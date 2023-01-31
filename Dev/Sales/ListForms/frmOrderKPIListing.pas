unit frmOrderKPIListing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BusObjPreference, JsonObject,
  DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TfmOrderKPIListing = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainQuoteId: TIntegerField;
    qryMainQuoteNo: TWideStringField;
    qryMainQuoteGlobalRef: TWideStringField;
    qryMainQuoteStatus: TWideStringField;
    qryMainSalesCategory: TWideStringField;
    qryMainSalesOrderID: TIntegerField;
    qryMainSalesOrderNo: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainFundingBodyName: TWideStringField;
    qryMainQuoteDate: TDateTimeField;
    qryMainSalesOrderDate: TDateTimeField;
    qryMainSalesOrderStatus: TWideStringField;
    qryMainOrderAcknowlegmentDate: TDateTimeField;
    qryMainOrderAcknowlegmentDays: TIntegerField;
    qryMainDeliveryConfirmationDate: TDateTimeField;
    qryMainDeliveryConfirmationMins: TIntegerField;
    qryMainSalesOrderShipDate: TDateTimeField;
    qryMainSalesOrderShipping: TWideStringField;
    qryMainLeadTimeMins: TIntegerField;
    qryMainDelayReason: TWideStringField;
    btnConfig: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnConfigClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    TempTableName: string;
    Pref: TPreference;
    Config: TJsonObject;
    procedure PopulateTable;
    procedure DoOnPeriodGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  public
    procedure RefreshQuery; override;
  end;

var
  fmOrderKPIListing: TfmOrderKPIListing;

implementation

{$R *.dfm}

uses
  CommonDbLib, BusObjBase, frmOrderKPIConfig, CommonFormLib;

procedure TfmOrderKPIListing.btnConfigClick(Sender: TObject);
begin
  inherited;
  if frmOrderKPIConfig.DoConfig then begin
    Pref.CloseDb;
    Pref.Load(0,'Config','TfmOrderKPIListing');
    Config.AsString:= Pref.PrefValue;
    RefreshQuery;
  end;
end;

procedure TfmOrderKPIListing.DoOnPeriodGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
var
  days: string;
begin
  if not Sender.IsNull then begin
   days := IntToStr(Abs(Trunc(Sender.AsInteger/1440)));
    while Length(days) < 3 do
      days := '0' + days;
    if (Sender.AsInteger/1440) < 0 then
      days := '- ' + days;
    Text := days + ' ' + FormatDateTime('hh:nn',Frac(Sender.AsInteger / 1440));
  end
  else
    Text := ''
end;

procedure TfmOrderKPIListing.FormCreate(Sender: TObject);
begin
  inherited;
  Pref := TPreference.Create(nil);
  Pref.Connection:= TMyDacDataConnection.Create(Pref);
  Pref.Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
  Pref.Load(0,'General','Config','TfmOrderKPIListing');
  Config := TJsonObject.Create;
  Config.AsString:= Pref.PrefValue;

  TempTableName := CreateUserTemporaryTable('tmp_orderkpi');
  qryMain.SQL.Text := StringReplace(qryMain.SQL.Text, 'tmp_orderkpi',TempTableName,[]);

  RefreshOrignalSQL;
end;

procedure TfmOrderKPIListing.FormDestroy(Sender: TObject);
begin
  inherited;
  Config.Free;
  Pref.Free;
  DestroyUserTemporaryTable(TempTableName);
end;

procedure TfmOrderKPIListing.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('ID,QuoteID,SalesOrderID');
end;

procedure TfmOrderKPIListing.grdMainDblClick(Sender: TObject);
var
  field: TField;
begin
  field := grdMain.SelectedField;
  if Assigned(field) then begin
    if SameText(field.FieldName,'QuoteNo') or
           SameText(field.FieldName,'QuoteGlobalRef') or
           SameText(field.FieldName,'QuoteStatus') or
           SameText(field.FieldName,'SalesCategory') or
           SameText(field.FieldName,'CustomerName') or
           SameText(field.FieldName,'FundingBodyName') or
           SameText(field.FieldName,'QuoteDate') or
           SameText(field.FieldName,'QuoteID') then
      CommonFormLib.OpenERPForm('TQuoteGUI',qryMainQuoteId.AsInteger)
    else if SameText(field.FieldName,'SalesOrderNo') or
            SameText(field.FieldName,'SalesOrderDate') or
            SameText(field.FieldName,'SalesOrderStatus') or
            SameText(field.FieldName,'SalesOrderId') then
      CommonFormLib.OpenERPForm('TSalesOrderGUI',qryMainSalesOrderId.AsInteger)
    else
     inherited;
  end;
end;

procedure TfmOrderKPIListing.PopulateTable;
var
  ProgDialog: TProgressDialog;
  cmd: TERPCommand;
  s: string;
  x: integer;
begin
  qryMain.Close;
  ProgDialog := TProgressDialog.Create(nil);
  ProgDialog.Caption := 'Loading Data';
  ProgDialog.MaxValue := 9;
  ProgDialog.Step := 1;
  ProgDialog.Value := 1;
  cmd := TERPCommand.Create(nil);
  try
    ProgDialog.Execute;
    ProgDialog.Message := 'Reading Quotes ..';
    cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
    cmd.SQL.Text := 'truncate ' + TempTableName;
    cmd.Execute;
    cmd.SQL.Clear;
    cmd.SQL.Add('insert into ' + TempTableName);
    cmd.SQL.Add('(QuoteID,QuoteNo,QuoteGlobalRef,CustomerName,FundingBodyName,QuoteDate,SalesCategory,QuoteStatus)');
    cmd.SQL.Add('select');
    cmd.SQL.Add('Q.SaleId as QuoteID,');
    cmd.SQL.Add('Q.InvoiceDocNumber as QuoteNo,');
    cmd.SQL.Add('Q.GlobalRef as QuoteGlobalRef,');
    cmd.SQL.Add('Q.CustomerName as CustomerName,');
    cmd.SQL.Add('R.MasterCompany as FundingBodyName,');
    cmd.SQL.Add('Q.SaleDate as QuoteDate,');
    cmd.SQL.Add('Q.SalesCategory as SalesCategory,');
    cmd.SQL.Add('Q.QuoteStatus as QuoteStatus');
    cmd.SQL.Add('from tblSales Q');
    cmd.SQL.Add('inner join tblrelatedclients R on Q.ClientID = R.ChildClientID');
    cmd.SQL.Add('where Q.IsQuote = "T"');
    cmd.SQL.Add('and Q.SaleDate between :date1 and :date2');
    cmd.SQL.Add('order by Q.SaleDate, R.MasterCompany');
    cmd.ParamByName('date1').AsDate := dtFrom.Date;
    cmd.ParamByName('date2').AsDate := dtTo.Date;
    cmd.Execute;
    ProgDialog.StepIt;

    { get the sales order that was created from quote, the first one if multiple }
    ProgDialog.Message := 'Reading Sales Orders ..';
    cmd.SQL.Clear;
    cmd.SQL.Add('update ' + TempTableName);
    cmd.SQL.Add('set SalesOrderID = (select min(SO.SaleID) from tblSales SO where SO.IsSalesOrder = "T" and SO.QuoteGlobalRef = '+ TempTableName +'.QuoteGlobalRef group by SO.QuoteGlobalRef)');
    cmd.Execute;
    ProgDialog.StepIt;

    { get sales order info }
    ProgDialog.Message := 'Updating Sales Orders ..';
    cmd.SQL.Clear;
    cmd.SQL.Add('update ' + TempTableName + ', tblSales SO');
//    cmd.SQL.Add('set SalesOrderDate = SO.SaleDate,');
    cmd.SQL.Add('set SalesOrderDate = AddTime(SO.OriginalCreationDate,SO.EnteredAt),');
    cmd.SQL.Add('SalesOrderStatus = SO.QuoteStatus,');
    cmd.SQL.Add('SalesOrderShipDate = SO.ShipDate,');
    cmd.SQL.Add('SalesOrderShipping = SO.Shipping,');
    cmd.SQL.Add('SalesOrderNo = SO.InvoiceDocNumber');
    cmd.SQL.Add('where ' + TempTableName + '.SalesOrderID = SO.SaleID');
    cmd.Execute;
    ProgDialog.StepIt;

    if Config.S['QuoteLetter'] <> '' then begin
      cmd.SQL.Clear;
      cmd.SQL.Add('update ' + TempTableName);
      cmd.SQL.Add('set OrderAcknowlegmentDate = ');
      cmd.SQL.Add('(select min(PD.PrintDate) from tblPrintDocs PD where PD.DocName = "TQuote" and PD.templatename = "' +
        Config.S['QuoteLetter'] + '" and ' + TempTableName + '.QuoteID = PD.DocID group by PD.DocID, PD.DocName, PD.templatename)');
      cmd.Execute;
    end;
    ProgDialog.StepIt;

//    cmd.SQL.Clear;
//    cmd.SQL.Add('update ' + TempTableName);
//    cmd.SQL.Add('set DeliveryConfirmationDate = ');
//    cmd.SQL.Add('(select min(PD.PrintDate) from tblPrintDocs PD where PD.DocName = "TSalesOrder" and PD.templatename = "' +
//      Config.S['DeliveryConfirmation'] + '" and ' + TempTableName + '.SalesOrderID = PD.DocID group by PD.DocID, PD.DocName, PD.templatename)');
//    cmd.Execute;
//    ProgDialog.StepIt;
    s:= '';
    for x := 0 to Config.A['DeliveryConfirmationList'].Count -1 do begin
      if s <> '' then s := s + ',';
      s := s + '"' + Config.A['DeliveryConfirmationList'].Items[x].AsString + '"';
    end;
    if s <> '' then  begin
      s:= '(' + s + ')';
      cmd.SQL.Clear;
      cmd.SQL.Add('update ' + TempTableName);
      cmd.SQL.Add('set DeliveryConfirmationDate = ');
      cmd.SQL.Add('(select min(PD.PrintDate) from tblPrintDocs PD where PD.DocName = "TSalesOrder" and PD.templatename in ' + s +
       ' and ' + TempTableName + '.SalesOrderID = PD.DocID)');
      cmd.Execute;
    end;
    ProgDialog.StepIt;

//    cmd.SQL.Clear;
//    cmd.SQL.Add('update ' + TempTableName);
//    cmd.SQL.Add('set OrderAcknowlegmentMins = TIME_TO_SEC(TIMEDIFF(OrderAcknowlegmentDate,SalesOrderDate)) / 60');
//    cmd.SQL.Add('where not IsNull(OrderAcknowlegmentDate) and not IsNull(SalesOrderDate) and OrderAcknowlegmentDate > SalesOrderDate');
//    cmd.Execute;
//    ProgDialog.StepIt;
    cmd.SQL.Clear;
    cmd.SQL.Add('update ' + TempTableName);
    cmd.SQL.Add('set OrderAcknowlegmentDays = DateDiff(OrderAcknowlegmentDate,SalesOrderDate)' +
      ' - (Truncate(DateDiff(OrderAcknowlegmentDate,SalesOrderDate) / 7,0) * 2)' +
      ' - (select Count(*) from tblPublicHolidays H where H.Day Between SalesOrderDate and OrderAcknowlegmentDate and not (DayOfWeek(H.Day)) in (1,7))');
    cmd.SQL.Add('where not IsNull(OrderAcknowlegmentDate) and not IsNull(SalesOrderDate) and OrderAcknowlegmentDate > SalesOrderDate');
    cmd.Execute;
    ProgDialog.StepIt;

    cmd.SQL.Clear;
    cmd.SQL.Add('update ' + TempTableName);
    cmd.SQL.Add('set DeliveryConfirmationMins = TIME_TO_SEC(TIMEDIFF(DeliveryConfirmationDate,SalesOrderDate)) / 60');
    cmd.SQL.Add('where not IsNull(DeliveryConfirmationDate) and not IsNull(SalesOrderDate) and DeliveryConfirmationDate > SalesOrderDate');
    cmd.Execute;
    ProgDialog.StepIt;

    cmd.SQL.Clear;
    cmd.SQL.Add('update ' + TempTableName);
    cmd.SQL.Add('set LeadTimeMins = TIME_TO_SEC(TIMEDIFF(SalesOrderShipDate,SalesOrderDate)) / 60');
    cmd.SQL.Add('where not IsNull(SalesOrderDate) and not IsNull(SalesOrderShipDate) and SalesOrderDate < SalesOrderShipDate');
    cmd.Execute;
    ProgDialog.StepIt;

    cmd.SQL.Clear;
    cmd.SQL.Add('update ' + TempTableName + ', tblsalesdeliverydetails D');
    cmd.SQL.Add('set DelayReason = D.CauseOfDelay');
    cmd.SQL.Add('where ' + TempTableName + '.SalesOrderId = D.SaleID');
    cmd.Execute;

  finally
    cmd.Free;
    ProgDialog.Free;
  end;
end;

procedure TfmOrderKPIListing.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
//  qryMain.FieldByName('OrderAcknowlegmentMins').OnGetText := DoOnPeriodGetText;
  qryMain.FieldByName('DeliveryConfirmationMins').OnGetText := DoOnPeriodGetText;
  qryMain.FieldByName('LeadTimeMins').OnGetText := DoOnPeriodGetText;
end;

procedure TfmOrderKPIListing.RefreshQuery;
begin
  PopulateTable;
  inherited;
end;

initialization
  RegisterClass(TfmOrderKPIListing);
end.
