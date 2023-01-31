unit PrintTemplateObj;

  // Date     Version  Who What
  // -------- -------- --- ------------------------------------------------------
  // 10/06/05  1.00.07 IJB Added logic to check report template exists before printing.
  // 27/07/05  1.00.12 IJB Added check that Templates object is assigned before
  //                       free in PrintTemplateReport.
  // 16/12/05  1.00.13 DSP Altered code to use ReportTemplates in place of
  //                       TemplatesFrm.

interface

uses
  DB, MyAccess, MemDS, SelectionDialog, DBAccess, Classes,
  SysUtils, Dialogs, ComObj, MyClasses;

type
  TSetParametersEvent = procedure(Const Query :TMyQuery) of object;

  TPrintTemplates = class(TObject)
  private
    conFormConnection: TCustomConnection;
    fbConnectionIsMyDAC: boolean;
    fbReportSQLSupplied: boolean;
    oOwner: TComponent;
    fsReportName: string;
    iReportTypeID: integer;
    dlgReportSelect: TSelectionDialog;
    fUseEmployeeShowPrintDialogPref: boolean;
    FSetParameters: TSetParametersEvent;
  protected
    procedure SetParameters(Const Query :TMyQuery);
    procedure LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = '');
    procedure LoadReportTypes;
    function ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
    function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
    function TemplateNameToTemplateClassName(const TemplateName: string): string;
  public
    constructor Create;
    destructor Destroy; override;

    procedure PrintTemplateReport(const ReportNameStr, SQLPortion: string; const DoPrint: boolean;
      const Copies: integer; const DBConnection: TCustomConnection = nil; Const Q1MasterQ2Details: Boolean=False);

    procedure SaveTemplateReport(const ReportNameStr, SQLPortion: string; const DoPrint: boolean;
      const FileType: string; const FileName: string = 'EmailReport'; const DBConnection: TCustomConnection = nil; Const Q1MasterQ2Details: Boolean=False);

    function GetDefaultReport(const TemplateType: integer): string;
    property ConnectionIsMyDAC: boolean read fbConnectionIsMyDAC write fbConnectionIsMyDAC stored false;
    property ReportSQLSupplied: boolean read fbReportSQLSupplied write fbReportSQLSupplied stored false;
    property ConnectionForReport: TCustomConnection read conFormConnection write conFormConnection stored nil;
    property ReportTypeID: integer read iReportTypeID write iReportTypeID;
    property UseEmployeeShowPrintDialogPref: boolean read fUseEmployeeShowPrintDialogPref write fUseEmployeeShowPrintDialogPref;
    property OnSetParameters: TSetParametersEvent read FSetParameters write FSetParameters;
  end;

implementation

uses
  Forms, FastFuncs,
//  Need For PDF Print
  ppPDFDevice, ppZLib,TXtraDev;


constructor TPrintTemplates.Create;
begin
  inherited;
  conFormConnection := nil;
  fbConnectionIsMyDAC := False;
  fbReportSQLSupplied := False;
  oOwner := nil;
  iReportTypeID := 0;
  fUseEmployeeShowPrintDialogPref := True;
  dlgReportSelect := TSelectionDialog.Create(nil);
end;

destructor TPrintTemplates.Destroy;
begin
  FreeandNil(dlgReportSelect);
  inherited;
end;

procedure TPrintTemplates.SetParameters(Const Query :TMyQuery);
Begin
  if Assigned(FSetParameters) then FSetParameters(Query);
end;

procedure TPrintTemplates.PrintTemplateReport(const ReportNameStr, SQLPortion: string;
  const DoPrint: boolean; const Copies: integer; const DBConnection: TCustomConnection = nil; Const Q1MasterQ2Details: Boolean=False);
var
  Tempqry: TMyQuery;
  TempMyqry: TMyQuery;
  iSQLcounter: integer;
  PipeName: string;
  RTemplates: TReportTemplates;
  qryTransactions: TMyQuery;
begin
  if ReportNameStr = '' then
    Exit;

  // Yes, then use this connection!

  if Assigned(DBConnection) then
    conFormConnection := DBConnection
  else
    conFormConnection := CommonDbLib.GetSharedMyDacConnection;

  RTemplates := TReportTemplates.Create;

  if not RTemplates.CheckTemplateExists(ReportNameStr) then
  begin
    CommonLib.MessageDlgXP_Vista('Report template "' + ReportNameStr + '" not found in database.', mtWarning, [mbOK], 0);
  end
  else
  begin
    with RTemplates do
    begin
      try
        RTemplates.MyConnection := TMyConnection(conFormConnection);

        qryTransactions := GeTMyQuery(1);

        with qryTransactions do
        begin
          Close;
          Sql.Clear;
          Sql.Add(GetSQLForReport(ReportNameStr));

          for iSQLcounter := 1 to GetSQLCount(ReportNameStr) do
          begin
            if not (conFormConnection is TMyConnection) then
            begin
              //ADO
              Tempqry := GeTMyQuery(iSQLcounter);

              if not Assigned(Tempqry) then
                Continue;

              with Tempqry do
              begin
                Close;
                Sql.Clear;
                //Sql.Add(GetSQLForReport(ReportNameStr, iSQLcounter - 1));
                {Binny : GetSQLforreport has the counter starting from 1 , not 0. So should not have the -1
                Problems with the Purchaseorder's reports}
                Sql.Add(GetSQLForReport(ReportNameStr, iSQLcounter ));
                
                {The calling object has supplied the entire SQL string b/c of it's complexity}
                if fbReportSQLSupplied then
                  Sql.Clear;

                Sql.Add(ExtractStrPortion(SQLPortion, '~|||~', iSQLcounter));
                PipeName := FastFuncs.Trim(ExtractStrPortion(ReplaceStr(Tempqry.Sql.Text, '{', ''), '}', 0));

                if (FastFuncs.Trim(Tempqry.Sql.Text) <> PipeName) then
                begin
                  RTemplates.PipelineUserName[iSQLcounter] := PipeName;
                  Tempqry.Sql.Text := ReplaceStr(Tempqry.Sql.Text, '{' + PipeName + '}', '');
                end;

                try
                  Tempqry.Open;
                except
                  on e: EOleException do
                  begin
                    CommonLib.MessageDlgXP_Vista('There is A Possible SQL Error with This Template' + #10#13 +
                      'Check Template And Try Again !' + e.Message, mtWarning, [mbOK], 0);
                    Exit;
                  end
                  else
                    raise;
                end;
              end;
            end else begin
              //MyDAC
              TempMyqry := GetMyQuery(iSQLcounter);

              if not Assigned(TempMyQry) then
                Continue;

              with TempMyqry do
              begin
                Close;
                Sql.Clear;
                Sql.Add(GetSQLForReport(ReportNameStr, iSQLcounter));

                {The calling object has supplied the entire SQL string b/c of it's complexity}
                if fbReportSQLSupplied then
                  Sql.Clear;

                Sql.Add(ExtractStrPortion(SQLPortion, '~|||~', iSQLcounter));
                PipeName := FastFuncs.Trim(ExtractStrPortion(ReplaceStr(TempMyqry.Sql.Text, '{', ''), '}', 0));

                if (FastFuncs.Trim(TempMyqry.Sql.Text) <> PipeName) then begin
                  RTemplates.PipelineUserName[iSQLcounter] := PipeName;
                  TempMyqry.Sql.Text := ReplaceStr(TempMyqry.Sql.Text, '{' + PipeName + '}', '');
                end;

                try
                  SetParameters(TempMyQry);
                  TempMyQry.Open;
                except
                  on e: EDatabaseError do
                  begin
                    CommonLib.MessageDlgXP_Vista('There is A Possible SQL Error with This Template' + #10#13 +
                      'Check Template And Try Again !' + e.Message, mtWarning, [mbOK], 0);
                    Exit;
                  end;
                end;
              end;
            end;
          end;

          {For Statements Invoice Details}
          if Q1MasterQ2Details then begin
            if GetMyQuery(2) is TMyQuery then begin
              GetPipeline(2).SkipWhenNoRecords := false;
              TMyQuery(GetMyQuery(2)).MasterSource := GetDataSource(1);
            end;
          end;

          try
            ReportStream.Position := 0;
            Report.Template.LoadFromStream(ReportStream);

            if fUseEmployeeShowPrintDialogPref then
              Report.ShowPrintDialog := AppEnv.Employee.ShowPrintDialog
            else
              Report.ShowPrintDialog := False;

            if DoPrint then
              Report.DeviceType := 'Printer'
            else
              MaxPreview := True;

            if Copies > 1 then
              Report.PrinterSetup.Copies := Copies;

            Try
              Report.Print;
            except
              on E: Exception do begin
                If FastFuncs.SameText(E.Message,'Screen printer does not support printing') then begin
                  CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
                end else
                  raise;
              end;
            end;
          except
            CommonLib.MessageDlgXP_Vista('Could not create Report, Possible template mismatch.', mtError, [mbOK], 0);
          end;
        end;
      finally
        FreeandNil(RTemplates);
      end;
    end;
  end;
end;

function TPrintTemplates.ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := Source + Delim;
  S := 1;
  for L9 := 1 to PosCount - 1 do begin
    S := FastFuncs.PosEx(Delim, Src);
    if S > 0 then Delete(Src, S, Length(Delim))
    else Break;
  end;

  Result := '';
  if (S > 0) then begin
    E      := FastFuncs.PosEx(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;

function TPrintTemplates.ReplaceStr(const sString, sOldStr, sNewStr: string): string;
begin
  Result := FastFuncs.AnsiStringReplace(sString, sOldStr, sNewStr, [rfReplaceAll]);
end;

procedure TPrintTemplates.LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = '');
begin
  if (fsReportName <> '') then
    fsReportName := TemplateNameToTemplateClassName(FastFuncs.Trim(fsReportName))
  else
    fsReportName := GetDefaultReport(ReportTypeID);
end;

procedure TPrintTemplates.SaveTemplateReport(const ReportNameStr, SQLPortion: string; const DoPrint: boolean;
  const FileType: string; const FileName: string = 'EmailReport'; const DBConnection: TCustomConnection = nil; Const Q1MasterQ2Details: Boolean=False);
var
  FileExt: string;
  Tempqry: TMyQuery;
  TempMyqry: TMyQuery;
  iSQLcounter: integer;
  PipeName: string;
  Templates: TReportTemplates;
begin
  if Assigned(DBConnection) then
    conFormConnection := DBConnection
  else
    conFormConnection := CommonDbLib.GetSharedMyDacConnection;

  if ReportNameStr <> '' then
  begin
    Templates := TReportTemplates.Create;

    with Templates do
    begin
      try
        Templates.MyConnection := TMyConnection(conFormConnection);

        for iSQLcounter := 1 to GetSQLCount(ReportNameStr) do
        begin
          if conFormConnection is TMyConnection then
          begin
            // MyDac
            TempMyqry := GetMyQuery(iSQLcounter);

            if not Assigned(TempMyqry) then
              Continue;

            with TempMyqry do
            begin
              Close;
              Sql.Clear;
              Sql.Add(GetSQLForReport(ReportNameStr, iSQLcounter));

              {The calling object has supplied the entire SQL string b/c of it's complexity}
              if fbReportSQLSupplied then
                Sql.Clear;

              Sql.Add(ExtractStrPortion(SQLPortion, '~|||~', iSQLcounter));
              PipeName := FastFuncs.Trim(ExtractStrPortion(ReplaceStr(TempMyqry.Sql.Text, '{', ''), '}', 0));

              if FastFuncs.Trim(TempMyqry.Sql.Text) <> PipeName then
              begin
                Templates.PipelineUserName[iSQLcounter] := PipeName;
                TempMyqry.Sql.Text := ReplaceStr(TempMyqry.Sql.Text, '{' + PipeName + '}', '');
              end;

              try
                SetParameters(TempMyqry);
                Open;
                If RecordCount=0 then Exit;
              except
                on e: EDatabaseError do
                begin
                  Exit;
                end;
              end;

            end;
          end
          else
          begin
            // ADO
            Tempqry := GeTMyQuery(iSQLcounter);

            if not Assigned(Tempqry) then
              Continue;

            with Tempqry do
            begin
              Close;
              Sql.Clear;
              Sql.Add(GetSQLForReport(ReportNameStr, iSQLcounter));

              {The calling object has supplied the entire SQL string b/c of it's complexity}
              if fbReportSQLSupplied then
                Sql.Clear;

              Sql.Add(ExtractStrPortion(SQLPortion, '~|||~', iSQLcounter));
              PipeName := FastFuncs.Trim(ExtractStrPortion(ReplaceStr(Tempqry.Sql.Text, '{', ''), '}', 0));

              if (FastFuncs.Trim(Tempqry.Sql.Text) <> PipeName) then
              begin
                Templates.PipelineUserName[iSQLcounter - 1] := PipeName;
                Tempqry.Sql.Text := ReplaceStr(Tempqry.Sql.Text, '{' + PipeName + '}', '');
              end;

              try
                Open;
              except
                on e: EDatabaseError do
                begin
                  Exit;
                end;
              end;
              
            end;
          end;
        end;

        {For Statements Invoice Details}
        if Q1MasterQ2Details then begin
          if GetMyQuery(1) is TMyQuery then begin
            GetPipeline(1).SkipWhenNoRecords := false;
            TMyQuery(GetMyQuery(1)).MasterSource := GetDataSource(1);
          end;
        end;


        try
          ReportStream.Position := 0;
          Report.Template.LoadFromStream(ReportStream);
          Report.AllowPrintToFile := True;
          Report.ShowPrintDialog := False;
          Report.DeviceType := FileType;

          if FileType = 'HTMLFile' then
            FileExt := 'HTM'
          else if FileType = 'GraphicFile' then
            FileExt := 'BMP'
          else if FileType = 'PDF' then
            FileExt := 'PDF';

          FileExt := FastFuncs.Trim(FileExt);

          // if the file name containes the extension, then no need to add the extension again.
          if FastFuncs.PosEx(FastFuncs.UpperCase('.' + fileExt), FastFuncs.UpperCase(FileName)) = 0 then
            Report.TextFileName := FileName + '.' + FileExt
          else
            Report.TextFileName := FileName;

          Report.TextFileName := ExtractFilePath(Application.ExeName) + Report.TextFileName;
          SysUtils.DeleteFile(Report.TextFileName);

          if Report.DeviceType = 'PDF' then begin
            Report.AllowPrintToFile := True;
            Report.ShowPrintDialog := False;
            Report.PDFSettings.Author := AppEnv.CompanyInfo.Tradingname;
            Report.PDFSettings.Title := 'Print to PDF!'; // Maybe Change to
            Report.PDFSettings.CompressionLevel := clDefault;
            Report.PDFSettings.OptimizeImageExport := True;
            Report.PDFSettings.OpenPDFFile := False;
          end;

          Try
            Report.Print;
          except
            on E: Exception do begin
              If FastFuncs.SameText(E.Message,'Screen printer does not support printing') then begin
                CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
              end else
                raise;
            end;
          end;
        except
          CommonLib.MessageDlgXP_Vista('Could not create Report, Possible template mismatch.', mtError, [mbOK], 0);
        end;
      finally
        Free;
      end;
    end;
  end;
end;

function TPrintTemplates.TemplateNameToTemplateClassName(const TemplateName: string): string;
begin
  Result := '';

  with TMyQuery.Create(nil) do
  begin
    try
      Options.FlatBuffers := True;
      Connection := GetSharedMyDacConnection;
      Sql.Add(Format('SELECT TemplateClass FROM tblTemplates WHERE TemplName = %s',
                     [QuotedStr(TemplateName)]));
      Open;
      Result := FieldByName('TemplateClass').AsString;
    finally
      Free;
    end;
  end;
end;

function TPrintTemplates.GetDefaultReport(const TemplateType: integer): string;
var
  qryTemp: TMyQuery;
begin
  Result := '';

  if TemplateType > 0 then
  begin
    qryTemp := TMyQuery.Create(nil);
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection := GetSharedMyDacConnection;

    with qryTemp do
    begin
      try
        Sql.Add(Format('SELECT TemplateClass FROM tblTemplates WHERE TypeID = %d and DefaultTemplate = "T"',
                [TemplateType]));
        Open;
        Result := FieldByName('TemplateClass').AsString;
      finally
        FreeAndNil(qryTemp);
      end;
    end;
  end;
end;

procedure TPrintTemplates.LoadReportTypes;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := GetSharedMyDacConnection;

  with qryTemp do
  begin
    try
      Sql.Add(Format('SELECT TemplName FROM tblTemplates WHERE TypeID = %d', [ReportTypeID]));
      Open;
      dlgReportSelect.Items.Clear;

      if not IsEmpty then
      begin
        First;

        while not Eof do
        begin
          dlgReportSelect.Items.Add(FieldByName('TemplName').AsString);
          Next;
        end;
      end;
    finally
      FreeAndNil(qryTemp);
    end;
  end;
end;

end.

