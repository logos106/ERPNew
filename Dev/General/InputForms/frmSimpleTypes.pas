unit frmSimpleTypes;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 12/04/05  1.00.01 IJB  Added DoSimpleTypesEditNew procedure to open form with
  //                        a new type the user wishes to add.
  // 17/10/05  1.00.02 DSP  Added simple type 'StatusType'.


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DB,  StdCtrls, Grids, Wwdbigrd, Wwdbgrid, MemDS, Buttons, DNMSpeedButton, ExtCtrls,
  DNMPanel, DataState, Menus, AdvMenus, Shader, ImgList, ProgressDialog;

type
  TfmSimpleTypes = class(TBaseInputGUI)
    pnlTop: TDNMPanel;
    pnlBottom: TDNMPanel;
    qrySimpleTypes: TERPQuery;
    grdTypes: TwwDBGrid;
    dsSimpleTypes: TDataSource;
    qrySimpleTypesGlobalRef: TWideStringField;
    qrySimpleTypesId: TIntegerField;
    qrySimpleTypesName: TWideStringField;
    qrySimpleTypesActive: TWideStringField;
    qrySimpleTypesTypeCode: TWideStringField;
    qrySimpleTypesIsDefault: TWideStringField;
    qrySimpleTypesDescription: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lblNote: TLabel;
    btnGrid: TwwIButton;
    popDelete: TAdvPopupMenu;
    mnuDelete: TMenuItem;
    mnuToggleActive: TMenuItem;
    mnuToggleDefault: TMenuItem;
    pnlshowActive: TDNMPanel;
    cbxShowInactive: TCheckBox;
    pnlbottombuttons: TDNMPanel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnSimpletypeActions: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cbxShowInactiveClick(Sender: TObject);
    procedure qrySimpleTypesBeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnSimpletypeActionsClick(Sender: TObject);
    procedure qrySimpleTypesNameChange(Sender: TField);
    procedure grdTypesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdTypesDblClick(Sender: TObject);
    procedure btnGridClick(Sender: TObject);
    procedure mnuDeleteClick(Sender: TObject);
    procedure mnuToggleActiveClick(Sender: TObject);
    procedure mnuToggleDefaultClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    FTypeToShow: string;
    fNewType: string;
    fbinLargefont: boolean;
    fbCloseonDblclick: Boolean;
    procedure RefreshQuery;
    procedure SetTypeToShow(const Value: string);
    function ValidateData: boolean;
    procedure setInLargefont(const Value: boolean);
  Protected
  public
    procedure Centralisebuttons(OwnerPanel:TDnMPanel; leftmargin :Integer =0; rightMargin :Integer =0; btngap:Integer=4);Override;
    property TypeToShow: string read FTypeToShow write SetTypeToShow;
    property NewType: string read fNewType write fNewType;
    class procedure DoSimpleTypesEdit(const aType: string;NewValue:String='';AOwner:Tcomponent=nil; InLargefont:Boolean =False; Autoclose:Boolean =False;aCloseonDblclick:Boolean= True);
    class function DoModalSimpleTypesEdit(const aType: string;NewValue:String='';AOwner:Tcomponent=nil; InLargefont:Boolean =False) : integer;
//    class procedure DoSimpleTypesEditNew(const aType, aName: string);
    class function DoSimpleTypesAddNew(const aType, aName: string): boolean;
    class function DoSimpleTypesSelect(const aType: string; InLargefont:Boolean =False; AllowNew:Boolean=False): Integer;
    Property inLargefont :boolean read fbinLargefont write setInLargefont;
    Property CloseonDblclick :Boolean read fbCloseonDblclick write fbCloseonDblclick;
  end;


implementation

{$R *.dfm}

uses
  DNMExceptions, CommonLib, tcconst,BusObjSimpleTypes, CommonDbLib, CommonFormLib,
  frmSimpleTypeActions, FastFuncs, AppEnvironment ;

class procedure TfmSimpleTypes.DoSimpleTypesEdit(const aType: string; NewValue:String='';AOwner:Tcomponent=nil; InLargefont:Boolean =False; Autoclose:Boolean =False;aCloseonDblclick:Boolean= True);
var
  fmSimpleTypes: TfmSimpleTypes;
  qry: TERPQuery;

begin
  if CommonLib.FormStillOpen('TfmSimpleTypes') then TForm(FindExistingComponent('TfmSimpleTypes')).Close;
  Application.ProcessMessages;

  fmSimpleTypes := TfmSimpleTypes.Create(Application);
  if Assigned(AOwner) and (AOwner is TForm) then
    fmSimpleTypes.AttachObserver(AOwner);

  fmSimpleTypes.TypeToShow := aType;
  fmSimpleTypes.FormStyle := fsMDIChild;
  fmSimpleTypes.InLargefont := InLargefont;
  fmSimpleTypes.CloseonDblclick := aCloseonDblclick;
  fmSimpleTypes.BringToFront;
  fmSimpleTypes.grdTypes.options := fmSimpleTypes.grdTypes.options + [dgEditing];
  fmSimpleTypes.grdTypes.Columnbyname('name').ReadOnly := True;
  fmSimpleTypes.cmdNew.enabled := TRue;

  if NewValue <> ''  then begin
    qry:= TERPQuery.Create(nil);
    try
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Add('select Name,Active from tblSimpleTypes');
      qry.SQL.Add('where TypeCode = ' + QuotedStr(aType));
      qry.SQL.Add('and Name = ' + QuotedStr(NewValue));
      qry.Open;
      if qry.IsEmpty then begin
        if fmSimpleTypes.qrySimpleTypes.Active then begin
          if (not(fmSimpleTypes.qrySimpleTypes.Locate('Name' , Newvalue , [loCaseInsensitive]))) then begin
            fmSimpleTypes.qrySimpleTypes.Append;
            fmSimpleTypes.qrySimpleTypesName.asString := Newvalue;
            fmSimpleTypes.qrySimpleTypes.Post;
          end;
        end;
      end
      else begin
        if fmSimpleTypes.qrySimpleTypes.Active then begin
          if (not qry.FieldByName('Active').asBoolean) and (not fmSimpleTypes.cbxShowInactive.Checked) then
            fmSimpleTypes.cbxShowInactive.Checked:= true;
          fmSimpleTypes.qrySimpleTypes.Locate('Name', Newvalue, [loCaseInsensitive]);
        end;
      end;
    finally
      qry.Free;
    end;
  if Autoclose then
    fmSimpleTypes.close;
  end;
  if assigned(AOwner) then
    if AOwner is TBaseInputGUI then
      fmSimpleTypes.AttachObserver(TBaseInputGUI(AOwner));
end;

class function TfmSimpleTypes.DoSimpleTypesSelect(const aType: string; InLargefont:Boolean =False; AllowNew:Boolean=False): Integer;
var
  form: TfmSimpleTypes;
begin
  result:= 0;
  form:= TfmSimpleTypes.Create(Application);
  form.TypeToShow:= aType;
  form.InLargefont := InLargefont;
  form.cmdNew.enabled :=  AllowNew;
  if AllowNew then form.grdTypes.options := form.grdTypes.options + [dgEditing];
  form.grdTypes.Columnbyname('name').ReadOnly := True;
  if form.ShowModal = mrOk then begin
    REsult := form.KeyId;
  end;
end;

class function TfmSimpleTypes.DoModalSimpleTypesEdit(const aType: string;
  NewValue: String; AOwner: Tcomponent; InLargefont: Boolean) : integer;
var
  fmSimpleTypes: TfmSimpleTypes;

begin
  if CommonLib.FormStillOpen('TfmSimpleTypes') then TForm(FindExistingComponent('TfmSimpleTypes')).Close;
  Application.ProcessMessages;

  fmSimpleTypes := TfmSimpleTypes.Create(Application);
  if Assigned(AOwner) and (AOwner is TForm) then
    fmSimpleTypes.AttachObserver(AOwner);

  fmSimpleTypes.TypeToShow := aType;
  fmSimpleTypes.InLargefont := InLargefont;
  fmSimpleTypes.NewType := NewValue;
  Result := fmSimpleTypes.ShowModal;
  try
    if Result = mrOK then
    begin
      if (not(fmSimpleTypes.qrySimpleTypes.Locate('Name' , Newvalue , [loCaseInsensitive]))) then
        Result := mrCancel
      else
        Result := mrOK;
    end
    else // Result = 0 or result = mrCancel
      Result := mrCancel;
  finally
    fmSimpleTypes.Free;
  end;
end;

class function TfmSimpleTypes.DoSimpleTypesAddNew(const aType,
  aName: string): boolean;
var
  form: TfmSimpleTypes;
  qry: TERPQuery;
begin
  result:= false;
  form:= TfmSimpleTypes.Create(Application);
  form.TypeToShow:= aType;
  form.NewType:= aName;
  if form.ShowModal = mrOk then begin
    qry:= TERPQuery.Create(nil);
    try
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Add('select * from tblsimpletypes where TypeCode = ' + QuotedStr(aType));
      qry.SQL.Add('and Name = ' + QuotedStr(aName));
      qry.SQL.Add('and Active = "T"');
      qry.Open;
      result:= qry.RecordCount > 0;
    finally
      qry.Free;
    end;
  end;
end;

//class procedure TfmSimpleTypes.DoSimpleTypesEditNew(const aType, aName: string);
//var
//  fmSimpleTypes: TfmSimpleTypes;
//begin
//  DoSimpleTypesEdit(aType);
//  fmSimpleTypes := TfmSimpleTypes(GetComponentByClassName('TfmSimpleTypes'));
//  fmSimpleTypes.qrySimpleTypes.Append;
//  fmSimpleTypes.qrySimpleTypes.FieldByName('Name').AsString := aName;
//end;

procedure TfmSimpleTypes.FormCreate(Sender: TObject);
begin
  inherited;
  fNewType:= '';
  lblNote.Caption := '';
  fbCloseonDblclick := True;
end;

procedure TfmSimpleTypes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if MyConnection.InTransaction then MyConnection.Rollback;
  Action := caFree;
end;

procedure TfmSimpleTypes.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      if MyConnection.InTransaction then MyConnection.Rollback;

      MyConnection.StartTransaction;
      RefreshQuery;
      if (SameText(TypeToShow , SimpleTypes_LeadStatusType)) and (Appenv.AccessLevels.GetEmployeeAccessLevel('FnCanCreateSalesStatus') <>    1) then
        Accesslevel := 5
      else begin
        if (NewType <> '') and (TypeToShow <> '') then begin
          if not(qrySimpleTypes.Locate('TypeCode;Name' , VarArrayof([TypeToShow , NewType]) , [loCaseInsensitive])) then begin
            qrySimpleTypes.append;
            qrySimpleTypesTypeCode.AsString:= TypeToShow;
            qrySimpleTypesName.AsString:= NewType;
            qrySimpleTypes.Post;
          end;
        end;
        btnSimpletypeActions.Enabled := Sysutils.SameText(TypeToShow ,SimpleTypes_StatusType);
      end;
      if fbinLargefont and (cbxShowInactive.Checked ) then
        timerMsg(lblNote , 'Inactive '+ TitleLabel.caption+' are shown in Gray');
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmSimpleTypes.grdTypesCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  //
  if fTypetoshow = SimpleTypes_LeadActionType then begin
    if SameText(qrySimpleTypesName.AsString, 'Appointment') or
       SameText(qrySimpleTypesName.AsString, 'Invoice') or
       SameText(qrySimpleTypesName.AsString, 'Quote') or
       SameText(qrySimpleTypesName.AsString, 'SalesOrder') or
       SameText(qrySimpleTypesName.AsString, 'Approved') or
       SameText(qrySimpleTypesName.AsString, 'Not Approved') then
      ABrush.Color := clYellow;
  end;
  if fbinLargefont then
    if qrySimpleTypesActive.asBoolean =False then
      Afont.color := Inactivefontcolor;
end;

procedure TfmSimpleTypes.grdTypesDblClick(Sender: TObject);
begin
  inherited;
  if CloseonDblclick then btnOk.click;
end;

procedure TfmSimpleTypes.mnuToggleDefaultClick(Sender: TObject);
begin
  if not(qrySimpleTypes.State in [dsEdit, dsInsert]) then
    qrySimpleTypes.Edit;
  if qrySimpleTypesIsDefault.AsString = 'T' then
    qrySimpleTypesIsDefault.AsString := 'F'
  else
    qrySimpleTypesIsDefault.AsString := 'T';
    qrySimpleTypes.Post;
end;

procedure TfmSimpleTypes.mnuDeleteClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are You Sure You Want to Delete This Value From the Type?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    PostDb(qrySimpleTypes);
    qrySimpleTypes.Delete;
  end;
end;

procedure TfmSimpleTypes.mnuToggleActiveClick(Sender: TObject);
begin
  if not(qrySimpleTypes.State in [dsEdit, dsInsert]) then
    qrySimpleTypes.Edit;
  if qrySimpleTypesActive.AsString = 'T' then
    qrySimpleTypesActive.AsString := 'F'
  else
    qrySimpleTypesActive.AsString := 'T';
    qrySimpleTypes.Post;
end;

procedure TfmSimpleTypes.RefreshQuery;
begin
  qrySimpleTypes.Close;
  if cbxShowInactive.Checked then qrySimpleTypes.ParamByName('ShowAll').AsString := 'T'
  else qrySimpleTypes.ParamByName('ShowAll').AsString := 'F';
  qrySimpleTypes.ParamByName('Type').AsString := TypeToShow;
  qrySimpleTypes.Open;
end;


procedure TfmSimpleTypes.setInLargefont(const Value: boolean);
begin
  fbinLargefont := Value;
  if not Value then exit;
  (*while grdTypes.Selected.Count>1 do grdTypes.Selected.Delete(1);*)
  qrySimpleTypesDescription.visible := False;
  qrySimpleTypesIsDefault.visible := False;
  grdTypes.font.Size := 30;
  cbxShowInactive.font.Size := 16;
  pnlshowActive.Width := 135;
  btnOk.font.Size     := 18;  btnOk.NumGlyphs     :=0;btnOk.Width     := btnSimpletypeActions.Width;
  cmdnew.font.Size    := 18;  cmdnew.NumGlyphs    :=0;cmdnew.Width    := btnSimpletypeActions.Width;
  btnCancel.font.Size := 18;  btnCancel.NumGlyphs :=0;btnCancel.Width := btnSimpletypeActions.Width;
  btnSimpletypeActions.font.Size := 18;
  Centralisebuttons(pnlbottombuttons);
  grdTypes.Titlefont.Size := 24;
  pnlBottom.Height := 100;
  Self.width := 950;

  grdTypes.selected.Clear;
  grdTypes.selected.add(SelectedText(qrySimpleTypesName.FieldName ,DoTranslate(qrySimpleTypesName.DisplayLabel) ,20 , ''));
  grdTypes.selected.add(SelectedText(qrySimpleTypesDescription.FieldName ,DoTranslate(qrySimpleTypesDescription.DisplayLabel) ,20 , ''));
end;
procedure TfmSimpleTypes.Centralisebuttons(OwnerPanel:TDnMPanel; leftmargin :Integer =0; rightMargin :Integer =0; btngap:Integer=4);
var
    ctr :Integer;
    Procedure Addbutton( button :TDnMspeedButton);
    begin
        if button.visible then begin
            ctr := ctr+1;
            Setlength(Buttons , ctr);
            Buttons[ctr-1] := button.Name;
        end;
    end;
begin
    ctr:= 0;
    Addbutton(btnOk);
    Addbutton(cmdNew);
    Addbutton(btnSimpletypeActions);
    Addbutton(btnCancel);
    inherited Centralisebuttons(OwnerPanel);
    OwnerPanel.paint;
end;
procedure TfmSimpleTypes.btnCancelClick(Sender: TObject);
begin
  inherited;
  Notify(true);
  if fsModal in FormState then
    modalResult := mrCancel
  else
    Close;
end;

procedure TfmSimpleTypes.btnGridClick(Sender: TObject);
begin
  mnuDeleteClick(Sender);
end;

procedure TfmSimpleTypes.btnOkClick(Sender: TObject);
begin
  inherited;
  if qrySimpleTypes.State in [dsInsert, dsEdit] then
    qrySimpleTypes.Post;
  if not ValidateData then
    exit;
  MyConnection.Commit;
  KeyId :=qrySimpleTypesID.asInteger;
  Notify(false);
  if fsModal in FormState then modalresult := mrOK  else Close;
end;

procedure TfmSimpleTypes.cbxShowInactiveClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
  if fbinLargefont and (cbxShowInactive.Checked ) then
        timerMsg(lblNote , 'Inactive '+ TitleLabel.caption+' are shown in Gray');end;

procedure TfmSimpleTypes.cmdNewClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  s:= CustomInputString(TypeToShow, 'New Entry','');
  if s<> '' then
          if not(qrySimpleTypes.Locate('TypeCode;Name' , VarArrayof([TypeToShow , s]) , [loCaseInsensitive])) then begin
            qrySimpleTypes.append;
            qrySimpleTypesTypeCode.AsString:= TypeToShow;
            qrySimpleTypesName.AsString:= s;
            qrySimpleTypes.Post;
          end;
end;

procedure TfmSimpleTypes.qrySimpleTypesBeforePost(DataSet: TDataSet);
begin
  inherited;
  if DataSet.State = dsInsert then begin
    qrySimpleTypesTypeCode.AsString := TypeToShow;
    //qrySimpleTypesIsDefault.AsString:= 'F';
    qrySimpleTypesActive.AsString := 'T';
  end;
end;

procedure TfmSimpleTypes.qrySimpleTypesNameChange(Sender: TField);
var
  ExistingName: string;
begin
  inherited;
  ExistingName := TSimpleTypes.IDToggle(qrySimpleTypesID.AsInteger);
  if ExistingName <> '' then begin
    if not SameText(Sender.AsString,ExistingName) then begin
      CommonLib.MessageDlgXP_Vista('Existing value can not be changed for "' +
        ExistingName + '"',mtInformation,[mbOk],0);
      Sender.AsString := ExistingName;
    end;
  end;
end;

procedure TfmSimpleTypes.SetTypeToShow(const Value: string);
begin
  FTypeToShow := Value;
  TitleLabel.Caption := '';
  TitleLabel.Caption := TSimpleTypes.SimpleTypeTypeDesc(fTypetoshow);
  if fTypetoshow = SimpleTypes_LeadActionType                then begin
    lblNote.Caption := 'NOTE: The highlighted items do not appear as a Telemarketing Action Type.';
    pnlBottom.Height := pnlBottom.Height + 10;
  end;

  Caption := TitleLabel.Caption;
end;

function TfmSimpleTypes.ValidateData: boolean;
var
  bm: TBookmark;
begin
  result:= true;
  qrySimpleTypes.DisableControls;
  bm:= qrySimpleTypes.GetBookmark;
  try
    qrySimpleTypes.First;
    while not qrySimpleTypes.Eof do begin
      if Trim(qrySimpleTypesName.AsString) = '' then begin
        result:= false;
        CommonLib.MessageDlgXP_Vista('Type field must not be blank',mtInformation,[mbOk],0);
        break;
      end;
      qrySimpleTypes.Next;
    end;
  finally
    qrySimpleTypes.GotoBookmark(bm);
    qrySimpleTypes.FreeBookmark(bm);
    qrySimpleTypes.EnableControls;
  end;
end;

procedure TfmSimpleTypes.btnSimpletypeActionsClick(Sender: TObject);
begin
  inherited;
  if qrySimpleTypes.State in [dsInsert, dsEdit] then
    qrySimpleTypes.Post;
  if not ValidateData then
    exit;
  MyConnection.Commit;
  if fsModal in FormState then begin
    TfmSimpleTypeActions.ListSimpleTypeActions(SimpleTypes_StatusType, true);
    MyConnection.StartTransaction;
  end else begin
    TfmSimpleTypeActions.ListSimpleTypeActions(SimpleTypes_StatusType);
    Self.Close;
  end;

end;

initialization
  RegisterClassOnce( TfmSimpleTypes);

end.
