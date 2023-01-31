unit eBay_Orders_ShippingAddress;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes,  eBayBaseObj ;


type
  Tebay_orders_shippingaddress = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetName_                                       : string    ;
    function GetStreet                                      : string    ;
    function GetStreet1                                     : string    ;
    function GetStreet2                                     : string    ;
    function GetCityName                                    : string    ;
    function GetCounty                                      : string    ;
    function GetStateOrProvince                             : string    ;
    function GetCountry                                     : string    ;
    function GetCountryName                                 : string    ;
    function GetPhone                                       : string    ;
    function GetPhoneCountryCode                            : string    ;
    function GetPhoneCountryPrefix                          : string    ;
    function GetPhoneAreaOrCityCode                         : string    ;
    function GetPhoneLocalNumber                            : string    ;
    function GetPhone2CountryCode                           : string    ;
    function GetPhone2CountryPrefix                         : string    ;
    function GetPhone2AreaOrCityCode                        : string    ;
    function GetPhone2LocalNumber                           : string    ;
    function GetPostalCode                                  : string    ;
    function GetAddressID                                   : string    ;
    function GetAddressOwner                                : string    ;
    function GetAddressStatus                               : string    ;
    function GetExternalAddressID                           : string    ;
    function GetInternationalName                           : string    ;
    function GetInternationalStateAndCity                   : string    ;
    function GetInternationalStreet                         : string    ;
    function GetCompanyName                                 : string    ;
    function GetAddressRecordType                           : string    ;
    function GetFirstName                                   : string    ;
    function GetLastName                                    : string    ;
    function GetPhone2                                      : string    ;
    function GetAddressUsage                                : string    ;
    function GetReferenceID                                 : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetName_                                       (const Value: string    );
    procedure SetStreet                                      (const Value: string    );
    procedure SetStreet1                                     (const Value: string    );
    procedure SetStreet2                                     (const Value: string    );
    procedure SetCityName                                    (const Value: string    );
    procedure SetCounty                                      (const Value: string    );
    procedure SetStateOrProvince                             (const Value: string    );
    procedure SetCountry                                     (const Value: string    );
    procedure SetCountryName                                 (const Value: string    );
    procedure SetPhone                                       (const Value: string    );
    procedure SetPhoneCountryCode                            (const Value: string    );
    procedure SetPhoneCountryPrefix                          (const Value: string    );
    procedure SetPhoneAreaOrCityCode                         (const Value: string    );
    procedure SetPhoneLocalNumber                            (const Value: string    );
    procedure SetPhone2CountryCode                           (const Value: string    );
    procedure SetPhone2CountryPrefix                         (const Value: string    );
    procedure SetPhone2AreaOrCityCode                        (const Value: string    );
    procedure SetPhone2LocalNumber                           (const Value: string    );
    procedure SetPostalCode                                  (const Value: string    );
    procedure SetAddressID                                   (const Value: string    );
    procedure SetAddressOwner                                (const Value: string    );
    procedure SetAddressStatus                               (const Value: string    );
    procedure SetExternalAddressID                           (const Value: string    );
    procedure SetInternationalName                           (const Value: string    );
    procedure SetInternationalStateAndCity                   (const Value: string    );
    procedure SetInternationalStreet                         (const Value: string    );
    procedure SetCompanyName                                 (const Value: string    );
    procedure SetAddressRecordType                           (const Value: string    );
    procedure SetFirstName                                   (const Value: string    );
    procedure SetLastName                                    (const Value: string    );
    procedure SetPhone2                                      (const Value: string    );
    procedure SetAddressUsage                                (const Value: string    );
    procedure SetReferenceID                                 (const Value: string    );
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Name_                                        :string      read GetName_                                      write SetName_                                   ;
    property Street                                       :string      read GetStreet                                     write SetStreet                                  ;
    property Street1                                      :string      read GetStreet1                                    write SetStreet1                                 ;
    property Street2                                      :string      read GetStreet2                                    write SetStreet2                                 ;
    property CityName                                     :string      read GetCityName                                   write SetCityName                                ;
    property County                                       :string      read GetCounty                                     write SetCounty                                  ;
    property StateOrProvince                              :string      read GetStateOrProvince                            write SetStateOrProvince                         ;
    property Country                                      :string      read GetCountry                                    write SetCountry                                 ;
    property CountryName                                  :string      read GetCountryName                                write SetCountryName                             ;
    property Phone                                        :string      read GetPhone                                      write SetPhone                                   ;
    property PhoneCountryCode                             :string      read GetPhoneCountryCode                           write SetPhoneCountryCode                        ;
    property PhoneCountryPrefix                           :string      read GetPhoneCountryPrefix                         write SetPhoneCountryPrefix                      ;
    property PhoneAreaOrCityCode                          :string      read GetPhoneAreaOrCityCode                        write SetPhoneAreaOrCityCode                     ;
    property PhoneLocalNumber                             :string      read GetPhoneLocalNumber                           write SetPhoneLocalNumber                        ;
    property Phone2CountryCode                            :string      read GetPhone2CountryCode                          write SetPhone2CountryCode                       ;
    property Phone2CountryPrefix                          :string      read GetPhone2CountryPrefix                        write SetPhone2CountryPrefix                     ;
    property Phone2AreaOrCityCode                         :string      read GetPhone2AreaOrCityCode                       write SetPhone2AreaOrCityCode                    ;
    property Phone2LocalNumber                            :string      read GetPhone2LocalNumber                          write SetPhone2LocalNumber                       ;
    property PostalCode                                   :string      read GetPostalCode                                 write SetPostalCode                              ;
    property AddressID                                    :string      read GetAddressID                                  write SetAddressID                               ;
    property AddressOwner                                 :string      read GetAddressOwner                               write SetAddressOwner                            ;
    property AddressStatus                                :string      read GetAddressStatus                              write SetAddressStatus                           ;
    property ExternalAddressID                            :string      read GetExternalAddressID                          write SetExternalAddressID                       ;
    property InternationalName                            :string      read GetInternationalName                          write SetInternationalName                       ;
    property InternationalStateAndCity                    :string      read GetInternationalStateAndCity                  write SetInternationalStateAndCity               ;
    property InternationalStreet                          :string      read GetInternationalStreet                        write SetInternationalStreet                     ;
    property CompanyName                                  :string      read GetCompanyName                                write SetCompanyName                             ;
    property AddressRecordType                            :string      read GetAddressRecordType                          write SetAddressRecordType                       ;
    property FirstName                                    :string      read GetFirstName                                  write SetFirstName                               ;
    property LastName                                     :string      read GetLastName                                   write SetLastName                                ;
    property Phone2                                       :string      read GetPhone2                                     write SetPhone2                                  ;
    property AddressUsage                                 :string      read GetAddressUsage                               write SetAddressUsage                            ;
    property ReferenceID                                  :string      read GetReferenceID                                write SetReferenceID                             ;
  end;


implementation


  {Tebay_orders_shippingaddress}

constructor Tebay_orders_shippingaddress.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename:= 'tblebay_orders_shippingaddress';
end;

{Property Functions}
function  Tebay_orders_shippingaddress.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_shippingaddress.GetName_                                   : string    ; begin Result := GetFieldValue('Name_');end;
function  Tebay_orders_shippingaddress.GetStreet                                  : string    ; begin Result := GetFieldValue('Street');end;
function  Tebay_orders_shippingaddress.GetStreet1                                 : string    ; begin Result := GetFieldValue('Street1');end;
function  Tebay_orders_shippingaddress.GetStreet2                                 : string    ; begin Result := GetFieldValue('Street2');end;
function  Tebay_orders_shippingaddress.GetCityName                                : string    ; begin Result := GetFieldValue('CityName');end;
function  Tebay_orders_shippingaddress.GetCounty                                  : string    ; begin Result := GetFieldValue('County');end;
function  Tebay_orders_shippingaddress.GetStateOrProvince                         : string    ; begin Result := GetFieldValue('StateOrProvince');end;
function  Tebay_orders_shippingaddress.GetCountry                                 : string    ; begin Result := GetFieldValue('Country');end;
function  Tebay_orders_shippingaddress.GetCountryName                             : string    ; begin Result := GetFieldValue('CountryName');end;
function  Tebay_orders_shippingaddress.GetPhone                                   : string    ; begin Result := GetFieldValue('Phone');end;
function  Tebay_orders_shippingaddress.GetPhoneCountryCode                        : string    ; begin Result := GetFieldValue('PhoneCountryCode');end;
function  Tebay_orders_shippingaddress.GetPhoneCountryPrefix                      : string    ; begin Result := GetFieldValue('PhoneCountryPrefix');end;
function  Tebay_orders_shippingaddress.GetPhoneAreaOrCityCode                     : string    ; begin Result := GetFieldValue('PhoneAreaOrCityCode');end;
function  Tebay_orders_shippingaddress.GetPhoneLocalNumber                        : string    ; begin Result := GetFieldValue('PhoneLocalNumber');end;
function  Tebay_orders_shippingaddress.GetPhone2CountryCode                       : string    ; begin Result := GetFieldValue('Phone2CountryCode');end;
function  Tebay_orders_shippingaddress.GetPhone2CountryPrefix                     : string    ; begin Result := GetFieldValue('Phone2CountryPrefix');end;
function  Tebay_orders_shippingaddress.GetPhone2AreaOrCityCode                    : string    ; begin Result := GetFieldValue('Phone2AreaOrCityCode');end;
function  Tebay_orders_shippingaddress.GetPhone2LocalNumber                       : string    ; begin Result := GetFieldValue('Phone2LocalNumber');end;
function  Tebay_orders_shippingaddress.GetPostalCode                              : string    ; begin Result := GetFieldValue('PostalCode');end;
function  Tebay_orders_shippingaddress.GetAddressID                               : string    ; begin Result := GetFieldValue('AddressID');end;
function  Tebay_orders_shippingaddress.GetAddressOwner                            : string    ; begin Result := GetFieldValue('AddressOwner');end;
function  Tebay_orders_shippingaddress.GetAddressStatus                           : string    ; begin Result := GetFieldValue('AddressStatus');end;
function  Tebay_orders_shippingaddress.GetExternalAddressID                       : string    ; begin Result := GetFieldValue('ExternalAddressID');end;
function  Tebay_orders_shippingaddress.GetInternationalName                       : string    ; begin Result := GetFieldValue('InternationalName');end;
function  Tebay_orders_shippingaddress.GetInternationalStateAndCity               : string    ; begin Result := GetFieldValue('InternationalStateAndCity');end;
function  Tebay_orders_shippingaddress.GetInternationalStreet                     : string    ; begin Result := GetFieldValue('InternationalStreet');end;
function  Tebay_orders_shippingaddress.GetCompanyName                             : string    ; begin Result := GetFieldValue('CompanyName');end;
function  Tebay_orders_shippingaddress.GetAddressRecordType                       : string    ; begin Result := GetFieldValue('AddressRecordType');end;
function  Tebay_orders_shippingaddress.GetFirstName                               : string    ; begin Result := GetFieldValue('FirstName');end;
function  Tebay_orders_shippingaddress.GetLastName                                : string    ; begin Result := GetFieldValue('LastName');end;
function  Tebay_orders_shippingaddress.GetPhone2                                  : string    ; begin Result := GetFieldValue('Phone2');end;
function  Tebay_orders_shippingaddress.GetAddressUsage                            : string    ; begin Result := GetFieldValue('AddressUsage');end;
function  Tebay_orders_shippingaddress.GetReferenceID                             : string    ; begin Result := GetFieldValue('ReferenceID');end;
procedure Tebay_orders_shippingaddress.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_shippingaddress.SetName_                                   (const Value: string    ); begin SetFieldValue('Name_'                                    , Value);end;
procedure Tebay_orders_shippingaddress.SetStreet                                  (const Value: string    ); begin SetFieldValue('Street'                                   , Value);end;
procedure Tebay_orders_shippingaddress.SetStreet1                                 (const Value: string    ); begin SetFieldValue('Street1'                                  , Value);end;
procedure Tebay_orders_shippingaddress.SetStreet2                                 (const Value: string    ); begin SetFieldValue('Street2'                                  , Value);end;
procedure Tebay_orders_shippingaddress.SetCityName                                (const Value: string    ); begin SetFieldValue('CityName'                                 , Value);end;
procedure Tebay_orders_shippingaddress.SetCounty                                  (const Value: string    ); begin SetFieldValue('County'                                   , Value);end;
procedure Tebay_orders_shippingaddress.SetStateOrProvince                         (const Value: string    ); begin SetFieldValue('StateOrProvince'                          , Value);end;
procedure Tebay_orders_shippingaddress.SetCountry                                 (const Value: string    ); begin SetFieldValue('Country'                                  , Value);end;
procedure Tebay_orders_shippingaddress.SetCountryName                             (const Value: string    ); begin SetFieldValue('CountryName'                              , Value);end;
procedure Tebay_orders_shippingaddress.SetPhone                                   (const Value: string    ); begin SetFieldValue('Phone'                                    , Value);end;
procedure Tebay_orders_shippingaddress.SetPhoneCountryCode                        (const Value: string    ); begin SetFieldValue('PhoneCountryCode'                         , Value);end;
procedure Tebay_orders_shippingaddress.SetPhoneCountryPrefix                      (const Value: string    ); begin SetFieldValue('PhoneCountryPrefix'                       , Value);end;
procedure Tebay_orders_shippingaddress.SetPhoneAreaOrCityCode                     (const Value: string    ); begin SetFieldValue('PhoneAreaOrCityCode'                      , Value);end;
procedure Tebay_orders_shippingaddress.SetPhoneLocalNumber                        (const Value: string    ); begin SetFieldValue('PhoneLocalNumber'                         , Value);end;
procedure Tebay_orders_shippingaddress.SetPhone2CountryCode                       (const Value: string    ); begin SetFieldValue('Phone2CountryCode'                        , Value);end;
procedure Tebay_orders_shippingaddress.SetPhone2CountryPrefix                     (const Value: string    ); begin SetFieldValue('Phone2CountryPrefix'                      , Value);end;
procedure Tebay_orders_shippingaddress.SetPhone2AreaOrCityCode                    (const Value: string    ); begin SetFieldValue('Phone2AreaOrCityCode'                     , Value);end;
procedure Tebay_orders_shippingaddress.SetPhone2LocalNumber                       (const Value: string    ); begin SetFieldValue('Phone2LocalNumber'                        , Value);end;
procedure Tebay_orders_shippingaddress.SetPostalCode                              (const Value: string    ); begin SetFieldValue('PostalCode'                               , Value);end;
procedure Tebay_orders_shippingaddress.SetAddressID                               (const Value: string    ); begin SetFieldValue('AddressID'                                , Value);end;
procedure Tebay_orders_shippingaddress.SetAddressOwner                            (const Value: string    ); begin SetFieldValue('AddressOwner'                             , Value);end;
procedure Tebay_orders_shippingaddress.SetAddressStatus                           (const Value: string    ); begin SetFieldValue('AddressStatus'                            , Value);end;
procedure Tebay_orders_shippingaddress.SetExternalAddressID                       (const Value: string    ); begin SetFieldValue('ExternalAddressID'                        , Value);end;
procedure Tebay_orders_shippingaddress.SetInternationalName                       (const Value: string    ); begin SetFieldValue('InternationalName'                        , Value);end;
procedure Tebay_orders_shippingaddress.SetInternationalStateAndCity               (const Value: string    ); begin SetFieldValue('InternationalStateAndCity'                , Value);end;
procedure Tebay_orders_shippingaddress.SetInternationalStreet                     (const Value: string    ); begin SetFieldValue('InternationalStreet'                      , Value);end;
procedure Tebay_orders_shippingaddress.SetCompanyName                             (const Value: string    ); begin SetFieldValue('CompanyName'                              , Value);end;
procedure Tebay_orders_shippingaddress.SetAddressRecordType                       (const Value: string    ); begin SetFieldValue('AddressRecordType'                        , Value);end;
procedure Tebay_orders_shippingaddress.SetFirstName                               (const Value: string    ); begin SetFieldValue('FirstName'                                , Value);end;
procedure Tebay_orders_shippingaddress.SetLastName                                (const Value: string    ); begin SetFieldValue('LastName'                                 , Value);end;
procedure Tebay_orders_shippingaddress.SetPhone2                                  (const Value: string    ); begin SetFieldValue('Phone2'                                   , Value);end;
procedure Tebay_orders_shippingaddress.SetAddressUsage                            (const Value: string    ); begin SetFieldValue('AddressUsage'                             , Value);end;
procedure Tebay_orders_shippingaddress.SetReferenceID                             (const Value: string    ); begin SetFieldValue('ReferenceID'                              , Value);end;


initialization
  RegisterClass(Tebay_orders_shippingaddress);


end.
