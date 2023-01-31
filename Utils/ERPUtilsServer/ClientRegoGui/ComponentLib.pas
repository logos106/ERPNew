unit ComponentLib;

interface

uses
  classes;

  function CreateComponentInst(aComponentClassName: string;
                               aOwner: TComponent = nil): TComponent;
  procedure RefreshForm(FormClassName: string);
  
implementation

uses
  forms, frmBase;

function CreateComponentInst(aComponentClassName: string;
                               aOwner: TComponent = nil): TComponent;
var
  comp: TComponent;
  Cls: TPersistentClass;
begin
  comp:= nil;
  Cls := GetClass(aComponentClassName);

  if Cls <> nil then begin

    if Assigned(aOwner) then
      comp:= TComponentClass(Cls).Create(aOwner)
    else
      comp:= TComponentClass(Cls).Create(nil);

    if comp is TForm then
      TForm(comp).Show;
  end;
  result:= comp;
end;

procedure RefreshForm(FormClassName: string);
var
  form: TForm;
  x: integer;
begin
  form:= Application.MainForm;
  for x:= 0 to form.MDIChildCount -1 do begin
    if form.MDIChildren[x].ClassNameIs(FormClassName) then
      TfmBase(form.MDIChildren[x]).RefreshData;

  end;
end;

end.
