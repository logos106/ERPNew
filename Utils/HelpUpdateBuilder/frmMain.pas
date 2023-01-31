unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DADump, MyDump, DB, DBAccess, MyAccess,
  ExtCtrls, AbBase, AbBrowse, AbZBrows, AbZipper;

type
  TfmMain = class(TForm)
    PageControl: TPageControl;
    Main: TTabSheet;
    Config: TTabSheet;
    Label1: TLabel;
    edtServer: TEdit;
    Label2: TLabel;
    edtPort: TEdit;
    pnlBottom: TPanel;
    btnExport: TButton;
    dbConn: TMyConnection;
    dbDump: TMyDump;
    Zipper: TAbZipper;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtServerChange(Sender: TObject);
    procedure edtPortChange(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  AppVarsObj, DbConst, CipherUtils;

const
  HelpDatabase = 'apphelp';


procedure TfmMain.FormCreate(Sender: TObject);
begin
  inherited;
  AppVars:= TAppVars.Create;
  AppVars.LoadFromFile();
  AppVars.SetDefault('Server','localhost');
  AppVars.SetDefault('Port', '3309');
  edtServer.Text:= AppVars['Server'];
  edtPort.Text:= AppVars['Port'];
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  if AppVars.Dirty then
    AppVars.SaveToFile();
  AppVars.Free;
  inherited;
end;

procedure TfmMain.edtServerChange(Sender: TObject);
begin
  AppVars['Server']:= edtServer.Text;
end;

procedure TfmMain.edtPortChange(Sender: TObject);
begin
  AppVars['Port']:= edtport.Text;
end;

procedure TfmMain.btnExportClick(Sender: TObject);
var
  cmd: TMyCommand;
  path: string;
  zipFileName: string;
begin
  path:= ExtractFilePath(Application.ExeName);
  try
    dbConn.Server:= AppVars['Server'];
    dbConn.Port:= AppVars.IntVar['Port'];
    dbConn.Database:= HelpDatabase;
    dbConn.Username:= SYSDB_USER;
    dbConn.Password:= SYSDB_PASS;
    dbConn.LoginPrompt:= false;
    try
      dbConn.Connect;
    except
      on E: exception do begin
        ShowMessage('Error connecting to database with message: ' + E.Message);
        exit;
      end;
    end;
    cmd:= TMyCommand.Create(nil);
    try
      cmd.Connection:= dbConn;
      cmd.SQL.Add('update helptree set NotesUpdateTimeStamp = TIMESTAMP("1970-01-02")');
      cmd.SQL.Add('where ISNULL(NotesUpdateTimeStamp) or (NotesUpdateTimeStamp = 0)');
      cmd.Execute;

    finally
      cmd.Free;
    end;


    dbDump.Connection:= dbConn;
    dbDump.TableNames:= 'helptree';
    dbDump.Options.CompleteInsert:= false;
    dbDump.Options.AddDrop:= false;
    dbDump.Options.GenerateHeader:= false;
    dbDump.Options.AddLock:= false;

    dbDump.Objects:= [doData];
    
    dbDump.BackupToFile(path + 'helptree.sql');

  finally
    if dbConn.Connected then
      dbConn.Disconnect;
  end;
  if FileExists('helptree.sql') then begin
    DeleteFile('helptree.zip');
    zipFileName:= path + 'helptree' + FormatDateTime('dd-mm-yyyy_hh-nn-ss',now) + '.zip';
    Zipper.BaseDirectory:= path;
    Zipper.FileName:= zipFileName; //path + 'helptree.zip';
    Zipper.AddFilesEx('helptree.sql', '',0);
    Zipper.Save;
    Zipper.CloseArchive;
    Encrypt(zipFileName, path + 'helptree.dat');
    DeleteFile(path + 'helptree.sql');
    DeleteFile(path + 'helptree.zip');
    ShowMessage('Generated Help Update File: ' + path + 'helptree.dat');
  end;
end;

end.
