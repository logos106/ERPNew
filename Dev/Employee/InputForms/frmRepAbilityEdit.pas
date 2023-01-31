unit frmRepAbilityEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImgList, Menus, AdvMenus, DataState, DB,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, MemDS, StdCtrls,
  Shader, wwcheckbox, DNMSpeedButton, DNMPanel, ActnList, Mask, wwdbedit;

type
  TfmRepAbilityEdit = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryAbility: TERPQuery;
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actNew: TAction;
    qryAbilityGlobalRef: TWideStringField;
    qryAbilityAbilityID: TIntegerField;
    qryAbilityAbilityDesc: TWideStringField;
    qryAbilityAbilityValue: TIntegerField;
    qryAbilityActive: TWideStringField;
    qryAbilityEditedFlag: TWideStringField;
    qryAbilitymsTimeStamp: TDateTimeField;
    dsAbility: TDataSource;
    Label2: TLabel;
    edtAbilityDesc: TwwDBEdit;
    Label1: TLabel;
    edtAbilityValue: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure edtAbilityDescChange(Sender: TObject);
    procedure edtAbilityValueChange(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
  private
    fDirty: boolean;
  private
    function SaveData: boolean;
    function ValidateData: boolean;
    property Dirty: boolean read fDirty write fDirty;
  public
    { Public declarations }
  end;

var
  fmRepAbilityEdit: TfmRepAbilityEdit;

implementation

{$R *.dfm}

uses
  DNMExceptions, FormFactory, CommonLib, FastFuncs;

procedure TfmRepAbilityEdit.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfmRepAbilityEdit.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;
      CloseQueries;

      BeginTransaction;

      qryAbility.ParamByName('Id').asInteger := KeyID;
      OpenQueries;

      if KeyID = 0 then begin
        qryAbility.Insert;
        qryAbilityAbilityValue.AsInteger:= 0;
        self.qryAbilityActive.AsBoolean:= true;
      end else begin
        qryAbility.Edit;
      end;

//      DataState.Activate;
      Dirty := false;

      // Exception Handler
    except
      // Handle these known exceptions.
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmRepAbilityEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose:= false;
  if Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not SaveData then Exit;
          self.CommitTransaction;
          Notify(false);
          CanClose:= true;
        end;
      mrNo:
        begin
          CanClose:= true;
        end;
      mrCancel:
        begin
          CanClose:= false;
        end;
    end;
  end
  else begin
    CanClose:= true;
  end;
end;

procedure TfmRepAbilityEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  RollbackTransaction;
  Action := caFree;
end;

procedure TfmRepAbilityEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  //
end;

function TfmRepAbilityEdit.SaveData: boolean;
begin
  result:= true;
  try
    PostDb(qryAbility);
  except
    on e: exception do begin
      result:= false;
      if Pos('Duplicate entry',e.Message) > 0 then begin
        MessageDlgXP_Vista('This Ability Description already exists.', mtInformation, [mbOk], 0);
        SetFocusedControl(edtAbilityDesc);
      end
      else
        raise;
      exit;
    end;
  end;

  { validate data and return tru if all ok }
  if ValidateData then begin
    KeyId:= qryAbilityAbilityID.AsInteger;
    Dirty:= false;
  end
  else
    result:= false;
end;

function TfmRepAbilityEdit.ValidateData: boolean;
begin
  result:= false;
  if Trim(qryAbilityAbilityDesc.AsString) = '' then begin
    MessageDlgXP_Vista('Ability Description can not be blank.',mtInformation,[mbOk],0);
    SetFocusedControl(edtAbilityDesc);
    exit;
  end;
  result:= true;
end;

procedure TfmRepAbilityEdit.actSaveExecute(Sender: TObject);
begin
  inherited;
  if not SaveData then Exit;
  CommitTransaction;
  Notify(false);
  Close;
end;

procedure TfmRepAbilityEdit.actCancelExecute(Sender: TObject);
begin
  inherited;
  Dirty := false;
  close;
end;

procedure TfmRepAbilityEdit.actNewExecute(Sender: TObject);
begin
  inherited;
  if Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not SaveData then Exit;
          self.CommitTransaction;
        end;
      mrNo:
        begin

        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;

  KeyID := 0;
  Dirty := false;
  FormShow(nil);
end;

procedure TfmRepAbilityEdit.edtAbilityDescChange(Sender: TObject);
begin
  inherited;
  Dirty:= true;
end;

procedure TfmRepAbilityEdit.edtAbilityValueChange(Sender: TObject);
begin
  inherited;
  Dirty:= True;
end;

procedure TfmRepAbilityEdit.chkActiveClick(Sender: TObject);
begin
  inherited;
  Dirty:= true;
end;

initialization
  RegisterClass(TfmRepAbilityEdit);
  FormFact.RegisterMe(TfmRepAbilityEdit, 'TfmRepAbilityList_*=AbilityID');
  FormFact.RegisterControl(TfmRepAbilityEdit, '*_cboAbility=AbilityID');

end.
