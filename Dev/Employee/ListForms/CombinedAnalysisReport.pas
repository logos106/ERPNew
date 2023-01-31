unit CombinedAnalysisReport;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 06/07/05  1.00.01 DSP  Initial version. Reports on charged and non-charged
  //                        values and hours for products and employees.
  // 25/07/05  1.00.01 IJB Removed HandleUnknownException (now handled by new
  //                       ExceptionalMagic code).



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, wwdblook, wwcheckbox, KbmMemTable, ProgressDialog,
   Shader, DAScript, MyScript, CustomInputBox;

type
  TCombinedAnalysisListGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    qryClass: TERPQuery;
    dsClass: TDataSource;
    qryMainEmployeeName: TWideStringField;
    qryMainInitials: TWideStringField;
    qryMainChargeableHours: TFloatField;
    qryMainChargedValue: TFloatField;
    qryMainNonChargeableHours: TFloatField;
    qryClassClassID: TIntegerField;
    qryClassClassName: TWideStringField;
    qryMainClassID: TIntegerField;
    qryMainClassName: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainNonChargedValue: TFloatField;
    qryMainEmployeeID: TIntegerField;
    qryMainRecoveryRate: TFloatField;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryClassAfterOpen(DataSet: TDataSet);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClassNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure chkAllClassClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
    bFalseAccessLevel: boolean;
    fsTableName:String;
    procedure CreateTemporaryTable;
    procedure DestroyTemporaryTable;
  public
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    property FalseAccessLevel: boolean read bFalseAccessLevel write bFalseAccessLevel;
  end;

implementation

uses DNMExceptions, CommonDbLib,  AppEnvironment, CommonLib, tcConst;

const
  COMBINED_TEMP = 'combinedanalysis';

  {$R *.dfm}

procedure TCombinedAnalysisListGUI.FormDestroy(Sender: TObject);
begin
  DestroyTemporaryTable;
  inherited;
end;

procedure TCombinedAnalysisListGUI.FormShow(Sender: TObject);
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

procedure TCombinedAnalysisListGUI.qryClassAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryClass.IndexFieldNames := 'ClassName ASC CIS';
end;

procedure TCombinedAnalysisListGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;

  if cboClass.Text = '' then Exit;

  RefreshQuery;
end;

procedure TCombinedAnalysisListGUI.cboClassNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
  Accept := false;
end;

procedure TCombinedAnalysisListGUI.RefreshQuery;
var
  qry: TERPQuery;
begin
  if Self.ErrorOccurred then Exit;

  if not chkAllClass.Checked then begin
    if cboClass.Text = '' then Exit;
  end;

  qry := TERPQuery.Create(nil);

  try
    DeleteContentsFromUserTemporaryTable(fsTableName);
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;

    qry.SQL.Add('INSERT HIGH_PRIORITY INTO ' + fsTableName + ' (');
    qry.SQL.Add('GlobalRef, EmployeeID, EmployeeName, ProductName, Initials, ChargeableHours, ChargedValue,');
    qry.SQL.Add('NonChargedValue, NonChargeableHours, ClassID, ClassName)');
    qry.SQL.Add('SELECT');
    qry.SQL.Add('E.GlobalRef, T.EmployeeID, T.EmployeeName, SPACE(50), E.Initials,');
    qry.SQL.Add('IF(T.JobID > 0, T.Hours, 0.00) AS ChargeableHours,');

    if not AppEnv.PayPrefs.UseEmployeeServiceAsEmployeeCost then begin
      qry.SQL.Add('IF(T.JobID > 0, if(PES.IsFixed="T" , PES.Rate ,  T.Hours * PES.Rate), 0.00) AS ChargedValue,');
      qry.SQL.Add('IF(T.JobID = 0, if(PES.IsFixed="T" , PES.Rate ,  T.Hours * PES.Rate), 0.00) AS NonChargedValue,');
    end else begin
      qry.SQL.Add('IF(T.JobID > 0, PES.Rate, 0.00) AS ChargedValue,');
      qry.SQL.Add('IF(T.JobID = 0, PES.Rate, 0.00) AS NonChargedValue,');
    end;

    qry.SQL.Add('IF(T.JobID = 0, T.Hours, 0.00) AS NonChargeableHours,');
    qry.SQL.Add('T.ClassID, T.ClassName');

    qry.SQL.Add('FROM tbltimesheets AS T');
    qry.SQL.Add('INNER JOIN tblemployees AS E on E.EmployeeID = T.EmployeeID');
    qry.SQL.Add('LEFT JOIN tblpaysemployeeservices AS PES on (PES.ID = T.ServiceID)');

    if chkAllClass.Checked then qry.SQL.Add('WHERE (T.TimesheetDate BETWEEN :xDate1 AND :xDate2)')
    else qry.SQL.Add('WHERE T.ClassID = ' + qryClass.FieldByName('ClassID').AsString +
        ' AND (T.Date BETWEEN :xDate1 AND :xDate2)');

    qry.SQL.Add('UNION ALL');
    qry.SQL.Add('SELECT P.GlobalRef, NULL, NULL,');
    qry.SQL.Add('P.PartName, NULL, NULL,');
    qry.SQL.Add('IF(PL.CustomerJobID > 0, PL.TotalLineAmountInc, 0.00),');
    qry.SQL.Add('IF(PL.CustomerJobID > 0, 0.00, PL.TotalLineAmountInc), NULL, 0.0, NULL');
    qry.SQL.Add('FROM tblparts AS P');
    qry.SQL.Add('LEFT JOIN tblpurchaselines AS PL on PL.ProductID = P.PartsID');
    qry.SQL.Add('LEFT JOIN tblpurchaseorders AS PO on PO.PurchaseOrderID = PL.PurchaseOrderID');
    qry.SQL.Add('WHERE P.IncludeInAnalysis = "T"');
    qry.SQL.Add('AND (PO.OrderDate BETWEEN :xDate1 AND :xDate2)');

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
    qryMain.SQL.Clear;
    qryMain.SQL.Add('SELECT GlobalRef, EmployeeID, EmployeeName, ProductName, Initials, ClassID, ClassName,');
    qryMain.SQL.Add('SUM(ChargeableHours) AS ChargeableHours, SUM(ChargedValue) AS ChargedValue,');
    qryMain.SQL.Add('SUM(NonChargedValue) AS NonChargedValue, SUM(NonChargeableHours) AS NonChargeableHours');
    qryMain.SQL.Add('FROM ' + fsTableName);
    qryMain.SQL.Add('WHERE EmployeeID > 0');
    qryMain.SQL.Add('GROUP BY EmployeeID');
    qryMain.SQL.Add('UNION ALL');
    qryMain.SQL.Add('SELECT GlobalRef, EmployeeID, EmployeeName, ProductName, Initials, ClassID, ClassName,');
    qryMain.SQL.Add('SUM(ChargeableHours) AS ChargeableHours, SUM(ChargedValue) AS ChargedValue,');
    qryMain.SQL.Add('SUM(NonChargedValue) AS NonChargedValue, SUM(NonChargeableHours) AS NonChargeableHours');
    qryMain.SQL.Add('FROM ' + fsTableName);
    qryMain.SQL.Add('WHERE EmployeeID = 0');
    qryMain.SQL.Add('GROUP BY ProductName');
    RefreshOrignalSQL;
    inherited;
    RefreshTotals;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TCombinedAnalysisListGUI.RefreshTotals;
var
  dChargeableHours, dChargedValue, dNonChargeableHours, dNonChargedValue: double;
begin
  inherited;
  dChargeableHours := 0;
  dChargedValue := 0;
  dNonChargeableHours := 0;
  dNonChargedValue := 0;
  qryMain.First;

  if bFalseAccessLevel then qryMain.ReadOnly := false;

  while not qryMain.Eof do begin
//    qryMain.Edit;
//    qryMain.FieldByName('RecoveryRate').AsFloat := 100 * DivZer(qryMain.FieldByName('ChargedValue').AsFloat,
//      qryMain.FieldByName('NonChargedValue').AsFloat + qryMain.FieldByName('ChargedValue').AsFloat);
//    qryMain.Post;

    dChargeableHours    := dChargeableHours + qryMain.FieldByName('ChargeableHours').AsFloat;
    dChargedValue       := dChargedValue + qryMain.FieldByName('ChargedValue').AsFloat;
    dNonChargeableHours := dNonChargeableHours + qryMain.FieldByName('NonChargeableHours').AsFloat;
    dNonChargedValue    := dNonChargedValue + qryMain.FieldByName('NonChargedValue').AsFloat;
    // Fetch next record.
    qryMain.Next;
  end;

  grdMain.ColumnByName('ChargeableHours').FooterValue := FloatToStrF(dChargeableHours, ffFixed, 15, 2);
  grdMain.ColumnByName('ChargedValue').FooterValue := FloatToStrF(dChargedValue, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('NonChargeableHours').FooterValue := FloatToStrF(dNonChargeableHours, ffFixed, 15, 2);
  grdMain.ColumnByName('NonChargedValue').FooterValue := FloatToStrF(dNonChargedValue, ffCurrency, 15, CurrencyRoundPlaces);

  if bFalseAccessLevel then qryMain.ReadOnly := true;

  qryMain.First;
end;

procedure TCombinedAnalysisListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.IndexFieldNames := 'EmployeeName ASC CIS';
end;

procedure TCombinedAnalysisListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainRecoveryRate.AsFloat :=
    100 * DivZer(qryMain.FieldByName('ChargedValue').AsFloat,
      qryMain.FieldByName('NonChargedValue').AsFloat + qryMain.FieldByName('ChargedValue').AsFloat);
end;

procedure TCombinedAnalysisListGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;

  if chkAllClass.Checked then cboClass.Enabled := false
  else cboClass.Enabled := true;

  RefreshQuery;
end;

procedure TCombinedAnalysisListGUI.CreateTemporaryTable;
var
  slSQL: TStringList;
begin
  DestroyUserTemporaryTable(fsTableName);
  slSQL := TStringList.Create;

  try
    slSQL.Clear;
    slSQL.Add('CREATE TABLE `' + fsTableName + '` (');
    slSQL.Add('`GlobalRef` varchar(25),');
    slSQL.Add('`RecID` INT(11) AUTO_INCREMENT,');
    slSQL.Add('`Details` INT(11) DEFAULT "0",');
    slSQL.Add('`EmployeeID` INT(11) DEFAULT "0",');
    slSQL.Add('`Initials` VARCHAR(255),');
    slSQL.Add('`EmployeeName` VARCHAR(255),');
    slSQL.Add('`ProductName` VARCHAR(255),');
    slSQL.Add('`ChargeableHours` DOUBLE DEFAULT "0",');
    slSQL.Add('`ChargedValue` DOUBLE DEFAULT "0",');
    slSQL.Add('`NonChargeableHours` DOUBLE DEFAULT "0",');
    slSQL.Add('`NonChargedValue` DOUBLE DEFAULT "0",');
//    slSQL.Add('`RecoveryRate` DOUBLE DEFAULT "0",');
    slSQL.Add('`ClassID` INT(11) DEFAULT "0",');
    slSQL.Add('`ClassName` VARCHAR(255),');
    slSQL.Add('PRIMARY KEY (`RecID`)) ENGINE=MyISAM;');
    CreateUserTemporaryTable(slSQL);
  finally
    FreeandNil(slSQL);
  end;
end;

procedure TCombinedAnalysisListGUI.DestroyTemporaryTable;
begin
  DestroyUserTemporaryTable(fsTableName);
end;

procedure TCombinedAnalysisListGUI.FormCreate(Sender: TObject);
begin
  //  fbIgnoreAccessLevels:= True;
  fsTablename := GetUserTemporaryTableName(COMBINED_TEMP);
  inherited;
  bFalseAccessLevel := false;
  CreateTemporaryTable;
end;

initialization
  RegisterClassOnce(TCombinedAnalysisListGUI);
end.
