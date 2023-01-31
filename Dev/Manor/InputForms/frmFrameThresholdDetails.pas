unit frmFrameThresholdDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, AdvEdit;

type
  TfrmFrameThresholdDetailsGUI = class(TBaseProcTreeEditGUI)
    edtDescription: TAdvEdit;
    Label1: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    edtWidthInches: TAdvEdit;
    Label5: TLabel;
    edtHeightInches: TAdvEdit;
    Label6: TLabel;
    Label3: TLabel;
    edtWidthMills: TAdvEdit;
    Label4: TLabel;
    Label7: TLabel;
    edtHeightMills: TAdvEdit;
    Label10: TLabel;
    edtTimberCost: TAdvEdit;
    edtCost: TAdvEdit;
    Label11: TLabel;
    Label9: TLabel;
    edtTotalCost: TAdvEdit;
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
  RegisterClassOnce(TfrmFrameThresholdDetailsGUI);
finalization
  UnregisterClass(TfrmFrameThresholdDetailsGUI);
end.
