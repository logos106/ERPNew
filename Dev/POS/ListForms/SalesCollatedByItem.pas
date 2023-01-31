unit SalesCollatedByItem;

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
  TSalesCollatedByItemGUI = class(TBaseListingGUI)
    qryMainsaleId: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainColumn1: TWideStringField;
    qryMaincolumn2: TWideStringField;
    qryMaincolumn3: TWideStringField;
    qryMainproductname: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainBaseUnitName: TWideStringField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainShipped: TFloatField;
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
    qryMainCategory: TLargeintField;
    procedure chkalltillsClick(Sender: TObject);
    procedure cboTillCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
  private
    //hideMessage :boolean;
    Procedure MakeQrymain;
    function getTillIDs: String;
    procedure SingletillMode;

  Protected
    function GetReportTypeID: integer; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure MakeTemplateSQL;Override;
    procedure RefreshTotals;Override;
    procedure SetGridColumns; Override;

  public
    Property TillIDs:String read getTillIDs ;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, ProductQtyLib, LogLib, POSConst, CommonDbLib, POSLIB,
  AppEnvironment, tcConst, Preferences;

{$R *.dfm}

{ TEOPProductGroupreportGUI }

procedure TSalesCollatedByItemGUI.cboTillCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;
procedure TSalesCollatedByItemGUI.SetGridColumns;
begin
  inherited;
   RemoveFieldfromGrid(qryMainCategory.fieldname);
end;

procedure TSalesCollatedByItemGUI.SingletillMode;
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
procedure TSalesCollatedByItemGUI.WriteGuiPrefExtra;
begin
  inherited;
    GuiPrefs.Node['Options.allTills'].asBoolean := chkAllTills.checked ;
    if not chkAllTills.checked  then
      GuiPrefs.Node['Options.TillId'].asInteger := cboTillQry.fieldbyname('TillId').asInteger
    else GuiPrefs.Node['Options.TillId'].asInteger := 0;
    //GuiPrefs.Node['Options.HideMessage'].asBoolean := hideMessage;
end;

procedure TSalesCollatedByItemGUI.chkalltillsClick(Sender: TObject);
begin
  inherited;
  if not(Screen.ActiveControl =chkAlltills) then exit;
  cbotill.Enabled := not(chkAlltills.Checked);
  SingletillMode;
  RefreshQuery;
end;

procedure TSalesCollatedByItemGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalccolumn(  qryMainTotalLineAmount.Fieldname, true);
  AddCalccolumn(  qryMainTotalLineAmountInc.Fieldname, true);
  AddCalccolumn(  qryMainLineTax.Fieldname, true);
end;

procedure TSalesCollatedByItemGUI.FormShow(Sender: TObject);
begin
  inherited;
  //TimerMsg(lblDateComments  , 'This is the list of POS transactions which are to be processed in the EOP'   );
end;

function TSalesCollatedByItemGUI.GetReportTypeID: integer;
begin
  REsult := 140;
end;

function TSalesCollatedByItemGUI.getTillIDs: String;
begin
  opendb(cbotillQry);
  if chkalltills.Checked then result := cbotillQry.GroupConcat('tillId')
  else result:= cbotillQrytillId.AsString;
  if result ='' then result := '0';
end;

procedure TSalesCollatedByItemGUI.grdMainDblClick(Sender: TObject);
begin
  if qryMainCategory.asInteger = 1 then begin
    MessageDlgXP_Vista('This is a POS Sale. Until EOP is Run, These Transactions Cannot be Viewed', mtInformation, [mbYes], 0);
    Exit;
  end;
  inherited;

end;

procedure TSalesCollatedByItemGUI.MakeQrymain;
begin
  closedb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.text := SalesCollatedByItemListSQL(TillIds, filterDateFrom, filterDateTo);
  clog(Qrymain.SQL.text);
  RefreshOrignalSQL(False);
end;

procedure TSalesCollatedByItemGUI.MakeTemplateSQL;
var
  MsgOption :Word;

function WhileSalecustomertypes:String;
begin
     Result := 'This will ONLY print the sales of Wholesale Customers  for the date range and Till(s) selected';
     if Appenv.CompanyPrefs.WholeSaleCustomerTypes = '' then Result := result +NL+NL+ 'Wholesale Customer Types are not selected in the preferences'
     else REsult := result + NL+ NL+'The Customer types Selected for Wholesale Customers are ' + Appenv.CompanyPrefs.WholeSaleCustomerTypes;
end;
function Retailcustomertypes:String;
begin
     Result := 'This will ONLY print the sales of Retail Customers  for the date range and Till(s) selected';
     if Appenv.CompanyPrefs.RetailcustomerType1 = '' then Result := result +NL+ NL+'Retail Customer Type is not selected in the preferences'
     else REsult := result + NL+ NL+'The Customer type Selected for Retail Customers is  ' + Appenv.CompanyPrefs.RetailcustomerType1;
end;
begin
  if (ReportToPrint <> '') (*and (not(hideMessage))*) then begin
      MsgOption :=0;
      if ForWholeSale(ReportToPrint) then MsgOption := MessageDlgXP_Vista(WhileSalecustomertypes, mtInformation, [] , 0 , nil , '' , '' , False , nil , 'OK,Open Preferences to Change')
      else if ForRetail(ReportToPrint)    then MsgOption := MessageDlgXP_Vista(Retailcustomertypes   , mtInformation, [] , 0 , nil , '' , '' , False , nil , 'OK,Open Preferences to Change');
      //hideMessage :=  MsgOption = 102;
      if MsgOption = 101 then OpenPrefform('Sales' ,  iif(ForWholeSale(ReportToPrint) , 'cboWholeSaleCustomerType1' , 'cboRetailcustomerType1' ), 0 , true )
  end;
  inherited;
  ReportSQLSupplied := True;
  TemplateSQL:= SalesCollatedByItemReportSQL(TillIds , ReportToPrint, filterDateFrom, filterDateTo);
  clog(TemplateSQL);
end;

procedure TSalesCollatedByItemGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  //hideMessage := False;
  opendb(cboTillQry);
  if GuiPrefs.Node.Exists('Options.allTills') then
        chkAllTills.checked := GuiPrefs.Node['Options.allTills'].asBoolean
  else  chkAllTills.Checked := False;
  SingleTillMode;
(*  if GuiPrefs.Node.Exists('Options.HideMessage') then
    hideMessage := GuiPrefs.Node['Options.HideMessage'].asBoolean*)
end;

procedure TSalesCollatedByItemGUI.RefreshQuery;
begin
  MakeQrymain;
  inherited;

end;

procedure TSalesCollatedByItemGUI.Refreshtotals;
begin
  inherited;
  Calcnshowfooter;
end;

initialization
  RegisterClassOnce(TSalesCollatedByItemGUI);

end.
