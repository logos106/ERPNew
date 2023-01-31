{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocol_Base_Message;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils,
  sgcJSON;

type
  TsgcWSMessage_Base = class(TComponent)
  private
    function GetObjectJSON(aJSONObject: TsgcObjectJSON = nil): TsgcJSON;
  protected
    FJSON: TsgcJSON;
  protected
    procedure Clear(aForceClear: Boolean = False); virtual;
  protected
    function DoReadJSONValue(const aField: string; aJSONObject: TsgcObjectJSON =
        nil): Variant; overload;
    function DoReadJSONValue(aItem: Integer; aJSONObject: TsgcObjectJSON = nil):
        Variant; overload;
  protected
    procedure DoWriteJSONValue(const aName, aValue: string; aJSONObject:
        TsgcObjectJSON = nil); overload;
    procedure DoWriteJSONValue(const aName: string; aValue: Integer; aJSONObject:
        TsgcObjectJSON = nil); overload;
    procedure DoWriteJSONValue(const aName: string; aValue: Double; aJSONObject:
        TsgcObjectJSON = nil); overload;
    procedure DoWriteJSONValue(const aName: string; aValue: Boolean; aJSONObject:
        TsgcObjectJSON = nil); overload;
  protected
    function DoAddJSONObject(const aName: String; aJSONObject: TsgcObjectJSON =
        nil): TsgcObjectJSON;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  protected
    FIsReading: Boolean;
    FIsWriting: Boolean;
  public
    procedure DoEnterRead(const aText: String);
    procedure DoLeaveRead;
    procedure DoEnterWrite;
    procedure DoLeaveWrite;
  public
    procedure Read(const aMessage: String); virtual;
    function Write: string; virtual;
  end;

implementation

constructor TsgcWSMessage_Base.Create(aOwner: TComponent);
begin
  inherited;
  FJSON := TsgcJSON.Create(nil);
end;

destructor TsgcWSMessage_Base.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
end;

function TsgcWSMessage_Base.DoAddJSONObject(const aName: String; aJSONObject:
    TsgcObjectJSON = nil): TsgcObjectJSON;
begin
  result := GetObjectJSON.Node[aName];
  if not Assigned(result) then
  begin
    result := GetObjectJSON.Add;
    result.Name := aName;
  end;
end;

procedure TsgcWSMessage_Base.Clear(aForceClear: Boolean = False);
begin
  if (not FIsWriting and not FIsReading) or (aForceClear = True) then
  begin
    FJSON.Clear;
    FIsWriting := True;
  end;
end;

procedure TsgcWSMessage_Base.DoEnterRead(const aText: String);
begin
  if not FIsReading then
  begin
    Clear;
    FIsReading := True;
    FJSON.Read(aText);
  end;
end;

procedure TsgcWSMessage_Base.DoEnterWrite;
begin
  FIsWriting := True;
end;

procedure TsgcWSMessage_Base.DoLeaveRead;
begin
  FIsReading := False;
  FJSON.Clear;
end;

procedure TsgcWSMessage_Base.DoLeaveWrite;
begin
  FIsWriting := False;
  Clear;
end;

function TsgcWSMessage_Base.DoReadJSONValue(const aField: string; aJSONObject:
    TsgcObjectJSON = nil): Variant;
begin
  Try
    if GetObjectJSON(aJSONObject).Node[aField] <> nil then
    begin
      if GetObjectJSON(aJSONObject).Node[aField].JSONType = sgcJSONObject then
        Result := GetObjectJSON(aJSONObject).Node[aField].JSONObject.Text
      else
        Result := GetObjectJSON(aJSONObject).Node[aField].Value;
    end;
  Except
    Result := '';
  End;
end;

function TsgcWSMessage_Base.DoReadJSONValue(aItem: Integer; aJSONObject:
    TsgcObjectJSON = nil): Variant;
begin
  Try
    if aItem < FJSON.count then
      if FJSON.Item[aItem] <> nil then
        Result := FJSON.Item[aItem].Value;
  Except
    Result := '';
  End;
end;

procedure TsgcWSMessage_Base.DoWriteJSONValue(const aName, aValue: string;
    aJSONObject: TsgcObjectJSON = nil);
begin
  GetObjectJSON(aJSONObject).Add(aName, aValue);
end;

procedure TsgcWSMessage_Base.DoWriteJSONValue(const aName: string; aValue:
    Integer; aJSONObject: TsgcObjectJSON = nil);
begin
  GetObjectJSON(aJSONObject).Add(aName, aValue);
end;

procedure TsgcWSMessage_Base.DoWriteJSONValue(const aName: string; aValue:
    Double; aJSONObject: TsgcObjectJSON = nil);
begin
  GetObjectJSON(aJSONObject).Add(aName, aValue);
end;

procedure TsgcWSMessage_Base.DoWriteJSONValue(const aName: string; aValue:
    Boolean; aJSONObject: TsgcObjectJSON = nil);
begin
  GetObjectJSON(aJSONObject).Add(aName, aValue);
end;

function TsgcWSMessage_Base.GetObjectJSON(aJSONObject: TsgcObjectJSON = nil):
    TsgcJSON;
begin
  if Assigned(aJSONObject) then
    Result := aJSONObject.JSONObject
  else
    Result := FJSON;
end;

procedure TsgcWSMessage_Base.Read(const aMessage: String);
begin
  DoLeaveRead;
end;

function TsgcWSMessage_Base.Write: string;
begin
  Result := String(FJSON.Text);
  DoLeaveWrite;
end;

end.
