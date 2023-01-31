unit ListSelector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DNMSpeedButton, CheckLst, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents;

type
  TfmListSelector = class(TForm)
    chkList: TCheckListBox;
    lblHeader: TLabel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
  private
    fKeyField: string;
    fQuery: TERPQuery;
    function GetHeader: string;
    procedure SetHeader(const Value: string);
    { Private declarations }
  protected
    procedure Resize;override;
  public
    { Public declarations }
    function SelectedList : TStringList;


    property Header : string read GetHeader write SetHeader;
    property Query : TERPQuery read fQuery write fQuery;
    property KeyField : string read fKeyField write fKeyField;
  end;


function SelectFromList(qry : TERPQuery; const aFieldName : string; const aHeader : string) : TStringList;

implementation

{$R *.dfm}

{ TfmListSelector }

procedure TfmListSelector.FormShow(Sender: TObject);
begin
//
  if not Assigned(Query) then
    raise Exception.Create('ListSelector: Query not set');
  if KeyField = '' then
    raise Exception.Create('ListSelector: KeyField Not Defined');
  if query.FindField(KeyField) = nil then
    raise Exception.Create('ListSelector: Wrong KeyField');

  query.First;
  while not Query.Eof  do
  begin
    chkList.Items.Add(Query.FieldByName(KeyField).AsString);
    Query.Next;
  end;

  lblHeader.Caption := Header;

end;

function TfmListSelector.GetHeader: string;
begin
  Result := lblHeader.Caption;
end;

procedure TfmListSelector.Resize;
begin
  inherited;
  lblHeader.Left := (ClientRect.Right - ClientRect.Left - lblHeader.Canvas.TextWidth(lblHeader.Caption) - 4) div 2;
end;

function TfmListSelector.SelectedList: TStringList;
var
  idx : integer;
begin
  Result := TStringList.Create;
  for idx := 0 to chkList.Count - 1 do
    if chkList.Checked[idx] then
      Result.Add(chkList.Items[idx]);
end;

procedure TfmListSelector.SetHeader(const Value: string);
begin
  lblHeader.Caption := Value;
end;


function SelectFromList(qry : TERPQuery; const aFieldName : string; const aHeader : string) : TStringList;
var
  bm : TBookMark;
  f : TfmListSelector;
begin
  Result := nil;
  if not qry.Active then
    exit;  //  ?? Or shoul i open it?
  if qry.RecordCount = 0 then
    exit;

    bm := qry.GetBookmark;
    try
      f := TfmListSelector.Create(nil);
      f.Header := aHeader;
      f.Query := qry;
      f.KeyField := aFieldName;
      if f.ShowModal = mrOk then
        Result := f.SelectedList
      else
        Result := nil;
    finally
      qry.GotoBookmark(bm);
      qry.FreeBookmark(bm);
    end;

end;
end.
