unit EDIDocObj;

interface

uses
  Classes, JsonObject;

type
//  TEDIElementValueType = (etNone, etString, etIdentifier, etObject, etArray, etDate, etTime, etNumeric, etDecimal);

  TEDIDoc = class(TJSONObject)
  private
    function MakeElement(aName, aType: string; min, max: integer; required: boolean; Value: string = ''): TJsonObject;
    { Segments }
    function MakeSegISA: TJsonObject;
    function MakeSegGS: TJsonObject;
    function MakeSegST: TJsonObject;

    function GetDataSeparator: string;
    function GetSegmentTerminator: string;
    procedure SetDataSeparator(const Value: string);
    procedure SetSegmentTerminator(const Value: string);
    function StrToSegment(seg: string): TJsonObject;
    function GetRepetitionSeperator: string;
    function GetSubElementSeparator: string;
    procedure SetRepetitionSeperator(const Value: string);
    procedure SetSubElementSeparator(const Value: string);

    function GetElementByName(aSeg: TJsonObject; aElementName: string): TJsonObject;
    function GetElementValByName(aSeg: TJsonObject; aElementName: string): string;
    procedure SetElementValByName(aSeg: TJsonObject; aElementName: string; aValue: string);
  public
    property DataSeparator: string read GetDataSeparator write SetDataSeparator;
    property RepetitionSeperator: string read GetRepetitionSeperator write SetRepetitionSeperator;
    property SubElementSeparator: string read GetSubElementSeparator write SetSubElementSeparator;
    property SegmentTerminator: string read GetSegmentTerminator write SetSegmentTerminator;

    constructor Create;
    procedure ReadFromEDIStream(Stream: TStream);
  end;

implementation

uses
  SysUtils, Character, Types, StrUtils;

const
  ElementType_ID = 'ID';
  ElementType_String = 'AN';
  ElementType_Numeric = 'N';  {Nn where n = digits}
  ElementType_Decimal = 'R';
  ElementType_Date = 'DT'; { CCYYMMDD }
  ElementType_Time = 'TM'; { HHMMSSd..d }

{ TEDIDoc }

constructor TEDIDoc.Create;
begin
  inherited;
  SegmentTerminator := '';
  DataSeparator := '';
end;

function TEDIDoc.GetDataSeparator: string;
begin
  result := S['DataSeparator'];
end;

function TEDIDoc.GetElementByName(aSeg: TJsonObject;
  aElementName: string): TJsonObject;
var
  x: integer;
  element: TJsonObject;
begin
  result := nil;
  for x := 0 to aSeg.A['Elements'].Count -1 do begin
    element := aSeg.A['Elements'].Items[x].AsObject;
    if SameText(element.S['Name'], aElementName) then begin
      result := element;
      exit;
    end;
  end;
end;

function TEDIDoc.GetElementValByName(aSeg: TJsonObject;
  aElementName: string): string;
var
  element: TJsonObject;
begin
  result := '';
  element := GetElementByName(aSeg, aElementName);
  if Assigned(element) then
    result := element.S['Value'];
end;

function TEDIDoc.GetRepetitionSeperator: string;
begin
  result := S['RepetitionSeperator'];
end;

function TEDIDoc.GetSegmentTerminator: string;
begin
  result := S['SegmentTerminator'];
end;

function TEDIDoc.GetSubElementSeparator: string;
begin
  result := S['ElementSeparator'];
end;

function TEDIDoc.MakeElement(aName, aType: string; min, max: integer;
  required: boolean; Value: string): TJsonObject;
begin
  result := JO;
  result.S['Name'] := aName;
  result.S['Value'] := Value;
  result.S['Type'] := aType;
  result.I['Min'] := min;
  result.I['Max'] := max;
  result.B['Required'] := required;
end;

function TEDIDoc.MakeSegGS: TJsonObject;
begin
  { GS Fubctional Group Header }
  result := JO;
  result.S['Name'] := 'GS';
  result.A['Elements'].Add(MakeElement('FunctionalIdentifierCode',ElementType_ID,2,2,true));
  result.A['Elements'].Add(MakeElement('SenderIDCode',ElementType_String,2,15,true));
  result.A['Elements'].Add(MakeElement('ReceiverIDCode',ElementType_String,2,15,true));
  result.A['Elements'].Add(MakeElement('TransmissionDate',ElementType_Date,6,6,true));
  result.A['Elements'].Add(MakeElement('TransmissionTime',ElementType_Date,4,4,true));
  result.A['Elements'].Add(MakeElement('GroupControlNumber',ElementType_Numeric + '0',1,9,true));
  result.A['Elements'].Add(MakeElement('TranactionTypeCode',ElementType_String,1,2,true,'X'));
  result.A['Elements'].Add(MakeElement('Version',ElementType_String,1,12,true));
end;

function TEDIDoc.MakeSegISA: TJsonObject;
begin
  { ISA Interchange Control Header }
  result := JO;
  result.S['Name'] := 'ISA';
  result.A['Elements'].Add(MakeElement('AuthorizationInformationQualifier',ElementType_ID,2,2,true));
  result.A['Elements'].Add(MakeElement('AuthorizationInformation',ElementType_String,10,10,true));
  result.A['Elements'].Add(MakeElement('SecurityInformationQualifier',ElementType_ID,2,2,true));
  result.A['Elements'].Add(MakeElement('SecurityInformation',ElementType_String,10,10,true));
  result.A['Elements'].Add(MakeElement('InterchangeIDQualifierSender',ElementType_ID,2,2,true));
  result.A['Elements'].Add(MakeElement('InterchangeSenderID',ElementType_String,15,15,true));
  result.A['Elements'].Add(MakeElement('InterchangeIDQualifierReceiver',ElementType_ID,2,2,true));
  result.A['Elements'].Add(MakeElement('InterchangeReceiverID',ElementType_String,15,15,true));
  result.A['Elements'].Add(MakeElement('InterchangeDate',ElementType_Date,6,6,true));
  result.A['Elements'].Add(MakeElement('InterchangeTime',ElementType_Time,4,4,true));
  result.A['Elements'].Add(MakeElement('RepititionSeparator',ElementType_ID,1,1,true,'U'));
  result.A['Elements'].Add(MakeElement('InterchangeControlVersionNumber',ElementType_ID,5,5,true,'00400'));
  result.A['Elements'].Add(MakeElement('InterchangeControlNumber',ElementType_Numeric+ '0',9,9,true));
  result.A['Elements'].Add(MakeElement('AcknowledgementRequested',ElementType_ID,1,1,true));
  result.A['Elements'].Add(MakeElement('UsageIndicator',ElementType_ID,1,1,true,'P'));
  result.A['Elements'].Add(MakeElement('SegmentTerminator',ElementType_String,1,1,true));
end;

function TEDIDoc.MakeSegST: TJsonObject;
begin
  { ST Transaction Set Header }
  result := JO;
  result.S['Name'] := 'ST';
  result.A['Elements'].Add(MakeElement('TransactionSetIdentifierCode',ElementType_ID,3,3,true));
  result.A['Elements'].Add(MakeElement('TransactionSetControlNumber',ElementType_String,4,9,true));
end;

procedure TEDIDoc.ReadFromEDIStream(Stream: TStream);
var
  Reader: TStreamReader;
  s: string;
  Ch: Char;
  ChAsInt: integer;
  seg: TJsonObject;
begin
  Clear;
  SegmentTerminator := '';
  DataSeparator := '';
  Reader := TStreamReader.Create(stream);
  try
    ChAsInt := Reader.Peek;
    while ChAsInt >= 0 do begin
      ChAsInt := Reader.Peek;
      Ch := Char(ChAsInt);
      if ChAsInt < 0 then exit;
      if Length(SegmentTerminator) = 0 then begin
        if DataSeparator = '' then begin
          s := s + Char(Reader.Read);
          if Length(Trim(s)) = 3 then begin
            if SameText(Trim(s),'ISA') then begin
              DataSeparator := Char(Reader.Peek);
            end
            else begin
              raise Exception.Create(Classname + ' - Unknown document type');
            end;
          end;
        end
        else begin
          { we have the data separator .. but not segment terminator }
          s := s + Char(Reader.Read);
          if Ch = DataSeparator then begin
            { if next char is a punctuation char then following char will be term }
            if not (TCharacter.IsLetterOrDigit(Char(Reader.Peek)) or (Char(Reader.Peek) = ' ')) then begin
              SubElementSeparator := Char(Reader.Read); // skip to next
              SegmentTerminator := Char(Reader.Read);
              while not TCharacter.IsLetterOrDigit(Char(Reader.Peek)) do
                SegmentTerminator := SegmentTerminator + Char(Reader.Read);
              { process the ISA segment }
              seg := StrToSegment(s);
              A['Segments'].Add(seg);
              s:= '';
            end;
          end;
        end;

      end
      else begin
        s := s + Char(Reader.Read);


      end;

    end;
  finally
    Reader.Free;
  end;
end;

procedure TEDIDoc.SetDataSeparator(const Value: string);
begin
  S['DataSeparator'] := Value;
end;

procedure TEDIDoc.SetElementValByName(aSeg: TJsonObject; aElementName,
  aValue: string);
var
  element: TJsonObject;
begin
  element := GetElementByName(aSeg, aElementName);
  if Assigned(element) then
    element.S['Value'] := aValue;
end;

procedure TEDIDoc.SetRepetitionSeperator(const Value: string);
begin
  S['RepetitionSeperator'] := Value;
end;

procedure TEDIDoc.SetSegmentTerminator(const Value: string);
begin
  S['SegmentTerminator'] := Value;
end;

procedure TEDIDoc.SetSubElementSeparator(const Value: string);
begin
  S['ElementSeparator'] := Value;
end;

function TEDIDoc.StrToSegment(seg: string): TJsonObject;
var
  s: string;
  arr: TStringDynArray;
  x: integer;
begin
  s:= Trim(seg);
  arr := StrUtils.SplitString(s,DataSeparator);
  if SameText(arr[0],'ISA') then begin
    result := MakeSegISA;
  end;

  if Assigned(result) then begin
    if SameText(arr[0],'ISA') then begin
      if High(arr) <> 16 then
        raise Exception.Create(ClassName + ' - Invalid element count for Segment ' + arr[0]);
      for x := (Low(arr) +1) to High(arr) do
        result.A['Elements'].Items[x-1].AsObject.S['Value'] := arr[x];
      SetElementValByName(result, 'SegmentTerminator', self.SegmentTerminator);
    end
    else begin
      if High(arr) <> result.A['Elements'].Count then
        raise Exception.Create(ClassName + ' - Invalid element count for Segment ' + arr[0]);
      for x := (Low(arr) +1) to High(arr) do
        result.A['Elements'].Items[x-1].AsObject.S['Value'] := arr[x];



    end;

  end;

end;

end.
