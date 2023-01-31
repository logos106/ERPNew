unit PoledisplayObj;

interface

uses
  MyAccess,ERPdbComponents, DB, classes;

const
  PoleNewLinechar = chr(10)+chr(13);
  VFD860        = 'VFD 860';
  GIGATEKDSP830 ='GIGATEK DSP 830';
type
  TPoleDisplayAlignment = (pdaLeft, pdaright , pdaCentre, pdaNone);

  TPoleDisplayObj = class(TObject)
  private
    fbUsePoledisplay: boolean;
    fsPolePort: String;
    FSPoleDisplayName:String;
    currentPoledisplay:string;
    stream: TFileStream;
    writer: TStreamWriter;

    (*function HexToInt(HexValue:String):Integer;*)
    function getPoleDisplayWidth: Integer;
    procedure StrToWriter(str: string;Align :TPoleDisplayAlignment);
    function formatPoledisplayText(Value: String; Align :TPoleDisplayAlignment): String;
    Procedure VFD860Clear;
    Procedure GiGaTekDSPClear;
    (*function currencychar_length(Digits: Integer): Integer;*)


  public
    class procedure Instance;
    constructor Create;
    destructor Destroy; override;
    procedure PopulateMe(const TillID: integer);
    property UsePoledisplay: boolean read fbUsePoledisplay;
    property PolePort: String read fsPolePort;
    Property PoleDisplayName :String read fsPoleDisplayName;
    Property PoleDisplayWidth :Integer read getPoleDisplayWidth;
    procedure DisplayWelcomeOnPole;
    procedure DisplayPairOnPole(st: String; db: Double);
    procedure DisplayOnPole(Value: String);
    procedure DisplayLineOnPole;
    procedure doComplete(Total:double; CashT , changet:String);

  end;
  function CurrToStrRJ(const rValue: currency; const iSize: integer): string;
  function RoundTo1C(const rMoney: currency): currency;

var
  PoleDisplayObjSetting: TPoleDisplayObj;

implementation

uses sysutils, CommonDbLib, FastFuncs, CommonLib, AppEnvironment,
  DecimalRounding, Dialogs;

{ TPoleDisplayObj }
(*Function TPoleDisplayObj.currencychar_length(Digits:Integer):Integer;
begin
  result := Digits +
            1 + {gap in the begenning}
            char_length(appenv.RegionalOptions.CurrencySymbol)+
            1;{decimal point}
end;*)

Procedure TPoleDisplayObj.DisplayPairOnPole(st :String; db:Double);
var
  PoleDisplayText:STring;
  x:Integer;
begin
  if not UsePoledisplay then Exit;

  if sameText(PoleDisplayName , VFD860) then begin
    VFD860Clear;
    StrToWriter( st , pdaLeft);
    StrToWriter( Trim(CurrToStrRJ(db, 13)) , pdaright);
  end else if sameText(PoleDisplayName , GIGATEKDSP830) then begin
    PoleDisplayText := Trim(CurrToStrRJ(db, 13));
    x:=char_length(PoleDisplayText);
    PoleDisplayText := copy(st + replicatestr(' ' , PoleDisplayWidth-x) , 1,PoleDisplayWidth-x)+ PoleDisplayText;
    StrToWriter( PoleDisplayText , pdaCentre);
  end;
end;

procedure TPoleDisplayObj.DisplayLineOnPole;
begin
  if not UsePoledisplay then Exit;
  StrToWriter(replicatestr('-' , PoleDisplayWidth) , pdaCentre);
end;

Procedure TPoleDisplayObj.DisplayOnPole(Value:String);
begin
  if not UsePoledisplay then Exit;

  If char_length(Value)>PoleDisplayWidth then Value := copy(value , 1,PoleDisplayWidth)
  else begin
    While char_length(Value)<PoleDisplayWidth do Value :=' ' +value +' ';
    Value:= copy(value , 1 ,PoleDisplayWidth);
  end;

  if sameText(PoleDisplayName , VFD860) then begin
    VFD860Clear;
    StrToWriter( Value, pdaCentre);
  end else begin
    if  currentPoledisplay= Value then exit;
    StrToWriter( Value, pdaCentre);
  end;
end;

procedure TPoleDisplayObj.DisplayWelcomeOnPole;
var
    PoleDisplayText:String;
begin
  if not UsePoledisplay then Exit;
  PoleDisplayText:=  trim(Appenv.CompanyInfo.Companyname);
  if char_length(PoleDisplayText)>= PoleDisplayWidth then PoleDisplayText := copy(PoleDisplayText,1,PoleDisplayWidth)
  else if char_length(PoleDisplayText)+char_length('Welcome To')>= PoleDisplayWidth then
  else PoleDisplayText := 'Welcome To ' +PoleDisplayText;

  While char_length(PoleDisplayText)<PoleDisplayWidth do PoleDisplayText := ' ' + PoleDisplayText +' ';
   if sameText(PoleDisplayName , VFD860) then begin
    VFD860Clear;
    StrToWriter( PoleDisplayText , pdaCentre);
   end else if sameText(PoleDisplayName , GIGATEKDSP830) then begin
    (*StrToWriter(replicatestr(' ' , PoleDisplayWidth) , pdaCentre);
    StrToWriter(replicatestr(' ' , PoleDisplayWidth) , pdaCentre);
    StrToWriter(replicatestr(' ' , PoleDisplayWidth) , pdaCentre);*)
    GiGaTekDSPClear;
    StrToWriter( PoleDisplayText , pdaCentre);
   end;
end;

procedure TPoleDisplayObj.doComplete(Total:double; CashT , changet:String);
begin
   if sameText(PoleDisplayName , VFD860) then begin
      StrToWriter( 'Total :' + Trim(CurrToStrRJ(Total, 13)), pdaCentre);
      While Pos('  ', changet)<>0 do changet:= replacestr(changet, '  ' , ' ');
      StrToWriter( changet, pdaCentre);
   end else if sameText(PoleDisplayName , GIGATEKDSP830) then begin
      DisplayPairOnPole('Total Amount :' , Total);
      DisplayOnPole(CashT);
      DisplayOnPole(changet);
      DisplayLineOnPole;
   end;
end;

function TPoleDisplayObj.getPoleDisplayWidth: Integer;
begin
   if sameText(PoleDisplayName , VFD860) then result := 19
   else if sameText(PoleDisplayName , GIGATEKDSP830) then result := 29
   else result := 20;
end;

procedure TPoleDisplayObj.GiGaTekDSPClear;
begin
(*  Writer.Write(chr(HexToInt('0C'))); {clear screen}
  Writer.Write(chr(HexToInt('0B'))); {cursor Left}
  Writer.Write(chr(HexToInt('1F')));Writer.Write(chr(HexToInt('0A')));{1 up 4 limes}
  Writer.Write(chr(HexToInt('1F')));Writer.Write(chr(HexToInt('0A')));{1 up}
  Writer.Write(chr(HexToInt('1F')));Writer.Write(chr(HexToInt('0A')));{1 up}
  Writer.Write(chr(HexToInt('1F')));Writer.Write(chr(HexToInt('0A')));{1 up}*)
  StrToWriter(replicatestr(' ' , PoleDisplayWidth) , pdaCentre);
  StrToWriter(replicatestr(' ' , PoleDisplayWidth) , pdaCentre);
  StrToWriter(replicatestr(' ' , PoleDisplayWidth) , pdaCentre);
  StrToWriter(replicatestr(' ' , PoleDisplayWidth) , pdaCentre);
end;

(*function TPoleDisplayObj.HexToInt(HexValue: String): Integer;
var
  ctr, i:Integer;
  function calcpower(no, exponent:Integer):Integer;
    var
    x:Integer;
  begin
    result := no;
    if exponent=1 then exit;
    for x:= 2 to exponent do
      result := result *no;
  end;
begin
  result :=0;
  if hexvalue = '' then exit;
  for ctr := char_length(hexValue) downto 1 do begin
         if copy(hexValue, ctr, 1) = '0' then i:=0
    else if copy(hexValue, ctr, 1) = '1' then i:=1
    else if copy(hexValue, ctr, 1) = '2' then i:=2
    else if copy(hexValue, ctr, 1) = '3' then i:=3
    else if copy(hexValue, ctr, 1) = '4' then i:=4
    else if copy(hexValue, ctr, 1) = '5' then i:=5
    else if copy(hexValue, ctr, 1) = '6' then i:=6
    else if copy(hexValue, ctr, 1) = '7' then i:=7
    else if copy(hexValue, ctr, 1) = '8' then i:=8
    else if copy(hexValue, ctr, 1) = '9' then i:=9
    else if copy(hexValue, ctr, 1) = 'A' then i:=10
    else if copy(hexValue, ctr, 1) = 'B' then i:=11
    else if copy(hexValue, ctr, 1) = 'C' then i:=12
    else if copy(hexValue, ctr, 1) = 'D' then i:=13
    else if copy(hexValue, ctr, 1) = 'E' then i:=14
    else if copy(hexValue, ctr, 1) = 'F' then i:=15;
    result := i* calcpower(16 , ctr);
  end;
end;*)

constructor TPoleDisplayObj.Create;
begin
  fbUsePoledisplay :=False;
  fsPolePort        := '';
  fsPoleDisplayName := '';
  PopulateMe(0);
end;

destructor TPoleDisplayObj.Destroy;
begin
    writer.Free;
    stream.Free;
    if not Assigned(PoleDisplayObjSetting) then begin
    FreeAndNil(PoleDisplayObjSetting);
  end;
  inherited;
end;

class procedure TPoleDisplayObj.Instance;
begin
  if not Assigned(PoleDisplayObjSetting) then begin
    PoleDisplayObjSetting := TPoleDisplayObj.Create;
  end;

end;

procedure TPoleDisplayObj.PopulateMe(const TillID: integer);
var
  qry: TERPQuery;
  fsTillname :string;
begin
  qry := nil;
  try
    qry := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    with qry do begin
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.ParamCheck := false;
      Sql.Add('Select TillName, UsePoledisplay,PolePort, PoleDisplayName');
      Sql.Add('From tblpostills Where TillID = ' + IntToStr(TillID) + ';');
      Open;
    end;

    with qry do begin
      if not IsEmpty then begin
        fbUsePoledisplay :=FieldByName('UsePoledisplay').AsBoolean;
        fsPolePort := FieldByName('PolePort').AsString;
        fsPoleDisplayName := fieldbyname('PoleDisplayName').asString;
        fsTillname :=Fieldbyname('tillname').asString;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
  if fbusepoledisplay then begin
    try
      stream:= TFileStream.Create(PolePort, fmCreate);
      writer:= TStreamWriter.Create(Stream);
      DisplayWelcomeOnPole;
    Except
      on E:Exception do begin
        MessageDlgXP_Vista('Pole Display Port ' +Quotedstr(PolePort) +' Specified for Till '+ Quotedstr(fsTillname)+' Is not Configured Properly.'+chr(13)+chr(13) +
                            'Pole Display is Disabled.' , mtWarning , [mbok] , 0 );
        fbusepoledisplay:= False;
      end;
    end;
  end;
end;

procedure TPoleDisplayObj.StrToWriter(str: string;Align :TPoleDisplayAlignment);
begin
    currentPoledisplay:= str;
    Str:= formatPoledisplayText(Str , Align);
    try
      Writer.Write(PoleNewLinechar);
      Writer.Write(Str);
    Except
      //kill the exception if pole display failed
    end;
end;

procedure TPoleDisplayObj.VFD860Clear;
begin
  Writer.Write(chr(12)); {clear screen}
  Writer.Write(chr(11));{home postion }
  Writer.Write(chr(31));Writer.Write(chr(10));{move cursor up}
end;

Function TPoleDisplayObj.formatPoledisplayText(Value:String; Align :TPoleDisplayAlignment):String;
begin
    if Align = pdaCentre  then begin
      While char_length(Value)< poleDisplaywidth do Value := ' ' +Value +' ';
      Value := copy(Value , 1 , poleDisplaywidth);
    end else if Align = pdaleft then begin
      Value:= copy(Value + replicateStr(' ' ,poleDisplaywidth),1,  poleDisplaywidth) ;
    end else if Align = pdaRight  then begin
      Value:= replicateStr(' ' ,poleDisplaywidth) +Value;
      if char_length(Value)> poleDisplaywidth then Value:= copy(Value, char_length(Value)- poleDisplaywidth+1 , poleDisplaywidth)  ;
    end else if Align = pdanone   then begin
      // no change
    end;
    REsult := Value;
end;
function RoundCurrency(const Value: double): currency;
begin
    Result := DecimalRoundDbl(Value, CurrencyRoundPlaces, drHalfUp);
end;
function CurrToStrRJ(const rValue: currency; const iSize: integer): string;
{ Converts currency value to a Right Justified String (there is probably
  already an RTL function that does this but I couldn't find it). This
  is required by the sting grid for right justifying $ amounts }
var
  sPadded, SUnpadded: string;
  i: integer;
begin
  sUnpadded := CurrToStrF(RoundTo1C(rValue) , ffCurrency , CurrencyRoundPlaces);
  Setlength(sPadded, iSize);
  if char_length(sUnpadded) <= iSize then begin
    for i := 1 to iSize do sPadded[i] := ' ';
    for i := char_length(sUnpadded) downto 1 do sPadded[i + (char_length(sPadded) - char_length(sUnpadded))] := sUnpadded[i];
  end else for i := 1 to iSize do sPadded[i] := '#';
  Result := sPadded;
end;
function RoundTo1C(const rMoney: currency): currency;
  // Rounds money to the closest 1 cents
begin
  Result := RoundCurrency(rMoney);
end;

end.
