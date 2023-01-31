unit frmFrameFanLightDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, StdCtrls, wwclearbuttongroup, wwradiogroup,
  AppEvnts, ExtCtrls, DNMSpeedButton, Shader, AdvEdit;

type
  TfrmFrameFanLightDetailsGUI = class(TBaseProcTreeEditGUI)
    rdgBeads: TwwRadioGroup;
    rdgSupplyAndFit: TwwRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    edtBeadWidth: TAdvEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtWebThickness: TAdvEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtTimberCost: TAdvEdit;
    edtBeadingCost: TAdvEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtPanelCost: TAdvEdit;
    Label9: TLabel;
    memPanelDesiption: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib;

{$R *.dfm}

initialization
  RegisterClassOnce(TfrmFrameFanLightDetailsGUI);
finalization
  UnregisterClass(TfrmFrameFanLightDetailsGUI);
end.
