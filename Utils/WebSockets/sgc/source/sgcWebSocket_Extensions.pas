{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}


unit sgcWebSocket_Extensions;

interface

uses
  Classes, SysUtils, Contnrs, StrUtils,
  sgcWebSocket_Extension_DeflateFrame;

type


  TsgcWSExtensions = class(TPersistent)
  private
    FExtensionNegotiated: Boolean;
  private
    FDeflateFrame: TsgcWSExtension_DeflateFrame;
  private
    FList: TStringList;
    function GetList: TStringList;
  public
    procedure Assign(aSource: TPersistent); override;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    procedure DecodeHeader(aByte: Byte);
    procedure EncodeHeader(var aByte: Byte);
  public
    procedure DecodeExtensions(const aExtensions: String);
  public
    procedure WriteHeader(aHeader: TStringList);
  public
    procedure ReadStream(var aStream: TStream);
    procedure WriteStream(var aStream: TStream);
  public
    property List: TStringList read GetList;
  public
    property ExtensionNegotiated: Boolean read FExtensionNegotiated;
  published
    property DeflateFrame: TsgcWSExtension_DeflateFrame read FDeflateFrame write
        FDeflateFrame;
  end;


implementation

uses sgcWebSocket_Classes, sgcWebSocket_Helpers, sgcWebSocket_Const;


constructor TsgcWSExtensions.Create;
begin
  FDeflateFrame := TsgcWSExtension_DeflateFrame.Create;
  FDeflateFrame.Enabled := False;
end;

destructor TsgcWSExtensions.Destroy;
begin
  FreeAndNil(FList);
  FreeAndNil(FDeflateFrame);
  inherited;
end;

procedure TsgcWSExtensions.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSExtensions then
  begin
    FDeflateFrame.Assign(TsgcWSExtensions(aSource).DeflateFrame);
  end
  else
    inherited Assign(aSource);
end;

procedure TsgcWSExtensions.DecodeExtensions(const aExtensions: String);
begin
  if DeflateFrame.Enabled then
    DeflateFrame.Enabled := sgcContainsText(aExtensions, DeflateFrame.GetName);
  FExtensionNegotiated := DeflateFrame.Enabled;
end;

procedure TsgcWSExtensions.DecodeHeader(aByte: Byte);
begin
  if DeflateFrame.Enabled then
    DeflateFrame.DecodeHeader(aByte);
end;

procedure TsgcWSExtensions.EncodeHeader(var aByte: Byte);
begin
  if DeflateFrame.Enabled then
    DeflateFrame.EncodeHeader(aByte);
end;

function TsgcWSExtensions.GetList: TStringList;
begin
  if not Assigned(FList) then
    FList := TStringList.Create;
  FList.Clear;
  if DeflateFrame.Enabled then
    FList.Add('x-webkit-deflate-frame');
  Result := FList;
end;

procedure TsgcWSExtensions.ReadStream(var aStream: TStream);
begin
  // ... deflate frame
  if DeflateFrame.Enabled then
  begin
    if DeflateFrame.MessageCompressed then
    begin
      if not DeflateFrame.DeflateFrame(aStream) then
        raise TsgcWSException.Create(S_ERROR_DEFLATING_FRAME);
    end;
  end;
end;

procedure TsgcWSExtensions.WriteHeader(aHeader: TStringList);
begin
  if DeflateFrame.Enabled then
    aHeader.Add('Sec-WebSocket-Extensions: x-webkit-deflate-frame');
end;

procedure TsgcWSExtensions.WriteStream(var aStream: TStream);
begin
  // ... inflate frame
  if DeflateFrame.Enabled then
  begin
    if not DeflateFrame.InflateFrame(aStream) then
      raise TsgcWSException.Create(S_ERROR_INFLATING_FRAME);
  end;

end;


end.
