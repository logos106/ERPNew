unit DialogsEX;

interface

implementation

uses
  TaskDialogEx;


function InputDateTimeQuery(const ACaption, APrompt: string;
  var Value: TDateTime): Boolean;
var
  dlg: TAdvTaskDialogEx;
begin
  dlg := TAdvTaskDialogEx.Create(nil);
  try
    dlg.Title := ACaption;
    dlg.Content := APrompt;
    dlg.Options

  finally
    dlg.Free;
  end;


end;


end.
