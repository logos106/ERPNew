unit frmchooseDays;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, DNMSpeedButton, ExtCtrls, DNMPanel, StdCtrls, CheckLst,
  Menus, ActnList, DNMAction, Shader;


type
  TIntArray = Array of integer;

  TfmchooseDays = class(TfrmBaseGUI)
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    chkSunday: TCheckBox;
    chkSaturday: TCheckBox;
    chkFriday: TCheckBox;
    chkthursday: TCheckBox;
    chkWednesday: TCheckBox;
    chktuesday: TCheckBox;
    chkMonday: TCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Shp: TShape;
    procedure FormCreate(Sender: TObject);
  private
    function getSunday    : Boolean;
    function getMonday    : Boolean;
    function getTuesday   : Boolean;
    function getWednesday : Boolean;
    function getThursday  : Boolean;
    function getFriday    : Boolean;
    function getSaturday  : Boolean;

    procedure setSunday   (const Value: Boolean);
    procedure setMonday   (const Value: Boolean);
    procedure setTuesday  (const Value: Boolean);
    procedure setWednesday(const Value: Boolean);
    procedure setThursday (const Value: Boolean);
    procedure setFriday   (const Value: Boolean);
    procedure setSaturday (const Value: Boolean);

    Procedure Disabledays(Days:TIntArray);
  public
    Property IsSunday     :Boolean Read getSunday     Write setSunday ;
    Property IsMonday     :Boolean Read getMonday     Write setMonday ;
    Property IsTuesday    :Boolean Read getTuesday    Write setTuesday ;
    Property IsWednesday  :Boolean Read getWednesday  Write setWednesday ;
    Property IsThursday   :Boolean Read getThursday   Write setThursday ;
    Property IsFriday     :Boolean Read getFriday     Write setFriday ;
    Property IsSaturday   :Boolean Read getSaturday   Write setSaturday ;

  end;

Procedure Choosedays(var Days:TIntArray; AOwner:TComponent);
implementation

{$R *.dfm}

Procedure Choosedays(var Days:TIntArray; AOwner:TComponent);
var
  chooseDays : TfmchooseDays;
//  ctr:Integer;
  //Days:Array of integer  ;
begin
  chooseDays := TfmchooseDays.Create(AOwner);
  try
    chooseDays.Disabledays(days);
    SetLength(Days,0);
    if chooseDays.Showmodal = mrOk then begin
      if chooseDays.IsSunday    then begin setLength(Days, length(Days)+1); Days[High(Days)] := 1; end;
      if chooseDays.IsMonday    then begin setLength(Days, length(Days)+1); Days[High(Days)] := 2; end;
      if chooseDays.IsTuesday   then begin setLength(Days, length(Days)+1); Days[High(Days)] := 3; end;
      if chooseDays.IsWednesday then begin setLength(Days, length(Days)+1); Days[High(Days)] := 4; end;
      if chooseDays.Isthursday  then begin setLength(Days, length(Days)+1); Days[High(Days)] := 5; end;
      if chooseDays.IsFriday    then begin setLength(Days, length(Days)+1); Days[High(Days)] := 6; end;
      if chooseDays.IsSaturday  then begin setLength(Days, length(Days)+1); Days[High(Days)] := 7; end;
    end;

  finally
    Freeandnil(chooseDays);
  end;
end;

{ TfrmBaseGUI1 }

procedure TfmchooseDays.Disabledays(Days: TIntArray);
var
  ctr:Integer;
begin
  for ctr:= low(Days) to high(Days) do begin
      if Days[ctr] =1 then chkSunday.Enabled   := False ;
      if Days[ctr] =2 then chkMonday.Enabled   := False ;
      if Days[ctr] =3 then chkTuesday.Enabled  := False ;
      if Days[ctr] =4 then chkWednesday.Enabled:= False ;
      if Days[ctr] =5 then chkthursday.Enabled := False ;
      if Days[ctr] =6 then chkFriday.Enabled   := False ;
      if Days[ctr] =7 then chkSaturday.Enabled := False ;
    end;
end;

procedure TfmchooseDays.FormCreate(Sender: TObject);
begin
  inherited;
  if Assigned(Owner) then
    if owner is TForm then
      Self.color := Tform(Owner).color;
  Shp.Left := 0;
  Shp.top := 0;
  Shp.width := self.width;
  Shp.Height := Self.height-0
end;

function TfmchooseDays.getSunday   : Boolean; begin result := chksunday.checked    ; End;
function TfmchooseDays.getMonday   : Boolean; begin result := chkMonday.checked    ; End;
function TfmchooseDays.getTuesday  : Boolean; begin result := chkTuesday.checked   ; End;
function TfmchooseDays.getWednesday: Boolean; begin result := chkWednesday.checked ; End;
function TfmchooseDays.getThursday : Boolean; begin result := chkThursday.checked  ; End;
function TfmchooseDays.getFriday   : Boolean; begin result := chkFriday.checked    ; End;
function TfmchooseDays.getSaturday : Boolean; begin result := chksaturday.checked  ; End;
procedure TfmchooseDays.setSunday    (const Value: Boolean);begin chksunday.checked    := Value;end;
procedure TfmchooseDays.setMonday    (const Value: Boolean);begin chkMonday.checked    := Value;end;
procedure TfmchooseDays.setTuesday   (const Value: Boolean);begin chkTuesday.checked   := Value;end;
procedure TfmchooseDays.setWednesday (const Value: Boolean);begin chkWednesday.checked := Value;end;
procedure TfmchooseDays.setThursday  (const Value: Boolean);begin chkThursday.checked  := Value;end;
procedure TfmchooseDays.setFriday    (const Value: Boolean);begin chkFriday.checked    := Value;end;
procedure TfmchooseDays.setSaturday  (const Value: Boolean);begin chkSAturday.checked  := Value;end;


end.
