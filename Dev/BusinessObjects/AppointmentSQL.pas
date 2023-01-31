unit AppointmentSQL;

interface

uses
  classes, ReportBaseObj;

type

  TAppointmentList = class(TReportWithDateRangeBase)

  private
    fbIsDetailReport: Boolean;

  protected

  public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  published
    property IsDetailReport: boolean read fbIsDetailReport write fbIsDetailReport;
  //  property ByCustomer             : Boolean   Write fbByCustomer  ;

  end;


implementation

uses sysutils, ProductQtyLib;

{ TSalesList }

constructor TAppointmentList.Create;
begin
  inherited;
  DateFrom             := MinDateTime;
  DateTo               := MaxDateTime;
 end;


(*function TSalesList.DateFromSQL: string;
begin
  REsult := DateSQL(fDateFrom, 'DateFrom');
end;
function TSalesList.DateToSQL: string;
begin
  REsult := DateSQL(fDateTo, 'DateTo');
end;*)

function TAppointmentList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  SQL.Clear;
  result := inherited;

  if IsDetailReport then begin
    SQL.Add('SELECT tblappointments.*, T.* FROM tblappointments');
    SQL.Add(' LEFT JOIN tblappointmentstimelog T ON tblappointments.AppointID = T.AppointID');
    SQL.Add(' WHERE tblappointments.AppDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);
  end
  else begin
    SQL.Add('SELECT tblappointments.* FROM tblappointments');
    SQL.Add(' WHERE tblappointments.AppDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);
  end;

  if not (Search = '') then
    SQL.Add('AND tblappointments.' + Search);

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy);

end;





initialization

  RegisterClass(TAppointmentList);

end.
