unit HelpDocLib;


interface

uses  ERPdbComponents;

Function HelpdocDirectory:String;
Function DownloadHelpdoc(HelpdocID: Integer; QryHelpdoc: TERPQuery=nil):Boolean;
Function HelpdocfilenamewithPath(filename:string=''):String;

implementation

uses tcConst, SystemLib, DbSharedObjectsObj , CommonDbLib, CommonLib,
  busobjERPHelpdoc, sysutils, db,variants, dialogs;

Function DownloadHelpdoc(HelpdocID: Integer; QryHelpdoc: TERPQuery=nil):Boolean;
var
  Qry:TERPQuery;
  fsFilename:String;
  fsSQL:String;
begin
  Qry:= nil;
  REsult := False;
  try
   Qry := QryHelpdoc;
   if qry = nil then
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
   fsSQL := ' Select HD.ID, HD.Description,HDB.HelpDoc, HD.filename,Filetype as Filetype , HD.mstimeStamp  ' +
                    ' from erpdocumentaion.tblHelpdocs HD   ' +
                    ' Left join erpdocumentaion.tblHelpdocblobs HDB on HD.Id = HDB.ID  where HD.ID = '+ inttostr(HelpdocID);
   if (Qry.active = False) or (not(Sametext(Qry.SQL.TExt , fsSQL))) then begin
    CloseDB(Qry);
    Qry.SQL.Text :=fsSQL;
    Opendb(Qry);
   end;
   if Qry.FieldByName('ID').AsInteger <> HelpdocId then
    if not Qry.Locate('ID' , HelpdocID , []) then Exit;

   if Qry.FieldByName('HelpDoc').asString = '' then begin
      MessageDlgXP_Vista(quotedstr(Qry.FieldByName('filename').asString)+' is Missing. ERP Synchronizes the Help Doc files Hourly. Please Try Again Later', mtInformation, [mbOK], 0);
      Exit;
   end;
   if Qry.FieldByName('filename').asString = '' then Exit;
   fsFilename := HelpdocfilenamewithPath(Qry.FieldByName('filename').asString);
   if not (FileExists(fsFilename)) or
    (GetFileDate(fsFilename) <> Qry.FieldByName('msTimeStamp').AsDateTime) then begin
      TBlobfield(Qry.FieldByName('HelpDoc')).SaveToFile(fsFilename);
      SetFileDate(fsFilename ,Qry.FieldByName('msTimeStamp').asDateTime);
    end;
   Result := True;
  finally
    if Assigned(Qry) and (QryHelpdoc = nil) then DbSharedObj.ReleaseObj(Qry);
  end;
end;
Function HelpdocDirectory:String;
begin
  result:= SystemLib.ExeDir + Helpdoc_SUBDIR;
end;
Function HelpdocfilenamewithPath(filename:string=''):String;
begin
 filename := ValidFileName(filename); // remove invalid chars
 ForceDirectories(GetAllUserDocumentsDir + HELPDOC_SUBDIR );
 result := GetAllUserDocumentsDir + HELPDOC_SUBDIR + filename;
end;

end.
