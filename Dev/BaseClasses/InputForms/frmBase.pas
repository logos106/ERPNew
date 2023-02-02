unit frmBase;
{$I ERP.inc}
interface

uses
  Windows, Messages, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwclearbuttongroup, Mask, wwdbedit, ExtCtrls , Contnrs , DelayLib ,db,
  DNMPanel, Menus, AdvMenus, DNMSpeedButton  , busobjbase, sysutils;

type

  TfrmBaseGUI = class(TForm)
    tmrProcessMessage: TTimer;
    lblSkingroupMsg: TLabel;
    tmrdelay: TTimer;
    popSpelling: TPopupMenu;
    mnuSpelling: TMenuItem;
    mnuSpellingOptions: TMenuItem;
    shapehint: TShape;
    shapehintextra1: TShape;
    Undo1: TMenuItem;
    Line1: TMenuItem;
    cut_1: TMenuItem;
    copy_1: TMenuItem;
    Paste_1: TMenuItem;
    delete_1: TMenuItem;
    Line2: TMenuItem;
    tmrdelayMsg: TTimer;
    shapehintextra2: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrProcessMessageTimer(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure mnuSpellingClick(Sender: TObject);
    procedure mnuSpellingOptionsClick(Sender: TObject);
    procedure HandlePopupClick(Sender: TObject);
    procedure tmrdelayMsgTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private

    NoteCaption:String;
    Notecolor:TColor;
    Notevisible:Boolean;
    noteEnabled:Boolean;
    NoteDblclick :TNotifyEvent;


    fAllowTABKeyEvent: boolean;
    fDisableCount: integer;
    fTranslateFormLanguage: boolean;
    fDelayProcedureList: TObjectList;
    fsCallingActionName: String;
    fCallingAction : TObject;
    //procedure Initialise;
    //procedure ResetHelpContext;
{$IFDEF GET_HELPCONTEX_INFO}
    procedure CheckHelpContexts;
{$ENDIF}
    procedure CMDialogKey( Var msg: TCMDialogKey );  message CM_DIALOGKEY;
    procedure SetAllowTABKeyEvent(const Value: boolean);
    Procedure FreeLcList;
    Procedure FreePhoneButtons;
    procedure initlbltimer(lbl: TLabel);overload;
    procedure initlbltimer(btn: TDnmSpeedbutton;lbl: TLabel);overload;
    procedure initlbltimer(pnl:TDnMPanel;lbl: TLabel);overload;
    procedure dblclicktoHide(Sender :TObject);
    procedure ShowSkinGroup;
    procedure DoOnTimer(Sender: TObject);
    {$HINTS OFF}
    procedure closeWithDelay;Overload;
    {$HINTS ON}
    procedure InitComponentDefaultProperties;Overload;
    procedure SpellingCheckAdd;
    procedure SpellingCheckRemove;
    Procedure CaptureMenuEvents;
    function getFormID: Integer;
    function getDisplayCaption: String;
    //function GetmenuEventRec(var MenuEventRec: TMenuEventRec; Const Name: string; MenuEventType: TMenuEventType; const RemoveFromList: boolean = false): Boolean;

  Protected
    lbltimerMsg:TLabel;
    pnlTimerMsg:TDnMPanel;
    btntohighLight : TDnmSpeedbutton;
    HighlightedCurrentComponent:TControl;
    HighlightedExtraCurrentComponent1:TWinControl;
    HighlightedExtraCurrentComponent2:TWinControl;
    lbldelay :TLabel;


    function ignorelogInuseform:boolean;virtual;
//    function Translation(Value:String):String;
    Procedure AfterFormShow; virtual;
    procedure OnFormShow(Sender: TObject);Virtual;
    property TranslateFormLanguage: boolean read fTranslateFormLanguage write fTranslateFormLanguage;
    function EnglishCaption(comp:Tcomponent):String;
    Function MakePhonebuttonName(const EdtName:String):String;
    Procedure AddPhoneCallbutton(edtPhone:TCustomEdit);
    Procedure logInuseform;virtual;
    Procedure ShowStatus(const Value :String);Virtual;
    procedure SleepUntilFormshown(const formname: String);
    procedure SetDefaultColor;virtual;
    Procedure Makeitcentralized;virtual;
    procedure DoDelayObjectProcedure(Proc: TObjectProcedure;      DelayMilliSecs: integer; aDescription :String='');
    procedure CloseWithDelay(const Seconds :Integer );Overload;
    procedure DoTranslate(ds: TDataset);Overload;
    function DoTranslate(Value:String):String;Overload;
    Procedure DoExtraTranslation;virtual;
    Procedure ShowControlhints;virtual;
    procedure CommitAndNotify;virtual;
    Function isModalForm:Boolean;
    Function GuiprefName:String;virtual;
    procedure ApplyPreferenceNames;Virtual;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); Virtual;
    Function MenuItemByname(PopupMenu:TAdvPopupMenu; Caption:String):TMenuitem;
    function ReadControlDisplayName(Sender:TObject):String;virtual;

  public
    LcList                : TList;
    menuEventList : TList;
    fdLogDatetime :TDateTime;
    IsFormshown :Boolean;
    Isclosing:Boolean;

    Procedure Widerform(NewWidth :Integer =1200);virtual;
    Procedure TallerForm(NewHeight :Integer =700);virtual;
    Procedure AfterTranslate; virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AllowTABKeyEvent: boolean read fAllowTABKeyEvent write SetAllowTABKeyEvent;
    procedure DisableForm; Virtual;
    procedure EnableForm;  Virtual;
    procedure TimerMsg(lbl:TLabel; const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);Overload;Virtual;
    procedure TimerMsg(pnl: TDNMPanel; lbl:TLabel; const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);Overload;Virtual;
    procedure TimerMsg(btn:TDnmspeedbutton; lbl:TLabel; const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);Overload;Virtual;
    procedure DoTranslateFormLanguage;
    procedure ReloadFormColor;
    Procedure hideTimerMsg;
    Procedure HideHighlightControl;
    Procedure HideHighlightExtraControl1;
    Procedure HideHighlightExtraControl2;
    Procedure HighlightControl(Sender:TControl = nil);
    Procedure HighlightextraControl1(Sender:TWinControl = nil);
    procedure HighlightextraControl2(Sender: TWinControl);
    function GetComponentForHelpcontextID(Const ComponentClassName: string; ahelpcontextID :Integer; var errMsg:String): TComponent;
    Property FormID:Integer read getFormID;
    Procedure ShowControlhint(Control :TControl; ControlHint :String);
    Property DisplayCaption:String read getDisplayCaption;
    function ControlDisplayName(Sender:TObject):String;
    function heirarchyname(Control:TComponent):String;
    procedure InitComponentDefaultProperties(acomp :TWinControl);Overload;
  Published
    Property CallingActionName : String read fsCallingActionName write fsCallingActionName;
    Property CallingAction :TObject read fCallingAction write fCallingAction;
  end;

implementation
uses
  wwcheckbox,
{$IFDEF GET_HELPCONTEX_INFO}
  DataTreeObj,FastFuncs,
{$ENDIF}
  wwradiogroup, AppEnvironment, wwdblook, wwdbgrid,
  AppContextObj, LanguageTranslationObj, frmPhoneButton, InuseFormslib,
  CommonLib , Clipbrd, shader, MAIN , LogLib, datSpelling, ad3SpellBase,
  DBCtrls, ad3MainDictionary, SystemLib, tcConst, WorkflowObj, EMHelper,
  TimedHint, MenuEvents, BusObjConst, ERPErrorEmailUtils, dateutils,
  ImageDLLLib , DNMAction;

{$R *.dfm}

function TfrmBaseGUI.ReadControlDisplayName(Sender: TObject): String;
begin
  result := '';
end;

procedure TfrmBaseGUI.ReloadFormColor;
begin
  SetDefaultColor;
end;

(*procedure TfrmBaseGUI.ResetHelpContext;
begin
//  Self.HelpType := htContext;
//  Self.HelpFile := Application.HelpFile;
end;*)

procedure TfrmBaseGUI.SetAllowTABKeyEvent(const Value: boolean);
begin
  fAllowTABKeyEvent:= value;
end;

procedure TfrmBaseGUI.DoTranslate(ds:TDataset);
begin
  TLanguageTranslationObj.Inst.DoTranslate(ds , TLanguageTranslationObj.Inst.UserLanguageId);
end;
function TfrmBaseGUI.DoTranslate(Value:String):String;
begin
  Result := TLanguageTranslationObj.Inst.DoTranslate(Value , TLanguageTranslationObj.Inst.UserLanguageId, []);
end;
procedure TfrmBaseGUI.DoTranslateFormLanguage;
begin
  TLanguageTranslationObj.Inst.CleanLc(Self);
  TLanguageTranslationObj.Inst.DoTranslate(Self, TLanguageTranslationObj.Inst.UserLanguageId);
  TLanguageTranslationObj.Inst.TranslateGrids(Self);
  DoExtraTranslation;
end;



{$IFDEF GET_HELPCONTEX_INFO}
procedure TfrmBaseGUI.CheckHelpContexts;
var
  Tree: TDataTree;
  DPR: TStringList;
  MaxContextId: integer;
  DefaultPath:String;

  procedure GetUnitName;
  var
    x: integer;
    sl: TStringList;
    s: string;
  begin
    if DPR.Count <> 0 then begin
      sl:= TStringList.Create;
      try
        for x:= 0 to DPR.Count -1  do begin
          FastFuncs.Split(Trim(DPR[x]),' ',sl);
          if (sl.Count = 4) and (FastFuncs.PosEx('{' + self.Name + '}',sl[3]) = 1) then begin
            s:= StringReplace(sl[2],'''','',[rfReplaceAll]);
            Tree[self.Name + '.UnitName'].AsString:= s;
            Tree[self.Name + '.FormName'].AsString:=
              StringReplace(s,'.pas','.dfm',[rfIgnoreCase]);
            break;
          end;
        end;
      finally
        sl.Free;
      end;
    end;
  end;


  function ParentPath(ctrl: TControl): string;
  var
    prnt: TWinControl;
  begin
    result:= ctrl.Name;
    prnt:= ctrl.Parent;
    if result <> '' then begin
      while Assigned(prnt) do begin
        if prnt.Name = '' then
          break;
        if prnt.ClassName = 'TwwDBGrid' then begin
          result:= '';
          break;
        end;
        result:= prnt.Name + '.' + result;
        prnt:= prnt.Parent;
      end;
    end;
  end;

  procedure ScanChildComponents(comp: TComponent);
  var
    x: integer;
    s: string;
  begin
//    log('Checking: ' + comp.name);
//    if (Assigned(comp.Owner) and (comp.Owner.ClassName = 'TwwDBGrid')) or
//      ((comp is TControl) and Assigned(TControl(comp).Parent) and
//      (TControl(comp).Parent.ClassName = 'TwwDBGrid')) then begin
//      exit;
//    end;
//    if (comp is TControl) and Assigned(TControl(comp).Parent) then
//      log(comp.name + ' Parent: ' + TControl(comp).Parent.ClassName + '  ' + TControl(comp).Parent.Name);
//    if Assigned(comp.Owner) then
//      log(comp.name + ' Owner: ' + comp.Owner.ClassName + '  ' + comp.Owner.name);
    for x:= 0 to comp.ComponentCount -1 do begin
      if comp.Components[x] is TComponent then begin

        if comp.Components[x] is TControl then begin
          s:= ParentPath(TControl(comp.Components[x]));
//          Log(s);
          if s <> '' then begin
            Tree[s + '.HelpContext'].AsInteger :=
              TControl(comp.Components[x]).HelpContext;
            if TControl(comp.Components[x]).HelpContext > MaxContextId then
              MaxContextId:= TControl(comp.Components[x]).HelpContext;
            Tree[s + '.ClassName'].AsString :=
              comp.Components[x].ClassName;
          end;
        end
        else begin
        end;
        if (comp.Components[x].Name <> '') then begin
          ScanChildComponents(TComponent(comp.Components[x]))
        end;
      end;
    end;
  end;

begin
  Tree:= TDataTree.Create;
  DPR:= TStringList.Create;
  try
    MaxContextId:= 0;
    DefaultPath := SystemLib.ExeDir+'AppContexts';
    ForceDirectories(DefaultPath);
    DefaultPath := DefaultPath+'\'+self.Name+'.xml';
    if FileExists(DefaultPath) then
      Tree.LoadFromFile(DefaultPath);

    if Tree.RootNode.NodeName = '' then
      Tree.RootNode.NodeName:= 'AppContexts';
    if FileExists('ERP.dpr') then
      DPR.LoadFromFile('ERP.dpr');

    GetUnitName;
    Tree[self.Name + '.HelpContext'].AsInteger:= self.HelpContext;
    MaxContextId:= self.HelpContext;
    ScanChildComponents(self);
    Tree[self.Name + '.MaxHelpContext'].AsInteger:= MaxContextId;

  finally
    if Tree.Dirty then
      If not FileExists(DefaultPath) then
        Tree.SaveToFile(DefaultPath);
    Tree.Free;
    DPR.Free;
  end;
end;
{$ENDIF}

procedure TfrmBaseGUI.AfterformShow;
begin
//  TLanguageTranslationObj.Inst.CleanLc(Self);
  IsFormshown := True;
  ApplyPreferenceNames;
end;

procedure TfrmBaseGUI.AfterTranslate;
begin
//decendants will override if required
end;

procedure TfrmBaseGUI.CaptureMenuEvents;
begin
  WorkflowActions.CaptureMenuEvents(Self);
end;


procedure TfrmBaseGUI.CloseWithDelay;
begin
  Self.Close;
end;

procedure TfrmBaseGUI.CloseWithDelay(const Seconds: Integer);
begin
  DoDelayObjectProcedure(CloseWithDelay,Seconds, Self.classname +'.CloseWithDelay');
end;

procedure TfrmBaseGUI.Makeitcentralized;
begin
  Top := ((MainForm.ClientHeight - MainForm.MainToolBar.Height - MainForm.StatusBar.Height) - Self.Height) div 2;
  Left := (MainForm.ClientWidth - Self.width) div 2;
end;

procedure TfrmBaseGUI.Widerform(NewWidth :Integer =1200);
begin
  if (Self.width <NewWidth) or (Windowstate = wsMaximized) then
    Self.width := NewWidth;
  Makeitcentralized;
end;

Procedure TfrmBaseGUI.TallerForm(NewHeight :Integer =700);
begin
  Self.height := NewHeight;
  Makeitcentralized;
end;

procedure TfrmBaseGUI.CMDialogKey(var msg: TCMDialogKey);
begin
  if (msg.Charcode = VK_TAB) then begin
    if ((ActiveControl is TwwDbLookupCombo) and (ActiveControl.Tag = 1)) then begin
      if not AllowTABKeyEvent then
        inherited;

    end
    else
      inherited;
  end
  else
    inherited;

//  if (msg.Charcode <> VK_TAB) or ((msg.Charcode = VK_TAB) and (not AllowTABKeyEvent)) then
//   inherited;
end;

procedure TfrmBaseGUI.CommitAndNotify;
begin

end;

function TfrmBaseGUI.ControlDisplayName(Sender: TObject): String;
var
  s:String;
begin
  if sender = nil then sender := self;
  try
  REsult := ReadControlDisplayName(Sender);
  if result <> '' then exit;
  if sender is TComponent then begin
    s:= Tcomponent(Sender).Name;
           if sender is TDnmSpeedbutton then Result := ReplaceStr(TDnmSpeedbutton(Sender).Caption , '&', '')
      else if sender is TCheckBox       then Result := ReplaceStr(TCheckBox(Sender).Caption       , '&', '')
      else if sender is TdbCheckBox     then Result := ReplaceStr(TdbCheckBox(Sender).Caption     , '&', '')
      else if sender is TwwCheckBox     then Result := ReplaceStr(TwwCheckBox(Sender).Caption     , '&', '')
      else if sender is TDnmAction      then Result := ReplaceStr(TDnmAction(Sender).Caption      , '&', '')
      else if sender is TMenuitem       then Result := ReplaceStr(TMenuitem(Sender).Caption       , '&', '')
      else if sender is TERPMainSwitchMovingButton       then Result := ReplaceStr(TERPMainSwitchMovingButton(Sender).Caption       , '&', '')
      else if sametext(s, 'cboAccount') then result := 'Account'
      else if sametext(s, 'cboClientR') then result := 'Customer Name'
      else if sametext(s, 'cboProductR') then result := 'Product Name'
      else if pos(uppercase('cbo'), uppercase(s))>0 then result := copy(s, length('cbo')+1, length(s))
      else if pos(uppercase('edt'), uppercase(s))>0 then result := copy(s, length('edt')+1, length(s))
      else if pos(uppercase('grd'), uppercase(s))>0 then result := copy(s, length('grd')+1, length(s));
      if result = '' then Result := s;
  end;
  Except
    // kill the exception
  end;
end;

constructor TfrmBaseGUI.Create(AOwner: TComponent);
begin
  fdLogDatetime :=now;
  //HintWindowClass := TERPhindWindow;
  fTranslateFormLanguage := true;
  AllowTABKeyEvent:= false;
  MenuEventList:= TList.Create;
  inherited Create(AOwner);
end;

procedure TfrmBaseGUI.dblclicktoHide(Sender: TObject);
begin
  tmrProcessMessageTimer(tmrProcessMessage);
end;

function TfrmBaseGUI.EnglishCaption(comp: Tcomponent): String;
var
  LCI :pLc;
begin
  result := '';
  if Comp = nil then exit;
  try
    LCI:= TLanguageTranslationObj.Inst.LcItem(Self , comp);
    if LCI = nil then begin

    end
    else begin
      REsult := LCI^.LCCaption;
    end;
    if result = '' then
      if comp is TDNMSpeedButton then
        result := TDNMSpeedButton(Comp).Caption
      else if comp is TERPMainSwitchMovingButton then
        result := TERPMainSwitchMovingButton(Comp).Caption
      else if comp is TERPMainSwitchButton then
        result := TERPMainSwitchButton(Comp).Caption;
  Except
    if comp is TDNMSpeedButton then result := TDNMSpeedButton(Comp).Caption;
  end;
end;

//function TfrmBaseGUI.Translation(Value: String): String;
//begin
//  result := TLanguageTranslationObj.Inst.Translation(Value, appenv.RegionalOptions.LanguageId);
//end;

procedure TfrmBaseGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  self.fDisableCount:= 0; { .. to stop form from being re-enabled when closing }
end;

procedure TfrmBaseGUI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Isclosing :=  CanClose;
end;

procedure TfrmBaseGUI.FormCreate(Sender: TObject);
begin
  fsCallingActionName := '';
  fCallingAction := nil;
  Logformname(self, classnameis('TMainForm'));
  lbldelay := nil;
  IsFormshown := false;
  {$IFDEF GET_HELPCONTEX_INFO}
  CheckHelpContexts;
  {$ENDIF}

  CaptureMenuEvents;
  LcList:= nil;
  Loginuseform;
  fDisableCount:= 0;
  lbltimerMsg:= nil;
  pnlTimerMsg:= nil;
  btntohighLight := nil;
  fDelayProcedureList:= TObjectList.Create(true);
  InitComponentDefaultProperties;
  SpellingCheckAdd;

end;
procedure TfrmBaseGUI.ApplyPreferenceNames;
var
  index:Integer;
begin
  try
      for index := 0 to ComponentCount-1 do begin
        if components[index] is Tlabel then begin
            if AppEnv.DefaultClass.EquipmentName <> '' then
                if pos('Equipment' , TLabel(components[index] ).caption)> 0 then TLabel(components[index] ).caption:= replaceStr(TLabel(components[index] ).caption , 'Equipment' , AppEnv.DefaultClass.equipmentName);

            if AppEnv.DefaultClass.HireName <> '' then
                if pos('Hire' , TLabel(components[index] ).caption)> 0 then TLabel(components[index] ).caption:= replaceStr(TLabel(components[index] ).caption , 'Hire' , AppEnv.DefaultClass.HireName);
        end else if components[index] is TSplitter then begin
           ShowControlhint(TSplitter(components[index]) , 'Drag to Re-size');
        end;
      end;
  Except

  end;
end;

procedure TfrmBaseGUI.FormDblClick(Sender: TObject);
begin
  if devmode then begin
    MessageDlgXP_Vista(self.classname, mtinformation, [mbOK], 0);
    CopyToClipboard(Self.Classname);
  end;
end;

procedure TfrmBaseGUI.FormDestroy(Sender: TObject);
begin
  lbltimerMsg:= nil;
  pnlTimerMsg:= nil;
  btntohighLight := nil;
  FreePhoneButtons;
  FreeLcList;
  FreeAndNil(lcList);
  FreeAndNil(fDelayProcedureList);
  if not(ignorelogInuseform) then
    DeleteLogInuse(Integer(Self) , Self.Classname);
  SpellingCheckRemove;

  if Assigned(fTimedHint) then  fTimedHint.HidehintformForm(Self);
  inherited;
end;

procedure TfrmBaseGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
begin
  if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_check4FieldErrorMsg) then begin
    //Mainform.TimerMsg( Sender.check4FieldErrorMsg , 20);
  end
  else if (Eventtype = BusObjEvent_UserErrorMessage) then
    CommonLib.MessageDlgXP_Vista(Value,mtError,[mbOk],0)
  else if (Eventtype = BusObjEvent_UserWarningMessage) then
    CommonLib.MessageDlgXP_Vista(Value,mtWarning,[mbOk],0)
  else if (Eventtype = BusObjEvent_UserInfoMessage) then
    CommonLib.MessageDlgXP_Vista(Value,mtInformation,[mbOk],0)
end;

procedure TfrmBaseGUI.DoDelayObjectProcedure(Proc: TObjectProcedure;
  DelayMilliSecs: integer; aDescription :String='');
var
  Rec: TDelayProcedureRec;
begin
  tmrdelay.Enabled:= true;
  Rec:= TDelayProcedureRec.Create;
  Rec.Proc:= Proc;
  Rec.ExecTime:= now + (DelayMilliSecs * (1/24/60/60/1000));
  Rec.Description := aDescription;
  fDelayProcedureList.Add(Rec);
  tmrdelay.OnTimer:= DoOnTimer;
  tmrdelayMsg.Enabled:= true;
end;
procedure TfrmBaseGUI.DoExtraTranslation;
begin
//descendants will override if required
end;

procedure TfrmBaseGUI.DoOnTimer(Sender: TObject);
var
  x: integer;
begin
  x:= 0;
  TTimer(Sender).Enabled:= false;
  try
    while x < fDelayProcedureList.Count do begin
      if TDelayProcedureRec(fDelayProcedureList[x]).ExecTime <= now then begin
        TDelayProcedureRec(fDelayProcedureList[x]).Proc;
        if x < fDelayProcedureList.Count then
          fDelayProcedureList.Delete(x)
        else
          Continue;
      end else begin
        Inc(x);
      end;
    end;
  finally
    if fDelayProcedureList.Count > 0 then begin
      TTimer(Sender).Enabled:= true;
    end;
  end;
end;

procedure TfrmBaseGUI.ShowControlhint(Control: TControl; ControlHint: String);
begin
  Control.Hint := trim(controlhint)+NL;
  control.ShowHint := trim(Controlhint) <> '';
end;

procedure TfrmBaseGUI.ShowControlhints;
begin
//
end;

Procedure TfrmBaseGUI.ShowSkinGroup;
var
  s:String;
begin
  s:=AppEnv.ColourPrefs.GetSkinsGroup(self.ClassName);
  if s = '' then begin
    s:= Self.ClassName +' Skins group not found';
  end;
  lblSkingroupMsg.Height := 24;
  TimerMsg(lblSkingroupMsg , s);
end;
procedure TfrmBaseGUI.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if Shift = [ssShift,ssCtrl] then begin
    if Key = vk_f7 then begin
      AppContext['WebHelpEntry'].VarByname['NewWebHelpEntry'] := 'T';
      Application.HelpCommand(HELP_CONTEXT , Screen.activecontrol.helpcontext);
      exit;
    end;
  end;
  if Shift = [ssShift,ssCtrl] then begin
    if Key = vk_f8 then begin
      ShowSkingroup;
      Exit;
    end;
  end;
  if Shift = [ssShift,ssCtrl] then begin
    if Key = vk_return then begin
      if devmode then begin
        Application.Terminate;
        Exit;
      end;
    end;
  end;

end;


(*procedure TfrmBaseGUI.Initialise;
begin
  ResetHelpContext;
end;*)


procedure TfrmBaseGUI.logInuseform;
begin
  if ignorelogInuseform then exit;
  LogInuse(integer(Self) , Self.Classname);
end;

function TfrmBaseGUI.MakePhonebuttonName(const EdtName: String): String;
begin
  Result := 'Phonebutton'+edtName;
  while Findcomponent(result)<> nil do
    result := result +'1';
end;
procedure TfrmBaseGUI.mnuSpellingClick(Sender: TObject);
var
  memo: TDbMemo;

  function FocusedMemo(comp: TComponent): TDBMemo;
  var
    x: integer;
  begin
    result := nil;
    for x := 0 to comp.ComponentCount -1 do begin
      if (comp is TDBMemo) and TDBMemo(comp.Components[x]).Focused then begin
        Result := TDBMemo(comp.Components[x]);
        exit;
      end
      else begin
        result := FocusedMemo(comp.Components[x]);
      end;
    end;
  end;

begin
  inherited;
  memo := FocusedMemo(self);
  if Assigned(memo) then
    Spelling.AddictSpell.CheckWinControl(memo,ctSmart);
end;

procedure TfrmBaseGUI.mnuSpellingOptionsClick(Sender: TObject);
begin
  Spelling.AddictSpell.Setup;
end;

procedure TfrmBaseGUI.AddPhoneCallbutton(edtPhone: TCustomEdit);
var
  PhoneButton:TPhoneButton;
begin
  PhoneButton           := TPhoneButton.Create(Self);
  PhoneButton.name      := MakePhonebuttonname(edtPhone.name);
  PhoneButton.Parent    := edtPhone.Parent;
  PhoneButton.taborder  := edtPhone.taborder+1;
  PhoneButton.Width     := edtPhone.Height;
  PhoneButton.Height    := edtPhone.Height;
  edtPhone.width        := edtPhone.Width - PhoneButton.width;
  PhoneButton.Left      := edtPhone.Left +edtPhone.width;
  PhoneButton.top       := edtPhone.Top;
  PhoneButton.PhoneEdit := edtPhone;
end;

procedure TfrmBaseGUI.OnFormShow(Sender: TObject);
begin
  if TranslateFormLanguage then
    DoTranslateFormLanguage;
  ShowControlhints;
end;

procedure TfrmBaseGUI.FormShow(Sender: TObject);
begin
  inherited;
//  Initialise;
(*  if DEvmode then
    try
      ShowSkinGroup;
    Except
      //kill the exception
    end;*)
end;

procedure TfrmBaseGUI.FreeLcList;
begin
  if Assigned(fLanguageTranslationObj) then
    TLanguageTranslationObj.Inst.FreeLcList(Self);
end;

procedure TfrmBaseGUI.FreePhoneButtons;
var
  ctr:Integer;
begin
  for ctr:= componentcount-1 downto 0 do
    if components[ctr] is TPhoneButton then begin
      try
        Components[ctr].free;
      Except
        // kill the exception if any
      end;
    end;
end;

function TfrmBaseGUI.GetComponentForHelpcontextID(const ComponentClassName: string; ahelpcontextID: Integer; var errMsg:String): TComponent;
var
  ctr:Integer;
  no:Integer;
  s:String;
begin
  result := nil;
  no :=0;
  s:= '';
  for ctr := 0 to componentcount-1 do
    if components[ctr] is TControl then
    if Sametext(components[ctr].classname ,  ComponentClassName) and ( TControl(components[ctr]).helpcontext = ahelpcontextID) then begin
      result :=components[ctr];
      no := no+1;
      if s<> '' then s:= s+',' ;s:= s +    components[ctr].Name;
    end;
  if no > 1 then begin
    result := nil;
    errMsg := errMsg +NL+inttostr(no) + ' components found in the ' + Self.classname +' with the same Helpcontext ID : ' + inttostr(ahelpcontextID)+':' +s;
  end else if no = 0 then begin
    errMsg := errMsg +NL+'Conponent NOT found in the ' + Self.classname +' with Helpcontext ID : ' + inttostr(ahelpcontextID);
  end;
end;

function TfrmBaseGUI.getDisplayCaption: String;
begin
  Result := Caption;
  Result := replacestr(result, ACC_LVL_MSG_1,'');
  Result := replacestr(result, ACC_LVL_MSG_2,'');
  Result := replacestr(result, ACC_LVL_MSG_3,'');
  Result := replacestr(result, ACC_LVL_MSG_4 ,'');
  Result := replacestr(result, ACC_LVL_MSG_5,'');
  Result := replacestr(result, ACC_LVL_MSG_6 ,'');
end;

function TfrmBaseGUI.getFormID: Integer;
begin
  result := AppEnv.AccessLevels.GetFormID(Self.ClassName);
end;

function TfrmBaseGUI.GuiprefName: String;
begin
  REsult := Self.classname;
end;

procedure TfrmBaseGUI.HandlePopupClick(Sender: TObject);
function MenuCaption(Const value:String):String;
begin
  Result := value;
  result := StringReplace(result, '&&', '||',[rfReplaceAll,rfIgnoreCase]);
  result := StringReplace(result, '&', '',[]);
  result := StringReplace(result, '||', '&&',[rfReplaceAll,rfIgnoreCase]);
end;
begin
try
  if ActiveControl= nil then exit;

  if Sender is TMenuItem then begin
    with TMenuItem(Sender) do begin
           if Sysutils.SameText(MenuCaption(Caption), 'Undo'      ) then SendMessage(ActiveControl.Handle, WM_UNDO  , 0, 0)
      else if Sysutils.SameText(MenuCaption(Caption), 'Cut'       ) then SendMessage(ActiveControl.Handle, WM_CUT   , 0, 0)
      else if Sysutils.SameText(MenuCaption(Caption), 'Copy'      ) then SendMessage(ActiveControl.Handle, WM_COPY  , 0, 0)
      else if Sysutils.SameText(MenuCaption(Caption), 'Paste'     ) then SendMessage(ActiveControl.Handle, WM_PASTE , 0, 0)
      else if Sysutils.SameText(MenuCaption(Caption), 'Delete'    ) then SendMessage(ActiveControl.Handle, WM_CLEAR , 0, 0)
      else if Sysutils.SameText(MenuCaption(Caption), 'Select All') then SendMessage(ActiveControl.Handle, EM_SETSEL, 0, -1);
    end;
  end;
Except
  // kill the exception if any
end;
end;
function TfrmBaseGUI.heirarchyname(Control: TComponent): String;
begin
  REsult := commonlib.heirarchyname(Control);
  (*REsult := Control.Name;
  if (Control is TWincontrol) and Assigned(TWincontrol(Control).Parent) then
    result :=heirarchyname(TWincontrol(Control).Parent)+'.'+result
  else if Assigned(Control.Owner) and (Control.Owner is TWincontrol) then
    result := heirarchyname(TWincontrol(Control.Owner))+'.'+result;*)
end;
Procedure TfrmBaseGUI.HideHighlightExtraControl1;
begin
  try
    shapehintextra1.Visible := False;
    shapehintextra1.Parent := Self;
    if Assigned(HighlightedExtraCurrentComponent1) then HighlightedExtraCurrentComponent1.invalidate;
    HighlightedExtraCurrentComponent1:= nil;
  Except
    on E:Exception do begin
    end;
  end;
end;
Procedure TfrmBaseGUI.HideHighlightExtraControl2;
begin
  try
    shapehintextra2.Visible := False;
    shapehintextra2.Parent := Self;
    if Assigned(HighlightedExtraCurrentComponent2) then HighlightedExtraCurrentComponent2.invalidate;
    HighlightedExtraCurrentComponent2:= nil;
  Except
    on E:Exception do begin
    end;
  end;
end;
procedure TfrmBaseGUI.HideHighlightControl;
begin
  try
    shapehint.Visible := False;
    shapehint.Parent := Self;
    if Assigned(HighlightedCurrentComponent) then HighlightedCurrentComponent.invalidate;
    HighlightedCurrentComponent:= nil;
  Except
    on E:Exception do begin
      if devmode then
        //MessageDlg(E.message, mtWarning, [mbOK], 0);
    end;
  end;

end;

procedure TfrmBaseGUI.hideTimerMsg;
begin
  tmrProcessMessageTimer(tmrProcessMessage);
end;


procedure TfrmBaseGUI.HighlightControl(Sender: TControl);
begin
  if Assigned(HighlightedCurrentComponent) then HighlightedCurrentComponent.invalidate;
  HighlightedCurrentComponent := Sender;
  shapehint.Visible           := False;
  if HighlightedCurrentComponent = nil then exit;
  shapehint.Parent  := HighlightedCurrentComponent.Parent;
  shapehint.Left    := HighlightedCurrentComponent.Left-3;
  shapehint.Width   := HighlightedCurrentComponent.width+6;
  shapehint.top     := HighlightedCurrentComponent.top-3;
  shapehint.height  := HighlightedCurrentComponent.height+6;
  shapehint.visible := True;
  shapehint.SendToBack;
  shapehint.Anchors :=HighlightedCurrentComponent.Anchors;
  if HighlightedCurrentComponent is TDNMSpeedButton then shapehint.Shape := stRoundRect else shapehint.Shape := stRectangle;
  HighlightedCurrentComponent.Invalidate;
end;

procedure TfrmBaseGUI.HighlightextraControl1(Sender: TWinControl);
begin
  if Assigned(HighlightedExtraCurrentComponent1) then HighlightedExtraCurrentComponent1.invalidate;
  HighlightedExtraCurrentComponent1:=Sender;
  shapehintextra1.Visible := False;
  if HighlightedExtraCurrentComponent1 = nil then exit;
  shapehintextra1.Parent:= HighlightedExtraCurrentComponent1.Parent;
  shapehintextra1.Left := HighlightedExtraCurrentComponent1.Left-3;
  shapehintextra1.Width := HighlightedExtraCurrentComponent1.width+6;
  shapehintextra1.top := HighlightedExtraCurrentComponent1.top-3;
  shapehintextra1.height := HighlightedExtraCurrentComponent1.height+6;
  shapehintextra1.visible := True;
  shapehintextra1.Anchors :=HighlightedExtraCurrentComponent1.Anchors;
  if HighlightedExtraCurrentComponent1 is TDNMSpeedButton then shapehintextra1.Shape := stRoundRect else shapehintextra1.Shape := stRectangle;
  HighlightedExtraCurrentComponent1.Invalidate;
end;
procedure TfrmBaseGUI.HighlightextraControl2(Sender: TWinControl);
begin
  if Assigned(HighlightedExtraCurrentComponent2) then HighlightedExtraCurrentComponent2.invalidate;
  HighlightedExtraCurrentComponent2:=Sender;
  shapehintextra2.Visible := False;
  if HighlightedExtraCurrentComponent2 = nil then exit;
  shapehintextra2.Parent:= HighlightedExtraCurrentComponent2.Parent;
  shapehintextra2.Left := HighlightedExtraCurrentComponent2.Left-3;
  shapehintextra2.Width := HighlightedExtraCurrentComponent2.width+6;
  shapehintextra2.top := HighlightedExtraCurrentComponent2.top-3;
  shapehintextra2.height := HighlightedExtraCurrentComponent2.height+6;
  shapehintextra2.visible := True;
  shapehintextra2.Anchors :=HighlightedExtraCurrentComponent2.Anchors;
  if HighlightedExtraCurrentComponent2 is TDNMSpeedButton then shapehintextra2.Shape := stRoundRect else shapehintextra2.Shape := stRectangle;
  HighlightedExtraCurrentComponent2.Invalidate;
end;

function TfrmBaseGUI.ignorelogInuseform: boolean;
begin
  REsult := False;
end;
destructor TfrmBaseGUI.Destroy;
begin
  FreeMenuEventList(MenuEventList);
  FreeandNil(MenuEventList);
  inherited;
end;

procedure TfrmBaseGUI.DisableForm;
begin
  self.Enabled:= false;
  Inc(fDisableCount);
end;

procedure TfrmBaseGUI.EnableForm;
begin
  if fDisableCount > 0 then begin
    Dec(fDisableCount);
    if (fDisableCount = 0) then begin
      try
        self.Enabled:= true;
      except
        { in case form has been closed / destroyed }
      end;
    end;
  end;
end;
procedure TfrmBaseGUI.TimerMsg(pnl: TDNMPanel; lbl:TLabel; const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);
begin
  initlbltimer(pnl,lbl);
  pnl.bringtofront;
  TimerMsg(lbl,Value,Secondstoshow,msgColor);
end;
procedure TfrmBaseGUI.TimerMsg(btn:TDnmspeedbutton; lbl:TLabel; const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);
begin
  initlbltimer(btn,lbl);
  TimerMsg(lbl,Value,Secondstoshow,msgColor);
end;

procedure TfrmBaseGUI.TimerMsg(lbl:TLabel; const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);
begin
  initlbltimer(lbl);
  lbltimerMsg.Font.Color := msgColor;
  ShowStatus(Value);
  tmrProcessMessage.Enabled:= False;
  tmrProcessMessage.Interval :=  Secondstoshow * 1000;
  tmrProcessMessage.Enabled:= True;
end;
procedure TfrmBaseGUI.initlbltimer(pnl:TDnMPanel;lbl: TLabel);
begin
    if pnltimerMsg <> nil then exit;
    pnltimerMsg:= pnl;
    initlbltimer(lbl);
end;
procedure TfrmBaseGUI.initlbltimer(btn: TDnmSpeedbutton;lbl: TLabel);
begin
    if btntohighLight <> nil then exit;
    btntohighLight:= btn;
    initlbltimer(lbl);

end;
procedure TfrmBaseGUI.initlbltimer(lbl: TLabel);
begin
    if lbltimerMsg <> nil then exit;
    lbltimerMsg := lbl;
    NoteCaption :=lbl.caption;
    NoteDblclick:= lbl.OnDblClick;
    Notecolor   :=lbl.font.color;
    Notevisible :=lbl.visible;
    noteEnabled :=lbl.enabled;
end;
function TfrmBaseGUI.isModalForm: Boolean;
begin
  Result:= fsmodal in formstate ;
end;

procedure TfrmBaseGUI.tmrdelayMsgTimer(Sender: TObject);
begin
      if lbldelay <> nil then begin
        if copy(lbldelay.caption,1,7) <> 'Closing' then lbldelay.caption := 'Closing . ' else lbldelay.caption := lbldelay.caption +' .';
        lbldelay.Visible := True;
        lbldelay.Refresh;
      end;
end;

procedure TfrmBaseGUI.tmrProcessMessageTimer(Sender: TObject);
begin
  if not(assigned(lbltimerMsg) ) then exit;
  ShowStatus('');
  lbltimerMsg.Caption     := NoteCaption;
  lblTimerMsg.OnDblClick    := notedblclick;
  lbltimerMsg.Font.Color  := Notecolor;
  lbltimerMsg.visible     := Notevisible;
  lbltimerMsg.Enabled     := noteEnabled;
  if assigned(pnlTimerMsg) then pnlTimerMsg.visible := False;
  if Assigned(btntohighLight) then hideHighlightcontrol;
  tmrProcessMessage.Enabled:= False;
end;


procedure TfrmBaseGUI.ShowStatus(const Value: String);
begin
    if not(assigned(lbltimerMsg) ) then exit;
    if Value = '' then begin
      lbltimerMsg.visible:= false;
      if Assigned(pnltimerMsg) then
        pnltimerMsg.visible:= false;
    end

    else if sametext(lbltimerMsg.Caption ,Value) and (lbltimerMsg.visible) then
    else begin
      if not(lbltimerMsg.visible) then lbltimerMsg.Visible := True;
      if pnltimerMsg <> nil then if not(pnltimerMsg.visible) then pnltimerMsg.Visible := True;
      if btntohighLight <> nil then Highlightcontrol(btntohighLight);
      lbltimerMsg.Caption := Value;
      lblTimerMsg.OnDblClick    := dblclicktohide;
      lbltimerMsg.Enabled := True;
      lbltimerMsg.Refresh;
    end;
end;
procedure TfrmBaseGUI.SleepUntilFormshown(const formname:String);
begin
    While FormStillOpen(formname) do Begin
      Application.ProcessMessages;
      Sleep(100);
    end;
end;

procedure TfrmBaseGUI.SpellingCheckAdd;

  function MenuExists(Item: TMenuItem; Caption: string): boolean;
  var
    x: integer;
  begin
    result := false;
    for x := 0 to Item.Count -1 do begin
      if SameText(Item.Items[x].Caption, Caption) then begin
        result := true;
        exit;
      end
      else
        result := MenuExists(Item.Items[x], Caption);
    end;
  end;

  procedure findMemos(comp: TComponent);
  var
    x: integer;
    mnu: TMenuItem;
  begin
    for x := 0 to comp.ComponentCount -1 do begin
      if comp.Components[x] is TDBMemo then begin
        Spelling.AddictSpell.AddControl(TDBMemo(comp.Components[x]));
        if Assigned(TDBMemo(comp.Components[x]).PopupMenu) then begin
          if not MenuExists(TDBMemo(comp.Components[x]).PopupMenu.Items, mnuSpelling.Caption) then begin
            mnu := TMenuItem.Create(self);
            mnu.Caption := mnuSpelling.Caption;
            mnu.OnClick := mnuSpelling.OnClick;
            TDBMemo(comp.Components[x]).PopupMenu.Items.Add(mnu);
          end;
          if not MenuExists(TDBMemo(comp.Components[x]).PopupMenu.Items, mnuSpellingOptions.Caption) then begin
            mnu := TMenuItem.Create(self);
            mnu.Caption := mnuSpellingOptions.Caption;
            mnu.OnClick := mnuSpellingOptions.OnClick;
            TDBMemo(comp.Components[x]).PopupMenu.Items.Add(mnu);
          end;
        end
        else begin
          { need a popup menu }
          TDBMemo(comp.Components[x]).PopupMenu := popSpelling;
        end;
      end
      else begin

        findMemos(comp.Components[x]);
      end;
    end;
  end;

begin
  findMemos(self);
//  spelling.AddictSpell.Configuration.Loaded := true;
//  showmessage(spelling.AddictSpell.Configuration.MainDictionaries.Text);
//  showmessage(TMainDictionary(spelling.AddictSpell.MainDictionaries[0]).FileNAme);
end;

procedure TfrmBaseGUI.SpellingCheckRemove;

  procedure findMemos(comp: TComponent);
  var
    x: integer;
  begin
    for x := 0 to comp.ComponentCount -1 do begin
      if comp.Components[x] is TDBMemo then begin
        Spelling.AddictSpell.RemoveControl(TDBMemo(comp.Components[x]));

      end
      else begin
        findMemos(comp.Components[x]);
      end;
    end;
  end;

begin
  findMemos(self);
end;
procedure TfrmBaseGUI.InitComponentDefaultProperties(acomp :TWinControl);
begin
    if acomp is twwCheckbox then begin
        if twwCheckbox(acomp).caption = '' then begin
          twwCheckbox(acomp).width := 14;
          twwCheckbox(acomp).Height:= 14;
        end;
        twwCheckbox(acomp).Frame.Transparent     := True;
        TwwCheckBox(acomp).Frame.FocusBorders    := [];
        TwwCheckBox(acomp).Frame.NonFocusBorders := [];
        TwwCheckBox(acomp).Frame.Enabled         := False;
        TwwCheckBox(acomp).AlwaysTransparent     := True;
        TwwCheckBox(acomp).Parentcolor           := True;
      end else if acomp is TCheckbox then begin
        if TCheckbox(acomp).caption = '' then begin
          TCheckbox(acomp).width     := 14;
          TCheckbox(acomp).Height    := 14;
        end;
        TCheckbox(acomp).Parentcolor := true;
      end else if acomp is TDNMPanel then begin
          TDNMPanel(acomp).Transparent := False;
          TDNMPanel(acomp).Parentcolor := True;
      end else if acomp is TwwRadioGroup then begin
          TwwRadioGroup(acomp).TransparentActiveItem := False;
          TwwRadioGroup(acomp).Transparent           := False;
      end else if acomp is TDnMSpeedButton then begin
        if Sametext(TDnMSpeedButton(acomp).caption , 'Add date') then begin
          TDnMSpeedButton(acomp).Width     := 56;
          TDnMSpeedButton(acomp).height    := 13;
          TDnMSpeedButton(acomp).Font.Name := 'Arial';
          TDnMSpeedButton(acomp).Font.Style:= [fsBold];
          TDnMSpeedButton(acomp).Font.Size := 9;
        end;
      end;
end;
procedure TfrmBaseGUI.InitComponentDefaultProperties;
var
  iIndex: integer;
begin
  for iIndex := 0 to ComponentCount - 1 do begin
    if Components[iIndex] is TWinControl then begin
       InitComponentDefaultProperties(TWinControl(Components[iIndex]));
    end;
  end;
end;


procedure TfrmBaseGUI.SetDefaultColor;
var
  ctr: Integer;
begin
  for ctr := 0 to componentcount - 1 do begin
    if components[ctr] is TShader then begin
      TShader(components[ctr]).FromColor := Self.color;
      TShader(components[ctr]).ToColorMirror := Self.color;
    end;
  end;
end;

Function TfrmBaseGUI.MenuItemByname(PopupMenu:TAdvPopupMenu; Caption:String):TMenuitem;
begin
  REsult := nil;
  if PopupMenu=nil then exit;
  Result := TAdvPopupMenu(PopupMenu).Items.Find(Caption);

(*var
  ctr:Integer;
  s:String;
begin
  result := nil;
  if PopupMenu=nil then exit;
  if PopupMenu.componentcount =0 then exit;
  for ctr:= 0 to PopupMenu.componentcount-1 do begin
    if PopupMenu.components[ctr] is tMenuItem then begin
      s:= tMenuItem(PopupMenu.components[ctr]).caption;
      if sametext(s , caption) then begin result := tMenuItem(PopupMenu.components[ctr]); exit; end;
      s:= replacestr(s , '&&' , '~|||~');
      s:= replacestr(s , '&' , '');
      s:= replacestr(s , '~|||~' , '&');
      if sametext(s , caption) then begin result := tMenuItem(PopupMenu.components[ctr]); exit; end;
    end;
  end;*)
end;


end.




