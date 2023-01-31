// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 17/05/05  1.00.01 BJ  GlobalRef Field is added to the grid as the first column
unit AccountTypesList;

interface

uses
  Messages, Classes, Graphics, Controls, Dialogs, BaseListingForm, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, Buttons, DNMSpeedButton,
  Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, DBAccess,
  MyAccess,ERPdbComponents, MemDS, wwdbdatetimepicker, 
  wwdblook, Shader, kbmMemTable, ProgressDialog, DAScript, MyScript, wwcheckbox,
  CustomInputBox, wwclearbuttongroup, wwradiogroup;

type
  TAccountTypesListGUI = class(TBaseListingGUI)
    qryMainAccountTypes: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainAccType: TWideStringField;
    qryMainTypeID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TAccountTypesListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbEnableWebSearch := true;
end;

procedure TAccountTypesListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('TypeID');
  ListTimerMsg('Double click to edit record');
end;

initialization
  RegisterClassOnce(TAccountTypesListGUI);

end.
