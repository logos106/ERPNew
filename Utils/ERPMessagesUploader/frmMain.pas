unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JsonObject, ComCtrls, AbBase, AbBrowse, AbZBrows,
  AbZipper, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP;

type
  TfmMain = class(TForm)
    pnlTop: TPanel;
    memLog: TMemo;
    Label1: TLabel;
    edtServer: TEdit;
    Label2: TLabel;
    edtDatabase: TEdit;
    btnUploadUpdates: TButton;
    StatusBar: TStatusBar;
    Zipper: TAbZipper;
    FtpClient: TIdFTP;
    IdAntiFreeze1: TIdAntiFreeze;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtServerChange(Sender: TObject);
    procedure edtDatabaseChange(Sender: TObject);
    procedure btnUploadUpdatesClick(Sender: TObject);
  private
    Config: TJsonObject;
    ConfigFileName: string;
    DataPath: string;
    procedure LoadConfig;
    procedure SaveConfig;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses
  MyAccess, MySQLUtils, IntegerListObj, CipherUtils, UpdaterConst;

const
  records_per_file = 1000;
  WebSiteAddress: String  = 'ftp.trueerp.com';
  WebSiteUser: String  = 'terpcom@trueerp.com';
  WebSitePassword: String  = 'Be!!aS@mm1';

{$R *.dfm}

procedure TfmMain.btnUploadUpdatesClick(Sender: TObject);
var
  conn: TMyConnection;
  qry: TMyQuery;
  fileId: integer;
  IdList: TIntegerList;
  json, subJson: TJsonObject;
  lastId: integer;
  currentCount: integer;
  x: integer;
  zipFileName: string;
begin
  memLog.Lines.Add('Started');
  IdList := TIntegerList.Create;
  json := JO;
  try
    fileId := 1;
    lastId := 0;
    currentCount := 0;
    while FileExists(dataPath + 'messages_' + IntToStr(fileId+1) + '.txt') do
      Inc(fileId);
    if FileExists(dataPath + 'messages_' + IntToStr(fileId) + '.txt') then begin
      json.LoadFromFile(dataPath + 'messages_' + IntToStr(fileId) + '.txt');
      currentCount := json.A['list'].Count;
      lastId := json.A['list'].Items[currentCount -1].AsObject.I['Id'];
      memLog.Lines.Add('Opening existing file: ' + dataPath + 'messages_' + IntToStr(fileId) + '.txt');
    end;

    conn := TMyConnection.Create(nil);
    qry := TMyQuery.Create(nil);
    try
      SetConnectionProps(conn, Config.S['Database'], Config.S['Server']);
      qry.Connection := conn;
      qry.SQL.Add('select ID, VersionNo, CreatedOn, Subject, Details');
      qry.SQL.Add('from tblTasks where TaskType = "Feature"');
      qry.SQL.Add('and Id > ' + IntToStr(lastID));
      qry.SQL.Add('order by ID ASC');
      qry.Open;
      memLog.Lines.Add('Found ' + IntToStr(qry.RecordCount) + ' records to process');
      while not qry.Eof do begin
        StatusBar.Panels[0].Text := 'Processing ' + IntToStr(qry.RecNo) + ' of ' + IntToStr(qry.RecordCount);
        subJson := JO;
        subJson.I['ID'] := qry.FieldByName('ID').AsInteger;
        subJson.S['VersionNo'] := qry.FieldByName('VersionNo').AsString;
        subJson.DT['CreatedOn'] := qry.FieldByName('CreatedOn').AsDateTime;
        subJson.S['Subject'] := qry.FieldByName('Subject').AsString;
        subJson.S['Details'] := qry.FieldByName('Details').AsString;

        json.A['list'].Add(subJson);
        Inc(currentCount);
        if currentCount >= records_per_file then begin
          json.SaveToFile(dataPath + 'messages_' + IntToStr(fileId) + '.txt');
          memLog.Lines.Add('Finished file: ' + dataPath + 'messages_' + IntToStr(fileId) + '.txt');
          IdList.Add(fileId);
          Inc(fileId);
          json.Clear;
          currentCount := 1;
        end;
        qry.Next;
      end;
      if not qry.IsEmpty then begin
        json.SaveToFile(dataPath + 'messages_' + IntToStr(fileId) + '.txt');
        memLog.Lines.Add('Saved file: ' + dataPath + 'messages_' + IntToStr(fileId) + '.txt');
        IdList.AddIfNotInList(fileId);
      end;

      if IdList.Count > 0 then begin
        for x := 0 to IdList.Count -1 do begin
          memLog.Lines.Add('Zipping file ' + dataPath + 'messages_' + IntToStr(IdList[x]) + ' ..');
//          DeleteFile(path + 'language.zip');
          zipFileName:= dataPath + 'messages_' + IntToStr(IdList[x]) +  '.zip';
          Zipper.BaseDirectory:= dataPath;
          Zipper.FileName:= zipFileName; //path + 'helptree.zip';
          Zipper.AddFilesEx(dataPath + 'messages_' + IntToStr(IdList[x]) +  '.txt', '',0);
          Zipper.Save;
          Zipper.CloseArchive;
          memLog.Lines.Add('Encrypting data ..');
          Encrypt(zipFileName, dataPath + 'messages_' + IntToStr(IdList[x]) +  '.dat');
          memLog.Lines.Add('Uploading file ..');
          if not FtpClient.Connected then begin
            FtpClient.Username := WebSiteUser;
            FtpClient.Password := WebSitePassword;
            FtpClient.Host := WebSiteAddress;
            FtpClient.Connect;
          end;

          FtpClient.Put(dataPath + 'messages_' + IntToStr(IdList[x]) +  '.dat', '/public_html/erp_updates/server/custom/messages/' + 'messages_' + IntToStr(IdList[x]) +  '.dat');
          DeleteFile(dataPath + 'messages_' + IntToStr(IdList[x]) +  '.dat');
          DeleteFile(zipFileName);
        end;

      end;




      memLog.Lines.Add('Finished');
      StatusBar.Panels[0].Text := 'Finished';


    finally
      qry.Free;
      conn.Free;
    end;
  finally
    json.Free;
    IdList.Free;
    FtpClient.Disconnect;
  end;
end;

procedure TfmMain.edtDatabaseChange(Sender: TObject);
begin
  if not TEdit(Sender).Focused then exit;
  Config.S['Database'] := edtDatabase.Text;
  SaveConfig;
end;

procedure TfmMain.edtServerChange(Sender: TObject);
begin
  if not TEdit(Sender).Focused then exit;
  Config.S['Server'] := edtServer.Text;
  SaveConfig;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Config := JO;
  ConfigFileName := ChangeFileExt(Application.ExeName,'_config.cfg');
  LoadConfig;
  if Config.Count = 0 then begin
    Config.S['Server'] := 'ERPServer1';
    Config.S['Database'] := 'madeurne_pty_ltd';
    SaveConfig;
  end;
  edtServer.Text := Config.S['Server'];
  edtDatabase.Text := Config.S['Database'];
  DataPath := ExtractFilePath(Application.ExeName) + 'Data\';
  ForceDirectories(DataPath);
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  Config.Free;
end;

procedure TfmMain.LoadConfig;
begin
  Config.LoadFromFile(ConfigFileName);
end;

procedure TfmMain.SaveConfig;
begin
  Config.SaveToFile(ConfigFileName);
end;

end.
