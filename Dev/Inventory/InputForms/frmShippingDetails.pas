unit frmShippingDetails;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/11/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, DB,
  DBAccess, MyAccess,ERPdbComponents, ExtCtrls, DNMSpeedButton, StdCtrls, Mask, wwdbedit,
  DNMPanel, MemDS, MessageConst, DBCtrls, wwdblook, Shader, ImgList;

type
  TShippingDetailsGUI = class(TBaseInputGUI)
    Label1: TLabel;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    Label2: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryMain: TERPQuery;
    qryMainShippingDetailsID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainCourierCompany: TWideStringField;
    qryMainConsignmentNumber: TWideStringField;
    qryMainBoxNumber: TIntegerField;
    qryMainActive: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    dsMain: TDataSource;
    Bevel1: TBevel;
    qrySales: TERPQuery;
    qrySalesShipping: TWideStringField;
    qryMainDateTime: TDateTimeField;
    Label3: TLabel;
    cboCourierCompany: TwwDBLookupCombo;
    qryShippingMethod: TERPQuery;
    qryShippingMethodShippingMethodID: TIntegerField;
    qryShippingMethodShippingMethod: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TShippingDetailsGUI.PerformStartup(var Msg: TMessage);
var
  SaleID: Integer;
begin
  SaleID := Msg.WParam;
  qryMain.ParamByName('SaleID').AsInteger := SaleID;
  qrySales.ParamByName('SaleID').AsInteger := SaleID;
  BeginTransaction;
  qryMain.Open;

  if qryMain.IsEmpty then
    qryMain.Append
  else
    qryMain.Edit;  

  qrySales.Open;
  qryShippingMethod.Open;

  if not qrySales.IsEmpty then begin
    qryMain.FieldByName('SaleID').AsInteger := SaleID;

    if qryMain.FieldByName('CourierCompany').AsString = '' then
      qryMain.FieldByName('CourierCompany').AsString := qrySales.FieldByName('Shipping').AsString;
  end;
end;

procedure TShippingDetailsGUI.btnSaveClick(Sender: TObject);
begin
  inherited;

  if not (qryMain.State in [dsEdit, dsInsert]) then
    qryMain.Edit;

  qryMain.FieldByName('DateTime').AsDateTime := Now;
  qryMain.Post;
  CommitTransaction;

  if fsModal in FormState then begin
    Tag := qryMain.FieldByName('BoxNumber').AsInteger;
    ModalResult := mrOK;
  end
  else
    Release;
end;

procedure TShippingDetailsGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if ModalResult in [mrNone, mrCancel] then begin
    RollbackTransaction;

    if fsModal in FormState then
      ModalResult := mrCancel
    else
      Action := caFree;
  end;
end;

procedure TShippingDetailsGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

initialization
  RegisterClassOnce(TShippingDetailsGUI);
finalization
  UnRegisterClass(TShippingDetailsGUI);
end.
