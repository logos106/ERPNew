unit StatementRunnBalListQL;

interface

Uses StatementListQL, classes;

Type

  TStatementForCustomerRunnBalance = Class(TStatementForCustomer)
  Private
    SQLfinal            : String;
    fsRTTablename	      : String ;
    fsTablename	        : String;
    fsTempTblName	      : String;
    fsRTDetailTablename : String ;
    fBalOnDaterange	    : Boolean;
    fCurDate	          : TDateTime;
    fincludeSalesOrder	: Boolean;
    fincludeinvoiceBO	  : Boolean;
    fincludeSOBO	      : Boolean;
    fbasedonoptionsIndex: Integer;
    fReportDateFrom 	  : TDateTime;
    fReportDateTo 	    : TDateTime;
    fClientID	          : integer;
    fGroupJobs	        : Boolean;
    fRelatedCustomer	  : Boolean;
    fshowPaid	          : Boolean;
    fAllClass	          : Boolean;
    fSelectedClass	    : String;
    fClassID	          : Integer;
    fOrderOptionsIndex	: Integer;
    fReportClassname	  : String;
    fiSQLNo             : Integer;

    Procedure initParams;

  Protected
  Public
    constructor Create; Override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Published
    Property BalOnDaterange      : Boolean    read fBalOnDaterange      write fBalOnDaterange  ;
    Property CurDate             : TDateTime  read fCurDate             write fCurDate  ;
    Property includeSalesOrder   : Boolean    read fincludeSalesOrder   write fincludeSalesOrder  ;
    Property includeinvoiceBO    : Boolean    read fincludeinvoiceBO    write fincludeinvoiceBO  ;
    Property includeSOBO         : Boolean    read fincludeSOBO         write fincludeSOBO  ;
    Property basedonoptionsIndex : Integer    read fbasedonoptionsIndex write fbasedonoptionsIndex   ;
    Property ReportDateFrom      : TDateTime  read fReportDateFrom      write fReportDateFrom   ;
    Property ReportDateTo        : TDateTime  read fReportDateTo        write fReportDateTo   ;
    Property ClientID            : integer    read fClientID            write fClientID  ;
    Property GroupJobs           : Boolean    read fGroupJobs           write fGroupJobs  ;
    Property RelatedCustomer     : Boolean    read fRelatedCustomer     write fRelatedCustomer  ;
    Property showPaid            : Boolean    read fshowPaid            write fshowPaid  ;
    Property AllClass            : Boolean    read fAllClass            write fAllClass  ;
    Property SelectedClass       : String     read fSelectedClass       write fSelectedClass  ;
    Property OrderOptionsIndex   : Integer    read fOrderOptionsIndex   write fOrderOptionsIndex  ;
    Property ReportClassname     : String     read fReportClassname     write fReportClassname  ;
    Property SQLNo               : Integer    read fiSQLNo              Write fiSQLNo;
  End;
implementation

uses StatementsLib, TempTableUtils, SystemLib, CommonDbLib,
  StatementsRunnBalLib, sysutils, CommonLib, BusObjClass;

constructor TStatementForCustomerRunnBalance.Create;
begin
  inherited;
  fsRTTablename         := GetUserTemporaryTableName('StatementRT');
  fsTablename           := GetUserTemporaryTableName('Statements');
  fsTempTblName         := GetUserTemporaryTableName('Statementsum');
  fsRTDetailTablename   := GetUserTemporaryTableName('StatementRTDetail');
  BalOnDaterange      := False;
  CurDate             := Date;
  includeSalesOrder   := False;
  includeinvoiceBO    := False;
  includeSOBO         := False;
  basedonoptionsIndex := 0;
  ReportDateFrom      := Date - 120;
  ReportDateTo        := Date;
  ClientID            := 0;
  GroupJobs           := False;
  RelatedCustomer     := False;
  showPaid            := False;
  AllClass            := True;
  SelectedClass       := '';
  OrderOptionsIndex   := 0;
  ReportClassname     := '';
  SQLNo                 := 5;
end;


destructor TStatementForCustomerRunnBalance.Destroy;
begin
  CommonDbLib.DestroyUserTemporaryTable(fsTempTblName);
  CommonDbLib.DestroyUserTemporaryTable(fsTablename);
  CommonDbLib.DestroyUserTemporaryTable(fsRTTablename);
  CommonDbLib.DestroyUserTemporaryTable(fsRTDetailTablename);
  inherited;
end;

procedure TStatementForCustomerRunnBalance.initParams;
begin
    sParams.fsRTTablename := fsRTTablename	;
    sParams.fsTablename := fsTablename	;
    sParams.fsTempTblName := fsTempTblName	;
    sParams.fsRTDetailTablename := fsRTDetailTablename	;
    sParams.BalOnDaterange := fBalOnDaterange	;
    sParams.CurDate := fCurDate	;
    sParams.includeSalesOrder := fincludeSalesOrder	;
    sParams.includeinvoiceBO := fincludeinvoiceBO	;
    sParams.includeSOBO := fincludeSOBO	;
    sParams.basedonoptionsIndex := fbasedonoptionsIndex	;
    sParams.ReportDateFrom  := DateFrom 	;
    sParams.ReportDateTo  := DateTo 	;
    sParams.ClientID := fClientID	;
    sParams.GroupJobs := fGroupJobs	;
    sParams.RelatedCustomer := fRelatedCustomer	;
    sParams.showPaid := fshowPaid	;
    sParams.AllClass := fAllClass	;
    sParams.SelectedClass := fSelectedClass	;
    sParams.ClassID := TDeptClass.IDToggle(fSelectedClass);
    sParams.OrderOptionsIndex := fOrderOptionsIndex	;
    sParams.ReportClassname := fReportClassname	;
end;

function TStatementForCustomerRunnBalance.PopulateReportSQL(SQL: TStrings;var msg: string): boolean;
var
  s:String;
begin
  initParams;
  StatementsRunnBalLib.CreateRunningBalanceStatement(SQLFinal);
  StatementsRunnBalLib.PopulateTransDetails;
  SQLFinal := SQLFinal + '~|||~'+'Select * from ' + SParams.fsRTDetailTablename;

  s:= trim(ExtractStrPortion(SQLFinal, '~|||~', SQLNo));
  if (Pos('{', s) =1) and (Pos('}', s) > 0) then
    s:= copy(s,Pos('}', s)+1, length(s));

  // just incase if the sqlno is not provided, this is the default value
  if trim(s)='' then s:='Select * from ' + SParams.fsRTDetailTablename;

  SQL.clear;
  SQL.add(s);

  Result := True;
end;


initialization
  RegisterClass(TStatementForCustomerRunnBalance);

end.
