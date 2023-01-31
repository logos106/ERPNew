unit frmLicenceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseList, DB, DBAccess, MyAccess, MemDS, Grids, Wwdbigrd,
  Wwdbgrid, ExtCtrls, StdCtrls;

type
  TfmLicenceList = class(TfmBaseList)
    cbStatus: TComboBox;
    Label1: TLabel;
    chkAllStatus: TCheckBox;
    rgLicenceActive: TRadioGroup;
    rgClientActive: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure cbStatusChange(Sender: TObject);
    procedure chkAllStatusClick(Sender: TObject);
    procedure gdMainDblClick(Sender: TObject);
  private
    CleanSQL: string;
  protected
    procedure LoadConfig; override;
    procedure SaveConfig; override;
  public
    procedure RefreshData; override;
  end;

var
  fmLicenceList: TfmLicenceList;

implementation

{$R *.dfm}

uses
  AppConfigObj, frmBaseEdit, ComponentLib;

{ TfmLicenceList }

procedure TfmLicenceList.FormCreate(Sender: TObject);
begin
  CleanSQL:= qryMain.SQL.Text;
  inherited;
  AutoReopen:= true;
  RefreshData;
end;

procedure TfmLicenceList.cbStatusChange(Sender: TObject);
begin
  inherited;
  RefreshData;
end;

procedure TfmLicenceList.chkAllStatusClick(Sender: TObject);
begin
  inherited;
  RefreshData;
end;

procedure TfmLicenceList.LoadConfig;
begin
  inherited;
  Inc(LoadingConfig);
  try
    if AppConfig.Data.O[ClassName].I['cbStatus_ItemIndex'] > -1 then
      cbStatus.ItemIndex:= AppConfig.Data.O[ClassName].I['cbStatus_ItemIndex'];
    chkAllStatus.Checked:= AppConfig.Data.O[ClassName].B['chkAllStatus_Checked'];
    if AppConfig.Data.O[ClassName].I['rgLicenceActive_ItemIndex'] > -1 then
      rgLicenceActive.ItemIndex:= AppConfig.Data.O[ClassName].I['rgLicenceActive_ItemIndex'];
    if AppConfig.Data.O[ClassName].I['rgClientActive_ItemIndex'] > -1 then
      rgClientActive.ItemIndex:= AppConfig.Data.O[ClassName].I['rgClientActive_ItemIndex'];
  finally
    Dec(LoadingConfig);
  end;
end;

procedure TfmLicenceList.SaveConfig;
begin
  inherited;
  AppConfig.Data.O[ClassName].I['cbStatus_ItemIndex']:= cbStatus.ItemIndex;
  AppConfig.Data.O[ClassName].B['chkAllStatus_Checked']:= chkAllStatus.Checked;
  AppConfig.Data.O[ClassName].I['rgLicenceActive_ItemIndex']:= rgLicenceActive.ItemIndex;
  AppConfig.Data.O[ClassName].I['rgClientActive_ItemIndex']:= rgClientActive.ItemIndex;
end;

procedure TfmLicenceList.RefreshData;
var
  s: string;
begin
  if LoadingConfig > 0 then
    exit;
  qryMain.Close;
  if not chkAllStatus.Checked then begin
    if s <> '' then s:= s + ' and ';
    s:= s + 'l.status = ' + QuotedStr(cbStatus.Text)
  end;
  case rgLicenceActive.ItemIndex of
    0: begin
         if s <> '' then s:= s + ' and ';
         s:= s  + '(l.active = "T")';
       end;
    1: begin
         if s <> '' then s:= s + ' and ';
         s:= s  + '(l.active = "F")';
       end;
    2: begin
       end;
  end;
  case rgClientActive.ItemIndex of
    0: begin
         if s <> '' then s:= s + ' and ';
         s:= s  + '(c.active = "T")';
       end;
    1: begin
         if s <> '' then s:= s + ' and ';
         s:= s  + '(c.active = "F")';
       end;
    2: begin
       end;
  end;
  if s <> '' then
    qryMain.SQL.Text:= CleanSQL + ' and ' + s
  else
    qryMain.SQL.Text:= CleanSQL;
  qryMain.Open;
end;

procedure TfmLicenceList.gdMainDblClick(Sender: TObject);
var
  EditForm: TfmBaseEdit;
begin
  inherited;
  EditForm:= TfmBaseEdit(CreateComponentInst('TfmClientEdit'));
  if Assigned(EditForm) then begin
    EditForm.KeyID:= qryMain.FieldByName('ClientId').AsInteger;
  end;
end;

initialization
  RegisterClass(TfmLicenceList);

end.
