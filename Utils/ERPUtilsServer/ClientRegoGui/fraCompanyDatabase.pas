unit fraCompanyDatabase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraTreeFrameBase, ExtCtrls, StdCtrls, JsonObject;

type
  TfrCompanyDatabase = class(TfrTreeFrameBase)
    Label1: TLabel;
    lblVersion: TLabel;
    Label2: TLabel;
    lblCompanyName: TLabel;
    Label4: TLabel;
    lblContact: TLabel;
    Label3: TLabel;
    lblAddress: TLabel;
    Label5: TLabel;
    lblPostalAddress: TLabel;
  private
  protected
    procedure SetData(const Value: TJsonObject); override;
  public
  end;

var
  frCompanyDatabase: TfrCompanyDatabase;

implementation

{$R *.dfm}

{ TfrCompanyDatabase }

procedure TfrCompanyDatabase.SetData(const Value: TJsonObject);
begin
  inherited;
  Bindings.AddBinding('version',valString,lblVersion);
  Bindings.AddBinding('companyname',valString,lblCompanyName);
  Bindings.AddBinding('address',valString,lblAddress);
  Bindings.AddBinding('postaladdress',valString,lblPostalAddress);
  Bindings.AddBinding('contact',valString,lblContact);

end;

end.
