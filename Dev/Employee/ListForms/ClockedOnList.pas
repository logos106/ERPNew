unit ClockedOnList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel , RosterListBase, DBCtrls, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TClockedOnListGUI = class(TRosterListBaseGUI)
    procedure FormCreate(Sender: TObject);
  private
  Protected
    function HideIfClockedOff :Boolean; Override;
  public
  end;


implementation

uses CommonLib, CommonDbLib;

{$R *.dfm}
procedure TClockedOnListGUI.FormCreate(Sender: TObject);
begin
  Tablename := commondblib.GetUserTemporaryTableName('ClockOn');
  Qrymain.SQL.clear;
  Qrymain.SQL.add('SELECT ');
  Qrymain.SQL.add('T.*,  ');
  Qrymain.SQL.add('E.EmployeeName  ');
  Qrymain.SQL.add('FROM ' + Tablename + ' T  ');
  Qrymain.SQL.add('INNER JOIN tblemployees E ON T.EmployeeId = E.EmployeeId  ');
  Qrymain.SQL.add('WHERE IFNULL(T.RosterEndtime, "1899-12-30 00:00:00")="1899-12-30 00:00:00" AND IFNULL(T.Endtime, "1899-12-30 00:00:00")="1899-12-30 00:00:00"  ');
  Qrymain.SQL.add('ORDER BY T.RosterId DESC, T.StartTime, T.RosterStarttime ') ;
  inherited;
end;

function TClockedOnListGUI.HideIfClockedOff: Boolean;
begin
  Result := true;
end;

initialization
  RegisterClassOnce(TClockedOnListGUI);

end.
