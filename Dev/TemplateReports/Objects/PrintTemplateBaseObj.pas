unit PrintTemplateBaseObj;
{$I ERP.inc}
interface

uses ERPdbComponents,db, JsonObject ;

type

  TSetParametersEvent = procedure(Const Query :TERPQuery) of object;

  TPrintTemplateBase = class(TObject)
   Private
    fsSaveReportErrorMsg:String;
    fiSaveReportErrorNo:Integer;
   Protected
    fbReportSQLSupplied: boolean;
    conFormConnection: TCustomConnection;
    FSetParameters: TSetParametersEvent;
    fNoRecordsToPrint:Boolean;

    function ExtractStrPortion(const Source, Delim: string; const PosCount: integer): string;
    procedure SetParameters(Const Query :TERPQuery);

   Public
    property ReportSQLSupplied: boolean read fbReportSQLSupplied write fbReportSQLSupplied stored false;
    function SaveReport( const ReportNameStr, SQLPortion: string;
                                  const DoPrint: boolean; const FileType: string; const FileName: string = 'EmailReport';
                                  const DBConnection: TCustomConnection = nil; MasterDetailLink: TJsonObject = nil):boolean;
    Property SaveReportErrorMsg:String read fsSaveReportErrorMsg write fsSaveReportErrorMsg;
    Property SaveReportErrorNo :Integer read fiSaveReportErrorNo write fiSaveReportErrorNo;
    property OnSetParameters: TSetParametersEvent read FSetParameters write FSetParameters;
    property NoRecordsToPrint:Boolean read fNoRecordsToPrint;
  end;

procedure SetReportQueryParameters(Const Query :TERPQuery);

implementation

uses  (*ReportTemplates, *)myaccess, AppEnvironmentVirtual, sysutils ,
ppZLib,windows, ReportTemplateBase,SystemLib,
  tcConst, forms, ppTypes;


procedure SetReportQueryParameters(Const Query :TERPQuery);
Begin
  try
    if Assigned(Query.findparam('CubicMeterToBroadFeet')) then Query.Parambyname('CubicMeterToBroadFeet').AsFloat := CubicMeterToBroadFeet;
    if Assigned(Query.findparam('LBstoKGs'))              then Query.Parambyname('LBstoKGs').AsFloat              := LBstoKGs;
    if Assigned(Query.findparam('KGstoLBs'))              then Query.Parambyname('KGstoLBs').AsFloat              := KGstoLBs;
  Except
    on E:Exception do begin
      //logtext(E.message+NL+Query.SQL.text);
    end;
  end;
end;
procedure TPrintTemplateBase.SetParameters(Const Query :TERPQuery);
begin
   if Assigned(FSetParameters) then FSetParameters(Query);
   SetReportQueryParameters(Query);
end;

function TPrintTemplateBase.ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := Source + Delim;
  S := 1;
  for L9 := 1 to PosCount - 1 do begin
    S := Pos(Delim, Src);
    if S > 0 then Delete(Src, S, length(Delim))
    else Break;
  end;

  Result := '';
  if (S > 0) then begin
    E      := Pos(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;



function  TPrintTemplateBase.SaveReport(const ReportNameStr, SQLPortion: string;
  const DoPrint: boolean; const FileType: string; const FileName: string = 'EmailReport';
  const DBConnection: TCustomConnection = nil; MasterDetailLink: TJsonObject = nil):Boolean;
var
  FileExt: string;
//  Tempqry: TERPQuery;
  TempMyqry: TERPQuery;
  iSQLcounter: integer;
  PipeName: string;
  Templates: TReportTemplateBase;
  bAnyRecsToPrint:Boolean;
  s:String;
begin
  (*clog('Report :' +ReportNameStr);
  if not fbReportSQLSupplied then Logtext('SQL :' + SQLPortion);
  Logtext('==========================================================================');*)

  Result:= true;
  SaveReportErrorNo:=0;
  SaveReportErrorMsg:= '';
  if Assigned(DBConnection) then
    conFormConnection := DBConnection
  else
    conFormConnection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

  try
    Templates := TReportTemplateBase.Create;
  except
    on e: exception do begin
      SaveReportErrorNo:= 1;
      SaveReportErrorMsg:= E.Message;
      result:= False;
      Exit;
    end;
  end;

  if not Templates.CheckTemplateExists(ReportNameStr) then begin
    SaveReportErrorNo := 2;
    SaveReportErrorMsg := 'Report template "' + ReportNameStr + '" not found in database.';
    Result:= False;
    Exit;
  end
  else begin
    bAnyRecsToPrint := False;
    with Templates do
    begin
      try
        if not CreatedOk then
        begin
          SaveReportErrorNo := 1;
          SaveReportErrorMsg := GetUserMessage;
          Result := false;
          exit;
        end;
        Templates.MyConnection := TERPConnection(conFormConnection);

        for iSQLcounter := 1 to GetSQLCount(ReportNameStr) do
        begin
          if conFormConnection is TERPConnection then
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
              PipeName := Trim(ExtractStrPortion(StringReplace(TempMyqry.Sql.Text, '{', '',[rfReplaceAll,rfIgnoreCase]), '}', 0));

              if Trim(TempMyqry.Sql.Text) <> PipeName then
              begin
                Templates.PipelineUserName[iSQLcounter] := PipeName;
                TempMyqry.Sql.Text := StringReplace(TempMyqry.Sql.Text, '{' + PipeName + '}', '',[rfReplaceAll,rfIgnoreCase]);
              end;

              try
                SetParameters(TempMyqry);
                  (*Logtext(iif(sametext(PipeName , trim(TempMyQry.SQL.Text)),'' , '{' + PipeName +'}')  +
                          trim(TempMyQry.SQL.Text));*)
                  try
                    TempMyQry.Open;
                  Except
                    on E:Exception do begin
                        SaveReportErrorNo:= 7;
                        SaveReportErrorMsg:= E.Message + NL+ TempMyQry.SQL.text;
                        result:= False;
                        Exit;

                    end;
                  end;
                  (*Logtext('Records:' + inttostr(TempMyQry.recordcount)+chr(13));
                  Logtext('==========================================================================');*)
                  Open;
                If RecordCount=0 then Continue; //Exit;
                if RecordCount > 0 then bAnyRecsToPrint := True;
              except
                on e: EDatabaseError do begin
                  (*Logtext(e.Message);*)
                  result := false;
                  SaveReportErrorNo := 6;
                  SaveReportErrorMsg := e.Message;
                  Exit;
                end;
              end;

            end;
          end;
        end;

        if not bAnyRecsToPrint then begin
          fNoRecordsToPrint := True;
          exit;
        end else fNoRecordsToPrint := False;

        if Assigned(MasterDetailLink) then
          ApplyMasterDetailLink(MasterDetailLink);

        try
          ReportStream.Position := 0;
          Report.Template.LoadFromStream(ReportStream);
          Report.AllowPrintToFile := True;
          Report.ShowPrintDialog := False;
          Report.DeviceType := FileType;
          if not Assigned(Application.MainForm) then begin
            { this is being called from console or service .. avoid trying to show dialog }
            Report.NoDataBehaviors := [ndMessageOnPage, ndBlankReport];

          end;

          if FileType = 'HTMLFile' then
            FileExt := 'HTM'
          else if FileType = 'GraphicFile' then
            FileExt := 'BMP'
          else if FileType = 'PDF' then
            FileExt := 'PDF';

          FileExt := Trim(FileExt);

          // if the file name containes the extension, then no need to add the extension again.
          if Pos(uppercase('.' + fileExt), uppercase(FileName)) = 0 then
            Report.TextFileName := FileName + '.' + FileExt
          else
            Report.TextFileName := FileName;

          s:= ExtractFilePath(Templates.Report.TextFileName);
          if s = '' then Report.TextFileName := SystemLib.WinTempDir +Report.TextFileName
          else if DirectoryExists(s) then
          else Report.TextFileName :=  SystemLib.WinTempDir +StringReplace(Report.TextFileName, s, '',[rfReplaceAll,rfIgnoreCase]);
          s:= '';
          try
            SysUtils.DeleteFile(Report.TextFileName);
          Except
            on E:Exception do begin
              s:= 'Error Deleting ' +quotedstr(Report.TextFileName) +'.' +NL + E.message
            end;
          end;
          if (s<>'') or fileexists(Report.TextFileName) then begin
              SaveReportErrorno := 5;
              if fileexists(Templates.Report.TextFileName) then s:= 'File already Exists :' +quotedstr(Report.TextFileName)+NL+s;
              saveReportErrorMsg := s;
              REsult:= False;
              Exit;
          end;
          if Report.DeviceType = 'PDF' then begin
            Report.AllowPrintToFile := True;
            Report.ShowPrintDialog := False;
            Report.PDFSettings.Author := AppEnvVirt.str['CompanyPrefs.Tradingname'];
            Report.PDFSettings.Title := 'Print to PDF!'; // Maybe Change to
            Report.PDFSettings.CompressionLevel := clDefault;
            Report.PDFSettings.OptimizeImageExport := True;
            Report.PDFSettings.OpenPDFFile := False;
          end;

          Try
            Report.ShowCancelDialog := false;
            Report.Print;
          except
            on E: Exception do begin
              SaveReportErrorno := 3;
              saveReportErrorMsg := E.Message;
              REsult:= False;
              Exit;
            end;
          end;
        except
          on E:Exception do begin
            SavereportErrorno := 4;
            SaveReportErrorMsg:= E.Message;
            Result:= False;
            Exit;
          end;
        end;
      finally
        Free;
      end;
    end;
  end;
end;

end.

