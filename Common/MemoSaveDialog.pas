unit MemoSaveDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmMemoDialog = class(TForm)
    Panel1: TPanel;
    btnSave: TButton;
    btnClose: TButton;
    memData: TMemo;
    SaveDialog: TSaveDialog;
    btnOk: TButton;
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function ShowDialog(var data: string; const aCaption: string = ''; ReadOnly: boolean = false): boolean;

implementation

{$R *.dfm}

function ShowDialog(var data: string; const aCaption: string = ''; ReadOnly: boolean = false): boolean;
var
  form: TfmMemoDialog;
begin
  result:= false;
  form := TfmMemoDialog.Create(Application);
  try
    form.memData.Lines.Text := data;
    if aCaption <> '' then
      form.Caption := aCaption;
    if ReadOnly then
      form.memData.ReadOnly := true;
    if form.ShowModal = mrOk then begin
      if not ReadOnly then
        data := form.memData.Lines.Text;
      result := true;
    end;
  finally
    form.Free;
  end;
end;


procedure TfmMemoDialog.btnSaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then begin
    memData.Lines.SaveToFile(SaveDialog.FileName);
  end;
end;

end.
