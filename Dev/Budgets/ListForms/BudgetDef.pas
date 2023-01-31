unit BudgetDef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar,  wwdblook, Shader,
  kbmMemTable;

type
  TBudgetDefGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainBudgetID: TIntegerField;
    qryMainName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainAmount1Label: TWideStringField;
    qryMainAmount2Label: TWideStringField;
    qryMainShowAmount1: TWideStringField;
    qryMainShowAmount2: TWideStringField;
    qryMainStartDate: TDateTimeField;
    qryMainEndDate: TDateTimeField;
    qryMainIntervalDuration: TSmallintField;
    qryMainActive: TWideStringField;
    qryMainIntervalPeriod: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

//var
//  BudgetDefGUI: TBudgetDefGUI;

implementation

uses frmBudgetDef, CommonLib;

{$R *.dfm}

procedure TBudgetDefGUI.grpFiltersClick(Sender: TObject);
begin
  with QryMain do case grpFilters.ItemIndex of
      0: 
        begin
          Filter := 'Active = ''T'' ';
          Filtered := true;
        end;
      1: 
        begin
          Filter := 'Active = ''F'' ';
          Filtered := true;
        end;
      2: 
        begin
          Filtered := false;
        end;
    end;
end;

procedure TBudgetDefGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.DbGridElement[grdMain].RemoveFields('BudgetID');
  grpFiltersClick(nil);
end;

procedure TBudgetDefGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
//  BudgetDefGUI := nil;
end;

procedure TBudgetDefGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfmBudgetDef');
    if Assigned(Form) then begin
      with TfmBudgetDef(Form) do begin
        AttachObserver(Self);
        KeyId     := 0;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TBudgetDefGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbEnableWebSearch      := true;
  fbStartinWebSearchMode := true;
end;

procedure TBudgetDefGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBudgetDefGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBudgetDefGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TBudgetDefGUI);
end.
