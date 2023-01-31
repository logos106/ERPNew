unit OverdueInvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , busobjsales;

type
  TOverdueInvoicesGUI = class(TBaseListingGUI)
    qryMainsALeId: TIntegerField;
    qryMaincustomerName: TWideStringField;
    qryMaintotalamountinc: TFloatField;
    qryMainPayment: TFloatField;
    qryMainbalance: TFloatField;
    qryMainForeignExchangeCode: TWideStringField;
    qryMainForeignTotalAmount: TFloatField;
    qryMainForeignBalanceAmount: TFloatField;
    qryMainDueDate: TDateField;
    qryMainShipDate: TDateField;
    qryMainSaleDate: TDateField;
    qryMainwithinTerms: TFloatField;
    qryMainSurchargePaid: TFloatField;
    qryMain1to30days: TFloatField;
    qryMain30to60days: TFloatField;
    qryMain60to90days: TFloatField;
    qryMainOver90days: TFloatField;
    qryMainSurchageDescription: TWideStringField;
    qryMainSurchageDueDescription: TWideStringField;
    QrymainSurchageDueAmount: TFloatField;
    brnSelectall: TDNMSpeedButton;
    btnApplySurcharge: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure brnSelectallClick(Sender: TObject);
    procedure btnApplySurchargeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    finv:TInvoice;
    UpdatedIds :TStringlist;
    TblUpdateSurchargestatus:String;
    procedure ApplyOverdueSurcharge(var abort: Boolean);
    function InvObj:TInvoice;
    procedure ShowSurchargeUpdateResult;
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, MySQLConst,dateutils, AppEnvironment, tcConst, frmMessageWithList, frmMessageBase,
  CommonDbLib, SystemLib, TemplateReportsLib;

{$R *.dfm}
{ TOverdueInvoicesGUI }

procedure TOverdueInvoicesGUI.brnSelectallClick(Sender: TObject);
begin
  inherited;
  Grdmain.unselectAll;
  IterateProcno := 1;
  Iteraterecords;
end;

procedure TOverdueInvoicesGUI.btnApplySurchargeClick(Sender: TObject);
begin
  inherited;
  if grdmain.SelectedList.Count = 0 then
    if MessageDlg('You haven''t Selected the Sales to apply the surcharges. Do you want to Select all?', mtconfirmation , [mbyes,mbNo], 0) = mrno then exit
    else begin
        grdMain.selectAll;
        DoAfterallSelected;
    end;


  UpdatedIds := TStringList.Create;
  try
    InvObj.Connection.BeginTransaction;
    try
      try
        IterateProcno:= 2;
        IterateSelectedRecords;
        ShowSurchargeUpdateResult;

        grdmain.UnselectAll;
        fInv.Connection.CommitTransaction;
        if UpdatedIds.Count <> 0 then RefreshQuery;
      Except
        on E:EXception do begin
          MessageDlgXP_Vista('Update Failed.'+NL+NL+
                              E.Message, mtWarning, [mbOK], 0);
          fInv.Connection.RollbackTransaction;
          Exit;
        end;
      end;
    finally
      FreeandNil(finv);
    end;
  finally
    Freeandnil(UpdatedIds);
  end;
end;

procedure TOverdueInvoicesGUI.FormCreate(Sender: TObject);
begin
  TblUpdateSurchargestatus :=CommonDbLib.GetUserTemporaryTableName('Inv_Updatesurcharge' );
  finv:= nil;
  Qrymain.SQL.clear;
  Qrymain.SQL.Add('Select');
  Qrymain.SQL.Add('s.sALeId as sALeId,');
  Qrymain.SQL.Add('S.customerName as customerName ,');
  Qrymain.SQL.Add('S.totalamountinc  as totalamountinc,');
  Qrymain.SQL.Add('S.Payment as Payment,');
  Qrymain.SQL.Add('s.balance as balance,');
  Qrymain.SQL.Add('s.ForeignExchangeCode as ForeignExchangeCode,');
  Qrymain.SQL.Add('s.ForeignTotalAmount as ForeignTotalAmount,');
  Qrymain.SQL.Add('s.ForeignBalanceAmount as ForeignBalanceAmount,');
  Qrymain.SQL.Add('s.DueDate as DueDate,');
  Qrymain.SQL.Add('s.ShipDate as ShipDate,');
  Qrymain.SQL.Add('s.SaleDate as SaleDate,');
  Qrymain.SQL.Add('if( ifnull(S.duedate,0)=0 or  S.duedate >=      "'+ FormatDateTime(MysqlDateFormat,Date)+ '",S.Balance,0.00) as withinTerms, ');
  Qrymain.SQL.Add('if(S.duedate between "'+ FormatDateTime(MysqlDateFormat,(IncMonth(Date,-1)))+ '" and "'+FormatDateTime(MysqlDateFormat,(Date))+'",S.Balance,0.00) as 1to30days, ');
  Qrymain.SQL.Add('if(S.duedate between "'+ FormatDateTime(MysqlDateFormat,(IncMonth(Date,-2)))+ '" and "'+FormatDateTime(MysqlDateFormat,(IncMonth(Date,-1)))+'",S.Balance,0.00) as 30to60days, ');
  Qrymain.SQL.Add('if(S.duedate between "'+ FormatDateTime(MysqlDateFormat,(IncMonth(Date,-3)))+ '" and "'+FormatDateTime(MysqlDateFormat,(IncMonth(Date,-2)))+'",S.Balance,0.00) as 60to90days, ');
  Qrymain.SQL.Add('if(S.duedate <       "'+ FormatDateTime(MysqlDateFormat,(IncMonth(Date,-3)))+ '",S.Balance,0.00) as Over90days ,');
  Qrymain.SQL.Add('SL.linepriceinc as SurchargePaid,');
  Qrymain.SQL.Add('SL.Product_Description as SurchargeDescription');
  Qrymain.SQL.Add('From tblsales s  ');
  Qrymain.SQL.Add('Left JOIN (tblsaleslines SL  ');
  Qrymain.SQL.Add('INNER JOIN tblparts P on p.partsid = SL.productId and P.partname = ' +Quotedstr(tcconst.PART_OVERDUE_SURCH)+') on S.saleId = SL.SaleId  ');
  Qrymain.SQL.Add('where s.IsInvoice ="T" and ifnull(balance,0) <> 0');
  Qrymain.SQL.Add('Order by Duedate Desc');
  inherited;

end;

procedure TOverdueInvoicesGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(TblUpdateSurchargestatus);
  inherited;
end;

procedure TOverdueInvoicesGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Sametext(field.fieldname ,qryMainForeignExchangeCode.fieldname) then
    if sametext(qryMainForeignExchangeCode.asString , Appenv.RegionalOptions.ForeignExDefault) then Afont.color := ABrush.color;

  if  Sametext(field.fieldname ,qryMainwithinTerms.fieldname) or
      Sametext(field.fieldname ,qryMain1to30days.fieldname) or
      Sametext(field.fieldname ,qryMain30to60days.fieldname) or
      Sametext(field.fieldname ,qryMain60to90days.fieldname) or
      Sametext(field.fieldname ,qryMainOver90days.fieldname) or
      Sametext(field.fieldname ,qryMainPayment.fieldname) or
      Sametext(field.fieldname ,qryMainBalance.fieldname) or
      Sametext(field.fieldname ,qryMaintotalAmountinc.fieldname) then
      if field.asfloat =0 then Afont.color := ABrush.color;
  if (QrymainPayment.asfloat <> 0) and  (QrymainSurchargePaid.asFloat <>0) then
    ABrush.color := GridColhighLightOrange;
end;

procedure TOverdueInvoicesGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if Selecting then begin
    Accept := (QrymainPayment.asfloat = 0) or (QrymainSurchargePaid.asFloat =0);
    if not Accept then
      timermsg(lblNote , 'Invoice # ' +inttostr(QrymainSaleId.asInteger) +' is partially paid and the surcharge is already applied to it.  It is not possible to apply surcharge again')
  end;
end;

function TOverdueInvoicesGUI.InvObj: TInvoice;
begin
  if fInv = nil then begin
    fInv := TInvoice.CreateWithNewConn(Self);
    fInv.silentmode := True;
  end;
  Result := fInv;
end;

procedure TOverdueInvoicesGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);

begin
  inherited;
  if IterateProcNo =1 then begin
     if (QrymainPayment.asfloat = 0) or (QrymainSurchargePaid.asFloat =0) then grdmain.selectrecord;
  end else if IterateProcNo =2 then begin
    ApplyOverdueSurcharge(abort);
  end else if  (IterateProcNo=ItearteProcno4ValidateSelection) then begin
    if  (QrymainPayment.asfloat <> 0) and  (QrymainSurchargePaid.asFloat <>0) then
      Grdmain.UnselectRecord;
  end;
end;

Procedure TOverdueInvoicesGUI.ApplyOverdueSurcharge(var abort:Boolean);
var
  SurchargeAmount:Double;
  SeqNo,SortId:Integer;
  SurchargeAmountDesc:String;
  Procedure SurchargeApplied(Status:Boolean;ID:Integer;Msg:STring);
  begin
    UpdatedIds.add('Insert ignore into '+ TblUpdateSurchargestatus+' Set Updated = '+quotedstr(BooleanToStr(Status))+','+
                                                        'SaleID = ' +inttostr(ID)+','+
                                                        'Msg = ' +Quotedstr(MSG)+';');
  end;
begin
  if (qryMain1to30days.AsFloat =0) and (qryMain30to60days.AsFloat =0) and (qryMain60to90days.AsFloat =0) and (qryMainOver90days.AsFloat =0)  then exit;

           if (qryMain1to30days.AsFloat  <> 0) and (Appenv.CompanyPrefs.SurchargePercent1<>0) then begin SurchargeAmount:= Appenv.CompanyPrefs.SurchargePercent1; SurchargeAmountDesc:= '1 - 30 days Overdue';
  end else if (qryMain30to60days.AsFloat <> 0) and (Appenv.CompanyPrefs.SurchargePercent2<>0) then begin SurchargeAmount:= Appenv.CompanyPrefs.SurchargePercent2; SurchargeAmountDesc:= '30 - 60 days Overdue';
  end else if (qryMain60to90days.AsFloat <> 0) and (Appenv.CompanyPrefs.SurchargePercent3<>0) then begin SurchargeAmount:= Appenv.CompanyPrefs.SurchargePercent3; SurchargeAmountDesc:= '60 - 90 days Overdue';
  end else if (qryMainOver90days.AsFloat <> 0) and (Appenv.CompanyPrefs.SurchargePercent4<>0) then begin SurchargeAmount:= Appenv.CompanyPrefs.SurchargePercent4; SurchargeAmountDesc:= '> 90 days Overdue';
  end else exit;
  SurchargeAmountDesc := SurchargeAmountDesc + '-' +floattostrF(SurchargeAmount, ffgeneral,15,2)+'%';

  with InvObj do begin
    Load(QrymainsaleId.AsInteger);
    if count =1 then begin
      if Lock then begin
        connection.BeginNestedTransaction;
        try
            if Lines.Dataset.Locate('ProductName',PART_OVERDUE_SURCH,[loCaseInsensitive]) then begin
              if TotalPaid <> 0 then begin
                SurchargeApplied(False, ID, Lines.ProductDescription + ' - Already Appliled and invoice is partially Paid' );
                Exit;
              end;
              SurchargeAmount := RoundCurrency((SurchargeAmount/100) * (TotalAmountInc - Lines.TotalLineAmountInc));
              if Lines.LinePriceInc <> SurchargeAmount then begin
                Lines.LinePriceInc := SurchargeAmount;
                Lines.ProductDescription := SurchargeAmountDesc;
                Lines.PostDb;
                if not Save then begin
                  SurchargeApplied(False, ID, LastErrorMsgFromREsultStatus );
                  connection.RollbackNestedTransaction;
                  exit;
                end;
              end;
            end else begin
              SurchargeAmount := RoundCurrency((SurchargeAmount/100) * TotalBalance);
              lines.Last;
              SeqNo := lines.SeqNo;
              SortId := lines.SortID;
              lines.New;
              lines.ProductName    := PART_OVERDUE_SURCH;
              lines.UOMMultiplier  := 1;
              lines.UOMQtySold     := 1;
              lines.LinePriceInc   := SurchargeAmount;
              lines.UOMQtyShipped  := 1;
              lines.SeqNo:= SeqNo+1;
              lines.SortID:= SortID+10;
              Lines.ProductDescription := SurchargeAmountDesc;
              Lines.PostDb;
              if not Save then begin
                  SurchargeApplied(False, ID, LastErrorMsgFromREsultStatus);
                  connection.RollbackNestedTransaction;
                  exit;
              end;
            end;
            SurchargeApplied(True, ID, SurchargeAmountDesc);
            connection.CommitNestedTransaction;
        Except
          on E:Exception do begin
            connection.RollbackNestedTransaction;
            SurchargeApplied(False, ID, E.Message);
          end;
        end;
      end else begin
        SurchargeApplied(False, ID, replacestr(UserLock.lockMessage , #13#10, '.'));
      end;
    end;
  end;

end;
procedure TOverdueInvoicesGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
           if (qryMain1to30days.AsFloat  <> 0) then begin qryMainSurchageDueAmount.Asfloat:= Appenv.CompanyPrefs.SurchargePercent1*Qrymaintotalamountinc.AsFloat/100; qryMainSurchageDueDescription.asString:=  '1 - 30 days Overdue : ' +floattostrF(Appenv.CompanyPrefs.SurchargePercent1, ffgeneral,15,2)+'%';
  end else if (qryMain30to60days.AsFloat <> 0) then begin qryMainSurchageDueAmount.Asfloat:= Appenv.CompanyPrefs.SurchargePercent2*Qrymaintotalamountinc.AsFloat/100; qryMainSurchageDueDescription.asString:= '30 - 60 days Overdue : ' +floattostrF(Appenv.CompanyPrefs.SurchargePercent2, ffgeneral,15,2)+'%';
  end else if (qryMain60to90days.AsFloat <> 0) then begin qryMainSurchageDueAmount.Asfloat:= Appenv.CompanyPrefs.SurchargePercent3*Qrymaintotalamountinc.AsFloat/100; qryMainSurchageDueDescription.asString:= '60 - 90 days Overdue : ' +floattostrF(Appenv.CompanyPrefs.SurchargePercent3, ffgeneral,15,2)+'%';
  end else if (qryMainOver90days.AsFloat <> 0) then begin qryMainSurchageDueAmount.Asfloat:= Appenv.CompanyPrefs.SurchargePercent4*Qrymaintotalamountinc.AsFloat/100; qryMainSurchageDueDescription.asString:=    '> 90 days Overdue : ' +floattostrF(Appenv.CompanyPrefs.SurchargePercent4, ffgeneral,15,2)+'%';
  end else exit;
end;

procedure TOverdueInvoicesGUI.RefreshQuery;
begin
 inherited;
end;

procedure TOverdueInvoicesGUI.ShowSurchargeUpdateResult;
var
  ds:TERPQuery;
  ssql:String;
begin
  if UpdatedIds.Count>0 then begin
    With Scriptmain do begin
      SQL.clear;
      SQL.add('Drop table if Exists '+ TblUpdateSurchargestatus+';');
      SQL.add('CREATE TABLE '+ TblUpdateSurchargestatus+' ( ID      INT NOT NULL AUTO_INCREMENT, 	'+
                                                          ' SaleId  INT NOT NULL DEFAULT 0, 		'+
                                                          ' Updated ENUM("T","F") NOT NULL DEFAULT "F", 		'+
                                                          '	Msg     VARCHAR(255)  NULL     DEFAULT NULL,'+
                                                          ' PRIMARY KEY (ID) ) 	'+
                                                          ' COLLATE="utf8_general_ci"  ENGINE=MyISAM ;');
      SQL.add(UpdatedIds.Text);
      Execute;
    end;
    ds:= TempMyQuery;
    try
      ds.SQL.text := 'Select Id, saleID, if(Updated="T" ,"Applied" , "NOT Applied") Updated, MSG from ' + TblUpdateSurchargestatus;
      ds.Open;
      if ds.RecordCount >0 then begin
              InitMsgParams;
              PopupMsgParams.Msgcaption := 'Overdue Surcharge Update Status';
              PopupMsgParams.Msgds := ds;
              PopupMsgParams.Custombuttons :='"Ok","Print"';
              PopupMsgParams.fieldnames := 'SaleId,Updated,MSg';
              PopupMsgParams.displayLabels:= 'ID #,Surcharge,Description';
              PopupMsgParams.DisplayWidths :='80,80,340';
              PopupMsgParams.Msg1:= 'Overdue Surcharge Update Status of Selected Sales';
              PopupMsgParams.Msg2 := '';
              PopupMsgParams.MsgColor := Self.Color;
              if TfmMessageWithList.MsgDlg = 101 then begin
                ssql := companyInfoSQL+'~|||~{Details}Select Id, saleID, if(Updated="T" ,"Applied" , "NOT Applied") Updated, MSG   from  ' + TblUpdateSurchargestatus;
                ReportSQLSupplied:= TRue;
                PrintTemplateReport('Surcharge Applied Sales List' , ssql, False , 1);
              end;
      end;
    finally
      ds.closenFree;
    end;

  end;

end;

initialization
  RegisterClassOnce(TOverdueInvoicesGUI);

end.
