unit BusobjCountries;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  07/06/10  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, MyAccess;


type
  TCountries = class(TMSBusObj)
  private
    function GetCountry      : string    ;
    function GetCurrencyDesc : string    ;
    function GetActive       : Boolean   ;
    procedure SetCountry      (const Value: string    );
    procedure SetCurrencyDesc (const Value: string    );
    procedure SetActive       (const Value: Boolean   );
    function GetCanadaPost: boolean;
    function GetCountryCode: string;
    function GetFedEx: boolean;
    function GetShortCountryCode: string;
    function GetUPS: boolean;
    function GetUSPS: boolean;
    procedure SetCanadaPost(const Value: boolean);
    procedure SetCountryCode(const Value: string);
    procedure SetFedEx(const Value: boolean);
    procedure SetShourtCountryCode(const Value: string);
    procedure SetUPS(const Value: boolean);
    procedure SetUSPS(const Value: boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function GetKeyStringField: string; override;
    class function  GetBusObjectTablename        : string;              override;
    class function DescIDToggle(aId: integer; Connection: TCustomMyConnection = nil): string; overload;
    class function DescIDToggle(aDesc: string; Connection: TCustomMyConnection = nil): integer; overload;
    class function ShortCodeForCountry(aCountry: string): string;
    class function CodeForCountry(aCountry: string): string;
    class function CountryForShortCode(aShortCode: string): string;
    class function ShortCodeForCode(aCountryCode: string): string;
    class function CountryForCode(aCode: string): string;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
  published
    property Country       :string      read GetCountry     write SetCountry  ;
    property CurrencyDesc  :string      read GetCurrencyDesc write SetCurrencyDesc  ;
    property Active        :Boolean     read GetActive      write SetActive   ;
    property CountryCode: string read GetCountryCode write SetCountryCode;
    property ShortCountryCode: string read GetShortCountryCode write SetShourtCountryCode;
    property FedEx: boolean read GetFedEx write SetFedEx;
    property UPS: boolean read GetUPS write SetUPS;
    property USPS: boolean read GetUSPS write SetUSPS;
    property CanadaPost: boolean read GetCanadaPost write SetCanadaPost;
  end;


implementation


uses tcDataUtils, CommonLib,Sysutils, ERPDbComponents, CommonDbLib,
  DbSharedObjectsObj;



  {TCountries}

class function TCountries.CodeForCountry(aCountry: string): string;
var
  qry: TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    if Qry.Active then Qry.Close;
    Qry.SQL.Text := 'select * from tblCountries where Country = ' + QuotedStr(aCountry);
    Qry.Open;
    result := qry.FieldByName('CountryCode').AsString;
  finally
    Dbsharedobj.releaseobj(Qry)
  end;
end;

class function TCountries.CountryForCode(aCode: string): string;
var
  qry: TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    if Qry.Active then Qry.Close;
    Qry.SQL.Text := 'select * from tblCountries where ShortCountryCode = ' + QuotedStr(aCode);
    Qry.Open;
    result := qry.FieldByName('Country').AsString;
    if result <> '' then exit;
    Qry.Close;
    Qry.SQL.Text := 'select * from tblCountries where CountryCode = ' + QuotedStr(aCode);
    Qry.Open;
    result := qry.FieldByName('Country').AsString;
  finally
    Dbsharedobj.releaseobj(Qry)
  end;

end;

class function TCountries.CountryForShortCode(aShortCode: string): string;
var
  qry: TERPQuery;
begin
  //qry := SharedObjs.SharedQryobj('select * from tblCountries where ShortCountryCode = ' + QuotedStr(aShortCode));
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    if Qry.Active then Qry.Close;
    Qry.SQL.Text := 'select * from tblCountries where ShortCountryCode = ' + QuotedStr(aShortCode);
    Qry.Open;
    result := qry.FieldByName('Country').AsString;
  finally
    Dbsharedobj.releaseobj(Qry)
  end;
end;

constructor TCountries.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Countries';
  fSQL := 'SELECT * FROM tblcountries';
end;


class function TCountries.DescIDToggle(aId: integer;
  Connection: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select CurrencyDesc from tblcountries');
    qry.SQL.Add('where CountryID = ' + IntToStr(aId));
    qry.Open;
    result:= qry.FieldByName('CurrencyDesc').AsString;
  finally
    qry.Free;
  end;
end;

class function TCountries.DescIDToggle(aDesc: string;
  Connection: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select CountryID from tblcountries');
    qry.SQL.Add('where CurrencyDesc = ' + QuotedStr(aDesc));
    qry.Open;
    result:= qry.FieldByName('CountryID').AsInteger;
  finally
    qry.Free;
  end;
end;

destructor TCountries.Destroy;
begin
  inherited;
end;


procedure TCountries.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Country');
  SetPropertyFromNode(node,'CurrencyDesc');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TCountries.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Country' ,Country);
  AddXMLNode(node,'CurrencyDesc' ,CurrencyDesc);
  AddXMLNode(node,'Active' ,Active);
end;


function TCountries.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  if Country = '' then begin
    ResultStatus.AddItem(False , rssWarning , 0 , 'Country Name Should Not Be Blank');
    Result := False;
    Exit;
  end;

  if not (IsUnique(ID, 'country = ' +QuotedStr(Country))) then begin
    ResultStatus.AddItem(False , rssWarning , 0 , 'Country '+Country +' Already Exists');
    Result := False;
    Exit;
  end;
  if not (IsUnique(ID, 'CurrencyDesc = ' +QuotedStr(CurrencyDesc))) then begin
    ResultStatus.AddItem(False , rssWarning , 0 , 'Currency Desc '+CurrencyDesc +' Already Exists');
    Result := False;
    Exit;
  end;

  Result := True;
end;


class function TCountries._Schema: string;
begin
  result:= inherited;
end;

function TCountries.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCountries.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TCountries.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if Sysutils.SameText(Sender.fieldname , 'country') then begin
    if not RawMode then begin
      if country <> '' then
        if CurrencyDesc = '' then
          CurrencyDesc := country;
    end;
  end;
end;


function TCountries.GetShortCountryCode: string;
begin
  result := GetStringField('ShortCountryCode');
end;

function TCountries.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TCountries.GetUPS: boolean;
begin
  result := GetBooleanField('UPS');
end;

function TCountries.GetUSPS: boolean;
begin
  result := GetBooleanField('USPS');
end;

class function TCountries.GetIDField: string;
begin
  Result := 'CountryId'
end;


class function TCountries.GetBusObjectTablename: string;
begin
  Result:= 'tblcountries';
end;


function TCountries.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function TCountries.GetCanadaPost: boolean;
begin
  result := GetBooleanField('CanadaPost');
end;

function  TCountries.GetCountry  : string    ; begin Result := GetStringField('Country');end;
function TCountries.GetCountryCode: string;
begin
  result := GetStringField('CountryCode');
end;

function  TCountries.GetCurrencyDesc  : string    ; begin Result := GetStringField('CurrencyDesc');end;
function TCountries.GetFedEx: boolean;
begin
  result := GetBooleanField('fedEx');
end;

function  TCountries.GetActive   : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TCountries.SetCanadaPost(const Value: boolean);
begin
  SetBooleanField('CanadaPost', Value);
end;

procedure TCountries.SetCountry  (const Value: string    ); begin SetStringField('Country'   , Value);end;
procedure TCountries.SetCountryCode(const Value: string);
begin
  SetStringField('CountryCode', Value);
end;

procedure TCountries.SetCurrencyDesc  (const Value: string    ); begin SetStringField('CurrencyDesc'   , Value);end;
procedure TCountries.SetFedEx(const Value: boolean);
begin
  SetBooleanField('FedEx', Value);
end;

procedure TCountries.SetShourtCountryCode(const Value: string);
begin
  SetStringField('ShortCountryCode', Value);
end;

procedure TCountries.SetUPS(const Value: boolean);
begin
  SetBooleanField('UPS', Value);
end;

procedure TCountries.SetUSPS(const Value: boolean);
begin
  SetBooleanField('USPS', Value);
end;

class function TCountries.ShortCodeForCode(aCountryCode: string): string;
var
  qry: TERPQuery;
begin
  //qry := SharedObjs.SharedQryobj('select * from tblCountries where CountryCode = ' + QuotedStr(aCountryCode));
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    if Qry.Active then Qry.Close;
    Qry.SQL.Text := 'select * from tblCountries where CountryCode = ' + QuotedStr(aCountryCode);
    Qry.Open;
    result := qry.FieldByName('ShortCountryCode').AsString;
  finally
    Dbsharedobj.releaseobj(Qry)
  end;
end;

class function TCountries.ShortCodeForCountry(aCountry: string): string;
var
  qry: TERPQuery;
begin
  if Length(aCountry) = 2 then begin
    result := aCountry;
    exit;
  end;
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    if Qry.Active then Qry.Close;
    Qry.SQL.Text := 'select * from tblCountries where Country = ' + QuotedStr(aCountry) +
      ' OR countrycode = ' + QuotedStr(aCountry);
    Qry.Open;
  result := qry.FieldByName('ShortCountryCode').AsString;
  finally
    Dbsharedobj.releaseobj(Qry)
  end;
end;

procedure TCountries.SetActive   (const Value: Boolean   ); begin SetBooleanField('Active'    , Value);end;


class function TCountries.GetKeyStringField: string;
begin
  result:= 'Country';
end;

class function TCountries.GetKeyStringProperty: string;
begin
  result:= 'Country';
end;

initialization
  RegisterClass(TCountries);


end.

