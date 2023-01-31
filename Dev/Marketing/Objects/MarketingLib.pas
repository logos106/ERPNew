// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 06/04/05  1.00.01 BJ  New Functions added
  //                      (1) ExecuteQuery :Executes the SQL passed to it.
  //                      (2) Openquery : Executes the SQL for the recordset and returns the Query
  //                      (3) Modulecompleted : 2 overload function for marking the course
  //                          for 'completed' and 'satisfactory'
  // 11/04/05 1.00.02 BJ  CreateNewMarketingCodeEntry : the function is modified to return
  //                          the 'marketing code' and 'marketting code ID' of the newly created
  //                           record
  // 15/04/05 1.00.02 BJ  A new table is introduced for coursemoduleproducts. the table is populated
  //                          along with the tblcourseModule. When the module is repeated on an 'unsatisfactory'
  //                          result - the moduleproduc records are fetched from the origical set assuming that
  //                          the material is not re-issued for a repeatition.
  // 21/04/2005  1.00.00 BJ Introduced new field in tblcourseModuleProducts for the qty

unit MarketingLib;

interface

uses MyAccess,ERPdbComponents;

type
  TMarketingCode = AnsiString;

  TMarketingCodeRecord = record
    Publication,
    CodeType,
    Country,
    Slot,
    Variation1,
    Variation2,
    Notes,
    Description: string;
    CourseDefId,
    Circulation: integer;
    DateFrom,
    DateTo: TDateTime;

  end;

  // returns a new unique marketing code (alse is ub=nique in cost centre table)
function GetNewMarketingCode(const DBConnection: TERPConnection): TMarketingCode;

  // Create a default marketing code for this course with blank dates
procedure CreateDefaultMarketingCodeForCourse(const CourseDefId: integer; const DBConnection: TERPConnection);

  //  procedure CreateNewMarketingCodeEntry(Publication, aType: string;
  //                                        CourseDefId: integer;
  //                                        DateFrom, DateTo: TDateTime;
  //                                        Description, Notes: string;
  //                                        DbConnection: TERPConnection);
procedure CreateNewMarketingCodeEntry(const MktCodeRec: TMarketingCodeRecord; const DbConnection: TERPConnection;
                                      out MktCd: string; out MktCdId: integer);

procedure Modulecompleted(const fQry: TERPQuery; const qrysource: TERPQuery; const isSatisfactory: boolean; const dtVal: TDateTime); overload;
procedure ModuleCompleted(const Qry: TERPQuery; const ModuleID: integer; const dtVal: TDateTime); overload;
function OpenQuery(const Qry: TERPQuery; const strSql: string): TERPQuery;
procedure ExecuteSql(const Qry: TERPQuery; const strSql: string);

const
  MCODE_DEFAULT_TYPE = 'Default Code';


implementation

uses FastFuncs,SysUtils, Dialogs, MySQLConst;

const
  {WARNING: DO NOT EVER CHANGE THIS CONSTANT}
  CODEARRAY: array[1..32] of AnsiChar = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ345678';

  { Coded related -------------------------------------------------------------}
  {
  This code is to be used in advertising and thus will be referred to via phone etc

  32 * 8 * 32 * 8 * 32 * 8 = 16777216
  we encode letter digit letter digit letter digit
  (some letters will be digits
   digits will range from 2..9)

  we use this bit sequence from a 3 byte cardinal (random) value:  5 3 5 3 5 3
  the letter gets picked from CODEARRAY, the digit is used directly (+2)
  }


function ToMarketingCoded(const Value: integer): TMarketingCode;
begin
  Result := '      ';
  Result[6] := AnsiChar(Chr(Ord('2') + Value and 7));
  Result[5] := AnsiChar(CODEARRAY[(Value shr 3) and 31 + 1]);
  Result[4] := AnsiChar(Chr(Ord('2') + (Value shr 8) and 7));
  Result[3] := AnsiChar(CODEARRAY[(Value shr 11) and 31 + 1]);
  Result[2] := AnsiChar(Chr(Ord('2') + (Value shr 16) and 7));
  Result[1] := AnsiChar(CODEARRAY[(Value shr 19) and 31 + 1]);
end;

// returns a new unique marketing code (alse is ub=nique in cost centre table)
function GetNewMarketingCode(const DBConnection: TERPConnection): TMarketingCode;
var
  qry: TERPQuery;
  CodeExists: boolean;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  CodeExists := false;
  try
    qry.Connection := DBConnection;
    repeat
      Result := ToMarketingCoded(Random(16777216 - 1));
      qry.Close;
      if (Result[1] in ['A'..'Z']) and (Result[3] in ['A'..'Z']) and (Result[5] in ['A'..'Z']) then begin
        qry.SQL.Text := 'SELECT TheCode FROM tblmarketingcode WHERE TheCode = ' + QuotedStr(string(Result));
        qry.Open;
        CodeExists := not qry.IsEmpty;
        qry.Close;
        if not CodeExists then begin
          // now make sure this is a unique cost centre
          qry.SQL.Text := 'SELECT CostCentreName FROM tblCostCentre WHERE CostCentreName = ' + QuotedStr(string(Result));
          qry.Open;
          CodeExists := not qry.IsEmpty;
          qry.Close;
        end;
      end;
    until not CodeExists;
  finally
    FreeAndNil(qry);
  end;
end;

  //procedure CreateNewMarketingCodeEntry(Publication, aType: string;
  //                                      CourseDefId: integer;
  //                                      DateFrom, DateTo: TDateTime;
  //                                      Description, Notes: string;
  //                                      DbConnection: TERPConnection);
procedure CreateNewMarketingCodeEntry(const MktCodeRec: TMarketingCodeRecord; const DbConnection: TERPConnection;
  out MktCd: string; out MktCdID: integer);
var
  qry: TERPQuery;
  cmd: TERPCommand;
  MktCode: TMarketingCode;
  CourseName: string;
  CostCentreId: integer;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  cmd := TERPCommand.Create(nil);
  try
    qry.Connection := DbConnection;
    cmd.Connection := DbConnection;

    // Get the coures name
    CourseName   := '';
    qry.SQL.Text := 'SELECT CourseName FROM tblCourseDef WHERE CourseDefId = ' + IntToStr(MktCodeRec.CourseDefId);
    qry.Open;
    if not qry.IsEmpty then CourseName := qry.Fields[0].AsString;
    qry.Close;

    // Get a new Code (that is not already used as a costcentre)
    MktCode := GetNewMarketingCode(DbConnection);
    MktCd   := string(MktCode);
    // Insert cost centre record
    cmd.SQL.Text := 'INSERT HIGH_PRIORITY INTO tblCostCentre SET' + ' CostCentreName = ' + QuotedStr(string(MktCode)) +
      ',' + ' CostCentreDescription = ' + QuotedStr('Course: ' + CourseName + ' - ' + MktCodeRec.Publication +
      ' ' + FormatDateTime((*'dd/mm/yy'*)FormatSettings.shortdateformat, MktCodeRec.DateFrom) + ' to ' + FormatDateTime((*'dd/mm/yy'*)FormatSettings.shortdateformat, MktCodeRec.DateTo));
    cmd.Execute;
    CostCentreId := cmd.InsertId;
    MktCdId      := CostCentreId;
    // Insert the marketing code reord
    cmd.SQL.Text := 'INSERT HIGH_PRIORITY INTO tblMarketingCode SET' + ' TheCode = ' + QuotedStr(string(MktCode)) + ',' +
      ' CourseDefId = ' + IntToStr(MktCodeRec.CourseDefId) + ',' + ' CostCentreId = ' + IntToStr(CostCentreId)
      + ',' + ' Active = "T"';


    if MktCodeRec.CodeType <> '' then cmd.SQL.Add(', Type = ' + QuotedStr(MktCodeRec.CodeType));
    if MktCodeRec.Publication <> '' then cmd.SQL.Add(', Publication = ' + QuotedStr(MktCodeRec.Publication));
    if MktCodeRec.Description <> '' then cmd.SQL.Add(', Description = ' + QuotedStr(MktCodeRec.Description));
    if MktCodeRec.Notes <> '' then cmd.SQL.Add(', Notes = ' + QuotedStr(MktCodeRec.Notes));
    if MktCodeRec.Country <> '' then cmd.SQL.Add(', Country = ' + QuotedStr(MktCodeRec.Country));
    if MktCodeRec.Slot <> '' then cmd.SQL.Add(', Slot = ' + QuotedStr(MktCodeRec.Slot));
    if MktCodeRec.Variation1 <> '' then cmd.SQL.Add(', Variation1 = ' + QuotedStr(MktCodeRec.Variation1));
    if MktCodeRec.Variation2 <> '' then cmd.SQL.Add(', Variation2 = ' + QuotedStr(MktCodeRec.Variation2));
    if MktCodeRec.Circulation <> 0 then cmd.SQL.Add(', Circulation = ' + IntToStr(MktCodeRec.Circulation));
    if MktCodeRec.DateFrom > 0 then cmd.SQL.Add(', DateFrom = ' + QuotedStr(FormatDateTime(MysqlDateFormat, MktCodeRec.DateFrom)));
    if MktCodeRec.DateTo > 0 then cmd.SQL.Add(', DateTo = ' + QuotedStr(FormatDateTime(MysqlDateFormat, MktCodeRec.DateTo)));
    cmd.Execute;

  finally
    FreeAndNil(qry);
    FreeAndNil(cmd);
  end;
end;

// Create a default marketing code for this course with blank dates
procedure CreateDefaultMarketingCodeForCourse(const CourseDefId: integer; const DBConnection: TERPConnection);
var
  qry: TERPQuery;
  mcr: TMarketingCodeRecord;
  MktCode: string;
  MktCdId: integer;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    // make sure there is not already a code for this course
    qry.Connection := DBConnection;
    qry.SQL.Text   := 'SELECT CourseDefId FROM tblmarketingcode WHERE ' + 'CourseDefId = ' +
      IntToStr(CourseDefId) + ' AND Type = "' + MCODE_DEFAULT_TYPE + '";';
    qry.Open;
    if qry.RecordCount = 0 then begin // we need a course record with a default type
      mcr.Publication := '';
      mcr.CodeType := MCODE_DEFAULT_TYPE;
      mcr.Country := '';
      mcr.Slot := '';
      mcr.Variation1 := '';
      mcr.Variation2 := '';
      mcr.Notes := '';
      mcr.Description := 'Default marketing code';
      mcr.CourseDefId := CourseDefId;
      mcr.Circulation := 0;
      mcr.DateFrom := 0;
      mcr.DateTo := 0;
      CreateNewMarketingCodeEntry(mcr, DbConnection, MktCode, MktCdId);
    end;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

// function being Called when the module is completed ie Iscomplete is true
procedure ModuleCompleted(const Qry: TERPQuery; const ModuleID: integer; const dtVal: TDateTime);
var
  strSql: string;
begin
  strSql := 'Update tblCourseModule Set IsComplete = ''T'' , ' + ' DateEnd = ''' + FormatDateTime('yyyy/mm/dd',
    dtVal) + '''' + '  Where courseModuleId = ' + IntToStr(ModuleID);
  ExecuteSql(Qry, strSql);
end;

procedure Modulecompleted(const fQry: TERPQuery; const qrysource: TERPQuery; const isSatisfactory: boolean; const dtVal: TDateTime);
var
  StrSql: string;
  NextModule: integer;
  Qry: TERPQuery;
begin
  Qry := fQry;
  strSql := '';
  // updating the current record for iscomplete, issatisfactory, dateend and datback
  if qrysource.FieldByName('IsComplete').AsString <> 'T' then strSql := 'IsComplete = ''T''';
  if qrysource.FieldByName('DateEnd').AsDateTime = 0 then begin
    if strSql <> '' then strSql := strSql + ',';
    strSql := strSql + ' DateEnd = ''' + FormatDateTime('yyyy/mm/dd', dtVal) + '''';
  end;
  if StrSql <> '' then StrSql := strSql + ',';
  if isSatisfactory then strSql := strSql + ' IsSatisfactory = ''T'' '
  else strSql := strSql + ' IsSatisfactory = ''F'' ';
  if StrSql <> '' then StrSql := strSql + ',';
  strSql := strSql + ' DateBack = ''' + FormatDateTime('yyyy/mm/dd', dtVal) + '''';
  strSql := 'Update tblCourseModule Set ' + StrSql + ' Where CourseModuleId = ' +
    qrySource.FieldByName('CourseModuleID').AsString;
  ExecuteSql(qry, strSql);

  if isSatisfactory = false then begin
    // when the current module is completed with a non-satisfactory status
    // increase the SEQUENCENO of all the rest of the modules by 1
    // then insert a new record for the module which is not satisfactory

    strSql := '';
    StrSql := 'Update tblCourseModule Set Sequence = sequence + 1 ' + ' where CourseId = ' +
      qrySource.FieldByName('CourseID').AsString + ' and Sequence > ' + qrySource.FieldByName('Sequence').AsString;
    ExecuteSql(qry, strSql);

    // coursemodule record for he repeating course
    StrSql := ' INSERT HIGH_PRIORITY INTO tblcourseModule ' +
      ' (CourseModuleDefId, CourseId , GlobalRef , IsSatisfactory , IsComplete, DateStart, Sequence, IsMaterialSent )' +
      ' values (' + qrySource.FieldByName('CourseModuleDefId').AsString + ',' + qrySource.FieldByName('CourseId').AsString +
      ',''' + qrySource.FieldByName('GlobalRef').AsString + ''','''' ,'''' ,''' + FormatDateTime('yyyy/mm/dd',
      dtVal) + ''',' + IntToStr(qrySource.FieldByName('Sequence').AsInteger + 1) + ',''' +
      qrySource.FieldByName('IsMaterialSent').AsString + '''' + ')';
    ExecuteSql(qry, strSql);

    // coursemoduleproducts records for the repeating course.
    strSql     := 'Select Max(CourseModuleId) as ID from   tblcourseModule';
    qry        := OpenQuery(qry, strSql);
    NextModule := qry.FieldByName('ID').AsInteger;

      {      // assuming that the material gets reissued so all prducts added as 'not issues'
      strSql := ' INSERT HIGH_PRIORITY INTO tblcoursemoduleProducts '+
                        '( CourseModuleId ,  PartsID ,  IsMaterialSent, Qty ) ' +
                        '  Select ' + IntToStr(NextModule) + ', PartsID , ''F'', Qty from tblModuleProducts ' +
                        ' where CourseModuleDefId = ' +    qrySource.fieldByname('CourseModuleDefId').AsString ;}

    // assuming that the course material is not reissued- so the 'issue status' is taken from the original course record.
    strSql := ' INSERT HIGH_PRIORITY INTO tblcoursemoduleProducts ' + '( CourseModuleId ,  PartsID ,  IsMaterialSent , Qty) ' +
      '  Select ' + IntToStr(NextModule) + ', PartsID ,IsMaterialSent  , Qty from tblCourseModuleProducts ' +
      ' where CourseModuleId = ' + qrySource.FieldByName('CourseModuleId').AsString;
    ExecuteSql(qry, strSql);
  end else begin
    // when the module is finished with satisfactory status, update the
    //  startdate of the next module in the sequence with the dateback of
    // of the module finished
    StrSql := 'Select CourseModuleId from tblCourseModule where courseId = ' +
      qrysource.FieldByName('CourseID').AsString + ' and Sequence > ' + qrySource.FieldByName('Sequence').AsString +
      ' and ' + 'DateStart is null  Order by Sequence';

    qry := OpenQuery(qry, strSql);
    if qry.RecordCount > 0 then begin
      qry.First;
      NextModule := qry.FieldByName('courseModuleId').AsInteger;
      StrSql := '';
      StrSql := 'Update tblCourseModule set dateStart = ''' + FormatDateTime('yyyy/mm/dd',
        dtVal) + '''' + '  where CourseModuleId = ' + IntToStr(NextModule);
      ExecuteSql(qry, strSql);
    end else begin
      strSql := 'Update tblCourse Set EndDate = ''' + FormatDateTime('yyyy/mm/dd', dtVal) +
        ''' where courseId = ' + qrysource.FieldByName('CourseId').AsString;
      ExecuteSql(qry, strSql);
    end;
  end;
end;

procedure ExecuteSql(const Qry: TERPQuery; const strSql: string);
begin
  with Qry do begin
    if Active then Close;
    Sql.Clear;
    Sql.Add(strSql);
    Execute;
  end;
end;

function OpenQuery(const Qry: TERPQuery; const strSql: string): TERPQuery;
begin
  with qry do begin
    if Active then Close;
    Sql.Clear;
    sql.Add(strSql);
    Execute;
    Result := Qry;
  end;
end;

end.
