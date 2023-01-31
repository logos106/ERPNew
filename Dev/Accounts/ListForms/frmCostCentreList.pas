unit frmCostCentreList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls, ProgressDialog, kbmMemTable, CustomInputBox,
  wwdblook, Shader;

type
  TfmCostCentreList = class(TBaseListingGUI)
    qryMainCostCentreId: TIntegerField;
    qryMainGlobalRef: TStringField;
    qryMainCostCentreName: TStringField;
    qryMainCostCentreDescription: TStringField;
    qryMainActive: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  protected 
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
  CommonDbLib, frmCostCentreEdit, CommonLib;

procedure TfmCostCentreList.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
  inherited;
  DefaultMaxGridColumnWidth := 0;
  qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;
end;

procedure TfmCostCentreList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmCostCentreList.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfmCostCentreList.RefreshQuery;
begin
  inherited;
  grdMain.DataSource.DataSet.DisableControls;
  try
    qryMain.Close;
    qryMain.ParamByName('Active').AsString := grpFilters.Items[grpFilters.ItemIndex];
    qryMain.Open;
  finally
    grdMain.DataSource.DataSet.EnableControls;
  end;
end;


procedure TfmCostCentreList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmCostCentreList.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmCostCentreEdit');
  if Assigned(Form) then begin
    with TfmCostCentreEdit(Form) do begin
      AttachObserver(Self);
      KeyId     := 0;
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfmCostCentreList);
end.
