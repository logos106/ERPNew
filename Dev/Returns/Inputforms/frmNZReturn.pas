unit frmNZReturn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ReturnsBase, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList,
  Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, BusObjConst,
  BusObjBase, BusobjReturns, wwdbedit, Wwdotdot, Wwdbcomb, StdCtrls, Mask,
  DBCtrls, wwclearbuttongroup, wwradiogroup, DNMSpeedButton, ComCtrls,
  wwcheckbox, BasObj, TransAccountDetailsForm, CashBasisDetails , ReturnObj,
  wwdbdatetimepicker, DNMPanel,  ProgressDialog;

type
  TfmNZReturn = class(TReturnsBaseGUI)
    QryReturnsGlobalRef: TWideStringField;
    QryReturnsID: TIntegerField;
    QryReturnsTab4_Type: TWideStringField;
    QryReturnsTab4_Month: TWideStringField;
    QryReturnsTab4_Year: TIntegerField;
    QryReturnsBasSheetDesc: TWideStringField;
    QryReturnsNZG5: TFloatField;
    QryReturnsNZG5Selected: TWideStringField;
    QryReturnsNZG6: TFloatField;
    QryReturnsNZG6Selected: TWideStringField;
    QryReturnsNZG7: TFloatField;
    QryReturnsNZG8: TFloatField;
    QryReturnsNZG9: TFloatField;
    QryReturnsNZG10: TFloatField;
    QryReturnsNZG11: TFloatField;
    QryReturnsNZG11Selected: TWideStringField;
    QryReturnsNZG12: TFloatField;
    QryReturnsNZG13: TFloatField;
    QryReturnsNZG14: TFloatField;
    QryReturnsNZG15: TFloatField;
    QryReturnsNZG16: TFloatField;
    QryReturnsC1: TFloatField;
    QryReturnsC2: TFloatField;
    QryReturnsC3: TFloatField;
    QryReturnsC4: TFloatField;
    QryReturnsC5: TFloatField;
    QryReturnsC6: TFloatField;
    QryReturnsC7: TFloatField;
    QryReturnsC8: TFloatField;
    QryReturnsC9: TFloatField;
    QryReturnsC10: TFloatField;
    QryReturnsC11: TFloatField;
    QryReturnsC12: TFloatField;
    QryReturnsC13: TFloatField;
    QryReturnsActive: TWideStringField;
    QryReturnsAccMethod: TWideStringField;
    QryReturnsAllClass: TWideStringField;
    QryReturnsClassID: TIntegerField;
    QryReturnsEditedFlag: TWideStringField;
    QryReturnsmsTimeStamp: TDateTimeField;
    QryReturnLinesID: TIntegerField;
    QryReturnLinesGlobalref: TWideStringField;
    QryReturnLinesNZID: TIntegerField;
    QryReturnLinesTransGlobalref: TWideStringField;
    QryReturnLinesTranstype: TWideStringField;
    QryReturnLinesTransSeqno: TIntegerField;
    QryReturnLinesNZCode: TWideStringField;
    QryReturnLinesAmount: TFloatField;
    QryReturnLinesmstimeStamp: TDateTimeField;
    tabNZReturnStatement: TTabSheet;
    Label179: TLabel;
    Label180: TLabel;
    Label181: TLabel;
    Label182: TLabel;
    Label183: TLabel;
    Label184: TLabel;
    Label185: TLabel;
    Label186: TLabel;
    Label187: TLabel;
    Label190: TLabel;
    Label191: TLabel;
    Label192: TLabel;
    Label194: TLabel;
    Label195: TLabel;
    Label196: TLabel;
    Label197: TLabel;
    Label198: TLabel;
    Label199: TLabel;
    Label200: TLabel;
    Label201: TLabel;
    Label203: TLabel;
    Label204: TLabel;
    Label206: TLabel;
    Label207: TLabel;
    Label208: TLabel;
    Label209: TLabel;
    Label210: TLabel;
    Label211: TLabel;
    Label193: TLabel;
    Label212: TLabel;
    Label213: TLabel;
    Label214: TLabel;
    Label215: TLabel;
    Label216: TLabel;
    MonthLabel: TLabel;
    Label219: TLabel;
    Label220: TLabel;
    Label221: TLabel;
    Label217: TLabel;
    Label188: TLabel;
    btnGoCalculationSheet: TDNMSpeedButton;
    btnGoCalculationSheet2: TDNMSpeedButton;
    rgGSTPaymentStatus: TRadioGroup;
    Period4: TwwRadioGroup;
    btn5: TDNMSpeedButton;
    btn6: TDNMSpeedButton;
    Button22: TDNMSpeedButton;
    NZG5: TDBEdit;
    NZG6: TDBEdit;
    NZG7: TDBEdit;
    NZG8: TDBEdit;
    NZG9: TDBEdit;
    NZG10: TDBEdit;
    NZG12: TDBEdit;
    NZG11: TDBEdit;
    NZG13: TDBEdit;
    NZG14: TDBEdit;
    NZG15: TDBEdit;
    NZG16: TDBEdit;
    Tab4_Month: TwwDBComboBox;
    Tab4_Year: TwwDBComboBox;
    tabNZReturnCalcSheet: TTabSheet;
    lblGSTAdjustmentTitle: TLabel;
    Label120: TLabel;
    Label74: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label155: TLabel;
    Label156: TLabel;
    Label157: TLabel;
    Label158: TLabel;
    Label159: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    Label163: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    Label166: TLabel;
    Label167: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label173: TLabel;
    Label174: TLabel;
    Label175: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Label178: TLabel;
    C1: TDBEdit;
    C2: TDBEdit;
    C3: TDBEdit;
    C4: TDBEdit;
    C5: TDBEdit;
    C6: TDBEdit;
    C7: TDBEdit;
    C8: TDBEdit;
    C13: TDBEdit;
    C9: TDBEdit;
    C10: TDBEdit;
    C11: TDBEdit;
    C12: TDBEdit;
    tmrNZBasMonitor: TTimer;
    Bevel1: TBevel;
    Label1: TLabel;
    dtTab_4PeriodEnding: TwwDBDateTimePicker;
    pnlTab4_LastPeriod: TDNMPanel;
    Label2: TLabel;
    Label3: TLabel;
    dtTab4_from: TwwDBDateTimePicker;
    dtTab4_To: TwwDBDateTimePicker;
    QryReturnsDone: TWideStringField;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    QryReturnLinesTransDate: TDateField;
    QryReturnsSummarisedTransDate: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PeriodChange(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure tmrNZBasMonitorTimer(Sender: TObject);
    procedure btnGoCalculationSheetClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TaxDblClick(Sender: TObject);Override;
    procedure AccDblClick(Sender: TObject);Override;
    procedure QryReturnsAccMethodChange(Sender: TField);


  private
   objBas  :TBasObj;


  Protected
    procedure DoTabchange(cThisKey: char );Override;
    Procedure InitBas4Tax(BAS: TBASObj; const Tab: integer);Override;
    Procedure InitBas4Account(BAS: TBASObj;const Tab: integer);Override;
    procedure Silent_OpenAccountSelect(const Box: TDBEdit; const Tab: integer);Override;
    procedure Silent_OpenTaxSelect(const Box: TDBEdit;const Tab: integer);Override;
    procedure RefreshAll;Override;
    procedure initTransAccountDetails(form :TTransAccountDetailsGUI;const Box: TDBEdit); override;
    procedure initCashBasisDetails(form: TCashBasisDetailsGUI; sender:TObject);override;
    procedure InitBas(fObjReturn: TReturnObj);Override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType,      Value: string);Override;
    procedure PeriodForAutoPopulatehistory;Override;
    function GetReportTypeID: integer; Override;
    function HighestReturnDate: TDatetime;Override;
  public
    NZReturn :TNZReturn;
    procedure PrepareCashBasis;Override;
  end;


implementation

uses CommonLib, CommonDbLib, AppEnvironment, FastFuncs, dateutils,
  BasSelectionPopup, FormFactory, tcConst, CommonFormLib, CashBasis;

{$R *.dfm}

procedure TfmNZReturn.btn5Click(Sender: TObject);begin  OpenTaxSelect(NZG5,4);  fbChangesMade := true;end;
procedure TfmNZReturn.btn6Click(Sender: TObject);begin  OpenTaxSelect(NZG6,4);  fbChangesMade := true;end;
procedure TfmNZReturn.Button22Click(Sender: TObject);begin  OpenTaxSelect(NZG11,4);  fbChangesMade := true;end;

procedure TfmNZReturn.btnGoCalculationSheetClick(Sender: TObject);
begin
  inherited;
  tabmain.ActivePage := tabNZReturnCalcSheet;
  fbChangesMade := true;
end;

procedure TfmNZReturn.btnPrintClick(Sender: TObject);
begin
  ReportToPrint := 'GST Report';
  inherited;
end;



procedure TfmNZReturn.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
var
  dtFrom , dtTo:TDatetime;
  stype:String;
begin
  inherited;
  if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_IDChange) then begin
    NZReturn.LastReturn(dtFrom, dtTo , stype, tRPNZ);
    pnlTab4_LastPeriod.visible := dtFrom <> 0;
    dtTab4_from.Date := dtFrom;
    dtTab4_to.Date := dtTo;
  end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_DateRangeChange) then begin
    if fbFormshown then begin
      OnchangePeriod(MonthLabel ,Tab4_Month , Period4  );
      if NZReturn.Tab4_To <> 0 then dtTab_4PeriodEnding.Date := NZReturn.Tab4_To;
      if (NZReturn.Description = '') and (NZReturn.Tab4_Month <> '') and (NZReturn.Tab4_year<> 0) then NZReturn.Description := NZReturn.Tab4_type +' From ' + NZReturn.Tab4_Month +' ' + inttostr(NZReturn.Tab4_year);
    end;
  end;
end;

procedure TfmNZReturn.DoTabchange(cThisKey: char);
begin
  inherited;
      if cThisKey = 'N' then begin
        TabMain.ActivePageIndex := 3;
        Exit;
      end;

      if (cThisKey = 'Z') or (cThisKey = '9') then begin
        TabMain.ActivePageIndex := 4;
        Exit;
      end;
end;



procedure TfmNZReturn.FormCreate(Sender: TObject);
begin
  objBas := TBASObj.Create;
  objReturn:=objBas;
  inherited;
  NZReturn := TNZReturn.Create(Self);
  NZReturn.Connection := TMydacdataconnection.Create(NZReturn);
  NZReturn.Connection.connection := Self.Myconnection;
  NZReturn.BusObjEvent :=DoBusinessObjectEvent;
  Return:=NZReturn;
  Objbas.ReturnsObj := Return;
end;

procedure TfmNZReturn.FormDestroy(Sender: TObject);
begin
  FreeandNil(objBas);
  objReturn:= nil;
  FreeandNil(NZReturn);
  Return:= nil;
  inherited;
end;

procedure TfmNZReturn.FormShow(Sender: TObject);
begin
  inherited;
  Tabmain.ActivePage := tabNZReturnStatement;
    if (NZReturn.AccMethod = 'Cash') then begin
      PrepareCashBasis;
      Label188.caption :=  'GST Accounting Method Cash';
    end else begin
      Label188.caption :=  'GST Accounting Method Non-Cash (Accruals)';
    end;
  if (KeyId <> 0) and (Accesslevel<5) then
    if Check4closingdate(NZREturn.tab4_from , NZREturn.Tab4_To) then
              Self.Caption := FormName +' Return - Date Range Selected ' +
                ' (' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,NZREturn.tab4_from  )) +
                ' to ' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,NZREturn.tab4_to  )) +') is Prior to Closing Date';
  AutoPopulateForHistory;
  CheckforSummary;

end;

function TfmNZReturn.GetReportTypeID: integer;
begin
  REsult := 99;
end;

function TfmNZReturn.HighestReturnDate: TDatetime;
begin
  result:= 0;
  if result < dtTab_4PeriodEnding.DateTime then Result := dtTab_4PeriodEnding.DateTime;
end;

procedure TfmNZReturn.PeriodForAutoPopulatehistory;
var
dtFrom , dtTo:TDatetime;
  stype:String;
begin
  inherited;
  NZReturn.LastReturn(dtFrom, dtTo , stype, tRPNZ);
  NZReturn.Tab4_type  := stype;
  NZReturn.Tab4_month := NZReturn.MonthNumberToName(monthof(dtFrom));
  NZReturn.Tab4_year  := YearOf(dtFrom);
  NZReturn.Description := 'Summary ';
end;

procedure TfmNZReturn.PrepareCashBasis;
begin
  If CashBasis.IsCashBasisTransSummarised(Self,FromDate(Tab4_Month.Text, Tab4_Year.Text),
    ToDate(Period4.Value, Tab4_Month.Text, Tab4_Year.Text)) then Begin
    fbNoCashBasis := True;
    Exit;
  end;
  CashBasis.PrepareCashBasisDetails(0,0, 'BAS');
  //CashBasis.PrepareCashBasisDetails(0,0, 'BAS', true);
end;

procedure TfmNZReturn.QryReturnsAccMethodChange(Sender: TField);
begin
  inherited;
    if (NZReturn.AccMethod = 'Cash') then begin
      PrepareCashBasis;
      Label188.caption :=  'GST Accounting Method Cash';
    end else begin
      Label188.caption :=  'GST Accounting Method Non-Cash (Accruals)';
    end;
end;

procedure TfmNZReturn.InitBas(fObjReturn: TReturnObj);
begin
  inherited;
  fObjReturn.AccountingMethod := NZReturn.AccMethod;
  fObjReturn.All := NZReturn.AllClass;
  fObjReturn.Department := GetClassName(NZReturn.ClassID);
end;

procedure TfmNZReturn.InitBas4Account(BAS: TBASObj;const Tab: integer);
begin
  inherited;
  BAS.ObjType := ftAcc;
  initBas(bas);
end;

procedure TfmNZReturn.InitBas4Tax(BAS: TBASObj; const Tab: integer);
begin
  inherited;
  BAS.FromDate := NZReturn.Tab4_From;//Self.FromDate(Tab4_Month.Text, Tab4_Year.Text);
  BAS.ToDate := NZReturn.Tab4_To;//Self.FromDate(Period4.Value, Tab4_Month.Text, Tab4_Year.Text);
  initBas(bas);
end;

procedure TfmNZReturn.initCashBasisDetails(form: TCashBasisDetailsGUI;
  sender: TObject);
begin
  inherited;
  Form.ToDate := NZReturn.Tab4_To;//Self.FromDate(Period4.Value, Tab4_Month.Text, Tab4_Year.Text);
  Form.FromDate := NZReturn.Tab4_From;//Self.FromDate(Tab4_Month.Text, Tab4_Year.Text);
end;

procedure TfmNZReturn.initTransAccountDetails(form: TTransAccountDetailsGUI;const Box: TDBEdit);
begin
  inherited;
      With form do begin
        if (Box.name = 'NZG5') or (Box.name = 'NZG6') or (Box.name = 'NZG7') or (Box.name = 'NZG8') or
              (Box.name = 'NZG9') or (Box.name = 'NZG10') or (Box.name = 'NZG11') or (Box.name = 'NZG12') or
               (Box.name = 'NZG13') or (Box.name = 'NZG14') or (Box.name = 'NZG15') or
               (Box.name = 'C1') or (Box.name = 'C2') or (Box.name = 'C3') or
                (Box.name = 'C4') or (Box.name = 'C5') or (Box.name = 'C6') or
                 (Box.name = 'C7') or (Box.name = 'C8') or (Box.name = 'C9') or
                  (Box.name = 'C10') or (Box.name = 'C11') or (Box.name = 'C12') or
                   (Box.name = 'C13') then begin
            FromDate := NZReturn.Tab4_From;//Self.FromDate(Tab4_Month.Text, Tab4_Year.Text);
            ToDate := NZReturn.Tab4_To;//Self.FromDate(Period4.Value, Tab4_Month.Text, Tab4_Year.Text);
        end;
      end;
end;

procedure TfmNZReturn.PeriodChange(Sender: TObject);
begin
  if not fbFormshown then exit;
  if NZReturn = nil then exit;
  NZReturn.Tab4_Type :=Period4.Value;
  if  NZReturn.Tab4_Month <> '' then if Tab4_Month.Items.Indexof(NZReturn.Tab4_Month) <0 then NZReturn.NextReturn(TRPNZ , False);
end;

procedure TfmNZReturn.RefreshAll;
begin
  showProgressbar(WAITMSG , 3);
  try
    Silent_OpenTaxSelect(NZG5,4);    stepProgressbar;
    Silent_OpenTaxSelect(NZG6,4);    stepProgressbar;
    Silent_OpenTaxSelect(NZG11,4);    stepProgressbar;
    Application.ProcessMessages;
    inherited;
  finally
    HideProgressbar;
  end;
end;

procedure TfmNZReturn.Silent_OpenAccountSelect(const Box: TDBEdit;const Tab: integer);
begin
  inherited;
  initbas(objBas);
  objBas.initialize;
end;

procedure TfmNZReturn.Silent_OpenTaxSelect(const Box: TDBEdit;const Tab: integer);
begin
  inherited;
    objBas.FromDate := NZReturn.Tab4_From;//Self.FromDate(Tab4_Month.Text, Tab4_Year.Text);
    objBas.ToDate := NZReturn.Tab4_To;//Self.FromDate(Period4.Value, Tab4_Month.Text, Tab4_Year.Text);
    objBas.Calc; //
end;

procedure TfmNZReturn.TaxDblClick(Sender: TObject);
begin
  //inherited;
  if  not(Sender is TDBEdit) then exit;
  //if accesslevel = 5 then exit;
  SelectedCode :=TDBEdit(Sender).Name;
  if accesslevel <> 5 then
      if not(Savencommit) then exit;
  OpenErpListform('TNZTransReturnListGUI' , beforeOpenDetails);
end;
procedure TfmNZReturn.AccDblClick(Sender: TObject);
begin
  //inherited;
  (*if  not(Sender is TDBEdit) then exit;
  if accesslevel = 5 then exit;
  SelectedCode :=TDBEdit(Sender).Name;
  if not(Savencommit) then exit;
  OpenErpListform('TNZTransReturnListGUI' , beforeOpenDetails);*)
  if Devmode then
    MessageDlgXP_Vista('This should be TaxDblclick not AccdblClick', mtWarning, [mbOK], 0);
end;

procedure TfmNZReturn.tmrNZBasMonitorTimer(Sender: TObject);
var
  curArea9, curArea13: currency;
begin
  inherited;
      if accesslevel = 5 then exit;

      curArea9 := NZReturn.C1 + NZReturn.C2 + NZReturn.C3 + NZReturn.C4 + NZReturn.C5 + NZReturn.C6 + NZReturn.C7;

      NZReturn.C8 := curArea9;
      NZReturn.NZG9 := curArea9;

      curArea13 := NZReturn.C9 + NZReturn.C10 + NZReturn.C11 + NZReturn.C12;

      NZReturn.C13 := curArea13;
      NZReturn.NZG13 := curArea13;
      if not FormStillOpen('TBasSelectionGUI') then
        GetComponentByClassName('TBasSelectionGUI');
      TBasSelectionGUI(FindExistingComponent('TBasSelectionGUI')).BAS.RefreshCalcFields;

  Application.ProcessMessages;
end;


initialization
  RegisterClassOnce(TfmNZReturn);
  FormFact.RegisterMe(TfmNZReturn, 'TNZReturnlistGUI_*=ID');
  FormFact.RegisterMe(TfmNZReturn, 'TNZTransReturnListGUI_*=ID');

end.

