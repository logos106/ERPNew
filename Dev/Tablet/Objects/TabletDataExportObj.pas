unit TabletDataExportObj;

interface

uses
  datTabletDB, ObjectSerialiser, BusObjBase, JsonObject;

type

  {$M+}
  TExportProgress = procedure (const msg: string; IsNewMessage: boolean = true) of object;
  TTabletDataExport = class(TObject)
  private
    fOnExportProgress: TExportProgress;
    fActive: boolean;
    fOutputDbName: string;
    fMinSaleDate: TDateTime;
    fIncludeProductPictures: boolean;
    JSONSerialiser: TJSONSerialiser;
    fDbList: string;
    function SaveApiDetails(aDb: TdmTabletDB; ErpDatabase: string): integer;
    function PasswordForUser(const aUserName: string): string;
    procedure SaveObject(BusObj: TMSBusObj; const ApiID: integer; Db: TdmTabletDB);
    procedure SaveObjectProps(json: TJsonObject; const ObjectDataID, ApiID: integer; Db: TdmTabletDB);
  protected
    procedure Log(const msg: string; IsNewMessage: boolean = true);
  public
    constructor Create;
    destructor Destroy; override;
    procedure ExportData;
    property OnExportProgress: TExportProgress read fOnExportProgress write fOnExportProgress;
    property Active: boolean read fActive write fActive;
    property OutputDbName: string read fOutputDbName write fOutputDbName;
    property MinSaleDate: TDateTime read fMinSaleDate write fMinSaleDate;
    property IncludeProductPictures: boolean read fIncludeProductPictures write fIncludeProductPictures;
    property DbList: string read fDbList write fDbList;
  end;

  TApiDetails = class(TObject)
  private
    fApiUserName: string;
    fPort: string;
    fDescription: string;
    fERPDatabaseName: string;
    fApiUserPassword: string;
    fUseSSL: boolean;
    fServer: string;
  published
    property Server: string read fServer write fServer;
    property UseSSL: boolean read fUseSSL write fUseSSL;
    property Port: string read fPort write fPort;
    property ApiUserName: string read fApiUserName write fApiUserName;
    property ApiUserPassword: string read fApiUserPassword write fApiUserPassword;
    property ERPDatabaseName: string read fERPDatabaseName write fERPDatabaseName;
    property Description: string read fDescription write fDescription;
  end;
  {$M-}


implementation

uses
  utSynchItemList, Classes, SysUtils, ERPDbComponents, CommonDbLib, TypInfo,
  BusObjSynchItem, AppEnvironment, JsonToObject, Types, StrUtils, Dialogs,
  SimpleEncrypt, DateUtils, BusObjPQA, BusObjProductClass, utObjSchema,
  CommonLib, MySQLUtils;

const
  KEY          = 'z';

{ TTabletDataExport }

constructor TTabletDataExport.Create;
begin
  fMinSaleDate := 0;
  fIncludeProductPictures := true;
  JSONSerialiser := TJSONSerialiser.Create;
end;

destructor TTabletDataExport.Destroy;
begin
  JSONSerialiser.Free;
  inherited;
end;

procedure TTabletDataExport.ExportData;
var
  ItemList, DatabaseList: TStringList;
  x: integer;
  qry: TERPQuery;
  limitFrom, limitCount: integer;
  BusObj: TMSBusObj;
  recCount, recNo: integer;
  json: TJsonObject;
  ApiID: integer;
  dt: TDateTime;
  dtStart: TDateTime;
  percent: double;
  dtObjStart: TDateTime;
  s: string;
  dtRemaining: TDateTime;
  Db: TdmTabletDB;
  DbIdx: integer;
  conn: TERPConnection;

begin
  dt := MinSaleDate;
  dtStart := now;
  Active := true;
  ItemList := TStringList.Create;
  DatabaseList := TStringList.Create;


  qry := TERPQuery.Create(nil);
  Db := TdmTabletDB.Create(nil);
  conn := TERPConnection.Create(nil);
  try
    SetConnectionProps(Conn,'',CommonDbLib.GetSharedMyDacConnection.Server);
    DatabaseList.CommaText := DbList;
    Db.DatabaseFileName := OutputDbName;
    try
      Db.Connected := true;
    except
      on e: exception do begin
        Log('Error opening export database: ' + e.Message);
        exit;
      end;
    end;
//    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    TSynchItemList.GetDownSynchList(ItemList);
    if not IncludeProductPictures then
      ItemList.Delete(ItemList.IndexOf('TProductPicture'));

    Log('==== Starting Data Export ====');
    try
      for DbIdx := 0 to DatabaseList.Count - 1 do begin
        Log('');
        Log('== Exporting Database: ' + DatabaseList[DbIdx] + ' ==');
        Conn.Connected := false;
        Conn.Database := DatabaseList[DbIdx];
        Conn.Connected := true;
        qry.Connection := Conn;
        ApiID := SaveApiDetails(Db,DatabaseList[DbIdx]);
        if ApiID = 0 then begin
          Log('Unable to read the Web API details for this database .. exiting');
          exit;
        end;
        for x := 0 to ItemList.Count -1 do begin
          Log('Processing Object ' + IntToStr(x + 1) + ' of ' + IntToStr(ItemList.Count) + ' (' + ItemList[x] + ')');
          if not Active then begin
            Log('Export Aborted by User');
            exit;
          end;
          dtObjStart := now;
          Log('Starting ..');
          BusObj := TMSBusObjClass(FindClass(ItemList[x])).Create(nil);
          try
            limitFrom := 0;
            limitCount := 1000;
            recNo := 0;
            BusObj.Connection := TMyDacDataConnection.Create(BusObj);
            BusObj.Connection.Connection := Conn;
            BusObj.SilentMode := true;
            if BusObj.ClassNameIs('TPQASNLastTransDate') then
              TPQASNLastTransDate.UpdateTableData
            else if BusObj.ClassNameIs('TProductClassQuantity') then
              TProductClassQuantity.UpdateTableData;
            while true do begin
              if not Active then begin
                Log('Export Aborted by User');
                exit;
              end;
              qry.SQL.Text := 'select count(' + BusObj.IDFieldName + ') as RecCount from ' + BusObj.GetBusObjectTablename;
              if SameText(ItemList[x],'TERPForm') then
                qry.SQL.Add('where TabGroup = 26')
              else if SameText(ItemList[x],'TEmployeeFormAccess') then
                qry.SQL.Add('where FormID in (select FormID from tblForms where TabGroup = 26)')
              else if SameText(ItemList[x], 'TERPPreference') then
                qry.SQL.Add('where RefType = "None"')
              else if SameText(ItemList[x], 'TERPAccountPref') then
                qry.SQL.Add('where RefType = "Account"')
              else if SameText(ItemList[x], 'TInvoice') then
                qry.SQL.Add('where IsInvoice = "T" and SaleDate >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dt)))
              else if SameText(ItemList[x], 'TQuote') then
                qry.SQL.Add('where IsQuote = "T" and SaleDate >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dt)))
              else if SameText(ItemList[x], 'TSalesOrder') then
                qry.SQL.Add('where IsSalesOrder = "T" and SaleDate >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dt)))
              else if SameText(ItemList[x], 'TPurchaseOrder') then
                qry.SQL.Add('where OrderDate >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dt)));

              qry.Open;
              recCount := qry.FieldByName('RecCount').AsInteger;
              qry.Close;

              qry.SQL.Text := 'select ' + BusObj.IDFieldName + ' from ' + BusObj.GetBusObjectTablename;
              if SameText(ItemList[x],'TERPForm') then
                qry.SQL.Add('where TabGroup = 26')
              else if SameText(ItemList[x],'TEmployeeFormAccess') then
                qry.SQL.Add('where FormID in (select FormID from tblForms where TabGroup = 26)')
              else if SameText(ItemList[x], 'TERPPreference') then
                qry.SQL.Add('where RefType = "None"')
              else if SameText(ItemList[x], 'TERPAccountPref') then
                qry.SQL.Add('where RefType = "Account"')
              else if SameText(ItemList[x], 'TInvoice') then
                qry.SQL.Add('where IsInvoice = "T" and SaleDate >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dt)))
              else if SameText(ItemList[x], 'TQuote') then
                qry.SQL.Add('where IsQuote = "T" and SaleDate >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dt)))
              else if SameText(ItemList[x], 'TSalesOrder') then
                qry.SQL.Add('where IsSalesOrder = "T" and SaleDate >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dt)))
              else if SameText(ItemList[x], 'TPurchaseOrder') then
                qry.SQL.Add('where OrderDate >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dt)));
              qry.SQL.Add('order by msTimeStamp ASC limit ' + IntToStr(limitCount) + ' offset ' + IntToStr(limitFrom));
              qry.Open;
              try
                while not qry.Eof do begin
                  if not Active then begin
                    Log('Export Aborted by User');
                    exit;
                  end;
                  BusObj.Load(qry.FieldByName(BusObj.IDFieldName).AsInteger);
                  Inc(recNo);
                  s := '';
                  percent := (recNo/recCount) * 100;
                  { if not 100 % yet and it has been more than 20 secs .. display remaining time  }
                  if (percent < 99.9) and ((now - dtObjStart) > (20 * OneSecond)) then begin
                    dtRemaining := ((now - dtObjStart) / recNo) * (recCount - recNo);
                    s:= ' (Est time remaining: ' + FormatDateTime('hh:nn:ss',dtRemaining) + ')';
                  end;

                  Log('   Record ' + IntToStr(recNo) + ' of ' + IntToStr(recCount) + ' ' + IntToStr(System.Round(percent)) + '%'+s,false);

  //                JSONSerialiser.Clear;
  //                json := JSONSerialiser.SerialiseObject(BusObj);
  //                try
  //                  json.FormatOutput := false;
  //                  Db.SaveObjectData(BusObj.ClassName, BusObj.ID,BusObj.MsTimeStamp, BusObj.MsUpdateSiteCode, json.AsString, ApiID);
  //
  //                finally
  //                  json.Free;
  //                end;
                  if BusObj.ID > 0 then
                    SaveObject(BusObj,ApiID,DB);

                  qry.Next;
                end;
                if qry.IsEmpty then
                  Log('   No data found.',false);

                if qry.RecordCount < limitCount then
                  break;
                limitFrom := limitFrom + limitCount;
              finally
                qry.Close;
              end;
            end;

          finally
            BusObj.Free;
          end;


        end;
      end;
    finally
      Log('==== Export Complete (Time taken: '+FormatDateTime('hh:nn:ss',now-dtStart)+') ====');
    end;


  finally
    qry.Free;
    ItemList.Free;
    DatabaseList.Free;
    DB.Free;
    Conn.Free;
  end;
end;

procedure TTabletDataExport.Log(const msg: string; IsNewMessage: boolean);
begin
  if Assigned(fOnExportProgress) then
    fOnExportProgress(msg, IsNewMessage);
end;

function TTabletDataExport.PasswordForUser(const aUserName: string): string;
var
  qry: TERPQuery;
begin
  result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:=
            'SELECT p.Pswd_ID, p.Logon_Name, p.Logon_Password, e.EmployeeID ' +
            'FROM tblEmployees e ' +
            'INNER JOIN tblPassword p ON e.EmployeeID=p.EmployeeId ' +
            'WHERE Not IsNull(p.Logon_Name) AND p.Logon_Name = "'+aUserName+'" ' +
            'And e.Active="T"';
    qry.Open;
    if qry.FieldByName('Logon_Password').AsString <> '' then
      result := LowerCase(DeCrypt(qry.FieldByName('Logon_Password').AsString, KEY));

  finally
    qry.Free;
  end;
end;

function TTabletDataExport.SaveApiDetails(aDb: TdmTabletDB; ErpDatabase: string): integer;
var
  json: TJsonObject;
  ApiDetails: TApiDetails;
//  SynchItem: TSynchItem;
begin
  result := 0;
  json := AppEnv.UtilsClient.Client.SendRequest('WebApi.GetConfig',nil);
  if Assigned(json) then begin
    try
      ApiDetails := TApiDetails.Create;
      try
        ApiDetails.Server := '';
        ApiDetails.UseSSL := json.O['result'].B['UseSSL'];
        if ApiDetails.UseSSL then
          ApiDetails.Port := IntToStr(json.O['result'].I['DefaultSSLPort'])
        else
          ApiDetails.Port := IntToStr(json.O['result'].I['DefaultPort']);
        ApiDetails.ApiUserName := json.O['result'].S['WebUserName'];
        ApiDetails.ApiUserPassword := PasswordForUser(ApiDetails.ApiUserName);
        ApiDetails.ERPDatabaseName := ErpDatabase; //CommonDbLib.GetSharedMyDacConnection.Database;
        ApiDetails.Description := ApiDetails.ERPDatabaseName;

        result := aDb.SaveObjectData(ApiDetails.ClassName, 0, 0, '', ObjToStr(ApiDetails), 0, true);

      finally
        ApiDetails.Free;
      end;

    finally
      json.Free;
    end;
  end;
end;

procedure TTabletDataExport.SaveObject(BusObj: TMSBusObj; const ApiID: integer; Db: TdmTabletDB);
var
  json: TJsonObject;
  s: string;
  DbID: integer;
begin
  s := TObjSchema.KeyPropertyList(BusObj.ClassName);
  JSONSerialiser.Clear;
  json := JSONSerialiser.SerialiseObject(BusObj);
  try
    json.FormatOutput := false;
    try
      DbID := Db.SaveObjectData(BusObj.ClassName, BusObj.ID,BusObj.MsTimeStamp, BusObj.MsUpdateSiteCode, json.AsString, ApiID, s <> '');
      if s <> '' then begin
        { need to save Object Props }
        SaveObjectProps(json,DbId,ApiID,DB);
      end;
    except
      on e: exception do begin
        CommonLib.MessageDlgXP_Vista('Error adding data for ' + BusObj.ClassName + ' ErpID: ' + IntToStr(BusObj.ID) +
          ' Message: ' + e.Message,mtInformation,[mbOk],0);
      end;
    end;
  finally
    json.Free;
  end;
end;

procedure TTabletDataExport.SaveObjectProps(json: TJsonObject;
  const ObjectDataID, ApiID: integer; Db: TdmTabletDB);
var
  PropList: TStringDynArray;
  strVal: string;
  sql, vals: string;
  pair: TJsonValuePair;
  I, x: integer;
  ObjectType: string;
  ErpID: integer;
  s: string;
begin
  ObjectType := json.S['type'];
  ErpID := json.O['fields'].I['ID'];
  sql := '';
  vals := '';
  PropList := TObjSchema.KeyPropertyArray(ObjectType);
  for I := Low(PropList) to High(PropList) do begin
    strVal := '';
    pair :=  json.O['fields'].ItemByName[PropList[I]];
    if Assigned(pair) then begin
      if pair.ValueType = valBoolean then begin
        if pair.Value.AsBoolean then strVal := 'True'
        else strVal := 'False';
      end
      else
        strVal := pair.Value.AsString;
    end;
    if vals <> '' then vals := vals + ',';
    vals := vals + QuotedStr(strVal);
  end;
  sql := 'insert into ObjectVals(ApiID,ObjectType,ErpID,ObjectDataID';
  for I := Low(PropList) to High(PropList) do
    sql := sql + ',Col' + IntToStr(I);
  sql := sql + ') values (' + IntToStr(ApiID) + ',' +QuotedStr(ObjectType) + ',' + IntToStr(ErpID) + ',' + IntToStr(ObjectDataID) + ',' + vals + ')';
  try
    Db.Database.Execute(sql);
  except
    on e: exception do begin
      CommonLib.MessageDlgXP_Vista('Error adding data for ' + ObjectType + ' ErpID: ' + IntToStr(ErpID) + ' ObjectDataID: ' +
        IntToStr(ObjectDataID) + ' Message: ' + e.Message,mtInformation,[mbOk],0);
    end;
  end;

  s := TObjSchema.SubArrayPropertyList(ObjectType);
  if s = '' then exit;
  PropList := SplitString(s,',');
  for I := Low(PropList) to High(PropList) do begin
    pair := json.O['fields'].ItemByName[PropList[I]];
    if pair.ValueType = valArray then begin
      for x := 0 to TJsonArray(pair.Value).Count -1 do
        SaveObjectProps(TJsonArray(pair.Value)[x].AsObject,ObjectDataID, ApiID, Db)
    end;
  end;
end;

end.


