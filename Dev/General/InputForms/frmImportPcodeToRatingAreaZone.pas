unit frmImportPcodeToRatingAreaZone;

interface

uses
  Windows, Forms, Dialogs, StdCtrls, Buttons, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar, Controls, ExtCtrls,
  Classes, SysUtils, DB, BaseInputForm, SelectionDialog,
  AppEvnts, MyAccess,ERPdbComponents,  DBAccess, DataState, Menus, AdvMenus, Graphics, Shader,
  DNMPanel;

type
  TImportPcodeToRatingAreaZoneGUI = class(TBaseInputGUI)
    OpenDialog1: TOpenDialog;
    SpeedButton1: TDNMSpeedButton;
    txtFilePath: TEdit;
    Letter_Label: TLabel;
    lblImporting: TLabel;
    ImportProgressBar: TProgressBar;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    qryInsertRecord: TERPCommand;
    qryTemp: TERPCommand;
    HeaderStrings: string;
    TableString: string;
    F: TextFile;
    LineNumber, FileLinesCount: integer;
    ErrorOccured: boolean;
    bEmpImported: boolean;
    function IsDir(const DirPath: string): boolean;
    function IsFile(const FileName: string): boolean;
    function LineCount(const FileName: string): integer;
    function GetLineOfString(const I, LinesCount: integer): string;
    procedure ProcessLineOfString(const LineString: string);
    procedure InsertRecord(const HeaderStrings, TableString, DataStrings: string);
    function InsertNow: boolean;
    procedure ClearTNTTable;
  public
    { Public declarations }
    
  end;

implementation

uses FastFuncs,StrUtils, CommonDbLib, DNMExceptions, CommonLib;

const
  Delimiter = '|';

{$R *.DFM}

procedure TImportPcodeToRatingAreaZoneGUI.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

function TImportPcodeToRatingAreaZoneGUI.IsDir(const DirPath: string): boolean;
begin
  Result := DirectoryExists(DirPath);
end;

function TImportPcodeToRatingAreaZoneGUI.IsFile(const FileName: string): boolean;
begin
  Result := FileExists(FileName);
end;

function TImportPcodeToRatingAreaZoneGUI.LineCount(const FileName: string): integer;
var
  Count: integer;
begin
  Count := 0;
  AssignFile(F, FileName);
  try
    Reset(F);
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


procedure TImportPcodeToRatingAreaZoneGUI.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    txtFilePath.Text := Opendialog1.FileName;
  end;
end;

procedure TImportPcodeToRatingAreaZoneGUI.btnOKClick(Sender: TObject);
var
  LINESTRING: string;
  I, Count: integer;
begin
  DisableForm;
  try
    btnOK.Enabled := false;
    try
      bEmpImported  := false;
      HeaderStrings := '';
      if empty(txtFilePath.Text) then begin
        SpeedButton1Click(Sender);
      end;
      if IsDir(ExtractFileDir(txtFilePath.Text)) then begin
        if IsFile(txtFilePath.Text) then begin
          //Import Function
          lblImporting.Caption := 'Please Wait Importing ..... 0%';
          lblImporting.Visible := true;
          FileLinesCount := LineCount(txtFilePath.Text);
          if (FileLinesCount = 0) then begin
            Self.Close;
            Exit;
          end;
          ImportProgressBar.Min := 0;
          ImportProgressBar.Max := FileLinesCount;
          ImportProgressBar.Position := ImportProgressBar.Min;
          try
            AssignFile(F, txtFilePath.Text);
            Reset(F);
            Count := FileLinesCount;
            //Clean TNT Postcode To Rates Table Before new import ;
            ClearTNTTable;
            for I := 1 to Count do begin
              //get next Line
              LineNumber := I;

              LINESTRING := GetLineOfString(I, FileLinesCount);

              // Process Line String
              LINESTRING := Trim(LINESTRING);
              if not empty(LINESTRING) then ProcessLineOfString(LINESTRING);
            end;
          finally
            CloseFile(f);
          end;
          lblImporting.Visible := true;
          Self.Close;
        end else begin
          CommonLib.MessageDlgXP_Vista('File "' + txtFilePath.Text + '"' + #13 + 'Does Not Exist !', mtWarning, [mbOK], 0);
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFilePath.Text) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
      end;
    finally
      btnOK.Enabled := true;
    end;
  finally
    EnableForm;
  end;  
end;

function TImportPcodeToRatingAreaZoneGUI.GetLineOfString(const I, LinesCount: integer): string;
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

procedure TImportPcodeToRatingAreaZoneGUI.ProcessLineOfString(const LineString: string);
var
  LineStr: string;
begin
  LineStr := LineString;
  if Empty(HeaderStrings) and (LineNumber = 1) then begin
    HeaderStrings := ReplaceStr(LineStr, Delimiter, #44);
    TableString   := 'tblTNTPostCodeToRatingAreaZone';
  end else begin
    LineStr := ReplaceStr(LineStr, Delimiter, #39 + #44 + #39);
    LineStr := #39 + LineStr + #39;
    if not empty(HeaderStrings) and not empty(TableString) and not empty(LineStr) then begin
      InsertRecord(HeaderStrings, TableString, LineStr);
    end;
  end;
end;

procedure TImportPcodeToRatingAreaZoneGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TImportPcodeToRatingAreaZoneGUI.InsertRecord(const HeaderStrings, TableString, DataStrings: string);
var
  SQLString: string;
begin
  try
    qryInsertRecord := TERPCommand.Create(nil);
    qryInsertRecord.Connection := CommonDbLib.GetSharedMyDacConnection;
    SQLString       := 'INSERT HIGH_PRIORITY INTO ' + TableString + '(' + HeaderStrings + ') VALUES (' + DataStrings + ');';
    qryInsertRecord.Sql.Add(SQLString);
    InsertNow;
  finally
    FreeandNil(qryInsertRecord);
  end;
end;

function TImportPcodeToRatingAreaZoneGUI.InsertNow: boolean;
begin
  Result := true;
  try
    qryInsertRecord.Execute;
  except
    Result := false;
  end;
end;

procedure TImportPcodeToRatingAreaZoneGUI.FormCreate(Sender: TObject);
begin
  inherited;
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  ErrorOccured := false;
end;

procedure TImportPcodeToRatingAreaZoneGUI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryTemp);
  inherited;
end;

procedure TImportPcodeToRatingAreaZoneGUI.ClearTNTTable;
begin
  try
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('DELETE QUICK FROM tbltntpostcodetoratingareazone;');
    qryTemp.Execute;
  except
  end;
end;

procedure TImportPcodeToRatingAreaZoneGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

initialization
  RegisterClassOnce(TImportPcodeToRatingAreaZoneGUI);
end.
