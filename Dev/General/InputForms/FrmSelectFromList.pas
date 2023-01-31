unit FrmSelectFromList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, DNMPanel,BaseListingForm,
  Shader, DNMSpeedButton, ComCtrls, Grids, Wwdbigrd, Wwdbgrid,wwdbdatetimepicker;

type
  TFmSelectFromList = class(TBaseForm)
    pnlList: TDNMPanel;
    pnltop: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    btnSelect: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
  private
    fsListClassname: String;
    fsSelectedRecordIDField: String;
    aList:TBaseListingGUI;
    hasdate:boolean;
    Procedure OnSelect(Sender: TwwDbGrid);
    procedure setListClassname(const Value: String);
    procedure DBlclicktoRemovetime(Sender: TObject);
    { Private declarations }
  public
    Property ListClassname:String read fsListClassname write setListClassname;
    Property SelectedRecordIDField:String read fsSelectedRecordIDField write fsSelectedRecordIDField;
    Property Listfrom : TBaseListingGUI read aList;
    Class Procedure SelectFromList(AOwner:TCOmponent;aListClassname, aSelectedRecordIDField:String; onBeforeshow:TNotifyEvent; OnSelect :TNotifyEvent; SingleSelect:Boolean);
    Function AddDateinput(DateinputCaption:STring;DefaultValue:TDateTime; hasdate,hastime:Boolean; var pnl:TDnmPanel):TwwDBDateTimePicker;
  end;


implementation

uses CommonLib, dateutils, CommonFormLib;

{$R *.dfm}

{ TFmSelectFromList }

Function TFmSelectFromList.AddDateinput(DateinputCaption: STring;DefaultValue: TDateTime; hasdate,hastime:Boolean; var pnl:TDnmPanel):TwwDBDateTimePicker;
var
  lbl :TLabel;
begin
  if pnl = nil then begin
    pnl:= TDNMPanel.create(Self);
    with pnl do begin
      Parent := Self;
      Height := 30;
      Align := alTop;
      TabOrder := 0;
      Visible := true;
      BevelOuter := bvNone;
      InitComponentDefaultProperties(pnl);
      top := pnltop.top + pnltop.height +10;
    end;
  end;
  lbl := TLabel.create(Self);
  with lbl do begin
    Parent := pnl;
    Align := alLeft;
    Caption := ' ' +trim(DateinputCaption)+' : ';
    Layout := tlCenter;
    alignwithmargins:=true;
    Visible := true;
  end;
  result:= TwwDBDateTimePicker.create(self);
  with result do begin
    Parent := pnl;
    Align := alLeft;
    left := lbl.left + lbl.width +10;
    alignwithmargins:=true;
    Date := Dateof(DefaultValue);
    Time := Timeof(DefaultValue);
    Font.Style := [];
    if hasdate and hastime then   Displayformat := Shortdateformat +' hh:mm:ss tt'
    else if hastime then   Displayformat := 'hh:mm:ss tt'
    else if hastime then   Displayformat := Shortdateformat;
    onDblclick := DBlclicktoRemovetime;
    if hasdate and hastime then   Width := 170 else Width := 80;

    TabOrder := 0;
    Visible := true;

  end;
  hasdate:=true;
end;
procedure TFmSelectFromList.DBlclicktoRemovetime(Sender:TObject);
begin
  if sender is  TwwDBDateTimePicker then
    if dateof(TwwDBDateTimePicker(Sender).datetime)<> TwwDBDateTimePicker(Sender).datetime then
      TwwDBDateTimePicker(Sender).datetime := Dateof(TwwDBDateTimePicker(Sender).datetime);
end;

procedure TFmSelectFromList.FormCreate(Sender: TObject);
begin
  inherited;
  hasdate:=False;
end;

procedure TFmSelectFromList.OnSelect(Sender: TwwDbGrid);
begin
  if hasdate then begin
    aList.listtimermsg('Please Select The Date and Choose "Select"');
    Setcontrolfocus(btnSelect);
    highlightcontrol(btnSelect);
  end else begin
    btnSelect.click;
  end;
end;

class procedure TFmSelectFromList.SelectFromList(AOwner:TCOmponent;aListClassname,  aSelectedRecordIDField: String; onBeforeshow, OnSelect: TNotifyEvent; SingleSelect:Boolean);
var
  aInst :TFmSelectFromList;
begin
  aInst:= TFmSelectFromList.Create(AOwner);
  try
    aInst.ListClassname:= aListClassname;
    aInst.SelectedRecordIDField:= aSelectedRecordIDField;
    if SingleSelect then else aInst.aList.EnableMultiSelect('');
    aInst.aList.OnGridDataSelect := aInst.OnSelect;
    if Assigned(onBeforeshow) then onBeforeshow(aInst);
    if aInst.showmodal = mrok then begin
      if assigned(OnSelect) then OnSelect(aInst);
    end;
  finally
    FreeandNil(aInst);
  end;
end;


procedure TFmSelectFromList.setListClassname(const Value: String);
begin
  if Value <> '' then begin
    fsListClassname := Value;
    CreateHistorylistform(fsListClassname ,Self, aList);
    Self.Color := aList.pnlHeader.Color;
    Self.Caption := aList.TitleLabel.Caption;
    TitleLabel.Caption := aList.TitleLabel.Caption;
    aList.parent := pnlList;
    aList.align := alclient;
    aList.BorderStyle := bsNone;
    aList.fbIgnoreQuerySpeed := true;
    try
      aList.Show;
    except
      FreeAndNil(aList);
    end;
  end;
end;

initialization
  RegisterClassOnce(TFmSelectFromList);

end.
