unit frmFrameExtensionDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, AdvEdit;

type
  TfrmFrameExtensionDetailsGUI = class(TBaseProcTreeEditGUI)
    Label1: TLabel;
    Label2: TLabel;
    edtWidthInches: TAdvEdit;
    Label3: TLabel;
    edtWidthMills: TAdvEdit;
    Label5: TLabel;
    edtHeightInches: TAdvEdit;
    Label6: TLabel;
    edtHeightMills: TAdvEdit;
    Label7: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    edtTimberCost: TAdvEdit;
    edtCost: TAdvEdit;
    Label10: TLabel;
    Label8: TLabel;
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
  RegisterClassOnce(TfrmFrameExtensionDetailsGUI);
finalization
  UnregisterClass(TfrmFrameExtensionDetailsGUI);
end.
