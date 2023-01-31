{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 17/05/05 1.00.01  BJ   GlobalRef of the employee is added as the first column in the list
 25/07/05 1.00.01  IJB  Removed HandleUnknownException (now handled by new
                        ExceptionalMagic code).
 31/10/05 1.00.02  MV   Fixed EmployeeID data type of Temporary Table specified as
                        caused issues and added ClassName to SQL.
                        Added new field charged time derived from HoursTakenForJob of
                        Repairs.
}

unit EmployeeAnalysisReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, wwdblook, wwcheckbox, KbmMemTable, ProgressDialog,
   Shader, DAScript, MyScript, CustomInputBox;

type
  TEmployeeAnalysisListGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    qryClass: TERPQuery;
    dsClass: TDataSource;
    qryClassClassID: TIntegerField;
    qryClassClassName: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainInitials: TWideStringField;
    qryMainChargeableHours: TFloatField;
    qryMainChargedValue: TFloatField;
    qryMainNonChargeableHours: TFloatField;
    qryMainRecoveryRate: TFloatField;
    qryMainClassID: TIntegerField;
    qryMainClassName: TWideStringField;
    qryMainChargedTime: TFloatField;
    qryMainJobname: TWideStringField;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryClassAfterOpen(DataSet: TDataSet);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClassNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkAllClassClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    bFalseAccessLevel: boolean;
    TempTable: string;

    procedure CreateTemporaryTable;
    procedure DestroyTemporaryTable;

  public
    { Public declarations }
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    property FalseAccessLevel: boolean read bFalseAccessLevel write bFalseAccessLevel;
  end;



implementation

uses
   DNMExceptions, CommonDbLib,  AppEnvironment, CommonLib, tcConst;

{$R *.dfm}

const
  ANALYSIS_TEMP = 'employeeanalysis';

procedure TEmployeeAnalysisListGUI.FormDestroy(Sender: TObject);
begin
  DestroyTemporaryTable;
  inherited;
end;

procedure TEmployeeAnalysisListGUI.FormShow(Sender: TObject);
var
  sOldCaption: string;
begin
  try
    // Set to Full Access
    sOldCaption := pnlHeader.Caption;
    if Self.AccessLevel = 5 then begin
      Self.AccessLevel := 1;
      bFalseAccessLevel := true;
    end;

    inherited;

    if bFalseAccessLevel then pnlHeader.Caption := sOldCaption;
    
    if Self.ErrorOccurred then Exit;

    GuiPrefs.DbGridElement[grdMain].RemoveFields(
      'EmployeeId,ClassId');

    qryClass.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryClass.Open;
    
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    on e: Exception do raise;
  end;
end;

procedure TEmployeeAnalysisListGUI.qryClassAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryClass.IndexFieldNames := 'ClassName ASC CIS';
end;

procedure TEmployeeAnalysisListGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboClass.Text = '' then Exit;
  RefreshQuery;
end;

procedure TEmployeeAnalysisListGUI.cboClassNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
  Accept := false;
end;

procedure TEmployeeAnalysisListGUI.RefreshQuery;
var
  qry: TERPQuery;
begin
  if Self.ErrorOccurred then Exit;
  if not chkAllClass.Checked then begin
    if cboClass.Text = '' then Exit;
  end;

  qry := TERPQuery.Create(nil);

  try
    DeleteContentsFromUserTemporaryTable(TempTable);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;

    qry.SQL.Add('INSERT HIGH_PRIORITY INTO ' + TempTable + ' (');
    qry.SQL.Add('GlobalRef, Company, jobname, EmployeeID, EmployeeName, Initials, ChargeableHours, ChargedValue,');
    qry.SQL.Add('NonChargeableHours, RecoveryRate, ClassID, ClassName, ChargedTime)');
    qry.SQL.Add('SELECT E.GlobalRef, ');
    qry.SQL.Add('LEFT(C.Company,  if(POSITION(''^'' IN C.Company)=0 ,char_length(C.Company),POSITION(''^'' IN C.Company)-1))  ,');
    qry.SQL.Add('C.JobName, ');
    qry.SQL.Add(' T.EmployeeID, T.EmployeeName, E.Initials,');
    qry.SQL.Add('IF(T.JobID > 0, T.Hours, 0.00) AS ChargeableHours,');
    if not AppEnv.PayPrefs.UseEmployeeServiceAsEmployeeCost then begin
        qry.SQL.Add('IF(T.JobID > 0, if(PES.IsFixed="T" , PES.Rate ,  T.Hours * PES.Rate), 0.00) As ChargedValue,');
    end else begin
        qry.SQL.Add('IF(T.JobID > 0, PES.Rate, 0.00) As ChargedValue,');
    end;
    qry.SQL.Add('IF(T.JobID = 0, T.Hours, 0.00) AS NonChargeableHours,');
    qry.SQL.Add('0.00 AS RecoveryRate, T.ClassID, T.ClassName,');
    qry.SQL.Add('C.HoursTakenForJob AS ChargedTime');
    qry.SQL.Add('From tbltimesheets AS T ');
    qry.SQL.Add('LEFT join tblclients AS C on T.JobId = C.clientID');
    qry.SQL.Add('LEFT JOIN tblpaysemployeeservices AS PES on (PES.ID = T.ServiceID)');
    qry.SQL.Add('inner  JOIN tblemployees AS E on E.EmployeeID = T.EmployeeID');
    if chkAllClass.Checked then begin
      qry.SQL.Add('WHERE (T.TimesheetDate BETWEEN :xDate1 AND :xDate2)');
    end else begin
      qry.SQL.Add('WHERE T.ClassID = ' + qryClass.FieldByName('ClassID').AsString + ' AND (T.Date BETWEEN :xDate1 AND :xDate2)');
    end;

    (*qry.SQL.Add('SELECT');
    qry.SQL.Add('E.GlobalRef, T.EmployeeID, T.EmployeeName, E.Initials,');
    qry.SQL.Add('IF(T.JobID > 0, T.Hours, 0.00) AS ChargeableHours,');
    if not AppEnv.PayPrefs.UseEmployeeServiceAsEmployeeCost then begin
      qry.SQL.Add('IF(T.JobID > 0, T.Hours * PES.Rate, 0.00) As ChargedValue,');
    end else begin
      qry.SQL.Add('IF(T.JobID > 0, PES.Rate, 0.00) As ChargedValue,');
    end;
    qry.SQL.Add('IF(T.JobID = 0, T.Hours, 0.00) AS NonChargeableHours,');
    qry.SQL.Add('0.00 AS RecoveryRate, T.ClassID, T.ClassName,');
    qry.SQL.Add('R.HoursTakenForJob AS ChargedTime');
    qry.SQL.Add('FROM tbltimesheets AS T');
    qry.SQL.Add('INNER JOIN tblemployees AS E on E.EmployeeID = T.EmployeeID');
    qry.SQL.Add('INNER JOIN tblrepairjobs AS R on E.EmployeeID = R.EmployeeID');
    qry.SQL.Add('LEFT JOIN tblpaysemployeeservices AS PES on (PES.ID = T.ServiceID)');
    if chkAllClass.Checked then begin
      qry.SQL.Add('WHERE (T.Date BETWEEN :xDate1 AND :xDate2)');
    end else begin
      qry.SQL.Add('WHERE T.ClassID = ' + qryClass.FieldByName('ClassID').AsString + ' AND (T.Date BETWEEN :xDate1 AND :xDate2)');
    end;*)

    if chkIgnoreDates.Checked then begin
      qry.Params.ParamByName('xDate1').AsDateTime := 0;
      qry.Params.ParamByName('xDate2').AsDateTime := MaxDAteTime;
    end
    else begin
      qry.Params.ParamByName('xDate1').AsDateTime := dtFrom.DateTime;
      qry.Params.ParamByName('xDate2').AsDateTime := dtTo.DateTime;
    end;
    qry.Execute;

    // Now setup main query to read.
    Qrymain.DisableControls;
    try
        if qrymain.Active then Qrymain.close;
        qryMain.SQL.Clear;
        qryMain.SQL.Add('SELECT GlobalRef,Company,  jobname , EmployeeID, EmployeeName, Initials, ClassID, ClassName, ChargedTime,');
        qryMain.SQL.Add('SUM(ChargeableHours) AS ChargeableHours, SUM(ChargedValue) AS ChargedValue,');
        qryMain.SQL.Add('SUM(NonChargeableHours) AS NonChargeableHours, 0.00 AS RecoveryRate');
        qryMain.SQL.Add('FROM ' + TempTable);
        qryMain.SQL.Add('GROUP BY EmployeeID;');
    finally
        qryMain.EnableControls;
    End;

    inherited;

    RefreshTotals;

  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TEmployeeAnalysisListGUI.RefreshTotals;
var
  dChargeableHours, dChargedValue, dNonChargeableHours: double;
begin
  inherited;
  dChargeableHours := 0;
  dChargedValue := 0;
  dNonChargeableHours := 0;
  qryMain.First;
  if bFalseAccessLevel then qryMain.ReadOnly := false;
  while not qryMain.Eof do begin
    qryMain.Edit;
    qryMain.FieldByName('RecoveryRate').AsFloat := 100 * (qryMain.FieldByName('ChargeableHours').AsFloat /
      (qryMain.FieldByName('NonChargeableHours').AsFloat + qryMain.FieldByName('ChargeableHours').AsFloat));
    qryMain.Post;
    
    dChargeableHours    := dChargeableHours + qryMain.FieldByName('ChargeableHours').AsFloat;
    dChargedValue       := dChargedValue + qryMain.FieldByName('ChargedValue').AsFloat;
    dNonChargeableHours := dNonChargeableHours + qryMain.FieldByName('NonChargeableHours').AsFloat;
    // Fetch next record.
    qryMain.Next;
  end;

  grdMain.ColumnByName('ChargeableHours').FooterValue := FloatToStrF(dChargeableHours, ffFixed, 15, 4);
  grdMain.ColumnByName('ChargedValue').FooterValue := FloatToStrF(dChargedValue, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('NonChargeableHours').FooterValue := FloatToStrF(dNonChargeableHours, ffFixed, 15, 4);

  if bFalseAccessLevel then qryMain.ReadOnly := true;
  qryMain.First;
end;

procedure TEmployeeAnalysisListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := 'EmployeeName ASC CIS';
end;

procedure TEmployeeAnalysisListGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if chkAllClass.Checked then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;

  RefreshQuery;
end;

procedure TEmployeeAnalysisListGUI.CreateTemporaryTable;
var
  slSQL: TStringList;
begin
  DestroyUserTemporaryTable(TempTable);
  slSQL := TStringList.Create;
  try
    slSQL.Clear;
    slSQL.Add('CREATE TABLE `' + TempTable + '` (');
    slSQL.Add('`GlobalRef` varchar(25),');
    slSQL.Add('`Company` varchar(100),');
    slSQL.Add('`JobName` varchar(100),');
    slSQL.Add('`RecID` INT(11) AUTO_INCREMENT,');
    slSQL.Add('`Details` INT(11) DEFAULT "0",');
    slSQL.Add('`EmployeeID` INT(11) DEFAULT "0",');
    slSQL.Add('`Initials` VARCHAR(255),');
    slSQL.Add('`EmployeeName` VARCHAR(255),');
    slSQL.Add('`ChargeableHours` DOUBLE DEFAULT "0",');
    slSQL.Add('`ChargedValue` DOUBLE DEFAULT "0",');
    slSQL.Add('`NonChargeableHours` DOUBLE DEFAULT "0",');
    slSQL.Add('`RecoveryRate` DOUBLE DEFAULT "0",');
    slSQL.Add('`ClassID` INT(11) DEFAULT "0",');
    slSQL.Add('`ClassName` VARCHAR(255),');
    slSQL.Add('`ChargedTime` DOUBLE DEFAULT "0",');
    slSQL.Add('PRIMARY KEY (`RecID`)) ENGINE=MyISAM;');
    CreateUserTemporaryTable(slSQL);

  finally
    // Free used objects.
    if Assigned(slSQL) then
      FreeandNil(slSQL);
  end;
end;

procedure TEmployeeAnalysisListGUI.DestroyTemporaryTable;
begin
  DestroyUserTemporaryTable(TempTable);
end;

procedure TEmployeeAnalysisListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  bFalseAccessLevel := false;
  TempTable := GetUserTemporaryTableName(ANALYSIS_TEMP);
  CreateTemporaryTable;
end;

initialization
  RegisterClassOnce(TEmployeeAnalysisListGUI);
end.
