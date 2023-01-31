unit frmReportingOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel,
  wwCheckBox, Contnrs, Menus, SelectionDialog;

type

  TCallbackMethod = procedure of object;
  TCallbackBoolFunction = function: boolean of object;

  TRepActItemList = class;
  TRepActItem = class;

  TfmReportingOptions = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    LblDescription: TLabel;
    chkEmailprogramconfrmation: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    fBuildDisplayDone: boolean;
    fCloseWhenDone: boolean;
    fInitForParent: TNotifyEvent;
    procedure BuildDisplay;
    procedure DoOnButtonClick(Sender: TObject);
    function getReportformCaption: String;
    procedure setReportformCaption(const Value: String);
    procedure RunAction(itm : TRepActItem);
  public
    ActionList: TRepActItemList;
    property CloseWhenDone: boolean read fCloseWhenDone write fCloseWhenDone;
    Property ReportformCaption :String read getReportformCaption Write setReportformCaption;
    Property InitForParent :TNotifyEvent read fInitForParent write fInitForParent;
  end;

  TRepActItem = class
  private
    fNotifyEventToCall: TNotifyEvent;
    fCaption: string;
    fMethodToCall: TCallbackMethod;
    fButton: TObject;
    fCheckBox: TwwCheckBox;
    fCloseWhenDone: boolean;
    fBoolFuncToCall: TCallbackBoolFunction;
    fenabled: boolean;
    fshowcheckBox: boolean;
    fComment: string;
    fIsDivider: boolean;
    fParam: TObject;
  public
    property NotifyEventToCall: TNotifyEvent read fNotifyEventToCall write fNotifyEventToCall;
    property MethodToCall: TCallbackMethod read fMethodToCall write fMethodToCall;
    property BoolFuncToCall: TCallbackBoolFunction read fBoolFuncToCall write fBoolFuncToCall;
    property Caption: string read fCaption write fCaption;
    property Button: TObject read fButton write fButton;
    property CheckBox: TwwCheckBox read fCheckBox write fCheckBox;
    property CloseWhenDone: boolean read fCloseWhenDone write fCloseWhenDone;
    property Enabled: boolean read fenabled write fEnabled;
    property showcheckBox: boolean read fshowcheckBox write fshowcheckBox;
    property Comment: string read fComment write fComment;
    property IsDivider: boolean read fIsDivider write fIsDivider;
    property Param : TObject read fParam write fParam;
  end;

  TRepActItemList = class
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItem(idx: integer): TRepActItem;
  protected
    procedure Insert(idx : integer;
      const aCaption, aComment: string; aNotifyEventToCall: TNotifyEvent; aCloseWhenDone, aEnabled: boolean;ashowcheckBox: boolean=true);
    function Search(const aOldCaption : string) : integer;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[idx: integer]: TRepActItem read GetItem;
    procedure Add(const aCaption, aComment: string; aNotifyEventToCall: TNotifyEvent; aCloseWhenDone, aEnabled: boolean;ashowcheckBox: boolean=true); overload;
    procedure Add(const aCaption, aComment: string; aMethodToCall: TCallbackMethod; aCloseWhenDone, aEnabled: boolean;ashowcheckBox: boolean=true); overload;
    procedure Add(const aCaption, aComment: string; aBoolFuncToCall: TCallbackBoolFunction; aCloseWhenDone, aEnabled: boolean;ashowcheckBox: boolean=true); overload;
    procedure Add(const ACaption, aComment : string; ANotifyEventToCall : TNotifyEvent; AParam : TObject;aCloseWhenDone, aEnabled: boolean;ashowcheckBox: boolean=true); overload;
    procedure InsertAfter(const aOldCaption : string;
      const aCaption, aComment: string;aNotifyEventToCall: TNotifyEvent; aCloseWhenDone, aEnabled: boolean;ashowcheckBox: boolean=true);overload;
    procedure InsertAfter(const aOldCaption : string;
      const aCaption, aComment: string; aMethodToCall: TCallbackMethod; aCloseWhenDone, aEnabled: boolean;ashowcheckBox: boolean=true);overload;

    procedure AddDivider(aCaption: string;aComment: string='');
  end;

(*
var
  fmReportingOptions: TfmReportingOptions;
*)
implementation

{$R *.dfm}

{ TRepActItemList }

procedure TRepActItemList.Add(const aCaption, aComment: string; aMethodToCall: TCallbackMethod; aCloseWhenDone, aEnabled: boolean;ashowcheckBox: boolean=true);
var
  itm: TRepActItem;
begin
  itm := TRepActItem.Create;
  itm.IsDivider := false;
  itm.Caption := aCaption;
  itm.MethodToCall := aMethodToCall;
  itm.CloseWhenDone := aCloseWhenDone;
  itm.Enabled := aEnabled;
  itm.showcheckBox := ashowcheckBox;
  itm.Comment := aComment;
  fList.Add(itm);
end;

procedure TRepActItemList.Add(const aCaption, aComment: string;
  aNotifyEventToCall: TNotifyEvent; aCloseWhenDone, aEnabled: boolean;ashowcheckBox: boolean=true);
var
  itm: TRepActItem;
begin
  itm := TRepActItem.Create;
  itm.IsDivider := false;
  itm.Caption := aCaption;
  itm.NotifyEventToCall := aNotifyEventToCall;
  itm.CloseWhenDone := aCloseWhenDone;
  itm.Enabled := aEnabled;
  itm.showcheckBox := ashowcheckBox;
  itm.Comment := aComment;
  fList.Add(itm);
end;

procedure TRepActItemList.Add(const aCaption, aComment: string;
  aBoolFuncToCall: TCallbackBoolFunction; aCloseWhenDone, aEnabled: boolean; ashowcheckBox: boolean=true);
var
  itm: TRepActItem;
begin
  itm := TRepActItem.Create;
  itm.IsDivider := false;
  itm.Caption := aCaption;
  itm.BoolFuncToCall := aBoolFuncToCall;
  itm.CloseWhenDone := aCloseWhenDone;
  itm.Enabled := aEnabled;
  itm.showcheckBox := ashowcheckBox;
  itm.Comment := aComment;
  fList.Add(itm);
end;

procedure TRepActItemList.AddDivider(aCaption: string;aComment: string='');
var
  itm: TRepActItem;
begin
  itm := TRepActItem.Create;
  itm.IsDivider := true;
  itm.Caption := aCaption;
  itm.Comment := aComment;
  fList.Add(itm);
end;

constructor TRepActItemList.Create;
begin
  fList := TObjectList.Create(true);
end;

destructor TRepActItemList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TRepActItemList.GetCount: integer;
begin
  result := fList.Count;
end;

function TRepActItemList.GetItem(idx: integer): TRepActItem;
begin
  result := TRepActItem(fList[idx]);
end;


procedure TRepActItemList.Insert(idx: integer; const aCaption, aComment: string;
  aNotifyEventToCall: TNotifyEvent; aCloseWhenDone, aEnabled,
  ashowcheckBox: boolean);
var
  itm: TRepActItem;
begin
  itm := TRepActItem.Create;
  itm.IsDivider := false;
  itm.Caption := aCaption;
  itm.NotifyEventToCall := aNotifyEventToCall;
  itm.CloseWhenDone := aCloseWhenDone;
  itm.Enabled := aEnabled;
  itm.showcheckBox := ashowcheckBox;
  itm.Comment := aComment;
  if idx >= Count then
    fList.Add(itm)
  else
    fList.Insert(idx, itm);

end;

procedure TRepActItemList.InsertAfter(const aOldCaption, aCaption,
  aComment: string; aMethodToCall: TCallbackMethod; aCloseWhenDone, aEnabled,
  ashowcheckBox: boolean);
var
  itm: TRepActItem;
  idx : integer;
begin
  idx := Search(aOldCaption) + 1;
  itm := TRepActItem.Create;
  itm.IsDivider := false;
  itm.Caption := aCaption;
  itm.MethodToCall := aMethodToCall;
  itm.CloseWhenDone := aCloseWhenDone;
  itm.Enabled := aEnabled;
  itm.Comment := aComment;
  if idx >= Count then
    fList.Add(itm)
  else
    fList.Insert(idx, itm);
end;

procedure TRepActItemList.InsertAfter(const aOldCaption, aCaption,
  aComment: string; aNotifyEventToCall: TNotifyEvent; aCloseWhenDone, aEnabled,
  ashowcheckBox: boolean);
var
  idx : integer;
  itm: TRepActItem;
begin
  idx := Search(aOldCaption) + 1;
  itm := TRepActItem.Create;
  itm.IsDivider := false;
  itm.Caption := aCaption;
  itm.NotifyEventToCall := aNotifyEventToCall;
  itm.CloseWhenDone := aCloseWhenDone;
  itm.Enabled := aEnabled;
  itm.showcheckBox := ashowcheckBox;
  itm.Comment := aComment;
  if idx >= Count then
    fList.Add(itm)
  else
    fList.Insert(idx, itm);

end;

function TRepActItemList.Search(const aOldCaption: string): integer;
var
  idx : integer;
begin
  for idx := 0 to Count-1 do
  begin
    if SameText(aOldCaption, Item[idx].Caption) then
    begin
      Result := idx;
      Exit;
    end;
  end;
  Result := Count;
end;

procedure TRepActItemList.Add(const ACaption, aComment: string;
  ANotifyEventToCall: TNotifyEvent; AParam: TObject; aCloseWhenDone, aEnabled,
  ashowcheckBox: boolean);
var
  itm: TRepActItem;
begin
  itm := TRepActItem.Create;
  itm.IsDivider := false;
  itm.Caption := aCaption;
  itm.NotifyEventToCall := aNotifyEventToCall;
  itm.CloseWhenDone := aCloseWhenDone;
  itm.Enabled := aEnabled;
  itm.showcheckBox := ashowcheckBox;
  itm.Comment := aComment;
  itm.Param := AParam;
  fList.Add(itm);
end;

{ TfmReportingOptions }

procedure TfmReportingOptions.btnOkClick(Sender: TObject);
var
  x: integer;
  itm: TRepActItem;
begin
  for x := 0 to ActionList.Count - 1 do begin
    itm := ActionList.Item[x];
    if (not itm.IsDivider) and itm.CheckBox.Checked then
      RunAction(itm);
  end;
  ModalResult := mrOk;
end;

procedure TfmReportingOptions.RunAction(itm: TRepActItem);
begin
  if Assigned(itm.NotifyEventToCall) then begin
    if Assigned(itm.Param) then itm.NotifyEventToCall(itm.Param)
    else if Assigned(itm.button) then itm.NotifyEventToCall(itm.button)
    else itm.NotifyEventToCall(nil);

    if itm.CloseWhenDone then
      CloseWhenDone := True;
  end
  else if Assigned(itm.MethodToCall) then begin
    itm.MethodToCall;
    if itm.CloseWhenDone then
      CloseWhenDone := True;
  end
  else if Assigned(itm.BoolFuncToCall) then begin
    if itm.BoolFuncToCall then begin
      if itm.CloseWhenDone then
        CloseWhenDone := True;
    end;
  end;
end;

procedure TfmReportingOptions.BuildDisplay;
var
  x: integer;
  btn: TDNMSpeedButton;
  chk: TwwCheckBox;
  itm: TRepActItem;
  lbl: TLabel;
  bvl: TBevel;
  AnycheckBoxvisible :Boolean;

const
  BTN_WIDTH = 117;
  BTN_HEIGHT = 27;
  BTN_LEFT  = 50;
  CHK_WIDTH = 17;

function CheckLeft: Integer;
begin
  result := BTN_LEFT + BTN_WIDTH + 30;
end;

Function LabelLeft: Integer;
begin
  Result := CheckLeft + CHK_WIDTH + 15;
end;
begin
  if fBuildDisplayDone then exit;

  AnycheckBoxvisible := False;
  for x := 0 to ActionList.Count -1 do begin
    itm := ActionList.Item[x];
    if itm.IsDivider then begin
      bvl         := TBevel.Create(self);
      bvl.Parent  := self;
      bvl.Shape   := bsBottomLine;
      bvl.Height  := 3;
      bvl.Width   := self.ClientWidth - 30;
      bvl.Left    := 15;
      bvl.Top     := (80 + (x * (BTN_HEIGHT + 7))) + BTN_HEIGHT - 3;

      lbl             := TLabel.Create(self);
      lbl.Parent      := self;
      lbl.Left        := bvl.Left;
      lbl.Top         := bvl.Top - lbl.Height - 3;
      lbl.Font.Style  := [fsBold];
      lbl.Caption     := itm.Caption;
      if itm.Comment <> '' then begin
        lbl         := TLabel.Create(self);
        lbl.Parent  := self;
        lbl.Caption := itm.Comment;
        lbl.Left    := CheckLeft;
        lbl.Width   := self.ClientWidth - lbl.Left - 10;
        lbl.Top     := bvl.Top - lbl.Height - 3;
        btn.ShowHint:= true;
        btn.Hint    := itm.Comment;
      end;
    end
    else begin
      btn               := TDNMSpeedButton.Create(self);
      btn.Parent        := self;
      btn.Width         := BTN_WIDTH;
      btn.Height        := BTN_HEIGHT;
      btn.Color         := clWhite;
      btn.HotTrackColor := clBtnShadow;
      btn.SlowDecease   := True;
      btn.Style         := bsModern;
      btn.ParentFont    := true;
      btn.Font.Style    := [fsBold];
      btn.Caption       := itm.Caption;
      itm.Button        := btn;
      btn.Left          := BTN_LEFT; //Round(((ClientWidth - btn.Width) / 2) - 20);
      btn.Top           := 80 + (x * (BTN_HEIGHT + 7));
      btn.OnClick       := DoOnButtonClick;
      btn.Enabled       := itm.Enabled;

      chk         := TwwCheckBox.Create(self);
      chk.Parent  := self;
      itm.CheckBox:= chk;
      chk.Caption := '';
      chk.Width   := CHK_WIDTH;
      chk.Top     := btn.Top + Round((btn.Height - chk.Height) / 2);
      chk.Left    := CheckLeft;
      chk.Enabled := itm.Enabled;
      chk.Visible := itm.showcheckBox;
      if itm.showcheckBox  then AnycheckBoxvisible := True;

      if itm.Comment <> '' then begin
        lbl         := TLabel.Create(self);
        lbl.Parent  := self;
        lbl.AutoSize:= false;
        lbl.Left    := labelLeft;
        lbl.Width   := self.ClientWidth - lbl.Left - 10;
        lbl.Top     := btn.Top + Round((btn.Height - lbl.Height) / 2);
        lbl.Caption := itm.Comment;
        btn.ShowHint:= true;
        btn.Hint    := itm.Comment;
      end;
    end;

    self.Height := self.Height + BTN_HEIGHT + 7;
  end;

  if not AnycheckBoxvisible then begin
    Self.Height := Self.Height  - LblDescription.Height;
    LblDescription.visible := False;
  end;
  if assigned(fInitForParent) then fInitForParent(self);

  fBuildDisplayDone := true;

end;

procedure TfmReportingOptions.DoOnButtonClick(Sender: TObject);
var
  x: integer;
  itm: TRepActItem;
begin
  for x := 0 to ActionList.Count - 1 do
  begin
    itm := ActionList.Item[x];
    if itm.Button = Sender then
    begin
      RunAction(itm);
      ModalResult := mrOk;
      Break;
    end;
  end;

end;

procedure TfmReportingOptions.FormCreate(Sender: TObject);
begin
  inherited;
  ActionList := TRepActItemList.Create;
  fBuildDisplayDone := false;
  fCloseWhenDone := false;
  chkEmailprogramconfrmation.visible := False;
  fInitForParent := nil;
end;

procedure TfmReportingOptions.FormDestroy(Sender: TObject);
begin
  inherited;
  ActionList.Free;
end;

procedure TfmReportingOptions.FormShow(Sender: TObject);
begin
  inherited;
  BuildDisplay;
end;

function TfmReportingOptions.getReportformCaption: String;
begin
  Result := TitleLabel.Caption;
end;

procedure TfmReportingOptions.setReportformCaption(const Value: String);
begin
  TitleLabel.Caption := Value;
  Self.Caption := Value;
end;

end.
