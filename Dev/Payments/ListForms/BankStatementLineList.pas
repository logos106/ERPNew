unit BankStatementLineList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TBankStatementLineListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainID: TIntegerField;
    qryMainSource: TWideStringField;
    qryMainYodleeContainer: TWideStringField;
    qryMainYodleeID: TIntegerField;
    qryMainYodleeAccountID: TIntegerField;
    qryMainAmount: TFloatField;
    qryMainCurrency: TWideStringField;
    qryMainTransactionDate: TDateField;
    qryMainType: TWideStringField;
    qryMainSubType: TWideStringField;
    qryMainCategory: TWideStringField;
    qryMainCategoryType: TWideStringField;
    qryMainCategoryID: TIntegerField;
    qryMainBaseType: TWideStringField;
    qryMainDescriptionSimple: TWideStringField;
    qryMainDescriptionOriginal: TWideStringField;
    qryMainDescriptionConsumer: TWideStringField;
    qryMainCheckNumber: TWideStringField;
    qryMainAccountID: TIntegerField;
    qryMainAccountName: TWideStringField;
    qryMainReconciliationLineID: TIntegerField;
    qryMainJSON: TWideMemoField;
    qryMainActive: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainmsUpdateSiteCode: TWideStringField;
    qryMainLinked: TWideStringField;
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllAccounts: TwwCheckBox;
    cboAccount: TwwDBLookupCombo;
    qryAccountLookup: TERPQuery;
    qryMainCreditAmount: TFloatField;
    qryMainDebitAmount: TFloatField;
    btnFlagInactive: TDNMSpeedButton;
    btnFlagActive: TDNMSpeedButton;
    procedure cboAccountCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkAllAccountsClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFlagInactiveClick(Sender: TObject);
    procedure btnFlagActiveClick(Sender: TObject);
  private
    procedure BankTransImportAfterShow(Sender: TObject);
    procedure FlagActive(const MakeActive: boolean);
  protected
    procedure RefreshQuery; override;
    procedure ApplyQueryFilter; override;
  public
    { Public declarations }
  end;

var
  BankStatementLineListGUI: TBankStatementLineListGUI;

implementation

uses
  CommonFormLib, frmBankStatmentImport, IntegerListObj, CommonLib, CommonDbLib;

{$R *.dfm}


{ TBankStatementLineListGUI }

procedure TBankStatementLineListGUI.ApplyQueryFilter;
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Active}
        GroupFilterString := '(Active = "T")';
      end;
    1:
      begin {Inactive}
        GroupFilterString := '(Active = "F")';
      end;
    2:
      begin {both}
        GroupFilterString := '';
      end;
  end;
  inherited;
end;

procedure TBankStatementLineListGUI.BankTransImportAfterShow(Sender: TObject);
begin
  if not chkAllAccounts.Checked then begin
    TfmBankStatmentImport(Sender).cboBankAccount.LookupTable.Locate('AccountName',qryAccountLookup.FieldByName('AccountName').AsString,[loCaseInsensitive]);
    TfmBankStatmentImport(Sender).cboBankAccount.Text := qryAccountLookup.FieldByName('AccountName').AsString;
  end;
end;

procedure TBankStatementLineListGUI.btnFlagActiveClick(Sender: TObject);
begin
  inherited;
  FlagActive(true);
end;

procedure TBankStatementLineListGUI.btnFlagInactiveClick(Sender: TObject);
begin
  inherited;
  FlagActive(false);
end;

procedure TBankStatementLineListGUI.cboAccountCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not chkAllAccounts.Checked then
    RefreshQuery;
end;

procedure TBankStatementLineListGUI.chkAllAccountsClick(Sender: TObject);
begin
  inherited;
  if not chkAllAccounts.Focused then exit;
  RefreshQuery;
end;

procedure TBankStatementLineListGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmBankStatmentImport', 0, BankTransImportAfterShow);
end;

procedure TBankStatementLineListGUI.FlagActive(const MakeActive: boolean);
var
  IDList: TIntegerList;
  x: integer;
  cmd: TERPCommand;
begin
  if grdMain.SelectedList.Count = 0 then begin
    CommonLib.MessageDlgXP_Vista('You have not selected any records.',mtInformation,[mbOk],0);
    exit;
  end;

  IDList := TIntegerList.Create;
  try
    qryMain.DisableControls;
    try
      for x := 0 to grdMain.SelectedList.Count -1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList[x]);
        IDList.Add(qryMainID.AsInteger);
        if (not MakeActive) and qryMainLinked.AsBoolean then begin
          CommonLib.MessageDlgXP_Vista('At least one of the selected transactions has been linked to a Bank Reconciliation record so can not be flagged as Inactive.',mtInformation,[mbOk],0);
          exit;
        end;
      end;

      cmd := TERPCommand.Create(nil);
      try
        cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
        cmd.SQL.Add('update tblbankstatementline');
        if MakeActive then
          cmd.SQL.Add('set Active = "T"')
        else
          cmd.SQL.Add('set Active = "F"');
        cmd.SQL.Add('where ID in (' + IdList.CommaText + ')');
        cmd.Execute;
        grdMain.SelectedList.Clear;
      finally
        cmd.Free;
      end;
      qryMain.Refresh;
    finally
      qryMain.EnableControls;
    end;
  finally
    IDList.Free;
  end;
end;

procedure TBankStatementLineListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryAccountLookup.Open
end;

procedure TBankStatementLineListGUI.RefreshQuery;
begin
  qryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('DateFrom').AsDate := 0;
    qryMain.ParamByName('DateTo').AsDate := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('DateFrom').AsDate := dtFrom.Date;
    qryMain.ParamByName('DateTo').AsDate := dtTo.Date;
  end;
  if chkAllAccounts.Checked then begin
    qryMain.ParamByName('AccountName').AsString := '';
  end
  else begin
    qryMain.ParamByName('AccountName').AsString := qryAccountLookup.FieldByName('AccountName').AsString;
  end;

  inherited;
end;

initialization
  RegisterClass(TBankStatementLineListGUI)

end.
