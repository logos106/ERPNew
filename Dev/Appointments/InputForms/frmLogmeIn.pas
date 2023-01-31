unit frmLogmeIn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseWebBrowser, OleCtrls, SHDocVw;

type
  TfmLogmeIn = class(TBaseWebBrowserGUI)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
implementation

uses CommonLib;

{$R *.dfm}
procedure TfmLogmeIn.FormShow(Sender: TObject);
begin
  inherited;
  WebBrowser.Navigate('www.Logmein.com');
end;

initialization
  RegisterClassOnce(TfmLogmeIn);

end.
