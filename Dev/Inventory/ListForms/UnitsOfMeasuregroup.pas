unit UnitsOfMeasuregroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnitsOfMeasureBaseList, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, DNMAction, ActnList,
  PrintDAT, ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, StdCtrls, wwdblook, Shader, AdvOfficeStatusBar,
  DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup;

type
  TUnitsOfMeasuregroupGUI = class(TUnitsOfMeasureBaseListGUI)
    qryMainUnitName: TWideStringField;
    qryMainMultiplier: TFloatField;
    qryMainBaseUnitName: TWideStringField;
    qryMainUnitDescription: TWideStringField;
    qryMainBaseUnitID: TIntegerField;
    qryMainUnitID: TIntegerField;
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fiProductId: Integer;
    { Private declarations }
  public
    Property ProductId :Integer read fiProductId write fiProductID;
    Procedure RefreshQuery;override;
  end;


implementation

uses CommonLib, UnitsOfMeasureForm, BaseListingForm;

{$R *.dfm}
procedure TUnitsOfMeasuregroupGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TUnitsOfMeasureGUI');
  if Assigned(Form) then begin //if has acess
    with TUnitsOfMeasureGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;  
end;

procedure TUnitsOfMeasuregroupGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('UnitID');
end;

procedure TUnitsOfMeasuregroupGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiProductID:= 0;
end;

procedure TUnitsOfMeasuregroupGUI.RefreshQuery;
begin
  closeDB(Qrymain);
  Qrymain.parambyname('xPartID').asInteger := fiProductId;
  inherited;
end;

initialization
  RegisterClassOnce(TUnitsOfMeasuregroupGUI);

end.
