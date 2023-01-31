{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/05/06  1.00.01 RM  Used by frmCashFlowStatement


}
unit CashFlowStatementObj;

interface
uses
  Classes;

type
  TCashFlowStatementObj = class(TObject)

  private

    fdtTo               : TDateTime;
    fsTempTableName     : string;
    fiClassID           : integer;
//    function AccntsRecievable(dtFrom:TDateTime;dtTo:TDateTime):double;
    procedure CreateTempCashFlowTable;
    procedure DeleteDataCashFlowTable;
    function AddDataToTempCashFlowTable:Boolean;
    function GetUserTempCashFlowName: string;
    function GetNetOperating(dtTo:TDateTime):double;
    function GetNetInvesting(dtTo:TDateTime):double;
  public
    constructor Create;
//    destructor Destroy; override;
    procedure CreateAndLoadTempTable;
    procedure DeleteTempCashFlowTable;
    property TempTableName :string read fsTempTableName;
    property dtTo : TDateTime read fdtTo write fdtTo;
//    property dtFrom:TDateTime read fdtFrom write fdtFrom;
    property ClassID: integer read fiClassID write fiClassID;
  end;

implementation

uses FastFuncs,CommonDbLib,DNMLib,MyAccess,ERPdbComponents,SysUtils, MySQLConst,
  SyncReportTableObj, MachineSignature;

function TCashFlowStatementObj.AddDataToTempCashFlowTable:Boolean;
var
  InsertSQL: string;
  qryTemp: TERPCommand;
  usingReportTables:boolean;
begin

  InsertSQL := 'INSERT HIGH_PRIORITY INTO ' + GetUserTempCashFlowName +
     '(Activity,Description,Amount,EndDate,Detail)';

  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    //Data
    DeleteDataCashFlowTable;
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add(InsertSQL);

    //OPERATING ACTIVITIES vvvvvvvvv OPERATING ACTIVITIES vvvvvvvvv OPERATING ACTIVITIES
    qryTemp.Sql.Add('SELECT ');
    qryTemp.Sql.Add('"Operating Activities          " as Activity,');   //( Main Heading)
    qryTemp.Sql.Add('Space(40) as Description,');
    qryTemp.Sql.Add('0 as Amount,');
    qryTemp.Sql.Add('NULL as Date,');
    qryTemp.Sql.Add('0 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add('GROUP BY Activity');


    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //( Sub Heading)
    qryTemp.Sql.Add('Space(40) as Activity,');
    qryTemp.Sql.Add('"Inflow" as Description,');
    qryTemp.Sql.Add('0 as Amount,');
    qryTemp.Sql.Add('NULL as Date,');
    qryTemp.Sql.Add('0 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add('GROUP BY Activity');


    qryTemp.Sql.Add(' UNION ALL');                            //Sales and Services
    qryTemp.Sql.Add('SELECT ');                               //(Summary)
    qryTemp.SQL.Add('Space(40) as Activity,');
    qryTemp.Sql.Add(' "    Sales and Services" as Description,');
    qryTemp.Sql.Add(' Sum(CreditsInc) - Sum(DebitsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('1 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "INC" OR AccountType = "EXINC"');
    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;

    qryTemp.Sql.Add('GROUP BY Detail');

    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //Details
    qryTemp.SQL.Add('Space(40) as Activity,');
    qryTemp.Sql.Add('Concat("        ", Type) as Description,');
    qryTemp.Sql.Add(' Sum(CreditsInc) - Sum(DebitsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('2 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "INC" OR AccountType = "EXINC"');
    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY AccountName');

    qryTemp.Sql.Add(' UNION ALL');                            //Accounts Recievable
    qryTemp.Sql.Add('SELECT ');                               //(Summary)
    qryTemp.SQL.Add('Space(40) as Activity,');
    qryTemp.Sql.Add(' "    Accounts Receivable" as Description,');
    qryTemp.Sql.Add(' Sum(DebitsInc) - Sum(CreditsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('1 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "AR"');

    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY Detail');

    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //Details
    qryTemp.SQL.Add('Space(40) as Activity,');
    qryTemp.Sql.Add('Concat("        ", Type) as Description,');
    qryTemp.Sql.Add(' Sum(DebitsInc) - Sum(CreditsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('2 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "AR"');

    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY AccountName');

    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //( Sub Heading)
    qryTemp.Sql.Add('Space(40) as Activity,');
    qryTemp.Sql.Add('"Outflow" as Description,');
    qryTemp.Sql.Add('0 as Amount,');
    qryTemp.Sql.Add('NULL as Date,');
    qryTemp.Sql.Add('0 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add('GROUP BY Activity');



    qryTemp.Sql.Add(' UNION ALL');                             //Employee Expenses
    qryTemp.Sql.Add('SELECT ');                               //(Summary)
    qryTemp.SQL.Add('Space(60) as Activity,');
    qryTemp.Sql.Add(' "    Employee Expenses" as Description,');
    qryTemp.Sql.Add(' Sum(DebitsInc) - Sum(CreditsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('1 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE Level1 = "Payroll Expenses"');
//    qryTemp.Sql.Add(' AND (AccountName = "Gross Wages" OR AccountName = "Super" OR AccountName = "Deductions")');
    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY Level1');


    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //Details
    qryTemp.SQL.Add('Space(60) as Activity,');
    qryTemp.Sql.Add('Concat("        ", Type) as Description,');
    qryTemp.Sql.Add(' Sum(DebitsInc)  - Sum(CreditsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('2 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE Level1 = "Payroll Expenses"');
//    qryTemp.Sql.Add(' AND (AccountName = "Gross Wages" OR AccountName = "Super")');
    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY AccountName');

    qryTemp.Sql.Add(' UNION ALL');                             //Accounts Payable
    qryTemp.Sql.Add('SELECT ');                               //(Summary)
    qryTemp.SQL.Add('Space(60) as Activity,');
    qryTemp.Sql.Add(' "    Accounts Payable" as Description,');
    qryTemp.Sql.Add(' Sum(DebitsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('1 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "AP"');
    qryTemp.Sql.Add(' AND AccountName = "Accounts Payable"');
    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY AccountType');

    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //Details
    qryTemp.SQL.Add('Space(60) as Activity,');
    qryTemp.Sql.Add('Concat("        ", Type) as Description,');
    qryTemp.Sql.Add(' Sum(DebitsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('2 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "AP"');
//    qryTemp.Sql.Add(' AND (AccountName = "  " OR AccountName = "  ")');
    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY AccountName');

        qryTemp.Sql.Add(' UNION ALL');                             //Payroll Liabilities
    qryTemp.Sql.Add('SELECT ');                               //(Summary)
    qryTemp.SQL.Add('Space(60) as Activity,');
    qryTemp.Sql.Add(' "    Payroll Liabilities" as Description,');
    qryTemp.Sql.Add('  Sum(CreditsInc) + Sum(DebitsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('1 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE Level1 = "Payroll Liabilities"');  //AccountType = "LTLIAB" or AccountType = "OCLIAB"');
//    qryTemp.Sql.Add(' AND Level1 = "Payroll Liabilities"');
    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY AccountType');

    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //Details
    qryTemp.SQL.Add('Space(60) as Activity,');
    qryTemp.Sql.Add('Concat("        ", Type) as Description,');
    qryTemp.Sql.Add(' Sum(DebitsInc)  - Sum(CreditsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('2 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE Level1 = "Payroll Liabilities"'); //qryTemp.Sql.Add(' WHERE AccountType = "AP"');
//    qryTemp.Sql.Add(' AND (AccountName = "  " OR AccountName = "  ")');
    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY AccountName');


    qryTemp.Sql.Add(' UNION ALL');                            //NET OPERATING ACTIVITIES
    qryTemp.Sql.Add('SELECT ');
    qryTemp.Sql.Add(' "    Net operating activities" as Activity,');
    qryTemp.SQL.Add('Space(40) as Description,');
    qryTemp.Sql.Add(FormatFloat('###########0.00',GetNetOperating(fdtTo)) + ' as Amount,');
    qryTemp.Sql.Add('NULL as Date,');                   //'Date,');
    qryTemp.Sql.Add('1 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
//    qryTemp.Sql.Add(' WHERE AccountType = "AP"');
//    qryTemp.Sql.Add(' AND AccountName = "Accounts Payable"');
//    qryTemp.Sql.Add(' AND Date <= ');
//    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    qryTemp.Sql.Add('GROUP BY Activity');

    //OPERATING ACTIVITIES ^^^^^^ OPERATING ACTIVITIES ^^^^^^^^^^^OPERATING ACTIVITIES


  //  //INVESTING ACTIVITIES vvvvvvv INVESTING ACTIVITIES vvvvvvvvv INVESTING ACTIVITIES

    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');
    qryTemp.Sql.Add('"Investing Activities          " as Activity,');   //(Main Heading)
    qryTemp.Sql.Add('Space(40) as Description,');
    qryTemp.Sql.Add('0 as Amount,');
    qryTemp.Sql.Add('NULL as Date,');
    qryTemp.Sql.Add('0 as Detail');

    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //( Sub Heading)
    qryTemp.Sql.Add('Space(40) as Activity,');
    qryTemp.Sql.Add('"Inflow" as Description,');
    qryTemp.Sql.Add('0 as Amount,');
    qryTemp.Sql.Add('NULL as Date,');
    qryTemp.Sql.Add('0 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add('GROUP BY Activity');

    qryTemp.Sql.Add(' UNION ALL');                            //Sale  proceeds for fixed assets
    qryTemp.Sql.Add('SELECT ');                               //(Summary)
    qryTemp.SQL.Add('Space(40) as Activity,');

    qryTemp.Sql.Add(' "    Sale proceeds Fixed assets" as Description,');
    qryTemp.Sql.Add(' Sum(CreditsInc) - Sum(DebitsInc) as Amount,');


    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('1 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "FIXASSET" AND Type = "Journal Entry"');

    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY Detail');

    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //Details
    qryTemp.SQL.Add('Space(40) as Activity,');
    qryTemp.Sql.Add('Concat("        ", Type) as Description,');
    qryTemp.Sql.Add(' Sum(CreditsInc) - Sum(DebitsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('2 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "FIXASSET" AND Type = "Journal Entry"');

    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY AccountName');


    qryTemp.Sql.Add(' UNION ALL');                            //Depreciation of fixed assets
    qryTemp.Sql.Add('SELECT ');                               //(Summary)
    qryTemp.SQL.Add('Space(40) as Activity,');

    qryTemp.Sql.Add(' "    Depreciation Fixed Assets" as Description,');
    qryTemp.Sql.Add(' Sum(CreditsInc) - Sum(DebitsInc) as Amount,');

    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('1 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "FIXASSET" AND Type = "Fixed Asset Depreciation"');

    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY Detail');

    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //Details
    qryTemp.SQL.Add('Space(40) as Activity,');
    qryTemp.Sql.Add('Concat("        ", Type) as Description,');
    qryTemp.Sql.Add(' Sum(CreditsInc) - Sum(DebitsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('2 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "FIXASSET" AND Type = "Fixed Asset Depreciation"');

    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY AccountName');

    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //( Sub Heading)
    qryTemp.Sql.Add('Space(40) as Activity,');
    qryTemp.Sql.Add('"Outflow" as Description,');
    qryTemp.Sql.Add('0 as Amount,');
    qryTemp.Sql.Add('NULL as Date,');
    qryTemp.Sql.Add('0 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add('GROUP BY Activity');


    qryTemp.Sql.Add(' UNION ALL');                            //Payment for fixed assets
    qryTemp.Sql.Add('SELECT ');                               //(Summary)
    qryTemp.SQL.Add('Space(40) as Activity,');
    qryTemp.Sql.Add(' "    Fixed assets payments" as Description,');
    qryTemp.Sql.Add('  Sum(DebitsInc) - Sum(CreditsInc) as Amount,');

    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('1 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "FIXASSET" AND Type = "Fixed Asset"');

    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY Detail');

    qryTemp.Sql.Add(' UNION ALL');
    qryTemp.Sql.Add('SELECT ');                               //Details
    qryTemp.SQL.Add('Space(40) as Activity,');
    qryTemp.Sql.Add('Concat("        ", Type) as Description,');
    qryTemp.Sql.Add('  Sum(DebitsInc) - Sum(CreditsInc) as Amount,');
    qryTemp.Sql.Add('Date,');
    qryTemp.Sql.Add('2 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add(' WHERE AccountType = "FIXASSET" AND Type = "Fixed Asset"');
    qryTemp.Sql.Add(' AND Date <= ');
    qryTemp.SQL.Add(QuotedStr(FormatDateTime(MysqlDateFormat, Fdtto)));
    if fiClassID <> 0 then begin
       qryTemp.SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
    end;
    qryTemp.Sql.Add('GROUP BY AccountName');   


    qryTemp.Sql.Add(' UNION ALL');                            //NET INVESTING ACTIVITIES
    qryTemp.Sql.Add('SELECT ');
    qryTemp.Sql.Add(' "    Net investing activities" as Activity,');
    qryTemp.SQL.Add('Space(40) as Description,');
    qryTemp.Sql.Add(FormatFloat('###########0.00',GetNetInvesting(fdtTo)) + ' as Amount,');
    if GetNetInvesting(fdtTo)  <= 0 then
      qryTemp.Sql.Add('NULL as Date,')
    else
      qryTemp.Sql.Add('Date,');

    qryTemp.Sql.Add('1 as Detail');

    qryTemp.Sql.Add('FROM tbltransactions');
    qryTemp.Sql.Add('GROUP BY Activity');
    //INVESTING ACTIVITIES ^^^^^^^^ INVESTING ACTIVITIES ^^^^^^^^^ INVESTING ACTIVITIES

    qryTemp.SQL.text := SyncReportObj.ChangeQuery(qryTemp.SQL.text, usingReportTables);

    qryTemp.Execute;
    result := true;
  finally
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;

function TCashFlowStatementObj.GetNetOperating(dtTo:TDateTime):double;
var
  qry:TERPQuery;
  dInflow,dOutflow:double;
  usingReportTables:Boolean;
begin
  qry := TERPQuery.Create(nil);
  with qry do begin
    try
        Options.FlatBuffers := True;
        Connection := CommonDbLib.GetSharedMyDacConnection;
        SQL.Clear;
        SQL.Add('SELECT Type,Sum(DebitsInc) + Sum(CreditsInc) as Amount,Date,1 as Detail');
        SQL.Add('FROM tbltransactions');
        SQL.Add('WHERE AccountType = "AR" OR AccountType = "INC" OR AccountType = "EXINC"');
        SQL.Add('GROUP BY Detail');
        SQL.text := SyncReportObj.ChangeQuery(SQL.text , usingReportTables);
        Open;
        First;
        dInflow := 0;
        while not Eof do begin
          dInflow :=  dInflow + FieldByName('Amount').AsFloat;
          next;
        end;

        Close;

        SQL.Clear;
        SQL.Add('SELECT Type,- Sum(DebitsInc) + Sum(CreditsInc) as Amount,Date,1 as Detail');
        SQL.Add('FROM tbltransactions');
        SQL.Add('WHERE Level1 = "Payroll Expenses"');
        SQL.Add('AND Type <> "Payroll Deductions"');
        SQL.Add('GROUP BY Level1');
        SQL.Add('UNION ALL');
        SQL.Add('SELECT Type, -Sum(DebitsInc)  as Amount,Date,1 as Detail');
        SQL.Add('FROM tbltransactions');
        SQL.Add('WHERE AccountType = "AP"');
        SQL.Add('AND AccountName = "Accounts Payable"');
        SQL.Add('GROUP BY AccountType');
        SQL.Add('UNION ALL');
        SQL.Add('SELECT Type, Sum(DebitsInc) - Sum(CreditsInc) as Amount,Date,1 as Detail');
        SQL.Add('FROM tbltransactions');
        SQL.Add('WHERE Level1 = "Payroll Liabilities"');
        SQL.Add('AND Type <> "Payroll Deductions"');
        SQL.Add('GROUP BY AccountType');
        SQL.text := SyncReportObj.ChangeQuery(SQL.text, usingReportTables);
        Open;

        First;
        dOutflow := 0;
        while not Eof do begin
          dOutflow :=  dOutflow + FieldByName('Amount').AsFloat;
          next;
        end;
        result := dInflow + dOutflow;      //outflow is negative 
    finally
      FreeAndNil(qry);
    end;
  end;
end;

function TCashFlowStatementObj.GetNetInvesting(dtTo:TDateTime):double;
var
  qry:TERPQuery;
  dInflow,dOutflow:double;
  usingReportTables:Boolean;
begin
  qry := TERPQuery.Create(nil);
  try
    with qry do begin
      Options.FlatBuffers := True;
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;
      SQL.Add('SELECT Sum(DebitsInc) as Total FROM tbltransactions');
      SQL.Add('WHERE AccountType = ');
      SQL.Add(QuotedStr('FIXASSET'));
      SQL.Add(' AND Type = ' + QuotedStr('Fixed Asset'));
      if fiClassID <> 0 then begin
       SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
      end;
      SQL.Add(' AND Date <= ' +  QuotedStr(FormatDateTime(MysqlDateFormat, dtTo)));
      SQL.Add(' GROUP BY AccountType');
      SQL.text := SyncReportObj.ChangeQuery(SQL.text , usingReportTables);
      Open;

      dOutflow := FieldByName('Total').AsFloat;

      if Active then Close;
      SQL.Clear;
      SQL.Add('SELECT - Sum(DebitsInc) + Sum(CreditsInc) as Total FROM tbltransactions');
      SQL.Add('WHERE AccountType = ');
      SQL.Add(QuotedStr('FIXASSET'));
      SQL.Add(' AND Type = ' + QuotedStr('Fixed Asset Depreciation'));
      if fiClassID <> 0 then begin
       SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
      end;
      SQL.Add(' AND Date <= ' +  QuotedStr(FormatDateTime(MysqlDateFormat, dtTo)));
      SQL.Add(' GROUP BY AccountType');
      SQL.text := SyncReportObj.ChangeQuery(SQL.text , usingReportTables);
      Open;

      dInflow := FieldByName('Total').AsFloat;

      result := dInflow - dOutflow;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TCashFlowStatementObj.CreateAndLoadTempTable;
begin
  CreateTempCashFlowTable;
  AddDataToTempCashFlowTable;
end;

procedure TCashFlowStatementObj.DeleteTempCashFlowTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + GetUserTempCashFlowName + ' ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;


function TCashFlowStatementObj.GetUserTempCashFlowName: string;
begin
  Result := 'tmp_cashflow_' + MachineSignature.GetMachineIdentification(true, true, true, true);
end;

procedure TCashFlowStatementObj.CreateTempCashFlowTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + GetUserTempCashFlowName + ' ');
    qryTemp.Execute;

    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('CREATE TABLE IF NOT EXISTS ' + GetUserTempCashFlowName + ' ( ');

    qryTemp.Sql.Add('`ID` int(11) NOT NULL auto_increment,');
    qryTemp.Sql.Add('`Activity` varchar(128) default NULL,');
    qryTemp.Sql.Add('`Description` varchar(64) default NULL,');
    qryTemp.Sql.Add('`Amount` double default "0",');
    qryTemp.SQL.Add('`EndDate` datetime default NULL,');
    qryTemp.Sql.Add('`Detail` tinyint(3) default "0",');
    qryTemp.Sql.Add('PRIMARY KEY  (`ID`),');
    qryTemp.Sql.Add('KEY `ID` (`ID`)');
    qryTemp.Sql.Add(') ENGINE=InnoDB;');

    qryTemp.Execute;
    fsTempTableName := GetUserTempCashFlowName;
  finally
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;

procedure TCashFlowStatementObj.DeleteDataCashFlowTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DELETE FROM  ' + GetUserTempCashFlowName + '; ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

constructor TCashFlowStatementObj.Create;
begin
  Inherited;
end;


end.
