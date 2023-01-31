unit frmInstallZipMaker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AbBase, AbBrowse, AbZBrows, AbZipper, AbZipKit,
  ExtCtrls;

type
  TfmInstallZipMaker = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnMakeZip: TButton;
    edtConfigFile: TEdit;
    edtZipName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ZipKit: TAbZipKit;
    memLog: TMemo;
    procedure btnMakeZipClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmInstallZipMaker: TfmInstallZipMaker;

implementation

uses
  JsonObject, AbArcTyp;

{$R *.dfm}

procedure TfmInstallZipMaker.btnMakeZipClick(Sender: TObject);
var
  jsn: TJsonObject;
  Path: string;
  idxTypes, idxItems: integer;
  item: TJsonObject;
  doneList: TStringList;
begin
  memLog.Lines.Clear;
  Path:= ExtractFilePath(Application.ExeName);
  DeleteFile(path + edtZipName.Text);
  jsn:= TJsonObject.Create;
  doneList:= TStringList.Create;
  try
    jsn.LoadFromFile(path + edtConfigFile.Text);
    ZipKit.StoreOptions := [soStripDrive,soStripPath,soRemoveDots];
    ZipKit.FileName:= path + edtZipName.Text;
    memLog.Lines.Add('Adding file: ' + edtConfigFile.Text);
    ZipKit.AddFiles(path + edtConfigFile.Text, faAnyFile);
    for idxTypes:= 0 to jsn.Count-1 do begin
      for idxItems:= 0 to jsn.Items[idxTypes].Value.AsObject.O['items'].Count -1 do begin
        item:= jsn.Items[idxTypes].Value.AsObject.O['items'].Items[idxItems].Value.AsObject;
        if doneList.IndexOf(item.S['file']) < 0 then begin
          doneList.Add(item.S['file']);
          if FileExists(path + item.S['file']) then begin
            if not item.B['external'] then begin
              memLog.Lines.Add('Adding file: ' + item.S['file']);
              ZipKit.AddFiles(path + item.S['file'], faAnyFile);
            end
            else begin
              memLog.Lines.Add('Checking External File: ' + item.S['file']);
            end;
          end
          else begin
            memLog.Lines.Add('Error - File not found: ' + item.S['file']);
          end;
        end;
      end;
    end;
    memLog.Lines.Add('Writing archive ...');
    ZipKit.CloseArchive;
    memLog.Lines.Add('Done!');
  finally
    jsn.Free;
    doneList.Free;
  end;
end;

end.
