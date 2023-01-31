unit ClientEquipmentListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TClientEquipmentlist = class(TBaseListingGUI)
    qryMainEquipName: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainUOMQty: TFloatField;
    qryMainManufacture: TWideStringField;
    qryMainmodel: TWideStringField;
    qryMainSerialno: TWideStringField;
    qryMainRegistration: TWideStringField;
    qryMainWarantyPeriod: TFloatField;
    qryMainWarantyFinishDate: TDateTimeField;
    qryMainDescription: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainClientID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainEquipmentID: TIntegerField;
    qryMainCost: TFloatField;
    qryMainPrice: TFloatField;
    qryMainServiceDueDate: TDateTimeField;
    qryMainWarantyStartDate: TDateTimeField;
    qryMainactive: TWideStringField;
    qryMainService: TWideStringField;
    qryMainCurrent: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
  private
    { Private declarations }
  Protected
    Procedure SetGridColumns;override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, frmCustomerFrm, FastFuncs;

{$R *.dfm}


procedure TClientEquipmentlist.FormShow(Sender: TObject);
begin
  inherited;
  if grpfilters.itemindex <0 then grpfilters.itemindex  := 0;
end;

procedure TClientEquipmentlist.grdMainDblClick(Sender: TObject);
begin
  inherited;
  if assigned(frmPopup) then
    if frmPopup is TfrmCustomer then begin
      TfrmCustomer(frmPopup).TabCtl20.ActivePage:= TfrmCustomer(frmPopup).tabEquip;
      TfrmCustomer(frmPopup).TabCtl20Change(TfrmCustomer(frmPopup).TabCtl20);
    end;

end;

procedure TClientEquipmentlist.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TClientEquipmentlist.FormCreate(Sender: TObject);
begin
  Qrymain.SQL.text := StringReplace(Qrymain.SQL.text , '`tblclients`.`Company`' ,SplitField('tblclients' , 'Company' , 1) +' as Company',  [rfIgnoreCase]);
  inherited;

end;

procedure TClientEquipmentlist.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ClientID');
  RemoveFieldfromGrid('EquipmentID');
  GuiPrefs.DbGridElement[grdmain].FieldGroupname['WarantyPeriod'] := 'Waranty';
  GuiPrefs.DbGridElement[grdmain].FieldGroupname['WarantyStartDate'] := 'Waranty';
  GuiPrefs.DbGridElement[grdmain].FieldGroupname['WarantyFinishDate'] := 'Waranty';
end;

initialization
  RegisterClassOnce(TClientEquipmentlist);

end.
