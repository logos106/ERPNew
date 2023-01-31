unit EmployeeReportsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseTemplateForm, DB,  Grids, Wwdbigrd,
  Wwdbgrid, StdCtrls, Buttons, DNMSpeedButton, Mask, DBCtrls, ExtCtrls, DNMPanel, AppEvnts,
  wwdbedit, Wwdotdot, Wwdbcomb, wwdblook, SelectionDialog, ImgList, MemDS,
  DBAccess, MyAccess,ERPdbComponents, DataState, Menus, AdvMenus, Shader, ProgressDialog,
  wwcheckbox;

type
  TEmployeeReportsGUI = class(TBaseTemplateGUI)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  DNMExceptions, CommonLib;


procedure TEmployeeReportsGUI.FormShow(Sender: TObject);
begin
  try
    inherited;
  except
    on E: ENoAccess do begin
      CommonLib.MessageDlgXP_Vista(E.Message, mtInformation, [mbOK], 0);
      PostMessage(Self.Handle, WM_Close, 0, 0);
      Exit;
    end;
  end;
end;

Initialization
  RegisterClassOnce(TEmployeeReportsGUI);

end.
