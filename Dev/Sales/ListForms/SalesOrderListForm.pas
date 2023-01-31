// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 25/04/05  1.00.01 BJ   Totals displayed at the bottom
  // 28/07/05  1.00.02 IJB  Added RefreshTotals to grpFilters onClick.
  // 10/08/05  1.00.03 DSP  The grid was being disabled when the 'Invoice' was
  //                        clicked but not enabled again. DisableControls and
  //                        EnableControls are now being used.
  // 01/09/05  1.00.04 DSP  Removed use of GetRowCount.
  // 03/11/05  1.00.05 MV   Added DueDate to SQL and List.

unit SalesOrderListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB, Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, ToolWin, ImgList, Menus, AdvMenus, PrintDAT,
  ActnList, wwDialog, Wwlocate, SelectionDialog, DNMPanel,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable,busobjPQa,
  DNMAction, IntegerListObj, UserLockObj, BaseListDetails, DAScript, MyScript,
  wwcheckbox, CustomInputBox, BusObjBase, wwclearbuttongroup, wwradiogroup,
  GIFImg;

type
  TSalesOrderListGUI = class(TBaseListDetailsGUI)
    CmdBackorders: TDNMSpeedButton;
    chkLayBy: TCheckBox;
    btnMergeToInvoice: TDNMSpeedButton;
    btnPrintTree: TDNMSpeedButton;
    ActionList1: TActionList;
    actInvoice: TDNMAction;
    DNMSpeedButton1: TDNMSpeedButton;
    btnChangeStatus: TDNMSpeedButton;
    qryMainbaseno: TWideStringField;
    qryMainboID: TWideStringField;
    qryMainSaleDate: TDateTimeField;
    qryMainShipDate: TDateTimeField;
    qryMainShipVia: TWideStringField;
    qryMainSalesCategory: TWideStringField;
    qryMainSalesOrderStatus: TWideStringField;
    qryMainIsLayBy: TWideStringField;
    qryMainType: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainPrintname: TWideStringField;
    qryMainJobname: TWideStringField;
    qryMainCustomerJobNumber: TWideStringField;
    qryMainJobNumber: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainOriginalref: TWideStringField;
    qryMainSalesOrderNumber: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainConverted: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainBalance: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainConsignmentNote: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainClassID: TIntegerField;
    qryMainTerms: TWideStringField;
    qryMainHeld: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainConvertFromQuote: TWideStringField;
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
    qryMainCUSTFLD13 :TWideStringField;
    qryMainCUSTFLD14 :TWideStringField;
    qryMainCUSTFLD15: TWideStringField;

    qryMainFutureSO: TWideStringField;
    qryMainDueDate: TDateTimeField;
    qryMainclass: TWideStringField;
    qryMainRep: TWideStringField;
    qryMainComments: TWideStringField;
    qryMainAttrib1Sale: TFloatField;
    qryMainAttrib2Sale: TFloatField;
    qryMainAttrib1SaleRate: TFloatField;
    qryMainIsLayByTOS: TWideStringField;
    qryMainShipTo: TWideStringField;
    qryMainPlannedDelFrom: TDateTimeField;
    qryMainPlannedDelto: TDateTimeField;
    qryMainPromisedDel: TDateTimeField;
    qryMainCauseofDelay: TWideStringField;
    qryMainActualDel: TDateTimeField;
    qryMainForeignExchangeCode: TWideStringField;
    qryMainForeignExchangeRate: TFloatField;
    qryMainSalesPrePayments: TFloatField;
    qryMainProgresspayments: TFloatField;
    qryMainDeliveryFeedBack: TWideStringField;
    qryMainID: TIntegerField;

    procedure grpFiltersClick(Sender: TObject);Override;
    procedure CmdBackordersClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure chkLayByClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure actClearFilterExecute(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure btnPrintTreeClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure actInvoiceUpdate(Sender: TObject);
    procedure actInvoiceExecute(Sender: TObject);
    procedure btnChangeStatusclick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormDestroy(Sender: TObject);
  private
    fiClientId: Integer;
    invIdsList:TIntegerList;
    NewStatus:String;
    UserLock: TUserLock;
    ChangeStatusSQL:TStringList;
    InvalidRecordselected:Boolean;
    SingleInvoice:Boolean;
    //fiMergingSOclientID:Integer;
    fiMergingSODeptID:Integer;
    fsForeignExchangeCode:String;
    fdForeignExchangeRate:Double;
    fiSaleIDtoconvert:Integer;
    //fsOktoMergeMsg:String;
    fstablename :String;

    Function  DoProductallocation(const LineObj :TProdQty):Boolean ;
    Procedure OpenTransactionSequence;
    Procedure TransactionSequenceBeforeshow(Sender: TObject);
    procedure setClientID(const Value: Integer);
    function getNewStatus: String;
    //function IsOktoMergeallSOsSelected :Boolean;
    Procedure PopulateData;

  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure SetGridColumns;Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);Override;
    Function ExpressDetailListName:String;Override;
    //Function IsOktoMerge:Boolean;

  public
    { Public declarations }
    ftblSalesLinesDetails: TERPQuery;
    Property ClientID :Integer read fiClientId write setClientID;

  end;


implementation
{$R *.dfm}

uses
  BackOrderSOForm, frmSalesOrder, CommonDbLib, frmInvoice,
    CommonLib, Forms, tcConst,
  BusObjSales,
  MySQLConst, frmAllocation, AppEnvironment,
  ProductQtyLib, TransactionSequence, FastFuncs, CommonFormLib ,
  ProcessDataUtils, SalesOrderLib, frmSimpleTypes, tcDataUtils, ManufactureLib,
  DateUtils, LogLib;

const
  VALIDATE_FOR_CONVERSION   = 1;
  DO_CONVERT_SO             = 2;
  VALIDATE_FOR_CHANGESTATUS = 3;
  LOCK_SALES                = 4;
  //VALIDATE_FOR_MERGESO      = 5;

procedure TSalesOrderListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin
        GroupFilterString := 'Converted <> ' + QuotedStr('T');
      end;
    1:
      begin
        GroupFilterString := 'FutureSO = ' + QuotedStr('T');
      end;
    2:
      begin
        GroupFilterString := 'Converted = ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

procedure TSalesOrderListGUI.RefreshTotals;
begin
  Calcnshowfooter;
(*var
  TotalTax, TotalEx,TotalInc: double;
  Bookmark: TBookmark;
begin
  TotalEx := 0;
  TotalInc := 0;
  TotalTax := 0;
  qryMain.DisableControls;
  Bookmark := qryMain.GetBookmark;
  try
    with qryMain do begin
      First;
      while not Eof do begin
        TotalTax := TotalTax + qryMainTotalTax.AsCurrency;
        TotalEx := TotalEx + qryMainTotalAmountEx.AsCurrency;
        TotalInc := TotalInc + qryMainTotalAmountInc.AsCurrency;
        Next;
      end;
    end;
  Finally
    qryMain.GotoBookmark(Bookmark);
    qryMain.FreeBookmark(Bookmark);
    qryMain.EnableControls;
  end;

  grdMain.ColumnByName(qryMainTotalTax.fieldname).FooterValue := FloatToStrF(TotalTax, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName(qryMainTotalAmountEx.fieldname).FooterValue := FloatToStrF(TotalEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName(qryMainTotalAmountInc.fieldname).FooterValue := FloatToStrF(TotalInc, ffCurrency, 15, CurrencyRoundPlaces);*)
end;

procedure TSalesOrderListGUI.setClientID(const Value: Integer);
begin
  fiClientId := Value;
  //Qrymain.Parambyname('ClientId').asInteger := Value;
end;

procedure TSalesOrderListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('IsLayBy');
  RemoveFieldfromGrid('ID');
end;

procedure TSalesOrderListGUI.RefreshQuery;
begin
  PopulateData;
  inherited;
end;

procedure TSalesOrderListGUI.CmdBackordersClick(Sender: TObject);
var
  BackOrderSO: TBackOrderSOGUI;
begin
  DisableForm;
  try
    inherited;
    BackOrderSO := TBackOrderSOGUI(GetComponentByClassName('TBackOrderSOGUI'));
    if Assigned(BackOrderSO) then begin
      BackOrderSO.FormStyle := fsMDIChild;
      BackOrderSO.BringToFront;
      Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderListGUI.cmdNewClick(Sender: TObject);
begin
    OpenERPForm('TSalesOrderGUI' , 0);
end;

procedure TSalesOrderListGUI.chkLayByClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
  btnGrid.Enabled := chkLayby.Checked;
  if chkLayBy.Checked then pnlHeader.Caption := 'LayBy List'
  else pnlHeader.Caption := 'Sales Order List';
end;

procedure TSalesOrderListGUI.FormShow(Sender: TObject);
begin
  if chkLayBy.Checked then pnlHeader.Caption := 'LayBy List'
  else pnlHeader.Caption := 'Sales Order List';
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'ClientId,EmployeeId');
  qryMain.First;
  //if fbFormOpenedOk then RefreshTotals;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnSOToInvoice') <> 1 then
    Grdmain.Options :=Grdmain.Options - [dgMultiSelect];
end;

procedure TSalesOrderListGUI.FormCreate(Sender: TObject);
begin
  fstablename := GetUserTemporaryTableName('SOList');
  Qrymain.SQL.clear;
  Qrymain.SQL.add( 'Select  ');
  Qrymain.SQL.add( '* ');
  Qrymain.SQL.add( 'from '+fsTablename);
  inherited;

  AddcalcColumn(qryMainTotalTax.fieldname , true);
  AddcalcColumn(qryMainTotalAmountEx.fieldname, true);
  AddcalcColumn(qryMainTotalAmountInc.fieldname, true);


  SingleInvoice := False;
  InvalidRecordselected:= False;
  //Qrymain.Parambyname('ClientId').asInteger := 0;
  ShowChartViewOnPopup := True;
  if (not Assigned(Owner)) or (not (Owner is TForm)) then begin
    {only do this if the list not owned by another form, ie embeded}
    fbEnableWebSearch := true;
  end;
end;
procedure TSalesOrderListGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  inherited;

end;

Function TSalesOrderListGUI.DoProductallocation(const LineObj :TProdQty):Boolean ;
begin
      LineObj.postdb;
      Result := TfmAllocation.DoBinBatchform(LineObj.PQA, self );
end;
function TSalesOrderListGUI.ExpressDetailListName: String;
begin
  REsult := 'TSalesorderListExpressGUI';
end;

procedure TSalesOrderListGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);
var
  ErrMsg:String;
  invID:Integer;
begin
    {Validate for conversion }
    if IterateProcNo = VALIDATE_FOR_CONVERSION then begin
      if not  SalesorderLib.IsOkToconvert(QrymainSaleId.asInteger, errMsg) then begin
        if errMsg<> '' then MessageDlgXP_Vista(ErrMsg, mtWarning, [mbOK], 0);
        grdmain.UnselectRecord;
      end;

      with Tsalesorder.CreateWithNewConn(nil) do try
        Load(QrymainSaleId.asInteger);
        UserLock := Self.userlock;
        if not(Lock) then begin
          ErrMsg:= replacestr(userlock.LockMessage , 'Unable to update data.' ,'Unable to convert Sales Order #' + inttostr(QrymainSaleId.asInteger) +' into invoice.');
          exit;
        end;
      finally
        Free;
      end;

    {convert the selected salesorder and all its associated BOs}
    end else if IterateProcNo = DO_CONVERT_SO then begin
      invId:= SalesOrderlib.ConvertSo(QrymainSaleID.asInteger, self , DoProductallocation);
      if invId<> 0 then
        invIdsList.add(invId);
    end else if IterateProcNo = VALIDATE_FOR_CHANGESTATUS then begin
      if QrymainConverted.asBoolean then begin
        InvalidRecordselected:= True;
        grdmain.UnselectRecord;
      end;
    end else if IterateProcNo = LOCK_SALES then begin
      if UserLock.Lock('tblsales', qrymainSaleId.asInteger, Self.Caption) then
          ChangeStatusSQL.add('update tblSales Set QuoteStatus = ' +quotedstr(NewStatus)+' where SaleId = ' +inttostr(QrymainSaleId.asInteger)+';');
(*    end else if IterateProcNo = VALIDATE_FOR_MERGESO then begin
      if not IsOktoMerge then begin
        InvalidRecordselected := true;
        abort := True;
    end;*)
end;
end;
procedure TSalesOrderListGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
end;
procedure TSalesOrderListGUI.actInvoiceExecute(Sender: TObject);
var
  Invoiceoption:Word;
  SOs:Integer;
  ctr:Integer;
begin
  DisableForm;
  try
    if grdMain.SelectedList.Count < 1 then begin
        CommonLib.MessageDlgXP_Vista(
                'You must at least pick one sales order before converting to an invoice.  Hold down the Ctrl Key and left click with your mouse to choose orders',
                mtInformation, [mbOK], 0);
        Exit;
    end;


    SingleInvoice := False;
    IterateProcNo := VALIDATE_FOR_CONVERSION;
    IterateselectedRecordsReverse(true, WaitMsg);
    if grdMain.SelectedList.Count < 1 then exit;

    if grdMain.SelectedList.Count =1 then begin
      if CommonLib.MessageDlgXP_Vista('Are you sure you want to convert the selected Sales Order and its associated Backorder(s) to Invoice(s)?',mtInformation, [mbYes,mbNo], 0) = mrNo then Exit;
    end else begin
      {make one of the selected row as current if not}
      if grdmain.IsSelectedRecord = False then
        qryMain.GoToBookmark(grdMain.SelectedList.Items[0]);

      Invoiceoption := CommonLib.MessageDlgXP_Vista('You have selected ' + inttostr(grdMain.SelectedList.Count) +' Sales Orders.'+NL+
                                                    'Would you like to make one invoice for all combined or separate invoices', mtconfirmation , [] , 0 , nil , '' , '' , False , nil ,
                                                    'Separate Invoices,Combine All to SO # ' + inttostr(QrymainSaleID.AsInteger)+' and convert to Single Invoice,Cancel');
      if Invoiceoption = 102 then exit;
      SingleInvoice := Invoiceoption = 101;
    end;

    (*if (grdMain.SelectedList.Count >1) and (IsOktoMergeallSOsSelected) then begin
      Invoiceoption := CommonLib.MessageDlgXP_Vista('You have selected ' + inttostr(grdMain.SelectedList.Count) +' Sales Orders of Customer ' +Quotedstr(QrymainCustomername.AsString) +'.'+NL+
                                                    'Would you like to make one invoice for all combined or separate invoices', mtconfirmation , [] , 0 , nil , '' , '' , False , nil ,
                                                    '"Separate Invoices" , "All on One invoice with the Header Details of SO # ' + inttostr(fiSaleIDtoconvert)+'", "Cancel"');
      if Invoiceoption = 102 then exit;
      SingleInvoice := Invoiceoption = 101;
    end else if (grdMain.SelectedList.Count >1) then begin
      if CommonLib.MessageDlgXP_Vista('You have selected multiple Sales Orders.'+NL +
                                          'Sales orders of the same customers and FX rates with no back orders associated with it can be merged into one invoice and ' +fsOktoMergeMsg+'.' +
                                          'Do you want to convert all selected Sales Order(s) and its associated Backorder(s) to different Invoice(s)?',mtInformation, [mbYes,mbNo], 0) = mrNo then Exit;
    end else if CommonLib.MessageDlgXP_Vista('Are you sure you want to convert the selected Sales Order and its associated Backorder(s) to Invoice(s)?',mtInformation, [mbYes,mbNo], 0) = mrNo then Exit;*)
    SOs:=grdMain.SelectedList.Count ;
    if SingleInvoice and (grdMain.SelectedList.Count >1)  then begin
      With TSalesorder.CreateWithNewConn(nil) do try
        BusObjEvent := DoBusinessObjectEvent;
        Load(QrymainSaleID.AsInteger);
        if MergeSale(Selectedids('SaleID')) then begin
          RefreshQuery;
          Qrymain.Locate('SaleId' , ID , []);
          grdmain.UnselectAll;
          grdmain.SelectRecord;
        end else begin
          MessageDlgXP_Vista('None of the Sales Orders can be merged into ' + NL+'SalesOrder # ' + inttostr(ID)+'.  Conversion cancelled.' , mtWarning, [mbOK], 0);
          Exit;
        end;
      finally
        Free;
      end;
    end;

    IterateProcNo := DO_CONVERT_SO;
    invIdsList:=TIntegerList.create;
    try
      IterateselectedRecords(true, WaitMsg);
    finally
      if invIdsList.count>0 then begin
        if MessageDlgXP_Vista(inttostr(invIdsList.count) +' Invoice(s) Created for ' + inttostr(SOs)+ ' Sales Order(s).' + NL +
                              'Do you want to view the invoice(s) created', mtconfirmation , [mbyes, mbno], 0) = mryes then begin
          for ctr:= 0 to invIdsList.count-1 do begin
                if fsModal in FormState then
                  OpenERPFormModal('TInvoiceGUI' , invIdsList[ctr])
                else  begin
                  OpenERPForm('TInvoiceGUI' , invIdsList[ctr]);
                  SleepUntilFormshown('TInvoiceGUI');
                end;
          end;
        end;
      end;
      Freeandnil(invIdsList);
    end;
  finally
    EnableForm;
    fiSaleIDtoconvert := 0;
    fiMergingSODeptID:=0;
    fsForeignExchangeCode:= '';
    fdForeignExchangeRate:=0;
  end;
end;

procedure TSalesOrderListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if fiSaleIDtoconvert <> 0 then
    if QrymainsaleId.asInteger = fiSaleIDtoconvert then Abrush.Color := $00BBFFBB;
end;

procedure TSalesOrderListGUI.grdMainDblClick(Sender: TObject);
begin
(*
  if qryMainIsLayBy.asBoolean then
{Binny : Don't comment this if
Laybys PQA transtype is "TPOSLaybyLines",
opening this in Salesorder form will open the transaction as SalesOrder and expects PQA with transtype "TSalesOrderLines" and makes duplicate PQA
This was one of the reason for "Creating duplicate PQA" issue }
    CommonLib.MessageDlgXP_Vista('This is a Layby Sales Order - Not Possible to View.', mtInformation, [mbOK], 0)
*)
  if qryMainIsLayBy.asBoolean then
    OpenERPForm('TLaybyGUI', qryMainSaleID.AsInteger)
  else
    inherited;
end;

procedure TSalesOrderListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('SaleDate') + ' DESC CIS ; ' + QuotedStr('SaleID') + ' DESC CIS';
  BaseIndexFieldNames := QuotedStr('SaleID') + ' DESC CIS';
end;

procedure TSalesOrderListGUI.actExecuteFilterExecute(Sender: TObject);
begin
  inherited;
  //RefreshTotals;
end;

procedure TSalesOrderListGUI.actClearFilterExecute(Sender: TObject);
begin
  inherited;
  //RefreshTotals;
end;

procedure TSalesOrderListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderListGUI.cmdCloseClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TSalesOrderListGUI.btnPrintTreeClick(Sender: TObject);
var
  s:String;
  Tablename:String;
begin
  inherited;
  tablename := GetUserTemporaryTableName('salesOrderPrintTree');
  s:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN ' +
        ' FROM tblCompanyInformation AS CO ' +
        ' ~|||~{Details}' + salesPrintTreeSQLWithNodeSelected(Tablename, salesPrintTreeSQL(qryMainSaleID.asString(*,Tablename*)))+
        ' ~|||~{Sales}Select S.* , C.Phone , C.FaxNumber , C.Mobile from tblSales S inner join tblclients C on C.clientId = S.clientId where S.SaleId =  ' +IntToStr(qryMainSaleID.asInteger)+
        ' ~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,   Sum(TTCL.`TaxAmount`) TaxAmount from tblsalestaxcodelines TTCL  inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID  '+
              ' Where TTC.SaleId = ' + IntToStr(qryMainSaleID.asInteger) +' group by TTCL.`SubTaxCode`'+
        ' ~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value ' +
              ' from  tblsales Trans' +
              ' inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID' +
              ' inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId' +
              ' where ifnull(CCV.Value,"")<>"" and CFL.ListType = "ltCustomer" and Trans.SaleId = ' + IntToStr(qryMainSaleID.asInteger) +
        ' ~|||~{ShippingAddress}select SA.* from tblsales S inner join tblshippingaddress SA on S.ShipToID = SA.ShipAddressID where S.SaleId = ' + IntToStr(qryMainSaleID.asInteger) +
        ' ~|||~{ShippingDetails}Select * from  tblsalesshippingdetails where SalesId = ' + IntToStr(qryMainSaleID.asInteger);
  ReportSQLSupplied := true;
  PrintTemplateReport('sale tree'  , s , False , 1);
  ReportSQLSupplied := False;
  DestroyUserTemporaryTable(Tablename);
end;

procedure TSalesOrderListGUI.btnChangeStatusclick(Sender: TObject);
var
  s:String;
begin
  inherited;
  DisableForm;
  try
    if grdMain.SelectedList.Count < 1 then begin
        CommonLib.MessageDlgXP_Vista(
                'You must at least pick one sales order before changing the status.  Hold down the Ctrl Key and left click with your mouse to choose orders',
                mtInformation, [mbOK], 0);
        Exit;
    end;

    if AppEnv.AccessLevels.GetEmployeeAccessLevel('TSalesOrderGUI')>2  then begin{1: full access / 2:full access with no delete}
      CommonLib.MessageDlgXP_Vista('You don''t have access to change the Sales Order Status' , mtWarning, [mbok],0);
      exit;
    end;

    IterateProcNo := VALIDATE_FOR_CHANGESTATUS;
    InvalidRecordselected := False;
    IterateselectedRecordsReverse(true, WaitMsg);
    if grdMain.SelectedList.Count < 1 then begin
      if InvalidRecordselected then MessageDlgXP_Vista('Sales Orders Selected were all converted.  It is not possible to change the status of converted Sales Orders', mtWarning, [mbOK], 0);
      exit;
    end;
    s:= '';
    if InvalidRecordselected then s:= 'Converted Sales Orders are Removed from the selection as status of the Converted Sales Orders cannot be changed.'+chr(13)+chr(13);
    if CommonLib.MessageDlgXP_Vista(s+ 'Are you sure you want to change the status of all selected Sales Order(s)?',mtInformation, [mbYes,mbNo], 0) = mrNo then Exit;

    InvalidRecordselected:= False;

    NewStatus:= getNewStatus;
    if NewStatus = '' then exit;

    if (SameText(newStatus ,'Approved')) then
      if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanApproveSalesOrder') <> 1 then begin
        CommonLib.MessageDlgXP_Vista( 'You don''t have Access to Approve Sales Order', mtWarning, [mbok], 0);
        Exit;
      end;

    if (SameText(NewStatus ,'Delivered')) then
      if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanDeliverSalesOrder') <> 1 then begin
        CommonLib.MessageDlgXP_Vista( 'You don''t have Access to Deliver Sales Order', mtWarning, [mbok], 0);
        Exit;
      end;

    IterateProcNo := LOCK_SALES;
    UserLock := TUserLock.Create(Self);
    try
      ChangeStatusSQL:= TStringlist.create;
      try
        IterateselectedRecords(true, WaitMsg);
        if changeStatusSQL.count >0 then begin
          ExecuteSQL(ChangeStatusSQl.text);
        end;
      finally
        FreeandNil(ChangeSTatusSQL);
      end;
    finally
      Userlock.Unlock(Self.Caption);
      FreeandNil(UserLock);
    end;
  finally
    EnableForm;
  end;

end;
Function TSalesOrderListGUI.getNewStatus:String;
begin
  result := GetSimpleType(TfmSimpleTypes.DoSimpleTypesSelect('LeadStatusType'));
end;
procedure TSalesOrderListGUI.OpenTransactionSequence;
begin

  if(Qrymainbaseno.asString = '') and (Qrymainboid.asString = '') then begin
    MessageDlgXP_Vista('Sales Order # ' +IntToStr(QrymainSaleID.asInteger) +' Has No BackOrder Associated with it' , mtInformation , [mbok],0);
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

procedure TSalesOrderListGUI.PopulateData;
begin
  With ScriptMain do begin
    With SQL do begin
      Clear;
      Add('Drop table if exists ' + fstablename +';');
      Add('Create table ' + fstablename +' ('+
            ' `ID` INT NOT NULL AUTO_INCREMENT, '+
            ' baseno              VARCHAR(255) DEFAULT NULL,'+
            ' boID                VARCHAR(255) DEFAULT NULL,'+
            ' SaleDate            DATETIME DEFAULT NULL,'+
            ' ShipDate            DATETIME DEFAULT NULL,'+
            ' ShipVia             VARCHAR(255) DEFAULT NULL,'+
            ' SalesCategory       VARCHAR(255) DEFAULT NULL,'+
            ' QuoteStatus         VARCHAR(255) DEFAULT NULL,'+
            ' IsLayBy             ENUM("T","F")  NULL DEFAULT "F",'+
            ' Type                VARCHAR(50)  NULL DEFAULT "",'+
            ' CustomerName        VARCHAR(100) DEFAULT NULL,'+
            ' Printname           VARCHAR(100) DEFAULT NULL,'+
            ' Jobname             VARCHAR(100) DEFAULT NULL,'+
            ' CustomerJobNumber   VARCHAR(100) DEFAULT NULL,'+
            ' JobNumber           VARCHAR(100) DEFAULT NULL,'+
            ' CustomerType        VARCHAR(50) DEFAULT NULL,'+
            ' GlobalRef           VARCHAR(255) DEFAULT NULL,'+
            ' Originalref         VARCHAR(255)  NULL DEFAULT "",'+
            ' SalesOrderNumber    VARCHAR(30) DEFAULT NULL,'+
            ' PONumber            VARCHAR(30) DEFAULT NULL,'+
            ' Converted           ENUM("T","F")  NULL DEFAULT "F",'+
            ' Deleted             ENUM("T","F")  NULL DEFAULT "F",'+
            ' TotalAmountEx       DOUBLE  NULL DEFAULT 0,'+
            ' TotalTax            DOUBLE  NULL DEFAULT 0,'+
            ' TotalAmountInc      DOUBLE  NULL DEFAULT 0,'+
            ' Balance             DOUBLE  NULL DEFAULT 0,'+
            ' EmployeeName        VARCHAR(255) DEFAULT NULL,'+
            ' ConsignmentNote     VARCHAR(25) DEFAULT NULL,'+
            ' ClassName           VARCHAR(255) DEFAULT NULL,'+
            ' ClassID             INT(11) DEFAULT NULL,'+
            ' Terms               VARCHAR(255) DEFAULT NULL,'+
            ' Held                ENUM("T","F")  NULL DEFAULT "F",'+
            ' EmployeeID          INT(11) DEFAULT NULL,'+
            ' ClientID            INT(11)  NULL DEFAULT 0,'+
            ' SaleID              INT(11)  NULL DEFAULT 0,'+
            ' ConvertFromQuote    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD1    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD2    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD3    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD4    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD5    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD6    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD7    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD8    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD9    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD10    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD11    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD12    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD13    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD14    VARCHAR(255) DEFAULT NULL ,'+
            ' CUSTFLD15    VARCHAR(255) DEFAULT NULL ,'+
            ' FutureSO            ENUM("T","F")  NULL DEFAULT "F",'+
            ' DueDate             DATETIME DEFAULT NULL,'+
            ' class               VARCHAR(255) DEFAULT NULL,'+
            ' Rep                 VARCHAR(255) DEFAULT NULL,'+
            ' Comments            VARCHAR(255) DEFAULT NULL,'+
            ' Attrib1Sale         DOUBLE  DEFAULT  0.0,'+
            ' Attrib2Sale         DOUBLE  DEFAULT  0.0,'+
            ' Attrib1SaleRate     DOUBLE  DEFAULT  0.0,'+
            ' IsLayByTOS          ENUM("T","F")  NULL DEFAULT "F",'+
            ' ShipTo              VARCHAR(255) DEFAULT NULL,'+
            ' SalesOrderStatus    VARCHAR(255) DEFAULT NULL,'+
            ' PlannedDelFrom      DATETIME DEFAULT NULL,'+
            ' PlannedDelto        DATETIME DEFAULT NULL,'+
            ' PromisedDel         DATETIME DEFAULT NULL,'+
            ' CauseofDelay        VARCHAR(255) DEFAULT NULL,'+
            ' ActualDel           DATETIME DEFAULT NULL,'+
            ' DeliveryFeedBack    VARCHAR(255),'+
            ' ForeignExchangeCode VARCHAR(10) DEFAULT NULL,'+
            ' ForeignExchangeRate DOUBLE  NULL DEFAULT 0,'+
            ' SalesPrePayments    DOUBLE DEFAULT NULL,'+
            ' Progresspayments    DOUBLE DEFAULT NULL,'+
            ' 	PRIMARY KEY (`ID`),'+
            ' 	INDEX `SaleID` (`SaleID`),'+
            '  Index GlobalRef (GlobalRef) , ' +
            ' 	INDEX `ClientId` (`ClientId`)'+
            '  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;');

      Add('Insert ignore into ' + fstablename +' (baseno,boID,SaleDate,ShipDate,ShipVia,SalesCategory,QuoteStatus,IsLayBy,Type,CustomerName,'#13#10 +
          ' GlobalRef,Originalref,SalesOrderNumber,PONumber,Converted,Deleted,TotalAmountEx,TotalTax,TotalAmountInc,'#13#10 +
          ' Balance,EmployeeName,ConsignmentNote,ClassName,ClassID,Terms,Held,EmployeeID,ClientID,SaleID,ConvertFromQuote,'+
          (*'CUSTFLD1,'+
          'CUSTFLD2,'+
          'CUSTFLD3,'+
          'CUSTFLD4,'+
          'CUSTFLD5,'+
          'CUSTFLD6,'+
          'CUSTFLD7,'+
          'CUSTFLD8,'+
          'CUSTFLD9,'+
          'CUSTFLD10,'+
          'CUSTFLD11,'+
          'CUSTFLD12,'+
          'CUSTFLD13,'+
          'CUSTFLD14,'+
          'CUSTFLD15,'+*)
          'FutureSO,'#13#10 +
          ' DueDate,class,Rep,Comments,Attrib1Sale,Attrib2Sale,Attrib1SaleRate,IsLayByTOS,ShipTo,SalesOrderStatus,'#13#10 +
          //' PlannedDelFrom,PlannedDelto,PromisedDel,CauseofDelay,ActualDel,DeliveryFeedBack,'+
          ' ForeignExchangeCode,ForeignExchangeRate ) '#13#10 +
          ' SELECT' +
          ' S.baseno,' +
          ' S.boID,' +
          ' S.SaleDate         as "SaleDate",' +
          ' S.ShipDate         as "ShipDate",' +
          ' S.Shipping         as ShipVia,' +
          ' S.SalesCategory    as SalesCategory,' +
          ' S.QuoteStatus      as QuoteStatus,' +
          ' S.IsLayByTOS       as IsLayBy,'#13#10 +
          ' If(S.IsSalesOrder="T","Sales Order",If(S.IsLayByTOS="T","LayBy","Invoice")) as Type,' +
          SplitField('S', 'CustomerName', 1)+' as "CustomerName" ,' +
          //' TypeName           as CustomerType,' +
          ' S.GlobalRef        as "GlobalRef" ,'#13#10 +
          ' S.OriginalNo       as "Originalref",' +
          ' S.InvoiceDocNumber as "SalesOrderNumber" ,' +
          ' S.PONumber         as "PONumber",' +
          ' S.Converted        as Converted,' +
          ' S.Deleted          as Deleted,' +
          ' S.TotalAmount      as "TotalAmountEx",'#13#10 +
          ' S.TotalTax         as "TotalTax",' +
          ' S.TotalAmountInc   as "TotalAmountInc" ,' +
          ' S.Balance          as "Balance" ,' +
          ' S.EmployeeName     AS "EmployeeName",'#13#10 +
          ' S.ConNote          as "ConsignmentNote",' +
          ' S.Class            as "ClassName",' +
          ' s.ClassID          as ClassID,' +
          ' S.Terms            as Terms,' +
          ' S.HoldSale         as Held,' +
          ' S.EmployeeID       as EmployeeID,'#13#10 +
          ' S.ClientID         as ClientID,' +
          ' S.SaleID           as SaleID,' +
          ' S.QuoteGlobalRef   as ConvertFromQuote,' +
          (*' S.CUSTFLD1   as CUSTFLD1,' +
          ' S.CUSTFLD2   as CUSTFLD2,' +
          ' S.CUSTFLD3   as CUSTFLD3,' +
          ' S.CUSTFLD4   as CUSTFLD4,' +
          ' S.CUSTFLD5   as CUSTFLD5,' +
          ' S.CUSTFLD6   as CUSTFLD6,' +
          ' S.CUSTFLD7   as CUSTFLD7,' +
          ' S.CUSTFLD8   as CUSTFLD8,' +
          ' S.CUSTFLD9   as CUSTFLD9,' +
          ' S.CUSTFLD10   as CUSTFLD10,' +
          ' S.CUSTFLD11   as CUSTFLD11,' +
          ' S.CUSTFLD12   as CUSTFLD12,' +
          ' S.CUSTFLD13   as CUSTFLD13,' +
          ' S.CUSTFLD14   as CUSTFLD14,' +
          ' S.CUSTFLD15   as CUSTFLD15,' +*)
          ' S.FutureSO,'#13#10 +
          ' S.DueDate,' +
          ' S.Class            as class,' +
          ' S.Employeename     as Rep,' +
          ' SUBSTRING(S.Comments,1,255) as Comments ,'#13#10 +
          ' SL.Attrib1Sale ,' +
          ' SL.Attrib2Sale ,' +
          ' SL.Attrib1SaleRate,' +
          ' S.IsLayByTOS       as IsLayByTOS,'#13#10 +
          ' S.ShipTo           as ShipTo,' +
          ' S.QuoteStatus      as SalesOrderStatus ,' +
          (*' SDD.PlannedDelFrom as PlannedDelFrom,' +
          ' SDD.PlannedDelto   as PlannedDelto ,' +
          ' SDD.PromisedDel    as PromisedDel,' +
          ' SDD.CauseofDelay   as CauseofDelay ,' +
          ' SDD.ActualDel      as ActualDel ,' +
          ' SDD.FeedBack       as DeliveryFeedBack,' +*)
          ' S.ForeignExchangeCode as ForeignExchangeCode,' +
          ' S.ForeignExchangeRate as ForeignExchangeRate'#13#10 +
          ' FROM tblSales S' +
          ' INNER JOIN tblSalesLines SL ON  S.SaleID = SL.SaleID'#13#10 +
          (*' INNER JOIN tblClients C ON S.ClientID = C.ClientID' +
          ' LEFT JOIN tblclienttype CT on CT.ClientTypeID = C.ClientTypeID' +
          ' LEFT JOIN tblsalesdeliverydetails SDD on SDD.SaleId = s.SAleID' +*)
          ' WHERE S.SaleDate Between ' +Quotedstr(FormatdateTime(mysqlDateTimeformat, filterdateFrom))+' AND ' +Quotedstr(FormatdateTime(mysqlDateTimeformat, filterdateTo))+' '#13#10 +
          (*' and S.IsRefund ="F" AND S.IsInvoice="F" AND SL.Invoiced="T" AND S.IsQuote="F"' +
          ' AND (S.IsCashSale="F" OR S.IsLayByTOS= "T")' +
          ' AND (S.IsSalesOrder= ' + Quotedstr(BooleantoString(not(chkLayBy.Checked ))) + ' OR S.IsLayByTOS= ' + Quotedstr(BooleantoString(not(chkLayBy.Checked ))) + ' )' +*)
          ' AND '+ iif(chkLayBy.Checked , ' S.IsLayByTOS= "T"' , 'S.IsSalesOrder= "T"') +
          IIF(fiClientId<> 0 , ' And S.clientId = ' + inttostr(fiClientId), '' )+
          #13#10' GROUP BY S.SaleID '+
          iif((edtSearch.Text = '') and (SearchMode <> smFullList),' Limit 0 ', '')+  // opening form in searchmode);
          ';');
(*      Add('Alter table '+ fsTablename +' add column SalesPrePayments double;');
      Add('Alter table '+ fsablename +' add column Progresspayments double;');*)
      Add('update ' +fstablename +' T inner join tblclients C on C.clientId = T.clientId  left JOIN tblclienttype CT on CT.ClientTypeID = C.ClientTypeID '+
                    ' Set T.CustomerType = CT.TypeName , '+
                    ' T.CUSTFLD1   = C.CUSTFLD1,' +
                    ' T.CUSTFLD2   = C.CUSTFLD2,' +
                    ' T.CUSTFLD3   = C.CUSTFLD3,' +
                    ' T.CUSTFLD4   = C.CUSTFLD4,' +
                    ' T.CUSTFLD5   = C.CUSTFLD5,' +
                    ' T.CUSTFLD6   = C.CUSTFLD6,' +
                    ' T.CUSTFLD7   = C.CUSTFLD7,' +
                    ' T.CUSTFLD8   = C.CUSTFLD8,' +
                    ' T.CUSTFLD9   = C.CUSTFLD9,' +
                    ' T.CUSTFLD10   = C.CUSTFLD10,' +
                    ' T.CUSTFLD11   = C.CUSTFLD11,' +
                    ' T.CUSTFLD12   = C.CUSTFLD12,' +
                    ' T.CUSTFLD13   = C.CUSTFLD13,' +
                    ' T.CUSTFLD14   = C.CUSTFLD14,' +
                    ' T.CUSTFLD15   = C.CUSTFLD15,' +
                    ' T.Printname = C.Printname, '+
                    ' T.Jobname = C.Jobname, '+
                    ' T.CustomerJobNumber = C.CustomerJobNumber, '+
                    ' T.JobNumber = C.JobNumber;');
      Add('update ' +fstablename +' T inner JOIN tblsalesdeliverydetails SDD on SDD.SaleId = T.SAleID '+
                    ' Set '+
                    ' T.PlannedDelFrom  = SDD.PlannedDelFrom ,'+
                    ' T.PlannedDelto    = SDD.PlannedDelto   ,'+
                    ' T.PromisedDel     = SDD.PromisedDel,'+
                    ' T.CauseofDelay    = SDD.CauseofDelay,'+
                    ' T.ActualDel       = SDD.ActualDel,'+
                    ' T.DeliveryFeedBack= SDD.FeedBack;');

      Add('Drop table if exists ' + fstablename +'1;' );
      Add('Create table ' + fstablename +'1 ('+
            ' `ID` INT NOT NULL AUTO_INCREMENT, '+
            ' SaleId INT(11) , '+
            ' Amt DOUBLE ,'+
            ' 	PRIMARY KEY (`ID`),'+
            ' 	INDEX `SaleID` (`SaleID`)'+
            '  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;');

      Add('Insert ignore into ' + fstablename +'1 (SaleID, amt) ' +
          ' Select T.SaleId, Sum(IfNull(Prepays.PayAmount,0)) amt   '+
          ' from  '+ fsTablename +' T '+
          ' inner join tblsalesprepayments sPrepays on sPrepays.SalesRef = T.GlobalRef '+
          ' inner join tblprepayments Prepays on Prepays.GlobalRef = sPrepays.PrepayRef group by T.SaleID;  ' );

      Add('Update '+ fsTablename +' T inner join '+fsTablename+'1 as T1 on T.saleId = T1.SaleId Set  T.SalesPrePayments = T1.Amt;');

      Add('Drop table if exists ' + fstablename +'1;' );
      Add('Create table ' + fstablename +'1 ('+
            ' `ID` INT NOT NULL AUTO_INCREMENT, '+
            ' SaleId INT(11) , '+
            ' Amt DOUBLE ,'+
            ' 	PRIMARY KEY (`ID`),'+
            ' 	INDEX `SaleID` (`SaleID`)'+
            '  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;');

      Add('Insert ignore into ' + fstablename +'1 (SaleID, amt) ' +
          ' Select T.SaleId, Sum(IfNull(Progresspays.TotalAmountInc,0)) amt   '+
          ' from  '+ fsTablename +' T '+
          ' inner join tblsales Progresspays on Progresspays.SOProgressPaymentGlobalRef = T.GlobalRef  group by T.SaleID;  ');
      Add('Update '+ fsTablename +' T inner join '+fsTablename+'1 as T1 on T.saleId = T1.SaleId Set  T.Progresspayments = T1.Amt;');

      Add('Update '+ fsTablename +' T Set Balance = ifnull(Balance,0)- ifnull(SalesPrePayments,0)- ifnull(Progresspayments,0);' );
      Add('Drop table if exists ' + fstablename +'1;');
    end;
    clog(SQLText);
    SQL.text := ChangeQuery(SQL.text);
    DoShowProgressbar(SQL.Count, WAITMSG);
    try
      Execute;
    finally
      DoHideProgressbar;
    end;
  end;
end;

procedure TSalesOrderListGUI.TransactionSequenceBeforeshow(
  Sender: TObject);
begin
   if not(Sender is TTransactionSequenceGUI) then exit;
   TTransactionSequenceGUI(Sender).Originalglobalref := qryMainOriginalref.asString;
   TTransactionSequenceGUI(Sender).GlobalRef := qryMainGlobalref.asString;
   TTransactionSequenceGUI(Sender).Transtype := 'SO'
end;

procedure TSalesOrderListGUI.actInvoiceUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := AppEnv.AccessLevels.GetEmployeeAccessLevel('FnSOToInvoice') =1;
end;

(*function TSalesOrderListGUI.IsOktoMergeallSOsSelected: Boolean;
begin
  IterateProcNo := VALIDATE_FOR_MERGESO;
  fiSaleIDtoconvert := QrymainSaleID.AsInteger;
  fiMergingSOclientID:=QrymainclientID.AsInteger;
  fiMergingSODeptID:=QrymainclientID.AsInteger;
  fsForeignExchangeCode:= qrymainForeignExchangeCode.asString;
  fdForeignExchangeRate:=QrymainForeignExchangeRate.asFloat;
  InvalidRecordselected := False;
  IterateselectedRecords(true, WaitMsg);
  REsult := not(InvalidRecordselected);
end;*)
(*function TSalesOrderListGUI.IsOktoMerge: Boolean;
begin

  if(fiMergingSOclientID<> QrymainclientID.AsInteger) then begin
    fsOktoMergeMsg := 'SO # ' + inttostr(QrymainSaleID.asInteger) +' has a differnet customer ' + Quotedstr(qryMainCustomerName .asString);
    Result:= False;
    Exit;
  end;
  if(fiMergingSODeptID<> qryMainclassID.AsInteger) then begin
    fsOktoMergeMsg := 'SO # ' + inttostr(QrymainSaleID.asInteger) +' has a differnet ' + Appenv.DefaultClass.classheading +' ' + Quotedstr(qryMainCustomerName .asString);
    Result:= False;
    Exit;
  end;
  if (fsForeignExchangeCode <> qrymainForeignExchangeCode.asString) or
    (fdForeignExchangeRate <> QrymainForeignExchangeRate.asFloat) then begin
    fsOktoMergeMsg := 'SO # ' + inttostr(QrymainSaleID.asInteger) +' has a differnet FX ' + Quotedstr(qrymainForeignExchangeCode.asString +' (' + FloatToStrF(QrymainForeignExchangeRate.asFloat , ffGeneral , 15, 2)+')' );
    REsult:=False;
    Exit;
  end;
  if QrymainBOID.AsString <> '' then begin
    fsOktoMergeMsg := 'SO # ' + inttostr(QrymainSaleID.asInteger) +' has a backorder associated with it';
    REsult := False;
    Exit;
  end;
  if qryMainbaseno.AsString <> '' then begin
    fsOktoMergeMsg := 'SO # ' + inttostr(QrymainSaleID.asInteger) +' if a backorder';
    REsult := False;
    Exit;
  end;
  Result:= True;
end;*)

procedure TSalesOrderListGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenTransactionSequence;
end;


initialization
  RegisterClassOnce(TSalesOrderListGUI);
end.
