unit frmStSInputBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMPanel , BaseFormForm, Shader, DNMSpeedButton,BusObjBase, BaseInputForm, BusObjSeedToSale, frmERPRunningHelp,
  wwdbdatetimepicker;

type
  TfmStSInputBase = class(TBaseInputGUI)
    pnlDetails: TDNMPanel;
    pnlFooter: TDNMPanel;
    pnlHeader: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fMyDAcDataconnection: TMyDAcDataconnection;
    helpButtonmsgs:TStringList;
    helpButtons:TStringList;
    fstitle: String;
    fBusobj: Tbusobj;
    procedure SetMyDAcDataconnection(const Value: TMyDAcDataconnection);
    function GETStSTagObj: TStSTags;
    Procedure InitwithinStsMain;
    procedure ERPRunningHelpformOnClose(Sender: TObject(*;var Action: TCloseAction*));
    procedure helpButtonclick(Sender: TObject);
    procedure settitle(const Value: String);
    procedure DBlclicktoRemovetime(Sender: TObject);
    procedure OnKeyDowntoRemovetime(Sender: TObject; var Key: Word;Shift: TShiftState);

  Protected
    //fStSTag: String;
    fitSTagID:Integer;
    fStSTagObj : TStSTags;
    fERPRunningHelpform :TfmERPRunningHelp;
    AdjustHeightRelativetoMain :Boolean;
    procedure BeginNestedTransaction;
    procedure CommitNestedTransaction;
    procedure RollbackNestedTransaction;
    Function StSMainform :Tform;
    procedure SetStSTagObj(const Value: TStSTags);Virtual;
    procedure showERPRunningHelp(const Value: String; Helpcontrol :TWincontrol=nil);
    Function MakehelpButton(ParentPanel:TDnMPanel; Helpmsg:String; helpBtnPos: String='rt'; aLeft:Integer =0; atop:Integer=0):TDNMSpeedButton;
  public
    Property MyDAcDataconnection : TMyDAcDataconnection read fMyDAcDataconnection write SetMyDAcDataconnection;

    constructor Create(Aowner:TComponent;aMyDAcDataconnection : TMyDAcDataconnection);Overload;Virtual;
    constructor Create(Aowner:TComponent;aMyDAcDataconnection : TMyDAcDataconnection;aStsTagID:Integer(*aStSTag:String*));Overload;Virtual;
    constructor Create(Aowner:TComponent;aMyDAcDataconnection : TMyDAcDataconnection;aStSTagObj:TStSTags);Overload;Virtual;
    constructor Create(Aowner:TComponent;aMyDAcDataconnection : TMyDAcDataconnection;aBusobj: Tbusobj);Overload;Virtual;

    //Property StSTag: String read fStSTag write fStSTag;
    Property StSTagID: Integer read fitSTagID write fitSTagID;
    Property StSTagObj : TStSTags read GETStSTagObj write SetStSTagObj;
    property Busobj: Tbusobj read fBusobj;
    Property title :String read fstitle write settitle;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); override;

  end;

implementation

uses CommonDbLib , LogLib, MAIN, FixedAssetsServiceLogList, frmStSMain,
  CommonLib, dateutils, sndkey32;



{$R *.dfm}

procedure TfmStSInputBase.BeginNestedTransaction    ;begin if AccessManager.accesslevel >=5 then Exit;if assigned(Owner) then if Owner is TfmStSMain then TfmStSMain(Owner).BeginNestedTransaction   ; end;
procedure TfmStSInputBase.CommitNestedTransaction   ;begin if AccessManager.accesslevel >=5 then Exit;if assigned(Owner) then if Owner is TfmStSMain then TfmStSMain(Owner).CommitNestedTransaction  ; end;
procedure TfmStSInputBase.RollbackNestedTransaction ;begin if AccessManager.accesslevel >=5 then Exit;if assigned(Owner) then if Owner is TfmStSMain then TfmStSMain(Owner).RollbackNestedTransaction; end;

constructor TfmStSInputBase.Create(Aowner: TComponent;  aMyDAcDataconnection: TMyDAcDataconnection; aStsTagID:Integer(*aStSTag: String*));
begin
  Create(Aowner, aMyDAcDataconnection);
  //StSTag := aStSTag;
  StSTagID := aStSTagID;
  (*TitleLabel.Caption := aStSTag;
  Self.Caption := 'Tag : ' +aStSTag;*)
end;

constructor TfmStSInputBase.Create(Aowner: TComponent;  aMyDAcDataconnection: TMyDAcDataconnection; aStSTagObj: TStSTags);
begin
  Create(Aowner, aMyDAcDataconnection);
  StSTagObj := aStSTagObj;
  (*TitleLabel.Caption := StSTagObj.StSTag+' ('+;
  Self.Caption := 'Tag : ' +StSTagObj.StSTag;*)
  Self.Title := StSTagObj.StSTag+' ('+ StSTagObj.PhaseDescription+')';
end;

constructor TfmStSInputBase.Create(Aowner: TComponent; aMyDAcDataconnection: TMyDAcDataconnection; aBusobj: Tbusobj);
begin
  Create(Aowner, aMyDAcDataconnection);
  fBusobj := aBusobj;
end;

procedure TfmStSInputBase.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  try
      if StSMainform = nil then exit;
      TfmStSMain(StSMainform).DoBusinessObjectEvent(Sender,EventType, Value);
  Except end;
end;

procedure TfmStSInputBase.SetMyDAcDataconnection(  const Value: TMyDAcDataconnection);
begin
  fMyDAcDataconnection := Value;
  ftransconnection := TERPConnection(fMyDAcDataconnection.connection);
end;

function TfmStSInputBase.StSMainform: Tform;
begin
  Result := nil;
  if assigned(Owner) then
    if owner is TfmStSMain then
      REsult := TfmStSMain(Owner);
end;

constructor TfmStSInputBase.Create(Aowner: TComponent;  aMyDAcDataconnection: TMyDAcDataconnection);
begin
  inherited Create(Aowner);
  MyDAcDataconnection := aMyDAcDataconnection;
end;

procedure TfmStSInputBase.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  AdjustHeightRelativetoMain := False;
  helpButtonmsgs:=TStringList.create;
  helpButtons:=TStringList.create;
  fERPRunningHelpform :=nil;
  //if fMyDAcDataconnection <> nil then
      for ctr := 0 to componentcount-1 do begin
        if components[ctr] is TERPQuery then
          try
            closedb(TERPQuery(components[ctr]));
            TERPQuery(components[ctr]).Connection :=fMyDAcDataconnection.Connection;
          Except end;
        if components[ctr] is TwwDBDateTimePicker then begin
          if not Assigned(TwwDBDateTimePicker(components[ctr]).onDblclick) then
            TwwDBDateTimePicker(components[ctr]).onDblclick := DBlclicktoRemovetime;
          if not Assigned(TwwDBDateTimePicker(components[ctr]).OnKeyDown) then
            TwwDBDateTimePicker(components[ctr]).OnKeyDown := OnKeyDowntoRemovetime;
        end;
      end;
end;
procedure TfmStSInputBase.OnKeyDowntoRemovetime(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F7) then begin
      DBlclicktoRemovetime(Sender);
  end;
end;

procedure TfmStSInputBase.DBlclicktoRemovetime(Sender:TObject);
var
  dt:TDatetime;
begin
  if sender is  TwwDBDateTimePicker then
    if dateof(TwwDBDateTimePicker(Sender).datetime)<> TwwDBDateTimePicker(Sender).datetime then begin
      dt:=Dateof(TwwDBDateTimePicker(Sender).datetime);
      TwwDBDateTimePicker(Sender).datetime := dt;
      try
          if (TwwDBDateTimePicker(Sender).Datasource <> nil) and (TwwDBDateTimePicker(Sender).datafield<>'') and
              (TwwDBDateTimePicker(Sender).Datasource.dataset.findfield(TwwDBDateTimePicker(Sender).datafield)<> nil) then begin
            EditDB(TwwDBDateTimePicker(Sender).Datasource.dataset);
            TwwDBDateTimePicker(Sender).Datasource.dataset.findfield(TwwDBDateTimePicker(Sender).datafield).asdatetime :=dt;
            PostDB(TwwDBDateTimePicker(Sender).Datasource.dataset);
            EditDB(TwwDBDateTimePicker(Sender).Datasource.dataset);
            Application.processmessages;
          end;
      Except
        // kill th exception
      end;
      TwwDBDateTimePicker(Sender).datetime := dt;
      Application.processmessages;
      SendKeys('{TAB}',True);
      Application.processmessages;
    end;
end;

procedure TfmStSInputBase.FormDestroy(Sender: TObject);
begin
  Freeandnil(helpButtonmsgs);
  Freeandnil(helpButtons);
  if assigned(fStSTagObj) and (Assigned(fStSTagObj.owner)) and (fStSTagObj.Owner = self) then
    Freeandnil(fStSTagObj);
  inherited;
end;

procedure TfmStSInputBase.FormShow(Sender: TObject);
begin
  inherited;
  InitwithinStsMain;
  BeginNestedTransaction;
end;

function TfmStSInputBase.GETStSTagObj: TStSTags;
begin
(*  if (fStSTagObj =nil) and (StSTagID=0) then
    if devmode then
      MessageDlgXP_Vista('tag object not found', mtWarning, [mbOK], 0);*)
  if fStSTagObj =nil then begin
    if (*(stsTag='')*)(StSTagID=0) and (KeyID<>0) then
      //stsTag :=  TStSTags.IDtoggle(KeyID);
      StSTagID := KeyId;
    fStSTagObj := TStSTags.StSTagrec(self, (*stsTag*)StSTagID, MyDAcDataconnection, DoBusinessObjectEvent);
  end;
  RESULT := fStSTagObj;
end;

procedure TfmStSInputBase.InitwithinStsMain;
begin
  if AdjustHeightRelativetoMain then begin
    if StSMainform<>nil then begin
      height := StSMainform.height - TfmStSMain(StSMainform).pnlTitle.height -    TfmStSMain(StSMainform).pnlFooter.height-10;
      top  := StSMainform.top + TfmStSMain(StSMainform).pnlTitle.height +5;
    end;
  end;
end;

procedure TfmStSInputBase.SetStSTagObj(const Value: TStSTags);
begin
  fStSTagObj := Value;
  //fStSTag:=Value.StSTag;
  fitSTagID := Value.id;
end;
Procedure TfmStSInputBase.ERPRunningHelpformOnClose(Sender: TObject(*;var Action: TCloseAction*));
begin
  fERPRunningHelpform.close;
  Freeandnil(fERPRunningHelpform);
  HideHighlightExtraControl1;
end;
procedure TfmStSInputBase.settitle(const Value: String);
begin
  fstitle := Value;
  TitleLabel.Caption := Value;
  Self.Caption := Value;
end;

Procedure TfmStSInputBase.showERPRunningHelp(const Value: String; Helpcontrol :TWincontrol=nil);
begin
  if Value = '' then exit;
  HideHighlightExtraControl1;
  if fERPRunningHelpform <> nil then
    fERPRunningHelpform.ShowERPRunningHelp(Value)
  else begin
    fERPRunningHelpform := TfmERPRunningHelp.ShowERPRunningHelp({msg}   Value,
                                           {Owner} Self(*,
                                           {Width} Mainform.width -(Self.left +Self.width+30) ,
                                           {height}self.top + pnlHeader.height ,
                                           {left}  Self.left+ Self.width+10*));
    fERPRunningHelpform.btnClose.onclick := ERPRunningHelpformOnClose;
  end;
  if Helpcontrol <> nil then HighlightextraControl1(fERPRunningHelpform);
end;
Function TfmStSInputBase.MakehelpButton(ParentPanel:TDnMPanel; Helpmsg:String; helpBtnPos: String='rt'; aLeft:Integer =0; atop:Integer=0):TDNMSpeedButton;
function VertMargin:Integer;
begin
  Result := ParentPanel.height -30;
  if Result <0 then Result := 0;
end;
begin
  Result := TDNMSpeedButton.create(Self);
  Result.name := MakeName(self, 'btn-'+ inttostr(helpButtonmsgs.count+1));
  Result.Parent :=  ParentPanel;
  Result.visible := True;
  Result.AlignWithMargins := True;
  Result.Width := 20;
  Result.Cursor := crHandPoint;
  Result.Caption := '?';
  Result.Font.Charset := DEFAULT_CHARSET;
  Result.Font.Color := clblack;//clGray;
  Result.Font.Height := -21;
  Result.Font.Name := 'Arial';
  Result.Font.Style := [fsBold];
  Result.HotTrackFont.Charset := ANSI_CHARSET;
  Result.HotTrackFont.Color := clWindowText;
  Result.HotTrackFont.Height := -12;
  Result.HotTrackFont.Name := 'Arial';
  Result.HotTrackFont.Style := [fsBold];
  //Result.Color := 13816530;
  Result.ParentColor := true;
  Result.ParentFont := False;
  Result.TabOrder := 1;

  if helpBtnPos ='rt' then begin
    Result.Margins.Bottom := VertMargin;
    Result.Align := alRight;
  end else if helpBtnPos ='rb' then begin
    Result.Margins.Top := VertMargin;
    Result.Align := alRight;
  end else if helpBtnPos ='lt' then begin
    Result.Margins.Bottom := VertMargin;
    Result.Align := alLeft;
  end else if helpBtnPos ='lb' then begin
    Result.Margins.Bottom := VertMargin;
    Result.Align := alLeft;
  end else begin
    Result.Align := alnone;
    Result.Left:= aLeft;
    Result.top := aTop;
    Result.Height := 30;
  end;
  helpButtonmsgs.add(Helpmsg);
  helpButtons.add(Result.name);

  Result.DisableTransparent := False;
  Result.AutoDisableParentOnclick := True;
  Result.OnClick := helpButtonclick;
end;
Procedure TfmStSInputBase.helpButtonclick(Sender:TObject);
begin
try
  logtext('==============================');
  logtext(Sender.classname);
  logtext(TDnmSpeedbutton(Sender).name);
  logtext(inttostr(helpButtons.indexof(TDnmSpeedbutton(Sender).name)));
  logtext(helpButtonmsgs[helpButtons.indexof(TDnmSpeedbutton(Sender).name)]);
  logtext('==============================');
  showERPRunningHelp(helpButtonmsgs[helpButtons.indexof(TDnmSpeedbutton(Sender).name)]);
Except
  // kill the exception
end;
end;


end.
