unit ERPShortcuts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwcheckbox, DBCtrls, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TERPShortcutsGUI = class(TBaseListingGUI)
    qryMainDescription: TWideStringField;
    qryMainShortcut: TWideStringField;
    qryMainformname: TWideStringField;
    qryMainPassword: TWideStringField;
    qryMaincomments: TWideMemoField;
    memComments: TDBMemo;
	procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;


implementation

uses CommonLib, MemoDialog, AppEnvironment;

{$R *.dfm}
procedure TERPShortcutsGUI.FormCreate(Sender: TObject);
begin
  with Qrymain.sql do begin
    clear;
                         Add('Select ');  Add('Description as Description ,');                           Add('Shortcut as Shortcut,');Add('formname as formname,');Add('Password as Password,');Add('convert(comments , CHAR(1000)) as comments ');  Add('from tblerpshortcuts');
    Add('union all  ');  Add('Select ');  Add('"EMAIL CHECK INTERVAL"               as Description, ');  Add('null as shortCut, ');   Add('Null as Formname, ');   Add('null as Password, ');   Add('"OneMinute * 30" as Commnets ');Add('From Dual');
    Add('union all  ');  Add('Select ');  Add('"GOLIVE CHECK INTERVAL"              as Description, ');  Add('null as shortCut, ');   Add('Null as Formname, ');   Add('null as Password, ');   Add('"OneMinute * 60" as Commnets ');Add('From Dual');
    Add('union all  ');  Add('Select ');  Add('"SCHEDULEDREPORTS CHECK INTERVAL"    as Description, ');  Add('null as shortCut, ');   Add('Null as Formname, ');   Add('null as Password, ');   Add('"OneMinute * 60" as Commnets ');Add('From Dual');
    Add('union all  ');  Add('Select ');  Add('"USER INACTIVITY CHECK INTERVAL"     as Description, ');  Add('null as shortCut, ');   Add('Null as Formname, ');   Add('null as Password, ');   Add('"OneMinute * 3"  as Commnets ');Add('From Dual');
    Add('union all  ');  Add('Select ');  Add('"GOOGLE CALENDAR CHECK INTERVAL"     as Description, ');  Add('null as shortCut, ');   Add('Null as Formname, ');   Add('null as Password, ');   Add('"OneMinute * 5"  as Commnets ');Add('From Dual');
    Add('union all  ');  Add('Select ');  Add('"GOOGLE APPOINTMENT CHECK INTERVAL"  as Description, ');  Add('null as shortCut, ');   Add('Null as Formname, ');   Add('null as Password, ');   Add('"OneMinute * 30" as Commnets ');Add('From Dual');
    Add('union all  ');  Add('Select ');  Add('"GOOGLE TASK CHECK INTERVAL"         as Description, ');  Add('null as shortCut, ');   Add('Null as Formname, ');   Add('null as Password, ');   Add('"OneMinute * 30" as Commnets ');Add('From Dual');
    Add('union all  ');  Add('Select ');  Add('"GOOGLE QUEUE CHECK INTERVAL"        as Description, ');  Add('null as shortCut, ');   Add('Null as Formname, ');   Add('null as Password, ');   Add('"OneMinute * 5"  as Commnets ');Add('From Dual');
    Add('union all  ');  Add('Select ');  Add('"FILE CLEANUP CHECK INTERVAL"        as Description, ');  Add('null as shortCut, ');   Add('Null as Formname, ');   Add('null as Password, ');   Add('"OneHour * 8"    as Commnets ');Add('From Dual');
    Add('union all  ');  Add('Select ');  Add('"DOC DOWNLOAD CHECK INTERVAL"        as Description, ');  Add('null as shortCut, ');   Add('Null as Formname, ');   Add('null as Password, ');   Add('"OneMinute * 60" as Commnets ');Add('From Dual');
    if Appenv.Companyprefs.EnableEbay then begin
      Add('union all  ');  Add('Select ');  Add('"Ebay Synch"        as Description, ');  Add('null as shortCut, ');   Add('Null as Formname, ');   Add('null as Password, ');   Add('"OneMinute * 60" as Commnets ');Add('From Dual');
    end;
  end;
  inherited;
end;

procedure TERPShortcutsGUI.FormShow(Sender: TObject);
begin
  inherited;
  memComments.Color := ClNavy;
  memComments.font.Color := clWhite;
end;

procedure TERPShortcutsGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
  DoMemoDialogReadonly('Comments', Qrymaincomments.AsString)
end;

initialization
  RegisterClassOnce(TERPShortcutsGUI);

end.

