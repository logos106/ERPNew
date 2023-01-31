unit frmEmbroidery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, DB, DBAccess, MyAccess, ExtCtrls, DNMPanel, DNMSpeedButton,
  Grids, Wwdbigrd, Wwdbgrid, MemDS, StdCtrls, wwdblook, MessageConst,
  Shader;

type
  TEmbroideryGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    wwDBGrid1: TwwDBGrid;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryMain: TMyQuery;
    dsMain: TDataSource;
    qryMainProductName: TStringField;
    qryMainQty: TFloatField;
    qryMainPosition: TStringField;
    qryMainName: TStringField;
    qryMainDesign: TBlobField;
    qryMainStitches: TIntegerField;
    qryMainCost: TFloatField;
    qryMainMemo: TMemoField;
    qryProduct: TMyQuery;
    cboProduct: TwwDBLookupCombo;
    qryMainSaleLineID: TIntegerField;
    qryMainProductID: TIntegerField;
    qryProductProductID: TIntegerField;
    qryProductProductName: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TEmbroideryGUI }

procedure TEmbroideryGUI.PerformStartup(var Msg: TMessage);
begin
  fbTabSettingEnabled := False;
  KeyID := Msg.WParam;
  qryMain.ParamByName('SaleLineID').AsInteger := KeyID;
  qryMain.Open;
  qryProduct.Open;
  BeginTransaction;
end;

procedure TEmbroideryGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  CommitTransaction;

  if fsModal in FormState then
    ModalResult := mrOK
  else
    Release;
end;

procedure TEmbroideryGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TEmbroideryGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult in [mrNone, mrCancel] then begin
    inherited;
    RollbackTransaction;

    if fsModal in FormState then
      ModalResult := mrCancel
    else
      Action := caFree;
  end;
end;

initialization
  RegisterClassOnce(TEmbroideryGUI);
finalization
  UnRegisterClass(TEmbroideryGUI);
end.
