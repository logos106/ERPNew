unit StockAdjustImportLatest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TStockAdjustImportLatestGUI = class(TBaseListingGUI)
    qryMainAdjID: TIntegerField;
    qryMainDepartmentID: TIntegerField;
    qryMainUOMID: TIntegerField;
    qryMainUOM: TWideStringField;
    qryMainUOMMultiplier: TFloatField;
    qryMainPartsId: TIntegerField;
    qryMaingLevel: TLargeintField;
    qryMainProductName: TWideStringField;
    qryMainProductColumn1: TWideStringField;
    qryMainProductColumn2: TWideStringField;
    qryMainProductColumn3: TWideStringField;
    qryMainPartsDescription: TWideStringField;
    qryMainDeptName: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainAccountGroup: TWideStringField;
    qryMainBatchnumber: TWideStringField;
    qryMainExpiryDate: TWideStringField;
    qryMainBatchExpiryDate: TDateTimeField;
    qryMainBinlocation: TWideStringField;
    qryMainBinnumber: TWideStringField;
    qryMainSerialnumber: TWideStringField;
    qryMainUOMQty: TFloatField;
    qryMainFinalcount: TFloatField;
    qryMainAllocFinalcount: TFloatField;
    qryMainQty: TFloatField;
    qryMainInstockUOMQty: TFloatField;
    qryMainInstockQty: TFloatField;
    qryMainCost: TFloatField;
    qryMainValue: TFloatField;
    qryMainActive: TWideStringField;
    qryMainSeqno: TIntegerField;
    qryMainProductBarCode: TWideStringField;
    qryMainBatch: TWideStringField;
    qryMainBins: TWideStringField;
    qryMainSN: TWideStringField;
  private
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib;



{$R *.dfm}

{ TStockAdjustImportLatestGUI }

procedure TStockAdjustImportLatestGUI.RefreshQuery;
begin

  inherited;

end;

procedure TStockAdjustImportLatestGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainAdjID.fieldname);
  RemoveFieldfromGrid(qryMainDepartmentID.fieldname);
  RemoveFieldfromGrid(qryMainUOMID.fieldname);
  RemoveFieldfromGrid(qryMainPartsId.fieldname);
  RemoveFieldfromGrid(qryMaingLevel.fieldname);
  RemoveFieldfromGrid(qryMainExpiryDate.fieldname);
  RemoveFieldfromGrid(qryMainUOMQty.fieldname);
  RemoveFieldfromGrid(qryMainQty.fieldname);
  RemoveFieldfromGrid(qryMainSeqno.fieldname);
  RemoveFieldfromGrid(qryMainProductBarCode.fieldname);
end;

initialization
  RegisterClassOnce(TStockAdjustImportLatestGUI);
end.

