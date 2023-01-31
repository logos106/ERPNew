unit EquipmentspareParts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TEquipmentsparePartsGUI = class(TBaseListingGUI)
    qryMainDetails: TLargeintField;
    qryMainEquipmentId: TIntegerField;
    qryMainEquipmentname: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainPARTTYPE: TWideStringField;
    qryMainPARTSDESCRIPTION: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure cmdNewClick(Sender: TObject);
  private
    fsEquipmentname: String;
    fiEquipmentID:Integer;
    fDoAddProducts: TNotifyEvent;
    procedure SetEquipmentname(const Value: String);
    procedure EquipmentafterShow(Sender: TObject);
  Protected
    Procedure IterateselectedRecordsCallback(Var abort:Boolean;SelIndex:Integer);Override;
    Procedure SetGridColumns;Override;
  public
    Property Equipmentname:String Read fsEquipmentname Write SetEquipmentname;
    Procedure AddProducts(DoAddProducts:TNotifyEvent);
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, tcDataUtils, FastFuncs, CommonFormLib, (*frmEquipmentFrm,*)
  frmEquip;

{$R *.dfm}
{ TEquipmentsparePartsGUI }

procedure TEquipmentsparePartsGUI.SetEquipmentname(const Value: String);
begin
  fsEquipmentname := Value;
  fiEquipmentID:= tcDataUtils.getEquipmentId(Value);
end;

procedure TEquipmentsparePartsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fsEquipmentname:= '';
  fiEquipmentID:= 0;
end;

procedure TEquipmentsparePartsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainProductName.asString = '' then
    AFont.Style := AFont.Style + [fsBold];
end;

procedure TEquipmentsparePartsGUI.RefreshQuery;
begin
  if  fiEquipmentID <> 0 then begin
    Closedb(qryMain);
    qryMain.Filter := 'EquipmentId =' +IntToStr(fiEquipmentID);
    qryMain.filtered := true;
  end;
  inherited;
end;

procedure TEquipmentsparePartsGUI.AddProducts(DoAddProducts: TNotifyEvent);
begin
  fDoAddProducts := DoAddProducts;
  IterateProcNo := 1;
  IterateselectedRecords(true , 'Please Wait');
end;

procedure TEquipmentsparePartsGUI.IterateselectedRecordsCallback(var abort: Boolean;SelIndex:Integer);
begin
  inherited;
  if assigned(fDoAddProducts) then fDoAddProducts(Qrymain);
end;

procedure TEquipmentsparePartsGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmEquip' , getEquipmentID(fsEquipmentname), EquipmentafterShow);
end;

procedure TEquipmentsparePartsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Details');
  RemoveFieldfromGrid('EquipmentID');
end;

procedure TEquipmentsparePartsGUI.EquipmentafterShow(Sender: TObject);
begin
   if not(Sender is TfmEquip) then exit;
   if TfmEquip(Sender).KeyId= QrymainEquipmentId.asInteger then begin
    SetControlfocus(TfmEquip(Sender).grdSpareParts);
    TfmEquip(Sender).QryEquipmentParts.Append;
   end;
end;

initialization
  RegisterClassOnce(TEquipmentsparePartsGUI);

end.
