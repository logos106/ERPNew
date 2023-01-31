unit tcClasses;

interface

uses SysUtils, Classes,  DBAccess;

type
{$M+}
  TMySQLHelper = class(TObject)
  private
    FExecuteResult: boolean;
  public
    constructor Create;
  published
    procedure OnAfterExecute(Sender: TObject; Result: boolean);// virtual;
    property ExecuteResult: boolean read FExecuteResult;
  end;
{$M-}

  TConnectionHelper = class(TObject)
  private
    FConnectionFailed: boolean;
  public
    constructor Create;
    procedure OnConnectionError(Sender: TObject; E: EDAError; var Fail: boolean);
    property ConnectionFailed: boolean read FConnectionFailed;
  end;

  TSimpleFlags = class(TStringList)
  public
    function AnyOfFlags(const Values: array of string): boolean;
    function IsFlag(const FlagName: string; const Reset: boolean = false): boolean;
    function NoneFlags(const Values: array of string): boolean;
    procedure AddFlag(const FlagName: string);
    procedure AddFlags(const Values: array of string);
    procedure RemoveFlag(const FlagName: string);
    procedure RemoveFlags(const Values: array of string);
  end;

implementation

uses
  Dialogs, CommonLib;

{ TConnectionHelper }

constructor TConnectionHelper.Create;
begin
  inherited;
  FConnectionFailed := false;
end;

procedure TConnectionHelper.OnConnectionError(Sender: TObject; E: EDAError; var Fail: boolean);
begin
  FConnectionFailed := true;
  if E.ErrorCode = 2005 then begin
    CommonLib.MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    Fail := false;
  end;
end;

{ TSimpleFlags }

procedure TSimpleFlags.AddFlag(const FlagName: string);
begin
  if not IsFlag(FlagName) then Self.Add(FlagName);
end;

procedure TSimpleFlags.AddFlags(const Values: array of string);
var
  I: integer;
begin
  for I := Low(Values) to High(Values) do Self.AddFlag(Values[I]);
end;

function TSimpleFlags.AnyOfFlags(const Values: array of string): boolean;
var
  I: integer;
begin
  Result := false;
  for I := Low(Values) to High(Values) do if Self.IsFlag(Values[I]) then begin
      Result := true;
      Break;
    end;
end;

function TSimpleFlags.IsFlag(const FlagName: string; const Reset: boolean = false): boolean;
begin
  Result := Self.IndexOf(FlagName) <> -1;
  if Result and Reset then RemoveFlag(FlagName);
end;

function TSimpleFlags.NoneFlags(const Values: array of string): boolean;
var
  I: integer;
begin
  // only returns true if all Values flags are not in the list
  Result := true;
  for I := Low(Values) to High(Values) do if Self.IsFlag(Values[I]) then begin // flag was listed
      Result := false;
      Break;
    end;
end;

procedure TSimpleFlags.RemoveFlag(const FlagName: string);
var
  Index: integer;
begin
  Index := Self.IndexOf(FlagName);
  if Index <> -1 then Self.Delete(Index); 
end;

procedure TSimpleFlags.RemoveFlags(const Values: array of string);
var
  I: integer;
begin
  for I := Low(Values) to High(Values) do Self.RemoveFlag(Values[I]);  
end;

{ TMySQLHelper }

constructor TMySQLHelper.Create;
begin
  inherited;
  FExecuteResult := false;
end;

procedure TMySQLHelper.OnAfterExecute(Sender: TObject; Result: boolean);
begin
  FExecuteResult := Result;; // do something in descendants
end;

end.
