unit frmDeductionListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwcheckbox, wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess,
  MyAccess,ERPdbComponents, MemDS, wwdbdatetimepicker, ProgressDialog, 
  wwdblook, Shader, kbmMemTable, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TfrmDeductionList = class(TBaseListingGUI)
    qryMainDescription: TWideStringField;
    qryMainUnionFees: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainTaxExempt: TWideStringField;
    qryMainDeductionID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure grdMainCellChanged(Sender: TObject);
//    procedure qryMainFieldChangeComplete(DataSet: TCustomMyConnection; const FieldCount: integer;
//      const Fields: OleVariant; const Error: Error; var EventStatus: TEventStatus);
    procedure cmdCloseClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses Forms, frmDeductionsFrm, CommonLib, AppEnvironment, tcTypes;

procedure TfrmDeductionList.cmdNewClick(Sender: TObject);
var tmpComponent:tComponent;
begin
  DisableForm;
  try
    inherited;
    if AppEnv.RegionalOptions.RegionType <> rUSA then
      tmpComponent:= GetComponentByClassName('TfrmDeductions')
    else
      tmpComponent:= GetComponentByClassName('TfrmDeductionsUSA');
    if not assigned(tmpComponent) then exit;
    with TfrmDeductions(tmpComponent) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmDeductionList.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin
        GroupFilterString := 'Active=' + QuotedStr('T');
      end;
    1: 
      begin
        GroupFilterString := 'Active=' + QuotedStr('F');
      end;
  end;
  inherited;
end;

procedure TfrmDeductionList.FormShow(Sender: TObject);
begin
  inherited;
  if not qryMain.Active then Exit;
  grpFiltersClick(Sender);
  qryMain.FieldByName('Description').DisplayWidth := 50;
  grdMain.Invalidate;
  grdMain.RefreshDisplay;
end;

procedure TfrmDeductionList.grdMainCellChanged(Sender: TObject);
begin
  inherited;
  qryMain.FieldByName('Description').DisplayWidth := 50;
end;

//procedure TfrmDeductionList.qryMainFieldChangeComplete(DataSet: TCustomMyConnection; const FieldCount: integer;
//  const Fields: OleVariant; const Error: Error; var EventStatus: TEventStatus);
//begin
//  inherited;
//  qryMain.FieldByName('Description').DisplayWidth := 50;
//  qryMain.Refresh;
//end;

procedure TfrmDeductionList.cmdCloseClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmDeductionList.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmDeductionList.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmDeductionList.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TfrmDeductionList);
end.
