unit frmSalesExt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, wwcheckbox, wwdblook, ERPDbLookupCombo,
  ExtCtrls, DNMPanel, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, Shader, Mask, wwdbedit, DNMSpeedButton;

type
  TfmSalesExt = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    btnCompleted: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    Label1: TLabel;
    chkExtraInput: TwwCheckBox;
    edtExtraInput: TwwDBEdit;
    DNMPanel4: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnClose: TDNMSpeedButton;
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
  public
    Class function ShowIt(AOwner:TComponent):Boolean;
  end;


implementation

uses  Sales;

{$R *.dfm}

{ TfmSalesExt }

procedure TfmSalesExt.btnCloseClick(Sender: TObject);
begin
  inherited;
  closeit(False);
end;

procedure TfmSalesExt.btnCompletedClick(Sender: TObject);
begin
  inherited;
  closeit(True);
end;

class function TfmSalesExt.ShowIt(AOwner: TComponent):boolean;
var
  aform :TfmSalesExt;
begin
  result := False;
  if AOwner is TBaseSaleGUI then begin
    if TBaseSaleGUI(AOwner).SaleBase.count =0 then exit;
    aForm :=TfmSalesExt.create(AOwner);
    try
      With aform do begin
        TBaseSaleGUI(AOwner).SaleBase.PostDB;
        TitleLabel.caption := TBaseSaleGUI(AOwner).TitleLabel.caption;
        edtExtraInput.datasource :=TBaseSaleGUI(AOwner).DSMaster;
        chkExtraInput.datasource :=TBaseSaleGUI(AOwner).DSMaster;
        Setfocusedcontrol(edtExtraInput);
        color :=TBaseSaleGUI(AOwner).color;
        ShowModal;
        result := Modalresult = mrok;
        TBaseSaleGUI(AOwner).SaleBase.PostDB;
      end;
    finally
      freeandnil(aForm);
    end;
  end;
end;

end.
