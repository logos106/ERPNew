unit BaseClassFuncs;

interface

uses Classes, BaseInputForm, BaseListingForm;

function GetBaseInputByClassName(Const FormClassName: string; Const SingleInstance: boolean = false): TBaseInputGUI;
function GetBaseListingByClassName(Const FormClassName: string; Const SingleInstance: boolean = false; Owner: TComponent = nil): TBaseListingGUI;
function GetBaseListingByClassNameNoCreate(Const FormClassName: string): TBaseListingGUI;

implementation

uses Dialogs, CommonLib;


function GetBaseInputByClassName(Const FormClassName: string; Const SingleInstance: boolean = false): TBaseInputGUI;
var
  Obj: TComponent;
begin
  Obj := GetComponentByClassName(FormClassName, SingleInstance);
  if Assigned(Obj) then Result := TBaseInputGUI(Obj)
  else Result := nil;
end;

function GetBaseListingByClassName(Const FormClassName: string; Const SingleInstance: boolean = false; Owner: TComponent = nil): TBaseListingGUI;
var
  Obj: TComponent;
begin
  Obj := GetComponentByClassName(FormClassName, SingleInstance, Owner);
  if Assigned(Obj) then Result := TBaseListingGUI(Obj)
  else Result := nil;
end;

function GetBaseListingByClassNameNoCreate(Const FormClassName: string): TBaseListingGUI;
var
  Obj: TComponent;
begin
  Obj := FindExistingComponent(FormClassName);
  if Assigned(Obj) then Result := TBaseListingGUI(Obj)
  else Result := nil;
end;

end.
