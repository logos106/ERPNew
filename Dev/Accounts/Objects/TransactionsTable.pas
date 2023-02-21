unit TransactionsTable;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 25/05/05  1.00.01 BJ  Raise is changed to MessageDlg
 27/07/05  1.00.02 DSP Removed '`' character from SQL statement in the
                       Delete_Unique_AR_TempTable method.
 01/09/05  1.00.03 IJB Added constructor to TTransactionTableObj to initialise
                       TQuery's used to nil. Changed loop inside UpdateAvgCosts
                       to use while not EOF rather than For loop.
 26/09/05  1.00.04 IJB Added AgeByTransDate to  CleanRefresh_AR_Table and
                       CleanRefresh_AP_Table
                       CleanRefresh_AR_Table :moved into ReportTransactionsTable

}
{$I ERP.inc}
interface

uses DB, SysUtils, DateUtils, Dialogs, Controls, Classes,
     MyAccess, ERPdbComponents, MemDS, MyScript, TableFunctionsObj, DAScript ,
     UserLockObj, ProgressInfoObj, LogThreadBase, LogMessageTypes;

const
  HrsToHoldClosingDate = 24;

type
  pClassRec = ^TClassRec;
  TClassRec = record
    ClassID: integer;
    ClassName: string;
    SubLevelIDs: string;
    Active : boolean;
  end;
  pFCRec = ^TFCRec;
  TFCRec = record
    FCID: integer;
    FCcode: string;
  end;

type
  TCOGSCoststatus = (ccsNone =0, ccsSummary = 1, ccsCurrent =2);
  TOnLog = Procedure (const msg: string; LogType: TLogMessageType)  of Object;

  TTransactionTableObj = class(TObject)
  private
    fLstFC: TList;
    TableFunctions: TTableFunctionsObj;
    qryPOs, qryParts, qryTemp: TERPQuery;
    bRecalcGroupItemCosts: boolean;
    bNoExecuteUpdates: boolean;
    SummarisedTransDate           : TDateTime;
    TempFile: string;
    MySQLTempDir: string;
    TempFileCount: integer;
    tmpString: string;
    LOAD_INTO_StringFixedAssets : String;
    UserLock: TUserLock;
    fbIsOwnerListing: boolean;
    fOwnedProgressDlg: TProgressInfo;
    fLogger: TLoggerBase;
    fBeforeScriptExecute: TBeforeStatementExecuteEvent;
    //fsSQL:String;
    fSharedConnection: TERPConnection;
    fOnLog: TOnLog;
    procedure Delete_Unique_AR_TempTable;
    function GetCreate_tbltransactions_inprogress: String;
    procedure Delete_Unique_ALL_TempTable;
    function COAColumns(COAQry:TERPQuery=nil): string;
    function Idcolumn(Const SaleID,poID,PayId,PrePayid,FAID:String):String;
    function LineIdcolumn(Const SLID,POLID,PayLId,PrePayLid:String):String;
    function RoundTocurrency(Const fieldname:String):String;
    function NextTempFile: string;

    procedure CreateTransObj;
    procedure DoAfterUpdate;
    procedure AddReconcileFlags;
    function SumSeqno(const Value: Integer): String;
    function GetProgressDlg: TProgressInfo;
    procedure ResetBalances;
    function GetAccountID(const AccountName: string): integer;
    function GetGLTaxCodeIDForName(const TaxCodeName: String): Integer;
    function IStochangeSummasedTransdateTocurent(SummaryDetailsTable: boolean ;KeepSummariseDt: boolean;ForceSummary: boolean ):Boolean;
    procedure SetClassLevelField;
    procedure CleanUpLevelFields;
    procedure UpdateLevels(const ClassID: integer; const Level1, Level2, Level3, Level4: string);
    Procedure GetFCs;
    function GetSubLevelIDs(const ClassID: integer): string;
    Procedure SetproctreeNodesSelected;
    function NewScript:TERPScript;
    Function NewQry:TERPQuery;
    procedure Updatecurrency(BulkSQL: TStringList);
    procedure UpdateVS1DashBoardTables;
    function QuotedFieldName(const fieldName: String): String;
    Function CurDBName:String;
//    function NextTableName: string;

  Protected
    qryTempExec: TERPCommand;
    qryMyScript: TERPScript;
    BulkSQL: TStringList;
    fDoingRefresh: boolean;
    fTotalsRoundPlaces:Integer;
    fLstClass: TList;
    TableName                   : String;
    LOAD_INTO_String            : String;
    BeforeOrAfterClosing          : String;

    procedure Log(const msg: string; LogType: TLogMessageType);
    procedure TrnsTable02(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable03(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable04(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable05(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
//    procedure TrnsTable05_1(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable06(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable07(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable08(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable10(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable11(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
//    procedure TrnsTable11_1(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable12(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
//    procedure TrnsTable12_1(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable14(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable16(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable17(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable18(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable19(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable20(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable21(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable22(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable23(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable24(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable25(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable26(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable27(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable28(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable29(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable30(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable31(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable32(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable33(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable34(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable35(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable36(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable37(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable38(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable39(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable40(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable41(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable42(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable43(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable44(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable45(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable46(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable47(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable48(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable49(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable50(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable51(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable52(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable53(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable54(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable55(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable56(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable57(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable58(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable59(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable60(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable61(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable62(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable63(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable64(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable65(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable66(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable67(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable69(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable70(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable71(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable72(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable73(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable74(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable75(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable76(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable77(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable78(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable79(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable80(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable81(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable83(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable84(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable85(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
    procedure TrnsTable87(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False; Const aSaleID:Integer=0);
    //procedure TrnsTable91(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False); // empty procedure for the next number
    procedure TrnsTable92(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False); // empty procedure for the next number
    procedure TrnsTable93(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False); // empty procedure for the next number
    procedure TrnsTable94(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False); // empty procedure for the next number
    procedure ClearFCs;

  public
    COGSCoststatus:TCOGSCoststatus;
    constructor Create(OwnerListing:boolean);Overload;virtual;
    destructor Destroy; override;
    procedure GetClasses(SelectedDepartments: TStrings= nil; includeInactive:Boolean =True);
    procedure ClearClasses;

    function CreatePermanentSummaryTable: Boolean;
    function CleanRefreshTrnsTable(const RefreshBatch: Boolean = False; const SummaryDetailsTable: Boolean = False; const VerfiyBalances: Boolean = False; const KeepSummariseDt: Boolean = False): Boolean;
    Function CleanOutTempTables: Boolean;
    Procedure CleanOutUserTempTables;
    Procedure InitforRefreshTrnsTable;
    property RecalcGroupItemCosts: Boolean read bRecalcGroupItemCosts write bRecalcGroupItemCosts;
    property NoExecuteUpdates: boolean read bNoExecuteUpdates write bNoExecuteUpdates;
    property LstClass: TList read fLstClass;
    property LstFC: TList read fLstFC;
    property DoingRefresh: boolean read fDoingRefresh;
    Property IsOwnerListing:boolean read fbIsOwnerListing write fbIsOwnerListing;
    Function Lock(Groupname:STring): Boolean;
    Procedure UnLock(Groupname:STring);
    property Logger: TLoggerBase read fLogger write fLogger;
    property BeforeScriptExecute: TBeforeStatementExecuteEvent read fBeforeScriptExecute write fBeforeScriptExecute;
    Procedure DoProcessScriptExecteError(const Value: String);

    //function NonInvProductcostinBOM(const tblParts:String ='P'; const tblproctree:string ='PT'):String;
    Function aQuery:TERPQuery;
    procedure showprogressDlg(Caption: String; MaxValue: Integer);
    Procedure StepProgressDlg(Acaption:String);
    Procedure HideProgressdlg;
    property ProgressDlg: TProgressInfo read GetProgressDlg; // write SetProgressDlg;
    procedure MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean); virtual;
    procedure MyScriptAfterExecute(Sender: TObject; SQL: string);
    //procedure MyScriptAfterExecute(Sender: TObject; SQL: string);
    Function Devmode:boolean;
    Procedure InvAssetPostings(BulkSQL: TStringlist; tablename :String; ProductName:String = '');
    procedure SetEmptyGlobalRef;
    Procedure UpdateGlobalRefWithcurrentSiteCode;
    property SharedConnection: TERPConnection read fSharedConnection write fSharedConnection;
    Function StripNewLine(const Value:String):String;
    Function TransSQLFields(seno:Integer):String;
    Property OnLog : TOnLog read fOnLog write fOnLog;
  end;

  Function Firstcolumn (const COATableAlias :String = 'COA'):String;
  Function Secondcolumn(const COATableAlias :String = 'COA'):String;
  Function Thirdcolumn (const COATableAlias :String = 'COA'):String;
  Function forthcolumn (const COATableAlias :String = 'COA'):String;
  Function AccountName (const COATableAlias :String = 'COA'):String;
  Function CurDateIfGreater(dDate:TdateTime):TDatetime;
  Function autochangeSumDtMsg(const YearStart,YearEnd:TDatetime; showCondValue:boolean):String;


implementation

uses
  Forms,   DNMExceptions,
  StrUtils,   StockCostSystemsObj,
  MySQLConst, ProductRewardPointsLib,
  AccruedLeaveLiabilitiesAdj,
  SyncReportTableObj, MySQLUtils, DateTimeUtils,
  InventoryTypes, AppEnvironmentVirtual, Vista_MessageDlg,
  MergeObj, UtilsLib, SystemLib, PQALib(*, tcConst*)
  {$IFNDEF CONSOLE}  {$IFDEF DevMode}  , LogLib  {$ENDIF}  {$ENDIF}
  ,ProfitAndLossPeriodCompareSQL, JSONObject, utCloudconst,
  APReportSQL, SalesListSQL   , ProfitAndLossSQL,
  ProductStockReportLib, BalanceSheetSQL, CommonDbLib;

{$IFDEF DevMode}
Const
TransSQLLogFileName= 'd:\translogSQL.lib';
TransErrorlogfilename= 'd:\translogerror.lib';
{$ENDIF}


Function autochangeSumDtMsg(const YearStart,YearEnd:TDatetime; showCondValue:boolean):String;
begin
    REsult:= '   (1) ''Summarised Date'' was changed on  ' + Quotedstr(formatDateTime(FormatSettings.ShortdateFormat +' hh:nn AM/PM' ,AppEnvVirt.Float['CompanyPrefs.SummarisedTransDateChanged'])) +
              ' is more than ' + inttostr(HrsToHoldClosingDate)+' hours now - ' + Quotedstr(formatDateTime(FormatSettings.ShortdateFormat +' hh:nn AM/PM' ,Now));
    if showCondValue then result := result +  ' - (' + BooleanToString(HoursBetween(AppEnvVirt.Float['CompanyPrefs.SummarisedTransDateChanged'],Now()) > HrsToHoldClosingDate )+  ').' ;
    result := result + ' AND ' +chr(13);

    result := result + '   (2)  It is ' + inttostr(AppEnvVirt.Int['CompanyPrefs.NoOfMonthstoChangeClosingdate']) +' months after the current Financial Year beginning - ' +
              Quotedstr(formatDateTime(FormatSettings.ShortdateFormat +' hh:nn AM/PM' ,YearEnd)) +'  till now - ' +
              Quotedstr(formatDateTime(FormatSettings.ShortdateFormat +' hh:nn AM/PM' ,Now())) +'.(as per the preference)';
    if showCondValue then result := result +   ' - (' +BooleanToString(MonthsBetween(YearStart,now) >= AppEnvVirt.Int['CompanyPrefs.NoOfMonthstoChangeClosingdate']) +').'  ;

    result := result + ' AND ' + chr(13);
    result := result + '   (3) Current ''Summarised Date''  ' + Quotedstr(formatDateTime(FormatSettings.ShortdateFormat +' hh:nn AM/PM' ,AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'])) +
              ' is not THE Current Financial Year End ' + Quotedstr(formatDateTime(FormatSettings.ShortdateFormat +' hh:nn AM/PM' ,YearEnd)) +' ';
    if showCondValue then result := result +   '- (' +BooleanToString(CompareDate(AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'],YearEnd)<>0) +').'  ;

    if (HoursBetween(AppEnvVirt.Float['CompanyPrefs.SummarisedTransDateChanged'],Now()) >HrsToHoldClosingDate ) AND
        (MonthsBetween(YearStart,now) >= AppEnvVirt.Int['CompanyPrefs.NoOfMonthstoChangeClosingdate']) AND
        (CompareDate(AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'],YearEnd)<>0) then
        result := result + chr(13) + 'The ''Summarise Trans Date'' WILL change to the current ' + Quotedstr(FormatDateTime(FormatSettings.ShortdateFormat , YearStart))
    else
      result := result + chr(13) + chr(13) + 'The ''Summarise Trans Date'' WILL NOT change';

    result := result + chr(13);
end;

function GetCurrentFiscalYearStart: TDateTime;
begin
  result := DateTimeUtils.FiscalYearStart(now, AppEnvVirt.Str['CompanyPrefs.FiscalYearStarts']);
end;

function GetLastFiscalYearEnd(aDate: TDateTime): TDateTime;
begin
  result := DateTimeUtils.LastFiscalYearEnd(aDate,AppEnvVirt.Str['CompanyPrefs.FiscalYearStarts']);
end;

Function  SplitField(TableAlias:STring; FieldName:STring;Position :Integer;Delimeter:String='^'):String;
begin
  if TableAlias <> '' then TableAlias := TableAlias+'.';
    if Position =1 then begin
        result := 'Left(SUBSTRING_INDEX(' + TableAlias +FieldName+','+QuotedStr(Delimeter) +',1),255)';
    end else begin
        REsult := 'Left(substring(substring_index(' + TableAlias +FieldName+','+QuotedStr(Delimeter) +',' + IntToStr(Position) +'),char_length(substring_index(' + TableAlias +FieldName+','+QuotedStr(Delimeter) +',' + IntToStr(Position-1)+'))+2),255)';
    end;
end;



{ TTransactionTableObj }

Procedure TTransactionTableObj.CreateTransObj;
begin
  inherited;
  fDoingRefresh:= false;
  TableFunctions := TTableFunctionsObj.Create;
  BulkSQL := TStringList.Create;
  fLstClass := Tlist.Create;
  fLstFC := TList.Create;
  qryPOs := nil;
  qryTemp := nil;
  qryParts := nil;
  qryTempExec := nil;
  qryMyScript := nil;
  fTotalsRoundPlaces := AppEnvVirt.Int['RegionalOptions.CurrencyRoundPlaces'];
  UserLock := TUserLock.Create(nil);
  fbIsOwnerListing := False;
end;

function TTransactionTableObj.CurDBName: String;
begin
  result := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']).Database;
end;

procedure TTransactionTableObj.UpdateGlobalRefWithcurrentSiteCode;
var
  dsTables: TERPQuery;
  qryUpdateMydac: TERPScript;
  PrimaryKey, TableName: string;
  Save_Cursor:TCursor;
  HasGlobalRef: boolean;
begin

  If not Assigned(AppEnvVirt.Obj['Branch']) then Exit; //Skip For Frmlogon Cancel
  try
    dsTables := TERPQuery.Create(nil);
    dsTables.Options.FlatBuffers := True;
    qryUpdateMydac := TERPScript.Create(nil);
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      try
        dsTables.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
        qryUpdateMydac.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

        dsTables.SQL.Text := 'Show Tables;';
        dsTables.Open;

        BulkSQL.Clear;
        BulkSQL.add('CREATE TABLE if not exists `tblGlobalrefBackup` ( '+
                    '	`ID` INT(11) NOT NULL AUTO_INCREMENT, '+
                    '		`Tablename` VARCHAR(255) NULL DEFAULT "", '+
                    '		`globalref` VARCHAR(255) NULL DEFAULT "", '+
                    '		`RecordID` INT(11) NULL DEFAULT 0, '+
                    '   msUpdateSiteCode varchar(3) NULL Default "", '+
                    '		`mstimeStamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, '+
                    '		PRIMARY KEY (`ID`),	UNIQUE INDEX `Tablename_RecordID` (`Tablename`, `RecordID`) ) ENGINE=InnoDB ;');

        if Assigned(ProgressDlg) then begin
          ProgressDlg.Caption := 'Updating GlobalRefs';
          ProgressDlg.MinValue := 0;
          ProgressDlg.MaxValue := dsTables.RecordCount;
          ProgressDlg.Message := 'Working...';
          ProgressDlg.Step := 1;
          ProgressDlg.Execute;
        end;
        dsTables.First;
        While Not dsTables.Eof do Begin
          TableName := dsTables.Fields[0].AsString;
          PrimaryKey := MySQLUtils.MysqlTablePrimaryKey(TableName, TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']),HasGlobalRef);
          if (PrimaryKey <> '') and
            (not (Sysutils.SameText(LeftStr(TableName, 4), 'tmp_'))) and
            (not (Sysutils.SameText(LeftStr(TableName, 7), 'erpfix_'))) and
            (not (Sysutils.SameText(TableName, 'tbltransactions'))) and
            (not (Sysutils.SameText(TableName, 'tbltransactionsummary'))) and
            (not (Sysutils.SameText(TableName, 'tbltransactionsummarydetails'))) and
            (not (Sysutils.SameText(TableName, 'tbltransactions_inprogress'))) and

            (not (Sysutils.SameText(TableName, 'rpt_tbltransactions'))) and
            (not (Sysutils.SameText(TableName, 'rpt_tbltransactionsummary'))) and
            (not (Sysutils.SameText(TableName, 'rpt_tbltransactionsummarydetails'))) and
            (not (Sysutils.SameText(TableName, 'rpt_tbltransactions_inprogress'))) and

            (not (Sysutils.SameText(TableName, 'tblGlobalrefBackup'))) and
            (not (Sysutils.SameText(LeftStr(TableName, 5), 'debug'))) and
            (HasGlobalRef) then begin
            BulkSQL.Add('insert into tblGlobalrefBackup (Tablename,globalref,RecordID , msUpdateSiteCode ) Select ' +quotedstr(TableName)+', GlobalRef , '+ PrimaryKey +', msUpdateSiteCode from ' + Tablename +';');
            BulkSQL.Add('ALTER TABLE `' + TableName + '` 	CHANGE COLUMN `mstimestamp` `mstimestamp` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP  ;');
            BulkSQL.Add('UPDATE `' + TableName + '` SET GlobalRef = CONCAT_WS("",' + QuotedStr(AppEnvVirt.Str['Branch.SiteCode']) + ',' + PrimaryKey + ') ;');
            BulkSQL.Add('UPDATE `' + TableName + '` set msUpdateSiteCode = "' + AppEnvVirt.Str['Branch.SiteCode'] + '" ;');
            BulkSQL.Add('ALTER TABLE `' + TableName + '` 	CHANGE COLUMN `mstimestamp` `mstimestamp` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP ;');
          end;
          dsTables.Next;
          if Assigned(ProgressDlg) then begin
            ProgressDlg.Message := Tablename;
            ProgressDlg.StepIt;
          end;
          Application.ProcessMessages;
        end;
        Application.ProcessMessages;
      finally
        if Assigned(ProgressDlg) then begin
          ProgressDlg.CloseDialog;
        end;
      end;
      BulkSQL.Add('update tblsales S ' +
                  ' inner join tblGlobalrefBackup G on ifnull(S.salesOrderGlobalref, "") = G.Globalref and G.tablename ="tblSales" ' +
                  ' inner join tblsales SO on SO.SaleId = G.RecordID '+
                  ' Set S.SalesOrderGlobalref = SO.globalref ' +
                  ' where ifnull(S.salesOrderGlobalref, "")  <> "";');

      BulkSQL.Add('update tblsales S ' +
                  ' inner join tblGlobalrefBackup G on ifnull(S.Quoteglobalref, "") = G.Globalref and G.tablename ="tblSales" ' +
                  ' inner join tblsales SO on SO.SaleId = G.RecordID '+
                  ' Set S.Quoteglobalref = SO.globalref ' +
                  ' where ifnull(S.Quoteglobalref, "")  <> "";');

      BulkSQL.Add('update tblsales S ' +
                  ' inner join tblGlobalrefBackup G on ifnull(S.OriginalNo, "") = G.Globalref and G.tablename ="tblSales" ' +
                  ' inner join tblsales SO on SO.SaleId = G.RecordID '+
                  ' Set S.OriginalNo = SO.globalref ' +
                  ' where ifnull(S.OriginalNo, "")  <> "";');

      BulkSQL.Add('update tblsales S ' +
                  ' inner join tblGlobalrefBackup G on ifnull(S.Baseno, "") = G.Globalref and G.tablename ="tblSales" ' +
                  ' inner join tblsales SO on SO.SaleId = G.RecordID '+
                  ' Set S.Baseno = SO.globalref ' +
                  ' where ifnull(S.Baseno, "")  <> "";');

      BulkSQL.Add('update tblsales S ' +
                  ' inner join tblGlobalrefBackup G on ifnull(S.BOID, "") = G.Globalref and G.tablename ="tblSales" ' +
                  ' inner join tblsales SO on SO.SaleId = G.RecordID '+
                  ' Set S.BOID = SO.globalref ' +
                  ' where ifnull(S.BOID, "")  <> "";');

      BulkSQL.Add('update tblpurchaseorders S ' +
                  ' inner join tblGlobalrefBackup G on ifnull(S.OriginalNo, "") = G.Globalref and G.tablename ="tblpurchaseorders" ' +
                  ' inner join tblpurchaseorders SO on SO.PurchaseOrderID = G.RecordID '+
                  ' Set S.OriginalNo = SO.globalref ' +
                  ' where ifnull(S.OriginalNo, "")  <> "";');

      BulkSQL.Add('update tblpurchaseorders S ' +
                  ' inner join tblGlobalrefBackup G on ifnull(S.Baseno, "") = G.Globalref and G.tablename ="tblpurchaseorders" ' +
                  ' inner join tblpurchaseorders SO on SO.PurchaseOrderID = G.RecordID '+
                  ' Set S.Baseno = SO.globalref ' +
                  ' where ifnull(S.Baseno, "")  <> "";');

      BulkSQL.Add('update tblpurchaseorders S ' +
                  ' inner join tblGlobalrefBackup G on ifnull(S.BOID, "") = G.Globalref and G.tablename ="tblpurchaseorders" ' +
                  ' inner join tblpurchaseorders SO on SO.PurchaseOrderID = G.RecordID '+
                  ' Set S.BOID = SO.globalref ' +
                  ' where ifnull(S.BOID, "")  <> "";');

      BulkSQL.Add('update tblsales S ' +
                  ' inner join tblGlobalrefBackup G on ifnull(S.RepairGlobalRef, "") = G.Globalref and G.tablename ="tblrepairs" ' +
                  ' inner join tblrepairs SO on SO.RepairID = G.RecordID '+
                  ' Set S.RepairGlobalRef = SO.globalref ' +
                  ' where ifnull(S.RepairGlobalRef, "")  <> "";');
      TRy
        if Assigned(ProgressDlg) then begin
          ProgressDlg.Caption := 'Updating GlobalRefs';
          ProgressDlg.Message := 'Updating.....';
          ProgressDlg.MinValue := 0;
          ProgressDlg.Step := 1;
        end;
        qryUpdateMydac.BeforeExecute := MyScriptBeforeExecute;
        qryUpdateMydac.AfterExecute := MyScriptAfterExecute;
        qryUpdateMydac.SQL.Clear;
        qryUpdateMydac.SQL.Text := BulkSQL.Text;
        BulkSQL.Clear;
        if Assigned(ProgressDlg) then begin
          ProgressDlg.MaxValue := qryUpdateMydac.Statements.Count;
          ProgressDlg.Message := 'Updating.....';
          ProgressDlg.Execute;
        end;
          qryUpdateMydac.IgnorenContinueOnError := True;
          qryUpdateMydac.ProcessScriptExecteError := DoProcessScriptExecteError;
//          {$IFDEF DevMode}clog(''); {$ENDIF}
          qryUpdateMydac.Execute;
      Finally
        if Assigned(ProgressDlg) then begin
          ProgressDlg.CloseDialog;
        end;
      End;


    finally
      FreeAndNil(dsTables);
      FreeAndNil(qryUpdateMydac);
      Screen.Cursor := Save_Cursor;
      Application.ProcessMessages;
    end;
  except
    raise;
  end;
end;

(*procedure TTransactionTableObj.MyScriptAfterExecute(Sender: TObject;
  SQL: string);
begin
  if Assigned(ProgressDlg) then begin
    ProgressDlg.Message := '';
    ProgressDlg.StepIt;
  end;
end;*)
procedure TTransactionTableObj.MyScriptAfterExecute(Sender: TObject; SQL: string);
begin
  if Assigned(ProgressDlg) then begin
      if pos('...Done',ProgressDlg.Message)<=0 then ProgressDlg.Message := ProgressDlg.Message +'...Done'
      else begin
          ProgressDlg.Message := ProgressDlg.Message +'.';
      end;
      ProgressDlg.StepIt;
  end;
end;
procedure TTransactionTableObj.MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean);
Function SQLno:String;
begin
  if (copy(sql,1,2) = '/*') and (copy(sql,5,2) = '*/') then begin
    result := trim(replacestr(replacestr(copy(SQL, 1,6), '/*' , ''), '*/' , ''));
    try
      if (result <> '') and (StrToIntDef(result,0)<>0) then begin
        result := 'Updating ... ' +result;
        ProgressDlg.Message := REsult;
      end;
    Except

    end;
  end else if (copy(sql,1,6) = '/*Gen-') and (copy(sql,9,2) = '*/') then begin
    result := trim(replacestr(replacestr(copy(SQL, 1,10), '/*' , ''), '*/' , ''));
    try
      if (result <> '')  then begin
        result := 'Updating ... ' +result;
        ProgressDlg.Message := REsult;
      end;
    Except
    end;
  end else if devmode then begin
    ProgressDlg.Message := copy(SQL,1,200);
  end;
end;
begin
  if Assigned(ProgressDlg) then begin
    //ProgressDlg.Message := iif(Devmode  , SQL , '');
    SQLno;
    ProgressDlg.StepIt;
  end;
  Application.ProcessMessages;
  if Assigned(fBeforeScriptExecute) then
    fBeforeScriptExecute(Sender,SQL,Omit);
  //fsSQL:= sql;
  //{$IFDEF DevMode}  Logtext(copy(SQL,1,1000), TransSQLLogFileName);  {$ENDIF}
end;

function TTransactionTableObj.NewQry: TERPQuery;
begin
  result := TERPQuery.Create(nil);
  result.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  result.Options.FlatBuffers := True;
end;

function TTransactionTableObj.NewScript: TERPScript;
begin
  result := TERPScript.Create(nil);
  result.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
end;

//function TTransactionTableObj.NextTableName: string;
//begin
//  result := 'tmp_' + tablename +'_'+ IntToStr(TempFileCount) ;
//end;

function TTransactionTableObj.NextTempFile: string;
begin
  result:= MySQLTempDir +  AppEnvVirt.str['CompanyPrefs.DBName']+'_'+ TableName + '_' + IntToStr(TempFileCount) + '.tmp';
  Inc(TempFileCount);
end;

Procedure TTransactionTableObj.showprogressDlg(Caption:String; MaxValue:Integer);
begin
  if Assigned(ProgressDlg) then begin
    ProgressDlg.Caption := Caption;
    ProgressDlg.MinValue := 0;
    ProgressDlg.Step := 1;
    ProgressDlg.MaxValue := MaxValue;
    ProgressDlg.Message := 'Working...';
    ProgressDlg.Execute;
  end;
end;

procedure TTransactionTableObj.SetEmptyGlobalRef;
var
  dsTables: TERPQuery;
  qryUpdateMydac: TERPScript;
  PrimaryKey, TableName: string;
  Save_Cursor:TCursor;
  HasGlobalRef: boolean;
begin
  If not Assigned(AppEnvVirt.Obj['Branch']) then Exit; //Skip For Frmlogon Cancel
  try
    dsTables := TERPQuery.Create(nil);
    dsTables.Options.FlatBuffers := True;
    qryUpdateMydac := NewScript;//TERPScript.Create(nil);
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      try
        dsTables.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
        //qryUpdateMydac.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

        dsTables.SQL.Text := 'Show Tables;';
        dsTables.Open;

        BulkSQL.Clear;
        if Assigned(ProgressDlg) then begin
          ProgressDlg.Caption := 'Updating GlobalRefs';
          ProgressDlg.MinValue := 0;
          ProgressDlg.MaxValue := dsTables.RecordCount;
          ProgressDlg.Message := 'Working...';
          ProgressDlg.Step := 1;
          ProgressDlg.Execute;
        end;
        dsTables.First;
        While Not dsTables.Eof do Begin
          TableName := dsTables.Fields[0].AsString;
          PrimaryKey := MySQLUtils.MysqlTablePrimaryKey(TableName, TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']),HasGlobalRef);
          if (PrimaryKey <> '') and
            (not (Sysutils.SameText(LeftStr(TableName, 4), 'tmp_'))) and
            (not (Sysutils.SameText(LeftStr(TableName, 7), 'erpfix_'))) and
            (not (Sysutils.SameText(LeftStr(TableName, length(MySQLConst.Mysql_TempTablePrefix)), MySQLConst.Mysql_TempTablePrefix))) and
            (not (Sysutils.SameText(TableName, 'tbltransactions'))) and
            (not (Sysutils.SameText(TableName, 'tbltransactionsummary'))) and
            (not (Sysutils.SameText(TableName, 'tbltransactionsummarydetails'))) and
            (not (Sysutils.SameText(LeftStr(TableName, 5), 'debug'))) and
            (HasGlobalRef) then begin
            BulkSQL.Add('UPDATE `' + TableName + '` SET GlobalRef = CONCAT_WS("",' +
             QuotedStr(AppEnvVirt.Str['Branch.SiteCode']) + ',' + PrimaryKey + ') WHERE char_length(GlobalRef)=0 OR IsNull(GlobalRef);');
            BulkSQL.Add('UPDATE `' + TableName + '` SET msUpdateSiteCode = "' + AppEnvVirt.Str['Branch.SiteCode'] + '" WHERE IFNULL(msUpdateSiteCode, "") = "";');
          end;
          dsTables.Next;
          if Assigned(ProgressDlg) then begin
            ProgressDlg.Message := Tablename;
            ProgressDlg.StepIt;
          end;
          Application.ProcessMessages;
        end;
        Application.ProcessMessages;
      finally
        if Assigned(ProgressDlg) then begin
          ProgressDlg.CloseDialog;
        end;
      end;

      TRy
        if Assigned(ProgressDlg) then begin
          ProgressDlg.Caption := 'Updating GlobalRefs';
          ProgressDlg.Message := 'Updating....';
          ProgressDlg.MinValue := 0;
          ProgressDlg.Step := 1;
        end;
        qryUpdateMydac.BeforeExecute := MyScriptBeforeExecute;
        qryUpdateMydac.AfterExecute := MyScriptAfterExecute;
        qryUpdateMydac.SQL.Clear;
        qryUpdateMydac.SQL.Text := BulkSQL.Text;
        BulkSQL.Clear;
        if Assigned(ProgressDlg) then begin
          ProgressDlg.MaxValue := qryUpdateMydac.Statements.Count;
          ProgressDlg.Execute;
        end;
          qryUpdateMydac.IgnorenContinueOnError := True;
          qryUpdateMydac.ProcessScriptExecteError := DoProcessScriptExecteError;
          qryUpdateMydac.Execute;
      Finally
        if Assigned(ProgressDlg) then begin
          ProgressDlg.CloseDialog;
        end;
      End;


    finally
      FreeAndNil(dsTables);
      FreeAndNil(qryUpdateMydac);
      Screen.Cursor := Save_Cursor;
      Application.ProcessMessages;
    end;
  except
    raise;
  end;
end;

procedure TTransactionTableObj.SetproctreeNodesSelected;
var
  Qry :TERPQuery;
  ctr,Levelno :Integer;

begin
  If not Assigned(AppEnvVirt.Obj['Branch']) then Exit; //Skip For Frmlogon Cancel
  With newScript do try
    SQL.add('Truncate tblproctreeNodes;');
    SQL.add('Insert ignore into tblproctreeNodes (ProctreeId , Selected) select ProctreeId  , Selected from tblProctree where mastertype <> "mtProduct";');
    Execute;

      Qry := NewQry;
      try
        Qry.SQL.Text := 'SELECT MAX(LEVEL) Level FROM tblproctree;';
        Qry.open;

        Levelno := Qry.fieldbyname('LEvel').asInteger;
        if Levelno =0 then exit;
        SQL.clear;
        SQL.Add('Truncate tblproctreeNodes;');
        SQL.Add('Insert ignore into tblproctreeNodes (ProctreeId ,ParentID ,Level , Selected) select ProctreeId  , ParentID , Level, "" from tblProctree where mastertype <> "mtProduct";');
        SQL.Add('update tblproctreeNodes PTN  inner join tblproctree PT on PTN.proctreeId = PT.proctreeId and ifnull(PT.ParentId,0)=0 Set PTN.selected ="T";');
        for ctr := 1 to levelno do begin
          SQL.add('update tblproctreeNodes PTN '+
                  ' inner join tblProctree PT on PT.proctreeId = PTN.proctreeID  and PT.level = '+ inttostr(ctr) +' '+
                  ' inner join tblproctreeNodes PPTN on PT.ParentId = PPTN.ProctreeId '+
                  ' inner join tblproctree PPT on PPT.proctreeId = PT.parentID '+
                  ' Set PTN.Selected = if(PPTN.Selected ="F", "F", if(PPT.inputtype <> "itOption" , "T" , if(PPTN.Selected ="T" and PT.selected="T"  , "T" , "F")));');
        end;

        TRy
          showprogressDlg('Check for Manufacture Tree Selections',Statements.Count);
          BeforeExecute := MyScriptBeforeExecute;
          AfterExecute := MyScriptAfterExecute;
          Execute;
        Finally
          if Assigned(ProgressDlg) then begin
            ProgressDlg.CloseDialog;
          end;
        End;
      finally
        Qry.closenFree;
      end;
  finally
    Free;
  end;

end;

procedure TTransactionTableObj.ResetBalances;
var
  MergeObj: TMergeObj;
  SavedCursor: TCursor;
begin
  if not AppEnvVirt.Bool['DNMLib.IsTransTableEmpty'] then begin
    MergeObj := TMergeObj.Create;
    SavedCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      MergeObj.ClientBalanceVerify;
      MergeObj.AccountBalanceVerify;
    finally
      FreeAndNil(MergeObj);
      Screen.Cursor := SavedCursor;
    end;
  end;
end;


function TTransactionTableObj.RoundTocurrency(const fieldname: String): String;
begin
  result := '';
  if fieldname = '' then exit;
  result := 'Round('+fieldname + ',' +inttostr(fTotalsRoundPlaces)+')';
end;

procedure TTransactionTableObj.TrnsTable02(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*2*/ SELECT STRAIGHT_JOIN 2, tblSales.SaleDate as "Date", ');
              Add('"Invoice" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+')  as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as  CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales  ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblSales.AccountID ');
              Add('WHERE (tblSales.IsInvoice="T") AND tblSales.Deleted="F" ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.Invoiced="T"');
              Add('GROUP BY  tblSales.SaleID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable03(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*3*/ SELECT STRAIGHT_JOIN 3, tblSales.SaleDate as "Date", ');
              Add('"Refund" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0 as "DebitsEx", ');
              Add('-Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "CreditsEx", ');
              Add('0 as "DebitsInc", ');
              Add('-Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('-Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('-Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as CASH_CreditsInc ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales ');
              Add('INNER JOIN tblSalesLines ON tblSales.SaleID = tblSalesLines.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblSales.AccountID ');
              Add('WHERE tblSales.IsRefund ="T" AND tblSales.Deleted="F" ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.Invoiced="T" ');
              Add('GROUP BY tblSales.SaleID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable04(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*4*/ SELECT 4,tblSales.SaleDate as "Date", ');
              Add('"Cash Sale" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "DebitsEx", ');
              Add('0 as "CreditsEx", ');
              Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "DebitsInc", ');
              Add('0 as "CreditsInc",');
              Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales  ');
              Add('INNER JOIN tblSalesLines ON  tblSales.SaleID = tblSalesLines.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblSales.AccountID = tblchartofaccounts.AccountID ');
              Add('WHERE (tblSales.IsCashSale="T") ');
              Add('AND tblSalesLines.Invoiced="T" AND tblSales.Deleted="F" ');
              Add(' AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('GROUP BY  tblSales.SaleID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable05(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*5*/ SELECT 5,tblPurchaseOrders.InvoiceDate as "Date", ');
              Add('"PO" AS Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('tblPurchaseLines.Product_Description as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0 as "DebitsEx", ');
              Add('Round(Sum('+Roundfix('tblpurchaseLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "CreditsEx", ');
              Add('0 as "DebitsInc", ');
              Add('Round(Sum('+Roundfix('tblpurchaseLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('Round(Sum('+Roundfix('tblpurchaseLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+')  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('Round(Sum('+Roundfix('tblpurchaseLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as CASH_CreditsInc,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders  ');
              Add('INNER JOIN tblPurchaseLines ON  tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON  tblPurchaseOrders.AccountID = tblchartofaccounts.AccountID ');
              Add('WHERE tblPurchaseLines.Invoiced="T" And (tblPurchaseOrders.IsPO="T") ');
              Add('AND tblPurchaseOrders.Deleted="F" AND (char_length(tblPurchaseOrders.InvoiceNumber))>0  ');
              Add('AND tblPurchaseOrders.InvoiceDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat,SummarisedTransDate)+'" ');
              Add('GROUP BY  tblPurchaseLines.ClassID,tblPurchaseOrders.PurchaseOrderID, tblpurchaselines.CustomerJobID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                  Add(';');
              end;

  end;
end;


procedure TTransactionTableObj.TrnsTable06(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*6*/ SELECT 6,tblPurchaseOrders.OrderDate as "Date", ');
              Add('"Bill" AS Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('tblPurchaseLines.Product_Description as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0 as "DebitsEx", ');
              Add('Round(Sum('+Roundfix('tblpurchaseLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "CreditsEx", ');
              Add('0 as "DebitsInc", ');
              Add('Round(Sum('+Roundfix('tblpurchaseLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('Round(Sum('+Roundfix('tblpurchaseLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('Round(Sum('+Roundfix('tblpurchaseLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as CASH_CreditsInc ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders  ');
              Add('INNER JOIN tblPurchaseLines ON  tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON  tblPurchaseOrders.AccountID = tblchartofaccounts.AccountID ');
              Add('WHERE tblPurchaseLines.Invoiced="T" And ');
              Add('(IsBill="T") AND tblPurchaseOrders.Deleted="F" ');
              Add(' AND tblPurchaseOrders.OrderDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('GROUP BY  tblPurchaseLines.ClassID,tblPurchaseOrders.PurchaseOrderID, tblpurchaselines.CustomerJobID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                  Add(';');
              end;

  end;
end;

procedure TTransactionTableObj.TrnsTable07(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*7*/ SELECT 7,tblPurchaseOrders.OrderDate as "Date", ');
              Add('"Credit" AS Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('Round(Sum('+Roundfix('tblpurchaseLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "DebitsEx", ');
              Add('0 as "CreditsEx", ');
              Add('Round(Sum('+Roundfix('tblpurchaseLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "DebitsInc", ');
              Add('0 as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders  ');
              Add('INNER JOIN tblPurchaseLines ON  tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON  tblPurchaseOrders.AccountID = tblchartofaccounts.AccountID ');
              Add('WHERE tblPurchaseLines.Invoiced="T" And ');
              Add('(IsCredit="T") AND tblPurchaseOrders.Deleted="F" ');
              Add(' AND tblPurchaseOrders.OrderDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('GROUP BY  tblPurchaseLines.ClassID,tblPurchaseOrders.PurchaseOrderID,tblpurchaselines.CustomerJobID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable08(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*8*/ SELECT 8, ');
              Add('tblPurchaseOrders.InvoiceDate as "Date", ');
              Add('"PO" AS Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblPurchaseLines.TotalLineAmount as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('tblPurchaseLines.TotalLineAmountinc as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('tblPurchaseLines.TotalLineAmount  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('tblPurchaseLines.TotalLineAmountinc  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders  ');
              Add('INNER JOIN tblPurchaseLines ON  tblPurchaseLines.PurchaseOrderID = tblPurchaseOrders.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = tblPurchaseLines.COGSACCNTID ');
              Add('WHERE PARTTYPE = "NONINV" AND tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
              Add('AND (char_length(tblPurchaseOrders.InvoiceNumber))>0   ');
              Add(' AND tblPurchaseOrders.InvoiceDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable10(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*10*/ SELECT 10, ');
              Add('tblPurchaseOrders.InvoiceDate as "Date", ');
              Add('"PO" AS Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblPurchaseLines.TotalLineAmount as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('tblPurchaseLines.TotalLineAmountinc as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('tblPurchaseLines.TotalLineAmount as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('tblPurchaseLines.TotalLineAmountinc as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders  ');
              Add('INNER JOIN tblPurchaseLines ON tblPurchaseLines.PurchaseOrderID = tblPurchaseOrders.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = tblPurchaseLines.COGSACCNTID ');
              Add('WHERE (PARTTYPE = "OTHER") AND tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
              Add('AND (char_length(tblPurchaseOrders.InvoiceNumber))>0  ');
              Add(' AND tblPurchaseOrders.InvoiceDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable11(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*11*/ SELECT 11, ');
              Add('tblPurchaseOrders.InvoiceDate as "Date", ');
              Add('"PO" AS Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              if AppEnvVirt.Bool['CompanyPrefs.UseInventoryStandardCosting'] then begin
                Add('(tblPurchaseLines.StandardCost * Shipped) as "DebitsEx", ');
                Add('0.00 as "CreditsEx", ');
                Add('(tblPurchaseLines.StandardCost * Shipped) as "DebitsInc", ');
                Add('0.00 as "CreditsInc", ');
                Add('(tblPurchaseLines.StandardCost * Shipped)  as CASH_DebitsEx, ');
                Add('0.00  as CASH_CreditsEx, ');
                Add('(tblPurchaseLines.StandardCost * Shipped)  as CASH_DebitsInc, ');
                Add('0.00  as CASH_CreditsInc ,  ');
              end
              else begin
                Add('(tblPurchaseLines.TotalLineAmount) as "DebitsEx", ');
                Add('0.00 as "CreditsEx", ');
                Add('(tblPurchaseLines.TotalLineAmountInc) as "DebitsInc", ');
                Add('0.00 as "CreditsInc", ');
                Add('(tblPurchaseLines.TotalLineAmount)  as CASH_DebitsEx, ');
                Add('0.00  as CASH_CreditsEx, ');
                Add('(tblPurchaseLines.TotalLineAmountInc)  as CASH_DebitsInc, ');
                Add('0.00  as CASH_CreditsInc ,  ');
              end;
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders  ');
              Add('INNER JOIN tblPurchaseLines ON tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblPurchaseLines.ASSETACCNTID  ');
              Add('WHERE (PARTTYPE = "INV"  ) AND tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
              Add('AND (char_length(tblPurchaseOrders.InvoiceNumber))>0   ');
              Add(' AND tblPurchaseOrders.InvoiceDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');

              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;

              if AppEnvVirt.Bool['CompanyPrefs.UseInventoryStandardCosting'] and
                (AppEnvVirt.Int['CompanyPrefs.StandardCostPurchaseAdjustmentAccountID'] > 0) then begin
                Add('/*11*/ SELECT 11.3, tblPurchaseOrders.InvoiceDate as "Date", ');
                Add('"PO" AS Type, ');
                Add('tblPurchaseOrders.GlobalRef as "Global #", ');
                Add('tblPurchaseLines.ClassID, ');
                Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
                Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
                Add(COAColumns+',');
                Add('SupplierName as ClientName, ');
                Add('ClientID as ClientID, ');
                Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
                Add('Product_Description  as ProductDesc, ');
                Add('ProductName  as ProductName, ');
                Add('ProductGroup  as ProductGroup, ');
                Add('tblPurchaseOrders.EmployeeName  as RepName, ');
                Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
                Add('"F" as Reconciled, ');
                Add('SUBSTRING(Comments,1,255) as Notes, ');
                Add('LineTaxCode  as TaxCode, ');
                Add('LineTaxRate  as TaxRate, ');
                Add('0  as TaxID, ');
                Add('0.00 as "DebitsEx", ');
                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped) as "CreditsEx", ');
                Add('0.00 as "DebitsInc", ');
                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped) as "CreditsInc", ');
                Add('0.00  as CASH_DebitsEx, ');
                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped)  as CASH_CreditsEx, ');
                Add('0.00  as CASH_DebitsInc ,  ');
                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped)  as CASH_CreditsInc, ');
                Add('""  as `Chq/Ref` ');
                Add('FROM tblPurchaseOrders  ');
                Add('INNER JOIN tblPurchaseLines ON tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
                Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = ' + IntToStr(AppEnvVirt.Int['CompanyPrefs.StandardCostPurchaseAdjustmentAccountID']));
                Add('WHERE (PARTTYPE = "INV"  ) AND tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
                Add('AND (char_length(tblPurchaseOrders.InvoiceNumber))>0  ');
                Add(' AND tblPurchaseOrders.InvoiceDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                  Add(';');
                end;
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable12(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              If AppEnvVirt.Bool['CompanyPrefs.IncludeUnInvoicedPOtoGL'] then Begin
                  Add('/*12*/ SELECT 12.1,  ');
                  Add('tblPurchaseLines.ReceivedDate as "Date", ');
                  Add('"Un-Invoiced PO" AS Type, ');
                  Add('tblPurchaseOrders.GlobalRef as "Global #", ');
                  Add('tblPurchaseLines.ClassID, ');
                  Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
                  Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
                  Add(COAColumns+',');
                  Add('SupplierName as ClientName, ');
                  Add('ClientID as ClientID, ');
                  Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
                  Add('Product_Description  as ProductDesc, ');
                  Add('ProductName  as ProductName, ');
                  Add('ProductGroup  as ProductGroup, ');
                  Add('tblPurchaseOrders.EmployeeName  as RepName, ');
                  Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
                  Add('"F" as Reconciled, ');
                  Add('SUBSTRING(Comments,1,255) as Notes, ');
                  Add('LineTaxCode  as TaxCode, ');
                  Add('LineTaxRate  as TaxRate, ');
                  Add('0  as TaxID, ');
                  if AppEnvVirt.Bool['CompanyPrefs.UseInventoryStandardCosting'] then begin
                    Add('(tblPurchaseLines.StandardCost * Shipped) as "DebitsEx", ');
                    Add('0.00 as "CreditsEx", ');
                    Add('(tblPurchaseLines.StandardCost * Shipped) as "DebitsInc", ');
                    Add('0.00 as "CreditsInc", ');
                    Add('(tblPurchaseLines.StandardCost * Shipped)  as CASH_DebitsEx, ');
                    Add('0.00  as CASH_CreditsEx, ');
                    Add('(tblPurchaseLines.StandardCost * Shipped)  as CASH_DebitsInc, ');
                    Add('0.00  as CASH_CreditsInc ,  ');
                  end
                  else begin
                    Add('(tblPurchaseLines.TotalLineAmount) as "DebitsEx", ');
                    Add('0.00 as "CreditsEx", ');
                    Add('(tblPurchaseLines.TotalLineAmount) as "DebitsInc", ');
                    Add('0.00 as "CreditsInc", ');
                    Add('(tblPurchaseLines.TotalLineAmount)  as CASH_DebitsEx, ');
                    Add('0.00  as CASH_CreditsEx, ');
                    Add('(tblPurchaseLines.TotalLineAmount)  as CASH_DebitsInc, ');
                    Add('0.00  as CASH_CreditsInc ,  ');
                  end;
                  Add('""  as `Chq/Ref` ');
                  Add('FROM tblPurchaseOrders  ');
                  Add('INNER JOIN tblPurchaseLines ON tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
                  Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblPurchaseLines.ASSETACCNTID  ');
                  Add('WHERE (PARTTYPE = "INV"  ) AND tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
                  Add(' AND tblPurchaseLines.ReceivedDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate)+ '"');
                  if not AppEnvVirt.Bool['CompanyPrefs.POHasPeriodPosting'] then
                    Add('AND (char_length(tblPurchaseOrders.InvoiceNumber)=0 OR IsNull(tblPurchaseOrders.InvoiceNumber))  ');

                  if not DonotMakeTransTable then begin
                    TempFile:= NextTempFile;
                    Add('INTO OUTFILE "' + TempFile + '";');
                    Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                  end else begin
                    Add(';');
                  end;


                  if AppEnvVirt.Bool['CompanyPrefs.UseInventoryStandardCosting'] and
                    (AppEnvVirt.Int['CompanyPrefs.StandardCostPurchaseAdjustmentAccountID'] > 0) then begin
                    Add('/*12*/ SELECT 12.2, tblPurchaseLines.ReceivedDate as "Date", ');
                    Add('"Un-Invoiced PO" AS Type, ');
                    Add('tblPurchaseOrders.GlobalRef as "Global #", ');
                    Add('tblPurchaseLines.ClassID, ');
                    Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
                    Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
                    Add(COAColumns+',');
                    Add('SupplierName as ClientName, ');
                    Add('ClientID as ClientID, ');
                    Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
                    Add('Product_Description  as ProductDesc, ');
                    Add('ProductName  as ProductName, ');
                    Add('ProductGroup  as ProductGroup, ');
                    Add('tblPurchaseOrders.EmployeeName  as RepName, ');
                    Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
                    Add('"F" as Reconciled, ');
                    Add('SUBSTRING(Comments,1,255) as Notes, ');
                    Add('LineTaxCode  as TaxCode, ');
                    Add('LineTaxRate  as TaxRate, ');
                    Add('0  as TaxID, ');
                Add('0.00 as "DebitsEx", ');
                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped) as "CreditsEx", ');
                Add('0.00 as "DebitsInc", ');
                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped) as "CreditsInc", ');
                Add('0.00  as CASH_DebitsEx, ');
                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped)  as CASH_CreditsEx, ');
                Add('0.00  as CASH_DebitsInc ,  ');
                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped)  as CASH_CreditsInc, ');


                    Add('""  as `Chq/Ref` ');
                    Add('FROM tblPurchaseOrders  ');
                    Add('INNER JOIN tblPurchaseLines ON tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
                    Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = ' + IntToStr(AppEnvVirt.Int['CompanyPrefs.StandardCostPurchaseAdjustmentAccountID']));
                    Add('WHERE (PARTTYPE = "INV"  ) AND tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
                    //Add('AND (char_length(tblPurchaseOrders.InvoiceNumber)=0 OR IsNull(tblPurchaseOrders.InvoiceNumber))  ');
                  if not AppEnvVirt.Bool['CompanyPrefs.POHasPeriodPosting'] then
                    Add('AND (char_length(tblPurchaseOrders.InvoiceNumber)=0 OR IsNull(tblPurchaseOrders.InvoiceNumber))  ');

                    Add(' AND tblPurchaseLines.ReceivedDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate)+ '"');
                    if not DonotMakeTransTable then begin
                      TempFile:= NextTempFile;
                      Add('INTO OUTFILE "' + TempFile + '";');
                      Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                    end else begin
                      Add(';');
                    end;
                  end;

                  Add('/*12*/ SELECT 12.3, tblPurchaseLines.ReceivedDate as "Date", ');
                  Add('"Un-Invoiced PO" AS Type, ');
                  Add('tblPurchaseOrders.GlobalRef as "Global #", ');
                  Add('tblPurchaseLines.ClassID, ');
                  Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
                  Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
                  Add(COAColumns+',');
                  Add('SupplierName as ClientName, ');
                  Add('ClientID as ClientID, ');
                  Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
                  Add('Product_Description  as ProductDesc, ');
                  Add('ProductName  as ProductName, ');
                  Add('ProductGroup  as ProductGroup, ');
                  Add('tblPurchaseOrders.EmployeeName  as RepName, ');
                  Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
                  Add('"F" as Reconciled, ');
                  Add('SUBSTRING(Comments,1,255) as Notes, ');
                  Add('LineTaxCode  as TaxCode, ');
                  Add('LineTaxRate  as TaxRate, ');
                  Add('0  as TaxID, ');
                  Add('(tblPurchaseLines.TotalLineAmount) as "DebitsEx", ');
                  Add('0.00 as "CreditsEx", ');
                  Add('(tblPurchaseLines.TotalLineAmount) as "DebitsInc", ');
                  Add('0.00 as "CreditsInc", ');
                  Add('(tblPurchaseLines.TotalLineAmount)  as CASH_DebitsEx, ');
                  Add('0.00  as CASH_CreditsEx, ');
                  Add('(tblPurchaseLines.TotalLineAmount)  as CASH_DebitsInc, ');
                  Add('0.00  as CASH_CreditsInc ,  ');
                  Add('""  as `Chq/Ref` ');
                  Add('FROM tblPurchaseOrders  ');
                  Add('INNER JOIN tblPurchaseLines ON tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
                  Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblPurchaseLines.INCOMEACCNTID  ');
                  Add('WHERE (PARTTYPE <> "INV"  ) AND tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
                  //Add('AND (char_length(tblPurchaseOrders.InvoiceNumber)=0 OR IsNull(tblPurchaseOrders.InvoiceNumber))  ');
                  if not AppEnvVirt.Bool['CompanyPrefs.POHasPeriodPosting'] then
                    Add('AND (char_length(tblPurchaseOrders.InvoiceNumber)=0 OR IsNull(tblPurchaseOrders.InvoiceNumber))  ');

                  Add(' AND tblPurchaseLines.ReceivedDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate)+ '"');
                  if not DonotMakeTransTable then begin
                    TempFile:= NextTempFile;
                    Add('INTO OUTFILE "' + TempFile + '";');
                    Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                  end else begin
                    Add(';');
                  end;


                  Add('/*12*/ SELECT 12.4, tblPurchaseLines.ReceivedDate as "Date", ');
                  Add('"Un-Invoiced PO" AS Type, ');
                  Add('tblPurchaseOrders.GlobalRef as "Global #", ');
                  Add('tblPurchaseLines.ClassID, ');
                  Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
                  Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
                  Add(COAColumns+',');
                  Add('SupplierName as ClientName, ');
                  Add('ClientID as ClientID, ');
                  Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
                  Add('Product_Description  as ProductDesc, ');
                  Add('ProductName  as ProductName, ');
                  Add('ProductGroup  as ProductGroup, ');
                  Add('tblPurchaseOrders.EmployeeName  as RepName, ');
                  Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
                  Add('"F" as Reconciled, ');
                  Add('SUBSTRING(Comments,1,255) as Notes, ');
                  Add('LineTaxCode  as TaxCode, ');
                  Add('LineTaxRate  as TaxRate, ');
                  Add('0  as TaxID, ');
                  Add('0.00 as "DebitsEx", ');
                  Add('(tblPurchaseLines.TotalLineAmount) as "CreditsEx", ');
                  Add('0.00 as "DebitsInc", ');
                  Add('(tblPurchaseLines.TotalLineAmount) as "CreditsInc", ');
                  Add('0.00  as CASH_DebitsEx, ');
                  Add('(tblPurchaseLines.TotalLineAmount)  as CASH_CreditsEx, ');
                  Add('0.00  as CASH_DebitsInc, ');
                  Add('(tblPurchaseLines.TotalLineAmount)  as CASH_CreditsInc ,  ');
                  Add('""  as `Chq/Ref` ');
                  Add('FROM tblPurchaseOrders  ');
                  Add('INNER JOIN tblPurchaseLines ON tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
                  Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = ' + IntToStr(AppEnvVirt.Int['CompanyPrefs.UnInvoicedPOAccount']) + '  ');
                  Add('WHERE tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
                  if not AppEnvVirt.Bool['CompanyPrefs.POHasPeriodPosting'] then
                      Add('AND (char_length(tblPurchaseOrders.InvoiceNumber)=0 OR IsNull(tblPurchaseOrders.InvoiceNumber))  ');
                  Add(' AND tblPurchaseLines.ReceivedDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate)+ '"');
                  if not DonotMakeTransTable then begin
                    TempFile:= NextTempFile;
                    Add('INTO OUTFILE "' + TempFile + '";');
                    Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                  end else begin
                    Add(';');
                  end;


                  if AppEnvVirt.Bool['CompanyPrefs.POHasPeriodPosting'] then begin
                    Add('/*12*/ SELECT 12.11,  ');
                    Add('tblPurchaseOrders.InvoiceDate as "Date", ');
                    Add('"Un-Invoiced PO" AS Type, ');
                    Add('tblPurchaseOrders.GlobalRef as "Global #", ');
                    Add('tblPurchaseLines.ClassID, ');
                    Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
                    Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
                    Add(COAColumns+',');
                    Add('SupplierName as ClientName, ');
                    Add('ClientID as ClientID, ');
                    Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
                    Add('Product_Description  as ProductDesc, ');
                    Add('ProductName  as ProductName, ');
                    Add('ProductGroup  as ProductGroup, ');
                    Add('tblPurchaseOrders.EmployeeName  as RepName, ');
                    Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
                    Add('"F" as Reconciled, ');
                    Add('SUBSTRING(Comments,1,255) as Notes, ');
                    Add('LineTaxCode  as TaxCode, ');
                    Add('LineTaxRate  as TaxRate, ');
                    Add('0  as TaxID, ');
                    if AppEnvVirt.Bool['CompanyPrefs.UseInventoryStandardCosting'] then begin
                      Add('0.0 as "DebitsEx", ');
                      Add('(tblPurchaseLines.StandardCost * Shipped) as "CreditsEx", ');
                      Add('0.00 as "DebitsInc", ');
                      Add('(tblPurchaseLines.StandardCost * Shipped) as "CreditsInc", ');
                      Add('0.00  as CASH_DebitsEx, ');
                      Add('(tblPurchaseLines.StandardCost * Shipped)  as CASH_CreditsEx, ');
                      Add('0.00  as CASH_DebitsInc, ');
                      Add('(tblPurchaseLines.StandardCost * Shipped)  as CASH_CreditsInc ,  ');
                    end
                    else begin
                      Add('0.00 as "DebitsEx", ');
                      Add('(tblPurchaseLines.TotalLineAmount) as "CreditsEx", ');
                      Add('0.00 as "DebitsInc", ');
                      Add('(tblPurchaseLines.TotalLineAmount) as "CreditsInc", ');
                      Add('0.00  as CASH_DebitsEx, ');
                      Add('(tblPurchaseLines.TotalLineAmount)  as CASH_CreditsEx, ');
                      Add('0.00  as CASH_DebitsInc, ');
                      Add('(tblPurchaseLines.TotalLineAmount)  as CASH_CreditsInc ,  ');
                    end;
                    Add('""  as `Chq/Ref` ');
                    Add('FROM tblPurchaseOrders  ');
                    Add('INNER JOIN tblPurchaseLines ON tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
                    Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblPurchaseLines.ASSETACCNTID  ');
                    Add('WHERE (PARTTYPE = "INV"  ) AND tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
                    Add(' AND tblPurchaseOrders.InvoiceDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate)+ '"');
                    Add('AND char_length(tblPurchaseOrders.InvoiceNumber) >0  ');

                    if not DonotMakeTransTable then begin
                      TempFile:= NextTempFile;
                      Add('INTO OUTFILE "' + TempFile + '";');
                      Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                    end else begin
                      Add(';');
                    end;

                  if AppEnvVirt.Bool['CompanyPrefs.UseInventoryStandardCosting'] and
                    (AppEnvVirt.Int['CompanyPrefs.StandardCostPurchaseAdjustmentAccountID'] > 0) then begin
                    Add('/*12*/ SELECT 12.21, tblPurchaseOrders.InvoiceDate  as "Date", ');
                    Add('"Un-Invoiced PO" AS Type, ');
                    Add('tblPurchaseOrders.GlobalRef as "Global #", ');
                    Add('tblPurchaseLines.ClassID, ');
                    Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
                    Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
                    Add(COAColumns+',');
                    Add('SupplierName as ClientName, ');
                    Add('ClientID as ClientID, ');
                    Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
                    Add('Product_Description  as ProductDesc, ');
                    Add('ProductName  as ProductName, ');
                    Add('ProductGroup  as ProductGroup, ');
                    Add('tblPurchaseOrders.EmployeeName  as RepName, ');
                    Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
                    Add('"F" as Reconciled, ');
                    Add('SUBSTRING(Comments,1,255) as Notes, ');
                    Add('LineTaxCode  as TaxCode, ');
                    Add('LineTaxRate  as TaxRate, ');
                    Add('0  as TaxID, ');

                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped) as "DebitsEx", ');
                Add('0.00 as "CreditsEx", ');
                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped)  as "DebitsInc", ');
                Add('0.00 as "CreditsInc", ');
                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped)  as CASH_DebitsEx, ');
                Add('0.00  as CASH_CreditsEx, ');
                Add('((tblPurchaseLines.StandardCost - tblPurchaseLines.LineCost) * tblPurchaseLines.Shipped)  as CASH_DebitsInc ,  ');
                Add('0.00  as CASH_CreditsInc, ');


                    Add('""  as `Chq/Ref` ');
                    Add('FROM tblPurchaseOrders  ');
                    Add('INNER JOIN tblPurchaseLines ON tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
                    Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = ' + IntToStr(AppEnvVirt.Int['CompanyPrefs.StandardCostPurchaseAdjustmentAccountID']));
                    Add('WHERE (PARTTYPE = "INV"  ) AND tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
                    Add(' AND tblPurchaseOrders.InvoiceDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate)+ '"');
                    Add('AND char_length(tblPurchaseOrders.InvoiceNumber) >0  ');
                    if not DonotMakeTransTable then begin
                      TempFile:= NextTempFile;
                      Add('INTO OUTFILE "' + TempFile + '";');
                      Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                    end else begin
                      Add(';');
                    end;
                  end;

                  Add('/*12*/ SELECT 12.31, tblPurchaseOrders.InvoiceDate as "Date", ');
                  Add('"Un-Invoiced PO" AS Type, ');
                  Add('tblPurchaseOrders.GlobalRef as "Global #", ');
                  Add('tblPurchaseLines.ClassID, ');
                  Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
                  Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
                  Add(COAColumns+',');
                  Add('SupplierName as ClientName, ');
                  Add('ClientID as ClientID, ');
                  Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
                  Add('Product_Description  as ProductDesc, ');
                  Add('ProductName  as ProductName, ');
                  Add('ProductGroup  as ProductGroup, ');
                  Add('tblPurchaseOrders.EmployeeName  as RepName, ');
                  Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
                  Add('"F" as Reconciled, ');
                  Add('SUBSTRING(Comments,1,255) as Notes, ');
                  Add('LineTaxCode  as TaxCode, ');
                  Add('LineTaxRate  as TaxRate, ');
                  Add('0  as TaxID, ');
                  Add('0.00 as "DebitsEx", ');
                  Add('(tblPurchaseLines.TotalLineAmount) as "CreditsEx", ');
                  Add('0.00 as "DebitsInc", ');
                  Add('(tblPurchaseLines.TotalLineAmount) as "CreditsInc", ');
                  Add('0.00 as CASH_DebitsEx, ');
                  Add('(tblPurchaseLines.TotalLineAmount)   as CASH_CreditsEx, ');
                  Add('0.00  as CASH_DebitsInc, ');
                  Add('(tblPurchaseLines.TotalLineAmount)  as CASH_CreditsInc ,  ');
                  Add('""  as `Chq/Ref` ');
                  Add('FROM tblPurchaseOrders  ');
                  Add('INNER JOIN tblPurchaseLines ON tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
                  Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblPurchaseLines.INCOMEACCNTID  ');
                  Add('WHERE (PARTTYPE <> "INV"  ) AND tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
                    Add(' AND tblPurchaseOrders.InvoiceDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate)+ '"');
                    Add('AND char_length(tblPurchaseOrders.InvoiceNumber) >0  ');
                  if not DonotMakeTransTable then begin
                    TempFile:= NextTempFile;
                    Add('INTO OUTFILE "' + TempFile + '";');
                    Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                  end else begin
                    Add(';');
                  end;


                    Add('/*12*/ SELECT 12.41, tblPurchaseOrders.InvoiceDate as "Date", ');
                    Add('"Un-Invoiced PO" AS Type, ');
                    Add('tblPurchaseOrders.GlobalRef as "Global #", ');
                    Add('tblPurchaseLines.ClassID, ');
                    Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
                    Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
                    Add(COAColumns+',');
                    Add('SupplierName as ClientName, ');
                    Add('ClientID as ClientID, ');
                    Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
                    Add('Product_Description  as ProductDesc, ');
                    Add('ProductName  as ProductName, ');
                    Add('ProductGroup  as ProductGroup, ');
                    Add('tblPurchaseOrders.EmployeeName  as RepName, ');
                    Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
                    Add('"F" as Reconciled, ');
                    Add('SUBSTRING(Comments,1,255) as Notes, ');
                    Add('LineTaxCode  as TaxCode, ');
                    Add('LineTaxRate  as TaxRate, ');
                    Add('0  as TaxID, ');
                    Add('(tblPurchaseLines.TotalLineAmount) as "DebitsEx", ');
                    Add('0.00 as "CreditsEx", ');
                    Add('(tblPurchaseLines.TotalLineAmount) as "DebitsInc", ');
                    Add('0.00  as CreditsInc, ');
                    Add('(tblPurchaseLines.TotalLineAmount)  as CASH_DebitsEx, ');
                    Add('0.00  as CASH_CreditsEx, ');
                    Add('(tblPurchaseLines.TotalLineAmount)  as CASH_DebitsInc ,  ');
                    Add('0.00 as "CASH_CreditsInc", ');
                    Add('""  as `Chq/Ref` ');
                    Add('FROM tblPurchaseOrders  ');
                    Add('INNER JOIN tblPurchaseLines ON tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
                    Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = ' + IntToStr(AppEnvVirt.Int['CompanyPrefs.UnInvoicedPOAccount']) + '  ');
                    Add('WHERE tblPurchaseLines.Invoiced="T" And tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ');
                    Add('AND char_length(tblPurchaseOrders.InvoiceNumber) >0  ');
                    Add(' AND tblPurchaseOrders.InvoiceDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate)+ '"');
                    if not DonotMakeTransTable then begin
                      TempFile:= NextTempFile;
                      Add('INTO OUTFILE "' + TempFile + '";');
                      Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                    end else begin
                      Add(';');
                    end;
                  end;
              end;
  end;
end;


procedure TTransactionTableObj.TrnsTable14(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              If AppEnvVirt.Bool['CompanyPrefs.IncludeUnInvoicedSOtoGL'] then Begin
                  Add('/*14*/ SELECT STRAIGHT_JOIN 14, tblSales.SaleDate as "Date", ');
                  Add('"UnInvoiced SO" as Type, ');
                  Add('tblSales.GlobalRef as "Global #", ');
                  Add('tblSales.ClassID, ');
                  Add(Idcolumn('tblSales.SaleID','','','',''));
                  Add(LineIdcolumn('','','',''));
                  Add(COAColumns+',');
                  Add('CustomerName as ClientName, ');
                  Add('ClientID as ClientID, ');
                  Add('0 as CustomerJobId, ');
                  Add('""  as ProductDesc, ');
                  Add('""  as ProductName, ');
                  Add('""  as ProductGroup, ');
                  Add('EmployeeName  as RepName, ');
                  Add('EmployeeID  as EmployeeID, ');
                  Add('"F" as Reconciled, ');
                  Add('SUBSTRING(Comments,1,255) as Notes, ');
                  Add('""  as TaxCode, ');
                  Add('0.00  as TaxRate, ');
                  Add('0  as TaxID, ');
                  If (AppEnvVirt.Int['CompanyPrefs.UnInvoicedSOType'] = 0) then Begin //Income
                    Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "DebitsEx", ');
                    Add('0.00 as "CreditsEx", ');
                    Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+')  as "DebitsInc", ');
                    Add('0.00 as "CreditsInc", ');
                    Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as  CASH_DebitsEx, ');
                    Add('0.00  as CASH_CreditsEx, ');
                    Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as CASH_DebitsInc, ');
                    Add('0.00  as CASH_CreditsInc, ');
                  end else If (AppEnvVirt.Int['CompanyPrefs.UnInvoicedSOType'] = 1) then Begin //Cost
                    Add('Sum(tblSalesLines.LineCost*tblSalesLines.Shipped) as "DebitsEx", ');
                    Add('0.00 as "CreditsEx", ');
                    Add('Sum(tblSalesLines.LineCost*tblSalesLines.Shipped) as "DebitsInc", ');
                    Add('0.00 as "CreditsInc", ');
                    Add('Sum(tblSalesLines.LineCost*tblSalesLines.Shipped) as CASH_DebitsEx, ');
                    Add('0.00 as CASH_CreditsEx, ');
                    Add('Sum(tblSalesLines.LineCost*tblSalesLines.Shipped) as CASH_DebitsInc, ');
                    Add('0.00 as CASH_CreditsInc, ');
                  end;
                  Add('""  as `Chq/Ref` ');
                  Add('FROM tblSales ');
                  Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
                  Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID =  ' + IntToStr(AppEnvVirt.Int['CompanyPrefs.UnInvoicedSOAccount']) + '  ');
                  Add('WHERE tblSales.IsSalesOrder="T" AND tblSales.Deleted="F" and `Converted` = "F" ');
                  Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
                  Add('AND tblSalesLines.Invoiced="T" ');
                  Add('GROUP BY  tblSales.SaleID');
                  if not DonotMakeTransTable then begin
                    TempFile:= NextTempFile;
                    Add('INTO OUTFILE "' + TempFile + '";');
                    Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                  end else begin
                    Add(';');
                  end;

                  Add('/*15*/ SELECT STRAIGHT_JOIN 15, tblSales.SaleDate as "Date", ');
                  Add('"UnInvoiced SO" as Type, ');
                  Add('tblSales.GlobalRef as "Global #", ');
                  Add('tblSales.ClassID, ');
                  Add(Idcolumn('tblSales.SaleID','','','',''));
                  Add(LineIdcolumn('','','',''));
                  Add(COAColumns+',');
                  Add('CustomerName as ClientName, ');
                  Add('ClientID as ClientID, ');
                  Add('0 as CustomerJobId, ');
                  Add('""  as ProductDesc, ');
                  Add('""  as ProductName, ');
                  Add('""  as ProductGroup, ');
                  Add('EmployeeName  as RepName, ');
                  Add('EmployeeID  as EmployeeID, ');
                  Add('"F" as Reconciled, ');
                  Add('SUBSTRING(Comments,1,255) as Notes, ');
                  Add('""  as TaxCode, ');
                  Add('0.00  as TaxRate, ');
                  Add('0  as TaxID, ');
                  If (AppEnvVirt.Int['CompanyPrefs.UnInvoicedSOType'] = 0) then Begin //Income
                    Add('0.00 as "DebitsEx", ');
                    Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "CreditsEx", ');
                    Add('0.00  as "DebitsInc", ');
                    Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as "CreditsInc", ');
                    Add('0.00 as  CASH_DebitsEx, ');
                    Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as CASH_CreditsEx, ');
                    Add('0.00 as CASH_DebitsInc, ');
                    Add('Round(Sum('+Roundfix('tblSalesLines.TotalLineAmountInc')+'),' +inttostr(fTotalsRoundPlaces)+') as CASH_CreditsInc, ');
                  end else If (AppEnvVirt.Int['CompanyPrefs.UnInvoicedSOType'] = 1) then Begin //Cost
                    Add('0.00 as "DebitsEx", ');
                    Add('Sum(tblSalesLines.LineCost*tblSalesLines.Shipped) as "CreditsEx", ');
                    Add('0.00 as "DebitsInc", ');
                    Add('Sum(tblSalesLines.LineCost*tblSalesLines.Shipped) as "CreditsInc", ');
                    Add('0.00 as CASH_DebitsEx, ');
                    Add('Sum(tblSalesLines.LineCost*tblSalesLines.Shipped) as CASH_CreditsEx, ');
                    Add('0.00 as CASH_DebitsInc, ');
                    Add('Sum(tblSalesLines.LineCost*tblSalesLines.Shipped) as CASH_CreditsInc, ');
                  end;
                  Add('""  as `Chq/Ref` ');
                  Add('FROM tblSales ');
                  Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
                  Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = '+ IntToStr(getAccountID('UnInvoiced SO'))+' ');
                  Add('WHERE tblSales.IsSalesOrder="T" AND tblSales.Deleted="F" and `Converted` = "F" ');
                  Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
                  Add('AND tblSalesLines.Invoiced="T" ');
                  Add('GROUP BY  tblSales.SaleID');
                  if not DonotMakeTransTable then begin
                    TempFile:= NextTempFile;
                    Add('INTO OUTFILE "' + TempFile + '";');
                    Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                  end else begin
                    Add(';');
                  end;
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable16(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*16*/ SELECT 16, tblPurchaseOrders.OrderDate as "Date",  ');
              Add('"Bill" AS Type,  ');
              Add('tblPurchaseOrders.GlobalRef as "Global #",  ');
              Add('tblPurchaseLines.ClassID,  ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('Product_Description as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('Round('+Roundfix('tblPurchaseLines.LineCost ')+',5) as "DebitsEx", ');
              //Add('tblPurchaseLines.LineCost as "DebitsEx",  ');
              Add('0.00 as "CreditsEx",  ');
              Add('Round('+Roundfix('tblPurchaseLines.LineCostInc ')+',5) as "DebitsInc", ');
              //Add('tblPurchaseLines.LineCostInc as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('Round('+Roundfix('tblPurchaseLines.LineCost ')+',5) as "CASH_DebitsEx", ');
              //Add('tblPurchaseLines.LineCost  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('Round('+Roundfix('tblPurchaseLines.LineCostInc ')+',5) as "CASH_DebitsInc", ');
              //Add('tblPurchaseLines.LineCostInc  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders  ');
              Add('INNER JOIN tblPurchaseLines ON tblPurchaseLines.PurchaseOrderID = tblPurchaseOrders.PurchaseOrderID  ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountName = tblPurchaseLines.AccountName ');
              Add('WHERE tblPurchaseLines.Invoiced="T" And IsBill="T" AND tblPurchaseOrders.Deleted="F"  ');
              Add(' AND tblPurchaseOrders.OrderDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
 end;
end;

procedure TTransactionTableObj.TrnsTable17(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*17*/ SELECT 17, tblPurchaseOrders.OrderDate as "Date",  ');
              Add('"Credit" AS Type,  ');
              Add('tblPurchaseOrders.GlobalRef as "Global #",  ');
              Add('tblPurchaseLines.ClassID,  ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('Product_Description as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx",  ');
              Add('tblPurchaseLines.LineCost as "CreditsEx",  ');
              Add('0.00 as "DebitsInc", ');
              Add('tblPurchaseLines.LineCostInc as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('tblPurchaseLines.LineCost  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('tblPurchaseLines.LineCostInc  as CASH_CreditsInc ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders  ');
              Add('INNER JOIN tblPurchaseLines  ON tblPurchaseLines.PurchaseOrderID = tblPurchaseOrders.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountName = tblPurchaseLines.AccountName ');
              Add('WHERE tblPurchaseLines.Invoiced="T" And IsCredit="T" AND tblPurchaseOrders.Deleted="F"  ');
              Add(' AND tblPurchaseOrders.OrderDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat,SummarisedTransDate)+ '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable18(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*18*/ SELECT 18, tbldeposits.PaymentDate as "Date", ');
              Add('"Customer Payment" AS Type, ');
              Add('tbldeposits.GlobalRef  as "Global #", ');
              Add('tbldeposits.ClassID, ');
              Add(Idcolumn('','','tbldeposits.PaymentID','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('tbldeposits.CompanyName as ClientName, ');
              Add('tbldeposits.CusID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('CONCAT_WS(" ", FirstName, LastName)  as RepName, ');
              Add('tbldeposits.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tbldeposits.Amount as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('tbldeposits.Amount as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('tbldeposits.Amount  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('tbldeposits.Amount  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('tbldeposits.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tbldeposits  ');
              Add('INNER JOIN tbldepositline USING(PaymentID) ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tbldeposits.AccountID ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tbldeposits.EmployeeID ');
              Add('WHERE tbldeposits.Deleted = "F" AND tbldeposits.Amount<>0.00 ');
              Add(' AND tbldeposits.PaymentDate '+BeforeOrAfterClosing+ ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('GROUP BY tbldeposits.PaymentID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable19(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*19*/ SELECT 19,tbldeposits.PaymentDate as "Date", ');
              Add('"Customer Payment" AS Type, ');
              Add('tbldeposits.GlobalRef  as "Global #", ');
              Add('tbldeposits.ClassID, ');
              Add(Idcolumn('If(tbldepositline.TrnType="Prepayment",0,tbldepositline.SaleID)','','tbldeposits.PaymentID','If(tbldepositline.TrnType="Prepayment",tbldepositline.PrePaymentID,0)',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('tbldeposits.CompanyName as ClientName, ');
              Add('tbldeposits.CusID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('CONCAT_WS(" ", FirstName, LastName)  as RepName, ');
              Add('tbldeposits.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('tbldeposits.ForeignVariationAmount as "CreditsEx", ');
              Add('0.00 as "DebitsInc",');
              Add('tbldeposits.ForeignVariationAmount as "CreditsInc", ');
              Add('0.00  as CASH_DebitsEx, ');
              Add('tbldeposits.ForeignVariationAmount as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc  ,  ');
              Add('tbldeposits.ForeignVariationAmount as CASH_CreditsInc, ');
              Add('tbldeposits.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tbldeposits  ');
              Add('INNER JOIN tbldepositline USING(PaymentID) ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tbldeposits.ForeignVariationAccountID ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tbldeposits.EmployeeID ');
              Add('WHERE tbldeposits.Deleted = "F" AND tbldeposits.ForeignVariationAmount<>0.00 ');
              Add(' AND tbldeposits.PaymentDate '+BeforeOrAfterClosing+ ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('GROUP BY tbldeposits.PaymentID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable20(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*20*/ SELECT 20, tbldeposits.PaymentDate as "Date", ');
              Add('"Customer Payment" AS Type, ');
              Add('tbldeposits.GlobalRef  as "Global #", ');
              Add('tbldeposits.ClassID, ');
              Add(Idcolumn('If(tbldepositline.TrnType="Prepayment",0,tbldepositline.SaleID)','','tbldeposits.PaymentID','If(tbldepositline.TrnType="Prepayment",tbldepositline.PrePaymentID,0)',''));
              Add(LineIdcolumn('','','tbldepositline.PaymentLineID',''));
              Add(COAColumns+',');
              Add('tbldeposits.CompanyName as ClientName, ');
              Add('tbldeposits.CusID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('CONCAT_WS(" ", FirstName, LastName)  as RepName, ');
              Add('tbldeposits.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('-tbldepositline.Payment as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('-tbldepositline.Payment as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('-tbldepositline.Payment  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('-tbldepositline.Payment  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('tbldeposits.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tbldeposits  ');
              Add('INNER JOIN tbldepositline USING(PaymentID) ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=' + IntToStr(AppEnvVirt.Int['DNMLib.GetCustomerPrepaymentAccountID']) + ' ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tbldeposits.EmployeeID ');
              Add('WHERE tbldeposits.Deleted = "F" AND TrnType = "Prepayment" ');
              Add(' AND tbldeposits.PaymentDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable21(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*21*/ SELECT 21, tbldeposits.PaymentDate as "Date", ');
              Add('"Customer Payment" AS Type, ');
              Add('tbldeposits.GlobalRef  as "Global #", ');
              Add('tbldeposits.ClassID, ');
              Add(Idcolumn('If(tbldepositline.TrnType="Prepayment",0,tbldepositline.SaleID)','','tbldeposits.PaymentID','If(tbldepositline.TrnType="Prepayment",tbldepositline.PrePaymentID,0)',''));
              Add(LineIdcolumn('','','tbldepositline.PaymentLineID',''));
              Add(COAColumns+',');
              Add('tbldeposits.CompanyName as ClientName, ');
              Add('tbldeposits.CusID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblemployees.EmployeeName as RepName, ');
              Add('tbldeposits.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('tbldepositline.Payment as "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('tbldepositline.Payment as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('tbldepositline.Payment as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('tbldepositline.Payment as CASH_CreditsInc  ,  ');
              Add('tbldeposits.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tbldeposits ');
              Add('INNER JOIN tbldepositline ON tbldepositline.PaymentID = tbldeposits.PaymentID ');
              Add('INNER JOIN tblSales ON tblSales.SaleID = tbldepositline.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblSales.AccountID ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID = tbldeposits.EmployeeID ');
              Add('WHERE tbldeposits.Deleted = "F" ');
              Add('AND tbldeposits.PaymentDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable22(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*22*/ SELECT 22, tblSales.SaleDate as "Date", ');
              Add('"Invoice" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('tblSalesLines.TotalLineAmount as "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('tblSalesLines.TotalLineAmountInc as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('tblSalesLines.TotalLineAmount  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('tblSalesLines.TotalLineAmountInc  as CASH_CreditsInc,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales   ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblSalesLines.INCOMEACCNTID ');
              Add('WHERE tblSales.IsInvoice="T" AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F" ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.Invoiced="T"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable23(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*23*/ SELECT 23, tblSales.SaleDate as "Date", ');
              Add('"Cash Sale" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('tblSalesLines.TotalLineAmount as "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('tblSalesLines.TotalLineAmountInc as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('tblSalesLines.TotalLineAmount  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('tblSalesLines.TotalLineAmountInc  as CASH_CreditsInc ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblSalesLines.INCOMEACCNTID ');
              Add('WHERE (tblSales.IsCashSale="T") AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable24(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*24*/ SELECT 24, tblSales.SaleDate as "Date", ');
              Add('"Refund" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('-tblSalesLines.TotalLineAmount as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('-tblSalesLines.TotalLineAmountInc as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('-tblSalesLines.TotalLineAmount  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('-tblSalesLines.TotalLineAmountInc as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblSalesLines.INCOMEACCNTID ');
              Add('WHERE (tblSales.IsRefund ="T") AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add(' AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable25(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*25*/ SELECT 25, tblSales.SaleDate as "Date", ');
              Add('"Invoice" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              if AppEnvVirt.Bool['CompanyPrefs.UseInventoryStandardCosting'] and
                (AppEnvVirt.INT['CompanyPrefs.StandardCostCOGSAdjustmentAccountID'] > 0) then begin
                Add('0.00 as "DebitsEx", ');
                Add('If(tblSalesLines.StandardCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.StandardCost*tblSalesLines.Shipped,0.00) as "CreditsEx", ');
                Add('0.00 as "DebitsInc", ');
                Add('If(tblSalesLines.StandardCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.StandardCost*tblSalesLines.Shipped,0.00) as "CreditsInc",');
                Add('0.00  as CASH_DebitsEx, ');
                Add('If(tblSalesLines.StandardCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.StandardCost*tblSalesLines.Shipped,0.00)  as CASH_CreditsEx, ');
                Add('0.00  as CASH_DebitsInc, ');
                Add('If(tblSalesLines.StandardCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.StandardCost*tblSalesLines.Shipped,0.00)  as CASH_CreditsInc  ,  ');
              end
              else begin
                Add('0.00 as "DebitsEx", ');
                Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00) as "CreditsEx", ');
                Add('0.00 as "DebitsInc", ');
                Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00) as "CreditsInc",');
                Add('0.00  as CASH_DebitsEx, ');
                Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)  as CASH_CreditsEx, ');
                Add('0.00  as CASH_DebitsInc, ');
                Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)  as CASH_CreditsInc  ,  ');
              end;
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales  ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = tblSalesLines.ASSETACCNTID  ');
              Add('WHERE tblSales.IsInvoice="T" AND tblSales.IsSalesOrder="F" AND tblSales.IsQuote="F" AND tblSales.Deleted="F" ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.Invoiced="T" AND (PARTTYPE = "INV")');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
              end;



              if AppEnvVirt.Bool['CompanyPrefs.UseInventoryStandardCosting'] and
                (AppEnvVirt.INT['CompanyPrefs.StandardCostCOGSAdjustmentAccountID'] > 0) then begin
                Add('/*25*/ SELECT 25.2, tblSales.SaleDate as "Date", ');
                Add('"Invoice" as Type, ');
                Add('tblSales.GlobalRef as "Global #", ');
                Add('tblSales.ClassID, ');
                Add(Idcolumn('tblSales.SaleID','','','',''));
                Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
                Add(COAColumns+',');
                Add('CustomerName as ClientName, ');
                Add('ClientID as ClientID, ');
                Add('0 as CustomerJobId, ');
                Add('Product_Description  as ProductDesc, ');
                Add('ProductName  as ProductName, ');
                Add('ProductGroup  as ProductGroup, ');
                Add('EmployeeName  as RepName, ');
                Add('EmployeeID  as EmployeeID, ');
                Add('"F" as Reconciled, ');
                Add('SUBSTRING(Comments,1,255) as Notes, ');
                Add('""  as TaxCode, ');
                Add('0.00  as TaxRate, ');
                Add('0  as TaxID, ');
                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00) as "DebitsEx", ');
                Add('0.00 as "CreditsEx", ');

                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00) as "DebitsInc",');
                Add('0.00 as "CreditsInc", ');

                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00)  as CASH_DebitsEx, ');
                Add('0.00  as CASH_CreditsEx, ');

                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00)  as CASH_DebitsInc  ,  ');
                Add('0.00  as CASH_CreditsInc, ');

                Add('""  as `Chq/Ref` ');
                Add('FROM tblSales  ');
                Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
                Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = ' + IntToStr(AppEnvVirt.INT['CompanyPrefs.StandardCostCOGSAdjustmentAccountID']) + ' ');
                Add('WHERE tblSales.IsInvoice="T" AND tblSales.IsSalesOrder="F" AND tblSales.IsQuote="F" AND tblSales.Deleted="F" ');
                Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
                Add('AND tblSalesLines.Invoiced="T" AND (PARTTYPE = "INV")');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                  Add(';');
                  (*Add(' limit 1 union all');*)
                end;
              end;


  end;

end;

procedure TTransactionTableObj.TrnsTable26(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*26*/ SELECT 26, tblSales.SaleDate as "Date", ');
              Add('"Cash Sale" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00) as "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00) as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = tblSalesLines.ASSETACCNTID  ');
              Add('WHERE (PARTTYPE = "INV"  ) AND (tblSales.IsCashSale="T") AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add(' AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;


              {COGS Adjustment}
              if AppEnvVirt.Bool['CompanyPrefs.UseInventoryStandardCosting'] and
                (AppEnvVirt.INT['CompanyPrefs.StandardCostCOGSAdjustmentAccountID'] > 0) then begin
                Add('/*26*/ SELECT 26.2, tblSales.SaleDate as "Date", ');
                Add('"Cash Sale" as Type, ');
                Add('tblSales.GlobalRef as "Global #", ');
                Add('tblSales.ClassID, ');
                Add(Idcolumn('tblSales.SaleID','','','',''));
                Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
                Add(COAColumns+',');
                Add('CustomerName as ClientName, ');
                Add('ClientID as ClientID, ');
                Add('0 as CustomerJobId, ');
                Add('Product_Description  as ProductDesc, ');
                Add('ProductName  as ProductName, ');
                Add('ProductGroup  as ProductGroup, ');
                Add('EmployeeName  as RepName, ');
                Add('EmployeeID  as EmployeeID, ');
                Add('"F" as Reconciled, ');
                Add('SUBSTRING(Comments,1,255) as Notes, ');
                Add('""  as TaxCode, ');
                Add('0.00  as TaxRate, ');
                Add('0  as TaxID, ');
//                Add('0.00 as "DebitsEx", ');
//                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00) as "CreditsEx", ');
//                Add('0.00 as "DebitsInc", ');
//                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00) as "CreditsInc",');
//                Add('0.00  as CASH_DebitsEx, ');
//                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00)  as CASH_CreditsEx, ');
//                Add('0.00  as CASH_DebitsInc, ');
//                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00)  as CASH_CreditsInc  ,  ');
                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00) as "DebitsEx", ');
                Add('0.00 as "CreditsEx", ');

                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00) as "DebitsInc",');
                Add('0.00 as "CreditsInc", ');

                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00)  as CASH_DebitsEx, ');
                Add('0.00  as CASH_CreditsEx, ');

                Add('If((tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped<>0.00 ,(tblSalesLines.StandardCost-tblSalesLines.LineCost)*tblSalesLines.Shipped,0.00)  as CASH_DebitsInc  ,  ');
                Add('0.00  as CASH_CreditsInc, ');

                Add('""  as `Chq/Ref` ');
                Add('FROM tblSales ');
                Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
                Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = ' + IntToStr(AppEnvVirt.INT['CompanyPrefs.StandardCostCOGSAdjustmentAccountID']) + ' ');
                Add('WHERE (PARTTYPE = "INV"  ) AND (tblSales.IsCashSale="T") AND tblSalesLines.Invoiced="T" ');
                Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
                Add(' AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                  Add(';');
                  (*Add(' limit 1 union all');*)
                end;
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable27(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*27*/ SELECT 27, tblSales.SaleDate as "Date", ');
              Add('"Refund" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,-tblSalesLines.LineCost*tblSalesLines.Shipped,0.00) as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,-tblSalesLines.LineCost*tblSalesLines.Shipped,0.00) as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,-tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,-tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = tblSalesLines.ASSETACCNTID  ');
              Add('WHERE (PARTTYPE = "INV"  ) AND (tblSales.IsRefund ="T") AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add(' AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;


  end;
end;

procedure TTransactionTableObj.TrnsTable28(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*28*/ SELECT 28, tblSales.SaleDate as "Date", ');
              Add('"Invoice" asType, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00) as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00) as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales  ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = tblSalesLines.COGSACCNTID  ');
              Add('WHERE tblSales.IsInvoice="T" AND tblSales.IsSalesOrder="F" AND tblSales.IsQuote="F" AND tblSales.Deleted="F" ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.Invoiced="T" AND (PARTTYPE = "INV")');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;


  end;
end;

procedure TTransactionTableObj.TrnsTable29(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*29*/ SELECT 29, tblSales.SaleDate as "Date", ');
              Add('"Cash Sale" asType, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblSalesLines.LineCost*tblSalesLines.Shipped as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('tblSalesLines.LineCost*tblSalesLines.Shipped as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('tblSalesLines.LineCost*tblSalesLines.Shipped  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('tblSalesLines.LineCost*tblSalesLines.Shipped  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales   ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblSalesLines.COGSACCNTID ');
              Add('WHERE (PARTTYPE = "INV"  ) AND (tblSales.IsCashSale="T") AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add(' AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;



  end;
end;

procedure TTransactionTableObj.TrnsTable30(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*30*/ SELECT 30, tblSales.SaleDate as "Date", ');
              Add('"Refund" asType, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('-tblSalesLines.LineCost*tblSalesLines.Shipped as "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('-tblSalesLines.LineCost*tblSalesLines.Shipped as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('-tblSalesLines.LineCost*tblSalesLines.Shipped  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('-tblSalesLines.LineCost*tblSalesLines.Shipped  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales   ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = tblSalesLines.COGSACCNTID ');
              Add('WHERE (PARTTYPE = "INV"  ) AND (tblSales.IsRefund ="T") AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add(' AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;


  end;
end;

procedure TTransactionTableObj.TrnsTable31(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*31*/ SELECT 31,tblwithdrawal.PaymentDate as "Date", ');
              Add('"Supplier Payment" AS Type, ');
              Add('tblwithdrawal.GlobalRef  as "Global #", ');
              Add('tblwithdrawal.ClassID, ');
              Add(Idcolumn('','If(tblwithdrawallines.TrnType="Prepayment",0,tblwithdrawallines.POID)','tblwithdrawal.PaymentID','If(tblwithdrawallines.TrnType="Prepayment",tblwithdrawallines.PrePaymentID,0)',''));
              Add(LineIdcolumn('','','tblwithdrawallines.PaymentLineID',''));
              Add(COAColumns+',');
              Add('tblwithdrawal.CompanyName as ClientName, ');
              Add('SupplierID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductName, ');
              Add('CONCAT_WS(" ", FirstName, LastName)  as RepName, ');
              Add('tblwithdrawal.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('-tblwithdrawallines.Payment as "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('-tblwithdrawallines.Payment as "CreditsInc", ');
              Add('0.00  as CASH_DebitsEx, ');
              Add('-tblwithdrawallines.Payment  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('-tblwithdrawallines.Payment  as CASH_CreditsInc  ,  ');
              Add('tblwithdrawal.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tblwithdrawal ');
              Add('INNER JOIN tblwithdrawallines ON tblwithdrawallines.PaymentID =tblwithdrawal.PaymentID  ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=' + IntToStr(AppEnvVirt.Int['DNMLib.GetSupplierPrepaymentAccountID']) + ' ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tblwithdrawal.EmployeeID ');
              Add('WHERE tblwithdrawal.Deleted = "F" AND TrnType = "Prepayment" ');
              Add(' AND tblwithdrawal.PaymentDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable32(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*32*/ SELECT 32, tblwithdrawal.PaymentDate as "Date", ');
              Add('"Supplier Payment" AS Type, ');
              Add('tblwithdrawal.GlobalRef  as "Global #", ');
              Add('tblwithdrawal.ClassID, ');
              Add(Idcolumn('','','tblwithdrawal.PaymentID','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('tblwithdrawal.CompanyName as ClientName, ');
              Add('SupplierID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductName, ');
              Add('EmployeeName as RepName, ');
              Add('tblwithdrawal.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('tblwithdrawal.Amount as "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('tblwithdrawal.Amount as "CreditsInc", ');
              Add('0.00  as CASH_DebitsEx, ');
              Add('tblwithdrawal.Amount as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('tblwithdrawal.Amount as CASH_CreditsInc  ,  ');
              Add('tblwithdrawal.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tblwithdrawal ');
              Add('INNER JOIN tblwithdrawallines ON tblwithdrawallines.PaymentID =tblwithdrawal.PaymentID  ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblwithdrawal.AccountID ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tblwithdrawal.EmployeeID ');
              Add('WHERE tblwithdrawal.Deleted = "F" AND tblwithdrawal.Amount<>0.00 ');
              Add(' AND tblwithdrawal.PaymentDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('GROUP BY tblwithdrawal.PaymentID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable33(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*33*/ SELECT 33, tblwithdrawal.PaymentDate as "Date", ');
              Add('"Supplier Payment" AS Type, ');
              Add('tblwithdrawal.GlobalRef  as "Global #", ');
              Add('tblwithdrawal.ClassID, ');
              Add(Idcolumn('','If(tblwithdrawallines.TrnType="Prepayment",0,tblwithdrawallines.POID)','tblwithdrawal.PaymentID','If(tblwithdrawallines.TrnType="Prepayment",tblwithdrawallines.PrePaymentID,0)',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('tblwithdrawal.CompanyName as ClientName, ');
              Add('SupplierID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductName, ');
              Add('EmployeeName as RepName, ');
              Add('tblwithdrawal.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblwithdrawal.ForeignVariationAmount as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('tblwithdrawal.ForeignVariationAmount as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('tblwithdrawal.ForeignVariationAmount as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('tblwithdrawal.ForeignVariationAmount as   CASH_DebitsInc,  ');
              Add('0.00  as CASH_CreditsInc, ');
              Add('tblwithdrawal.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tblwithdrawal ');
              Add('INNER JOIN tblwithdrawallines ON tblwithdrawallines.PaymentID =tblwithdrawal.PaymentID  ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblwithdrawal.ForeignVariationAccountID ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tblwithdrawal.EmployeeID ');
              Add('WHERE tblwithdrawal.Deleted = "F" AND tblwithdrawal.ForeignVariationAmount<>0.00 ');
              Add(' AND tblwithdrawal.PaymentDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('GROUP BY tblwithdrawal.PaymentID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable34(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*34*/ SELECT 34, tblwithdrawal.PaymentDate as "Date", ');
              Add('"Supplier Payment" AS Type, ');
              Add('tblwithdrawal.GlobalRef  as "Global #", ');
              Add('tblwithdrawal.ClassID, ');
              Add(Idcolumn('','If(tblwithdrawallines.TrnType="Prepayment",0,tblwithdrawallines.POID) ','tblwithdrawal.PaymentID' ,'If(tblwithdrawallines.TrnType="Prepayment",tblwithdrawallines.PrePaymentID,0)',''));
              Add(LineIdcolumn('','','tblwithdrawallines.PaymentLineID',''));

              Add(COAColumns+',');
              Add('CompanyName as ClientName, ');
              Add('SupplierID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('CONCAT_WS(" ", FirstName, LastName)  as RepName, ');
              Add('tblwithdrawal.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblwithdrawallines.Payment as "DebitsEx", ');
              Add('0.00 as "CreditsEx",  ');
              Add('tblwithdrawallines.Payment as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('tblwithdrawallines.Payment  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('tblwithdrawallines.Payment  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('tblwithdrawal.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tblwithdrawal ');
              Add('INNER JOIN tblwithdrawallines ON tblwithdrawallines.PaymentID = tblwithdrawal.PaymentID  ');
              Add('INNER JOIN tblpurchaseorders ON  tblpurchaseorders.PurchaseOrderID = tblwithdrawallines.POID  ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountName=tblpurchaseorders.Account ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tblwithdrawal.EmployeeID ');
              Add('WHERE tblwithdrawal.Deleted = "F" ');
              Add(' AND tblwithdrawal.PaymentDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable35(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*35*/ SELECT 35, tblPurchaseOrders.OrderDate as "Date", ');
              Add('"Cheque" AS Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(tblPurchaseLines.Product_Description,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('tblPurchaseLines.TotalLineAmountInc as "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('tblPurchaseLines.TotalLineAmountInc as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('tblPurchaseLines.TotalLineAmount  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('tblPurchaseLines.TotalLineAmountInc  as CASH_CreditsInc  ,  ');
              Add('InvoiceNumber  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders  ');
              Add('INNER JOIN tblPurchaseLines ON  tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON  tblPurchaseOrders.AccountID = tblchartofaccounts.AccountID ');
              Add('WHERE IsCheque="T" AND tblPurchaseOrders.Deleted="F"   ');
              Add(' AND tblPurchaseOrders.OrderDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable36(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*36*/ SELECT 36, tblPurchaseOrders.OrderDate as "Date", ');
              Add('"Cheque" AS Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(tblPurchaseLines.Product_Description,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblPurchaseLines.TotalLineAmount as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('tblPurchaseLines.TotalLineAmountInc as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('tblPurchaseLines.TotalLineAmount  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('tblPurchaseLines.TotalLineAmountInc  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('InvoiceNumber  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders ');
              Add('INNER JOIN tblPurchaseLines ON  tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON  tblPurchaseLines.AccountName = tblchartofaccounts.AccountName  ');
              Add('WHERE IsCheque="T" AND tblPurchaseOrders.Deleted="F"  ');
              Add(' AND tblPurchaseOrders.OrderDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable37(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*37*/ SELECT 37, tblbankdeposit.DepositDate as "Date", ');
              Add('if (TrnsType="Deposit Entry","Deposit Entry","Bank Deposit") AS Type, ');
              Add('tblbankdeposit.GlobalRef  as "Global #", ');
              Add('tblbankdepositlines.ClassID as ClassID, ');
              Add(Idcolumn('','','tblbankdeposit.DepositID','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('CompanyName as ClientName, ');
              Add('CusID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('CONCAT_WS(" ", FirstName, LastName)  as RepName, ');
              Add('tblbankdeposit.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('tblbankdeposit.Notes as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('Deposit as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('Deposit as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('Deposit  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('Deposit  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblbankdeposit  ');
              Add('INNER JOIN tblbankdepositlines ON tblbankdepositlines.DepositID = tblbankdeposit.DepositID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblbankdeposit.AccountID ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tblbankdeposit.EmployeeID ');
              Add('Where (tblbankdepositlines.TrnsType = "Customer Payment" OR tblbankdepositlines.TrnsType = "Deposit Entry" OR ');
              Add('tblbankdepositlines.TrnsType = "Cash Sale" OR tblbankdepositlines.TrnsType = "Refund" OR tblbankdepositlines.TrnsType = "Prepayment" OR tblbankdepositlines.TrnsType = "POS Cash Sale") ');
              Add('And tblbankdepositlines.FromDeposited ="T" ');
              Add('And tblbankdeposit.Deleted <>"T" ');
              Add(' AND tblbankdeposit.DepositDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('GROUP BY tblbankdeposit.DepositID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable38(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*38*/ SELECT 38, tblbankdeposit.DepositDate as "Date", ');
              Add('if (TrnsType="Deposit Entry","Deposit Entry","Bank Deposit") AS Type, ');
              Add('tblbankdeposit.GlobalRef  as "Global #", ');
              Add('tblbankdepositlines.ClassID as ClassID, ');
              Add(Idcolumn('','','tblbankdeposit.DepositID','',''));
              Add(LineIdcolumn('','','tblbankdepositlines.DepositLineID',''));
              Add(COAColumns+',');
              Add('tblbankdepositlines.CompanyName as ClientName, ');
              Add('tblbankdepositlines.CusID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('CONCAT_WS(" ", FirstName, LastName)  as RepName, ');
              Add('tblbankdeposit.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('tblbankdeposit.Notes as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('tblbankdepositlines.Amount as "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('tblbankdepositlines.Amount as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('tblbankdepositlines.Amount  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('tblbankdepositlines.Amount  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblbankdeposit  ');
              Add('INNER JOIN tblbankdepositlines ON tblbankdepositlines.DepositID = tblbankdeposit.DepositID ');
              Add('LEFT JOIN tbldeposits ON tblbankdepositlines.PaymentID =tbldeposits.PaymentID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblbankdepositlines.AccountID  ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tblbankdeposit.EmployeeID ');
              Add('Where (tblbankdepositlines.TrnsType = "Customer Payment" OR tblbankdepositlines.TrnsType = "Deposit Entry" OR ');
              Add('tblbankdepositlines.TrnsType = "Cash Sale" OR tblbankdepositlines.TrnsType = "Refund" OR tblbankdepositlines.TrnsType = "Prepayment" OR tblbankdepositlines.TrnsType = "POS Cash Sale") ');
              Add('And tblbankdepositlines.FromDeposited ="T" ');
              Add('And tblbankdeposit.Deleted <>"T" ');
              Add('AND tblbankdeposit.DepositDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable39(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              {TransferFrom-Asset Account --> Credit}
              Add('/*39*/ SELECT 39, SM.MovementDate as "Date", ');
              Add('"Stock Transfer" as Type, ');
              Add('ST.GlobalRef as "Global #", ');
              Add('SML.ClassId, ');
              Add(Idcolumn('ST.TransferEntryID','SM.StockmovementID','','',''));
              Add(LineIdcolumn('SML.StockmovementLinesID','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('tblParts.PARTSDESCRIPTION  as ProductDesc, ');
              Add('SML.ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('SM.Employee  as RepName, ');
              Add('SM.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(SM.Notes,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as DebitsEx, ');
              Add('(ifnull(abs(SML.Qty*cost),0)) as CreditsEx, ');
              Add('0.00 as DebitsInc, ');
              Add('(ifnull(abs(SML.Qty)*Cost,0)) as CreditsInc, ');
              Add('0.00  as CASH_DebitsEx, ');
              Add('(ifnull(abs(SML.Qty)*Cost,0))  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('(ifnull(abs(SML.Qty)*cost,0))  as CASH_CreditsInc  , ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblStockMovementLines as SML ');
              Add('INNER JOIN tblstockmovement as SM on SM.stockmovementID = SML.stockmovementID and SM.StockmovementEntryType = "StockTransferEntry" ');
              Add('INNER join tblPQA pqa on pqa.transId = SML.StockmovementID and PQA.translineId = SML.StockmovementLinesID and PQA.transtype = "TStockMovementLines" and if(Alloctype="OUT", 0-PQA.Qty, PQA.QTY)<0');
              Add('INNER JOIN tblstocktransferentry ST on SM.StockMovementEntryglobalref = ST.Globalref');
              Add('INNER JOIN tblParts On tblParts.PartsID = SML.ProductID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = SML.AssetAccountID ');
              Add('WHERE SM.Deleted<>"T" AND SM.MovementDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              //Add('GROUP BY SM.StockMovementID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;


  end;
end;

procedure TTransactionTableObj.TrnsTable40(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              {Transferto-Asset Account --> debit}
              Add('/*40*/ SELECT 40, SM.MovementDate as "Date", ');
              Add('"Stock Transfer" as Type, ');
              Add('ST.GlobalRef as "Global #", ');
              Add('SML.ClassId, ');
              Add(Idcolumn('ST.TransferEntryID','SM.StockmovementID','','',''));
              Add(LineIdcolumn('SML.StockmovementLinesID','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('tblParts.PARTSDESCRIPTION  as ProductDesc, ');
              Add('SML.ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('SM.Employee  as RepName, ');
              Add('SM.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(SM.Notes,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('(ifnull(abs(SML.Qty*cost),0))  as DebitsEx, ');
              Add('0.00             as CreditsEx, ');
              Add('(ifnull(abs(SML.Qty*cost),0))  as DebitsInc, ');
              Add('0.00             as CreditsInc, ');
              Add('(ifnull(abs(SML.Qty*cost),0))  as CASH_DebitsEx, ');
              Add('0.00             as CASH_CreditsEx, ');
              Add('(ifnull(abs(SML.Qty*cost),0))  as CASH_DebitsInc, ');
              Add('0.00             as CASH_CreditsInc  , ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblStockMovementLines as SML ');
              Add('INNER JOIN tblstockmovement as SM on SM.stockmovementID = SML.stockmovementID and SM.StockmovementEntryType = "StockTransferEntry" ');
              Add('INNER join tblPQA pqa on pqa.transId = SML.StockmovementID and PQA.translineId = SML.StockmovementLinesID and PQA.transtype = "TStockMovementLines" and if(Alloctype="OUT", 0-PQA.Qty, PQA.QTY)>0');
              Add('INNER JOIN tblstocktransferentry ST on SM.StockMovementEntryglobalref = ST.Globalref');
              Add('INNER JOIN tblParts On tblParts.PartsID = SML.ProductID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = SML.AssetAccountID ');
              Add('WHERE SM.Deleted<>"T" AND SM.MovementDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              //Add('GROUP BY SM.StockMovementID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;


  end;
end;

procedure TTransactionTableObj.TrnsTable41(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*41*/ SELECT 41, tblSales.SaleDate as "Date", ');
              Add('"Invoice" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "CreditsEx", ');
              Add('tblSalesLines.LineTax as "DebitsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('tblSalesLines.LineTax  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales  ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID =tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['TcConst.GLACCOUNT_TAX_COLLECTED']))+' ');
              Add('WHERE tblSales.IsInvoice="T" AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSalesLines.LineTaxCode<>"WC"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable42(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*42*/ SELECT 42, tblSales.SaleDate as "Date", ');
              Add('"Invoice" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('Name  as TaxCode, ');
              Add('Rate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "CreditsEx", ');
              Add('(Shipped * LinePrice) * Rate as "DebitsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('(Shipped * LinePrice) * Rate as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc, ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales  ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID =  tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['TcConst.GLACCOUNT_TAX_COLLECTED']))+' ');
              Add('INNER JOIN tbltaxcodes ON  tbltaxcodes.TaxCodeID = '+ IntToStr(GetGLTaxCodeIDForName(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_WEG']))+' ');
              Add('WHERE (tblSales.IsInvoice="T") AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F" ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.LineTaxCode="WC"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable43(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*43*/ SELECT 43, tblSales.SaleDate as "Date", ');
              Add('"Invoice" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('Name  as TaxCode, ');
              Add('Rate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "CreditsEx", ');
              Add('(Shipped * LinePrice) * Rate as "DebitsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('(Shipped * LinePrice) * Rate as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc, ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_WET']))+' ');
              Add('INNER JOIN tbltaxcodes ON  tbltaxcodes.TaxCodeID = '+ IntToStr(GetGLTaxCodeIDForName(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_WET']))+' ');
              Add('WHERE (tblSales.IsInvoice="T") AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F" ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.LineTaxCode="WC"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable44(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*44*/ SELECT 44, tblSales.SaleDate as "Date", ');
              Add('"Cash Sale" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "CreditsEx", ');
              Add('tblSalesLines.LineTax as "DebitsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('tblSalesLines.LineTax  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['TcConst.GLACCOUNT_TAX_COLLECTED']))+' ');
              Add('WHERE (tblSales.IsCashSale="T") AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add(' AND tblSalesLines.LineTaxCode<>"WC"  ');
              Add(' AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable45(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*45*/ SELECT 45, tblSales.SaleDate as "Date", ');
              Add('"Invoice" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('Name  as TaxCode, ');
              Add('Rate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "CreditsEx", ');
              Add('(Shipped * LinePrice) * Rate as "DebitsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('(Shipped * LinePrice) * Rate as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc, ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['TcConst.GLACCOUNT_TAX_COLLECTED']))+' ');
              Add('INNER JOIN tbltaxcodes ON  tbltaxcodes.TaxCodeID = '+ IntToStr(GetGLTaxCodeIDForName(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_WEG']))+' ');
              Add('WHERE (tblSales.IsCashSale="T") AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.LineTaxCode="WC"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable46(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*46*/ SELECT 46, tblSales.SaleDate as "Date", ');
              Add('"Invoice" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('Name  as TaxCode, ');
              Add('Rate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "CreditsEx", ');
              Add('(Shipped * LinePrice) * Rate as "DebitsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('(Shipped * LinePrice) * Rate as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc, ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_WET']))+' ');
              Add('INNER JOIN tbltaxcodes ON  tbltaxcodes.TaxCodeID = '+ IntToStr(GetGLTaxCodeIDForName(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_WET']))+' ');
              Add('WHERE (tblSales.IsCashSale="T") AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.LineTaxCode="WC"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');

                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable47(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*47*/ SELECT 47, tblSales.SaleDate as "Date", ');
              Add('"Refund" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('-tblSalesLines.LineTax as "CreditsEx", ');
              Add('0.00 as "DebitsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('-tblSalesLines.LineTax  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales   ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['TcConst.GLACCOUNT_TAX_COLLECTED']))+' ');
              Add('WHERE tblSales.IsRefund ="T" AND tblSales.IsInvoice="F" AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add(' AND tblSalesLines.LineTaxCode<>"WC"  ');
              Add(' AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable48(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*48*/ SELECT 48, tblSales.SaleDate as "Date", ');
              Add('"Invoice" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('Name  as TaxCode, ');
              Add('Rate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "CreditsEx", ');
              Add('(Shipped * LinePrice) * Rate as "DebitsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('(Shipped * LinePrice) * Rate as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc, ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['TcConst.GLACCOUNT_TAX_COLLECTED']))+' ');
              Add('INNER JOIN tbltaxcodes ON  tbltaxcodes.TaxCodeID = '+ IntToStr(GetGLTaxCodeIDForName(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_WEG']))+' ');
              Add('WHERE tblSales.IsRefund ="T" AND tblSales.IsInvoice="F" AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.LineTaxCode="WC"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable49(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*49*/ SELECT 49, tblSales.SaleDate as "Date", ');
              Add('"Invoice" as Type, ');
              Add('tblSales.GlobalRef as "Global #", ');
              Add('tblSales.ClassID, ');
              Add(Idcolumn('tblSales.SaleID','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','','',''));
              Add(COAColumns+',');
              Add('CustomerName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('EmployeeName  as RepName, ');
              Add('EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('Name  as TaxCode, ');
              Add('Rate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "CreditsEx", ');
              Add('(Shipped * LinePrice) * Rate as "DebitsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('(Shipped * LinePrice) * Rate as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc, ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblSales ');
              Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_WET']))+' ');
              Add('INNER JOIN tbltaxcodes ON  tbltaxcodes.TaxCodeID = '+ IntToStr(GetGLTaxCodeIDForName(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_WET']))+' ');
              Add('WHERE tblSales.IsRefund ="T" AND tblSales.IsInvoice="F" AND tblSalesLines.Invoiced="T" ');
              Add('AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F"  ');
              Add('AND tblSales.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('AND tblSalesLines.LineTaxCode="WC"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');

                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable50(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*50*/ SELECT 50, tblPurchaseOrders.OrderDate as "Date", ');
              Add('"Bill" AS Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblPurchaseLines.LineTax as "DebitsEx", ');
              Add('0.00 as  "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('tblPurchaseLines.LineTax  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders ');
              Add('INNER JOIN tblPurchaseLines ON  tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_PAID']))+' ');
              Add('WHERE tblPurchaseLines.Invoiced="T" And (IsBill="T") AND tblPurchaseOrders.Deleted="F"  ');
              Add(' AND tblPurchaseOrders.OrderDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat,SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable51(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*51*/ SELECT 51, tblPurchaseOrders.OrderDate as "Date", ');
              Add('"Cheque" AS Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(tblPurchaseLines.Product_Description,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblPurchaseLines.LineTax as "DebitsEx", ');
              Add('0.00 as  "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('tblPurchaseLines.LineTax  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders ');
              Add('INNER JOIN tblPurchaseLines ON  tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_PAID']))+' ');
              Add('WHERE tblPurchaseLines.Invoiced="T" And (IsCheque="T") AND tblPurchaseOrders.Deleted="F"  ');
              Add(' AND tblPurchaseOrders.OrderDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat,SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable52(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*52*/ SELECT 52, tblPurchaseOrders.InvoiceDate as "Date", ');
              Add('"PO" as Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('Product_Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblPurchaseLines.Linetax as "DebitsEx", ');
              Add('0.00 as "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('tblPurchaseLines.Linetax  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders ');
              Add('INNER JOIN tblPurchaseLines ON  tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_PAID']))+' ');
              Add('WHERE tblPurchaseLines.Invoiced="T" And (tblPurchaseOrders.IsPO="T") AND tblPurchaseOrders.Deleted="F"  ');
              Add('AND If((IsPO="T"),char_length(tblPurchaseOrders.InvoiceNumber),1)>0  ');
              Add(' AND tblPurchaseOrders.InvoiceDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;


procedure TTransactionTableObj.TrnsTable53(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*53*/ SELECT 53,tblPurchaseOrders.OrderDate as "Date", ');
              Add('"Credit" as Type, ');
              Add('tblPurchaseOrders.GlobalRef as "Global #", ');
              Add('tblPurchaseLines.ClassID, ');
              Add(Idcolumn('','tblPurchaseOrders.PurchaseOrderID','','',''));
              Add(LineIdcolumn('','tblPurchaseLines.PurchaselineID','',''));
              Add(COAColumns+',');
              Add('SupplierName as ClientName, ');
              Add('ClientID as ClientID, ');
              Add('tblpurchaselines.CustomerJobID as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblPurchaseOrders.EmployeeName  as RepName, ');
              Add('tblPurchaseOrders.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(Comments,1,255) as Notes, ');
              Add('LineTaxCode  as TaxCode, ');
              Add('LineTaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0  as "DebitsEx", ');
              Add('tblPurchaseLines.Linetax as "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc",');
              Add('0.00  as CASH_DebitsEx, ');
              Add('tblPurchaseLines.Linetax  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblPurchaseOrders ');
              Add('INNER JOIN tblPurchaseLines   ON  tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_PAID']))+' ');
              Add('WHERE tblPurchaseLines.Invoiced="T" And (tblPurchaseOrders.IsCredit="T") AND tblPurchaseOrders.Deleted="F"  ');
              Add(' AND tblPurchaseOrders.OrderDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;
procedure TTransactionTableObj.TrnsTable54(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*54*/ SELECT 54, SM.MovementDate as "Date",  ');
              Add('"Stock Adjustment" as Type,  ');
              Add('SA.Globalref as "Global #", ');
              Add('SML.ClassID, ');
              Add(Idcolumn('SA.StockAdjustEntryID','SM.StockmovementID','','',''));
              Add(LineIdcolumn('SML.StockmovementLinesID','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('SML.Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('""  as RepName, ');
              Add('0  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(SM.Notes,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx",  ');
              Add('Value as  "CreditsEx",  ');
              Add('0.00 as "DebitsInc",  ');
              Add('Value as "CreditsInc", ');
              Add('0.00  as CASH_DebitsEx, ');
              Add('Value  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('Value as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblstockmovementlines  as SML ');
              Add('INNER JOIN tblstockmovement as SM on SM.stockmovementID = SML.stockmovementID and SM.StockmovementEntryType = "StockAdjustEntry"');
              Add('INNER JOIN tblstockadjustentry SA on SM.StockMovementEntryglobalref = SA.Globalref');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = SML.AccountID  ');
              Add('Where SM.Deleted<>"T" AND Value <>0.00  ');
              Add(' AND SM.MovementDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;



  end;
end;

procedure TTransactionTableObj.TrnsTable55(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*55*/ SELECT 55, SM.MovementDate as "Date",  ');
              Add('"Stock Adjustment" as Type,  ');
              Add('SA.Globalref as "Global #", ');
              Add('SML.ClassID, ');
              Add(Idcolumn('SA.StockAdjustEntryID','SM.StockmovementID','','',''));
              Add(LineIdcolumn('SML.StockmovementLinesID','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('SML.Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('""  as RepName, ');
              Add('0  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(SM.Notes,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('Value as "DebitsEx",  ');
              Add('0.00 as  "CreditsEx",  ');
              Add('Value as "DebitsInc",  ');
              Add('0.00 as "CreditsInc", ');
              Add('Value  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('Value  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblstockmovementlines  as SML ');
              Add('INNER JOIN tblstockmovement as SM on SM.stockmovementID = SML.stockmovementID and SM.StockmovementEntryType = "StockAdjustEntry"');
              Add('INNER JOIN tblstockadjustentry SA on SM.StockMovementEntryglobalref = SA.Globalref');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = SML.AssetAccountID  ');
              Add('Where SM.Deleted<>"T" AND Value <>0.00  ');
              Add(' AND SM.MovementDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable56(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*56*/ SELECT 56, TransactionDate as "Date", ');
              Add('"Journal Entry" as Type, ');
              Add('tblgeneraljournal.GlobalRef  as "Global #", ');
              Add('tblgeneraljournaldetails.ClassID, ');
              Add(Idcolumn('tblgeneraljournal.GJID','','','','IF(tblgeneraljournal.TaxSelect="OUTPUT",99,98)'));
              Add(LineIdcolumn('tblgeneraljournaldetails.GJDID','','',''));
              Add(COAColumns+',');
              Add('tblgeneraljournaldetails.ClientName as ClientName, ');
              Add('tblgeneraljournaldetails.ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('""  as RepName, ');
              Add('0  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('tblgeneraljournaldetails.Memo  as Notes, ');
              Add('tblgeneraljournaldetails.TaxCode  as TaxCode, ');
              Add('tblgeneraljournaldetails.TaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('If(DebitAmount<>0.00,(DebitAmount),0.00) as "DebitsEx", ');
              Add('If(CreditAmount<>0.00,(CreditAmount),0.00) as  "CreditsEx", ');
              Add('If(DebitAmount<>0.00,(DebitAmount + TaxAmount),0.00) as "DebitsInc", ');
              Add('If(CreditAmount<>0.00,(CreditAmount + TaxAmount),0.00) as "CreditsInc",');
              Add('If(DebitAmount<>0.00,(DebitAmount),0.00) as "CASH_DebitsEx", ');
              Add('If(CreditAmount<>0.00,(CreditAmount),0.00) as  "CASH_CreditsEx", ');
              Add('If(DebitAmount<>0.00,(DebitAmount + TaxAmount),0.00) as "CASH_DebitsInc", ');
              Add('If(CreditAmount<>0.00,(CreditAmount + TaxAmount),0.00) as "CASH_CreditsInc",  ');
              Add('TransactionNo  as `Chq/Ref` ');
              Add('FROM tblgeneraljournaldetails ');
              Add('INNER JOIN tblgeneraljournal ON tblgeneraljournal.GJID = tblgeneraljournaldetails.GJID ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = tblgeneraljournaldetails.AccountID ');
              Add(' AND TransactionDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable57(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*57*/ SELECT 57, TransactionDate as "Date", ');
              Add('"Journal Entry" as Type, ');
              Add('tblgeneraljournal.GlobalRef  as "Global #", ');
              Add('tblgeneraljournaldetails.ClassID, ');
              Add(Idcolumn('tblgeneraljournal.GJID','','','','IF(tblgeneraljournal.TaxSelect="OUTPUT",99,98)'));
              Add(LineIdcolumn('tblgeneraljournaldetails.GJDID','','',''));
              Add(COAColumns+',');
              Add('tblgeneraljournaldetails.ClientName as ClientName, ');
              Add('tblgeneraljournaldetails.ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('""  as RepName, ');
              Add('0  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('tblgeneraljournaldetails.Memo  as Notes, ');
              Add('tblgeneraljournaldetails.TaxCode  as TaxCode, ');
              Add('tblgeneraljournaldetails.TaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('If(DebitAmount<>0.00,(TaxAmount),0.00) as "DebitsEx", ');
              Add('If(CreditAmount<>0.00,(TaxAmount),0.00) as  "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('If(DebitAmount<>0.00,(TaxAmount),0.00) as "CASH_DebitsEx", ');
              Add('If(CreditAmount<>0.00,(TaxAmount),0.00) as  "CASH_CreditsEx", ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('TransactionNo  as `Chq/Ref` ');
              Add('FROM tblgeneraljournaldetails  ');
              Add('INNER JOIN tblgeneraljournal ON tblgeneraljournal.GJID = tblgeneraljournaldetails.GJID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['tcConst.GLACCOUNT_TAX_PAID']))+' ');
              Add('WHERE TaxSelect = "INPUT" AND TaxAmount<>0  AND Not IsNull(TaxAmount) ');
              Add(' AND TransactionDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable58(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*58*/ SELECT 58, TransactionDate as "Date", ');
              Add('"Journal Entry" as Type, ');
              Add('tblgeneraljournal.GlobalRef  as "Global #", ');
              Add('tblgeneraljournaldetails.ClassID, ');
              Add(Idcolumn('tblgeneraljournal.GJID','','','','IF(tblgeneraljournal.TaxSelect="OUTPUT",99,98)'));
              Add(LineIdcolumn('tblgeneraljournaldetails.GJDID','','',''));
              Add(COAColumns+',');
              Add('tblgeneraljournaldetails.ClientName as ClientName, ');
              Add('tblgeneraljournaldetails.ClientID as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('""  as RepName, ');
              Add('0  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('tblgeneraljournaldetails.Memo  as Notes, ');
              Add('tblgeneraljournaldetails.TaxCode  as TaxCode, ');
              Add('tblgeneraljournaldetails.TaxRate  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('If(DebitAmount<>0.00 ,(TaxAmount),0.00) as "DebitsEx", ');
              Add('If(CreditAmount<>0.00 ,(TaxAmount),0.00) as  "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('If(DebitAmount<>0.00 ,(TaxAmount),0.00)  as CASH_DebitsEx, ');
              Add('If(CreditAmount<>0.00 ,(TaxAmount),0.00)  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc ,  ');
              Add('TransactionNo  as `Chq/Ref` ');
              Add('FROM tblgeneraljournaldetails  ');
              Add('INNER JOIN tblgeneraljournal ON tblgeneraljournal.GJID = tblgeneraljournaldetails.GJID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = '+ IntToStr(getAccountID(AppEnvVirt.Str['TcConst.GLACCOUNT_TAX_COLLECTED']))+' ');
              Add('WHERE TaxSelect = "OUTPUT" AND TaxAmount<>0 AND Not IsNull(TaxAmount)  ');
              Add(' AND TransactionDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable59(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              { 29/11/13 Changed to use PayDte }
//              Add('/*59*/ SELECT 59, tblPays.PayDate as Date, ');
              { IJB 2/4/19 changed to DatePaid to match ATO requirements }
              Add('/*59.1*/ SELECT 59.1, tblPays.DatePaid as Date, ');
              Add('Type, ');
              Add('tblpays.GlobalRef  as "Global #", ');
              Add('tblpaystransactions.ClassID, ');
              Add(Idcolumn('tblpaystransactions.PayID','','','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('tblpaystransactions.ClientName, ');
              Add('tblpaystransactions.ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('tblpaystransactions.Description as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblpaystransactions.EmployeeName as RepName, ');
              Add('tblpaystransactions.EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('If(tblpaystransactions.Amount<0 ,-tblpaystransactions.Amount,0.00)+0.00 as "DebitsEx", ');
              Add('If(tblpaystransactions.Amount>0 ,tblpaystransactions.Amount,0.00)+0.00 as  "CreditsEx", ');
              Add('If(tblpaystransactions.Amount<0 ,-tblpaystransactions.Amount,0.00)+0.00 as "DebitsInc", ');
              Add('If(tblpaystransactions.Amount>0 ,tblpaystransactions.Amount,0.00)+0.00 as "CreditsInc", ');
              Add('If(tblpaystransactions.Amount<0 ,-tblpaystransactions.Amount,0.00)+0.00 as "CASH_DebitsEx", ');
              Add('If(tblpaystransactions.Amount>0 ,tblpaystransactions.Amount,0.00)+0.00 as  "CASH_CreditsEx", ');
              Add('If(tblpaystransactions.Amount<0 ,-tblpaystransactions.Amount,0.00)+0.00 as "CASH_DebitsInc", ');
              Add('If(tblpaystransactions.Amount>0 ,tblpaystransactions.Amount,0.00)+0.00 as "CASH_CreditsInc" , ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblpaystransactions ');
              Add('INNER JOIN tblpays USING(PayID)');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = tblpaystransactions.AccountID ');
              { IJB 2/4/19 changed to DatePaid to match ATO requirements }
//              Add('WHERE tblPays.PayDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('WHERE tblPays.DatePaid ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              tmpString:='';
              if Not AppEnvVirt.Bool['PayPrefs.ShowAccruedAnnualLeaveLiability'] then
                tmpString := tmpString + ' AND tblpaystransactions.Description <> "Annual Leave Accrued" ';
              if Not AppEnvVirt.Bool['PayPrefs.ShowAccruedSickLeaveLiability'] then
                //tmpString := tmpString + ' AND tblpaystransactions.Description <> "Sick Leave Accrued" ';
                tmpString := tmpString + ' AND tblpaystransactions.Description <> "' +Appenvvirt.str['RegionalOptions.SLName'] +' Accrued" ';
              if Not AppEnvVirt.Bool['PayPrefs.ShowAccruedLongServiceLeaveLiability'] then
                tmpString := tmpString + ' AND tblpaystransactions.Description <> "Long Service Accrued" ';
              Add(tmpString);
                     {todo: Handle sick leave,annual leave , long service taken according to above preferences}
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;

  with BulkSQL do begin
              Add('/*59.2*/ SELECT 59.2, ');
              Add('PT.checkDate as Date, ');
              Add('T.Type, ');
              Add('PT.GlobalRef  as "Global #", ');
              Add('T.ClassID, ');
              Add(Idcolumn('T.PayID','','','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('T.ClientName, ');
              Add('T.ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('T.Description as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('T.EmployeeName as RepName, ');
              Add('T.EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('If(T.Amount<0 ,-T.Amount,0.00)+0.00 as "DebitsEx", ');
              Add('If(T.Amount>0 ,T.Amount,0.00)+0.00 as  "CreditsEx", ');
              Add('If(T.Amount<0 ,-T.Amount,0.00)+0.00 as "DebitsInc", ');
              Add('If(T.Amount>0 ,T.Amount,0.00)+0.00 as "CreditsInc", ');
              Add('If(T.Amount<0 ,-T.Amount,0.00)+0.00 as "CASH_DebitsEx", ');
              Add('If(T.Amount>0 ,T.Amount,0.00)+0.00 as  "CASH_CreditsEx", ');
              Add('If(T.Amount<0 ,-T.Amount,0.00)+0.00 as "CASH_DebitsInc", ');
              Add('If(T.Amount>0 ,T.Amount,0.00)+0.00 as "CASH_CreditsInc" , ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblpaychextransactions T');
              Add('INNER JOIN tblpaychexpays PT on PT.ID =  T.PayID');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = T.AccountID ');
              Add('WHERE PT.CheckDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              tmpString:='';
              if Not AppEnvVirt.Bool['PayPrefs.ShowAccruedAnnualLeaveLiability'] then
                tmpString := tmpString + ' AND T.Description <> "Annual Leave Accrued" ';
              if Not AppEnvVirt.Bool['PayPrefs.ShowAccruedSickLeaveLiability'] then
                tmpString := tmpString + ' AND T.Description <> "' +Appenvvirt.str['RegionalOptions.SLName'] +' Accrued" ';
              if Not AppEnvVirt.Bool['PayPrefs.ShowAccruedLongServiceLeaveLiability'] then
                tmpString := tmpString + ' AND T.Description <> "Long Service Accrued" ';
              Add(tmpString);
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable60(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*60*/ SELECT ');
              Add('60, tblprepayments.PrePaymentDate, ');
              Add('"'+ AppEnvVirt.Str['tcConst.CUSTOMER_PREPAYMENT'] +'" AS Type, ');
              Add('tblprepayments.GlobalRef  as "Global #", ');
              Add('tblprepayments.ClassID, ');
              Add(Idcolumn('','','','tblprepayments.PrePaymentID',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('CompanyName, ');
              Add('tblprepayments.ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('EmployeeName as RepName, ');
              Add('tblprepayments.EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('tblprepayments.Notes as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblprepayments.PayAmount as "DebitsEx", ');
              Add('0.00 as  "CreditsEx", ');
              Add('tblprepayments.PayAmount as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('tblprepayments.PayAmount as "CASH_DebitsEx", ');
              Add('0.00 as  "CASH_CreditsEx", ');
              Add('tblprepayments.PayAmount as "CASH_DebitsInc", ');
              Add('0.00 as "CASH_CreditsInc" , ');
              Add('tblprepayments.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tblprepayments ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblprepayments.BankAccountID ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tblprepayments.EmployeeID ');
              Add('WHERE tblprepayments.Deleted<>"T" AND tblprepayments.Customer="T" AND tblprepayments.PrePaymentDate ' +
                BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable61(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*61*/ SELECT ');
              Add('61, tblprepayments.PrePaymentDate, ');
              Add('"'+AppEnvVirt.Str['tcConst.CUSTOMER_PREPAYMENT']+'" AS Type, ');
              Add('tblprepayments.GlobalRef  as "Global #", ');
              Add('tblprepayments.ClassID, ');
              Add(Idcolumn('','','','tblprepayments.PrePaymentID ',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('CompanyName, ');
              Add('tblprepayments.ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('EmployeeName as RepName, ');
              Add('tblprepayments.EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('tblprepayments.PayAmount as  "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('tblprepayments.PayAmount as "CreditsInc", ');
              Add('0.00 as "CASH_DebitsEx", ');
              Add('tblprepayments.PayAmount as  "CASH_CreditsEx", ');
              Add('0.00 as "CASH_DebitsInc", ');
              Add('tblprepayments.PayAmount as "CASH_CreditsInc" , ');
              Add('tblprepayments.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tblprepayments ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblprepayments.MasterAccountID ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tblprepayments.EmployeeID ');
              Add('WHERE tblprepayments.Deleted<>"T" AND tblprepayments.Customer="T" AND tblprepayments.PrePaymentDate ' +
                BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable62(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*62*/ SELECT ');
              Add('62, tblprepayments.PrePaymentDate, ');
              Add('"Supplier Prepayment" AS Type, ');
              Add('tblprepayments.GlobalRef  as "Global #", ');
              Add('tblprepayments.ClassID, ');
              Add(Idcolumn('','','','tblprepayments.PrePaymentID ',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('CompanyName, ');
              Add('tblprepayments.ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('EmployeeName as RepName, ');
              Add('tblprepayments.EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('tblprepayments.PayAmount as  "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('tblprepayments.PayAmount as "CreditsInc", ');
              Add('0.00 as "CASH_DebitsEx", ');
              Add('tblprepayments.PayAmount as  "CASH_CreditsEx", ');
              Add('0.00 as "CASH_DebitsInc", ');
              Add('tblprepayments.PayAmount as "CASH_CreditsInc" , ');
              Add('tblprepayments.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tblprepayments ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblprepayments.BankAccountID ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tblprepayments.EmployeeID ');
              Add('WHERE tblprepayments.Deleted<>"T" AND tblprepayments.Supplier="T" AND tblprepayments.PrePaymentDate ' +
                BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable63(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*63*/ SELECT ');
              Add('63, tblprepayments.PrePaymentDate, ');
              Add('"Supplier Prepayment" AS Type, ');
              Add('tblprepayments.GlobalRef  as "Global #", ');
              Add('tblprepayments.ClassID, ');
              Add(Idcolumn('','','','tblprepayments.PrePaymentID ',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('CompanyName, ');
              Add('tblprepayments.ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('""  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('EmployeeName as RepName, ');
              Add('tblprepayments.EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblprepayments.PayAmount as "DebitsEx", ');
              Add('0.00 as  "CreditsEx", ');
              Add('tblprepayments.PayAmount as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('tblprepayments.PayAmount as "CASH_DebitsEx", ');
              Add('0.00 as  "CASH_CreditsEx", ');
              Add('tblprepayments.PayAmount as "CASH_DebitsInc", ');
              Add('0.00 as "CASH_CreditsInc" , ');
              Add('tblprepayments.ReferenceNo  as `Chq/Ref` ');
              Add('FROM tblprepayments ');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblprepayments.MasterAccountID ');
              Add('LEFT JOIN tblemployees ON tblemployees.EmployeeID=tblprepayments.EmployeeID ');
              Add('WHERE tblprepayments.Deleted<>"T" And tblprepayments.Supplier="T" AND tblprepayments.PrePaymentDate ' +
                BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable64(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*64*/ SELECT ');
              Add('64, tblfixedassets.PurchDate as Date, ');
              Add('"Fixed Asset" AS Type, ');
              Add('tblfixedassets.GlobalRef  as "Global #", ');
              Add('FAP.ClassID, ');
              Add(Idcolumn('','','','','tblfixedassets.AssetID'));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('PARTNAME  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('""  as RepName, ');
              Add('0 as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('Notes as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblfixedassets.PurchCost*(FAP.Cost/100) as "DebitsEx", ');
              Add('0.00 as  "CreditsEx", ');
              Add('tblfixedassets.PurchCost*(FAP.Cost/100) as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('tblfixedassets.PurchCost*(FAP.Cost/100) as "CASH_DebitsEx", ');
              Add('0.00 as  "CASH_CreditsEx", ');
              Add('tblfixedassets.PurchCost*(FAP.Cost/100) as "CASH_DebitsInc", ');
              Add('0.00 as "CASH_CreditsInc" , ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblfixedassets ');
              Add('INNER JOIN tblFixedAssetPercentages FAP ON FAP.AssetID=tblfixedassets.AssetID ');
              if (AppEnvVirt.Int['CompanyPrefs.DepreciationForTransactions'] = 2) then begin
                Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblfixedassets.FixedAssetCostAccountID2 ');
              end else begin
                Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblfixedassets.FixedAssetCostAccountID ');
              end;
              Add('WHERE tblfixedassets.Active="T" AND tblfixedassets.PurchCost<>0.00 ');
              Add('AND tblfixedassets.PurchDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable65(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*65*/ SELECT ');
              Add('65, tblfixedassets.PurchDate as Date, ');
              Add('"Fixed Asset" AS Type, ');
              Add('tblfixedassets.GlobalRef  as "Global #", ');
              Add('FAP.ClassID, ');
              Add(Idcolumn('','','','','tblfixedassets.AssetID'));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('PARTNAME  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('""  as RepName, ');
              Add('0 as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('Notes as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00 as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('tblfixedassets.PurchCost*(FAP.Cost/100) as  "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('tblfixedassets.PurchCost*(FAP.Cost/100) as "CreditsInc", ');
              Add('0.00 as "CASH_DebitsEx", ');
              Add('tblfixedassets.PurchCost*(FAP.Cost/100) as  "CASH_CreditsEx", ');
              Add('0.00 as "CASH_DebitsInc", ');
              Add('tblfixedassets.PurchCost*(FAP.Cost/100) as "CASH_CreditsInc" , ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblfixedassets ');
              Add('INNER JOIN tblFixedAssetPercentages FAP ON FAP.AssetID=tblfixedassets.AssetID ');
              if (AppEnvVirt.Int['CompanyPrefs.DepreciationForTransactions'] = 2) then begin
                Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblfixedassets.ClearingAccountID2 ');
              end else begin
                Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblfixedassets.ClearingAccountID ');
              end;
              Add('WHERE tblfixedassets.Active="T" AND tblfixedassets.PurchCost<>0.00 ');
              Add('AND tblfixedassets.PurchDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable66(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*66*/ SELECT ');
              Add('66, FAD.Date as Date, ');
              Add('"Fixed Asset Depreciation" AS Type, ');
              Add('tblfixedassets.GlobalRef  as "Global #", ');
              Add('FAP.ClassID, ');
              Add(Idcolumn('','','','','tblfixedassets.AssetID'));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('PARTNAME  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('""  as RepName, ');
              Add('0 as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('Notes as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('FAD.Depreciation*(FAP.Depreciation/100) as  "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('FAD.Depreciation*(FAP.Depreciation/100) as "CreditsInc", ');
              Add('0.00 as "CASH_DebitsEx", ');
              Add('FAD.Depreciation*(FAP.Depreciation/100) as  "CASH_CreditsEx", ');
              Add('0.00 as "CASH_DebitsInc", ');
              Add('FAD.Depreciation*(FAP.Depreciation/100) as "CASH_CreditsInc" , ');
              Add('""  as `Chq/Ref`, ');
              Add('If(FAD.Date>CURDATE(),"F","T")  as `Active` ');
              Add('FROM tblfixedassets ');
              Add('INNER JOIN tblFixedAssetPercentages FAP ON FAP.AssetID=tblfixedassets.AssetID ');
              if (AppEnvVirt.Int['CompanyPrefs.DepreciationForTransactions'] = 2) then begin
                Add('INNER JOIN tblfixedassetsdepreciationdetails2 FAD ON FAD.AssetID=tblfixedassets.AssetID');
                Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblfixedassets.FixedAssetDepreciationAssetAccountID2 ');
              end else begin
                Add('INNER JOIN tblfixedassetsdepreciationdetails FAD ON FAD.AssetID= tblfixedassets.AssetID');
                Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblfixedassets.FixedAssetDepreciationAssetAccountID ');
              end;
              Add('WHERE tblfixedassets.Active="T" AND FAD.Depreciation<>0.00 ');
              Add('AND FAD.Date ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
	      Add('AND FAD.Date >= tblfixedassets.DepreciationStartDate');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_StringFixedAssets + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable67(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*67*/ SELECT ');
              Add('67, FAD.Date as Date, ');
              Add('"Fixed Asset Depreciation" AS Type, ');
              Add('tblfixedassets.GlobalRef  as "Global #", ');
              Add('FAP.ClassID, ');
              Add(Idcolumn('','','','','tblfixedassets.AssetID'));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('PARTNAME  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('""  as RepName, ');
              Add('0 as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('Notes as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00 as TaxRate, ');
              Add('0  as TaxID, ');
              Add('FAD.Depreciation*(FAP.Depreciation/100) as "DebitsEx", ');
              Add('0.00 as  "CreditsEx", ');
              Add('FAD.Depreciation*(FAP.Depreciation/100) as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('FAD.Depreciation*(FAP.Depreciation/100) as "CASH_DebitsEx", ');
              Add('0.00 as  "CASH_CreditsEx", ');
              Add('FAD.Depreciation*(FAP.Depreciation/100) as "CASH_DebitsInc", ');
              Add('0.00 as "CASH_CreditsInc" , ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblfixedassets ');
              Add('INNER JOIN tblFixedAssetPercentages FAP ON FAP.AssetID=tblfixedassets.AssetID ');
              if (AppEnvVirt.Int['CompanyPrefs.DepreciationForTransactions'] = 2) then begin
                Add('INNER JOIN tblfixedassetsdepreciationdetails2 FAD ON FAD.AssetID=tblfixedassets.AssetID ');
                Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblfixedassets.FixedAssetDepreciationAccountID2 ');
              end else begin
                Add('INNER JOIN tblfixedassetsdepreciationdetails FAD ON FAD.AssetID=tblfixedassets.AssetID ');
                Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID=tblfixedassets.FixedAssetDepreciationAccountID ');
              end;
              Add('WHERE tblfixedassets.Active="T" AND FAD.Depreciation<>0.00 ');
              Add('AND FAD.Date ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
		Add('AND FAD.Date >= tblfixedassets.DepreciationStartDate');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable69(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*69*/ SELECT ');
              Add('69, tblstocklastcostadjustments.Date, ');
              Add('Concat_WS("","Last Cost Asset Adjustment - ",tblstocklastcostadjustments.TransType) as Type, ');
              Add('""  as "Global #", ');
              Add('tblstocklastcostadjustments.ClassID, ');
              Add(Idcolumn('','','','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('P.PARTNAME  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('"" as RepName, ');
              Add('0 as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('tblstocklastcostadjustments.AdjValue as "DebitsEx", ');
              Add('0.00 as  "CreditsEx", ');
              Add('tblstocklastcostadjustments.AdjValue as "DebitsInc", ');
              Add('0.00 as "CreditsInc", ');
              Add('tblstocklastcostadjustments.AdjValue as "CASH_DebitsEx", ');
              Add('0.00 as  "CASH_CreditsEx", ');
              Add('tblstocklastcostadjustments.AdjValue as "CASH_DebitsInc", ');
              Add('0.00 as "CASH_CreditsInc" , ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblstocklastcostadjustments ');
              Add('INNER JOIN tblParts P ON P.PARTSID=tblstocklastcostadjustments.ProductID ');
              Add('INNER JOIN tblchartofaccounts on AccountName = P.ASSETACCNT ');
              Add('WHERE tblstocklastcostadjustments.AdjValue<>0 ');
              Add('AND tblstocklastcostadjustments.Date ' + BeforeOrAfterClosing + ' "' +  FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable70(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*70*/ SELECT ');
              Add('70, tblstocklastcostadjustments.Date, ');
              Add('Concat_WS("","Last Cost Asset Adjustment - ",tblstocklastcostadjustments.TransType) as Type, ');
              Add('""  as "Global #", ');
              Add('tblstocklastcostadjustments.ClassID, ');
              Add(Idcolumn('','','','',''));
              Add(LineIdcolumn('','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('""  as ProductDesc, ');
              Add('P.PARTNAME  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('"" as RepName, ');
              Add('0 as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('"" as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx", ');
              Add('tblstocklastcostadjustments.AdjValue as  "CreditsEx", ');
              Add('0.00 as "DebitsInc", ');
              Add('tblstocklastcostadjustments.AdjValue as "CreditsInc", ');
              Add('0.00 as "CASH_DebitsEx", ');
              Add('tblstocklastcostadjustments.AdjValue as  "CASH_CreditsEx", ');
              Add('0.00 as "CASH_DebitsInc", ');
              Add('tblstocklastcostadjustments.AdjValue as "CASH_CreditsInc" , ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblstocklastcostadjustments ');
              Add('INNER JOIN tblParts P ON P.PARTSID = tblstocklastcostadjustments.ProductID ');
              Add('INNER JOIN tblchartofaccounts on AccountName = P.COGSACCNT ');
              Add('WHERE tblstocklastcostadjustments.AdjValue<>0 ');
              Add('AND tblstocklastcostadjustments.Date ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;
  end;
end;

procedure TTransactionTableObj.TrnsTable71(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              //------------------------------------------------------------------
              //  Account Postings (Manufacturing)
              //------------------------------------------------------------------
              Add('/*71*/ SELECT 71, tblAccountPosting.Date as "Date", ');
              Add('tblAccountPosting.SourceName as Type, ');
              Add('tblsales.GlobalRef as "Global #", ');
              Add('APD.ClassID, ');
              Add(Idcolumn('tblSalesLines.SaleId','','','',''));
              Add(LineIdcolumn('tblSalesLines.SaleLineID','APD.AccountPostingDetailId','APD.SourceLineID',''));
              Add(COAColumns+',');
              Add('tblAccountPosting.Description  as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255))    as ProductDesc, ');
              Add('APD.Productname  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('tblAccountPosting.EmployeeName  as RepName, ');
              Add('tblAccountPosting.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(APD.Description,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('APD.DebitAmount as "DebitsEx", ');
              Add('APD.CreditAmount as "CreditsEx", ');
              Add('APD.DebitAmount  as "DebitsInc", ');
              Add('APD.CreditAmount as "CreditsInc",');
              Add('0.00 as  CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('0.00 as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc,  ');
              Add('""  as `Chq/Ref` ');

                  Add('FROM tblAccountPosting  ');
                  Add('INNER JOIN tblAccountPostingDetail APD ON APD.AccountPostingID = tblAccountPosting.AccountPostingID ');
                  Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = APD.AccountID ');
                  Add('LEFT JOIN tblProcTree PT ON PT.ProcTreeId = tblAccountPosting.SourceId');
                  Add('LEFT JOIN tblSalesLines ON tblSalesLines.SaleLineId = PT.MasterId');
                  Add('LEFT JOIN tblsales  ON tblSalesLines.saleId = tblsales.saleId');
                  Add('WHERE (tblAccountPosting.Active="T") ');
                  Add('AND tblAccountPosting.Date ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
                  if not DonotMakeTransTable then begin
                    TempFile:= NextTempFile;
                    Add('INTO OUTFILE "' + TempFile + '";');
                    Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                  end else begin
                    Add(';');
                    (*Add(' limit 1 union all');*)
                  end;




                (*qry := aQuery;
                try
                  Qry.SQl.text :=' select ' + COAColumns +' from  tblchartofaccounts where Accountname = '+quotedstr(AppEnvVirt.Str['CompanyPrefs.InventoryAssetBOMNonInvCogsAccount']);
                  Qry.Open;
                  Add('select');
                  Add('71.3 as Seqno,');
                  Add('AP.Date as date,');
                  Add('AP.SourceName as Type, ');
                  Add('AP.GlobalRef as "Global #", ');
                  Add('S.ClassID,');
                  Add(Idcolumn('SL.SaleId','','','',''));
                  Add(LineIdcolumn('SL.SaleLineID','PT.ProctreeID','PTP.proctreePartID',''));
                  Add(COAColumns(Qry)+',');
                  Add('S.CustomerName,');
                  Add('null as clientId,');
                  Add('0 as CustomerJobId, ');
                  Add('P.PARTSDESCRIPTION as ProductDesc,');
                  Add('P.PARTNAME,');
                  Add('P.PRODUCTGROUP,');
                  Add('S.EmployeeName,');
                  Add('S.EmployeeID,');
                  Add('"F" as Reconciled,');
                  Add('"" as notes,');
                  Add('""  as TaxCode,');
                  Add('0.00  as TaxRate,');
                  Add('0  as TaxID,');
                  Add('0-PT.totalqty *' + NonInvProductcostinBOM +',');
                  Add('0,');
                  Add('0-PT.totalqty *' + NonInvProductcostinBOM +',');
                  Add('0,');
                  Add('0.00 as CASH_DebitsEx,');
                  Add('0.00 as CASH_CreditsEx,');
                  Add('0.00 as CASH_DebitsInc,');
                  Add('0.00 as CASH_CreditsInc,');
                  Add('""   as `Chq/Ref`');
                  Add('from  tblproctree  PT');
                  Add('inner join tblaccountposting AP on PT.TreeRootID = AP.SourceId');
                  Add('inner join tblproctreePart PTP on Pt.proctreeId = PTP.proctreeId');
                  Add('inner join tblparts        P on Ptp.ProductID = P.partsId and P.PARTTYPE <> "INV"');
                  Add('inner join tblsaleslines   SL on PT.masterId = SL.salelineId');
                  Add('inner join tblsales S on s.saleId = SL.saleId  and S.converted ="T"');
                  Add('where  PT.masterType in ("mtSalesOrder" ,  "mtInvoice") and ifnull(Pt.PartsID,0)<>0 and PT.TreeRootId<>PT.ProcTreeId');
                  Add('AND AP.Date ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                  Add('Drop table if exists '+'tmp_tblchartofaccounts'+ AppEnvVirt.str['Employee.LogonName']+';');
                finally
                  Qry.ClosenFree;
                end;
              end;  *)
  end;
end;
procedure TTransactionTableObj.TrnsTable72(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
                {reward points}
                Add('SELECT');
                Add('72, S.SaleDate,');
                Add('if(S.ISInvoice="T", "Invoice" ,"Cash Sale") ,');
                Add('SLP.Globalref,');
                Add('S.ClassID,');
                Add(Idcolumn('S.SaleID','','','',''));
                Add(LineIdcolumn('SLP.SalesLinesPointsId','','',''));
                Add(COAColumns+',');
                Add('S.CustomerName,');
                Add('S.ClientID,');
                Add('0 as CustomerJobId, ');
                Add('SL.Product_Description,');
                Add('SL.ProductName,');
                Add('SL.ProductGroup,');
                Add('S.EmployeeName,');
                Add('S.EmployeeID,');
                Add('"F",');
                Add('"",');
                Add('"",');
                Add('0.0,');
                Add('0,');
                Add('0 , ');
    {credit}    Add('SLP.ValueforRewardPoint*SLP.LinePoints, ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints,');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints, ');
                Add('0 ,');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints , ');
                Add('""');
                Add('FROM');
                Add('tblsales AS S');
                Add('Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID');
                Add('Inner Join tblsaleslinespoints AS SLP ON SL.SaleID = SLP.SaleID AND SL.SaleLineID = SLP.SaleLineID ,');
                Add('tblchartofaccounts ');
                Add('WHERE');
                Add('tblchartofaccounts.AccountId =  ' +IntToStr(AppEnvVirt.Int['CompanyPrefs.RewardPointssoldAccount']) );
                Add('AND S.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                  Add(';');
                  (*Add(' limit 1 union all');*)
                end;
  end;
end;
procedure TTransactionTableObj.TrnsTable73(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
                Add('SELECT');
                Add('73, SLP.OpeningBalanceAsOn,');
                Add('"Sales Points Opening Balance" ,');
                Add('SLP.Globalref,');
                Add('SLP.DEptID,');
                Add(Idcolumn('','','','',''));
                Add(LineIdcolumn('SLP.SalesLinesPointsId','','',''));
                Add(COAColumns+',');
                Add('C.company,');
                Add('C.ClientID,');
                Add('0 as CustomerJobId, ');
                Add('"",');
                Add('"",');
                Add('"",');
                Add('"",');
                Add('0,');
                Add('"F",');
                Add('"",');
                Add('"",');
                Add('0.0,');
                Add('0,');
                Add('0 , ');
    {credit}    Add('SLP.ValueforRewardPoint*SLP.LinePoints, ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints,');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints, ');
                Add('0 ,');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints , ');
                Add('""');
                Add('FROM tblsaleslinespoints AS SLP inner join tblClients C on C.ClientId = SLP.clientID,');
                Add('tblchartofaccounts ');
                Add('WHERE SLP.IsOpeningBalance ="T" and ');
                Add('tblchartofaccounts.AccountId =  ' +IntToStr(AppEnvVirt.Int['CompanyPrefs.RewardPointssoldAccount']) );
                Add('AND SLP.OpeningBalanceAsOn' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                  Add(';');
                  (*Add(' limit 1 union all');*)
                end;
  end;
end;
procedure TTransactionTableObj.TrnsTable74(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin

                Add('SELECT');
                Add('74,S.SaleDate,');
                Add('if(S.ISInvoice="T", "Invoice" ,"Cash Sale") ,');
                Add('SLP.Globalref,');
                Add('S.ClassID,');
                Add(Idcolumn('S.SAleID','','','',''));
                Add(LineIdcolumn('SLP.SalesLinesPointsId','','',''));
                Add(COAColumns+',');
                Add('S.CustomerName,');
                Add('S.ClientID,');
                Add('0 as CustomerJobId, ');
                Add('SL.Product_Description,');
                Add('SL.ProductName,');
                Add('SL.ProductGroup,');
                Add('S.EmployeeName,');
                Add('S.EmployeeID,');
                Add('"F",');
                Add('"",');
                Add('"",');
                Add('0.0,');
                Add('0,');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints , ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints, ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints,');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints, ');
                Add('0 ,');
                Add('""');
                Add('FROM');
                Add('tblsales AS S');
                Add('Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID');
                Add('Inner Join tblsaleslinespoints AS SLP ON SL.SaleID = SLP.SaleID AND SL.SaleLineID = SLP.SaleLineID ,');
                Add('tblchartofaccounts ');
                Add('WHERE');
                Add('tblchartofaccounts.AccountID =  ' + IntToStr(AppEnvVirt.Int['CompanyPrefs.ExpenseAccountforRewardPoints']));
                Add('AND S.SaleDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                  Add(';');
                  (*Add(' limit 1 union all');*)
                end;
  end;
end;
procedure TTransactionTableObj.TrnsTable75(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin


                Add('SELECT');
                Add('75,SLP.OpeningBalanceAsOn,');
                Add('"Sales Points Opening Balance" ,');
                Add('SLP.Globalref,');
                Add('SLP.DeptID,');
                Add(Idcolumn('','','','',''));
                Add(LineIdcolumn('SLP.SalesLinesPointsId','','',''));
                Add(COAColumns+',');
                Add('C.company,');
                Add('C.ClientID,');
                Add('0 as CustomerJobId, ');
                Add('"",');
                Add('"",');
                Add('"",');
                Add('"",');
                Add('0,');
                Add('"F",');
                Add('"",');
                Add('"",');
                Add('0.0,');
                Add('0,');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints , ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints, ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints,');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*SLP.LinePoints, ');
                Add('0 ,');
                Add('""');
                Add('FROM tblsaleslinespoints AS SLP inner join tblClients C on C.ClientId = SLP.clientID, ');
                Add('tblchartofaccounts ');
                Add('WHERE SLP.IsOpeningBalance ="T" and ');
                Add('tblchartofaccounts.AccountID =  ' + IntToStr(AppEnvVirt.Int['CompanyPrefs.ExpenseAccountforRewardPoints']));
                Add('AND SLP.OpeningBalanceAsOn' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                  Add(';');
                  (*Add(' limit 1 union all');*)
                end;

  end;
end;
procedure TTransactionTableObj.TrnsTable76(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin

                {expired reward points}
    {reward points}
                Add('SELECT');
                Add('76, ' +ProductRewardPointsLib.PointsExpireDate+',');
                Add('if(S.ISInvoice="T", "Invoice" ,"Cash Sale") ,');
                Add('SLP.Globalref,');
                Add('S.ClassID,');
                Add(Idcolumn('s.SAleId','','','',''));
                Add(LineIdcolumn('SLP.SalesLinesPointsId','','',''));
                Add(COAColumns+',');
                Add('S.CustomerName,');
                Add('S.ClientID,');
                Add('0 as CustomerJobId, ');
                Add('SL.Product_Description,');
                Add('SL.ProductName,');
                Add('SL.ProductGroup,');
                Add('S.EmployeeName,');
                Add('S.EmployeeID,');
                Add('"F",');
                Add('"",');
                Add('"",');
                Add('0.0,');
                Add('0,');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 ,');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 , ');
                Add('""');
                Add('FROM');
                Add('tblsales AS S');
                Add('Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID');
                Add('Inner Join tblsaleslinespoints AS SLP ON SL.SaleID = SLP.SaleID AND SL.SaleLineID = SLP.SaleLineID ');
                Add('and ' + ProductRewardPointsLib.PointsExpireDate +' <>0');
                Add('and ' + ProductRewardPointsLib.PointsExpireDate +' <'+QuotedStr(formatDateTime(mySQLDateFormat, DAte)));
                Add('Left join tblsalesredeempoints SRP on SRP.SalesLinesPointsId = SLP.SalesLinesPointsId and SRP.active ="T",');
                Add('tblchartofaccounts ');
                Add('WHERE');
                Add('tblchartofaccounts.AccountId =  ' +IntToStr(AppEnvVirt.Int['CompanyPrefs.RewardPointsExpiredAccount']));
                Add('AND ' +ProductRewardPointsLib.PointsExpireDate+' ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
                Add('Group by SLP.SalesLinesPointsId');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                  Add(';');
                  (*Add(' limit 1 union all');*)
                end;
  end;
end;
procedure TTransactionTableObj.TrnsTable77(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin


                Add('SELECT');
                Add('77, SLP.PointExpiresOn,');
                Add('"Sales Points Opening Balance" ,');
                Add('SLP.Globalref,');
                Add('SLP.DEptID,');
                Add(Idcolumn('','','','',''));
                Add(LineIdcolumn('SLP.SalesLinesPointsId','','',''));
                Add(COAColumns+',');
                Add('C.company,');
                Add('C.ClientID,');
                Add('0 as CustomerJobId, ');
                Add('"" as ProductDesc,');
                Add('"" as ProductName,');
                Add('"" as ProductGroup,');
                Add('"" as RepName,');
                Add('0 as EmployeeID,');
                Add('"F" as Reconciled,');
                Add('"" as Notes,');
                Add('"" as TaxCode,');
                Add('0.0 as TaxRate,');
                Add('0 as TaxID,');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 ,');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 , ');
                Add('""');
                Add('FROM tblsaleslinespoints AS SLP ');
                Add('inner join tblclients C on C.ClientId = SLP.clientID');
                Add('Left join tblsalesredeempoints SRP on SRP.SalesLinesPointsId = SLP.SalesLinesPointsId and SRP.active ="T",');
                Add('tblchartofaccounts ');
                Add('WHERE SLP.IsOpeningBalance ="T" and ');
                Add('tblchartofaccounts.AccountId =  ' +IntToStr(AppEnvVirt.Int['CompanyPrefs.RewardPointsExpiredAccount']));
                Add('AND SLP.PointExpiresOn ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
                Add('and SLP.PointExpiresOn <>0');
                Add('and SLP.PointExpiresOn <'+QuotedStr(formatDateTime(mySQLDateFormat, DAte)));
                Add('Group by SLP.SalesLinesPointsId');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                  Add(';');
                  (*Add(' limit 1 union all');*)
                end;
  end;
end;
procedure TTransactionTableObj.TrnsTable78(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin


                Add('SELECT');
                Add('78,' +ProductRewardPointsLib.PointsExpireDate+',');
                Add('if(S.ISInvoice="T", "Invoice" ,"Cash Sale") ,');
                Add('SLP.Globalref,');
                Add('S.ClassID,');
                Add(Idcolumn('S.SAleId','','','',''));
                Add(LineIdcolumn('SLP.SalesLinesPointsId','','',''));
                Add(COAColumns+',');
                Add('S.CustomerName,');
                Add('S.ClientID,');
                Add('0 as CustomerJobId, ');
                Add('SL.Product_Description,');
                Add('SL.ProductName,');
                Add('SL.ProductGroup,');
                Add('S.EmployeeName,');
                Add('S.EmployeeID,');
                Add('"F",');
                Add('"",');
                Add('"",');
                Add('0.0,');
                Add('0,');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 ,');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('""');
                Add('FROM');
                Add('tblsales AS S');
                Add('Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID');
                Add('Inner Join tblsaleslinespoints AS SLP ON SL.SaleID = SLP.SaleID AND SL.SaleLineID = SLP.SaleLineID ');
                Add('and ' + ProductRewardPointsLib.PointsExpireDate +' <>0');
                Add('and ' + ProductRewardPointsLib.PointsExpireDate +' <'+QuotedStr(formatDateTime(mySQLDateFormat, DAte)));
                Add('Left join tblsalesredeempoints SRP on SRP.SalesLinesPointsId = SLP.SalesLinesPointsId and SRP.active ="T",');
                Add('tblchartofaccounts ');
                Add('WHERE');
                Add('tblchartofaccounts.AccountID =  ' + IntToStr(AppEnvVirt.Int['CompanyPrefs.ExpenseAccountforRewardPoints']));
                Add('AND ' +ProductRewardPointsLib.PointsExpireDate+' ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
                Add('Group by SLP.SalesLinesPointsId');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                  Add(';');
                  (*Add(' limit 1 union all');*)
                end;

  end;
end;
procedure TTransactionTableObj.TrnsTable79(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin

                Add('SELECT');
                Add('79, SLP.PointExpiresOn,');
                Add('"Sales Points Opening Balance" ,');
                Add('SLP.Globalref,');
                Add('SLP.DEptID,');
                Add(Idcolumn('','','','',''));
                Add(LineIdcolumn('SLP.SalesLinesPointsId','','',''));
                Add(COAColumns+',');
                Add('C.company,');
                Add('C.ClientID,');
                Add('0 as CustomerJobId, ');
                (*Add('"",');*)Add('"" as ProductDesc,');
                (*Add('"",');*)Add('"" as ProductName,');
                (*Add('"",');*)Add('"" as ProductGroup,');
                (*Add('"",');*)Add('"" as RepName,');
                (*Add('"",');*)Add('0 as EmployeeID,');
                (*Add('"F",');*)Add('"F" as Reconciled,');
                (*Add('"",');*)Add('"" as Notes,');
                (*Add('"",');*)Add('"" as TaxCode,');
                (*Add('0.0,');*)Add('0.0 as TaxRate,');
                (*Add('0,');*)Add('0 as TaxID,');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 , ');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('0 ,');
                Add('SLP.ValueforRewardPoint*(ifnull(SLP.LinePoints,0)-ifnull(round(Sum(ifnull(SRP.UsedPoints,0)),0),' + IntToStr(AppEnvVirt.Int['CompanyPrefs.RoundUpPoints'])+ ')), ');
                Add('""');
                Add('FROM tblsaleslinespoints AS SLP ');
                Add('inner join tblclients C on C.ClientId = SLP.clientID');
                Add('Left join tblsalesredeempoints SRP on SRP.SalesLinesPointsId = SLP.SalesLinesPointsId and SRP.active ="T",');
                Add('tblchartofaccounts ');
                Add('WHERE SLP.IsOpeningBalance ="T" and ');
                Add('tblchartofaccounts.AccountID =  ' + IntToStr(AppEnvVirt.Int['CompanyPrefs.ExpenseAccountforRewardPoints']));
                Add('AND SLP.PointExpiresOn ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
                Add('and SLP.PointExpiresOn <>0');
                Add('and SLP.PointExpiresOn <'+QuotedStr(formatDateTime(mySQLDateFormat, DAte)));
                Add('Group by SLP.SalesLinesPointsId');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                  Add(';');
                  (*Add(' limit 1 union all');*)
                end;
  end;
end;

procedure TTransactionTableObj.TrnsTable80(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              {TransferFrom- Account --> Debit}
              Add('/*80*/ SELECT 80, SM.MovementDate as "Date", ');
              Add('"Stock Transfer" as Type, ');
              Add('ST.GlobalRef as "Global #", ');
              Add('SML.ClassId, ');
              Add(Idcolumn('ST.TransferEntryID','SM.StockmovementID','','',''));
              Add(LineIdcolumn('SML.StockmovementLinesID','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('tblParts.PARTSDESCRIPTION  as ProductDesc, ');
              Add('SML.ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('SM.Employee  as RepName, ');
              Add('SM.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(SM.Notes,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('Sum(ifnull(abs(SML.Qty)*cost,0))  as DebitsEx, ');
              Add('0.00             as CreditsEx, ');
              Add('Sum(ifnull(abs(SML.Qty)*cost,0))  as DebitsInc, ');
              Add('0.00             as CreditsInc, ');
              Add('Sum(ifnull(abs(SML.Qty)*cost,0))  as CASH_DebitsEx, ');
              Add('0.00             as CASH_CreditsEx, ');
              Add('Sum(ifnull(abs(SML.Qty)*cost,0))  as CASH_DebitsInc, ');
              Add('0.00             as CASH_CreditsInc  , ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblStockMovementLines as SML ');
              Add('INNER JOIN tblstockmovement as SM on SM.stockmovementID = SML.stockmovementID and SM.StockmovementEntryType = "StockTransferEntry" ');
              Add('INNER join tblPQA pqa on pqa.transId = SML.StockmovementID and PQA.translineId = SML.StockmovementLinesID and PQA.transtype = "TStockMovementLines" and if(Alloctype="OUT", 0-PQA.Qty, PQA.QTY)<>0');
              Add('INNER JOIN tblstocktransferentry ST on SM.StockMovementEntryglobalref = ST.Globalref');
              Add('INNER JOIN tblParts On tblParts.PartsID = SML.ProductID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = SM.AccountID ');
              Add('WHERE SM.Deleted<>"T" AND SM.MovementDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('GROUP BY SM.StockMovementID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;


  end;
end;
procedure TTransactionTableObj.TrnsTable81(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              {Transferto-Account --> Credit}
              Add('/*81*/ SELECT 81, SM.MovementDate as "Date", ');
              Add('"Stock Transfer" as Type, ');
              Add('ST.GlobalRef as "Global #", ');
              Add('SML.ClassId, ');
              Add(Idcolumn('ST.TransferEntryID','SM.StockmovementID','','',''));
              Add(LineIdcolumn('SML.StockmovementLinesID','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('tblParts.PARTSDESCRIPTION  as ProductDesc, ');
              Add('SML.ProductName  as ProductName, ');
              Add('ProductGroup  as ProductGroup, ');
              Add('SM.Employee  as RepName, ');
              Add('SM.EmployeeID  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(SM.Notes,1,255) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as DebitsEx, ');
              Add('sum(ifnull(abs(SML.Qty*cost),0)) as CreditsEx, ');
              Add('0.00 as DebitsInc, ');
              Add('sum(ifnull(abs(SML.Qty*cost),0)) as CreditsInc, ');
              Add('0.00  as CASH_DebitsEx, ');
              Add('sum(ifnull(abs(SML.Qty*cost),0))  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('sum(ifnull(abs(SML.Qty*cost),0))  as CASH_CreditsInc  , ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblStockMovementLines as SML ');
              Add('INNER JOIN tblstockmovement as SM on SM.stockmovementID = SML.stockmovementID and SM.StockmovementEntryType = "StockTransferEntry" ');
              Add('INNER join tblPQA pqa on pqa.transId = SML.StockmovementID and PQA.translineId = SML.StockmovementLinesID and PQA.transtype = "TStockMovementLines" and if(PQA.Alloctype="OUT", 0-PQA.Qty, PQA.QTY)<>0');
              Add('INNER JOIN tblstocktransferentry ST on SM.StockMovementEntryglobalref = ST.Globalref');
              Add('INNER JOIN tblParts On tblParts.PartsID = SML.ProductID ');
              Add('INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = SM.AccountID ');
              Add('WHERE SM.Deleted<>"T" AND SM.MovementDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
              Add('GROUP BY SM.StockMovementID');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;



  end;
end;
procedure TTransactionTableObj.TrnsTable83(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin

end;
procedure TTransactionTableObj.TrnsTable84(BulkSQL: TStringList;
  DonotMakeTransTable: Boolean);
begin

end;
procedure TTransactionTableObj.TrnsTable85(BulkSQL: TStringList;
  DonotMakeTransTable: Boolean);
begin
  if (AppEnvVirt.Bool['CompanyPrefs.POSPostBlindBalanceVariance']) and
    (AppEnvVirt.Str['CompanyPrefs.POSBliandBalanceVarianceAccount'] <> '') then begin

    with BulkSQL do begin
      Add('/*85*/ SELECT 85, EndDate as "Date", ');
      Add('"POS EOP Variance" as Type, ');
      Add('tblPosTillEop.GlobalRef as "Global #", ');
      Add('0 as ClassId, ');
      Add(Idcolumn('PeriodId','','','',''));
      Add(LineIdcolumn('','','',''));
      Add(COAColumns+',');
      Add('"" as ClientName, ');
      Add('0 as ClientID, ');
      Add('0 as CustomerJobId, ');
      Add('""  as ProductDesc, ');
      Add('""  as ProductName, ');
      Add('""  as ProductGroup, ');
      Add('EmployeeName  as RepName, ');
      Add('EmployeeID  as EmployeeID, ');
      Add('"F" as Reconciled, ');
      Add('Concat("Till ",TillID) as Notes, ');
      Add('"" as TaxCode, ');
      Add('0.00  as TaxRate, ');
      Add('0 as TaxID, ');

      Add('Variation as "DebitsEx", ');
      Add('0.00 as "CreditsEx", ');
      Add('Variation as "DebitsInc", ');
      Add('0.00 as "CreditsInc",');
      Add('Variation as  CASH_DebitsEx, ');
      Add('0.00  as CASH_CreditsEx, ');
      Add('Variation as CASH_DebitsInc, ');
      Add('0.00  as CASH_CreditsInc,  ');

      Add('""  as `Chq/Ref` ');
      Add('FROM tblPosTillEop  ');
      // Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
      Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountName = ' + QuotedStr(AppEnvVirt.Str['CompanyPrefs.POSBliandBalanceVarianceAccount']));
      //Add('WHERE (tblSales.IsInvoice="T") AND tblSales.Deleted="F" ');
      Add('WHERE tblPosTillEop.EndDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
      Add('AND NOT ISNull(TillID)');
      //Add('GROUP BY  tblSales.SaleID');
      if not DonotMakeTransTable then begin
        TempFile:= NextTempFile;
        Add('INTO OUTFILE "' + TempFile + '";');
        Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
      end else begin
        Add(';');
        (*Add(' limit 1 union all');*)
      end;
    end;

    with BulkSQL do begin
      Add('/*86*/ SELECT 86, EndDate as "Date", ');
      Add('"POS EOP Variance" as Type, ');
      Add('tblPosTillEop.GlobalRef as "Global #", ');
      Add('0 as ClassId, ');
      Add(Idcolumn('PeriodId','','','',''));
      Add(LineIdcolumn('','','',''));
      Add(COAColumns+',');
      Add('"" as ClientName, ');
      Add('0 as ClientID, ');
      Add('0 as CustomerJobId, ');
      Add('""  as ProductDesc, ');
      Add('""  as ProductName, ');
      Add('""  as ProductGroup, ');
      Add('EmployeeName  as RepName, ');
      Add('EmployeeID  as EmployeeID, ');
      Add('"F" as Reconciled, ');
      Add('Concat("Till ",TillID) as Notes, ');
      Add('"" as TaxCode, ');
      Add('0.00  as TaxRate, ');
      Add('0 as TaxID, ');

      Add('Variation as "DebitsEx", ');
      Add('0.00 as "CreditsEx", ');
      Add('Variation as "DebitsInc", ');
      Add('0.00 as "CreditsInc",');
      Add('Variation as  CASH_DebitsEx, ');
      Add('0.00  as CASH_CreditsEx, ');
      Add('Variation as CASH_DebitsInc, ');
      Add('0.00  as CASH_CreditsInc,  ');

      Add('""  as `Chq/Ref` ');
      Add('FROM tblPosTillEop  ');
      // Add('INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID ');
      Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountName = ' + QuotedStr(AppEnvVirt.Str['tcConst.UNDEPOSITED_FUNDS']));
      //Add('WHERE (tblSales.IsInvoice="T") AND tblSales.Deleted="F" ');
      Add('WHERE tblPosTillEop.EndDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ');
      Add('AND NOT ISNull(TillID)');
      //Add('GROUP BY  tblSales.SaleID');
      if not DonotMakeTransTable then begin
        TempFile:= NextTempFile;
        Add('INTO OUTFILE "' + TempFile + '";');
        Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
      end else begin
        Add(';');
        (*Add(' limit 1 union all');*)
      end;
    end;

  end;
end;
procedure TTransactionTableObj.TrnsTable87(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False; Const aSaleID:Integer=0);
var
  ctr:Integer;
(*  fiBOMTreeLevels: Integer;

Function BOMTreeLevels: Integer;
var
  qry:TERPQuery;
begin
  Qry := NewQry;
  try
    qry.sql.text := 'Select max(Level) as BOMTreeLevels from tblProctree';
    qry.open;
    Result := qry.FieldByname('BOMTreeLevels').asInteger;
  finally
    Qry.closenFree;
  end;
end;*)

begin
    // this makes 87 : Progress build for INV product
    //            88 : Progress build for NONINV
    //            89 : Progress build wastage (Expense)
    //  90 : fix posting for Steel mains progress build issue of not using all row materilas some time
    with BulkSQL do begin
        for ctr:= 0 to 3 do begin
              Log( 'BOM Entries #'+ inttostr(ctr) +': Seqno :' +inttostr(87+ctr) ,ltWarning);
              Log(' BoM Non Product subnode Posting Account = '+  Quotedstr(trim(AppEnvVirt.Str['CompanyPrefs.BoMNonProductsubnodePostingAccount'])) ,ltWarning);
              if (ctr<>3) or (trim(AppEnvVirt.Str['CompanyPrefs.BoMNonProductsubnodePostingAccount'])<> '') then begin
                Log( 'BOM Entries #'+ inttostr(ctr) +': Seqno :' +inttostr(87+ctr) ,ltWarning);
                Add('/* ' + inttostr(87+ctr) +'*/ SELECT ' + inttostr(87+ctr) +' ,  date(PPG.Progressdate) as Date , ');
                Add('"Manufacturing" as type, ');
                Add('S.globalref, ');
                Add('PPG.ClassID, ');
                Add(Idcolumn('SL.saleID ','','','','')); // Add('SL.saleID , 0 as PurchaseOrderID,0 as PaymentID,0 as PrepaymentID,0 as FixedAssetID, ');
                Add(LineIdcolumn('SL.SaleLineID',
                                 'PPG.ProcProgressID ',
                                 'if(ifnull(PPG.InProcProgressId,0)<>0 , PPG.InProcProgressId , PPG.ProcProgressID)',
                                 'PPG.ProcProgressID')); // Add('SL.SaleLineID as SaleLineId, PPG.ProcProgressID as PurchaselineID, 0 as PaymentLineID, 0 as PrePaymentlineID, ');
                Add(COAColumns+',');
                (*Add('P.ASSETACCNT  as AccountName, ');
                Add('Concat_WS("^",IF(char_length(COA.AccountGroup)=0,Null,COA.AccountGroup) ,Trim(COA.AccountName)) as AccountGroupLevels , ');
                Add('Left(SUBSTRING_INDEX(Concat_WS("^",IF(char_length(COA.AccountGroup)=0,Null,COA.AccountGroup) ,Trim(COA.AccountName)),"^",1),255) as Level1,Left(substring(substring_index(Concat_WS("^",IF(char_length(COA.AccountGroup)=0,Null,COA.AccountGroup) ,Trim(COA.AccountName)),"^",2),char_length(substring_index(Concat_WS("^",IF(char_length(COA.AccountGroup)=0,Null,COA.AccountGroup) ,Trim(COA.AccountName)),"^",1))+2),255) as Level2,Left(substring(substring_index(Concat_WS("^",IF(char_length(COA.AccountGroup)=0,Null,COA.AccountGroup) ,Trim(COA.AccountName)),"^",3),char_length(substring_index(Concat_WS("^",IF(char_length(COA.AccountGroup)=0,Null,COA.AccountGroup) ,Trim(COA.AccountName)),"^",2))+2),255) as Level3,Left(substring(substring_index(Concat_WS("^",IF(char_length(COA.AccountGroup)=0,Null,COA.AccountGroup) ,Trim(COA.AccountName)),"^",4),char_length(substring_index(Concat_WS("^",IF(char_length(COA.AccountGroup)=0,Null,COA.AccountGroup) ,Trim(COA.AccountName)),"^",3))+2),255) as Level4, ');
                Add('COA.AccountID,COA.AccountType, ');*)
                Add('S.CustomerName  as ClientName , ');
                Add('S.ClientID , ');
                Add('0 as CustomerJobId, ');
                Add('Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255))    as ProductDesc, ');
                if ctr = 3 then begin
                  Add('PT.caption as Productname, ');
                  Add('PT.caption as PRODUCTGROUP , ') ;
                end else begin
                  Add('P.partname as Productname, ') ;
                  Add('P.PRODUCTGROUP  as PRODUCTGROUP , ') ;
                end;
                Add('E.EmployeeName, ');
                Add('PPG.employeeid , ');
                Add('"F" REconciled, ');
                Add('PPG.Globalref Notes, ');
                Add('""  as TaxCode, ');
                Add('0.00  as TaxRate, ');
                Add('0  as TaxID, ');
                Add(iif(ctr=2, '0-' , '')+ 'if(PPG.Alloctype ="OUT"  , 0 , PPG.Qty* PPG.ProductUnitCost ) as "DebitsEx", ');
                Add(iif(ctr=2, '0-' , '')+ 'if(PPG.Alloctype ="IN"   , 0 , PPG.Qty* PPG.ProductUnitCost ) as "CreditsEx", ');
                Add(iif(ctr=2, '0-' , '')+ 'if(PPG.Alloctype ="OUT"  , 0 , PPG.Qty* PPG.ProductUnitCost ) as "DebitsInc", ');
                Add(iif(ctr=2, '0-' , '')+ 'if(PPG.Alloctype ="IN"   , 0 , PPG.Qty* PPG.ProductUnitCost ) as "CreditsInc", ');

                Add('0.00 as  CASH_DebitsEx, ');
                Add('0.00  as CASH_CreditsEx, ');
                Add('0.00 as CASH_DebitsInc, ');
                Add('0.00  as CASH_CreditsInc , ');
                {$IFDEF DevMode}
                  Add('concat( PPG.Alloctype , ":" , PPG.UOMQty)  as `Chq/Ref` ');
                {$ELSE}
                Add('""  as `Chq/Ref` ');
                {$ENDIF}
                Add('from tblprocprogress PPG ');
                if ctr < 3 then begin
                  Add('inner join tblproctreepart PP on PP.ProcTreePartId = PPG.ProcTreePartID ');
                  Add('inner join tblproctree PT on PT.ProcTreeId = PP.ProcTreeId ');
                end else begin
                  Add('inner join tblproctree PT on PT.ProcTreeId = PPG.ProcTreeId ');
                end;
                Add('inner join tblSaleslines SL on PT.MasterId = SL.salelineId ');
                Add('inner join tblsales S on S.saleId = SL.saleId ');
                if aSaleID <> 0 then Add(' AND S.saleId =' + inttostr(aSaleID));
                if ctr < 3 then Add('inner join tblparts P on P.partsId = PPG.ProductID ');
                     if ctr =0 then Add(' inner join tblchartofaccounts  on P.ASSETACCNT = tblchartofaccounts.AccountName ')
                else if ctr =1 then Add(' inner join tblchartofaccounts  on P.COGSACCNT = tblchartofaccounts.AccountName ')
                else if ctr =2 then Add(' inner join tblchartofaccounts  on tblchartofaccounts.AccountName = ' + Quotedstr(AppEnvVirt.Str['CompanyPrefs.DefaultBOMWastageAccount']) )
                else if ctr =3 then Add(' inner join tblchartofaccounts  on tblchartofaccounts.AccountName = ' + Quotedstr(AppEnvVirt.Str['CompanyPrefs.BoMNonProductsubnodePostingAccount']) )(*
                else if ctr =3 then Add(' inner join tblchartofaccounts  on P.COGSACCNT = tblchartofaccounts.AccountName ')*);

                Add('inner join tblemployees E on E.EmployeeID = PPG.employeeId ');
                Add('AND PPG.Progressdate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');

                     if ctr =0 then Add(' Where P.partType ="INV"   ' (*+ ' and PPG.Alloctype ="OUT"'*))  // exclude B:Building and H:On hold as the PQA is still inactive and so is not included in stock movement
                else if ctr =1 then Add(' Where P.partType <>"INV"  ' (*+ '  and PPG.Alloctype ="IN"'*))  // exclude B:Building and H:On hold as the PQA is still inactive and so is not included in stock movement
                else if ctr =2 then Add(' Where PPG.BuildStatus ="W"' (*+ '  and PPG.Alloctype ="IN"'*))
                else if ctr =3 then Add(' Where  ifnull( PPG.ProductID,0)=0' (*+ '  and PPG.Alloctype ="IN"'*))(*
                else if ctr =3 then Add(' Where P.partType ="INV" and PPG.Alloctype ="IN"')*);

                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                if ((ctr=3) and (trim(AppEnvVirt.Str['CompanyPrefs.BoMNonProductsubnodePostingAccount'])<> '')) or
                   ((ctr=2) and (trim(AppEnvVirt.Str['CompanyPrefs.BoMNonProductsubnodePostingAccount'])= '')) then
                    Add(';') else Add('union all ');

                  (*Add(' limit 1 union all');*)
                end;
            end;
          end;
        end;

(*
{Binny - posting to adjust the cost of non-product SUB bom branch when the avg cost of its row material changed
the problem with this is, it only fix for the immediate parent of the non product bom, if thats not the top level item, the adjusted cost is not used for its parent in the heirarchy}
              TempFile:= NextTempFile;
                Add('drop table if exists  tmpppgsummarymismatch; '+
                          ' CREATE TABLE tmpppgsummarymismatch ( '+
                          ' ID INT(11) NOT NULL AUTO_INCREMENT, '+
                          ' Date DATE NULL DEFAULT NULL, '+
                          ' globalref VARCHAR(255) NULL DEFAULT NULL, '+
                          ' ClassID INT(11) NULL DEFAULT NULL, '+
                          ' saleID INT(11) NULL DEFAULT 0, '+
                          ' SaleLineID INT(11) NOT NULL DEFAULT 0, '+
                          ' ProcTreeId INT(11) NOT NULL DEFAULT 0, '+
                          ' AccountName VARCHAR(255) NULL DEFAULT NULL, '+
                          ' ClientName VARCHAR(255) NULL DEFAULT NULL, '+
                          ' ClientID INT(11) NULL DEFAULT NULL, '+
                          ' ProductDesc VARCHAR(255) NULL DEFAULT NULL, '+
                          ' Productname VARCHAR(255) NULL DEFAULT NULL, '+
                          ' PRODUCTGROUP VARCHAR(255) NULL DEFAULT NULL, '+
                          ' EmployeeName VARCHAR(255) NULL DEFAULT NULL, '+
                          ' employeeid INT(11) NULL DEFAULT NULL, '+
                          ' DebitsEx DOUBLE NULL DEFAULT NULL, '+
                          ' CreditsEx DOUBLE NULL DEFAULT NULL, '+
                          ' PRIMARY KEY (ID) )COLLATE="utf8_general_ci" ENGINE=MyISAM ;' );

                Add('SELECT '+
                          ' date(PPG.Progressdate) as Date , '+
                          ' S.globalref, '+
                          ' S.ClassID, '+
                          ' SL.saleID , '+
                          ' SL.SaleLineID , '+
                          ' PPT.ProcTreeId, '+
                          ' tblchartofaccounts.AccountName as AccountName, '+
                          ' S.CustomerName  as ClientName , '+
                          ' S.ClientID , '+
                          ' Convert(TreeNodeCaption(PPT.Level, PPT.caption ), char(255))    as ProductDesc, '+
                          ' PP.partname as Productname, '+
                          ' PP.PRODUCTGROUP  as PRODUCTGROUP , '+
                          ' S.EmployeeName, '+
                          ' S.employeeid , '+
                          ' sum(if(PPG.Alloctype ="OUT"  , 0 , PPG.Qty* PPG.ProductUnitCost )) as "DebitsEx", '+
                          ' sum(if(PPG.Alloctype ="IN"   , 0 , PPG.Qty* PPG.ProductUnitCost )) as "CreditsEx" '+
                          ' from tblprocprogress PPG '+
                          ' inner join tblproctree PT on PT.ProcTreeId = PPG.ProcTreeId and PT.MasterType <> "mtProduct" '+
                          ' inner join tblSaleslines SL on PT.MasterId = SL.salelineId '+
                          ' inner join tblsales S on S.saleId = SL.saleId '+
                          ' left join tblparts P on P.partsId = PPG.ProductID '+
                          ' inner join tblemployees E on E.EmployeeID = PPG.employeeId '+
                          ' inner join tblproctree PPT  on PT.ParentId = PPT.ProcTreeId '+
                          ' Left join tblparts PP on PP.PARTSID = PPT.PartsId '+
                          ' Left join tblchartofaccounts on tblchartofaccounts.accountname =  if(PP.partType ="INV"  , PP.ASSETACCNT , if(PP.partType ="INV"  , PP.COGSACCNT , if(PPG.BuildStatus="W" , "DefaultBOMWastageAccount" , "Unkown"))) '+
                          ' Where PPG.Progressdate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"' +
                          ' group by PPG.ProcTreePartID, date(PPG.Progressdate) '+
                          ' having DebitsEx<>0 and CreditsEx<> 0 and CreditsEx<> DebitsEx '+
                          ' order by date(PPG.Progressdate) , Accountname , procprogressid '+
                          ' INTO OUTFILE "' + TempFile + '";');

                Add('LOAD DATA INFILE "' + TempFile + '" ' +
                           ' INTO TABLE tmpppgsummarymismatch  CHARACTER SET  UTF8   ' +
                           ' (Date , globalref, ClassID , saleID, SaleLineID, ProcTreeId, AccountName, ClientName, ClientID, ProductDesc, Productname, PRODUCTGROUP, EmployeeName, employeeid, DebitsEx , CreditsEx);');

                Add('Select 90 as Seqno,');
                Add('T.date ,');
                Add(' "Manufacturing" as type,');
                Add(' T.globalref ,');
                Add(' T.classId ,');
                Add(Idcolumn('T.saleId ','','','',''));
                Add(LineIdcolumn('T.saleLineId','T.ProctreeId ','',''));
                Add(COAColumns+',');
                Add(' T.ClientName  as ClientName ,');
                Add(' T.clientId as ClientId,');
                Add(' T.ProductDesc as ProductDesc,');
                Add(' T.Productname as Productname,');
                Add(' T.PRODUCTGROUP as PRODUCTGROUP,');
                Add(' T.EmployeeName as EmployeeName,');
                Add(' T.employeeid as employeeid,');
                Add(' "F" REconciled,');
                Add(' T.globalref as Notes,');
                Add(' ""  as TaxCode,');
                Add('0.00  as TaxRate,');
                Add('0  as TaxID,');
                Add('DebitsEx-CreditsEx as DebitsEx,');
                Add('0 as CreditsEx,');
                Add('DebitsEx-CreditsEx as Debitsinc,');
                Add('0 as Creditsinc,');
                Add('0 as "CASH_DebitsEx",');
                Add('0 as "CASH_CreditsEx",');
                Add('0 as "CASH_DebitsInc",');
                Add('0 as "CASH_CreditsInc",');
                Add('""  as `Chq/Ref`');
                Add('from tmpppgsummarymismatch T inner join tblchartofaccounts on tblchartofaccounts.accountname = t.accountname');
                if not DonotMakeTransTable then begin
                  TempFile:= NextTempFile;
                  Add('INTO OUTFILE "' + TempFile + '";');
                  Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
                end else begin
                end;
                Add('/*90-6*/ drop table if exists  tmpppgsummarymismatch;');*)

          (*Add('/*90-1*/ truncate  tmpppgsummary;');
          Add('/*90-2*/ Select s.saleId, sl.salelineId, pt.TreeRootId, ppg.Progressdate,   PT.proctreeId,');
          Add('if(ifnull(ppg.InProcProgressId,0)=0 , ppg.ProcProgressID , ppg.InProcProgressId) as ProcProgressID,');
          Add('if(PPG.Alloctype ="OUT"  , 0 , PPG.Qty* PPG.ProductUnitCost ) as debit ,');
          Add('if(PPG.Alloctype ="IN"   , 0 , PPG.Qty* PPG.ProductUnitCost ) as credit');
          Add('FROM tblsales s');
          Add('INNER JOIN tblsaleslines sl on s.saleId = sl.saleId');
          Add('INNER JOIN tblproctree pt on pt.masterid = sl.salelineid and pt.MasterType <> "mtProduct"');
          Add('INNER JOIN tblprocprogress ppg on pt.ProcTreeId = ppg.ProcTreeId');
          Add('ORDER BY ProcProgressID');
          TempFile:= NextTempFile;
          Add('INTO OUTFILE "' + TempFile + '";');
          Add('LOAD DATA INFILE "' + TempFile + '" ' +
           'INTO TABLE tmpppgsummary  CHARACTER SET  UTF8  (saleId, salelineId , TreeRootId, Progressdate , proctreeId , ProcProgressID , debit , credit);');

          Add('/*90-3*/ truncate  tmpppgsummarymismatch;');
          Add('/*90-4*/ select saleId, salelineId, ProcProgressID,TreeRootId, Progressdate ,proctreeId,  sum(debit) debit, sum(credit) as credit from tmpppgsummary group by ProcProgressID ,TreeRootId having debit-credit> 0.01');
          TempFile:= NextTempFile;
          Add('INTO OUTFILE "' + TempFile + '";');
          Add('LOAD DATA INFILE "' + TempFile + '" ' +
           'INTO TABLE tmpppgsummarymismatch  CHARACTER SET  UTF8   (saleId, salelineId, ProcProgressID,TreeRootId, Progressdate ,proctreeId,  debit, credit);');

          Add('/*90-5*/ SELECT 90 ,  date(PPGMisMatch.Progressdate) as Date ,');
          Add('"Manufacturing" as type,');
          Add('S.globalref,');
          Add('S.ClassID,');
          Add(Idcolumn('SL.saleID ','','','',''));
          Add(LineIdcolumn('SL.SaleLineID','PT.proctreeId','',''));
          Add(COAColumns+',');
          Add('S.CustomerName  as ClientName ,');
          Add('S.ClientID ,');
          Add('Convert(TreeNodeCaption(PT.Level, PT.caption ), char(255))    as ProductDesc,');
          Add('P.partname as Productname,');
          Add('P.PRODUCTGROUP  as PRODUCTGROUP ,');
          Add('S.EmployeeName,');
          Add('S.employeeid ,');
          Add('"F" REconciled,');
          Add('S.Globalref Notes,');
          Add('""  as TaxCode,');
          Add('0.00  as TaxRate,');
          Add('0  as TaxID,');
          Add('0-(PPGMisMatch.Debit-PPGMisMatch.Credit) as "DebitsEx",');
          Add('0 as "CreditsEx",');
          Add('0-(PPGMisMatch.Debit-PPGMisMatch.Credit) as "DebitsInc",');
          Add('0 as "CreditsInc",');
          Add('0 as "CASH_DebitsEx",');
          Add('0 as "CASH_CreditsEx",');
          Add('0 as "CASH_DebitsInc",');
          Add('0 as "CASH_CreditsInc",');
          Add('""  as `Chq/Ref`');

          Add('FROM tblproctree PT');
          Add('INNER JOIN tblSaleslines SL on PT.MasterId = SL.salelineId');
          Add('INNER JOIN tblsales S on S.saleId = SL.saleId');
          Add('INNER JOIN tblparts P on P.partsId = PT.PartsId');
          Add('INNER JOIN tblchartofaccounts  on P.ASSETACCNT = tblchartofaccounts.AccountName');
          {Add('INNER JOIN (select saleId, salelineId, id,TreeRootId, Progressdate ,proctreeId,  sum(debit) debit, sum(credit) as credit');
          Add('               from (Select s.saleId, sl.salelineId, pt.TreeRootId, ppg.Progressdate,   PT.proctreeId,');
          Add('               if(ifnull(ppg.InProcProgressId,0)=0 , ppg.ProcProgressID , ppg.InProcProgressId) as ID,');
          Add('               if(PPG.Alloctype ="OUT"  , 0 , PPG.Qty* PPG.ProductUnitCost ) as debit ,');
          Add('               if(PPG.Alloctype ="IN"   , 0 , PPG.Qty* PPG.ProductUnitCost ) as credit');
          Add('               FROM tblsales s');
          Add('               INNER JOIN tblsaleslines sl on s.saleId = sl.saleId');
          Add('               INNER JOIN tblproctree pt on pt.masterid = sl.salelineid and pt.MasterType <> "mtProduct"');
          Add('               INNER JOIN tblprocprogress ppg on pt.ProcTreeId = ppg.ProcTreeId');
          Add('               ORDER BY id) PPGSummary');
          Add('           group by id ,TreeRootId having debit-credit> 0.01)  PPGMisMatch on PPGMisMatch.TreeRootId = PT.proctreeId');}
          Add('INNER JOIN tmpppgsummarymismatch    PPGMisMatch on PPGMisMatch.TreeRootId = PT.proctreeId');
          Add('Where PPGMisMatch.Progressdate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');

          if not DonotMakeTransTable then begin
            TempFile:= NextTempFile;
            Add('INTO OUTFILE "' + TempFile + '";');
            Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
          end else begin
          end;
          Add('/*90-6*/ truncate  tmpppgsummary;');
          Add('/*90-7*/ truncate  tmpppgsummarymismatch;');*)
end;

procedure TTransactionTableObj.TrnsTable92(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*92*/ SELECT 92, SML.MovementDate as "Date",  ');
              Add('"Stock Movement - StS" as Type,  ');
              Add('SA.Globalref as "Global #", ');
              Add('SML.ClassID, ');
              Add(Idcolumn('SA.ID','SM.StockmovementID','','',''));
              Add(LineIdcolumn('SML.StockmovementLinesID','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('SML.Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('""  as RepName, ');
              Add('0  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(SM.Notes,1,293) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('0.00 as "DebitsEx",  ');
              Add('Value as  "CreditsEx",  ');
              Add('0.00 as "DebitsInc",  ');
              Add('Value as "CreditsInc", ');
              Add('0.00  as CASH_DebitsEx, ');
              Add('Value  as CASH_CreditsEx, ');
              Add('0.00  as CASH_DebitsInc, ');
              Add('Value as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblstockmovementlines  as SML ');
              Add('INNER JOIN tblstockmovement as SM on SM.stockmovementID = SML.stockmovementID and SM.StockmovementEntryType = "StSTags"');
              Add('INNER JOIN tblststags SA on SM.StockMovementEntryglobalref = SA.Globalref');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = SML.AccountID  ');
              Add('Where SM.Deleted<>"T" AND Value <>0.00  ');
              Add(' AND SM.MovementDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;



  end;
end;

procedure TTransactionTableObj.TrnsTable93(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
  with BulkSQL do begin
              Add('/*93*/ SELECT 93, SML.MovementDate as "Date",  ');
              Add('"Stock Movement - StS" as Type,  ');
              Add('SA.Globalref as "Global #", ');
              Add('SML.ClassID, ');
              Add(Idcolumn('SA.ID','SM.StockmovementID','','',''));
              Add(LineIdcolumn('SML.StockmovementLinesID','','',''));
              Add(COAColumns+',');
              Add('"" as ClientName, ');
              Add('0 as ClientID, ');
              Add('0 as CustomerJobId, ');
              Add('SML.Description  as ProductDesc, ');
              Add('ProductName  as ProductName, ');
              Add('""  as ProductGroup, ');
              Add('""  as RepName, ');
              Add('0  as EmployeeID, ');
              Add('"F" as Reconciled, ');
              Add('SUBSTRING(SM.Notes,1,293) as Notes, ');
              Add('""  as TaxCode, ');
              Add('0.00  as TaxRate, ');
              Add('0  as TaxID, ');
              Add('Value as "DebitsEx",  ');
              Add('0.00 as  "CreditsEx",  ');
              Add('Value as "DebitsInc",  ');
              Add('0.00 as "CreditsInc", ');
              Add('Value  as CASH_DebitsEx, ');
              Add('0.00  as CASH_CreditsEx, ');
              Add('Value  as CASH_DebitsInc, ');
              Add('0.00  as CASH_CreditsInc  ,  ');
              Add('""  as `Chq/Ref` ');
              Add('FROM tblstockmovementlines  as SML ');
              Add('INNER JOIN tblstockmovement as SM on SM.stockmovementID = SML.stockmovementID and SM.StockmovementEntryType = "StSTags"');
              Add('INNER JOIN tblststags SA on SM.StockMovementEntryglobalref = SA.Globalref');
              Add('INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = SML.AssetAccountID  ');
              Add('Where SM.Deleted<>"T" AND Value <>0.00  ');
              Add(' AND SM.MovementDate ' + BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '"');
              if not DonotMakeTransTable then begin
                TempFile:= NextTempFile;
                Add('INTO OUTFILE "' + TempFile + '";');
                Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
              end else begin
                Add(';');
                (*Add(' limit 1 union all');*)
              end;

  end;
end;

procedure TTransactionTableObj.TrnsTable94(BulkSQL: TStringList;  DonotMakeTransTable: Boolean);
begin
  // use 92 for next type transaction
end;

(*procedure TTransactionTableObj.TrnsTable91(BulkSQL: TStringList;DonotMakeTransTable:Boolean =False);
begin
    with BulkSQL do begin
      Add('Drop table if exists tmp_1;');
      Add('Create table '+NextTableName+' SELECT '+
          ' trans.type , trans.Globalref,Date, classId, '+
          ' sum(DebitsEx) as DebitsEx , '+
          ' sum(CreditsEx) as CreditsEx , '+
          ' sum(DebitsInc ) as DebitsInc , '+
          ' sum(CreditsInc ) as CreditsInc , '+
          ' sum(Cash_DebitsEx) as Cash_DebitsEx  , '+
          ' sum(Cash_CreditsEx ) as Cash_CreditsEx , '+
          ' sum(Cash_DebitsInc) as Cash_DebitsInc  , '+
          ' sum(Cash_CreditsInc ) as Cash_CreditsInc '+
          ' FROM '+ TableName +' as Trans '+
          ' group by  classId, date, trans.type , trans.Globalref '+
          ' having abs(round(DebitsEx- creditsEx , 5))>0 or '+
          ' abs(round(Debitsinc- creditsinc , 5))>0;');

      Add('/*91*/ SELECT 91, T.Date as "Date", ');
      Add('T.Type as Type, ');
      Add('T.GlobalRef as "Global #", ');
      Add('T.ClassId, ');
      Add(Idcolumn('','','','',''));
      Add(LineIdcolumn('','','',''));
      Add(COAColumns+',');
      Add('"" as ClientName, ');
      Add('0 as ClientID, ');
      Add('0 as CustomerJobId, ');
      Add('"" as ProductDesc, ');
      Add('""  as ProductName, ');
      Add('""  as ProductGroup, ');
      Add('"" as RepName, ');
      Add('"" as EmployeeID, ');
      Add('"F" as Reconciled, ');
      Add('"" as Notes, ');
      Add('""  as TaxCode, ');
      Add('"" as TaxRate, ');
      Add('0  as TaxID, ');
      Add('0-T.DebitsEx as DebitsEx, ');
      Add('0-T.CreditsEx as CreditsEx, ');
      Add('0-T.DebitsInc as DebitsInc, ');
      Add('0-T.CreditsInc as CreditsInc, ');
      Add('0-T.CASH_DebitsEx  as CASH_DebitsEx, ');
      Add('0-T.CASH_CreditsEx  as CASH_CreditsEx, ');
      Add('0-T.CASH_DebitsInc  as CASH_DebitsInc, ');
      Add('0-T.CASH_CreditsInc  as CASH_CreditsInc  , ');
      Add('""  as `Chq/Ref` ');
      Add('FROM '+NextTableName+' T, tblchartofaccounts  where  tblchartofaccounts.AccountName ="Stock Adjustment" ');
      if not DonotMakeTransTable then begin
        TempFile:= NextTempFile;
        Add('INTO OUTFILE "' + TempFile + '";');
        Add('LOAD DATA INFILE "' + TempFile + '" ' + LOAD_INTO_String + ';');
      end else begin
      end;
      Add('Drop table if exists '+NextTableName+';');
    end;
end;*)
procedure TTransactionTableObj.StepProgressDlg(Acaption: String);
begin
  if Assigned(ProgressDlg) then begin
    if Acaption <> '' then ProgressDlg.Message := Acaption;
    ProgressDlg.StepIt;
  end;
end;

Function TTransactionTableObj.StripNewLine(const Value:String):String;
begin
   result := replacestr(replacestr(Value , chr(13), ' '), chr(10), ' ');

end;
destructor TTransactionTableObj.Destroy;
begin
  ClearClasses;
  FreeandNil(fLstClass);
  ClearFCs;
  FreeandNil(fLstFC);
  If Assigned(TableFunctions) then FreeAndNil(TableFunctions);
  If Assigned(qryPOs) then FreeAndNil(qryPOs);
  If Assigned(qryTemp) then FreeAndNil(qryTemp);
  If Assigned(qryParts) then FreeAndNil(qryParts);
  If Assigned(qryTempExec) then FreeAndNil(qryTempExec);
  If Assigned(BulkSQL) then FreeAndNil(BulkSQL);
  Freeandnil(UserLock);
  fOwnedProgressDlg.Free;
  AppEnvVirt.Obj['ProgressInfo'].Free;
  AppEnvVirt.Obj['ProgressInfo'] := nil;
  inherited;
end;

function TTransactionTableObj.Devmode: Boolean;
begin
  REsult := AppEnvVirt.Bool['CommonLib.DevMode'] ;
end;

procedure TTransactionTableObj.ClearFCs;
var
  i: integer;
begin
 If not Assigned(fLstFC) then exit;
  for i := 0 to fLstFC.Count - 1 do
    Dispose(fLstFC.Items[i]);
  fLstFC.Clear;
end;
function TTransactionTableObj.COAColumns(COAQry:TERPQuery=nil): string;
begin
  if (COAQry <> nil) and (COAQry.Active) and (COAQry.RecordCount=1) then begin
      result := quotedstr(COAQry.fieldbyname('AccountName').AsString        ) +' as AccountName,'+
                quotedstr(COAQry.fieldbyname('AccountGroupLevels').AsString ) +' as AccountGroupLevels,'+
                quotedstr(COAQry.fieldbyname('Level1').AsString             ) +' as Level1,'+
                quotedstr(COAQry.fieldbyname('Level2').AsString             ) +' as Level2,'+
                quotedstr(COAQry.fieldbyname('Level3').AsString             ) +' as Level3,'+
                quotedstr(COAQry.fieldbyname('Level4').AsString             ) +' as Level4,'+
                inttostr(COAQry.fieldbyname('AccountID').AsInteger          ) +' as AccountID,' +
                quotedstr(COAQry.fieldbyname('AccountType').AsString        ) +' as AccountType';
  end else begin
      result := 'tblchartofaccounts.AccountName as AccountName,'+
                AccountName ('tblchartofaccounts')+ ' as AccountGroupLevels ,' +
                Firstcolumn('tblchartofaccounts')  +' as Level1,'+
                Secondcolumn('tblchartofaccounts') +' as Level2,'+
                Thirdcolumn('tblchartofaccounts')  +' as Level3,'+
                forthcolumn('tblchartofaccounts')  +' as Level4,'+
                'tblchartofaccounts.AccountID,'+
                'tblchartofaccounts.AccountType';
  end;
end;

procedure TTransactionTableObj.ClearClasses;
var
  i: integer;
begin
  If not Assigned(fLstClass) then exit;
  for i := 0 to fLstClass.Count - 1 do
    Dispose(fLstClass.Items[i]);
  fLstClass.Clear;
end;

function TTransactionTableObj.GetSubLevelIDs(const ClassID: integer): string;
var
  qryTemp: TERPQuery;
  TempIDs: string;
  ClassName: string;
begin
  TempIDs := '';
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection :=
    TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  qryTemp.ParamCheck := false;
  try
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT ClassName from tblClass where ClassId = ' + IntToStr(ClassID));
    qryTemp.Open;
    ClassName := qryTemp.FieldByName('ClassName').AsString;
    qryTemp.Close;

    qryTemp.SQL.Clear;
    qryTemp.Sql.Add('SELECT ClassID FROM tblclass WHERE Level1 = ' + QuotedStr(ClassName) + ';');
    qryTemp.Active := true;
    qryTemp.First;
    while not qryTemp.Eof do begin
      TempIDs := TempIDs + qryTemp.FieldByName('ClassID').AsString + ',';
      qryTemp.Next;
    end;
    qryTemp.Active := false;
    qryTemp.SQL.Clear;
    qryTemp.Sql.Add('SELECT ClassID FROM tblclass WHERE Level2 = ' + QuotedStr(ClassName) + ';');
    qryTemp.Active := true;
    qryTemp.First;
    while not qryTemp.Eof do begin
      TempIDs := TempIDs + qryTemp.FieldByName('ClassID').AsString + ',';
      qryTemp.Next;
    end;
    qryTemp.Active := false;
    qryTemp.SQL.Clear;
    qryTemp.Sql.Add('SELECT ClassID FROM tblclass WHERE Level3 = ' + QuotedStr(ClassName) + ';');
    qryTemp.Active := true;
    qryTemp.First;
    while not qryTemp.Eof do begin
      TempIDs := TempIDs + qryTemp.FieldByName('ClassID').AsString + ',';
      qryTemp.Next;
    end;
    qryTemp.Active := false;
    qryTemp.SQL.Clear;
    qryTemp.Sql.Add('SELECT ClassID FROM tblclass WHERE Level4 = ' + QuotedStr(ClassName) + ';');
    qryTemp.Active := true;
    qryTemp.First;
    while not qryTemp.Eof do begin
      TempIDs := TempIDs + qryTemp.FieldByName('ClassID').AsString + ',';
      qryTemp.Next;
    end;
    qryTemp.Active := false;
    TempIDs        := LeftStr(TempIDs, Length(TempIDs) - 1);
    Result         := TempIDs;
  finally
    FreeAndNil(qryTemp);
  end;
end;
procedure TTransactionTableObj.HideProgressdlg;
begin
  if Assigned(ProgressDlg) then begin
    ProgressDlg.CloseDialog;
  end;
end;

function TTransactionTableObj.LineIdcolumn(Const SLID,POLID,PayLId,PrePayLid:String):String;
var
  s:String;
begin
  s:= '';
  try
    if SLID      <> '' then s:= s+ SLID      +' as SaleLineId, '           else s:= s+'0 as SaleLineId,';
    if POLID     <> '' then s:= s+ POLID     +' as PurchaselineID, '       else s:= s+'0 as PurchaselineID,';
    if PayLId    <> '' then s:= s+ PayLId    +' as PaymentLineID, '        else s:= s+'0 as PaymentLineID,';
    if PrePayLid <> '' then s:= s+ PrePayLid +' as PrePaymentlineID, '     else s:= s+'0 as PrePaymentlineID,';
  finally
    result := s;
  end;


end;
function TTransactionTableObj.Idcolumn(const SaleID, poID, PayId, PrePayid,FAID: String): String;
var
  s:String;
begin
  s:= '';
  try
    if SaleId   <> '' then s:= s+ saleId   +' as SaleId, '           else s:= s+'0 as SaleID,';
    if poID     <> '' then s:= s+ poID     +' as PurchaseOrderID, '  else s:= s+'0 as PurchaseOrderID,';
    if PayId    <> '' then s:= s+ PayId    +' as PaymentID, '        else s:= s+'0 as PaymentID,';
    if PrePayid <> '' then s:= s+ PrePayid +' as PrepaymentID, '     else s:= s+'0 as PrepaymentID,';
    if FAID     <> '' then s:= s+ FAID     +' as FixedAssetID, '     else s:= s+'0 as FixedAssetID,';
  finally
    result := s;
  end;
end;

procedure TTransactionTableObj.InitforRefreshTrnsTable;
begin
  SetEmptyglobalref;
  SetproctreeNodesSelected;
end;

procedure TTransactionTableObj.InvAssetPostings(BulkSQL: TStringlist; tablename :String; ProductName:String = '');
const
  Fields ='(Seqno,Date,PQAID,Type,ClassID,'+
            'SaleId,PurchaseOrderID,PaymentID,PrepaymentID,FixedAssetID,'+
            'SaleLineId,PurchaselineID,PaymentLineID,PrePaymentlineID,'+
            'AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,AccountID,AccountType,'+
            'ProductName,'+
            'Actualtotalcost,DebitsEx,CreditsEx,DebitsInc,CreditsInc,aDebitsEx,aCreditsEx,aDebitsInc,aCreditsInc) ';
  Function Productfilter(Productfieldname:String):String;
  begin
    result := '';
    if ProductName = '' then exit;
    Result := ' AND ' + Productfieldname +' = ' +quotedstr(ProductName);
  end;
begin
  with BulkSQL do begin
                Add('Insert ignore into '+ tablename + ' ' + Fields + ' SELECT 25, tblSales.SaleDate as "Date", '+
                    ' TransPQA.PQAID, '+
                    ' "Invoice" as Type, '+
                    ' tblSales.ClassID, '+
                    Idcolumn('tblSales.SaleID','','','','')+
                    LineIdcolumn('tblSalesLines.SaleLineID','','','')+
                    COAColumns+','+
                    ' tblSalesLines.ProductName  as ProductName, '+
                    ' TransPQA.Actualtotalcost,'+
                    ' 0.00 as "DebitsEx", '+
                    RoundTocurrency('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "CreditsEx", '+
                    ' 0.00 as "DebitsInc", '+
                    RoundTocurrency('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "CreditsInc",'+
                    ' 0.00 as "aDebitsEx", '+
                    RoundTocurrency('TransPQA.Actualtotalcost- If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "aCreditsEx", '+
                    ' 0.00 as "aDebitsInc", '+
                    RoundTocurrency('TransPQA.Actualtotalcost- If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "aCreditsInc"'+
                    '  FROM tblSales  '+
                    '  INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID '+
                    '  INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = tblSalesLines.ASSETACCNTID  '+
                    '  INNER JOIN tbltransactionpqas TransPQA on TransPQA.transId =tblSalesLines.SaleID and TransPQA.translineId =tblSalesLines.saleLineId and TransPQA.Transtype in (' +SalesTransTypes+')'+
                    '  WHERE tblSales.IsInvoice="T" AND tblSales.IsSalesOrder="F" AND tblSales.IsQuote="F" AND tblSales.Deleted="F" '+
                    '  AND tblSalesLines.Invoiced="T" AND (PARTTYPE = "INV")' + Productfilter('tblSalesLines.ProductName') +';');


                Add('Insert ignore into '+ tablename + ' ' + Fields + ' SELECT 26, tblSales.SaleDate as "Date", '+
                    ' TransPQA.PQAID, '+
                    ' "Cash Sale" as Type, '+
                    ' tblSales.ClassID, '+
                    Idcolumn('tblSales.SaleID','','','','')+
                    LineIdcolumn('tblSalesLines.SaleLineID','','','')+
                    COAColumns+','+
                    ' tblSalesLines.ProductName  as ProductName, '+
                    ' TransPQA.Actualtotalcost,'+
                    ' 0.00 as "DebitsEx", '+
                    RoundTocurrency(' If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "CreditsEx", '+
                    ' 0.00 as "DebitsInc", '+
                    RoundTocurrency(' If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "CreditsInc",'+
                    ' 0.00 as "aDebitsEx", '+
                    RoundTocurrency('TransPQA.Actualtotalcost- If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "aCreditsEx", '+
                    ' 0.00 as "aDebitsInc", '+
                    RoundTocurrency('TransPQA.Actualtotalcost- If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "aCreditsInc"'+
                    '  FROM tblSales '+
                    '  INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID '+
                    '  INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = tblSalesLines.ASSETACCNTID  '+
                    '  INNER JOIN tbltransactionpqas TransPQA on TransPQA.transId =tblSalesLines.SaleID and TransPQA.translineId =tblSalesLines.saleLineId and TransPQA.Transtype in (' +SalesTransTypes+')'+
                    '  WHERE (PARTTYPE = "INV"  ) AND (tblSales.IsCashSale="T") AND tblSalesLines.Invoiced="T" '+
                    '  AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F" ' + Productfilter('tblSalesLines.ProductName') +'; ');

                Add('Insert ignore into '+ tablename + ' ' + Fields + ' SELECT 27, tblSales.SaleDate as "Date", '+
                    ' TransPQA.PQAID, '+
                    ' "Refund" as Type, '+
                    ' tblSales.ClassID, '+
                    Idcolumn('tblSales.SaleID','','','','')+
                    LineIdcolumn('tblSalesLines.SaleLineID','','','')+
                    COAColumns+','+
                    ' tblSalesLines.ProductName  as ProductName, '+
                    ' TransPQA.Actualtotalcost,'+
                    RoundTocurrency('If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,-tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "DebitsEx", '+
                    ' 0.00 as "CreditsEx", '+
                    RoundTocurrency(' If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,-tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "DebitsInc", '+
                    ' 0.00 as "CreditsInc",'+
                    RoundTocurrency('TransPQA.Actualtotalcost- If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,-tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "aDebitsEx", '+
                    ' 0.00 as "aCreditsEx", '+
                    RoundTocurrency('TransPQA.Actualtotalcost- If(tblSalesLines.LineCost*tblSalesLines.Shipped<>0.00 ,-tblSalesLines.LineCost*tblSalesLines.Shipped,0.00)')+' as "aDebitsInc", '+
                    ' 0.00 as "aCreditsInc"'+
                    '  FROM tblSales '+
                    '  INNER JOIN tblSalesLines ON tblSalesLines.SaleID = tblSales.SaleID '+
                    '  INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = tblSalesLines.ASSETACCNTID  '+
                    '  INNER JOIN tbltransactionpqas TransPQA on TransPQA.transId =tblSalesLines.SaleID and TransPQA.translineId =tblSalesLines.saleLineId and TransPQA.Transtype in (' +SalesTransTypes+')'+
                    '  WHERE (PARTTYPE = "INV"  ) AND (tblSales.IsRefund ="T") AND tblSalesLines.Invoiced="T" '+
                    '  AND tblSales.IsSalesOrder="F" And tblSales.IsQuote="F" AND tblSales.Deleted="F" ' + Productfilter('tblSalesLines.ProductName') +'; ');

                Add('Insert ignore into '+ tablename + ' ' + Fields + ' SELECT 39,SM.MovementDate as "Date", '+
                    ' TransPQA.PQAID, '+
                    ' "Stock Transfer" as Type, '+
                    ' SML.ClassId, '+
                    Idcolumn('ST.TransferEntryID','SM.StockmovementID','','','')+
                    LineIdcolumn('SML.StockmovementLinesID','','','')+
                    COAColumns+','+
                    ' SML.ProductName  as ProductName, '+
                    ' TransPQA.Actualtotalcost,'+
                    ' 0.00 as DebitsEx, '+
                    RoundTocurrency('(ifnull(abs(SML.Qty*cost),0))')+' as CreditsEx, '+
                    ' 0.00 as DebitsInc, '+
                    RoundTocurrency('(ifnull(abs(SML.Qty*Cost),0))')+' as CreditsInc, '+
                    ' 0.00 as aDebitsEx, '+
                    RoundTocurrency('(ifnull(abs(TransPQA.Actualtotalcost - SML.Qty*cost),0))')+' as aCreditsEx, '+
                    ' 0.00 as aDebitsInc, '+
                    RoundTocurrency('(ifnull(abs(TransPQA.Actualtotalcost - SML.Qty*Cost),0))')+' as aCreditsInc '+

                    '  FROM tblStockMovementLines as SML '+
                    '  INNER JOIN tbltransactionpqas TransPQA on TransPQA.transId =SML.StockmovementID and TransPQA.translineId =SML.StockmovementLinesID and TransPQA.Transtype in (' +StockMovementtypes+')'+
                    '  INNER JOIN tblstockmovement as SM on SM.stockmovementID = SML.stockmovementID and SM.StockmovementEntryType = "StockTransferEntry" '+
                    '  INNER join tblPQA pqa on pqa.transId = SML.StockmovementID and PQA.translineId = SML.StockmovementLinesID and PQA.transtype = "TStockMovementLines" and if(Alloctype="OUT", 0-PQA.Qty, PQA.QTY)<0' +
                    '  INNER JOIN tblstocktransferentry ST on SM.StockMovementEntryglobalref = ST.Globalref'+
                    '  INNER JOIN tblParts On tblParts.PartsID = SML.ProductID '+
                    '  INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = SML.AssetAccountID '+
                    '  WHERE SM.Deleted<>"T" ' + Productfilter('SML.ProductName') +'; ');


                Add('Insert ignore into '+ tablename + ' ' + Fields + ' SELECT 40, SM.MovementDate as "Date", '+
                    ' TransPQA.PQAID, '+
                    ' "Stock Transfer" as Type, '+
                    ' SML.ClassId, '+
                    Idcolumn('ST.TransferEntryID','SM.StockmovementID','','','')+
                    LineIdcolumn('SML.StockmovementLinesID','','','')+
                    COAColumns+','+
                    ' SML.ProductName  as ProductName, '+
                    ' TransPQA.Actualtotalcost,'+
                    RoundTocurrency('(ifnull(abs( SML.Qty*cost),0))')+'  as DebitsEx, '+
                    ' 0.00             as CreditsEx, '+
                    RoundTocurrency('(ifnull(abs( SML.Qty*cost),0))')+'  as DebitsInc, '+
                    ' 0.00             as CreditsInc, '+
                    RoundTocurrency('(ifnull(abs(TransPQA.Actualtotalcost - SML.Qty*cost),0))')+'  as aDebitsEx, '+
                    ' 0.00             as aCreditsEx, '+
                    RoundTocurrency('(ifnull(abs(TransPQA.Actualtotalcost - SML.Qty*cost),0))')+'  as aDebitsInc, '+
                    ' 0.00             as aCreditsInc '+

                    ' FROM tblStockMovementLines as SML '+
                    ' INNER JOIN tbltransactionpqas TransPQA on TransPQA.transId =SML.StockmovementID and TransPQA.translineId =SML.StockmovementLinesID and TransPQA.Transtype in (' +StockMovementtypes+')'+
                    ' INNER JOIN tblstockmovement as SM on SM.stockmovementID = SML.stockmovementID and SM.StockmovementEntryType = "StockTransferEntry" '+
                    ' INNER join tblPQA pqa on pqa.transId = SML.StockmovementID and PQA.translineId = SML.StockmovementLinesID and PQA.transtype = "TStockMovementLines" and if(Alloctype="OUT", 0-PQA.Qty, PQA.QTY)>0 '+
                    ' INNER JOIN tblstocktransferentry ST on SM.StockMovementEntryglobalref = ST.Globalref'+
                    ' INNER JOIN tblParts On tblParts.PartsID = SML.ProductID '+
                    ' INNER JOIN tblchartofaccounts ON  tblchartofaccounts.AccountID = SML.AssetAccountID '+
                    ' WHERE SM.Deleted<>"T" ' + Productfilter('SML.ProductName') +';');

                Add('Insert ignore into '+ tablename + ' ' + Fields + ' SELECT 55, SM.MovementDate as "Date",  '+
                    ' TransPQA.PQAID, '+
                    ' "Stock Adjustment" as Type,  '+
                    ' SML.ClassID, '+
                    Idcolumn('SA.StockAdjustEntryID','SM.StockmovementID','','','')+
                    LineIdcolumn('SML.StockmovementLinesID','','','')+
                    COAColumns+','+
                    ' SML.ProductName  as ProductName, '+
                    ' TransPQA.Actualtotalcost,'+
                    RoundTocurrency(' Value')+' as "DebitsEx",  '+
                    ' 0.00 as  "CreditsEx",  '+
                    RoundTocurrency(' Value')+' as "DebitsInc",  '+
                    ' 0.00 as "CreditsInc", '+
                    RoundTocurrency('TransPQA.Actualtotalcost - Value')+' as "aDebitsEx",  '+
                    ' 0.00 as  "aCreditsEx",  '+
                    RoundTocurrency('TransPQA.Actualtotalcost - Value')+' as "aDebitsInc",  '+
                    ' 0.00 as "aCreditsInc" '+
                    ' FROM tblstockmovementlines  as SML '+
                    ' INNER JOIN tbltransactionpqas TransPQA on TransPQA.transId =SML.StockmovementID and TransPQA.translineId =SML.StockmovementLinesID and TransPQA.Transtype in (' +StockMovementtypes+')'+
                    ' INNER JOIN tblstockmovement as SM on SM.stockmovementID = SML.stockmovementID and SM.StockmovementEntryType = "StockAdjustEntry"'+
                    ' INNER JOIN tblstockadjustentry SA on SM.StockMovementEntryglobalref = SA.Globalref'+
                    ' INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = SML.AssetAccountID  '+
                    ' Where SM.Deleted<>"T" AND Value <>0.00  ' + Productfilter('SML.ProductName') +';  ');

                Add('Insert ignore into '+ tablename + ' ' + Fields + ' SELECT 71, tblAccountPosting.Date as "Date", '+
                    ' TransPQA.PQAID, '+
                    ' tblAccountPosting.SourceName as Type, '+
                    ' APD.ClassID, '+
                    Idcolumn('tblSalesLines.SaleId','','','','')+
                    LineIdcolumn('tblSalesLines.SaleLineID','APD.AccountPostingDetailId','APD.SourceLineID','')+
                    COAColumns+','+
                    ' APD.Productname  as ProductName, '+
                    ' TransPQA.Actualtotalcost,'+

                    RoundTocurrency(' APD.DebitAmount')+'  as "DebitsEx", '+
                    RoundTocurrency(' APD.CreditAmount')+' as "CreditsEx", '+
                    RoundTocurrency(' APD.DebitAmount')+'  as "DebitsInc", '+
                    RoundTocurrency(' APD.CreditAmount')+' as "CreditsInc",'+
                    RoundTocurrency('if(APD.CreditDebittype="C" and transtype <>"TProcTreePartIN"  AND not (transtype ="TProcTreePart" and alloctype ="IN"), 0, TransPQA.Actualtotalcost )-  APD.DebitAmount')+'  as "aDebitsEx", '+
                    RoundTocurrency('if(APD.CreditDebittype="D" or  transtype = "TProcTreePartIN"  or      (transtype ="TProcTreePart" and alloctype ="IN"), 0, TransPQA.Actualtotalcost )-  APD.CreditAmount')+' as "aCreditsEx", '+
                    RoundTocurrency('if(APD.CreditDebittype="C" and transtype <>"TProcTreePartIN"  AND not (transtype ="TProcTreePart" and alloctype ="IN"), 0, TransPQA.Actualtotalcost )-  APD.DebitAmount')+'  as "aDebitsInc", '+
                    RoundTocurrency('if(APD.CreditDebittype="D" or  transtype = "TProcTreePartIN"  or      (transtype ="TProcTreePart" and alloctype ="IN"), 0, TransPQA.Actualtotalcost )-  APD.CreditAmount')+' as "aCreditsInc"'+

                    ' FROM tblAccountPosting  '+
                    ' INNER JOIN tblAccountPostingDetail APD ON APD.AccountPostingID = tblAccountPosting.AccountPostingID and APD.parttype ="INV" '+
                    ' INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = APD.AccountID '+
                    ' INNER JOIN tblproctreepart PTP     ON APD.SourcelineID = PTP.ProcTreePartId'+
                    ' inner join tblprocTree PT on PT.proctreeId = PTP.proctreeID'+
                    ' INNER JOIN tblSalesLines           ON tblSalesLines.SaleLineId = PT.MasterId'+
                    ' INNER JOIN tbltransactionpqas TransPQA on TransPQA.TransLineID = ptp.ProcTreePartId and TransPQA.transtype = "TProcTreePart"  '+
                    ' WHERE (tblAccountPosting.Active="T") ' + Productfilter('APD.Productname') +';');


                Add('Insert ignore into '+ tablename + ' ' + Fields + ' SELECT 71, tblAccountPosting.Date as "Date", '+
                    ' TransPQA.PQAID, '+
                      ' tblAccountPosting.SourceName as Type, '+
                      ' APD.ClassID, '+
                      Idcolumn('tblSalesLines.SaleId','','','','')+
                      LineIdcolumn('tblSalesLines.SaleLineID','APD.AccountPostingDetailId','APD.SourceLineID','')+
                      COAColumns+','+
                      ' APD.Productname  as ProductName, '+
                      ' TransPQA.Actualtotalcost ,'+
                      RoundTocurrency('APD.DebitAmount')+'  as "DebitsEx", '+
                      RoundTocurrency('APD.CreditAmount')+' as "CreditsEx", '+
                      RoundTocurrency(' APD.DebitAmount')+'  as "DebitsInc", '+
                      RoundTocurrency(' APD.CreditAmount')+' as "CreditsInc",'+
                      RoundTocurrency('if(APD.CreditDebittype="C" and transtype <>"TProcTreePartIN" AND not (transtype ="TProcTreePart" and alloctype ="IN"), 0, TransPQA.Actualtotalcost )-  APD.DebitAmount')+'  as "aDebitsEx", '+
                      RoundTocurrency('if(APD.CreditDebittype="D" or  transtype = "TProcTreePartIN" or      (transtype ="TProcTreePart" and alloctype ="IN"), 0, TransPQA.Actualtotalcost )-  APD.CreditAmount')+' as "aCreditsEx", '+
                      RoundTocurrency('if(APD.CreditDebittype="C" and transtype <>"TProcTreePartIN" AND not (transtype ="TProcTreePart" and alloctype ="IN"), 0, TransPQA.Actualtotalcost )-  APD.DebitAmount')+'  as "aDebitsInc", '+
                      RoundTocurrency('if(APD.CreditDebittype="D" or  transtype = "TProcTreePartIN" or      (transtype ="TProcTreePart" and alloctype ="IN"), 0, TransPQA.Actualtotalcost )-  APD.CreditAmount')+' as "aCreditsInc"'+
                      ' FROM tblAccountPosting  '+
                      ' INNER JOIN tblAccountPostingDetail APD ON APD.AccountPostingID = tblAccountPosting.AccountPostingID and APD.parttype <> "INV"'+
                      ' INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountID = APD.AccountID '+
                      ' INNER JOIN tblproctreepart PTP     ON APD.SourcelineID = PTP.ProcTreePartId'+
                      ' inner join tblprocTree PT on PT.proctreeId = PTP.proctreeID'+
                      ' INNER JOIN tblSalesLines           ON tblSalesLines.SaleLineId = PT.MasterId'+
                      ' inner JOIN tbltransactionpqas TransPQA on TransPQA.TransLineID = ptp.ProcTreePartId and TransPQA.transtype in ( "TProcTreePart"  )'+
                      ' WHERE (tblAccountPosting.Active="T") ' + Productfilter('APD.Productname') +';');

                Add('Insert ignore into '+ tablename + ' ' + Fields + ' Select 86 , ' +
                      ' PPG.Progressdate as Date , ' +
                      ' PQa.PQAID, ' +
                      ' "Manufacturing" as type, ' +
                      ' PPG.ClassID, ' +
                      Idcolumn('SL.saleID ','','','','')+ // Add('SL.saleID , 0 as PurchaseOrderID,0 as PaymentID,0 as PrepaymentID,0 as FixedAssetID, ');
                      LineIdcolumn('SL.SaleLineID','PPG.ProcProgressID ','','')+ // Add('SL.SaleLineID as SaleLineId, PPG.ProcProgressID as PurchaselineID, 0 as PaymentLineID, 0 as PrePaymentlineID, ');
                      COAColumns+','+
                      ' P.partname as Productname, ' +
                      ' PQA.Actualtotalcost, ' +
                      ' Round( if(PPG.Alloctype ="IN"  , 0 , PPG.Qty* PPG.ProductUnitCost ),0) as "DebitsEx", ' +
                      ' Round( if(PPG.Alloctype ="OUT" , 0 , PPG.Qty* PPG.ProductUnitCost ),0) as "CreditsEx", ' +
                      ' Round( if(PPG.Alloctype ="IN"  , 0 , PPG.Qty* PPG.ProductUnitCost ),0) as "DebitsInc", ' +
                      ' Round( if(PPG.Alloctype ="OUT" , 0 , PPG.Qty* PPG.ProductUnitCost ),0) as "CreditsInc", ' +
                      ' Round( PQA.Actualtotalcost - if(PPG.Alloctype ="IN"  , 0 , PPG.Qty* PPG.ProductUnitCost ),0) as "aDebitsEx", ' +
                      ' Round( PQA.Actualtotalcost - if(PPG.Alloctype ="OUT" , 0 , PPG.Qty* PPG.ProductUnitCost ),0) as "aCreditsEx", ' +
                      ' Round( PQA.Actualtotalcost - if(PPG.Alloctype ="IN"  , 0 , PPG.Qty* PPG.ProductUnitCost ),0) as "aDebitsInc", ' +
                      ' Round( PQA.Actualtotalcost - if(PPG.Alloctype ="OUT" , 0 , PPG.Qty* PPG.ProductUnitCost ),0) as "aCreditsInc" ' +
                      ' from tblprocprogress PPG ' +
                      ' inner join tblproctreepart PP on PP.ProcTreePartId = PPG.ProcTreePartID ' +
                      ' inner join tblproctree PT on PT.ProcTreeId = PP.ProcTreeId ' +
                      ' inner join tblSaleslines SL on PT.MasterId = SL.salelineId ' +
                      ' inner join tblparts P on P.partsId = PPG.ProductID ' +
                      ' inner join tblchartofaccounts on P.ASSETACCNT = tblchartofaccounts.AccountName ' +
                      ' inner join tbltransactionpqas pqa on pqa.transLineId = PPG.ProcProgressID and PQa.transtype in ("TProcProgressIn" , "TProcProgressOUT") ;' );
  end;

end;

procedure TTransactionTableObj.GetFCs;
var
    pFC :pFCRec;
    qryFC :TERPQuery;
begin
  ClearFCs;
  qryFC := TERPQuery.Create(nil);
  qryFC.Options.FlatBuffers := True;
  qryFC.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  qryFC.ParamCheck := false;
  try
    qryFC.Sql.Clear;
    qryFC.Sql.Add('SELECT CurrencyID,Code ');
    qryFC.Sql.Add('FROM tblcurrencyconversion ');
    qryFC.Sql.Add('where active = "T" ');
    qryFC.Sql.Add('and code <>' + quotedStr(AppenvVirt.Str['RegionalOptions.ForeignExDefault']));
    qryFC.Sql.Add('Order By Code');
    qryFC.Open;
    if not qryFC.IsEmpty then begin
      qryFC.First;
      while not qryFC.Eof do begin
        New(pFC);
        fLstFC.Add(pFC);
        pFC^.FCID := qryFC.FieldByName('CurrencyID').AsInteger;
        pFC^.FCCode := qryFC.FieldByName('Code').AsString;
        qryFC.Next;
      end;
    end;
  finally
    FreeAndNil(qryFC);
  end;
end;

function TTransactionTableObj.GetGLTaxCodeIDForName(const TaxCodeName: String): Integer;
begin
  with TERPQuery.Create(nil) do
  begin
    Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    try
      SQL.Text := 'SELECT TaxCodeID FROM tbltaxcodes WHERE Name = ' +
        QuotedStr(TaxCodeName) + ' AND RegionID=' +
        IntToStr(AppEnvVirt.Int['RegionalOptions.ID']) + ';';
      Open;
      Result := fieldByname('TaxCodeID').asInteger;
    finally
      Free;
    end;
  end;
end;

function TTransactionTableObj.GetProgressDlg: TProgressInfo;
begin
  if IsGUI then
    result := TProgressInfo(AppEnvVirt.Obj['ProgressInfo'])
  else
    result := nil;
end;

function TTransactionTableObj.GetAccountID(const AccountName: string): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    qry.SQL.Add('SELECT AccountID from tblChartOfAccounts where AccountName = ' + QuotedStr(AccountName));
    qry.Open;
    result := qry.FieldByName('AccountID').AsInteger;
  finally
    qry.Free;
  end;
end;

procedure TTransactionTableObj.GetClasses(SelectedDepartments: TStrings= nil; includeInactive:Boolean =True);
var
  pClass: pClassRec;
  qryClass: TERPQuery;
begin
  ClearClasses;
  SetClassLevelField;
  qryClass := TERPQuery.Create(nil);
  qryClass.Options.FlatBuffers := True;
  qryClass.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  qryClass.ParamCheck := false;
  try
    qryClass.Sql.Clear;
    qryClass.Sql.Add('SELECT ClassID, ClassName, ');
    qryClass.Sql.Add('SUBSTRING(If((char_length(tblClass.ClassGroup)>0),Concat(REPLACE(tblClass.ClassGroup,"^"," - ")," - ",tblClass.ClassName),tblClass.ClassName),1,255) as "FullClassName", ');
    qryClass.Sql.Add('Active FROM tblClass Where Trim(ClassName)<>"" ');
    if AppEnvVirt.Bool['CompanyPrefs.ShowActiveClassOnReports']       then  qryClass.Sql.Add('AND Active="T"');
    if (SelectedDepartments <> nil) and (SelectedDepartments.count>0) then qryClass.Sql.Add('AND Classid in ('+ SelectedDepartments.commatext+')');
    if not(includeInactive) then qryClass.Sql.Add('AND Active ="T"');
    qryClass.Sql.Add('Order By FullClassName');
    qryClass.Open;
    if not qryClass.IsEmpty then begin
      qryClass.First;
      while not qryClass.Eof do begin
        New(pClass);
        fLstClass.Add(pClass);
        pClass^.ClassID := qryClass.FieldByName('ClassID').AsInteger;
        pClass^.ClassName := qryClass.FieldByName('ClassName').AsString;
        pClass^.SubLevelIDs := GetSubLevelIDs(qryClass.FieldByName('ClassID').AsInteger);
        pClass^.Active := qryClass.FieldByName('Active').asBoolean;
        qryClass.Next;
      end;
    end;
  finally
    FreeAndNil(qryClass);
  end;
end;

procedure TTransactionTableObj.AddReconcileFlags;
var
  qryBankDep: TERPQuery;
  qryRecon: TERPQuery;
  Reconciled: boolean;
  Save_Cursor: TCursor;

  function IsReconciled(const ID, Fieldname, TrnsType, AccountID: string; Const qryRecon: TERPQuery; const MasterAndDetails: boolean = false): boolean;
  begin
    with qryRecon do begin
      qryRecon.Close;
      qryRecon.Sql.Clear;
      qryRecon.Sql.Add('SELECT Reconciled  FROM tblbankdepositlines Where ' + Fieldname + ' = ' + ID + '');
      if Trim(TrnsType) <> '' then begin
        qryRecon.Sql.Add(' AND TrnsType = "' + TrnsType + '" ');
      end;
      qryRecon.Sql.Add(' AND AccountID = "' + AccountID + '" ');
      qryRecon.Open;
      if qryRecon.RecordCount > 0 then begin
        Result := qryRecon.FieldByName('Reconciled').AsBoolean;
      end else begin
        Result := false;
      end;
      if MasterAndDetails and not Result then begin
        qryRecon.Sql.Clear;
        qryRecon.Sql.Add('SELECT Reconciled  FROM tblbankdeposit Where ' + Fieldname + ' = ' + ID + '');
        qryRecon.Sql.Add(' AND AccountID = "' + AccountID + '" ');
        qryRecon.Open;
        if qryRecon.RecordCount = 1 then begin
          Result := qryRecon.FieldByName('Reconciled').AsBoolean;
        end else begin
          Result := false;
        end;
      end;
    end;
  end;
  function  IsChequeReconciled(const ID, Fieldname, TrnsType, AccountID: string; Const qryRecon: TERPQuery): boolean;
  begin
    with qryRecon do begin
      qryRecon.Close;
      qryRecon.Sql.Clear;
      qryRecon.Sql.Add('SELECT B.Reconciled as RecMaster FROM tblbankdepositlines BL ');
      qryRecon.Sql.Add('INNER JOIN tblbankdeposit B Using(DepositID) ');
      qryRecon.Sql.Add('Where ' + Fieldname + ' = ' + ID + '');
      if Trim(TrnsType) <> '' then begin
        qryRecon.Sql.Add(' AND TrnsType = "' + TrnsType + '" ');
      end;
      qryRecon.Sql.Add(' AND B.AccountID = "' + AccountID + '" ');
      qryRecon.Open;
      if qryRecon.RecordCount > 0 then begin
        Result := qryRecon.FieldByName('RecMaster').AsBoolean;
      end else begin
        Result := false;
      end;
    end;
  end;
begin
  qryBankDep := TERPQuery.Create(nil);
  qryBankDep.Options.FlatBuffers := True;
  qryBankDep.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  qryBankDep.ParamCheck := false;
  qryRecon := TERPQuery.Create(nil);
  qryRecon.Options.FlatBuffers := True;
  qryRecon.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  qryRecon.ParamCheck := false;
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if Assigned(ProgressDlg) then begin
      ProgressDlg.Caption  := iif(Devmode  , 'AddReconcileFlags',AppEnvVirt.Str['TcConst.WAITMSG']);
      ProgressDlg.MinValue := 0;
      ProgressDlg.Step     := 1;
    end;
    with qryBankDep do begin
      Sql.Clear;
      Sql.Add('SELECT Type, ');
      Sql.Add('TransID,AccountName,AccountID, ');
      Sql.Add('SaleID, PurchaseOrderID, PaymentID,PrepaymentID,ClientID,Reconciled');
      Sql.Add('FROM tbltransactions ');
      Sql.Add('WHERE (AccountType = "BANK" OR AccountType = "CCARD") ' );
      Open;
      if Assigned(ProgressDlg) then begin
        ProgressDlg.MaxValue := RecordCount + 1;
        ProgressDlg.Execute;
        ProgressDlg.StepIt;
      end;
      First;
      while not
        qryBankDep.Eof do begin
        if FieldByName('Type').AsString = 'Cheque' then begin
          Reconciled := IsChequeReconciled(FieldByName('PurchaseOrderID').AsString, 'PaymentID', 'Cheque', FieldByName('AccountID').AsString,qryRecon);
          if not Reconciled then
            Reconciled := IsChequeReconciled(FieldByName('PurchaseOrderID').AsString, 'PaymentID', 'Cheque Deposit', FieldByName('AccountID').AsString,qryRecon);
        end else if FieldByName('Type').AsString = 'Customer Payment' then begin
          Reconciled := IsReconciled(FieldByName('PaymentID').AsString, 'PaymentID', 'Customer Payment', FieldByName('AccountID').AsString,qryRecon);
        end else if FieldByName('Type').AsString =
          'Supplier Payment' then begin
          Reconciled := IsReconciled(FieldByName('PaymentID').AsString, 'PaymentID', 'Supplier Payment', FieldByName('AccountID').AsString,qryRecon);
        end else if (FieldByName('Type').AsString =
          'Bank Deposit') then begin
          Reconciled := IsReconciled(FieldByName('PaymentID').AsString, 'DepositID', '', FieldByName('AccountID').AsString,qryRecon, true);
        end else if (FieldByName('Type').AsString = 'Deposit Entry') then begin
          Reconciled := IsReconciled(FieldByName('PaymentID').AsString, 'DepositID', 'Deposit Entry', FieldByName('AccountID').AsString,qryRecon, true);
        end else if FieldByName('Type').AsString = 'Journal Entry' then begin
          Reconciled := IsReconciled(FieldByName('SaleID').AsString, 'PaymentID', 'Journal Entry', FieldByName('AccountID').AsString,qryRecon);
        end else if FieldByName('Type').AsString = AppEnvVirt.Str['tcConst.CUSTOMER_PREPAYMENT'] then begin
          Reconciled := IsReconciled(FieldByName('PrepaymentID').AsString, 'PaymentID', AppEnvVirt.Str['tcConst.CUSTOMER_PREPAYMENT'], FieldByName('AccountID').AsString,qryRecon);
        end else if FieldByName('Type').AsString = 'Supplier Prepayment' then begin
          Reconciled := IsReconciled(FieldByName('PrepaymentID').AsString, 'PaymentID', 'Supplier Prepayment', FieldByName('AccountID').AsString,qryRecon);
        end else begin
          Reconciled := false;
        end;
        if Reconciled then begin
          Edit;
          FieldByName('Reconciled').AsString := 'T';
          Post;
        end else begin
          Edit;
          FieldByName('Reconciled').AsString := 'F';
          Post;
        end;
        if Assigned(ProgressDlg) then begin
          ProgressDlg.Message := inttostr(recno)+' of '+ inttostr(recordcount);
          ProgressDlg.StepIt;
        end;
        qryBankDep.Next;
      end;
    end;
  finally
    FreeAndNil(qryBankDep);
    FreeAndNil(qryRecon);
    if Assigned(ProgressDlg) then begin
      ProgressDlg.CloseDialog;
    end;
    Screen.Cursor := Save_Cursor;
  end;
end;

Procedure TTransactionTableObj.CleanOutUserTempTables;
begin
  Delete_Unique_AR_TempTable;
  Delete_Unique_ALL_TempTable;
end;

function TTransactionTableObj.aQuery: TERPQuery;
begin
  Result := TERPQuery.Create(nil);
  Result.Options.FlatBuffers := True;
  Result.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  Result.ParamCheck := false;
end;

Function TTransactionTableObj.CleanOutTempTables:boolean;
var
  Save_Cursor: TCursor;
begin
Result := False;
if not(Lock('Clean Up')) then exit;
try
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
   if Assigned(TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection'])) AND
     (not TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']).Connected) then
      Exit;
   with BulkSQL do begin
      Clear;
      if not AppEnvVirt.Bool['CompanyPrefs.UseBatchTransactions'] then begin
        Add('DELETE  FROM tbltransactions;');
        Add('ALTER TABLE tbltransactions CHANGE TransID TransID INT(11)  NOT NULL;');
        Add('ALTER TABLE tbltransactions ENGINE = InnoDB;');
        Add('ALTER TABLE tbltransactions ENGINE = MyISAM;');
        Add('DELETE FROM tbltransactions_inprogress;');
        Add('ALTER TABLE tbltransactions_inprogress CHANGE TransID TransID INT(11)  NOT NULL;');
        Add('ALTER TABLE tbltransactions_inprogress ENGINE = InnoDB;');
        Add('ALTER TABLE tbltransactions_inprogress ENGINE = MyISAM;');
      end;
      Add('DELETE  FROM tblbalancesheet;');
      Add('ALTER TABLE tblbalancesheet CHANGE ID ID INT(11) NOT NULL;');
      Add('ALTER TABLE tblbalancesheet ENGINE = InnoDB;');
      Add('ALTER TABLE tblbalancesheet ENGINE = MyISAM;');
      Add('ALTER TABLE tblbalancesheet CHANGE ID ID INT(11) NOT NULL AUTO_INCREMENT;');

      Add('DELETE  FROM tmp_tblaccountspayable;');
      Add('ALTER TABLE tmp_tblaccountspayable CHANGE ID ID INT(11) NOT NULL;');
      Add('ALTER TABLE tmp_tblaccountspayable ENGINE = InnoDB;');
      Add('ALTER TABLE tmp_tblaccountspayable ENGINE = MyISAM;');
      Add('ALTER TABLE tmp_tblaccountspayable CHANGE ID ID INT(11) NOT NULL AUTO_INCREMENT;');

      Add('DELETE FROM ' + AppEnvVirt.Str['tcConst.TABLE_PROFITANDLOSSREPORT'] + ' ;');
      Add('ALTER TABLE ' + AppEnvVirt.Str['tcConst.TABLE_PROFITANDLOSSREPORT'] + ' CHANGE ID ID INT(11) NOT NULL;');
      Add('ALTER TABLE ' + AppEnvVirt.Str['tcConst.TABLE_PROFITANDLOSSREPORT'] + ' ENGINE = InnoDB;');
      Add('ALTER TABLE ' + AppEnvVirt.Str['tcConst.TABLE_PROFITANDLOSSREPORT'] + ' ENGINE = MyISAM;');
      Add('ALTER TABLE ' + AppEnvVirt.Str['tcConst.TABLE_PROFITANDLOSSREPORT'] + ' CHANGE ID ID INT(11) NOT NULL AUTO_INCREMENT;');
    end;
    if Assigned(ProgressDlg) then begin
      ProgressDlg.Caption := AppEnvVirt.Str['TcConst.WAITMSG'];
      ProgressDlg.MinValue := 0;
      ProgressDlg.Step := 1;
    end;
    if not Assigned(qryMyScript) then begin
      qryMyScript := NewScript;//TERPScript.Create(nil);
      //qryMyScript.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    end;
    qryMyScript.BeforeExecute := MyScriptBeforeExecute;
    qryMyScript.AfterExecute := MyScriptAfterExecute;
    qryMyScript.SQL.Clear;
    qryMyScript.SQL.Text := BulkSQL.Text;
    BulkSQL.Clear;
    if Assigned(ProgressDlg) then begin
      ProgressDlg.MaxValue := qryMyScript.Statements.Count;
      ProgressDlg.Execute;
    end;
      qryMyScript.IgnorenContinueOnError := True;
      qryMyScript.ProcessScriptExecteError := DoProcessScriptExecteError;
      qryMyScript.Execute;
  finally
    if Assigned(ProgressDlg) then begin
      ProgressDlg.CloseDialog;
    end;
    Screen.Cursor := Save_Cursor;
    Application.ProcessMessages
  end;
finally
  unLock('Clean Up');
  REsult := True;
end;
end;
Function  TTransactionTableObj.IStochangeSummasedTransdateTocurent(SummaryDetailsTable: boolean ;KeepSummariseDt: boolean;ForceSummary: boolean ):Boolean;
var
  s:String;
begin
  s:= '';
  result:= False;
  try
    if SummaryDetailsTable then exit;
    if KeepSummariseDt     then exit;

    if ForceSummary then begin
      result := True;
      s:= 'No data prior to the current ''Summarised Date''';
      exit;
    end;

    if HoursBetween(AppEnvVirt.Float['CompanyPrefs.SummarisedTransDateChanged'],Now()) >8  then
        if MonthsBetween(GetCurrentFiscalYearStart,now) >= AppEnvVirt.Int['CompanyPrefs.NoOfMonthstoChangeClosingdate'] then
            if CompareDate(AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'],GetLastFiscalYearEnd(Now()))<>0 then begin
              s:=  AutochangeSumDtMsg(GetCurrentFiscalYearStart, GetLastFiscalYearEnd(Now()), false);
              Result:= TRue;
              exit;
            end;

  finally
    if result then
      if s<> '' then begin
        s:= '''Summarised Date'' is automatically changed from ' + chr(13)+ quotedstr(formatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat ,AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate']) )+
              ' to Current '+ chr(13)+ ' because ' + chr(13)+ chr(13)+ s;
        if not AppEnvVirt.showWarning (s) then Log(  s,ltError);
      end;
  end;
end;

Function TTransactionTableObj.QuotedFieldName(const fieldName:String):String;
begin
    result := '`' +trim(fieldname) +'`';
end;

function TTransactionTableObj.CleanRefreshTrnsTable(const RefreshBatch: Boolean = False; const SummaryDetailsTable: Boolean = False; const VerfiyBalances: Boolean = False; const KeepSummariseDt: Boolean = False): Boolean;
var
    AccruedLeaveLiabAdj           : TAccruedLeaveLiabilitiesAdjObj;
    Save_Cursor                   : TCursor;
    StockCostSystems              : TStockCostSystemsObj;
    tmpDate                       : TDate;
    qry                           : TERPQuery;
    IdList                        : string;
    ForceSummary                  : Boolean;
begin
  Result := False;
  if not(Lock('Update Batch / Report')) then Exit;
  try
    fDoingRefresh := True;
    TempFileCount := 0;
    MySQLTempDir := StringReplace(AppEnvVirt.Str['CommonDbLib.GetMySQLTempDir'], '\', '/', [rfReplaceAll]);
    try
      Application.ProcessMessages; {Gui Main Screen Paint}
      try
         qry := TERPQuery.Create(nil);
         try
           qry.Connection:= TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
           qry.SQL.Text := 'SELECT COUNT(TransId) AS TransCount from tbltransactionsummarydetails';
           qry.Open;
           ForceSummary := qry.FieldByName('TransCount').AsInteger = 0;
         finally
           qry.Free;
         end;

        if IStochangeSummasedTransdateTocurent(SummaryDetailsTable, keepSummariseDt, forceSummary) then begin
          If (StartOfAMonth(YearOf(Now()), 7) <= Now()) AND (Now() <= EndOfAMonth(YearOf(Now()), 7)) then
            tmpDate := EndOfAMonth(YearOf(Now()),6)
          else  tmpDate := Now;

          AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'] := GetLastFiscalYearEnd(tmpDate);
          AppEnvVirt.Float['CompanyPrefs.closingDate'] := AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'] ;
          AppEnvVirt.Float['CompanyPrefs.closingDateAP'] := AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'] ;
          AppEnvVirt.Float['CompanyPrefs.closingDateAR'] := AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'] ;

          CleanRefreshTrnsTable(True, True);
          CreatePermanentSummaryTable;
          AppEnvVirt.PopulateCompanyPrefs;
        end;
          SummarisedTransDate := AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'];
          if SummaryDetailsTable then begin
            TableName := 'tbltransactionsummarydetails';
            BeforeOrAfterClosing := '<=';
          end else begin
            TableName := 'tbltransactions_inprogress';
            BeforeOrAfterClosing := '>';
          end;

          LOAD_INTO_String := 'INTO TABLE ' + TableName +
            '  CHARACTER SET  UTF8  ('+ TransSQLFields(0) +
(*                'SeqNo, Date,Type,GlobalRef,ClassID,'+
              'SaleID,PurchaseOrderID,PaymentID,PrepaymentID,FixedAssetID,'+
              'SaleLineId, purchaselineID,PaymentLineId, prepaymentlineid, '+
              'AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,' +
            'AccountID,AccountType,ClientName, ClientID,' +
            'ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,' +
            'TaxCode,TaxRate,TaxID,DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,' +
            'CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`'+*)
              ') ';

          LOAD_INTO_StringFixedAssets := 'INTO TABLE ' + TableName +
            '  CHARACTER SET  UTF8  ('+ TransSQLFields(66)+') ';
(*              '  CHARACTER SET  UTF8  (SeqNo, Date,Type,GlobalRef,ClassID,SaleID,PurchaseOrderID,PaymentID,PrepaymentID,FixedAssetID,AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,AccountID,AccountType,ClientName, ClientID,' +
            'ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,TaxCode,TaxRate,TaxID,DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`,Active) ';*)


          if AppEnvVirt.Bool['CompanyPrefs.UseBatchTransactions'] and not RefreshBatch then begin
            Exit;
          end;

          Randomize; //See Ianos
          Sleep(Random(16)*125);

          if AppEnvVirt.Bool['CompanyPrefs.UseBatchTransactions'] and (AppEnvVirt.GetEmployeeAccessLevel('FnRunBatch') <> 1) then begin
            if IsGUI then
              Vista_MessageDlg.MessageDlgXP_Vista('You do not have Access to this Function', mtInformation, [mbOK], 0)
            else
              Log('You do not have Access to run Batch Update function',ltError);
            raise ENoAccess.Create('You do not have Access to this Function');
            Exit;
          end;


          if not Assigned(qryMyScript) then begin
            qryMyScript := NewScript;//TERPScript.Create(nil);
            //qryMyScript.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
          end;

          if not Assigned(qryTemp) then begin
            qryTemp := TERPQuery.Create(nil);
            qryTemp.Options.FlatBuffers := True;
            qryTemp.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
          end;

          if AppEnvVirt.Bool['CompanyPrefs.BatchUpdateInProgress'] then begin
            if IsGUI then
              Vista_MessageDlg.MessageDlgXP_Vista('Batch Update is Already in Progress by Another User !' + #13 + #10 + 'Please Try Again Later',
                mtWarning, [mbOK], 0)
              else
                Log('Batch Update is Already in Progress, Please Try Again Later',ltWarning);
            Exit;
          end else begin
            AppEnvVirt.Bool['CompanyPrefs.BatchUpdateInProgress'] := true;
          end;
          Save_Cursor   := Screen.Cursor;
          Screen.Cursor := crHourGlass;
          try
            StockCostSystems := TStockCostSystemsObj.Create;
            try
              if (AppEnvVirt.Int['CompanyPrefs.StockCostSystem'] = Ord(scsLast)) then
                StockCostSystems.RefreshLastCostAdjTable(BeforeOrAfterClosing + ' "' + FormatDateTime(MysqlDateFormat, SummarisedTransDate) + '" ')
              else
                StockCostSystems.CleanTempTable;
            finally
              FreeAndNil(StockCostSystems);
            end;

            AppEnvVirt.Float['CompanyPrefs.TransactionTableLastUpdated'] := 0;
            AppEnvVirt.DeleteServerFiles(StringReplace(MySQLTempDir,'/','\',[rfReplaceAll]) + AppEnvVirt.str['CompanyPrefs.DBName']+'_'+ TableName + '_*.tmp');

            with BulkSQL do begin
              Clear;
              add('update tblpurchaselines set CustomerJobID =0 where ifnull(CustomerJobID,0)=0;'); // this is to avoid NULL issue for group by
              if TableName = 'tbltransactions_inprogress' then begin
                  add('drop table if exists tbltransactions_inprogress;');
                  Add(StringReplace(GetCreate_tbltransactions_inprogress,'tmp_tbltransactions','tbltransactions_inprogress',[rfReplaceAll,rfIgnoreCase])+';')
              end else
                  Add('DELETE  FROM ' + TableName + ';');

              Add('ALTER TABLE `' + TableName + '` CHANGE `TransID` `TransID` INT(11)  NOT NULL;');
              Add('ALTER TABLE ' + TableName + ' ENGINE = InnoDB;');
              Add('ALTER TABLE ' + TableName + ' ENGINE = MyISAM;');
              Add('ALTER TABLE `' + TableName + '` CHANGE `TransID` `TransID` INT(11)    NOT NULL AUTO_INCREMENT;');

              qry:= TERPQuery.Create(nil);
              try
                qry.Connection:= TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

                qry.SQL.Text:=
                  'SELECT tblsaleslines.SaleLineID ' +
                  'FROM tblsaleslines ' +
                  'where tblsaleslines.INCOMEACCNTID <> ' +
                  '(select tblchartofaccounts.AccountID from tblchartofaccounts ' +
                  'where tblchartofaccounts.AccountName = tblsaleslines.INCOMEACCNT)';
                qry.Open;
                IdList:= qry.GroupConcat('SaleLineId');
                if IdList <> '' then begin
                  Add('UPDATE tblsaleslines INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountName = tblsaleslines.INCOMEACCNT ');
                  Add('SET INCOMEACCNTID = AccountID');
                  Add('WHERE tblsaleslines.SaleLineId in (' + IdList + ');');
                end;
                qry.Close;

                qry.SQL.Text:=
                  'SELECT tblsaleslines.SaleLineID ' +
                  'FROM tblsaleslines ' +
                  'where tblsaleslines.ASSETACCNTID <> ' +
                  '(select tblchartofaccounts.AccountID from tblchartofaccounts ' +
                  'where tblchartofaccounts.AccountName = tblsaleslines.ASSETACCNT)';
                qry.Open;
                IdList:= qry.GroupConcat('SaleLineId');
                if IdList <> '' then begin
                  Add('UPDATE tblsaleslines INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountName = tblsaleslines.ASSETACCNT ');
                  Add('SET ASSETACCNTID = AccountID');
                  Add('WHERE tblsaleslines.SaleLineId in (' + IdList + ');');
                end;
                qry.Close;

                qry.SQL.Text:=
                  'SELECT tblsaleslines.SaleLineID ' +
                  'FROM tblsaleslines ' +
                  'where tblsaleslines.COGSACCNTID <> ' +
                  '(select tblchartofaccounts.AccountID from tblchartofaccounts ' +
                  'where tblchartofaccounts.AccountName = tblsaleslines.COGSACCNT)';
                qry.Open;
                IdList:= qry.GroupConcat('SaleLineId');
                if IdList <> '' then begin
                  Add('UPDATE tblsaleslines INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountName = tblsaleslines.COGSACCNT ');
                  Add('SET COGSACCNTID = AccountID');
                  Add('WHERE tblsaleslines.SaleLineId in (' + IdList + ');');
                end;
                qry.Close;

                qry.SQL.Text:=
                  'SELECT tblpurchaselines.PurchaseLineID ' +
                  'FROM tblpurchaselines ' +
                  'where tblpurchaselines.INCOMEACCNTID <> ' +
                  '(select tblchartofaccounts.AccountID from tblchartofaccounts ' +
                  'where tblchartofaccounts.AccountName = tblpurchaselines.INCOMEACCNT)';
                qry.Open;
                IdList:= qry.GroupConcat('PurchaseLineID');
                if IdList <> '' then begin
                  Add('UPDATE tblpurchaselines INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountName = tblpurchaselines.INCOMEACCNT ');
                  Add('SET INCOMEACCNTID = AccountID');
                  Add('WHERE tblpurchaselines.PurchaseLineID in (' + IdList + ');');
                end;
                qry.Close;

                qry.SQL.Text:=
                  'SELECT tblpurchaselines.PurchaseLineID ' +
                  'FROM tblpurchaselines ' +
                  'where tblpurchaselines.ASSETACCNTID <> ' +
                  '(select tblchartofaccounts.AccountID from tblchartofaccounts ' +
                  'where tblchartofaccounts.AccountName = tblpurchaselines.ASSETACCNT)';
                qry.Open;
                IdList:= qry.GroupConcat('PurchaseLineID');
                if IdList <> '' then begin
                  Add('UPDATE tblpurchaselines INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountName = tblpurchaselines.ASSETACCNT ');
                  Add('SET ASSETACCNTID = AccountID');
                  Add('WHERE tblpurchaselines.PurchaseLineID in (' + IdList + ');');
                end;
                qry.Close;

                qry.SQL.Text:=
                  'SELECT tblpurchaselines.PurchaseLineID ' +
                  'FROM tblpurchaselines ' +
                  'where tblpurchaselines.COGSACCNTID <> ' +
                  '(select tblchartofaccounts.AccountID from tblchartofaccounts ' +
                  'where tblchartofaccounts.AccountName = tblpurchaselines.COGSACCNT)';
                qry.Open;
                IdList:= qry.GroupConcat('PurchaseLineID');
                if IdList <> '' then begin
                  Add('UPDATE tblpurchaselines INNER JOIN tblchartofaccounts ON tblchartofaccounts.AccountName = tblpurchaselines.COGSACCNT ');
                  Add('SET COGSACCNTID = AccountID');
                  Add('WHERE tblpurchaselines.PurchaseLineID in (' + IdList + ');');
                end;
                qry.Close;

              finally
                qry.Free;
              end;

              if not SummaryDetailsTable then begin
                {1}Add('UNLOCK TABLES; INSERT HIGH_PRIORITY INTO ' + TableName +
                                ' (SeqNo, Date,Type,GlobalRef,ClassID,' +
                                ' SaleID,PurchaseOrderID,PaymentID,PrepaymentID,FixedAssetID,' +
                                ' SaleLineId, PurchaseLineID, PaymentlineID, PrePaymentlineID,'+
                                ' AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,' +
                                ' AccountID,AccountType,ClientName, ClientID,CustomerJobId,' +
                                ' ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,' +
                                ' TaxCode,TaxRate,TaxID,DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,' +
                                ' CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`) ');
                Add('SELECT '+SumSeqno(800)+', Date,Type,GlobalRef,ClassID,SaleID,PurchaseOrderID,PaymentID,PrepaymentID,FixedAssetID,' +
                                ' SaleLineId, PurchaseLineID, PaymentlineID, PrePaymentlineID,AccountName,AccountGroupLevels,' +
                                ' Level1,Level2,Level3,Level4,AccountID,AccountType,ClientName, ClientID, CustomerJobId,' +
                                ' ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,TaxCode,' +
                                ' TaxRate,TaxID,DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,CASH_CreditsEx,' +
                                ' CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref` ' +
                                ' From tbltransactionsummary;');
              end;

              TrnsTable02(BulkSQL);
              TrnsTable03(BulkSQL);
              TrnsTable04(BulkSQL);
              TrnsTable05(BulkSQL);
              TrnsTable06(BulkSQL);
              TrnsTable07(BulkSQL);
              TrnsTable08(BulkSQL);
              TrnsTable10(BulkSQL);
              TrnsTable11(BulkSQL);
              TrnsTable12(BulkSQL);
              TrnsTable14(BulkSQL);
              TrnsTable16(BulkSQL);
              TrnsTable17(BulkSQL);
              TrnsTable18(BulkSQL);
              TrnsTable19(BulkSQL);
              TrnsTable20(BulkSQL);
              TrnsTable21(BulkSQL);
              TrnsTable22(BulkSQL);
              TrnsTable23(BulkSQL);
              TrnsTable24(BulkSQL);
              TrnsTable25(BulkSQL);
              TrnsTable26(BulkSQL);
              TrnsTable27(BulkSQL);
              TrnsTable28(BulkSQL);
              TrnsTable29(BulkSQL);
              TrnsTable30(BulkSQL);
              TrnsTable31(BulkSQL);
              TrnsTable32(BulkSQL);
              TrnsTable33(BulkSQL);
              TrnsTable34(BulkSQL);
              TrnsTable35(BulkSQL);
              TrnsTable36(BulkSQL);
              TrnsTable37(BulkSQL);
              TrnsTable38(BulkSQL);
              TrnsTable39(BulkSQL);
              TrnsTable80(BulkSQL);
              TrnsTable40(BulkSQL);
              TrnsTable81(BulkSQL);
              TrnsTable41(BulkSQL);
              TrnsTable44(BulkSQL);
              TrnsTable47(BulkSQL);
              TrnsTable50(BulkSQL);
              TrnsTable51(BulkSQL);
              TrnsTable52(BulkSQL);
              TrnsTable53(BulkSQL);
              TrnsTable54(BulkSQL);
              TrnsTable55(BulkSQL);
              TrnsTable56(BulkSQL);
              TrnsTable57(BulkSQL);
              TrnsTable58(BulkSQL);

    //###########################################
    //############  PAYROLL #####################
    //###########################################
                AccruedLeaveLiabAdj := TAccruedLeaveLiabilitiesAdjObj.Create;
                try
                  AccruedLeaveLiabAdj.UpdateAccruedLeaveAdj;
                finally
                  AccruedLeaveLiabAdj.Free;
                end;

                TrnsTable59(BulkSQL);

    //###########################################
    //###########################################
                TrnsTable60(BulkSQL);
                TrnsTable61(BulkSQL);
                TrnsTable62(BulkSQL);
                TrnsTable63(BulkSQL);
                TrnsTable64(BulkSQL);
                TrnsTable65(BulkSQL);
                TrnsTable66(BulkSQL);
                TrnsTable67(BulkSQL);
                //TrnsTable69(BulkSQL);
                //TrnsTable70(BulkSQL);
                TrnsTable71(BulkSQL);
                TrnsTable72(BulkSQL);
                TrnsTable73(BulkSQL);
                TrnsTable74(BulkSQL);
                TrnsTable75(BulkSQL);
                TrnsTable76(BulkSQL);
                TrnsTable77(BulkSQL);
                TrnsTable78(BulkSQL);
                TrnsTable79(BulkSQL);
                TrnsTable83(BulkSQL);
                TrnsTable84(BulkSQL);
                TrnsTable85(BulkSQL);
                TrnsTable87(BulkSQL);
                //TrnsTable91(BulkSQL);
                TrnsTable92(BulkSQL);
                TrnsTable93(BulkSQL);
                TrnsTable94(BulkSQL);

                //delete all the adjustemnts if all amounts are 0
                Add('/*Gen-01*/ Delete from ' + Tablename +' where round(Seqno) <> Seqno and ifnull(creditsEx,0)=0 and ifnull(debitsEx,0)=0 and ifnull(creditsinc,0)=0 and ifnull(debitsinc,0)=0;');


                UpdateCurrency(BulkSQL);

                if not SummaryDetailsTable then begin
                    //UpdateCurrency;
                    Add('/*Gen-02*/FLUSH TABLES tbltransactions;');
                    Add('/*Gen-03*/DROP TABLE tbltransactions;');
                    Add('/*Gen-04*/RENAME TABLE tbltransactions_inprogress TO tbltransactions;');
                    Add('/*Gen-05*/'+StringReplace(GetCreate_tbltransactions_inprogress,'tmp_tbltransactions','tbltransactions_inprogress',[rfReplaceAll,rfIgnoreCase])+';');
                    Add('/*Gen-06*/UNLOCK TABLES;');
                    Add('/*Gen-07*/FLUSH TABLES tbltransactions;');
                end;
              end;
              if Assigned(ProgressDlg) then begin
                ProgressDlg.Caption := AppEnvVirt.Str['TcConst.WAITMSG'];
                ProgressDlg.MinValue := 0;
                ProgressDlg.MaxValue := BulkSQL.Count;
                ProgressDlg.Step := 1;
              end;
              qryMyScript.BeforeExecute := MyScriptBeforeExecute;
              qryMyScript.AfterExecute := MyScriptAfterExecute;

              qryMyScript.SQL.Clear;
              qryMyScript.SQL.Text := BulkSQL.Text;
              BulkSQL.Clear;
              if Assigned(ProgressDlg) then begin
                ProgressDlg.MaxValue :=qryMyScript.Statements.Count+10;
                ProgressDlg.Execute;
              end;
              qryMyScript.IgnorenContinueOnError := True;
              qryMyScript.ProcessScriptExecteError := DoProcessScriptExecteError;
              qryMyScript.Execute;

              {VS1 tables creation - they need to be done after update batch only}
              if not SummaryDetailsTable then begin
                Log(' not SummaryDetailsTable : ' + CurDBName, ltDetail);
                DoAfterUpdate;
              end else begin
                Log(' SummaryDetailsTable - not running afterupdate: ' + CurDBName,ltDetail);
              end;

            finally
              AppEnvVirt.Bool['CompanyPrefs.BatchUpdateInProgress'] := false;
              if Assigned(ProgressDlg) then begin
                ProgressDlg.CloseDialog;
              end;
              AppEnvVirt.DeleteServerFiles(StringReplace(MySQLTempDir,'/','\',[rfReplaceAll]) + AppEnvVirt.str['CompanyPrefs.DBName']+'_'+ TableName + '_*.tmp');
              Screen.Cursor := Save_Cursor;
              Application.ProcessMessages
            end;
            try
              if not SummaryDetailsTable then AddReconcileFlags;

              if (TableName = 'tbltransactions_inprogress') then begin
                if  (AppEnvVirt.Bool['CompanyPrefs.VerifyBalanceOnBatch']) and VerfiyBalances then begin
                   { TODO 1 -oBinny -cUserLock : Check for user locking of Customer/Supplier/Account  before balance update }
                  ResetBalances;
                end;
              end;

            except
              on E:Exception do
                Log(' Error  Clean refresh :' + E.Message,ltError);
            end;
      except
        on e: ENoAccess do Log(' Error  Clean refresh no access :' + E.Message,ltError);
        on E:Exception do begin
          Log(' Error  Clean refresh no access :' + E.Message,ltError);
          raise;
        end;
        else raise;
      end;
    finally
      fDoingRefresh:= false;
    end;
  finally
    result := True;
    try
      unLock('Update Batch / Report');
    except
      on E:Exception do
        Log(' Error : unLock("Update Batch / Report") : ' + E.Message,ltError);
    end;
    try
      AppEnvVirt.Float['CompanyPrefs.TransactionTableLastUpdated'] := Now;
    except
      on E:Exception do
        Log(' Error setting TransactionTableLastUpdated ' + E.Message,ltError);
    end;
  end;
end;

procedure MakePnLReportSum(DateFrom: TDateTime; DateTo: TDateTime; Suffix: Integer);
var
  fReportSQLObj: TProfitAndLossReport;
  fScript: TERPScript;
  msg: String;
begin
  fReportSQLObj := TProfitAndLossReport.Create;
  try
    fReportSQLObj.DateFrom := DateFrom;
    fReportSQLObj.DateTo := DateTo;

    fScript := TERPScript.Create(nil);
    try
//      fScript.Connection := CommonDbLib.GetSharedMyDacConnection;;
      fScript.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
      fScript.SQL.Clear;
      fReportSQLObj.PopulateReportSQL(fScript.SQL, msg);
      fScript.SQL.text := 'DROP TEMPORARY TABLE IF EXISTS tmp_PNL_Data' + IntToStr(Suffix) + ';' +
                    ' CREATE TEMPORARY TABLE tmp_PNL_Data' + IntToStr(Suffix) + ' ' + fScript.SQL.text + ';' +
                    ' DELETE FROM tmp_PNL_Data' + IntToStr(Suffix) + ' WHERE NOT(`account type` LIKE "Total%" OR `account type` LIKE "Net%");';
      fScript.Execute;
    finally
      fScript.Free;
    end;

  finally
    FreeAndNil(fReportSQLObj);
  end;

end;

procedure TTransactionTableObj.UpdateVS1DashBoardTables;
var
  sct: TERPScript;
  aDtFrom, aDtTo: Tdatetime;
  msg: String;

  procedure Make_VS1_PnLPeriodReport;
  var
    fReportSQLObj : TProfitAndLossPeriodReport;//TReportSQLProfitAndLossPeriod;
    aParams:TJsonObject;
  begin
    fReportSQLObj := TProfitAndLossPeriodReport.Create;
    try
      aParams := JO;
      aParams.DT[TAG_DATEFROM] := aDtFrom;
      aParams.DT[TAG_DATETO] := aDtTo;
      aParams.S[TAG_PeriodType] := 'Month';
      fReportSQLObj.AssignParams(aParams);
      sct.SQL.Clear;
      fReportSQLObj.PopulateReportSQL(sct.SQL, msg);
      sct.SQL.Text := 'DROP TABLE IF EXISTS tmp_VS1_Dashboard_Pnl_Period;' +
                        'CREATE TABLE tmp_VS1_Dashboard_Pnl_Period ' + sct.SQL.Text + ';' +
                        'DELETE FROM tmp_VS1_Dashboard_Pnl_Period WHERE NOT(`accounttypedesc` LIKE "Total%" OR `accounttypedesc` LIKE "Net%");' ;
      sct.Execute;
    finally
      Freeandnil(fReportSQLObj);
    end;
  end;

  procedure Make_VS1_APReport;
  var
    fReportSQLObj : TAPReport;//TReportSQLProfitAndLossPeriod;
    aParams:TJsonObject;
    aDate:TDateTime;
  begin
    fReportSQLObj := TAPReport.Create;
    try
      aParams := JO;
      aParams.DT[TAG_DATEFROM] := aDtFrom;
      aParams.DT[TAG_DATETO] := aDtTo;
      fReportSQLObj.AssignParams(aParams);
      sct.SQL.Clear;
      fReportSQLObj.PopulateReportSQL(sct.SQL, msg);
      sct.SQL.text := ' DROP TABLE IF EXISTS tmp_vs1_dashboard_ap_report;' +
                            'CREATE TABLE tmp_vs1_dashboard_ap_report ( ' +
                            '	id INT(11) NOT NULL AUTO_INCREMENT, ' +
                            '	Datefrom DATETIME NULL DEFAULT NULL, ' +
                            '	dateto DATEtIME NULL DEFAULT NULL, ' +
                            '	month1 VARCHAR(15) NULL DEFAULT NULL, ' +
                            '	MONTH2 VARCHAR(15) NULL DEFAULT NULL, ' +
                            '	MONTH3 VARCHAR(15) NULL DEFAULT NULL, ' +
                            '	total DOUBLE NULL DEFAULT NULL, ' +
                            '	PRIMARY KEY (id), ' +
                            '	UNIQUE INDEX Datefrom (Datefrom)) COLLATE="utf8_general_ci" ENGINE=MyISAM;'+
                            ' INSERT IGNORE INTO tmp_VS1_Dashboard_AP_Report (Datefrom, dateto, month1, MONTH2, MONTH3, total) SELECT ' +
                            ' date_add(date_add(LAST_DAY(Orderdate), interval 1 DAY), interval - 1 MONTH) Datefrom, ' +
                            ' LAST_DAY(orderdate) dateto, ' +
                            ' DATE_FORMAT(orderdate,"%M") AS month1, ' +
                            ' DATE_FORMAT(orderdate,"%b") AS MONTH2, ' +
                            ' DATE_FORMAT(orderdate,"%b-%Y") AS MONTH3, SUM(Originalamount) total ' +
                            ' FROM (' + sct.SQL.text +') aa WHERE orderdate BETWEEN ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDtfrom)) +' and ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDtto)) +' GROUP BY LAST_DAY(orderdate);';

      aDate :=  StartOfThemonth(aDtFrom);
      while aDate <= aDtTo do begin
        sct.SQL.add('INSERT IGNORE INTO tmp_VS1_Dashboard_AP_Report (Datefrom, dateto, month1, MONTH2, MONTH3, total) '+
                      ' SELECT ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDate))+' Datefrom, '+
                      ' LAST_DAY('+quotedStr(Formatdatetime(mysqldatetimeformat,aDate))+') DateTo, '+
                      ' DATE_FORMAT( ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDate))+',"%M") AS month1, ' +
                      ' DATE_FORMAT( ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDate))+',"%b") AS MONTH2, ' +
                      ' DATE_FORMAT( ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDate))+',"%b-%Y") AS MONTH3, ' +
                      ' 0.0 total ;' );

        aDate := incmonth(aDate,1);
      end;
      sct.Execute;
    finally
      Freeandnil(fReportSQLObj);
    end;
  end;

  procedure Make_VS1_SalesList;
  var
    fReportSQLObj : TSalesList;//TReportSQLProfitAndLossPeriod;
    aParams:TJsonObject;
    aDate:tDatetime;
  begin

      fReportSQLObj := TSalesList.Create;
      try
          aParams := jo;
          aParams.DT[TAG_DATEFROM]      := aDtFrom;
          aParams.DT[TAG_DATETO]        := aDtTo;
          fReportSQLObj.AssignParams(aParams);
          sct.SQL.Clear;
          fReportSQLObj.PopulateReportSQL(sct.SQL, msg);
(*          sct.SQL.text := 'Drop table if exists tmp_VS1_Dashboard_SalesList;' +
                            'Create table tmp_VS1_Dashboard_SalesList SELECT ' +*)
          sct.SQL.text := ' Drop table if exists tmp_VS1_Dashboard_SalesList;' +
                            'CREATE TABLE tmp_VS1_Dashboard_SalesList ( ' +
                            '	id INT(11) NOT NULL AUTO_INCREMENT, ' +
                            '	Datefrom DATETIME NULL DEFAULT NULL, ' +
                            '	dateto DATEtIME NULL DEFAULT NULL, ' +
                            '	month1 VARCHAR(15) NULL DEFAULT NULL, ' +
                            '	MONTH2 VARCHAR(15) NULL DEFAULT NULL, ' +
                            '	MONTH3 VARCHAR(15) NULL DEFAULT NULL, ' +
                            '	invoicetotal DOUBLE NULL DEFAULT NULL, ' +
                            '	quotetotal DOUBLE NULL DEFAULT NULL, ' +
                            '	PRIMARY KEY (id), ' +
                            '	UNIQUE INDEX Datefrom (Datefrom)) COLLATE="utf8_general_ci" ENGINE=MyISAM;'+
                            ' INSERT IGNORE INTO tmp_VS1_Dashboard_SalesList (Datefrom, dateto, month1, MONTH2, MONTH3 ,invoicetotal, quotetotal) ' +
                            ' Select date_add(date_add(LAST_DAY(SaleDate),interval 1 DAY),interval -1 MONTH) Datefrom, ' +
                            ' LAST_DAY(SaleDate) dateto, ' +
                            ' DATE_FORMAT(SaleDate,"%M") AS month1, ' +
                            ' DATE_FORMAT(SaleDate,"%b") AS MONTH2, ' +
                            ' DATE_FORMAT(SaleDate,"%b-%Y") AS MONTH3, ' +
                            ' SUM(if(TYPE="Invoice",Totalamountinc,0))  invoicetotal,' +
                            ' SUM(if(TYPE="Quote",Totalamountinc,0))  quotetotal '+
                            ' FROM (' +sct.SQL.text +') aa       '+
                            ' where SaleDate between ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDtfrom)) +' and ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDtto)) +
                            ' GROUP BY LAST_DAY(SaleDate);'+

                            'DROP TABLE IF EXISTS tmp_VS1_Dashboard_SalesPerEmployee;' +
                            'CREATE TABLE tmp_VS1_Dashboard_SalesPerEmployee SELECT ' +
                            'Employeeid, employeename, ' +
                            'SUM(IF(TYPE <> "Quote"  , Totalamountinc,0)) Totalsales, ' +
                            'SUM(IF(TYPE = "Invoice" , Totalamountinc,0)) invoicetotal, ' +
                            'SUM(IF(TYPE = "Quote"   , Totalamountinc,0)) quotetotal ' +
                            'FROM (' + sct.SQL.text + ') aa     ' +
                            'WHERE SaleDate BETWEEN  ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, aDtfrom)) +' AND ' + quotedStr(FormatDateTime(MysqlDateTimeFormat, aDtto)) +
                            'GROUP BY EmployeeId ORDER BY Totalsales LIMIT 5;';

          aDate :=  StartOfThemonth(aDtFrom);
          while aDate <= aDtTo do begin
            sct.SQL.add('INSERT IGNORE INTO tmp_VS1_Dashboard_SalesList (Datefrom, dateto, month1, MONTH2, MONTH3 ,invoicetotal, quotetotal) '+
                                                                      ' SELECT ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDate))+' Datefrom, '+
                                                                      ' LAST_DAY('+quotedStr(Formatdatetime(mysqldatetimeformat,aDate))+') DateTo, '+
                                                                      ' DATE_FORMAT( ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDate))+',"%M") AS month1, ' +
                                                                      ' DATE_FORMAT( ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDate))+',"%b") AS MONTH2, ' +
                                                                      ' DATE_FORMAT( ' + quotedStr(Formatdatetime(mysqldatetimeformat,aDate))+',"%b-%Y") AS MONTH3, ' +
                                                                      ' 0.0 as invoicetotal, 0.0 as quotetotal ;' );

            aDate := incmonth(aDate,1);
          end;


          sct.Execute;
      finally
        Freeandnil(fReportSQLObj);
      end;
  end;

  procedure Make_VS1_PnLReport;
  var
    fReportSQLObj : TProfitAndLossReport;
    aParams:TJsonObject;
  begin
      fReportSQLObj := TProfitAndLossReport.Create;
      try
        aParams := jo;
        aParams.DT[TAG_DATEFROM] := aDtFrom;
        aParams.DT[TAG_DATETO]   := aDtto;
        fReportSQLObj.AssignParams(aParams);
        sct.SQL.Clear;
        fReportSQLObj.PopulateReportSQL(sct.SQL, msg);
        sct.SQL.text := ' DROP TABLE IF EXISTS tmp_VS1_Dashboard_PNL;' +
                        ' CREATE TABLE tmp_VS1_Dashboard_PNL ' + sct.SQL.text +
//                        ' DELETE FROM tmp_VS1_Dashboard_PNL  WHERE NOT(`account type` LIKE "Total%" OR `account type` LIKE "Net%");' +
                        ' UPDATE tmp_VS1_Dashboard_Summary Set PnL_TotalIncomeEx  =(SELECT totalAmountEx  FROM tmp_VS1_Dashboard_PNL   WHERE UCASE(`account type`)  = UCASE("Total Income"));' +
                        ' UPDATE tmp_VS1_Dashboard_Summary Set PnL_TotalIncomeInc =(SELECT TotalAmountinc FROM tmp_VS1_Dashboard_PNL   WHERE UCASE(`account type`)  = UCASE("Total Income"));' +
                        ' UPDATE tmp_VS1_Dashboard_Summary Set PnL_TotalExpenseEx =(SELECT totalAmountEx  FROM tmp_VS1_Dashboard_PNL   WHERE UCASE(`account type`)  = UCASE("Total Expenses"));' +
                        ' UPDATE tmp_VS1_Dashboard_Summary Set PnL_TotalExpenseIn =(SELECT TotalAmountinc FROM tmp_VS1_Dashboard_PNL   WHERE UCASE(`account type`)  = UCASE("Total Expenses"));' +
                        ' UPDATE tmp_VS1_Dashboard_Summary Set PnL_TotalCOGSEx    =(SELECT totalAmountEx  FROM tmp_VS1_Dashboard_PNL   WHERE UCASE(`account type`)  = UCASE("Total COGS"));' +
                        ' UPDATE tmp_VS1_Dashboard_Summary Set PnL_TotalCOGSIn    =(SELECT TotalAmountinc FROM tmp_VS1_Dashboard_PNL   WHERE UCASE(`account type`)  = UCASE("Total COGS"));' +
                        ' UPDATE tmp_VS1_Dashboard_Summary Set PnL_NetIncomeEx    =(SELECT totalAmountEx  FROM tmp_VS1_Dashboard_PNL   WHERE UCASE(`account type`)  = UCASE("Net Income"));' +
                        ' UPDATE tmp_VS1_Dashboard_Summary Set PnL_NetIncomeIn    =(SELECT TotalAmountinc FROM tmp_VS1_Dashboard_PNL   WHERE UCASE(`account type`)  = UCASE("Net Income"));' ;
        sct.Execute;
      finally
        Freeandnil(fReportSQLObj);
      end;
  end;

  procedure Make_VS1_Sum;
  begin
    sct.SQL.Clear;
    sct.SQL.AdD('DROP table if EXISTS tmp_VS1_Dashboard_Summary;');
    sct.SQL.AdD('CREATE TABLE tmp_VS1_Dashboard_Summary ( ' +
                    ' ID                                  INT(11) NOT NULL AUTO_INCREMENT, ' +
                    ' ReportsDate                         DateTime Null Default Null,'+
                    ' ERPVersionNo                        INT(11)  DEFAULT NULL, ' +
                    ' ERPVersionStr                       VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_POBox                   VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_POBox2                  VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_POBox3                  VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_POCity                  VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_POState                 VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_POPostcode              VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_POCountry               VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_ABN                     VARCHAR(15 )  DEFAULT NULL, ' +
                    ' Companyinfo_CompanyName             VARCHAR(200)  DEFAULT NULL, ' +
                    ' Companyinfo_TradingName             VARCHAR(200)  DEFAULT NULL, ' +
                    ' Companyinfo_Address                 VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_Address2                VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_Address3                VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_PhoneNumber             VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_URL                     VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_Email                   VARCHAR(255)  DEFAULT NULL, ' +
                    ' Companyinfo_IsSetupWizard           ENUM("T","F") DEFAULT "F",  ' +

                    ' ColumnHeadings_DefaultClass         VARCHAR(30)   DEFAULT NULL, ' +
                    ' ColumnHeadings_DefaultUOM           VARCHAR(100)  DEFAULT NULL, ' +

                    ' ReportsDateFrom                     DateTime Null Default Null,'+
                    ' ReportsDateTo                       DateTime Null Default Null,'+

                    ' RegionalOptions_CurrencySymbol      VARCHAR(3)    DEFAULT NULL, ' +
                    ' RegionalOptions_ForeignExDefault    VARCHAR(255)  DEFAULT NULL, ' +
                    ' RegionalOptions_TaxCodePurchaseInc  VARCHAR(255)  DEFAULT NULL, ' +
                    ' RegionalOptions_TaxCodeSalesInc     VARCHAR(255)  DEFAULT NULL, ' +

                    ' OVERDUE_INVOICES_AMOUNT             DOUBLE        DEFAULT NULL, ' +
                    ' OVERDUE_INVOICES_QUANTITY           INT(11)       DEFAULT NULL, ' +
                    ' OUTSTANDING_PAYABLES_AMOUNT         DOUBLE        DEFAULT NULL, ' +
                    ' OUTSTANDING_PAYABLES_QUANTITY       INT(11)       DEFAULT NULL, ' +

                    ' OVERDUE_PAYABLES_AMOUNT             DOUBLE        DEFAULT NULL, ' +
                    ' OVERDUE_PAYABLES_QUANTITY           INT(11)       DEFAULT NULL, ' +
                    ' OUTSTANDING_INVOICES_AMOUNT         DOUBLE        DEFAULT NULL, ' +
                    ' OUTSTANDING_INVOICES_QUANTITY       INT(11)       DEFAULT NULL, ' +

                    ' PnL_TotalIncomeEx                   DOUBLE NOT NULL DEFAULT 0 , ' +
                    ' PnL_TotalIncomeInc                  DOUBLE NOT NULL DEFAULT 0 , ' +
                    ' PnL_TotalExpenseEx                  DOUBLE NOT NULL DEFAULT 0 , ' +
                    ' PnL_TotalExpenseIn                  DOUBLE NOT NULL DEFAULT 0 , ' +
                    ' PnL_TotalCOGSEx                     DOUBLE NOT NULL DEFAULT 0 , ' +
                    ' PnL_TotalCOGSIn                     DOUBLE NOT NULL DEFAULT 0 , ' +
                    ' PnL_NetIncomeEx                     DOUBLE NOT NULL DEFAULT 0 , ' +
                    ' PnL_NetIncomeIn                     DOUBLE NOT NULL DEFAULT 0 , ' +

                    ' PRIMARY KEY (ID) ' +
                    ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');
    sct.SQL.Add('INSERT INTO tmp_VS1_Dashboard_Summary SET ReportsDate =' +quotedStr(FormatDateTime(mysqldatetimeformat,Now))+',  '+
                                                        '  ReportsDateFrom =' +quotedStr(FormatDateTime(mysqldatetimeformat,aDtfrom))+', '+
                                                        '  ReportsDateTo =' +quotedStr(FormatDateTime(mysqldatetimeformat,aDtTo))+';');
    sct.SQL.Add('UPDATE tmp_VS1_Dashboard_Summary T, tblupdatedetails U SET T.ERPVersionNo=VersionToNo(U.VERSION), T.ERPVersionStr=U.VERSION;');

                {Sales and po summary}
    sct.SQL.Add('DROP TABLE IF EXISTS tmp_VS1_Dashboard_Summary_1; ' +
                'CREATE TABLE tmp_VS1_Dashboard_Summary_1 SELECT ' +
//                        '(SELECT SUM(balance) FROM tblsales WHERE isinvoice = "T" AND IFNULL(balance,0) <> 0 ) as OVERDUE_INVOICES_AMOUNT, '+
//                        '(SELECT COUNT(SaleID) FROM tblsales WHERE isinvoice = "T" AND IFNULL(balance,0) <> 0 ) as OVERDUE_INVOICES_QUANTITY, '+
//                        '(SELECT SUM(balance) FROM tblpurchaseorders WHERE isPO="T" OR isbill="T" OR iscredit="T" AND IFNULL(balance,0) <> 0 ) as OUTSTANDING_PAYABLES_AMOUNT, '+
//                        '(SELECT COUNT(PurchaseorderID) FROM tblpurchaseorders WHERE isPO="T" OR isbill="T" OR iscredit="T" AND IFNULL(balance,0) <> 0 ) as OUTSTANDING_PAYABLES_QUANTITY; ');
                {these 2 fields should match accounts receivable report(with default option) as its the drill down option}
                '(SELECT SUM(balance) FROM tblsales WHERE (isinvoice="T" or isrefund="T")  and DueDate < NOW() AND IFNULL(balance,0) <> 0 ) as OVERDUE_INVOICES_AMOUNT, '+
                '(SELECT COUNT(SaleID) FROM tblsales WHERE (isinvoice="T" or isrefund="T")  and DueDate < NOW() AND IFNULL(balance,0) <> 0 ) as OVERDUE_INVOICES_QUANTITY, '+
                {these 2 fields should match accounts payable(with default option) for drill down}
                //'(SELECT SUM(balance) FROM tblpurchaseorders WHERE (isPO="T" OR isbill="T" OR iscredit="T") AND IFNULL(balance,0) <> 0 ) as OUTSTANDING_PAYABLES_AMOUNT, '+
                '(SELECT SUM(IF(IsCredit ="T", IFNULL(-balance,0.00), IFNULL(balance,0.00))) '+
                    ' FROM tblpurchaseorders  ' +
                    ' WHERE (((isPO="T") and (char_length(tblPurchaseOrders.InvoiceNumber)>0)) OR isbill="T" OR iscredit="T")  '+
                    ' AND IFNULL(balance,0) <> 0 ) as OUTSTANDING_PAYABLES_AMOUNT, '+
                '(SELECT COUNT(PurchaseorderID)  ' +
                    ' FROM tblpurchaseorders  '+
                    ' WHERE (((isPO="T") and (char_length(tblPurchaseOrders.InvoiceNumber)>0)) OR isbill="T" OR iscredit="T")  '+
                    ' AND IFNULL(balance,0) <> 0 ) as OUTSTANDING_PAYABLES_QUANTITY; ');

    sct.SQL.AdD('UPDATE tmp_VS1_Dashboard_Summary T , tmp_VS1_Dashboard_Summary_1 T1 SET ' +
                        'T.OVERDUE_INVOICES_AMOUNT      = T1.OVERDUE_INVOICES_AMOUNT, ' +
                        'T.OVERDUE_INVOICES_QUANTITY    = T1.OVERDUE_INVOICES_QUANTITY, ' +
                        'T.OUTSTANDING_PAYABLES_AMOUNT  = T1.OUTSTANDING_PAYABLES_AMOUNT, ' +
                        'T.OUTSTANDING_PAYABLES_QUANTITY= T1.OUTSTANDING_PAYABLES_QUANTITY;');

    if not Devmode then sct.SQL.AdD('Drop table if exists tmp_VS1_Dashboard_Summary_1;');

    sct.SQL.AdD('DROP TABLE IF EXISTS tmp_VS1_Dashboard_Summary_1_1; ' +
                'CREATE TABLE tmp_VS1_Dashboard_Summary_1_1 SELECT ' +
                '(SELECT SUM(balance) FROM tblpurchaseorders WHERE (((isPO="T") and (char_length(tblPurchaseOrders.InvoiceNumber)>0))  '+
                    ' OR isbill="T" OR iscredit="T")  '+
                    ' AND IFNULL(balance,0) <> 0  '+
                    ' AND DueDate < NOW() ) as OVERDUE_PAYABLES_AMOUNT, ' +
                '(SELECT COUNT(PurchaseorderID)  '+
                    ' FROM tblpurchaseorders  '+
                    ' WHERE (((isPO="T") and (char_length(tblPurchaseOrders.InvoiceNumber)>0))  '+
                    ' OR isbill="T" OR iscredit="T")  '+
                    ' AND IFNULL(balance,0) <> 0  '+
                    ' AND DueDate < NOW() ) as OVERDUE_PAYABLES_QUANTITY, ' +
                '(SELECT SUM(balance)  FROM tblsales WHERE (isinvoice = "T" or isrefund="T") AND IFNULL(balance, 0) <> 0 ) as OUTSTANDING_INVOICES_AMOUNT, ' +
                '(SELECT COUNT(SaleID) FROM tblsales WHERE (isinvoice = "T" or isrefund="T") AND IFNULL(balance, 0) <> 0 ) as OUTSTANDING_INVOICES_QUANTITY; ');

    sct.SQL.AdD('UPDATE tmp_VS1_Dashboard_Summary T, tmp_VS1_Dashboard_Summary_1_1 T1 SET ' +
                      'T.OVERDUE_PAYABLES_AMOUNT      = T1.OVERDUE_PAYABLES_AMOUNT, ' +
                      'T.OVERDUE_PAYABLES_QUANTITY    = T1.OVERDUE_PAYABLES_QUANTITY, ' +
                      'T.OUTSTANDING_INVOICES_AMOUNT  = T1.OUTSTANDING_INVOICES_AMOUNT, ' +
                      'T.OUTSTANDING_INVOICES_QUANTITY= T1.OUTSTANDING_INVOICES_QUANTITY;');

    if not Devmode then sct.SQL.AdD('DROP TABLE IF EXISTS tmp_VS1_Dashboard_Summary_1_1;');

    {REgional Options}
    sct.SQL.AdD('Drop table if exists tmp_VS1_Dashboard_Summary_2;');
    sct.SQL.AdD('Create table tmp_VS1_Dashboard_Summary_2 Select  ' + quotedstr(AppenvVirt.Str['RegionalOptions.Region'])+' as PrefRegion,  CurrencySymbol,  ForeignExDefault, TaxCodePurchaseInc, TaxCodeSalesInc '+
                                              ' FROM tblregionaloptions WHERE region = ' + quotedstr(AppenvVirt.Str['RegionalOptions.Region'])+';');
    sct.SQL.AdD('update tmp_VS1_Dashboard_Summary T , tmp_VS1_Dashboard_Summary_2 T1 Set T.RegionalOptions_CurrencySymbol     = T1.CurrencySymbol,   '+
                                                                   ' T.RegionalOptions_ForeignExDefault   = T1.ForeignExDefault, '+
                                                                   ' T.RegionalOptions_TaxCodePurchaseInc = T1.TaxCodePurchaseInc,  '+
                                                                   ' T.RegionalOptions_TaxCodeSalesInc    = T1.TaxCodeSalesInc;');
    if not Devmode then sct.SQL.AdD('Drop table if exists tmp_VS1_Dashboard_Summary_2;');
    {Column heading}
    sct.SQL.AdD('Drop table if exists tmp_VS1_Dashboard_Summary_3;');

    sct.SQL.AdD('Create table tmp_VS1_Dashboard_Summary_3 SELECT  DefaultClass, DefaultUOM FROM tblcolumnheadings;');
    sct.SQL.AdD('update tmp_VS1_Dashboard_Summary T , tmp_VS1_Dashboard_Summary_3 T1 Set T.ColumnHeadings_DefaultClass     = T1.DefaultClass,   '+
                                                                   ' T.ColumnHeadings_DefaultUOM       = T1.DefaultUOM;');

    if not Devmode then sct.SQL.AdD('Drop table if exists tmp_VS1_Dashboard_Summary_3;');

    {Companyinfo}
    sct.SQL.AdD('Drop table if exists tmp_VS1_Dashboard_Summary_4;');

    sct.SQL.AdD('CREATE TABLE tmp_VS1_Dashboard_Summary_4 SELECT PoBox, PoBox2,PoBox3, PoCity, PoState, PoPostcode, PoCountry, abn, CompanyName, TradingName, PhoneNumber, Address, Address2, Address3, URL, Email, IsSetupWizard FROM tblcompanyinformation;');
    sct.SQL.AdD('UPDATE tmp_VS1_Dashboard_Summary T, tmp_VS1_Dashboard_Summary_4 T1 ' +
                  'SET T.Companyinfo_PoBox          = T1.PoBox, ' +
                   '   T.Companyinfo_PoBox2         = T1.PoBox2, ' +
                   '   T.Companyinfo_PoBox3         = T1.PoBox3, ' +
                   '   T.Companyinfo_PoCity         = T1.PoCity, ' +
                   '   T.Companyinfo_PoState        = T1.PoState, ' +
                   '   T.Companyinfo_PoPostcode     = T1.PoPostcode, ' +
                   '   T.Companyinfo_PoCountry      = T1.PoCountry, ' +
                   '   T.Companyinfo_abn            = T1.abn, ' +
                   '   T.Companyinfo_CompanyName    = T1.CompanyName, ' +
                   '   T.Companyinfo_TradingName    = T1.TradingName, ' +
                   '   T.Companyinfo_PhoneNumber    = T1.PhoneNumber, ' +
                   '   T.Companyinfo_Address        = T1.Address, ' +
                   '   T.Companyinfo_Address2       = T1.Address2, ' +
                   '   T.Companyinfo_Address3       = T1.Address3, ' +
                   '   T.Companyinfo_URL            = T1.URL, ' +
                   '   T.Companyinfo_Email          = T1.Email, ' +
                   '   T.Companyinfo_IsSetupWizard  = T1.IsSetupWizard  ;');
    if not Devmode then sct.SQL.AdD('DROP TABLE IF EXISTS tmp_VS1_Dashboard_Summary_4;');

    sct.Execute;
  end;

  procedure Make_VS1_PQASumList;
  begin
    sct.SQL.Clear;
    sct.SQL.AdD(SQLtoAddDataToProductMovementTable('tmp_vs1_report_productmovement', '', True, 0, 0));
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblpqatranstypes TT on T.PQATranstype = T.TransType Set T.cTranstype = TT.description;');
    sct.SQL.AdD('Update tmp_vs1_report_productmovement T Set T.cTranstype = transType ;');
    sct.SQL.AdD('Update tmp_vs1_report_productmovement T Set T.cTranstype = ''Layby'' where T.transType =''TPOSLaybylines'';' );
    sct.SQL.AdD('Update tmp_vs1_report_productmovement T Set T.cTranstype = ''Sales Order (From Stock)'' where T.transType =''Sales Order'' and T.FromStock ="T";');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.PARTSDESCRIPTION = P.PARTSDESCRIPTION;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.PURCHASEDESC     = P.PURCHASEDESC;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD1  = P.CUSTFLD1 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD2  = P.CUSTFLD2 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD3  = P.CUSTFLD3 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD4  = P.CUSTFLD4 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD5  = P.CUSTFLD5 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD6  = P.CUSTFLD6 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD7  = P.CUSTFLD7 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD8  = P.CUSTFLD8 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD9  = P.CUSTFLD9 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD10 = P.CUSTFLD10;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD11 = P.CUSTFLD11;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD12 = P.CUSTFLD12;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD13 = P.CUSTFLD13;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD14 = P.CUSTFLD14;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTFLD15 = P.CUSTFLD15;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTDATE1 = P.CUSTDATE1;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTDATE2 = P.CUSTDATE2;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.CUSTDATE3 = P.CUSTDATE3;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.BARCODE   = P.BARCODE;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.SellQTY1  = P.SellQTY1;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.SellQTY2  = P.SellQTY2 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.SellQTY3  = P.SellQTY3;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.PRICE1    = P.PRICE1;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.PRICE2    = P.PRICE2;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.PRICE3    = P.PRICE3 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.PRICEINC1 = P.PRICEINC1;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.PRICEINC2 = P.PRICEINC2;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.PRICEINC3 = P.PRICEINC3;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.BuyQTY1   = P.BuyQTY1;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.BuyQTY2   = P.BuyQTY2;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.BuyQTY3   = P.BuyQTY3;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.COST1     = P.COST1;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.COST2     = P.COST2;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.COST3     = P.COST3;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.AvgCost   = P.AvgCost;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.COSTINC1  = P.COSTINC1;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.COSTINC2  = P.COSTINC2 ;');
    sct.SQL.AdD('update tmp_vs1_report_productmovement T inner join tblParts P ON T.ProductID = P.partsId SET T.COSTINC3  = P.COSTINC3;');

    sct.Execute;
  end;

  procedure Make_VS1_Sum2;
  var
    Params: TJSONObject;
    PnLReport: TProfitAndLossReport;
    BalanceObj: TBalanceSheetReport;
    TempScript: TERPScript;
    fDTFrom1, fDTTo1: TDateTime;
    fDTFrom2, fDTTo2: TDateTime;
    fSelDate: TDateTime;
    DateFrom1, DateTo1: String;
    DateFrom2, DateTo2: String;
  begin
    fSelDate := Date;

    fDTFrom1 := StartOfTheMonth(IncMonth(fSelDate, -2));
    fDTTo1 := EndOfTheMonth(IncMonth(fSelDate, -2));
    fDTFrom2 := StartOfTheMonth(IncMonth(fSelDate, -1));
    fDTTo2 := EndOfTheMonth(IncMonth(fSelDate, -1));

    DateFrom1 := FormatDateTime(MysqlDateFormat, fDTFrom1);
    DateTo1 := FormatDateTime(MysqlDateFormat, fDTTo1);
    DateFrom2 := FormatDateTime(MysqlDateFormat, fDTFrom2);
    DateTo2 := FormatDateTime(MysqlDateFormat, fDTTo2);

    // Create PnL table for two periods
    MakePnLReportSum(fDTFrom1, fDTTo1, 1);
    MakePnLReportSum(fDTFrom2, fDTTo2, 2);

    sct.SQL.Clear;

    sct.SQL.Add('DROP TABLE IF EXISTS tmp_vs1_dashboard_exec_set1;');
    sct.SQL.Add('CREATE TABLE tmp_vs1_dashboard_exec_set1 ( ' +
                ' ID                     INT(11)  NOT NULL AUTO_INCREMENT, ' +
                ' DateFrom1               DATETIME NULL DEFAULT NULL, ' +
                ' DateTo1                 DATETIME NULL DEFAULT NULL, ' +
                ' DateFrom2               DATETIME NULL DEFAULT NULL, ' +
                ' DateTo2                 DATETIME NULL DEFAULT NULL, ' +

                ' Cash_Received1          DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Cash_Received2          DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Cash_Spent1             DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Cash_Spent2             DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Cash_Surplus1           DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Cash_Surplus2           DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Cash_Balance1           DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Cash_Balance2           DOUBLE   NOT NULL DEFAULT 0, ' +

                ' Prof_Income1            DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Prof_Income2            DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Prof_Gross1             DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Prof_Gross2             DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Prof_Expenses1          DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Prof_Expenses2          DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Prof_Net1               DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Prof_Net2               DOUBLE   NOT NULL DEFAULT 0, ' +

                ' Income_Invoices1        INT(11)  NOT NULL DEFAULT 0, ' +
                ' Income_Invoices2        INT(11)  NOT NULL DEFAULT 0, ' +
                ' Income_Average1         DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Income_Average2         DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Income_Total1           DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Income_Total2           DOUBLE   NOT NULL DEFAULT 0, ' +

                ' Perf_GrossMargin1       DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Perf_GrossMargin2       DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Perf_NetMargin1         DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Perf_NetMargin2         DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Perf_ROI1               DOUBLE   NOT NULL DEFAULT 0, ' +
                ' Perf_ROI2               DOUBLE   NOT NULL DEFAULT 0, ' +

                ' Bal_Debtors1            DOUBLE  NOT NULL DEFAULT 0, ' +
                ' Bal_Debtors2            DOUBLE  NOT NULL DEFAULT 0, ' +
                ' Bal_Creditors1          DOUBLE  NOT NULL DEFAULT 0, ' +
                ' Bal_Creditors2          DOUBLE  NOT NULL DEFAULT 0, ' +
                ' Bal_NetAsset1           DOUBLE  NOT NULL DEFAULT 0, ' +
                ' Bal_NetAsset2           DOUBLE  NOT NULL DEFAULT 0, ' +

                ' Pos_AvgDebtDays1        INT(11) NOT NULL DEFAULT 0, ' +
                ' Pos_AvgDebtDays2        INT(11) NOT NULL DEFAULT 0, ' +
                ' Pos_AvgCredDays1        INT(11) NOT NULL DEFAULT 0, ' +
                ' Pos_AvgCredDays2        INT(11) NOT NULL DEFAULT 0, ' +
                ' Pos_CashForecast1       DOUBLE  NOT NULL DEFAULT 0, ' +
                ' Pos_CashForecast2       DOUBLE  NOT NULL DEFAULT 0, ' +
                ' Pos_AssetToLiab1        DOUBLE  NOT NULL DEFAULT 0, ' +
                ' Pos_AssetToLiab2        DOUBLE  NOT NULL DEFAULT 0, ' +

                ' Sheet_AssetToLiab1      DOUBLE  NOT NULL DEFAULT 0, ' +
                ' Sheet_AssetToLiab2      DOUBLE  NOT NULL DEFAULT 0, ' +

                ' PRIMARY KEY (ID) ' +
                ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_exec_set1 SET DateFrom1=' + QuotedStr(DateFrom1) + ';');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET DateTo1=' + QuotedStr(DateTo1) + ';');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET DateFrom2=' + QuotedStr(DateFrom2) + ';');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET DateTo2=' + QuotedStr(DateTo2) + ';');

     // Cash
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 T, (SELECT TRUNCATE(SUM(DebitsInc), 4) AS Received FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ') T1 SET T.Cash_Received1=T1.Received;');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 T, (SELECT TRUNCATE(SUM(DebitsInc), 4) AS Received FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ') T1 SET T.Cash_Received2=T1.Received;');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 T, (SELECT TRUNCATE(SUM(CreditsEx), 4) AS Spent 	 FROM tbltransactions	WHERE (AccountType="BANK" OR AccountType="CCARD") AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ') T1 SET T.Cash_Spent1=T1.Spent;');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 T, (SELECT TRUNCATE(SUM(CreditsEx), 4) AS Spent 	 FROM tbltransactions	WHERE (AccountType="BANK" OR AccountType="CCARD") AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ') T1 SET T.Cash_Spent2=T1.Spent;');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 T, (SELECT TRUNCATE(SUM(DebitsInc) - SUM(CreditsEx), 4) AS Surplus FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ') T1 SET T.Cash_Surplus1=T1.Surplus;');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 T, (SELECT TRUNCATE(SUM(DebitsInc) - SUM(CreditsEx), 4) AS Surplus FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ') T1 SET T.Cash_Surplus2=T1.Surplus;');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 T, (SELECT TRUNCATE(SUM(DebitsInc), 4) AS Balance FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ') T1 SET T.Cash_Balance1=T1.Balance;');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 T, (SELECT TRUNCATE(SUM(DebitsInc), 4) AS Balance FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ') T1 SET T.Cash_Balance2=T1.Balance;');

    // Profitability
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Prof_Income1=(SELECT totalAmountEx FROM tmp_PNL_Data1 WHERE UCASE(`account type`)=UCASE("Total Income"));');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Prof_Income2=(SELECT totalAmountEx FROM tmp_PNL_Data2 WHERE UCASE(`account type`)=UCASE("Total Income"));');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Prof_Gross1=(SELECT totalAmountEx FROM tmp_PNL_Data1 WHERE UCASE(`account type`)=UCASE("Gross Profit"));');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Prof_Gross2=(SELECT totalAmountEx FROM tmp_PNL_Data2 WHERE UCASE(`account type`)=UCASE("Gross Profit"));');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Prof_Expenses1=(SELECT totalAmountEx FROM tmp_PNL_Data1 WHERE UCASE(`account type`)=UCASE("Total Expenses"));');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Prof_Expenses2=(SELECT totalAmountEx FROM tmp_PNL_Data2 WHERE UCASE(`account type`)=UCASE("Total Expenses"));');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Prof_Net1=(SELECT totalAmountEx FROM tmp_PNL_Data1 WHERE UCASE(`account type`)=UCASE("Net Income"));');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Prof_Net2=(SELECT totalAmountEx FROM tmp_PNL_Data2 WHERE UCASE(`account type`)=UCASE("Net Income"));');

    // Income
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Income_Invoices1=' +
                  '(SELECT COUNT(*) FROM tblsales WHERE IsInvoice="T" AND Deleted="F"  AND Saledate BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Income_Invoices2=' +
                  '(SELECT COUNT(*) FROM tblsales WHERE IsInvoice="T" AND Deleted="F"  AND Saledate BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Income_Average1=' +
                  '(SELECT AVG(TotalAmountInc) FROM tblsales WHERE IsInvoice="T" AND Deleted="F"  AND Saledate BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Income_Average2=' +
                  '(SELECT AVG(TotalAmountInc) FROM tblsales WHERE IsInvoice="T" AND Deleted="F"  AND Saledate BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Income_Total1=' +
                  '(SELECT SUM(TotalAmountInc) FROM tblsales WHERE IsInvoice="T" AND Deleted="F" AND Saledate BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Income_Total2=' +
                  '(SELECT SUM(TotalAmountInc) FROM tblsales WHERE IsInvoice="T" AND Deleted="F" AND Saledate BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

    // Performance
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Perf_GrossMargin1=TRUNCATE((Prof_Income1 - (SELECT totalAmountEx FROM tmp_PNL_Data1 WHERE UCASE(`account type`) = UCASE("Total COGS"))) * 100 / Prof_Income1, 2);');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Perf_GrossMargin2=TRUNCATE((Prof_Income2 - (SELECT totalAmountEx FROM tmp_PNL_Data2 WHERE UCASE(`account type`) = UCASE("Total COGS"))) * 100 / Prof_Income2, 2);');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Perf_NetMargin1=TRUNCATE((Prof_Income1 - Prof_Expenses1) * 100 / Prof_Income1, 2);');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Perf_NetMargin2=TRUNCATE((Prof_Income2 - Prof_Expenses2) * 100 / Prof_Income2, 2);');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Perf_ROI1=TRUNCATE((Prof_Net1) * 100 / (SELECT SUM(DebitsInc) FROM tbltransactions WHERE AccountType="EQUITY"), 2);');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Perf_ROI2=TRUNCATE((Prof_Net2) * 100 / (SELECT SUM(DebitsInc) FROM tbltransactions WHERE AccountType="EQUITY"), 2);');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Perf_NetMargin1=TRUNCATE((Prof_Income1 - Prof_Expenses1) * 100 / Prof_Income1, 2);');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Perf_NetMargin2=TRUNCATE((Prof_Income2 - Prof_Expenses2) * 100 / Prof_Income2, 2);');

    // Balance Sheet
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Bal_Debtors1=' +
                  '(SELECT TRUNCATE(SUM(t.DebitsEx) - SUM(t.CreditsEx), 4) ' +
                  'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID = p.PurchaseOrderID ' +
                  'WHERE t.AccountType = "AR" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Bal_Debtors2=' +
                  '(SELECT TRUNCATE(SUM(t.DebitsEx) - SUM(t.CreditsEx), 4) ' +
                  'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID = p.PurchaseOrderID ' +
                  'WHERE t.AccountType = "AR" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Bal_Creditors1=' +
                  '(SELECT TRUNCATE(SUM(t.CreditsEx) - SUM(t.DebitsEx), 4) ' +
                  'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID = p.PurchaseOrderID ' +
                  'WHERE t.AccountType = "AP" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Bal_Creditors2=' +
                  '(SELECT TRUNCATE(SUM(t.CreditsEx) - SUM(t.DebitsEx), 4) ' +
                  'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID = p.PurchaseOrderID ' +
                  'WHERE t.AccountType = "AP" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Bal_NetAsset1=' +
                  '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) FROM tbltransactions WHERE (AccountType = "AR" OR AccountType = "BANK" OR AccountType = "OCASSET" OR AccountType = "OASSET") ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Bal_NetAsset2=' +
                  '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) FROM tbltransactions WHERE (AccountType = "AR" OR AccountType = "BANK" OR AccountType = "OCASSET" OR AccountType = "OASSET") ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

    // Position
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Pos_AvgDebtDays1=' +
                  '(SELECT SUM(IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date))) ' +
                  'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID=p.PurchaseOrderID ' +
                  'WHERE t.AccountType = "AR" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Pos_AvgDebtDays2=' +
                  '(SELECT SUM(IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date))) ' +
                  'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID=p.PurchaseOrderID ' +
                  'WHERE t.AccountType = "AR" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Pos_AvgCredDays1=' +
                  '(SELECT SUM(IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date))) ' +
                  'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID=p.PurchaseOrderID ' +
                  'WHERE t.AccountType = "AP" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Pos_AvgCredDays2=' +
                  '(SELECT SUM(IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date))) ' +
                  'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID=p.PurchaseOrderID ' +
                  'WHERE t.AccountType = "AP" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Pos_CashForecast1=' +
                  'Bal_Debtors1 - Bal_Creditors1;');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Pos_CashForecast2=' +
                  'Bal_Debtors2 - Bal_Creditors2;');

    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Pos_AssetToLiab1=Bal_NetAsset1 - ' +
                  '(SELECT IF(AccountType = "CCARD", TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4), TRUNCATE(SUM(CreditsEx) - SUM(DebitsEx), 4)) ' +
                  'FROM tbltransactions WHERE (AccountType="AP" OR AccountType="OCLIAB" OR AccountType="CCARD") ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Pos_AssetToLiab2=Bal_NetAsset2 - ' +
                  '(SELECT IF(AccountType = "CCARD", TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4), TRUNCATE(SUM(CreditsEx) - SUM(DebitsEx), 4)) ' +
                  'FROM tbltransactions WHERE (AccountType="AP" OR AccountType="OCLIAB" OR AccountType="CCARD") ' +
                  'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

    // Sheet
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Sheet_AssetToLiab1=' +
                  '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) ' +
                  '  FROM tbltransactions WHERE AccountType="OCASSET" AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ') - ' +
                  '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) ' +
                  '  FROM tbltransactions WHERE AccountType="OCLIAB" AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_exec_set1 SET Sheet_AssetToLiab2=' +
                  '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) ' +
                  '  FROM tbltransactions WHERE AccountType="OCASSET" AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ') - ' +
                  '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) ' +
                  '  FROM tbltransactions WHERE AccountType="OCLIAB" AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

    sct.Execute;
  end;

  procedure Make_VS1_Sales_Set;
  begin
    //    Set 1
    sct.SQL.Clear;

    sct.SQL.Add('DROP TABLE IF EXISTS tmp_vs1_dashboard_sales_set1;');
    sct.SQL.Add('CREATE TABLE tmp_vs1_dashboard_sales_set1 ( ' +
                ' ID              INT(11)  NOT NULL AUTO_INCREMENT, ' +
                ' NewLead         INT(11)  NOT NULL DEFAULT 0, ' +
                ' NewDeal         INT(11)  NOT NULL DEFAULT 0, ' +
                ' ClosedDeal      INT(11)  NOT NULL DEFAULT 0, ' +
                ' ClosedTotal     DOUBLE   NOT NULL DEFAULT 0, ' +
                ' WinRate         DOUBLE   NOT NULL DEFAULT 0, ' +
                ' AvgCycle        INT(11)  NOT NULL DEFAULT 0, ' +
                ' PRIMARY KEY (ID) ' +
                ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_sales_set1 SET NewLead=0;');

    // New Lead
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set1 T, ' +
                ' (SELECT COUNT(*) AS CNT FROM tblclients	' +
                ' WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" ' +
                '	AND DATEDIFF(CURDATE(), CreationDate) < 31) T1 ' +
                ' SET T.NewLead=T1.CNT;');

    // New Deal
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set1 T, ' +
                ' (SELECT COUNT(*) AS CNT FROM tblsales ' +
                ' WHERE IsQuote = "T" AND Deleted="F" AND Cancelled="F" ' +
                ' AND DATEDIFF(CURDATE(), SaleDate) < 31) T1 ' +
                ' SET T.NewDeal=T1.CNT;');

    // Closed Deals
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set1 T, ' +
                ' (SELECT SUM(Balance) AS Amount FROM tblsales ' +
                '	WHERE IsQuote="T" AND Deleted="F" AND Cancelled="F" AND Converted="T" ' +
                ' AND DATEDIFF(CURDATE(), SaleDate) < 31) T1 ' +
                ' SET T.ClosedTotal=T1.Amount;');

    // Win Rate
    sct.SQL.Add('SELECT COUNT(*) INTO @converted FROM tblsales WHERE IsQuote = "T" AND Converted = "T" AND DATEDIFF(CURDATE(), SaleDate) < 31; ' +
                'SELECT COUNT(*) INTO @all FROM tblsales WHERE IsQuote = "T" AND DATEDIFF(CURDATE(), SaleDate) < 31; ' +
                'UPDATE tmp_vs1_dashboard_sales_set1 T, ' +
                ' (SELECT ROUND(@converted / (@all) * 100, 2) AS Rate) T1 ' +
                ' SET T.WinRate=T1.Rate;');

    // Avg Sales Cycle
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set1 T, ' +
                ' (SELECT ROUND(AVG(DATEDIFF(ConvertedDate, SaleDate)), 2) Cycle FROM tblsales ' +
                '	WHERE IsQuote="T" AND Deleted="F" AND Cancelled="F" AND Converted="T" AND NOT ISNULL(ConvertedDate) ' +
                ' AND DATEDIFF(CURDATE(), SaleDate) < 31) T1 ' +
                ' SET T.ClosedTotal=IFNULL(T1.Cycle, 0);');

    sct.Execute;

    //    Set 2
    sct.SQL.Clear;

    sct.SQL.Add('DROP TABLE IF EXISTS tmp_vs1_dashboard_sales_set2;');
    sct.SQL.Add('CREATE TABLE tmp_vs1_dashboard_sales_set2 ( ' +
                ' ID              INT(11)     NOT NULL AUTO_INCREMENT, ' +
                ' EmployeeName    VARCHAR(50) NOT NULL, ' +
                ' TotalSales      DOUBLE      NOT NULL DEFAULT 0, ' +
                ' PRIMARY KEY (ID) ' +
                ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_sales_set2');
    sct.SQL.Add('(SELECT @ROW:=@ROW + 1, s.EmployeeName, IF(e.SalesTarget = 0, 0, ROUND(SUM(s.Balance) * 100 / e.SalesTarget, 2)) AS CA' +
                '	FROM tblsales s INNER JOIN tblemployees e ON s.EmployeeID=e.EmployeeID, (SELECT @row:=0) Dummy' +
                '	WHERE DATEDIFF(CURDATE(), s.SaleDate) < 31' +
                '	GROUP BY s.EmployeeID' +
                '	ORDER BY CA DESC' +
                ' LIMIT 6);');

    sct.Execute;

    //    Set 3
    sct.SQL.Clear;

    sct.SQL.Add('DROP TABLE IF EXISTS tmp_vs1_dashboard_sales_set3;');
    sct.SQL.Add('CREATE TABLE tmp_vs1_dashboard_sales_set3 ( ' +
                ' Oppts6    INT(11)   NOT NULL DEFAULT 0, ' +
                ' Status6   INT(11)   NOT NULL DEFAULT 0, ' +
                ' Oppts5    INT(11)   NOT NULL DEFAULT 0, ' +
                ' Status5   INT(11)   NOT NULL DEFAULT 0, ' +
                ' Oppts4    INT(11)   NOT NULL DEFAULT 0, ' +
                ' Status4   INT(11)   NOT NULL DEFAULT 0, ' +
                ' Oppts3    INT(11)   NOT NULL DEFAULT 0, ' +
                ' Status3   INT(11)   NOT NULL DEFAULT 0, ' +
                ' Oppts2    INT(11)   NOT NULL DEFAULT 0, ' +
                ' Status2   INT(11)   NOT NULL DEFAULT 0, ' +
                ' Oppts1    INT(11)   NOT NULL DEFAULT 0, ' +
                ' Status1   INT(11)   NOT NULL DEFAULT 0 ' +
                ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_sales_set3 SET Oppts6=0;');

    // Opportunities 6 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Oppts FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" AND `Status` = "Quoted" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 6 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 6 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Oppts6=T1.Oppts;');

    // All status 6 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Status FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 6 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 6 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Status6=T1.Status;');

    // Opportunities 5 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Oppts FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" AND `Status` = "Quoted" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 5 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 5 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Oppts5=T1.Oppts;');

    // All status 5 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Status FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 5 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 5 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Status5=T1.Status;');

    // Opportunities 4 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Oppts FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" AND `Status` = "Quoted" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 4 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 4 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Oppts4=T1.Oppts;');

    // All status 4 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Status FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 4 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 4 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Status4=T1.Status;');

    // Opportunities 3 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Oppts FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" AND `Status` = "Quoted" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 3 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 3 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Oppts3=T1.Oppts;');

    // All status 3 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Status FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 3 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 3 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Status3=T1.Status;');

    // Opportunities 2 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Oppts FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" AND `Status` = "Quoted" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 2 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 2 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Oppts2=T1.Oppts;');

    // All status 2 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Status FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 2 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 2 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Status2=T1.Status;');

    // Opportunities 1 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Oppts FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" AND `Status` = "Quoted" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 1 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Oppts1=T1.Oppts;');

    // All status 1 months before
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_sales_set3 T, ' +
                ' (SELECT COUNT(*) AS Status FROM tblclients	' +
                '   WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" ' +
                '	    AND CreationDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 1 MONTH), "%Y-%m-%d") ' +
                ' ) T1 SET T.Status1=T1.Status;');

    sct.Execute;

  end;

  procedure Make_VS1_My_Set;
  begin
    sct.SQL.Clear;

    // My Metric
    sct.SQL.Add('DROP TABLE IF EXISTS tmp_vs1_dashboard_my_set1;');
    sct.SQL.Add('CREATE TABLE tmp_vs1_dashboard_my_set1 ( ' +
                ' ID              INT(11)     NOT NULL AUTO_INCREMENT, ' +
                ' EmployeeID      INT(11)     NOT NULL DEFAULT 0, ' +
                ' NewLead         INT(11)     NOT NULL DEFAULT 0, ' +
                ' NewOppt         INT(11)     NOT NULL DEFAULT 0, ' +
                ' Quoted          INT(11)     NOT NULL DEFAULT 0, ' +
                ' Won             INT(11)     NOT NULL DEFAULT 0, ' +
                ' Gap             DOUBLE      NOT NULL DEFAULT 0.0, ' +
                ' WinRate         DOUBLE      NOT NULL DEFAULT 0.0, ' +
                ' AvgTime         DOUBLE      NOT NULL DEFAULT 0.0, ' +
                ' PipeLine        DOUBLE     NOT NULL DEFAULT 0.0, ' +
                ' PRIMARY KEY (ID) ' +
                ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_my_set1');
    sct.SQL.Add('(');     // Opening

    sct.SQL.Add('SELECT @ROW:=@ROW + 1, EmployeeID, SUM(NewLead) AS NewLead, SUM(NewOppt) AS NewOppt, SUM(Quoted) AS Quoted, SUM(Won) AS Won, SUM(Gap) AS Gap, SUM(WinRate) AS WinRate, SUM(AvgTime) AS AvgTime, SUM(PipeLine) AS PipeLIne');
    sct.SQL.Add('FROM (');
    sct.SQL.Add('SELECT RepID AS EmployeeID, COUNT(*) AS NewLead, 0 AS NewOppt, 0 AS Quoted, 0 AS Won, 0.0 AS Gap, 0.0 AS WinRate, 0.0 AS AvgTime, 0.0 AS PipeLine FROM tblclients ' +
                ' WHERE OtherContact="T" AND IsJob <> "T" AND PublishOnVS1="T" ' +
                '   AND `Status`="Unqualified" AND DATEDIFF(CURDATE(), CreationDate) < 91' +
                ' GROUP BY RepID');

    sct.SQL.Add('UNION');

    sct.SQL.Add('SELECT RepID AS EmployeeID, 0 AS NewLead, COUNT(*) AS NewOppt, 0 AS Quoted, 0 AS Won, 0.0 AS Gap, 0.0 AS WinRate, 0.0 AS AvgTime, 0.0 AS PipeLine FROM tblclients ' +
                ' WHERE OtherContact="T" AND IsJob <> "T" AND PublishOnVS1="T" ' +
                '   AND `Status`="Opportunity"	AND DATEDIFF(CURDATE(), CreationDate) < 91 ' +
                ' GROUP BY RepID');

    sct.SQL.Add('UNION');

    sct.SQL.Add('SELECT RepID AS EmployeeID, 0 AS NewLead, 0 AS NewOppt, COUNT(*) AS Quoted, 0 AS Won, 0.0 AS Gap, 0.0 AS WinRate, 0.0 AS AvgTime, 0.0 AS PipeLine FROM tblclients ' +
                ' WHERE OtherContact="T" AND IsJob <> "T" AND PublishOnVS1="T" ' +
                '   AND `Status`="Qutoed" AND DATEDIFF(CURDATE(), CreationDate) < 91 ' +
                ' GROUP BY RepID');

    sct.SQL.Add('UNION');

    sct.SQL.Add('SELECT RepID AS EmployeeID, 0 AS NewLead, 0 AS NewOppt, 0 AS Quoted, COUNT(*) AS Won, 0.0 AS Gap, 0.0 AS WinRate, 0.0 AS AvgTime, 0.0 AS PipeLine FROM tblclients ' +
                ' WHERE OtherContact="T" AND IsJob <> "T" AND PublishOnVS1="T" ' +
                '   AND `Status`="Invoiced" AND DATEDIFF(CURDATE(), CreationDate) < 91 ' +
                ' GROUP BY RepID');

    sct.SQL.Add('UNION');

    sct.SQL.Add('SELECT s.EmployeeID, 0 AS NewLead, 0 AS NewOppt, 0 AS Quoted, COUNT(*) AS Won, (SUM(s.TotalAmountInc) - e.SalesTarget) AS Gap, 0.0 AS WinRate, 0.0 AS AvgTime, 0.0 AS PipeLine ' +
                ' FROM tblsales s LEFT JOIN tblemployees e ON s.EmployeeID=e.EmployeeID' +
                ' WHERE s.IsInvoice="T" AND s.Deleted="F" AND s.Cancelled="F" AND DATEDIFF(CURDATE(), s.SaleDate) < 91' +
                ' GROUP BY s.EmployeeID');

    sct.SQL.Add('UNION');

    sct.SQL.Add('SELECT EmployeeID, 0 AS NewLead, COUNT(*) AS NewOppt, 0 AS Quoted, 0 AS Won, 0.0 AS SalesAmount, ROUND(SUM(Con) / SUM(Evr) * 100, 2) AS WinRate, 0.0 AS AvgTime, 0.0 AS PipeLine FROM ' +
                ' (SELECT EmployeeID, COUNT(*) AS Con, 0 AS Evr FROM tblsales ' +
                '   WHERE IsQuote = "T" AND Converted = "T" AND DATEDIFF(CURDATE(), SaleDate) < 91 ' +
                '   GROUP BY EmployeeID ' +
                '  UNION ' +
                '  SELECT EmployeeID, 0 AS Con, COUNT(*) AS Evr FROM tblSales ' +
                '   WHERE IsQuote = "T" AND DATEDIFF(CURDATE(), SaleDate) < 91 ' +
                '   GROUP BY EmployeeID ' +
                ' ) T1 GROUP BY EmployeeID ');

    sct.SQL.Add('UNION');

    sct.SQL.Add('SELECT IFNULL(RepID, 0) AS EmployeeID, 0 AS NewLead, COUNT(*) AS NewOppt, 0 AS Quoted, 0 AS Won, 0.0 AS SalesAmount, 0.0 AS WinRate, ' +
                '   ROUND(AVG(DATEDIFF(DATE_FORMAT(msTimeStamp, "%Y-%m-%d"), IFNULL(CreationDate, DATE_SUB(CURDATE(), INTERVAL 90 DAY)))), 2) AS AvgTime, 0.0 AS PipeLine FROM tblClients ' +
                ' WHERE OtherContact="T" AND IsJob <> "T" AND PublishOnVS1="T" ' +
                '   AND `Status`="Invoiced" AND DATEDIFF(CURDATE(), CreationDate) < 91 ' +
                ' GROUP BY RepID');

    sct.SQL.Add('UNION');

    sct.SQL.Add('SELECT EmployeeID, 0 AS NewLead, 0 AS NewOppt, 0 AS Quoted, 0 AS Won, 0.0 AS SalesAmount, 0.0 AS WinRate, 0.0 AS AvgTime, SUM(TotalAmountInc) AS PipeLine FROM tblsales ' +
                ' WHERE IsQuote = "T" AND Converted = "F" AND DATEDIFF(CURDATE(), SaleDate) < 91 ' +
                ' GROUP BY EmployeeID');

    sct.SQL.Add(') T2, (SELECT @row:=0) Dummy GROUP BY EmployeeID');
    sct.SQL.Add(')');     // Closing

    sct.Execute;

    // For Team Average
    sct.SQL.Clear;

    sct.SQL.Add('DROP TABLE IF EXISTS tmp_vs1_dashboard_my_set2;');
    sct.SQL.Add('CREATE TABLE tmp_vs1_dashboard_my_set2 ( ' +
                ' ID              INT(11)     NOT NULL AUTO_INCREMENT, ' +
                ' NewLead         INT(11)     NOT NULL DEFAULT 0, ' +
                ' NewOppt         INT(11)     NOT NULL DEFAULT 0, ' +
                ' Quoted          INT(11)     NOT NULL DEFAULT 0, ' +
                ' Won             INT(11)     NOT NULL DEFAULT 0, ' +
                ' WinRate         DOUBLE      NOT NULL DEFAULT 0.0, ' +
                ' AvgTime         DOUBLE      NOT NULL DEFAULT 0.0, ' +
                ' PipeLine        DOUBLE      NOT NULL DEFAULT 0.0, ' +
                ' PRIMARY KEY (ID) ' +
                ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_my_set2 SET NewLead=0;');

    // New Lead
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_my_set2 T, ' +
                ' (SELECT COUNT(*) AS CNT FROM tblclients	' +
                ' WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" AND `Status`="Unqualified" ' +
                '	AND DATEDIFF(CURDATE(), CreationDate) < 91) T1 ' +
                ' SET T.NewLead=T1.CNT;');

    // New Oppt
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_my_set2 T, ' +
                ' (SELECT COUNT(*) AS CNT FROM tblclients	' +
                ' WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" AND `Status`="Opportunity" ' +
                '	AND DATEDIFF(CURDATE(), CreationDate) < 91) T1 ' +
                ' SET T.NewLead=T1.CNT;');

    // Quoted
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_my_set2 T, ' +
                ' (SELECT COUNT(*) AS CNT FROM tblclients	' +
                ' WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" AND `Status`="Invoiced" ' +
                '	AND DATEDIFF(CURDATE(), CreationDate) < 91) T1 ' +
                ' SET T.NewLead=T1.CNT;');

    // Won
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_my_set2 T, ' +
                ' (SELECT COUNT(*) AS CNT FROM tblclients	' +
                ' WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" AND `Status`="Quoted" ' +
                '	AND DATEDIFF(CURDATE(), CreationDate) < 91) T1 ' +
                ' SET T.NewLead=T1.CNT;');

    // WinRate
    sct.SQL.Add('SELECT COUNT(*) INTO @converted FROM tblsales WHERE IsQuote = "T" AND Converted = "T" AND DATEDIFF(CURDATE(), SaleDate) < 31; ' +
                'SELECT COUNT(*) INTO @all FROM tblsales WHERE IsQuote = "T" AND DATEDIFF(CURDATE(), SaleDate) < 91; ' +
                'UPDATE tmp_vs1_dashboard_my_set2 T, ' +
                ' (SELECT ROUND(@converted / (@all) * 100, 2) AS WinRate) T1 ' +
                ' SET T.WinRate=T1.WinRate;');

    // Avg Time
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_my_set2 T, ' +
                ' (SELECT ROUND(AVG(DATEDIFF(DATE_FORMAT(msTimeStamp, "%Y-%m-%d"), IFNULL(CreationDate, DATE_SUB(CURDATE(), INTERVAL 90 DAY)))), 2) AS AvgTime FROM tblClients ' +
                ' WHERE OtherContact = "T" AND IsJob <> "T" AND PublishOnVS1 = "T" AND `Status`="Invoiced" ' +
                '	AND DATEDIFF(CURDATE(), CreationDate) < 91) T1 ' +
                ' SET T.AvgTime=T1.AvgTime;');

    // PipeLine
    sct.SQL.Add('UPDATE tmp_vs1_dashboard_my_set2 T, ' +
                ' (SELECT SUM(TotalAmountInc) AS PipeLine FROM tblsales ' +
                ' WHERE IsQuote = "T" AND Converted = "F" AND DATEDIFF(CURDATE(), SaleDate) < 91) T1 ' +
                ' SET T.PipeLine=T1.PipeLine;');

    sct.Execute;

    // Sales Performance vs Quota
    sct.SQL.Add('DROP TABLE IF EXISTS tmp_vs1_dashboard_my_set3;');
    sct.SQL.Add('CREATE TABLE tmp_vs1_dashboard_my_set3 ( ' +
                ' EmployeeID  INT(11)   NOT NULL DEFAULT 0, ' +
                ' Month       INT(11)   NOT NULL DEFAULT 0, ' +
                ' Quota       Double    NOT NULL DEFAULT 0, ' +
                ' Quote       Double    NOT NULL DEFAULT 0, ' +
                ' Invoice     Double    NOT NULL DEFAULT 0 ' +
                ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

    // Before 6 months
    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_my_set3');
    sct.SQL.Add('(');     // Opening
    sct.SQL.Add('SELECT EmployeeID, 6, SUM(Quota) AS Quota, SUM(Quote) AS Quote, SUM(Invoice) AS Invoice');
    sct.SQL.Add('FROM (');
    sct.SQL.Add('SELECT EmployeeID, AVG(Quota) AS Quota, 0 AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 6 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 6 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, SUM(TotalAmountInc) AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsQuote = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '	  AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 6 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 6 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, 0 AS Quote, SUM(TotalAmountInc) AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 6 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 6 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add(') T2 GROUP BY EmployeeID');
    sct.SQL.Add(');');     // Closing

    // Before 5 months
    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_my_set3');
    sct.SQL.Add('(');     // Opening
    sct.SQL.Add('SELECT EmployeeID, 5, SUM(Quota) AS Quota, SUM(Quote) AS Quote, SUM(Invoice) AS Invoice');
    sct.SQL.Add('FROM (');
    sct.SQL.Add('SELECT EmployeeID, AVG(Quota) AS Quota, 0 AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 5 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 5 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, SUM(TotalAmountInc) AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsQuote = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '	  AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 5 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 5 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, 0 AS Quote, SUM(TotalAmountInc) AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 5 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 5 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add(') T2 GROUP BY EmployeeID');
    sct.SQL.Add(');');     // Closing

    // Before 4 months
    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_my_set3');
    sct.SQL.Add('(');     // Opening
    sct.SQL.Add('SELECT EmployeeID, 4, SUM(Quota) AS Quota, SUM(Quote) AS Quote, SUM(Invoice) AS Invoice');
    sct.SQL.Add('FROM (');
    sct.SQL.Add('SELECT EmployeeID, AVG(Quota) AS Quota, 0 AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 4 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 4 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, SUM(TotalAmountInc) AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsQuote = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '	  AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 4 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 4 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, 0 AS Quote, SUM(TotalAmountInc) AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 4 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 4 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add(') T2 GROUP BY EmployeeID');
    sct.SQL.Add(');');     // Closing

    // Before 3 months
    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_my_set3');
    sct.SQL.Add('(');     // Opening
    sct.SQL.Add('SELECT EmployeeID, 3, SUM(Quota) AS Quota, SUM(Quote) AS Quote, SUM(Invoice) AS Invoice');
    sct.SQL.Add('FROM (');
    sct.SQL.Add('SELECT EmployeeID, AVG(Quota) AS Quota, 0 AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 3 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 3 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, SUM(TotalAmountInc) AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsQuote = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '	  AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 3 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 3 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, 0 AS Quote, SUM(TotalAmountInc) AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 3 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 3 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add(') T2, (SELECT @row:=0) Dummy GROUP BY EmployeeID');
    sct.SQL.Add(');');     // Closing

    // Before 2 months
    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_my_set3');
    sct.SQL.Add('(');     // Opening
    sct.SQL.Add('SELECT EmployeeID, 2, SUM(Quota) AS Quota, SUM(Quote) AS Quote, SUM(Invoice) AS Invoice');
    sct.SQL.Add('FROM (');
    sct.SQL.Add('SELECT EmployeeID, AVG(Quota) AS Quota, 0 AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 2 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 2 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, SUM(TotalAmountInc) AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsQuote = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '	  AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 2 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 2 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, 0 AS Quote, SUM(TotalAmountInc) AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 2 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 2 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add(') T2 GROUP BY EmployeeID');
    sct.SQL.Add(');');     // Closing

    // Before 1 months
    sct.SQL.Add('INSERT INTO tmp_vs1_dashboard_my_set3');
    sct.SQL.Add('(');     // Opening
    sct.SQL.Add('SELECT EmployeeID, 1, SUM(Quota) AS Quota, SUM(Quote) AS Quote, SUM(Invoice) AS Invoice');
    sct.SQL.Add('FROM (');
    sct.SQL.Add('SELECT EmployeeID, AVG(Quota) AS Quota, 0 AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 1 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, SUM(TotalAmountInc) AS Quote, 0 AS Invoice FROM tblSales ' +
                ' WHERE IsQuote = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '	  AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 1 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add('UNION');
    sct.SQL.Add('SELECT EmployeeID, 0 AS Quota, 0 AS Quote, SUM(TotalAmountInc) AS Invoice FROM tblSales ' +
                ' WHERE IsInvoice = "T" AND Deleted = "F" AND Cancelled = "F" ' +
                '   AND SaleDate BETWEEN DATE_FORMAT(CURDATE() - INTERVAL 1 MONTH, "%Y-%m-01") AND DATE_FORMAT(LAST_DAY(NOW() - INTERVAL 1 MONTH), "%Y-%m-%d") ' +
                ' GROUP BY EmployeeId ');
    sct.SQL.Add(') T2 GROUP BY EmployeeID');
    sct.SQL.Add(');');     // Closing

    sct.Execute;

  end;

  function HasVS1data: Boolean;
  begin
    Result := UtilsLib.HasVS1data(TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']));
  end;

begin
  if HasVS1data or devmode then begin
    showprogressDlg('VS1 Update', 10);
    try
      Log( 'UpdateVS1DashBoardTables :' + CurDBName, ltDetail);
      aDtFrom := IncMonth(Date, -6);
      aDtTo := IncDay(Date, +1);
      sct := NewScript;
      try
         if AppEnvVirt.Bool['CompanyPrefs.UpdatebatchRunVS1_sum']           then begin StepProgressDlg('Make VS1 Sum')              ;Log( 'UpdateVS1DashBoardTables -> Make_VS1_Sum'              ,ltDetail); try Make_VS1_Sum;             Except on E:Exception do begin Log( 'Error in Make_VS1_Sum : '              + E.message, ltDetail); end;end;end;
         if AppEnvVirt.Bool['CompanyPrefs.UpdatebatchRunVS1_PnLReport']     then begin StepProgressDlg('Make VS1 PnLPeriodReport')  ;Log( 'UpdateVS1DashBoardTables -> Make_VS1_PnLPeriodReport'  ,ltDetail); try Make_VS1_PnLPeriodReport; Except on E:Exception do begin Log( 'Error in Make_VS1_PnLPeriodReport : '  + E.message, ltDetail); end;end;end;
         if AppEnvVirt.Bool['CompanyPrefs.UpdatebatchRunVS1_PnLReport_Sum'] then begin StepProgressDlg('Make VS1 PnLReport')        ;Log( 'UpdateVS1DashBoardTables -> Make_VS1_PnLReport'        ,ltDetail); try Make_VS1_PnLReport;       Except on E:Exception do begin Log( 'Error in Make_VS1_PnLReport : '        + E.message, ltDetail); end;end;end;
         if AppEnvVirt.Bool['CompanyPrefs.UpdatebatchRunVS1_APReport']      then begin StepProgressDlg('Make VS1 APReport')         ;Log( 'UpdateVS1DashBoardTables -> Make_VS1_APReport'         ,ltDetail); try Make_VS1_APReport;        Except on E:Exception do begin Log( 'Error in Make_VS1_APReport : '         + E.message, ltDetail); end;end;end;
         if AppEnvVirt.Bool['CompanyPrefs.UpdatebatchRunVS1_SalesList']     then begin StepProgressDlg('Make VS1 SalesList')        ;Log( 'UpdateVS1DashBoardTables -> Make_VS1_SalesList'        ,ltDetail); try Make_VS1_SalesList;       Except on E:Exception do begin Log( 'Error in Make_VS1_SalesList : '        + E.message, ltDetail); end;end;end;
         if AppEnvVirt.Bool['CompanyPrefs.UpdatebatchRunVS1_PQASumList']    then begin StepProgressDlg('Make VS1 PQASumList')       ;Log( 'UpdateVS1DashBoardTables -> Make_VS1_PQASumList'       ,ltDetail); try Make_VS1_PQASumList;      Except on E:Exception do begin Log( 'Error in Make_VS1_PQASumList: '        + E.message, ltDetail); end;end;end;
         if AppEnvVirt.Bool['CompanyPrefs.UpdatebatchRunVS1_Sum2']          then begin StepProgressDlg('Make VS1 Sum2')             ;Log( 'UpdateVS1DashBoardTables -> Make_VS1_Sum2'             ,ltDetail); try Make_VS1_Sum2;            Except on E:Exception do begin Log( 'Error in Make_VS1_Sum2: '              + E.message, ltDetail); end;end;end;
         if AppEnvVirt.Bool['CompanyPrefs.UpdatebatchRunVS1_Sum2']          then begin StepProgressDlg('Make VS1 Sales_Set')        ;Log( 'UpdateVS1DashBoardTables -> Make_VS1_Sales_Set'        ,ltDetail);  try Make_VS1_Sales_Set;      Except on E:Exception do begin Log( 'Error in Make_VS1_Sales_Set: '         + E.message, ltDetail); end;end;end;
         if AppEnvVirt.Bool['CompanyPrefs.UpdatebatchRunVS1_Sum2']          then begin StepProgressDlg('Make VS1 My_Set')           ;Log( 'UpdateVS1DashBoardTables -> Make_VS1_My_Set'           ,ltDetail);  try Make_VS1_My_Set;         Except on E:Exception do begin Log( 'Error in Make_VS1_My_Set: '            + E.message, ltDetail); end;end;end;
      finally
        Freeandnil(Sct);
      end;
    finally
      if Assigned(ProgressDlg) then begin
        HideProgressdlg;
      end;
    end;
  end else begin
    Log( 'Non-VS1 Database, Doesn''t require "UpdateVS1DashBoardTables" :' + CurDBName ,ltDetail);
  end;
end;

Procedure   TTransactionTableObj.Updatecurrency(BulkSQL: TStringList);
var
    pFC                           : pFCRec;
    I                             : Integer;
    scode                         : STring;
begin
  With BulkSQL do begin
                    Add('delete from tblcurrencyconversionhistory where ifnull(sellrate,0) = 0 and ifnull(buyrate,0) = 0;');
                    GetFCs;
                    try
                        if fLstFC.count > 0 then begin
                            for I := 0 to fLstFC.count - 1 do begin
                                pFC := fLstFC.Items[I];
                                sCode :=pFC^.FCCode;
                                Add(' alter table  ' + TableName );
                                Add(' add column ' + QuotedFieldName(SCode + '_FCRate')        +'   Double Default 0 Null, ' );
                                Add(' add column ' + QuotedFieldName(SCode + '_SellDebitsEx')  +'   Double Default 0 Null, ' );
                                Add(' add column ' + QuotedFieldName(SCode + '_SellCreditsEx') +'   Double Default 0 Null, ' );
                                Add(' add column ' + QuotedFieldName(SCode + '_SellDebitsInc') +'   Double Default 0 Null, ' );
                                Add(' add column ' + QuotedFieldName(SCode + '_SellCreditsInc')+'   Double Default 0 Null;  ' );

                                      {get the currency rate on the transaction date }

                                      {rate from the transaction record - if available}
                                      Add(' update ' + TableName + ' a1, Tblwithdrawal a2' +
                                              ' set a1.' +  QuotedFieldName(SCode + '_FCRate')+' = a2.ForeignExchangeRate ' +
                                              ' where a2.ForeignExchangeCode = ' + Quotedstr(Scode) +
                                              ' and a2.PaymentID=a1.PaymentId' +
                                              ' and (a1.Type =''Supplier Payment'' ); ' );
                                      Add(' update  ' + TableName + ' a1, tblDeposits a2 ' +
                                              ' set a1.' +  QuotedFieldName(SCode + '_FCRate')+' = a2.ForeignExchangeRate  ' +
                                              ' Where a2.ForeignExchangeCode  = ' + Quotedstr(Scode) +
                                              ' and a2.PaymentID         = a1.PaymentId          ' +
                                              ' and (a1.Type =''Customer Payment'' ); ' );
                                      Add(' update  ' + TableName + ' a1,  tblSales           a2 ' +
                                              ' set a1.' +  QuotedFieldName(SCode + '_FCRate')+' = a2.ForeignExchangeRate  ' +
                                              ' Where a2.ForeignExchangeCode  = ' + Quotedstr(Scode) +
                                              ' and a2.SaleID            = a1.SaleID             ' +
                                              ' and (a1.Type =''Invoice''             or a1.type= ''Refund''    or a1.type= ''Cash Sale'' or a1.type= ''UnInvoiced SO''); ' );
                                      Add(' update  ' + TableName + ' a1,  tblpurchaseOrders  a2 ' +
                                              ' set a1.' +  QuotedFieldName(SCode + '_FCRate')+' = a2.ForeignExchangeRate  ' +
                                              ' Where a2.ForeignExchangeCode  = ' + Quotedstr(Scode) +
                                              ' and a2.PurchaseOrderId   = a1.PurchaseOrderId    ' +
                                              ' and (a1.Type =''PO''                  or a1.type= ''Bill''      or a1.type= ''Credit''    or a1.type= ''Un-Invoiced PO''     or a1.type= ''Cheque''); ' );
                                      Add(' update  ' + TableName + ' a1,  Tblprepayments     a2 ' +
                                              ' set a1.' +  QuotedFieldName(SCode + '_FCRate')+' = a2.ForeignExchangeRate  ' +
                                              ' Where a2.ForeignExchangeCode  = ' + Quotedstr(Scode) +
                                              ' and a2.PrePaymentID      = a1.PrepaymentID       ' +
                                              ' and (a1.Type ="'+AppEnvVirt.Str['tcConst.CUSTOMER_PREPAYMENT']+'" or a1.type= ''Supplier Prepayment''); ' );

                                      Add('Update  ' + TableName +
                                           ' set ' + QuotedFieldName(SCode + '_FCRate')+'  =   '+
                                                 ' (Select'+
                                                 ' ifnull((select cch.SellRate'+
                                                         ' from  tblcurrencyconversionhistory cch'+
                                                         ' where cc.CurrencyID = cch.CurrencyID'+
                                                         ' and (cch.Date <= ' + TableName + '.date )'+
                                                         ' order by cch.Date DESC'+
                                                         ' limit 1) ,cc.SellRate )'+
                                                 ' from tblcurrencyconversion cc'+
                                                 ' where cc.Code = ' + quotedStr(sCode) +');');
                                      {calculate amounts using the rate}
                                      Add('update   ' + TableName );
                                      Add('set ' + QuotedFieldName(SCode + '_SellDebitsEx')+'     = DebitsEx  * ' + QuotedFieldName(SCode + '_FCRate')+', ' );
                                      Add(         QuotedFieldName(SCode + '_SellCreditsEx')+'    = CreditsEx * ' + QuotedFieldName(SCode + '_FCRate')+', ' );
                                      Add(         QuotedFieldName(SCode + '_SellDebitsInc')+'    = DebitsInc * ' + QuotedFieldName(SCode + '_FCRate')+', ' );
                                      Add(         QuotedFieldName(SCode + '_SellCreditsInc')+'   = CreditsInc* ' + QuotedFieldName(SCode + '_FCRate')+'; ' );
                                end;
                        end;
                    finally
                      ClearFCs;
                    end;
  end;
end;

Procedure   TTransactionTableObj.DoAfterUpdate;
var
  QryProductclass, QryProduct: TERpQuery;
begin
  with TSyncReportTableObj.Create(nil) do begin
    try
      DosyncAll;
    finally
      Free;
    end;
  end;

  UpdateVS1DashBoardTables;

  {incase if productclass is missing for PQA entries}
  QryProductclass:= TERPQuery.Create(nil);
  QryProduct:= TERPQuery.Create(nil);
  try
    QryProductclass.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    QryProduct.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    QryProduct.SQL.add(' Select distinct PQA.ProductID, PQA.DepartmentID , PQA.ProductName   , C.ClassName '+
          ' from tblPQa  PQA '+
          ' inner join tblclass C on PQA.DepartmentID = C.ClassID '+
          ' LEft join tblproductClasses PC on PQa.ProductId = PC.ProductID and PQA.DepartmentID = PC.ClassID '+
          ' where ifnull(PC.classId,0) =0');
    QryProduct.Open;
    QryProductclass.SQL.Add('SELECT * from tblProductClasses limit 0');
    QryProductclass.open;
    if QryProduct.Recordcount >0 then begin
      QryProduct.first;
      While QryProduct.eof = false do begin
        if userlock.Lock('tblParts' , QryProduct.fieldbyname('ProductId').asInteger, 'UpdateBatch') then try
          try
            QryProductclass.Append;
            QryProductclass.fieldbyname('ProductID').asInteger := QryProduct.FieldByname('ProductID').asInteger;
            QryProductclass.fieldbyname('classID').asInteger := QryProduct.FieldByname('DepartmentID').asInteger;
            QryProductclass.fieldbyname('productName').AsString := QryProduct.FieldByname('ProductName').AsString;
            QryProductclass.fieldbyname('className').AsString := QryProduct.FieldByname('ClassName').AsString;
            QryProductclass.Post;
          Except
          end;
        finally
          userlock.UnLock('tblParts' , QryProduct.fieldbyname('ProductId').asInteger, 'UpdateBatch');
        end;
        QryProduct.NExt;
      end;
    end;
  finally
    Freeandnil(QryProductclass);
    Freeandnil(QryProduct);
  end;
end;

constructor TTransactionTableObj.Create(OwnerListing: boolean);
begin
  fSharedConnection := nil;
  COGSCoststatus := ccsNone;
  CreateTransObj;
  IsOwnerListing := OwnerListing;
  fOnLog := nil;
end;

function TTransactionTableObj.SumSeqno(const Value:Integer ):String;
begin
  Result := 'IF(Seqno > 100, Seqno, ' + IntToStr(Value) + ' + Seqno) AS Seqno';
end;

Function TTransactionTableObj.CreatePermanentSummaryTable: Boolean;
var
  SummarisedTransDate: TDateTime;
  qryAccountIDTemp: TERPQuery;
  qrySumTemp: TERPQuery;
  Save_Cursor: TCursor;
  Ids:String;
const
  INSERT_INTO_String  = 'INSERT HIGH_PRIORITY INTO tbltransactionsummary (Seqno, Date,ClassID,Type,AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,AccountID,AccountType, ' +
    'DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc) ';
  INSERT_INTO_String2 =
    'INSERT HIGH_PRIORITY INTO tbltransactionsummary (Seqno, Date,Type,GlobalRef,ClassID,SaleID,PurchaseOrderID,PaymentID,PrepaymentID,AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,AccountID,AccountType,ClientName, ClientID,CustomerJobId,' +
    'ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,TaxCode,TaxRate,TaxID,' +
    'DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`) ';
begin
Result := False;
if not(Lock('Update Batch / Report')) then exit;
try
  if AppEnvVirt.Bool['CompanyPrefs.BatchUpdateInProgress'] then begin
    if IsGUI then
      Vista_MessageDlg.MessageDlgXP_Vista('Batch Update is Already in Progress!', mtWarning, [mbOK], 0)
    else
      Log('Batch Update is Already in Progress!',ltWarning);
    Exit;
  end else begin
    AppEnvVirt.Bool['CompanyPrefs.BatchUpdateInProgress'] := true;
  end;

  SummarisedTransDate := AppEnvVirt.Float['CompanyPrefs.SummarisedTransDate'];
  qrySumTemp := TERPQuery.Create(nil);
  qrySumTemp.Options.FlatBuffers := True;
  qrySumTemp.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

  qryAccountIDTemp := TERPQuery.Create(nil);
  qryAccountIDTemp.Options.FlatBuffers := True;
  qryAccountIDTemp.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    with BulkSQL do begin
      Clear;
      Add('DELETE  FROM tbltransactionsummary;');
      Add('ALTER TABLE `tbltransactionsummary` CHANGE `TransID` `TransID` INT(11)  NOT NULL;');
      Add('ALTER TABLE tbltransactionsummary ENGINE = InnoDB;');
      Add('ALTER TABLE tbltransactionsummary ENGINE = MyISAM;');
      Add('ALTER TABLE `tbltransactionsummary` CHANGE `TransID` `TransID` INT(11)    NOT NULL AUTO_INCREMENT;');
      if Devmode then begin
        Add('Drop table if exists tbltransactionsummariseddetails;');
        Add('create table tbltransactionsummariseddetails like tbltransactionsummarydetails;');
        Add('Alter table tbltransactionsummariseddetails add column sumseq double;');
      end;
      {Dummy Record for Auto SummaryDetailsTable refesh}
      Add('INSERT INTO `tbltransactionsummary` ( `Date`, `Type`, `GlobalRef`, `ClassID`, `SaleID`, `PurchaseOrderID`, `PaymentID`, `PrepaymentID`,');
      Add('`FixedAssetID`, `AccountName`, `AccountGroupLevels`, `Level1`, `Level2`, `Level3`, `Level4`, `AccountID`, `AccountType`, `ClientName`,');
      Add('`ClientID`, `ProductName`, `ProductGroup`, `ProductDesc`, `RepName`, `EmployeeID`, `TaxCode`, `TaxRate`, `TaxID`, `DebitsEx`, `CreditsEx`,');
      Add('`DebitsInc`, `CreditsInc`, `CASH_DebitsEx`, `CASH_CreditsEx`, `CASH_DebitsInc`, `CASH_CreditsInc`, `Reconciled`, `Notes`, `Active`, `Chq/Ref`) VALUES ');
      Add('("1900-01-01", "Initialise Summary", "", "0", "0", "0", "0", "0", "0", "", "", "", "", "", "", "0", "", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,');
      Add('"0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "F", NULL, "T", NULL);');
    end;

    with qryAccountIDTemp do begin
      Sql.Clear;
      Sql.Add('SELECT AccountID FROM `tblchartofaccounts` ');
      Sql.Add('WHERE AccountType<>"AR" AND AccountType<>"AP" ');
      Sql.Add('AND AccountID<>'+ IntToStr(AppEnvVirt.Int['DNMLib.GetCustomerPrepaymentAccountID']) +' ');
      Sql.Add('AND AccountID<>'+ IntToStr(AppEnvVirt.Int['DNMLib.GetSupplierPrepaymentAccountID']) +' ');
      Sql.Add('Group by AccountID;');
      Open;
    end;
    qryAccountIDTemp.First;
    while not qryAccountIDTemp.Eof do begin
        BulkSQL.Add(INSERT_INTO_String);
        BulkSQL.Add('SELECT '+SumSeqno(100)+', ');
        BulkSQL.Add(Quotedstr(FormatDateTime(MysqlDateFormat, SummarisedTransDate)) +', ');
        BulkSQL.Add('ClassID,  "Closing Date Summary"  , AccountName, AccountGroupLevels,Level1, Level2, Level3, Level4, AccountID, AccountType, ');
        BulkSQL.Add('Sum(DebitsEx) as DebitsEx, Sum(CreditsEx) as CreditsEx, Sum(DebitsInc) as DebitsInc, Sum(CreditsInc) as CreditsInc ,');
        BulkSQL.Add('Sum(DebitsEx) as DebitsEx, Sum(CreditsEx) as CreditsEx, Sum(DebitsInc) as DebitsInc, Sum(CreditsInc) as CreditsInc ');
        BulkSQL.Add('FROM tbltransactionsummarydetails Where AccountID = ' + qryAccountIDTemp.FieldByName('AccountID').AsString );
        BulkSQL.add( ' Group By Date, ClassID,AccountID; ');
        if Devmode then begin
          BulkSQL.add( ' insert into  tbltransactionsummariseddetails Select * , 1 ');
          BulkSQL.add( ' FROM tbltransactionsummarydetails Where AccountID = ' + qryAccountIDTemp.FieldByName('AccountID').AsString +';');
        end;
      qryAccountIDTemp.Next;
    end;


//#####  AR  Stuff ####################################################
    {Get Account In (AR) from Details Table}
    with qryAccountIDTemp do begin
      Sql.Clear;
      Sql.Add('SELECT TRANS.ClientID,SaleID, Sum(Creditsex)- Sum(Debitsex) AS `AmountDueex` , Sum(CreditsInc)- Sum(DebitsInc)  AS `AmountDueinc`  ');
      Sql.Add('FROM tbltransactionsummarydetails TRANS  Where TRANS.AccountType = "AR" AND ');
      Sql.Add('(TRANS.TYPE = "Invoice" OR TRANS.TYPE = "Refund" OR TRANS.TYPE = "Customer Payment") ');
      Sql.Add('Group By ClientID,SaleID Order by Saleid; ');
      Open;
    end;
    Ids:= qryAccountIDTemp.groupconcat('SaleID' ,  'AmountDueinc<> 0 or AmountDueex<> 0');
    if ids<> '' then begin
        with BulkSQL do begin
          Add(INSERT_INTO_String2);
          Add('SELECT '+SumSeqno(200)+',Date,Type,GlobalRef,ClassID,SaleID,PurchaseOrderID,PaymentID,PrepaymentID,AccountName,');
          Add('AccountGroupLevels,Level1,Level2,Level3,Level4,AccountID,AccountType,ClientName, ClientID, CustomerJobId, ');
          Add('ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,TaxCode,TaxRate,TaxID, ');
          Add('DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`');
          Add('FROM tbltransactionsummarydetails TRANS ');
          Add('Where TRANS.AccountType = "AR" AND (TRANS.TYPE = "Invoice" OR TRANS.TYPE = "Refund" OR TRANS.TYPE = "Customer Payment") ');
          Add('AND SaleID in ( ' + Ids + ');');
          if Devmode then begin
            add( ' insert into  tbltransactionsummariseddetails Select * , 2');
            Add('FROM tbltransactionsummarydetails TRANS ');
            Add('Where TRANS.AccountType = "AR" AND (TRANS.TYPE = "Invoice" OR TRANS.TYPE = "Refund" OR TRANS.TYPE = "Customer Payment") ');
            Add('AND SaleID in ( ' + Ids + ');');
          end;
        end;
    end;

    {Get Account In (Customer Prepayments) from Details Table}
    with qryAccountIDTemp do begin
      Sql.Clear;
      Sql.Add('SELECT TRANS.ClientID,PrepaymentID, Sum(Creditsex)- Sum(Debitsex) AS `AmountDueex` , Sum(CreditsInc)- Sum(DebitsInc)  AS `AmountDueinc`  ');
      Sql.Add('FROM tbltransactionsummarydetails TRANS Where TRANS.AccountID = '+ IntToStr(AppEnvVirt.Int['DNMLib.GetCustomerPrepaymentAccountID']) +' ');
      Sql.Add('Group By ClientID,PrepaymentID Order by PrepaymentID; ');
      Open;
    end;
    Ids:= qryAccountIDTemp.groupconcat('PrepaymentID' ,  'AmountDueinc<> 0 or AmountDueex<> 0');
    if ids <> '' then begin
        with BulkSQL do begin
          Add(INSERT_INTO_String2);
          Add('SELECT '+SumSeqno(300)+',Date,Type,GlobalRef,ClassID,SaleID,PurchaseOrderID,PaymentID,PrepaymentID,AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,AccountID,AccountType,ClientName, ClientID,CustomerJobId, ');
          Add('ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,TaxCode,TaxRate,TaxID, ');
          Add('DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`');
          Add('FROM tbltransactionsummarydetails TRANS ');
          Add('Where TRANS.AccountID = '+ IntToStr(AppEnvVirt.Int['DNMLib.GetCustomerPrepaymentAccountID']) +' ');
          Add('AND PrepaymentID in ( ' + Ids + ');');
          if Devmode then begin
            add( ' insert into  tbltransactionsummariseddetails Select * , 3');
            Add('FROM tbltransactionsummarydetails TRANS ');
            Add('Where TRANS.AccountID = '+ IntToStr(AppEnvVirt.Int['DNMLib.GetCustomerPrepaymentAccountID']) +' ');
            Add('AND PrepaymentID in ( ' + Ids + ');');
          end;

        end;
      end;



    with BulkSQL do begin
    {Add All Other Types AR}
      Add(INSERT_INTO_String2);
      Add('SELECT '+SumSeqno(400)+',Date,Type,GlobalRef,ClassID,SaleID,PurchaseOrderID,PaymentID,PrepaymentID,AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,AccountID,AccountType,ClientName, ClientID, CustomerJobId,');
      Add('ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,TaxCode,TaxRate,TaxID, ');
          Add('DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`');
      Add('FROM tbltransactionsummarydetails TRANS ');
      Add('Where TRANS.AccountType = "AR" ');
      Add(' AND Not (TRANS.TYPE = "'+AppEnvVirt.Str['tcConst.CUSTOMER_PREPAYMENT']+'" OR TRANS.TYPE = "Invoice" OR TRANS.TYPE = "Refund" OR TRANS.TYPE = "Customer Payment"); ');
      if Devmode then begin
            add( ' insert into  tbltransactionsummariseddetails Select * , 4');
            Add('FROM tbltransactionsummarydetails TRANS ');
            add( ' Where TRANS.AccountType = "AR" ');
            add( ' AND Not (TRANS.TYPE = "'+AppEnvVirt.Str['tcConst.CUSTOMER_PREPAYMENT']+'" OR TRANS.TYPE = "Invoice" OR TRANS.TYPE = "Refund" OR TRANS.TYPE = "Customer Payment"); ');
      end;

    end;

   //#####  AP  Stuff ####################################################

   {Get Account In (AP) from Details Table}
    with qryAccountIDTemp do begin
      Sql.Clear;
      Sql.Add('SELECT TRANS.ClientID,PurchaseOrderID,Sum(Creditsex)- Sum(Debitsex) AS `AmountDueex` , Sum(CreditsInc)- Sum(DebitsInc)  AS `AmountDueinc`  ');
      Sql.Add('FROM tbltransactionsummarydetails TRANS  Where TRANS.AccountType = "AP" AND ');
      Sql.Add('(TRANS.TYPE = "PO" OR TRANS.TYPE = "Bill" OR TRANS.TYPE = "Credit" OR TRANS.TYPE = "Supplier Payment") ');
      Sql.Add('Group By ClientID,PurchaseOrderID Order by PurchaseOrderID; ');
      Open;
    end;

    Ids:= qryAccountIDTemp.groupconcat('PurchaseOrderID' ,  'AmountDueinc<> 0 or AmountDueex<> 0');
    if ids <> '' then begin

        with BulkSQL do begin
          Add(INSERT_INTO_String2);
          Add('SELECT '+SumSeqno(500)+',Date,Type,GlobalRef,ClassID,SaleID,PurchaseOrderID,PaymentID,PrepaymentID,AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,AccountID,AccountType,ClientName, ClientID, CustomerJobId,');
          Add('ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,TaxCode,TaxRate,TaxID, ');
          Add('DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`');
          Add('FROM tbltransactionsummarydetails TRANS ');
          Add('Where TRANS.AccountType = "AP" AND (TRANS.TYPE = "PO" OR TRANS.TYPE = "Bill" OR TRANS.TYPE = "Credit" OR TRANS.TYPE = "Supplier Payment") ');
          Add('AND PurchaseOrderID in (' + Ids+ ');');
          if Devmode then begin
            add( ' insert into  tbltransactionsummariseddetails Select * , 5');
            Add('FROM tbltransactionsummarydetails TRANS ');
            Add('Where TRANS.AccountType = "AP" AND (TRANS.TYPE = "PO" OR TRANS.TYPE = "Bill" OR TRANS.TYPE = "Credit" OR TRANS.TYPE = "Supplier Payment") ');
            Add('AND PurchaseOrderID in (' + Ids+ ');');
          end;

      end;
    end;

    {Get Account In (Supplier Prepayments) from Details Table}
    with qryAccountIDTemp do begin
      Sql.Clear;
      Sql.Add('SELECT TRANS.ClientID,PrepaymentID, Sum(Creditsex)- Sum(Debitsex) AS `AmountDueex` , Sum(CreditsInc)- Sum(DebitsInc)  AS `AmountDueinc`  ');
      Sql.Add('FROM tbltransactionsummarydetails TRANS Where TRANS.AccountID = '+ IntToStr(AppEnvVirt.Int['DNMLib.GetSupplierPrepaymentAccountID']) +' ');
      Sql.Add('Group By ClientID,PrepaymentID Order by PrepaymentID; ');
      Open;
    end;
    Ids:= qryAccountIDTemp.groupconcat('PrepaymentID' ,  'AmountDueinc<> 0 or AmountDueex<> 0');
    if ids <> '' then begin
        with BulkSQL do begin
          Add(INSERT_INTO_String2);
          Add('/*'+SumSeqno(600)+'*/ SELECT '+SumSeqno(600)+',Date,Type,GlobalRef,ClassID,SaleID,PurchaseOrderID,PaymentID,PrepaymentID,AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,AccountID,AccountType,ClientName, ClientID, CustomerJobId,');
          Add('ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,TaxCode,TaxRate,TaxID, ');
          Add('DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`');
          Add('FROM tbltransactionsummarydetails TRANS ');
          Add('Where TRANS.AccountID = '+ IntToStr(AppEnvVirt.Int['DNMLib.GetSupplierPrepaymentAccountID']) +' ');
          Add('AND PrepaymentID in (' + Ids+');');
          if Devmode then begin
            add( ' insert into  tbltransactionsummariseddetails Select * , 6');
            Add('FROM tbltransactionsummarydetails TRANS ');
            Add('Where TRANS.AccountID = '+ IntToStr(AppEnvVirt.Int['DNMLib.GetSupplierPrepaymentAccountID']) +' ');
            Add('AND PrepaymentID in (' + Ids+');');
          end;
        end;
      end;

    {Add All Other Types AP}
    with BulkSQL do begin
      Add(INSERT_INTO_String2);
      Add('/*'+SumSeqno(700)+'*/ SELECT '+SumSeqno(700)+',Date,Type,GlobalRef,ClassID,SaleID,PurchaseOrderID,PaymentID,PrepaymentID,AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,AccountID,AccountType,ClientName, ClientID, CustomerJobId,');
      Add('ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,TaxCode,TaxRate,TaxID, ');
      Add('DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`');
      Add('FROM tbltransactionsummarydetails TRANS ');
      Add('Where TRANS.AccountType = "AP" ');
      Add('AND Not (TRANS.TYPE = "Supplier Prepayment" OR TRANS.TYPE = "PO" OR TRANS.TYPE = "Bill" OR TRANS.TYPE = "Credit" OR TRANS.TYPE = "Supplier Payment");');
      if Devmode then begin
        add( ' insert into  tbltransactionsummariseddetails Select * , 7');
        Add('FROM tbltransactionsummarydetails TRANS ');
        Add('Where TRANS.AccountType = "AP" ');
        Add('AND Not (TRANS.TYPE = "Supplier Prepayment" OR TRANS.TYPE = "PO" OR TRANS.TYPE = "Bill" OR TRANS.TYPE = "Credit" OR TRANS.TYPE = "Supplier Payment");');
      end;
    end;

    if Assigned(ProgressDlg) then begin
      ProgressDlg.Caption := 'Please Wait .......';
      ProgressDlg.MinValue := 0;
      ProgressDlg.Step := 1;
    end;
    if not Assigned(qryMyScript) then begin
      qryMyScript := NewScript;//TERPScript.Create(nil);
      //qryMyScript.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    end;
    qryMyScript.BeforeExecute := MyScriptBeforeExecute;
    qryMyScript.AfterExecute := MyScriptAfterExecute;
    qryMyScript.SQL.Clear;
    qryMyScript.SQL.Text := BulkSQL.Text;
    BulkSQL.Clear;
    if Assigned(ProgressDlg) then begin
      ProgressDlg.MaxValue:= qryMyScript.Statements.Count;
      ProgressDlg.Execute;
    end;
      qryMyScript.IgnorenContinueOnError := True;
      qryMyScript.ProcessScriptExecteError := DoProcessScriptExecteError;
      qryMyScript.Execute;
  finally
    AppEnvVirt.Bool['CompanyPrefs.BatchUpdateInProgress'] := false;
    if Assigned(ProgressDlg) then begin
      ProgressDlg.CloseDialog;
    end;
    Screen.Cursor := Save_Cursor;
    Application.ProcessMessages
  end;
finally
   unLock('Update Batch / Report');
   Result := True;
end;
end;

procedure TTransactionTableObj.CleanUpLevelFields;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  try
    qryTemp.Sql.Add('UPDATE tblclass SET Level1 = ClassName , Level2 =NULL , Level3 =NULL , Level4 =NULL ');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TTransactionTableObj.SetClassLevelField;
var
  qryLevelsTemp: TERPQuery;
begin
  CleanUpLevelFields;
  qryLevelsTemp := TERPQuery.Create(nil);
  qryLevelsTemp.Options.FlatBuffers := True;
  qryLevelsTemp.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  qryLevelsTemp.ParamCheck := false;
  try
    qryLevelsTemp.Sql.Add('SELECT ClassID, ');
    qryLevelsTemp.Sql.Add(SplitField('', 'Concat_WS("^",ClassGroup,ClassName)' , 1) +' as Level1, ');
    qryLevelsTemp.Sql.Add(SplitField('', 'Concat_WS("^",ClassGroup,ClassName)' , 2) +' as Level2, ');
    qryLevelsTemp.Sql.Add(SplitField('', 'Concat_WS("^",ClassGroup,ClassName)' , 3) +' as Level3, ');
    qryLevelsTemp.Sql.Add(SplitField('', 'Concat_WS("^",ClassGroup,ClassName)' , 4) +' as Level4 ');
    qryLevelsTemp.Sql.Add('FROM tblclass Where char_length(ClassGroup) > 0 ; ');
    qryLevelsTemp.Active := true;
    if not qryLevelsTemp.IsEmpty then begin
      qryLevelsTemp.First;
      while not qryLevelsTemp.Eof do begin
        UpdateLevels(qryLevelsTemp.FieldByName('ClassID').AsInteger, qryLevelsTemp.FieldByName('Level1').AsString,
          qryLevelsTemp.FieldByName('Level2').AsString, qryLevelsTemp.FieldByName('Level3').AsString, qryLevelsTemp.FieldByName('Level4').AsString);
        qryLevelsTemp.Next;
      end;
    end;
  finally
    FreeAndNil(qryLevelsTemp);
  end;
end;

Procedure TTransactionTableObj.UnLock(Groupname: STring);
begin
    UserLock.UnLock('tblTransactions', 0, Groupname);
end;

procedure TTransactionTableObj.UpdateLevels(const ClassID: integer; const Level1, Level2, Level3, Level4: string);
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  try
    qryTemp.Sql.Add('UPDATE tblclass SET Level1 ="' + Level1 + '" , Level2 ="' + Level2 + '" , Level3 ="' + Level3 + '" , Level4 ="' + Level4 + '" ');
    qryTemp.Sql.Add('WHERE ClassID =' + IntToStr(ClassID) + ';');
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TTransactionTableObj.Delete_Unique_AR_TempTable;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('DROP TABLE IF EXISTS tmp_tblaccountsreceivable' + AppEnvVirt.Str['CommonDbLib.GetTemporaryTableNameSuffix'] + ';');
    try
      qryTemp.Execute;
    except
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;



function TTransactionTableObj.Lock(Groupname: STring): boolean;
var
  s:String;
begin
    result := UserLock.Lock('tblTransactions', 0, Groupname);
    if not result then begin
      s:= UserLock.LockMessage;
      s:= replacestr(s , 'update data.' , ' Run ' +Groupname+'.') ;
      s:= replacestr(s , 'accessing this record (Whole Table Locked) with: ' , 'running ');
      s:= replacestr(s , 'Record has been in use ' , 'Update Running ');

      if IsOwnerListing then
           s:= s+chr(13) +chr(13) +'Please Select The "Refresh" Button On The Report After ' +userLock.LockInfo.Username +' Has Finished.'
      else s:=s+chr(13) +chr(13) +'Please Run it Later After ' +userLock.LockInfo.Username +' Has Finished.';
      if IsGUI then
        Vista_MessageDlg.MessageDlgXP_Vista(s, mtWarning, [mbOK], 0)
      else
        Log(s,ltWarning);
    end;
end;

procedure TTransactionTableObj.Log(const msg: string; LogType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg, LogType);
  if Assigned(fOnLog) then fOnLog(msg, LogType);
(*  if devmode then
    logtext(msg);*)
end;

function TTransactionTableObj.GetCreate_tbltransactions_inprogress: String;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Sql.Add('SHOW CREATE TABLE tmp_tbltransactions;');
    qryTemp.Open;
    Result := qryTemp.Fields[1].AsString;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TTransactionTableObj.Delete_Unique_ALL_TempTable;
var
  qryTemp: TERPCommand;
  TempList: TStringList;
  i: integer;
begin
  qryTemp := TERPCommand.Create(nil);
  TempList := TStringList.Create;
  try
    qryTemp.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    qryTemp.Connection.GetTableNames(TempList);
    for i := 0 to TempList.Count - 1 do
      if (Pos(uppercase(Trim(AppEnvVirt.Str['CommonDbLib.GetTemporaryTableNameSuffix'])),uppercase(TempList.Strings[i])) <> 0) then begin
        qryTemp.Sql.Clear;
        qryTemp.Sql.Add('DROP TABLE IF EXISTS `' + TempList.Strings[i] + '`;');
        try
          qryTemp.Execute;
          Application.ProcessMessages;
        except
        end;
      end;
  finally
    FreeAndNil(TempList);
    FreeAndNil(qryTemp);
  end;
end;
Procedure TTransactionTableObj.DoProcessScriptExecteError(const Value:String);
begin
  if not devmode then
    UtilsLib.DoProcessScriptExecteError(Value);
//  {$IFDEF DevMode}   Logtext(Value, TransErrorlogfilename);   {$ENDIF}
end;

Function Firstcolumn(const COATableAlias :String = 'COA'):String;begin  REsult := SplitField('', AccountName(COATableAlias) , 1);end;
Function Secondcolumn(const COATableAlias:String = 'COA'):String;begin  REsult := SplitField('', AccountName(COATableAlias) , 2);end;
Function Thirdcolumn(const COATableAlias :String = 'COA'):String;begin  REsult := SplitField('', AccountName(COATableAlias) , 3);end;
Function forthcolumn(const COATableAlias :String = 'COA'):String;begin  REsult := SplitField('', AccountName(COATableAlias) , 4);end;

Function AccountName (const COATableAlias :String = 'COA'):String;
begin
  result := 'Concat_WS("^",IF(char_length(' + COATableAlias +'.AccountGroup)=0,Null,' + COATableAlias +'.AccountGroup) ,Trim(' + COATableAlias +'.AccountName))';
end;
Function CurDateIfGreater(dDate:TDateTime):TdateTime;
begin
  if dDate > Date then result := Date else Result := dDate;
end;

function TTransactionTableObj.TransSQLFields(seno: Integer): String;
begin
  if seno = 66 then
    REsult := 'SeqNo, Date,Type,GlobalRef,ClassID,SaleID,PurchaseOrderID,PaymentID,PrepaymentID,FixedAssetID,AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,AccountID,AccountType,ClientName, ClientID,CustomerJobId,' +
              'ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,TaxCode,TaxRate,TaxID,DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`,Active'
  else
      REsult := 'SeqNo, Date,Type,GlobalRef,ClassID,'+
                'SaleID,PurchaseOrderID,PaymentID,PrepaymentID,FixedAssetID,'+
                'SaleLineId, purchaselineID,PaymentLineId, prepaymentlineid, '+
                'AccountName,AccountGroupLevels,Level1,Level2,Level3,Level4,' +
                'AccountID,AccountType,ClientName, ClientID,CustomerJobId,' +
                'ProductDesc,ProductName,ProductGroup,RepName,EmployeeID,Reconciled,Notes,' +
                'TaxCode,TaxRate,TaxID,DebitsEx,CreditsEx,DebitsInc,CreditsInc,CASH_DebitsEx,' +
                'CASH_CreditsEx,CASH_DebitsInc,CASH_CreditsInc,`Chq/Ref`';

end;

end.



