unit JournalList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox , BaseListDetails,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TJournalListGui = class(TBaseListDetailsGUI)
    qryMainTransactionDate: TDateField;
    qryMainEntryNo: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainDebitAmount: TFloatField;
    qryMainCreditAmount: TFloatField;
    qryMainTaxAmount: TFloatField;
    qryMainClassName: TWideStringField;
    qryMainGJID: TIntegerField;
    qryMainAccountNumber: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainmemo: TWideStringField;
    qryMainApproved: TWideStringField;
    qryMainJournalMemo: TWideStringField;
    lblbalance: TLabel;
    edtBalance: TEdit;
    procedure cmdNewClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fClientId: integer;
    fAccountIdList: string;
    procedure MakeQrymain;
    procedure SetAccountIdList(const Value: string);
    //fCleanSQL: string;
  protected
    procedure RefreshQuery; override;
    Function ExpressDetailListName:String;Override;
    Procedure RefreshTotals; override;
  public
    property AccountIdList: string read fAccountIdList write SetAccountIdList;
    property ClientId: integer read fClientId write fClientId;
  end;

implementation
    
uses CommonLib, Forms, CommonFormLib;
{$R *.dfm}

procedure TJournalListGui.cmdNewClick(Sender: TObject);
begin
  OpenERPForm('TJournalEntryGUI' , 0);
(*Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TJournalEntryGUI');
    if Assigned(Form) then begin
      with TJournalEntryGUI(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;*)
end;

procedure TJournalListGui.RefreshQuery;
begin
(*  qryMain.Close;
  if fAccountIdList <> '' then begin
    qryMain.SQL.Text := fCleanSQL;
    qryMain.SQL.Add('and AccountID in (' + fAccountIdList + ')');
    qryMain.SQL.Add('Order by a.GJId desc');
  end
  else begin
    qryMain.SQL.Text := QueryManipulationObj.ModifiedSQL;
  end;
  self.RefreshOrignalSQL;*)
  InitDateFromnDateto('txtfrom' ,'txtto');
  qryMain.ParamByName('ClientID').AsInteger:= fClientId;
  inherited;
end;

procedure TJournalListGui.RefreshTotals;
var
  fdCredit, fdDebit: Double;
begin
  inherited;
  CalcnShowFooter;
  fdCredit := FooterValue(qryMainCreditAmount.Fieldname);
  fdDebit := FooterValue(qryMainDebitAmount.Fieldname);
  edtBalance.Text:= FloatToStrF(fdDebit- fdCredit, ffCurrency, 15, 2);
end;

procedure TJournalListGui.SetAccountIdList(const Value: string);
begin
  fAccountIdList := Value;
  MakeQrymain;
  self.RefreshOrignalSQL;
end;

procedure TJournalListGui.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := QuotedStr('TransactionDate') + ' DESC CIS';
  BaseIndexFieldNames := QuotedStr('TransactionDate') + ' DESC CIS';
  qryMain.First;
  if fclientid<> 0 then
    Setcontrolfocus(edtBalance);
end;

procedure TJournalListGui.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TJournalListGui.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TJournalListGui.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

function TJournalListGui.ExpressDetailListName: String;
begin
  result := 'TJournalEnrtiesGUI';
end;

procedure TJournalListGui.FormShow(Sender: TObject);
begin
  inherited;

  GuiPrefs.DbGridElement[grdMain].RemoveFields('GJID');

  if not DevMode then begin
    lblBalance.Visible := False;
    edtBalance.Visible := False;
  end;

end;

Procedure TJournalListGui.MakeQrymain;
begin
    closedb(qryMain);
    qryMain.SQL.clear;
    qryMain.SQL.add('SELECT  ' );
    qryMain.SQL.add('a.GJID as GJID, ' );
    qryMain.SQL.add('TransactionDate  as TransactionDate, '  );
    qryMain.SQL.add('TransactionNo    as "Entry No", '  );
    qryMain.SQL.add('AccountName      as AccountName, '  );
    qryMain.SQL.add('AccountNumber    as AccountNumber, '  );
    qryMain.SQL.add('DebitAmount      as DebitAmount, '  );
    qryMain.SQL.add('CreditAmount     as CreditAmount, '  );
    qryMain.SQL.add('TaxAmount        as TaxAmount, '  );
    qryMain.SQL.add('ClassName        as ClassName, '  );
    qryMain.SQL.add('a.Memo           as "Journal Memo", '  );
    qryMain.SQL.add('b.EmployeeName   as EmployeeName, '  );
    qryMain.SQL.add('b.Memo           as memo, '  );
    qryMain.SQL.add('a.Approved       as Approved '  );
    qryMain.SQL.add('FROM tblgeneraljournal a '  );
    qryMain.SQL.add('INNER JOIN tblgeneraljournaldetails b USING(gjid) '  );
    qryMain.SQL.add('where  (TransactionDate Between :txtfrom AND :txtto) '  );
    qryMain.SQL.add('and ((:ClientID = 0) or (b.ClientID = :ClientID))');
    if fAccountIdList <> '' then
      qryMain.SQL.Add('and AccountID in (' + fAccountIdList + ')');
    qryMain.SQL.Add('Order by a.GJId desc');
end;
procedure TJournalListGui.FormCreate(Sender: TObject);
begin
  fClientId:= 0;
  fAccountIdList:= '';
  //fCleanSQL :=  //qryMain.SQL.Text;
  MakeQrymain;
  inherited;
  AddCalcColumn(qryMainDebitAmount.Fieldname, true);
  AddCalcColumn(qryMainCreditAmount.Fieldname, true);
  AddCalcColumn(qryMainTaxAmount.Fieldname, true);
end;

initialization
  RegisterClassOnce(TJournalListGui);
end.
