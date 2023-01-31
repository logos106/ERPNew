unit RepairsList_Equipment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, wwdblook, wwcheckbox,
   Shader, kbmMemTable, AdvOfficeStatusBar,  BaseRepairsList,
  DAScript, MyScript;

type
  TRepairListEquipment = class(TBaseRepairsListGUI)
    qryMainEquipName        : TWideStringField;
    qryMainManufacture      : TWideStringField;
    qryMainmodel            : TWideStringField;
    qryMainSerialno         : TWideStringField;
    qryMainRegistration     : TWideStringField;
    qryMainWarantyPeriod    : TFloatField;
    qryMainWarantyFinishDate: TDateTimeField;
    qryMainUOM              : TWideStringField;
    qryMainUOMQty           : TFloatField;
    qryMainDescription      : TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryMainEquipmentID: TIntegerField;
    qryMainnextServiceDate: TDateTimeField;
    procedure DNMSpeedButton1Click(Sender: TObject);
  end;

implementation

uses CommonLib, ExportRepairsObj, FastFuncs;
{$R *.dfm}
procedure TRepairListEquipment.DNMSpeedButton1Click(Sender: TObject);
var
  ExportRepairsObj:TExportRepairsObj;
  Ids:String;
begin
  DisableForm;
  try
    inherited;
    Ids := SelectedIDs('RepairID' , true);
    ExportRepairsObj:=TExportRepairsObj.create(Self);
    try
      ExportRepairsObj.RepairIDs := Ids;
      ExportRepairsObj.Exportdata(''); ;
    finally
      Freeandnil(ExportRepairsObj);
    end;
  finally
    EnableForm;
  end;
  self.Close;
end;

initialization
  RegisterClassOnce(TRepairListEquipment);


end.
