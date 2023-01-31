unit ERPMessagesDb;

interface

uses
  ERPDBComponents, MyAccess, DAScript, SysUtils;

type
  TERPMEssagesDb = class(TObject)
  private
//    FERPUserName: string;
    FServer: string;
    FConnection: TMyConnection;
    FUpdatesConnection: TMyConnection;
//    procedure SetERPUserName(const Value: string);
    procedure SetServer(const Value: string);
    function GetConnection: TMyConnection;
    function CheckDatabase: boolean;
    procedure DoOnScriptError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
    function GeUpdatestConnection: TMyConnection;
  public
    constructor Create;
    destructor Destroy; override;
    property Server: string read FServer write SetServer;
//    property ERPUserName: string read FERPUserName write SetERPUserName;
    property Connection: TMyConnection read GetConnection;
    property UpdatesConnection: TMyConnection read GeUpdatestConnection;
    function LatestVersion: string;
    function LatestVersionParams: string;
  end;

implementation

uses
  Classes, DbConst, MySQLUtils;

const
  LF = #10;

  {   ***** NOTE *****
      When updating table structure do not re-name or remove existing fields
  }

  tblERPMessages_Fields = 'Id,OrigId,MessageType,VersionNo,CreatedOn,Subject,Details';
  tblERPMessages_SQL =
    'CREATE TABLE `tblerpmessages` (' + LF +
    '  `Id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,' + LF +
    '  `OrigId` bigint(20) DEFAULT ''0'',' + LF +
    '  `MessageType` varchar(255) DEFAULT NULL,' + LF +
    '  `VersionNo` varchar(255) DEFAULT NULL,' + LF +
    '  `CreatedOn` datetime DEFAULT NULL,' + LF +
    '  `Subject` varchar(255) DEFAULT NULL,' + LF +
    '  `Details` text,' + LF +
    '  PRIMARY KEY (`Id`),' + LF +
    '  UNIQUE KEY `OrigIdIdx` (`OrigId`),' + LF +
    '  KEY `MessageTypeIdx` (`MessageType`)' + LF +
    ') ENGINE=MyISAM;';

  tblERPUserMessages_Fields = 'Id,MessageId,UserName,SortId,Active';
  tblERPUserMessages_SQL =
    'CREATE TABLE `tblerpusermessages` (' + LF +
    '  `Id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,' + LF +
    '  `MessageId` bigint(20) DEFAULT ''0'',' + LF +
    '  `UserName` varchar(255) DEFAULT NULL,' + LF +
    '  `SortId` bigint(20) DEFAULT ''0'',' + LF +
    '  `NewMessage` enum(''T'',''F'') DEFAULT ''T'',' + LF +
    '  `Active` enum(''T'',''F'') DEFAULT ''T'',' + LF +
    '  PRIMARY KEY (`Id`),' + LF +
    '  KEY `MessageIdIdx` (`MessageId`),' + LF +
    '  KEY `SortIdIdx` (`SortId`),' + LF +
    '  KEY `UserNameIdIdx` (`UserName`)' + LF +
    ') ENGINE=MyISAM;';


{ TERPMEssagesDb }

function TERPMEssagesDb.CheckDatabase: boolean;
var
  qry: TERPQuery;
  scr: TERPScript;
  sl: TStringList;
  s: string;
begin
  result := true;
  sl := TStringList.Create;
  qry := TERPQuery.Create(nil);
  scr := TERPScript.Create(nil);
  try
    qry.Connection := Connection;
    scr.Connection := Connection;
    scr.OnError := DoOnScriptError;
    Connection.GetTableNames(sl);

    if sl.IndexOf('tblerpmessages') < 0 then begin
      { table not there so create it! }
      qry.SQL.Text := tblERPMessages_SQL;
      qry.Execute;
    end
    else begin
      { table exists, check structure }
      qry.SQL.Text := 'show create table ' + 'tblerpmessages';
      qry.Open;
      s:= qry.FieldByName('Create Table').AsString;
      s:= Copy(s,1,Pos('MyISAM',s) + 5) + ';';
      qry.Close;
      if not SameText(s, tblERPMessages_SQL) then begin
//        with TStringList.Create do begin
//          text:= s;
//          savetofile('c:\temp\temp_actual.sql');
//          text:= tblERPMessages_SQL;
//          savetofile('c:\temp\temp_create.sql');
//          free;
//        end;
        scr.SQL.Clear;
        scr.SQL.Add('create table tmp_erp_tblerpmessages as (select * from tblerpmessages);');
        scr.SQL.Add('drop table ' + 'tblerpmessages' + ';');
        scr.SQL.Add(tblERPMessages_SQL);
        scr.SQL.Add('insert ignore into tblerpmessages (' + tblERPMessages_Fields + ') select * from tmp_erp_tblerpmessages;');
        scr.SQL.Add('drop table if exists tmp_erp_tblerpmessages');
        scr.Execute;
      end;
    end;


    if sl.IndexOf('tblERPUserMessages') < 0 then begin
      { table not there so create it! }
      qry.SQL.Text := tblERPUserMessages_SQL;
      qry.Execute;
    end
    else begin
      { table exists, check structure }
      qry.SQL.Text := 'show create table ' + 'tblERPUserMessages';
      qry.Open;
      s:= qry.FieldByName('Create Table').AsString;
      s:= Copy(s,1,Pos('MyISAM',s) + 5) + ';';
      qry.Close;
      if not SameText(s, tblERPUserMessages_SQL) then begin
//        with TStringList.Create do begin
//          text:= s;
//          savetofile('c:\temp\temp_actual.sql');
//          text:= tblERPUserMessages_SQL;
//          savetofile('c:\temp\temp_create.sql');
//          free;
//        end;
        scr.SQL.Clear;
        scr.SQL.Add('create table tmp_erp_tblERPUserMessages as (select * from tblERPUserMessages);');
        scr.SQL.Add('drop table ' + 'tblERPUserMessages' + ';');
        scr.SQL.Add(tblERPUserMessages_SQL);
        scr.SQL.Add('insert ignore into tblERPUserMessages (' + tblERPUserMessages_Fields + ') select * from tmp_erp_tblERPUserMessages;');
        scr.SQL.Add('drop table if exists tmp_erp_tblERPUserMessages');
        scr.Execute;
      end;
    end;

  finally
    sl.Free;
    qry.Free;
    scr.Free;
  end;

end;

constructor TERPMEssagesDb.Create;
begin

end;

destructor TERPMEssagesDb.Destroy;
begin
  FConnection.Free;
  FUpdatesConnection.Free;
  inherited;
end;

procedure TERPMEssagesDb.DoOnScriptError(Sender: TObject; E: Exception;
  SQL: string; var Action: TErrorAction);
begin
  Action := eaContinue;
end;

function TERPMEssagesDb.GetConnection: TMyConnection;
begin
  if not assigned(fConnection) then begin
    FConnection := TMyConnection.Create(nil);
    MySQLUtils.SetConnectionProps(FConnection,DbConst.SERVICES_DATABASE,self.Server);
    FConnection.Connect;
  end
  else begin
    if not SameText(FConnection.Server,self.Server) then begin
      FConnection.Disconnect;
      FConnection.Server := self.Server;
      FConnection.Connect;
    end;
  end;
  result := FConnection;
end;

function TERPMEssagesDb.GeUpdatestConnection: TMyConnection;
begin
  if not assigned(fUpdatesConnection) then begin
    fUpdatesConnection := TMyConnection.Create(nil);
    MySQLUtils.SetConnectionProps(fUpdatesConnection,'serverupdates',self.Server);
    fUpdatesConnection.Connect;
  end
  else begin
    if not SameText(fUpdatesConnection.Server,self.Server) then begin
      fUpdatesConnection.Disconnect;
      fUpdatesConnection.Server := self.Server;
      fUpdatesConnection.Connect;
    end;
  end;
  result := fUpdatesConnection;
end;

function TERPMEssagesDb.LatestVersion: string;
var
  qry: TERPQuery;
begin
  result := '';
  if not UpdatesConnection.Connected then exit;

  qry := TERPQuery.Create(nil);
  try
    qry.Connection := UpdatesConnection;
    qry.SQL.Add('select Version from updates where UpdateName = "TrueERPMessages"');
    qry.Open;
    result := qry.FieldByName('Version').AsString;
  finally
    qry.Free;
  end;
end;

function TERPMEssagesDb.LatestVersionParams: string;
var
  qry: TERPQuery;
begin
  result := '';
  if not UpdatesConnection.Connected then exit;

  qry := TERPQuery.Create(nil);
  try
    qry.Connection := UpdatesConnection;
    qry.SQL.Add('select Params from updates where UpdateName = "TrueERPMessages"');
    qry.Open;
    result := qry.FieldByName('Params').AsString;
  finally
    qry.Free;
  end;
end;

//procedure TERPMEssagesDb.SetERPUserName(const Value: string);
//begin
//  FERPUserName := Value;
//end;

procedure TERPMEssagesDb.SetServer(const Value: string);
begin
  FServer := Value;
  self.CheckDatabase;
end;

end.
