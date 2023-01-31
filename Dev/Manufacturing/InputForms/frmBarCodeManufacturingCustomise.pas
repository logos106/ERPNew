unit frmBarCodeManufacturingCustomise;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, Shader, DNMPanel, ImageDLLLib,
  DNMSpeedButton;

type
  Tformbutton  = record
    Name:String;
    visible:Boolean;
    Caption :String;
    checkBox:TCheckbox;
  end;
  TfmBarCodeManufacturingCustomise = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    Shader1: TShader;
    titleLabel: TLabel;
    Scrollbox: TScrollBox;
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    Label1: TLabel;
    btnSelectAll: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
  private
    formbuttons : Array of Tformbutton;
  public
    { Public declarations }
  end;


implementation

uses frmBarCodeManufacturing, StringUtils;

{$R *.dfm}

procedure TfmBarCodeManufacturingCustomise.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmBarCodeManufacturingCustomise.btnSaveClick(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  if Assigned(Self.Owner) then
    if self.Owner is TfmBarCodeManufacturing then begin
      With TfmBarCodeManufacturing(Owner) do begin
          for ctr:= low(formbuttons) to high(formbuttons) do begin
            TERPMainSwitchButton(findcomponent(formbuttons[ctr].name)).Visible := formbuttons[ctr].checkbox.Checked;
          end;
      end;
    end;
  Modalresult := mrOk;
end;

procedure TfmBarCodeManufacturingCustomise.btnSelectAllClick(
  Sender: TObject);
var
  x: integer;
begin
  inherited;
  for x := Low(formbuttons) to High(formbuttons) do begin
    formbuttons[x].checkBox.Checked := true;
  end;
end;

procedure TfmBarCodeManufacturingCustomise.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  SetLength(formbuttons,0);
  if Assigned(Self.Owner) then
    if self.Owner is TfmBarCodeManufacturing then begin
      With TfmBarCodeManufacturing(Owner) do begin
          Self.color := color;
          for ctr:= 0 to  ComponentCount-1 do
            if components[ctr] is TERPMainSwitchButton then
              if (TERPMainSwitchButton(components[ctr]).Parent = pnlOptions) or
                 (TERPMainSwitchButton(components[ctr]).Parent = DNMPanel3) or
                 (TERPMainSwitchButton(components[ctr]).Parent = DNMPanel4) then begin
                SetLength(formbuttons,length(formbuttons)+1);
                formbuttons[high(formbuttons)].Name := TERPMainSwitchButton (components[ctr]).Name;
                formbuttons[high(formbuttons)].visible := TERPMainSwitchButton (components[ctr]).visible;
                formbuttons[high(formbuttons)].Caption := TERPMainSwitchButton (components[ctr]).Caption;
              end;
          end;
      end;
  for ctr:= low(formbuttons) to high(formbuttons) do begin
    formbuttons[ctr].checkBox := Tcheckbox.Create(Self);
    formbuttons[ctr].checkBox.Parent := Scrollbox;
    formbuttons[ctr].checkBox.Align := altop;
    formbuttons[ctr].checkBox.alignWithMargins := True;
    formbuttons[ctr].checkBox.Margins.left := 3;
    formbuttons[ctr].checkBox.Margins.top := 3;
    formbuttons[ctr].checkBox.Margins.Right := 3;
    formbuttons[ctr].checkBox.Margins.Bottom := 3;
    formbuttons[ctr].checkBox.Alignment := taRightJustify;
    formbuttons[ctr].checkBox.Caption :=ProperCase(formbuttons[ctr].caption);
    formbuttons[ctr].checkBox.checked :=formbuttons[ctr].visible;
    formbuttons[ctr].checkBox.visible := true;
  end;
end;

end.
