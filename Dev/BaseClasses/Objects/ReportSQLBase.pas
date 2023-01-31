unit ReportSQLBase;

interface

{$I ERP.inc}

uses
  ProgressInfoObj, classes, UserLockObj ,ERPdbComponents,  GuiPrefReaderObj,
  PrintTemplateBaseObj, JSONObject, sysutils, DAScript;

type
    TEmailReport = Class(TComponent)
      Private
        fMailConfig : TERPQuery;
        function getMailConfig: TERPQuery;
      Protected
      Public
        Constructor Create(AOwner:Tcomponent);Override;
        Property MailConfig : TERPQuery read getMailConfig write fMailConfig;
        function EmailReport(var ErrMsg:String; const FromAddress, ToAddress, subject, Bodytext, Attachingfile:String ) : boolean;
    End;

    TReportSQLBaseClass = class of TReportSQLBase;
    TOnChangeToDate = Procedure(Const Value:TdateTime) of Object;

    TReportSQLBase = Class(TComponent)
      Private
        fdDatefrom :TDatetime;
        fdDateto:TDatetime;
        fsBaseTemptablename:String;
        fsTemptablename:String;
        fUserLock: TUserLock;
        fsErrorMsg :String;
        fbReportonForeignCurrency:Boolean;
        fGuiPrefs: TFormGuiPrefReader;
        fbDateRangeSupplied :Boolean;
        fiEmployeeID:Integer;
        fqryPersonalPrefs :TERPQuery;
        fsReportToPrint:String;
        fReportObj:TERPQuery;
        fScheduleforEmployee : TERPQuery;
        fPrintTemplate: TPrintTemplateBase;
        fbReportSQLSupplied :Boolean;
        fsReportClassName:String;
        fSharedConnection: TERPConnection;
        function GetProgressDlg: TProgressInfo;
        function getReportonForeignCurrency: boolean;Virtual;
        function getReportToPrint: String;
        function getreportObj: TERPQuery;
        function getScheduleforEmployee :TERPQuery;
        function DoEmailreport(RecipientAddress, reportType, sSQL, reportfilename: String): boolean;
        Function SaveTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const FileType: string; const FileName: string = 'EmailReport'; MasterDetailLink: TJsonObject = nil):Boolean;
        function getPrintTemplate: TPrintTemplateBase;
        function getformID(Const fFormName: String): Integer;
        procedure SetReportClassNAme(const Value: String);
        Function NextDueDate(const  scheduleID:Integer):TDateTime;
        function getEmployeeEmail: String;
        function TemplateTypeName(const TypeID: Integer): String;
        procedure DeleteFiles(const Path, Mask: string);
        procedure setFCOnreport(const Value: TERPQuery);

        //procedure IgnoreScriptError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
      Protected
        fQry_ForeigncurrecnyonReport: TERPQuery;
        formID:Integer;
        usingReportTables :Boolean;
        fOnChangeToDate :TOnChangeToDate;
        function GetTemplateSQL: String;virtual;abstract;
        Procedure clearErrors;
        Procedure AddError(Const Value:String);
        Procedure InitIt;Virtual;
        function GetFCOnreport :TERPQuery;
        function GetGuiPrefs: TFormGuiPrefReader;
        Function GetQryPersonalPrefs: TERPQuery;
        function GetUserLock: TUserLock;Virtual;
        function GetReportTypeID :Integer ; virtual;
        procedure LogEmailedReport(const TransactionID:Integer;const  UserID:Integer; const  EmailDate:TDateTime; const ReportType:String; const TransactionDescription :String; IsScheduledreport:boolean =False; Status:String = 'Success');
        function FCFields: String;
        Procedure AddFCFields(Tablename:String ='');Virtual;
        function StrToBoolean(const Value:String):Boolean;
        procedure SetEmployeeID(const Value: Integer);Virtual;
        procedure showProgressbar(Progressbarcaption: string; Progresscount: integer = 0);
        procedure stepProgressbar(Const ProgressbarMsg :String = '');
        procedure HideProgressbar;
        property ProgressDlg: TProgressInfo read GetProgressDlg;
        function TempQuery :TERPQuery;
        function TempScript :TERPScript;
      Public
        Constructor Create(AOwner:Tcomponent);Override;
        Destructor Destroy;override;
        Property Datefrom :TDatetime read fdDatefrom write fdDatefrom;
        Property DateTo   :TDatetime read fdDateTo write fdDateTo;
        Property TemplateSQL:String read getTemplateSQL;
        Property BaseTemptablename :String read fsBaseTemptablename write fsBaseTemptablename;
        Property Temptablename:String read fsTemptablename write fsTemptablename;
        Property ReportClassNAme:String read fsReportClassName write SetReportClassNAme;
        Property ErrorMsg :String read fsErrorMsg write fsErrorMsg;
        property ReportonForeignCurrency: boolean read getReportonForeignCurrency write fbReportonForeignCurrency;
        Property DateRangeSupplied :Boolean read fbDateRangeSupplied write fbDateRangeSupplied;
        Property EmployeeID: Integer read fiemployeeID write SetEmployeeID;
        Property FCOnreport :TERPQuery read getFCOnreport write setFCOnreport;
        Property GuiPrefs: TFormGuiPrefReader read getGuiPrefs write fGuiPrefs;
        Property qryPersonalPrefs: TERPQuery read getqryPersonalPrefs write fqryPersonalPrefs;
        Property UserLock: TUserLock read getUserLock write fUserLock;
        Property ReportToPrint :String read getReportToPrint write fsReportToPrint;
        Property ReportObj:TERPQuery read getreportObj write fReportObj;
        Property ScheduleforEmployee:TERPQuery read getScheduleforEmployee write fScheduleforEmployee;
        Property PrintTemplate: TPrintTemplateBase read getPrintTemplate write fPrintTemplate;
        Property ReportSQLSupplied :boolean read fbReportSQLSupplied write fbReportSQLSupplied;
        function EmailReport:boolean; overload;
        function EmailReport(const EmailID:String; reportToPrint:String):boolean;overload;
        function PrepareForReport:Boolean;virtual;
        Property ReportTypeID :Integer read getReportTypeID;
        Procedure ClosenfreeFCOnReport;
        Property OnChangeToDate :TOnChangeToDate read fOnChangeToDate write fOnChangeToDate;
        function DTFromStr: string;
        function DTToStr: string;
        function DFromStr: string;
        function DToStr: string;
        property SharedConnection: TERPConnection read fSharedConnection write fSharedConnection;
    End;

  function TempMyquery :TERPQuery;
  function TempMyScript :TERPScript;
  function GetSharedMyDacConnection: TERPConnection;
  function WinTempDir: string;


implementation

uses
  IdSMTP, IdMessage, tcConst,  Windows, AppEnvironmentVirtual,
  IdAttachmentFile ,MyAccess, TempTableUtils, MySQLConst, ShellAPI,
  SystemLib, SyncReportTableObj, UtilsLib, TemplateReportsTypeLib;


{ TReportSQLBase }

procedure TReportSQLBase.AddError(const Value: String);
begin
  if fsErrorMsg <> '' then fsErrorMsg := fsErrorMsg + NL;
  fsErrorMsg := fsErrorMsg + value;
end;
(*procedure TReportSQLBase.IgnoreScriptError(Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction);
begin
  inherited;
  Action := eaContinue;
end;*)

procedure TReportSQLBase.AddFCFields(Tablename:String ='');
var
  scr: TERPScript;
  qry: TERPQuery;
  colName: string;
begin
  if ReportonForeignCurrency then begin
    if Tablename = '' then Tablename := TempTablename;
    FCOnReport.first;
    scr := TempScript;
    qry := TempQuery;
    try
      while not FCOnreport.EOF do begin
        colName := FCOnReport.FieldByname('code').asString+ '_FCRate';
        qry.Close;
        qry.SQL.Text :=
          'SELECT * FROM information_schema.COLUMNS ' +
          'WHERE COLUMN_NAME = ' + QuotedStr(colName) + ' AND TABLE_NAME = ' + QuotedStr(Tablename);
        qry.Open;
        if qry.IsEmpty then begin
          scr.SQL.Add('Alter table ' + Tablename + ' Add column ' + colName + ' Double;');
        end;
        qry.Close;

        FCOnReport.Next;
      end;
      if scr.SQL.Count > 0 then
        scr.Execute;
    finally
      scr.Free;
      qry.Free;
    end;
  end;
end;

procedure TReportSQLBase.clearErrors;
begin
  fsErrorMsg:= '';
end;

procedure TReportSQLBase.ClosenfreeFCOnReport;
begin
  if fQry_ForeigncurrecnyonReport <> nil then
    fQry_ForeigncurrecnyonReport.closenfree;
  fQry_ForeigncurrecnyonReport:= nil;
end;

constructor TReportSQLBase.Create(AOwner: Tcomponent);
begin
  fSharedConnection := nil;
  fOnChangeToDate := nil;
  usingReportTables:= False;
  inherited Create(AOwner);
  fsErrorMsg:= '';
  fQry_ForeigncurrecnyonReport := nil;
  fGuiPrefs := nil;
  fbDateRangeSupplied := False;
  fiemployeeID:=0;
  fqryPersonalPrefs := nil;
  fsReportToPrint:= '';
  fReportObj:=nil;
  fScheduleforEmployee := nil;
  fPrintTemplate:= nil;
  fbReportSQLSupplied:= False;
end;


function TReportSQLBase.getReportonForeignCurrency: boolean;
begin
  Result := fbReportonForeignCurrency and (FCOnreport.recordcount > 0);
end;


function TReportSQLBase.getReportToPrint: String;
begin
  Result := fsReportToPrint;
  if result = '' then
    result := TemplateReportsTypeLib.GetDefaultReport(GetReportTypeID, SharedConnection);
end;

function TReportSQLBase.GetReportTypeID: Integer;
begin
  Result:= 0;
end;

procedure TReportSQLBase.InitIt;
begin
   if fbDateRangeSupplied =False then begin
    DateFrom := 0;
    if qryPersonalPrefs.RecordCount = 1 then begin
      DateTo := Date + qryPersonalPrefs.FieldByName('ListDaysFuture').asInteger;
      if qryPersonalPrefs.FieldByName('ListDaysPast').asInteger <> 0 then DateFrom := Date - qryPersonalPrefs.FieldByName('ListDaysPast').asInteger
      else DateFrom := Date - 14;
    end else begin
      DateTo := Date + 0;
      DateFrom := Date - 14;
    end;
   end;
end;

function TReportSQLBase.Prepareforreport:boolean;
begin
  Result:= True;
end;
Function TReportSQLBase.SaveTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const FileType, FileName: string; MasterDetailLink: TJsonObject):Boolean;
begin
  REsult := False;
  if trim(ReportName) <>'' then begin
    PrintTemplate.ReportSQLSupplied := ReportSQLSupplied;
    REsult := PrintTemplate.SaveReport(ReportName, SQLPortion, DoPrint, FileType, FileName, nil, MasterDetailLink);
  end;
end;


procedure TReportSQLBase.SetEmployeeID(const Value: Integer);
begin
  fiemployeeID := Value;
  AddFCFields;
end;

procedure TReportSQLBase.setFCOnreport(const Value: TERPQuery);
begin
  fQry_ForeigncurrecnyonReport:= Value;
end;

procedure TReportSQLBase.SetReportClassNAme(const Value: String);
begin
  fsReportClassName := Value;
  formID:= getformID(Value);
end;


procedure TReportSQLBase.showProgressbar(Progressbarcaption: string; Progresscount: integer);
begin
  if IsGUI then begin
        ProgressDlg.Caption := Progressbarcaption;
        ProgressDlg.MinValue := 0;
        ProgressDlg.MaxValue := Progresscount;
        ProgressDlg.Step := 1;
        ProgressDlg.Execute;
  end;
end;

procedure TReportSQLBase.stepProgressbar(const ProgressbarMsg: String);
begin
  if IsGui then
    ProgressDlg.StepIt;
end;

function TReportSQLBase.StrToBoolean(const Value: String): Boolean;
begin
  result := SameText(Value , 'T') or SameText(Value , 'True');
end;

function TReportSQLBase.getFCOnreport: TERPQuery;
var
  FCSQL:String;
//  FCSQLforUserID0:String;
begin
  FCSQL :=
    'SELECT CC.code, FCR.*  ' +
    ' FROM tblforeigncurrencyonreport FCR  ' +
    ' inner join tblcurrencyconversion CC on FCR.CurrencyID = CC.CurrencyID and CC.Active = "T" ' +
    ' and CC.Active = "T" and FCR.ListName = ' + quotedStr(ReportClassNAme) +
    ' and FCR.Active = "T" and Showinthereport = "T" ' +
    ' and FCR.USerID = ' + IntToStr(employeeId) +
    ' and CC.code <> ' + quotedStr(Appenvvirt.str['RegionalOptions.ForeignExDefault']);
//  FCSQLforUserID0 := 'SELECT CC.code, FCR.*  ' +
//                                  ' FROM tblforeigncurrencyonreport FCR  ' +
//                                  ' inner join tblcurrencyconversion CC on FCR.CurrencyID = CC.CurrencyID and CC.Active = "T" ' +
//                                  ' and FCR.ListName = ' + quotedStr(ReportClassNAme) +
//                                  ' and FCR.Active = "T" and Showinthereport = "T" ' +
//                                  ' and FCR.USerID = 0' +
//                                  ' and CC.code <> ' + quotedStr(Appenvvirt.str['RegionalOptions.ForeignExDefault']);

    if fQry_ForeigncurrecnyonReport = nil then
        fQry_ForeigncurrecnyonReport := TempQuery;

    if (fQry_ForeigncurrecnyonReport.Active = false) or (trim(fQry_ForeigncurrecnyonReport.SQL.Text) <> trim(fcSQL)) then begin
        if fQry_ForeigncurrecnyonReport.active then  fQry_ForeigncurrecnyonReport.Close;
        fQry_ForeigncurrecnyonReport.SQL.Text := FCSQL;
        fQry_ForeigncurrecnyonReport.Open;

        if fQry_ForeigncurrecnyonReport.RecordCount =0 then begin
          With TempQuery do try
            SQL.text := ' insert into tblForeigncurrencyonReport ' +
                        ' (CurrencyID   , formID  , ListName   , Active  ,Showinthereport , userId)' +
                        ' select CurrencyID   , formID  , ListName   , Active  ,Showinthereport , ' + IntToStr(employeeId) +
                        ' from tblForeigncurrencyonReport  where ListName = ' + quotedStr(ReportClassNAme) +
                        ' and Active = "T" and Showinthereport = "T" ' +
                        ' and USerID = 0';
            Execute;
          finally
            Free;
          end;
          if fQry_ForeigncurrecnyonReport.active then  fQry_ForeigncurrecnyonReport.Close;
          fQry_ForeigncurrecnyonReport.Open;
        end;
    end;
    Result:= fQry_ForeigncurrecnyonReport;
end;
function TReportSQLBase.getformID(const fFormName: String): Integer;
begin
  With TempQuery do try
    SQL.Text :=  'select formid from tblforms where formname = ' +QuotedStr(fFormName);
    open;
    Result := FieldByname('formid').AsInteger;
  finally
    if active then close;
    Free;
  end;
end;

function TReportSQLBase.getGuiPrefs: TFormGuiPrefReader;
begin
  if fGuiPrefs = nil then begin
    fGuiPrefs := TFormGuiPrefReader.Create(Self);
    fGuiPrefs.PrefsName :=ReportClassName;
    fGuiPrefs.USerID:= employeeID;
    fGuiPrefs.LoadPrefs;
  end;
  result:= fGuiPrefs;
end;
function TReportSQLBase.getPrintTemplate: TPrintTemplateBase;
begin
  if fPrintTemplate = nil then begin
     fPrintTemplate := TPrintTemplateBase.Create;
  end;
  Result := fPrintTemplate;
end;

function TReportSQLBase.GetProgressDlg: TProgressInfo;
begin
  result := nil;
  if IsGui then
    result := TProgressInfo(AppEnvVirt.Obj['ProgressInfo']);
end;

function TReportSQLBase.getqryPersonalPrefs: TERPQuery;
begin
  if fqryPersonalPrefs = nil then begin
    fqryPersonalPrefs:= TempQuery;
    fqryPersonalPrefs.SQL.text :=   'SELECT ListDaysPast, ListDaysFuture FROM tblPersonalPreferences WHERE EmployeeID = :EmployeeID;';
  end;
  if fqryPersonalPrefs.Parambyname('EmployeeID').asInteger <> EmployeeID then begin
    if fqryPersonalPrefs.Active then fqryPersonalPrefs.close;
    fqryPersonalPrefs.Parambyname('EmployeeID').asInteger := EmployeeID;
  end;
  if fqryPersonalPrefs.Active = False then fqryPersonalPrefs.open;
  Result :=fqryPersonalPrefs;
end;

function TReportSQLBase.getScheduleforEmployee: TERPQuery;
begin
  if fScheduleforEmployee = nil then begin
    fScheduleforEmployee := TERPQuery.Create(Self);
    fScheduleforEmployee.Connection := TCustomMyConnection(GetSharedMyDacConnection);
    fScheduleforEmployee.SQL.Text := 'SELECT * FROM tblscheduledreports where FormID = ' + inttostr(ReportObj.Fieldbyname('FormID').asInteger)+' and EmployeeId = ' +inttostr(fiEmployeeID);
    fScheduleforEmployee.open;
  end;
  Result := fScheduleforEmployee;
end;

function TReportSQLBase.getreportObj: TERPQuery;
begin
  if fReportObj = nil then begin
    fReportObj := TERPQuery.Create(Self);
    fReportObj.Connection := TCustomMyConnection(GetSharedMyDacConnection);
    fReportObj.SQL.Text := 'Select * from tblforms where FormID = ' + inttostr(formID);
    fReportObj.open;
  end;
  Result := fReportObj;
end;

function TReportSQLBase.getUserLock: TUserLock;
begin
  if not(Assigned(fUserLock)) then
   fUserLock:= TUserLock.Create(self);
  result := fUserLock;
end;
procedure TReportSQLBase.HideProgressbar;
begin
  if IsGui then
    ProgressDlg.CloseDialog;
end;

function TReportSQLBase.getEmployeeEmail:String;
begin
    Result := '';
    with TempQuery do
      try
        SQL.text := 'select email from tblemployees where employeeId =  '+inttostr(EmployeeID);
        open;
        Result := FieldByName('email').asString;
      finally Free;
      end;
end;
function TReportSQLBase.TemplateTypeName(Const TypeID:Integer): String;
begin
    Result := '';
    with TempQuery do
      try
        SQL.text := 'SELECT  TypeName FROM  tbltemplatetype where  TypeID= ' +inttostr(TypeID);
        open;
        Result := FieldByName('TypeName').asString;
      finally Free;
      end;
end;

function TReportSQLBase.TempQuery: TERPQuery;
begin
  if Assigned(SharedConnection) then begin
    result := TERPQuery.Create(nil);
    result.Connection := SharedConnection;
  end
  else
    result := TempMyQuery;
end;

function TReportSQLBase.TempScript: TERPScript;
begin
  if Assigned(SharedConnection) then begin
    result := TERPScript.Create(nil);
    result.Connection := SharedConnection;
  end
  else
    result := TempMyScript;
end;

function TReportSQLBase.EmailReport:boolean;
var
  sql:String;
  emailID:String;
  s:String;
  EmailDate       : TDateTime;
begin
  Result := true;
  clearErrors;
  if EmployeeID =0 then begin
      AddError('No employee Selected for the report');
      result:= False;
  end else begin
    emailId:= getEmployeeEmail;
    if emailId = '' then begin
        AddError(ScheduleforEmployee.Fieldbyname('Employeename').AsString+ ' has no email address provided');
        result:= False;
    end;
    if ReportToPrint ='' then begin
      if GetReportTypeID =0 then
        AddError(ReportObj.Fieldbyname('Description').asString +' template is not initialised. Please contact ERP')
      else AddError(ReportObj.Fieldbyname('Description').asString +' doesn''t have a default report assigned for type ' + TemplateTypeName(GetReportTypeID));
      Result := False;
      Exit;
    end;
  end;
  if not(UserLock.Lock('tblforms'  , formID)) then begin
      s:= Userlock.LockMessage;
      s:= StringReplace(s, 'Unable to update data.', quotedstr(ReportObj.Fieldbyname('Description').asString) + ' as per the schedule .' ,[rfReplaceAll,rfIgnoreCase]);
      s:= StringReplace(s, 'accessing this record', 'accessing scheduling',[rfReplaceAll,rfIgnoreCase]);
      AddError(s);
      Result := False;
      Exit;
  end;
  try
    InitIt;
    if not Prepareforreport then exit;
    sql:= TemplateSQL;
    if sql= '' then begin
        AddError(ReportObj.Fieldbyname('Description').asString +' Report SQL is not initialised. Please contact ERP');
        Result:= False;
    end;
    if Result then begin
      if DoEmailreport( EmailID, ReportToPrint  , sql, OutGoingFileName(GetSharedMyDacConnection.Database, '', TempTableUtils.GetTemporaryTableNameSuffix(AppEnvVirt.str['Employee.LogonName'])+'_' +ReportToPrint +inttostr(employeeId) , 'PDF')) then begin
        EmailDate := Now;
        LogEmailedReport( formID ,EmployeeID, EmailDate  , ReportToPrint , 'Scheduled Reports', True, 'Success : ' + Quotedstr(ReportToPrint) +' is sent to ' + Quotedstr(ScheduleforEmployee.Fieldbyname('Employeename').AsString) +' as per schedule');
        ScheduleforEmployee.Edit;
        ScheduleforEmployee.Fieldbyname('NextDueDate').AsDateTime := NextDueDate(ScheduleforEmployee.FieldByname('ID').AsInteger);
        ScheduleforEmployee.Fieldbyname('LastEmaileddate').AsDateTime := now;
        ScheduleforEmployee.Post;
      end else begin
        LogEmailedReport(formID ,EmployeeID, Date  , ReportToPrint , 'Scheduled Reports', True ,'Failed : ' + fsErrorMsg );
      end;
    end else begin
      LogEmailedReport(formID ,EmployeeID, Date  , ReportToPrint , 'Scheduled Reports', True ,'Failed : ' + fsErrorMsg );
    end;
  finally
    Userlock.UnlockAllCurrentInstance;
  end;
end;


function TReportSQLBase.EmailReport(const EmailID:String; reportToPrint:String):boolean;
var
  sql:String;
  //s:String;
begin
  Result := true;
    InitIt;
    if not Prepareforreport then exit;
    sql:= TemplateSQL;
    if sql= '' then begin
        AddError(ReportObj.Fieldbyname('Description').asString +' Report SQL is not initialised. Please contact ERP');
        Result:= False;
    end;
    if Result then begin
      DoEmailreport( EmailID, ReportToPrint  , sql, OutGoingFileName(GetSharedMyDacConnection.Database, '', TempTableUtils.GetTemporaryTableNameSuffix(AppEnvVirt.str['Employee.LogonName'])+'_' +ReportToPrint +inttostr(employeeId) , 'PDF'));
    end;
end;
function TReportSQLBase.DoEmailreport( RecipientAddress, reportType  :String; sSQL:String; reportfilename:String) :boolean;
var
  OutGoingFileName: string;
  errmsg:String;
begin
  Result          := False;
  OutGoingFileName:= '';
  try
    try
        if not SaveTemplateReport(ReportToPrint, sSQL, true, 'PDF') then begin
           AddError(PrintTemplate.SaveReportErrorMsg);
           REsult:= False;
           Exit;
        end;

        OutGoingFileName := reportfilename;
        if not FileExists( WinTempDir  + OutGoingFileName) then begin
          copyfile(PChar( WinTempDir  + 'EmailReport.PDF'), PChar( WinTempDir  + OutGoingFileName), false);
        end;

        Sleep(1000);
        With TEmailReport.Create(Self) do try
            result := EmailReport(ErrMsg, AppEnvVirt.str['CompanyPrefs.Email'] ,RecipientAddress ,ReportObj.Fieldbyname('Description').asString +' : email schduled for ' + formatdatetime(FormatSettings.shortDateformat , date)  , 'This is an automatically generated email from ERP Software from the report scheduler.' ,WinTempDir  + OutGoingFileName);
            if not result then begin
              if ErrMsg <> '' then AddError(ErrMsg);
              REsult:= False;
              Exit;
            end;
        finally
          Free;
        end;
        DeleteFiles( WinTempDir , '*.PDF');
        REsult:= TRue;
    except

    end;
  finally
    DeleteFiles( WinTempDir , '*.PDF');
  end;
end;
function TReportSQLBase.DTFromStr: string;
begin
  result := '"' + FormatDateTime(MysqlDateTimeFormat,DateFrom) + '"';
end;

function TReportSQLBase.DToStr: string;
begin
  result := '"' + FormatDateTime(MysqlDateFormat,DateTo) + '"';
end;

function TReportSQLBase.DTToStr: string;
begin
  result := '"' + FormatDateTime(MysqlDateTimeFormat,DateTo) + '"';
end;

procedure TReportSQLBase.DeleteFiles(const Path, Mask: string);
var
  lpFileOp: TSHFileOpStruct;
begin
  FillChar(lpFileOp, SizeOf(lpFileOp), #0);
  lpFileOp.wFunc := FO_DELETE;
  // The + #0 is required
  lpFileOp.pfrom := PChar(Path + Mask + #0);
  lpFileOp.pto := PChar(Path);
  lpFileOp.fFlags := FOF_NOCONFIRMATION or FOF_FILESONLY or FOF_SILENT;
  // Perform Operation
  if (SHFileOperation(lpFileOp) <> 0) then Exit;
end;

destructor TReportSQLBase.Destroy;
begin
  if TempTablename <> '' then TempTableUtils.DestroyUserTemporaryTable(GetSharedMyDacConnection,  TempTablename);
  inherited;
end;

function TReportSQLBase.DFromStr: string;
begin
  result := '"' + FormatDateTime(MysqlDateFormat,DateFrom) + '"';
end;

Function TReportSQLBase.NextDueDate(const  scheduleID:Integer):TDateTime;
begin
  With TempQuery  do try
    SQL.text := 'Select NextScheduleDueDate(ID) as NextDate from tblscheduledreports where Id = ' + inttostr(scheduleID);
    open;
    REsult := Fieldbyname('NextDate').asDateTime;
  finally
    if active then close;
    Free;
  end;
end;

Procedure TReportSQLBase.LogEmailedReport(const TransactionID:Integer;const  UserID:Integer; const  EmailDate:TDateTime; const ReportType:String; const TransactionDescription :String; IsScheduledreport:boolean =False; Status:String = 'Success');
begin
        With TempQuery  do try
          Sql.Add('INSERT HIGH_PRIORITY INTO tblEmailedReports (TransactionID, UserID, Date, ReportType, TransactionDescription , IsScheduledreport , Status) ' +
                                   'Values (' +
                                   inttostr(TransactionID) +',' +
                                    inttostr(UserID) +',' +
                                   Quotedstr(FormatDateTime(MysqlDateFormat,EmailDate)) + ',' +
                                   QuotedStr(ReportType)  +',' +
                                   QuotedStr(TransactionDescription) +',' +
                                   QuotedStr(BooleanToStr(IsScheduledreport))+',' +
                                   Quotedstr(Status) +  ')');
          Execute;
        finally
          Free;
        end;

end;
Function TReportSQLBase.FCFields:String;
begin
  REsult:= '';
  with FCOnreport do begin
    First;
    while Eof = False do begin
      if  Result <> '' then Result := Result + ',' ;
      Result := Result + FieldByname('code').asString + '_FCRate';
      Next;
    end;
  end;
end;

{ TEmailReport }

constructor TEmailReport.Create(AOwner: Tcomponent);
begin
  inherited;
  fMailConfig := nil;
end;

function TEmailReport.EmailReport(var ErrMsg:String; const FromAddress, ToAddress, subject, Bodytext, Attachingfile:String ) : boolean;
var
  exMessage: TIdMessage;
  exSMTP: TIdSMTP;
  JMailConfig: TJsonObject;
begin
  REsult:= False;
  ErrMsg:= '';
  if AppEnvVirt.Bool['CompanyPrefs.EnableScheduledreports'] = False then begin
    ErrMsg := 'Scheduled Reports are disabled in the Company Preferences';
    Exit;
  end;
  JMailConfig := JO;
  JMailConfig.AsString := MailConfig.Fieldbyname('ConfigJSON').AsString;
  if (trim(JMailConfig.S['outServerName'])='') or (JMailConfig.I['outServerPort']=0) or (trim(JMailConfig.S['UserName'])='') or (trim(JMailConfig.S['Password'])='')  then begin
    ErrMsg := 'Outgoing Email Configuration is incomplete. Please Configure it (Utilities -> Company Information -> Email Config)';
    Exit;
  end;
  exMessage := TIdMessage.Create(nil);
  exSMTP := TIdSMTP.Create(nil);
  try
    try
      exSMTP.Host     := JMailConfig.S['outServerName'];
      exSMTP.Port     := JMailConfig.I['outServerPort'];
      exSMTP.Username := JMailConfig.S['UserName'];
      exSMTP.Password := JMailConfig.S['Password'];

      exMessage.From.Text := FromAddress;
      if exMessage.From.Text  ='' then exMessage.From.Text  :=exSMTP.Username;
      exMessage.Recipients.EMailAddresses := ToAddress;
      exMessage.Subject := Subject;
      exMessage.Body.Add(Bodytext);
      if FileExists(Attachingfile) then
        TIdAttachmentFile.Create(exMessage.MessageParts, Attachingfile);
        exSMTP.Connect;
        if exSMTP.Connected then begin
          exSMTP.Send(exMessage);
          Result:= True;
        end;
    except
        on E:Exception do begin
          ErrMsg := 'Report  could not be emailed this time. '+E.Message;
          REsult:= False;
        end;
    end;
  finally
    FreeAndNil(exMessage);
    FreeAndNil(exSMTP);
  end;
end;
function TEmailReport.getMailConfig: TERPQuery;
begin
  if fMailConfig = nil then begin
      fMailConfig := TERPQuery.create(Self);
      fMailConfig.connection := TCustomMyConnection(GetSharedMyDacConnection);
      fMailConfig.SQL.text := 'SELECT * FROM tblemailconfig where EntityName = ' + QuotedStr('Company');
      fMailConfig.open;
  end;
  Result := fMailConfig;
end;
function TempMyquery: TERPQuery;
begin
  result :=TERPquery(AppEnvVirt.Obj['CommonDbLib.TempMyQuery']);
end;
function TempMyScript: TERPScript;
begin
  result :=TERPScript(AppEnvVirt.Obj['CommonDbLib.TempMyScript']);
end;
function GetSharedMyDacConnection: TERPConnection;
begin
  result:= TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
end;

function WinTempDir: string;
var
  Buffer: array[0..MAX_PATH] of char;
begin
  GetTempPath(Length(Buffer), Buffer);
  Result := StrPas(Buffer);
end;


end.

