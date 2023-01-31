unit frmShipContainerPopUpGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, ActnList, DNMSpeedButton,
  DNMPanel, MemDS, StdCtrls, wwdblook, Grids, Wwdbigrd, Wwdbgrid, Mask,
  wwdbedit,BusObjShippingContainer, Shader, Wwdbdlg, ImgList, ProgressDialog;

type
  TfrmShipContainerPopUp = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    ActionList: TActionList;
    actCancel: TAction;
    btnCancel: TDNMSpeedButton;
    btnAdd: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    qrySuppliers: TERPQuery;
    grdPO: TwwDBGrid;
    DSPOs: TDataSource;
    qryPOs: TERPQuery;
    qryPOsPurchaseOrderID: TIntegerField;
    qryPOsUnitOfMeasurePOLines: TWideStringField;
    qryPOsSupplierName: TWideStringField;
    qryPOsUnitOfMeasureShipped: TFloatField;
    qryPOsProductName: TWideStringField;
    qryPOsClass: TWideStringField;
    qryPOsTotalLineAmountInc: TFloatField;
    qryPOsPurchaseLineID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    Label1: TLabel;
    cboSuppliers: TwwDBLookupCombo;
    qrySuppliersClientID: TIntegerField;
    qrySuppliersCompany: TWideStringField;
    qrySuppliersSupplier: TWideStringField;
    qrySuppliersActive: TWideStringField;
    qryPOsProduct_Description: TWideStringField;
    qryCustomerLookup: TERPQuery;
    qryPOsSaleLineID: TIntegerField;
    qryPOsCustomerName: TWideStringField;
    qryPOsOrderDate: TDateField;
    qryPOsQtysold: TFloatField;
    Label3: TLabel;
    lblTotal: TLabel;
    procedure actCancelExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cboSuppliersCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryPOsAfterOpen(DataSet: TDataSet);
  private
    fSubShip:TShippingContainer;
    procedure SetSubShip(Const Value :TShippingContainer );
  Protected

  public
    property SubShip:TShippingContainer  read fSubShip write SetSubShip ;
  end;



implementation

{$R *.dfm}
uses
  CommonLib, tcConst, LogLib;

procedure TfrmShipContainerPopUp.SetSubShip(Const Value :TShippingContainer);
begin
  fSubShip := Value;
end;

procedure TfrmShipContainerPopUp.actCancelExecute(Sender: TObject);
begin
  inherited;
  ModalResult:= mrCancel;
end;

procedure TfrmShipContainerPopUp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmShipContainerPopUp.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    qrySuppliers.Open;
    //qryCustomerLookup.Open;
  finally
    EnableForm;
  end;  
end;

procedure TfrmShipContainerPopUp.qryPOsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblTotal.caption := inttostr(Dataset.recordcount);
end;

procedure TfrmShipContainerPopUp.cboSuppliersCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  if qryPOs.Active then qryPOs.Close;
  qryPOs.Params.ParamByName('xSupplierName').AsString := cboSuppliers.Text;
  qryPOs.Open;
end;

procedure TfrmShipContainerPopUp.btnAddClick(Sender: TObject);
var
  i:integer;
begin
  inherited;
  grdPO.datasource.dataset.DisableControls;
  try
    if grdPO.SelectedList.Count < 1 then begin
      CommonLib.MessageDlgXP_Vista('No lines selected.', mtInformation, [mbOK], 0);
      exit;
    end;
    clog('');
    showProgressbar(WAITMSG , grdPO.SelectedList.Count);
    try
        for i:= 0 to grdPO.SelectedList.Count-1 do begin
          grdPO.datasource.dataset.GotoBookmark(grdPO.SelectedList.items[i]);
          SubShip.ContainerDetails.New;
          SubShip.ContainerDetails.PurchaseLineID := grdPO.datasource.dataset.FieldByName('PurchaseLineID').asInteger;
          SubShip.ContainerDetails.PostDb;
          stepProgressbar(inttostr(i) +' of ' + inttostr(grdPO.SelectedList.Count));
        end;
    finally
      HideProgressbar;
    end;  
  finally
    grdPO.datasource.dataset.EnableControls;
  end;  
  if grdPO.SelectedList.Count > 0 then
    ModalResult:= mrOk
  else
    ModalResult:= mrCancel;
end;

procedure TfrmShipContainerPopUp.FormCreate(Sender: TObject);
begin
  AllowGridSorting:= True;
  inherited;

end;

initialization
  RegisterClassOnce(TfrmShipContainerPopUp);
end.
