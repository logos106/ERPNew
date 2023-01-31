unit PurchasesPrefs;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 31/07/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, wwdbedit, wwdblook, DB, DataSourcePrefs,
  DBAccess, MyAccess,ERPdbComponents, wwcheckbox, ExtCtrls, DNMPanel, DNMSpeedButton, MemDS,
  MessageConst, frmBase, AdvEdit, BasePrefs, Wwdotdot, Wwdbcomb,
  wwclearbuttongroup, wwradiogroup, Menus, ERPDbLookupCombo, AdvScrollBox;

type
  TPurchasesPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    MyConnection: TERPConnection;
    dsPrefs: TDataSourcePrefs;
    qryAccount: TERPQuery;
    qryPayMethod: TERPQuery;
    qryAccUnInvPO: TERPQuery;
    qryAccExp: TERPQuery;
    QryPOStoreawaytempl: TERPQuery;
    QryPOStoreawaytemplTemplname: TWideStringField;
    DNMPanel5: TDNMPanel;
    Bevel5: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cboDutiesAccount: TwwDBLookupCombo;
    cboBrokerHandlingAccount: TwwDBLookupCombo;
    DNMPanel6: TDNMPanel;
    Bevel6: TBevel;
    Label5: TLabel;
    wwCheckBox12: TwwCheckBox;
    wwCheckBox13: TwwCheckBox;
    wwCheckBox18: TwwCheckBox;
    wwCheckBox32: TwwCheckBox;
    wwCheckBox33: TwwCheckBox;
    wwCheckBox34: TwwCheckBox;
    wwCheckBox35: TwwCheckBox;
    chkDisableAltSaveCost: TwwCheckBox;
    wwCheckBox36: TwwCheckBox;
    wwCheckBox37: TwwCheckBox;
    wwRadioGroup2: TwwRadioGroup;
    wwCheckBox21: TwwCheckBox;
    chkAutoAppendBatchNumber: TwwCheckBox;
    chkDisablePurchaseLineZeroQuantityWarning: TwwCheckBox;
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Bevel7: TBevel;
    lblFuturePurchaseOrders1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    wwCheckBox1: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox5: TwwCheckBox;
    wwCheckBox6: TwwCheckBox;
    wwCheckBox7: TwwCheckBox;
    wwCheckBox8: TwwCheckBox;
    wwCheckBox9: TwwCheckBox;
    wwCheckBox10: TwwCheckBox;
    cboUnInvoicedSOAccount: TwwDBLookupCombo;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwCheckBox11: TwwCheckBox;
    wwCheckBox15: TwwCheckBox;
    edtPurchasesStartNum: TAdvEdit;
    wwCheckBox14: TwwCheckBox;
    wwCheckBox16: TwwCheckBox;
    wwCheckBox17: TwwCheckBox;
    cboStatus: TwwDBComboBox;
    wwRadioGroup1: TwwRadioGroup;
    wwCheckBox19: TwwCheckBox;
    wwCheckBox20: TwwCheckBox;
    wwCheckBox22: TwwCheckBox;
    wwCheckBox23: TwwCheckBox;
    wwCheckBox24: TwwCheckBox;
    wwCheckBox25: TwwCheckBox;
    chkUseFuturePurchaseOrders: TwwCheckBox;
    edtFuturePurchaseOrdersDays: TwwDBEdit;
    cboSalesBackorderCheckType: TwwDBComboBox;
    wwCheckBox38: TwwCheckBox;
    cboPOStoreAwayTemplate: TwwDBLookupCombo;
    DNMPanel3: TDNMPanel;
    Bevel3: TBevel;
    Label13: TLabel;
    lbleta4_1: TLabel;
    chkPOMatchLineETAToHeaderETA: TwwCheckBox;
    chkPOMatchLineETAToShippingContainerETA: TwwCheckBox;
    chkPOMatchHeaderETAToLineETA: TwwCheckBox;
    wwCheckBox26: TwwCheckBox;
    DNMPanel4: TDNMPanel;
    Bevel4: TBevel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwCheckBox4: TwwCheckBox;
    optTotalvolumeUOMInsmartOrder: TwwRadioGroup;
    wwDBEdit2: TwwDBEdit;
    wwCheckBox27: TwwCheckBox;
    wwCheckBox28: TwwCheckBox;
    wwCheckBox29: TwwCheckBox;
    wwCheckBox30: TwwCheckBox;
    chkDefaultNotifyPurchaseOrderChange: TwwCheckBox;
    wwCheckBox31: TwwCheckBox;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    lblPOHasPeriodPosting: TLabel;
    chkIncludeUnInvoicedPOtoGL: TwwCheckBox;
    wwDBLookupCombo2: TwwDBLookupCombo;
    chkPOHasPeriodPosting: TwwCheckBox;
    wwRadioGroup3: TwwRadioGroup;
    chkCustFirstAndLastNamesRequired: TwwCheckBox;
    procedure dsPrefsDataChange(Sender: TObject; Field: TField);
    procedure cboDutiesAccountNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure chkDisableAltSaveCostClick(Sender: TObject);
    procedure chkUseFuturePurchaseOrdersClick(Sender: TObject);
    procedure cboPOStoreAwayTemplateEnter(Sender: TObject);
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure initCOA(Sender: TObject);
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, CommonDbLib, BusObjUtils, BusObjOrders, tcConst, CommonFormLib,
  frmChartOfAccountsFrm;

{$R *.dfm}



procedure TPurchasesPrefsGUI.cboPOStoreAwayTemplateEnter(Sender: TObject);
begin
  inherited;
  opendb(TERPQuery(cboPOStoreAwayTemplate.lookuptable));
end;

procedure TPurchasesPrefsGUI.cboDutiesAccountNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if NewValue <> '' then begin
    if MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      comboNewValue := NewValue;
      try
        OpenERPFormModal('TfrmChartOfAccounts' , 0, initCOA, true , nil) ;
        closedb(TwwDBLookupCombo(Sender).Lookuptable);
        opendb(TwwDBLookupCombo(Sender).Lookuptable);
        if TwwDBLookupCombo(Sender).Lookuptable.Locate('accountname' , comboNewValue , []) then
          TwwDBLookupCombo(Sender).Text := comboNewValue;
      finally
        comboNewValue:= '';
      end;
    end;
  end;
end;
procedure TPurchasesPrefsGUI.initCOA(Sender: TObject);
begin
  if Sender is  TfrmChartOfAccounts then
    TfrmChartOfAccounts(Sender).keystring :=  comboNewValue;
end;
procedure TPurchasesPrefsGUI.chkDisableAltSaveCostClick(Sender: TObject);
begin
  inherited;
  if Screen.activecontrol = chkDisableAltSaveCost then MessageDlgXP_Vista(chkDisableAltSaveCost.Hint, mtWarning, [mbOK], 0);
end;

procedure TPurchasesPrefsGUI.chkUseFuturePurchaseOrdersClick(Sender: TObject);
begin
  inherited;
  edtFuturePurchaseOrdersDays.Enabled := chkUseFuturePurchaseOrders.Checked;
  lblFuturePurchaseOrders1.Enabled := chkUseFuturePurchaseOrders.Checked;
  //lblFuturePurchaseOrders.Enabled := chkUseFuturePurchaseOrders.Checked;
end;

procedure TPurchasesPrefsGUI.dsPrefsDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  cboStatus.Items.CommaText:= RALineStatusCommaText;
  cboStatus.Items.Add('');
//  cboStatus.Datasource:= dsPrefs;
end;


procedure TPurchasesPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;
procedure TPurchasesPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
  showcontrolhint(chkPOMatchLineETAToHeaderETA ,  'When checked -'+NL+'    Changing ''ETA Date'' in the header, will change its lines'' ''ETA Date'' as the Header''s ''ETA Date'' ');
  showcontrolhint(chkPOMatchHeaderETAToLineETA ,  'When checked -'+NL+'    Changing ''ETA Date'' in any Lines of a purhcase order , will change its Header''s '' ''ETA Date'' as the smallest ''ETA Date'' of its lines ');
  showcontrolhint(chkPOMatchLineETAToShippingContainerETA ,  'When checked -'+NL+'    Changing ''ETA Date'' in  Shipping Container will change the Purchase Order Lines'' ''ETA Date''.' + NL +
                                    '    If first option ' +Quotedstr(chkPOMatchLineETAToHeaderETA.caption)+' is checked, will update its Header''s '' ''ETA Date'' as the smallest ''ETA Date'' of its lines as well.');

  edtFuturePurchaseOrdersDays.Enabled := chkUseFuturePurchaseOrders.Checked;
  lblFuturePurchaseOrders1.Enabled := chkUseFuturePurchaseOrders.Checked;
  //lblFuturePurchaseOrders.Enabled := chkUseFuturePurchaseOrders.Checked;

  showcontrolhint(chkDisableAltSaveCost , 'When not Checked, a User confirmation will be Taken Before Updating the Product Cost.' + NL +
                                        'Product Cost will only be Updated if "On Purchase, Update Product Cost With Purchase Cost" is Selected in the Product Card->Miscellaneous->General'+NL);
  //showcontrolhint(lblDisableAltSaveCost , chkDisableAltSaveCost.Hint);
end;
procedure TPurchasesPrefsGUI.PerformFinish(var Msg: TMessage);
begin
DoPrefformFinish(msg);
end;
procedure TPurchasesPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  if edtPurchasesStartNum.IntValue > 0 then
    BusObjUtils.SetBusObjNextIdNo(edtPurchasesStartNum.IntValue, TPurchaseOrder, TMyConnection(qryAccount.Connection));
end;
initialization
  RegisterClassOnce(TPurchasesPrefsGUI);
finalization
  UnRegisterClass(TPurchasesPrefsGUI);
end.
