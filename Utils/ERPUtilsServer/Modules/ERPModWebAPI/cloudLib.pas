unit cloudLib;

interface

Uses JsonObject, classes;

Function DoHTTPGET(aURL:String;adbname,aUser,aPassword:String;var JsResultStr:String; initREquest :TNotifyEvent = nil):Boolean;
Function DoHTTPPost(aURL:String;adbname,aUser,aPassword:String;jsInput:TjsonObject; var JsResultStr:String; initREquest :TNotifyEvent = nil):Integer;

implementation

uses IdHTTP, IdSSLOpenSSL, HTTPConst,systemlib, sysutils, WebApiConst,
  utCloudconst;


Function DoHTTPGET(aURL:String;adbname,aUser,aPassword:String;var JsResultStr:String; initREquest :TNotifyEvent = nil):Boolean;
var
  Client: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  InStream: TFileStream;
  TempFileName: string;
  js:TjsonObject;
begin
  JsResultStr := '';
  Result := False;
    js:= jo;
    try
      js.S['aURL'] :=aURL;
      js.S['adbname'] :=adbname;
      js.S['aUser'] :=aUser;
      js.S['aPassword'] :=aPassword;
      Client:= TIdHTTP.Create(nil);
      try
        Client.Request.UserAgent := HTTPConst.TrueERPUserAgent;

        if Pos('HTTPS', Uppercase(aURL)) = 1 then begin
            SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(client);
            client.IOHandler:= SSLHandler;
            client.Request.BasicAuthentication:= true;
            Client.Request.Username:= aUser;
            Client.Request.Password:= aPassword;
        end else begin
            Client.Request.CustomHeaders.AddValue('username', aUser);
            Client.Request.CustomHeaders.AddValue('password', aPassword);
        end;
        Client.ReadTimeout := HTTP_READTIMEOUT ;//(1000 * 60 * 10);
        Client.Request.CustomHeaders.AddValue('database', adbName);
        if Assigned(initREquest) then initREquest(Client);
        TempFileName := SystemLib.GetTempFileName('','.json',true);
          try
            InStream := TFileStream.Create(TempFileName, fmOpenReadWrite);
            try
              Client.Get(aURL,InStream);
            finally
              try InStream.Free; Except end;
            end;
            js.LoadFromFile(TempFileName);
            sysutils.DeleteFile(TempFileName);
            JsResultStr := js.AsString;
            Result := True;
          Except
               on E:Exception do begin
                //MessageDlgXP_Vista(e.message, mtWarning, [mbOK], 0);
                js.O['ResPonse']:= JO;
                js.O['ResPonse'].S[TAG_Method]:= 'DoHTTPGET';
                js.O['ResPonse'].S['Status']:= 'Failed';
                js.O['ResPonse'].O[TAG_ResponseError]:= jo;
                js.O['ResPonse'].O[TAG_ResponseError].I['Code']:= Client.Response.ResponseCode;
                js.O['ResPonse'].O[TAG_ResponseError].S['Message']:=E.message;
                JsResultStr :=js.asString;
               end;
          end;
      finally
        Client.Free;
      end;
    finally
      js.free;
    end;
end;

Function DoHTTPPost(aURL:String; adbname, aUser, aPassword: String; jsInput: TjsonObject; var JsResultStr: String; InitRequest: TNotifyEvent = nil): Integer;
var
  Client: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  stream: TMemoryStream;
  js:TJsonObject;
begin
  js := jo;
  try
      JsResultStr := '';
      Result := 0;
      Client := TIdHTTP.Create(nil);
      try
        Client.Request.UserAgent := HTTPConst.TrueERPUserAgent;

        if Pos('HTTPS', Uppercase(aURL)) = 1 then begin
            SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(Client);
            Client.IOHandler := SSLHandler;
            Client.Request.BasicAuthentication := True;
            Client.Request.Username:= aUser;
            Client.Request.Password:= aPassword;
        end else begin
            Client.Request.CustomHeaders.AddValue('username', aUser);
            Client.Request.CustomHeaders.AddValue('password', aPassword);
        end;
        Client.ReadTimeout := HTTP_READTIMEOUT ;//(1000 * 60 * 10);
        Client.Request.CustomHeaders.AddValue('database', adbName);

        if Assigned(InitRequest) then InitRequest(Client);

        stream := TMemoryStream.Create;
        try
          jsInput.SaveToStream(stream);
          try
            JsResultStr := Client.Post(aURL, stream);
          Except
            on E:Exception do begin
              js.O['ResPonse'] := JO;
              js.O['ResPonse'].S[TAG_Method] := 'DoHTTPPost';
              js.O['ResPonse'].S['Status'] := 'Failed ';
              js.O['ResPonse'].O[TAG_ResponseError] := JO;
              js.O['ResPonse'].O[TAG_ResponseError].I['Code'] := Client.Response.ResponseCode;
              js.O['ResPonse'].O[TAG_ResponseError].S['Message'] := E.message;
              JsResultStr := js.AsString;
            end;
          end;
           Result := Client.Response.ResponseCode;
        finally
          stream.Free;
        end;
      finally
        Client.Free;
      end;
  finally
    Js.Free;
  end;
end;


end.
