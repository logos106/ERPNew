unit StoredProcedures;

interface

uses
  BusObjGeneral, Myaccess;

  Procedure CreateSP(SPNAme:String; Usercount :Integer = 0; const fConnection :TCustomMyConnection = nil);
  Function SPExists(SPName:STring):Boolean;
  function SpProcessstatusSQL:String;
  function SPVersionToNoSQL:String;
  function SPTermToDaysSQL: string;
  function SPNextVersionNoSQL:String;
  function SPNewLineSQL:String;
  function SPRemoveBlankLineSQL:String;
  function SPFormatSecondsSQL:String;
  function SPFormatSecondsTotimeSQL:String;
  function SPGetSequenceNumberSQL:String;
  function SPSetSequenceNumberSQL:String;
  function SPProcessPartStatusToUserStrSQL:String;
  Function SPProcessPartStatusToNoSQL :String;
  Function SPProcessPartStatusNoToStrSQL :String;
  Function SPAccLevelNoToDescriptionSQL :String;
  Function SPBOMTypetoStrSQL :String;
  Function SPInputTypetoStrSQL :String;
  Function SPProcessPartStatusNoToStrValSQL :String;
  Function SPHireStatusSQL :String;
  Function SPDurationdescSQL :String;
  Function SPDurationtypeToDescriptionSQL :String;
  Function SPAllRelatedSAleIDsSQL:String;
  Function SPSameValueSQL:String;
  Function SPMonthNoSQL:String;
  Function SPDateRangetypeToMonthSQL:String;
  Function SPPartHasAnyTransactionSQL:String;
  Function SPCStoQuotedCSSQL:String;
  function SPSaletypeSQL:String;
  function SPDescribeFormulaSQL:String;
  (*function SPDescSalesLineSoldformulaSQL:String;
  function SPDescSalesLinShippedformulaSQL:String;*)
  function SPWeekDaynameSQL:String;
  function SPWeekDayNoSQL:String;
  function SPNextDayNoSQL:String;
  Function SPTableExistsSQL:String;
  Function SPIncMonthSQL:String;
  function SPEncodeDateSQL:String;
  function SPSleepSecondsSQL:String;
  function SPFileExistsSQL:String;
  function SPLastFiscalYearEndSQL:String;
  function SPLastFiscalYearStartSQL:String;
  function SPFiscalYearStartSQL:String;
  function SPFiscalYearEndSQL:String;
  function SPDrop_Index_If_ExistsSQL :String;
  function SPIsIntegerSQL :String;
  function SPIsNumberSQL :String;
  function SPPQAAllocTypeSQL :String;
  function SPFxCodeSQL :String;
  function SPNextDueDateSQL :String;
  function SPApplyHolidayValidationSQL :String;
  function SPApplySunValidationSQL :String;
  function SPApplySatValidationSQL :String;
  function SPIsHolidaySQL :String;
  function SPQtyinUOMSQL :String;
  function SPPostingtypetoPQAtypeSQL :String;
  function SPFloatToStrCurrSQL :String;
  function SPCurrencydecimalPlacesSQL :String;
  function SPNextScheduleDueDateSQL :String;
  function SPAmountToWordsSQL: string;
  function SPERPTimeToTime: string;
  function SPSecondsBetween: string;
  Function SPEndOfTheDay:String;
  Function SPSimpleTypetoDesc:String;
  Function SPSimpleTypeDesctocode:String;
  Function SPCustomername:String;
  Function SPSplitShiptTo:String;
  function SPSaleTotalLineIncRelatedExSQL: string;
  function SPSaleTotalLineIncRelatedIncSQL: string;
  function SPSaleLinePriceIncRelatedExSQL: string;
  function SPSaleLinePriceIncRelatedIncSQL: string;
  function SPTreeNodeCaptionSQL: string;
  function SPAutoRoundRelatedQtySQL: string;
  function SPStrToRowsSQL: string;
  function SPOrderDiscountAmountSQL: string;
  function SPOrderDiscountPercentSQL: string;
  function SPSalesPrintdocIDSQL: string;
  function SPSalesPrintedbySQL: string;
  function SPField_TypeSQL: string;
  function SPPreftypeToSQLTypeSQL: string;
  function SPvosCodeToMsgSQL: string;
  function SPReplaceNewLineSQL: string;
  function SPProductQtySumUpdateSQL(fConnection:TCustomMyConnection ): string;
  Function SPStsPhaseCodetoDescSQL :String;
  Function SPSeedToSalePhaseSQL :String;

  //function SPIntParamSQL: string;
  //function VWProductUOMSQL: string;

(*  function SPPrefDateToDateSQL: string;
  function SPPrefDateTimeToDateTimeSQL: string;*)

  (*function SPUpdateSerialnumberOldListSQL: string;*)
  function SPUpdate_Serial_Number_ListSQL: string;
  Procedure CreateSPs(DOProgress :TStepProgressbar; const fConnection :TCustomMyConnection = nil);

implementation

uses
  CommonDbLib, sysutils, AppEnvironment, ProcessUtils, tcConst, Classes, PQALib,
  CommonLib, ProductQtyLib, DbSharedObjectsObj, ERPDbComponents;


Procedure CreateSPs(DOProgress :TStepProgressbar; const fConnection :TCustomMyConnection = nil);
var
  UserCount:Integer;
  ctr:Integer;
  fsProcname:String;
  Procedure CallDOProgress;
  begin
    if Assigned(DOProgress) then DOProgress('Checking for Database Components :'+ inttostr(ctr)+ ' of 85 ') ;
    ctr:= ctr+1;
  end;
begin
  ctr:= 1;
  UserCount :=   AppEnv.UtilsClient.GetLoggedOnUserCount(AppEnv.AppDb.Database, true);
(*01*)  fsProcname :='Processstatus'              ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*02*)  fsProcname :='VersionToNo'                ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*02*)  fsProcname :='NextVersionNo'              ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*02*)  fsProcname :='TermToDays'                 ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*03*)  fsProcname :='NewLine'                    ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*04*)  fsProcname :='RemoveBlankLine'            ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*05*)  fsProcname :='FormatSeconds'              ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*06*)  fsProcname :='FormatSecondsTotime'        ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*07*)  fsProcname :='GetSequenceNumber'          ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*08*)  fsProcname :='SetSequenceNumber'          ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*09*)  fsProcname :='ProcessPartStatusToUserStr' ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*10*)  fsProcname :='ProcessPartStatusToNo'      ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*11*)  fsProcname :='ProcessPartStatusNoToStr'   ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*11*)  fsProcname :='AccLevelNoToDescription'    ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*12*)  fsProcname :='BOMTypetoStr'               ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*13*)  fsProcname :='InputTypetoStr'             ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*14*)  fsProcname :='ProcessPartStatusNoToStrVal';CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*15*)  fsProcname :='HireStatus'                 ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*16*)  fsProcname :='Durationdesc'               ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*17*)  fsProcname :='DurationtypeToDescription'  ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*18*)  fsProcname :='AllRelatedSAleIDs'          ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*19*)  fsProcname :='SameValue'                  ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*20*)  fsProcname :='MonthNo'                    ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*21*)  fsProcname :='DateRangetypeToMonth'       ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*22*)  fsProcname :='PartHasAnyTransaction'      ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*23*)  fsProcname :='CStoQuotedCS'               ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*24*)  fsProcname :='Saletype'                   ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*25*)  fsProcname :='DescribeFormula'            ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*26    fsProcname :='DescSalesLineSoldformula'   ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*27  fsProcname :='DescSalesLinShippedformula'   ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;*)
(*28*)  fsProcname :='WeekDayname'                ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*29*)  fsProcname :='LastFiscalYearEnd'          ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*29*)  fsProcname :='LastFiscalYearStart'        ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*29*)  fsProcname :='FiscalYearStart'            ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*29*)  fsProcname :='FiscalYearEnd'              ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*30*)  fsProcname :='IsInteger'                  ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*31*)  fsProcname :='IsNumber'                   ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*32*)  fsProcname :='PQAAllocType'               ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*33*)  fsProcname :='FxCode'                     ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*34*)  fsProcname :='NextDueDate'                ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*35*)  fsProcname :='ApplyHolidayValidation'     ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*36*)  fsProcname :='ApplySunValidation'         ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*37*)  fsProcname :='ApplySatValidation'         ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*38*)  fsProcname :='IsHoliday'                  ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*39*)  fsProcname :='QtyinUOM'                   ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*40*)  fsProcname :='PostingtypetoPQAtype'       ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*41*)  fsProcname :='FloatToStrCurr'             ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*42*)  fsProcname :='CurrencydecimalPlaces'      ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*43*)  fsProcname :='NextScheduleDueDate'        ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*44*)  fsProcname :='Drop_Index_If_Exists'       ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*45*)  fsProcname :='IncMonth'                   ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*46*)  fsProcname :='TableExists'                ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*47*)  fsProcname :='EncodeDate'                 ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*48*)  fsProcname :='SleepSeconds'               ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*49*)  fsProcname :='FileExists'                 ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*50*)  fsProcname :='AmountToWords'              ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*51*)  fsProcname :='ERPTimeToTime'              ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*52*)  fsProcname :='SecondsBetween'             ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*53*)  fsProcname :='EndOfTheDay'                ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*54*)  fsProcname :='SimpleTypetoDesc'           ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*55*)  fsProcname :='SimpleTypeDesctocode'       ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*56*)  fsProcname :='Customername'               ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*57*)  fsProcname :='SplitShiptTo'               ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*58*)  fsProcname :='SaleTotalLineIncRelatedEx'  ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*59*)  fsProcname :='SaleTotalLineIncRelatedInc' ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*60*)  fsProcname :='SaleLinePriceIncRelatedEx'  ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*61*)  fsProcname :='SaleLinePriceIncRelatedInc' ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*62*)  fsProcname :='TreeNodeCaption'            ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*63*)  fsProcname :='AutoRoundRelatedQty'        ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*64*)  fsProcname :='StrToRows'                  ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*65*)  fsProcname :='OrderDiscountAmount'        ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*66*)  fsProcname :='OrderDiscountPercent'       ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*67*)  fsProcname :='SalesPrintdocID'            ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*67*)  fsProcname :='SalesPrintedby'             ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*68*)  fsProcname :='Field_Type'                 ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*69*)  fsProcname :='PreftypeToSQLType'          ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*70*)  fsProcname :='vosCodeToMsg'               ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
{(*71*)  fsProcname :='PrefDateToDate'            ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*72*)  fsProcname :='PrefDateTimeToDateTime'     ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;}
(*73  fsProcname :='UpdateSerialnumberOldList'    ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;*)
(*74*)  fsProcname :='Update_Serial_Number_List'  ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*75*)  fsProcname :='ReplaceNewLine'             ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
//(*76*)  fsProcname :='IntParam'                 ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
//(*77*)  fsProcname :='ProductUOM'               ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*78*)  fsProcname :='WeekDayNo'                  ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*79*)  fsProcname :='NextDayNo'                  ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*80*)  fsProcname :='ProductQtySumUpdate'        ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*81*)  fsProcname :='StsPhaseCodetoDesc'         ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;
(*82*)  fsProcname :='SeedToSalePhase'            ;CreateSP(fsProcname, UserCount, fConnection);CallDOProgress;

end;

Function SPExists(SPName:STring):Boolean;
var
  strSQL:String;
begin
  strSql:= 'SELECT ROUTINE_TYPE, ROUTINE_NAME ' +
            ' FROM INFORMATION_SCHEMA.ROUTINES ' +
            ' WHERE ROUTINE_SCHEMA=' + Quotedstr(GetActiveDatabaseName)+
            ' and ROUTINE_NAME = '+QuotedStr(SPName);
  With TempMyQuery do try
    SQL.add(strSQL);
    open;
    Result := recordcount=1;
  finally
    if active then close;
    Free;
  end;
end;

Procedure CreateSP(SPNAme:String; Usercount :Integer = 0; const fConnection :TCustomMyConnection = nil);
var
  strSQL:String;
begin
  if Usercount >1 then
    if SPExists(SPName) then exit;
       if SameText(Spname , 'ProcessStatus')              then  strSQL:= SpProcessstatusSQL
  else if SameText(Spname , 'VersionToNo')                then  strSQL:= SpVersionToNoSQL
  else if SameText(Spname , 'TermToDays')                 then  strSQL:= SpTermToDaysSQL
  else if SameText(Spname , 'NextVersionNo')              then  strSQL:= SpNextVersionNoSQL
  else if SameText(Spname , 'NewLine')                    then  strSQL:= SpNewLineSQL
  else if sameText(Spname , 'RemoveBlankLine')            then  strSQL:= SpRemoveBlanklineSQL
  else if SameText(SPNAme , 'FormatSeconds')              then  strSQL:= SpFormatSecondsSQL
  else if SameText(SPNAme , 'FormatSecondsTotime')        then  strSQL:= SpFormatSecondsTotimeSQL
  else if Sametext(SPNAme , 'GetSequenceNumber')          then  strSQL:= SpGetSequenceNumberSQL
  else if Sametext(SPNAme , 'SetSequenceNumber')          then  strSQL:= SpSetSequenceNumberSQL
  else if Sametext(SPNAme , 'ProcessPartStatusToUserStr') then  strSQL:= SPProcessPartStatusToUserStrSQL
  else if Sametext(SPName , 'ProcessPartStatusToNo')      then  strSQL:= SPProcessPartStatusToNoSQL
  else if Sametext(SPName , 'ProcessPartStatusNoToStr')   then  strSQL:= SPProcessPartStatusNoToStrSQL
  else if Sametext(SPName , 'AccLevelNoToDescription')    then  strSQL:= SPAccLevelNoToDescriptionSQL
  else if Sametext(SPName , 'BOMTypetoStr')               then  strSQL:= SPBOMTypetoStrSQL
  else if Sametext(SPName , 'InputTypetoStr')             then  strSQL:= SPInputTypetoStrSQL
  else if Sametext(SPName , 'ProcessPartStatusNoToStrVal')then  strSQL:= SPProcessPartStatusNoToStrValSQL
  else if Sametext(SPName , 'HireStatus')                 then  strSQL:= SPHireStatusSQL
  else if Sametext(SPName , 'Durationdesc')               then  strSQL:= SPDurationdescSQL
  else if Sametext(SPName , 'DurationtypeToDescription')  then  strSQL:= SPDurationtypeToDescriptionSQL
  else if sametext(SPName , 'AllrelatedSaleIds')          then  strsql:= SPAllrelatedSaleIdsSQL
  else if Sametext(SPName , 'SameValue')                  then  strSQL:= SPSameValueSQL
  else if Sametext(SPName , 'MonthNo')                    then  strSQL:= SPMonthNoSQL
  else if SameText(SPNAme , 'DateRangetypeToMonth')       then  strSQL:= SPDateRangetypeToMonthSQL
  else if SameText(SPNAme , 'PartHasAnyTransaction')      then  strSQL:= SPPartHasAnyTransactionSQL
  else if Sametext(SPName , 'CStoQuotedCS')               then  strSQL:= SPCStoQuotedCSSQL
  else if Sametext(SPNAme , 'TableExists')                then  strSQL:= SPTableExistsSQL
  else if SameText(SPNAme , 'Saletype')                   then  strSQL:= SPSaletypeSQL
  else if SameText(SPNAme , 'DescribeFormula')            then  strSQL:= SPDescribeFormulaSQL
  (*else if SameText(SPNAme , 'DescSalesLineSoldformula'  ) then  strSQL:= SPDescSalesLineSoldformulaSQL
  else if SameText(SPNAme , 'DescSalesLinShippedformula') then  strSQL:= SPDescSalesLinShippedformulaSQL*)
  else if SameText(SPNAme , 'WeekDayname')                then  strSQL:= SPWeekDaynameSQL
  else if SameText(SPNAme , 'WeekDayNo')                  then  strSQL:= SPWeekDayNoSQL
  else if SameText(SPNAme , 'NextDayNo')                  then  strSQL:= SPNextDayNoSQL
  else if Sametext(SPName , 'LastFiscalYearEnd')          then  strSQL:= SPLastFiscalYearEndSQL
  else if Sametext(SPName , 'LastFiscalYearStart')        then  strSQL:= SPLastFiscalYearStartSQL
  else if Sametext(SPName , 'FiscalYearStart')            then  strSQL:= SPFiscalYearStartSQL
  else if Sametext(SPName , 'FiscalYearEnd')              then  strSQL:= SPFiscalYearEndSQL
  else if Sametext(SPName , 'EncodeDate')                 then  strSQL:= SPEncodeDateSQL
  else if Sametext(SPName , 'SleepSeconds')               then  strSQL:= SPSleepSecondsSQL
  else if Sametext(SPName , 'FileExists')                 then  strSQL:= SPFileExistsSQL
  else if Sametext(SPName , 'IncMonth')                   then  strSQL:= SPIncMonthSQL
  else if Sametext(SPName , 'Drop_Index_If_Exists')       then  strSQL:= SPDrop_Index_If_ExistsSQL
  else if Sametext(SPName , 'IsInteger')                  then  strSQL:= SPIsIntegerSQL
  else if Sametext(SPName , 'IsNumber')                   then  strSQL:= SPIsNumberSQL
  else if Sametext(SPName , 'PQAAllocType')               then  strSQL:= SPPQAAllocTypeSQL
  else if Sametext(SPName , 'FxCode')                     then  strSQL:= SPFxCodeSQL
  else if Sametext(SPName , 'NextDueDate')                then  strSQL:= SPNextDueDateSQL
  else if Sametext(SPName , 'ApplyHolidayValidation')     then  strSQL:= SPApplyHolidayValidationSQL
  else if Sametext(SPName , 'ApplySunValidation')         then  strSQL:= SPApplySunValidationSQL
  else if Sametext(SPName , 'ApplySatValidation')         then  strSQL:= SPApplySatValidationSQL
  else if Sametext(SPName , 'IsHoliday')                  then  strSQL:= SPIsHolidaySQL
  else if Sametext(SPName , 'QtyinUOM')                   then  strSQL:= SPQtyinUOMSQL
  else if Sametext(SPName , 'PostingtypetoPQAtype')       then  strSQL:= SPPostingtypetoPQAtypeSQL
  else if Sametext(SPName , 'FloatToStrCurr')             then  strSQL:= SPFloatToStrCurrSQL
  else if Sametext(SPName , 'CurrencydecimalPlaces')      then  strSQL:= SPCurrencydecimalPlacesSQL
  else if Sametext(SPName , 'NextScheduleDueDate')        then  strSQL:= SPNextScheduleDueDateSQL
  else if Sametext(SPName , 'AmountToWords')              then  strSQL:= SPAmountToWordsSQL
  else if Sametext(SPName , 'ERPTimeToTime')              then  strSQL:= SPERPTimeToTime
  else if Sametext(SPName , 'SecondsBetween')             then  strSQL:= SPSecondsBetween
  else if Sametext(SPName , 'EndOfTheDay')                then  strSQL:= SPEndOfTheDay
  else if Sametext(SPName , 'SimpleTypetoDesc')           then  strSQL:= SPSimpleTypetoDesc
  else if Sametext(SPName , 'SimpleTypeDesctocode')       then  strSQL:= SPSimpleTypeDesctocode
  else if Sametext(SPName , 'Customername')               then  strSQL:= SPCustomername
  else if Sametext(SPName , 'SplitShiptTo')               then  strSQL:= SPSplitShiptTo
  else if SameText(SPName , 'SaleTotalLineIncRelatedEx')  then  strSQL:= SPSaleTotalLineIncRelatedExSQL
  else if SameText(SPName , 'SaleTotalLineIncRelatedInc') then  strSQL:= SPSaleTotalLineIncRelatedIncSQL
  else if SameText(SPName , 'SaleLinePriceIncRelatedEx')  then strSQL:= SPSaleLinePriceIncRelatedExSQL
  else if SameText(SPName , 'SaleLinePriceIncRelatedInc') then strSQL:= SPSaleLinePriceIncRelatedIncSQL
  else if SameText(SPName , 'TreeNodeCaption')            then strSQL:= SPTreeNodeCaptionSQL
  else if SameText(SPName , 'AutoRoundRelatedQty')        then strSQL:= SPAutoRoundRelatedQtySQL
  else if SameText(SPName , 'StrToRows')                  then strSQL:= SPStrToRowsSQL
  else if SameText(SPName , 'OrderDiscountAmount')        then strSQL:= SPOrderDiscountAmountSQL
  else if SameText(SPName , 'OrderDiscountPercent')       then strSQL:= SPOrderDiscountPercentSQL
  else if SameText(SPName , 'SalesPrintdocID')            then strSQL:= SPSalesPrintdocIDSQL
  else if SameText(SPName , 'SalesPrintedby')             then strSQL:= SPSalesPrintedbySQL
  else if SameText(SPName , 'Field_Type')                 then strSQL:= SPField_TypeSQL
  else if SameText(SPName , 'PreftypeToSQLType')          then strSQL:= SPPreftypeToSQLTypeSQL
  else if SameText(SPName , 'vosCodeToMsg')               then strSQL:= SPvosCodeToMsgSQL
(*  else if SameText(SPName , 'PrefDateToDate')             then strSQL:= SPPrefDateToDateSQL
  else if SameText(SPName , 'PrefDateTimeToDateTime')     then strSQL:= SPPrefDateTimeToDateTimeSQL*)
  (*else if SameText(SPName , 'UpdateSerialnumberOldList')  then strSQL:= SPUpdateSerialnumberOldListSQL*)
  else if SameText(SPName , 'Update_Serial_Number_List')  then strSQL:= SPUpdate_Serial_Number_ListSQL
  else if SameText(SPName , 'ReplaceNewLine')             then strSQL:= SPReplaceNewLineSQL
  else if SameText(SPName , 'ProductQtySumUpdate')        then strSQL:= SPProductQtySumUpdateSQL(fConnection)
  else if Sametext(SPName , 'StsPhaseCodetoDesc')         then strSQL:= SPStsPhaseCodetoDescSQL
  else if Sametext(SPName , 'SeedToSalePhase')            then strSQL:= SPSeedToSalePhaseSQL

  (*else if SameText(SPName , 'IntParam')                   then strSQL:= SPIntParamSQL
  else if SameText(SPName , 'ProductUOM')                 then strSQL:= VWProductUOMSQL*);


  if strsql<> '' then begin
    try
      executeSQL(strSQL, fConnection);
    Except
      on E:Exception do begin
        // ignore the error
      end;
    end;
  end;
end;
Function SPDrop_Index_If_ExistsSQL:string;
begin
  Result := ' DROP PROCEDURE IF EXISTS drop_index_if_exists ;' + NL+
              'DELIMITER //' + NL+
              ' CREATE PROCEDURE drop_index_if_exists(in theTable VARCHAR(128), in theIndexName VARCHAR(128) )' + NL+
              ' BEGIN' + NL+
              '  IF((SELECT COUNT(*) AS index_exists ' + NL+
                            ' FROM information_schema.statistics  ' + NL+
                            ' WHERE TABLE_SCHEMA = DATABASE()  ' + NL+
                            ' and table_name = theTable  ' + NL+
                            ' AND index_name = theIndexName) > 0) THEN' + NL+
              '    SET @s = CONCAT("DROP INDEX " , theIndexName , " ON " , theTable);' + NL+
              '    PREPARE stmt FROM @s;' + NL+
              '    EXECUTE stmt;' + NL+
              '  END IF;' + NL+
              ' END //' + NL+
              ' DELIMITER ; ';
end;
Function SPIsIntegerSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS IsInteger ;' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION IsInteger(Data TEXT)' + NL+
              ' 	RETURNS ENUM("T","F")' + NL+
              ' 	LANGUAGE SQL' + NL+
              ' 	NOT DETERMINISTIC' + NL+
              ' 	CONTAINS SQL' + NL+
              ' 	SQL SECURITY DEFINER' + NL+
              ' 	COMMENT ""' + NL+
              ' BEGIN' + NL+
              ' Set Data = replace(data,"0","");' + NL+
              ' Set Data = replace(data,"1","");' + NL+
              ' Set Data = replace(data,"2","");' + NL+
              ' Set Data = replace(data,"3","");' + NL+
              ' Set Data = replace(data,"4","");' + NL+
              ' Set Data = replace(data,"5","");' + NL+
              ' Set Data = replace(data,"6","");' + NL+
              ' Set Data = replace(data,"7","");' + NL+
              ' Set Data = replace(data,"8","");' + NL+
              ' Set Data = replace(data,"9","");' + NL+
              ' if data=""  then  	RETURN "T";  else 	RETURN "F"; end if;' + NL+
              ' END; //' + NL+
              ' DELIMITER ; ';
end;
Function SPIsNumberSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS IsNumber ;' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION IsNumber(Data TEXT)' + NL+
              ' 	RETURNS ENUM("T","F")' + NL+
              ' 	LANGUAGE SQL' + NL+
              ' 	NOT DETERMINISTIC' + NL+
              ' 	CONTAINS SQL' + NL+
              ' 	SQL SECURITY DEFINER' + NL+
              ' 	COMMENT ""' + NL+
              ' BEGIN' + NL+
              ' Set Data = replace(data,"0","");' + NL+
              ' Set Data = replace(data,"1","");' + NL+
              ' Set Data = replace(data,"2","");' + NL+
              ' Set Data = replace(data,"3","");' + NL+
              ' Set Data = replace(data,"4","");' + NL+
              ' Set Data = replace(data,"5","");' + NL+
              ' Set Data = replace(data,"6","");' + NL+
              ' Set Data = replace(data,"7","");' + NL+
              ' Set Data = replace(data,"8","");' + NL+
              ' Set Data = replace(data,"9","");' + NL+
              ' if data="" or data ="." then  	RETURN "T"; else  	RETURN "F"; end if;' + NL+
              ' END; //' + NL+
              ' DELIMITER ; ';
end;
Function SPPQAAllocTypeSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS PQAAllocType ;' + NL+
              ' DELIMITER // ' + NL+
              ' CREATE FUNCTION `PQAAllocType`(`AllocType` VARCHAR(50), `Transtype` VARCHAR(50), `Qty` dOUBLE, `StockmovementID` INT, `StockmovementEntryType` VARCHAR(50), `FASerial` VARCHAR(50),IsinternalSale Varchar(1), saleconverted varchar(1)) ' + NL+
              ' 	RETURNS VARCHAR(50) ' + NL+
              ' BEGIN ' + NL+
              '     IF (allocType="OUT" and Qty >0) or (allocType="IN" and Qty <0)  THEN ' + NL+
              '       IF Transtype="TSalesOrderLine"  THEN ' + NL+
              '           RETURN "On SO" ; ' + NL+
              '       ELSEIF (transtype = "TProcTreePart" and allocType="OUT" ) THEN ' + NL+
              '           RETURN "Using to Build" ; ' + NL+
              '       ELSEIF ( transtype =  "TProcTreePart" and allocType="IN" and (saleconverted="T" and IsinternalSale="T") ) THEN ' + NL+
              '           RETURN "In-Stock" ; ' + NL+
              '       ELSEIF ( transtype =  "TProcTreePart" and allocType="IN" ) THEN ' + NL+
              '           RETURN "Building" ; ' + NL+
              '       ELSEIF transtype = "TStockMovementLines" and StockmovementEntryType="StockTransferEntry"   THEN ' + NL+
              '           RETURN "Transferred (Not Available)" ; ' + NL+
              '       ELSEIF transtype = "TStockMovementLines" and StockmovementEntryType="StockAdjustEntry"   THEN ' + NL+
              '           RETURN "Adjusted (Not Available)" ; ' + NL+
              '       ELSEIf (transtype ="TProcProgressOUT" ) THEN '+NL+
              '         RETURN "Used to Build" ;'+NL+
              '       ELSE ' + NL+
              '           RETURN  "Sold" ; ' + NL+
              '       END IF; ' + NL+
              '     ELSEIF transtype = "TStockMovementLines" and Qty<0   and allocType="IN"  THEN ' + NL+
              '         IF StockmovementID <>0 and StockmovementEntryType="StockTransferEntry"  THEN ' + NL+
              '           RETURN "Transferred (Not Available)" ; ' + NL+
              '         else ' + NL+
              '           RETURN "Adjusted (Not Available)" ; ' + NL+
              '         END IF; ' + NL+
              '     ELSEIF transtype = "TStockMovementLines" and Qty>0    and allocType="IN" THEN ' + NL+
              '         IF StockmovementID <>0 and StockmovementEntryType="StockTransferEntry" THEN ' + NL+
              '           RETURN "In-Stock" ; ' + NL+
              '         else ' + NL+
              '           RETURN "In-Stock" ; ' + NL+
              '         END IF; ' + NL+
              '     ELSEIF ( transtype =  "TProcTreePart" and allocType="IN" and (saleconverted="T" and IsinternalSale="T") ) THEN ' + NL+
              '           RETURN "In-Stock" ; ' + NL+
              '     ELSEIF ( transtype =  "TProcTreePart" and allocType="IN" ) THEN ' + NL+
              '           RETURN "Building" ; ' + NL+
              '     ELSEIf (transtype ="TProcProgressIn" and Qty>0) THEN '+NL+
              //'         RETURN "Built";'+NL+
              '           RETURN "In-Stock" ; ' + NL+
              '     ELSEIF FASerial <> "" THEN ' + NL+
              '       RETURN "Fixed Asset"  ; ' + NL+
              '     else ' + NL+
              '       RETURN "In-Stock" ; ' + NL+
              '     END IF; ' + NL+
              ' END; // ' + NL+
              ' DELIMITER ; ';
end;
Function SPFxCodeSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS FxCode ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `FXCode`(`Code` Text, `Rate` Double, `Defaultcode` Text) ' + NL+
              ' 	RETURNS TEXT ' + NL+
(*              ' 	LANGUAGE SQL ' + NL+
              ' 	NOT DETERMINISTIC ' + NL+
              ' 	CONTAINS SQL ' + NL+
              ' 	SQL SECURITY DEFINER ' + NL+
              ' 	COMMENT "" ' + NL+*)
              ' BEGIN ' + NL+
              ' 	DECLARE result VARCHAR(100); ' + NL+
              ' 	if Code="" then  	Set result = defaultcode; else  	Set result = code; end if; ' + NL+
              ' 	if Rate=0 then set result = concat(result , "(" , format(1,2) , ")"); else set result = concat(Result , "(" , format(Rate,2) , ")"); end if; ' + NL+
              ' 	RETURN Result; ' + NL+
              ' END //' + NL+
              ' DELIMITER ; ';
end;
Function SPNextDueDateSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS NextDueDate ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION NextDueDate(Frequency CHAR(1), ' + NL+
                                        ' 	Every INT, ' + NL+
                                        ' 	WeekDayNo INT, ' + NL+
                                        ' 	BeginFromOption CHAR(1), ' + NL+
                                        ' 	MonthDays INT, ' + NL+
                                        ' 	ContinueIndefinitely CHAR(1), ' + NL+
                                        ' 	Lastdate DATETIME, ' + NL+
                                        ' 	EndDate DateTime, ' + NL+
                                        ' 	SatAction char(1), ' + NL+
                                        ' 	sunAction char(1), ' + NL+
                                        ' 	holidayAction char(1))' + NL+
              ' 	RETURNS DATETIME ' + NL+
              ' BEGIN ' + NL+
              ' 	Declare ReturnDate Datetime; ' + NL+
              ' 	Declare fdDt datetime; ' + NL+
              ' 	Set ReturnDate = Lastdate; ' + NL+
              ' 	repeat ' + NL+
              ' 	if Frequency = "D" then ' + NL+
              ' 		Set ReturnDate = DATE_ADD(ReturnDate,INTERVAL Every DAY); ' + NL+
              ' 	elseif Frequency = "W" then ' + NL+
              ' 		Set ReturnDate := DATE_ADD(ReturnDate,INTERVAL Every * 7 DAY); ' + NL+
              ' 	elseif Frequency = "M" then ' + NL+
              ' 		if BeginFromOption = "S" then ' + NL+
              ' 			Set ReturnDate = DATE_ADD(DATE_SUB(LAST_DAY(DATE_ADD(ReturnDate, INTERVAL every MONTH)), INTERVAL DAY(LAST_DAY(DATE_ADD(ReturnDate, INTERVAL every MONTH)))-1 DAY),INTERVAL MonthDays DAY); ' + NL+
              ' 		else ' + NL+
              ' 			Set ReturnDate = DATE_ADD(LAST_DAY(DATE_ADD(ReturnDate, INTERVAL 1 MONTH)) ,INTERVAL 0-MonthDays DAY); ' + NL+
              ' 		end if; ' + NL+
              ' 	else ' + NL+
              ' 		Set ReturnDate = 0; ' + NL+
              ' 	end if; ' + NL+
              ' 	until ReturnDate > CurDate()  END REPEAT; ' + NL+
              ' 	if ContinueIndefinitely ="F" then ' + NL+
              ' 		if ReturnDate > EndDate then ' + NL+
              ' 			Set ReturnDate = 0; ' + NL+
              ' 		end if; ' + NL+
              ' 	end if; ' + NL+
              ' 	Repeat' + NL+
              ' 			Set fdDt = ReturnDate;' + NL+
              ' 			Set ReturnDate = ApplySatValidation(ReturnDate , SatAction);' + NL+
              ' 			Set ReturnDate = ApplySunValidation(ReturnDate , SunAction);' + NL+
              ' 			Set ReturnDate = ApplyHolidayValidation(ReturnDate , HolidayAction);' + NL+
              ' 			if ReturnDate <CurDate() then  Set ReturnDate =0;' + NL+
              ' 			elseif ReturnDate > endDate and ContinueIndefinitely="F" then  Set ReturnDate =0;' + NL+
              ' 			end if;' + NL+
              ' 		until ReturnDate =0 or  fdDt = ReturnDate  END REPEAT;' + NL+
              ' 	Return ReturnDate ; ' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;
Function SPApplyHolidayValidationSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS ApplyHolidayValidation ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `ApplyHolidayValidation`(`Dt` DATETIME, `HolidayAction` char(1))' + NL+
              ' 	RETURNS DATETIME ' + NL+
              ' BEGIN ' + NL+
              ' 	Declare ReturnDate datetime; ' + NL+
              ' 	Set ReturnDate  = Dt; ' + NL+
              ' 	if Isholiday(ReturnDate) = "T" then ' + NL+
              ' 		if HolidayAction="D" then ' + NL+
              ' 			Set REturnDate =0; ' + NL+
              ' 		elseif HolidayAction ="A" then ' + NL+
              ' 			Set REturnDate = DATE_ADD(REturnDate,INTERVAL 1 DAY); ' + NL+
              ' 		elseif HolidayAction ="B" then ' + NL+
              ' 			Set REturnDate = DATE_ADD(REturnDate,INTERVAL -1 DAY); ' + NL+
              ' 		end if; ' + NL+
              ' 	end if; ' + NL+
              ' 	Return REturnDate; ' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;
Function SPApplySunValidationSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS ApplySunValidation ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `ApplySunValidation`(`Dt` DATETIME, `sunAction` char(1))' + NL+
              ' 	RETURNS DATETIME ' + NL+
              ' BEGIN ' + NL+
              ' 	Declare ReturnDate Datetime; ' + NL+
              ' 	Set ReturnDate  = Dt; ' + NL+
              ' 	if Weekday(ReturnDate) = 6 then ' + NL+
              ' 		if sunAction="D" then ' + NL+
              ' 			Set REturnDate =0; ' + NL+
              ' 		elseif sunAction ="A" then ' + NL+
              ' 			Set REturnDate = DATE_ADD(REturnDate,INTERVAL 1 DAY); ' + NL+
              ' 		elseif sunAction ="B" then ' + NL+
              ' 			Set REturnDate = DATE_ADD(REturnDate,INTERVAL -1 DAY); ' + NL+
              ' 		end if; ' + NL+
              ' 	end if; ' + NL+
              ' 	Return ReturnDate; ' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;
Function SPApplySatValidationSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS ApplySatValidation ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `ApplySatValidation`(`Dt` Datetime, `SatAction` char(1))' + NL+
              ' 	RETURNS DATETIME ' + NL+
              ' BEGIN ' + NL+
              ' 	Declare ReturnDate datetime; ' + NL+
              ' 	Set ReturnDate  = Dt; ' + NL+
              ' 	if Weekday(ReturnDate) = 5 then ' + NL+
              ' 		if satAction="D" then ' + NL+
              ' 			Set REturnDate =0; ' + NL+
              ' 		elseif satAction ="A" then ' + NL+
              ' 			Set REturnDate = DATE_ADD(REturnDate,INTERVAL 1 DAY); ' + NL+
              ' 		elseif satAction ="B" then ' + NL+
              ' 			Set REturnDate = DATE_ADD(REturnDate,INTERVAL -1 DAY); ' + NL+
              ' 		end if; ' + NL+
              ' 	end if; ' + NL+
              ' 	Return REturnDate; ' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;
Function SPIsHolidaySQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS IsHoliday ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `IsHoliday`(`Dt` DATETIME)' + NL+
              ' 	RETURNS enum("T","F") ' + NL+
              ' BEGIN  ' + NL+
              '  	Declare holidayctr int; ' + NL+
              '  	Declare  curdt cursor for SELECT Count(ID) as Ctr FROM tblpublicholidays  WHERE Day = DATE(Dt); ' + NL+
              '  	open curdt ; ' + NL+
              '  	Fetch curdt  into holidayctr ; ' + NL+
              '  	if holidayctr  =0 then ' + NL+
              '  		return "F"; ' + NL+
              '  	else ' + NL+
              '  		return "T"; ' + NL+
              '  	end if; ' + NL+
              '  	CLOSE curdt;' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;

Function SPQtyinUOMSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS QtyinUOM ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION QtyinUOM(Qty FLOAT,ProductId INT,QtyUOM VARCHAR(255),ConvertToUOM VARCHAR(255)) RETURNS FloaT ' + NL+
              'BEGIN ' + NL+
              '	DECLARE iPARTiD1 INT; ' + NL+
              '	DECLARE iMultiplier1 INT; ' + NL+
              '	DECLARE iPARTiD2 INT; ' + NL+
              '	DECLARE iMultiplier2 INT; ' + NL+
              '	Declare  CurMult1 cursor for  	' +
                          '           SELECT PARTiD , Multiplier FROM tblunitsofmeasure where IFNULL(PartID,0) = ProductId and  UnitName = qTYuom 	' +
                          ' UNION ALL SELECT PARTiD , Multiplier FROM tblunitsofmeasure where IFNULL(PartID,0) = 0         and  UnitName = qTYuom  	' +
                          ' UNION ALL select -1 as PartId, 1 as  Multiplier oRDER BY PartID DESC ; ' + NL+
              '	Declare  CurMult2 cursor for  		' +
                          '           SELECT PARTiD , Multiplier FROM tblunitsofmeasure where IFNULL(PartID,0) = ProductId and  UnitName = ConvertToUOM 	' +
                          ' UNION ALL SELECT PARTiD , Multiplier FROM tblunitsofmeasure where IFNULL(PartID,0) = 0         and  UnitName = ConvertToUOM  	' +
                          ' UNION ALL select -1 as PartId, 1 as  Multiplier oRDER BY PartID DESC ; ' + NL+
              '	OPEN  CurMult1 ; ' + NL+
              '	OPEN  CurMult2 ; ' + NL+
              '	Fetch CurMult1  into iPARTiD1 , iMultiplier1 ; ' + NL+
              '	Fetch CurMult2  into iPARTiD2 , iMultiplier2 ; ' + NL+
              '	if iMultiplier1 =0 then Set iMultiplier1 =1; end if; ' + NL+
              '	if iMultiplier2 =0 then Set iMultiplier2 =1; end if; ' + NL+
              '	Return Qty / iMultiplier1*iMultiplier2; ' + NL+
              'END//' + NL+
              ' DELIMITER ; ';
end;

Function SPPostingtypetoPQAtypeSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS PostingtypetoPQAtype ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `PostingtypetoPQAtype`(`Postingtype` VARCHAR(50)) 	RETURNS VARCHAR(100)' + NL+
              ' BEGIN' + NL+
              ' Declare sPQATransType VARCHAR(255);' + NL+
              ' Declare  CurPostingtype cursor for Select PQATransType from tblTrnsPostingTypes where  description = PostingType;' + NL+
              ' open CurPostingtype ;' + NL+
              ' Fetch CurPostingtype  into sPQATransType ;' + NL+
              ' return sPQATransType ;' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;

Function SPFloatToStrCurrSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS FloatToStrCurr ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `FloatToStrCurr`(`Value` Float)' + NL+
              ' 		RETURNS VARCHAR(10)' + NL+
              ' BEGIN  ' + NL+
              '  	Declare sCurrencySymbol VARCHAR(10);  ' + NL+
              '  	declare idecimalPlaces Int;  ' + NL+
              '  	Declare  curCurrencySymbol cursor for select CurrencySymbol , decimalPlaces from tblregionaloptions where region in (select fieldValue from tbldbpreferences where name = "CompanyRegion");  ' + NL+
              '  	open CurCurrencySymbol;  ' + NL+
              '  	Fetch curCurrencySymbol   into sCurrencySymbol ,idecimalPlaces;  ' + NL+
              '  	return concat(sCurrencySymbol , " " , round(Value,idecimalPlaces));  ' + NL+
              '  	CLOSE curCurrencySymbol;' + NL+
              '  	END//' + NL+
              ' DELIMITER ; ';
end;
Function SPCurrencydecimalPlacesSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS CurrencydecimalPlaces ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION CurrencydecimalPlaces()' + NL+
              '      RETURNS Int    ' + NL+
              ' BEGIN  ' + NL+
              '  	declare idecimalPlaces Int;' + NL+
              '  	Declare  curdecimalPlaces cursor for select decimalPlaces from tblregionaloptions where region in (select fieldValue from tbldbpreferences where name = "CompanyRegion");' + NL+
              '  	open CurdecimalPlaces;' + NL+
              '  	Fetch curdecimalPlaces   into idecimalPlaces;' + NL+
              '  	return idecimalPlaces;' + NL+
              '  	CLOSE CurdecimalPlaces;' + NL+
              '  	END//' + NL+
              ' DELIMITER ; ';
end;

Function SPNextScheduleDueDateSQL:string;
begin
  Result := ' DROP FUNCTION IF EXISTS NextScheduleDueDate ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `NextScheduleDueDate`(`ScheduleID` INT)' + NL+
              ' 	RETURNS DATETIME ' + NL+
              'BEGIN' + NL+
              ' 	Declare ReturnDate Datetime;' + NL+
              ' 	DECLARE mainc Cursor for   	  ' + NL+
                              ' Select NextDueDate(ifnull(Frequency,"D") , 	  ' + NL+
                              ' ifnull(`Every`,1) , 	  ' + NL+
                              ' ifnull(WeekDay,0) , 	  ' + NL+
                              ' ifnull(BeginFromOption,"S") , 	  ' + NL+
                              ' ifnull(MonthDays,1) , 	  ' + NL+
                              ' ifnull(ContinueIndefinitely,"T") , 	  ' + NL+
                              ' ifnull(NextDueDate,"1899/01/01") , 	  ' + NL+
                              ' ifnull(EndDate,curDate()), ' + NL+
                              ' ifnull(SatAction,"P") , ' + NL+
                              ' ifnull(SunAction,"P") , ' + NL+
                              ' ifnull(HolidayAction,"P")  ) as NextDate   	  ' + NL+
                              ' from tblscheduledreports where Id =ScheduleID;' + NL+
              ' 	Open mainc ;' + NL+
              ' 	Fetch mainc  into ReturnDate ;' + NL+
              '  	CLOSE mainc;' + NL+
              ' 	Return ReturnDate;' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;
function SPEncodeDateSQL:String;
begin
  Result :='drop function if exists EncodeDate; ' + NL+
              ' delimiter // ' + NL+
              '   CREATE FUNCTION `EncodeDate`(`days` INT, `Months` INT, `Years` INT) ' + NL+
              '   	RETURNS DATE ' + NL+
              '   BEGIN ' + NL+
              '   	RETURN STR_TO_DATE(concat(Days ,"," , months , "," , years),"%d,%m,%Y"); ' + NL+
              '   END;//' + NL+
              ' delimiter ;';
end;
function SPSleepSecondsSQL:String;
begin
  Result :='drop PROCEDURE if exists SleepSeconds; ' + NL+
              ' delimiter // ' + NL+
              '   CREATE   PROCEDURE `SleepSeconds`(IN `Sleepfor` INT) ' + NL+
              '   BEGIN ' + NL+
              '   Select Sleep(Sleepfor); ' + NL+
              '   END;//' + NL+
              ' delimiter ;';
end;

function SPFileExistsSQL:String;
begin
  Result :='drop function if exists FileExists; ' + NL+
              ' delimiter // ' + NL+
              '   CREATE  FUNCTION `FileExists`(`Filename` VARCHAR(255), `IterateCount` INT, `SleepSeconds` INT)' + NL+
              '   	RETURNS tinyint(4)' + NL+
              '   BEGIN' + NL+
              '   Declare ctr int;' + NL+
              '   Declare  Curfile cursor for SELECT isnull(LOAD_FILE(filename)) ;' + NL+
              '   open Curfile  ;' + NL+
              '   Fetch Curfile  into ctr ;' + NL+
              '   if ctr  <> 0 then' + NL+
              '   	return 1;' + NL+
              '   elseif IterateCount>0 then' + NL+
              '   	call SleepSeconds(SleepSeconds) ;' + NL+
              '   	return FileExists(Filename , IterateCount-1);' + NL+
              '   else' + NL+
              '   	return 1;' + NL+
              '   end if;' + NL+
              '   END;//' + NL+
              ' delimiter ;';
end;

function SPLastFiscalYearEndSQL:String;
begin
  Result :='DROP FUNCTION IF EXISTS `LastFiscalYearEnd`; ' + NL+
              ' delimiter // ' + NL+
              '   CREATE FUNCTION `LastFiscalYearEnd`() ' + NL+
              '   	RETURNS DATE ' + NL+
              '   BEGIN ' + NL+
              '   DECLARE fdDt Date; ' + NL+
              (*'   DECLARE Cur_LastFiscalYearEnd1 Cursor for  Select DATE_Add( Cast(concat(year(curdate())  , "/" ,(Select monthno(FieldValue) from tbldbpreferences where Name = "FiscalYearStarts" ) , "/01") as Date) ,  INTERVAL -1 DAY) DT; ' + NL+
              '   DECLARE Cur_LastFiscalYearEnd2 Cursor for  Select DATE_Add( Cast(concat(year(curdate()-1), "/" ,(Select monthno(FieldValue) from tbldbpreferences where Name = "FiscalYearStarts" ) , "/01") as Date) ,  INTERVAL -1 DAY) DT; ' + NL+
              '   Open Cur_LastFiscalYearEnd1; ' + NL+
              '   Fetch Cur_LastFiscalYearEnd1 into fdDt; ' + NL+
              '   if fdDt >= CurDate() then  '  + NL+
              '       Open Cur_LastFiscalYearEnd2; ' + NL+
              '       Fetch Cur_LastFiscalYearEnd2 into fdDt; ' + NL+
              '   end if;' + NL+
              '   RETURN fdDt; ' + NL+
              '  	CLOSE Cur_LastFiscalYearEnd1;' + NL+
              '  	CLOSE Cur_LastFiscalYearEnd2;' + NL+*)
              '   DECLARE Cur_LastFiscalYearEnd Cursor for  Select FiscalYearEnd(CURDATE()) DT; ' + NL+
              '   Open Cur_LastFiscalYearEnd; ' + NL+
              '   Fetch Cur_LastFiscalYearEnd into fdDt; ' + NL+
              '   Set fdDt = DATE_Add(fdDt,  INTERVAL -1 year) ; ' + NL+
              '  	CLOSE Cur_LastFiscalYearEnd;' + NL+
              '   RETURN fdDt; ' + NL+
              '   END;//' + NL+
              ' delimiter ;';
end;
function SPLastFiscalYearStartSQL:String;
begin
  Result :='DROP FUNCTION IF EXISTS `LastFiscalYearStart`; ' + NL+
              ' delimiter // ' + NL+
              '   CREATE FUNCTION `LastFiscalYearStart`() ' + NL+
              '   	RETURNS DATE ' + NL+
              '   BEGIN ' + NL+
              '   DECLARE fdDt Date; ' + NL+
              '   DECLARE Cur_LastFiscalYearStart Cursor for  Select FiscalYearStart(CURDATE()) DT; ' + NL+
              '   Open Cur_LastFiscalYearStart; ' + NL+
              '   Fetch Cur_LastFiscalYearStart into fdDt; ' + NL+
              '   Set fdDt = DATE_Add(fdDt,  INTERVAL -1 year) ; ' + NL+
              '  	CLOSE Cur_LastFiscalYearStart;' + NL+
              '   RETURN fdDt; ' + NL+
              '   END;//' + NL+
              ' delimiter ;';
end;
function SPFiscalYearStartSQL:String;
begin
  Result :='DROP FUNCTION IF EXISTS `FiscalYearStart`; ' + NL+
              ' delimiter // ' + NL+
              '   CREATE FUNCTION `FiscalYearStart`(aDate DATE) ' + NL+
              '   	RETURNS DATE ' + NL+
              '   BEGIN ' + NL+
              '   DECLARE fdDt Date; ' + NL+
              '   DECLARE Cur_FiscalYearStart1 Cursor for  Select Cast(concat(year(aDate)  , "/" ,(Select monthno(FieldValue) from tbldbpreferences where Name = "FiscalYearStarts" ) , "/01") as Date)  DT; ' + NL+
              '   DECLARE Cur_FiscalYearStart2 Cursor for  Select Cast(concat(year(aDate)-1, "/" ,(Select monthno(FieldValue) from tbldbpreferences where Name = "FiscalYearStarts" ) , "/01") as Date)  DT; ' + NL+
              '   Open Cur_FiscalYearStart1; ' + NL+
              '   Fetch Cur_FiscalYearStart1 into fdDt; ' + NL+
              '   if fdDt > adate then  '  + NL+
              '       Open Cur_FiscalYearStart2; ' + NL+
              '       Fetch Cur_FiscalYearStart2 into fdDt; ' + NL+
              '   end if;' + NL+
              '   RETURN fdDt; ' + NL+
              '  	CLOSE Cur_FiscalYearStart1;' + NL+
              '  	CLOSE Cur_FiscalYearStart2;' + NL+
              '   END;//' + NL+
              ' delimiter ;';
end;
function SPFiscalYearEndSQL:String;
begin
  Result :='DROP FUNCTION IF EXISTS `FiscalYearEnd`; ' + NL+
              ' delimiter // ' + NL+
              '   CREATE FUNCTION `FiscalYearEnd`(aDate DATE) ' + NL+
              '   	RETURNS DATE ' + NL+
              '   BEGIN ' + NL+
              '   DECLARE fdDt Date; ' + NL+
              '   DECLARE Cur_FiscalYearEnd1 Cursor for  Select DATE_Add( Cast(concat(year(aDate)  , "/" ,(Select monthno(FieldValue) from tbldbpreferences where Name = "FiscalYearStarts" ) , "/01") as Date) ,  INTERVAL -1 DAY)   DT; ' + NL+
              '   DECLARE Cur_FiscalYearEnd2 Cursor for  Select DATE_Add( Cast(concat(year(aDate)+1, "/" ,(Select monthno(FieldValue) from tbldbpreferences where Name = "FiscalYearStarts" ) , "/01") as Date) ,  INTERVAL -1 DAY)   DT; ' + NL+
              '   Open Cur_FiscalYearEnd1; ' + NL+
              '   Fetch Cur_FiscalYearEnd1 into fdDt; ' + NL+
              '   if fdDt < adate then  '  + NL+
              '       Open Cur_FiscalYearEnd2; ' + NL+
              '       Fetch Cur_FiscalYearEnd2 into fdDt; ' + NL+
              '   end if;' + NL+
              '   RETURN fdDt; ' + NL+
              '  	CLOSE Cur_FiscalYearEnd1;' + NL+
              '  	CLOSE Cur_FiscalYearEnd2;' + NL+
              '   END;//' + NL+
              ' delimiter ;';
end;
Function SPIncMonthSQL:String;
begin
  Result :='drop function if exists IncMonth; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `IncMonth`(`MonthFrom` INT, `YearFrom` INT, `NoOfMonths` INT) ' + NL+
              ' 	RETURNS DATE ' + NL+
              ' BEGIN ' + NL+
              ' 	Declare Dt Datetime; ' + NL+
              ' 	Set Dt = EncodeDate(1, monthfrom , yearFrom); ' + NL+
              ' 	Set Dt = Date_add(dt, Interval noOfmonths month); ' + NL+
              ' 	Set dt = Date_add(dt,  interval -1 Day) ; ' + NL+
              ' 	RETURN dt; ' + NL+
              ' END;//' + NL+
              ' delimiter ;';
end;

Function SPWeekDaynameSQL:String;
begin
Result := 'drop function if exists WeekDayname; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `WeekDayname`(`Dayno` INT)' + NL+
              '   RETURNS CHAR(20) ' + NL+
              ' BEGIN' + NL+
              '  	  if Dayno = 1 then RETURN "Monday";' + NL+
              '  elseif Dayno = 2 then RETURN "Tuesday";' + NL+
              '  elseif Dayno = 3 then RETURN "Wednesday";' + NL+
              '  elseif Dayno = 4 then RETURN "Thursday";' + NL+
              '  elseif Dayno = 5 then RETURN "Friday";' + NL+
              '  elseif Dayno = 6 then RETURN "Saturday";' + NL+
              '  elseif Dayno = 0 then RETURN "Sunday";' + NL+
              '  else RETURN "";' + NL+
              '  end if;' + NL+
              ' END;;//' + NL+
              ' delimiter ;';
end;

{this is used for BOM employee allocation TfmEmpResProcRoster
Sunday to SAturday : 1 to 7}
Function SPWeekDayNoSQL:String;
begin
Result := 'drop function if exists WeekDayNo; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `WeekDayNo`(`Dayname` CHAR(20))' + NL+
              '   RETURNS  INT' + NL+
              ' BEGIN' + NL+
              '      if Dayname = "Sunday"    then RETURN 1;' + NL+
              '  elseif Dayname = "Monday"    then RETURN 2;' + NL+
              '  elseif Dayname = "Tuesday"   then RETURN 3;' + NL+
              '  elseif Dayname = "Wednesday" then RETURN 4;' + NL+
              '  elseif Dayname = "Thursday"  then RETURN 5;' + NL+
              '  elseif Dayname = "Friday"    then RETURN 6;' + NL+
              '  elseif Dayname = "Saturday"  then RETURN 7;' + NL+
              '  else RETURN 0;' + NL+
              '  end if;' + NL+
              ' END;;//' + NL+
              ' delimiter ;';
end;

Function SPNextDayNoSQL:String;
begin
Result := 'drop function if exists NextDayNo; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `NextDayNo`(`Dayname` CHAR(20), DaysAfter INT)' + NL+
              '   RETURNS  INT' + NL+
              ' BEGIN' + NL+
              ' Declare iResult int(11); ' + NL+
              '      if Dayname = "Sunday"    then set iResult = 1;' + NL+
              '  elseif Dayname = "Monday"    then set iResult = 2;' + NL+
              '  elseif Dayname = "Tuesday"   then set iResult = 3;' + NL+
              '  elseif Dayname = "Wednesday" then set iResult = 4;' + NL+
              '  elseif Dayname = "Thursday"  then set iResult = 5;' + NL+
              '  elseif Dayname = "Friday"    then set iResult = 6;' + NL+
              '  elseif Dayname = "Saturday"  then set iResult = 7;' + NL+
              '  else set iResult = 0;' + NL+
              '  end if;' + NL+
              '  Set iResult = iResult +DaysAfter;' + NL+
              '  if iResult >7 then Set iResult := iResult -7; end if;' + NL+
              '  return iresult;' + NL+
              ' END;;//' + NL+
              ' delimiter ;';
end;


Function SPSaleTypeSQL:String;
begin

Result := 'drop function if exists SaleType; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `SaleType`(`pSAleID` INT)  RETURNS text ' + NL+
              ' BEGIN ' + NL+
              ' Declare fsIsPOS 			   VARCHAR(1); ' + NL+
              ' Declare fsPOS 				   VARCHAR(1); ' + NL+
              ' Declare fsIsRefund 		   VARCHAR(1); ' + NL+
              ' Declare fsIsCashSale 	   VARCHAR(1); ' + NL+
              ' Declare fsIsInvoice 		 VARCHAR(1); ' + NL+
              ' Declare fsIsQuote 		   VARCHAR(1); ' + NL+
              ' Declare fsIsSalesOrder 	 VARCHAR(1); ' + NL+
              ' Declare fsIsVoucher 		 VARCHAR(1); ' + NL+
              ' Declare fsIsLayby 		   VARCHAR(1); ' + NL+
              ' Declare fsIsLaybyTOS 	   VARCHAR(1); ' + NL+
              ' Declare fsIsLaybyPayment VARCHAR(1); ' + NL+
              ' DECLARE no_more_rows BOOLEAN; ' + NL+
              ' Declare sResult text; ' + NL+
              ' DECLARE Cur_Sales Cursor for  SELECT S.IsPOS,S.POS,S.IsRefund,S.IsCashSale,S.IsInvoice,S.IsQuote,S.IsSalesOrder,S.IsVoucher,S.IsLayby,S.IsLaybyTOS,S.IsLaybyPayment from tblSales S Where SaleID = pSaleID; ' + NL+
              ' DECLARE CONTINUE HANDLER FOR NOT FOUND     SET no_more_rows = TRUE; ' + NL+
              ' Open Cur_Sales ; ' + NL+
              ' the_loop: LOOP ' + NL+
              ' 	FETCH Cur_Sales into fsIsPOS,fsPOS,fsIsRefund,fsIsCashSale,fsIsInvoice,fsIsQuote,fsIsSalesOrder,fsIsVoucher,fsIsLayby,fsIsLaybyTOS,fsIsLaybyPayment ; ' + NL+
              ' 	IF no_more_rows THEN ' + NL+
              ' 		CLOSE Cur_Sales; ' + NL+
              ' 		LEAVE the_loop; ' + NL+
              ' 	END IF; ' + NL+
              ' 	     if upper(fsIsPOS) 				    = "T" then RETURN "POS";      ' + NL+
              ' 	elseif upper(fsPOS) 					    = "T" then RETURN "POS";      ' + NL+
              ' 	elseif upper(fsIsRefund) 			    = "T" then RETURN "Refund";   ' + NL+
              ' 	elseif upper(fsIsCashSale) 		    = "T" then RETURN "CashSale"; ' + NL+
              ' 	elseif upper(fsIsInvoice) 			  = "T" then RETURN "Invoice";  ' + NL+
              ' 	elseif upper(fsIsQuote) 			    = "T" then RETURN "Quote";    ' + NL+
              ' 	elseif upper(fsIsSalesOrder) 		  = "T" then RETURN "Sales Order"; ' + NL+
              ' 	elseif upper(fsIsVoucher) 			  = "T" then RETURN "Voucher";  ' + NL+
              ' 	elseif upper(fsIsLayby) 			    = "T" then RETURN "Layby";    ' + NL+
              ' 	elseif upper(fsIsLaybyTOS) 		    = "T" then RETURN "Layby";    ' + NL+
              ' 	elseif upper(fsIsLaybyPayment ) 	= "T" then RETURN "Layby";    ' + NL+
              '   else RETURN "Un-Known"; ' + NL+
              ' 	end if; ' + NL+
              ' END LOOP the_loop; ' + NL+
              ' END;//' + NL+
              ' delimiter ;';
end;

Function SPDescribeFormulaSQL:String;
begin

Result := 'drop function if exists DescribeFormula; ' + NL+
              ' delimiter //  ' + NL+
              ' CREATE FUNCTION DescribeFormula(Formula VARCHAR(255)) ' + NL+
              ' 	RETURNS VARCHAR(255) ' + NL+
              ' BEGIN ' + NL+
              ' 		Declare fsFormulaEntryno VARCHAR(255); ' + NL+
              ' 		Declare fsFormulaEntryname VARCHAR(255); ' + NL+
              ' 		Declare sResult VARCHAR(255); ' + NL+
              ' 		DECLARE no_more_rows BOOLEAN; ' + NL+
              ' 		Declare  CurFes cursor for select FormulaEntryno , FormulaEntryname from tblfenames; ' + NL+
              ' 		DECLARE CONTINUE HANDLER FOR NOT FOUND     SET no_more_rows = TRUE; ' + NL+
              ' 	Set sResult = formula; ' + NL+
              ' 	if Formula = "" then ' + NL+
              ' 	Return sResult; ' + NL+
              ' 	else ' + NL+
              ' 		open CurFes ; ' + NL+
              ' 		the_loop: LOOP ' + NL+
              ' 			Fetch CurFes  into  fsFormulaEntryno , fsFormulaEntryname ; ' + NL+
              ' 			IF 	no_more_rows THEN ' + NL+
              ' 				CLOSE CurFes; ' + NL+
              ' 				LEAVE the_loop; ' + NL+
              ' 			END IF; ' + NL+
              ' 			Set sResult = Replace(sResult , concat("Field" , trim(fsFormulaEntryno)) , concat("[",fsFormulaEntryname, "]")); ' + NL+
              ' 		END LOOP the_loop; ' + NL+
              ' 		Return sResult; ' + NL+
              ' 	end if; ' + NL+
              ' END //' + NL+
              ' delimiter ;';
end;

(*Function SPDescSalesLineSoldformulaSQL:String;
begin

Result := 'drop function if exists DescSalesLineSoldformula; ' + NL+
              ' delimiter //  ' + NL+
              ' CREATE FUNCTION DescSalesLineSoldformula(Formula VARCHAR(255)) ' + NL+
              ' 	RETURNS VARCHAR(255) ' + NL+
              ' BEGIN ' + NL+
              ' Declare fsFormulaEntryno VARCHAR(1); ' + NL+
              ' Declare fsActive VARCHAR(1); ' + NL+
              ' Declare sResult VARCHAR(255); ' + NL+
              ' Declare  CurFes cursor for select FormulaEntryno , Active from tblfenames; ' + NL+
              ' open CurFes ; ' + NL+
              ' Set sResult  = ""; ' + NL+
              ' the_loop: LOOP ' + NL+
              ' 	Fetch CurFes  into  fsFormulaEntryno , fsActive; ' + NL+
              ' 	IF 	no_more_rows THEN ' + NL+
              ' 		CLOSE CurFes; ' + NL+
              ' 		LEAVE the_loop; ' + NL+
              ' 	END IF; ' + NL+
              ' 	if fsFormulaEntryno ="1" and fsActive ="T" then Set sResult = trim(concat(sResult , " " , FormulaQtySoldValue1)); end if; ' + NL+
              ' 	if fsFormulaEntryno ="2" and fsActive ="T" then Set sResult = trim(concat(sResult , " " , FormulaQtySoldValue2)); end if; ' + NL+
              ' 	if fsFormulaEntryno ="3" and fsActive ="T" then Set sResult = trim(concat(sResult , " " , FormulaQtySoldValue3)); end if; ' + NL+
              ' 	if fsFormulaEntryno ="4" and fsActive ="T" then Set sResult = trim(concat(sResult , " " , FormulaQtySoldValue4)); end if; ' + NL+
              ' 	if fsFormulaEntryno ="5" and fsActive ="T" then Set sResult = trim(concat(sResult , " " , FormulaQtySoldValue5)); end if; ' + NL+
              ' END LOOP the_loop; ' + NL+
              ' Return sResult; ' + NL+
              ' END //' + NL+
              ' delimiter ;';
end;
Function SPDescSalesLinShippedformulaSQL:String;
begin

Result := 'drop function if exists DescSalesLinShippedformula; ' + NL+
              ' delimiter //  ' + NL+
              ' CREATE FUNCTION DescSalesLinShippedformula(Formula VARCHAR(255)) ' + NL+
              ' 	RETURNS VARCHAR(255) ' + NL+
              ' BEGIN ' + NL+
              ' Declare fsFormulaEntryno VARCHAR(1); ' + NL+
              ' Declare fsActive VARCHAR(1); ' + NL+
              ' Declare sResult VARCHAR(255); ' + NL+
              ' Declare  CurFes cursor for select FormulaEntryno , Active from tblfenames; ' + NL+
              ' open CurFes ; ' + NL+
              ' Set sResult  = ""; ' + NL+
              ' the_loop: LOOP ' + NL+
              ' 	Fetch CurFes  into  fsFormulaEntryno , fsActive; ' + NL+
              ' 	IF 	no_more_rows THEN ' + NL+
              ' 		CLOSE CurFes; ' + NL+
              ' 		LEAVE the_loop; ' + NL+
              ' 	END IF; ' + NL+
              ' 	if fsFormulaEntryno ="1" and fsActive ="T" then Set sResult = trim(concat(sResult , " " , FormulaQtyShippedValue1)); end if; ' + NL+
              ' 	if fsFormulaEntryno ="2" and fsActive ="T" then Set sResult = trim(concat(sResult , " " , FormulaQtyShippedValue2)); end if; ' + NL+
              ' 	if fsFormulaEntryno ="3" and fsActive ="T" then Set sResult = trim(concat(sResult , " " , FormulaQtyShippedValue3)); end if; ' + NL+
              ' 	if fsFormulaEntryno ="4" and fsActive ="T" then Set sResult = trim(concat(sResult , " " , FormulaQtyShippedValue4)); end if; ' + NL+
              ' 	if fsFormulaEntryno ="5" and fsActive ="T" then Set sResult = trim(concat(sResult , " " , FormulaQtyShippedValue5)); end if; ' + NL+
              ' END LOOP the_loop; ' + NL+
              ' Return sResult; ' + NL+
              ' END //' + NL+
              ' delimiter ;';
end;*)
Function SPSameValueSQL:String;
begin
  Result := 'Drop function if exists SameValue; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `SameValue`(`No1` doUBLE, `No2` doUBLE, `Roundto` INT)	RETURNS InT ' + NL+
              ' BEGIN ' + NL+
              ' if Round(no1,roundto) = Round(no2,roundto) then RETURN 1 ; else RETURN 0; end if; ' + NL+
              ' END;// ' + NL+
              ' delimiter ; ' ;
end;

Function SPTableExistsSQL:String;
begin
  Result := 'Drop function if exists TableExists; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `TableExists`(`Tablename` text) ' + NL+
              ' 	RETURNS TINYINT  ' + NL+
              ' BEGIN ' + NL+
              ' 	DECLARE sTablename VARCHAR(255); ' + NL+
              ' 	DECLARE no_more_rows BOOLEAN; ' + NL+
              ' 	DECLARE cur_Tables Cursor FOR 	SELECT Table_NAME FROM INFORMATION_SCHEMA.TableS WHERE Table_SCHEMA= Database() and Table_NAME =Tablename; ' + NL+
              ' 	DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows = TRUE; ' + NL+
              ' 	Open cur_Tables ; ' + NL+
              ' 	FETCH cur_Tables  into sTablename; ' + NL+
              ' 	IF no_more_rows THEN RETURN 0; ' + NL+
              ' 	elseif ifnull(sTablename,"") = "" then  RETURN 0; ' + NL+
              ' 	else RETURN 1; ' + NL+
              ' 	end if; ' + NL+
              ' 	CLOSE cur_Tables; ' + NL+
              ' END;// ' + NL+
              ' delimiter ; ' ;
end;




Function SPDateRangetypeToMonthSQL:String;
begin
  Result := 'Drop function if exists DateRangetypeToMonth; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `DateRangetypeToMonth`(`DateRange` TEXT) ' + NL+
              ' 	RETURNS INT ' + NL+
              ' 	BEGIN ' + NL+
              ' 		if upper(DateRange) = "MONTHLY" then RETURN 1; ' + NL+
              ' 		elseif upper(DateRange) = "TWO MONTHLY" then RETURN 2; ' + NL+
              ' 		elseif upper(DateRange) = "QUARTERLY" then RETURN 3; ' + NL+
              ' 		elseif upper(DateRange) = "FOUR MONTHLY" then RETURN 4; ' + NL+
              ' 		elseif upper(DateRange) = "FIVE MONTHLY" then RETURN 5; ' + NL+
              ' 		elseif upper(DateRange) = "SIX MONTHLY" then RETURN 6; ' + NL+
              ' 		elseif upper(DateRange) = "HALF YEARLY" then RETURN 6; ' + NL+
              ' 		elseif upper(DateRange) = "YEARLY" then RETURN 12; ' + NL+
              '     else RETURN 0; ' + NL+
              ' 		end if; ' + NL+
              ' 	END;// ' + NL+
              ' delimiter ; ' ;
end;
Function SPPartHasAnyTransactionSQL:String;
begin
  Result := 'Drop function if exists PartHasAnyTransaction; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `PartHasAnyTransaction`(`ID` INT) ' + NL+
              ' 	RETURNS TINYINT ' + NL+
              ' BEGIN ' + NL+
              ' 	DECLARE ctr INT; ' + NL+
              ' 	DECLARE no_more_rows BOOLEAN; ' + NL+
              ' 	DECLARE cur_Trans Cursor FOR 		Select ' + NL+
              ' 											ifnull((Select count(*) from tblproctree where PartsId = ID),0)+ ' + NL+
              ' 											ifnull((Select count(*) from tblsaleslines where ProductID = ID),0)+ ' + NL+
              ' 											ifnull((Select count(*) from tblrepairparts where PartsID = ID),0) + ' + NL+
              ' 											ifnull((Select count(*) from tblpurchaselines where ProductID = ID),0)+ ' + NL+
              ' 											ifnull((Select count(*) from tblsmartorderlines where PARTSID = ID),0)+ ' + NL+
              ' 											ifnull((Select count(*) from tblstockmovementlines where ProductID = ID),0)+ ' + NL+
              ' 											ifnull((Select count(*) from tblstockadjustentrylines where ProductID = ID),0)+ ' + NL+
              ' 											ifnull((Select count(*) from tblstocktransferentrylines where ProductID = ID),0) as transcount; ' + NL+
              ' 	Open cur_Trans ; ' + NL+
              ' 	FETCH cur_Trans  into ctr; ' + NL+
              ' 	RETURN ctr; ' + NL+
              ' 	CLOSE cur_Trans; ' + NL+
              ' END;// ' + NL+
              ' delimiter ; ' ;
end;
Function SPMonthNoSQL:String;
begin
  Result := 'Drop function if exists MonthNo; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `MonthNo`(`sMonth` TEXT) ' + NL+
              ' 	RETURNS INT ' + NL+
              ' BEGIN ' + NL+
              ' if upper(sMonth) = "JANUARY" then  RETURN 1; ' + NL+
              ' elseif upper(sMonth) = "FEBRUARY" then  RETURN 2; ' + NL+
              ' elseif upper(sMonth) = "MARCH" then  RETURN 3; ' + NL+
              ' elseif upper(sMonth) = "APRIL" then  RETURN 4; ' + NL+
              ' elseif upper(sMonth) = "MAY" then  RETURN 5; ' + NL+
              ' elseif upper(sMonth) = "JUNE" then  RETURN 6; ' + NL+
              ' elseif upper(sMonth) = "JULY" then  RETURN 7; ' + NL+
              ' elseif upper(sMonth) = "AUGUST" then  RETURN 8; ' + NL+
              ' elseif upper(sMonth) = "SEPTEMBER" then  RETURN 9; ' + NL+
              ' elseif upper(sMonth) = "OCTOBER" then  RETURN 10; ' + NL+
              ' elseif upper(sMonth) = "NOVEMBER" then  RETURN 11; ' + NL+
              ' elseif upper(sMonth) = "DECEMBER" then  RETURN 12; ' + NL+
              ' else RETURN 0; ' + NL+
              ' end if; ' + NL+
              ' END;// ' + NL+
              ' delimiter ; ' ;
end;

Function SPCStoQuotedCSSQL:String;
begin
  Result := 'Drop function if exists CStoQuotedCS; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `CStoQuotedCS`(`Data` text) 	RETURNS text ' + NL+
              ' BEGIN ' + NL+
              ' if ifnull(Data , "") = "" then RETURN ""; ' + NL+
              ' else   RETURN concat(''"'' , replace(data,'','' , ''","''),''"''); ' + NL+
              ' end if; ' + NL+
              ' END;// ' + NL+
              ' delimiter ; ' ;
end;

Function SPAllrelatedSaleIdsSQL:String;
begin
  Result := 'Drop function if exists AllRelatedSaleIDs; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `AllRelatedSaleIDs`(`pSaleID` INT) RETURNS text ' + NL+
              ' BEGIN ' + NL+
              ' Declare iSaleID int; ' + NL+
              ' DECLARE no_more_rows BOOLEAN; ' + NL+
              ' Declare sResult text; ' + NL+
              ' DECLARE Cur_Sales Cursor for ' + NL+
              ' Select Distinct SaleId from tblsales  where saleId =pSaleID and isinvoice ="F" and  issalesorder="F" ' + NL+
              ' union all ' + NL+
              ' Select distinct SaleId from tblsales where originalno  in (select originalno  from tblsales where saleId = pSaleID and (isinvoice ="T" or issalesorder="T")) ' + NL+
              ' union all ' + NL+
              ' Select distinct SaleId from tblsales where originalno  in (Select Originalno from tblsales where globalref in (select ifnull(SalesorderGlobalref,"") from tblsales where saleId = pSaleID and isinvoice ="T")) ' + NL+
              ' union all ' + NL+
              ' Select distinct SaleId from tblsales where originalno  in (Select Originalno from tblSales where ifnull(SalesorderGlobalref,"") in (Select globalref from tblsales where saleId = pSaleID and issalesorder="T")); ' + NL+
              ' DECLARE CONTINUE HANDLER FOR NOT FOUND     SET no_more_rows = TRUE; ' + NL+
              ' Set sResult = ""; ' + NL+
              ' Open Cur_Sales ; ' + NL+
              ' the_loop: LOOP ' + NL+
              ' 	FETCH Cur_Sales into iSaleID; ' + NL+
              ' 	 IF no_more_rows THEN ' + NL+
              '         CLOSE Cur_Sales; ' + NL+
              '         LEAVE the_loop; ' + NL+
              '     END IF; ' + NL+
              '     if sResult <> "" then Set sResult = concat(sResult ,","); end if; ' + NL+
              ' 	 Set sResult = concat(sResult ,iSAleId); ' + NL+
              ' END LOOP the_loop; ' + NL+
              ' RETURN sResult; ' + NL+
              ' END;// ' + NL+
              ' delimiter ; ' ;
end;
function SpProcessstatusSQL:String;
begin
	Result := 'drop function if exists ProcessStatus; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `ProcessStatus`(`SaleLineId` INT)  RETURNS text  ' + NL+
              ' BEGIN  ' + NL+
              ' Declare AllStatus VARCHAR(255);  ' + NL+
              ' DECLARE Cur_Status Cursor for Select group_concat(distinct ppd.Status) ' + NL+
                  ' from tblProcTree ptd ' + NL+
                  ' inner JOIN tblProcessPart PPd on PPd.ProcTreeId = PTd.ProcTreeId ' + NL+
                  ' where ptd.MasterId = saleLineId and ptd.MasterType = "mtSalesOrder" ;  ' + NL+
              ' Open Cur_Status;  ' + NL+
              ' FETCH Cur_Status into AllStatus;     ' + NL+
              ' RETURN    ProcessPartStatusToUserStr(AllStatus);'+
              ' END;//' + NL+
              ' delimiter ;';
End;
Function SPProcessPartStatusToNoSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS ProcessPartStatusToNo; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION ProcessPartStatusToNo(ProcessPartStatus VARCHAR(50) )   ' + NL+
          ' RETURNS INT   ' + NL+
          ' BEGIN  ' + NL+
                  ' if ProcessPartStatus  = "psNotScheduled"      then RETURN 1;  ' + NL+
              ' elseif ProcessPartStatus  = "psScheduled"         then RETURN 2 ;  ' + NL+
              ' elseif ProcessPartStatus  = "psStarted"           then RETURN 3;  ' + NL+
              ' elseif ProcessPartStatus  = "psnStoped"           then RETURN 4;  ' + NL+
              ' elseif ProcessPartStatus  = "psQualityAssurance"  then RETURN 5;  ' + NL+
              ' elseif ProcessPartStatus  = "psComplete"          then RETURN 6;  ' + NL+
              ' elseif locate("PS_SCHEDULED"        , ProcessPartStatus)>0 then RETURN 2;  ' + NL+
              ' elseif locate("psScheduled"         , ProcessPartStatus)>0 then RETURN 2;  ' + NL+
              ' elseif locate("psStarted"           , ProcessPartStatus)>0 then RETURN 3;  ' + NL+
              ' elseif locate("psComplete"          , ProcessPartStatus)>0 then RETURN 4;  ' + NL+
              ' elseif locate("psQualityAssurance"  , ProcessPartStatus)>0 then RETURN 5;  ' + NL+
              ' else RETURN 10;  end if; ' + NL+
          ' END; // ' ;

end;
Function SPProcessPartStatusNoToStrSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS ProcessPartStatusNoToStr; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION ProcessPartStatusNoToStr(ProcessPartStatusNo  int(11) )   ' + NL+
          ' RETURNS VARCHAR(50)   ' + NL+
          ' BEGIN  ' + NL+
              '     if ProcessPartStatusNo  = 1 then RETURN ' + NL+ Quotedstr(PS_STR_NOTSCHEDULED)    +';  ' + NL+
              ' elseif ProcessPartStatusNo  = 2 then RETURN ' + NL+ Quotedstr(PS_STR_SCHEDULED)       +';  ' + NL+
              ' elseif ProcessPartStatusNo  = 3 then RETURN ' + NL+ Quotedstr(PS_STR_STARTED)         +';  ' + NL+
              ' elseif ProcessPartStatusNo  = 4 then RETURN ' + NL+ Quotedstr(PS_STR_STOPPED)         +';  ' + NL+
              ' elseif ProcessPartStatusNo  = 5 then RETURN ' + NL+ Quotedstr(PS_STR_QualityAssurance)+';  ' + NL+
              ' elseif ProcessPartStatusNo  = 6 then RETURN ' + NL+ QuotedStr(PS_STR_COMPLETE)        +';  ' + NL+
              ' else RETURN "no Process";  end if; ' + NL+
          ' END; // ' ;
end;
Function SPAccLevelNoToDescriptionSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS AccLevelNoToDescription; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION AccLevelNoToDescription(AccLevelNo  int(11) )   ' + NL+
          ' RETURNS VARCHAR(50)   ' + NL+
          ' BEGIN  ' + NL+
              '     if AccLevelNo  = 1 then RETURN ' + NL+ Quotedstr(ACC_LVL_MSG_1)    +';  ' + NL+
              ' elseif AccLevelNo  = 2 then RETURN ' + NL+ Quotedstr(ACC_LVL_MSG_2)       +';  ' + NL+
              ' elseif AccLevelNo  = 3 then RETURN ' + NL+ Quotedstr(ACC_LVL_MSG_3)         +';  ' + NL+
              ' elseif AccLevelNo  = 4 then RETURN ' + NL+ Quotedstr(ACC_LVL_MSG_4)         +';  ' + NL+
              ' elseif AccLevelNo  = 5 then RETURN ' + NL+ Quotedstr(ACC_LVL_MSG_5)+';  ' + NL+
              ' elseif AccLevelNo  = 6 then RETURN ' + NL+ QuotedStr(ACC_LVL_MSG_6)        +';  ' + NL+
              ' else RETURN "No Access Defined";  end if; ' + NL+
          ' END; // ' ;
end;
Function SPBOMTypetoStrSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS BOMTypetoStr; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION BOMTypetoStr(BOMType VARCHAR(255) )   ' + NL+
          ' RETURNS VARCHAR(50)   ' + NL+
          ' BEGIN  ' + NL+
              '     if BOMType  = "psManufacture" then RETURN "Manufacture";  ' + NL+
              ' elseif BOMType  = "psStock" then RETURN "From Stock";  ' + NL+
              ' else RETURN "";  end if; ' + NL+
          ' END; // ' ;
end;
Function SPInputTypetoStrSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS InputTypetoStr; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION InputTypetoStr(Inputtype VARCHAR(255) )   ' + NL+
          ' RETURNS VARCHAR(50)   ' + NL+
          ' BEGIN  ' + NL+
              '     if Inputtype  = "itnone" then RETURN "";  ' + NL+
              ' elseif Inputtype  = "itUser" then RETURN "User";  ' + NL+
              ' elseif Inputtype  = "itOption" then RETURN "Option";  ' + NL+
              ' elseif Inputtype  = "itCustom" then RETURN "Custom";  ' + NL+
              ' else RETURN "";  end if; ' + NL+
          ' END; // ' ;
end;
Function SPProcessPartStatusNoToStrValSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS ProcessPartStatusNoToStrVal; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION ProcessPartStatusNoToStrVal(ProcessPartStatusNo  int(11) )   ' + NL+
          ' RETURNS VARCHAR(50)   ' + NL+
          ' BEGIN  ' + NL+
              '     if ProcessPartStatusNo  = 1 then RETURN ' + NL+ Quotedstr(PS_NOTSCHEDULED)    +';  ' + NL+
              ' elseif ProcessPartStatusNo  = 2 then RETURN ' + NL+ Quotedstr(PS_SCHEDULED)       +';  ' + NL+
              ' elseif ProcessPartStatusNo  = 3 then RETURN ' + NL+ Quotedstr(PS_STARTED)         +';  ' + NL+
              ' elseif ProcessPartStatusNo  = 4 then RETURN ' + NL+ Quotedstr(PS_STOPPED)         +';  ' + NL+
              ' elseif ProcessPartStatusNo  = 5 then RETURN ' + NL+ Quotedstr(PS_QualityAssurance)+';  ' + NL+
              ' elseif ProcessPartStatusNo  = 6 then RETURN ' + NL+ QuotedStr(PS_COMPLETE)        +';  ' + NL+
              ' else RETURN ' + NL+ Quotedstr(PS_NOTSCHEDULED)    +';  end if; ' + NL+
          ' END; // ' ;
end;

Function SPHireStatusSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS HireStatus; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION HireStatus(Status VARCHAR(50) )   ' + NL+
          ' RETURNS VARCHAR(50)   ' + NL+
          ' BEGIN  ' + NL+
                  ' if Status  = "Q"          then RETURN "Quote";  ' + NL+
              ' elseif Status  = "O"          then RETURN "On Hire" ;  ' + NL+
              ' elseif Status  = "I"          then RETURN "Invoiced";  ' + NL+
              ' elseif Status  = "R"          then RETURN "Returned";  ' + NL+
              ' elseif Status  = "N"          then RETURN "Off Hire";  ' + NL+
              ' else RETURN "";  end if; ' + NL+
          ' END; // ' ;

end;
Function SPSeedToSalePhaseSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS SeedToSalePhase; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION SeedToSalePhase(aPhase VARCHAR(1) )   ' + NL+
          ' RETURNS VARCHAR(50)   ' + NL+
          ' BEGIN  ' + NL+
                  ' if aPhase  = "I"          then RETURN "Immature";  ' + NL+
              ' elseif aPhase  = "V"          then RETURN "Vegetative" ;  ' + NL+
              ' elseif aPhase  = "F"          then RETURN "Flowering";  ' + NL+
              ' elseif aPhase  = "H"          then RETURN "Harvest";  ' + NL+
              ' elseif aPhase  = "P"          then RETURN "Product";  ' + NL+
              ' else RETURN "";  end if; ' + NL+
          ' END; // ' ;

end;
Function SPDurationdescSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS Durationdesc; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION Durationdesc(Status VARCHAR(50) )   ' + NL+
          ' RETURNS VARCHAR(50)   ' + NL+
          ' BEGIN  ' + NL+
                  ' if Status  = "Y"          then RETURN "Year(s)";  ' + NL+
              ' elseif Status  = "M"          then RETURN "Month(s)" ;  ' + NL+
              ' elseif Status  = "W"          then RETURN "Week(s)";  ' + NL+
              ' elseif Status  = "D"          then RETURN "Day(s)";  ' + NL+
              ' elseif Status  = "H"          then RETURN "Hour(s)";  ' + NL+
              ' else RETURN "";  end if; ' + NL+
          ' END; // ' ;

end;

Function SPDurationtypeToDescriptionSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS DurationtypeToDescription; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION DurationtypeToDescription(Value VARCHAR(50) )   ' + NL+
          ' RETURNS VARCHAR(50)   ' + NL+
          ' BEGIN  ' + NL+
                  ' if Value  = "H"          then RETURN "Hour";  ' + NL+
              ' elseif Value  = "D"          then RETURN "Day" ;  ' + NL+
              ' elseif Value  = "W"          then RETURN "Week";  ' + NL+
              ' elseif Value  = "M"          then RETURN "Month";  ' + NL+
              ' elseif Value  = "Y"          then RETURN "Year";  ' + NL+
              ' else RETURN "";  end if; ' + NL+
          ' END; // ' ;

end;

function SPProcessPartStatusToUserStrSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS ProcessPartStatusToUserStr; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION ProcessPartStatusToUserStr(ProcessPartStatus VARCHAR(50) )   ' + NL+
          ' RETURNS TEXT   ' + NL+
          ' BEGIN  ' + NL+
                  ' if ProcessPartStatus  = "psComplete"          then RETURN ' + NL+ QuotedStr(PS_STR_COMPLETE) +';  ' + NL+
              ' elseif ProcessPartStatus  = "psScheduled"         then RETURN ' + NL+ Quotedstr(PS_STR_SCHEDULED)+' ;  ' + NL+
              ' elseif ProcessPartStatus  = "psStarted"           then RETURN ' + NL+ Quotedstr(PS_STR_STARTED)+';  ' + NL+
              ' elseif ProcessPartStatus  = "psNotScheduled"      then RETURN ' + NL+ Quotedstr(PS_STR_NOTSCHEDULED)+';  ' + NL+
              ' elseif ProcessPartStatus  = "psQualityAssurance"  then RETURN ' + NL+ QuotedStr(PS_STR_QualityAssurance) +';  ' + NL+
              ' elseif locate("psStarted"           , ProcessPartStatus)>0 then RETURN ' + NL+Quotedstr(PS_STR_STARTED)+';  ' + NL+
              ' elseif locate("psScheduled"         , ProcessPartStatus)>0 then RETURN ' + NL+Quotedstr(PS_STR_SCHEDULED)+';  ' + NL+
              ' elseif locate("psQualityAssurance"  , ProcessPartStatus)>0 then RETURN ' + NL+Quotedstr(PS_STR_QualityAssurance)+';  ' + NL+
              ' elseif locate("PS_SCHEDULED"        , ProcessPartStatus)>0 then RETURN ' + NL+Quotedstr(PS_STR_SCHEDULED)+' ;  ' + NL+
              ' elseif locate("psComplete"          , ProcessPartStatus)>0 then RETURN ' + NL+Quotedstr(PS_STR_STARTED)+';  ' + NL+
              ' else RETURN "no Process";  end if; ' + NL+
          ' END; // ' ;
end;

function SPVersionToNoSQL: String;
begin
    Result:= 'drop function if exists VersionToNo; ' + NL+
              ' delimiter // ' + NL+
              '  CREATE DEFINER=`P_One`@`%` FUNCTION `VersionToNo`(`Version` VARCHAR(20))  RETURNS bigint(20)  ' + NL+
              ' BEGIN  ' + NL+
              '   Declare vData VARCHAR(50);  ' + NL+
              '   Declare s1  VARCHAR(4);  ' + NL+
              '   Declare s2  VARCHAR(4);  ' + NL+
              '   Declare s3  VARCHAR(4);  ' + NL+
              '   Declare s4  VARCHAR(4);  ' + NL+
              '   Declare x int;  ' + NL+
              '   Set vData = version;  ' + NL+
              '   if length(vdata) - length(replace(vdata,''.'','''')) = length(vdata) then  ' + NL+
              '     if IsInteger(vdata) = "T"  then  RETURN CONVERT(VDATA , UNSIGNED);  ' + NL+
              '     else return 9999999999; end if;  ' + NL+
              '     else  if IsInteger(replace(vdata,''.'','''')) <> "T" then return 9999999999; else  ' + NL+
              '       if vdata = "" then  RETURN 0;  else  ' + NL+
              '         set x =0;  ' + NL+
              '         set s1 = "";  ' + NL+
              '         while substr(vData,	x,1) <> "."  and  x<= Length(Vdata) do set s1 = concat(s1 , substr(vData,	x,1)); set x = x+1; end while;  ' + NL+
              '         set x = x+1;  ' + NL+
              '         set s2 = "";  ' + NL+
              '         if x< Length(Vdata)  then  ' + NL+
              '           while substr(vData,	x,1) <> "." and  x<= Length(Vdata) do set s2 = concat(s2 , substr(vData,	x,1)); set x = x+1; end while;  ' + NL+
              '           set x = x+1;  ' + NL+
              '           set s3 = "";  ' + NL+
              '           if x< Length(Vdata)  then  ' + NL+
              '             while substr(vData,	x,1) <> "." and  x<= Length(Vdata) do set s3 = concat(s3 , substr(vData,	x,1)); set x = x+1; end while;  ' + NL+
              '             set x = x+1;  ' + NL+
              '             set s4 = "";  ' + NL+
              '             if x< Length(Vdata)  then  ' + NL+
              '               while x <=length(vdata) and  x<= Length(Vdata) do set s4 = concat(s4 , substr(vData,	x,1)); set x = x+1; end while;  ' + NL+
              '             end if;  ' + NL+
              '           end if;  ' + NL+
              '         end if;  ' + NL+
              '        RETURN s1*1000 +s2*100 + s3*10+s4;  ' + NL+
              '      end if;  ' + NL+
              '    end if;  ' + NL+
              '  end if;  ' + NL+
              '  END;// ' + NL+
              ' delimiter ;';
end;

function SPTermToDaysSQL: String;
begin
  Result:= 'DROP FUNCTION IF EXISTS TermToDays; ' + NL +
            ' delimiter // ' + NL +
            '  CREATE DEFINER=`P_One`@`%` FUNCTION `TermToDays`(`PTerm` VARCHAR(50), `PDate` DATETIME) RETURNS int(11) ' + NL+
            ' BEGIN  ' + NL+
            '   DECLARE TDays INT; ' + NL +
            '   DECLARE DueDate DateTime; ' + NL +
            '   DECLARE PastDays INT; ' + NL +
            '   SET DueDate = CURDATE();  ' + NL +
            '   IF PTerm REGEXP "^[0-9]" = 1 THEN ' + NL +
            '     SET TDays = SUBSTRING(PTerm, 1, LENGTH(PTerm) - 5); ' + NL +
            '     SET DueDate = DATE_ADD(PDate, INTERVAL @TDays DAY); ' + NL +
            '   ELSEIF PTerm = "Due on Receipt" THEN ' + NL +
            '     SET DueDate = PDate; ' + NL +
            '   ELSEIF PTerm = "COD" THEN ' + NL +
            '     SET DueDate = PDate; ' + NL +
            '   ELSEIF PTerm = "PrePayment" THEN  ' + NL +
            '     SET DueDate = PDate; ' + NL +
            '   ELSEIF PTerm = "EOM" THEN ' + NL +
            '     SET DueDate = LAST_DAY(PDate); ' + NL +
            '   ELSEIF PTerm = "EOM + 20" THEN ' + NL +
            '     SET DueDate = DATE_ADD(LAST_DAY(PDate), INTERVAL 20 DAY); ' + NL +
            '   ELSEIF PTerm = "EOM + EOM" THEN ' + NL +
            '     SET DueDate = DATE_ADD(LAST_DAY(PDate), INTERVAL 1 MONTH); ' + NL +
            '   END IF; ' + NL +
            '   SET PastDays = DATEDIFF(CURDATE(), DueDate); ' + NL +
            '   RETURN PastDays; ' + NL +
            ' END;//';
end;

function SPNextVersionNoSQL: String;
begin
    Result:= 'drop function if exists NextVersionNo; ' + NL+
              ' delimiter // ' + NL+
              '  CREATE DEFINER=`P_One`@`%` FUNCTION `NextVersionNo`(`Version` VARCHAR(50))  RETURNS varchar(50) ' + NL+
              ' BEGIN  ' + NL+
              ' Declare vData VARCHAR(50); ' + NL+
              ' Declare s1  VARCHAR(4); ' + NL+
              ' Declare s2  VARCHAR(4); ' + NL+
              ' Declare s3  VARCHAR(4); ' + NL+
              ' Declare s4  VARCHAR(4); ' + NL+

              ' Declare x int; ' + NL+
              ' Set vData = version; ' + NL+
              ' if length(vdata) - length(replace(vdata,".","")) = length(vdata) then ' + NL+
              '   if IsInteger(vdata) = "T"  then  RETURN CONVERT(VDATA , UNSIGNED); ' + NL+
              '   else return "2020.0.0.0"; end if; ' + NL+
              '   else  if IsInteger(replace(vdata,".","")) <> "T" then return "2020.0.0.0"; else ' + NL+
              '     if vdata = "" then  RETURN  "2020.0.0.0";  else ' + NL+
              '       set x =0; ' + NL+
              '       set s1 = ""; ' + NL+
              '       while substr(vData,	x,1) <> "."  and  x<= Length(Vdata) do set s1 = concat(s1 , substr(vData,	x,1)); set x = x+1; end while; ' + NL+
              '       set x = x+1; ' + NL+
              '       set s2 = ""; ' + NL+
              '       if x< Length(Vdata)  then ' + NL+
              '         while substr(vData,	x,1) <> "." and  x<= Length(Vdata) do set s2 = concat(s2 , substr(vData,	x,1)); set x = x+1; end while; ' + NL+
              '         set x = x+1; ' + NL+
              '         set s3 = ""; ' + NL+
              '         if x< Length(Vdata)  then ' + NL+
              '           while substr(vData,	x,1) <> "." and  x<= Length(Vdata) do set s3 = concat(s3 , substr(vData,	x,1)); set x = x+1; end while; ' + NL+
              '           set x = x+1; ' + NL+
              '           set s4 = ""; ' + NL+
              '           if x< Length(Vdata)  then ' + NL+
              '             while x <=length(vdata) and  x<= Length(Vdata) do set s4 = concat(s4 , substr(vData,	x,1)); set x = x+1; end while; ' + NL+
              '           end if; ' + NL+
              '         end if; ' + NL+
              '       end if; ' + NL+
              '       if s3<9 then SET s3 = s3+1; ELSE SET s3= 0; SET s2 = s2+1; END if; ' + NL+
              '       if s2>=9 then set s2="0";set s1= s1+1; END if; ' + NL+
              '       RETURN concat(s1,".",s2,".",s3,".0"); ' + NL+
              '    end if; ' + NL+
              '  end if; ' + NL+
              ' end if; ' + NL+
              ' END;// ' + NL+
              ' delimiter ;';
end;
function SPNewLineSQL:String;
begin
    Result:= 'drop function if exists NewLine; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `NewLine`()  RETURNS text ' + NL+
              ' BEGIN ' + NL+
              ' RETURN CHAR(13,10); ' + NL+
              ' END ;// ' + NL+
              ' delimiter ;';
end;
function SPRemoveBlankLineSQL:String;
begin

    Result:= 'Drop function if exists RemoveBlankLine; ' + NL+
              ' delimiter // ' + NL+
              ' CREATE FUNCTION `RemoveBlankLine`(`Data` text)  RETURNS text ' + NL+
              ' BEGIN ' + NL+
              ' RETURN Replace(data , CHAR(13,10)+CHAR(13,10) , CHAR(13,10)); ' + NL+
              ' END ;// ' + NL+
              ' delimiter ;';
end;
function SPFormatSecondsSQL:String;
begin
    Result:= 'DROP FUNCTION IF EXISTS `FormatSeconds`; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION `FormatSeconds`(SecsInaWorkingDay INT, `Seconds` INT)   ' + NL+
          ' RETURNS teXT   ' + NL+
          ' BEGIN  ' + NL+
          ' declare d         int;  ' + NL+
          ' declare h         int;  ' + NL+
          ' declare m         int;  ' + NL+
          ' declare s         int;  ' + NL+
          ' declare secsinday int;  ' + NL+
          ' declare secsinmin int;  ' + NL+
          ' declare secsinhr  int;  ' + NL+
          ' declare hrStr     VARCHAR(30);  ' + NL+
          ' declare dStr      VARCHAR(30);  ' + NL+
          ' declare minStr    VARCHAR(30);  ' + NL+
          ' declare secstr    VARCHAR(30);   ' + NL+
          ' if SecsInaWorkingDay =0 then Set     secsinday = 86400; else Set     secsinday = SecsInaWorkingDay; end if;'+
          ' Set     secsinhr  = 3600;'+
          ' Set     secsinmin = 60;'+
          ' Set     d         = 0;'+
          ' Set     h         = 0;'+
          ' Set     m         = 0;'+
          ' Set     s         = 0;'+
          ' if Seconds =0 then 	RETURN ""; else'+
          ' if Seconds >=secsinday then  Set d = truncate(abs(Seconds) /secsinday ,0);  set Seconds  := Seconds    -(d*secsinday); end if;' + NL+
          ' if Seconds >=secsinhr  then  Set h = truncate(abs(Seconds) /secsinhr  ,0);  set Seconds  := Seconds    -(h*secsinhr);  end if;' + NL+
          ' if Seconds >=secsinmin then  Set m = truncate(abs(seconds) /secsinmin ,0);  set Seconds  := Seconds    -(m*secsinmin); end if;' + NL+
          ' Set s = seconds ;  ' + NL+
          ' if d =0 then Set dStr ="000" ; elseif d < 10 then Set dStr = concat("00",d) ; elseif d < 100 then Set dStr = concat("0",d) ; else Set dStr = d ; end if;  ' + NL+
          ' if h =0 then Set hrStr ="00" ; elseif h < 10 then Set hrStr = concat("0",h) ; else Set hrStr = h ; end if;  ' + NL+
          ' if m =0 then  Set minStr ="00" ; elseif m < 10 then set minStr = concat("0",m) ; else Set minStr = m ; end if;  ' + NL+
          ' if s =0 then  Set SecStr ="00" ; elseif s < 10 then set SecStr = concat("0",s) ; else Set SecStr = s ; end if;   ' + NL+
          ' RETURN concat(dStr, ":" , hrStr ,":" ,minStr ,":" ,SecStr);   ' + NL+
          ' end if;'+
          ' END;// ' + NL+
          ' delimiter ;';
end;

function SPFormatSecondsTotimeSQL:String;
begin
    Result:= 'DROP FUNCTION IF EXISTS `FormatSecondsTotime`; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION `FormatSecondsTotime`(`Seconds` INT)   ' + NL+
          ' RETURNS teXT   ' + NL+
          ' BEGIN  ' + NL+
          ' declare h         int;  ' + NL+
          ' declare m         int;  ' + NL+
          ' declare s         int;  ' + NL+
          ' declare secsinmin int;  ' + NL+
          ' declare secsinhr  int;  ' + NL+
          ' declare hrStr     VARCHAR(30);  ' + NL+
          ' declare minStr    VARCHAR(30);  ' + NL+
          ' declare secstr    VARCHAR(30);   ' + NL+
          ' Declare isnetaive Boolean;  ' + NL+
          '  set isnetaive = False;  ' + NL+
          '  if Seconds<0 then Set isnetaive = True; Set Seconds = abs(Seconds);  end if;  ' + NL+
          ' Set     secsinhr  = 3600;'+
          ' Set     secsinmin = 60;'+
          ' Set     h         = 0;'+
          ' Set     m         = 0;'+
          ' Set     s         = 0;'+
          ' if Seconds =0 then 	RETURN ""; else'+
          ' if Seconds >=secsinhr  then  Set h = truncate(abs(Seconds) /secsinhr  ,0);  set Seconds  := Seconds    -(h*secsinhr);  end if;' + NL+
          ' if Seconds >=secsinmin then  Set m = truncate(abs(seconds) /secsinmin ,0);  set Seconds  := Seconds    -(m*secsinmin); end if;' + NL+
          ' Set s = seconds ;  ' + NL+
          ' if h =0 then Set hrStr ="00" ; elseif h < 10 then Set hrStr = concat("0",h) ; else Set hrStr = h ; end if;  ' + NL+
          ' if m =0 then  Set minStr ="00" ; elseif m < 10 then set minStr = concat("0",m) ; else Set minStr = m ; end if;  ' + NL+
          ' if s =0 then  Set SecStr ="00" ; elseif s < 10 then set SecStr = concat("0",s) ; else Set SecStr = s ; end if;   ' + NL+
          ' if isnetaive then  	RETURN concat("- " , hrStr ,":" ,minStr ,":" ,SecStr);    else  RETURN concat(hrStr ,":" ,minStr ,":" ,SecStr);    end if;   ' + NL+
          ' end if;'+
          ' END;// ' + NL+
          ' delimiter ;';
end;

function SPGetSequenceNumberSQL:String;
begin
    Result:= 'DROP FUNCTION IF EXISTS `GetSequenceNumber`; ' + NL+
          ' delimiter //' + NL+
              ' CREATE FUNCTION  `GetSequenceNumber`(sSeqName VARCHAR(255), iThreadid BIGINT , iDefaultSeqValue BIGINT)  ' + NL+
                        ' RETURNS BIGINT' + NL+
              ' BEGIN' + NL+
              ' DECLARE aResult BIGINT;' + NL+
              ' Set aResult=0;' + NL+
              ' if iDefaultSeqValue =0 then Set iDefaultSeqValue=1; end if;' + NL+
              ' WHILE aResult=0 do' + NL+
              '   INSERT INTO tblSeqNumbers (SeqName , SeqValue , Threadid) VALUES (sSeqName , iDefaultSeqValue , iThreadid )  ' +NL+
                        ' ON DUPLICATE KEY UPDATE SeqValue = if(ifnull(SeqValue,0)+1<iDefaultSeqValue , iDefaultSeqValue ,ifnull(SeqValue,0)+1) , Threadid=iThreadid;' + NL+
              '   SELECT convert(ifnull(SeqValue,0),Unsigned) into aResult  ' +
                        ' From tblSeqNumbers  ' +
                        ' where SeqName =sSeqName   and Threadid = iThreadid;' + NL+
              ' end while;' + NL+
              '   RETURN aResult;' + NL+
              ' END//' + NL+
              ' delimiter ;';
end;

function SPSetSequenceNumberSQL:String;
begin
    Result:= 'DROP PROCEDURE IF EXISTS `SetSequenceNumber`; ' + NL+
          ' delimiter //' + NL+
              ' CREATE PROCEDURE `SetSequenceNumber`(sSeqName VARCHAR(50), Value int)  ' + NL+
              ' BEGIN ' + NL+
              ' if value = 0 then set value =1; end if; ' + NL+
              ' INSERT INTO tblSeqNumbers (SeqName , SeqValue )  VALUES (sSeqName , Value )   ON DUPLICATE KEY UPDATE   SeqValue = Value; ' + NL+
              ' END//' + NL+
              ' delimiter ;';
end;

function SPAmountToWordsSQL: string;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.Add('DROP FUNCTION IF EXISTS AmountToWords ;                          ');
    sl.Add('DROP FUNCTION IF EXISTS number_part_to_string;                   ');
    sl.Add('DELIMITER //                                                     ');
    sl.Add('CREATE FUNCTION `number_part_to_string`(n int) RETURNS VARCHAR(1000)');
    sl.Add('BEGIN                                                            ');
    sl.Add('    declare ans VARCHAR(1000);                                   ');
    sl.Add('    declare nStr VARCHAR(3);                                     ');
    sl.Add('	 declare val int;                                              ');
    sl.Add('	 set nStr = RIGHT(CONCAT("00", CAST(n as CHAR(3))),3);         ');
    sl.Add('	 set ans = "";                                                 ');

    sl.Add('	 set val = CAST(RIGHT(nStr,2) as UNSIGNED);                    ');
    sl.Add('	 if val > 19 then                                              ');
    sl.Add('	   set val = CAST(RIGHT(nStr,1) as UNSIGNED);                  ');
    sl.Add('	 end if;                                                       ');
    sl.Add('	 case val                                                      ');
    sl.Add('	     when 0 then set ans = "";                                 ');
    sl.Add('	     when 1 then set ans = "One";                              ');
    sl.Add('	     when 2 then set ans = "Two";                              ');
    sl.Add('	     when 3 then set ans = "Three";                            ');
    sl.Add('	     when 4 then set ans = "Four";                             ');
    sl.Add('	     when 5 then set ans = "Five";                             ');
    sl.Add('	     when 6 then set ans = "Six";                              ');
    sl.Add('	     when 7 then set ans = "Seven";                            ');
    sl.Add('	     when 8 then set ans = "Eight";                            ');
    sl.Add('	     when 9 then set ans = "Nine";                             ');
    sl.Add('	     when 10 then set ans = "Ten";                             ');
    sl.Add('	     when 11 then set ans = "Eleven";                          ');
    sl.Add('	     when 12 then set ans = "Twelve";                          ');
    sl.Add('	     when 13 then set ans = "Thirteen";                        ');
    sl.Add('	     when 14 then set ans = "Fourteen";                        ');
    sl.Add('	     when 15 then set ans = "Fifteen";                         ');
    sl.Add('	     when 16 then set ans = "Sixteen";                         ');
    sl.Add('	     when 17 then set ans = "Seventeen";                       ');
    sl.Add('	     when 18 then set ans = "Eighteen";                        ');
    sl.Add('	     when 19 then set ans = "Nineteen";                        ');
    sl.Add('	     else set ans = "";                                        ');
    sl.Add('	 end case;                                                     ');
    sl.Add('	 if n > 19 then                                                ');
    sl.Add('        set val = CAST(SUBSTR(nStr,-2,1) as UNSIGNED);           ');
    sl.Add('	     case val                                                  ');
    sl.Add('	         when 2 then set ans = CONCAT("Twenty", " ", ans);     ');
    sl.Add('	         when 3 then set ans = CONCAT("Thirty", " ", ans);     ');
    sl.Add('	         when 4 then set ans = CONCAT("Forty", " ", ans);      ');
    sl.Add('	         when 5 then set ans = CONCAT("Fifty", " ", ans);      ');
    sl.Add('	         when 6 then set ans = CONCAT("Sixty", " ", ans);      ');
    sl.Add('	         when 7 then set ans = CONCAT("Seventy", " ", ans);    ');
    sl.Add('	         when 8 then set ans = CONCAT("Eighty", " ", ans);     ');
    sl.Add('	         when 9 then set ans = CONCAT("Ninety", " ", ans);     ');
    sl.Add('	         else set ans = CONCAT("", "", ans);                   ');
    sl.Add('		  end case;                                                  ');
    sl.Add('		  if n >= 100 then                                           ');
    sl.Add('		      set val = CAST(SUBSTR(nStr,-3,1) as UNSIGNED);         ');
    sl.Add('		      case val                                               ');
    sl.Add('		          when 1 then set ans = CONCAT("One Hundred", " ", ans);     ');
    sl.Add('		          when 2 then set ans = CONCAT("Two Hundred", " ", ans);     ');
    sl.Add('		          when 3 then set ans = CONCAT("Three Hundred", " ", ans);   ');
    sl.Add('		          when 4 then set ans = CONCAT("Four Hundred", " ", ans);    ');
    sl.Add('		          when 5 then set ans = CONCAT("Five Hundred", " ", ans);    ');
    sl.Add('		          when 6 then set ans = CONCAT("Six Hundred", " ", ans);     ');
    sl.Add('		          when 7 then set ans = CONCAT("Seven Hundred", " ", ans);   ');
    sl.Add('		          when 8 then set ans = CONCAT("Eight Hundred", " ", ans);   ');
    sl.Add('		          when 9 then set ans = CONCAT("Nine Hundred", " ", ans);    ');
    sl.Add('		          else set ans = CONCAT("", "", ans);                ');
    sl.Add('		      end case;                                              ');
    sl.Add('		  end if;                                                    ');
    sl.Add('	 end if;                                                       ');

    sl.Add('    return trim(ans);                                            ');
    sl.Add('END//                                                            ');
    sl.Add('DELIMITER ;                                                      ');

    sl.Add('DROP FUNCTION IF EXISTS AmountToWords ;                          ');
    sl.Add('DELIMITER //                                                     ');
    sl.Add('CREATE FUNCTION AmountToWords(n double) RETURNS VARCHAR(1000)    ');
    sl.Add('BEGIN                                                            ');
    sl.Add('    declare ans, dollars, part VARCHAR(1000);                    ');
    sl.Add('    declare cents int;                                           ');
    sl.Add('    declare intPart int;                                         ');
    sl.Add('    declare CentsName, DollarName VARCHAR(20);                   ');
    sl.Add('    set dollars = CAST(TRUNCATE(abs(n),0) AS CHAR(1000));             ');
    sl.Add('    set dollars = CONCAT("00",dollars);                          ');
    sl.Add('    set cents = (ROUND(abs(n),2) - CAST(dollars as UNSIGNED)) * 100;  ');
    sl.Add('	 set ans = "";                                                 ');
    sl.Add('	 set DollarName = (select WholeCurrencyName from tblregionaloptions, tbldbpreferences where tbldbpreferences.Name = "CompanyRegion" and tblregionaloptions.Region = tbldbpreferences.FieldValue); ');

    sl.Add('    if (abs(n) >= 1000000000000) then                                 ');
    sl.Add('        set part = SUBSTR(dollars,-15,3);                        ');
    sl.Add('        set part = number_part_to_string(CAST(part as UNSIGNED));');
    sl.Add('		  if (part <> "") then                                       ');
    sl.Add('            set ans = CONCAT_WS(" ",ans,part,"Trillion");        ');
    sl.Add('        end if;                                                  ');
    sl.Add('    end if;                                                      ');
    sl.Add('    if (abs(n) >= 1000000000) then                                    ');
    sl.Add('        set part = SUBSTR(dollars,-12,3);                        ');
    sl.Add('        set part = number_part_to_string(CAST(part as UNSIGNED));');
    sl.Add('		  if (part <> "") then                                       ');
    sl.Add('            set ans = CONCAT_WS(" ",ans,part,"Billion");         ');
    sl.Add('        end if;                                                  ');
    sl.Add('    end if;                                                      ');
    sl.Add('    if (abs(n) >= 1000000) then                                       ');
    sl.Add('        set part = SUBSTR(dollars,-9,3);                         ');
    sl.Add('        set part = number_part_to_string(CAST(part as UNSIGNED));');
    sl.Add('		  if (part <> "") then                                       ');
    sl.Add('            set ans = CONCAT_WS(" ",ans,part,"Million");         ');
    sl.Add('        end if;                                                  ');
    sl.Add('    end if;                                                      ');
    sl.Add('    if (abs(n) >= 1000) then                                          ');
    sl.Add('        set part = SUBSTR(dollars,-6,3);                         ');
    sl.Add('        set part = number_part_to_string(CAST(part as UNSIGNED));');
    sl.Add('		  if (part <> "") then                                       ');
    sl.Add('            set ans = CONCAT_WS(" ",ans,part,"Thousand");        ');
    sl.Add('        end if;                                                  ');
    sl.Add('    end if;                                                      ');

    sl.Add('	 set part = SUBSTR(dollars,-3,3);                              ');
    sl.Add('    set part = number_part_to_string(CAST(part as UNSIGNED));    ');
    sl.Add('    if (part <> "") then                                         ');
    sl.Add('        set ans = CONCAT_WS(" ",ans,part,"");                    ');
    sl.Add('    end if;                                                      ');

    sl.Add('    set ans = CONCAT_WS(" ",Trim(ans),DollarName);               ');

    sl.Add('    set part = number_part_to_string(cents);                     ');
    sl.Add('    if (part <> "") then                                         ');
    sl.Add('        set CentsName = (select DecimalCurrencyName from tblregionaloptions, tbldbpreferences where tbldbpreferences.Name = "CompanyRegion" and tblregionaloptions.Region = tbldbpreferences.FieldValue); ');
    sl.Add('        set ans = CONCAT_WS(" ",Trim(ans),"and",part,CentsName); ');
    sl.Add('    end if;                                                      ');
    sl.Add('    if n <0 then Set ans = concat("- " , ans);    		end if;');
    sl.Add('    return trim(ans);                                            ');
    sl.Add('END//                                                            ');
    sl.Add('DELIMITER ;                                                      ');

    result := sl.text;
  finally
    sl.Free;
  end;
end;

function SPERPTimeToTime: string;
begin
  Result := ' DROP FUNCTION IF EXISTS ERPTimeToTime ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `ERPTimeToTime`(`ERPTime` VARCHAR(50))' + NL+
              ' 	RETURNS TIME' + NL+
              ' BEGIN' + NL+
              '     if ERPTime = "00:00 AM"	then return Time("00:00:00");' + NL+
              ' elseif ERPTime = "00:30 AM"	then return Time("00:30:00");' + NL+
              ' elseif ERPTime = "01:00 AM"	then return Time("01:00:00");' + NL+
              ' elseif ERPTime = "01:30 AM"	then return Time("01:30:00");' + NL+
              ' elseif ERPTime = "02:00 AM"	then return Time("02:00:00");' + NL+
              ' elseif ERPTime = "02:30 AM"	then return Time("02:30:00");' + NL+
              ' elseif ERPTime = "03:00 AM"	then return Time("03:00:00");' + NL+
              ' elseif ERPTime = "03:30 AM"	then return Time("03:30:00");' + NL+
              ' elseif ERPTime = "04:00 AM"	then return Time("04:00:00");' + NL+
              ' elseif ERPTime = "04:30 AM"	then return Time("04:30:00");' + NL+
              ' elseif ERPTime = "05:00 AM"	then return Time("05:00:00");' + NL+
              ' elseif ERPTime = "05:30 AM"	then return Time("05:30:00");' + NL+
              ' elseif ERPTime = "06:00 AM"	then return Time("06:00:00");' + NL+
              ' elseif ERPTime = "06:30 AM"	then return Time("06:30:00");' + NL+
              ' elseif ERPTime = "07:00 AM"	then return Time("07:00:00");' + NL+
              ' elseif ERPTime = "07:30 AM"	then return Time("07:30:00");' + NL+
              ' elseif ERPTime = "08:00 AM"	then return Time("08:00:00");' + NL+
              ' elseif ERPTime = "08:30 AM"	then return Time("08:30:00");' + NL+
              ' elseif ERPTime = "09:00 AM"	then return Time("09:00:00");' + NL+
              ' elseif ERPTime = "09:30 AM"	then return Time("09:30:00");' + NL+
              ' elseif ERPTime = "10:00 AM"	then return Time("10:00:00");' + NL+
              ' elseif ERPTime = "10:30 AM"	then return Time("10:30:00");' + NL+
              ' elseif ERPTime = "11:00 AM"	then return Time("11:00:00");' + NL+
              ' elseif ERPTime = "11:30 AM"	then return Time("11:30:00");' + NL+
              ' elseif ERPTime = "12:00 PM"	then return Time("12:00:00");' + NL+
              ' elseif ERPTime = "12:30 PM"	then return Time("12:30:00");' + NL+
              ' elseif ERPTime = "01:00 PM"	then return Time("13:00:00");' + NL+
              ' elseif ERPTime = "01:30 PM"	then return Time("13:30:00");' + NL+
              ' elseif ERPTime = "02:00 PM"	then return Time("14:00:00");' + NL+
              ' elseif ERPTime = "02:30 PM"	then return Time("14:30:00");' + NL+
              ' elseif ERPTime = "03:00 PM"	then return Time("15:00:00");' + NL+
              ' elseif ERPTime = "03:30 PM"	then return Time("15:30:00");' + NL+
              ' elseif ERPTime = "04:00 PM"	then return Time("16:00:00");' + NL+
              ' elseif ERPTime = "04:30 PM"	then return Time("16:30:00");' + NL+
              ' elseif ERPTime = "05:00 PM"	then return Time("17:00:00");' + NL+
              ' elseif ERPTime = "05:30 PM"	then return Time("17:30:00");' + NL+
              ' elseif ERPTime = "06:00 PM"	then return Time("18:00:00");' + NL+
              ' elseif ERPTime = "06:30 PM"	then return Time("18:30:00");' + NL+
              ' elseif ERPTime = "07:00 PM"	then return Time("19:00:00");' + NL+
              ' elseif ERPTime = "07:30 PM"	then return Time("19:30:00");' + NL+
              ' elseif ERPTime = "08:00 PM"	then return Time("20:00:00");' + NL+
              ' elseif ERPTime = "08:30 PM"	then return Time("20:30:00");' + NL+
              ' elseif ERPTime = "09:00 PM"	then return Time("21:00:00");' + NL+
              ' elseif ERPTime = "09:30 PM"	then return Time("21:30:00");' + NL+
              ' elseif ERPTime = "10:00 PM"	then return Time("22:00:00");' + NL+
              ' elseif ERPTime = "10:30 PM"	then return Time("22:30:00");' + NL+
              ' elseif ERPTime = "11:00 PM"	then return Time("23:00:00");' + NL+
              ' elseif ERPTime = "11:30 PM"	then return Time("23:30:00");' + NL+
              ' elseif ERPTime = "12:00 AM"	then return Time("00:00:00");' + NL+
              ' elseif ERPTime = "12:30 AM"	then return Time("00:30:00");' + NL+

              ' elseif ERPTime = "00:00:00 AM"	then return Time("00:00:00");' + NL+
              ' elseif ERPTime = "00:30:00 AM"	then return Time("00:30:00");' + NL+
              ' elseif ERPTime = "01:00:00 AM"	then return Time("01:00:00");' + NL+
              ' elseif ERPTime = "01:30:00 AM"	then return Time("01:30:00");' + NL+
              ' elseif ERPTime = "02:00:00 AM"	then return Time("02:00:00");' + NL+
              ' elseif ERPTime = "02:30:00 AM"	then return Time("02:30:00");' + NL+
              ' elseif ERPTime = "03:00:00 AM"	then return Time("03:00:00");' + NL+
              ' elseif ERPTime = "03:30:00 AM"	then return Time("03:30:00");' + NL+
              ' elseif ERPTime = "04:00:00 AM"	then return Time("04:00:00");' + NL+
              ' elseif ERPTime = "04:30:00 AM"	then return Time("04:30:00");' + NL+
              ' elseif ERPTime = "05:00:00 AM"	then return Time("05:00:00");' + NL+
              ' elseif ERPTime = "05:30:00 AM"	then return Time("05:30:00");' + NL+
              ' elseif ERPTime = "06:00:00 AM"	then return Time("06:00:00");' + NL+
              ' elseif ERPTime = "06:30:00 AM"	then return Time("06:30:00");' + NL+
              ' elseif ERPTime = "07:00:00 AM"	then return Time("07:00:00");' + NL+
              ' elseif ERPTime = "07:30:00 AM"	then return Time("07:30:00");' + NL+
              ' elseif ERPTime = "08:00:00 AM"	then return Time("08:00:00");' + NL+
              ' elseif ERPTime = "08:30:00 AM"	then return Time("08:30:00");' + NL+
              ' elseif ERPTime = "09:00:00 AM"	then return Time("09:00:00");' + NL+
              ' elseif ERPTime = "09:30:00 AM"	then return Time("09:30:00");' + NL+
              ' elseif ERPTime = "10:00:00 AM"	then return Time("10:00:00");' + NL+
              ' elseif ERPTime = "10:30:00 AM"	then return Time("10:30:00");' + NL+
              ' elseif ERPTime = "11:00:00 AM"	then return Time("11:00:00");' + NL+
              ' elseif ERPTime = "11:30:00 AM"	then return Time("11:30:00");' + NL+
              ' elseif ERPTime = "12:00:00 PM"	then return Time("12:00:00");' + NL+
              ' elseif ERPTime = "12:30:00 PM"	then return Time("12:30:00");' + NL+
              ' elseif ERPTime = "01:00:00 PM"	then return Time("13:00:00");' + NL+
              ' elseif ERPTime = "01:30:00 PM"	then return Time("13:30:00");' + NL+
              ' elseif ERPTime = "02:00:00 PM"	then return Time("14:00:00");' + NL+
              ' elseif ERPTime = "02:30:00 PM"	then return Time("14:30:00");' + NL+
              ' elseif ERPTime = "03:00:00 PM"	then return Time("15:00:00");' + NL+
              ' elseif ERPTime = "03:30:00 PM"	then return Time("15:30:00");' + NL+
              ' elseif ERPTime = "04:00:00 PM"	then return Time("16:00:00");' + NL+
              ' elseif ERPTime = "04:30:00 PM"	then return Time("16:30:00");' + NL+
              ' elseif ERPTime = "05:00:00 PM"	then return Time("17:00:00");' + NL+
              ' elseif ERPTime = "05:30:00 PM"	then return Time("17:30:00");' + NL+
              ' elseif ERPTime = "06:00:00 PM"	then return Time("18:00:00");' + NL+
              ' elseif ERPTime = "06:30:00 PM"	then return Time("18:30:00");' + NL+
              ' elseif ERPTime = "07:00:00 PM"	then return Time("19:00:00");' + NL+
              ' elseif ERPTime = "07:30:00 PM"	then return Time("19:30:00");' + NL+
              ' elseif ERPTime = "08:00:00 PM"	then return Time("20:00:00");' + NL+
              ' elseif ERPTime = "08:30:00 PM"	then return Time("20:30:00");' + NL+
              ' elseif ERPTime = "09:00:00 PM"	then return Time("21:00:00");' + NL+
              ' elseif ERPTime = "09:30:00 PM"	then return Time("21:30:00");' + NL+
              ' elseif ERPTime = "10:00:00 PM"	then return Time("22:00:00");' + NL+
              ' elseif ERPTime = "10:30:00 PM"	then return Time("22:30:00");' + NL+
              ' elseif ERPTime = "11:00:00 PM"	then return Time("23:00:00");' + NL+
              ' elseif ERPTime = "11:30:00 PM"	then return Time("23:30:00");' + NL+
              ' elseif ERPTime = "12:00:00 AM"	then return Time("00:00:00");' + NL+
              ' elseif ERPTime = "12:30:00 AM"	then return Time("00:30:00");' + NL+

              ' elseif ERPTime = "00:00"	then return Time("00:00:00");' + NL+
              ' elseif ERPTime = "00:30"	then return Time("00:30:00");' + NL+
              ' elseif ERPTime = "01:00"	then return Time("01:00:00");' + NL+
              ' elseif ERPTime = "01:30"	then return Time("01:30:00");' + NL+
              ' elseif ERPTime = "02:00"	then return Time("02:00:00");' + NL+
              ' elseif ERPTime = "02:30"	then return Time("02:30:00");' + NL+
              ' elseif ERPTime = "03:00"	then return Time("03:00:00");' + NL+
              ' elseif ERPTime = "03:30"	then return Time("03:30:00");' + NL+
              ' elseif ERPTime = "04:00"	then return Time("04:00:00");' + NL+
              ' elseif ERPTime = "04:30"	then return Time("04:30:00");' + NL+
              ' elseif ERPTime = "05:00"	then return Time("05:00:00");' + NL+
              ' elseif ERPTime = "05:30"	then return Time("05:30:00");' + NL+
              ' elseif ERPTime = "06:00"	then return Time("06:00:00");' + NL+
              ' elseif ERPTime = "06:30"	then return Time("06:30:00");' + NL+
              ' elseif ERPTime = "07:00"	then return Time("07:00:00");' + NL+
              ' elseif ERPTime = "07:30"	then return Time("07:30:00");' + NL+
              ' elseif ERPTime = "08:00"	then return Time("08:00:00");' + NL+
              ' elseif ERPTime = "08:30"	then return Time("08:30:00");' + NL+
              ' elseif ERPTime = "09:00"	then return Time("09:00:00");' + NL+
              ' elseif ERPTime = "09:30"	then return Time("09:30:00");' + NL+
              ' elseif ERPTime = "10:00"	then return Time("10:00:00");' + NL+
              ' elseif ERPTime = "10:30"	then return Time("10:30:00");' + NL+
              ' elseif ERPTime = "11:00"	then return Time("11:00:00");' + NL+
              ' elseif ERPTime = "11:30"	then return Time("11:30:00");' + NL+
              ' elseif ERPTime = "12:00"	then return Time("12:00:00");' + NL+
              ' elseif ERPTime = "12:30"	then return Time("12:30:00");' + NL+
              ' elseif ERPTime = "13:00"	then return Time("13:00:00");' + NL+
              ' elseif ERPTime = "13:30"	then return Time("13:30:00");' + NL+
              ' elseif ERPTime = "14:00"	then return Time("14:00:00");' + NL+
              ' elseif ERPTime = "14:30"	then return Time("14:30:00");' + NL+
              ' elseif ERPTime = "15:00"	then return Time("15:00:00");' + NL+
              ' elseif ERPTime = "15:30"	then return Time("15:30:00");' + NL+
              ' elseif ERPTime = "16:00"	then return Time("16:00:00");' + NL+
              ' elseif ERPTime = "16:30"	then return Time("16:30:00");' + NL+
              ' elseif ERPTime = "17:00"	then return Time("17:00:00");' + NL+
              ' elseif ERPTime = "17:30"	then return Time("17:30:00");' + NL+
              ' elseif ERPTime = "18:00"	then return Time("18:00:00");' + NL+
              ' elseif ERPTime = "18:30"	then return Time("18:30:00");' + NL+
              ' elseif ERPTime = "19:00"	then return Time("19:00:00");' + NL+
              ' elseif ERPTime = "19:30"	then return Time("19:30:00");' + NL+
              ' elseif ERPTime = "20:00"	then return Time("20:00:00");' + NL+
              ' elseif ERPTime = "20:30"	then return Time("20:30:00");' + NL+
              ' elseif ERPTime = "21:00"	then return Time("21:00:00");' + NL+
              ' elseif ERPTime = "21:30"	then return Time("21:30:00");' + NL+
              ' elseif ERPTime = "22:00"	then return Time("22:00:00");' + NL+
              ' elseif ERPTime = "22:30"	then return Time("22:30:00");' + NL+
              ' elseif ERPTime = "23:00"	then return Time("23:00:00");' + NL+
              ' elseif ERPTime = "23:30"	then return Time("23:30:00");' + NL+
              ' elseif ERPTime = "24:00"	then return Time("00:00:00");' + NL+
              ' elseif ERPTime = "24:30"	then return Time("00:30:00");' + NL+


              ' elseif ERPTime = "00:00:00"	then return Time("00:00:00");' + NL+
              ' elseif ERPTime = "00:30:00"	then return Time("00:30:00");' + NL+
              ' elseif ERPTime = "01:00:00"	then return Time("01:00:00");' + NL+
              ' elseif ERPTime = "01:30:00"	then return Time("01:30:00");' + NL+
              ' elseif ERPTime = "02:00:00"	then return Time("02:00:00");' + NL+
              ' elseif ERPTime = "02:30:00"	then return Time("02:30:00");' + NL+
              ' elseif ERPTime = "03:00:00"	then return Time("03:00:00");' + NL+
              ' elseif ERPTime = "03:30:00"	then return Time("03:30:00");' + NL+
              ' elseif ERPTime = "04:00:00"	then return Time("04:00:00");' + NL+
              ' elseif ERPTime = "04:30:00"	then return Time("04:30:00");' + NL+
              ' elseif ERPTime = "05:00:00"	then return Time("05:00:00");' + NL+
              ' elseif ERPTime = "05:30:00"	then return Time("05:30:00");' + NL+
              ' elseif ERPTime = "06:00:00"	then return Time("06:00:00");' + NL+
              ' elseif ERPTime = "06:30:00"	then return Time("06:30:00");' + NL+
              ' elseif ERPTime = "07:00:00"	then return Time("07:00:00");' + NL+
              ' elseif ERPTime = "07:30:00"	then return Time("07:30:00");' + NL+
              ' elseif ERPTime = "08:00:00"	then return Time("08:00:00");' + NL+
              ' elseif ERPTime = "08:30:00"	then return Time("08:30:00");' + NL+
              ' elseif ERPTime = "09:00:00"	then return Time("09:00:00");' + NL+
              ' elseif ERPTime = "09:30:00"	then return Time("09:30:00");' + NL+
              ' elseif ERPTime = "10:00:00"	then return Time("10:00:00");' + NL+
              ' elseif ERPTime = "10:30:00"	then return Time("10:30:00");' + NL+
              ' elseif ERPTime = "11:00:00"	then return Time("11:00:00");' + NL+
              ' elseif ERPTime = "11:30:00"	then return Time("11:30:00");' + NL+
              ' elseif ERPTime = "12:00:00"	then return Time("12:00:00");' + NL+
              ' elseif ERPTime = "12:30:00"	then return Time("12:30:00");' + NL+
              ' elseif ERPTime = "13:00:00"	then return Time("13:00:00");' + NL+
              ' elseif ERPTime = "13:30:00"	then return Time("13:30:00");' + NL+
              ' elseif ERPTime = "14:00:00"	then return Time("14:00:00");' + NL+
              ' elseif ERPTime = "14:30:00"	then return Time("14:30:00");' + NL+
              ' elseif ERPTime = "15:00:00"	then return Time("15:00:00");' + NL+
              ' elseif ERPTime = "15:30:00"	then return Time("15:30:00");' + NL+
              ' elseif ERPTime = "16:00:00"	then return Time("16:00:00");' + NL+
              ' elseif ERPTime = "16:30:00"	then return Time("16:30:00");' + NL+
              ' elseif ERPTime = "17:00:00"	then return Time("17:00:00");' + NL+
              ' elseif ERPTime = "17:30:00"	then return Time("17:30:00");' + NL+
              ' elseif ERPTime = "18:00:00"	then return Time("18:00:00");' + NL+
              ' elseif ERPTime = "18:30:00"	then return Time("18:30:00");' + NL+
              ' elseif ERPTime = "19:00:00"	then return Time("19:00:00");' + NL+
              ' elseif ERPTime = "19:30:00"	then return Time("19:30:00");' + NL+
              ' elseif ERPTime = "20:00:00"	then return Time("20:00:00");' + NL+
              ' elseif ERPTime = "20:30:00"	then return Time("20:30:00");' + NL+
              ' elseif ERPTime = "21:00:00"	then return Time("21:00:00");' + NL+
              ' elseif ERPTime = "21:30:00"	then return Time("21:30:00");' + NL+
              ' elseif ERPTime = "22:00:00"	then return Time("22:00:00");' + NL+
              ' elseif ERPTime = "22:30:00"	then return Time("22:30:00");' + NL+
              ' elseif ERPTime = "23:00:00"	then return Time("23:00:00");' + NL+
              ' elseif ERPTime = "23:30:00"	then return Time("23:30:00");' + NL+
              ' elseif ERPTime = "24:00:00"	then return Time("00:00:00");' + NL+
              ' elseif ERPTime = "24:30:00"	then return Time("00:30:00");' + NL+

              ' else return Time("00:00:00");' + NL+
              ' end if;' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;
function SPSecondsBetween: string;
begin
  Result := ' DROP FUNCTION IF EXISTS SecondsBetween ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `SecondsBetween`(`TimeFrom` DATETIME, `TimeTo` DATETIME) ' + NL+
              ' 	RETURNS INT ' + NL+
              ' BEGIN' + NL+
              ' return  '+
                        ' DATEdiff(if(ifnull(TimeTo,0)=0 ,CURRENT_TIMESTAMP , TimeTo), TimeFrom)*60*60 + '+
                        ' timediff(if(ifnull(TimeTo,0)=0 ,CURRENT_TIMESTAMP , TimeTo), DATE_ADD( TimeFrom,INTERVAL DATEdiff(if(ifnull(TimeTo,0)=0 ,CURRENT_TIMESTAMP , TimeTo), TimeFrom) dAY) ); '+NL+
              //' return  TIME_TO_SEC(TimeTo) - TIME_TO_SEC(TimeFrom); '+NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;
function SPEndOfTheDay: string;
begin
  Result := ' DROP FUNCTION IF EXISTS EndOfTheDay ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `EndOfTheDay`(`DateValue` DATE) ' + NL+
              ' 	RETURNS DATETIME  ' + NL+
              ' BEGIN' + NL+
              ' return  Date_add(Date_add(DATE(DateValue), INTERVAL 1 day) , INTERVAL -1 SECond); '+NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;

function SPSimpleTypetoDesc: string;
begin
  Result := ' DROP FUNCTION IF EXISTS SimpleTypetoDesc ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `SimpleTypetoDesc`(TypeCode VARCHAR(255)) ' + NL+
              ' 	RETURNS VARCHAR(255)  ' + NL+
              ' BEGIN' + NL+
              '      if typecode = ' +quotedstr(SimpleTypes_CompanyType                   )+' then return '+Quotedstr(SimpleTypes_CompanyType_DESC                 )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_FollowUpType                  )+' then return '+Quotedstr(SimpleTypes_FollowUpType_DESC                )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_FollowUpResultType            )+' then return '+Quotedstr(SimpleTypes_FollowUpResultType_DESC          )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_StatusType                    )+' then return '+Quotedstr(SimpleTypes_StatusType_DESC                  )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_LeadStatusType                )+' then return '+Quotedstr(SimpleTypes_LeadStatusType_DESC              )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_PhSupportStatusType           )+' then return '+Quotedstr(SimpleTypes_PhSupportStatusType_DESC         )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_CustomerReturnStatus          )+' then return '+Quotedstr(SimpleTypes_CustomerReturnStatus_DESC        )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_ShippingContainerStatusType   )+' then return '+Quotedstr(SimpleTypes_ShippingContainerStatusType_DESC )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_AppointmentStatusType         )+' then return '+Quotedstr(SimpleTypes_AppointmentStatusType_DESC       )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_AppointmentCancellationType   )+' then return '+Quotedstr(SimpleTypes_AppointmentCancellationType_DESC )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_SalesCategory                 )+' then return '+Quotedstr(SimpleTypes_SalesCategory_DESC               )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_SalesDelDelayReason           )+' then return '+Quotedstr(SimpleTypes_SalesDelDelayReason_DESC         )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_PhoneSupportType              )+' then return '+Quotedstr(SimpleTypes_PhoneSupportType_DESC            )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_PhoneSupportVersion           )+' then return '+Quotedstr(SimpleTypes_PhoneSupportVersion_DESC         )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_RepairFault                   )+' then return '+Quotedstr(SimpleTypes_RepairFault_DESC                 )+';'+
              '  elseif typecode = ' +quotedstr(simpletypes_CAR_Actiontype                )+' then return '+Quotedstr(simpletypes_CAR_Actiontype_DESC              )+';'+
              '  elseif typecode = ' +quotedstr(simpletypes_CAR_Productionbuild           )+' then return '+Quotedstr(simpletypes_CAR_Productionbuild_DESC         )+';'+
              '  elseif typecode = ' +quotedstr(simpletypes_CAR_ActionRequired            )+' then return '+Quotedstr(simpletypes_CAR_ActionRequired_DESC          )+';'+
              '  elseif typecode = ' +quotedstr(simpletypes_CAR_PreventiveActionComments  )+' then return '+Quotedstr(simpletypes_CAR_PreventiveActionComments_DESC)+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_OrderStatus                   )+' then return '+Quotedstr(SimpleTypes_OrderStatus_DESC                 )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_ReturnAuthority               )+' then return '+Quotedstr(SimpleTypes_ReturnAuthority_DESC             )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_Credit                        )+' then return '+Quotedstr(SimpleTypes_Credit_DESC                      )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_Bill                          )+' then return '+Quotedstr(SimpleTypes_Bill_DESC                        )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_cheque                        )+' then return '+Quotedstr(SimpleTypes_cheque_DESC                      )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_RosterBreaks                  )+' then return '+Quotedstr(SimpleTypes_RosterBreaks_DESC                )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_LeadActionType                )+' then return '+Quotedstr(SimpleTypes_LeadActionType_DESC              )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_BOM_WastageReason             )+' then return '+Quotedstr(SimpleTypes_BOM_WastageReason_DESC           )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_ProcresourceColour            )+' then return '+Quotedstr(SimpleTypes_ProcresourceColour_DESC          )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_EmployeeSkillLevel            )+' then return '+Quotedstr(SimpleTypes_EmployeeSkillLevel_DESC          )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_MessageType                   )+' then return '+Quotedstr(SimpleTypes_MessageType_DESC                 )+';'+
              {change the TSimpleTypesGUI when adding new types}
              '  else return "" ;' + NL+
              ' end if;' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;

function SPSimpleTypeDesctocode: string;
begin
  Result := ' DROP FUNCTION IF EXISTS SimpleTypeDesctocode ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `SimpleTypeDesctocode`(TypeCode VARCHAR(255)) ' + NL+
              ' 	RETURNS VARCHAR(255)  ' + NL+
              ' BEGIN' + NL+
              '      if typecode = ' +quotedstr(SimpleTypes_CompanyType_DESC                   )+' then return '+Quotedstr(SimpleTypes_CompanyType                 )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_FollowUpType_DESC                  )+' then return '+Quotedstr(SimpleTypes_FollowUpType                )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_FollowUpResultType_DESC            )+' then return '+Quotedstr(SimpleTypes_FollowUpResultType          )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_StatusType_DESC                    )+' then return '+Quotedstr(SimpleTypes_StatusType                  )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_LeadStatusType_DESC                )+' then return '+Quotedstr(SimpleTypes_LeadStatusType              )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_PhSupportStatusType_DESC           )+' then return '+Quotedstr(SimpleTypes_PhSupportStatusType         )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_CustomerReturnStatus_DESC          )+' then return '+Quotedstr(SimpleTypes_CustomerReturnStatus        )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_ShippingContainerStatusType_DESC   )+' then return '+Quotedstr(SimpleTypes_ShippingContainerStatusType )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_AppointmentStatusType_DESC         )+' then return '+Quotedstr(SimpleTypes_AppointmentStatusType       )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_AppointmentCancellationType_DESC   )+' then return '+Quotedstr(SimpleTypes_AppointmentCancellationType )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_SalesCategory_DESC                 )+' then return '+Quotedstr(SimpleTypes_SalesCategory               )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_SalesDelDelayReason_DESC           )+' then return '+Quotedstr(SimpleTypes_SalesDelDelayReason         )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_PhoneSupportType_DESC              )+' then return '+Quotedstr(SimpleTypes_PhoneSupportType            )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_PhoneSupportVersion_DESC           )+' then return '+Quotedstr(SimpleTypes_PhoneSupportVersion         )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_RepairFault_DESC                   )+' then return '+Quotedstr(SimpleTypes_RepairFault                 )+';'+
              '  elseif typecode = ' +quotedstr(simpletypes_CAR_Actiontype_DESC                )+' then return '+Quotedstr(simpletypes_CAR_Actiontype              )+';'+
              '  elseif typecode = ' +quotedstr(simpletypes_CAR_Productionbuild_DESC           )+' then return '+Quotedstr(simpletypes_CAR_Productionbuild         )+';'+
              '  elseif typecode = ' +quotedstr(simpletypes_CAR_ActionRequired_DESC            )+' then return '+Quotedstr(simpletypes_CAR_ActionRequired          )+';'+
              '  elseif typecode = ' +quotedstr(simpletypes_CAR_PreventiveActionComments_DESC  )+' then return '+Quotedstr(simpletypes_CAR_PreventiveActionComments)+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_OrderStatus_DESC                   )+' then return '+Quotedstr(SimpleTypes_OrderStatus                 )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_ReturnAuthority_DESC               )+' then return '+Quotedstr(SimpleTypes_ReturnAuthority             )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_Credit_DESC                        )+' then return '+Quotedstr(SimpleTypes_Credit                      )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_Bill_DESC                          )+' then return '+Quotedstr(SimpleTypes_Bill                        )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_cheque_DESC                        )+' then return '+Quotedstr(SimpleTypes_cheque                      )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_RosterBreaks_DESC                  )+' then return '+Quotedstr(SimpleTypes_RosterBreaks                )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_LeadActionType_DESC                )+' then return '+Quotedstr(SimpleTypes_LeadActionType              )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_BOM_WastageReason_DESC             )+' then return '+Quotedstr(SimpleTypes_BOM_WastageReason           )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_ProcresourceColour_DESC            )+' then return '+Quotedstr(SimpleTypes_ProcresourceColour          )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_EmployeeSkillLevel_DESC            )+' then return '+Quotedstr(SimpleTypes_EmployeeSkillLevel          )+';'+
              '  elseif typecode = ' +quotedstr(SimpleTypes_MessageType_DESC                   )+' then return '+Quotedstr(SimpleTypes_MessageType                 )+';'+
              '  else return "" ;' + NL+
              ' end if;' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;

function SPCustomername: string;
begin
  Result := ' DROP FUNCTION IF EXISTS Customername ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `Customername`(company VARCHAR(255)) ' + NL+
              ' 	RETURNS VARCHAR(255)  ' + NL+
              ' BEGIN' + NL+
              '  	Declare sFieldvalue VARCHAR(1);  ' + NL+
              '  	Declare DBPREf cursor  for select Fieldvalue from tbldbpreferences where name = "SuppressJobNamesOnInvoices";  ' + NL+
              '  	Open DBPREf;  ' + NL+
              '  	Fetch DBPREf into sFieldvalue;  ' + NL+
              '  	CLOSE DBPREf;  ' + NL+
              '  	if sFieldvalue ="T" then return Left(SUBSTRING_INDEX(Company,"^",1),255);  ' + NL+
              '  	else return Company; end if;  ' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;
function SPSplitShiptTo: string;
begin
  Result := ' DROP FUNCTION IF EXISTS SplitShiptTo ; ' + NL+
              'DELIMITER //' + NL+
              ' CREATE FUNCTION `SplitShiptTo`( 	`ShipTo` VARCHAR(255), 	`SplitPart` INT ) RETURNS VARCHAR(255) ' + NL+
              ' BEGIN' + NL+
              '  	if SplitPart =1 then Return Left(SUBSTRING_INDEX(Shipto,"\r\n",1),255); ' + NL+
              '  	else Return trim(BOTH "\r\n" FROM Left(substring(Shipto,char_length(substring_index(Shipto,"\r\n",1))+1),255) ) ; end if;' + NL+
              ' END//' + NL+
              ' DELIMITER ; ';
end;

function SPSaleTotalLineIncRelatedExSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS SaleTotalLineIncRelatedEx; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION SaleTotalLineIncRelatedEx(aSaleLineGlobalRef VARCHAR(255) )   ' + NL+
    ' RETURNS DOUBLE   ' + NL+
    ' BEGIN  ' + NL+
        ' DECLARE result DOUBLE; ' +NL +
        ' DECLARE related DOUBLE; ' +NL +
        ' SET result = (select sum(SL1.TotalLineAmount) from tblsaleslines SL1 ' + NL +
        '   where SL1.GlobalRef = aSaleLineGlobalRef and IfNull(SL1.RelatedParentLineRef,"") = "" ' + NL+
        '   and IfNull(SL1.GlobalRef,"") <> ""); ' + NL+
        ' SET related = (select sum(SL.TotalLineAmount) ' + NL+
        '   from tblsaleslines as SL ' + NL+
        '   inner join tblparts p on p.PartsID = SL.ProductID ' + NL+
        '   inner join tblrelatedparts r on r.ProductID = SL.ProductID ' + NL+
        '   where SL.RelatedParentLineRef = aSaleLineGlobalRef ' + NL+
        '   and (p.HideOnPrint = "T" or r.HideRelated = "T")); ' + NL+
        ' RETURN ROUND(result + ifNull(related,0),5); ' + NL+
    ' END; // ' + NL+
    ' DELIMITER ; ';
end;

function SPSaleTotalLineIncRelatedIncSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS SaleTotalLineIncRelatedInc; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION SaleTotalLineIncRelatedInc(aSaleLineGlobalRef VARCHAR(255) )   ' + NL+
    ' RETURNS DOUBLE   ' + NL+
    ' BEGIN  ' + NL+
        ' DECLARE result DOUBLE; ' +NL +
        ' DECLARE related DOUBLE; ' +NL +
        ' SET result = (select sum(SL1.TotalLineAmountInc) from tblsaleslines SL1 ' + NL+
        '   where SL1.GlobalRef = aSaleLineGlobalRef and IfNull(SL1.RelatedParentLineRef,"") = "" ' + NL+
        '   and IfNull(SL1.GlobalRef,"") <> ""); ' + NL+
        ' SET related = (select sum(SL.TotalLineAmountInc) ' + NL+
        '   from tblsaleslines as SL ' + NL+
        '   inner join tblparts p on p.PartsID = SL.ProductID ' + NL+
        '   inner join tblrelatedparts r on r.ProductID = SL.ProductID ' + NL+
        '   where SL.RelatedParentLineRef = aSaleLineGlobalRef ' + NL+
        '   and (p.HideOnPrint = "T" or r.HideRelated = "T")); ' + NL+
        ' RETURN ROUND(result + ifNull(related,0),5); ' + NL+
    ' END; // ' + NL+
    ' DELIMITER ; ';
end;

function SPSaleLinePriceIncRelatedExSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS SaleLinePriceIncRelatedEx; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION SaleLinePriceIncRelatedEx(aSaleLineGlobalRef VARCHAR(255) )   ' + NL+
    ' RETURNS DOUBLE   ' + NL+
    ' BEGIN  ' + NL+
        ' DECLARE result DOUBLE; ' +NL +
        ' DECLARE related DOUBLE; ' +NL +
        ' SET result = (select sum(SL1.LinePrice) from tblsaleslines SL1 ' + NL +
        '   where SL1.GlobalRef = aSaleLineGlobalRef and IfNull(SL1.RelatedParentLineRef,"") = "" ' + NL+
        '   and IfNull(SL1.GlobalRef,"") <> ""); ' + NL+
        ' SET related = (select sum(SL.LinePrice) ' + NL+
        '   from tblsaleslines as SL ' + NL+
        '   inner join tblparts p on p.PartsID = SL.ProductID ' + NL+
        '   inner join tblrelatedparts r on r.ProductID = SL.ProductID ' + NL+
        '   where SL.RelatedParentLineRef = aSaleLineGlobalRef ' + NL+
        '   and (p.HideOnPrint = "T" or r.HideRelated = "T")); ' + NL+
        ' RETURN ROUND(result + ifNull(related,0),5); ' + NL+
    ' END; // ' + NL+
    ' DELIMITER ; ';
end;

function SPSaleLinePriceIncRelatedIncSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS SaleLinePriceIncRelatedInc; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION SaleLinePriceIncRelatedInc(aSaleLineGlobalRef VARCHAR(255) )   ' + NL+
    ' RETURNS DOUBLE   ' + NL+
    ' BEGIN  ' + NL+
        ' DECLARE result DOUBLE; ' +NL +
        ' DECLARE related DOUBLE; ' +NL +
        ' SET result = (select sum(SL1.LinePriceInc) from tblsaleslines SL1 ' + NL +
        '   where SL1.GlobalRef = aSaleLineGlobalRef and IfNull(SL1.RelatedParentLineRef,"") = "" ' + NL+
        '   and IfNull(SL1.GlobalRef,"") <> ""); ' + NL+
        ' SET related = (select sum(SL.LinePriceInc) ' + NL+
        '   from tblsaleslines as SL ' + NL+
        '   inner join tblparts p on p.PartsID = SL.ProductID ' + NL+
        '   inner join tblrelatedparts r on r.ProductID = SL.ProductID ' + NL+
        '   where SL.RelatedParentLineRef = aSaleLineGlobalRef ' + NL+
        '   and (p.HideOnPrint = "T" or r.HideRelated = "T")); ' + NL+
        ' RETURN Round(result + ifNull(related,0),5); ' + NL+
    ' END; // ' + NL+
    ' DELIMITER ; ';
end;
function SPTreeNodeCaptionSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS TreeNodeCaption; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION TreeNodeCaption(	Level INT,	Caption VARCHAR(255))   ' + NL+
    ' RETURNS VARCHAR(255)  ' + NL+
    ' BEGIN  ' + NL+
        ' return concat(repeat("    " , Level) , caption); ' + NL+
    ' END; // ' + NL+
    ' DELIMITER ; ';
end;

function SPReplaceNewLineSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS ReplaceNewLine; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION ReplaceNewLine(Data VARCHAR(3000), replaceWith VARCHAR(10))   ' + NL+
    ' RETURNS VARCHAR(3000)  ' + NL+
    ' BEGIN  ' + NL+
    '   if ReplaceWith ="" then set ReplaceWith = ","; end if;'+NL+
    '   return replace(Data, "\r\n",replaceWith); ' + NL+
    ' END; // ' + NL+
    ' DELIMITER ; ';
end;
function SPAutoRoundRelatedQtySQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS AutoRoundRelatedQty; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION AutoRoundRelatedQty(	aShipQty DOUBLE,	aParentProductId INT,	aProductID INT) ' + NL+
    ' RETURNS DOUBLE  ' + NL+
    ' BEGIN  ' + NL+
    '   Declare aZeroWhenLessthan1 VARCHAR(1); ' + NL+
    ' 	Declare aIsToRoundtoNextNumberinSales VARCHAR(1); ' + NL+
    ' 	Declare aIsToRoundtoPreviousNumberinSales VARCHAR(1); ' + NL+
    ' 	Declare aParentQty double; ' + NL+
    ' 	Declare aqty double; ' + NL+
    ' 	Declare aextraQty  double; ' + NL+
    ' 	Declare aREsult  double; ' + NL+
    '   Declare  fi int(11); ' + NL+


    ' 	Declare  RP cursor for Select convert(ZeroWhenLessthan1, char(1)) as ZeroWhenLessthan1, '+
                                      ' convert(IsToRoundtoNextNumberinSales, char(1)) as IsToRoundtoNextNumberinSales, '+
                                      ' convert(IsToRoundtoPreviousNumberinSales , char(1)) as IsToRoundtoPreviousNumberinSales, '+
                                      ' ParentQty, qty, extraQty ' +
    ' 	from tblrelatedparts  	where ParentID = aParentProductId and ProductID = aProductID; ' + NL+

    ' 	Set aREsult = aShipQty; ' + NL+
    '	open RP; ' + NL+
    '	Fetch RP  into aZeroWhenLessthan1 , aIsToRoundtoNextNumberinSales , aIsToRoundtoPreviousNumberinSales , aParentQty, aqty, aextraQty; ' + NL+
    '       if (aQty =0) or (aParentQty=0) then set aREsult = 0; ' + NL+
    '       else Set aREsult := aREsult * (aQty / aParentQty); end if; ' + NL+
    '       if aREsult <>0 then '+
    '                if (aIsToRoundtoNextNumberinSales="T") 				  then  '+NL+
    '                    if truncate((aREsult)/aQty,0) <> (aREsult)/aQty then '+NL+
    '                         set fi = 1;'+NL+
    '                         while fi*aQty < aREsult do Set fi = fi+1; end while;'+NL+
    '                         Set aREsult := fi*aQty;  '+NL+
    '                    end if;'+NL+
    '                ELSEIF (aIsToRoundtoPreviousNumberinSales="T") 				  then  '+NL+
    '                    if truncate((aREsult)/aQty,0) <> (aREsult)/aQty then '+NL+
    '                         set fi = truncate((aREsult)/aQty,0)+1;'+NL+
    '                         while fi*aQty > aREsult do Set fi = fi-1; end while;'+NL+
    '                         Set aREsult := fi*aQty;  '+NL+
    '                    end if;'+NL+
    '                end if; '+NL+
    '       end if;' + NL+

    '       if aextraQty >0 then Set aREsult := aREsult + aextraQty; end if; ' + NL+
    '      	if (aZeroWhenLessthan1 ="T") and (aREsult <1 ) then Set aREsult = 0; end if;' + NL+
    '	return Round(aResult, ' + Floattostr(tcConst.GeneralRoundPlaces) +');' + NL+
    ' END; // ' + NL+
    ' DELIMITER ; ';
end;

function SPStrToRowsSQL: string;
begin
  Result :=
    ' DROP PROCEDURE IF EXISTS StrToRows; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE PROCEDURE StrToRows(	IN toSplit VARCHAR(255),	IN tmpTable VARCHAR(255)) ' + NL+
    ' BEGIN ' + NL+
    ' /*eg call: ' + NL+
    ' call FieldTorows((Select SoldSerials from tblsaleslines where ifnull(SoldSerials ,"")<> "" and SoldSerials like "%,%" limit 1), "tmp_1") ; ' + NL+
    ' Select * from tmp_1*/ ' + NL+
    '   SET @fieldName = "Data"; ' + NL+

    '   SET @sql := CONCAT("DROP TABLE IF EXISTS ", tmpTable); ' + NL+
    '   PREPARE stmt FROM @sql; ' + NL+
    '   EXECUTE stmt; ' + NL+
    '   DEALLOCATE PREPARE stmt; ' + NL+

    '   SET @sql := CONCAT("CREATE TEMPORARY TABLE ", tmpTable, " (", @fieldName, " VARCHAR(1000))"); ' + NL+
    '   PREPARE stmt FROM @sql; ' + NL+
    '   EXECUTE stmt; ' + NL+
    '   DEALLOCATE PREPARE stmt; ' + NL+

    '   SET @vars := toSplit; ' + NL+
    '   SET @vars := CONCAT("(''", REPLACE(@vars, ",", "''),(''"), "'')"); ' + NL+

    '   SET @sql := CONCAT("INSERT INTO ", tmpTable, " VALUES ", @vars); ' + NL+
    '   PREPARE stmt FROM @sql; ' + NL+
    '   EXECUTE stmt; ' + NL+
    '   DEALLOCATE PREPARE stmt; ' + NL+

    ' END; // ' + NL+
    ' DELIMITER ; ';
end;

function SPOrderDiscountAmountSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS OrderDiscountAmount; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION OrderDiscountAmount(aOrderID int(11) )   ' + NL+
    ' RETURNS DOUBLE   ' + NL+
    ' BEGIN  ' + NL+
        ' DECLARE result DOUBLE; ' +NL +
        ' SET result = - (select sum(TotalLineAmountInc)' + NL+
        '   from tblPurchaseLines' + NL +
        '   where tblPurchaseLines.PurchaseOrderID = aOrderID' + NL +
        '   and tblPurchaseLines.ProductName like "%Discount%"' + NL +
        '   and tblPurchaseLines.PartType = "OTHER");' + NL +
        ' RETURN result; ' + NL+
    ' END; // ' + NL+
    ' DELIMITER ; ';
end;

function SPOrderDiscountPercentSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS OrderDiscountPercent; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION OrderDiscountPercent(aOrderID int(11) )   ' + NL+
    ' RETURNS DOUBLE   ' + NL+
    ' BEGIN  ' + NL+
        ' DECLARE DiscountAmount DOUBLE; ' +NL +
        ' DECLARE OrderTotal DOUBLE; ' +NL +
        ' DECLARE result DOUBLE; ' +NL +
        ' SET result = 0;' + NL +
        ' SET DiscountAmount = - (select sum(TotalLineAmountInc)' + NL+
        '   from tblPurchaseLines' + NL +
        '   where tblPurchaseLines.PurchaseOrderID = aOrderID' + NL +
        '   and tblPurchaseLines.ProductName like "%Discount%"' + NL +
        '   and tblPurchaseLines.PartType = "OTHER");' + NL +
        ' SET OrderTotal = (select sum(TotalAmountInc)' + NL+
        '  from tblPurchaseOrders' + NL +
        '  where tblPurchaseOrders.PurchaseOrderID = aOrderID);' + NL +
        ' IF (DiscountAmount <> 0 and OrderTotal <> 0)' +NL +
        ' THEN SET result = Round((DiscountAmount / (OrderTotal + DiscountAmount)) * 100,1);' + NL +
        ' END IF;' + NL +
        ' RETURN result;' + NL +
    ' END; // ' + NL+
    ' DELIMITER ; ';
end;
function SPSalesPrintdocIDSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS SalesPrintdocID; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION SalesPrintdocID(aDocName VARCHAR(255),    ' + NL+
    '                                 aSaleId INT(11),    ' + NL+
    '                                 aPrintedFromAnyForm VARCHAR(1),    ' + NL+
    '                                 aPrintedfrom VARCHAR(255),    ' + NL+
    '                                 aDocOutputType VARCHAR(255))   ' + NL+
    ' RETURNS INT(11) ' + NL+
    ' begin ' + NL+
    ' DECLARE fiPrintDocId Integer; ' + NL+
    ' DECLARE no_more_rows BOOLEAN; ' + NL+
    ' DECLARE Cur_SalesPrint Cursor for' + NL+
    '     select PrintDocId from tblPrintDocs' + NL+
    '     where tblPrintdocs.DocId = aSaleId' + NL+
    '     AND tblPrintdocs.DocName = aDocName' + NL+
    '     and (tblPrintdocs.printedfrom = aPrintedfrom  or aPrintedFromAnyForm ="T")' + NL+
    '     and (IfNull(tblPrintdocs.DocOutputType,"") = aDocOutputType or aDocOutputType ="")' + NL+
    '     limit 1; ' + NL+
    ' DECLARE CONTINUE HANDLER FOR NOT FOUND     SET no_more_rows = TRUE; ' + NL+
    ' Open Cur_SalesPrint; ' + NL+
    ' Fetch Cur_SalesPrint into fiPrintDocId; ' + NL+
    ' IF no_more_rows THEN  ' + NL+
    '   RETURN  0;  ' + NL+
    ' ELSE   ' + NL+
    '   RETURN  fiPrintDocId;   ' + NL+
    ' END IF; ' + NL+
    ' CLOSE Cur_SalesPrint; ' + NL+
    ' end;   // ' + NL+
    ' DELIMITER ; ';
end;

function SPSalesPrintedbySQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS SalesPrintedby; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION SalesPrintedby(aDocName VARCHAR(255),    ' + NL+
    '                                 aSaleId INT(11),    ' + NL+
    '                                 aPrintedFromAnyForm VARCHAR(1),    ' + NL+
    '                                 aPrintedfrom VARCHAR(255),    ' + NL+
    '                                 aDocOutputType VARCHAR(255))   ' + NL+
    ' RETURNS varchar(255) ' + NL+
    ' begin ' + NL+
    '  DECLARE fsEmployeeName varchar(255); ' + NL+
    ' DECLARE no_more_rows BOOLEAN; ' + NL+
    ' DECLARE Cur_SalesPrint Cursor for ' + NL+
    '     select tblEmployees.EmployeeName  ' + NL+
    '     from tblPrintDocs INNER JOIN  tblEmployees ON tblPrintDocs.PrintedBy = tblEmployees.EmployeeID  ' + NL+
    '     where  tblPrintdocs.DocId = aSaleId ' + NL+
    '     AND tblPrintdocs.DocName = aDocName' + NL+
    '     and (tblPrintdocs.printedfrom = aPrintedfrom  or aPrintedFromAnyForm ="T")' + NL+
    '     and (IfNull(tblPrintdocs.DocOutputType,"") = aDocOutputType or aDocOutputType ="")' + NL+
    '     limit 1; ' + NL+
    ' DECLARE CONTINUE HANDLER FOR NOT FOUND     SET no_more_rows = TRUE; ' + NL+
    ' Open Cur_SalesPrint; ' + NL+
    ' Fetch Cur_SalesPrint into fsEmployeeName; ' + NL+
    ' IF no_more_rows THEN  ' + NL+
    '   RETURN  "";  ' + NL+
    ' ELSE   ' + NL+
    '   RETURN  fsEmployeeName;   ' + NL+
    ' END IF; ' + NL+
    ' CLOSE Cur_SalesPrint; ' + NL+
    ' end;   // ' + NL+
    ' DELIMITER ; ';
end;
{function SPUpdateSerialnumberOldListSQL: string;
begin
  Result :=
    ' DROP PROCEDURE IF EXISTS UpdateSerialnumberOldList; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE PROCEDURE UpdateSerialnumberOldList(aProductId INT,aDepartmentId INT,aUOMID INT,aSerialnumber VARCHAR(255),aAsOnDate DATETIME,aTablename VARCHAR(255)) ' + NL+
    ' BEGIN ' + NL+

    ' Declare spqa VARCHAR(255);' + NL+
    ' Declare spqad VARCHAR(255);' + NL+
    ' DECLARE fiClassId int(11);' + NL+
    ' DECLARE no_more_rows BOOLEAN;' +NL+
    ' DECLARE aTablename1 VarChar(255);'+NL+
    ' DECLARE aTablename2 VarChar(255);'+NL+

    '  Declare fdLastUpdateSerialnumberDatetime Datetime;'+NL+
    '  Declare fdmaxdate Datetime;'+NL+

    ' DECLARE Cur_classes Cursor for  '+
    ' Select Distinct departmentId as ClassID , '+
    ' (select LastUpdateSerialnumberDatetime from tblUpdateSerialnumberHistory where (tablename = aTablename) or (aTablename ="" and Tablename = "tblSerialnumberList")) as LastUpdateSerialnumberDatetime,'+
    ' (select if(pqa<pqad, pqad, pqa) as maxdate from (Select (Select max(mstimestamp) from tblpqa) as pqa,  (Select max(mstimestamp) from tblpqadetails where pqatype ="SN") as pqad ) details) as maxdate '+
    ' from tblpqa  Where ( aDepartmentId=0 or departmentId = aDepartmentId) and departmentId <>0;' +NL+
    ' DECLARE CONTINUE HANDLER FOR NOT FOUND     SET no_more_rows = TRUE; ' + NL+
    ' Open Cur_classes ; ' + NL+
    ' FETCH Cur_classes into fiClassId , fdLastUpdateSerialnumberDatetime , fdmaxdate ;   ' + NL+

    ' if (ifnull(fdLastUpdateSerialnumberDatetime ,0) <>0) and  (fdLastUpdateSerialnumberDatetime >=  fdmaxdate) then '+NL+
    '  	    update tblUpdateSerialnumberHistory Set LastUpdateSerialnumberDatetime = now() , updateStatus =1 where (tablename = aTablename) or (aTablename ="" and Tablename = "tblSerialnumberList"); ' + NL+
    ' else ' + NL+
    '  	  set spqa = concat("tmp_SNL_pqa_",TIME_FORMAT(CURRENT_TIME(),"%i%S") ,"_" , trim(convert(round(Rand()*100000) , char(15)))) ;' + NL+
    '  	  set spqad =concat("tmp_SNL_pqadetails_",TIME_FORMAT(CURRENT_TIME(),"%i%S") ,"_" , trim(convert(round(Rand()*100000) , char(15)))) ;' + NL+


    '  	  SET @s = CONCAT(''DROP TABLE if exists '', spqa, '' ; ''   );' + NL+
    '  	  PREPARE stmt FROM @s; ' + NL+
    '  	  EXECUTE stmt; ' + NL+

    '  	  SET @s = CONCAT(''DROP TABLE if exists '', spqad, '' ; ''   );' + NL+
    '  	  PREPARE stmt FROM @s; ' + NL+
    '  	  EXECUTE stmt; ' + NL+

    '  	  SET @s = CONCAT('' Create table '', spqa , '' like tblpqa; '' );' + NL+
    '  	  PREPARE stmt FROM @s; ' + NL+
    '  	  EXECUTE stmt; ' + NL+

    '  	  SET @s = CONCAT(''Create table '', spqad , '' like tblpqadetails; '' );' + NL+
    '  	  PREPARE stmt FROM @s; ' + NL+
    '  	  EXECUTE stmt; ' + NL+

    '  	  if (aAsOnDate<>0) or (aProductID<>0) or (ADepartmentID<>0) or (aUOMID<>0) or (aSerialnumber<>"") then ' + NL+
    '  	      if (aTablename = "tblSerialnumberList" or  aTablename ="") then ' + NL+
    '  	        Set aTablename = "tmp_tblSerialnumberList";  end if; ' + NL+
    '  	      else if aTablename = "" then ' + NL+
    '  	        Set aTablename = "tblSerialnumberList"; ' + NL+
    '  	      end if; ' + NL+
    '  	  end if; ' + NL+
    '  	  Set aTablename1 = concat(aTablename, "1");'+NL+
    '  	  Set aTablename2 = "tmp_SN_Ctr";'+NL+


    '  	  SET @s = CONCAT(''DROP TABLE if exists '', aTablename2, '' ; '' ); ' + NL+
    '  	  PREPARE stmt FROM @s; ' + NL+
    '  	  EXECUTE stmt; ' + NL+

    '  	  SET @s = CONCAT(''Create table  '', aTablename2, ''  Select Distinct departmentId as ClassID , "F" as Done from tblpqa  Where ( '', aDepartmentId ,''=0 or departmentId = '', aDepartmentId ,'') and departmentId <>0; '' ); ' + NL+
    '  	  PREPARE stmt FROM @s; ' + NL+
    '  	  EXECUTE stmt; ' + NL+

    '  	  SET @s = CONCAT(''DROP TABLE if exists '', aTablename, '' ; '' ); ' + NL+
    '  	  PREPARE stmt FROM @s; ' + NL+
    '  	  EXECUTE stmt; ' + NL+

    '  	  SET @s = CONCAT(''CREATE TABLE if not exists '', aTablename, '' ( '', ' + NL+
    '  	      '' ID             INT(11) NOT NULL AUTO_INCREMENT, '', ' + NL+
    '  	      '' ProductID      INT(11) NULL DEFAULT "0", '', ' + NL+
    '  	      '' DepartmentId   INT(11) NULL DEFAULT "0", '', ' + NL+
    '  	      '' UOMID          INT(11) NULL DEFAULT "0", '', ' + NL+
    '  	      '' UOM            VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    '  	      '' UOMMultiplier  Double Null Default 0, '', ' + NL+
    '  	      '' SerialNumber   VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    '  	      '' PQAID          INT(11) NULL DEFAULT "0", '', ' + NL+
    '  	      '' PQABatchID     INT(11) NULL DEFAULT "0", '', ' + NL+
    '  	      '' PQABinID       INT(11) NULL DEFAULT "0", '', ' + NL+
    '  	      '' PQASNID        INT(11) NULL DEFAULT "0", '', ' + NL+
    '  	      '' Transdate      DATETIME NULL DEFAULT NULL, '', ' + NL+
    '  	      '' Qty            Double Null Default 0, '', ' + NL+
    '  	      '' Batchnumber    VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    '  	      '' TruckLoadNo    VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    '  	      '' Expirydate     DAteTime NULL DEFAULT NULL, '', ' + NL+
    '  	      '' binLocation    VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    '  	      '' Binnumber      VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    '  	      '' TransType      VARCHAR(50) NULL DEFAULT NULL, '', ' + NL+
    '  	      '' Alloctype      VARCHAR(3) NULL DEFAULT NULL, '', ' + NL+
    '  	      '' Status         VARCHAR(30) NULL DEFAULT NULL, '', ' + NL+
    '  	      '' SMID           INT(11) NULL DEFAULT "0", '', ' + NL+
    '  	      '' SMEntryType    VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    '  	      '' AssetID        INT(11) NULL DEFAULT "0", '', ' + NL+
    '  	      '' mstimeStamp    TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, '', ' + NL+
    '  	      '' PRIMARY KEY (ID), '', ' + NL+
    '  	      '' UNIQUE INDEX KeyIDX (ProductID,DepartmentId, UOMID, SerialNumber) ) COLLATE="utf8_general_ci" ENGINE=MyISAM ; '' ); ' + NL+
    '  	  PREPARE stmt FROM @s; ' + NL+
    '  	  EXECUTE stmt; ' + NL+

    '  	  Close Cur_classes ; ' + NL+
    '  	  Open Cur_classes ; ' + NL+
    '  	  The_loop: LOOP ' + NL+

    '  	      FETCH Cur_classes into fiClassId , fdLastUpdateSerialnumberDatetime , fdmaxdate ;   ' + NL+
    '  	      IF no_more_rows THEN ' + NL+
    '  	    			CLOSE Cur_classes; ' + NL+
    '  	    	    SET @s = CONCAT(''DROP TABLE if exists '', aTablename1, '' ; '' ); ' + NL+
    '  	    	    PREPARE stmt FROM @s; ' + NL+
    '  	    	    EXECUTE stmt; ' + NL+
    '  	    			LEAVE the_loop; ' + NL+
    '  	      END IF; ' + NL+

    '  	      SET @s = CONCAT(''Truncate '', spqa, '' ; '' ); ' + NL+
    '  	      PREPARE stmt FROM @s; ' + NL+
    '  	      EXECUTE stmt; ' + NL+

    '  	      SET @s = CONCAT(''Truncate '', spqad, '' ; '' ); ' + NL+
    '  	      PREPARE stmt FROM @s; ' + NL+
    '  	      EXECUTE stmt; ' + NL+

    '  	      SET @s = CONCAT(''insert ignore into '', spqa , '' select * from tblpqa  '' , '+
	 	'                 '' where ( '' , aProductID    , ''=0 or '', aProductID    ,''= ProductID   ) '' ,'+
 	  '                 '' and   ( '' , aUOMID        , ''=0 or '', aUOMID        ,''= UOMID       )'' ,' +
 	  '                 '' and   ( DepartmentId ='', fiClassId, ''); '' );'+NL+
    '  	      PREPARE stmt FROM @s; ' + NL+
    '  	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''insert ignore into '', spqad , '' select pqad.*  from tblpqadetails pqad inner join tblpqa pqa on pqad.pqaid = pqa.PQAID '' , '+
    ' 	              '' where ( '' , aProductID    , ''=0 or '', aProductID    ,''= pqa.ProductID   ) '' ,'+
    ' 	              '' and   ( '' , aUOMID        , ''=0 or '', aUOMID        ,''= pqa.UOMID       )'' ,' +
    ' 	              '' and   ( DepartmentId ='', fiClassId, ''); '' );'+NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''DROP TABLE if exists '', aTablename1, '' ; '' ); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''CREATE TABLE if not exists '', aTablename1, '' ( '', ' + NL+
    ' 	       '' ID             INT(11) NOT NULL AUTO_INCREMENT, '', ' + NL+
    ' 	       '' ProductID      INT(11) NULL DEFAULT "0", '', ' + NL+
    ' 	       '' DepartmentId   INT(11) NULL DEFAULT "0", '', ' + NL+
    ' 	       '' UOMID          INT(11) NULL DEFAULT "0", '', ' + NL+
    ' 	       '' UOM            VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' UOMMultiplier  Double Null Default 0, '', ' + NL+
    ' 	       '' SerialNumber   VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' PQAID          INT(11) NULL DEFAULT "0", '', ' + NL+
    ' 	       '' PQABatchID     INT(11) NULL DEFAULT "0", '', ' + NL+
    ' 	       '' PQABinID       INT(11) NULL DEFAULT "0", '', ' + NL+
    ' 	       '' PQASNID        INT(11) NULL DEFAULT "0", '', ' + NL+
    ' 	       '' Transdate      DATETIME NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' Qty            Double Null Default 0, '', ' + NL+
    ' 	       '' Batchnumber    VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' TruckLoadNo    VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' Expirydate     DAteTime NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' binLocation    VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' Binnumber      VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' TransType      VARCHAR(50) NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' Alloctype      VARCHAR(3) NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' Status         VARCHAR(30) NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' SMID           INT(11) NULL DEFAULT "0", '', ' + NL+
    ' 	       '' SMEntryType    VARCHAR(255) NULL DEFAULT NULL, '', ' + NL+
    ' 	       '' AssetID        INT(11) NULL DEFAULT "0", '', ' + NL+
    ' 	       '' mstimeStamp    TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, '', ' + NL+
    ' 	       '' PRIMARY KEY (ID), '', ' + NL+
    ' 	       '' UNIQUE INDEX KeyIDX (ProductID, DepartmentId,  UOMID, SerialNumber) ) COLLATE="utf8_general_ci" ENGINE=MyISAM ; '' ); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+


    ' 	      SET @s = CONCAT('' insert ignore into '', aTablename1, '' (ProductId, departmentId, uomid, Serialnumber)  '', ' + NL+
    ' 	     	  '' select distinct pqa.ProductID, pqa.DepartmentID, pqa.UOMID , pqasn.Value as serialnumber  '', ' + NL+
    ' 	     	  '' from '', spqad , '' pqasn  '', ' + NL+
    ' 	     	  '' inner join '', spqa , '' pqa on pqasn.PQAID = pqa.pqaid  '', ' + NL+
    ' 	     	  '' where pqatype ="SN" '', ' + NL+
    ' 	     	  '' and ( (pqa.ProductID = '',aProductID,''  or '',aProductID,'' =0) '', ' + NL+
    ' 	     	  '' and (pqa.DepartmentId = '',fiClassId,'' ) '', ' + NL+
    ' 	     	  '' and (pqa.uomid = '',auomid,'' or '',auomid,'' =0) '', ' + NL+
    ' 	     	  '' and (pqasn.Value = "'',aSerialnumber,''" or "'',aSerialnumber,''" = "") '', ' + NL+
    ' 	     	  '' and (pqa.transdate <= "'',aAsOnDate,''" or "'',aAsOnDate,''" =convert(0,date)));''  ); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''update '', aTablename1, '' T Set Transdate = (Select max(maxpqa.transDate)   '', ' + NL+
    ' 	     	  '' from '', spqad , '' maxpqad  '', ' + NL+
    ' 	     	  '' inner join '', spqa , '' maxpqa on maxpqa.PQAID = maxpqad.PQAID  '', ' + NL+
    ' 	     	  '' where  maxpqad.PQAType = "SN"  and maxpqad.qty <> 0 and  (maxpqa.Active = "T"  or  maxpqa.transtype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE","TProcProgressIn"))    '', ' + NL+
    ' 	     	  '' and maxpqa.ProductID = T.ProductID and maxpqa.DepartmentId = T.departmentId and maxpqa.uomid = T.uomid '', ' + NL+
    ' 	     	  '' and maxpqad.value =T.serialnumber and (maxpqa.transdate <= "'',aAsOnDate,''" or "'',aAsOnDate,''" =convert(0,date)))  '', ' + NL+
    ' 	     	  '' where T.transdate is null and  ((T.ProductID = '',aProductID,''  or '',aProductID,'' =0) '', ' + NL+
    ' 	     	  '' and (T.DepartmentId = '',fiClassId,'' ) '', ' + NL+
    ' 	     	  '' and (T.uomid = '',auomid,'' or '',auomid,'' =0) '', ' + NL+
    ' 	     	  '' and (T.Serialnumber = "'',aSerialnumber,''" or "'',aSerialnumber,''" = "") );'' ); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''update '', aTablename1, '' T Set Qty = (Select  '', ' + NL+
    ' 	     	  '' sum( '+    replacestr(SQL4QtyField(tAvailable, 'MaxPQA' , 'maxPQAD.qty'), '''', '"')+')    '', ' + NL+
    ' 	     	  '' from '', spqad , '' maxpqad  '', ' + NL+
    ' 	     	  '' inner join '', spqa , '' maxpqa on maxpqa.PQAID = maxpqad.PQAID  '', ' + NL+
    ' 	     	  '' where maxpqad.PQAType = "SN"  and maxpqad.qty <> 0 and  (maxpqa.Active = "T"  or  maxpqa.transtype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE","TProcProgressIn"))    '', ' + NL+
    ' 	     	  '' and maxpqa.ProductID = T.ProductID and maxpqa.DepartmentId = T.departmentId  and maxpqa.uomid = T.uomid '', ' + NL+
    ' 	     	  '' and maxpqad.value =T.serialnumber  and (maxpqa.transdate <= "'',aAsOnDate,''" or "'',aAsOnDate,''" =convert(0,date)))  '', ' + NL+
    ' 	     	  '' where  ((T.ProductID = '',aProductID,''  or '',aProductID,'' =0) '', ' + NL+
    ' 	     	  '' and (T.DepartmentId = '',fiClassId,'' ) '', ' + NL+
    ' 	     	  '' and (T.uomid = '',auomid,'' or '',auomid,'' =0) '', ' + NL+
    ' 	     	  '' and (T.Serialnumber = "'',aSerialnumber,''" or "'',aSerialnumber,''" = "")); ''); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+


    ' 	      SET @s = CONCAT(''update '', aTablename1, '' T  '', ' + NL+
    ' 	     	  '' inner join '', spqa , '' pqa on T.productId = pqa.ProductId    AND PQA.TRANSDATE = T.TRANSDATE'+
    ' 	     	and T.departmentId = pqa.departmentId '+
    ' 	     	and t.uomid = pqa.uomid  '', ' + NL+
    ' 	     	  '' inner join '', spqad , '' pqad on pqad.pqaid = pqa.pqaid and pqad.PQAType ="SN" and pqad.Value = T.serialnumber  '', ' + NL+
    ' 	     	  '' Set T.pqasnid = pqad.PQADetailID , t.pqaid = pqa.PQAID, t.Alloctype = pqa.Alloctype , T.TransType = pqa.TransType'+
    ' 	        '', ' + NL+
    ' 	     	  '' where  ((T.ProductID = '',aProductID,''  or '',aProductID,'' =0) '', ' + NL+
    ' 	     	  '' and (T.DepartmentId = '',fiClassId,'' ) '', ' + NL+
    ' 	     	  '' and (T.uomid = '',auomid,'' or '',auomid,'' =0) '', ' + NL+
    ' 	     	  '' and (T.Serialnumber = "'',aSerialnumber,''" or "'',aSerialnumber,''" = ""));''); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''update '', aTablename1, '' T  '', ' + NL+
    ' 	     	  '' inner join '', spqad , '' pqad on T.pqasnid = pqad.PQADetailID '', ' + NL+
    ' 	     	  '' inner join '', spqad , '' pqadp on pqad.ParentRef = pqadp.GlobalRef '', ' + NL+
    ' 	     	  '' Set T.pqabinid = pqadp.PQADetailID '', ' + NL+
    ' 	     	  '' where (ifnull(pqad.ParentRef, "")<> "" and  pqad.pqatype = "Bin" )'', ' + NL+
    ' 	     	  '' and ( (T.ProductID = '',aProductID,''  or '',aProductID,'' =0) '', ' + NL+
    ' 	     	  '' and (T.DepartmentId = '',fiClassId,'' ) '', ' + NL+
    ' 	     	  '' and (T.uomid = '',auomid,'' or '',auomid,'' =0) '', ' + NL+
    ' 	     	  '' and (T.Serialnumber = "'',aSerialnumber,''" or "'',aSerialnumber,''" = ""));'' ); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''update '', aTablename1, '' T  '', ' + NL+
    ' 	     	  '' inner join '', spqad , '' pqad on T.pqasnid = pqad.PQADetailID '', ' + NL+
    ' 	     	  '' inner join '', spqad , '' pqadp on pqad.ParentRef = pqadp.GlobalRef '', ' + NL+
    ' 	     	  '' Set T.pqabinid = pqadp.PQADetailID '', ' + NL+
    ' 	     	  '' where ifnull(pqad.ParentRef, "")<> "" and  pqad.pqatype = "Batch" '', ' + NL+
    ' 	     	  '' and ( (T.ProductID = '',aProductID,''  or '',aProductID,'' =0) '', ' + NL+
    ' 	     	  '' and (T.DepartmentId = '',fiClassId,'' ) '', ' + NL+
    ' 	     	  '' and (T.uomid = '',auomid,'' or '',auomid,'' =0) '', ' + NL+
    ' 	     	  '' and (T.Serialnumber = "'',aSerialnumber,''" or "'',aSerialnumber,''" = ""));''); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''update '', aTablename1, '' T  inner join '', spqad , '' pqad on pqad.PQADetailID = T.PQABatchID  '+
                                    ' 	Set T.Batchnumber = pqad.value , T.TruckLoadNo = pqad.TruckLoadNo , T.Expirydate = pqad.Expirydate '', ' + NL+
    ' 	     	   '' Where ( (T.ProductID = '',aProductID,''  or '',aProductID,'' =0) '', ' + NL+
    ' 	     	   '' and (T.DepartmentId = '',fiClassId,'' ) '', ' + NL+
    ' 	     	   '' and (T.uomid = '',auomid,'' or '',auomid,'' =0) '', ' + NL+
    ' 	     	   '' and (T.Serialnumber = "'',aSerialnumber,''" or "'',aSerialnumber,''" = ""));''); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''update '', aTablename1, '' T   '+
                                    ' inner join '', spqad , '' pqad on pqad.PQADetailID = T.PQABinID  '+
                                    ' Left join `tblProductBin` PBin     on PBin.binId 	= pqad.BinID  '+
                                    ' Set T.Binlocation = PBin.Binlocation , T.Binnumber = PBin.Binnumber '', ' + NL+
    ' 	     	   '' Where ( (T.ProductID = '',aProductID,''  or '',aProductID,'' =0) '', ' + NL+
    ' 	     	   '' and (T.DepartmentId = '',fiClassId,'' ) '', ' + NL+
    ' 	     	   '' and (T.uomid = '',auomid,'' or '',auomid,'' =0) '', ' + NL+
    ' 	     	   '' and (T.Serialnumber = "'',aSerialnumber,''" or "'',aSerialnumber,''" = ""));''); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+


    ' 	      SET @s = CONCAT(''update '', aTablename1, '' T '+
                                    ' inner join '', spqa , '' pqa on pqa.pqaid = T.pqaid  '+
                                    ' left join tblstockmovementlines SML on PQA.transId = SML.StockmovementID and PQA.transLineId = SML.StockmovementLinesID and PQA.transType = "TStockMovementLines"   '+
                                    ' Left join tblstockmovement SM on SM.StockmovementID = SML.StockmovementID  '+
                                    ' Set T.SMID = SM.StockmovementID , T.SMEntryType = SM.StockmovementEntryType '', ' + NL+
    ' 	     	   '' Where ( (T.ProductID = '',aProductID,''  or '',aProductID,'' =0) '', ' + NL+
    ' 	     	   '' and (T.DepartmentId = '',fiClassId,'' ) '', ' + NL+
    ' 	     	   '' and (T.uomid = '',auomid,'' or '',auomid,'' =0) '', ' + NL+
    ' 	     	   '' and (T.Serialnumber = "'',aSerialnumber,''" or "'',aSerialnumber,''" = ""));''); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''update '', aTablename1, '' T '+
                                    ' Left join `tblfixedAssets` FA on FA.PartsId = T.ProducTID and FA.ClassId =T.DepartmentID and FA.Serial = T.serialnumber '+
                                    ' Set T.AssetID = FA.AssetID '', ' + NL+
    ' 	     	   '' Where ( (T.ProductID = '',aProductID,''  or '',aProductID,'' =0) '', ' + NL+
    ' 	     	   '' and (T.DepartmentId = '',fiClassId,'' ) '', ' + NL+
    ' 	     	   '' and (T.uomid = '',auomid,'' or '',auomid,'' =0) '', ' + NL+
    ' 	     	   '' and (T.Serialnumber = "'',aSerialnumber,''" or "'',aSerialnumber,''" = ""));''); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''update '', aTablename1, '' T inner join '', spqad , '' pqasn on pqasn.pqadetailid = T.pqasnid left join tblfixedassets FA on T.AssetID = FA.AssetID  '+
                                    ' Set T.Status = PQAAllocType(T.AllocType, T.Transtype, pqasn.Qty, T.SMID, T.SMEntryType, FA.Serial)  '', ' + NL+
    ' 	     	   '' Where ( (T.ProductID = '',aProductID,''  or '',aProductID,'' =0) '', ' + NL+
    ' 	     	   '' and (T.DepartmentId = '',fiClassId,'' ) '', ' + NL+
    ' 	     	   '' and (T.uomid = '',auomid,'' or '',auomid,'' =0) '', ' + NL+
    ' 	     	   '' and (T.Serialnumber = "'',aSerialnumber,''" or "'',aSerialnumber,''" = ""));''); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''update '', aTablename1, '' T inner join tblunitsofmeasure UOM on UOM.unitID = T.UOMID  '+
                                    ' Set T.UOM = UOM.UnitName, T.UOMMultiplier = UOM.Multiplier  ;''); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+



    ' 	      SET @s = CONCAT(''insert ignore into  '', aTablename, ''  '+
                                    ' (ProductID,DepartmentId,UOMID,UOM,UOMMultiplier,SerialNumber,PQAID,PQABatchID,PQABinID,PQASNID,Transdate,Qty,Batchnumber,TruckLoadNo,Expirydate,binLocation,Binnumber,TransType,Alloctype,Status,SMID,SMEntryType,AssetID,mstimeStamp)  '+
                                    ' select ProductID,DepartmentId,UOMID,UOM,UOMMultiplier,SerialNumber,PQAID,PQABatchID,PQABinID,PQASNID,Transdate,Qty,Batchnumber,TruckLoadNo,Expirydate,binLocation,Binnumber,TransType,Alloctype,Status,SMID,SMEntryType,AssetID,mstimeStamp  '+
                                    ' from '', aTablename1, '' ;''); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	      SET @s = CONCAT(''update  '', aTablename2, '' Set Done ="T" where classid ='' , fiClassId, ''; '' ); ' + NL+
    ' 	      PREPARE stmt FROM @s; ' + NL+
    ' 	      EXECUTE stmt; ' + NL+

    ' 	  END LOOP the_loop; ' + NL+

    ' 	  SET @s = CONCAT(''DROP TABLE if exists '', aTablename,''_Available'', '';''); ' + NL+
    ' 	  PREPARE stmt FROM @s; ' + NL+
    ' 	  EXECUTE stmt; ' + NL+

    ' 	  SET @s = CONCAT(''Create TABLE  '', aTablename,''_Available Like '',aTablename , '';''); ' + NL+
    ' 	  PREPARE stmt FROM @s; ' + NL+
    ' 	  EXECUTE stmt; ' + NL+

    ' 	  SET @s = CONCAT(''Insert ignore into '', aTablename,''_Available'', '' Select * from '' , aTablename , '' where Status = "In-Stock" or Status = "New" ;''); ' + NL+
    ' 	  PREPARE stmt FROM @s; ' + NL+
    ' 	  EXECUTE stmt; ' + NL+

    ' 	 SET @s = CONCAT(''DROP TABLE if exists '', spqa, '' ; ''   );' + NL+
    ' 	 PREPARE stmt FROM @s; ' + NL+
    ' 	 EXECUTE stmt; ' + NL+

    ' 	 SET @s = CONCAT(''DROP TABLE if exists '', spqad, '' ; ''   );' + NL+
    ' 	 PREPARE stmt FROM @s; ' + NL+
    ' 	 EXECUTE stmt; ' + NL+

    ' 	 SET @s = CONCAT(''DROP TABLE if exists '', aTablename2, '' ; '' ); ' + NL+
    ' 	 PREPARE stmt FROM @s; ' + NL+
    ' 	 EXECUTE stmt; ' + NL+

    ' 	 SET @s = CONCAT(''Create table  '', aTablename2, ''  Select Distinct departmentId as ClassID , "F" as Done from tblpqa  Where  departmentId <>0; '' ); ' + NL+
    ' 	 PREPARE stmt FROM @s; ' + NL+
    ' 	 EXECUTE stmt; ' + NL+

    ' 	 insert ignore into tblUpdateSerialnumberHistory Set Tablename = aTablename, LastUpdateSerialnumberDatetime = now() , updateStatus =2  on duplicate key update LastUpdateSerialnumberDatetime = now() , updateStatus =3; ' + NL+
    ' end if; ' + NL+
    ' END; // ' + NL+
    ' DELIMITER ; ';
end;            }

function SPUpdate_Serial_Number_ListSQL: string;
begin
  Result :=
    ' DROP PROCEDURE IF EXISTS Update_Serial_Number_List; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE PROCEDURE Update_Serial_Number_List()' + NL+
    ' BEGIN ' + NL+

    '       DECLARE fiClassId int(11);' + NL+
    '       DECLARE no_more_rows BOOLEAN;' +NL+
    '       DECLARE sSql varchar(255);' +NL+

    '       Declare fdLastUpdateSerialnumberDatetime Datetime;'+NL+
    '       Declare fdmaxdate Datetime;'+NL+

    '   /*01*/DECLARE Cur_classes Cursor for  Select Distinct departmentId as ClassID , '+
                                          ' convert(ifnull((select LastUpdateSerialnumberDatetime from tblUpdate_Serial_NumberHistory ),"1900-01-01"),datetime) as LastUpdateSerialnumberDatetime,'+
                                          ' (select if(pqa<pqad, pqad, pqa) as maxdate from (Select (Select max(mstimestamp) from tblpqa) as pqa,  (Select max(mstimestamp) from tblpqadetails where pqatype ="SN") as pqad ) details) as maxdate '+
                                          ' from tblpqa  Where departmentId <>0;' +NL+

    '       DECLARE CONTINUE HANDLER FOR NOT FOUND     SET no_more_rows = TRUE; ' + NL+
    '       Open Cur_classes ; ' + NL+
    '       FETCH Cur_classes into fiClassId , fdLastUpdateSerialnumberDatetime , fdmaxdate ;   ' + NL+

    '   /*02*/drop table if exists tblUpdate_Serial_Number_Listlog ;' + NL+
    '   /*03*/CREATE TABLE tblUpdate_Serial_Number_Listlog ( 	ID INT(11) NOT NULL AUTO_INCREMENT, 	'+
                                                      ' UpdateSerialnumberListLog VARCHAR(255) NULL DEFAULT NULL,  	'+
                                                      ' mstimestamp TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,		'+
                                                      ' PRIMARY KEY (ID) ) ENGINE=Myisam;' + NL+
    '   /*04*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = 1;' + NL+NL+

    '       if (fdLastUpdateSerialnumberDatetime  <>0) and  (fdLastUpdateSerialnumberDatetime >=  fdmaxdate) then '+NL+
    '  	          update tblUpdate_Serial_NumberHistory Set LastUpdateSerialnumberDatetime = now() , updateStatus =1  ; ' + NL+
    '       else ' + NL+
    '   /*05*/DROP TABLE if exists tmp_tbl_pqa ;'+NL+
    '   /*06*/DROP TABLE if exists tmp_tbl_pqadetails ; ' + NL+
    '   /*07*/Create table tmp_tbl_pqa like tblpqa;  '+ NL+
    '   /*08*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "2";' + NL+

    '   /*09*/Create table tmp_tbl_pqadetails like tblpqadetails; ' + NL+
    '   /*10*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "3";' + NL+

    '   /*11*/DROP TABLE if exists tmp_tbl_SN_Ctr ; ' + NL+

    '   /*12*/Create table  tmp_tbl_SN_Ctr Select Distinct departmentId as ClassID , "F" as Done from tblpqa  Where departmentId <>0;  ' + NL+

    '   /*13*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "4";' + NL+

    '   /*14*/CREATE TABLE if not exists tblserial_number_list ( '+
                '	ID INT(11) NOT NULL AUTO_INCREMENT, '+
                '	ProductID INT(11) NULL DEFAULT  0, '+
                '	DepartmentId INT(11) NULL DEFAULT  0, '+
                '	UOMID INT(11) NULL DEFAULT  0, '+
                '	UOM VARCHAR(255) NULL DEFAULT NULL, '+
                '	UOMMultiplier DOUBLE NULL DEFAULT  0, '+
                '	SerialNumber VARCHAR(255) NULL DEFAULT NULL, '+
                '	PQAID INT(11) NULL DEFAULT  0, '+
                '	PQABatchID INT(11) NULL DEFAULT  0, '+
                '	PQABinID INT(11) NULL DEFAULT  0, '+
                '	PQASNID INT(11) NULL DEFAULT  0, '+
                '	Transdate DATETIME NULL DEFAULT NULL, '+
                '	Qty DOUBLE NULL DEFAULT  0, '+
                '	Batchnumber VARCHAR(255) NULL DEFAULT NULL, '+
                '	TruckLoadNo VARCHAR(255) NULL DEFAULT NULL, '+
                '	Expirydate DATETIME NULL DEFAULT NULL, '+
                '	binLocation VARCHAR(255) NULL DEFAULT NULL, '+
                '	Binnumber VARCHAR(255) NULL DEFAULT NULL, '+
                '	TransType VARCHAR(50) NULL DEFAULT NULL, '+
                '	Alloctype VARCHAR(3) NULL DEFAULT NULL, '+
                '	Status VARCHAR(30) NULL DEFAULT NULL, '+
                '	SMID INT(11) NULL DEFAULT  0, '+
                '	SMEntryType VARCHAR(255) NULL DEFAULT NULL, '+
                '	AssetID INT(11) NULL DEFAULT  0, '+
                '	mstimeStamp TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, '+
                '	PRIMARY KEY (ID), '+
                '	UNIQUE INDEX KeyIDX (ProductID, DepartmentId, UOMID, SerialNumber), '+
                '	INDEX transdate (transdate), '+
                '	INDEX PQABatchID (PQABatchID), '+
                '	INDEX PQABinID (PQABinID), '+
                '	INDEX PQASNID (PQASNID)) COLLATE="utf8_general_ci" ENGINE=MyISAM; '+NL+

    '   /*15*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "5";' + NL+

    '   /*16*/Close Cur_classes ; ' + NL+
    '   /*17*/Open Cur_classes ; ' + NL+

    '   /*18*/The_loop: LOOP ' + NL+NL+

    '  	      /*19*/FETCH Cur_classes into fiClassId , fdLastUpdateSerialnumberDatetime , fdmaxdate ;   ' + NL+
    '  	      /*20*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(6 , "-" , fiClassId) ;' + NL+

    '  	            IF no_more_rows THEN ' + NL+
    '  	    			      CLOSE Cur_classes; ' + NL+
    '  	    	          DROP TABLE if exists tmp_tbl_SerialnumberList ; ' + NL+
    '  	    			      LEAVE the_loop; ' + NL+
    '  	            END IF; ' + NL+

    '  	      /*21*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(7 , "-" , fiClassId);' + NL+

    '  	      /*22*/Truncate  tmp_tbl_pqa  ; ' + NL+

    '  	      /*23*/Truncate tmp_tbl_pqadetails ; ' + NL+

    '  	      /*24*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(8 , "-" , fiClassId);' + NL+

    '  	      /*25*/insert ignore into  tmp_tbl_pqa  select * from tblpqa  '+
                                                    ' where  mstimestamp >= fdLastUpdateSerialnumberDatetime   '+
                                                    ' and   ( DepartmentId = fiClassId);' + NL+

    '  	      /*26*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(9 , "-" ,fiClassId, "-" ,  "tmp_tbl_pqa   -  " , (Select count(*) from   tmp_tbl_pqa  )); ' + NL+

    '  	      /*27*/insert ignore into tmp_tbl_pqadetails select pqad.* from tblpqadetails pqad  '+
                                                        ' inner join  tmp_tbl_pqa  pqa on pqad.pqaid = pqa.PQAID   '+
                                                        ' where  pqad.mstimestamp >= fdLastUpdateSerialnumberDatetime ; ' + NL+

    '  	      /*28*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(10 , "-" ,fiClassId, "-" ,   "tmp_tbl_pqadetails  -  ", (Select count(*) from  tmp_tbl_pqadetails )); ' + NL+

    ' 	      /*29*/CREATE TABLE if not exists tmp_tbl_SerialnumberList (  '+
    ' 	          ID             INT(11) NOT NULL AUTO_INCREMENT,  '+
                 ' ProductID      INT(11) NULL DEFAULT "0",  '+
                 ' DepartmentId   INT(11) NULL DEFAULT "0",  '+
                 ' UOMID          INT(11) NULL DEFAULT "0",  '+
                 ' UOM            VARCHAR(255) NULL DEFAULT NULL,  '+
                 ' UOMMultiplier  Double Null Default 0,  '+
                 ' SerialNumber   VARCHAR(255) NULL DEFAULT NULL,  '+
                 ' PQAID          INT(11) NULL DEFAULT "0",  '+
                 ' PQABatchID     INT(11) NULL DEFAULT "0",  '+
                 ' PQABinID       INT(11) NULL DEFAULT "0",  '+
                 ' PQASNID        INT(11) NULL DEFAULT "0",  '+
                 ' Transdate      DATETIME NULL DEFAULT NULL,  '+
                 ' Qty            Double Null Default 0,  '+
                 ' Batchnumber    VARCHAR(255) NULL DEFAULT NULL,  '+
                 ' TruckLoadNo    VARCHAR(255) NULL DEFAULT NULL,  '+
                 ' Expirydate     DAteTime NULL DEFAULT NULL,  '+
                 ' binLocation    VARCHAR(255) NULL DEFAULT NULL,  '+
                 ' Binnumber      VARCHAR(255) NULL DEFAULT NULL,  '+
                 ' TransType      VARCHAR(50) NULL DEFAULT NULL,  '+
                 ' Alloctype      VARCHAR(3) NULL DEFAULT NULL,  '+
                 ' Status         VARCHAR(30) NULL DEFAULT NULL,  '+
                 ' SMID           INT(11) NULL DEFAULT "0",  '+
                 ' SMEntryType    VARCHAR(255) NULL DEFAULT NULL,  '+
                 ' AssetID        INT(11) NULL DEFAULT "0",  '+
                '	IsinternalSale ENUM("T","F") Default "F", '+
                '	saleconverted ENUM("T","F") Default "F", '+
                 ' mstimeStamp    TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  '+
                 ' PRIMARY KEY (ID),  '+
                 ' UNIQUE INDEX KeyIDX (ProductID, DepartmentId,  UOMID, SerialNumber) , '+
                '	INDEX transdate (transdate), '+
                '	INDEX PQABatchID (PQABatchID), '+
                '	INDEX PQABinID (PQABinID), '+
                '	INDEX PQASNID (PQASNID))  COLLATE="utf8_general_ci" ENGINE=MyISAM ;  ' + NL+

    '  	     /*30*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(11 , "-" , fiClassId);' + NL+
    '  	     /*31*/Truncate tmp_tbl_SerialnumberList;'+NL+
    ' 	     /*32*/insert ignore into tmp_tbl_SerialnumberList (ProductId, departmentId, uomid, Serialnumber)  '+
                  ' select distinct pqa.ProductID, pqa.DepartmentID, pqa.UOMID , pqasn.Value as serialnumber    '+
                  ' from tmp_tbl_pqadetails pqasn    '+
                  ' inner join  tmp_tbl_pqa  pqa on pqasn.PQAID = pqa.pqaid   where pqatype ="SN"  and pqa.DepartmentId = fiClassId ; ' + NL+

    '  	     /*33*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(12 , "-" , fiClassId);' + NL+
    '        /*34*/drop table if exists tmp_tbl_SerialnumberList1;'+NL+
    '        /*35*/CREATE TABLE tmp_tbl_SerialnumberList1 ( '+
                    '	ID INT(11) NOT NULL AUTO_INCREMENT, '+
                    '		ProductID INT(11) NULL DEFAULT 0, '+
                    '		DepartmentId INT(11) NULL DEFAULT 0, '+
                    '		uomid INT(11) NULL DEFAULT 0, '+
                    '		serialnumber VARCHAR(100) NULL DEFAULT "", '+
                    '		transdate DATETIME NULL DEFAULT NULL, '+
                    '		qty double NOT NULL DEFAULT 0, '+
                    '		PRIMARY KEY (ID), '+
                    '		INDEX ProductID_DepartmentId_uomid_value (ProductID, DepartmentId, uomid, serialnumber)) COLLATE="utf8_general_ci" ENGINE=myisam;'+NL+

    '      /*36*/insert ignore into tmp_tbl_SerialnumberList1 (ProductID, DepartmentId , uomid ,  serialnumber ,transdate , Qty) '+
                  '  Select maxpqa.ProductID ,maxpqa.DepartmentId ,maxpqa.uomid,maxpqad.value as serialnumber , '+
                  '  max(maxpqa.transDate) transdate,  '+
                  '  sum( '+    SQL4QtyField(tAvailable , 'MaxPQA' , 'maxPQAD.qty' )+' )  as Qty '+
                  '  from tmp_tbl_pqadetails maxpqad   '+
                  ' inner join  tmp_tbl_pqa  maxpqa on maxpqa.PQAID = maxpqad.PQAID   '+
                  ' where maxpqad.PQAType = "SN"  and maxpqad.qty <> 0 and  (maxpqa.Active = "T"  or  maxpqa.transtype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE","TProcProgressIn"))     '+
                  ' group by maxpqa.ProductID ,maxpqa.DepartmentId ,maxpqa.uomid,maxpqad.value ;'+NL+
   '       /*37*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat("12-1-" , fiClassId);' + NL+
   ' 	     /*38*/update tmp_tbl_SerialnumberList T inner join  tmp_tbl_SerialnumberList1 T1 on T.productId = T1.productId '+
                                                                                         ' and T.DepartmentId = T1.DepartmentId '+
                                                                                         ' and T.uomid = T1.uomid '+
                                                                                         ' and T.serialnumber = T1.serialnumber '+
                                                                                         ' Set T.transDate = T1.transdate, T.Qty = T1.Qty; '+NL+
   '       /*39*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(13 , "-" , fiClassId);' + NL+
   '       /*40*/drop table if exists tmp_tbl_SerialnumberList1;'+NL+

(*    ' 	     /*33*/update tmp_tbl_SerialnumberList T Set Transdate = (Select max(maxpqa.transDate)    '+
                  '  from tmp_tbl_pqadetails maxpqad   '+
                  ' inner join  tmp_tbl_pqa  maxpqa on maxpqa.PQAID = maxpqad.PQAID   '+
                  ' where maxpqad.PQAType = "SN"  and maxpqad.qty <> 0 and  (maxpqa.Active = "T"  or  maxpqa.transtype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE","TProcProgressIn"))     '+
                  ' and maxpqa.ProductID = T.ProductID and maxpqa.DepartmentId = T.departmentId and maxpqa.uomid = T.uomid  '+
                  ' and maxpqad.value =T.serialnumber  )  '+
                  ' where T.transdate is null  and T.DepartmentId = fiClassId  ; ' + NL+


    '  	     /*34*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(13 , "-" , fiClassId);' + NL+

    ' 	     /*35*/update tmp_tbl_SerialnumberList T Set Qty = (Select   '+
                  '  sum( '+    SQL4QtyField(tAvailable , 'MaxPQA' , 'maxPQAD.qty' )+' )' +
                  ' from tmp_tbl_pqadetails maxpqad   '+
                  ' inner join  tmp_tbl_pqa  maxpqa on maxpqa.PQAID = maxpqad.PQAID   '+
                  ' where maxpqad.PQAType = "SN"  and maxpqad.qty <> 0 and  (maxpqa.Active = "T"  or  maxpqa.transtype in ("TProcTreePart","TProcTreePartIN","TProcTreePartINDONE","TProcProgressIn"))   '+
                  '  and maxpqa.ProductID = T.ProductID and maxpqa.DepartmentId = T.departmentId  and maxpqa.uomid = T.uomid  '+
                  '  and maxpqad.value =T.serialnumber )  where T.DepartmentId = fiClassId; ' + NL+*)

    '  	   /*41*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(14 , "-" , fiClassId);' + NL+


    '  	   /*42*/update tmp_tbl_SerialnumberList T  '+
                  ' inner join  tmp_tbl_pqa  pqa on T.productId = pqa.ProductId    '+
                                              ' and T.departmentId = pqa.departmentId '+
                                              ' and t.uomid = pqa.uomid  '+
                                              ' AND T.TRANSDATE = PQA.TRANSDATE'+
                  ' inner join tmp_tbl_pqadetails pqad on pqad.pqaid = pqa.pqaid and pqad.PQAType ="SN" and pqad.Value = T.serialnumber   '+
                  ' Set T.pqasnid = pqad.PQADetailID , t.pqaid = pqa.PQAID, t.Alloctype = pqa.Alloctype , T.TransType = pqa.TransType  '+
                  ' where  T.DepartmentId = fiClassId ; ' + NL+

    '  	   /*43*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(15 , "-" , fiClassId);' + NL+
    '  	   /*44*/update tmp_tbl_pqadetails Set  ParentRef ="" where ParentRef is null;'+NL+

    '  	   /*45*/update tmp_tbl_SerialnumberList T   '+
                  '  inner join tmp_tbl_pqadetails pqad on T.pqasnid = pqad.PQADetailID  '+
                  '  inner join tmp_tbl_pqadetails pqadp on pqad.ParentRef = pqadp.GlobalRef  '+
                  '  Set T.pqabinid = pqadp.PQADetailID  '+
                  '  where (pqad.ParentRef<> "" and  pqadp.pqatype = "Bin" ) '+
                  '  and T.DepartmentId = ficlassID   ; ' + NL+

    '  	   /*46*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(16 , "-" , fiClassId);' + NL+

    '  	   /*47*/update tmp_tbl_SerialnumberList T   '+
                  ' inner join tmp_tbl_pqadetails pqad on T.pqasnid = pqad.PQADetailID  '+
                  ' inner join tmp_tbl_pqadetails pqadp on pqad.ParentRef = pqadp.GlobalRef  '+
                  ' Set T.pqabatchid = pqadp.PQADetailID  '+
                  ' where pqad.ParentRef<> "" and  pqadp.pqatype = "Batch"  '+
                  ' and T.DepartmentId = ficlassId ; ' + NL+


    '  	   /*48*/update tmp_tbl_SerialnumberList T   '+
                  ' inner join tmp_tbl_pqadetails pqad on T.pqasnid = pqad.PQADetailID  '+
                  ' inner join tmp_tbl_pqadetails pqadp on pqad.ParentRef = pqadp.GlobalRef  '+
                  ' inner join tmp_tbl_pqadetails pqadpp on pqadp.ParentRef = pqadpp.GlobalRef  '+
                  ' Set T.pqabatchid = pqadpp.PQADetailID  '+
                  ' where pqad.ParentRef<> "" and  pqadpp.pqatype = "Batch"  '+
                  ' and T.DepartmentId = fiClassId ; ' + NL+

    '  	   /*49*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(17 , "-" , fiClassId);' + NL+

    '  	   /*50*/update tmp_tbl_SerialnumberList T  inner join tmp_tbl_pqadetails pqad on pqad.PQADetailID = T.PQABatchID  '+
                  ' Set T.Batchnumber = pqad.value , T.TruckLoadNo = pqad.TruckLoadNo , T.Expirydate = pqad.Expirydate '+
                  ' Where T.DepartmentId = fiClassId ; ' + NL+

    '  	   /*51*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(18 , "-" , fiClassId);' + NL+

    '  	   /*52*/update tmp_tbl_SerialnumberList T   '+
                                    ' inner join tmp_tbl_pqadetails pqad on pqad.PQADetailID = T.PQABinID  '+
                                    ' Left join `tblProductBin` PBin     on PBin.binId 	= pqad.BinID  '+
                                    ' Set T.Binlocation = PBin.Binlocation , T.Binnumber = PBin.Binnumber  '+
                                    ' Where T.DepartmentId = fiClassId ; ' + NL+

    '      /*53*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(19 , "-" , fiClassId);' + NL+


    '  	   /*54*/update tmp_tbl_SerialnumberList T '+
                                    ' inner join  tmp_tbl_pqa  pqa on pqa.pqaid = T.pqaid  '+
                                    ' left join tblstockmovementlines SML on PQA.transId = SML.StockmovementID and PQA.transLineId = SML.StockmovementLinesID and PQA.transType = "TStockMovementLines"   '+
                                    ' Left join tblstockmovement SM on SM.StockmovementID = SML.StockmovementID  '+
                                    ' Set T.SMID = SM.StockmovementID , T.SMEntryType = SM.StockmovementEntryType  Where (T.DepartmentId = fiClassId  ) ; ' + NL+

    '  	   /*55*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(20 , "-" , fiClassId);' + NL+

    '  	   /*56*/update tmp_tbl_SerialnumberList T '+
                                    ' Left join `tblfixedAssets` FA on FA.PartsId = T.ProducTID and FA.ClassId =T.DepartmentID and FA.Serial = T.serialnumber '+
                                    ' Set T.AssetID = FA.AssetID  ' +
                  ' Where (T.DepartmentId = fiClassId  ) ; ' + NL+

    '  	   /*56-1*/update tmp_tbl_SerialnumberList T '+
                                    ' inner join tblpqa pqa on pqa.pqaid = T.pqaid and pqa.transtype in (' +SalesTransTypes+',' +ManufactureTypes+') ' +
                                    ' inner join tblsales S on S.SaleId = Pqa.transId '+
                                    ' Set T.IsinternalSale = S.IsInternalOrder ,  ' +
                                    '     T.saleconverted  = S.Converted  ' +
                  ' Where (T.DepartmentId = fiClassId  ) ; ' + NL+

    '  	   /*57*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(21 , "-" , fiClassId);' + NL+

    '  	   /*58*/update tmp_tbl_SerialnumberList T  '+
                                    ' inner join tmp_tbl_pqadetails pqasn on pqasn.pqadetailid = T.pqasnid  '+
                                    ' left join tblfixedassets FA on T.AssetID = FA.AssetID  '+
                                    ' Set T.Status = PQAAllocType(T.AllocType, T.Transtype, pqasn.Qty, T.SMID, T.SMEntryType, FA.Serial,T.IsinternalSale,T.saleconverted) '+
                  ' Where (T.DepartmentId = fiClassId  ) ;'+NL+

    '  	   /*59*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(22 , "-" , fiClassId);' + NL+

    '  	   /*60*/update tmp_tbl_SerialnumberList T inner join tblunitsofmeasure UOM on UOM.unitID = T.UOMID  '+
                                    ' Set T.UOM = UOM.UnitName, T.UOMMultiplier = UOM.Multiplier ;'+NL+

    '  	   /*61*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(23 , "-" , fiClassId);' + NL+

    '  	   /*62*/insert ignore into  tblSerial_number_List  '+
                                    ' (ProductID,DepartmentId,UOMID,UOM,UOMMultiplier,SerialNumber,PQAID,PQABatchID,PQABinID,PQASNID,Transdate,Qty,Batchnumber,TruckLoadNo,Expirydate,binLocation,Binnumber,TransType,Alloctype,Status,SMID,SMEntryType,AssetID,mstimeStamp)  '+
                                    ' select ProductID,DepartmentId,UOMID,UOM,UOMMultiplier,SerialNumber,PQAID,PQABatchID,PQABinID,PQASNID,Transdate,Qty,Batchnumber,TruckLoadNo,Expirydate,binLocation,Binnumber,TransType,Alloctype,Status,SMID,SMEntryType,AssetID,mstimeStamp  '+
                                    ' from tmp_tbl_SerialnumberList t2 '+
                                    ' on duplicate key update PQAID = t2.PQAID, '+
                                                            ' PQABatchID = t2.PQABatchID,'+
                                                            ' PQABinID = t2.PQABinID,'+
                                                            ' PQASNID = t2.PQASNID,'+
                                                            ' Transdate = t2.Transdate,'+
                                                            ' Qty = t2.Qty,'+
                                                            ' TransType = t2.TransType,'+
                                                            ' Alloctype = t2.Alloctype,'+
                                                            ' Status = t2.Status,'+
                                                            ' SMID = t2.SMID,'+
                                                            ' SMEntryType = t2.SMEntryType,'+
                                                            ' AssetID = t2.AssetID,'+
                                                            ' mstimeStamp = t2.mstimeStamp;  ' + NL+
    '  	   /*63*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(24 , "-" , fiClassId);' + NL+

    '  	   /*64*/update  tmp_tbl_SN_Ctr Set Done ="T" where classid = fiClassId;' + NL+

    '  	   /*65*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = concat(25 , "-" , fiClassId);' + NL+


    ' 	            END LOOP the_loop; ' + NL+
    '   /*66*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "26";' + NL+

    '   /*67*/DROP TABLE if exists tblSerial_number_List_Available;' + NL+

    '   /*68*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "27";' + NL+

    '   /*69*/Create TABLE  tblSerial_number_List_Available Like tblSerial_number_List;' + NL+

    '   /*69*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "28";' + NL+

    '   /*70*/Insert ignore into tblSerial_number_List_Available Select * from tblSerial_number_List where Status = "In-Stock" or Status = "New";' + NL+

    '   /*71*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "29";' + NL+

    '   /*72*/DROP TABLE if exists  tmp_tbl_pqa  ;' + NL+

    '   /*73*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "30";' + NL+

    '   /*74*/DROP TABLE if exists tmp_tbl_pqadetails ;' + NL+

    '   /*75*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "31";' + NL+

    '   /*76*/DROP TABLE if exists tmp_tbl_SN_Ctr ;' + NL+

    '   /*77*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "32";' + NL+

    '   /*78*/Create table  tmp_tbl_SN_Ctr  Select Distinct departmentId as ClassID , "F" as Done from tblpqa  Where  departmentId <>0;' + NL+

    '   /*78*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "33";' + NL+

    '   /*80*/insert ignore into tblUpdate_Serial_NumberHistory Set Tablename = "tblSerial_number_List", LastUpdateSerialnumberDatetime = now() , updateStatus =2  on duplicate key update LastUpdateSerialnumberDatetime = now() , updateStatus =3; ' + NL+
    '   /*81*/insert ignore into tblUpdate_Serial_Number_Listlog Set UpdateSerialnumberListLog = "34";' + NL+
    ' end if; ' + NL+
    ' END; // ' + NL+
    ' DELIMITER ; ';
end;
function SPField_TypeSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS Field_Type; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION Field_Type(aTablename VARCHAR(255),  ' + NL+
    ' 	aDBName VARCHAR(255),  ' + NL+
    ' 	aFieldname VARCHAR(255))   ' + NL+
    ' RETURNS varchar(255) ' + NL+
    ' begin ' + NL+
    '  Declare sFieldtype varchar(255); ' + NL+
    '  Declare  curFieldtype cursor for select Data_type from INFORMATION_SCHEMA.COLUMNS   where table_name = aTablename and  Table_schema = aDBName and column_name = aFieldname; ' + NL+
    '  open curFieldtype; ' + NL+
    '  Fetch curFieldtype  into sFieldtype ; ' + NL+
    '  return sFieldtype; ' + NL+
    ' end;   // ' + NL+
    ' DELIMITER ; ';
end;
function SPPreftypeToSQLTypeSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS PreftypeToSQLType; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION PreftypeToSQLType(Dbtype VARCHAR(255))   ' + NL+
    ' RETURNS varchar(255) ' + NL+
    ' begin ' + NL+
    '     if DBtype ="ftBoolean" then Return "enum"; ' + NL+
    ' elseif DBtype ="ftDate" then Return "date";  ' + NL+
    ' elseif DBtype ="ftDateTime" then Return "datetime"; ' + NL+
    ' elseif DBtype ="ftFloat" then Return "double"; ' + NL+
    ' elseif DBtype ="ftInteger" then Return "int"; ' + NL+
    ' elseif DBtype ="ftLargeint" then Return "bigint"; ' + NL+
    ' elseif DBtype ="ftMemo" then Return "longtext"; ' + NL+
    ' elseif DBtype ="ftString" then Return "varchar"; ' + NL+
    ' elseif DBtype ="ftWord" then Return "double"; ' + NL+
    ' else Return "varchar";end if ; ' + NL+
    ' end;   // ' + NL+
    ' DELIMITER ; ';
end;

function SPvosCodeToMsgSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS vosCodeToMsg; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION vosCodeToMsg(vosCode int(11))   ' + NL+
    ' RETURNS varchar(255) ' + NL+
    ' begin ' + NL+
    '     if vosCode ='+ inttostr(vosNotValidated)+' then Return "Not Validated"; ' + NL+
    ' elseif vosCode ='+ inttostr(vosMultipleFxinLine)+' then Return "Order Items has Multiple Currencies";  ' + NL+
    ' elseif vosCode ='+ inttostr(vosMultipleFxinOrder)+' then Return "Order has Multiple Currencies";  ' + NL+
    ' elseif vosCode ='+ inttostr(vosFxVarriesinLinenTax)+' then Return "Line and Tax has different Currency";  ' + NL+
    ' elseif vosCode ='+ inttostr(vosInvalidTaxCode)+' then Return "Invalid TaxCode";  ' + NL+
    ' elseif vosCode ='+ inttostr(vosInvalidProduct)+' then Return "Invalid Product";  ' + NL+
    ' elseif vosCode ='+ inttostr(vosOK)+' then Return "OK";  ' + NL+
    ' else Return "";' +NL+
    ' end if;'+NL+
    ' end;   // ' + NL+
    ' DELIMITER ; ';
end;
(*function SPIntParamSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS IntParam; ' + NL+
    ' CREATE FUNCTION IntParam()   ' + NL+
    ' returns INTEGER DETERMINISTIC NO SQL return @IntParam;';
end;*)

(*function VWProductUOMSQL: string;
begin
  Result :=
    ' DROP View IF EXISTS ProductUOM; ' + NL+
    ' CREATE View ProductUOM  AS  ' + NL+
    ' select u.UnitID AS UnitID, ' + NL+
          ' u.PartID , ' +NL+
          ' u.UnitName AS UnitName, ' + NL+
          ' u.Multiplier AS Multiplier, ' + NL+
          ' u.UnitDescription AS UnitDescription, ' + NL+
          ' u.BaseUnitName AS BaseUnitName  ' + NL+
          ' from tblunitsofmeasure u  ' + NL+
          ' where ((u.Active = "T") and (ifnull(u.PartID,0) = IntParam()))  ' + NL+
    ' union all  ' + NL+
    ' select u.UnitID AS UnitID, ' + NL+
          ' u.PartID , ' +NL+
          ' u.UnitName AS UnitName, ' + NL+
          ' u.Multiplier AS Multiplier, ' + NL+
          ' u.UnitDescription AS UnitDescription, ' + NL+
          ' u.BaseUnitName AS BaseUnitName  ' + NL+
          ' from tblunitsofmeasure u  ' + NL+
          ' where ((u.Active = "T")  ' + NL+
          ' and (ifnull(u.PartID,0) = 0)  ' + NL+
          ' and (not(u.UnitName in (select tblunitsofmeasure.UnitName  ' + NL+
                ' from tblunitsofmeasure where (ifnull(tblunitsofmeasure.PartID,0) = IntParam())))))  ' + NL+
    ' order by UnitID desc,UnitName; ';
end;*)
(*function SPPrefDateToDateSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS PrefDateToDate; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION PrefDateToDate(Prefdate VARCHAR(255))   ' + NL+
    ' RETURNS DATE ' + NL+
    ' begin ' + NL+
    '     return DATE_ADD(STR_TO_DATE("1899-12-30","%Y-%m-%d"), INTERVAL round(convert(Prefdate , decimal)) DAY) ;  ' + NL+
    ' end;   // ' + NL+
    ' DELIMITER ; ';
end;
function SPPrefDateTimeToDateTimeSQL: string;
begin
  Result :=
    ' DROP FUNCTION IF EXISTS PrefDateTimeToDateTime; ' + NL+
    ' delimiter // ' + NL+
    ' CREATE FUNCTION PrefDateTimeToDateTime(Prefdate VARCHAR(255))   ' + NL+
    ' RETURNS DATETIME ' + NL+
    ' begin ' + NL+
    '  declare fd Date;    ' + NL+
    '  declare fdi decimal;    ' + NL+
    '  set fd = DATE_ADD(STR_TO_DATE("1899-12-30","%Y-%m-%d"), INTERVAL round(convert(Prefdate , decimal)) DAY) ;     ' + NL+
    '  set fdi = Prefdate- round(Prefdate);    ' + NL+
    '  while fdi - round(fdi,6) <> 0 do set fdi = fdi*10; end while;    ' + NL+
    '  return DAte_add(fd, interval round(fdi) second);    ' + NL+
    ' end;   // ' + NL+
    ' DELIMITER ; ';
end;*)



function SPProductQtySumUpdateSQL(fConnection:TCustomMyConnection ): string;
    Function Spaces :String; begin result := '    '; end;
    Function LogProcesstime:String;
    begin
      REsult :=
        Spaces +Spaces +Spaces +Spaces +'update  tblProductQtySumProgress Set Seconds = FormatSeconds(0, SecondsBetween(DT, now())) where Progresscode = fiProgresscode; '+NL;
    end;
    Function Progressmsg(Const aMsg:String):String;
     begin
      result := LogProcesstime + Spaces +Spaces +Spaces +Spaces +'Set fiProgresscode = fiProgresscode +1;' +NL+
        Spaces +Spaces +Spaces +Spaces +'Insert ignore into tblProductQtySumProgress ( Progresscode , ProgressMsg) Values (fiProgresscode, '+quotedstr(aMsg)+');'+NL+
        Spaces +Spaces +Spaces +Spaces +'Set Dt = Now();'+NL;
     end;

    Function DevProgressmsg(Const aMsg:String):String;
     begin
      result := Spaces +Spaces +Spaces +Spaces +'if Devmode ="T" then '+
                      'Insert ignore into tblProductQtySumProgress ( Progresscode , ProgressMsg) Values (100+fiProgresscode, '+aMsg+');'+
                'end if;'+NL;
     end;

    Function AddComment(const Value:String):String;
    begin
      Result := '-- ' + Value +NL+
              Progressmsg(Value);
    end;
    Function CountSOBOInAvailable:Boolean;
    var
      qry: TERPQuery;
    begin
      if fconnection = nil then
        REsult := Appenv.companyprefs.CountSOBOInAvailable
      else begin
        qry := DbSharedObjectsObj.DbSharedObj.GetQuery(fconnection);
        try
          qry.SQL.text := 'Select FieldValue from tbldbpreferences where Name = "CountSOBOInAvailable"';
          qry.open;
          result := sametext(qry.Fieldbyname('FieldValue').asString ,'T');
        finally
          DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
        end;
      end;
    end;
begin
  Result :=
    'DROP PROCEDURE IF EXISTS ProductQtySumUpdate; ' + NL+
    'delimiter // ' + NL+
    'CREATE PROCEDURE ProductQtySumUpdate(aProductID Int(11), DevMode Varchar(1))   ' + NL+
    'BEGIN  ' + NL+
    '  Declare fiProgresscode  Int(11) ;'+NL+
    '  Declare dt Datetime;'+NL+
    '  Declare aMsTimestamp1 timestamp;'+NL+
    '  Declare aMsTimestamp2 timestamp;'+NL+
    '  Declare  CurMsTimestamp1 Cursor for Select Max(mstimeStamp) mstimestamp from tblProductQtySum; ' + NL+
    '  Declare  CurMsTimestamp2 Cursor for Select Max(mstimeStamp) mstimestamp from tblpqa; ' + NL+
    '  open CurMsTimestamp1 ; ' + NL+
    '  Fetch CurMsTimestamp1  into aMsTimestamp1 ; ' + NL+
    '  open CurMsTimestamp2 ; ' + NL+
    '  Fetch CurMsTimestamp2  into aMsTimestamp2 ; ' + NL+

    '  if aMsTimestamp1 <>  aMsTimestamp2 then   ' + NL+
    Spaces +'Set fiProgresscode =  0;'+NL+
    Spaces +'Set Dt = Now();'+NL+
    Spaces +'DROP TABLE if EXISTS tblProductQtySumProgress; ' + NL+
    Spaces +'CREATE TABLE tblProductQtySumProgress (   '+
           ' ID int(11) NOT NULL AUTO_INCREMENT,   '+
           ' Progresscode int(11) null DEFAULT NULL,  '+
           ' ProgressMsg varchar(255) null default null ,  '+
           ' Seconds varchar(100) null default null,' +
           ' mstimestamp TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, PRIMARY KEY (ID)   ) ENGINE=MyISAM DEFAULT CHARSET=utf8 ;' +NL+

//    Spaces +''+ Progressmsg('Scan for Product Quntity')+
    Spaces +'update tblProductQtySum Set needsupdate ="F";'+NL+
//    Spaces +''+ Progressmsg('Looking For New Transactions')+

    AddComment('Temprary Table for Changed Products')+
    Spaces +'DROP TABLE if EXISTS tmp_tblProductQtySumProducts; ' + NL+
    Spaces +'CREATE TABLE tmp_tblproductqtysumproducts ( '+
           ' ID int(11) NOT NULL AUTO_INCREMENT, '+
           ' productId int(11) null DEFAULT NULL, '+
           ' departmentId int(11) null DEFAULT NULL, '+
           ' UOMID int(11) null DEFAULT NULL, '+
           ' PRIMARY KEY (ID), '+
           ' UNIQUE KEY productId_departmentId_UOMID (productId,departmentId,UOMID)) ENGINE=MyISAM DEFAULT CHARSET=utf8; '+NL+
    AddComment('New PQAs')+
    Spaces +'insert ignore into tmp_tblProductQtySumProducts (productId, departmentId ,UOMID  )' + NL+
    Spaces +'      SELECT ' + NL+
    Spaces +'      distinct pqa.productId , pqa.departmentId, pqa.UOMID ' + NL+
    Spaces +'      FROM tblpqa pqa ' + NL+
    Spaces +'      LEFT JOIN tblProductQtySum pqasum ON pqa.ProductID = pqasum.ProductId AND pqa.DepartmentID = pqasum.DepartmentID AND pqa.UOMID = pqasum.UOMID ' + NL+
    Spaces +'      WHERE pqasum.ProductQtySumId is null and (aProductID =0 or pqa.ProductID = aProductID); ' + NL+

    DevProgressmsg('concat("tmp_tblProductQtySumProducts:" , (Select count(*) from tmp_tblProductQtySumProducts))')+NL+

    AddComment('New Stock Transfer PQAs')+
    Spaces +'insert ignore into tmp_tblProductQtySumProducts (productId, departmentId ,UOMID  )' + NL+
    Spaces +'      SELECT ' + NL+
    Spaces +'      distinct pqa.productId , pqa.departmentId, pqa.UOMID ' + NL+
    Spaces +'      FROM tblstocktransferentrypqa pqa ' + NL+
    Spaces +'      LEFT JOIN tblProductQtySum pqasum ON pqa.ProductID = pqasum.ProductId AND pqa.DepartmentID = pqasum.DepartmentID AND pqa.UOMID = pqasum.UOMID ' + NL+
    Spaces +'      WHERE pqasum.ProductQtySumId is null and (aProductID =0 or pqa.ProductID = aProductID); ' + NL+

    Spaces +'' + DevProgressmsg('concat("tmp_tblProductQtySumProducts:" , (Select count(*) from tmp_tblProductQtySumProducts))')+NL+

    AddComment('Changed PQAs')+
//    Spaces +'' +Progressmsg('Looking For Changed Transactions')+
    Spaces +'insert ignore into tmp_tblProductQtySumProducts (productId, departmentId ,UOMID  )' + NL+
    Spaces +'      SELECT ' + NL+
    Spaces +'      distinct pqa.productId , pqa.departmentId, pqa.UOMID ' + NL+
    Spaces +'      FROM tblpqa pqa ' + NL+
    Spaces +'      inner JOIN tblProductQtySum pqasum ON pqa.ProductID = pqasum.ProductId AND pqa.DepartmentID = pqasum.DepartmentID AND pqa.UOMID = pqasum.UOMID ' + NL+
    Spaces +'      WHERE pqa.mstimestamp > aMsTimestamp1 and pqasum.mstimestamp < pqa.mstimestamp and (aProductID =0 or pqa.ProductID = aProductID); ' + NL+

    DevProgressmsg('concat("tmp_tblProductQtySumProducts:" , (Select count(*) from tmp_tblProductQtySumProducts))')+NL+

    AddComment('Changed Stock Transfer PQAs')+
    Spaces +'insert ignore into tmp_tblProductQtySumProducts (productId, departmentId ,UOMID  )' + NL+
    Spaces +'      SELECT ' + NL+
    Spaces +'      distinct pqa.productId , pqa.departmentId, pqa.UOMID ' + NL+
    Spaces +'      FROM tblstocktransferentrypqa pqa ' + NL+
    Spaces +'      inner JOIN tblProductQtySum pqasum ON pqa.ProductID = pqasum.ProductId AND pqa.DepartmentID = pqasum.DepartmentID AND pqa.UOMID = pqasum.UOMID ' + NL+
    Spaces +'      WHERE pqa.mstimestamp > aMsTimestamp1 and pqasum.mstimestamp < pqa.mstimestamp and (aProductID =0 or pqa.ProductID = aProductID); ' + NL+
    DevProgressmsg('concat("tmp_tblProductQtySumProducts:" , (Select count(*) from tmp_tblProductQtySumProducts))')+NL+

    AddComment('List of Products that Needs Update')+
    Spaces +'insert ignore into tblProductQtySum (productId, departmentId ,UOMID  , needsupdate) Select productId, departmentId ,UOMID  , "T" as needsupdate from tmp_tblProductQtySumProducts ON DUPLICATE KEY UPDATE needsupdate ="T" ;' + NL+

    DevProgressmsg('concat("tblProductQtySum - All:" , (Select count(*) from tblProductQtySum))')+NL+
    DevProgressmsg('concat("tblProductQtySum - needsupdate:" , (Select count(*) from tblProductQtySum where needsupdate ="T"))')+NL+

//    Spaces +'' +Progressmsg('Read Product Quantities')+

    AddComment('Temporary Table for Product''s Current Quantities')+
    Spaces +'DROP TABLE if EXISTS tmp_tblProductQtySumQtys; ' + NL+
    Spaces +'CREATE TABLE tmp_tblproductqtysumqtys ( '+
           ' ID int(11) NOT NULL AUTO_INCREMENT, '+
           ' productId int(11) null DEFAULT NULL, '+
           ' departmentId int(11) null DEFAULT NULL, '+
           ' uomId int(11) null DEFAULT NULL, '+
           ' SOBO Double null DEFAULT NULL, '+
           ' Available Double null DEFAULT NULL, '+
           ' InStock Double null DEFAULT NULL, '+
           ' AllocatedSO Double null DEFAULT NULL, '+
           ' InvBO Double null DEFAULT NULL, '+
           ' POBO Double null DEFAULT NULL, '+

           ' OnBuild Double null DEFAULT NULL, '+
           ' Building Double null DEFAULT NULL, '+
           ' OnTransitin Double null DEFAULT NULL, '+
           ' OnTransitout Double null DEFAULT NULL, '+
           ' PRIMARY KEY (ID), '+
           ' UNIQUE KEY productId_departmentId_UOMID (productId,departmentId,uomId) '+
           ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8 ;'+NL+

//    Spaces +'' +Progressmsg('Summarise Product Quantities')+
    AddComment('Quatities from PQA  into Temporary Table')+
    Spaces +'insert ignore into  tmp_tblProductQtySumQtys (productId,departmentId,uomId,SOBO,Available,InStock,AllocatedSO,InvBO,POBO,OnBuild,Building)' + NL+
    Spaces +'     SELECT P.PARTSID          As ProductId,  PQA.departmentId,  PQA.uomId, ' + NL+
    Spaces +'     Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tSOBO)       +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As SOBO, ' + NL+
             //iif(AppEnvVirt.Bool['CompanyPrefs.CountSOBOInAvailable'],
             iif(CountSOBOInAvailable,
        Spaces +'     Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tAvailable ) +' - ' +
                                                    ProductQtylib.SQL4Qty( tSoBo) +',0.0) ,' +  IntToStr(tcConst.GeneralRoundPlaces)+')  as Available,',
        Spaces +'     Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tAvailable ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as Available,')  + NL+
    Spaces +'     Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tInstock)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As InStock, ' + NL+
    Spaces +'     Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tSO)         +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As AllocatedSO, ' + NL+
    Spaces +'     Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tInvBO)      +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As InvBO, ' + NL+
    Spaces +'     Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tPOBO)       +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As POBO, ' + NL+
    Spaces +'     Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tOnBuild)    +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As OnBuild, ' + NL+
    Spaces +'     Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty( tBuilding)   +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As Building ' + NL+

    Spaces +'     FROM ' + trim(replacestr(ProductTables(tProductList) , NL , NL +Spaces+Spaces )) + NL+
    Spaces +'     inner join tblProductQtySum TPQA on TPQA.needsupdate ="T" and PQA.productId = TPQA.productId and PQA.departmentId = TPQA.DepartmentId and PQA.UOMId = TPQA.UOMID  ' + NL+
    Spaces +'     GROUP BY PQA.ProductId, PQA.DepartmentID, PQA.UOMID ;'+ NL+
    DevProgressmsg('concat("tmp_tblProductQtySumQtys:" , (Select count(*) from tmp_tblProductQtySumQtys))')+NL+

    AddComment('Update Quatities Temporary Table')+
//    Spaces +'' +Progressmsg('Update Summarised Product Quantities')+
    Spaces +'update tblProductQtySum T1 inner join   tmp_tblProductQtySumQtys T2 on    T1.productId = T2.productId and T1.departmentId = T2.DepartmentId and T1.UOMId = T2.UOMID ' + NL+
    Spaces +'      Set T1.InStock = T2.InStock , ' + NL+
    Spaces +'      T1.Available = T2.Available ,' + NL+
    Spaces +'      T1.POBO = T2.POBO ,' + NL+
    Spaces +'      T1.SOBO = T2.SOBO,' + NL+
    Spaces +'      T1.InvBO = T2.InvBO,' + NL+
    Spaces +'      T1.OnBuild = T2.OnBuild,' + NL+
    Spaces +'      T1.Building = T2.Building;' + NL+

    AddComment('Quatities from Stock Transfer PQA  into Temporary Table')+
//    Spaces +'' +Progressmsg('Summarise Product Quantities On Transit')+
    Spaces +'truncate tmp_tblProductQtySumQtys; ' + NL+
    Spaces +'insert ignore into  tmp_tblProductQtySumQtys (productId,departmentId,uomId,OnTransitin,OnTransitout)' + NL+
    Spaces +'     SELECT  P.PARTSID          As ProductId,  PQA.departmentId, PQA.uomId, ' + NL+
    Spaces +'     Round(IF(P.PARTTYPE = "INV",' +SQL4QtyField(tOnTransitin, '', 'QTY')  +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As OnTransitin, ' + NL+
    Spaces +'     Round(IF(P.PARTTYPE = "INV",' +SQL4QtyField(tOnTransitout, '', 'QTY')   +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')   As OnTransitout ' + NL+
    Spaces +'     FROM ' + trim(replacestr(ProductTables(tProductList) , NL , NL + Spaces +Spaces ))  + NL+
    Spaces +'     inner join tblProductQtySum TPQA on TPQA.needsupdate ="T" and PQA.productId = TPQA.productId and PQA.departmentId = TPQA.DepartmentId and PQA.UOMId = TPQA.UOMID  ' + NL+
    Spaces +'     GROUP BY PQA.ProductId, PQA.DepartmentID, PQA.UOMID ;'+ NL+
    DevProgressmsg('concat("tmp_tblProductQtySumQtys:" , (Select count(*) from tmp_tblProductQtySumQtys))')+NL+

//    Spaces +'' +Progressmsg('Update Summarised Product Quantities On Transit')+
    AddComment('Update Stock Transfer Quatities Temporary Table')+
    Spaces +'update tblProductQtySum T1 inner join   tmp_tblProductQtySumQtys T2 on    T1.productId = T2.productId and T1.departmentId = T2.DepartmentId and T1.UOMId = T2.UOMID ' + NL+
    Spaces +'      Set T1.OnTransitin = T2.OnTransitin,' + NL+
    Spaces +'      T1.OnTransitOut = T2.OnTransitOut;' + NL+

    AddComment('Delete Temporary Tables')+
//    Spaces +'' +Progressmsg('Delete Temporary Tables')+
    Spaces +'DROP TABLE if EXISTS tmp_tblProductQtySumProducts;' + NL+
    Spaces +'DROP TABLE if EXISTS tmp_tblProductQtySumQtys;' + NL+
    '  end if;' + NL+

    '  CLOSE CurMsTimestamp1;'+NL+
    '  CLOSE CurMsTimestamp2;'+NL+
    Progressmsg('Done')+
    'END; // ' + NL+
    'DELIMITER ; ';
end;
Function SPStsPhaseCodetoDescSQL:String;
begin
      Result:= 'DROP FUNCTION IF EXISTS StsPhaseCodetoDesc; ' + NL+
          ' delimiter // ' + NL+
          ' CREATE FUNCTION StsPhaseCodetoDesc(StsPhaseCode VARCHAR(1) )   ' + NL+
          ' RETURNS VARCHAR(50)   ' + NL+
          ' BEGIN  ' + NL+
                  ' if StsPhaseCode  = "I"  then RETURN "Immature";  ' + NL+
              ' elseif StsPhaseCode  = "V"  then RETURN "Vegetative" ;  ' + NL+
              ' elseif StsPhaseCode  = "F"  then RETURN "Flowering";  ' + NL+
              ' elseif StsPhaseCode  = "H"  then RETURN "Harvest";  ' + NL+
              ' elseif StsPhaseCode  = "P"  then RETURN "Product";  ' + NL+
              ' elseif StsPhaseCode  = "D"  then RETURN "Destroy";  ' + NL+
              ' else RETURN "";  end if; ' + NL+
          ' END; // ' ;

end;

end.
