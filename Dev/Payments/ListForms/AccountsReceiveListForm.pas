Unit AccountsReceiveListForm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 29/06/05  1.00.01 BJ  New option to Group the jobs with customer.
                       When checked, the Teh customer and all its jobs will be
                       summerised into 1 line and the custmer name will be
                       displaed.
 26/09/05  1.00.02 ISB Added chkAging
 03/11/05  1.00.03 MV  Added Employee Name to ARMemoDialogUserButton1Click Date
 04/11/05  1.00.04 MV  Added Credit Limit to details list.
 14/03/06  1.00.05 DSP Added HandleDialogInit to modify the dialog's buttons to
                       be TDNMSpeedButtons. Also added a date selector form.
}

interface

uses
  Messages, Graphics, Dialogs, BaseListingForm, ActnList, PrintDAT,
  Menus, AdvMenus, DB, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, wwdblook, wwcheckbox, SelectionDialog, DNMPanel,
  wwDialog, Wwlocate, wwMemo, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker,
  ProgressDialog, Classes, ImgList, Controls,  Report_AR_Obj,
  Shader, kbmMemTable,Forms, DAScript, MyScript, frmDelayMessageDlg, CustomInputBox, busobjSales, IntegerListObj,
  wwclearbuttongroup, wwradiogroup, GIFImg, ARReportSQL;

const
  SX_DatechangeMsg = WM_USER + 125;

type
  TAccountsReceiveListGUI = class(TBaseListingGUI)
    qryARNotes: TERPQuery;
    DSARNotes: TDataSource;
    ARMemoDialog: TwwMemoDialog;
    chkShowPrepayments: TCheckBox;
    btnBulkPay: TDNMSpeedButton;
    chkGroupJobsWithCustomer: TCheckBox;
    chkAging: TCheckBox;
    qryMainCustomerName: TWideStringField;
    qryMainConNote: TWideStringField;
    qryMainPrintname: TWideStringField;
    qryMainRelatedCustomerName: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainType: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainDueDate: TDateField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainName: TWideStringField;
    qryMainOriginalAmount: TFloatField;
    qryMainAmountDue: TFloatField;
    qryMainCurrent: TFloatField;
    qryMainDSDesigner17Days: TFloatField;
    qryMainDSDesigner714Days: TFloatField;
    qryMainDSDesigner1421Days: TFloatField;
    qryMainDSDesigner21Days: TFloatField;
    qryMainDSDesigner130Days: TFloatField;
    qryMainDSDesigner3060Days: TFloatField;
    qryMainDSDesigner6090Days: TFloatField;
    qryMainDSDesigner90Days: TFloatField;
    qryMainSaleID: TLargeintField;
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
    qryMainPhone: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainDetails: TLargeintField;
    qryMainNotes: TWideMemoField;
    qryMainStopCredit: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainTransactionName: TWideStringField;
    qryMainCreditLimit: TFloatField;
    qryMainClientID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainPO_Number: TWideStringField;
    qryMainAvgDays: TFloatField;
    qryMainPrepaymentno: TIntegerField;
    qryMainChequeNo: TWideStringField;
    qryMainShipping: TWideStringField;
    qryMainTerms: TWideStringField;
    lblREfreshInfo: TLabel;
    qryMainClassName: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainClientNo: TWideStringField;
    chkCalenderAgeing: TCheckBox;
    qryMainARNotes: TWideMemoField;
    btnEmail: TDNMSpeedButton;
    qryMainEmail: TWideStringField;
    qryMainOverdueSurchargeDesc: TWideStringField;
    btnApplySurcharge: TDNMSpeedButton;
    btnhelp: TDNMSpeedButton;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
    procedure ARMemoDialogUserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
    procedure chkShowPrepaymentsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnBulkPayClick(Sender: TObject);
    procedure chkGroupJobsWithCustomerClick(Sender: TObject);
    procedure chkAgingClick(Sender: TObject);
    procedure ARMemoDialogUserButton2Click(Dialog: TwwMemoDlg;
      Memo: TMemo);
    procedure FormDestroy(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkCalenderAgeingClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure btnSMSClick(Sender: TObject);
    procedure btnApplySurchargeClick(Sender: TObject);
    procedure grdMainMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure btnhelpClick(Sender: TObject);
  private
    { Private declarations }
    ClassIDUsed:Integer;
    xDateFrom, xdateTo:TDateTime;
    ShowingPrepayments:boolean;
    AgingTransactionDate:Boolean;
    CalenderAgeing: boolean;
    DetailsStr: string;
    fInv: TInvoice;
    UpdatedIds :TStringlist;
    TblUpdateSurchargestatus:String;
    ARReport: TARReport;
    fsGridHint :String;

    procedure HandleInitDialog(Dialog : TwwMemoDlg);
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    Procedure ToBeRefreshed;
    procedure SendBulkEmail;
    Procedure ApplyOverdueSurcharge(var abort:Boolean);
    function InvObj: TInvoice;
    procedure ShowSurchargeUpdateResult;
    function allowSelection: Boolean;
    procedure InitGridfields;
    procedure SetQryMainSQL;
    procedure initJournalList(Sender: TObject);
  protected
    Wheresql :String;
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure SetGridColumns;override;
    procedure RefreshAll;Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    procedure actEmail(Sender : TObject);
    procedure initqrymainsql;Override;
  public
    { Public declarations }
    ARClientID :Integer;
  end;

implementation

uses
  Windows, SysUtils, CommonDbLib,
  DNMExceptions, frmBulkPayCustomers,
  CommonLib, frmDateSelectDialog, AppEnvironment, FastFuncs,
  JournalList, BusObjGLAccount, tcConst, SystemLib, TransactionsTable,
  GridFieldsObj, EmailUtils, CorrespondenceObj, DbSharedObjectsObj,
  AppEnvironmentVirtual, frmMessageWithList, frmMessageBase, TemplateReportsLib, frmReportingOptions,
  EmailExtraUtils, CommonFormLib , ReportLib;

{$R *.dfm}

procedure TAccountsReceiveListGUI.WriteGuiPref;
begin
  GuiPrefs.Node['General.AgeByTransactionDate'].AsString := BooleanToStr(chkAging.checked);
  GuiPrefs.Node['General.CalenderAgeing'].AsString := BooleanToStr(chkCalenderAgeing.Checked);
  GuiPrefs.Node['General.ShowPrepayments'].AsString := BooleanToStr(chkShowPrepayments.Checked);
end;

procedure TAccountsReceiveListGUI.ReadGuipref;
begin
    if GuiPrefs.Node.Exists('General') then begin
      chkAging.checked     := StrToBoolean(GuiPrefs.Node['General.AgeByTransactionDate'].AsString);
      chkCalenderAgeing.Checked := StrToBoolean(GuiPrefs.Node['General.CalenderAgeing'].AsString);
      chkShowPrepayments.Checked := StrToBoolean(GuiPrefs.Node['General.ShowPrepayments'].AsString);
    end;
end;
procedure TAccountsReceiveListGUI.RefreshTotals;
var
    fsFilter, s: string;
begin
    Qrymain.disablecontrols;
    try
        fsFilter := Qrymain.filter;
        s:= Qrymain.filter;
        if fsfilter <> '' then begin
          if Pos(DetailsStr,s) > 0 then
            s:= StringReplace(s,DetailsStr,'Details = 1',[rfIgnoreCase])
          else
            s:= s + ' AND Details = 1 ';
        end
        else
            s:= ' Details = 1 ';
        qrymain.filter:= s;
        qrymain.filtered := True;
        CalcnShowFooter;
    finally
        if fsfilter <> '' then begin
            Qrymain.filter := fsFilter;
            qrymain.filtered := True;
        end else qrymain.filtered := False;
        qrymain.enablecontrols;
    end;
end;

procedure TAccountsReceiveListGUI.grdMainDblClick(Sender: TObject);
var
  JournalList: TJournalListGui;
begin
  if qryMain.fieldbyname('SaleID').AsInteger > 0 then begin
    if (grdMain.GetActiveField.FieldName = 'ARNotes') and (qryMain.fieldbyname('Details').AsInteger = 2) and (qryMain.fieldbyname('SaleID').AsInteger <> 0) then
    begin
      qryARNotes.Close;

      if qryMain.fieldbyname('Type').AsString <> CUSTOMER_PREPAYMENT then begin
        qryARNotes.SQL.Text := 'SELECT SaleID, ARNotes FROM tblsales Where SaleID = :ID';
        ARMemoDialog.DataField := 'ARNotes';
      end

      else if qryMain.fieldbyname('Type').AsString = CUSTOMER_PREPAYMENT then begin
        qryARNotes.SQL.Text := 'SELECT PrePaymentID, Notes FROM tblprepayments Where PrePaymentID = :ID';
        ARMemoDialog.DataField := 'Notes';
      end;

      qryARNotes.ParamByName('ID').AsInteger := qryMain.fieldbyname('SaleID').AsInteger;
      qryARNotes.Open;
      if not qryARNotes.IsEmpty then begin
        ARMemoDialog.OnInitDialog := HandleInitDialog;

        if ARMemoDialog.Execute then begin
          qryARNotes.Edit;
          qryARNotes.Post;
          qryMain.Refresh;
        end;
      end else begin
        SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
        inherited;
      end;
    end else begin
      if qryMain.FieldByName('Type').AsString = 'Journal Entry' then begin
         (*JournalList:= TJournalListGui(FindExistingComponent('TJournalListGui'));

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
           JournalList.chkIgnoreDates.Checked:= self.chkIgnoreDates.Checked;
           if not JournalList.chkIgnoreDates.Checked then begin
             JournalList.dtFrom.DateTime:= self.dtFrom.DateTime;
             JournalList.dtTo.DateTime:= self.dtTo.DateTime;
           end;
           JournalList.FormStyle:= fsMDIChild;
           JournalList.BringToFront;
         end;*)
         Processingcursor(true);
         try
            ShowProgressbar(WAITMSG, 3);
            try
               StepProgressbar;
               CloseformifOpen('TJournalListGui');
               StepProgressbar;
               OpenERPListForm('TJournalListGui', initJournalList);
               StepProgressbar;
            finally
              HideProgressbar;
            end;
         finally
           ProcessingCursor(False);
         end;
      end
      else begin
        SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
        inherited;
      end;
    end;
  end;
end;
procedure TAccountsReceiveListGUI.initJournalList(Sender:TObject);
begin
  if sender is   TJournalListGui then begin
     TJournalListGui(Sender).AccountIdList          := TAccount.AccountGroupIdListForAccount(qryMainAccountName.AsString);
     TJournalListGui(Sender).ClientID               := qryMainClientID.AsInteger;
     TJournalListGui(Sender).chkIgnoreDates.Checked := self.chkIgnoreDates.Checked;
     if not TJournalListGui(Sender).chkIgnoreDates.Checked then begin
       TJournalListGui(Sender).dtFrom.DateTime      := self.dtFrom.DateTime;
       TJournalListGui(Sender).dtTo.DateTime        := self.dtTo.DateTime;
     end;
  end;
end;
procedure TAccountsReceiveListGUI.grdMainMultiSelectAllRecords(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if Selecting then Accept := AllowSelection;
end;
Function TAccountsReceiveListGUI.allowSelection:Boolean;
begin
      result :=  ( Qrymaindetails.asinteger = 2 ) and
       ((qryMain.fieldbyname('Type').AsString <> CUSTOMER_PREPAYMENT) and (qryMain.fieldbyname('Type').AsString <> JOURNAL_ENTRY) and (qryMain.fieldbyname('Type').AsString <> RefundType) ) and
       ((qryMainDSDesigner130Days.AsFloat <>0) or (qryMainDSDesigner3060Days.AsFloat <>0) or (qryMainDSDesigner6090Days.AsFloat <>0) or (qryMainDSDesigner90Days.AsFloat <>0)) ;

end;
procedure TAccountsReceiveListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if Selecting then Accept := AllowSelection;
end;

procedure TAccountsReceiveListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        GroupFilterString := '(Details = 0)';
        DetailsStr:= 'Details = 0';
      end;
    1:
      begin {Details}
        GroupFilterString := '(Details <> 2)';
        DetailsStr:= 'Details <> 2';
      end;
    2:
      begin  {Extra Details}
        GroupFilterString := '(Details <> 1)';
        DetailsStr:= 'Details <> 1';
      end;
    else
       DetailsStr:= '';
  end;
  inherited;
end;
procedure TAccountsReceiveListGUI.ToBeRefreshed;
begin
   lblREfreshInfo.visible := (ClassIDUsed<>Selectedclassid) or
      (xDateFrom<>filterDatefrom) or
      (xdateTo<> FilterDateto) or
      (ShowingPrepayments <> chkShowPrepayments.checked) or
      (AgingTransactionDate<>chkAging.checked) or
      (CalenderAgeing <> chkCalenderAgeing.Checked);
end;

Procedure TAccountsReceiveListGUI.RefreshAll;
begin
  ARReport.DateFrom             := FilterdateFrom;
  ARReport.DateTo               := filterdateTo;
  ARReport.Ignoredates          := IgnoreDateRange;
  ARReport.WhereSQL             := WhereSQL;
  ARReport.DepartmentID         := Selectedclassid;
  ARReport.IncludePrepayments   := chkShowPrepayments.Checked;
  ARReport.AgeByTransactionDate := chkAging.Checked;
  ARReport.GroupJobsWithCustomer:= chkGroupJobsWithCustomer.Checked;
  ARReport.CalenderAgeing       := chkCalenderAgeing.Checked;
  ARReport.ClientID             := ARClientID;

  SetQryMainSQL;
  RefreshOrignalSQL;

  inherited RefreshQuery;

  InitGridFields;
  ShowingPrepayments  := chkShowPrepayments.checked;
  AgingTransactionDate:= chkAging.checked;
  CalenderAgeing      := chkCalenderAgeing.Checked;
  xDateFrom           := filterDatefrom;
  xdateTo             := FilterDateto;
  ClassIDUsed         := Selectedclassid;
  ToBeRefreshed;

end;
Procedure TAccountsReceiveListGUI.InitGridfields;
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
        GridField := GridFieldList.FieldByName('1-30Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := FormatDateTime('mmm',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-1));
          GridField.GroupName := 'Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 30 Days As Of '+
                                    FormatDateTime('mmm-yyyy',CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto))+
                                    DevModeDesc(AgeByTransDate +' >= ' + Datefrom_1_30(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Date_Thismonth(chkIgnoreDates.Checked,FilterDateto, true)));
        end;

        GridField := GridFieldList.FieldByName('30-60Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := FormatDateTime('mmm',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-2));
          GridField.GroupName := 'Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 60 Days As Of '+
                                  FormatDateTime('mmm-yyyy',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-1))+
                                  DevModeDesc(AgeByTransDate +' >= ' + Datefrom_30_60(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Datefrom_1_30(chkIgnoreDates.Checked,FilterDateto, true)));
        end;

        GridField := GridFieldList.FieldByName('60-90Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := FormatDateTime('mmm',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-3));
          GridField.GroupName := 'Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 90 Days As Of '+
                  FormatDateTime('mmm-yyyy',IncMonth(CurDateifIgnoredateRange(chkIgnoreDates.Checked,FilterDateto),-3))+
                  DevModeDesc(AgeByTransDate +' >= ' + Datefrom_60_90(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Datefrom_30_60(chkIgnoreDates.Checked,FilterDateto, true) ));
        end;

        GridField := GridFieldList.FieldByName('>90Days');
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
        GridField := GridFieldList.FieldByName('1-30Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '1-30 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 30 Days As Of '+ Date_today(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' >= ' + Date_1_30(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Date_today(chkIgnoreDates.Checked,FilterDateto, true)  )) ;
        end;

        GridField := GridFieldList.FieldByName('30-60Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '30-60 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 60 Days As Of '+ Date_1_30(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' >= ' + Date_30_60(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Date_1_30(chkIgnoreDates.Checked,FilterDateto, true) ));
        end;

        GridField := GridFieldList.FieldByName('60-90Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '60-90 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 60 Days As Of '+ Date_30_60(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' >= ' + Date_60_90(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Date_30_60(chkIgnoreDates.Checked,FilterDateto, true)));
        end;

        GridField := GridFieldList.FieldByName('>90Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '> 90 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying that the Transaction is Overdue More than 90 Days As Of  '+ Date_60_90(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' < ' +Date_60_90(chkIgnoreDates.Checked,FilterDateto, true) ));
        end;

          Reporthint('===========================================================');
        GridField := GridFieldList.FieldByName('1-7Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '1-7 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 7 Days As Of '+ Date_today(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' >= ' + Date_1_7(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Date_today(chkIgnoreDates.Checked,FilterDateto, true) ));
        end;

        GridField := GridFieldList.FieldByName('7-14Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '7-14 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 14 Days As Of '+ Date_1_7(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' >= ' + Date_7_14(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Date_1_7(chkIgnoreDates.Checked,FilterDateto, true)  ));
        end;

        GridField := GridFieldList.FieldByName('14-21Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '14-21 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying That The Transaction is Overdue By Up To 21 Days As Of '+ Date_7_14(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' >= ' + Date_14_21(chkIgnoreDates.Checked,FilterDateto, true) +' and < ' +Date_7_14(chkIgnoreDates.Checked,FilterDateto, true) ));
        end;

        GridField := GridFieldList.FieldByName('>21Days');
        if Assigned(GridField) then begin
          GridField.DisplayLabel := '> 21 Days';
          GridField.GroupName := 'Days Outside Trading Terms'+ AsOnDateGroupLabel;
          Reporthint(Quotedstr(GridField.DisplayLabel)  + ' is Saying that the Transaction is Overdue More than 21 Days As Of  '+ Date_14_21(chkIgnoreDates.Checked,FilterDateto, true)+
          DevModeDesc(AgeByTransDate +' < ' +Date_14_21(chkIgnoreDates.Checked,FilterDateto, true) ));
        end;
    end;
    GridFieldList.SaveToGrid(grdMain);
  finally
    GridFieldList.Free;
  end;
end;
procedure TAccountsReceiveListGUI.initqrymainsql;
begin
  SetQryMainSQL;
end;
procedure TAccountsReceiveListGUI.SetQryMainSQL;
var
  msg: string;
begin
  ARReport.PopulateReportSQL(qryMain.SQL, msg);
end;
procedure TAccountsReceiveListGUI.RefreshQuery;
begin
if Searching then
  inherited RefreshQuery
else ToBeRefreshed;

end;
procedure TAccountsReceiveListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Field= nil then begin
      Exit;
  end;
  if not Empty(qryMain.fieldbyname('CustomerName').AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
  if qryMain.fieldbyname('StopCredit').AsBoolean then begin
    AFont.Color := clRed;
  end;
  if Sysutils.SameText(Field.fieldname , 'AvgDays' ) then begin
     if (qryMainDetails.asInteger <> 0) or (qryMainAvgDays.asFloat = 0) then
        Afont.Color := ABrush.color;
  end;
  HideZeroValueInNumberfield(State,Field, Afont,Abrush);
  if chkCalenderAgeing.checked then
    if SameText(Field.fieldname ,    qryMainDSDesigner17Days.fieldname) or
       SameText(Field.fieldname ,    qryMainDSDesigner714Days.fieldname) or
       SameText(Field.fieldname ,    qryMainDSDesigner1421Days.fieldname) or
       SameText(Field.fieldname ,    qryMainDSDesigner21Days.fieldname) then begin
       //DoGrayoutCell(Afont, Abrush);
       DoHide(Field,State,Afont, Abrush);
    end;
end;

procedure TAccountsReceiveListGUI.FormShow(Sender: TObject);
begin
  if not fbDateRangeSupplied then begin
    chkIgnoreDates.checked := true;
  end;

  GuiPrefs.DbGridElement[grdMain].RemoveFields('ClientID,SaleID,details,Notes');
  if not ErrorOccurred then begin
    if AppEnv.CompanyPrefs.UseEmployeeClassForARList and (AppEnv.Employee. DefaultClassID > 0) then begin
      SelectedClassId :=AppEnv.Employee. DefaultClassID;
    end;
    ReadGuipref;
    inherited;
    RefreshAll;
    if not (Qrymain.active) then
      Qrymain.Open;
  end else begin
    try
      raise ENoAccess.Create('You don''t have access to Accounts Receivable Report!');
    except
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
    end;
  end;
end;

procedure TAccountsReceiveListGUI.chkCalenderAgeingClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TAccountsReceiveListGUI.actEmail(Sender: TObject);
begin
  SendBulkEmail;
end;

procedure TAccountsReceiveListGUI.actRefreshQryExecute(Sender: TObject);
begin
  if not fbFormOpenedOk then exit;
  RefreshAll;
  // inherited;
end;

procedure TAccountsReceiveListGUI.ARMemoDialogUserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
begin
  inherited;
  Memo.Lines.Text := Memo.Lines.Text + ' :- (' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName +
    ') ' + FormatDateTime('dddd mmmm d yyyy " at " hh:mm AM/PM', Now) + #13#10;
end;

procedure TAccountsReceiveListGUI.chkShowPrepaymentsClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TAccountsReceiveListGUI.FormCreate(Sender: TObject);
begin
  Wheresql :='';
  //Wheresql :='AR.Type <> "' + CUSTOMER_PAYMENT + '" ';

  fInv := Nil;
  ARClientID := -1;
  chkGroupJobsWithCustomer.OnClick := nil;
  chkGroupJobsWithCustomer.Checked := AppEnv.CompanyPrefs.groupJobsOnAccountsReceivable;
  chkGroupJobsWithCustomer.OnClick := chkGroupJobsWithCustomerClick;
  IsGridcustomisable      := True;
  CanCreatecustomReport   := True;
  ReportonForeignCurrency := False;
  inherited;
  SelectionOption := soClass;
  EnableClosingDateBalanceCheck:=True;
  SearchMode:= smFullList;
  AddCalcColumn('OriginalAmount', true);
  AddCalcColumn('AmountDue', true);
  AddCalcColumn('Current', true);
  AddCalcColumn('1-7Days', true);
  AddCalcColumn('7-14Days', true);
  AddCalcColumn('14-21Days', true);
  AddCalcColumn('>21Days', true);
  AddCalcColumn('1-30Days', true);
  AddCalcColumn('30-60Days', true);
  AddCalcColumn('60-90Days', true);
  AddCalcColumn('>90Days', true);
  ARReport := TARReport.Create;


  showFCFooters := true;
  ShowChartViewOnPopup := True;
  TblUpdateSurchargestatus :=CommonDbLib.GetUserTemporaryTableName('AR_Updatesurcharge' );
  btnApplySurcharge.Visible := Appenv.CompanyPrefs.SurchargePercentDEfined;
  ShowControlhint(btnApplySurcharge, 'Please Choose Transaction Records in "Extra Details"' + NL+
                                     'Surcharge will be applied to SALES records only - not to ' + Quotedstr(CUSTOMER_PREPAYMENT)+','+Quotedstr(JOURNAL_ENTRY)+' and ' + Quotedstr(RefundType)+'.'+NL );
end;

procedure TAccountsReceiveListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('Name') + ' ASC CIS ; ' + QuotedStr('ClientID') + ' ASC CIS ; ' +
    QuotedStr('Details') + ' ASC CIS ; ' + QuotedStr('DueDate') + ' ASC CIS';
  BaseIndexFieldNames := QuotedStr('ClientID') + ' ASC CIS ; ' + QuotedStr('Details') + ' ASC CIS';
end;
procedure TAccountsReceiveListGUI.btnApplySurchargeClick(Sender: TObject);
begin
  inherited;
  if grdmain.SelectedList.Count = 0 then
    if MessageDlg('You haven''t Selected the Sales to apply the surcharges. Do you want to Select all?', mtconfirmation , [mbyes,mbNo], 0) = mrno then exit
    else begin
        grdMain.selectAll;
        DoAfterallSelected;
    end;


  UpdatedIds := TStringList.Create;
  try
    InvObj.Connection.BeginTransaction;
    try
      try
        IterateProcno:= 1;
        IterateSelectedRecords;
        ShowSurchargeUpdateResult;

        grdmain.UnselectAll;
        fInv.Connection.CommitTransaction;
        if UpdatedIds.Count <> 0 then refreshAll;
      Except
        on E:EXception do begin
          MessageDlgXP_Vista('Update Failed.'+NL+NL+
                              E.Message, mtWarning, [mbOK], 0);
          fInv.Connection.RollbackTransaction;
          Exit;
        end;
      end;
    finally
      FreeandNil(finv);
    end;
  finally
    Freeandnil(UpdatedIds);
  end;
end;
Procedure TAccountsReceiveListGUI.ShowSurchargeUpdateResult;
var
  ds:TERPQuery;
  ssql:String;
begin
  if UpdatedIds.Count>0 then begin
    With Scriptmain do begin
      SQL.clear;
      SQL.add('Drop table if Exists '+ TblUpdateSurchargestatus+';');
      SQL.add('CREATE TABLE '+ TblUpdateSurchargestatus+' ( ID      INT NOT NULL AUTO_INCREMENT, 	'+
                                                          ' SaleId  INT NOT NULL DEFAULT 0, 		'+
                                                          ' Updated ENUM("T","F") NOT NULL DEFAULT "F", 		'+
                                                          '	Msg     VARCHAR(255)  NULL     DEFAULT NULL,'+
                                                          ' PRIMARY KEY (ID) ) 	'+
                                                          ' COLLATE="utf8_general_ci"  ENGINE=MyISAM ;');
      SQL.add(UpdatedIds.Text);
      Execute;
    end;
    ds:= TempMyQuery;
    try
      ds.SQL.text := 'Select Id, saleID, if(Updated="T" ,"Applied" , "NOT Applied") Updated, MSG from ' + TblUpdateSurchargestatus;
      ds.Open;
      if ds.RecordCount >0 then begin
              InitMsgParams;
              PopupMsgParams.Msgcaption := 'Overdue Surcharge Update Status';
              PopupMsgParams.Msgds := ds;
              PopupMsgParams.MsgHeight := 350;
              PopupMsgParams.Custombuttons :='"Ok","Print"';
              PopupMsgParams.fieldnames := 'SaleId,Updated,MSg';
              PopupMsgParams.displayLabels:= 'ID #,Surcharge,Description';
              PopupMsgParams.DisplayWidths :='80,80,340';
              PopupMsgParams.Msg1:= 'Overdue Surcharge Update Status of Selected Sales';
              PopupMsgParams.Msg2 := 'Please run "Update Batch" to refresh the updated surcharge in the reports';
              PopupMsgParams.MsgColor := Self.Color;
              if TfmMessageWithList.MsgDlg = 101 then begin
                ssql := companyInfoSQL+'~|||~{Details}Select Id, saleID, if(Updated="T" ,"Applied" , "NOT Applied") Updated, MSG   from  ' + TblUpdateSurchargestatus;
                ReportSQLSupplied:= TRue;
                PrintTemplateReport('Surcharge Applied Sales List' , ssql, False , 1);
              end;
      end;
    finally
      ds.closenFree;
    end;

  end;
end;
procedure TAccountsReceiveListGUI.btnBulkPayClick(Sender: TObject);
begin
  OpenERPForm('TfrmBulkReceiveCustomersGUI' , 0);
  closewait;
end;

procedure TAccountsReceiveListGUI.chkGroupJobsWithCustomerClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TAccountsReceiveListGUI.chkAgingClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
  if chkAging.Focused and chkAging.Checked then
    DelayMessageDlg('All aging on this report is now ignored, columns will adjust based on the number of days since creation.',mtInformation,[mbOk],0);

end;

procedure TAccountsReceiveListGUI.ARMemoDialogUserButton2Click(
  Dialog: TwwMemoDlg; Memo: TMemo);
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
        Qry.Connection := GetSharedMyDacConnection;
        Qry.SQL.Text := 'SELECT * FROM tblToDo Limit 0';
        Qry.Open;
        Qry.Insert;
        Qry.FieldByName('CreatedDate').AsDateTime := Now;
        Qry.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
        Qry.FieldByName('Description').AsString := ARMemoDialog.Form.Memo.Text;
        Qry.FieldByName('ToDoByDate').AsDateTime := SelectDate.Calendar.Date;
        Qry.FieldByName('AppearDays').AsInteger := AppEnv.Employee.ToDoAppearDays;
        Qry.FieldByName('ClientID').AsInteger :=  qryMainClientID.asInteger;
        Qry.FieldByName('CreatedByEmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
        Qry.Post;

        if ARMemoDialog.Form.OKBtn.Enabled then
          ARMemoDialog.Form.OKBtn.Click;
      end;
    end;
  finally
    FreeAndNil(qry);
    FreeAndNil(SelectDate);
  end;
end;

procedure TAccountsReceiveListGUI.HandleInitDialog(Dialog: TwwMemoDlg);
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
procedure TAccountsReceiveListGUI.ApplyOverdueSurcharge(var abort:Boolean);
var
  SurchargeAmount:Double;
  SeqNo,SortId:Integer;
  SurchargeAmountDesc:String;
  Procedure SurchargeApplied(Status:Boolean;ID:Integer;Msg:STring);
  begin
    UpdatedIds.add('Insert ignore into '+ TblUpdateSurchargestatus+' Set Updated = '+quotedstr(BooleanToStr(Status))+','+
                                                        'SaleID = ' +inttostr(ID)+','+
                                                        'Msg = ' +Quotedstr(MSG)+';');
  end;
begin
  if Qrymaindetails.asinteger <> 2 then exit;
  if  (qryMain.fieldbyname('Type').AsString = CUSTOMER_PREPAYMENT) or (qryMain.fieldbyname('Type').AsString = JOURNAL_ENTRY) or (qryMain.fieldbyname('Type').AsString = RefundType) then Exit;
  if (qryMainDSDesigner130Days.AsFloat =0) and (qryMainDSDesigner3060Days.AsFloat =0) and (qryMainDSDesigner6090Days.AsFloat =0) and (qryMainDSDesigner90Days.AsFloat =0)  then exit;

           if (qryMainDSDesigner130Days.AsFloat  <> 0) and (Appenv.CompanyPrefs.SurchargePercent1<>0) then begin SurchargeAmount:= Appenv.CompanyPrefs.SurchargePercent1; SurchargeAmountDesc:= '1 - 30 days Overdue';
  end else if (qryMainDSDesigner3060Days.AsFloat <> 0) and (Appenv.CompanyPrefs.SurchargePercent2<>0) then begin SurchargeAmount:= Appenv.CompanyPrefs.SurchargePercent2; SurchargeAmountDesc:= '30 - 60 days Overdue';
  end else if (qryMainDSDesigner6090Days.AsFloat <> 0) and (Appenv.CompanyPrefs.SurchargePercent3<>0) then begin SurchargeAmount:= Appenv.CompanyPrefs.SurchargePercent3; SurchargeAmountDesc:= '60 - 90 days Overdue';
  end else if (qryMainDSDesigner90Days.AsFloat   <> 0) and (Appenv.CompanyPrefs.SurchargePercent4<>0) then begin SurchargeAmount:= Appenv.CompanyPrefs.SurchargePercent4; SurchargeAmountDesc:= '> 90 days Overdue';
  end else exit;
  SurchargeAmountDesc := SurchargeAmountDesc + '-' +floattostrF(SurchargeAmount,ffGeneral, 15,2)+'%';
  with InvObj do begin
    Load(QrymainsaleId.AsInteger);
    if count =1 then begin
      if Lock then begin
        connection.BeginNestedTransaction;
        try
            if Lines.Dataset.Locate('ProductName',PART_OVERDUE_SURCH,[loCaseInsensitive]) then begin
              if TotalPaid <> 0 then begin
                SurchargeApplied(False, ID, Lines.ProductDescription + ' - Already Appliled and invoice is partially Paid' );
                Exit;
              end;
              SurchargeAmount := RoundCurrency((SurchargeAmount/100) * (TotalAmountInc - Lines.TotalLineAmountInc));
              if Lines.LinePriceInc <> SurchargeAmount then begin
                Lines.LinePriceInc := SurchargeAmount;
                Lines.ProductDescription := SurchargeAmountDesc;
                Lines.PostDb;
                if not Save then begin
                  SurchargeApplied(False, ID, LastErrorMsgFromREsultStatus );
                  connection.RollbackNestedTransaction;
                  exit;
                end;
              end;
            end else begin
              SurchargeAmount := RoundCurrency((SurchargeAmount/100) * TotalBalance);
              lines.Last;
              SeqNo := lines.SeqNo;
              SortId := lines.SortID;
              lines.New;
              lines.ProductName    := PART_OVERDUE_SURCH;
              lines.UOMMultiplier  := 1;
              lines.UOMQtySold     := 1;
              lines.LinePriceInc   := SurchargeAmount;
              lines.UOMQtyShipped  := 1;
              lines.SeqNo:= SeqNo+1;
              lines.SortID:= SortID+10;
              Lines.ProductDescription := SurchargeAmountDesc;
              Lines.PostDb;
              if not Save then begin
                  SurchargeApplied(False, ID, LastErrorMsgFromREsultStatus);
                  connection.RollbackNestedTransaction;
                  exit;
              end;
            end;
            SurchargeApplied(True, ID, SurchargeAmountDesc);
            connection.CommitNestedTransaction;
        Except
          on E:Exception do begin
            connection.RollbackNestedTransaction;
            SurchargeApplied(False, ID, E.Message);
          end;
        end;
      end else begin
        SurchargeApplied(False, ID, replacestr(UserLock.lockMessage , #13#10, '.'));
      end;
    end;
  end;

end;

function TAccountsReceiveListGUI.InvObj: TInvoice;
begin
  if fInv = nil then begin
    fInv := TInvoice.CreateWithNewConn(Self);
    fInv.silentmode := True;
  end;
  Result := fInv;
end;

procedure TAccountsReceiveListGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if IterateProcNo =1 then begin
    ApplyOverdueSurcharge(abort);
  end else if IterateProcNo =2 then begin
    if ( Qrymaindetails.asinteger = 2 ) and
       ((qryMain.fieldbyname('Type').AsString <> CUSTOMER_PREPAYMENT) and (qryMain.fieldbyname('Type').AsString <> JOURNAL_ENTRY) and (qryMain.fieldbyname('Type').AsString <> RefundType) ) and
       ((qryMainDSDesigner130Days.AsFloat <>0) or (qryMainDSDesigner3060Days.AsFloat <>0) or (qryMainDSDesigner6090Days.AsFloat <>0) or (qryMainDSDesigner90Days.AsFloat <>0)) then
        grdmain.SelectRecord;
  end else if  (IterateProcNo=ItearteProcno4ValidateSelection) then begin
    if not AllowSelection then Grdmain.UnselectRecord;
  end;
end;

procedure TAccountsReceiveListGUI.FormDestroy(Sender: TObject);
begin
  ARReport.Free;
  DeleteTable(TblUpdateSurchargestatus);
  inherited;
end;

procedure TAccountsReceiveListGUI.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if not fbFormOpenedOk then exit;
  if Qrymain.active =false then Refreshall;
end;

procedure TAccountsReceiveListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    InitGridfields;
  finally
    EnableForm;
  end;
end;

procedure TAccountsReceiveListGUI.btnEmailClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
begin
  OptsForm := TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.Add('Print', 'Print The List', cmdPrintClick, true, true, true);
    OptsForm.ActionList.Add('Email', 'Email Selected Invoices', actEmail, true, true, true);
    OptsForm.ActionList.Add('SMS', 'Send the List Via SMS', btnSMSClick, true, true,true);
    OptsForm.ActionList.Add('Export', 'Export the List', cmdExportClick, true, true, true);
    OptsForm.ShowModal;
  finally
    OptsForm.Free;
  end;
end;

procedure TAccountsReceiveListGUI.btnhelpClick(Sender: TObject);
begin
  inherited;
  if fsGridHint = '' then InitGridfields;
  if devmode then
    MessageDlgXP_Vista(fsGridHint, mtInformation, [mbOK], 0,nil,'','',false,nil,'' , '',800)
  else
    MessageDlgXP_Vista(fsGridHint, mtInformation, [mbOK], 0,nil,'','',false,nil,'' , '',600);
end;

procedure TAccountsReceiveListGUI.btnSMSClick(Sender: TObject);
var
  i: integer;
  qry: TERPQuery;
  mblNumber: string;
  ClientID: integer;
  SL: TStringList;
begin
  DisableForm;
  try
    // If we have no statements to print then out we go.
    if qryMain.RecordCount = 0 then Exit;
    if grdMain.SelectedList.Count = 0 then begin
      commonlib.MessageDlgXP_Vista('Please select the customer', mtWarning, [mbOK], 0) ;
      Exit;
    end;
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    SL := TStringList.Create;
    try
      qry.SQL.Add('select tblclients.Company, tblclients.Mobile, tblcontacts.ContactMOB from tblclients');
      qry.SQL.Add('left join tblcontacts on tblclients.ClientID = tblcontacts.ClientID and tblcontacts.IsPrimarycontact = "T"');
      qry.SQL.Add('where tblclients.clientid = :clientid');

      DoshowProgressbar(grdMain.SelectedList.Count , WAITMSG);
      try
        for i := 0 to grdMain.SelectedList.Count - 1 do begin
          qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
          ClientID := qryMain.FieldByName('ClientID').AsInteger;
          SL.Values['#Balance#'] := FloatToStrF(qryMainAmountDue.AsFloat, ffCurrency, 15, 2);
          SL.Values['#Company#'] := qryMainName.AsString;
          mblNumber := '';
          qry.ParamByName('clientid').AsInteger := ClientId;
          qry.Open;
          try
            if qry.FieldByName('ContactMob').AsString <> '' then
              mblNumber := qry.FieldByName('ContactMob').AsString
            else if qry.FieldByName('Mobile').AsString <> '' then
              mblNumber := qry.FieldByName('Mobile').AsString
            else
              mblNumber := '[Mobile for ' + qry.FieldByName('Company').AsString + ']';
          finally
            qry.Close;
          end;
          TCorrespondenceGui.SMSCustomer(mblNumber,TMailUtils.SubstituteText(AppEnv.CompanyPrefs.ARSMSText, SL),ClientID);
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      DbSharedObj.ReleaseObj(qry);
      SL.Free;
    end;
  finally
    EnableForm;
  end;
end;

procedure TAccountsReceiveListGUI.cmdExportClick(Sender: TObject);
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

procedure TAccountsReceiveListGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TAccountsReceiveListGUI.cmdPrintClick(Sender: TObject);
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

procedure TAccountsReceiveListGUI.SendBulkEmail;
var
  List: TStringList;
  Corres: TCorrespondenceGui;
  lSilent, lSecret : boolean;
  idx : integer;
  j : integer;
  sSQL : string;
  tempFileName : string;
  No : integer;
begin
  List := TStringList.Create;
  List.Duplicates := dupIgnore;  // Only different e-mails
  List.CaseSensitive := false;
  List.Sorted := true;
  try

    for j := 0 to grdmain.SelectedList.Count - 1 do
    begin
      qryMain.GotoBookmark(grdMain.SelectedList.Items[j]);
      if qrymain.FieldByName('Email').AsString <> ''  then
        List.Add(qrymain.FieldByName('Email').AsString);
    end;

    if List.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('None of the Customers in the selected list have Email addresses.', mtInformation, [mbOk], 0);
      exit;
    end;
    
    if not EmailSilentSecret(List.Count, false, lSilent, lSecret) then
      exit;

    DoShowProgressBar(grdMain.SelectedList.Count + List.Count, 'EMailing..', '', false);
    try
    for idx := 0 to List.Count - 1 do
    begin
      Corres := TCorrespondenceGui.Create;
      try
        Corres.RecipientList := List[idx];
        for j := 0 to grdMain.SelectedList.Count - 1 do
        begin
          qryMain.GotoBookmark(grdMain.SelectedList.Items[j]);
          if not sametext(List[idx], qryMain.FieldByName('Email').AsString) then
            Continue;

          if qrymain.FieldByName('InvoiceNumber').asInteger > 0 then
          begin
            if SameText(qryMain.FieldByName('Type').AsString, 'invoice') then
              TempFileName := 'Invoice' + qryMain.FieldByName('InvoiceNumber').AsString
            else
              TempFileName := 'Refund' + qryMain.FieldByName('InvoiceNumber').AsString;
            No := qrymaininvoicenumber.asInteger;
            sSQL := Format('   AND (P.HideOnPrint = "F"  and   (d3.IsRelatedProduct = "F" or ( d3.IsRelatedProduct = "T" and ifnull(d5.HideRelated,"F")  <> "T"))) AND d2.SaleID = %d order by d3.sortID~|||~ where TTC.SaleID = %d group by TTCL.`SubTaxCode`~|||~ and ' +
                'Trans.SaleID = %d~|||~ Where S.SaleId = %d~|||~ Where S.SaleId =  %d~|||~ where salesid =   %d~|||~where TC.Transtype = "Invoice" and TC.TransId = %d ORDER BY seqno',
                [no, no, no, no, no, no, no]);
            DoStepProgressbar('Preparing Invoice ' + qryMain.FieldByName('InvoiceNumber').AsString);
            SaveTemplateReport('invoice', sSQL, true, 'PDF', tempfilename);
            if not FileExists(Commonlib.TempDir  + TempFileName + '.pdf') then
            begin
              MessageDlgXP_Vista('Cannot Find Attachment for InvoiceNo ' + qryMain.FieldByName('InvoiceNumber').AsString + #13#10'Emailing Failed', mtWarning, [mbOk], 0);
              exit;
            end;
            Corres.AttachmentList.Add(Commonlib.TempDir + TempFileName+ '.pdf');
          end;
        end;  // for j
        Corres.Subject := 'Accounts Receivable';
        Corres.MessageText := 'Invoices';
        Corres.DeleteAttachments := true;
        DoStepProgressBar('Sending to ' + List[idx]);
        Corres.Execute(lSilent, lSecret);
      finally
        Corres.Free;
      end;
    end; // for idx
    finally
      DoHideProgressBar;
    end;

  finally
    List.Free;
  end;

end;

procedure TAccountsReceiveListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('SaleID');
  RemoveFieldfromGrid('clientID');
  RemoveFieldfromGrid('Details');
  SetUpcustomFields('Cust');
end;

procedure TAccountsReceiveListGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;
end;

initialization
  RegisterClassOnce(TAccountsReceiveListGUI);
end.
