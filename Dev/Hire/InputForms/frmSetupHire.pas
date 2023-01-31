unit frmSetupHire;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SelectionDialog, Menus, ExtCtrls, StdCtrls, Shader,
  DNMPanel, DNMSpeedButton ,BaseInputForm, ProgressDialog, DB, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, ComCtrls , frmBaseSetup;

type
  TfmSetupHire = class(TfmBaseSetup)
    pnlSetupDurations: TDNMPanel;
    lblSetupDurations: TLabel;
    Label3: TLabel;
    btnDurations: TDNMPanel;
    Shader1: TShader;
    Label1: TLabel;
    btnDurationworkflow: TDNMPanel;
    Shader2: TShader;
    Label2: TLabel;
    pnlMakeAssetProduct: TDNMPanel;
    lblMakeAssetProduct: TLabel;
    label6: TLabel;
    btnAssetProductList: TDNMPanel;
    Shader3: TShader;
    Label5: TLabel;
    btnProductWorkflows: TDNMPanel;
    Shader4: TShader;
    Label9: TLabel;
    pnlPurchaseOrder: TDNMPanel;
    lblPurchaseOrder: TLabel;
    Label14: TLabel;
    btnPurchaseOrder: TDNMPanel;
    Shader9: TShader;
    Label15: TLabel;
    btnPurchaseOrderWF: TDNMPanel;
    Shader10: TShader;
    Label16: TLabel;
    pnlConvertProduct: TDNMPanel;
    lblConvertProduct: TLabel;
    Label10: TLabel;
    btnStockToAssettList: TDNMPanel;
    Shader5: TShader;
    Label7: TLabel;
    btnConvertProductHireWorkflow: TDNMPanel;
    Shader6: TShader;
    Label11: TLabel;
    pnlHire: TDNMPanel;
    lblHire: TLabel;
    Label4: TLabel;
    btnHireList: TDNMPanel;
    Shader7: TShader;
    Label8: TLabel;
    btnHireWorkflow: TDNMPanel;
    Shader8: TShader;
    Label12: TLabel;
    procedure btnDurationsClick(Sender: TObject);
    procedure btnAssetProductListClick(Sender: TObject);
    procedure btnHireProductListClick(Sender: TObject);
    procedure btnStockToAssettListClick(Sender: TObject);
    procedure btnHireListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPOClick(Sender: TObject);
    procedure btnDurationworkflowClick(Sender: TObject);
    procedure btnProductWorkflowsClick(Sender: TObject);
    procedure btnConvertProductHireWorkflowClick(Sender: TObject);
    procedure btnHireWorkflowClick(Sender: TObject);
    procedure btnPurchaseOrderClick(Sender: TObject);
  private
    procedure initPO(Sender: TObject);
  Protected
    Procedure highlightNewBtn(Sender: TObject);Override;
  public
  end;

implementation

uses CommonFormLib, BaseListingForm, ProductListExpressForm, tcConst, CommonLib,
  EquipmentListForm, frmPurchaseOrders, frmWorkflowPlay, tcDataUtils;

{$R *.dfm}
procedure TfmSetupHire.btnAssetProductListClick (Sender: TObject);begin  inherited; OpenERPListForm('TProductListExpressGUI'  , highlightNewBtn);end;
procedure TfmSetupHire.btnDurationsClick        (Sender: TObject);begin  inherited; OpenERPListForm('TDurationListGUI'        , highlightNewBtn);end;
procedure TfmSetupHire.btnStockToAssettListClick    (Sender: TObject);begin  inherited; OpenERPListForm('TStockToFixedAssetListGUI'       , highlightNewBtn);end;
procedure TfmSetupHire.btnHireListClick         (Sender: TObject);begin  inherited; OpenERPListForm('THireListGUI'            , highlightNewBtn);end;
procedure TfmSetupHire.btnHireProductListClick  (Sender: TObject);begin  inherited; OpenERPListForm('TProductListExpressGUI'  , highlightNewBtn);end;
procedure TfmSetupHire.btnPurchaseOrderClick    (Sender: TObject);begin  inherited; OpenERPForm('TPurchaseGUI',0 );end;
procedure TfmSetupHire.btnPOClick(Sender: TObject);
begin
  inherited;
  OpenErpform('TPurchaseGUI' , 0, initPO );
end;

procedure TfmSetupHire.initPO(Sender: TObject);
begin
  if sender is TPurchaseGUI then begin
    //MessageDlgXP_Vista('Please choose the supplier', mtInformation, [mbOK], 0);
    TPurchaseGUI(sender).confirmtoautoloadHireProducts := True;
  end;
end;
procedure TfmSetupHire.FormCreate(Sender: TObject);
begin
  inherited;

  InitDescLabel(pnlSetupDurations,btnDurations , btnDurationworkflow,lblSetupDurations, 'Hire Durations are Used to Define the Hire Rates for a Piece of Equipment.' +NL+
                                 'ie. To make a Duration of 2 Days, Please enter 2 in the Duration and Choose, Type ''Days''.');

  InitDescLabel(pnlMakeAssetProduct,btnAssetProductList , btnProductWorkflows,lblMakeAssetProduct,'Make a new Product for the Purchase of Items that you wish to Hire Out. '+NL+
                                 'Products can be either Inventory or Non-Inventory Products.' );

  InitDescLabel(pnlPurchaseOrder,btnPurchaseOrder ,btnPurchaseOrderWF,lblPurchaseOrder,'Create a Purchase Order to buy the Stock In.'+NL+
                              'Once Stock has been Purchased it becomes Available to eithe Sell or Convert to Hire.');

  InitDescLabel(pnlConvertProduct,btnStockToAssettList , btnConvertProductHireWorkflow,lblConvertProduct,'Here you can Select which Products you wish to Hire Out and Convert those Products to Hire Assets.');
  InitDescLabel(pnlHire,btnHireList , btnHireWorkflow,lblHire,'Here is Where you Hire Out Items and Sell Products.  ');

end;

procedure TfmSetupHire.highlightNewBtn(Sender: TObject);
begin
  inherited;
  if Sender is TBaseListingGUI then begin
    if sender is TProductListExpressGUI then begin
      if screen.ActiveControl = btnAssetProductList then begin
        TProductListExpressGUI(sender).grpExtrafilters.ItemIndex := 0;
        TBaseListingGUI(sender).ListTimerMsg( 'List is filtered for ''Inventory'' Products. Choose New to Create a New Record' , TBaseListingGUI(Sender).cmdNew );
      end;
    end else if sender is TEquipmentListGUI then begin
      TEquipmentListGUI(sender).filterString := 'OnHire =' +quotedstr('T');
      TBaseListingGUI(sender).ListTimerMsg( 'List is filtered for Equipment on Hire. Choose New to Create a New Record' , TBaseListingGUI(Sender).cmdNew );
    end;
  end;
end;

procedure TfmSetupHire.btnDurationworkflowClick           (Sender: TObject);begin  inherited;  Playworkflow(HireDurationWorkflowID)    ;end;
procedure TfmSetupHire.btnProductWorkflowsClick           (Sender: TObject);begin  inherited;  Playworkflow(HireMakeProductWorkflowID) ;end;
procedure TfmSetupHire.btnConvertProductHireWorkflowClick (Sender: TObject);begin  inherited;  Playworkflow(HireConvertProductToHireWorkflowID);end;
procedure TfmSetupHire.btnHireWorkflowClick               (Sender: TObject);begin  inherited;  Playworkflow(HireMakeHireWorkflowID);end;

initialization
  RegisterClassOnce(TfmSetupHire);

end.
