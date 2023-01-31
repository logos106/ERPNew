unit frmImportTemplatesFrm;

interface

uses
  Windows, Forms, Dialogs, StdCtrls, Buttons, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar, Controls, ExtCtrls,
  Classes, SysUtils,  DB, BaseInputForm,
  Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents, MyClasses, SelectionDialog, AppEvnts, Graphics,
  MemDS, Shader, DNMPanel, ImgList, ProgressDialog;

type
  TImportTemplatesGUI = class(TBaseInputGUI)
    OpenDialog1: TOpenDialog;
    SpeedButton1: TDNMSpeedButton;
    Letter_Label: TLabel;
    lblImporting: TLabel;
    ImportProgressBar: TProgressBar;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    txtFilePath: TMemo;
    qryTemplatesRTM: TERPQuery;
    qryTemplatesRTMReport: TBlobField;
    qryTemplatesRTMTemplID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdInsertRecord: TERPCommand;
    qryTemplatesRTMDefaultTemplate: TWideStringField;
    qryTemplatesRTMTypeID: TIntegerField;
    procedure btnCancelClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }

    FieldValueStrTempID: string;
    TempFilePath: string;
    HeaderStrings: string;
    TableString: string;
    F: TextFile;
    function IsDir(const DirPath: string): boolean;
    function IsFile(const FileName: string): boolean;
    function LineCount(const FileName: string): integer;
    function GetLineOfString(const I, LinesCount: integer): string;
    procedure ProcessLineOfString(const LineStr: string);
    function StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
    Function InsertRecord(const HeaderStrings, TableString, DataStrings: string):Integer;
    function UpdateRecord(const HeaderStrings, TableString, DataStrings: string): Integer;
    function InsertNow(const SQLStr, HeaderStrings, TableString, DataStrings: string): Integer;
    function CreateUpdateString(const HeaderStrings, DataStrings: string): string;
    function CreateWhereString(const DataStrings: string): string;
    function UpdateNow(const SQLStr: string): boolean;
    function GetTypeID(const TypeName: string): integer;
    function GetEmployeeID(const EmployeeName: string): integer;
    function ModQtyDataStr(const LineStringTemp: string): string;
    function FieldCounter(const TestString: string): integer;
    procedure ExtractFiles(const FileName, DataPath: string);
    procedure ImportRTM(const FileName, ID: string);
    function TypeHasaDefualtTemplate(typeId, ID: Integer): boolean;

  public
    { Public declarations }
    
  end;

var
  ImportTemplatesGUI: TImportTemplatesGUI;

implementation

uses FastFuncs,DNMLib, DNMExceptions, CommonDbLib, CommonLib, SystemLib, cabfiles;

{$R *.DFM}

procedure TImportTemplatesGUI.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

function TImportTemplatesGUI.IsDir(const DirPath: string): boolean;
begin
  Result := DirectoryExists(DirPath);
end;

function TImportTemplatesGUI.IsFile(const FileName: string): boolean;
begin
  Result := FileExists(FileName);
end;

function TImportTemplatesGUI.LineCount(const FileName: string): integer;
var
  Count: integer;
begin
  Count := 0;
  AssignFile(F, FileName);
  Reset(F);
  while not Eof(F) do begin
    Readln(F);
    Inc(Count);
  end;
  CloseFile(F);
  Result := Count;
end;

procedure TImportTemplatesGUI.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    txtFilePath.Lines := Opendialog1.Files;
  end;
end;

procedure TImportTemplatesGUI.btnOKClick(Sender: TObject);
var
  LINESTRING: string;
  FCount, I, LinesCount: integer;
begin
  DisableForm;
  try
    btnOK.Enabled := false;
    try
      if empty(txtFilePath.Lines.Text) then begin
        SpeedButton1Click(Sender);
      end;

      for FCount := 0 to (txtFilePath.Lines.Count - 1) do begin
        TempFilePath := '';
        HeaderStrings := '';
        if IsDir(ExtractFileDir(txtFilePath.Lines[FCount])) then begin
          if IsFile(txtFilePath.Lines[FCount]) then begin
            //Import Function
            lblImporting.Caption := 'Please Wait Importing ..... 0%';
            lblImporting.Visible := true;

            //Decompress Files
            TempFilePath := WinTempDir + 'ERPTemplateImport\Templates.pdi';
            try
              if not IsDir(ExtractFileDir(TempFilePath)) then begin
                MkDir(ExtractFileDir(TempFilePath));
              end;
            except
            end;
            try
              ExtractFiles(txtFilePath.Lines[FCount], ExtractFileDir(TempFilePath));
            except
              on e: exception do begin
                MessageDlgXP_Vista(
                  'Error extracting template files with message: ' +
                  e.Message,mtInformation, [mbOk],0);
                exit;
              end;
            end;
            //Start Process
            LinesCount := LineCount(TempFilePath);
            ImportProgressBar.Min := 0;
            ImportProgressBar.Max := LinesCount;
            ImportProgressBar.Position := ImportProgressBar.Min;
            try
              AssignFile(F, TempFilePath);
              Reset(F);
              for I := 1 to LinesCount do begin
                //get next Line
                LINESTRING := GetLineOfString(I, LinesCount);

                // Process Line String
                LINESTRING := Trim(LINESTRING);
                if not empty(LINESTRING) then ProcessLineOfString(LINESTRING);
              end;
            finally
              CloseFile(f);
            end;
            RemoveXDesignSql;
            //Delete Temp Directory
            try
              DeleteFiles(ExtractFileDir(TempFilePath) + '\TemplateFiles\', '*.*');
              DeleteFiles(ExtractFileDir(TempFilePath) + '\', '*.*');
              if IsDir(ExtractFileDir(TempFilePath)) then begin
                if IsDir(ExtractFileDir(TempFilePath)) then begin
                  try
                    RmDir(ExtractFileDir(TempFilePath) + '\TemplateFiles');
                  except
                  end;
                end;
                RmDir(ExtractFileDir(TempFilePath));
              end;
            except
            end;
            lblImporting.Visible := true;
          end else begin
            CommonLib.MessageDlgXP_Vista('File "' + txtFilePath.Lines[FCount] + '"' + #13 + 'Does Not Exist !', mtWarning, [mbOK], 0);
          end;
        end else begin
          CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFilePath.Lines[FCount]) + '"' + #13 + ' Does Not Exist !',
            mtWarning, [mbOK], 0);
        end;
      end;
      Self.Close;
    finally
      btnOK.Enabled := true;
    end;
  finally
    EnableForm;
  end;  
end;

function TImportTemplatesGUI.StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := HSrc + Delim;
  S := 1;
  for L9 := 1 to Count - 1 do begin
    S := FastFuncs.PosEx(Delim, Src);
    if S > 0 then Delete(Src, S, char_length(Delim))
    else Break;
  end;

  Result := '';
  if S > 0 then begin
    E      := FastFuncs.PosEx(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;

function TImportTemplatesGUI.GetLineOfString(const I, LinesCount: integer): string;
begin
  try
    Readln(F, Result);
    ImportProgressBar.StepIt;
    lblImporting.Caption := 'Please Wait Importing ..... ' + FloatToStrF(((I / LinesCount) * 100),
      ffFixed, 18, 0) + '% Complete';
    Application.ProcessMessages;
  except
    on EInOutError do Result := '';
  end;
end;

procedure TImportTemplatesGUI.ProcessLineOfString(const LineStr: string);
var
  LineString, FirstField, TypeImport, RTMFilePath: string;
  NewId :Integer;
begin
  LineString := LineStr;
  FirstField := '';
  RTMFilePath := '';
  FirstField := StrExtStr(LineString, #9, 1);
  TypeImport := ReplaceStr(FirstField, '$', '');
  TypeImport := ReplaceStr(TypeImport, 'FINAL', '');
  if TypeImport = 'TEMPLATE' then begin
    if FirstField = '$TEMPLATE' then begin
      LineString := ReplaceStr(Trim(LineString), '$TEMPLATE' + #9, '');
      HeaderStrings := Trim(LineString);
      HeaderStrings := ReplaceStr(HeaderStrings, 'TypeName', 'TypeID');
      HeaderStrings := ReplaceStr(HeaderStrings, 'EmployeeName', 'EmployeeID');
      TableString := 'tbltemplates';
    end else if FirstField = 'TEMPLATE' then begin
      LineString := ReplaceStr(Trim(LineString), 'TEMPLATE' + #9, '');
      LineString := ModQtyDataStr(LineString);
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString) then begin
        NewId := InsertRecord(HeaderStrings, TableString, LineString);
        if NewId <> 0 then begin
          RTMFilePath := ExtractFileDir(TempFilePath) + '\TemplateFiles\' + FieldValueStrTempID + '.tcr';
          if IsFile(RTMFilePath) then begin
            ImportRTM(RTMFilePath, IntToStr(NewId));
          end;
        end;
      end;
    end else if FirstField = 'FINALTEMPLATE' then begin
      HeaderStrings := '';
      lblImporting.Caption := 'Preparing Templates .....  Please Wait ';
      Application.ProcessMessages;
    end;
  end;
end;

procedure TImportTemplatesGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
  ImportTemplatesGUI := nil;
end;

function  TImportTemplatesGUI.InsertRecord(const HeaderStrings, TableString, DataStrings: string):Integer;
var
  SQLString: string;
  SQLString1: string;
begin
    cmdInsertRecord.Connection := CommonDbLib.GetSharedMyDacConnection;
    SQLString  := 'INSERT HIGH_PRIORITY INTO ' + TableString + '(' + ReplaceStr(HeaderStrings, #9, #44) + ') VALUES ';
    SQLString1 := '(' + ReplaceStr(DataStrings, #9, #44) + ');';
    cmdInsertRecord.Sql.Clear;
    cmdInsertRecord.Sql.Add(SQLString);
    cmdInsertRecord.Sql.Add(SQLString1);

    REsult := InsertNow(SQLString, HeaderStrings, TableString, DataStrings);
end;

function TImportTemplatesGUI.UpdateRecord(const HeaderStrings, TableString, DataStrings: string): Integer;
var
  UpdateString, SQLString, WhereString: string;
begin
    //Convert Insert SQL String To Update SQL
    UpdateString := CreateUpdateString(HeaderStrings, DataStrings);
    //Create Update SQL Where Clause
    SQLString := 'UPDATE ' + TableString + ' SET ' + UpdateString + ';';

    //Create Update SQL Where Clause
    WhereString := CreateWhereString(UpdateString);
    SQLString   := 'UPDATE ' + TableString + ' SET ' + UpdateString + WhereString + ';';
    SQLString :=REplaceStr(SQLString , 'SET TemplID=NULL,' , 'SET ');
    cmdInsertRecord.Sql.Clear;
    cmdInsertRecord.Sql.Add(SQLString);

    UpdateNow(SQLString);
    with commondbLib.TempMyQuery do try
      connection := cmdInsertRecord.connection;
      SQL.add('select TemplID From tblTemplates ' + WhereString);
      open;
      REsult := fieldbyname('TemplID').asInteger;
    finally
        if active then close;
        Free;
    end;
end;

function TImportTemplatesGUI.UpdateNow(const SQLStr: string): boolean;
begin
  try
    Result := true;
    cmdInsertRecord.Execute;
  except
    on E: EMyError do Result := false;
  end;
end;


function TImportTemplatesGUI.InsertNow(const SQLStr, HeaderStrings, TableString, DataStrings: string): Integer;
var
  ThenUpdate: boolean;
begin
  Result := 0;
  try
    ThenUpdate := false;
    cmdInsertRecord.Execute;
    result := cmdInsertRecord.InsertId;
  except
    on E: EMyError do ThenUpdate := true;
  end;
  if ThenUpdate then begin
    result := UpdateRecord(HeaderStrings, TableString, DataStrings);
  end;
end;

function TImportTemplatesGUI.GetEmployeeID(const EmployeeName: string): integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
    
  try
    qryTemp.Sql.Add('SELECT EmployeeID FROM tblemployees WHERE Concat(FirstName," ",LastName) = ' +
      QuotedStr(EmployeeName) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('EmployeeID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TImportTemplatesGUI.GetTypeID(const TypeName: string): integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

  try
    qryTemp.Sql.Add('SELECT TypeID FROM tbltemplatetype WHERE TypeName = ' + QuotedStr(TypeName) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('TypeID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TImportTemplatesGUI.ModQtyDataStr(const LineStringTemp: string): string;
var
  StringTemp: string;
  FieldValueStrTypeName: string;
  FieldValueStrTemplName: string;
  FieldValueStrTemplateClass: string;
  FieldValueStrEmployee: string;
  StrTypeID: string;
  StrEmployeeID: string;
begin
  StringTemp := LineStringTemp;

  FieldValueStrTempID := StrExtStr(StringTemp, #9, 1);
  FieldValueStrTypeName := StrExtStr(StringTemp, #9, 2);
  StrTypeID := IntToStr(GetTypeID(FieldValueStrTypeName));
  FieldValueStrTemplName := StrExtStr(StringTemp, #9, 3);
  FieldValueStrTemplateClass := StrExtStr(StringTemp, #9, 4);
  FieldValueStrEmployee := StrExtStr(StringTemp, #9, 5);
  if trim(FieldValueStrEmployee) ='' then StrEmployeeID :=  '' else StrEmployeeID := IntToStr(GetEmployeeID(FieldValueStrEmployee));
  if StrEmployeeID ='' then StrEmployeeID := '0';

  StringTemp := ReplaceStr(StringTemp, FieldValueStrTempID + #9 + FieldValueStrTypeName + #9 +
    FieldValueStrTemplName + #9 + FieldValueStrTemplateClass + #9 + FieldValueStrEmployee,
    'NULL' + #9 + FieldValueStrTypeName + #9 + FieldValueStrTemplName + #9 +
    FieldValueStrTemplateClass + #9 + StrEmployeeID);
  StringTemp := ReplaceStr(StringTemp, 'NULL' + #9 + FieldValueStrTypeName, 'NULL'+ #9 + StrTypeID);

  StringTemp := ReplaceStr(StringTemp, #9, #34 + #9 + #34);

  StringTemp := #34 + StringTemp + #34;
  StringTemp := ReplaceStr(StringTemp, '"NULL"', 'NULL');

  if (StrTypeID = '0') then begin
    Result := '';
  end else begin
    Result := StringTemp;
  end;
end;

function TImportTemplatesGUI.CreateUpdateString(const HeaderStrings, DataStrings: string): string;
var
  TempString, CreatingString: string;
  FieldCount, I: integer;
begin
  TempString := '';
  CreatingString := '';
  FieldCount := FieldCounter(HeaderStrings);

  if FieldCount = 0 then begin
    FieldCount := 1;
  end;

  for I := 1 to FieldCount do begin
    TempString     := '';
    TempString     := TempString + StrExtStr(HeaderStrings, #9, I) + '=';
    TempString     := TempString + StrExtStr(DataStrings, #9, I) + ',';
    CreatingString := CreatingString + TempString
  end;
  CreatingString := Copy(CreatingString, 0, char_length(CreatingString) - 1);
  Result := CreatingString
end;

function TImportTemplatesGUI.FieldCounter(const TestString: string): integer;
var
  TempStr: string;
  S, Count, I: integer;
begin
  TempStr := TestString;
  Count := 1;

  for I := 1 to 200 do begin
    S := FastFuncs.PosEx(#9, TempStr);
    if S > 0 then begin
      Delete(TempStr, S, char_length(#9));
      Count := Count + 1;
    end else begin
      Break;
    end;
  end;
  Result := Count
end;

procedure TImportTemplatesGUI.ExtractFiles(const FileName, DataPath: string);
var
  aCab: TCabFile;
begin
  aCab := TCabFile.Create(nil);
  try
    aCab.CABFile:= FileName;
    aCab.GetContents;
    aCab.TargetPath:= DataPath;
    aCab.ExtractAll;
  finally
    FreeandNil(aCab);
  end;
end;

function TImportTemplatesGUI.CreateWhereString(const DataStrings: string): string;
var
  TempWhereField1, TempStr, CreatingString: string;
  Wherename, wheretype:String;
begin
  TempStr := DataStrings;
  wheretype:= ReplaceStr(StrExtStr(TempStr, #44, 2), #39, ' ');
  Wherename:= ReplaceStr(StrExtStr(TempStr, #44, 3), #39, ' ');
  TempWhereField1 :=  Wherename + ' and ' + wheretype;
  CreatingString := ' WHERE ' + TempWhereField1;
  Result := CreatingString;
end;
Function TImportTemplatesGUI.TypeHasaDefualtTemplate(typeId, ID:Integer):boolean;
begin
  With tempMyquery do try
    connection := qryTemplatesRTM.connection;
    SQL.add('Select TemplId from tbltemplates  where  TypeID  =' +inttostr(typeId) +'  and DefaultTemplate="T" and TemplID <> ' +inttostr(ID) );
    open;
    result:= recordcount >0;
  finally
    if active then close;
    Free;
  end;
end;
procedure TImportTemplatesGUI.ImportRTM(const FileName, ID: string);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    ms.LoadFromFile(FileName);
    with qryTemplatesRTM do begin
      Close;
      Params.ParamByName('ID').asString := ID;
      Open;
      if RecordCount < 1 then Exit;
      First;
      Edit;
      if qryTemplatesRTMDefaultTemplate.AsBoolean then
        if TypeHasaDefualtTemplate(qryTemplatesRTMtypeId.asInteger, qryTemplatesRTMTemplID.AsInteger) then
          qryTemplatesRTMDefaultTemplate.AsBoolean := False;

      ms.Position := 0;
      qryTemplatesRTMReport.LoadFromStream(ms);
      Post;
    end;
  finally
    FreeandNil(ms);
  end;
end;


procedure TImportTemplatesGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      if UserLock.IsLocked('tbltemplates', -1, 'Customise Templates') then begin
        AccessLevel := 6;
        EnableDisable;
        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + GetFormDescription(Self.ClassName) +
          ' Access is Denied.', mtWarning, [mbOK], 0);
      end;
      inherited;
      OpenQueries;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TImportTemplatesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  UserLock.Enabled := True;  
end;

initialization
  RegisterClassOnce(TImportTemplatesGUI);      
end.


