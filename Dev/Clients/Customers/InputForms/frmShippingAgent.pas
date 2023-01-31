unit frmShippingAgent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, Shader, DNMPanel, wwcheckbox, DNMSpeedButton, wwdblook, Mask,
  wwdbedit,  BusObjBase, BusObjShippingAgent, ProgressDialog;

type
  TfmShippingAgent = class(TBaseInputGUI)
    tblMain: TERPQuery;
    dscMain: TDataSource;
    tblMainGlobalref: TWideStringField;
    tblMainShippingAgentID: TLargeintField;
    tblMainCode: TWideStringField;
    tblMainDescription: TWideStringField;
    tblMainSupplierId: TLargeintField;
    tblMainSupplierName: TWideStringField;
    tblMainmstimeStamp: TDateTimeField;
    tblMainActive: TWideStringField;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    Label2: TLabel;
    edtCode: TwwDBEdit;
    Label3: TLabel;
    edtDescription: TwwDBEdit;
    lblSupplier: TLabel;
    cmdNew: TDNMSpeedButton;
    tblMainDefaultWeightUOMID: TLargeintField;
    tblMainDefaultSizeUOMID: TLargeintField;
    QryWeightUOM: TERPQuery;
    QrySizeUOM: TERPQuery;
    QryWeightUOMunitId: TIntegerField;
    QryWeightUOMunitname: TWideStringField;
    QrySizeUOMunitId: TIntegerField;
    QrySizeUOMunitname: TWideStringField;
    Label4: TLabel;
    DefaultWeightUOM: TwwDBLookupCombo;
    Label5: TLabel;
    cboDefaultsizeUOM: TwwDBLookupCombo;
    tblMainDefaultWeightUOM: TWideStringField;
    tblMainDefaultsizeUOM: TWideStringField;
    edtInsurance: TwwDBEdit;
    tblMainInsurance: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DefaultWeightUOMCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboDefaultsizeUOMCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    ShippingAgent:TShippingAgent;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    
  end;



implementation

uses CommonLib, FormFactory, BusObjConst;

{$R *.dfm}
procedure TfmShippingAgent.FormCreate(Sender: TObject);
begin
  inherited;
  ShippingAgent := TShippingAgent.Create(Self);
  ShippingAgent.Connection := TMyDacDataConnection.create(ShippingAgent);
  ShippingAgent.connection.Connection := self.MyConnection;
  ShippingAgent.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmShippingAgent.FormShow(Sender: TObject);
begin
  inherited;
  ShippingAgent.Load(KeyID);
  if ShippingAgent.count = 0 then ShippingAgent.New;
  OpenQueries;
end;  

procedure TfmShippingAgent.cmdNewClick(Sender: TObject);
begin
  inherited;
  if ShippingAgent.dirty then begin
      if not ShippingAgent.Save then exit;
      ShippingAgent.Connection.CommitTransaction;
  end;
  ShippingAgent.Connection.BeginTransaction;
  ShippingAgent.New;
  SetControlFocus(edtCode);
end;

procedure TfmShippingAgent.btnSaveClick(Sender: TObject);
begin
  inherited;
  if ShippingAgent.dirty then begin
      if not ShippingAgent.Save then exit;
  end;
  ShippingAgent.Connection.CommitTransaction;
  KeyID := ShippingAgent.Id;
  Notify(False);
  Self.Close;
end;

procedure TfmShippingAgent.btnCancelClick(Sender: TObject);
begin
  inherited;
  Notify(true);
  Self.Close;
end;

procedure TfmShippingAgent.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  ExitResult: Word;
begin
  inherited;

  if ShippingAgent.dirty then begin
    ExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0);
    case ExitResult of
    mrYes:    begin
                if not ShippingAgent.Save then begin
                  CanClose:= false;
                end else begin
                    Canclose:= true;
                end;
              end;
    mrNo:     begin
                  ShippingAgent.Connection.RollbackTransaction;
                  Canclose:= True;
              end;
    mrCancel: begin
                CanClose:= false;
              end;
    end;
  end;
end;

procedure TfmShippingAgent.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TShippingAgent then TShippingAgent(Sender).Dataset := tblMain;
    end;
end;

procedure TfmShippingAgent.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmShippingAgent.DefaultWeightUOMCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  ShippingAgent.DefaultWeightUOMID := QryWeightUOMunitId.asInteger;
end;

procedure TfmShippingAgent.cboDefaultsizeUOMCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  ShippingAgent.DefaultSizeUOMID:= QrysizeUOMunitId.asInteger;
end;

procedure TfmShippingAgent.FormDestroy(Sender: TObject);
begin
  Freeandnil(ShippingAgent);
  inherited;

end;

initialization
  RegisterClassOnce(TfmShippingAgent);
  with FormFact do
  begin
    RegisterMe(TfmShippingAgent, 'TShippingAgentGUI_*=ShippingAgentID');
    RegisterControl(TfmShippingAgent, '*_cboShippingAgent=ShippingAgentID');
  end;
end.
