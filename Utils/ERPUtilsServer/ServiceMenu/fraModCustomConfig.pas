unit fraModCustomConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraUtilsConfigBase, DNMSpeedButton, StdCtrls, wwclearbuttongroup,
  wwradiogroup, ExtCtrls, JsonObject, UserUtilsClientObj;

type
  TfrModCustomConfig = class(TfrUtilsConfigBase)
    Bevel1: TBevel;
    lblModuleName: TLabel;
    rgLoggingLevel: TwwRadioGroup;
    btnShowLog: TDNMSpeedButton;
    procedure rgLoggingLevelClick(Sender: TObject);
    procedure btnShowLogClick(Sender: TObject);
  private
    procedure DoOnClick(Sender: TObject);
    procedure DoOnExit(Sender: TObject);
    procedure DoOnChange(Sender: TObject);
    procedure DoOnCloseUp(Sender: TObject);
    procedure DoUserControlChange(Sender: TObject);
    procedure ConfigToControls;
  protected
    GuiBuildDone: boolean;
    function GetModuleName: string; override;
    procedure AfterGetModuleConfig; override;
    function BuildGui(json: TJsonObject; aOwner: TComponent; aParent: TWinControl = nil; aControl: TObject = nil): TObject;
    procedure SetUtilsClient(const Value: TUserUtilsClient); override;
  public
    constructor Create(aOwner: TComponent); override;
    { Public declarations }
  end;

//var
//  frModCustomConfig: TfrModCustomConfig;

implementation

uses
  LogMessageTypes, TypInfo, DNMPanel, ComCtrls, Vista_MessageDlg,
  UpdateStoreObj, SystemLib, MyAccess, ServiceMenuLib;

{$R *.dfm}

function ControlParent(control :TControl): string;
begin
  Result :=ServiceMenuLib.ControlParent(Control);
(*  result:= '';
  try
    if control = nil then exit;
    if Assigned(Control.Parent) then result := ControlParent(Control.Parent)+'.'+control.Name else result := control.Name;
  Except
  end;*)
end;

function FindComponentByName(Const RootComponent:TComponent; Const ComponentName: string; SearchSub :Boolean = true; fsControlParent :String = ''): TComponent;
begin
  Result :=ServiceMenuLib.FindComponentByName(RootComponent,ComponentName,SearchSub,fsControlParent);
(*var
  ctr, I: integer;
Begin
  Result := nil;
  if RootComponent.ComponentCount =0 then exit;
  for ctr  := 1 to 2 do begin
  {this lop is specifically for the mainmenu.panel1/panel2 buttons for workflows Play
  As on the mainmenu the parent panel is dynamic and the panel could be different when u play it }
    for I := 0 to RootComponent.ComponentCount - 1 do begin
      if Sysutils.SameText(RootComponent.Components[I].Name,ComponentName) then

        if fsControlParent='' then begin
          Result := RootComponent.Components[I];
          Exit;
        end else if not (RootComponent.Components[I] is TControl) then begin
          Result := RootComponent.Components[I];
          Exit;
        end else if sametext(fsControlParent , ControlParent(TControl(RootComponent.Components[I])))  then begin
          Result := RootComponent.Components[I];
          Exit;
        end;
    end;
    if fsControlParent = '' then break;
         if pos(uppercase('MainSwitch2.sbButtons.pnlButtons2'), uppercase(fsControlParent)) =1 then fsControlParent := StringReplace(fsControlParent ,'MainSwitch2.sbButtons.pnlButtons2', 'MainSwitch2.sbButtons.pnlButtons1', [rfIgnoreCase] )
    else if pos(uppercase('MainSwitch2.sbButtons.pnlButtons1'), uppercase(fsControlParent)) =1 then fsControlParent := StringReplace(fsControlParent ,'MainSwitch2.sbButtons.pnlButtons1', 'MainSwitch2.sbButtons.pnlButtons2', [rfIgnoreCase] )
    else break;
  end;

  if not(SearchSub) then exit;

  if RootComponent.ComponentCount >0 then
    for I := 0 to RootComponent.ComponentCount - 1 do begin
      //logtext(RootComponent.Name+'['+inttostr(i)+']='+RootComponent.Components[I].name +'.componentcount='+inttostr(RootComponent.Components[I].ComponentCount));
      if RootComponent.Components[I].ComponentCount >0 then begin
        Result:= FindComponentbyName(RootComponent.Components[I],ComponentName, SearchSub,fsControlParent);
        if (result = nil) and (fsControlParent <> '') then
          Result:= FindComponentbyName(RootComponent.Components[I],ComponentName, SearchSub, '');
        if Assigned(Result) then exit;
      end;
    end;*)
end;


{ TfrModCustomConfig }

procedure TfrModCustomConfig.AfterGetModuleConfig;
var
  JsonResult: TJsonObject;

begin
  inherited;
  rgLoggingLevel.ItemIndex := Ord(StrToLoggingLevel(Config.S['LoggingLevel']));
  lblModuleName.Caption := ModuleName;
  JsonResult:= UtilsClient.Client.SendRequest(self.ModuleName  + '.getgui', nil);
  if Assigned(JsonResult) then begin
    try
      //ShowMessage(JsonResult.O['result'].AsString);
      BuildGui(JsonResult.O['result'],self,self,self);
      ConfigToControls;
    finally
      JsonResult.Free;
    end;
  end;
//  edtClientServerName.Text := Config.S['ClientServerName'];
//  chkActive.Checked := Config.B['Active'];
end;

procedure TfrModCustomConfig.btnShowLogClick(Sender: TObject);
var
  cls: TPersistentClass;
  logForm: TForm;
  PropInfo: PPropInfo;
type
  TFormClass = class of TForm;
begin
  inherited;
  if Assigned(fOnShowLog) and Assigned(UtilsClient) then begin
    fOnShowLog(self,GetModuleName,UtilsClient.Client.ServerName);
  end
  else begin
//    fOnShowLog(self,GetModuleName,UtilsClient.Client.ServerName);
    cls := Classes.FindClass('TfmServerLogList');
    if Assigned(cls) then begin
      logForm := TFormClass(cls).Create(Application);
      PropInfo := GetPropInfo(logForm, 'ModuleName');
      if Assigned(PropInfo) then begin
        SetPropValue(logForm, 'ModuleName', ModuleName);


      end;
      if Application.MainForm.FormStyle = fsMDIForm then begin
        logForm.FormStyle := fsMDIChild;
        logForm.BringToFront;
      end
      else
        logForm.Show;

    end;
  end;
end;

function TfrModCustomConfig.BuildGui(json: TJsonObject; aOwner: TComponent;
  aParent: TWinControl; aControl: TObject): TObject;
var
  x: integer;
  //obj: TObject;
  ctl: TObject;

  procedure ApplyFontStyles(aFont: TFont; aStyles: TJsonArray);
  var i: integer;
  begin
    aFont.Style := [];
    for i := 0 to aStyles.Count-1 do begin
      if SameText(aStyles[i].AsString, 'fsBold') then
        aFont.Style := aFont.Style + [fsbold]
      else if SameText(aStyles[i].AsString, 'fsItalic') then
        aFont.Style := aFont.Style + [fsItalic]
      else if SameText(aStyles[i].AsString, 'fsUnderline') then
        aFont.Style := aFont.Style + [fsUnderline]
      else if SameText(aStyles[i].AsString, 'fsStrikeOut') then
        aFont.Style := aFont.Style + [fsStrikeOut];
    end;
  end;

  function StrToPanelBevel(BevelStr: string): TPanelBevel;
  begin
    if SameText(BevelStr, 'bvNone') then result := bvNone
    else if SameText(BevelStr, 'bvLowered') then result := bvLowered
    else if SameText(BevelStr, 'bvRaised') then result := bvRaised
    else if SameText(BevelStr, 'bvSpace') then result := bvSpace
    else result := bvNone;
  end;

  function StrToBevelKind(KindStr: string): TBevelKind;
  begin
    if SameText(KindStr, 'bkNone') then result := bkNone
    else if SameText(KindStr, 'bkTile') then result := bkTile
    else if SameText(KindStr, 'bkSoft') then result := bkSoft
    else if SameText(KindStr, 'bkFlat') then result := bkFlat
    else result := bkNone;
  end;

  function StrToComboStyle(s: string): TComboBoxStyle;
  begin
    result := csDropDown;
    if SameText(s, 'csDropDown') then result := csDropDown
    else if SameText(s, 'csSimple') then result := csSimple
    else if SameText(s, 'csDropDownList') then result := csDropDownList
    else if SameText(s, 'csOwnerDrawFixed') then result := csOwnerDrawFixed
    else if SameText(s, 'csOwnerDrawVariable') then result := csOwnerDrawVariable
  end;

begin
  if GuiBuildDone then exit;

  ctl:= nil;
  //result := nil;
  if Assigned(aControl) then
    ctl := AControl
  else begin
    if SameText(json.S['ClassName'], 'TPanel') then begin
      ctl:= TPanel.Create(aOwner);
      if assigned(aParent) then TPanel(ctl).Parent := aParent;
      if json.Exists('Color') then begin
        TPanel(ctl).ParentColor := false;
        TPanel(ctl).Color := json.I['Color'];
      end
      else begin
        TPanel(ctl).ParentColor := true; // Color := self.Color;
      end;
      if json.Exists('BevelInner') then TPanel(ctl).BevelInner := StrToPanelBevel(json.S['BevelInner']);
      if json.Exists('BevelOuter') then TPanel(ctl).BevelOuter := StrToPanelBevel(json.S['BevelOuter']);
      if json.Exists('BevelKind') then TPanel(ctl).BevelKind := StrToBevelKind(json.S['BevelKind']);
    end
    else if SameText(json.S['ClassName'], 'TDNMPanel') then begin
      ctl:= TDNMPanel.Create(aOwner);
      if assigned(aParent) then TDNMPanel(ctl).Parent := aParent;
      if json.Exists('Color') then begin
        TDNMPanel(ctl).ParentColor := false;
        TDNMPanel(ctl).Color := json.I['Color'];
      end
      else begin
        TDNMPanel(ctl).ParentColor := true;
      end;
      if json.Exists('BevelInner') then TPanel(ctl).BevelInner := StrToPanelBevel(json.S['BevelInner']);
      if json.Exists('BevelOuter') then TPanel(ctl).BevelOuter := StrToPanelBevel(json.S['BevelOuter']);
      if json.Exists('BevelKind') then TPanel(ctl).BevelKind := StrToBevelKind(json.S['BevelKind']);
    end
    else if SameText(json.S['ClassName'], 'TButton') then begin
      ctl:= TButton.Create(aOwner);
      if assigned(aParent) then TButton(ctl).Parent := aParent;
      TButton(ctl).OnClick := DoOnClick;
      if json.Exists('Caption') then TButton(ctl).Caption := json.S['Caption'];
    end
    else if SameText(json.S['ClassName'], 'TDNMSpeedButton') then begin
      ctl:= TDNMSpeedButton.Create(aOwner);
      if assigned(aParent) then TDNMSpeedButton(ctl).Parent := aParent;
      TDNMSpeedButton(ctl).OnClick := DoOnClick;
      if json.Exists('Caption') then TDNMSpeedButton(ctl).Caption := json.S['Caption'];
      if json.Exists('Style') then begin
        if SameText(Json.S['Style'], 'bsNormal') then TDNMSpeedButton(ctl).Style := DNMSpeedButton.bsNormal
        else if SameText(Json.S['Style'], 'bsEncarta') then TDNMSpeedButton(ctl).Style := DNMSpeedButton.bsEncarta
        else if SameText(Json.S['Style'], 'bsModern') then TDNMSpeedButton(ctl).Style := DNMSpeedButton.bsModern
        else if SameText(Json.S['Style'], 'bsOld') then TDNMSpeedButton(ctl).Style := DNMSpeedButton.bsOld
        else if SameText(Json.S['Style'], 'bsQuicken') then TDNMSpeedButton(ctl).Style := DNMSpeedButton.bsQuicken
        else if SameText(Json.S['Style'], 'bsShape') then TDNMSpeedButton(ctl).Style := DNMSpeedButton.bsShape;
      end;
    end
    else if SameText(json.S['ClassName'], 'TLabel') then begin
      ctl:= TLabel.Create(aOwner);
      if json.Exists('WordWrap') then
        TLabel(ctl).WordWrap := json.B['WordWrap'];
      if json.Exists('Width') then TLabel(ctl).AutoSize := false;
      if assigned(aParent) then TLabel(ctl).Parent := aParent;
      if json.Exists('Caption') then TLabel(ctl).Caption := json.S['Caption'];
      if json.Exists('Font.Color') then TLabel(ctl).Font.Color := json.I['Font.Color'];
      if json.Exists('Font.Style') then ApplyFontStyles(TLabel(ctl).Font, Json.A['Font.Style']);
    end
    else if SameText(json.S['ClassName'], 'TBevel') then begin
      ctl:= TBevel.Create(aOwner);
      if assigned(aParent) then TBevel(ctl).Parent := aParent;
      TBevel(ctl).Shape := bsFrame;
      TBevel(ctl).Anchors := [akLeft,akTop,akRight,akBottom];
    end
    else if SameText(json.S['ClassName'], 'TLoggingLevel') then begin
      ctl := TRadioGroup.Create(aOwner);
      if assigned(aParent) then TRadioGroup(ctl).Parent := aParent;
      TRadioGroup(ctl).Name := 'rgLoggingLevel';
      TRadioGroup(ctl).Caption := ' Logging Level ';
      TRadioGroup(ctl).Columns := 4;
      TRadioGroup(ctl).Items.CommaText := 'Error,Warning,Info,Detail';
    end
    else if SameText(json.S['ClassName'], 'TEdit') then begin
      ctl:= TEdit.Create(aOwner);
      if assigned(aParent) then TEdit(ctl).Parent := aParent;
      TEdit(ctl).OnExit := DoOnExit;
      if json.Exists('PasswordChar') then
        TEdit(ctl).PasswordChar := json.S['PasswordChar'][1];
    end
    else if SameText(json.S['ClassName'], 'TComboBox') then begin
      ctl:= TComboBox.Create(aOwner);
      if Assigned(aParent) then TComboBox(ctl).Parent := aParent;
      TComboBox(ctl).Style := StrToComboStyle(json.S['Style']);
      TComboBox(ctl).OnChange := DoOnChange;
      TComboBox(ctl).OnCloseUp := DoOnCloseup;
      TComboBox(ctl).OnExit := DoOnExit;
      if json.Exists('Items') then TComboBox(ctl).Items.CommaText := json.S['Items'];
    end
    else if SameText(json.S['ClassName'], 'TMemo') then begin
      ctl:= TMemo.Create(aOwner);
      if Assigned(aParent) then TMemo(ctl).Parent := aParent;
      TMemo(ctl).ScrollBars := ssBoth;
      TMemo(ctl).OnExit := DoOnExit;
    end
    else if SameText(json.S['ClassName'], 'TCheckBox') then begin
      ctl:= TCheckBox.Create(aOwner);
      if Assigned(aParent) then TCheckBox(ctl).Parent := aParent;
      TCheckBox(ctl).Caption := '';
      TCheckBox(ctl).Width := TCheckBox(ctl).Height;
      TCheckBox(ctl).OnClick := DoOnClick;
    end
    else if SameText(json.S['ClassName'], 'TDateTimePicker') then begin
      ctl:= TDateTimePicker.Create(aOwner);
      if Assigned(aParent) then TDateTimePicker(ctl).Parent := aParent;
      if json.Exists('Kind') then begin
        if SameText(json.S['Kind'],'dtkDate') then TDateTimePicker(ctl).Kind := dtkDate
        else if SameText(json.S['Kind'],'dtkTime') then TDateTimePicker(ctl).Kind := dtkTime
      end;
      TDateTimePicker(ctl).OnChange := DoOnChange;
    end;
  end;

  if Assigned(ctl) then begin
    if ctl is TControl then begin
      if json.Exists('Left') then TControl(ctl).Left := json.I['Left'];
      if json.Exists('Top') then TControl(ctl).Top := json.I['Top'];
      if json.Exists('Width') then TControl(ctl).Width := json.I['Width'];
      if json.Exists('Height') then TControl(ctl).Height := json.I['Height'];
      if json.Exists('Hint') then TControl(ctl).Hint :=
        json.S['Hint'];
    end;
    if ctl is TComponent then begin
      if json.Exists('Name') and (json.S['Name'] <> '') then begin
        TComponent(ctl).Name := json.S['Name'];
        if ctl is TCheckBox then
          TCheckBox(ctl).Caption := '';
      end;
    end;

    for x := 0 to json.A['Children'].Count -1 do begin
      if ctl is TWinControl then begin
        (*obj := *)BuildGui(json.A['Children'].Items[x].AsObject, TComponent(ctl), TWinControl(ctl));
      end
      else begin
        (*obj := *)BuildGui(json.A['Children'].Items[x].AsObject, nil);
      end;

    end;
  end;
  result := ctl;
//  GuiBuildDone := true;
end;

procedure TfrModCustomConfig.ConfigToControls;
var
  x: integer;
  pair: TJsonValuePair;
  comp: TComponent;
begin
  for x := 0 to Config.Count -1 do begin
    pair := Config.Items[x];
    comp := FindComponentByName(self,pair.Name);
    if Assigned(comp) then begin
      if comp is TEdit then begin
        TEdit(comp).Text := pair.Value.AsString;
      end
      else if comp is TComboBox then begin
        TComboBox(comp).Text := pair.Value.AsString;
        TComboBox(comp).ItemIndex := TComboBox(comp).Items.IndexOf(pair.Value.AsString);
      end
      else if comp is TMemo then begin
        TMemo(comp).Lines.CommaText := pair.Value.AsString;
      end
      else if comp is TCheckBox then begin
        if SameText(TCheckBox(comp).Name, 'Active') then begin
          TCheckBox(comp).Caption := '';
          TCheckBox(comp).Width := TCheckBox(comp).Height;
        end;
        TCheckBox(comp).Checked := pair.Value.AsBoolean;
      end
      else if comp is TDateTimePicker then begin
        TDateTimePicker(comp).DateTime := pair.Value.AsDateTime;
      end;
    end;
  end;
end;

constructor TfrModCustomConfig.Create(aOwner: TComponent);
begin
  inherited;
  ValidateConfig := false;
end;

procedure TfrModCustomConfig.DoOnClick(Sender: TObject);
begin
  DoUserControlChange(Sender);
end;

procedure TfrModCustomConfig.DoOnChange(Sender: TObject);
begin
  DoUserControlChange(Sender);
end;

procedure TfrModCustomConfig.DoOnCloseUp(Sender: TObject);
begin
  DoUserControlChange(Sender);
end;

procedure TfrModCustomConfig.DoOnExit(Sender: TObject);
begin
  DoUserControlChange(Sender);
end;

procedure TfrModCustomConfig.DoUserControlChange(Sender: TObject);
var
  JsonResult, O: TJsonObject;
  MsgDlgType: TMsgDlgType;
  MsgDlgButtons: Dialogs.TMsgDlgButtons;
  x: integer;
  Params: TJsonObject;
  Path: string;
  CustomConfigName: string;
  UpdateStore: TUpdateStore;
  msg: string;
  obj: TObject;

  procedure DoShowDialog;
  var I: integer;
  begin
    MsgDlgType := mtInformation;
    if SameText(JsonResult.O['Dialog'].S['Type'], 'mtWarning') then MsgDlgType := mtWarning
    else if SameText(JsonResult.O['Dialog'].S['Type'], 'mtError') then MsgDlgType := mtError
    else if SameText(JsonResult.O['Dialog'].S['Type'], 'mtInformation') then MsgDlgType := mtInformation
    else if SameText(JsonResult.O['Dialog'].S['Type'], 'mtConfirmation') then MsgDlgType := mtConfirmation
    else if SameText(JsonResult.O['Dialog'].S['Type'], 'mtCustom') then MsgDlgType := mtCustom;
    MsgDlgButtons := [];
    for I := 0 to JsonResult.O['Dialog'].A['Buttons'].Count -1 do begin
      if SameText(JsonResult.O['Dialog'].A['Buttons'].Items[I].AsString, 'mbYes') then MsgDlgButtons := MsgDlgButtons + [mbYes]
      else if SameText(JsonResult.O['Dialog'].A['Buttons'].Items[x].AsString, 'mbNo') then MsgDlgButtons := MsgDlgButtons + [mbNo]
      else if SameText(JsonResult.O['Dialog'].A['Buttons'].Items[x].AsString, 'mbOK') then MsgDlgButtons := MsgDlgButtons + [mbOk]
      else if SameText(JsonResult.O['Dialog'].A['Buttons'].Items[x].AsString, 'mbCancel') then MsgDlgButtons := MsgDlgButtons + [mbCancel]
      else if SameText(JsonResult.O['Dialog'].A['Buttons'].Items[x].AsString, 'mbAbort') then MsgDlgButtons := MsgDlgButtons + [mbAbort]
      else if SameText(JsonResult.O['Dialog'].A['Buttons'].Items[x].AsString, 'mbRetry') then MsgDlgButtons := MsgDlgButtons + [mbRetry]
      else if SameText(JsonResult.O['Dialog'].A['Buttons'].Items[x].AsString, 'mbIgnore') then MsgDlgButtons := MsgDlgButtons + [mbIgnore]
      else if SameText(JsonResult.O['Dialog'].A['Buttons'].Items[x].AsString, 'mbAll') then MsgDlgButtons := MsgDlgButtons + [mbAll]
      else if SameText(JsonResult.O['Dialog'].A['Buttons'].Items[x].AsString, 'mbNoToAll') then MsgDlgButtons := MsgDlgButtons + [mbNoToAll]
      else if SameText(JsonResult.O['Dialog'].A['Buttons'].Items[x].AsString, 'mbYesToAll') then MsgDlgButtons := MsgDlgButtons + [mbYesToAll]
      else if SameText(JsonResult.O['Dialog'].A['Buttons'].Items[x].AsString, 'mbClose') then MsgDlgButtons := MsgDlgButtons + [mbClose];
    end;
    if MsgDlgButtons = [] then MsgDlgButtons := [mbOk];
    Vista_MessageDlg.MessageDlgXP_Vista(JsonResult.O['Dialog'].S['Message'],MsgDlgType,MsgDlgButtons,0);
  end;

begin
  if Loading then exit;
  if (Sender is TComponent) and (not ((Sender is TDNMSpeedButton) or (Sender is TButton))) then begin
    if TComponent(Sender).Name = '' then exit;
    if not Config.Exists(TComponent(Sender).Name) then exit;
  end;
  if Sender is TEdit then begin
    if Config.S[TEdit(Sender).Name] <> TEdit(Sender).Text then begin
      Config.S[TEdit(Sender).Name] := TEdit(Sender).Text;
      if not VerifyAndSetModuleConfig then
        TEdit(Sender).Text := Config.S[TEdit(Sender).Name];
    end;
  end
  else if Sender is TComboBox then begin
    if Config.S[TComboBox(Sender).Name] <> TComboBox(Sender).Text then begin
      Config.S[TComboBox(Sender).Name] := TComboBox(Sender).Text;
      if not VerifyAndSetModuleConfig then begin
        TComboBox(Sender).Text := Config.S[TComboBox(Sender).Name];
        TComboBox(Sender).ItemIndex := TComboBox(Sender).Items.IndexOf(Config.S[TComboBox(Sender).Name]);
      end;
    end;
  end
  else if Sender is TMemo then begin
    if Config.S[TMemo(Sender).Name] <> TMemo(Sender).Lines.CommaText then begin
      Config.S[TMemo(Sender).Name] := TMemo(Sender).Lines.CommaText;
      if not VerifyAndSetModuleConfig then
        TMemo(Sender).Lines.CommaText := Config.S[TMemo(Sender).Name];
    end;
  end
  else if Sender is TCheckBox then begin
    if Config.B[TCheckBox(Sender).Name] <> TCheckBox(Sender).Checked then begin
      Config.B[TCheckBox(Sender).Name] := TCheckBox(Sender).Checked;
      if not VerifyAndSetModuleConfig then
        TCheckBox(Sender).Checked := Config.B[TCheckBox(Sender).Name]
      else begin
        O := JO;
        O.S['Name'] := TCheckBox(Sender).Name;
        JsonResult:= UtilsClient.Client.SendRequest(self.ModuleName  + '.Click', O);
        if Assigned(JsonResult) then begin
          try
            if JsonResult.Exists('Dialog') then begin
              DoShowDialog;
              TCheckBox(Sender).Checked := false;
            end
          finally
            JsonResult.Free;
          end;
        end;
      end;
    end;
  end
  else if Sender is TDNMSpeedButton then begin
    if TDNMSpeedButton(Sender).Name <> '' then begin
      O := JO;
      O.S['Name'] := TDNMSpeedButton(Sender).Name;
      JsonResult:= UtilsClient.Client.SendRequest(self.ModuleName  + '.Click', O);
      if Assigned(JsonResult) then begin
        try
          if JsonResult.Exists('Dialog') then begin
            DoShowDialog;
          end
          else if JsonResult.Exists('CustomConfig') then begin
            Params := JO;
            UpdateStore := TUpdateStore.Create;
            try
              CustomConfigName := JsonResult.O['CustomConfig'].S['CustomConfigName'];
              path := ExtractFilePath(Application.ExeName);
              if Parent is TDNMPanel then begin
                { we are running in ERP }
                Params.I['color'] := TDNMPanel(Parent).Color;
                Params.O['Position'].I['left'] := TDNMPanel(Parent).Left;
                Params.O['Position'].I['top'] := TDNMPanel(Parent).top;
                obj := nil;
                if Assigned(Owner) then begin
                  try
                    obj := TypInfo.GetObjectProp(Owner,'Connection');
                  except
                  end;
                end;
                if Assigned(obj) and (obj is TMyConnection) then
                  Params.S['ERPDatabase'] := TMyConnection(obj).Database;
              end
              else begin
                Params.I['color'] := Application.MainForm.Color;
                Params.O['Position'].I['left'] := Application.MainForm.Left;
                Params.O['Position'].I['top'] := Application.MainForm.top;
                Params.S['ERPDatabase'] := '';
              end;
              Params.O['Config'].Assign(self.Config);
              Params.S['ERPUtilsServer'] := self.UtilsClient.Client.ServerName;
              Params.SaveToFile(path + ChangeFileExt(CustomConfigName,'_Params.txt'));
              UpdateStore.UpdateIfNeeded(path + CustomConfigName);

              if ExecNewWinProcess(path +CustomConfigName, true, msg) then begin
                { read back results when user has closed config form }
                Params.LoadFromFile(Path + ChangeFileExt(CustomConfigName,'_Params.txt'));
                if Params.I['ModalResult'] = mrOk then begin

                  Config.Assign(Params.O['Config']);
                  self.VerifyAndSetModuleConfig;

                end;
              end
              else begin
                Vista_MessageDlg.MessageDlgXP_Vista('Unable to open configuration settings',mtInformation,[mbOk],0);
              end;



            finally
              Params.Free;
              UpdateStore.Free;
            end;
          end;
        finally
          JsonResult.Free;
        end;
      end;
    end;
  end;
  if Sender is TDateTimePicker then begin
    if Config.DT[TDateTimePicker(Sender).Name] <> TDateTimePicker(Sender).DateTime then begin
      Config.DT[TDateTimePicker(Sender).Name] := TDateTimePicker(Sender).DateTime;
      if not VerifyAndSetModuleConfig then
        TDateTimePicker(Sender).DateTime := Config.DT[TDateTimePicker(Sender).Name];
    end;
  end
end;

function TfrModCustomConfig.GetModuleName: string;
begin
  result := SeverModuleInfo.S['ModuleName'];
end;

procedure TfrModCustomConfig.rgLoggingLevelClick(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  Config.S['LoggingLevel'] := LoggingLevelToStr(TLoggingLevel(rgLoggingLevel.ItemIndex));
  VerifyAndSetModuleConfig;
end;

procedure TfrModCustomConfig.SetUtilsClient(const Value: TUserUtilsClient);
begin
  inherited;
  GuiBuildDone := true;
end;

end.
