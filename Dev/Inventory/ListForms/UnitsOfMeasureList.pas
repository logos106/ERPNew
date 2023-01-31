unit UnitsOfMeasureList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  UnitsOfMeasureBaseList, DNMAction, BusobjProductProperties, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup;

type
  TUnitsOfMeasuresList = class(TUnitsOfMeasureBaseListGUI)
    qryGroup: TERPQuery;
    dsGroup: TDataSource;
    qryGroupUnitName: TWideStringField;
    qryGroupMultiplier: TFloatField;
    qryGroupUnitDescription: TWideStringField;
    qryMainUnitID: TIntegerField;
    qryMainProduct: TWideStringField;
    qryMainSalesDefault: TWideStringField;
    qryMainPurchasesDefault: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainUnitName: TWideStringField;
    qryMainMultiplier: TFloatField;
    qryMainBaseUnitID: TIntegerField;
    btnShowRelatedCustomersList: TDNMSpeedButton;
    lblProductCaption: TLabel;
    Panel4: TPanel;
    Label4: TLabel;
    grdgroup: TwwDBGrid;
    wwIButton2: TwwIButton;
    Panel5: TPanel;
    btnSalesDefault: TDNMSpeedButton;
    btnPODefault: TDNMSpeedButton;
    Label5: TLabel;
    qryMainWeight: TFloatField;
    qryMainheight: TFloatField;
    qryMainwidth: TFloatField;
    qryMainvolume: TFloatField;
    qryMainLength: TFloatField;
    qryMainBaseUnitName: TWideStringField;
    procedure btnShowRelatedCustomersListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdgroupRowChanged(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure btnSalesDefaultClick(Sender: TObject);
    procedure btnPODefaultClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private

    Ids:String;
    Procedure SetUOMasDEfault(UOMDefaulttype:TUOMDefaulttype);
    procedure initNewuom(Sender: TObject);
    
  Protected
    Procedure IterateselectedRecordsCallback(Var abort:Boolean;SelIndex:Integer);Override;
    Procedure SetGridColumns;Override;

  public
    procedure RefreshQuery; Override;
  end;


implementation

uses FastFuncs, UnitsOfMeasureForm, CommonFormLib,commonLib , BusobjUOM;

{$R *.dfm}
procedure TUnitsOfMeasuresList.btnShowRelatedCustomersListClick(
  Sender: TObject);
begin
  inherited;
  OpenERPListForm('TUnitsOfMeasureListGUI');
  Self.Close;
end;

procedure TUnitsOfMeasuresList.FormShow(Sender: TObject);
begin
  inherited;
  OpenDB(qryGroup);
end;

procedure TUnitsOfMeasuresList.FormCreate(Sender: TObject);
begin
  inherited;
  qryGroup.connection  := Qrymain.connection;
  grdgroup.Footercolor := grdMain.footercolor;
  grdgroup.titlecolor  := grdmain.titlecolor;

end;

procedure TUnitsOfMeasuresList.RefreshQuery;
var
  bm:TBookmark;
begin
  inherited;
  try
    bm :=Qrygroup.GetBookmark;
    try
      closeDB(Qrygroup);
      OpenDB(Qrygroup);
    finally
      Qrygroup.GotoBookmark(bm);
      Qrygroup.FreeBookmark(bm);
    end;
  except
      // kill the exception 
  end;
end;

procedure TUnitsOfMeasuresList.grdgroupRowChanged(Sender: TObject);
begin
  inherited;
  lblProductCaption.caption := 'Products Linked to ' +qryGroupUnitName.asString;
end;

procedure TUnitsOfMeasuresList.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if QrymainActive.asBoolean = False then
    AFont.color:= clInactiveCaption;
end;

procedure TUnitsOfMeasuresList.btnSalesDefaultClick(Sender: TObject);
begin
  inherited;
  SetUOMasDefault(tUOMSalesDefault);
  RefreshQuery;
end;

procedure TUnitsOfMeasuresList.btnPODefaultClick(Sender: TObject);
begin
  inherited;
  SetUOMasDefault(tUOMPODefault);
  RefreshQuery;
end;

procedure TUnitsOfMeasuresList.SetUOMasDefault(UOMDefaulttype:TUOMDefaulttype);
begin
  Ids := '';
  IterateRecords(True , 'Set Default UOM');
  if ids='' then exit;
  TUnitOfMeasure.SetUOMasDefault(Ids, UOMDefaulttype);
end;

procedure TUnitsOfMeasuresList.IterateselectedRecordsCallback(var abort: Boolean;SelIndex:Integer);
begin
  inherited;
  if qryMainProduct.asString ='' then exit;
  if ids <> '' then ids:= ids+',';
  Ids := Ids + IntToStr(qryMainUnitID.asInteger)
end;

procedure TUnitsOfMeasuresList.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('UnitName');
  RemoveFieldfromGrid('Multiplier');
  RemoveFieldfromGrid('BaseUnitID');
end;
procedure TUnitsOfMeasuresList.initNewuom(Sender: TObject);
begin
  if sender is TUnitsOfMeasureGUI then
    with TUnitsOfMeasureGUI(Sender) do begin
      qryUnitsOfMeasureUnitName.asString        := qryGroupUnitName.asString;
      qryUnitsOfMeasureUnitDescription.asString := qryGroupUnitDescription.asString;
      qryUnitsOfMeasureMultiplier.AsFloat       := qryGroupMultiplier.AsFloat;
      qryUnitsOfMeasureBaseUnitID.asInteger     := qrymainBaseUnitId.asInteger;
      qryUnitsOfMeasureBaseUnitName.asString    := qrymainBaseUnitName.asString;
      SetControlFocus(cboParts);
    end;
end;
procedure TUnitsOfMeasuresList.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TUnitsOfMeasureGUI', 0 , initNewuom);

(*  Form := GetComponentByClassName('TUnitsOfMeasureGUI');
  if Assigned(Form) then begin //if has acess
    with TUnitsOfMeasureGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      qryUnitsOfMeasureUnitName.asString        := qryGroupUnitName.asString;
      qryUnitsOfMeasureUnitDescription.asString := qryGroupUnitDescription.asString;
      qryUnitsOfMeasureMultiplier.AsFloat       := qryGroupMultiplier.AsFloat;
      qryUnitsOfMeasureBaseUnitID.asInteger     := qrymainBaseUnitId.asInteger;
      qryUnitsOfMeasureBaseUnitName.asString    := qrymainBaseUnitName.asString;
      SetControlFocus(cboParts);
      BringToFront;
    end;
  end;*)
end;




initialization
  RegisterClassOnce(TUnitsOfMeasuresList);

end.
