unit frmProcStowAwaySlipList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB, CustomInputBox,
  ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton;

type
  TfmProcStowAwaySlipList = class(TBaseListingGUI)
    procedure grpFiltersClick(Sender: TObject); override;
  private
  protected
    procedure RefreshQuery; override;  
  public
  end;

var
  fmProcStowAwaySlipList: TfmProcStowAwaySlipList;

implementation

uses
  CommonLib;

{$R *.dfm}

{ TfmProcStowAwaySlipList }

procedure TfmProcStowAwaySlipList.RefreshQuery;
begin
  qryMain.Close;
  qryMain.SQL.Text:=
    'SELECT ProcPickSlipId as SlipNumber, Date, Description, Picked as Stowed' +
    ' FROM tblProcPickSlip WHERE PickType = "StowAway"';
  case grpFilters.ItemIndex of
    0: qryMain.SQL.Add('AND Picked = "T"');
    1: qryMain.SQL.Add('AND Picked = "F"');
  end;
  inherited;
end;

procedure TfmProcStowAwaySlipList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

initialization

  RegisterClassOnce(TfmProcStowAwaySlipList);

end.
