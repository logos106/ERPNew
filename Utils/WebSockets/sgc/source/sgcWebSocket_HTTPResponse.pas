{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}


unit sgcWebSocket_HTTPResponse;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils, Contnrs;

type
  TsgcWSHTTPResponse_Base = class;
  TsgcWSHTTPResponse_BaseClass = class of TsgcWSHTTPResponse_Base;

  TsgcWSHTTPResponse_Base = class(TObject)
  private
  protected
    function GetResponse: string; virtual; abstract;
  public
    class function GetFileName: string; virtual; abstract;
  public
  end;

{$IFDEF D2006}
  TsgcWSHTTPResponse = class(TObject)
  private
    class var FServiceClassList: TClassList;
  protected
    function GetFileNameClass(const aServiceName: string):
        TsgcWSHTTPResponse_BaseClass;
  public
    class procedure RegisterFileName(aClass: TsgcWSHTTPResponse_BaseClass);
  public
    function GetResponseMessage(const aFileName: String): string;
  end;

{$ELSE}
  TsgcWSHTTPResponseObject = class(TObject)
  private
    FServiceClassList: TClassList;
  protected
    function GetFileNameClass(const aServiceName: string):
        TsgcWSHTTPResponse_BaseClass;
  public
    procedure RegisterFileName(aClass: TsgcWSHTTPResponse_BaseClass);
  public
    function GetResponseMessage(const aFileName: String): string;
  end;

var
  TsgcWSHTTPResponse: TsgcWSHTTPResponseObject = nil;
{$ENDIF}

implementation

{ TsgcWSHTTPResponse }

{$IFDEF D2006}
function TsgcWSHTTPResponse.GetResponseMessage(const aFileName: String):
    string;
var
  oClass: TsgcWSHTTPResponse_BaseClass;
  oInstance: TsgcWSHTTPResponse_Base;
begin
  Result := '';
  oClass := GetFileNameClass(aFileName);
  if Assigned(oClass) then
  begin
    oInstance := nil;
    try
      oInstance := oClass.Create;
      Result := oInstance.GetResponse;
    finally
      oInstance.Free;
    end;
  end;
end;

function TsgcWSHTTPResponse.GetFileNameClass(const aServiceName: string):
    TsgcWSHTTPResponse_BaseClass;
var
  vCount: integer;
  oService: TsgcWSHTTPResponse_BaseClass;
begin
  Result := nil;
  for vCount := 0 to FServiceClassList.Count - 1 do
  begin
    oService := TsgcWSHTTPResponse_BaseClass(FServiceClassList[vCount]);
    if SameText(oService.GetFileName, aServiceName) then
    begin
      Result := oService;
      Exit;
    end;
  end;
end;

class procedure TsgcWSHTTPResponse.RegisterFileName(aClass:
    TsgcWSHTTPResponse_BaseClass);
begin
  FServiceClassList.Add(aClass);
end;

{$ELSE}

function TsgcWSHTTPResponseObject.GetResponseMessage(const aFileName: String):
    string;
var
  oClass: TsgcWSHTTPResponse_BaseClass;
  oInstance: TsgcWSHTTPResponse_Base;
begin
  Result := '';
  oClass := GetFileNameClass(aFileName);
  if Assigned(oClass) then
  begin
    oInstance := nil;
    try
      oInstance := oClass.Create;
      Result := oInstance.GetResponse;
    finally
      oInstance.Free;
    end;
  end;
end;

function TsgcWSHTTPResponseObject.GetFileNameClass(const aServiceName: string):
    TsgcWSHTTPResponse_BaseClass;
var
  vCount: integer;
  oService: TsgcWSHTTPResponse_BaseClass;
begin
  Result := nil;
  for vCount := 0 to FServiceClassList.Count - 1 do
  begin
    oService := TsgcWSHTTPResponse_BaseClass(FServiceClassList[vCount]);
    if SameText(oService.GetFileName, aServiceName) then
    begin
      Result := oService;
      Exit;
    end;
  end;
end;

procedure TsgcWSHTTPResponseObject.RegisterFileName(aClass:
    TsgcWSHTTPResponse_BaseClass);
begin
  FServiceClassList.Add(aClass);
end;

{$ENDIF}

{$IFDEF D2006}
initialization
  TsgcWSHTTPResponse.FServiceClassList := TClassList.Create;

finalization
  FreeAndNil(TsgcWSHTTPResponse.FServiceClassList);

{$ELSE}
initialization
  TsgcWSHTTPResponse := TsgcWSHTTPResponseObject.Create;
  TsgcWSHTTPResponse.FServiceClassList := TClassList.Create;

finalization
  FreeAndNil(TsgcWSHTTPResponse.FServiceClassList);
  FreeAndNil(TsgcWSHTTPResponse);
{$ENDIF}

end.
