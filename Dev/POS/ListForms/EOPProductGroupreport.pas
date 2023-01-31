unit EOPProductGroupreport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TEOPProductGroupreportGUI = class(TBaseListingGUI)
    qryMainsaleId: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMainColumn1: TWideStringField;
    qryMainColumn2: TWideStringField;
    qryMainColumn3: TWideStringField;
    qryMainproductname: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainLinePrice: TFloatField;
    qryMainDiscounts: TFloatField;
    qryMainDiscountPercent: TFloatField;
    qryMainMarkup: TFloatField;
    qryMainMarkupPercent: TFloatField;
    qryMainmargin: TFloatField;
    qryMainLatestCost: TFloatField;
    qryMainAvgCost: TFloatField;
    qryMainPRICE1: TFloatField;
    qryMainPRICEINC1: TFloatField;
    qryMainTotalLineAmount: TFloatField;
    qryMainTotalLineAmountInc: TFloatField;
    qryMainLineTax: TFloatField;
    qryMainmarginPercent: TFloatField;
    cbotillQry: TERPQuery;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    chkalltills: TwwCheckBox;
    cboTill: TwwDBLookupCombo;
    cbotillQrytillId: TIntegerField;
    cbotillQrytillname: TWideStringField;
    qryMainEOPDone: TWideStringField;
    procedure chkalltillsClick(Sender: TObject);
    procedure cboTillCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure FormShow(Sender: TObject);
  private
    Procedure MakeQrymain;
    function getTillIDs: String;
    procedure SingletillMode;

  Protected
    function GetReportTypeID: integer; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure MakeTemplateSQL;Override;

  public
    Property TillIDs:String read getTillIDs ;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, ProductQtyLib, LogLib, POSConst, CommonDbLib, POSLIB;

{$R *.dfm}

{ TEOPProductGroupreportGUI }

procedure TEOPProductGroupreportGUI.cboTillCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;
procedure TEOPProductGroupreportGUI.SingletillMode;
begin
  opendb(cbotillQry);
  if not chkAlltills.checked  then begin
    if GuiPrefs.Node.Exists('Options.tillId') or (DEFAULT_TILL=0) then begin
      cbotillQry.locate('tillId' , GuiPrefs.Node['Options.tillId'].asInteger, []);
    end else begin
      cbotillQry.locate('tillId' , DEFAULT_TILL, []);
    end;
    cbotill.Text := cbotillQry.fieldbyname('tillname').asString;
  end;

end;
procedure TEOPProductGroupreportGUI.WriteGuiPrefExtra;
begin
  inherited;
    GuiPrefs.Node['Options.allTills'].asBoolean := chkAllTills.checked ;
    if not chkAllTills.checked  then
      GuiPrefs.Node['Options.TillId'].asInteger := cboTillQry.fieldbyname('TillId').asInteger
    else GuiPrefs.Node['Options.TillId'].asInteger := 0;

end;

procedure TEOPProductGroupreportGUI.chkalltillsClick(Sender: TObject);
begin
  inherited;
  if not(Screen.ActiveControl =chkAlltills) then exit;
  cbotill.Enabled := not(chkAlltills.Checked);
  SingletillMode;
  RefreshQuery;
end;

procedure TEOPProductGroupreportGUI.FormShow(Sender: TObject);
begin
  inherited;
  //TimerMsg(lblDateComments  , 'This is the list of POS transactions which are to be processed in the EOP'   );
end;

function TEOPProductGroupreportGUI.GetReportTypeID: integer;
begin
  REsult := 140;
end;

function TEOPProductGroupreportGUI.getTillIDs: String;
begin
  opendb(cbotillQry);
  if chkalltills.Checked then result := cbotillQry.GroupConcat('tillId')
  else result:= cbotillQrytillId.AsString;
  if result ='' then result := '0';
end;

procedure TEOPProductGroupreportGUI.MakeQrymain;
begin
  closedb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.text := EOPProductGroupListSQL(TillIds, filterDateFrom, filterDateTo);
  clog(Qrymain.SQL.text);
  RefreshOrignalSQL(False);
end;

procedure TEOPProductGroupreportGUI.MakeTemplateSQL;
begin
  inherited;
  ReportSQLSupplied := True;
  TemplateSQL:= EOPProductGroupreportSQL(TillIds , ReportToPrint, filterDateFrom, filterDateTo);
end;

procedure TEOPProductGroupreportGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  opendb(cboTillQry);
  if GuiPrefs.Node.Exists('Options.allTills') then
        chkAllTills.checked := GuiPrefs.Node['Options.allTills'].asBoolean
  else  chkAllTills.Checked := False;
  SingleTillMode;
end;

procedure TEOPProductGroupreportGUI.RefreshQuery;
begin
  MakeQrymain;
  inherited;

end;

initialization
  RegisterClassOnce(TEOPProductGroupreportGUI);

end.
