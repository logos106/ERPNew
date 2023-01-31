unit ErpDbInfo;

interface

uses
  JsonObject;


function GetERPDatabaseInfo(var DbInfo: TJsonObject; aMySQLServer: string): boolean;
function SetERPDatabaseInfo(DbInfo: TJsonObject; aMySQLServer: string): boolean;

implementation

uses
  MyAccess, moduleDbUtils, DbConst, sysutils, classes, SMSConfigObj, MySQLUtils;

function GetERPDatabaseInfo(var DbInfo: TJsonObject; aMySQLServer: string): boolean;
var
  Conn: TMyConnection;
  qry: TMyQuery;
  dbList,
  excludeDbList,
  tableList: TStringList;
  x: integer;
  db, version: string;
  json: TJsonObject;
  s: string;

begin
  result:= false;
  Conn:= TMyConnection.Create(nil);
  qry:= TMyQuery.Create(nil);
  dbList:= TStringList.Create;
  excludeDbList:= TStringList.Create;
  tableList:= TStringList.Create;
  try
    excludeDbList.CommaText:=
      'information_schema,apphelp,erp_export,erpnewdb,mysql,' +
      'pbxmonitor,serverupdates,services';
    qry.Connection:= Conn;
    InitialiseConnection(Conn,aMySQLServer,MYSQL_DATABASE);
    try
      Conn.Connect;
      qry.SQL.Text:= 'show databases';
      qry.Open;
      while not qry.Eof do begin
        dbList.Add(qry.Fields[0].AsString);
        qry.Next;
      end;
      qry.Close;
      Conn.Disconnect;
      for x:= 0 to dbList.Count -1 do begin
        db:= dbList[x];
        if excludeDbList.IndexOf(db) < 0 then begin
          Conn.Disconnect;
          InitialiseConnection(Conn,aMySQLServer,db);
          Conn.Connect;
          tableList.Clear;
          Conn.GetTableNames(tableList);
          if (tableList.Count > 100) and
             (tableList.IndexOf('tblupdatedetails') > -1) and
             (tableList.IndexOf('tblcompanyinformation') > -1) then begin   { probably an ERP database }
            qry.Close;
            qry.SQL.Text:= 'select * from tblupdatedetails';
            qry.Open;
            version:= qry.FieldByName('version').AsString;
            qry.Close;
            qry.SQL.Text:= 'select * from tblcompanyinformation';
            qry.Open;
            if not Assigned(DbInfo) then
              DbInfo:= TJsonObject.Create;
            result:= true;
            json:= DbInfo.O[db];
            json.S['version']:= version;
            json.S['companyname']:= qry.FieldByName('CompanyName').AsString;
            try
              s:=
                qry.FieldByName('Address').AsString + ',' +
                qry.FieldByName('Address2').AsString + ',' +
                qry.FieldByName('City').AsString + ',' +
                qry.FieldByName('State').AsString + ',' +
                qry.FieldByName('PostCode').AsString + ',' +
                qry.FieldByName('Country').AsString;
            except
              on e: exception do begin
                s:= 'Error: ' + e.Message;
              end;
            end;
            json.S['address']:= s;
            try
              s:=
                qry.FieldByName('POBox').AsString + ',' +
                qry.FieldByName('POBox2').AsString + ',' +
                qry.FieldByName('POCity').AsString + ',' +
                qry.FieldByName('POState').AsString + ',' +
                qry.FieldByName('POPostCode').AsString + ',' +
                qry.FieldByName('POCountry').AsString;
            except
              on e: exception do begin
                s:= 'Error: ' + e.Message;
              end;
            end;
            json.S['postaladdress']:= s;
            try
              s:=
                'Phone: ' + qry.FieldByName('PhoneNumber').AsString + ', Fax: ' +
                qry.FieldByName('FaxNumber').AsString;
            except
              on e: exception do begin
                s:= 'Error: ' + e.Message;
              end;
            end;
            json.S['contact']:= s;
            qry.Close;
            qry.SQL.Text := 'select fieldvalue from tbldbPreferences where PrefType = "TSMSConfig" and Name = "Config"';
            qry.Open;
            json.O['SMSConfig'].AsString := qry.FieldByName('fieldvalue').AsString;

          end;
        end;
      end;
    except
      on e: exception do begin
        result:= false;
        if not Assigned(DbInfo) then
          DbInfo:= TJsonObject.Create;
        DbInfo.S['error']:= e.Message;
      end;
    end;
  finally
    tableList.Free;
    excludeDbList.Free;
    dbList.Free;
    qry.Free;
    Conn.Free;
  end;
end;

function SetERPDatabaseInfo(DbInfo: TJsonObject; aMySQLServer: string): boolean;
var
  Conn: TMyConnection;
  qry: TMyQuery;
  dbList,
  excludeDbList,
  tableList: TStringList;
  x: integer;
  db: string;
  json: TJsonObject;
  smsConfig: TSMSConfig;

begin
  result:= true;
  Conn:= TMyConnection.Create(nil);
  qry:= TMyQuery.Create(nil);
  dbList:= TStringList.Create;
  excludeDbList:= TStringList.Create;
  tableList:= TStringList.Create;
  smsConfig := TSMSConfig.Create;
  try
    excludeDbList.CommaText:=
      'information_schema,apphelp,erp_export,erpnewdb,mysql,' +
      'pbxmonitor,serverupdates,services';
    qry.Connection:= Conn;
    InitialiseConnection(Conn,aMySQLServer,MYSQL_DATABASE);
    try
      Conn.Connect;
      qry.SQL.Text:= 'show databases';
      qry.Open;
      while not qry.Eof do begin
        dbList.Add(qry.Fields[0].AsString);
        qry.Next;
      end;
      qry.Close;
      Conn.Disconnect;
      for x:= 0 to dbList.Count -1 do begin
        db:= dbList[x];
        if excludeDbList.IndexOf(db) < 0 then begin
          Conn.Disconnect;
          InitialiseConnection(Conn,aMySQLServer,db);
          Conn.Connect;
          tableList.Clear;
          Conn.GetTableNames(tableList);
          if (tableList.Count > 100) and
             (tableList.IndexOf('tblupdatedetails') > -1) and
             (tableList.IndexOf('tblcompanyinformation') > -1) then begin   { probably an ERP database }


            if DBInfo.ObjectExists(db) then begin
              json := DbInfo.O[db];
              smsConfig.Load(Conn);
              if not SameText(smsConfig.AsString, json.O['SMSConfig'].AsString) then begin
                smsConfig.AsString := json.O['SMSConfig'].AsString;
                smsConfig.Save(Conn);
              end;
            end;
          end;
        end;
      end;
    except
      on e: exception do begin
        result:= false;
        DbInfo.S['error']:= e.Message;
      end;
    end;
  finally
    tableList.Free;
    excludeDbList.Free;
    dbList.Free;
    qry.Free;
    Conn.Free;
    smsConfig.Free;
  end;
end;


end.
