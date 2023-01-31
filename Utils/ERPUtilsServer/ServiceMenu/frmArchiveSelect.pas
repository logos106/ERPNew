unit frmArchiveSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DNMSpeedButton, Shader, ExtCtrls, DNMPanel;

type
  TfmArchiveSelect = class(TForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lbRestore: TLabel;
    lbArchive: TListBox;
    cbShowAllDBs: TCheckBox;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbArchiveClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cbShowAllDBsClick(Sender: TObject);
  private
    procedure PopulateList;
  public
    ArchiveList: TStringList;
    DatabaseName: string;
    Selected: string;
  end;

  function GetArchiveName(const aArchiveList, aDatabaseName: string; var aArchiveName: string): boolean;

implementation

{$R *.dfm}

function GetArchiveName(const aArchiveList, aDatabaseName: string; var aArchiveName: string): boolean;
var
  form: TfmArchiveSelect;
begin
  form := TfmArchiveSelect.Create(nil);
  try
    form.ArchiveList.CommaText := aArchiveList;
    form.DatabaseName := aDatabaseName;
    if form.ShowModal = mrOk then begin
      result:= true;
      aArchiveNAme := form.Selected;
    end
    else
      result := false;
  finally
    form.Free;
  end;
end;

procedure TfmArchiveSelect.btnSaveClick(Sender: TObject);
begin
  if Selected <> '' then ModalResult := mrOk
  else ModalResult := mrCancel;
end;

procedure TfmArchiveSelect.cbShowAllDBsClick(Sender: TObject);
begin
  PopulateList;
end;

procedure TfmArchiveSelect.FormCreate(Sender: TObject);
begin
  ArchiveList := TStringList.Create;
end;

procedure TfmArchiveSelect.FormDestroy(Sender: TObject);
begin
  ArchiveList.Free;
end;

procedure TfmArchiveSelect.FormShow(Sender: TObject);
begin
  cbShowAllDBs.Checked := false;
  PopulateList;
end;

procedure TfmArchiveSelect.lbArchiveClick(Sender: TObject);
begin
  Selected := lbArchive.Items[lbArchive.ItemIndex];
end;

procedure TfmArchiveSelect.PopulateList;
var
  x: integer;
begin
  lbArchive.Clear;
  for x := 0 to ArchiveList.Count - 1 do begin
    if cbShowAllDBs.Checked or (DatabaseName = '') or (pos(DatabaseName,ArchiveList[x]) = 1) then
      lbArchive.Items.Add(ArchiveList[x]);
  end;
end;

end.
