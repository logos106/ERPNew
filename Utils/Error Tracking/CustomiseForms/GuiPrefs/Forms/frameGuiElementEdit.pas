unit frameGuiElementEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  GuiPrefsObj, DataTreeObj, frmFormGuiPrefsEdit;

type
  TfrGuiElementEdit = class(TFrame)
  private
    fElement: TGuiElement;
    function GetNode: TDataTreeNode;
    function GetTarget: TComponent;
    function GetEditGuiPrefsForm: TfmFormGuiPrefsEdit;
  public
    property Element: TGuiElement read fElement write fElement;
    property Node: TDataTreeNode read GetNode;
    property Target: TComponent read GetTarget;
    procedure DisplayGuiSettings; virtual;
    property EditGuiPrefsForm: TfmFormGuiPrefsEdit read GetEditGuiPrefsForm;
  end;

  TfrGuiElementEditClass = class of TfrGuiElementEdit;

implementation

{$R *.dfm}

{ TfrGuiElementEdit }

procedure TfrGuiElementEdit.DisplayGuiSettings;
begin

end;

function TfrGuiElementEdit.GetEditGuiPrefsForm: TfmFormGuiPrefsEdit;
begin
  if Assigned(Owner) and (Owner is TfmFormGuiPrefsEdit) then
    result:= TfmFormGuiPrefsEdit(Owner)
  else
    result:= nil;  
end;

function TfrGuiElementEdit.GetNode: TDataTreeNode;
begin
  if Assigned(fElement) then
    result:= Element.Node
  else
    result:= nil;  
end;

function TfrGuiElementEdit.GetTarget: TComponent;
begin
  if Assigned(fElement) then
    result:= Element.Target
  else
    result:= nil;  
end;

end.
