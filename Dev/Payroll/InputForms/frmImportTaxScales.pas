unit frmImportTaxScales;

interface

uses
  Windows, Forms, Dialogs, StdCtrls, Buttons, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar, Controls, ExtCtrls,
  Classes, SysUtils, MyAccess,ERPdbComponents, MyClasses, DB, {ComObj,} BaseInputForm, SelectionDialog,
  AppEvnts,  kbmMemTable, DBAccess, DataState,
  Menus, AdvMenus, Graphics, ImgList, MemDS, ProgressDialog, ConTnrs;

type
  TWhereTableName = (wtSCALENAME, wtSCALES);

  TWhereField = array[Low(TWhereTableName)..High(TWhereTableName)] of string;

const
  TableDesc: TWhereField = ('tbltaxscales', 'tbltax');

  WhereField: TWhereField = ('ScaleID', 'TaxID^ScaleID');


type
  TfrmImportTaxScalesGUI = class(TBaseInputGUI)
    OpenDialog1: TOpenDialog;
    SpeedButton1: TDNMSpeedButton;
    txtFilePath: TEdit;
    lblFile: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label23: TLabel;
    Bevel1: TBevel;
    lblImporting: TLabel;
    lblImporting2: TLabel;
    ImportProgressBar: TProgressBar;
    ImportProgressBar2: TProgressBar;
    memSqlStrings: TkbmMemTable;
    memSqlStringsID: TAutoIncField;
    memSqlStringsInsertSQL: TWideMemoField;
    memSqlStringsHeaderStrings: TWideMemoField;
    memSqlStringsTableString: TWideMemoField;
    memSqlStringsDataStrings: TWideMemoField;
    Label4: TLabel;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    btnHelp: TDNMSpeedButton;
    procedure btnCancelClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label4MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure Label4DblClick(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure Label12DblClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    EarlyClose: boolean;
    qryInsertRecord: TERPCommand;
    qryUpdateRecord: TERPCommand;
    qryTemp: TERPQuery;
    TextFileStrings: TStringList;
    UpdateStrings: TStringList;
    HeaderStrings: string;
    RegionID:Integer;
    TableString: string;
    TableType: TWhereTableName;
    LineNumber, FileLinesCount: integer;
    ErrorOccured: boolean;
    bEmpImported: boolean;
    F: TextFile;
    EncryptMode: boolean;
    DecryptMode: boolean;
    Keypressed: boolean;
    ExistingScalesDeleted:Boolean;
    Filter: string;
    EmpTaxScaleList: TObjectList;
    function IsDir(const DirPath: string): boolean;
    function IsFile(const FileName: string): boolean;
    function LineCount(const FileName: string): integer;
    function GetLineOfString(const I, LinesCount: integer): string;
    procedure ProcessLineOfString(const LineStr: string);
    function StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
    procedure InsertRecord(const HeaderStrings, TableString, DataStrings: string);
    function UpdateRecord(const HeaderStrings, TableString, DataStrings: string): boolean;
    function CreateUpdateString(const HeaderStrings, DataStrings: string): string;
    function CreateWhereString(const HeaderStrings, TableString, DataStrings: string): string;
    function TypeToTableName(const TableName: TWhereTableName): string;
    function TypeToWhereField(const TableName: TWhereTableName): string;
    function FieldCounter(const TestString: string): integer;
    function GetColumnNo(const ColumnHeading, HeaderStrings: string): integer;
    procedure UpdateRecords;
    procedure DeleteOldTaxScalesTables;
    procedure SaveEmployeeTaxScaleNames;
    procedure ReassignEmployeeTaxScales;
  public
    { Public declarations }

  end;

  TEmpTaxScaleRec = class
  public
    EmployeeID: integer;
    TaxScaleName: string;
    HECSTaxScaleName: string;
    StudentLoanTaxScaleName: string;
  end;


implementation

uses
  FastFuncs,DNMLib, StrUtils, CommonDbLib, DNMExceptions, CommonLib,
  CipherUtils, SystemLib, tcDataUtils,  AppEnvironment, ShellAPI,
  MemoDialog, PreferancesLib, ButtonsLib;


const
  KEYPHRASE = 'Tax Law Amendment -(PAYG) Withheld Tax Scales';
  {$R *.DFM}

procedure TfrmImportTaxScalesGUI.btnCancelClick(Sender: TObject);
begin
  EarlyClose := true;
  Self.Close;
end;

function TfrmImportTaxScalesGUI.IsDir(const DirPath: string): boolean;
begin
  Result := DirectoryExists(DirPath);
end;

function TfrmImportTaxScalesGUI.IsFile(const FileName: string): boolean;
begin
  Result := FileExists(FileName);
end;

function TfrmImportTaxScalesGUI.LineCount(const FileName: string): integer;
var
  Count: integer;
begin
  Count := 0;
  AssignFile(F, FileName);
  try
    {$I-}
    Reset(F);
    {$I+}
    IOResult;
    while not Eof(F) do begin
      Readln(F);
      Inc(Count);
    end;
    CloseFile(F);
    Result := Count;
  except
    CommonLib.MessageDlgXP_Vista('File is Already in Use!', mtWarning, [mbOK], 0);
    Result := 0;
  end;
end;

procedure TfrmImportTaxScalesGUI.SaveEmployeeTaxScaleNames;
var
  qry: TERPQuery;
  rec: TEmpTaxScaleRec;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select EmployeeID,');
    qry.SQL.Add('(select tblTaxScales.ScaleDescription from tblTaxScales where tblemployees.TaxScaleID = tblTaxScales.ScaleID) as TaxScaleName,');
    qry.SQL.Add('(select tblTaxScales.ScaleDescription from tblTaxScales where tblemployees.HECSTaxScale = tblTaxScales.ScaleID) as HECSTaxScaleName,');
    qry.SQL.Add('(select tblTaxScales.ScaleDescription from tblTaxScales where tblemployees.StudentLoanTaxScale = tblTaxScales.ScaleID) as StudentLoanTaxScaleName');
    qry.SQL.Add(' from tblemployees');
    qry.Open;
    while not qry.Eof do begin
      rec := TEmpTaxScaleRec.Create;
      rec.EmployeeID := qry.FieldByName('EmployeeId').AsInteger;
      rec.TaxScaleName := qry.FieldByName('TaxScaleName').AsString;
      rec.HECSTaxScaleName := qry.FieldByName('HECSTaxScaleName').AsString;
      rec.StudentLoanTaxScaleName := qry.FieldByName('StudentLoanTaxScaleName').AsString;
      EmpTaxScaleList.Add(rec);
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmImportTaxScalesGUI.SpeedButton1Click(Sender: TObject);
begin
  if EncryptMode then begin
    if OpenDialog1.Execute then begin
      Opendialog1.FileName;
      CipherUtils.Encrypt(Opendialog1.FileName, Opendialog1.FileName + '.enc',KEYPHRASE);
    end;
  end else if DecryptMode then begin
    if OpenDialog1.Execute then begin
      Opendialog1.FileName;
      CipherUtils.Decrypt(Opendialog1.FileName, Opendialog1.FileName + '.dec',KEYPHRASE);
    end;
  end else begin
    if OpenDialog1.Execute then begin
      txtFilePath.Text := Opendialog1.FileName;
    end;
  end;
  DecryptMode := false;
  EncryptMode := false;
  Keypressed := false;
end;

procedure TfrmImportTaxScalesGUI.btnHelpClick(Sender: TObject);
var
  helpfilename:String;
begin
  inherited;
  helpfilename := '\\erp-svr1\Data\ERP Packages\TaxScales\Instructions on creating tax file.txt';
  ShellExecute(Handle, 'open', PChar(helpfilename), '', '', SW_SHOW);
end;

procedure TfrmImportTaxScalesGUI.btnOKClick(Sender: TObject);
var
  LINESTRING: string;
  I, Count: integer;
  FileName: string;
begin
  DisableForm;
  try
    btnOK.Enabled := false;
    btnCancel.Enabled := false;
    try
      bEmpImported  := false;
      HeaderStrings := '';
      RegionID:=AppEnv.RegionalOptions.ID;
      if empty(txtFilePath.Text) then begin
        Self.SpeedButton1Click(Sender);
        exit;
      end;
      if IsDir(ExtractFileDir(txtFilePath.Text)) then begin
        if IsFile(txtFilePath.Text) then begin
          //Import Function
          lblImporting.Caption := 'Please Wait Loading Data ..... 0%';
          lblImporting.Visible := true;

          //Decrypt File
          FileName := WinTempDir + ExtractFileName(txtFilePath.Text);
          CipherUtils.Decrypt(txtFilePath.Text, FileName,KEYPHRASE);

          FileLinesCount := LineCount(FileName);
          if (FileLinesCount = 0) then begin
            Self.Close;
            Exit;
          end;
          ImportProgressBar.Min := 0;
          ImportProgressBar.Max := FileLinesCount;
          ImportProgressBar.Position := ImportProgressBar.Min;
          try
            AssignFile(F, FileName);
            Reset(F);
            Count := FileLinesCount;
            TextFileStrings.Clear;
            for I := 1 to Count do begin
              //get next Line
              LineNumber := I;
              LINESTRING := GetLineOfString(I, FileLinesCount);
              LINESTRING := Trim(LINESTRING);
              if not empty(LINESTRING) then TextFileStrings.Add(LINESTRING);
            end;
            UpdateStrings.Clear;
            memSqlStrings.Open;
            //DeleteOldTaxScalesTables;
            self.SaveEmployeeTaxScaleNames;
            ExistingScalesDeleted := False;
            try
                for I := 0 to TextFileStrings.Count - 1 do begin
                  if EarlyClose then Exit;
                  ProcessLineOfString(TextFileStrings.Strings[I]);
                  ImportProgressBar.StepIt;
                  lblImporting.Caption := 'Please Wait Loading Data ..... ' + FloatToStrF(((I / TextFileStrings.Count) * 100),
                    ffFixed, 18, 0) + '% Complete';
                  Application.ProcessMessages;
                end;
            finally
              ExistingScalesDeleted:= False;
              self.ReassignEmployeeTaxScales;
            end;
          finally
            CloseFile(f);
            DeleteFile(FileName);
          end;
          lblImporting.Visible := true;
          PreferancesLib.DoPrefAuditTrail;
          Self.Close;
        end else begin
          CommonLib.MessageDlgXP_Vista('File "' + txtFilePath.Text + '"' + #13 + 'Does Not Exist !', mtWarning, [mbOK], 0);
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFilePath.Text) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
      end;
    finally
      btnOK.Enabled     := true;
      btnCancel.Enabled := true;
    end;
  finally
    EnableForm;
  end;
end;

function TfrmImportTaxScalesGUI.StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
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

function TfrmImportTaxScalesGUI.GetLineOfString(const I, LinesCount: integer): string;
begin
  try
    Readln(F, Result);
  except
    on EInOutError do Result := '';
  end;
end;

procedure TfrmImportTaxScalesGUI.ProcessLineOfString(const LineStr: string);
var
  LineString1, FirstField1,ScaleName, TypeImport1,RegionName: string;
  Procedure Processregion;
  begin
    if FirstField1 = '$REGIONNAME' then begin
    end else if FirstField1 = 'REGIONNAME' then begin
      RegionName  := StrExtStr(LineString1, #9, 2);
      REgionID    := GetRegion(RegionName);
    end else if FirstField1 = 'FINALREGIONNAME' then begin
      DeleteOldTaxScalesTables;
    end;
  end;
  Procedure ProcessScaleNames;
  begin
    if FirstField1 = '$SCALENAME' then begin
      LineString1 := ReplaceStr(LineString1, '$SCALENAME' + #9, '');
      if (RegionID<>0)  then begin
        LineString1 := 'RegionID' + #9 +LineString1;
      end;
      HeaderStrings := ReplaceStr(LineString1, #9, #44);
      TableType := wtSCALENAME;
      TableString := TypeToTableName(TableType);
      DeleteOldTaxScalesTables;
    end else if FirstField1 = 'SCALENAME' then begin
      LineString1 := ReplaceStr(LineString1, 'SCALENAME' + #9, '');
      if (RegionID<>0)  then begin
          LineString1 := inttostr(REgionID) +#9+ LineString1;
      end;
      LineString1 := ReplaceStr(LineString1, #9, #39 + #44 + #39);
      LineString1 := #39 + LineString1 + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString1) then begin
        InsertRecord(HeaderStrings, TableString, LineString1);
      end;
    end else if FirstField1 = 'FINALSCALENAME' then begin
      HeaderStrings := '';
      UpdateRecords;
    end;
  end;
  Procedure ProcessScales;
  var
    scaleID:Integer;
  begin
    if FirstField1 = '$SCALES' then begin
      LineString1 := ReplaceStr(LineString1, '$SCALES' + #9, '');
      HeaderStrings := ReplaceStr(LineString1, #9, #44);
      TableType := wtSCALES;
      TableString := TypeToTableName(TableType);
      DeleteOldTaxScalesTables;
    end else if FirstField1 = 'SCALES' then begin
      LineString1 := ReplaceStr(LineString1, 'SCALES' + #9, '');
      ScaleName := StrExtStr(LineString1, #9, 1);
      if not(ISInteger(ScaleName)) and (pos(scaleName+#9 ,LineString1 )=1) then begin
        ScaleID := getaxScaleID(ScaleName);
        LineString1 := StringReplace(LineString1, ScaleName +#9 , inttostr(scaleID)+#9,[]);
      end;
      LineString1 := ReplaceStr(LineString1, #9, #39 + #44 + #39);
      LineString1 := #39 + LineString1 + #39;
      if not empty(HeaderStrings) and not empty(TableString) and not empty(LineString1) then begin
        InsertRecord(HeaderStrings, TableString, LineString1);
      end;
    end else if FirstField1 = 'FINALSCALES' then begin
      HeaderStrings := '';
      UpdateRecords;
    end;
  end;
begin
  LineString1 := LineStr;
  FirstField1 := StrExtStr(LineString1, #9, 1);
  TypeImport1 := ReplaceStr(FirstField1, '$', '');
  TypeImport1 := ReplaceStr(TypeImport1, 'FINAL', '');
  if TypeImport1 = 'REGIONNAME' then begin
    Processregion;
  end else if TypeImport1 = 'SCALENAME' then begin
    ProcessScaleNames;
  end else if TypeImport1 = 'SCALES' then begin
    ProcessScales;
  end;
end;

procedure TfrmImportTaxScalesGUI.ReassignEmployeeTaxScales;
var
  qryEmp: TERPQuery;
  qryScale: TERPQuery;
  x: integer;
  rec: TEmpTaxScaleRec;
  sl: TStringList;
begin
  qryEmp := TERPQuery.Create(nil);
  qryScale := TERPQuery.Create(nil);
  sl := TStringList.Create;
  try
    qryEmp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryScale.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryEmp.SQL.Add('select * from tblemployees where EmployeeID = :ID');
    qryScale.SQL.Add('select * from tbltaxscales where ScaleDescription = :Desc');
    for x := 0 to EmpTaxScaleList.Count -1 do begin
      rec := TEmpTaxScaleRec(EmpTaxScaleList[x]);
      try
        qryEmp.ParamByName('ID').AsInteger := rec.EmployeeID;
        qryEmp.Open;

        if rec.TaxScaleName <> '' then begin
          qryScale.Close;
          qryScale.ParamByName('Desc').AsString := rec.TaxScaleName;
          qryScale.Open;
          if qryScale.IsEmpty then begin
            sl.Add('Tax Scale "' + rec.TaxScaleName + '" not found for Employee ' + qryEmp.FieldByName('EmployeeName').AsString);
          end
          else begin
            if qryEmp.FieldByName('TaxScaleID').AsInteger <> qryScale.FieldByName('ScaleId').AsInteger then begin
              EditDb(qryEmp);
              qryEmp.FieldByName('TaxScaleID').AsInteger := qryScale.FieldByName('ScaleId').AsInteger;
            end;
          end;
        end;

        if rec.HECSTaxScaleName <> '' then begin
          qryScale.Close;
          qryScale.ParamByName('Desc').AsString := rec.HECSTaxScaleName;
          qryScale.Open;
          if qryScale.IsEmpty then begin
            sl.Add('HECS Tax Scale "' + rec.HECSTaxScaleName + '" not found for Employee ' + qryEmp.FieldByName('EmployeeName').AsString);
          end
          else begin
            if qryEmp.FieldByName('HECSTaxScale').AsInteger <> qryScale.FieldByName('ScaleId').AsInteger then begin
              EditDb(qryEmp);
              qryEmp.FieldByName('HECSTaxScale').AsInteger := qryScale.FieldByName('ScaleId').AsInteger;
            end;
          end;
        end;

        if rec.StudentLoanTaxScaleName <> '' then begin
          qryScale.Close;
          qryScale.ParamByName('Desc').AsString := rec.StudentLoanTaxScaleName;
          qryScale.Open;
          if qryScale.IsEmpty then begin
            sl.Add('Student Loan Tax Scale "' + rec.StudentLoanTaxScaleName + '" not found for Employee ' + qryEmp.FieldByName('EmployeeName').AsString);
          end
          else begin
            if qryEmp.FieldByName('StudentLoanTaxScale').AsInteger <> qryScale.FieldByName('ScaleId').AsInteger then begin
              EditDb(qryEmp);
              qryEmp.FieldByName('StudentLoanTaxScale').AsInteger := qryScale.FieldByName('ScaleId').AsInteger;
            end;
          end;
        end;

        PostDb(qryEmp);
      finally
        qryEmp.Close;
        qryScale.Close;
      end;
    end;
    if sl.Count > 0 then begin
      MemoDialog.DoMemoDialog('Tax Scale Import Errors',sl.Text,ssBoth);
    end;
  finally
    EmpTaxScaleList.Clear;
    qryEmp.Free;
    qryScale.Free;
    sl.Free;
  end;
end;

procedure TfrmImportTaxScalesGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;

end;

procedure TfrmImportTaxScalesGUI.InsertRecord(const HeaderStrings, TableString, DataStrings: string);
var
  SQLString: string;
begin
  SQLString := 'INSERT HIGH_PRIORITY INTO ' + TableString + '(' + HeaderStrings + ') VALUES (' + DataStrings + ');';
  memSqlStrings.Insert;
  memSqlStringsInsertSQL.AsString := SQLString;
  memSqlStringsHeaderStrings.AsString := HeaderStrings;
  memSqlStringsTableString.AsString := TableString;
  memSqlStringsDataStrings.AsString := DataStrings;
  memSqlStrings.Post;
end;

function TfrmImportTaxScalesGUI.UpdateRecord(const HeaderStrings, TableString, DataStrings: string): boolean;
var
  UpdateString, WhereString, SQLString: string;
begin
  //Convert Insert SQL String To Update SQL
  UpdateString := CreateUpdateString(HeaderStrings, DataStrings);
  //Create Update SQL Where Clause
  WhereString := CreateWhereString(HeaderStrings, TableString, DataStrings);

  if (GetColumnNo('CompanyName', HeaderStrings) = 1) and (GetColumnNo('Address', HeaderStrings) = 2) then begin
    WhereString := FastFuncs.LeftStr(WhereString, (char_length(WhereString) - 1));
  end;

  SQLString := 'UPDATE ' + TableString + ' SET ' + UpdateString + WhereString + ';';
  UpdateStrings.Add(SQLString);
  Result := true;
end;



function TfrmImportTaxScalesGUI.TypeToTableName(const TableName: TWhereTableName): string;
begin
  Result := TableDesc[TableName];
end;

function TfrmImportTaxScalesGUI.TypeToWhereField(const TableName: TWhereTableName): string;
begin
  Result := WhereField[TableName];
end;

function TfrmImportTaxScalesGUI.FieldCounter(const TestString: string): integer;
var
  TempStr: string;
  S, Count, I: integer;
begin
  TempStr := TestString;
  Count := 1;

  for I := 1 to 200 do begin
    S := FastFuncs.PosEx(#44, TempStr);
    if S > 0 then begin
      Delete(TempStr, S, char_length(#44));
      Count := Count + 1;
    end else begin
      Break;
    end;
  end;
  Result := Count
end;

function TfrmImportTaxScalesGUI.CreateUpdateString(const HeaderStrings, DataStrings: string): string;
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
    TempString     := TempString + StrExtStr(HeaderStrings, #44, I) + '=';
    TempString     := TempString + StrExtStr(DataStrings, #44, I) + ',';
    CreatingString := CreatingString + TempString
  end;
  CreatingString := Copy(CreatingString, 0, char_length(CreatingString) - 1);
  Result := CreatingString
end;

function TfrmImportTaxScalesGUI.CreateWhereString(const HeaderStrings, TableString, DataStrings: string): string;
var
  TempWhereField1, TempWhereField2, TempWhereField3, TempWhereField4, TempWhereField5, TempWhereField6,
  TempWhereField7, TempWhereField8, TempWhereField9: string;
  TempStr, CreatingString: string;
  FieldCount, I: integer;
begin
  TempStr := '';
  TempWhereField1 := '';
  TempWhereField2 := '';
  TempWhereField3 := '';
  TempWhereField4 := '';
  TempWhereField5 := '';
  TempWhereField6 := '';
  TempWhereField7 := '';
  TempWhereField8 := '';
  TempWhereField9 := '';

  case TableType of
    wtSCALES:

      begin
        TempStr := TypeToWhereField(TableType);
        TempWhereField1 := StrExtStr(TempStr, '^', 1);
        TempWhereField2 := StrExtStr(TempStr, '^', 2);
        TempWhereField3 := StrExtStr(TempStr, '^', 3);
        TempWhereField4 := StrExtStr(TempStr, '^', 4);
        TempWhereField5 := StrExtStr(TempStr, '^', 5);
        TempWhereField6 := StrExtStr(TempStr, '^', 6);
        TempWhereField7 := StrExtStr(TempStr, '^', 7);
        TempWhereField8 := StrExtStr(TempStr, '^', 8);
        TempWhereField9 := StrExtStr(TempStr, '^', 9);

        CreatingString := ' WHERE ' + TempWhereField1 + '=';
        FieldCount := FieldCounter(HeaderStrings);

        if FieldCount = 0 then begin
          FieldCount := 1;
        end;
        TempStr := '';
        for I := 1 to FieldCount do begin
          if StrExtStr(HeaderStrings, #44, I) = TempWhereField1 then begin
            TempStr := StrExtStr(DataStrings, #44, I);
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
            Break;
          end;
        end;
        if Empty(TempStr) then begin
          if Empty(TempStr) then TempStr := '""';
          CreatingString := CreatingString + TempStr;
        end;
        //2
        if not Empty(TempWhereField2) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField2 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField2 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///3
        if not Empty(TempWhereField3) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField3 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField3 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///4
        if not Empty(TempWhereField4) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField4 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField4 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///5
        if not Empty(TempWhereField5) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField5 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField5 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///6
        if not Empty(TempWhereField6) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField6 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField6 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///7
        if not Empty(TempWhereField7) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField7 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField7 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///8
        if not Empty(TempWhereField8) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField8 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField8 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
        ///9
        if not Empty(TempWhereField9) then begin
          CreatingString := CreatingString + ' AND ' + TempWhereField9 + '=';
          TempStr := '';
          for I := 1 to FieldCount do begin
            if StrExtStr(HeaderStrings, #44, I) = TempWhereField9 then begin
              TempStr := StrExtStr(DataStrings, #44, I);
              if Empty(TempStr) then TempStr := '""';
              CreatingString := CreatingString + TempStr;
              Break;
            end;
          end;
          if Empty(TempStr) then begin
            if Empty(TempStr) then TempStr := '""';
            CreatingString := CreatingString + TempStr;
          end;
        end;
      end;

    else begin
        CreatingString := ' WHERE ' + TypeToWhereField(TableType) + '=';
        FieldCount := FieldCounter(HeaderStrings);

        if FieldCount = 0 then begin
          FieldCount := 1;
        end;


        for I := 1 to FieldCount do begin
          if StrExtStr(HeaderStrings, #44, I) = TypeToWhereField(TableType) then begin
            TempStr := StrExtStr(DataStrings, #44, I);
            CreatingString := CreatingString + TempStr;
            Break;
          end;
        end;
        if Empty(TempStr) then begin
          CreatingString := CreatingString + TempStr;
        end;
      end;
  end;
  Result := CreatingString;
end;

function TfrmImportTaxScalesGUI.GetColumnNo(const ColumnHeading, HeaderStrings: string): integer;
var
  TotalStrLength, CurrentStrLength, Count, I: integer;
  TempStrValue: string;
begin
  Count := 0;
  CurrentStrLength := 0;
  TotalStrLength := char_length(HeaderStrings);

  for I := 1 to TotalStrLength do begin
    Count        := I;
    TempStrValue := StrExtStr(HeaderStrings, #44, I);

    if (uppercase(TempStrValue) = uppercase(ColumnHeading)) then begin
      Break;
    end;

    CurrentStrLength := CurrentStrLength + char_length(TempStrValue);

    if (CurrentStrLength = TotalStrLength) then begin
      Count := 0;
      Break;
    end;
  end;

  Result := Count;
end;

procedure TfrmImportTaxScalesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  FormatBtnHelp(btnhelp);
  ExistingScalesDeleted:= False;
  Label12.Caption := '';
  EncryptMode := false;
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.ParamCheck := false;
  qryUpdateRecord := TERPCommand.Create(nil);
  qryUpdateRecord.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryInsertRecord := TERPCommand.Create(nil);
  qryInsertRecord.Connection := CommonDbLib.GetSharedMyDacConnection;
  TextFileStrings := TStringList.Create;
  UpdateStrings := TStringList.Create;
  memSqlStrings.Close;
  memSqlStrings.EmptyTable;
  memSqlStrings.Standalone := true;
  memSqlStrings.Performance := mtpfFast;
  memSqlStrings.EnableIndexes := false;
  ErrorOccured := false;
  EmpTaxScaleList := TObjectList.Create(true);

end;

procedure TfrmImportTaxScalesGUI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryTemp);
  FreeAndNil(qryUpdateRecord);
  FreeAndNil(qryInsertRecord);
  FreeAndNil(TextFileStrings);
  FreeAndNil(UpdateStrings);
  EmpTaxScaleList.Free;
  inherited;
end;


procedure TfrmImportTaxScalesGUI.FormShow(Sender: TObject);
begin
  btnHelp.Visible := Devmode;
  try
    inherited;
    Filter:= OpenDialog1.Filter;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TfrmImportTaxScalesGUI.UpdateRecords;
var
  qryExec: TERPCommand;
  I, C: integer;
begin
  UpdateStrings.Clear;
  memSqlStrings.EnableIndexes := true;
  memSqlStrings.UpdateIndexes;
  qryExec := TERPCommand.Create(Self);
  try
    qryExec.Connection := CommonDbLib.GetSharedMyDacConnection;
    ImportProgressBar2.Min := 0;
    ImportProgressBar2.Max := memSqlStrings.RecordCount + 2;
    ImportProgressBar2.Position := ImportProgressBar2.Min;
    lblImporting2.Caption := 'Please Wait Importing ..... 0%';
    lblImporting2.Visible := true;
    ImportProgressBar2.Visible := true;
    C := 0;
    memSqlStrings.First;
    while not memSqlStrings.Eof do begin
      C := C + 1;
      qryExec.SQL.Clear;
      qryExec.SQL.Text := memSqlStringsInsertSQL.AsString;
      Application.ProcessMessages;
//      with TStringList.Create do begin
//        if FileExists('c:\temp\tax_scales.txt') then loadfromfile('c:\temp\tax_scales.txt');
//        Add(memSqlStringsInsertSQL.AsString);
//        savetofile('c:\temp\tax_scales.txt');
//        free;
//      end;
      try
        qryExec.Execute;
      except
        on E: EMyError do begin
          UpdateRecord(memSqlStringsHeaderStrings.AsString, memSqlStringsTableString.AsString,
            memSqlStringsDataStrings.AsString);
        end;
      end;
      memSqlStrings.Next;
      ImportProgressBar2.StepIt;
      lblImporting2.Caption := 'Please Wait Importing ..... ' + FloatToStrF(((C / (memSqlStrings.RecordCount + 1)) * 100),
        ffFixed, 18, 0) + '% Complete';
      Application.ProcessMessages;
    end;
    memSqlStrings.Close;
    memSqlStrings.EmptyTable;
    memSqlStrings.Open;
    //###########
    ImportProgressBar2.Min      := 0;
    ImportProgressBar2.Max      := UpdateStrings.Count + 2;
    ImportProgressBar2.Position := ImportProgressBar2.Min;
    lblImporting2.Caption       := 'Please Wait Updating ..... 0%';
    lblImporting2.Visible       := true;

    for I := 0 to UpdateStrings.Count - 1 do begin
      qryExec.SQL.Clear;
      qryExec.SQL.Text := UpdateStrings.Strings[I];
      Application.ProcessMessages;
      try
        qryExec.Execute;
      except
        on E: EMyError do if devmode then MessageDlgXP_Vista(E.message, mtWarning, [mbOK], 0);
        on E: Exception do if devmode then MessageDlgXP_Vista(E.message, mtWarning, [mbOK], 0);
      end;
      ImportProgressBar2.StepIt;
      lblImporting2.Caption := 'Please Wait Updating ..... ' + FloatToStrF(((I / (UpdateStrings.Count + 1)) * 100),
        ffFixed, 18, 0) + '% Complete';
      Application.ProcessMessages;
    end;
  finally
    FreeAndNil(qryExec);
  end;
  ImportProgressBar2.Position := ImportProgressBar2.Min;
  lblImporting2.Visible := false;
  UpdateStrings.Clear;
end;

procedure TfrmImportTaxScalesGUI.Label4MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited;
  if (Shift = [ssShift, ssCtrl, ssLeft]) then begin
    Keypressed := true;
  end else begin
    Keypressed := false;
  end;
end;

procedure TfrmImportTaxScalesGUI.Label4DblClick(Sender: TObject);
begin
  inherited;
  if Keypressed then begin
    EncryptMode := not EncryptMode;
//    DecryptMode := false;
    DecryptMode := not EncryptMode;
    if DecryptMode then
      lblFile.Caption:=  'Select Import File :' + ' [Decrypt Mode]'
    else if EncryptMode then
      lblFile.Caption:=  'Select Import File :' + ' [Encrypt Mode - Select the file To Encrypt]'
    else
      lblFile.Caption:=  'Select Import File :';
    lblFile.Refresh;
    Refresh;
    Application.ProcessMessages;
    if DecryptMode or EncryptMode then
      OpenDialog1.Filter:= Filter + '| All Files (*.*)|*.*'
    else
      OpenDialog1.Filter:= Filter;
  end;
end;

procedure TfrmImportTaxScalesGUI.DeleteOldTaxScalesTables;
var
  qryTemp: TERPCommand;
begin
  if ExistingScalesDeleted then exit;
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try

    qryTemp.Sql.Add('DELETE FROM tbltax');
    //if REgionId <> 0 then qryTemp.Sql.Add('where ScaleId in (select ScaleID from tbltaxscales where regionid = ' + inttostr(RegionID) +')');
    qryTemp.Execute;

    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DELETE FROM tbltaxscales');
    //if REgionID<> 0 then qryTemp.Sql.Add('where Regionid = ' + inttostr(RegionID));
    qryTemp.Execute;

  finally
    ExistingScalesDeleted:= TRue;
    FreeAndNil(qryTemp);
  end;
end;

procedure TfrmImportTaxScalesGUI.Label12DblClick(Sender: TObject);
var
  qryScales, qryTax: TERPQuery;
  s: string;
  sl: TStringList;
  yr: integer;
  filename: string;
begin
  inherited;
  if Keypressed then begin
    qryScales := TERPQuery.Create(nil);
    qryTax := TERPQuery.Create(nil);
    sl:= TStringList.Create;
    try
      qryScales.Connection := GetSharedMyDacConnection;
      qryTax.Connection := GetSharedMyDacConnection;
      qryScales.SQL.Text := 'select * from tbltaxscales';
      qryTax.SQL.Text := 'select * from tbltax order by ScaleID asc, Threshold desc';
      s := InputBox('Tax Year Start','Year Start',FormatDateTime('yyyy',now)+ '-07-01');
      yr := 0;
      if s <> '' then begin
        yr := StrToIntDef(Copy(s,1,4),0);
        if yr = 0 then begin
          CommonLib.MessageDlgXP_Vista('Invalid start date.',mtError,[mbOk],0);
          exit;
        end;
        qryScales.Open;

        sl.Add('$SCALENAME' + #9 + 'scaleid' + #9 + 'ScaleDescription' + #9 + 'LastUpdated');
        while not qryScales.Eof do begin
          sl.Add('SCALENAME' + #9 + qryScales.FieldByName('ScaleId').AsString + #9 + qryScales.FieldByName('ScaleDescription').AsString + #9 + IntToStr(yr) + '-07-01');
          qryScales.Next;
        end;
        sl.Add('FINALSCALENAME');

        qryTax.Open;
        sl.Add('$SCALES' + #9 + 'scaleid' + #9 + 'threshold' + #9 + 'a' + #9 + 'b');
        while not qryTax.Eof do begin
          sl.Add('SCALES' + #9 + qryTax.FieldByName('ScaleId').AsString + #9 + qryTax.FieldByName('Threshold').AsString + #9 + qryTax.FieldByName('A').AsString + #9 +  qryTax.FieldByName('B').AsString);
          qryTax.Next;
        end;
        sl.Add('FINALSCALES');
      end;
      filename := GetDesktopDir + 'ERP_Tax_Scales_'+ IntToStr(yr) + '_' + IntToStr(yr+1) + '.csv';
      sl.SaveToFile(filename);
      CommonLib.MessageDlgXP_Vista('File Saved:' + #13#10 + filename,mtInformation,[mbOk],0);
      CipherUtils.Encrypt(filename, Changefileext(filename,'.pts'),KEYPHRASE);
    finally
      qryScales.Free;
      qryTax.Free;
      sl.Free;
    end;

  end;
end;

procedure TfrmImportTaxScalesGUI.Label1DblClick(Sender: TObject);
begin
  inherited;
  if Keypressed then begin
    DecryptMode := not DecryptMode;
    EncryptMode := false;
    if DecryptMode then
      lblFile.Caption:=  'Select Import File :' + ' [Decrypt Mode]'
    else if EncryptMode then
      lblFile.Caption:=  'Select Import File :' + ' [Encrypt Mode]'
    else
      lblFile.Caption:=  'Select Import File :';
    lblFile.Refresh;
    Refresh;
    Application.ProcessMessages;
    if DecryptMode or EncryptMode then
      OpenDialog1.Filter:= Filter + '| All Files (*.*)|*.*'
    else
      OpenDialog1.Filter:= Filter;
  end;
end;

initialization
  RegisterClassOnce(TfrmImportTaxScalesGUI);
end.
