unit fraServerConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraTreeFrameBase, ExtCtrls, JSONObject, StdCtrls;

type
  TfrServerConfig = class(TfrTreeFrameBase)
    edtText: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtNotes: TEdit;
    procedure edtTextDblClick(Sender: TObject);
  private
  protected
    procedure SetData(const Value: TJsonObject); override;
  public
  end;

var
  frServerConfig: TfrServerConfig;

implementation

uses
  MemoSaveDialog, JsonObjectUtils;

{$R *.dfm}

{ TfrServerConfig }

procedure TfrServerConfig.edtTextDblClick(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := JsonToStrFormat(TEdit(sender).Text);
  ShowDialog(s,'Config',true);
end;

procedure TfrServerConfig.SetData(const Value: TJsonObject);
begin  inherited;
  Bindings.AddBinding('text',valString,edtText);
  Bindings.AddBinding('notes',valString,edtNotes);
end;

end.
