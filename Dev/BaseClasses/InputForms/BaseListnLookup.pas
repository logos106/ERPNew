
unit BaseListnLookup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls, DBCtrls,
  DNMPanel, Shader, BaseListingForm, DNMSpeedButton , ImageDLLLib, ActnList,
  GuiPrefsObj, DNMAction, wwdblook , db;

type
  TBaseListnLookupGUI = class(TBaseForm)
    pnlSelection: TDNMPanel;
    lblselection: TLabel;
    pnllist: TDNMPanel;
    pnlTop: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkHideDetails: TCheckBox;
    c: TActionList;
    actSave: TDNMAction;
    actclose: TDNMAction;
    pnlButtons: TDNMPanel;
    DNMPanel2: TDNMPanel;
    cboLookup: TwwDBLookupCombo;
    report1n2: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actcloseExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkHideDetailsClick(Sender: TObject);
  private
    fsListclassname: String;
    fscomboSelected: String;
    fOnGridDataSelect: TOnGridDataSelect ;
    faftershowlist: TNotifyEvent;
    fBeforeshowList: TNotifyEvent;
    Procedure DoOnGridDataSelect(Sender:TObject);
    Procedure OnDataScroll(Dataset :TDataset);

  Protected
    fListForm: TBaseListingGUI;
    btn_Save  : TERPMainSwitchButton;
    btn_Close  : TERPMainSwitchButton;
    GuiPrefs: TFormGuiPrefs;
  public
    Property Listclassname:String read fsListclassname write fsListclassname;
    Property comboSelected:String read fscomboSelected write fscomboSelected;
    property OnGridDataSelect: TOnGridDataSelect read fOnGridDataSelect write fOnGridDataSelect;
    Property aftershowlist :TNotifyEvent read faftershowlist write faftershowlist;
    Property BeforeshowList :TNotifyEvent read fBeforeshowList write fBeforeshowList;

  Class function MakeListnLookup(Listname:String ; selectedfields:String;BeforeshowList, aftershowlist :TnotifyEvent;  aOnGridDataSelect: TOnGridDataSelect ):Boolean;
  Class Function MakeInstance:TBaseListnLookupGUI;virtual;

  end;


implementation

uses AppEnvironment, CommonLib, CommonFormLib, ButtonsLib;

{$R *.dfm}

{ TBaseListnLookupGUI }

procedure TBaseListnLookupGUI.actcloseExecute(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TBaseListnLookupGUI.actSaveExecute(Sender: TObject);
begin
  inherited;
  if Assigned(fOnGridDataSelect) then
    fOnGridDataSelect(fListForm.grdMain);
  Self.Close;
end;

procedure TBaseListnLookupGUI.chkHideDetailsClick(Sender: TObject);
begin
  inherited;
  if chkHideDetails.checked then begin
    Self.Width := pnlSelection.Width+10;
    Self.height := 400 ;
    TitleLabel.font.size :=  18;
    pnlHeader.Left := 30;
    pnlHeader.Width := pnlTop.width -60;
  end else begin
    self.width := 1004;
    self.height:= 590;
    TitleLabel.font.size :=  26;
    pnlHeader.Left := 100;
    pnlHeader.Width := pnlTop.width -200;
  end;

  pnllist.visible := not(chkHideDetails.checked);
  GuiPrefs.Node['Options.HideDetails'].asBoolean := chkHideDetails.checked;
  Position := poMainFormCenter;
  Setcontrolfocus(cboLookup);
end;

procedure TBaseListnLookupGUI.DoOnGridDataSelect(Sender: TObject);
begin
  btn_Save.Click;
end;

procedure TBaseListnLookupGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  GuiPrefs.Node['Options.LeftMargin.'+Listclassname].AsInteger:= pnlSelection.width;
  GuiPrefs.SavePrefs;
  action := caFree;
end;

procedure TBaseListnLookupGUI.FormCreate(Sender: TObject);
begin
  fBeforeshowList := nil;
  faftershowlist := nil;
  inherited;
    GuiPrefs := TFormGuiPrefs.Create(Self);

    self.width := 1004;
    self.height:= 590;
    TitleLabel.font.size :=  26;
    pnlHeader.Left := 100;
    pnlHeader.Width := pnlTop.width -200;

    btn_Save	    := TERPMainSwitchButton.create(Self);  With btn_Save   do begin  Name := MakeName(Self,'btn_Save'); Parent := pnlButtons;width := 75;Height := 75;Left := btnleft(2, 75 ,1, pnlButtons);Top := pnlButtons.Height -10 - 75;DnmAction := actSave ;onclick := actSaveexecute; Enabled := True;Anchors :=[]; end;
    btn_Close	    := TERPMainSwitchButton.create(Self);  With btn_close  do begin  Name := MakeName(Self,'btn_close'); Parent := pnlButtons;width := 75;Height := 75;Left := btnleft(2, 75 ,2, pnlButtons);Top := pnlButtons.Height -10 - 75;DnmAction := actclose ;onclick := actcloseexecute;Enabled := True;Anchors :=[]; end;
end;

procedure TBaseListnLookupGUI.FormDestroy(Sender: TObject);
begin
  FreeandNil(fListForm);
  inherited;

end;

procedure TBaseListnLookupGUI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = vk_f5 then begin
      chkHideDetails.Checked := not(chkHideDetails.Checked);
      exit;
    end;
    if Key = VK_ESCAPE then Begin
      Self.Close;
      Exit;
    End;
  inherited;
end;

procedure TBaseListnLookupGUI.FormShow(Sender: TObject);
var
  st:TStringlist;
  ctr:Integer;
  function comboSelectedText(const Fieldname:String):String;
  begin
    Result := Fieldname+#9+
              inttostr(fListform.Qrymain.fieldbyname(Fieldname).displayWidth)+#9+
              fListform.Qrymain.fieldbyname(Fieldname).DisplayLabel ;
  end;
begin
  inherited;
  if not GuiPrefs.Active then GuiPrefs.Active:= true;
  if GuiPrefs.Node.Exists('Options.LeftMargin.'+Listclassname) then
    pnlSelection.width := GuiPrefs.Node['Options.LeftMargin.'+Listclassname].AsInteger;

  CreateHistorylistform(Listclassname ,Self, fListForm,'');



  if Assigned(fListForm) then begin
    fListForm.Parent := pnllist;
    fListForm.OnDataScroll := OnDataScroll;
    fListForm.align := alclient;
    fListForm.CloseOnRecSelect := False;
    fListForm.BorderStyle := bsNone;
    fListForm.grdmain.OnDblClick := DoOnGridDataSelect;
    fListForm.fbIgnoreQuerySpeed := true;
    Self.Color := fListForm.Color;
    try
      if Assigned(fBeforeshowList) then fBeforeshowList(fListForm);
      fListForm.Show;
      if Assigned(faftershowlist) then faftershowlist(fListForm);
    except
      FreeAndNil(fListForm);
    end;
    fListForm.Refresh;

    fListForm.Qrymain.First;
    TitleLabel.Caption := fListform.TitleLabel.Caption;
    Caption := fListform.TitleLabel.Caption;
    cboLookup.lookuptable := fListform.Qrymain;
    cboLookup.Selected.Clear;
    if comboSelected  = '' then  comboSelected  := fListform.Qrymain.fields[0].fieldname;
    if comboSelected <> '' then begin
      st:= TStringlist.create;
      try
        st.commatext := comboSelected ;
        for ctr := 0 to st.count-1 do begin
          if fListform.Qrymain.findfield(st[ctr]) = nil then begin
            MessageDlgXP_Vista(fListform.classname +'.' + st[ctr]+'-Field Missing.. Contact ERP', mtWarning, [mbOK], 0);
          end else begin
            if ctr =0 then begin
              cboLookup.Lookupfield:=  st[ctr];
              cboLookup.text := fListForm.Qrymain.fieldbyname(cboLookup.Lookupfield).asString;
              lblselection.caption := fListform.Qrymain.fieldbyname(st[ctr]).DisplayLabel;
            end;
            cboLookup.Selected.Add( comboSelectedText(st[ctr]));
          end;
        end;
      finally
        Freeandnil(St);
      end;
    end;

  end;
  chkHideDetails.checked := GuiPrefs.Node['Options.HideDetails'].asBoolean;
end;


class function TBaseListnLookupGUI.MakeInstance: TBaseListnLookupGUI;
begin
  Result := TBaseListnLookupGUI(GetComponentByClassName('TBaseListnLookupGUI'));
end;

class Function  TBaseListnLookupGUI.MakeListnLookup(Listname,  selectedfields: String; BeforeshowList, aftershowlist :TnotifyEvent;aOnGridDataSelect: TOnGridDataSelect ):Boolean;
var
  Form :TBaseListnLookupGUI;
begin
  Result := False;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel(Listname) =6 then begin
    CommonLib.MessageDlgXP_Vista('You do not have Access to ' + AppEnv.AccessLevels.GetFormDescription(Listname), mtWarning, [mbOK], 0);
    Exit;
  end;
  Form := MakeInstance;
  Form.BeforeshowList := BeforeshowList;
  Form.aftershowlist := aftershowlist;
  form.OnGridDataSelect := aOnGridDataSelect;
  form.Listclassname := listName;
  Form.comboSelected := Selectedfields;
  //if Assigned(BeforeshowList) then BeforeshowList(form);
  form.FormStyle := fsMdiChild;
  //if Assigned(aftershowlist) then aftershowlist(form);
  form.Bringtofront;
 (* while FormStillOpen(form.ClassName, form) do begin
    Sleep(10);
    Application.ProcessMessages;
  end;*)

end;

procedure TBaseListnLookupGUI.OnDataScroll(Dataset: TDataset);
begin
  if cboLookup.Lookupfield <> '' then
    if fListForm.Qrymain.findfield(cboLookup.Lookupfield) <> nil then
      cboLookup.text := fListForm.Qrymain.fieldbyname(cboLookup.Lookupfield).asString;
end;

end.
