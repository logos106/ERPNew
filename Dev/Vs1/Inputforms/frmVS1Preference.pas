unit frmVS1Preference;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, wwdblook, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, wwcheckbox, DNMPanel;

type
  TfmVS1Preference = class(TForm)
    pnlVS1config: TDNMPanel;
    lblTitle: TLabel;
    Bevel1: TBevel;
    chkUseRegioncurrency: TwwCheckBox;
    qryForeignCurrency: TERPQuery;
    lblBaseForeignCurrencyCode: TLabel;
    cboBaseForeignCurrencyCode: TwwDBLookupCombo;
    MyConnection: TERPConnection;
    procedure chkUseRegioncurrencyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboBaseForeignCurrencyCodeChange(Sender: TObject);
  private
  public
    procedure Load;
    Procedure Save;
  end;

implementation

uses AppEnvironment, CommonDbLib;

{$R *.dfm}

procedure TfmVS1Preference.cboBaseForeignCurrencyCodeChange(Sender: TObject);
begin
  AppEnv.CompanyPrefs.VS1Config.DefaultCurrency   := cboBaseForeignCurrencyCode.Text        ;
  AppEnv.CompanyPrefs.VS1Config.UseRegioncurrency := trim(AppEnv.CompanyPrefs.VS1Config.DefaultCurrency)= '';
  chkUseRegioncurrency.checked        := AppEnv.CompanyPrefs.VS1Config.UseRegioncurrency;
end;

procedure TfmVS1Preference.chkUseRegioncurrencyClick(Sender: TObject);
begin
    if not chkUseRegioncurrency.Focused  then exit;
    AppEnv.CompanyPrefs.VS1Config.UseRegioncurrency   := chkUseRegioncurrency.Checked  ;
    if AppEnv.CompanyPrefs.VS1Config.UseRegioncurrency then begin
        cboBaseForeignCurrencyCode.Text := '';
        AppEnv.CompanyPrefs.VS1Config.DefaultCurrency   := '';
    end;
end;

procedure TfmVS1Preference.FormCreate(Sender: TObject);
begin
  closedb(qryForeignCurrency);
  qryForeignCurrency.Connection  :=GetSharedMyDacConnection;
  Opendb(qryForeignCurrency);
end;

procedure TfmVS1Preference.Load;
begin
  chkUseRegioncurrency.checked        := AppEnv.CompanyPrefs.VS1Config.UseRegioncurrency;
  cboBaseForeignCurrencyCode.Text     := AppEnv.CompanyPrefs.VS1Config.DefaultCurrency  ;
end;

procedure TfmVS1Preference.Save;
begin
  AppEnv.CompanyPrefs.VS1Config.Save(CommonDbLib.GetSharedMyDacConnection);
end;

end.
