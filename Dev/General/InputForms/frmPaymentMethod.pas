unit frmPaymentMethod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, BusobjPaymethods, BusObjBase, DNMSpeedButton,
  Shader, DNMPanel, ActnList, wwcheckbox, Mask, wwdbedit;

type
  TfmPaymentMethod = class(TBaseInputGUI)
    qryPaymentType: TERPQuery;
    dsPaymentType: TDataSource;
    ActionList1: TActionList;
    actSave: TAction;
    actNew: TAction;
    actCancel: TAction;
    qryPaymentTypeGlobalRef: TWideStringField;
    qryPaymentTypePayMethodID: TIntegerField;
    qryPaymentTypeNAME: TWideStringField;
    qryPaymentTypeIsCreditCard: TWideStringField;
    qryPaymentTypeActive: TWideStringField;
    qryPaymentTypemsTimeStamp: TDateTimeField;
    qryPaymentTypemsUpdateSiteCode: TWideStringField;
    qryPaymentTypePaymentMethod: TWideStringField;
    lblMsg: TLabel;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label1: TLabel;
    edtMethodName: TwwDBEdit;
    chkIsCreditCard: TwwCheckBox;
    btnCancel: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure qryPaymentTypeCalcFields(DataSet: TDataSet);
  private
    PaymentMethod: TPaymentMethod;
    function SaveData: boolean;
    function getisCreditCard: boolean;
    procedure setisCreditCard(const Value: boolean);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property isCreditCard :boolean read getisCreditCard write setisCreditCard;
    Procedure Initform;
  end;

implementation

{$R *.dfm}

uses
  BusObjConst, CommonLib, DNMExceptions, FormFactory, tcConst;

procedure TfmPaymentMethod.actCancelExecute(Sender: TObject);
begin
  inherited;
  PaymentMethod.Dirty := false;
  Close;
end;

procedure TfmPaymentMethod.actNewExecute(Sender: TObject);
begin
  inherited;
  PostDb(qryPaymentType);
  if PaymentMethod.Dirty then begin
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
  FormShow(nil);
  PaymentMethod.Dirty := false;
end;

procedure TfmPaymentMethod.actSaveExecute(Sender: TObject);
begin
  inherited;
  if not SaveData then Exit;
  CommitTransaction;
  PaymentMethod.Dirty := False;
  Notify;
  Close;
end;

procedure TfmPaymentMethod.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TPaymentMethod then TPaymentMethod(Sender).DataSet:= qryPaymentType;
  end;
end;

procedure TfmPaymentMethod.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;
end;

procedure TfmPaymentMethod.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if PaymentMethod.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            PaymentMethod.Connection.CommitTransaction;
            PaymentMethod.Dirty := false;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          PaymentMethod.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;
end;

procedure TfmPaymentMethod.FormCreate(Sender: TObject);
begin
  inherited;
  PaymentMethod := TPaymentMethod.Create(self);
  PaymentMethod.Connection := TMyDacDataConnection.Create(PaymentMethod);
  PaymentMethod.Connection.MyDacConnection := MyConnection;
  PaymentMethod.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmPaymentMethod.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      Initform;
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

function TfmPaymentMethod.getisCreditCard: boolean;
begin
  result := qryPaymentTypeIsCreditCard.AsBoolean;
end;

procedure TfmPaymentMethod.Initform;
begin
      RollbackTransaction; // Roll back any existing transaction
      BeginTransaction;   // Put our Database Connection into transaction mode.

      PaymentMethod.Load(KeyId);
      if KeyID = 0 then PaymentMethod.New
      else edtMethodName.ReadOnly := true;

end;

procedure TfmPaymentMethod.qryPaymentTypeCalcFields(DataSet: TDataSet);
begin
  inherited;
  Dataset.FieldByName('PaymentMethod').AsString := Dataset.FieldByName('Name').AsString;
end;

function TfmPaymentMethod.SaveData: boolean;
begin
  result:= true;
  PaymentMethod.POSTDB;
  { validate data and return tru if all ok }
  if PaymentMethod.Dirty then begin
    if not PaymentMethod.Save then
      result:= false;
  end;
end;

procedure TfmPaymentMethod.setisCreditCard(const Value: boolean);
begin
  if (value <>PaymentMethod.IsCreditCard) and (Value) then
    TimerMsg(lblMsg , quotedstr(PaymentMethod.PaymentMethodName) +NL+' is a payment Method but not flagged as a Creit Card.' +
                      NL+'Please Flag it as ''Credit Card'' and Save.' , 20);
  PaymentMethod.IsCreditCard := Value;
  PaymentMethod.PostDB;
end;

initialization
  RegisterClass(TfmPaymentMethod);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmPaymentMethod, 'TPaymentMethodListGUI_*=PayMethodId');
    RegisterControl(TfmPaymentMethod, '*_cboPaymentMethod=PayMethodID');
    RegisterControl(TfmPaymentMethod, '*_cboCreditCardType=CreditCardType');
  end;

end.
