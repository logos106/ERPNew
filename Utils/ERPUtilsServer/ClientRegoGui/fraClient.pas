unit fraClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraTreeFrameBase, StdCtrls, JsonObject, ExtCtrls;

type
  TfrClient = class(TfrTreeFrameBase)
    edtName: TEdit;
    cboReleaseType: TComboBox;
    Label1: TLabel;
    chkActive: TCheckBox;
    lblID: TLabel;
  private
  protected
    procedure SetData(const Value: TJsonObject); override;
  public
    { Public declarations }
  end;

var
  frClient: TfrClient;

implementation

{$R *.dfm}

{ TfrClient }

procedure TfrClient.SetData(const Value: TJsonObject);
begin
  inherited;
  Bindings.AddBinding('name',valString,edtName);
  Bindings.AddBinding('softwarereleasetype',valString,cboReleaseType);
  Bindings.AddBinding('active',valBoolean,chkActive);
  Bindings.AddBinding('id',valNumber,lblID);
end;

end.
