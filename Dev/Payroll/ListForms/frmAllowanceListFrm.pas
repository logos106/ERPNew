unit frmAllowanceListFrm;

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
  TfrmAllowanceList = class(TBaseListingGUI)
    qryMainDescription: TWideStringField;
    qryMainSuper: TWideStringField;
    qryMainTaxExempt: TWideStringField;
    qryMainPayrollTaxExempt: TWideStringField;
    qryMainWorkcoverExempt: TWideStringField;
    qryMainDisplayIn: TWideStringField;
    qryMainAmount: TFloatField;
    qryMainPercentage: TFloatField;
    qryMainBasedOn: TWideStringField;
    chkPayrollTaxExempt: TwwCheckBox;
    chkSuper: TwwCheckBox;
    chkWorkCoverExempt: TwwCheckBox;
    chkTaxExempt: TwwCheckBox;
    qryMainActive: TWideStringField;
    chkActive: TwwCheckBox;
    qryMainAllowanceID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure actlstFiltersUpdate(Action: TBasicAction; var Handled: boolean);
    procedure actlstFiltersExecute(Action: TBasicAction; var Handled: boolean);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
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

uses Forms, frmAllowancesFrm, frmAllowancesFrmUSA, CommonLib, AppEnvironment, tcTypes;

procedure TfrmAllowanceList.cmdNewClick(Sender: TObject);
var
   tmpComponent:TComponent;
begin
  DisableForm;
  try
    inherited;

      if AppEnv.RegionalOptions.RegionType = rUSA then
      begin
         tmpComponent:=GetComponentByClassName('TfrmAllowancesUSA');

         if not assigned(tmpComponent) then exit;

         with TfrmAllowancesUSA(tmpComponent) do
         begin
               AttachObserver(Self);
               FormStyle := fsMDIChild;
               BringToFront;
         end;

      end
      else
      begin
         tmpComponent:=GetComponentByClassName('TfrmAllowances');

         if not assigned(tmpComponent) then exit;

         with TfrmAllowances(tmpComponent) do
         begin
               AttachObserver(Self);
               FormStyle := fsMDIChild;
               BringToFront;
         end;
     end;




  finally
    EnableForm;
  end;  
end;

procedure TfrmAllowanceList.actlstFiltersUpdate(Action: TBasicAction; var Handled: boolean);
begin
  inherited;
  //
end;

procedure TfrmAllowanceList.actlstFiltersExecute(Action: TBasicAction; var Handled: boolean);
begin
  inherited;
  //
end;

procedure TfrmAllowanceList.FormShow(Sender: TObject);
begin
  inherited;
  if not qryMain.Active then Exit;
//  GuiPrefs.DbGridElement[grdMain].RemoveFields(
//    'StartDate,EndDate,BankAccnts');
  grpFiltersClick(Sender);

  grdMain.SetControlType('Payroll Tax Exempt', fctCustom, 'chkPayrollTaxExempt');
  grdMain.Invalidate;
  grdMain.RefreshDisplay;
end;


procedure TfrmAllowanceList.grpFiltersClick(Sender: TObject);
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

procedure TfrmAllowanceList.cmdCloseClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmAllowanceList.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmAllowanceList.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TfrmAllowanceList.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TfrmAllowanceList);

end.
