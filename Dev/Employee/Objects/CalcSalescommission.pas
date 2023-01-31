
unit CalcSalescommission;

interface

uses MyAccess,ERPdbComponents,Classes, BusobjSalesCommission, BusObjBase ;

type
  TCalcSalescommissionObj = class(TComponent)
  Private
    fiSaleID: Integer;
    fSalescommission: Tsalescommission;
    fiSalescommissionCalcId: Integer;
    fConnection: TMyDacDataConnection;
    fbIgnoredateRange: Boolean;
    fdDateFrom: TDateTime;
    fdDateTo: TDatetime;
    Procedure deleteSalescommission(Const Sender: TBusObj; var Abort: boolean);
    Procedure createSalescommission;
  Public
    constructor Create(AOwner: TComponent); override;
    Property SaleId:Integer read fiSaleID write fiSaleID;
    Property Salescommission :Tsalescommission read fSalescommission write fSalescommission;
    Property SalescommissionCalcId :Integer read fiSalescommissionCalcId write fiSalescommissionCalcId;
    Property Connection :TMyDacDataConnection read fConnection write fConnection;
    Property IgnoredateRange :Boolean read fbIgnoredateRange write fbIgnoredateRange;
    Property DateFrom:TDateTime read fdDateFrom Write fdDateFrom;
    Property DateTo :TDatetime read fdDateTo write fdDateTo;
    Procedure DoCalc(const Logds:TERPQuery);
    Procedure DeleteAll(DeletePaidAlso:boolean);
  End;
implementation

uses Variants, CommonDbLib, CommonLib, sysutils,
  forms, MySQLConst, ProductQtyLib  , ProgressDialog, Dialogs;

{ TCalcSalescommissionObj }

constructor TCalcSalescommissionObj.Create(AOwner: TComponent);
begin
  inherited;
  fiSaleID:= 0;
  fSalescommission := nil;
  fiSalescommissionCalcId:= 0;
  fConnection := nil;
  fbIgnoredateRange:= False;
  fdDateTo := 0;
  fddatefrom :=0;
end;

procedure TCalcSalescommissionObj.createSalescommission;
begin
  if fSalescommission = nil then begin
      fSalescommission := Tsalescommission.create(self);
      if fConnection <> nil then fSalescommission.Connection := fConnection
      else begin
        fSalescommission.Connection:= TMyDacDataConnection.create(fSalescommission);
        fSalescommission.Connection.connection := CommonDbLib.GetNewMyDacConnection(fSalescommission);
      end;
  end else  if fConnection <> nil then fSalescommission.Connection := fConnection;
  fSalescommission.Connection.BeginTransaction;
end;

procedure TCalcSalescommissionObj.DeleteAll(DeletePaidAlso:boolean);
var
  strSQL:String;
begin
  strSQL := '';
  if not DeletePaidAlso then begin
    With CommonDbLib.TempMyQuery Do try
      SQL.add('Select saleId ' +
                ' from tblpayscommissionlines PCL  ' +
                ' inner join  tblsalescommission SC on SC.Salescommissionid = PCL.SalescommissionID');
      open;
      strSQL := GroupConcat('SaleId');
    finally
        if active then close;
        free;
    end;
  end;
  Connection.BeginTransaction;
  try
    if fSalescommission = nil then createSalescommission;
    if strSQL <> '' then fSalescommission.Loadselect(' not (SaleID in (' + strSQL+')) and Deleted = "F"' )
    else fSalescommission.Loadselect(' Deleted = "F"' );

    DoShowProgressbar(fSalescommission.count , 'Please Wait');
    try
      fSalescommission.Iteraterecords(deleteSalescommission);
    finally
        DoHideProgressbar;
    end;

    Connection.CommitTransaction;
  Except
    on E:Exception do begin
        Connection.RollbackTransaction;
    end;
  end;

end;

procedure TCalcSalescommissionObj.deleteSalescommission(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not(sender is Tsalescommission)  then exit;
  if Tsalescommission(Sender).AmountPaID = 0 then
    Tsalescommission(Sender).Deleted := true
  else Tsalescommission(Sender).CommissionAmount := 0;
  Tsalescommission(Sender).PostDB;
  DoStepProgressbar;
end;

Procedure TCalcSalescommissionObj.DoCalc(const Logds:TERPQuery) ;
var
  s:TStringList;
  ds : TERPQuery;
  cusDs : TCustomMyDataSet;

  (*FieldValuesinformula,*) (*FieldValues4Spreadsheet:String;*)

  function HasCommission:Boolean;
  begin
      result := False;
      if ds.recordcount = 0                             then exit;
      if ds.fieldbyname('CommissionRate').asFloat = 0   then exit;
      if ds.Fieldbyname('SalesAmount').asFloat = 0  then exit;
      (*if Sysutils.SameText(ds.Fieldbyname('customername').asString , CLIENT_CASH) then exit;*)
      result := true;
    end;
(*    Procedure AddFieldValuesinformula(const value:String);
    begin
        if FieldValuesinformula <> '' then FieldValuesinformula := FieldValuesinformula + chr(13);
        FieldValuesinformula := FieldValuesinformula + Value;
    end;*)

    Procedure LogDetails(const formula,Valueformula:String);
    begin
      if Logds = nil then exit;
      Logds.Append;
      (*Logds.fieldbyname('SaleID').asInteger       := ds.Fieldbyname('SaleId').asInteger;
      Logds.fieldbyname('SaleLineId').asInteger   := ds.fieldbyname('SaleLineId').asInteger;
      Logds.fieldbyname('EmployeeId').asInteger   := ds.fieldbyname('EmployeeId').asInteger;
      Logds.fieldbyname('EmployeeName').asString  := fSalescommission.EmployeeName ;
      Logds.fieldbyname('Productname').asString   := fSalescommission.ProductName;
      Logds.fieldbyname('commissionOn').ASsTRING   := ds.FieldByname('commissionon').ASsTRING;*)
      Logds.fieldbyname('SaleID').asInteger       := ds.Fieldbyname('SaleId').asInteger;
      Logds.fieldbyname('SalesCommissionId').asInteger       := fSalescommission.ID;
      Logds.fieldbyname('Amount').asfloat         := ds.FieldByname('SalesAmount').asfloat;
      (*Logds.fieldbyname('Rate').asfloat           := ds.FieldByname('CommissionRate').asfloat;*)
      Logds.fieldbyname('Cost').asfloat           := ds.fieldByname('cost').asfloat;
      (*Logds.fieldbyname('OHbase').asfloat         := ds.fieldbyname('Overheadbaserate').asfloat;*)
      Logds.fieldbyname('Landedcost').asfloat     := ds.fieldbyname('Landedcost').asfloat;
      Logds.FieldByName('LatestCost').asFloat     := ds.FieldByName('LatestCost').AsFloat;
      (*Logds.fieldbyname('Commission').asfloat     := fSalescommission.CommissionAmount;*)
      Logds.fieldbyname('Formula').asString       := formula +chr(13) +chr(13) +Valueformula;
      Logds.fieldbyname('Valueformula').asString  := Valueformula+chr(13) +chr(13) +Formula;
      Logds.Post;
      (*  if FieldValues4Spreadsheet ='' then
        FieldValues4Spreadsheet := 'Name' + #9 +
          'commission On' + #9 +
          'Amount' + #9 +
          'Rate' + #9 +
          'Cost' + #9 +
          'OH base' + #9 +
          'Landed cost';
        FieldValues4Spreadsheet := FieldValues4Spreadsheet + chr(13) ;
        if ds.fieldbyname('SaleLineId').asInteger = 0 then
          FieldValues4Spreadsheet:= FieldValues4Spreadsheet + fSalescommission.EmployeeName else
            FieldValues4Spreadsheet := FieldValues4Spreadsheet + fSalescommission.ProductName;
        FieldValues4Spreadsheet := FieldValues4Spreadsheet         + #9+
          ds.FieldByname('commissionon').asString  + #9 +
          ds.FieldByname('SalesAmount').asString +#9 +
          ds.FieldByname('CommissionRate').asString +#9 +
          ds.fieldByname('cost').asString+ #9 +
          ds.fieldbyname('Overheadbaserate').asString +#9+
          ds.fieldbyname('Landedcost').asString+ #9 + value;*)
    end;
begin
  (*FieldValuesinformula := '';*)
  (*FieldValues4Spreadsheet:= '';*)
  if fSalescommission = nil then createSalescommission;

  {delete commissions of deleted sales}
//@@@  With fSalescommission.getnewDataset('Select SaleId from tblSales where Deleted ="T"' , true) do try
    cusDs := fSalescommission.getnewDataset('Select SaleId from tblSales where Deleted ="T"' , true);
    with cusDs do try
    if recordcount > 0 then begin
      DoShowProgressbar(recordcount, 'Sales Commission Update' , 'Please Wait');
      try
        First;
        while Eof = False do begin
          fSalescommission.Loadselect('SaleID=' + IntToStr(fieldbyname('saleID').asInteger)+' and Deleted ="F"');
          if fSalescommission.count>0 then begin
            DoShowProgressbar(fSalescommission.count , 'Please Wait');
            try
              fSalescommission.Iteraterecords(deleteSalescommission);
            finally
                DoHideProgressbar;
            end;
          end;
          Next;
          DoStepProgressbar;
        end;
      Finally
          DoHideProgressbar;
      end;
    end;
  finally
      if active then close;
      Free;
  end;


  s:=TStringList.create;
  try
      s.add('SELECT S.customername , S.Saledate , S.employeeId, 0 as ProductId, "E" as Commissiontype , S.SaleID, 0 as SaleLineId,');
      s.add('"T" as IsCommissionPercent,');
      s.add('if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.IsCommissiononpaidInvoice , E.CommissionOnPaid)          as CommissionOnPaid ,');
      s.add('if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionInvoiceExPrice  , E.CommissionInvoiceExPrice)  as CommissionInvoiceExPrice  ,');
      s.add('if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionOn              , E.CommissionOn)              as CommissionOn ,');
      s.add('if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.Overheadbaserate          , E.Overheadbaserate)          as Overheadbaserate,');
      (*s.add('if(ifnull(E.CommissionUseEmp,"F") = "F" , 0 , if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionRate ,E.CommissionFlatRate  ) ) as CommissionRate,');*)
      s.add('if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionRate , if(ifnull(E.CommissionUseEmp,"F") = "F" , 0 , if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionRate ,E.CommissionFlatRate  ) )) as CommissionRate, ');
      s.add('Sum(if( if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionInvoiceExPrice , E.CommissionInvoiceExPrice)="T" , SL.TotalLineAmount,SL.TotalLineAmountInc)) as SalesAmount,');
      s.add('Sum(if(ifnull(P.Landedcost,0) =0 , P.cost1 , P.LandedCost)* SL.shipped) as LandedCost,');
      s.Add('Sum(P.LatestCost * SL.Shipped) as LatestCost,');
      s.add('Sum(if( if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionInvoiceExPrice , E.CommissionInvoiceExPrice) ="T" ,         ');
      s.add('          (if(ifnull(SL.LineCost,0)<> 0 , SL.LineCost ,if(ifnull(P.AvgCost,0)<> 0 , P.AvgCost , if(ifnull(P.Landedcost,0) <>0 ,  P.LandedCost, P.cost1 ) )) * SL.shipped) ,          ');
      s.add('          (if(ifnull(SL.LineCost,0)<> 0 , SL.LineCostInc ,if(ifnull(P.AvgCost,0)<> 0 , P.AvgCost , if(ifnull(P.Landedcost,0) <>0 ,  P.LandedCost, P.costinc1 ) )) * SL.shipped))) cost');
      s.add('FROM  tblsales AS S');
      s.add('Inner Join tblemployees AS E ON  E.EmployeeId = s.EmployeeID');
      s.add('Left Join tblsalescommission AS SC ON S.EmployeeID = SC.EmployeeId AND S.SaleID = SC.SaleId AND ifnull(SC.SaleLineId,0) = 0 and SC.Deleted = "F"');
      s.add('Left  Join tblsaleslines AS SL ON S.SaleID = SL.SaleID and SL.ProductId not in (Select  ProductId from tblempnocommsproducts EC where ifnull(EC.Active,"T") = "T" and EC.EmployeeId = S.EmployeeId)');
      s.add('Left join tblParts P on P.PartsId = SL.ProductId');
      s.add('where /*SL.ProductId not in (Select  ProductId from tblempnocommsproducts EC where ifnull(EC.Active,"T") = "T" and EC.EmployeeId = S.EmployeeId)');
      s.add('and */(if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.IsCommissiononpaidInvoice , E.CommissionOnPaid) ="F" or ifnull(S.balance,0) =0) ');
      if IgnoredateRange then
      else begin
        s.add('and S.SaleDate between ' + QuotedStr(formatDateTime(MysqlDateFormat , DateFrom)))         ;
        s.add(QuotedStr(formatDateTime(MysqlDateFormat , DateTo)) );
      end;
      S.ADD(' and ((' + ISInvoice  + ') or (' + ISRefund   + ') or (' + IsLayby    + ') or (' + ISCashSale + ') )');
      if fiSaleId <> 0 then s.add('and S.SaleId = '+IntToStr(fiSaleId));
      S.ADD(' and (ifnull(E.CommissionUseEmp , "F") = "T" or ifnull(SC.SalesCommissionId,0)<>0) ');
      s.add('group by S.SaleID');

      s.add('union');

      s.add('SELECT S.customername , S.Saledate , S.employeeId,SL.ProductId ,  "P" as Commissiontype, SL.SaleID, SL.SaleLineID, ');
      s.add('if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.IsCommissionPercent , if(ifnull(PC.ProductCommissionId,0) =0 , PCA.IsPercentage, PC.IsPercentage) )          as IsCommissionPercent,');
      s.add('if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.IsCommissiononpaidInvoice , if(ifnull(PC.ProductCommissionId,0) =0 , PCA.CommissionOnPaid , PC.CommissionOnPaid) )          as CommissionOnPaid ,');
      s.add('if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionInvoiceExPrice  , if(ifnull(PC.ProductCommissionId,0) =0 , PCA.CommissionInvoiceExPrice , PC.CommissionInvoiceExPrice))  as CommissionInvoiceExPrice  ,');
      s.add('if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionOn              , if(ifnull(PC.ProductCommissionId,0) =0 , PCA.CommissionOn , PC.CommissionOn))              as CommissionOn ,');
      s.add('if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.Overheadbaserate          , if(ifnull(PC.ProductCommissionId,0) =0 , PCA.Overheadbaserate , PC.Overheadbaserate))          as Overheadbaserate,');
      s.add('if(if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.IsCommissionPercent , if(ifnull(PC.ProductCommissionId,0) =0 , PCA.IsPercentage, PC.IsPercentage) ) ="T" ,');
      s.add('                 if(ifnull(E.CommissionUseProd,"F") = "F" , 0 , if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionRate ,if(ifnull(PC.ProductCommissionId,0) =0 , PCA.CommissionRate , PC.CommissionRate) ) ),');
      s.add('                 if(ifnull(E.CommissionUseProd,"F") = "F" , 0 , if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionRate ,if(ifnull(PC.ProductCommissionId,0) =0 , PCA.CommissionRate , PC.CommissionRate)* SL.shipped ) ) )  as CommissionRate,');
      s.add('(if( if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionInvoiceExPrice , if(ifnull(PC.ProductCommissionId,0) =0 , PCA.CommissionInvoiceExPrice , PC.CommissionInvoiceExPrice))="T" , SL.TotalLineAmount,SL.TotalLineAmountInc)) as SalesAmount,');
      s.add('(if(ifnull(P.Landedcost,0) =0 , P.cost1 , P.LandedCost)* SL.shipped) as LandedCost,');
      s.Add('Sum(P.LatestCost * SL.Shipped) as LatestCost,');
      s.add('(if( if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.CommissionInvoiceExPrice , if(ifnull(PC.ProductCommissionId,0) =0 , PCA.CommissionInvoiceExPrice , PC.CommissionInvoiceExPrice)) ="T" ,         ');
      s.add('          (if(ifnull(SL.LineCost,0)<> 0 , SL.LineCost ,if(ifnull(P.AvgCost,0)<> 0 , P.AvgCost , if(ifnull(P.Landedcost,0) <>0 ,  P.LandedCost, P.cost1 ) )) * SL.shipped) ,          ');
      s.add('          (if(ifnull(SL.LineCost,0)<> 0 , SL.LineCostInc ,if(ifnull(P.AvgCost,0)<> 0 , P.AvgCost , if(ifnull(P.Landedcost,0) <>0 ,  P.LandedCost, P.costinc1 ) )) * SL.shipped))) as cost');
      s.add('FROM  tblsales 									AS S');
      s.add('Inner Join tblsaleslines 				AS SL  ON S.SaleID = SL.SaleID');
      s.add('Inner join tblemployees 				AS E   ON E.EmployeeId = S.employeeID');
      s.add('Left Join tblsalescommission 		AS SC  ON S.EmployeeID = SC.EmployeeId AND SL.SaleID = SC.SaleId AND ifnull(SC.SaleLineId,0) = Sl.SaleLineId and SC.Deleted = "F"');
      s.add('Left join tblproductcommission AS PC   ON PC.PartsID = SL.ProductID and (ifnull(PC.employeeID,0) = S.EmployeeID) and PC.active = "T"');
      s.add('Left join tblproductcommission AS PCA  ON PCA.PArtsID = SL.ProductID and (ifnull(PCA.employeeID,0) = 0) and PCA.active = "T"');
      s.add('inner join tblParts 						AS P 	 ON P.PartsId = SL.ProductId');
      s.add('where (if(ifnull(SC.SalesCommissionId,0)<>0 ,SC.IsCommissiononpaidInvoice , if(ifnull(PC.ProductCommissionId,0) =0 , PCA.CommissionOnPaid , PC.CommissionOnPaid)) ="F" or ifnull(S.balance,0) =0)');
      s.add('and (ifnull(PC.ProductCommissionId,0)<> 0 or ifnull(PCA.ProductCommissionId,0)<> 0)');
      if IgnoredateRange then
      else begin
        s.add('and S.SaleDate between ' + QuotedStr(formatDateTime(MysqlDateFormat , DateFrom))) ;
        s.add(QuotedStr(formatDateTime(MysqlDateFormat , DateTo))) ;
      end;
      S.ADD(' and ((' + ISInvoice  + ') or (' + ISRefund   + ') or (' + IsLayby    + ') or (' + ISCashSale + ') )');
      if fiSaleId <> 0 then s.add('and S.SaleId = '+IntToStr(fiSaleId));
      S.ADD(' and (ifnull(E.CommissionUseProd , "F") = "T" or ifnull(SC.SalesCommissionId,0)<>0)');
      s.add('Order by SaleID, SaleLineId');

//      s.SaveToFile('c:\dev\Commission.txt');

      ds:= TERPQuery(fSalescommission.getnewDataset(s.text, true));
      try
        if ds.RecordCount = 0 then begin
          if fiSaleId <> 0 then TForm(GetComponentByClassName('TfmSalesCommissionMsg' , True , nil , False )).showModal;
          Exit;
        end;
        DoShowProgressbar(ds.recordcount, 'Sales Commission Update', 'Please Wait');
        try
          ds.first;
          While ds.Eof = False do begin
            if not HasCommission then begin
              fSalescommission.Loadselect('SaleID=' + IntToStr(ds.fieldbyname('sAleID').asInteger)+' and ProductId = ' + IntToStr(ds.fieldbyname('ProductID').asInteger)+' and Deleted ="F"');
              if fSalescommission.count > 0 then begin
                DoShowProgressbar(fSalescommission.count , 'Please Wait');
                try
                  fSalescommission.Iteraterecords(deleteSalescommission);
                finally
                    DoHideProgressbar;
                end;
              end;
            end else begin
              fSalescommission.Loadselect('SaleID=' + IntToStr(ds.fieldbyname('sAleID').asInteger)+' and employeeId <> ' +IntToStr(ds.FieldByname('EmployeeId').asInteger)+' and ifnull(Deleted,"F") ="F" ');
              if fSalescommission.count > 0 then begin
                DoShowProgressbar(fSalescommission.count , 'Please Wait');
                try
                  fSalescommission.Iteraterecords(deleteSalescommission);
                finally
                    DoHideProgressbar;
                end;
              end;

              fSalescommission.Loadselect('SaleID=' + IntToStr(ds.fieldbyname('sAleID').asInteger)+' and employeeId = ' +IntToStr(ds.FieldByname('EmployeeId').asInteger));
              DoStepProgressbar;
              fSalescommission.Connection.BeginNestedTransaction;
              TRY
                if not (fSalescommission.Locate('SaleID;saleLineID' ,
                                                vararrayof([ds.Fieldbyname('SaleID').asInteger ,ds.Fieldbyname('SaleLineID').asInteger  ]) , [])) then begin
                  fSalescommission.New;
                  fSalescommission.SalescommissionCalcId    :=fiSalescommissionCalcId;
                  fSalescommission.saleId                   :=ds.Fieldbyname('SaleID').asInteger ;
                  fSalescommission.saleLineId               :=ds.Fieldbyname('SaleLineID').asInteger ;
                  fSalescommission.employeeId               :=ds.Fieldbyname('employeeId').asInteger ;
                  fSalescommission.Saledate                 :=ds.Fieldbyname('Saledate').asDateTime;
                  fSalescommission.ProductID                :=ds.fieldbyname('ProductID').asInteger;
                  fSalescommission.IsCommissiononpaidInvoice:=ds.fieldbyname('CommissionOnPaid').AsBoolean;
                  fSalescommission.Commissioninvoiceexprice :=ds.fieldbyname('Commissioninvoiceexprice').asBoolean;
                  fSalescommission.CommissionOn             :=ds.fieldbyname('CommissionOn').asString;
                  fSalescommission.Overheadbaserate         :=ds.fieldbyname('Overheadbaserate').asFloat;
                  fSalescommission.CommissionRate           :=ds.Fieldbyname('CommissionRate').asfloat;
                  fSalescommission.IsCommissionPercent      :=ds.fieldbyname('IsCommissionPercent').asBoolean;
                end else begin
                  if fSalescommission.deleted then begin
                    fSalescommission.employeeId               :=ds.Fieldbyname('employeeId').asInteger ;
                    fSalescommission.Saledate                 :=ds.Fieldbyname('Saledate').asDateTime;
                    fSalescommission.ProductID                :=ds.fieldbyname('ProductID').asInteger;
                    fSalescommission.IsCommissiononpaidInvoice:=ds.fieldbyname('CommissionOnPaid').AsBoolean;
                    fSalescommission.Commissioninvoiceexprice :=ds.fieldbyname('Commissioninvoiceexprice').asBoolean;
                    fSalescommission.CommissionOn             :=ds.fieldbyname('CommissionOn').asString;
                    fSalescommission.Overheadbaserate         :=ds.fieldbyname('Overheadbaserate').asFloat;
                    fSalescommission.CommissionRate           :=ds.Fieldbyname('CommissionRate').asfloat;
                    fSalescommission.IsCommissionPercent      :=ds.fieldbyname('IsCommissionPercent').asBoolean;
                  end;
                end;
                fSalescommission.deleted := False;
                fSalescommission.PostDB;
                (*if fSalescommission.saleLineId = 0 then Addresult('Employee commission:' + fSalescommission.EmployeeName+chr(13) +'===========================================');
                Addresult(fSalescommission.DoCalc(ds.FieldByname('SalesAmount').asFloat, ds.FieldByname('CommissionRate').asFloat , ds.fieldByname('cost').asFloat , ds.fieldbyname('Overheadbaserate').asFloat/100, ds.fieldbyname('LandedCost').asfloat));
                if fSalescommission.saleLineId = 0 then Addresult('Product Commission'+chr(13) +'===========================================');*)
                (*AddFieldValuesinformula(fSalescommission.DoCalc(ds.FieldByname('SalesAmount').asFloat, ds.FieldByname('CommissionRate').asFloat , ds.fieldByname('cost').asFloat , ds.fieldbyname('Overheadbaserate').asFloat/100, ds.fieldbyname('LandedCost').asfloat));*)
                (*AddFieldValues4Spreadsheet;*)
                fSalescommission.DoCalc(ds.FieldByname('SalesAmount').asFloat, ds.FieldByname('CommissionRate').asFloat ,
                    ds.fieldByname('cost').asFloat , ds.fieldbyname('Overheadbaserate').asFloat/100,
                    ds.fieldbyname('LandedCost').asfloat, ds.FieldByName('LatestCost').AsFloat);
                LogDetails(fSalescommission.Formula,fSalescommission.Valueformula(ds.FieldByname('SalesAmount').asFloat,
                                                                                  ds.FieldByname('CommissionRate').asFloat ,
                                                                                  ds.fieldByname('cost').asFloat ,
                                                                                  ds.fieldbyname('Overheadbaserate').asFloat,
                                                                                  ds.fieldbyname('LandedCost').asfloat,
                                                                                  ds.FieldByName('LatestCost').asFloat));
                fSalescommission.Connection.CommitNestedTransaction;
              EXCEPT
                on E:Exception do begin
                    fSalescommission.Connection.RollbackNestedTransaction;
                end;
              END;
            end;
            ds.next;
          end;
        finally
            DoHideProgressbar;
        end;
        if fConnection = nil then fSalescommission.Connection.CommitTransaction;
      finally
          if ds.Active then ds.Close;
          Freeandnil(ds);
      end;
  finally
    FreeandNil(s);
  end;
end;


end.
