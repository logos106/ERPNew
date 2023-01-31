unit frmMainBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DNMSpeedButton, ExtCtrls, DB, DBAccess, MyAccess,
  DAScript, MyScript;

type
  TfmMainBase = class(TForm)
    Panel1: TPanel;
    pnlBottom: TPanel;
    btnStartUpdate: TDNMSpeedButton;
    pnlLeft: TPanel;
    pnlRight: TPanel;
    Label1: TLabel;
    lblDescription: TLabel;
    memLog: TMemo;
    DbConn: TMyConnection;
    Script: TMyScript;
    procedure btnStartUpdateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    DbList: TStringList;
    procedure PopulateDbList;
  protected
    function GetDescription: string; virtual;
    procedure StartUpdate; virtual;
    function ConnectToServer: boolean; virtual;
    procedure UpdateDb(const Conn: TMyConnection); virtual;

    procedure Log(const msg: string);
    procedure ClearLog;
    function UsersInMysql: Integer;
    procedure ConnectAndUpdate;
    function TablesCount(Const DBConnection: TMyConnection): Integer;
    function IsERPDatabase(const Conn: TMyConnection; var Version: string): boolean;
  public
    { Public declarations }
  end;

var
  fmMainBase: TfmMainBase;

implementation

{$R *.dfm}

uses
  MyClasses;

{ TfmMain }

procedure TfmMainBase.ClearLog;
begin
  memLog.Lines.Clear;
end;

function TfmMainBase.GetDescription: string;
begin
  result:= 'ERP Data update.';
end;

procedure TfmMainBase.Log(const msg: string);
begin
  memLog.Lines.Add(msg);
end;

procedure TfmMainBase.btnStartUpdateClick(Sender: TObject);
begin
  StartUpdate;
end;

function TfmMainBase.ConnectToServer: boolean;
begin
  result:= false;
  DbConn.Disconnect;
  DbConn.Server           := 'localhost';
  DbConn.Database         := 'Mysql';
  DbConn.Username         := 'P_One';
  DbConn.Password         := '1w$p&LD07';
  DbConn.Port             := 3309;
  DbConn.Options.Compress := false;
  DbConn.Options.Protocol := mpDefault;
  DbConn.LoginPrompt      := false;
  try
    DbConn.Connect;
    result:= DbConn.Connected;
  except
    on e: Exception do begin
      MessageDlg('Could not connect to MySQL Server: ' + e.Message,mtError,[mbOk],0);
    end;
  end;
end;

procedure TfmMainBase.StartUpdate;
begin
  ConnectAndUpdate;
end;

procedure TfmMainBase.FormShow(Sender: TObject);
begin
  lblDescription.Caption:= GetDescription;
end;

procedure TfmMainBase.FormCreate(Sender: TObject);
begin
  inherited;
  DbList:= TStringList.Create;
end;

procedure TfmMainBase.FormDestroy(Sender: TObject);
begin
  DbList.Free;
  inherited;
end;

procedure TfmMainBase.PopulateDbList;
begin
  DbConn.GetDatabaseNames(DbList);
end;

function TfmMainBase.UsersInMysql: Integer;
Var
  qryTemp : TMyQuery;
Begin
  Result := 0;
  qryTemp := TMyQuery.Create(nil);
  Try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection := DBConn;
    qryTemp.SQL.Text := 'SHOW PROCESSLIST';
    qryTemp.Open;
    if (qryTemp.Recordcount>1) then
      Result := qryTemp.Recordcount-1;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TfmMainBase.ConnectAndUpdate;
var
  UserCount: integer;
  x: integer;
  UpdateDbConn: TMyConnection;
begin
  if ConnectToServer then begin
    try
      UserCount:= UsersInMysql;
      if UserCount > 1 then begin
        MessageDlg('Can not run updates while other users/processes are accessing the database. '+
          'MySql reports ' + IntToStr(UserCount -1) + ' additional connections.',mtInformation,[mbOk],0);
        exit;
      end;
      Log('Starting update process ...');

      PopulateDbList;
      UpdateDbConn:= TMyConnection.Create(nil);
      try
        UpdateDbConn.Server:= DbConn.Server;
        UpdateDbConn.Database:= DbConn.Database;
        UpdateDbConn.Username:= DbConn.Username;
        UpdateDbConn.Password:= DbConn.Password;
        UpdateDbConn.Port:= DbConn.Port;
        UpdateDbConn.Options.Compress:= DbConn.Options.Compress;
        UpdateDbConn.Options.Protocol:= DbConn.Options.Protocol;
        UpdateDbConn.LoginPrompt:= DbConn.LoginPrompt;
        for x:= 0 to DbList.Count -1 do begin
          UpdateDbConn.Disconnect;
          UpdateDbConn.Database:= DbList[x];
          try
            UpdateDbConn.Connect;
            UpdateDb(UpdateDbConn);
          except
            on e: Exception do begin
              Log('Error Connecting to or updating database "' + DbList[x] + '" with message: ' + e.Message);
            end;
          end;
        end;
      finally
        UpdateDbConn.Free;
      end;
      Log('Update process complete.');
    finally
      DbConn.Disconnect;
    end;
  end;
end;

procedure TfmMainBase.UpdateDb(const Conn: TMyConnection);
begin
  Log('Updating database: ' + Conn.Database);
end;

function TfmMainBase.TablesCount(
  const DBConnection: TMyConnection): Integer;
Var
  Tables : TStringList;
Begin
  Tables := TStringList.Create;
  Try
    DBConnection.GetTableNames(Tables);
    Result := Tables.Count;
  finally
    FreeAndNil(Tables);
  end;
end;

function TfmMainBase.IsERPDatabase(const Conn: TMyConnection;
  var Version: string): boolean;
var
  TableList: TStringList;
  qry: TMyQuery;
begin
  result:= false;
  Version:= '';
  TableList:= TStringList.Create;
  qry:= TMyQuery.Create(nil);
  try
    Conn.GetTableNames(TableList);
    result:= TableList.IndexOf('tblupdatedetails') > -1;
    if not result then
      exit;
    qry.Connection:= conn;
    qry.SQL.Text:= 'select Version from tblupdatedetails';
    qry.Open;
    Version:= qry.fieldByName('Version').AsString;
  finally
    TableList.Free;
    qry.Free;
  end;
end;

end.
