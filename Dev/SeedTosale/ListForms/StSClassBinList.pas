unit StSClassBinList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ClassBinList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TStSClassBinListGUI = class(TClassBinListGUI)
    qryMainStsClassId: TIntegerField;
    qryMainLicenseNumber: TWideStringField;
    qryMainPrincipleContact: TWideStringField;
    qryMainPrincipleContactPhone: TWideStringField;
  private
  Protected
    procedure MakeQrymain; Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TClassBinListGUI2 }

procedure TStSClassBinListGUI.MakeQrymain;
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
    QryMain.SQL.Add('tblclass.ClassName,');
    QryMain.SQL.Add('StS.Id as StsClassId,');
    QryMain.SQL.Add('StS.LicenseNumber as LicenseNumber,');
    QryMain.SQL.Add('StS.PrincipleContact as PrincipleContact,');
    QryMain.SQL.Add('StS.PrincipleContactPhone as PrincipleContactPhone');

    QryMain.SQL.Add('from tblclass');
    QryMain.SQL.Add('inner join tblStSClass StS on StS.classId = tblclass.classId');
    QryMain.SQL.Add('Left join tblProductbin on tblclass.ClassId = tblProductbin.ClassId');
          if grpFilters.ItemIndex = 0 then QryMain.SQL.Add('AND tblclass.active ="T" and (ifnull(tblProductbin.binID,0)=0 or  tblProductbin.Active = "T")')
    else  if grpFilters.ItemIndex = 1 then QryMain.SQL.Add('AND tblclass.active ="F" and (ifnull(tblProductbin.binID,0)=0 or  tblProductbin.Active = "F")');
    if selectedClassId<>0 then QryMain.SQL.Add('AND tblclass.ClassID = ' + IntToStr(selectedClassId));
  Finally
      Qrymain.EnableControls;
  end;

end;

initialization
  RegisterClassOnce(TStSClassBinListGUI);

end.
