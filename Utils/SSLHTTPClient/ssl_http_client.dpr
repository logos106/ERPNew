library ssl_http_client;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  HttpObj in 'HttpObj.pas',
  JSONObject in '..\..\Common\JSONObject.pas',
  HTTPConst in '..\..\Common\HTTPConst.pas',
  LogMessageTypes in '..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  LogThreadBase in '..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  LogThreadLib in '..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  MultiEventObj in '..\..\Dev\General\Objects\CommonObjects\MultiEventObj.pas',
  ModuleFileNameUtils in '..\..\Common\ModuleFileNameUtils.pas';

{$R *.res}

  procedure AddSSLVersion(aVersion: PChar);
  begin
    THTTPSSL.Inst.AddSSLVersion(aVersion);
  end;

  procedure ClearSSLVersions;
  begin
    THTTPSSL.Inst.ClearSSLVersions;
  end;

  procedure SetAccept(Value: PChar);
  begin
    THTTPSSL.Inst.Accept := Value;
  end;

  function GetAccept: PChar;
  begin
    result := PChar(THTTPSSL.Inst.Accept);
  end;

  procedure SetContentType(Value: PChar);
  begin
    THTTPSSL.Inst.ContentType := Value;
  end;

  function GetContentType: PChar;
  begin
    result := PChar(THTTPSSL.Inst.ContentType);
  end;

  function GetCustomeHeader(aName: PChar): PChar;
  begin
    result := PChar(THTTPSSL.Inst.CustomHeaders[aName]);
  end;

  procedure SetCustomHeader(aName, aValue: PChar);
  begin
    THTTPSSL.Inst.CustomHeaders[aName] := aValue;
  end;

  procedure DeleteCustomHeader(aName: PChar);
  begin
    THTTPSSL.Inst.DeleteCustomHeader(aName);
  end;

  procedure AddFormField(aName, aValue: PChar);
  begin
    THTTPSSL.Inst.AddFormField(aName, aValue);
  end;

  procedure ClearFormData;
  begin
    THTTPSSL.Inst.ClearFormData;
  end;

  function Get(aURL: PChar): PChar;
  begin
    result := PChar(THTTPSSL.Inst.Get(aURL));
  end;

  function Post(aURL, Data: PChar): PChar;
  begin
    result := PChar(THTTPSSL.Inst.Post(aURL, Data));
  end;

  function PostFormData(aURL: PChar): PChar;
  begin
    result := PChar(THTTPSSL.Inst.PostFormData(aURL));
  end;

  procedure SetDebugMode(Value: boolean);
  begin
    THTTPSSL.Inst.DebugMode := Value;
  end;

  function GetDebugMode: boolean;
  begin
    result := THTTPSSL.Inst.DebugMode;
  end;

  procedure BasicAuthentication(aUserName, aPassword: PChar);
  begin
    THTTPSSL.Inst.BasicAuthentication(aUserNAme, aPAssword);
  end;

  function GetConnectTimeout: integer;
  begin
    result := THTTPSSL.Inst.ConnectTimeout;
  end;

  procedure SetConnectTimeout(const Value: integer);
  begin
    THTTPSSL.Inst.ConnectTimeout := Value;
  end;

  function GetReadTimeout: integer;
  begin
    result := THTTPSSL.Inst.ReadTimeout;
  end;

  procedure SetReadTimeout(const Value: integer);
  begin
    THTTPSSL.Inst.ReadTimeout := Value;
  end;

  function Delete(aURL: PChar): PChar;
  begin
    result := PChar(THTTPSSL.Inst.Delete(aURL));
  end;

  function PostFile(aURL, aFileName: PChar): PChar;
  begin
    result := PChar(THTTPSSL.Inst.PostFile(aURL, aFileName));
  end;

  procedure GetFile(aURL, aFileName: PChar);
  begin
    THTTPSSL.Inst.GetFile(aURL, aFileName);
  end;

  function GetLastError: PChar;
  begin
    result := PChar(THTTPSSL.Inst.LastError);
  end;


exports
  AddSSLVersion,
  ClearSSLVersions,
  SetAccept,
  GetAccept,
  SetContentType,
  GetContentType,
  GetCustomeHeader,
  SetCustomHeader,
  DeleteCustomHeader,
  AddFormField,
  ClearFormData,
  Get,
  Post,
  PostFormData,
  SetDebugMode,
  GetDebugMode,
  BasicAuthentication,
  GetConnectTimeout,
  SetConnectTimeout,
  GetReadTimeout,
  SetReadTimeout,
  Delete,
  PostFile,
  GetFile,
  GetLastError;

begin
end.
