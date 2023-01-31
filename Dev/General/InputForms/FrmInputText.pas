unit FrmInputText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, DNMPanel, DNMSpeedButton, Shader,
  ComCtrls;

type
  TFmInputText = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    memInput: TMemo;
    lblPrompt: TLabel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lblFooter: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lstInput: TListBox;
    edtValue: TEdit;
    lblFilter: TLabel;
    dtPanel: TDNMPanel;
    Label1: TLabel;
    dtInput: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure lstInputDblClick(Sender: TObject);
    procedure edtValueDblClick(Sender: TObject);
    procedure lstInputClick(Sender: TObject);
    procedure dtPanelDblClick(Sender: TObject);
  private
    fsSelectedValue: String;
  public
    Property SelectedValue :String read fsSelectedValue write fsSelectedValue;

  end;
  function ModalInputBox(const aCaption, aPrompt,aFooter: string; var Input: string; DoInit:TNotifyEvent=nil): boolean;
  function ModalInputTextnDate(const aCaption, aPrompt,aFooter: string; var Input: string; var Inputdate:TDatetime; DoInit:TNotifyEvent=nil): boolean;
  Function InputTextInst(const aCaption, aPrompt,aFooter: string; var Input: string; hasDate:Boolean; DoInit:TNotifyEvent=nil):TFmInputText;
  Function SelectFromList(const aCaption, aPrompt,aFooter: string; Values : array of String; DefaultCalue:String; DoInit:TNotifyEvent=nil): String;

implementation

uses dateutils;

{$R *.dfm}
Function SelectFromList(const aCaption, aPrompt,aFooter: string; Values : array of String; DefaultCalue:String; DoInit:TNotifyEvent=nil): String;
var
  dlg: TFmInputText;
  ctr:Integer;
begin
  dlg:= TFmInputText.Create(nil);
  try
    dlg.Caption:= aCaption;
    dlg.TitleLabel.Caption:= aCaption;
    dlg.lblPrompt.Caption:= aPrompt;
    dlg.lblFooter.Caption:= aFooter;
    dlg.lstInput.visible := true;
    dlg.edtValue.visible := true;
    dlg.lstInput.Items.Clear;
    if length(Values)>0 then
      //for ctr := low(Values) to high(Values) do
      for ctr := 0 to length(Values)-1 do begin
        if trim(values[ctr]) <> '' then dlg.lstInput.items.add(values[ctr]);
      end;
    if DefaultCalue <> '' then
      for ctr := 0 to dlg.lstInput.items.count-1 do
        if sametext(DefaultCalue, dlg.lstInput.items[ctr]) then begin
          dlg.lstInput.itemindex := ctr;
          break;
        end;

    if (dlg.lstInput.itemindex <0) and (dlg.lstInput.items.count>0) then
      dlg.lstInput.itemindex := 0;
    if (dlg.lstInput.itemindex >=0) then
      dlg.lstInputClick(dlg.lstInput);

    if Assigned(DoInit) then DoInit(dlg);

    if dlg.ShowModal = mrOk then
        REsult := dlg.SelectedValue;
  finally
    dlg.Release;
  end;
end;
function ModalInputTextnDate(const aCaption, aPrompt,aFooter: string; var Input: string; var Inputdate:TDatetime; DoInit:TNotifyEvent=nil): boolean;
var
  dlg: TFmInputText;
begin
  dlg:= InputTextInst(aCaption,aPrompt,aFooter,Input, true, DoInit);
  try
    dlg.dtInput.datetime:=  Inputdate;
    result:= dlg.ShowModal = mrOk;
    Input:= dlg.memInput.Lines.Text;
    Inputdate := dlg.dtInput.datetime;
  finally
    dlg.Release;
  end;
end;
function ModalInputBox(const aCaption, aPrompt,afooter: string; var Input: string; DoInit:TNotifyEvent=nil): boolean;
var
  dlg: TFmInputText;
begin
  dlg:= InputTextInst(aCaption,aPrompt,aFooter,Input, false, DoInit);//TFmInputText.Create(nil);
  try
    (*dlg.Caption:= aCaption;
    dlg.TitleLabel.Caption:= aCaption;
    dlg.lblPrompt.Caption:= aPrompt;
    dlg.lblFooter.Caption:= aFooter;
    dlg.memInput.visible := true;
    dlg.memInput.Lines.Text:= Input;*)
    result:= dlg.ShowModal = mrOk;
    Input:= dlg.memInput.Lines.Text;
  finally
    dlg.Release;
  end;
end;
Function InputTextInst(const aCaption, aPrompt,aFooter: string; var Input: string; hasDate:Boolean; DoInit:TNotifyEvent=nil):TFmInputText;
begin
    Result:= TFmInputText.Create(nil);
    Result.Caption:= aCaption;
    Result.TitleLabel.Caption:= aCaption;
    Result.lblPrompt.Caption:= aPrompt; Result.lblPrompt.visible := trim(Result.lblPrompt.caption)<> '';
    Result.lblFooter.Caption:= aFooter; Result.lblFooter.visible := trim(Result.lblFooter.caption)<> '';
    Result.memInput.visible := true;
    Result.memInput.Lines.Text:= Input;
    Result.dtPanel.visible := hasDate;
    if hasDate then Result.height := Result.height +Result.dtPanel.height;
    if Assigned(DoInit) then DoInit(Result);
end;
procedure TFmInputText.dtPanelDblClick(Sender: TObject);
begin
  inherited;
  if dateof(dtInput.datetime) <> dtInput.datetime then
    dtInput.datetime:= dateof(dtInput.datetime);
end;

procedure TFmInputText.edtValueDblClick(Sender: TObject);
begin
  inherited;
  SelectedValue := trim(edtValue.Text);
end;

procedure TFmInputText.FormCreate(Sender: TObject);
begin
  inherited;
  memInput.visible := False;
  lstInput.visible := False;
  edtValue.visible := False;
  color:= $ADCF9C;
  lblPrompt.Caption:= '';
  SelectedValue := '';
end;

procedure TFmInputText.lstInputClick(Sender: TObject);
begin
  inherited;
  SelectedValue := trim(lstInput.Items[lstInput.ItemIndex]);
  edtvalue.text := trim(lstInput.Items[lstInput.ItemIndex]);
end;

procedure TFmInputText.lstInputDblClick(Sender: TObject);
begin
  inherited;
  SelectedValue := trim(lstInput.Items[lstInput.ItemIndex]);
  Modalresult := mrOk;
end;

end.
