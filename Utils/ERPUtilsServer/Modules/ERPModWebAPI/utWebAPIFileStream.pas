unit utWebAPIFileStream;

interface

uses
  Classes;

type
  TWebAPIFileStream = class(TFileStream)
  public
    destructor Destroy; override;
  end;

implementation

uses
  SysUtils;

{ TWebAPIFileStream }

destructor TWebAPIFileStream.Destroy;
var
  aFileName: string;
begin
  aFileName := self.FileName;
  inherited;
  try
    DeleteFile(aFileName);
  except
  end;
end;

end.
