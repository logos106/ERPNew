unit frameGuiElementEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  GuiPrefsObj, DataTreeObj, frmFormGuiPrefsEdit, StdCtrls, ExtCtrls;

type
    TfrGuiElementEdit = class(TFrame)
    tmrProcessMessage: TTimer;
    lblMsg: TLabel;
    procedure tmrProcessMessageTimer(Sender: TObject);
    private
        fElement: TGuiElement;
        fiTabsheetIndex: Integer;
        function GetNode: TDataTreeNode;
        function GetTarget: TComponent;
        function GetEditGuiPrefsForm: TfmFormGuiPrefsEdit;
    Protected
        procedure TimerMsg(const Value: String; Secondstoshow: Integer=10; msgColor: TColor= clred);
    public
        constructor Create(AOwner: TComponent); override;
        property Element: TGuiElement read fElement write fElement;
        property Node: TDataTreeNode read GetNode;
        property Target: TComponent read GetTarget;
        procedure DisplayGuiSettings(fUserID:Integer =0); virtual;
        property EditGuiPrefsForm: TfmFormGuiPrefsEdit read GetEditGuiPrefsForm;
        Property TabsheetIndex :Integer read fiTabsheetIndex write fiTabsheetIndex;
    end;

    TfrGuiElementEditClass = class of TfrGuiElementEdit;

implementation

uses GraphUtil,CommonDbLib;

{$R *.dfm}

{ TfrGuiElementEdit }

constructor TfrGuiElementEdit.Create(AOwner: TComponent);
begin
  inherited;
  If Assigned(Self.Owner) then
    Self.Color := ColorAdjustLuma(GetGradientColor(Self.Owner.ClassName).Color,GetGradientColor(Self.Owner.ClassName).AdjLuma , False);
  TabsheetIndex := -1;
end;

procedure TfrGuiElementEdit.DisplayGuiSettings(fUserID:Integer =0);
begin
end;

procedure TfrGuiElementEdit.TimerMsg(const Value: String; Secondstoshow: Integer=10; msgColor: TColor= clred);
var
  x: integer;
begin
  lblMsg.caption := Value;
  lblMsg.font.color :=msgColor;
  lblMsg.visible := True;
  x := lblMsg.Canvas.TextWidth(lblMsg.caption);
  if x > lblMsg.Width then
    lblMsg.Height := 20 * Round((x / lblMsg.Width) + 0.4)
  else
    lblMsg.Height := 20;
  tmrProcessMessage.interval :=Secondstoshow*1000;
  tmrProcessMessage.Enabled := True;
end;

procedure TfrGuiElementEdit.tmrProcessMessageTimer(Sender: TObject);
begin
  lblMsg.visible := False;
  tmrProcessMessage.enabled := False;
end;

function TfrGuiElementEdit.GetEditGuiPrefsForm: TfmFormGuiPrefsEdit;
begin
  if Assigned(Owner) and (Owner is TfmFormGuiPrefsEdit) then Result := TfmFormGuiPrefsEdit(Owner)
  else Result := nil;  
end;

function TfrGuiElementEdit.GetNode: TDataTreeNode;
begin
  if Assigned(fElement) then Result := Element.Node
  else Result := nil;  
end;

function TfrGuiElementEdit.GetTarget: TComponent;
begin
  if Assigned(fElement) then Result := Element.Target
  else Result := nil;  
end;

end.

