unit StsUtils;

interface

uses
  Classes;

function IsExistsEmptyControls(AOwner: TComponent): boolean;

implementation

uses
  Controls, StdCtrls, CommonLib, wwdblook, DBCtrls, Wwdbcomb, SysUtils, Dialogs, ComCtrls, Forms;

function GetEmptyControlCaption(AOwner: TComponent; AObject: TWinControl): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to AOwner.ComponentCount - 1 do
    if AOwner.Components[i] is TLabel then
      with TLabel(AOwner.Components[i]) do
        if FocusControl = AObject then
          Exit(Caption);
end;


function IsExistsEmptyControls(AOwner: TComponent): boolean;
var
  i: integer;
  LMsg: string;
  LControl: TWinControl;
begin
  Result := False;
  LControl := nil;
  for i := 0 to AOwner.ComponentCount - 1 do
  begin
    if AOwner.Components[i] is TWinControl then
      LControl := TWinControl(AOwner.Components[i])
    else
      Continue;

    if LControl.Tag = -10 then
      Continue;

    if not LControl.Visible then
      Continue;

    if LControl is TEdit then
      Result := TEdit(LControl).Text = ''
    else if LControl is TwwDBLookupCombo then
      Result := TwwDBLookupCombo(LControl).Text = ''
    else if LControl is TwwDBComboBox then
      Result := TwwDBComboBox(LControl).Text = ''
    else if LControl is TDBMemo then
      Result := TDBMemo(LControl).Text = ''
    else if LControl is TComboBox then
      Result := TComboBox(LControl).Text = ''
    else if LControl is TFrame then
    begin
      Result := IsExistsEmptyControls(LControl);
      if Result then
        Exit;
    end;

    if Result then
    begin
      LMsg := GetEmptyControlCaption(AOwner, LControl);
      LMsg := Trim(Format('You missed field: %s', [LMsg]));
      MessageDlgXP_Vista(LMsg, mtWarning, [mbOK], 0);
      if LControl.CanFocus then
        LControl.SetFocus;
      Exit;
    end;
  end;
end;

end.
