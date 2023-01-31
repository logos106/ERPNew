unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmMainBase, DB, DBAccess, MyAccess, StdCtrls, DNMSpeedButton,
  ExtCtrls, DAScript, MyScript;

type
  TfmMain = class(TfmMainBase)
  private
  protected
    function GetDescription: string; override;
    procedure StartUpdate; override;
//    function ConnectToServer: boolean; override;
    procedure UpdateDb(const Conn: TMyConnection); override;
  public
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

{ TfmMain }

function TfmMain.GetDescription: string;
begin
  result:= 'Update for version 7424 to remove existing layout preferences for all forms and replace with new structure.';
end;

procedure TfmMain.StartUpdate;
begin
  inherited;
end;

procedure TfmMain.UpdateDb(const Conn: TMyConnection);
var
  Version: string;
begin
  if self.IsERPDatabase(Conn, Version) then begin
    inherited; {to log databse we are looking at ..}
    if Version > '7.4.2.3' then begin
      Script.Connection:= Conn;
      Script.Execute;
      Log('    Done!');
    end
    else begin
      Log('    This database is version ' + Version + ' ... this update is only for version 7.4.2.4 and above.');
    end;
  end;
end;

end.
