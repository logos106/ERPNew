unit AuditTrailObj;

interface

uses MyAccess,ERPdbComponents,Classes;

type
  TAuditTrailObj = class(TObject)
  private
    F: TextFile;
    qryExport: TERPQuery;
    procedure MakeExportFile(const FileName: string);
    procedure CloseExportFile;
    procedure AddLinetoFile(const StrData: string);
    function MakeDataLine(const TypeStr: string): string;
    function MakeHeaderLine(const TypeStr, TypeStr2, TypeStr3: string): string;
  public
    function ExportAuditTrail: boolean;
    procedure Purge;
    procedure AddEntry(const DataDescription: string;
      const GlobalRef: string; const DiffText: TStringList;
      const AffectedObj: TObject; Connection: TERPConnection; ISNewRec:Boolean);
  end;

var
  AuditTrail: TAuditTrailObj;

implementation

uses
  Forms,  DNMLib, CommonDbLib,CommonLib, Dialogs,
  ProgressDialog, SysUtils, DB, Controls, AppEnvironment,
  BusObjAudit, BusObjBase;

procedure TAuditTrailObj.AddEntry(const DataDescription: string;
  const GlobalRef: string; const DiffText: TStringList;
  const AffectedObj: TObject; Connection: TERPConnection; ISNewRec:Boolean);
begin
  TAudit.AddEntry(DataDescription,GlobalRef,DiffText.Text,DiffText,
    TypeToDescription(ClassNameToTranType(AffectedObj.ClassName)),Connection , ISNewRec);
end;

function TAuditTrailObj.ExportAuditTrail: boolean;
var
  txtFileName: string;
  SaveDialog: TSaveDialog;
  ProgressDialog: TProgressDialog;
  I, LinesCount: integer;
begin
  Result := false;
  SaveDialog := TSaveDialog.Create(nil);
  SaveDialog.DefaultExt := 'pdi';
  SaveDialog.Filter := 'ERP Data Import (*.pdi)|*.pdi|All Files (*.*)|*.*';
  SaveDialog.FilterIndex := 1;
  qryExport := TERPQuery.Create(nil);
  qryExport.Connection := CommonDbLib.GetSharedMyDacConnection;
  ProgressDialog := TProgressDialog.Create(nil);
  try
    if SaveDialog.Execute then begin
      txtFileName := SaveDialog.FileName;
    end;
    if IsDir(ExtractFileDir(txtFileName)) then begin
      Processingcursor(True);
      ProgressDialog.Caption := 'Please Wait .......';
      ProgressDialog.MinValue := 0;
      ProgressDialog.MaxValue := 3;
      ProgressDialog.Step := 1;
      ProgressDialog.Execute;
      ProgressDialog.Stepit;
      //Application.ProcessMessages;
      //Start File
      MakeExportFile(txtFileName);
      ProgressDialog.Stepit;
      //Application.ProcessMessages;
      qryExport.SQL.Clear;
      qryExport.SQL.Add
      ('Select AuditID,AuditDate,EmployeeID,TransType,TransGlobalref,DataDescription,REPLACE(ChangedFields,CHAR(13,10),"<~>") as ChangedFields From tblaudittrail');
      ProgressDialog.Stepit;
      //Application.ProcessMessages;
      If Not CommonDbLib.GetSharedMyDacConnection.Connected then CommonDbLib.GetSharedMyDacConnection.Open;
      qryExport.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryExport.Open;
      AddLinetoFile(MakeHeaderLine('$AUDITTRAIL,AuditID,AuditDate,EmployeeID,TransType,TransGlobalRef,DataDescription,ChangedFields',
        '', ''));
      with qryExport do begin
        First;
        LinesCount := qryExport.RecordCount + 1;
        ProgressDialog.CloseDialog;
        ProgressDialog.Caption := 'Please Wait Exporting .......';
        ProgressDialog.MinValue := 0;
        ProgressDialog.MaxValue := LinesCount;
        ProgressDialog.Step := 1;
        ProgressDialog.Execute;

        for I := 0 to qryExport.RecordCount - 1 do begin
          ProgressDialog.Stepit;
          //Application.ProcessMessages;
          ProgressDialog.Caption := 'Please Wait Exporting ....... ' + FloatToStrF(((I / LinesCount) * 100),
            ffFixed, 7, 0) + '% Complete';
          AddLinetoFile(MakeDataLine('AUDITTRAIL'));
          Next;
          //Application.ProcessMessages;
        end;
      end;
      AddLinetoFile('FINALAUDITTRAIL');
      CloseExportFile;
      Result := true;
    end else begin
      CommonLib.MessageDlgXP_Vista('Directory "' + ExtractFileDir(txtFileName) + '"' + #13 + ' Does Not Exist !', mtWarning, [mbOK], 0);
    end;
  finally
    Processingcursor(False);
    FreeandNil(SaveDialog);
    FreeandNil(qryExport);
    FreeandNil(ProgressDialog);
  end;
end;

procedure TAuditTrailObj.AddLinetoFile(const StrData: string);
begin
  Writeln(F, StrData);
end;

procedure TAuditTrailObj.MakeExportFile(const FileName: string);
begin
  AssignFile(F, FileName);
  Rewrite(F);
end;

procedure TAuditTrailObj.CloseExportFile;
begin
  try
    Flush(F);
    CloseFile(F);
  except
  end;
end;

function TAuditTrailObj.MakeHeaderLine(const TypeStr, TypeStr2, TypeStr3: string): string;
begin
  if not Empty(TypeStr) and not Empty(TypeStr2) and not Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9) + ReplaceStr(TypeStr2, ',', #9) + ReplaceStr(TypeStr3, ',', #9);
  end else if not Empty(TypeStr) and not Empty(TypeStr2) and Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9) + ReplaceStr(TypeStr2, ',', #9);
  end else if not Empty(TypeStr) and Empty(TypeStr2) and Empty(TypeStr3) then begin
    Result := ReplaceStr(TypeStr, ',', #9);
  end;
end;

function TAuditTrailObj.MakeDataLine(const TypeStr: string): string;
var
  TempStr: string;
  I: integer;
begin
  TempStr := '';
  with qryExport do begin
    TempStr := TypeStr + #9;
    for I := 0 to qryExport.FieldCount - 1 do begin
      if (Fields[I].DataType = ftDate) or (Fields[I].DataType = ftDateTime) then begin
        TempStr := TempStr + FormatDateTime('yyyy-mm-dd hh:mm:ss', Fields[I].AsDateTime) + #9;
      end else begin
        TempStr := TempStr + Fields[I].AsString + #9;
      end;
    end;
  end;
  Result := Copy(TempStr, 0, char_length(TempStr) - 1)
end;


procedure TAuditTrailObj.Purge;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DELETE FROM `tblaudittrail`;');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

end.


