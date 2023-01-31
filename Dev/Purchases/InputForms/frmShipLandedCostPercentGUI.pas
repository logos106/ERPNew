unit frmShipLandedCostPercentGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls,BusObjShippingContainer,
  StdCtrls, Mask, wwdbedit, Shader, DNMPanel, DNMSpeedButton, MemDS, Grids,
  Wwdbigrd, Wwdbgrid, ImgList, ProgressDialog;

type
  TfrmShipLandedCostPercent = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DSShip: TDataSource;
    wwDBGrid1: TwwDBGrid;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fSubShip:TShippingContainer;
    procedure SetSubShip(Const Value :TShippingContainer );
  public
    property SubShip:TShippingContainer  read fSubShip write SetSubShip ;
  end;  


implementation

{$R *.dfm}
uses
  CommonLib,tcDataUtils;


procedure TfrmShipLandedCostPercent.btnSaveClick(Sender: TObject);
begin
  inherited;
  if SubShip.ContainerDetails.UserDataError then begin
    CommonLib.MessageDlgXP_Vista('The Amount entered has increased the total to more than the imported costs.', mtWarning, [mbOK], 0);
    exit;
  end else ModalResult := mrOK;
end;

procedure TfrmShipLandedCostPercent.SetSubShip(Const Value :TShippingContainer);
begin
  fSubShip := Value;
end;

procedure TfrmShipLandedCostPercent.btnCancelClick(Sender: TObject);
begin
  inherited;
  if SubShip.ContainerDetails.UserDataError then begin
    CommonLib.MessageDlgXP_Vista('The Amounts must be adjusted so that the total is not greater than the imported costs.', mtWarning, [mbOK], 0);
    exit;
   end else ModalResult := mrCancel;
end;

procedure TfrmShipLandedCostPercent.FormShow(Sender: TObject);
var
  fld: TField;
  ffmtPerc: String;
begin
  DisableForm;
  try
    inherited;
    ffmtPerc := '##0.00 %;(''##0.00 %)';
    if DSShip.DataSet.Active then begin
      fld:= DSShip.DataSet.FindField('AuxilaryCostsPercentage');
      if Assigned(fld) then TFloatField(fld).DisplayFormat:= ffmtPerc;
    end;
  finally
    EnableForm;
  end;  
end;

initialization
  RegisterClassOnce(TfrmShipLandedCostPercent);
end.
