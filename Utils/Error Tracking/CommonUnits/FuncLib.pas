unit FuncLib;

interface

Uses
  Windows,Forms,MyAccess,DB,Dialogs,Controls,Classes,ComCtrls,Graphics,
  AdvPageControl;

Type
  TColorMapRec = record
    Name: string;
    Color: TColor;
    AdjLuma: Integer;
  end;

Const  
  cDefaultGradientColor = $00CED6D9;
  cAdjustLuma = 50;  

function StrValue(const sValue: string): Integer;
function DivZer(const x, y: extended): extended;
function Empty(const s: string): boolean;
function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
function IsInteger(Const s:String): Boolean;
function StripQuotes(const sString : string): string;
function ValidateLogin(const UserLogin,Password: string): boolean;
function EnCrypt(Const text: String; Const KEY: String): String;
function DeCrypt(Const EnCryptedText: String; Const KEY: String): String;
function DeleteRecord(Const dst: TDataSet; Const NoWarning :Boolean = False):Boolean;
function GetFileVersion(const FileName : String) : String;
function GetUniqueID: String;
function CopyFile(const FromFilePath,ToFilePath: String): Boolean;
function SumField(Const Dataset: TDataset; Const FieldName:String):Double;
function MaxField(Const Dataset: TDataset; Const FieldName:String):Double;
function MinField(Const Dataset: TDataset; Const FieldName:String):Double;
function GetTempFileName(const SuffixName: string = '';
                         const Extension: string = '.tmp';
                         const CreateTheFile: boolean = false): string;
function GetAppTempDir: string;
function GetWinTempDir: string;


function GetDefaultFilter(Const ClassName:String): String;
function ReplaceNonAlphaNumeric(const aString: string): string;
function ReinstateNonAlphaNumeric(const aString: string): string;
function GetComponentByClassName(Const ComponentClassName: string; Const SingleInstance: boolean = false): TComponent;
procedure Split(Const aValue : string; Const aDelimiter : Char; var Result : TStringList);
procedure PaintGradientColor(const Form: TForm);

implementation

Uses SysUtils, StrUtils, Types,FastFuncs,
     GraphUtil,Math,BaseDataMod,kbmCompress,UserInfoObj;

var
  AppTempDir: string = '';

procedure PaintGradientColor(const Form: TForm);
var
  Y: Integer;
  dr,dg,db: Extended;
  C1,C2: TColor;
  R1,R2,G1,G2,B1,B2: Byte;
  R,G,B: Byte;
  cnt: Integer;
  ColorMapRec: TColorMapRec;
begin

   ColorMapRec.Color := cDefaultGradientColor;
   ColorMapRec.AdjLuma := cAdjustLuma;

     
   C1 := ColorAdjustLuma(ColorMapRec.Color, ColorMapRec.AdjLuma, False);
   R1 := GetRValue(C1);
   G1 := GetGValue(C1);
   B1 := GetBValue(C1);

   C2 := ColorMapRec.Color;
   R2 := GetRValue(C2);
   G2 := GetGValue(C2);
   B2 := GetBValue(C2);

   dr := (R2 - R1) / Form.ClientRect.Bottom-Form.ClientRect.Top;
   dg := (G2 - G1) / Form.ClientRect.Bottom-Form.ClientRect.Top;
   db := (B2 - B1) / Form.ClientRect.Bottom-Form.ClientRect.Top;

   cnt := 0;

   for Y := Form.ClientRect.Top to Form.ClientRect.Bottom - 1 do
   begin
      R := R1+Ceil(dr*cnt);
      G := G1+Ceil(dg*cnt);
      B := B1+Ceil(db*cnt);

      Form.Canvas.Pen.Color := RGB(R, G, B);
      Form.Canvas.MoveTo(Form.ClientRect.Left, Y);
      Form.Canvas.LineTo(Form.ClientRect.Right, Y);
      Inc(cnt);
   end;
end;

procedure Split(Const aValue : string; Const aDelimiter : Char; var Result : TStringList);
var
  X : Integer;
  S : string;
begin
  if Result = nil then Result := TStringList.Create;
  Result.Clear;
  S := '';
  for X:=1 to FastFuncs.StrLength(aValue) do begin
    if aValue[X] <> aDelimiter then
      S:=S + aValue[X]
    else begin
      Result.Add(S);
      S := '';
    end;
  end;
  if S <> '' then Result.Add(S);
end;

function GetComponentByClassName(Const ComponentClassName: string; Const SingleInstance: boolean = false): TComponent;
var
  Cls: TPersistentClass;
  x: integer;
begin
  result:= nil;
  if SingleInstance then begin
    // see if there is an instance of this class already created
    for x:= 0 to Application.ComponentCount -1 do begin
      if (Application.Components[x].ClassName = ComponentClassName) then begin
        result:= Application.Components[x];
        Break;
      end;
    end;
  end;
  if not Assigned(result) then begin
    try
      Cls:= FindClass(ComponentClassName);
    except
      Cls:= nil;
      MessageDlg('Could not find component class: ' + ComponentClassName, mtError, [mbOK], 0);
    end;
    if Cls <> nil then begin
      result:= TComponentClass(Cls).Create(Application);
    end;
  end;
end;

function GetWinTempDir: string;
var
  Buffer: array[0..MAX_PATH] of Char;
begin
  GetTempPath(SizeOf(Buffer) - 1, Buffer);
  Result := StrPas(Buffer);
end;  

function GetAppTempDir: string;
begin
  if AppTempDir = '' then begin
    AppTempDir := GetWinTempDir;
    AppTempDir:= AppTempDir + ChangeFileExt(ExtractFileName(Application.ExeName),'');
    if not DirectoryExists(AppTempDir) then CreateDir(AppTempDir);
  end;
  result:= AppTempDir;
end;

function GetTempFileName(const SuffixName: string = '';
                         const Extension: string = '.tmp';
                         const CreateTheFile: boolean = false): string;
var
  f: file;
begin
  result:= GetAppTempDir + '\Temp ' + FastFuncs.RandomStr(6);
  if SuffixName <> '' then
    result:= result + ' ' + SuffixName;
  result:= result + Extension;
  while FileExists(result) do begin
    result:= GetAppTempDir + '\Temp ' + FastFuncs.RandomStr(6);
    if SuffixName <> '' then
      result:= result + ' ' + SuffixName;
    result:= result + Extension;
  end;
  if CreateTheFile then begin
    Assign(f, result);
    Rewrite(f);
    CloseFile(f);
  end;
end;


function DivZer(const x, y: extended): extended;
begin
  if (x = 0) or (y = 0) then result := 0 else result := x / y;
end;

Function SumField(Const Dataset: TDataset; Const FieldName:String):Double;
Var
  bm: TBookmark;
begin
  Result := 0.00;
  If (Dataset.FindField(FieldName)=nil) then Exit;
  with Dataset do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not EOF do begin
      Result := Result + FieldbyName(FieldName).AsFloat;
      next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
    Dataset.Edit;
  end;
End;

function MaxField(Const Dataset: TDataset; Const FieldName:String):Double;
Var
  bm: TBookmark;
begin
  Result := 0.00;
  If (Dataset.FindField(FieldName)=nil) then Exit;
  with Dataset do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not EOF do begin
      If (Result < Dataset.FieldbyName(FieldName).AsFloat) OR (Result=0) then
        Result := FieldbyName(FieldName).AsFloat;
      next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
    Dataset.Edit;
  end;
End;


function MinField(Const Dataset: TDataset; Const FieldName:String):Double;
Var
  bm: TBookmark;
begin
  Result := 0.00;
  If (Dataset.FindField(FieldName)=nil) then Exit;
  with Dataset do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not EOF do begin
      If (Result > Dataset.FieldbyName(FieldName).AsFloat) OR (Result=0) then
        Result := FieldbyName(FieldName).AsFloat;
      next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
    Dataset.Edit;
  end;
End;


function CopyFile(const FromFilePath,ToFilePath: String): Boolean;
Var
  FileStream: TMemoryStream;
  Save_Cursor:TCursor;
begin
  Save_Cursor := Screen.Cursor;
  FileStream := TMemoryStream.Create;
  Try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    If FileExists(FastFuncs.Trim(FromFilePath)) then Begin
      FileStream.LoadFromFile(FromFilePath);
    end;
    Application.ProcessMessages;
    If DirectoryExists(ExtractFilePath(FastFuncs.Trim(ToFilePath))) then Begin
      FileStream.SaveToFile(FastFuncs.Trim(ToFilePath));
    end else begin
      If ForceDirectories(ExtractFilePath(FastFuncs.Trim(ToFilePath))) then Begin
        FileStream.SaveToFile(FastFuncs.Trim(ToFilePath));
      end;
    end;
    Result := True;
  finally
    FreeAndNil(FileStream);
    Screen.Cursor := Save_Cursor;
    Application.ProcessMessages;
  end;
end;

function Empty(const s: String): boolean;
begin
  result := (FastFuncs.Trim(s) = '');
end;

function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
begin
  result  := FastFuncs.AnsiStringReplace(sString,sOldStr,sNewStr,[rfReplaceAll]);
end;

function IsInteger(Const s:String): Boolean;
var
  I, Code: Integer;
begin
  Val(s, I, Code);
  If I=0 then;
  Result := (Code=0);
end;

function StripQuotes(const sString : string): string;
begin
  result  := FastFuncs.AnsiStringReplace(sString,'"','',[rfReplaceAll]);
end;

function EnCrypt(Const text: String; Const KEY: String): String;
var
  i, j: Integer;
begin
  result := '';
  j := 1;
  For i := 1 To FastFuncs.StrLength(text) do
    begin
    result := result + Chr( Ord(text[i]) + Ord(KEY[j]) and 255);
    inc(j);
    If j > FastFuncs.StrLength(KEY) then
      j := 1;
    end;
End;

function DeCrypt(Const EnCryptedText: String; Const KEY: String): String;
var
  i, j, v: Integer;
begin
  result := '';
  j := 1;
  for i := 1 To FastFuncs.StrLength(EnCryptedText) do
    begin
    v := Ord(EnCryptedText[i]) - Ord(KEY[j]);
    if v < 0 then
      v := v + 256;
    result := result + Chr(v);
    inc(j);
    if j > FastFuncs.StrLength(KEY) then
      j := 1;
    end;
End;

function ValidateLogin(const UserLogin,Password: string): boolean;
var
  TempQry: TMyQuery;
Begin
  Result := False;
  TempQry := TMyQuery.Create(nil);
  try
    TempQry.Options.FlatBuffers := True;  
    TempQry.Connection := BaseDataModule.NonTransDBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('SELECT users.userID, users.LoginName, users.loginpassword ');
    TempQry.SQL.Add('FROM users ');
    TempQry.SQL.Add('WHERE users.loginname = '+QuotedStr(FastFuncs.Trim(UserLogin))+';');
    TempQry.Open;
    If (TempQry.RecordCount>0) Then Begin
     If (FastFuncs.LowerCase(UserLogin)=FastFuncs.LowerCase(TempQry.FieldByName('loginName').asString)) AND (FastFuncs.LowerCase(Password) = FastFuncs.LowerCase(TempQry.FieldByName('loginpassword').asString)) Then Begin
        Result := True;
     end;
    end;
   finally
    TempQry.Free;
  end;
end;

function GetDefaultFilter(Const ClassName:String): String;
var
  TempQry: TMyQuery;
Begin
  Result := '';
  TempQry := TMyQuery.Create(nil);
  try
    TempQry.Options.FlatBuffers := True;  
    TempQry.Connection := BaseDataModule.NonTransDBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('SELECT CustomFilterID, FilterName ');
    TempQry.SQL.Add('FROM customfilters ');
    TempQry.SQL.Add('WHERE ClassName = '+QuotedStr(ClassName)+' ');
    TempQry.SQL.Add('AND UserID = '+FastFuncs.IntToStr(UserInfo.UserID)+' ');
    TempQry.SQL.Add('AND DefaultFilter="True";');
    TempQry.Open;
    If (TempQry.RecordCount>0) Then Begin
       Result := TempQry.FieldbyName('FilterName').AsString;
    end;
  finally
    TempQry.Free;
  end;
end;

function GetParentTaskID(Const TaskID:Integer): Integer;
var
  TempQry: TMyQuery;
Begin
  Result := 0;
  TempQry := TMyQuery.Create(nil);
  try
    TempQry.Options.FlatBuffers := True;  
    TempQry.Connection := BaseDataModule.NonTransDBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('SELECT tasks.TaskID, tasks.ParentTaskID ');
    TempQry.SQL.Add('FROM tasks ');
    TempQry.SQL.Add('WHERE tasks.TaskID = '+FastFuncs.IntToStr(TaskID)+';');
    TempQry.Open;
    If (TempQry.RecordCount>0) Then Begin
       Result := TempQry.FieldbyName('ParentTaskID').AsInteger;
    end;
   finally
    TempQry.Free;
  end;
end;

function GetTaskTypeID(Const TaskID:Integer): Integer;
var
  TempQry: TMyQuery;
Begin
  Result := 0;
  TempQry := TMyQuery.Create(nil);
  try
    TempQry.Options.FlatBuffers := True;  
    TempQry.Connection := BaseDataModule.NonTransDBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('SELECT tasks.TaskID, tasks.TaskTypeID ');
    TempQry.SQL.Add('FROM tasks ');
    TempQry.SQL.Add('WHERE tasks.TaskID = '+FastFuncs.IntToStr(TaskID)+';');
    TempQry.Open;
    If (TempQry.RecordCount>0) Then Begin
       Result := TempQry.FieldbyName('TaskTypeID').AsInteger;
    end;
   finally
    TempQry.Free;
  end;
end;

function GetTaskRequestedBy(Const TaskID:Integer): String;
var
  TempQry: TMyQuery;
Begin
  Result := '';
  TempQry := TMyQuery.Create(nil);
  try
    TempQry.Options.FlatBuffers := True;  
    TempQry.Connection := BaseDataModule.NonTransDBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('SELECT tasks.TaskID, tasks.RequestedBy ');
    TempQry.SQL.Add('FROM tasks ');
    TempQry.SQL.Add('WHERE tasks.TaskID = '+FastFuncs.IntToStr(TaskID)+';');
    TempQry.Open;
    If (TempQry.RecordCount>0) Then Begin
       Result := TempQry.FieldbyName('RequestedBy').AsString;
    end;
   finally
    TempQry.Free;
  end;
end;

function DeleteRecord(Const dst: TDataSet; Const NoWarning :Boolean):Boolean;
begin
  Result := False;
  if NoWarning Or (MessageDlg('Are you sure you want to delete this record?', mtConfirmation, [mbYes, mbNo],0) = mrYes) then begin
    try
      dst.Delete;
      Result := True;
    except
      Result := False;
    end;
  end;
end;

Function CheckABN(Const ABN: String): Boolean;
var
  arrX: array[1..11] of Integer;
  arrY: array[1..11] of Integer;
  Remainder: Extended;
begin
  Result := False;
  Try
    arrY[1] := 10;
    arrY[2] := 1;
    arry[3] := 3;
    arry[4] := 5;
    arry[5] := 7;
    arry[6] := 9;
    arry[7] := 11;
    arry[8] := 13;
    arry[9] := 15;
    arry[10] := 17;
    arry[11] := 19;
    arrx[1] := StrToInt(MidStr(ABN,1,1));
    arrx[2] := StrToInt(MidStr(ABN,2,1));
    arrx[3] := StrToInt(MidStr(ABN,3,1));
    arrx[4] := StrToInt(MidStr(ABN,4,1));
    arrx[5] := StrToInt(MidStr(ABN,5,1));
    arrx[6] := StrToInt(MidStr(ABN,6,1));
    arrx[7] := StrToInt(MidStr(ABN,7,1));
    arrx[8] := StrToInt(MidStr(ABN,8,1));
    arrx[9] := StrToInt(MidStr(ABN,9,1));
    arrx[10] := StrToInt(MidStr(ABN,10,1));
    arrx[11] := StrToInt(MidStr(ABN,11,1));
    Remainder := ((arry[1]*arrx[1])+(arry[2]*arrx[2])+(arry[3]*arrx[3])+(arry[4]*arrx[4])+(arry[5]*arrx[5])+(arry[6]*arrx[6])+(arry[7]*arrx[7])+(arry[8]*arrx[8])+(arry[9]*arrx[9])+(arry[10]*arrx[10])+(arry[11]*arrx[11])) mod 89;
    if Remainder = 0 then Begin
      Result := True;
    End;
  except
    Result := False;
  end;
end;

function GetFileVersion(const FileName : String) : String;
var
   VersionInfoSize,
   VersionInfoValueSize,
   Zero             : DWord;
   VersionInfo,
   VersionInfoValue : Pointer;
begin
   Result := '';
   VersionInfoSize := GetFileVersionInfoSize(PChar(FileName), Zero);
   if VersionInfoSize = 0 then exit;
   GetMem(VersionInfo, VersionInfoSize);
   try
      if GetFileVersionInfo(PChar(FileName), 0, VersionInfoSize, VersionInfo)
      and VerQueryValue(VersionInfo, '\' { root block }, VersionInfoValue,
      VersionInfoValueSize) and
      (0 <> LongInt(VersionInfoValueSize)) then begin
         with TVSFixedFileInfo(VersionInfoValue^) do begin
            Result :=                FastFuncs.IntToStr(HiWord(dwFileVersionMS));
            Result := Result + '.' + FastFuncs.IntToStr(LoWord(dwFileVersionMS));
            Result := Result + '.' + FastFuncs.IntToStr(HiWord(dwFileVersionLS));
            Result := Result + '.' + FastFuncs.IntToStr(LoWord(dwFileVersionLS));
         end;
      end;
   finally
      FreeMem(VersionInfo);
   end;
end;

function StrValue(const sValue: string): Integer;
var
  sTemp: string;
  bIsNeg: boolean;
  i: integer;
begin
  result:= 0;
  bIsNeg := (FastFuncs.PosEx('-', sValue) > 0) or (FastFuncs.PosEx('(', sValue) > 0);
  sTemp := '';
  for i := 1 to FastFuncs.StrLength(sValue) do
    if sValue[i] in ['0'..'9', DecimalSeparator] then sTemp := sTemp + sValue[i];
  if sTemp = '' then sTemp := '0';
  if bIsNeg then sTemp := '-' + sTemp;
  try
    result := Trunc(StrToFloat(sTemp));
  except
    on e: exception do begin
      Showmessage('StrValue Failed with value: ' + sVAlue + ' Exception: ' + e.Message);
    end;
  end;
end;

function GetUniqueID: String;
Var
  Guid: TGUID;
Begin
  CreateGUID(Guid);
  Result := ReplaceStr(GUIDToString(Guid),'{','');
  Result := ReplaceStr(Result,'}','');
  Result := ReplaceStr(Result,'-','');
End;


function ReplaceNonAlphaNumeric(const aString: string): string;
var
  x: byte;
begin
  result:= aString;
  for x:= 0 to 47 do begin
    result:= FastFuncs.AnsiStringReplace(result, chr(x), '_x' + IntToHex(x,2) + '_',[rfReplaceAll]);
  end;
  for x:= 58 to 64 do begin
    result:= FastFuncs.AnsiStringReplace(result, chr(x), '_x' + IntToHex(x,2) + '_',[rfReplaceAll]);
  end;
  for x:= 91 to 96 do begin
    if x <> 95 then
      result:= FastFuncs.AnsiStringReplace(result, chr(x), '_x' + IntToHex(x,2) + '_',[rfReplaceAll]);
  end;
  for x:= 123 to 127 do begin
    result:= FastFuncs.AnsiStringReplace(result, chr(x), '_x' + IntToHex(x,2) + '_',[rfReplaceAll]);
  end;
end;

function ReinstateNonAlphaNumeric(const aString: string): string;
var
  x: byte;
begin
  result:= aString;
  for x:= 0 to 47 do begin
    result:= FastFuncs.AnsiStringReplace(result, '_x' + IntToHex(x,2) + '_', chr(x),[rfReplaceAll]);
  end;
  for x:= 58 to 64 do begin
    result:= FastFuncs.AnsiStringReplace(result, '_x' + IntToHex(x,2) + '_', chr(x),[rfReplaceAll]);
  end;
  for x:= 91 to 96 do begin
    if x <> 95 then
      result:= FastFuncs.AnsiStringReplace(result, '_x' + IntToHex(x,2) + '_', chr(x),[rfReplaceAll]);
  end;
  for x:= 123 to 127 do begin
    result:= FastFuncs.AnsiStringReplace(result, '_x' + IntToHex(x,2) + '_', chr(x),[rfReplaceAll]);
  end;
end;

procedure SetAssignedUser(Const TaskID,UserID:Integer);
var
  TempQry: TMyCommand;
Begin
  TempQry := TMyCommand.Create(nil);
  try
    TempQry.Connection := BaseDataModule.NonTransDBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('UPDATE tasks SET AssignedToUserID='+FastFuncs.IntToStr(UserID)+' WHERE TaskID='+FastFuncs.IntToStr(TaskID));
    TempQry.Execute();
   finally
    TempQry.Free;
  end;
end;


end.






