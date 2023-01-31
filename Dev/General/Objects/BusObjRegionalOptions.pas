unit BusObjRegionalOptions;

interface

uses BusObjBase, DB, Classes, XMLDoc, forms, tcTypes, AdvPicture, MyScript, DAScript , Graphics , Sysutils, BusObjClass;

type

  TRegionalOptions = class(TMSBusObj)
  private
    function GetRegion: string;
    function GetCurrencySymbol: string;
    function GetWholeCurrencyName: string;
    function GetDecimalCurrencyName: string;
    function GetCurrencyFormat: Integer;
    function GetNegCurrFormat: Integer;
    function GetShortDateFormat: string;
    function GetDateSeparator: string;
    function GetSuburbName: string;
    function GetStateName: string;
    function GetPostcodeLength: Integer;
    function GetPostcodeMask: string;
    function GetPhoneNumberLength: Integer;
    function GetPhoneNumberMask: string;
    function GetMobileNumberLength: Integer;
    function GetMobileNumberMask: string;
    function GetBSBName: string;
    function GetSLName: string;
    function GetBSBLength: Integer;
    function GetBSBMask: string;
    function GetBankAccountLength: Integer;
    function GetBankNumberLength: Integer;
    function GetBankAccountMask: string;
    function GetBankNumberMask: string;
    function GetForeignExDefault: string;
    // function GetBussinessNoName           : string    ;
    // function GetCustomerABNMask           : string    ;
    // function GetCustomerABNLength         : Integer   ;
    procedure SetRegion(const Value: string);
    procedure SetCurrencySymbol(const Value: string);
    procedure SetWholeCurrencyName(const Value: string);
    procedure SetDecimalCurrencyName(const Value: string);
    procedure SetCurrencyFormat(const Value: Integer);
    procedure SetNegCurrFormat(const Value: Integer);
    procedure SetShortDateFormat(const Value: string);
    procedure SetDateSeparator(const Value: string);
    procedure SetSuburbName(const Value: string);
    procedure SetStateName(const Value: string);
    procedure SetPostcodeLength(const Value: Integer);
    procedure SetPostcodeMask(const Value: string);
    procedure SetPhoneNumberLength(const Value: Integer);
    procedure SetPhoneNumberMask(const Value: string);
    procedure SetMobileNumberLength(const Value: Integer);
    procedure SetMobileNumberMask(const Value: string);
    procedure SetBSBName(const Value: string);
    procedure SetSLName(const Value: string);
    procedure SetBSBLength(const Value: Integer);
    procedure SetBSBMask(const Value: string);
    procedure SetBankAccountLength(const Value: Integer);
    procedure SetBankNumberLength(const Value: Integer);
    procedure SetBankAccountMask(const Value: string);
    procedure SetBankNumberMask(const Value: string);
    procedure SetForeignExDefault(const Value: string);
    // procedure SetBussinessNoName           (const Value: string    );
    // procedure SetCustomerABNMask           (const Value: string    );
    // procedure SetCustomerABNLength         (const Value: Integer   );
    procedure ApplyPOSFuncFormatting;
    procedure ApplyDefaultProductFormatting;
    procedure ApplyDefaultForeignExFormatting;
    procedure ApplyDefaultTaxStatmentFormatting;
    procedure ApplyCurrencyFormatting(const Component: TComponent);
    procedure ApplyBankFormatting(const Component: TComponent);
    procedure ApplyLocationsFormatting(const Component: TComponent);
    procedure ApplyPhoneNumFormatting(const Component: TComponent);
    procedure ApplyPostCodeFormatting(const Component: TComponent);
    procedure ApplyBussinessNoFormatting(const Component: TComponent);
    Procedure ApplyBaseListingsFormatting(const Component: TComponent);
    Procedure ApplyDatetimeFormatting(const Component: TComponent);
    function GetRegionAbbreviation: string;
    procedure SetRegionAbbreviation(const Value: string);
    function GetWeekStartDay: Integer;
    procedure SetWeekStartDay(const Value: Integer);
    function GetTaxCodeNoTax: string;
    function GetTaxCodePurchaseEx: string;
    function GetTaxCodePurchaseInc: string;
    function GetTaxCodeSalesEx: string;
    function GetTaxCodeSalesInc: string;
    procedure SetTaxCodeNoTax(const Value: string);
    procedure SetTaxCodePurchaseEx(const Value: string);
    procedure SetTaxCodePurchaseInc(const Value: string);
    procedure SetTaxCodeSalesEx(const Value: string);
    procedure SetTaxCodeSalesInc(const Value: string);
    function GetBusinessNoLabel: string;
    function GetBusinessTaxNoLabel: string;
    function GetBusinessTaxNoLength: Integer;
    function GetBusinessTaxNoMask: string;
    procedure SetBusinessNoLabel(const Value: string);
    procedure SetBusinessTaxNoLabel(const Value: string);
    procedure SetBusinessTaxNoLength(const Value: Integer);
    procedure SetBusinessTaxNoMask(const Value: string);
    function getPOSDocName: string;
    procedure setPOSDocName(const Value: string);
    function getDecimalPlaces: Integer;
    procedure SetDecimalPlaces(const Value: Integer);
    function getISDCode: Integer;
    function getMoneyWordsShowsDecimalCurrencyName :Boolean;
    function getCountryId: Integer;
    function getLanguageID: Integer;
    procedure setISDCode(const Value: Integer);
    Procedure SetMoneyWordsShowsDecimalCurrencyName(const Value :Boolean);
    procedure setCountryId(const Value: Integer);
    procedure setLanguageID(const Value: Integer);
    procedure MyScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
    function getDecimalValue: Integer;
    function getcountryname: String;
    function getLanguageName: String;
    function getWeekEndDay1: Integer;
    function getWeekEndDay2: Integer;
    function getDeptClass: TDeptClass;
    function getDeptClassID: Integer;
    function getDeptClassName: String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterClose(Sender: TDatasetBusObj): Boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure SetupRegion;
    procedure Load(const fIsReadonly: Boolean = False); override;
    function ChangeStr(const Str: string): string;
    procedure ChangeForm(const Form: TForm);
    procedure ChangeQuery(const Query: TDataset);
    Procedure ChangeList(const Component: TComponent);
    function RegionType: TRegionType;
    function RegionNameToRegionType(const aRegion: string): TRegionType;
    procedure LoadFlagPicture(aPicture: TIPicture);
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    Function UpdateSLName(CleanSLname:String):Boolean;
    Property DeptClass :TDeptClass read getDeptClass;
    Property DeptClassID :Integer read getDeptClassID;
    Property DeptClassName :String read getDeptClassName;
  published
    property Region: string read GetRegion write SetRegion;
    property RegionAbbreviation: string read GetRegionAbbreviation write SetRegionAbbreviation;
    property CurrencySymbol: string read GetCurrencySymbol write SetCurrencySymbol;
    property WholeCurrencyName: string read GetWholeCurrencyName write SetWholeCurrencyName;
    property DecimalCurrencyName: string read GetDecimalCurrencyName write SetDecimalCurrencyName;
    property DecimalPlaces: Integer read getDecimalPlaces write SetDecimalPlaces;
    Property DecimalValue:Integer read getDecimalValue;
    property CurrencyFormat: Integer read GetCurrencyFormat write SetCurrencyFormat;
    property NegCurrFormat: Integer read GetNegCurrFormat write SetNegCurrFormat;
    property ShortDateformat: string read GetShortDateFormat write SetShortDateFormat;
    property DateSeparator: string read GetDateSeparator write SetDateSeparator;
    property SuburbName: string read GetSuburbName write SetSuburbName;
    property StateName: string read GetStateName write SetStateName;
    property PostcodeLength: Integer read GetPostcodeLength write SetPostcodeLength;
    property PostcodeMask: string read GetPostcodeMask write SetPostcodeMask;
    property PhoneNumberLength: Integer read GetPhoneNumberLength write SetPhoneNumberLength;
    property PhoneNumberMask: string read GetPhoneNumberMask write SetPhoneNumberMask;
    property MobileNumberLength: Integer read GetMobileNumberLength write SetMobileNumberLength;
    property MobileNumberMask: string read GetMobileNumberMask write SetMobileNumberMask;
    property BSBName: string read GetBSBName write SetBSBName;
    property SLName: string read GetSLName write SetSLName;
    property BSBLength: Integer read GetBSBLength write SetBSBLength;
    property BSBMask: string read GetBSBMask write SetBSBMask;
    property BankAccountLength: Integer read GetBankAccountLength write SetBankAccountLength;
    property BankNumberLength: Integer read GetBankNumberLength write SetBankNumberLength;
    property BankAccountMask: string read GetBankAccountMask write SetBankAccountMask;
    property BankNumberMask: string read GetBankNumberMask write SetBankNumberMask;
    property ForeignExDefault: string read GetForeignExDefault write SetForeignExDefault;
    property BusinessTaxNoLabel: string read GetBusinessTaxNoLabel write SetBusinessTaxNoLabel;
    property BusinessTaxNoMask: string read GetBusinessTaxNoMask write SetBusinessTaxNoMask;
    property BusinessTaxNoLength: Integer read GetBusinessTaxNoLength write SetBusinessTaxNoLength;
    property BusinessNoLabel: string read GetBusinessNoLabel write SetBusinessNoLabel;
    property WeekStartDay: Integer read GetWeekStartDay write SetWeekStartDay;
    property TaxCodeSalesInc: string read GetTaxCodeSalesInc write SetTaxCodeSalesInc;
    property TaxCodeSalesEx: string read GetTaxCodeSalesEx write SetTaxCodeSalesEx;
    property TaxCodePurchaseInc: string read GetTaxCodePurchaseInc write SetTaxCodePurchaseInc;
    property TaxCodePurchaseEx: string read GetTaxCodePurchaseEx write SetTaxCodePurchaseEx;
    property TaxCodeNoTax: string read GetTaxCodeNoTax write SetTaxCodeNoTax;
    property POSDocName: string read getPOSDocName write setPOSDocName;
    property ISDCode: Integer read getISDCode write setISDCode;
    property MoneyWordsShowsDecimalCurrencyName : Boolean read getMoneyWordsShowsDecimalCurrencyName write setMoneyWordsShowsDecimalCurrencyName;
    property CountryId: Integer read getCountryId write setCountryId;
    property LanguageID: Integer read getLanguageID write setLanguageID;
    Property CountryName :String read getcountryname;
    Property LanguageName :String read getLanguageName;
    Property WeekEndDay1:Integer read getWeekEndDay1;
    Property WeekEndDay2:Integer read getWeekEndDay2;

  end;

implementation

uses tcDataUtils, CommonLib, AppEnvironment, CommonDbLib, stdctrls, wwdblook,
  DNMPanel, ERPdbComponents, AdvGrid, extctrls, wwcheckbox, dbctrls,
  MessageInterface, MessageConst, windows, Messages, wwdbedit, MyAccess,
  BusobjCountries, wwDbGrid, DbSharedObjectsObj, SQLsLib, tcConst, LogLib;

{ TRegionalOptions }

constructor TRegionalOptions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'RegionalOptions';
  fSQL := 'SELECT * FROM tblregionaloptions';
  ExportExcludeList.Add('languageid');
end;

destructor TRegionalOptions.Destroy;
begin
  inherited;
end;

function TRegionalOptions.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  Result := False;

//  if DecimalPlaces = 0 then DecimalPlaces := 2;
  if SLName = '' then
    if Region = 'Australia' then SLName := 'Personal Leave' else SLName := 'Sick Leave';

  if Region = '' then begin
    AddResult(False, rssWarning, 0, 'Region should not be blank');
    exit;
  end
  else if RegionAbbreviation = '' then begin
    AddResult(False, rssWarning, 0, 'Region Abbreviation should not be blank');
    exit;
  end
  else if self.ForeignExDefault = '' then begin
    AddResult(False, rssWarning, 0, 'Default Currency should not be blank');
    exit;
  end
  else if self.CurrencySymbol = '' then begin
    AddResult(False, rssWarning, 0, 'Currency Symbol should not be blank');
    exit;
  end
  else if self.WholeCurrencyName = '' then begin
    AddResult(False, rssWarning, 0, 'Currency Whole Name should not be blank');
    exit;
  end
  else if self.DecimalCurrencyName = '' then begin
    AddResult(False, rssWarning, 0, 'Currency Decimal Name should not be blank');
    exit;
  end
  else if self.CurrencyFormat < 0 then begin
    AddResult(False, rssWarning, 0, 'Currency Format should not be blank');
    exit;
  end
  else if self.NegCurrFormat < 0 then begin
    AddResult(False, rssWarning, 0, 'Currency Negative Format should not be blank');
    exit;
  end
  else if self.ShortDateformat = '' then begin
    AddResult(False, rssWarning, 0, 'Date Format should not be blank');
    exit;
  end
  else if self.DateSeparator = '' then begin
    AddResult(False, rssWarning, 0, 'Date Separator should not be blank');
    exit;
  end
  else if self.SuburbName = '' then begin
    AddResult(False, rssWarning, 0, 'City/Suburb/Place Label should not be blank');
    exit;
  end
  else if self.StateName = '' then begin
    AddResult(False, rssWarning, 0, 'State Label should not be blank');
    exit;
  end
  else if self.PostcodeMask = '' then begin
    AddResult(False, rssWarning, 0, 'Postcode Format should not be blank');
    exit;
  end
  else if self.PostcodeLength < 1 then begin
    AddResult(False, rssWarning, 0, 'Postcode Length should be greater than 0');
    exit;
  end
  else if self.PhoneNumberMask = '' then begin
    AddResult(False, rssWarning, 0, 'Phone Number Format should not be blank');
    exit;
  end
  else if self.PhoneNumberLength < 1 then begin
    AddResult(False, rssWarning, 0, 'Phone Number length should be greater than 0');
    exit;
  end
//  else if self.MobileNumberMask = '' then begin
//    AddResult(False, rssWarning, 0, 'Mobile Number Format should not be blank');
//    exit;
//  end
//  else if self.MobileNumberLength < 1 then begin
//    AddResult(False, rssError, 0, 'Mobile Number Length should be greater than 0');
//    exit;
//  end
  else if self.BSBName = '' then begin
    AddResult(False, rssWarning, 0, 'Bank Branch Label should not be blank');
    exit;
  end
  else if self.BSBLength < 1 then begin
    AddResult(False, rssWarning, 0, 'Bank Branch Length should be greater than 0');
    exit;
  end
  else if self.BSBMask = '' then begin
    AddResult(False, rssWarning, 0, 'Bank Branch Format should not be blank');
    exit;
  end
  else if self.BankAccountMask = '' then begin
    AddResult(False, rssWarning, 0, 'Bank Account Format should not be blank');
    exit;
  end
  else if self.BankNumberMask = '' then begin
    AddResult(False, rssWarning, 0, 'Bank Account Format should not be blank');
    exit;
  end
  else if self.BankAccountLength < 1 then begin
    AddResult(False, rssWarning, 0, 'Bank Account Length should be greater than 0');
    exit;
  end
  else if self.BankNumberLength < 1 then begin
    AddResult(False, rssWarning, 0, 'Bank Account Length should be greater than 0');
    exit;
  end
  else if self.TaxCodeSalesInc = '' then begin
    AddResult(False, rssWarning, 0, 'Sales Tax Code Inc should not be blank');
    exit;
  end
  else if self.TaxCodeSalesEx = '' then begin
    AddResult(False, rssWarning, 0, 'Sales Tax Code Ex should not be blank');
    exit;
  end
  else if self.TaxCodePurchaseInc = '' then begin
    AddResult(False, rssWarning, 0, 'Purchase Tax Code Inc should not be blank');
    exit;
  end
  else if self.TaxCodePurchaseEx = '' then begin
    AddResult(False, rssWarning, 0, 'Purchase Tax Code Ex should not be blank');
    exit;
  end
  else if self.TaxCodeNoTax = '' then begin
    AddResult(False, rssWarning, 0, 'Tax Code No Tax should not be blank');
    exit;
  end
  else if self.BusinessTaxNoLabel = '' then begin
    AddResult(False, rssWarning, 0, 'Company/Business Tax Number Label should not be blank');
    exit;
  end
  else if self.BusinessTaxNoMask = '' then begin
    AddResult(False, rssWarning, 0, 'Company/Business Tax Number Format should not be blank');
    exit;
  end
  else if self.BusinessTaxNoLength < 1 then begin
    AddResult(False, rssWarning, 0, 'Company/Business Tax Number Length should be greater than 0');
    exit;
  end
  else if self.BusinessNoLabel = '' then begin
    AddResult(False, rssWarning, 0, 'Company/Business Name/Code Label should not be blank');
    exit;
  end
  else if (self.WeekStartDay < 1) or (self.WeekStartDay > 7) then begin
    AddResult(False, rssWarning, 0, 'Week Start Day is invalid');
    exit;
  end;

  Result := true;
end;

class function TRegionalOptions._Schema: string;
begin
  result:= inherited;
end;

function TRegionalOptions.Save: Boolean;
begin
  Result := False;
  if not ValidateData then exit;
  Result := inherited Save;
end;
Function TRegionalOptions.UpdateSLName(CleanSLname:String):Boolean;
var
  scr :TERPScript;
begin
  inherited;
  Result := True;
  if  CleanSLname = SLname then Exit;

    scr := DbSharedObj.GetScript(connection.connection);
    try
      scr.SQL.text := SLNameUpdateSQL(Region , CleanSLname);
      Self.Connection.BeginNestedTransaction;
      try
          scr.Execute;
          Self.Connection.CommitNestedTransaction;
      Except
        on E:Exception do begin
          Self.Connection.RollbackNestedTransaction;
          Result := False;
          AddResult(False, rssWarning, 0,'Changing Sick Leave Name Failed.'+NL+ e.message);
        end;
      end;
    finally
      DbSharedObj.ReleaseObj(scr);
    end;
end;
procedure TRegionalOptions.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TRegionalOptions.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then exit; // we are only interested in data fields.
  inherited;
  if (sysutils.SameText(Sender.FieldName, 'DecimalPlaces')) then begin
    if DecimalPlaces < 0 then DecimalPlaces := 0
    else if DecimalPlaces > 3 then DecimalPlaces := 3;
  end;
end;

function TRegionalOptions.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TRegionalOptions.GetIDField: string;
begin
  Result := 'RegionID'
end;

function TRegionalOptions.getLanguageName: String;
begin
  With GEtNewdataset('Select Language from erplanguages.languages where Id = ' + inttostr(LanguageID) , true) do try
    REsult := fieldByname('Language').AsString;
  finally
    if Active then close;
    Free;
  end;
end;

class function TRegionalOptions.GetBusObjectTablename: string;
begin
  Result := 'tblregionaloptions';
end;

function TRegionalOptions.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
class function TRegionalOptions.GetKeyStringField: string;
begin
  Result := 'Region';
end;

{ Property Functions }
Function TRegionalOptions.GetMoneyWordsShowsDecimalCurrencyName:Boolean;begin  REsult := GetBooleanfield('MoneyWordsShowsDecimalCurrencyName');end;
function TRegionalOptions.getISDCode: Integer; begin   Result := getIntegerField('ISDCode'); end;
function TRegionalOptions.getCountryId: Integer; begin   Result := getIntegerField('CountryId'); end;
function TRegionalOptions.getLanguageID: Integer; begin   Result := getIntegerField('LanguageID'); end;
function TRegionalOptions.getcountryname: String; begin   result := TCountries.IDToggle(CountryId); end;
function TRegionalOptions.GetRegion: string; begin   Result := GetStringField('Region'); end;
function TRegionalOptions.GetCurrencySymbol: string; begin   Result := GetStringField('CurrencySymbol'); end;
function TRegionalOptions.GetWholeCurrencyName: string; begin   Result := GetStringField('WholeCurrencyName'); end;
function TRegionalOptions.GetDecimalCurrencyName: string; begin   Result := GetStringField('DecimalCurrencyName'); end;
function TRegionalOptions.GetCurrencyFormat: Integer; begin   Result := getIntegerField('CurrencyFormat'); end;
function TRegionalOptions.GetNegCurrFormat: Integer; begin   Result := getIntegerField('NegCurrFormat'); end;
function TRegionalOptions.GetShortDateFormat: string; begin   Result := GetStringField('ShortDateformat'); end;
function TRegionalOptions.GetDateSeparator: string; begin   Result := GetStringField('DateSeparator'); end;
function TRegionalOptions.GetSuburbName: string; begin   Result := GetStringField('SuburbName'); end;
function TRegionalOptions.GetStateName: string; begin   Result := GetStringField('StateName'); end;
function TRegionalOptions.GetPostcodeLength: Integer; begin  Result := getIntegerField('PostcodeLength'); end;
function TRegionalOptions.GetPostcodeMask: string; begin   Result := GetStringField('PostcodeMask');end;
function TRegionalOptions.GetPhoneNumberLength: Integer; begin   Result := getIntegerField('PhoneNumberLength'); end;
function TRegionalOptions.GetPhoneNumberMask: string; begin  Result := GetStringField('PhoneNumberMask');end;
function TRegionalOptions.GetMobileNumberLength: Integer;begin  Result := getIntegerField('MobileNumberLength');end;
function TRegionalOptions.GetMobileNumberMask: string;begin  Result := GetStringField('MobileNumberMask');end;
function TRegionalOptions.GetBSBName: string;begin  Result := GetStringField('BSBName');end;
function TRegionalOptions.GetSLName: string;begin  Result := GetStringField('SLName');end;
function TRegionalOptions.GetBSBLength: Integer;begin  Result := getIntegerField('BSBLength');end;
function TRegionalOptions.GetBSBMask: string;begin  Result := GetStringField('BSBMask');end;
function TRegionalOptions.GetBankAccountLength: Integer;begin  Result := getIntegerField('BankAccountLength');end;
function TRegionalOptions.GetBankNumberLength: Integer;begin  Result := getIntegerField('BankNumberLength');end;
function TRegionalOptions.GetBankAccountMask: string;begin  Result := GetStringField('BankAccountMask');end;
function TRegionalOptions.GetBankNumberMask: string;begin  Result := GetStringField('BankNumberMask');end;
function TRegionalOptions.GetForeignExDefault: string;begin  Result := GetStringField('ForeignExDefault');end;
function TRegionalOptions.getPOSDocName: string; begin   Result := GetStringField('POSDocName'); end;
function TRegionalOptions.getDecimalPlaces: Integer; begin   Result := getIntegerField('DecimalPlaces'); end;
function TRegionalOptions.GetRegionAbbreviation: string;begin  Result := GetStringField('RegionAbbreviation');end;
function TRegionalOptions.GetWeekStartDay: Integer;begin  Result := getIntegerField('WeekStartDay');end;
function TRegionalOptions.GetTaxCodeNoTax: string;begin  Result := GetStringField('TaxCodeNoTax');end;
function TRegionalOptions.GetTaxCodePurchaseEx: string;begin  Result := GetStringField('TaxCodePurchaseEx');end;
function TRegionalOptions.GetTaxCodePurchaseInc: string;begin  Result := GetStringField('TaxCodePurchaseInc');end;
function TRegionalOptions.GetTaxCodeSalesEx: string;begin  Result := GetStringField('TaxCodeSalesEx');end;
function TRegionalOptions.GetTaxCodeSalesInc: string;begin  Result := GetStringField('TaxCodeSalesInc');end;
function TRegionalOptions.GetBusinessNoLabel: string;begin  Result := GetStringField('BusinessNoLabel');end;
function TRegionalOptions.GetBusinessTaxNoLabel: string;begin  Result := GetStringField('BusinessTaxNoLabel');end;
function TRegionalOptions.GetBusinessTaxNoLength: Integer;begin  Result := getIntegerField('BusinessTaxNoLength');end;
function TRegionalOptions.GetBusinessTaxNoMask: string;begin  Result := GetStringField('BusinessTaxNoMask');end;
// function  TRegionalOptions.GetBussinessNoName       : string    ; begin Result := GetStringField('BussinessNoName');end;
// function  TRegionalOptions.GetCustomerABNMask       : string    ; begin Result := GetStringField('CustomerABNMask');end;
// function  TRegionalOptions.GetCustomerABNLength     : Integer   ; begin Result := GetIntegerField('CustomerABNLength');end;
procedure TRegionalOptions.setPOSDocName(const Value: string); begin   SetStringField('POSDocName', Value); end;
procedure TRegionalOptions.SetDecimalPlaces(const Value: Integer);begin  SetIntegerField('DecimalPlaces', Value);end;
procedure TRegionalOptions.SetRegion(const Value: string);begin  SetStringField('Region', Value);end;
procedure TRegionalOptions.SetCurrencySymbol(const Value: string);begin  SetStringField('CurrencySymbol', Value);end;
procedure TRegionalOptions.SetWholeCurrencyName(const Value: string);begin  SetStringField('WholeCurrencyName', Value);end;
procedure TRegionalOptions.SetDecimalCurrencyName(const Value: string);begin  SetStringField('DecimalCurrencyName', Value);end;
procedure TRegionalOptions.SetCurrencyFormat(const Value: Integer);begin  SetIntegerField('CurrencyFormat', Value);end;
procedure TRegionalOptions.SetNegCurrFormat(const Value: Integer);begin  SetIntegerField('NegCurrFormat', Value);end;
procedure TRegionalOptions.SetShortDateFormat(const Value: string);begin  SetStringField('ShortDateformat', Value);end;
procedure TRegionalOptions.SetDateSeparator(const Value: string);begin  SetStringField('DateSeparator', Value);end;
procedure TRegionalOptions.SetSuburbName(const Value: string);begin  SetStringField('SuburbName', Value);end;
procedure TRegionalOptions.SetStateName(const Value: string);begin  SetStringField('StateName', Value);end;
procedure TRegionalOptions.SetPostcodeLength(const Value: Integer);begin  SetIntegerField('PostcodeLength', Value);end;
procedure TRegionalOptions.SetPostcodeMask(const Value: string);begin  SetStringField('PostcodeMask', Value);end;
procedure TRegionalOptions.SetPhoneNumberLength(const Value: Integer);begin  SetIntegerField('PhoneNumberLength', Value);end;
procedure TRegionalOptions.SetPhoneNumberMask(const Value: string);begin  SetStringField('PhoneNumberMask', Value);end;
procedure TRegionalOptions.SetMobileNumberLength(const Value: Integer);begin  SetIntegerField('MobileNumberLength', Value);end;
procedure TRegionalOptions.SetMobileNumberMask(const Value: string);begin  SetStringField('MobileNumberMask', Value);end;
procedure TRegionalOptions.SetBSBName(const Value: string);begin  SetStringField('BSBName', Value);end;
procedure TRegionalOptions.SetSLName(const Value: string);begin  SetStringField('SLName', Value);end;
procedure TRegionalOptions.SetBSBLength(const Value: Integer);begin  SetIntegerField('BSBLength', Value);end;
procedure TRegionalOptions.SetBSBMask(const Value: string);begin  SetStringField('BSBMask', Value);end;
procedure TRegionalOptions.SetBankAccountLength(const Value: Integer);begin  SetIntegerField('BankAccountLength', Value);end;
procedure TRegionalOptions.SetBankNumberLength(const Value: Integer);begin  SetIntegerField('BankNumberLength', Value);end;
procedure TRegionalOptions.SetBankAccountMask(const Value: string);begin  SetStringField('BankAccountMask', Value);end;
procedure TRegionalOptions.SetBankNumberMask(const Value: string);begin  SetStringField('BankNumberMask', Value);end;
procedure TRegionalOptions.SetForeignExDefault(const Value: string);begin  SetStringField('ForeignExDefault', Value);end;
procedure TRegionalOptions.setMoneyWordsShowsDecimalCurrencyName(const Value :Boolean);begin  SetBooleanfield('MoneyWordsShowsDecimalCurrencyName' , value);end;
procedure TRegionalOptions.setISDCode(const Value: Integer);begin  SetIntegerField('ISDCode', Value);end;
procedure TRegionalOptions.setCountryId(const Value: Integer);begin  SetIntegerField('CountryId', Value);end;
procedure TRegionalOptions.setLanguageID(const Value: Integer);begin  SetIntegerField('LanguageID', Value);end;
procedure TRegionalOptions.SetRegionAbbreviation(const Value: string);begin  SetStringField('RegionAbbreviation', Value);end;
procedure TRegionalOptions.SetWeekStartDay(const Value: Integer);begin  SetIntegerField('WeekStartDay', Value);end;
procedure TRegionalOptions.SetTaxCodeNoTax(const Value: string);begin  SetStringField('TaxCodeNoTax', Value);end;
procedure TRegionalOptions.SetTaxCodePurchaseEx(const Value: string);begin  SetStringField('TaxCodePurchaseEx', Value);end;
procedure TRegionalOptions.SetTaxCodePurchaseInc(const Value: string);begin  SetStringField('TaxCodePurchaseInc', Value);end;
procedure TRegionalOptions.SetTaxCodeSalesEx(const Value: string);begin  SetStringField('TaxCodeSalesEx', Value);end;
procedure TRegionalOptions.SetTaxCodeSalesInc(const Value: string);begin  SetStringField('TaxCodeSalesInc', Value);end;
procedure TRegionalOptions.SetBusinessNoLabel(const Value: string);begin  SetStringField('BusinessNoLabel', Value);end;
procedure TRegionalOptions.SetBusinessTaxNoLabel(const Value: string);begin  SetStringField('BusinessTaxNoLabel', Value);end;
procedure TRegionalOptions.SetBusinessTaxNoLength(const Value: Integer);begin  SetIntegerField('BusinessTaxNoLength', Value);end;
procedure TRegionalOptions.SetBusinessTaxNoMask(const Value: string);begin  SetStringField('BusinessTaxNoMask', Value);end;
// procedure TRegionalOptions.SetBussinessNoName       (const Value: string    ); begin SetStringField('BussinessNoName'        , Value);end;
// procedure TRegionalOptions.SetCustomerABNMask       (const Value: string    ); begin SetStringField('CustomerABNMask'        , Value);end;
// procedure TRegionalOptions.SetCustomerABNLength     (const Value: Integer   ); begin SetIntegerField('CustomerABNLength'      , Value);end;
(* Procedure TRegionalOptions.setRegionLanguageFont(Value         :TFont);
  var
  st:TStringList;
  begin
  try
  Value := Tfont.create;
  {default value}
  Value.name := 'Arial';
  Value.size:= 9;
  Value.style := [fsBold];

  if Languagefont <>'' then begin
  Split(Languagefont , ';' , st);
  if st.Count>= 1 then Value.Name:= st[0];
  if st.Count>= 2 then Value.Size:= strToint(st[1]);
  if st.Count>= 3 then
  if SameText(st[2] ,'[fsBold, fsItalic]') then Value.Style := [fsBold, fsItalic]
  else if SameText(st[2] ,'[fsItalic]')         then Value.Style := [fsItalic]
  else if SameText(st[2] ,'[fsBold]')           then Value.Style := [fsBold]
  else if SameText(st[2] ,'[]')                 then Value.Style := []
  else Value.Style := [];
  end;
  finally
  freeandNil(st);
  end;

  end; *)



class function TRegionalOptions.GetKeyStringProperty: string;
begin
  result:= 'Region';
end;
function TRegionalOptions.getWeekEndDay1: Integer;begin
  result := WeekStartDay-2;
  if result =-1 then result := 6
  else if result =0 then result := 7;
end;

function TRegionalOptions.getWeekEndDay2: Integer;
begin
  result := WeekStartDay-1;
  if result =-1 then result := 6
  else if result =0 then result := 7;
end;
procedure TRegionalOptions.ApplyBankFormatting(const Component: TComponent);
const
  aysBSBLabel: array [0 .. 1] of string = ('BSB', 'lblBSB');
  aysBSBField: array [0 .. 2] of string = ('BSB', 'edtBSB' , 'BankAccountBSB');
  aysBankAccountField: array [0..1] of string = ('BankAccountNo', 'BankAccountNumber');
  aysBankNumberField: array [0..0] of string = ('BankNumber');
  aysBankNumberLabel: array [0..0] of string = ('Bank Number');
  aysBankCodeLabel: array [0..0] of string = ('Bank Code');
  aysBankCodeField: array [0..1] of string = ('Bank Code', 'BankCode');
var
  iIndex: Integer;
begin
  if Component is TField then begin
     //  BSB Display Label
    for iIndex := 0 to high(aysBSBLabel) do begin
      if (Pos(uppercase(aysBSBLabel[iIndex]), uppercase(TField(Component).FieldName)) <> 0) or (Pos(uppercase(aysBSBLabel[iIndex]), uppercase(TField(Component).DisplayName)) <> 0) then begin
        TField(Component).DisplayLabel := BSBName;
      end;
    end;

    if not TField(Component).Dataset.Active then begin
      // BSB Field
      for iIndex := 0 to high(aysBSBField) do begin
        if (Pos(uppercase(aysBSBField[iIndex]), uppercase(TField(Component).FieldName)) <> 0) or (Pos(uppercase(aysBSBField[iIndex]), uppercase(TField(Component).DisplayName)) <> 0) then begin
          if AppEnv.CompanyPrefs.BankAccFormatting then begin
            TField(Component).EditMask := BSBMask;
            // Size 1 = Boolean
            if (TField(Component).DataType = ftwideString) and (TField(Component).Size > 1) then TField(Component).Size := BSBLength;
            if (TField(Component).DataType = ftwideString) and (TField(Component).Size > 1) then TField(Component).DisplayWidth := BSBLength;
            if (TField(Component).DataType = ftwideString) and (TField(Component).Size > 1) then TField(Component).Displaylabel := BSBName;
          end else begin
            TField(Component).EditMask := '';
          end;

        end;
      end;

      // Bank Account Field
      for iIndex := 0 to high(aysBankAccountField) do begin
        if (Pos(uppercase(aysBankAccountField[iIndex]), uppercase(TField(Component).FieldName)) <> 0) or (Pos(uppercase(aysBankAccountField[iIndex]), uppercase(TField(Component).DisplayName)) <> 0)
        then begin
          if AppEnv.CompanyPrefs.BankAccFormatting then begin
            TField(Component).EditMask := BankAccountMask;
            // Size 1 = Boolean
            if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).Size := BankAccountLength;
            if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).DisplayWidth := BankAccountLength;
          end else begin
            TField(Component).EditMask := '';
          end;
        end;
      end;

      // Bank Account Field
      for iIndex := 0 to high(aysBankNumberField) do begin
        if (Pos(uppercase(aysBankNumberField[iIndex]), uppercase(TField(Component).FieldName)) <> 0) or (Pos(uppercase(aysBankNumberField[iIndex]), uppercase(TField(Component).DisplayName)) <> 0)
        then begin
          if AppEnv.CompanyPrefs.BankAccFormatting then begin
            TField(Component).EditMask := BankNumberMask;
            // Size 1 = Boolean
            if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).Size := BankNumberLength;
            if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).DisplayWidth := BankNumberLength;
          end else begin
            TField(Component).EditMask := '';
          end;
        end;
      end;
    end;
  end;

  if (Component is TLabel) then begin
    // BSB Label
    for iIndex := 0 to high(aysBSBLabel) do begin
      if (Pos(uppercase(aysBSBLabel[iIndex]), uppercase(TLabel(Component).Caption)) <> 0) then begin
        TLabel(Component).AutoSize := true;
        TLabel(Component).WordWrap := False;
        TLabel(Component).Caption := BSBName;
      end;
    end;
    // Bank Code Label
    for iIndex := 0 to high(aysBankCodeLabel) do begin
      if (Pos(uppercase(aysBankCodeLabel[iIndex]), uppercase(TLabel(Component).Caption)) <> 0) then begin
        TLabel(Component).Visible := (RegionType = rAust) or (RegionType = rUSA) or (RegionType = rNz);
      end;
    end;

    for iIndex := low(aysBankNumberLabel) to high(aysBankNumberLabel) do begin
      if (Pos(uppercase(aysBankNumberLabel[iIndex]), uppercase(TLabel(Component).Caption)) <> 0) then begin
        TLabel(Component).Visible :=  (RegionType = rNz);
      end;
    end;
  end;

  if (Component is TwwDBEdit) then begin
      if Assigned(TwwDBEdit(Component).Datasource) and Assigned(TwwDBEdit(Component).Datasource.DataSet) and Assigned(TwwDBEdit(Component).Datasource.DataSet.FindField(TwwDBEdit(Component).DataField)) then begin
        try
            for iIndex := 0 to high(aysBSBField) do
              if TwwDBEdit(Component).MaxLength < TwwDBEdit(Component).Datasource.DataSet.FindField(TwwDBEdit(Component).DataField).Size then
                TwwDBEdit(Component).MaxLength := TwwDBEdit(Component).Datasource.DataSet.FindField(TwwDBEdit(Component).DataField).Size;
            for iIndex := 0 to high(aysBankAccountField) do
              if TwwDBEdit(Component).MaxLength < TwwDBEdit(Component).Datasource.DataSet.FindField(TwwDBEdit(Component).DataField).Size then
                TwwDBEdit(Component).MaxLength := TwwDBEdit(Component).Datasource.DataSet.FindField(TwwDBEdit(Component).DataField).Size;
            for iIndex := 0 to high(aysBankNumberField) do
              if TwwDBEdit(Component).MaxLength < TwwDBEdit(Component).Datasource.DataSet.FindField(TwwDBEdit(Component).DataField).Size then
                TwwDBEdit(Component).MaxLength := TwwDBEdit(Component).Datasource.DataSet.FindField(TwwDBEdit(Component).DataField).Size;
        Except
        end;
      end;
      for iIndex := 0 to high(aysBankNumberField) do begin
        if (Pos(uppercase(aysBankNumberField[iIndex]), uppercase(TwwDBEdit(Component).DataField)) <> 0) then begin
          TwwDBEdit(Component).Visible :=  (RegionType = rNZ);
        end;
      end;
  end;

  if (Component is TwwDBLookupCombo) then begin
    // Bank Code Combo
    for iIndex := 0 to high(aysBankCodeField) do begin
      if (Pos(uppercase(aysBankCodeField[iIndex]), uppercase(TwwDBLookupCombo(Component).DataField)) <> 0) then begin
        TwwDBLookupCombo(Component).Visible := (RegionType = rAust) or (RegionType = rUSA) or (RegionType = rNZ);
      end;
    end;
  end;

  if sysutils.SameText(Component.Owner.ClassName, 'TfrmChartOfAccounts') then begin
    if (Component is TDNMPanel) and sysutils.SameText(Component.Name, 'pnlEFT') then begin
      TDNMPanel(Component).Visible := (RegionType = rAust) or (RegionType = rUSA) or (RegionType = rNZ);
    end;
  end;
end;

Procedure TRegionalOptions.ApplyBaseListingsFormatting(const Component: TComponent);
var
  iIndex, iIndex2: Integer;
const
  aysSuburbDisplayNames: array [0 .. 2] of string = ('Suburb', 'Bill Suburb', 'City_Sub');
  aysStateDisplayNames: array [0 .. 1] of string = ('State', 'Bill State');
begin
  // BaseListings
  if (Component is TERPQuery) and sysutils.SameText(Component.Name, 'qryMain') then begin

    for iIndex2 := 0 to TERPQuery(Component).FieldCount - 1 do begin

      // Suburb Display Names
      for iIndex := 0 to high(aysSuburbDisplayNames) do begin
        if (Pos(uppercase(aysSuburbDisplayNames[iIndex]), uppercase(TERPQuery(Component).Fields[iIndex2].DisplayLabel)) <> 0) then begin
          TERPQuery(Component).Fields[iIndex2].DisplayLabel := SuburbName;
          // StringReplace(TERPQuery(Component).Fields[iIndex2].DisplayLabel, aysSuburbDisplayNames[iIndex],SuburbName, [rfReplaceAll,rfIgnoreCase]);
        end;
      end;

      // State Display Names
      for iIndex := 0 to high(aysStateDisplayNames) do begin
        if (Pos(uppercase(aysStateDisplayNames[iIndex]), uppercase(TERPQuery(Component).Fields[iIndex2].DisplayLabel)) <> 0) then begin
          TERPQuery(Component).Fields[iIndex2].DisplayLabel := StateName;
          // StringReplace(TERPQuery(Component).Fields[iIndex2].DisplayLabel, aysStateDisplayNames[iIndex],StateName, [rfReplaceAll,rfIgnoreCase]);
        end;
      end;

    end;

  end;
end;

procedure TRegionalOptions.ApplyBussinessNoFormatting(const Component: TComponent);
begin
  if Component is TLabel then begin
    TLabel(Component).Caption := StringReplace(TLabel(Component).Caption, 'ABN', BusinessTaxNoLabel, [rfIgnoreCase]);
    TLabel(Component).Caption := StringReplace(TLabel(Component).Caption, 'Company No', BusinessNoLabel, [rfIgnoreCase]);
  end;
end;

procedure TRegionalOptions.ApplyCurrencyFormatting(const Component: TComponent);
var
  fsFieldname:String;
begin
  try
    if Component is TLabel then begin
      fsFieldname:= TLabel(Component).Name;
      TLabel(Component).Caption := StringReplace(TLabel(Component).Caption, '$', self.CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
    end;
    if Component is TERPQuery then begin
      fsFieldname:=TERPQuery(Component).Name;
      if not TERPQuery(Component).Active then TERPQuery(Component).SQL.Text := StringReplace(TERPQuery(Component).SQL.Text, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
    end;
    if Component is TERPQuery then begin
      fsFieldname:=TERPQuery(Component).Name;
      if not TERPQuery(Component).Active then TERPQuery(Component).SQL.Text := StringReplace(TERPQuery(Component).SQL.Text, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
    end;
    if Component is TNumericField then begin
      fsFieldname:=TNumericField(Component).Name;
      TNumericField(Component).DisplayFormat := StringReplace(TNumericField(Component).DisplayFormat, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
      TNumericField(Component).EditFormat := StringReplace(TNumericField(Component).EditFormat, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
    end;
    if Component is TField then begin
      fsFieldname:=TField(Component).Name+':'+TField(Component).Fieldname+':'+TField(Component).DisplayLabel;
      TField(Component).DisplayLabel := StringReplace(TField(Component).DisplayLabel, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
      if not TField(Component).Dataset.Active then TField(Component).FieldName := StringReplace(TField(Component).FieldName, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
      TField(Component).Origin := '';
    end;
    if Component is TAdvStringGrid then begin
      fsFieldname:=TAdvStringGrid(Component).Name;
      TAdvStringGrid(Component).ColumnHeaders.Text := StringReplace(TAdvStringGrid(Component).ColumnHeaders.Text, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
    end;
    if Component is TRadioGroup then begin
      fsFieldname:=TRadioGroup(Component).Name;
      TRadioGroup(Component).Items.Text := StringReplace(TRadioGroup(Component).Items.Text, 'Dollar', WholeCurrencyName, [rfReplaceAll, rfIgnoreCase]);
    end;
    if Component is TLabel then begin
      fsFieldname:=TLabel(Component).name;
      TLabel(Component).Caption := StringReplace(TLabel(Component).Caption, 'Cents', DecimalCurrencyName, [rfReplaceAll, rfIgnoreCase]);
    end;
    if Component is TwwCheckBox then begin
      fsFieldname:=TwwCheckBox(Component).name;
      TwwCheckBox(Component).Caption := StringReplace(TwwCheckBox(Component).Caption, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
    end;
  Except
    on E:Exception do begin
      logtext(fsFieldname);
      logtext(E.Message);
    end;
  end;
end;

procedure TRegionalOptions.ApplyDatetimeFormatting(const Component: TComponent);
begin
  if (Component is TField) and (not TField(Component).Dataset.Active) then begin
    if Component is TDateTimeField then begin
      //TDateTimeField(Component).Displayformat := FormatSettings.ShortDateFormat+' hh:nn:ss am/pm';
    end else if Component is TDateField then begin
      TDateField(Component).Displayformat := FormatSettings.ShortDateFormat;
    end;
  end;
end;

procedure TRegionalOptions.ApplyDefaultForeignExFormatting;
begin

end;

procedure TRegionalOptions.ApplyDefaultProductFormatting;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  try
    qryTemp.Connection := GetSharedMyDacConnection;
    if (RegionType = rUK) then begin
      qryTemp.SQL.Text := 'select PartName from tblparts where PARTNAME= "£Discount"';
      qryTemp.Open;
      if qryTemp.IsEmpty then begin
        qryTemp.Close;
        qryTemp.SQL.Text := 'UPDATE tblparts SET PARTNAME= "£Discount", PARTSDESCRIPTION= "Pound Discount" WHERE PARTNAME="$Discount";';
        try qryTemp.Execute;
        except
        end;
      end;
      qryTemp.Close;
      qryTemp.SQL.Text := 'select PartName from tblparts where PARTNAME= "£Surcharge"';
      qryTemp.Open;
      if qryTemp.IsEmpty then begin
        qryTemp.Close;
        qryTemp.SQL.Text := 'UPDATE tblparts SET PARTNAME= "£Surcharge", PARTSDESCRIPTION= "Pound Surcharge" WHERE PARTNAME="$Surcharge";';
        try qryTemp.Execute;
        except
        end;
      end;
    end else begin
//      qryTemp.SQL.Clear;
//      qryTemp.SQL.Add('UPDATE tblparts SET PARTNAME= "$Discount", PARTSDESCRIPTION= "Dollar Discount" WHERE PARTNAME="£Discount";');
//      try qryTemp.Execute;
//      except
//      end;
//      qryTemp.SQL.Clear;
//      qryTemp.SQL.Add('UPDATE tblparts SET PARTNAME= "$Surcharge", PARTSDESCRIPTION= "Dollar Surcharge" WHERE PARTNAME="£Surcharge";');
//      try qryTemp.Execute;
//      except
//      end;
      qryTemp.SQL.Text := 'select PartName from tblparts where PARTNAME= "$Discount"';
      qryTemp.Open;
      if qryTemp.IsEmpty then begin
        qryTemp.Close;
        qryTemp.SQL.Text := 'UPDATE tblparts SET PARTNAME= "$Discount", PARTSDESCRIPTION= "Dollar Discount" WHERE PARTNAME="£Discount";';
        try qryTemp.Execute;
        except
        end;
      end;
      qryTemp.Close;
      qryTemp.SQL.Text := 'select PartName from tblparts where PARTNAME= "$Surcharge"';
      qryTemp.Open;
      if qryTemp.IsEmpty then begin
        qryTemp.Close;
        qryTemp.SQL.Text := 'UPDATE tblparts SET PARTNAME= "$Surcharge", PARTSDESCRIPTION= "Dollar Surcharge" WHERE PARTNAME="£Surcharge";';
        try qryTemp.Execute;
        except
        end;
      end;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;
procedure TRegionalOptions.MyScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
begin
  Action := eaContinue;
end;
procedure TRegionalOptions.ApplyDefaultTaxStatmentFormatting;
begin
  With TempMyScript do try
    OnError := MyScriptError;
    case RegionType of
      rUK:
        begin
          SQL.Add('UPDATE tblforms SET FormName= "TfmVATReturn"       , Description = "VAT Return"      WHERE (FormName = "TfmNZReturn")       or (FormName = "TfmBASReturn");');
          SQL.Add('UPDATE tblforms SET FormName = "TVATReturnListGUI" , Description = "VAT Return List" WHERE (FormName = "TBasReturnListGUI") or (FormName = "TNZReturnlistGUI");');
          SQL.Add('update tbltemplates Set Active = "F" where  typeid in (42, 102) ;');
          SQL.add('INSERT ignore INTO `tblforms` (`FormName`, `Description`, `TabGroup`, `SkinsGroup`) VALUES ("TVATReturnListGUI", "VAT Report List", 18, "Returns");');
          SQL.add('INSERT ignore INTO `tblforms` (`FormName`, `Description`, `TabGroup`, `SkinsGroup`) VALUES ("TfmVATReturn", "VAT Report", 18, "Returns");');
        end;
      rNZ:
        begin
          SQL.Add('UPDATE tblforms SET FormName= "TfmNZReturn"      , Description = "GST Return"      WHERE (FormName = "TfmVATReturn")      or (FormName = "TfmBASReturn");');
          SQL.Add('UPDATE tblforms SET FormName= "TNZReturnlistGUI" , Description = "GST Return List" WHERE (FormName = "TBasReturnListGUI") or (FormName = "TVATReturnListGUI");');
          SQL.Add('update tbltemplates Set Active = "F" where  typeid in (42, 103);');
          SQL.add('INSERT ignore INTO `tblforms` (`FormName`, `Description`, `TabGroup`, `SkinsGroup`) VALUES ("TNZReturnlistGUI", "GST Report List", 18, "Returns");');
          SQL.add('INSERT ignore INTO `tblforms` (`FormName`, `Description`, `TabGroup`, `SkinsGroup`) VALUES ("TfmNZReturn", "GST Report", 18, "Returns");');
        end;
      else
        begin
          SQL.Add('UPDATE tblforms SET FormName = "TfmBASReturn", Description = "BAS Report" WHERE (FormName= "TfmVATReturn") or (FormName= "TfmNZReturn");');
          SQL.Add('UPDATE tblforms SET FormName = "TBasReturnListGUI", Description= "BAS Report List" WHERE (FormName = "TVATReturnListGUI") or (FormName = "TNZReturnlistGUI");');
          SQL.Add('update tbltemplates Set Active = "F" where  typeid in (102, 103) ;');
          SQL.add('INSERT ignore INTO `tblforms` (`FormName`, `Description`, `TabGroup`, `SkinsGroup`) VALUES ("TBasReturnListGUI", "BAS Report List", 18, "Returns");');
          SQL.add('INSERT ignore INTO `tblforms` (`FormName`, `Description`, `TabGroup`, `SkinsGroup`) VALUES ("TfmBASReturn", "BAS Report", 18, "Returns");');
        end;
      end;
    //Payroll
    case RegionType of
      rUSA: begin
              SQL.Add('UPDATE tblforms SET FormName = "TfmEmployeePayUSA"  WHERE (FormName= "TfrmEmployeePay");');
              SQL.Add('UPDATE tblforms SET FormName = "TfmPaySummaryUSA"   WHERE (FormName= "TfrmPaySummary");');
            end;
      else  begin
              SQL.Add('UPDATE tblforms SET FormName = "TfrmEmployeePay"    WHERE (FormName= "TfmEmployeePayUSA");');
              SQL.Add('UPDATE tblforms SET FormName = "TfrmPaySummary"     WHERE (FormName= "TfmPaySummaryUSA");');
            end;
      end;
    	Execute;
  finally
    Free;
  end;
end;

procedure TRegionalOptions.ApplyLocationsFormatting(const Component: TComponent);
var
  iStrlst, iIndex: Integer;
  ComboStrings: TStringList;
  sField, sWidth, sDesc, sEnd: string;
const
  aysSuburbCombs  : array [0 .. 2] of string = ('Suburb', 'Suburb2', 'BillSuburb');
  aysSuburbLabels : array [0 .. 2] of string = ('lblSuburb', 'lblSuburb2', 'lblBillSuburb');
  aysStateEdit    : array [0 .. 2] of string = ('State', 'State2', 'BillState');
  aysStateLabels  : array [0 .. 2] of string = ('lblState', 'lblState2', 'lblBillState');
  aysPcodeEdit    : array [0 .. 2] of string = ('Postcode', 'Postcode2', 'BillPostcode');
  aysPcodeLabels  : array [0 .. 2] of string = ('lblPostcode', 'lblPostcode2', 'lblBillPostcode');
begin
  if Component is TwwDBLookupCombo then begin
    for iIndex := 0 to high(aysSuburbCombs) do begin
      if (Pos(uppercase(aysSuburbCombs[iIndex]), uppercase(TwwDBLookupCombo(Component).Name)) <> 0) then begin
        ComboStrings := TStringList.Create;
        try
          ComboStrings.Text := TwwDBLookupCombo(Component).Selected.Text;
          for iStrlst := 0 to ComboStrings.Count - 1 do begin
            sField := CommonLib.ExtractStrPortion(ComboStrings[iStrlst], #9, 1);
            sWidth := '20';
            sDesc := CommonLib.ExtractStrPortion(ComboStrings[iStrlst], #9, 3);
            sEnd := CommonLib.ExtractStrPortion(ComboStrings[iStrlst], #9, 4);
            sDesc := StringReplace(sDesc, 'Suburb', SuburbName, [rfReplaceAll, rfIgnoreCase]);
            sDesc := StringReplace(sDesc, 'State', StateName, [rfReplaceAll, rfIgnoreCase]);
            ComboStrings[iStrlst] := sField + #9 + sWidth + #9 + sDesc + #9 + sEnd;
          end;
          TwwDBLookupCombo(Component).Selected.Text := ComboStrings.Text;
          if (RegionType = rUK) then TwwDBLookupCombo(Component).Width := 186;
        finally FreeAndNil(ComboStrings);
        end;
      end;
    end;
  end;
  if Component is TLabel then begin
    for iIndex := 0 to high(aysSuburbLabels) do begin
      if (Pos(uppercase(aysSuburbLabels[iIndex]), uppercase(TLabel(Component).Name)) <> 0) then begin
        TLabel(Component).AutoSize := true;
        TLabel(Component).WordWrap := False;
        TLabel(Component).Caption := SuburbName + CommonLib.ExtractLabelSuffix(TLabel(Component).Caption);
      end;
    end;
  end;
  if Component is TDBEdit then begin
    for iIndex := 0 to high(aysStateEdit) do begin
      if (Pos(uppercase(aysStateEdit[iIndex]), uppercase(TDBEdit(Component).Name)) <> 0) then begin
        if (RegionType = rUK) then TDBEdit(Component).Width := 186;
      end;
    end;
  end;
  if Component is TLabel then begin
    for iIndex := 0 to high(aysStateLabels) do begin
      if (Pos(uppercase(aysStateLabels[iIndex]), uppercase(TLabel(Component).Name)) <> 0) then begin
        TLabel(Component).AutoSize := true;
        TLabel(Component).WordWrap := False;
        TLabel(Component).Caption := StateName + CommonLib.ExtractLabelSuffix(TLabel(Component).Caption);
      end;
    end;
  end;
  if Component is TLabel then begin
    for iIndex := 0 to high(aysPcodeLabels) do begin
      if (Pos(uppercase(aysPcodeLabels[iIndex]), uppercase(TLabel(Component).Name)) <> 0) then begin
        TLabel(Component).AutoSize := true;
        TLabel(Component).WordWrap := False;
        TLabel(Component).Caption := 'Postcode' + CommonLib.ExtractLabelSuffix(TLabel(Component).Caption);
      end;
    end;
  end;
  (* if Sysutils.SameText(Component.Owner.ClassName, 'TLocationListGUI') then begin
    if (Component is TERPQuery) and Sysutils.SameText(Component.Name, 'qryMain') then begin
    if not TERPQuery(Component).Active then TERPQuery(Component).SQL.Text := StringReplace(TERPQuery(Component).SQL.Text, 'as City_Sub', 'as "' + SuburbName + '"', [rfReplaceAll,rfIgnoreCase]);
    if not TERPQuery(Component).Active then TERPQuery(Component).SQL.Text := StringReplace(TERPQuery(Component).SQL.Text, 'as State', 'as ' + StateName, [rfReplaceAll,rfIgnoreCase]);
    end;
    end; *)
end;

procedure TRegionalOptions.ApplyPhoneNumFormatting(const Component: TComponent);
var
  iPhIndex: Integer;
  iPhExcludeIndex: Integer;
  ExcludeComponent: Boolean;
const
  aysPhExclude: array [0 .. 4] of string = ('PHONESUPPORTPERIODNO', 'PHONESUPPORTAMOUNTNO', 'FAXTO', 'FAXBY', 'FAXSPOOL');
  aysPh: array [0 .. 7] of string = ('PHONE', 'FAX', 'CONTACTPH', 'CONTACTALTPH', 'CONTACTFAX', 'TXTPHONE', 'BILLPHONE', 'BILLFAX');
  aysMOB: array [0 .. 1] of string = ('MOBILE', 'CONTACTMOB');
  aysABN: array [0 .. 0] of string = ('ABN');
begin
  ExcludeComponent := False;
  if (Component is TField) and (not TField(Component).Dataset.Active) then begin
    for iPhIndex := 0 to high(aysPh) do begin
      if (Pos(aysPh[iPhIndex], uppercase(TField(Component).FieldName)) <> 0) or (Pos(aysPh[iPhIndex], uppercase(TField(Component).DisplayName)) <> 0) then begin
        for iPhExcludeIndex := 0 to high(aysPhExclude) do begin
          if (Pos(aysPhExclude[iPhExcludeIndex], uppercase(TField(Component).FieldName)) <> 0) then begin
            ExcludeComponent := true;
          end;
        end;
        if not ExcludeComponent then
          if AppEnv.CompanyPrefs.PhoneNumberFormatting then begin
            TField(Component).EditMask := PhoneNumberMask;
            // Size 1 = Boolean
            if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).Size := PhoneNumberLength;
            if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).DisplayWidth := PhoneNumberLength;
          end else begin
            TField(Component).EditMask := '';
          end;
      end;
    end;
    for iPhIndex := 0 to high(aysMOB) do begin
      if (Pos(aysMOB[iPhIndex], uppercase(TField(Component).FieldName)) <> 0) or (Pos(aysMOB[iPhIndex], uppercase(TField(Component).DisplayName)) <> 0) then begin
        TField(Component).EditMask := '';
//        if AppEnv.CompanyPrefs.PhoneNumberFormatting then begin
//          TField(Component).EditMask := MobileNumberMask;
//          // Size 1 = Boolean
//          if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).Size := MobileNumberLength;
//          if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).DisplayWidth := MobileNumberLength;
//        end else begin
//          TField(Component).EditMask := '';
//        end;
      end;
    end;

    for iPhIndex := 0 to high(aysABN) do begin
      if (Pos(aysABN[iPhIndex], uppercase(TField(Component).Name)) <> 0) or (Pos(aysABN[iPhIndex], uppercase(TField(Component).DisplayName)) <> 0) then begin
        if AppEnv.CompanyPrefs.CustomerABNFormating then begin
          TField(Component).EditMask := BusinessTaxNoMask;
          // Size 1 = Boolean
          if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).Size := BusinessTaxNoLength;
          if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).DisplayWidth := BusinessTaxNoLength;
        end else begin
          TField(Component).EditMask := '';
        end;
      end;
    end;
  end;
end;

procedure TRegionalOptions.ApplyPOSFuncFormatting;
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  try
    qryTemp.Connection := GetSharedMyDacConnection;
    if (RegionType = rUK) then begin
      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('UPDATE tblposfunctions SET FunctionName= "Pound Discount", CaptionLine1= "£££",');
      qryTemp.SQL.Add('Description=REPLACE(Description,"$","£"), Hint = REPLACE(Hint,"dollars","pounds") WHERE ID=9;');
      try qryTemp.Execute;
      except
      end;
      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('UPDATE tblposfunctions SET FunctionName= "Pound Surcharge", CaptionLine1= "£££",');
      qryTemp.SQL.Add('Description=REPLACE(Description,"$","£"), Hint = REPLACE(Hint,"dollars","pounds") WHERE ID=11;');
      try qryTemp.Execute;
      except
      end;
    end else begin
      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('UPDATE tblposfunctions SET FunctionName= "Dollar Discount", CaptionLine1= "$$$",');
      qryTemp.SQL.Add('Description=REPLACE(Description,"£","$"), Hint = REPLACE(Hint,"pounds","dollars") WHERE ID=9;');
      try qryTemp.Execute;
      except
      end;
      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('UPDATE tblposfunctions SET FunctionName= "Dollar Surcharge", CaptionLine1= "$$$",');
      qryTemp.SQL.Add('Description=REPLACE(Description,"£","$"), Hint = REPLACE(Hint,"pounds","dollars") WHERE ID=11;');
      try qryTemp.Execute;
      except
      end;
    end;
  finally FreeAndNil(qryTemp);
  end;
end;

procedure TRegionalOptions.ApplyPostCodeFormatting(const Component: TComponent);
const
  aysPCode: array [0 .. 1] of string = ('POSTCODE', 'PCODE');
var
  iPCodeIndex: Integer;
begin
  if (Component is TField) and (not TField(Component).Dataset.Active) then begin
    for iPCodeIndex := 0 to high(aysPCode) do begin
      if (Pos(aysPCode[iPCodeIndex], uppercase(TField(Component).FieldName)) <> 0) or (Pos(aysPCode[iPCodeIndex], uppercase(TField(Component).DisplayName)) <> 0) then begin
        if AppEnv.CompanyPrefs.PostcodeFormatting then begin
          TField(Component).EditMask := PostcodeMask;
          // Size 1 = Boolean
          if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).Size := PostcodeLength;
          if (TField(Component).DataType = ftString) and (TField(Component).Size > 1) then TField(Component).DisplayWidth := PostcodeLength;
        end else begin
          TField(Component).EditMask := '';
        end;
      end;
    end;
  end;
end;

procedure TRegionalOptions.SetupRegion;
var
  MsgObj: TMsgObj;
  MsgHandler: TMsgHandler;
begin
  if Count <> 1 then exit;
  PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0, 0);
  Application.UpDateFormatSettings := False;
  FormatSettings.CurrencyString := CurrencySymbol;
  FormatSettings.CurrencyDecimals := DecimalPlaces;
  FormatSettings.CurrencyFormat := CurrencyFormat;
  FormatSettings.NegCurrFormat := NegCurrFormat;
  FormatSettings.ShortDateformat := ShortDateformat;
  FormatSettings.DateSeparator := DateSeparator[1];
  MsgHandler := TMsgHandler.Create(self);
  try
    if Assigned(FindExistingComponent('TMainForm')) then begin
      MsgObj := TMsgObj.Create;
      MsgObj.ClassStr := 'TMainForm';
      MsgObj.MethodStr := 'SetRegionCaption';
      MsgObj.StrValue := RegionAbbreviation;
      MsgHandler.sEnd(MsgObj);
    end;
  finally FreeAndNil(MsgHandler);
  end;
  ApplyDefaultForeignExFormatting;
  ApplyDefaultProductFormatting;
  ApplyPOSFuncFormatting;
  ApplyDefaultTaxStatmentFormatting;
end;

procedure TRegionalOptions.Load(const fIsReadonly: Boolean = False);
begin
  inherited;
end;

procedure TRegionalOptions.ChangeForm(const Form: TForm);
var
  iIndex, x: Integer;
  Component: TComponent;
  ds: TDataSet;
begin
  for iIndex := 0 to Form.ComponentCount - 1 do begin
    Component := Form.Components[iIndex];
    if (Component is TwwDbGrid)  and
      Assigned(TwwDbGrid(Component).DataSource) and Assigned(TwwDbGrid(Component).DataSource.DataSet) and
      (TwwDbGrid(Component).DataSource.DataSet.Owner <> Form) then begin
      ds := TwwDbGrid(Component).DataSource.DataSet;
      for x := 0 to ds.FieldCount -1 do begin
        ApplyCurrencyFormatting(ds.Fields[x]);
        ApplyLocationsFormatting(ds.Fields[x]);
        ApplyBankFormatting(ds.Fields[x]);
        ApplyPhoneNumFormatting(ds.Fields[x]);
        ApplyPostCodeFormatting(ds.Fields[x]);
        ApplyBussinessNoFormatting(ds.Fields[x]);
        ApplyDatetimeFormatting(ds.Fields[x]);
      end;
    end
    else begin
      ApplyCurrencyFormatting(Component);
      ApplyLocationsFormatting(Component);
      ApplyBankFormatting(Component);
      ApplyPhoneNumFormatting(Component);
      ApplyPostCodeFormatting(Component);
      ApplyBussinessNoFormatting(Component);
      ApplyDatetimeFormatting(Component);
    end;
  end;
end;

Procedure TRegionalOptions.ChangeList(const Component: TComponent);
begin
  ApplyBaseListingsFormatting(Component);
end;

procedure TRegionalOptions.ChangeQuery(const Query: TDataset);
var
  iIndex: Integer;
  Component: TComponent;
begin
  if Query is TERPQuery then begin
    if not TERPQuery(Query).Active then TERPQuery(Query).SQL.Text := StringReplace(TERPQuery(Query).SQL.Text, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
  end;
  if Query is TERPQuery then begin
    if not TERPQuery(Query).Active then TERPQuery(Query).SQL.Text := StringReplace(TERPQuery(Query).SQL.Text, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
  end;
  for iIndex := 0 to Query.FieldCount - 1 do begin
    Component := Query.Fields[iIndex];
    if Component is TNumericField then begin
      TNumericField(Component).DisplayFormat := StringReplace(TNumericField(Component).DisplayFormat, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
      TNumericField(Component).EditFormat := StringReplace(TNumericField(Component).EditFormat, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
    end;
    if Component is TField then begin
      TField(Component).DisplayLabel := StringReplace(TField(Component).DisplayLabel, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
      if not TField(Component).Dataset.Active then TField(Component).FieldName := StringReplace(TField(Component).FieldName, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
      TField(Component).Origin := '';
    end;
  end;
end;

function TRegionalOptions.ChangeStr(const Str: string): string;
begin
  Result := StringReplace(Str, '$', CurrencySymbol, [rfReplaceAll, rfIgnoreCase]);
end;

function TRegionalOptions.RegionType: TRegionType;
begin
  Result := RegionNameToRegionType(Region);
end;

function TRegionalOptions.RegionNameToRegionType(const aRegion: string): TRegionType;
begin
  if aRegion = 'Australia' then Result := rAust
  else if aRegion = 'United Kingdom' then Result := rUK
  else if aRegion = 'New Zealand' then Result := rNZ
  else if aRegion = 'South Africa' then Result := rRSA
  else if aRegion = 'United States of America' then Result := rUSA
  else if aRegion = 'Canada' then Result := rCAN
  else Result := rOther;
end;

procedure TRegionalOptions.LoadFlagPicture(aPicture: TIPicture);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    try
      TBlobField(Dataset.FieldByName('FlagImage')).SaveToStream(ms);
      if ms.Size > 0 then aPicture.LoadFromStream(ms)
      else aPicture.Assign(nil);
    except
      { ignore picture errors }
    end;
  finally ms.Free;
  end;
end;

function TRegionalOptions.DoAfterClose(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterClose(Sender);
  if not Result then exit;
end;

function TRegionalOptions.getDecimalValue: Integer;
var
  fiDecimalValue,x:Integer;
begin
  inherited;
  fiDecimalValue:= 1;
  for x := 1 to DecimalPlaces do
    fiDecimalValue:= fiDecimalValue * 10;  { ie: 100 for 2 places, 1000 for 3 places }
  result:= fiDecimalValue;
end;

function TRegionalOptions.getDeptClass: TDeptClass;
begin
    result := TDeptClass(GetContainerComponent(TDeptClass ,'ClassName = ' + quotedstr(Region) ));
    if result.count =0 then begin
      result.New;
      result.DeptClassName :=Region;
      result.Postdb;
    end;
end;
function TRegionalOptions.getDeptClassID: Integer;begin    REsult := DeptClass.ID;end;
function TRegionalOptions.getDeptClassName: String;begin    REsult := DeptClass.DeptClassName;end;

initialization

Classes.RegisterClass(TRegionalOptions);

end.
