unit frmcustomAccountsReportOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPayDeptSelectionGUI, Shader, ExtCtrls, DNMPanel, ProgressDialog,
  DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState,
  SelectionDialog, AppEvnts, Menus, StdCtrls, wwcheckbox, DNMSpeedButton,
  CheckLst  , CustomAccountsReportObj;

type
  TfmcustomAccountsReportOptions = class(TfrmPayDeptSelection)
    pnlTitle: TDNMPanel;
    pnlHeader: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCustomize: TDNMSpeedButton;
    chkBlankwhen0: TCheckBox;
    chkUseGroupcolors: TCheckBox;
    procedure btnCustomizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private

    fCustomAccountsReportObj :TCustomAccountsReportObj;
    procedure initChartofAccountsReportTree(Sender: TObject);
  public
    Property CustomAccountsReportObj : TCustomAccountsReportObj read fCustomAccountsReportObj write fCustomAccountsReportObj;
  end;


implementation

uses CommonLib , CommonFormLib, FrmChartofAccountsReportTree;

{$R *.dfm}

procedure TfmcustomAccountsReportOptions.btnCustomizeClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TFmChartofAccountsReportTree' , 0, initChartofAccountsReportTree, true , nil)
end;
procedure TfmcustomAccountsReportOptions.initChartofAccountsReportTree(Sender: TObject);
begin
  if not(Sender is TFmChartofAccountsReportTree) then exit;
  TFmChartofAccountsReportTree(Sender).ReportID := CustomAccountsReportObj.FormId;
end;
procedure TfmcustomAccountsReportOptions.btnSaveClick(Sender: TObject);
begin
  CustomAccountsReportObj.USeGroupcolours := chkUseGroupcolors.Checked;
  CustomAccountsReportObj.Blankwhen0      := chkBlankwhen0.Checked;
  CustomAccountsReportObj.Hidetotals      := chkShowSubTotals.Checked;
  updateSelectedList;
//  CustomAccountsReportObj.SelectedDepartmentList.commatext := SelectedList.commatext;
  CustomAccountsReportObj.SelectedClasses := SelectedList.commatext;
  //if CustomAccountsReportObj.SelectedClasses = '' then CustomAccountsReportObj.SelectedClasses := '0';
end;

procedure TfmcustomAccountsReportOptions.FormCreate(Sender: TObject);
begin
  inherited;
  fCustomAccountsReportObj := nil;
end;


procedure TfmcustomAccountsReportOptions.FormShow(Sender: TObject);
begin
  ReturnIDs := True;
  SelectedList.commatext := CustomAccountsReportObj.SelectedClasses;
  inherited;
  chkUseGroupcolors.Checked := CustomAccountsReportObj.USeGroupcolours;
  chkBlankwhen0.Checked     := CustomAccountsReportObj.Blankwhen0;
  chkShowSubTotals.Checked  := CustomAccountsReportObj.Hidetotals;
end;

initialization
  RegisterClassOnce(TfmcustomAccountsReportOptions);


end.
