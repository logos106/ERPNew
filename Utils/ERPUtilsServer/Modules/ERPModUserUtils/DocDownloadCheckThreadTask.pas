unit DocDownloadCheckThreadTask;

interface

uses
  IdHttp, ERPDocsDBObj, ServerModuleThreadTask;

type

  TDocDownloadCheckThreadTask = class(TServerModuleThreadTask)
  private
    fLastPercent: integer;
    procedure OnDataTransferProgress(percent: integer);
    procedure DoDownloadVideoTable(DocsDB: TERPDocsDB);
    procedure DoDownloadHelpDocTable(DocsDB: TERPDocsDB);
  protected
    procedure DoWork; override;
  public
    constructor Create; override;
  end;

implementation

uses
  FileDownloadFuncs, UpdaterConst, InstallConst, SysUtils, LogMessageTypes,
  ERPDBComponents, DateUtils, DB, Windows, HTTPConst;

{ TPingCheckThreadTask }

constructor TDocDownloadCheckThreadTask.Create;
begin
  inherited Create;
  //RemoveWhenComplete := false;
end;

procedure TDocDownloadCheckThreadTask.DoWork;
var
  DocsDB: TERPDocsDB;
//  msg: string;
  //http: TIdHttp;
begin
  inherited;
  DocsDB := TERPDocsDB.Create;
  try
    DocsDB.OnLog := Log;
    DocsDb.Server := MySQLServer;
    try
      DocsDb.DownloadTasks;
    except on e: exception do begin Log('Error checking for ERP Messages: ' + e.Message,ltError); end; end;

    try
      DocsDb.DownloadERPOffices;
    except on e: exception do begin Log('Error checking for ERP Messages: ' + e.Message,ltError); end; end;


    if (not CommonConfig.BooleanExists('DownloadVideos')) or CommonConfig.B['DownloadVideos'] then begin
          try
            DocsDb.DownloadVideoTable;
          except on e: exception do begin Log('Error checking for ERP Videos: ' + e.Message,ltError); end; end;

          Log('Checking for new Videos ..',ltInfo);
          try
            DoDownloadVideoTable(DocsDB);
          finally Log('Finished checking for new Videos.',ltInfo); end;

    end else begin
      Log('Skipped checking for new Videos.',ltInfo);
    end;

    if (not CommonConfig.BooleanExists('DownloadHelpDocs')) or CommonConfig.B['DownloadHelpDocs'] then begin
          try
            DocsDb.DownloadHelpDocTable;
          except on e: exception do begin Log('Error checking for ERP HelpDocs: ' + e.Message,ltError); end; end;

          Log('Checking for new HelpDocs ..',ltInfo);
          try
            DoDownloadHelpDocTable(DocsDB);
          finally Log('Finished checking for new HelpDocs.',ltInfo); end;

    end else begin
      Log('Skipped checking for new HelpDocs.',ltInfo);
    end;


  finally
    DocsDB.Free;
  end;

//  Log('Checking for new Videos ..',ltInfo);
//  try
//    UpdateBaseDir:= ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Updates\';
//    TFileDownloader.DownloadFile(VIDEO_FTP_URL + VIDEO_CONFIG_FILE,
//      UpdateBaseDir + VIDEO_CONFIG_FILE,
//      DownloadResult,
//      frReplaceIfNewer,
//      false,
//      OnDataTransferProgress);
//    case DownloadResult of
//      drNone: Log('Download of Video Config file failed, reason unknown.',ltError);
//      drConnectFailed: Log('Download of Video Config file failed, connection failed.',ltError);
//      drReplaceNotRequired: Log('Video config file is up to date, download not required.',ltDetail);
//      drDownloadFailed: Log('Download of Video Config file failed, reason unknown.',ltError);
//      drFileReplaced: Log('New Video Config file downloaded.',ltInfo);
//      drDownloadCancelled: Log('Download of Video Config file failed, download cancelled.',ltError);
//    end;
//    DocsDB := TERPDocsDB.Create;
//    try
//      DocsDB.OnLog := Log;
//      qry := TERPQuery.Create(nil);
//      qry2 := TERPQuery.Create(nil);
//      try
//        DocsDb.Server := 'localhost';
//        qry.Connection := DocsDB.Connection;
//        qry2.Connection := DocsDB.Connection;
//        qry.SQL.Text := 'select Count(ID) as RecCount from ' + VIDEO_TABLE_NAME;
//        qry.Open;
//        if (DownloadResult = drFileReplaced) or (qry.FieldByName('RecCount').AsInteger = 0) then begin
////          if not DocsDb.UpdateVideoTableFromConfigFile(msg, UpdateBaseDir + VIDEO_CONFIG_FILE) then begin
////            Log('Error reading latest info from Video Config file with error: ' + msg,ltError);
////            exit;
////          end;
//          if not DocsDb.DownloadVideoTable then
//            exit;
//        end;
//        qry.Close;
//        if self.Terminated then exit;
//        http:= TIdHttp.Create(nil);
//        try
//          qry.SQL.Text := 'select Id, FileName, msTimeStamp from ' + VIDEO_TABLE_NAME + ' where Active = "T"';
//          qry.Open;
//          while not qry.Eof do begin
//            try
//              if self.Terminated then exit;
//
//              http.Head(VIDEO_FTP_URL + StringReplace(qry.FieldByName('FileName').AsString,' ','%20',[rfReplaceAll]));
//              if (SecondSpan(http.Response.lastmodified, qry.FieldByName('msTimeStamp').AsDateTime) > 5) then begin
//                { we need to get the new file ... }
//                ServerTime := http.Response.lastmodified;
//                SysUtils.DeleteFile(UpdateBaseDir + 'temp.tmp');
//                Log('Downloading new video "' + qry.FieldByName('FileName').AsString + '"',ltInfo);
//                TFileDownloader.DownloadFile(VIDEO_FTP_URL + StringReplace(qry.FieldByName('FileName').AsString,' ','%20',[rfReplaceAll]),
//                  UpdateBaseDir + 'temp.tmp',
//                  DownloadResult,
//                  frReplaceAlways,
//                  false,
//                  OnDataTransferProgress);
//                case DownloadResult of
//                  drNone: Log('Download of Video file failed, reason unknown.',ltError);
//                  drConnectFailed: Log('Download of Video file failed, connection failed.',ltError);
//                  drReplaceNotRequired: Log('Video file is up to date, download not required.',ltDetail);
//                  drDownloadFailed: Log('Download of Video file failed, reason unknown.',ltError);
//                  drFileReplaced: Log('New Video file downloaded.',ltInfo);
//                  drDownloadCancelled: Log('Download of Video file failed, download cancelled.',ltError);
//                end;
//                if DownloadResult = drFileReplaced then begin
//                  qry.Connection.StartTransaction;
//                  qry2.SQL.Text := 'select * from ' + VIDEO_TABLE_NAME + ' where Id = ' + qry.FieldByName('Id').AsString;
//                  qry2.Open;
//
//                  qry2.Edit;
//                  TBlobField(qry2.FieldByName('Video')).LoadFromFile(UpdateBaseDir + 'temp.tmp');
//                  qry2.FieldByName('msTimeStamp').AsDateTime := ServerTime;
//                  qry2.Post;
//                  qry2.Close;
//                  qry.Connection.Commit;
//                  SysUtils.DeleteFile(UpdateBaseDir + 'temp.tmp');
//                end;
//              end;
//
//            except
//              on e: exception do begin
//                if qry.Connection.InTransaction then
//                  qry.Connection.Rollback;
//                Log('Error updating Video file from website "' + qry.FieldByName('FileNAme').AsString + '" with error: ' + e.Message,ltError);
//              end;
//            end;
//
//            qry.Next;
//          end;
//
//        finally
//          http.Free;
//        end;
//
//      finally
//        qry.Free;
//        qry2.Free;
//      end;
//      if self.Terminated then exit;
//    finally
//      DocsDb.Free;
//    end;
//
//  finally
//    Log('Finished checking for new Videos.',ltInfo);
//  end;


end;
Procedure TDocDownloadCheckThreadTask.DoDownloadHelpDocTable(DocsDB: TERPDocsDB);
var
    ServerTime: TDateTime;
    qry, qry2: TERPQuery;
    DownloadResult: TFileDownloadResult;
    UpdateBaseDir: string;
    http: TIdHttp;
    fs:String;
begin
        qry := TERPQuery.Create(nil);
        qry2 := TERPQuery.Create(nil);
        try
          DocsDb.Server := MySQLServer;
          qry.Connection := DocsDB.Connection;
          qry2.Connection := DocsDB.Connection;
          if self.Terminated then exit;
          http:= TIdHttp.Create(nil);
          try
            http.Request.UserAgent := HTTPConst.TrueERPUserAgent;
            //qry.SQL.Text := 'select V.Id, V.FileName, VB.HelpDocTimeStamp from ' + HelpDoc_TABLE_NAME + ' V Left join '+ HelpDocBLOB_TABLE_NAME +' VB on V.Id = VB.ID where V.Active = "T"';
            Qry.SQL.Text :=' Select HD.ID, HD.filename,  ' +
                    ' HDb.HelpDocTimeStamp  ' +
                    ' from erpdocumentaion.tblHelpdocs HD   ' +
                    ' left join erpdocumentaion.tblHelpdocblobs HDB on HD.Id = HDB.ID   ' +
                    ' WHERE HD.active ="T"';
            qry.Open;
            while not qry.Eof do begin
              try
                if self.Terminated then exit;
                fs:=HelpDoc_FTP_URL + StringReplace(qry.FieldByName('FileName').AsString,' ','%20',[rfReplaceAll]);
                http.Head(fs);
                if (SecondSpan(http.Response.lastmodified, qry.FieldByName('HelpDocTimeStamp').AsDateTime) > 5) then begin
                  { we need to get the new file ... }
                  ServerTime := http.Response.lastmodified;
                  SysUtils.DeleteFile(UpdateBaseDir + 'temp.tmp');
                  Log('Downloading new HelpDoc "' + qry.FieldByName('FileName').AsString + '"',ltInfo);
                  TFileDownloader.DownloadFile(HelpDoc_FTP_URL + StringReplace(qry.FieldByName('FileName').AsString,' ','%20',[rfReplaceAll]),
                    UpdateBaseDir + 'temp.tmp',
                    DownloadResult,
                    frReplaceAlways,
                    false,
                    OnDataTransferProgress);
                  case DownloadResult of
                    drNone: Log('Download of HelpDoc file failed, reason unknown.',ltError);
                    drConnectFailed: Log('Download of HelpDoc file failed, connection failed.',ltError);
                    drReplaceNotRequired: Log('HelpDoc file is up to date, download not required.',ltDetail);
                    drDownloadFailed: Log('Download of HelpDoc file failed, reason unknown.',ltError);
                    drFileReplaced: Log('New HelpDoc file downloaded.',ltInfo);
                    drDownloadCancelled: Log('Download of HelpDoc file failed, download cancelled.',ltError);
                  end;
                  if DownloadResult = drFileReplaced then begin
                    qry.Connection.StartTransaction;
                    qry2.SQL.Text := 'select * from ' + HelpDocBLOB_TABLE_NAME + ' where Id = ' + qry.FieldByName('Id').AsString;
                    qry2.Open;
                    if qry2.recordcount =0 then begin
                      qry2.Insert;
                      qry2.fieldbyname('ID').AsInteger := qry.FieldByName('Id').AsInteger;
                      qry2.Post;
                    end;

                    qry2.Edit;
                    TBlobField(qry2.FieldByName('HelpDoc')).LoadFromFile(UpdateBaseDir + 'temp.tmp');
                    qry2.FieldByName('HelpDocTimeStamp').AsDateTime := ServerTime;
                    qry2.Post;
                    qry2.Close;
                    qry.Connection.Commit;
                    SysUtils.DeleteFile(UpdateBaseDir + 'temp.tmp');
                  end;
                end;

              except
                on e: exception do begin
                  if qry.Connection.InTransaction then
                    qry.Connection.Rollback;
                  if qry.Active then
                    Log('Error updating HelpDoc file from website "' + qry.FieldByName('FileName').AsString + '" with error: ' + e.Message,ltError)
                  else
                    Log('Error updating HelpDoc file from website with error: ' + e.Message,ltError);
                end;
              end;

              qry.Next;
            end;

          finally
            http.Free;
          end;

        finally
          qry.Free;
          qry2.Free;
        end;

end;
Procedure TDocDownloadCheckThreadTask.DoDownloadVideoTable(DocsDB: TERPDocsDB);
var
    qry, qry2: TERPQuery;
    ServerTime: TDateTime;
    DownloadResult: TFileDownloadResult;
    UpdateBaseDir: string;
    http: TIdHttp;
    fs:String;
begin
        qry := TERPQuery.Create(nil);
        qry2 := TERPQuery.Create(nil);
        try
          DocsDb.Server := MySQLServer;
          qry.Connection := DocsDB.Connection;
          qry2.Connection := DocsDB.Connection;
          if self.Terminated then exit;
          http:= TIdHttp.Create(nil);
          try
            http.Request.UserAgent := HTTPConst.TrueERPUserAgent;
            qry.SQL.Text := 'select V.Id, V.FileName, VB.VideoTimeStamp from ' + VIDEO_TABLE_NAME + ' V Left join '+ VIDEOBLOB_TABLE_NAME +' VB on V.Id = VB.ID where V.Active = "T"';
            qry.Open;
            while not qry.Eof do begin
              try
                if self.Terminated then exit;
                fs:=VIDEO_FTP_URL + StringReplace(qry.FieldByName('FileName').AsString,' ','%20',[rfReplaceAll]);
                http.Head(fs);
                if (SecondSpan(http.Response.lastmodified, qry.FieldByName('VideoTimeStamp').AsDateTime) > 5) then begin
                  { we need to get the new file ... }
                  ServerTime := http.Response.lastmodified;
                  SysUtils.DeleteFile(UpdateBaseDir + 'temp.tmp');
                  Log('Downloading new video "' + qry.FieldByName('FileName').AsString + '"',ltInfo);
                  TFileDownloader.DownloadFile(VIDEO_FTP_URL + StringReplace(qry.FieldByName('FileName').AsString,' ','%20',[rfReplaceAll]),
                    UpdateBaseDir + 'temp.tmp',
                    DownloadResult,
                    frReplaceAlways,
                    false,
                    OnDataTransferProgress);
                  case DownloadResult of
                    drNone: Log('Download of Video file failed, reason unknown.',ltError);
                    drConnectFailed: Log('Download of Video file failed, connection failed.',ltError);
                    drReplaceNotRequired: Log('Video file is up to date, download not required.',ltDetail);
                    drDownloadFailed: Log('Download of Video file failed, reason unknown.',ltError);
                    drFileReplaced: Log('New Video file downloaded.',ltInfo);
                    drDownloadCancelled: Log('Download of Video file failed, download cancelled.',ltError);
                  end;
                  if DownloadResult = drFileReplaced then begin
                    qry.Connection.StartTransaction;
                    qry2.SQL.Text := 'select * from ' + VIDEOBLOB_TABLE_NAME + ' where Id = ' + qry.FieldByName('Id').AsString;
                    qry2.Open;
                    if qry2.recordcount =0 then begin
                      qry2.Insert;
                      qry2.fieldbyname('ID').AsInteger := qry.FieldByName('Id').AsInteger;
                      qry2.Post;
                    end;

                    qry2.Edit;
                    TBlobField(qry2.FieldByName('Video')).LoadFromFile(UpdateBaseDir + 'temp.tmp');
                    qry2.FieldByName('VideoTimeStamp').AsDateTime := ServerTime;
                    qry2.Post;
                    qry2.Close;
                    qry.Connection.Commit;
                    SysUtils.DeleteFile(UpdateBaseDir + 'temp.tmp');
                  end;
                end;

              except
                on e: exception do begin
                  if qry.Connection.InTransaction then
                    qry.Connection.Rollback;
                  if qry.Active then
                    Log('Error updating Video file from website "' + qry.FieldByName('FileName').AsString + '" with error: ' + e.Message,ltError)
                  else
                    Log('Error updating Video file from website with error: ' + e.Message,ltError);
                end;
              end;

              qry.Next;
            end;

          finally
            http.Free;
          end;

        finally
          qry.Free;
          qry2.Free;
        end;

end;
procedure TDocDownloadCheckThreadTask.OnDataTransferProgress(percent: integer);
begin
  if Frac(percent / 5) = 0 then begin
    if fLastPercent <> percent then begin
      fLastPercent := percent;
      Log('Downloading file ' + IntToStr(percent) + '%',ltDetail);
    end;
  end;
end;

end.
