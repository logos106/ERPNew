unit frmProcessStep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Shader, ExtCtrls, DNMPanel, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, DNMSpeedButton, wwcheckbox, Mask, wwdbedit, Grids,
  Wwdbigrd, Wwdbgrid, wwdblook , BusObjProcessStep , BusObjBase, Buttons,
  ProgressDialog, ERPDbLookupCombo;

type
  TfmProcessStep = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCancel: TDNMSpeedButton;
    btnOK: TDNMSpeedButton;
    edtprocessStep: TwwDBEdit;
    QryProcessStep: TERPQuery;
    QryProcessStepGlobalRef: TWideStringField;
    QryProcessStepID: TIntegerField;
    QryProcessStepDescription: TWideStringField;
    QryProcessStepProcessTime: TDateTimeField;
    QryProcessStepActive: TWideStringField;
    QryProcessStepmsTimeStamp: TDateTimeField;
    dsProcessStep: TDataSource;
    Label1: TLabel;
    grdEmployees: TwwDBGrid;
    qryemployeeprocesssteps: TERPQuery;
    dsemployeeprocesssteps: TDataSource;
    qryemployeeprocessstepsEmpProcessStepsID: TIntegerField;
    qryemployeeprocessstepsGlobalRef: TWideStringField;
    qryemployeeprocessstepsEmployeeID: TIntegerField;
    qryemployeeprocessstepsEmployeeName: TWideStringField;
    qryemployeeprocessstepsProcessStepID: TIntegerField;
    qryemployeeprocessstepsProcessStep: TWideStringField;
    qryemployeeprocessstepsActive: TWideStringField;
    qryemployeeprocessstepsmsTimeStamp: TDateTimeField;
    QryEmployees: TERPQuery;
    QryEmployeesEmployeeId: TIntegerField;
    QryEmployeesemployeeName: TWideStringField;
    cboemployee: TwwDBLookupCombo;
    QryProcessStepExtraInfo: TWideStringField;
    QryProcessStepmsUpdateSiteCode: TWideStringField;
    Label3: TLabel;
    edtExtraInfo: TwwDBEdit;
    QryProcessStepQtyPerCoupon: TFloatField;
    QryProcessStepRAtePercoupon: TFloatField;
    QryProcessStepDefaultDuration: TFloatField;
    Label4: TLabel;
    edtQtyPercoupon: TwwDBEdit;
    Label5: TLabel;
    edtRatePercolumn: TwwDBEdit;
    edtDefaultDuration: TwwDBEdit;
    btnEmployee: TDNMSpeedButton;
    btnResource: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    Label2: TLabel;
    Label7: TLabel;
    qryemployeeprocessstepsIsDefault: TWideStringField;
    qryemployeeprocessstepsmsUpdateSiteCode: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnEmployeeClick(Sender: TObject);
    procedure QryProcessStepAfterOpen(DataSet: TDataSet);
    procedure edtDefaultDurationExit(Sender: TObject);
  private
    ProcessStep :TProcessStep ;
    function SaveRecord: Boolean;
    procedure SelectEmployees(Sender: TwwDbGrid);
    Procedure OpenResourceform;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib  , BusObjConst, FormFactory, CommonDbLib, ManufactureLib,
  frmProcResourceEdit, CommonFormLib, IntegerListObj, tcDataUtils;

{$R *.dfm}
procedure TfmProcessStep.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;
function TfmProcessStep.SaveRecord:Boolean;
begin
  REsult := False;
  ProcessStep.PostDB;
  ProcessStep.EmployeeProcessteps.PostDb;
  if not(ProcessStep.ValidateData) then exit;
  if not(ProcessStep.Save) then exit;
  REsult := True;
end;
procedure TfmProcessStep.btnEmployeeClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TEmployeeExpresslistGUI' , nil , SelectEmployees);
end;
procedure TfmProcessStep.SelectEmployees(Sender: TwwDbGrid);
var
  st:TIntegerList;
  ctr:Integer;
begin
  if Sender.DataSource.DataSet.FindField('EmployeeId') = nil then exit;

  st:= TIntegerList.Create;
  try
    CommonLib.SelectedIDs(Sender, 'employeeId', St, true);
    for ctr:= 0 to st.Count-1 do begin
      if not ProcessStep.EmployeeProcessteps.Locate('EmployeeId' , st[ctr] , []) then begin
        ProcessStep.EmployeeProcessteps.New;
        ProcessStep.EmployeeProcessteps.EmployeeId := st[ctr];
        ProcessStep.EmployeeProcessteps.PostDB;
      end;
    end;
  finally
    FreeandNil(st);
  end;
end;
procedure TfmProcessStep.btnOKClick(Sender: TObject);
var
  isNew: boolean;
begin
  inherited;
  IsNew := ProcessStep.IsNew;
  if not(SaveRecord) then exit;
  ProcessStep.Connection.CommitTransaction;
  ProcessStep.Dirty := False;
  if (IsNew and  (MessageDlgXP_Vista('Do you want to create Resource for this Process Step?', mtConfirmation, [mbYes, mbNo], 0) = mrYes )) or
      (sender =btnResource ) then begin
      OpenResourceform;
  end;
  Self.Close;
end;

procedure TfmProcessStep.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
      if Sender is TProcessStep then TProcessStep(Sender).Dataset := QryProcessStep
      else if Sender is TEmployeeProcessSteps then TEmployeeProcessSteps(Sender).Dataset:= qryemployeeprocesssteps;
  end;
end;

procedure TfmProcessStep.edtDefaultDurationExit(Sender: TObject);
begin
  inherited;
  ProcessStep.DefaultDuration := TimeToSeconds(edtDefaultDuration.text);
  ProcessStep.PostDB;
end;

procedure TfmProcessStep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmProcessStep.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if ProcessStep.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            ProcessStep.Connection.CommitTransaction;
            ProcessStep.Dirty := false;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          ProcessStep.Dirty := false;
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

procedure TfmProcessStep.FormCreate(Sender: TObject);
begin
  inherited;
  ProcessStep := TProcessStep.Create(Self);
  ProcessStep.connection := TMyDacDataConnection.create(ProcessStep);
  ProcessStep.connection.connection := Self.MyConnection;
  ProcessStep.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmProcessStep.FormShow(Sender: TObject);
begin
  inherited;
  ProcessStep.Load(KeyID);
  ProcessStep.connection.BeginTransaction;
  if KeyId = 0 then ProcessStep.New
  else  if not ProcessStep.Lock then begin
        AccessLevel := 5; // read only
        CommonLib.MessageDlgXP_Vista(ProcessStep.UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',
          mtWarning, [mbOK], 0);
  end;
  ProcessStep.EmployeeProcessteps;
  OpenQueries;
  (* ProcessStep.EmployeeProcessteps.DataSet.Filter := 'Active = ' + QuotedStr('T');
  ProcessStep.EmployeeProcessteps.DataSet.Filtered := true; *)
end;


procedure TfmProcessStep.OpenResourceform;
var
  form: TfmProcResourceEdit;
begin
      Form := TfmProcResourceEdit(GetComponentByClassName('TfmProcResourceEdit'));
      if Assigned(Form) then begin
        form.KeyId := ProcesstepResourceID(ProcessStep.ID);
        form.FormStyle := fsMDIChild;
        form.BringToFront;
        if form.ProcResource.Processes.count =0 then form.ProcessStepId :=ProcessStep.ID;
      end;
end;

procedure TfmProcessStep.QryProcessStepAfterOpen(DataSet: TDataSet);
begin
  inherited;
  edtDefaultDuration.text := SecondsToTime(trunc(ProcessStep.DefaultDuration) , True);
end;

initialization
  RegisterClassOnce(TfmProcessStep);
  with FormFact do begin
    RegisterMe(TfmProcessStep, 'TprocessstepListGUI_*=ID');
  end;
end.

