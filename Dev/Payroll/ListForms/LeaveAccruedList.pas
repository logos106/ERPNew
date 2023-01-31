unit LeaveAccruedList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, wwdblook, DBAccess, MyAccess,ERPdbComponents,
  MemDS, wwdbdatetimepicker, ProgressDialog,  Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox;

type
  TLeaveAccruedListGUI = class(TBaseListingGUI)
    qryMainEmployeeName: TWideStringField;
    qryMainAccrueAfterNo: TFloatField;
    qryMainAccrueAfterPeriod: TWideStringField;
    qryMainAccrueNo: TFloatField;
    qryMainAccruePeriod: TWideStringField;
    qryMainAccrueHours: TFloatField;
    qryMainAccruedHours: TFloatField;
    qryMainAccruedDate: TDateField;
    qryMainType: TWideStringField;
    chkAllEmployees: TCheckBox;
    cboEmployee: TwwDBLookupCombo;
    Label4: TLabel;
    cboLeaveType: TwwDBLookupCombo;
    chkAllLeaveTypes: TCheckBox;
    qryLeaveTypes: TERPQuery;
    qryEmployees: TERPQuery;
    qryMainValue: TFloatField;
    qryMainLeaveID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    procedure grdMainUpdateFooter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboLeaveTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkAllEmployeesClick(Sender: TObject);
    procedure chkAllLeaveTypesClick(Sender: TObject);
  private
    { Private declarations }
    bFooterCalcInProgress: boolean;
    sSavedSQL: string;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
uses
  CommonLib, FastFuncs, tcConst;

procedure TLeaveAccruedListGUI.grdMainUpdateFooter(Sender: TObject);
var
  dHours: double;
  dValue: double;
  oRecPointer: TBookmark;
begin
  inherited;
  if not bFooterCalcInProgress then begin
    bFooterCalcInProgress := true;
    qryMain.DisableControls;
    oRecPointer := qryMain.GetBookmark;
    try
      dHours := 0.00;
      dValue := 0.00;
      qryMain.First;
      while not qryMain.Eof do begin
        dHours := dHours + qryMain.FieldByName('AccruedHours').AsFloat;
        dValue := dValue + qryMain.FieldByName('Value').AsFloat;
        qryMain.Next;
      end;
    finally
      qryMain.GoToBookmark(oRecPointer);
      qryMain.FreeBookmark(oRecPointer);
      qryMain.EnableControls;
      bFooterCalcInProgress := false;
    end;
    grdMain.ColumnByName('AccruedHours').FooterValue := FloatToStrF(dHours, ffNumber, 15, 4);
    grdMain.ColumnByName('Value').FooterValue := FloatToStrF(dValue, ffCurrency, 15, CurrencyRoundPlaces);
  end;
end;

procedure TLeaveAccruedListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  bFooterCalcInProgress := false;
end;

procedure TLeaveAccruedListGUI.RefreshQuery;
{
  Where clause for qry main handled differenly in this list cuz we may want to
  restrict to a particular employee OR show them all }
const
  sWhere1 = ' Type = ';
  sWhere2 = ' E.EmployeeID = ';
var
  sFullSQL: string;
  iEmployeeID: integer;
  bWhereIncluded: boolean;
begin
  bWhereIncluded := false;
  // Get SQL that is in qryMain originally
//  sFullSQL := sSavedSQL;

  sFullSQL := 'SELECT LeaveID, E.EmployeeID, EmployeeName, Type,'+
        'AccrueAfterNo, AccrueAfterPeriod, AccrueNo, AccruePeriod, AccrueHours, AccruedHours, AccruedDate,'+
        'AccruedHours*(If(IsNull(EPR.LineTotal/EPR.Qty),HourlyRate,(EPR.LineTotal/EPR.Qty)) +(If(IsNull(EPR.LineTotal/EPR.Qty),HourlyRate,(EPR.LineTotal/EPR.Qty))'+
        '*(If(Type="Annual Leave",E.LeaveLoading,0.00)/100))) as Value '+
        'FROM tblLeave '+
        'INNER JOIN tblemployees as E using (EmployeeID) '+
        'INNER JOIN tblemployeepayrates EPR USING(EmployeeID) '+
        'INNER JOIN tblpayrates PR ON (EPR.PayRateID=PR.RateID) AND (Multiplier=1)';
  
  // Restict to type specifed
  if (not chkAllLeaveTypes.Checked) and (not Empty(cboEmployee.Text)) then begin
    if not bWhereIncluded then begin
      sFullSQL := sFullSQL + ' WHERE';
      bWhereIncluded := true;
    end;
    sFullSQL := sFullSQL + sWhere1 + QuotedStr(qryLeaveTypes.FieldByName('LeaveType').AsString);
  end else if (chkAllEmployees.Checked) and (not chkAllLeaveTypes.Checked) then begin
    if not bWhereIncluded then begin
      sFullSQL := sFullSQL + ' WHERE';
      bWhereIncluded := true;
    end;
    sFullSQL := sFullSQL + sWhere1 + QuotedStr(qryLeaveTypes.FieldByName('LeaveType').AsString);
  end;

  // Retrict to employee if want
  iEmployeeID := qryEmployees.FieldByName('EmployeeID').AsInteger;
  if (not chkAllEmployees.Checked) and (iEmployeeID <> 0) and (not Empty(cboEmployee.Text)) then begin
    if not bWhereIncluded then begin
      sFullSQL := sFullSQL + ' WHERE';
      //bWhereIncluded := true;
    end else begin
      sFullSQL := sFullSQL + ' AND';
    end;
    sFullSQL := sFullSql + ' ' + sWhere2 + IntToStr(iEmployeeID);
  end;
  sFullSQL := sFullSQL + '  GROUP BY tblLeave.LeaveID';
  sFullSQL := sFullSQL + ' ORDER BY EmployeeName';

  qryMain.SQL.Clear;
  qryMain.SQL.Add(sFullSQL);

  inherited;
end;

procedure TLeaveAccruedListGUI.FormShow(Sender: TObject);
begin
  sSavedSQL := qryMain.SQL.Text;
  qryLeaveTypes.Open;
  //  cboLeaveType.Text := qryLeaveTypes.FieldByName('LeaveType').AsString;
  chkAllLeaveTypes.Checked := true;
  chkAllEmployees.Checked := true;
  cboEmployee.Enabled := false;
  qryEmployees.Open;
  inherited;
  if not qryMain.Active then Exit;

  if fbFormOpenedOk then begin
    RefreshQuery;
  end;
end;

procedure TLeaveAccruedListGUI.cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TLeaveAccruedListGUI.cboLeaveTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TLeaveAccruedListGUI.chkAllEmployeesClick(Sender: TObject);
begin
  inherited;
  cboEmployee.Enabled := not chkAllEmployees.Checked;
  RefreshQuery;
end;

procedure TLeaveAccruedListGUI.chkAllLeaveTypesClick(Sender: TObject);
begin
  inherited;
  cboLeaveType.Enabled := not chkAllLeaveTypes.Checked;
  RefreshQuery;
end;

procedure TLeaveAccruedListGUI.RefreshTotals;
begin
  inherited;
  grdMainUpdateFooter(Self);
end;

initialization
  RegisterClassOnce(TLeaveAccruedListGUI);
end.
