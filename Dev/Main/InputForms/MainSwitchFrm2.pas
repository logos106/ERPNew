                              unit MainSwitchFrm2;

{

  Date     Version  Who What
  -------- -------- --- ------------------------------------------------------
  03/01/06  1.00.01 BJ  Changed the size of the form as it doesn't fit in a higher resolution.
  01/02/06  1.00.02 DSP Changed FormPaint so if MenuColor is clNone default to
                        clMoneyGreen.
  22/03/06  1.00.03 BJ  When the switch form is closed, closing the hint form if still visible.
  29/03/06  1.00.04 DSP Set the DoubleBuffered property of pnlButtons1 and
                        pnlButtons2 to remove flicker when they are painted.
  03/04/06  1.00.05 DSP Removed check for employee access levels from
                        AddActionButtons. This was redundant and was slowing
                        the display of the 'Manufacturing' panel.
  04/04/06  1.00.07 DSP Fixed memory leak in AddActionButtons. Added private
                        field PackageList to store package names and data
                        module pointers.
  04/05/06  1.00.08 DSP Added FormActivate method.
  10/07/06  1.00.09 DSP Removed unused UnregisterActiveWindow procedure.
  06/09/06  1.00.10 DSP Changed Application.ProcessMessages to Update in
                        FormActivate method to prevent access violations.
}

{$I ERP.inc}

interface

uses
  Windows, BaseFormForm, ExtCtrls, DB, MemDS, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, DNMPanel, Forms, Controls, DNMSpeedButton, Classes,
  StdCtrls, AdvReflectionLabel, ActnList, Graphics,
  MenuCustomiseForm, frmReportSelectorFrm, Shader, AdvPicture, ImageDLLLib,
  AdvOfficeStatusBar,GuiPrefsObj, Mask, wwdbedit, Menus, Messages, MenuCustomiseClasses,
  ImgList, ComCtrls, ToolWin, GripPanel, Types, PageLayoutModifier,
  ProgressDialog;

type
  TMainSwitch2 = class(TBaseForm)
    sbButtons: TScrollBox;
    pnlButtons1: TDNMPanel;
    sbMain: TScrollBox;
    pnlMainButtons: TDNMPanel;
    pnlButtons2: TDNMPanel;
    tmrActiveWindows: TTimer;
    Title: TAdvReflectionLabel;
    Shader1: TShader;
    pnlActivePage: TLabel;
    ReminderTimer: TTimer;
    pnlbotton: TDNMPanel;
    Label1: TLabel;
    btnReports: TDNMSpeedButton;
    btnShowMessagesList: TDNMSpeedButton;
    btnCustomise: TDNMSpeedButton;
    btnShowRemindersList: TDNMSpeedButton;
    btnExit: TDNMSpeedButton;
    edtSearch: TwwDBEdit;
    edtMenuSearch: TwwDBEdit;
    btnWorkflow: TDNMSpeedButton;
    pnlDevOptions: TDNMPanel;
    btnLog: TDNMSpeedButton;
    btnTempfolder: TDNMSpeedButton;
    btnLogforms: TDNMSpeedButton;
    btnDevHints: TDNMSpeedButton;
    btnHowTo: TDNMSpeedButton;
    popLayouts: TPopupMenu;
    mnuEditLayout: TMenuItem;
    mnuEditSave: TMenuItem;
    mnuEditCancel: TMenuItem;
    pnlEditTools: TGripPanel;
    barEditTools: TToolBar;
    toolDeleteBtn: TToolButton;
    toolSaveBtn: TToolButton;
    toolCancelBtn: TToolButton;
    imgEditTools: TImageList;
    toolNewConnectorBtn: TToolButton;
    Image1: TImage;
    toolLoadLayout: TToolButton;
    prgDlgInitERP: TProgressDialog;
    AdvPicture2: TAdvPicture;
    AdvPicture1: TAdvPicture;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MainButtonClick(Sender: TObject);

    procedure btnCustomiseMenuClick(Sender: TObject);
    procedure btnShowRemindersListclick(Sender: TObject);
    procedure tmrActiveWindowsTimer(Sender: TObject);
    procedure ReportsClick(Sender: TObject);
    procedure btnShowMessagesListClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AddMainButtons(Sender:TObject; ignoreLayout:Boolean = False);
    procedure FormActivate(Sender: TObject);
    procedure ReminderTimerTimer(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
//    procedure btnVideosClick(Sender: TObject);
    procedure pnlButtons1Click(Sender: TObject);
    procedure pnlButtons2Click(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pnlButtons2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtMenuSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pnlActivePageDblClick(Sender: TObject);
    procedure edtMenuSearchExit(Sender: TObject);
    procedure btnWorkflowClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure btnTempfolderClick(Sender: TObject);
    procedure btnLogformsClick(Sender: TObject);
    procedure btnDevHintsClick(Sender: TObject);
    procedure btnHowToClick(Sender: TObject);
    procedure DoPageLayoutEdit(Sender: TObject);
    procedure DoPageLayoutSave(Sender: TObject);
    procedure DoPageLayoutCancel(Sender: TObject);
    procedure DoPageLayoutConnector(Sender : TObject);
    procedure toolDeleteBtnClick(Sender: TObject);
    procedure btnUnselectClick(Sender: TObject);
    procedure tollNewButtonBtnClick(Sender: TObject);
    procedure pnlEditToolsMouseEnter(Sender: TObject);
    procedure pnlEditToolsMouseLeave(Sender: TObject);
    procedure pnlEditToolsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure toolLoadLayoutClick(Sender: TObject);
  private
    { Private declarations }
    PanelColor: TColor;
    FButtonCount: integer;
    FMainButtonCount: integer;
    PageConfig: TPageCollection;
    RemindersShownOnce: boolean;
    InstallDoc: boolean;
    MemTransShownOnce: boolean;
    POSAutoLoad: boolean;
    FPanelIndex: byte;
    pnlArray: array[0..1] of TDNMPanel;
    TimerCount: integer;
    fCurrentButtonName:string;
    GuiPrefs: TFormGuiPrefs;
    DashboardDone:boolean;
    KeysPressed:String;
    ButtonCtr:Integer;
    fSelectedbutton:TObject;
    fEditMode: boolean;
    fPageLayoutSelectedItem: TObject;
    fLayoutEdited: boolean;
    fbHowToClickonStartup :Boolean;
    function ButtonCountPerRow: integer;
    function GetReposMainX: integer;
    function GetReposMainY: integer;
    function GetReposX: integer;
    function GetReposY: integer;
    function MaxButtonsPerRow: integer;
    function MaxX: integer;
    function RowCount: integer;
//    function AddActionButtons(const AButtonList: string):Integer;
    function AddActionButtons(APage : TPageItem; ignoreLayout:Boolean = False) : integer;
//    Procedure AddActionButton(const AOwner: TComponent; Action: TAction);
    function AddActionButton(const AOwner: TComponent; Action: TAction) : TERPMainSwitchButton;
    function AddMainButton(const AOwner: TComponent; const ACaption: string; const OnClickEvent: TNotifyEvent = nil):boolean;
    procedure ClearMainButtons;
    procedure ClearActionButtons(const PanelIndex: byte);
    procedure GetDefaultSettings;
    procedure ListActiveWindows;
    procedure RegisterActiveWindow(const ACaption: string; AObject: TObject);
    procedure ShowMemTransList;
    procedure ApplyPreferenceCaption(Action:TAction);
//    procedure LoadResourceFile(aFile:string; ms:TMemoryStream);
    Procedure ShowDashboard;
    Procedure showhint;
    Procedure SetHint;
    function InputPassword:String;
    Function ValidPassword:Boolean;
    procedure GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
    procedure ValidateEmpDefaultClasses;
    Function UserLanguageID:Integer;
    function RegionUserLanguageID: Integer;
    procedure ResizeMenu(BtnCount: Integer; ResizeAnyway:Boolean =False);
    procedure SetFormTop;
    { extra stuff for form caption }
    procedure WMNCPaint(var Msg: TWMNCPaint) ; message WM_NCPAINT;
    procedure WMNCACTIVATE(var Msg: TWMNCActivate) ; message WM_NCACTIVATE;
    procedure DrawCaptionText();
    procedure SetPageLayoutSelectedItem(const Value: TObject);
    procedure SetSelectedButton(const Value: TObject);
    procedure DoProgress(const Value:String);
    //procedure MainButtons;
    property SelectedButton : TObject read fSelectedButton write SetSelectedButton;
    Procedure Centreform;
    Procedure DoProgressdialogProgress(const Value:String);
//    property ModifiedPageList : TStringList read fModifiedStringList write fModifiedStringList;
  Protected
    procedure OnFormShow(Sender: TObject);Override;
    Procedure AfterFormShow; Override;
    procedure HowToAfterShow(Sender : TObject);
    function AddTrainingButtons(const aPageName : string) : integer;
    procedure DoSetEditMode(AEdit : boolean);
    procedure PageLayoutItemSelected(Sender : TObject);
    procedure PageLayoutItemMoving(Sender : TObject; Shift: TShiftState; X, Y: Integer);
    function PageLayoutItemsLinked(AButton, ALine : TObject) : boolean;
    function DoCheckEditMode(Sender : TObject) : boolean;
    procedure DrawLink(APanel : TPanel; ALink : TPageItemDesc);
    procedure ApplyModifiers(APage : TPageItem; APanel : TPanel; const invButtons : string; ignoreLayout:Boolean = False);

    property EditMode : boolean read fEditMode write fEditMode;
    property LayoutEdited : boolean read fLayoutEdited write fLayoutEdited;
    property PageLayoutSelectedItem : TObject read fPageLayoutSelectedItem write SetPageLayoutSelectedItem;
  public
    ActivePageName:String;
    Procedure AfterTranslate; Override;
    { Public declarations }
    function IsFavouriteAction(const ActionName: string): boolean;
    function MaxMainX: integer;
    function MaxMainY: integer;
    function MaxY: integer;
    function RowMainCount: integer;
    function DoReportShow(const ReportName, Groupname: string): TfrmReportSelectorGUI;
    procedure ShowmesageForm;
    procedure Showreminders;
    procedure Docustomise(Sender: TObject);
    Procedure RefreshButtons(Sender: TObject; ignoreLayout:Boolean = False);
    procedure LoadFlagImage;
    Property CurrentButtonName :String read fCurrentButtonName;
    Procedure ReadPosfromGuiPrefs;
    procedure ChangeHeight(const Value: Integer; AddTocurent:Boolean );

  end;

const

  BUTTON_HOT_TRACK_COLOR: TColor = clBtnShadow;
  // action buttons
  BUTTON_WIDTH   = 110;
  BUTTON_HEIGHT  = 95;
  BUTTON_SPACE_X = 18;
  BUTTON_SPACE_Y = 18;
  MIN_OFFSET_X   = BUTTON_SPACE_X + BUTTON_WIDTH;
  MIN_OFFSET_Y   = BUTTON_SPACE_Y + BUTTON_HEIGHT;
  MAX_X          = 400;

  PANEL_HEIGHT_REGULAR = 434;
  PANEL_WIDTH_REGULAR  = 792;
  PANEL_WIDTH_SMALL    = 773;
  // main buttons (categories)
  MAIN_BUTTON_WIDTH   = 148;


  MAIN_BUTTON_HEIGHT  = 28;
  MAIN_BUTTON_SPACE_X = 5;
  MAIN_BUTTON_SPACE_Y = 1;
  MAIN_MIN_OFFSET_X   = MAIN_BUTTON_SPACE_X + MAIN_BUTTON_WIDTH;
  MAIN_MIN_OFFSET_Y   = MAIN_BUTTON_SPACE_Y + MAIN_BUTTON_HEIGHT;
  MAIN_MAX_X          = 400;

  MAIN_PANEL_HEIGHT_REGULAR = 553;
  MAIN_PANEL_WIDTH_REGULAR  = 180;
  MAIN_PANEL_WIDTH_SMALL  = 180;

var
  MainSwitch2: TMainSwitch2;


implementation

{$R *.DFM}

uses FastFuncs,MAIN, CommonDbLib, DNMLib, PackageControl,
       GlobalEventsObj, dmMainGUI, Math, PrefObj,
     ActionsObj, tcConst, CommonLib, frmActivePopup, BarcodeProcessObj,
     ShellAPI, AppEnvironment,SysUtils, GraphUtil, AdvMenus,
     Dialogs, AddinPackageInfoObj,tcTypes, tcDataUtils,
  CompanyPrefObj,strUtils, EmployeeObj, BaseListingForm,
   Globalsearch, VerifynFixPayments, FileDownloadFuncs,
  CommonFormLib, LanguageTranslationObj, StoredProcedures, SalesDashboard,
  DashBoard, frmMessageBase, frmMessageWithList , DNMAction, customInputBox, commonGuiLib ,
  ReminderList, frmShowMeERPOffices, SystemLib, DbSharedObjectsObj ,
  LogLib, HowToListFrm, ImagesDataModule, Menulib, ERPLine, ERPDrawUtils, PageLayoutHistory,
  FileVersion, ERPChanges, ProgressdialogLib, variants;

function TMainSwitch2.DoReportShow(const ReportName, Groupname: string): TfrmReportSelectorGUI;
var
  frmReportSelectorGUI:TfrmReportSelectorGUI;
begin
  Result := Nil;
  if FormStillOpen('TfrmReportSelectorGUI') then TForm(FindExistingComponent('TfrmReportSelectorGUI')).Close;
  Application.ProcessMessages;
  frmReportSelectorGUI := TfrmReportSelectorGUI(GetComponentByClassName('TfrmReportSelectorGUI', true));
  if Assigned(frmReportSelectorGUI) then begin //if has acess
    //GlobalEvents.Notify(frmReportSelectorGUI, GEVENT_AfterCreate);
    Result := frmReportSelectorGUI;
    with frmReportSelectorGUI do begin
      defaultGroup  := GroupName;
      defaultReport := ReportName;
      FormStyle     := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TMainSwitch2.DoSetEditMode(AEdit: boolean);
var
  n : integer;
  idx : integer;
begin

//  btnEditSave.Enabled := AEdit;
//  btnEditCancel.Enabled := AEdit;
  mnuEditSave.Enabled := AEdit;
  mnuEditCancel.Enabled := AEdit;
  n := (FPanelIndex + 1) mod 2;
  if AEdit then begin
    pnlArray[n].Height := 730;
    pnlEditTools.Parent := pnlArray[n];
    pnlEditTools.Left := pnlArray[n].Width - pnlEditTools.Width - 4;
    pnlEditTools.Top := pnlArray[n].Height - pnlEditTools.Height - 4;
    pnlEditTools.Visible := true;
//    pnlACtivePage.Color := $C1C2FF;
    Shader1.FromColor := $C1C2FF;
  end
  else begin
    pnlEditTools.Visible := false;
//    pnlActivePage.Color := clBtnFace;

    Shader1.FromColor := clBtnFace;
    if Appenv.Employee.UseERPButtonColor then begin
      Shader1.FromColor := Appenv.Employee.ERPButtonColor;
      Shader1.ToColorMirror := Appenv.Employee.ERPButtonColor;
      Shader1.ToColor := Appenv.Employee.ERPButtonColor;
      Shader1.FromColorMirror := Appenv.Employee.ERPButtonColor;
      pnlActivePage.Font.Color :=Appenv.Employee.ERPButtonFontColor;
    end;

    if EditMode then
      for idx := 0 to pnlArray[n].ComponentCount - 1 do
        if pnlArray[n].Components[idx] is TERPMainSwitchMovingButton then
        begin
          TERPMainSwitchMovingButton(pnlArray[n].Components[idx]).StopMoving;
          TERPMainSwitchMovingButton(pnlArray[n].Components[idx]).Selected := false; //CancelMoving
        end
        else if pnlArray[n].Components[idx] is TLine then
        begin
          TLine(pnlArray[n].Components[idx]).AllowSelect := false;
        end;
  end;
  if not AEdit then
    LayoutEdited := false;
  EditMode := AEdit; //  be careful - it must be the last thing in the proc
end;

procedure TMainSwitch2.DrawCaptionText;
var
  canvas: TCanvas;
begin
 canvas := TCanvas.Create;
 try
   canvas.Handle := GetWindowDC(Self.Handle) ;
   with canvas do begin
     Brush.Style := bsClear;
     Font.Color := clInactiveCaptionText;
     Font.Name := 'Arial';
     Font.Size := 9;
     Font.Style := [fsBold];

     TextOut(Self.Width - 10 - TextWidth(Trim(Appenv.Employee.EmployeeName)), 6, Trim(Appenv.Employee.EmployeeName)) ;
   end;
 finally
   ReleaseDC(Self.Handle, canvas.Handle) ;
   canvas.Free;
 end;
end;

procedure TMainSwitch2.DrawLink(APanel: TPanel; ALink: TPageItemDesc);
var
  l : TLine;

  function ActButton(const aName : string) : TControl;
  var
    idx : integer;
  begin
    for idx := 0 to APanel.ComponentCount -1 do
      if APanel.Components[idx] is TERPMainSwitchMovingButton then
        if SameText(TERPMainSwitchMovingButton(APanel.Components[idx]).Action.Name, AName) then
        begin
          Result := TControl(APanel.Components[idx]);
          exit;
        end;
    Result := nil;
  end;

begin
  if Not Assigned(ALink) then
    exit;
  if not assigned(APanel) then
    exit;
  l := TLine.Create(APanel);
  l.LineWidth := ALink.LineWidth;
  if ALink.LineHeads <> 0 then
  begin
    l.Arrow1 := (ALink.LineHeads and 1) <> 0;
    l.Arrow2 := (ALink.LineHeads and 2) <> 0;
  end;
  l.StartPoint := Point(ALink.Left, ALink.Top);
  l.EndPoint := Point(ALink.Width, ALink.Height);
  l.Align := alClient;
  if ALink.ActionName <> '' then
    l.ActionFrom := ActButton(ALink.ActionName);
  if ALink.EndActionName <> '' then
    l.ActionTo := ActButton(ALink.EndActionName);
  l.LineColor := ALink.LineColor;
  l.MarkSize := ALink.MarkSize;
  l.MarkColor := ALink.MarkColor;
  l.SelectedColor := ALink.SelectedColor;
  l.OnSelected := PageLayoutItemSelected;
  l.LineStyle := ALink.LineStyle;
  l.ArrowColor := ALink.ArrowColor;
  l.Arrow1Kind := ALink.Arrow1Kind;
  l.Arrow2Kind := ALink.Arrow2Kind;
  l.AllowSelect := EditMode;
  l.Parent := APanel;
  l.Visible := true;
  l.BringToFront;


end;

{ this is called from frmMainModuleSales
  which does not have MainSwitchFrm in its 'Uses' clause
  it sets required parameters in MethodParms.Items }

procedure TMainSwitch2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if fCurrentButtonName <> '' then
    GuiPrefs.Node['LastMainButton.Name'].AsString:= fCurrentButtonName;

   GuiPrefs.Node['window.height'].asInteger := MainSwitch2.height;
   GuiPrefs.Node['window.Top'].asInteger := MainSwitch2.Top;

       if TLanguageTranslationObj.Inst.UserLanguageID = EnglishLanguageID    then GuiPrefs.Node['UseRegionalLanguage.ID'].asInteger := 0
  else if TLanguageTranslationObj.Inst.UserLanguageID = RegionUserLanguageID then GuiPrefs.Node['UseRegionalLanguage.ID'].asInteger := 0
  else GuiPrefs.Node['UseRegionalLanguage.ID'].asInteger := TLanguageTranslationObj.Inst.UserLanguageID;


  GuiPrefs.SavePrefs;
//  Application.MainForm.Close;  { this was causing AV when MAIN was closing this form }
  MainSwitch2 := nil;
end;
procedure TMainSwitch2.ValidateEmpDefaultClasses;
var
  ds:TERPQuery;
begin
  if not devmode then exit;
    ds:= TempMyQuery;
    try
      ds.SQL.Add('Select EmployeeName, DefaultClassname , if(C.active="F", "Inactive" , "Doesn''t Exist") as comments ' +
              ' from tblemployees E left join tblclass c on E.DefaultClassID = C.ClassID' +
              ' where (ifnull(C.ClassId,0)=0 or C.active ="F") and ifnull(E.DefaultClassID,0)<> 0');
      ds.open;
      if ds.recordcount >0 then begin
          InitMsgParams;
            PopupMsgParams.Msgcaption := 'Warning';
            PopupMsgParams.Msgds := ds;
            PopupMsgParams.fieldnames := 'EmployeeName,DefaultClassname,comments';
            PopupMsgParams.displayLabels:= 'Employee,' +Appenv.DefaultClass.classheading+',Comments';
            PopupMsgParams.Custombuttons := 'OK';
            PopupMsgParams.Msg1:='The following Employee(s) have a Default ' + Appenv.DefaultClass.classheading +' which either Doesn''t exists or is inactive';
            PopupMsgParams.Msg2 := 'Please Create/Activate those '+ Appenv.DefaultClass.classheading +'(s) or '+chr(13)+'change the Employee''s Default ' + Appenv.DefaultClass.classheading +'.' ;
            PopupMsgParams.MsgColor := Self.Color;
            TfmMessageWithList.MsgDlg;
      end;
  finally
    ds.ClosenFree;
  end;

end;
procedure TMainSwitch2.DoProgress(const Value:String);
begin
  if Assigned(MainForm) then
    MainForm.DoProgressdialogProgress(Value);
end;
procedure TMainSwitch2.FormShow(Sender: TObject);
  function DEvmodeUserName:String;
  begin
    result:= '';
    if not devmode then exit;
    result := '<FONT color="clblack" face="times new Roman" size="12">      ('+ Application.ExeName+'  /d:'+Appenv.AppDB.Server +'.'+  Appenv.AppDB.Database+')</FONT>';
  end;

  Procedure Inittitle;
  begin
    if devmode then begin
      Title.HTMLText.Text := '<P align="center"><FONT color="#494949" face="Verdana" size="24"><SHAD>'+Trim(CommonDbLib.GetCompanyName(true))+ '</SHAD></FONT>' + Devmodeusername+'</P>';
      Title.showhint := True;
      Title.hint :=CommonDbLib.GetCompanyName(true)+ NL+  Application.ExeName+'  /d:'+Appenv.AppDB.Server +'.'+  Appenv.AppDB.Database+NL;
    end else begin
    Title.HTMLText.Text := '<P align="center"><FONT color="#494949" face="Verdana" size="24"><SHAD>'+Trim(CommonDbLib.GetCompanyName(true))+ '</SHAD></FONT>'+
                            {'<FONT COLOR="#666633"><B>' + '   ' +trim(Appenv.Employee.EmployeeName)+'   '+'</B></FONT>}'</P>';
    end;
  end;

begin
  centreform;

  pnlDevOptions.Visible := devmode;

  btnWorkflow.Visible := AppEnv.CompanyPrefs.UseWorkFlow;

  edtMenuSearch.visible := False;
  CreateSPs(DoProgress);
  // normalise the form caption
  Self.Caption := MAIN_MENU_CAPTION;
  Title.HTMLText.Text := '<P align="center"><FONT color="#494949" face="Verdana" size="24"><SHAD>'+CommonDbLib.GetCompanyName(true)+ '</SHAD></FONT></P>';
  Inittitle;

  Title.BringToFront;
  BtnExit.BringToFront;
  MainForm.Caption := Application.Title+' - ' + Title.Caption + '   ( Version :- ' + FileVersion.GetFileVersion(Application.ExeName) + ' )';
  {$IFDEF BETAVERSION}
  MainForm.Caption := Application.Title+' - ' + Title.Caption + '   ( Version :- ' + FileVersion.GetFileVersion(Application.ExeName) + '  BETA)';
  {$ENDIF}
  {$IFDEF ALPHAVERSION}
  MainForm.Caption := Application.Title+' - ' + Title.Caption + '   ( Version :- ' + FileVersion.GetFileVersion(Application.ExeName) + '  ALPHA)';
  {$ENDIF}

  MainForm.OriginalCaption := '';


  AddMainButtons(Self);
  inherited;


  PanelColor := self.color;//ColorAdjustLuma(GetGradientColor(Self.ClassName).Color,GetGradientColor(Self.ClassName).AdjLuma div 2, False);
  pnlButtons1.Color := PanelColor;
  pnlButtons2.Color := PanelColor;
  pnlMainButtons.Color := PanelColor;

  InvalidateComponents(Self);


  LoadFlagImage;
  fCurrentButtonName := 'Getting Started';
  SetHint;
  showhint;
  TLanguageTranslationObj.Inst.IsERPRunning:= True;

  DoSetEditMode(false);
  Setcontrolfocus(edtSearch);

end;

procedure TMainSwitch2.FormCreate(Sender: TObject);
begin
  fbHowToClickonStartup := False;
  pnlMainButtons.Left := 0;
  pnlMainButtons.top := 0;
  Self.DoubleBuffered := True;
  GlobalEvents.RegisterNameHandler(Self, '', '', GEVENT_AnyActionExecuting, GlobalEventHandler);
  GlobalEvents.RegisterNameHandler(Self, '', '', GEVENT_AnyActionExecuted, GlobalEventHandler);
  inherited;
  //
  // Removes flicker from panels when they are painted
  //
//  ModifiedPageList := TStringList.Create;
//  ModifiedPageList.CaseSensitive := false;
  Selectedbutton:=nil;
  ButtonCtr:= 0;
  DashboardDone := False;
  pnlButtons1.DoubleBuffered := True;
  pnlButtons2.DoubleBuffered := True;

  RemindersShownOnce := false;
  InstallDoc := false;
  MainSwitch2 := self;
  GlobalEvents.Notify(Self, GEVENT_FormCreate_After);

  FButtonCount := 0;
  FMainButtonCount := 0;
  FPanelIndex := 0;
  TimerCount:=0;
  pnlArray[0] := pnlButtons1;
  pnlArray[1] := pnlButtons2;
  PageConfig := TPageCollection.Create;
  GuiPrefs := TFormGuiPrefs.Create(self);
  GuiPrefs.Active := True;
  ValidateEmpDefaultClasses;
end;

procedure TMainSwitch2.ShowMemTransList;
var
  dtFrom: TDateTime;
  dtTo: TDateTime;
begin
  with TERPQuery.Create(Self) do try
      Options.FlatBuffers := True;
      Connection := CommonDbLib.GetSharedMyDacConnection;
      // First we need to ensure that the default dates
      // are within range of this query
      dtFrom := Date - AppEnv.Employee.ListDaysPast;
      dtTo := Date + AppEnv.Employee.ListDaysFuture;

      SQL.Clear;
      SQL.Add('SELECT MemTransID,DateDue');
      SQL.Add('FROM tblMemTrans');
      SQL.Add('WHERE (DateDue BETWEEN :xDate1 AND :xDate2) AND ');
      SQL.Add('((DateDue-' + IntToStr(AppEnv.Employee.MemTransAppearDays) + ') <= CURDATE())');
      Params.ParamByName('xDate1').AsDateTime := dtFrom;
      Params.ParamByName('xDate2').AsDateTime := dtTo;
      Open;

      // Any records viewable?
      if not IsEmpty then begin
        // Yes, show the Memorised Transactions List Form.
        dtmMainGUI.actAccountsMemorisedTransactionList.Execute;
      end;
      MemTransShownOnce := true;
      Application.ProcessMessages;
    finally
      Free;
    end;
end;

procedure TMainSwitch2.ApplyModifiers(APage: TPageItem; APanel: TPanel; const invButtons : string; ignoreLayout:Boolean = False);
var
  btn: TERPMainSwitchMovingButton;
  I: integer;
  M: TPageItemDesc;
  SL: TStringList;
  Desc: TPageItemDesc;
  qry : TERPQuery;
  PanelHeight, BottomY : Integer;
begin
  // Fix positions for edited stuff
  if not Assigned(APanel) or not Assigned(APage) then
    Exit;

  if (APage.PageModifier = nil) or (APage.PageModifier.Count = 0) then
    Exit;

  if devmode then Exit;

  // Check if this page is set default
  qry := TempMyQuery;
  qry.SQL.Add('SELECT IsDefault FROM tblPageLayout WHERE PageName="' + APage.PageName + '"');
  qry.SQL.Add('AND Active="T"');
  qry.SQL.Add('AND UserId=' + IntToStr(AppEnv.Employee.EmployeeID));
  qry.SQL.Add('AND IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId));
  qry.Open;
  if (qry.RecordCount > 0) and (qry.FieldByName('IsDefault').AsString = 'T') then Exit;

  SL := TStringList.Create;
  SL.CaseSensitive := False;
  if invButtons <> '' then
    SL.CommaText := invButtons;
  SL.Sort;

  try
    // Delete modifiers for invisible buttons
    for I := 0 to SL.Count - 1 do
      APage.PageModifier.DeleteButton(SL[i]);

    for I := APanel.ComponentCount - 1 downto 0 do begin
      if (APanel.Components[I] is TERPMainSwitchMovingButton) then begin
        btn := TERPMainSwitchMovingButton(APanel.Components[I]);
        M := APage.PageModifier.ButtonDescriptor[btn.Action.Name];
        if Assigned(M) then begin
          btn.Left := M.Left;
          btn.Top := M.Top;
          btn.Width := M.Width;
          btn.Height := M.Height;

          BottomY := btn.Top + MENU_MIN_OFFSET_Y;
          PanelHeight := TWinControl(APanel).Height;
          if BottomY > PanelHeight then begin
            // grow the owner
            TWinControl(APanel).Height := PanelHeight + (BottomY - PanelHeight);
          end;
        end
        else if not(ignoreLayout) then
          // The button was removed from layout
          APanel.Components[I].Free
        else begin
          Desc := TPageItemDesc.Create;
          Desc.NodeType := mtButton;
          Desc.Left := btn.Left;
          Desc.Top := btn.top;
          Desc.Width := btn.Width;
          Desc.Height := btn.Height;
          Desc.ActionName := btn.Action.Name;
          APage.PageModifier.AddLinkDescriptor(Desc);
          APage.PageModifier.Save;
          MessageDlgXP_Vista('Option is Added to the Main Menu Switch on '+ quotedStr(APage.PageModifier.pagename), mtWarning, [mbOK], 0);
        end;
      end
      else if (APanel.Components[I] is TLine) then
        APanel.Components[I].Free;  // remove all except buttons
        (*
        else
        begin
          l := TLine(APanel.Components[i]);
          Done := false;
          for k := 0 to APage.PageModifier.Count - 1 do
            if APage.PageModifier.Items[k].NodeType = mtLink then
            begin
              m := APage.PageModifier.Items[k];
              if ((not assigned(l.ActionFrom) and (m.ActionName='')) or (l.ActionFrom.Action.Name = m.ActionName)) and
                 ((not assigned(l.ActionTo) and (m.EndActionName='')) or (l.ActionTo.Action.Name = m.EndActionName)) then
              begin
                DrawLink(APanel, APage.PageModifier.Items[i]);
                Done := true;
                Break;
              end;
            end;
          if not Done then
            APanel.Components[i].Free;
        end;
        *)
    end;
  finally
    SL.Free;
  end;

  // Now draw connectors
  for I := 0 to APage.PageModifier.Count - 1 do begin
    if APage.PageModifier.Items[I].NodeType = mtLink then begin
      DrawLink(APanel, APage.PageModifier.Items[I]);
    end;
  end;
end;

procedure TMainSwitch2.ApplyPreferenceCaption(Action:TAction);
begin
   if Action = nil then exit;
//   if Action.Name = 'actApptsNewRepair' then begin
//    if AppEnv.CompanyPrefs.RepairTitle<>'' then
//            Action.Caption:='New '+AppEnv.CompanyPrefs.RepairTitle;
//   end;
//   if Action.Name = 'actApptsRepairsList' then begin
//    if AppEnv.CompanyPrefs.RepairTitle<>'' then
//            Action.Caption:=AppEnv.CompanyPrefs.RepairTitle+' List';
//   end;
   if Action.Name = 'actApptsNewJob' then begin
    if AppEnv.CompanyPrefs.JobTitle<>'' then
      Action.Caption:=  TLanguageTranslationObj.Inst.DoTranslate('New '+AppEnv.CompanyPrefs.JobTitle, TLanguageTranslationObj.Inst.UserLanguageID, []);
   end;
   if Action.Name = 'actApptsJobList' then begin
    if AppEnv.CompanyPrefs.JobTitle<>'' then
      Action.Caption:=  TLanguageTranslationObj.Inst.DoTranslate(AppEnv.CompanyPrefs.JobTitle+' List', TLanguageTranslationObj.Inst.UserLanguageID, []);
   end;
end;

function TMainSwitch2.AddActionButtons //(const AButtonList: string):Integer;
  (APage: TPageItem; ignoreLayout:Boolean = False) : integer;
var
  I: integer;
  Action: TAction;
  List: TStrings;
  {var for packages}
  J: integer;
  SelAddinInfo: TAddinPackageInfo;
  btnAction: string;
  {declare for RTTI method}
  invButtons: string;
begin
  invButtons := '';
  Result := 0;

  try
    ClearActionButtons((FPanelIndex + 1) mod 2);
    List := TStringList.Create;

    try
      //List.CommaText := AButtonList;
      List.CommaText := APage.ButtonList;

      if List.Count > 0 then begin
        for I := 0 to List.Count - 1 do begin
          Action := dtmMainGUI.ActionHelper.ActionByName[List[I]];

          if Assigned(Action) then begin
            if Action.Enabled And Action.Visible then begin
              ApplyPreferenceCaption(Action);
              AddActionButton(pnlArray[FPanelIndex], Action);
              Result := Result + 1;
            end
            else begin
             if invButtons = '' then
               invButtons := Action.Name
             else
               invButtons := invButtons + ',' + Action.Name;
            end;
          end
          else begin
            //  now load from any packages
            for J := 0 to AddinPackageList.Count - 1 do begin
              SelAddinInfo := TAddinPackageInfo(AddinPackageList[J]);

              if Assigned(SelAddinInfo.GuiDataModule) then begin
                btnaction := List[I];
                Action := SelAddinInfo.GuiDataModule.GetAction(btnaction);
                if Assigned(Action) then begin
                  Action.Enabled := TRue;
                  ApplyPreferenceCaption(Action);
                  AddActionButton(pnlArray[FPanelIndex], Action);
                  Result := Result + 1;
                  Break;                                                        {Assume the first actionname found can be the only one}
                end;
              end        {if}
            end;         {for}
          end;           {if}
        end;             {for}
      end;  // if List.Count > 0
      // HowTo extra buttons

      if not Assigned(APage.PageModifier) or (APage.PageModifier.Id = 0)  then
        APage.Save(pnlArray[FPanelIndex]);

      ApplyModifiers(APage, pnlArray[FPanelIndex], invButtons, ignoreLayout);

    finally
      FreeAndNil(List);
    end;
  finally
    pnlArray[FPanelIndex].BringToFront;
    FPanelIndex := (FPanelIndex + 1) mod 2;
    btnShowRemindersList.BringToFront;
  end;
end;

function TMainSwitch2.IsFavouriteAction(const ActionName: string): boolean;
begin
  Result := true; // this needs to be changed further down the track
end;

//ocedure TMainSwitch2.AddActionButton(const AOwner: TComponent; Action: TAction);
function TMainSwitch2.AddActionButton(const AOwner: TComponent; Action: TAction) : TERPMainSwitchButton;
var
  Button: TERPMainSwitchButton;
  PanelHeight, BottomY: integer;

  procedure HandleMainComponentError;
  Begin
    Try
      Randomize;
      Button.Name := 'MainmenuActionbtn_'+ValidateForName(pnlActivePage.Caption)+'_' + Action.Name+ '_'+IntToStr(Random(50));
    except
      on EComponentError do HandleMainComponentError;
    end;
  end;
begin
  Result := nil;  // Make compiler happy

  if not(assigned(Action)) or (Action.visible and action.enabled) then begin
    //Logcomponents(Self, Self.Name+'.');
    //Button := TDNMSpeedButton.Create(AOwner);
    //      Button := TERPMainSwitchButton.Create(AOwner);  // ##################
    Button := TERPMainSwitchMovingButton.Create(AOwner);
    Button.Parent := TWinControl(AOwner);
    Button.Font.Style := Button.Font.Style - [fsBold];
    Button.Font.Size := 8;
    Button.Top := GetReposY + MENU_BUTTON_SPACE_X;
    //Button.Singlecolor :=       $00FFE9D2;
    //Button.colors := vararrayof([$00FFE9D2,Appenv.Employee.ERPButtonColor, $00EBC1AB, $00FBF2EE]);
    Button.colors := vararrayof([$00FFE9D2, Appenv.Employee.ERPButtonColor, Appenv.Employee.ERPButtonHTColor, clWhite]);

    Button.TabStop := True;


    BottomY := Button.Top + MENU_MIN_OFFSET_Y;

    PanelHeight := TWinControl(AOwner).Height;
    if BottomY > PanelHeight then begin
      // grow the owner
      TWinControl(AOwner).Height := PanelHeight + (BottomY - PanelHeight);
      TWinControl(AOwner).Width  := PANEL_WIDTH_SMALL;
    end;

    Button.Left := GetReposX + MENU_BUTTON_SPACE_Y;
    Button.Height := BUTTON_HEIGHT;
    Button.Width := BUTTON_WIDTH;
    if Assigned(Action) then begin
      Button.DnMAction := Action;
      //if Action is tDnMAction then Button.color := TDNMAction(Action).buttoncolor;
      Try
        //Button.Name   := 'MainmenuActionbtn_'+ValidateForName(pnlActivePage.Caption)+'_' + Action.Name;
        Button.Name   := 'MainmenuActionbtn_'+ValidateForName(TLanguageTranslationObj.Inst.DoTranslateToEnglish(trim(pnlActivePage.Caption)))+'_' + Action.Name;

      except
        on EComponentError do HandleMainComponentError;
      end;
    end;

    //Button.Alignment := taCenter;
    //Button.Layout := DNMSpeedButton.blGlyphTop;
    //Button.SlowDecease := true;
    //Button.HotTrackColor := BUTTON_HOT_TRACK_COLOR;
    //Button.Style := bsModern;
    //Button.Visible := true;
    Button.BringToFront;
    Button.WordWrap := true;
    //  Button.OnMouseEnter := ActionButtonMouseEnter;
    Inc(FButtonCount);
    Result := Button;
  end;
end;

function TMainSwitch2.GetReposX: integer;
begin
  Result := ButtonCountPerRow * MIN_OFFSET_X;
end;

function TMainSwitch2.GetReposY: integer;
begin
  Result := RowCount * MIN_OFFSET_Y;

  if ButtonCountPerRow >= MaxButtonsPerRow then Result := Result + MIN_OFFSET_Y;
end;

procedure TMainSwitch2.GlobalEventHandler(const Sender: TObject;
  const Event: string; const Data: Pointer);
begin
  if sameText(Event , GEVENT_AnyActionExecuting)  then begin
    pnlButtons2.Enabled     := False;
    pnlMainButtons.Enabled  := False;
    pnlbotton.Enabled       := False;
  end else if sameText(Event , GEVENT_AnyActionExecuted)  then begin
    pnlButtons2.Enabled    := True;
    pnlMainButtons.Enabled := True;
    pnlbotton.Enabled      := True;
  end;
end;

procedure TMainSwitch2.HowToAfterShow(Sender: TObject);
begin
  if Sender is THowToListGUI then
    (Sender as THowToListGUI).SetGrpFilters;
end;

function TMainSwitch2.ButtonCountPerRow: integer;
begin
  // returns number of existing buttons on the last populated row
  Result := FButtonCount - (RowCount * MaxButtonsPerRow);
end;

function TMainSwitch2.MaxButtonsPerRow: integer;
begin
  // maximum number of buttons that can fit in the row
  Result := MaxX div MIN_OFFSET_X;
end;

function TMainSwitch2.RowCount: integer;
begin
  if FButtonCount = 0 then Result := 0
  else Result := FButtonCount div MaxButtonsPerRow;
end;

function TMainSwitch2.MaxX: integer;
begin
  //  Result := pnlButtons.Width - (2 * BUTTON_SPACE_X);
  Result := pnlArray[FPanelIndex].Width;
end;

function TMainSwitch2.MaxY: integer;
begin
  Result := pnlArray[FPanelIndex].Height - (2 * BUTTON_SPACE_Y);
end;

procedure TMainSwitch2.Centreform;
begin
  Top := (Screen.Height - Height) div 2 - Mainform.ClientOrigin.Y - Mainform.MainToolBar.Height +Mainform.StatusBar.Height;
  Left := (Screen.Width - Width) div 2;
  if Width > Screen.Width- Left  then Left := 0;
end;

procedure TMainSwitch2.ClearActionButtons(const PanelIndex: byte);
var
  I: integer;
begin
  I := 0;
  while I < pnlArray[PanelIndex].ComponentCount do begin
    if pnlArray[PanelIndex].Components[I] is TERPMainSwitchButton then begin
      Try
        pnlArray[PanelIndex].Components[I].Free;
      except
      end;
    end else if pnlArray[PanelIndex].Components[I] is TLine then
      pnlArray[PanelIndex].Components[I].Free
    else
      Inc(I);
  end;
  pnlArray[PanelIndex].Width := PANEL_WIDTH_REGULAR;
  pnlArray[PanelIndex].Height := PANEL_HEIGHT_REGULAR;
  FButtonCount := 0;
end;

function TMainSwitch2.AddMainButton(const AOwner: TComponent; const ACaption: string; const OnClickEvent: TNotifyEvent = nil):boolean;
var
  Button: TERPMainSwitchButton(*TDNMSpeedButton*);
  PanelHeight, BottomY: integer;
  mnuitem: TMenuItem;

  function MenuItemByCaption(aMainMenu: TMainMenu; aCaption: string): TMenuItem;
    var i: integer;

    function ItemByCaption(aMenu: TMenuItem; aCaption: string): TMenuItem;
    var x: integer;
    begin
      result:= aMenu.Find(aCaption);
      if not Assigned(result) then begin
        for x := 0 to aMenu.Count -1 do begin
          result:= ItemByCaption(aMenu.Items[x],aCaption);
          if Assigned(result) then
            break;
        end;
      end;
    end;

  begin
    result:= aMainMenu.Items.Find(aCaption);
    if not Assigned(result) then begin
      for i := 0 to aMainMenu.Items.Count -1 do begin
        result:= ItemByCaption(aMainMenu.Items[i],aCaption);
        if Assigned(result) then
          break;
      end;
    end;
  end;

  Function FindMenu(Const mnuCaption:String):TMenuItem;
  begin
    result := nil;
    if MainForm.Menu= nil then exit;
    result:= MenuItemByCaption(MainForm.Menu,mnuCaption);
    if Assigned(result) then exit;
    Result:= MenuItemByCaption(MainForm.Menu,DoTranslate(mnuCaption));
  end;
begin
  Result:=false;
  {check for the user preference}

{ TODO -oIanos : LOOK / FIX to Use NEW Menus ?? }
  if ACaption = 'Employee' then  begin
      mnuitem:= FindMenu('Employee');
      if not Assigned(mnuitem) then Exit;
      if mnuitem.Visible=false then exit;
  end;

  if ACaption = 'Accounts' then begin
      mnuitem:= FindMenu('Accounts');
      if not Assigned(mnuitem) then Exit;
      if mnuitem.Visible=false then exit;
  end;

  if ACaption = 'Google' then begin
    If not(AppEnv.CompanyPrefs.UseGoogleAnalytics) then Exit;
  end;

  if ACaption = 'Budget' then begin
      mnuitem:= FindMenu('Budget');
      if not Assigned(mnuitem) then Exit;
      if mnuitem.Visible=false then exit;
  end;

  if ACaption = 'Payroll' then begin
      mnuitem:= FindMenu('Payroll');
      if not Assigned(mnuitem) then Exit;
      if mnuitem.Visible=false then exit;
  end;

  if ACaption = 'Delivery' then begin
      mnuitem:=  FindMenu('Manifest');
      if not Assigned(mnuitem) then Exit;
      mnuitem.visible:=AppEnv.CompanyPrefs.UseDelivery;
      mnuitem.enabled:=AppEnv.CompanyPrefs.UseDelivery;
      if mnuitem.Visible=false then exit;
  end;

  if (ACaption = 'CRM') then begin
      mnuitem:= FindMenu('CRM');
      if not Assigned(mnuitem) then Exit;
      mnuitem.visible:=AppEnv.CompanyPrefs.UseCRM;
      mnuitem.enabled:=AppEnv.CompanyPrefs.UseCRM;
      if mnuitem.Visible=false then exit;
  end;

  if (ACaption = 'Price Schemes') then begin
      mnuitem:= FindMenu('Price Schemes');
      if not Assigned(mnuitem) then Exit;
      mnuitem.visible:=AppEnv.CompanyPrefs.UsePriceSchemes;
      mnuitem.enabled:=AppEnv.CompanyPrefs.UsePriceSchemes;
      if mnuitem.Visible=false then exit;
  end;

  if (ACaption = 'Marketing') then begin
      mnuitem:= FindMenu('Marketing');
      if not Assigned(mnuitem) then Exit;
      mnuitem.visible:=AppEnv.CompanyPrefs.UseCRM;
      mnuitem.enabled:=AppEnv.CompanyPrefs.UseCRM;
      if mnuitem.Visible=false then exit;
  end;

  if ACaption = 'Fixed Assets' then begin
      mnuitem:= FindMenu('Fixed Assets');
      if not Assigned(mnuitem) then Exit;
      if AppEnv.CompanyPrefs.UseFixedAssets =  false then begin
          {turn off menu}
          mnuitem.visible:=false;
          mnuitem.enabled:=false;
          Exit;
      end;
     if mnuitem.Visible=false then exit;
  end;

  if (ACaption = 'Workshop') then begin
      mnuitem:= FindMenu('Workshop');
      if not Assigned(mnuitem) then Exit;
      if not AppEnv.CompanyPrefs.UseWorkShop then begin
        mnuitem.visible := false;
        mnuitem.enabled := false;
        exit;
      end;
  end;

  if (sametext(ACaption, 'Workflow')) then begin
      mnuitem:= FindMenu('Workflow');
      if not Assigned(mnuitem) then Exit;
      if not AppEnv.CompanyPrefs.UseWorkflow then begin
        mnuitem.visible := false;
        mnuitem.enabled := false;
        exit;
      end;
  end;

  if (sametext(ACaption, 'Hire')) then begin
      mnuitem:= FindMenu('Hire');
      if not Assigned(mnuitem) then Exit;
      if not AppEnv.CompanyPrefs.UseHire then begin
        mnuitem.visible := false;
        mnuitem.enabled := false;
        exit;
      end;
  end;

//  if ACaption = 'Assessment' then begin
//      mnuitem:=MainForm.Menu.Items.Find('General');
//      if Assigned(mnuitem) then
//        mnuitem:= mnuitem.Find('Assessment');
//      if not Assigned(mnuitem) then Exit;
//      if AppEnv.CompanyPrefs.UseAssessment = False   then begin
//          {turn off menu}
//          mnuitem.visible:=false;
//          mnuitem.enabled:=false;
//          Exit;
//      end;
//     if mnuitem.Visible=false then exit;
//  end;

  if ACaption = 'Manufacturing' then begin
      mnuitem:= FindMenu('Manufacturing');
      if not Assigned(mnuitem) then Exit;
      if AppEnv.CompanyPrefs.UseManufacturing = False then begin
          {turn off menu}
          mnuitem.visible:=false;
          mnuitem.enabled:=false;
          Exit;
      end;
      if mnuitem.Visible=false then exit;
  end;

  if (ACaption = 'Manufacturing Setup') and (AppEnv.CompanyPrefs.UseManufacturing = False) then
    exit;

  if ACaption = 'Appointment' then begin
      mnuitem:= FindMenu('Appointment');
      if not Assigned(mnuitem) then Exit;
      if mnuitem.Visible=false then exit;
  end;

  if ACaption = 'Utilities' then begin
      mnuitem:= FindMenu('Utilities');
      if not Assigned(mnuitem) then Exit;
      if mnuitem.Visible=false then exit;
  end;
   if (ACaption = 'Repairs') and (MainForm.Menu <> nil) then begin
    if MainForm.Menu.Items.Find('Manufacturing') <> nil then begin
      mnuitem:= FindMenu('Manufacturing').find(ACaption);
      if not Assigned(mnuitem) then Exit;
      if mnuitem.Visible=false then exit;
    end;
  end;

  if ACaption = 'EDI and Integration' then begin
    If not(AppEnv.CompanyPrefs.ShowEdiIntegration) then Exit;
  end;

  if ACaption = 'Ebay' then begin
    If not(AppEnv.CompanyPrefs.ShowEbayonMainMenubyDefault) then Exit;
  end;

  if ACaption = 'Walmart' then begin
    If not(AppEnv.CompanyPrefs.EnableWalmart) then Exit;
  end;

  Button := TERPMainSwitchButton(*TDNMSpeedButton*).Create(Self);
  //Button.MaxTextDisplay := False;
  Button.Caption := Commonlib.ApplyPreferenceNames(ACaption);
  Button.Helpcontext :=  Self.Helpcontext + MainMenuHelpcontextID(ACaption);
  Button.Parent := TWinControl(AOwner);
  Button.ParentFont := false;
  //Button.ParentColor := false;
  //Button.Color := MENU_BUTTON_COLOR;
  Button.Font.Style := Button.Font.Style - [fsBold];
  Button.Font.Size := 10;
  Button.Top := GetReposMainY (*+ MAIN_BUTTON_SPACE_Y*);

  BottomY := Button.Top + MAIN_MIN_OFFSET_Y;

  PanelHeight := TWinControl(AOwner).Height;
  SBMain.AutoScroll:=false;
  if BottomY > PanelHeight then begin
    // grow the owner
    TWinControl(AOwner).Height := PanelHeight + (BottomY - PanelHeight);
    //TWinControl(AOwner).Width  := MAIN_PANEL_WIDTH_SMALL;
    SBMain.AutoScroll:=true;
  end;

  Button.Left := GetReposMainX + MAIN_BUTTON_SPACE_X;
  Button.Height := MAIN_BUTTON_HEIGHT;
  Button.Width := MAIN_BUTTON_WIDTH;
  Button.Action := Action;
  //Button.Alignment := taCenter;
  //Button.Layout := DNMSpeedButton.blGlyphTop;
  //Button.SlowDecease := true;
  //Button.HotTrackColor := BUTTON_HOT_TRACK_COLOR;
  //Button.Style := bsModern;
  Button.Visible := true;
  Button.BringToFront;
  Button.WordWrap := true;
  (*Button.Align := AlTop;
  Button.Alignwithmargins := True;
  Button.Margins.Left := 3;
  Button.Margins.right := 3;
  Button.Margins.Top :=0;
  Button.Margins.Bottom := 0;*)
  Button.colors := vararrayof([clwhite,clSilver, $00EBC1AB, $00FBF2EE]);
  Button.colors := vararrayof([clwhite,clSilver, Appenv.Employee.ERPButtonHTColor, clWhite]);
  //Button.colors := vararrayof([clwhite,Appenv.Employee.ERPButtonColor, Appenv.Employee.ERPButtonHTColor, clWhite]);


  //Button.ShadowColor := clwhite;//$00BCBCBC;

  Result:=true;
  inc(ButtonCtr);
  Button.name := 'mainmenusidepanelbtn_'+ValidateForName(Button.Caption);
  if Assigned(OnClickEvent) then Button.OnClick := OnClickEvent
  else Button.OnClick := MainButtonClick;
  Inc(FMainButtonCount);
end;

procedure TMainSwitch2.ReadPosfromGuiPrefs;
var
      i,x,y:Integer;
begin
  if GuiPrefs.Node.Exists('window.height') then MainSwitch2.height := GuiPrefs.Node['window.height'].asInteger ;
  if GuiPrefs.Node.Exists('window.Top') then MainSwitch2.Top := GuiPrefs.Node['window.Top'].asInteger ;

    y := 0;
    for I := 0 to PageConfig.Count - 1 do begin
      x := PageConfig.GetButtoncount(PageConfig.Items[I].PageName);
      if y < x then y:= x;
    end;
    Resizemenu(y, true);
end;

function TMainSwitch2.RegionUserLanguageID: Integer;
var
  QRY:TERPQuery;
begin
    Qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      Qry.SQL.Text := 'Select languageId from tblregionaloptions where RegionID = ' + inttostr(Appenv.RegionalOptions.ID);
      Qry.open;
      Result := Qry.FieldByName('languageId').AsInteger;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
end;
function TMainSwitch2.UserLanguageID: Integer;
begin
  result := GuiPrefs.Node['UseRegionalLanguage.ID'].asInteger;
  if result = 0 then result := RegionUserLanguageID;
  if result =0 then TLanguageTranslationObj.Inst.UserLanguageID := EnglishLanguageID;
end;
(*procedure TMainSwitch2.MainButtons;
  procedure MakeERPBtnfromdnmBtn(btn:TDnmspeedbutton);
  begin
    if btn.visible =False then Exit;
    With TERPMainSwitchButton.Create(Self) do begin
      Caption := btn.Caption;
      Helpcontext :=  btn.Helpcontext;
      Parent := btn.Parent;
      ParentFont := false;
      Font.Color := clWhite;
      Font.Style := Font.Style - [fsBold];
      Font.Size := 10;
      Onclick := btn.Onclick;
      Action := btn.Action;
      Visible := true;

      Width := btn.Width;
      Align := alleft;
      Alignwithmargins := True;
      Margins.left :=1;
      Margins.right :=1;
      Margins.top :=3;
      Margins.Bottom := 3;

      BringToFront;
      WordWrap := true;
      if Appenv.Employee.UseERPButtonColor then colors := vararrayof([Appenv.Employee.ERPButtonColor,clSilver, $00EBC1AB, clwhite]);
      btn.visible := False;
      Left := 0;
    end;

  end;
begin
  MakeERPBtnfromdnmBtn(btnHowTo);
  MakeERPBtnfromdnmBtn(btnWorkflow);
  MakeERPBtnfromdnmBtn(btnShowRemindersList);
  MakeERPBtnfromdnmBtn(btnCustomise);
  MakeERPBtnfromdnmBtn(btnShowMessagesList);
  MakeERPBtnfromdnmBtn(btnReports);

end;*)
procedure TMainSwitch2.AddMainButtons(Sender:TObject; ignoreLayout:Boolean = False);
var
  I, J: integer;
  Prefs: TPrefCollection;
  List: TStrings;
  r,pnlfound:boolean;
  defaultpage:string;
  defpageindex:integer;
  StartUpPageName:string;
  btncount:Integer;
  no : integer;
begin
  btncount:=0;
  ClearMainButtons;

  // Make unused modules menu items disabled
  with MainForm do begin
    dtmMainGUI.Payroll2.Visible := HasPayrollAccess;
    dtmMainGUI.TerminateEmployeemnu.Visible := dtmMainGUI.Payroll2.Visible;
    if AppEnv.RegionalOptions.RegionType = rAust then begin
      dtmMainGUI.ATOSubmissions.Visible := dtmMainGUI.Payroll2.Visible;
      dtmMainGUI.PayRunList.Visible := dtmMainGUI.Payroll2.Visible;
    end
    else begin
      dtmMainGUI.ATOSubmissions.Visible := False;
      dtmMainGUI.PayRunList.Visible := false;
    end;
    dtmMainGUI.FixedAssets3.Visible := AppEnv.CompanyPrefs.UseFixedAssets;
  end;

  Prefs := TPrefCollection.Create(0, AppEnv.Employee.EmployeeID, PREF_GROUP_MAIN_SWITCH);
  try
    if Prefs.Count > 0 then begin
      for I := 0 to Prefs.Count - 1 do begin
        if Prefs.Items[I].PrefName = PREF_NAME_MAIN_SWITCH_MENU then begin
          List := TStringList.Create;
          try
            List.Text := Prefs.Items[I].AsString;
            if List.Count > 0 then begin
              { tempory code to remove old module stuff }
              if List.IndexOfName('Door') > -1 then begin
                List.Delete(List.IndexOfName('Door'));
                Prefs.Items[I].AsString:= List.Text;
                Prefs.Save;
              end;
              if List.IndexOfName('Assessment') > -1 then begin
                List.Delete(List.IndexOfName('Assessment'));
                Prefs.Items[I].AsString:= List.Text;
                Prefs.Save;
              end;
              (*if List.IndexOfName('Hire') > -1 then begin
                if not Appenv.companyprefs.UseHire then begin
                  List.Delete(List.IndexOfName('Hire'));
                  Prefs.Items[I].AsString:= List.Text;
                  Prefs.Save;
                end;
              end;*)
              PageConfig.Clear;
              for J := 0 to List.Count - 1 do begin
                try
                  if trim(List.Values[List.Names[J]]) <> '' then
                  begin
                    no := PageConfig.AddPage(List.Names[J], List.Values[List.Names[J]]);
                    PageConfig.Items[no].PageModifier := TPageModifier.Create(PageConfig.Items[no]);
                    PageConfig.Items[no].PageModifier.Load(trim(List.Names[J]), AppEnv.CompanyInfo.IndustryId);
                    // Button list depends on current modifier
                    if (PageConfig.Items[no].PageModifier.Id  > 0) then
                      if (ignoreLayout=False) then
                        PageConfig.Items[no].ButtonList := PageConfig.Items[no].PageModifier.ButtonList
                    else begin
                    end;
                  end;
                Except
                end;
              end;
            end;
          finally
            FreeAndNil(List);
          end;
          Break;
        end;
      end;
    end else begin
      GetDefaultSettings;
    end;
  finally
    FreeAndNil(Prefs);
  end;

  // there better be a pages in a configuration
  if PageConfig.Count > 0 then begin
    pnlfound:=false;
    // add main buttons for all pages
    defpageindex:=0;

    if GuiPrefs.Node['LastMainButton.Name'].AsString <> '' then begin
      StartUpPageName := GuiPrefs.Node ['LastMainButton.Name'].AsString;
    end else begin
      StartUpPageName := 'Sales';
    end;

    TLanguageTranslationObj.Inst.UserLanguageID := UserLanguageID;

    dtmMainGUI.ShowSelectedLanguage(TLanguageTranslationObj.Inst.UserLanguageID);

    for I := 0 to PageConfig.Count - 1 do begin
      r:=AddMainButton(pnlMainButtons, PageConfig.Items[I].PageName);
      if PageConfig.Items[I].PageName = StartUpPageName then defpageindex:=i;
      // add action buttons for the topmost page
      if  r AND (PageConfig.Items[I].PageName = Trim(pnlActivePage.Caption))  then begin
            pnlActivePage.Caption := ' ' +PageConfig.Items[I].PageName;
//            btncount :=  AddActionButtons(PageConfig.Items[I].ButtonList);
            btncount :=  AddActionButtons(PageConfig.Items[I], ignoreLayout);
            btnCount := btnCount + AddTrainingButtons(PageConfig.Items[i].PageName);
            ActivePageName := PageConfig.Items[I].PageName;
            pnlfound:=true;
      end else if  r AND (Sender is TDNMAction) and (PageConfig.Items[I].PageName = TDNMAction(Sender).category)  then begin
            btncount :=  AddActionButtons(PageConfig.Items[I], ignoreLayout);
            btnCount := btnCount + AddTrainingButtons(PageConfig.Items[i].PageName);
            ActivePageName := PageConfig.Items[I].PageName;
            pnlfound:=true;
      end else if (r =false) and (pnlfound=false) then begin
            defaultpage :='Sales'
      end;

    end;
    if pnlfound =false then begin
        if  (pnlActivePage.Caption ='') or (defaultpage = StartUpPageName) or (defpageindex=0) then begin {if starting up, where there is no active page; or panel is not visible}
            pnlActivePage.Caption := ' ' +PageConfig.Items[defpageindex].PageName; {Sales}
//            btncount :=AddActionButtons(PageConfig.Items[defpageindex].ButtonList);
            btncount :=AddActionButtons(PageConfig.Items[defpageindex]);
            btnCount := btnCount + AddTrainingButtons(PageConfig.Items[defpageindex].PageName);
            ActivePageName := PageConfig.Items[defpageindex].PageName;
        end;
    end;
    Resizemenu(btnCount, False);


  end;
  { NOTE: If user has clicked on Access Levels and saved then the Customise
          button stops working .. so re-assign action to button here }
  btnCustomise.Action := dtmMainGUI.actCustomise;
  //MainButtons;
end;

function TMainSwitch2.AddTrainingButtons(const aPageName: string): integer;
const
  csPageButtons = 'select distinct  H.HowToId, H.Description'#13#10 +
                  'from tblHowTo H'#13#10 +
                  'inner join tblTrainingButtons T on (T.HowToId = H.HowToId)'#13#10 +
                  'where (T.EmployeeId=0 or T.EmployeeId = %d) and (PageName = "%s")';
  csShowButtons = 'SELECT * from tblTrainingButtons where EmployeeId = %d and HowToId = -1';
var
  qry : TERPQuery;
  lButton : TERPMainSwitchButton;
  lBitmap : TBitmap;
begin
  Result := 0;
  qry := TempMyQuery;
  try
    qry.SQL.Text := Format(csShowButtons, [AppEnv.Employee.EmployeeId]);
    qry.Open;
    if not qry.EOF then
      exit;
    qry.SQL.Text := Format(csPageButtons, [AppEnv.Employee.EmployeeID, aPageName]);
    qry.Open;
    while not qry.EOF do
    begin
      // Note: PanelIdex was changed by AddActionButtons, so we need to restore it temporarily
      lButton := AddActionButton(pnlArray[(FPanelIndex + 1) mod 2], nil);
      if assigned(lButton) then
      begin
        lButton.OnClick := dtmMainGUI.HowToExtraButtonClick;
        lButton.Tag := qry.FieldByName('HowToId').AsInteger;
        lButton.Caption := qry.FieldByName('Description').AsString;
        lBitmap := TBitmap.Create;
        try
          if lButton.UseLargeIcon then
            ImgDataModule.ImageList.GetBitmap(661, lBitmap)
          else
            ImgDataModule.ImageListSmlIcons.GetBitmap(661, lBitmap);
        lButton.Picture.Assign(lBitmap);
        finally
          lBitmap.Free;
        end;
      end;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure TMainSwitch2.AfterformShow;
begin
  inherited;
  ReminderTimer.enabled := true;
end;

procedure TMainSwitch2.AfterTranslate;
begin
  inherited;
  if assigned(Selectedbutton) then
    if Selectedbutton is TDNMSpeedButton then
      pnlActivePage.caption := TDNMSpeedButton(Selectedbutton).caption
    else     if Selectedbutton is TERPMainSwitchButton then
      pnlActivePage.caption := TERPMainSwitchButton(Selectedbutton).caption;


end;

procedure TMainSwitch2.FormDestroy(Sender: TObject);
begin
  FreeAndNil(PageConfig);
//  ModifiedPageList.Free;
  inherited;
end;

function TMainSwitch2.GetReposMainX: integer;
begin
  Result := MAIN_BUTTON_SPACE_X;
end;

function TMainSwitch2.GetReposMainY: integer;
begin
  Result := MAIN_BUTTON_SPACE_Y+1+ FMainButtonCount * MAIN_MIN_OFFSET_Y;
end;

function TMainSwitch2.RowMainCount: integer;
begin
  Result := FMainButtonCount;
end;

Procedure TMainSwitch2.ResizeMenu(BtnCount: Integer; ResizeAnyway: Boolean=False);
begin
  if appenv.CompanyPrefs.UserSetMainSwitchHeight <> 0 then exit; // if user has set a height, dont change it

  if BtnCount = 0 then BtnCount := 580
  else if Screen.Height <= 768 then Btncount := 580
  else if BtnCount <= 24 then BtnCount := 580
  else if BtnCount <= 30 then BtnCount := 685
  else BtnCount := 790;

  if (BtnCount = Self.Height)  or ((BtnCount < Self.Height) and not ResizeAnyway) then Exit;


  if BtnCount > Self.Height then Self.Height := BtnCount
  else if ((Btncount < Self.Height) and (ResizeAnyway=False)) then Self.Height := BtnCount
  else Exit;

  if Self.Height > MainForm.ClientHeight - 100 then Self.Height := MainForm.ClientHeight - 100;
  //Self.Top := trunc((mainform.ClientHeight-100 -self.Height)/2);
  SetFormTop;
end;

Procedure TMainSwitch2.SetFormTop;
var
  i:Integer;
begin
  if Self.Height > 790 then Self.Height := 790;
  i := (Screen.Height - Self.Height) div 2 - mainform.ClientOrigin.Y - mainform.MainToolBar.Height + mainform.StatusBar.Height;
  if Abs(Self.Top-i) >40 then Self.Top := i;
  if Height > Screen.Height- top  then top := 0;
end;

procedure TMainSwitch2.MainButtonClick(Sender: TObject);
var
  PageName, ButtonList: string;
  btncount:Integer;
begin
  if not DoCheckEditMode(Sender) then
    exit;

  btncount := 0;
  DisableForm;
  try
    //fCurrentButtonName := EnglishCaption(TDNMSpeedButton(Sender));
    PageName           := EnglishCaption(TERPMainSwitchButton(*TDNMSpeedButton*)(Sender));
    PageName := CeasePreferenceNames(PageName);
    fCurrentButtonName := PageName;
    if TERPMainSwitchButton(*TDNMSpeedButton*)(Sender).caption <> Trim(pnlActivePage.Caption) then begin
      Selectedbutton := sender;
      pnlActivePage.Caption := ' ' + TERPMainSwitchButton(*TDNMSpeedButton*)(Sender).caption;
      btnCount := 0;
      if PageConfig.GetButtonList(PageName, ButtonList) then
      begin
//        btncount := AddActionButtons(ButtonList);
        btncount := AddActionButtons(PageConfig.PageByName[PageName]);
        ActivePageName := PageName;
        DoSetEditMode(false);
      end;
      btnCount := btnCount + AddTrainingButtons(PageName);
      if btnCount = 0 then
        CommonLib.MessageDlgXP_Vista(Format('Page "%s" does not have any buttons assigned', [PageName]), mtWarning, [mbOK], 0);
    end;

    ResizeMenu(btncount);

    Mainform.LoadVideoURLs(fCurrentButtonName);
    Application.ProcessMessages;
    PageLayoutSelectedItem := nil; //@@
  finally
    EnableForm;
  end;
end;

function TMainSwitch2.MaxMainX: integer;
begin
  Result := pnlMainButtons.Width - (2 * MAIN_BUTTON_SPACE_X);
end;

function TMainSwitch2.MaxMainY: integer;
begin
  Result := pnlMainButtons.Height - (2 * MAIN_BUTTON_SPACE_Y);
end;

procedure TMainSwitch2.ClearMainButtons;
var
  I: integer;
begin
  try
    I := 0;
    while I < pnlMainButtons.ControlCount do begin
      if pnlMainButtons.Controls[I] is TERPMainSwitchButton(*TDNMSpeedButton*) then begin
        if TERPMainSwitchButton(*TDNMSpeedButton*)(pnlMainButtons.Controls[I]).Caption <> 'Customise' then
          pnlMainButtons.Controls[I].Free
        else
          Inc(I);
      end
      else
        Inc(I);
    end;
    pnlMainButtons.Width  := MAIN_PANEL_WIDTH_REGULAR;
    //sbmain.Width  := MAIN_PANEL_WIDTH_REGULAR;
    pnlMainButtons.Height := MAIN_PANEL_HEIGHT_REGULAR;
  finally
    FMainButtonCount := 0;
    SelectedButton := nil;
  end;
end;

procedure TMainSwitch2.GetDefaultSettings;
begin
  GetMainMenuDefaultPreferences(PageConfig);
end;

procedure TMainSwitch2.btnCustomiseMenuClick(Sender: TObject);
begin
  inherited;
  Docustomise(Sender);
end;
procedure TMainSwitch2.btnWorkflowClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TWorkflowsGUI');
end;

procedure TMainSwitch2.btnDevHintsClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TERPShortcutsGUI')
end;

function TMainSwitch2.DoCheckEditMode(Sender: TObject): boolean;
begin
  Result := true;
  if (not EditMode) then
  begin
    pnlEditTools.Visible := false;
    exit;
  end;

  if not LayoutEdited then
  begin
    DoPageLayoutCancel(Sender); // was not edited - just cancel the state
    exit;
  end;

  case MessageDlgXP_Vista('You Are in Edit Page Layout Mode. Do You Want To Save Your Changes, Cancel Your Changes, Or Return'+
                          ' to Editing?',
                                mtWarning,
                                //[mbYes, mbOk, mbIgnore],
                                [],  0, nil, '' , '' , False, nil, 'Save,Cancel,Return') of
            {myes}    100 : DoPageLayoutSave(Sender);
            {mrNo}    101 : DoPageLayoutCancel(Sender);
            {mrRetry} 102 : Result := false;
  end;

end;

procedure TMainSwitch2.Docustomise(Sender: TObject);
var
  i:Integer;
//  Page : TPageItem;
begin
  if not DoCheckEditMode(Sender) then
    exit;

//  if ShowMenuCustomiseForm(pnlArray[(FPanelIndex + 1) mod 2].Width, pnlArray[(FPanelIndex + 1) mod 2].Height) then
  i :=  ShowMenuCustomiseForm(pnlArray[(FPanelIndex + 1) mod 2].Width, pnlArray[(FPanelIndex + 1) mod 2].Height);

  if i = mrOk then begin RefreshButtons(Sender);
  end else if i=mrCancel then exit
  else DoPageLayoutEdit(Sender);

end;
procedure TMainSwitch2.RefreshButtons(Sender: TObject; ignoreLayout:Boolean = False);
var
  i:Integer;
begin
    i:=TLanguageTranslationObj.Inst.UserLanguageID;
    try
      GuiPrefs.Node['UseRegionalLanguage.ID'].asInteger:= EnglishLanguageID;
      AddMainButtons(Sender , ignoreLayout);
      DoTranslateFormLanguage;
    finally
       GuiPrefs.Node['UseRegionalLanguage.ID'].asInteger:= i;
       TLanguageTranslationObj.Inst.UserLanguageID:= i;
       //DoTranslateFormLanguage;
    end;
end;

procedure TMainSwitch2.DoPageLayoutCancel(Sender: TObject);
var
  idx : integer;
  i,
  k,
  n : integer;
  Page : TPageItem;
  sl : TStringList;

  procedure FreeButton(const AName : string);
  var
    l : integer;
  begin
    for l := 0 to pnlArray[n].ComponentCount - 1 do
      if pnlArray[n].Components[l] is TERPMainSwitchMovingButton then
        if SameText(TERPMainSwitchMovingButton(pnlArray[n].Components[l]).Action.Name, AName) then
        begin
          pnlArray[n].Components[l].Free;
          exit;
        end;
  end;
begin
//
  n := (FPanelIndex + 1) mod 2;
  for idx := pnlArray[n].ComponentCount - 1 downto 0 do
    if pnlArray[n].Components[idx] is TERPMainSwitchMovingButton then
      TERPMainSwitchMovingButton(pnlArray[n].Components[idx]).CancelMoving
    else if pnlArray[n].Components[idx] is TLine then
      // TLine(pnlArray[n].Components[idx]).AllowSelect := false;
      pnlArray[n].Components[idx].Free;

    Page := PageConfig.PageByName[ActivePageName];
    Page.PageModifier.Free;
    Page.PageModifier := TPageModifier.Create(Page);
    Page.PageModifier.Load(ActivePageName, AppEnv.CompanyInfo.IndustryId);

    sl := TStringList.Create;
    sl.CommaText := Page.ButtonList;
    try
      for k := Page.PageModifier.Count - 1 downto 0 do
        if Page.PageModifier.Items[k].NodeType = mtButton then
        begin
          i := sl.IndexOf(Page.PageModifier.Items[k].ActionName);
          if i < 0 then
          begin
            FreeButton(Page.PageModifier.Items[k].ActionName);
            Page.PageModifier.Delete(k);
          end;
        end;
      Page.ButtonList := sl.CommaText;
    finally
      sl.Free;
    end;

    ApplyModifiers(Page, pnlArray[n], ''); //???
    DoSetEditMode(false);

//    AddActionButtons(PageConfig.PageByName[ActivePageName]);
//    AddTrainingButtons(ActivePageName);
//    DoSetEditMode(false);
end;

procedure TMainSwitch2.DoPageLayoutConnector(Sender: TObject);
var
//  c : TLine;
  n : integer;
  pnl : TPanel;
  page : TPageItem;
  Desc : TPageItemDesc;
begin
//
  n := (FPanelIndex + 1) mod 2;
  pnl := pnlArray[n];
  Page := PageConfig.PageByName[ActivePageName];
  //Page.PageModifier.Descriptor['', mtLink] :=
  Desc := TPageItemDesc.Create;
  Desc.NodeType := mtLink;
  Desc.Left := 0;
  Desc.Top := 0;
  Desc.Width := 180;
  Desc.Height := 180;
  Desc.ActionName := '';
  Desc.EndActionName := '';
  Desc.LineHeads := 2; // Arrow2
  Desc.Arrow2Kind := akSolidArrow;
  Desc.LineColor := clTeal; // clBlack;
  Desc.ArrowColor := clTeal;
  Desc.SelectedColor := clGreen; //clRed;
  Desc.MarkColor := clLime;
  Desc.MarkSize := 8;
  Desc.LineWidth := 6;
  Desc.LineStyle := psSolid;
  Page.PageModifier.AddLinkDescriptor(Desc);
  DrawLink(pnl, Desc);
  LayoutEdited := true;
  DoSetEditMode(true);
end;

procedure TMainSwitch2.DoPageLayoutEdit(Sender: TObject);
var
  idx : integer;
  n : integer;
  b : TERPMainSwitchMovingButton;
  l : TLine;
begin
//
  if EditMode then
    exit;
  n := (FPanelIndex + 1) mod 2;
  for idx := 0 to pnlArray[n].ComponentCount - 1 do
  begin
    if pnlArray[n].Components[idx] is TERPMainSwitchMovingButton then
    begin
      b := TERPMainSwitchMovingButton(pnlArray[n].Components[idx]);
      b.OnSelected := PageLayoutItemSelected;
      b.OnMouseMove := PageLayoutItemMoving;
      b.StartMoving;
    end
    else if pnlArray[n].Components[idx] is TLine then
    begin
      l := TLine(pnlArray[n].Components[idx]);
      l.AllowSelect := true;
      l.OnSelected := PageLayoutItemSelected;
      l.OnMouseMove := PageLayoutItemMoving;
    end;

  end;
  DoSetEditMode(true);

end;

procedure TMainSwitch2.DoPageLayoutSave(Sender: TObject);
var
  idx : integer;
  n : integer;
  page : TPageItem;
begin
  if LayoutEdited then
  begin
    n := (FPanelIndex + 1) mod 2;

    page := PageConfig.PageByName[ActivePageName]; //trim(pnlACtivePage.Caption)];
    if assigned(Page) then
      Page.Save(pnlArray[n]);

    for idx := 0 to pnlArray[n].ComponentCount - 1 do
      if pnlArray[n].Components[idx] is TERPMainSwitchMovingButton then
        TERPMainSwitchMovingButton(pnlArray[n].Components[idx]).Selected := false
      else if (pnlArray[n].Components[idx])is TLine then
        TLine(pnlArray[n].Components[idx]).Selected := false;

    pnlArray[n].Height := PANEL_HEIGHT_REGULAR;
    ApplyModifiers(Page, pnlArray[n], '');
  end;

  DoSetEditMode(false);
end;

procedure TMainSwitch2.DoProgressdialogProgress(const Value: String);
begin
  DoStepProgressbar(prgDlgInitERP , Value);
end;

procedure TMainSwitch2.RegisterActiveWindow(const ACaption: string; AObject: TObject);
var frmActiveWindows: TfrmActiveWindows;
begin
  // check if the form is already registered
  frmActiveWindows := TfrmActiveWindows(FindExistingComponent('TfrmActiveWindows'));
  if frmActiveWindows.lbActiveWindows.Items.IndexOf(ACaption) = -1 then frmActiveWindows.lbActiveWindows.Items.AddObject(ACaption, AObject);
end;

procedure TMainSwitch2.tmrActiveWindowsTimer(Sender: TObject);
var
  frmActiveWindows: TfrmActiveWindows;
begin
  inherited;
  frmActiveWindows := TfrmActiveWindows(FindExistingComponent('TfrmActiveWindows'));
  inc(TimerCount);
  if TimerCount=3 then begin
    TimerCount:=0;
    if frmActiveWindows.visible then frmActiveWindows.hide;
  end;
  ListActiveWindows;
end;

procedure TMainSwitch2.tollNewButtonBtnClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TMainSwitch2.toolDeleteBtnClick(Sender: TObject);
var
  p : TPanel;
  idx : integer;
  k : integer;
  l : TLine;
  b : TERPMainSwitchMovingButton;
  page : TPageItem;
//  sl : TStringList;
//  mcr: TMenuCustomiseRec;
begin
  inherited;
//
  p := pnlArray[(FPanelIndex + 1) mod 2];
  // Need to count from top to bottom
  for idx := p.ComponentCount - 1 downto 0 do
  begin
    if (p.Components[idx] is TLine) and (TLine(p.Components[idx]).Selected)then
    begin
      p.Components[idx].Free;
    end
    else if (p.Components[idx] is TERPMainSwitchMovingButton) and TERPMainSwitchMovingButton(p.Components[idx]).Selected  then
    begin
     // Un-link potentially linked links
     b := TERPMainSwitchMovingButton(p.Components[idx]);
     for k := 0 to p.ComponentCount - 1 do
       if (p.Components[k] is TLine) then
       begin
         l := p.Components[k] as TLine;
         if Assigned(l.ActionFrom) and SameText(l.ActionFrom.Action.Name, b.Action.Name) then
           l.ActionFrom := nil
         else if Assigned(l.ActionTo) and SameText(l.ActionTo.Action.Name, b.Action.Name) then
           l.ActionTo := nil;
       end;

       // Now button itself
       Page := PageConfig.PageByName[ActivePageName];

       if not assigned(Page) then
         exit;
       (*
       sl := TStringList.Create;
       try
         sl.CommaText := Page.ButtonList;
         k := sl.IndexOf(b.Action.Name);
         if k < 0 then
           exit;
         sl.Delete(k);
         Page.ButtonList := sl.CommaText;

         mcr.PrefGroup := PREF_GROUP_MAIN_SWITCH;
         mcr.PrefName := PREF_NAME_MAIN_SWITCH_MENU;
         mcr.PackageID := 0;
         mcr.UserID := AppEnv.Employee.EmployeeID;
         if SavePageConfigData(PageConfig, mcr) then
           p.Components[idx].Free;
       finally
         sl.Free;
       end;
       *)
       Page.PageModifier.DeleteButton(TERPMainSwitchMovingButton(p.Components[idx]).Action.Name);
       p.Components[idx].Free;
    end;

  end;
  LayoutEdited := true;
end;

procedure TMainSwitch2.toolLoadLayoutClick(Sender: TObject);
var
  frm : TLayoutHistoryGUI;
  Page : TPageItem;
begin
//  Page := PageConfig.PageByName[ActivePageName];

  frm := TLayoutHistoryGUI.Create(nil);
  try
    frm.PageName := ActivePageName;
    if frm.ShowModal = mrOk then
    begin
      Page := PageConfig.PageByName[ActivePageName];
      if Page.PageModifier.Id = frm.SelectedId then
        exit;
      Page.PageModifier.Free;
      Page.PageModifier := TPageModifier.Create(Page);
      Page.PageModifier.Id := frm.SelectedId;
      Page.PageModifier.Load(ActivePageName, AppEnv.CompanyInfo.IndustryId);
      ApplyModifiers(Page, pnlArray[(FPanelIndex + 1) mod 2], '');
      invalidate;

    end;
  finally
    frm.Free;
  end;
end;

procedure TMainSwitch2.ListActiveWindows;
var
  I: integer;
  frmActiveWindows: TfrmActiveWindows;

begin
  frmActiveWindows := TfrmActiveWindows(FindExistingComponent('TfrmActiveWindows'));
  frmActiveWindows.lbActiveWindows.Items.Clear;
  if Application.MainForm.MDIChildCount > 0 then for I := 0 to Application.MainForm.MDIChildCount - 1 do begin
      if Not Sysutils.SameText(Application.MainForm.MDIChildren[I].ClassName,'TMainSwitch2')
         {AND Not Sysutils.SameText(Application.MainForm.MDIChildren[I].ClassName,'THintGUI')} then
        RegisterActiveWindow(Application.MainForm.MDIChildren[I].Caption,
          Application.MainForm.MDIChildren[I]);
    end;
end;

procedure TMainSwitch2.btnShowRemindersListclick(Sender: TObject);
begin
    Showreminders;
end;
procedure TMainSwitch2.btnTempfolderClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  s:= Wintempdir;
  ShellExecute(Handle, 'open', PChar(s), '', '', SW_SHOW);
end;

procedure TMainSwitch2.btnUnselectClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TMainSwitch2.Showreminders;
var
  frmRemindersList: TComponent;
begin
  inherited;
  if not FormStillOpen('TReminderListGUI') then begin
    frmRemindersList := GetComponentByClassName('TReminderListGUI');
    if Assigned(frmRemindersList) then begin
      TForm(frmRemindersList).FormStyle := fsMDIChild;
      TForm(frmRemindersList).Show;
      TForm(frmRemindersList).BringToFront;
    end;
  end else begin
    frmRemindersList := FindExistingComponent('TReminderListGUI');
    TForm(frmRemindersList).Show;
    TForm(frmRemindersList).BringToFront;
  end;
end;

procedure TMainSwitch2.ReportsClick(Sender: TObject);
 { TODO -oIanos : FIX to Use New Reports }
begin
  inherited;
  if pnlActivePage.Caption = REPORT_GROUP_APPOINTMENTS then begin
      MainSwitch2.DoReportshow('Feedback Report', REPORT_GROUP_APPOINTMENTS);
      end
  else if pnlActivePage.Caption = REPORT_GROUP_SALES then begin
      MainSwitch2.DoReportshow('Accounts Receivable Report', REPORT_GROUP_SALES);
      end
  else if pnlActivePage.Caption = REPORT_GROUP_PURCHASES then begin
      MainSwitch2.DoReportshow('Accounts Payable Report', REPORT_GROUP_PURCHASES);
      end
  else if pnlActivePage.Caption = REPORT_GROUP_INVENTORY then begin
      MainSwitch2.DoReportshow('Product Report', REPORT_GROUP_INVENTORY);
      end
  else if pnlActivePage.Caption = REPORT_GROUP_PAYMENTS then begin
      MainSwitch2.DoReportshow('Accounts Payable Report', REPORT_GROUP_PAYMENTS);
      end
  else if pnlActivePage.Caption = REPORT_GROUP_EMPLOYEE then begin
      MainSwitch2.DoReportshow('Employee Summary', REPORT_GROUP_EMPLOYEE);
      end
  else if pnlActivePage.Caption = REPORT_GROUP_ACCOUNTS then begin
      MainSwitch2.DoReportshow('Accounts Payable Report', REPORT_GROUP_ACCOUNTS);
      end
  else if pnlActivePage.Caption = REPORT_GROUP_BANKING then begin
      MainSwitch2.DoReportshow('Accounts Payable Report', REPORT_GROUP_BANKING);
      end
  else if pnlActivePage.Caption = REPORT_GROUP_GENERAL then begin                  {same as accounts}
      MainSwitch2.DoReportshow('Accounts Payable Report', REPORT_GROUP_ACCOUNTS);
      end
  else if pnlActivePage.Caption = REPORT_GROUP_CRM then begin
      MainSwitch2.DoReportshow('Phone Contact / Follow Up List', REPORT_GROUP_CRM);
      end
  else if pnlActivePage.Caption = REPORT_GROUP_MARKETING then begin
      MainSwitch2.DoReportshow('Leads', REPORT_GROUP_MARKETING);
      end

  else if pnlActivePage.Caption = REPORT_GROUP_FIXED_ASSETS then begin
      MainSwitch2.DoReportshow('Warranty / Insurance Policy Report', REPORT_GROUP_FIXED_ASSETS);
      end
  else if  pnlActivePage.Caption = REPORT_GROUP_PAYROLL then begin
      MainSwitch2.DoReportshow('Pay History', REPORT_GROUP_PAYROLL);
      end
  else if  pnlActivePage.Caption = REPORT_GROUP_UTILITIES then begin
      MainSwitch2.DoReportshow('Accounts Receivable Report', REPORT_GROUP_SALES);
      end
  else {Default to first report}
      MainSwitch2.DoReportshow('Accounts Payable Report', REPORT_GROUP_ACCOUNTS);

  fCurrentButtonName := 'Reports' ;
  Mainform.LoadVideoURLs('Reports');
end;

procedure TMainSwitch2.btnShowMessagesListClick(Sender: TObject);
begin
  ShowmesageForm;
end;
procedure TMainSwitch2.ShowmesageForm;
var
  MessageListForm : TComponent;
begin
  inherited;
  if not FormStillOpen('TfrmMessagesListGUI') then begin
    MessageListForm := GetComponentByClassName('TfrmMessagesListGUI');
    if Assigned(MessageListForm) then begin //if has acess
      TForm(MessageListForm).FormStyle := fsmdiChild;
      TForm(MessageListForm).BringToFront;
    end;
   end else begin
     MessageListForm := FindExistingComponent('TfrmMessagesListGUI');
     TForm(MessageListForm).Show;
     TForm(MessageListForm).BringToFront;
   end;
end;

procedure TMainSwitch2.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  AccessLevel: Integer;
  Form: TComponent;
  BarcodeProcess: TBarcodeProcess;
begin
  inherited;
  if (ssCtrl in Shift ) and (Key in [ord('V') , ord('F') ]) then begin
      KeysPressed :=KeysPressed +chr(key);
    if Sysutils.SameText(KeysPressed , 'VF') then begin

      if not ValidPassword then exit;
      OpenERPForm('TfmDebugforms', 0);
      KeysPressed :='';
    end;
  end else KeysPressed := '';
  case Key of
      {$IFDEF DevMode}
    VK_F4:
        dtmMainGUI.DevModeShowForm(nil);
      {$ENDIF}

    VK_F8:
    begin
      if not FormStillOpen('TClockOnGUI') then begin
        Form := GetComponentByClassName('TClockOnGUI');
        if Assigned(Form) then begin //if has acess
          with TForm(Form) do begin
            FormStyle := fsmdiChild;
            BringToFront;
          end;
        end;
      end else begin
        with TForm(FindExistingComponent('TClockOnGUI')) do begin
          Show;
          BringToFront;
        end;
      end;
    end;

    VK_F9:
    begin
      {$IFDEF DevMode}
        Exit;
      {$ENDIF}
      BarcodeProcess := TBarcodeProcess(FindExistingComponent('TBarcodeProcess'));

      if Assigned(BarcodeProcess) then
        BarcodeProcess.BringToFront
      else begin
        AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel('TBarcodeProcess');

        if AccessLevel > 2 then
          CommonLib.MessageDlgXP_Vista('You do not have Access to ' + AppEnv.AccessLevels.GetFormDescription('TBarcodeProcess'), mtWarning	, [mbOK], 0)
        else begin
          BarcodeProcess := TBarcodeProcess(GetComponentByClassName('TBarcodeProcess'));

          if Assigned(BarcodeProcess) then begin
            BarcodeProcess.CreateForm;
            BarcodeProcess.SetupDisplay;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainSwitch2.FormActivate(Sender: TObject);
begin
  inherited;
  //
  // This performs a cleaner paint erase of forms being Destroyed and
  // returning focus to this form.
  //
  Update;
end;

procedure TMainSwitch2.ReminderTimerTimer(Sender: TObject);
var
	frmRemindersList : TComponent;
begin
  DoShowProgressbar(prgDlgInitERP , 10 , 'Initializing ERP');
  try


      Self.Update;
      inherited;
      ReminderTimer.Enabled := false;
      //if devmode then exit;
      if AppEnv.CompanyPrefs.ShowDashboard then begin
        try
          if DashboardDone = False then begin
            DoProgressdialogProgress('Checking For Dashboard');
            ShowDashBoard;
            DashboardDone := True;
          end;
        except

        end;
      end;
      try
        if not RemindersShownOnce then begin
          DoProgressdialogProgress('Checking For Reminders');
          Self.Update;
          if not FormStillOpen('TReminderListGUI') then begin
            frmRemindersList := GetComponentByClassName('TReminderListGUI');
            if Assigned(frmRemindersList) then begin
              Self.Update;
              If TReminderListGUI(frmRemindersList).IsAnyReminders then Begin
                TReminderListGUI(frmRemindersList).FormStyle := fsMDIChild;
              end else Begin
                TReminderListGUI(frmRemindersList).Close;
              end;
            end;
            RemindersShownOnce := true;
          end;
        end;
        if (AppEnv.Employee.MemTransAppearDays <> -1) and (not MemTransShownOnce) and (not POSAutoLoad) then begin
          DoProgressdialogProgress('Checking For Memorise Transactions');
          ShowMemTransList;
        end;
      except
      end;

      if AppEnv.Employee.ShowVideoMenuAtStartup then begin
        DoProgressdialogProgress('Checking For Help Docs');
        fbHowToClickonStartup:= true;
        try
          btnHowToClick(Self);
        finally
          fbHowToClickonStartup:= False;
        end;
      end;
  finally
    DoHideProgressbar(prgDlgInitERP);
  end;
end;

//procedure TMainSwitch2.LoadResourceFile(aFile:string; ms:TMemoryStream);
//var
//   HResInfo: HRSRC;
//   HGlobal: THandle;
//   Buffer, GoodType : pchar;
//   Ext:string;
//begin
//  ext:=uppercase(extractfileext(aFile));
//  ext:=copy(ext,2,char_length(ext));
//  if ext='HTM' then ext:='HTML';
//  Goodtype:=pchar(ext);
//  aFile:=changefileext(afile,'');
//  HResInfo := FindResource(HInstance, pchar(aFile), GoodType);
//  HGlobal := LoadResource(HInstance, HResInfo);
//  if HGlobal = 0 then
//     raise EResNotFound.Create('Can''t load resource: '+aFile);
//  Buffer := LockResource(HGlobal);
//  ms.clear;
//  ms.WriteBuffer(Buffer[0], SizeOfResource(HInstance, HResInfo));
//  ms.Seek(0,0);
//  UnlockResource(HGlobal);
//  FreeResource(HGlobal);
//end;


procedure TMainSwitch2.btnExitClick(Sender: TObject);
begin
  inherited;
  TLanguageTranslationObj.Inst.IsERPRunning:= False;
  Application.MainForm.Close;
  PerformPaints;
end;

procedure TMainSwitch2.btnHowToClick(Sender: TObject);
begin
  inherited;
//  OpenERPListForm('THowToListGUI');
  //OpenERPListForm('THowToListGUI', nil, HowToAfterShow)
  OpenERPListForm('TERPChangesGUI', nil, HowToAfterShow)
end;

procedure TMainSwitch2.btnLogClick(Sender: TObject);
begin
  inherited;
  ShellExecute(Handle, 'open', PChar(replacestr(Application.ExeName, '.exe' , '.log')), '', '', SW_SHOW);
end;

procedure TMainSwitch2.btnLogformsClick(Sender: TObject);
begin
  inherited;
  ShellExecute(Handle, 'open', PChar(replacestr(Application.ExeName, '.exe' , '_forms.log')), '', '', SW_SHOW);
end;
(*
procedure TMainSwitch2.btnVideosClick(Sender: TObject);
begin
  Mainform.ShowVideoFrm(CurrentButtonName);
  TfmShowMeERPOffices.ShowMe;
end;
*)

procedure TMainSwitch2.pnlActivePageDblClick(Sender: TObject);
begin
  inherited;
  if devmode then begin
    edtMenuSearch.Visible := True;
    edtMenuSearch.Left :=pnlActivePage.Left;
    edtMenuSearch.Width  :=pnlActivePage.Width;
    Setcontrolfocus(edtMenuSearch);
  end;
end;

procedure TMainSwitch2.pnlButtons1Click(Sender: TObject);
begin
  inherited;     {if no buttons are clicked return video form to Getting Started}
  fCurrentButtonName := 'Getting Started' ;
  Mainform.LoadVideoURLs(fCurrentButtonName);
end;

procedure TMainSwitch2.pnlButtons2Click(Sender: TObject);
begin
  inherited;
    {if no buttons are clicked return video form to Getting Started}
  fCurrentButtonName := 'Getting Started' ;
  Mainform.LoadVideoURLs(fCurrentButtonName);
end;

procedure TMainSwitch2.pnlButtons2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if  (ssShift in shift) and (ssCtrl in Shift)  then
    if button = mbRight then begin
      if SameText(InputBox('Password','' ,'') , 'devmodeshortcut') then OpenErpListform(Trim(InputBox('Dev Mode - Show Form', 'Class Name:', '')));
    end;
end;

procedure TMainSwitch2.pnlEditToolsMouseEnter(Sender: TObject);
begin
  inherited;
//
  Screen.Cursor := crDrag;
end;

procedure TMainSwitch2.pnlEditToolsMouseLeave(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crDefault;
end;

procedure TMainSwitch2.pnlEditToolsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
(*
  if (Shape1.Left <= X) and (X <= pnlEditTools.Width) then
  begin
    Screen.Cursor := crDrag;
    Shape1.Cursor := crDrag;
  end
  else
  begin
    Screen.Cursor := crDefault;
    Shape1.Cursor := crDefault;
  end;
*)
//
end;

procedure TMainSwitch2.ShowDashboard;
var
  form:Tcomponent;
  fDashboard:TDashboardGUI;
begin
  //if devmode then exit;

  if appenv.CompanyPrefs.DashboardToshow = 'M' then
    form:= commonlib.GetComponentByClassName('TMainDashboardGUI' , true , Nil, True, False)
  else form:= commonlib.GetComponentByClassName('TSalesDashboardGUI' , true , nil, true, False);

  if not Assigned(form) then exit;

  fDashboard:= TDashboardGUI(form);
  fDashboard.formstyle := fsmdichild;
  fDashboard.bringtoFront;

end;

procedure TMainSwitch2.edtMenuSearchExit(Sender: TObject);
begin
  inherited;
    edtMenuSearch.Visible := False;
end;

procedure TMainSwitch2.edtMenuSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key =   VK_ESCAPE then begin
      edtMenuSearch.text := '';
      Exit;
  end;
  Application.ProcessMessages;

  {$IFDEF DevMode}
  if (Key = VK_RETURN) or (Key = VK_TAB) or (Key = VK_F5) then begin
    dtmMainGUI.SearchForMenu(edtMenuSearch.text);
    edtMenuSearch.Visible := False;
  end;
  {$ENDIF}

end;

procedure TMainSwitch2.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Searchmode:TBaseListingSearchMode;
  Globalsearchform :TComponent;

begin
  inherited;
  if Key =   VK_ESCAPE then begin
      edtSearch.text := '';
      Exit;
  end;
  Application.ProcessMessages;
  Disableform;
  try
    Processingcursor(True);
    try
      if (Key = VK_RETURN) or (Key = VK_TAB) or (Key = VK_F5) then begin
        Searchmode := smFullList;
      end else if (Key = VK_F6) then begin
        Searchmode := smSearchEngine;
      end else if (Key = VK_F7) then begin
        Searchmode := smSearchEngineLike;
      end else exit;
      Globalsearchform := FindExistingComponent('TGlobalsearchGUI');
      if Assigned(Globalsearchform) then begin
        TGlobalsearchGUI(Globalsearchform).Close;
        Application.ProcessMessages;
      end;
      Globalsearchform := GetComponentByClassName('TGlobalsearchGUI',False,nil);
      if assigned(Globalsearchform) then begin
        TGlobalsearchGUI(Globalsearchform).QuerySearchmode := SearchMode;
        TGlobalsearchGUI(Globalsearchform).Searchname := edtSearch.text;
        edtSearch.text := '';
        TGlobalsearchGUI(Globalsearchform).FormStyle := fsmdiChild;
        TGlobalsearchGUI(Globalsearchform).BringToFront;
      end;
    finally
      Processingcursor(False);
    end;
  finally
    Enableform;
  end;
end;

procedure TMainSwitch2.SetHint;
begin
  ShowcontrolHint(edtSearch ,'Search on All Names (F5/F6/F7 Search) ' +NL +
                             'All Transactional Global References(ie. DEF258)  (F5/F6/F7  Search)  ' +NL +
                             'All Transactional Amount (F5 Search)');
end;


procedure TMainSwitch2.SetPageLayoutSelectedItem(const Value: TObject);
begin
  fPageLayoutSelectedItem := Value;
end;

procedure TMainSwitch2.SetSelectedButton(const Value: TObject);
begin
  fSelectedButton := Value;
end;

procedure TMainSwitch2.showhint;
begin
    Application.ShowHint      := true;
    Application.HintPause     := 100;
    Application.HintHidePause := 5000;

end;

function TMainSwitch2.InputPassword: String;
var
  CustomInputBox: TCustomInputBox;
begin
  {$IFDEF DevMode}
    result := 'vf';
    Exit;
  {$ENDIF}

  result := '';
  CustomInputBox:= TCustomInputBox.create(Nil);
  try
    CustomInputBox.Buttons := [sbOK, sbCancel];
    CustomInputBox.Caption := 'Password';
    CustomInputBox.Message := 'Please enter the password for Verify and fix Payments';
      CustomInputBox.DefaultString := '';
      CustomInputBox.EditBoxFont.Name := 'Arial';
      CustomInputBox.EditBoxFont.Size := 9;
      CustomInputBox.EditBoxFont.Style := [];
      CustomInputBox.MessageFont.Name := 'Arial';
      CustomInputBox.MessageFont.Size := 9;
      CustomInputBox.MessageFont.Style := [fsBold];
      CustomInputBox.Height := 115;
      CustomInputBox.Width := 400;
      CustomInputBox.PasswordCharacter := '*';
    if CustomInputBox.Execute then
      result := CustomInputBox.InputResult;
  Finally
    FreeandNil(CustomInputBox);
  end;
end;

procedure TMainSwitch2.OnFormShow(Sender: TObject);
var
    SelAddinInfo: TAddinPackageInfo;
    x:Integer;
begin
  DoShowProgressbar(prgDlgInitERP , 10 , 'Initializing ERP');
  try
          inherited;
          if assigned(dtmMainGUI) then begin
            DoProgressdialogProgress('Checking For Language Setup');
              TLanguageTranslationObj.Inst.CleanLc(dtmMainGUI);
             TLanguageTranslationObj.Inst.DoTranslate(dtmMainGUI, TLanguageTranslationObj.Inst.UserLanguageID);
          end;

          if Assigned(AddInPackageList) then begin
            for x := 0 to AddinPackageList.Count - 1 do begin
              SelAddinInfo := TAddinPackageInfo(AddinPackageList[x]);
              DoProgressdialogProgress('Checking For Packages - '+ SelAddinInfo.PackageName);
              if Assigned(SelAddinInfo.GuiDataModule) then begin
                SelAddinInfo.GuiDataModule.AssignImageList;
                TLanguageTranslationObj.Inst.CleanLc(SelAddinInfo.GuiDataModule);
                TLanguageTranslationObj.Inst.DoTranslate(SelAddinInfo.GuiDataModule, TLanguageTranslationObj.Inst.UserLanguageID);
              end;
            end;
          end;
  finally
    DoHideProgressbar(prgDlgInitERP);
  end;
end;

procedure TMainSwitch2.PageLayoutItemMoving(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  b : TERPMainSwitchMovingButton;
  p : TPanel;
  idx : integer;

  function Link(APoint : TPoint) : TPoint;
  var
    r : TRect;
  begin
//    Result := b.ClientToScreen(Point(0,0));
//      pt2 := b.ClientToScreen(Point(b.Width, b.Height));
      r := Rect(b.Left, b.Top, b.Left + b.Width, b.Top + b.Height);
      //pt := l.ClientToScreen(pt);

      case ButtonEdge(r, APoint) of
        beTop : begin
          Result.X := b.Left + b.Width div 2;
          Result.Y := b.Top;
          end;
        beRight : begin
          Result.X := b.Width + b.Left;
          Result.Y := b.Top + b.Height div 2;
          end;
        beLeft : begin
          Result.X := b.Left;
          Result.Y := b.Top + b.Height div 2;
          end;
        beBottom : begin
          Result.X := b.Left + b.Width div 2;
          Result.Y := b.Top + b.Height;
          end;
      end;
  end;

begin
  LayoutEdited := true;
  if Sender is TERPMainSwitchMovingButton then
  begin
    b := sender as TERPMainSwitchMovingButton;
    p := TPanel(b.Parent);
    for idx := 0 to  p.ComponentCount - 1 do
      if p.Components[idx] is TLine then
      begin
        if TLine(p.Components[idx]).ActionFrom = b then
          TLine(p.Components[idx]).StartPoint := Link(TLine(p.Components[idx]).StartPoint)
        else if TLine(p.Components[idx]).ActionTo = b then
          TLine(p.Components[idx]).EndPoint := Link(TLine(p.Components[idx]).EndPoint);
        TLine(p.Components[idx]).Invalidate;
      end;
  end
  else
  begin

  end;
end;

procedure TMainSwitch2.PageLayoutItemSelected(Sender: TObject);
var
  idx : integer;
  n : integer;
  l : TLine;
  b : TERPMainSwitchMovingButton;
  r : TRect;
  pt1, pt2,
  pt : TPoint;
  DoLink : boolean;

begin
  n := (FPanelIndex + 1) mod 2;
  if not assigned(Sender) then
    exit;
  if (Sender is TERPMainSwitchMovingButton) and Assigned(PageLayoutSelectedItem) and
     (PageLayoutSelectedItem is TLine) and not PageLayoutItemsLinked(Sender, PageLayoutSelectedItem) then
  begin
    // Line was selected and potencially was dropped on the button
    l := TLine(PageLayoutSelectedItem);
    b := TERPMainSwitchMovingButton(Sender);

    DoLink := true;
    case l.SelectedPoint of
      lsNotSelected: DoLink := false;
      lsPoint1: pt := l.StartPoint;
      lsPoint2: pt := l.EndPoint;
      lsLine: DoLink := False;
    end;
    if DoLink then
    begin
      pt1 := b.ClientToScreen(Point(0,0));
      pt2 := b.ClientToScreen(Point(b.Width, b.Height));
      r := Rect(pt1.X, pt1.Y, pt2.X, pt2.Y);
      pt := l.ClientToScreen(pt);

      case ButtonEdge(r, pt) of
        beTop : begin
          Pt1.X := b.Left + b.Width div 2;
          Pt1.Y := b.Top;
          end;
        beRight : begin
          pt1.X := b.Width + b.Left;
          pt1.Y := b.Top + b.Height div 2;
          end;
        beLeft : begin
          pt1.X := b.Left;
          pt1.Y := b.Top + b.Height div 2;
          end;
        beBottom : begin
          Pt1.X := b.Left + b.Width div 2;
          pt1.Y := b.Top + b.Height;
          end;
      end;
      // Line coords are in Parent system!
      if l.SelectedPoint = lsPoint1 then
      begin
        l.StartPoint := pt1;
        l.ActionFrom := b;
      end
      else
      begin
        l.EndPoint := pt1;
        l.ActionTo := b;
      end;
    end;
  end;

  for idx := 0 to  pnlArray[n].ComponentCount - 1 do
  begin
    if pnlArray[n].Components[idx] = Sender then
      Continue;
    if (pnlArray[n].Components[idx]) is TERPMainSwitchMovingButton then
    begin
      TERPMainSwitchMovingButton(pnlArray[n].Components[idx]).Selected := false;
    end
    else if pnlArray[n].Components[idx] is TLine then
    begin
      TLine(pnlArray[n].Components[idx]).Selected := false;
    end;
  end;
  PageLayoutSelectedItem := Sender;
end;

function TMainSwitch2.PageLayoutItemsLinked(AButton, ALine: TObject): boolean;
begin
  Result := false;
  if not (AButton is  TERPMainSwitchMovingButton) then
    exit;
  if not (aLine is TLine) then
    exit;

  Result := ((Assigned(TLine(ALine).ActionFrom)) and assigned(TLine(ALine).ActionFrom.Action) and SameText(TERPMainSwitchMovingButton(AButton).Action.Name, TLine(ALine).ActionFrom.Action.Name )) or
            (Assigned(TLine(ALine).ActionTo) and assigned(TLine(ALine).ActionTo.Action) and SameText(TERPMainSwitchMovingButton(AButton).Action.Name, TLine(ALine).ActionTo.Action.Name));
end;

procedure TMainSwitch2.ChangeHeight(const Value :Integer; AddTocurent:Boolean );
var
  fih:Integer;
begin
  if AddTocurent then
    fih := MainSwitch2.Height  +Value
  else fih := Value;
  if fih < MENU_FORM_MIN_HEIGHT then begin
    Mainform.TimerMsg('Minimum Height to Show 1 Raw of Options is ' + inttostr(MENU_FORM_MIN_HEIGHT) +'.  Its not Possible to Decrease it Any Further');
    fih :=  MENU_FORM_MIN_HEIGHT;
  end;
  if Screen.Height - fih - 160 <0 then begin
    Mainform.TimerMsg('Possible Maximum Height of the form is ' + inttostr(Screen.Height - Mainform.MainToolBar.Height -Mainform.StatusBar.Height) +'.  Its not Possible to Increase it Any Further');
    fih :=Screen.Height - 160;
  end;
  MainSwitch2.Height :=fih;
  if fih = MENU_FORM_MIN_HEIGHT then // ERP default height
  else  appenv.CompanyPrefs.UserSetMainSwitchHeight :=fih;
  Centreform;
end;
procedure TMainSwitch2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_DOWN) and (ssShift in Shift) and (ssAlt in Shift) and (ssCtrl in Shift) then begin
    ChangeHeight(CustomInputInteger('Increase Height' , 'Height is : ' + inttostr(MainSwitch2.Height)+NL+'Please Provide Height to Increase.'+NL + inttostr(MainSwitch2.Height)+' + ?' , '5', 0), true);
  end else if (Key = VK_up) and (ssShift in Shift) and (ssAlt in Shift) and (ssCtrl in Shift) then begin
    ChangeHeight(0-CustomInputInteger('Decrease Height' , 'Height is : ' + inttostr(MainSwitch2.Height)+NL+'Please Provide Height to Decrease.'+NL + inttostr(MainSwitch2.Height)+' - ?'  , '5',0), true);
  end else if (Key = Ord('W')) and (ssShift in Shift) and (ssAlt in Shift) and (ssCtrl in Shift) then begin
    dtmMainGUI.actWebAPITest.Execute;
  end else if (Key = Ord('C')) and (ssShift in Shift) and (ssAlt in Shift) and (ssCtrl in Shift) then begin
    raise Exception.Create('TEST EXCEPTION');
  end else begin
    {$IFDEF DevMode}
    if Key = VK_ESCAPE then Begin
      btnExit.click;
    end;
    {$ENDIF}
  end;
end;

function TMainSwitch2.ValidPassword: Boolean;
begin
  result := False;
  if Sysutils.SameText(InputPassword , 'vf') then begin
      REsult := true;
  end else begin
    MessageDlgXP_Vista('Invlid Password' , mtWarning , [mbOk], 0);
  end;

end;

procedure TMainSwitch2.WMNCACTIVATE(var Msg: TWMNCActivate);
begin
  inherited;
  DrawCaptionText
end;

procedure TMainSwitch2.WMNCPaint(var Msg: TWMNCPaint);
begin
  inherited;
  DrawCaptionText
end;

procedure TMainSwitch2.LoadFlagImage;
begin
  AdvPicture1.Picture:= nil;
  AdvPicture2.Picture:= nil;
  AppEnv.RegionalOptions.LoadFlagPicture(AdvPicture1.Picture);
  AppEnv.RegionalOptions.LoadFlagPicture(AdvPicture2.Picture);
end;

end.

