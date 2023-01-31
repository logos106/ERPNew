unit frmShippingFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, DB, StdCtrls, Mask, DBCtrls, ExtCtrls,  
  BaseInputForm, DNMPanel, kbmMemTable, wwcheckbox, Buttons, DNMSpeedButton, DataState,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, Menus, AdvMenus, MemDS, Shader,
  ImgList, BusObjCommon, BusObjBase, ActnList, ProgressDialog;

type
  TfrmShipping = class(TBaseInputGUI)
    frmShippingSrc: TDataSource;
    txtShippingMethod: TDBEdit;
    Name_Label: TLabel;
    Label11: TLabel;
    qryShipping: TERPQuery;
    memQryShipping: TkbmMemTable;
    chkActive: TwwCheckBox;
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    ActionList: TActionList;
    actSave: TAction;
    actNew: TAction;
    actCancel: TAction;
    qryShippingShippingMethodID: TIntegerField;
    qryShippingShippingMethod: TWideStringField;
    qryShippingActive: TWideStringField;
    qryShippingEditedFlag: TWideStringField;
    qryShippingGlobalref: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryShippingAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
  private
    ShippingMethod: TShippingMethod;
    function SaveData: boolean;
    procedure HandleValidationErrors;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
  end;

implementation

uses DNMLib, FormFactory, DNMExceptions, CommonLib, BusObjConst;

{$R *.DFM}


procedure TfrmShipping.FormCreate(Sender: TObject);
begin
  inherited;
  ShippingMethod:= TShippingMethod.Create(self);
  ShippingMethod.Connection := TMyDacDataConnection.Create(ShippingMethod);
  ShippingMethod.Connection.MyDacConnection := MyConnection;
  ShippingMethod.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfrmShipping.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Roll back any existing transaction
      RollbackTransaction;


      // Put our Database Connection into transaction mode.
      BeginTransaction;

     // qryProcResource.ParamByName('ProcResourceId').asInteger := KeyID;

      if KeyID = 0 then begin
        ShippingMethod.New;
      end else begin
        ShippingMethod.Load(KeyId);
      end;
      OpenQueries;

      chkActive.Enabled := (AccessLevel <> 2) and (AccessLevel <> 3);
      SetControlFocus(txtShippingMethod);
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

procedure TfrmShipping.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  inherited;
  Action := caFree;
end;

procedure TfrmShipping.qryShippingAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryShipping, memqryShipping);
end;

procedure TfrmShipping.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TShippingMethod then
      TShippingMethod(Sender).DataSet:= qryShipping;
  end
end;

procedure TfrmShipping.HandleValidationErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem := ShippingMethod.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_ShippingMethod_MethodBlank :
        begin
          SetControlFocus(txtShippingMethod);
        end;
    end;
  end;
end;

function TfrmShipping.SaveData: boolean;
begin
  result:= true;
  { validate data and return tru if all ok }
  if ShippingMethod.Dirty then begin
    if not ShippingMethod.Save then
      result:= false;
  end;
end;

procedure TfrmShipping.actSaveExecute(Sender: TObject);
begin
  inherited;
  PostDb(qryShipping);
  if not SaveData then begin
    HandleValidationErrors;
    Exit;
  end;
  CommitTransaction;
  KeyId := ShippingMethod.ID;
  Notify(False);
  Close;
end;

procedure TfrmShipping.actNewExecute(Sender: TObject);
begin
  inherited;
  PostDB(qryShipping);
  if ShippingMethod.Dirty then begin
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
  ShippingMethod.Dirty := false;
end;

procedure TfrmShipping.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

initialization
  RegisterClassOnce(TFrmShipping);
  FormFact.RegisterMe(TfrmShipping, 'TShippingListGUI_*=ShippingMethodID');
  FormFact.RegisterControl(TfrmShipping, '*_cboVia=ShippingMethodID');
  FormFact.RegisterControl(TfrmShipping, '*_cboShipping=ShippingMethodID');
  FormFact.RegisterControl(TfrmShipping, '*_Shipping=ShippingMethodID');
end.
