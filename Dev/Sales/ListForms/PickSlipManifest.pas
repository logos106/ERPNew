unit PickSlipManifest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PickSlipList, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, DNMSpeedButton, Shader, DNMPanel, wwdblook;

type
  TPickSlipManifestGUI = class(TPickSlipGUI)
    qryMaincustomerArea: TWideStringField;
    qryMainSaleArea: TWideStringField;
    qryMainShipTo: TWideStringField;
    qryMainShipCity: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainProductArea: TFloatField;
    qryMainProductWeight: TFloatField;
    qryMaintotalProductArea: TFloatField;
    qryMaintotalProductWeight: TFloatField;
    qryMainAddToManifest: TWideStringField;
    qryMainManifestID: TIntegerField;
    btnExpressDetail: TDNMSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnExpressDetailClick(Sender: TObject);
  private
  Protected
    Procedure SetGridColumns;override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}

{ TPickSlipManifestGUI }

procedure TPickSlipManifestGUI.btnExpressDetailClick(Sender: TObject);
begin
  inherited;
  OpenERpListForm('TPickSlipGUI', copyParamsto);
  Self.Close;
end;

procedure TPickSlipManifestGUI.FormShow(Sender: TObject);
begin
  inherited;
  if grpAssemblyfilter.ItemIndex <> 1 then grpAssemblyfilter.ItemIndex := 1;
  timerMsg(FilterLabel, 'This list shows all the sales that is being already picked(Printed a Picking slip)'  );
end;

procedure TPickSlipManifestGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Product');
end;

initialization
  RegisterClassOnce(TPickSlipManifestGUI);

end.

