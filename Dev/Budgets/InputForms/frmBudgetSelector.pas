unit frmBudgetSelector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, StdCtrls, wwdblook,
  DNMSpeedButton, DNMPanel, MemDS;

type
  TfmBudgetSelector = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    btnSave: TDNMSpeedButton;
    Label1: TLabel;
    cboBudget: TwwDBLookupCombo;
    QryBudgets: TERPQuery;
    btnCancel: TDNMSpeedButton;
    QryBudgetsName: TWideStringField;
    QryBudgetsBudgetID: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    fiAccountID :Integer;
    fibudgetId : integer;
  public
    Property AccountId :Integer Write fiAccountId;
    Property BudgetID :Integer read fiBudgetID;
  end;
var
  fmBudgetSelector: TfmBudgetSelector;

implementation

uses FastFuncs,CommonLib;

{$R *.dfm}

procedure TfmBudgetSelector.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    fbIgnoreAccessLevels := true;
    inherited;
    if QryBudgets.active then QryBudgets.Close;
    if FiaccountId > 0 then
      QryBudgets.SQL.add('AND tblbudgetperiodlines.AccountID=' + IntToStr(FiaccountId));
    QryBudgets.Open;
  finally
    EnableForm;
  end;   
end;

procedure TfmBudgetSelector.FormCreate(Sender: TObject);
begin
  inherited;
    fiAccountId := 0;
end;

procedure TfmBudgetSelector.btnSaveClick(Sender: TObject);
begin
  inherited;
    if cboBudget.text <> '' then fiBudgetId := QryBudgetsBudgetID.asInteger;
end;

initialization
  RegisterClassOnce(TfmBudgetSelector);

end.
