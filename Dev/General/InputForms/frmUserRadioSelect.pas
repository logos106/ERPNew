unit frmUserRadioSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader, DNMPanel;

type
  TfmUserRadioSelect = class(TBaseForm)
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    rgSeklect: TRadioGroup;
    DNMPanel1: TDNMPanel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DoSelect(const OptionCommaList, Caption, GroupLabel: string; var Selected: string): boolean;

implementation

{$R *.dfm}

function DoSelect(const OptionCommaList, Caption, GroupLabel: string; var Selected: string): boolean;
var
  form: TfmUserRadioSelect;
//  sl: TStringList;
begin
  result := false;
  form := TfmUserRadioSelect.Create(nil);
  try
//    sl := TStringList.Create;
//    sl.CommaText := OptionCommaList;
    form.rgSeklect.Items.CommaText := OptionCommaList;
    form.rgSeklect.Columns := form.rgSeklect.Items.Count;
    form.rgSeklect.ItemIndex := 0;
//    sl.Free;
    form.rgSeklect.Caption := Caption;
    form.TitleLabel.Caption := GroupLabel;
    form.Caption := Caption;
    if form.ShowModal = mrOk then begin
      result := true;
      Selected := form.rgSeklect.Items[form.rgSeklect.ItemIndex];
    end;
  finally
    form.Release;
  end;

end;



end.
