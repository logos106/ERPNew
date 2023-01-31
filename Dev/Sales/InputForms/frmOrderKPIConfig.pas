unit frmOrderKPIConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, DNMSpeedButton, StdCtrls, Shader, DNMPanel,
  BusObjPreference, JsonObject, Mask, wwdbedit, Wwdotdot, Wwdbcomb;

type
  TfmOrderKPIConfig = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    cboQuoteLetter: TwwDBComboBox;
    lstSelected: TListBox;
    lstTemplates: TListBox;
    Label3: TLabel;
    btnAdd: TButton;
    btnRemove: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboQuoteLetterCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure lstTemplatesDblClick(Sender: TObject);
    procedure lstSelectedDblClick(Sender: TObject);
  private
    Pref: TPreference;
    Config: TJsonObject;
  public
    { Public declarations }
  end;

  function DoConfig: boolean;

implementation

{$R *.dfm}

uses
  BusObjBase, CommonDbLib, ERPDbComponents;

function DoConfig: boolean;
var
  form: TfmOrderKPIConfig;
begin
  form := TfmOrderKPIConfig.Create(nil);
  try
    result := form.ShowModal = mrOk;
  finally
    form.Free;
  end;
end;

procedure TfmOrderKPIConfig.btnAddClick(Sender: TObject);
begin
  inherited;
  if lstTemplates.ItemIndex >= 0 then begin
    lstSelected.Items.Add(lstTemplates.Items[lstTemplates.ItemIndex]);
    lstTemplates.Items.Delete(lstTemplates.ItemIndex);
  end;
end;

procedure TfmOrderKPIConfig.btnRemoveClick(Sender: TObject);
begin
  inherited;
  if lstSelected.ItemIndex >= 0 then begin
    lstTemplates.Items.Add(lstSelected.Items[lstSelected.ItemIndex]);
    lstSelected.Items.Delete(lstSelected.ItemIndex);
  end;
end;

procedure TfmOrderKPIConfig.btnSaveClick(Sender: TObject);
var
  x: integer;
begin
  inherited;
  Config.A['DeliveryConfirmationList'].Clear;
  for x := 0 to lstSelected.Items.Count -1 do
    Config.A['DeliveryConfirmationList'].Add(lstSelected.Items[x]);
  Pref.PrefValue := Config.AsString;
  Pref.Save;
  ModalResult := mrOk;
end;

procedure TfmOrderKPIConfig.cboQuoteLetterCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;
  Config.S['QuoteLetter'] := Sender.Text;
end;

procedure TfmOrderKPIConfig.FormCreate(Sender: TObject);
begin
  inherited;
  Pref := TPreference.Create(nil);
  Pref.Connection:= TMyDacDataConnection.Create(Pref);
  Pref.Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
  Pref.Load(0,'Config','TfmOrderKPIListing');
  Config := TJsonObject.Create;
  Config.AsString:= Pref.PrefValue;
end;

procedure TfmOrderKPIConfig.FormDestroy(Sender: TObject);
begin
  inherited;
  Config.Free;
  Pref.Free;
end;

procedure TfmOrderKPIConfig.FormShow(Sender: TObject);
var
  qry : TERPQuery;
  x: integer;
begin
  inherited;
  qry := TERPQuery.Create(nil);
  try
    cboQuoteLetter.Clear;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'select TemplName from tbltemplates where Active = "T" order by TemplName';
    qry.Open;
    while not qry.Eof do begin
      cboQuoteLetter.Items.Add(qry.Fields[0].AsString);
      lstTemplates.Items.Add(qry.Fields[0].AsString);
      qry.Next;
    end;
    for x := 0 to Config.A['DeliveryConfirmationList'].Count -1 do begin
      lstSelected.Items.Add(Config.A['DeliveryConfirmationList'].Items[x].AsString);
      if lstTemplates.Items.IndexOf(Config.A['DeliveryConfirmationList'].Items[x].AsString) >= 0 then
        lstTemplates.Items.Delete(lstTemplates.Items.IndexOf(Config.A['DeliveryConfirmationList'].Items[x].AsString));
    end;
    cboQuoteLetter.ItemIndex := cboQuoteLetter.Items.IndexOf(Config.S['QuoteLetter']);
  finally
    qry.Free;
  end;
end;

procedure TfmOrderKPIConfig.lstSelectedDblClick(Sender: TObject);
begin
  inherited;
  btnRemove.Click;
end;

procedure TfmOrderKPIConfig.lstTemplatesDblClick(Sender: TObject);
begin
  inherited;
  btnAdd.Click;
end;

end.
