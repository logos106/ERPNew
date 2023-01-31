unit RegPopupObj;

interface

uses
  Classes, SysUtils;


type
  TRegPopup = class(TObject)
  private
    FList: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const DisplayStr, ClassStr: string);
    procedure Remove(const DisplayStr: string);
    function GetDisplayList: TStringList;
    function GetClassName(const DisplayStr: string): string;
    function GetDisplayText(const ClassStr: string): string;
  end;

var
  RegPopup: TRegPopup;

implementation

uses
  FastFuncs, CommonLib;

{ TRegPopup }

procedure TRegPopup.Add(const DisplayStr, ClassStr: string);
var
  Index: Integer;
begin
  if not FList.Find(DisplayStr, Index) then
    FList.Add(DisplayStr + '=' + ClassStr);
end;

constructor TRegPopup.Create;
begin
  inherited;
  FList := TStringList.Create;
  FList.Sorted := True;
end;

destructor TRegPopup.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TRegPopup.GetClassName(const DisplayStr: string): string;
begin
  Result := FList.Values[DisplayStr];
end;

function TRegPopup.GetDisplayList: TStringList;
var
  Index: Integer;
begin
  Result := TStringList.Create;

  for Index := 0 to FList.Count - 1 do
    Result.Add(FList.Names[Index]);
end;

function TRegPopup.GetDisplayText(const ClassStr: string): string;
var
  Index: Integer;
  FoundMatch: Boolean;
  TmpStr: string;
  DelimiterPos: Integer;
begin
  Result := '';
  Index := 0;
  FoundMatch := False;

  while (Index < FList.Count) and (not FoundMatch) do begin
    TmpStr := FList.Strings[Index];
    DelimiterPos := FastFuncs.PosEx('=', TmpStr) + 1;

    if Sysutils.SameText(ClassStr, Copy(TmpStr, DelimiterPos, char_length(TmpStr) - DelimiterPos + 1)) then begin
      FoundMatch := True;
      Result := Copy(TmpStr, 1, DelimiterPos - 2);
    end
    else
      Inc(Index);
  end;
end;

procedure TRegPopup.Remove(const DisplayStr: string);
var
  Index: Integer;
begin
  Index := FList.IndexOfName(DisplayStr);

  if Index >= 0 then
    FList.Delete(Index);
end;

initialization
  RegPopup := TRegPopup.Create;
  RegPopup.add('Pricematrix' , 'TfmpartsPriceMatrixInput');
finalization
  FreeAndNil(RegPopup);
end.
