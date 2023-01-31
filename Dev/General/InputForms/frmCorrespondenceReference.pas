unit frmCorrespondenceReference;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, BusObjCorrespondenceReference, wwcheckbox, Mask,
  wwdbedit, DNMSpeedButton, Shader, DNMPanel, ActnList, BusObjBase, DBCtrls;

type
  TfmCorrespondenceReference = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryMain: TERPQuery;
    qryMainId: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainTypeCode: TWideStringField;
    qryMainReference: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainmsUpdateSiteCode: TWideStringField;
    edtReference: TwwDBEdit;
    dsMain: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    chkActive: TwwCheckBox;
    ActionList1: TActionList;
    actSave: TAction;
    actNew: TAction;
    actCancel: TAction;
    btnNew: TDNMSpeedButton;
    qryMainCorrespondenceText: TWideMemoField;
    memInvoiceMailText: TDBMemo;
    Label3: TLabel;
    popMemo: TPopupMenu;
    mnufield1: TMenuItem;
    mnufield2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnufield1Click(Sender: TObject);
    procedure mnufield2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function SaveData: boolean;
  protected
    CorrespondenceReference: TCorrespondenceReference;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    NewReference: string;
  end;

var
  fmCorrespondenceReference: TfmCorrespondenceReference;

implementation

{$R *.dfm}

uses
  DNMExceptions, CommonLib, BusObjConst, tcConst;

procedure TfmCorrespondenceReference.actCancelExecute(Sender: TObject);
begin
  inherited;
  if (fsModal in self.FormState) then ModalResult := mrCancel
  else Close;
end;

procedure TfmCorrespondenceReference.actNewExecute(Sender: TObject);
begin
  inherited;
  PostDb(qryMain);
  if CorrespondenceReference.Dirty then begin
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
  CorrespondenceReference.Dirty := false;
end;

procedure TfmCorrespondenceReference.actSaveExecute(Sender: TObject);
begin
  inherited;
  if not SaveData then Exit;
  CommitTransaction;
  CorrespondenceReference.Dirty := False;
  Notify;
  if (fsModal in self.FormState) then ModalResult := mrOk
  else Close;
end;

procedure TfmCorrespondenceReference.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TCorrespondenceReference then TCorrespondenceReference(Sender).DataSet:= qryMain;
  end;
end;

procedure TfmCorrespondenceReference.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmCorrespondenceReference.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if CorrespondenceReference.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            CorrespondenceReference.Connection.CommitTransaction;
            CorrespondenceReference.Dirty := false;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          CorrespondenceReference.Dirty := false;
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

procedure TfmCorrespondenceReference.FormCreate(Sender: TObject);
begin
  inherited;
  mnufield1.caption := CORRESPONDENCE_FIELD1;
  mnufield2.caption := CORRESPONDENCE_FIELD2;

  (*mnufield1.Hint :=  'Customer : Customer Name' +NL+
                     'Supplier : Supplier Name' +NL+
                     'Employee : Employee Name'+NL +
                     'Marketing Lead : MC Name '+ NL+
                     'Repairs : Customer Name'+ NL+
                     'Job : Job Name' ;

  mnufield2.hint :=  'Customer : ShipTo Address' +NL+
                     'Supplier : ShipTo Address' +NL+
                     'Employee : Employee Address'+NL +
                     'Marketing Lead : MC Shipping Address'+ NL+
                     'Repairs : Customer Address'+ NL+
                     'Job : ShipTo address' ;*)
end;

procedure TfmCorrespondenceReference.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;

      // Put our Database Connection into transaction mode.
      BeginTransaction;

      CorrespondenceReference.Load(KeyId);
      if KeyID = 0 then begin
        CorrespondenceReference.New;
        edtReference.ReadOnly := false;
        CorrespondenceReference.Reference := NewReference;
      end
      else
        edtReference.ReadOnly := true;

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
function TfmCorrespondenceReference.SaveData: boolean;
begin
  result:= true;
//  CorrespondenceReference.PostDB;
  { validate data and return tru if all ok }
  if CorrespondenceReference.Dirty then begin
    result := CorrespondenceReference.Save;
  end;
end;
procedure TfmCorrespondenceReference.mnufield1Click(Sender: TObject);begin  inherited; CorrespondenceReference.EditDb; memInvoiceMailText.Seltext:= '»' + CORRESPONDENCE_FIELD1 +'«';end;
procedure TfmCorrespondenceReference.mnufield2Click(Sender: TObject);begin  inherited; CorrespondenceReference.EditDb; memInvoiceMailText.Seltext:= '»' + CORRESPONDENCE_FIELD2 +'«';end;
end.
