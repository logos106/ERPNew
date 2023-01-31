unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, ImgList, shellapi, AppEvnts, ComCtrls,
  ERPMessagesDb, JsonObject, ConfigDbObj, AdvSmoothButton, ExtCtrls,
  DbSharedObjectsObj, ERPMessageExpander, StdCtrls, HTMLPopup, AdvSmoothPopup;

const
    WM_ICONTRAY = WM_USER + 1;

type
  TDelayProc = procedure() of object;
  TUpdateCheckProc = procedure() of object;

  TConectionMonitor = class;
  TfmMain = class(TForm)
    ImageList: TImageList;
    ActionList1: TActionList;
    actExit: TAction;
    actShowMessages: TAction;
    popTray: TPopupMenu;
    ShowMessages1: TMenuItem;
    ExitTrueERPMessages1: TMenuItem;
    StatusBar: TStatusBar;
    sbMessages: TScrollBox;
    pnlBottom: TPanel;
    actNext: TAction;
    actPrev: TAction;
    actMenu: TAction;
    btnMenu: TButton;
    actOpenAll: TAction;
    actCloseAll: TAction;
    btnOpenAll: TButton;
    btnCloseAll: TButton;
    tmrDelayMethod: TTimer;
    btnNext: TButton;
    btnPrior: TButton;
    popNew: TAdvSmoothPopup;
    ImageList32: TImageList;
    pnlPop: TPanel;
    btnBin: TButton;
    actBin: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actExitExecute(Sender: TObject);
    procedure actShowMessagesExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actOpenAllExecute(Sender: TObject);
    procedure actCloseAllExecute(Sender: TObject);
    procedure tmrDelayMethodTimer(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actPrevExecute(Sender: TObject);
    procedure popNewButtonClick(Sender: TObject; Index: Integer);
    procedure pnlPopClick(Sender: TObject);
    procedure popNewShow(Sender: TObject);
    procedure actMenuExecute(Sender: TObject);
    procedure actBinExecute(Sender: TObject);
    procedure btnBinDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure btnBinDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    TrayIconData: TNotifyIconData;
    ERPConnectionFile: string;
    fServer,
    fUser: string;
    fLastIniDate: TDateTime;
    db: TERPMEssagesDb;
    fConfig: TJsonObject;
    fConfigDb: TConfigDb;
    dbShare: TDbSharedObj;
    fSortType: TMessageSortType;
    fDelayProc: TDelayProc;
    fCurrentOffset: integer;
    fConectionMonitor: TConectionMonitor;
    procedure ReadERPConnectionInfo;
//    function ERPLoginChanged: boolean;
    function GetConfig: TJsonObject;
    procedure DoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DoClick(Sender: TObject);
    procedure DOMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LoadMessages(offset: integer);
//    procedure DoMouseEnter(Sender: TObject);
//    procedure DoMouseLeave(Sender: TObject);
    procedure DoMove(src, dst: TERPMessageExpander);
    procedure DoOnPanelExpand(Sender: TObject);
    procedure SaveItem(item: TERPMessageExpander);
    procedure DoDelayProc(Proc: TDelayProc; DelayMilliSecs: integer = 100);
    procedure DoOnSortChange(Sender: TObject; SortType: TMessageSortType);
    procedure DisableAnimation;
    procedure EnableAnimation;
    procedure ShowPopUp(msg: string);
    procedure HidePopUp;
//    procedure ShowPop;
    procedure DoOnConnectionChange(aUserName, aServerName: string);
    procedure DoOnNewMessages(aMessageList: string);
    function GetListType: string;
    procedure SetListType(const Value: string);
    procedure CheckForUpdates;
  protected
    property Config: TJsonObject read GetConfig;
    procedure SaveConfig;
    property ListType: string read GetListType write SetListType;
  public
    procedure TrayMessage(var Msg: TMessage); message WM_ICONTRAY;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  end;

  TOnERPConnectionChange = procedure (aUserName, aServerName: string) of object;
  TOnERPNewMessages = procedure (aMessageList: string) of object;


  TConectionMonitor = class(TThread)
  private
    fERPConnectionFileName: string;
    fOnConnectionChange: TOnERPConnectionChange;
    fOnNewMessages: TOnERPNewMessages;
    fOnUpdateCheck: TUpdateCheckProc;
    fServer,
    fUser: string;
    fLastIniDate: TDateTime;
    fNextConnectionCheckTime: TDateTime;
    fNextNewMessageCheckTime: TDateTime;
    fNextUpdateCheckTime: TDateTime;
    db: TERPMEssagesDb;
    dbShare: TDbSharedObj;
    fNewMsgSubjects: TStringList;
    procedure DoOnConnectionChange;
    procedure DoOnNewMessages;
    procedure DoOnUpdateCheck;
    function ERPLoginChanged: boolean;
    procedure CheckForNewMessages;
    procedure DoWork;
  protected
    procedure Execute; override;
  public
//    constructor Create(CreateSuspended: boolean);
    constructor Create(ERPConnectionFileName: string);
    destructor Destroy; override;
//    property
    property OnConnectionChange: TOnERPConnectionChange read fOnConnectionChange write fOnConnectionChange;
    property OnNewMessages: TOnERPNewMessages read fOnNewMessages write fOnNewMessages;
    property OnUpdateCheck: TUpdateCheckProc read fOnUpdateCheck write fOnUpdateCheck;
  end;

var
  fmMain: TfmMain;
(*
  https://erpserver1/erpapi/TTasks?select=[ID] > 100 and [TaskType] = "Feature"&PropertyList=Subject,Details,VersionNo,CreatedOn
{
    "ttasks":[
    {
        "Id":1,
        "MsTimeStamp":"2012-12-13 14:00:32",
        "MsUpdateSiteCode":"DEF",
        "GlobalRef":"DEF1",
        "Subject":"Automatic Stock Transfers ",
        "Details":"Auto generation of Stock Transfer when selling products from different Departments",
        "VersionNo":"9004\/10060",
        "CreatedOn":"2012-02-24 12:39:18"
    },
    {
        "Id":2,
        "MsTimeStamp":"2012-12-13 14:00:32",
        "MsUpdateSiteCode":"DEF",
        "GlobalRef":"DEF2",
        "Subject":"Stock Departments",
        "Details":"Added the ability to select stock from different departments from a Sales transaction ",
        "VersionNo":"9004\/10060",
        "CreatedOn":"2012-02-24 12:39:49"
    },
*)

implementation

{$R *.dfm}

uses
  systemLib, shlobj, IniFiles, ERPDbComponents, frmConfig, UpdaterCallUtils,
  FileVersion, LogThreadLib, LogMessageTypes, VersionUtils,
  Vista_MessageDlg, ProgressDialog, InstallConst, UpdateStoreObj, Db;

const
  Config_Prefix = 'ERP_Messages_';
//  Message_PageSize = 100; //40;

procedure TfmMain.actBinExecute(Sender: TObject);
begin
  if SameText(Config.S['ListType'], 'Normal') then begin
    ListType := 'Deleted';
  end
  else begin
    ListType := 'Normal';
  end;
  fCurrentOffset := 0;
  LoadMessages(fCurrentOffset);
end;

procedure TfmMain.actCloseAllExecute(Sender: TObject);
var
  x: integer;
begin
  sbMessages.DisableAlign;
  try
    DisableAnimation;
    for x := 0 to sbMessages.ControlCount -1 do
      if sbMessages.Controls[x] is TERPMessageExpander then
        TERPMessageExpander(sbMessages.Controls[x]).Expanded := false;
    DoDelayProc(EnableAnimation,5000);
  finally
    sbMessages.EnableAlign;
  end;
end;

procedure TfmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.actMenuExecute(Sender: TObject);
begin
  if DoConfig(Config) then begin
    SaveConfig;
    ListType := Config.S['ListType'];
    fCurrentOffset := 0;
    LoadMessages(fCurrentOffset);
  end;
end;

procedure TfmMain.actNextExecute(Sender: TObject);
begin
  Inc(fCurrentOffset);
  self.LoadMessages(fCurrentOffset * Config.I['ListSize']);
end;

procedure TfmMain.actOpenAllExecute(Sender: TObject);
var
  x: integer;
begin
  sbMessages.DisableAlign;
  try
    DisableAnimation;
    for x := 0 to sbMessages.ControlCount -1 do
      if sbMessages.Controls[x] is TERPMessageExpander then
        TERPMessageExpander(sbMessages.Controls[x]).Expanded := true;
    DoDelayProc(EnableAnimation,5000);
  finally
    sbMessages.EnableAlign;
  end;
end;

procedure TfmMain.actPrevExecute(Sender: TObject);
begin
  if fCurrentOffset = 0 then exit;
  Dec(fCurrentOffset);
  self.LoadMessages(fCurrentOffset * Config.I['ListSize']);
end;

procedure TfmMain.actShowMessagesExecute(Sender: TObject);
begin
  self.Show;
end;

procedure TfmMain.btnBinDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if Source is TERPMessageExpander then begin
    if SameText(Config.S['ListType'],'Deleted') then
      TERPMessageExpander(Source).Active := true
    else
      TERPMessageExpander(Source).Active := false;
    self.SaveItem(TERPMessageExpander(Source));
    TERPMessageExpander(Source).Free;
  end;
end;

procedure TfmMain.btnBinDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Source is TERPMessageExpander then
    Accept := true;
end;

procedure TfmMain.DisableAnimation;
var
  x: integer;
begin
  for x := 0 to sbMessages.ControlCount -1 do
    if sbMessages.Controls[x] is TERPMessageExpander then begin
      TERPMessageExpander(sbMessages.Controls[x]).AnimationFactor := 1;
//      TERPMessageExpander(sbMessages.Controls[x]).Align := alNone;
    end;
end;

procedure TfmMain.DoClick(Sender: TObject);
begin

end;

procedure TfmMain.DoDelayProc(Proc: TDelayProc; DelayMilliSecs: integer);
begin
  fDelayProc:= Proc;
  self.tmrDelayMethod.Interval := DelayMilliSecs;
  self.tmrDelayMethod.Enabled := true;
end;

procedure TfmMain.DoDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if (Source is TERPMessageExpander) and (Sender is TERPMessageExpander) then begin
    DoMove(TERPMessageExpander(Source), TERPMessageExpander(Sender));
  end;
end;

procedure TfmMain.DoDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Source is TERPMessageExpander then
    Accept := true;
end;

procedure TfmMain.DOMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Sender is TERPMessageExpander then begin
    if x < (TERPMessageExpander(Sender).Width - 20) then
      TERPMessageExpander(Sender).BeginDrag(true)
//    else
//      TERPMessageExpander(Sender).Expanded := not TERPMessageExpander(Sender).Expanded;
  end;
end;

procedure TfmMain.DoMove(src, dst: TERPMessageExpander);
var
  sql: string;
  scr: TERPScript;
begin
  if src.Top < dst.Top then begin
    src.Top := dst.Top + 1;
    sql := 'update tblerpusermessages set SortID = SortID +1 where SortId > ' + IntToStr(dst.SortId -1) +
      ' and SortId < ' + IntToStr(src.SortId +1) + ' and Id <> ' + IntToStr(src.Id) + ';';
    src.SortId := dst.SortId;
  end
  else begin
    src.Top := dst.Top - 1;
    sql := 'update tblerpusermessages set SortID = SortID -1 where SortId < ' + IntToStr(dst.SortId +1) +
      ' and SortId > ' + IntToStr(src.SortId -1) + ' and Id <> ' + IntToStr(src.Id) + ';';
    src.SortId := dst.SortId;
  end;
  scr := dbShare.GetScript(db.Connection);
  try
    scr.SQL.Add('update tblerpusermessages set SortId = ' + IntToStr(src.SortId) + ' where id = ' + IntToStr(src.Id) + ';');
    scr.SQL.Add(sql);
    scr.Execute;
  finally
    dbShare.ReleaseObj(scr);
  end;
end;

procedure TfmMain.DoOnConnectionChange(aUserName, aServerName: string);
var
  sUser, sServer: string;
begin
  TLogger.Inst.Log('DoOnConnectionChange - Start');
  fUser := aUserName;
  fServer := aServerName;
//  db.ERPUserName := fUser;
  db.Server := fServer;
  fCurrentOffset := 0;
  ListType := Config.S['ListType'];
  sUser := fUser;
  if sUser = '' then sUser := '[Unknown]';
  sServer := fServer;
  if sServer = '' then sServer := '[Unknown]';
  StatusBar.Panels[0].Text := 'User: ' + sUser + ' on: ' + sServer;
  self.LoadMessages(fCurrentOffset);
  TLogger.Inst.Log('DoOnConnectionChange - End');
end;

procedure TfmMain.DoOnNewMessages(aMessageList: string);
begin
  TLogger.Inst.Log('DoOnNewMessages - Start');
  self.ShowPopUp(aMessageList);
  if SameText(Config.S['ListType'], 'Normal') then begin
    { only refresh list if user is not viewing deleted }
    fCurrentOffset:= 0;
    self.LoadMessages(fCurrentOffset);
  end;
  TLogger.Inst.Log('DoOnNewMessages - End');
end;

procedure TfmMain.DoOnPanelExpand(Sender: TObject);
begin
  if TERPMessageExpander(Sender).Expanded and TERPMessageExpander(Sender).NewMessage then begin
    TERPMessageExpander(Sender).NewMessage := false;
    SaveItem(TERPMessageExpander(Sender));
  end;
end;

procedure TfmMain.DoOnSortChange(Sender: TObject; SortType: TMessageSortType);
begin
  fSortType := SortType;
  fCurrentOffset:= 0;

  self.LoadMessages(fCurrentOffset * Config.I['ListSize']);
end;

//procedure TfmMain.DoMouseEnter(Sender: TObject);
//var
//  pt: TPoint;
//begin
//  pt := Mouse.CursorPos;
//  pt := TERPMessageExpander(Sender).ScreenToClient(pt);
//  if pt.X > (TERPMessageExpander(Sender).Width - 20) then
//    TERPMessageExpander(Sender).Expanded := true;
//end;

//procedure TfmMain.DoMouseLeave(Sender: TObject);
//var
//  pt: TPoint;
//begin
//  pt := Mouse.CursorPos;
//  pt := TERPMessageExpander(Sender).ScreenToClient(pt);
//  if pt.X > (TERPMessageExpander(Sender).Width - 20) then
//    TERPMessageExpander(Sender).Expanded := false;
//end;

procedure TfmMain.EnableAnimation;
var
  x: integer;
begin
  for x := 0 to sbMessages.ControlCount -1 do
    if sbMessages.Controls[x] is TERPMessageExpander then begin
      TERPMessageExpander(sbMessages.Controls[x]).AnimationFactor := 4;
//      TERPMessageExpander(sbMessages.Controls[x]).Align := alTop;
    end;
end;

//function TfmMain.ERPLoginChanged: boolean;
//var
//  dt: TDateTime;
//  ini: TIniFile;
//  svr, usr: string;
//begin
//  result := false;
//  if ERPConnectionFile <> '' then begin
//    if FileAge(ERPConnectionFile,dt) then begin
//      if fLastIniDate <> dt then begin
//        { file has changed }
//        fLastIniDate := dt;
//        ini := TIniFile.Create(ERPConnectionFile);
//        try
//          svr:= ini.ReadString('Last_Database','LastConnectServer','');
//          usr:= ini.ReadString('Last_Database','UserName','');
//        finally
//          ini.Free;
//        end;
//        if (svr <> '') and (usr <> '') then begin
//          if (not SameText(fServer, svr)) or (not SameText(fServer, svr)) then begin
//            result := true;
//            self.fServer := svr;
//            self.fUSer := usr;
//          end;
//        end;
//      end;
//    end;
//  end;
//end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := false;
  if MessageDlg('Are you sure you want to exit True ERP Messages?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    CanClose := true;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  icon: TIcon;
begin
  inherited;
  TLogger.Inst.LogAllTypes;
//  ERPConnectionFile;
//  Caption := Caption + ' ' + FileVersion.GetFileVersion;
  popNew.Control := pnlPop;
  fSortType := msSeq;
  dbShare := TDbSharedObj.Create;
  fCurrentOffset:= 0;
  sbMessages.VertScrollBar.Tracking := true;
  TrayIconData.cbSize := SizeOf(TrayIconData);
  TrayIconData.Wnd := Handle;
  TrayIconData.uID := 0;
  TrayIconData.uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
  TrayIconData.uCallbackMessage := WM_ICONTRAY;
  TrayIconData.hIcon := Application.Icon.Handle;
//  StrPCopy(TrayIconData.szTip, Application.Title);
  StrPCopy(TrayIconData.szTip, 'True ERP Messages');

  Shell_NotifyIcon(NIM_ADD, @TrayIconData);

  icon := TIcon.Create;
  try
    ImageList.GetIcon(0,icon);
    TrayIconData.hIcon := icon.Handle;
    Shell_NotifyIcon(NIM_Modify, @TrayIconData);

  finally
    icon.Free;
  end;
  db := TERPMEssagesDb.Create;
  ReadERPConnectionInfo;
  if (fServer <> '') and (fUser <> '') then begin
//    db.ERPUserName := fUser;
    db.Server := fServer;
  end;

  fConfigDb := TConfigDb.Create('','');
  fConectionMonitor:= TConectionMonitor.Create(ERPConnectionFile);
  fConectionMonitor.OnConnectionChange := DoOnConnectionChange;
  fConectionMonitor.OnNewMessages := DoOnNewMessages;
  fConectionMonitor.OnUpdateCheck := self.CheckForUpdates;
  ListType := Config.S['ListType'];
//  CheckForUpdates;

//  self.DoDelayProc(ShowPop,5000);
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  fConectionMonitor.OnConnectionChange := nil;
  fConectionMonitor.Terminate;
  db.Free;
  fConfig.Free;
  fConfigDb.Free;
  dbShare.Free;
  Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
  inherited;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
//  self.LoadMessages(fCurrentOffset * Message_PageSize);
end;

function TfmMain.GetConfig: TJsonObject;
begin
  if not Assigned(fConfig) then
    fConfig := JO;
  if (fServer <> '') and (fUser <> '') then begin
    if (not SameText(fConfigDb.ServerName, self.fServer)) or
       (not SameText(fConfigDb.ConfigName, Config_Prefix + fUser)) then begin
      fConfigDb.ServerName :=  self.fServer;
      fConfigDb.ConfigName := Config_Prefix + fUser;
      fConfig.AsString := fConfigDb.Value;
      if fConfig.Count = 0 then begin
        { set defaults .. }
        fConfig.I['ListSize'] := 100;
        fConfig.S['ListType'] := 'Normal';
        fConfigDb.Value := fConfig.AsString;
      end;
    end;
  end;
  result := fConfig;
end;

function TfmMain.GetListType: string;
begin
  result := Config.S['ListType'];
end;

procedure TfmMain.HidePopUp;
begin
  popNew.ClosePopup;
end;

procedure TfmMain.LoadMessages(offset: integer);
var
  qry: TERPQuery;
  item: TERPMessageExpander;
begin
  sbMessages.DisableAlign;
  try

    { clear all messages }
    while sbMessages.ControlCount > 0 do
      sbMessages.Controls[0].Free;

    qry:= dbShare.GetQuery(db.Connection);
    try
      qry.SQL.Add('select um.Id as Id, um.SortId as SortId, um.NewMessage as NewMessage, um.Active as Active,');
      qry.SQL.Add('m.VersionNo as VersionNo, m.CreatedOn as CreatedOn, m.Subject as Subject, m.Details as Details');
      qry.SQL.Add('from tblerpusermessages um, tblerpmessages m');
      qry.SQL.Add('where um.MessageId = m.Id');
      qry.SQL.Add('and um.UserName = ' + QuotedStr(fUser));
      if SameText(Config.S['ListType'],'Deleted') then
        qry.SQL.Add('and um.Active = "F"')
      else
        qry.SQL.Add('and um.Active = "T"');
      case fSortType of
        msSeq:
          qry.SQL.Add('order by um.SortId desc');
        msDate:
          qry.SQL.Add('order by m.CreatedOn desc, um.SortId desc');
        msVersion:
          qry.SQL.Add('order by m.VersionNo desc, um.SortId desc');
      end;

      qry.SQL.Add('limit ' + IntToStr(Config.I['ListSize']) + ' offset ' + IntToStr(offset));
      qry.Open;

      actPrev.Enabled := fCurrentOffset > 0;
      actNext.Enabled := qry.RecordCount = Config.I['ListSize'];


      while not qry.Eof do begin
        item:= TERPMessageExpander.Create(self);
        item.SubjectText := qry.FieldByName('Subject').AsString; // + ' [' + IntToStr(qry.FieldByName('Id').AsInteger) + ']';
        item.BodyText := qry.FieldByName('Details').AsString;
        item.Id := qry.FieldByName('Id').AsInteger;
        item.SortId := qry.FieldByName('SortId').AsInteger;
        item.NewMessage := qry.FieldByName('NewMessage').AsBoolean;
        item.Active := qry.FieldByName('Active').AsBoolean;
        item.CreatedOn := qry.FieldByName('CreatedOn').AsDateTime;
        item.Version := qry.FieldByName('VersionNo').AsString;
        item.SortType := fSortType;
        item.OnSortChange := self.DoOnSortChange;


        item.Parent := sbMessages;
        item.Align := alTop;
        item.Top := MaxInt;
        item.OnDragOver := DoDragOver;
        item.OnDragDrop := DoDragDrop;
        item.OnClick := DoClick;
        item.OnMouseDown := DoMouseDown;
        item.OnExpandPanel := DoOnPanelExpand;
        qry.Next;
      end;

    finally
      dbShare.ReleaseObj(qry);
    end;
  finally
    sbMessages.EnableAlign;
  end;
  { force scroll bar to resize }
  if sbMessages.ControlCount > 0 then begin
    if sbMessages.VertScrollBar.Position > 0 then begin
      sbMessages.VertScrollBar.Position := sbMessages.VertScrollBar.Position -1;
      sbMessages.VertScrollBar.Position := sbMessages.VertScrollBar.Position +1;
    end
    else begin
      sbMessages.VertScrollBar.Position := sbMessages.VertScrollBar.Position +1;
      sbMessages.VertScrollBar.Position := sbMessages.VertScrollBar.Position -1;
    end;
  end;
end;

procedure TfmMain.pnlPopClick(Sender: TObject);
begin
  Show;
//  pnlPop.Caption := IntToStr(pnlPop.Width);
end;

procedure TfmMain.popNewButtonClick(Sender: TObject; Index: Integer);
begin
  popNew.ClosePopup;
end;

procedure TfmMain.popNewShow(Sender: TObject);
begin
//  pnlPop.Caption := IntToStr(pnlPop.Width);

end;

procedure TfmMain.ReadERPConnectionInfo;
var
  dir: string;
  ini: TIniFile;
  sUser, sServer: string;
begin
  ERPConnectionFile := '';
  { try and find the ERP connetion.ini info }
  dir := ExtractFilePath(Application.ExeName);
  if not FileExists(dir + 'connection.ini') then
    dir := SpecialFolder(CSIDL_PROGRAM_FILESX86) + 'ERP Software\';
  if not FileExists(dir + 'connection.ini') then begin
    StatusBar.Panels[0].Text := 'Error - Could not find ERP install folder.';
    exit;
  end;
  ERPConnectionFile := dir + 'connection.ini';
  StatusBar.Panels[0].Text := 'ERP Path = ' + dir;
  ini := TIniFile.Create(ERPConnectionFile);
  try
    fServer:= ini.ReadString('Last_Database','LastConnectServer','');
    fUser:= ini.ReadString('Last_Database','UserName','');
    FileAge(ERPConnectionFile,fLastIniDate);
    sUser := fUser;
    if sUser = '' then sUser := '[Unknown]';
    sServer := fServer;
    if sServer = '' then sServer := '[Unknown]';
    StatusBar.Panels[0].Text := 'User: ' + sUser + ' on: ' + sServer;
  finally
    ini.Free;
  end;
end;

procedure TfmMain.SaveConfig;
begin
  fConfigDb.Value := fConfig.AsString;
end;

procedure TfmMain.SaveItem(item: TERPMessageExpander);
var
  cmd: TERPCommand;
begin
  cmd := dbShare.GetCommand(db.Connection);
  try
    cmd.SQL.Add('update tblerpusermessages set');
    cmd.SQL.Add('SortId = ' + IntToStr(item.SortId));
    if item.NewMessage then
      cmd.SQL.Add(',NewMessage = "T"')
    else
      cmd.SQL.Add(',NewMessage = "F"');
    if item.Active then
      cmd.SQL.Add(',Active = "T"')
    else
      cmd.SQL.Add(',Active = "F"');
    cmd.SQL.Add('where id = ' + IntToStr(item.Id));
    cmd.Execute;
  finally
    dbShare.ReleaseObj(cmd);
  end;
end;

procedure TfmMain.SetListType(const Value: string);
begin
  if not SameText(Config.S['ListType'], Value) then begin
    Config.S['ListType'] := Value;
    SaveConfig;
  end;
  if SameText(Config.S['ListType'], 'Deleted') then begin
    actBin.ImageIndex := 7;
    Caption := 'True ERP Deleted Messages (Ver ' + FileVersion.GetFileVersion + ')';
    actBin.Hint := 'Drag messages here to undelete them, click to show messages.';
  end
  else begin
    actBin.ImageIndex := 5;
    Caption := 'True ERP Messages (Ver ' + FileVersion.GetFileVersion + ')';
    actBin.Hint := 'Drag messages here to delete them, click to show deleted messages.';
  end;
end;

//procedure TfmMain.ShowPop;
//begin
//  ShowPopUp('This is the first line.' + #13#10 +
//    'This is the second line that is longer than the first line.' + #13#10 +
//    'This is line three.' + #13#10 + 'This is line number four' + #13#10 +
//    'This line number five' + #13#10 +
//    'This is the last line being line six.');
//end;

procedure TfmMain.ShowPopUp(msg: string);
var
  x, y, i: integer;
  sl: TStringList;
  lbl: TLabel;
  lineCount: double;

  function ShrinkLine(line: string): string;
  begin
    result := line;
    if self.Canvas.TextWidth(result) > (popNew.Width - 25 - 6) then begin
      while (self.Canvas.TextWidth(result + '..') > (popNew.Width - 25 - 6)) and (Length(result) > 3) do
        result := Copy(result, 1, Length(result) -1);
      result := result + '..';
    end;
  end;

begin
  popNew.HeaderCaption := 'TrueERP - New Messages';
  popNew.FooterCAption := '';
  popNew.FooterHeight := 3;
//  popNew.Control := Label1;

  popNew.Animation := true;
  popNew.AnimationFactor := 1;

  if msg <> '' then begin
    while pnlPop.ControlCount > 0 do
      pnlPop.Controls[0].Free;
    sl := TStringList.Create;
    try
      sl.CommaText := msg;
      lbl := nil;
      for I := 0 to sl.Count -1 do begin
        lbl := TLabel.Create(pnlPop);
        lbl.OnClick := pnlPop.OnClick;
        lbl.Parent := pnlPop;
        lbl.Align := alTop;
        if i = 4 then begin
          lbl.Caption := 'More ...';
          break;
        end;
        lbl.Caption := ShrinkLine(sl[i]);
      end;
      if Assigned(lbl) then begin
        if sl.Count < 6 then
          lineCount := sl.Count
        else
          lineCount := 5.5;
        popNew.Height := Round(popNew.HeaderHeight +
          popNew.FooterHeight +
//          popNew.ArrowSize +
//          popNew.ShadowSize +
          (lineCount * lbl.Height) +
          pnlPop.Padding.Top +
          pnlPop.Padding.Bottom +
          4);

      end;

    finally
      sl.Free;
    end;
  end;

  x:= Screen.WorkAreaRect.Right - popNew.Width - popNew.ShadowSize;
  y:= Screen.WorkAreaRect.Bottom - popNew.Height - popNew.ArrowSize - popNew.ShadowSize;

  popNew.PopupAt(x,y);
  self.DoDelayProc(HidePopUp,10000);
end;

procedure TfmMain.tmrDelayMethodTimer(Sender: TObject);
begin
  tmrDelayMethod.Enabled := false;
  fDelayProc;
end;

procedure TfmMain.TrayMessage(var Msg: TMessage);
var
  p: TPoint;
begin
  case Msg.lParam of
    WM_LBUTTONDOWN:
    begin
//      ShowMessage('Left button clicked - let''s SHOW the Form!');
//      fmMain.Show;
//      ShowMessage('This icon responds to RIGHT BUTTON click!');
      self.Show;
    end;
    WM_RBUTTONDOWN:
    begin
       SetForegroundWindow(Handle);
       GetCursorPos(p);
       popTray.Popup(p.x, p.y);
       PostMessage(Handle, WM_NULL, 0, 0);
    end;
  end;
end;

procedure TfmMain.WMSysCommand(var Msg: TWMSysCommand);
begin
  if (Msg.CmdType = SC_MINIMIZE) or (Msg.CmdType = SC_MAXIMIZE) then
    self.Hide
  else
    DefaultHandler(Msg);
end;

procedure TfmMain.CheckForUpdates;
var
  ver: string;
  UpdaterDest: string;
  UpdateProgress: TProgressDialog;
  done: boolean;
  UpdateStore: TUpdateStore;
  msg: string;
  UpdateConfig: TJsonObject;
  s: string;
begin
  TLogger.Inst.Log('CheckForUpdates - Start');
  try
    ver := db.LatestVersion;
    if (ver <> '') and (VersionComp(ver,GetFileVersion) > 0) then begin

      Vista_MessageDlg.MessageDlgXP_Vista('A newer version of the True ERP Messages application (' +
        ver + ') is available.' + #13#10 + #13#10 +
        'True ERP Messages will now be updated.', mtInformation, [mbOK], 0);
      { now do the update }

      { get the client updater }
      UpdaterDest:= SystemLib.WinTempDir + 'ERPClientUpdater.exe';
      DeleteFile(UpdaterDest);
      UpdateProgress:= TProgressDialog.Create(nil);
      UpdateProgress.Message:= 'Downloading updater ...';
      UpdateProgress.Execute;
      try
        { try update store first }
        msg := '';
        done:= false;
        UpdateStore:= TUpdateStore.Create;
        try
          try
            UpdateStore.Server:= db.Connection.Server;
            with UpdateStore.VersionUpdates('ERPClientUpdater','','') do begin
              if RecordCount = 0 then begin

                msg := 'Error - update not found on server for ERP Client Updater';
                //exit;
              end
              else begin
                TBlobField(FieldByName('File')).SaveToFile(UpdaterDest);
                done := true;
              end;
            end;
          except
            on e: exception do begin
              msg := 'Error getting ERP Client Updater file from server: ' + e.Message;
              exit;
            end;
          end;
        finally
          UpdateStore.Free;
        end;

        if done then begin

          UpdateConfig:= TJsonObject.Create;
          try

            UpdateConfig.S['module']:= 'trueerpmessages';
            UpdateConfig.S['softwarereleasetype']:= 'all';
            s:= '{"parts":{"1":' + db.LatestVersionParams + '}}';
            UpdateConfig.O['update'].AsString :=  s; //  Assign(verList.O[aRequest.O['params'].S['version']]);

            UpdateConfig.S['installpath']:= SystemLib.ExeDir;
            UpdateConfig.S['erpfilename']:= ExtractFileName(Application.ExeName);
            UpdateConfig.S['servername']:= db.Connection.Server; //   AppEnv.AppDb.Server;
            //UpdateConfig.S['databasename']:= dbName;
            UpdateConfig.SaveToFile(SystemLib.WinTempDir + 'UpdateConfig.txt');
          finally
            UpdateConfig.Free;
          end;
          msg:= '';
          if not ExecNewWinProcess(UpdaterDest, false, msg) then begin
            MessageDlgXP_Vista('Unable to run the user updater (ERPClientUpdater.exe) as the permissions are insufficient.' + #13#10 +
              'Please open the folder containing the updater (ERPClientUpdater.exe):' + #13#10 +
              ExtractFilePath(UpdaterDest) + #13#10 +
              'and right click on the updater (ERPClientUpdater.exe) and select "Run as administrator"', mtInformation, [mbOK], 0);
          end;
          Application.Terminate;
          Exit;
        end
        else begin
          MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
        end;
      finally
        UpdateProgress.CloseDialog;
        UpdateProgress.Free;
      end;

    end;

  except
    on e: exception do begin
      TLogger.Inst.Log('CheckForUpdates - Error: ' + e.Message, ltError);
    end;
  end;
  TLogger.Inst.Log('CheckForUpdates - End');
end;

{ TConectionMonitor }

procedure TConectionMonitor.CheckForNewMessages;
var
  qry: TERPQuery;
  NewCount: integer;
begin
  if (fUser = '') or (fServer = '') then exit;
  qry := dbShare.GetQuery(db.Connection);
  try
    qry.SQL.Add('select Count(tblerpmessages.Id) as NewCount from tblerpmessages');
    qry.SQL.Add('left join tblerpusermessages on tblerpusermessages.MessageId = tblerpmessages.Id and tblerpusermessages.UserName = ' + QuotedStr(fUser));
    qry.SQL.Add('where IsNull(tblerpusermessages.Id)');
    qry.Open;
    NewCount := qry.FieldByName('NewCount').AsInteger;
    if NewCount > 0 then begin
      { we have new messages }
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('insert into tblerpusermessages (MessageId,UserName,SortId)');
      qry.SQL.Add('select tblerpmessages.Id, ' + QuotedStr(fUser)+ ', tblerpmessages.Id');
      qry.SQL.Add('from tblerpmessages');
      qry.SQL.Add('left join tblerpusermessages on tblerpusermessages.MessageId = tblerpmessages.Id and tblerpusermessages.UserName = ' + QuotedStr(fUser));
      qry.SQL.Add('where IsNull(tblerpusermessages.Id)');
      qry.Execute;
      qry.SQL.Clear;
      if NewCount > 10 then NewCount := 10;
      qry.SQL.Add('select tblerpmessages.Subject');
      qry.SQL.Add('from tblerpmessages, tblerpusermessages');
      qry.SQL.Add('where tblerpmessages.Id = tblerpusermessages.MessageId');
      qry.SQL.Add('and tblerpusermessages.UserName = ' + QuotedStr(fUser));
      qry.SQL.Add('order by tblerpusermessages.Id DESC');
      qry.SQL.Add('limit ' + IntToStr(NewCount));
      qry.Open;
      fNewMsgSubjects.Clear;
      qry.First;
      while not qry.Eof do begin
        fNewMsgSubjects.Add(qry.FieldByName('Subject').AsString);
        qry.Next;
      end;
      self.Synchronize(self.DoOnNewMessages);

    end;
  finally
    dbShare.ReleaseObj(qry);
  end;
end;

constructor TConectionMonitor.Create(ERPConnectionFileName: string);
begin
  fNewMsgSubjects := TStringList.Create;
  fNextConnectionCheckTime := now;
  fERPConnectionFileName := ERPConnectionFileName;
  fNextNewMessageCheckTime := now;
  fNextUpdateCheckTime := now + (1/24/60);
  dbShare := TDbSharedObj.Create;
  db := TERPMEssagesDb.Create;
  inherited Create(false);
  self.FreeOnTerminate := true;
end;

destructor TConectionMonitor.Destroy;
begin
  db.Free;
  dbShare.Free;
  fNewMsgSubjects.Free;
  inherited;
end;

procedure TConectionMonitor.DoOnConnectionChange;
begin
  if Assigned(fOnConnectionChange) then
    fOnConnectionChange(fUser, fServer);
end;

procedure TConectionMonitor.DoOnNewMessages;
begin
  if Assigned(fOnNewMessages) then
    fOnNewMessages(fNewMsgSubjects.CommaText);
end;

procedure TConectionMonitor.DoOnUpdateCheck;
begin
  if Assigned(fOnUpdateCheck) then
    fOnUpdateCheck;
end;

procedure TConectionMonitor.DoWork;
const
  OneSec = 1/24/60/60;
begin
  if now >= fNextConnectionCheckTime then begin
    try
      if ERPLoginChanged then begin
        self.Synchronize(DoOnConnectionChange);
        CheckForNewMessages;
      end;
    finally
      fNextConnectionCheckTime := now + (OneSec * 15);
    end;
  end;
  if now > self.fNextNewMessageCheckTime then begin
    try
      CheckForNewMessages;
    finally
      self.fNextNewMessageCheckTime := now + (OneSec * 60 * 5);
    end;
  end;
  if now >= fNextUpdateCheckTime then begin
    self.Synchronize(DoOnUpdateCheck);
    fNextUpdateCheckTime := now + 1;
  end;
end;

function TConectionMonitor.ERPLoginChanged: boolean;
var
  dt: TDateTime;
  ini: TIniFile;
  svr, usr: string;
begin
  result := false;
  if fERPConnectionFileName <> '' then begin
    if FileExists(fERPConnectionFileName) then begin
      if FileAge(fERPConnectionFileName,dt) then begin
        if fLastIniDate <> dt then begin
          { file has changed }
          fLastIniDate := dt;
          ini := TIniFile.Create(fERPConnectionFileName);
          try
            svr:= ini.ReadString('Last_Database','LastConnectServer','');
            usr:= ini.ReadString('Last_Database','UserName','');
          finally
            ini.Free;
          end;
          if (not SameText(svr, fServer)) or (not SameText(usr, fUSer)) then begin
            result := true;
            self.fServer := svr;
            self.fUSer := usr;
            db.Server := svr;
          end;
        end;
      end
      else begin
        svr := '';
        usr := '';
        if (not SameText(svr, fServer)) and (not SameText(usr, fUSer)) then begin
          result := true;
          self.fServer := svr;
          self.fUSer := usr;
          db.Server := svr;
        end;
      end;
    end;
  end;
end;

procedure TConectionMonitor.Execute;
begin
  inherited;
  while not Terminated do begin
    try
      DoWork;
      Sleep(500);
    except
    end;
  end;
end;

end.
