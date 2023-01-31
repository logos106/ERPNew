unit ModuleClientUtils;

interface

uses
  JsonObject,
  JsonRpcBase;


type
  TOnDataTransferProgress = procedure (percent: integer) of object;


  function JsonGetFile(moduleName, sourceFileName, DestFileName: string; Client: TJsonRpcBase;
                     ProgressProc: TOnDataTransferProgress; var msg: string): boolean;


implementation

uses
  SysUtils, Classes, idCoderMIME;

function JsonGetFile(moduleName, sourceFileName, DestFileName: string; Client: TJsonRpcBase;
                     ProgressProc: TOnDataTransferProgress; var msg: string): Boolean;
var
  x: integer;
  o, resp: TJsonObject;
  filesize: integer;
  filedate: TDateTime;
  chunkCount: integer;
  percent: integer;
  s: string;
  filestream: TFileStream;
  DecoderMIME: TIdDecoderMIME;
  chunkSize: integer;
begin
  chunkSize:= 30000; { must be multiple of 3 }
  s := '';
  msg := '';
  Result := False;

  try
    { first get the file info }
    o := TJsonObject.Create;
    o.S['filename'] := SourceFileName;
    resp := Client.SendRequest(moduleName + '.getfileinfo',O);
    try
      if Assigned(resp) then begin
        if resp.ObjectExists('error') then begin
          msg := 'Error while getting file info: ' + resp.O['error'].S['message'];
          Exit;
        end;
        filesize := resp.O['result'].I['filesize'];
        filedate := resp.O['result'].F['filedate'];
      end
      else begin
        msg := 'No response for request to get file info';
        Exit;
      end;
    finally
      resp.Free;
    end;

    { how many chunks }
    chunkCount := 1;
    if filesize > chunkSize then begin
      if filesize > (chunkSize * 200) then begin
        chunkSize := (filesize div 200);
        while Frac(chunksize/3) <> 0 do
          chunksize := chunksize - 1;
      end
      else if filesize > (chunkSize * 100) then begin
        chunkSize := (filesize div 100);
        while Frac(chunksize/3) <> 0 do
          chunksize := chunksize - 1;
      end;
      chunkCount:= Trunc(filesize / chunkSize) + 1;
    end;

    { main loop }
    filestream := TFileStream.Create(DestFileName, fmCreate);
    DecoderMIME := TIdDecoderMIME.Create(nil);
    try
      for x := 0 to chunkCount - 1 do begin
        Sleep(5);
        o := TJsonObject.Create;
        o.S['filename'] := SourceFileName;
        o.F['filedate'] := filedate;
        o.I['filesize'] := filesize;
        if x = 0 then
          o.I['position'] := 0
        else
          o.I['position'] := (x * chunkSize); // + 1;
        if x = chunkCount - 1 then
          o.I['count'] := 0 { last chunk }
        else
          o.I['count'] := chunkSize;
        resp := Client.SendRequest(moduleName + '.getfilepart', O);
        try
          if Assigned(resp) then begin
            if resp.ObjectExists('error') then begin
              msg:= 'Error while getting file with message: ' + resp.O['error'].S['message'];
              break;
            end;
            s := resp.O['result'].S['filepartstring'];
            DecoderMIME.DecodeBegin(filestream);
            try
              DecoderMIME.Decode(s);
            finally
              DecoderMIME.DecodeEnd;
            end;
            percent := Round((filestream.size / filesize) * 100);
            if Assigned(ProgressProc) then begin
              if percent > 100 then
                percent := 100;
              ProgressProc(percent);
            end;
          end
          else begin
            msg := 'No response for request to get file';
            Break;
          end;
        finally
          resp.Free;
        end;
      end;
      if filestream.Size >= filesize then
        Result := True;
    finally
      filestream.Free;
      DecoderMIME.Free;
    end;
  except
    on e: exception do begin
      msg:= 'Failed to get file with message: ' + e.Message;
    end;
  end;
end;



end.
