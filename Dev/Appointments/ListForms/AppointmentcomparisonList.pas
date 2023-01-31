unit AppointmentcomparisonList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript;

type
  TAppointmentcomparisonGUI = class(TBaseListingGUI)

  private
    { Private declarations }
  public
    { Public declarations }
  Protected
    procedure RefreshQuery; override;
  end;

var
  AppointmentcomparisonGUI: TAppointmentcomparisonGUI;

implementation

uses CommonLib;

{$R *.dfm}
procedure TAppointmentcomparisonGUI.RefreshQuery;
begin
    QryMain.Parambyname('DateFrom').asDateTime := dtFrom.Date;
    QryMain.Parambyname('DateTo').asDateTime := dtTo.Date;
    Inherited;
end;

initialization
  RegisterClassOnce(TAppointmentcomparisonGUI);
end.
