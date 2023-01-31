unit JobProfitansLoss;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProfitandLossReportForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwcheckbox,
  wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript,
  MyScript, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TJobProfitansLossGUI = class(TProfitandLossGUI)
    qryCustomers: TERPQuery;
    Label5: TLabel;
    cboClients: TwwDBLookupCombo;
    Label1: TLabel;
    chkAllclients: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboClientsCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure dtFromChange(Sender: TObject);
    procedure chkIncludehistoryClick(Sender: TObject);
    procedure chkAllclientsClick(Sender: TObject);
  private

  Protected
    function clientID:Integer;Override;
//    procedure CleanRefresh_PL_Table;Override;
    function formprefix :String; Override;
    procedure PriortoClosingdateMsg;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery;override;

  end;

implementation

uses CommonLib, CommonDbLib, AppEnvironment, tcConst, dateutils,
  TransactionsTable , SystemLib;

{$R *.dfm}
{ TJobProfitansLossGUI }

procedure TJobProfitansLossGUI.cboClientsCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  chkAllclients.checked := trim(cboClients.Text)= '';
  RefreshQuery;
end;

procedure TJobProfitansLossGUI.chkAllclientsClick(Sender: TObject);
begin
  inherited;
    RefreshQuery;
end;

procedure TJobProfitansLossGUI.chkIncludehistoryClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol = chkIncludehistory then
    if IncludedataPriorToClosingDate  = false then
      lblmsg.caption := 'Please note that this report does not show any data prior to the closing date. ' +
                      '  The Current Closing Date is - ' + FormatDateTime('dddd, mmmm d, yyyy', AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*))
    else
      lblmsg.caption := '';

end;

//procedure TJobProfitansLossGUI.CleanRefresh_PL_Table;
//var
//  cmd: TERPCommand;
//  ctr, i:Integer;
//  pClass: pClassRec;
//  function TransTablename(Loopno :Integer):String;
//  begin
//    if ctr= 1 then result := 'tbltransactions' else result := 'tbltransactionsummarydetails';
//  end;
//
//begin
////  inherited;
//  ReportTransactionTableObj.CleanRefresh_PL_Table((*SelectedDepartments, *)filterdatefrom, filterdateto, fsTablename, FCFields ,clientID , IncludedataPriorToClosingDate);
//  if ClientId < 1 then exit;
//
//  { need to add bill COGS for bills linked to this job (ClientID) }
//  cmd := TERPCommand.Create(nil);
//  try
//    cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
//    for ctr:= 1 to 2 do begin
//      if (ctr=1) or (IncludedataPriorToClosingDate)  then begin
//          cmd.SQL.Add('insert into ' + fsTablename);
//          cmd.SQL.Add('(AccountID,Date,AccountType,Accounts,AccountName,Level1,Level2,Level3,Level4,');
//          //cmd.SQL.Add('`Default_AmountColumnEx`,`Default_AmountColumnInc`,');
//       for I := 0 to ReportTransactionTableObj.LstClass.Count - 1 do begin
//          pClass := ReportTransactionTableObj.LstClass.Items[I];
//          cmd.SQL.Add('`' + pClass^.ClassName +'_AmountColumnEx`,');
//          cmd.SQL.Add('`' + pClass^.ClassName +'_AmountColumnInc`,');
//       end;
//
//          cmd.SQL.Add('TotalAmountEx,TotalAmountInc,Ordered,');
//          cmd.SQL.Add('AccountHeaderOrder, AccountSub1Order,AccountSub2Order,AccountSub3Order,FilterDate,');
//          cmd.SQL.Add('FilterWeekday,FilterWeekdayNumber,FilterWeekNumber,FilterMonthNumber, FilterMonthName,FilterQuarterNumber,FilterYEAR)');
//          cmd.SQL.Add('SELECT AccountID,Date,AccountType,');
//          cmd.SQL.Add('IF(char_length(T.Level4)>0,Concat(Space(15),T.AccountName),IF(char_length(T.Level3)>0,Concat(Space(10),T.AccountName),IF(char_length(T.Level2)>0,Concat(Space(5),T.AccountName),Concat(Space(0),T.AccountName)))) as Accounts,');
//          cmd.SQL.Add('T.AccountName,T.Level1,T.Level2,T.Level3,T.Level4,');
//
//(*          cmd.SQL.Add('If((T.ClassID=1)  ,(CreditsEx - DebitsEx),0.00)   as "AmountEx1" ,');
//          cmd.SQL.Add('If((T.ClassID=1)  ,(CreditsInc - DebitsInc),0.00)   as "AmountInc1",');*)
//
//       for I := 0 to ReportTransactionTableObj.LstClass.Count - 1 do begin
//          pClass := ReportTransactionTableObj.LstClass.Items[I];
//          cmd.SQL.Add('If((T.ClassID=' + inttostr(pClass.ClassID) +')  ,(CreditsEx - DebitsEx),0.00)   as "AmountEx1" ,');
//          cmd.SQL.Add('If((T.ClassID=' + inttostr(pClass.ClassID) +')  ,(CreditsInc - DebitsInc),0.00)   as "AmountInc1",');
//       end;
//
//          cmd.SQL.Add('(CreditsEx - DebitsEx) as "Total Amount (Ex)" ,');
//          cmd.SQL.Add('(CreditsInc - DebitsInc) as "Total Amount (Inc)" ,');
//          cmd.SQL.Add('IF(char_length(T.Level3)>0,5,IF(char_length(T.Level2)>0,4, IF(char_length(T.Level1)>0,2,1))) as Ordered,');
//          cmd.SQL.Add('T.Level1 as AccountHeaderOrder,');
//          cmd.SQL.Add('T.Level2 as AccountSub2Order,');
//          cmd.SQL.Add('T.Level3 as AccountSub2Order,');
//          cmd.SQL.Add('T.Level4 as AccountSub3Order,');
//          cmd.SQL.Add('Date as FilterDate,');
//          cmd.SQL.Add('DAYNAME(Date) as FilterWeekday,');
//          cmd.SQL.Add('WEEKDAY(Date) as FilterWeekdayNumber,');
//          cmd.SQL.Add('WEEK(Date,3)  AS FilterWeekNumber,');
//          cmd.SQL.Add('MONTH(Date) as FilterMonthNumber,');
//          cmd.SQL.Add('MONTHNAME(Date) as FilterMonthName,');
//          cmd.SQL.Add('QUARTER(Date) AS FilterQuarterNumber,');
//          cmd.SQL.Add('YEAR(Date) AS FilterYEAR');
//          cmd.SQL.Add('FROM ' + TransTablename(ctr) +'  T');
//          cmd.SQL.Add('inner join tblPurchaseLines PL on T.PurchaseLineID = PL.PurchaseLineID and PL.CustomerJobID = ' + IntToStr(ClientID));
//          cmd.SQL.Add('Where char_length(T.AccountName)>0 AND (AccountType = "COGS")');
//          if (ctr=1) and (IncludedataPriorToClosingDate)  then cmd.SQL.Add('AND T.Type <> "Closing Date Summary"');
//          cmd.SQL.Add(';');
//      end;
//    end;
//    cmd.Execute;
//  finally
//    cmd.Free;
//  end;
//end;

function TJobProfitansLossGUI.clientID: Integer;
begin
  result := -1;
  if chkAllclients.checked then Exit;
  if cboClients.text ='' then exit;
  if not Qrycustomers.locate('company' , cboClients.text , []) then exit;
  Result := qryCustomers.fieldbyname('ClientID').asInteger;
end;

procedure TJobProfitansLossGUI.dtFromChange(Sender: TObject);
begin

  if (FilterDateFrom <= AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*)) and (IncludedataPriorToClosingDate =False) then begin
    if Screen.ActiveControl = dtFrom then  PriortoClosingdateMsg;
    dtfrom.date := incday(AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*),1);
  end;
  inherited;
end;

procedure TJobProfitansLossGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryCustomers.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCustomers.Open;
  PnlSQLObj.ClientID := self.clientID;
  lblmsg.caption := 'Please note that this report does not show any data prior to the closing date. ' +
                      '  The Current Closing Date is - ' + FormatDateTime('dddd, mmmm d, yyyy', AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*));
end;

function TJobProfitansLossGUI.formprefix: String;
begin
  Result := 'JPnL';
end;

procedure TJobProfitansLossGUI.FormShow(Sender: TObject);
begin
  inherited;
  if not(qryCustomers.active) then qryCustomers.open;
  //if cboClients.text = '' then cboClients.text :=qryCustomers.fieldbyname('Company').asString;
end;

procedure TJobProfitansLossGUI.PriortoClosingdateMsg;
begin
  if IncludedataPriorToClosingDate = False then
    CommonLib.MessageDlgXP_Vista('The From Date Selected Is Prior To The Closing Date.' + NL+NL+
        ' - Transactions Prior To Closing Date Are NOT included  '+NL+'in this report' +NL+NL+
        ' - Current Closing Date - ' + FormatDateTime('dddd, mmmm d, yyyy', AppEnv.CompanyPrefs.SummarisedTransDate(*ClosingDate*)),
        mtInformation, [mbOK], 0);
end;

procedure TJobProfitansLossGUI.RefreshQuery;
begin
  //inherited;
  RefreshAll;
end;
procedure TJobProfitansLossGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  chkAllClients.checked     := StrToBoolean(GuiPrefs.Node['General.AllClients'].AsString);
  if chkAllClients.checked then cboClients.text :=  ''
  else begin
    if GuiPrefs.Node.Exists('CleintID') then
      if Qrycustomers.locate('clientID' , GuiPrefs.Node['CleintID'].asInteger  , []) then
          cboClients.text :=  qryCustomers.fieldbyname('Company').asString;

  end;
end;
procedure TJobProfitansLossGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['General.AllClients'].AsString  := BooleanToStr(chkAllClients.checked);
  GuiPrefs.Node['CleintID'].asInteger := clientID;
end;


initialization
  RegisterClassOnce(TJobProfitansLossGUI);

end.

