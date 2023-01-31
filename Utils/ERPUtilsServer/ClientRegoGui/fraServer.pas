unit fraServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraTreeFrameBase, JsonObject, StdCtrls, ExtCtrls;

type
  TfrServer = class(TfrTreeFrameBase)
    edtName: TEdit;
    lblID: TLabel;
    chkActive: TCheckBox;
    Label1: TLabel;
    edtNotes: TEdit;
  private
  protected
    procedure SetData(const Value: TJsonObject); override;
  public
  end;

var
  frServer: TfrServer;

implementation

{$R *.dfm}

{ TfrServer }

procedure TfrServer.SetData(const Value: TJsonObject);
begin
  inherited;
  Bindings.AddBinding('computername',valString,edtName);
  Bindings.AddBinding('notes',valString,edtNotes);
  Bindings.AddBinding('active',valBoolean,chkActive);
  Bindings.AddBinding('id',valNumber,lblID);
end;

end.
