unit InvoiceListForm;
{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 25/05/05  1.00.01 BJ  New field is added in the sales tbale RepairGlobalRef
                       this stored the GlobalREf of the repair record if it
                       is an invoice of a repair.
                       Grid has a new column 'ConvertFromRepair' to show this
                       link
 01/07/05  1.00.02 BJ  Added 'Refreshtotal' proc to display the total for the grid
                       the total is calcualted for AmountEx, AmountInc and Tax.
 25/07/05  1.00.03 IJB Changed formating of TotalAmountEx total to currency.
 26/09/05  1.00.04 MV  Modified qryMain.SQL tblClients.CUSTFLD(s) by replacing
                       block for multiple lines and adding [as title].
                       Placed multiple IF statements on one line.
 26/10/05  1.00.04 MV  Added Gross Profit and Percent Profit.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, SelectionDialog, DNMPanel, wwDialog, Wwlocate,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, DNMLib, ProgressDialog,
   wwdblook, Shader, kbmMemTable, BaseInputForm, BaseListDetails,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TInvoiceListGUI = class(TBaseListDetailsGUI)
    btnBOlist: TDNMSpeedButton;
    qryMainSaleDate: TDateField;
    qryMainType: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainPrintname: TWideStringField;
    qryMainGlobal: TWideStringField;
    qryMainOriginal: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainConsignmentNote: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainCustomerType: TWideStringField;
    qryMainHeld: TWideStringField;
    qryMainTerms: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainJobNumber: TIntegerField;
    qryMainConvertFromQuote: TWideStringField;
    qryMainConvertFromSO: TWideStringField;
    qryMainMemo: TWideStringField;
    qryMainComments: TWideStringField;
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
    qryMainShipDate: TDateField;
    qryMainPaid: TWideStringField;
    btnServiceCycle: TDNMSpeedButton;
    qryMainConvertFromRepair: TWideStringField;
    qryMainShipTo: TWideStringField;
    qryMainTimeOfSale: TWideStringField;
    btnDelete: TDNMSpeedButton;
    qryMainDueDate: TDateField;
    qryMainLaybyID: TWideStringField;
    qryMainPOSPostCode: TWideStringField;
    qryMainRep: TWideStringField;
    qryMainEnteredBy: TWideStringField;
    qryMainclass: TWideStringField;
    qryMainCUSTdate1: TDateField;
    qryMainCUSTdate2: TDateField;
    qryMainCUSTdate3: TDateField;
    qryMainMedtype: TWideStringField;
    qryMainCardNumber: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainBOID: TWideStringField;
    qryMainbaseno: TWideStringField;
    qryMainRefno: TWideStringField;
    qryMainSaleConfirmed: TWideStringField;
    qryMainSalesStatus: TWideStringField;
    qryMainParentRelatedCustomerName: TWideStringField;
    qryMainShipTo2: TWideStringField;
    qryMainSalesCategory: TWideStringField;
    qryMainShipVia: TWideStringField;
    qryMainPlannedDelFrom: TDateTimeField;
    qryMainPlannedDelto: TDateTimeField;
    qryMainPromisedDel: TDateTimeField;
    qryMainCauseofDelay: TWideStringField;
    qryMainActualDel: TDateTimeField;
    qryMainDeliveryFeedBack: TWideMemoField;
    qryMainClientAccountno: TWideStringField;
    qryMainPickingMemo: TWideMemoField;
    qryMainTransTime: TTimeField;
    qryMainTransDate: TDateField;
    qryMainPayment: TFloatField;
    qryMainbalance: TFloatField;
    qryMainBOREF: TWideStringField;
    qryMainPaymentMethod: TWideStringField;
    procedure btnBOlistClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnServiceCycleClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);

  private
    { Private declarations }
    oDescription: TASDescription;
    Procedure OpenTransactionSequence;
    Procedure TransactionSequenceBeforeshow(Sender: TObject);


  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); override;
    Procedure SetGridColumns;override;
    procedure AdjustDisplayLabels; override;
    Function ExpressDetailListName:String;Override;
    Function DefaultAllClasses :Integer;Override;
  public
    { Public declarations }
    property ASDescription: TASDescription read oDescription write oDescription;

  end;

implementation

uses
  frmInvoice, DeletedInvoices, BackOrderListForm, frmJob, frmCustomerFrm, CommonDbLib,
  CommonLib, Forms, FastFuncs, AppEnvironment, tcDataUtils,
  TransactionSequence, CommonFormLib, tcConst, DateUtils, SystemLib, LogLib;

{$R *.dfm}

procedure TInvoiceListGUI.RefreshQuery;
begin
  fbIgnoreQuerySpeed := false;
  (*if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtto').AsDate := IncYear(Now(), 1000);
    qryMain.Params.ParamByName('txtfrom').AsDate := 0;
  end else begin
    qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  end;*)
  InitDateFromnDateto('txtfrom' , 'txtto');

  qryMain.Params.ParamByName('IgnoreClassfilter').AsString := BooleanToStr(AppEnv.CompanyPrefs.InvoiceClassDefaultAll and AllClasses);
  qryMain.Params.ParamByName('ClassID').AsInteger := iif(AppEnv.CompanyPrefs.InvoiceClassDefaultAll  , SelectedClassID , appenv.Employee.DefaultClassID);
  try
    clog(Qrymain.SQLtext);
    inherited;
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('Invoice List Failed'+NL+E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TInvoiceListGUI.RefreshTotals;
var
  bm: TBookmark;
  TotalAmountEx:double;
  TotalTax :double;
  TotalAmountInc :Double;
begin
  inherited;
  TotalAmountEx:=0;
  TotalTax :=0;
  TotalAmountInc :=0;
  bm := qryMain.GetBookmark;
  Try
    qryMain.DisableControls;
    with qryMain do begin
      First;
      while not EOF do begin
          TotalAmountEx := TotalAmountEx + qryMain.FieldByname('Total Amount (Ex)').AsFloat;
          TotalTax := TotalTax + qryMain.FieldByname('Total Tax').AsFloat;
          TotalAmountInc := TotalAmountInc + qryMain.FieldByname('Total Amount (Inc)').AsFloat;
          next;
      end;
    end;
  Finally
    try
      qryMain.GotoBookmark(bm);
    except
    end;
    qryMain.FreeBookmark(bm);
    qryMain.EnableControls;
  end;
  grdMain.ColumnByName('Total Amount (Ex)').FooterValue := FloatToStrF(TotalAmountEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Tax').FooterValue := FloatToStrF(TotalTax, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Amount (Inc)').FooterValue := FloatToStrF(TotalAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TInvoiceListGUI.btnBOlistClick(Sender: TObject);
var
  BackOrdersList: TComponent;
begin
  DisableForm;
  try
    inherited;
    BackOrdersList := GetComponentByClassName('TBackOrdersListGUI');
    if Assigned(BackOrdersList) then begin
      TBackOrdersListGUI(BackOrdersList).FormStyle := fsMDIChild;
      TBackOrdersListGUI(BackOrdersList).BringToFront;
      Self.Close;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TInvoiceListGUI.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TInvoiceGUI' , 0);
(*Var
  tmpComponent: TComponent;
begin
  DisableForm;
  try
    inherited;
    tmpComponent := GetComponentByClassName('TInvoiceGUI');
    If not Assigned(tmpComponent) then Exit;
    with TInvoiceGUI(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;*)
end;

procedure TInvoiceListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  inherited;
end;

procedure TInvoiceListGUI.Label4Click(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TInvoiceListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ShowChartViewOnPopup := True;
  if (not Assigned(Owner)) or (not (Owner is TForm)) then begin
    {only do this if the list not owned by another form, ie embeded}
    fbEnableWebSearch := true;
  end;
  if Appenv.CompanyPrefs.InvoiceClassDefaultAll  then SelectionOption := soClass;
end;

procedure TInvoiceListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('Sale Date') + ' DESC CIS ; ' + QuotedStr('SaleID') + ' DESC CIS';
  BaseIndexFieldNames := QuotedStr('SaleID') + ' DESC CIS';
  qryMain.First;
end;

procedure TInvoiceListGUI.btnServiceCycleClick(Sender: TObject);
var
  qry: TERPQuery;
  iClientID: integer;
  frmJob: TJobGUI;
  frmCustomer: TfrmCustomer;
begin
  DisableForm;
  try
    inherited;
    qry := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    try
      iClientID      := qryMain.FieldByName('ClientID').AsInteger;
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.ParamCheck := true;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT ClientID, IsJob FROM tblclients WHERE ClientID = :xID');
      qry.Params.ParamByName('xID').AsInteger := iClientID;

      qry.Open;
      if qry.RecordCount < 1 then begin
        CommonLib.MessageDlgXP_Vista('Could not find requested customer within database - Aborted!', mtWarning, [mbOK], 0);
        Exit;
      end;

      if qry.FieldByName('IsJob').AsBoolean then begin
        frmJob :=TJobGUI(GetComponentByClassName('TJobGUI'));
        If not Assigned(frmJob) then Exit;
        with frmJob do begin
          frmJob := TJobGUI(GetComponentByClassName('TJobGUI'));
          frmJob.KeyID := iClientID;
          frmJob.FormStyle := fsMDIChild;
          frmJob.pgeControl.ActivePage := TTabSheet(frmJob.tabFollowup);
          frmJob.BringToFront;
          Application.ProcessMessages;
          // Activate Auto Service Cycle procedure.
          frmJob.btnServiceCycle.Click;
        end;
      end else begin
        frmCustomer := TfrmCustomer(GetComponentByClassName('TfrmCustomer'));
        If not Assigned(frmCustomer) then Exit;
        with frmCustomer do begin
          frmCustomer := TfrmCustomer(GetComponentByClassName('TfrmCustomer'));
          frmCustomer.KeyID := iClientID;
          frmCustomer.FormStyle := fsMDIChild;
          frmCustomer.TabCtl20.ActivePage := TTabSheet(frmCustomer.tabFollowup);
          frmCustomer.BringToFront;
          frmCustomer.Update;
          frmCustomer.DNMPanel17.Paint;
          Application.ProcessMessages;
          // Activate Auto Service Cycle procedure.
          frmCustomer.btnServiceCycle.Click;
        end;
      end;
    finally
      // Release our used allocated objects.
      if Assigned(qry) then FreeAndNil(qry);
    end;
  finally
    EnableForm;
  end;  
end;

procedure TInvoiceListGUI.btnDeleteClick(Sender: TObject);
begin
  OpenERplistForm('TfrmDeletedInvoicesListGUI' , nil);
  Self.close
(*var
  DeletedInvoicesList: TfrmDeletedInvoicesListGUI;
begin
  inherited;
  DeletedInvoicesList := TfrmDeletedInvoicesListGUI(GetComponentByClassName('TfrmDeletedInvoicesListGUI'));
  if Assigned(DeletedInvoicesList) then begin
    DeletedInvoicesList.FormStyle := fsMDIChild;
    DeletedInvoicesList.BringToFront;
    Close;
  end;*)
end;

procedure TInvoiceListGUI.grdMainCalcCellColors(Sender: TObject;Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Sysutils.SameText(Field.Fieldname , 'LaybyId') then
    if field.Value = '' then
      Afont.color := ABrush.color;
end;

procedure TInvoiceListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TInvoiceListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TInvoiceListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TInvoiceListGUI.cmdCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TInvoiceListGUI.FormShow(Sender: TObject);
begin
  inherited;
  if AppEnv.CompanyPrefs.InvoiceClassDefaultAll then
    //TimerMsg(FilterLabel , 'The list shows Invoices of all ' + Appenv.DefaultClass.ClassHeading+'s based on the preference')
  else if Appenv.Employee.DefaultClassID =0 then
    TimerMsg(FilterLabel , 'The list shows Invoices of your Default ' + Appenv.DefaultClass.ClassHeading+' based on the preference. Your Default ' + Appenv.DefaultClass.ClassHeading+' is not selected')
  else
    TimerMsg(FilterLabel , 'The list shows Invoices of your Default ' + Appenv.DefaultClass.ClassHeading+' - '+ quotedstr(Appenv.Employee.DefaultClassName)+' based on the preference');
end;

procedure TInvoiceListGUI.AdjustDisplayLabels;
begin
  if AppEnv.CompanyPrefs.RelatedMasterCaptionInSales <> '' then
    qryMainParentRelatedCustomerName.DisplayLabel:=
      AppEnv.CompanyPrefs.RelatedMasterCaptionInSales;
  inherited;
end;

procedure TInvoiceListGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  Popupform.KeyId := 0;
  if Sysutils.SameText(grdmain.GetActiveField.fieldname , 'convertfromrepair') then begin
    Popupform.KeyId := GetId(Qrymain.Fieldbyname('ConvertFromRepair').asSTring , 'RepairId' , 'tblrepairs');
  end ;
  if Popupform.KeyId = 0 then inherited;
end;

procedure TInvoiceListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Cust');
  RemoveFieldfromGrid('ClientId');
  RemoveFieldfromGrid('EmployeeID');
  RemoveFieldfromGrid('LaybyId');
  if  AppEnv.CompanyPrefs.ShowSalesWarrantyEndsOn then begin
    grdmain.AddField('WarrantyEndsOn');
  end else begin
    RemoveFieldfromGrid('WarrantyEndsOn');
  end;

  if  AppEnv.CompanyPrefs.ShowSalesWarrantyPeriod then begin
    grdmain.AddField('WarrantyPeriod');
  end else begin
    RemoveFieldfromGrid('WarrantyPeriod');
  end;
end;

procedure TInvoiceListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenTransactionSequence;
end;

function TInvoiceListGUI.ExpressDetailListName: String;
begin
  Result := 'TInvoicelistExpressGUI';
end;

procedure TInvoiceListGUI.OpenTransactionSequence;
begin

  if(Qrymainbaseno.asString = '') and (Qrymainboid.asString = '') then begin 
    MessageDlgXP_Vista('Invoice # ' +IntToStr(QrymainSaleID.asInteger) +' Has No BackOrder Associated with it' , mtInformation , [mbok],0);
    exit;
  end;
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

procedure TInvoiceListGUI.TransactionSequenceBeforeshow(Sender: TObject);
begin
   if not(Sender is TTransactionSequenceGUI) then exit;
   TTransactionSequenceGUI(Sender).Originalglobalref := qryMainOriginal.asString;
   TTransactionSequenceGUI(Sender).GlobalRef := qryMainGlobal.asString;
   TTransactionSequenceGUI(Sender).Transtype := 'INV'
end;
Function TInvoiceListGUI.DefaultAllClasses :Integer;
begin
  result := inherited DefaultAllClasses;
  if result <0 then
    if not Appenv.CompanyPrefs.InvoiceClassDefaultAll then result := 2;
end;

initialization
  RegisterClassOnce(TInvoiceListGUI);
end.

