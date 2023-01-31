unit frmProdAttribBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Grids, Wwdbigrd, Wwdbgrid, StdCtrls, wwdblook,
  DNMSpeedButton, BusobjProdAttribGroup, ExtCtrls , UserLockObj, Menus ;

type
  TfmProdAttribBase = class(TfrmBaseGUI)
    procedure FormCreate(Sender: TObject);

  private
    fiAccessLevel: Integer;
    function getAttributeGroups: TProdAttribGroups;
    procedure SetAccessLevel(const Value: Integer);
    function getMainform: TfrmBaseGUI;
  Protected
    procedure EnableDisable;Virtual;// Enables / disables components according to access levels
    Procedure EnableProgressbar(visible :Boolean; Max :Integer);
    Procedure StepProgress;
    function userLock:TUserLock;

  public
    Property AccessLevel :Integer Read fiAccessLevel Write SetAccessLevel;
    Property AttributeGroups : TProdAttribGroups read getAttributeGroups;
    Property Mainform :TfrmBaseGUI read getMainform;
  end;

implementation

uses BaseInputForm, frmProdAttribMain ;


{$R *.dfm}

procedure TfmProdAttribBase.FormCreate(Sender: TObject);
begin
  inherited;
 AccessLevel := 0;
 if Self.owner is TBaseInputGUI then
  AccessLevel:= TBaseInputGUI(Self.owner).AccessLevel;
end;

procedure TfmProdAttribBase.EnableDisable;// Enables / disables components according to access levels
var 
  iIndex: integer;
  bEnabled: boolean;
begin 
  bEnabled := AccessLevel < 5;
  for iIndex := 0 to ComponentCount - 1 do begin 
    if Components[iIndex] is TWinControl then begin// Combos
      if Components[iIndex] is TwwDBLookupCombo then begin
        if (TwwDBLookupCombo(Components[iIndex]).DataSource <> nil) then begin
          TwwDBLookupCombo(Components[iIndex]).Enabled := bEnabled;
        end;
      end;// Grids
      if Components[iIndex] is TwwDBGrid then begin
        TwwDBGrid(Components[iIndex]).ReadOnly := not bEnabled;
      end;

      if Components[iIndex] is TDNMSpeedButton then begin
        if (Components[iIndex].Name = 'btnSave') or (Components[iIndex].Name = 'btnNew') or (Components[iIndex].Name = 'cmdOk') or (Components[iIndex].Name = 'btnCompleted') or (Components[iIndex].Name = 'cmdSave') or (Components[iIndex].Name = 'cmdNew') then begin
          if TDNMSpeedButton(Components[iIndex]).Enabled then begin 
            TDNMSpeedButton(Components[iIndex]).Enabled := bEnabled;
          end;
        end;
      end;
    end;
  end;
end;


function TfmProdAttribBase.getAttributeGroups: TProdAttribGroups;
begin
  REsult := TfmProdAttribMain(Self.Owner).AttributeGroups;
end;

procedure TfmProdAttribBase.SetAccessLevel(const Value: Integer);
begin
  fiAccessLevel := Value;
  if Assigned(AttributeGroups) then EnableDisable;
end;

function TfmProdAttribBase.getMainform: TfrmBaseGUI;
begin
  Result := nil;
  if assigned(Self.owner) then
    if Self.Owner is tfrmbasegui then
      result := TfrmBaseGUI(Self.Owner);
end;

procedure TfmProdAttribBase.EnableProgressbar(visible: Boolean;
  Max: Integer);
begin
  if assigned(Self.Owner) then
    if self.Owner is TfmProdAttribMain then
      TfmProdAttribMain(Self.Owner).EnableProgressbar(Visible , Max);
end;

procedure TfmProdAttribBase.StepProgress;
begin
  if assigned(Self.Owner) then
    if self.Owner is TfmProdAttribMain then
      TfmProdAttribMain(Self.Owner).StepProgress;
end;

function TfmProdAttribBase.userLock: TUserLock;
begin
  REsult:= nil;
  if assigned(Mainform) then
    if mainform is TfmProdAttribMain then
      result := TfmProdAttribMain(mainform).AttributeGroups.Userlock;
end;

end.
