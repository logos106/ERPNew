unit frmSourceFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, BaseInputForm,
  jpeg, wwdblook, wwdbdatetimepicker, wwcheckbox, kbmMemTable,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DataState, DNMPanel,
  Buttons, DNMSpeedButton, Menus, AdvMenus, MemDS, Shader, ImgList,
  BusObjClient, ActnList, BusObjConst, BusObjbase, ProgressDialog;

type
  TfrmSource = class(TBaseInputGUI)
    frmSourceSrc: TDataSource;
    MediaType_Label: TLabel;
    Active_Label: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    txtMediaType: TDBEdit;
    cmdNew: TDNMSpeedButton;
    MedTypeID: TDBEdit;
    EditedFlag: TDBCheckBox;
    Label20: TLabel;
    Cost: TDBEdit;
    Label21: TLabel;
    qrySource: TERPQuery;
    qryAccount: TERPQuery;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    qrySourceMedTypeID: TAutoIncField;
    qrySourceMediaType: TWideStringField;
    qrySourceAccount: TIntegerField;
    qrySourceCost: TFloatField;
    qrySourceActive: TWideStringField;
    qrySourceCreationDate: TDateField;
    qrySourceInactiveDate: TDateField;
    cboAccount: TwwDBLookupCombo;
    chkActive: TwwCheckBox;
    memQrySource: TkbmMemTable;
    memQrySourceMedTypeID: TAutoIncField;
    memQrySourceMediaType: TWideStringField;
    memQrySourceAccount: TIntegerField;
    memQrySourceCost: TFloatField;
    memQrySourceActive: TWideStringField;
    memQrySourceCreationDate: TDateField;
    memQrySourceInactiveDate: TDateField;
    memQrySourceEditedFlag: TWideStringField;
    qrySourceEditedFlag: TWideStringField;
    Bevel2: TBevel;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    ActionList: TActionList;
    actSave: TAction;
    actNew: TAction;
    actCancel: TAction;
    qrySourceGlobalref: TWideStringField;
    qrySourceshowingoogle: TWideStringField;
    Label1: TLabel;
    wwCheckBox1: TwwCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actCancelExecute(Sender: TObject);
  private
    Source: TSource;
    function SaveData: boolean;
    procedure HandleValidationErrors;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
  end;

implementation

uses CommonDbLib, FormFactory, DNMExceptions,
  CommonLib;

{$R *.DFM}

procedure TfrmSource.FormShow(Sender: TObject);
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

      OpenDb(qryAccount);
      if KeyID = 0 then begin
        Source.New;
        Source.InactiveDate:= 0;
        wwDBDateTimePicker2.Clear;
      end else begin
        Source.Load(KeyId);
      end;

      chkActive.Enabled := (AccessLevel <> 2) and (AccessLevel <> 3);
      SetControlFocus(txtMediaType);
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

procedure TfrmSource.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RollbackTransaction;
  CloseQueries;
  inherited;
  Action := caFree;
end;

procedure TfrmSource.FormCreate(Sender: TObject);
begin
  inherited;
  Source:= TSource.Create(self);
  Source.Connection := TMyDacDataConnection.Create(Source);
  Source.Connection.MyDacConnection := MyConnection;
  Source.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfrmSource.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TSource then
      TSource(Sender).DataSet:= qrySource;
  end
end;

function TfrmSource.SaveData: boolean;
begin
  result:= true;
  { validate data and return tru if all ok }
  if Source.Dirty then begin
    if not Source.Save then
      result:= false;
  end;
end;

procedure TfrmSource.actSaveExecute(Sender: TObject);
begin
  inherited;
  PostDb(qrySource);
  if not SaveData then begin
    HandleValidationErrors;
    Exit;
  end;
  CommitTransaction;
  Notify;
  Notify(false);
  Close;
end;

procedure TfrmSource.HandleValidationErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem := Source.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_Source_DescriptionBlank :
        begin
          SetControlFocus(txtMediaType);
        end;
    end;
  end;
end;

procedure TfrmSource.actNewExecute(Sender: TObject);
begin
  inherited;
  PostDB(qrySource);
  if Source.Dirty then begin
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
  Source.Dirty := false;
end;

procedure TfrmSource.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if Source.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            self.CommitTransaction;
            CanClose:= true;
          end
          else begin
            CanClose:= false;
          end;
        end;
      mrNo:
        begin
          self.RollbackTransaction;
          CanClose:= true;
        end;
      mrCancel:
        begin
          Exit;
        end;
    end;
  end;
end;

procedure TfrmSource.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

initialization
  RegisterClassOnce(TFrmSource);
  FormFact.RegisterMe(TfrmSource, 'TSourceListGUI_*=MedTypeID');
  FormFact.RegisterControl(TfrmSource, '*_cboSource=MedTypeID');
  FormFact.RegisterControl(TfrmSource, '*_cboMediaType=MedTypeID');
end.
