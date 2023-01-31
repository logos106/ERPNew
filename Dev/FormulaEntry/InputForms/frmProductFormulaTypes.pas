unit frmProductFormulaTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusobjProductFormula, wwcheckbox, Mask,
  wwdbedit;

type
  TfmProductFormulaTypes = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    lblProductPrintName: TLabel;
    edtProductPrintName: TwwDBEdit;
    Label1: TLabel;
    chkActive: tdbcheckbox;
    dsformula: TDataSource;
    qryfeformulatypes: TERPQuery;
    qryfeformulatypesFormulaTypeId: TIntegerField;
    qryfeformulatypesGlobalRef: TWideStringField;
    qryfeformulatypesFormulaType: TWideStringField;
    qryfeformulatypesFe1visible: TWideStringField;
    qryfeformulatypesFe2visible: TWideStringField;
    qryfeformulatypesFe3visible: TWideStringField;
    qryfeformulatypesFe4visible: TWideStringField;
    qryfeformulatypesFe5visible: TWideStringField;
    qryfeformulatypesActive: TWideStringField;
    qryfeformulatypesmstimeStamp: TDateTimeField;
    qryfeformulatypesmsupdatesiteCode: TWideStringField;
    pnlFormulaTypeFlags: TDNMPanel;
    pnlFe1: TDNMPanel;
    lblfe1: TLabel;
    chkfe1: tdbcheckbox;
    pnlFe2: TDNMPanel;
    lblfe2: TLabel;
    chkfe2: tdbcheckbox;
    pnlFe3: TDNMPanel;
    lblfe3: TLabel;
    chkfe3: tdbcheckbox;
    pnlFe4: TDNMPanel;
    lblfe4: TLabel;
    chkfe4: tdbcheckbox;
    pnlFe5: TDNMPanel;
    lblfe5: TLabel;
    chkfe5: tdbcheckbox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    FeFormulaTypeObj: TFeFormulaTypes;
    fsFormulatypeLockMsg: String;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function SaveRecord: Boolean;
    Procedure Openrec;
    procedure NewBusObjinstance;
    procedure NewRecord;
    function getEditingFromformula: Boolean;
    procedure SetFormulatypeLockMsg(const Value: String);
    procedure ShowFEFieldsCallback(const Sender: TBusObj; var Abort: boolean);
  Protected
    procedure CommitAndNotify;override;
    procedure SetTransConnection(const Value: TERPConnection); override;
  public
    procedure CancelRec;
    Function SavenCommit:Boolean;
    Property EditingFromformula : Boolean read getEditingFromformula ;
    Property FormulatypeLockMsg :String read fsFormulatypeLockMsg write SetFormulatypeLockMsg;
    procedure RefreshFields(Sender: TObject);
  end;


implementation

uses CommonLib, BusObjConst, AppEnvironment, FormFactory, frmProductformula,
  tcConst;

{$R *.dfm}

procedure TfmProductFormulaTypes.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmProductFormulaTypes.SaveRecord :Boolean;
begin
  result:= False;
  FeFormulaTypeObj.PostDB;
  if not(FeFormulaTypeObj.Save) then exit;
  Result:= True;
end;
function TfmProductFormulaTypes.SavenCommit: Boolean;
begin
  REsult := False;
  if not SaveRecord then exit;
  CommitAndNotify;
  Result := True;
end;

procedure TfmProductFormulaTypes.SetFormulatypeLockMsg(const Value: String);
begin
  fsFormulatypeLockMsg := Value;
  if Assigned(Owner) then
    if Owner is TfmProductFormula then
      TfmProductFormula(Owner).FormulatypeLockMsg := trim(Value);
end;

procedure TfmProductFormulaTypes.SetTransConnection(const Value: TERPConnection);
begin
  inherited;
  SetTransconenctiontoQueries;
end;

procedure TfmProductFormulaTypes.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SavenCommit then exit;
  CloseIt(True);
end;

procedure TfmProductFormulaTypes.cmdNewClick(Sender: TObject);
begin
  inherited;
  // If user does not have access to this form don't process any further
  DisableForm;
  try
    if FeFormulaTypeObj.Dirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if SavenCommit then begin
            end else Exit;
          end;
        mrNo:
          begin
            // Cancel edits and Rollback changes
            RollbackTransaction;
          end;
        mrCancel:
          begin
            Exit;
          end;
      end;
    end;
    KeyID := 0;
    NewRecord;
  finally
    EnableForm;
  end;

end;

procedure TfmProductFormulaTypes.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;

procedure TfmProductFormulaTypes.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TFeFormulaTypes then TFeFormulaTypes(Sender).Dataset  := qryfeformulatypes;
    end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_FormulaType) then begin
      if Assigned(Owner) and (Owner is TfmProductFormula) then begin
          TfmProductFormula(Owner).DoBusinessObjectEvent(Sender,EventType, Value);
      end;
     end;
end;

procedure TfmProductFormulaTypes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := cafree;
end;

procedure TfmProductFormulaTypes.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if FeFormulaTypeObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SavenCommit then begin
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          CancelRec;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;
Procedure TfmProductFormulaTypes.CancelRec;
begin
          RollbackTransaction;
          FeFormulaTypeObj.Dirty := false;

end;
procedure TfmProductFormulaTypes.FormCreate(Sender: TObject);
begin
  inherited;
   NewBusObjinstance;
end;
procedure TfmProductFormulaTypes.FormDestroy(Sender: TObject);
begin
  UnlockRelatedTables;
  inherited;
end;

procedure TfmProductFormulaTypes.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
  RefreshFields(self);
  (*pnlFe1.visible := AppEnv.CompanyPrefs.Fe1Visible;
  pnlFe2.visible := AppEnv.CompanyPrefs.Fe2Visible;
  pnlFe3.visible := AppEnv.CompanyPrefs.Fe3Visible;
  pnlFe4.visible := AppEnv.CompanyPrefs.Fe4Visible;
  pnlFe5.visible := AppEnv.CompanyPrefs.Fe5Visible;

  lblFe1.Caption := AppEnv.CompanyPrefs.Fe1Name;
  lblFe2.Caption := AppEnv.CompanyPrefs.Fe2Name;
  lblFe3.Caption := AppEnv.CompanyPrefs.Fe3Name;
  lblFe4.Caption := AppEnv.CompanyPrefs.Fe4Name;
  lblFe5.Caption := AppEnv.CompanyPrefs.Fe5Name;

  lblFe1.autosize := true;
  lblFe2.autosize := true;
  lblFe3.autosize := true;
  lblFe4.autosize := true;
  lblFe5.autosize := true;

  lblFe1.top := trunc((lblFe1.parent.height - lblFe1.height)/2);
  lblFe2.top := lblFe1.top;
  lblFe3.top := lblFe1.top;
  lblFe4.top := lblFe1.top;
  lblFe5.top := lblFe1.top;

  chkFe1.Left := 3;
  chkFe2.Left := 3;
  chkFe3.Left := 3;
  chkFe4.Left := 3;
  chkFe5.Left := 3;


  lblFe1.left := chkFe1.left + chkFe1.width +3;
  lblFe2.left := chkFe2.left + chkFe2.width +3;
  lblFe3.left := chkFe3.left + chkFe3.width +3;
  lblFe4.left := chkFe4.left + chkFe4.width +3;
  lblFe5.left := chkFe5.left + chkFe5.width +3;

  chkFe1.Caption := '';
  chkFe2.Caption := '';
  chkFe3.Caption := '';
  chkFe4.Caption := '';
  chkFe5.Caption := '';

  chkFe1.top := lblFe1.top;
  chkFe2.top := lblFe2.top;
  chkFe3.top := lblFe3.top;
  chkFe4.top := lblFe4.top;
  chkFe5.top := lblFe5.top;*)
end;

function TfmProductFormulaTypes.getEditingFromformula: Boolean;
begin
  result := false;
  if Assigned(Owner) then
    if Owner is TfmProductFormula then
      Result := True;
end;

procedure TfmProductFormulaTypes.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  FeFormulaTypeObj := TFeFormulaTypes.CreateWithNewConn(Self);
  FeFormulaTypeObj.Connection.connection := Self.MyConnection;
  FeFormulaTypeObj.BusObjEvent := DoBusinessObjectEvent;
  {$WARNINGS ON}
end;

procedure TfmProductFormulaTypes.NewRecord;
begin
    CloseQueries;
    KeyID:= 0;
    NewBusObjinstance;
    AccessLevel:= AppEnv.AccessLevels.GetEmployeeAccessLevel(Self.ClassName);
    self.BeginTransaction;
    OpenRec;
    Caption:= TitleLabel.Caption + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
    Setcontrolfocus(edtProductPrintName);
    //Setcontrolfocus(edtName);
end;

procedure TfmProductFormulaTypes.Openrec;
var
  s:String;
begin
  FeFormulaTypeObj.Load(KeyID);
  BeginTransaction;//FeFormulaTypeObj.connection.BeginTransaction;
  if FeFormulaTypeObj.count=0 then FeFormulaTypeObj.new;
  openQueries;
  s:= '';
  FeFormulaTypeObj.Dirty := false;
    if KeyID<> 0 then
      if not FeFormulaTypeObj.LockInUse then begin
        if not EditingFromformula then begin
            AccessLevel := 5; // read only
          CommonLib.MessageDlgXP_Vista(FeFormulaTypeObj.UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.', mtWarning, [mbOK], 0);
        end else s:=FeFormulaTypeObj.UserLock.LockMessage+NL+'So, It is not possible to Change the Field''s Visibility.';
      end;
  FormulatypeLockMsg := s;
end;


procedure TfmProductFormulaTypes.RefreshFields(Sender: TObject);
var
  FormulaEntry : TFormulaEntry;
begin
    FormulaEntry := TFormulaEntry.create(Self);
    try
      FormulaEntry.connection := FeFormulaTypeObj.connection;
      FormulaEntry.BusObjEvent := DoBusinessObjectEvent;
      FormulaEntry.SQLOrder := 'FieldOrderno';
      FormulaEntry.Load;
      FormulaEntry.IterateRecordsReverse(ShowFEFieldsCallback);
    finally
      freeandnil(FormulaEntry);
    end;
end;
Procedure TfmProductFormulaTypes.ShowFEFieldsCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if sender is TFormulaEntry then begin
             if TFormulaEntry(Sender).FormulaEntryNo = 1 then begin  lblFe1.caption := AppEnv.CompanyPrefs.Fe1Name;pnlFe1.Visible := AppEnv.CompanyPrefs.Fe1Visible;chkfe1.left := 3;chkfe1.top := 26;pnlFe1.left:= 0;
    end else if TFormulaEntry(Sender).FormulaEntryNo = 2 then begin  lblFe2.caption := AppEnv.CompanyPrefs.Fe2Name;pnlFe2.Visible := AppEnv.CompanyPrefs.Fe2Visible;chkfe2.left := 3;chkfe2.top := 26;pnlFe2.left:= 0;
    end else if TFormulaEntry(Sender).FormulaEntryNo = 3 then begin  lblFe3.caption := AppEnv.CompanyPrefs.Fe3Name;pnlFe3.Visible := AppEnv.CompanyPrefs.Fe3Visible;chkfe3.left := 3;chkfe3.top := 26;pnlFe3.left:= 0;
    end else if TFormulaEntry(Sender).FormulaEntryNo = 4 then begin  lblFe4.caption := AppEnv.CompanyPrefs.Fe4Name;pnlFe4.Visible := AppEnv.CompanyPrefs.Fe4Visible;chkfe4.left := 3;chkfe4.top := 26;pnlFe4.left:= 0;
    end else if TFormulaEntry(Sender).FormulaEntryNo = 5 then begin  lblFe5.caption := AppEnv.CompanyPrefs.Fe5Name;pnlFe5.Visible := AppEnv.CompanyPrefs.Fe5Visible;chkfe5.left := 3;chkfe5.top := 26;pnlFe5.left:= 0;
    end;
  end;
end;

initialization
  RegisterClassOnce(TfmProductFormulaTypes);
  with FormFact do  begin
    RegisterMe(TfmProductFormulaTypes, 'TProductformulaTypeListGUI_*=FormulaTypeId');
  end;
end.

