unit PnLAreaEmployeeReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel, DNMAction,
  CustomInputBox;

type
  TPnLAreaEmployeeReportGUI = class(TBaseListingGUI)
    btnMainList: TDNMSpeedButton;
    btnCategory: TDNMSpeedButton;
    btnOptions: TDNMSpeedButton;
    btnPnlAreareport: TDNMSpeedButton;
    actGrpupReport: TDNMAction;
    qryMainID: TIntegerField;
    qryMainDetails: TIntegerField;
    qryMainTransID: TIntegerField;
    qryMainOrderDate: TDateTimeField;
    qryMainWeekno: TIntegerField;
    qryMainmonthno: TIntegerField;
    qryMainQuarterno: TIntegerField;
    qryMainyearno: TIntegerField;
    qryMainPeriodID: TWideStringField;
    qryMainPeriod: TWideStringField;
    qryMainCategory: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainTranstype: TWideStringField;
    qryMainCostEx: TFloatField;
    qryMainAmountTax: TFloatField;
    qryMainCostInc: TFloatField;
    qryMainPriceEx: TFloatField;
    qryMainPriceInc: TFloatField;
    qryMainRecInfo: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);   override;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure btnMainListClick(Sender: TObject);
    procedure btnCategoryClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnOptionsClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure actGrpupReportUpdate(Sender: TObject);
    procedure actGrpupReportExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    dtfromClean, DtToClean:TDatetime;
    filterClean:String;
    FilterItemIndexclean:Integer;
    fbincludePOS: boolean;
    fbincludeCredit: boolean;
    fbincludeLayby: boolean;
    fbincludeSO: boolean;
    fbincludeinvoice: boolean;
    fbincludecheque: boolean;
    fbincludePO: boolean;
    fbincludeRefund: boolean;
    fbincludeCashSale: boolean;
    fbincludeVoucher: boolean;
    fbincludeJE: boolean;
    fbincludeBill: boolean;
    fbisEmployee: boolean;
    fsTablename:String;

    Procedure MakeQrymain;
    Procedure ShowDetails;
    procedure beforeshowOptions(Sender: TObject);
    procedure initPnLAreaReport(Sender: TObject);
    Procedure QrymainSQL;
  Protected
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Procedure RefreshTotals;Override;
  public
    Property isEmployee     :boolean read fbisEmployee      write fbisEmployee;
    Property includePO      :boolean read fbincludePO       write fbincludePO;
    Property includeBill    :boolean read fbincludeBill     write fbincludeBill;
    Property includeCredit  :boolean read fbincludeCredit   write fbincludeCredit;
    Property includecheque  :boolean read fbincludecheque   write fbincludecheque;
    Property includeinvoice :boolean read fbincludeinvoice  write fbincludeinvoice;
    Property includeVoucher :boolean read fbincludeVoucher  write fbincludeVoucher;
    Property includeSO      :boolean read fbincludeSO       write fbincludeSO;
    Property includeCashSale:boolean read fbincludeCashSale write fbincludeCashSale;
    Property includePOS     :boolean read fbincludePOS      write fbincludePOS;
    Property includeRefund  :boolean read fbincludeRefund   write fbincludeRefund;
    Property includeLayby   :boolean read fbincludeLayby    write fbincludeLayby;
    Property includeJE      :boolean read fbincludeJE       write fbincludeJE;
    Procedure RefreshQuery;override;
    Procedure InitOptionsform(Sender:TObject);
    Procedure InitOptionsfromform(Sender:TObject);
  end;


implementation

uses CommonLib, MySQLUtils,  BusobjCustomFilter, dateUtils, DNMLib, frmPnLEmployeeReportoptions, CommonFormLib, PnlReportLib, CommonDbLib, AppEnvironment;

{$R *.dfm}
{ TPnLEmployeereportGUI }

procedure TPnLAreaEmployeeReportGUI.btnCategoryClick(Sender: TObject);
begin
  inherited;
  isEmployee := not(isEmployee);
  Qrymain.DisableControls;
  try
    closeDb(Qrymain);
    RefreshQuery;
  finally
    Qrymain.EnableControls;
  end;
end;

procedure TPnLAreaEmployeeReportGUI.btnMainListClick(Sender: TObject);
begin
  inherited;
  Setcontrolfocus(grdmain);
  btnMainList.Visible:= False;
  HighlightControl;
  DtFrom.Date :=   DTFromClean ;
  DTto.Date:=  DTToClean;
  groupfilterString := filterClean ;
  ApplyQueryFilter;
  RefreshfilterLabel;
  RefreshQuery;
  grpfilters.ItemIndex := FilterItemIndexclean;
  Grpfiltersclick(Grpfilters);
end;

procedure TPnLAreaEmployeeReportGUI.btnOptionsClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmPnLEmployeeReportoptions' , 0, beforeshowOptions);
end;
procedure TPnLAreaEmployeeReportGUI.initPnLAreaReport(Sender: TObject);
begin
  copyParamsto(Sender);
end;
procedure TPnLAreaEmployeeReportGUI.actGrpupReportExecute(Sender: TObject);
begin
  inherited;
  if isemployee then
    OpenERpListForm('TPnLEmployeeReportGUI', initPnLAreaReport)
  else
    OpenERpListForm('TPnLAreaReportGUI', initPnLAreaReport);

  Self.Close;
end;

procedure TPnLAreaEmployeeReportGUI.actGrpupReportUpdate(Sender: TObject);
begin
  inherited;
  if isEmployee then actGrpupReport.Caption := 'PnL by Employee'
  else actGrpupReport.Caption := 'PnL by ' + Appenv.companyprefs.Areacolumnname +'';

  if isEmployee then actGrpupReport.hint := 'Report with breakdown on each employee'
  else actGrpupReport.hint := 'Report with breakdown on each ' + Appenv.companyprefs.Areacolumnname +'';

  btnPnlAreareport.Caption :=actGrpupReport.Caption;
  btnPnlAreareport.Refresh;
end;

procedure TPnLAreaEmployeeReportGUI.beforeshowOptions(Sender: TObject);
begin
  if not(Sender is TfmPnLEmployeeReportoptions) then exit;
  TfmPnLEmployeeReportoptions(Sender).InitOptionsform := InitOptionsform;
  TfmPnLEmployeeReportoptions(Sender).InitOptionsFromform := InitOptionsFromform;
end;
procedure TPnLAreaEmployeeReportGUI.FormCreate(Sender: TObject);
begin
    fstablename := commondblib.GetUserTemporaryTableName('PnlbyAreaEmp');
    Qrymain.SQL.text := 'Select * from ' +fstablename;
    Self.Caption := replacestr(Self.Caption , 'Area' , AppEnv.CompanyPrefs.Areacolumnname);
    actGrpupReport.Caption := replacestr(actGrpupReport.caption , 'Area' , AppEnv.CompanyPrefs.Areacolumnname);
    IsEmployee:= False;
    includePO:= True;
    includeBill:= True;
    includeCredit:= True;
    includecheque:= True;
    includeinvoice:= True;
    includeVoucher := True;
    includeSO:= True;
    includeJE:= True;
    includeCashSale:= True;
    includePOS:= True;
    includeRefund:= True;
    includeLayby:= True;
    dtfromClean:=0;
    DtToClean:=0;
    filterClean:='';
    FilterItemIndexclean:=-1;
    inherited;
    AddCalccolumn(QrymainCostEx.FieldName, true);
    AddCalccolumn(QrymaincostInc.FieldName, true);
    AddCalccolumn(QrymainPriceEx.FieldName, true);
    AddCalccolumn(QrymainPriceInc.FieldName, true);
    AddCalccolumn(qryMainAmountTax.FieldName, true);
end;

procedure TPnLAreaEmployeeReportGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fsTablename);
  inherited;
end;

procedure TPnLAreaEmployeeReportGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if sametext(Field.FieldName , QrymainCostEx.FieldName) or
     sametext(Field.FieldName , QrymainCostInc.FieldName) or
     sametext(Field.FieldName , QrymainPriceInc.FieldName) or
     sametext(Field.FieldName , QrymainPriceEx.FieldName) or
     sametext(Field.FieldName , QrymainamountTax.FieldName) then
      if Field.AsFloat =0 then
        Afont.Color := ABrush.Color;

end;

procedure TPnLAreaEmployeeReportGUI.grdMainDblClick(Sender: TObject);
begin
   if QrymainDetails.asInteger=1 then  begin
    SubsequentID := Chr(95) + qryMainTranstype.AsString;
    inherited;
   end else begin
    if MessageDlgXP_Vista('This will Refresh the list in ''All'' for the selected record Range / Employee / Account. Would you like to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrYEs then
      ShowDetails;
   end;
end;

procedure TPnLAreaEmployeeReportGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := 'Details =' + inttostr(grpfilters.ItemIndex +1);
  inherited;
       if grpfilters.ItemIndex=0 then qrymainperiod.DisplayLabel := 'Trans Date'
  else if grpfilters.ItemIndex=1 then qrymainperiod.DisplayLabel := 'Trans Date'
  else if grpfilters.ItemIndex=2 then qrymainperiod.DisplayLabel := 'Week no - Year'
  else if grpfilters.ItemIndex=3 then qrymainperiod.DisplayLabel := 'Month - Year'
  else if grpfilters.ItemIndex=4 then qrymainperiod.DisplayLabel := 'Quarter - Year'
  else qrymainperiod.DisplayLabel := 'Year';
end;

procedure TPnLAreaEmployeeReportGUI.InitOptionsform(Sender: TObject);
begin
  if not (Sender is TfmPnLEmployeeReportoptions) then exit;
  TfmPnLEmployeeReportoptions(Sender).chkPO.checked       := includePO;
  TfmPnLEmployeeReportoptions(Sender).chkLayby.checked    := includeLayby;
  TfmPnLEmployeeReportoptions(Sender).chkcheque.checked   := includecheque;
  TfmPnLEmployeeReportoptions(Sender).chkBills.checked    := includeBill;
  TfmPnLEmployeeReportoptions(Sender).chkCredits.checked  := includeCredit;
  TfmPnLEmployeeReportoptions(Sender).chkInvoice.checked  := includeInvoice;
  TfmPnLEmployeeReportoptions(Sender).chkVoucher.checked  := includeVoucher;
  TfmPnLEmployeeReportoptions(Sender).chkPOS.checked      := includePOS;
  TfmPnLEmployeeReportoptions(Sender).chkSO.checked       := includeSO;
  TfmPnLEmployeeReportoptions(Sender).chkJE.checked       := includeJE;
  TfmPnLEmployeeReportoptions(Sender).chkCashSale.checked := includeCashSale;
  TfmPnLEmployeeReportoptions(Sender).chkRefunds.checked  := includeRefund;
  if isemployee then TfmPnLEmployeeReportoptions(Sender).optCategory.itemindex :=0 else TfmPnLEmployeeReportoptions(Sender).optCategory.itemindex :=1;
end;

procedure TPnLAreaEmployeeReportGUI.InitOptionsfromform(Sender: TObject);
begin
  if not (Sender is TfmPnLEmployeeReportoptions) then exit;
  includePO       := TfmPnLEmployeeReportoptions(Sender).chkPO.checked;
  includeLayby    := TfmPnLEmployeeReportoptions(Sender).chkLayby.checked;
  includecheque   := TfmPnLEmployeeReportoptions(Sender).chkcheque.checked;
  includeBill     := TfmPnLEmployeeReportoptions(Sender).chkBills.checked ;
  includeCredit   := TfmPnLEmployeeReportoptions(Sender).chkCredits.checked ;
  includeInvoice  := TfmPnLEmployeeReportoptions(Sender).chkInvoice.checked ;
  includeVoucher  := TfmPnLEmployeeReportoptions(Sender).chkVoucher.checked ;
  includePOS      := TfmPnLEmployeeReportoptions(Sender).chkPOS.checked ;
  includeSO       := TfmPnLEmployeeReportoptions(Sender).chkSO.checked ;
  includeJE       := TfmPnLEmployeeReportoptions(Sender).chkJE.checked ;
  includeCashSale := TfmPnLEmployeeReportoptions(Sender).chkCashSale.checked ;
  includeRefund   := TfmPnLEmployeeReportoptions(Sender).chkRefunds.checked ;
  isemployee      := TfmPnLEmployeeReportoptions(Sender).optCategory.itemindex =0;
  RefreshQuery;

end;

procedure TPnLAreaEmployeeReportGUI.MakeQrymain;

begin
  With ScriptMain do try
    SQL.clear;
    SQL.add(PnlTransSQL(fsTablename, isEmployee, includePO, includeBill, includeCredit, includecheque, includeinvoice,includeVoucher,  includeSO, includeCashSale, includePOS, includeRefund, includeLayby, includeJE, filterdatefrom, filterDateTo));
  finally
    showProgressbar('Making report Data', 40);
    try
      Execute;
      QrymainSQL;
    finally
      HideProgressbar;
    end;
  end;
end;

procedure TPnLAreaEmployeeReportGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;

  if isEmployee then
    GuiPrefs.DbGridElement[grdMain].ReplaceGroupname(qryMainCategory.Fieldname, '' , 'Employee')
  else
    GuiPrefs.DbGridElement[grdMain].ReplaceGroupname(qryMainCategory.Fieldname, '' , Appenv.companyprefs.Areacolumnname );
end;

procedure TPnLAreaEmployeeReportGUI.QrymainSQL;
var
  st:TStringlist;
begin
  st:=TStringlist.create;
  try
            st.add('SELECT 0 as AccountID,');
            st.add('"INC" as AccountType,');
            st.add('"Income" as "Account Type" , ');
            st.add('Space(255) as AccountName,');
            st.add('Space(255) as Category,');
            st.add('Space(50) as AccountNo,');
            st.add('NULL, NULL, NULL, NULL, ');
            st.add('2 As FinalOrder,');
            st.add('"T" as HideTotal');
    // Income Accounts
            st.add('UNION ALL');
            st.add('SELECT AccountID,"INC" as AccountType,');
            st.add('Space(255) as "Account Type",');
            st.add('AccountName,');
            st.add('Category,');
            st.add('Accountno,');
            st.add('Sum(costEx) as CostEx , Sum(PriceEx) as PriceEx, Sum(CostInc) as CostInc, Sum(PriceInc) as PriceInc,');
            st.add('3 As FinalOrder,');

            st.add('"T" as HideTotal');
            st.add('FROM ' + fstablename + ' Where (AccountType = "EXINC" OR AccountType = "INC")');
    // Total Income
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,');
            st.add('"INC" as AccountType,');
            st.add('"Total Income" as "Account Type",');
            st.add('Space(255) as AccountName,');
            st.add('Category,');
            st.add('Space(50) as AccountNo,');
            st.add('Sum(costEx) as CostEx , Sum(PriceEx) as PriceEx, Sum(CostInc) as CostInc, Sum(PriceInc) as PriceInc,');
            st.add('4 As FinalOrder,');

            st.add('"T" as HideTotal');
            st.add('FROM ' + fstablename + ' Where (AccountType = "EXINC" OR AccountType = "INC")');
            st.add('Group By "INC", Category');
    // Space
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,');
            st.add('Space(255) as AccountType,');
            st.add('Space(255) as "Account Type",');
            st.add('Space(255) as AccountName,');
            st.add('Space(255) as Category,');
            st.add('Space(50) as AccountNo,');
            st.add('NULL, NULL, NULL, NULL, ');
            st.add('5 As FinalOrder,');

            st.add('"T" as HideTotal');
    // COGS Header
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,');
            st.add('"COGS" as AccountType,');
            st.add('"Cost of Goods Sold" as "Account Type",');
            st.add('Space(255) as AccountName,');
            st.add('Space(255) as Category,');
            st.add('Space(50) as AccountNo,');
            st.add('NULL, NULL, NULL, NULL, ');
            st.add('6 As FinalOrder,');

            st.add('"T" as HideTotal');
    // COGS Accounts
            st.add('UNION ALL');
            st.add('SELECT AccountID,AccountType,');
            st.add('Space(255) as "Account Type",');
            st.add('Accountname,');
            st.add('Category,');
            st.add('Accountno,');
            st.add('Sum(costEx) as CostEx , Sum(PriceEx) as PriceEx, Sum(CostInc) as CostInc, Sum(PriceInc) as PriceInc,');
            st.add('7 As FinalOrder,');

            st.add('"T" as HideTotal');
            st.add('FROM ' + fstablename + ' Where (AccountType = "COGS")');
            st.add('Group By Accountname, Category');
    // COGS Totals
            st.add('UNION ALL');
            st.add('SELECT  0 as AccountID,');
            st.add('"COGS" as AccountType,');
            st.add('"Total COGS" as "Account Type",');
            st.add('Space(255) as AccountName,');
            st.add('Category,');
            st.add('Space(50) as AccountNo,');
            st.add('Sum(costEx) as CostEx , Sum(PriceEx) as PriceEx, Sum(CostInc) as CostInc, Sum(PriceInc) as PriceInc,');
            st.add('8 As FinalOrder,');

            st.add('"T" as HideTotal');
            st.add('FROM ' + fstablename + ' Where (AccountType = "COGS")');
            st.add('Group By "COGS", Category');
    // Space
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,');
            st.add('Space(255) as AccountType,');
            st.add('Space(255) as "Account Type",');
            st.add('Space(255) as AccountName,');
            st.add('Space(255) as Category,');
            st.add('Space(50) as AccountNo,');
            st.add('NULL, NULL, NULL, NULL, ');
            st.add('9 As FinalOrder,');

            st.add('"T" as HideTotal');
    // Gross Profit
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,');
            st.add('Space(255) as AccountType,');
            st.add('"Gross Profit" as "Account Type",');
            st.add('Space(255) as AccountName,');
            st.add('Category,');
            st.add('Space(50) as AccountNo,');
            st.add('Sum(costEx) as CostEx , Sum(PriceEx) as PriceEx, Sum(CostInc) as CostInc, Sum(PriceInc) as PriceInc,');
            st.add('10 As FinalOrder,');

            st.add('"T" as HideTotal');
            st.add('FROM ' + fstablename + ' Where (AccountType = "COGS" OR AccountType = "EXINC" OR AccountType = "INC")');
            st.add('Group By FinalOrder, Category');
    // Space
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,');
            st.add('Space(255) as AccountType,');
            st.add('Space(255) as "Account Type",');
            st.add('Space(255) as AccountName,');
            st.add('Space(255) as Category,');
            st.add('Space(50) as AccountNo,');
            st.add('NULL, NULL, NULL, NULL, ');
            st.add('11 As FinalOrder,');


            st.add('"T" as HideTotal');
    // Expense Header
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,');
            st.add('"EXP" as AccountType,');
            st.add('"Expense" as "Account Type" , ');
            st.add('Space(255) as AccountName,');
            st.add('Space(255) as Category,');
            st.add('Space(50) as AccountNo,');
            st.add('NULL, NULL, NULL, NULL, ');
            st.add('12 As FinalOrder,');


            st.add('"T" as HideTotal');
    // Expense Accounts
            st.add('UNION ALL');
            st.add('SELECT AccountID,');
            st.add('AccountType,');
            st.add('Space(255) as "Account Type",');
            st.add('Accountname,');
            st.add('Category,');
            st.add('Accountno,');
            st.add('Sum(costEx) as CostEx , Sum(PriceEx) as PriceEx, Sum(CostInc) as CostInc, Sum(PriceInc) as PriceInc,');
            st.add('13 As FinalOrder,');

            st.add('"T" as HideTotal');
            st.add('FROM ' + fstablename + ' Where (AccountType = "EXEXP" OR AccountType = "EXP")');
            st.add('Group By Accountname, Category');
    // Expense Total
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,"EXP" as AccountType,');
            st.add('"Total Expenses" as "Account Type",');
            st.add('Space(255) as AccountName,');
            st.add('Category,');
            st.add('Space(50) as AccountNo,');
            st.add('Sum(costEx) as CostEx , Sum(PriceEx) as PriceEx, Sum(CostInc) as CostInc, Sum(PriceInc) as PriceInc,');
            st.add('14 As FinalOrder,');

            st.add('"T" as HideTotal');
            st.add('FROM ' + fstablename + ' Where (AccountType = "EXEXP" OR AccountType = "EXP")');
            st.add('Group By "EXP", Category');
    // Space
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,');
            st.add('Space(255) as AccountType,');
            st.add('Space(255) as "Account Type",');
            st.add('Space(255) as AccountName,');
            st.add('Space(255) as Category,');
            st.add('Space(50) as AccountNo,');
            st.add('NULL, NULL, NULL, NULL, ');
            st.add('15 As FinalOrder,');

            st.add('"T" as HideTotal');
    // Net Income
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,');
            st.add('Space(255) as AccountType,');
            st.add('"Net Income" as "Account Type",');
            st.add('Space(255) as AccountName,');
            st.add('Category,');
            st.add('Space(50) as AccountNo,');
            st.add('Sum(costEx) as CostEx , Sum(PriceEx) as PriceEx, Sum(CostInc) as CostInc, Sum(PriceInc) as PriceInc,');
            st.add('16 As FinalOrder,');

            st.add('"T" as HideTotal');
            st.add('FROM ' + fstablename + ' Where  (AccountType = "EXEXP" OR AccountType = "EXP" OR AccountType = "EXINC" OR AccountType = "INC" OR AccountType = "COGS")');
            st.add('Group By FinalOrder, Category');
    // Total Income Accounts  Totals Level1
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,');
            st.add('AccountType,');
            st.add('Space(255) as "Account Type",');
            st.add('LEFT(Concat("Total ",Level1,Space(255)),255) as AccountName,');
            st.add('Category,');
            st.add('Space(50) as AccountNo,');
            st.add('Sum(costEx) as CostEx , Sum(PriceEx) as PriceEx, Sum(CostInc) as CostInc, Sum(PriceInc) as PriceInc,');
            st.add('IF((AccountType = "EXINC" OR AccountType = "INC"),3,IF((AccountType = "COGS"),7,13)) As FinalOrder,');


            st.add('If( char_length(Max(Level2))>0 ,"T","F") as HideTotal');
            st.add('FROM ' + fstablename + '');
            st.add('Where AccountName<> LEvel1 and  char_length(Level1)>0 ');
            st.add('');
    // Total Income Accounts  Totals Level2
            st.add('UNION ALL');
            st.add('SELECT 0 as AccountID,');
            st.add('AccountType,');
            st.add('Space(255) as "Account Type",');
            st.add('LEFT(Concat(Space(5),REPLACE(Level2,Level2,Concat("Total ",Level2,Space(255)))),255)  as AccountName,');
            st.add('Category,');
            st.add('Space(50) as AccountNo,');
            st.add('Sum(costEx) as CostEx , Sum(PriceEx) as PriceEx, Sum(CostInc) as CostInc, Sum(PriceInc) as PriceInc,');
            st.add('IF((AccountType = "EXINC" OR AccountType = "INC"),3,IF((AccountType = "COGS"),7,13)) As FinalOrder,');

            st.add('If( char_length(Max(Level3))>0 ,"T","F") as HideTotal');
            st.add('FROM ' + fstablename + '');
            st.add('Where (AccountName <> Level1) AND (AccountName<> LEvel2 ) AND (char_length(Level2)>0) ');
            st.add('Group By AccountType,LEFT(Concat(Space(5),REPLACE(Level2,Level2,Concat("Total ",Level2,Space(255)))),255), Category');

    // Total Income Accounts  Totals Level3
            st.add('Union All');
            st.add('SELECT 0 as AccountID,');
            st.add('AccountType,');
            st.add('Space(255) as "Account Type",');
            st.add('LEFT(Concat(Space(10),REPLACE(Level3,Level3,Concat("Total ",Level3,Space(255)))),255)  as AccountName,');
            st.add('Category,');
            st.add('Space(50) as AccountNo,');
            st.add('Sum(costEx) as CostEx , Sum(PriceEx) as PriceEx, Sum(CostInc) as CostInc, Sum(PriceInc) as PriceInc,');
            st.add('IF((AccountType = "EXINC" OR AccountType = "INC"),3,IF((AccountType = "COGS"),7,13)) As FinalOrder,');

            st.add('If( char_length(Max(Level4))>0 ,"T","F") as HideTotal');
            st.add('FROM ' + fstablename + '');
            st.add('Where (AccountName <> Level1) And (AccountName <> Level2) And (char_length(Level3)>0) ');
            st.add('Group By AccountType,LEFT(Concat(Space(10),REPLACE(Level3,Level3,Concat("Total ",Level3,Space(255)))),255), Category');
            st.add('Order By FinalOrder;');
  finally
    Freeandnil(st);
  end;
end;

procedure TPnLAreaEmployeeReportGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  isEmployee      := GuiPrefs.Node['Options.IsEmployee'].AsBoolean;
  includePO       := GuiPrefs.Node['Options.IncludePO'].AsBoolean;
  includeBill     := GuiPrefs.Node['Options.Includebill'].AsBoolean;
  includeCredit   := GuiPrefs.Node['Options.IncludeCredit'].AsBoolean;
  includecheque   := GuiPrefs.Node['Options.IncludeCheque'].AsBoolean;
  includeinvoice  := GuiPrefs.Node['Options.IncludeInvoice'].AsBoolean;
  includeVoucher  := GuiPrefs.Node['Options.IncludeVoucher'].AsBoolean;
  includeSO       := GuiPrefs.Node['Options.includeSO'].AsBoolean;
  includeJE       := GuiPrefs.Node['Options.includeJE'].AsBoolean;
  includeCashSale := GuiPrefs.Node['Options.IncludeCashSale'].AsBoolean;
  includePOS      := GuiPrefs.Node['Options.IncludePOs'].AsBoolean;
  includeRefund   := GuiPrefs.Node['Options.includeRefund'].AsBoolean;
  includeLayby    := GuiPrefs.Node['Options.includeLayby'].AsBoolean;
end;

procedure TPnLAreaEmployeeReportGUI.RefreshQuery;
begin
    if isEmployee then btnCategory.Caption :='Group By ' + Appenv.companyprefs.Areacolumnname +'' else btnCategory.Caption := 'Group By Employee';

    if isEmployee then btnCategory.hint :='Change the report to group the data by the ' + Appenv.companyprefs.Areacolumnname +'' else btnCategory.hint := 'Change the report to group the data by the Employee';

    if isEmployee then TitleLabel.Caption := 'Profit And Loss - Employee' else TitleLabel.Caption := 'Profit And Loss - ' + Appenv.companyprefs.Areacolumnname +'';
    makeQrymain;
    inherited;
         if grpfilters.ItemIndex=0 then qrymainperiod.DisplayLabel := 'Trans Date'
    else if grpfilters.ItemIndex=1 then qrymainperiod.DisplayLabel := 'Week no - Year'
    else if grpfilters.ItemIndex=2 then qrymainperiod.DisplayLabel := 'Month - Year'
    else if grpfilters.ItemIndex=3 then qrymainperiod.DisplayLabel := 'Quarter - Year'
    else if grpfilters.ItemIndex=4 then qrymainperiod.DisplayLabel := 'Year';
    TimerMsg(lblDateComments, 'Please check the ''OPTIONS'' for the type of transactions included in the report');
end;

procedure TPnLAreaEmployeeReportGUI.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

procedure TPnLAreaEmployeeReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainPeriodID.FieldName);
  RemoveFieldfromGrid(QrymainDetails.FieldName);
  RemoveFieldfromGrid(qryMainOrderDate.FieldName);
  RemoveFieldfromGrid(qryMainWeekno.FieldName);
  RemoveFieldfromGrid(qryMainmonthno.FieldName);
  RemoveFieldfromGrid(qryMainQuarterno.FieldName);
  RemoveFieldfromGrid(qryMainyearno.FieldName);
end;

procedure TPnLAreaEmployeeReportGUI.ShowDetails;
begin
  btnMainList.Visible:= True;
  HighlightControl(btnMainList);
  btnMainList.bringtofront;
  DTFromClean := DTFrom.Date;
  DTToClean := DTto.Date;
  filterClean := GroupfilterString;
  FilterItemIndexclean:= grpfilters.ItemIndex;
  if QrymainDetails.asInteger = 2 then begin
     if dTFrom.date <= QrymainOrderdate.asDAtetime then DtFrom.Date:= QrymainOrderdate.asDAtetime;
     if DtTo.date   >= QrymainOrderDate.asDAtetime then DtTo.Date := QrymainOrderDate.asDAtetime;
     if GroupfilterString <> '' then GroupfilterString:= GroupfilterString +' and ';
     GroupfilterString := GroupfilterString +
                                QrymainCategory.fieldname +' =' +Quotedstr(QrymainCategory.asString) + ' and ' +
                                QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) +' and ' +
                                QrymainTransType.fieldname +' =' +Quotedstr(QrymainTransType.asString) ;
  end else if QrymainDetails.asInteger = 3 then begin
     if dTFrom.date <= QrymainOrderdate.asDAtetime then DtFrom.Date := EncodeDateWeek(qrymainyearno.AsInteger, qrymainweekno.AsInteger);
     if DtTo.date   >= QrymainOrderDate.asDAtetime then DtTo.Date := EndOfTheWeek(DtFrom.Date);
     if GroupfilterString <> '' then GroupfilterString:= GroupfilterString +' and ';
     GroupfilterString := GroupfilterString +
                                QrymainCategory.fieldname +' =' +Quotedstr(QrymainCategory.asString ) +' and ' +
                                QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) +' and ' +
                                QrymainTransType.fieldname +' =' +Quotedstr(QrymainTransType.asString) ;
  end else if QrymainDetails.asInteger = 4 then begin
     if dTFrom.date <= QrymainOrderdate.asDAtetime then DtFrom.Date := EncodeDate(qrymainyearno.AsInteger, qrymainmonthno.AsInteger , 1);
     if DtTo.date   >= QrymainOrderDate.asDAtetime then DtTo.Date := EndOfTheMonth(DtFrom.Date);
     if GroupfilterString <> '' then GroupfilterString:= GroupfilterString +' and ';
     GroupfilterString := GroupfilterString +
                                QrymainCategory.fieldname +' =' +Quotedstr(QrymainCategory.asString ) +' and ' +
                                QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) +' and ' +
                                QrymainTransType.fieldname +' =' +Quotedstr(QrymainTransType.asString) ;
  end else if QrymainDetails.asInteger = 5 then begin
     if dTFrom.date <= QrymainOrderdate.asDAtetime then DtFrom.Date := EncodeDate(qrymainyearno.AsInteger, (QrymainQuarterno.AsInteger - 1) * 3 + 1 , 1);
     if DtTo.date   >= QrymainOrderDate.asDAtetime then DtTo.Date := EndOfTheQuarter(DtFrom.Date);
     if GroupfilterString <> '' then GroupfilterString:= GroupfilterString +' and ';
     GroupfilterString := GroupfilterString +
                                QrymainCategory.fieldname +' =' +Quotedstr(QrymainCategory.asString ) +' and ' +
                                QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) +' and ' +
                                QrymainTransType.fieldname +' =' +Quotedstr(QrymainTransType.asString) ;
  end else if QrymainDetails.asInteger = 6 then begin
     if dTFrom.date <= QrymainOrderdate.asDAtetime then DtFrom.Date := EncodeDate(QrymainYearno.asInteger ,1,1);
     if DtTo.date   >= QrymainOrderDate.asDAtetime then DtTo.Date := EndOfTheYear(DtFrom.Date);
     if GroupfilterString <> '' then GroupfilterString:= GroupfilterString +' and ';
     GroupfilterString := GroupfilterString +
                                QrymainCategory.fieldname +' =' +Quotedstr(QrymainCategory.asString ) +' and ' +
                                QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) +' and ' +
                                QrymainTransType.fieldname +' =' +Quotedstr(QrymainTransType.asString) ;
  end else if QrymainDetails.asInteger = 7 then begin
     if GroupfilterString <> '' then GroupfilterString:= GroupfilterString +' and ';
     GroupfilterString := GroupfilterString +
                                QrymainCategory.fieldname +' =' +Quotedstr(QrymainCategory.asString ) +' and ' +
                                QrymainAccountname.fieldname +' =' +Quotedstr(QrymainAccountname.asString) ;
  end;
  RefreshfilterLabel;
  PreviewFilteredReport;
  RefreshQuery;
  grpfilters.ItemIndex :=0;
  grpfiltersclick(grpfilters);
end;

procedure TPnLAreaEmployeeReportGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.IsEmployee'].AsBoolean     := isEmployee;
  GuiPrefs.Node['Options.IncludePO'].AsBoolean      := includePO;
  GuiPrefs.Node['Options.Includebill'].AsBoolean    := includeBill;
  GuiPrefs.Node['Options.IncludeCredit'].AsBoolean  := includeCredit;
  GuiPrefs.Node['Options.IncludeCheque'].AsBoolean  := includecheque;
  GuiPrefs.Node['Options.IncludeInvoice'].AsBoolean := includeinvoice;
  GuiPrefs.Node['Options.IncludeVoucher'].AsBoolean := includeVoucher;
  GuiPrefs.Node['Options.includeSO'].AsBoolean      := includeSO;
  GuiPrefs.Node['Options.includeJE'].AsBoolean      := includeJE;
  GuiPrefs.Node['Options.IncludeCashSale'].AsBoolean:= includeCashSale;
  GuiPrefs.Node['Options.IncludePOs'].AsBoolean     := includePOS;
  GuiPrefs.Node['Options.includeRefund'].AsBoolean  := includeRefund;
  GuiPrefs.Node['Options.includeLayby'].AsBoolean   := includeLayby;
end;

initialization
  RegisterClassOnce(TPnLAreaEmployeeReportGUI);

end.

