unit VS1Forms;

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
  TVS1FormsGUI = class(TBaseListingGUI)
    qryMainFormID: TIntegerField;
    qryMainFormName: TWideStringField;
    qryMainBusinessObjectName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainTabGroup: TIntegerField;
    qryMainIsForm: TWideStringField;
    qryMainSkinsGroup: TWideStringField;
  private
  Protected
    procedure SetGridColumns; Override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

{ TVS1FormsGUI }

procedure TVS1FormsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('fieldname');
  RemoveFieldfromGrid(qryMainFormID.fieldname);
  RemoveFieldfromGrid(qryMainFormName.fieldname);
  RemoveFieldfromGrid(qryMainBusinessObjectName.fieldname);
  RemoveFieldfromGrid(qryMainTabGroup.fieldname);
end;

initialization
  RegisterClass(TVS1FormsGUI);

end.
