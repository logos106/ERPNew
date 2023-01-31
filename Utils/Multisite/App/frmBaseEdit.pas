unit frmBaseEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, DNMSpeedButton, ExtCtrls, DNMPanel;

type
  TfmBaseEdit = class(TfmBase)
    pnlBottom: TDNMPanel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
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
