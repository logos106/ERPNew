unit BusObjCurrency;

interface

uses BusObjBase, DB, Classes,  MyAccess,ERPdbComponents, XMLDoc, XMLIntf;


type

  TCurrency = class(TMSBusObj)
  private
    fCleanBuyRate: double;
    fCleanSellRate: double;
    fSymbolList: TStringList;
    Function GetCurrencyDesc             : string    ;
    Function GetCurrency                 : string    ;
    Function GetCode                     : string    ;
    Function GetBuyRate                  : Double    ;
    Function GetSellRate                 : Double    ;
    Function GetRateLastModified         : TDateTime ;
    Function GetActive                   : Boolean   ;
    Function GetFixedRate                : Double    ;
    Function GetUpperVariation           : Double    ;
    Function GetLowerVariation           : Double    ;
    Function GetTriggerPriceVariation    : Double    ;
    Function GetCurrencySymbol           : string    ;
    Procedure SetCurrencyDesc             (const Value: string    );
    Procedure SetCurrency                 (const Value: string    );
    Procedure SetCode                     (const Value: string    );
    Procedure SetBuyRate                  (const Value: Double    );
    Procedure SetSellRate                 (const Value: Double    );
    Procedure SetRateLastModified         (const Value: TDateTime );
    Procedure SetActive                   (const Value: Boolean   );
    Procedure SetFixedRate                (const Value: Double    );
    Procedure SetUpperVariation           (const Value: Double    );
    Procedure SetLowerVariation           (const Value: Double    );
    Procedure SetTriggerPriceVariation    (const Value: Double    );
    Procedure SetCurrencySymbol           (const Value: string    );
    function GetCountryID: integer;
    procedure SetCountryID(const Value: integer);
    function GetCountry: string;
    procedure SetCountry(const Value: string);
    function getCleanActive: Boolean;

  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    Procedure DoFieldOnChange(Sender: TField);                           override;
    Function  GetSQL: string;                                            override;
    Function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;

  Public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    Constructor  Create(AOwner: TComponent);                             override;
    Destructor   Destroy;                                                override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    Function     ValidateData: Boolean ;                                 override;
    Function     Save: Boolean ;                                         override;
    procedure Load(const fIsReadonly:boolean =False); override;
    class function CurrencySymbolForCode(const aCode: string; Connection: TERPConnection = nil): string;
    class function CurrencySymbolForId(const aId: Integer; Connection: TERPConnection = nil): string;
    function CachedSymbolForId(aCurrencyId: integer): string;
    property CountryID: integer read GetCountryID write SetCountryID;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    Property CleanActive :Boolean read getCleanActive;

  Published
    property CurrencyDesc               :string      read GetCurrencyDesc             write SetCurrencyDesc              ;
    property Country: string read GetCountry write SetCountry;
    property Currency                  :string      read GetCurrency                write SetCurrency             ;
    property Code                      :string      read GetCode                    write SetCode                 ;
    property BuyRate                   :Double      read GetBuyRate                 write SetBuyRate              ;
    property SellRate                  :Double      read GetSellRate                write SetSellRate             ;
    property RateLastModified          :TDateTime   read GetRateLastModified        write SetRateLastModified     ;
    property Active                    :Boolean     read GetActive                  write SetActive               ;
    property FixedRate                 :Double      read GetFixedRate               write SetFixedRate            ;
    property UpperVariation            :Double      read GetUpperVariation          write SetUpperVariation       ;
    property LowerVariation            :Double      read GetLowerVariation          write SetLowerVariation       ;
    property TriggerPriceVariation     :Double      read GetTriggerPriceVariation   write SetTriggerPriceVariation;
    property CurrencySymbol            :string      read GetCurrencySymbol          write SetCurrencySymbol       ;
  end;

  TCurrencyRateHistory = class(TMSBusObj)
  private
    function GetActive: Boolean;
    function GetBuyRate: Double;
    function GetCode: string;
    function GetCurrencyID: integer;
    function GetDate: TDateTime;
    function GetSellRate: Double;
    procedure SetActive(const Value: Boolean);
    procedure SetBuyRate(const Value: Double);
    procedure SetCode(const Value: string);
    procedure SetCurrencyID(const Value: integer);
    procedure SetDate(const Value: TDateTime);
    procedure SetSellRate(const Value: Double);
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    Procedure DoFieldOnChange(Sender: TField);                           override;
    Function  GetSQL: string;                                            override;
    Function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
    function GetIsList: boolean; override;
  Public
    class function GetBusObjectTablename: string; override;
    class function GetIDField: string; override;
    class function GetKeyStringField: string; override;
    Constructor  Create(AOwner: TComponent);                             override;
    Destructor   Destroy;                                                override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                  override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                    override;
    Function     ValidateData: Boolean ;                                 override;
    Function     Save: Boolean ;                                         override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    property CurrencyID: integer read GetCurrencyID write SetCurrencyID;
  Published
    property Code :string read GetCode write SetCode;
    property Date: TDateTime read GetDate write SetDate;
    property BuyRate: Double read GetBuyRate write SetBuyRate;
    property SellRate: Double read GetSellRate write SetSellRate;
    property Active: Boolean read GetActive write SetActive;
  end;


implementation

uses
  CommonLib, CommonDbLib, SysUtils, BusObjConst, BusObjSchemaLib,
  BusObjCountries;


  { TCurrency }

Constructor TCurrency.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Currency';
  fSQL := 'SELECT * FROM tblcurrencyconversion';
  fSymbolList:= TStringList.Create;
  fCleanBuyRate:= 0;
  fCleanSellRate:= 0;
end;


Destructor TCurrency.Destroy;
begin
  fSymbolList.Free;
  inherited;
end;


Procedure TCurrency.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'CurrencyDesc');
  SetPropertyFromNode(node,'Currency');
  SetPropertyFromNode(node,'Code');
  SetPropertyFromNode(node,'BuyRate');
  SetPropertyFromNode(node,'SellRate');
  SetDateTimePropertyFromNode(node,'RateLastModified');
  SetPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'FixedRate');
  SetPropertyFromNode(node,'UpperVariation');
  SetPropertyFromNode(node,'LowerVariation');
  SetPropertyFromNode(node,'TriggerPriceVariation');
  SetPropertyFromNode(node,'CurrencySymbol');
end;


Procedure TCurrency.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'CurrencyDesc' ,CurrencyDesc);
  AddXMLNode(node,'Currency' ,Currency);
  AddXMLNode(node,'Code' ,Code);
  AddXMLNode(node,'BuyRate' ,BuyRate);
  AddXMLNode(node,'SellRate' ,SellRate);
  AddXMLNode(node,'RateLastModified' ,RateLastModified);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'FixedRate' ,FixedRate);
  AddXMLNode(node,'UpperVariation' ,UpperVariation);
  AddXMLNode(node,'LowerVariation' ,LowerVariation);
  AddXMLNode(node,'TriggerPriceVariation' ,TriggerPriceVariation);
  AddXMLNode(node,'CurrencySymbol' ,CurrencySymbol);
end;


Function TCurrency.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := False;
  if Trim(CurrencyDesc) = '' then begin
    AddResult(false,rssWarning,BOR_Currency_No_Country,'Currency Description can not be blank.');
    Exit;
  end;
  if Trim(Currency) = '' then begin
    AddResult(false,rssWarning,BOR_Currency_No_Currency,'Currency can not be blank.');
    Exit;
  end;
  if Trim(Code) = '' then begin
    AddResult(false,rssWarning,BOR_Currency_No_Code,'Currency Code can not be blank.');
    Exit;
  end;
  if Active and (BuyRate <= 0) then begin
    AddResult(false,rssWarning,BOR_Currency_BuyRateInvalid,'Buy Rate must be a positive value greater than zero.');
    Exit;
  end;
  if Active and (SellRate <= 0) then begin
    AddResult(false,rssWarning,BOR_Currency_SellRateInvalid,'Sell Rate must be a positive value greater than zero.');
    Exit;
  end;
  if not isunique(ID, 'Code =' + quotedstr(Code), self.Connection.Connection) then begin
    AddResult(false,rssWarning,BOR_Currency_SellRateInvalid,'currency Code ' +quotedstr(Code) +' already exists.');
    Exit;
  end;
  Result := True;
end;


class function TCurrency._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TCountries','CountryObj','Country','Country');
end;

Function TCurrency.Save: Boolean ;
var
  hist: TCurrencyRateHistory;
begin
  Result := False;
  if not ValidateData then Exit;
  PostDB;
  Result := inherited Save;
  if result and (not RawMode) then begin
    if (fCleanBuyRate <> BuyRate) or (fCleanSellRate <> SellRate) then begin
      hist:= TCurrencyRateHistory.Create(nil);
      try
        hist.Connection:= self.Connection;
        hist.LoadSelect(
          'Code = ' + QuotedStr(self.Code) + ' and Date = ' + QuotedStr(FormatDateTime('yyyy-mm-dd',Date)));
        if hist.Count = 0 then begin
          hist.New;
          hist.CurrencyID:= self.ID;
          hist.Code:= self.Code;
          hist.Date:= Date;
        end;
        hist.BuyRate:= self.BuyRate;
        hist.SellRate:= self.SellRate;
        hist.Save;
      finally
        hist.Free;
      end;
    end;  
  end;
end;


Procedure TCurrency.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


Procedure TCurrency.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then Exit; // we are only interested in data fields.
  if Sysutils.SameText(Sender.FieldName , 'CountryID') then begin
    Country:= TCountries.IDToggle(Sender.AsInteger, Connection.Connection);
    CurrencyDesc:= TCountries.DescIDToggle(Sender.AsInteger, Connection.Connection);
  end
  else if Sysutils.SameText(Sender.FieldName , 'Country') then begin
    CountryID:= TCountries.DescIDToggle(Sender.AsString, Connection.Connection);
  end;
end;


Function TCurrency.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCurrency.GetBusObjectTablename: string;
begin
  Result := 'tblcurrencyconversion';
end;

class Function TCurrency.GetIDField: string;
begin
  Result := 'CurrencyID'
end;


Function TCurrency.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function TCurrency.GetCountry: string;
begin
  result:= TCountries.IDToggle(CountryID, Connection.Connection);
end;

Function  TCurrency.GetCurrencyDesc              : string    ; begin Result := GetStringField('Country');end;
function TCurrency.GetCountryID: integer;
begin
  result:= GetIntegerField('CountryID');
end;

Function  TCurrency.GetCurrency             : string    ; begin Result := GetStringField('Currency');end;
Function  TCurrency.GetCode                 : string    ; begin Result := GetStringField('Code');end;
Function  TCurrency.GetBuyRate              : Double    ; begin Result := GetFloatField('BuyRate');end;
function TCurrency.getCleanActive: Boolean; begin   Result := GetXMLNodeBooleanValue(CleanXMLNode, 'Active'); end;
Function  TCurrency.GetSellRate             : Double    ; begin Result := GetFloatField('SellRate');end;
Function  TCurrency.GetRateLastModified     : TDateTime ; begin Result := GetDateTimeField('RateLastModified');end;
Function  TCurrency.GetActive               : Boolean   ; begin Result := GetBooleanField('Active');end;
Function  TCurrency.GetFixedRate            : Double    ; begin Result := GetFloatField('FixedRate');end;
Function  TCurrency.GetUpperVariation       : Double    ; begin Result := GetFloatField('UpperVariation');end;
Function  TCurrency.GetLowerVariation       : Double    ; begin Result := GetFloatField('LowerVariation');end;
Function  TCurrency.GetTriggerPriceVariation: Double    ; begin Result := GetFloatField('TriggerPriceVariation');end;
Function  TCurrency.GetCurrencySymbol       : string    ; begin Result := GetStringField('CurrencySymbol');end;

Procedure TCurrency.SetCurrencyDesc              (const Value: string    ); begin SetStringField('Country'               , Value);end;
procedure TCurrency.SetCountryID            (const Value: integer   ); begin SetIntegerField('CountryID'            ,Value); end;
Procedure TCurrency.SetCurrency             (const Value: string    ); begin SetStringField('Currency'              , Value);end;
Procedure TCurrency.SetCode                 (const Value: string    ); begin SetStringField('Code'                  , Value);end;
Procedure TCurrency.SetBuyRate              (const Value: Double    ); begin SetFloatField('BuyRate'                , Value);end;
Procedure TCurrency.SetSellRate             (const Value: Double    ); begin SetFloatField('SellRate'               , Value);end;
Procedure TCurrency.SetRateLastModified     (const Value: TDateTime ); begin SetDateTimeField('RateLastModified'    , Value);end;
Procedure TCurrency.SetActive               (const Value: Boolean   ); begin SetBooleanField('Active'               , Value);end;
Procedure TCurrency.SetFixedRate            (const Value: Double    ); begin SetFloatField('FixedRate'              , Value);end;
Procedure TCurrency.SetUpperVariation       (const Value: Double    ); begin SetFloatField('UpperVariation'         , Value);end;
Procedure TCurrency.SetLowerVariation       (const Value: Double    ); begin SetFloatField('LowerVariation'         , Value);end;
Procedure TCurrency.SetTriggerPriceVariation(const Value: Double    ); begin SetFloatField('LowerVariation'         , Value);end;
Procedure TCurrency.SetCurrencySymbol       (const Value: string    ); begin SetStringField('CurrencySymbol'        , Value);end;
procedure TCurrency.SetCountry              (const Value: string    ); begin CountryID:= TCountries.IDToggle(Value, Connection.Connection); end;


class function TCurrency.CurrencySymbolForCode(const aCode: string;
  Connection: TERPConnection): string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select CurrencySymbol from tblCurrencyConversion');
    qry.SQL.Add('where code = ' + QuotedStr(aCode));
    qry.Open;
    result:= qry.FieldByName('CurrencySymbol').AsString;
  finally
    qry.Free;
  end;
end;

class function TCurrency.CurrencySymbolForId(const aId: Integer;
  Connection: TERPConnection): string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select CurrencySymbol from tblCurrencyConversion');
    qry.SQL.Add('where CurrencyID = ' + IntToStr(aId));
    qry.Open;
    result:= qry.FieldByName('CurrencySymbol').AsString;
  finally
    qry.Free;
  end;
end;

class function TCurrency.GetKeyStringField: string;
begin
  result:= 'Code';
end;

class function TCurrency.GetKeyStringProperty: string;
begin
  result:= 'Code';
end;

procedure TCurrency.Load(const fIsReadonly:boolean =False);
begin
  inherited;
  fCleanBuyRate:= BuyRate;
  fCleanSellRate:= SellRate;
end;

function TCurrency.CachedSymbolForId(aCurrencyId: integer): string;
var
  x: integer;
begin
  x:= fSymbolList.IndexOfObject(TObject(aCurrencyId));
  if x >= 0 then
    result:= fSymbolList[x]
  else begin
    result:= TCurrency.CurrencySymbolForId(aCurrencyId);
    fSymbolList.AddObject(result, TObject(aCurrencyId));
  end;
end;

{ TCurrencyRateHistory }

constructor TCurrencyRateHistory.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CurrencyFateHistory';
  fSQL := 'SELECT * FROM tblcurrencyconversionhistory';
  ExportExcludeList.Add('currencyid');
end;

destructor TCurrencyRateHistory.Destroy;
begin

  inherited;
end;

function TCurrencyRateHistory.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited;
  if result then begin
    if Assigned(Owner) and (Owner is TCurrency) then begin
      self.CurrencyID:= TCurrency(Owner).ID;
      self.Code:= TCurrency(Owner).Code;
    end;
  end;
end;

function TCurrencyRateHistory.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterPost(Sender);
end;

procedure TCurrencyRateHistory.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then Exit; // we are only interested in data fields.
  if Sysutils.SameText(Sender.FieldName , 'CurrencyID') then begin
    Code:= TCurrency.IDToggle(Sender.AsInteger, Connection.Connection);
  end
  else if Sysutils.SameText(Sender.FieldName , 'Code') then begin
    CurrencyID:= TCurrency.IDToggle(Sender.AsString, Connection.Connection);
  end;
end;

function TCurrencyRateHistory.GetActive: Boolean;
begin
  result:= GetBooleanField('Active');
end;

class function TCurrencyRateHistory.GetBusObjectTablename: string;
begin
  Result := 'tblcurrencyconversionhistory';
end;

function TCurrencyRateHistory.GetBuyRate: Double;
begin
  result:= GetFloatField('BuyRate');
end;

function TCurrencyRateHistory.GetCode: string;
begin
  result:= GetStringField('Code');
end;

function TCurrencyRateHistory.GetCurrencyID: integer;
begin
  result:= GetIntegerField('CurrencyID');
end;

function TCurrencyRateHistory.GetDate: TDateTime;
begin
  result:= GetDateTimeField('Date');
end;

class function TCurrencyRateHistory.GetIDField: string;
begin
  Result := 'CurrencyHistoryID'
end;

function TCurrencyRateHistory.GetIsList: boolean;
begin
  result:= true;
end;

class function TCurrencyRateHistory.GetKeyStringField: string;
begin
  result:= 'Code';
end;

class function TCurrencyRateHistory.GetKeyStringProperty: string;
begin
  result:= '';
end;

function TCurrencyRateHistory.GetSellRate: Double;
begin
  result:= GetFloatField('SellRate');
end;

function TCurrencyRateHistory.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

procedure TCurrencyRateHistory.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Code');
  SetDateTimePropertyFromNode(node,'Date');
  SetPropertyFromNode(node,'BuyRate');
  SetPropertyFromNode(node,'SellRate');
  SetPropertyFromNode(node,'Active');
end;

procedure TCurrencyRateHistory.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TCurrencyRateHistory.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TCurrencyRateHistory.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Code',Code);
  AddXMLNode(node,'Date',Date);
  AddXMLNode(node,'BuyRate',BuyRate);
  AddXMLNode(node,'SellRate',SellRate);
  AddXMLNode(node,'Active',Code);
end;

procedure TCurrencyRateHistory.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active',Value);
end;

procedure TCurrencyRateHistory.SetBuyRate(const Value: Double);
begin
  SetFloatField('BuyRate',Value);
end;

procedure TCurrencyRateHistory.SetCode(const Value: string);
begin
  SetStringField('Code',Value);
end;

procedure TCurrencyRateHistory.SetCurrencyID(const Value: integer);
begin
  SetIntegerField('CurrencyID',Value);
end;

procedure TCurrencyRateHistory.SetDate(const Value: TDateTime);
begin
  SetDateTimeField('Date',Value);
end;

procedure TCurrencyRateHistory.SetSellRate(const Value: Double);
begin
  SetFloatField('SellRate',Value);
end;

function TCurrencyRateHistory.ValidateData: Boolean;
begin
  Resultstatus.Clear;
  Result := True;
  if CurrencyID < 1 then begin
    AddResult(false,rssWarning,0,'CurrencyID can not be blank.');
    Result := False;
    Exit;
  end
  else if Trim(Code) = '' then begin
    AddResult(false,rssWarning,0,'Currency Code can not be blank.');
    Result := False;
    Exit;
  end
  else if Active and (BuyRate <= 0) then begin
    AddResult(false,rssWarning,0,'Buy Rate must be a positive value greater than zero.');
    Result := False;
    Exit;
  end
  else if Active and (SellRate <= 0) then begin
    AddResult(false,rssWarning,0,'Sell Rate must be a positive value greater than zero.');
    Result := False;
    Exit;
  end
end;

class function TCurrencyRateHistory._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TCurrency','CurrencyObj','Code','Code');
end;

initialization
  RegisterClassOnce(TCurrency);
  RegisterClassOnce(TCurrencyRateHistory);


end.
