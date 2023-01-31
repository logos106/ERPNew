unit PaymentsPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 14/08/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, DataSourcePrefs, StdCtrls,
  wwdblook, ExtCtrls, DNMPanel, MessageConst, DBCtrls, wwclearbuttongroup,
  wwradiogroup, wwcheckbox, DNMSpeedButton, frmBase, Mask, AdvEdit, BasePrefs, wwdbedit, Menus,
  Grids, Wwdbigrd, Wwdbgrid, AdvScrollBox;

type
  TPaymentsPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    qryAccount: TERPQuery;
    qryAccount2: TERPQuery;
    dsPersonalPreferences: TDataSource;
    qryPersonalPreferences: TERPQuery;
    dschequeNos: TDataSource;
    QrychequeNos: TERPQuery;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    wwDBLookupCombo4: TwwDBLookupCombo;
    wwDBLookupCombo5: TwwDBLookupCombo;
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label8: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwDBLookupCombo2: TwwDBLookupCombo;
    wwDBLookupCombo3: TwwDBLookupCombo;
    btnTenderAccounts: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    Bevel3: TBevel;
    Label7: TLabel;
    lblIgnore: TLabel;
    grpOverdueDays: TwwRadioGroup;
    edtOverdueMsg: TDBMemo;
    DNMPanel4: TDNMPanel;
    Bevel4: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    wwDBLookupCombo6: TwwDBLookupCombo;
    wwDBLookupCombo7: TwwDBLookupCombo;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox5: TwwCheckBox;
    wwCheckBox6: TwwCheckBox;
    wwCheckBox7: TwwCheckBox;
    wwCheckBox8: TwwCheckBox;
    edtCustPaymentsStartNo: TAdvEdit;
    edtSuppPaymentsStartNo: TAdvEdit;
    wwCheckBox1: TwwCheckBox;
    wwDBEdit1: TwwDBEdit;
    grdlastchequeno: TwwDBGrid;
    rgCustEarlyPaymentAction: TwwRadioGroup;
    rgSuppEarlyPaymentAction: TwwRadioGroup;
    pnlapprovals: TDNMPanel;
    Bevel5: TBevel;
    Approvals: TLabel;
    chkUseApprovalLevels: TwwCheckBox;
    btnFaxSetup: TDNMSpeedButton;
    wwCheckBox2: TwwCheckBox;
    btnERPLink: TDNMSpeedButton;
    DNMPanel6: TDNMPanel;
    Bevel6: TBevel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    DNMPanel7: TDNMPanel;
    Bevel7: TBevel;
    Label21: TLabel;
    Label22: TLabel;
    wwDBEdit6: TwwDBEdit;
    pnlBankReconciliation: TDNMPanel;
    Bevel8: TBevel;
    Label23: TLabel;
    wwCheckBox4: TwwCheckBox;
    optApprovaltype: TwwRadioGroup;
    Label24: TLabel;
    memApprovaltype: TMemo;
    procedure grpOverdueDaysClick(Sender: TObject);
    procedure btnApprovalLevelsClick(Sender: TObject);
    procedure chkPOOnlyApprovedTransInSuppPaymentClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTenderAccountsClick(Sender: TObject);
    procedure grdlastchequenoCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnERPLinkClick(Sender: TObject);
    procedure optApprovaltypeClick(Sender: TObject);
  private
    fFormShown: Boolean;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

implementation

uses
   CommonDbLib, AppEnvironment, CommonLib, BusObjUtils, BusObjPayments;

{$R *.dfm}

{ TPaymentsPrefsGUI }


procedure TPaymentsPrefsGUI.grdlastchequenoCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QrychequeNos.fieldbyname('typecode').asInteger =4 then begin
    Afont.color := clWhite;
    Afont.Style := Afont.Style +[fsBold];
    if sametext(Field.Fieldname, 'type') or
       sametext(Field.Fieldname, 'ChequeLastNumber') then
      ABrush.color := clNavy;
  end;
end;



procedure TPaymentsPrefsGUI.grpOverdueDaysClick(Sender: TObject);
begin
  case grpOverdueDays.ItemIndex of
    0: edtOverdueMsg.DataField := 'ODueOk';
    1: edtOverdueMsg.DataField := 'ODue1Days';
    2: edtOverdueMsg.DataField := 'ODue7Days';
    3: edtOverdueMsg.DataField := 'ODue14Days';
    4: edtOverdueMsg.DataField := 'ODue21Days';
    5: edtOverdueMsg.DataField := 'ODue30Days';
    6: edtOverdueMsg.DataField := 'ODue60Days';
    7: edtOverdueMsg.DataField := 'ODue90Days';
    else edtOverdueMsg.DataField := '';
  end;
end;

procedure TPaymentsPrefsGUI.btnApprovalLevelsClick(Sender: TObject);
var
  Form: TForm;
begin
  Form := TForm(GetComponentByClassName('TApprovalLevelsGUI'));
  if Assigned(Form) then begin
    (*Form.FormStyle := fsMDIChild;
    Form.BringToFront;*)
    Form.Showmodal;
  end;
end;

procedure TPaymentsPrefsGUI.btnTenderAccountsClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TTenderPrefsGUI');

  if not Assigned(tmpComponent) then
    Exit;

  with TForm(tmpComponent) do begin
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TPaymentsPrefsGUI.chkPOOnlyApprovedTransInSuppPaymentClick(Sender: TObject);
begin
 // chkUseApprovalLevels.Enabled := chkPOOnlyApprovedTransInSuppPayment.Checked;
//  if fFormShown and not chkPOOnlyApprovedTransInSuppPayment.Checked and chkUseApprovalLevels.Checked then begin
//    chkUseApprovalLevels.Checked := False;
//    dsPrefs.DataSet.Edit;
//    dsPrefs.DataSet.FieldByName('UseApprovalLevels').AsBoolean := False;
//  end;
end;

procedure TPaymentsPrefsGUI.btnERPLinkClick(Sender: TObject);
begin
  inherited;
  SearchForText('ERP Link / API | EDI and Integration', 'edtErpApiPort');
end;

procedure TPaymentsPrefsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fFormShown := False;
end;
procedure TPaymentsPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);

end;

procedure TPaymentsPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
  SetupPersonalPreferences(qryPersonalPreferences, AppEnv.Employee.EmployeeID);
  grpOverdueDaysClick(Self);

  edtCustPaymentsStartNo.IntValue := TCustomerPayments.GetMaxIdNumber(dsPrefs.Connection);
  edtSuppPaymentsStartNo.IntValue := TSupplierPayments.GetMaxIdNumber(dsPrefs.Connection);
  fFormShown := True;
  rgCustEarlyPaymentAction.ItemIndex := dsPrefs.FieldByName('CustEarlyPaymentAction').AsInteger;
  rgSuppEarlyPaymentAction.ItemIndex := dsPrefs.FieldByName('SuppEarlyPaymentAction').AsInteger;

         if Appenv.Companyprefs.ApprovalType   ='S' then optApprovaltype.itemindex  := 0
    else if Appenv.Companyprefs.ApprovalType   ='A' then optApprovaltype.itemindex := 1
    else optApprovaltype.itemindex := 2;
end;
procedure TPaymentsPrefsGUI.optApprovaltypeClick(Sender: TObject);
begin
  inherited;
  case optApprovaltype.Itemindex of
    0: Appenv.Companyprefs.ApprovalType   :='S';
    1: Appenv.Companyprefs.ApprovalType   :='A';
    else Appenv.Companyprefs.ApprovalType :='M';
  end;
end;

procedure TPaymentsPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TPaymentsPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  if edtCustPaymentsStartNo.IntValue > 0 then
//    BusObjUtils.SetBusObjNextIdNo(edtCustPaymentsStartNo.IntValue, TCustomerPayments, dsPrefs.Connection);
    BusObjUtils.SetBusObjAutoIncrement(edtCustPaymentsStartNo.IntValue, TCustomerPayments, dsPrefs.Connection);

  if edtSuppPaymentsStartNo.IntValue > 0 then
//    BusObjUtils.SetBusObjNextIdNo(edtSuppPaymentsStartNo.IntValue, TSupplierPayments, dsPrefs.Connection);
    BusObjUtils.SetBusObjAutoIncrement(edtSuppPaymentsStartNo.IntValue, TSupplierPayments, dsPrefs.Connection);

  if qryPersonalPreferences.State in [dsEdit, dsInsert] then
    qryPersonalPreferences.Post;

  dsPrefs.FieldByName('CustEarlyPaymentAction').AsInteger := rgCustEarlyPaymentAction.ItemIndex;
  dsPrefs.FieldByName('SuppEarlyPaymentAction').AsInteger := rgSuppEarlyPaymentAction.ItemIndex;

  fFormShown := False;
end;
initialization
  RegisterClassOnce(TPaymentsPrefsGUI);
finalization
  UnRegisterClass(TPaymentsPrefsGUI);
end.
