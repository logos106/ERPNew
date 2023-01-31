unit RegionLocationcountries;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RegionLocations, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TRegionLocationcountriesGUI = class(TRegionLocationsGUI)
    qryMainCountry: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;


{$R *.dfm}
initialization
  RegisterClassOnce(TRegionLocationcountriesGUI);

end.

