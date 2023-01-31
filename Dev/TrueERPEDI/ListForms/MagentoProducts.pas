unit MagentoProducts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MagentoListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel ;

type
  TMagentoProductsGUI = class(TMagentoListBaseGUI)
    qryMainSynchState: TWideStringField;
    qryMainPARTSID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainPURCHASEDESC: TWideStringField;
    qryMainPriceInc: TFloatField;
    qryMainDiscontinued: TWideStringField;
    qryMainPartType: TWideStringField;
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
    qryMainCUSTDATE1: TDateTimeField;
    qryMainCUSTDATE2: TDateTimeField;
    qryMainCUSTDATE3: TDateTimeField;
    qryMainBARCODE: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainProductionNotes: TWideMemoField;
    qryMainGeneralNotes: TWideMemoField;
    qryMainIsSystemProduct: TWideStringField;
    qryMainBatch: TWideStringField;
    qryMainMultiplebins: TWideStringField;
    qryMainSNtracking: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainPreferedSupp: TWideStringField;
    procedure btnSynchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  Protected
    procedure SynchTransactions;Override;
    Procedure SetGridColumns;Override;
    Function EnableEDIAutocheckProgress:Boolean; virtual;
  public
    procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, BusobjExternalXRef, ErpSynchMagento;

{$R *.dfm}
{ TMagentoProductsGUI }

procedure TMagentoProductsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainPartsId.fieldname);
end;

procedure TMagentoProductsGUI.SynchTransactions;
begin
  inherited;
  LogInList('Synch Products From Magento...' );
  TErpSynchMagento(SynchObj).SynchProducts;
end;

procedure TMagentoProductsGUI.btnSynchClick(Sender: TObject);
begin
  inherited;
  DoEDICheckEvent;
end;

function TMagentoProductsGUI.EnableEDIAutocheckProgress: Boolean;
begin
  Result := True;
end;

procedure TMagentoProductsGUI.FormShow(Sender: TObject);
begin
  inherited;
  HasEDIAutocheckProgress := EnableEDIAutocheckProgress;
  HaveDateRangeSelection := False;
end;

procedure TMagentoProductsGUI.RefreshQuery;
begin
  Qrymain.parambyname('Externaltype').asString:= SynchObj.CoreService.ServiceName;
  Qrymain.parambyname('ObjectType').asString:= ExRef_Objtype_Product;
  inherited;
end;


initialization
  RegisterClass(TMagentoProductsGUI);

end.
