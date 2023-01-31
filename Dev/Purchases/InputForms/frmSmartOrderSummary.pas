unit frmSmartOrderSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, Buttons, Wwdbigrd, Grids, Wwdbgrid, DNMSpeedButton, Shader,
  DNMPanel;

type
  TfmSmartOrderSummary = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlFooter: TDNMPanel;
    DNMPanel1: TDNMPanel;
    DNMSpeedButton1: TDNMSpeedButton;
    grdLines: TwwDBGrid;
    tblMaster: TERPQuery;
    DSMaster: TDataSource;
    tblMasterSupplierName: TWideStringField;
    tblMasterex: TFloatField;
    tblMasterInc: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    fiSmartOrderId: Integer;
    fMyConnection: TERPConnection;
  public
    Property SmartOrderId :Integer read fiSmartOrderId write fiSmartOrderId;
    Property MyConnection: TERPConnection read fMyConnection write fMyConnection;
  end;


implementation

uses frmSmartOrderFrm, CommonLib;

{$R *.dfm}

procedure TfmSmartOrderSummary.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_ESCAPE then modalresult:= mrCancel;
end;

procedure TfmSmartOrderSummary.FormShow(Sender: TObject);
begin
  inherited;
  if tblMaster.Active then tblMaster.Close;
  tblMaster.connection := MyConnection;
  tblMaster.parambyname('SmartOrderID').asInteger := SmartOrderID;
  tblMaster.open;
  SetControlfocus(grdLines);
end;

initialization
  RegisterClassOnce(TfmSmartOrderSummary);

end.

