unit frmAccessLevels;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/08/06  1.00.01 DSP  Moved functionality from frmAccessLevelsfrm to here.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMPanel, DNMSpeedButton,
  Grids, Mask, wwdbedit, Wwdotdot, Wwdbcomb, StdCtrls, wwdblook, ImgList,
  GraphUtil, Shader, MemDS, wwcheckbox, ProgressDialog;

type
  TAccessLevelsGUI = class(TBaseInputGUI)
    Bevel1: TBevel;
    btnUndo: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    sbButtons: TScrollBox;
    pnlButtons: TDNMPanel;
    ImageList: TImageList;
    Label1: TLabel;
    cboEmployee: TwwDBLookupCombo;
    Label2: TLabel;
    cboCopyFrom: TwwDBLookupCombo;
    Label3: TLabel;
    cboDefaultOption: TwwDBComboBox;
    qryForms: TERPQuery;
    qryEmployeeFormsAccess: TERPQuery;
    qryEmployee: TERPQuery;
    qryEmployeeCopyFrom: TERPQuery;
    qryEmployeeFormsAccessRead: TERPQuery;
    Shader1: TShader;
    pnlActiveAccessLevel: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkAll: TwwCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    edtSearch: TEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    DNMPanel1: TDNMPanel;
    grdAccessLevels: TDrawGrid;
    lblMsg: TLabel;
    cmdExport: TDNMSpeedButton;
    procedure grdAccessLevelsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnUndoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdAccessLevelsDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboDefaultOptionCloseUp(Sender: TwwDBComboBox;
      Select: Boolean);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboCopyFromCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmdExportClick(Sender: TObject);
  private
    fDataChanged: Boolean;
    CurrentEmployeeID: Integer;
    CurrentEmployeeIDWrite: Integer;
    CurrentGroup: integer;
    ButtonCtr:Integer;
    Selectedbutton:TObject;
    procedure AddMainButtons;
    procedure MainButtonClick(Sender: TObject);
    function FilterForms(const Group: Integer): Integer;
    function FindMainButton(const Caption: string): TDNMSpeedButton;
    function GotoFormsRecNo(const RecNo: Integer): Boolean;
    function GetFormsDescription: string;
    function GetAccessLevel(const UserID, FormID: Integer): Integer;
    procedure FetchAccessLevelsRead(const UserID: Integer);
    function GetFormsFormID: Integer;
    function GetCaptionIndex(const Caption: string): Integer;
    procedure SetAccessLevel(UserID, FormID, Access: Integer);
    procedure FetchAccessLevels(const UserID: Integer);
    procedure CreateAccessLevel(UserID, FormID, Access: Integer);
    Function UserWithFullAccess(FormId :Integer; userID :Integer):Integer;
    procedure GoSearch(const SearchMode: String);
    function buttoncaption(const Tabgroup: Integer): String;
    function SaveData: Boolean;
    procedure initAccessLevelsList(Sender: TObject);
    (*procedure highLightentry(Description: String);*)
  Protected

  public
    Procedure AfterTranslate; Override;
    { Public declarations }
  end;

implementation

uses
  DNMExceptions, CommonLib,  AuditObj, MAIN,
  MainSwitchFrm2, CommonDbLib, AppEnvironment, FastFuncs, tcDataUtils,
  frmMessageWithList, DNMLib, frmMessageBase, AccessLevelUtils, CommonFormLib,
  AccessLevelsList;

const
  cMainButtonWidth = 148;
  cMainButtonHeight = 28;
  cMainButtonGap = 1;
  cMainButtonLeft = 7;

{$R *.dfm}

procedure RefreshGrid;
begin
  with TAccessLevelsGUI(FindExistingComponent('TAccessLevelsGUI')) do  begin
    grdAccessLevels.Visible := false;
    grdAccessLevels.Visible := true;
   // grdAccessLevels.Update;
    grdAccessLevels.Repaint;
  end;
end;

procedure TAccessLevelsGUI.AddMainButtons;
var
  ButtonTop: Integer;
  Button: TDNMSpeedButton;
  ButtonIndex: Integer;
begin
  ButtonTop := 5;

  for ButtonIndex := 1 to AccessGroupCount do begin
    if (not SameText(ERPAccessGroups[ButtonIndex].Name, 'Dummy')) and
       (not SameText(ERPAccessGroups[ButtonIndex].Name, 'MainBackground')) then begin

      {Exclude Due To Prefs}

//      If not AppEnv.CompanyPrefs.UseAssessment then
//        if Sysutils.SameText(cButtonCaptions[ButtonIndex], 'Assessment') then
//          Continue;

      If not AppEnv.CompanyPrefs.UseBudget then
        if Sysutils.SameText(ERPAccessGroups[ButtonIndex].Name, 'Budget') then
          Continue;

      If not AppEnv.CompanyPrefs.UseHire then
        if Sysutils.SameText(ERPAccessGroups[ButtonIndex].Name, 'Hire') then
          Continue;

      If not AppEnv.CompanyPrefs.UseCRM then
        if Sysutils.SameText(ERPAccessGroups[ButtonIndex].Name, 'CRM / Marketing') then
          Continue;

      If not AppEnv.CompanyPrefs.UseDelivery then
        if Sysutils.SameText(ERPAccessGroups[ButtonIndex].Name, 'Delivery') then
          Continue;

      If not AppEnv.CompanyPrefs.UseFixedAssets then
        if Sysutils.SameText(ERPAccessGroups[ButtonIndex].Name, 'Fixed Assets') then
          Continue;

      If not AppEnv.CompanyPrefs.UseManufacturing then
        if Sysutils.SameText(ERPAccessGroups[ButtonIndex].Name, 'Manufacturing') then
          Continue;

      If not AppEnv.CompanyPrefs.UsePayroll then
        if Sysutils.SameText(ERPAccessGroups[ButtonIndex].Name, 'Payroll') then
          Continue;

      If not AppEnv.CompanyPrefs.UsePriceSchemes then
        if Sysutils.SameText(ERPAccessGroups[ButtonIndex].Name, 'PriceSchemes') then
          Continue;

      (*If not(GoogleModuleInstalled) or  not(AppEnv.CompanyPrefs.GoogleAnalyticsEnabled) then*)
      If not(AppEnv.CompanyPrefs.UseGoogleAnalytics) then
        if Sysutils.SameText(ERPAccessGroups[ButtonIndex].Name, 'Google') then
          Continue;

      {####################}

      Button := TDNMSpeedButton.Create(Self);
      with Button do begin
        Left := cMainButtonLeft;
        Top := ButtonTop;
        Width := cMainButtonWidth;
        Height := cMainButtonHeight;
        Caption := ERPAccessGroups[ButtonIndex].Name;
        Parent := pnlButtons;
        Alignment := taCenter;
        Color := clWhite;
        HotTrackColor := clBtnShadow;
        SlowDecease := True;
        Style := bsModern;
        inc(ButtonCtr);
        name := 'mainbutton'+inttostr(ButtonCtr);
        OnClick := MainButtonClick;
      end;

      ButtonTop := ButtonTop + cMainButtonHeight + cMainButtonGap;
    end;
  end;
  If ButtonTop > pnlButtons.Height then
     pnlButtons.Height := ButtonTop;

end;

procedure TAccessLevelsGUI.grdAccessLevelsDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Access: integer;
  t: integer;

  procedure DrawIcon(Exp: integer);
  var
    t, l: integer;
  begin
    l := (Rect.Right - Rect.Left - ImageList.Width) div 2;
    t := (Rect.Bottom - Rect.Top - ImageList.Height) div 2;
    // draw nothing if exp < 0
    if Exp = 0 then // draw Clover
      ImageList.Draw(TDrawGrid(Sender).Canvas, Rect.Left + l, Rect.Top + t, 1, true)
    else if Exp > 0 then // draw Prohibited
      ImageList.Draw(TDrawGrid(Sender).Canvas, Rect.Left + l, Rect.Top + t, 0, true);
  end;

  procedure TextCentered(const s: string);
  var
    t, l: integer;
  begin
    with TDrawGrid(Sender).Canvas do begin
      l := (Rect.Right - Rect.Left - TextWidth(s)) div 2;
      t := (Rect.Bottom - Rect.Top - TextHeight(s)) div 2;
      TextRect(Rect, Rect.Left + l, Rect.Top + t, s);
    end;
  end;
begin
  if Accesslevel <> 1 then Exit;
  with TDrawGrid(Sender).Canvas do begin
    Brush.Color := TDrawGrid(Sender).Color;
    Rectangle(Rect);

    if ARow = 0 then begin
      Font.Style := [fsbold];
      Font.Size := 9;
      Font.name := 'Arial';

      case ACol of
        0:
          begin
          end;
        1: TextCentered(DoTranslate('No Access'));
        2: TextCentered(DoTranslate('Read Only'));
        3: TextCentered(DoTranslate('Create & Read'));
        4: TextCentered(DoTranslate('Full without Delete'));
        5: TextCentered(DoTranslate('Full with Delete'));
      end
    end
    else begin
      t := (Rect.Bottom - Rect.Top - TextHeight('^g')) div 2;
      gotoFormsRecNo(ARow);

      if (ACol = 0) then begin
        Font.Style := [];
        Font.Size := 9;
        Font.name := 'Arial';
        TextRect(Rect, Rect.Left + 4, Rect.Top + t, Dotranslate(getFormsDescription));
      end
      else begin
        if qryEmployee.active then Access := GetAccessLevel(qryEmployee.FieldByName('EmployeeID').AsInteger, GetFormsFormID)
        else Access := 6;

        if Access >= 0 then begin
          case ACol of
            1: DrawIcon(Access - 6);
            2: DrawIcon(Access - 5);
            3: DrawIcon(Access - 3);
            4: DrawIcon(Access - 2);
            5: DrawIcon(Access - 1);
          end;
        end;
      end;
    end;
  end;
end;

procedure TAccessLevelsGUI.MainButtonClick(Sender: TObject);
var
  RecordCount: Integer;
  CaptionIndex: integer;
begin
  if Sender is TDNMSpeedButton then begin
    CaptionIndex := GetCaptionIndex(EnglishCaption(TDNMSpeedButton(Sender)));
    CurrentGroup:= ERPAccessGroups[CaptionIndex].Id;

    if CaptionIndex > 0 then begin
      Selectedbutton:= sender;
      pnlActiveAccessLevel.Caption := EnglishCaption(TDNMSpeedButton(Sender));
      RecordCount := FilterForms(ERPAccessGroups[CaptionIndex].Id);
      grdAccessLevels.RowCount := RecordCount + 1;
      grdAccessLevels.Refresh;
    end;
  end;
end;

function TAccessLevelsGUI.FilterForms(const Group: Integer): Integer;
begin
  if qryForms.Active then
    qryForms.Close;

  qryForms.SQL.Clear;

  if Group > 0 then
    qryForms.SQL.Add('SELECT FormID, FormName, Description from tblForms WHERE TabGroup = ' +
                     IntToStr(Group) + ' AND AccessLevels = ''T'' ORDER BY Description')
  else
    qryForms.SQL.Add('SELECT FormID, FormName, Description from tblForms ' +
                  'WHERE AccessLevels = ''T''  ORDER BY Description');

  qryForms.Open;
  Result := qryForms.RecordCount;
end;

procedure TAccessLevelsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Selectedbutton:=nil;
  CurrentGroup:= 0;
  fDataChanged := False;
  AddMainButtons;
  pnlButtons.Color := Self.color; //ColorAdjustLuma(GetGradientColor(Self.ClassName).Color, GetGradientColor(Self.ClassName).AdjLuma div 2, False);
  (*Shader1.FromColor := GetGradientColor(Self.ClassName).Color;
  Shader1.ToColorMirror := Shader1.FromColor;
  Self.Color := pnlButtons.Color;*)
  ButtonCtr:= 0;
end;

procedure TAccessLevelsGUI.FormShow(Sender: TObject);
var
  MainButton: TDNMSpeedButton;
begin
  DisableForm;
  try
    try
      if AccessLevel <> 1 then begin
        AccessLevel := 6   // all or none!!!
      end;

      inherited;  // among other things, access levels to this form are checked here

      qryEmployee.Open;
      qryEmployeeCopyFrom.Open;
      CurrentEmployeeID := -1;
      MainButton := FindMainButton('Sales');

      if Assigned(MainButton) then
        MainButton.Click;

      if qryEmployee.Active then begin
        qryEmployee.Locate('EmployeeID', AppEnv.Employee.EmployeeID, [loCaseInsensitive]);
        cboEmployee.Text := qryEmployee.FieldByName('Employee Names').AsString;
  //      TabCtlChange(Sender);
      end;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;    
end;

function TAccessLevelsGUI.FindMainButton(const Caption: string): TDNMSpeedButton;
var
  Index: Integer;
  FoundButton: Boolean;
begin
  Index := 0;
  Result := nil;
  FoundButton := False;

  while (Index < ComponentCount) and (not FoundButton) do begin
    if (Components[Index] is TDNMSpeedButton) and (TDNMSpeedButton(Components[Index]).Caption = Caption) then begin
      Result := TDNMSpeedButton(Components[Index]);
      FoundButton := True;
    end
    else
      Inc(Index);
  end;
end;

function TAccessLevelsGUI.GotoFormsRecNo(const RecNo: Integer): Boolean;
begin
  Result := (RecNo > 0) and (RecNo <= qryForms.RecordCount);

  if Result then begin
    qryForms.RecNo := RecNo;
  end;
end;

function TAccessLevelsGUI.GetFormsDescription: string;
begin
  Result := '';

  if qryForms.RecordCount > 0 then
    Result := qryForms.FieldByName('Description').AsString;
end;

function TAccessLevelsGUI.GetAccessLevel(const UserID, FormID: Integer): Integer;
begin
  Result := -1;
  FetchAccessLevelsRead(UserID);

  with qryEmployeeFormsAccessRead do begin
    if active then
      if Locate('FormID', formID, []) then
        Result := FieldByName('Access').AsInteger;
  end;
end;

procedure TAccessLevelsGUI.FetchAccessLevelsRead(const UserID: Integer);
begin
  if (CurrentEmployeeID <> UserID) or (qryEmployeeFormsAccessRead.active =False) then begin
     with qryEmployeeFormsAccessRead do begin
       Close;
       SQL.Text := (Format('SELECT FormID, EmployeeID, Access, EditedFlag ' + 'FROM tblEmployeeFormsAccess ' +
                            'WHERE EmployeeID = %1d', [UserID]));
       Open;
       CurrentEmployeeID := UserID;
    end;
  end;
end;

function TAccessLevelsGUI.GetFormsFormID: Integer;
begin
  Result := -1;

  if qryForms.RecordCount > 0 then
    Result := qryForms.FieldByName('FormID').AsInteger;
end;

function TAccessLevelsGUI.GetCaptionIndex(const Caption: string): Integer;
var
  Index: Integer;
  FoundCaption: Boolean;
begin
  Result := 0;
  Index := 1;
  FoundCaption := False;

  while (Index <= AccessGroupCount) and (not FoundCaption) do begin
    if ERPAccessGroups[Index].Name = Caption then begin
      Result := Index;
      FoundCaption := True
    end
    else
      Inc(Index);
  end;
end;


procedure TAccessLevelsGUI.AfterTranslate;
begin
  inherited;
  if assigned(Selectedbutton) then
    if Selectedbutton is TDNMSpeedButton then
      pnlActiveAccessLevel.caption := TDNMSpeedButton(Selectedbutton).caption;

end;

procedure TAccessLevelsGUI.btnSaveClick(Sender: TObject);
begin
  DisableForm;
  try
    if SaveData then begin
      Close;
      inherited;
    end;
  finally
    EnableForm;
  end;
end;

Function TAccessLevelsGUI.SaveData:Boolean;
begin
  Result := False;
  DisableForm;
  try
    try
      CommitTransaction;
      REsult := True;
    except
      on e: Exception do begin
        Audit.AddEntry(e, Self);
        raise Exception.Create(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName);
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TAccessLevelsGUI.btnUndoClick(Sender: TObject);
begin
  inherited;

  try
    qryEmployeeFormsAccessRead.Close;
    qryEmployeeFormsAccess.Close;
    qryForms.Close;
    RollbackTransaction;
    Close;
  except
    on e: Exception do begin
      Audit.AddEntry(e, Self);
      raise Exception.Create(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName);
    end;
  end;
end;

procedure TAccessLevelsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if qryEmployeeFormsAccess.State = dsEdit then
    qryEmployeeFormsAccess.Post;

  qryEmployee.Close;
  qryEmployeeCopyFrom.Close;
  qryEmployeeFormsAccess.Close;
  qryForms.Close;
  {reload the main menus & refresh switch}

  if fDataChanged then begin
      MainForm.WindowState := wsMinimized;
      Try
        Self.FormStyle := fsNormal;
        Self.Visible := False;
        MainForm.AddinPackagesMenu;
        Mainform.ReloadToolbarButtons;
        MainSwitch2.AddMainButtons(Sender);
      finally
        MainForm.WindowState := wsMaximized;
      end;
  end;
  inherited;
  Action := caFree;
end;

procedure TAccessLevelsGUI.SetAccessLevel(UserID, FormID, Access: Integer);
begin
  BeginTransaction;
  FetchAccessLevels(UserID);

  with qryEmployeeFormsAccess do try
      if (Access > 6) or (Access < 1) then
        Access := 6;

      if Locate('FormID', formID, []) then begin
        Edit;
        FieldByName('Access').AsInteger := Access;
        FieldByName('EditedFlag').AsString := 'T';

        Post;
      end
      else
        CreateAccessLevel(UserID, FormID, Access);

      fDataChanged := True;
    except
      on e: Exception do begin
        RollbackTransaction;
        Audit.AddEntry(e, Self);
        raise Exception.Create(e.message + '###' + IntToStr(userID) + '###' + IntToStr(formID) + '###' + IntToStr(Access));
      end;
    end;
end;

procedure TAccessLevelsGUI.grdAccessLevelsDblClick(Sender: TObject);
var
  OldAccess, Access, UserID, FormID: integer;
  x:Integer;
  strMsg :STring;
begin
  inherited;
  Access := 0;

  if (TDrawGrid(Sender).Col > 0) and (TDrawGrid(Sender).Row > 0) then begin
    case TDrawGrid(Sender).Col of
      1, 2: Access := 7 - TDrawGrid(Sender).Col;
      3, 4, 5: Access := 6 - TDrawGrid(Sender).Col;
    end;

    GotoFormsRecNo(TDrawGrid(Sender).Row);
    UserID := qryEmployee.FieldByName('EmployeeID').AsInteger;
    FormID := GetFormsFormID;
    OldAccess := GetAccessLevel(UserID, FormID);
    if (formID = GetAccessLevelsFormID(Self.Classname)) and
        (OldAccess<= 1) and ( Access > oldAccess) then begin
        if UserWithFullAccess(formID, userID) = 0 then begin
            strMsg := 'You are the only user with full access to access level forms. Its not possible to change it.';
            if AppEnv.Employee.EmployeeID = userId then
            else
                strMSg :=  StringReplace(strMsg , 'You are', qryEmployee.FieldByName('Employee Names').AsString +' is', [rfIgnoreCase]);
            CommonLib.MessageDlgXP_Vista(strMsg , mtInformation , [mbOK], 0);
            x := Access;
            Access := oldAccess;
            OldAccess := x;

        end;
    end;

    if OldAccess = Access then
      SetAccessLevel(UserID, FormID, 0)
    else
      SetAccessLevel(UserID, FormID, Access);

    CurrentEmployeeID := 0;
    TDrawGrid(Sender).Repaint;;
  end;
end;
Function TAccessLevelsGUI.UserWithFullAccess(FormId :Integer; UserID :Integer):Integer;
begin
    REsult := 0;
    with TERPQuery.Create(nil) do try
      Connection := CommonDbLib.GetSharedMyDacConnection;
      Sql.Add('SELECT EmployeeID ' +
        'FROM tblEmployeeFormsAccess ' +
        'WHERE  Access = 1 and EmployeeID <> ' + IntToStr(UserID) + ' and FormID = ' + IntToStr(FormID) );
      Open;
      if not IsEmpty then begin
        Result := FieldByName('employeeID').AsInteger;
      end;
    finally
      Free;
    end;
end;
procedure TAccessLevelsGUI.FetchAccessLevels(const UserID: Integer);
begin
  if CurrentEmployeeIDWrite <> UserID then begin
    with qryEmployeeFormsAccess do begin
      Close;
      SQL.Text := (Format('SELECT FormID, EmployeeID, Access, EditedFlag ' + 'FROM tblEmployeeFormsAccess ' +
                          'WHERE EmployeeID = %1d', [userID]));
      Open;
//      Properties['Update Criteria'].Value := adCriteriaKey;
      CurrentEmployeeIDWrite := UserID;
    end;  
  end;
end;

procedure TAccessLevelsGUI.CreateAccessLevel(UserID, FormID, Access: Integer);
begin
  BeginTransaction;
  FetchAccessLevels(UserID);

  with qryEmployeeFormsAccess do begin
    try
      Insert;
      FieldByName('EmployeeID').AsInteger := userID;
      FieldByName('FormID').AsInteger := formID;
      FieldByName('Access').AsInteger := Access;
      FieldByName('EditedFlag').AsString := 'T';
      Post;
    except
      on e: Exception do begin
        RollbackTransaction;
        Audit.AddEntry(e, Self);
        raise Exception.Create(e.message);
      end;
    end;
  end;  
end;

procedure TAccessLevelsGUI.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ThisKey: Char;
  MainButton: TDNMSpeedButton;
begin
  inherited;
  ThisKey := Chr(Key);

  if Shift = [ssCtrl] then begin
    if ThisKey = 'A' then begin
      Key := 0;
      MainButton := FindMainButton('Appointments');

      if Assigned(MainButton) then
        MainButton.Click;

      Exit;
    end
    else if ThisKey = 'S' then begin
      Key := 0;
      MainButton := FindMainButton('Sales');

      if Assigned(MainButton) then
        MainButton.Click;

      Exit;
    end
    else if ThisKey = 'O' then begin
      Key := 0;
      MainButton := FindMainButton('POS');

      if Assigned(MainButton) then
        MainButton.Click;

      Exit;
    end
    else if ThisKey = 'P' then begin
      Key := 0;
      MainButton := FindMainButton('Purchases');

      if Assigned(MainButton) then
        MainButton.Click;

      Exit;
    end
    else if ThisKey = 'I' then begin
      Key := 0;
      MainButton := FindMainButton('Inventory');

      if Assigned(MainButton) then
        MainButton.Click;

      Exit;
    end
    else if ThisKey = 'Y' then begin
      Key := 0;
      MainButton := FindMainButton('Payments');

      if Assigned(MainButton) then
        MainButton.Click;

      Exit;
    end
    else if ThisKey = 'E' then begin
      Key := 0;
      MainButton := FindMainButton('Employee');

      if Assigned(MainButton) then
        MainButton.Click;

      Exit;
    end
    else if ThisKey = 'C' then begin
      Key := 0;
      MainButton := FindMainButton('Accounts');

      if Assigned(MainButton) then
        MainButton.Click;

      Exit;
    end
    else if ThisKey = 'U' then begin
      Key := 0;
      MainButton := FindMainButton('Utilities');

      if Assigned(MainButton) then
        MainButton.Click;

      Exit;
    end
    else if ThisKey = 'L' then begin
      Key := 0;
      MainButton := FindMainButton('Payroll');

      if Assigned(MainButton) then
        MainButton.Click;

      Exit;
    end;
  end;
end;
procedure TAccessLevelsGUI.GoSearch(const SearchMode:String);
var
  tabGroup :Integer;
  Description:String;
  btn: TDNMSpeedButton;
  Qry :TErpQuery;
  Function Searchmodedesc :String;
  begin
    result := '';
           if SearchMode = 'F5' then result := ' Equals '
      else if SearchMode = 'F6' then result := 'Starts With '
      else if SearchMode = 'F7' then result := ' Contains ';
  end;

begin
  Qry := TEmpMyQuery;
  try
    With Qry do begin
      SQL.Add('Select * from tblForms Where AccessLevels = "T" and ' );
           if SearchMode = 'F5' then SQL.Add('description = ' +quotedstr(edtSearch.text))
      else if SearchMode = 'F6' then SQL.Add('description like ' +quotedstr(edtSearch.text+'%'))
      else if SearchMode = 'F7' then SQL.Add('description like ' +quotedstr('%'+edtSearch.text+'%'))
      else exit;
      open;
      if recordcount =0 then begin
        TimerMsg(lblMsg ,'Entries ' +Searchmodedesc+' :' + Quotedstr(edtSearch.Text) +' not found.');
        exit;
      end;
      TabGroup := Fieldbyname('TabGroup').asInteger;
      Description := fieldbyname('Description').AsString;
      if recordcount >1 then begin
        TimerMsg(lblMsg ,'Entries ' +Searchmodedesc+' :' + Quotedstr(edtSearch.Text) +' is in few pages as listed here.');
        InitMsgParams;
        PopupMsgParams.Msgcaption  := 'Search Result' ;
        PopupMsgParams.Msgds := qry;
        PopupMsgParams.fieldnames  := 'Description,skinsgroup';
        PopupMsgParams.displayLabels := 'Name,Page';
        PopupMsgParams.Custombuttons  :='Ok';
        PopupMsgParams.Msg1:= 'Entries ' +Searchmodedesc+' :' + Quotedstr(edtSearch.Text);
        TfmMessageWithList.MsgDlg;
      end else begin
        TimerMsg(lblMsg ,'Entries ' +Searchmodedesc+' :' + Quotedstr(edtSearch.Text) +' is in ' + Buttoncaption(TabGroup) +' page.' );
      end;
    end;
  finally
    Qry.closenFree;
  end;
  btn:= FindMainButton(Buttoncaption(TabGroup));
  if assigned(btn) then begin
      SetcontrolFocus(btn);
      MainButtonClick(btn);
  end;
end;
function TAccessLevelsGui.Buttoncaption(const Tabgroup:Integer):String;
var
  ctr:Integer;
begin
  REsult := '';
  for ctr := low(ERPAccessGroups) to high(ERPAccessGroups) do
    if ERPAccessGroups[ctr].Id = TabGroup then begin
      REsult :=  ERPAccessGroups[ctr].Name;
      Exit;
    end;

end;

procedure TAccessLevelsGUI.FormKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  inherited;
    if (edtSearch.Focused) and (Key = VK_RETURN) then begin
      GoSearch('F6' );
    end else if (Key = VK_F7)  then begin
      GoSearch('F7' );
    end else if (Key = VK_F6)  then begin
      GoSearch('F6' );
    end else if (Key = VK_F5) then begin
      GoSearch('F5' );
    end;
end;

procedure TAccessLevelsGUI.cboDefaultOptionCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
var
  UserID, Access, formsCount, i, formID: integer;
  bOK: boolean;
  PersonalPrefsFormID:integer;
  PrefsFormID:integer;
begin
  inherited;
  bOK := true;
  Access := cboDefaultOption.ItemIndex + 1;

  case Access of
    1, 2, 3:;
    4, 5: Access := Access + 1;
    else bOK := False;
  end;

  if bOK then begin
    Processingcursor(True);
    PersonalPrefsFormID := AppEnv.AccessLevels.GetFormID('FnPersonalPref');
    PrefsFormID := AppEnv.AccessLevels.GetFormID('TPreferencesGUI');
    try
      UserID := qryEmployee.FieldByName('EmployeeID').AsInteger;
      if chkAll.Checked then
        FormsCount := FilterForms(0)    //fetch all forms
      else begin
        if CurrentGroup > 0 then
          FormsCount := FilterForms(CurrentGroup)
        else
          exit;
      end;

      for i := 1 to formsCount do begin
        if not gotoFormsRecNo(i) then
          CommonLib.MessageDlgXP_Vista('frmAccessLevels: goto had no nowhere to go to: ' + IntToStr(i), mtInformation , [mbOK], 0);

        FormId:= GetFormsFormID;

        if (FormID <> PersonalPrefsFormID) and (FormID <> PrefsFormID) then //personal prefs can only be set to full access
          SetAccessLevel(UserID, FormID, Access)
        else
          if Access = 1 then SetAccessLevel(UserID, FormID, Access);
      end;

      CurrentEmployeeID := 0;
      RefreshGrid;
//      TabCtlChange(Sender);   // refresh face
    finally
      Processingcursor(False);
    end;
  end;
end;

procedure TAccessLevelsGUI.cboEmployeeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if Modified = false then Exit;
  inherited;
  CommitTransaction;
  grdAccessLevels.Refresh;
  SetControlFocus(cboCopyFrom);
end;

procedure TAccessLevelsGUI.cmdExportClick(Sender: TObject);
begin
  inherited;
  if not SaveData then exit;
  OpenERPListForm('TAccessLevelsListGUI' , initAccessLevelsList);
  CloseWait;
end;
procedure TAccessLevelsGUI.initAccessLevelsList(Sender:TObject);
begin
  if not(Sender is TAccessLevelsListGUI) then exit;
  TAccessLevelsListGUI(Sender).EmployeeId := qryEmployee.FieldByName('EmployeeID').AsInteger ;
  if TAccessLevelsListGUI(Sender).SelectedEmployeeId  =0 then TAccessLevelsListGUI(Sender).EmployeeId := AppEnv.Employee.EmployeeID ;
end;
procedure TAccessLevelsGUI.cboCopyFromCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
var
  CopyFromID, UserID, Access, formsCount, formID, i: integer;
begin
  if Modified = false then Exit;
  Processingcursor(True);
  try
    inherited;
    CopyFromID := qryEmployeeCopyFrom.FieldByName('EmployeeID').AsInteger;

    if CopyFromID >= 1 then begin
      UserID := qryEmployee.FieldByName('EmployeeID').AsInteger;
      FormsCount := FilterForms(0);    //fetch all forms

      for i := 1 to FormsCount do begin
        if not GotoFormsRecNo(i) then
          CommonLib.MessageDlgXP_Vista('frmAccessLevels: goto had no nowhere to go to: ' + IntToStr(i), mtInformation , [mbOK], 0);

        FormID := GetFormsFormID;
        Access := GetAccessLevel(CopyFromID, formID);
        SetAccessLevel(UserID, formID, Access);
      end;
      grdAccessLevels.Refresh;
//      TabCtlChange(Sender);   // refresh face
    end;
  finally
    Processingcursor(False);
  end;
end;

initialization
  RegisterClassOnce(TAccessLevelsGUI);
finalization
  UnRegisterClass(TAccessLevelsGUI);
end.
