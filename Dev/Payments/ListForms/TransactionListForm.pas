unit TransactionListForm;

{
 Date     Version  Who  What
 -------- -------- ---  --------------------------------------------------------
 04/08/05  1.00.01 IJB  Added PrepaymentID into persistant field list so
                        Prepayments can be opened by double clicking on grid.

}

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, wwdblook, wwcheckbox, kbmMemTable, Mask, DBCtrls, Math,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  Shader, BaseInputForm,
  DAScript, MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg,TransactionListBase , TransactionListSQL;


type
  TTransactionListGUI = class(TTransactionListBaseGUI)
    qryMainDate: TDateField;
    qryMainGlobalRef: TWideStringField;
    qryMainType: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainAccountID: TIntegerField;
    qryMainDebitsEx: TFloatField;
    qryMainEXDiff: TFloatField;
    qryMainIncDiff: TFloatField;
    qryMainCreditsEx: TFloatField;
    qryMainDebitsInc: TFloatField;
    qryMainCreditsInc: TFloatField;
    qryMainClientName: TWideStringField;
    qryMainCompanyName: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainCustomerJobName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainProductDesc: TWideStringField;
    qryMainTaxCode: TWideStringField;
    qryMainAccountType: TWideStringField;
    qryMainAccountNumber: TWideStringField;
    lblbalance: TLabel;
    edtBalanceex: TEdit;
    Label5: TLabel;
    Edit1: TEdit;
    edtBalanceinc: TEdit;
    btnback: TDNMSpeedButton;
    btnFront: TDNMSpeedButton;
    btnfinddiff: TDNMSpeedButton;
    btnchecktrans: TDNMSpeedButton;
    qryMainTransTimeStamp: TDateTimeField;
    qryMainEmployeeName: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainMemo: TWideStringField;
    btnGlobalreffilter: TDNMSpeedButton;
    lblREfreshInfo: TLabel;
    btnExpressDetail: TDNMSpeedButton;
    qryMainCLASSID: TLargeintField;
    qryMainSALEID: TLargeintField;
    qryMainPURCHASEORDERID: TLargeintField;
    qryMainPAYMENTID: TLargeintField;
    qryMainJobNumber: TLargeintField;
    qryMainSeqno: TLargeintField;
    qryMainPREPAYMENTID: TLargeintField;
    qryMainFIXEDASSETID: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    //procedure chkAllClassClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure actClearFilterExecute(Sender: TObject);
    procedure chkOptionClick(Sender: TObject);
    procedure btnbackClick(Sender: TObject);
    procedure btnFrontClick(Sender: TObject);
    procedure btnfinddiffClick(Sender: TObject);
    procedure btnchecktransClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnGlobalreffilterClick(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
  private
    TotalsQry: TERPQuery;
    ForeignCurrencyFieldCount: integer;
    findingdiff:boolean;
    fbFormshown:Boolean;
    ClassIDUsed :Integer;
    filterindex :Integer;
    xDateFrom : TDateTime;
    xdateTo   : TDateTime;
    Procedure showDiff;
    procedure RefreshAll;
    Procedure ToBeRefreshed;

  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
    Procedure SetGridColumns;Override;
    Procedure MakeQryMain;Virtual;
    procedure ApplyQueryFilter;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure OnRefreshQueryOutOfMemoryError(Sender: TObject);Override;
    Function TransListtype : TTransListtype;Override;
  public
  end;

implementation

uses StrUtils, Forms, AppEnvironment, CommonLib, CommonDbLib, FastFuncs,
  busobjStockMovement, BusobjStockAdjustEntry, busobjstockTransferentry,
  tcConst, SyncReportTableObj, BusObjSaleBase, SalesConst, BusobjCustomFilter ,
  DateUtils,  tcDataUtils, LogLib, MySQLConst, TransactionListDetails,
  DbSharedObjectsObj;

{$R *.dfm}

procedure TTransactionListGUI.FormCreate(Sender: TObject);
begin
  //fsTablename := CommonDbLib.GetUserTemporaryTableName('tmp_transactionjournal' );
  findingdiff := False;
  btnchecktrans.visible := devmode;
  edtBalanceex.visible := devmode;
  edtBalanceinc.visible := devmode;
  lblbalance.visible := devmode;
  ForeignCurrencyFieldCount:= -1;
  fbFormshown:= False;
  fbEnableWebSearch := true;
  ReportonForeignCurrency := true;
  inherited;
  SelectionOption := soClass;
  Addcalccolumn(Qrymain.fieldbyname('debitsex').FieldName , true);
  Addcalccolumn(Qrymain.fieldbyname('creditsEx').FieldName , true);
  Addcalccolumn(Qrymain.fieldbyname('debitsinc').FieldName , true);
  Addcalccolumn(Qrymain.fieldbyname('creditsinc').FieldName , true);
  Addcalccolumn(Qrymain.fieldbyname('EXDiff').FieldName , true);
  Addcalccolumn(Qrymain.fieldbyname('IncDiff').FieldName , true);
  TransactionListReport.CreateReportTable;
  MakeQrymain;
  EnableClosingDateBalanceCheck:= True;
  showFCFooters := true;
  if ErrorOccurred then Exit;
  //cboClassQry.Connection := qryMain.Connection;
  ShowChartViewOnPopup := True;
end;


procedure TTransactionListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  findingdiff:= false;
end;

procedure TTransactionListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if grpfilters.itemindex =0 then
    if not(samevalue(Qrymain.fieldbyname('debitsex').asfloat , Qrymain.fieldbyname('creditsEx').asfloat,0.01)) or
       not(samevalue(Qrymain.fieldbyname('debitsinc').asfloat , Qrymain.fieldbyname('creditsinc').asfloat,0.01)) then AFont.color := clred;
end;

procedure TTransactionListGUI.grdMainDblClick(Sender: TObject);
begin

  if devmode then begin
    if sametext(Activefieldname , qryMainGlobalref.fieldname) then begin
      if (globalref <>qryMainGlobalref.asString) then globalref :=qryMainGlobalref.asString else globalref :='';
      RefreshAll;
      Exit;
    end;

    if grpFilters.itemindex =0 then
      if sametext(Activefieldname , qryMainEXDiff.fieldname) or
         sametext(Activefieldname , qryMainIncDiff.fieldname) then begin
        TTransactionListDetailsGUI.DoTransactionListDetails(fsTablename,qrymaintype.AsString, qrymainglobalref.asString);
        exit;
      end;
  end;


       if (Sysutils.SameText(qryMainType.asString , TStockAdjustEntry.Transtype))  then SubsequentID := Chr(95) + AdjustType(QrymainSaleID.asInteger)   +  qryMain.Fields.FieldByName('Type').AsString
  else if (Sysutils.SameText(qryMainType.asString ,TStockTransferEntry.Transtype)) then SubsequentID := Chr(95) + TransferType(QrymainSaleID.asInteger) +  qryMain.Fields.FieldByName('Type').AsString
  else SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;

  if SameText(qryMain.Fields.FieldByName('Type').AsString,'Cash Sale') then begin
    case TSalesBase.GetSaleType(qryMain.Fields.FieldByName('SaleID').AsInteger) of
      stPOS,
      stPOSLayby,
      stPOSLaybyPayment,
      stPOSCashSale: SubsequentID := Chr(95) + 'POS';
    end;
  end;
  inherited;
end;

procedure TTransactionListGUI.grpFiltersClick(Sender: TObject);
begin
  if fbformshown then RefreshQuery;
end;

procedure TTransactionListGUI.makeQrymain;
var
  msg:String;
begin
  Qrymain.disablecontrols;
  try
    closedb(qryMain);
(*    Qrymain.SQL.clear;
      Qrymain.SQL.add('select ');
      Qrymain.SQL.add('`transID` as `transID` ,');
      Qrymain.SQL.add('`DATE` as `DATE` ,');
      Qrymain.SQL.add('GLOBALREF as GLOBALREF ,');
      Qrymain.SQL.add('`TYPE` as `TYPE` ,');
      Qrymain.SQL.add('CLIENTNAME as CLIENTNAME ,');
      Qrymain.SQL.add('CLASSID as CLASSID ,');
      Qrymain.SQL.add('SALEID as SALEID ,');
      Qrymain.SQL.add('PURCHASEORDERID as PURCHASEORDERID ,');
      Qrymain.SQL.add('PAYMENTID as PAYMENTID ,');
      Qrymain.SQL.add('PREPAYMENTID as PREPAYMENTID ,');
      Qrymain.SQL.add('FIXEDASSETID as FIXEDASSETID ,');
      Qrymain.SQL.add('ACCOUNTNAME as ACCOUNTNAME ,');
      Qrymain.SQL.add('ACCOUNTID as ACCOUNTID ,');
      Qrymain.SQL.add('AccountType as AccountType ,');
      Qrymain.SQL.add('sum(DEBITSEX) as DEBITSEX ,');
      Qrymain.SQL.add('sum(CREDITSEX) as CREDITSEX ,');
      Qrymain.SQL.add('sum(DEBITSINC) as DEBITSINC ,');
      Qrymain.SQL.add('sum(CREDITSINC) as CREDITSINC ,');
      Qrymain.SQL.add('Sum(CREDITSEX- DEBITSEX )  as EXDiff,');
      Qrymain.SQL.add('Sum(CREDITSINC - DEBITSINC ) as IncDiff ,');
      Qrymain.SQL.add('sum(CASHDEBITSEX) as CASHDEBITSEX ,');
      Qrymain.SQL.add('sum(CASHCREDITSEX) as CASHCREDITSEX ,');
      Qrymain.SQL.add('sum(CASHDEBITSINC) as CASHDEBITSINC ,');
      Qrymain.SQL.add('sum(CASHCREDITSINC) as CASHCREDITSINC ,');
      Qrymain.SQL.add('PRODUCTNAME as PRODUCTNAME ,');
      Qrymain.SQL.add('PRODUCTGROUP as PRODUCTGROUP ,');
      Qrymain.SQL.add('PRODUCTDESC as PRODUCTDESC ,');
      Qrymain.SQL.add('TAXCODE as TAXCODE ,');
      Qrymain.SQL.add('ACCOUNT as ACCOUNT ,');
      Qrymain.SQL.add('Seqno as Seqno ,');
      Qrymain.sql.add('TransTimeStamp,');
      Qrymain.SQL.add('ACCOUNTNUMBER as ACCOUNTNUMBER ,');
      if FConReport.RecordCount > 0 then begin
              FCOnReport.first;
              while FConReport.Eof = False do begin
                  Qrymain.SQL.add('sum(' +FCOnReportCode.asString + '_DebitsEx) as ' + FCOnReportCode.asString + '_DebitsEx , ' );
                  Qrymain.SQL.add('sum(' +FCOnReportCode.asString + '_CreditsEx) as ' + FCOnReportCode.asString + '_CreditsEx , ' );
                  Qrymain.SQL.add('sum(' +FCOnReportCode.asString + '_DebitsInc) as ' + FCOnReportCode.asString + '_DebitsInc , ' );
                  Qrymain.SQL.add('sum(' +FCOnReportCode.asString + '_CreditsInc) as ' + FCOnReportCode.asString + '_CreditsInc , ' );
                  FCOnReport.Next;
              end;
          end;
      Qrymain.SQL.add('EMPLOYEEID as EMPLOYEEID, ');
      qryMain.SQL.Add('EmployeeName as EmployeeName, ');
      Qrymain.SQL.add('Department as Department, ');
      Qrymain.SQL.add('Memo as Memo,');
      Qrymain.SQL.add('ReferenceNo as ReferenceNo');
      Qrymain.SQL.add('from ' + fsTablename );
         if grpfilters.itemindex =2 then Qrymain.SQL.add('group by  transId ')
    else if grpfilters.itemindex =1 then Qrymain.SQL.add('group by   type, GLOBALREF')
    else Qrymain.SQL.add('group by  type, accountid');
    Qrymain.SQL.add('Order by Date DESC');*)
    Qrymain.SQL.clear;
    TransactionListReport.PopulateReportSQL(Qrymain.SQL, msg);
    RefreshOrignalSQL;
    Logtext(Qrymain.SQL.Text);
    ForeignCurrencyFieldCount:= FConReport.RecordCount;
  finally
    Qrymain.EnableControls;
  end;
end;


procedure TTransactionListGUI.OnRefreshQueryOutOfMemoryError(Sender: TObject);
begin
    inherited;
end;

procedure TTransactionListGUI.RefreshQuery;
begin
  //inherited;
  if qrymain.active = false then
    try qrymain.active := true; except end;
  if Searching then RefreshAll else ToBeRefreshed;
end;
procedure TTransactionListGUI.RefreshAll;
begin
  While (TransRecCount(FilterDatefrom, FilterDateTo ) > 100000) and not(Devmode) do begin
    dtTo.date := incmonth(dtTo.date ,-10);
    ListTimerMsg('Too Many Transactions for the date Range, Changed to ' + SelectedDateRangeMsg);
  end;
  DoShowProgressbar(7,WAITMSG);
  try
    PopulateReportTable;
    DoStepProgressbar;
    makeQrymain;
    DoStepProgressbar;
    inherited RefreshQuery;
    ClassIDUsed :=  SelectedClassId;
    filterindex :=  grpfilters.itemindex;
    xDateFrom := filterDatefrom;
    xdateTo   := FilterDateto;
    ToBeRefreshed;
  finally
    DoHideProgressbar;
  end;
end;

procedure TTransactionListGUI.RefreshTotals;
begin
    inherited;
    Calcnshowfooter;
    if devmode then Showdiff;

end;

procedure TTransactionListGUI.FormShow(Sender: TObject);
begin
  btnFront.Visible := devmode;
  btnback.Visible  := devmode;
  btnfinddiff.Visible := Devmode;

  inherited;
  RefreshAll;
  if grpfilters.ItemIndex <0 then grpfilters.Itemindex := 0;
  fbFormshown:= True;
end;

procedure TTransactionListGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TTransactionListGUI.chkOptionClick(Sender: TObject);
begin
  inherited;
  inherited actRefreshQryExecute(sender);
end;

procedure TTransactionListGUI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Totalsqry);
  DeleteTable(fstablename);
  inherited;
end;
procedure TTransactionListGUI.BitBtn1Click(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TTransactionListGUI.btnbackClick(Sender: TObject);
var
  Days:Integer;
begin
  inherited;
  changingFromDate:=TRue;
  changingToDate:=TRue;
  try
    Days := DaysBetween(filterDateFrom , FilterDateTo)-1;
    dtFrom.Date := incDay(dtfrom.Date , 0-Days);
    dtto.Date := incDay(dtto.Date , 0-Days);
  finally
    changingFromDate:=False;
    changingToDate:=False;
  end;
  dtFromChange(dtFRom);
end;

procedure TTransactionListGUI.btnchecktransClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  grdmain.setActivefield(Qrymainglobalref.fieldname);
  DoShowProgressbar(Qrymain.recordcount,WAITMSG);
  try
    while Qrymain.eof = False do begin
      Customfilter.Addfilter(grdMain.GetActiveField, AndFilter);
      RefreshfilterLabel;
      DoStepProgressbar(Qrymain.Filter);
      PreviewFilteredReport;
      Qrymain.Last;
      mnuClearFilter.Click;
      s:= Qrymainglobalref.AsString;
      while (Qrymain.Eof = False) and (Sametext(s ,Qrymainglobalref.AsString)) do  Qrymain.Next;

    end;

  finally
    DoHideProgressbar;
  end;
end;

procedure TTransactionListGUI.btnfinddiffClick(Sender: TObject);
var
  sGloablref, stype:String;
begin
if grpfilters.itemindex =0 then begin
    if not findingdiff then begin
      clog('');
      Qrymain.First;
      findingdiff := True;
    end else begin
      Qrymain.Next;
    end;
    if Qrymain.Eof then begin
          findingdiff:= False;
          mnuClearFilter.Click;
          Exit;
    end;
    DoShowProgressbar(Qrymain.recordcount,WAITMSG);
    try
      While Qrymain.Eof = False do begin
        Logtext( qryMainType.AsString +':' +  Qrymainglobalref.asString +'-> Ex = ' +  floatTostr(Qrymain.fieldbyname('exdiff').asfloat) +' ,'+
                                    '  Inc = ' +  floatTostr(Qrymain.fieldbyname('incdiff').asfloat));
        if not (Samevalue(Qrymain.fieldbyname('creditsEx').asfloat , Qrymain.fieldbyname('debitsex').asfloat,0.01)) or
           not (Samevalue(Qrymain.fieldbyname('creditsinc').asfloat , Qrymain.fieldbyname('debitsinc').asfloat,0.01)) then break;
        Qrymain.Next;
        DoStepProgressbar;
      end;
    finally
      DoHideProgressbar;
    end;
end else begin
  Qrymain.disablecontrols;
  try
    if not findingdiff then begin
      clog('');
      qryMain.IndexFieldNames := Qrymaintype.fieldname +' ASC, ' + Qrymainglobalref.FieldName +' ASC';
      Qrymain.First;
    end;
    DoShowProgressbar(Qrymain.recordcount,WAITMSG);
    try
    While Qrymain.Eof = False do begin
        if findingdiff then begin
            sGloablref:= Qrymainglobalref.asString;
            stype := Qrymaintype.asString;
            Qrymain.Last;
            mnuClearFilter.Click;
            while (Qrymain.Eof = False) and Sametext(sGloablref ,Qrymainglobalref.AsString) and sametext(stype, qrymaintype.asString) do  Qrymain.Next;
        end;

        if Qrymain.Eof then begin
          findingdiff:= False;
          mnuClearFilter.Click;
          Exit;
        end;
        findingdiff:= True;
        Customfilter.Addfilter(Qrymainglobalref, AndFilter);
        Customfilter.Addfilter(qrymaintype, AndFilter);
        RefreshfilterLabel;
        PreviewFilteredReport;
        Logtext( qryMainType.AsString +':' +  Qrymainglobalref.asString +'-> Ex = ' +  edtBalanceex.Text +' ,  Inc = ' +edtBalanceinc.text);
        if (abs(strValue(edtBalanceex.Text)) >=0.05) or (abs(strValue(edtBalanceinc.text))>=0.05) then break;
        DoStepProgressbar;
    end;
    finally
      DoHideProgressbar;
    end;
  finally
    Qrymain.enablecontrols;
  end;
end;
end;

procedure TTransactionListGUI.btnFrontClick(Sender: TObject);
var
  Days:Integer;
begin
  inherited;
  changingFromDate:=TRue;
  changingToDate:=TRue;
  try
    Days := DaysBetween(filterDateFrom , FilterDateTo)+1;
    dtto.Date := incDay(dtto.Date , Days);
    dtFrom.Date := incDay(dtfrom.Date , Days);
  finally
    changingFromDate:=False;
    changingToDate:=False;
  end;
  dtFromChange(dtFRom);
end;

procedure TTransactionListGUI.btnGlobalreffilterClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  s:= CustomInputString(globalref, 'Enter transaction Globalref to search','');
  if sametext(s, globalref) then exit;
  Globalref := s;
  RefreshAll;
end;

procedure TTransactionListGUI.actExecuteFilterExecute(Sender: TObject);
begin
  inherited;
  RefreshTotals;
end;

procedure TTransactionListGUI.actRefreshQryExecute(Sender: TObject);
begin
//  inherited;
    RefreshAll;
end;

procedure TTransactionListGUI.actClearFilterExecute(Sender: TObject);
begin
  inherited;
  if findingdiff then exit;
  RefreshTotals;
end;

procedure TTransactionListGUI.ApplyQueryFilter;
begin
  inherited;
  if devmode then Showdiff;
end;

procedure TTransactionListGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  Popupform.KeyId := 0;
  if (Sysutils.SameText(qryMainType.asString ,TStockTransferEntry.Transtype)) or
            (Sysutils.SameText(qryMainType.asString , TStockAdjustEntry.Transtype))  then begin
     Popupform.KeyId := QrymainSaleID.asInteger;
  end;
  if Popupform.KeyId = 0 then inherited;

end;

procedure TTransactionListGUI.SetGridColumns;
begin
    RemoveFieldfromGrid('ClassID');
    RemoveFieldfromGrid('SaleID');
    RemoveFieldfromGrid('PurchaseOrderID');
    RemoveFieldfromGrid('PaymentID');
    RemoveFieldfromGrid('AccountID');
    RemoveFieldfromGrid('PrepaymentID');
	RemoveFieldfromGrid(qryMainTransTimeStamp.fieldname);
    if not devmode then begin
      RemoveFieldfromGrid('Seqno');
      RemoveFieldfromGrid('exdiff');
      RemoveFieldfromGrid('incdiff');
    end;
end;

procedure TTransactionListGUI.showDiff;
begin
  try
      edtBalanceex.text :=FloatToStrF(FooterCalcfieldValue('exdiff') , ffCurrency, 15, 2);
      edtBalanceinc.text:=FloatToStrF(FooterCalcfieldValue('incdiff'), ffCurrency, 15, 2);
  Except
    //kill the exception
  end;
end;


procedure TTransactionListGUI.ToBeRefreshed;
begin
   lblREfreshInfo.visible := (ClassIDUsed<>SelectedClassId) or
      (xDateFrom<>filterDatefrom) or
      (xdateTo<> FilterDateto) or
      (filterindex <> grpfilters.itemindex);

end;

function TTransactionListGUI.TransListtype: TTransListtype;
begin
  Result := tltTransList;
end;

procedure TTransactionListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if not fbDateRangeSupplied then begin
    if GuiPrefs.Node.Exists('Options.dtfrom') then dtfrom.Date := strtoDate( GuiPrefs.Node['Options.dtfrom'].AsString);
    if GuiPrefs.Node.Exists('Options.dtTo')   then dtTo.Date   := strtoDate( GuiPrefs.Node['Options.dtTo'].AsString);
  end;
 //Globalref := GuiPrefs.Node['Options.Globalref'].AsString ;
end;
procedure TTransactionListGUI.WriteGuiPrefExtra;
begin
  inherited;
  if not fbDateRangeSupplied then begin
    GuiPrefs.Node['Options.dtfrom'].AsString  := DatetoStr(dtfrom.Date);
    GuiPrefs.Node['Options.dtTo'].AsString    := datetostr(dtTo.Date);
  end;
  //GuiPrefs.Node['Options.Globalref'].AsString    := Globalref;
end;

initialization
  RegisterClassOnce(TTransactionListGUI);
end.
