{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 12/10/05  1.00.00 BJ   Initial version.

                        Export :Descendant classes should have the LOADSQL procedure
                                to create any required temporary tables and
                                design the SQL for the export query.
                                Descendant class will assign the special note to the property
                                which should start with 'NOTE : '
                                The first line in the export data is the special note, if
                                there is no special note the first line should be blank

                        Import :The first line in the exported file is the special note
                                the second line is the heading where the first column will
                                store the name of the class itself.
 15/10/05  1.00.06 BJ   Replaced TOpResp with TResultStatus.

}
unit BusObjImportExport;

interface

uses BusObjBase, ComCtrls,AdvOfficeStatusBar, CLasses, MyAccess,ERPdbComponents, stdCtrls;


type
  TBusObjImportExport = class(TComponent)
  private
    fsFileName: string;
    fResultStatus: TResultStatus;
    fProgressBar: TProgressBar;
    flLabelMsg: TLabel;
    fsHeaderLine: string;
    fsSpecialNote: string;
    fsFooterLine: string;
    fsModuleName: string;
    fqIOQry: TERPQuery;
    fLogExists: boolean;
    IOFile: TextFile;


    function getResultStatus: TResultStatus;
    function getProgressBar: TProgressBar;
    function getIOQry: TERPQuery;
    //function MakeExportFile(const FileName: string): boolean;
    //function MakeHeaderLine(const TypeStr, TypeStr2, TypeStr3: string): string;
    //function MakeDataLine(const TypeStr: string): string;
    //procedure AddLinetoFile(const StrData: string);
    function getLableMsg: TLabel;
    function IsFile(const FileName: string): boolean;


  public
    ImportLog: string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; Override;
    //class function Instance: TBusObjImportExport; virtual; abstract;
    property FileName: string read fsFileName write fsFileName;
    property LabelMsg: TLabel read getLableMsg write flLabelMsg;
    property HeaderLine: string read fsHeaderLine write fsHeaderLine;
    property SpecialNote: string read fsSpecialnote write fsSpecialnote;
    property FooterLine: string read fsFooterLine write fsFooterLine;
    property ModuleName: string read fsModuleName write fsModuleName;
    property ProgressBar: TProgressBar read getProgressBar write fProgressBar;
    function ImportData: boolean; virtual;
    procedure LoadSQL; virtual; abstract;
    function ExportData: boolean;
    property Logexists: boolean read fLogExists write fLogExists;
    procedure Logerror;
    function PrintError: string;
    property IOQry: TERPQuery read getIOQry;

  protected


    property ResultStatus: TResultStatus read getResultStatus;
    function IsDir(const DirPath: string): boolean;
    function LineCount: integer;
    procedure OpenFile(const FileName: string);
    function GetLineOfString: string;
    function FieldCounter(const Data: string): integer;
    procedure CloseImportExportFile;

  end;

implementation

uses FastFuncs,SysUtils, CommonDBLib, Forms, db, DNMLib,systemlib;

Destructor TBusObjImportExport.Destroy;
begin
    if assigned(fqIOQry) then begin
        if fqIOQry.Active then fqIOQry.close;
        FreeandNil(fqIOQry);
    end;
    inherited;
end;
constructor TBusObjImportExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FileName := '';
end;

function TBusObjImportExport.getResultStatus: TResultStatus;
begin
  if not Assigned(fResultStatus) then fResultStatus := TResultStatus.Create(TResultStatusItem);
  Result := fResultStatus;
end;

function TBusObjImportExport.getIOQry: TERPQuery;
begin
  if not Assigned(fqIOQry) then Begin
    fqIOQry := TERPQuery.Create(nil);
    fqIOQry.Options.FlatBuffers := True;
  end;
  if not Assigned(fqIOQry.Connection) then fqIOqry.Connection := getsharedMydacConnection;
  Result := fqIOQry;
end;

function TBusObjImportExport.getLableMsg: TLabel;
begin
  if not Assigned(flLabelMsg) then flLabelMsg := TLabel.Create(nil);
  Result := flLabelMsg;
end;

function TBusObjImportExport.getProgressBar: TProgressBar;
begin
  if not Assigned(fProgressBar) then fProgressBar := TProgressBar.Create(nil);
  Result := fProgressBar;
end;


function TBusObjImportExport.IsDir(const DirPath: string): boolean;
begin
  Result := DirectoryExists(DirPath);
end;

function TBusObjImportExport.ImportData: boolean;
begin
  Result := false;

  if FileName = '' then begin
    ResultStatus.AddItem(false, rssWarning, 0, 'The file to be imported is not specified', false);
    Exit;
  end;

  if not IsDir(ExtractFileDir(FileName)) then begin
    ResultStatus.AddItem(false, rssWarning, 0, 'Directory ''' + ExtractFileDir(FileName) + '''' + #13 + ' Does Not Exist !',
      false);
    Exit;
  end;
  if not IsFile(FileName) then begin
    ResultStatus.AddItem(false, rssWarning, 0, 'File "' + FileName + '"' + #13 + 'Does Not Exist !', false);
    Exit;
  end;
  OpenFile(FileName);
  if (LineCount <= 1) then begin
    ResultStatus.AddItem(false, rssWarning, 0, 'File is empty !', false);
    Exit;
  end;
  ImportLog := SystemLib.ExeDir + 'ImportErrors.log';
  Result := true;
end;

function TBusObjImportExport.ExportData: boolean;
begin
  Result := false;
  SpecialNote := '';
  LoadSQL;
end;



procedure TBusObjImportExport.CloseImportExportFile;
begin
  try
    Flush(IOFile);
    CloseFile(IOFile);
  except
  end;
end;

procedure TBusObjImportExport.OpenFile(Const FileName: string);
begin
  AssignFile(IOFile, FileName);
  Reset(IOFile);
end;

function TBusObjImportExport.LineCount: integer;
var
  Count: integer;
begin
  Count := 0;
  try
    Reset(IOFile);
    while not Eof(IOFile) do begin
      Readln(IOFile);
      Inc(Count);
    end;
    Result := Count;
    Reset(IOFile);
  except
    Result := 0;
  end;
end;

function TBusObjImportExport.IsFile(const FileName: string): boolean;
begin
  Result := FileExists(FileName);
end;

function TBusObjImportExport.GetLineOfString: string;
begin
  try
    Readln(IOFile, Result);
  except
    on EInOutError do Result := '';
  end;
end;

function TBusObjImportExport.FieldCounter(const Data: string): integer;
var
  TempStr: string;
  S, Count, I: integer;
begin
  TempStr := Data;
  Count := 1;

  for I := 1 to 200 do begin
    S := FastFuncs.PosEx(#44, TempStr);
    if S > 0 then begin
      Delete(TempStr, S, Length(#44));
      Count := Count + 1;
    end else begin
      Break;
    end;
  end;
  Result := Count
end;

function TBusObjImportExport.PrintError: string;
var
  sTableName: string;
  ctr: integer;
  ErrMsg: string;
begin
  with TERPQuery.Create(nil) do try
      Options.FlatBuffers := True;
      Connection := GetSharedMyDacConnection;
      sTableName := 'tmp_log_' + GetTemporaryTableNameSuffix;
      Sql.add('Drop table if exists ' + sTableName);
      Execute;
      SQL.Clear;
      SQL.add('Create table ' + sTableName);
      SQL.add(' ( Filename varchar(255) , LogFile varchar(255) ,  Msgtype varchar(20) , ');
      SQL.add('MsgDesc varchar(255))  ENGINE=InnoDB;');
      Execute;
      if Resultstatus.Count = 0 then Exit;
      for ctr := 0 to ResultStatus.Count - 1 do begin
        SQL.Clear;
        SQL.add('INSERT HIGH_PRIORITY INTO ' + sTableName + '( Filename, LogFile, Msgtype , MsgDesc) ');
        SQL.add('VAlues (' + QuotedStr(FileName) + ',');
        SQL.add(QuotedStr(ImportLog) + ',');
        ErrMsg := '';
        case TResultStatusItem(Resultstatus.Items[ctr]).Severity of
          rssInfo: ErrMsg := 'Info    ';
          rssWarning: ErrMsg := 'Warning ';
          rssError: ErrMsg := 'Error   ';
        end;
        SQL.add(QuotedStr(ErrMsg) + ',');
        ErrMsg := TResultStatusItem(Resultstatus.Items[ctr]).Message;
        SQL.add(QuotedStr(ErrMsg) + ')');
        Execute;
      end;
      Result := STableName;
    finally
      if Active then Close;
      Free;
    end;
end;

procedure TBusObjImportExport.LogError;
var
  ErrorLog: TextFile;
  ctr: integer;
  ErrMsg: string;
begin
  if Resultstatus.Count = 0 then Exit;
  logexists := true;
  AssignFile(ErrorLog, ImportLog);
  try
    Rewrite(ErrorLog);
    for ctr := 0 to ResultStatus.Count - 1 do begin
      case TResultStatusItem(Resultstatus.Items[ctr]).Severity of
        rssInfo: ErrMsg := 'Info    ';
        rssWarning: ErrMsg := 'Warning ';
        rssError: ErrMsg := 'Error   ';
        else ErrMsg := '';
      end;
      ErrMsg := ErrMsg + ': ' + TResultStatusItem(Resultstatus.Items[ctr]).Message;
      Writeln(ErrorLog, ErrMsg);
    end;
    Flush(ErrorLog);
    CloseFile(ErrorLog);
  except
    on   EInOutError do;
  end;
end;

end.
