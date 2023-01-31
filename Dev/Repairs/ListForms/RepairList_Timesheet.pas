unit RepairList_Timesheet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, wwdblook, wwcheckbox, 
  Shader, kbmMemTable, AdvOfficeStatusBar, BaseRepairsList, DAScript, MyScript,
  CustomInputBox ;

type
  TRepairListTimesheet = class(TBaseRepairsListGUI)
    qryMainServiceDate        : TDateField;
    qryMainServiceName        : TWideStringField;
    qryMainChargeRate         : TFloatField;
    qryMainQty                : TFloatField;
    qryMainTotalServicecharge : TFloatField;
    qryMainLabourCost         : TFloatField;
    qryMainHours              : TFloatField;
    qryMainTotal              : TFloatField;
    qryMainEquipment          : TWideStringField;
    qryMainEmployeeName       : TWideStringField;
    qryMainServicedept        : TWideStringField;
    procedure FormCreate(Sender: TObject);
  protected
    procedure RefreshTotals; override;
  end;

implementation

uses CommonLib;

{$R *.dfm}
procedure TRepairListTimesheet.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalccolumn( 'ChargeRate', true);
  AddCalccolumn( 'Qty', false);
  AddCalccolumn( 'TotalServicecharge', true);

end;

procedure TRepairListTimesheet.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

initialization
  RegisterClassOnce(TRepairListTimesheet);

end.
