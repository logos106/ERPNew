unit LeaveList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, wwdblook, DBAccess, MyAccess,ERPdbComponents,
  MemDS, wwdbdatetimepicker, ProgressDialog, wwcheckbox, 
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TLeaveListGUI = class(TBaseListingGUI)
    qryLeaveTypes: TERPQuery;
    qryEmployees: TERPQuery;
    chkAllEmployees: TCheckBox;
    cboEmployee: TwwDBLookupCombo;
    qryMainEmployeeName: TWideStringField;
    qryMainPayDate: TDateField;
    qryMainDateTaken: TDateField;
    qryMainLeaveType: TWideStringField;
    qryMainHours: TFloatField;
    qryMainPayID: TIntegerField;
    qryMainEmployeeID: TIntegerField;
    qryMainIsCertified: TWideStringField;
    chkIsCertified: TwwCheckBox;
    cboLeaveType: TwwDBLookupCombo;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure chkAllEmployeesClick(Sender: TObject);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboLeaveTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure grdMainUpdateFooter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sSavedSQL: string;
    bOkToCalc: boolean;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, FastFuncs, MySQLConst;

{$R *.dfm}

procedure TLeaveListGUI.RefreshQuery;
{
  Where clause for qry main handled differenly in this list cuz we may want to
  restrict to a particular employee OR show them all }
const
  sWhere1 = ' WHERE L.LeaveType = ';
  sWhere2 = ' AND P.EmployeeID = ';
  sWhere3 = ' AND P.PayDate BETWEEN ';
var
  sFullSQL: string;
  iEmployeeID: integer;
begin
  // Get SQL that is in qryMain originally
  sFullSQL := sSavedSQL;

  // Leave type specifed
  sFullSQL := sFullSQL + sWhere1 + QuotedStr(qryLeaveTypes.FieldByName('LeaveType').AsString);

  // dates
  sFullSQL := SFullSQL + sWhere3 + QuotedStr(FormatDateTime(MysqlDateFormat, filterdatefrom)) +
    ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, filterdateto));

  // Retrict to employee if want
  iEmployeeID := qryEmployees.FieldByName('EmployeeID').AsInteger;
  if (not chkAllEmployees.Checked) and (iEmployeeID <> 0) and (not Empty(cboEmployee.Text)) then begin
    sFullSQL := sFullSql + ' ' + sWhere2 + IntToStr(iEmployeeID);
  end;

  sFullSQL := sFullSQL + ' AND p.Paid="T" AND P.Deleted = "F" ';

  qryMain.SQL.Clear;
  qryMain.SQL.Add(sFullSQL);

  inherited;
end;

procedure TLeaveListGUI.FormShow(Sender: TObject);
begin
  sSavedSQL := qryMain.SQL.Text;
  qryLeaveTypes.Open;
  cboLeaveType.Text := qryLeaveTypes.FieldByName('LeaveType').AsString;
  chkAllEmployees.Checked := true;
  cboEmployee.Enabled := false;
  qryEmployees.Open;
  inherited;
  if not qryMain.Active then Exit;
  if fbFormOpenedOk then begin
    bOkToCalc := true;
    RefreshQuery;
  end;
end;

procedure TLeaveListGUI.chkAllEmployeesClick(Sender: TObject);
begin
  inherited;
  cboEmployee.Enabled := not chkAllEmployees.Checked;
  RefreshQuery;
end;

procedure TLeaveListGUI.cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TLeaveListGUI.cboLeaveTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshQuery;
end;

procedure TLeaveListGUI.grdMainUpdateFooter(Sender: TObject);
var
  dHours: double;
  oRecPointer: TBookmark;
  //const
  // bInProgress: boolean = false;
begin
  inherited;
  dHours := 0;
  if bOkToCalc then begin
    bOkToCalc := false;
    qryMain.DisableControls;
    oRecPointer := qryMain.GetBookmark;
    try
      qryMain.First;
      while not qryMain.Eof do begin
        dHours := dHours + qryMain.FieldByName('Hours').AsFloat;
        qryMain.Next;
      end;
    finally
      qryMain.GoToBookmark(oRecPointer);
      qryMain.FreeBookmark(oRecPointer);      
      qryMain.EnableControls;
      bOkToCalc := true;
    end;
    grdMain.ColumnByName('Hours').FooterValue := FloatToStrF(dHours, ffFixed, 15, 2);
  end;
end;

procedure TLeaveListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  bOkToCalc := false;
end;

procedure TLeaveListGUI.RefreshTotals;
begin
  inherited;
  grdMainUpdateFooter(Self);
end;

initialization
  RegisterClassOnce(TLeaveListGUI);
end.
