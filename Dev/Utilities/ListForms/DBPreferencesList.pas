unit DBPreferencesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TDBPreferencesListGUI = class(TBaseListingGUI)
    qryMainPrefID: TIntegerField;
    qryMainPrefType: TWideStringField;
    qryMainName: TWideStringField;
    qryMainRefType: TWideStringField;
    qryMainLocalPref: TWideStringField;
    qryMainFieldType: TWideStringField;
    qryMainFieldSize: TIntegerField;
    qryMainFieldValue: TWideMemoField;
    qryMainDefaultValue: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainmsUpdateSiteCode: TWideStringField;
  private
  public
  end;

implementation

uses CommonLib;

{$R *.dfm}

initialization
  RegisterClassOnce(TDBPreferencesListGUI);
end.
