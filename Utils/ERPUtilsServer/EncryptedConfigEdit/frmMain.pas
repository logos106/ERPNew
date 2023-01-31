unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmMain = class(TForm)
    Panel1: TPanel;
    memEdit: TMemo;
    btnOpen: TButton;
    btnSave: TButton;
    OpenDialog: TOpenDialog;
    procedure btnOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure memEditChange(Sender: TObject);
  private
    FileName: string;
    SavedCaption: string;
    Dirty: boolean;
    procedure SaveFile;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  JsonObjectUtils, CipherUtils;

procedure TfmMain.btnOpenClick(Sender: TObject);
var
  InStream: TFileStream;
  OutStream: TMemoryStream;
begin
  if OpenDialog.Execute then begin
    FileName:= OpenDialog.FileName;
    Caption:= SavedCaption + ' [' + FileName + ']';
    InStream:= TFileStream.Create(FileName, fmOpenRead);
    OutStream:= TMemoryStream.Create;
    try
      CipherUtils.Decrypt(InStream, OutStream);
      OutStream.Position:= 0;
      memEdit.Lines.LoadFromStream(OutStream);
    finally
      InStream.Free;
      OutStream.Free;
    end;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  SavedCaption:= Caption;
  FileName:= '';
  Dirty:= false;
end;

procedure TfmMain.btnSaveClick(Sender: TObject);
begin
  SaveFile;
end;

procedure TfmMain.SaveFile;
var
  InStream: TMemoryStream;
  OutStream: TFileStream;
begin
  if FileName <> '' then begin
    InStream:= TMemoryStream.Create;
    OutStream:= TFileStream.Create(FileName, fmOpenWrite);
    try
      memEdit.Lines.SaveToStream(InStream);
      InStream.Position:= 0;
      CipherUtils.Encrypt(InStream, OutStream);
      Dirty:= false;
    finally
      InStream.Free;
      OutStream.Free;
    end;
  end;
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:= true;
  if Dirty and (FileName <> '') then begin
    case MessageDlg('Do you want to save your changes?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
      mrYes: SaveFile;
      mrNo:;
      mrCancel: CanClose:= false;
    end;
  end;
end;

procedure TfmMain.memEditChange(Sender: TObject);
begin
  Dirty:= true;
end;

end.
