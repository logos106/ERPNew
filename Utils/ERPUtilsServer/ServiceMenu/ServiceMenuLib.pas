unit ServiceMenuLib;

interface

uses classes , controls;

function ControlParent(control :TControl): string;
function FindComponentByName(Const RootComponent:TComponent; Const ComponentName: string; SearchSub :Boolean = true; fsControlParent :String = ''): TComponent;

implementation

uses Sysutils ;

function ControlParent(control :TControl): string;
begin
  result:= '';
  try
    if control = nil then exit;
    if Assigned(Control.Parent) then result := ControlParent(Control.Parent)+'.'+control.Name else result := control.Name;
  Except
  end;
end;

function FindComponentByName(Const RootComponent:TComponent; Const ComponentName: string; SearchSub :Boolean = true; fsControlParent :String = ''): TComponent;
var
  ctr, I: integer;
Begin
  Result := nil;
  if RootComponent.ComponentCount =0 then exit;
  for ctr  := 1 to 2 do begin
  {this lop is specifically for the mainmenu.panel1/panel2 buttons for workflows Play
  As on the mainmenu the parent panel is dynamic and the panel could be different when u play it }
    for I := 0 to RootComponent.ComponentCount - 1 do begin
      if Sysutils.SameText(RootComponent.Components[I].Name,ComponentName) then

        if fsControlParent='' then begin
          Result := RootComponent.Components[I];
          Exit;
        end else if not (RootComponent.Components[I] is TControl) then begin
          Result := RootComponent.Components[I];
          Exit;
        end else if sametext(fsControlParent , ControlParent(TControl(RootComponent.Components[I])))  then begin
          Result := RootComponent.Components[I];
          Exit;
        end;
    end;
    if fsControlParent = '' then break;
         if pos(uppercase('MainSwitch2.sbButtons.pnlButtons2'), uppercase(fsControlParent)) =1 then fsControlParent := StringReplace(fsControlParent ,'MainSwitch2.sbButtons.pnlButtons2', 'MainSwitch2.sbButtons.pnlButtons1', [rfIgnoreCase] )
    else if pos(uppercase('MainSwitch2.sbButtons.pnlButtons1'), uppercase(fsControlParent)) =1 then fsControlParent := StringReplace(fsControlParent ,'MainSwitch2.sbButtons.pnlButtons1', 'MainSwitch2.sbButtons.pnlButtons2', [rfIgnoreCase] )
    else break;
  end;

  if not(SearchSub) then exit;

  if RootComponent.ComponentCount >0 then
    for I := 0 to RootComponent.ComponentCount - 1 do begin
      //logtext(RootComponent.Name+'['+inttostr(i)+']='+RootComponent.Components[I].name +'.componentcount='+inttostr(RootComponent.Components[I].ComponentCount));
      if RootComponent.Components[I].ComponentCount >0 then begin
        Result:= FindComponentbyName(RootComponent.Components[I],ComponentName, SearchSub,fsControlParent);
        if (result = nil) and (fsControlParent <> '') then
          Result:= FindComponentbyName(RootComponent.Components[I],ComponentName, SearchSub, '');
        if Assigned(Result) then exit;
      end;
    end;
end;

end.
