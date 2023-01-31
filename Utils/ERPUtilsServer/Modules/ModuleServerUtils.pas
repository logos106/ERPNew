unit ModuleServerUtils;

interface

uses
  JsonObject;

  procedure JsonDoGetFileInfo(RequestJson, ResultJson: TJsonObject);
  procedure JsonDoGetFilePart(RequestJson, ResultJson: TJsonObject);


implementation

uses
  SysUtils, IdGlobalProtocols, Classes, idCoderMIME, Math;

procedure JsonDoGetFileInfo(RequestJson, ResultJson: TJsonObject);
var
  filename: string;
  fileDate: TDateTime;
begin
  filename:= RequestJson.O['params'].S['filename'];
  if FileExists(fileName) then begin
    ResultJson.O['result'].S['filename']:= filename;
    FileAge(filename,fileDate);
    ResultJson.O['result'].F['filedate']:= fileDate;
    ResultJson.O['result'].I['filesize']:= FileSizeByName(filename);
  end
  else begin
    ResultJson.O['error'].I['code']:= -1;
    ResultJson.O['error'].S['message']:= 'File not found: "' + filename + '"';
  end;
end;

procedure JsonDoGetFilePart(RequestJson, ResultJson: TJsonObject);
var
  filename: string;
  fileStream: TFileStream;
  MIMEEncoder: TIdEncoderMIME;
  s: string;
  count: integer;
  fileDate, requestFileDate: TDateTime;
  fileSize, requestFileSize: integer;

begin
  s:= '';
  try
    filename:= RequestJson.O['params'].S['filename'];
    if FileExists(fileName) then begin
      FileAge(filename,filedate);
      filesize:= FileSizeByName(filename);
      requestFileDate:= RequestJson.O['params'].F['filedate'];
      requestFileSize:= RequestJson.O['params'].I['filesize'];
      if (filesize <> requestFileSize) or (not SameValue(filedate,requestFileDate,0.00001)) then begin
        ResultJson.O['error'].I['code']:= -1;
        ResultJson.O['error'].S['message']:= 'File has changed';
        exit;
      end;
      fileStream:= TFileStream.Create(filename,fmOpenRead);
      MIMEEncoder:= TIdEncoderMIME.Create(nil);
      try
        fileStream.Position:= RequestJson.O['params'].I['position'];
        count:= RequestJson.O['params'].I['count'];
        if (count = 0) or (count > (filestream.Size - fileStream.Position)) then begin
          count:= (filestream.Size - fileStream.Position);
          while Frac(count/3) <> 0 do
            Inc(Count);
        end;
        s:= MIMEEncoder.Encode(fileStream,count);
      finally
        MIMEEncoder.Free;
        fileStream.Free;
      end;
      ResultJson.O['result'].S['filepartstring']:= s;
    end
    else begin
      ResultJson.O['error'].I['code']:= -1;
      ResultJson.O['error'].S['message']:= 'File not found';
    end;
  except
    on e: exception do begin
      ResultJson.O['error'].I['code']:= -1;
      ResultJson.O['error'].S['message']:= 'Error during DoGetFilePart with message: '+ e.Message;
    end;
  end;
end;

end.
