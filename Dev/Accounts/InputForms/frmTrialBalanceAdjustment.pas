unit frmTrialBalanceAdjustment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DAScript, MyScript, ERPdbComponents, StdCtrls,
  ProgressDialog, DB, MemDS, DBAccess, MyAccess, ImgList, AdvMenus, DataState,
  AppEvnts, SelectionDialog, Menus, ExtCtrls, BaseListingForm, kbmMemTable,
  CustomInputBox, wwDialog, Wwlocate, ActnList, PrintDAT, AdvOfficeStatusBar,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TfmTrialBalanceAdjustment = class(TBaseListingGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    qryMaintype: TWideStringField;
    qryMaindate: TDateField;
    qryMainDebitsEx: TFloatField;
    qryMainCreditsEx: TFloatField;
    qryMainDebitsInc: TFloatField;
    qryMainCreditsInc: TFloatField;
    qryMainClassID: TIntegerField;
    qryMainExamt: TFloatField;
    qryMainincamt: TFloatField;
    qryMainsaleId: TIntegerField;
    qryMainsaleLineId: TIntegerField;
    qryAccount: TERPQuery;
    DNMPanel1: TDNMPanel;
    Label2: TLabel;
    cboStandardCostPurchaseAdjustmentAccountID: TwwDBLookupCombo;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboStandardCostPurchaseAdjustmentAccountIDCloseUp(Sender: TObject;
      LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
  private
      fsTablename:String;
  Protected
    procedure SetGridColumns; Override;
  public
      Procedure RefreshQuery;Override;
    { Public declarations }
  end;


implementation

uses CommonDbLib, DbSharedObjectsObj, TempTableUtils, BusobjJournal, BusObjBase,
  tcConst, CommonLib, LogLib, AppEnvironment;

{$R *.dfm}

procedure TfmTrialBalanceAdjustment.Button1Click(Sender: TObject);
var
  JE: TJournalEntry;
  aconnection : TMyDAcDataconnection;
  fsTRFixAccount:String;

  function TRFixAccount :String;
  var
    qry: TERPQuery;
  begin
    if (fsTRFixAccount = '') and (Appenv.companyprefs.TrialBalanceAdjustAccount<>0) then begin
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
         qry.sql.text := 'Select accountname from tblchartofaccounts where Accountid = '+ inttostr(Appenv.companyprefs.TrialBalanceAdjustAccount);
         qry.open;
         fsTRFixAccount := qry.fieldbyname('accountname').AsString;
(*         if fsTRFixAccount = '' then begin
          qry.close;
          qry.sql.text := 'Select accountname from tblchartofaccounts where accountname = '+ quotedstr('Stock Adjustment');
          qry.open;
          fsTRFixAccount := qry.fieldbyname('accountname').AsString;
         end;*)
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
    end;
    result := fsTRFixAccount;
  end;
  function currentclassID:Integer;
  begin
      if qrymainclassid.asInteger <> 0 then result :=qrymainclassid.asInteger
      else result :=  AppEnv.DefaultClass.Classid;
  end;
  Function JELinesExists:Boolean;
  var
    qry: TERPQuery;
  begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      qry.sql.text := 'Select * from tblgeneraljournaldetails '+
                    ' where AccountName =' + quotedstr(TRFixAccount)+
                    ' and   ClassID = ' +inttostr(currentclassID)+
                    ' and   Memo = ' +quotedstr ( Qrymaintype.asString +'-' +
                                                  inttostr(qrymainsaleId.asinteger)+'-'+
                                                  inttostr(qrymainsalelineId.asinteger)+'-' +
                                                  FormatDateTime('yyyy-mm-dd hh:nn:ss' , qrymaindate.asDatetime));
      qry.Open;
      result := qry.recordcount >0;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  end;
begin
  if Appenv.companyPrefs.TrialBalanceAdjustAccount =0 then begin
    MessageDlgXP_Vista('Please Choose the Account for Journal Entries', mtInformation, [mbOK], 0);
    Setcontrolfocus(cboStandardCostPurchaseAdjustmentAccountID);
    Exit;
  end;

  fsTRFixAccount:='';
  if TRFixAccount = '' then begin
    MessageDlgXP_vista('Please Choose an Expense account for the adjustments in Preferences-> Accounts', mtWarning, [mbOK], 0);
    Exit;
  end;

  if MessageDlgXP_Vista('This will Create Journal Entries for all these Lines. Do you wish To Continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

  try
    inherited;
    
      if qrymain.recordcount >0 then begin
        qrymain.first;
        showProgressbar(waitmsg , qrymain.RecordCount);
        try
            aconnection := TMyDAcDataconnection.Create(Self);
            try
              aconnection.BeginTransaction;
              try
                aconnection.Connection := GetNewMyDacConnection(self);
                clog('');
                while qrymain.eof = false do begin
                    JE:= TJournalEntry.Create(self);
                    try
                      JE.Connection := aconnection;
                      JE.Load(0);
                      try
                        JE.checkApprovalLevels := False;
                        JE.New;
                        JE.TransactionDate := qrymaindate.AsDateTime;
                        JE.TransactionNo := 'TB Fix' ;
                        JE.postdb;
                        While (JE.TransactionDate = qrymaindate.AsDateTime) and (qrymain.EOf = False) do begin
                          stepProgressbar(formatDateTime(FormatSettings.shortdateformat , qrymaindate.AsDateTime) +' - ' + inttostr(qrymain.RecNo) +' of ' + inttostr(qrymain.RecordCount));
                          if (round(qrymainDebitsEx.AsFloat  - qrymainCreditsEx.AsFloat,5) <> 0) or
                              (round(qrymainDebitsinc.AsFloat  - qrymainCreditsinc.AsFloat,5) <> 0) then begin
                              if not(JELinesExists) then begin
                                  JE.Lines.New;
                                  JE.Lines.AccountName := TRFixAccount;
                                  JE.Lines.DebitAmount    :=  0-(qrymainDebitsEx.AsFloat  - qrymainCreditsEx.AsFloat);
                                  JE.Lines.DebitAmountInc :=  0-(qrymainDebitsinc.AsFloat - qrymainCreditsinc.AsFloat);
                                  if qrymainclassid.asInteger <> 0 then JE.Lines.ClassID :=qrymainclassid.asInteger
                                  else JE.Lines.ClassID :=  AppEnv.DefaultClass.Classid;
                                  JE.Lines.memo := Qrymaintype.asString +'-' + inttostr(qrymainsaleId.asinteger)+'-'+
                                                    inttostr(qrymainsalelineId.asinteger)+'-' +FormatDateTime('yyyy-mm-dd hh:nn:ss' , qrymaindate.asDatetime);
                                  JE.Lines.PostDB;
                                  logtext('Line added:' +  JE.Lines.AccountName +',' +
                                                            floattostr(JE.Lines.DebitAmount)+','+
                                                            inttostr(JE.Lines.ClassID)+','+
                                                            JE.Lines.memo);
                              end else begin
                                  logtext('Line exits :' +  TRFixAccount +',' +
                                                            floattostr(0-(qrymainDebitsEx.AsFloat  - qrymainCreditsEx.AsFloat))+','+
                                                            inttostr(currentclassID)+','+
                                                             Qrymaintype.asString +'-' + inttostr(qrymainsaleId.asinteger)+'-'+
                                                    inttostr(qrymainsalelineId.asinteger));
                              end;
                          end else begin
                          end;
                          qrymain.next;
                        end;
                        IF JE.Lines.Count =0 then
                          JE.delete;
                      finally
                        Freeandnil(JE);
                      end;
                    finally
                      Freeandnil(JE);
                    end;

                end;
                aconnection.CommitTransaction;
              Except
                on E:Exception do begin
                  aconnection.RollbackTransaction;
                end;
              end;
            finally
              freeandnil(aconnection);
            end;
        finally
          HideProgressbar;
        end;
      end;



  finally
  end;

end;
procedure TfmTrialBalanceAdjustment.cboStandardCostPurchaseAdjustmentAccountIDCloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  Appenv.companyPrefs.TrialBalanceAdjustAccount :=qryAccount.fieldbyname('accountID').asInteger;
end;

procedure TfmTrialBalanceAdjustment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
action := cafree;
end;

procedure TfmTrialBalanceAdjustment.FormCreate(Sender: TObject);
begin
  fsTablename := commondbLib.GetUserTemporaryTableName('tbfix' );
//  qrymain.sql.text := 'select * from '+ fsTablename +' order by date , classid';
  qrymain.sql.text := '  select * from '+ fstablename+' '+
                      ' where (abs(ifnull(Examt,0))> 0.01 or abs(ifnull(incamt,0)) > 0.01 ) '+
                      ' order by date, classid';

  inherited;
  SearchMode:= smFullList;
  HaveDateRangeSelection := False;
  if qryAccount.Active = false then qryAccount.connection := GetSharedMyDacConnection;
end;

procedure TfmTrialBalanceAdjustment.FormDestroy(Sender: TObject);
begin
    TempTableUtils.DestroyUserTemporaryTable(GetSharedMydacConnection, fstablename);

  inherited;

end;

procedure TfmTrialBalanceAdjustment.FormShow(Sender: TObject);
begin
  inherited;
  opendb(qryAccount);
  if Appenv.companyPrefs.TrialBalanceAdjustAccount <>0 then
    if qryAccount.locate('accountID' , Appenv.companyPrefs.TrialBalanceAdjustAccount , []) then
      cboStandardCostPurchaseAdjustmentAccountID.text :=qryAccount.fieldbyname('accountname').asString;

end;

procedure TfmTrialBalanceAdjustment.RefreshQuery;
begin
  with scriptmain do begin
      SQL.clear;
      SQL.add('Drop table if exists '+ fstablename+'; ');
      SQL.add('create table '+ fstablename+
              ' SELECT trans.type, trans.date, trans.classid,saleId, saleLineId, '+
              ' sum(IF ( CreditsEx -DebitsEx  >0.00 ,  CreditsEx-DebitsEx  ,0.00)) as CreditsEx , '+
              ' sum(IF ( CreditsEx -DebitsEx  <0.00 ,  DebitsEx-CreditsEx  ,0.00))  as DebitsEx  , '+
              ' sum(IF ( CreditsInc-DebitsInc >0.00 ,  CreditsInc-DebitsInc,0.00))  as CreditsInc, '+
              ' sum(IF ( CreditsInc-DebitsInc <0.00 ,  DebitsInc-CreditsInc,0.00))  as DebitsInc '+
              ' FROM tbltransactions as Trans '+
              ' where type = "Manufacturing" '+
              ' Group By type, date , classid,saleId, saleLineId;');

      SQL.add('Alter table '+ fstablename+' add column Examt double;');
      SQL.add('Alter table '+ fstablename+' add column incamt double;');
      SQL.add('update '+ fstablename+' set examt = ifnull(CreditsEx,0) - ifnull(debitsEx,0);');
      SQL.add('update '+ fstablename+' set incamt = ifnull(Creditsinc,0) - ifnull(debitsinc,0);');
      clog(sql.text);
      showProgressbar(waitmsg , 3);
      try
        stepProgressbar;
        Execute;
      finally
        hideProgressbar;
      end;
    end;
    inherited;
end;

procedure TfmTrialBalanceAdjustment.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainClassID.fieldname);
  RemoveFieldfromGrid(qryMainsaleLineId.fieldname);

end;

initialization
  RegisterClassOnce(TfmTrialBalanceAdjustment);

end.
