unit frmDU_ProcResource;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDU_base, StdCtrls, Menus, ExtCtrls, Shader, DNMPanel;

type
  TfmDU_ProcResource = class(TfmDU_base)
    pnlMakePrimaryContacts: TDNMPanel;
    chkupdateHourlyRate: TCheckBox;
    edtHourlyRate: TEdit;
    pnlUOM: TLabel;
    chkMakeRate0: TCheckBox;
    procedure chkMakeRate0Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkupdateHourlyRateClick(Sender: TObject);
  private
    fbchoosingRateUpdate :boolean;
    function getHourlyRate: double;
    procedure setHourlyRate(const Value: double);
  Protected
    Class function MakeInstance(AOwner:TComponent): TfmDU_base;overload; override;
  public
    Class Function  MakeInstance(AOwner:TComponent; ParentPanel:TDNMPanel) :TfmDU_base ;overload;Override;
    Property HourlyRate : double read getHourlyRate write setHourlyRate;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TfmDU_ProcResource }

procedure TfmDU_ProcResource.chkMakeRate0Click(Sender: TObject);
begin
  inherited;
  if fbchoosingRateUpdate then exit;

  fbchoosingRateUpdate := True;
  try
    chkupdateHourlyRate.checked := not(chkMakeRate0.checked);
  finally
    fbchoosingRateUpdate := false;
  end;
end;

procedure TfmDU_ProcResource.chkupdateHourlyRateClick(Sender: TObject);
begin
  inherited;
  if fbchoosingRateUpdate then exit;

  fbchoosingRateUpdate := True;
  try
    chkMakeRate0.checked := not(chkupdateHourlyRate.checked);
    if chkupdateHourlyRate.checked then Setcontrolfocus(edtHourlyRate);

  finally
    fbchoosingRateUpdate := false;
  end;

end;

Procedure TfmDU_ProcResource.FormCreate(Sender: TObject);
begin
  inherited;
  fbchoosingRateUpdate := False;
end;

function TfmDU_ProcResource.getHourlyRate: double;
begin
  try
    Result := strtofloat(edtHourlyRate.text);
  Except
    on E:Exception do begin
      Result := 0;
    end;
  end;

end;

class function TfmDU_ProcResource.MakeInstance(AOwner: TComponent): TfmDU_base;
begin
  Result:= TfmDU_ProcResource.create(AOwner);
  inherited;
end;

class function TfmDU_ProcResource.MakeInstance(AOwner: TComponent;ParentPanel: TDNMPanel): TfmDU_base;
begin
  result:= inherited MakeInstance(AOwner,ParentPanel);
end;

procedure TfmDU_ProcResource.setHourlyRate(const Value: double);
begin
  edtHourlyRate.text := Floattostrf(Value , ffGeneral, 15,2)
end;

end.
