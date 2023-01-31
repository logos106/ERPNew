unit BaseFormForm;
{$I ERP.inc}
{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
          initial version
                        Parent of all ERP forms
                        enables intercept at low level:
                        1. Clear all programmer set hints
                        2. Set hints in components from tblmacrohelp
                        GUIDELINE: All variables on this form should be prefixed with bf
 07/11/05  1.00.01 BJ   Implemeted timer to check for the idle time and the applciation
                        is terminated if the system is idle for 10 mnts
                        Note :Timer's interval is 5 mnts in the begenning, to avoid
                        executing the proc unnecessarly. When it is idle for 5 mnts the
                        interval is changed to 1 mint.
 22/11/05  1.00.02 BJ   Preference added for the automatic logout of idle users and
                        then Sessiontime(in mints)
 28/11/05  1.00.03 DSP  Added the property ActionBitmap.
 28/03/06  1.00.04 BJ   Helpnotes implemented.
 03/04/06  1.00.05 BJ   introduced HintDisabledSetFocus. This should be set to
                        True when the focus is Handled programatically and doesn;t need the
                        hitnform invokation for it
 21/04/06  1.00.06 BJ   hint is disabeld for modalform and maximised forms.
 26/04/06  1.00.07 DSP  Added test for csFocusing in OnFormActivate.
 02/05/06  1.00.08 DSP  Moved PostMessage from OnFormActivate to OnFormShow.
 02/05/06  1.00.09 BJ   function SetButtonProperties was a local function of formcreate
                        which is changed to a protected function. Adding any button dynamically
                        can call this function to set the properties.
 15/10/06  1.00.10 BJ  Form's caption is set in the onFormshow procedure after the formshoow
                        Formcreate checks the user's access to the form and the formshow checks
                        the record locking status, both are done before changing the caption.
                        fiAccesslevel(and ignoreaccesslevels) is moved into the baseform -
                        required for changing the caption

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, MyAccess, IniFiles, StdCtrls, ComCtrls,AdvOfficeStatusBar,
  ExtCtrls, AppEvnts, DNMSpeedButton, wwclearbuttongroup, wwradiogroup,
  Wwdbgrid,MessageConst, DNMAccessManager, GraphUtil, frmBase, DNMPanel, ERPdbComponents,
  BusobjTemplateOptions, JsonObject,PrintTemplateObj,Menus, SelectionDialog, CorrespondenceObj , FormEvents, busobjbase;

type

  TBaseForm = class(TfrmBaseGUI)
    dlgReportSelect: TSelectionDialog;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    bfInitialised: boolean;     // indicates that a 'OnShowEvent' has occured before
    F2Pressed :Boolean;
    fbHintDisabledSetFocus :Boolean;
    (*foSavedCursor: TCursor;*)
    fAccessManager: TDNMAccessManager;

    procedure Initialise;
//    Procedure FormatHeading(var DefaultHeading :String);
//    Procedure PositionForHintForm(Sender :TWinControl);
    (*procedure ClearComponentHints;*)

    procedure OnFormActivate(Sender: TObject);
    procedure OnFormKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    Procedure SetFlatBuffers;
    procedure WMSetText(var Msg: TMessage); message WM_SETTEXT;
    procedure WMBringToFrontSoon(var Msg: TMessage); message WM_BringToFrontSoon;
    function GetAccessLevel: Integer;
    procedure SetAccessLevel(const Value: Integer);
    function GetAccessManager: TDNMAccessManager;
    (*procedure setInEnglish(const Value: boolean);*)
    procedure setUserLanguageID(const Value: Integer);
    procedure WMSyscommand(Var msg: TWmSysCommand); message WM_SYSCOMMAND;
(*    {$WARNINGS OFF}
    function GetSendEmailtoErpExcLogFileName(const emaillogPrefix :String): string;

    {$WARNINGS ON}*)

    procedure DoOnCloseWait(Sender: TObject);
    procedure SetIgnoreAccessLevels(const Value: boolean);
    procedure FormPaintCancel(Sender: TObject);
    procedure SetButtonProperties(const Control: TWinControl);
    function EventTypeToStr(const aEventType: TEventType): String;
  protected
    fbPainting :Boolean;
    fChangingCaption      : Boolean;
    HintFor               : String ;
    //fActionBitmap         : TBitmap;
    fbPageFontrol         : TPageControl;
    fbPageFontrolTabIndex : Integer;
    fbOnshowHint          : Boolean;
    EventList             : TList;
    Buttons               : array of String;
    UseDefaultColor       : Boolean;
    fformcolor            : TColor;
    (*fbInEnglish:boolean;*)
    fiUserLanguageID:Integer;
    formCaption           : string;
    EnableChangeForm:Boolean;
    PrintTemplate                        : TPrintTemplates;
    fsReportName: string;
    fbInitToTabcolor :Boolean;


    Procedure AfterFormShow; Override;
    procedure OnFormShow(Sender: TObject);Override;
    (*Procedure ProcessingCursor(Apply :Boolean = True);*)
    Property HintDisabledSetFocus :Boolean REad fbHintDisabledSetFocus write fbHintDisabledSetFocus;
    procedure CMFocusChanged(var Message: TCMFOCUSCHANGED); message CM_FOCUSCHANGED;
    function GetEventRec(var EventRec: TFormEventRec;  const fsName: string; EventType: TFormEventType; RemoveFromList: boolean = false): Boolean;Overload;
    function GetEventRec(var EventRec: TEventRec;       const fsName: string;EventType: TEventType;     RemoveFromList: boolean = false): Boolean;Overload;
    procedure CreateParams(var Params: TCreateParams); override;
    //function GetNewDataSet(Const strSql :String; Connection :TERPConnection = nil) :TCustomMyDataset;
    procedure SetFormColor(const Value: TColor);Virtual;
    Procedure PostDB(const Ds:TDataset);
    Procedure cancelDB(const Ds:TDataset);
    Procedure EditDB(const Ds:TDataset);
    procedure SetDefaultColor;Override;
    function FormCaptionSuffix: string; virtual;
    function GridsortDescription(const Grid: TwwDBGrid): String;
    procedure PageControlDrawTab(Control: TCustomTabControl; TabIndex: integer;
      const Rect: TRect; Active: boolean);
    Procedure AlignbuttonTopnHeight(pnl:TDnmPanel);
    Procedure AlignbuttonLeftnWidth(pnl:TDnmPanel);
    function TemplateToPrint(const Templatetype: String;  const ChooseReport: Boolean;DefaultTemplate:String =''): String;

    Function IsFormReadOnly:boolean;Virtual;
    function NewMenuItem(menuCaption: String;  MenuEvent: TNotifyEvent; hasSeparator: Boolean; PopupMenu : TPopupMenu; menuhint:String='') : TMenuItem;
    Procedure PrintTemplateOptionsReport(Sender: TTemplateOptions); virtual;
    procedure initPrintTemplateOptionsReport(Sender: TTemplateOptions; var sSQL: String; var MasterDetailLink: TJsonObject;var ShowCancelPreviewBtninReportPreview: boolean); Virtual;
    procedure initCorresforPrintTemplateOptionsReport(Sender: TTemplateOptions;var OutGoingFileName: String; var Corres: TCorrespondenceGui);Virtual;
    function ButtonToExcludeFromFormating: String; virtual;
    Procedure CloseIt(IsDoneOK: boolean = true); Virtual;

    (*function SendEmailtoErp(Const Subject:String; Value:String;emaillogPrefix:String='emaillog'):String;*)
  public
    fbIgnoreAccessLevels: boolean;
    procedure CallUpdateActions;
    procedure BringToFrontSoon;
    //property ActionBitmap: TBitmap read fActionBitmap;
    Property FormColor :TColor read fformcolor write SetFormColor;
    constructor Create(AOwner:TComponent) ; override;
    procedure Centralisebuttons(OwnerPanel:TDnMPanel; leftmargin :Integer ; rightMargin :Integer ; btngap:Integer;Matchwidth:Boolean); Overload;
    procedure Centralisebuttons(OwnerPanel:TDnMPanel; leftmargin :Integer =0; rightMargin :Integer =0; btngap:Integer=4); Overload;Virtual;
    procedure Centralisepanel(OwnerPanel, currentPanel:TDnMPanel); Virtual;
    (*Property InEnglish :boolean read fbInEnglish write setInEnglish;*)
    Property UserLanguageID :Integer read fiUserLanguageID write setUserLanguageID;
    procedure CloseWait;
    Procedure CloseWithParentform;
    Function  ConfirmFromGUI(const msg :String; Buttons:TMsgDlgButtons ; DlgType: TMsgDlgType =mtConfirmation) :Integer;
    procedure PrintTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const Copies: integer; MasterDetailLink: TJsonObject = nil;fsPrintename: String = ''; ShowCancelPreviewBtninReportPreview: boolean = false); Virtual;
    Function SaveTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const FileType: string; const FileName: string = 'EmailReport';MasterDetailLink: TJsonObject = nil): boolean;Virtual;
    property ReportToPrint: string read fsReportName write fsReportName;
    procedure LoadReportTypes(reportTypeID:Integer =0;LoadReportTypesconditions:String=''); overload; virtual;
    procedure LoadReportTypes(const ReportTypeNameList: string); overload; virtual;

  published
    property AccessManager: TDNMAccessManager read GetAccessManager;
    property AccessLevel: Integer read GetAccessLevel write SetAccessLevel;
    Property CleanformCaption :String read formCaption;
    Property  IgnoreAccessLevels :boolean read fbIgnoreAccessLevels write SetIgnoreAccessLevels;
  end;

implementation

uses wwdbedit, Grids, Wwdbigrd,
  wwdblook, Wwdbdlg, DBCtrls, wwdbcomb, wwdbdatetimepicker, wwcheckbox, TypInfo,
  AppEnvironment, CommonDBLib, CommonLib, FastFuncs, tcTypes, tcConst,
   IdMessage, IdSMTP, IdException, EMHelper, dmMainGUI,
  LanguageTranslationObj, tcDataUtils, ButtonsLib, DbSharedObjectsObj, Types,
  StrUtils, DNMLib, StringUtils, BaseListLib,shader, ColourLib, LogLib;
{$R *.dfm}
procedure TBaseForm.Centralisepanel(OwnerPanel, currentPanel:TDnMPanel);
begin
  currentPanel.Left := trunc((OwnerPanel.width - (currentPanel.Width))/2);
end;
procedure TBaseForm.Centralisebuttons(OwnerPanel:TDnMPanel; leftmargin :Integer =0; rightMargin :Integer =0; btngap:Integer=4);
begin
  Centralisebuttons(OwnerPanel,leftmargin ,rightMargin ,btngap,False);
end;

procedure TBaseForm.Centralisebuttons(OwnerPanel:TDnMPanel; leftmargin :Integer ; rightMargin :Integer ; btngap:Integer;Matchwidth:Boolean);
var
  ctr:Integer;
  button :TDnMSpeedButton;
  iTop, iheight:Integer;
  iWidth :Integer;
begin
    itop := -1; iheight:= -1;
    if (not(Assigned(Buttons))) or (Length(Buttons) = 0) then exit;
    button := TDNMSpeedButton(FindComponent(buttons[low(buttons)]));
    if assigned(button) then begin
      if Self.width < (button.width+btngap) *Length(Buttons) then
        Self.width := (button.width+btngap) *Length(Buttons) ;
        iWidth :=button.width;
    end;

    for ctr:= low(buttons) to high(buttons) do begin
      button := TDNMSpeedButton(FindComponent(buttons[ctr]));
      if Matchwidth then button.width := iWidth;
      if iTop <0 then itop :=button.Top;
      if iHeight <0 then iHeight :=button.Height;
      button.Left := btnLeft(Length(buttons) , button.Width , ctr+1,OwnerPanel, LEFTMARGIN, RIGHTMARGIN);
      button.Top := itop;
      button.Height:= iHeight;
    end;

(*var
    button :TDnMSpeedButton;
    ctr :Integer;
    curpos:Integer;
    centre :Integer;
begin
    if (not(Assigned(Buttons))) or (Length(Buttons) = 0) then exit;


    Centre := Trunc(OwnerPanel.width/2);
    if Assigned(Self.Parent) then if Self.Parent is TDNMPanel then
        Centre := Trunc(TDNMPanel(self.Parent).width/2);;

    if trunc(Length(buttons)/2)*2 = Length(buttons) then begin
        curpos := Centre-5;
        for ctr := trunc(Length(buttons)/2)+1 to Length(buttons) do begin
            button := TDNMSpeedButton(FindComponent(buttons[ctr-1]));
            Button.Left :=curpos+10;
            curpos := curpos + 10+button.width;
        end;
        curpos := Centre+5;
        for ctr := trunc(Length(buttons)/2) downto 1 do begin
            button := TDNMSpeedButton(FindComponent(buttons[ctr-1]));
            Button.Left :=curpos-10 - button.width;
            curpos := button.Left;
        end;
    end else begin
        curpos := Centre;
        button := TDNMSpeedButton(FindComponent(buttons[trunc(Length(buttons)/2)]));
        Button.Left :=curpos-Trunc(button.width/2);
        curpos :=  centre + Trunc(button.width/2);
        Centre := button.Left;
        for ctr := trunc(Length(buttons)/2)+2 to Length(buttons) do begin
            button := TDNMSpeedButton(FindComponent(buttons[ctr-1]));
            Button.Left :=curpos+10;
            curpos := curpos + 10+button.width;
        end;
        curpos := Centre;
        for ctr := trunc(Length(buttons)/2) downto 1 do begin
            button := TDNMSpeedButton(FindComponent(buttons[ctr-1]));
            Button.Left :=curpos-10 - button.width;
            curpos := curpos - 10-button.width;
        end;
    end;*)

end;

Function TBaseForm.ConfirmFromGUI(const msg :String; Buttons:TMsgDlgButtons ; DlgType: TMsgDlgType =mtConfirmation ) :Integer;
begin
    Result := CommonLib.MessageDlgXP_Vista(msg, DlgType, Buttons, 0);
end;
(*function TBaseForm.GetNewDataSet(Const strSql :String; Connection :TERPConnection = nil ) :TCustomMyDataset;
var
  qryExecute :TERPCommand;
begin
  result := nil;
  if connection = nil then connection := GetSharedMyDacConnection;
  if uppercase(copy(Trim(strSql),1,6)) = 'SELECT' then begin
      Result := TERPQuery.Create(Self);
      Result.Options.FlatBuffers := True;
      Result.connection := Connection;
      Result.SQL.add(strSql);
      Result.Open;
  end else begin
    qryExecute := TERPCommand.Create(Self);
    Try
        qryExecute.connection := Connection;
        qryExecute.SQL.text := strSql;
        qryExecute.Execute;
    finally
        FreeAndNil(qryExecute);
    end;
  end;


end;*)

procedure TBaseForm.FormShow(Sender: TObject);
begin
  inherited;
  if not bfInitialised then begin
    Initialise;
    bfInitialised := true;
  end;
end;

procedure TBaseForm.Initialise;
begin
  Inherited;
  //if self.ClassName <> 'TfmRegionalOptionEdit' then
  if EnableChangeForm then
    AppEnv.RegionalOptions.ChangeForm(Self);
end;

function TBaseForm.IsFormReadOnly: boolean;
begin
  REsult := Accesslevel >=5;
end;




Procedure TBaseform.SetDefaultColor;
var
  fTabColor : TColor;
begin
  Self.OnPaint := FormPaintCancel;
  if fbInitToTabcolor then begin
    fTabColor := ColorAdjustLuma(GetGradientColor(Self.ClassName).Color,GetGradientColor(Self.ClassName).AdjLuma  , False);
    Self.Color := fTabColor;
  end;
  inherited;
end;
procedure TBaseForm.FormCreate(Sender: TObject);
var
  PER: PEventRec;
begin
  SetDefaultColor;
  //Self.DoubleBuffered := True;
  UseDefaultColor := True;
  fformcolor:= 0;
  inherited;

  PrintTemplate                   := TPrintTemplates.Create;

  F2Pressed := False;
  fbOnshowHint := False;
  hintfor := '';
  bfInitialised := false;
  //fActionBitmap := TBitmap.Create;
  SetButtonProperties(Self );
  fbPageFontrol := nil;
  fbPageFontrolTabIndex :=-1;
  EventList:= TList.Create;
  fbHintDisabledSetFocus := True;
  (*foSavedCursor := crArrow;*)
  SetFlatBuffers;
  if Assigned(Self.OnShow) then begin
            System.New(PER);
            PER^.EventType:= on_Show;
            PER^.Name:= Self.ClassName;
            PER^.Data:= TMethod(Self.OnShow).Data;
            PER^.Code:= TMethod(Self.OnShow).Code;
            EventList.Add(PER);
  end;
  Self.OnShow := OnFormShow;

  if Assigned(Self.OnKeyUP) then begin
            System.New(PER);
            PER^.EventType:= on_KeyUp;
            PER^.Name:= Self.ClassName;
            PER^.Data:= TMethod(Self.OnKeyUP).Data;
            PER^.Code:= TMethod(Self.onKeyUP).Code;
            EventList.Add(PER);
  end;
  Self.OnKeyUP := OnFormKeyUp;

  if Assigned(Self.OnActivate) then begin
            System.New(PER);
            PER^.EventType:= on_Activate;
            PER^.Name:= Self.ClassName;
            PER^.Data:= TMethod(Self.OnActivate).Data;
            PER^.Code:= TMethod(Self.OnActivate).Code;
            EventList.Add(PER);
  end;
  Self.OnActivate := OnFormActivate;
  //if self.ClassName <> 'TfmRegionalOptionEdit' then
  if EnableChangeForm then
    AppEnv.RegionalOptions.ChangeForm(Self);
end;

procedure TBaseForm.CallUpdateActions;
begin
  try
    UpdateActions;
  except
  end;
end;

procedure TBaseForm.FormDestroy(Sender: TObject);
begin
  //if Assigned(fActionBitmap) then FreeAndNil(fActionBitmap);
  if EventList <> nil then while EventList.Count > 0 do begin
      Dispose(PEventRec(EventList.Items[0]));
      EventList.Delete(0);
    end;
  FreeAndNil(EventList);
  If Assigned(PrintTemplate) then FreeAndNil(PrintTemplate);
  inherited;
end;


procedure TBaseForm.CMFocusChanged(var Message: TCMFOCUSCHANGED);
begin
  inherited;
end;
Function TBaseForm.EventTypeToStr(const aEventType:TEventType):String;
begin
  if aEventType = OnChange then result := 'OnChange'
  else  if aEventType = OnGetText then result := 'OnGetText'
  else  if aEventType = OnSetText then result := 'OnSetText'
  else  if aEventType = OnValidate then result := 'OnValidate'
  else  if aEventType = AfterOpen then result := 'AfterOpen'
  else  if aEventType = AfterClose then result := 'AfterClose'
  else  if aEventType = BeforeClose then result := 'BeforeClose'
  else  if aEventType = BeforeDelete  then result := 'BeforeDelete '
  else  if aEventType = Beforepost then result := 'Beforepost'
  else  if aEventType = Afterpost then result := 'Afterpost'
  else  if aEventType = AfterInsert then result := 'AfterInsert '
  else  if aEventType = CalcFields then result := 'CalcFields '
  else  if aEventType = BeforeInsert then result := 'BeforeInsert '
  else  if aEventType = NewRecord  then result := 'NewRecord  '
  else  if aEventType = BeforeOpen  then result := 'BeforeOpen  '
  else  if aEventType = BeforeEdit then result := 'BeforeEdit '
  else  result := '';
end;
function TBaseForm.GetEventRec(var EventRec: TEventRec;       const fsName: string;EventType: TEventType;     RemoveFromList: boolean = false): Boolean;
var
  x: integer;
type
  aEventRec = ^TEventRec;
begin
  result:= False;
  if EventList = nil then Exit;
  for x:= 0 to EventList.Count -1 do begin
    if (aEventRec(EventList.Items[x])^.EventType = EventType) and (aEventRec(EventList.Items[x])^.Name = fsName) then begin
      result:= true;
      EventRec:= aEventRec(EventList.Items[x])^;
      if RemoveFromList then begin
        Dispose(aEventRec(EventList.Items[x]));
        EventList.Delete(x);
      end;
      Break;
    end;
  end;
end;

function TBaseForm.GetEventRec(var EventRec: TFormEventRec;  const fsName: string; EventType: TFormEventType;
    RemoveFromList: boolean = false): Boolean;
var
  x: integer;
begin
  result:= False;
  if EventList = nil then Exit;
  for x:= 0 to EventList.Count -1 do begin
    if (PEventRec(EventList.Items[x])^.EventType = EventType) and (PEventRec(EventList.Items[x])^.Name = fsName) then begin
      result:= true;
      EventRec:= PEventRec(EventList.Items[x])^;
      if RemoveFromList then begin
        Dispose(PEventRec(EventList.Items[x]));
        EventList.Delete(x);
      end;
      Break;
    end;
  end;
end;

procedure TBaseForm.onFormActivate(Sender: TObject);
var
  EventRec: TFormEventRec;
  NotifyEvent: TNotifyEvent;
begin
  NotifyEvent := nil;
  if Self.GetEventRec(EventRec, Self.ClassName, on_Activate) then  begin
    TMethod(NotifyEvent).Data:= EventRec.Data;
    TMethod(NotifyEvent).Code:= EventRec.Code;
    NotifyEvent(Sender);
  end;
end;
procedure TBaseForm.OnFormShow(Sender: TObject);
var
  EventRec: TFormEventRec;
  NotifyEvent: TNotifyEvent;
begin
  NotifyEvent := nil;
//  Try
    Application.ProcessMessages; //Remove Waiting Messages
    if Self.GetEventRec(EventRec, Self.ClassName, on_Show) then  begin
        TMethod(NotifyEvent).Data:= EventRec.Data;
        TMethod(NotifyEvent).Code:= EventRec.Code;
        NotifyEvent(Sender);
    end;
//  Except
//  End;
  inherited;
  AfterformShow;
end;

procedure TBaseForm.onFormKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
var
  EventRec: TFormEventRec;
  NotifyEvent: TKeyEvent;
begin
  NotifyEvent := nil;
  if Self.GetEventRec(EventRec, Self.ClassName, on_KeyUp) then  begin
      TMethod(NotifyEvent).Data:= EventRec.Data;
      TMethod(NotifyEvent).Code:= EventRec.Code;
      NotifyEvent(Sender, Key, shift);
  end;
end;

procedure TBaseForm.SetFlatBuffers;
var
  iIndex: integer;
begin
  for iIndex := 0 to ComponentCount - 1 do begin
    if Components[iIndex] is TERPQuery then begin
      if not(TERPQuery(Components[iIndex]).active) then // this is to ignore the dataset used for inuseforms obj
        TERPQuery(Components[iIndex]).Options.FlatBuffers := True;
    end;
   end;
end;


procedure TBaseForm.BringToFrontSoon;
begin
  PostMessage(Handle, WM_BringToFrontSoon, 0, 0);
end;

procedure TBaseForm.WMBringToFrontSoon(var Msg: TMessage);
begin
  BringToFront;
end;

function TBaseForm.GetAccessLevel: Integer;
begin
  if fbIgnoreAccessLevels then
    result:= 1
  else
    result:= AccessManager.AccessLevel;
end;

procedure TBaseForm.SetAccessLevel(const Value: Integer);
var
  TmpCaption: PChar;
begin
  if Value <> AccessManager.AccessLevel then begin
    AccessManager.AccessLevel := Value;
    TmpCaption := PChar(formCaption);
    SendMessage(Handle, WM_SETTEXT, 0, Longint(TmpCaption));
  end;
end;

procedure TBaseForm.SetButtonProperties(const Control: TWinControl);
begin
  ColourLib.SetButtonProperties(Control,ButtonToExcludeFromFormating);
end;

function TBaseForm.GetAccessManager: TDNMAccessManager;
begin
  if Assigned(Owner) and (Owner is TBaseForm) then
    result:= TBaseForm(Owner).AccessManager
  else begin
    if not Assigned(fAccessManager) then begin
      fAccessManager:= TDNMAccessManager.Create(self);
      if IgnoreAccessLevels then
        fAccessManager.AccessLevel:= 1
      else
        fAccessManager.AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    end;
    result:= fAccessManager;
  end;
end;

procedure TBaseForm.FormPaint(Sender: TObject);
var
  ColorMapRec: TColorMapRec;
begin
try
  inherited;
//  Exit;
  If not fbPainting then Try  // Attempt to Stop InvalidateComponents force Paint Loop
    fbPainting := True;
    if UseDefaultColor then PaintGradientColor(Self)
    else   begin
      ColorMapRec.Color   := Self.color;
      ColorMapRec.AdjLuma := cAdjustLuma;
      PaintColor(Self, ColorMapRec);
    end;
    InvalidateComponents(Self);
  finally
    fbPainting := False;
  end;
Except
  on E:Exception do begin
  end;
end;
end;

procedure TBaseForm.FormPaintCancel(Sender: TObject);
begin
    FormPaint(Sender);
end;

procedure TBaseForm.CreateParams(var Params: TCreateParams);
begin
  try
    inherited;
    //
    // This is used to force a repaint of the whole form after a resize. The
    // gradient colour drawing on the form requires a repaint after resizing.
    //
    with Params.WindowClass do
      Style := Style or CS_HREDRAW or CS_VREDRAW;
  Except

  end;
end;

procedure TBaseForm.CloseIt(IsDoneOK: boolean);
begin
    if not(fsModal in Self.FormState) then Self.Close
    else begin
      if IsDoneOK then modalresult := mrOk
      else modalresult             := mrCancel;
    end;
end;

procedure TBaseForm.CloseWait;
var
  timer: TTimer;
begin
  timer := TTimer.Create(self);
  timer.Interval := 100;
  timer.OnTimer := DoOnCloseWait;
  timer.Enabled := True;
end;

procedure TBaseForm.CloseWithParentform;
begin
  if Assigned(Owner) and (Owner is TBaseForm) then
    TBaseForm(Owner).CloseWithParentform
  else Self.Close;
end;

procedure TBaseForm.DoOnCloseWait(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
  Close;
end;

procedure TBaseForm.WMSetText(var Msg: TMessage);
begin
  if not fChangingCaption and not fbIgnoreAccessLevels {and not (csLoading in ComponentState)} then begin
    fChangingCaption := True;
    try
      formCaption := PChar(Msg.lParam);
      if Pos(AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel),formCaption) = 0 then
        Caption := formCaption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel) + FormCaptionSuffix
      else
        Caption := formCaption + FormCaptionSuffix ;
    finally
      fChangingCaption := False;
    end;
  end else
    inherited;
end;

procedure TBaseForm.WMSyscommand(var msg: TWmSysCommand);
begin
  if (msg.cmdtype and $FFF0) = SC_CLOSE then
    CloseWait
  else
    inherited;
end;

function TBaseForm.FormCaptionSuffix: string;
begin
  result := '';
end;

procedure TBaseForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (WindowState = wsMaximized) and (not (fsModal in FormState)) then
    WindowState := wsMinimized;

  if fsModal in FormState then
    Hide
  else
    if IsWindow(Handle) then
      ShowWindow(Handle, SW_HIDE);
  PerformPaints;
end;

procedure TBaseForm.SetFormColor(const Value: TColor);
begin
  fformcolor :=  Value;
  Self.color := Value;
  UseDefaultColor := False;
end;


procedure TBaseForm.SetIgnoreAccessLevels(const Value: boolean);
begin
  fbIgnoreAccessLevels := Value;
    if Assigned(fAccessManager) then
      if Assigned(fAccessManager.Owner) and (fAccessManager.Owner = Self) then
        if fbIgnoreAccessLevels then
          fAccessManager.AccessLevel:= 1
        else if fAccessManager.AccessLevel= 1 then
          fAccessManager.AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
  if ignoreaccessLevels then
    Caption := replacestr(formCaption , AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel) , '');
end;

(*procedure TBaseForm.setInEnglish(const Value: boolean);
begin
  fbInEnglish := Value;
  appenv.LanguageTranslationObj.DoTranslate(Self, Value);
end;*)

procedure TBaseForm.setUserLanguageID(const Value: Integer);
begin
  if fiUserLanguageID <> Value then begin
    fiUserLanguageID := Value;
    TLanguageTranslationObj.Inst.DoTranslate(Self, Value);
  end;
end;

constructor TBaseForm.Create(AOwner: TComponent);
begin
  fbInitToTabcolor := True;
  inherited;
  (*fbInEnglish := appenv.LanguageTranslationObj.UseRegionalLanguage  = false ;*)
  fiUserLanguageID := TLanguageTranslationObj.Inst.UserLanguageId;
  EnableChangeForm := true;
//  fbInitToTabcolor := True;
end;
procedure TBaseForm.PostDB(const Ds: TDataset);
begin
  if ds.active = False then exit;
  if ds.state in [dsEdit , dsInsert] then ds.Post;
end;
procedure TBaseForm.CancelDB(const Ds: TDataset);
begin
  if ds.active = False then exit;
  if ds.state in [dsEdit , dsInsert] then ds.Cancel;
end;

procedure TBaseForm.EditDB(const Ds: TDataset);
begin
  if ds.active = False then exit;
  if not(ds.state in [dsEdit , dsInsert]) then ds.Edit;
end;






procedure TBaseForm.AfterformShow;
begin
inherited;
{descendants will override if necessary}

end;


procedure TBaseForm.PageControlDrawTab(Control: TCustomTabControl; TabIndex: integer; const Rect: TRect; Active: boolean);
var
  TmpRect: TRect;
  Bitmap: TBitmap;

  Function FindPageforTabIndex( pagecontrol: TPagecontrol; tabindex: Integer ): TTabSheet;
  Var
    i: Integer;
  Begin
    Assert( Assigned( pagecontrol ));
    Assert( (tabindex >= 0) and (tabindex < pagecontrol.pagecount ));
    Result := nil;
    For i:= 0 To pagecontrol.pagecount-1 Do
      If pagecontrol.pages[i].tabVisible Then Begin
        Dec( tabindex );
        If tabindex < 0 Then Begin
          result := pagecontrol.pages[i];
          break;
        End;
      End;
  end;


begin
  Bitmap := TBitmap.Create;
  try
    TmpRect    := Rect;
    Bitmap.Width := 300;
    Bitmap.Height := 300;
    Bitmap.Canvas.Brush.Color := Self.Color;
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

    DrawText(Control.Canvas.Handle, PChar(FindPageforTabIndex(TPageControl(Control),TabIndex).Caption), - 1, TmpRect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);

  finally
    FreeAndNil(Bitmap);
  end;
end;
Function TBaseForm.GridsortDescription (const Grid :TwwDBGrid):String;
var
  s:String;
  st:TStringlist;
  ctr:Integer;
begin
  s:= '';
  st:= tStringlist.Create;
  try
    st.Delimiter := ' ';
    try
      st.DelimitedText := TERPQuery(Grid.datasource.dataset).IndexFieldNames;
      if st.Count =0 then begin
        s:= 'Data is in Default Order';
        exit;
      end;
      s:= 'Data Sorted by ';
      if Grid.datasource.dataset.findfield(st[0])<> nil then s:= s+ quotedstr(Grid.datasource.dataset.findfield(st[0]).displaylabel) else s:= s + quotedstr(st[0]);
      if st.Count = 1 then exit;
      s:= s+':' ;
      for ctr:= 1 to st.Count-1 do begin
        st[ctr]:= trim(replacestr(st[ctr], ';' , ''));
             if sametext(st[ctr], 'ASC')  then s:= s+ ' Ascending'
        else if sametext(st[ctr], 'DESC') then s:= s+ ' Descending'
        else if sametext(st[ctr], 'CIS')  then s:= s+ ' Case In-sensitive'
        else if sametext(st[ctr], 'CS')   then s:= s+ ' Case Sensitive'
        else s:= s +' ' + st[ctr];
      end;
    Except
    end;
  finally
    freeandNil(st);
    REsult:= s;
  end;
end;
Procedure TBaseForm.AlignbuttonTopnHeight(pnl:TDnmPanel);
var
  ctr:Integer;
  itop,iheight:Integer;
begin
  itop:= -1;
  iheight:=-1;
  for ctr:= 0 to componentcount-1 do
    if (components[ctr] is TDNMSpeedbutton)and (TDNMSpeedbutton(components[ctr]).Parent =pnl) then begin
        if itop= -1 then itop := TDNMSpeedbutton(components[ctr]).top;
        if iheight= -1 then iheight := TDNMSpeedbutton(components[ctr]).height;

        TDNMSpeedbutton(components[ctr]).top:= itop;
        TDNMSpeedbutton(components[ctr]).height := iheight;
    end;


end;
Procedure TBaseForm.AlignbuttonLeftnWidth(pnl:TDnmPanel);
var
  ctr:Integer;
  ileft,iWidth:Integer;
begin
  ileft:= -1;
  iWidth:=-1;
  for ctr:= 0 to componentcount-1 do
    if (components[ctr] is TDNMSpeedbutton)and (TDNMSpeedbutton(components[ctr]).Parent =pnl) then begin
        if ileft= -1 then ileft := TDNMSpeedbutton(components[ctr]).left;
        if iWidth= -1 then iWidth := TDNMSpeedbutton(components[ctr]).Width;

        TDNMSpeedbutton(components[ctr]).left:= ileft;
        TDNMSpeedbutton(components[ctr]).Width := iWidth;
    end;
end;

function TBaseForm.TemplateToPrint(const Templatetype: String;  const ChooseReport: Boolean;DefaultTemplate:String =''): String;
begin
  result := '';
  if ChooseReport then begin
    if Pos(',',Templatetype) > 0 then
      LoadReportTypes(Templatetype)
    else
      LoadReportTypes(tcdatautils.TemplateTypeID(Templatetype));
    if dlgReportSelect.Execute then
      REsult := dlgReportSelect.SelectedItems.Text;
  end else begin
    REsult := GetDefaultTemplate(Templatetype);
    if result = '' then result := DefaultTemplate;
  end;
end;

procedure TBaseForm.LoadReportTypes(reportTypeID:Integer =0;LoadReportTypesconditions:String='');
var
  qryTemp: TERPQuery;
begin
  qryTemp := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    with qryTemp do begin
      Sql.Add('SELECT TemplName '+
              ' FROM tblTemplates  '+
              ' WHERE ifnull(Active, "F")  = "T"  '+
              ' and TypeID = ' + inttostr(reportTypeID) +' '+
              LoadReportTypesconditions+
              ' order by TemplName');
      open;
      dlgReportSelect.Items.Clear;
      if not IsEmpty then begin
        first;
        while not eof do begin
          dlgReportSelect.Items.Add(FieldByName('TemplName').asString);
          Next;
        end;
      end;
    end;
  finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qryTemp);
  end;
end;

procedure TBaseForm.LoadReportTypes(const ReportTypeNameList: string);
var
  qry: TERPQuery;
  strArr: TStringDynArray;
  s: string;
  x: integer;
begin
  strArr := SplitString(ReportTypeNameList,',');
  s := '';
  for x := Low(strArr) to High(strArr) do begin
    if s <> '' then s := s + ',';
    s := s + '"' + strArr[x] + '"';
  end;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.SQL.Add('select TemplName from tblTemplates');
    qry.SQL.Add('inner join tbltemplatetype on tbltemplatetype.TypeID = tblTemplates.TypeID');
    qry.SQL.Add('and tbltemplatetype.TypeName in (' + s + ')');
    qry.SQL.Add('where IfNull(tblTemplates.Active,"F") = "T"');
    qry.Open;
    dlgReportSelect.Items.Clear;
    while not qry.Eof do begin
      dlgReportSelect.Items.Add(qry.FieldByName('TemplName').asString);
      qry.Next;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;


function TBaseForm.NewMenuItem(menuCaption: String;  MenuEvent: TNotifyEvent; hasSeparator: Boolean; PopupMenu : TPopupMenu; menuhint:String='') : TMenuItem;
begin
  REsult := BaseListLib.NewMenuItem(self,menuCaption,MenuEvent,hasSeparator,PopupMenu ,menuhint);
(*var
  mnu: TMenuItem;
  CountMenuItems:Integer;
  FoundMenuItem:Boolean;
begin
  Result := nil;
  if not (Assigned(PopupMenu)) then exit;

  {Search if menu exists }
  FoundMenuItem := False;
  CountMenuItems := 0;
  while (CountMenuItems < PopupMenu.Items.Count) and (FoundMenuItem = false) do begin
    if PopupMenu.Items[CountMenuItems].Caption = menuCaption then begin
      FoundMenuItem := true;
      if not PopupMenu.Items[CountMenuItems].visible then PopupMenu.Items[CountMenuItems].visible := true;
      Result := PopupMenu.Items[CountMenuItems];
      Break;
    end
    else Inc(CountMenuItems);
  end;


  if not FoundMenuItem then begin
      if hasSeparator then begin
        mnu := TMenuItem.Create(self);
        mnu.Caption := '-';
        PopupMenu.Items.Add(mnu);
      end;

      mnu := TMenuItem.Create(self);
      mnu.Caption := menuCaption;
      mnu.OnClick := MenuEvent;
      if menuhint <> '' then mnu.hint :=  menuhint;
      PopupMenu.Items.Add(mnu);
      Result := mnu;
  end;*)

end;
procedure TBaseForm.PrintTemplateOptionsReport(Sender: TTemplateOptions);
  var
    sSQL                               : String;
    MasterDetailLink                   : TJsonObject;
    ShowCancelPreviewBtninReportPreview: boolean;
    OutGoingFileName                   : String;
    Corres                             : TCorrespondenceGui;
    ReportAttachmentfiles              : String;
  begin
    if Sender = nil then Exit;
    if Sender.Active then begin
      initPrintTemplateOptionsReport(Sender, sSQL, MasterDetailLink, ShowCancelPreviewBtninReportPreview);
      if Sender.Print then PrintTemplateReport(Sender.TemplateName, sSQL, true, 1, MasterDetailLink, Sender.PrinterName, ShowCancelPreviewBtninReportPreview);
      if Sender.Preview then PrintTemplateReport(Sender.TemplateName, sSQL, false, 1, MasterDetailLink, Sender.PrinterName, ShowCancelPreviewBtninReportPreview);
      if Sender.email then begin
        Corres := TCorrespondenceGui.Create;
        try
          Corres.Clear;
          SaveTemplateReport(Sender.TemplateName, sSQL, false, 'PDF');
          initCorresforPrintTemplateOptionsReport(Sender, OutGoingFileName, Corres);
          if Corres.RecipientList <> '' then begin
            if not FileExists(CommonLib.TempDir + 'EmailReport.PDF') then begin
              CommonLib.MessageDlgXP_Vista('Can''t Find Attachment' + #13 + #10 + #13 + #10 + 'Email Failed !', mtWarning, [mbOK], 0);
              Exit;
            end;
            Copyfile(PChar(CommonLib.TempDir + 'EmailReport.PDF'), PChar(CommonLib.TempDir + OutGoingFileName), false);
            Corres.AttachmentList.Add(CommonLib.TempDir + OutGoingFileName);
            ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres, GetTemplate(ReportToPrint));
            Corres.Execute();
          end;
        finally
          DeleteFiles(ExtractFilePath(ParamStr(0)), '*.PDF');
          DeleteMultipleFiles(CommonLib.TempDir, ReportAttachmentfiles);
          Corres.Free;
        end;
      end;
    end;
  end;


procedure TBaseForm.initPrintTemplateOptionsReport(Sender: TTemplateOptions;
  var sSQL: String; var MasterDetailLink: TJsonObject;
  var ShowCancelPreviewBtninReportPreview: boolean);
begin

end;
procedure TBaseForm.PrintTemplateReport(const ReportName, SQLPortion: string;
  const DoPrint: boolean; const Copies: integer; MasterDetailLink: TJsonObject;
  fsPrintename: String; ShowCancelPreviewBtninReportPreview: boolean);
begin
end;

Function TBaseForm.SaveTemplateReport(const ReportName, SQLPortion: string; const DoPrint: boolean; const FileType: string; const FileName: string = 'EmailReport';MasterDetailLink: TJsonObject = nil): boolean;
begin
  REsult := TRue;
end;
procedure TBaseForm.initCorresforPrintTemplateOptionsReport(Sender: TTemplateOptions; var OutGoingFileName: String; var Corres: TCorrespondenceGui);
begin

end;

(*function TBaseForm.ButtoninNotToformatList(btn:TDnmSpeedbutton): boolean;
begin
  result := pos(uppercase(trim(btn.Name)), uppercase(ButtonToExcludeFromFormating)) <> 0;
  if not result then
    result := pos(uppercase(trim(btn.Caption)), uppercase(ButtonToExcludeFromFormating)) <> 0;
end;*)
function TBaseForm.ButtonToExcludeFromFormating: String;
begin
    result := ''
end;

end.



