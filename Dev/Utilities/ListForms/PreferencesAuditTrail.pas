unit PreferencesAuditTrail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AuditTrailList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel ;

type
  TPreferencesAuditTrailGUI = class(TAuditTrailListGUI)
  private
  Protected
  public
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TPreferencesAuditTrailGUI }

initialization
  RegisterClassOnce(TPreferencesAuditTrailGUI);

end.
