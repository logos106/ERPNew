unit frmDatabaseBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DNMSpeedButton, AdvProgressBar, UserUtilsClientObj,
  JsonObject, ComCtrls, ExtCtrls, Shader, DNMPanel;

type

  TDbOperationType = (otBackup, otRestore, otCopy , otCopyRO, otRemove, otOptimise , otNonERPClone);

  TfmDatabaseBackup = class(TForm)
    lblProg1: TLabel;
    ProgBar1: TAdvProgressBar;
    lblProg2: TLabel;
    ProgBar2: TAdvProgressBar;
    btnOK: TDNMSpeedButton;
    memLog: TMemo;
    Timer1: TTimer;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    TaskId: string;
    fUtilsClient: TUserUtilsClient;
    SecCount: integer;
    OperationOk: boolean;
    CloseOnDone: boolean;
    UpdateParams: TJsonObject;
    procedure UtilsEventHandler(Sender: TObject; const Event, Value : string);
    procedure SetUtilsClient(const Value: TUserUtilsClient);
    procedure DoFinish(SubTaskText: string = ''; DetailText: string = ''; RemoveTask: boolean = true);
    procedure DoOnProgress(ProgJson: TJsonObject);
  public
    OperationType: TDbOperationType;
    UserName: string;
    DatabaseName: string;
    NewDatabaseName: string;
    ArchiveName: string;
    BackupFirst: boolean;
    LastTask,
    LastSubTask,
    LastDetail: string;
    property UtilsClient: TUserUtilsClient read fUtilsClient write SetUtilsClient;
  end;

function DbBackup(DatabaseName, UserName: string; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;
function DbCopy(DatabaseName, NewDatabaseName, UserName: string; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;
function DbCopyRO(DatabaseName, NewDatabaseName, UserName: string; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;
function DbRestore(DatabaseName, UserName, ArchiveName: string; BackupFirst: boolean; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;
function DBRemove(DatabaseName, UserName: string; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil; aBackupFirst :Boolean = true): boolean;
function DbOptimise(DatabaseName, UserName: string; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;
function DBNonERPClone(DatabaseName, NewDatabaseName, UserName: string;UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;

implementation

const
  NO_RESPONSE_SECONDS = 20;

{$R *.dfm}


function DoDbOperation(OpType: TDbOperationType; aDatabaseName, aNewDatabaseName, aUserName, aArchiveName: string; aBackupFirst: boolean; aUtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean; AOwner: TComponent = nil): boolean;
var
  Form: TfmDatabaseBackup;
begin
  Form:= TfmDatabaseBackup.Create(aOwner);
  try
    Form.OperationType:= OpType;
    Form.UtilsClient:= aUtilsClient;
    Form.UserName:= aUserName;
    Form.DatabaseName:= aDatabaseName;
    Form.NewDatabaseName:= aNewDatabaseName;
    Form.ArchiveName:= aArchiveName;
    Form.BackupFirst:= aBackupFirst;
    Form.CloseOnDone:= CloseOnDone;
    result:= Form.ShowModal = mrOk;
    if not result then
      msg:= Form.LastDetail
    else
      msg:= '';
  finally
    Form.Free;
  end;
end;

function DbBackup(DatabaseName, UserName: string; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;
begin
  result:= DoDbOperation(otBackup, DatabaseName, '', UserName, '', false, UtilsClient, msg, CloseOnDone, aOwner);
end;

function DbCopy(DatabaseName, NewDatabaseName, UserName: string; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;
begin
  result:= DoDbOperation(otCopy, DatabaseName, NewDatabaseName, UserName, '', false, UtilsClient, msg, CloseOnDone, aOwner);
end;

function DbCopyRO(DatabaseName, NewDatabaseName, UserName: string; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;
begin
  result:= DoDbOperation(otCopyRO, DatabaseName, NewDatabaseName, UserName, '', false, UtilsClient, msg, CloseOnDone, aOwner);
end;
function DBNonERPClone(DatabaseName, NewDatabaseName, UserName: string;UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;
begin
  result:= DoDbOperation(otNonERPClone, DatabaseName, NewDatabaseName, UserName, '', false, UtilsClient, msg, CloseOnDone, aOwner);
end;

function DbRestore(DatabaseName, UserName, ArchiveName: string; BackupFirst: boolean; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;
begin
  result:= DoDbOperation(otRestore, DatabaseName, '', UserName, ArchiveName, BackupFirst, UtilsClient, msg, CloseOnDone, aOwner);
end;
function DbRemove(DatabaseName, UserName: string; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil; aBackupFirst :Boolean= true): boolean;
begin
  result:= DoDbOperation(otRemove, DatabaseName, '', UserName, '', aBackupFirst, UtilsClient, msg, CloseOnDone, aOwner);
end;

function DbOptimise(DatabaseName, UserName: string; UtilsClient: TUserUtilsClient; var msg: string; CloseOnDone: boolean = false; AOwner: TComponent = nil): boolean;
begin
  result:= DoDbOperation(otOptimise, DatabaseName, '', UserName, '', false, UtilsClient, msg, CloseOnDone, aOwner);
end;


{ TfmDatabaseBackup }

procedure TfmDatabaseBackup.btnOKClick(Sender: TObject);
begin
  if OperationOk then
    ModalResult:= mrOk
  else
    ModalResult:= mrCancel;
end;

procedure TfmDatabaseBackup.DoFinish(SubTaskText, DetailText: string; RemoveTask: boolean);
var
  Params, ResultJson: TJsonObject;
  s: string;
begin
  Timer1.Enabled:= false;
  try
    UtilsClient.Events.RemoveMultiEvent(UtilsEventHandler);
  except

  end;
  if SubTaskText <> '' then
    lblProg1.Caption:= SubTaskText;
  if DetailText <> '' then
    lblProg1.Caption:= DetailText;
  if RemoveTask then begin
    try
      Params:= JO;
      Params.S['TaskID']:= TaskID;
      s:= lblProg2.Caption;
      lblProg2.Caption:= 'Finalising task - please wait';
      ResultJson:= UtilsClient.Client.SendRequest('UserUtils.removetask',Params);
      if Assigned(ResultJson) then begin
        try

        finally
          ResultJson.Free;
        end;
      end
      else begin
        { error, no response }
        LastDetail:= 'No response from server while finalising task.';

      end;
      lblProg2.Caption:= s;
    except
      LastDetail:= 'Error while finalising task.';
    end;
  end;
  ProgBar1.Position:= 100;
  ProgBar1.Refresh;
  ProgBar2.Position:= 100;
  ProgBar2.Refresh;


  if OperationOK and Assigned(UpdateParams) then begin
    Params:= JO;
    Params.Assign(UpdateParams);
    ResultJson:= UtilsClient.Client.SendRequest('UserUtils.forceupdatecheck',Params);
    if Assigned(ResultJson) then begin
      try

      finally
        ResultJson.Free;
      end;
    end
    else begin
      { error, no response }
      LastDetail:= 'No response from server while starting update check.';

    end;
  end;


  btnOk.Enabled:= true;
  if CloseOnDone then begin
    btnOk.Click;
  end;
end;

procedure TfmDatabaseBackup.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= btnOk.Enabled
end;

procedure TfmDatabaseBackup.FormCreate(Sender: TObject);
begin
  TaskId:= '';
  SecCount:= 0;
  OperationOk:= true;
  lblProg2.Caption:= '';
  UpdateParams:= nil;
end;

procedure TfmDatabaseBackup.FormDestroy(Sender: TObject);
begin
  UtilsClient.Events.RemoveMultiEvent(UtilsEventHandler);
  UpdateParams.Free;
end;

procedure TfmDatabaseBackup.FormShow(Sender: TObject);
var
  Params, ResultJson, item: TJsonObject;
begin
  Params:= TJsonObject.Create;
  Params.S['UserName']:= UserName;
  Params.S['DatabaseName']:= DatabaseName;
  if ArchiveName <> '' then
    Params.S['ArchiveName']:= ArchiveName;
  if NewDatabaseName <> '' then
    Params.S['NewDatabaseName']:= NewDatabaseName;
  Params.B['BackupFirst']:= BackupFirst;
  Timer1.Enabled:= true;

  case OperationType of
    otBackup:
      begin
        Caption:= 'Database Backup';
        TitleLabel.Caption:= Caption;
        Params.S['Operation']:= 'Backup';
        ResultJson:= UtilsClient.Client.SendRequest('UserUtils.dbbackup', Params);
        if Assigned(ResultJson) then begin
          try
            TaskID:= ResultJson.O['result'].S['TaskID'];
          finally
            ResultJson.Free;
          end;
        end
        else begin
          { error }
          self.DoFinish('Error','No response from ERP Utils Server',false);
        end;
      end;
    otRestore:
      begin
        Caption:= 'Database Restore';
        TitleLabel.Caption:= Caption;
        Params.S['Operation']:= 'Restore';
        UpdateParams:= JO;
        item:= Jo;
        item.S['DatabaseName']:= DatabaseName;
        item.B['SkipBackup']:= true;
        item.S['ArchiveName']:= ArchiveName;
        UpdateParams.A['List'].Add(item);

        ResultJson:= UtilsClient.Client.SendRequest('UserUtils.dbbackup',Params);
        if Assigned(ResultJson) then begin
          try
            TaskID:= ResultJson.O['result'].S['TaskID'];
          finally
            ResultJson.Free;
          end;
        end
        else begin
          { error }
          self.DoFinish('Error','No response from ERP Utils Server',false);
        end;
      end;
    otCopy:
      begin
        Caption:= 'Database Copy';
        TitleLabel.Caption:= Caption;
        Params.S['Operation']:= 'Copy';
        ResultJson:= UtilsClient.Client.SendRequest('UserUtils.dbbackup',Params);
        if Assigned(ResultJson) then begin
          try
            TaskID:= ResultJson.O['result'].S['TaskID'];
          finally
            ResultJson.Free;
          end;
        end
        else begin
          { error }
          self.DoFinish('Error','No response from ERP Utils Server',false);
        end;
      end;
    otCopyRO:
      begin
        Caption:= 'Database Copy';
        TitleLabel.Caption:= Caption;
        Params.S['Operation']:= 'CopyRO';
        ResultJson:= UtilsClient.Client.SendRequest('UserUtils.dbbackup',Params);
        if Assigned(ResultJson) then begin
          try
            TaskID:= ResultJson.O['result'].S['TaskID'];
          finally
            ResultJson.Free;
          end;
        end
        else begin
          { error }
          self.DoFinish('Error','No response from ERP Utils Server',false);
        end;
      end;
    otNonERPClone:
      begin
        Caption:= 'Clone (Non ERP)';
        TitleLabel.Caption:= Caption;
        Params.S['Operation']:= 'NonERPClone';
        ResultJson:= UtilsClient.Client.SendRequest('UserUtils.dbbackup',Params);
        if Assigned(ResultJson) then begin
          try
            TaskID:= ResultJson.O['result'].S['TaskID'];
          finally
            ResultJson.Free;
          end;
        end
        else begin
          { error }
          self.DoFinish('Error','No response from ERP Utils Server',false);
        end;
      end;
    otRemove:
      begin
        Caption:= 'Database Remove';
        TitleLabel.Caption:= Caption;
        Params.S['Operation']:= 'Remove';
        ResultJson:= UtilsClient.Client.SendRequest('UserUtils.dbbackup',Params);
        if Assigned(ResultJson) then begin
          try
            TaskID:= ResultJson.O['result'].S['TaskID'];
          finally
            ResultJson.Free;
          end;
        end
        else begin
          { error }
          self.DoFinish('Error','No response from ERP Utils Server',false);
        end;
      end;
    otOptimise:
      begin
        Caption:= 'Database Optimise';
        TitleLabel.Caption:= Caption;
        Params.S['Operation']:= 'Optimise';
        ResultJson:= UtilsClient.Client.SendRequest('UserUtils.dbbackup',Params);
        if Assigned(ResultJson) then begin
          try
            TaskID:= ResultJson.O['result'].S['TaskID'];
          finally
            ResultJson.Free;
          end;
        end
        else begin
          { error }
          self.DoFinish('Error','No response from ERP Utils Server',false);
        end;
      end;
  end;
end;

procedure TfmDatabaseBackup.SetUtilsClient(const Value: TUserUtilsClient);
begin
  fUtilsClient := Value;
  UtilsClient.Events.AddMultiEvent(UtilsEventHandler);
end;

procedure TfmDatabaseBackup.Timer1Timer(Sender: TObject);
var
  Params, ResultJson: TJsonObject;
  ReEnableTimer: boolean;
  ProgJson: TJsonObject;
begin
  ReEnableTimer:= true;
  Timer1.Enabled:= false;
  try
    if TaskID = '' then
      exit;
    if ProgBar2.Position >= 100 then
      ProgBar2.Position:= 0
    else
      ProgBar2.Position:= ProgBar2.Position + 2;
    ProgBar1.Refresh;
    Inc(SecCount);
    if SecCount >= NO_RESPONSE_SECONDS then begin
      { see if thread is still running on server }
      Params:= JO;
      Params.S['TaskID']:= TaskID;
      try
        try
          ResultJson:= UtilsClient.Client.SendRequest('UserUtils.gettaskstatus',Params);
        except
          on e: exception do begin
            { error }
            ReEnableTimer:= false;
            OperationOk:= false;
            DoFinish('Error', e.Message);
            exit;
          end;
        end;
        if Assigned(ResultJson) then begin
          try
            if ResultJson.O['Result'].B['TaskFound'] then begin
              ProgJson:= JO;
              try
                if ResultJson.O['Result'].B['WasTaskError'] then
                  OperationOk:= false;
                ProgJson.AsString:= ResultJson.O['Result'].S['TaskMessage'];
                self.DoOnProgress(ProgJson);
              finally
                ProgJson.Free;
              end;
            end
            else begin
              ReEnableTimer:= false;
              OperationOk:= false;
              DoFinish('Error','Server Task not found',false);
            end;
          finally
            ResultJson.Free;
          end;
        end
        else begin
          { error }
          ReEnableTimer:= false;
          OperationOk:= false;
          DoFinish('Error', 'No response from ERP Utils Server');
        end;
      except
        on e: exception do begin
          OperationOk:= false;
          DoFinish('Error','Error communicating with Server',false);
        end;
      end;
    end;
  finally
    if ReEnableTimer then
      Timer1.Enabled:= true;
  end;
end;

procedure TfmDatabaseBackup.UtilsEventHandler(Sender: TObject; const Event,
  Value: string);
var
  ProgJson: TJsonObject;
begin
  if SameText(Event,'Progress') then begin
    ProgJson:= JO;
    try
      ProgJson.AsString:= Value;
      if ProgJson.S['TaskId'] = TaskId then begin
        DoOnProgress(ProgJson);
      end;
    finally
      ProgJson.Free;
    end;
  end;
end;

procedure TfmDatabaseBackup.DoOnProgress(ProgJson: TJsonObject);
begin
  SecCount:= 0;
  if (LastTask <> ProgJson.S['Task']) and (ProgJson.S['Task'] <> '') then begin
    LastTask:= ProgJson.S['Task'];
    Caption:= LastTask;
    memLog.Lines.Add(LastTask);
  end;
  if (LastSubTask <> ProgJson.S['SubTask']) and (ProgJson.S['SubTask'] <> '') then begin
    LastSubTask:= ProgJson.S['SubTask'];
    lblProg1.Caption:= LastSubTask;
    memLog.Lines.Add(LastSubTask);
  end;
  if (LastDetail <> ProgJson.S['Detail']) then begin
    LastDetail:= ProgJson.S['Detail'];
    lblProg2.Caption:= LastDetail;
    memLog.Lines.Add(LastDetail);
  end;

  if ProgJson.StringExists('Result') then begin
    LastSubTask:= ProgJson.S['SubTask'];
    lblProg1.Caption:= LastSubTask;
    LastDetail:= ProgJson.S['Detail'];
    lblProg2.Caption:= LastDetail;
    OperationOk:= SameText(ProgJson.S['Result'],'Ok');
    DoFinish;
  end
  else begin
    if ProgJson.IntegerExists('StepNo') and (ProgJson.I['StepCount'] > 0) then begin
      ProgBar1.Position:= Trunc((ProgJson.I['StepNo']/ProgJson.I['StepCount']) * 100);
    end
    else begin
      ProgBar1.Position:= 100;
    end;
  end;
end;

end.
