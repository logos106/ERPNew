// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 17/05/05  1.00.01 BJ  GlobalRef Field is added to the grid as the first column
  // 26/09/05  1.00.02 ISB Added chkAging
  // 27/10/05  1.00.03 Modified qryMainCalcFields to use currency sell rate

unit AccountsPayListForm;

interface
{$I ERP.inc}
uses
  Messages, Classes, Graphics, Dialogs, BaseListingForm, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, StdCtrls, ExtCtrls, Menus, AdvMenus, ComCtrls,AdvOfficeStatusBar, PrintDAT, ActnList, wwdblook, wwcheckbox,
  SelectionDialog, DNMPanel, Wwlocate, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, DBAccess,
  MemDS, wwDialog, wwMemo, ImgList, Controls, Report_AP_Obj,PaymentConformationObj,
   Shader, kbmMemTable, BaseInputForm, DAScript, MyScript, CustomInputBox, Forms,
  wwclearbuttongroup, wwradiogroup, GIFImg, APReportSQL;

const
  SX_DatechangeMsg = WM_USER + 125;

type
  TAccountsPayListGUI = class(TBaseListingGUI)
    cboClassQry: TERPQuery;
    cboClassSrc: TDataSource;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;

    chkShowPrepayments: TCheckBox;
    btnBulkPay: TDNMSpeedButton;
    chkAging: TCheckBox;
    btnPayApproved: TDNMSpeedButton;
    lblReview: TLabel;
    lblApproved: TLabel;
    lblReviewAmount: TLabel;
    lblApprovedAmount: TLabel;
    APMemoDialog: TwwMemoDialog;
    qryAPNotes: TERPQuery;
    DSAPNotes: TDataSource;
    qryMainGlobalRef: TWideStringField;
    qryMainSupplierName: TWideStringField;
    qryMainType: TWideStringField;
    qryMainOrderDate: TDateField;
    qryMainInvoiceDate: TDateField;
    qryMainDueDate: TDateField;
    qryMainPONumber: TWideStringField;
    qryMainName: TWideStringField;
    qryMainOriginalAmount: TFloatField;
    qryMainAmountDue: TFloatField;
    qryMainCurrent: TFloatField;
    qryMainDSDesigner30Days: TFloatField;
    qryMainDSDesigner60Days: TFloatField;
    qryMainDSDesigner90Days: TFloatField;
    qryMainDSDesigner120Days: TFloatField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainDetails: TLargeintField;
    qryMainClientID: TIntegerField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainPOGlobalRef: TWideStringField;
    qryMainTransID: TIntegerField;
    qryMainTerms: TWideStringField;
    lblREfreshInfo: TLabel;
    btnfix: TDNMSpeedButton;
    qryMainAPNotes: TWideMemoField;
    chkCalenderAgeing: TCheckBox;
    Label2: TLabel;
    qryMainPrintname: TWideStringField;
    qryMainPCStatus: TWideStringField;
    btnhelp: TDNMSpeedButton;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkShowPrepaymentsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnBulkPayClick(Sender: TObject);
    procedure chkAgingClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPayApprovedClick(Sender: TObject);
    procedure HandleInitDialog(Dialog : TwwMemoDlg);
    procedure APMemoDialogUserButton1Click(Dialog: TwwMemoDlg;
      Memo: TMemo);
    procedure APMemoDialogUserButton2Click(Dialog: TwwMemoDlg;
      Memo: TMemo);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnfixClick(Sender: TObject);
    procedure chkCalenderAgeingClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnhelpClick(Sender: TObject);
  private
    { Private declarations }
    ShowingPrepayments :Boolean;
    AgingTransactionDate:Boolean;
    xDateFrom : TDateTime;
    xdateTo   : TDateTime;
    ClassIDUsed :Integer;
    KeysPressed:String;

    OriginalSql: string;

    PaymentConformation :TPaymentConformationObj;
    fiAPClientID :Integer;
    FCFields :String;
    CalenderAgeing: boolean;
    APReport: TAPReport;
    fsGridHint :String;
    procedure DoOnReviewChange(Sendet: TObject);
    procedure logit;
    Procedure ToBeRefreshed;
    Function ReportforClassId:Integer;
    procedure SetQryMainSQL;
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    procedure ReFreshQeymain;
    procedure InitGridfields;
  protected
    Wheresql :String;

    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
    procedure RefreshAll;Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);Override;
    Procedure ShowControlhints;Override;
    procedure initqrymainsql;Override;
  public
    { Public declarations }
    Property APClientID :Integer read fiAPClientID write fiAPClientID;
  end;

implementation

uses
  Windows, SysUtils,
  frmBulkPaySuppliersGUI, DNMExceptions, CommonLib, frmDateSelectDialog,
  CommonDBlib, AppEnvironment, FastFuncs, BusObjPayments, BusObjBase,
  Variants, BusObjConst, tcDataUtils, JournalList, BusObjGLAccount, tcConst,
  dateutils, CommonFormLib, GridFieldsObj, TransactionsTable, SystemLib,
  ReportLib;

{$R *.dfm}

procedure TAccountsPayListGUI.RefreshTotals;
var
    fsFilter :STring;
begin
    Qrymain.disablecontrols;
    try
        fsFilter := Qrymain.filter;
        if fsfilter <> '' then
            qrymain.filter := Qrymain.filter + ' AND Details = 0 '
        else
            qrymain.filter := ' Details = 0 ';
        qrymain.filtered := True;
        inherited;
    finally
        if fsfilter <> '' then begin
            Qrymain.filter := fsFilter;
            qrymain.filtered := True;
        end else qrymain.filtered := False;
        qrymain.enablecontrols;
    end;
end;

function TAccountsPayListGUI.ReportforClassId: Integer;
begin
  if not cboClass.Enabled then begin
      result :=0;
  end else begin
      cboClassQry.Locate('ClassName', cboClass.Text, [loCaseInsensitive]);
      result := cboClassQry.FieldByName('ClassID').AsInteger;
  end;
end;
procedure TAccountsPayListGUI.initqrymainsql;
begin
  SetQryMainSQL;
end;
procedure TAccountsPayListGUI.SetQryMainSQL;
var
  msg: string;
begin
  try
  //if isformShown then begin
    APReport.WhereSQL := WhereSQL;
    APReport.DateFrom := filterdatefrom;
    APReport.DateTo := filterDateto;
    APReport.IgnoreDates := chkIgnoreDates.Checked;
    APReport.DepartmentID := self.SelectedClassID;
    APReport.IncludePrepayments := chkShowPrepayments.Checked;
    APReport.AgeByTransactionDate := chkAging.Checked;
    APReport.CalenderAgeing := chkCalenderAgeing.Checked;
    APReport.ClientID := self.APClientID;
    APReport.ReportOnForeignCurrency := self.ReportonForeignCurrency;
    APReport.PopulateReportSQL(qryMain.SQL,msg);
  //end;
  Except
    //ignore exception
  end;
  self.RefreshOrignalSQL();
end;

procedure TAccountsPayListGUI.grdMainDblClick(Sender: TObject);
var
  JournalList: TJournalListGui;
begin
  {binny : to be removed - just added for debuggin babylon's rounding issue}
  if qryMain.fieldbyname('PurchaseOrderID').AsInteger > 0 then begin
    if (grdMain.GetActiveField.FieldName = 'APNotes') and (qryMain.fieldbyname('DEtails').AsInteger = 2) and (qryMain.fieldbyname('PurchaseOrderID').AsInteger <> 0) then
    begin
      qryAPNotes.Close;

      if qryMain.fieldbyname('type').AsString <> 'Supplier Prepayment' then begin
        qryAPNotes.SQL.Text := 'SELECT PurchaseOrderID, APNotes FROM tblpurchaseorders WHERE PurchaseOrderID= :ID;';
        APMemoDialog.DataField := 'APNotes';
      end

      else if qryMain.fieldbyname('type').AsString = 'Supplier Prepayment' then begin
        qryAPNotes.SQL.Text := 'SELECT Notes FROM tblprepayments Where PrePaymentID = :ID';
        APMemoDialog.DataField := 'Notes';
      end;

      qryAPNotes.ParamByName('ID').AsInteger := qryMain.fieldbyname('PurchaseOrderID').AsInteger;
      qryAPNotes.Open;
      if not qryAPNotes.IsEmpty then begin
        APMemoDialog.OnInitDialog := HandleInitDialog;

        if APMemoDialog.Execute then begin
          qryAPNotes.Edit;
          qryAPNotes.Post;
          qryMain.Refresh;
        end;
      end else begin
        SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
        inherited;
      end;
    end else begin
      if qryMain.fieldbyname('Details').AsInteger = 2 then begin
          SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
          inherited;
      end;
    end;
  end else if (QrymainTransId.asInteger <> 0)  and (qryMainType.asString = 'Journal Entry') then begin
    if qryMain.fieldbyname('Details').AsInteger = 2 then begin
       JournalList:= TJournalListGui(FindExistingComponent('TJournalListGui'));

       if Assigned(JournalList) then begin
         JournalList.Release;
         Application.ProcessMessages;
       end;

       if FormStillOpen('TJournalListGui') then
         exit;

       JournalList:= TJournalListGui(GetComponentByClassName('TJournalListGui'));
       if Assigned(JournalList) then begin
         JournalList.AccountIdList:= TAccount.AccountGroupIdListForAccount(qryMainAccountName.AsString);
         JournalList.ClientID:= qryMainClientID.AsInteger;
         JournalList.chkIgnoreDates.Checked:= self.chkignoredates.Checked;
         if not JournalList.chkIgnoreDates.Checked then begin
           JournalList.dtFrom.DateTime:= self.dtFrom.DateTime;
           JournalList.dtTo.DateTime:= self.dtTo.DateTime;
         end;
         JournalList.FormStyle:= fsMDIChild;
         JournalList.BringToFront;
       end;
    end;
  end;
end;
procedure TAccountsPayListGUI.ToBeRefreshed;
begin
   lblREfreshInfo.visible := (ClassIDUsed<>ReportforClassId) or
      (xDateFrom<>filterDatefrom) or
      (xdateTo<> FilterDateto) or
      (ShowingPrepayments <> chkShowPrepayments.checked) or
      (AgingTransactionDate<>chkAging.checked) or
      (fblistTobeRefreshed) or
      (CalenderAgeing <> chkCalenderAgeing.Checked);
end;

procedure TAccountsPayListGUI.WriteGuiPref;
begin
  GuiPrefs.Node['General.AgeByTransactionDate'].AsString := SystemLib.BooleanToStr(chkAging.checked);
  GuiPrefs.Node['General.CalenderAgeing'].AsString := SystemLib.BooleanToStr(chkCalenderAgeing.Checked);
end;
procedure TAccountsPayListGUI.ReadGuipref;
begin
  if GuiPrefs.Node.Exists('General') then begin
    chkAging.checked := StrToBoolean(GuiPrefs.Node['General.AgeByTransactionDate'].AsString);
    chkCalenderAgeing.Checked := StrToBoolean(GuiPrefs.Node['General.CalenderAgeing'].AsString);
  end;
end;
Procedure TAccountsPayListGUI.InitGridfields;
var
  GridFieldList: TGridFieldList;
  GridField: TGridFieldRec;
  Function AgeByTransDate:String;
  begin
    if chkAging.Checked then
      result := 'Transaction Date'
    else
      REsult := 'DueDate';

  end;
  Procedure Reporthint(const Value:String);
  begin
    if fsGridHint <> '' then fsGridHint := fsGridHint + NL;
    fsGridHint := fsGridHint + Value;
  end;

  Function AsOnDateGroupLabel:String;
  begin
    Result := ' As On ';
    if  IgnoreDateRange then result := FormatDatetime(FormatSettings.ShortDateFormat, Date)
    else Result := FormatDatetime(FormatSettings.ShortDateFormat, filterdateTo);
  end;
  Function DevModeDesc( const Value:String):String;
  begin
    REsult := '';
    if not devmode then exit;
    result :='   ie: ' + Value;
  end;
begin
  fsGridHint := '';
  GridFieldList := TGridFieldList.Create;
  try

    GridFieldList.LoadFromGrid(grdMain);

    if chkCalenderAgeing.Checked {and (not chkAging.Checked)} then begin
       GridField := GridFieldList.FieldByName('Current');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := FormatDateTime('mmm',CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto));
          Reporthint(Quotedstr(GridField.DisplayLabel)  +' is Saying That The Transaction Is Within Their Trading Terms As Of ' + FormatDateTime('mmm-yyyy',CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto))+
                DevModeDesc(AgeByTransDate +' >= ' + Date_Thismonth(chkIgnoreDates.Checked,FilterDateto, true)));
        end;
        Reporthint('===========================================================');
        GridField := GridFieldList.FieldByName('30Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := FormatDateTime('mmm',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-1));
          GridField.GroupName := 'Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 30 Days As Of '+
                                    FormatDateTime('mmm-yyyy',CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto))+
                                    DevModeDesc(AgeByTransDate +' >= ' + Datefrom_1_30(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Date_Thismonth(chkIgnoreDates.Checked,FilterDateto, true)));
        end;

        GridField := GridFieldList.FieldByName('60Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := FormatDateTime('mmm',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-2));
          GridField.GroupName := 'Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 60 Days As Of '+
                                  FormatDateTime('mmm-yyyy',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-1))+
                                  DevModeDesc(AgeByTransDate +' >= ' + Datefrom_30_60(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Datefrom_1_30(chkIgnoreDates.Checked,FilterDateto, true)));
        end;

        GridField := GridFieldList.FieldByName('90Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := FormatDateTime('mmm',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-3));
          GridField.GroupName := 'Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 90 Days As Of '+
                  FormatDateTime('mmm-yyyy',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-3))+
                  DevModeDesc(AgeByTransDate +' >= ' + Datefrom_60_90(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Datefrom_30_60(chkIgnoreDates.Checked,FilterDateto, true) ));
        end;

        GridField := GridFieldList.FieldByName('120Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '< ' + FormatDateTime('mmm',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-3));
          GridField.GroupName := 'Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying that the Transaction is Overdue More than 90 Days As Of  '+
                          FormatDateTime('mmm-yyyy',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-3))+
                          DevModeDesc(AgeByTransDate +' < ' +Datefrom_60_90(chkIgnoreDates.Checked,FilterDateto, true) ));
        end;
    end
    else begin

        GridField := GridFieldList.FieldByName('Current');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := 'Current';
          Reporthint(Quotedstr(GridField.DisplayLabel)  +' is Saying That The Transaction Is Within Their Trading Terms As Of ' + Date_today(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' >= ' + Date_today(chkIgnoreDates.Checked,FilterDateto, true) ));
        end;
        Reporthint('===========================================================');
        GridField := GridFieldList.FieldByName('30Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '1-30 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 30 Days As Of '+ Date_today(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' >= ' + Date_1_30(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Date_today(chkIgnoreDates.Checked,FilterDateto, true)  )) ;
        end;

        GridField := GridFieldList.FieldByName('60Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '30-60 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 60 Days As Of '+ Date_1_30(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' >= ' + Date_30_60(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Date_1_30(chkIgnoreDates.Checked,FilterDateto, true) ));
        end;

        GridField := GridFieldList.FieldByName('90Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '60-90 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 60 Days As Of '+ Date_30_60(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' >= ' + Date_60_90(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Date_30_60(chkIgnoreDates.Checked,FilterDateto, true)));
        end;

        GridField := GridFieldList.FieldByName('120Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '> 90 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying that the Transaction is Overdue More than 90 Days As Of  '+ Date_60_90(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' < ' +Date_60_90(chkIgnoreDates.Checked,FilterDateto, true) ));
        end;
    end;
    GridFieldList.SaveToGrid(grdMain);
  finally
    GridFieldList.Free;
  end;
end;
procedure TAccountsPayListGUI.RefreshAll;
var
  GridFieldList: TGridFieldList;
  GridField: TGridFieldRec;
begin
  initqrymainsql;
  inherited RefreshQuery;
  InitGridfields;
  ShowingPrepayments :=chkShowPrepayments.checked;
  AgingTransactionDate:= chkAging.checked;
  xDateFrom := filterDatefrom;
  xdateTo   := FilterDateto;
  ClassIDUsed :=  ReportforClassId;
  CalenderAgeing := chkCalenderAgeing.Checked;
  ToBeRefreshed;
end;

procedure TAccountsPayListGUI.RefreshQuery;
begin
  if Searching then RefreshAll else ToBeRefreshed;
end;

procedure TAccountsPayListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        GroupFilterString := '(Details = 0)';
      end;
    1:
      begin {Details}
        GroupFilterString := '(Details <> 2)';
      end;
    2:
      begin  {Extra Details}
        GroupFilterString := '(Details <> 1)';
      end;
  end;
  If Assigned(PaymentConformation) then Begin
    PaymentConformation.EnablePopupMenu((grpFilters.ItemIndex=2));
    if (grpFilters.ItemIndex=2) then begin
      grdMain.Options := grdMain.Options + [dgMultiSelect];
      grdMain.MultiSelectOptions := grdMain.MultiSelectOptions + [msoShiftSelect,msoAutoUnselect];
    end else begin
      grdMain.Options := grdMain.Options - [dgMultiSelect];
      grdMain.MultiSelectOptions := grdMain.MultiSelectOptions - [msoShiftSelect,msoAutoUnselect];
    end;
  end;
  inherited;
end;

procedure TAccountsPayListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  If Not qryMain.Active Then Exit;
  if not Empty(qryMainSupplierName.AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
  If (grpFilters.ItemIndex=2) then begin
    if QrymainPCStatus.AsString = 'R' then ABrush.Color := ReviewColour;
    if QrymainPCStatus.AsString = 'A' then ABrush.Color := ApprovedColour;
  end;
end;

Procedure TAccountsPayListGUI.logit;
var
  s:String;
begin
  s:= 'Show Prepayments : ' + boolToStr(chkShowPrepayments.checked)+chr(13) +
      'Aging            : ' +booltostr(chkAging.checked);
end;

procedure TAccountsPayListGUI.FormShow(Sender: TObject);
begin
  if not fbDateRangeSupplied then begin
      chkIgnoreDates.checked := true;
    end;
  {$IFDEF DevMode}
  {$ELSE}
  GuiPrefs.DbGridElement[grdMain].RemoveFields('ClientID,TransID,PurchaseOrderID,Notes');
  {$ENDIF}

  if not ErrorOccurred then begin
    cboClassQry.Open;
    cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
    cboClass.LookupValue := AppEnv.DefaultClass.DefaultClassName;

    if self.fbFormOpenedOk then begin
    end;
    ReadGuipref;
    if Assigned(PaymentConformation) then PaymentConformation.APTablename := APReport.TempTableName;
    If Assigned(PaymentConformation) then PaymentConformation.UpdateTotals;
    inherited;
    isformShown := True;
    RefreshAll;
    if not qryMain.Active then Qrymain.Open;
  end else begin
    try
      raise ENoAccess.Create('You don''t have access to Accounts Payable Report!');
    except
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
    end;
  end;
end;

procedure TAccountsPayListGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;
    RefreshQuery;
end;

procedure TAccountsPayListGUI.chkCalenderAgeingClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TAccountsPayListGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TAccountsPayListGUI.chkShowPrepaymentsClick(Sender: TObject);
begin
      RefreshQuery;
end;

procedure TAccountsPayListGUI.FormCreate(Sender: TObject);
Var
  OrgPayApprovedLeft,OrgPrintLeft: Integer;

begin
  Wheresql :='';
  KeysPressed:='';
  btnfix.Visible := devmode;
  fiAPClientID := -1;
  IsGridcustomisable      := True;
  CanCreatecustomReport   := False;
  ReportonForeignCurrency := False;
  NonSearchMode := True;

  inherited;
  APReport := TAPReport.Create;
  APReport.ReportClassName := self.ClassName;
  APReport.APIMode := false;
  EnableClosingDateBalanceCheck:=True;
  showFCFooters := True;
  if not ErrorOccurred then begin
    OriginalSql := Self.qryMain.SQL.Text;
  end;
  if (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPaymentComfirmationAdd')=1) OR
     (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPaymentComfirmationApprove')=1) OR
     (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPaymentComfirmationPayApproved')=1) then Begin
     PaymentConformation := TPaymentConformationObj.Create(Self);
     PaymentConformation.APTablename := APReport.TempTableName;
     PaymentConformation.LoadPopupMenu(mnuFilter,lblReviewAmount,lblApprovedAmount);
     PaymentConformation.OnReviewChange:= DoOnReviewChange;
     lblReview.Font.Color := ReviewColour;
     lblApproved.Font.Color := ApprovedColour;
  end else
    PaymentConformation := nil;
  If Assigned(PaymentConformation) then begin
    PaymentConformation.APTablename := APReport.TempTableName;
    lblApprovedAmount.Visible := True;
    lblReviewAmount.Visible := True;
    lblApprovedAmount.Visible := True;
    lblReviewAmount.Visible := True;
    lblReview.Visible := True;
    lblApproved.Visible := True;
    if (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPaymentComfirmationPayApproved')=1) then Begin
      OrgPrintLeft:= cmdPrint.Left;
      OrgPayApprovedLeft := btnPayApproved.Left;
      btnPayApproved.Left := OrgPrintLeft;
      cmdPrint.Left:= OrgPayApprovedLeft;
      btnPayApproved.Visible := True;
      Alignbuttons;
    end;
  end;
  chkCalenderAgeing.Left := chkAdvancedPrinting.Left;
  ShowChartViewOnPopup := True;
end;

procedure TAccountsPayListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.FieldDefs.Update;
  qryMain.IndexFieldNames := QuotedStr('Name') + ' ASC CIS ; ' + QuotedStr('ClientID') + ' ASC CIS ; ' +
    QuotedStr('Details') + ' ASC CIS ; ' + QuotedStr('DueDate') + ' ASC CIS';
  BaseIndexFieldNames := QuotedStr('ClientID') + ' ASC CIS ; ' + QuotedStr('Details') + ' ASC CIS';
end;

procedure TAccountsPayListGUI.btnBulkPayClick(Sender: TObject);
var tmpComponent:TComponent;
begin
  DisableForm;
  try
    inherited;
    tmpComponent:=  GetComponentByClassName('TfrmBulkPaySuppliers');
    if not assigned(tmpComponent) then exit;
    with TfrmBulkPaySuppliers(tmpComponent) do begin
      FormStyle := fsMDIChild;
      BringToFront;
      Self.Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TAccountsPayListGUI.chkAgingClick(Sender: TObject);
begin
  inherited;
      RefreshQuery;
end;

procedure TAccountsPayListGUI.FormDestroy(Sender: TObject);
begin
  If Assigned(PaymentConformation) then FreeAndNil(PaymentConformation);
  APReport.Free;
  inherited;
end;

procedure TAccountsPayListGUI.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift ) and (Key in [ord('F') , ord('I') , ord('X') , ord('I') , ord('T')]) then begin
      KeysPressed :=KeysPressed +chr(key);
    if Sysutils.SameText(KeysPressed , 'FIXIT') then begin
      btnfix.visible := devmode;
    end;
  end else KeysPressed := '';

  if Qrymain.active =false then Refreshall;
end;

procedure TAccountsPayListGUI.btnPayApprovedClick(Sender: TObject);
var
  SuppPayments: TSuppPayments;
  msg: string;
begin
  DisableForm;
  try
    inherited;
    SuppPayments:= TSuppPayments.Create(nil);
    try
      SuppPayments.Connection:= TMyDacDataConnection.Create(SuppPayments);
      SuppPayments.Connection.Connection:= CommonDbLib.GetNewMyDacConnection(SuppPayments.Connection);
      SuppPayments.confirmFromGUI := Self.confirmFromGUI;
      SuppPayments.SilentMode:= true;
      if SuppPayments.Payapproved then
        actRefreshQryExecute(actRefreshQry)
      else begin
        if SuppPayments.ResultStatus.HasCode(BORSCode_No_Data) then begin
          msg:= 'No pending transactions to pay.';
          commonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
        end
        else begin
          msg:= SuppPayments.ResultStatus.Messages;
          msg:= 'Could not process payments for ' + SuppPayments.client.clientName + ':' + #13#10 + msg;
          commonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
        end;
      end;
      ReFreshQeymain;
    finally
      SuppPayments.Free;
    end;

  finally
    EnableForm;
  end;
end;
procedure TAccountsPayListGUI.HandleInitDialog(Dialog: TwwMemoDlg);
var
  Index: Integer;
  BtnArray: array[1..4] of TDNMSpeedButton;
begin
  with Dialog do begin
    for Index := 1 to 4 do begin
      BtnArray[Index] := TDNMSpeedButton.Create(Dialog);

      if Index <= 2 then
        BtnArray[Index].Parent := Dialog.UserButtonPanel
      else
        BtnArray[Index].Parent := Dialog;

      BtnArray[Index].Color := clWhite;
      BtnArray[Index].HotTrackColor := clBtnShadow;
      BtnArray[Index].SlowDecease := true;
      BtnArray[Index].Style := bsModern;
      BtnArray[Index].Visible := true;
    end;

    BtnArray[1].Left := UserButton1.Left;
    BtnArray[1].Top := UserButton1.Top;
    BtnArray[1].Width := UserButton1.Width;
    BtnArray[1].Height := UserButton1.Height;
    BtnArray[1].Font.Name := 'Ariel';
    BtnArray[1].Font.Size := 9;
    BtnArray[1].Font.Style := [fsBold];
    BtnArray[1].Caption := UserButton1.Caption;
    BtnArray[1].OnClick := UserButton1.OnClick;

    BtnArray[2].Left := UserButton2.Left;
    BtnArray[2].Top := UserButton2.Top;
    BtnArray[2].Width := UserButton2.Width;
    BtnArray[2].Height := UserButton2.Height;
    BtnArray[2].Font.Name := 'Ariel';
    BtnArray[2].Font.Size := 9;
    BtnArray[2].Font.Style := [fsBold];
    BtnArray[2].Caption := UserButton2.Caption;
    BtnArray[2].OnClick := UserButton2.OnClick;

    BtnArray[3].Left := OKBtn.Left;
    BtnArray[3].Top := OKBtn.Top;
    BtnArray[3].Width := OKBtn.Width;
    BtnArray[3].Height := OKBtn.Height;
    BtnArray[3].Font.Name := 'Ariel';
    BtnArray[3].Font.Size := 9;
    BtnArray[3].Font.Style := [fsBold];
    BtnArray[3].Caption := OKBtn.Caption;
    BtnArray[3].Enabled := OKBtn.Enabled;
    BtnArray[3].Kind := bkOK;
    BtnArray[3].OnClick := OKBtn.OnClick;

    BtnArray[4].Left := CancelBtn.Left;
    BtnArray[4].Top := CancelBtn.Top;
    BtnArray[4].Width := CancelBtn.Width;
    BtnArray[4].Height := CancelBtn.Height;
    BtnArray[4].Font.Name := 'Ariel';
    BtnArray[4].Font.Size := 9;
    BtnArray[4].Font.Style := [fsBold];
    BtnArray[4].Caption := CancelBtn.Caption;
    BtnArray[4].Kind := bkCancel;
    BtnArray[4].OnClick := CancelBtn.OnClick;

    UserButton1.Hide;
    UserButton2.Hide;
    OKBtn.Hide;
    CancelBtn.Hide;

    UserButton1 := TButton(BtnArray[1]);
    UserButton2 := TButton(BtnArray[2]);
    OKBtn := TButton(BtnArray[3]);
    CancelBtn := TButton(BtnArray[4]);
  end;
end;

procedure TAccountsPayListGUI.actRefreshQryExecute(Sender: TObject);
begin
    RefreshAll;
end;

procedure TAccountsPayListGUI.APMemoDialogUserButton1Click(
  Dialog: TwwMemoDlg; Memo: TMemo);
begin
  inherited;
  Memo.Lines.Text := Memo.Lines.Text + ' :- (' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName +
    ') ' + FormatDateTime('dddd mmmm d yyyy " at " hh:mm AM/PM', Now) + #13#10;
end;

procedure TAccountsPayListGUI.APMemoDialogUserButton2Click(Dialog: TwwMemoDlg; Memo: TMemo);
var
  Qry : TERPQuery;
  SelectDate: TfmDateSelectDialog;
begin
  Qry := TERPQuery.Create(nil);
  Qry.Options.FlatBuffers := True;
  SelectDate := TfmDateSelectDialog(GetComponentByClassname('TfmDateSelectDialog'));

  try
    if Assigned(SelectDate) then begin

      if SelectDate.ShowModal = mrOK then begin
        Qry.Connection := CommonDBlib.GetSharedMyDacConnection;
        Qry.SQL.Text := 'SELECT * FROM tblToDo Limit 0';
        Qry.Open;
        Qry.Insert;
        Qry.FieldByName('CreatedDate').AsDateTime := Now;
        Qry.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
        Qry.FieldByName('Description').AsString := APMemoDialog.Form.Memo.Text;
        Qry.FieldByName('ToDoByDate').AsDateTime := SelectDate.Calendar.Date;
        Qry.FieldByName('AppearDays').AsInteger := AppEnv.Employee.ToDoAppearDays;
        Qry.FieldByName('CreatedByEmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
        Qry.Post;

        if APMemoDialog.Form.OKBtn.Enabled then
          APMemoDialog.Form.OKBtn.Click;
      end;
    end;
  finally
    FreeAndNil(qry);
    FreeAndNil(SelectDate);
  end;
end;

procedure TAccountsPayListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TAccountsPayListGUI.btnfixClick(Sender: TObject);
begin
  inherited;
 exit;
 IterateProcNo := 1;
 IterateselectedRecords(true);
  SetcontrolFocus(cmdClose);
  btnfix.Visible := devmode;
end;
procedure TAccountsPayListGUI.btnhelpClick(Sender: TObject);
begin
  inherited;
  if fsGridHint = '' then InitGridfields;
  if devmode then
    MessageDlgXP_Vista(fsGridHint, mtInformation, [mbOK], 0,nil,'','',false,nil,'' , '',800)
  else
    MessageDlgXP_Vista(fsGridHint, mtInformation, [mbOK], 0,nil,'','',false,nil,'' , '',600);

end;

procedure TAccountsPayListGUI.ShowControlhints;
var
  s:String;
begin
  inherited;
  s:= 'For this report to match with the Balance Sheet, Please make sure ' + NL+ quotedstr(chkAging.caption)+' is turned ON and ' +NL+quotedstr(chkShowPrepayments.caption)+' should be turned OFF.'+NL;
  ShowControlhint(chkShowPrepayments , s);
  ShowControlhint(chkAging , s);
  ShowControlhint(grdMain , s);
  TimerMsg(FilterLabel ,replacestr(s, NL , ' '));
end;

procedure TAccountsPayListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
begin
end;
procedure TAccountsPayListGUI.cmdExportClick(Sender: TObject);
begin

  if lblREfreshInfo.Visible then begin
    MessageDlgXP_Vista('The data on this report has not been refreshed.' + #13#10 +
      'Please Refresh this report before Continuing.', mtInformation, [mbOk], 0);
    exit;
  end;

  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TAccountsPayListGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TAccountsPayListGUI.cmdPrintClick(Sender: TObject);
begin

  if lblREfreshInfo.Visible then begin
    MessageDlgXP_Vista('The data on this report has not been refreshed.' + #13#10 +
      'Please Refresh this report before Continuing.', mtInformation, [mbOk], 0);
    exit;
  end;

  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TAccountsPayListGUI.DoOnReviewChange(Sendet: TObject);
begin
  ReFreshQeymain;
end;

procedure TAccountsPayListGUI.ReFreshQeymain;
var
  fitransid :Integer;
begin
  if qrymain.Active then begin
    fitransId := qrymaintransid.asInteger;
    try
      closedb(qrymain);
      Opendb(qrymain);
    finally
      if fitransid <> 0 then
        Qrymain.locate('transId' , fitransid , []);
    end;
  end;
end;

procedure TAccountsPayListGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  if (QrymainTransId.asInteger <> 0)  and (qryMainType.asString = 'Journal Entry') then begin
     Popupform.KeyID := SaleIDFromTrans(QrymainTransId.asInteger);
  end else begin
      inherited;
  end;
end;

procedure TAccountsPayListGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;
end;

initialization
  RegisterClassOnce(TAccountsPayListGUI);
end.




