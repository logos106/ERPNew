unit LogLib;

  // -----------------------------------------------------------------------------
  // Common logging for ERP applications.
  //
  // The Log procedure will write to a log file in the root directory with
  // the following name: "<AppName>_Log dd-mm-yy.log"
  // This file will cycle each month, ie if current date is 01/03/05 the log
  // file for previous month (01/02/05) will be deleted when the new log is created.
  //
  // The MsgType parameter can be anything you like (see common types below) and
  // with the exception of "Error" (always logged) the log message will only be
  // logged if that MsgType is listed in the "LogOptions.ini" file in the root
  // directory. To enable logging for a particular MsgType add that type to the
  // "LoggingTypes" entry in the ini section with the same name as your app.
  // Note to enable logging for all message types set this entry to All.
  // eg to enable logging of Warning and Info messages for the ERPshell.exe app the
  // LogOptions.ini file would need to contain the following entries:
  // [ERP]
  // LoggingTypes=Warning,Info
  //
  // To enable logging for all types:
  //
  // [ERP]
  // LoggingTypes=All
  // -----------------------------------------------------------------------------

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 11/03/05  1.00.00 IJB  Initial version.
  // 21/03/05  1.00.01 IJB  Added LogE function and added exception handling
  //                        around Log function to disable logging.
  // 10/06/05  1.00.02 IJB  Modified to delete all log files except current day.
  //

interface
{$I ERP.inc}
uses
  SysUtils, Classes,XMLDoc , ERPdbComponents, forms ;

Type
  TLogList = class(Tcomponent)
  private
  Protected
    FLogList        : TStrings;
  public
    constructor Create(AOwner:Tcomponent); override;
    destructor Destroy; override;
    function LogList :TStrings;
    procedure Add(const LogMsg:String);
    procedure Clear;
  end;


const
  LogType_Error   = 'Error';
  LogType_Warning = 'Warning';
  LogType_Info    = 'Info';
  LogType_Debug   = 'Debug';
  logfile2 = 'i:\temp\to be deleted\erp.log';
procedure LogQuerySQL(Qry :TERPQuery; xfilename:String=''; logtime:boolean =False);
procedure Logtext(const Msg: string; xfilename:String=''; logtime:boolean =False);
procedure Logformname(form :TForm; ClearLog:Boolean = False);
Procedure LogTextLoge(const Msg: string);
Procedure shownLogtext(const Value:String);
procedure Logstr(const Msg: string; xfilename:String='c:\erp.log');
procedure cLog(const Msg: string; xfilename:String='');
procedure LogTime(const Msg: string;extraInfo :String = ''; xfilename:String='');
Procedure LogCurrenttime(const Msg:String);
Procedure StartLogtime;
Procedure ClearLogtime;
procedure cleanLog(xfilename:String='c:\ERP.log');
procedure LogXML(const DOC : TXMLDocument; const XMLNodeName :STring);
procedure Log(const Msg: string; const MsgType: string = LogType_Error; includeDateNType :Boolean = True);
function ExplainObj(ObjTYPE:TPersistentClass; Obj:TObject=NIL;showValue:Boolean=False):string;
function GetCurrentLogFileName: string;
procedure LogE(const Sender: TComponent; const E: Exception; const msg: string = '');
Procedure CopyToClipboard(Const Value:String);
Procedure Logbusobj(sName, sclassname, objInteger :String;  sSQL:String; Action :String);
Procedure emptyLogbusobj;
Procedure ShowExceptionMessageInDevmode(const E:Exception; ExtraMsg:String) ;
Procedure LogdsStruct(Qry:TERPQuery);
Procedure LogDsData(qry:TERPQuery; msg:String = '';showheader:Boolean =False);
Procedure AddToLogList(AOwner:TComponent; LogMsg:String);
Procedure ClearLogList(AOwner:TComponent);
Function LogList(AOwner:TComponent ):TLogList;
Function LogListDetails(AOwner:TComponent ):String;
Procedure OpenLogfile(xfilename:String='');



implementation

uses
  IniFiles, Dialogs, CommonLib, Windows, DNMLib, DateUtils,
  Clipbrd,  Variants,TypInfo, CommonDbLib, MySQLConst, SystemLib, AppEnvironment  ,
  ShellAPI,  MyScript, LogThreadLib, DbSharedObjectsObj, FilesLib, tcConst;

var
  LoggingPath: string;
  FileName: string;
  F: TextFile;
  LastLogDate: TDateTime = 0;
  FirstLog: boolean = false;
  TypesToLog: string;
  LogAll: boolean = false;
  fbLogXML :Boolean;
  fsLogXMLFileName :String;
  ini: TMemIniFile;
  LoggingEnabled: boolean = false;
  PreviousTime: TDateTime;
  PreviousEvent: String;

function GetModuleNameStr: String;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

function GetCurrentLogFileName: string;
begin
  Result := FileName;
end;
Procedure OpenLogFile(xfilename:String='');
begin
{$IFDEF DevMode}
      if xfilename = '' then xfilename := replacestr(Application.ExeName, '.EXE' ,'.Log');
      try
        ShellExecute(application.Handle, 'Open', PChar(xfilename) , '', '', SW_SHOWNORMAL)
      except
        on E: Exception do begin
          CommonLib.MessageDlgXP_Vista('open Log file Failed: ' + E.Message, mtWarning, [mbOK], 0);
        end;
      end;
  {$ENDIF}
end;
procedure LogE(const Sender: TComponent; const E: Exception; const msg: string = '');
var
  s: string;
begin
  s := E.Message;
  if Assigned(Sender) then s := ' Unit name: "' + Sender.Name + '"';
  if msg <> '' then s := s + ' ' + msg;
end;

procedure LogXML(const DOC : TXMLDocument; const XMLNodeName :STring);
var
    fsFileName:String;
begin
    if not fbLogXML then Exit;
    if fsLogXMLFileName = '' then Exit;
    fsFileName :=replaceStr(fsLogXMLFileName , '.XML' , Trim(XMLNodeName) +'.XML');
    Doc.XML.SaveToFile(fsFileName);
end;
procedure cleanLog(xfilename:String='c:\ERP.log');
begin
{$IFDEF DevMode}
    try
    {$I-}
      Assignfile(F, xfilename);
      Rewrite(F); // new file
      Writeln(F, '');
      CloseFile(F);
{$I+}
    except
      on E: Exception do begin
        LoggingEnabled := false;
        CommonLib.MessageDlgXP_Vista('Logging has been disabled, could not write to log file log file: ' + E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  {$ENDIF}
end;
Procedure ClearLogtime;
begin
{$IFDEF DevMode}
  PreviousTime:= 0;
  PreviousEvent:= '';
 With TempMyScript do try
    SQL.add('  drop table if exists tmp_logtime;' );
    execute;
  finally
    free;
  end;
    {$ENDIF}
end;

Procedure StartLogtime;
begin
{$IFDEF DevMode}
  PreviousTime:= now;
  PreviousEvent:= '';
 With TempMyScript do try
    SQL.add('  drop table if exists tmp_logtime;' );
    SQL.add('CREATE TABLE `tmp_logtime` ( '+
                '`ID` int(11) NOT NULL auto_increment, '+
                '  `PreviousEvent` varchar(100) default NULL, '+
                '  `Event` varchar(100) default NULL, '+
                '  `milliseconds` int(11) default NULL, '+
                '  `ExtraInfo` longtext, '+
                '  `mstimeStamp` timestamp NULL default NULL on update CURRENT_TIMESTAMP, '+
                '  PRIMARY KEY  (`ID`) '+
                ') ENGINE=MyISAM AUTO_INCREMENT=3362 ');
    execute;
  finally
    free;
  end;
  LogTime('starting');
  {$ENDIF}
end;
procedure LogTime(const Msg: string;extraInfo :String = ''; xfilename:String='');
{$IFDEF DevMode}
var
  timediff :Integer;
{$ENDIF}
begin
  {$IFDEF DevMode}
  if Previoustime =0 then   timediff:=0 else   timediff:=MilliSecondsBetween(Previoustime , now);
  if timediff >0 then
  logtext(IntToStr(timediff)+' milliseconds    :' +quotedStr(msg)+FormatDateTime('dd-mm-yyyy hh:nn:ss:zz' , now) , xfilename);
  PreviousTime:= now;
  PreviousEvent := Msg;
  {$ENDIF}
end;
Procedure LogCurrenttime(const Msg:String);
begin
{$IFDEF DevMode}
  Logtext(Msg +':' +formatdateTime('dd-mm-yyyy hh:nn:ss:zzz', now));
{$ENDIF}
end;

procedure cLog(const Msg: string; xfilename: String='');
begin
  {$IFDEF DevMode}
  if xfilename = '' then xfilename:= ReplaceStr(Application.ExeName, '.EXE', '.Log');
  (*CleanLog(xfilename);
  Logtext(Msg,xfilename);*)
    Savetofile(xfilename, Msg, True);
  {$ENDIF}
end;

procedure Logstr(const Msg: string; xfilename:String='c:\erp.log');
begin
 {$IFDEF DevMode}
  try
    {$I-}
      Assignfile(F, xfilename);
      if not FileExists(xfilename) then
        Rewrite(F)
      else
        Append(F); // append to existing
      Writeln(F, Msg);
      CloseFile(F);
    {$I+}
  except
      on E: Exception do begin
        LoggingEnabled := false;
        CommonLib.MessageDlgXP_Vista('Logging has been disabled, could not write to log file log file: ' + E.Message, mtWarning, [mbOK], 0);
      end;
  end;
 {$ENDIF}
end;

Procedure shownLogtext(const Value:String);
begin
{$IFDEF DevMode}
    MessageDlgXP_Vista(value, mtInformation, [mbOK], 0);
    Logtext(Value);
 {$ENDIF}
end;
Procedure LogTextLoge(const Msg: string);
begin
  TLogger.Inst.Log(replacestr(msg, #$D#$A, ' '));
end;
procedure Logformname(form :TForm; ClearLog:Boolean = False);
begin
{$IFDEF DevMode}
  if ClearLog then
    clog(Form.classname , replacestr(Application.ExeName, '.EXE' ,'_forms.Log'))
  else
  Logtext(Form.classname , replacestr(Application.ExeName, '.EXE' ,'_forms.Log'));
 {$ENDIF}
end;

procedure Logtext(const Msg: string; xfilename:String=''; logtime:boolean =False);
  {$IFDEF DevMode}
var
  fileName: string;
  {$ENDIF}
begin
  {$IFDEF DevMode}
      fileName:= xfilename;
      if FileName = '' then
        filename := replacestr(Application.ExeName, '.EXE' ,'.Log');
      Savetofile(Filename, iif(logtime, formatdatetime('dd-mm-yyyy hh:nn:ss:zzz' , now)+':', '')+ Msg , False);
  {$ELSE}
  {$ENDIF}
end;

procedure LogQuerySQL(Qry :TERPQuery; xfilename:String=''; logtime:boolean =False);
  {$IFDEF DevMode}
var
  fileName: string;
  {$ENDIF}
begin
  {$IFDEF DevMode}
      fileName:= xfilename;
      if FileName = '' then
        filename := replacestr(Application.ExeName+'QrySQL', '.EXE' ,'.Log');
        if qry = nil then clog('', filename)
        else Savetofile(Filename,
                iif(logtime, formatdatetime('dd-mm-yyyy hh:nn:ss:zzz' , now)+':', '')+NL+
                Qry.SQLtext + NL+
                'Recordcount :' + inttostr(Qry.recordcount) , False);
  {$ENDIF}
end;

function ExplainObj(ObjTYPE:TPersistentClass; Obj:TObject=NIL;showValue:Boolean=False):string;
var
  s:String;
  x:integer;
  count:Integer;
  PropList: PPropList;
  val:Variant;
  valStr:String;
begin
result := '';
  Count := GetPropList(ObjTYPE.ClassInfo, PropList);
  s:= '';

  for x:= 0 to Count -1 do begin
      if (PropList[x].Name = 'Name') or (PropList[x].Name = 'Tag') or (PropList[x].SetProc = nil) then
        Continue;
      if showValue and (Obj<> nil) then begin
        val:= GetPropValue(OBJ, String(PropList[x].Name));
        if (not VarIsNull(val)) then begin
          if (PropList[x].PropType^ = TypeInfo(TDateTime)) then
            valStr:= FormatDateTime(MysqlDateTimeFormat, val)
          else begin
              valStr:= val;
          end;
        end;
        valStr := '=' + valStr;
      end else ValStr:= '';
      if s <> '' then s:= s +chr(13);
      s:= s +  String(PropList[x].Name) +  valStr;
  end;
  result := s;
end;
procedure Log(const Msg: string; const MsgType: string = LogType_Error; includeDateNType :Boolean = True);
var
  sr: SysUtils.TSearchRec;
begin
  if not LoggingEnabled then Exit;

  if LogAll or (MsgType = LogType_Error) or (Pos(MsgType, TypesToLog) > 0) or (TypesToLog = 'ALL') then begin
    firstLog := false;
    if (LastLogDate <> Trunc(Now)) then begin
      // need new file name
      FileName := LoggingPath + ChangeFileExt(ExtractFileName(GetModuleNameStr), '') + '_Log ' +
        FormatDateTime('dd-mm-yy', Now) + '.log';
      if not FileExists(FileName) then begin
        if FindFirst(LoggingPath + ChangeFileExt(ExtractFileName(GetModuleNameStr), '') + '_Log ' + '*.log',
          faAnyFile, sr) = 0 then begin
          try
            repeat
              SysUtils.DeleteFile(LoggingPath + sr.Name);
            until FindNext(sr) <> 0;
          except
            on E: Exception do begin
              LoggingEnabled := false;
              CommonLib.MessageDlgXP_Vista('Logging has been disabled, could not delete old log file: ' + E.Message, mtWarning, [mbOK], 0);
            end;
          end;
        end;
        SysUtils.FindClose(sr);
        FirstLog := true;
      end;
    end;

    if not LoggingEnabled then Exit;

    try
    {$I-}
      Assignfile(F, Filename);
      if FirstLog then Rewrite(F) // new file
      else Append(F); // append to existing
      if includeDateNType then
        Writeln(F, FormatDateTime('dd/mm/yy hh:nn:ss', Now) + ' ' + MsgType + ': ' + Msg)
      else
        Writeln(F, Msg);
      CloseFile(F);
{$I+}
    except
      on E: Exception do begin
        LoggingEnabled := false;
        CommonLib.MessageDlgXP_Vista('Logging has been disabled, could not write to log file log file: ' + E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  end;

end;
Procedure CopyToClipboard(Const Value:String);
begin
    {$IFDEF DevMode}
      Clipboard.asText := Value;
    {$ENDIF}
end;
Procedure Logbusobj(sName, sclassname , objInteger :String;  sSQL:String; Action :String);
{$IFDEF DevMode}
var
  qry :TERPQuery;
{$ENDIF}
begin
{$IFDEF DevMode}

  try
    qry := TempMyquery;
    try
      qry.SQL.Add('Select * from tblbusobjLog where userId = ' + inttostr(AppEnv.Employee.EmployeeID) +' and  Name = ' + quotedstr(sName) +' and Classname = '+quotedstr(sclassname) + ' and ObjInteger = ' + quotedstr(objInteger)  );
      qry.open;
      if qry.recordcount =0 then begin
        qry.Append;
        qry.Fieldbyname('userId').asInteger   := AppEnv.Employee.EmployeeID;
        qry.Fieldbyname('Name').AsString      := sname;
        qry.Fieldbyname('Classname').AsString := sclassname;
        qry.Fieldbyname('ObjInteger').AsString:= objInteger;
      end;
      EditDB(qry);
      qry.Fieldbyname('SQLString').AsString := sSQl;
      if Action ='C' then qry.Fieldbyname('CreatedAt').asDateTime := now
      else qry.Fieldbyname('DeletedAt').asDateTime := now;
      PostDB(qry);
    finally
      qry.closenFree;
    end;
  Except
    // kill the exception
  end;
{$ENDIF}
end;
Procedure emptyLogbusobj;
begin
  try
    With TempMyquery do try
      SQL.Add('delete from tblbusobjlog where userId =' + inttostr(AppEnv.Employee.EmployeeID) + ' or userId =0');
      Execute;
    finally
      ClosenFree;
    end;
  Except
    // kill the exception
  end;
end;
Procedure ShowExceptionMessageInDevmode(const E:Exception; ExtraMsg:String) ;
begin

end;

Procedure LogdsStruct(Qry:TERPQuery);
{$IFDEF DevMode}
var
  ctr:Integer;
  s:String;
{$ENDIF}
begin
  {$IFDEF DevMode}
  s:= '';
  for ctr := 0 to Qry.Fields.Count-1 do begin
    if s<> '' then s:= s+',';
    s:= s+ Quotedstr(Qry.Fields[ctr].FieldName);
  end;
  Logtext(s);
  {$ENDIF}
end;
Procedure LogDsData(qry:TERPQuery; msg:String = '';showheader:Boolean =False);
{$IFDEF DevMode}
var
  ctr:Integer;
  s:String;
{$ENDIF}
begin
  {$IFDEF DevMode}
  if showheader then begin
    s:= '';
    for ctr := 0 to Qry.Fields.Count-1 do begin
      if s<> '' then s:= s+',';
      s:= s+ Qry.Fields[ctr].FieldName;
    end;
    if msg <> '' then s:= msg +':' + s;
    Logtext(s);
  end;

  s:= '';
  for ctr := 0 to Qry.Fields.Count-1 do begin
    if s<> '' then s:= s+',';
    s:= s+ Quotedstr(Qry.Fields[ctr].asString);
  end;
  if msg <> '' then s:= msg +':' + s;
  Logtext(s);
  {$ENDIF}

end;



{ TLogList }

procedure TLogList.Add(const LogMsg: String);
var
  NewEntry:String;
begin
  NewEntry := '';
  if Assigned(Owner) then NewEntry :=NewEntry + Owner.ClassName;
  NewEntry :=NewEntry +FormatDateTime('hh:mm:ss:zzz - ', Now)+' : ' + LogMsg;
  FLogList.Add(NewEntry);
end;

procedure TLogList.Clear;
begin
  FLogList.clear;
end;

constructor TLogList.Create(AOwner:Tcomponent);
begin
  inherited create(AOwner);
  FLogList := TStringList.Create;
end;

destructor TLogList.Destroy;
begin
  FreeAndNil(FLogList);
  inherited;
end;

function TLogList.LogList: TStrings;
begin
  Result := FLogList;
end;
Function LogList(AOwner:TComponent ):TLogList;
var
   fLogList : TComponent;
begin
  fLogList := AOwner.findcomponent(AOwner.classname+'_LogList');
  if not Assigned(fLogList) then begin
    fLogList := TLogList.Create(AOwner);
    fLogList.Name := AOwner.ClassName+'_LogList';
  end;
  Result := TLogList( fLogList);
end;
Procedure AddToLogList(AOwner:TComponent; LogMsg:String);
begin
  try
    LogList(Aowner).Add(LogMsg);
  Except  end;
end;
Procedure ClearLogList(AOwner:TComponent);
begin
  try
    LogList(Aowner).Clear;
  Except  end;
end;
Function LogListDetails(AOwner:TComponent ):String;
begin
  try
  Result := LogList(Aowner).LogList.Text;
  Except  end;
end;

initialization
  LoggingPath := ExtractFileDrive(GetModuleNameStr) + '\';
  LoggingEnabled:= fileexists(LoggingPath + 'LogOptions.ini');
  ini := TMemIniFile.Create(LoggingPath + 'LogOptions.ini');
  Try
    TypesToLog := ini.ReadString(ChangeFileExt(ExtractFileName(GetModuleNameStr), ''), 'LoggingTypes', '');
    fbLogXML := ini.ReadString(ChangeFileExt(ExtractFileName(GetModuleNameStr), ''), 'LogXML', '')='T';
    fsLogXMLFileName := uppercase(ini.ReadString(ChangeFileExt(ExtractFileName(GetModuleNameStr), ''), 'LogXMLFileName', ''));
  finally
    FreeAndNil(ini);
  end;

  if (Pos('ALL', uppercase(TypesToLog)) > 0) then LogAll := true;
  {$IFDEF DevMode}
      LogAll := true;
      LoggingEnabled:=true;
  {$ENDIF}

end.
