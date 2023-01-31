unit MemoDialog;

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AdvMenus, StdCtrls, Buttons, DNMSpeedButton, StrUtils,
  frmBase, db, ExtCtrls, DNMLib;

type
  TfrmMemoDialog = class(TfrmBaseGUI)
    Memo: TMemo;
    MainMenu: TMainMenu;
    mFile: TMenuItem;
    mSaveAs: TMenuItem;
    mPrint: TMenuItem;
    bbtnOK: TDNMSpeedButton;
    sdSaveMemo: TSaveDialog;
    bbtnSaveAs: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnAdddateTime: TDNMSpeedButton;
    procedure mSaveAsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbtnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdddateTimeClick(Sender: TObject);
  private
    fDBField: TField;
    { Private declarations }
  public
    { Public declarations }
    procedure SetMemo(const aFormCaption, aMemo: string);
    Property DBField:TField read fDBField write fDBField;
    Class Procedure Memopopup(memotext,memoheader:String);
  end;

  procedure DoMemoDialog(const aCaption, aText: string; ScrollBars: TScrollStyle = ssNone);
  procedure DoMemoDialogReadonly(const aCaption, aText: string; ScrollBars: TScrollStyle = ssNone);
  procedure DoMemoDialogOnTop(const AOwner:TComponent; const aCaption, aText: string; ScrollBars: TScrollStyle = ssNone);
  Procedure DoDBMemoDialog(memotext,memoheader:String; Editfield:TField);

var
  frmMemoDialog: TfrmMemoDialog;

implementation

{$R *.dfm}

uses FastFuncs, CommonLib;

{ TfrmMemoDialog }
Procedure DoDBMemoDialog(memotext,memoheader:String; Editfield:TField);
var
  form: TfrmMemoDialog;
begin
  form:= TfrmMemoDialog.Create(nil);
  try
    form.Memo.Lines.Text    := Editfield.AsString;
    form.Memo.REadonly      := False;
    form.Caption            := memoheader;
    form.bbtnSaveAs.Enabled := False;
    form.btnCancel.Enabled  := True;
    form.mFile.visible      := False;
    form.fDBField           := Editfield;
    form.ShowModal;
  finally
    form.Free;
  end;
end;
procedure DoMemoDialogOnTop(const AOwner:TComponent; const aCaption, aText: string; ScrollBars: TScrollStyle = ssNone);
var
  form: TfrmMemoDialog;
begin
  form := TfrmMemoDialog(FindExistingComponent(AOwner, 'TfrmMemoDialog'));
  if form = nil then form:= TfrmMemoDialog.Create(AOwner);
  form.Memo.ScrollBars:= ScrollBars;
  form.Memo.Lines.Text:= aText;
  form.Caption:= aCaption;
  form.bbtnSaveAs.Enabled := False;
  form.mFile.visible := False;
  form.formStyle := fsStayontop;
  form.Show;
  form.bringtofront;
end;
procedure DoMemoDialogReadonly(const aCaption, aText: string; ScrollBars: TScrollStyle = ssNone);
var
  form: TfrmMemoDialog;
begin
  form:= TfrmMemoDialog.Create(nil);
  try
    form.Memo.ScrollBars:= ScrollBars;
    form.Memo.Lines.Text:= aText;
    form.Caption:= aCaption;
    form.bbtnSaveAs.Enabled := False;
    form.mFile.visible := False;
    form.ShowModal;
  finally
    form.Free;
  end;
end;
procedure DoMemoDialog(const aCaption, aText: string; ScrollBars: TScrollStyle = ssNone);
var
  form: TfrmMemoDialog;
begin
  form:= TfrmMemoDialog.Create(nil);
  try
    form.Memo.ScrollBars:= ScrollBars;
    form.Memo.Lines.Text:= aText;
    form.Caption:= aCaption;
    form.ShowModal;
  finally
    form.Free;
  end;
end;

procedure TfrmMemoDialog.SetMemo(Const aFormCaption, aMemo: string);
Var
  TmpStr: String;
begin
  Caption := aFormCaption;
  TmpStr := StringReplace(aMemo, #10, #13#10, [rfReplaceAll, rfIgnoreCase]);
  Memo.Text := TmpStr;
end;
procedure TfrmMemoDialog.bbtnOKClick(Sender: TObject);
begin
  inherited;
  if Assigned(fDBField) then begin
    with fDBField.DataSet do if state in [dsEdit,dsInsert] then else fDBField.DataSet.edit;
	  fDBField.AsString := Memo.text;
    with fDBField.DataSet do if state in [dsEdit,dsInsert] then fDBField.DataSet.Post;
  end;
  if fsModal in formstate then Modalresult := mrOk else self.Close;
end;

procedure TfrmMemoDialog.btnAdddateTimeClick(Sender: TObject);
begin
  inherited;
    memo.Text := TRim(memo.text);
    memo.Lines.Add(AddDateTimeemp(lcdOnLoganyway , memo.Lines.Strings[memo.Lines.Count - 1] , true));
end;

procedure TfrmMemoDialog.btnCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in formstate then Modalresult := mrcancel else self.Close;
end;

procedure TfrmMemoDialog.FormCreate(Sender: TObject);
begin
  inherited;
  fDBField:= nil;
end;

procedure TfrmMemoDialog.FormShow(Sender: TObject);
(*var
  x: integer;
  totWidth: integer;
  btn: TDNMSpeedButton;
  nextLeft: integer;*)
begin
  inherited;
//  if bbtnOK.visible     and not(btnCancel.visible) then bbtnOK.left     := trunc((Self.width - bbtnOK.width)/2)
//  else if btnCancel.visible  and not(bbtnOK.visible)    then btnCancel.left  := trunc((Self.width - btnCancel.width)/2)
 (* totWidth := 0;
  for x := 0 to self.ControlCount -1 do begin
    if Controls[x] is TDNMSpeedButton then begin
      btn := TDNMSpeedButton(Controls[x]);
      if btn.Visible then begin
        if totWidth = 0 then totWidth := btn.Width
        else totWidth := totWidth + btn.Width + 20;
      end;
    end;
  end;
  nextLeft := (ClientWidth - totWidth) Div 2;
  for x := 0 to self.ControlCount -1 do begin
    if Controls[x] is TDNMSpeedButton then begin
      btn := TDNMSpeedButton(Controls[x]);
      if btn.Visible then begin
        btn.Left := nextLeft;
        nextLeft := nextLeft + btn.Width + 20;
      end;
    end;
  end;*)

end;

class procedure TfrmMemoDialog.Memopopup(memotext,memoheader: String);
var
  fMemoDialog :TfrmMemoDialog;
begin
    fMemoDialog:= TfrmMemoDialog.create(nil);
    try
      try
        //fMemoDialog.Memo.Text := memotext;
        fMemoDialog.Memo.Lines.Text := memotext;
        fMemoDialog.Caption:= memoheader;
        fMemoDialog.bbtnOK.Default:= True;
        fMemoDialog.bbtnOK.Cancel:= True;
        fMemoDialog.ShowModal;
      except
         {$IFDEF DevMode}
        on E:Exception do begin
            MessageDlgXP_Vista(E.Message , mterror, [mbok],0);
        end;
         {$ENDIF}
      end;
    finally
      Freeandnil(fMemoDialog);
    end;
end;


procedure TfrmMemoDialog.mSaveAsClick(Sender: TObject);
begin
  if sdSaveMemo.Execute then begin
    Memo.Lines.SaveToFile(sdSaveMemo.FileName);
  end; {if}
end;

end.
