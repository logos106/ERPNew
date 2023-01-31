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
  DB, MyAccess,ERPdbComponents, MemDS, SelectionDialog, DBAccess, Classes,
  SysUtils, Dialogs, MyClasses, JsonObject , ppTBX , PrintTemplateBaseObj,
  CorrespondenceObj, EmailUtils;

type


  TPrintTemplates = class(TPrintTemplateBase)
  private

    fbConnectionIsMyDAC: boolean;
    oOwner: TComponent;
    fsReportName: string;
    iReportTypeID: integer;
    dlgReportSelect: TSelectionDialog;
    fUseEmployeeShowPrintDialogPref: boolean;
    fMMFileType:string;
    //fMMDocsProcessed:integer;
    fMMRecipientName:string;

    fbShowCancelPreviewBtninReportPreview:Boolean;
    CancelPreviewAllbtnclick: TNotifyEvent;
    fbCancelPreviewAll:Boolean;
    CancelButton:TppTBXItem;
    procedure doOnPreviewFormCreate(Sender:TObject);
    procedure DoCancelPreviewAllbtnclick(Sender:TObject);
  protected

    procedure LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = '');
    procedure LoadReportTypes;
    function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
    function TemplateNameToTemplateClassName(const TemplateName: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure PrintTemplateReport(const ReportNameStr, SQLPortion: string; const DoPrint: boolean;
      const Copies: integer; const DBConnection: TCustomConnection = nil;
      const ReportFilter: string = ''; MasterDetailLink: TJsonObject = nil;fsPrintername :String = '');
    procedure EmailTemplateReport(const ReportNameStr, SQLPortion: string;RecipientAddress:String; emailSubject:String ='';EmailBody:String = '';
      const DBConnection: TCustomConnection = nil;
      const ReportFilter: string = ''; MasterDetailLink: TJsonObject = nil;fsPrintername :String = '';
      const aSilent : boolean = false; const aSecret : boolean = false);
//    Function AddTemplateAttachments(FEmailSender :T2cEmailSender; aReportID:Integer):String; overload;
    Function AddTemplateAttachments(Corres :TCorrespondenceGui; aReportID: Integer): String; overload;
    Function SaveTemplateReport(const ReportNameStr, SQLPortion: string; const DoPrint: boolean;
      const FileType: string; const FileName: string = 'EmailReport';
      const DBConnection: TCustomConnection = nil; MasterDetailLink: TJsonObject = nil) :Boolean;
    procedure PrintMailMerge(const ReportNameStr: string; const SQLPortion:string;
      const DoPrint: Boolean; const FileType: string;
      RecipientName: string; MasterDetailLink: TJsonObject = nil);
    property ConnectionIsMyDAC: boolean read fbConnectionIsMyDAC write fbConnectionIsMyDAC stored false;
    property ConnectionForReport: TCustomConnection read conFormConnection write conFormConnection stored nil;
    property ReportTypeID: integer read iReportTypeID write iReportTypeID;
    property UseEmployeeShowPrintDialogPref: boolean read fUseEmployeeShowPrintDialogPref write fUseEmployeeShowPrintDialogPref;

    Property ShowCancelPreviewBtninReportPreview :Boolean read fbShowCancelPreviewBtninReportPreview write fbShowCancelPreviewBtninReportPreview;
    Property CancelPreviewAll :boolean read fbCancelPreviewAll write fbCancelPreviewAll;
  end;



implementation

uses
  Forms, CommonDBLib,  ReportTemplates, AppEnvironment, FastFuncs,
//  Need For PDF Print
  ppPDFDevice, ppZLib,
  CommonLib, ComObj,DnMLib, windows , SystemLib,ppPrvDlg , ppReport,
  tcConst, frmDelayMessageDlg, tcDataUtils, DbSharedObjectsObj, LogLib,
  TemplateReportsLib, TemplateReportsTypeLib;

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
  ShowCancelPreviewBtninReportPreview:= False;
  fbCancelPreviewAll:= False;
end;

destructor TPrintTemplates.Destroy;
begin
  FreeandNil(dlgReportSelect);
  inherited;
end;

procedure TPrintTemplates.EmailTemplateReport(const ReportNameStr, SQLPortion: string; RecipientAddress:String;emailSubject:String ='';EmailBody:String = '';
      const DBConnection: TCustomConnection = nil;
      const ReportFilter: string = ''; MasterDetailLink: TJsonObject = nil;fsPrintername :String = '';
      const aSilent : boolean = false; const aSecret : boolean = false);
var
  Corres: TCorrespondenceGui;
  OutGoingFileName:string;
begin


    if RecipientAddress = '' then begin
      CommonLib.MessageDlgXP_Vista('Email address is blank - cannot send email', mtInformation , [mbOK], 0);
      Exit;
    end;

    if ReportNameStr = '' then begin
      CommonLib.MessageDlgXP_Vista('Could not find the Report Template to use.', mtInformation , [mbOK], 0);
      exit;
    end;

    SaveTemplateReport(ReportNameStr, SQLPortion, False, 'PDF');

    if not FileExists( Commonlib.TempDir  + 'EmailReport.PDF') then begin
      CommonLib.MessageDlgXP_Vista('Could not find the Report File', mtInformation , [mbOK], 0);
      exit;
    end;

  Corres := TCorrespondenceGui.Create;
  try
        Corres.Subject := emailSubject;

        Corres.RecipientList := RecipientAddress;

        Corres.MessageText := EmailBody;

        OutGoingFileName := Commonlib.TempDir  + GetCompanyName+'-' +Emailsubject+'.pdf';
        if FileExists(OutGoingFileName) then begin
          DeleteFile(pchar(OutGoingFileName));
          Sleep(1000);//wait for file delete
        end;

        if not FileExists(OutGoingFileName) then begin
          copyfile(PChar( Commonlib.TempDir  + 'EmailReport.PDF'),PChar( OutGoingFileName), false);
        end;

        // Wait For OS Copy
        Sleep(1000);
        Application.ProcessMessages;


        if FileExists(  OutGoingFileName) then
          Corres.AttachmentList.Add(OutGoingFileName);
        Corres.Execute(aSilent, aSecret);

        DeleteFile(pchar(OutGoingFileName));
        DeleteFile(pchar(pchar(Commonlib.TempDir  + 'EmailReport.PDF')));

  finally
    Corres.Free;
  end;
end;

procedure TPrintTemplates.PrintTemplateReport(const ReportNameStr, SQLPortion: string;
  const DoPrint: boolean; const Copies: integer; const DBConnection: TCustomConnection = nil;
  const ReportFilter: string = ''; MasterDetailLink: TJsonObject = nil;fsPrintername :String = '');
var
  Tempqry: TERPQuery;
  TempMyqry: TERPQuery;
  iSQLcounter: integer;
  PipeName: string;
  RTemplates: TReportTemplates;
  qryTransactions: TERPQuery;
  fsfilter:String;
  SS: String;

  it : integer;
  sSql : string;

begin
  clog('Report :' +ReportNameStr);
  if not fbReportSQLSupplied then Logtext('SQL :' + SQLPortion);
  Logtext('==========================================================================');
  CancelPreviewAll:= False;
  CloseallUserMsgs;
  if ReportNameStr = '' then
    Exit;

  // Yes, then use this connection!

  if Assigned(DBConnection) then
    conFormConnection := DBConnection
  else
    conFormConnection := CommonDbLib.GetSharedMyDacConnection;

(*  with TStringList.Create do begin
    text := SQLPortion;
    savetofile('c:\temp\temp.sql');
    free;
  end;*)

  try
    RTemplates := TReportTemplates.Create;
  except
    on e: exception do begin
      if Pos('Unable to write to RBuilder.ini',e.Message) > 0 then begin
        MessageDlgXP_Vista('Windows is preventing Report Builder from writing' +
          ' a file to the disk (RBuilder.ini), please ensure that the user' +
          ' you are logged on as has full rights to access the disk', mtInformation, [mbOk],0);
        exit;
      end
      else
        raise;
    end;
  end;

  if not RTemplates.CheckTemplateExists(ReportNameStr) then
  begin
    CommonLib.MessageDlgXP_Vista('Report template "' + ReportNameStr + '" not found in database.', mtWarning, [mbOK], 0);
  end
  else
  begin
    with RTemplates do
    begin

      if not CreatedOk then exit;
      try
        RTemplates.MyConnection := TERPConnection(conFormConnection);

        qryTransactions := GeTMyQuery(1);

        with qryTransactions do
        begin
          Close;
          Sql.Clear;
          Sql.Add(GetSQLForReport(ReportNameStr));

          for iSQLcounter := 1 to GetSQLCount(ReportNameStr) do
          begin
(*            if not (conFormConnection is TERPConnection) then
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
                //Binny : GetSQLforreport has the counter starting from 1 , not 0. So should not have the -1
                //Problems with the Purchaseorder's reports
                Sql.Add(GetSQLForReport(ReportNameStr, iSQLcounter ));

                //The calling object has supplied the entire SQL string b/c of it's complexity
                if fbReportSQLSupplied then
                  Sql.Clear;

                Sql.Add(ExtractStrPortion(SQLPortion, '~|||~', iSQLcounter));
                PipeName := Trim(ExtractStrPortion(ReplaceStr(Tempqry.Sql.Text, '{', ''), '}', 0));

                if (Trim(Tempqry.Sql.Text) <> PipeName) then
                begin
                  RTemplates.PipelineUserName[iSQLcounter] := PipeName;
                  Tempqry.Sql.Text := ReplaceStr(Tempqry.Sql.Text, '{' + PipeName + '}', '');
                end;
                if Sametext(pipename ,'ColumnHeadings') or Sametext(pipename ,BlankColumnHeadings)  then
                  Tempqry.Sql.Text := ColumnHeadingsSQL('columnHeadings' , '' , False);
                try
                  Logtext(Tempqry.SQL.Text);
                  Logtext('==========================================================================');
                  Tempqry.Open;
                  Logtext('Records:' + inttostr(TempMyQry.recordcount)+chr(13));
                  Logtext('==========================================================================');
                  if ReportFilter<> '' then begin
                    fsFilter := ExtractStrPortion(ReportFilter, '~|||~', iSQLcounter);
                    if fsFilter<>'' then begin
                      Tempqry.Filter := fsfilter;
                      Tempqry.filtered := True;
                    end;
                  end;
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
            end else begin*)
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
                begin
                  Sql.Clear;
                end;

                Sql.Add(ExtractStrPortion(SQLPortion, '~|||~', iSQLcounter));
                PipeName := Trim(ExtractStrPortion(ReplaceStr(TempMyqry.Sql.Text, '{', ''), '}', 0));

                SS := Sql.Text;

                if (Trim(TempMyqry.Sql.Text) <> PipeName) then begin
                  RTemplates.PipelineUserName[iSQLcounter] := PipeName;
                  TempMyqry.Sql.Text := ReplaceStr(TempMyqry.Sql.Text, '{' + PipeName + '}', '');
                end;

                if Sametext(pipename ,'ColumnHeadings') or Sametext(pipename ,BlankColumnHeadings)  then
                  TempMyqry.Sql.Text := ColumnHeadingsSQL('columnHeadings' , '' , False);

                try
                  SetParameters(TempMyQry);
                  Logtext(iif(sametext(PipeName , trim(TempMyQry.SQL.Text)),'' , '{' + PipeName +'}')  +
                          trim(TempMyQry.SQL.Text));

                  TempMyQry.Open;
                  Logtext('Records:' + inttostr(TempMyQry.recordcount)+chr(13));
                  Logtext('==========================================================================');
                except
                  on e: EDatabaseError do
                  begin
                    CommonLib.MessageDlgXP_Vista('There is A Possible SQL Error with This Template' + #10#13 +
                      'Check Template And Try Again !' + e.Message, mtWarning, [mbOK], 0);
                      Logtext(e.Message);
                    Exit;
                  end;
                end;
              end;
            (*end;*)
          end;

          if Assigned(MasterDetailLink) then
            ApplyMasterDetailLink(MasterDetailLink);

          try
            ReportStream.Position := 0;
            Report.Template.LoadFromStream(ReportStream);
            if fsPrintername <> '' then printername := fsPrintername;
            if fUseEmployeeShowPrintDialogPref then
              Report.ShowPrintDialog := AppEnv.Employee.ShowPrintDialog
            else
              Report.ShowPrintDialog := False;

            if DoPrint then begin
              if not DirectoryExists(ExeDir + 'MailMergeFiles') then
                  if not CreateDir(ExeDir + 'MailMergeFiles') then
                    raise Exception.Create('Cannot create ' + ExeDir + '\MailMergeFiles');

              Report.DeviceType := 'Printer';
              if fMMFileType = 'HTML' then begin
                Report.DeviceType := 'HTMLFile' ;  //create this file for emailing
                RTemplates.report.textfilename := ExeDir + 'MailMergeFiles\Merge.htm';
              end else if fMMFileType = 'Pdf' then begin
                report.textfilename := ExeDir + 'MailMergeFiles\' + ReportNameStr + '_' + fMMRecipientName + '.PDF';

                Report.AllowPrintToFile := True;
                Report.ShowPrintDialog := False;
                Report.PDFSettings.Author := AppEnv.CompanyInfo.Tradingname;
                Report.PDFSettings.Title := 'Print to PDF!';
                Report.PDFSettings.CompressionLevel := clDefault;
                Report.PDFSettings.OptimizeImageExport := True;
                Report.PDFSettings.OpenPDFFile := False;

                RTemplates.Report.DeviceType := 'PDF';
                RTemplates.Report.Print;
                exit;
              end else if fMMFileType = 'bmp' then begin
                Report.DeviceType := 'GraphicFile';
                RTemplates.report.textfilename := ExeDir + 'MailMergeFiles\IMG001.bmp';
              end;
            end else begin
              MaxPreview := True;
            end;
            if Copies > 1 then
              Report.PrinterSetup.Copies := Copies;
            Try
              Report.ShowCancelDialog := False;
              Report.OnPreviewFormCreate := doOnPreviewFormCreate;
              Report.Print;

//              if doprint then PlayPrintSound;
              PlayPrintSound;
            except
              on E: Exception do begin
                If Pos('Screen printer does not support printing', E.Message) > 0 then begin
                  CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
                  exit;
                end else
                  raise;
              end;
            end;
          except
            on E:Exception do begin
              CommonLib.MessageDlgXP_Vista('Could not create Report, Possible template mismatch.'+chr(13) +chr(13) + E.Message, mtWarning, [mbOK], 0);
            end;
          end;
        end;
      finally
        FreeandNil(RTemplates);
      end;
    end;
  end;
end;
procedure TPrintTemplates.DoCancelPreviewAllbtnclick(Sender:TObject);
begin
    if assigned(CancelPreviewAllbtnclick) then CancelPreviewAllbtnclick(Sender);
    if Assigned(CancelButton) then CancelButton.click;
    CancelPreviewAll :=True;
end;
procedure TPrintTemplates.doOnPreviewFormCreate(Sender:TObject);
var
  btnCancelPreviewAll:TppTBXItem;
begin
  if not (Sender is TppReport) then exit;

  try
    {button to cancel all printing when printed inside a loop}
    btnCancelPreviewAll:= TppTBXItem(TppPrintPreview(TppReport(sender).previewform).toolbar.GetItemForName('btnCancelPreviewAll'));
    CancelButton:= TppPrintPreview(TppReport(sender).previewform).CancelButton;
    if assigned(btnCancelPreviewAll) then begin
      btnCancelPreviewAll.visible := ShowCancelPreviewBtninReportPreview;
      CancelPreviewAllbtnclick    := btnCancelPreviewAll.OnClick;
      btnCancelPreviewAll.OnClick := DoCancelPreviewAllbtnclick;
    end;
  except
    on E:Exception do begin
      if commonlib.DevMode then
        MessageDlg('Error hiding/displaying the close All button in report'+NL+NL+E.Message, mtWarning, [mbOK], 0);
    end;
  end;

end;
procedure TPrintTemplates.PrintMailMerge(const ReportNameStr: string;
  const SQLPortion: string; const DoPrint: Boolean; const FileType: string;
  RecipientName: string; MasterDetailLink: TJsonObject = nil);
begin
  fMMFileType := FileType;
  fMMRecipientName := RecipientName;
  PrintTemplateReport(ReportNameStr,SQLPortion ,DoPrint,1, nil, '', MasterDetailLink);
end;


function TPrintTemplates.ReplaceStr(const sString, sOldStr, sNewStr: string): string;
begin
  Result := StringReplace(sString, sOldStr, sNewStr, [rfReplaceAll]);
end;

procedure TPrintTemplates.LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = '');
begin
  if (fsReportName <> '') then
    fsReportName := TemplateNameToTemplateClassName(Trim(fsReportName))
  else
    fsReportName := TemplateReportsTypeLib.GetDefaultReport(ReportTypeID);
end;

//function TPrintTemplates.AddTemplateAttachments(FEmailSender :T2cEmailSender; aReportID:Integer):String;
//var
//  Qry :TERPQuery;
//  fsFileName:String;
//begin
//  result := '';
//  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
//  try
//    Qry.SQL.Text := 'SELECT  AttachmentId, `TableName`,  Attachment, attachmentName '+
//                    ' FROM `tblattachments`  '+
//                    ' WHERE `TableName` = "tbltemplates" and tableId = ' + inttostr(aReportID)+' and active ="T"';
//    Qry.open;
//    if Qry.recordcount =0 then exit;
//    Qry.first;
//    While Qry.eof = False do begin
//      fsFileName :=trim(Qry.FieldByName('AttachmentId').AsString) +'_'+ Trim(Qry.FieldByName('attachmentName').AsString);
//      TBlobfield(Qry.FieldByName('Attachment')).SaveToFile(Commonlib.TempDir  + fsFileName);
//      FEmailSender.AddAttachment(Commonlib.TempDir  + fsFileName);
//      if result <> '' then result := result +','; Result := result + fsfileName;
//      Qry.Next;
//    end;
//  finally
//    DbSharedObj.ReleaseObj(qry);
//  end;
//    //FEmailSender.AddAttachment((*ExtractFilePath(ParamStr(0)) *)Commonlib.TempDir +OutGoingFileName);
//end;

function TPrintTemplates.AddTemplateAttachments(Corres :TCorrespondenceGui; aReportID: Integer): String;
var
  Qry :TERPQuery;
  fsFileName:String;
begin
  result := '';
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    Qry.SQL.Text := 'SELECT  AttachmentId, `TableName`,  Attachment, attachmentName '+
                    ' FROM `tblattachments`  '+
                    ' WHERE `TableName` = "tbltemplates" and tableId = ' + inttostr(aReportID)+' and active ="T"';
    Qry.open;
    if Qry.recordcount =0 then exit;
    Qry.first;
    While Qry.eof = False do begin
      fsFileName :=trim(Qry.FieldByName('AttachmentId').AsString) +'_'+ Trim(Qry.FieldByName('attachmentName').AsString);
      TBlobfield(Qry.FieldByName('Attachment')).SaveToFile(Commonlib.TempDir  + fsFileName);
      Corres.AttachmentList.Add(Commonlib.TempDir  + fsFileName);
      if result <> '' then result := result +','; Result := result + fsfileName;
      Qry.Next;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

Function TPrintTemplates.SaveTemplateReport(const ReportNameStr, SQLPortion: string;
  const DoPrint: boolean; const FileType: string; const FileName: string = 'EmailReport';
  const DBConnection: TCustomConnection = nil; MasterDetailLink: TJsonObject = nil) : Boolean;
begin
  REsult := inherited SaveReport(ReportNameStr, SQLPortion,DoPrint,FileType,FileName,DBConnection,MasterDetailLink);
  if SaveReportErrorNo = 1 then begin
    if not SaveReport(ReportNameStr, SQLPortion, DoPrint, FileType, FileName, DBConnection,MasterDetailLink) then begin
      if Pos('Unable to write to RBuilder.ini',SaveReportErrorMsg) > 0 then begin
        MessageDlgXP_Vista('Windows is preventing Report Builder from writing' +
          ' a file to the disk (RBuilder.ini), please ensure that the user' +
          ' you are logged on as has full rights to access the disk', mtInformation, [mbOk],0);
      end else
        MessageDlgXP_Vista(SaveReportErrorMsg, mtWarning, [mbOk],0);
    end;
  end else if SaveReportErrorNo = 2 then begin
    CommonLib.MessageDlgXP_Vista(SaveReportErrorMsg, mtWarning, [mbOK], 0);
  end else if SavereportErrorNo = 3 then begin
    If Sysutils.SameText(SaveReportErrorMsg,'Screen printer does not support printing') then begin
      CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
    end else
      MessageDlgXP_Vista(SaveReportErrorMsg, mtWarning, [mbOk],0);
  end else if SaveReportErrorNo= 4 then begin
    CommonLib.MessageDlgXP_Vista('Could not create Report, Possible template mismatch.'+chr(13) +chr(13) + SaveReportErrorMsg, mtWarning, [mbOK], 0);
  end else if SaveReportErrorNo= 5 then begin
    CommonLib.MessageDlgXP_Vista('Could not create Report into PDF.'+chr(13) +chr(13) + SaveReportErrorMsg, mtWarning, [mbOK], 0);
  end;
end;
(*var
  FileExt: string;
  Tempqry: TERPQuery;
  TempMyqry: TERPQuery;
  iSQLcounter: integer;
  PipeName: string;
  Templates: TReportTemplates;
  bAnyRecsToPrint:Boolean;
  s:String;
begin
  if Assigned(DBConnection) then
    conFormConnection := DBConnection
  else
    conFormConnection := CommonDbLib.GetSharedMyDacConnection;

  try
    Templates := TReportTemplates.Create;
  except
    on e: exception do begin
      if Pos('Unable to write to RBuilder.ini',e.Message) > 0 then begin
        MessageDlgXP_Vista('Windows is preventing Report Builder from writing' +
          ' a file to the disk (RBuilder.ini), please ensure that the user' +
          ' you are logged on as has full rights to access the disk', mtInformation, [mbOk],0);
        exit;
      end
      else
        raise;
    end;
  end;

  if not Templates.CheckTemplateExists(ReportNameStr) then begin
    CommonLib.MessageDlgXP_Vista('Report template "' + ReportNameStr + '" not found in database.', mtWarning, [mbOK], 0);
  end
  else begin
    bAnyRecsToPrint := False;
    with Templates do
    begin
      try
        if not CreatedOk then exit;
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
              PipeName := Trim(ExtractStrPortion(ReplaceStr(TempMyqry.Sql.Text, '{', ''), '}', 0));

              if Trim(TempMyqry.Sql.Text) <> PipeName then
              begin
                Templates.PipelineUserName[iSQLcounter] := PipeName;
                TempMyqry.Sql.Text := ReplaceStr(TempMyqry.Sql.Text, '{' + PipeName + '}', '');
              end;

              try
                SetParameters(TempMyqry);
                Open;
                If RecordCount=0 then Continue; //Exit;
                if RecordCount > 0 then bAnyRecsToPrint := True;
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
              PipeName := Trim(ExtractStrPortion(ReplaceStr(Tempqry.Sql.Text, '{', ''), '}', 0));

              if (Trim(Tempqry.Sql.Text) <> PipeName) then
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

          if FileType = 'HTMLFile' then
            FileExt := 'HTM'
          else if FileType = 'GraphicFile' then
            FileExt := 'BMP'
          else if FileType = 'PDF' then
            FileExt := 'PDF';

          FileExt := Trim(FileExt);

          // if the file name containes the extension, then no need to add the extension again.
          if FastFuncs.PosEx(uppercase('.' + fileExt), uppercase(FileName)) = 0 then
            Report.TextFileName := FileName + '.' + FileExt
          else
            Report.TextFileName := FileName;

          s:= ExtractFilePath(Templates.Report.TextFileName);
          if s = '' then Report.TextFileName := Commonlib.TempDir +Report.TextFileName
          else if DirectoryExists(s) then
          else Report.TextFileName :=  Commonlib.TempDir +replacestr(Report.TextFileName, s, '');
          SysUtils.DeleteFile(Report.TextFileName);
          Application.ProcessMessages;

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
              If Sysutils.SameText(E.Message,'Screen printer does not support printing') then begin
                CommonLib.MessageDlgXP_Vista('No Printer Available !', mtInformation, [mbOK], 0);
              end else
                raise;
            end;
          end;
        except
          on E:Exception do begin
            CommonLib.MessageDlgXP_Vista('Could not create Report, Possible template mismatch.'+chr(13) +chr(13) + E.Message, mtWarning, [mbOK], 0);
          end;
        end;
      finally
        Free;
      end;
    end;
  end;
end;*)

function TPrintTemplates.TemplateNameToTemplateClassName(const TemplateName: string): string;
begin
  Result := '';

  with TERPQuery.Create(nil) do
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

procedure TPrintTemplates.LoadReportTypes;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
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


