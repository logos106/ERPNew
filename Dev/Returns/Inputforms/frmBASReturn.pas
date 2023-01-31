unit frmBASReturn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ReturnsBase, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList,
  Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, BusObjConst,
  BusObjBase, BusobjReturns, wwdbedit, Wwdotdot, Wwdbcomb, StdCtrls,
  wwclearbuttongroup, wwradiogroup, Mask, DBCtrls, DNMSpeedButton, ComCtrls,
  wwcheckbox, BasObj, TransAccountDetailsForm, CashBasisDetails , ReturnObj,
  wwdbdatetimepicker, DNMPanel,  ProgressDialog;


type
  TfmBASReturn = class(TReturnsBaseGUI)
    QryReturnsGlobalRef: TWideStringField;
    QryReturnsID: TIntegerField;
    QryReturnsTab1_Type: TWideStringField;
    QryReturnsTab1_Month: TWideStringField;
    QryReturnsTab1_Year: TIntegerField;
    QryReturnsBasSheetDesc: TWideStringField;
    QryReturnsG1: TFloatField;
    QryReturnsG1Selected: TWideStringField;
    QryReturnsG2: TFloatField;
    QryReturnsG2Selected: TWideStringField;
    QryReturnsG3: TFloatField;
    QryReturnsG3Selected: TWideStringField;
    QryReturnsG4: TFloatField;
    QryReturnsG4Selected: TWideStringField;
    QryReturnsG5: TFloatField;
    QryReturnsG6: TFloatField;
    QryReturnsG7: TFloatField;
    QryReturnsG7Selected: TWideStringField;
    QryReturnsG8: TFloatField;
    QryReturnsG9: TFloatField;
    QryReturnsG10: TFloatField;
    QryReturnsG10Selected: TWideStringField;
    QryReturnsG11: TFloatField;
    QryReturnsG11Selected: TWideStringField;
    QryReturnsG12: TFloatField;
    QryReturnsG13: TFloatField;
    QryReturnsG13Selected: TWideStringField;
    QryReturnsG14: TFloatField;
    QryReturnsG14Selected: TWideStringField;
    QryReturnsG15: TFloatField;
    QryReturnsG15Selected: TWideStringField;
    QryReturnsG16: TFloatField;
    QryReturnsG17: TFloatField;
    QryReturnsG18: TFloatField;
    QryReturnsG18Selected: TWideStringField;
    QryReturnsG19: TFloatField;
    QryReturnsG20: TFloatField;
    QryReturnsTab2_Type: TWideStringField;
    QryReturnsTab2_Month: TWideStringField;
    QryReturnsTab2_Year: TIntegerField;
    QryReturnsW1: TFloatField;
    QryReturnsW1Selected: TWideStringField;
    QryReturnsW2: TFloatField;
    QryReturnsW2Selected: TWideStringField;
    QryReturnsW3: TFloatField;
    QryReturnsW3Selected: TWideStringField;
    QryReturnsW4: TFloatField;
    QryReturnsW4Selected: TWideStringField;
    QryReturnsT1: TFloatField;
    QryReturnsT1Selected: TWideStringField;
    QryReturnsT2: TFloatField;
    QryReturnsT3: TFloatField;
    QryReturnsT4: TWideStringField;
    QryReturnsF1: TFloatField;
    QryReturnsF2: TFloatField;
    QryReturnsF3: TFloatField;
    QryReturnsF4: TWideStringField;
    QryReturns_1A: TFloatField;
    QryReturns_1B: TFloatField;
    QryReturns_1C: TFloatField;
    QryReturns_1CSelected: TWideStringField;
    QryReturns_1D: TFloatField;
    QryReturns_1DSelected: TWideStringField;
    QryReturns_1E: TFloatField;
    QryReturns_1ESelected: TWideStringField;
    QryReturns_1F: TFloatField;
    QryReturns_1FSelected: TWideStringField;
    QryReturns_1G: TFloatField;
    QryReturns_1GSelected: TWideStringField;
    QryReturns_2A: TFloatField;
    QryReturns_2B: TFloatField;
    QryReturns_3: TFloatField;
    QryReturns_4: TFloatField;
    QryReturns_5A: TFloatField;
    QryReturns_5B: TFloatField;
    QryReturns_6A: TFloatField;
    QryReturns_6B: TFloatField;
    QryReturns_7: TFloatField;
    QryReturns_8A: TFloatField;
    QryReturns_8B: TFloatField;
    QryReturns_9: TFloatField;
    QryReturnsActive: TWideStringField;
    QryReturnsAccMethod: TWideStringField;
    QryReturnsAllClass: TWideStringField;
    QryReturnsClassID: TIntegerField;
    QryReturnsEditedFlag: TWideStringField;
    QryReturnsTab3_Type: TWideStringField;
    QryReturnsTab3_Month: TWideStringField;
    QryReturnsTab3_Year: TIntegerField;
    QryReturnsmsTimeStamp: TDateTimeField;
    QryReturnLinesID: TIntegerField;
    QryReturnLinesGlobalref: TWideStringField;
    QryReturnLinesBasID: TIntegerField;
    QryReturnLinesTransGlobalref: TWideStringField;
    QryReturnLinesTranstype: TWideStringField;
    QryReturnLinesBasCode: TWideStringField;
    QryReturnLinesAmount: TFloatField;
    QryReturnLinesmstimeStamp: TDateTimeField;
    tabSuppAndAcq: TTabSheet;
    Label72: TLabel;
    tabTaxandWithheld: TTabSheet;
    Label31: TLabel;
    Label101: TLabel;
    Page327: TTabSheet;
    Label123: TLabel;
    pnlTaxandWithheld: TDNMPanel;
    Label117: TLabel;
    W4: TDBEdit;
    Label32: TLabel;
    btn9: TDNMSpeedButton;
    Label110: TLabel;
    Label109: TLabel;
    btn10: TDNMSpeedButton;
    Label33: TLabel;
    W3: TDBEdit;
    W2: TDBEdit;
    btn7: TDNMSpeedButton;
    Label104: TLabel;
    Label103: TLabel;
    btn6: TDNMSpeedButton;
    W1: TDBEdit;
    Label30: TLabel;
    Bevel7: TBevel;
    Period2: TwwRadioGroup;
    MonthLabel2: TLabel;
    Tab2_Month: TwwDBComboBox;
    YearLabel2: TLabel;
    Tab2_Year: TwwDBComboBox;
    Label120: TLabel;
    dtTab_2PeriodEnding: TwwDBDateTimePicker;
    pnlTab2_LastPeriod: TDNMPanel;
    Label155: TLabel;
    Label156: TLabel;
    dtTab2_from: TwwDBDateTimePicker;
    dtTab2_To: TwwDBDateTimePicker;
    Label102: TLabel;
    Bevel2: TBevel;
    pnlInstallment: TDNMPanel;
    Label115: TLabel;
    pnlTab3_LastPeriod: TDNMPanel;
    Label158: TLabel;
    Label159: TLabel;
    dtTab3_from: TwwDBDateTimePicker;
    dtTab3_To: TwwDBDateTimePicker;
    Bevel8: TBevel;
    Period3: TwwRadioGroup;
    MonthLabel3: TLabel;
    Tab3_Month: TwwDBComboBox;
    YearLabel3: TLabel;
    Tab3_Year: TwwDBComboBox;
    Label157: TLabel;
    dtTab_3PeriodEnding: TwwDBDateTimePicker;
    Label105: TLabel;
    btn12: TDNMSpeedButton;
    Label106: TLabel;
    Label38: TLabel;
    Label34: TLabel;
    T1: TDBEdit;
    T2: TDBEdit;
    Label35: TLabel;
    Label118: TLabel;
    Label112: TLabel;
    Label111: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    T3: TDBEdit;
    T4: TwwDBComboBox;
    Label37: TLabel;
    Bevel3: TBevel;
    Label116: TLabel;
    DateLabel2: TLabel;
    Label107: TLabel;
    Label46: TLabel;
    Label36: TLabel;
    F1: TDBEdit;
    Label113: TLabel;
    Label44: TLabel;
    F3: TDBEdit;
    Label42: TLabel;
    Label108: TLabel;
    Label43: TLabel;
    Label41: TLabel;
    F2: TDBEdit;
    Label119: TLabel;
    Label114: TLabel;
    Label45: TLabel;
    F4: TwwDBComboBox;
    pnlGST: TDNMPanel;
    Label98: TLabel;
    Label97: TLabel;
    Label96: TLabel;
    Label25: TLabel;
    Label20: TLabel;
    G20: TDBEdit;
    G19: TDBEdit;
    Label18: TLabel;
    Label26: TLabel;
    Label95: TLabel;
    Label94: TLabel;
    btn18: TDNMSpeedButton;
    Label17: TLabel;
    G18: TDBEdit;
    G17: TDBEdit;
    Label16: TLabel;
    Label27: TLabel;
    Label93: TLabel;
    Label92: TLabel;
    Label28: TLabel;
    Label15: TLabel;
    G16: TDBEdit;
    G15: TDBEdit;
    Label14: TLabel;
    btn15: TDNMSpeedButton;
    Label91: TLabel;
    Label90: TLabel;
    btn14: TDNMSpeedButton;
    Label13: TLabel;
    G14: TDBEdit;
    G13: TDBEdit;
    Label12: TLabel;
    btn13: TDNMSpeedButton;
    Label89: TLabel;
    Label88: TLabel;
    Label29: TLabel;
    Label11: TLabel;
    G12: TDBEdit;
    G11: TDBEdit;
    Label10: TLabel;
    btn11: TDNMSpeedButton;
    Label87: TLabel;
    Label86: TLabel;
    btn20: TDNMSpeedButton;
    Label19: TLabel;
    G10: TDBEdit;
    Label99: TLabel;
    Label100: TLabel;
    G9: TDBEdit;
    Label9: TLabel;
    Label23: TLabel;
    Label85: TLabel;
    Label84: TLabel;
    Label24: TLabel;
    Label8: TLabel;
    G8: TDBEdit;
    G7: TDBEdit;
    Label7: TLabel;
    btn8: TDNMSpeedButton;
    Label83: TLabel;
    Label82: TLabel;
    Label22: TLabel;
    Label6: TLabel;
    G6: TDBEdit;
    G5: TDBEdit;
    Label5: TLabel;
    Label21: TLabel;
    Label81: TLabel;
    Label80: TLabel;
    btn5: TDNMSpeedButton;
    Label4: TLabel;
    G4: TDBEdit;
    G3: TDBEdit;
    Label3: TLabel;
    btn4: TDNMSpeedButton;
    Label79: TLabel;
    Label78: TLabel;
    btn3: TDNMSpeedButton;
    Label2: TLabel;
    G2: TDBEdit;
    Label77: TLabel;
    btn2: TDNMSpeedButton;
    Label1: TLabel;
    G1: TDBEdit;
    Label76: TLabel;
    Label75: TLabel;
    Bevel6: TBevel;
    Period: TwwRadioGroup;
    MonthLabel: TLabel;
    Tab1_Month: TwwDBComboBox;
    YearLabel: TLabel;
    Tab1_Year: TwwDBComboBox;
    Label74: TLabel;
    dtTab_1PeriodEnding: TwwDBDateTimePicker;
    Label73: TLabel;
    pnlTab1_LastPeriod: TDNMPanel;
    Label121: TLabel;
    Label122: TLabel;
    dtTab1_from: TwwDBDateTimePicker;
    dtTab1_To: TwwDBDateTimePicker;
    DNMPanel4: TDNMPanel;
    Label134: TLabel;
    Label127: TLabel;
    Label47: TLabel;
    _1A: TDBEdit;
    Label135: TLabel;
    btn17_old: TDNMSpeedButton;
    btn19_old: TDNMSpeedButton;
    btn23_old: TDNMSpeedButton;
    btn24_old: TDNMSpeedButton;
    btn25_old: TDNMSpeedButton;
    btn26_old: TDNMSpeedButton;

    lbl01: TLabel;
    lbl02: TLabel;
    lbl03: TLabel;
    lbl04: TLabel;
    lbl05: TLabel;
    lbl06: TLabel;


    Label48: TLabel;
    _1C_: TDBEdit;
    Label136: TLabel;

    Label49: TLabel;
    _1E_: TDBEdit;
    Label137: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    _2A: TDBEdit;
    Label138: TLabel;
    Bevel4: TBevel;
    Label51: TLabel;
    Label65: TLabel;
    _3: TDBEdit;
    Label150: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label133: TLabel;
    Label66: TLabel;
    Label132: TLabel;
    Label50: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    _8A: TDBEdit;
    _7: TDBEdit;
    _6A: TDBEdit;
    _5A: TDBEdit;
    _4: TDBEdit;
    Label144: TLabel;
    Label69: TLabel;
    Label62: TLabel;
    _9: TDBEdit;
    Bevel5: TBevel;
    Label154: TLabel;
    Label153: TLabel;
    Label152: TLabel;
    Label151: TLabel;
    Label130: TLabel;
    Label70: TLabel;
    Label131: TLabel;
    Label63: TLabel;
    Label61: TLabel;
    Label60: TLabel;
    _5B: TDBEdit;
    _6B: TDBEdit;
    _8B: TDBEdit;
    Label149: TLabel;
    Label71: TLabel;
    Label148: TLabel;
    Label147: TLabel;
    Label146: TLabel;
    Label145: TLabel;

    Label126: TLabel;
    Label125: TLabel;
    Label64: TLabel;
    _1B: TDBEdit;
    Label56: TLabel;
    _1D_: TDBEdit;
    Label57: TLabel;
    _1F_: TDBEdit;
    Label58: TLabel;
    _1G_: TDBEdit;
    Label59: TLabel;
    _2B: TDBEdit;
    Label124: TLabel;
    Bevel9: TBevel;
    Bevel18: TBevel;
    Label160: TLabel;
    QryReturnsDone: TWideStringField;
    QryReturnsHasTab1: TWideStringField;
    QryReturnsHasTab2: TWideStringField;
    QryReturnsHasTab3: TWideStringField;
    QryReturnsHasTab4: TWideStringField;
    chkHasTab1: TwwCheckBox;
    chkHasTab2: TwwCheckBox;
    chkHasTab3: TwwCheckBox;
    chkHAsTab4: TwwCheckBox;
    Bevel1: TBevel;
    QryReturnLinesTransDate: TDateField;
    QryReturnsSummarisedTransDate: TDateField;
    Label161: TLabel;
    Label162: TLabel;
    _7D_: TDBEdit;
    QryReturns_7D: TFloatField;
    QryReturns_7DSelected: TWideStringField;
    lbl_comment_1: TLabel;
    lbl_comment_5: TLabel;
    lbl_comment_3: TLabel;
    lbl_comment_2: TLabel;
    lbl_comment_4: TLabel;
    TabSheet1: TTabSheet;
    Label163: TLabel;
    pnlWnL: TDNMPanel;
    Label167: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label210: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    Label217: TLabel;
    Label218: TLabel;
    Label219: TLabel;
    Label222: TLabel;
    Label223: TLabel;
    btn17: TDNMSpeedButton;
    btn19: TDNMSpeedButton;
    _1E: TDBEdit;
    btn25: TDNMSpeedButton;
    btn24: TDNMSpeedButton;
    btn23: TDNMSpeedButton;
    _1d: TDBEdit;
    _1F: TDBEdit;
    _1G: TDBEdit;
    btn26: TDNMSpeedButton;
    _7d: TDBEdit;
    QryReturnsTab4_type: TWideStringField;
    QryReturnsTab4_Month: TWideStringField;
    QryReturnsTab4_year: TIntegerField;
    Label164: TLabel;
    Period4: TwwRadioGroup;
    MonthLabel4: TLabel;
    Tab4_Month: TwwDBComboBox;
    YearLabel4: TLabel;
    Tab4_Year: TwwDBComboBox;
    Label171: TLabel;
    dtTab_4PeriodEnding: TwwDBDateTimePicker;
    Bevel10: TBevel;
    DNMPanel1: TDNMPanel;
    pnlTab4_LastPeriod: TLabel;
    Label173: TLabel;
    dtTab4_from: TwwDBDateTimePicker;
    dtTab4_To: TwwDBDateTimePicker;
    _1C: TDBEdit;
    QryReturnLinesTransSeqno: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure QryReturnsAccMethodChange(Sender: TField);
    procedure Tab1Change(Sender: TField);
    procedure btnPrintClick(Sender: TObject);
    procedure PeriodChange(Sender: TObject);
    procedure Period2Change(Sender: TObject);
    procedure Period3Change(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn20Click(Sender: TObject);
    procedure btn11Click(Sender: TObject);
    procedure btn13Click(Sender: TObject);
    procedure btn14Click(Sender: TObject);
    procedure btn15Click(Sender: TObject);
    procedure btn18Click(Sender: TObject);
    procedure btn17Click(Sender: TObject);
    procedure btn19Click(Sender: TObject);
    procedure btn23Click(Sender: TObject);
    procedure btn24Click(Sender: TObject);
    procedure btn25Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn10Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn12Click(Sender: TObject);
    procedure Tab3_MonthCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure Tab2_MonthCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure Tab1_MonthCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure QryReturns_1CChange(Sender: TField);
    procedure QryReturnsG1Change(Sender: TField);
    procedure QryReturnsW1Change(Sender: TField);
    procedure FormDestroy(Sender: TObject);
    procedure TaxDblClick(Sender: TObject);Override;
    procedure AccDblClick(Sender: TObject);Override;
    procedure chkHasTab1Click(Sender: TObject);
    procedure chkHasTab2Click(Sender: TObject);
    procedure chkHasTab3Click(Sender: TObject);
    procedure chkHAsTab4Click(Sender: TObject);
    procedure btn26Click(Sender: TObject);
    procedure Tab4_MonthCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure Period4Change(Sender: TObject);

  private
    objBas  :TBasObj;
    procedure PrintSelectedBasReport(const ReportName: string;const Print: boolean);
    procedure BASReturnOptions(Sender: TObject);
    procedure InitBASReturnOptions(Sender: TObject);
    procedure HideComments;


  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure DoTabchange(cThisKey: char );Override;
    Procedure InitBas4Tax(BAS: TBASObj; const Tab: integer);Override;
    Procedure InitBas4Account(BAS: TBASObj;const Tab: integer);Override;
    procedure Silent_OpenAccountSelect(const Box: TDBEdit; const Tab: integer);Override;
    procedure Silent_OpenTaxSelect(const Box: TDBEdit; const Tab: integer);Override;
    procedure RefreshAll;Override;
    procedure initTransAccountDetails(form :TTransAccountDetailsGUI;const Box: TDBEdit); override;
    procedure initCashBasisDetails(form: TCashBasisDetailsGUI; sender:TObject);override;
    procedure InitBas(fObjReturn: TReturnObj);Override;
    Procedure PeriodForAutoPopulatehistory;Override;
    procedure PrintReport(const ReportName: string; const Print: boolean = false);Override;
    function HighestReturnDate: TDatetime;Override;

  public
    BASReturn : TBASReturn;
    procedure PrepareCashBasis; Override;
  end;

implementation

uses CommonLib, CommonDbLib, AppEnvironment, CashBasis, dateutils, FastFuncs,
  DNMLib, FormFactory, tcConst, CommonFormLib, frmBASReturnOptions;

{$R *.dfm}

procedure TfmBASReturn.btnPrintClick(Sender: TObject);
begin
  ReportToPrint := 'BAS Quarterly Option1';
  inherited;
end;

procedure TfmBASReturn.btn2Click(Sender: TObject);begin  OpenTaxSelect(G1,1);  fbChangesMade := true;end;
procedure TfmBASReturn.btn3Click(Sender: TObject);begin  OpenTaxSelect(G2,1);  fbChangesMade := true;end;
procedure TfmBASReturn.btn4Click(Sender: TObject);begin  OpenTaxSelect(G3,1);  fbChangesMade := true;end;
procedure TfmBASReturn.btn8Click(Sender: TObject);begin  OpenTaxSelect(G7,1);  fbChangesMade := true;end;
procedure TfmBASReturn.btn5Click(Sender: TObject);begin  OpenTaxSelect(G4,1);  fbChangesMade := true;end;
procedure TfmBASReturn.btn11Click(Sender: TObject);begin OpenTaxSelect(G11,1);  fbChangesMade := true;end;
procedure TfmBASReturn.btn13Click(Sender: TObject);begin OpenTaxSelect(G13,1);  fbChangesMade := true;end;
procedure TfmBASReturn.btn14Click(Sender: TObject);begin OpenTaxSelect(G14,1);  fbChangesMade := true;end;
procedure TfmBASReturn.btn15Click(Sender: TObject);begin OpenTaxSelect(G15,1);  fbChangesMade := true;end;
procedure TfmBASReturn.btn20Click(Sender: TObject);begin OpenTaxSelect(G10,1);  fbChangesMade := true;end;
procedure TfmBASReturn.btn18Click(Sender: TObject);begin OpenTaxSelect(G18,1);  fbChangesMade := true;end;

procedure TfmBASReturn.btn17Click(Sender: TObject);begin OpenTaxSelect(_1C,3);  fbChangesMade := true;end;
procedure TfmBASReturn.btn19Click(Sender: TObject);begin OpenTaxSelect(_1E,3);  fbChangesMade := true;end;
procedure TfmBASReturn.btn23Click(Sender: TObject);begin OpenTaxSelect(_1D,3);  fbChangesMade := true;end;
procedure TfmBASReturn.btn24Click(Sender: TObject);begin OpenTaxSelect(_1F,3);  fbChangesMade := true;end;
procedure TfmBASReturn.btn25Click(Sender: TObject);begin OpenTaxSelect(_1G,3);  fbChangesMade := true;end;

procedure TfmBASReturn.btn26Click(Sender: TObject);begin OpenAccountSelect(_7D,1);  fbChangesMade := true;end;
procedure TfmBASReturn.btn6Click(Sender: TObject);begin  OpenAccountSelect(W1, 2);  fbChangesMade := true;end;
procedure TfmBASReturn.btn7Click(Sender: TObject);begin  OpenAccountSelect(W2, 2);  fbChangesMade := true;end;
procedure TfmBASReturn.btn9Click(Sender: TObject);begin  OpenAccountSelect(W4, 2);  fbChangesMade := true;end;

procedure TfmBASReturn.btn10Click(Sender: TObject);begin OpenAccountSelect(W3, 2);  fbChangesMade := true;end;
procedure TfmBASReturn.btn12Click(Sender: TObject);begin OpenAccountSelect(T1,3);  fbChangesMade := true;end;

procedure TfmBASReturn.PeriodForAutoPopulatehistory;
var
  dtFrom1 , dtTo1,dtFrom2 , dtTo2, dtFrom3 , dtTo3, dtFrom4, dtTo4:TDatetime;
  stype1,stype2,stype3, stype4:String;
begin
  inherited;
  BasReturn.LastReturn(dtFrom1, dtTo1 , stype1, tRPBASTab1);
  BasReturn.LastReturn(dtFrom2, dtTo2 , stype2, tRPBASTab2);
  BasReturn.LastReturn(dtFrom3, dtTo3 , stype3, tRPBASTab3);
  BasReturn.LastReturn(dtFrom4, dtTo4 , stype4, tRPBASTab4);

  if stype2 = '' then stype2 := stype1; if dtFrom2=0 then dtFrom2 := dtFrom1; if dtTo2 =0 then dtTo2 := dtTo1;
  if stype3 = '' then stype3 := stype1; if dtFrom3=0 then dtFrom3 := dtFrom1; if dtTo3 =0 then dtTo3 := dtTo1;
  if stype4 = '' then stype4 := stype1; if dtFrom4=0 then dtFrom4 := dtFrom1; if dtTo4 =0 then dtTo4 := dtTo1;

  BasReturn.Tab1_type  := stype1;
  BasReturn.Tab1_month := BasReturn.MonthNumberToName(monthof(dtFrom1));
  BasReturn.Tab1_year  := YearOf(dtFrom1);


  BasReturn.Tab2_type  := stype2;
  BasReturn.Tab2_month := BasReturn.MonthNumberToName(monthof(dtFrom2));
  BasReturn.Tab2_year  := YearOf(dtFrom2);

  BasReturn.Tab3_type  := stype3;
  BasReturn.Tab3_month := BasReturn.MonthNumberToName(monthof(dtFrom3));
  BasReturn.Tab3_year  := YearOf(dtFrom3);

  BasReturn.Tab4_type  := stype4;
  BasReturn.Tab4_month := BasReturn.MonthNumberToName(monthof(dtFrom4));
  BasReturn.Tab4_year  := YearOf(dtFrom4);

  BasReturn.Description := 'Summary ';
end;

procedure TfmBASReturn.InitBASReturnOptions(Sender:TObject);
begin
  if not(Sender is TfmBASReturnOptions) then exit;
  TfmBASReturnOptions(Sender).GSTEnabled   := BASReturn.HasTab1;
  TfmBASReturnOptions(Sender).PAYGWEnabled := BASReturn.HasTab2;
  TfmBASReturnOptions(Sender).PAYGIEnabled := BASReturn.HasTab3;
  TfmBASReturnOptions(Sender).WnLEnabled   := BASReturn.HasTab4;
end;

procedure TfmBASReturn.BASReturnOptions(Sender:TObject);
begin
  if not(Sender is TfmBASReturnOptions) then exit;
  BASReturn.HasTab1 := TfmBASReturnOptions(Sender).GSTEnabled;
  BASReturn.HasTab2 := TfmBASReturnOptions(Sender).PAYGWEnabled;
  BASReturn.HasTab3 := TfmBASReturnOptions(Sender).PAYGIEnabled;
  BASReturn.HasTab4 := TfmBASReturnOptions(Sender).WnLEnabled;
end;

procedure TfmBASReturn.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
var
  dtFrom , dtTo:TDatetime;
  stype:String;
begin
  inherited;

  if (Eventtype = BusobjEvent_Event) and (Value = BusobjEvent_AfterInsert) then begin
    OpenERPFormModal('TfmBASReturnOptions', 0, InitBASReturnOptions, True, BASReturnOptions);
    pnlGST.Enabled            := BASReturn.HasTab1; if not(pnlGST.Enabled)            then pnlGST.color           := $0089FAF7;
    pnlTaxandWithheld.Enabled := BASReturn.HasTab2; if not(pnlTaxandWithheld.Enabled) then pnlTaxandWithheld.color:= $0089FAF7;
    pnlInstallment.Enabled    := BASReturn.HasTab3; if not(pnlInstallment.Enabled)    then pnlInstallment.color   := $0089FAF7;
    pnlWnL.Enabled            := BASReturn.HasTab4; if not(pnlWnL.Enabled)            then pnlWnL.color           := $0089FAF7;
  end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_IDChange) then begin
    if BasReturn.HasTab1 then begin
      BasReturn.LastReturn(dtFrom, dtTo , stype, tRPBASTab1);
      pnlTab1_LastPeriod.visible := dtFrom <> 0;
      dtTab1_from.Date := dtFrom;
      dtTab1_to.Date := dtTo;
    end;

    if BasReturn.HasTab2 then begin
      BasReturn.LastReturn(dtFrom, dtTo , stype, tRPBASTab2);
      pnlTab2_LastPeriod.visible := dtFrom <> 0;
      dtTab2_from.Date := dtFrom;
      dtTab2_to.Date := dtTo;
    end;

    if BasReturn.HasTab3 then begin
      BasReturn.LastReturn(dtFrom, dtTo , stype, tRPBASTab3);
      pnlTab3_LastPeriod.visible := dtFrom <> 0;
      dtTab3_from.Date := dtFrom;
      dtTab3_to.Date := dtTo;
    end;


    if BasReturn.HasTab4 then begin
      BasReturn.LastReturn(dtFrom, dtTo , stype, tRPBASTab4);
      pnlTab4_LastPeriod.visible := dtFrom <> 0;
      dtTab4_from.Date := dtFrom;
      dtTab4_to.Date := dtTo;
    end;


  end else if (Sametext(Eventtype , BusobjEvent_ToDo)) and (Sametext(Value , BusobjEvent_DateRangeChange+'tab1')) then begin
    if fbFormshown then begin
      OnchangePeriod(MonthLabel ,Tab1_Month , Period );
      if BASReturn.Tab1_To <> 0 then dtTab_1PeriodEnding.Date := BASReturn.Tab1_To;
      if (BASReturn.Description = '') and (BASReturn.Tab1_Month <> '') and (BASReturn.Tab1_year<> 0) then BASReturn.Description := BASReturn.Tab1_type +' From ' + BASReturn.Tab1_Month +' ' + inttostr(BASReturn.Tab1_year);
    end;
  end else if (Sametext(Eventtype , BusobjEvent_ToDo)) and (Sametext(Value , BusobjEvent_DateRangeChange+'tab2')) then begin
    if fbFormshown then begin
      OnchangePeriod(MonthLabel2 , Tab2_Month , Period2 );
      if (BASReturn.Tab2_To <> 0)  then dtTab_2PeriodEnding.Date := BASReturn.Tab2_To;
      if (BASReturn.Description = '') and (BASReturn.Tab2_Month <> '') and (BASReturn.Tab2_year<> 0) then BASReturn.Description := BASReturn.Tab2_type +' From ' + BASReturn.Tab2_Month +' ' + inttostr(BASReturn.Tab2_year);
    end;
  end else if (Sametext(Eventtype , BusobjEvent_ToDo)) and (Sametext(Value , BusobjEvent_DateRangeChange+'tab3')) then begin
    if fbFormshown then begin
      OnchangePeriod(MonthLabel3 , Tab3_Month , Period3 );
      if BASReturn.Tab3_To <> 0 then dtTab_3PeriodEnding.Date := BASReturn.Tab3_To;
      if (BASReturn.Description = '') and (BASReturn.Tab3_Month <> '') and (BASReturn.Tab3_year<> 0) then BASReturn.Description := BASReturn.Tab3_type +' From ' + BASReturn.Tab3_Month +' ' + inttostr(BASReturn.Tab3_year);
    end;
  end else if (Sametext(Eventtype , BusobjEvent_ToDo)) and (Sametext(Value , BusobjEvent_DateRangeChange+'tab4')) then begin
    if fbFormshown then begin
      OnchangePeriod(MonthLabel4, Tab4_Month, Period4 );
      if BASReturn.Tab4_To <> 0 then dtTab_4PeriodEnding.Date := BASReturn.Tab4_To;
      if (BASReturn.Description = '') and (BASReturn.Tab4_Month <> '') and (BASReturn.Tab4_year<> 0) then BASReturn.Description := BASReturn.Tab4_type +' From ' + BASReturn.Tab4_Month +' ' + inttostr(BASReturn.Tab4_year);
    end;
  end;
end;

procedure TfmBASReturn.FormCreate(Sender: TObject);
begin
  objBas := TBASObj.Create;
  objReturn := objBas;
  inherited;
  BASReturn := TBASReturn.Create(Self);
  BASReturn.Connection := TMydacdataconnection.Create(BASReturn);
  BASReturn.Connection.Connection := Self.Myconnection;
  BASReturn.BusObjEvent := DoBusinessObjectEvent;
  Return := BASReturn;
  Objbas.ReturnsObj := Return;
end;

procedure TfmBASReturn.FormDestroy(Sender: TObject);
begin
  FreeandNil(objBas);
  objReturn := nil;
  FreeandNil(BASReturn);
  Return := nil;
  inherited;

end;

Procedure TfmBASReturn.HideComments;
begin
  lbl_comment_1.visible := devmode;
  lbl_comment_2.visible := devmode;
  lbl_comment_3.visible := devmode;
  lbl_comment_4.visible := devmode;
  lbl_comment_5.visible := devmode;
end;

procedure TfmBASReturn.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    HideComments;
    inherited;
    Tabmain.ActivePage := tabSuppAndAcq;
    if keyId = 0 then begin
    end else begin
      if (Period.Value = tPTQuarterly) then Quarterly(Tab1_Month)else if (Period.Value = tPTMonthly) then Monthly(Tab1_Month);
      if (Period2.Value = tPTQuarterly) then Quarterly(Tab2_Month)else if (Period2.Value = tPTMonthly) then Monthly(Tab2_Month);
      if (Period3.Value = tPTQuarterly) then Quarterly(Tab3_Month) else if (Period3.Value = tPTMonthly) then Monthly(Tab3_Month);
      if (Period4.Value = tPTQuarterly) then Quarterly(Tab4_Month) else if (Period4.Value = tPTMonthly) then Monthly(Tab4_Month);
      if  BASReturn.Tab1_To <> 0 then dtTab_1PeriodEnding.Date := BASReturn.Tab1_To;
      if  BASReturn.Tab2_To <> 0 then dtTab_2PeriodEnding.Date := BASReturn.Tab2_To;
      if  BASReturn.Tab3_to <> 0 then dtTab_3PeriodEnding.Date := BASReturn.Tab3_To;
      if  BASReturn.Tab4_to <> 0 then dtTab_4PeriodEnding.Date := BASReturn.Tab4_To;
    end;

    if (BASReturn.AccMethod = 'Cash') then begin
      PrepareCashBasis;
      Label76.caption :=  'GST Accounting Method Cash';
    end else begin
      Label76.caption :=  'GST Accounting Method Non-Cash (Accruals)';
    end;
    {if any of the date range is prior to the closing date the form si readonly}
    if (KeyId <> 0) and (Accesslevel<5) then begin
      if  (BasReturn.HasTab1) and (Check4closingdate(BasReturn.tab1_from , BasReturn.Tab1_To)) then
        Self.Caption := FormName +' Return - Date Range Selected '  +
                ' (' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,BasReturn.tab1_from  )) +
                ' to ' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,BasReturn.tab1_to  )) + ') is Prior to Closing Date'
      else if (BasReturn.HasTab2) and (Check4closingdate(BasReturn.tab2_from , BasReturn.Tab2_To)) then
        Self.Caption := FormName +' Return - Date Range Selected '  +
                ' (' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,BasReturn.tab2_from  )) +
                ' to ' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,BasReturn.tab2_to  )) + ') is Prior to Closing Date'
      else if (BasReturn.HasTab3) and (Check4closingdate(BasReturn.tab3_from , BasReturn.Tab3_To)) then
          Self.Caption := FormName +' Return - Date  Range Selected '  +
                ' (' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,BasReturn.tab3_from  )) +
                ' to ' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,BasReturn.tab3_to  )) + ') is Prior to Closing Date'
      else if (BasReturn.HasTab4) and (Check4closingdate(BasReturn.tab4_from , BasReturn.Tab4_To)) then
          Self.Caption := FormName +' Return - Date  Range Selected '  +
                ' (' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,BasReturn.tab4_from  )) +
                ' to ' +quotedstr(formatDateTime(FormatSettings.ShortDateFormat ,BasReturn.tab4_to  )) + ') is Prior to Closing Date' ;
    end;
      chkHasTab1Click(chkHasTab1);
      chkHasTab2Click(chkHasTab2);
      chkHasTab3Click(chkHasTab3);
      chkHasTab4Click(chkHasTab4);
      if not AutoPopulateForHistory then begin
          Self.Close;
          Exit;
      end;
      CheckForsummary;
  finally
    RealignTabControl(TabMain, 1);
    EnableForm;
  end;
end;

function TfmBASReturn.HighestReturnDate: TDatetime;
begin
  Result:= 0;
  if chkHasTab1.Checked then
    if result < dtTab_1PeriodEnding.DateTime then result:= dtTab_1PeriodEnding.DateTime;
  if chkHasTab2.checked then
    if result <    dtTab_2PeriodEnding.DateTime then result := dtTab_2PeriodEnding.DateTime;
  if chkHasTab3.Checked then
    if result < dtTab_3PeriodEnding.DateTime then result := dtTab_3PeriodEnding.DateTime;
  if chkHasTab4.Checked then
    if result < dtTab_4PeriodEnding.DateTime then result := dtTab_4PeriodEnding.DateTime;
end;

procedure TfmBASReturn.DoTabchange(cThisKey: char );
begin
if cThisKey = 'A' then begin
        TabMain.ActivePageIndex := 0;
        Exit;
      end;

      if cThisKey = 'X' then begin
        TabMain.ActivePageIndex := 1;
        Exit;
      end;

      if cThisKey = 'B' then begin
        TabMain.ActivePageIndex := 2;
        Exit;
      end;
end;



procedure TfmBASReturn.InitBas4Account(BAS: TBASObj;const Tab: integer);
begin
  inherited;
  if (Tab = 1) then begin
    BAS.FromDate := BasReturn.Tab1_From; //Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
    BAS.ToDate := BasReturn.Tab1_To;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
  end else if (Tab = 2) then begin
    BAS.FromDate := BasReturn.Tab2_From; //Self.FromDate(Tab2_Month.Text, Tab2_Year.Text);
    BAS.ToDate := BasReturn.Tab2_To;//Self.toDate(Period2.Value, Tab2_Month.Text, Tab2_Year.Text);
  end else if (Tab = 3) then begin
    BAS.FromDate := BasReturn.Tab3_From; //Self.FromDate(Tab3_Month.Text, Tab3_Year.Text);
    BAS.ToDate := BasReturn.Tab3_To;//Period3.Value, Tab3_Month.Text, Tab3_Year.Text);
  end else if (Tab = 4) then begin
    BAS.FromDate := BasReturn.Tab4_From; //Self.FromDate(Tab3_Month.Text, Tab3_Year.Text);
    BAS.ToDate := BasReturn.Tab4_To;//Period3.Value, Tab3_Month.Text, Tab3_Year.Text);
  end;
  BAS.ObjType := ftAcc;
  InitBas(BAs);
end;

procedure TfmBASReturn.InitBas(fObjReturn: TReturnObj);
begin
  fObjReturn.AccountingMethod := BASReturn.AccMethod;
  fObjReturn.All := BASReturn.AllClass;
  fObjReturn.Department := GetClassName(BASReturn.ClassID);
end;

procedure TfmBASReturn.InitBas4Tax(BAS: TBASObj; const Tab: integer);
begin
  inherited;
  if tab =1 then begin
    BAS.FromDate := BasReturn.Tab1_From; //Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
    BAS.ToDate := BasReturn.Tab1_To;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
  end else if tab = 2 then begin
    BAS.FromDate := BasReturn.Tab2_From; //Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
    BAS.ToDate := BasReturn.Tab2_To;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
  end else if tab = 3 then begin
    BAS.FromDate := BasReturn.Tab3_From; //Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
    BAS.ToDate := BasReturn.Tab3_To;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
  end else if tab = 4 then begin
    BAS.FromDate := BasReturn.Tab4_From; //Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
    BAS.ToDate := BasReturn.Tab4_To;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
  end;
  InitBas(BAs);
end;

procedure TfmBASReturn.initCashBasisDetails(form: TCashBasisDetailsGUI;
  sender: TObject);
begin
  inherited;
  if not (Sender is TDBEdit) then exit;
  if TDBEdit(sender).Parent = pnlTaxandWithheld then begin
    Form.ToDate := BasReturn.Tab2_To;//Self.toDate(Period2.Value, Tab2_Month.Text, Tab2_Year.Text);
    Form.FromDate := BasReturn.Tab2_From; //Self.FromDate(Tab2_Month.Text, Tab2_Year.Text);
  end else if TDBEdit(sender).Parent = pnlInstallment then begin
    Form.ToDate := BasReturn.Tab3_To;//Self.toDate(Period3.Value, Tab3_Month.Text, Tab3_Year.Text);
    Form.FromDate := BasReturn.Tab3_From; //Self.FromDate(Tab3_Month.Text, Tab3_Year.Text);
  end else if TDBEdit(sender).Parent = pnlWnL then begin
    Form.ToDate := BasReturn.Tab4_To;//Self.toDate(Period3.Value, Tab3_Month.Text, Tab3_Year.Text);
    Form.FromDate := BasReturn.Tab4_From; //Self.FromDate(Tab3_Month.Text, Tab3_Year.Text);
  end else begin
    Form.ToDate := BasReturn.Tab1_To;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
    Form.FromDate := BasReturn.Tab1_From; //Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
  end;
end;

procedure TfmBASReturn.initTransAccountDetails(form :TTransAccountDetailsGUI;const Box: TDBEdit);
begin
  inherited;
  if not (Box is TDBEdit) then exit;
  if TDBEdit(Box).Parent = pnlTaxandWithheld then begin
    Form.ToDate := BasReturn.Tab2_To;//Self.toDate(Period2.Value, Tab2_Month.Text, Tab2_Year.Text);
    Form.FromDate := BasReturn.Tab2_From; //Self.FromDate(Tab2_Month.Text, Tab2_Year.Text);
  end else if TDBEdit(Box).Parent = pnlInstallment then begin
    Form.ToDate := BasReturn.Tab3_To;//Self.toDate(Period3.Value, Tab3_Month.Text, Tab3_Year.Text);
    Form.FromDate := BasReturn.Tab3_From; //Self.FromDate(Tab3_Month.Text, Tab3_Year.Text);
  end else if TDBEdit(Box).Parent = pnlWnL then begin
    Form.ToDate := BasReturn.Tab4_To;//Self.toDate(Period3.Value, Tab3_Month.Text, Tab3_Year.Text);
    Form.FromDate := BasReturn.Tab4_From; //Self.FromDate(Tab3_Month.Text, Tab3_Year.Text);
  end else begin
    Form.ToDate := BasReturn.Tab1_To;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
    Form.FromDate := BasReturn.Tab1_From; //Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
  end;
end;

procedure TfmBASReturn.Period2Change(Sender: TObject);
begin
  inherited;
  if not fbFormshown then exit;
  if BasReturn = nil then exit;
  BASReturn.Tab2_Type :=Period2.Value;
  if BASReturn.Tab2_Month <> '' then if  Tab2_Month.Items.Indexof(BASReturn.Tab2_Month) <0 then BASReturn.NextReturn(tRPBasTab2 , False);
end;

procedure TfmBASReturn.Period3Change(Sender: TObject);
begin
  inherited;
  if not fbFormshown then exit;
  if BasReturn = nil then exit;
  BASReturn.Tab3_Type :=Period3.Value;
  if BASReturn.Tab3_Month <> '' then if  Tab3_Month.Items.Indexof(BASReturn.Tab3_Month) <0 then BASReturn.NextReturn(tRPBasTab3 , False);
end;

procedure TfmBASReturn.Period4Change(Sender: TObject);
begin
  inherited;
    if not fbFormshown then exit;
    if BasReturn = nil then exit;
    BASReturn.Tab4_Type :=Period4.Value;
    if BASReturn.Tab4_Month <> '' then if  Tab4_Month.Items.Indexof(BASReturn.Tab4_Month) <0 then BASReturn.NextReturn(tRPBasTab4 , False);
end;

procedure TfmBASReturn.PeriodChange(Sender: TObject);
begin
    if not fbFormshown then exit;
    if BasReturn = nil then exit;
    BASReturn.Tab1_Type :=Period.Value;
    if BASReturn.Tab1_Month <> '' then if  Tab1_Month.Items.Indexof(BASReturn.Tab1_Month) <0 then BASReturn.NextReturn(tRPBasTab1 , False);
end;

procedure TfmBASReturn.PrepareCashBasis;
begin
  inherited;
  if  (AccessLevel =5) then Exit;
  if fbNoCashBasis  then exit;
  //Cash Basis Prepare
  If BasReturn.HasTab1 then begin
    if CashBasis.IsCashBasisTransSummarised(Self,BasReturn.Tab1_From,BasReturn.Tab1_TO) then Begin
      fbNoCashBasis := True;
      //Close;
      Exit;
    end;
  end else If BasReturn.HasTab2 then begin
    if CashBasis.IsCashBasisTransSummarised(Self,BasReturn.Tab2_From,BasReturn.Tab2_TO) then Begin
      fbNoCashBasis := True;
      //Close;
      Exit;
    end;
  end;

  if duetoPrepareCashBasisDetails(0,0)  then  CashBasis.PrepareCashBasisDetails(0,0, 'BAS');
  //CashBasis.PrepareCashBasisDetails(0,0, 'BAS', true);
end;

procedure TfmBASReturn.QryReturnsAccMethodChange(Sender: TField);
begin
  inherited;
  if (BASReturn.AccMethod = 'Cash') then begin
    PrepareCashBasis;
    Label76.caption := 'GST Accounting Method Cash';
  end else begin
    Label76.caption := 'GST Accounting Method Non-Cash (Accruals)';
  end;

end;

procedure TfmBASReturn.QryReturnsG1Change(Sender: TField);
begin
  inherited;
  RefreshTypeValues;
end;

procedure TfmBASReturn.QryReturnsW1Change(Sender: TField);
begin
  inherited;
  RefreshTypeValues;
end;

procedure TfmBASReturn.QryReturns_1CChange(Sender: TField);
begin
  inherited;
  RefreshTypeValues;
end;

procedure TfmBASReturn.RefreshAll;
begin
  ShowProgressbar(WAITMSG , 21);
  try
    Silent_OpenTaxSelect(G1, 1);      stepProgressbar;
    Silent_OpenTaxSelect(G2, 1);      stepProgressbar;
    Silent_OpenTaxSelect(G3, 1);      stepProgressbar;
    Silent_OpenTaxSelect(G4, 1);      stepProgressbar;
    Silent_OpenTaxSelect(G7, 1);      stepProgressbar;
    Silent_OpenTaxSelect(G10,1);      stepProgressbar;
    Silent_OpenTaxSelect(G11,1);      stepProgressbar;
    Silent_OpenTaxSelect(G13,1);      stepProgressbar;
    Silent_OpenTaxSelect(G14,1);      stepProgressbar;
    Silent_OpenTaxSelect(G15,1);      stepProgressbar;
    Silent_OpenTaxSelect(G18,1);      stepProgressbar;
    Silent_OpenAccountSelect(W1, 2);  stepProgressbar;
    Silent_OpenAccountSelect(W2, 2);  stepProgressbar;
    Silent_OpenAccountSelect(W3, 2);  stepProgressbar;
    Silent_OpenAccountSelect(W4, 2);  stepProgressbar;
    Silent_OpenAccountSelect(T1, 3);  stepProgressbar;
    Silent_OpenTaxSelect(_1C, 4);     stepProgressbar;
    Silent_OpenTaxSelect(_1E, 4);     stepProgressbar;
    Silent_OpenTaxSelect(_1D, 4);     stepProgressbar;
    Silent_OpenTaxSelect(_1F, 4);     stepProgressbar;
    Silent_OpenTaxSelect(_1G, 4);     stepProgressbar;
    Silent_OpenAccountSelect(_7D, 4); stepProgressbar;
    Application.ProcessMessages;
    inherited;
  finally
    HideProgressbar;
  end;
end;

procedure TfmBASReturn.Tab1Change(Sender: TField);
begin
  inherited;
  if (BASReturn.AccMethod = 'Cash') then begin
    PrepareCashBasis;
  end;
  DateLabel2.caption := SelectedPeriodToStr(Tab1_Month, Tab1_Year, Period);
end;
procedure TfmBASReturn.Tab1_MonthCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  Silent_OpenTaxSelect(G1,1);{Sets ReturnObj dates etc}
  objBas.RecalcAllG(Self.KeyID);
end;

procedure TfmBASReturn.Tab2_MonthCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  Silent_OpenAccountSelect(W2, 2);{Sets ReturnObj dates etc}
  objBas.RecalcAllW(Self.KeyID);
end;

procedure TfmBASReturn.Tab3_MonthCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  Silent_OpenAccountSelect(T1, 3);{Sets ReturnObj dates etc}
  objBas.RecalcPAYG(Self.KeyID);
end;


procedure TfmBASReturn.Tab4_MonthCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  Silent_OpenTaxSelect(_1C,3);{Sets ReturnObj dates etc}
  objBas.RecalcAllG(Self.KeyID);
end;

procedure TfmBASReturn.TaxDblClick(Sender: TObject);
begin
  //inherited;
  if  not(Sender is TDBEdit) then exit;
  //if accesslevel = 5 then exit;
  SelectedCode :=TDBEdit(Sender).Name;
  if accesslevel <> 5 then
      if not(Savencommit) then exit;
  OpenErpListform('TBASTransReturnListGUI' , beforeOpenDetails);
end;

procedure TfmBASReturn.chkHasTab2Click(Sender: TObject);
begin
  inherited;
  if not Assigned(BASReturn) then exit;

  if screen.ActiveControl = chkHasTab2 then
    if BASReturn.HasTab2<>chkHasTab2.Checked then begin BASReturn.HasTab2:= chkHasTab2.Checked;  BASReturn.postDB;  BASReturn.EditDB;end;
  pnlTaxandWithheld.Enabled := BASReturn.HasTab2;
  if not(pnlTaxandWithheld.Enabled) then pnlTaxandWithheld.color := $0089FAF7 else pnlTaxandWithheld.color := Self.Color;
end;

procedure TfmBASReturn.chkHasTab3Click(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkHasTab3 then
    if BASReturn.HasTab3<>chkHasTab3.Checked then begin BASReturn.HasTab3:= chkHasTab3.Checked;  BASReturn.postDB;  BASReturn.EditDB;end;
  pnlInstallment.Enabled := BASReturn.HasTab3;
  if not(pnlInstallment.Enabled) then     pnlInstallment.color := $0089FAF7  else    pnlInstallment.color := Self.Color;
end;

procedure TfmBASReturn.chkHAsTab4Click(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkHasTab4 then
    if BASReturn.HasTab4<>chkHasTab4.Checked then begin BASReturn.HasTab4:= chkHasTab4.Checked;  BASReturn.postDB;  BASReturn.EditDB;end;
  pnlWnL.Enabled := BASReturn.HasTab4;
  if not(pnlInstallment.Enabled) then     pnlInstallment.color := $0089FAF7  else    pnlInstallment.color := Self.Color;

end;

procedure TfmBASReturn.chkHasTab1Click(Sender: TObject);
begin
  inherited;
  if not Assigned(BASReturn) then exit;

  if screen.ActiveControl = chkHasTab1 then
    if BASReturn.HasTab1<>chkHasTab1.Checked then begin BASReturn.HasTab1:= chkHasTab1.Checked;  BASReturn.postDB;  BASReturn.EditDB;end;
  pnlGST.Enabled := BASReturn.HasTab1;
  if not(pnlGST.Enabled) then pnlGST.color := $0089FAF7 else pnlGST.color := Self.Color;
end;

procedure TfmBASReturn.AccDblClick(Sender: TObject);
begin
  //inherited;
  if  not(Sender is TDBEdit) then exit;
  //if accesslevel = 5 then exit;
  SelectedCode :=TDBEdit(Sender).Name;
  if accesslevel <> 5 then
    if not(Savencommit) then exit;
  OpenErpListform('TBASTransReturnListGUI' , beforeOpenDetails);
end;

procedure TfmBASReturn.Silent_OpenAccountSelect(const Box: TDBEdit;  const Tab: integer);
begin
  try
    inherited;
    if (Tab = 1) then begin
      objBas.FromDate := BasReturn.Tab1_From;//Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
      objBas.ToDate := BasReturn.Tab1_To;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
    end else if (Tab = 2) then begin
      objBas.FromDate := BasReturn.Tab2_From;//Self.FromDate(Tab2_Month.Text, Tab2_Year.Text);
      objBas.ToDate := BasReturn.Tab2_To;//Self.toDate(Period2.Value, Tab2_Month.Text, Tab2_Year.Text);
    end else if (Tab = 3) then begin
      objBas.FromDate := BasReturn.Tab3_From;//Self.FromDate(Tab3_Month.Text, Tab3_Year.Text);
      objBas.ToDate := BasReturn.Tab3_To;//Self.toDate(Period3.Value, Tab3_Month.Text, Tab3_Year.Text);
    end else if (Tab = 4) then begin
      objBas.FromDate := BasReturn.Tab4_From;//Self.FromDate(Tab3_Month.Text, Tab3_Year.Text);
      objBas.ToDate := BasReturn.Tab4_To;//Self.toDate(Period3.Value, Tab3_Month.Text, Tab3_Year.Text);
    end;
    initbas(objBas);
    objBas.initialize;
    objBas.Calc;
  except
    CommonLib.MessageDlgXP_Vista('No Date Period Selected.', mtWarning, [mbOK], 0);
  end;
end;

procedure TfmBASReturn.Silent_OpenTaxSelect(const Box: TDBEdit; const Tab: Integer);
begin
  inherited;
  if tab =1 then begin
    objBas.FromDate := BasReturn.Tab1_From;//Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
    objBas.ToDate := BasReturn.Tab1_to;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
  end else if tab = 2 then begin
    objBas.FromDate := BasReturn.Tab2_From;//Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
    objBas.ToDate := BasReturn.Tab2_to;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
  end else if tab = 3 then begin
    objBas.FromDate := BasReturn.Tab3_From;//Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
    objBas.ToDate := BasReturn.Tab3_to;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
  end else if tab = 4 then begin
    objBas.FromDate := BasReturn.Tab4_From;//Self.FromDate(Tab1_Month.Text, Tab1_Year.Text);
    objBas.ToDate := BasReturn.Tab4_to;//Self.toDate(Period.Value, Tab1_Month.Text, Tab1_Year.Text);
  end;
  objBas.Calc;
end;

procedure TfmBASReturn.PrintReport(const ReportName: string;const Print: boolean);
begin
  PrintSelectedBasReport(ReportName, Print);
end;

procedure TfmBASReturn.PrintSelectedBasReport(const ReportName: string;const Print: boolean);
var
  sSQL,sDigits:string;
  sALLSQL:string;
  x:Integer;
  total:Double;
  Function SplitfieldInTodigits(Const Value:String; Totaldigits:Integer; FieldnamePrefix:String):String;
  var
    xValue:String;
    ctr:Integer;
    l:Integer;
  begin
    result := '';
    xValue := ReplicateStr(' ' , Totaldigits)+Value ;
    l:= char_length(xvalue)-10;
    for ctr := 1 to  Totaldigits do begin
      if result <> '' then result := result +',';
      result := result + Quotedstr(copy(xValue,l+ctr,1)) +' as `' + FieldnamePrefix+ Trim(IntToStr(ctr))+'`';
    end;
  end;
begin
  fbReportSQLSupplied := true;
  try

    if not(SAmetext(Trim(ReportName) , 'Tax Summary')) then begin
        sSQL := '{companyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, ' +
              'CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,' +
              ' Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, Co.POBox , CO.POCity ' +
              'FROM tblCompanyInformation AS CO' +
              '~|||~{details}Select *, ' +

              'if (HasTab1="F" , "" ,' +
              'if(Tab1_type = "Monthly" , concat("For the Month of " , tab1_month , tab1_year)  ,' +
              'concat(concat( if(Tab1_type = "Two Monthly" , "2 Months Beginning " , if(Tab1_type = "Quarterly" , " Quarter Beginning " , if(Tab1_type = "Six Monthly" , "Six Months Beginning " , 1))) ,  EncodeDate(1, monthno(tab1_month) , tab1_year) ),' +
              '" to " ,' +
              'incmonth(monthno(Tab1_month), tab1_year, if(Tab1_type = "Monthly" , 1 , if(Tab1_type = "Two Monthly" , 2 , if(Tab1_type = "Quarterly" , 3 , if(Tab1_type = "Six Monthly" , 6 , 1)))))))) tab1,' +

              'if (HasTab2="F" , "" , if(Tab2_type = "Monthly" , concat("For the Month of " , Tab2_month , Tab2_year)  ,' +
              'concat(concat( if(Tab2_type = "Two Monthly" , "2 Months Beginning " , if(Tab2_type = "Quarterly" , " Quarter Beginning " , if(Tab2_type = "Six Monthly" , "Six Months Beginning " , 1))) ,  EncodeDate(1, monthno(Tab2_month) , Tab2_year) ),' +
              '" to " ,' +
              'incmonth(monthno(Tab2_month), Tab2_year, if(Tab2_type = "Monthly" , 1 , if(Tab2_type = "Two Monthly" , 2 , if(Tab2_type = "Quarterly" , 3 , if(Tab2_type = "Six Monthly" , 6 , 1)))))))) tab2,' +

              ' if (HasTab3="F" , "" , if(Tab3_type = "Monthly" , concat("For the Month of " , Tab3_month , Tab3_year)  ,' +
              ' concat(concat( if(Tab3_type = "Two Monthly" , "2 Months Beginning " , if(Tab3_type = "Quarterly" , " Quarter Beginning " , if(Tab3_type = "Six Monthly" , "Six Months Beginning " , 1))) ,  EncodeDate(1, monthno(Tab3_month) , Tab3_year) ),' +
              '" to " ,' +
              ' incmonth(monthno(Tab3_month), Tab3_year, if(Tab3_type = "Monthly" , 1 , if(Tab3_type = "Two Monthly" , 2 , if(Tab3_type = "Quarterly" , 3 , if(Tab3_type = "Six Monthly" , 6 , 1)))))))) tab3, ' +

              ' if (HasTab4="F" , "" , if(Tab4_type = "Monthly" , concat("For the Month of " , Tab4_month , Tab4_year)  ,' +
              ' concat(concat( if(Tab4_type = "Two Monthly" , "2 Months Beginning " , if(Tab4_type = "Quarterly" , " Quarter Beginning " , if(Tab4_type = "Six Monthly" , "Six Months Beginning " , 1))) ,  EncodeDate(1, monthno(Tab4_month) , Tab4_year) ),' +
              '" to " ,' +
              ' incmonth(monthno(Tab4_month), Tab4_year, if(Tab4_type = "Monthly" , 1 , if(Tab4_type = "Two Monthly" , 2 , if(Tab4_type = "Quarterly" , 3 , if(Tab4_type = "Six Monthly" , 6 , 1)))))))) tab4 ' +


              '  from tblbasreports WHERE ID = ' + IntToStr(BasReturn.ID);
        with CommonDbLib.TempMyQuery do try
          SQL.clear;
          SQL.add('select CO.PhoneNumber from tblCompanyInformation AS CO');
          Open;
          sDigits := 'Select ' + SplitfieldInTodigits(FieldByname('PhoneNumber').asString , 10 , 'Phone');
          close;

          SQL.clear;
          SQL.add('SELECT');
          SQL.add('`G1`,`G2`,`G3`,`G10`,`G11`,`G4`,`G5`,`G6`,`G7`,`G8`,`G9`,`G12`,');
          SQL.add('`G13`,`G14`,`G15`,`G16`,`G17`,`G18`,`G19`,`G20`,`W1`,`W2`,`W3`,');
          SQL.add('`W4`,`T1`,`T2`,`T3`,`F1`,`F2`,`F3`,`_1A`,`_1B`,`_1C`,');
          SQL.add('`_1D`,`_1E`,`_1F`,`_1G`,`_2A`,`_2B`,`_3`,`_4`,`_5A`,`_5B`,`_6A`,`_6B`,');
          SQL.add('`_7`,`_7D`, `_8A`,`_8B`,`_9`');
          SQL.add('from tblbasreports');
          SQL.add('WHERE ID = ' + IntToStr(BasReturn.ID));
          open;
          for x := 0 to fields.count-1 do begin
            sDigits := sDigits +',' ;
            sDigits := sDigits+ SplitfieldInTodigits(IntToStr(Trunc(Round(fields[x].asFloat,0))) , 10 , Fields[x].FieldName);
            sDigits := sDigits +chr(13);
          end;
          {5:w2+w3+w4}
          sDigits := sDigits +',' ;
          total :=FieldByname('w2').asFloat + FieldByname('w3').asFloat + FieldByname('w4').asFloat;
          sDigits := sDigits+ SplitfieldInTodigits(IntToStr(Trunc(Round(total,0))) , 10 , 'w5');
          sDigits := sDigits +chr(13);
          {8a : 1a+4+5a+7}
          sDigits := sDigits +',' ;
          total :=FieldByname('_1A').asFloat + FieldByname('_4').asFloat + FieldByname('_5A').asFloat+ FieldByname('_7').asFloat;
          sDigits := sDigits+ SplitfieldInTodigits(IntToStr(Trunc(Round(total,0))) , 10 , '8A');
          sDigits := sDigits +chr(13);
          {T11 : T1 * T2(or T3)}
          sDigits := sDigits +',' ;
          total :=FieldByname('T1').asFloat ;
          if  FieldByname('T2').asFloat <>0 then total := total * FieldByname('t2').asFloat
          else if  FieldByname('T3').asFloat <>0 then total := total * FieldByname('t3').asFloat;
          sDigits := sDigits+ SplitfieldInTodigits(IntToStr(Trunc(Round(total,0))) , 10 , 'T11');
          sDigits := sDigits +chr(13);
          {8B:_1B+_5B+_7B}
          sDigits := sDigits +',' ;
          total :=FieldByname('_1B').asFloat + FieldByname('_5B').asFloat + FieldByname('_7D').asFloat ;
          sDigits := sDigits+ SplitfieldInTodigits(IntToStr(Trunc(Round(total,0))) , 10 , '8B');
          sDigits := sDigits +chr(13);
        finally
            if active then Close;
            free;
        end;
        sALLSQL := sSQL+'~|||~{Digits}'+sDigits;

    end else  begin
      sSQL := 'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,' +
              ' CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN ,CURDATE() as DateFrom,' +
              ' CURDATE() as  DateTo ,0 as ID,"GST" as TaxCode,0.1 as TaxRate, 0.00 as INPUT_AmountEx,' +
              ' 0.00 as INPUT_AmountInc,    0.00 as OUTPUT_AmountEx,0.00 as OUTPUT_AmountInc,' +
              ' 0.00 as TotalNet,  tblbasreports.W1 as TotalTax    ' +
              ' FROM tblCompanyInformation AS CO' +
              ' Left join tblbasreports on CO.SetupID' ;
      sALLSQL := sSQL;
    end;

    PrintTemplateReport(Trim(ReportName), sALLSQL, Print,1);
  finally
    fbReportSQLSupplied := false;
  end;
end;

initialization
  RegisterClassOnce(TfmBASReturn);
  FormFact.RegisterMe(TfmBASReturn, 'TBasReturnListGUI_*=ID');
  FormFact.RegisterMe(TfmBASReturn, 'TBASTransReturnListGUI_*=ID');
end.

