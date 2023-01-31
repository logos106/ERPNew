unit ChartOfAccountsListLookup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ChartOfAccountsListForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwcheckbox,
  wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

  (*
     NOTE:
       This list inherits from TChartOfAccountsListGUI and its only purpose
       is to provide a lookup list that does not inclute Header accounts
       and is used by the ERPDbLookupCombo

  *)



type
  TChartOfAccountsListLookupGUI = class(TChartOfAccountsListGUI)
    procedure FormCreate(Sender: TObject);
  private
    fbExpenseClaimList: Boolean;
    procedure setExpenseClaimList(const Value: Boolean);
    { Private declarations }
  public
    Property ExpenseClaimList :Boolean read fbExpenseClaimList write setExpenseClaimList;
  end;


implementation

{$R *.dfm}

procedure TChartOfAccountsListLookupGUI.FormCreate(Sender: TObject);
begin
  qryMain.ParamByName('ExcludeHeaderAccounts').AsString:= 'T';
  fbExpenseClaimList:= False;
  inherited;
end;

procedure TChartOfAccountsListLookupGUI.setExpenseClaimList(
  const Value: Boolean);
begin
  fbExpenseClaimList := Value;
  if value then begin
    ChangeNote('This List is showing the ''Allow Expense Claim'' Accounts only ' , clRed );
    FilterString := 'AllowExpenseClaim = ' +Quotedstr('T');
  end;
end;

initialization
  RegisterClass(TChartOfAccountsListLookupGUI);


end.
