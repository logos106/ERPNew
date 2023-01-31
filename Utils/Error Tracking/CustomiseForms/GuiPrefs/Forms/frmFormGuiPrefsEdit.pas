unit frmFormGuiPrefsEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, GuiPrefsObj, ComCtrls, Shader,
  DNMSpeedButton;

type
  TfmFormGuiPrefsEdit = class(TForm)
    pnlBottom: TPanel;
    pnlTop: TPanel;
    pnlMain: TPanel;
    rgUserType: TRadioGroup;
    pcMain: TPageControl;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnDefaults: TDNMSpeedButton;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure rgUserTypeClick(Sender: TObject);
    procedure btnDefaultsClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure pnlTopDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fFormGuiPrefs: TFormGuiPrefs;
    SaveUserType: TPrefUserType;
    procedure SetFormGuiPrefs(const Value: TFormGuiPrefs);
  protected
  public
    property FormGuiPrefs: TFormGuiPrefs read fFormGuiPrefs write SetFormGuiPrefs;
    procedure DisplayAllGuiSettings;
  end;

var
  fmFormGuiPrefsEdit: TfmFormGuiPrefsEdit;

implementation

{$R *.dfm}

uses
  frameGuiElementEdit;

procedure TfmFormGuiPrefsEdit.FormCreate(Sender: TObject);
begin
//
end;

procedure TfmFormGuiPrefsEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
  if FormGuiPrefs.Dirty then begin
    // revert back to saved prefs
    FormGuiPrefs.LoadPrefs;
    FormGuiPrefs.ApplyGuiPrefs;
  end;
end;

procedure TfmFormGuiPrefsEdit.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfmFormGuiPrefsEdit.FormShow(Sender: TObject);
begin
  SaveUserType:= FormGuiPrefs.UserType;
end;

procedure TfmFormGuiPrefsEdit.rgUserTypeClick(Sender: TObject);
var
  UserType: TPrefUserType;
begin
  case rgUserType.ItemIndex of
    0: UserType:= puUser;
    1: UserType:= puGlobal;
    else UserType:= puUser;
  end;
  if UserType <> FormGuiPrefs.UserType then begin
    // reload the prefs
    FormGuiPrefs.UserType:= UserType;
    // reapply to target
    if not FormGuiPrefs.UserPrefsOnly then
      btnDefaults.Enabled := rgUserType.Enabled and (FormGuiPrefs.UserType <> puGlobal);
    FormGuiPrefs.ApplyGuiPrefs;
    // update display
    DisplayAllGuiSettings;
  end;
  if not FormGuiPrefs.UserPrefsOnly then
    btnDefaults.Enabled := rgUserType.Enabled and (FormGuiPrefs.UserType <> puGlobal);
end;

procedure TfmFormGuiPrefsEdit.btnDefaultsClick(Sender: TObject);
begin
  //
  if MessageDlg('Are you sure you want to delete all your custom display settings '+
    #13+#10+'for this form and revert back to the default settings?',
    mtWarning, [mbYes,mbNo], 0) = mrYes then begin
    FormGuiPrefs.RevertToGlobalPrefs;
    FormGuiPrefs.ApplyGuiPrefs;
    DisplayAllGuiSettings;
  end;
end;

procedure TfmFormGuiPrefsEdit.btnOKClick(Sender: TObject);
begin
  if FormGuiPrefs.Dirty then
    FormGuiPrefs.SavePrefs;
  FormGuiPrefs.ApplyGuiPrefs;
  Modalresult:= mrOk;
end;

procedure TfmFormGuiPrefsEdit.btnCancelClick(Sender: TObject);
begin
  if FormGuiPrefs.Dirty then begin
    if SaveUserType <> FormGuiPrefs.UserType then begin
      FormGuiPrefs.UserType:= SaveUserType;
    end;
    FormGuiPrefs.LoadPrefs;
    FormGuiPrefs.ApplyGuiPrefs;
  end;
  ModalResult:= mrCancel;
end;

procedure TfmFormGuiPrefsEdit.SetFormGuiPrefs(const Value: TFormGuiPrefs);
var
  x: integer;
  TabSheet: TTabSheet;
  TabWidth: integer;
  Cls: TPersistentClass;
  MinW, MinH: integer;
  GuiElementEdit: TfrGuiElementEdit;
begin
  fFormGuiPrefs := Value;
  GuiElementEdit:= nil;

  // add a tab for each Gui element
  MinH:= 0;
  MinW:= 0;
  for x:= 0 to fFormGuiPrefs.Elements.Count-1 do begin
    try
      Cls:= FindClass(fFormGuiPrefs.Elements[x].PrefFrameClassName);
      TabSheet:= TTabSheet.Create(self);
      TabSheet.PageControl:= pcMain;
      TabSheet.Caption:= fFormGuiPrefs.Elements[x].Description;
      GuiElementEdit:= TfrGuiElementEditClass(Cls).Create(self);
      with GuiElementEdit do begin
        Parent:= TabSheet;
        Element:= fFormGuiPrefs.Elements[x];
        if Constraints.MinWidth > MinW then MinW:= Constraints.MinWidth;
        if Constraints.MinHeight > MinH then MinH:= Constraints.MinHeight;
        DisplayGuiSettings;
      end;
    except
      raise
    end;
  end;

  // adjust form size to accommodate largest tab
  if (MinW > 0) and (MinW > ClientWidth) then
    ClientWidth:= MinW;
  if (MinH > 0) and
     ((ClientHeight - pnlTop.Height - pnlBottom.Height - pcMain.TabHeight) < MinH) then
    ClientHeight:= (pnlTop.Height + pnlBottom.Height + pcMain.TabHeight + MinH);

  if pcMain.PageCount = 1 then begin
    // don't display tabs if there is only one
    pcMain.Visible:= false;
    GuiElementEdit.Parent := pnlMain;
  end
  else begin
    // ajust tab widths to use full width
    TabWidth:= Trunc((pcMain.Width - 3) / pcMain.PageCount);
    pcMain.TabWidth:= TabWidth;
  end;

  case FormGuiPrefs.UserType of
    puGlobal: rgUserType.ItemIndex:= 1;
    puUser: rgUserType.ItemIndex:= 0;
    else rgUserType.ItemIndex:= -1;
  end;

  if FormGuiPrefs.UserPrefsOnly then begin
    btnDefaults.Enabled:= false;
    rgUserType.Visible:= false
  end
  else begin
    rgUserType.Visible:= true;
    btnDefaults.Enabled := rgUserType.Enabled and (FormGuiPrefs.UserType <> puGlobal);
  end;

  if FormGuiPrefs.UserType = puGlobal then
    Caption:= 'Customise - GLOBAL SETTINGS'
  else
    Caption:= 'Customise';
    
  TitleLabel.Caption := TForm(fFormGuiPrefs.Owner).caption;

end;


procedure TfmFormGuiPrefsEdit.pnlTopDblClick(Sender: TObject);
//var
//  s: string;
begin
//  if FormGuiPrefs.UserType = puUser then s:= 'User'
//  else if FormGuiPrefs.UserType = puGlobal then s:= 'Global';
//
//  self.FormGuiPrefs.Node.SaveToFile(s + '_' +FormGuiPrefs.Node.NodeName + '.xml');
end;

procedure TfmFormGuiPrefsEdit.DisplayAllGuiSettings;
var
  x: integer;
begin
  for x:= 0 to self.ComponentCount-1 do begin
    if Components[x] is TfrGuiElementEdit then
      TfrGuiElementEdit(Components[x]).DisplayGuiSettings;
  end;
end;

initialization
  RegisterClass(TfmFormGuiPrefsEdit);

finalization
  RegisterClass(TfmFormGuiPrefsEdit);


end.
