unit DtdObj;

interface

uses
  ConTnrs;

type

  TQuantifierType = (qRequiredOnce,qOneOrMore,qZeroOrMore,qOptionalOnce);
   {[blank] , + , * , ? }

  TItem = class
  public
    Name: string;
    Quantifer : TQuantifierType;
    constructor Create;
  end;

  TElement = class
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItem(index: integer): TItem;
  public
    Name: string;
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[index: integer]: TItem read GetItem;
    procedure Add(aItem: TItem);
  end;

  TDTD = class
  private
    fList: TObjectList;
    fFileName: string;
    function GetCount: integer;
    function GetElement(index: integer): TElement;
    function GetElementByName(aName: string): TElement;
    procedure ProcessElement(s: string);
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Element[index: integer]: TElement read GetElement;
    property ElementByName[aName: string]: TElement read GetElementByName;
    procedure Add(aElement: TElement);
    procedure LoadFromFile(aFileName: string);
    procedure SaveAsXML(aFileName: string = ''; ShowQuantiferType: boolean = false; OmitOptional: boolean = false);
  end;


implementation

uses
  SysUtils, StrUtils, types, Classes;

{ TItem }

constructor TItem.Create;
begin
  Quantifer:= qRequiredOnce;
end;

{ TElement }

procedure TElement.Add(aItem: TItem);
begin
  fList.Add(aItem);
end;

constructor TElement.Create;
begin
  fList:= TObjectList.Create;
end;

destructor TElement.Destroy;
begin
  fList.Free;
  inherited;
end;

function TElement.GetCount: integer;
begin
  result:= fList.Count;
end;

function TElement.GetItem(index: integer): TItem;
begin
  result := TItem(fList[index]);
end;

{ TDTD }

procedure TDTD.Add(aElement: TElement);
begin
  fList.Add(aElement);
end;

constructor TDTD.Create;
begin
  fList:= TObjectList.Create;
end;

destructor TDTD.Destroy;
begin
  fList.Free;
  inherited;
end;

function TDTD.GetCount: integer;
begin
  result := fList.Count;
end;

function TDTD.GetElement(index: integer): TElement;
begin
  result:= TElement(fList[index]);
end;

function TDTD.GetElementByName(aName: string): TElement;
var
  x: integer;
begin
  result:= nil;
  for x := 0 to Count -1 do begin
    if SameText(self.Element[x].Name, aName) then begin
      result:= self.Element[x];
      break;
    end;
  end;
end;

procedure TDTD.LoadFromFile(aFileName: string);
var
  f: TextFile;
  line: string;
  inElement: boolean;
  elementStr: string;
begin
  fFileName:= aFileName;
  inElement := false;
  self.fList.Clear;
  AssignFile(f, aFileName);
  Reset(f);
  try
    while not EOF(f) do begin
      ReadLn(f,line);
      if inElement then begin
        if Pos('>',line) > 0 then begin
          { end of element }
          elementStr := elementStr + ReplaceStr(line,'>','');

          ProcessElement(elementStr);
          inElement:= false;
          elementStr := '';
        end
        else
          elementStr := elementStr + line;
      end
      else begin
        if Pos('<!ELEMENT',line) > 0 then begin
          inElement := true;
          elementStr := Copy(line,Pos('<!ELEMENT',line)+10,Length(line));

          if Pos('>',line) > 0 then begin
            { end of element }
            elementStr := ReplaceStr(elementStr,'>','');

            ProcessElement(elementStr);
            inElement:= false;
            elementStr := '';
          end

        end;
      end;

    end;

  finally
    CloseFile(f);
  end;
end;

procedure TDTD.ProcessElement(s: string);
var
  itemsStr, itemStr: string;
  x, posn: integer;
  StrArray: TStringDynArray;
  newElement : TElement;
  newItem : TItem;
  QuantiferStr: string;
begin
  posn:= Pos('(',s);
  if posn > 0 then begin
    newElement := TElement.Create;
    newElement.Name := Trim(Copy(s,1,posn-1));
    itemsStr := Copy(s,posn+1,Length(s));
    itemsStr := Trim(ReplaceStr(itemsStr,')',''));
    StrArray := SplitString(itemsStr,',');
    for x := Low(StrArray) to High(StrArray) do begin
      itemStr := Trim(StrArray[x]);
      if Pos('#',itemStr) = 1 then begin
        { ignore it }

      end
      else begin
        newItem := TItem.Create;
        QuantiferStr := RightStr(itemStr,1);
        if SameText(QuantiferStr,'+') then begin
          newItem.Name := LeftStr(itemStr,Length(itemStr)-1);
          newItem.Quantifer := qOneOrMore;
        end
        else if SameText(QuantiferStr,'*') then begin
          newItem.Name := LeftStr(itemStr,Length(itemStr)-1);
          newItem.Quantifer := qZeroOrMore;
        end
        else if SameText(QuantiferStr,'?') then begin
          newItem.Name := LeftStr(itemStr,Length(itemStr)-1);
          newItem.Quantifer := qOptionalOnce;
        end
        else begin
          newItem.Name := itemStr;
          newItem.Quantifer := qRequiredOnce;
        end;
        newElement.Add(newItem);
      end;
    end;
    self.Add(newElement);
  end;
end;

procedure TDTD.SaveAsXML(aFileName: string; ShowQuantiferType: boolean; OmitOptional: boolean);
var
  sl: TStringList;
  aFile: string;

  procedure OutputStr(aStr: string; aIndent: integer);
  var
    indStr: string;
    indCnt: integer;
  begin
    indStr := aStr;
    for indCnt := 1 to aIndent do
      indStr := #9 + indStr;
    sl.Add(indStr);
  end;

  procedure OutputElement(aElement: TElement; QuantiferType: TQuantifierType; elmIndent: integer);
  var
    cnt: integer;
    itm: TItem;
    subElement: TElement;

    function QuantifierStr(QT: TQuantifierType): string;
    begin
      result:= '';
      if ShowQuantiferType then begin
        case QT of
          qRequiredOnce: result := ' Quantifier="RequiredOnce"';
          qOneOrMore: result := ' Quantifier="OneOrMore"';
          qZeroOrMore: result := ' Quantifier="ZeroOrMore"';
          qOptionalOnce: result := ' Quantifier="OptionalOnce"';
        end;
      end;
    end;

  begin
    if OmitOptional and ((QuantiferType = qZeroOrMore) or (QuantiferType = qOptionalOnce)) then exit;

    if aElement.Count > 0 then begin
      OutputStr('<' + aElement.Name + QuantifierStr(QuantiferType) + '>',elmIndent);
      for cnt := 0 to aElement.Count -1 do begin
        itm := aElement.Item[cnt];
        subElement := self.GetElementByName(itm.Name);
        if Assigned(subElement) then begin
          OutputElement(subElement,itm.Quantifer,elmIndent+1);
        end
        else begin
          OutputStr('<' + itm.Name + QuantifierStr(itm.Quantifer) + '></' +itm.Name + '>',elmIndent);
        end;

      end;
      OutputStr('</' +aElement.Name + '>',elmIndent);
    end
    else
      OutputStr('<' + aElement.Name + QuantifierStr(QuantiferType) + '></' +aElement.Name + '>',elmIndent);
  end;


begin
  if aFileName <> '' then aFile := aFileName
  else aFile := ChangeFileExt(fFileName,'.xml');
  if self.Count > 0 then begin
    sl := TStringList.Create;
    try
      sl.Add('<?xml version="1.0" encoding="utf-8"?>');
      sl.Add('<!DOCTYPE ' + self.Element[0].Name + ' SYSTEM "' + ExtractFileName(fFileName) + '">' );
      OutputElement(self.Element[0],qRequiredOnce,0);
      sl.SaveToFile(aFile);
    finally
      sl.Free;
    end;
  end;
end;

end.
