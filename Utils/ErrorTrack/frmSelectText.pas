unit frmSelectText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmSelectText = class(TForm)
    pnlBottom: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    memSelect: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  function DoSelectString(var sql: string): boolean;

var
  fmSelectText: TfmSelectText;

implementation

{$R *.dfm}


function DoSelectString(var sql: string): boolean;
var form: TfmSelectText;
begin
  result:= false;
  form:= TfmSelectText.Create(nil);
  try
    form.memSelect.Lines.Text:= sql;
    if form.ShowModal = mrOk then begin
      sql:= form.memSelect.Lines.Text;
      result:= true;
    end;
  finally
    form.Free;
  end;
end;

end.
