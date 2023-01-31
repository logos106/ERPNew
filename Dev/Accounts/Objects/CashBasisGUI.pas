unit CashBasisGUI;

interface

uses
  forms;

Function ResetSummarisedDate(const SummariseDate: TDateTime;Ownerform:TForm):Boolean;

implementation

uses
  SysUtils, AppEnvironment, TransactionsTable, dmMainGUI, EmployeeAccesses,
  CommonLib, Dialogs, CommonFormLib, UserUtilsClientObj, CommonDbLib;

Function ResetSummarisedDate(const SummariseDate: TDateTime;Ownerform:TForm):Boolean;
var
  TransactionTableObj: TTransactionTableObj;
  msg: string;
  //fdSumDate:TDatetime;
  function GetCurrentUserCount: integer;
  var
    s: string;
  begin
    result:= -1;
    if AppEnv.UtilsClient.GetDatabaseUserList(s, AppEnv.AppDb.Database,AppEnv.AppDb.UserName,true) then begin
      dtmMainGUI.dlgCurrentUsers.Items.CommaText:= s;
      Result := dtmMainGUI.dlgCurrentUsers.Items.Count;
    end;
  end;
begin
  Result := False;
  if not CanChangeClosingDate then begin
    CommonLib.MessageDlgXP_Vista(Format('You don''t have access to %s.',
      [AppEnv.AccessLevels.GetFormDescription('FnChangeClosingDate')]), mtInformation, [mbOK], 0);
  end else begin

    if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Summarised Transactions') then begin
      try
        (*if CommonLib.MessageDlgXP_Vista('Changing Summarised Dates will Remain For Twenty Four Hours. '+#13+#10+#13+#10+
                      'Batch Update Run Twenty Four Hours From Now Will Restore it Back To The End Of The Last Fiscal Year'+#13+#10+#13+#10+
                      'This Process May Take Several Minutes.'+#13+#10+#13+#10+'Are You Sure You Wish To Proceed ?',
                      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin*)
        CommonLib.MessageDlgXP_Vista('Changing Summarised Dates will Remain For Twenty Four Hours. '+#13+#10+#13+#10+
                      'Batch Update Run Twenty Four Hours From Now Will Restore it Back To The End Of The Last Fiscal Year'+#13+#10+#13+#10+
                      'This Process May Take Several Minutes.',
                      mtInformation, [mbok], 0) ;
          ShowUpdateBatchHint(Ownerform );
          try
            TransactionTableObj := TTransactionTableObj.Create(False);
            try
              TransactionTableObj.InitforRefreshTrnsTable;
              //fdSumDate :=AppEnv.CompanyPrefs.SummarisedTransDate;
              AppEnv.CompanyPrefs.SummarisedTransDate := SummariseDate;
              if TransactionTableObj.CleanRefreshTrnsTable(true, true) then
                if TransactionTableObj.CreatePermanentSummaryTable then begin
                  //AppEnv.CompanyPrefs.SummarisedTransDate:= fdSumDate;
                  if TransactionTableObj.CleanRefreshTrnsTable(true, false, true, true) then
                    Result := True;
                end;
            finally
              FreeandNil(TransactionTableObj);
            end;
          finally
            HideERPHint(Ownerform);
          end;
        (*end;*)
      finally
        AppEnv.UtilsClient.UnlockLogon;
      end;
    end
    else begin
      if msg = USERS_IN_SYSTEM_MESSAGE then begin
        if GetCurrentUserCount > 0 then begin
          dtmMainGUI.dlgCurrentUsers.Caption := CommonDbLib.GetSharedMyDacConnection.Database + ' Closing Date Update';
          dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
          dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
          dtmMainGUI.dlgCurrentUsers.Execute;
        end
        else begin
          MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time.', mtInformation, [mbOk], 0);
        end;
      end
      else begin
        MessageDlgXP_Vista('Unable To Summarise Dates, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
      end;
    end;
  end;
end;


end.
