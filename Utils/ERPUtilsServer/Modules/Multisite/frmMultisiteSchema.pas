unit frmMultisiteSchema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMultisiteSchema = class(TForm)
    memSchema: TMemo;
  private
    { Private declarations }
  public
    class function SchemaText: string;
  end;

var
  MultisiteSchema: TMultisiteSchema;

implementation

{$R *.dfm}

{ TMultisiteSchema }

class function TMultisiteSchema.SchemaText: string;
begin
  with TMultisiteSchema.Create(nil) do begin
    result:= memSchema.Text;
    Free;
  end;
end;

end.
