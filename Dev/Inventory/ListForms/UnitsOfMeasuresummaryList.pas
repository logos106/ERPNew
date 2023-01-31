unit UnitsOfMeasuresummaryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel, GIFImg;

type
  TUnitsOfMeasuresummaryListGUI = class(TBaseListingGUI)
    qryMainUnitName: TWideStringField;
    qryMainMultiplier: TFloatField;
    qryMainUnitDescription: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonFormLib, CommonLib;

{$R *.dfm}
procedure TUnitsOfMeasuresummaryListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
    OpenERPForm('TUnitsOfMeasureGUI', 0);
end;

initialization
  RegisterClassOnce(TUnitsOfMeasuresummaryListGUI);

end.
