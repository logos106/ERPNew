unit frmFixedAssetRepairList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, DNMPanel, StdCtrls, Buttons, Wwdbigrd,
  Grids, Wwdbgrid, wwdbdatetimepicker, wwdblook, DNMSpeedButton, Shader;

type
  TfmFixedAssetRepairList = class(TBaseListingGUI)
    qryMainAssetID: TIntegerField;
    qryMainRepairID: TIntegerField;
    qryMainAssetCode: TWideStringField;
    qryMainAssetName: TWideStringField;
    qryMainRepairDocNo: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainCreationDate: TDateField;
    qryMainDueDate: TDateTimeField;
    qryMainDone: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainNotes: TWideMemoField;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmFixedAssetRepairList: TfmFixedAssetRepairList;

implementation

{$R *.dfm}


procedure TfmFixedAssetRepairList.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('RepairID,AssetID');
end;

procedure TfmFixedAssetRepairList.grdMainDblClick(Sender: TObject);
begin
  if {Assigned(grdMain.GetActiveField) and} (grdMain.GetActiveField.FieldName = 'Notes') then
    exit;
  inherited;
end;

initialization
  RegisterClass(TfmFixedAssetRepairList);

end.
