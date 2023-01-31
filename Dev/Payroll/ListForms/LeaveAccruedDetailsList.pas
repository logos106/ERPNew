unit LeaveAccruedDetailsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TLeaveAccruedDetailsListGUI = class(TBaseListingGUI)
    qryMainAccruedDate: TDateField;
    qryMainEmployee: TWideStringField;
    qryMainPayNo: TLargeintField;
    qryMainAccruedType: TWideStringField;
    qryMainLeaveType: TWideStringField;
    qryMainHours: TFloatField;
    qryMainValue: TFloatField;
    Label4: TLabel;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;  
    procedure RefreshTotals; override;
    function GetReportTypeID: integer; override;
  public
    { Public declarations }
  end;

implementation

uses
  Forms, CommonLib, BaseInputForm, tcConst, MySQLConst;

{$R *.dfm}

procedure TLeaveAccruedDetailsListGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDateTime := Filterdatefrom;
  qryMain.Params.ParamByName('txtto').AsDateTime := filterdateto;
  inherited;
  TFloatField(qryMain.FieldByName('Value')).currency := true;
end;

procedure TLeaveAccruedDetailsListGUI.cmdPrintClick(Sender: TObject);
begin
  if chkAdvancedPrinting.Checked then begin
    ReportSQLSupplied := true;

    TemplateSQL := '{SQL}SELECT Date AS AccruedDate, EmployeeName AS Employee, PayID AS PayNo, AccrualType AS AccruedType, ';
    TemplateSQL := TemplateSQL + 'LeaveType as LeaveType, Round(AccruedHours, 5) as Hours, ';
    TemplateSQL := TemplateSQL + 'AccruedHours * (IF(ISNULL(EPR.LineTotal/EPR.Qty), HourlyRate, (EPR.LineTotal/EPR.Qty)) +(If(IsNull(EPR.LineTotal/EPR.Qty), HourlyRate, (EPR.LineTotal/EPR.Qty)) * (IF(LeaveType="Annual Leave", E.LeaveLoading, 0.00) / 100))) AS Value ';
    TemplateSQL := TemplateSQL + 'FROM tblleaveaccruals ';
    TemplateSQL := TemplateSQL + 'INNER JOIN tblpays as P using (PayID) ';
    TemplateSQL := TemplateSQL + 'INNER JOIN tblemployees as E on E.EmployeeID = tblleaveaccruals.EmployeeID ';
    TemplateSQL := TemplateSQL + 'INNER JOIN tblemployeepayrates EPR on EPR.EmployeeID = tblleaveaccruals.EmployeeID ';
    TemplateSQL := TemplateSQL + 'INNER JOIN tblpayrates PR ON (EPR.PayRateID=PR.RateID) AND (Multiplier=1) ';
    TemplateSQL := TemplateSQL + 'WHERE P.Deleted = "F" ';
    if chkIgnoreDates.Checked then begin
      TemplateSQL := TemplateSQL + 'AND tblleaveaccruals.Date BETWEEN "' + FormatDateTime(MysqlDateFormat, 0);
      TemplateSQL := TemplateSQL + '" AND "' + FormatDateTime(MysqlDateFormat, MaxDateTime) + '" ';
    end
    else begin
      TemplateSQL := TemplateSQL + 'AND tblleaveaccruals.Date BETWEEN "' + FormatDateTime(MysqlDateFormat, dtFrom.DateTime);
      TemplateSQL := TemplateSQL + '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime) + '" ';
    end;
    TemplateSQL := TemplateSQL + 'GROUP BY tblleaveaccruals.AccrualID ';

    TemplateSQL := TemplateSQL + 'UNION ALL ';

    TemplateSQL := TemplateSQL + 'SELECT OpenningBalanceDate AS AccruedDate, EmployeeName AS Employee, 0 as PayNo, "Opening" AS AccruedType, ';
    TemplateSQL := TemplateSQL + '`Type` as LeaveType, Round(OpenningBalanceHrs, 5) AS Hours, ';
    TemplateSQL := TemplateSQL + 'OpenningBalanceHrs * (IF(ISNULL(EPR.LineTotal / EPR.Qty), HourlyRate, (EPR.LineTotal / EPR.Qty))  + (IF(ISNULL(EPR.LineTotal / EPR.Qty), HourlyRate, (EPR.LineTotal / EPR.Qty)) *(IF(`Type`="Annual Leave", E.LeaveLoading, 0.00) / 100))) AS Value ';
    TemplateSQL := TemplateSQL + 'FROM tblleave ';
    TemplateSQL := TemplateSQL + 'INNER JOIN tblemployees AS E USING (EmployeeID) ';
    TemplateSQL := TemplateSQL + 'INNER JOIN tblemployeepayrates EPR USING(EmployeeID) ';
    TemplateSQL := TemplateSQL + 'INNER JOIN tblpayrates as PR ON (EPR.PayRateID=PR.RateID) AND (Multiplier=1) ';
    TemplateSQL := TemplateSQL + 'WHERE OpenningBalanceHrs <> 0 ';
    if chkIgnoreDates.Checked then begin
      TemplateSQL := TemplateSQL + 'AND tblleave.OpenningBalanceDate BETWEEN "' + FormatDateTime(MysqlDateFormat, 0);
      TemplateSQL := TemplateSQL + '" AND "' + FormatDateTime(MysqlDateFormat, MaxDateTime) + '" ';
    end
    else begin
      TemplateSQL := TemplateSQL + 'AND tblleave.OpenningBalanceDate BETWEEN "' + FormatDateTime(MysqlDateFormat, dtFrom.DateTime);
      TemplateSQL := TemplateSQL + '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.DateTime) + '" ';
    end;
    TemplateSQL := TemplateSQL + 'ORDER BY AccruedDate ';

    TemplateSQL := TemplateSQL + '~|||~{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO ';

  end;

  inherited;
  ReportSQLSupplied := false;

end;

function TLeaveAccruedDetailsListGUI.GetReportTypeID: integer;
begin
  Result := 54;
end;

procedure TLeaveAccruedDetailsListGUI.RefreshTotals;
var
  bm: TBookmark;
  dValue1: double;
  dValue2: double;
begin
  inherited;
  dValue1 := 0.00;
  dValue2 := 0.00;

  with qryMain do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      dValue1 := dValue1 + FieldByName('Value').AsFloat;
      dValue2 := dValue2 + FieldByName('Hours').AsFloat;

      Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
  end;
  grdMain.ColumnByName('Value').FooterValue := FloatToStrF(dValue1, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Hours').FooterValue := FloatToStrF(dValue2, ffFixed, 15, 4);
end;

procedure TLeaveAccruedDetailsListGUI.grdMainDblClick(Sender: TObject);
//var form: TBaseInputGUI;
begin
//  { form TfrmEmployeePay was not designed to have its keyid changed and
//    formshow called more than once (it crashes), also not designed to have
//    more than one instance open at a time!! ...
//    so always close existing instance before opening/re-showing new }
//  form:= TBaseInputGUI(FindExistingComponent('TfrmEmployeePay'));
//  if Assigned(form) then begin
//    form.Close;
//    Application.ProcessMessages;
//  end;
//  if not FormStillOpen('TfrmEmployeePay') then begin
    inherited;
//  end;
end;

initialization
  RegisterClassOnce(TLeaveAccruedDetailsListGUI);
end.
