unit frmRegionalOptionSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, wwdblook, Shader, DNMSpeedButton, DNMPanel, ProgressDialog;

type
  TfmRegionalOptionSelect = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryRegion: TMyQuery;
    cboRegion: TwwDBLookupCombo;
    lblDisableCalcs: TLabel;
    btnNewRegion: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure cboRegionNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnNewRegionClick(Sender: TObject);
  private
  public
    procedure SetCompanyRegion(const aRegion: string);
  end;


  function DoSelectRegion: string;

implementation

{$R *.dfm}

uses
  frmRegionalOptionEdit, CommonLib, PreferancesLib;


function DoSelectRegion: string;
var
  form: TfmRegionalOptionSelect;
begin
  result:= '';
  form:= TfmRegionalOptionSelect.Create(nil);
  try
    if form.ShowModal = mrOk then begin
      result:= form.cboRegion.Text;
      form.SetCompanyRegion(result);
    end;
  finally
    form.Free;
  end;
end;

procedure TfmRegionalOptionSelect.FormShow(Sender: TObject);
begin
  inherited;
  qryRegion.Open;
end;

procedure TfmRegionalOptionSelect.cboRegionNotInList(
  Sender: TObject; LookupTable: TDataSet; NewValue: String;
  var Accept: Boolean);
begin
  inherited;
  Accept:= True;
end;

procedure TfmRegionalOptionSelect.SetCompanyRegion(const aRegion: string);
var
  cmd: TMyCommand;
begin
  cmd:= TMyCommand.Create(nil);
  try
    cmd.Connection:= MyConnection;
    cmd.SQL.Text:= 'update tbldbpreferences set FieldValue = ' +
      QuotedStr(aRegion) + ' where Name = "CompanyRegion" and PrefType = "ptCompany"';
    cmd.Execute;
    PreferancesLib.DoPrefAuditTrail;
  finally
    cmd.Free;
  end;
end;

procedure TfmRegionalOptionSelect.btnNewRegionClick(Sender: TObject);
var
  NewRegion : string;
begin
  NewRegion := '';
  if DoNewRegionalOption(NewRegion) then
  begin
    cboRegion.Text:= NewRegion;
    ModalResult:= mrOk;
  end;
end;

procedure TfmRegionalOptionSelect.btnOkClick(Sender: TObject);
var
  NewRegion: string;
begin
  inherited;
  if cboRegion.Text <> '' then begin
    if not qryRegion.Locate('Region',cboRegion.Text,[]) then begin
      NewRegion:= cboRegion.Text;
      if DoNewRegionalOption(NewRegion) then begin
        cboRegion.Text:= NewRegion;
        ModalResult:= mrOk;
      end;
    end
    else begin
      ModalResult:= mrOk;
    end;
  end
  else begin
    CommonLib.MessageDlgXP_Vista('Please select a region',mtInformation,[mbOk],0);
  end;
end;

procedure TfmRegionalOptionSelect.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult:= mrCancel;
end;

end.
