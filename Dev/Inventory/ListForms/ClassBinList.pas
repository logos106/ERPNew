unit ClassBinList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BinLocationList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TClassBinListGUI = class(TBinLocationListGUI)
  private
  Protected
    procedure MakeQrymain; Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TClassBinListGUI }

procedure TClassBinListGUI.MakeQrymain;
begin
  Qrymain.Disablecontrols;
  Try
    if Qrymain.Active then qrymain.close;
    QryMain.SQL.Clear;
    QryMain.SQL.Add('Select distinct ');
    QryMain.SQL.Add('tblProductbin.GlobalRef, ');
    QryMain.SQL.Add('tblProductbin.BinID, ');
    QryMain.SQL.Add('tblclass.ClassID,');
    QryMain.SQL.Add('tblProductbin.binLocation,');
    QryMain.SQL.Add('tblProductbin.binnumber, ');
    QryMain.SQL.Add('tblProductbin.Active, ');
    QryMain.SQL.Add('tblProductbin.Volume ,');
    QryMain.SQL.Add('Volume_used as BinVolume,');
    QryMain.SQL.Add('tblclass.ClassName');
    QryMain.SQL.Add('from tblclass');
    QryMain.SQL.Add('Left join tblProductbin on tblclass.ClassId = tblProductbin.ClassId');
          if grpFilters.ItemIndex = 0 then QryMain.SQL.Add('AND tblclass.active ="T" and (ifnull(tblProductbin.binID,0)=0 or  tblProductbin.Active = "T")')
    else  if grpFilters.ItemIndex = 1 then QryMain.SQL.Add('AND tblclass.active ="F" and (ifnull(tblProductbin.binID,0)=0 or  tblProductbin.Active = "F")');
    if selectedClassId<>0 then QryMain.SQL.Add('AND tblclass.ClassID = ' + IntToStr(selectedClassId));
  Finally
      Qrymain.EnableControls;
  end;

end;

initialization
  RegisterClassOnce(TClassBinListGUI);

end.
