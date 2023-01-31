unit ChartOfAccountsListExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TChartOfAccountsListExpressGUI = class(TBaseListingGUI)
    qryMainAccountNo: TWideStringField;
    qryMainFullAccountName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainBalance: TFloatField;
    qryMainTaxCode: TWideStringField;
    qryMainBSB: TWideStringField;
    qryMainBankAccNo: TWideStringField;
    qryMainBankAccountName: TWideStringField;
    qryMainBankNumber: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainAccountGroup: TWideStringField;
    qryMainAccountTree: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainLevel1: TWideStringField;
    qryMainLevel2: TWideStringField;
    qryMainLevel3: TWideStringField;
    qryMainLevel4: TWideStringField;
    qryMainAccountID: TIntegerField;
    qryMainAllowExpenseClaim: TWideStringField;
    qryMainAccounttype: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TChartOfAccountsListExpressGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := False;
end;


procedure TChartOfAccountsListExpressGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainAccountID.fieldname);
  RemoveFieldfromGrid(qryMainAccounttype.fieldname);
end;

initialization
  RegisterClassOnce(TChartOfAccountsListExpressGUI);

end.
