unit IpRangeListObj;

(*

127.0.0.1 - 127.0.0.1
10.0.0.0 - 10.255.255.255
172.16.0.0 - 172.31.255.255
192.168.0.0 - 192.168.255.255
*)

interface

uses
  contnrs, JsonObject;

type

  TIpRangeItem = class(TObject)
  private
    fRangeStartInt,
    fRangeEndInt: longword;
    FRangeEnd: string;
    FRangeStart: string;
    procedure SetRangeEnd(const Value: string);
    procedure SetRangeStart(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property RangeStart: string read FRangeStart write SetRangeStart;
    property RangeEnd: string read FRangeEnd write SetRangeEnd;
    function InRange(aIpInt: longword): boolean;
  end;

  TIpRangeList = class(TObject)
  private
    fList: TObjectList;
    function GetItem(index: integer): TIpRangeItem;
    function GetCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SaveToJson(Json: TJsonObject);
    procedure LoadFromJson(Json: TJsonObject);
    function IpInRange(Ip: string): boolean;
    procedure AddRange(aRangeStart, aRangeEnd: string);
    property Count: integer read GetCount;
  end;


implementation

uses
  sysutils, Classes;

function IpToInt(const AIpAddress : string) : longword;
var Retvar,i,iShift : longword;
    sData,sSeg : string;
begin
  Retvar := 0;
  iShift := 24;
  sData := trim(AIpAddress);

  while sData <> '' do begin
    i := pos('.',sData);

    if i <> 0 then begin
      sSeg := copy(sData,1,i - 1);
      sData := copy(sData,i+1,length(sData));
    end
    else begin
      sSeg := sData;
      sData := '';
    end;

    Retvar := Retvar + (longword(StrToIntDef(sSeg,0)) shl iShift);
    dec(iShift,8);
  end;

  Result := Retvar;
end;


function IntToIp(AIpValue : longword) : string;
var Retvar : string;
    iSeg,iShift,
    i,iMask : longword;
begin
  Retvar := '';
  iShift := 24;
  iMask := $FF000000;

  for i := 1 to 4 do begin
    iSeg := (AIpValue and iMask) shr iShift;
    Retvar := Retvar + IntToStr(iSeg);
    if i <> 4 then Retvar := Retvar + '.';
    iMask := iMask shr 8;
    dec(iShift,8);
  end;

  Result := Retvar;
end;

//function IP2Number (IP: string): dword;
//var
//   I, DotPosition: integer;
//   IPWord: dword;
//begin
//   Result := 0;
//   for I := 0 to 3 do begin
//      DotPosition := Pos ('.', IP);
//      if (DotPosition = 0) then begin
//         DotPosition := Length (IP) + 1;
//      end; {if}
//      IPWord := StrToInt (Copy (IP, 1, DotPosition - 1));
//      Result := Result OR (IPWord SHL ((3 - I)*8));
//      IP := Copy (IP, DotPosition + 1, Length (IP));
//   end; {for}
//end;




{ TIpRangeItem }

constructor TIpRangeItem.Create;
begin
  fRangeStartInt:= 0;
  fRangeEndInt:= 0;
end;

destructor TIpRangeItem.Destroy;
begin

  inherited;
end;

function TIpRangeItem.InRange(aIpInt: longword): boolean;
begin
  result:= (fRangeStartInt <= fRangeEndInt) and
    (aIpInt >= fRangeStartInt) and (aIpInt <= fRangeEndInt);
end;

procedure TIpRangeItem.SetRangeEnd(const Value: string);
begin
  FRangeEnd := Value;
  fRangeEndInt:= IpToInt(Value);
end;

procedure TIpRangeItem.SetRangeStart(const Value: string);
begin
  FRangeStart := Value;
  fRangeStartInt:= IpToInt(Value);
end;

{ TIpRangeList }

procedure TIpRangeList.AddRange(aRangeStart, aRangeEnd: string);
var
  newItem: TIpRangeItem;
begin
  newItem:= TIpRangeItem.Create;
  newItem.RangeStart:= aRangeStart;
  newItem.RangeEnd:= aRangeEnd;
  fList.Add(newItem);
end;

constructor TIpRangeList.Create;
begin
  fList:= TObjectList.Create(true);
end;

destructor TIpRangeList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TIpRangeList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TIpRangeList.GetItem(index: integer): TIpRangeItem;
begin
  result:= TIpRangeItem(fList[index]);
end;

function TIpRangeList.IpInRange(Ip: string): boolean;
var
  x: integer;
  IpInt: longword;
begin
  result:= false;
  IpInt:= IpToInt(Ip);
  for x:= 0 to fList.Count -1 do begin
    if GetItem(x).InRange(IpInt) then begin
      result:= true;
      break;
    end;
  end;
end;

procedure TIpRangeList.LoadFromJson(Json: TJsonObject);
var
  x: integer;
begin
  fList.Clear;
  for x:= 0 to Json.O['items'].Count -1 do begin
    self.AddRange(
      Json.O['items'].Items[x].Value.AsObject.S['rangestart'],
      Json.O['items'].Items[x].Value.AsObject.S['rangeend']);
  end;
end;

procedure TIpRangeList.SaveToJson(Json: TJsonObject);
var
  x: integer;
begin
  Json.Clear;
  for x:= 0 to fList.Count -1 do begin
    Json.O['items'].O[IntToStr(x)].S['rangestart']:= GetItem(x).RangeStart;
    Json.O['items'].O[IntToStr(x)].S['rangeend']:= GetItem(x).RangeEnd;
  end;
end;

end.
