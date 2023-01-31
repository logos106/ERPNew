unit ProfitandLossReportCustom;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  DBClient, Provider, wwdblook, wwcheckbox,
  SelectionDialog, DNMPanel, wwDialog, Wwlocate, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
  Shader, kbmMemTable,GuiPrefsObj, DAScript,
  MyScript, CustomInputBox, Report_ProfitnLoss_Obj, wwclearbuttongroup,
  wwradiogroup, GIFImg, ProfitAndLossSQL2;

type
  TProfitandLossCustomGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    btnDeptSelect: TDNMSpeedButton;
    lblREfreshInfo: TLabel;
    btnCashPnl: TDNMSpeedButton;
    cbkFreezeAccountname: TCheckBox;
    chkShowAllAccounts: TCheckBox;
    lblMsg: TLabel;
    rgSummary: TwwRadioGroup;
    btnLayouts: TDNMSpeedButton;
    qryLayout: TMyQuery;
    qryMainAccountID: TIntegerField;
    qryMainIsRoot: TWideStringField;
    qryMainSubTotalInc: TFloatField;
    qryMainSubTotalEx: TFloatField;
    btnPnLStandard: TDNMSpeedButton;
    qryMainSeqNo: TLargeintField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboClassChange(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnPnlByPeriodcompClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnDeptSelectClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure chkIncludehistory1111Click(Sender: TObject);
    procedure btnCashPnlClick(Sender: TObject);
    procedure cbkFreezeAccountnameClick(Sender: TObject);
    procedure chkShowAllAccountsClick(Sender: TObject);
    procedure rgSummaryClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnLayoutsClick(Sender: TObject);
    procedure btnPnLStandardClick(Sender: TObject);

  private
    { Private declarations }
    fbFromBalanceSheet: boolean;
    fDateTo: TDateTime;
    fDateFrom: TDateTime;
    bDoingLabelChange: boolean;
    xDateFrom, xdateto:TDateTime;
    xIncludehistory:Boolean;
    fbformShown:boolean;
    DoPopulateReportTable: boolean;
    fShowAllAccounts: Boolean;
    DoingFormShow: boolean;

    Procedure LabelChange;
    //Procedure CreateTranstable;
//    Procedure CreateTempTable;
    Procedure ToBeRefreshed;
    procedure OnScriptTempError(Sender: TObject; E: Exception; SQL: string;var Action: TErrorAction);
//    procedure MakeReportTable;
    procedure CallLabelChange;
    procedure OnShowProfitandLossByPeriodGUI(Sender: TObject);
    procedure OnShowCashPnLByPeriodGUI(Sender: TObject);
    procedure OnShowProfitandLossGUI(Sender: TObject);
//    function IsClassselected(sClassId: Integer): Boolean;
//    function SubtotalUpdateSQL: String;
    Procedure classmsg;
  protected
//    fsTablename :String;
    FCFields :String;
    ReportTransactionTableObj: TProfitnLoss_Report_Obj;
    SelectedDepartments: TStrings;
    PnLSQLObj: TProfitAndLossReport2;

    function GetReportTypeID: integer; override;
    procedure RefreshQuery; override;
    Procedure PopulateReportTable;override;
    procedure RefreshAll;Override;
//    procedure CleanRefresh_PL_Table;Virtual;
    function formprefix :String; virtual;
    procedure PriortoClosingdateMsg;virtual;
    function clientID: Integer; virtual;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure FormDoShowProgressbar(
      ProgressCount: integer; ProgressBarCaption: string;
      ProgressBarMessage: string = '';
      IsPercenage:boolean = true;
      aTimerUpdate: Boolean = False;
      OnCancelEvent :TNotifyEvent = nil;
      aAllowCancel:Boolean = False);
    procedure FormDoStepProgressBar(const ProgressBarMessage: String = '');
    procedure FormDoHideProgressBar();
  public
    { Public declarations }
    property FromBalanceSheet: boolean read fbFromBalanceSheet write fbFromBalanceSheet;
    property ToDate: TDateTime read fDateTo write fDateTo;
    property FromDate: TDateTime read fDateFrom write fDateFrom;
  end;


implementation

uses FastFuncs,DNMlib, TransAccountDetailsForm,  BalanceSheetForm,
  StrUtils,
  DateUtils, Types, Commonlib,Systemlib, Forms,
   AppEnvironment, tcConst, CommonDbLib,frmPayDeptSelectionGUI,
  (*ProfitandLossReportByPeriod, *)tcDataUtils, ThreadDataset, CommonFormLib,
   MySQLConst, CashProfitandLoss, TempTableUtils, LogLib,
  ProfitandLossPeriodCompare, ProfitandLossReportByPeriod, BusObjClass,
  PnLLayout, ProfitandLossReportForm, PnLLayouts;

{$R *.dfm}

procedure TProfitandLossCustomGUI.grdMainDblClick(Sender: TObject);
var
  sTitles, sFilter, sSortID, sAccName, sClassName: string;
  iClassID: integer;
  frmTransAccountDetails: TComponent;
  ctr:Integer;
  ipos :Integer;
  colprops:TStringList;
begin
  if rgSummary.ItemIndex = 1 then begin
    { if in summary mode change to detail .. }
    rgSummary.ItemIndex := 0;
    exit;
  end;
  { else do the usual stuff .. }

  if qrymain.fieldbyname('AccountId').asinteger = 0 then Exit;
  sFilter   := '';
  sSortID   := '';
  sAccName  := '';
  sTitles   := '';
  sClassName:= '';

  sSortID   := Trim(qryMain.FieldByName('AccountType').AsString);
  sAccName  := Trim(qryMain.FieldByName('AccountName').AsString);
  sTitles   := Trim(qryMain.FieldByName('Account Type').AsString);

  sClassName:= grdMain.GetActiveField.DisplayLabel;
  sClassName:= ReplaceStr(ReplaceStr(sClassName, ' (Inc)', ''), ' (Ex)', '');
  iClassID  := GetDeptID(sClassName);
  if iClassid = 0 then begin {foreign currencies enabled}
    sClassName := TField(grdMain.GetActiveField).FieldName;
    for ctr := 0 to grdMain.Selected.count - 1 do begin
      iPos:=  Pos(sClassname, grdMain.Selected[ctr]);
      if iPOs > 0 then begin
          Split(grdMain.Selected[ctr] , #9 , colprops);
          if colprops.Count >= 5 then
            sClassName := colprops[4]
          else
            sClassName := '';
          break;
      end;
    end;
    if sClassName <> '' then begin
      sClassName := ReplaceStr(ReplaceStr(sClassName, ' (Inc)', ''), ' (Ex)', '');
      iClassID := GetDeptID(sClassName);
    end
    else
      iClassID := 0;
  end;

  if not (Empty(sSortID) and Empty(sAccName) and Empty(sTitles)) then begin
    if FormStillOpen('TTransAccountDetailsGUI') then begin
      frmTransAccountDetails := FindExistingComponent('TTransAccountDetailsGUI');
      TForm(frmTransAccountDetails).Close;
      Freeandnil(frmTransAccountDetails);
      sleep(100);
    end;
    if not FormStillOpen('TTransAccountDetailsGUI') then begin
      frmTransAccountDetails := GetComponentByClassName('TTransAccountDetailsGUI');
      if Assigned(frmTransAccountDetails) then begin
        with  TTransAccountDetailsGUI(frmTransAccountDetails) do begin
          FromDate := 0;
          ToDate := (*self.dtto.DateTime*)self.filterdateto;
          FromDate := (*self.dtFrom.DateTime*)self.filterdateFrom;
          fbDateRangeSupplied := true;
          InverseCreditvsDebits := True;
          chkIncludehistory.Checked := self.chkIncludehistory.Checked;
          chkIgnoreDates.Checked    := self.chkIgnoreDates.Checked;

          clientID := Self.ClientID;
          if AnsiContainsText(sSortID, 'INC') and Empty(sAccName) then begin
            sFilter := '(AccountType = "EXINC" OR AccountType = "INC")';
          end else if AnsiContainsText(sSortID, 'INC') and not Empty(sAccName) then begin
            sFilter := '(AccountType = "EXINC" OR AccountType = "INC") AND AccountName = ' + QuotedStr(sAccName) + '';
          end else if AnsiContainsText(sSortID, 'COGS') and Empty(sAccName) then begin
            sFilter := 'AccountType = "COGS"';
          end else if AnsiContainsText(sSortID, 'COGS') and not Empty(sAccName) then begin
            sFilter := 'AccountType = "COGS" AND AccountName = ' + QuotedStr(sAccName) + '';
          end else if AnsiContainsText(sSortID, 'EXP') and Empty(sAccName) then begin
            sFilter := '(AccountType = "EXEXP" OR AccountType = "EXP")';
          end else if AnsiContainsText(sSortID, 'EXP') and not Empty(sAccName) then begin
            sFilter := '(AccountType = "EXEXP" OR AccountType = "EXP") AND AccountName = ' + QuotedStr(sAccName) + '';
          end else if AnsiContainsText(sSortID, 'EXP') and Empty(sAccName) then begin
            sFilter := '(AccountType = "EXEXP" OR AccountType = "EXP")';
          end else if AnsiContainsText(sSortID, 'EXP') and not Empty(sAccName) then begin
            sFilter := '(AccountType = "EXEXP" OR AccountType = "EXP") AND AccountName = ' + QuotedStr(sAccName) + '';
          end else if AnsiContainsText(sTitles, 'Net Income') and Empty(sAccName) then begin
            sFilter :=
              '((AccountType = "EXEXP" OR AccountType = "EXP") OR (AccountType = "EXINC" OR AccountType = "INC") OR AccountType = "COGS")';
          end else if AnsiContainsText(sTitles, 'Gross Profit') and Empty(sAccName) then begin
            sFilter :=
              '(AccountType = "COGS" OR (AccountType = "EXINC" OR AccountType = "INC"))';
          end;
          if iClassID <> 0 then begin
            sFilter := sFilter + ' AND ((T.Level1=' + QuotedStr(sClassName) +') OR ' +
                                       '(T.Level2=' + QuotedStr(sClassName) +') OR ' +
                                       '(T.Level3=' + QuotedStr(sClassName) +') OR ' +
                                       '(T.Level4=' + QuotedStr(sClassName) +'))';

          end;
          qryMain.SQL.Add('AND ' + sFilter + ' Group by TransID;');
          WhereString := 'AND (' + sFilter + ')';
          SearchMode := smFullList;
          FormStyle := fsmdiChild;
        end;
      end;
    end else begin
      frmTransAccountDetails := FindExistingComponent('TTransAccountDetailsGUI');
      fbDateRangeSupplied := true;
      TForm(frmTransAccountDetails).Show;
    end;
  end;
end;

procedure TProfitandLossCustomGUI.RefreshQuery;
begin
  if Searching then RefreshAll else ToBeRefreshed;
end;

procedure TProfitandLossCustomGUI.rgSummaryClick(Sender: TObject);
begin
  inherited;
  if DoingFormShow then exit;
  PnLSQLObj.DetailReport := rgSummary.ItemIndex = 0;
  RefreshAll;
end;

procedure TProfitandLossCustomGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  cbkFreezeAccountname.checked     := StrToBoolean(GuiPrefs.Node['General.FreezeAccountname'].AsString);
  chkShowAllAccounts.checked     := StrToBoolean(GuiPrefs.Node['General.ShowSubTotals'].AsString);
  rgSummary.ItemIndex := GuiPrefs.Node['rgSummary.ItemIndex'].AsInteger;
  PnLSQLObj.AllAccounts := chkShowAllAccounts.checked;
  PnLSQLObj.DetailReport := rgSummary.ItemIndex = 0;
end;

Procedure TProfitandLossCustomGUI.RefreshAll;
var
  iMaxLevel, K : Integer;
begin
  qryMain.DisableControls;
  try
    try
      qryMain.Close;

      // Check if the default layout exists
      with qryLayout do begin
        SQL.Clear;
        SQL.Add('SELECT COUNT(*) AS cnt FROM tblPnLLayouts WHERE DefaultLayout="T"');
        Open;

        if FieldByName('cnt').AsInteger < 1  then begin
          MessageDlgXP_Vista('No default layout set.',
                    mtWarning, [mbOK], 0);

          Exit;
        end;

      end;

      // Populate the data to default layout
      PopulateReportTable;

      // Add fields for levels to qryMain
      with qryLayout do begin
        SQL.Clear;
        SQL.Add('SELECT (MAX(LENGTH(Pos)) DIV 2) AS ML FROM tblPnLLayoutData ld');
        SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
        SQL.Add('WHERE ls.DefaultLayout="T" AND IsAccount="F"');
        Open;
        iMaxLevel := FieldByName('ML').AsInteger;

        for K := 1 to iMaxLevel do begin
          if qryMain.FindField('Level' + IntToStr(K)) <> nil then Continue;
          with TWideStringField.Create(Self) do begin
            FieldKind := fkData;
            FieldName := 'Level' + IntToStr(K);
            Name := 'qryMainLevel' + IntToStr(K);
            DataSet := qryMain;
            Visible := True;
          end;
        end;
        Close;
      end;

      DonotChangeGridLabels := True;
      DoShowProgressbar(6, 'Refreshing Report' );
      try
        DoStepProgressbar;
        inherited RefreshQuery;
        DoStepProgressbar;
        Application.ProcessMessages;
        DoStepProgressbar;
        GroupFilterString := '[HideTotal]=' + QuotedStr('T');
        DoStepProgressbar;
        self.ApplyQueryFilter;
        LabelChange;
        DoStepProgressbar;
        Application.ProcessMessages;
      finally
        DohideProgressbar;
      end;
      if not (dtFrom.DroppedDown) then if CompareDate((*dtFrom.DateTime*)filterdateFrom, AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*)) = LessThanValue then begin
          Priortoclosingdatemsg;
      end;
      Application.ProcessMessages;
    finally
      xDateFrom := filterdatefrom;
      xdateTo   := Filterdateto;
      xIncludehistory:= IncludedataPriorToClosingDate;
      fShowAllAccounts := chkShowAllAccounts.Checked;
      ToBeRefreshed;
      DoHideProgressbar;
      ClassMsg;
    end;
  finally
    qryMain.EnableControls;
  end;
end;

Procedure TProfitandLossCustomGUI.PriortoClosingdateMsg;
begin
  if IncludedataPriorToClosingDate = False then
    CommonLib.MessageDlgXP_Vista('The From Date Selected Is Prior To The Closing Date.' + #13 + #10 + #13 + #10 +
        ' - All Transactions Prior To This Date Are Summarised ' + #13 + #10 +
        '    to One Entry On This Date.' + #13 + #10 + #13 + #10 +
        ' - Current Closing Date - ' + FormatDateTime('dddd, mmmm d, yyyy', AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*)),
        mtInformation, [mbOK], 0);
end;
procedure TProfitandLossCustomGUI.ToBeRefreshed;
begin
  lblREfreshInfo.visible :=
              ( xDateFrom <> filterdatefrom) or
              (xIncludehistory <> IncludedataPriorToClosingDate) or
              (xdateTo   <> Filterdateto) or
              (fShowAllAccounts <> chkShowAllAccounts.Checked);
end;


procedure TProfitandLossCustomGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['General.FreezeAccountname'].AsString  := BooleanToStr(cbkFreezeAccountname.checked);
  if cbkFreezeAccountname.checked then begin
    GuiPrefs.Node['General.ColWidths.C1'].AsInteger := grdMain.ColWidths[1];
    GuiPrefs.Node['General.ColWidths.C2'].AsInteger := grdMain.ColWidths[2];
    GuiPrefs.Node['General.ColWidths.C3'].AsInteger := grdMain.ColWidths[3];
  end;
  if chkAllClass.Checked then
      GuiPrefs.Node['SelectedDepartments'].AsString:= ''
  else GuiPrefs.Node['SelectedDepartments'].AsString:= SelectedDepartments.CommaText;

  GuiPrefs.Node['General.ShowSubTotals'].AsString  := BooleanToStr(chkShowAllAccounts.checked);
  GuiPrefs.Node['rgSummary.ItemIndex'].AsInteger := rgSummary.ItemIndex;
end;

(*Procedure TProfitandLossCustomGUI.CreateTranstable;
begin
    CreateTempTable;
    MakeReportTable;
end;*)
procedure TProfitandLossCustomGUI.dtFromChange(Sender: TObject);
begin
  inherited;
  ToBeRefreshed;
end;

procedure TProfitandLossCustomGUI.dtToChange(Sender: TObject);
begin
  inherited;
  ToBeRefreshed;
end;


Procedure TProfitandLossCustomGUI.PopulateReportTable;
var
  msg: string;

begin
  if not DoPopulateReportTable then
    Exit;

  PnlSQLObj.IncludePriorClosingDate := chkIncludehistory.Checked;
  PnlSQLObj.DateFrom := self.FilterDateFrom;
  PnlSQLObj.DateTo := self.FilterDateTo;
  PnlSQLObj.ClientId := Self.clientID;
  PnlSQLObj.PopulateReportSQL(QryMain.SQL, msg);
  RefreshOrignalSQL;
end;

procedure TProfitandLossCustomGUI.FormCreate(Sender: TObject);
begin
    PnLSQLObj := TProfitAndLossReport2.Create;
    PnLSQLObj.APIMode := false;
    PnLSQLObj.ReportClassName := self.ClassName;
    PnLSQLObj.OnShowProgressBar := FormDoShowProgressBar;
    PnLSQLObj.OnStepProgressBar := FormDoStepProgressBar;
    PnLSQLObj.OnHideProgressBar := FormDoHideProgressBar;
    DoingFormShow := false;
//    fstablename := commondblib.GetUserTemporaryTableName('PnL');
    fbIncludehistory:= True;
    DoPopulateReportTable:= true;
    fbformShown:= false;
    bDoingLabelChange:= false;
    IsGridcustomisable      := False;
    CanCreatecustomReport   := False;
    ReportonForeignCurrency := True;
    inherited;
    SearchMode:= smFullList;
    StringListForSQL:=TStringList.create;
    PnLSQLObj.StringListForSQL := StringListForSQL;
    SelectedDepartments := TStringList.Create;
    if ErrorOccurred then Exit;
    ReportTransactionTableObj := TProfitnLoss_Report_Obj.Create(True);
    ShowChartViewOnPopup := True;
    NonSearchReport := True;
    Brush.Style := bsClear;
end;

procedure TProfitandLossCustomGUI.FormShow(Sender: TObject);
var
  I, K : integer;
  iMaxLevel : Integer;
begin
  DoingFormShow := true;
  try
    if not ErrorOccurred then begin
        GroupFilterString := '[HideTotal]=' + QuotedStr('T');
        self.ApplyQueryFilter;

        SelectedDepartments.CommaText:= GuiPrefs.Node['SelectedDepartments'].AsString;

        for I := 0 to SelectedDepartments.Count -1 do begin
          if I > 0 then PnlSQLObj.SelectedDepartments := PnlSQLObj.SelectedDepartments + ',';
          PnlSQLObj.SelectedDepartments :=
            PnlSQLObj.SelectedDepartments + TDeptClass.IDToggle(StrToInt(SelectedDepartments[I]));
        end;


        chkAllClass.OnClick:= nil;
        try
          chkAllClass.Checked:= SelectedDepartments.Count = 0;
        finally
          chkAllClass.OnClick:= chkAllClassClick;
        end;
        chkShowAllAccounts.Checked := GuiPrefs.Node['ShowAllAccounts'].AsBoolean;
        fShowAllAccounts := chkShowAllAccounts.Checked;

        if fbFromBalanceSheet then begin
            dtFrom.DateTime := 0;
            dtTo.DateTime := fDateTo;
        end;
        inherited;
        cbkFreezeAccountname.left := chkAdvancedPrinting.Left + chkAdvancedPrinting.width + 5;
        cbkFreezeAccountname.top := chkAdvancedPrinting.top;
        Refreshall;
        if cbkFreezeAccountname.checked then begin
          if GuiPrefs.Node['General.ColWidths.C1'].AsInteger > 0 then
            grdMain.ColWidths[1] := GuiPrefs.Node['General.ColWidths.C1'].AsInteger;
          if GuiPrefs.Node['General.ColWidths.C2'].AsInteger > 0 then
            grdMain.ColWidths[2] := GuiPrefs.Node['General.ColWidths.C2'].AsInteger;
          if GuiPrefs.Node['General.ColWidths.C3'].AsInteger > 0 then
            grdMain.ColWidths[3] := GuiPrefs.Node['General.ColWidths.C3'].AsInteger;
        end;
        Application.ProcessMessages;

        if fbFormOpenedOk then begin
          lblClassTitle.Caption := AppEnv.DefaultClass.ClassHeading;
        end;
    end else begin
      CommonLib.MessageDlgXP_Vista('You do not have access to Profit and Loss Report!', mtInformation, [mbOK], 0);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
    end;
    fbformShown:= true;

    btninc.Visible := False;

  finally
    DoingFormShow := false;
  end;
end;

procedure TProfitandLossCustomGUI.cbkFreezeAccountnameClick(Sender: TObject);
begin
  inherited;
  if cbkFreezeAccountname.Checked then begin
    grdMain.SelectedField := qryMain.Fields[4];
    grdMain.FixedCols     := 3;
  end else begin
    grdMain.FixedCols := 0;
  end;

end;

procedure TProfitandLossCustomGUI.cboClassChange(Sender: TObject);
begin
  inherited;
  CallLabelChange;
end;

procedure TProfitandLossCustomGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  DoShowProgressbar(4 , 'Refreshing Report' );
  try

    if chkAllClass.Checked then begin
        GuiPrefs.Node['SelectedDepartments'].AsString:= '';
        PnlSQLObj.SelectedDepartments := '';
        PnlSQLObj.AllDepartments := true;
    end
    else begin
      GuiPrefs.Node['SelectedDepartments'].AsString:= SelectedDepartments.CommaText;
        PnlSQLObj.SelectedDepartments := SelectedDepartments.CommaText;
        PnlSQLObj.AllDepartments := false;
    end;

      with Scriptmain do try
        SQL.clear;
        SQL.add(PnlSQLObj.SubtotalUpdateSQL);
        Execute;
        DoStepProgressbar;
      finally
        SQL.clear;
        closedb(qrymain);
        OpenDB(Qrymain);
        DoStepProgressbar;
      end;
      CallLabelChange;
    DoStepProgressbar;
  finally
    classmsg;
    DohideProgressbar;
  end;
end;

procedure TProfitandLossCustomGUI.chkIncludehistory1111Click(Sender: TObject);
begin
  inherited;
  ToBeRefreshed;
end;

procedure TProfitandLossCustomGUI.chkShowAllAccountsClick(Sender: TObject);
begin
  inherited;
  PnLSQLObj.AllAccounts := chkShowAllAccounts.checked;
  ToBeRefreshed;
end;

procedure TProfitandLossCustomGUI.classmsg;
begin
  if not(chkAllClass.Checked)  then
        TimerMsg(lblMsg, '"Sub Total Ex/Inc" shows the total amount of the ' + Appenv.DefaultClass.ClassHeading +'(s) selected and "Total Amount Ex/Inc" is the total of all  ' + Appenv.DefaultClass.ClassHeading +'(s)' );
end;

Procedure TProfitandLossCustomGUI.CallLabelChange;
begin
  if not(fbformShown) then exit;
  ProcessingCursor;
  try
    DoShowProgressbar(2 , 'Refreshing Report' );
    try
      DoStepProgressbar;
      if Qrymain.active = false then Exit;
      DoStepProgressbar;
      LabelChange;
    finally
      DohideProgressbar;
    end;
  finally
    ProcessingCursor(False);
  end;
end;

procedure TProfitandLossCustomGUI.LabelChange;
var
  groupprefix :String;
  FieldPrefix :String;
  x_colWidth  :Integer;
  iMaxLevel : Integer;
  K : Integer;

  procedure AddForeignCurrencies;
    var
      fs: string;
  begin
    FConReport.First;
    while FConReport.EOF = False do begin
      fs := FCOnReportCode.asString + fieldPrefix;
      AddGridSelectedfield(fs, x_colWidth, FCOnReportCode.asString, GroupPrefix);
      if qryMain.FindField(fs) <> nil then
          TFloatField(qrymain.FindField(fs)).DisplayFormat := AnsiReplaceStr(FConReportSymbol.AsString, '.' , '' ) + '###,###,###,##0.0#';
      FConReport.Next;
    end;
  end;

begin
  if bDoingLabelChange then Exit;
  bDoingLabelChange:= true;
  try
    x_colWidth := 12;
    if grdMain.titlelines < 2 then grdMain.titlelines := 2;
    SetIndicatorbutton;
    FieldList := TStringList.Create;
    try
      if devmode then begin
        AddGridSelectedfield('Seqno', 1 , 'Seqno');
      end;

//      AddGridSelectedfield('Account Type', 15 ,'Account Type');
      AddGridSelectedfield('AccountName1', 25, 'Account Name');
      AddGridSelectedfield('AccountNo', 1, 'Account No');

      // Add levels
      with qryLayout do begin
        SQL.Clear;
        SQL.Add('SELECT (MAX(LENGTH(Pos)) DIV 2) AS ML FROM tblPnLLayoutData ld');
        SQL.Add('LEFT JOIN tblPnLLayouts ls ON ld.LayoutID=ls.LayoutID');
        SQL.Add('WHERE ls.DefaultLayout="T" AND IsAccount="F"');
        Open;
        iMaxLevel := FieldByName('ML').AsInteger;
        for K := 1 to iMaxLevel do
          AddGridSelectedfield('Level' + IntToStr(K), 15, 'Level' + InttoStr(K));
        Close;
      end;

      if ActiveClasses.RecordCount > 0 then begin
        ActiveClasses.First;
        while ActiveClasses.Eof = False do begin
            if (chkAllClass.checked)
           // or IsClassselected(ActiveClasses.fieldByname('ClassId').asInteger) then begin
            or PnlSQLObj.DepartmentSelected(ActiveClasses.fieldByname('ClassName').asString) then begin
              if (grpFilters.ItemIndex = 0) or (grpFilters.ItemIndex = 2) then begin
                if ReportonForeignCurrency then begin
                    fieldPrefix := '_' + (*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnEx' ;
                    GroupPrefix := ActiveClasses.fieldByname('ClassName').asString + ' (Ex)' ;
                    AddGridSelectedfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnEx',x_colWidth ,Appenv.RegionalOptions.ForeignExDefault,  GroupPrefix );
                    AddForeignCurrencies;
                end else begin
                  AddGridSelectedfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) +'_AmountColumnEx',x_colWidth , ActiveClasses.fieldByname('ClassName').asString + ' (Ex)' );
                end;
                if qryMain.FindField((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnEx') <> nil then
                  TFloatfield(qryMain.FindField((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnEx')).Currency := True;
              end;

              if (grpFilters.ItemIndex = 1) or (grpFilters.ItemIndex = 2) then begin
                if ReportonForeignCurrency then begin
                    fieldPrefix := '_' + (*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnInc' ;
                    GroupPrefix := ActiveClasses.fieldByname('ClassName').asString + ' (Inc)' ;
                    AddGridSelectedfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnInc',x_colWidth ,Appenv.RegionalOptions.ForeignExDefault,  GroupPrefix);
                    Addforeigncurrencies;
                end else begin
                  AddGridSelectedfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) +'_AmountColumnInc',x_colWidth , ActiveClasses.fieldByname('ClassName').asString + ' (Inc)' );
                end;
                if qryMain.FindField((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnInc') <> nil then
                  TFloatfield(qryMain.FindField((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnInc')).Currency := true;
              end;
          End;

          ActiveClasses.Next;
        end;
      end;

      if qryMain.FindField('SubTotalInc') <> nil then TFloatfield(qryMain.FindField('SubTotalInc')).Currency := True;
      if qryMain.FindField('SubTotalEx')  <> nil then TFloatfield(qryMain.FindField('SubTotalEx')).Currency := True;

      if (grpFilters.ItemIndex = 0) or (grpFilters.ItemIndex = 2) then begin
        if ReportonForeignCurrency then begin
          fieldPrefix := '_TotalAmountEx';
          GroupPrefix := 'Total Amount (Ex)';
          if not (chkAllClass.checked) then begin
            AddGridSelectedfield('SubTotalEx', x_colWidth, 'SubTotal (Ex)');
          end;
          AddGridSelectedfield('TotalAmountEx', x_colWidth, Appenv.RegionalOptions.ForeignExDefault, GroupPrefix);
          AddForeignCurrencies;
        end else Begin
          if not (chkAllClass.checked) then begin
            AddGridSelectedfield('SubTotalEx', x_colWidth, 'SubTotal (Ex)');
          end;
          AddGridSelectedfield('TotalAmountEx', x_colWidth, 'Total Amount (Ex)');
        end;
        if qryMain.FindField('TotalAmountEx') <> nil then
            TFloatfield(Qrymain.findfield('TotalAmountEx')).currency := True;
      end;

      if (grpFilters.ItemIndex = 1) or (grpFilters.ItemIndex = 2) then  begin
        if ReportonForeignCurrency then begin
          fieldPrefix := '_TotalAmountInc';
          GroupPrefix :='Total Amount (Inc)' ;
          if  not (chkAllClass.checked) then begin
            AddGridSelectedfield('SubTotalInc', x_colWidth, 'SubTotal (Inc)');
          end;
          AddGridSelectedfield('TotalAmountInc', x_colWidth, Appenv.RegionalOptions.ForeignExDefault, GroupPrefix);
          AddForeignCurrencies;
        end else Begin
          if not (chkAllClass.checked) then begin
            AddGridSelectedfield('SubTotalInc', x_colWidth, 'SubTotal (Inc)');
          end;
          AddGridSelectedfield('TotalAmountInc', x_colWidth, 'Total Amount (Inc)');
        end;
        if qryMain.FindField('TotalAmountInc') <> nil then
          TFloatfield(qryMain.FindField('TotalAmountInc')).Currency := True;
      end;

      if Assigned(FieldList) then begin
        grdMain.Selected := FieldList;
        grdMain.ApplySelected;
      end;
    finally
      FreeAndNil(FieldList);
    end;
  finally
    bDoingLabelChange := false;
  end;
end;

procedure TProfitandLossCustomGUI.OnScriptTempError(Sender: TObject; E: Exception;  SQL: string; var Action: TErrorAction);
begin
  inherited;
  Action := eaContinue ;
end;

procedure TProfitandLossCustomGUI.grpFiltersClick(Sender: TObject);
begin
  CallLabelChange;
end;

procedure TProfitandLossCustomGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
    inherited;
    if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
    if (qryMain.fieldbyname('IsRoot').AsString = 'T') then
        AFont.Style := AFont.Style + [fsBold];


  if (FastFuncs.posex(uppercase('amountcolumn') ,uppercase(field.fieldName)) > 0) or
     (FastFuncs.posex(uppercase('totalamount')  ,uppercase(field.fieldName)) > 0) or
     (sametext('SubTotalInc', field.fieldName)) or
     (sametext('SubTotalEx', field.fieldName))  then
        if field.Asfloat = 0 then
            AFont.Color := Abrush.color;
end;

function TProfitandLossCustomGUI.GetReportTypeID: integer;
begin
  Result := 37;
end;

procedure TProfitandLossCustomGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    ReportSQLSupplied   := true;
    UseStringListForSQL := true;
    TemplateFilter := ' [HideTotal]=' + QuotedStr('T');
    Try
      StringListForSQL.Text := StringReplace(StringListForSQL.Text,':fromDate' ,Quotedstr(FormatDatetime(MysqlDateFormat, dtFrom.DateTime)), [rfIgnoreCase, rfReplaceAll]);
      StringListForSQL.Text := StringReplace(StringListForSQL.Text,':toDate'   ,Quotedstr(FormatDatetime(MysqlDateFormat, filterdateto   )), [rfIgnoreCase, rfReplaceAll]);

      StringListForSQL.Text := StringReplace(StringListForSQL.Text,':txtfrom' ,Quotedstr(FormatDatetime(MysqlDateFormat , dtFrom.DateTime)), [rfIgnoreCase, rfReplaceAll]);
      StringListForSQL.Text := StringReplace(StringListForSQL.Text,':txtto'   ,Quotedstr(FormatDatetime(MysqlDateFormat, (*dtto.DateTime*)filterdateto     )), [rfIgnoreCase, rfReplaceAll]);
      inherited;
    finally
      ReportSQLSupplied   := false;
      TemplateFilter := '';
      UseStringListForSQL := false;
    end;
  finally
    EnableForm;
  end;
end;

procedure TProfitandLossCustomGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TProfitandLossByPeriodGUI' , OnShowProfitandLossByPeriodGUI);
  Self.Close;
end;

procedure TProfitandLossCustomGUI.btnPnlByPeriodcompClick(Sender: TObject);
begin
  OpenERPListForm('TProfitandLossPeriodCompareGUI' , OnShowProfitandLossByPeriodGUI);
  Self.Close;
end;

procedure TProfitandLossCustomGUI.btnPnLStandardClick(Sender: TObject);
begin
  OpenERPListForm('TProfitandLossGUI', OnshowProfitandLossGUI);
  Self.Close;
end;

procedure TProfitandLossCustomGUI.OnshowProfitandLossGUI(Sender: TObject);
begin
  if TProfitandLossGUI(Sender).dtTo.DateTime   <> self.dtTo.DateTime   then TProfitandLossGUI(Sender).dtTo.DateTime   := self.dtTo.DateTime;
  if TProfitandLossGUI(Sender).dtFrom.DateTime <> self.dtFrom.DateTime then TProfitandLossGUI(Sender).dtFrom.DateTime := self.dtFrom.DateTime;
  TProfitandLossGUI(Sender).fbDateRangeSupplied := true;
  TProfitandLossGUI(Sender).fbIncludehistory    := fbIncludehistory;
  TProfitandLossGUI(Sender).chkIncludehistory.Checked := chkIncludehistory.Checked;
end;

procedure TProfitandLossCustomGUI.OnShowProfitandLossByPeriodGUI(Sender:TObject);
begin
      if sender is TProfitandLossByPeriodGUI then begin
        if TProfitandLossByPeriodGUI(Sender).dtTo.DateTime <> self.dtTo.DateTime then TProfitandLossByPeriodGUI(Sender).dtTo.DateTime := self.dtTo.DateTime;
        if TProfitandLossByPeriodGUI(Sender).dtFrom.DateTime <> self.dtFrom.DateTime then TProfitandLossByPeriodGUI(Sender).dtFrom.DateTime := self.dtFrom.DateTime;
        TProfitandLossByPeriodGUI(Sender).fbDateRangeSupplied := true;
        TProfitandLossByPeriodGUI(Sender).fbIncludehistory := fbIncludehistory;
        TProfitandLossByPeriodGUI(Sender).chkIncludehistory.Checked := chkIncludehistory.Checked;
      end else if sender is TProfitandLossPeriodCompareGUI then begin
        if TProfitandLossPeriodCompareGUI(Sender).dtTo.DateTime <> self.dtTo.DateTime then TProfitandLossPeriodCompareGUI(Sender).dtTo.DateTime := self.dtTo.DateTime;
        if TProfitandLossPeriodCompareGUI(Sender).dtFrom.DateTime <> self.dtFrom.DateTime then TProfitandLossPeriodCompareGUI(Sender).dtFrom.DateTime := self.dtFrom.DateTime;
        TProfitandLossPeriodCompareGUI(Sender).fbDateRangeSupplied := true;
        TProfitandLossPeriodCompareGUI(Sender).fbIncludehistory := fbIncludehistory;
        TProfitandLossPeriodCompareGUI(Sender).chkIncludehistory.Checked := chkIncludehistory.Checked;
      end;
end;

procedure TProfitandLossCustomGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.FieldDefs.Update;
end;

procedure TProfitandLossCustomGUI.FormDestroy(Sender: TObject);
begin
  Freeandnil(ReportTransactionTableObj);
//  DeleteTable(fstablename);
  FreeAndNil(SelectedDepartments);
  PnLSQLObj.Free;
  inherited;
end;

procedure TProfitandLossCustomGUI.FormDoHideProgressBar;
begin
  DoHideProgressBar;
end;

procedure TProfitandLossCustomGUI.FormDoShowProgressbar(ProgressCount: integer;
  ProgressBarCaption, ProgressBarMessage: string; IsPercenage,
  aTimerUpdate: Boolean; OnCancelEvent: TNotifyEvent; aAllowCancel: Boolean);
begin
  DoShowProgressBar(ProgressCount, ProgressBarCaption, ProgressBarMessage,
  IsPercenage, aTimerUpdate, OnCancelEvent, aAllowCancel);
end;

procedure TProfitandLossCustomGUI.FormDoStepProgressBar(
  const ProgressBarMessage: String);
begin
  DoStepProgressBar(ProgressBarMessage);
end;

function TProfitandLossCustomGUI.formprefix: String;
begin
  REsult := 'PnL';
end;

procedure TProfitandLossCustomGUI.actRefreshQryExecute(Sender: TObject);
begin
//  inherited;
    RefreshAll;
end;

procedure TProfitandLossCustomGUI.btnCashPnlClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TCashProfitandLossGUI' , OnShowCashPnLByPeriodGUI);
  Self.Close;
end;

procedure TProfitandLossCustomGUI.OnShowCashPnLByPeriodGUI(Sender:TObject);
begin
        if TCashProfitandLossGUI(Sender).dtTo.DateTime <> self.dtTo.DateTime then TCashProfitandLossGUI(Sender).dtTo.DateTime := self.dtTo.DateTime;
        if TCashProfitandLossGUI(Sender).dtFrom.DateTime <> self.dtFrom.DateTime then TCashProfitandLossGUI(Sender).dtFrom.DateTime := self.dtFrom.DateTime;
        TCashProfitandLossGUI(Sender).fbDateRangeSupplied := true;
        TCashProfitandLossGUI(Sender).fbIncludehistory := fbIncludehistory;
        TCashProfitandLossGUI(Sender).chkIncludehistory.Checked := chkIncludehistory.Checked;
end;

procedure TProfitandLossCustomGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    DoPopulateReportTable:= false;
    try
      RefreshAll;
    finally
      DoPopulateReportTable:= true;
    end;
  finally
    EnableForm;
  end;
end;

function TProfitandLossCustomGUI.clientID: Integer;
begin
  Result := 0;
end;

procedure TProfitandLossCustomGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProfitandLossCustomGUI.btnLayoutsClick(Sender: TObject);
var
  layouts : TfrmPnlLayouts;
begin
  inherited;
  try
    layouts := TfrmPnlLayouts.Create(nil);
    layouts.ShowModal;
  finally
    layouts.Free;
  end;
end;

procedure TProfitandLossCustomGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProfitandLossCustomGUI.btnDeptSelectClick(Sender: TObject);
var
  s:String;
  I: integer;
begin
  inherited;
  fShowAllAccounts :=chkShowAllAccounts.checked;
  s:= SelectedDepartments.commatext;
  if DoDepartmentSelection(SelectedDepartments,fShowAllAccounts, False, true) then begin
    if sametext(SelectedDepartments.commatext , s) and not(chkAllClass.Checked) then exit;
    if chkAllClass.Checked then chkAllClass.Checked := False;

    PnlSQLObj.AllDepartments := chkAllClass.Checked;
//    PnlSQLObj.SelectedDepartments := SelectedDepartments.CommaText;
    PnlSQLObj.SelectedDepartments := '';
    for I := 0 to SelectedDepartments.Count -1 do begin
      if I > 0 then PnlSQLObj.SelectedDepartments := PnlSQLObj.SelectedDepartments + ',';
      PnlSQLObj.SelectedDepartments :=
        PnlSQLObj.SelectedDepartments + TDeptClass.IDToggle(StrToInt(SelectedDepartments[I]));
    end;

    DoShowProgressbar(14 , 'Refreshing Report' );
    try
      with Scriptmain do try
        SQL.clear;
        SQL.add(PnlSQLObj.SubtotalUpdateSQL);
        Execute;
        DoStepProgressbar;
      finally
        SQL.clear;
        closedb(qrymain);
        OpenDB(Qrymain);
        DoStepProgressbar;
      end;
      LabelChange;
      DoStepProgressbar;
      chkShowAllAccounts.checked := fShowAllAccounts;
      if chkAllClass.Checked then
          GuiPrefs.Node['SelectedDepartments'].AsString:= ''
      else GuiPrefs.Node['SelectedDepartments'].AsString:= SelectedDepartments.CommaText;
    finally
      classmsg;
      DohideProgressbar;
    end;
  end;

end;

//procedure TProfitandLossCustomGUI.CreateTempTable;
//begin
//  CreateTemporyTableFromTemplate( GetSharedMyDacConnection, TABLE_PROFITANDLOSSREPORT , fsTablename );
//(*var
//  strSQL:String;
//begin
//      fsTablename := commondbLib.CreateUserTemporaryTable(TABLE_PROFITANDLOSSREPORT , formprefix);
//      strSQL := 'alter table ' + fsTablename+' Add column SubTotalInc double default null;'+
//                'alter table ' + fsTablename+' Add column SubTotalEx double default null;';
//      ExecuteSQL(strSQL);*)
//end;

procedure TProfitandLossCustomGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose:= not self.ReportTransactionTableObj.DoingRefresh;
end;

initialization
  RegisterClassOnce(TProfitandLossCustomGUI);
end.






