unit frmUDDPropertyListEditor;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 06/12/05 1.00.00  MV   Initial verson.
 06/12/05 1.00.01  MV   Modified to support CategoryName Field required
                        datScopingAddin.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess, SelectionDialog,
  AppEvnts, DB,  StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, daBase, Menus, AdvMenus,
  Shader;

type
  TUDDListEditor = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    pnlBottom: TDNMPanel;
    Memo1: TMemo;
    DNMPanel1: TDNMPanel;
    UserCanEditList: TCheckBox;
    btnOk: TDNMSpeedButton;
    Label1: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    DefinitionPtr: TdaCustPropDef;
    function GetDefinitionPtr: TdaCustPropDef;
    procedure SetDefinitionPtr(const Value: TdaCustPropDef);
  public
    { Public declarations }
    property Definition: TdaCustPropDef read GetDefinitionPtr write SetDefinitionPtr;
  end;

{var
  UDDListEditor: TUDDListEditor;}

implementation

    // Only required if FormFact used in initialization

{$R *.dfm}

procedure TUDDListEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;
end;

function TUDDListEditor.GetDefinitionPtr: TdaCustPropDef;
begin
  Result := DefinitionPtr;
end;

procedure TUDDListEditor.SetDefinitionPtr(const Value: TdaCustPropDef);
begin
  if DefinitionPtr <> Value then DefinitionPtr := Value;
end;

procedure TUDDListEditor.FormActivate(Sender: TObject);
begin
  inherited;
  // Load previously defined items
  UserCanEditList.Checked := DefinitionPtr.Params.UserCanEditList;
  Memo1.Lines.CommaText := DefinitionPtr.Params.ListValues;
end;

procedure TUDDListEditor.btnOkClick(Sender: TObject);
begin
  inherited;
  // Save Params
  DefinitionPtr.Params.UserCanEditList := UserCanEditList.Checked;
  DefinitionPtr.Params.ListValues := Memo1.Lines.CommaText;
  Close;
end;

procedure TUDDListEditor.FormCreate(Sender: TObject);
begin
    Self.fbIgnoreAccessLevels := true;
  inherited;
  if ErrorOccurred then Exit;
end;

initialization
  {RegisterClassOnce(TUDDListEditor);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
  end;}

finalization
  //UnRegisterClass(TUDDListEditor);
end.
