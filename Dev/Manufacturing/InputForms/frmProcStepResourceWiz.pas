unit frmProcStepResourceWiz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, DNMPanel,
  StdCtrls, Mask, wwdbedit, Shader, BusObjProcessStep, busObjProcResource,
  AdvEdit, MemDS, ImgList;

type
  TfmProcStepResourceWiz = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTop: TDNMPanel;
    pnlStep: TDNMPanel;
    Label2: TLabel;
    edtStepDesc: TEdit;
    Label1: TLabel;
    cboResource: TComboBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlResourceDetail: TDNMPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCapacityHours: TAdvEdit;
    edtSetupHours: TAdvEdit;
    edtBreakDownHours: TAdvEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cboResourceCloseUp(Sender: TObject);
    procedure cboResourceExit(Sender: TObject);
  private
    ProcessStep: TProcessStep;
    Resource: TProcResource;
    function Save: boolean;
    procedure PopulateResourceList;
    procedure SetDisplay;
    function GetProcessStepId: integer;
  public
    property ProcessStepId: integer read GetProcessStepId;
  end;

function AddProcessStep(const aStepDescription: string): integer;

var
  fmProcStepResourceWiz: TfmProcStepResourceWiz;

implementation

{$R *.dfm}

uses
  DNMExceptions, CommonLib, CommonDbLib, 
  BusObjBase;


function AddProcessStep(const aStepDescription: string): integer;
var
  form: TfmProcStepResourceWiz;
begin
  result:= 0;
  form:= TfmProcStepResourceWiz.Create(nil);
  try
    form.edtStepDesc.Text:= aStepDescription;
    if form.ShowModal = mrOk then
      result:= form.ProcessStepId;

  finally
    form.free;
  end;
end;


procedure TfmProcStepResourceWiz.FormCreate(Sender: TObject);
begin
  self.fbIgnoreAccessLevels:= true;
  inherited;
  ProcessStep:= TProcessStep.Create(nil);
  ProcessStep.SilentMode:= true;
  ProcessStep.Connection := TMyDacDataConnection.Create(ProcessStep);
  ProcessStep.Connection.MyDacConnection := MyConnection;

  Resource:= TProcResource.Create(nil);
  Resource.SilentMode:= true;
  Resource.Connection := TMyDacDataConnection.Create(Resource);
  Resource.Connection.MyDacConnection := MyConnection;

  PopulateResourceList;
end;

procedure TfmProcStepResourceWiz.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;

      // Put our Database Connection into transaction mode.
      BeginTransaction;


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

procedure TfmProcStepResourceWiz.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  //
end;

procedure TfmProcStepResourceWiz.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
end;

procedure TfmProcStepResourceWiz.FormDestroy(Sender: TObject);
begin
  ProcessStep.Free;
  Resource.Free;
  inherited;
end;

function TfmProcStepResourceWiz.Save: boolean;
begin
  result:= true;
  try
    ProcessStep.Cancel;
    ProcessStep.New;
    ProcessStep.Description:= edtStepDesc.Text;
    ProcessStep.ResultStatus.Clear;
    if not ProcessStep.Save then begin
      result:= false;
      CommonLib.MessageDlgXP_Vista(ProcessStep.ResultStatus.Messages,mtInformation,[mbOk],0);
      exit;
    end;
    if cboResource.ItemIndex < 0 then begin
      {new resource}
      Resource.ResultStatus.Clear;
      Resource.Cancel;
      Resource.New;
      Resource.ResourceName:= cboResource.Text;
      Resource.Description:= cboResource.Text;
      (* Resource.CapacityHoursDay:= edtCapacityHours.FloatValue*60*60; *)
      if Resource.ProcResourceDays.Sunday    then Resource.ProcResourceDays.SundayCapacityHoursDay    := edtCapacityHours.FloatValue*60*60;
      if Resource.ProcResourceDays.Monday    then Resource.ProcResourceDays.MondayCapacityHoursDay    := edtCapacityHours.FloatValue*60*60;
      if Resource.ProcResourceDays.Tuesday   then Resource.ProcResourceDays.TuesdayCapacityHoursDay   := edtCapacityHours.FloatValue*60*60;
      if Resource.ProcResourceDays.wednesday then Resource.ProcResourceDays.WednesdayCapacityHoursDay := edtCapacityHours.FloatValue*60*60;
      if Resource.ProcResourceDays.Thursday  then Resource.ProcResourceDays.ThursdayCapacityHoursDay  := edtCapacityHours.FloatValue*60*60;
      if Resource.ProcResourceDays.Friday    then Resource.ProcResourceDays.FridayCapacityHoursDay    := edtCapacityHours.FloatValue*60*60;
      if Resource.ProcResourceDays.Saturday  then Resource.ProcResourceDays.SaturdayCapacityHoursDay  := edtCapacityHours.FloatValue*60*60;
      Resource.ProcResourceDays.PostDb;
      Resource.SetupHoursDay:= edtSetupHours.FloatValue*60*60;
      Resource.BreakdownHoursDay:= edtBreakDownHours.FloatValue*60*60;
      Resource.Processes.New;
      Resource.Processes.ProcessStepId:= ProcessStepId;
      Resource.Processes.PostDB;
      if not Resource.Save then begin
        result:= false;
        CommonLib.MessageDlgXP_Vista(Resource.ResultStatus.Messages,mtInformation,[mbOk],0);
        exit;
      end;
    end
    else begin
      Resource.Load(Integer(cboResource.Items.Objects[cboResource.ItemIndex]));
      Resource.Processes.New;
      Resource.Processes.ProcessStepId:= ProcessStepId;
      Resource.Processes.PostDB;
      Resource.ResultStatus.Clear;
      if not Resource.Save then begin
        result:= false;
        CommonLib.MessageDlgXP_Vista(Resource.ResultStatus.Messages,mtInformation,[mbOk],0);
        exit;
      end;
    end;
  finally
    if not result then begin
      self.RollbackTransaction;
      self.BeginTransaction;
    end;
  end;
end;

procedure TfmProcStepResourceWiz.PopulateResourceList;
var
  qry: TERPQuery;
begin
  cboResource.Clear;
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Add('select * from tblProcResource where Active = "T"');
    qry.Open;
    while not qry.Eof do begin
      cboResource.Items.AddObject(qry.FieldByName('ResourceName').AsString,
        TObject(qry.FieldByName('ProcResourceId').AsInteger));
      qry.Next;
    end;
  finally
    qry.Free;
  end;  
end;

procedure TfmProcStepResourceWiz.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Save then begin
    self.CommitTransaction;
    ModalResult:= mrOk;
  end;  
end;

procedure TfmProcStepResourceWiz.SetDisplay;
begin
  pnlResourceDetail.Visible:= cboResource.ItemIndex < 0;
end;

procedure TfmProcStepResourceWiz.cboResourceCloseUp(Sender: TObject);
begin
  inherited;
  SetDisplay;
end;

procedure TfmProcStepResourceWiz.cboResourceExit(Sender: TObject);
begin
  inherited;
  SetDisplay;
end;

function TfmProcStepResourceWiz.GetProcessStepId: integer;
begin
  result:= ProcessStep.Id;
end;

end.
