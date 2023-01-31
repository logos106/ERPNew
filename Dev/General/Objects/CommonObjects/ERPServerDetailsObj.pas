unit ERPServerDetailsObj;

interface

uses
  JsonObject;


function ERPServerDetails: TJSONObject;

implementation

uses
  SysUtils, ModuleFileNameUtils, FileDownloadFuncs, UpdaterConst, JSONToObject;

var
  fERPServerDetails: TJSONObject;

function ERPServerDetails: TJSONObject;
var
  ModPath: string;
begin
  if not Assigned(fERPServerDetails) then
    fERPServerDetails := JO;
  if fERPServerDetails.Count = 0 then begin
    ModPath := ModuleFileNameUtils.GetCurrentModulePath;
    try
      TFileDownloader.DownloadFile(WebUpdatesURL + ERPServerDetailsFile,
        ModPath + ERPServerDetailsFile, frReplaceIfNewer,false);
    except
      { hide exceptions }
    end;
    { if file exists from this or previous download decrypt and load into json }
    if FileExists(ModPath + ERPServerDetailsFile) then
      EncryptedFileToJson(fERPServerDetails, ModPath + ERPServerDetailsFile);
  end;
  result := fERPServerDetails;
end;

initialization

finalization

end.

