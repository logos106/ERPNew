unit frmConfigClientLicenceServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmConfigBase, ExtCtrls;

type
  TfmConfigClientLicenceServer = class(TfmConfigBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmConfigClientLicenceServer: TfmConfigClientLicenceServer;

implementation

{$R *.dfm}

initialization
  RegisterClass(TfmConfigClientLicenceServer);

end.
