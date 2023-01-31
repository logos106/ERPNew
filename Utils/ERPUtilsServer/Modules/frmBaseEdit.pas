unit frmBaseEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, DNMSpeedButton, ExtCtrls, DNMPanel, StdCtrls, Shader;

type
  TfmBaseEdit = class(TfmBase)
    pnlBottom: TDNMPanel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    lblTitle: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmBaseEdit: TfmBaseEdit;

implementation

{$R *.dfm}

end.
