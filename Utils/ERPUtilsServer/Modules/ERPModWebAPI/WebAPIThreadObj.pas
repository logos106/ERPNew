unit WebAPIThreadObj;
{$I ERP.inc}
interface

uses
  Classes, SyncObjs, JsonObject, LogThreadBase, LogMessageTypes, ConTnrs,
  BusObjBase, WebAPILib, utServerTask;

type

  TWebAPIThreadStatus = (wsIdle,wsFinished,wsBusy);

  TWebAPIThreadBase = class(TThread)

  private
  Protected
    fLogger: TLoggerBase;
    fOnEvent:TEventProc;    // utAPIBaseObj-> TAPIBaseObj.DoEvent(
    fiServerTaskID:Integer;
    procedure Log(const msg: string; aType: TLogMessageType = ltNone);
    procedure OnStatus(aResponseno:String; aStatusMsg:String; aErrorMsg:String='');
  Public
    constructor Create(Logger: TLoggerBase; CreateSuspended:Boolean);Virtual;
    Property ServerTaskID :Integer read fiServerTaskID write fiServerTaskID;
  end;

  TWebAPIThread = class(TWebAPIThreadBase)
  private
    fLock: TCriticalSection;
    FStatus: TWebAPIThreadStatus;
    fDatabase: string;
    fPassword: string;
    fUserName: string;
    fMySQLServer: string;
    TaskRec: TServerTaskRec;
    procedure ProcessRequest;
    function GetResource(const aResourceName: string): boolean;
    function GetFunction(const aResourceName: string): boolean;
    function Func_ProductAvailableQty: boolean;
    function Func_ValidateSN: boolean;
    function Func_SaleGroup: boolean;
    function Func_ARList: boolean;
    function Func_APList: boolean;
    procedure SetStatus(const Value: TWebAPIThreadStatus);
    function GetObjectList(ResourceName: string; aList: TStringList; var msg: string; AddToList: boolean = true): boolean;
    function ParamVal(const aParamName: string): TJsonValue;
    function SplitPSN(const aValue: string; var aPartsID: integer; var aSerialNumber: string): boolean;
    function MaxSaleGroupID(const aSaleID: integer): integer;
    function SelectParamToSQL(aSelectParam: string; aDsObj: TDatasetBusObj): string;

  protected
    procedure Execute; override;

  public
    RequestJson,
    ResultJson: TJsonObject;
    LastTime: TDateTime;
    OutStream: TStream;
    constructor Create(Logger: TLoggerBase; CreateSuspended:Boolean);Override;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    property Status: TWebAPIThreadStatus read FStatus write SetStatus;
    property Database: string read fDatabase;
    property UserName: string read fUserName;
    property Password: string read fPassword;
    property MySQLServer: string read fMySQLServer write fMySQLServer;
  end;

  TCleanupThread = class;
  TApiThreadList = class(TObject)
  private
    fList: TObjectList;
    fLock: TCriticalSection;
    fLogger: TLoggerBase;
    FMaxThreadCount: integer;
    CleanupThread: TCleanupThread;
    fMySQLServer: string;
    procedure SetMaxThreadCount(const Value: integer);
    procedure Log(const msg: string; aType: TLogMessageType = ltNone);
  public
    constructor Create(aLogger: TLoggerBase);
    destructor Destroy; override;
    property MaxThreadCount: integer read FMaxThreadCount write SetMaxThreadCount;
    procedure Lock;
    procedure Unlock;
    procedure DoHTTPRequest(RequestJson, ResultJson: TJsonObject; var OutStream: TStream);
    property List: TObjectList read fList;
    property MySQLServer: string read fMySQLServer write fMySQLServer;
  end;

  TCleanupThread = class(TThread)
  private
    fThreadList: TApiThreadList;
    fNextCheckTime: TDateTime;
  protected
    procedure Execute; override;
  public
    constructor Create(aThreadList: TApiThreadList);
  end;

implementation

uses
  types, MyAccess, ObjectSerialiser, db, sysutils, DateUtils,
  ModuleConst, AppEnvironment, strutils, AppEnvironmentPool,
  CommonDbLib, ActiveX, windows, ModuleUtils, Character, WebApiConst, typinfo,
  RepObjBase, ObjBasicInfoObj, ApiFunctionObj, ErpSchemaObj, ErpDbComponents,
  DbSharedObjectsObj, JsonToDatasetFuncs,
  ProductQtyLib, PQALib, DateTimeConvert, BusObjPQA, TempTableUtils,
  Report_AR_Obj, Report_AP_Obj, utCloudAPI, utSystemAPI, ApiFuncObj , utVS1AdminAPI,
  utGTAdminAPI, BusobjWebAPIRequestLog, utCloudconst,
  {$IFDEF DevMode}loglib,{$ENDIF}
  utVS1Const, BusObjTimeSheet, LogThreadLib, Dialogs, BusObjProfitLoss;

const
//  DefaultServer = 'localhost';
  OneMin = 1 / 24 /60;

function RemoveCRLF(inStr: string): string;
var
  sl: TStringList;
  x: integer;
begin
  result:= '';
  sl:= TStringList.Create;
  try
    sl.Text:= Trim(inStr);
    for x := 0 to sl.Count-1 do begin
      if x > 0 then result:= result + ' ';
      result:= result + sl[x];
    end;
  finally
    sl.Free;
  end;
end;

function UnQuoteStr(const Value: string): string;
begin
  result := Value;
  if ((copy(result,1,1) = '''') and (copy(result,Length(result),1) = '''')) or
     ((copy(result,1,1) = '"') and (copy(result,Length(result),1) = '"')) then begin
     result := copy(result , 2, Length(result)-2);
  end;
end;

function IsQuotedStr(const Value: string): boolean;
begin
  result := false;
  if ((copy(Value,1,1) = '''') and (copy(Value,Length(Value),1) = '''')) or
     ((copy(Value,1,1) = '"') and (copy(Value,Length(Value),1) = '"')) then begin
     result := true;
  end;
end;

function StrToKeyString(InStr: string; var OutStr: string): boolean;
begin
  result:= IsQuotedStr(InStr);
  if result then OutStr := UnQuoteStr(InStr)
  else OutStr := '';
end;

{ The JSON data posted to the server may have created sub objects
  (eg TLead.MarketingContact) that are not created by the form, so these need
  to be saved (which calls validate) here }
function SaveBusObj(obj: TDatasetBusObj; var msg: string): boolean;
var
  Count: integer;
  PropList: PPropList;
  x: integer;
  subObj: TObject;
  i: Integer;
begin
  { find sub objects }
  Count := GetPropList(obj.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(obj.ClassInfo, tkProperties, PropList);

    for x := 0 to Count - 1 do begin
      case PropList[x].PropType^.Kind of
        tkClass:
          begin
            // ShowMessage('prop name ' + string(PropList[x].Name));
            subObj := GetObjectProp(obj, string(PropList[x].Name));
            if (SameText(string(PropList[x].Name), 'Lines')) then
              i := x;

            if (not SameText(string(PropList[x].Name), 'Lines')) and Assigned(subObj) and (subObj is TDatasetBusObj) and (TDatasetBusObj(subObj).Count = 1) and (TDatasetBusObj(subObj).IsReadOnly = False) then begin
              { only interested in single record objects as these are more
                likly to be sub or reference business objects as opposed
                to lines type objects (which should be validated/saved by parent). }

              Result := SaveBusObj(TDatasetBusObj(subObj), msg);
              if not Result then Exit;
            end;
          end;
      end;
    end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;

  Result := obj.Save;
  if not Result then
    msg := RemoveCRLF(obj.ResultStatus.Messages);
end;

function SaveBusObjArray(jsonIn: TJSONObject; var msg: string): Boolean;
var
  K : Integer;
  JArray : TJSONArray;
  JObject : TJSONObject;
  Obj : TObject;
  JSONDesrialiser : TJSONDeserialiser;
  DsBusObj : TDatasetBusObj;
  msTimeStamp : TDateTime;
begin
  Result := False;

  JArray := jsonIn.A['objects'];
  for K := 0 to JArray.Count - 1 do begin
    JObject := JArray[K].AsObject;

    JSONDesrialiser := TJSONDeserialiser.Create;
    try
      JSONDesrialiser.DatabaseConnection:= AppEnv.AppDb.TransConnection;
      Obj := JSONDesrialiser.DeserialiseObject(JObject);
      if not JSONDesrialiser.IsConsistent then begin
        msg := 'POST - Error populating object... ';
        Exit;
      end;

      if Obj is TDatasetBusObj then begin
        DsBusObj := TDatasetBusObj(Obj);

        msTimeStamp := 0;
        if JObject.O['fields'].Exists('msTimeStamp') then
          msTimeStamp := JObject.O['fields'].ItemByName['msTimeStamp'].Value.AsDateTime;

        DsBusObj.SilentMode := true;

        msg:= '';
        if not SaveBusObj(DsBusObj, msg) then begin
          msg := 'POST - Error saving object... ';
          Exit;
        end;

        if DsBusObj is TMSBusObj then begin
          if (msTimeStamp <> 0) then begin
            { the save above will cause db trigger to update msTimeStamp .. so set back to correct value }
            TMSBusObj(DsBusObj).FlagAsUpdated(msTimeStamp);
          end;
        end;

        JObject.O['fields'].I['ID'] := DsBusObj.ID;

        if DsBusObj is TMSBusObj then
          JObject.O['fields'].S['GlobalRef']:= TMSBusObj(DsBusObj).GlobalRef;
      end;
    finally
      JSONDesrialiser.Free;
    end;
  end;
end;

function DeleteBusObj(jsonIn: TJSONObject; var msg: string): Boolean;
var
  K, Count : Integer;
  Obj : TObject;
  JSONDesrialiser : TJSONDeserialiser;
  PropList : PPropList;
  FieldName, FieldValue : string;
  DsBusObj : TDatasetBusObj;
  SWhere, TableName: string;
  TempQuery : TERPQuery;

  iObjID: Integer;
begin
  Result := False;

  // Deserialize the JSON object into common object
  JSONDesrialiser := TJSONDeserialiser.Create;
  try
    JSONDesrialiser.DatabaseConnection:= AppEnv.AppDb.TransConnection;
    Obj := JSONDesrialiser.DeserialiseObject(jsonIn);
    if not JSONDesrialiser.IsConsistent or not (Obj is TDatasetBusObj) then begin
      msg := 'POST - Error populating object... ';
      Exit;
    end;

    DsBusObj := TDatasetBusObj(Obj);
    TableName := DsBusObj.GetBusObjectTablename;

    iObjID := 0;
    if jsonIn.O['fields'].IntegerExists('ID') then
      iObjID := jsonIn.O['fields'].I['ID'];

    SWhere := DsBusObj.GetIDField +  ' = ' + IntToStr(iObjID);

    // Execute the delete statement
    TempQuery := TERPQuery.Create(nil);
    try
      TempQuery.Connection := AppEnv.AppDb.TransConnection;
      TempQuery.SQL.Add('DELETE FROM ' + TableName + ' WHERE ' + SWhere);
      TempQuery.Execute;
    finally
      TempQuery.Free;
    end;
  finally
    JSONDesrialiser.Free;
  end;
end;

function MakeErrorMessage(msg: string): string;
begin
  result := msg;
  if Pos(TAG_ResponseError,result) = 1 then exit;
  if Pos('Warning',result) = 1 then
    result := TAG_ResponseError + Copy(result,8,Length(result))
  else
    result := 'Error: ' + msg;
end;

{ TWebAPIThread }

constructor TWebAPIThread.Create(Logger: TLoggerBase; CreateSuspended:Boolean);
begin
  inherited Create(Logger, CreateSuspended);
  Status := wsIdle;
  fMySQLServer := '127.0.0.1';
  FreeOnTerminate := true;
  fLock := TCriticalSection.Create;

  TaskRec := TServerTaskRec.New('webapi', '');
  TaskRec.TaskStatus := 'Unknown';
  TaskRec.Save;
  //  RequestJson := TJsonObject.Create;
//  ResultJson := TJsonObject.Create;
  LastTime := now;
  {$Warnings Off}
  Resume;
  {$Warnings On}
end;

destructor TWebAPIThread.Destroy;
begin
//  RequestJson.Free;
//  ResultJson.Free;
  fLock.Free;
  TaskRec.Free;
  inherited;
end;

procedure TWebAPIThread.Execute;
var
  dt: TDatetime;
begin
  AppEnv.AppDb.Server := MySQLServer; // DefaultServer;
  AppEnv.UtilsClient.Logger := fLogger;
//  with AppEnv.AppDb.Connection do ;
  while not Terminated do begin
    try
      Lock;
      if Status = wsBusy then begin
        Unlock;
        try
          dt := Now;
          try
            ProcessRequest;
          finally
            Log('==========> Seconds Taken for Request :' + inttostr(Secondsbetween(dt,now)),ltDebug);
          end;
        finally
          LastTime := now;
          Lock;
          Status := wsFinished;
          Unlock;
        end;
      end
      else begin
        Unlock;
        Sleep(10);
      end;
    except
    end;
  end;
end;

function TWebAPIThread.Func_ProductAvailableQty: boolean;
var
  qry: TERPQuery;
  jsonVal: TJsonValue;
  obj, arrObj: TJsonObject;
  dtStart: TDateTime;

  AsOnDate: TDatetime;
  UOM: String;
  FilterType: TFiltertype;
  // (tFilterNone = 0, tProductList = 1, tSummary = 2, tDetails = 3, tExtraDetails = 4, tDetailswithSno = 5, tSerialnoList = 6);
  ProductID: Integer;
  DepartmentID: Integer;
  BatchNo: String;
  BatchExpiryDate: TDatetime;
  BinLocation: String;
  BinNumber: String;
  SerialNumber: String;
  QtyType: TQtytype;
  ExtraFields: String;
  ExtraWhere: String;
  CurSNIDtoExclude: Integer;
  IncludeDeptFields: Boolean ;
  GroupByUOM: Boolean;
  SNIfHasQty:Boolean;
begin
  dtStart := now;
  result := true;
  qry := DbSharedObj.GetQuery(appEnv.AppDb.Connection);
  try
    AsOnDate := 0;
    UOM := '';
//    FilterType := tSummary;
    ProductID := 0;
    DepartmentID := 0;
    BatchNo := '';
    BatchExpiryDate := 0;
    BinLocation := '';
    BinNumber := '';
    SerialNumber := '';
    QtyType := tAvailable;
    ExtraFields := 'PQABatch.CUSTFLD1';
    ExtraWhere := '';
    CurSNIDtoExclude := 0;
    IncludeDeptFields := False;
    GroupByUOM := False;
    SNIfHasQty := True;

    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['AsOnDate'];
    if Assigned(jsonVal) then
      AsOnDate := TDateTimeConverter.StrToDateTimeFmt('yyyy-mm-dd',jsonVal.AsString);
    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['UOM'];
    if Assigned(jsonVal) then
      UOM := jsonVal.AsString;
    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['DepartmentID'];
    if Assigned(jsonVal) then
      DepartmentID := StrToInt(jsonVal.AsString);
    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['BatchNo'];
    if Assigned(jsonVal) then
      BatchNo := jsonVal.AsString;
    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['BatchExpiryDate'];
    if Assigned(jsonVal) then
      BatchExpiryDate := TDateTimeConverter.StrToDateTimeFmt('yyyy-mm-dd',jsonVal.AsString);

    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['BinLocation'];
    if Assigned(jsonVal) then
      BinLocation := jsonVal.AsString;

    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['BinNumber'];
    if Assigned(jsonVal) then
      BinNumber := jsonVal.AsString;

    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['SerialNumber'];
    if Assigned(jsonVal) then begin
      if SplitPSN(jsonVal.AsString,ProductID,SerialNumber) then begin
        { we have ProdID and SN now .. }
      end
      else begin
        SerialNumber := jsonVal.AsString;

        jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['ProductID'];
        if Assigned(jsonVal) then
          ProductID := StrToInt(jsonVal.AsString);
      end;
    end
    else begin
      jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['ProductID'];
      if Assigned(jsonVal) then
        ProductID := StrToInt(jsonVal.AsString);
    end;

    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['QtyType'];
    if Assigned(jsonVal) then
      QtyType := TQtytype(StrToInt(jsonVal.AsString));

    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['FilterType'];
    if Assigned(jsonVal) then
      FilterType := TFiltertype(StrToInt(jsonVal.AsString))
    else begin
      if SerialNumber <> '' then
        FilterType := tDetailswithSno
      else if BatchNo <> '' then begin
        if BinNumber <> '' then
          FilterType := tExtraDetails
        else
         FilterType := tDetails
      end
      else if BinNumber <> '' then
         FilterType := tDetails
      else
         FilterType := tSummary;
    end;

    qry.SQL.Text :=
      'select T.* from (' +
      ProductQtyLib.SQL4ProductAvailableQty(
        AsOnDate,
        UOM,
        FilterType,
        ProductID,
        DepartmentID,
        BatchNo,
        BatchExpiryDate,
        BinLocation,
        BinNumber,
        SerialNumber,
        QtyType,
        ExtraFields,
        ExtraWhere,
        CurSNIDtoExclude,
        IncludeDeptFields,
        GroupByUOM,
        SNIfHasQty
      ) + ') as T';

    obj := ResultJson.O['JsonOut'];
    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['LimitCount'];
    if Assigned(jsonVal) then
      qry.SQL.Add('LIMIT ' + jsonVal.AsString);

    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['LimitFrom'];
    if Assigned(jsonVal) then
      qry.SQL.Add('OFFSET ' + jsonVal.AsString);

    obj.O['_System'].S['PrepTime'] := FormatDateTime('nn:ss.zzz',now-dtStart);
    dtStart := now;
    qry.Open;
    obj.O['_System'].S['QueryTime'] := FormatDateTime('nn:ss.zzz',now-dtStart);

    jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['FilterString'];
    if Assigned(jsonVal) and (jsonVal is TJsonString) then begin
      dtStart := now;
      qry.Filter := jsonVal.AsString;
      qry.Filtered := true;
      obj.O['_System'].S['FilterTime'] := FormatDateTime('nn:ss.zzz',now-dtStart);
    end;

    dtStart := now;
    while not qry.Eof do begin
      arrObj := JO;
      DatasetToJson(qry,arrObj);
      obj.A['ProductAvailableQty'].Add(arrObj);
      qry.Next;
    end;
    obj.O['_System'].S['OutputTime'] := FormatDateTime('nn:ss.zzz',now-dtStart);

  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TWebAPIThread.Func_SaleGroup: boolean;
var
  SaleID: integer;
  SaleLineID: integer;
  jsonVal: TJsonValue;
  obj, arrObj: TJsonObject;
  qry: TERPQuery;
begin
  result := true;
  qry := DbSharedObj.GetQuery(appEnv.AppDb.Connection);
  try
    obj := ResultJson.O['JsonOut'];

    jsonVAl := self.ParamVal('SaleID');
    if Assigned(jsonVal) then SaleID := jsonVal.AsInteger
    else SaleID := 0;

    jsonVAl := self.ParamVal('SaleLineID');
    if Assigned(jsonVal) then SaleLineID := jsonVal.AsInteger
    else SaleLineID := 0;

    qry.SQL.Add('select distinct');
    qry.SQL.Add('if(S.IsInvoice="T", "Invoice", if(S.IsSalesorder = "T", "Sales Order", if(S.IsCashSale = "T", "Cash Sale", if(S.IsRefund = "T", "Refund", if(S.IsLayby = "T", "Layby", ""))))) as TransactionType,');
    qry.SQL.Add('S.SaleID');
    qry.SQL.Add('from tblsales as S');
    if SaleID > 0 then
      qry.SQL.Add('where S.OriginalNo = (select distinct S1.OriginalNo from tblsales S1 inner join tblsaleslines as SL1 on SL1.SaleID = S1.SaleID where S1.SaleID = '+IntToStr(SaleID)+')')
    else if SaleLineID > 0 then
      qry.SQL.Add('where S.OriginalNo = (select distinct S1.OriginalNo from tblsales S1 inner join tblsaleslines as SL1 on SL1.SaleID = S1.SaleID where SL1.SaleLineID = '+IntToStr(SaleLineID)+')')
    else
      raise Exception.Create('Invaild request - Missing SaleID or SaleLineID');
    qry.SQL.Add('order By SaleID ASC');
    qry.Open;
    while not qry.Eof do begin
      arrObj := JO;
      DatasetToJson(qry,arrObj);
      obj.A['SaleGroup'].Add(arrObj);
      qry.Next;
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;

end;

function TWebAPIThread.Func_APList: boolean;
var
  qry: TERPQuery;
  TableName: string;
  obj, arrObj: TJsonObject;
  AsAtDate: TDateTime;
  DepartmentID: integer;
  SupplierID: integer;
  APObj: TAP_Report_Obj;
  jsonVal: TJsonValue;
  SummaryMode: boolean;
  RoundPlaces: integer;

begin

  result := true;
  obj := ResultJson.O['JsonOut'];
  AsAtDate := MaxDateTime;
  DepartmentID := 0;
  SupplierID := -1;
  SummaryMode := true;

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['AsAtDate'];
  if Assigned(jsonVal) then
    AsAtDate := TDateTimeConverter.StrToDateTimeFmt('yyyy-mm-dd',jsonVal.AsString);

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['DepartmentID'];
  if Assigned(jsonVal) then
    DepartmentID := jsonVal.AsInteger;

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['SupplierID'];
  if Assigned(jsonVal) then
    SupplierID := jsonVal.AsInteger;

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['Summary'];
  if Assigned(jsonVal) then
    SummaryMode := jsonVal.AsBoolean;


  TableName := TempTableUtils.UniqueTableName('APList');
  TempTableUtils.CreateTemporyTableFromTemplate(AppEnv.AppDb.Connection,'tmp_tblaccountspayable',TableName);
  try
    APObj := TAP_Report_Obj.Create(false);
    try
      APObj.CleanRefresh_AP_Table(true,AsAtDate,DepartmentID,DepartmentID = 0,SupplierID, false, TableName);
    finally
      APObj.Free;
    end;

    qry := DbSharedObj.GetQuery(appEnv.AppDb.Connection);
    try
      if SummaryMode then begin
        RoundPlaces := Appenv.RegionalOptions.DecimalPlaces;;

        qry.SQL.Add('select T.* from (');
        qry.SQL.Add('select');
        qry.SQL.Add('SupplierName,');
        qry.SQL.Add('Name,');
//        qry.SQL.Add('Round(Sum(`OriginalAmount`),'+inttostr(RoundPlaces)+') as OriginalAmount,');
        qry.SQL.Add('Round(Sum(`AmountDue` ),'+inttostr(RoundPlaces)+') as `AmountDue`,');
        qry.SQL.Add('Round(Sum(`Current` ),'+inttostr(RoundPlaces)+') as `Current`,');
        qry.SQL.Add('Round(Sum(`30Days` ),'+inttostr(RoundPlaces)+') as `30Days`,');
        qry.SQL.Add('Round(Sum(`60Days` ),'+inttostr(RoundPlaces)+') as `60Days`,');
        qry.SQL.Add('Round(Sum(`90Days` ),'+inttostr(RoundPlaces)+') as `90Days`,');
        qry.SQL.Add('Round(Sum(`120Days` ),'+inttostr(RoundPlaces)+') as `120Days`,');
        qry.SQL.Add('APNotes,');
        qry.SQL.Add('ClientID');
        qry.SQL.Add('from ' + TableName);
        qry.SQL.Add('group by ClientID');
        qry.SQL.Add(') as T');
      end
      else
        qry.SQL.Add('select T.* from (select * from ' + TableName + ') as T');

      jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['LimitCount'];
      if Assigned(jsonVal) then
        qry.SQL.Add('LIMIT ' + jsonVal.AsString);

      jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['LimitFrom'];
      if Assigned(jsonVal) then
        qry.SQL.Add('OFFSET ' + jsonVal.AsString);

      qry.Open;

      jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['FilterString'];
      if Assigned(jsonVal) and (jsonVal is TJsonString) then begin
        //dtStart := now;
        qry.Filter := jsonVal.AsString;
        qry.Filtered := true;
        //obj.O['_System'].S['FilterTime'] := FormatDateTime('nn:ss.zzz',now-dtStart);
      end;

      while not qry.Eof do begin
        arrObj := JO;
        DatasetToJson(qry,arrObj);
        obj.A['APList'].Add(arrObj);
        qry.Next;
      end;

    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  finally
    TempTableUtils.DestroyUserTemporaryTable(AppEnv.AppDb.Connection,TableName);
  end;
end;

function TWebAPIThread.Func_ARList: boolean;
var
  qry: TERPQuery;
  TableName: string;
  obj, arrObj: TJsonObject;
  AsAtDate: TDateTime;
  DepartmentID: integer;
  CustomerID: integer;
  ARObj: TAR_Report_Obj;
  jsonVal: TJsonValue;
  SummaryMode: boolean;
  RoundPlaces: integer;

begin
  result := true;
  obj := ResultJson.O['JsonOut'];
  AsAtDate := MaxDateTime;
  DepartmentID := 0;
  CustomerID := -1;
  SummaryMode := true;

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['AsAtDate'];
  if Assigned(jsonVal) then
    AsAtDate := TDateTimeConverter.StrToDateTimeFmt('yyyy-mm-dd',jsonVal.AsString);

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['DepartmentID'];
  if Assigned(jsonVal) then
    DepartmentID := jsonVal.AsInteger;

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['CustomerID'];
  if Assigned(jsonVal) then
    CustomerID := jsonVal.AsInteger;

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['Summary'];
  if Assigned(jsonVal) then
    SummaryMode := jsonVal.AsBoolean;


  TableName := TempTableUtils.UniqueTableName('ARList');
  TempTableUtils.CreateTemporyTableFromTemplate(AppEnv.AppDb.Connection,'tmp_tblaccountsreceivable',TableName);
  try
    ARObj := TAR_Report_Obj.Create(false);
    try
      ARObj.CleanRefresh_AR_Table(true,AsAtDate,DepartmentID,DepartmentID = 0,CustomerID, false, TableName);
    finally
      ARObj.Free;
    end;

    qry := DbSharedObj.GetQuery(appEnv.AppDb.Connection);
    try
      if SummaryMode then begin
        RoundPlaces := Appenv.RegionalOptions.DecimalPlaces;;

        qry.SQL.Add('select T.* from (');
        qry.SQL.Add('select');
        qry.SQL.Add('CustomerName,');
        qry.SQL.Add('CustomerType,');
        qry.SQL.Add('Name,');
//        qry.SQL.Add('Round(Sum(`OriginalAmount`),'+inttostr(RoundPlaces)+') as OriginalAmount,');
        qry.SQL.Add('Round(Sum(`AmountDue` ),'+inttostr(RoundPlaces)+') as `AmountDue`,');
        qry.SQL.Add('Round(Sum(`Current` ),'+inttostr(RoundPlaces)+') as `Current`,');
        qry.SQL.Add('Round(Sum(`1-7Days` ),'+inttostr(RoundPlaces)+') as `1-7Days`,');
        qry.SQL.Add('Round(Sum(`7-14Days` ),'+inttostr(RoundPlaces)+') as `7-14Days`,');
        qry.SQL.Add('Round(Sum(`14-21Days` ),'+inttostr(RoundPlaces)+') as `14-21Days`,');
        qry.SQL.Add('Round(Sum(`>21Days` ),'+inttostr(RoundPlaces)+') as `>21Days`,');
        qry.SQL.Add('Round(Sum(`1-30Days` ),'+inttostr(RoundPlaces)+') as `1-30Days`,');
        qry.SQL.Add('Round(Sum(`30-60Days` ),'+inttostr(RoundPlaces)+') as `30-60Days`,');
        qry.SQL.Add('Round(Sum(`60-90Days` ),'+inttostr(RoundPlaces)+') as `60-90Days`,');
        qry.SQL.Add('Round(Sum(`>90Days` ),'+inttostr(RoundPlaces)+') as `>90Days`,');
        qry.SQL.Add('Phone,');
        qry.SQL.Add('FaxNumber,');
        qry.SQL.Add('Mobile,');
        qry.SQL.Add('AltPhone,');
        qry.SQL.Add('ARNotes,');
        qry.SQL.Add('ClientID,');
        qry.SQL.Add('StopCredit');
        qry.SQL.Add('from ' + TableName);
        qry.SQL.Add('group by ClientID');
        qry.SQL.Add(') as T');
      end
      else
        qry.SQL.Add('select T.* from (select * from ' + TableName + ') as T');

      jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['LimitCount'];
      if Assigned(jsonVal) then
        qry.SQL.Add('LIMIT ' + jsonVal.AsString);

      jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['LimitFrom'];
      if Assigned(jsonVal) then
        qry.SQL.Add('OFFSET ' + jsonVal.AsString);

      qry.Open;

      jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['FilterString'];
      if Assigned(jsonVal) and (jsonVal is TJsonString) then begin
        //dtStart := now;
        qry.Filter := jsonVal.AsString;
        qry.Filtered := true;
        //obj.O['_System'].S['FilterTime'] := FormatDateTime('nn:ss.zzz',now-dtStart);
      end;

      while not qry.Eof do begin
        arrObj := JO;
        DatasetToJson(qry,arrObj);
        obj.A['ARList'].Add(arrObj);
        qry.Next;
      end;

    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  finally
    TempTableUtils.DestroyUserTemporaryTable(AppEnv.AppDb.Connection,TableName);
  end;
end;

function TWebAPIThread.Func_ValidateSN: boolean;
var
  SerialNumber: string;
  PQADetailsID: integer;
  ProductID: integer;
  DepartmentID: integer;
  TransDate: TDateTime;
  msg: string;
  jsonVal: TJsonValue;
  obj: TJsonObject;
  dtStart: TDateTime;
begin

  dtStart := now;
  result := true;
  obj := ResultJson.O['JsonOut'];

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['SerialNumber'];
  if Assigned(jsonVal) then begin
    if SplitPSN(jsonVal.AsString,ProductID,SerialNumber) then begin
      { we have ProdID and SN now .. }
    end
    else begin
      SerialNumber := jsonVal.AsString;

      jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['ProductID'];
      if Assigned(jsonVal) then
        ProductID := StrToInt(jsonVal.AsString)
      else
        ProductID := 0;
    end;
  end
  else
    SerialNumber := '';

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['DepartmentID'];
  if Assigned(jsonVal) then
    DepartmentID := StrToInt(jsonVal.AsString)
  else
    DepartmentID := 0;

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['PQADetailsID'];
  if Assigned(jsonVal) then
    PQADetailsID := StrToInt(jsonVal.AsString)
  else
    PQADetailsID := 0;

  jsonVal := RequestJson.O[TAG_CLOUD_Params].ValueByName['TransDate'];
  if Assigned(jsonVal) then
    TransDate := TDateTimeConverter.StrToDateTimeFmt('yyyy-mm-dd',jsonVal.AsString)
  else
    TransDate := Now;


  if BusObjPQA.TPQASN.ValidateSN(SerialNumber,PQADetailsID,ProductID,DepartmentID,AppEnv.AppDb.Connection,false,msg,TransDate) then begin
    obj.O['ValidateSN'].B['Result'] := true;
  end
  else begin
    obj.O['ValidateSN'].B['Result'] := false;
    obj.O['ValidateSN'].S['Message'] := msg;
  end;
  obj.O['_System'].S['FunctionTime'] := FormatDateTime('nn:ss.zzz',now-dtStart);

end;

function TWebAPIThread.GetFunction(const aResourceName: string): boolean;
begin
  result := false;
  if SameText(aResourceName,'ProductAvailableQty') then begin
    result := Func_ProductAvailableQty;
  end
  else if SameText(aResourceName,'ValidateSN') then begin
    result := Func_ValidateSN;
  end
  else if SameText(aResourceName,'SaleGroup') then begin
    result := Func_SaleGroup;
  end
  else if SameText(aResourceName,'ARList') then begin
    result := Func_ARList;
  end
  else if SameText(aResourceName,'APList') then begin
    result := Func_APList;
  end;
end;

function TWebAPIThread.GetObjectList(ResourceName: string; aList: TStringList;
  var msg: string; AddToList: boolean): boolean;
var
  ResourceClass: TPersistentClass;
  Resource: TPersistent;
  s: string;
  json: TJsonObject;
  x: integer;
  count: integer;
  PropList: PPropList;
  PropInfo: PPropInfo;
begin
  result:= true;
  ResourceClass:= GetClass(ResourceName);
  if Assigned(ResourceClass) then begin
    if aList.IndexOf(ResourceName) < 0 then begin
      if AddToList then
        aList.Add(ResourceName);
    end
    else
      exit;
    if ResourceClass.InheritsFrom(TBusObjBase) then begin
      s:= '';
      try
        Resource:=  TBusObjBaseClass(ResourceClass).Create(nil);
      except
        on e: exception do begin
          result:= false;
          msg := e.Message;
          exit;
        end;
      end;
      try
        s := TBusObjBase(Resource)._Schema;

        if (s <> '') then begin
          json:= JO;
          try
            json.AsString := s;
            for x := 0 to json.A['RefTypes'].Count -1 do begin
              if not GetObjectList(json.A['RefTypes'].Items[x].AsObject.S['Type'],aList,msg) then begin
                result:= false;
                exit;
              end;
            end;
          finally
            json.Free;
          end;
        end;

        { now get non-lookup sub objects eg invoice lines }
        Count := GetPropList(Resource.ClassInfo, tkProperties, nil);
        GetMem(PropList, Count * SizeOf(PPropInfo));
        try
          GetPropList(Resource.ClassInfo, tkProperties, PropList);
          for x := 0 to Count -1 do begin
            try
              PropInfo:= GetPropInfo(Resource,String(PropList[x].Name));
              if PropList[x].PropType^.Kind = tkClass then begin
                if not GetObjectList(GetObjectPropClass(PropInfo).ClassName,aList,msg,false) then begin
                  result:= false;
                  exit;
                end;
              end;
            except
              on e: exception do begin

              end;
            end;
          end;
        finally
          FreeMem(PropList, Count * SizeOf(PPropInfo));
        end;

      finally
        Resource.Free;
      end;

    end;
  end
  else begin
    { ignore things like TStringList  }
  end;
end;

function TWebAPIThread.GetResource(const aResourceName: string): boolean;
var
  //schema,
  params: TJsonObject;
  schemaPair: TJsonValuePair;
  obj: TJsonObject;
  arr: TJsonArray;

  procedure PopulateObject(const aClassName: string; aObj: TJsonObject; aArr: TJsonArray; parentDS: TDataset; aParams: TJsonObject; aLinkSQL: string);
  var
    sch: TJsonObject;
    pair, propPair: TJsonValuePair;
    qry: TERPQuery;
    s, tblSQL: string;
    propIdx: integer;
//    propDef: TJsonObject;
    arrObj: TJsonObject;
    subArr: TJsonArray;
    paramIdx: integer;
    fld: TField;
    paramVal: string;
    jsonVal: TJsonValue;
    paramExists: boolean;
    filterStr: string;
  begin
    paramExists := false;
    pair := ErpSchema.DbSchema().ItemByName[aClassName];
    if not Assigned(pair) then raise Exception.Create('Error Message - No schema data found for object ' + aClassName);
    sch := pair.Value.AsObject;
    qry := DbSharedObj.GetQuery(appEnv.AppDb.Connection);
    try
      tblSQL := sch.S['DbTableDef'];
      if aLinkSQL <> '' then begin
        if Pos('where',Lowercase(tblSQL)) > 0 then
          tblSQL := tblSQL + ' and ' + aLinkSQL
        else
          tblSQL := tblSQL + ' where ' + aLinkSQL;
      end;
      tblSQL := 'from (' + tblSQL + ') as T';
      if sch.O['Props'].Count > 0 then begin
        for propIdx := 0 to sch.O['Props'].Count -1 do begin
          propPair := sch.O['Props'][propIdx];
          if SameText(propPair.Value.AsObject.S['PropType'],'Field') then begin
            if qry.SQL.Count = 0 then
              s := 'select '
            else
              s := ', ';
            s := s + 'T.' + propPair.Value.AsObject.S['DbFieldName'] + ' as ' +
               propPair.Value.AsObject.S['PropName'];
            qry.SQL.Add(s);
          end;
        end;
      end
      else
        qry.SQL.Add('select T.*');
      qry.SQL.Add(tblSQL);
      for paramIdx := 0 to qry.ParamCount -1 do begin
        if Assigned(aParams) then begin
          jsonVal := aParams.ValueByName[qry.Params[paramIdx].Name];
          if Assigned(jsonVal) then begin
            paramVal := jsonVal.AsString;
            paramExists := true;
          end
          else begin
            paramVal := '';
            paramExists := false;
          end;
        end
        else if Assigned(parentDS) then begin
          fld := parentDS.FindField(qry.Params[paramIdx].Name);
          if Assigned(fld) then begin
            paramVal := fld.AsString;
            paramExists := true;
          end
          else begin
            paramVal := '';
            paramExists := false;
          end;
        end;
        if paramExists then begin
          qry.Params[paramIdx].AsString := paramVal;
        end
        else begin
          qry.Params[paramIdx].Clear;
        end;

      end;
      { look for special params .. }
      filterStr := '';
      jsonVal := nil;
      if Assigned(aParams) then begin
        jsonVal := aParams.ValueByName['LimitCount'];
        if Assigned(jsonVal) then
          qry.SQL.Add('LIMIT ' + jsonVal.AsString);

        jsonVal := aParams.ValueByName['LimitFrom'];
        if Assigned(jsonVal) then
          qry.SQL.Add('OFFSET ' + jsonVal.AsString);

        jsonVal := Params.ValueByName['FilterString'];
        if Assigned(jsonVal) and (jsonVal is TJsonString) then begin
          filterStr := jsonVal.AsString;
        end;
      end;

      { populate from query }
      qry.Open;

      if (filterStr <> '') and Assigned(jsonVal) then begin
        qry.Filter := jsonVal.AsString;
        qry.Filtered := true;
      end;

      if Assigned(aArr) then begin
        qry.First;
        while not qry.Eof do begin
          arrObj := JO;
          arrObj.S['_ClassName'] := pair.Name;
          aArr.Add(arrObj);
//          FieldsToObj(arrObj,qry);
          DatasetToJson(qry,arrObj);
          for propIdx := 0 to sch.O['Props'].Count -1 do begin
            propPair := sch.O['Props'][propIdx];
            if SameText(propPair.Value.AsObject.S['PropType'],'ObjectList') then begin
              subArr := arrObj.A[propPair.Value.AsObject.S['PropName']];
              PopulateObject(propPair.Value.AsObject.S['DbFieldName'],nil,subArr,qry,nil,propPair.Value.AsObject.S['LinkSQL']);
            end;
          end;

          qry.Next;
        end;

      end
      else begin
        { single object }
        aObj.S['_ClassName'] := pair.Name;
//        FieldsToObj(aObj,qry);
        DatasetToJson(qry,aObj);
        for propIdx := 0 to sch.O['Props'].Count -1 do begin
          propPair := sch.O['Props'][propIdx];
          if SameText(propPair.Value.AsObject.S['PropType'],'ObjectList') then begin
            subArr := aObj.A[propPair.Value.AsObject.S['PropName']];
            PopulateObject(propPair.Value.AsObject.S['DbFieldName'],nil,subArr,qry,nil,propPair.Value.AsObject.S['LinkSQL']);
          end;
        end;
      end;

    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end;

begin
  result := false;
  params := nil;
  if RequestJson.ObjectExists(TAG_CLOUD_Params) then
    params := RequestJson.O[TAG_CLOUD_Params];
//  schema := TJsonObject(ErpSchema.DbSchema().ItemByName[aResourceName]);
  schemaPair := ErpSchema.DbSchema().ItemByName[aResourceName];
  if not Assigned(schemaPair) then exit;
  result := true;

  obj := ResultJson.O['JsonOut'];
  arr := obj.A[schemaPair.Name];

  PopulateObject(aResourceName,obj,arr, nil,params,'');
//  ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
end;

procedure TWebAPIThread.Lock;
begin
  fLock.Acquire;
end;


function TWebAPIThread.MaxSaleGroupID(const aSaleID: integer): integer;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(appEnv.AppDb.Connection);
  try
   qry.SQL.Add('select MAX(S.SaleID) as SaleID');
   qry.SQL.Add('from tblsales as S');
   qry.SQL.Add('where S.OriginalNo = (select distinct S1.OriginalNo from tblsales S1 where S1.SaleID = '+IntToStr(aSaleID)+')');
   qry.Open;
   result := qry.FieldByName('SaleID').AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TWebAPIThread.ParamVal(const aParamName: string): TJsonValue;
begin
  result := RequestJson.O[TAG_CLOUD_Params].ValueByName[aParamName];
end;

procedure TWebAPIThread.ProcessRequest;
var
  MultiLogon: boolean;
  msg: string;
  ResourceClass: TPersistentClass;
  ResourceName: string;
  ResourceClassName: string;
  Resource: TPersistent;
  DsBusObj: TDatasetBusObj;
  ApiFunc: TApiFunc;
  JSONSerialiser: TJSONSerialiser;
  JSONDesrialiser: TJSONDeserialiser;
  KeyValue, GlobalRef: string;
  ObjList: TStringList;
  y: integer;
  ObjID: integer;
  FieldSL, ValSL: TStringList;
  FieldSQL: string;
  FieldCount: integer;
  Obj: TObject;
  msTimeStamp: TDateTime;
  fLogId :Integer;

  BusObjPLL : TProfitLossLayout;

  Confirmation : TJSONObject;

  procedure ListDb(json: TJsonObject);
  var
    qry: TMyQuery;
    JsonArray: TJsonArray;
    ArrayItem: TJsonObject;
    x: integer;
    WherePos: integer;
    LimitFrom, LimitCount, RecCount, SendCount: integer;
    limit, offset: integer;
    Rows: integer;
    field: TField;
    sl: TStringList;
    y: integer;
    s: string;
    PropList: TStringList;
    KeyValList: TStringList;
    PropInfo: PPropInfo;
    select: string;
    ListType: string;
    LoadSelectSQL: string;
    HasPropertyList: boolean;
    PropertyListParam: string;

  begin
    JsonArray:= Json.A[ResourceName];
    if RequestJson.Exists(TAG_CLOUD_Params) and RequestJson.O[TAG_CLOUD_Params].Exists('FieldList') then begin
      WherePos := Pos('WHERE', UpperCase(DsBusObj.SQL));
      qry := TMyQuery.Create(nil);
      try
        qry.Connection := AppEnv.AppDb.TransConnection;
        qry.SQL.Add('SELECT ' + RequestJson.O[TAG_CLOUD_Params].S['FieldList']);
        qry.SQL.Add('FROM ' + DsBusObj.BusObjectTableName);

        if WherePos > 0 then begin
          qry.SQL.Add(Copy(DsBusObj.SQL, WherePos, Length(DsBusObj.SQL)));
        end;

        LoadSelectSQL := '';
        if RequestJson.O[TAG_CLOUD_Params].StringExists('select') then begin
          select := RequestJson.O[TAG_CLOUD_Params].S['select'];
          LoadSelectSQL := Self.SelectParamToSQL(select, DsBusObj);
        end;

        if LoadSelectSQL <> '' then begin
          if WherePos > 0 then
            qry.SQL.Add('AND ' + LoadSelectSQL)
          else
            qry.SQL.Add('WHERE ' + LoadSelectSQL);
        end;

        LimitFrom := -1;
        LimitCount := -1;
        if RequestJson.Exists(TAG_CLOUD_Params) then begin
          if RequestJson.O[TAG_CLOUD_Params].Exists('LimitFrom') then
            LimitFrom := RequestJson.O[TAG_CLOUD_Params].I['LimitFrom'];
          if RequestJson.O[TAG_CLOUD_Params].Exists('LimitCount') then
            LimitCount := RequestJson.O[TAG_CLOUD_Params].I['LimitCount'];
        end;
        if LimitFrom > -1 then
          qry.SQL.Add('LIMIT ' + IntToStr(LimitFrom)+ ',' + IntToStr(LimitCount))
        else if LimitCount > -1 then
          qry.SQL.Add('LIMIT ' + IntToStr(LimitCount));

        qry.Open;
//        RecCount := 0;
        while not qry.Eof do begin
          ArrayItem := TJSONObject.Create;
          field := qry.FindField(DsBusObj.IDFieldName);
          if Assigned(field) then begin
            ArrayItem.I['ID'] := field.AsInteger;
          end;

          field := qry.FindField('mstimestamp');
          if Assigned(field) then
            ArrayItem.S['msTimeStamp'] := FormatDateTime(JsonDateTimeFormat, field.AsDateTime);

          field := qry.FindField('msupdatesitecode');
          if Assigned(field) then
            ArrayItem.S['msUpdateSiteCode'] := field.AsString;

          for x := 0 to qry.FieldCount - 1 do begin
            if (Lowercase(qry.Fields[x].FieldName) <> 'mstimestamp') and
               (Lowercase(qry.Fields[x].FieldName) <> Lowercase(DsBusObj.IDFieldName)) then begin
              case qry.Fields[x].DataType of
                ftString, ftFixedChar, ftWideString, ftWideMemo, ftFixedWideChar:
                  ArrayItem.S[qry.Fields[x].FieldName] := qry.Fields[x].AsString;

                ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint, ftLongWord,
                ftShortint, ftByte, DB.ftSingle:
                  ArrayItem.I[qry.Fields[x].FieldName] := qry.Fields[x].AsInteger;

                DB.ftFloat, DB.ftCurrency, DB.ftExtended:
                  ArrayItem.F[qry.Fields[x].FieldName] := qry.Fields[x].AsFloat;

                ftDate, ftTime, ftDateTime:
                  ArrayItem.DT[qry.Fields[x].FieldName] := qry.Fields[x].AsDateTime;

                ftUnknown, ftBoolean, ftBytes,
                ftVarBytes, ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor,
                ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftADT, ftArray, ftReference,
                ftDataSet, ftOraBlob, ftOraClob, ftVariant, ftInterface,
                ftIDispatch, ftGuid, ftTimeStamp, ftFMTBcd,
                ftOraTimeStamp, ftOraInterval, ftConnection, ftParams,
                ftStream, ftTimeStampOffset, ftObject, ftBCD: ;

              end;
            end;
          end;
          JsonArray.Add(ArrayItem);
          qry.Next;
        end;
      finally
        qry.Free;
      end;
      Exit;
    end;

    PropList := TStringList.Create;
    KeyValList := TStringList.Create;
    try
      { get a list of properties to send back }
      HasPropertyList := False;
      if RequestJson.Exists(TAG_CLOUD_Params) and RequestJson.O[TAG_CLOUD_Params].Exists('PropertyListOnly') then begin
        HasPropertyList := True;
        PropertyListParam := 'PropertyListOnly';
      end
      else if RequestJson.Exists(TAG_CLOUD_Params) and RequestJson.O[TAG_CLOUD_Params].Exists('PropertyList') then begin
        HasPropertyList := True;
        PropertyListParam := 'PropertyList';
        PropList.CommaText := DsBusObj.APIListDefaultProperties;
      end
      else begin
        PropList.CommaText := DsBusObj.APIListDefaultProperties;
      end;

      if HasPropertyList then begin
        sl := TStringList.Create;
        try
          sl.CommaText := RequestJson.O[TAG_CLOUD_Params].S[PropertyListParam];
          for x := 0 to SL.Count - 1 do
            PropList.Add(sl[x]);
        finally
          sl.Free;
        end;
      end;

      { normal list }
      ListType := '';

      { limits on number of records ? }
      LimitFrom := -1;
      LimitCount := -1;
      if RequestJson.Exists(TAG_CLOUD_Params) then begin
        if RequestJson.O[TAG_CLOUD_Params].Exists('LimitFrom') then
          LimitFrom := RequestJson.O[TAG_CLOUD_Params].I['LimitFrom'];
        if RequestJson.O[TAG_CLOUD_Params].Exists('LimitCount') then
          LimitCount := RequestJson.O[TAG_CLOUD_Params].I['LimitCount'];
        if RequestJson.O[TAG_CLOUD_Params].Exists('OrderBy') then
          DsBusObj.SQLOrder := RequestJson.O[TAG_CLOUD_Params].S['OrderBy'];
        if RequestJson.O[TAG_CLOUD_Params].StringExists('ListType') then
          ListType := RequestJson.O[TAG_CLOUD_Params].S['ListType'];
      end;

      RecCount := 0;
      SendCount := 0;

      { remove any properties we dont have }
      x := 0;
      while x < PropList.Count do begin
        PropInfo := GetPropInfo(DsBusObj, PropList[x]);
        if Assigned(PropInfo) and Assigned(PropInfo.GetProc) then
          Inc(x)
        else
          PropList.Delete(x);
      end;

      select := '';
      LoadSelectSQL := '';
      if RequestJson.O[TAG_CLOUD_Params].StringExists('select') then begin
        select := RequestJson.O[TAG_CLOUD_Params].S['select'];
        LoadSelectSQL := Self.SelectParamToSQL(select, DsBusObj);
      end;

      { don't load whole table into memory in one go! do it in chunks }
      if LimitCount > 0 then Limit := LimitCount else limit := DsBusObj.LimitCount;
      if limit <= 0 then limit := 2000;
      //if DsBusObj.ClassNameIs('TProductPicture') then { these contain large blob fields .. }
      //  limit := 5;
      if LimitFrom > 0 then offset := LimitFrom else offset := 0;

      while True do begin
        DsBusObj.LimitCount := limit;
        DsBusObj.LimitFrom := offset;
        if LoadSelectSQL <> '' then
          DsBusObj.LoadSelect(LoadSelectSQL, true)
        else
          DsBusObj.Load(true);

        Rows := DsBusObj.Count;
        try
          { now output data .. }
          while not DsBusObj.EOF do begin
//            if select <> '' then begin
//              if not DsBusObj.Parse(select) then begin
//                DsBusObj.Next;
//                Continue;
//              end;
//            end;

            { we have to do the limiting here after the Parse above }
            Inc(RecCount);
            if (LimitCount > 0) and ((DsBusObj.LimitCount <= 0) or (DsBusObj.LimitCount < LimitCount)) then begin
              if (LimitFrom > 0) then begin
                if RecCount <= LimitFrom then begin
                  DsBusObj.Next;
                  Continue;
                end;
              end;
            end;
            Inc(SendCount);
            if LimitCount > 0 then begin
              if SendCount > LimitCount then
                Exit; { we are done }
            end;

            if ListType = '' then begin
              ArrayItem := TJsonObject.Create;
              for x := 0 to PropList.Count - 1 do begin
                PropInfo := GetPropInfo(DsBusObj,PropList[x]);

                case PropInfo.PropType^.Kind of
                  TTypeKind.tkInteger:
                    ArrayItem.I[PropList[x]] := GetOrdProp(DsBusObj, PropInfo);
                  TTypeKind.tkInt64:
                    ArrayItem.I[PropList[x]] := GetInt64Prop(DsBusObj, PropInfo);
                  TTypeKind.tkFloat:
                    begin
                      if (CompareText(string(PropInfo^.PropType^.Name), 'TDateTime') = 0) then  begin
                        if (GetFloatProp(DsBusObj,PropInfo) = 0) then
                          ArrayItem.S[PropList[x]] := ''
                        else
                          ArrayItem.DT[PropList[x]] :=  GetFloatProp(DsBusObj,PropInfo);
                      end
                      else
                        ArrayItem.F[PropList[x]] :=  GetFloatProp(DsBusObj,PropInfo);
                    end;
                  TTypeKind.tkChar,
                  TTypeKind.tkWChar,
                  TTypeKind.tkString,
                  TTypeKind.tkLString,
                  TTypeKind.tkWString,
                  TTypeKind.tkUString:
                    ArrayItem.S[PropList[x]] :=  GetStrProp(DsbusObj, PropInfo);
                  TTypeKind.tkEnumeration:
                    if (CompareText('Boolean', string(PropInfo^.PropType^.Name)) = 0) then
                      ArrayItem.B[PropList[x]] := SameText(GetEnumProp(DsBusObj, PropInfo), 'True')
                    else
                      ArrayItem.S[PropList[x]] := GetEnumProp(DsBusObj, PropInfo);
                  TTypeKind.tkDynArray,
                  TTypeKind.tkArray,
                  TTypeKind.tkClass,
                  TTypeKind.tkRecord,
                  TTypeKind.tkPointer,
                  TTypeKind.tkSet,
                  TTypeKind.tkMethod,
                  TTypeKind.tkVariant,
                  TTypeKind.tkInterface,
                  TTypeKind.tkClassRef,
                  TTypeKind.tkProcedure:;
                end;
              end;

              if PropertyListParam <> 'PropertyListOnly' then begin
                KeyValList.CommaText := DsBusObj.KeyValue;
                if KeyValList.Count > 0 then begin
                  if KeyValList.Count = 1 then
                    ArrayItem.S['KeyValue'] := DsBusObj.KeyValue
                  else begin
                    for y := 0 to KeyValList.Count - 1 do begin
                      if y = 0 then s := '"' + KeyValList[y] + '"'
                      else s := s + ',"' + KeyValList[y] + '"';
                    end;
                    ArrayItem.S['KeyValue'] := s;
                  end;
                end;
              end;

              JsonArray.Add(ArrayItem);
            end
            else if SameText(ListType, 'Detail') then begin
              if not Assigned(JSONSerialiser) then
                JSONSerialiser := TJSONSerialiser.Create;
              JSONSerialiser.Clear;
              ArrayItem := JSONSerialiser.SerialiseObject(DsBusObj);
              JsonArray.Add(ArrayItem);
            end
            else begin
              raise Exception.Create('Invailid ListType: ' + ListType);
            end;

            DsBusObj.Next;
          end;

        finally
          DsBusObj.Close();
        end;

        if Rows < limit then
          exit; { we are done }
        offset := offset + limit;
      end;

    finally
      PropList.Free;
      KeyValList.Free;
      FreeAndNil(JSONSerialiser);
    end;
  end;

begin
  Log('Processing Start' + ', Thread ID ' + IntToStr(GetCurrentThreadId), ltDetail);
  ResultJson.Clear;
  ResultJson.S[TAG_ContentType] := 'application/json';
//  ResultJson.S[TAG_ContentType]:= 'application/vnd.trueerp.webapi+json';
  Resource:= nil;
  try
    try
(*      {$IFDEF DevMode}
      try
        logtext(Requestjson.asString);
        logtext('=========================================================================');
      Except
      end;
      {$ENDIF}*)

//       ShowMessage(RequestJson.A['URIParts'].Items[1].AsString);
//       ShowMessage(RequestJson.A['URIParts'].Items[2].AsString);
//      ShowMessage(RequestJson.A['URIParts'].Items[3].AsString);

      ResourceName := RequestJson.A['URIParts'].Items[2].AsString;
      ResourceClassName := {'T' +} ResourceName;
      ResourceClass := GetClass(ResourceClassName);

      fDatabase := RequestJson.S[TAG_ERPDatabase];
      fUserName := RequestJson.S[TAG_ERPUserName];
      fPassword := RequestJson.S[TAG_ERPPassword];

      if not SameText(AppEnv.AppDb.Database, fDatabase) then begin
        Log('Database Change :' + AppEnv.AppDb.Database + ',' + fDatabase);
        AppEnv.AppDb.Database := fDatabase;
        if not AppEnv.AppDb.VersionOk then begin
          if AppEnv.AppDb.VersionOkReason <> '' then begin
            Log(AppEnv.AppDb.VersionOkReason, ltError);
            ResultJson.S[TAG_ErrorMessage]:= AppEnv.AppDb.VersionOkReason;
          end
          else begin
            Log('Server and database versions do not match.', ltError);
            ResultJson.S[TAG_ErrorMessage] := 'Error: Server and database versions do not match';
          end;
          ResultJson.I[TAG_ResponseNo] := 500; { "Internal Server Error" }
          Exit;
        end;
      end;

      Log('Using Database Server: ' + AppEnv.AppDb.Server + ' Database: ' + AppEnv.AppDb.Database, ltDetail);

      if TSystemAPI.DoCloudRequest(RequestJson, ResultJson, OutStream, Appenv.AppDb.Connection, fLogger, TaskREc.ID) then begin
        { resuest has been handled .. so we are done }
        Exit;
      end;

      //if not SameText(AppEnv.AppDb.UserName, fUserName) then begin
      try
        AppEnv.AppDb.ConnectUser(RequestJson.S[TAG_ERPUserName], RequestJson.S[TAG_ERPPassword], TLogger(fLogger));
      except
        on eusr: exception do begin
          Log('Error: ' + eusr.Message,ltError);
          ResultJson.I[TAG_ResponseNo] := VS1_HTTP_Failed_Code; { "Forbidden" }
          ResultJson.S[TAG_ErrorMessage] := 'Forbidden: ' + RemoveCRLF(eusr.Message);
          Exit;
        end;
      end;
//        end;
      if not AppEnv.AppDb.Connection.Connected then  begin
        Log('Could not connect to ERP.', ltError);
        ResultJson.I[TAG_ResponseNo] := VS1_HTTP_Failed_Code; { "Forbidden" }
        ResultJson.S[TAG_ErrorMessage] := 'Forbidden: Could not connect to ERP';
        Exit;
      end;

      MultiLogon := Lowercase(RequestJson.S[TAG_ERPUserName]) = Lowercase(RequestJson.S['ERPWebUserName']);
      if not AppEnv.UtilsClient.ConnectUser(msg, MySQLServer, AppEnv.AppDb.Database, RequestJson.S[TAG_ERPUserName], '', '', MultiLogon) then begin
        Log('Could not connect to ERP. ' + RemoveCRLF(msg),ltError);
        ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Forbidden" }
        ResultJson.S[TAG_ErrorMessage]:= 'Forbidden: Could not connect to ERP. ' + RemoveCRLF(msg);
        exit;
      end;

      try
        CoInitialize(nil);

        try
          fLogId := TWebAPIRequestLog.NewEntry(nil, now, 0, RequestJson.asString );

          try
            if TVS1AdminAPI.DoCloudRequest(RequestJson,ResultJson, OutStream, Appenv.AppDb.Connection, fLogger, TaskREc.id) then begin
              { resuest has been handled .. so we are done }
              //ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
              Exit;
            end;

            if TGTAdminAPI.DoCloudRequest(RequestJson, ResultJson, OutStream, Appenv.AppDb.Connection, fLogger, TaskREc.id) then begin
              { resuest has been handled .. so we are done }
              //ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
              Exit;
            end;

            if TCloudAPI.DoCloudRequest(RequestJson, ResultJson, OutStream, Appenv.AppDb.Connection, fLogger) then begin
              { resuest has been handled .. so we are done }
              Exit;
            end;

            if RequestJson.S['Command'] = 'GET' then begin
//              if SysUtils.SameText(ResourceClassName,'TAppointmentStatusType') then
//                Log('');

      //         ShowMessage('ResourceName ' + ResourceName);
              if not Assigned(ResourceClass) then begin
                if (not GetResource(ResourceName)) and (not GetFunction(ResourceName)) then begin
                  Log('Resourse not found.', ltError);
                  ResultJson.I[TAG_ResponseNo] := 404; { "Not Found" }
                  ResultJson.S[TAG_ErrorMessage] := 'Could not find the requested resource "' + ResourceName + '"';
                end
                else begin
                  ResultJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                end;
                Exit;
              end
              else if ResourceClass.ClassName = TObjBasicInfoClass.ClassName then
                Resource := TObjBasicInfoClass(ResourceClass).Create(RequestJson.O[TAG_CLOUD_Params].S['ClassName'], RequestJson.O[TAG_CLOUD_Params].ItemByName['ID'].Value.AsInteger)
              else if ResourceClass.InheritsFrom(TDatasetBusObj) then begin
                Resource := TDatasetBusObjClass(ResourceClass).Create(nil);
              end
              else
                Resource := ResourceClass.Create;
       //              ShowMessage('Resource.ClassName  ' + Resource.ClassName);

              if Resource.ClassName = 'TProfitLossLayout' then begin
              //  ShowMessage('getting TProfitLossLayout');
                BusObjPLL := TProfitLossLayout(Resource);

              //                        if RequestJson.O[TAG_CLOUD_Params].B['Up'] then
              //                           ShowMessage('up')
              //                        else
              //                           ShowMessage('down');

                // fPassLive := Json.O['ozedi'].S['PassLive'];

                // ShowMessage( BusObjPLL.Name );

                try
                   BusObjPLL.AssignParams(RequestJson.O[TAG_CLOUD_Params], RequestJson.A['URIParts'].Items[3].AsInteger);
                except
                end;
              end;

              DsBusObj:= nil;

              if Resource is TDatasetBusObj then begin
                DsBusObj := TDatasetBusObj(Resource);
                DsBusObj.Connection := TMyDacDataConnection.Create(DsBusObj);
                DsBusObj.Connection.MyDacConnection := AppEnv.AppDb.TransConnection;
              end
              else if Resource is TRepObjBase then begin
//                ResultJson.O['JsonOut'].Assign(TRepObjBase(Resource).Json);
                TRepObjBase(Resource).Params := RequestJson.O[TAG_CLOUD_Params];
                ResultJson.O['JsonOut'] :=  TRepObjBase(Resource).JsonResult;
                ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
                Exit;
              end
              else if Resource is TPersistent then begin
                JSONSerialiser:= TJSONSerialiser.Create;
                try
                  Log('GET - Object: ' + Resource.ClassName + ' ok.',ltDetail);
                  ResultJson.O['JsonOut']:= JSONSerialiser.SerialiseObject(Resource);
                  ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
                finally
                  JSONSerialiser.Free;
                end;
                Exit;
              end
              else begin
                { differnt sort of object }
                Log('Unsupported class of object.', ltError);
                ResultJson.I[TAG_ResponseNo] := 404; { "Not Found" }
                ResultJson.S[TAG_ErrorMessage] := 'Unsupported class of object';
                Exit;
              end;

              GlobalRef := '';
              KeyValue := '';
              ObjID := 0;
              if RequestJson.Exists(TAG_CLOUD_Params) then begin
                if RequestJson.O[TAG_CLOUD_Params].StringExists('GlobalRef') then
                  GlobalRef := RequestJson.O[TAG_CLOUD_Params].S['GlobalRef']
                else if RequestJson.O[TAG_CLOUD_Params].StringExists('KeyValue') then
                  KeyValue := SysUtils.AnsiDequotedStr(RequestJson.O[TAG_CLOUD_Params].S['KeyValue'], '"')
                else if RequestJson.O[TAG_CLOUD_Params].Exists('SaleGroupID') then
                  ObjID := MaxSaleGroupID(RequestJson.O[TAG_CLOUD_Params].ItemByName['SaleGroupID'].Value.AsInteger);
              end;

              if (RequestJson.A['URIParts'].Count > 3) and (SameText(RequestJson.A['URIParts'].Items[3].AsString, 'Schema')) then begin
                if resource is TBusObjBase then begin
                  Log('GET Schema for ' + Resource.ClassName + ' ok.', ltDetail);
                  ResultJson.O['JsonOut'].AsString:= TBusObjBase(Resource)._Schema;
                  ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
                end
                else begin
                  Log('GET Schema for ' + Resource.ClassName + ' not found.', ltError);
                  ResultJson.I[TAG_ResponseNo] := 404; { "Not Found" }
                  ResultJson.S[TAG_ErrorMessage] := 'Not Found';
                end;
              end
              else if (RequestJson.A['URIParts'].Count > 3) and (SameText(RequestJson.A['URIParts'].Items[3].AsString, 'ObjectList')) then begin
                Log('GET ObjectList for ' + Resource.ClassName + '.', ltDetail);
                ObjList := TStringList.Create;
                try
                  ObjList.CaseSensitive := false;
                  if GetObjectList(ResourceName, ObjList, msg) then begin
                    with TJsonObject.Create do begin
                      try
                        for y := ObjList.Count - 1 downto 0 do
                          A['List'].Add(ObjList[y]);
                        ResultJson.O['JsonOut'].AsString := AsString;
                        ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
                      finally
                        Free;
                      end;
                    end;
                  end
                  else begin
                    ResultJson.I[TAG_ResponseNo] := 404; { "Not Found" }
                    ResultJson.S[TAG_ErrorMessage] := msg;
                  end;
                finally
                  ObjList.Free;
                end;
              end
              { get a list or single object instance }
              else if (RequestJson.A['URIParts'].Count > 3) or (GlobalRef <> '') or (KeyValue <> '') or (ObjID > 0) then begin
                if AppEnv.ThreadId <> GetCurrentThreadID then
                  Log('Threads do not match!', ltError);
                if ((GlobalRef <> '') or (KeyValue <> '') or (ObjID > 0) or TryStrToInt(RequestJson.A['URIParts'].Items[3].AsString,ObjID) or
                  StrToKeyString(RequestJson.A['URIParts'].Items[3].AsString,KeyValue)) then begin
                  { specific instance }
                  if (not Assigned(DsBusObj)) or
                     (Assigned(DsBusObj) and
                     ((ObjID > 0) or (KeyValue <> '') or (GlobalRef <> ''))) then begin

                    JSONSerialiser:= TJSONSerialiser.Create;
                    try
                      try
                        if Assigned(DsBusObj) then begin
                          if (ObjID > 0) then
                            DsBusObj.Load(ObjID, true)
                          else if (GlobalRef <> '') then
                            DsBusObj.Load(GlobalRef, true)
                          else begin
                            if DsBusObj.GetKeyStringField <> '' then begin
                              FieldSL := TStringList.Create;
                              ValSL:= TStringList.Create;
                              try
                                FieldSQL:= '';
                                FieldSL.CommaText:= DsBusObj.GetKeyStringField;
                                if FieldSL.Count = 1 then
                                  FieldSQL:= '`' + FieldSL[0] + '` = ' + QuotedStr(StringReplace(KeyValue,'\','\\',[rfReplaceAll]))
                                else begin
                                  ValSL.CommaText:= KeyValue;
                                  if ValSL.Count <> FieldSL.Count then begin
                                    Log('GET - Key Value list count ('+IntToStr(ValSL.Count)+') does not match Key Property list count ('+IntToStr(FieldSL.Count)+') for ' + DsBusObj.ClassName,ltError);
                                    ResultJson.I[TAG_ResponseNo]:= 406; { "Not Acceptable" }
                                    ResultJson.S[TAG_ErrorMessage]:= 'Error: Key Value list count ('+IntToStr(ValSL.Count)+') does not match Key Property list count ('+IntToStr(FieldSL.Count)+') for ' + DsBusObj.ClassName;
                                    exit;
                                  end;
                                  for FieldCount := 0 to FieldSL.Count -1 do begin
                                    if ValSL[FieldCount] <> '' then begin
                                      if FieldSQL <> '' then FieldSQL:= FieldSQL + ' and ';
                                      FieldSQL:= FieldSQL + '`' + FieldSL[FieldCount] + '` = ' + QuotedStr(StringReplace(ValSL[FieldCount],'\','\\',[rfReplaceAll]));
                                    end;
                                  end;
                                end;
                              finally
                                FieldSL.Free;
                                ValSL.Free;
                              end;
                              DsBusObj.LoadSelect(FieldSQL, true);
                            end
                            else begin
                              Log('GET - KeyStringField not defined for ' + DsBusObj.ClassName,ltError);
                              ResultJson.I[TAG_ResponseNo]:= 500; { "Internal Server Error" }
                              ResultJson.S[TAG_ErrorMessage]:= 'Error: KeyStringField not defined for ' + DsBusObj.ClassName;
                              exit;
                            end;
                          end;
                          if DsBusObj.Count = 0 then begin
                            if (ObjID > 0) then
                              ResultJson.S[TAG_ErrorMessage]:= 'Instance not found for object "' + DsBusObj.ClassName +
                                '" and ID ' + IntToStr(ObjID)
                            else if (GlobalRef <> '') then
                              ResultJson.S[TAG_ErrorMessage]:= 'Instance not found for object "' + DsBusObj.ClassName +
                                '" and GlobalRef "' + GlobalRef + '"'
                            else
                              ResultJson.S[TAG_ErrorMessage]:= 'Instance not found for object "' + DsBusObj.ClassName +
                                '" and Key Value "' + KeyValue + '"';

                            Log('GET - Instance not found for object "' + DsBusObj.ClassName +
                              '" Key Value ("' + KeyValue + '") ID (' + IntToStr(ObjID) + ') GlobalRef (' + GlobalRef + ').',ltError);
                            ResultJson.I[TAG_ResponseNo]:= 404; { "Not Found" }
                            exit;
                          end;
                        end;
                        ResultJson.O['JsonOut']:= JSONSerialiser.SerialiseObject(Resource);
                        if (not ResultJson.O['JsonOut'].StringExists('type')) or (ResultJson.O['JsonOut'].S['type'] = '') then begin
                          Log('GET - Error reading object for "' + Resource.ClassName + '", object type missing',ltError);
                          ResultJson.I[TAG_ResponseNo]:= 500; { "Internal Server Error" }
                          ResultJson.S[TAG_ErrorMessage]:= 'Error reading object for "' + Resource.ClassName + '", object type missing';
                          exit;
                        end;
                      except
                        on exc: exception do begin
                          Log('GET - Error: ' + exc.Message + ' ThreadID = ' + IntToStr(GetCurrentThreadID),ltError);
                          ResultJson.I[TAG_ResponseNo]:= 500; { "Internal Server Error" }
                          ResultJson.S[TAG_ErrorMessage]:= 'Error: ' + RemoveCRLF(exc.Message);
                          exit;
                        end;
                      end;
                    finally
                      JSONSerialiser.Free;
                    end;

                    ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
                  end
                  else begin
                    { invalid ID  }

                    Log('GET - Invalid Object/ID.',ltError);
                    ResultJson.I[TAG_ResponseNo]:= 500; { "Internal Server Error" }
                    ResultJson.S[TAG_ErrorMessage]:= 'Error: Invalid Object/ID.';
                  end;


                end
                else begin
                  Log('GET - Invalid URI: "' +RequestJson.S['URI'] + '".',ltError);
                  ResultJson.I[TAG_ResponseNo]:= 404; { "Not Found" }
                  ResultJson.S[TAG_ErrorMessage]:= 'Invalid URI: "' +RequestJson.S['URI'] + '"';
                  exit;
                end;
              end
              else begin
                 {  }
                { list of objects }
                if (Resource is TDatasetBusObj) and (not TDatasetBusObj(Resource).CanRead) then begin
                  Log('GET - User does not have rights to read ' +Resource.ClassName + '.',ltError);
                  ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Failed_Code; { "Forbidden" }
                  ResultJson.S[TAG_ErrorMessage]:= 'User does not have rights to read ' +Resource.ClassName + '.';
                  exit;
                end
                else begin
                  (*
                  ResultJson.O['JsonOut'].O['Test'].I['Data']:= 123;
                  ResultJson.O['JsonOut'].O['Test'].S['FirstName']:= 'Peter';
                  ResultJson.O['JsonOut'].O['Test'].S['SecndName']:= 'Pan';
                  *)
                  ListDb(ResultJson.O['JsonOut']);
                  Log('GET - List for ' + Resource.ClassName + ' ok.', ltDetail);
                  ResultJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                end;
              end;
            end
            else if (RequestJson.S['Command'] = 'POST') {or (ARequestInfo.CommandType = hcPUT)} then begin
              if not RequestJson.ObjectExists('JsonIn') then begin
                Log('POST - Input data for ' + ResourceName + ' is empty.',ltError);
                ResultJson.I[TAG_ResponseNo] := 406; { "Not Acceptable" }
                ResultJson.S[TAG_ErrorMessage] := 'Data is empty';
                Exit;
              end;

              // ShowMessage('ResourceName ' + ResourceName + '  RequestJson ' + RequestJson.AsString);
              if SameText(ResourceName, 'TApiFunction') then begin
                ResultJson.AsString := TApiFunction.Execute(RequestJson.O['JsonIn']);
                // ShowMessage('ResultJson ' + ResultJson.AsString);
                Exit;
              end;

              if Assigned(ResourceClass) then begin
                if ResourceClass.InheritsFrom(ApiFuncObj.TApiFunc) then begin
                  ApiFunc := TApiFuncClass(ResourceClass).Create;
                  ApiFunc.JsonIn := RequestJson.O['JsonIn'];
                  ApiFunc.JsonOut := ResultJson.O['JsonOut'];
                  ApiFunc.Execute;

                  OutStream := ApiFunc.StreamOut;
                  ResultJson.I[TAG_ResponseNo] := ApiFunc.ResponceNo;
                  if ApiFunc.ErrorMessage <> '' then
                    ResultJson.S[TAG_ErrorMessage] := ApiFunc.ErrorMessage;
                  Exit;
                end;
              end;

              // ShowMessage('JSON type ' + RequestJson.O['JsonIn'].S['type'] + '  ResourceName ' + ResourceName);
              if Lowercase(RequestJson.O['JsonIn'].S['type']) <> Lowercase(ResourceName) then begin
                Log('POST - URI Resource does not match request class type.', ltError);
                ResultJson.I[TAG_ResponseNo] := 406; { "Not Acceptable" }
                ResultJson.S[TAG_ErrorMessage] := 'URI Resource does not match request class type';
                Exit;
              end;

              if not RequestJson.O['JsonIn'].ObjectExists('fields') then begin
                if RequestJson.O['JsonIn'].ArrayExists('layout') then begin  // Jacob ?
                  BusObjPLL.SaveLayout(RequestJson);
                   // ResultJson.O['JsonOut']:= JSONSerialiser.SerialiseObject(Resource);
                  Confirmation := TJSONObject.Create;
                  Confirmation.S['type'] := 'TProfitLossLayout';
                  Confirmation.S['action'] := 'save';
                  Confirmation.S['layout'] := 'saved';

                  ResultJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                  ResultJson.O['JsonOut'] := Confirmation;
                  Exit;
                end
                else if RequestJson.O['JsonIn'].ArrayExists('objects') then begin  // Multiple object creation   by Wang
                  msg := '';
                  SaveBusObjArray(RequestJson.O['JsonIn'], msg);

                  ResultJson.O['JsonOut'].S['type'] := RequestJson.O['JsonIn'].S['type'];
                  if msg <> '' then begin
                    ResultJson.I[TAG_ResponseNo]:= 406; { "Not Acceptable" }
                    ResultJson.O['JsonOut'].S['result'] := msg;
                  end
                  else begin
                    ResultJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                    ResultJson.O['JsonOut'].S['result'] := 'Success';
                  end;

                  Exit;
                end
                else begin
                   Log('POST - Request does not contain object "fields".', ltError);
                   ResultJson.I[TAG_ResponseNo] := 406; { "Not Acceptable" }
                   ResultJson.S[TAG_ErrorMessage] :=
                     'Request does not contain object "fields" or "layout"';
                   Exit;
                end;
              end;

              // Delete request   --- by Wang
              if RequestJson.O['JsonIn'].BooleanExists('delete') then begin
                msg := '';
                DeleteBusObj(RequestJson.O['JsonIn'], msg);

                ResultJson.O['JsonOut'].S['type'] := RequestJson.O['JsonIn'].S['type'];
                if msg <> '' then begin
                  ResultJson.I[TAG_ResponseNo]:= 406; { "Not Acceptable" }
                  ResultJson.O['JsonOut'].S['result'] := msg;
                end
                else begin
                  ResultJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                  ResultJson.O['JsonOut'].S['result'] := 'Success';
                end;

                Exit;
              end;

              ObjId := 0;
              if RequestJson.O['JsonIn'].O['fields'].IntegerExists('id') then
                ObjId := RequestJson.O['JsonIn'].O['fields'].I['id'];
              AppEnv.AppDb.TransConnection.StartTransaction;
              JSONDesrialiser := TJSONDeserialiser.Create;
              Obj := nil;
              try
                try
                  JSONDesrialiser.DatabaseConnection := AppEnv.AppDb.TransConnection;
                  if RequestJson.Exists(TAG_CLOUD_Params) and RequestJson.O[TAG_CLOUD_Params].Exists('RawMode') then begin
                    if SameText(RequestJson.O[TAG_CLOUD_Params].ItemByName['RawMode'].Value.AsString, 'True') then
                      JSONDesrialiser.RawMode := true;
                  end;
                  if AppEnv.ThreadId <> GetCurrentThreadID then
                    Log('Threads do not match!', ltError);
                  Obj := JSONDesrialiser.DeserialiseObject(RequestJson.O['JsonIn']);
                  if not JSONDesrialiser.IsConsistent then begin
                    Log('POST - Error populating object: ' + JSONDesrialiser.Messages.CommaText, ltDetail);
                    ResultJson.I[TAG_ResponseNo] := 406; { "Not Acceptable" }
                    ResultJson.S[TAG_ErrorMessage] := 'Error: ' + JSONDesrialiser.Messages.CommaText;
                    Exit;
                  end;

                  ResultJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
                  ResultJson.O['JsonOut'].S['type'] := RequestJson.O['JsonIn'].S['type'];

                  if Obj is TDatasetBusObj then begin
                    DsBusObj := TDatasetBusObj(Obj);
//                    Log('Before Save ' + DsBusObj.ClassName + ' ' + DsBusObj.MsUpdateSiteCode,ltDebug);
                    msTimeStamp := 0;
                    if RequestJson.O['JsonIn'].O['fields'].Exists('msTimeStamp') then
                      msTimeStamp := RequestJson.O['JsonIn'].O['fields'].ItemByName['msTimeStamp'].Value.AsDateTime;
                    DsBusObj.SilentMode := true;
                    msg := '';
                    if not SaveBusObj(DsBusObj, msg) then begin
                      Log('POST - Error saving object: ' +  msg,ltError);
                      ResultJson.I[TAG_ResponseNo] := 406; { "Not Acceptable" }
                      ResultJson.S[TAG_ErrorMessage] := MakeErrorMessage(msg);
                      exit;
                    end;

                    if DsBusObj is TMSBusObj then begin
                      if (msTimeStamp <> 0) then begin
                        { the save above will cause db trigger to update msTimeStamp .. so set back to correct value }
                        TMSBusObj(DsBusObj).FlagAsUpdated(msTimeStamp);
                      end;

                    end;
                    ResultJson.O['JsonOut'].O['fields'].I['ID'] := DsBusObj.ID;
                    if DsBusObj is TMSBusObj then
                      ResultJson.O['JsonOut'].O['fields'].S['GlobalRef']:= TMSBusObj(DsBusObj).GlobalRef;

                    Log('POST - Object saved ok, ID = ' +  IntToStr(DsBusObj.ID),ltDetail);
                  end;
                except
                  on ex: exception do begin
                    Log('POST - Error: ' + ex.Message + ' ThreadID = ' + IntToStr(GetCurrentThreadID),ltError);
                    ResultJson.I[TAG_ResponseNo] := 500; { "Internal Server Error" }
                    ResultJson.S[TAG_ErrorMessage] := 'Error: ' + RemoveCRLF(ex.Message);
                    Exit;
                  end;
                end;
//                Log('After Save ' + DsBusObj.ClassName + ' ' + DsBusObj.MsUpdateSiteCode,ltDebug);
                AppEnv.AppDb.TransConnection.Commit;
              finally
                if Assigned(Obj) then begin
                  if (Obj is TDatasetBusObj) then
                    TDatasetBusObj(Obj).UnLock;
                end;
                try JSONDesrialiser.Free;  { Obj is freeed when JSONDesrialiser is freeed } Except End;
                if AppEnv.AppDb.TransConnection.InTransaction then
                  AppEnv.AppDb.TransConnection.Rollback;
              end;
            end
            else if (RequestJson.S['Command'] = 'OPTIONS') then begin
              ResultJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code;
            end
            else begin
              Log('Command ' + RequestJson.S['Command'] + ' Not Implemented',ltError);
              ResultJson.I[TAG_ResponseNo]:= 501; { "Not Implemented" }
              ResultJson.S[TAG_ErrorMessage]:= 'Command ' + RequestJson.S['Command'] + ' Not Implemented';
              Exit;
            end;
          Finally
            TWebAPIRequestLog.UpdateEntry(nil, fLogID, now);
          end;
        finally
//            AppEnv.UtilsClient.Logger := nil;
          Resource.Free;
          CoUninitialize();
        end;
      finally
        AppEnv.UtilsClient.Disconnect;
      end;
      finally
        AppEnv.AppDb.TransConnection.Disconnect;
        AppEnv.AppDb.Connection.Disconnect;
      end;
  except
    on e: exception do begin
      Log('Error: ' + e.Message, ltError);
      ResultJson.I[TAG_ResponseNo] := 500; { "Internal Server Error" }
      ResultJson.S[TAG_ErrorMessage] := 'Error: ' + RemoveCRLF(e.Message);
    end;
  end;
end;

function TWebAPIThread.SelectParamToSQL(aSelectParam: string; aDsObj: TDatasetBusObj): string;
var
  I : Integer;
  item : string;
  IsField : Boolean;
  IsBool : Boolean;
  data : string;
  isf7LikeFound : Boolean;
  isf6LikeFound : Boolean;
  isQuoted : Boolean;

  function FormatItem(const aValue:String) : String;
  begin
         if isf7LikeFound then Result := '%' + aValue + '%' // contains
    else if isf6LikeFound then Result :=  aValue + '%' // starts with
    else if SameText(item,'F7like') then result := 'like'
    else if SameText(item,'F6like') then result := 'like'
    else Result := aValue;
  end;
begin
  data := '';
  IsField := false;
  if (not aDsObj.DatasetAssigned) then
    aDsObj.Load(0);

  for I := 1 to Length(aSelectParam) do begin
    if aSelectParam[I] = '[' then begin
      if IsField then raise Exception.Create('Error processing Select statement - illegal character "[" found in field name.');
      IsField := True;
      item := '';
    end
    else if aSelectParam[I] = ']' then begin
      if not IsField then raise Exception.Create('Error processing Select statement - illegal character "]" found in statement.');
      IsField := False;
      data := data + aDsObj.PropertyNameToFieldName(item);
      item := '';
    end
    else if IsField then begin
      item := item + aSelectParam[I];
    end
    else begin
      data := data + aSelectParam[I];
    end;
  end;

  { convert booleans .. }
  item := '';
  isf7LikeFound := False;
  isf6LikeFound := False;
  isQuoted := False;
  for I := 1 to Length(data) do begin
    if data[I] = '"' then
      if isQuoted then
        isQuoted := False
      else
        isQuoted := True;

    if not (TCharacter.IsLetter(data[I])) and not(TCharacter.IsNumber(data[I])) and (data[I] <> '_') and (not isQuoted or (data[I] <> ' ')) then begin
      { not a letter }
      if item <> '' then begin
        if SameText(item, 'true') then begin
          Result := Result + '"T"';
          item := '';
        end else if SameText(item, 'false') then begin
          Result := Result + '"F"';
          item := '';
        end else begin
          Result := Result + FormatItem(item);
          isf7LikeFound := SameText(item, 'F7like') or SameText(item, 'like');
          isf6LikeFound := SameText(item, 'F6like');
          item := '';
        end;
      end else begin
        { item is blank }
      end;
      Result := Result + data[I]
    end
    else begin
      { is a letter }
      item := item + data[I];
    end;
  end; // end for

  if item <> '' then begin
    if SameText(item, 'true') then begin
      Result := result + '"T"';
    end
    else if SameText(item, 'false') then begin
      Result := Result + '"F"';
    end
    else begin
      Result := Result + item;
    end;
  end

end;

procedure TWebAPIThread.SetStatus(const Value: TWebAPIThreadStatus);
begin
  FStatus := Value;
end;

function TWebAPIThread.SplitPSN(const aValue: string; var aPartsID: integer;
  var aSerialNumber: string): boolean;
var
  arr: TStringDynArray;
  x: integer;
begin
  result := false;
  arr := SplitString(aValue,'-');
  if (Length(arr) >= 3) and SameText(arr[0],'PSN') then begin
    result := true;
    aPartsID := StrToIntDef(arr[1],0);
    aSerialNumber := '';
    for x := 2 to High(arr) do begin
      if aSerialNumber <> '' then aSerialNumber := aSerialNumber + '-';
      aSerialNumber := aSerialNumber + arr[x];
    end;
  end;
end;

procedure TWebAPIThread.Unlock;
begin
  fLock.Release;
end;

{ TApiThreadList }

constructor TApiThreadList.Create(aLogger: TLoggerBase);
begin
  fMySQLServer := '127.0.0.1';
  fList := TObjectList.Create(False);
  fLock := TCriticalSection.Create;
  fLogger := aLogger;
  FMaxThreadCount := 10;
  CleanupThread := TCleanupThread.Create(Self);
end;

destructor TApiThreadList.Destroy;
var
  x: Integer;
begin
  for x := 0 to fList.Count - 1 do
    TWebAPIThread(fList[x]).Terminate;
  fList.Free;
  fLock.Free;
  inherited;
end;

procedure TApiThreadList.DoHTTPRequest(RequestJson, ResultJson: TJsonObject;
  var OutStream: TStream);
var
  StartTime: TDateTime;
  ResourceName: string;
//  ResourceClass: TPersistentClass;
  ResourceClassName: string;
  thread, oldThread: TWebAPIThread;
  x: integer;
  tryCount: integer;
begin
  StartTime:= now;
  try
    Log('',ltDetail);
    //Log('RequestJson:' + RequestJson.asString,ltDetail);
  Log('====================================================',ltDebug);
  Log('URI',ltDebug);
  Log(RequestJson.S['URI'],ltDebug);
  Log(RequestJson.asString, ltDebug);
  Log('====================================================',ltDebug);

    Log('Processing HTTP Request',ltDetail);
    try
      ResourceName:= RequestJson.A['URIParts'].Items[2].AsString;
      ResourceClassName:= {'T' +} ResourceName;
//      ResourceClass:= GetClass(ResourceClassName);
      Log('Resourse Name: ' + ResourceName,ltDetail);
      if ResourceName = 'about' then begin
        ResultJson.S[TAG_ContentType]:= 'text/plain';
        ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
        ResultJson.O['JsonOut'].S['Name']:= 'ERP Web API Server';
        ResultJson.O['JsonOut'].S['Module']:= ExtractFileName(GetModuleNameStr);
        ResultJson.O['JsonOut'].S['Version']:= ModuleUtils.GetFileVersion(GetModuleNameStr);
        exit;
//      end
//      else if SameText(ResourceName, 'help') then begin
//        ResultJson.S[TAG_ContentType]:= 'text/html';
//        ResultJson.I[TAG_ResponseNo]:= VS1_HTTP_Success_Code; { "OK" }
//        ResultJson.O['JsonOut'].S['content'] :=
//          '<!DOCTYPE html>' +
//          '<html>' +
//          '<body>' +
//
//          '<h1>TrueERP WebAPI Help</h1>' +
//
//          '<p>List of functions:</p>' +
//
//          '</body>' +
//          '</html>';
//        exit;
      end;
      if RequestJson.S[TAG_ERPDatabase] = '' then begin
        {$IFDEF DevMode}RequestJson.S[TAG_ERPDatabase]:= VS1_Admin_DB_Sandbox;{$ELSE}
        Log('No Databse Name specified',ltError);
        ResultJson.I[TAG_ResponseNo]:= 406; { "Not Acceptable" }
        ResultJson.S[TAG_ErrorMessage]:= 'No ERP Database specified';
        exit;{$ENDIF}
      end;
      if RequestJson.S[TAG_ERPUserName] = '' then begin
        {$IFDEF DevMode}RequestJson.S[TAG_ERPUserName]:= 'VS1_Cloud_Admin';{$ELSE}
        Log('No User Name specified.',ltError);
        ResultJson.I[TAG_ResponseNo]:= 406; { "Not Acceptable" }
        ResultJson.S[TAG_ErrorMessage]:= 'No ERP User Name specified';
        exit;{$ENDIF}
      end;
      if RequestJson.S[TAG_ERPPassword] = '' then begin
        {$IFDEF DevMode}RequestJson.S[TAG_ERPPassword]:= 'DptfGw83mFl1j&9';{$ELSE}
        Log('No User Password specified',ltError);
        ResultJson.I[TAG_ResponseNo]:= 406; { "Not Acceptable" }
        ResultJson.S[TAG_ErrorMessage]:= 'No ERP User Password specified';
        exit;{$ENDIF}
      end;

      { find a thread to process the request }
      thread := nil;
      oldThread := nil;
      tryCount:= 0;
      repeat
        Inc(tryCount);
        Lock;
        try
          for x := 0 to fList.Count -1 do begin
            TWebAPIThread(fList[x]).Lock;
            try
              if (TWebAPIThread(fList[x]).Status = wsIdle) then begin
                if SameText(RequestJson.S[TAG_ERPDatabase],TWebAPIThread(fList[x]).Database) and
                  SameText(RequestJson.S[TAG_ERPUserName],TWebAPIThread(fList[x]).UserName) and
                  SameText(RequestJson.S[TAG_ERPPassword],TWebAPIThread(fList[x]).Password) then begin
                  thread := TWebAPIThread(fList[x]);
                  //thread.RequestJson.Assign(RequestJson);
                  thread.RequestJson := RequestJson;
                  thread.ResultJson := ResultJson;
                  thread.OutStream := OutStream;
                  thread.Status := wsBusy;
                  break;
                end
                else begin
                  if not Assigned(OldThread) then
                    OldThread := TWebAPIThread(fList[x]);
                end;
              end;
            finally
              TWebAPIThread(fList[x]).Unlock;
            end;
          end;
          if not Assigned(thread) then begin
            { check list size }
            if (MaxThreadCount > 0) and (fList.Count >= MaxThreadCount) then begin
              if Assigned(OldThread) then begin
                fList.Remove(OldThread);
                OldThread.Terminate;
              end
              else begin
                if (MaxThreadCount > 0) then begin
                  { list too big and we cant delete anything }

                end;
              end;

            end;

            if fList.Count < MaxThreadCount then begin
              { add a new one to the list }
              thread := TWebAPIThread.Create(fLogger, true);
              thread.MySQLServer := MySQLServer;
              fList.Add(thread);
//              thread.RequestJson.Assign(RequestJson);
              thread.RequestJson := RequestJson;
              thread.ResultJson := ResultJson;
              thread.OutStream := OutStream;
              thread.Status := wsBusy;
            end;

          end;

        finally
          Unlock;
        end;
        if not Assigned(thread) then
          Sleep(100);
      until Assigned(thread) or (tryCount >= 300);

      if Assigned(thread) then begin
        { wait for thread to finish }
        while true do begin
          Sleep(10);
          thread.Lock;
          try
            if thread.Status = wsFinished then begin
//              ResultJson.Assign(thread.ResultJson);
              OutStream := thread.OutStream;
              thread.Status := wsIdle;
              break;
            end;
          finally
            thread.Unlock;
          end;
        end;
      end
      else begin
        { could not process }
        Log('Unable to process request at this time',ltError);
        ResultJson.I[TAG_ResponseNo]:= 503; { "Service Unavailable" }
        ResultJson.S[TAG_ErrorMessage]:= 'Unable to process request at this time';
      end;

    finally
      Log('Finished Processing HTTP Request (' + FormatDateTime('hh:nn:ss.zzz',now-StartTime)+ ')',ltDetail);
    end;
  except
    on e: exception do begin
      Log('Error: ' + e.Message ,ltError);
      ResultJson.I[TAG_ResponseNo]:= 500; { "Internal Server Error" }
      ResultJson.S[TAG_ErrorMessage]:= 'Error: ' + RemoveCRLF(e.Message);
    end;
  end;
end;

procedure TApiThreadList.Lock;
begin
  fLock.Acquire;
end;

procedure TApiThreadList.Log(const msg: string; aType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg,aType);
end;

procedure TApiThreadList.SetMaxThreadCount(const Value: integer);
begin
  FMaxThreadCount := Value;
end;

procedure TApiThreadList.Unlock;
begin
  fLock.Release;
end;

{ TCleanupThread }

constructor TCleanupThread.Create(aThreadList: TApiThreadList);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  fNextCheckTime := Now + (OneMin);
  fThreadList := aThreadList;
  {$Warnings Off}
  Resume;
  {$Warnings On}
end;

{ remove from list if idle for more than 5 mins }
procedure TCleanupThread.Execute;
var
  x: Integer;
  item: TWebAPIThread;
begin
  inherited;
  while not Terminated do begin
    try
      Sleep(50);
      if Now >= fNextCheckTime then begin
        try
          fThreadList.Lock;
          try
            x := 0;
            while x < fThreadList.List.Count do begin
              item := TWebAPIThread(fThreadList.List[x]);
              item.Lock;
              if (item.Status = wsIdle) and (item.LastTime < (Now - (OneMin * 5))) then begin
                item.Unlock;
                fThreadList.List.Extract(item);
                try
                  item.OutStream.Free;
                  item.OutStream := nil;
                except
                end;
                try
                  item.Terminate;
                except
                end;
              end
              else begin
                item.Unlock;
                Inc(x);
              end;
            end;
          finally
            fThreadList.Unlock;
          end;
        finally
          fNextCheckTime := now + (OneMin);
        end;
      end;
    except
    end;
  end;
end;



{ TWebAPIThreadBase }

constructor TWebAPIThreadBase.Create(Logger: TLoggerBase; CreateSuspended:Boolean);
begin
  inherited Create(CreateSuspended);
  fiServerTaskID := -1;
  fLogger := Logger;
end;

procedure TWebAPIThreadBase.Log(const msg: string; aType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg,aType);
end;

Procedure TWebAPIThreadBase.OnStatus(aResponseno:String; aStatusMsg:String; aErrorMsg:String='');
begin
  if not Assigned(fOnEvent) then exit;
  if trim(aResponseno)<> '' then AddEventdata(fOnEvent ,TAG_ResponseNo     , aResponseno, true);
  if trim(aStatusMsg) <> '' then AddEventdata(fOnEvent ,TAG_ResponseStatus , aStatusMsg, true);
  if trim(aErrorMsg)  <> '' then AddEventdata(fOnEvent ,TAG_ResponseError  , aErrorMsg, true);

end;
end.
