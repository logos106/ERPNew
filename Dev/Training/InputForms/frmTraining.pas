unit frmTraining;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseTraining, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  DNMPanel, BusObjBase, BusobjTraining, DNMSpeedButton, StdCtrls, Shader,
  Mask, wwdbedit, wwdbdatetimepicker, ActnList, DNMAction;

type
  TfmTraining = class(TfmBaseTraining)
    qryTraining: TERPQuery;
    ERPQuery1GlobalRef: TStringField;
    ERPQuery1TrainingID: TLargeintField;
    ERPQuery1Description: TStringField;
    ERPQuery1TrainingDate: TDateField;
    ERPQuery1msTimeStamp: TDateTimeField;
    dsTraining: TDataSource;
    QryTrainingEmployeeModules: TERPQuery;
    QryTrainingEmployeeModulesEmployeeName: TStringField;
    QryTrainingEmployeeModulesBasicFeactures: TStringField;
    QryTrainingEmployeeModulesEmployee: TStringField;
    QryTrainingEmployeeModulesAccounts: TStringField;
    QryTrainingEmployeeModulesInventory_Basics: TStringField;
    QryTrainingEmployeeModulesFileMaintenance: TStringField;
    QryTrainingEmployeeModulesPurchase: TStringField;
    QryTrainingEmployeeModulesCRM: TStringField;
    QryTrainingEmployeeModulesMarketing: TStringField;
    QryTrainingEmployeeModulesSales: TStringField;
    QryTrainingEmployeeModulesPos: TStringField;
    QryTrainingEmployeeModulesBanking: TStringField;
    QryTrainingEmployeeModulesReports: TStringField;
    QryTrainingEmployeeModulesGeneral: TStringField;
    QryTrainingEmployeeModulesUtilities: TStringField;
    QryTrainingEmployeeModulesInventory_Advanced: TStringField;
    QryTrainingEmployeeModulesCustomerPayments: TStringField;
    QryTrainingEmployeeModulesSupplierPayments: TStringField;
    QryTrainingEmployeeModulesManufacturing: TStringField;
    QryTrainingEmployeeModulesAppointments: TStringField;
    QryTrainingEmployeeModulesPayroll: TStringField;
    QryTrainingEmployeeModulesFixedAssets: TStringField;
    QryTrainingEmployeeModulesWorkshop: TStringField;
    QryTrainingEmployeeModulesbudgets: TStringField;
    QryTrainingEmployeeModulesDelivery: TStringField;
    QryTrainingEmployeeModulesMatrix: TStringField;
    QryTrainingEmployeeModulesMoreTraining: TStringField;
    QryTrainingEmployeeModulesMoreTrainingDetails: TStringField;
    QryTrainingEmployeeModulesGlobalRef: TStringField;
    QryTrainingEmployeeModulesTrainingEmployeeModuleID: TIntegerField;
    QryTrainingEmployeeModulesEmployeeId: TIntegerField;
    QryTrainingEmployeeModulesDateCreated: TDateTimeField;
    QryTrainingEmployeeModulesEnteredby: TIntegerField;
    QryTrainingEmployeeModulesmstimestamp: TDateTimeField;
    dsTrainingEmployeeModules: TDataSource;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnClose: TDNMSpeedButton;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    wwDBEdit1: TwwDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    btn9: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    actTraining: TActionList;
    actTrainingAssignment: TDNMAction;
    actRoster: TDNMAction;
    QryTrainingDays: TERPQuery;
    QryTrainingDaysTrainingDate: TDateField;
    QryTrainingDaysStartTime: TDateTimeField;
    QryTrainingDaysEndTime: TDateTimeField;
    QryTrainingDaysActive: TStringField;
    QryTrainingDaysGlobalref: TStringField;
    QryTrainingDaysTrainingdayID: TLargeintField;
    QryTrainingDaysmsTimeStamp: TDateTimeField;
    dsTrainingDays: TDataSource;
    QryTrainingDaysTrainingID: TLargeintField;
    QryTrainingEmployeeModulesTrainingID: TLargeintField;
    ImageList1: TImageList;
    DNMSpeedButton2: TDNMSpeedButton;
    actTrainingProgress: TDNMAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actTrainingAssignmentExecute(Sender: TObject);
    procedure actRosterExecute(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure wwDBDateTimePicker1Exit(Sender: TObject);
    procedure wwDBEdit1Exit(Sender: TObject);
    procedure actTrainingProgressExecute(Sender: TObject);
  private
    Procedure SubformBeforeShow(Sender:TObject);
  Protected
    procedure doBusObjEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); Override;
  public
    Training :TTraining;
    TEM :TTrainingEmployeeModules;

        (*TEM : TTrainingEmployeeModules;*)

  end;


implementation

uses CommonLib, BusObjConst, datTraining, CommonFormLib,
  frmTrainingAssignment, frmTrainingRoster;

{$R *.dfm}

{ TfmBaseTraining1 }

procedure TfmTraining.doBusObjEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TTraining                 then TTraining(Sender).Dataset                := qryTraining
        else if Sender is TTrainingEmployeeModules  then TTrainingEmployeeModules(Sender).Dataset := QryTrainingEmployeeModules
        else if Sender is TTrainingDays             then TTrainingDays(Sender).Dataset            := QryTrainingDays;
    end;
end;

procedure TfmTraining.FormCreate(Sender: TObject);
begin
  inherited;
  Training := TTraining.Create(Self);
  Training.Connection := TMyDacDataConnection.Create(Training);
  Training.Connection.Connection := Self.MyConnection;
  Training.BusObjEvent := doBusObjEvent;
end;

procedure TfmTraining.FormShow(Sender: TObject);
begin
  inherited;
  Training.Load;
  {this is outside Transaction}
  if Training.count = 0 then begin
      Training.New;
      Training.TrainingDate := Date;
      Training.Description := 'E R P';
      Training.PostDB;
  end;
  TEM:=Training.TrainingEmployeeModules;
  if not Training.USerLock.Lock(Training.BusObjectTableName , 0) then Accesslevel := 5;
  OpenQueries;
end;
procedure TfmTraining.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmTraining.actTrainingAssignmentExecute(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmTrainingAssignment' ,0 , SubformBeforeShow);
end;
Procedure TfmTraining.actRosterExecute(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmTrainingRoster' ,0 , SubformBeforeShow);
end;
procedure TfmTraining.SubformBeforeShow(Sender: TObject);
begin
  if sender is TfmTrainingAssignment then begin
    Training.TrainingEmployeeModules.closeDB;
    Training.TrainingDays.CloseDb;
    TfmTrainingAssignment(SendeR).TEM := Training.TrainingEmployeeModules;
    TfmTrainingAssignment(SendeR).TrainingDays :=Training.TrainingDays;
  end else   if sender is TfmTrainingRoster then begin
    Training.TrainingEmployeeModules.closeDB;
    TfmTrainingRoster(SendeR).TEM := Training.TrainingEmployeeModules;
    TfmTrainingRoster(SendeR).dtpMonth.Date := TRaining.TrainingDate;
  end;
end;
procedure TfmTraining.btnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmTraining.wwDBDateTimePicker1Exit(Sender: TObject);
begin
  inherited;
  Training.PostDB;
end;

procedure TfmTraining.wwDBEdit1Exit(Sender: TObject);
begin
  inherited;
  Training.PostDB;
end;

procedure TfmTraining.actTrainingProgressExecute(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmTrainingStatusChart' ,0 , SubformBeforeShow);
end;

initialization
  RegisterClassOnce(TfmTraining);

end.
