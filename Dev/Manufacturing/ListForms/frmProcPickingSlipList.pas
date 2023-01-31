unit frmProcPickingSlipList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB, CustomInputBox,
  ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, TaskDialog, TaskDialogEx;

type
  TfmProcPickingSlipList = class(TBaseListingGUI)
    procedure grpFiltersClick(Sender: TObject); override;
  private
  protected
    procedure RefreshQuery; override;  
  public
  end;

var
  fmProcPickingSlipList: TfmProcPickingSlipList;

implementation

uses
  CommonLib;

{$R *.dfm}

{ TfmProcPickingSlipList }

procedure TfmProcPickingSlipList.RefreshQuery;
begin
  qryMain.Close;
  qryMain.SQL.Text:=
    'SELECT ProcPickSlipId as SlipNumber, Date, Description, Picked' +
    ' FROM tblProcPickSlip WHERE PickType = "Picking"';
  case grpFilters.ItemIndex of
    0: qryMain.SQL.Add('AND Picked = "T"');
    1: qryMain.SQL.Add('AND Picked = "F"');
  end;
  inherited;
end;

procedure TfmProcPickingSlipList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

initialization

  RegisterClassOnce(TfmProcPickingSlipList);

end.
