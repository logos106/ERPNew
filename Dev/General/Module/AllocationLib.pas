unit AllocationLib;

interface

uses busobjPQA;

Function DoAutoAlloc(const PQA:TPQA;const PQADetails :TPQADetails; const PQAtype :String; const ReqQty, ReqUOMQty :Double;
                                const ParentValue:String=''; const ParentExpiryDaye :TDatetime=0 ;const ParentPQAType:String=''):Boolean;

implementation

uses DB, sysutils, AppEnvironment, MySQLConst;


Function DoAutoAlloc(const PQA:TPQA;const PQADetails :TPQADetails; const PQAtype :String; const ReqQty, ReqUOMQty :Double;
                                const ParentValue:String=''; const ParentExpiryDaye :TDatetime=0 ;const ParentPQAType:String=''):Boolean;
var
    s:STring;
    ds :TDataset;
    QtyToAllocate :Double;
    UOMQtyToAllocate :Double;
    Function getParetRefs:String;
    begin
        Result:= '';
        if ParentValue = '' then Exit;
        s := 'Select Globalref from tblPQADetails ' +
            ' where Value = ' + quotedStr(ParentValue) +
            ' and ifnull(ExpiryDate, ' + quotedStr(FormatDateTime(MysqlDateFormat , ParentExpiryDaye)) +') = ' + quotedStr(FormatDateTime(MysqlDateFormat , ParentExpiryDaye))+
            ' and PQAType = ' + quotedStr(ParentPQAType);
        with PQA.getnewdataset(s, true) do try
            s:= '';
            if recordcount = 0 then exit;
            first;
            s := '';
            while Eof = false do begin
                if s <> '' then s := s +',';
                s:= s+QuotedStr(fieldbyname('Globalref').asString);
                next;
            end;
        finally
            if active then close;
            free;
        end;
        Result := s;
    end;
begin
    Result          := true;
    if PQA.Product.SnTracking then result := False;
    QtyToAllocate   := ReqQty;
    UOMQtyToAllocate:= ReqUOMQty;
    try
        if PQADetails.count > 0 then begin
            PQADetails.dataset.first;
            while PQADetails.Dataset.eof = False do begin
                QtyToAllocate := QtyToAllocate - PQADetails.Qty;
                UOMQtyToAllocate := UOMQtyToAllocate - PQADetails.UOMQty;
                PQADetails.Dataset.Next;
            end;
        end;

        if QtyToAllocate <= 0 then Exit; // nothing to allocate

        s := getParetRefs;
        if s <> '' then s := ' and Details.ParentRef in (' + s +')';

        s:= ' SELECT Details.Value,Details.ExpiryDate,PQA.UOM,PQA.UOMMultiplier,'+
            ' Sum(if(ifnull(PQA.Alloctype,"")="OUT",0-Details.Qty,Details.Qty) ) as Qty,'+
            ' Sum(if(ifnull(PQA.Alloctype,"")="OUT",0-Details.UOMQty,Details.UOMQty) ) as UOMQty,'+
            ' Sum(if(ifnull(PQA.Alloctype,"")="OUT",0-Details.CUSTFLD1,Details.CUSTFLD1) ) as CUSTFLD1Qty'+
            ' FROM tblpqadetails AS Details Inner Join tblpqa AS PQA ON Details.PQAID = PQA.PQAID'+
            ' WHERE Details.PQAType =  ' + QuotedStr(PQAType) +
            ' AND PQA.Active <>  "F" AND PQA.IsBO <>  "T"' + s;

        s := s + ' AND PQA.ProductID = ' + IntToStr(PQA.ProductID);
        s := s + ' AND ifnull(PQA.DepartmentID,0) = ' + IntToStr(PQA.DepartmentID);
        s := s + ' AND (Date(ifnull(PQA.TransDate,0)) <= ' + QuotedStr(FormatDateTime(MysqlDateFormat , PQA.TransDate)) +
                ' OR ifnull(PQA.Alloctype,"")="OUT")';
        if AppEnv.CompanyPrefs.MatchUOMinallocation then
            s := s + ' AND PQA.UOMID = ' + IntToStr(PQA.UnitOfMeasureID);

        s := s + ' group by Details.Value,Details.ExpiryDate,PQA.UOM,PQA.UOMMultiplier ';
        ds := PQA.GetNewDataset(s , true);
        try
            if ds.recordcount = 0 then begin
                exit;
            end;
            ds.first;
            while (ds.Eof = False) and (QtyToAllocate <> 0)   do begin
                if (ds.fieldByname('Qty').asfloat>0) then begin
                    PQADetails.New;
                    PQADetails.PQAValue :=ds.FieldByname('Value').asString;
                    if ds.fieldbyname('Expirydate').asdatetime <> 0 then
                        PQADetails.ExpiryDate :=ds.FieldByname('ExpiryDate').asDatetime;
                    if ds.fieldByname('Qty').asfloat <= QtyToAllocate then
                        PQADetails.Qty := ds.FieldByname('Qty').asFloat
                    else PQADetails.Qty :=QtyToAllocate;
                    PQADetails.CUSTFLD1 := ds.FieldByname('CUSTFLD1Qty').asFloat;
                    PQADetails.Dirty := true;
                    PQADetails.PostDB;
                    if PQAtype = TPQABatch.PQADetailtype then
                        if PQA.Product.multipleBins then
                            if PQA.Product.Autoallocbin then
                                DoAutoAlloc(pqa, TPQABatch(PQADetails).PQABins,TPQABatch(PQADetails).PQABins.PQADetailtype ,  TPQABatch(PQADetails).Qty,  TPQABatch(PQADetails).UOMQty  , TPQABatch(PQADetails).batchno, TPQABatch(PQADetails).ExpiryDate , TPQABatch(PQADetails).PQADetailtype);
                    QtyToAllocate := QtyToAllocate -PQADetails.Qty;
                end;
                ds.Next;
            end;
        finally
            if ds.Active then ds.close;
            Freeandnil(ds);
        end;
    Finally
        result := QtyToAllocate <=0;
    end;
end;

end.
