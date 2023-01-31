unit SalesPrefsStateFreight;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdblook, wwcheckbox, ExtCtrls, DNMPanel, DataSourcePrefs,
  DB, MemDS, DBAccess, MyAccess, ERPdbComponents, DNMSpeedButton;

type
  TSalesPrefsStateFreightGUI = class(TForm)
    pnlStateFreight: TDNMPanel;
    Bevel8: TBevel;
    Label7: TLabel;
    chkStateFreightEnabled: TwwCheckBox;
    Label3: TLabel;
    cboFreightProduct: TwwDBLookupCombo;
    qryProductLookup: TERPQuery;
    Label1: TLabel;
    MyConnection: TERPConnection;
    btnShowStateFreightList: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnShowStateFreightListClick(Sender: TObject);
  private
    fDataSourcePrefs: TDataSourcePrefs;
    procedure SetDataSourcePrefs(const Value: TDataSourcePrefs);
  public
    property DataSourcePrefs: TDataSourcePrefs read fDataSourcePrefs write SetDataSourcePrefs;
  end;

var
  SalesPrefsStateFreightGUI: TSalesPrefsStateFreightGUI;

implementation

uses
  CommonDbLib, CommonFormLib, frmStateFreightList;

{$R *.dfm}

{ TSalesPrefsStateFreightGUI }

procedure TSalesPrefsStateFreightGUI.btnShowStateFreightListClick(
  Sender: TObject);
begin
  OpenERPListForm(TfmStateFreightList.ClassName);
end;

procedure TSalesPrefsStateFreightGUI.FormCreate(Sender: TObject);
begin
  qryProductLookup.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryProductLookup.Open;
end;

procedure TSalesPrefsStateFreightGUI.SetDataSourcePrefs(
  const Value: TDataSourcePrefs);
begin
  fDataSourcePrefs := Value;
  fDataSourcePrefs.FieldNames.Add('StateFreightChargeEnabled');
  fDataSourcePrefs.FieldNames.Add('FreightChargeProduct');

  chkStateFreightEnabled.DataSource := fDataSourcePrefs;
  chkStateFreightEnabled.DataField := 'StateFreightChargeEnabled';

  cboFreightProduct.DataSource := fDataSourcePrefs;
  cboFreightProduct.DataField := 'FreightChargeProduct';
end;

end.
