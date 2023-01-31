{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 05/05/06  1.00.01 RM  Created this obj to keep CashFlowReportGUI simple and
                       hopefully steer away from the usual huge sql statements
                       and make later changes easier.
                       Calculates and loads everything into a TStringList, then
                       loads the list to the temp table for the Form.

}

unit CashFlowForecastObj;

interface

uses
  ERPdbComponents,Classes;

Type
  TempAccRec = class(TObject)
  private
  public
    TimePeriodRange     : String;
    StartDate           : TDateTime;
    EndDate             : TDateTime;
    AccntsRec           : Double;
    AccntsPay           : Double;
    BankAccnts          : Double;
    NetInflows          : Double;
    ProjBalance         : Double;
  end;


type
  TCashFlowObj = class(TObject)

  private
    fsDebug             : string;
    fdBeginningBalance  : double;
    fdNewBalance        : double;
    fdTotalRec          : double;
    fdTotalPay          : double;
    fdTotalBank         : double;
    fsTimePeriod        : string;
    fsTempTableName     : string;
    fdtFrom,fdtTo       : TDateTime;
    fiClassID           : integer;
    AccRecList : TList;
    fQryAccntsRecievable :TERPQuery;
    fQryAccntsPayable :TERPQuery;
    procedure LoadList;
    procedure LoadListToTempTable;
    procedure createTmp_tblcashflow;
    procedure LoadBeginBalance;
    procedure LoadEndBalance;
    function AccntsRecievable(dtFrom:TDateTime;dtTo:TDateTime):double;
    function AccntsPayable(dtFrom:TDateTime;dtTo:TDateTime):double;
    function BankAccounts(dtFrom:TDateTime;dtTo:TDateTime):double;
    //function GetTempTableName: string;
    function QryAccntsRecievable: TERPQuery;
    function QryAccntsPayable: TERPQuery;
    procedure Logrec(const value:Integer;rec: TempAccRec);
  public
    property sDebug: string read fsDebug;
    property ClassID: integer read fiClassID write fiClassID;
    property TempTableName :string read fsTempTableName;
    property dtTo : TDateTime read fdtTo write fdtTo;
    property dtFrom:TDateTime read fdtFrom write fdtFrom;
    property sTimePeriod:string read fsTimePeriod write fsTimePeriod;
    constructor Create;
    destructor Destroy; override;
    procedure CreateAndLoadTempTable;
    procedure DeleteTempTable;
  end;

implementation

uses
  DateUtils,DNMLib,SysUtils,MyAccess,CommonDbLib,
  FastFuncs, MySQLConst, SyncReportTableObj, MachineSignature, LogLib,
  DbSharedObjectsObj;

procedure TCashFlowObj.CreateAndLoadTempTable;
begin
  fdNewBalance := 0;
  createTmp_tblcashflow;
  LoadList;
  LoadBeginBalance;
  LoadListToTempTable;
  LoadEndBalance;
end;

procedure TCashFlowObj.DeleteTempTable;
begin
  DestroyUserTemporaryTable(fsTempTableName);
(*var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('DROP TABLE IF EXISTS ' + fsTempTableName + ' ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;*)
end;

function TCashFlowObj.AccntsRecievable(dtFrom:TDateTime;dtTo:TDateTime):double;
begin
    with qryAccntsRecievable do begin
      if active then close;
      Parambyname('datefrom').asDatetime := dtFrom;
      Parambyname('dateTo').asDatetime := dtTo;
      Parambyname('ClassId').asInteger := fiClassId;
      Open;
      Logtext('1:'+'AR:' + SQLtext);
      result := FieldByName('Total').AsFloat;
      Logtext('2:'+Floattostr(result));
    end;
end;
function TCashFlowObj.AccntsPayable(dtFrom:TDateTime;dtTo:TDateTime):double;
begin
    with qryAccntsPayable do begin
      if active then close;
      Parambyname('datefrom').asDatetime := dtFrom;
      Parambyname('dateTo').asDatetime := dtTo;
      Parambyname('ClassId').asInteger := fiClassId;
      Open;
      Logtext('3:'+'AP:' + SQLtext);
      result := FieldByName('Total').AsFloat;
      Logtext('4:'+Floattostr(result));
    end;
end;

function TCashFlowObj.BankAccounts(dtFrom:TDateTime;dtTo:TDateTime):double;
//var
//  qry:TERPQuery;
begin
  result:= 0;
//  qry := TERPQuery.Create(nil);
//  try
//    with qry do begin
//      Options.FlatBuffers := True;
//      Connection := CommonDbLib.GetSharedMyDacConnection;
//      SQL.Clear;
//      SQL.Add('SELECT Sum(DebitsInc)-Sum(CreditsEx) as Total FROM tbltransactions');
//      SQL.Add('WHERE AccountName = ');
//      SQL.Add(QuotedStr(UNDEPOSITED_FUNDS));
//      if fiClassID <> 0 then begin
//       SQL.Add(' AND ClassID = ' + IntToStr(fiClassID));
//      end;
//      SQL.Add(' AND Date BETWEEN ' +  QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom)));
//      SQL.Add(' AND ' +  QuotedStr(FormatDateTime(MysqlDateFormat, dtTo)));
//      SQL.Add(' GROUP BY AccountType');
//      Open;
//
//      result := FieldByName('Total').AsFloat;
//    end;
//  finally
//    FreeAndNil(qry);
//  end;
end;

procedure TCashFlowObj.LoadBeginBalance;
var
  qry   : TERPQuery;
  dAccntsRecievable,dAccntsPayable,dBankAccnts: double;
begin
    Logtext('5:'+'LoadBeginBalance');
    qry := TERPQuery.Create(nil);
    try
      with qry do begin
        dAccntsRecievable := AccntsRecievable(IncYear(fdtFrom, -20),fdtFrom) ;
        dAccntsPayable    := AccntsPayable(IncYear(fdtFrom, -20),fdtFrom);
        dBankAccnts       := BankAccounts(IncYear(fdtFrom, -20),fdtFrom);
        Options.FlatBuffers := True;
        Connection := CommonDbLib.GetSharedMyDacConnection;
        SQL.Clear;
        SQL.Add('SELECT * FROM ' + fsTempTableName);
        Open;

        Insert;
        FieldByName('TimePeriod').AsString  := 'Beginning Balance';
        FieldByName('AccntsRec').AsFloat  :=dAccntsRecievable;
        FieldByName('AccntsPay').AsFloat  := dAccntsPayable;
        FieldByName('BankAccnts').AsFloat  := dBankAccnts;
        FieldByName('ProjBalance').AsFloat  := dAccntsRecievable - dAccntsPayable + dBankAccnts;
        Post;
        Logtext('6:'+FieldByName('TimePeriod').AsString+','+
                Floattostr(FieldByName('AccntsRec').AsFloat)+','+
                Floattostr(FieldByName('AccntsPay').AsFloat)+','+
                Floattostr(FieldByName('BankAccnts').AsFloat)+','+
                Floattostr(FieldByName('ProjBalance').AsFloat));

                       //initialise
        fdBeginningBalance := dAccntsRecievable - dAccntsPayable + dBankAccnts;
        fdNewBalance := fdBeginningBalance;
                        //Add beginning balances to list balances
        fdTotalRec := fdTotalRec + dAccntsRecievable;
        fdTotalPay := fdTotalPay + dAccntsPayable;
        fdTotalBank := fdTotalBank + dBankAccnts;
      end;
    finally
      FreeAndNil(qry);
    end;
end;

procedure TCashFlowObj.LoadEndBalance;
var
  qry   : TERPQuery;
begin
    Logtext('7:'+'LoadEndBalance');
    qry := TERPQuery.Create(nil);
    try
      with qry do begin
        Options.FlatBuffers := True;
        Connection := CommonDbLib.GetSharedMyDacConnection;
        SQL.Clear;
        SQL.Add('SELECT * FROM ' + fsTempTableName);
        Open;

        Insert;
        FieldByName('TimePeriod').AsString  := 'Ending Balance';
        FieldByName('AccntsRec').AsFloat  := fdTotalRec;
        FieldByName('AccntsPay').AsFloat  := fdTotalPay;
        FieldByName('BankAccnts').AsFloat  := fdTotalBank;
        FieldByName('ProjBalance').AsFloat  := fdTotalRec - fdTotalPay + fdTotalBank;
        Post;

      end;
    finally
      FreeAndNil(qry);
    end;
end;

procedure TCashFlowObj.LoadListToTempTable;
var
  qry   : TERPQuery;
  i     : integer;
begin
  Logtext('8:'+'LoadListToTempTable');
  qry := TERPQuery.Create(nil);
  try
    with qry do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      Options.FlatBuffers := True;
      SQL.Clear;
      SQL.Add('SELECT * FROM ' + fsTempTableName);
      Open;

      for i := 0 to AccRecList.Count - 1 do
      begin
         Insert;

         FieldByName('TimePeriod').AsString     := TempAccRec(AccRecList[i]).TimePeriodRange;
         FieldByName('StartDate').AsDateTime    := TempAccRec(AccRecList[i]).StartDate;
         FieldByName('EndDate').AsDateTime      := TempAccRec(AccRecList[i]).EndDate;
         FieldByName('AccntsRec').AsFloat       := TempAccRec(AccRecList[i]).AccntsRec;

         FieldByName('AccntsPay').AsFloat       := TempAccRec(AccRecList[i]).AccntsPay;
         FieldByName('BankAccnts').AsFloat      := TempAccRec(AccRecList[i]).BankAccnts;
         FieldByName('NetInFlow').AsFloat       := TempAccRec(AccRecList[i]).NetInflows;
         FieldByName('ProjBalance').AsFloat     := TempAccRec(AccRecList[i]).ProjBalance;
         Post;
         Logrec(11,TempAccRec(AccRecList[i]));

      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TCashFlowObj.createTmp_tblcashflow;
var
  qry: TERPCommand;
begin
  qry := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    with qry do begin
      SQL.Add('DROP TABLE IF EXISTS ' + fsTempTableName + ';');
      Execute;

      while AccRecList.Count > 0 do begin   //clear list
        TempAccRec(AccRecList[0]).Free;
        AccRecList.Delete(0);
      end;

      SQL.Clear;
      SQL.Add('CREATE TABLE ' + fsTempTableName + ' (');
      SQL.Add('`ID` int(11) NOT NULL auto_increment,');
      SQL.Add('`TimePeriod` varchar(32) default NULL,');
      SQL.Add('`StartDate` datetime default NULL,');
      SQL.Add('`EndDate` datetime default NULL,');
      SQL.Add('`AccntsRec` double default "0",');
      SQL.Add('`AccntsPay` double default "0",');
      SQL.Add('`BankAccnts` double default "0",');
      SQL.Add('`NetInflow` double default "0",');
      SQL.Add('`ProjBalance` double default "0",');

      SQL.Add('PRIMARY KEY  (`ID`),');
      SQL.Add('KEY `ID` (`ID`)');
      SQL.Add(')  ENGINE=InnoDB;');
      clog(SQL.Text);
      Execute;
   end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

(*function TCashFlowObj.GetTempTableName: string;
begin
  Result := 'tmp_tblcashflow_' + MachineSignature.GetMachineIdentification(true, true, true, true);
end;*)

procedure TCashFlowObj.LoadList;
var
  Rec                   :TempAccRec;
  wMonth1,wMonth2       : word;
  iWeeksBetween,i       : integer;
  iMonthsBetween        : integer;
  sPeriodDescription    : string;
  dtNewFrom             : TDateTime;
  iCurrentQuarter       : integer;
  iNextQuarter          : integer;
  iCurrentYear          : integer;
  iNextYear             : word;
  wYear, wMonth, wDay   : Word;

begin
  Logtext('9:'+'LoadList');
  fdTotalRec := 0;
  fdTotalPay := 0;
  fdTotalBank := 0;

  fsDebug := '';
  if fsTimePeriod = 'Week' then begin
    iWeeksBetween := WeeksBetween(fdtTo,fdtFrom);
    dtNewFrom := IncWeek(fdtFrom,-1);

    for i := 0 to iWeeksBetween do
    begin
      dtNewFrom := IncWeek(dtNewFrom,1);
      wMonth1 :=  MonthOf(dtNewFrom);
      wMonth2 := MonthOf(IncWeek(dtNewFrom,1));

      if wMonth1 = wMonth2 then begin
        sPeriodDescription :=  GetMonthName(wMonth1) + ' ' + IntToStr(DayOf(dtNewFrom))
            + ' - ' + GetMonthName(wMonth1) + ' ' + IntToStr((DayOf(IncWeek(dtNewFrom))) - 1) + ' ' + IntToStr(YearOf(IncWeek(dtNewFrom)));

      end else  begin
        sPeriodDescription :=  GetMonthName(wMonth1) + ' ' + IntToStr(DayOf(dtNewFrom))
            + ' - ' + GetMonthName(wMonth2) + ' ' + IntToStr((DayOf(IncWeek(dtNewFrom))) - 1) + ' ' + IntToStr(YearOf(IncWeek(dtNewFrom)));

      end;

      Rec := TempAccRec.Create;          //store in the list
      Rec.TimePeriodRange := sPeriodDescription;
      Rec.StartDate     := dtNewFrom;
      Rec.EndDate       := IncDay(IncWeek(dtNewFrom), -1);
      Rec.AccntsRec     := AccntsRecievable(dtNewFrom,IncDay(IncWeek(dtNewFrom), -1));
      Rec.AccntsPay     := AccntsPayable(dtNewFrom,IncDay(IncWeek(dtNewFrom), -1));
      Rec.BankAccnts    := BankAccounts(dtNewFrom,IncDay(IncWeek(dtNewFrom), -1));
      Rec.NetInflows    := AccntsRecievable(dtNewFrom,IncDay(IncWeek(dtNewFrom), -1)) - AccntsPayable(dtNewFrom,IncDay(IncWeek(dtNewFrom), -1))
                                + BankAccounts(dtNewFrom,IncDay(IncWeek(dtNewFrom), -1));

      fdNewBalance :=  fdNewBalance + AccntsRecievable(dtNewFrom,IncDay(IncWeek(dtNewFrom), -1)) - AccntsPayable(dtNewFrom,IncDay(IncWeek(dtNewFrom), -1))
                                + BankAccounts(dtNewFrom,IncDay(IncWeek(dtNewFrom), -1));

      Rec.ProjBalance   := fdNewBalance;
      fdTotalRec := fdTotalRec + Rec.AccntsRec;
      fdTotalPay := fdTotalPay + Rec.AccntsPay;
      fdTotalBank := fdTotalBank + Rec.BankAccnts;

      AccRecList.Add(Rec);
      Logrec(12,Rec);


    end;
  end;

  if fsTimePeriod = 'Month' then begin
    iMonthsBetween := MonthsBetween(fdtTo,fdtFrom);
    dtNewFrom := IncMonth(fdtFrom,-1);

    for i := 0 to iMonthsBetween do
    begin
      dtNewFrom := IncMonth(dtNewFrom,1);
       wMonth1 :=  MonthOf(dtNewFrom);
      wMonth2 := MonthOf(IncMonth(dtNewFrom,1));

      if wMonth1 = wMonth2 then begin
        sPeriodDescription :=  GetMonthName(wMonth1) + ' ' + IntToStr(DayOf(dtNewFrom))
            + ' - ' + GetMonthName(wMonth1) + ' ' + IntToStr((DayOf(IncMonth(dtNewFrom,1))) - 1) + ' ' + IntToStr(YearOf(IncMonth(dtNewFrom)));

      end else  begin
        sPeriodDescription :=  GetMonthName(wMonth1) + ' ' + IntToStr(DayOf(dtNewFrom))
            + ' - ' + GetMonthName(wMonth2) + ' ' + IntToStr((DayOf(IncMonth(dtNewFrom,1))) - 1) + ' ' + IntToStr(YearOf(IncMonth(dtNewFrom)));

      end;
      Rec := TempAccRec.Create;          //store in the list
      Rec.TimePeriodRange := sPeriodDescription;
      Rec.StartDate :=  dtNewFrom;
      Rec.EndDate :=  IncDay(IncMonth(dtNewFrom), -1);
      Rec.AccntsRec := AccntsRecievable(dtNewFrom,IncDay(IncMonth(dtNewFrom), -1));
      Rec.AccntsPay     := AccntsPayable(dtNewFrom,IncDay(IncMonth(dtNewFrom), -1));
      Rec.BankAccnts    := BankAccounts(dtNewFrom,IncDay(IncMonth(dtNewFrom), -1));
      Rec.NetInflows    := AccntsRecievable(dtNewFrom,IncDay(IncMonth(dtNewFrom), -1)) - AccntsPayable(dtNewFrom,IncDay(IncMonth(dtNewFrom), -1))
                                +  BankAccounts(dtNewFrom,IncDay(IncMonth(dtNewFrom), -1));

      fdNewBalance :=  fdNewBalance + Rec.NetInflows;

      fdTotalRec := fdTotalRec + Rec.AccntsRec;
      fdTotalPay := fdTotalPay + Rec.AccntsPay;
      fdTotalBank := fdTotalBank + Rec.BankAccnts;

      Rec.ProjBalance   := fdNewBalance;

      AccRecList.Add(Rec);
      Logrec(13,Rec);
    end;
  end;

  if fsTimePeriod = 'Quarter' then begin
    iCurrentQuarter := QuarterOf(fdtFrom) - 1;
    dtNewFrom := fdtFrom;

    while dtNewFrom < dtTo  do begin
      sPeriodDescription := '';
      if iCurrentQuarter >= 4 then begin
        iCurrentQuarter := 1;
        iNextQuarter := 2
      end else begin
        iCurrentQuarter := iCurrentQuarter + 1;
        if iCurrentQuarter >= 4 then begin
          iNextQuarter := 1;
        end else begin
          iNextQuarter := iCurrentQuarter + 1;
        end;
      end;

      while iCurrentQuarter <> iNextQuarter do begin
        dtNewFrom := IncDay(dtNewFrom,1);
        iCurrentQuarter := QuarterOf(dtNewFrom);
      end;
      iCurrentQuarter := QuarterOf(IncDay(dtNewFrom, - 1));

      sPeriodDescription := sPeriodDescription + ' Quarter ' + IntToStr(iCurrentQuarter) + ' ending ' + FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat,dtNewFrom -1);

      Rec := TempAccRec.Create;          //store in the list
      Rec.TimePeriodRange := sPeriodDescription;

      Rec.StartDate :=  StartOfTheQuarter(dtNewFrom - 1);
      Rec.EndDate :=  EndOfTheQuarter(dtNewFrom - 1);
      Rec.AccntsRec := AccntsRecievable(Rec.StartDate, Rec.EndDate);
      Rec.AccntsPay     := AccntsPayable(Rec.StartDate, Rec.EndDate);
      Rec.BankAccnts    := BankAccounts(Rec.StartDate, Rec.EndDate);
      Rec.NetInflows    :=  Rec.AccntsRec - Rec.AccntsPay + Rec.BankAccnts;

      fdNewBalance :=  fdNewBalance + Rec.NetInflows;

      fdTotalRec := fdTotalRec + Rec.AccntsRec;
      fdTotalPay := fdTotalPay + Rec.AccntsPay;
      fdTotalBank := fdTotalBank + Rec.BankAccnts;

      Rec.ProjBalance   := fdNewBalance;

      AccRecList.Add(Rec);
      Logrec(14,Rec);
      if dtNewFrom > dtTo then break;
    end;
  end;

  if fsTimePeriod = 'Year' then begin
    iCurrentYear := YearOf(fdtFrom) - 1;
    dtNewFrom := fdtFrom;

    while dtNewFrom < dtTo  do begin
      sPeriodDescription := '';
      iNextYear := iCurrentYear + 1;
      while iCurrentYear <= iNextYear do begin
        dtNewFrom := IncDay(dtNewFrom,1);
        iCurrentYear := YearOf(dtNewFrom);
      end;
      iCurrentYear := YearOf(dtNewFrom - 1);

      sPeriodDescription := sPeriodDescription + ' Year ' + IntToStr(iCurrentYear) + ' ending ' + FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat,dtNewFrom -1);

      Rec := TempAccRec.Create;          //store in the list
      Rec.TimePeriodRange := sPeriodDescription;
      DecodeDate(dtNewFrom -1,wYear,wMonth,wDay);

      Rec.StartDate :=  StartOfAYear(wYear);
      Rec.EndDate :=  EndOfAYear(wYear);
      Rec.AccntsRec := AccntsRecievable(Rec.StartDate, Rec.EndDate);
      Rec.AccntsPay     := AccntsPayable(Rec.StartDate, Rec.EndDate);
      Rec.BankAccnts    := BankAccounts(Rec.StartDate, Rec.EndDate);
      Rec.NetInflows    :=  Rec.AccntsRec - Rec.AccntsPay + Rec.BankAccnts;

      fdNewBalance :=  fdNewBalance + Rec.NetInflows;

      fdTotalRec := fdTotalRec + Rec.AccntsRec;
      fdTotalPay := fdTotalPay + Rec.AccntsPay;
      fdTotalBank := fdTotalBank + Rec.BankAccnts;

      Rec.ProjBalance   := fdNewBalance;

      AccRecList.Add(Rec);
      Logrec(15,Rec);
      if dtNewFrom > dtTo then break;
    end;
  end;
end;

constructor TCashFlowObj.Create;
begin
  Inherited;
  fsTempTableName := commondbLib.GetUserTemporaryTableName('tmp_tblcashflow');
  AccRecList := TList.Create;
  fQryAccntsRecievable := nil;
end;

destructor TCashFlowObj.Destroy;
begin
  while  AccRecList.Count > 0 do begin
    TempAccRec(AccRecList[0]).Free;
    AccRecList.Delete(0);
  end;
  if fqryAccntsRecievable <> nil then DbSharedObj.ReleaseObj(fqryAccntsRecievable);
  if fqryAccntsPayable    <> nil then DbSharedObj.ReleaseObj(fqryAccntsPayable);
  Inherited;  
end;
function TCashFlowObj.QryAccntsRecievable :TERPQuery;
var
  usingReportTables:boolean;
  fs:String;
begin
  if fQryAccntsRecievable = nil then begin
      fs := 'SELECT  '+
            ' Sum(DebitsInc)-Sum(CreditsEx) as Total  '+
            ' FROM tbltransactions  '+
            ' WHERE AccountType = '+ QuotedStr('AR')+
            ' and (ClassId =:ClassID or :ClassID =0) '+
            ' AND Date BETWEEN :Datefrom and :Dateto '+
            ' GROUP BY AccountType';
      fs := SyncReportObj.ChangeQuery(fs , usingReportTables);
      fQryAccntsRecievable := DbSharedObj.GetQuery(GetSharedMyDacConnection);
      fQryAccntsRecievable.SQL.text := fs;
  end;
  result := fQryAccntsRecievable;
end;
function TCashFlowObj.QryAccntsPayable :TERPQuery;
var
  usingReportTables:boolean;
  fs:String;
begin
  if fQryAccntsPayable = nil then begin
    fs := 'SELECT '+
          ' Sum(DebitsInc)-Sum(CreditsEx) as Total  '+
          ' FROM tbltransactions  '+
          ' WHERE AccountType = '+ QuotedStr('AP')+
          ' and (ClassId =:ClassID or :ClassID =0) '+
          ' AND Date BETWEEN :Datefrom and :Dateto '+
          ' GROUP BY AccountType';
     fs := SyncReportObj.ChangeQuery(fs , usingReportTables);
     fQryAccntsPayable := DbSharedObj.GetQuery(GetSharedMyDacConnection);
     fQryAccntsPayable.SQL.text := fs;
  end;
  result := fQryAccntsPayable;
end;
Procedure TCashFlowObj.Logrec(const value:Integer;rec:TempAccRec);
begin
  Logtext(inttostr(value)+':'+Rec.TimePeriodRange +',' +
          FormatDatetime('dd-mm-yy', Rec.StartDate  )+','+
          FormatDatetime('dd-mm-yy', Rec.EndDate    )+','+
          Floattostr(Rec.AccntsRec     )+','+
          Floattostr(Rec.AccntsPay     )+','+
          Floattostr(Rec.BankAccnts    )+','+
          Floattostr(Rec.NetInflows    )+','+
          Floattostr(Rec.ProjBalance   )+','+
          Floattostr(fdTotalRec )+','+
          Floattostr(fdTotalPay )+','+
          Floattostr(fdTotalBank ));

end;
end.
