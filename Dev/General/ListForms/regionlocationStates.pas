unit regionlocationStates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RegionLocations, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TregionlocationStatesGUI = class(TRegionLocationsGUI)
    qryMainState: TWideStringField;
    qryMainCountry: TWideStringField;
  private
  public
  end;


implementation

uses AppEnvironment, CommonLib;

{$R *.dfm}

initialization
  RegisterClassOnce(TregionlocationStatesGUI);

end.

