unit frmEDIDataFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, JsonObject, StdCtrls, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb;

type
  TfmEDIDataFilter = class(TForm)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    cboColumn: TwwDBComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cboSelectWhen: TwwDBComboBox;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboColumnChange(Sender: TObject);
    procedure cboSelectWhenChange(Sender: TObject);
  private
    Loading: boolean;
  public
    FileConfig: TJsonObject;
    Idx: integer;
  end;

  function DoDataFilter(aFileConfig: TJsonObject; aIdx: integer; aColor: TColor): boolean;

implementation

uses
  Vista_MessageDlg;

{$R *.dfm}

function DoDataFilter(aFileConfig: TJsonObject; aIdx: integer; aColor: TColor): boolean;
var
  form: TfmEDIDataFilter;
begin
  form := TfmEDIDataFilter.Create(nil);
  try
    form.Color := aColor;
    form.FileConfig.Assign(aFileConfig);
    form.Idx := aIdx;
    result := form.ShowModal = mrOk;
    if result then
      aFileConfig.Assign(form.FileConfig);
  finally
    form.Release;
  end;
end;

{ TfmEDIDataFilter }

procedure TfmEDIDataFilter.btnSaveClick(Sender: TObject);
begin
  if cboColumn.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Please select a Column for the Filter',mtInformation,[mbOk],0);
    exit;
  end;
  if cboSelectWhen.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Please select a "Select When" Value',mtInformation,[mbOk],0);
    exit;
  end;

  ModalResult := mrOk;
end;

procedure TfmEDIDataFilter.cboColumnChange(Sender: TObject);
begin
  if Loading then exit;
  FileConfig.A['Filters'][Idx].AsObject.I['ColumnNumber'] := StrToInt(cboColumn.Value);
end;

procedure TfmEDIDataFilter.cboSelectWhenChange(Sender: TObject);
begin
  if Loading then exit;
  FileConfig.A['Filters'][Idx].AsObject.S['SelectWhen'] := cboSelectWhen.Value;
end;

procedure TfmEDIDataFilter.FormCreate(Sender: TObject);
begin
  FileConfig := TJsonObject.Create;
end;

procedure TfmEDIDataFilter.FormDestroy(Sender: TObject);
begin
  FileConfig.Free;
end;

procedure TfmEDIDataFilter.FormShow(Sender: TObject);
var
  x: integer;
begin
  Loading := true;
  try
    cboColumn.Items.Clear;
    for x := 0 to FileConfig.O['Columns'].Count -1 do begin
      cboColumn.Items.Add(FileConfig.O['Columns'][x].Value.AsObject.S['Name'] + #9 + FileConfig.O['Columns'][x].Name);
    end;
    if Idx >= 0 then begin
      cboColumn.Value := IntToStr(FileConfig.A['Filters'][Idx].AsObject.I['ColumnNumber']);
      cboSelectWhen.Value := FileConfig.A['Filters'][Idx].AsObject.S['SelectWhen'];
    end
    else begin
      FileConfig.A['Filters'].Add(JO);
      Idx := FileConfig.A['Filters'].Count -1;
    end;


  finally
    Loading := false;
  end;
end;

end.
