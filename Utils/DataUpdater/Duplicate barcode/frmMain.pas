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
  result:= 'Deleting the duplicate barcodes';
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
      Script.Connection:= Conn;
      Script.Execute;
      Log('    Done!');
  end;
end;

end.
