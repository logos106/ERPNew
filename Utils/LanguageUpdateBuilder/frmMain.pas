unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, AbBase, AbBrowse, AbZBrows, AbZipper, DB,
  DBAccess, MyAccess, DADump, MyDump, ExtCtrls, ERPdbComponents;

type
  TfmMain = class(TForm)
    pcMain: TPageControl;
    tsMain: TTabSheet;
    tsConfig: TTabSheet;
    Label1: TLabel;
    edtServerName: TEdit;
    btnBuildUpdate: TButton;
    dbDump: TMyDump;
    Zipper: TAbZipper;
    memLog: TMemo;
    StatusBar: TStatusBar;
    dbConn: TERPConnection;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtServerNameChange(Sender: TObject);
    procedure btnBuildUpdateClick(Sender: TObject);
    procedure dbDumpBackupProgress(Sender: TObject; ObjectName: string;
      ObjectNum, ObjectCount, Percent: Integer);
  private
    path: string;
    procedure Log(msg: string);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  AppVarsObj, DbConst, CipherUtils;

procedure TfmMain.btnBuildUpdateClick(Sender: TObject);
var
  zipFileName: string;
begin
  Log('Started language export ...');
  dbConn.Port:= SERVER_PORT;
  dbConn.Database:= LANGUAGE_DATABASE;
  dbConn.Username:= SYSDB_USER;
  dbConn.Password:= SYSDB_PASS;
  dbConn.Server:= edtServerName.Text;
  dbConn.LoginPrompt:= false;
  //dbConn.Options.Charset:= 'utf8';
  dbConn.Options.UseUnicode := true;
  dbConn.Options.Compress:= MYDAC_OPTIONS_COMPRESS;
  dbConn.Options.Protocol:= MYDAC_OPTIONS_PROTOCOL;
  try
    dbConn.Connect;
    dbDump.Connection:= dbConn;
    dbDump.TableNames:=  'inenglish,languages,languagetranslation,helptreeurls';
    dbDump.Options.AddDrop:= true;
    Log('Exporting data ..');
    dbDump.BackupToFile(path + 'language.sql');
    StatusBar.SimpleText:= '';
  finally
    dbConn.Disconnect;
  end;
  if FileExists(path + 'language.sql') then begin
    Log('Zipping data ..');
    DeleteFile(path + 'language.zip');
    zipFileName:= path + 'language' + FormatDateTime('dd-mm-yyyy_hh-nn-ss',now) + '.zip';
    Zipper.BaseDirectory:= path;
    Zipper.FileName:= zipFileName; //path + 'helptree.zip';
    Zipper.AddFilesEx(path + 'language.sql', '',0);
    Zipper.Save;
    Zipper.CloseArchive;
    Log('Encrypting data ..');
    Encrypt(zipFileName, path + 'language.dat');
    DeleteFile(path + 'language.sql');
    DeleteFile(path + 'language.zip');
  end;
  Log('Export complete.');
end;

procedure TfmMain.dbDumpBackupProgress(Sender: TObject; ObjectName: string;
  ObjectNum, ObjectCount, Percent: Integer);
begin
  StatusBar.SimpleText:=
    'Backing up .. ' + ObjectName + ' ' + IntToStr(ObjectNum + 1) +
      ' of ' + IntToStr(ObjectCount) + ' ' + IntToStr(Percent) + '%';
  StatusBar.Refresh;
end;

procedure TfmMain.edtServerNameChange(Sender: TObject);
begin
  AppVars['Server']:= edtServerName.Text;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  path:= ExtractFilePath(Application.ExeName);
  AppVars:= TAppVars.Create;
  AppVars.LoadFromFile();
  AppVars.SetDefault('Server','localhost');
  edtServerName.Text:= AppVars['Server'];
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  if AppVars.Dirty then
    AppVars.SaveToFile();
  AppVars.Free;
end;

procedure TfmMain.Log(msg: string);
begin
  memLog.Lines.Add(msg);
end;

end.
