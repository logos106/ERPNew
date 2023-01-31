unit ReturnsBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls , busobjbase, BusobjReturns,
  StdCtrls, wwcheckbox, DNMSpeedButton, ComCtrls, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, wwclearbuttongroup, wwradiogroup, DBCtrls,
  BasObj, TransAccountDetailsForm, CashBasisDetails, ReturnObj, DNMPanel,
   ProgressDialog;

type
  TReturnsBaseGUI = class(TBaseInputGUI)
    QryReturns: TERPQuery;
    QryReturnLines: TERPQuery;
    dsReturns: TDataSource;
    dsReturnLines: TDataSource;
    Panel1: TDNMPanel;
    Label189: TLabel;
    BtnRefresh: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    btnOptions: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    btnPrint: TDNMSpeedButton;
    chkChooseRpt: TCheckBox;
    Tabmain: TPageControl;

    pnltop: TDNMPanel;
    Label202: TLabel;
    edtDescription: TwwDBEdit;
    wwDBEdit1: TwwDBEdit;
    lblreturnno: TLabel;
    wwCheckBox2: TwwCheckBox;
    memsummaryreturn: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnRefreshClick(Sender: TObject);
    procedure AccDblClick(Sender: TObject);Virtual;
    procedure TaxDblClick(Sender: TObject);Virtual;
    procedure FormDestroy(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure chkActiveEnter(Sender: TObject);
    procedure chkActiveExit(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure memsummaryreturnDblClick(Sender: TObject);

  private
    fbRecEditable :Boolean;
    SavedAccessLevel:Integer;
    CleanSummarisedTransDate:TDatetime;
    fiTransCount, fisunTransCount:Integer;
    fdCashbasisPreparedfrom , fdCashbasisPreparedTo:TdateTime;
    procedure DisplayCurrencyLabels;
    procedure sixMonthly(const Box: TwwDBComboBox);
    procedure TwoMonthly(const Box: TwwDBComboBox);
    function NeedToAutoPopulateforhistory:Boolean;Virtual;
    Function ISfirstReturn:Boolean;

  Protected
    fbChangesMade: boolean;
    fbNoCashBasis:Boolean;
    objReturn: TReturnObj;
    fbFormshown:Boolean;
    fbPrioToclosingdate:Boolean;
    SelectedCode:String;
    procedure Silent_OpenAccountSelect(const Box: TDBEdit; const Tab: integer);Virtual;
    procedure Silent_OpenTaxSelect(const Box: TDBEdit; const Tab: integer);Virtual;
    Procedure InitBas4Tax(BAS: TBASObj; const Tab: integer);Virtual;
    Procedure InitBas4Account(BAS: TBASObj;const Tab: integer);Virtual;
    procedure OpenTaxSelect(const Box: TDBEdit; const Tab: integer);Virtual;
    procedure OpenAccountSelect(const Box: TDBEdit; const Tab: integer);
    procedure OnchangePeriod(LblMonth: TLabel; cboMonth: TwwDBComboBox;grpPeriod: TwwRadioGroup);
    procedure Monthly(const Box: TwwDBComboBox);
    procedure Quarterly(const Box: TwwDBComboBox);Virtual;
    Procedure AfterFormShow; Override;
    procedure NewRecord;Virtual;
    Procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); Override;
    function ToDate(const Period, Month, Year: string): TDateTime;virtual;
    function FromDate(const Month, Year: string): TDateTime;virtual;
    function GetReportTypeID: integer; override;
    function Save:Boolean;virtual;
    procedure InfoSumDate;
    procedure PrintReport(const ReportName: string; const Print: boolean = false);virtual;
    procedure DoTabchange(cThisKey: char );Virtual;
    function SelectedPeriodToStr(const Month, Year: TwwDBComboBox; const Period: TwwRadioGroup): string;

    procedure RefreshAll;virtual;
    procedure DrillDownReports(const Taxcodes: boolean; const Box: TDBEdit);virtual;
    procedure initTransAccountDetails(form :TTransAccountDetailsGUI;const Box: TDBEdit); virtual;
    function CreateWhere(const WhereFieldName, FromName: string): string;
    procedure initCashBasisDetails(form: TCashBasisDetailsGUI; sender:TObject);virtual;
    procedure RefreshTypeValues;virtual;
    procedure InitBas(ReturnObj: TReturnObj);virtual;
    function FormName:String;virtual;
    Function Check4ClosingDate(DateFrom, DateTo:TDateTime):Boolean;
    procedure beforeOpenDetails(Sender: TObject);Virtual;

    Function AutoPopulateForHistory:Boolean;
    Procedure PeriodForAutoPopulatehistory;virtual;
    function SAvencommit:boolean;virtual;
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    Procedure CheckforSummary;
    Procedure ShowBatchupdateWarn;
    function HighestReturnDate: TDatetime;Virtual;Abstract;
    Function DuetoPrepareCashBasisDetails(DateFrom, DateTo:TDateTime):Boolean;

  public
    Return :TReturns;
    Property NoCashBasis: boolean read fbNoCashBasis;
    procedure PrepareCashBasis;Virtual;
  end;


implementation

uses BusObjConst, CashBasisGUI, FastFuncs, dateutils, Commonlib,systemlib, AppEnvironment,
  BasSelectionPopup, BasOptionsPopup, tcDataUtils, tcConst, CommonDbLib,
  TransReturnList, DNMLib, MySQLConst, frmMessageStayontop, CashBasis;

{$R *.dfm}

{ TReturnsBaseGUI }
procedure TReturnsBaseGUI.beforeOpenDetails(Sender:TObject);
begin
  if not(Sender is TTransReturnListGUI) then exit;
  TTransReturnListGUI(Sender).TransType  := '';
  TTransReturnListGUI(Sender).transRef   := '';
  TTransReturnListGUI(Sender).ID         := Return.ID;
  TTransReturnListGUI(Sender).ReturnCode := SelectedCode;
end;

procedure TReturnsBaseGUI.AccDblClick(Sender: TObject);
begin
  (* if fbPrioToclosingdate then begin
      MessageDlgXP_Vista('The ' +formname +' Return Date Range Selected Is Prior To The Closing Date.  It is not Possible  to Show the details' + NL+NL+
        ' - Current Closing Date - ' + FormatDateTime('dddd, mmmm d, yyyy', Appenv.Companyprefs.SummarisedTransDate),mtInformation, [mbOK], 0);
      Exit;
  end;
  if Accesslevel = 5 then begin
      MessageDlgXP_Vista('The ' +formname +' Return is Read-Only.  It is not Possible  to Show the details.' ,mtInformation, [mbOK], 0);
      Exit;
  end;
  DrillDownReports(false, TDBEdit(Sender)); *)
end;

procedure TReturnsBaseGUI.AfterformShow;
begin
  inherited;
  if fbNoCashBasis then
      TfmMessageStayontop.ShowMessage(Self, 'Please Note That '+NL+'Summarise Cash Basis Transaction '+NL+'is NOT done.',10);
  //btnOptions.Enabled := ISfirstReturn and (Accesslevel =1) and (btnOptions.Enabled );
end;

Function TReturnsBaseGUI.AutoPopulateForHistory:Boolean;
begin
  result:= True;
  if KeyId <> 0 then exit;
  if accesslevel  >= 5 then exit;

  if not NeedToAutoPopulateforhistory then begin
    ShowBatchupdateWarn;
    exit;
  end;

  Return.ExecuteSQL('update ' + Return.BusObjectTablename +
                    ' Set SummarisedTransDate = ' + Quotedstr(formatdateTime(mySQLDatetimeformat ,AppEnv.CompanyPrefs.SummarisedTransDate)) +
                    ' where SummarisedTransDate > ' + Quotedstr(formatdateTime(mySQLDatetimeformat ,AppEnv.CompanyPrefs.SummarisedTransDate)), TRUE);

  Return.connection.BeginTransaction;

  CleanSummarisedTransDate:=AppEnv.CompanyPrefs.SummarisedTransDate;
  if (AppEnv.CompanyPrefs.SummarisedTransDate >Appenv.CompanyPrefs.FirstTransDate) then begin
    if Appenv.CompanyPrefs.FirstTransDate >0 then begin
      if MessageDlgXP_Vista('The ' + formname +' Return Functionality is Changed to track the transactions even if they are in a previous return. '+
                        NL+NL+'This will populate a Summary Return from the beginning until the Last Existing Return''s Period.  '+
                        'Do you wish to continue?', mtconfirmation , [mbyes, mbno] , 0) = mrno then begin
        Result:= False;
        exit;
      end;


      if not CashBasisGUI.ResetSummarisedDate(Appenv.CompanyPrefs.FirstTransDate, self) then begin
        MessageDlgXP_Vista('Failed to create Summary Return from the beginning. You cannot proceed with ' + Formname +' return without creating the summary.  This will close the form ', mtWarning , [mbOk] , 0) ;
        Result:= False;
        exit;
      end;
    end;
  end;

  MessageDlgXP_Vista('Populating a Summary ' + formname +' Return from the beginning until the Last Existing Return''s Period.  '+
                        'Please Save it', mtWarning, [mbOK], 0);
  PeriodForAutoPopulatehistory;
  Return.SumTransDate := CleanSummarisedTransDate;
  Return.PostDb;
  BtnRefresh.click;
  Return.Dirty := False;
  fbChangesMade:= False;
  Return.PostDb;
  Return.Connection.CommitTransaction;
  //CashBasis.ResetSummarisedDate(CleanSummarisedTransDate, self);
  Return.connection.BeginTransaction;
end;

procedure TReturnsBaseGUI.btnCloseClick(Sender: TObject);
var
  iExitResult: integer;
begin
  inherited;
  if fbChangesMade then begin
    iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
      [mbYes, mbNo, mbCancel], 0);
    case iExitResult of
      mrYes: btnCompleted.Click;
      mrNo:
        begin;
          Self.Close;
        end;
      mrCancel: Exit;
    end;
  end else begin
    Self.Close;
  end;
end;

procedure TReturnsBaseGUI.btnCompletedClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if not Save then Exit;
    Return.Connection.CommitTransaction;
    Self.close;

  finally
    EnableForm;
  end;
end;

procedure TReturnsBaseGUI.btnOptionsClick(Sender: TObject);
var
  FormBASoptions: TComponent;
begin
  if not FormStillOpen('TfrmBASoptionsGUI') then begin
    FormBASoptions := GetComponentByClassName('TfrmBASoptionsGUI');//,True,Self);
    if Assigned(FormBASoptions) then begin
      with TfrmBASoptionsGUI(FormBASoptions) do begin
          AccountMethod := QryReturns.Fieldbyname('AccMethod').AsString;
          Department := GetClassName(QryReturns.fieldByname('ClassID').AsInteger);
          All := QryReturns.fieldByname('AllClass').AsBoolean;
          IsfirstReturn := Self.IsfirstReturn;
          //ISfirstReturn:= Self.ISfirstReturn;
          TitleLabel.caption := formname +' Options';
          caption := formname +' Options';
        ShowModal;
      end;
    end;
  end else begin
    FormBASoptions := FindExistingComponent('TfrmBASoptionsGUI');
    TForm(FormBASoptions).ShowModal;
  end;
  If fbNoCashBasis then Self.Close;
end;

procedure TReturnsBaseGUI.btnPrintClick(Sender: TObject);
begin
  inherited;
  try
    (* if not save then exit;
    PrintReport('VAT Report');
    Self.Close; *)

    if not save then exit;
    try
      Return.connection.CommitTransaction;
      ReportToPrint := '';
      if chkChooseRpt.checked then begin
        LoadReportTypes;
        if dlgReportSelect.Execute then ReportToPrint := dlgReportSelect.SelectedItems.Text;
      end;
      if ReportToPrint = '' then ReportToPrint :=tcdatautils.GetDefaultReport(GetReportTypeID);
      PrintReport(ReportToPrint , not Appenv.Employee.ShowPreview);
    finally
      Self.Close;
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TReturnsBaseGUI.InfoSumDate;
begin
(*   MessageDlgXP_Vista('When The' + formname +' Report is Finalised, '+
                     'Please change the Summarise Transaction Closing Date in the '+
                     'Preference To Avoid Calculating the Same Transactions in the next' + formname +' Report.', mtInformation, [mbok] , 0 ); *)
end;

procedure TReturnsBaseGUI.InitBas(ReturnObj: TReturnObj);
begin

end;

procedure TReturnsBaseGUI.InitBas4Account(BAS: TBASObj;const Tab: integer);
begin

end;

procedure TReturnsBaseGUI.InitBas4Tax(BAS: TBASObj; const Tab: integer);
begin

end;

procedure TReturnsBaseGUI.initCashBasisDetails(form: TCashBasisDetailsGUI;
  sender: TObject);
begin

end;

procedure TReturnsBaseGUI.initTransAccountDetails(form :TTransAccountDetailsGUI;const Box: TDBEdit);
begin

end;


function TReturnsBaseGUI.ISfirstReturn: Boolean;
begin
  With Return.GetNewDataSet('Select count(' +return.IDFieldName +') ctr from ' + return.BusObjectTableName +' where ' +return.IDFieldName +' <> ' +inttostr(Return.ID)+' and Active ="T"', true) do try
    result:= fieldbyname('ctr').AsInteger =0;
  finally
    if active then close;
    Free;
  end;
end;

procedure TReturnsBaseGUI.memsummaryreturnDblClick(Sender: TObject);
begin
  inherited;
  memsummaryreturn.Visible := False;
end;

procedure TReturnsBaseGUI.BtnRefreshClick(Sender: TObject);
begin
  if AccessLevel = 5 then begin
    MessageDlgXP_Vista('You have ''Readonly Access''. Its not possible to ''Refresh''', mtWarning, [mbOK], 0);
    Exit;
  end;
  DisableForm;
  try
    ProcessingCursor(True);
    try
      inherited;
      initbas(objReturn);
      objReturn.Initialize;
      objReturn.RefreshCalcFields;
      RefreshAll;
      Return.SumTransDate := Appenv.Companyprefs.SummarisedTransDate ;
      Return.PostDB;
    finally
      ProcessingCursor(False);
    end;
  finally
    EnableForm;
  end;
end;

procedure TReturnsBaseGUI.PeriodForAutoPopulatehistory;
begin

end;

procedure TReturnsBaseGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TReturns then TReturns(Sender).Dataset := QryReturns
        else if Sender is TBASReturnLines then TBASReturnLines(Sender).Dataset := QryReturnLines;
  end;
end;
procedure TReturnsBaseGUI.DoTabchange(cThisKey: char);
begin

end;

procedure TReturnsBaseGUI.DrillDownReports(const Taxcodes: boolean;  const Box: TDBEdit);
var
  TmpCreateWhere: string;
  frmTransAccountDetails : TComponent;
begin
  //######## Open Listing #####################


  if FormStillOpen('TTransAccountDetailsGUI') then TForm(FindExistingComponent('TTransAccountDetailsGUI')).Destroy;
  if not FormStillOpen('TTransAccountDetailsGUI') then begin
      frmTransAccountDetails := GetComponentByClassName('TTransAccountDetailsGUI');
    if Assigned(frmTransAccountDetails) then begin
      MessageDlgXP_Vista('Be aware that unless the period for this report is ' +
        'locked in "Preferences: Accounts" the data on this report may be ' +
        'different.' + #13#10 + #13#10 + 'Selecting Refresh will update this ' +
        'report to the current values.',mtInformation,[mbOK],0);
      initTransAccountDetails(TTransAccountDetailsGUI(frmTransAccountDetails) , box);

      with  TTransAccountDetailsGUI(frmTransAccountDetails) do begin
        fbDateRangeSupplied := true;
        if Sysutils.SameText(Trim(Return.AccMethod), 'Accrual') then begin
          {Accrual}
          qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_DebitsEx', 'DebitsEx');
          qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_CreditsEx', 'CreditsEx');
          qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text,  'CASH_DebitsInc', 'DebitsInc');
          qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_CreditsInc', 'CreditsInc');
        end;
        if Taxcodes then begin
          TmpCreateWhere := CreateWhere('TaxCode', Box.Name);
        end else begin
          TmpCreateWhere := CreateWhere('AccountName', Box.Name);
        end;

        if TmpCreateWhere = '()' then TmpCreateWhere := ''
          else TmpCreateWhere := ' AND ' + TmpCreateWhere;


          qryMain.SQL.Add('AND (AccountName<>"Tax Paid" AND AccountName<>"Tax Collected") ' +
            TmpCreateWhere + ' Group by TransID;');
          WhereString := 'AND (AccountName<>"Tax Paid" AND AccountName<>"Tax Collected") ' + TmpCreateWhere;
        NonSearchMode:= true;
        FormStyle := fsmdiChild;
      end;
    end;
  end;

end;

function TReturnsBaseGUI.DuetoPrepareCashBasisDetails(DateFrom, DateTo: TDateTime): Boolean;
begin
  Result:= False;
  if fdCashbasisPreparedfrom <> DateFrom then begin
    fdCashbasisPreparedfrom := DateFrom;
    result:= True;
    Exit;
  end;
  if fdCashbasisPreparedTo <> DateTo then begin
    fdCashbasisPreparedTo := DateTo;
    result:= True;
    Exit;
  end;
  With TempMyquery do try
    if tableexists('tbltransactionsummarydetails') then  begin
      SQL.text :='Select count(*) as ctr from tbltransactionsummarydetails';
      open;
      if   fisunTransCount <> fieldbyname('ctr').AsInteger then begin
        fisunTransCount := fieldbyname('ctr').AsInteger;
        Result:= True;
        Exit;
      end;
    end;
    if active then close;

    if tableexists('tbltransactions') then begin
      SQL.text :='Select count(*) as ctr from tbltransactions';
      open;
      if   fiTransCount <> fieldbyname('ctr').AsInteger then begin
        fiTransCount := fieldbyname('ctr').AsInteger;
        Result:= True;
        Exit;
      end;
    end;
  finally
    closenFree;
  end;
end;

procedure TReturnsBaseGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
  WriteGuiPref;
  inherited;
end;

procedure TReturnsBaseGUI.FormCreate(Sender: TObject);
begin
  fiTransCount:= -1;
  fisunTransCount:= -1;
  fdCashbasisPreparedfrom:= 0;
  fdCashbasisPreparedTo:=0;
  inherited;
  TabColor := Color;
  fbNoCashBasis := False;
  objReturn.OwnerForm := self;
  DisplayCurrencyLabels;
  fbFormshown:= False;
  fbPrioToclosingdate:= False;
  SelectedCode := '';
  CleanSummarisedTransDate:= 0;
end;
procedure TReturnsBaseGUI.DisplayCurrencyLabels;
var
  ctr:Integer;
begin
  for ctr:= 0 to componentcount -1 do begin
    if (Components[ctr] is TLabel) and (TLabel(Components[ctr]).tag = 90) then begin
      TLabel(Components[ctr]).Caption := AppEnv.RegionalOptions.CurrencySymbol;
    end;
  end;
end;
procedure TReturnsBaseGUI.FormDestroy(Sender: TObject);
begin
  if Assigned(objReturn) then FreeandNil(objReturn);
  if Assigned(Return) then FreeandNil(Return);
  CashBasis.RemoveTempTable('BAS');
  CashBasis.RemoveTempTable('BAS', true);
  inherited;
end;

procedure TReturnsBaseGUI.Silent_OpenAccountSelect(const Box: TDBEdit;  const Tab: integer);
begin
  try
    objReturn.From := Box;
    objReturn.FromName := Box.Name;
    objReturn.ObjType := ftAcc;
  except
    CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
  end;
end;
procedure TReturnsBaseGUI.Silent_OpenTaxSelect(const Box: TDBEdit; const Tab: integer);
begin
  try
    objReturn.From := Box;
    objReturn.FromName := Box.Name;
    objReturn.ObjType := ftTax;
    initbas(objReturn);
    objReturn.Initialize;
  except
    CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
  end;

end;

procedure TReturnsBaseGUI.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var
  cThisKey: char;
begin
  inherited;
  if Shift = [ssCtrl] then begin
    cThisKey := Chr(Key);
    Key      := 0;
    DoTabchange(cThisKey );
  end;

  fbChangesMade := true;
end;

function TReturnsBaseGUI.FormName: String;
begin
  if Self.Classnameis('TfmBASReturn') then Result := 'BAS'
  else if  Self.Classnameis('TfmNZReturn') then Result := 'GST'
  else if Self.Classnameis('TfmVATReturn') then Result := 'VAT'
  else Result := '';
end;

procedure TReturnsBaseGUI.FormShow(Sender: TObject);
var
  s:String;
  //dt:Tdatetime;
begin
  inherited;
  fbChangesMade       := false;
  UserLock.enabled := True;
  Return.Load(KeyID);
  fbFormshown:= True;
  Return.connection.BeginTransaction;
  {only one user can create / change BAS at a time }
  if AccessLevel <5 then begin
    if KeyId <> 0 then begin
      if Return.SumTransDate > Appenv.Companyprefs.SummarisedTransDate  then begin
        AccessLevel := 5;
        MessageDlgXP_Vista('''Closing Date'' was ' + QuotedStr(FormatDateTime(formatSettings.ShortDateFormat , Return.SumTransDate)) +
                          ' when this ' +formname +' return was created. Access is changed to read-Only as the Current Closing Date ' + Quotedstr(FormatdateTime(formatSettings.ShortDateFormat ,Appenv.Companyprefs.SummarisedTransDate )) +' is prior to it.', mtWarning, [mbok] , 0);
      end else if Return.Id <> LastReturnID(Return.BusObjectTableName) then begin
        AccessLevel := 5;
        MessageDlgXP_Vista('This is not the last return and only the last return is editable.'+NL+NL+'Access is changed to Read-Only', mtWarning, [mbok] , 0);
      end;

    end else begin
      if NeedToAutoPopulateforhistory then else begin
        (*dt:= LastReturnSummariseDate(Return.BusObjectTableName) ;
        if dt> Appenv.Companyprefs.SummarisedTransDate  then begin
          AccessLevel := 5;
          MessageDlgXP_Vista('Last ' +formname +' Return was Created when the ''closing Date'' was ' + QuotedStr(FormatDateTime(formatSettings.ShortDateFormat , dt)) +' and the Current Closing Date is' + Quotedstr(FormatdateTime(formatSettings.ShortDateFormat ,Appenv.Companyprefs.SummarisedTransDate )) +'.'+
                            ' New ' +formname +' return should be created with the ''Closing date'' greater than ' + QuotedStr(FormatDateTime(formatSettings.ShortDateFormat , dt)) +'.', mtWarning, [mbok] , 0);
        end;*)
      end;
    end;
  end;

  if accessLevel <5 then
    if not Userlock.Lock(Return.GetBusObjectTablename , 0 , self.caption) then begin
      Accesslevel := 5;
      s:= userlock.LockMessage ;
      if KeyId <> 0 then begin
        s:= replacestr(s , 'Unable to update data.' , 'Access changed To Read Only.') ;
        s:= replaceStr(s , 'this record' , Formname +' Return');
        MessageDlgXP_Vista(s , mtWarning, [mbok] , 0);
      end else begin
        s:= replacestr(s , 'Unable to update data.' , 'Unable to create ' +formname +' return.') ;
        s:= replaceStr(s , 'this record' , Formname +' Return');
        MessageDlgXP_Vista(s , mtWarning, [mbok] , 0);
      end;
    end;

  if Accesslevel <=3 then
    if KeyId =0 then
      NewRecord;
  Return.Lines;
  OpenQueries;
  GuiPrefs.active := TRue;
  ReadGuiPref;
  fbRecEditable := Accesslevel =1;
  if Accesslevel <5 then
    if Return.done then begin
      Accesslevel := 5;
      MessageDlgXP_Vista('This ' + Formname +' Return is already Done.' +NL+NL+
                          'Access changed to Read Only' , mtWarning, [mbok] , 0);
      Self.Caption :=Formname +' Return : Done';
    end;


  btnOptions.enabled    := AccessLevel <5;
  btnCompleted.Enabled  := AccessLevel <5;
  btnRefresh.Enabled    := AccessLevel <5;
  btnOptions.Enabled    := AccessLevel <5;

end;

procedure TReturnsBaseGUI.ReadGuipref;
begin
    if GuiPrefs.Node.Exists('General') then begin
      chkChooseRpt.checked:= StrToBoolean(GuiPrefs.Node['General.ChooseTemplate'].AsString);
    end else begin
      chkChooseRpt.checked:= False;
    end;
end;

procedure TReturnsBaseGUI.WriteGuiPref;
begin
  GuiPrefs.Node['General.ChooseTemplate'].AsString            := BooleanToStr(chkChooseRpt.checked);
end;

procedure TReturnsBaseGUI.chkActiveClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkActive then
    fbChangesMade:= True;
end;

procedure TReturnsBaseGUI.chkActiveEnter(Sender: TObject);
begin
  inherited;
  SavedAccessLevel := Accesslevel;
  if fbRecEditable and Return.Active  and not(Sametext(trim(Return.Description) , 'Summary')) then begin
    AccessLevel := 1;
    Return.AccessManager.AccessLevel := 1;
  end;
end;

procedure TReturnsBaseGUI.chkActiveExit(Sender: TObject);
begin
  inherited;
  if Accesslevel = SavedAccessLevel then Exit;
  Return.PostDB;
  Return.AccessManager.AccessLevel := SavedAccessLevel;
end;

function TReturnsBaseGUI.GetReportTypeID: integer;
begin
  Result := 42; {Tax type}
end;

procedure TReturnsBaseGUI.Monthly(const Box: TwwDBComboBox);
begin
  Box.Items.Clear;
  Box.Items.Add('January');
  Box.Items.Add('February');
  Box.Items.Add('March');
  Box.Items.Add('April');
  Box.Items.Add('May');
  Box.Items.Add('June');
  Box.Items.Add('July');
  Box.Items.Add('August');
  Box.Items.Add('September');
  Box.Items.Add('October');
  Box.Items.Add('November');
  Box.Items.Add('December');
end;
procedure TReturnsBaseGUI.TwoMonthly(const Box: TwwDBComboBox);
begin
(*  Box.Items.Clear;
  Box.Items.Add('January');
  Box.Items.Add('March');
  Box.Items.Add('May');
  Box.Items.Add('July');
  Box.Items.Add('September');
  Box.Items.Add('November');*)
  Monthly(Box);
end;
procedure TReturnsBaseGUI.sixMonthly(const Box: TwwDBComboBox);
begin
(*  Box.Items.Clear;
  Box.Items.Add('January');
  Box.Items.Add('July');*)
  Monthly(Box);
end;

procedure TReturnsBaseGUI.Quarterly(const Box: TwwDBComboBox);
begin
  (*Box.Items.Clear;
  Box.Items.Add('January');
  Box.Items.Add('April');
  Box.Items.Add('July');
  Box.Items.Add('October');*)
  Monthly(Box);
end;


procedure TReturnsBaseGUI.RefreshAll;
begin
  fbChangesMade := true;
end;

procedure TReturnsBaseGUI.RefreshTypeValues;
var
  frmBASselection: TComponent;
begin
  try
    if not FormStillOpen('TBasSelectionGUI') then begin
      frmBASselection := GetComponentByClassName('TBasSelectionGUI');
      with TBasSelectionGUI(frmBASselection) do begin
        InitBas(BAS);
        BAS.RefreshCalcFields;
      end;

    end else begin
      frmBASselection := FindExistingComponent('TBasSelectionGUI');
      TBasSelectionGUI(frmBASselection).BAS.RefreshCalcFields;
    end;
  except
    if FormStillOpen('TBasSelectionGUI') then begin
      CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
      TForm(FindExistingComponent('TBasSelectionGUI')).Close;
    end;
  end;

end;

function TReturnsBaseGUI.Save: Boolean;
begin
    inherited;
    if accesslevel = 5 then begin
      Result := True;
      Exit;
    end;
    Return.PostDB;
    if not Return.Save then begin
      Result := False;
      Exit;
    end;
    Notify;
    InfoSumDate;
    Result := True;
end;

function TReturnsBaseGUI.SAvencommit: boolean;
begin
  Result := False;
  if MessageDlgXP_Vista('You are about to view the details of ' +formname +' Return  Entry :' +Selectedcode+'.'+NL+
                  'This will save the current ' +formname +' Return record.' +NL+NL+
                  'Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  if not Save then exit;
  Return.Connection.CommitTransaction;
  Return.Connection.BeginTransaction;
  Result := True;
end;

function TReturnsBaseGUI.SelectedPeriodToStr(const Month, Year: TwwDBComboBox;
  const Period: TwwRadioGroup): string;
begin
  try
    if Empty(Period.Value) or Empty(Month.Text) or Empty(Year.Text) then begin
      Result := ' - Not Entered.';
    end else begin
      Result := DateToStr(FromDate(Month.Text, Year.Text)) + ' to ' + DateToStr(ToDate(Period.Value, Month.Text, Year.Text));
    end;
  except
    on EConvertError do Result := ' - Not Entered.';
  end;

end;

procedure TReturnsBaseGUI.ShowBatchupdateWarn;
var
  BatchDateStr:String;

function GetBatchDate: string;
var
  TempDate: TDateTime;
begin
    Result:='';
    If  (csDestroying in ComponentState) then Exit;
    Try
      TempDate := AppEnv.CompanyPrefs.TransactionTableLastUpdated;
           if TempDate = 0 then Result := ' '
      else Result := FormatDateTime(FormatSettings.ShortDateFormat +', " at " hh:mm AM/PM', TempDate);
    except
    end;
end;

begin
  {as the batch update is automatically triggered at mid night, this warning is not required}
  //exit;
  {binny : we need this incase if the batch update is interrupted}

   if  (AppEnv.CompanyPrefs.TransactionTableLastUpdated > HighestReturnDate) or (AppEnv.CompanyPrefs.TransactionTableLastUpdated = date) then exit;
   BatchDateStr := '';
   if not AppEnv.CompanyPrefs.ClosingDateChangeDone then
        BatchDateStr:= ' Batch Transaction Incomplete / Not Done in this database at all.' +NL +NL+'Please cancel this record and run "Update Batch". '
   else begin
    BatchDateStr:= GetBatchDate;
    if Trim(BatchDateStr) <> '' then
      BatchDateStr:= ' Batch Transaction Last Update On  ' +NL+ quotedstr(BatchDateStr) +
                    ' which is prior to the ' +FormName +' Date - ' + Quotedstr(FormatDateTime(FormatSettings.ShortDateFormat ,HighestReturnDate )) +
                    '.' +NL +NL+' Please cancel this record and run "Update Batch" to get the transactions after this date'
   end;

  MessageDlgXP_Vista(BatchDateStr, mtInformation, [mbOK], 0);
end;

function TReturnsBaseGUI.ToDate(const Period, Month, Year: string): TDateTime;
var
  Period1: integer;
  Year1, Month1, Day1: word;
  Date: TDateTime;
begin
  Result := 0;
  Period1 := 0;
    if (SameText(Period ,tPTQuarterly)) then begin
      Period1 := 2;
    end else if (SameText(Period , tPTMonthly)) then begin
      Period1 := 0;
    end else if (SameText(Period , tPTTwoMonthly)) then begin
      Period1 := 1;
    end else if (SameText(Period , tPTSixMonthly)) then begin
      Period1 := 5;
    end;
  Year1 := FastFuncs.StrToInt(Year);
  Month1 := REturn.MonthNameToNumber(Month) + Period1;
  Day1 := 1;

  if Month1 > 12 then begin  //handle if crossing to next year
    Year1 := Year1 + 1;
    if Month1 = 13 then Month1 := 1
    else if Month1 = 14 then Month1 := 2;
  end;

  if TryEncodeDate(Year1, Month1, Day1, Date) then begin
    Result := EndOfTheMonth(EncodeDate(Year1, Month1, Day1));
  end;
end;

procedure TReturnsBaseGUI.NewRecord;
var
  s:String;
begin
  Return.connection.BeginTransaction;
  Return.New;
  Return.Active := False;
  s:=Return.Description ;
  Return.Description :='Cancelled - ' + FormName;
  Return.PostDB;
  Return.Save;
  Return.connection.CommitTransaction;
  Return.connection.BeginTransaction;
  Return.Description :=s;
  Return.Active := True;
  Return.postdb;
end;

procedure TReturnsBaseGUI.PrepareCashBasis;
begin
  //descendants will override;
end;

procedure TReturnsBaseGUI.PrintReport(const ReportName: string;const Print: boolean);
var
  sSQL: string;
begin
    sSQL := ' WHERE  ID = '+ inttostr(Return.ID);
    PrintTemplateReport(ReportName, sSQL, Print, 1);
end;

function TReturnsBaseGUI.FromDate(const Month, Year: string): TDateTime;
var
  Year1, Month1, Day1: word;
  Date: TDateTime;
begin
  Result := 0;
  Year1 := FastFuncs.StrToInt(Year);
  Month1 := REturn.MonthNameToNumber(Month);
  Day1 := 1;
  if TryEncodeDate(Year1, Month1, Day1, Date) then begin
    Result := EncodeDate(Year1, Month1, Day1);
  end;
end;

procedure TReturnsBaseGUI.OnchangePeriod(LblMonth: TLabel; cboMonth: TwwDBComboBox;grpPeriod: TwwRadioGroup);
begin
  Processingcursor(True);
  try
    inherited;
    if (SameText(grpPeriod.Value ,tPTQuarterly)) then begin
      LblMonth.caption :=  'Beginning';
      Quarterly(cboMonth);
    end else if (SameText(grpPeriod.Value , tPTMonthly)) then begin
      LblMonth.caption :=  'Month of ';
      Monthly(cboMonth);
    end else if (SameText(grpPeriod.Value , tPTTwoMonthly)) then begin
      LblMonth.caption :=  'Beginning';
      TwoMonthly(cboMonth);
    end else if (SameText(grpPeriod.Value , tPTSixMonthly)) then begin
      LblMonth.caption :=  'Beginning';
      SixMonthly(cboMonth);
    end;
    fbChangesMade := true;
  finally
    Processingcursor(False);
  end;
end;
procedure TReturnsBaseGUI.OpenTaxSelect(const Box: TDBEdit; const Tab: integer);
 var
  frmBASselection : TComponent;
begin

  //if Accesslevel = 5 then exit;
  (* if not FormStillOpen('TBasSelectionGUI') then begin
      frmBASselection := GetComponentByClassName('TBasSelectionGUI');
    end else begin
      frmBASselection := FindExistingComponent('TBasSelectionGUI');
    end; *)
  frmBASselection := GetComponentByClassName('TBasSelectionGUI' , True, self , False);
  try
      TBasSelectionGUI(frmBASselection).BAS.From     := Box;
      TBasSelectionGUI(frmBASselection).BAS.FromName := Box.Name;
      TBasSelectionGUI(frmBASselection).BAS.ObjType := ftTax;
      TBasSelectionGUI(frmBASselection).BAS.Ownerform := Self;
      TBasSelectionGUI(frmBASselection).BAS.ReturnsObj := Return;
      TBasSelectionGUI(frmBASselection).Accesslevel := Self.Accesslevel;
      InitBas4Tax(TBasSelectionGUI(frmBASselection).BAS , tab);
      TBasSelectionGUI(frmBASselection).FormStyle := fsMDIChild;
  except
    CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
    TBasSelectionGUI(FindExistingComponent('TBasSelectionGUI')).Close;
  end;
end;


procedure TReturnsBaseGUI.OpenAccountSelect(const Box: TDBEdit; const Tab: integer);
var
  frmBASselection : TComponent;
begin
  if accesslevel = 5 then exit;
  try
    (* if not FormStillOpen('TBasSelectionGUI') then begin
      frmBASselection := GetComponentByClassName('TBasSelectionGUI');
    end else begin
      frmBASselection := FindExistingComponent('TBasSelectionGUI');
    end; *)
    frmBASselection := GetComponentByClassName('TBasSelectionGUI' , True, self , False);
    if Assigned(frmBASselection) then begin
      TBasSelectionGUI(frmBASselection).BAS.From := Box;
      TBasSelectionGUI(frmBASselection).BAS.FromName := Box.Name;
      TBasSelectionGUI(frmBASselection).BAS.Ownerform := Self;
      TBasSelectionGUI(frmBASselection).BAS.ReturnsObj := Return;
      InitBas4Account(TBasSelectionGUI(frmBASselection).BAS, tab);
      TBasSelectionGUI(frmBASselection).FormStyle := fsMDIChild;
    end;
  except
    CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
    TForm(FindExistingComponent('TBasSelectionGUI')).Close;
  end;
end;
Function TReturnsBaseGUI.Check4ClosingDate(DateFrom, DateTo: TDateTime):Boolean;
begin
  Result := False;
  fbPrioToclosingdate := False;
  if (DateFrom <= Appenv.Companyprefs.SummarisedTransDate) or (DateTo <= Appenv.Companyprefs.SummarisedTransDate) Then begin
      CommonLib.MessageDlgXP_Vista('The ' +formname +' Return Date Range Selected Is Prior To The Closing Date.' + NL+NL+
        ' - Access has been changed to read-only .' + NL+NL+
        ' - Current Closing Date - ' + FormatDateTime('dddd, mmmm d, yyyy', Appenv.Companyprefs.SummarisedTransDate),
        mtInformation, [mbOK], 0);
      AccessLevel := 5;
      Result := True;
      fbPrioToclosingdate := True;
    end;
end;

procedure TReturnsBaseGUI.CheckforSummary;
begin

  if Sametext(trim(Return.Description) , 'Summary') then begin
      if accesslevel <5 then Accesslevel := 5;

      Self.Caption := Self.Caption + '     { Summary Return ! - Cannot Modify}';
      CommonLib.MessageDlgXP_Vista('You have ''Read-only'' access to this ' + Formname +' Return as it is a Summary ' +Formname +' Return.' +
                                      NL+NL +'The Summary '+Formname+' Return is created and used internally.' +NL +NL +'Please IGNORE this '+Formname+' Return record.' , mtInformation, [mbOK], 0);
      memsummaryreturn.Left := trunc((Self.ClientWidth - memsummaryreturn.Width)/2);
      memsummaryreturn.Top := trunc((Self.Clientheight - memsummaryreturn.height)/2);
      memsummaryreturn.visible := True;
      memsummaryreturn.Lines.Clear;
      memsummaryreturn.Lines.Add('SUMMARY ' + formname +' RETURN');
      memsummaryreturn.Lines.Add(' ===============================================');
      memsummaryreturn.Lines.Add('');
      memsummaryreturn.Lines.Add('You have ''Read-only'' access to this ' + Formname +' Return ');
      memsummaryreturn.Lines.Add('as it is a Summary ' +Formname +' Return.' );
      memsummaryreturn.Lines.Add('');
      memsummaryreturn.Lines.Add('The Summary '+Formname+' Return is created and used internally.' );
      memsummaryreturn.Lines.Add('');
      memsummaryreturn.Lines.Add('Please IGNORE this '+Formname+' Return record.');
      memsummaryreturn.Lines.Add('');
      memsummaryreturn.Lines.Add('Select ''CANCEL'' to close the form.');
      btnPrint.Enabled := False;
  end;
end;

function TReturnsBaseGUI.NeedToAutoPopulateforhistory: Boolean;
begin
  Result := False;
  if Appenv.CompanyPrefs.FirstTransDate =0 then Exit;
  With tempMyQuery do try
    SQL.add('Select count(R.ID) ctr1 , count(RL.ID) ctr2 from ' +Return.BusObjectTableName +' R left join ' +  Return.Lines.BusObjectTableName +' RL  on R.Id = RL.' + Return.HeaderIDFieldName +' Where R.Active ="T"  ' );
    open;
    if Fieldbyname('Ctr2').asInteger <> 0 then exit;
    if Fieldbyname('Ctr1').asInteger = 0 then exit;
    close;
    SQL.clear;
    SQL.add('Select * from   ' +Return.BusObjectTableName +' where ' +return.HeaderDescfieldName +' = "Summary" and active ="T"');
    open;
    if recordcount >0 then exit;
  finally
    ClosenFree;
  end;
  Result := True;
end;

function TReturnsBaseGUI.CreateWhere(const WhereFieldName, FromName: string): string;
var
  G, F, C: integer;
  TempResult, TempFieldName, TempSelectedStrings, TempSelectedStr: string;
begin
  if not Empty(FromName) then begin
    TempFieldName := FromName + 'Selected';
      TempSelectedStrings := QryReturns.FieldByName(TempFieldName).AsString;
    C := 0;
    for F := 1 to 100 do begin
      if ExtractStrPortion(TempSelectedStrings, #44, F) <> '' then begin
        C := C + 1;
      end;
    end;

    TempResult := '';
    if C > 0 then begin
      for G := 1 to C do begin
        TempSelectedStr := ExtractStrPortion(TempSelectedStrings, #44, G);
        TempResult := TempResult + ' ' + WhereFieldName + '=' + QuotedStr(TempSelectedStr);
        if (G <> C) then TempResult := TempResult + ' OR ';
      end;
    end;
    Result := '(' + TempResult + ')';
  end;
end;

procedure TReturnsBaseGUI.TaxDblClick(Sender: TObject);
begin
(* var
  TaxcodeStr: string;
  frmCashBasisDetails: TComponent;
begin
  if fbPrioToclosingdate then begin
      MessageDlgXP_Vista('The ' +formname +' Return Date Range Selected Is Prior To The Closing Date.  It is not Possible  to Show the details' + NL+NL+
        ' - Current Closing Date - ' + FormatDateTime('dddd, mmmm d, yyyy', Appenv.Companyprefs.SummarisedTransDate),mtInformation, [mbOK], 0);
      Exit;
  end;
  if Accesslevel = 5 then begin
      MessageDlgXP_Vista('The ' +formname +' Return is Read-Only.  It is not Possible  to Show the details.' ,mtInformation, [mbOK], 0);
      Exit;
  end;
  if not (Return.AccMethod = 'Cash') then begin
    DrillDownReports(true, TDBEdit(Sender));
  end else begin
    if FormStillOpen('TCashBasisDetailsGUI') then TCashBasisDetailsGUI(FindExistingComponent('TCashBasisDetailsGUI')).Close;
    if not FormStillOpen('TCashBasisDetailsGUI') then begin
      frmCashBasisDetails := GetComponentByClassName('TCashBasisDetailsGUI',True,Self);
      if Assigned(frmCashBasisDetails) then begin
        with TCashBasisDetailsGUI(frmCashBasisDetails) do begin
          initCashBasisDetails(TCashBasisDetailsGUI(frmCashBasisDetails), sender);
          TaxcodeStr := CreateWhere('TaxCode', TDBEdit(Sender).Name);
          if (not Empty(TaxcodeStr)) then begin
            WhereString := TaxcodeStr;
          end else begin
            Close;
            Exit;
          end;
          FormStyle := fsmdiChild;
        end;
      end;
    end else begin
      TCashBasisDetailsGUI(FindExistingComponent('TCashBasisDetailsGUI')).Show;
    end;
    Exit;
  end;*)
end;
end.

