unit frmProductGroupList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox;

type
  TfmProductGroupList = class(TBaseListingGUI)
    qryMainProductGroupID: TIntegerField;
    qryMainGroupName: TWideStringField;
    qryMainDescription: TWideMemoField;
    qryMainGlobalRef: TWideStringField;
    qryMainParentGroupName: TWideStringField;
    qryMainActive: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
  public
    { Public declarations }
  end;

var
  fmProductGroupList: TfmProductGroupList;

implementation

{$R *.dfm}

procedure TfmProductGroupList.ApplyQueryFilter;
begin
  case grpFilters.ItemIndex of
    0: GroupFilterString := '(Active = "T")';
    1: GroupFilterString := '(Active = "F")';
    2: GroupFilterString := '';
  end;
  inherited;

end;

procedure TfmProductGroupList.FormCreate(Sender: TObject);
begin
  inherited;
  { can not create new Product Groups, these are created from Product Card }
  cmdNew.Enabled:= false;
end;

procedure TfmProductGroupList.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields(
    'ProductGroupId,GlobalRef');

end;

procedure TfmProductGroupList.RefreshQuery;
begin
  inherited;

end;

initialization
  RegisterClass(TfmProductGroupList);

end.
