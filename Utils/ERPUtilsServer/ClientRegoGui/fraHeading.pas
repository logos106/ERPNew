unit fraHeading;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraTreeFrameBase, StdCtrls, JsonObject, ExtCtrls;

type
  TfrHeading = class(TfrTreeFrameBase)
    lblName: TLabel;
  private
  protected
    procedure SetData(const Value: TJsonObject); override;
  public
  end;

var
  frHeading: TfrHeading;

implementation

{$R *.dfm}

{ TfrHeading }

procedure TfrHeading.SetData(const Value: TJsonObject);
begin
  inherited;
  Bindings.AddBinding('name',valString,lblName);
end;

end.
