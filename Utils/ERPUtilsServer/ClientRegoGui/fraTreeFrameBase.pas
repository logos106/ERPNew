unit fraTreeFrameBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JsonObject, JSONBinding, ExtCtrls;

type

  TfrTreeFrameBaseClass = class of TfrTreeFrameBase;
  TfrTreeFrameBase = class(TFrame)
    Bevel1: TBevel;
  private
    fData: TJsonObject;
    fTreeNode: TObject;
  protected
    procedure DoBindingsOnChange(Sender: TObject);
    procedure SetData(const Value: TJsonObject); virtual;
  public
    Bindings: TJSONBindings;
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Data: TJsonObject read fData write SetData;
    property TreeNode: TObject read fTreeNode write fTreeNode;
  end;

implementation

{$R *.dfm}

{ TFrameBase }

constructor TfrTreeFrameBase.Create(aOwner: TComponent);
begin
  inherited;
  Bindings := TJSONBindings.Create(nil);
  Bindings.OnChange := DoBindingsOnChange;
end;

destructor TfrTreeFrameBase.Destroy;
begin
  Bindings.Free;
  inherited;
end;

procedure TfrTreeFrameBase.DoBindingsOnChange(Sender: TObject);
begin
  if Assigned(Data) and Data.StringExists('user') then
    Data.S['user'] := 'ERP';
  Data.B['_dirty'] := true;
end;

procedure TfrTreeFrameBase.SetData(const Value: TJsonObject);
begin
  fData := Value;
  Bindings.JSONObject := Data;
end;

end.
