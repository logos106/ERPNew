{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Extension_Base;

interface

uses
  Classes;

type
  TsgcWSExtension_Base = class(TPersistent)
  private
    FEnabled: Boolean;
  public
    procedure Assign(aSource: TPersistent); override;
  public
    procedure DecodeHeader(aByte: Byte); virtual; abstract;
    procedure EncodeHeader(var aByte: Byte); virtual; abstract;
  public
    function GetName: string; virtual; abstract;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
  end;

implementation

procedure TsgcWSExtension_Base.Assign(aSource: TPersistent);
begin
  if aSource.InheritsFrom(TsgcWSExtension_Base) then
    Enabled := TsgcWSExtension_Base(aSource).Enabled
  else
    inherited Assign(aSource);
end;

end.
