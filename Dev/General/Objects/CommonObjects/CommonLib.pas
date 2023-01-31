unit CommonLib;
{$I ERP.inc}
{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 11/03/05  2.00.01 IJB  Added windows environment valiable functions.
 14/03/05  2.00.02 IJB  Moved windows system functions to SystemLib

 18/03/05  2.00.03 DJH  Created two new functions:-
                        1) ConvertMSTimeStampStrToDate()
                        2) ConvertDateTimeToMSTimeStampStr
 18/04/05  2.00.04 IJB  Added NumCharOnly function;
 03/05/05  2.00.05 IJB  Added Round function
 13/05/05  2.00.06 IJB  Added ForeignToLocal and LocalToForeign functions.
 01/06/05  2.00.07 ISB  Added GetClassNameHierarchy function;
 09/06/05  2.00.08 ISB  Added DivZer function;
 24/06/05  2.00.09 ISB  Added API function GetWindowsVersion;
 25/07/05  2.00.10 DMS  Added string function ValueListed
 08/09/05  2.00.11 IJB  Added Replace/ReinstateNonAlphaNumeric functions
 15/09/05  2.00.12 IJB  Added StringToInt and StringToFloat functions.
 22/09/05  2.00.13 DSP  Added SetControlFocus function.
 17/10/05  2.00.14 IJB  Added GetAmountInc function.
 17/11/05  2.00.15 IJB  Added XML functions.
 02/12/05  2.00.16 DSP  Added function GetComponentByClassType.
 12/12/05  2.00.17 MV   Added function FindExistingComponent
 04/01/06  2.00.18 IJB  Changed GetComponentByClassName to use single instance by default.
 13/01/06  2.00.19 IJB  Added FormStillOpen function.
 10/08/06  2.00.20 BJ   variable and functions added to store the export to XML file name.
 18/09/06  2.00.21 BJ   GetAmountEX function added
                        Note: getamountEx and getAmountinc are re-defined(same definition) in DNMLib as well.
                        As there are many units using it from dnmLib, I haven;t deleted it from there.
}

interface

uses
 XMLDoc,  Classes, Forms, DateUtils, Controls, Variants{, SoundObj},
  db,wwdblook, Wwdbgrid,  WwDbiGrd , Dialogs, Messages, TaskDialog,Graphics,
 Windows,  IntegerListObj, XMLIntf , sysutils;


// --------- String Functions -----------------------------------------------
type
  TProc          = procedure of object;
  TBoolFunc      = function (Sender: TObject): Boolean of Object;

TContactType = (tAll=0, tcustomercontact=1, tSuppliercontact=2, tEmployeecontact=3);

function Empty(const s: string): boolean;
function EmptyNumber(const s: string): boolean;
function CharCounter(const char, TestString: string): integer;
function SubStr(const fMainString: string; const Delimeter: string = ','; const fPosition: double = 1): string;
Function CustomInputFloat(const fCaption , fMessage:String;Defaultvalue:String='') : Double;
Function CustomInputBoolean(const fCaption , fMessage:String) : Boolean;
Function CustomInputInteger(const fCaption , fMessage:String;Defaultvalue:String=''; DefaultResult:Integer = -1) : Integer;
Function CustomInputString(const fCaption , fMessage,Defaultvalue:String) : String;
Function CustomInputPassword(const fCaption , fMessage,Defaultvalue:String) : String;
function StrValue(const sValue: string): double;
function ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
Procedure StrtoStringlist(const Source, delim:String; var St:TStringList);
function ExtractLabelSuffix(const Source: string): string;
function IsNumber(const s: string): boolean;
Function ISInteger(const s: string): boolean;
Function ISEvenNo(const s: string): boolean;
function ConcatStrings(const Values:Array of string ; Delimstr:String):String;
function searchArray(const SearchingArray:Array of string ; Searchvalue:String;Casesensitive:Boolean =true):Integer; overload;
function searchArray(const SearchingArray:Array of integer; Searchvalue:integer):Integer;overload
function searchArray(const SearchingArray:Array of TDatetime; Searchvalue:Tdatetime):Integer;overload
function LeftPadStr(const s: string; const places: integer; const padChar: char): string;
function NumCharOnly(Key: char): char;
function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
Function UnQuoteStr(const Value :STring):String;
function SeparateWords(const s: string): string;
function CurDatestr:String;
(*function StripQuotes(const sString: string): string;*)
function ValueListed(const S: string; const CaseSensitive: boolean; const Values: array of string): boolean; overload;
function StringToFloat(const aString: string): double;
function StringToInt(const aString: string): integer;
function RemoveInvalidAlphaNumericCharacters(const sValue: string): string;
Function ReplicateStr(Const Repeatingchar :String; const iCount :Integer) :String;
Function TruncateStr(Const Value :String ; const Leng :Integer; TrimResult :Boolean = true): String;
function StartsWith(const Value, substr:String):Boolean;
function Stringcontains(const Value, substr:String):Boolean;
function InToStrWith0(const value :Integer ; const Leng :Integer):String;
procedure RemoveBlankLines(const Strings: TStrings); overload;
function RemoveBlankLines(const aString: string): string; overload;
function IsQuotedStr(const aString: string): boolean;
//function BooleanToStr(const Value:Boolean):String;
function BooleanToString(const Value:Boolean):String;
function BooleanToYN(const Value:Boolean):String;
function StrToBoolean(const Value:String):Boolean;
Function ArrayToString(const Value :Array of String):String;

  // --------- Date Functions ------------------------------------------------
function ConvertMSTimeStampStrToDate(const msTimeStamp: string): TDateTime;
function ConvertDateTimeToMSTimeStampStr(dtDate: TDateTime): string;
Function WeekDay(DayName :String) :Integer; overload;
Function WeekDay(DayNo :Integer) :String; overload;
Function IsSunday(Value:TDateTime):Boolean;
Function IsMonday(Value:TDateTime):Boolean;
Function IsTuesday(Value:TDateTime):Boolean;
Function IsWednesday(Value:TDateTime):Boolean;
Function IsThursday(Value:TDateTime):Boolean;
Function IsFriday(Value:TDateTime):Boolean;
Function IsSaturday(Value:TDateTime):Boolean;
function  CurrentWeekEndDate(DateVal :TDatetime) :TDatetime;
function MinutesBetween(const ANow, AThen: TDateTime): Integer;
Function DatewithHourof(Const Dt:TDatetime):TDateTime;
function MysqlDateStrToDate(const MsqlDate: string): TDateTime;
function DateTimeToMysqlDateStr(const aDateTime: TDateTime): string;
function MonthNameToNumber(const Month: string): integer;
function MonthNumberToName(const Month: Integer): String;
function NowUTC: TDateTime;
function DateUTC: TDateTime;
Function LocalTimezoneInfo :   TTimeZoneInformation;
function SecondsToTime(secs: integer; CalcDays:boolean =False;details:Boolean=False;Resultwhen0:String = ''): string;
function TimeToSeconds(const value:String): Integer;
function MilliSecondsTotime(MilliSecs:Integer):String;

function DayStart(Dt:TDatetime):TDatetime;
function DayEnd(Dt:TDatetime):TDatetime;
function SecsInaWorkingDay: Integer;

  // --------- Number Functions ------------------------------------------------
function RoundCurrency(const Value: double): currency;
function Round(const Value: double; places: word): double;
function ForeignToLocal(const ForeignAmount, Rate: double; const Places: integer = -1): double;
function LocalToForeign(const LocalAmount, Rate: double; const Places: integer = -1): double;
function DivZer(const x, y: extended): extended;
function IsNumeric(const s: string): boolean;
function IsNumbersOnly(const s: string): boolean;
(*Function isInteger(const s:String):boolean;*)
Function IsDate(const s:String; var dt:TDatetime):Boolean;
function ValueListed(const I: integer; const Values: array of integer): boolean; overload;
function GetAmountInc(const AmountEx: double; const TaxRate: double): double;
function GetAmountEx(const AmountInc: double; const TaxRate: double): double;
function GetRate(const AmountInc: double; const AmountEx: double): double;
Function GetPercent(const AmountInc: double;const AmountEx: double):Double;
Function IsInvProduct(Const PartType:String):Boolean;
// --------- General Procedures -----------------------------------------------

procedure StringToStream(const Text: String;
                         const Stream: TMemoryStream);
//procedure Setcolwidth(CurGrid:twwDBGrid; Adjustthewidest:Boolean =False);
//procedure Setcolwidths(CurGrid:twwDBGrid; Adjustthewidest:Boolean =False);
Procedure ReadonlyGrid(CurGrid:twwDBGrid);
Function  SplitField(TableAlias:STring; FieldName:STring;Position :Integer;Delimeter:String='^'):String;
Procedure ProcessingCursor(Apply :Boolean = True);
Procedure HandPointCursor(Apply :Boolean = True);
function ComponentName(Owner :Tcomponent ;compname:String):String;
function ControlName(Control :TComponent):String;
function MakeName(Const AOwner:TComponent; Const Value:String;StrtoRemove:String= '') :String;Overload;
function MakeName(const Value:String;StrtoRemove:String= ''):String;Overload;
function ValidFieldName(const aFieldName : string) : string;

  // --------- General Functions -----------------------------------------------
Function Isformvisible(const FormName :STring ): boolean;
Function FindFormInstance(const FormName :STring ):TForm;
//function GetAppForm(const FormName: string): TForm;
function GetComponentsForm(const aComponent: TComponent): TForm;
function FindControlClass(const OwnerComponent: TComponent; const SearchClass: string): TComponent;
function StatusAndToolbarHeight :Integer;
function FindChildComponent(const Owner: TComponent; const ComponentName: string): TComponent;
procedure ClearTList(const lst: TList; const iSize: integer);
procedure MFree(var p: Pointer; const lSize: longint);
function GetPCName: string;
function getOutGoingFileName(Prefix,Suffix , extension :String):String;
Function Validfilename(filename:String):String;

function GetMachineIdentification(const User, System, Network, Drives: boolean): string;
function GetFormUsableClientHeight(const aForm: TForm): integer;
function GetClassNameHierarchy(const aObject: TObject): string;
function GetUniqueName(const Name: string): string;
Function GetObjectProperty(aObj: TObject; aPropName: string):String;
procedure SetObjectProperty(aObj: TObject; aPropName: string; aValue: Variant);
procedure SetMethodProperty(aObj: TObject; aPropName: string; aValue: TMethod);
function GetComponentByClassName(Const ComponentClassName: string;
                                 Const SingleInstance: boolean = true;
                                 Const Owner: TComponent = nil;
                                 Const CheckAccessLevel:Boolean=true;
                                 Const showErrorMsg :Boolean = True;
                                 Const iTag: Integer = 0): TComponent;
function GetComponentByClassType(Const ComponentClassType: TPersistentClass; Const SingleInstance: boolean = false; Const AOwner :TComponent = Nil): TComponent;
function FindExistingComponent(Const ComponentClassName: string; Const iTag: Integer = 0): TComponent; overload;
function FindExistingComponent(Const RootComponent:TComponent; Const ComponentClassName: string): TComponent; overload;
function FindExistingComponentbyname(Const RootComponent:TComponent; Const ComponentName: string; SearchSub :Boolean = False; fsControlParent :String = ''): TComponent; overload;
(*Procedure CloseAllforms;*)
function FormStillOpen(const FormClassName: string): boolean; overload;
function FormStillOpen(const FormClassName: string; FormVar: TForm): boolean; overload;
function FormStillOpen(const FormClassName: string; Const iTag: Integer): boolean; overload;
function FormInstance(const FormClassName : string) : TForm;
procedure ExitFocus(frm: TForm);
function HintInEditMode: boolean;
Function Productcolumn(const AliasName : String; const colctr :Integer):String;
function DevMode:Boolean;
function UsingWalmart:Boolean;
function UsingWoocommerce:Boolean;
Function WalmartMsg :String;
Function WoocommerceMsg :String;
Function WalmartPrefinvalidcomponent:String;
//Function WooCommercePrefinvalidcomponent:String;
//function MessageDlgS(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Word;

{ makes sure we cam create/read/write to a file }
function CanUseFile(aFileName: string; var msg: string): boolean;
function LineCount(const FileName: string): integer;
function StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
Function FloatFieldDisplayFormat:String;

function CtrlDown : Boolean;
function ShiftDown : Boolean;
function AltDown : Boolean;

function UniqueComponentName(aComponent: TComponent; CompName: string): string;
function Ifempty(expr1, expr2:String):String;
function IncQuarter(const Date: TDateTime; NumberOfQuarters: integer): TDateTime;
function GetMonthName(const MonthNo: integer): string;
function EndOfTheQuarter(const AValue: TDateTime): TDateTime;
function QuarterOf(const AValue: TDateTime): integer;
function RemoveHotKey(const Value:String):String;
function FillString(const Str: string; const StrLength: integer; const FillChar: char;  const InFront: boolean): string;
Function AligntoStr(const Value : TAlign):String;
function WrappedSQLtext(SQL:TStrings): String;Overload;
function WrappedSQLtext(SQL:String): String;Overload;
function MonthsRND(Const DateFrom , DAteto:TDateTime):Integer;
Function DaysRND(Const DateFrom , DAteto:TDateTime):Integer;
Function Savefilename(DefaultExt :String; defaultFilename:String=''): String;
Function StringDataForSQL(const Value:String):String;
function formatmilliSeconds(Value:Integer):String;
function FormatSeconds(Seconds:Integer):String;
Function AnchorstoStr(const Value :TAnchors):String;
Procedure ShowExceptionMsg(E:Exception; PreExMsg:String =''; PostExMsg:String = ''; showinlyindecmode:Boolean = true);




    {$WARNINGS OFF}
    function GetSendEmailtoErpExcLogFileName(const emaillogPrefix :String): string;

    {$WARNINGS ON}

Function ApplyPreferenceNames(Const Value:String):String;
Function CeasePreferenceNames(Const Value:String):String;

function MessageDlgXP_Vista(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint;
        const Owner: TComponent=nil;
        const Instruction: string = '';
        const VerifyText: string = '';
        const VerifyChecked: boolean = false;
        OnVerifyClick: TTaskDialogVerifyClickEvent = nil;
        const CustomButtonsStr :String = '' ;
        Soundfilename:String = '';
        MsgBoxWidth:Integer=0): Word;

(*
MessageDlgXP_Vista('',mtinformation,[Mbyes,mbno],0,
                      nil   {Owner},
                      ''    {Instruction},
                      ''    {VerifyText},
                      false {VerifyChecked},
                      nil   {OnVerifyClick},
                      ''    {CustomButtonsStr},
                      ''    {Soundfilename},
                      0     {MsgBoxWidth})
                      *)

Procedure PlaySAveSound;
Procedure PlayPrintSound;
Procedure PlayEmailSound;
Procedure PlayCancelSound;
Procedure PlaySound(const DoPlaySound:Boolean; Soundfielname:String);
Procedure ShowWarning(const Value:String);
function CurrencyRoundPlaces:Integer;
function LowestcurrencyDecimalValue:double;
Function char_length(Const Value :String):Integer;
function GetCharFromVKey(vkey: Word): string;

// --------- API Functions -----------------------------------------------
function GetWindowsVersion: string;
Procedure RefreshMemoryUsage;
// -----------------------------------------------------------------------------
procedure LogMessage(const Msg, LogFile: string);
procedure LogDateTimeMessage(const Msg, LogFile, DateFormat: string); overload;
procedure LogDateTimeMessage(const Msg, LogFile: string); overload;
function SetControlFocus(Control: TWinControl): boolean;

// --------- TXMLDocument/Node functions ---------------------------------------
function  GetXMLNodeStringValue  (const Node: IXMLNode; aNodeName: string; var XMLFieldNodeExists :Boolean): string;
function  GetXMLNodeFloatValue   (const Node: IXMLNode; aNodeName: string; var XMLFieldNodeExists :Boolean): double;
function  GetXMLNodeIntegerValue (const Node: IXMLNode; aNodeName: string; var XMLFieldNodeExists :Boolean): integer;
function  GetXMLNodeBooleanValue (const Node: IXMLNode; aNodeName: string; var XMLFieldNodeExists :Boolean): boolean;
function  GetXMLNodeDateTimeValue(const Node: IXMLNode; aNodeName: string; var XMLFieldNodeExists :Boolean): TDateTime;
Function  GetDate_FormatofMYSQL:String;

Procedure AddXMLNode(const Node : IXMLNode ; const sNodeName :String; const Value : OleVariant; XMLTagsinLowercase :Boolean = True);
function  DateTimeToXMLStr(const DateTime: TDateTime): string;

Function  XMLImportResultDoc: IXMLDocument;
Function  XMLImportResultDocName:string;
Procedure SetXMLImportResultDocName(const Value :String) ;

Function  XMLExportResultDocName:string;
Procedure SetXMLExportResultDocName(const Value :String) ;

Procedure InitResultXMLDoc;
Function  NewResultNode(const nodeName :String) :IXMLNode;
Procedure FreeXMLImportResultDoc ;

function GetIndexName(const tblName: string): string;
function getRGB(ColortoConvert :Integer):String;
  // --------- Class Functions ------------------------------------------------
function IsClassByString(const aObject: TObject; const aClassName: string): boolean;
procedure RegisterClassOnce(const AClass: TPersistentClass);
procedure PerformPaints;

procedure InvalidateComponents(Const RootComponent: TComponent;Const IncludedLabels:Boolean=False);
function MemoryUsedPercentage: Integer;
Function MemoryStatusDetails:String;
function MemoryTotalPhysical: Int64;

{ tempory procedure to build a list of fields that need to be excluded from grids }
procedure ListNonGUIFields(grid: TwwDbGrid);
// function MakeEmailID(var emailchanged: Boolean; const firstname, LastName , Email, ClientName :String):String;
// Function ConfirmEmailId(var emailchanged:Boolean; const EmailEdit:TWincontrol; const ds:TDataset; const emailIdfieldname:String):boolean;

function SearchstrArray(Value :String; ArrayValue :Array of String):Boolean;
function ClientDetails(const Value:TDataset ; const isbilldetails:Boolean = False) :String;
function IsDir(const DirPath: string): boolean;
function IsFile(const FileName: string): boolean;
function StripQuotes(  const sString: string): string;
function StripCR(  const sString: string; ReplaceWith :String =' '): string;
function SearchStringList(StringList :TStringList; SearchValue:String):Integer;

Procedure SelectedIDs(grd:TwwDBGrid; IDFieldname:String;var St:TStringlist; ignoreduplicates:Boolean = False; DoCheckrec:TBoolFunc=nil); overload;
Procedure SelectedIDs(grd:TwwDBGrid; IDFieldname:String;var St:TIntegerList; ignoreduplicates:Boolean = False; DoCheckrec:TBoolFunc=nil);overload;
function  SelectedIDs(grd:TwwDBGrid; IDFieldname: string; ignoreduplicates: boolean = false): string; overload;
Procedure SelectedDatas(grd:TwwDBGrid; Fieldname:String;var St:TStringlist; ignoreduplicates:Boolean = False);overload;
Function SelectedDatas(grd:TwwDBGrid; Fieldname:String;ignoreduplicates:Boolean = False):String;overload;
Function SelectedData(grd:TwwDBGrid; Fieldname:String):String;
function StringCount(const subtext: string; Text: string): Integer;
function tempdir :String;
Function NumberMaskTocaption(fsMask:String):STring;
Function Skipdays(CurDay, noofDays: Integer): Integer;
function IsClassParent(const aClass, aParent: TClass): boolean;
function TemplateToTemplClass(TemplateName:String ):String;
function TransType(TableAlias:String ; IsSales:Boolean):String;
Function companyinfoSQLfortemplate: String;
Function iif(const cond :boolean ; trueValue, falseValue:Variant):Variant;
Function ValidateForName(Const Value:String):String;
function Parentformcolor(const control :TWincontrol):TColor;
function ControlParent(control :TControl): string;
function ControlOwner(control :TComponent): string;
function EmployeeHasAccess(const FormName: string; const EmployeeID: integer = 0; AccessLevelreqd:Integer = 3 ):boolean;
function NameToCode(NameValue:String):String;
function MilliSeconds(const Seconds:Integer):Integer;
function Seconds(const MilliSeconds:Integer):Integer;
function RelatedColor(Colr:TColor):TColor;
Function Highest(Const Values :Array of double):Double;
Function Lowest(Const Values :Array of double):Double;
Function SelectedText(Const fieldname:String; const DisplayLabel:String; DisplayWidth:Integer; const Groupname :String =''; fbReadonly :Boolean =False):String;
Function FloatToInt(Value:Double; RoundToNext:Boolean=True):Integer;
function  IsSundayWeekend:Boolean   ;
function  IsMondayWeekend:Boolean   ;
function  IsTuesdayWeekend:Boolean  ;
function  IsWednesdayWeekend:Boolean;
function  IsthursdayWeekend:Boolean ;
function  IsFridayWeekend:Boolean   ;
function  IsSaturdayWeekend:Boolean ;
Function IsWeekendDay(const Weekdayno :Integer):Boolean;
Function IsWeekend(const aDate :TDatetime):Boolean;
Function IsDateholiday(const aDate :TDatetime):Boolean;
Function nextnum(const Value:Integer; NumLength:Integer;fillchar:String='0'):String;
function heirarchyname(Control:TComponent):String;
Function DateRangeWithin(Dtfrom, dtTo, RanegFrom, RangeTo:TDateTime):Boolean;
Function UOMForProductLookupSQL:String;
Function StrCurrToDouble(Value:String):Double;

var
{$IFDEF GET_HELPCONTEX_INFO}
    AllRegisteredClass: TStringList;
{$ENDIF}
    fbMessaging:Boolean;
  //Settingcolwidth:Boolean;
implementation

uses
  ComCtrls,AdvOfficeStatusBar, DecimalRounding,  OnGuard, {LBUtils,}
  DNMAccessManager,Vista_MessageDlg, ogutil,
  BusObjConst, tcDataUtils, tcConst, SysInfo,  MyAccess,
  DNMLib, AppEnvironment, DNMPanel, StdCtrls, CommonDbLib,
  DNMSpeedButton, IniFiles, MMSystem, tcTypes,
  IdMessage, IdSMTP, IdException,
  {EMHelper,}
  IdAttachment, MailServerConst,
  IdAttachmentFile, SystemLib, Character, typinfo, MySQLConst, Rounding, Math, DateTimeUtils, customInputBox, LogLib,
  ProgressDialog, UtilsLib , StrUtils, StringUtils(*, BaseFormForm,
  MainSwitchFrm2, MAIN*); {**********DO NOT USE ANY ERP FORMS ****************}



var
    foXMLImportResultDoc: IXMLDocument;
    fsXMLImportResultDocName :String;
    fsXMLExportResultDocName :String;
    foSavedCursor: TCursor;

function TempDir:String;
begin
  result := SystemLib.WinTempDir;
end;

function FindExistingComponentbyname(Const RootComponent:TComponent; Const ComponentName: string; SearchSub :Boolean = False; fsControlParent :String = ''): TComponent;
var
  ctr, I: integer;
Begin
  Result := nil;
  if RootComponent.ComponentCount =0 then exit;
  for ctr  := 1 to 2 do begin
  {this lop is specifically for the mainmenu.panel1/panel2 buttons for workflows Play
  As on the mainmenu the parent panel is dynamic and the panel could be different when u play it }
    for I := 0 to RootComponent.ComponentCount - 1 do begin
      if Sysutils.SameText(RootComponent.Components[I].Name,ComponentName) then

        if fsControlParent='' then begin
          Result := RootComponent.Components[I];
          Exit;
        end else if not (RootComponent.Components[I] is TControl) then begin
          Result := RootComponent.Components[I];
          Exit;
        end else if sametext(fsControlParent , ControlParent(TControl(RootComponent.Components[I])))  then begin
          Result := RootComponent.Components[I];
          Exit;
        end;
    end;
    if fsControlParent = '' then break;
         if pos(uppercase('MainSwitch2.sbButtons.pnlButtons2'), uppercase(fsControlParent)) =1 then fsControlParent := StringReplace(fsControlParent ,'MainSwitch2.sbButtons.pnlButtons2', 'MainSwitch2.sbButtons.pnlButtons1', [rfIgnoreCase] )
    else if pos(uppercase('MainSwitch2.sbButtons.pnlButtons1'), uppercase(fsControlParent)) =1 then fsControlParent := StringReplace(fsControlParent ,'MainSwitch2.sbButtons.pnlButtons1', 'MainSwitch2.sbButtons.pnlButtons2', [rfIgnoreCase] )
    else break;
  end;

  if not(SearchSub) then exit;

  if RootComponent.ComponentCount >0 then
    for I := 0 to RootComponent.ComponentCount - 1 do begin
      //logtext(RootComponent.Name+'['+inttostr(i)+']='+RootComponent.Components[I].name +'.componentcount='+inttostr(RootComponent.Components[I].ComponentCount));
      if RootComponent.Components[I].ComponentCount >0 then begin
        Result:= FindExistingComponentbyname(RootComponent.Components[I],ComponentName, SearchSub,fsControlParent);
        if (result = nil) and (fsControlParent <> '') then
          Result:= FindExistingComponentbyname(RootComponent.Components[I],ComponentName, SearchSub, '');
        if Assigned(Result) then exit;
      end;
    end;
end;

function FindExistingComponent(Const RootComponent:TComponent; Const ComponentClassName: string): TComponent; overload;
var
  I: integer;
Begin
  Result := nil;
  for I := 0 to RootComponent.ComponentCount - 1 do begin
    if Sysutils.SameText(RootComponent.Components[I].ClassName,ComponentClassName) then begin
      Result := RootComponent.Components[I];
      Exit;
    end;
  end;
end;

(*Procedure CloseAllforms;
var
  X: integer;
begin
  for x := 0 to Application.ComponentCount - 1 do begin
    if Application.Components[x] is TBaseForm then
        if Sysutils.SameText(Application.Components[x].ClassName,mainform.classname) or
           Sysutils.SameText(Application.Components[x].ClassName,MainSwitch2.classname)  Then
        else begin
           TBaseForm(Application.Components[x]).CloseWait;
           Application.processmessages;
        end;
  end;

end;*)
function FindExistingComponent(Const ComponentClassName: string; Const iTag: Integer = 0): TComponent; overload;
var
  X,X2: integer;
  TempComp:  TComponent;
begin
  Result := nil;
  // see if there is an instance of this class already created
  for x := 0 to Application.ComponentCount - 1 do begin
    if Sysutils.SameText(Application.Components[x].ClassName,ComponentClassName) Then Begin
      If (Application.Components[x].Tag = iTag) then begin
        Result := Application.Components[x];
        Exit;
      end;
    end;
    // To Test TForm Owned forms
    TempComp := Application.Components[x];
    If TempComp is TForm then
      for X2 := 0 to TempComp.ComponentCount - 1 do begin
        if Sysutils.SameText(TempComp.Components[X2].ClassName,ComponentClassName) Then Begin
          If (TempComp.Components[X2].Tag = iTag) then begin
            Result :=  TempComp.Components[X2];
            Exit;
          end;
        end;
      end;
  end;
end;

procedure StringToStream(const Text: String;
                         const Stream: TMemoryStream);
begin
  Stream.SetSize(char_length(Text));
  Stream.Seek(0, soFromBeginning);
  Stream.Write(Text[1], char_length(Text));
  Stream.Seek(0, soFromBeginning);
end;

function MemoryStatusDetails :String;
var
  MemStat: TMemoryStatusex;
begin
  MemStat.dwLength := SizeOf(MemStat);
  GlobalMemoryStatusex(MemStat);
  result :=      (*'physical memory: '          +*)floattostr(MemStat.ullTotalPhys )+', ' +
                 (*'Percent of memory in use: ' +*)inttostr(MemStat.dwMemoryLoad)+', ' +
                 (*'free physical memory: '     +*)floattostr(MemStat.ullAvailPhys )+', ' +
                 (*'paging file space: '        +*)floattostr(MemStat.ullTotalPageFile )+', ' +
                 (*'free paging file space: '   +*)floattostr(MemStat.ullAvailPageFile )+', ' +
                 (*'virtual address space: '    +*)floattostr(MemStat.ullTotalVirtual )+', ' +
                 (*'free virtual address space:'+*)floattostr(MemStat.ullAvailVirtual );


end;
function MemoryUsedPercentage: Integer;
var
  MemStat: TMemoryStatus;
begin
  MemStat.dwLength := SizeOf(MemStat);
  GlobalMemoryStatus(MemStat);
  result := MemStat.dwMemoryLoad;
end;

function MemoryTotalPhysical: Int64;
var
  MemStatus: TMemoryStatusEx;
begin
  FillChar(MemStatus, SizeOf(MemStatus), 0);
  MemStatus.dwLength := SizeOf(MemStatus);
  // check return code for errors
  try
   {$Warnings Off}
    Win32Check(GlobalMemoryStatusEx(MemStatus));
   {$Warnings On}
    result := MemStatus.ullTotalPhys;
  except
    result := 0;
  end;
end;

{Get the Primary Key from the table}
function GetIndexName(const tblName: string): string;
begin
  Result := DNMLib.GetMysqlTablePrimaryKey(tblName);
  if Empty(Result) then begin
    MessageDlgXP_Vista('Primary Key not found in Dataset', mtInformation , [mbOK], 0);
  end;
end;
function getRGB(ColortoConvert :Integer):String;
begin
    REsult := IntToStr(GetRValue(ColortoConvert)) + ':' +
              IntToStr(GetGValue(ColortoConvert)) + ':' +
              IntToStr(GetBValue(ColortoConvert));
end;
Function DatewithHourof(Const Dt:TDatetime):TDateTime;
begin
  result := inchour(DateOf(Dt) , HourOf(dt));
end;
function MinutesBetween(const ANow, AThen: TDateTime): Integer;
var
  M1, M2: integer;
const
  HalfMillisecond = 0.5/(24*60*60*1000);
begin
    M1 := trunc((AThen + HalfMillisecond)*(24*60));
    M2 := trunc((ANow + HalfMillisecond)*(24*60));
    Result := M2 - M1;
end;

procedure LogDateTimeMessage(const Msg, LogFile, DateFormat: string); overload;
begin
  LogMessage(FormatDateTime(DateFormat, SysUtils.Now) + ' ' + Msg, LogFile);
end;

procedure LogDateTimeMessage(const Msg, LogFile: string); overload;
begin
  LogDateTimeMessage(Msg, LogFile, 'dd/mm/yyyy - hh:nn:ss');
end;

procedure LogMessage(const Msg, LogFile: string);
var
  F: System.TextFile;
begin
  AssignFile(F, LogFile);

  if SysUtils.FileExists(LogFile) then begin
    {$I-}
    Append(F);
    {$I+}
    IOResult;
  end else begin
    {$I-}
    Rewrite(F);
    {$I+}
    IOResult;
  end;

  try
    Writeln(F, Msg);
  finally
    CloseFile(F);
  end;
end;

// --------- String Functions -----------------------------------------------

function ValueListed(const S: string; const CaseSensitive: boolean; const Values: array of string): boolean;
var
  I: integer;
begin
  Result := false;
  for I := Low(Values) to High(Values) do begin
    if CaseSensitive then Result := S = Values[I]
    else Result := Sysutils.SameText(S, Values[I]);

    if Result then Break;
  end;
end;

function ValueListed(const I: integer; const Values: array of integer): boolean;
var
  J: integer;
begin
  Result := false;
  for J := Low(Values) to High(Values) do begin
    Result := (I = Values[J]);
    if Result then Break;
  end;
end;

(*function StripQuotes(const sString: string): string;
begin
  Result := StringReplace(sString, '"', '', [rfReplaceAll]);
end;*)
Function UnQuoteStr(const Value :STring):String;
begin
    result := Value;
    if ((copy(result,1,1) = '''') and (copy(result,char_length(result),1) = '''')) or
       ((copy(result,1,1) = '"') and (copy(result,char_length(result),1) = '"')) then begin
       result := copy(result , 2, char_length(result)-2);
    end;
end;
function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
begin
  //Result := StringReplace(sString, sOldStr, sNewStr,[rfReplaceAll,rfIgnoreCase]);
  Result := Stringutils.ReplaceStr(sString,sOldStr,sNewStr);
end;
function EmptyNumber(const s: string): boolean;
begin
    Result := (Trim(s) = '') or (Trim(s) = '0') or (Trim(s) = '0.00');
end;
function Empty(const s: string): boolean;
begin
  Result := (Trim(s) = '');
end;

Function CustomInputPassword(const fCaption , fMessage,Defaultvalue:String) : String;
var
    CIB: TCustomInputBox;
begin
    REsult := '';
    CIB := TCustomInputBox.Create(nil);
    try
      CIB.Buttons := [sbOK, sbCancel];
      CIB.Caption := fCaption;
      CIB.Message := fMessage;
      CIB.DefaultString := Defaultvalue;
      CIB.PasswordCharacter := '*';
      if CIB.Execute then Result :=CIB.InputResult;
    finally
      FreeandNil(CIB);
    end;
end;

Function CustomInputString(const fCaption , fMessage,Defaultvalue:String) : String;
var
    CIB: TCustomInputBox;
begin
    REsult := '';
    CIB := TCustomInputBox.Create(nil);
    try
      CIB.Buttons := [sbOK, sbCancel];
      CIB.Caption := fCaption;
      CIB.Message := fMessage;
      CIB.DefaultString := Defaultvalue;
      if CIB.Execute then Result :=CIB.InputResult;
    finally
      FreeandNil(CIB);
    end;
end;
Function CustomInputInteger(const fCaption , fMessage:String;Defaultvalue:String=''; DefaultResult:Integer = -1) : Integer;
var
    CIB: TCustomInputBox;
begin
    CIB := TCustomInputBox.Create(nil);
    try
      CIB.Buttons := [sbOK, sbCancel];
      CIB.Caption := fCaption;
      CIB.Message := fMessage;
      CIB.DefaultString := Defaultvalue;
      CIB.InputType := customInputBox.ttFloat;
      if CIB.Execute then Result := trunc(strValue(CIB.InputResult))
      else result := DefaultResult;
    finally
      FreeandNil(CIB);
    end;
end;
Function CustomInputBoolean(const fCaption , fMessage:String) : Boolean;
var
    CIB: TCustomInputBox;
begin
    CIB := TCustomInputBox.Create(nil);
    try
      CIB.Buttons := [sbOK, sbCancel];
      CIB.Caption := fCaption;
      CIB.Message := fMessage;
      CIB.InputType := customInputBox.ttBoolean;
      if CIB.Execute then Result :=sametext(CIB.InputResult, 'T')
      else result := False;
    finally
      FreeandNil(CIB);
    end;
end;

Function CustomInputFloat(Const fCaption, fMessage:String;Defaultvalue:String='') : Double;
var
    CIB: TCustomInputBox;
begin
    CIB := TCustomInputBox.Create(nil);
    try
      CIB.Buttons := [sbOK, sbCancel];
      CIB.Caption := fCaption;
      CIB.Message := fMessage;
      CIB.DefaultString := Defaultvalue;
      CIB.InputType := customInputBox.ttFloat;
      if CIB.Execute then Result :=StrValue(CIB.InputResult)
      else result := -1;
    finally
      FreeandNil(CIB);
    end;
end;
function StrValue(const sValue: string): double;
var
  sTemp: string;
  bIsNeg: boolean;
  i: integer;
begin
  bIsNeg := (Pos('-', sValue) > 0) or (Pos('(', sValue) > 0);
  sTemp := '';
  for i := 1 to char_length(sValue) do if CharInSet(sValue[i],['0'..'9', FormatSettings.DecimalSeparator]) then sTemp := sTemp + sValue[i];
  if sTemp = '' then sTemp := '0';
  if bIsNeg then sTemp := '-' + sTemp;
  try
    Result := StrToFloat(sTemp);
  except
    Result := 0.00;
  end;
end;
function SubStr(const fMainString: string; const Delimeter: string = ','; const fPosition: double = 1): string;
var
  MainString: string;
  Position: double;
begin
  Result := '';
  MainString := fMainString;
  Position := fPosition;
  if Delimeter = '' then begin
    Result := MainString;
    Exit;
  end;
  if MainString = '' then begin
    Result := '';
    Exit;
  end;
  if Pos(Delimeter, Mainstring) = 0 then begin
    Result := MainString;
    Exit;
  end;
  if Position = 1 then Result := Copy(MainString, 1, Pos(Delimeter, Mainstring) - 1)
  else begin
    Mainstring := Copy(MainString, Pos(Delimeter, Mainstring) + length(delimeter), char_length(Mainstring));
    Position   := Position - 1;
    if MainString = '' then Result := ''
    else Result := SubStr(MainString, Delimeter, Position);
  end;
end;
function CharCounter(const char, TestString: string): integer;
var
  TempStr: string;
  S, Count, I: integer;
begin
  TempStr := TestString;
  Count := 1;

  for I := 1 to char_length(TestString) do begin
    S := Pos(char, TempStr);
    if S > 0 then begin
      Delete(TempStr, S, char_length(char));
      Count := Count + 1;
    end else begin
      Break;
    end;
  end;
  Result := Count
end;
Procedure StrtoStringlist(const Source, delim:String; var St:TStringList);
var
  S: integer;
  //E: integer;
  //L9: integer;
  Src: string;
begin
  st.Clear;
  if source = '' then exit;
  if Delim = '' then begin
    St.Add(Source);
    exit;
  end;
  Src := Source + Delim;
  While src<> '' do begin
    S := Pos(Delim, Src);
    if S > 0 then begin
      st.Add(Copy(src, 0 , s-1));
      src:= copy(src,s+1, length(src));
    end  else begin
      St.Add(src);
      src:= '';
    end;
  end;
end;
function ExtractStrPortion(const Source: string; const Delim: string; const PosCount: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := Source + Delim;
  S := 1;
  for L9 := 1 to PosCount - 1 do begin
    S := Pos(Delim, Src);
    if S > 0 then Delete(Src, S, char_length(Delim))
    else Break;
  end;

  Result := '';
  if S > 0 then begin
    E      := Pos(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;

{Extracts the trailing spaces & colon from a string, e.g. Source = 'City :'  Result = ' :'}
function ExtractLabelSuffix(const Source: string): string;
var
  lStart, lEnd: Integer;
begin
  lEnd := char_length(Source);
  lStart := lEnd;
  while (lStart > 0) and CharInSet(Source[lStart],[' ',':']) do
    Dec(lStart);
  if lStart = lEnd then
    Result := ''
  else
    Result := Copy(Source, lStart + 1, lEnd - lStart);
end;

function CurDatestr:String;
begin
  result := QuotedStr(formatdateTime(mySQLDateFormat, date));
end;
{Use to insert a space between capitals or in the position of an underscore (_)}
function SeparateWords(const s: string): string;
var
  i: integer;
begin
  Result := s;
  i := 2;
  while i <= char_length(Result) do begin
    if CharInSet(Result[i - 1],['a'..'z']) and CharInSet(Result[i],['A'..'Z']) then Insert(' ', Result, i)
    else if Result[i] = '_' then Result[i] := ' ';
    Inc(i);
  end;
end;
function searchArray(const SearchingArray:Array of integer; Searchvalue:integer):Integer;overload;
var
  i:Integer;
begin
  result := -1;
  for i := low(SearchingArray) to high(SearchingArray) do
    if SearchingArray[i] = SearchValue then begin
        REsult := i;
        break;
    end;
end;
function searchArray(const SearchingArray:Array of TDatetime; Searchvalue:Tdatetime):Integer;
var
  i:Integer;
begin
  result := -1;
  for i := low(SearchingArray) to high(SearchingArray) do
    if SearchingArray[i] = SearchValue then begin
        REsult := i;
        break;
    end;
end;
function ConcatStrings(const Values:Array of string ; DElimstr:String):String;
var
  i:Integer;
begin
  result := '';
  for i := low(Values) to high(Values) do begin
    if TRim(Values[i])<> '' then begin
      if result <> '' then result := result + DElimstr;
      result := result +Values[i];
    end;
  end;
end;
function searchArray(const SearchingArray:Array of string ; SearchValue:String;Casesensitive:Boolean =true):Integer;
var
  i:Integer;
begin
  result := -1;
  for i := low(SearchingArray) to high(SearchingArray) do
    if (Casesensitive and (SearchingArray[i] = SearchValue)) or (SAmeText(SearchingArray[i] , SearchValue)) then begin
        REsult := i;
        break;
    end;
end;
(*Function ISInteger(const s: string): boolean;
var
  x: integer;
begin
  Result := true;
  x := 1;
  while x <= char_length(s) do begin
    if not (s[x] in ['0'..'9']) then begin
      Result := false;
      Break;
    end;
    Inc(x);
  end;
end;*)
function IsNumber(const s: string): boolean;
var
  x: integer;
begin
  Result := true;
  x := 1;
  while x <= char_length(s) do begin
    if not CharInSet(s[x],['0'..'9', '.', '-', '+']) then begin
      Result := false;
      Break;
    end;
    Inc(x);
  end;
end;

function LeftPadStr(const s: string; const places: integer; const padChar: char): string;
begin
  Result := s;
  while char_length(Result) < places do Result := padChar + Result;
end;

function NumCharOnly(Key: char): char;
begin
  Result := Key;
  if (not CharInSet(Result,['0'..'9', '.', '-', '+', Chr(8)])) then Result := Chr(0);
end;

function StringToFloat(const aString: string): double;
begin
  Result := StrToFloatDef(aString, 0);
end;

function StringToInt(const aString: string): integer;
begin
  Result := StrToIntDef(aString, 0);
end;

procedure RemoveBlankLines(const Strings: TStrings); overload;
var
  i: integer;
begin
  for i := Strings.Count - 1 downto 0 do
    if Trim(Strings[i]) = '' then
      Strings.Delete(i);
end;

function RemoveBlankLines(const aString: string): string; overload;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  Try
    sl.Text := aString;
    RemoveBlankLines(sl);
    Result := sl.Text;
  finally
    FreeandNil(sl);
  end;
end;

function IsQuotedStr(const aString: string): boolean;
var
  s1, s2: string;
begin
  result:= false;
  s1:= Copy(aString, 0,1);
  s2:= Copy(aString, char_length(aString),1);
  if ((s1 = '''') and (s2 = '''')) or ((s1 = '"') and (s2 = '"')) then
    result:= true;
end;

// --------- Number Functions ------------------------------------------------
function RoundCurrency(const Value: double): currency;
begin
  Result := Rounding.RoundCurrency(Value); //   DecimalRoundDbl(Value, CurrencyRoundPlaces, drHalfUp);
end;

function Round(const Value: double; places: word): double;
begin
  //Result := Rounding.Round(Value, places); //  DecimalRoundDbl(Value, places, drHalfUp);
  result := Value;
  if Value = 0 then exit;
  //Result := Math.Roundto(Value , 0-Places);
  result := DecimalRoundDbl(Value, Places, drHalfUp);
end;

function ForeignToLocal(const ForeignAmount, Rate: double; const Places: integer = -1): double;
var
  ConvRate: double;
begin
  ConvRate := Rate;
  if ConvRate = 0 then ConvRate := 1;
  Result := ForeignAmount * (1 / ConvRate);
  if Places > -1 then Result := Round(Result, Places);
end;

function LocalToForeign(const LocalAmount, Rate: double; const Places: integer = -1): double;
begin
  try Result := LocalAmount;Except end;
  try Result := Result * Rate; Except end;
  try if Places > -1 then if Result<>0 then Result := Round(Result, Places); Except end;
end;

function DivZer(const x, y: extended): extended;
begin
  {return 0 if either value is 0 otherwise perform division}
  if (x = 0) or (y = 0) then Result := 0
  else Result := x / y;
end;
function IsTimeValid(Const s :String ):Boolean;
begin
    Result := True;
  if s = '' then begin
    Result := False;
    Exit;
  end;
  try
    StrToTime(s);
  except
    on EConvertError do Result := false;
  end;
end;
Function IsInvProduct(Const PartType:String):Boolean;
begin
    Result :=  (PartType = 'INV');
end;
Function IsDate(const s:String; var dt:TDatetime):Boolean;
begin
    Result := TryStrToDate(s, dt);
end;
Function ISEvenNo(const s: string): boolean;
begin
  result:= False;
  if not IsInteger(s) then exit;
  result := trunc(strtoInt(s)/2)*2 = strtoInt(s);
end;
Function IsInteger(const s: string):boolean;
var
  x: Integer;
  s2: string;
begin
  result := true;
  if trim(s) = '' then begin
    Result:= False;
    Exit;
  end;
  s2:= Trim(s);
  for x := 1 to Length(s2) do begin
    if ((x=1) and (not (CharInSet(s2[x],['0'..'9']) or CharInSet(s2[x],['+','-'])))) or
       ((x>1) and (not (CharInSet(s2[x],['0'..'9'])))) then begin
      result := false;
      exit;
    end;
  end;
end;

function IsNumeric(const s: string): boolean;
var
  num: extended;
begin
  Result := TryStrToFloat(s, num);
end;

function IsNumbersOnly(const s: string): boolean;
var
  x: integer;
begin
  result:= true;
  for x:= 1 to char_length(s) do begin
    if not TCharacter.IsNumber(s,x) then begin
      result:= false;
      break;
    end;
  end;
end;

function GetAmountInc(const AmountEx: double; const TaxRate: double): Double;
begin
  Result := AmountEx * Divzer((1 + TaxRate), 1);
end;
function GetAmountEx(const AmountInc: double; const TaxRate: double): double;
begin
  Result := AmountInc * Divzer(1, (1 + TaxRate));
end;
function GetRate(const AmountInc: double; const AmountEx: double): double;
begin
  Result := divzer((AmountInc-amountEx) ,amountEx)*100;
end;
Function GetPercent(const AmountInc: double;const AmountEx: double):Double;
begin
  REsult := (Divzer(AmountInc , AmountEx)-1)*100;
end;
// --------- General Functions -----------------------------------------------

{ Return a reference to a running form }
{function GetAppForm(const FormName: string): TForm;
var
  x: integer;
begin
  Result := nil;
  for x := 0 to Application.ComponentCount - 1 do begin
    if (Application.Components[x] is TForm) and (TForm(Application.Components[x]).Name = FormName) then begin
      Result := TForm(Application.Components[x]);
      Break;
    end;
  end;
end;}

function GetComponentsForm(const aComponent: TComponent): TForm;
var
  c: TComponent;
begin
  c := aComponent;
  while (c <> nil) and (not (c is TForm)) do c := c.Owner;
  Result := TForm(c);
end;

function FindChildComponent(const Owner: TComponent; const ComponentName: string): TComponent;
var
  x: integer;
begin
  Result := nil;
  If not Assigned(Owner) then Exit;
  for x := 0 to Owner.ComponentCount - 1 do begin
    if SameText(Owner.Components[x].Name, ComponentName) then begin
      Result := Owner.Components[x];
      Break;
    end;
  end;
end;

procedure ClearTList(const lst: TList; const iSize: integer);
var
  i: integer;
  p: Pointer;
begin
  { don't try if lst = nil otherwise GPF }
  if lst <> nil then begin
    for i := 0 to lst.Count - 1 do begin
      p := lst.Items[i];
      if iSize > 0 then MFree(p, iSize)
      else Dispose(p);
    end;
    lst.Clear;
  end;
end;

procedure MFree(var p: Pointer; const lSize: longint);
begin
  if lSize < 65528 then FreeMem(p, word(lSize))
  else GlobalFreePtr(p);
  p := nil;
end;

function GetPCName: string;
var
  Buffer: array[0..MAX_COMPUTERNAME_LENGTH] of char;
  nSize: cardinal;
begin
  nSize := SizeOf(Buffer);
  GetComputerName(Buffer, nSize);
  Result := Buffer;
end;

function StatusAndToolbarHeight:Integer;
var
  comp :TComponent;
begin
  REsult :=0;
  comp := CommonLib.FindControlClass(Application.MainForm, 'TToolBar');
  if Assigned(comp) then REsult := TToolBar(comp).Height;
  comp := CommonLib.FindControlClass(Application.MainForm, 'TAdvOfficeStatusBar');
  if Assigned(comp) then result := result+ TAdvOfficeStatusBar(comp).Height;
end;

function FindControlClass(const OwnerComponent: TComponent; const SearchClass: string): TComponent;
var
  x: integer;
begin
  Result := nil;
  for x := 0 to OwnerComponent.ComponentCount - 1 do if OwnerComponent.Components[x].ClassName = SearchClass then begin
      Result := OwnerComponent.Components[x];
      Break;
    end;
end;

{ returns client height minus status and tool bar heights }
function GetFormUsableClientHeight(const aForm: TForm): integer;
var
  comp: TComponent;
begin
  Result := aForm.ClientHeight;
  comp := FindControlClass(aForm, 'TToolBar');
  if Assigned(comp) then Result := Result - TToolBar(comp).Height;
  comp := FindControlClass(aForm, 'TTAdvOfficeStatusBar');
  if Assigned(comp) then Result := Result - TAdvOfficeStatusBar(comp).Height;
end;

  ////////////////////////////////////////////////////////////////////
  // Daniel: 18/3/2005
  // This function converts a geniune TDateTime to a MS Time Stamp.
  // If the result string is empty then this indicates there was
  // error during the conversion process due to the fact that the
  // given datetime is invalid.
  ////////////////////////////////////////////////////////////////////
function ConvertDateTimeToMSTimeStampStr(dtDate: TDateTime): string;
var
  wDay, wMonth, wYear, wHour, wMin, wSec, wMilli: word;
begin
  try
    DecodeDateTime(dtDate, wYear, wMonth, wDay, wHour, wMin, wSec, wMilli);
    Result := IntToStr(wYear);
    if wMonth < 10 then Result := Result + '0' + IntToStr(wMonth)
    else Result := Result + IntToStr(wMonth);

    if wDay < 10 then Result := Result + '0' + IntToStr(wDay)
    else Result := Result + IntToStr(wDay);

    if wHour < 10 then Result := Result + '0' + IntToStr(wHour)
    else Result := Result + IntToStr(wHour);

    if wMin < 10 then Result := Result + '0' + IntToStr(wMin)
    else Result := Result + IntToStr(wMin);

    if wSec < 10 then Result := Result + '0' + IntToStr(wSec)
    else Result := Result + IntToStr(wSec);

  except
    Result := '';
  end;
end;

function ConvertMSTimeStampStrToDate(const msTimeStamp: string): TDateTime;
var
  wDay, wMonth, wYear, wHour, wMin, wSecs, wMilli: word;
  SrcBuffer: array[0..16] of char;
  Buffer: array[0..16] of char;
begin
  try
    StrPCopy(SrcBuffer, PChar(msTimeStamp));
    // Get Year.
    StrLCopy(Buffer, SrcBuffer, 4);
    wYear := StrToInt(string(Buffer));

    // Get Month.
    ZeroMemory(@Buffer, SizeOf(Buffer));
    StrLCopy(Buffer, @SrcBuffer[4], 2);
    wMonth := StrToInt(string(Buffer));

    // Get Day.
    ZeroMemory(@Buffer, SizeOf(Buffer));
    StrLCopy(Buffer, @SrcBuffer[6], 2);
    wDay := StrToInt(string(Buffer));

    // Get Hours.
    ZeroMemory(@Buffer, SizeOf(Buffer));
    StrLCopy(Buffer, @SrcBuffer[8], 2);
    wHour := StrToInt(string(Buffer));

    // Get Minutes.
    ZeroMemory(@Buffer, SizeOf(Buffer));
    StrLCopy(Buffer, @SrcBuffer[10], 2);
    wMin := StrToInt(string(Buffer));

    // Get Seconds.
    ZeroMemory(@Buffer, SizeOf(Buffer));
    StrLCopy(Buffer, @SrcBuffer[12], 2);
    wSecs := StrToInt(string(Buffer));

    wMilli := 0;
    Result := EncodeDateTime(wYear, wMonth, wDay, wHour, wMin, wSecs, wMilli);

  except
    Result := 0;
  end;
end;

Function IsSunday   (Value:TDateTime):Boolean;begin result := DayOfTheWeek(Value)=7; end;
Function IsMonday   (Value:TDateTime):Boolean;begin result := DayOfTheWeek(Value)=1; end;
Function IsTuesday  (Value:TDateTime):Boolean;begin result := DayOfTheWeek(Value)=2; end;
Function IsWednesday(Value:TDateTime):Boolean;begin result := DayOfTheWeek(Value)=3; end;
Function IsThursday (Value:TDateTime):Boolean;begin result := DayOfTheWeek(Value)=4; end;
Function IsFriday   (Value:TDateTime):Boolean;begin result := DayOfTheWeek(Value)=5; end;
Function IsSaturday (Value:TDateTime):Boolean;begin result := DayOfTheWeek(Value)=6; end;

Function WeekDay(DayNo :Integer) :String;
begin
  Result := DatetimeUtils.WeekDay(DayNo);
end;
Function WeekDay(DayName :String) :Integer;
begin
  Result := DatetimeUtils.WeekDay(Dayname);
end;

function  CurrentWeekEndDate(DateVal :TDatetime) :TDatetime;
var
    ctr :Integer;
begin
    Result := DateVal;
    ctr := DayOfTheWeek(Result);
    While ctr <>AppEnv.CompanyPrefs.EndWeekDay do begin
        Result := incDay(Result);
        ctr := DayOfTheWeek(REsult);
    end;
end;

function GetClassNameHierarchy(const aObject: TObject): string;
var
  aComponent: TComponent;
begin
  Result := '';
  if (aObject is TComponent) then begin
    aComponent := TComponent(aObject);
    while (aComponent.Owner <> nil) do begin
      if (Result = '') then begin
        Result := aComponent.ClassName;
      end else begin
        Result := aComponent.ClassName + '.' + Result;
      end;
      aComponent := aComponent.Owner;
    end;
  end else begin
    Result := aObject.ClassName;
  end;
end;

function GetUniqueName(const Name: string): string;
var
  I: Integer;
begin
  I := 0;
  Result := Name;
  while FindExistingComponent(Application, Result) <> nil do
  begin
    Inc(I);
    Result := Format('%s_%d', [Name, I]);
  end;
end;
procedure SetMethodProperty(aObj: TObject; aPropName: string; aValue: TMethod);
var PropInfo: PPropInfo;
begin
  PropInfo:= GetPropInfo(aObj,aPropName);
  if Assigned(PropInfo) then begin
    SetMethodProp(aObj, aPropName, aValue);
  end else begin
//      Log('Property does not exist - ' + aPropName, LogType_Error);
  end;

end;
Function GetObjectProperty(aObj: TObject; aPropName: string):String;
var
  val: Variant;
begin
  Val :='';
  try
    try
      if aobj = nil then exit;
      val := GetPropValue(aobj, aPropName);
    Except
        on E:Exception do begin
          if devmode then
            Logtext(E.Message);
        end;
    end;
  finally
    Result := VarToStr(Val);
  end;

end;
procedure SetObjectProperty(aObj: TObject; aPropName: string; aValue: Variant);
var PropInfo: PPropInfo;
begin
  PropInfo:= GetPropInfo(aObj,aPropName);
  if Assigned(PropInfo) then begin
    SetPropValue(aObj, aPropName, aValue);
  end else begin
//      Log('Property does not exist - ' + aPropName, LogType_Error);
  end;
end;

function GetComponentByClassName(Const ComponentClassName: string;
                                 Const SingleInstance: boolean = true;
                                 Const Owner: TComponent = nil;
                                 Const CheckAccessLevel:Boolean=true;
                                 Const showErrorMsg :Boolean = True;
                                 Const iTag: Integer = 0): TComponent;
var
  Cls: TPersistentClass;
  AccessLevel : Integer;
  Index: Integer;


begin
  Result := nil;
  if SingleInstance then begin
    Result := FindExistingComponent(ComponentClassName, iTag);
  end;
  if not Assigned(Result) then begin
    try
      Cls := FindClass(ComponentClassName);
    except
      Cls := nil;
      if showErrorMsg then
      MessageDlgXP_Vista('Could not find component class: ' + ComponentClassName, mtWarning, [mbOK], 0);
    end;
    if Cls <> nil then begin
      If CheckAccessLevel then begin
        if Assigned(AppEnv.AppDb) and AppEnv.AppDb.Connection.Connected then begin
          AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(ComponentClassName);
          if AccessLevel = 6 then begin
            if showErrorMsg then MessageDlgXP_Vista('You do not have Access to ' + AppEnv.AccessLevels.GetFormDescription(ComponentClassName), mtWarning	, [mbOK], 0);
            Exit;
          end;
        end;
      end;
      if Owner = nil then begin
        Result := TComponentClass(Cls).Create(nil);
        if Assigned(Result) then begin

          SetObjectProperty(result , 'IgnoreAccessLevels' ,  not(CheckAccessLevel));

          if Assigned(Application.FindComponent(Result.Name)) then begin
            Index := 1;

            while Assigned(Application.FindComponent(Result.Name + IntToStr(Index))) do
              Inc(Index);

            Result.Name := Result.Name + IntToStr(Index);
          end;

          Application.InsertComponent(Result);
        end;
      end
      else
        Result := TComponentClass(Cls).Create(Owner);
    end;
  end;
end;


function FormStillOpen(const FormClassName: string): boolean; overload;
var
  aForm: TForm;
begin
  aForm:= TForm(FindExistingComponent(FormClassName));
  result:= Assigned(aForm);
end;

function FormStillOpen(const FormClassName: string; FormVar: TForm): boolean; overload;
var
  aForm: TForm;
begin
  aForm:= TForm(FindExistingComponent(FormClassName));
  result:= Assigned(aForm) and (aForm = FormVar);
end;

function FormStillOpen(const FormClassName: string; Const iTag:Integer): boolean; overload;
var
  aForm: TForm;
begin
  aForm := TForm(FindExistingComponent(FormClassName,iTag));
  result := Assigned(aForm);
end;

function GetComponentByClassType(Const ComponentClassType: TPersistentClass;
                                 Const SingleInstance: boolean = false;
                                 Const AOwner :TComponent = Nil): TComponent;
var
  Index: integer;
  DNMAccessManager: TDNMAccessManager;
  AccessLevel : integer;
begin
  Result := nil;

  if SingleInstance then begin
    Index := 0;
    while (Index < Application.ComponentCount) and (Result = nil) do begin
      if Application.Components[Index].ClassType = ComponentClassType then Result := Application.Components[Index]
      else Inc(Index);
    end;
  end;

  if not Assigned(Result) then begin
    //Check access levels
    DNMAccessManager := TDNMAccessManager.Create(nil);
    Try
      if Assigned(AppEnv.Employee) then begin
        AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(ComponentClassType.ClassName);
        if AccessLevel = 6 then begin
          MessageDlgXP_Vista('You do not have Access to ' + AppEnv.AccessLevels.GetFormDescription(ComponentClassType.ClassName), mtWarning	, [mbOK], 0);
          Exit;
        end;
      end;
      if Assigned(ComponentClassType) then
        if AOwner <> nil then
            Result := TComponentClass(ComponentClassType).Create(AOwner)
        else
            Result := TComponentClass(ComponentClassType).Create(Application);
    finally
      FreeandNil(DNMAccessManager);
    end
  end;
end;

// --------- API Functions -----------------------------------------------
function GetWindowsVersion: string;
const
  sWindowsVersion = '%s %s (%.3d) %s';
var
  OSInfo :TPJOSInfo;
begin
  OSInfo:= TPJOSInfo.Create;
  Try
    Result := Trim(Format(sWindowsVersion, [OSInfo.ProductName,OSInfo.Edition,OSInfo.BuildNumber,OSInfo.ServicePack]));
  Finally
    FreeAndNil(OSInfo);
  end;
end;

Procedure RefreshMemoryUsage;
begin
  systemlib.TrimWorkingSet;
(*Var
  MainHandle: THandle;
Begin
  MainHandle := OpenProcess(PROCESS_ALL_ACCESS, False, GetCurrentProcessID);
  SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
  CloseHandle(MainHandle);*)
End;

function SetControlFocus(Control: TWinControl): boolean;
begin
  Result := false;

  if Assigned(Control) and Control.Enabled and Control.Visible then begin
    Windows.SetFocus(Control.Handle);
    Result := Control.Focused;
  end;
end;

// --------- TXMLDocument/Node functions ---------------------------------------

function GetXMLNodeStringValue(const Node: IXMLNode; aNodeName: string; var XMLFieldNodeExists :Boolean): string;
var
  ValNode: IXMLNode;
begin
  Result := '';
  if Node = nil then Exit;
  aNodeName := LowerCase(aNodeName);
  ValNode := Node.ChildNodes.FindNode(aNodeName);
  XMLFieldNodeExists := Assigned(ValNode);
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Result := ValNode.NodeValue;
end;

function GetXMLNodeFloatValue(const Node: IXMLNode; aNodeName: string; var XMLFieldNodeExists :Boolean): double;
var
  ValNode: IXMLNode;
begin
  Result := 0;
  if Node = nil then Exit;
  aNodeName := LowerCase(aNodeName);
  ValNode := Node.ChildNodes.FindNode(aNodeName);
  XMLFieldNodeExists := Assigned(ValNode);
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Result := ValNode.NodeValue;
end;

function GetXMLNodeIntegerValue(const Node: IXMLNode; aNodeName: string; var XMLFieldNodeExists :Boolean): integer;
var
  ValNode: IXMLNode;
begin
  Result := 0;
  if Node = nil then Exit;
  aNodeName := LowerCase(aNodeName);
  ValNode := Node.ChildNodes.FindNode(aNodeName);
  XMLFieldNodeExists := Assigned(ValNode);
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Result := ValNode.NodeValue;
end;

function GetXMLNodeBooleanValue(const Node: IXMLNode; aNodeName: string; var XMLFieldNodeExists :Boolean): boolean;
var
  ValNode: IXMLNode;
begin
  Result := false;
  if Node = nil then Exit;
  aNodeName := LowerCase(aNodeName);
  ValNode := Node.ChildNodes.FindNode(aNodeName);
  XMLFieldNodeExists := Assigned(ValNode);
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Result := ValNode.NodeValue;
end;

Function  GetDate_FormatofMYSQL:String;
begin
  REsult := '%d/%m/%Y';
end;
function GetXMLNodeDateTimeValue(const Node: IXMLNode; aNodeName: string; var XMLFieldNodeExists :Boolean): TDateTime;
var
  ValNode: IXMLNode;
  saveDateFormat, saveTimeFormat: string;
  sDAta :String;
begin
  Result := 0;
  if Node = nil then Exit;
  aNodeName := LowerCase(aNodeName);
  saveDateFormat := FormatSettings.ShortDateformat;
  saveTimeFormat := FormatSettings.LongTimeFormat;

  FormatSettings.LongTimeFormat := MysqlTimeFormat;
  FormatSettings.LongTimeFormat := replaceStr(FormatSettings.LongTimeFormat , ':' , FormatSettings.TimeSeparator);

  FormatSettings.ShortDateformat := MysqlDateFormat;
  FormatSettings.ShortDateformat := replaceStr(FormatSettings.ShortDateformat , '-' , FormatSettings.DateSeparator);

  XMLFieldNodeExists := false;
  try
    ValNode := Node.ChildNodes.FindNode(aNodeName);
    XMLFieldNodeExists := Assigned(ValNode);
    if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then begin
        sDAta :=ValNode.NodeValue;
        sDAta := replaceStr(sDAta , ':' , FormatSettings.TimeSeparator);
        sDAta := replaceStr(sDAta , '-' , FormatSettings.DateSeparator);
        Result := StrToDateTime(sDAta);
    end;

  finally
    FormatSettings.ShortDateformat := saveDateFormat;
    FormatSettings.LongTimeFormat  := saveTimeFormat;
  end;
end;

Procedure AddXMLNode(Const Node : IXMLNode; Const sNodeName :String; Const Value : OleVariant; XMLTagsinLowercase :Boolean = True);
Var
  NodeName :String;
  sValue: OleVariant;
begin
    if node = nil then Exit;
    if snodeName = '' then Exit;
    if XMLTagsinLowercase then NodeName := LowerCase(sNodeName)
    else NodeName :=sNodeName;
    sValue := Value;
    if vartype(Value) = VarDate then
        if Value = '12:00:00 AM' then Exit{ignore blank date}
            else sValue := FormatDateTime( MysqlDateFormat, sValue); {dateTostr to convert the date into system date format}
    Node.Addchild(NodeName).NodeValue := sValue;
end;

function DateTimeToXMLStr(const DateTime: TDateTime): string;
var
  saveDateFormat, saveTimeFormat: string;
begin
  saveDateFormat := FormatSettings.ShortDateformat;
  saveTimeFormat := FormatSettings.LongTimeFormat;

  FormatSettings.LongTimeFormat := MysqlTimeFormat;
  FormatSettings.LongTimeFormat := replaceStr(FormatSettings.LongTimeFormat , ':' , FormatSettings.TimeSeparator);

  FormatSettings.ShortDateformat := MysqlDateFormat;
  FormatSettings.ShortDateformat := replaceStr(FormatSettings.ShortDateformat , '-' , FormatSettings.DateSeparator);

  try
    Result := DateTimeToStr(DateTime);
  finally
    FormatSettings.ShortDateformat := saveDateFormat;
    FormatSettings.LongTimeFormat  := saveTimeFormat;
  end;
end;
function InToStrWith0(const value :Integer ; const Leng :Integer):String;
var
    i :Integer;
begin
    Result := IntToStr(Value);
    REsult := ReplicateStr('0',Leng) + REsult;
    i :=char_length(Result);
    if i > leng then i := i - leng else i := 1;
    Result := copy(Result , i+1 , Leng);
end;
Function TruncateStr(Const Value :String ; const Leng :Integer; TrimResult :Boolean = true): String;
begin
    REsult := copy(Value + ReplicateStr(' ' , Leng) , 1, Leng);
    if TrimResult then Result := Trim(Result);
end;
Function ReplicateStr(Const Repeatingchar :String; const iCount :Integer) :String;
begin
    Result := '';
    if Repeatingchar = '' then exit;
    if icount <= 0 then exit;
    result := DupeString(Repeatingchar , icount);
end;
function Stringcontains(const Value, substr:String):Boolean;
begin
  result:= False;
  if length(value) < length(substr) then exit;
  if (substr = '') then exit;
  result := Pos(uppercase(substr) , uppercase(value)) <> 0;
end;
function StartsWith(const Value, substr:String):Boolean;
begin
  result:= False;
  if length(value) < length(substr) then exit;
  if (substr = '') then exit;
  result := Sametext(copy(value ,1, length(substr)) , substr);
end;
function RemoveInvalidAlphaNumericCharacters(const sValue: string): string;
var
  iIndex: integer;
  sNewValue: string;
begin
  sNewValue := sValue;
  for iIndex := 1 to char_length(sValue) do begin
    if not CharInSet(sValue[iIndex],['a'..'z', 'A'..'Z', '0'..'9', '_']) then begin
      sNewValue := StringReplace(sNewValue, sValue[iIndex], '_', [rfReplaceAll]);
    end;
  end;
  Result := sNewValue;
end;
function getOutGoingFileName(Prefix,Suffix , extension :String):String;
begin
    result := ValidfileName(Prefix +GetCompanyName + Suffix + '.' + replaceStr(extension , '.' , ''));
end;
function ValidFileName(filename:String):String;
begin
  result := GetValidfileName(filename);
  (*result :=filename;
  result := replaceStr(result , '"' , '');
  result := replaceStr(result , '*' , '');
  result := replaceStr(result , '/' , '');
  result := replaceStr(result , ':' , '');
  result := replaceStr(result , '<' , '');
  result := replaceStr(result , '>' , '');
  result := replaceStr(result , '?' , '');
  result := replaceStr(result , '\' , '');
  result := replaceStr(result , '|' , '');*)
end;
function GetMachineIdentification(const User, System, Network, Drives: boolean): string;
begin
  result := Systemlib.GetMachineIdentification(User, System, Network, Drives);
(*var
  InfoSet: TEsMachineInfoSet;
  MachineID: longint;
begin
  InfoSet := [];
  if User then InfoSet := InfoSet + [midUser];
  if System then InfoSet := InfoSet + [midSystem];
  if Network then InfoSet := InfoSet + [midNetwork];
  if Drives then InfoSet := InfoSet + [midDrives];

  MachineID := CreateMachineID(InfoSet);
  Result := BufferToHex(MachineID, SizeOf(MachineID));*)
end;
procedure ExitFocus(frm: TForm);
var
  I: integer;
begin
  with frm do begin
    for I := 0 to Controlcount - 1 do if Screen.ActiveControl = Controls[I] then Break;
    for I := I to Controlcount - 1 do if Controls[I] is TWinControl then if TWinControl(Controls[I]).Canfocus then begin
          SetControlFocus(TWinControl(Controls[I]));
          Exit;
        end;
    {if no controls found after the current control to set focus, Reverse the searching }
    for I := Controlcount - 1 downto 0 do if Controls[I] is TWinControl then if TWinControl(Controls[I]).Canfocus then begin
          SetControlFocus(TWinControl(Controls[I]));
          Exit;
        end;
  end;
end;
Function FindFormInstance(const FormName :STring ):TForm;
var
    I:Integer;
begin
    Result := nil;
    if Application.MainForm.MDIChildCount > 0 then
        for I := 0 to Application.MainForm.MDIChildCount - 1 do
            if Application.MainForm.MDIChildren[I].ClassName = formName then begin
                Result := Application.MainForm.MDIChildren[I];
                Exit;
            end;
end;

function FormInstance(const FormClassName : string) : TForm;
var
  idx : integer;
//  lForm : TForm;
begin
  for idx := 0 to Screen.FormCount - 1 do
  begin
    Result := Screen.Forms[idx];
    if Result.ClassNameIs(FormClassName) then
      exit;
  end;
  Result := nil;
end;

Function Isformvisible(Const FormName :STring ): boolean;
var
    I:Integer;
begin
    Result := False;
    if Application.MainForm.MDIChildCount > 0 then
        for I := 0 to Application.MainForm.MDIChildCount - 1 do
            if Application.MainForm.MDIChildren[I].ClassName = formName then begin
                Result := True;
                Exit;
            end;
end;

Function Productcolumn(Const AliasName : String; Const colctr :Integer):String;
begin
    if colctr = 1 then
        result :=   'If(InStr(' + AliasName + '.PRODUCTGROUP,"^") -1 >0,Left(' + AliasName +
                    '.PRODUCTGROUP,InStr(' + AliasName + '.PRODUCTGROUP,"^")-1),' + AliasName +
                    '.PRODUCTGROUP) '
    else if colctr = 2 then
        result :=   'MID(' + AliasName + '.PRODUCTGROUP,InStr(' + AliasName + '.PRODUCTGROUP,"^")+1,' +
                    'If(LOCATE("^",' + AliasName + '.PRODUCTGROUP,InStr(' + AliasName +
                    '.PRODUCTGROUP,"^")+1)-InStr(' + AliasName + '.PRODUCTGROUP,"^")>0,' +
                    'LOCATE("^",' + AliasName + '.PRODUCTGROUP,InStr(' + AliasName +
                    '.PRODUCTGROUP,"^")+1)-1-InStr(' + AliasName + '.PRODUCTGROUP,"^"),' +
                    'IF(InStr(' + AliasName + '.PRODUCTGROUP,"^")<>0,char_length(' + AliasName +
                    '.PRODUCTGROUP)-InStr(' + AliasName + '.PRODUCTGROUP,"^"),0))) '
    else if colctr = 3 then
        Result :=   'if((LOCATE("^",' + AliasName + '.PRODUCTGROUP,InStr(' + AliasName +
                    '.PRODUCTGROUP,"^")+1)) >0, MID(' + AliasName + '.PRODUCTGROUP,LOCATE("^",  ' +
                    AliasName + '.PRODUCTGROUP, InStr(' + AliasName +
                    '.PRODUCTGROUP,"^")+1)+1, char_length(' + AliasName + '.PRODUCTGROUP)- LOCATE("^",' + AliasName +
                    '.PRODUCTGROUP,InStr(' + AliasName + '.PRODUCTGROUP,"^")+1)),  "") ';

end;

function HintInEditMode: boolean;
begin
  Result := AppEnv.CompanyPrefs.HintInEditMode;
end;

//function MessageDlgS(const Msg: string; DlgType: TMsgDlgType;
//  Buttons: TMsgDlgButtons; HelpCtx: Longint): Word;
//var
//  PlaySound: TSoundObj;
//begin
//  PlaySound := TSoundObj.Create;
//  try
//    if (DlgType = mtConfirmation) or (DlgType = mtWarning) or (DlgType = mtInformation) then begin
//      PlaySound.Sound('Error','');
//    end;
//  finally
//    FreeAndNil(PlaySound);
//  end;
//  Result := MessageDlgXP_Vista(Msg,DlgType,Buttons,HelpCtx);
//end;
Procedure ShowWarning(const Value:String);
begin
  MessageDlgXP_Vista(Value , mtWarning, [mbok],0);
end;
Procedure PlaySound(const DoPlaySound:Boolean; Soundfielname:String);
begin
  if not DoPlaySound then Exit;
  if Soundfielname = '' then exit;
  if not (FileExists(Soundfielname)) then exit;
  sndPlaySound(pchar(Soundfielname),SND_ASYNC );
end;
Procedure PlaySaveSound   ;begin  PlaySound(Appenv.CompanyPrefs.EnableSoundonSave   , trim(AppEnv.CompanyPrefs.Savesoundfile))  ;end;
Procedure PlayCancelSound ;begin  PlaySound(Appenv.CompanyPrefs.EnableSoundonCancel , trim(AppEnv.CompanyPrefs.Cancelsoundfile));end;
Procedure PlayEmailSound  ;begin  PlaySound(Appenv.CompanyPrefs.EnableSoundonEmail  , trim(AppEnv.CompanyPrefs.Emailsoundfile)) ;end;
Procedure PlayPrintSound  ;begin  PlaySound(Appenv.CompanyPrefs.EnableSoundonPrint  , trim(AppEnv.CompanyPrefs.Printsoundfile)) ;end;
Function CeasePreferenceNames(Const Value:String):String;
begin
    Result := Value;
    if Pos(Appenv.DefaultClass.EquipmentName  , Result)>0 then Result:= replacestr(Result , Appenv.DefaultClass.EquipmentName ,'Equipment' );
    if Pos(Appenv.DefaultClass.HireName       , Result)>0 then Result:= replacestr(Result , Appenv.DefaultClass.HireName      ,'Hire' );
end;

Function ApplyPreferenceNames(Const Value:String):String;
begin
    Result := Value;
    if Pos('Equipment'  , Result)>0 then Result:= replacestr(Result , 'Equipment' , Appenv.DefaultClass.EquipmentName);
    if Pos('Hire'       , Result)>0 then Result:= replacestr(Result , 'Hire'      , Appenv.DefaultClass.HireName);
end;
function MessageDlgXP_Vista(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint;
        const Owner: TComponent=nil;
        const Instruction: string = '';
        const VerifyText: string = '';
        const VerifyChecked: boolean = false;
        OnVerifyClick: TTaskDialogVerifyClickEvent = nil;
        const CustomButtonsStr :String = '';
        Soundfilename:String = '';MsgBoxWidth:Integer=0): Word;
var
  fsMsg:String;
  aSavedCursor: TCursor;

  Procedure SendToBackProgressbar;
  begin
    try
      if Assigned(ProgressDialogInst) and (ProgressDialogInst.visible) then begin
        ProgressDialogInst.Stayontop := False;
        ProgressDialogInst.InitformToCentre;
        ProgressDialogInst.Top := ProgressDialogInst.Top- 200;
      end;
    Except
    end;
  end;

  Procedure bringtofrontProgressbar;
  begin
    try
      if Assigned(ProgressDialogInst) and (ProgressDialogInst.visible) then begin
        ProgressDialogInst.InitformToCentre;
        ProgressDialogInst.Stayontop := true;
      end;
    Except
    end;
  end;

begin
  fbMessaging:= true;
  try
    SendtoBackProgressbar;
    try
      aSavedCursor := Screen.cursor;
      try
        Screen.cursor := crArrow;
        fsMsg := ApplyPreferenceNames(Msg);
        if Soundfilename<> ''  then
          if FileExists(Soundfilename) then
            sndPlaySound(pchar(Soundfilename),SND_ASYNC );
      (*  {$IFDEF EXCEPTIONAL_MAGIC}
          UserActions.Add(uetNone, 0, 0, 'User Message :' + Quotedstr(MSG) +'(' + MsgOptions+')');
        {$ENDIF}*)
        Result := Vista_MessageDlg.MessageDlgXP_Vista(fsMsg, DlgType,Buttons,HelpCtx, Owner, Instruction, VerifyText,VerifyChecked, OnVerifyClick,CustomButtonsStr , MsgBoxWidth);
      finally
        Screen.cursor := aSavedCursor;
      end;
    finally
      bringtofrontProgressbar;
    end;
  finally
    fbMessaging := False;
  end;
end;

(*function MessageDlgXPEx(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Captions: array of string): Integer;
var
  aMsgDlg: TForm;
  i: Integer;
  dlgButton: TButton;
  CaptionIndex: Integer;
begin
//  aMsgDlg := CreateMessageDialog(Msg, DlgType, Buttons);
  aMsgDlg := CreateMessageDialog(ApplyPreferenceNames(Msg), DlgType, Buttons);
  captionIndex := 0;
  { Loop through Objects in Dialog }
  for i := 0 to aMsgDlg.ComponentCount - 1 do
  begin
   { If the object is of type TButton, then }
    if (aMsgDlg.Components[i] is TButton) then
    begin
      dlgButton := TButton(aMsgDlg.Components[i]);
      if CaptionIndex > High(Captions) then Break;
      { Give a new caption from our Captions array}
      dlgButton.Caption := Captions[CaptionIndex];
      Inc(CaptionIndex);
    end;
  end;
  Result := aMsgDlg.ShowModal;
end;*)


Function  XMLImportResultDocName:string;
begin
    Result := fsXMLImportResultDocName;
end;
Procedure SetXMLImportResultDocName(Const Value :String) ;
begin
    fsXMLImportResultDocName := Value;
end;

Function  XMLExportResultDocName:string;
begin
    Result := fsXMLExportResultDocName;
end;
Procedure SetXMLExportResultDocName(Const Value :String) ;
begin
    fsXMLExportResultDocName := Value;
end;

Function NewResultNode(Const nodeName :String) :IXMLNode;
var
    node: IXMLNode;
begin
    if XMLImportResultDoc.ChildNodes.FindNode(XMLDocResponseRoot) <> nil then
       node:= XMLImportResultDoc.ChildNodes.FindNode(XMLDocResponseRoot)
    else node:= XMLImportResultDoc.AddChild(XMLDocResponseRoot);
    node.Attributes['DataVersion'] := getUserVersion;
    if node.ChildNodes.FindNode('Importstatus') <> nil then
        node:= node.ChildNodes.FindNode('Importstatus')
    else node := node.Addchild('Importstatus');
    if node.ChildNodes.FindNode(nodeName) <> nil then
        node:= node.ChildNodes.FindNode(nodeName)
    else node := node.Addchild(nodeName);
    Result :=node;
end;
Procedure InitResultXMLDoc;
begin
  FreeXMLImportResultDoc;
end;

Function XMLImportResultDoc: IXMLDocument;
begin
    if not assigned(foXMLImportResultDoc) then begin
        foXMLImportResultDoc := TXMLDocument.Create(nil);
        foXMLImportResultDoc.Active := true;
        foXMLImportResultDoc.Encoding := XMLDocEncoding;
        { NOTE: Do not use doNodeAutoIndent option as this stuffs up XML
                comparison in business objects (indents are returned as Text nodes) }

        //foXMLImportResultDoc.Options := [doNodeAutoIndent];
        foXMLImportResultDoc.Version := XMLDocVersion;
        foXMLImportResultDoc.AddChild(XMLDocResponseRoot).Addchild('Importstatus');
    end;
    Result := foXMLImportResultDoc;
end;
Procedure FreeXMLImportResultDoc ;
begin
   if Assigned(foXMLImportResultDoc)        then FreeandNil(foXMLImportResultDoc);
end;

{ Can be used in place of the "is" operator where we want to use ancestor class name }
function IsClassByString(const aObject: TObject; const aClassName: string): boolean;
var
  ClassRef: TClass;
begin
  result:= false;
  ClassRef:= aObject.ClassType;
  while ClassRef <> nil do begin
    if ClassRef.ClassNameIs(aClassName) then begin
      result:= true;
      break;
    end;
    ClassRef:= ClassRef.ClassParent;
  end;
end;

procedure RegisterClassOnce(const AClass: TPersistentClass);
begin
  if GetClass(AClass.ClassName) = nil then begin
    try
      Classes.RegisterClass(AClass);
      {$IFDEF GET_HELPCONTEX_INFO}
      If not Assigned(AllRegisteredClass) then begin
        AllRegisteredClass := TStringList.Create;
        AllRegisteredClass.Sorted    := true;
        AllRegisteredClass.Duplicates := dupIgnore;
      end;
      AllRegisteredClass.Add(AClass.ClassName)
      {$ENDIF}
    except
      raise Exception.Create('Error registering class: ' + aClass.ClassName);
    end;
  end
end;

function MysqlDateStrToDate(const MsqlDate: string): TDateTime;
var
  Year1, Month1, Day1: word;
  Date1: TDateTime;
begin
  Result := 0;
  If Empty(MsqlDate) then Exit;
  Year1 := StrToInt(ExtractStrPortion(MsqlDate, '-', 1));
  Month1 := StrToInt(ExtractStrPortion(MsqlDate, '-', 2));
  Day1 := StrToInt(ExtractStrPortion(MsqlDate, '-', 3));
  if TryEncodeDate(Year1, Month1, Day1, Date1) then begin
    Result := EncodeDate(Year1, Month1, Day1);
  end;
end;
function MonthNumberToName(const Month: Integer): String;
begin
  REsult := '';
       if Month = 1  then result := 'January'
  else if Month = 2  then Result := 'February'
  else if Month = 3  then Result := 'March'
  else if Month = 4  then Result := 'April'
  else if Month = 5  then Result := 'May'
  else if Month = 6  then Result := 'June'
  else if Month = 7  then Result := 'July'
  else if Month = 8  then Result := 'August'
  else if Month = 9  then Result := 'September'
  else if Month = 10 then Result := 'October'
  else if Month = 11 then Result := 'November'
  else if Month = 12 then Result := 'December';
end;
function MonthNameToNumber(const Month: string): integer;
begin
  if Month = 'January' then begin
    Result := 1;
  end else if Month = 'February' then begin
    Result := 2;
  end else if Month = 'March' then begin
    Result := 3;
  end else if Month = 'April' then begin
    Result := 4;
  end else if Month = 'May' then begin
    Result := 5;
  end else if Month = 'June' then begin
    Result := 6;
  end else if Month = 'July' then begin
    Result := 7;
  end else if Month = 'August' then begin
    Result := 8;
  end else if Month = 'September' then begin
    Result := 9;
  end else if Month = 'October' then begin
    Result := 10;
  end else if Month = 'November' then begin
    Result := 11;
  end else if Month = 'December' then begin
    Result := 12;
  end else begin
    Result := 0;
  end;
end;


function DateTimeToMysqlDateStr(const aDateTime: TDateTime): string;
begin
  result:= FormatDateTime(MysqlDateTimeFormat,aDateTime);
end;

procedure PerformPaints;
var
  Msg: TMsg;
begin
  while PeekMessage(Msg, 0, WM_PAINT, WM_PAINT, PM_REMOVE) do
    DispatchMessage(Msg);
end;

procedure InvalidateComponents(Const RootComponent: TComponent;Const IncludedLabels:Boolean);
Var
  I:Integer;
begin
  for I := 0 to RootComponent.ComponentCount - 1 do begin
    if (RootComponent.Components[I] is TDNMSpeedButton) then begin
      TDNMSpeedButton(RootComponent.Components[I]).Update;
      TDNMSpeedButton(RootComponent.Components[I]).Invalidate;
    end;
    if (RootComponent.Components[I] is TwwDBGrid) then begin
      TwwDBGrid(RootComponent.Components[I]).Update;
      TwwDBGrid(RootComponent.Components[I]).Invalidate;
    end;
    if IncludedLabels AND (RootComponent.Components[I] is TLabel) then begin
      TLabel(RootComponent.Components[I]).Update;
      TLabel(RootComponent.Components[I]).Invalidate;
    end;
  end;
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
Procedure ReadonlyGrid(CurGrid:twwDBGrid);
begin
  CurGrid.readonly := TRue;
  CurGrid.multiselectOptions := CurGrid.multiselectOptions  - [msoAutoUnselect];
  CurGrid.multiselectOptions := CurGrid.multiselectOptions  - [msoShiftSelect];
  CurGrid.Options := CurGrid.Options - [dgEditing];
end;

(*procedure Setcolwidths(CurGrid:twwDBGrid; Adjustthewidest:Boolean =False);
var
    ctr:Integer;
    ft:Integer;

    function Widestcolumnindex:Integer;
    var
      i,x:Integer;
    begin
      result:=1;
      x :=   CurGrid.ColWidths[1];
      for i := 0 to CurGrid.GetColCount -1 do
        if CurGrid.Columns[i].visible then
          if x < CurGrid.ColWidths[i] then begin
            x:=CurGrid.ColWidths[i];
            result :=i;
          end;

    end;
    function Indicatorwidth:Integer;
    begin
      result := iif(assigned(CurGrid.IndicatorButton) and (CurGrid.IndicatorButton.visible), CurGrid.IndicatorButton.Width,0);
      if result<0 then result:= 0;
      if CurGrid.ShowVertScrollBar then  result := result + 7;
    end;
    function colwidths:String;
    var
      t,i:Integer;

    begin
      result := '';
      t:= 0;
      for i := 1 to CurGrid.GetColCount -1 do begin
        if CurGrid.Columns[i].visible then
          result := result + NL+ CurGrid.Columns[i].FieldName +':' + inttostr(CurGrid.ColWidths[i]);
          t:= t+CurGrid.ColWidths[i];

      end;
      result := trim(Result)+NL+inttostr(curgrid.Width)+':' +inttostr(t);
    end;

begin
  if Settingcolwidth then exit;
  Logtext('1:' + curGrid.Selected.Text);
  Settingcolwidth:= True;
  try
    ft:= 0;
    for ctr := 0 to CurGrid.GetColCount -1 do
      if CurGrid.Columns[ctr].visible then
          ft:= ft +CurGrid.ColWidths[ctr];
    ctr:= 1;
    if Adjustthewidest  then begin
      if ft < CurGrid.Width-Indicatorwidth then begin
        while ft < CurGrid.Width-Indicatorwidth do begin
            ctr:= Widestcolumnindex;
            CurGrid.ColWidths[ctr] := CurGrid.ColWidths[ctr]+1;
            ft:= ft+1;
        end;
      end else begin
        while ft > CurGrid.Width-Indicatorwidth do begin
          ctr:= Widestcolumnindex;
          CurGrid.ColWidths[ctr] := CurGrid.ColWidths[ctr]-1;
          ft:= ft-1;
        end;
      end;

    end else begin
      if (ft <> CurGrid.Width-Indicatorwidth ) then  begin
        while ft <= CurGrid.Width-Indicatorwidth do begin
            if CurGrid.Columns[ctr].visible then begin
              CurGrid.ColWidths[ctr] := CurGrid.ColWidths[ctr]+1;
              ft:= ft+1;
            end;
            ctr:= ctr+1;
            if ctr>=CurGrid.GetColCount then ctr:= 1;
        end;
      end else begin
        while ft > CurGrid.Width-Indicatorwidth do begin
          if CurGrid.Columns[ctr].visible then begin
              CurGrid.ColWidths[ctr] := CurGrid.ColWidths[ctr]-1;
              ft:= ft-1;
          end;
          ctr:= ctr+1;
          if ctr>=CurGrid.GetColCount then ctr:= 1;
        end;
      end;
    end;
    Logtext('2:' + curGrid.Selected.Text);
    Application.ProcessMessages;
  finally
    Settingcolwidth:= False;
  end;
end;*)

{procedure Setcolwidth(CurGrid:twwDBGrid; Adjustthewidest:Boolean =False);
var
    ctr:Integer;
    ft:Integer;
    function Widestcolumnindex:Integer;
    var
      i,x:Integer;
    begin
      result:=1;
      x :=   CurGrid.ColWidthsPixels[1];
      for i := 1 to CurGrid.GetColCount -1 do
        if x < CurGrid.ColWidthsPixels[i] then begin
          x:=CurGrid.ColWidthsPixels[i];
          result :=i;
        end;
    end;
    function Narroestcolumnindex:Integer;
    var
      i,x:Integer;
    begin
      result:=1;
      x :=   CurGrid.ColWidthsPixels[1];
      for i := 1 to CurGrid.GetColCount -1 do
        if x > CurGrid.ColWidthsPixels[i] then begin
          x:=CurGrid.ColWidthsPixels[i];
          result :=i;
        end;
    end;
    function Indicatorwidth:Integer;
    begin
      result := CurGrid.ColWidthsPixels[0];
      if result<0 then result:= 0;
    end;
begin
  if Settingcolwidth then exit;
  Logtext('1:' + curGrid.Selected.Text);
  Settingcolwidth:= True;
  try
    ft:= 0;
    for ctr := 1 to CurGrid.GetColCount -1 do
          ft:= ft +CurGrid.ColWidthsPixels[ctr];
    ctr:= 1;
    if Adjustthewidest  then begin
      while (ft <> CurGrid.clientWidth-5-Indicatorwidth ) do begin
        if ft <= CurGrid.clientWidth-5-Indicatorwidth then begin
            ctr:= Widestcolumnindex;
            CurGrid.ColWidthsPixels[ctr] := CurGrid.ColWidthsPixels[ctr]+1;
            ft:= ft+1;
        end else begin
          ctr:= Widestcolumnindex;
          CurGrid.ColWidthsPixels[ctr] := CurGrid.ColWidthsPixels[ctr]-1;
          ft:= ft-1;
        end;
      end;
    end else begin
      while (ft <> CurGrid.clientWidth-5-Indicatorwidth ) do begin
          if ft <= CurGrid.clientWidth-5-Indicatorwidth then begin
              CurGrid.ColWidthsPixels[ctr] := CurGrid.ColWidthsPixels[ctr]+1;
              ft:= ft+1;
          end else begin
              CurGrid.ColWidthsPixels[ctr] := CurGrid.ColWidthsPixels[ctr]-1;
              ft:= ft-1;
          end;
        ctr:= ctr+1;
        if ctr>=CurGrid.GetColCount then ctr:= 1;
      end;
    end;
(*    for ctr := 1 to CurGrid.GetColCount -1 do
          CurGrid.ColWidths[ctr] := trunc(CurGrid.ColWidthsPixels[ctr]/8);*)
    Application.ProcessMessages;
    Logtext('2:' + curGrid.Selected.Text);
  finally
    Settingcolwidth:= False;
  end;
end; }

procedure ListNonGUIFields(grid: TwwDbGrid);
var
  sl: TStringList;
  x, y: integer;
  s: string;
begin
  sl:= TStringList.Create;
  try
    for x:= 0 to grid.DataSource.DataSet.FieldCount -1 do begin
      s:= grid.DataSource.DataSet.Fields[x].FieldName;
      for y:= 0 to grid.Selected.Count -1 do begin
        if Pos(s,grid.Selected[y]) > 0 then begin
          s:= '';
          break;
        end;
      end;
      if s <> '' then
        sl.Add(s);
    end;
    s:= sl.CommaText;
    sl.Clear;
    sl.Add(s);
    sl.SaveToFile('Grid_Fields_' + grid.Name + '.txt');
  finally
    sl.Free;
  end;
end;

//Function ConfirmEmailId(var emailchanged:Boolean; const EmailEdit:TWincontrol; const ds:TDataset; const emailIdfieldname:String):boolean;
//var
//  ans:Word;
//begin
//  result := True;
//  if emailchanged  then begin
//      ans := MessageDlgXP_Vista('Is "' + ds.fieldbyname(emailIdfieldname).asString +'" the correct email address?',
//          mtconfirmation, [mbYes,mbNo, mbcancel], 0);
//      if ans = mrCancel then begin
//        SetControlFocus(EmailEdit);
//        result := False;
//        exit;
//      end else if ans = mrno then begin
//        if ds.RecordCount = 1 then begin
//          EditDB(ds);
//          ds.fieldbyname(emailIdfieldname).asString:='';
//          PostDB(ds);
//        end;
//
//        SetControlFocus(EmailEdit);
//        result := False;
//
//        emailchanged:= False;
//      end else if ans = mryes then begin
//        result := TRue;
//        emailchanged:= False;
//      end;
//  end;
//end;

//function MakeEmailID(var emailchanged: Boolean; const firstname, LastName , Email, ClientName :String):String;
//var
//  suffix: string;
//begin
//  Result := Email;
//  suffix:= '.com';
//  if Appenv.RegionalOptions.RegionType = rAust then
//    suffix:= '.com.au'
//  else if Appenv.RegionalOptions.RegionType = rUK then
//    suffix:= '.co.uk'
//  else if Appenv.RegionalOptions.RegionType = rNZ then
//    suffix:= '.co.nz'
//  else if Appenv.RegionalOptions.RegionType = rRSA then
//    suffix:= '.co.za';
//  if (Email = '' ) or
//    (Email = LowerCase(StringReplace(FirstName+'@' +Trim(ClientName)+suffix , ' ' , '' , [rfReplaceAll]))) or
//    (Email = StringReplace(FirstName+'@' +Trim(FirstName)+suffix , ' ' , '' , [rfReplaceAll])) or
//    (Email = StringReplace(LastName+'@' +Trim(LastName)+suffix , ' ' , '' , [rfReplaceAll])) or
//    (Email = StringReplace(LastName  +'@' +Trim(ClientName)+suffix , ' ' , '' , [rfReplaceAll])) or//then begin
//
//
//  emailChanged then begin
//    Result:= Trim(FirstName)+ '.' + Trim(LastName)+'@' +Trim(ClientName)+suffix;
//    Result:= StringReplace(Result , ' ' , '' , [rfReplaceAll]);
//    Result := LowerCase(Result);
//    emailchanged:= true;
//  end;
//
//end;

function SearchStringList(StringList :TStringList; SearchValue:String):Integer;
var
  ctr:Integer;
begin
    result := -1;
    for ctr := 0 to StringList.Count-1 do
      if SameText(StringList[ctr] , SearchValue) then begin
          REsult := ctr;
          break;
      end;
end;
function SearchstrArray(Value :String; ArrayValue :Array of String):Boolean;
var
    ctr:Integer;
begin
    Result := False;
    if Length(ArrayValue) = 0 then exit;
    for ctr := low(ArrayValue) to high(ArrayValue) do
      if SameText(ArrayValue[ctr] ,Value) then begin
          REsult := true;
          Exit;
      end;
end;
function ClientDetails(const Value:TDataset ; const isbilldetails:Boolean = False) :String;
  function readdataset(const fsfieldnames :array of String; Prefix,sufix:String):String;
    var    ctr:Integer;
  begin
    for ctr:=low(fsfieldnames) to high(fsfieldnames) do
      if Value.findfield(fsfieldnames[ctr])<> nil then begin
        if Value.FieldByname(fsfieldnames[ctr]).asString <> '' then
        result := Prefix + Value.FieldByname(fsfieldnames[ctr]).asString+Sufix;
      end;
  end;
begin
  (*if not Value.FieldByName('contacttitle').IsNull then Result  := Value.FieldByName('contacttitle').AsString;*)
  REsult := readdataset(['Title' , 'ContactTitle'],  '', '');
  (*if not Value.FieldByName('contactfirstname').IsNull then if Result = '' then
          Result := Value.FieldByName('contactfirstname').AsString
  else Result := Result + ' ' + Value.FieldByName('contactfirstname').AsString;*)
  REsult := REsult + ' ' +readdataset(['Firstname' , 'ContactfirstName'],  '', '');
  (*if not Value.FieldByName('contactsurname').IsNull then if Result = '' then
          Result := Value.FieldByName('contactsurname').AsString
  else Result := Result + ' ' + Value.FieldByName('contactsurname').AsString;*)
  REsult := REsult + ' ' +readdataset(['Surname' , 'contactsurname', 'Lastname'], '', '');

  if not isbilldetails then
    result :=
        Result +
        readdataset(['Address'  , 'ContactAddress'  , 'Street']       , #13 +#10  , '')(*Value.FieldByName('ContactAddress').AsString *)+
        readdataset(['Address2' , 'ContactAddress2' , 'Street2']      , #13 +#10  , '')(*Value.FieldByName('ContactAddress2').AsString *)+
        readdataset(['Address3' , 'ContactAddress3' , 'street3']      , #13 +#10  , '')(*Value.FieldByName('ContactAddress3').AsString *)+
        readdataset(['city'     , 'ContactCity'     , 'suburb']       , #13 +#10  , '')(*Value.FieldByName('ContactCity').AsString *)+
        readdataset(['State'    , 'ContactState']                     , ' ' , '')(*Value.FieldByName('ContactState').AsString *)+
        readdataset(['Postcode' , 'ContactPcode']                     , ' ' , '')(*Value.FieldByName('ContactPcode').AsString*)
  else
  result :=
        Result +
        readdataset(['Address'  , 'ContactAddress'  , 'billstreet']   , #13 +#10  , '')(*Value.FieldByName('ContactAddress').AsString *)+
        readdataset(['Address2' , 'ContactAddress2' , 'billstreet2']  , #13 +#10  , '')(*Value.FieldByName('ContactAddress2').AsString *)+
        readdataset(['Address3' , 'ContactAddress3' , 'billstreet3']  , #13 +#10  , '')(*Value.FieldByName('ContactAddress3').AsString *)+
        readdataset(['city'     , 'ContactCity'     , 'billsuburb']   , #13 +#10  , '')(*Value.FieldByName('ContactCity').AsString *)+
        readdataset(['billState'    , 'ContactState']                 , ' ' , '')(*Value.FieldByName('ContactState').AsString *)+
        readdataset(['billPostcode' , 'ContactPcode']                 , ' ' , '')(*Value.FieldByName('ContactPcode').AsString*);

end;
function IsDir(const DirPath: string): boolean;
begin
  Result := DirectoryExists(DirPath);
end;
function IsFile(const FileName: string): boolean;
begin
  Result := FileExists(FileName);
end;
function StripCR(  const sString: string; ReplaceWith :String =' '): string;
begin
  Result:= sString;
  Result := StringReplace(Result, #$D#$A     , ReplaceWith      , [rfReplaceAll,rfIgnoreCase]);
end;
function StripQuotes(  const sString: string): string;
begin
  Result:= sString;
  Result := StringReplace(Result, '""'    , '~|||~' , [rfReplaceAll,rfIgnoreCase]);
  Result := StringReplace(Result, '"'     , ''      , [rfReplaceAll,rfIgnoreCase]);
  Result := StringReplace(Result, '~|||~' , '"'     , [rfReplaceAll,rfIgnoreCase]);
end;

{ makes sure we cam create/read/write to a file }
function CanUseFile(aFileName: string; var msg: string): boolean;
var
  ini: TIniFile;
  s, val, sect, idt: string;
begin
  result:= false;
  ini:= nil;
  try
    try
      ini:= TIniFile.Create(aFileName);
      sect:= '_Test_File_Read-Write_Section_';
      idt:= '_Test_Read-Write_Ident_';
      val:= '_Test_Value_' + FormatDateTime('dd-mm-yy_hh-nn-ss-zzz',now);
      ini.WriteString(sect,idt,val);
      s:= ini.ReadString(sect,idt,'');
      if s <> val then
        raise Exception.Create('Error writing and reading value to file.');
      ini.EraseSection(sect);
      result:= true;
    except
      on E: exception do begin
        msg:= 'ERP is trying to use the following file: ';
        if Assigned(ini) then msg:= msg + ini.FileName
        else msg:= msg + aFileName;
        msg:= msg +
        ' but Windows is preventing access to this with the message: ' + e.Message +
        #13#10 + #13#10 +
        'Please have your system administrator ensure that you have access rights to this file/directory.';
      end;
    end;
  finally
    ini.Free;
  end;
end;
function StrExtStr(const HSrc: string; const Delim: string; const Count: integer): string;
var
  S: integer;
  E: integer;
  L9: integer;
  Src: string;
begin
  Src := HSrc + Delim;
  S := 1;
  for L9 := 1 to Count - 1 do begin
    S := Pos(Delim, Src);
    if S > 0 then Delete(Src, S, char_length(Delim))
    else Break;
  end;

  Result := '';
  if S > 0 then begin
    E      := Pos(Delim, Src + Delim);
    Result := Copy(Src, S, E - S);
  end;
end;
function LineCount(const FileName: string): integer;
var
  Count: integer;
  F: TextFile;
begin
  Count := 0;
  if not FileExists(FileName) then begin
    Result := 0;
    Exit;
  end;
  AssignFile(F, FileName);
  try
    {$I-}
    Reset(F);
    {$I+}
    IOResult;
    while not Eof(F) do begin
      Readln(F);
      Inc(Count);
    end;
    CloseFile(F);
    Result := Count;
  except
    CommonLib.MessageDlgXP_Vista('File is Already in Use!', mtWarning, [mbOK], 0);
    Result := 0;
  end;
end;
function SelectedIDs(grd:TwwDBGrid; IDFieldname: string; ignoreduplicates: boolean = false): string; overload;
var
  St: TStringList;
begin
  St := TStringList.Create;
  try
    SelectedIDs(grd, IDFieldname, St, ignoreduplicates);
  finally
    St.Delimiter := ',';
    Result := St.DelimitedText;
    FreeandNil(St);
  end;
end;
Procedure SelectedIDs(grd:TwwDBGrid; IDFieldname:String;var St:TIntegerList; ignoreduplicates:Boolean = False; DoCheckrec:TBoolFunc=nil)(*:String*);
var
    i:Integer;
begin
  st.clear;
  DoShowProgressbar(grd.SelectedList.Count, WAITMSG);
  try
    grd.Datasource.dataset.DisableControls;
    try
      if grd.SelectedList.Count > 0 then begin
          for i := 0 to grd.SelectedList.Count - 1 do begin
            grd.Datasource.dataset.GotoBookmark(grd.SelectedList.Items[i]);
            if grd.Datasource.dataset.fieldByname(IDFieldname).asinteger <> 0 then begin
              if Assigned(DoCheckrec) and not(DoCheckrec(grd)) then continue
              else if ignoreduplicates then
                st.AddIfNotInList(grd.Datasource.dataset.fieldByname(IDFieldname).asInteger)
              else st.add(grd.Datasource.dataset.fieldByname(IDFieldname).asInteger);
            end;
            DoStepProgressbar;
          end;
      end;
    finally
      grd.Datasource.dataset.EnableControls;
    end;
  finally
    DoHideProgressbar;
  end;
end;
Procedure SelectedIDs(grd:TwwDBGrid; IDFieldname:String;var St:TStringlist; ignoreduplicates:Boolean = False; DoCheckrec:TBoolFunc=nil)(*:String*);
var
    i:Integer;
begin
  DoShowProgressbar(grd.SelectedList.Count, WAITMSG);
  try
    grd.Datasource.dataset.DisableControls;
    try
      if grd.SelectedList.Count > 0 then
      begin
        for I := 0 to grd.SelectedList.Count - 1 do
        begin
          grd.Datasource.dataset.GotoBookmark(grd.SelectedList.Items[I]);
          if grd.Datasource.dataset.FieldByname(IDFieldname).asinteger <> 0 then begin
            if Assigned(DoCheckrec) and not(DoCheckrec(grd)) then continue
            else if ignoreduplicates = False then
              St.Add(grd.Datasource.dataset.FieldByname(IDFieldname).asString)
            else if SearchStringList(St,
              grd.Datasource.dataset.FieldByname(IDFieldname).asString) < 0 then
              St.Add(grd.Datasource.dataset.FieldByname(IDFieldname).asString);
          end;
          DoStepProgressbar;
        end;
      end;
    finally
      grd.Datasource.dataset.EnableControls;
    end;
  finally
    DoHideProgressbar;
  end;
end;
Function SelectedData(grd:TwwDBGrid; Fieldname:String):String;
begin
  result := '';
  if grd.SelectedList.Count > 0 then begin
      grd.Datasource.dataset.GotoBookmark(grd.SelectedList.Items[0]);
      if (grd.Datasource.dataset.fieldByname(Fieldname) is TDateTimefield) then begin
        if grd.Datasource.dataset.fieldByname(Fieldname).asDatetime <> 0 then result:= formatDateTime(mysQLDateTimeformat , grd.Datasource.dataset.fieldByname(Fieldname).asDAteTime);
      end else if grd.Datasource.dataset.fieldByname(Fieldname).asString <> '' then begin
        result:= grd.Datasource.dataset.fieldByname(Fieldname).asString;
      end;
  end;
end;
function SelectedDatas(grd:TwwDBGrid; Fieldname:String;ignoreduplicates:Boolean = False):String;
var
  st:TStringlist;
  ctr:Integer;
begin
  result := '';
  st:= TStringlist.create;
  try
    SelectedDatas(grd,Fieldname,St,ignoreduplicates);
    if st.Count =0 then exit;
    for ctr := 0 to st.count-1 do begin
      if result <> '' then result := result +',';
      result := result + quotedstr(st[ctr]);
    end;
  finally
    Freeandnil(st);
  end;

end;

Procedure SelectedDatas(grd:TwwDBGrid; Fieldname:String;var St:TStringlist; ignoreduplicates:Boolean = False)(*:String*);
var
    i:Integer;
    s:String;
    bm: TBookmark;
begin
  st.clear;
  if grd.SelectedList.Count > 0 then begin
    bm := grd.Datasource.dataset.GetBookmark;
    try
        for i := 0 to grd.SelectedList.Count - 1 do begin
          grd.Datasource.dataset.GotoBookmark(grd.SelectedList.Items[i]);

          s:= '';
          if (grd.Datasource.dataset.fieldByname(Fieldname) is TDateTimefield) then begin
            if grd.Datasource.dataset.fieldByname(Fieldname).asDatetime <> 0 then s:= formatDateTime(mysQLDateTimeformat , grd.Datasource.dataset.fieldByname(Fieldname).asDAteTime);
          end else if grd.Datasource.dataset.fieldByname(Fieldname).asString <> '' then begin
            s:= grd.Datasource.dataset.fieldByname(Fieldname).asString;
          end;
          if s <> '' then
            if ignoreduplicates = false then
              st.add(s)
            else if SearchStringList(st, s) < 0 then
              st.add(s);
        end;
      grd.Datasource.dataset.GotoBookmark(bm);
    finally
      grd.Datasource.dataset.FreeBookmark(bm);
    end;
  end;
end;

function NowUTC: TDateTime;
var
  st: TSystemTime;
begin
  Windows.GetSystemTime(st);
  result:= EncodeDate(st.wYear,st.wMonth,st.wDay) +
    EncodeTime(st.wHour,st.wMinute,st.wSecond,st.wMilliseconds);
end;

function DateUTC: TDateTime;
begin
  result:= Trunc(NowUTC);
end;
Function LocalTimezoneInfo :   TTimeZoneInformation;
var
  TZInfo:   TTimeZoneInformation;
begin
  GetTimeZoneInformation(TZInfo);
  result :=TZInfo;
end;
function MilliSecondsTotime(MilliSecs:Integer):String;
begin
  result := SecondsToTime(Trunc(MilliSecs/1000));
  if MilliSecs - Trunc(MilliSecs/1000) >0 then
    if result <>'' then result := result +':' +inttostr(MilliSecs - Trunc(MilliSecs/1000))
    else result := inttostr(MilliSecs - Trunc(MilliSecs/1000));
end;
function TimeToSeconds(const value:String): Integer;
var
  st:TStringlist;
  ctr , i:integer;
const
  seconds : array[0..3] of Integer =    (*(1,60,3600, 86400);//*) (86400,3600,60,1);
begin
  result:= 0;
  st:= tStringlist.Create;
  try
    DnmLib.SplitString(Value , ':' , st);
    if st.Count =0 then exit;
    for ctr:= 1 to st.Count do begin
      i:= st.Count - ctr;
      if (st[i] <> '') and ISInteger(st[i]) then
          result := result + strtoint(trim(st[i])) * seconds[4-ctr];
    end;
  finally
    Freeandnil(st);
  end;
end;
function SecondsToTime(secs: integer; CalcDays:boolean =False;details:Boolean=False;Resultwhen0:String = ''): string;
  var
    dd, hh, mm, ss: integer;
    function  Addtime(const resultValue, Value:String):String;
    begin
      result :=     resultValue;
      if value = '' then exit;
      if Result <> '' then Result := Result +':';
      Result := Result +Value;
    end;
  begin
    Result := '';
    if Secs=0 then begin
      REsult :=Resultwhen0;
      exit;
    end;
    if CalcDays then begin
      dd := secs div 86400;      secs :=secs mod 86400;
      if not details then
        Result := Addtime(result,FillString(IntToStr(dd), 4, ' ', true))
      else if dd>0 then result := inttostr(dd) +' days ';
    end;
    hh := secs div 3600;      secs :=secs mod 3600;
    mm := secs div 60;      secs :=secs mod 60;
    ss:= secs;

    if not details then begin
      Result := Addtime(result,FillString(IntToStr(hh), 2, '0', true)) ;
      Result := Addtime(result,FillString(IntToStr(mm), 2, '0', true)) ;
      Result := Addtime(result,FillString(IntToStr(ss), 2, '0', true)) ;
    end else begin
      if hh>0 then result := result + ' '+ inttostr(hh) +' hrs';
      if mm>0 then result := result + ' '+ inttostr(mm) +' mnts';
      if ss>0 then result := result + ' '+ inttostr(ss) +' secs';
    end;

  end;

function CtrlDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Control] And 128) <> 0) ;
end;

function ShiftDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Shift] and 128) <> 0) ;
end;

function AltDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Menu] and 128) <> 0) ;
end;

{$WARNINGS OFF}
function GetSendEmailtoErpExcLogFileName(const emaillogPrefix :String): string;
var
  ExeName: string;
begin
  ExeName := Application.ExeName;
  Result :=
    IncludeTrailingBackslash(ExtractFilePath(ExeName)) + ChangeFileExt(ExtractFileName(ExeName),
    '') + '_' + emaillogPrefix +'_' + FormatDateTime('YYYYMMDD_HHNNSS', SysUtils.Now) + '.txt';
end;
{$WARNINGS ON}
Function char_length(Const Value :String):Integer;
begin
  result := length(Value);
end;
function CurrencyRoundPlaces:Integer;
begin
  result := Appenv.RegionalOptions.DecimalPlaces;
end;
function LowestCurrencyDecimalValue:double;
begin
  Result := Math.IntPower(10,0-AppEnv.RegionalOptions.DecimalPlaces);
end;
function StringCount(const subtext: string; Text: string): Integer;
begin
  if (char_length(subtext) = 0) or (char_length(Text) = 0) or (Pos(subtext, Text) = 0) then
    Result := 0
  else
    Result := (char_length(Text) - char_length(StringReplace(Text, subtext, '', [rfReplaceAll]))) div char_length(subtext);
end;

{
  Typically you would get the scancode needed from the
  lparam of a WM_KEYDOWN message.
  If you are trying to work from an OnKeyDown handler
  here you don't have that either,
  so you have to fall back on MapVirtualKey.
  The keystate array is obtained from GetKeyboardstate.
}


{: Obtain the character that will result from the virtual key
     passed in.
   @param vkey is the virtual key code, e.g. Key parameter of an
     OnKeyDown handler.
   @returns the character or '' if the key does not result in a
     character. On rare occasions the function may return two
     characters, e.g. if an accent key is pressed followed by another
     character that does not have an accented version. }

function GetCharFromVKey(vkey: Word): string;
var
  keystate: TKeyboardState;
  retcode: Integer;
begin
{$WARN SYMBOL_PLATFORM OFF}
  Win32Check(GetKeyboardState(keystate));
{$WARN SYMBOL_PLATFORM ON}
  Setlength(Result, 2);
  retcode := ToAscii(vkey,
    MapVirtualKey(vkey, 0),
    keystate, @Result[1],
    0);
  case retcode of
    0: Result := ''; // no character
    1: Setlength(Result, 1);
    2:;
    else
      Result := ''; // retcode < 0 indicates a dead key
  end;
end;
(*function BooleanToStr(const Value:Boolean):String;
begin
  if Value then result := 'T' else result := 'F';
end;*)
function StrToBoolean(const Value:String):Boolean;
begin
  result := SameText(Value , 'T') or SameText(Value , 'True');
end;
function BooleanToString(const Value:Boolean):String;
begin
  REsult:= Systemlib.BooleanToString(Value);
end;
function BooleanToYN(const Value:Boolean):String;
begin
  if Value then result := 'Y' else result := 'N';
end;
Function ArrayToString(const Value :Array of String):String;
var
  ctr:Integer;
begin
  REsult := '';
  for ctr := low(Value) to high(Value) do begin
    if result <> '' then result := result +',';
    Result := result +value[ctr];
  end;
end;

function DevMode:Boolean;
begin
(* result := False;
 Exit;*)
 {$IFDEF DevMode}
    Result := True;
 {$ELSE}
    Result := False;
 {$ENDIF}
end;
//Function WooCommercePrefinvalidcomponent:String;
//begin
//       if not AppEnv.CompanyPrefs.EnableWooCommerce               then result := 'chkEnableWooCommerce'
//  else if AppEnv.CompanyPrefs.WooCommerce_consumerKey        = '' then Result := 'EDTWooCommerce_consumerKey'
//  else if AppEnv.CompanyPrefs.WooCommerce_consumerSecretKey  = '' then Result :=  'edtWooCommerce_consumerSecretKey'
//  else if AppEnv.CompanyPrefs.WooCommerce_URL                = '' then Result := 'edtWooCommerce_URL'
//  else if AppEnv.CompanyPrefs.Woocommerce_ProductNameField   = '' then Result := 'optWoocommerce_ProductNameField'
//  else Result :='chkEnableWooCommerce';
//end;
Function WalmartPrefinvalidcomponent:String;
begin
       if not AppEnv.CompanyPrefs.EnableWalmart        then result := 'chkEnableWalmart'
  else if AppEnv.CompanyPrefs.Walmartcustomer     = '' then Result := 'cboWalmartcustomer'
  else if AppEnv.CompanyPrefs.WALMART_ConsumerId  = '' then Result :=  'EDTWALMART_ConsumerId'
  else if AppEnv.CompanyPrefs.WALMART_PrivateKey  = '' then Result := 'memWALMART_PrivateKey'
  else if AppEnv.CompanyPrefs.WALMART_ChannelType = '' then Result := 'EDTWALMART_ChannelType'
  else Result :='chkEnableWalmart';
end;
Function WoocommerceMsg :String;
begin
       if not AppEnv.CompanyPrefs.EnableWooCommerce        then result := 'WooCommerce is not Enabled in Preferences.'+NL+NL+ 'Please Select "Enable WooCommerce" in preferences to use this module.'
  else Result :='';
end;
Function WalmartMsg :String;
begin
       if not AppEnv.CompanyPrefs.EnableWalmart        then result := 'Walmart is not Enabled in Preferences.'+NL+NL+ 'Please Select "Enable Walmart" in preferences to use this module.'
  else if AppEnv.CompanyPrefs.Walmartcustomer     = '' then Result := 'You do not have the "Walmart Customer" field in preferences selected.'+NL+
                                                                      'This field is used to populate the Sales Order customer field for orders that come from Walmart.'+NL+NL+
                                                                      'Please select a Customer Name in the Walmart preferences to use this module.'
  else if AppEnv.CompanyPrefs.WALMART_ConsumerId  = '' then Result := 'Walmart Consumer ID is not Provided in Preferences.'+NL+NL+ 'Please Provide "Walmart Consumer ID" in preferences to use this module.'
  else if AppEnv.CompanyPrefs.WALMART_PrivateKey  = '' then Result := 'Walmart Private Key is not Provided in Preferences.'+NL+NL+ 'Please Provide "Walmart Private Key" in preferences to use this module.'
  else if AppEnv.CompanyPrefs.WALMART_ChannelType = '' then  Result:= 'Walmart Channel Type is not Provided in Preferences.'+NL+NL+ 'Please Provide "Walmart Channel Type" in preferences to use this module.'
  else Result :='';
end;
function UsingWalmart:Boolean;
begin
  result := AppEnv.CompanyPrefs.EnableWalmart
        and (AppEnv.CompanyPrefs.Walmartcustomer <> '')
        and (AppEnv.CompanyPrefs.WALMART_ConsumerId <> '')
        and (AppEnv.CompanyPrefs.WALMART_PrivateKey <> '')
        and (AppEnv.CompanyPrefs.WALMART_ChannelType <> '');
end;
function UsingWoocommerce:Boolean;
begin
  result := AppEnv.CompanyPrefs.EnableWoocommerce;
end;

Function NumberMaskTocaption(fsMask:String):STring;
begin
  result := fsMask;
  result := replacestr(result, '\-'   , '-') ;
  result := replacestr(result, ';0;_' , '');
  result := replacestr(result, '9'    , '#');
  result := replacestr(result, '0'    , '#');
end;

function FloatFieldDisplayFormat:String;
begin
  Result := '############0.0' + ReplicateStr('#' , GeneralRoundPlaces-1);
end;
Function Skipdays(CurDay, noofDays: Integer): Integer;
begin
  result := DatetimeUtils.Skipdays(CurDay, noofDays);
  (*if noofDays <0 then noofDays := 7+noofDays;
  REsult :=CurDay+ noofDays;
  if result > 7 then REsult := Result -7;*)
end;

function IsClassParent(const aClass, aParent: TClass): boolean;
var ClassRef: TClass;
begin
  result:= false;
  ClassRef:= aClass;
  while ClassRef <> nil do begin
    if ClassRef = aParent then begin
      result:= true;
      break;
    end;
    ClassRef:= ClassRef.ClassParent;
  end;
end;

function TemplateToTemplClass(TemplateName:String ):String;
begin
  REsult :=TemplateName;
  Exit;
  with TempMyQuery do
    try
      SQL.Add(Format('SELECT TemplateClass FROM tblTemplates WHERE TemplName = %s', [QuotedStr(TemplateName)]));
      open;
      Result := FieldByName('TemplateClass').asString;
    finally
      if active then close;
      Free;
    end;
end;
Procedure HandPointCursor(Apply :Boolean = True);
begin
    if Apply then begin
      if Screen.cursor <> crHandPoint then begin
        foSavedCursor := Screen.cursor;
        Screen.cursor := crHandPoint;
      end;
    end else begin
        Screen.Cursor := foSavedcursor;
    end;
end;
Procedure ProcessingCursor(Apply :Boolean = True);
begin
    if Apply then begin
      if Screen.cursor <> crHourGlass then begin
        foSavedCursor := Screen.cursor;
        Screen.cursor := crHourGlass;
      end;
    end else begin
        Screen.Cursor := foSavedcursor;
    end;
end;
function ControlName(Control :TComponent):String;
begin
  REsult := Control.Name;
  if Assigned(Control.Owner) then
    Result :=ControlName(Control.Owner)+'.' +Result;
end;
function ComponentName(Owner :Tcomponent ;compname:String):String;
var
  ctr:Integer;
begin
  result := compname;
  ctr:= 1;
  while true do begin
    if Owner.FindComponent(result ) = nil then exit;
    result:= result +inttostr(ctr);
    ctr:= ctr+1;
  end;
end;
function UniqueComponentName(aComponent: TComponent; CompName: string): string;
var
  s: string;
  i: integer;

  function Exists(aName: string): boolean;
  var x: integer;
  begin
    result := false;
    for x := 0 to aComponent.Owner.ComponentCount -1 do begin
      if (aComponent.Owner.Components[x] <> aComponent) and (aComponent.Owner.Components[x].Name = aName) then begin
        result := true;
        break;
      end;
    end;
  end;

begin
  if CompName <> '' then s := CompName
  else s:= aComponent.ClassName;
  if Assigned(aComponent.Owner) then begin
    if Exists(s) then begin
      i := 1;
      while Exists(s + IntToStr(i)) do
        Inc(i);
      s:= s + IntToStr(i);
    end;
  end;
  result := s;
end;

function Ifempty(expr1, expr2:String):String;
begin
  if expr1<>'' then result:= expr1
  else result := expr2;
end;
function IncQuarter(const Date: TDateTime; NumberOfQuarters: integer): TDateTime;
begin
  Result := DatetimeUtils.IncQuarter(Date ,NumberOfQuarters);
end;
function GetMonthName(const MonthNo: integer): string;
begin
  result := Datetimeutils.GetMonthName(MonthNo);
end;


function EndOfTheQuarter(const AValue: TDateTime): TDateTime;
begin
  REsult := DateTimeUtils.EndOfTheQuarter(AValue);
end;

function QuarterOf(const AValue: TDateTime): integer;
begin
  result := datetimeutils.QuarterOf(AValue);
end;
Function RemoveHotKey(const Value:String):String;
begin
  REsult:=Value;
  Result := replaceStr(value , '&&' , '|~~~|');
  result := replacestr(Value , '&' , '');
  REsult := ReplaceStr(value , '|~~~|' , '&&');
end;

function FillString(const Str: string; const StrLength: integer; const FillChar: char; const InFront: boolean): string;
var
      FinalStr, TempStr: string;
      RequiredSpaces: integer;
begin
      RequiredSpaces := StrLength - char_length(Trim(Str));
      TempStr := StringOfChar(FillChar, RequiredSpaces);
      if InFront then begin
        FinalStr := TempStr + Trim(Str);
      end else begin
        FinalStr := Trim(Str) + TempStr;
      end;
      Result := FinalStr;
end;

function TransType(TableAlias:String ; IsSales:Boolean):String;
begin
  if isSales then
    Result:= '  If( ' + TableAlias +'.IsVoucher="T" and ' + TableAlias +'.isinvoice="T", "Invoice Voucher", '+
                       'if(' + TableAlias +'.IsVoucher="T" ,"Voucher" ,'+
                       'if(' + TableAlias +'.IsSalesOrder="T" ,"Sales Order" ,'+
                       'If(' + TableAlias +'.IsCashSale="T" And ' + TableAlias +'.IsPOS="F" ,"Cash Sale",'+
                       'If(' + TableAlias +'.IsRefund="T","Refund",'+
                       'If(' + TableAlias +'.IsInvoice="T","Invoice",'+
                       'If(' + TableAlias +'.IsCashSale="T" And ' + TableAlias +'.IsPOS="T",if(' + TableAlias +'.IsLaybyPayment="T" ,'+
                       'if( ' + TableAlias +'.TotalAmountInc <0 , "Layby Reverse Transaction ","Layby Payment" ), "POS"),"Unknown")))))))'
  else
    Result:= 'if(' + TableAlias +'.isPO="T" , "PO" ,'+
             'if(' + TableAlias +'.isCredit="T" , "Credit" ,'+
             'if(' + TableAlias +'.Isbill="T" , "Bill" ,'+
             'if(' + TableAlias +'.ischeque="T" , "cheque" , '+
             'if(' + TableAlias +'.isRA="T" , "RA" ,"Unknown")))))';
end;
Function companyinfoSQLfortemplate:String;
begin
  REsult := '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO';
End;
Function iif(const cond :boolean ; trueValue, falseValue:Variant):Variant;
begin
  //if cond then result := TrueValue else result := FalseValue;
  Result := Utilslib.iif(cond, TrueValue , FalseValue);
end;
Function ValidateForName(Const Value:String):String;
begin
  result := trim(Value);
  Result := replacestr(result , ' ' , '_');
  Result := replacestr(result , '&' , '_');
  Result := replacestr(result , '(' , '_');
  Result := replacestr(result , ')' , '_');
  Result := replacestr(result , '[' , '_');
  Result := replacestr(result , ']' , '_');
end;
function Parentformcolor(const control :TWincontrol):TColor;
begin
  result := 0;
  if Assigned(control.Parent) then
    if Control.parent is TForm then result := TForm(Control.parent).color
    else result := Parentformcolor(control.parent);
end;
function ControlOwner(control :TComponent): string;
function Itsname:String;
begin
   if control.Name <> '' then result := control.Name
   else result := control.ClassName;
end;
begin
  result:= '';
  try
    if control = nil then exit;
    if Assigned(Control.Owner) then result := ControlOwner(Control.Owner)+'.'+Itsname else result := Itsname;
  Except
  end;
end;
function ControlParent(control :TControl): string;
begin
  result:= '';
  try
    if control = nil then exit;
    if Assigned(Control.Parent) then result := ControlParent(Control.Parent)+'.'+control.Name else result := control.Name;
  Except
  end;
end;
Function EmployeeHasAccess(const FormName: string; const EmployeeID: integer = 0; AccessLevelreqd:Integer = 3):boolean;
begin
  Result := Appenv.AccessLevels.GetEmployeeAccessLevel(Formname, EmployeeID)<= AccessLevelreqd;
end;
function MakeName(const Value:String;StrtoRemove:String= ''):String;
begin
    REsult := Value;
    if StrtoRemove <> '' then Result := replacestr(REsult , StrtoRemove , '_');
    Result := replacestr(REsult , '.' , '_');
    Result := replacestr(REsult , ' ' , '_');
    Result := replacestr(REsult , '-' , '_');
    Result := replacestr(REsult , '/' , '_');
    Result := replacestr(REsult , '\' , '_');
    Result := replacestr(REsult , '(' , '_');
    Result := replacestr(REsult , ')' , '_');
    while pos('__' , result)>0 do Result := replacestr(REsult , '__' , '_');
end;
function MakeName(Const AOwner:TComponent; Const Value:String;StrtoRemove:String= '') :String;
var
  ctr:Integer;
begin
    REsult := MakeName(Value, StrtoRemove);
    ctr:= 1;
    While AOwner.Findcomponent(Result )<> nil do begin
      REsult := Result +trim(inttostr(ctr));
      ctr:= ctr+1;
    end;
end;
function NameToCode(NameValue:String):String;
var
  ctr:Integer;
begin
  result:= '';
    if NameValue = '' then exit;
    Result := copy(Namevalue,1,1);
    ctr:= 2;
    while ctr<=Length(NameValue) do begin
      if copy(Namevalue , ctr-1 , 1 )=' ' then result := result+copy(Namevalue , ctr , 1 );
      ctr:= ctr+1;
    end;
end;
function MilliSeconds(const Seconds:Integer):Integer;
begin
  Result := Seconds*1000;
end;
function Seconds(const MilliSeconds:Integer):Integer;
begin
  Result := trunc(divzer(MilliSeconds,1000));
end;

function RelatedColor(Colr:TColor):TColor;
var
  R,G,B:Integer;
begin
  r:= GetRValue(Colr); if R> 125 then r := r-20 else r:= r+20;
  G:= GetGValue(Colr); if g> 125 then g := g-20 else g:= g+20;
  B:= GetBValue(Colr); if b> 125 then b := b-20 else b:= b+20;
  Result := RGB(r,g,b  );
end;

function DayStart(Dt:TDatetime):TDateTime;
begin
  if AppEnv.CompanyPrefs.StartOfDay = 0 then begin
    result := EncodeTime(8, 30, 0, 0);
  end else begin
    result:= TimeOf(AppEnv.CompanyPrefs.StartOfDay);
  end;
  result := Dateof(Dt)+REsult;
end;

function DayEnd(Dt:TDatetime):TDateTime;
begin
  if AppEnv.CompanyPrefs.EndOfDay = 0 then begin
    result := EncodeTime(8, 30, 0, 0);
  end else begin
    result:= TimeOf(AppEnv.CompanyPrefs.EndOfDay);
  end;
  result := Dateof(Dt)+REsult;
end;
function SecsInaWorkingDay: Integer;
begin
    REsult := SecondsBetween(DayStart(date),DayEnd(Date));
end;
Function Highest(Const Values :Array of double):Double;
var
  ctr:Integer;
begin
  Result := 0;
  if length(Values) =0 then exit;
  Result := Values[low(Values)];
  for ctr:= low(Values) to high(Values) do
    if REsult <Values[ctr] then result := Values[ctr];
end;

Function Lowest(Const Values :Array of double):Double;
var
  ctr:Integer;
begin
  Result := 0;
  if length(Values) =0 then exit;
  Result := Values[low(Values)];
  for ctr:= low(Values) to high(Values) do
    if REsult >Values[ctr] then result := Values[ctr];
end;

function SelectedText(Const fieldname: String; const DisplayLabel: String; DisplayWidth: Integer; const Groupname: String = ''; fbReadonly: Boolean = False): String;
begin
  if DisplayWidth = 255 then DisplayWidth := 20;
  Result := fieldName + #9 + IntToStr(displaywidth) + #9 + DisplayLabel + #9;
  if fbReadonly      then Result := Result + 'T' + #9      else Result := Result + 'F' + #9 ;
  if GroupName <> '' then Result := Result + GroupName;
end;

Function FloatToInt(Value:Double; RoundToNext:Boolean=TRue):Integer;
begin
  if Value = TRunc(Value) then result := Trunc(Value)
  else if RoundToNext =False then result := Trunc(Value)
  else Result := Trunc(Value)+1;
end;
Function nextnum(const Value:Integer; NumLength:Integer;fillchar:String='0'):String;
begin
  REsult := inttostr(Value);
  While Length(Result) < NumLength do result := fillchar + Result;
end;
function  IsSundayWeekend:Boolean   ;begin  Result := IsWeekendDay(0); end;
function  IsMondayWeekend:Boolean   ;begin  Result := IsWeekendDay(1); end;
function  IsTuesdayWeekend:Boolean  ;begin  Result := IsWeekendDay(2); end;
function  IsWednesdayWeekend:Boolean;begin  Result := IsWeekendDay(3); end;
function  IsthursdayWeekend:Boolean ;begin  Result := IsWeekendDay(4); end;
function  IsFridayWeekend:Boolean   ;begin  Result := IsWeekendDay(5); end;
function  IsSaturdayWeekend:Boolean ;begin  Result := IsWeekendDay(6); end;
Function IsWeekend(const aDate :TDatetime):Boolean;
begin
  result :=IsWeekendDay(DayOfTheWeek(aDate))
end;
Function IsDateholiday(const aDate :TDatetime):Boolean;
begin
  result := IsWeekend(aDate) Or tcDataUtils.IsHoliday(aDate);
end;
Function IsWeekendDay(const Weekdayno :Integer):Boolean;{Days 0(sun) - 6(sat) }
var
  x,dayNo:Integer;
begin
  Result := False;
  if AppEnv.CompanyPrefs.NoOfWeekendDays = 0 then exit; // 7 day operation
  for x:= 1 to 7 do begin
    if x >AppEnv.CompanyPrefs.NoOfWeekendDays  then exit;
    dayNo := AppEnv.CompanyPrefs.StartWorkWeekDay - x;
    //if dayNo <0 then dayNo := 7+dayNo;
    if dayNo <=0 then dayNo := 7+dayNo;
    if dayNo = Weekdayno then begin
        result := True;
        Exit;
    end;
  end;
end;

function ValidFieldName(const aFieldName : string) : string;
var
  idx : integer;
begin
  Result := aFieldName;
  for idx := 1 to Length(Result) do
    if CharInSet(Result[idx], [' ', '-']) then
      Result[idx] := '_';
end;
Function AligntoStr(const Value : TAlign):String;
begin
       if Value = albottom  then result :=   'Bottom'
  else if Value = alLeft    then result :=   'Left'
  else if Value = alRight   then result :=   'Right'
  else if Value = alTop     then result :=   'Top'
  else if Value = alClient  then result :=   'Client'
  else result := '';
end;
function WrappedSQLtext(SQL:TStrings): String;
var
  ctr:Integer;
begin
      Result :='';
      for ctr := 0 to sql.count-1 do    if trim(sql[ctr]) <> '' then result := result +' ' +trim(sql[ctr]);
end;
function WrappedSQLtext(SQL:String): String;
begin
  result := sql;
  result := replacestr(result , chr(13)+chr(10) , ' ');
  result := replacestr(result , chr(13) , ' ');
  result := replacestr(result , chr(10) , ' ');
  result := replacestr(result , '\n' , ' ');
  result := replacestr(result , NL , ' ');
end;
function MonthsRND(Const DateFrom , Dateto:TDateTime):Integer;
begin
  result := trunc(DecimalRoundDbl(MonthSpan(datefrom , dateTo ) ,0 , drrndup));
end;
Function DaysRND(Const DateFrom , DAteto:TDateTime):Integer;
begin
    result := trunc(DecimalRoundDbl(DaySpan(datefrom , dateTo ) ,0 , drrndup));
end;
Function Savefilename(DefaultExt :String; defaultFilename:String=''): String;
Var
  SaveDialog: TSaveDialog;
Begin
  Result := '';
  SaveDialog := TSaveDialog.Create(Nil);
  try
    SaveDialog.Filename := defaultFilename;
    SaveDialog.DefaultExt := DefaultExt;
    If SaveDialog.Execute Then Result := SaveDialog.FileName;
  finally
    Freeandnil(SaveDialog);
  end;
End;
Function StringDataForSQL(const Value:String):String;
begin
  Result := Value;
  REsult := replacestr(result , '\' , '\\');
end;

function formatmilliSeconds(Value:Integer):String;
begin

Result := '';
if   Value =0 then exit;
{
MilliSecons	1
        sec	1000
        min	60000
      hours	3600000
       days	86400000
}
{days}
if trunc(Value /86400000)>0 then begin
    REsult := Trim(inttostr(trunc(Value /86400000)))+':';
    Value := Value - trunc(Value /86400000)*86400000;
end else REsult := '0:';

{Hours}
if trunc(Value /3600000)>0 then begin
    REsult := REsult + Trim(inttostr(trunc(Value /3600000)))+':';
    Value := Value - trunc(Value /3600000)*3600000;
end else REsult := REsult +'0:';

{min}
if trunc(Value /60000)>0 then begin
    REsult := REsult + Trim(inttostr(trunc(Value /60000)))+':';
    Value := Value - trunc(Value /60000)*60000;
end else REsult := REsult +'0:';

{min}
if trunc(Value /1000)>0 then begin
    REsult := REsult + Trim(inttostr(trunc(Value /1000)))+':';
    Value := Value - trunc(Value /1000)*1000;
end else REsult := REsult +'0:';

if value >0 then Result := REsult + Trim(inttostr(trunc(Value)))
else REsult := REsult +'0';

end;

function FormatSeconds(Seconds:Integer):String;
var
  fih , fim, fis:Integer;
begin
  Result := '';
  //fih := 0; fim:= 0;
  fis:= 0;
  fih := trunc(seconds/(24*60));  if fih>0 then seconds := seconds - fih*(24*60);
  fim := trunc(seconds/60);  if fim >0 then seconds := seconds - fim*60;
  if Seconds >0 then fis:= Seconds;
  Result := inttostr(fih)+':'+ inttostr(fim)+':'+ inttostr(fis);
  While Copy(Result , 1, 2) ='0:' do Result := Copy(Result,3,length(Result));
  if Result ='0' then Result :='' else Result := Result +' Second(s)';
end;
Function AnchorstoStr(const Value :TAnchors):String;
begin
  REsult := '';
  if akleft in Value then REsult := result +',Left';
  if akRight in Value then REsult := result +',Right';
  if akTop in Value then REsult := result +',Top';
  if akBottom in Value then REsult := result +',Bottom';
  if copy(result,1,1) =',' then result := copy(result, 2, length(result));
end;
Procedure ShowExceptionMsg(E:Exception; PreExMsg:String =''; PostExMsg:String = ''; showinlyindecmode:Boolean = true);
var
  s:String;
begin
  s:= E.Message;
  s:= trim(PreExMsg +NL+s+NL+PostExMsg);
  if not(showinlyindecmode) or devmode then
    MessageDlgXP_vista(s, mtWarning, [mbOK], 0);
end;
function heirarchyname(Control: TComponent): String;
begin
  REsult := Control.Name;
  if (Control is TWincontrol) and Assigned(TWincontrol(Control).Parent) then
    result :=heirarchyname(TWincontrol(Control).Parent)+'.'+result
  else if Assigned(Control.Owner) and (Control.Owner is TWincontrol) then
    result := heirarchyname(TWincontrol(Control.Owner))+'.'+result;
end;
Function DateRangeWithin(Dtfrom, dtTo, RanegFrom, RangeTo:TDateTime):Boolean;
begin
  Result := True;
  if  (Dtfrom <= RanegFrom  ) and (dtTo >=RanegFrom ) then Exit;
  if  (Dtfrom <= RangeTo    ) and (dtTo >=RangeTo   ) then Exit;
  if  (Dtfrom <= RanegFrom  ) and (dtTo >=RangeTo   ) then Exit;
  if  (Dtfrom >= RanegFrom  ) and (dtTo <=RangeTo   ) then Exit;
  Result := False;
end;

Function UOMForProductLookupSQL:String;
begin
Result := 'SELECT '+
          ' U.UnitID, '+
          'CONCAT(U.UnitName , "(", U.Multiplier,")") AS UOMDetails,'+
          ' U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName '+
          ' FROM tblunitsofmeasure U '+
          ' WHERE U.ACTIVE = "T"  AND ifnull(U.PartID,0) = :xPartID '+
          ' union all '+
          ' SELECT '+
          ' U.UnitID, '+
          'CONCAT(U.UnitName , "(", U.Multiplier,")") AS UOMDetails,'+
          ' U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName '+
          ' FROM tblunitsofmeasure U '+
          ' WHERE U.ACTIVE = "T"  AND ifnull(U.PartID,0) = 0 and Unitname not  in (Select unitname from  tblunitsofmeasure where  ifnull(PartID,0) = :xPartID  ) '+
          ' Order By UnitID desc ,UnitName;';
end;
Function StrCurrToDouble(Value:String):Double;
begin
  if trim(Value) ='' then begin
    result := 0;
    Exit;
  end;
  Value:= replacestr(Value, AppEnv.RegionalOptions.CurrencySymbol , '');
  Value:= replacestr(Value, FormatSettings.ThousandSeparator, '');
  try REsult := StrTofloat(Value); except end;
end;


initialization
  fsXMLImportResultDocName := '';
  foXMLImportResultDoc := nil;
  foSavedCursor := crArrow;
  fbMessaging:=False;

{$IFDEF GET_HELPCONTEX_INFO}
finalization
  FreeandNil(AllRegisteredClass);
{$ENDIF}
end.



