unit frmdatabaseSelection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton, Shader,
  DNMPanel;

type
  TfmdatabaseSelection = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    lstDatabases: TListBox;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lstDatabasesDblClick(Sender: TObject);
  private
    function getSelectedDatabases: String;
    procedure SetSelectedDatabases(const Value: String);
  public
    Property SelectedDatabases:String read getSelectedDatabases write SetSelectedDatabases;
  end;
  function selectDatabase:String;
  function selectDatabases(fsSelectedDatabases:String):String;

implementation

uses AppEnvironment, CommonLib, AppDatabase, ERPVersionConst;

{$R *.dfm}

function selectDatabase:String;
var
  form :TfmdatabaseSelection;
begin
  form := TfmdatabaseSelection.Create(nil);
  try
    if form.modalresult = mrOk then
      REsult := form.lstDatabases.Items[form.lstDatabases.ItemIndex];
  finally
    Freeandnil(form);
  end;
end;

function selectDatabases(fsSelectedDatabases:String):String;
var
  form :TfmdatabaseSelection;
begin
  //form := TfmdatabaseSelection.Create(nil);
  form := TfmdatabaseSelection(getcomponentbyclassname('TfmdatabaseSelection' , false));
  if not Assigned(form) then exit;
  try
    form.SelectedDatabases := fsSelectedDatabases;
    form.showmodal;
    if form.modalresult = mrOk then
      REsult := form.SelectedDatabases
    else result:=fsSelectedDatabases;
  finally
    Freeandnil(form);
  end;
end;

procedure TfmdatabaseSelection.FormCreate(Sender: TObject);
var
  x: integer;
  DbRec: TDatabaseRec;
begin
  inherited;
  lstDatabases.Items.Clear;

 for x:= 0 to AppEnv.AppDb.DatabaseList.Count -1 do begin
    DbRec:= TDatabaseRec(AppEnv.AppDb.DatabaseList.Objects[x]);
    if DbRec.Name <> 'erpnewdb' then begin
      if sametext(DbRec.Version , TABLE_VERSION) then
        lstDatabases.Items.add (DbRec.Name);
    end;
  end;
  lstDatabases.ItemIndex := 0;
end;

function TfmdatabaseSelection.getSelectedDatabases: String;
var
  ctr:Integer;
begin
  result:= '';
  for ctr:= 0 to lstDatabases.Count-1 do begin
    if lstDatabases.Selected[ctr] then begin
      if result <> '' then result := result +',';
      Result := result + lstDatabases.items[ctr];
    end;
  end;
end;

procedure TfmdatabaseSelection.lstDatabasesDblClick(Sender: TObject);
begin
  inherited;
  Modalresult:= mrOk;
end;

procedure TfmdatabaseSelection.SetSelectedDatabases(const Value: String);
var
  ctr:Integer;
  st:TStringlist;
  i:Integer;
begin
  if value ='' then begin
    lstDatabases.ClearSelection;
    exit;
  end;
  st:= TStringlist.Create;
  try
    st.CommaText := Value;
    for ctr:= 0 to st.Count-1 do begin
      i:= lstDatabases.Items.IndexOf(st[ctr]);
      if i>=0 then
        lstDatabases.Selected[i]:= true;
    end;
  finally
    freeandnil(st);
  end;
end;

initialization
  RegisterClass(TfmdatabaseSelection);

end.

