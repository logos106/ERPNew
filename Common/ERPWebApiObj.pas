unit ERPWebApiObj;

interface

(*
  Requred structure for aConfig:
    {
        "ServerName":"localhost",
        "ServerPort":443,
        "UseSSL":true,
        "ERPUserName":"webuser",
        "ERPUserPassword":"webuser",
        "ERPDatabase":"sample_company"
    }
*)
uses
  JsonObject, ConTnrs, SysUtils, WebApiClientObj, SyncObjs;

type
  TERPWebApiException = class(Exception)
  public
    DetailMessage: string;
    constructor Create(const Msg: string); overload;
    constructor Create(const Msg, aDetailMsg: string); overload;
  end;

  TERPWebApi = class
  private
    CriticalSection: TCriticalSection;
    fList: TObjectList;
    fAPIConfigStr: string;
    APIConfig: TJsonObject;
    procedure Lock;
    procedure Unlock;
    procedure CheckConfig;
    procedure CheckObjConsistency(var Idx: integer);
    function IndexOf(const aERPClassName: string; aId: integer): integer; overload;
    function IndexOf(const aERPClassName, aKeyValue: string): integer; overload;
    function GetApiClient: TWebAPIClient;
  public
    constructor Create(aAPIConfig: TJsonObject);
    destructor Destroy; override;
    procedure Clear;
    function GetObject(const aERPClassName: string; aId: integer; ForceRefresh: boolean = false): TJsonObject; overload;
    function GetObject(const aERPClassName, aKeyValue: string; ForceRefresh: boolean = false): TJsonObject; overload;
    function SaveObject(Obj: TJsonObject): integer;
    function GetList(const aERPClassName: string; aSelect: string = ''; aPropertyList: string = ''): TJsonObject;
    function CompanyInfo: TJsonObject; {  BusObjCompanyInfo.TCompanyInfo  }
    procedure RemoveOldObjects;
  end;

  TERPObjInst = class
  public
    ERPClass: string;
    ID: integer;
    KeyValue: string;
    Inst: TJsonObject;
    RetrieveTime: TDateTime;
    constructor Create;
  end;

implementation

uses
  DateUtils;

const
  ObjectLifeMins = 5;

{ TERPWebApi }

procedure TERPWebApi.CheckConfig;
begin
  { if config has changed clear everything .. }
  if not SameText(fAPIConfigStr,APIConfig.AsString) then begin
    fLIst.Clear;
    fAPIConfigStr := APIConfig.AsString;
  end;
end;

procedure TERPWebApi.CheckObjConsistency(var Idx: integer);
begin
  if Idx < 0 then exit;

  { for now just delete if more than 5 mins old }
  if MinutesBetween(now,TERPObjInst(fList[Idx]).RetrieveTime) >= ObjectLifeMins then begin
    fList.Delete(Idx);
    Idx := -1;
  end;
end;

procedure TERPWebApi.Clear;
begin
  fList.Clear;
end;

function TERPWebApi.CompanyInfo: TJsonObject;
begin
  result := self.GetObject('TCompanyInfo',1,false);
end;

constructor TERPWebApi.Create(aAPIConfig: TJsonObject);
begin
  CriticalSection := TCriticalSection.Create;
  fList := TObjectList.Create;
  APIConfig := aAPIConfig;
  fAPIConfigStr := APIConfig.AsString;
end;

destructor TERPWebApi.Destroy;
begin
  fList.Free;
  CriticalSection.Free;
  inherited;
end;

function TERPWebApi.GetApiClient: TWebAPIClient;
begin
  result := TWebApiClient.Create;
  result.UserName := ApiConfig.S['ERPUserName'];
  result.Password := ApiConfig.S['ERPUserPassword'];
  result.Database := ApiConfig.S['ERPDatabase'];
  if ApiConfig.B['USeSSL'] then
    result.URL := 'https://' + ApiConfig.S['ServerName'] + ':' + IntToStr(ApiConfig.I['ServerPort'])
  else
    result.URL := 'http://' + ApiConfig.S['ServerName'] + ':' + IntToStr(ApiConfig.I['ServerPort']);
end;

function TERPWebApi.GetList(const aERPClassName: string; aSelect,
  aPropertyList: string): TJsonObject;
var
  api: TWebAPIClient;
  s: string;
begin
  result := nil;
  api := self.GetApiClient;
  try
    if aPropertyList <> '' then
      s:= 'PropertyList=' + aPropertyList;
    if aSelect <> '' then begin
      if s <> '' then s:= '&' + s;
      s:= 'select=' + aSelect + s;
    end;
    if s <> '' then
      s:= aERPClassName  + '?' + s
    else
      s:= aERPClassName;

    if api.Get(s,result) then begin
      { all good .. result populated with list }
    end
    else begin
      raise TERPWebApiException.Create('Error reading list for ' + aERPClassName + ' from ERP Web API.',api.ErrorMessage);
    end;
  finally
    api.Free;
  end;
end;

function TERPWebApi.IndexOf(const aERPClassName: string; aId: integer): integer;
var
  x: integer;
begin
  result := -1;
  for x := 0 to fList.Count -1 do begin
    if SameText(TERPObjInst(fList[x]).ERPClass,aERPClassName) and (TERPObjInst(fList[x]).ID = aId) then begin
      result := x;
      exit;
    end;
  end;
end;

function TERPWebApi.IndexOf(const aERPClassName, aKeyValue: string): integer;
var
  x: integer;
begin
  result := -1;
  for x := 0 to fList.Count -1 do begin
    if SameText(TERPObjInst(fList[x]).ERPClass,aERPClassName) and
      (TERPObjInst(fList[x]).KeyValue <> '') and SameText(TERPObjInst(fList[x]).KeyValue,aKeyValue) then begin
      result := x;
      exit;
    end;
  end;
end;

procedure TERPWebApi.Lock;
begin
  CriticalSection.Acquire;
end;

procedure TERPWebApi.RemoveOldObjects;
var
  x: integer;
begin
  Lock;
  try
    x:= 0;
    while x < fList.Count do begin
      if MinutesBetween(now,TERPObjInst(fList[x]).RetrieveTime) >= ObjectLifeMins then
       fList.Delete(x)
      else
       Inc(x);
    end;
  finally
    Unlock;
  end;
end;

function TERPWebApi.GetObject(const aERPClassName: string; aId: integer;
  ForceRefresh: boolean): TJsonObject;
var
  InstIdx: integer;
  api: TWebAPIClient;
  ObjInst: TERPObjInst;
begin
  Lock;
  try
    result:= nil;
    CheckConfig;
    InstIdx := IndexOf(aERPClassName, aId);
    if ForceRefresh then begin
      if (InstIdx > -1) then begin
        fList.Delete(InstIdx);
        InstIdx := -1;
      end;
    end
    else
      CheckObjConsistency(InstIdx);
    if (InstIdx > -1) then begin
      result := JO;
      result.Assign(TERPObjInst(fList[InstIdx]).Inst);
    end
    else begin
      { get it .. }
      api := self.GetApiClient;
      try
        ObjInst:= TERPObjInst.Create;
        if api.Get(aERPClassName,aId,ObjInst.Inst) then begin
          result := JO;
          result.Assign(ObjInst.Inst);
          ObjInst.ERPClass := aERPClassName;
          ObjInst.ID := result.O['fields'].I['ID'];
          ObjInst.KeyValue := result.O['fields'].S['KeyValue'];
          fList.Add(ObjInst);
        end
        else begin
          ObjInst.Free;
          raise TERPWebApiException.Create('Error reading ' + aERPClassName + ' from ERP Web API.',api.ErrorMessage);
        end;
      finally
        api.Free;
      end;
    end;
  finally
    Unlock;
  end;
end;

function TERPWebApi.GetObject(const aERPClassName, aKeyValue: string;
  ForceRefresh: boolean): TJsonObject;
var
  InstIdx: integer;
  api: TWebAPIClient;
  ObjInst: TERPObjInst;
begin
  Lock;
  try
    result := nil;
    CheckConfig;
    InstIdx := IndexOf(aERPClassName, aKeyValue);
    if ForceRefresh then begin
      if (InstIdx > -1) then begin
        fList.Delete(InstIdx);
        InstIdx := -1;
      end;
    end
    else
      CheckObjConsistency(InstIdx);
    if (InstIdx > -1) then begin
      result:= JO;
      result.Assign(TERPObjInst(fList[InstIdx]).Inst);
    end
    else begin
      { get it .. }
      api := self.GetApiClient;
      try
        ObjInst:= TERPObjInst.Create;
        if api.Get(aERPClassName + '?KeyValue=' + aKeyValue,ObjInst.Inst) then begin
          result := JO;
          result.Assign(ObjInst.Inst);
          ObjInst.ERPClass := aERPClassName;
          ObjInst.ID := result.O['fields'].I['ID'];
          ObjInst.KeyValue := result.O['fields'].S['KeyValue'];
          fList.Add(ObjInst);
        end
        else begin
          ObjInst.Free;
          raise TERPWebApiException.Create('Error reading ' + aERPClassName + ' from ERP Web API.',api.ErrorMessage);
        end;
      finally
        api.Free;
      end;
    end;
  finally
    Unlock;
  end;
end;

function TERPWebApi.SaveObject(Obj: TJsonObject): integer;
var
  api: TWebAPIClient;
  OutObj: TJsonObject;
begin
  result:= 0;
  api := self.GetApiClient;
  OutObj := nil;
  try
    if api.Post(Obj.S['type'],Obj,OutObj) then begin
      result := OutObj.O['fields'].I['Id'];
    end
    else begin
      raise TERPWebApiException.Create('Error sending ' + Obj.S['type'] + ' to ERP Web API.',api.ErrorMessage);
    end;
  finally
    api.Free;
    OutObj.Free;
  end;
end;

procedure TERPWebApi.Unlock;
begin
  CriticalSection.Release;
end;

{ TERPWebApiException }

constructor TERPWebApiException.Create(const Msg, aDetailMsg: string);
begin
  inherited Create(Msg);
  DetailMessage := aDetailMsg;
end;

constructor TERPWebApiException.Create(const Msg: string);
begin
  inherited;
  DetailMessage := '';
end;

{ TERPObjInst }

constructor TERPObjInst.Create;
begin
  self.RetrieveTime := now;
  self.Inst := nil;
  KeyValue:= '';
end;

end.
