unit GoLiveSchedulerThreadTask;
interface

uses
  ServerModuleThreadTask, DBBackupObj, JsonRpcTcpClient, ERPDBComponents;



type

  TGoLiveSchedulerThreadTask = class(TServerModuleThreadTask)
  private
    procedure EmailAllGoLiveReports(AConnection : TERPConnection);
    procedure EmailReport(Const AReportName : string; const AEmail : string; const aEmployeeName : string; aEmployeeId : integer;
      aSecretMail : boolean; const ACompanyName : string);
    procedure DoEmail(var ErrMsg : string; const AddressTo, Subject, Body : string;
                      const Attachment : string);
  protected
    procedure DoWork; override;
  end;

implementation

uses
  Windows, ShellApi, ERPDbListObj, LogMessageTypes, SysUtils, ScheduledreportObj, ActiveX,
  MySQLConst, AppEnvironmentVirtual, PrintTemplateBaseObj, ReportSQLBase,
  TempTableUtils,
  IdSMTP, IdMessage, IdAttachmentFile, MailServerConst;
var
  aLock : integer;
{ TReportSchedulerThreadTask }


const
  csGoLiveSql = '{CompanyInfo}SELECT  CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,'+
            'CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN,   concat("Ph: ", CO.PhoneNumber) AS Phone,' +
            'concat("Fax: " , CO.FaxNumber) AS Fax, concat("Email: " , CO.email) as EmailAddress, CO.URL , ' +
            'concat("Website: " , CO.URL) as WebAddress, Concat (if(ifnull(CO.CompanyName,"") <> "" , ' +
            'concat(CO.CompanyName , "\n"), ""), ' +
            'if(ifnull(CO.Address,"") <> "" , concat(CO.Address,   "\n"), ""),if(ifnull(CO.Address2,"") <> "" ,' +
            'concat(CO.Address2 , "\n"), ""),if(ifnull(CO.City,"") <> "" , concat(CO.City , "\n"), ""),' +
            'if(ifnull(CO.State,"") <> "" , concat(CO.State , "\n"), ""),if(ifnull(CO.Postcode,"") <> "" , ' +
            'concat(CO.Postcode , "\n"), "")) NamenAddress,concat_ws(", ",  nullif(CO.Address, ""),  ' +
            'nullif(CO.Address2, ""), nullif(CO.Address3, ""), nullif(CO.City  , ""),  ' +
            'nullif(concat(CO.State  , " "  , CO.postCode  ),"") , nullif(CO.country  , "") ) as CompAddress, ' +
            'concat_ws(", ",  nullif(CO.POBox  , ""),  nullif(CO.POBox2  , ""), nullif(CO.POBox3  , ""), ' +
            'nullif(CO.POCity, ""),  nullif(concat(CO.POState, " "  , CO.POPostcode),"") , ' +
            'nullif(CO.POCountry, "") ) as CompbillAddress , CO.email , convert("2016-09-29 00:00:00",dateTime)  as DateFrom,' +
            'convert("2016-09-29 00:00:00",dateTime)  as DateTo,' +
            '"Admin ." as LoggedInUser  FROM tblCompanyInformation AS CO  ' +

            '~|||~{GoLive} Select G.GoLiveId, G.ModuleId, G.EmployeeId, G.Days, G.RequiredBy, G.StepNo, G.OrderNo, ' +
            'case G.Addition when NULL then G.Description when "" then G.Description else Concat(G.Addition, ": ", G.Description) end as Description, ' +
            'case G.Done when 0 then "" else "X" end as Done,G.StepType, G.RequiredTime, ' +
            'ifnull(E.EmployeeName, ifnull(EE.EMployeeName, "")) EmployeeName,ifnull(M.TrainingModuleName, "") as ModuleName, ' +
            'case G.StepType when 0 then CONCAT("Training: ", M.TrainingModuleName) when 1 then "Addition" when 2 then "Summary" when 3 then "Task" end as StepName, ' +
            'ifnull(GM.GoLiveModuleId, 0) GoLiveModuleId ' +
            'from tblGoLive G left join tblEmployees E on E.Employeeid=G.Employeeid ' +
            'left join tbltrainingmodules M on M.TrainingModuleId=G.ModuleId left join tblGoLiveModules GM on G.GoLiveId = GM.GoLiveId left join tblEmployees EE on GM.EmployeeId = EE.EmployeeId';

procedure TGoLiveSchedulerThreadTask.DoEmail(var ErrMsg : string; const AddressTo, Subject, Body : string;
const Attachment : string);
var
  exMessage: TIdMessage;
  exSMTP: TIdSMTP;
  indyAttachment : TIdAttachmentFile;
begin
  ErrMsg:= '';

  exMessage := TIdMessage.Create(nil);
  exSMTP := TIdSMTP.Create(nil);
  try
    try
      exSMTP.Host := System_SMTPHost;
      exSMTP.Port := System_SMTPPort;
      exSMTP.Username := System_SMTPUsername;
      exSMTP.Password := System_SMTPPassword;
      exMessage.From.Text := exSMTP.Username;
      exMessage.From.Name := 'True ERP System';

//      exMessage.From.Text := FromAddress;
 //     if exMessage.From.Text  ='' then exMessage.From.Text  :=exSMTP.Username;
      exMessage.Recipients.EMailAddresses := AddressTo;
      exMessage.Subject := Subject;
      exMessage.Body.Add(Body);
      if FileExists(Attachment) then
      begin
        indyAttachment := TIdAttachmentFile.Create(exMessage.MessageParts, Attachment);
        indyAttachment.FileIsTempFile := true;
      end;

      exSMTP.Connect;
      if exSMTP.Connected then begin
        exSMTP.Send(exMessage);
      end;
    except
        on E:Exception do begin
          ErrMsg := 'Report  could not be emailed this time. '+E.Message;
        end;
    end;
  finally
    FreeAndNil(exMessage);
    FreeAndNil(exSMTP);
  end;

end;

procedure TGoLiveSchedulerThreadTask.DoWork;
var
  dbList: TERPDbList;
begin
  if InterlockedIncrement(aLock) > 1 then
  begin
    InterlockedDecrement(aLock);
    exit;
  end;
  Try
    Log('Starting Scheduled GoLive Reports check ...',ltDetail);
    dbList := TERPDbList.Create(MySQLServer);
    try
     if dbList.First then begin
         repeat
           if Terminated then begin
             Log(ClassName + ' terminated, aborting Scheduled GoLive Reports check.',ltDetail);
             exit;
           end;

            Log(' Scheduled GoLive Reports  : Checking in database ' + dbList.Connection.Database, ltDetail);
//            sched := TScheduledreportObj.Create(nil);
            CoInitialize(nil);
            try
//              sched.OnLog := Log;
              //sched.
              EmailAllGoLiveReports(dblist.Connection);
              Log(' Scheduled Reports : Done database ' + dbList.Connection.Database, ltDetail);
            finally
//              sched.Free;
              CoUninitialize();
            end;
         until not dbList.Next;
     end;
    finally
      dbList.Free;
      Log('Finished Scheduled GoLive Reports check.',ltDetail);
      InterlockedDecrement(aLock);
    end;
  except
    on e: exception do begin
      Log('Error checking Scheduled GoLive Reports: ' + e.Message, ltError);
    end;
  end;
end;

procedure TGoLiveSchedulerThreadTask.EmailAllGoLiveReports(AConnection : TERPConnection);
const
  csReportQry = 'select S.EndDate, ifnull(S.LastEmailedDate, 0) as LastEmailedDate, S.ReportTime,'#13#10+
                'E.EmployeeName as Name, E.Email as Email, E.EmployeeId, C.CompanyName'#13#10+
                'from tblCompanyInformation C, tblGoLiveSchedule S'#13#10+
                'inner join tblEmployees E on E.EmployeeId = S.EmployeeId'#13#10+
                'where S.Report="%s" and'#13#10+
                '((S.LastEmailedDate is null ) or (S.LastEmailedDate < CurDate() ))and'#13#10+
                'EndDate >= CurDate()'#13#10+
                'and ReportTime <= CurTime()';
var
  qry1 : TERPQuery;
  Qry:TERPquery;
//  qry2 : TERPQuery;
  lSrcReports : integer;
//  lErr,
//  lBody : string;
begin
   TAppEnvVirtualGUI(AppEnvVirt).SharedDbConnection := AConnection;

   Qry1 := TERPquery(AppEnvVirt.Obj['CommonDbLib.TempMyQuery']);
   try
     // qry1 - ERP email addresses to send copies to
     qry1.SQL.Clear;
     qry1.SQL.Text := 'SELECT F.*, CompanyName from tblEmailForwards F, tblCompanyInformation where task="GoLive"';
     qry1.Open;
     // qry2: EmployeeIDs that have TrainingModules assigned and not yet closed
     {
     qry2 := TERPquery(AppEnvVirt.Obj['CommonDbLib.TempMyQuery']);
     qry2.SQL.Clear;
     qry2.SQL.Text := 'SELECT GM.EMployeeId FROM tblGoLive G LEFT JOIN tblGoLiveModules GM on GM.GoLiveId=G.GoLiveId';
     qry2.SQL.Add('WHERE G.Done=0 and G.StepType=0');
     qry2.Open;
     try
     }
       qry := TERPquery(AppEnvVirt.Obj['CommonDbLib.TempMyQuery']);
       try
         qry.SQL.Text := Format(csReportQry, ['GoLive Common']);
         qry.Open;
         lSrcReports := qry.RecordCount;
         while not qry.Eof do
         begin
           EmailReport('GoLive Common', qry.FieldByName('Email').AsString, qry.FieldByName('Name').AsString,  qry.FieldByName('EmployeeId').asInteger, false, qry.FieldByName('CompanyName').asString);
           qry.Edit;
           qry.FieldByName('LastEmailedDate').AsString := FormatDateTime(MysqlDateFormat,Date());
           qry.Post;
           Qry.Next;
         end;

         // One off for all extra guys
         if lSrcReports > 0 then
         begin
           qry1.First;
           while not qry1.eof do
           begin
             EmailReport('GoLive Common', qry1.FieldByName('Email').AsString, '', 0, false, qry1.FieldByName('CompanyName').asString);
             qry1.Next;
           end;
         end;

         qry.Close;
         qry.SQL.Clear;
         qry.SQL.Text := Format(csReportQry, ['GoLive']);
         qry.Open;
         while not qry.Eof do
         begin
{           if qry2.Locate('EmployeeId', qry.FieldByName('EmployeeId').AsInteger, []) then
           begin }
             EmailReport('GoLive', qry.FieldByName('Email').AsString, qry.FieldByName('Name').AsString,
                          qry.FieldByName('EmployeeId').asInteger, false, qry.FieldByName('CompanyName').asString);
             qry.Edit;
             qry.FieldByName('LastEmailedDate').AsString := FormatDateTime(MysqlDateFormat,Date());
             qry.Post;

             qry1.First;
             while not qry1.Eof do
             begin
               EmailReport('GoLive', qry1.FieldByName('Email').AsString, qry.FieldByName('Name').AsString, qry.FieldByName('EmployeeId').asInteger,
                           true, qry1.FieldByName('CompanyName').asString);
               qry1.Next;
             end;
{           end
           else
           begin
             lBody := 'Sheduled Report For ' + qry.FieldByName('Name').AsString + ' was not sent since no open Training Modules'+
                      ' assigned to the employee.';
             qry1.First;
             while not qry1.eof do
             begin
               DoEmail(lErr, qry1.FieldByName('Email').AsString,'Sheduled GoLive Email For ' + qry.FieldByName('Name').AsString, lBody, '');
               if lErr <> '' then
               begin
                 Log('Failed sending GoLive Report to' + qry1.FieldByName('Email').AsString);
                 Log(lErr);
               end;
               qry1.Next;
             end;
           end;
           }
         Qry.Next;
         end;
       finally
         qry.ClosenFree;
       end;
{     finally
       qry2.ClosenFree;
     end; }
   finally
     Qry1.ClosenFree;
   end;
end;

procedure TGoLiveSchedulerThreadTask.EmailReport(const AReportName,
  AEmail, AEmployeeName: string; aEmployeeId : integer; aSecretMail : boolean; const aCompanyName : string);
var
  OutGoingFileName: string;
  errmsg:String;
  lPrintTemplate : TPrintTemplateBase;
  lSql : string;
  lSQLSupplied : boolean;
  lpFileOp: TSHFileOpStruct;
  lHeader,
  lBody : string;

begin
  OutGoingFileName:= '';
//  try
    lPrintTemplate := TPrintTemplateBase.Create;
    try
      if SameText(AReportName,'GoLive') then
      begin
        lSQL := csGoLiveSQL + ' AND GM.EmployeeId=' + IntToStr(AEmployeeId);
        lSQLSupplied := true;
      end
      else
      begin
        lSql := '';
        lSQLSupplied := false;
      end;

      OutGoingFileName := GetSharedMyDacConnection.Database+ TempTableUtils.GetTemporaryTableNameSuffix(AppEnvVirt.str['Employee.LogonName']) + '.PDF';
      OutGoingFileName := StringReplace(OutGoingFileName , '"' , '',[rfReplaceAll,rfIgnoreCase]);
      OutGoingFileName := StringReplace(OutGoingFileName , '*' , '',[rfReplaceAll,rfIgnoreCase]);
      OutGoingFileName := StringReplace(OutGoingFileName , '/' , '',[rfReplaceAll,rfIgnoreCase]);
      OutGoingFileName := StringReplace(OutGoingFileName , ':' , '',[rfReplaceAll,rfIgnoreCase]);
      OutGoingFileName := StringReplace(OutGoingFileName , '<' , '',[rfReplaceAll,rfIgnoreCase]);
      OutGoingFileName := StringReplace(OutGoingFileName , '>' , '',[rfReplaceAll,rfIgnoreCase]);
      OutGoingFileName := StringReplace(OutGoingFileName , '?' , '',[rfReplaceAll,rfIgnoreCase]);
      OutGoingFileName := StringReplace(OutGoingFileName , '\' , '',[rfReplaceAll,rfIgnoreCase]);
      OutGoingFileName := StringReplace(OutGoingFileName , '|' , '',[rfReplaceAll,rfIgnoreCase]);

      lPrintTemplate.ReportSQLSupplied := lSQLSupplied;
      lPrintTemplate.SaveReport(AReportName, lSQL, true, 'PDF');

        if not FileExists(WinTempDir  + OutGoingFileName) then begin
          copyfile(PChar( WinTempDir  + 'EmailReport.PDF'), PChar( WinTempDir  + OutGoingFileName), false);
        end;

        Sleep(1000);

        if not ASecretMail then
        begin
          lBody := 'This is an automatically generated email from ' + ACompanyName + '''s GoLive report scheduler.';
          lHeader := AReportName + ' : email scheduled for ' + formatdatetime(FormatSettings.shortDateformat, date);
        end
        else if AEmployeeId = 0 then
        begin
          lBody := 'This is an automatically generated email from ERP Software from the GoLive report scheduler.'#13#10 +
                   'Company Name Is: ' + ACompanyName;
          lHeader :=  AReportName + ' : Summary email scheduled for ' + formatdatetime(FormatSettings.shortDateformat, date);
        end
        else
        begin
          lBody :=  'This is scheduled reminder email for ' + AEmployeeName + #13#10'Company Name Is: ' + ACompanyName;
          lHeader := AReportName + ' : email scheduled for ' + formatdatetime(FormatSettings.shortDateformat, date);
        end;
        (*
        if not ASecretMail then
          DoEmail(ErrMsg, AEmail, lHeader, lBody, WinTempDir  + OutGoingFileName)
        else if AEmployeeId = 0 then
          DoEmail(ErrMsg, AEmail, lHeader, lBody, WinTempDir  + OutGoingFileName)
        else
          DoEmail(ErrMsg, AEmail, lHeader, lBody, WinTempDir  + OutGoingFileName);
        *)
        DoEmail(ErrMsg, AEmail, lHeader, lBody, WinTempDir  + OutGoingFileName);
        if ErrMsg <> '' then
        begin
          Log('Failed sending ' + AreportName + ' to ' + aEmail);
          Log(ErrMsg);
        end;
  finally
    FillChar(lpFileOp, SizeOf(lpFileOp), #0);
    lpFileOp.wFunc := FO_DELETE;
    lpFileOp.pfrom := PChar(WinTempDir + '*.pdf' + #0);
    lpFileOp.pto := PChar(WinTempDir);
    lpFileOp.fFlags := FOF_NOCONFIRMATION or FOF_FILESONLY or FOF_SILENT;
    // Perform Operation
    SHFileOperation(lpFileOp);
    lPrintTemplate.Free;
  end;

end;

initialization
  aLock := 0;
end.
