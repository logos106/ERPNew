unit frmRunName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB, Grids,
  Wwdbigrd, Wwdbgrid, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, DBAccess,
  MyAccess, wwdblook, MemDS, DataState, Menus, AdvMenus, Shader;

type
  TfrmRunCreator = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    btnClose: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    grdRuns: TwwDBGrid;
    qryRuns: TMyQuery;
    dsRuns: TDataSource;
    qryRunsRunID: TAutoIncField;
    qryRunsRunName: TStringField;
    qryRunsActive: TStringField;
    qryRunsOperator: TStringField;
    qryRunsOperatorID: TIntegerField;
    qryOperator: TMyQuery;
    cboOperator: TwwDBLookupCombo;
    qryOperatorEmployeeID: TIntegerField;
    qryOperatorEmployeeName: TStringField;
    qryRunsGlobalRef: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryRunsBeforePost(DataSet: TDataSet);
    procedure cboOperatorCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboOperatorNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure qryRunsAfterPost(DataSet: TDataSet);

  private
    { Private declarations }
    sNewRunname: string;
  protected
    function IsOkToSave: boolean; override;
  public
    { Public declarations }
    property NewRunName: string read sNewRunname write sNewRunname;

  end;

//var
//  frmRunCreator: TfrmRunCreator;

implementation

uses
  DNMExceptions,  frmEmployeeFrm, CommonLib, AppEnvironment,
  FastFuncs;

{$R *.dfm}

procedure TfrmRunCreator.FormShow(Sender: TObject);
begin
  try
    inherited;

    OpenQueries;

    EditNoAbort(qryRuns);

    // Put our Database Connection into transaction mode.
    BeginTransaction;

    if NewRunName <> '' then begin
      qryRuns.Insert;
      qryRuns.FieldByName('RunName').AsString := NewRunName;
      qryRuns.FieldByName('Active').AsString := 'T';
      SetControlFocus(grdRuns);
    end;

    // Exception Handler
  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TfrmRunCreator.btnSaveClick(Sender: TObject);
begin
  inherited;
  try
    // This will force a post
    qryRuns.First;
    qryRuns.Last;

    // Check data to ensure all fields have been specified.
    if IsOkToSave then begin
      // Commit data to database.
      if (MyConnection.intransaction) then begin
        CommitTransaction;
      end;
    end;
  except
    // Failed! Perform a rollback.
    RollbackTransaction;
  end;

  if Self.FormState = [fsModal] then begin
    Self.ModalResult := mrOk;
  end else begin
    // Close down the form.
    Self.Close;
  end;
end;

procedure TfrmRunCreator.btnCloseClick(Sender: TObject);
begin
  inherited;
  // Ensure we are in transaction mode.
  if MyConnection.intransaction then begin
    // Cancel all new data entered.
    RollbackTransaction;
  end;

  if Self.FormState = [fsModal] then begin
    Self.ModalResult := mrCancel;
  end else begin
    // Close down the form.
    Self.Close;
  end;
end;

function TfrmRunCreator.IsOkToSave: boolean;
begin
  Result := inherited IsOkToSave;
  if Result = false then Exit;

  qryRuns.First;
  qryRuns.DisableControls;
  while not qryRuns.Eof do begin
    if (FastFuncs.Trim(qryRuns.FieldByName('RunName').AsString) = '') then begin
      CommonLib.MessageDlgXP_Vista('Runs must have a valid name and code - Please specify and retry again.', mtWarning, [mbOK], 0);
      Result := false;
      // Re-enable data aware controls
      qryRuns.EnableControls;
      Exit;
    end;

    if (FastFuncs.Trim(qryRuns.FieldByName('Operator').AsString) = '') then begin
      CommonLib.MessageDlgXP_Vista('Runs must have an assigned operator - Please specify and retry again.', mtWarning, [mbOK], 0);
      Result := false;
      // Re-enable data aware controls
      qryRuns.EnableControls;
      Exit;
    end;

    // Fetch next record.
    qryRuns.Next;
  end;

  // Reenable data aware controls
  qryRuns.EnableControls;
end;

procedure TfrmRunCreator.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmRunCreator.qryRunsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if qryRuns.State = dsInsert then begin
    qryRuns.FieldByName('Active').AsString := 'T';
  end;
end;

procedure TfrmRunCreator.cboOperatorCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  FillTable.Edit;
  FillTable.FieldByName('OperatorID').AsInteger := qryOperator.FieldByName('EmployeeID').AsInteger;
end;

procedure TfrmRunCreator.cboOperatorNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: boolean);
var
  frm: TfrmEmployee;
  slNames: TStringList;
begin
  //  inherited;
  if NewValue = '' then Exit;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtInformation, [mbYes, mbNo], 0) = mrYes then begin
    slNames := TStringList.Create;
    try
      ExtractStrings([' '], [' '], PChar(NewValue), slNames);

      frm := TfrmEmployee(GetComponentByClassName('TfrmEmployee'));
      if Assigned(Frm) then begin
        frm.KeyID := 0;
        frm.FormStyle := fsNormal;
        frm.NewFirstName := slNames.Strings[0];
        frm.NewLastName := slNames.Strings[slNames.Count - 1];
        frm.CallingClassName := 'TfrmRunCreator';
        frm.ShowModal;
      end;  

      LookupTable.Close;
      LookupTable.Open;
      if LookupTable.Locate('EmployeeName', NewValue, [loCaseInsensitive]) then begin
        qryRuns.Edit;
        qryRuns.FieldByName('Operator').AsString := NewValue;
        cboOperator.Text := NewValue;
        Accept := true;
      end else begin
        Accept := false;
      end;
    finally
      // Release our used objects.
      if Assigned(slNames) then
        FreeandNil(slNames);
    end;
  end;
end;

procedure TfrmRunCreator.qryRunsAfterPost(DataSet: TDataSet);
begin
  inherited;
  if Empty(qryRuns.FieldByName('GlobalRef').AsString) then begin
    qryRuns.Edit;
    qryRuns.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + qryRuns.FieldByName('RunID').AsString;
    qryRuns.Post;
  end;
end;

initialization
  RegisterClassOnce(TfrmRunCreator);
end.
