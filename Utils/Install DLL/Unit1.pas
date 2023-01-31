unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FolderDialog, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdFinger;

type
  TForm1 = class(TForm)
    FolderDialog1: TFolderDialog;
    BitBtn1: TBitBtn;
    IdFinger1: TIdFinger;
    OpenDialog1: TOpenDialog;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  OpenDialog1.Execute;
end;

end.
