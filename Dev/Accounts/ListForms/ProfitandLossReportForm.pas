unit ProfitandLossReportForm;

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
  wwradiogroup, GIFImg, ProfitAndLossSQL, BusObjProfitLoss;

type
  TProfitandLossGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    btnPnlByPeriodcomp: TDNMSpeedButton;
    qryMainAccountID: TLargeintField;
    qryMainAccountType: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainFinalOrder: TLargeintField;
    qryMainAccountHeaderOrder: TWideStringField;
    qryMainAccountSub1Order: TWideStringField;
    qryMainAccountSub2Order: TWideStringField;
    qryMainAccountSub3Order: TWideStringField;
    qryMainHideTotal: TWideStringField;
    btnDeptSelect: TDNMSpeedButton;
    qryMainSubTotalInc: TFloatField;
    qryMainSubTotalEx: TFloatField;
    qryMainAccountNo: TWideStringField;
    lblREfreshInfo: TLabel;
    btnCashPnl: TDNMSpeedButton;
    cbkFreezeAccountname: TCheckBox;
    chkShowAllAccounts: TCheckBox;
    qryMainSeqno: TLargeintField;
    lblMsg: TLabel;
    rgSummary: TwwRadioGroup;
    DNMSpeedButton1: TDNMSpeedButton;
    qryLayout: TMyQuery;
    btnPnlCustom: TDNMSpeedButton;
    qryDisplayReport: TERPQuery;
    qrySaveReport: TERPQuery;
    dsDisplayReport: TDataSource;
    qryIndex: TERPQuery;
    qryUpdateTotal: TERPQuery;
    qryDeleteTotals: TERPQuery;
    qryDisplayReportAccountID: TLargeintField;
    qryDisplayReportAccountType: TWideStringField;
    qryDisplayReportAccountType2: TWideStringField;
    qryDisplayReportAccountNo: TWideStringField;
    qryDisplayReportAccountName: TWideStringField;
    qryDisplayReportFinalOrder: TLargeintField;
    qryDisplayReportAccountHeaderOrder: TWideStringField;
    qryDisplayReportAccountSub1Order: TWideStringField;
    qryDisplayReportAccountSub2Order: TWideStringField;
    qryDisplayReportAccountSub3Order: TWideStringField;
    qryDisplayReportSubTotalInc: TFloatField;
    qryDisplayReportSubTotalEx: TFloatField;
    qryDisplayReportHideTotal: TWideStringField;
    qryDisplayReportSeqno: TLargeintField;
    DNMSpeedButton2: TDNMSpeedButton;
    qryMainAccountType2: TWideStringField;
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
    procedure cmdLayoutClick(Sender: TObject);
    procedure btnPnlCustomClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);


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
    procedure OnShowProfitandLossCustomGUI(Sender:TObject);
//    function IsClassselected(sClassId: Integer): Boolean;
//    function SubtotalUpdateSQL: String;
    Procedure classmsg;


    procedure AddLayoutAutoIncField(name : string);
    procedure AddLayoutStringField(name : string);
    procedure AddLayoutIntegerField(name : string);
    procedure AddLayoutFloatField(name : string);

  protected
//    fsTablename :String;
    FCFields :String;
    ReportTransactionTableObj: TProfitnLoss_Report_Obj;
    SelectedDepartments: TStrings;

    PnLSQLObj: TProfitAndLossReport;
    ObjLayout: TProfitLossLayout;

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
  StrUtils, DBGrids,
  DateUtils, Types, Commonlib,Systemlib, Forms,
   AppEnvironment, tcConst, CommonDbLib,frmPayDeptSelectionGUI,
  (*ProfitandLossReportByPeriod, *)tcDataUtils, ThreadDataset, CommonFormLib,
   MySQLConst, CashProfitandLoss, TempTableUtils, LogLib,
  ProfitandLossPeriodCompare, ProfitandLossReportByPeriod, BusObjClass,
  PnLLayout, PnLLayouts, ProfitandLossReportCustom, ClipBrd, ProfitLossLayoutsForm;

{$R *.dfm}

procedure TProfitandLossGUI.grdMainDblClick(Sender: TObject);
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
          qryMain.SQL.Add('AND ' + sFilter + ' GROUP BY TransID;');
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

procedure TProfitandLossGUI.RefreshQuery;
begin
  if Searching then RefreshAll else ToBeRefreshed;
end;

procedure TProfitandLossGUI.rgSummaryClick(Sender: TObject);
begin
  inherited;
  if DoingFormShow then exit;
  PnLSQLObj.DetailReport := rgSummary.ItemIndex = 0;
  RefreshAll;
end;

procedure TProfitandLossGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  cbkFreezeAccountname.checked     := StrToBoolean(GuiPrefs.Node['General.FreezeAccountname'].AsString);
  chkShowAllAccounts.checked     := StrToBoolean(GuiPrefs.Node['General.ShowSubTotals'].AsString);
  rgSummary.ItemIndex := GuiPrefs.Node['rgSummary.ItemIndex'].AsInteger;
  PnLSQLObj.AllAccounts := chkShowAllAccounts.checked;
  PnLSQLObj.DetailReport := rgSummary.ItemIndex = 0;
end;

Procedure TProfitandLossGUI.RefreshAll;
begin
  qryMain.DisableControls;
  try
    try
      qryMain.Close;

      PopulateReportTable;

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

Procedure TProfitandLossGUI.PriortoClosingdateMsg;
begin
  if IncludedataPriorToClosingDate = False then
    CommonLib.MessageDlgXP_Vista('The From Date Selected Is Prior To The Closing Date.' + #13 + #10 + #13 + #10 +
        ' - All Transactions Prior To This Date Are Summarised ' + #13 + #10 +
        '    to One Entry On This Date.' + #13 + #10 + #13 + #10 +
        ' - Current Closing Date - ' + FormatDateTime('dddd, mmmm d, yyyy', AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*)),
        mtInformation, [mbOK], 0);
end;

procedure TProfitandLossGUI.ToBeRefreshed;
begin
  lblREfreshInfo.visible :=
              ( xDateFrom <> filterdatefrom) or
              (xIncludehistory <> IncludedataPriorToClosingDate) or
              (xdateTo   <> Filterdateto) or
              (fShowAllAccounts <> chkShowAllAccounts.Checked);
end;

procedure TProfitandLossGUI.WriteGuiPrefExtra;
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

(*Procedure TProfitandLossGUI.CreateTranstable;
begin
    CreateTempTable;
    MakeReportTable;
end;*)
procedure TProfitandLossGUI.dtFromChange(Sender: TObject);
begin
  inherited;
  ToBeRefreshed;
end;

procedure TProfitandLossGUI.dtToChange(Sender: TObject);
begin
  inherited;
  ToBeRefreshed;
end;

//Procedure TProfitandLossGUI.MakeReportTable;
//var
//    ScripTemp: TERPScript;
//    ctr :Integer;
//    QrymainSQLList: TStringList;
//begin
//    QrymainSQLList:= TStringList.Create;
//    try
//        if not (Owner is TBalanceSheetGUI) then begin
//            ScripTemp := commondblib.TempMyScript;
//            Try
//              ScripTemp.OnError :=OnScriptTempError;
//                CreateTempTable;
//                FCFields := '';
//                QrymainSQLList.Add('Alter table ' + fsTablename );
//                for ctr := low(AmountFields) to high(AmountFields) do begin
//                    if ctr > 0 then QrymainSQLList.Add(',');
//                    QrymainSQLList.Add(' Add column  `' +  AmountFields[ctr]  + '` Double');
//                end;
//                if FConReport.RecordCount > 0 then begin
//                    FCOnReport.first;
//                    while FConReport.Eof = False do begin
//                        QrymainSQLList.Add(',');
//                        for ctr := low(AmountFields) to high(AmountFields) do
//                            QrymainSQLList.Add(' Add column  `' + FCOnReportCode.asString + '_' + AmountFields[ctr]  + '` Double,');
//                        QrymainSQLList.Add(' Add column  ' + FCOnReportCode.asString + '_FCRate Double');
//
//                        if FCFields <> '' then FCFields := FCFields + ',' ;
//                        FCFields := FCFields + FCOnReportCode.asString + '_FCRate';
//                        FCOnReport.Next;
//                    end;
//                end;
//                QrymainSQLList.Add(';');
//                QrymainSQLList.Add('Alter table ' + fsTablename +' Add column  `Accountno` varchar(50);' );
//                ScripTemp.SQL.clear;
//                ScripTemp.SQL.add(ChangeQuery(QrymainSQLList.TExt));
//                ScripTemp.Execute;
//                QrymainSQLList.clear;
//            Finally
//              Freeandnil(ScripTemp);
//            End;
//        End;
//    finally
//      if Assigned(QrymainSQLList) then FreeAndNil(QrymainSQLList);
//    end;
//end;

//Procedure TProfitandLossGUI.CleanRefresh_PL_Table;
//begin
//  ReportTransactionTableObj.CleanRefresh_PL_Table(filterdatefrom, filterdateto, fsTablename, FCFields , 0 , IncludedataPriorToClosingDate);
//end;

//
//Function TProfitandLossGUI.SubtotalUpdateSQL:String;
//var
//  SubTotalIncSQL , SubTotalExSQL :String;
//begin
//  REsult := 'Update ' + fsTableName + ' Set SubTotalInc = 0;' +
//            'Update ' + fsTableName + ' Set SubTotalEx  = 0;';
//  if chkAllClass.checked  then exit;
//  if ActiveClasses.recordcount =0 then exit;
//
//   ActiveClasses.First;
//   SubTotalIncSQL := '';
//   SubTotalExSQL  := '';
//   while ActiveClasses.Eof = False do begin
//       if IsClassselected(ActiveClasses.fieldByname('ClassId').asInteger) then begin
//         if SubTotalIncSQL <> '' then SubTotalIncSQL := SubTotalIncSQL + ' + '; SubTotalIncSQL := SubTotalIncSQL + '`' + (*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnInc`  ';
//         if SubTotalExSQL  <> '' then SubTotalExSQL  := SubTotalExSQL  + ' + '; SubTotalExSQL  := SubTotalExSQL  + '`' + (*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnEx`  ';
//       End;
//       ActiveClasses.Next;
//   end;
//   if SubTotalIncSQL <> '' then REsult := Result + '  Update ' + fsTableName + ' Set SubTotalInc = ' + SubTotalIncSQL+';';
//   if SubTotalExSQL <> '' then REsult := Result + '  Update ' + fsTableName + ' Set SubTotalEx = ' + SubTotalExSQL+';';
//
//end;

Procedure TProfitandLossGUI.PopulateReportTable;
var
  msg: string;
  SQL: TStringList;
  displayFieldNames: TStringList;
  // fieldsToShow : string;
begin
  if not DoPopulateReportTable then
    Exit;

  PnlSQLObj.IncludePriorClosingDate := chkIncludehistory.Checked;
  PnlSQLObj.DateFrom := self.FilterDateFrom;
  PnlSQLObj.DateTo := self.FilterDateTo;
  PnlSQLObj.ClientId := Self.clientID;

  SQL := TStringList.Create;

//  PnlSQLObj.PopulateReportSQL(SQL, msg);
  PnlSQLObj.PopulateReportSQL1(SQL, msg);
  qryMain.SQL.Text := SQL.Text;

  if PnlSQLObj.UseCustomLayout then begin
    // Exit;
    //  grdMain.DataSource := dsDisPlayReport;
    //    PnlSQLObj.CalculateTotals(SQL);
    qryDisplayReport.SQL.Text := SQL.Text;
    //      ShowMessage('qryDisplayReport.SQL.Text   ' + qryDisplayReport.SQL.Text);
    //        fld := TWideStringField.Create(ds);
    grdMain.DataSource := dsDisplayReport;
    qryMain := qryDisplayReport;
    Clipboard.AsText := qryDisplayReport.SQL.Text;
    //              ShowMessage(qryDisplayReport.SQL.Text);
    displayFieldNames := TStringList.Create;
    qryMain.GetFieldNames(displayFieldNames);
    //    ShowMessage('displayFieldNames ' + displayFieldNames.Text);
    qryDisplayReport.Open;
    //  qryDisplayReport.Refresh;
    //         qryDisplayReport.Close;
    //         qryDisplayReport.Open;
     //   ShowMessage('LabelChange ');
    LabelChange;
  end;
 // FormActivate(nil);
  RefreshOrignalSQL;
end;

procedure TProfitandLossGUI.AddLayoutAutoIncField(name : string);
var
  field : TField;
begin
  field := TAutoIncField.Create(qryDisplayReport);
  field.Name := '';
  field.FieldName := name;
  field.Dataset := qryDisplayReport;
end;

procedure TProfitandLossGUI.AddLayoutStringField(name : string);
var
  field : TField;
begin
  field := TWideStringField.Create(qryDisplayReport);
  field.Name := '';
  field.FieldName := name;
  field.Dataset := qryDisplayReport;
end;

procedure TProfitandLossGUI.AddLayoutIntegerField(name : string);
var
  field : TField;
begin
  field := TIntegerField.Create(qryDisplayReport);
  field.Name := '';
  field.FieldName := name;
  field.Dataset := qryDisplayReport;
end;

procedure TProfitandLossGUI.AddLayoutFloatField(name : string);
var
  field : TField;
begin
  field := TFloatField.Create(qryDisplayReport);
  field.Name := '';
  field.FieldName := name;
  field.Dataset := qryDisplayReport;
end;

procedure TProfitandLossGUI.FormCreate(Sender: TObject);
var
  fldLevel1Order : TField;
  fldLevel1Total : TField;
  Col: TwwColumn;
begin
  PnLSQLObj := TProfitAndLossReport.Create;
  PnLSQLObj.APIMode := false;
  PnLSQLObj.ReportClassName := self.ClassName;
  PnLSQLObj.OnShowProgressBar := FormDoShowProgressBar;
  PnLSQLObj.OnStepProgressBar := FormDoStepProgressBar;
  PnLSQLObj.OnHideProgressBar := FormDoHideProgressBar;

   {$WARNINGS OFF}
  ObjLayout := TProfitLossLayout.CreateWithNewConn(Self);
  ObjLayout.Connection.connection := Self.MyConnection1;
  ObjLayout.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}

  if ObjLayout.GetLayoutToUse = 0 then begin
    PnlSQLObj.UseCustomLayout := false
  end else begin
    PnlSQLObj.UseCustomLayout := true;

 //   grdMain.DataSource := dsDisPlayReport;

    AddLayoutAutoIncField('ReportIndex');
    //   AddLayoutField('HideTotal');

    AddLayoutStringField('LayoutAccountName');
    AddLayoutStringField('LayoutAccountType');

   //          AddLayoutStringField('Account No');

    AddLayoutIntegerField('Level0Order');
    AddLayoutIntegerField('IsLevel0Total');
    AddLayoutIntegerField('Level1Order');
    AddLayoutIntegerField('IsLevel1Total');
    AddLayoutIntegerField('Level2Order');
    AddLayoutIntegerField('IsLevel2Total');
    AddLayoutIntegerField('Level3Order');
    AddLayoutIntegerField('IsLevel3Total');
    AddLayoutStringField('IsAccount');
    AddLayoutFloatField('1_AmountColumnInc');
    AddLayoutFloatField('2_AmountColumnInc');
    AddLayoutFloatField('3_AmountColumnInc');
    AddLayoutFloatField('1_AmountColumnEx');
    AddLayoutFloatField('2_AmountColumnEx');
    AddLayoutFloatField('3_AmountColumnEx');
    AddLayoutFloatField('TotalAmountInc');
    AddLayoutFloatField('TotalAmountEx');

         //     AddGridSelectedfield('LayoutAccountName', 25, 'Layout Account Name');


      //  Col := grdMain.Columns.InsertBeforeColumn('AccountName');

    //  Col := TwwColumn.Create(grdMain, 'LayoutAccountName');

      //  grdMain.Columns[1]  := Col;

//    Col.Expanded := False;
//    Col.FieldName := 'LayoutAccountName';
//    Col.Title.Caption := 'Layout Account Name' ;
//    Col.Width := 100;

//        fldLevel1Order := TIntegerField.Create(qryDisplayReport);
//        fldLevel1Order.Name := '';
//        fldLevel1Order.FieldName := 'Level1Order';
//        fldLevel1Order.Dataset := qryDisplayReport;

 //     qryMain := qryDisplayReport;

  end;

  DoingFormShow := false;
  //    fstablename := commondblib.GetUserTemporaryTableName('PnL');
  fbIncludehistory := True;
  DoPopulateReportTable := true;
  fbformShown:= false;
  bDoingLabelChange:= false;
  //    IsGridcustomisable      := False;
  CanCreatecustomReport   := False;
  ReportonForeignCurrency := True;

  inherited;

  SearchMode := smFullList;
  StringListForSQL := TStringList.create;
  PnLSQLObj.StringListForSQL := StringListForSQL;
  SelectedDepartments := TStringList.Create;
  if ErrorOccurred then Exit;
  ReportTransactionTableObj := TProfitnLoss_Report_Obj.Create(True);
  ShowChartViewOnPopup := True;
  NonSearchReport := True;
  Brush.Style := bsClear;

  //  ShowMessage(DateTimeToStr(dtFrom.DateTime));
      //     FormActivate(Sender);

end;

procedure TProfitandLossGUI.FormShow(Sender: TObject);
var
  I: integer;
begin
  DoingFormShow := true;
  try
    if not ErrorOccurred then begin
      GroupFilterString := '[HideTotal]=' + QuotedStr('T');
      self.ApplyQueryFilter;

      SelectedDepartments.CommaText := GuiPrefs.Node['SelectedDepartments'].AsString;

      for I := 0 to SelectedDepartments.Count - 1 do begin
        if I > 0 then PnlSQLObj.SelectedDepartments := PnlSQLObj.SelectedDepartments + ',';
        PnlSQLObj.SelectedDepartments :=
          PnlSQLObj.SelectedDepartments + TDeptClass.IDToggle(StrToInt(SelectedDepartments[I]));
      end;

      chkAllClass.OnClick := nil;
      try
        chkAllClass.Checked := SelectedDepartments.Count = 0;
      finally
        chkAllClass.OnClick := chkAllClassClick;
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
      dtFrom.DateTime := IncMonth(dtFrom.DateTime, - 3);

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

procedure TProfitandLossGUI.cbkFreezeAccountnameClick(Sender: TObject);
begin
  inherited;
  if cbkFreezeAccountname.Checked then begin
    grdMain.SelectedField := qryMain.Fields[4];
    grdMain.FixedCols     := 3;
  end else begin
    grdMain.FixedCols := 0;
  end;

end;

procedure TProfitandLossGUI.cboClassChange(Sender: TObject);
begin
  inherited;
  CallLabelChange;
end;

procedure TProfitandLossGUI.chkAllClassClick(Sender: TObject);
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
procedure TProfitandLossGUI.chkIncludehistory1111Click(Sender: TObject);
begin
  inherited;
  ToBeRefreshed;
end;

procedure TProfitandLossGUI.chkShowAllAccountsClick(Sender: TObject);
begin
  inherited;
  PnLSQLObj.AllAccounts := chkShowAllAccounts.checked;
  ToBeRefreshed;
end;

procedure TProfitandLossGUI.classmsg;
begin
  if not(chkAllClass.Checked)  then
        TimerMsg(lblMsg, '"Sub Total Ex/Inc" shows the total amount of the ' + Appenv.DefaultClass.ClassHeading +'(s) selected and "Total Amount Ex/Inc" is the total of all  ' + Appenv.DefaultClass.ClassHeading +'(s)' );
end;

Procedure TProfitandLossGUI.CallLabelChange;
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

//Function TProfitandLossGUI.IsClassselected(sClassId:Integer):Boolean;
//  var i:integer;
//begin
//  Result := False;
//  for i := 0 to SelectedDepartments.Count - 1 do
//  begin
//    if isinteger(SelectedDepartments.Strings[i]) and (strtoInt(SelectedDepartments.Strings[i]) = sClassId) then Result := True;
//  end;
//end;

procedure TProfitandLossGUI.LabelChange;
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
        AddGridSelectedfield('Seqno', 1 , 'Seqno'  );
      end;


    if PnlSQLObj.UseCustomLayout then
     begin
        AddGridSelectedfield('LayoutAccountType', 15, 'Account Type');
        AddGridSelectedfield('LayoutAccountName', 25, 'Account Name');
     end
     else
     begin
      AddGridSelectedfield('Account Type', 15, 'Account Type');
      AddGridSelectedfield('AccountName', 25, 'Account Name');
    end;


      AddGridSelectedfield('AccountNo', 1, 'Account No');

      if ActiveClasses.recordcount > 0 then begin
        ActiveClasses.First;
        while ActiveClasses.Eof = False do begin
            if (chkAllClass.checked)
           // or IsClassselected(ActiveClasses.fieldByname('ClassId').asInteger) then begin
            or PnlSQLObj.DepartmentSelected(ActiveClasses.fieldByname('ClassName').asString) then begin
                if (grpFilters.ItemIndex = 0) or (grpFilters.ItemIndex=2) then begin
                    if ReportonForeignCurrency then begin
                        fieldPrefix := '_' + (*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnEx' ;
                        GroupPrefix :=ActiveClasses.fieldByname('ClassName').asString + ' (Ex)' ;
                        AddGridSelectedfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnEx',x_colWidth ,Appenv.RegionalOptions.ForeignExDefault,  GroupPrefix );
                        Addforeigncurrencies;
                    end else begin
                      AddGridSelectedfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) +'_AmountColumnEx',x_colWidth , ActiveClasses.fieldByname('ClassName').asString + ' (Ex)' );
                    end;
                    if Qrymain.findfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnEx') <> nil then
                      TFloatfield(Qrymain.findfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnEx')).Currency := True;
                end;

                if (grpFilters.ItemIndex = 1) or (grpFilters.ItemIndex=2) then begin
                    if ReportonForeignCurrency then begin
                        fieldPrefix := '_' + (*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnInc' ;
                        GroupPrefix :=ActiveClasses.fieldByname('ClassName').asString + ' (Inc)' ;
                        AddGridSelectedfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnInc',x_colWidth ,Appenv.RegionalOptions.ForeignExDefault,  GroupPrefix);
                        Addforeigncurrencies;
                    end else begin
                      AddGridSelectedfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) +'_AmountColumnInc',x_colWidth , ActiveClasses.fieldByname('ClassName').asString + ' (Inc)' );
                    end;
                    if Qrymain.findfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnInc') <> nil then
                      TFloatfield(Qrymain.findfield((*ActiveClasses.fieldByname('ClassName').asString*)Trim(inttostr(ActiveClasses.FieldByName('classId').asInteger)) + '_AmountColumnInc')).Currency := true;
                end;
            End;

            ActiveClasses.Next;
        end;
      end;

      if Qrymain.findfield('SubTotalInc') <> nil then TFloatfield(Qrymain.findfield('SubTotalInc')).Currency := True;
      if Qrymain.findfield('SubTotalEx')  <> nil then TFloatfield(Qrymain.findfield('SubTotalEx')).Currency := True;


      if (grpFilters.ItemIndex = 0) or (grpFilters.ItemIndex=2) then begin
        if ReportonForeignCurrency then begin
            fieldPrefix :=  '_TotalAmountEx';
            GroupPrefix :='Total Amount (Ex)' ;
            if  not (chkAllClass.checked) then begin
              AddGridSelectedfield('SubTotalEx',x_colWidth , 'SubTotal (Ex)'  );
            end;
            AddGridSelectedfield('TotalAmountEx',x_colWidth ,Appenv.RegionalOptions.ForeignExDefault,  GroupPrefix  );
            Addforeigncurrencies;
        end else Begin
          if  not (chkAllClass.checked) then begin
            AddGridSelectedfield('SubTotalEx',x_colWidth , 'SubTotal (Ex)'  );
          end;
          AddGridSelectedfield('TotalAmountEx',x_colWidth , 'Total Amount (Ex)'  );
        end;
        if Qrymain.findfield('TotalAmountEx') <> nil then
            TFloatfield(Qrymain.findfield('TotalAmountEx')).currency := True;
      end;

      if (grpFilters.ItemIndex = 1) or (grpFilters.ItemIndex=2) then  begin
        if ReportonForeignCurrency then begin
          fieldPrefix := '_TotalAmountInc';
          GroupPrefix :='Total Amount (Inc)' ;
          AddGridSelectedfield('TotalAmountInc',x_colWidth ,Appenv.RegionalOptions.ForeignExDefault,  GroupPrefix  );
          if  not (chkAllClass.checked) then begin
            AddGridSelectedfield('SubTotalInc', x_colWidth , 'SubTotal (Inc)'  );
          end;

          Addforeigncurrencies;
        end else Begin
          if  not (chkAllClass.checked) then begin
            AddGridSelectedfield('SubTotalInc', x_colWidth , 'SubTotal (Inc)'  );
          end;
          AddGridSelectedfield('TotalAmountInc', x_colWidth , 'Total Amount (Inc)'  );
        end;
        if Qrymain.findfield('TotalAmountInc') <> nil then
          TFloatfield(Qrymain.findfield('TotalAmountInc')).Currency := True;
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

procedure TProfitandLossGUI.OnScriptTempError(Sender: TObject; E: Exception;  SQL: string; var Action: TErrorAction);
begin
  inherited;
  Action := eaContinue ;
end;

procedure TProfitandLossGUI.grpFiltersClick(Sender: TObject);
begin
  CallLabelChange;
end;

//procedure TProfitandLossGUI.HandleGridPaint(var Msg: TMessage);
//begin
//  ShowImage;
//
//end;

procedure TProfitandLossGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
    inherited;
    if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }

    if not PnlSQLObj.UseCustomLayout then
    begin
         if (qryMain.fieldbyname('AccountID').AsString = '0') then
            AFont.Style := AFont.Style + [fsBold];

   //       if (qryMain.fieldbyname('Level1Order').AsInteger = 0) then
   //         AFont.Color := Abrush.color;

    end
    else
    begin
         if (qryMain.fieldbyname('AccountID').AsString = '0') or (qryMain.fieldbyname('IsLevel0Total').AsInteger = 1)
            or (qryMain.fieldbyname('IsLevel1Total').AsInteger = 1) or (qryMain.fieldbyname('IsLevel2Total').AsInteger = 1)
            or (qryMain.fieldbyname('IsAccount').AsString = 'F') then
               AFont.Style := AFont.Style + [fsBold];
    end;


  if (FastFuncs.posex(uppercase('amountcolumn') ,uppercase(field.fieldName)) > 0) or
     (FastFuncs.posex(uppercase('totalamount')  ,uppercase(field.fieldName)) > 0) or
     (sametext('SubTotalInc'  ,field.fieldName)) or
     (sametext('SubTotalEx'  ,field.fieldName))  then
        if field.Asfloat = 0 then
            AFont.Color := Abrush.color;

end;


function TProfitandLossGUI.GetReportTypeID: integer;
begin
  Result := 37;
end;

procedure TProfitandLossGUI.cmdPrintClick(Sender: TObject);
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

procedure TProfitandLossGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TProfitandLossByPeriodGUI' , OnShowProfitandLossByPeriodGUI);
  Self.Close;
end;

procedure TProfitandLossGUI.DNMSpeedButton2Click(Sender: TObject);
var
  layouts : TProfitLossLayoutsGUI;
begin
  inherited;
  try
    layouts := TProfitLossLayoutsGUI.Create(nil);
    layouts.ShowModal;
  finally
    layouts.Free;
  end;

//  inherited;
//  OpenERPListForm('TProfitandLossCustomGUI' , OnShowProfitandLossCustomGUI);
  Self.Close;
end;

procedure TProfitandLossGUI.btnPnlByPeriodcompClick(Sender: TObject);
begin
  OpenERPListForm('TProfitandLossPeriodCompareGUI' , OnShowProfitandLossByPeriodGUI);
  Self.Close;
end;

procedure TProfitandLossGUI.btnPnlCustomClick(Sender: TObject);
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

//  inherited;
//  OpenERPListForm('TProfitandLossCustomGUI' , OnShowProfitandLossCustomGUI);
  Self.Close;
end;

procedure TProfitandLossGUI.OnShowProfitandLossCustomGUI(Sender:TObject);
begin
  if TProfitandLossCustomGUI(Sender).dtTo.DateTime <> self.dtTo.DateTime then TProfitandLossCustomGUI(Sender).dtTo.DateTime := self.dtTo.DateTime;
  if TProfitandLossCustomGUI(Sender).dtFrom.DateTime <> self.dtFrom.DateTime then TProfitandLossCustomGUI(Sender).dtFrom.DateTime := self.dtFrom.DateTime;
  TProfitandLossCustomGUI(Sender).fbDateRangeSupplied := true;
  TProfitandLossCustomGUI(Sender).fbIncludehistory := fbIncludehistory;
  TProfitandLossCustomGUI(Sender).chkIncludehistory.Checked := chkIncludehistory.Checked;
end;

procedure TProfitandLossGUI.OnShowProfitandLossByPeriodGUI(Sender:TObject);
begin
  if Sender is TProfitandLossByPeriodGUI then begin
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

procedure TProfitandLossGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.FieldDefs.Update;
end;

procedure TProfitandLossGUI.FormDestroy(Sender: TObject);
begin
  Freeandnil(ReportTransactionTableObj);
//  DeleteTable(fstablename);
  FreeAndNil(SelectedDepartments);
  PnLSQLObj.Free;
  inherited;
end;
procedure TProfitandLossGUI.FormDoHideProgressBar;
begin
  DoHideProgressBar;
end;

procedure TProfitandLossGUI.FormDoShowProgressbar(ProgressCount: integer;
  ProgressBarCaption, ProgressBarMessage: string; IsPercenage,
  aTimerUpdate: Boolean; OnCancelEvent: TNotifyEvent; aAllowCancel: Boolean);
begin
  DoShowProgressBar(ProgressCount, ProgressBarCaption, ProgressBarMessage,
  IsPercenage, aTimerUpdate, OnCancelEvent, aAllowCancel);
end;

procedure TProfitandLossGUI.FormDoStepProgressBar(
  const ProgressBarMessage: String);
begin
  DoStepProgressBar(ProgressBarMessage);
end;

function TProfitandLossGUI.formprefix: String;
begin
  REsult := 'PnL';
end;

procedure TProfitandLossGUI.actRefreshQryExecute(Sender: TObject);
begin
//  inherited;
    RefreshAll;
end;

procedure TProfitandLossGUI.btnCashPnlClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TCashProfitandLossGUI' , OnShowCashPnLByPeriodGUI);
  Self.Close;
end;

procedure TProfitandLossGUI.OnShowCashPnLByPeriodGUI(Sender:TObject);
begin
  if TCashProfitandLossGUI(Sender).dtTo.DateTime <> self.dtTo.DateTime then TCashProfitandLossGUI(Sender).dtTo.DateTime := self.dtTo.DateTime;
  if TCashProfitandLossGUI(Sender).dtFrom.DateTime <> self.dtFrom.DateTime then TCashProfitandLossGUI(Sender).dtFrom.DateTime := self.dtFrom.DateTime;
  TCashProfitandLossGUI(Sender).fbDateRangeSupplied := true;
  TCashProfitandLossGUI(Sender).fbIncludehistory := fbIncludehistory;
  TCashProfitandLossGUI(Sender).chkIncludehistory.Checked := chkIncludehistory.Checked;
end;
procedure TProfitandLossGUI.btnCustomizeClick(Sender: TObject);
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

function TProfitandLossGUI.clientID: Integer;
begin
  Result := 0;
end;

procedure TProfitandLossGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProfitandLossGUI.cmdLayoutClick(Sender: TObject);
var
  frmLayout : TfmPnLLayout;
begin
  inherited;
  try
//    frmLayout := TForm(GetcomponentByClassName('TfmPnLLayout', False, Self, False));
//    frmLayout.ShowModal;

    frmLayout := TfmPnLLayout.Create(nil);
    frmLayout.ShowModal;
  finally
//    FreeAndNil(frmLayout);
    frmLayout.Free;
  end;

end;

procedure TProfitandLossGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TProfitandLossGUI.btnDeptSelectClick(Sender: TObject);
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

//procedure TProfitandLossGUI.CreateTempTable;
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

procedure TProfitandLossGUI.FormActivate(Sender: TObject);
var
  fieldNames : TStringList;
  f : Integer;

  finalOrder : Integer;

  totalLevel0Amount_1Inc : Double;
  totalLevel0Amount_2Inc : Double;
  totalLevel0Amount_3Inc : Double;
  totalLevel0AmountTotalInc : Double;


  totalLevel1Amount_1Inc : Double;
  totalLevel1Amount_2Inc : Double;
  totalLevel1Amount_3Inc : Double;
  totalLevel1AmountTotalInc : Double;

  totalLevel2Amount_1Inc : Double;
  totalLevel2Amount_2Inc : Double;
  totalLevel2Amount_3Inc : Double;
  totalLevel2AmountTotalInc : Double;


  totalLevel0Amount_1Ex : Double;
  totalLevel0Amount_2Ex : Double;
  totalLevel0Amount_3Ex : Double;
  totalLevel0AmountTotalEx : Double;


  totalLevel1Amount_1Ex : Double;
  totalLevel1Amount_2Ex : Double;
  totalLevel1Amount_3Ex : Double;
  totalLevel1AmountTotalEx : Double;

  totalLevel2Amount_1Ex : Double;
  totalLevel2Amount_2Ex : Double;
  totalLevel2Amount_3Ex : Double;
  totalLevel2AmountTotalEx : Double;

  currentLevel0Order : Integer;
  nLevel0Entries :  Integer;

  currentLevel1Order : Integer;
  nLevel1Entries :  Integer;

  currentLevel2Order : Integer;
  nLevel2Entries : Integer;

  currentAmount_1Inc : Double;
  currentAmount_2Inc : Double;
  currentAmount_3Inc : Double;
  currentAmountTotalInc : Double;

  currentAmount_1Ex : Double;
  currentAmount_2Ex : Double;
  currentAmount_3Ex : Double;
  currentAmountTotalEx : Double;


  calculatingLevel1Total : Boolean;
  calculatingLevel2Total : Boolean;

  bookmark: TBookmark;

  displayFieldNames: TStringList;
  fieldsToShow : string;

  SQL : TStringList;

 // fld : TField;

begin
  inherited;

//  {$WARNINGS OFF}
//  ObjLayout := TProfitLossLayout.CreateWithNewConn(Self);
//  ObjLayout.Connection.connection := Self.MyConnection1;
//  ObjLayout.BusObjEvent := DoBusinessObjectEvent;
//  {$WARNINGS ON}

//   if ObjLayout.GetLayoutToUse = 0 then
 //     PnlSQLObj.UseCustomLayout := false
 //  else
 //     PnlSQLObj.UseCustomLayout := true;



   if not PnlSQLObj.UseCustomLayout then
      Exit;

 //  grdMain.DataSource := dsDisPlayReport;

   SQL := TStringList.Create;

   PnlSQLObj.CalculateTotals(SQL);



      qryDisplayReport.SQL.Text := SQL.Text;


   //   ShowMessage('qryDisplayReport.SQL.Text   ' + qryDisplayReport.SQL.Text);

//        fld := TWideStringField.Create(ds);

        grdMain.DataSource := dsDisplayReport;

        qryMain := qryDisplayReport;



         Clipboard.AsText := qryDisplayReport.SQL.Text;

   //            ShowMessage(qryDisplayReport.SQL.Text);



             displayFieldNames := TStringList.Create;

              qryDisplayReport.GetFieldNames(displayFieldNames);

   //   ShowMessage('displayFieldNames ' + displayFieldNames.Text);

             //      AddLayoutStringField('`Account No`');


    //                ShowMessage(' *** opening qryDisplayReport ');


       qryDisplayReport.Open;



 //  qryDisplayReport.Refresh;

//         qryDisplayReport.Close;
//         qryDisplayReport.Open;

  //  ShowMessage('LabelChange ');


        LabelChange;


                //      ShowMessage( grdMain.Columns[1].FieldName);

                //      ShowMessage( grdMain.Columns[2].FieldName);
            //  ShowMessage( grdMain.Columns[3].FieldName);


 //  qryRecalc.SQL.Text :=

end;


procedure TProfitandLossGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose:= not self.ReportTransactionTableObj.DoingRefresh;
end;


initialization
  RegisterClassOnce(TProfitandLossGUI);
end.






