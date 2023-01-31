unit RosterExceptionsListGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess,ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, DateUtils, ComCtrls,AdvOfficeStatusBar, Math,  wwdblook,
  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TfrmRosterExceptionsList = class(TBaseListingGUI)
    procedure actRefreshQryExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
  private
    { Private declarations }
    procedure SearchPeriod;
    procedure LoadExceptions(const EmpID: integer; const EmpName: string; const dtDate: TDate);
    procedure Summary;
    procedure Details;

    procedure CreateTemporaryTable;
    function GetTemporaryTableName: string;
    procedure ClearTemporaryTable;
    procedure DropTemporaryTable;

  public
    { Public declarations }
    procedure RefreshQuery; override;
  end;

implementation

uses
  CommonDbLib, CommonLib, Forms, FastFuncs, MySQLConst;
{$R *.dfm}

procedure TfrmRosterExceptionsList.actRefreshQryExecute(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmRosterExceptionsList.RefreshQuery;
begin
  qryMain.Close;
  SearchPeriod;
  if grpFilters.ItemIndex = 0 then begin
    Summary;
  end else begin
    Details;
  end;
  
  inherited;
end;

procedure TfrmRosterExceptionsList.SearchPeriod;
var
  iDaysInPeriod, i, j: integer;
  dtDate: TDate;
  qryEmp: TERPQuery;
  qryEmpName: TERPQuery;
begin
  ClearTemporaryTable;
  qryEmp := TERPQuery.Create(self);
  qryEmp.Options.FlatBuffers := True;
  qryEmp.Connection := qryMain.Connection;
  qryEmp.SQL.Clear;
  //Get a list of employees in this period
  qryEmp.SQL.Add('SELECT EmployeeID,Date FROM tblroster WHERE Date BETWEEN ' +
    QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom.Date)) + ' AND ' +
    QuotedStr(FormatDateTime(MysqlDateFormat, dtTo.Date)) + ' GROUP BY EmployeeID');

  qryEmpName := TERPQuery.Create(self);
  qryEmpName.Options.FlatBuffers := True;
  qryEmpName.Connection := qryMain.Connection;

  try
    qryEmp.Open;
    qryEmp.First;
    iDaysInPeriod := DaysBetween(dtTo.Date, dtFrom.Date);

    for J := 1 to qryEmp.RecordCount do begin   //for every employee
      dtDate := dtFrom.Date;
      if qryEmpName.Active then qryEmpName.Close;
      qryEmpName.SQL.Clear;
      qryEmpName.SQL.Add('SELECT EmployeeID,EmployeeName FROM tblemployees WHERE EmployeeID = ' //Get their name
        + IntToStr(qryEmp.FieldByName('EmployeeID').AsInteger));
      qryEmpName.Open;

      for i := 0 to iDaysInPeriod do begin       //go thru each day
        LoadExceptions(qryEmp.FieldByName('EmployeeID').AsInteger, qryEmpName.FieldByName('EmployeeName').AsString, dtDate);
        dtDate := dtDate + 1;
      end;
      qryEmp.Next;
    end;
  finally
    FreeAndNil(qryEmp);
    FreeAndNil(qryEmpName);
  end;
end;

procedure TfrmRosterExceptionsList.LoadExceptions(const EmpID: integer; const EmpName: string; const dtDate: TDate);
var
  qry, qryTemp: TERPQuery;
  i: integer;
  dClockedHrs, dAllocatedHrs, DiffHrs: double;
  sType: string;
begin
  qry := TERPQuery.Create(self);
  qry.Options.FlatBuffers := True;
  qry.Connection := qryMain.Connection;
  qryTemp := TERPQuery.Create(self);
  qryTemp.Connection := qryMain.Connection;
  dClockedHrs := 0;
  dAllocatedHrs := 0;
  try
    with qry do begin
      if Active then Close;
      SQL.Clear;
      SQL.Add('SELECT Type,Date,hours,EmployeeID FROM tblroster WHERE Date = ' +
        QuotedStr(FormatDateTime(MysqlDateFormat, dtDate)) + ' AND EmployeeID = ' + IntToStr(EmpID));
      Open;
      First;
      for i := 1 to RecordCount do begin
        if FieldByName('Type').AsString = 'Clocked' then begin
          dClockedHrs := dClockedHrs + FieldByName('Hours').AsFloat;
          sType := 'Clocked';
        end else begin
          dAllocatedHrs := dAllocatedHrs + FieldByName('Hours').AsFloat;
          sType := 'Allocated';
        end;
        Next;
      end;
      dAllocatedHrs := RoundTo(dAllocatedHrs, - 4);
      dClockedHrs := RoundTo(dClockedHrs, - 4);
      if dAllocatedHrs <> dClockedHrs then begin
        DiffHrs := dClockedHrs - dAllocatedHrs;
        qryTemp.SQL.Clear;
        qryTemp.SQL.Add('INSERT HIGH_PRIORITY INTO `' + GetTemporaryTableName + '` (Date, Type, EmployeeID, EmployeeName,');
        qryTemp.SQL.Add(' AllocatedHrs, ClockedHrs, HoursDifference) VALUES (' + QuotedStr(FormatDateTime(MysqlDateFormat, dtDate)));
        qryTemp.SQL.Add(',' + QuotedStr(sType) + ',' + IntToStr(EmpID) + ',' + QuotedStr(EmpName) + ',');
        qryTemp.SQL.Add(Format('%f,%f,%f)', [dAllocatedHrs, dClockedHrs, DiffHrs]));

        qryTemp.Execute;
      end;
    end;

  finally
    FreeAndNil(qry);
    FreeAndNil(qryTemp);
  end;
end;

procedure TfrmRosterExceptionsList.CreateTemporaryTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
  qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('CREATE TABLE IF NOT EXISTS `' + GetTemporaryTableName + '` (`ExceptionID` INT(255) NOT NULL AUTO_INCREMENT,');
    qry.SQL.Add('`Date` DATE, `Type` VARCHAR (255), `EmployeeID` INT (11) DEFAULT "0",');
    qry.SQL.Add('`EmployeeName` VARCHAR (255),`AllocatedHrs` Double , `ClockedHrs` Double, `HoursDifference` Double,');
    qry.SQL.Add('PRIMARY KEY(`ExceptionID`))  ENGINE = InnoDB;');

    qry.Execute;

  finally
    FreeAndNil(qry);
  end;
end;

procedure TfrmRosterExceptionsList.FormCreate(Sender: TObject);
begin
  inherited;
  CreateTemporaryTable;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT * FROM `' + GetTemporaryTableName + '`;');
end;

function TfrmRosterExceptionsList.GetTemporaryTableName: string;
begin
  Result := 'tmp_roster_exceptions' + GetMachineIdentification(true, true, true, true);
end;

procedure TfrmRosterExceptionsList.ClearTemporaryTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM `' + GetTemporaryTableName + '`;');
    qry.Execute;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmRosterExceptionsList.DropTemporaryTable;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('DROP TABLE IF EXISTS `' + GetTemporaryTableName + '`;');
    qry.Execute;
  finally

    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmRosterExceptionsList.FormDestroy(Sender: TObject);
begin
  DropTemporaryTable;
  inherited;
end;


procedure TfrmRosterExceptionsList.grpFiltersClick(Sender: TObject);
begin
  RefreshQuery;

  inherited;
end;

procedure TfrmRosterExceptionsList.Summary;
begin
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT EmployeeName,Sum(AllocatedHrs) as AllocatedHours,');
  qryMain.SQL.Add('Sum(ClockedHrs) as ClockedHours, Sum(HoursDifference) as HoursDifference ');
  qryMain.SQL.Add('FROM ' + GetTemporaryTableName);
  qryMain.SQL.Add('GROUP BY EmployeeName');

  qryMain.Open;

  grdMain.ColumnByName('EmployeeName').DisplayWidth := 15;
end;

procedure TfrmRosterExceptionsList.Details;
begin
  with qryMain do begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT EmployeeName,Date,Type,AllocatedHrs, ClockedHrs, HoursDifference FROM ' + GetTemporaryTableName);
    Open;

    grdMain.ColumnByName('Type').DisplayWidth         := 15;
    grdMain.ColumnByName('EmployeeName').DisplayWidth := 15;
  end;
end;

initialization
  RegisterClassOnce(TfrmRosterExceptionsList);
end.
