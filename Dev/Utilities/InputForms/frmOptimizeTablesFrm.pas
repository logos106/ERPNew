unit frmOptimizeTablesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, AppEvnts, DB,  StdCtrls, Buttons, DNMSpeedButton, ComCtrls,AdvOfficeStatusBar,
  ExtCtrls, DNMPanel, TableFunctionsObj, SelectionDialog, DBAccess, MyAccess,ERPdbComponents,
  DataState, Menus, AdvMenus, Shader, ImgList, MemDS, ProgressDialog;

type
  TOptimizeTablesGUI = class(TBaseInputGUI)
    btnContinue: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    ProgressBar1: TProgressBar;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    edtServer: TEdit;
    lblServer: TLabel;
    lblDatabase: TLabel;
    edtDatabase: TEdit;
    procedure btnContinueClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure btnContinueMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
    KeyCtrlPressed: boolean;
    Running: boolean;
    TableFunctions: TTableFunctionsObj;
    procedure OptimizeTables;
    procedure RepairTables(const ExtendedMode: boolean);
  public
    { Public declarations }
  end;

implementation
  
uses MAIN, CommonDbLib, DNMExceptions, CommonLib,
  dmMainGUI, AppEnvironment, UserUtilsClientObj;
{$R *.dfm}

{ TOptimizeTablesGUI }

procedure TOptimizeTablesGUI.btnContinueClick(Sender: TObject);
var
  msg: string;
  EMode: boolean;
begin
  EMode := KeyCtrlPressed;
  inherited;
  btnContinue.Enabled:= false;
  btnCancel.Enabled:= false;
  Processingcursor(True);
  try
    case CommonLib.MessageDlgXP_Vista('The Optimise Function may take a Long Time depending on the ' + #13 + #10 +
      'Amount of Data in this Database.' +
      #13 + #10 + '' + #13 + #10 + '' + #13 + #10 + 'OPTIMISE This Company Database ?', mtWarning, [mbYes, mbNo], 0) of
      mrNo: Exit;
    end;
    if not MainForm.RemoveAllConnectionsToDB('TOptimizeTablesGUI') then Exit;
    if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Optimise DB') then begin
      try
        CommonDbLib.GetSharedMyDacConnection.Disconnect;
        Running:= true;
        try
          Self.RepairTables(EMode);
          Self.OptimizeTables;
          Running := false;
          Self.Close;
        finally
          Running := false;
          CommonDbLib.GetSharedMyDacConnection.Connect;
        end;
      finally
        AppEnv.UtilsClient.UnlockLogon;
      end;
    end
    else begin
      if msg = USERS_IN_SYSTEM_MESSAGE then begin
        MainForm.GetCurrentUserCount;
        dtmMainGUI.dlgCurrentUsers.Caption := CommonDbLib.GetSharedMyDacConnection.Database + ' Database Optimise';
        dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
        dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
        dtmMainGUI.dlgCurrentUsers.Execute;
      end
      else begin
        MessageDlgXP_Vista('Unable to Optimise DB, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
      end;
    end;
  finally
    Processingcursor(False);
    btnContinue.Enabled:= true;
    btnCancel.Enabled:= true;
  end;
end;

procedure TOptimizeTablesGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TOptimizeTablesGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
//  OptimizeTablesGUI := nil;
end;

procedure TOptimizeTablesGUI.OptimizeTables;
var
  TableCount, I: integer;
  dsTables: TERPQuery;
  TableName: string;
  Conn: TMyConnection;
begin
  try
    //Setup Query/Dataset
    dsTables := TERPQuery.Create(Self);
    dsTables.Options.FlatBuffers := True;
    if edtServer.Visible then begin
      Conn:= CommonDbLib.GetNewMyDacConnection(nil);
      Conn.Server:= edtServer.Text;
      Conn.Database:= edtDatabase.Text;
      try
        Conn.Connect;
      except
        on e: exception do begin
          CommonLib.MessageDlgXP_Vista('Optimize tables failed with message: ' + e.Message, mtWarning,[mbOk],0);
          conn.Free;
          exit;
        end;
      end;                                            dsTables.Connection:= Conn;
    end
    else
      dsTables.Connection := CommonDbLib.GetSharedMyDacConnection;
    //Setup Progress
    ProgressBar1.Min      := 0;
    ProgressBar1.Position := ProgressBar1.Min;
    ProgressBar1.Step     := 1;
    try
      dsTables.SQL.Text := 'Show Tables;';
      dsTables.Open;
      with dsTables do begin
        if RecordCount > 0 then begin
          TableCount := RecordCount;
          ProgressBar1.Max := TableCount;
          First;
          for I := 0 to TableCount - 1 do begin
            TableName := dsTables.Fields[0].AsString;
            TableFunctions.OptimizeTable(TableName);
            ProgressBar1.StepIt;
            Application.ProcessMessages;
            Next;
          end;
        end;
      end;
    finally
      FreeandNil(dsTables);
      FreeAndNil(Conn);
    end;
  except
    raise;
  end;
end;

procedure TOptimizeTablesGUI.RepairTables(const ExtendedMode: boolean);
var
  TableCount, I: integer;
  dsTables: TERPQuery;
  Conn: TMyConnection;
begin
  try
    //Setup Query/Dataset
    dsTables := TERPQuery.Create(Self);
    try
      dsTables.Options.FlatBuffers := True;
      if edtServer.Visible then begin
        Conn:= CommonDbLib.GetNewMyDacConnection(dsTables);
        Conn.Server:= edtServer.Text;
        Conn.Database:= edtDatabase.Text;
        try
          Conn.Connect;
        except
          on e: exception do begin
            CommonLib.MessageDlgXP_Vista('Optimize tables failed with message: ' + e.Message, mtWarning,[mbOk],0);
            conn.Free;
            exit;
          end;
        end;
        dsTables.Connection:= Conn;
      end
      else
        dsTables.Connection := CommonDbLib.GetSharedMyDacConnection;
      //Setup Progress
      ProgressBar1.Min      := 0;
      ProgressBar1.Position := ProgressBar1.Min;
      ProgressBar1.Step     := 1;
      dsTables.SQL.Text := 'Show Tables;';
      dsTables.Open;
      with dsTables do begin
        if RecordCount > 0 then begin
          TableCount := RecordCount;
          ProgressBar1.Max := TableCount;
          First;
          for I := 0 to TableCount - 1 do begin
            TableFunctions.RepairTable(dsTables.Fields[0].AsString, ExtendedMode);
            ProgressBar1.StepIt;
            Application.ProcessMessages;
            Next;
          end;
        end;
      end;
    finally
      dsTables.Free;
    end;
  except
    raise;
  end;
end;

procedure TOptimizeTablesGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      TableFunctions := TTableFunctionsObj.Create;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TOptimizeTablesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Running := false;
  KeyCtrlPressed := false;  
end;

procedure TOptimizeTablesGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  CanClose := not Running;
end;

procedure TOptimizeTablesGUI.btnContinueMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited;
  if (Shift = [ssCtrl, ssLeft]) then begin
    KeyCtrlPressed := true;
  end else begin
    KeyCtrlPressed := false;
  end;
end;

procedure TOptimizeTablesGUI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = VK_F5) and (ssCtrl in Shift) then begin
    lblServer.Visible:= true;
    edtServer.Visible:= true;
    edtServer.Text:= CommonDbLib.GetSharedMyDacConnection.Server;
    lblDatabase.Visible:= true;
    edtDatabase.Visible:= true;
    edtDatabase.Text:= CommonDbLib.GetSharedMyDacConnection.Database;
  end;
end;

initialization
  RegisterClassOnce(TOptimizeTablesGUI);
end.
