unit EmployeeTransferDetailsForm;

{

 Date     Version  Who  What
 -------- -------- ---  --------------------------------------------------------
 01/11/05 1.00.00  MV   Initial verson.
 06/03/06 1.00.01  DSP  Added check for access level before enabling transfer
                        button.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog,
  AppEvnts, DB,  StdCtrls, wwdblook, Buttons, DNMSpeedButton, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  MemDS, Menus, AdvMenus, Shader, DNMPanel, ImgList;

type
  TEmployeeTransferDetails = class(TBaseInputGUI)
    btnOK: TDNMSpeedButton;
    cboEmployeeFromLookupCombo: TwwDBLookupCombo;
    cboEmployeeToLookupCombo: TwwDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    lblProgress: TLabel;
    Bevel2: TBevel;
    chkToDo: TCheckBox;
    chkFollowups: TCheckBox;
    chkAppointments: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    qryEmployeeLookup: TERPQuery;
    BitBtn1: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure LookupComboChange(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    FFromEmployeeID: integer;
    FToEmployeeID: integer;
    procedure DoOpenData;
    procedure EnableDisableControls(EnabledState: boolean);
    procedure UpdateRecords(TransferDataType: integer);
  public
    { Public declarations }
  end;

implementation
  uses FastFuncs,tcDataUtils, DNMExceptions, MAIN, CommonLib, dmMainGUI;

const
  TODO         = 0;
  APPOINTMENTS = 1;
  FOLLOWUPS = 2;

  {$R *.dfm}

procedure TEmployeeTransferDetails.DoOpenData;
begin
  // rollback if form is called when already open
  RollbackTransaction;

  qryEmployeeLookup.Open;

  BeginTransaction;
end;

procedure TEmployeeTransferDetails.EnableDisableControls(EnabledState: boolean);
begin
  // Enable or Disable controls
  if EnabledState then begin
    cboEmployeeToLookupCombo.Enabled := true;
    chkToDo.Enabled         := True;
    chkAppointments.Enabled := True;
    chkFollowups.Enabled    := True;
  end else begin
    cboEmployeeToLookupCombo.Enabled := false;
    chkToDo.Enabled         := False;
    chkAppointments.Enabled := False;
    chkFollowups.Enabled    := False;
    btnOK.Enabled := False;
  end
end;

procedure TEmployeeTransferDetails.UpdateRecords(TransferDataType: integer);
var
  qryTransferData: TERPQuery;
begin
  // Create an instance of qryTransferData
  qryTransferData := TERPQuery.Create(nil);

  try
    qryTransferData.Close;
    qryTransferData.Connection := MyConnection;

    // Update table records with new employeeID
    case TransferDataType of

      TODO:
        begin
          // Process ToDo table records
          with qryTransferData do begin
            SQL.Clear;
            SQL.Add(' UPDATE tbltodo ');
            SQL.Add(' SET EmployeeID = ' + QuotedStr(IntToStr(FToEmployeeID)) + ' ');
            SQL.Add(' WHERE EmployeeID = ' + QuotedStr(IntToStr(FFromEmployeeID)) + ' AND Done = "F" ');
            Execute;
          end;
        end;

      APPOINTMENTS:
        begin
          // Process Appointments table records
          with qryTransferData do begin
            SQL.Clear;
            SQL.Add(' UPDATE tblappointments ');
            SQL.Add(' SET TrainerID = ' + QuotedStr(IntToStr(FToEmployeeID)) + ' ');
            SQL.Add(' WHERE TrainerID = ' + QuotedStr(IntToStr(FFromEmployeeID)) + ' ');
            Execute;
          end;
        end;

      FOLLOWUPS:
        begin
          with qryTransferData do begin
            SQL.Clear;
            SQL.Add('UPDATE tblmarketingleadlines');
            SQL.Add('SET EmployeeID= ' + QuotedStr(IntToStr(FToEmployeeID)) + ' , EmployeeName= '+ QuotedStr(tcDataUtils.GetEmployeeName(FToEmployeeID)));
            SQL.Add('WHERE EmployeeID= ' + QuotedStr(IntToStr(FFromEmployeeID)) + ' AND Done<>"T";');
            Execute;

            SQL.Clear;
            SQL.Add('UPDATE tblotherfollowup ');
            SQL.Add('SET EmployeeID= ' + QuotedStr(IntToStr(FToEmployeeID)));
            SQL.Add('WHERE EmployeeID= ' + QuotedStr(IntToStr(FFromEmployeeID)) + ' AND Done<>"T";');
            Execute;
          end;
        end;
    end;
  finally
    FreeandNil(qryTransferData);
  end;
end;

procedure TEmployeeTransferDetails.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
  
end;

procedure TEmployeeTransferDetails.FormShow(Sender: TObject);
begin
  try
    inherited;
    // Initialise database requirements
    DoOpenData;
    // Process controls
    EnableDisableControls(false);
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
  end;
end;

procedure TEmployeeTransferDetails.btnOKClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    // Ensure there is only one user connected to the database.  That is You only!
    if MainForm.GetCurrentUserCount > 1 then begin
      dtmMainGUI.dlgCurrentUsers.Caption := qryEmployeeLookup.Connection.Database + ' Transfer Employee Data';
      dtmMainGUI.dlgCurrentUsers.Color := $00D7FFFF;
      dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
      dtmMainGUI.dlgCurrentUsers.Execute;
    end else begin
      ProcessingCursor(True);
      try
        lblProgress.Caption := 'Transfer in progress please wait ...';

        // Process changes to data record
        try
          if chkToDo.Checked then UpdateRecords(TODO);
          if chkAppointments.Checked then UpdateRecords(APPOINTMENTS);
          if chkFollowups.Checked then UpdateRecords(FOLLOWUPS);

          CommitTransaction;
        except
          CommonLib.MessageDlgXP_Vista('An error has occurred transferring data between employees.', mtWarning, [mbOK], 0);
        end;

        lblProgress.Caption := 'Transfer progress complete';
      finally
        ProcessingCursor(False);
      end;

    End;
  finally
    EnableForm;
  end;      
end;

procedure TEmployeeTransferDetails.LookupComboChange(Sender: TObject);
begin
  inherited;
  if TwwDBLookupCombo(Sender).Name = 'cboEmployeeFromLookupCombo' then begin
    // Find and set the FromEmployeeID
    FFromEmployeeID := cboEmployeeFromLookupCombo.LookupTable.FieldValues['EmployeeID'];

    // Enable additional control functionality
    if cboEmployeeFromLookupCombo.Text <> '' then cboEmployeeToLookupCombo.Enabled := true
    else begin
      // Disable the controls
      cboEmployeeToLookupCombo.Enabled := false;
      EnableDisableControls(false);
    end
  end else if TwwDBLookupCombo(Sender).Name = 'cboEmployeeToLookupCombo' then begin
    // Find and set the ToEmployeeID
    FToEmployeeID := cboEmployeeToLookupCombo.LookupTable.FieldValues['EmployeeID'];

    // Enable the controls
    EnableDisableControls(true);
  end;
end;

procedure TEmployeeTransferDetails.CheckBoxClick(Sender: TObject);
begin
  inherited;
  btnOK.Enabled := false;

  if AccessLevel <= 2 then begin
    // re-enabled Transfer if any one is checked
    if chkToDo.Checked or chkAppointments.Checked or chkFollowups.Checked then
      btnOK.Enabled := true;
  end;
end;

procedure TEmployeeTransferDetails.BitBtn1Click(Sender: TObject);
begin
  inherited;
  close;  
end;

initialization
  RegisterClassOnce(TEmployeeTransferDetails);

finalization
  UnRegisterClass(TEmployeeTransferDetails);
end.
