unit frmStSClass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmClassFrm, DB, kbmMemTable, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, DNMSpeedButton, ERPDbLookupCombo, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, StdCtrls, DBCtrls, ComCtrls, wwdbedit, wwdblook,
  Mask, Shader, DNMPanel;

type
  TfmStSClass = class(TfrmClass)
    procedure FormShow(Sender: TObject);
  private
  Protected
  public
  end;

implementation

uses CommonLib;

{$R *.dfm}


procedure TfmStSClass.FormShow(Sender: TObject);
begin
  inherited;
  TabStS.TabVisible := true;
  pgmain.activePageindex := 1;
  Setcontrolfocus(cboPrincipleContact);
end;

initialization
  RegisterClassOnce(TfmStSClass);

end.
