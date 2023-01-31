unit Preferences;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/07/06  1.00.01 DSP  First version.

}

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImageScroll, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DB,
  DNMSpeedButton, StdCtrls, wwcheckbox, DataSourcePrefs, MessageConst,
  wwradiogroup, Mask, wwdbedit, Wwdotdot, Wwdbcomb, jpeg, GraphUtil, Shader,
  AdvScrollBox, ImgList, MemDS , BasePrefs, PrefsConfigListObj, ActnList,
  DNMAction, ProgressDialog, Grids, Wwdbigrd, Wwdbgrid, ImageDLLLib;

type
  TPreferencesGUI = class(TBaseInputGUI)
    sbButtons: TScrollBox;
    ImageScroll: TImageScroll;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    Bevel1: TBevel;
    cboSearch: TwwDBComboBox;
    Label2: TLabel;
    imgPrefs: TImage;
    Shader: TShader;
    pnlActiveForm: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lsTDNMSpeedButtonActions: TActionList;
    actSave: TDNMAction;
    actCancel: TDNMAction;
    btnSearch: TDNMSpeedButton;
    cboFields: TwwDBComboBox;
    DNMPanel1: TDNMPanel;
    sbPrefs: TAdvScrollBox;
    lblMsg: TLabel;
    btnOpenList: TDNMSpeedButton;
    popMain: TPopupMenu;
    AuditTrail1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboSearchCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure AfterCommitFunctions;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actCancelUpdate(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cboSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cboSearchDblClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnOpenListClick(Sender: TObject);
    procedure AuditTrail1Click(Sender: TObject);

  private
    //fSingleButtonCaption: string;
    fsSinglePanelToshow:String;
    fTextSearch: string;
    fFocusControlName: string;
    fSourceForm: TBasePrefsGUI;
    fDataSourcePrefs: TDataSourcePrefs;
    fPreventFinish: Boolean;
    fPanelColor: TColor;
    fRestartRequired: boolean;
    ButtonCtr:Integer;
    Selectedbutton:TObject;
    SearchControl:Tcomponent;
    fPrefsConfigList: TPrefConfigList;
    fFormColorsChanged: boolean;
    fbIsformClosing :boolean;
    fDoingProcess: boolean;
    AuditTrailDiffList :TStringlist;
    fPrefformStartedStatus: TSubformStartupStatus;
    procedure HandleActiveFormChange(Sender: TObject);
    procedure AddButton(const ButtonCaption: string; const ButtonTop: Integer);
    procedure AddMainButtons;
    procedure LoadPanels;
    function GetFormClassName(const ButtonCaption: string): string;
    function ClearScrollBox: boolean;
    function GetDataSourcePrefs: TDataSourcePrefs;
    procedure SetupConnections;
    procedure BuildSearchList;
    procedure CancelFinish(var Msg: TMessage); message TX_CancelFinish;
    procedure PerformTextSearch(var Msg: TMessage); message TX_PerformTextSearch;
    procedure CallMainSwitchFormShow;
    function IsButtonShown(const ButtonIndex: Integer): Boolean;
    procedure SetAccessLevel(const Form: TForm);
    procedure ChangeControlfont(const control: Tcomponent);
    procedure ResetControlfont;
    procedure openSearchlist(const SearchValue:String);
    procedure LocatePreference(Sender: TwwDbGrid);
    procedure InitPreferenceList(Sender: TObject);
    function Datafield(const Value: Tcomponent): String;
    Procedure ShowTimerMsg(Const Value:String);
    procedure InitbuttonOptions(buttons: String='');
    procedure AfterShowPreferenceList(Sender: TObject);
    procedure DoAuditTrail;
    function getSourceFormName: String;
    //procedure SetSingleButtonCaption(const Value: string);
  Protected
    procedure ApplyPreferenceNames;Override;
    Procedure AfterFormShow; Override;
  public
    procedure SetScrollBarIncrement;
    Procedure AfterTranslate; Override;
    Function SearchForText(const SearchStr: string; const FocusControlName: string = ''; SearchingCaption :Boolean =True):Boolean;
    //property SingleButtonCaption: string read fSingleButtonCaption write SetSingleButtonCaption;
    Property SinglePanelToshow :String read fsSinglePanelToshow write fsSinglePanelToshow;
    property TextSearch: string read fTextSearch write fTextSearch;
    property FocusControlName: string read fFocusControlName write fFocusControlName;
    property RestartRequired: boolean read fRestartRequired write fRestartRequired;
    property FormColorsChanged: boolean read fFormColorsChanged write fFormColorsChanged;
    Property IsformClosing :boolean read fbIsformClosing;
    Property DoingProcess :boolean read fDoingProcess write fDoingProcess;
    Procedure ShowHintmsg(const Value:String);
    property PrefsConfigList: TPrefConfigList read fPrefsConfigList;
    Property initMsg :String write ShowTimerMsg;
    Procedure DoOnchangedDataSave(Const Changedfield:Tfield; CleanDs :TMyQuery);Overload;
    procedure DoOnchangedDataSave(const aPreftype, aPropName, acleanValue, aNewValue: String);Overload;
    procedure CreateAuditTrailEntry(aName, acleanValue, aNewValue: String);Overload;
    procedure CreateAuditTrailEntry(const Value: String);Overload;
    function SinglePanelMode: Boolean;
    Property PrefformStartedStatus:TSubformStartupStatus read fPrefformStartedStatus write fPrefformStartedStatus;
    Property SourceFormName :String read getSourceFormName;

    function IsPanelShown(const ctl: TControl): Boolean;
    function FindMainButton(const Caption: string): TERPMainSwitchButton(*TDNMSpeedButton*);
    procedure MainButtonClick(Sender: TObject);
  end;

  function OpenPrefform(SinglebuttonCaption, focuscontrolName: string;
    Accesslevel:Integer = 0; OpenAsModel: boolean = true;
    TextSearch: string = ''; SinglePanelToshow: string = '';
    initMsg: string=''): boolean;

implementation

uses
  CommonLib, DNMLib, StrUtils,
  CommonDBLib, AppEnvironment, FastFuncs,tcTypes,
  BusObjProcPrefs, BusObjNDSBase, MAIN,  dmMainGUI, BaseFormForm, TypInfo,
  AdvSpin, DBCtrls, Wwdbspin, wwdblook, wwdbdatetimepicker,
  MyClasses, PreferenceLib, LogThreadLib, LogMessageTypes, frmBase,
  CommonFormLib, PreferencesList, WorkflowObj, LogLib, tcDataUtils, tcConst,
  types, commonGuiLib, BusobjDbPreferences4AuditTrail, BusObjBase,
  BusObjAudit, DbSharedObjectsObj, BusObjPrejerenceToExport , ImagesLib;

const
  cMainButtonWidth = 148;
  cMainButtonHeight = 28;
  cMainButtonGap = 1;
  cMainButtonLeft = 14;
  cMainButtonTopStart = 5;
  cFormCount = 20;
  cMaxRange = 6000;
var
  aButtonCaptions: array[1..cFormCount] of string = ('Accounts',
                                                     'Appointments',
                                                     'Colours',
                                                     'Employee',
                                                     'EDI and Integration',
                                                     'Fixed Assets',
                                                     'General',
                                                     'Hire',
                                                     'Inventory',
                                                     'Manufacturing',
                                                     'Messaging',
                                                     'Payments',
                                                     'Payroll',
                                                     'POS',
                                                     'Purchases',
                                                     'Sales',
                                                     'Sounds',
                                                     'Speed',
                                                     'Utilities',
                                                     'Workshop');

  aFormClassNames: array[1..cFormCount] of string = ('TAccountsPrefsGUI',
                                                     'TAppointmentsPrefsGUI',
                                                     'TColourPrefsGUI',
                                                     'TEmployeePrefsGUI',
                                                     'TIntegrationPrefsGUI',
                                                     'TFixedAssetsPrefsGUI',
                                                     'TGeneralPrefsGUI',
                                                     'THirePrefsGUI',
                                                     'TInventoryPrefsGUI',
                                                     'TProcessPrefsGUI',
                                                     'TMessagePrefsGUI',
                                                     'TPaymentsPrefsGUI',
                                                     'TPayrollPrefsGUI',
                                                     'TPOSPrefsGUI',
                                                     'TPurchasesPrefsGUI',
                                                     'TSalesPrefsGUI',
                                                     'TSoundPrefsGUI',
                                                     'TSpeedPrefsGui',
                                                     'TUtilitiesPrefsGUI',
                                                     'TWorkshopPrefsGUI');


  cButtonCaptions :Array of String;
  cFormClassNames :Array of String;

{$R *.dfm}

function OpenPrefform(SinglebuttonCaption, focuscontrolName: string;
  Accesslevel :Integer =0;OpenAsModel:boolean =True;TextSearch: string = '';
  SinglePanelToshow: string = ''; initMsg: string=''): boolean;
var
  LockMessage:String;
  Form : TComponent;
begin
//  if not(Assigned(fPrefLib)) then fPrefLib:= TPrefLib.create(Application);
//  if not(assigned(fPrefLib)) then exit;


//  if fPrefLib.LockDBPref(LockMessage) then begin
  result := false;
  if LockPreferenceTable(LockMessage) then begin
    try
      Form := GetComponentByClassName('TPreferencesGUI',true,nil,AccessLevel=0, AccessLevel<>0);
      try
        if (Assigned(Form)) and (AccessLevel <= 1) then begin //if has acess
              if Accesslevel <> 0 then
                if TPreferencesGUI(Form).AccessLevel > Accesslevel then
                  TPreferencesGUI(Form).AccessLevel :=Accesslevel;
              //TPreferencesGUI(Form).SingleButtonCaption := SinglebuttonCaption;
              TPreferencesGUI(Form).InitbuttonOptions(SinglebuttonCaption);
              TPreferencesGUI(Form).SinglePanelToshow := SinglePanelToshow;
              TPreferencesGUI(Form).FocusControlName    := focuscontrolName;
              TPreferencesGUI(Form).TextSearch          := TextSearch;
              if OpenAsModel then begin
                TPreferencesGUI(Form).FormStyle           := fsNormal;
                TPreferencesGUI(Form).Position            := poScreenCenter;
                TPreferencesGUI(Form).initMsg := initMsg;
                result := TPreferencesGUI(Form).ShowModal = mrOk;
                Freeandnil(form);
              end else begin
                result := true;
                TPreferencesGUI(Form).FormStyle           := fsMdiChild;
                TPreferencesGUI(Form).BringtoFront;
                TPreferencesGUI(Form).initMsg := initMsg;
              end;
        end else begin
          UnLockPreferenceTable;
          MessageDlgXP_Vista('You don''t have permission to change the Preferences.',mtWarning, [mbok], 0);
        end;
      finally
          (* FreeandNil(Form); *)
      end;
    finally
      //fPrefLib.UnLockDBPref;
      //UnLockPreferenceTable;
    end;
  end else begin
    MessageDlgXP_vista(LockMessage, mtWarning, [mbOK], 0);
  end;
end;

{ TPreferencesGUI }
Procedure TPreferencesGUI.InitbuttonOptions(buttons:String='');
var
  ctr:Integer;
  sl: TStringDynArray;
  Function IndexOf(Const Value:String):Integer;
  var
    i:Integer;
  begin
    result := -1;
    for i := low(sl) to high(sl) do
      if sametext(sl[i] , value) then begin
        result := i;
        exit;
      end;

  end;
begin
  if (buttons='') and (Length(cButtonCaptions) = Length(aButtonCaptions)) and (Length(cFormClassNames) = Length(aFormClassNames)) then exit;
  Setlength(cButtonCaptions,0);
  Setlength(cFormClassNames,0);

    sl := SplitString(Trim(Buttons),',');
    for ctr:= low(aButtonCaptions) to high(aButtonCaptions) do begin
      if  (buttons = '') or (IndexOf(aButtonCaptions[ctr])>=0) then begin
        Setlength(cButtonCaptions,Length(cButtonCaptions)+1);
        Setlength(cFormClassNames,Length(cFormClassNames)+1);
        cButtonCaptions[high(cButtonCaptions)]:= aButtonCaptions[ctr];
        cFormClassNames[high(cFormClassNames)]:= aFormClassNames[ctr];
      end;
    end;

end;
procedure TPreferencesGUI.ApplyPreferenceNames;
var
  ctr:Integer;
begin
  inherited;
  for ctr:= low(aButtonCaptions) to high(aButtonCaptions) do begin
    if Pos('Equipment' , aButtonCaptions[ctr])>0 then aButtonCaptions[ctr]:= replacestr(aButtonCaptions[ctr] , 'Equipment' , Appenv.DefaultClass.EquipmentName);
    if Pos('Hire' , aButtonCaptions[ctr])>0 then aButtonCaptions[ctr]:= replacestr(aButtonCaptions[ctr] , 'Hire' , Appenv.DefaultClass.HireName);
  end;
end;

procedure TPreferencesGUI.AuditTrail1Click(Sender: TObject);
begin
  inherited;
  OpenErpListform('TPreferencesAuditTrailGUI' );
end;

procedure TPreferencesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fPrefformStartedStatus:= sssNone;
  AuditTrailDiffList := TStringlist.create;
  cboFields.Visible := devmode;
  initbuttonOptions;
  fFormColorsChanged:= false;
  Selectedbutton:= nil;
  ButtonCtr:=0;
  fbTabSettingEnabled := False;
  fTextSearch := '';
  fFocusControlName := '';
  //fSingleButtonCaption := '';
  fSourceForm := nil;
  fDataSourcePrefs := nil;
  fPreventFinish := False;
  fDoingProcess:= False;
  (*sbPrefs.DoubleBuffered := True;*)
  imgPrefs.IncrementalDisplay := true;
  fPanelColor := Self.color; //ColorAdjustLuma(GetGradientColor(Self.ClassName).Color, GetGradientColor(Self.ClassName).AdjLuma div 2, False);
//  pnlButtons.Color := fPanelColor;
  (*Shader.FromColor := GetGradientColor(ClassName).Color;
  Shader.ToColorMirror := Shader.FromColor;
  Color := fPanelColor;*)
  fRestartRequired:= false;
  SearchControl := nil;
  fPrefsConfigList:= TPrefConfigList.Create;
  fbIsformClosing:= False;
end;

procedure TPreferencesGUI.SetAccessLevel(const Form: TForm);
  var
    Index: Integer;
    i :Integer;
  begin
    if Form.ClassName = 'TEmployeePrefsGUI' then exit;
    i :=AccessLevel;
    for Index := 0 to Form.ComponentCount - 1 do begin
      if (Form.Components[Index] is TAdvSpinEdit)             then TAdvSpinEdit(Form.Components[Index]).Readonly        := i>1
      else if (Form.Components[Index] is TDBMemo)             then TDBMemo(Form.Components[Index]).Readonly             := i>1
      else if (Form.Components[Index] is TEdit)               then TEdit(Form.Components[Index]).Readonly               := i>1
      else if (Form.Components[Index] is TwwCheckBox)         then TwwCheckBox(Form.Components[Index]).Readonly         := i>1
      else if (Form.Components[Index] is TwwDBComboBox)       then TwwDBComboBox(Form.Components[Index]).Readonly       := i>1
      else if (Form.Components[Index] is TwwDBEdit)           then TwwDBEdit(Form.Components[Index]).Readonly           := i>1
      else if (Form.Components[Index] is TwwDBGrid)           then TwwDBGrid(Form.Components[Index]).Readonly           := i>1
      else if (Form.Components[Index] is TwwDBSpinEdit)       then TwwDBSpinEdit(Form.Components[Index]).Readonly       := i>1
      else if (Form.Components[Index] is TwwRadioGroup)       then TwwRadioGroup(Form.Components[Index]).Readonly       := i>1
      else if (Form.Components[Index] is TwwDBLookupCombo)    then TwwDBLookupCombo(Form.Components[Index]).Readonly    := i>1
      else if (Form.Components[Index] is TwwDBDateTimePicker) then TwwDBDateTimePicker(Form.Components[Index]).Readonly := i>1;
    end;
  end;

procedure TPreferencesGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    {if (SingleButtonCaption = '') then showProgressbar(WAITMSG , 10 + Length(cFormClassNames)(*cFormCount*))
    else showProgressbar(WAITMSG , 10);}
    showProgressbar(WAITMSG , 10 + Length(cFormClassNames)(*cFormCount*));
    try
        inherited;
        stepProgressbar;
        BuildSearchList;
        stepProgressbar;
        (*if (SingleButtonCaption <> '')  then begin
          AddButton(SingleButtonCaption, cMainButtonTopStart);
          fSourceForm := TBasePrefsGUI(GetComponentByClassName(GetFormClassName(SingleButtonCaption),true,self));
          SetAccessLevel(fSourceForm);
          pnlActiveForm.Caption := SingleButtonCaption;
        end else begin*)
          AddMainButtons;
          //if TextSearch = '' then begin
            fSourceForm := TBasePrefsGUI(GetComponentByClassName(cFormClassNames[0],true,self));
            SetAccessLevel(fSourceForm);
            pnlActiveForm.Caption := cButtonCaptions[0];
            (*if SingleButtonCaption = '' then begin
              fSourceForm := TBasePrefsGUI(GetComponentByClassName(cFormClassNames[1],true,self));
              SetAccessLevel(fSourceForm);
              pnlActiveForm.Caption := cButtonCaptions[1];
            end
            else begin
              fSourceForm := TBasePrefsGUI(GetComponentByClassName(GetFormClassName(SingleButtonCaption),true,self));
              SetAccessLevel(fSourceForm);
              pnlActiveForm.Caption := SingleButtonCaption;
            end;*)
          //end;
        (*end;*)
        stepProgressbar;
        BeginTransaction;
        AuditTrailDiffList.clear;
        stepProgressbar;

        if Assigned(fSourceForm) then begin
          fSourceForm.SinglePanelToshow := SinglePanelToshow;
          SetClassLabels(fSourceForm);
          AppEnv.RegionalOptions.ChangeForm(fSourceForm);
          SetupConnections;
          fDataSourcePrefs := GetDataSourcePrefs;
          stepProgressbar;
          if Assigned(fDataSourcePrefs) then begin
            fDataSourcePrefs.Connection := MyConnection;
            fDataSourcePrefs.Active := True;
          end;
          stepProgressbar;
          sbPrefs.Visible := False;
          LoadPanels;
          Application.processmessages;
          PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);

        end;
        stepProgressbar;
        Screen.OnActiveFormChange := HandleActiveFormChange;
    finally
      HideProgressbar;
      btnOpenList.Visible := not(fsModal in Self.FormState)  and (SinglePanelToshow = '') and (Length(cButtonCaptions)>1);
    end;

  finally
    MainForm.EnableForm;
    EnableForm;
    Top := 76;
  end;
end;
Function TPreferencesGUI.SinglePanelMode:Boolean;
begin
   REsult := (SinglePanelToshow<>'');
end;
procedure TPreferencesGUI.HandleActiveFormChange(Sender: TObject);
//var
//  Comp: TComponent;

//  function GetComponent(aParent: TComponent): TComponent;
//  var
//    x: integer;
//  begin
//    result := nil;
//    for x := 0 to aParent.ComponentCount -1 do begin
//      if SameText(aParent.Components[x].Name,FocusControlName) then begin
//        result := aParent.Components[x];
//        exit;
//      end;
//      result := GetComponent(aParent.Components[x]);
//      if Assigned(result) then
//        exit;
//    end;
//  end;

begin
  if (Screen.ActiveForm = Self) and (ImageScroll.Enabled = False) then begin
    sbPrefs.Visible := True; // To Stop Ficker on ShowForm
    Update;
    ImageScroll.Image := imgPrefs;
    ImageScroll.ScrollBox := sbPrefs;
    ImageScroll.Enabled := True;
    SetScrollBarIncrement;
    if (TextSearch <> '')  then begin
      SearchForText(TextSearch, FocusControlName);
      TextSearch := '';
    end
//    else if FocusControlName <> '' then begin
//     { assume we have opend prefs with a single page .. try and find control }
//       Comp := GetComponent(fSourceForm);
//       if Assigned(Comp) then begin
//         if Comp is TWinControl then
//           SetControlFocus(TWinControl(Comp));
//       end;
//    end;

  end;
end;

procedure TPreferencesGUI.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveFormChange := nil;
  UnLockPreferenceTable;
  fPrefsConfigList.Free;
  Freeandnil(AuditTrailDiffList);
  inherited;
end;

procedure TPreferencesGUI.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
var
  Increment: Integer;
begin
  inherited;
  Handled := True;
  Increment := sbPrefs.VertScrollBar.Increment;

  if WheelDelta < 0 then begin
    if (ImageScroll.ImagePosition + Increment) > imgPrefs.ClientHeight then
      ImageScroll.PerformScroll(imgPrefs.ClientHeight)
    else
      ImageScroll.PerformScroll(ImageScroll.ImagePosition + Increment);
  end
  else begin
    if (ImageScroll.ImagePosition - Increment) < 0 then
      ImageScroll.PerformScroll(0)
    else
      ImageScroll.PerformScroll(ImageScroll.ImagePosition - Increment)
  end;
end;

procedure TPreferencesGUI.AddMainButtons;
var
  ButtonTop: Integer;
  ButtonIndex: Integer;
begin
  ButtonTop := cMainButtonTopStart;
  for ButtonIndex := 0 to Length(cFormClassNames)-1(*cFormCount*) do begin
    if IsButtonShown(ButtonIndex) then begin
      AddButton(cButtonCaptions[ButtonIndex], ButtonTop);
      ButtonTop := ButtonTop + cMainButtonHeight + cMainButtonGap;
    end;
  end;
end;

procedure TPreferencesGUI.LoadPanels;
var
  TmpPanel: TDNMPanel;
  CurrentTop: Integer;
  PanelIndex: Integer;
  PanelList: TList;
  Bitmap: TBitmap;

  function GetPanel(Order: Integer): TDNMPanel;
  var
    Index: Integer;
  begin
    Result := nil;

    Index := 0;
    if fSourceForm is TBasePrefsGUI then
    while (Index < TBasePrefsGUI(fSourceform).sbpanels.ControlCount) and (Result = nil) do begin
      if (TBasePrefsGUI(fSourceform).sbpanels.Controls[Index] is TDNMPanel) and
         (TDNMPanel(TBasePrefsGUI(fSourceform).sbpanels.Controls[Index]).TabOrder = Order) then begin
        Result := TDNMPanel(TBasePrefsGUI(fSourceform).sbpanels.Controls[Index]);
         exit;
      end else
        Inc(Index);
    end;


    Index := 0;
    while (Index < fSourceForm.ControlCount) and (Result = nil) do begin
      if (fSourceForm.Controls[Index] is TDNMPanel) and
         (TDNMPanel(fSourceForm.Controls[Index]).TabOrder = Order) then begin
        Result := TDNMPanel(fSourceForm.Controls[Index]);
         exit;
      end else
        Inc(Index);
    end;

  end;

  procedure SetPanelProperties(const Panel: TDNMPanel);
  begin
    Panel.Align := alnone;
    Panel.BevelOuter := bvNone;
    Panel.Transparent := False;
    Panel.Color := fPanelColor;
    Panel.Left := 0;
    Panel.Top := CurrentTop;
    (*Panel.DoubleBuffered := True;*)
    Panel.Parent := sbPrefs;
    Panel.Width := sbPrefs.Width;
    Panel.Top := CurrentTop;
  end;

begin
  PanelList := TList.Create;
  Bitmap := TBitmap.Create;

  try
    PanelIndex := 0;
    TmpPanel := GetPanel(PanelIndex);
    while Assigned(TmpPanel) do begin
      if IsPanelShown(TmpPanel) then
        PanelList.Add(TmpPanel);

      Inc(PanelIndex);
      TmpPanel := GetPanel(PanelIndex);
    end;

    PanelIndex := 0;
    CurrentTop := 0;
    while PanelIndex < PanelList.Count do begin
       TmpPanel := TDNMPanel(PanelList[PanelIndex]);
      SetPanelProperties(TmpPanel);
      CurrentTop := CurrentTop + TmpPanel.Height;
      Inc(PanelIndex);
    end;
    if fSourceForm is TBasePrefsGUI then
      TBasePrefsGUI(fSourceform).sbpanels.visible := False;
  finally
    FreeandNil(PanelList);
    FreeandNil(Bitmap);
  end;
end;

procedure TPreferencesGUI.MainButtonClick(Sender: TObject);
begin
  ResetcontrolFont;
  if Sender is TERPMainSwitchButton(*TDNMSpeedButton*) then begin
    if not Sysutils.SameText(TERPMainSwitchButton(*TDNMSpeedButton*)(Sender).caption, pnlActiveForm.Caption) then begin
      ProcessingCursor(True);
      try
        ClearScrollBox;
        fPrefformStartedStatus:= sssNone;
        sbPrefs.VertScrollBar.Visible := True;
        fSourceForm := TBasePrefsGUI(GetComponentByClassName(GetFormClassName(EnglishCaption(TERPMainSwitchButton(*TDNMSpeedButton*)(Sender))),true,self));
        if Assigned(fSourceForm) then begin
          fSourceForm.PrefsConfigList := fPrefsConfigList;
          SetAccessLevel(fSourceForm);
          SetClassLabels(fSourceForm);
          AppEnv.RegionalOptions.ChangeForm(fSourceForm);
          SetupConnections;
          fDataSourcePrefs := GetDataSourcePrefs;

          if Assigned(fDataSourcePrefs) then begin
            fDataSourcePrefs.Connection := MyConnection;
            fDataSourcePrefs.Active := True;
          end;

          sbPrefs.Visible := False;
          try
            pnlActiveForm.Caption := TERPMainSwitchButton(*TDNMSpeedButton*)(Sender).caption;
            LoadPanels;
            Application.processmessages;
            ImageScroll.Enabled := False;
            imgPrefs.Picture.Graphic := nil;
            fPrefformStartedStatus := sssStarting;
            application.ProcessMessages;
            PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
            While fPrefformStartedStatus <> sssDone do begin
              application.ProcessMessages;
            end;
            Selectedbutton :=sender;
          Finally
            sbPrefs.Visible := True; // To Stop Ficker
            Update;
            ImageScroll.Enabled := True;
            SetScrollBarIncrement;
            application.ProcessMessages;
          end;
        end;
      finally
        Processingcursor(False);
      end;
    end;
  end;
end;

procedure TPreferencesGUI.openSearchlist(const SearchValue: String);
begin
   OpenERPListFormSingleselect('TPreferencesListGUI' , LocatePreference , InitPreferenceList , AfterShowPreferenceList);
end;

Procedure TPreferencesGUI.AfterShowPreferenceList(Sender: TObject);
begin
  if not(Sender is TPreferencesListGUI) then exit;
  TPreferencesListGUI(Sender).CloseOnRecSelect := False;
end;
Procedure TPreferencesGUI.InitPreferenceList(Sender: TObject);
begin
  if not(Sender is TPreferencesListGUI) then exit;
  TPreferencesListGUI(Sender).Values := cboSearch.Items;
  TPreferencesListGUI(Sender).PreferencetoLocate :=cboSearch.text;
end;
Procedure TPreferencesGUI.LocatePreference(Sender: TwwDbGrid);
begin
  cboSearch.Text := Sender.datasource.dataset.fieldbyname('SearchValue').asString;
  cboSearchCloseUp(cboSearch , True);
  Self.bringtofront;
end;
function TPreferencesGUI.GetFormClassName(const ButtonCaption: string): string;
var
  ctr:Integer;
begin
  Result := '';
  for ctr:= low(cFormClassNames) to high(cFormClassNames) do begin
    if sametext(ButtonCaption , cButtonCaptions[ctr]) then begin
      Result := cFormClassNames[ctr];
      exit;
    end;
  end;
(*var
  Index: Integer;
begin
  Index := 0;
  Result := '';

  while (Index <= Length(cFormClassNames)-1(*cFormCount* )) and (Result = '') do begin
    if cButtonCaptions[Index] = ButtonCaption then
      Result := cFormClassNames[Index]
    else
      Inc(Index);
  end;*)
end;

function TPreferencesGUI.getSourceFormName: String;
begin
  result := '';
  if assigned(fSourceForm) then
    result := fSourceForm.classname;
end;

function TPreferencesGUI.ClearScrollBox: boolean;
var
  Index: Integer;
  s:String;
  ctl:TControl;
begin
  HideHighlightControl;
  result:= true;
  if Assigned(fSourceForm) then begin
    try
      if Assigned(fDataSourcePrefs) then
        fDataSourcePrefs.SaveData;
      if not AppEnv.CompanyPrefs.ValidateData then begin
          fPreventFinish := True;
          exit;
      end;
      SendMessage(fSourceForm.Handle, TX_PerformFinish, 0, 0);
      if Assigned(fDataSourcePrefs) then begin
        fDataSourcePrefs.SaveData;
      end;
    except
      on e: Exception do begin
        if (e is EMyError) and (Pos('Lock wait timeout',e.Message) > 0) then begin
          CommonLib.MessageDlgXP_Vista('Unable to update one of more preference settings.' + #10#13 + #10#13 +
            'Records are locked by other users of processes in ERP, ' +
            'please try again shortly.', mtInformation, [mbOK], 0);
          result:= false;
          exit;
        end
        else
          raise;
      end;
    end;

    if not fPreventFinish then begin
      for Index := sbPrefs.ControlCount - 1 downto 0 do begin
          ctl:= sbPrefs.Controls[Index];
          ctl.Parent := fSourceForm;
      end;
      fSourceForm.Release;
      fSourceForm := nil;
      fDataSourcePrefs := nil;
    end;
  end;
end;

procedure TPreferencesGUI.FormActivate(Sender: TObject);
begin
  //  showmessage('color: ' + IntToStr(self.Color));
end;

procedure TPreferencesGUI.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Form : TComponent;
begin
  if FormStillOpen('TPreferencesListGUI') then begin
    Form :=  FindExistingComponent('TPreferencesListGUI');
    TForm(Form).BringtoFront;
    TForm(Form).Close;
    Application.ProcessMessages;
  end;

  fbIsformClosing :=True;
  try
    if (ModalResult in [mrNone, mrCancel]) then begin
      inherited;
      RollbackTransaction;
      AuditTrailDiffList.clear;

      if fsModal in FormState then
        ModalResult := mrCancel
      else
        Action := caFree;
    end;
  Except
    // kill the exception
  end;
  UnLockPreferenceTable;
end;

procedure TPreferencesGUI.AfterCommitFunctions;
begin
  AppEnv.Reset;
  { force the global manufacturing prefs object to reaload }
  ProcPrefs.Load;
end;

procedure TPreferencesGUI.AfterFormShow;
var
  TmpControl: TWinControl;
  NewPosition:Integer;
begin
  inherited;
  try
          if  (FocusControlName <> '') then begin
            if assigned(fSourceForm) then begin
              TmpControl := TWinControl(fSourceForm.FindComponent(FocusControlName));
              if Assigned(TmpControl) then begin
                SetControlFocus(TmpControl);
                fSourceForm.HighlightControl(TmpControl);
                NewPosition := System.Round((controlTop(TmpControl) - ((sbPrefs.ClientHeight ) / 2)) / ImageScrollHeightFactor(ImageScroll));
                NewPosition := NewPosition + 10;
                if NewPosition > imgPrefs.ClientHeight then
                  ImageScroll.PerformScroll(imgPrefs.ClientHeight)
                else if NewPosition > 0 then
                  ImageScroll.PerformScroll(NewPosition);
              end;

              FocusControlName := '';

            end;


          end;
  Except
    // kill the exception
  end;
end;

procedure TPreferencesGUI.AfterTranslate;
begin
  inherited;
  if assigned(Selectedbutton) then
    if Selectedbutton is TDNMSpeedButton then
      pnlActiveForm.caption := TDNMSpeedButton(Selectedbutton).caption
    else     if Selectedbutton is TERPMainSwitchButton then
      pnlActiveForm.caption := TERPMainSwitchButton(Selectedbutton).caption;

end;

procedure TPreferencesGUI.btnOpenListClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TPrejerenceToExportGUI');
end;

procedure TPreferencesGUI.btnSearchClick(Sender: TObject);
begin
  inherited;
  openSearchlist(cboSearch.text);
end;

function TPreferencesGUI.GetDataSourcePrefs: TDataSourcePrefs;
var
  Index: Integer;
  FoundDataSource: Boolean;
begin
  Result := nil;
  Index := 0;
  FoundDataSource := False;

  if Assigned(fSourceForm) then begin
    while (Index < fSourceForm.ComponentCount) and (not FoundDataSource) do begin
      if fSourceForm.Components[Index] is TDataSourcePrefs then begin
        Result := TDataSourcePrefs(fSourceForm.Components[Index]);
        FoundDataSource := True;
      end
      else
        Inc(Index);
    end;
  end;
end;

procedure TPreferencesGUI.SetScrollBarIncrement;
begin
  if (sbPrefs.VertScrollBar.Range > 0) and (sbPrefs.VertScrollBar.Range < cMaxRange) then
    sbPrefs.VertScrollBar.Increment := cMaxRange div sbPrefs.VertScrollBar.Range
  else
    sbPrefs.VertScrollBar.Increment := 1;
end;

{procedure TPreferencesGUI.SetSingleButtonCaption(const Value: string);
begin
  (*if pos(',' , value)<>0 then  begin
    InitbuttonOptions(Value);
  end else begin
    fSingleButtonCaption := Value;
  end;*)
  InitbuttonOptions(Value);
end;}

procedure TPreferencesGUI.SetupConnections;
var
  Index: Integer;
begin
  if Assigned(fSourceForm) then begin
    for Index := 0 to fSourceForm.ComponentCount - 1 do begin
      if fSourceForm.Components[Index] is TERPQuery then begin
        TERPQuery(fSourceForm.Components[Index]).Connection := MyConnection;
        TERPQuery(fSourceForm.Components[Index]).Open;
      end else if fSourceForm.Components[Index] is TBusObjNDS then
        TBusObjNDS(fSourceForm.Components[Index]).Storer.Connection := MyConnection;
    end;
    if Assigned(TypInfo.GetPropInfo(fSourceForm,'Connection')) then
      TypInfo.SetObjectProp(fSourceForm,'Connection', MyConnection);
  fSourceForm.SetupConnections(fSourceForm, MyConnection);
  end;
end;
procedure TPreferencesGUI.ShowHintmsg(const Value: String);
begin
  if trim(Value) = '' then exit;
  MessageDlgXP_Vista(Value, mtInformation, [mbOK], 0);
end;

procedure TPreferencesGUI.ShowTimerMsg(const Value: String);
begin
  if Value = '' then exit;
  TimerMsg(lblMsg, trim(Value), 20);
end;

function TPreferencesGUI.Datafield(const Value :Tcomponent):String;
var
    PropInfo: PPropInfo;
begin
    PropInfo:= GetPropInfo(Value, 'Datafield');
    if Assigned(PropInfo) then begin
      result := GetStrProp(Value,PropInfo);
    end;
end;
procedure TPreferencesGUI.BuildSearchList;
var
  Form: TForm;
  FormIndex: Integer;

  procedure Addfieldsforform(const Value :Tcomponent; const FormID: string);
  var
    s:String;
  begin
    s:= Datafield(Value);
    if s <> '' then
      cboFields.Items.Add(s + ' | ' + FormID);
  end;

 (* procedure LogPrefitem(ctl: TControl);
  var
    s1, s2, s3:String;
  begin
    if not devmode then exit;
    try
      if Assigned(GetPropInfo(ctl,'Caption')) and Assigned(GetPropInfo(ctl,'datafield')) then begin
        s1:= GetPropValue(ctl, 'Datafield');
        s2:= GetPropValue(ctl, 'caption');
        s3:= '';
        if Assigned(ctl.parent) and (ctl.parent is TDNmPanel) then
            s3:= GroupDescofPanel(TDnMPanel(ctl.parent));
        logtext('insert ignore into TMP_1 (Preftype ,page, Name , Description , groupdesc) values ("ptMisc" , '+
                                                                      quotedstr(Form.classname)+',' +
                                                                      quotedstr(s1)+',' +
                                                                      quotedstr(s2)+', ' +
                                                                      quotedstr(s3)+' );');
      end;
    Except
      // kill the exception
    end;
  end;*)
  procedure AddCaptionsForForm(const ctrl: TWinControl; const FormID: string);
  var
    Index: Integer;
    ctl: TControl;
  begin
    for Index := 0 to ctrl.ControlCount - 1 do begin
      ctl := ctrl.Controls[Index];
      //logtext(ctrl.name +':' +ctl.ClassName);
      //logtext('union Select ' + ctl.ClassName+ ' as Classname ' );
      //LogPrefitem(ctl);
      try
        if (ctl is TwwCheckBox) and (TwwCheckBox(ctl).Visible)  and
                 IsPanelShown(TDNMPanel(TwwCheckBox(ctl).Parent)) then begin
                //logtext('1');
                cboSearch.Items.Add(Trim(TwwCheckBox(ctl).Caption) + ' | ' + FormID);
        end else  if (ctl is TDBcheckbox) and (TDBcheckbox(ctl).Visible)  and
                 IsPanelShown(TDNMPanel(TDBcheckbox(ctl).Parent)) then begin
                //logtext('2');
                cboSearch.Items.Add(Trim(TDBcheckbox(ctl).Caption) + ' | ' + FormID);
        end else  if (ctl is TLabel) and (TLabel(ctl).Visible) and (TLabel(ctl).Name <> 'lblWidth') and
                 (not Sysutils.SameText(Copy(TLabel(ctl).Name, 1, 9), 'lblIgnore')) and
                 IsPanelShown(TDNMPanel(TLabel(ctl).Parent)) then begin
                //logtext('3');
                cboSearch.Items.Add(Trim(TLabel(ctl).Caption) + ' | ' + FormID);
        end else  if (ctl is TwwRadioGroup) and (TwwRadioGroup(ctl).Visible) and (Trim(TwwRadioGroup(ctl).Caption) <> '') and
                IsPanelShown(TDNMPanel(TwwRadioGroup(ctl).Parent)) then begin
                //logtext('4');
                cboSearch.Items.Add(Trim(TwwRadioGroup(ctl).Caption) + ' | ' + FormID(*iif(SingleButtonCaption = '' , ' | ' + FormID,'')*));
        end else  if (ctl is TDNMSpeedButton) and (TDNMSpeedButton(ctl).visible) and  (Trim(TDNMSpeedButton(ctl).Caption) <> '') and
                IsPanelShown(TDNMPanel(TDNMSpeedButton(ctrl.Controls[Index]).Parent)) then begin
                //logtext('5');
                cboSearch.Items.Add(Trim(TDNMSpeedButton(ctl).Caption) + ' | ' + FormID);
        end else  if (ctl is TERPMainSwitchButton) and (TERPMainSwitchButton(ctl).visible) and  (Trim(TERPMainSwitchButton(ctl).Caption) <> '') and
                IsPanelShown(TDNMPanel(TERPMainSwitchButton(ctrl.Controls[Index]).Parent)) then begin
                //logtext('6');
                cboSearch.Items.Add(Trim(TERPMainSwitchButton(ctl).Caption) + ' | ' + FormID);
        end;


        if devmode then Addfieldsforform(ctl, formID);
        if ctl is TWinControl then
          AddCaptionsForForm(TWinControl(ctl), formID);
      Except
        on E:Exception do begin
          logtext(E.message);
        end;
      end;
    end;
  end;

begin
  cboFields.Clear;
  cboSearch.Clear;
  //if (SingleButtonCaption = '')  then begin
    for FormIndex := 0 to Length(cFormClassNames)-1(*cFormCount*) do begin
      if IsButtonShown(FormIndex) then begin
        try
          Form := TForm(GetComponentByClassName(cFormClassNames[FormIndex]));
          try
            if Assigned(Form) then begin
              SetClassLabels(Form);
              AppEnv.RegionalOptions.ChangeForm(Form);
              AddCaptionsForForm(Form, cButtonCaptions[FormIndex]);
            end else begin
            end;
          finally
            FreeAndNil(Form);
          end;
        except
          on e: exception do begin
            TLogger.Inst.Log('  TPreferencesGUI.BuildSearchList - Exception getting form: ' + cFormClassNames[FormIndex] + ' message: ' + e.Message, ltError);
            raise;
          end;
        end;
      end;
      stepProgressbar;
    end;
  (*end
  else begin
    Form := TForm(GetComponentByClassName(GetFormClassName(SingleButtonCaption)));
    try
      if Assigned(Form) then begin
        SetClassLabels(Form);
        AppEnv.RegionalOptions.ChangeForm(Form);
        AddCaptionsForForm(Form, SingleButtonCaption);
      end;
    finally
      FreeAndNil(Form);
    end;
  end;*)
end;




function TPreferencesGUI.FindMainButton(const Caption: string): TERPMainSwitchButton(*TDNMSpeedButton*);
var
  Index: Integer;
  FoundButton: Boolean;
begin
  Index := 0;
  Result := nil;
  FoundButton := False;

  while (Index < ComponentCount) and (not FoundButton) do begin
    if (Components[Index] is TERPMainSwitchButton(*TDNMSpeedButton*)) and (EnglishCaption(TERPMainSwitchButton(*TDNMSpeedButton*)(Components[Index])) = Caption) then begin
      Result := TERPMainSwitchButton(*TDNMSpeedButton*)(Components[Index]);
      FoundButton := True;
    end
    else
      Inc(Index);
  end;
end;

procedure TPreferencesGUI.cboSearchCloseUp(Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  Update;

  if not fPreventFinish then
    SearchForText(Sender.Text, '' , Sender = cboSearch);
end;

procedure TPreferencesGUI.cboSearchDblClick(Sender: TObject);
begin
  inherited;
  openSearchlist(cboSearch.text);
end;

procedure TPreferencesGUI.cboSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = vk_f5) or (Key = vk_f6) or (Key = vk_f7) then begin
    openSearchlist(cboSearch.text);
  end;
end;

procedure TPreferencesGUI.actCancelExecute(Sender: TObject);
begin
  inherited;
  if DoingProcess then exit;
  if fPreventFinish then begin
    {if invalid is already commited}
    self.actSaveExecute(nil);
    Exit;
  end;

  if Assigned(fDataSourcePrefs) and (fDataSourcePrefs.State in [dsEdit, dsInsert]) then
    fDataSourcePrefs.DataSet.post;
  fPrefsConfigList.RollbackChanges;
  RollbackTransaction;
  AuditTrailDiffList.clear;

    if fsModal in FormState then
      ModalResult := mrcancel
    else begin
      //Release;
      Self.Close;
    end;
end;

procedure TPreferencesGUI.actCancelUpdate(Sender: TObject);
begin
  inherited;
  actCancel.Enabled := not(DoingProcess);
end;
Procedure TPreferencesGUI.DoAuditTrail;
var
  Audit:  TAudit;
begin
  if AuditTrailDiffList.count > 0 then begin
          Audit:= TAudit.Create(nil);
          try
            Audit.Load(0);
            Audit.New;
            Audit.TransType:= 'TPreferences';
            Audit.DataDescription:= 'Main';
            Audit.AuditDate:= now;
            Audit.employeeId := Appenv.employee.employeeId;
            Audit.ChangeDescription:= AuditTrailDiffList.Text;
            Audit.LogDetails(AuditTrailDiffList);
            try
                Audit.Save;
            Except
                // kill the exception when ChangeDescription is more than 255 chars
            end;
          finally
            FreeandNil(Audit);
          end;
  end;
  AuditTrailDiffList.clear;
(*var
  Pref, CleanPref:TPersonalPreferences4AuditTrail;
begin
  cleanPRef := TPersonalPreferences4AuditTrail.CreateWithSharedConn(self);
  Pref := TPersonalPreferences4AuditTrail.Create(Self);
  try
    Pref.connection := TMyDAcDataconnection.Create(Pref);
    Pref.connection.Connection := Myconnection;
    Pref.Load;
    cleanPref.Load;
    if AppEnv.CompanyPrefs.UseAuditTrail then
      Pref.CompareXMLDocs(cleanPref.XMLDoc, Pref.XMLDoc);
  finally
    Freeandnil(Pref);
    Freeandnil(cleanPref);
  end;*)

end;
procedure TPreferencesGUI.DoOnchangedDataSave(const Changedfield: Tfield;CleanDs: TMyQuery);
  Function NewValue  :String; begin   REsult := TDataSourcePrefs.PrefFieldToStr(Changedfield); end;
  Function CleanValue:String; begin   REsult := CleanDs.fieldbyname('FieldValue').asString           ; end;
begin
  DoOnchangedDataSave('', CleanDs.fieldbyname('Name').asString,CleanValue,NewValue);
end;
procedure TPreferencesGUI.DoOnchangedDataSave(const aPreftype, aPropName, acleanValue, aNewValue: String);
var
  QRy:TERPQuery;
begin
  if not AppEnv.CompanyPrefs.UseAuditTrail then exit;
  if acleanValue =aNewValue then exit;

  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    qry.sql.text := TPrejerenceToExport.PrefLisSQL(aPropName);
    qry.open;
    (*AuditTrailDiffList.add({PrefNameToDesc(aPreftype , aPropName)+} trim(qry.fieldbyname('Page').asString) +' - '+trim(qry.fieldbyname('GroupDEsc').asString) +' - '+trim(qry.fieldbyname('Description').asString) +
                          ' - Old Value =' +TPrejerenceToExport.FormatedFieldValue(aCleanValue, qry.fieldbyname('Fieldtype').asString)+
                          ', New Value =' + TPrejerenceToExport.FormatedFieldValue(aNewValue, qry.fieldbyname('Fieldtype').asString));*)
    CreateAuditTrailEntry(trim(qry.fieldbyname('Page').asString) +' - '+trim(qry.fieldbyname('GroupDEsc').asString) +' - '+trim(qry.fieldbyname('Description').asString)  ,
                                TPrejerenceToExport.FormatedFieldValue(aCleanValue, qry.fieldbyname('reftype').asString, qry.fieldbyname('Fieldtype').asString),
                                TPrejerenceToExport.FormatedFieldValue(aNewValue, qry.fieldbyname('reftype').asString,qry.fieldbyname('Fieldtype').asString));
  finally
      DbSharedObj.ReleaseObj(Qry);
  end;
end;
procedure TPreferencesGUI.CreateAuditTrailEntry(aName, acleanValue, aNewValue: String);
begin
  if not AppEnv.CompanyPrefs.UseAuditTrail then exit;
  if acleanValue =aNewValue then exit;
  CreateAuditTrailEntry(aName+
                          ' - Old Value =' +aCleanValue+
                          ', New Value =' + aNewValue);

end;
procedure TPreferencesGUI.CreateAuditTrailEntry(const Value: String);
begin
  if not AppEnv.CompanyPrefs.UseAuditTrail then exit;
  if AuditTrailDiffList.count =0 then AuditTrailDiffList.add('Preferences');
  AuditTrailDiffList.add(Value);
end;

procedure TPreferencesGUI.actSaveExecute(Sender: TObject);
var
  MainSwitchForm: TForm;
  x: integer;
  msgOption :word;
begin
  inherited;
  if DoingProcess then exit;
  Processingcursor(True);
  try
    {Since Saving the Preferances reloads the main switch based on the selections -  which accesses the main form's menu, the recording has to be stopped before saving }
    if IsWorkFlowRecoding then begin
      msgOption := MessageDlgXP_Vista('The Workflow recording has to be stopped for saving the Preferences. '+#13+#10+'Do you want to save and Stop the Recording ', mtWarning, [mbYes, mbNo, mbCancel], 0);
      if msgOption = mrCancel then exit;
      try
        if msgOption = mrYes then
          MainForm.DoStoprecording
        else
          MainForm.DoCancelrecording;
      except
      end;
    end;

    fPreventFinish := False;

    if Assigned(fDataSourcePrefs) then begin
      if (fDataSourcePrefs.State in [dsEdit, dsInsert]) then
        fDataSourcePrefs.DataSet.Post;

      fDataSourcePrefs.SaveData;
    end;

    if not AppEnv.CompanyPrefs.ValidateData then begin
      Exit;
    end;

    //DoAuditTrail;
    fPrefsConfigList.CommitChanges;
    CommitTransaction;
    DoAuditTrail;
    if not ClearScrollBox then exit;
    AfterCommitFunctions; {Reset All Prefs}


    if not fPreventFinish then begin
      if RestartRequired then begin
        dtmMainGUI.actFileOpenCompany.Execute;
      end;

      AfterCommitFunctions; {Reset All Prefs}

       { need to update open forms }
      if FormColorsChanged then begin
        for x:= 0 to Application.MainForm.MDIChildCount -1 do begin
          if Application.MainForm.MDIChildren[x] is TfrmBaseGUI then
            TfrmBaseGUI(Application.MainForm.MDIChildren[x]).ReloadFormColor;
        end;
        Application.MainForm.WindowState := wsMinimized;
        Application.MainForm.WindowState := wsMaximized;
      end;

      ShowWindow(Handle, SW_HIDE);
      MainSwitchForm := TForm(FindExistingComponent('TMainSwitch2'));

      if Assigned(MainSwitchForm) then
        MainSwitchForm.Update;

      CallMainSwitchFormShow;

      Application.MainForm.Update;

      Closeit(True);
    end else  begin
      btnCancel.enabled := False;
    end ;
  finally
    Processingcursor(False);
  end;
end;

procedure TPreferencesGUI.actSaveUpdate(Sender: TObject);
begin
  inherited;
  actSave.Enabled := not(DoingProcess);
end;

procedure TPreferencesGUI.AddButton(const ButtonCaption: string; const ButtonTop: Integer);
var
  Button: TERPMainSwitchButton(*TDNMSpeedButton*);
begin
(*  Button := TDNMSpeedButton.Create(Self);

  with Button do begin
    Left := cMainButtonLeft;
    Top := ButtonTop;
    Width := cMainButtonWidth;
    Height := cMainButtonHeight;
    Caption := ButtonCaption;
//    Parent := pnlButtons;
    Parent := sbButtons;
    Alignment := taCenter;
    //Color := clWhite;
    HotTrackColor := clBtnShadow;
    SlowDecease := True;
    Style := bsModern;
  ParentFont := false;
  ParentColor := false;
  Color := MENU_BUTTON_COLOR;
  Font.Style := Font.Style - [fsBold];
  Font.Size := 10;*)

  Button := TERPMainSwitchButton(*TDNMSpeedButton*).Create(Self);
  Button.Caption := ButtonCaption;
  Button.Parent := sbButtons;
  Button.ParentFont := false;
  Button.Font.Style := Button.Font.Style - [fsBold];
  Button.Font.Size := 10;
  Button.Top := ButtonTop;

  Button.Left := cMainButtonLeft;
  Button.Height := cMainButtonHeight;
  Button.Width := cMainButtonWidth;
  Button.Visible := true;
  Button.BringToFront;
  Button.WordWrap := true;

  Button.colors := vararrayof([clwhite,clSilver, $00EBC1AB, $00FBF2EE]);
  Button.colors := vararrayof([clwhite,clSilver, Appenv.Employee.ERPButtonHTColor, clWhite]);
  Button.Enabled := True;
  Button.OnClick := MainButtonClick;
  inc(ButtonCtr);
  Button.name := 'mainbutton_'+replacestr(replacestr(buttoncaption, ' ',''),'&','');
end;
  Procedure TPreferencesGUI.ResetControlfont;
  begin
  try
//  {$IFDEF DevMode}
    if not(Assigned(SearchControl)) then exit;
    if SearchControl is TLabel then begin
      TLabel(SearchControl).Font.Color := clblack;
    end else if SearchControl is TwwRadioGroup then begin
      TwwRadioGroup(SearchControl).Font.Color := clblack;
    end else if SearchControl is TDNMSpeedButton then begin
      TDNMSpeedButton(SearchControl).Font.Color := clblack;
    end else if SearchControl is TERPMainSwitchButton then begin
      TERPMainSwitchButton(SearchControl).Font.Color := clblack;
    end;
    SearchControl := nil;
//   {$ENDIF}
  except
  end;
  end;
  Procedure TPreferencesGUI.ChangeControlfont(Const control :Tcomponent);
  begin
  try
//   {$IFDEF DevMode}
    if Control is TLabel then begin
      TLabel(Control).Font.Color := clred;
      SearchControl:= control;
    end else if Control is TwwRadioGroup then begin
      TwwRadioGroup(Control).Font.Color := clred;
      SearchControl:= control;
    end else if Control is TDNMSpeedButton then begin
      TDNMSpeedButton(Control).Font.Color := clred;
      SearchControl:= control;
    end else if Control is TERPMainSwitchButton then begin
      TERPMainSwitchButton(Control).Font.Color := clred;
      SearchControl:= control;
    end;
    highlightcontrol(Tcontrol(control));
//  {$ENDIF}
  except
  end;
  end;

Function TPreferencesGUI.SearchForText(const SearchStr: string; const FocusControlName: string = ''; SearchingCaption :Boolean =True):Boolean;
var
//  ControlIndex: Integer;
  PanelIndex: Integer;
  FoundControl: Boolean;
  Panel: TPanel;
  ControlTop: Integer;
  ControlHeight: Integer;
  MainButton: TERPMainSwitchButton;
  NewPosition: Integer;
  IndexOfText: Integer;
//  ControlCaption: string;
  SearchText: string;
  DelimiterPos: Integer;
  TmpControl: TWinControl;
  ctl: TControl;
  ctr:Integer;

  function FindControl(const ctrl: TWinControl): TControl;
  var
    i: integer;
    cap: string;
  begin
    result := nil;
    for i := 0 to ctrl.ControlCount -1 do begin
      cap := '';
      if SearchingCaption then begin
        if ctrl.Controls[i] is TLabel then
          cap := TLabel(ctrl.Controls[i]).Caption
        else if ctrl.Controls[i] is TwwRadioGroup then
          cap := TwwRadioGroup(ctrl.Controls[i]).Caption
        else if ctrl.Controls[i] is TDNMSpeedButton then
          cap := TDNMSpeedButton(ctrl.Controls[i]).Caption
        else if ctrl.Controls[i] is TERPMainSwitchButton then
          cap := TERPMainSwitchButton(ctrl.Controls[i]).Caption
        else if ctrl.Controls[i] is twwCheckbox then
          cap := twwCheckbox(ctrl.Controls[i]).Caption
        else if ctrl.Controls[i] is TDBcheckbox then
          cap := TDBcheckbox(ctrl.Controls[i]).Caption;
      end else begin
        cap := Datafield(ctrl.Controls[i]);
      end;
      if (cap <> '') and Sysutils.SameText(Cap, SearchText) then begin
        result := ctrl.Controls[i];
        exit;
      end;
      cap := Trim(Cap);
      if (cap <> '') and Sysutils.SameText(Cap, SearchText) then begin
        result := ctrl.Controls[i];
        exit;
      end;

      if ctrl.Controls[i] is TWinControl then begin
        result := FindControl(TWinControl(ctrl.Controls[i]));
        if Assigned(result) then
          exit;
      end;
    end;
  end;

begin
try
  Result := False;
  if SearchingCaption then IndexOfText := cboSearch.Items.IndexOf(trim(SearchStr))
  else IndexOfText := cboFields.Items.IndexOf(trim(SearchStr));

  if (IndexOfText <0) and SearchingCaption then begin
    for ctr := low(cButtonCaptions) to high(cButtonCaptions) do begin
      IndexOfText := cboSearch.Items.IndexOf(trim(SearchStr)+ ' | ' + cButtonCaptions[ctr]);
      if IndexOfText >=0 then break;
    end;
  end;
  if (IndexOfText  <0) and (FocusControlName <> '' ) then begin

  end;

  if IndexOfText >= 0 then begin
    DelimiterPos := FastFuncs.PosEx('|', SearchStr);
    if DelimiterPos <> 0 then SearchText := Copy(SearchStr, 1, DelimiterPos - 2) else SearchText := SearchStr;

    if SearchingCaption then begin with cboSearch do
      MainButton := FindMainButton(Copy(SearchStr, DelimiterPos + 2,char_length(SearchStr) - DelimiterPos - 1));
    end else with cboFields do
      MainButton := FindMainButton(Copy(SearchStr, DelimiterPos + 2,char_length(SearchStr) - DelimiterPos - 1));

    if not Assigned(MainButton) then
       if (ctr<=  high(cButtonCaptions)) and
          (cboSearch.Items.IndexOf(trim(SearchStr)+ ' | ' + cButtonCaptions[ctr])>=0) then
       MainButton := FindMainButton(cButtonCaptions[ctr]);

    if Assigned(MainButton) then begin
      MainButton.Click;
      Application.ProcessMessages;
    end Else Exit;

    PanelIndex := 0;
    FoundControl := False;
    ImageScroll.PerformScroll(0);

    while (PanelIndex < sbPrefs.ControlCount) and (not FoundControl) do begin
      Panel := TPanel(sbPrefs.Controls[PanelIndex]);
      ctl := FindControl(Panel);
      if Assigned(ctl) then begin
        FoundControl := True;
        ControlTop := Panel.Top + ctl.Top;
        Changecontrolfont(ctl);
        ControlHeight := ctl.Height;
        NewPosition := System.Round((ControlTop - ((sbPrefs.ClientHeight - ControlHeight) / 2)) / ImageScrollHeightFactor(ImageScroll));
        if NewPosition <=0 then NewPosition := 1;// reposition to the top if negative
        NewPosition := NewPosition + 10;
        if NewPosition > imgPrefs.ClientHeight then NewPosition := imgPrefs.ClientHeight;
        if NewPosition > imgPrefs.ClientHeight then
          ImageScroll.PerformScroll(imgPrefs.ClientHeight)
        else if NewPosition > 0 then
          ImageScroll.PerformScroll(NewPosition);
         Application.ProcessMessages;
      end;

//      ControlIndex := 0;
//
//      while (ControlIndex < Panel.ControlCount) and (not FoundControl) do begin
//        if SearchingCaption then begin
//            if Panel.Controls[ControlIndex] is TLabel then
//              ControlCaption := Trim(TLabel(Panel.Controls[ControlIndex]).Caption)
//            else if Panel.Controls[ControlIndex] is TwwRadioGroup then
//              ControlCaption := Trim(TwwRadioGroup(Panel.Controls[ControlIndex]).Caption)
//            else if Panel.Controls[ControlIndex] is TDNMSpeedButton then
//              ControlCaption := Trim(TDNMSpeedButton(Panel.Controls[ControlIndex]).Caption)
//            else
//              ControlCaption := '';
//        end else begin
//           ControlCaption :=Datafield(Panel.Controls[ControlIndex]);
//        end;
//
//        if ControlCaption <> '' then begin
//          if Sysutils.SameText(ControlCaption, SearchText) then begin
//            ControlTop := Panel.Top + Panel.Controls[ControlIndex].Top;
//            Changecontrolfont(Panel.controls[controlindex]);
//            ControlHeight := Panel.Controls[ControlIndex].Height;
//            NewPosition := System.Round((ControlTop - ((sbPrefs.ClientHeight - ControlHeight) / 2)) / ImageScroll.HeightFactor);
//
//            if NewPosition > imgPrefs.ClientHeight then
//              ImageScroll.PerformScroll(imgPrefs.ClientHeight)
//            else if NewPosition > 0 then
//              ImageScroll.PerformScroll(NewPosition);
//
//            FoundControl := True;
//          end
//          else
//            Inc(ControlIndex);
//        end
//        else
//          Inc(ControlIndex);
//      end;

      Inc(PanelIndex);
    end;

    if FoundControl and (FocusControlName <> '') then begin
      TmpControl := TWinControl(fSourceForm.FindComponent(FocusControlName));
      if Assigned(TmpControl) then begin
        SetControlFocus(TmpControl);
        Result := True;
      end;
    end;
  end;
Except
  on E:Exception do begin
    logtext('Error : SearchForText -> '+E.message);
  end;
end;
end;

procedure TPreferencesGUI.PerformTextSearch(var Msg: TMessage);
begin
  SearchForText('Default Accounts Receivables Account | Sales', 'cboDefaultSales');
end;

procedure TPreferencesGUI.CancelFinish(var Msg: TMessage);
begin
  fPreventFinish := True;
end;

procedure TPreferencesGUI.CallMainSwitchFormShow;
var
  MainSwitchForm: TForm;
  MainSwitchFormShow: procedure(Sender: TObject) of object;
begin
  MainSwitchForm := TForm(FindExistingComponent('TMainSwitch2'));

  if Assigned(MainSwitchForm) then begin
    TMethod(MainSwitchFormShow).Data := MainSwitchForm;
    TMethod(MainSwitchFormShow).Code := MainSwitchForm.MethodAddress('FormShow');

    if Assigned(TMethod(MainSwitchFormShow).Code) then
      MainSwitchFormShow(nil);
  end;
end;

function TPreferencesGUI.IsButtonShown(const ButtonIndex: Integer): Boolean;
begin
  Result := True;

  if Sysutils.SameText(cButtonCaptions[ButtonIndex], 'Fixed Assets') and (not AppEnv.CompanyPrefs.UseFixedAssets) then
    Result := False
  else if Sysutils.SameText(cButtonCaptions[ButtonIndex], 'Hire') and (not AppEnv.CompanyPrefs.UseHire) then
    Result := False
  else if Sysutils.SameText(cButtonCaptions[ButtonIndex], 'Payroll') and (not AppEnv.CompanyPrefs.UsePayroll) then
    Result := False
  else if Sysutils.SameText(cButtonCaptions[ButtonIndex], 'Google') and  (not AppEnv.CompanyPrefs.UseGoogleAnalytics) then
    Result := False
  else if Sysutils.SameText(cButtonCaptions[ButtonIndex], 'Workshop') and (not AppEnv.CompanyPrefs.UseWorkshop) then
    Result := False
  else if Sysutils.SameText(cButtonCaptions[ButtonIndex], 'Workflow') and (not AppEnv.CompanyPrefs.UseWorkflow) then
    Result := False
  else if Sysutils.SameText(cButtonCaptions[ButtonIndex], 'EDI and Integration') and (GetEmployeeAccessLevel('FnIntegrationPrefs',AppEnv.Employee.LogonName) < 1) then
    Result := False;
end;

function TPreferencesGUI.IsPanelShown(const ctl: TControl): Boolean;
var
  pnl: TDNMPanel;
begin
  result := false;
  try
    if ctl is TDNMPanel then
      pnl := TDNMPanel(ctl)
    else if Assigned(ctl.Parent) and (ctl.Parent is TDNMPanel) then
      pnl := TDNMPanel(ctl.Parent)
    else
      exit;

    Result := True;

    If Result and not Pnl.Visible then
      Result := False;

    if Pnl.Category = 'For later use' then Result := False; //used to hide panels still working on
  except
    on e: exception do begin
//      showmessage(Panel.ClassName + '   ' + Panel.Name + '    ' + e.Message);
      result:= false;
    end;
  end;
end;

procedure TPreferencesGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if fPreventFinish then begin
    self.actSaveExecute(nil);
    if fPreventFinish then canclose := False;
    fbIsformClosing:= False;
    Exit;
  end;

  canclose:= true;

end;

initialization
  RegisterClassOnce(TPreferencesGUI);
finalization
  UnRegisterClass(TPreferencesGUI);
end.



