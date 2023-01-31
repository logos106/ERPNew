unit ERPVideos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TERPVideosGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainPageIndex: TIntegerField;
    qryMainPagename: TWideStringField;
    qryMainPagehint: TWideStringField;
    qryMainPageCaption: TWideStringField;
    qryMainfilename: TWideStringField;
    qryMainDateCreated: TDateField;
    qryMainApproved: TWideStringField;
    qryMainSynchronized: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainmsUpdateSiteCode: TWideStringField;
    btnSynch: TDNMSpeedButton;
    btnDownloadAll: TDNMSpeedButton;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure btnSynchClick(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);   override;
    procedure btnDownloadAllClick(Sender: TObject);
  private
    formShown :Boolean;
    downloadMsg:String;
    Procedure RefreshQuery(Sender: TObject);Overload;
    Procedure RefreshListnLocateRec(Sender:Tobject);
    procedure Exportlist;
    function downloadfile(URL, filename:String; var Msg:String):Boolean;
    function DownLoadVideofile: boolean;
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    Procedure RefreshQuery;Overload;override;
  end;


implementation

uses CommonLib, VideosnworkFlowObj, CommonFormLib, ExportDataObj, Objvideos,
  AppEnvironment , ShellAPI, FileDownloadFuncs, frmImportERPVideos, tcConst,
  frmERPVideo, TimedHint, frmMessageWithList, frmMessageBase, SharedObjs,
  CommonDbLib, UpdaterConst;

{$R *.dfm}
Function TERPVideosGUI.DownLoadVideofile : boolean;
var
  aDownloadResult: TFileDownloadResult;
  configFile: string;
begin
  inherited;
  REsult := True;
  configFile:= TVideoObj.VideoDirectory + VIDEO_CONFIG_FILE;
  ForceDirectories(TVideoObj.VideoDirectory);
  TFileDownloader.DownloadFile(VIDEO_FTP_URL +VIDEO_CONFIG_FILE , configFile, aDownloadResult);
  if aDownloadResult= drConnectFailed then begin
    if fileExists(configFile) then begin
      MessageDlgXP_vista('Internet access failed to update the video list. The list is synchronized with the local list.', mtWarning, [mbOK], 0);
    end else begin
      MessageDlgXP_vista('Internet access failed to download the video list.', mtWarning, [mbOK], 0);
      REsult := False;
    end;
  end else if aDownloadResult = drFileReplaced then begin
      REsult := True;
  end;
end;
procedure TERPVideosGUI.btnSynchClick(Sender: TObject);
var
  fstablename:String;
begin
  inherited;
  if MessageDlgXP_vista('This will clear the exisitng videolist and will synchronize with the ERP List. Do you want to continue? ', mtConfirmation, [mbYes, mbNo], 0)= mrno then exit;
  //if formShown then OpenERPFormModal('TfmImportERPVideos', 0, nil,False);
  Hidehint(btnSynch);
  if not DownloadVideofile then exit;
  with scriptmain do begin
    SQL.Clear;
    fsTableName:= CommonDbLib.GetUserTemporaryTableName('tblvideos');
    SQL.Add('Drop table if exists '+ fsTableName +';');
    SQL.Add('create table  '+ fsTableName +' like tblvideos;');
    SQL.Add('insert into '+ fsTableName +' select *  from tblvideos where Synchronized="F";');
    SQL.Add('truncate tblvideos');
    Execute;
  end;
  TfmImportERPVideos.ImportERPVideos;
  with scriptmain do begin
    SQL.Clear;
    SQL.Add('insert ignore into tblvideos (PageIndex,Pagename,Seqno,Pagehint,PageCaption,filename,DateCreated,Approved,Synchronized) '+
              ' select PageIndex,Pagename,Seqno,Pagehint,PageCaption,filename,DateCreated,Approved,Synchronized  from  '+ fsTableName +';');
    Execute;
  end;
  btnRequery.click;
  if grpFilters.itemindex = 1 then grpFilters.itemindex := 2;
end;

procedure TERPVideosGUI.cmdExportClick(Sender: TObject);
begin
  if not devmode then begin
      inherited;
      exit;
  end;
  Exportlist;
end;

procedure TERPVideosGUI.Exportlist;
var
  Exporter: TDataExporter;
  str:String;
begin
  Exporter:= TDataExporter.Create;
  try
    Exporter.DataFormat:= dfCSV;
    Exporter.StopOnError:= false;
    //Exporter.SeparatorValue := #9;
    Exporter.ExportDataToFile('TERPVideo',TVideoObj.VideoDirectory + VIDEO_CONFIG_FILE);
    if MessageDlgXP_vista('Video list is exported to ' +quotedstr(TVideoObj.VideoDirectory + VIDEO_CONFIG_FILE)+' . Do you want to send this to ERP for update? ', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
              processingcursor(true);
              try

                str:= 'INSERT INTO `tblvideos` (`PageIndex`, `Pagename`, `Seqno`, `Pagehint`, `PageCaption`, `filename`, `Approved`) ' +
                      'Select ' + inttostr(qrymainPageIndex.asInteger)+', '+
                                quotedstr(QrymainPagename.asString)+','+
                                ' (Select Max(Seqno)+1 from tblvideos where Pagename ='+ quotedstr(QrymainPagename.asString) +' ) Seqno,'+
                                quotedstr(QrymainPagehint.asString)+','+
                                quotedstr(QrymainPageCaption.asString)+','+
                                quotedstr(Qrymainfilename.asString)+','+
                                quotedstr('F')+
                                ' ON DUPLICATE KEY UPDATE Pageindex = ' + inttostr(qrymainPageIndex.asInteger)+', '+
                                                        ' Pagename = '+quotedstr(QrymainPagename.asString)+' ,  '+
                                                        ' pagehint = '+quotedstr(QrymainPagehint.asString)+','+
                                                        ' pagecaption = ' + quotedstr(QrymainPageCaption.asString) +';';

                str:=  SendEmailtoErp('Video List updated from :  ' + Appenv.Employee.EmployeeName+' ('+ Appenv.CompanyInfo.Companyname+')',
                                        'Filename :' + ExtractFileName(TVideoObj.VideoDirectory + VIDEO_CONFIG_FILE) + chr(13) +
                                        'From     : ' + Appenv.CompanyInfo.Companyname+ chr(13) +
                                        'User     : ' + Appenv.Employee.EmployeeName+ chr(13) +
                                        'Date     : ' +formatDateTime('dd-mm-yyyy hh:nn' , now()) +chr(13)+chr(13)+
                                        'Note for ERP: Upload this file to the FTP folder : /public_html/Docs' +chr(13)+chr(13)+
                                        ' SQL : ' + str , '' ,  TVideoObj.VideoDirectory + VIDEO_CONFIG_FILE );
              finally
                ProcessingCursor(False);
              end;
              if str <> '' then MessageDlgXP_Vista('Emailing Video List  to ERP failed. Please Contact ERP.'+chr(13)+'Error Log:'+str , mtwarning, [mbok],0)
              else MessageDlgXP_Vista('Video List is emailed to ERP.', mtInformation, [mbok],0);
            end else begin
              //ShellExecute(Handle, 'Open', PChar(ExtractFilePath(filename)) , '', '', SW_SHOWNORMAL)
              ShellExecute(0, nil, 'explorer.exe', PChar('/select,'+TVideoObj.VideoDirectory + VIDEO_CONFIG_FILE ), nil,  SW_SHOWNORMAL)
            end;
  finally
    Exporter.Free;
  end;

end;

procedure TERPVideosGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  if grpfilters.itemindex = 0 then grpfilters.itemindex:= 2;
  OpenERPFormModal('TfmERPVideo' , 0, nil, false, RefreshListnLocateRec);
end;

procedure TERPVideosGUI.FormCreate(Sender: TObject);
begin
  formShown:= False;
  inherited;
  cmdNew.enabled := devmode;
  SearchMode:= smFullList;
end;

procedure TERPVideosGUI.FormShow(Sender: TObject);
begin
  inherited;
  formShown := True;
  lblNote.caption := 'Double click on the ' + Qrymainfilename.displaylabel+' to Play / Upload the file.';
  if qrymain.recordcount =0 then ShowTimedHint(btnSynch ,  'Please choose to synchronize with the ERP list.' +NL + btnSynch.hint , true );
end;

procedure TERPVideosGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (Qrymainsynchronized.asBoolean =false) and (grpfilters.ItemIndex <> 1) then Afont.color := clred;
end;
procedure TERPVideosGUI.btnDownloadAllClick(Sender: TObject);
var
  Qry:TERPQuery;
begin
  inherited;
  if MessageDlgXP_Vista('This will download all video files you have filtered on within the list.'+NL+
                'Each video will take few minutes to download (depending on the download speed of the internet connection).'+NL+NL+
                'Do you want to continue? ', mtConfirmation, [mbYes, mbNo], 0)= mrno then exit;
  downloadMsg := '';
  iterateprocno := 1;
  Iteraterecords(True , 'Downloading all Videos');
  if downloadMsg <> '' then begin
    Qry:= SharedQryObj(downloadMsg );
    InitMsgParams;
    PopupMsgParams.Msgcaption := 'Videos Download Status';
    PopupMsgParams.Msgds := Qry;
    PopupMsgParams.MsgHeight := self.Height;
    PopupMsgParams.fieldnames := 'Pagename,pagehint,pagecaption,filename,ResponseMSg';
    PopupMsgParams.displayLabels:= (Qrymainpagename.DisplayLabel)+',' +
                                   (qryMainPagehint.DisplayLabel)+',' +
                                   (qryMainPageCaption.DisplayLabel)+',' +
                                   (qryMainfilename.DisplayLabel)+',' +('Download Response');
    PopupMsgParams.MsgWidth := Self.Width;
    PopupMsgParams.displayWidths := '150,300,175,180,150';
    PopupMsgParams.Custombuttons := 'OK';
    PopupMsgParams.Msg1:= 'Result of Download';
    PopupMsgParams.Msg2 := '';
    PopupMsgParams.MsgColor := Self.Color;
    TfmMessageWithList.MsgDlg;
    closedb(Qry);
    //Qry:= nil;
  end;
end;
procedure TERPVideosGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer);
var
  URL, filename, s:String;
  Procedure AddResponse(resposeStr:String);
  begin

                if downloadMsg <> '' then downloadMsg := downloadMsg +' union ';
                downloadMsg := downloadMsg +' Select ' +Quotedstr(Qrymainpagename.AsString)+' as pagename , '+
                                   Quotedstr(qryMainPagehint.AsString)+' as Pagehint,'+
                                   Quotedstr(qryMainPageCaption.AsString)+' as pagecaption ,'+
                                   Quotedstr(qryMainfilename.AsString)+' as filename ,'+ Quotedstr(resposeStr) +' as ResponseMSg';

  end;
begin
   if IterateProcno = 1 then begin
        URL:=VIDEO_FTP_URL +Qrymain.fieldbyname('filename').asString;
        filename := TVideoObj.VideoDirectory + Qrymain.fieldbyname('filename').asString;
        if not downloadfile(url, filename, s) then begin
          if sametext(s,  'Connection Failed') then begin
              MessageDlgXP_Vista(s, mtWarning, [mbOK], 0);
              Abort := true;
              if downloadMsg <> '' then AddResponse(s+'.  Download Terminated');
              Exit;
          end;
          AddResponse(s);
        end else begin
          AddResponse(iif(s='','Downloaded',s));
        end;
   end;
end;
function TERPVideosGUI.downloadfile(URL, filename:String; var Msg:String):Boolean;
var
  aDownloadResult: TFileDownloadResult;
begin
        Result := False;
        if (qryMainSynchronized.AsBoolean =False) and (fileExists(fileName)) then
          result := True
        else begin
          TFileDownloader.DownloadFile(URL, FileName, aDownloadResult, frReplaceIfSizeDifferent);
          msg:= '';
          if aDownloadResult= drConnectFailed then msg:= 'Connection Failed'
          else if aDownloadResult=drDownloadFailed then if fileexists(filename) then else msg:= 'Download Failed'
          else begin
            if aDownloadResult = drReplaceNotRequired then msg:= 'File Already exists'
            else if aDownloadResult = drFileReplaced then msg:= 'File replaced'
            else msg:= 'File Downloaded';
            result := True;
          end;
(*          if (s<> '') then
            if showmsg then  MessageDlgXP_Vista(s+chr(13) +'File:'+ URL, mtInformation , [mbok], 0)
            else begin
              TimerMsg(lblNote ,Qrymain.fieldbyname('filename').asString;+':' + s  );
            end;*)
        end;
end;
procedure TERPVideosGUI.grdMainDblClick(Sender: TObject);
var
  fiID:Integer;
  str:String;
  URL, filename, s:String;
  msgOption : word;
begin
  if  (Qrymain.fieldbyname('filename').asString <> '' ) then begin
      MsgOption := MessageDlgXP_Vista('Do you wish to play this file or Upload to ERP?', mtConfirmation, [], 0 , nil, '', '' , False , nil , 'Play,Upload,Cancel');
      if MsgOption = 102 then exit;
      if MsgOption = 100 then begin
        URL:=VIDEO_FTP_URL +Qrymain.fieldbyname('filename').asString;
        filename := TVideoObj.VideoDirectory + Qrymain.fieldbyname('filename').asString;
        if not(downloadfile(url,filename, s)) then begin
          if (s<> '') then MessageDlgXP_Vista(s+chr(13) +'File:'+ URL, mtInformation , [mbok], 0);
          exit;
        end;
        ShellExecute(Handle, 'open',PChar(filename),nil, nil, SW_SHOW);
      end else begin
              processingcursor(true);
              try
                str:=  SendEmailtoErp('Video file updated from :  ' + Appenv.Employee.EmployeeName+' ('+ Appenv.CompanyInfo.Companyname+')',
                                        'Filename :' + ExtractFileName(TVideoObj.VideoDirectory + Qrymainfilename.asString) + chr(13) +
                                        'From     : ' + Appenv.CompanyInfo.Companyname+ chr(13) +
                                        'User     : ' + Appenv.Employee.EmployeeName+ chr(13) +
                                        'Date     : ' +formatDateTime('dd-mm-yyyy hh:nn' , now()) +chr(13)+chr(13)+
                                        'Note for ERP: Upload this file to the FTP folder : /public_html/Docs'  , '' ,  TVideoObj.VideoDirectory + Qrymainfilename.asString+Nl+NL+
                                        'insert ignore into tblvideos (Pageindex , pagename,pagehint, pagecaption, filename) values (' + inttostr(QryMainPageindex.asInteger)+' , '+
                                                                                                                                                  Quotedstr(QryMainpagename.asString )+' , '+
                                                                                                                                                  Quotedstr(QryMainpagehint.asString)+' , '+
                                                                                                                                                  Quotedstr(QryMainpagecaption.asString)+' , '+
                                                                                                                                                  Quotedstr(QryMainfilename.asString)+')' );
              finally
                ProcessingCursor(False);
              end;
              if str <> '' then MessageDlgXP_Vista('Emailing Video file to ERP failed. Please Contact ERP.'+chr(13)+'Error Log:'+str , mtwarning, [mbok],0)
              else MessageDlgXP_Vista('Video file is emailed to ERP.', mtInformation, [mbok],0);
      end;
    Exit;
  end;

  if devmode and sametext(activefieldname  , QrymainApproved.FieldName) then begin
    if QrymainApproved.AsBoolean =false then begin
      if MessageDlgXP_vista('Do you want to approve this Video?', mtConfirmation, [mbYes, mbNo], 0) = mryes then begin
        fiID :=qrymainId.AsInteger;
        with ScriptMain do begin
          SQL.Clear;
          SQL.Text := 'update tblvideos Set Approved ="T" where Id = ' +inttostr(fiID);
          Execute;
          Refreshquery;
          Qrymain.Locate('ID' , fiid , []);
        end;
      end;
      Exit;
    end;
  end;
  inherited;
end;

procedure TERPVideosGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString(Qrymainsynchronized.FieldName , ['T','F','']);
  inherited;

end;

procedure TERPVideosGUI.RefreshQuery(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TERPVideosGUI.RefreshListnLocateRec(Sender:Tobject);
var
  fiId :Integer;
begin
  if not (sender is TfmERPVideo) then Exit;
  fiId := TfmERPVideo(sender).QryvideosID.AsInteger;
  closedb(Qrymain);
  openDB(Qrymain);
  Qrymain.Locate('ID' , fiId, []);
  grdMainDblClick(grdmain);
end;

procedure TERPVideosGUI.Refreshquery;
begin
  Qrymain.parambyname('Approved').asstring :='T';
  Qrymain.parambyname('ShowAll').asstring  := iif(devmode , 'T' , 'F');

  inherited;

end;

procedure TERPVideosGUI.SetGridColumns;
begin
  inherited;
  if not devmode then begin
    RemoveFieldfromGrid(qrymainapproved.fieldname);
    RemoveFieldfromGrid(qrymainSynchronized.fieldname);
    RemoveFieldfromGrid(qrymainDateCreated.fieldname);
    RemoveFieldfromGrid(qrymainApproved.fieldname);
  end;
  RemoveFieldfromGrid(qrymainID.fieldname);
  RemoveFieldfromGrid(qrymainglobalref.fieldname);
  RemoveFieldfromGrid(qrymainpageindex.fieldname);
  RemoveFieldfromGrid(qrymainmstimestamp.fieldname);
  RemoveFieldfromGrid(qrymainmsupdatesitecode.fieldname);

end;

initialization
  RegisterClassOnce(TERPVideosGUI);

end.
