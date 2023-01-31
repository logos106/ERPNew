unit Lib_HttpUtils;

interface

  function HttpGetFile(const aURL: string; var aDestFile, msg: string; const DecryptFile: boolean): boolean;

exports
  HttpGetFile;

implementation

uses
  SysUtils, IdHttp, HttpConst, Classes, SystemLib;


function HttpGetFile(const aURL: string; var aDestFile, msg: string; const DecryptFile: boolean): boolean;
var
  http: TIdHttp;
  getStream: TFileStream;
begin
  result := true;
  try
    if aDestFile = '' then begin
      aDestFile := ExtractFileName(aURL);
      aDestFile := WinTempDir + aDestFile;
    end;
    getStream := TFileStream.Create(aDestFile,fmCreate);
    try
      http := TIdHttp.Create(nil);
      try
        http.Request.UserAgent := HTTPConst.TrueERPUserAgent;
        http.Get(aURL,getStream);
        { todo - decrypt }
      finally
        http.Free;
      end;
    finally
      getStream.Free;
    end;
  except
    on e: exception do begin
      result := false;
      msg := e.Message;
    end;

  end;
end;

end.
