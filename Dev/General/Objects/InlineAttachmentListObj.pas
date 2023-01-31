unit InlineAttachmentListObj;

interface

uses
  ConTnrs;

type

  TInlineAttachment = class
  private
    fFileName: string;
    fContentId: string;
    fContentType: string;
    procedure SetFileName(const Value: string);
  public
    property FileName: string read fFileName write SetFileName;
    property ContentID: string read fContentId write fContentId;
    property ContentType: string read fContentType write fContentType;
  end;

  TInlineAttachmentList = class
  private
    fList: TObjectList;
    fDomain: string;
    function GetCount: integer;
    function GetInlineAttachment(index: integer): TInlineAttachment;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[index: integer]: TInlineAttachment read GetInlineAttachment; default;
    procedure AddFile(aFileName: string);
    property Domain: string read fDomain write fDomain;
    procedure Clear;
    procedure Assign(aSource: TInlineAttachmentList);
  end;



implementation

uses
  SysUtils, Classes;

{ TInlineAttachment }

procedure TInlineAttachment.SetFileName(const Value: string);
var
  ext: string;
begin
  fFileName := Value;
  fContentType := '';

  ext := Copy(ExtractFileExt(fFileName),2,255);
  if SameText(ext,'bmp') then fContentType := 'image/bmp'
  else if SameText(ext,'jpg') then fContentType := 'image/jpeg'
  else if SameText(ext,'jpeg') then fContentType := 'image/jpeg'
  else if SameText(ext,'png') then fContentType := 'image/png'
  else if SameText(ext,'tif') then fContentType := 'image/tiff'
  else if SameText(ext,'tiff') then fContentType := 'image/tiff'
end;

{ TInlineAttachmentList }

procedure TInlineAttachmentList.AddFile(aFileName: string);
var
  rec: TInlineAttachment;
begin
  rec := TInlineAttachment.Create;
  rec.FileName := aFileName;
  rec.ContentID := IntToStr(fList.Count + 1) + '.' + FormatFloat('#0.000000',now) + '.' + IntToStr(Integer(self)) + fDomain;
  fLIst.Add(rec);
end;

procedure TInlineAttachmentList.Assign(aSource: TInlineAttachmentList);
var
  rec: TInlineAttachment;
  x: integer;
begin
  Clear;
  Domain := aSource.Domain;
  for x := 0 to aSource.Count -1 do begin
    rec := TInlineAttachment.Create;
    rec.FileName := aSource.Item[x].FileName;
    rec.ContentID := aSource.Item[x].ContentID;
    rec.ContentType := aSource.Item[x].ContentType;
    fLIst.Add(rec);
  end;
end;

procedure TInlineAttachmentList.Clear;
begin
  fList.Clear;
end;

constructor TInlineAttachmentList.Create;
begin
  fList:= TObjectList.Create;
end;

destructor TInlineAttachmentList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TInlineAttachmentList.GetCount: integer;
begin
  result := fList.Count;
end;

function TInlineAttachmentList.GetInlineAttachment(
  index: integer): TInlineAttachment;
begin
  result := TInlineAttachment(fLIst[index]);
end;


end.
