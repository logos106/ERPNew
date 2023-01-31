unit ClientTypeForm;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/08/05  1.00.01 IJB  Rewrote ApplyGlobal function to cater for locking of
                        tblClients.
 26/09/05  1.00.01 AL   Change Screen Cursor to Hour Glass when pressing the 
                        "Save" button (try...finally block)
 01/11/05  1.00.02 DLS  Added RegisterClass
 12/01/06  1.00.03 IJB  Changed Notify in btnSaveClick processing so
                        CompleteNotInList processing works on customer form.
 }


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,   ExtCtrls, DNMPanel,
  StdCtrls, Buttons, DNMSpeedButton, Mask, DBCtrls, wwdblook, SelectionDialog, wwcheckbox,
  kbmMemTable, DBAccess, MyAccess,ERPdbComponents, MemDS, DataState, Menus, AdvMenus, Shader,
  ImgList, BusObjCommon, ActnList, BusObjBase, wwdbedit, Wwdotdot, Wwdbcomb,
  ProgressDialog;

type
  TClientTypeGUI = class(TBaseInputGUI)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Name_Label: TLabel;
    Description_Label: TLabel;
    TypeName: TDBEdit;
    edtDescription: TDBEdit;
    dsClientType: TDataSource;
    qryClientType: TERPQuery;
    btnNew: TDNMSpeedButton;
    cboTerms: TwwDBLookupCombo;
    edtCredit: TDBEdit;
    edtGrace: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qryTerms: TERPQuery;
    Bevel1: TBevel;
    Label4: TLabel;
    chkGlobal: TCheckBox;
    Label5: TLabel;
    chkActive: TwwCheckBox;
    Label6: TLabel;
    memQryClientType: TkbmMemTable;
    cboDefaultPostAccount: TwwDBLookupCombo;
    cboAccountQry: TERPQuery;
    Label113: TLabel;
    qryClientTypeClientTypeID: TAutoIncField;
    qryClientTypeTypeName: TWideStringField;
    qryClientTypeTypeDescription: TWideStringField;
    qryClientTypeTermsID: TIntegerField;
    qryClientTypeDefaultPostAccount: TWideStringField;
    qryClientTypeDefaultPostAccountID: TIntegerField;
    qryClientTypeCreditLimit: TFloatField;
    qryClientTypeGracePeriod: TWordField;
    qryClientTypeActive: TWideStringField;
    qryClientTypeEditedFlag: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryClientTypeGlobalRef: TWideStringField;
    ActionList: TActionList;
    actSave: TAction;
    actNew: TAction;
    actCancel: TAction;
    Label7: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    qryClientTypecallpriority: TIntegerField;
    Bevel2: TBevel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    function ApplyGlobal: boolean;
    procedure SetCreditDefaults;
    procedure cboDefaultPostAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure qryClientTypeTypeNameChange(Sender: TField);
    procedure FormCreate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
  private
    { Private declarations }
    fsClientTypeName: string;
    fbInitialising: boolean;
    ClientType: TClientType;
    function SaveData: boolean;
    procedure HandleValidationErrors;
    procedure SetClientTypeName(const Value: string);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    function DoComboToPopUp(const FieldName: string; const cbo: TwwDBLookupCombo): boolean; override;
    property ClientTypeName: string read fsClientTypeName write SetClientTypeName;
  end;

implementation
{$R *.dfm}

uses
  DNMExceptions, DNMLib, FormFactory,  CommonDbLib, UserLockObj, UserLockBaseObj,
  CommonLib, AppEnvironment, FastFuncs, BusObjConst, BusObjClient;

procedure TClientTypeGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;

      // Put our Database Connection into transaction mode.
      BeginTransaction;

      OpenDb(qryTerms);
      OpenDb(cboAccountQry);
      if KeyID = 0 then begin
        ClientType.New;
        if self.fsClientTypeName <> '' then
          qryClientTypeTypeName.AsString:= fsClientTypeName;
      end else begin
        ClientType.Load(KeyId);
      end;

      SetControlFocus(TypeName);
      chkGlobal.Checked := false;
      btnSave.Enabled   := IsOkToSave;
      btnNew.Enabled    := IsOkToSave;
      chkGlobal.Enabled := IsOkToSave;
      chkActive.Enabled := (AccessLevel = 1);
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

procedure TClientTypeGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TClientTypeGUI.ApplyGlobal: boolean;
var
  qry: TERPQuery;
  Cust: TCustomer;
  ProgressDialog: TProgressDialog;
begin
  Result := true;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to Change the Terms of ' +
    'ALL customers of this Type', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    qry:= TERPQuery.Create(nil);
    Cust:= TCustomer.Create(nil);
    ProgressDialog:= TProgressDialog.Create(nil);
    try
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Add('SELECT ClientId, Company FROM tblClients');
      qry.SQL.Add('WHERE Customer = "T" AND' + ' ClientTypeId = ' +
        IntToStr(qryClientType.FieldByName('ClientTypeID').AsInteger));
      qry.Open;
      if qry.RecordCount > 0 then begin
        Cust.Connection:= ClientType.Connection;
        Cust.SilentMode:= true;
        ClientType.Connection.BeginNestedTransaction;
        ProgressDialog.Caption:= 'Updating Customers';
        ProgressDialog.Caption:= 'Please wait ...';
        ProgressDialog.Step:= 1;
        ProgressDialog.MaxValue:= qry.RecordCount;
        ProgressDialog.Execute;
        while not qry.Eof do begin
          Cust.ResultStatus.Clear;
          Cust.Load(qry.FieldByName('ClientID').AsInteger);
          if not Cust.ResultStatus.OperationOk then begin
            ClientType.Connection.RollbackNestedTransaction;
            result:= false;
            CommonLib.MessageDlgXP_Vista('Error loading customer "' +
              qry.FieldByName('Company').AsString + '" with message: ' +
              Cust.ResultStatus.Messages, mtInformation, [mbOK], 0);
            exit;
          end;
          if not Cust.Lock then begin
            ClientType.Connection.RollbackNestedTransaction;
            result:= false;
            CommonLib.MessageDlgXP_Vista('Error updating customer "' +
              qry.FieldByName('Company').AsString + '" with message: ' +
              Cust.UserLock.LockMessage, mtInformation, [mbOK], 0);
            exit;
          end;

          Cust.GracePeriod:= ClientType.GracePeriod;
          Cust.CreditLimit:= ClientType.CreditLimit;

          if not Cust.Save then begin
            ClientType.Connection.RollbackNestedTransaction;
            result:= false;
            CommonLib.MessageDlgXP_Vista('Error updating customer "' +
              qry.FieldByName('Company').AsString + '" with message: ' +
              Cust.ResultStatus.Messages, mtInformation, [mbOK], 0);
            exit;
          end;
          qry.Next;
          ProgressDialog.StepIt;
        end;
        ClientType.Connection.CommitNestedTransaction;
        CommonLib.MessageDlgXP_Vista('A total of ' + IntToStr(qry.RecordCount) +
        ' customers of type: "' +
          TypeName.Text + '" have been updated.', mtInformation, [mbOK], 0);
      end
      else begin
        CommonLib.MessageDlgXP_Vista('No matching customers where found to update.', mtInformation, [mbOK], 0);
      end;
    finally
      ProgressDialog.Free;
      Cust.Free;
      qry.Free;
    end;
  end;
end;

procedure TClientTypeGUI.SetClientTypeName(const Value: string);
begin
  fsClientTypeName := Value;
  if (Value <> '') and qryClientType.Active then begin
    if qryClientTypeTypeName.AsString = '' then
      qryClientTypeTypeName.AsString:= Value;
  end;
end;

procedure TClientTypeGUI.SetCreditDefaults;
begin
  qryClientType.FieldByName('TermsID').AsInteger := AppEnv.CompanyPrefs.CreditTermsID;
  qryClientType.FieldByName('CreditLimit').AsFloat := AppEnv.CompanyPrefs.CreditLimit;
  qryClientType.FieldByName('GracePeriod').AsInteger := AppEnv.CompanyPrefs.GracePeriod;
end;

procedure TClientTypeGUI.cboDefaultPostAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboDefaultPostAccount.Text = '' then Exit;
  FillTable.Edit;
  FillTable.FieldByName('DefaultPostAccountID').AsInteger := LookupTable.FieldByName('AccountID').AsInteger;
end;

procedure TClientTypeGUI.qryClientTypeTypeNameChange(Sender: TField);
var
  qry: TERPQuery;
begin
  if fbInitialising then Exit;
  inherited;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT');
    qry.SQL.Add('ClientTypeID, TypeName');
    qry.SQL.Add('FROM tblClientType');
    qry.SQL.Add('WHERE Active="T" AND TypeName = ' + QuotedStr(Sender.AsString));
    qry.Open;
    
    // Do we have any matches?
    if qry.RecordCount > 0 then begin
      // Yes report error.
      CommonLib.MessageDlgXP_Vista('It appears the Client Type "' + Sender.AsString +
        '" has already been entered! - Please choose another type name.', mtWarning, [mbOK], 0);
      fbInitialising := true;
      qryClientType.Edit;
      qryClientType.FieldByName('TypeName').AsString := '';
      TypeName.Text := '';
      fbInitialising := false;
      Application.ProcessMessages;
      SetControlFocus(TypeName);
      Exit;
    end;

    // Close query.
    qry.Close;

  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TClientTypeGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ClientType:= TClientType.Create(self);
  ClientType.Connection := TMyDacDataConnection.Create(ClientType);
  ClientType.Connection.MyDacConnection := MyConnection;
  ClientType.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TClientTypeGUI.DoBusinessObjectEvent(
  const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TClientType then
      TClientType(Sender).DataSet:= qryClientType;
  end
end;

procedure TClientTypeGUI.HandleValidationErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem := ClientType.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
//    case FatalStatusItem.Code of
//    end;
  end;
end;

function TClientTypeGUI.SaveData: boolean;
begin
  result:= true;
  { validate data and return tru if all ok }
  if ClientType.Dirty then begin
    if not ClientType.Save then begin
      result:= false;
      exit;
    end
    else begin
      if KeyID <> qryClientTypeClientTypeID.AsInteger then
        self.KeyID:= qryClientTypeClientTypeID.AsInteger;

    end;
  end;
  if (chkGlobal.Checked and (not ApplyGlobal)) then
      result:= false;
end;

procedure TClientTypeGUI.actSaveExecute(Sender: TObject);
begin
  inherited;
  ProcessingCursor(True);
  try
    PostDb(qryClientType);
    if not SaveData then begin
      HandleValidationErrors;
      Exit;
    end;
    CommitTransaction;
    Notify(false);
    Close;
  finally
    ProcessingCursor(False);
  end;
end;

procedure TClientTypeGUI.actNewExecute(Sender: TObject);
begin
  inherited;
  PostDB(qryClientType);
  if ClientType.Dirty or chkGlobal.Checked then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if not SaveData then Exit;
          CommitTransaction;
          Notify(false);
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
  FormShow(nil);
  ClientType.Dirty := false;
end;

procedure TClientTypeGUI.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

function TClientTypeGUI.DoComboToPopUp(const FieldName: string;
  const cbo: TwwDBLookupCombo): boolean;
begin
  result:= Inherited DoComboToPopUp(FieldName,cbo);
  if FieldName = 'TYPENAME' then begin
    self.ClientTypeName:= cbo.Text;
    result:= true;
  end;
end;

initialization
  RegisterClassOnce(TClientTypeGUI);
  with FormFact do begin
    RegisterMe(TClientTypeGUI, 'TClientTypeListGUI_*=ClientTypeID');
    RegisterControl(TClientTypeGUI, '*_cboClientType=ClientTypeID');
  end;
end.


