unit SerialNoTabletAllocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TSerialNoTabletAllocationGUI = class(TBaseListingGUI)
    qryMainsaleId: TLargeintField;
    qryMainSaleLineId: TLargeintField;
    qryMaincustomername: TWideStringField;
    qryMainProductname: TWideStringField;
    qryMainsaleDate: TWideStringField;
    qryMainPQAID: TLargeintField;
    qryMainSerialno: TWideStringField;
    qryMainrownum: TLargeintField;
    btnFix: TDNMSpeedButton;
    qryMainUOMMultiplier: TFloatField;
    qryMainshipped: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnFixClick(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, DbSharedObjectsObj, LogLib, CommonLib, tcConst, MySQLConst,
  SharedObjs, PQALib;

{$R *.dfm}

{ TSerialNoTabletAllocationGUI }


procedure TSerialNoTabletAllocationGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SearchMode:= smFullList;
  NonSearchReport := True;
  DisableSortoncolumtitleclick:= TRue;
  HaveDateRangeSelection := False;

  if devmode then
    showcontrolhint(self, 'This is the list of serial numebrs from tblsaleslines.SoldSerials,'+NL+
                        'validating against the PQADetails.Serial numbers. '+NL+
                        'SteelMains Tablet import had issues that the PQADetials was not updated but was in tblsaleslines.soldserials');

  //EnableMultiSelect('Select Records to Fix the Serial Number');
end;

procedure TSerialNoTabletAllocationGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymainrownum.asInteger >1 then
    if sametext(Field.fieldname,     qryMainsaleId.fieldname) or
       sametext(Field.fieldname,     qryMaincustomername.fieldname) or
       sametext(Field.fieldname,     qryMainProductname.fieldname) or
       sametext(Field.fieldname,     qryMainsaleDate.fieldname) then
        DoHide(Field,State,Afont, ABrush);
end;

procedure TSerialNoTabletAllocationGUI.RefreshQuery;
var
   qry: TERPQuery;
const
  SQLSerial = 'select ' +
              ' s.saleId, sl.saleLineId, s.customername,sl.productname, s.saleDate, SL.shipped,pqa.pqaid, sl.SoldSerials, pqa.UOMMultiplier,' +
              ' CHAR_LENGTH(sl.SoldSerials) - CHAR_LENGTH(replace(sl.SoldSerials , ",",""))  as slcount ' +
              ' from tblsales S inner join tblsaleslines sl  on s.saleId = sl.saleid ' +
              ' inner join tblparts p on sl.ProductID = p.partsId  and p.SNTracking ="T" and p.batch="F" and p.MultipleBins="F" ' +
              ' inner join tblpqa pqa on sl.saleLineId = pqa.translineId and pqa.transtype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine" ) ' +
              ' left join tblpqadetails pqad on pqad.PQAID = pqa.pqaid ' +
              ' where ifnull(pqad.PQADetailID,0)=0 and ifnull(sl.SoldSerials , "")<> ""';
  Procedure SoldSerialsToQrymainSQL;
  var
    s:String;
    ssql:String;
  begin
     if trim(Qry.FieldByName('SoldSerials').AsString) ='' then exit;
     s :=trim(Qry.FieldByName('SoldSerials').AsString);
     While s<> '' do begin
        ssql:= '';
        ssql:= 'Select';
        ssql := ssql+ NL + inttostr(Qry.FieldByName('saleId').AsInteger)+' as saleId,';
        ssql := ssql+ NL + inttostr(Qry.FieldByName('SaleLineId').AsInteger)+' as SaleLineId,';
        ssql := ssql+ NL + Quotedstr(Qry.FieldByName('customername').asString)+' as customername,';
        ssql := ssql+ NL + Quotedstr(Qry.FieldByName('Productname').asString)+' as Productname,';
        ssql := ssql+ NL + Quotedstr(Formatdatetime(MYSQLDateTimeformat, Qry.FieldByName('saleDate').asDateTime))+' as saleDate,';
        ssql := ssql+ NL + FloatToStrF(Qry.FieldByName('UOMMultiplier').asfloat, ffGeneral, 15, tcConst.GeneralRoundPlaces)+' as UOMMultiplier,';
        ssql := ssql+ NL + Quotedstr(Qry.FieldByName('shipped').asString)+' as shipped,';
        if pos(',' ,s)>0 then begin
          ssql := ssql+ NL + inttostr(Qry.FieldByName('PQAId').AsInteger)+' as PQAID, '  ;
          ssql := ssql+ NL + quotedstr(copy(s , 1, pos(',' ,s)-1)) +' as Serialno';
          s:= copy(s ,pos(',' ,s)+1, length(s));
        end else begin
          ssql := ssql+ NL + inttostr(Qry.FieldByName('PQAId').AsInteger)+' as PQAID, '  ;
          ssql := ssql+ NL + quotedstr(s) +' as Serialno';
          s:= '';
        end;

        if Qrymain.SQL.Count > 0 then Qrymain.SQL.Add('Union');
        Qrymain.SQL.Add(ssql);

     end;
  end;
begin
    closedb(Qrymain);
    Qrymain.SQL.Clear;
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
            closedb(Qry);
            Qry.SQL.text := SQLSerial;
            Qry.open;
            if Qry.recordcount >0 then begin
              Qry.First;
              While Qry.EOf = False do begin
                SoldSerialsToQrymainSQL;
                Qry.Next;
              end;
            end else begin
                Qrymain.SQL.add('Select');
                Qrymain.SQL.add('null    as saleId,');
                Qrymain.SQL.add('null    as SaleLineId,');
                Qrymain.SQL.add('""   as customername,');
                Qrymain.SQL.add('""   as Productname,');
                Qrymain.SQL.add('NULL as saleDate,');
                Qrymain.SQL.add('NULL as UOMMultiplier,');
                Qrymain.SQL.add('NULL as shipped,');

                Qrymain.SQL.add('null    as PQAId,');
                Qrymain.SQL.add('""   as Serialno ');
                Qrymain.SQL.add('from dual');
            end;
            Qrymain.SQL.Add('Order by saleId Desc , saleLineId');
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
    Qrymain.sql.text:= 'Select ' +NL+
        ' convert(@rownum:=if(@SaleLineId <> T.SaleLineId,  @rownum:= 1 ,  @rownum+1),unsigned)  as rownum , ' +NL+
        '  @SaleLineId := T.SaleLineId, ' +NL+
        '  convert(T.saleId,unsigned)  as saleId,  ' +NL+
        '  convert(T.SaleLineId,unsigned)  as SaleLineId,  ' +NL+
        '  T.customername,  ' +NL+
        '  T.Productname,  ' +NL+
        '  T.saleDate,  ' +NL+
        ' convert( T.UOMMultiplier ,  DECIMAL) as UOMMultiplier ,  '+ NL+
        ' convert( T.shipped ,  DECIMAL) as shipped, '+ NL+
        '  convert(T.PQAID,unsigned)  as PQAID,  ' +NL+
        '  T.Serialno  ' +NL+
        '  from (' +NL+
        Qrymain.sql.text +NL+') T ,  (SELECT @rownum:=0) r ,  (SELECT @SaleLineId:=0) s';

    clog(Qrymain.SQL.Text);

    RefreshOrignalSQL(False);
  inherited;
end;

procedure TSerialNoTabletAllocationGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainPQAID.fieldname);
  RemoveFieldfromGrid(qryMainSaleLineId.fieldname);
  RemoveFieldfromGrid(qryMainRownum.fieldname);
  RemoveFieldfromGrid(qryMainUOMMultiplier.fieldname);
  RemoveFieldfromGrid(qryMainshipped.fieldname);
end;
procedure TSerialNoTabletAllocationGUI.btnFixClick(Sender: TObject);
begin
  inherited;
  IterateProcno := 1;
  With ScriptMainInTrans do begin
    try
      SQL.clear;
      SQL.Add(ERPFixtableSQL('tblpqadetails'));
      Iteraterecords;
            showProgressbar(WAITMSG, SQL.count);
            try
              ScriptMainBeginTrans;
              try
                clog(SQL.Text);
                Execute;
                ScriptMainCommit;
                RefreshQuery;
              Except
                  on E:Exception do begin
                      ScriptMainrollback;
                  end;
              end;
            finally
              HideProgressbar;
              UserLock.UnlockAllCurrentInstance;
            end;
    finally
      ScrptMainCleanConn;
    end;
  end;
end;

procedure TSerialNoTabletAllocationGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if IterateProcno = 1 then begin
    if UserLock.Lock('tblsales' , QrymainsaleID.asInteger) then begin
      if Qrymainshipped.asfloat <> 0 then begin
          sctmain.sql.add('insert ignore into tblpqadetails  Set PQAID = ' + inttostr(Qrymainpqaid.asInteger) +','+
                                                               ' Qty =' + FloatTostr(QrymainUOMMultiplier.asFloat)+',' +
                                                               ' UOMQty = 1,'+
                                                               ' BOQty=0,'+
                                                               ' BOUOMQty=0,'+
                                                               ' PQAType="SN",'+
                                                               ' Value =' + Quotedstr(QrymainSerialno.asString)+';' );
      end else begin
          sctmain.sql.add('insert ignore into tblpqadetails  Set PQAID = ' + inttostr(Qrymainpqaid.asInteger) +','+
                                                               ' BOQty =' + FloatTostr(QrymainUOMMultiplier.asFloat)+',' +
                                                               ' BOUOMQty = 1,'+
                                                               ' Qty=0,'+
                                                               ' UOMQty=0,'+
                                                               ' PQAType="SN",'+
                                                               ' Value =' + Quotedstr(QrymainSerialno.asString)+';' );

      end;
      sctmain.sql.add('update tblsales S ' +
                      ' inner join tblsaleslines sl on s.saleId = sl.saleId ' +
                      ' inner join tblpqa pqa on sl.SaleLineID = pqa.translineId and pqa.transtype in ('+SalesTransTypes +')' +
                      ' set s.mstimestamp =now(), ' +
                      ' sl.mstimestamp =now(), ' +
                      ' pqa.mstimestamp =now()'+
                      ' where PQAID = ' + inttostr(Qrymainpqaid.asInteger) +';')
    end;
  end;
end;

Initialization
  RegisterClassOnce(TSerialNoTabletAllocationGUI);

end.
