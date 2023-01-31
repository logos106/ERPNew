unit RepairList_Parts;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/11/05  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,
  wwdblook, wwcheckbox, wwDialog, Wwlocate,
  SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker,
  ProgressDialog, Math,  Shader, kbmMemTable, BaseRepairsList ,
  AdvOfficeStatusBar, DAScript, MyScript, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TRepairListParts = class(TBaseRepairsListGUI)
    qryPOLines            : TERPQuery;
    qryRepairJobs         : TERPQuery;
    qryMainPartName       : TWideStringField;
    qryMainUOMQty         : TFloatField;
    qryMainUnitofMeasure  : TWideStringField;
    qryMainPartIssuedOn   : TDateTimeField;
    qryMainEquipment      : TWideStringField;
    qryMainPartIssuedFrom : TWideStringField;
    qryMainProductDescription: TWideStringField;
  end;

implementation

uses CommonLib;

{$R *.dfm}
initialization
  RegisterClassOnce(TRepairListParts);

end.
