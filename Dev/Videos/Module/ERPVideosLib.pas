unit ERPVideosLib;

interface

uses  ERPdbComponents;

Function VideoDirectory:String;
Function DownloadVideo(VideoID: Integer; QryVideo: TERPQuery=nil):Boolean;

implementation

uses tcConst, SystemLib, DbSharedObjectsObj , CommonDbLib, CommonLib,
  busobjERPVideo, sysutils, db,variants;

Function DownloadVideo(VideoID: Integer; QryVideo: TERPQuery=nil):Boolean;
var
  Qry:TERPQuery;
  fsFilename:String;
begin
  Qry:= nil;
  REsult := False;
  try
   Qry := QryVideo;
   if qry = nil then begin
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    CloseDB(Qry);
    Qry.SQL.Text :=' Select V.ID, V.Pagecaption,VB.video, V.filename, V.mstimeStamp  ' +
                    ' from erpdocumentaion.tblvideos V   ' +
                    ' inner join erpdocumentaion.tblvideoblobs VB on V.Id = VB.ID  where V.ID = '+ inttostr(VideoID);
    Opendb(Qry);
   end;
   if Qry.FieldByName('ID').AsInteger <> VideoId then
    if not Qry.Locate('ID' , VideoID , []) then Exit;

   if Qry.FieldByName('Video').Value = null then Exit;
   if Qry.FieldByName('filename').asString = '' then Exit;
   fsFilename := VideofilenamewithPath(Qry.FieldByName('filename').asString);
   if not (FileExists(fsFilename)) or
    (GetFileDate(fsFilename) <> Qry.FieldByName('msTimeStamp').AsDateTime) then begin
      TBlobfield(Qry.FieldByName('Video')).SaveToFile(fsFilename);
      SetFileDate(fsFilename ,Qry.FieldByName('msTimeStamp').asDateTime);
    end;
   Result := True;
  finally
    if Assigned(Qry) and (Qryvideo = nil) then DbSharedObj.ReleaseObj(Qry);
  end;
end;
Function VideoDirectory:String;
begin
  result:= SystemLib.ExeDir + VIDEO_SUBDIR;
end;

end.
