unit QuoteListForm;
{
   Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   26/10/05 1.00.1   MV   Added Product Descriptions of Manufacturer, Size, Type
                          and custom fields.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ToolWin, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, KbmMemTable,
  ProgressDialog,  wwdblook, Shader, BaseListDetails, DAScript,
  MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TQuoteListGUI = class(TBaseListDetailsGUI)
    qryMainType: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainGlobal: TWideStringField;
    qryMainOriginal: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainCustomerType: TWideStringField;
    qryMainTotalQuoteAmount: TFloatField;
    qryMainComments: TWideStringField;
    qryMainPickMemo: TWideStringField;
    qryMainQuoteStatus: TWideStringField;
    qryMainConverted: TWideStringField;
    qryMainDone: TWideStringField;
    qryMainReference: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateField;
    qryMainCUSTDATE2: TDateField;
    qryMainCUSTDATE3: TDateField;
    qryMainInvoiceTo: TWideStringField;
    qryMainShipTo: TWideStringField;
    qryMainFollowupDate: TDateField;
    qryMainRep: TWideStringField;
    qryMainEnteredBy: TWideStringField;
    qryMainclass: TWideStringField;
    btnTransSeq: TDNMSpeedButton;
    qryMainFundingBody: TWideStringField;
    qryMainFundingBodyId: TIntegerField;
    qryMainVariedFromRef: TWideStringField;
    qryMainVariedtoRef: TWideStringField;
    qryMainIsVaried: TWideStringField;
    qryMainEmployeeId: TIntegerField;
    qryMainSalesCategory: TWideStringField;
    qryMainPrintName: TWideStringField;
    qryMainTerms: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure btnTransSeqClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    procedure TransactionSequenceBeforeshow(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    (*procedure CustomFieldsRefresh;*)
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure SetGridColumns;override;
    Function ExpressDetailListName:String;Override;
  end;

implementation

uses FastFuncs,frmQuote, CommonDbLib, CommonLib, Forms, AppEnvironment, tcConst,
  TransactionSequence, CommonFormLib, tcDataUtils, DateUtils;

{$R *.dfm}

procedure TQuoteListGUI.grdMainDblClick(Sender: TObject);
var
//  clientId:Integer;
  SaleId:Integer;
begin
  SubsequentID :='';
//  ClientId := 0;
  if SameText(ActiveFieldname , QrymainVariedfromref.fieldname) then begin
    SaleId :=GetSaleIDForGlobalRef(QrymainVariedfromref.asString);
    if SaleID <> 0 then begin
      OpenErpform('TQuoteGUI' , saleID);
      Exit;
    end;
  end else if SameText(ActiveFieldname , QrymainVariedToref.fieldname) then begin
    SaleId :=GetSaleIDForGlobalRef(QrymainVariedToref.asString);
    if SaleID <> 0 then begin
      OpenErpform('TQuoteGUI' , saleID);
      Exit;
    end;
  end;
//  else if SameText(ActiveFieldname , Qrymaincustomername.fieldname) then
//    ClientId := QrymainClientID.asInteger
//  else if SameText(ActiveFieldname , Qrymainfundingbody.fieldname) then
//    ClientId := QrymainFundingbodyId.asInteger;

//  if ClientID <> 0 then
//    if Clienttype(ClientID)  = ttcustomer then
//      SubsequentID := '_Customer'
//    else
//      SubsequentID := '_Job';
  inherited;

end;

procedure TQuoteListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin   // Active Quotes
        GroupFilterString := 'Done = ' + QuotedStr('F') + ' AND Converted = ' + QuotedStr('F') + ' and IsVaried =  ' + QuotedStr('F');
      end;

    1:
      begin // Converted Quotes
        GroupFilterString := 'Converted = ' + QuotedStr('T');
      end;

    2: 
      begin // Completed Quotes
        GroupFilterString := 'Done = ' + QuotedStr('T');
      end;
    3:
      begin // Completed Quotes
        GroupFilterString := 'IsVaried =  ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

procedure TQuoteListGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtfrom').AsDate := 0;
    qryMain.Params.ParamByName('txtto').AsDate :=  DateUtils.IncYear(now, 1000);
  end
  else begin
    qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  end;
  inherited;
end;

procedure TQuoteListGUI.cmdNewClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    tmpComponent := GetComponentByClassName('TQuoteGUI');
    if not Assigned(tmpComponent) then Exit;
    with TQuoteGUI(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TQuoteListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if (not Assigned(Owner)) or (not (Owner is TForm)) then begin
    {only do this if the list not owned by another form, ie embeded}
    fbEnableWebSearch := true;
  end;    
  ShowChartViewOnPopup := True;
end;

procedure TQuoteListGUI.RefreshTotals;
var
  mem: TKbmMemTable;
  dTotalAmtEx, dTotalTax, dTotalAmtInc: double;
begin
  inherited;
  mem := TKbmMemTable.Create(nil);
  try
    mem.LoadFromDataset(qryMain, [mtcpoStructure, mtcpoProperties]);
    dTotalAmtEx  := 0;
    dTotalTax    := 0;
    dTotalAmtInc := 0;
    while not mem.Eof do begin
      dTotalAmtEx := dTotalAmtEx + mem.FieldByName('Total Amount (Ex)').AsFloat;
      dTotalTax := dTotalTax + mem.FieldByName('Total Tax').AsFloat;
      dTotalAmtInc := dTotalAmtInc + mem.FieldByName('Total Amount (Inc)').AsFloat;
      // Fetch next records.
      mem.Next;
    end;

    // Show totals.
    grdMain.ColumnByName('Total Amount (Ex)').FooterValue  := FloatToStrF(dTotalAmtEx, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('Total Tax').FooterValue          := FloatToStrF(dTotalTax, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('Total Amount (Inc)').FooterValue := FloatToStrF(dTotalAmtInc, ffCurrency, 15, CurrencyRoundPlaces);

  finally
    // Release our used objects.
    if Assigned(mem) then
      FreeandNil(mem);
  end;
end;

(*procedure TQuoteListGUI.CustomFieldsRefresh;
var
  LoopFields: integer;
begin
  qryCustomFields.Close;
  qryCustomFields.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCustomFields.Open;

  // Modify the column header
  for LoopFields := 1 to 18 do begin
    grdMain.ColumnByName('CUSTFLD' + IntToStr(LoopFields)).DisplayLabel :=
      qryCustomFields.FieldByName('CFLabel' + IntToStr(LoopFields)).AsString;
  end;
  qryCustomFields.Close;
end;*)

procedure TQuoteListGUI.FormShow(Sender: TObject);
begin
  inherited;
  btnTransSeq.enabled := appenv.companyPrefs.EnablequoteVariation;
  if (Self.AccessLevel = 6) then Exit;
  (*CustomFieldsRefresh;*)
end;

procedure TQuoteListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TQuoteListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TQuoteListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

function TQuoteListGUI.ExpressDetailListName: String;
begin
  REsult := 'TQuoteListExpressGUI';
end;

procedure TQuoteListGUI.btnTransSeqClick(Sender: TObject);
begin
  inherited;
  if FormStillOpen('TTransactionSequenceGUI') then begin
    Try
      TTransactionSequenceGUI(GetComponentByClassName('TTransactionSequenceGUI')).BringToFront;
    Except
        // kill exception
    end;
    MessageDlgXP_Vista('Please Close the Opened Transaction Sequence to Open the Transaction Sequence of ' + 'Invoice # ' +IntToStr(QrymainSaleID.asInteger) +'.' , mtwarning, [mbok], 0);
    Exit;
  end;
  CreatenOpenERPListForm('TTransactionSequenceGUI' , TransactionSequenceBeforeshow);
end;
procedure TQuoteListGUI.TransactionSequenceBeforeshow(
  Sender: TObject);
begin
   if not(Sender is TTransactionSequenceGUI) then exit;
   TTransactionSequenceGUI(Sender).GlobalRef := qryMainGlobal.asString;
   TTransactionSequenceGUI(Sender).Transtype := 'QUOTE'
end;

procedure TQuoteListGUI.cmdCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TQuoteListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Cust');
  RemoveFieldfromGrid('employeeId');
  RemoveFieldfromGrid('ClientId');
  RemoveFieldfromGrid(qryMainFundingBodyId.Fieldname);
end;

initialization
  RegisterClassOnce(TQuoteListGUI);
end.
