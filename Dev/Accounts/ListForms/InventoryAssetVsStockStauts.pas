unit InventoryAssetVsStockStauts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , BaseListingForm,
  DBCtrls, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TInventoryAssetVsStockStautsGUI = class(TBaseListingGUI)
    qryMainLevelno: TLargeintField;
    qryMainTranstype: TWideStringField;
    qryMainProductname: TWideStringField;
    qryMainAccountname: TWideStringField;
    qryMainTransactionno: TIntegerField;
    qryMainBalancesheet: TFloatField;
    qryMainCOGSAdjamount: TFloatField;
    qryMainDiff: TFloatField;
    qryMainStockValue: TFloatField;
    lblMsg: TLabel;
    DNMPanel1: TDNMPanel;
    chkShowWithDiff: TCheckBox;
    qryMainTransDate: TDateTimeField;
    DNMPanel2: TDNMPanel;
    chkNonProductentries: TCheckBox;
    qryMainCategory: TIntegerField;
    DNMPanel3: TDNMPanel;
    chkHideRunningQty: TCheckBox;
    QryExplain: TERPQuery;
    dsExplain: TDataSource;
    QryExplainField1: TWideStringField;
    QryExplainField2: TWideStringField;
    report2n3: TSplitter;
    btnExplainOption: TDNMSpeedButton;
    QryExplainno: TLargeintField;
    pnlExplain: TDNMPanel;
    grdExplain: TwwDBGrid;
    wwIButton1: TwwIButton;
    lblExplainhint: TLabel;
    lblHint: TLabel;
    btnHowTo: TDNMSpeedButton;
    Panel5: TPanel;
    DNMSpeedButton1: TDNMSpeedButton;
    btnStockVarify: TDNMSpeedButton;
    StockValueVarify1: TMenuItem;
    btnChooseAccounts: TDNMSpeedButton;
    qryMainAccountId: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormDestroy(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure chkShowWithDiffClick(Sender: TObject);
    procedure chkNonProductentriesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditCahrtClick(Sender: TObject);
    procedure grdExplainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure QryExplainAfterOpen(DataSet: TDataSet);
    procedure pnlExplainResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdExplainDblClick(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure btnStockVarifyClick(Sender: TObject);
    procedure StockValueVarify1Click(Sender: TObject);
    procedure btnHowToClick(Sender: TObject);
    procedure btnChooseAccountsClick(Sender: TObject);
  private
    fsTablename:String;
    fsAccountIDs: String;
    procedure showUpdateBatchWarning;
    function getAssetValue: Double;
    procedure DoExplain;
    procedure resetonResize;
    procedure intLists(Sender: TObject);
    procedure initInventoryAssetVsStockStautsDetails(Sender: TObject);
    procedure AftershowStockVarify(Sender: TObject);
    procedure StockValueVarify;
    procedure initChartOfAccountsList(Sender: TObject);
    procedure onSelectTChartOfAccounts(Sender: TwwDBGrid);
    procedure MakeQrymain;
    procedure SetAccountIDs(const Value: String);
    function AllAccountIdfilter: String;
    Function Accountnames:String;
  Protected
    Procedure RefreshTotals;Override;
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure AfterPopup(Popupform:TComponent);Override;
  public
    Procedure RefreshQuery;Override;
    Property AssetValue :Double read getAssetValue;
    Property AccountIDs :String read fsAccountIDs write SetAccountIDs;

  end;


implementation

uses StockStatusRolingList, BalTransListForm, BalanceSheetForm, CommonDbLib, CommonLib, MySQLConst, Math, tcConst, BusobjCustomFilter,CommonFormLib, AppEnvironment,
  DbSharedObjectsObj, LogLib, Preferences, MAIN, BOMOrders, TimedHint,
  SystemLib, InventoryAssetVsStockStautsDetails, DocReaderObj,
  StockAdjustAccountList, SalesLinesList, frmStockVarify, SalesorderListExpress,
  frmJournalEntry, ChartOfAccountsListExpress;

  const
    UN_INVOICED_PO      = 1;
    UN_INVOICED_PO_LIST = 2;
    UN_INVOICED_SO      = 3;
    UN_INVOICED_SO_LIST = 4;
    BOM_ORDERS          = 5;
    BOM_COST_STRUCT     = 6;
    STOCK_ADJ_ACCOUNT   = 7;
    SALES_LINE_COST     = 8;


{$R *.dfm}

{ TInventoryAssetVsStockStautsGUI }

procedure TInventoryAssetVsStockStautsGUI.btnChooseAccountsClick(
  Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TChartOfAccountsListExpressGUI' ,initChartOfAccountsList, onSelectTChartOfAccounts );
end;
procedure TInventoryAssetVsStockStautsGUI.initChartOfAccountsList(Sender: TObject);
begin
  if Sender is  TChartOfAccountsListExpressGUI then begin
    TChartOfAccountsListExpressGUI(Sender).Selectrecordsfieldname :='AccountID';
    TChartOfAccountsListExpressGUI(Sender).SelectrecordsValues := AccountIDs;
    TChartOfAccountsListExpressGUI(Sender).FilterString := AllAccountIdfilter;
  end;
end;
Function TInventoryAssetVsStockStautsGUI.AllAccountIdfilter :String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    result := qry.GroupConcatFilter('Select distinct AccountID from ' + fstablename , 'AccountID', '',False,  ' OR ' , '' , '' , 'AccountID'  , False);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TInventoryAssetVsStockStautsGUI.onSelectTChartOfAccounts(Sender: TwwDBGrid);
begin
  AccountIDs := commonlib.SelectedIDs(sender, 'accountid' , true);
end;
procedure TInventoryAssetVsStockStautsGUI.btnEditCahrtClick(Sender: TObject);
begin
  inherited;
  pnlExplain.visible := not(pnlExplain.visible);
end;

procedure TInventoryAssetVsStockStautsGUI.btnHowToClick(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Inventory Asset v Balance Sheet');
end;

procedure TInventoryAssetVsStockStautsGUI.chkNonProductentriesClick(
  Sender: TObject);
begin
  inherited;
  grpFiltersClick(grpFilters);
end;

procedure TInventoryAssetVsStockStautsGUI.chkShowWithDiffClick(Sender: TObject);
begin
  inherited;
  grpFiltersClick(grpFilters);
end;
procedure TInventoryAssetVsStockStautsGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if QryExplain.locate('No' , 1 , []) then      DoExplain;
  if QryExplain.locate('No' , 3 , []) then      DoExplain;
end;

procedure TInventoryAssetVsStockStautsGUI.btnStockVarifyClick(Sender: TObject);
begin
  inherited;
  StockValueVarify;
end;
procedure TInventoryAssetVsStockStautsGUI.StockValueVarify;
begin
  OpenERPForm('TfmStockVarify' , 0  ,nil,  AftershowStockVarify);
  //close;
end;
function TInventoryAssetVsStockStautsGUI.Accountnames: String;
var
  qry: TERPQuery;
begin
  result := '';
  if fsAccountIds = '' then exit;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    result := qry.OpennGroupconcat('Select distinct Accountname from tblchartofaccounts where accountId in (' + fsAccountIds +')' , 'AccountName', '',False,  NL+'  ->' );
    if result <> '' then result := '  ->'+result;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;

procedure TInventoryAssetVsStockStautsGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
  if popupform is TJournalEntryGUI then begin
    TJournalEntryGUI(popupform).locatelinefor(Qrymainaccountname.AsString );
  end;
end;

procedure TInventoryAssetVsStockStautsGUI.AftershowStockVarify(Sender: TObject);
begin
  if (sender is TfmStockVarify) then begin
    TfmStockVarify(sender).InventoryAssetVsStockStauts := self;
  end;
end;
procedure TInventoryAssetVsStockStautsGUI.FormCreate(Sender: TObject);
begin
  HaveOnlyToDate['As On'] := true;
  btnStockVarify.visible := Devmode;
  closedb(QryExplain);
  QryExplain.SQL.clear;
  QryExplain.SQL.add('       Select ' + inttostr(UN_INVOICED_PO     )  + ' as no, ' + quotedstr('Include Un-Invoiced PO to GL.  '+NL+'Should be True to Match Inventory Asset Value and Stock') + '  as Field1 , ' + quotedstr(BooleanToString(Appenv.Companyprefs.IncludeUnInvoicedPOtoGL)) +' as Field2 '+
                     ' union Select ' + inttostr(UN_INVOICED_PO_LIST)  + ' as no, ' + quotedstr('Un-Invoiced PO List')           + '  as Field1 , "Open" as Field2 '+
                     ' union Select ' + inttostr(UN_INVOICED_SO     )  + ' as no, ' + quotedstr('Include Un-Invoiced SO to GL.  '+NL+'Should be False to Match Inventory Asset Value and Stock')+ '  as Field1 , ' + quotedstr(BooleanToString(Appenv.Companyprefs.IncludeUnInvoicedSOtoGL)) +' as Field2 ' +
                     ' union Select ' + inttostr(UN_INVOICED_SO_LIST)  + ' as no, ' + quotedstr('Un-Invoiced Sales Orders')      + '  as Field1 , "Open" as Field2 '+
                     ' union Select ' + inttostr(BOM_ORDERS         )  + ' as no, ' + quotedstr('BOM Orders')                    + '  as Field1 , "Open" as Field2 '+
                     ' union Select ' + inttostr(BOM_COST_STRUCT    )  + ' as no, ' + quotedstr('BOM Cost Structure')            + '  as Field1 , "Open" as Field2 '+
                     ' union Select ' + inttostr(STOCK_ADJ_ACCOUNT  )  + ' as no, ' + quotedstr('Stock Adjustment Accounts')     + '  as Field1 , "Open" as Field2 '+
                     //' union Select ' + inttostr(SALES_LINE_COST    )  + ' as no, ' + quotedstr('Sales Line List')               + '  as Field1 , "Open" as Field2 '+
                     ' order by no');
  dtFrom.Date :=0;
  showUpdateBatchWarning;
  fsTablename := CommonDbLib.GetUserTemporaryTableName('tmp_AssnBal' );
  MakeQrymain;
  NonSearchMode:= true;
  inherited;
  SelectionOption :=soClassnProduct;
  GrpfilterSupplied :=True;
  grpfilters.itemindex := 0;
  AddcalcColumn(qryMainBalancesheet.fieldname, true);
  AddcalcColumn(qryMainCOGSAdjamount.fieldname, true);
  AddcalcColumn(qryMainDiff.fieldname, true);
  AddcalcColumn(qryMainStockValue.fieldname, true);
  grdexplain.TitleColor := Self.Color;
  grdexplain.FooterColor := Self.Color;
  lblExplainhint.caption := 'Hold CTRL and Click on the Item for Details.'+NL+'Make Sure that Closing Date Refresh is Done when Preference is changed';
  lblExplainhint.REfresh;
  resetonResize;
end;
Procedure TInventoryAssetVsStockStautsGUI.MakeQrymain;
begin
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add('1 as Levelno ,');
  Qrymain.SQL.add('Null as CAtegory ,');
  Qrymain.SQL.add('TransType as Transtype,');
  Qrymain.SQL.add('Convert(Null,dateTime) as TransDate,');
  Qrymain.SQL.add('NULL as Productname,');
  Qrymain.SQL.add('Accountname as Accountname,');
  Qrymain.SQL.add('AccountId  as AccountId , ');
  Qrymain.SQL.add('null as Transactionno,');
  Qrymain.SQL.add('round(Sum(ifnull(Balancesheet,0)), '+FloatToStr(GeneralRoundPlaces) +') as  Balancesheet,');
  Qrymain.SQL.add('round(Sum(ifnull(COGSAdjamount,0)), '+FloatToStr(GeneralRoundPlaces) +') as  COGSAdjamount,');
  Qrymain.SQL.add('round(Sum(ifnull(stockValue,0)) , '+FloatToStr(GeneralRoundPlaces) +') as  StockValue,');
  Qrymain.SQL.add('round(Sum(ifnull(Balancesheet,0)-ifnull(stockValue,0)) , '+FloatToStr(GeneralRoundPlaces) +') as  Diff');
  Qrymain.SQL.add('from ' + fsTablename +' ');
  Qrymain.SQL.add('where (ifnull(Balancesheet,0)<> 0 or ifnull(stockValue,0)<> 0)');
  if AccountIDs <> '' then Qrymain.SQL.add(' and Accountid in (' + AccountIDs +')');
  Qrymain.SQL.add('group by TransType , Accountname');
  Qrymain.SQL.add('union all');
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add('2 as Levelno ,');
  Qrymain.SQL.add('Null as CAtegory ,');
  Qrymain.SQL.add('TransType as Transtype,');
  Qrymain.SQL.add('Convert(Null , dateTime) as TransDate,');
  Qrymain.SQL.add('Productname as Productname,');
  Qrymain.SQL.add('Accountname as Accountname,');
  Qrymain.SQL.add('AccountId  as AccountId , ');
  Qrymain.SQL.add('null as Transactionno,');
  Qrymain.SQL.add('round(Sum(ifnull(Balancesheet,0)), '+FloatToStr(GeneralRoundPlaces) +') as  Balancesheet,');
  Qrymain.SQL.add('round(Sum(ifnull(COGSAdjamount,0)), '+FloatToStr(GeneralRoundPlaces) +') as  COGSAdjamount,');
  Qrymain.SQL.add('round(Sum(ifnull(stockValue,0)) , '+FloatToStr(GeneralRoundPlaces) +') as  StockValue,');
  Qrymain.SQL.add('round(Sum(ifnull(Balancesheet,0)-ifnull(stockValue,0)) , '+FloatToStr(GeneralRoundPlaces) +') as  Diff');
  Qrymain.SQL.add('from ' + fsTablename +'');
  Qrymain.SQL.add('where (ifnull(Balancesheet,0)<> 0 or ifnull(stockValue,0)<> 0)');
  if AccountIDs <> '' then Qrymain.SQL.add(' and Accountid in (' + AccountIDs +')');
  Qrymain.SQL.add('group by TransType,Productname,Accountname');
  Qrymain.SQL.add('union all');
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add('3 as Levelno ,');
  Qrymain.SQL.add('Category as CAtegory ,');
  Qrymain.SQL.add('TransType as Transtype,');
  Qrymain.SQL.add('Convert(Transdate, datetime) as TransDate,');
  Qrymain.SQL.add('Productname as Productname,');
  Qrymain.SQL.add('Accountname as Accountname,');
  Qrymain.SQL.add('AccountId  as AccountId , ');
  Qrymain.SQL.add('Transactionno as Transactionno,');
  Qrymain.SQL.add('Round(Sum(ifnull(Balancesheet,0)) , '+FloatToStr(GeneralRoundPlaces) +') as  Balancesheet,');
  Qrymain.SQL.add('Round(Sum(ifnull(COGSAdjamount,0)) , '+FloatToStr(GeneralRoundPlaces) +') as  COGSAdjamount,');
  Qrymain.SQL.add('Round(Sum(ifnull(stockValue,0)) , '+FloatToStr(GeneralRoundPlaces) +') as  StockValue,');
  Qrymain.SQL.add('Round(Sum(ifnull(Balancesheet,0)-ifnull(stockValue,0)) , '+FloatToStr(GeneralRoundPlaces) +') as  Diff');
  Qrymain.SQL.add('from ' + fsTablename +'');
  Qrymain.SQL.add('where (ifnull(Balancesheet,0)<> 0 or ifnull(stockValue,0)<> 0)');
  if AccountIDs <> '' then Qrymain.SQL.add(' and Accountid in (' + AccountIDs +')');
  Qrymain.SQL.add('group by TransType   , Productname, Accountname, Transactionno');
  Qrymain.SQL.add('Order by TransType   , Productname, Accountname, Transactionno');
end;
procedure TInventoryAssetVsStockStautsGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(fsTablename);
  DestroyUserTemporaryTable(fsTablename+'_SMS');
  DestroyUserTemporaryTable(fsTablename+'_BAL');
  DestroyUserTemporaryTable(fsTablename+'1');
  DestroyUserTemporaryTable(fsTablename+'2');
  inherited;
end;


procedure TInventoryAssetVsStockStautsGUI.FormResize(Sender: TObject);
begin
  inherited;
  resetonResize;
end;

procedure TInventoryAssetVsStockStautsGUI.FormShow(Sender: TObject);
begin
  inherited;
  QryExplain.connection := Qrymain.connection;
  OpenDb(QryExplain);
  resetonResize;
  Widerform(1100);
  TallerForm;
end;

function TInventoryAssetVsStockStautsGUI.getAssetValue: Double;
begin
  REsult :=   strValue(grdMain.ColumnByName(qryMainStockValue.fieldname).FooterValue);
end;

procedure TInventoryAssetVsStockStautsGUI.grdExplainDblClick(Sender: TObject);
begin
  inherited;
  DoExplain;
end;

procedure TInventoryAssetVsStockStautsGUI.grdExplainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if ssCtrl in Shift then
     if Button = mbLeft then
      DoExplain;
end;

procedure TInventoryAssetVsStockStautsGUI.DoExplain;
var
  AccLevel: Integer;
begin
  AccLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel('TPreferencesGUI');
           if QryExplainno.asInteger = UN_INVOICED_PO      then begin OpenPrefform('Purchases' ,  'chkIncludeUnInvoicedPOtoGL' , AccLevel , true , '' , '' , qryexplain.fieldbyname('Field1').asString);
  end else if QryExplainno.asInteger = UN_INVOICED_SO      then begin OpenPrefform('Sales'     ,  'chkIncludeUnInvoicedSOtoGL' , AccLevel , true , '' , '' , qryexplain.fieldbyname('Field1').asString);
  end else if QryExplainno.asInteger = UN_INVOICED_PO_List then begin OpenERPListForm('TUnInvoicedPOListGUI'       , nil);
  end else if QryExplainno.asInteger = BOM_ORDERS          then begin OpenERPListForm('TBOMOrdersGUI'              , nil, intLists);
  end else if QryExplainno.asInteger = STOCK_ADJ_ACCOUNT   then begin OpenERPListForm('TStockAdjustAccountListGUI' , nil, intLists);
  end else if QryExplainno.asInteger = SALES_LINE_COST     then begin OpenERPListForm('TSalesLinesListGUI'         , nil, intLists);
  end else if QryExplainno.asInteger = UN_INVOICED_SO_LIST then begin OpenERPListForm('TSalesorderListExpressGUI'  , nil, intLists);
  end else if QryExplainno.asInteger = BOM_COST_STRUCT     then begin TDocReaderObj.ShowERPHelp(nil, Self, TRue, 'BOM tree');
  end;

end;
procedure TInventoryAssetVsStockStautsGUI.dtToChange(Sender: TObject);
begin
  dtFrom.Date :=0;
  inherited;
end;

procedure TInventoryAssetVsStockStautsGUI.intLists(Sender: TObject);
begin
  if (Sender is TBOMOrdersGUI) then begin
    if not TBOMOrdersGUI(Sender).chkIgnoreDates.checked then begin
      TBOMOrdersGUI(Sender).chkIgnoreDates.checked := True ;
      TBOMOrdersGUI(Sender).RefreshQuery;
    end;
    TBOMOrdersGUI(Sender).grpfilters.ItemIndex := 1;
    TBOMOrdersGUI(Sender).selectall;
    TBOMOrdersGUI(Sender).HighlightControl(TBOMOrdersGUI(Sender).btnUpdate);
    ShowTimedHint(TBOMOrdersGUI(Sender).btnUpdate , TBOMOrdersGUI(Sender).btnUpdate.hint  , true );
  end else if (Sender is TStockAdjustAccountListGUI) then begin
    TStockAdjustAccountListGUI(Sender).grpFilters.ItemIndex := 0;
    TStockAdjustAccountListGUI(Sender).chkIgnoreDates.Checked := True;
  end else if (Sender is TSalesLinesListGUI ) then begin
    TSalesLinesListGUI(Sender).grpFilters.ItemIndex := 0;
    TSalesLinesListGUI(Sender).chkIgnoreDates.Checked := True;
  end else if (Sender is TSalesorderListExpressGUI ) then begin
    TSalesorderListExpressGUI(Sender).grpFilters.ItemIndex := 0;
    TSalesorderListExpressGUI(Sender).chkIgnoreDates.Checked := True;
  end;
end;
procedure TInventoryAssetVsStockStautsGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
       if (Field is TFloatfield)  and (samevalue(Field.asfloat ,0, 0.01)) then AFont.color := ABrush.color
  else if not(samevalue(qryMainBalancesheet.asfloat, qryMainStockValue.asFloat,0.01)) then
    if Sametext(field.fieldname ,qryMainBalancesheet.fieldname) or
       Sametext(field.fieldname ,qryMainStockValue.fieldname) or
       Sametext(field.fieldname ,qryMainCOGSAdjamount.fieldname) then AFont.color := clred;
end;

procedure TInventoryAssetVsStockStautsGUI.grdMainDblClick(Sender: TObject);
begin
  if (grpfilters.itemindex =0) and (qryMainTranstype.asString <> '') then begin
    mnuClearFilter.Click;
    Customfilter.Addfilter(qryMainTranstype, AndFilter);
    RefreshfilterLabel;
    PreviewFilteredReport;
    grpfilters.itemindex := 1;
    timerMsg(FilterLabel, 'List Filtered for type ' +Quotedstr(qryMainTranstype.asString)+' and expanded to ''Details''.  Remove the filter for complete list', 20);
    Exit;
  end;
  if (grpfilters.itemindex =1) and (qryMainTranstype.asString <> '')  then begin
    mnuClearFilter.Click;
    Customfilter.Addfilter(qryMainTranstype, AndFilter);
    Customfilter.Addfilter(qryMainProductname, AndFilter);
    RefreshfilterLabel;
    PreviewFilteredReport;
    grpfilters.itemindex := 2;
    timerMsg(FilterLabel, 'List Filtered for type = ' +Quotedstr(qryMainTranstype.asString)+' and Product = ' +Quotedstr(qryMainProductname.asString)+' and expanded to ''Extra Details''.  Remove the filter for complete list', 20);
    Exit;
  end;

  if devmode then
    if (grpfilters.itemindex =2) and sametext(activefieldname , qryMainDiff.fieldname) and (qryMainDiff.asFloat <> 0)then begin
      OpenERPListFormModal('TInventoryAssetVsStockStautsDetailsGUI' , nil, initInventoryAssetVsStockStautsDetails);
      Exit;
    end;

  SubsequentID := Chr(95) + qryMainTranstype.AsString;
  inherited;
end;
procedure TInventoryAssetVsStockStautsGUI.initInventoryAssetVsStockStautsDetails(Sender: TObject);
begin
   if not(Sender is TInventoryAssetVsStockStautsDetailsGUI) then exit;
   TInventoryAssetVsStockStautsDetailsGUI(sender).tablename := fstablename;
   TInventoryAssetVsStockStautsDetailsGUI(sender).TransId   := Qrymaintransactionno.asInteger;
   TInventoryAssetVsStockStautsDetailsGUI(sender).Transtype := qryMainTranstype.asString;
end;
procedure TInventoryAssetVsStockStautsGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Levelno' , ['1','2','3'], true);

  if chkShowWithDiff.checked then
    if groupfilterstring <> '' then
         groupfilterstring := groupfilterstring +' and (diff >=' + FloatTostr(50*LowestCurrencyDecimalValue)+' or diff <=-' + FloatTostr(50*LowestCurrencyDecimalValue)+')'
    else groupfilterstring :=                        ' (diff >=' + FloatTostr(50*LowestCurrencyDecimalValue)+' or diff <=-' + FloatTostr(50*LowestCurrencyDecimalValue)+')';

  if chkNonProductentries.Checked then
    if groupfilterstring <> '' then
         groupfilterstring := groupfilterstring +' and (Category <> 1)'
    else groupfilterstring :=                        ' (Category <> 1)';
  inherited;
end;

procedure TInventoryAssetVsStockStautsGUI.pnlExplainResize(Sender: TObject);
begin
  inherited;
  resetonResize;
end;

procedure TInventoryAssetVsStockStautsGUI.QryExplainAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.Field1Width')  then QryExplainField1.DisplayWidth       := GuiPrefs.Node['Options.Field1Width'].AsInteger;
  if GuiPrefs.Node.Exists('Options.Field2Width')  then QryExplainField2.DisplayWidth       := GuiPrefs.Node['Options.Field2Width'].AsInteger;
end;

procedure TInventoryAssetVsStockStautsGUI.showUpdateBatchWarning;
var
  s:String;
  Qry:TERPQuery;
begin
  inherited;
  s:= '';
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    With Qry do begin
      SQL.text := 'Select count(PQAID) ctr from tblPQA where mstimestamp >' + quotedstr(Formatdatetime(mysqlDateTimeformat ,  AppEnv.CompanyPrefs.TransactionTableLastUpdated));
    open;
    if fieldbyname('ctr').asInteger >0 then
      s:= 'There are ' + inttostr(fieldbyname('ctr').asInteger) +' Inventory Asset transaction Entries changed after the Last Batch Transaction Updated on  ' +
          quotedstr(Formatdatetime(FormatSettings.Shortdateformat +' hh:nn:ss',  AppEnv.CompanyPrefs.TransactionTableLastUpdated))+NL;
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;
  lblMsg.Caption :=  s+ 'The ''Amount in Balance Sheet'' uses the Summarised data. Make sure the ''Closing Date Refresh'' / ''Update Batch'' is done for data accuracy.';
end;

procedure TInventoryAssetVsStockStautsGUI.StockValueVarify1Click(
  Sender: TObject);
begin
  inherited;
  StockValueVarify;
end;

procedure TInventoryAssetVsStockStautsGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.ShowWithDiff')       then chkShowWithDiff.checked  := GuiPrefs.Node['Options.ShowWithDiff'].asBoolean;
  if GuiPrefs.Node.Exists('Options.ExplainWidth')       then pnlExplain.Width         := GuiPrefs.Node['Options.ExplainWidth'].asInteger;
  if GuiPrefs.Node.Exists('Options.grdExplainvisible')  then pnlExplain.visible       := GuiPrefs.Node['Options.grdExplainvisible'].asBoolean;
  if GuiPrefs.Node.Exists('Options.AccountIds')         then AccountIds               := GuiPrefs.Node['Options.AccountIds'].asString;
end;

procedure TInventoryAssetVsStockStautsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.ShowWithDiff'].asBoolean := chkShowWithDiff.checked;
  GuiPrefs.Node['Options.ExplainWidth'].asInteger := pnlExplain.Width;
  GuiPrefs.Node['Options.grdExplainvisible'].asBoolean :=pnlExplain.visible;
  GuiPrefs.Node['Options.Field1Width'].AsInteger := QryExplainField1.DisplayWidth;
  GuiPrefs.Node['Options.Field2Width'].AsInteger := QryExplainField2.DisplayWidth;
  GuiPrefs.Node['Options.AccountIds'].asString   := AccountIds;

end;

procedure TInventoryAssetVsStockStautsGUI.RefreshQuery;
var
  s:String;
begin
  With ScriptMain do begin
    SQL.clear;
    SQL.add('Drop table if exists ' + fstablename +'_SMS;');
    SQL.add('Create table ' + fstablename +'_SMS like tmp_ssrr;');
{-----stock trans based on pqa}
    SQL.add(TStockStatusRoling.PopulateData(fstablename +'_SMS' , True , SelectedClasSId,SelectedProductID, 'ActualTransdate' , filterDateFrom, filterdateTo, 2, chkHideRunningQty.checked));
    SQL.add('/*21*/delete from ' +fstablename +'_SMS  where ifnull(levelno,0)<>3;');
    SQL.add('/*22*/Alter table   ' +fstablename +'_SMS add column totalcost double, add column Avgtotalcost double, add column POInvoicenumber varchar(255) , add column POinvoiceDate datetime;');
    {purchase order's total cost is used instead of qtyxcost to avoid round issue }
    SQL.add('/*23.1*/update  ' +fstablename +'_SMS set totalcost = totalLinecost Where Transtype = "Purchase Order"/*round('+Roundfix('Qty*linecost')+','+FloatToStr(GeneralRoundPlaces) +')*/;');
    SQL.add('/*23.2*/update  ' +fstablename +'_SMS set totalcost = round('+Roundfix('Qty*linecost')+','+FloatToStr(GeneralRoundPlaces) +') Where Transtype <> "Purchase Order";');
    SQL.add('/*24*/update  ' +fstablename +'_SMS set Avgtotalcost = round('+Roundfix('Qty*avgcost')+','+FloatToStr(GeneralRoundPlaces) +');');

    SQL.add('/*25*/alter table  ' +fstablename +'_SMS add column Trans_Type varchar(100);');
    SQL.add('/*26*/update   ' +fstablename +'_SMS Set Trans_Type = transtype;');

    SQL.add('/*27*/update  ' +fstablename +'_SMS set Transactionno = cTransID where cTranstype = "StockAdjustEntry" or cTranstype = "StockTransferEntry";');
    SQL.add('/*27.1*/update  ' +fstablename +'_SMS sms inner join tblpurchaseorders po on sms.ctransId = po.purchaseorderID and (sms.Trans_Type = "PO" or sms.Trans_Type = "Un-Invoiced PO")  set sms.POInvoicenumber = PO.Invoicenumber, sms.POinvoiceDate = PO.invoiceDate;');
    SQL.add('/*28*/update  ' +fstablename +'_SMS set Trans_Type = "Stock Adjustment"  where cTranstype = "StockAdjustEntry" ;');
    SQL.add('/*29*/update  ' +fstablename +'_SMS set Trans_Type = "Stock Transfer"    where cTranstype = "StockTransferEntry";');
    SQL.add('/*30*/update  ' +fstablename +'_SMS set Trans_Type = "Purchase Order"  where Trans_Type = "PO"               or Trans_Type = "Un-Invoiced PO";');
    SQL.add('/*31*/update  ' +fstablename +'_SMS set Trans_Type = "Cash Sale"       where Trans_Type = "Cash Sale"        or Trans_Type = "POS";');

{---- balancesheet report }
    SQL.add('/*32*/Drop table if exists ' +fstablename +'_Bal;');
    s:= TBalTransListGUI.InvAssetBalTransListSQL(filterDateTo);
    s:= replacestr(s ,':txtfrom' , quotedstr(FormatDatetime(MYSQLDatetimeformat , filterdateFrom)));
    s:= replacestr(s ,':txtto'   , quotedstr(FormatDatetime(MYSQLDatetimeformat , filterdateTo  )));
    SQL.add('/*33*/Create table ' +fstablename +'_Bal ' + s);

    SQL.add('/*34*/ALTER TABLE ' +fstablename +'_Bal  	ADD COLUMN `ID` INT(11) NOT NULL AUTO_INCREMENT first, 	ADD PRIMARY KEY (`ID`);');
    SQL.add('/*35*/ALTER TABLE ' +fstablename +'_Bal  	ADD COLUMN `Transactionno` INT(11) after `global #`;');

    SQL.add('/*36*/update  ' +fstablename +'_Bal  Set  Transactionno = saleId           where ifnull(SaleId         ,0) <> 0 and ifnull(Transactionno,0)=0;');
    SQL.add('/*37*/update  ' +fstablename +'_Bal  Set  Transactionno = PurchaseOrderID  where ifnull(PurchaseOrderID,0) <> 0 and ifnull(Transactionno,0)=0;');
    SQL.add('/*38*/update  ' +fstablename +'_Bal  Set  Transactionno = PaymentID        where ifnull(PaymentID      ,0) <> 0 and ifnull(Transactionno,0)=0;');
    SQL.add('/*39*/update  ' +fstablename +'_Bal  Set  Transactionno = PrepaymentID     where ifnull(PrepaymentID   ,0) <> 0 and ifnull(Transactionno,0)=0;');
    SQL.add('/*40*/update  ' +fstablename +'_Bal  Set  Transactionno = FixedAssetID     where ifnull(FixedAssetID   ,0) <> 0 and ifnull(Transactionno,0)=0;');

    SQL.add('/*41*/alter table ' +fstablename +'_Bal  add index Transactionno (Transactionno);');
    SQL.add('/*42*/alter table ' +fstablename +'_Bal  add index type (type);');
    SQL.add('/*43*/alter table ' +fstablename +'_Bal  add index ProductName (ProductName);');

    SQL.add('/*44*/alter  table  ' +fstablename +'_Bal add column Trans_Type varchar(100);');
    SQL.add('/*45*/update   ' +fstablename +'_Bal Set Trans_Type = type;');
    SQL.add('/*46*/update  ' +fstablename +'_Bal set Trans_Type = "Purchase Order"  where Trans_Type = "PO"               or Trans_Type = "Un-Invoiced PO";');
    SQL.add('/*47*/update  ' +fstablename +'_Bal set Trans_Type = "Cash Sale"       where Trans_Type = "Cash Sale"        or Trans_Type = "POS";');

{----- combine both BAL and STOCK report}
    SQL.add('/*48*/Drop table if exists ' +fstablename +';');
    SQL.add('/*49*/Drop table if exists ' +fstablename +'1;');
    SQL.add('/*50*/Drop table if exists ' +fstablename +'2;');

{----- BAL summary on account/product/transid, type}
    SQL.add('/*51*/Create table ' +fstablename +'1 '+
              ' select bal.transId, bal.`account name` as Accountname,   bal.Productname, bal.transactionno,  bal.Trans_Type as Trans_Type, bal.date as TransDate,  sum(round(bal.`Amount (EX)`,'+FloatToStr(GeneralRoundPlaces) +')) as amt   '+
              ' from ' +fstablename +'_Bal   bal  where (InvAssetEntry ="T"  Or type = "Journal Entry")'+
              ' group by bal.`account name` , bal.Productname,bal.transactionno, bal.Trans_Type ;');
    SQL.add('/*53.1*/ALTER TABLE ' +fstablename +'1 ADD COLUMN `id` INT(10) NOT NULL AUTO_INCREMENT ,  ADD PRIMARY KEY (`id`);');
    SQL.add('/*53.3*/Alter table ' +fstablename +'1 ADD index allindex (Trans_Type , transactionno  , productname);');


{----- Stock summary on product/transid, type}

    SQL.add('/*53.1*/ update ' + fstablename +'_sms  sms Set  Trans_Type = "Manufacturing" where Trans_Type = "Progress Build(In)";');
    SQL.add('/*53.2*/ update ' + fstablename +'_sms  sms Set  Trans_Type = "Manufacturing" where Trans_Type = "Progress Build(Out)";');


    SQL.add('/*52.1*/CREATE TABLE ' +fstablename +'2 ('+
	          ' id INT(10) NOT NULL AUTO_INCREMENT,'+
	          ' Productname VARCHAR(255) NULL DEFAULT NULL,'+
	          ' transactionno INT(11) NOT NULL DEFAULT 0,'+
	          ' Trans_Type VARCHAR(50) NULL DEFAULT NULL,'+
	          ' TransDate DATETIME NULL DEFAULT NULL,'+
	          ' ActualTransdate DATETIME NULL DEFAULT NULL,'+
	          ' amt DOUBLE NULL DEFAULT NULL,'+
	          ' smsIDs VARCHAR(255) NULL DEFAULT NULL ,'+
	          ' PRIMARY KEY (id),'+
	          ' INDEX Productname_transactionno_Trans_Type (Productname, transactionno, Trans_Type)'+
	          ' ) COLLATE="utf8_general_ci" ENGINE=MyISAM;');
    SQL.add('/*52.2*/insert ignore into ' +fstablename +'2  '+
              ' (Productname ,transactionno,Trans_Type ,TransDate ,ActualTransdate ,amt ,smsIDs )  '+
              'select sms.Productname,sms.transactionno,  sms.Trans_Type as Trans_Type, sms.TransDate as TransDate,  '+
              'ActualTransdate as ActualTransdate, sum(round(sms.totalcost,'+FloatToStr(GeneralRoundPlaces) +')) as amt ,  '+
              ' Left(group_concat(Distinct ID),255) as smsIDs '+
              ' from ' +fstablename +'_sms   sms  '+
              ' group by sms.Productname,sms.transactionno, sms.Trans_Type ;');

    SQL.add('/*53*/update ' +fstablename +'2 set trans_type = "Manufacturing" where trans_type = "Sales Order (Man)";');

    SQL.add('/*54*/create table ' +fstablename +
              ' select 1 as Category, bal.accountname,  bal.transID as balTransId, bal.Productname,bal.transactionno,  bal.Trans_Type as Transtype, bal.TransDate ,  bal.amt as BalanceSheet , sms.amt as StockValue  , sms.smsids'+
              ' from ' +fstablename +'1   bal '+
              ' inner join ' +fstablename +'2  sms on bal.Trans_Type = sms.Trans_Type and bal.transactionno = sms.transactionno  and sms.productname = bal.productname;');

    SQL.add('/*54.1*/insert into ' +fstablename +
              ' select 2 as Category, bal.accountname,  bal.transID as balTransId, bal.Productname,bal.transactionno,  bal.Trans_Type as Transtype, bal.TransDate ,  bal.amt as BalanceSheet , Null as StockValue  , sms.smsids'+
              ' from ' +fstablename +'1   bal '+
              ' Left  join ' +fstablename +'2  sms on bal.Trans_Type = sms.Trans_Type and bal.transactionno = sms.transactionno  and sms.productname = bal.productname ' +
              ' Where ifnull(sms.ID,0)=0 and ifnull( bal.amt ,0)<> 0;');


    SQL.add('/*55*/ALTER TABLE ' +fstablename +'  	ADD UNIQUE INDEX `Nontype` (accountname, `transactionno`, `Transtype`, productname);');

(*    SQL.add('/*56*/insert ignore into ' +fstablename +'  '+
              ' select 3 as Category, accountname,  transID as balTransId,   Productname,transactionno,  Trans_Type , TransDate, Amt, Null as StockValue , null as smsids '+
              ' from ' +fstablename +'1  group by accountname , Productname,transactionno,  Trans_Type ;');

    SQL.add('/*57*/insert ignore into ' +fstablename +'  '+
              ' select 4 as Category, null accountname,  null as balTransId, Productname,transactionno,  Trans_Type , TransDate, null as BalanceSheet , amt as StockValue  , smsids '+
              ' from ' +fstablename +'2  group by Productname,transactionno,  Trans_Type ;');*)

      SQL.add('/*57*/insert ignore into ' +fstablename +'  '+
              ' select 4 as Category, null accountname,  null as balTransId, sms.Productname,sms.transactionno,  sms.Trans_Type , sms.TransDate, null as BalanceSheet , sms.amt as StockValue  , sms.smsids ' +
              ' from ' +fstablename +'2   sms '+
              ' Left  join ' +fstablename +'1  bal on bal.Trans_Type = sms.Trans_Type and bal.transactionno = sms.transactionno  and sms.productname = bal.productname ' +
              ' Where ifnull(bal.ID,0)=0 and ifnull( sms.amt ,0)<> 0;');

    if not devmode then begin
      SQL.add('/*58*/Drop table if exists ' +fstablename +'1;');
      SQL.add('/*59*/Drop table if exists ' +fstablename +'2;');
    end;
    SQL.add('/*60*/alter table ' +fstablename +' add column COGSAdjamount double;');
    SQL.add('/*61*/update ' +fstablename +' Set COGSAdjamount  = balancesheet - stockValue where Transtype <> "Journal Entry";');
    SQL.add('/*60*/alter table ' +fstablename +' add column AccountId int(11);');
    SQL.add('/*61*/update ' +fstablename +' T inner join tblchartofaccounts C on T.accountname = C.accountname set T.AccountId = C.accountId;');


    DoShowProgressbar(SQL.count, WAITMSG);
    try
      clog('');
      SQL.text := ChangeQuery(SQL.text);
      Execute;
    finally
      DoHideProgressbar;
    end;
  end;
  inherited;
end;

procedure TInventoryAssetVsStockStautsGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TInventoryAssetVsStockStautsGUI.SetAccountIDs(const Value: String);
begin
  fsAccountIDs := Value;
  Closedb(qrymain);
  MakeQrymain;
  if isFormShown then begin
    Opendb(qrymain);
  end;
  if Value <> '' then Showcontrolhint(btnChooseAccounts , 'The List is Filtered for the Following Accounts :' + NL + Accountnames+NL+NL+ 'Choose the Button to Choose a Different Set of Accounts to Filter the List.')
  else Showcontrolhint(btnChooseAccounts , 'The list is not Filtered.'+NL+NL+ 'Choose the Button to Select Accounts to Filter the List.');
end;

procedure TInventoryAssetVsStockStautsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainlevelno.fieldname);
  RemoveFieldfromGrid(qrymainAccountId.fieldname);
  if not devmode then begin
    RemoveFieldfromGrid(qrymaincategory.fieldname);
    RemoveFieldfromGrid(qryMainCOGSAdjamount.fieldname);
  end;
end;
procedure TInventoryAssetVsStockStautsGUI.resetonResize;
begin
  lblExplainhint.Autosize := False;
  lblExplainhint.Autosize := TRue;

  lblHint.Autosize := False;
  lblHint.Autosize := TRue;

end;

initialization
  RegisterClass(TInventoryAssetVsStockStautsGUI);

end.

