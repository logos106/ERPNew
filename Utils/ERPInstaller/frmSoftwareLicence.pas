unit frmSoftwareLicence;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, DNMSpeedButton;

type
  TfmSoftwareLicence = class(TForm)
    pnlBottom: TPanel;
    RadioGroup1: TRadioGroup;
    Memo1: TMemo;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function AgreeToLicence: boolean;

implementation

{$R *.dfm}

function AgreeToLicence: boolean;
var
  form: TfmSoftwareLicence;
begin
  form := TfmSoftwareLicence.Create(nil);
  try
    form.ShowModal;
    result := form.RadioGroup1.ItemIndex = 1;
  finally
    form.Free;
  end;
end;


end.
