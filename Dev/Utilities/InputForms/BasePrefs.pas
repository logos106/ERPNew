unit BasePrefs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, PrefsConfigListObj, db, ExtCtrls, StdCtrls, Menus, wwcheckbox,
  ERPdbComponents, MyAccess, DataSourcePrefs, AdvScrollBox, MessageConst, busobjbase;

type
  TSubformStartupStatus = (sssNone =1, sssStarting =2, sssStarted=3, sssDone =4);
  TBasePrefsGUI = class(TfrmBaseGUI)
    sbpanels: TAdvScrollBox;
    procedure FormCreate(Sender: TObject);
  private
    fbPosting:Boolean;
    fsSinglePanelToshow: String;
    function getDoingProcess: boolean;
    procedure setDoingProcess(const Value: boolean);
    procedure setSinglePanelToshow(const Value: String);
    Procedure InitDsPrefs;
    procedure intPreferencesForm(Msg: TMessage);
    function getPrefformStartedStatus: TSubformStartupStatus;
    procedure setPrefformStartedStatus(const Value: TSubformStartupStatus);
(*    procedure PrefformStartup(var Msg: TMessage); message TX_PrefformStartup;
    procedure PrefformFinish(var Msg: TMessage); message TX_PrefformFinish;*)
  Protected
    fPreferencesForm: TForm;
    comboNewValue:String;
    procedure EditDB(ds: TDataset);
    procedure PostDB(ds: TDataset);
    Function Preferenceform :TComponent;
    function IsformClosing:Boolean;
    Procedure CheckBoxEdit(Const checkbox : TwwCheckbox; const Value:Boolean);
    Procedure ShowHintmsg(Sender :TObject ;control:TObject);
    procedure SearchForText(const SearchStr: string; const FocusControlName: string = ''; SearchingCaption :Boolean =True);Virtual;
    Procedure DoOnchangedDataSave(Const Changedfield:Tfield; CleanDs :TMyQuery);Virtual;
    Procedure DsBeforePostAuditTrail(const aQry:TDataSet; const aPrefType:String);overload;virtual;
    procedure DsBeforePostAuditTrail(const aName: String; aidfieldname,aDescFieldname, aFieldValueName:String;const aQry: TDataSet);overload;virtual;
    procedure DoPerformStartup(var Msg: TMessage);
    procedure DoPrefformFinish(var Msg: TMessage);
    procedure StartupProcess(var Msg: TMessage);Virtual;abstract;
    procedure FinishProcess(var Msg: TMessage);Virtual;abstract;
  public
    PrefsConfigList: TPrefConfigList;
    procedure DisableForm; Override;
    procedure EnableForm;  Override;
    constructor Create(AOwner: TComponent); override;
    Property DoingProcess :boolean read getDoingProcess write setDoingProcess;
    Property SinglePanelToshow :String read fsSinglePanelToshow write setSinglePanelToshow;
    Property PrefformStartedStatus :TSubformStartupStatus read getPrefformStartedStatus write setPrefformStartedStatus;
    Procedure ShowTimerMsg(Const Value:String);
    Procedure SetupConnections(aForm :Tform; aConnection :TERPConnection);
  end;

implementation

uses CommonLib, Preferences, LogLib,
  DNMPanel , typinfo, Prefslib, DbSharedObjectsObj,
  CommonDbLib, DBCtrls,WwRadiogroup,DNMSpeedButton,ImageDLLLib,WwDBLook;

{$R *.dfm}

{ TBasePrefsGUI }
procedure TBasePrefsGUI.EditDB(ds:TDataset);
begin
  if ds.active = false then exit;
  if ds.state in [dsEdit,dsinsert] then
  else ds.edit;
end;
procedure TBasePrefsGUI.CheckBoxEdit(const checkbox: TwwCheckbox; const Value: Boolean);
begin
  try
    editdb(checkbox.datasource.dataset);
  Except
  end;
  checkbox.checked := Value;
  try
    editdb(checkbox.datasource.dataset);
    checkbox.datasource.dataset.fieldbyname(checkbox.datafield).asBoolean := Value;
    Postdb(checkbox.datasource.dataset);
  Except
  end;
end;

constructor TBasePrefsGUI.Create(AOwner: TComponent);
begin
try
  comboNewValue := '';
  inherited;
except
  on E:Exception do begin
    if devmode then begin
      MessageDlgXP_Vista(Self.classname +'.create ecxeption :' +E.Message ,mtInformation , [mbok],0);
    end;
  end;
end;

end;

procedure TBasePrefsGUI.DisableForm;
begin
  if (Assigned(Self.Owner)) and (Self.Owner is TfrmBaseGUI) then begin
      TfrmBaseGUI(Self.Owner).DisableForm;
  end else begin
    inherited;
  end;
end;


procedure TBasePrefsGUI.DoOnchangedDataSave(const Changedfield: Tfield;  CleanDs: TMyQuery);
begin
  if  Preferenceform <> nil then
    if Preferenceform  is TPreferencesGUI then
      TPreferencesGUI(Preferenceform).DoOnchangedDataSave(Changedfield,CleanDs);
end;
procedure TBasePrefsGUI.DsBeforePostAuditTrail(const aName: String; aidfieldname,aDescFieldname, aFieldValueName:String; const aQry: TDataSet);
var
  ctr:Integer;
  s1,s2:String;
  fQry:TERPQuery;
begin
  inherited;
  if  Preferenceform <> nil then
    if Preferenceform  is TPreferencesGUI then begin

      fQry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        fQry.sql.text :=TERPQuery(aQry).SQL.text ;
        fQry.open;
        if (fQry.recordcount =0) and (aQry.recordcount =0) then exit;
        if fQry.locate(aidfieldname ,aQry.fieldbyname(aidfieldname).asInteger, []) then begin
          TPreferencesGUI(Preferenceform).CreateAuditTrailEntry(aName+'-' +aQry.fieldbyname(aDescFieldname).asString , fQry.fieldbyname(aFieldValueName).asString,aQry.fieldbyname(aFieldValueName).asString);
        end else begin
          TPreferencesGUI(Preferenceform).CreateAuditTrailEntry(aName+'-' +aQry.fieldbyname(aDescFieldname).asString , '',aQry.fieldbyname(aFieldValueName).asString);
        end;

      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(fQry);
      end;
    end;
end;
procedure TBasePrefsGUI.DsBeforePostAuditTrail(const aQry: TDataSet;  const aPrefType: String);
var
  ctr:Integer;
  s1,s2:String;
begin
  inherited;
  if  Preferenceform <> nil then
    if Preferenceform  is TPreferencesGUI then
      for ctr := 0 to aQry.fieldcount-1 do begin
        try s1:=aQry.fields[ctr].OldValue; Except end;
        try s2:= aQry.fields[ctr].Value; except end;
        if s1 <> s2 then
          TPreferencesGUI(Preferenceform).DoOnchangedDataSave(aPrefType, aQry.fields[ctr].Fieldname, s1,s2);
      end;
end;

procedure TBasePrefsGUI.EnableForm;
begin
  if (Assigned(Self.Owner)) and (Self.Owner is TfrmBaseGUI) then begin
      TfrmBaseGUI(Self.Owner).EnableForm;
  end else begin
    inherited;
  end;
end;

procedure TBasePrefsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbPosting:= False;
  initDsPrefs;
  (*PrefsGUIObj.AssignDblclicks(self);*)
end;
function TBasePrefsGUI.getDoingProcess: boolean;
begin
  Result:= False;
  if  Preferenceform <> nil then
    if Preferenceform  is TPreferencesGUI then
      result := TPreferencesGUI(Preferenceform).DoingProcess;
end;



procedure TBasePrefsGUI.InitDsPrefs;
var
  ctr:Integer;
begin
    for ctr:= 0 to componentcount -1 do begin
      if (components[ctr] is TDataSourcePrefs) then
        TDataSourcePrefs(components[ctr]).OnchangedDataSave := DoOnchangedDataSave;
    end;


end;

function TBasePrefsGUI.IsformClosing: Boolean;
begin
  Result:= False;
  if  Preferenceform <> nil then
    if Preferenceform  is TPreferencesGUI then
      result := TPreferencesGUI(Preferenceform).IsformClosing;
end;
procedure TBasePrefsGUI.PostDB(ds: TDataset);
begin
  if fbPosting then exit;
  fbPosting:= True;
  try
    if ds.active = false then exit;
    if ds.state in [dsEdit,dsinsert] then ds.Post;
  finally
    fbPosting:= False;
  end;
end;

function TBasePrefsGUI.Preferenceform: TComponent;
var
  form :TComponent;
begin
  Result :=nil;
  form := FindExistingComponent('TPreferencesGUI');
  if assigned (form) and (Form is TPreferencesGUI) then
    result := form;
end;

procedure TBasePrefsGUI.SearchForText(const SearchStr, FocusControlName: string;SearchingCaption: Boolean);
begin
  try
    TPreferencesGUI(Preferenceform).SearchForText( SearchStr, FocusControlName,SearchingCaption);
  Except

  end;


end;


procedure TBasePrefsGUI.setDoingProcess(const Value: boolean);
begin
  if  Preferenceform <> nil then
    if Preferenceform  is TPreferencesGUI then
      TPreferencesGUI(Preferenceform).DoingProcess:= Value;
end;


procedure TBasePrefsGUI.setSinglePanelToshow(const Value: String);
var
  ctr:Integer;
begin
  fsSinglePanelToshow := Value;
  if trim(fsSinglePanelToshow) <> '' then begin
    for ctr:= 0 to componentcount -1 do begin
      if (components[ctr] is TDnMPanel) and
      ((TDnMPanel(components[ctr]).parent = Self) or (TDnMPanel(components[ctr]).parent = sbpanels)) then
        TDnMPanel(components[ctr]).visible := sametext(TDnMPanel(components[ctr]).name , Value);
    end;

    {the edi forms are dynamically created with self is the owner of the form
    and panel's prent is sbpanel.  So teh above loop doesn't find those components
    eg: UPS / FEdEx etc in Integeration form}
    for ctr:= 0 to  sbpanels.controlcount-1 do begin
      if (sbpanels.controls[ctr] is TDnMPanel) and
      ((TDnMPanel(sbpanels.controls[ctr]).parent = Self) or (TDnMPanel(sbpanels.controls[ctr]).parent = sbpanels)) then
        TDnMPanel(sbpanels.controls[ctr]).visible := sametext(TDnMPanel(sbpanels.controls[ctr]).name , Value);
    end;
  end;
end;

procedure TBasePrefsGUI.SetupConnections(aForm :Tform; aConnection: TERPConnection);
var
  Index: Integer;
begin
  if Assigned(aForm) then begin
    try
        for Index := 0 to aForm.ComponentCount - 1 do begin
          if aForm.Components[Index] is TERPQuery then begin
            if (TERPQuery(aForm.Components[Index]).Connection <>aConnection) or
              (TERPQuery(aForm.Components[Index]).active =False) then begin
                if TERPQuery(aForm.Components[Index]).active then TERPQuery(aForm.Components[Index]).close;
                TERPQuery(aForm.Components[Index]).Connection := aConnection;
                if trim(TERPQuery(aForm.Components[Index]).SQL.Text) <> '' then
                    TERPQuery(aForm.Components[Index]).Open;
            end;
          end else if aForm.Components[Index] is TForm then
            SetupConnections(TForm(aForm.Components[Index]), aConnection);
        end;
    Except
      on E:Exception do begin
        if devmode then
          Logtext(E.message);
      end;
    end;
  end;
end;

procedure TBasePrefsGUI.ShowHintmsg(Sender, control: TObject);
var
  s:String;
begin
  if Sender <> control then exit;
  s:= GetObjectProperty(Sender, 'Hint');
  s:= replacestr(s , char(VK_TAB) , '');
  if s<> '' then
    if  Preferenceform <> nil then
      TPreferencesGUI(Preferenceform).ShowHintmsg(s);

end;

procedure TBasePrefsGUI.ShowTimerMsg(const Value: String);
begin
    if Preferenceform  is TPreferencesGUI then begin
      TPreferencesGUI(Preferenceform).lblMsg.alignment := taLeftJustify;
      TimerMsg(TPreferencesGUI(Preferenceform).lblMsg, trim(Value), 20, clgreen);
    end;
end;

procedure TBasePrefsGUI.DoPerformStartup(var Msg: TMessage);
begin
  PrefformStartedStatus := sssStarting;
  try
   intPreferencesForm(Msg);
   StartupProcess(Msg);
  finally
    PrefformStartedStatus := sssDone;
  end;
end;

procedure TBasePrefsGUI.intPreferencesForm(Msg: TMessage);
begin
  fPreferencesForm := TForm(FindControl(Msg.WParam));
end;
procedure TBasePrefsGUI.DoPrefformFinish(var Msg: TMessage);
begin
  FinishProcess(Msg);
end;
function TBasePrefsGUI.getPrefformStartedStatus: TSubformStartupStatus;
begin
  if Assigned(fPreferencesForm) then
    if fPreferencesForm is TPreferencesGUI then
      Result := TPreferencesGUI(fPreferencesForm).PrefformStartedStatus ;
end;
procedure TBasePrefsGUI.SetPrefformStartedStatus(Const Value:TSubformStartupStatus);
begin
  if Assigned(fPreferencesForm) then
    if fPreferencesForm is TPreferencesGUI then
      TPreferencesGUI(fPreferencesForm).PrefformStartedStatus := Value;
end;

end.
