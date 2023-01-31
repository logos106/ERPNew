unit frmTrainingEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, wwcheckbox, DNMSpeedButton, Shader, DNMPanel, BusObjTraining,
  BusObjBase, ActnList, Mask, wwdbedit, wwdbdatetimepicker, ProgressDialog;

type
  TfmTrainingEdit = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryTraining: TERPQuery;
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    actNew: TAction;
    dsTraining: TDataSource;
    Label1: TLabel;
    edtDescription: TwwDBEdit;
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtTotalHours: TwwDBEdit;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    edtTraingDate: TwwDBDateTimePicker;
    edtDayStart: TwwDBDateTimePicker;
    edtDayEnd: TwwDBDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actNewExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Training: TTraining;
    function SaveData: boolean;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;

implementation

uses
  BusObjConst, DNMExceptions, CommonLib, FormFactory;


{$R *.dfm}

procedure TfmTrainingEdit.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmTrainingEdit.actNewExecute(Sender: TObject);
begin
  PostDb(qryTraining);
  if Training.Dirty then begin
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
  Training.ResultStatus.Clear;
  FormShow(nil);
  Training.Dirty := false;
end;

procedure TfmTrainingEdit.actSaveExecute(Sender: TObject);
begin
  inherited;
  if not SaveData then Exit;
  CommitTransaction;
  Notify;
  Close;
end;

procedure TfmTrainingEdit.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TTraining then TTraining(Sender).DataSet:= qryTraining;
  end;
end;

procedure TfmTrainingEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;
end;

procedure TfmTrainingEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if Training.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveData then begin
            Training.Connection.CommitTransaction;
            Training.Dirty := false;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          Training.Dirty := false;
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

procedure TfmTrainingEdit.FormCreate(Sender: TObject);
begin
  inherited;
  Training:= TTraining.Create(self);
  Training.Connection := TMyDacDataConnection.Create(Training);
  Training.Connection.MyDacConnection := MyConnection;
  Training.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmTrainingEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfmTrainingEdit.FormShow(Sender: TObject);
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
      Training.Load(KeyId);
      if KeyID = 0 then begin
        Training.New;
        edtDescription.ReadOnly := false;
      end
      else begin
        edtDescription.ReadOnly := true;
      end;
      //DataState.Activate;

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

function TfmTrainingEdit.SaveData: boolean;
begin
  result:= true;
  PostDb(qryTraining);
  if Training.Dirty and (not TRaining.Save) then
     result := false
  else
    Training.Dirty := false;
end;

initialization

  RegisterClass(TfmTrainingEdit);

  FormFact.RegisterMe(TfmTrainingEdit, 'TfmTrainingList_*=TrainingId');

end.
