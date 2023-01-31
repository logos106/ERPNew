unit MessageInfoObj;

interface

uses
  ConTnrs, Classes, XMLIntf;

type

  TMessageInfo = class(TObject)
  private
    //fID: string;
    fMessagePath: string;
    Docs: TObjectList;
    fReceipt: TObject;
    procedure SetID(const Value: string);
    function GetID: string;
    function GetTryCount: integer;
    procedure SetTryCount(const Value: integer);
    function GetRetryCount: integer;
    procedure SetRetryCount(const Value: integer);
  public
    Info: TStringList;
    constructor Create(const aMessagePath: string);
    destructor Destroy; override;
    property ID: string read GetID write SetID;
    property TryCount: integer read GetTryCount write SetTryCount;
    procedure Save;
    procedure Load;
    procedure AddDocument(aDocName: string; aDocStream: TStream); overload;
    procedure AddDocument(aDocName: string; aDocStr: string); overload;
    procedure AddDocument(aDocName: string; aDoc: IXMLDocument); overload;
    property Receipt: TObject read fReceipt write fReceipt;
    property RetryCount: integer read GetRetryCount write SetRetryCount;
    class function NewInst(const aMessageDir: string): TMessageInfo; overload;
    class function NewInst(const aMessageDir, aFolder: string): TMessageInfo; overload;
  end;

  TMessageInfoDoc = class
  public
    Stream: TStringStream;
    Name: string;
    constructor Create;
    destructor Destroy; override;
  end;


implementation

uses
  SysUtils, RandomUtils;

{ TMessageInfo }

procedure TMessageInfo.AddDocument(aDocName: string; aDocStream: TStream);
var Doc: TMessageInfoDoc;
begin
  Doc := TMessageInfoDoc.Create;
  Doc.Name := aDocName;
  aDocStream.Position := 0;
  Doc.Stream.LoadFromStream(aDocStream);
  Docs.Add(Doc);
end;

procedure TMessageInfo.AddDocument(aDocName, aDocStr: string);
var Doc: TMessageInfoDoc;
begin
  Doc := TMessageInfoDoc.Create;
  Doc.Name := aDocName;
  Doc.Stream.WriteString(aDocStr);
  Docs.Add(Doc);
end;

procedure TMessageInfo.AddDocument(aDocName: string; aDoc: IXMLDocument);
var Doc: TMessageInfoDoc;
begin
  Doc := TMessageInfoDoc.Create;
  Doc.Name := aDocName;
  aDoc.SaveToStream(Doc.Stream);
  Docs.Add(Doc);
end;

constructor TMessageInfo.Create(const aMessagePath: string);
begin
  self.fMessagePath := aMessagePath;
  Docs := TObjectList.Create;
  Info := TStringList.Create;
  TryCount := 0;
  Load;
end;

destructor TMessageInfo.Destroy;
begin
  Info.Free;
  Docs.Free;
  fReceipt.Free;
  inherited;
end;

function TMessageInfo.GetID: string;
begin
  result := Info.Values['ID'];
end;

function TMessageInfo.GetRetryCount: integer;
begin
  result := StrToIntDef(Info.Values['RetryCount'],0);
end;

function TMessageInfo.GetTryCount: integer;
begin
  result := StrToIntDef(Info.Values['TryCount'],0);
end;

procedure TMessageInfo.Load;
var
  dir: string;
  sr: TSearchRec;
  FileAttrs: Integer;
  Doc: TMessageInfoDoc;
begin
  dir:= self.fMessagePath + '\';
  self.Docs.Clear;
  self.Info.Clear;
   FileAttrs := 0;
   if SysUtils.FindFirst(dir + '*.*',FileAttrs, sr) = 0 then begin
     repeat
       if SameText(sr.Name,'Info.txt') then begin
         self.Info.LoadFromFile(dir + 'Info.txt');
       end
       else begin
         Doc := TMessageInfoDoc.Create;
         Doc.Name := sr.Name;
         Doc.Stream.LoadFromFile(dir + sr.Name);
         Docs.Add(Doc);
       end;
     until FindNext(sr) <> 0;
     FindClose(sr);
   end;
end;

class function TMessageInfo.NewInst(const aMessageDir,
  aFolder: string): TMessageInfo;
var
  TryCount: integer;
begin
  result:= nil;
  tryCount := 20;
  while tryCount > 0 do begin
    Dec(tryCount);
    if ForceDirectories(aMessageDir + '\'  + aFolder) then begin
      result := TMessageInfo.Create(aMessageDir + '\'  + aFolder);
      result.Id := aFolder;
      exit;
    end
    else
      Sleep(5);
  end;
end;

class function TMessageInfo.NewInst(const aMessageDir: string): TMessageInfo;
var
  TryCount: integer;
  timeStr: string;
begin
  result:= nil;
  tryCount := 20;
  while tryCount > 0 do begin
    Dec(tryCount);
    timeStr := FormatDateTime('yyyy_mm_dd_hh-nn-ss-zzz',now);
    if ForceDirectories(aMessageDir + '\'  + timeStr) then begin
      result := TMessageInfo.Create(aMessageDir + '\'  + timeStr);
      result.Id := timeStr;
      exit;
    end
    else
      Sleep(5);
  end;
end;

procedure TMessageInfo.Save;
var
  dir: string;
  x: integer;
begin
  dir := fMessagePath + '\';
  Info.SaveToFile(dir + 'Info.txt');
  for x := 0 to Docs.Count -1 do begin
    TMessageInfoDoc(Docs[x]).Stream.SaveToFile(dir + TMessageInfoDoc(Docs[x]).Name);
  end;
end;

procedure TMessageInfo.SetID(const Value: string);
begin
  Info.Values['ID'] := Value;
end;

procedure TMessageInfo.SetRetryCount(const Value: integer);
begin
  Info.Values['RetryCount'] := IntToStr(Value);
end;

procedure TMessageInfo.SetTryCount(const Value: integer);
begin
  Info.Values['TryCount'] := IntToStr(Value);
end;

{ TMessageInfoDoc }

constructor TMessageInfoDoc.Create;
begin
  Stream := TStringStream.Create;
end;

destructor TMessageInfoDoc.Destroy;
begin
  Stream.Free;
  inherited;
end;



end.
