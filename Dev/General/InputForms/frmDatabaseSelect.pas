unit frmDatabaseSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb;

type
  TfmDatabaseSelect = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSelect: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    cboDatabase: TwwDBComboBox;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function SelectDatabase(var aDatabase: string): boolean;

implementation

{$R *.dfm}

uses
  CommonDbLib;

function SelectDatabase(var aDatabase: string): boolean;
var
  form: TfmDatabaseSelect;
begin
  result:= false;
  form := TfmDatabaseSelect.Create(nil);
  try
   form.cboDatabase.ItemIndex := form.cboDatabase.Items.IndexOf(aDatabase);
   if form.ShowModal = mrOk then begin
     if form.cboDatabase.Text <> '' then begin
       aDatabase := form.cboDatabase.Text;
       result:= true;
     end;
   end;
  finally
    form.Free;
  end;
end;


procedure TfmDatabaseSelect.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  Action := caFree;
end;

procedure TfmDatabaseSelect.FormCreate(Sender: TObject);
var
  idx: integer;
begin
  inherited;
  CommonDbLib.GetSharedMyDacConnection.GetDatabaseNames(cboDatabase.Items);
  if cboDatabase.Items.Count > 1 then begin
    idx := cboDatabase.Items.IndexOf('erpnewdb');
    if idx >= 0 then
      cboDatabase.Items.Delete(idx);
    cboDatabase.ItemIndex := 0;
  end;
end;
initialization
  RegisterClass(TfmDatabaseSelect);
end.
