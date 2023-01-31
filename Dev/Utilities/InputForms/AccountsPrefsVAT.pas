unit AccountsPrefsVAT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataSourcePrefs, StdCtrls, Mask, wwdbedit, wwcheckbox, ExtCtrls,
  DNMPanel;

type
  TAccountsPrefsVATGUI = class(TForm)
    pnlVAT: TDNMPanel;
    Bevel5: TBevel;
    lblPanelCaption_VAT: TLabel;
    Label19: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Bevel6: TBevel;
    Label29: TLabel;
    Bevel7: TBevel;
    Label30: TLabel;
    Bevel8: TBevel;
    wwCheckBox8: TwwCheckBox;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit8: TwwDBEdit;
    wwDBEdit9: TwwDBEdit;
    wwDBEdit10: TwwDBEdit;
    wwDBEdit11: TwwDBEdit;
    wwCheckBox6: TwwCheckBox;
  private
    { Private declarations }
  public
    procedure Load(DsPrefs: TDataSourcePrefs);
  end;

var
  AccountsPrefsVATGUI: TAccountsPrefsVATGUI;

implementation

{$R *.dfm}

{ TAccountsPrefsVATGUI }

procedure TAccountsPrefsVATGUI.Load(DsPrefs: TDataSourcePrefs);
var
  I: integer;
begin
  for I := 0 to ComponentCount -1 do begin
    if Components[I] is TwwDBEdit then
      TwwDBEdit(Components[I]).DataSource := DsPrefs
    else if Components[I] is TwwCheckBox then
      TwwCheckBox(Components[I]).DataSource := DsPrefs;
  end;
end;

end.
