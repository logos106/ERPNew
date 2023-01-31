unit AppEnvVirtualObj;

interface

uses
  Types;

type

  TAppEnvVirtual = class
  private
    fThreadId: Cardinal;
    procedure RaiseinvPropException(ObjNamePath: string);
    Function DevMode:Boolean;
  protected
    function GetBool(ObjNamePath: string): boolean;
    function GetDateTime(ObjNamePath: string): TDateTime;
    function GetFloat(ObjNamePath: string): double;
    function GetInt(ObjNamePath: string): integer;
    function GetObj(ObjNamePath: string): TObject;
    function GetStr(ObjNamePath: string): string;
    procedure SetBool(ObjNamePath: string; const Value: boolean);
    procedure SetDateTime(ObjNamePath: string; const Value: TDateTime);
    procedure SetFloat(ObjNamePath: string; const Value: double);
    procedure SetInt(ObjNamePath: string; const Value: integer);
    procedure SetObj(ObjNamePath: string; const Value: TObject);
    procedure SetStr(ObjNamePath: string; const Value: string);
    function GetTopObject(ObjNamePath: String): TObject;
    function PropName(ObjNamePath: string): string;
    function DoGetObject(path: TStringDynArray): TObject; virtual;
  public
    property ThreadId: Cardinal read fThreadId write fThreadId;
    property Obj[ObjNamePath: string]: TObject read GetObj write SetObj;
    property Int[ObjNamePath: string]: integer read GetInt write SetInt;
    property Float[ObjNamePath: string]: double read GetFloat write SetFloat;
    property Str[ObjNamePath: string]: string read GetStr write SetStr;
    property Bool[ObjNamePath: string]: boolean read GetBool write SetBool;
    property DateTime[ObjNamePath: string]: TDateTime read GetDateTime write SetDateTime;
    procedure PopulateCompanyPrefs; virtual; Abstract;
    function GetEmployeeAccessLevel(const FormName: string; const EmployeeID: integer = 0): integer; virtual; abstract;
    procedure DeleteServerFiles(const aFileNameMask: string); virtual; abstract;
    Function showWarning(const Value:String):Boolean;virtual;abstract;
    Procedure LogText(const Value:String);virtual;abstract;
    Procedure LogTextLoge(const Value:String);virtual;abstract;
    function Round(const Value: double; places: word): double;virtual;abstract;
  end;

implementation

uses
  StrUtils, TypInfo, Sysutils;

{ TAppEnvVirtual }

function TAppEnvVirtual.DevMode: Boolean;
begin
  Result := Bool['CommonLib.DevMode'];
end;

function TAppEnvVirtual.DoGetObject(path: TStringDynArray): TObject;
begin
  Result := nil;
end;

function TAppEnvVirtual.GetBool(ObjNamePath: string): boolean;
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  Result := False;
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.GetProc) then begin
      result := SameText(GetEnumProp(obj,PropInfo), 'True');
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

function TAppEnvVirtual.GetDateTime(ObjNamePath: string): TDateTime;
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  result := 0;
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.GetProc) then begin
      result := GetFloatProp(obj,PropInfo);
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

function TAppEnvVirtual.GetFloat(ObjNamePath: string): double;
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  result := 0;
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.GetProc) then begin
      result := GetFloatProp(obj,PropInfo);
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

function TAppEnvVirtual.GetInt(ObjNamePath: string): integer;
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  result := 0;
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.GetProc) then begin
      result := GetOrdProp(obj,PropInfo);
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

function TAppEnvVirtual.GetObj(ObjNamePath: string): TObject;
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  result := nil;
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.GetProc) then begin
      result := GetObjectProp(obj,PropInfo);
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

function TAppEnvVirtual.GetStr(ObjNamePath: string): string;
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  result := '';
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.GetProc) then begin
      result := GetStrProp(obj,PropInfo);
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

procedure TAppEnvVirtual.RaiseinvPropException(ObjNamePath: string);
begin
  if not devmode then exit;
  raise Exception.Create('Invalid AppEnvVirtual Property ' + ObjNamePath);
end;

function TAppEnvVirtual.GetTopObject(ObjNamePath: String): TObject;
var
  x: Integer;
  StrArray: TStringDynArray;
begin
  StrArray := SplitString(ObjNamePath, '.');
  Result := DoGetObject(StrArray);
  if (not Assigned(Result)) and (High(StrArray) >= 0) then begin
    Result := self;
    for x := Low(StrArray) to High(StrArray) - 1 do begin
      Result := GetObjectProp(Result, StrArray[x]);
      if not Assigned(Result) then
        Break;
    end;
  end;
end;

function TAppEnvVirtual.PropName(ObjNamePath: string): string;
var
  StrArray: TStringDynArray;
begin
  StrArray := SplitString(ObjNamePath,'.');
  result := StrArray[High(StrArray)];
end;

procedure TAppEnvVirtual.SetBool(ObjNamePath: string; const Value: boolean);
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.SetProc) then begin
      if Value then
        TypInfo.SetEnumProp(Obj,PropInfo,'True')
      else
        TypInfo.SetEnumProp(Obj,PropInfo,'False');
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

procedure TAppEnvVirtual.SetDateTime(ObjNamePath: string;
  const Value: TDateTime);
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.SetProc) then begin
      SetFloatProp(obj,PropInfo,Value);
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

procedure TAppEnvVirtual.SetFloat(ObjNamePath: string; const Value: double);
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.SetProc) then begin
      SetFloatProp(obj,PropInfo,Value);
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

procedure TAppEnvVirtual.SetInt(ObjNamePath: string; const Value: integer);
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.SetProc) then begin
      SetOrdProp(obj,PropInfo,Value);
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

procedure TAppEnvVirtual.SetObj(ObjNamePath: string; const Value: TObject);
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.SetProc) then begin
      SetObjectProp(obj,PropInfo,Value);
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

procedure TAppEnvVirtual.SetStr(ObjNamePath: string; const Value: string);
var
  obj: TObject;
  PropInfo: PPropInfo;
begin
  obj := GetTopObject(ObjNamePath);
  if Assigned(Obj) then begin
    PropInfo := GetPropInfo(Obj,PropName(ObjNamePath));
    if Assigned(PropInfo) and Assigned(PropInfo.SetProc) then begin
      SetStrProp(obj,PropInfo,Value);
      Exit;
    end;
  end;
  RaiseinvPropException(objnamePath);
end;

end.
