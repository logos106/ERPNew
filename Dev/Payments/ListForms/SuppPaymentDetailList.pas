unit SuppPaymentDetailList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  Spin, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSuppPaymentDetailListGUI = class(TBaseListingGUI)
    DNMPanel1: TDNMPanel;
    chkRange: TCheckBox;
    DNMPanel2: TDNMPanel;
    Label2: TLabel;
    edtIgnoreRangemin: TSpinEdit;
    edtIgnoreRangemax: TSpinEdit;
    qryMainReceiptNo: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainOpeningBalance: TFloatField;
    qryMainPaymentAmount: TFloatField;
    qryMainPaymentMethod: TWideStringField;
    qryMainReferenceNo: TWideStringField;
    qryMainBankAccount: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainClassID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainAccountID: TIntegerField;
    qryMainChequePrinted: TWideStringField;
    qryMainPaymentID: TIntegerField;
    qryMainCompanyName: TWideStringField;
    qryMainPaymentDate: TDateField;
    qryMainPOID: TIntegerField;
    qryMainPrePaymentID: TIntegerField;
    qryMainTrnType: TWideStringField;
    qryMainOriginalAmount: TFloatField;
    qryMainPayment: TFloatField;
    qryMainAmountOutstanding: TFloatField;
    qryMainAmountDue: TFloatField;
    qryMainPaidInFull: TWideStringField;
    qryMainForeignOriginalAmount: TFloatField;
    qryMainForeignAmountDue: TFloatField;
    qryMainForeignPayment: TFloatField;
    qryMainForeignAmountOutstanding: TFloatField;
    qryMainPONum: TLargeintField;
    lblREfreshInfo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure chkRangeClick(Sender: TObject);
    procedure lblREfreshInfoDblClick(Sender: TObject);
  private
    fsTablename :String;
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonDbLib, CommonLib, SystemLib;

{$R *.dfm}

procedure TSuppPaymentDetailListGUI.chkRangeClick(Sender: TObject);
begin
  inherited;
  if (screen.activecontrol = chkRange) then
    if (not(chkRange.checked)) then
      RefreshQuery
    else lblREfreshInfo.visible := true ;
end;

procedure TSuppPaymentDetailListGUI.FormCreate(Sender: TObject);
begin
  fstablename := commondblib.GetUserTemporaryTableName('SP');
  Qrymain.SQL.Text := 'Select * from '+fsTablename ;
  inherited;
end;
procedure TSuppPaymentDetailListGUI.lblREfreshInfoDblClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TSuppPaymentDetailListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.IgnoreRange'   ) then chkRange.checked  :=  GuiPrefs.Node['Options.IgnoreRange'].asBoolean;
  if GuiPrefs.Node.Exists('Options.IgnoreRangemin') then edtIgnoreRangemin.Value :=  GuiPrefs.Node['Options.IgnoreRangemin'].asInteger;
  if GuiPrefs.Node.Exists('Options.IgnoreRangemax') then edtIgnoreRangemax.Value :=  GuiPrefs.Node['Options.IgnoreRangemax'].asInteger;
end;

procedure TSuppPaymentDetailListGUI.RefreshQuery;
begin
  lblREfreshInfo.visible := False;
  CloseDB(Qrymain);
  With ScriptMain do begin
    SQL.Clear;
    SQL.Add('Drop table if exists '+ fsTablename +';');
    SQL.Add(' Create table  '+ fsTablename +' Select '+
            ' @PONum:=if(@POID <> ifnull(POID,0),  @PONum:= 1 ,  @PONum+1) PONum , '+
            '  @POID := ifnull(POID,0),a.* '+
            ' from '+
            '  (SELECT @PONum:=0) r , '+
            '  (SELECT @POID:=0) s, '+
            '   (Select '+
            ' Concat_ws("",PaymentNo) as ReceiptNo, '+
            ' W.GlobalRef as GlobalRef, '+
            ' W.Balance as OpeningBalance, '+
            ' Amount as PaymentAmount, '+
            ' Name as PaymentMethod, '+
            ' ReferenceNo as ReferenceNo, '+
            ' AccountName as BankAccount, '+
            ' ClassName as Department, '+
            ' W.Notes as Notes, '+
            ' W.Deleted as Deleted, '+
            ' W.ClassID as ClassID, '+
            ' EmployeeID as EmployeeID, '+
            ' W.AccountID as AccountID , '+
            ' W.ChequePrinted as ChequePrinted, '+
            ' W.PaymentID, W.CompanyName,  W.PaymentDate, '+
            ' WL.POID, WL.PrePaymentID , WL.TrnType, WL.OriginalAmount, WL.Payment, WL.AmountOutstanding, WL.AmountDue, WL.PaidInFull, WL.ForeignOriginalAmount ,  '+
            ' WL.ForeignAmountDue , WL.ForeignPayment , WL.ForeignAmountOutstanding '+
            '  from tblwithdrawal W inner join tblwithdrawallines WL on W.PaymentID = WL.PaymentID '+
            '  LEFT JOIN tblpaymentmethods PM ON PM.PayMethodID= W.PayMethodID '+
            '  INNER JOIN tblchartofaccounts COA ON COA.AccountID=W.AccountID '+
            '  INNER JOIN tblclass CL ON CL.ClassID= W.ClassID '+
            ' Where W.deleted ="F" '+
            ' and ("T"=' + Quotedstr(BooleanToStr(not(chkRange.Checked))) +' or  WL.Payment >' + inttostr(edtIgnoreRangemin.Value) + ' and WL.Payment < ' + inttostr(edtIgnoreRangemax.Value) + ' ) '+
            ' Order by CompanyName , POID Desc, PaymentDate) a;');
    Execute;
  end;
  inherited;

end;

procedure TSuppPaymentDetailListGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(QryMainClassID.Fieldname);
    RemoveFieldfromGrid(QryMainEmployeeID.Fieldname);
    RemoveFieldfromGrid(QryMainAccountID.Fieldname);
    RemoveFieldfromGrid(QryMainPaymentID.Fieldname);
    RemoveFieldfromGrid(qryMainPONum.Fieldname);
end;

procedure TSuppPaymentDetailListGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.IgnoreRange'].asBoolean := chkRange.checked;
  GuiPrefs.Node['Options.IgnoreRangemin'].asInteger := edtIgnoreRangemin.Value;
  GuiPrefs.Node['Options.IgnoreRangemax'].asInteger := edtIgnoreRangemax.Value;
end;

initialization
  RegisterClassOnce(TSuppPaymentDetailListGUI);

end.
