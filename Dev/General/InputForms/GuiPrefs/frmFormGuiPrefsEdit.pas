unit frmFormGuiPrefsEdit;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 17/10/05  1.00.01 DSP  Set component name to null in SetFormGuiPrefs to avoid
                        duplicate names.
 03/01/06  1.00.02 DSP  Added ActiveTab property.
 17/01/06  1.00.03 DSP  Added Hourglass cursor when saving.
 13/03/06  1.00.04 DSP  Added pcMainDrawTab event method to paint the tabs the
                        same colour as the rest of the page control.
 24/04/06  1.00.05 DSP  Added SetControlFocus to btnOKClick.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, GuiPrefsObj, ComCtrls,AdvOfficeStatusBar,
  Shader, DNMPanel, wwclearbuttongroup, wwradiogroup, frmBase, Menus;

type
  TfmFormGuiPrefsEdit = class(TfrmBaseGUI)
    pnlBottom: TDNMPanel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnDefaults: TDNMSpeedButton;
    pnlTop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlMain: TDNMPanel;
    pcMain: TPageControl;
    rgUserType: TwwRadioGroup;
    chkReset: TCheckBox;
    btnAddtoMainSwitch: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgUserTypeClick(Sender: TObject);
    procedure btnDefaultsClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure pnlTopDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pcMainDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure chkResetClick(Sender: TObject);
    procedure btnAddtoMainSwitchClick(Sender: TObject);
  private
    fbPainting :Boolean;  
    fFormGuiPrefs: TFormGuiPrefs;
    SaveUserType: TPrefUserType;
    CallingAction :TObject;
    procedure SetFormGuiPrefs(const Value: TFormGuiPrefs);
    procedure SetActiveTab(const Value: string);
    procedure CheckforCallingform;
  protected
  public
    procedure DisplayAllGuiSettings;
  published
    property FormGuiPrefs: TFormGuiPrefs read fFormGuiPrefs write SetFormGuiPrefs;
    property ActiveTab: string write SetActiveTab;
  end;


var
  fmFormGuiPrefsEdit: TfmFormGuiPrefsEdit;

implementation

{$R *.dfm}

uses
  frameGuiElementEdit, CommonLib, CommonDbLib, GraphUtil, AppEnvironment,
  TypInfo, FastFuncs, dnmLib , DnmAction, PrefObj, tcConst, MainSwitchFrm2;

procedure TfmFormGuiPrefsEdit.FormCreate(Sender: TObject);
begin
  inherited;
  //pnlTitle.Color := GetGradientColor(Self.ClassName).Color;
  //Self.Color := ColorAdjustLuma(pnlTitle.Color,GetGradientColor(Self.ClassName).AdjLuma div 2, False);
end;

procedure TfmFormGuiPrefsEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FormGuiPrefs.Dirty then begin
    // revert back to saved prefs
    FormGuiPrefs.LoadPrefs;
    FormGuiPrefs.ApplyGuiPrefs;
  end;
end;

procedure TfmFormGuiPrefsEdit.FormShow(Sender: TObject);
begin
  inherited;
  SaveUserType := FormGuiPrefs.UserType;
  chkReset.Checked := FormGuiPrefs.ResetAllToGlobal;
  PerformPaints;
  CheckforCallingform;
end;
Procedure TfmFormGuiPrefsEdit.CheckforCallingform;
var
  GuiPrefs : TObject;
begin
  btnAddtoMainSwitch.Visible := False;
        if Assigned(GetPropInfo(Self,'FormGuiPrefs')) then begin
            GuiPrefs := GetObjectProp(Self, 'FormGuiPrefs');
            if (Assigned(GuiPrefs)) and (GuiPrefs is TFormGuiPrefs) and (Assigned(TFormGuiPrefs(GuiPrefs).Owner)) and (TFormGuiPrefs(GuiPrefs).Owner is TfrmBaseGUI) then begin
              if (Assigned(TfrmBaseGUI(TFormGuiPrefs(GuiPrefs).Owner).CallingAction)) and
                 (TfrmBaseGUI(TFormGuiPrefs(GuiPrefs).Owner).CallingAction is TDnmAction)  then begin
                 CallingAction := TfrmBaseGUI(TFormGuiPrefs(GuiPrefs).Owner).CallingAction ;
                 btnAddtoMainSwitch.Visible := True;
              end;
            end;
        end;
end;
procedure TfmFormGuiPrefsEdit.rgUserTypeClick(Sender: TObject);
var
  UserType: TPrefUserType;
begin
  case rgUserType.ItemIndex of
    0: UserType := puUser;
    1: UserType := puGlobal;
    else UserType := puUser;
  end;
  if UserType <> FormGuiPrefs.UserType then begin
    // reload the prefs
    FormGuiPrefs.UserType := UserType;
    // reapply to target
    if not FormGuiPrefs.UserPrefsOnly then btnDefaults.Enabled := rgUserType.Enabled and (FormGuiPrefs.UserType <> puGlobal);
    FormGuiPrefs.LoadPrefs;
    FormGuiPrefs.ApplyGuiPrefs;
    // update display
    DisplayAllGuiSettings;
  end;
  if not FormGuiPrefs.UserPrefsOnly then btnDefaults.Enabled := rgUserType.Enabled and (FormGuiPrefs.UserType <> puGlobal);
  if UserType = puUser then begin
    chkReset.Checked := false;
    chkReset.Enabled := false;
    FormGuiPrefs.ResetAllToGlobal := false;
  end
  else begin
    // pu Global
    chkReset.Enabled := true;
  end;
end;

procedure TfmFormGuiPrefsEdit.btnDefaultsClick(Sender: TObject);
begin
  //
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete all your custom display settings for this form and revert back to the default settings?',
    mtWarning, [mbYes, mbNo], 0) = mrYes then begin
    FormGuiPrefs.RevertToGlobalPrefs;
    FormGuiPrefs.ApplyGuiPrefs;
    DisplayAllGuiSettings;
  end;
end;

procedure TfmFormGuiPrefsEdit.btnOKClick(Sender: TObject);
begin
  SetControlFocus(btnOK);  // Used to trigger OnExit event of ItemEdit in frameWwDbGridGuiEdit if visible.
  Processingcursor(True);
  Enabled := False;

  try
    if FormGuiPrefs.Dirty then
      FormGuiPrefs.SavePrefs;
    if FormGuiPrefs.FCEnabled then
      FormGuiPrefs.Savecurrencysetup;
    FormGuiPrefs.ApplyGuiPrefs;
  finally
    Processingcursor(False);
    ModalResult := mrOk;
  end;
end;

procedure TfmFormGuiPrefsEdit.chkResetClick(Sender: TObject);
begin
  inherited;
  FormGuiPrefs.ResetAllToGlobal := chkReset.Checked;
end;

procedure TfmFormGuiPrefsEdit.btnAddtoMainSwitchClick(Sender: TObject);
var
  fsPagename:String;
  fsActionname:String;
begin
  inherited;
  if not(assigned(CallingAction)) then exit;
  if not (CallingAction is TDnmAction) then exit;
  fsPagename:= TDnMAction(CallingAction).Category;
  fsActionname:= TDnMAction(CallingAction).Name;
  if TPrefCollection.AddAction(fsPagename, fsActionname , PREF_GROUP_MAIN_SWITCH) then begin
    MainSwitch2.RefreshButtons((*Sender*)CallingAction , true);
  end;

end;

procedure TfmFormGuiPrefsEdit.btnCancelClick(Sender: TObject);
begin
  Processingcursor(True);
  try
    if FormGuiPrefs.Dirty then begin

      if SaveUserType <> FormGuiPrefs.UserType then begin
        FormGuiPrefs.UserType := SaveUserType;
      end;

      FormGuiPrefs.LoadPrefs;
      FormGuiPrefs.ApplyGuiPrefs;
    end;
  finally
    Processingcursor(False);
    ModalResult := mrCancel;
  end;  
end;

procedure TfmFormGuiPrefsEdit.SetFormGuiPrefs(const Value: TFormGuiPrefs);
var
  x: integer;
  TabSheet: TTabSheet;
//  TabWidth: integer;
  Cls: TPersistentClass;
  MinW, MinH: integer;
  GuiElementEdit: TfrGuiElementEdit;
  posn: integer;
  rowCount : integer;
begin
  fFormGuiPrefs := Value;
//  GuiElementEdit := nil;

  // add a tab for each Gui element
  MinH := 0;
  MinW := 0;
  for x := 0 to fFormGuiPrefs.Elements.Count - 1 do begin
    try
      Cls := FindClass(fFormGuiPrefs.Elements[x].PrefFrameClassName);
      TabSheet := TTabSheet.Create(self);
      TabSheet.PageControl := pcMain;
      TabSheet.Caption := fFormGuiPrefs.Elements[x].Description;
      Showcontrolhint(TabSheet , fFormGuiPrefs.Elements[x].ElementPagehint);
      GuiElementEdit := TfrGuiElementEditClass(Cls).Create(self);
      with GuiElementEdit do begin
        Name := '';
        Parent := TabSheet;
        if   TabsheetIndex >= 0 then TabSheet.PageIndex := TabsheetIndex;
        Element := fFormGuiPrefs.Elements[x];
        if Constraints.MinWidth > MinW then MinW := Constraints.MinWidth;
        if Constraints.MinHeight > MinH then MinH := Constraints.MinHeight;
        DisplayGuiSettings(Appenv.Employee.EmployeeID);
      end;
    except
      raise
    end;
    pcMain.Tabindex :=0;
  end;

  RowCount := fFormGuiPrefs.Elements.Count div 6;

  if fFormGuiPrefs.Elements.Count mod 6 <> 0 then
    RowCount := RowCount + 1;

  RealignTabControl(pcMain, RowCount);

  // adjust form size to accommodate largest tab
  if (MinW > 0) and (MinW > ClientWidth) then ClientWidth := MinW;
  if (MinH > 0) and
    ((ClientHeight - pnlTop.Height - pnlBottom.Height - pcMain.TabHeight * RowCount) < MinH) then
    ClientHeight := (pnlTop.Height + pnlBottom.Height + pcMain.TabHeight * RowCount + MinH);
(*
  // ajust tab widths to use full width
  if pcMain.PageCount = 1 then begin
    pcMain.TabWidth := pcMain.Width;
  end else begin
    TabWidth        := Trunc((pcMain.Width - 3) / pcMain.PageCount);
    pcMain.TabWidth := TabWidth;
  end;
*)
  case FormGuiPrefs.UserType of
    puGlobal: rgUserType.ItemIndex := 1;
    puUser: rgUserType.ItemIndex := 0;
    else rgUserType.ItemIndex := -1;
  end;

  if FormGuiPrefs.UserPrefsOnly then begin
    btnDefaults.Enabled := false;
    rgUserType.Visible  := false
  end else begin
    rgUserType.Visible  := true;
    btnDefaults.Enabled := rgUserType.Enabled and (FormGuiPrefs.UserType <> puGlobal);
  end;

  if FormGuiPrefs.UserType = puGlobal then Caption := 'Customise - GLOBAL SETTINGS'
  else Caption := 'Customise';

  posn := FastFuncs.PosEx('-',TForm(fFormGuiPrefs.Owner).Caption);
  if posn > 0 then
    TitleLabel.Caption := FastFuncs.LeftStr(TForm(fFormGuiPrefs.Owner).Caption,posn-1)
  else
    TitleLabel.Caption := TForm(fFormGuiPrefs.Owner).Caption;
  PerformPaints;
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
  fuserID:Integer;
begin
  if rgUserType.ItemIndex = 0 then  fuserID :=  AppEnv.Employee.EmployeeID else fuserID := 0;
  for x := 0 to self.ComponentCount - 1 do begin
    if Components[x] is TfrGuiElementEdit then TfrGuiElementEdit(Components[x]).DisplayGuiSettings(fuserID);
  end;
  PerformPaints;
end;

procedure TfmFormGuiPrefsEdit.SetActiveTab(const Value: string);
var
  Index: Integer;
begin
  for Index := 0 to pcMain.PageCount - 1 do
  begin
    if Sysutils.SameText(pcMain.Pages[Index].Caption, Value) then pcMain.ActivePage := pcMain.Pages[Index];
  end;
  PerformPaints;
end;

procedure TfmFormGuiPrefsEdit.pcMainDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  TmpRect: TRect;
  Bitmap: TBitmap;
begin
  Bitmap := TBitmap.Create;

  try
    TmpRect    := Rect;
    Bitmap.Width := 300;
    Bitmap.Height := 300;
    Bitmap.Canvas.Brush.Color := Color;
    Bitmap.Canvas.FillRect(Classes.Rect(0, 0, 300, 300));

    Control.Canvas.Brush.Bitmap := Bitmap;
    TmpRect := Control.ClientRect;
    TmpRect.Left := ((TPageControl(Control).TabWidth * TPageControl(Control).PageCount) div TPageControl(Control).RowCount) + 4;
    TmpRect.Bottom := Rect.Bottom - 4;
    Control.Canvas.FillRect(TmpRect);
    TmpRect := Rect;
    TmpRect.Bottom := TmpRect.Bottom + 2;
    Control.Canvas.FillRect(TmpRect);
    TmpRect.Bottom := TmpRect.Bottom - 2;

    if Active then
      Control.Canvas.Font.Color := clNavy;

    Control.Canvas.Brush.Style := bsClear;
    DrawText(Control.Canvas.Handle, PChar(TPageControl(Control).Pages[TabIndex].Caption), - 1, TmpRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);
  finally
    FreeandNil(Bitmap);
  end;
end;

procedure TfmFormGuiPrefsEdit.FormPaint(Sender: TObject);

  procedure TabSheetShow(Sender: TObject);
  var
    TabSheetRect: TRect;
    PageControlRect: TRect;
    Bitmap: TBitmap;
    Canvas: TControlCanvas;
  begin
  if Sender=nil then
    exit;
    Bitmap := TBitmap.Create;
    Canvas := TControlCanvas.Create;
    try
      Bitmap.Width := 300;
      Bitmap.Height := 300;
      Bitmap.Canvas.Brush.Color := Self.color;//ColorAdjustLuma(GetGradientColor(Self.ClassName).Color,GetGradientColor(Self.ClassName).AdjLuma div 2, False);
      Bitmap.Canvas.FillRect(Rect(0, 0, 300, 300));
      TabSheetRect := TTabSheet(Sender).ClientRect;
      Canvas.Control := TTabSheet(Sender);
      Canvas.Brush.Bitmap := Bitmap;
      Canvas.FillRect(TabSheetRect);
      Canvas.Control := TTabSheet(Sender).PageControl;
      Canvas.Brush.Bitmap := Bitmap;
      PageControlRect := Canvas.Control.ClientRect;
      PageControlRect.Left := TTabSheet(Sender).Left - 2;
      PageControlRect.Top := TTabSheet(Sender).Top - 2;
      PageControlRect.Right := PageControlRect.Right - 2;
      PageControlRect.Bottom := PageControlRect.Bottom - 2;
      Canvas.FillRect(PageControlRect);
    finally
      FreeAndNil(Bitmap);
      FreeAndNil(Canvas);
    end;
  end;
begin
  If not fbPainting then Try  // Attempt to Stop InvalidateComponents force Paint Loop
    fbPainting := True;
    (*TitleShader.FromColor := pnlTitle.Color;
    TitleShader.ToColorMirror := pnlTitle.Color;*)
    TabSheetShow(TPageControl(pcMain).ActivePage);
    inherited;
    PaintGradientColor(Self);
    InvalidateComponents(Self);
  finally
    fbPainting := False;
  end;
end;

initialization
  RegisterClassOnce(TfmFormGuiPrefsEdit);

finalization
  UnRegisterClass(TfmFormGuiPrefsEdit);
end.
