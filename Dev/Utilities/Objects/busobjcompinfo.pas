unit busobjcompinfo;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   15/12/06   1.00.01   bb   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf , BusObjCompLogo;


type
   TCompanyInfo = class(TMSBusObj)
   private
      Function GetCompanyname                 :String    ;
      Function GetTradingname                 :String    ;
      Function GetAddress                     :String    ;
      Function GetAddress2                    :String    ;
      Function GetAddress3                    :String    ;
      Function GetCity                        :String    ;
      Function GetState                       :String    ;
      Function GetPostcode                    :String    ;
      Function GetCountry                     :String    ;
      Function GetLocationcode                :String    ;
      Function GetContactname                 :String    ;
      Function GetFirstname                   :String    ;
      Function GetLastName                    :String    ;
      Function GetContactemail                :String    ;
      Function GetPhonenumber                 :String    ;
      Function GetCompanyCategory             :String    ;
      Function GetMobileNumber                :String    ;
      Function GetFaxnumber                   :String    ;
      Function GetAbn                         :String    ;
      Function GetPobox                       :String    ;
      Function GetPobox2                      :String    ;
      Function GetPobox3                      :String    ;
      Function GetPocity                      :String    ;
      Function GetPostate                     :String    ;
      Function GetPopostcode                  :String    ;
      Function GetPocountry                   :String    ;
      Function GetPoLocationcode              :String    ;
      Function GetEtppayertype                :Boolean   ;
      Function GetFilereference               :String    ;
      Function GetTaxsignatory                :String    ;
      Function GetLeaveloadingpercent         :Double    ;
      Function GetCompulsorysuperpercent      :Double    ;
      Function GetBsb                         :String    ;
      Function GetAccountno                   :String    ;
      Function GetFontcompanyname             :String    ;
      Function GetFontaddress                 :String    ;
      Function GetFontsuburb                  :String    ;
      Function GetFontphone                   :String    ;
      Function GetFontabn                     :String    ;
      Function GetFontdefault                 :String    ;
      Function GetSizecompanyname             :Integer   ;
      Function GetSizeaddress                 :Integer   ;
      Function GetSizesuburb                  :Integer   ;
      Function GetSizephone                   :Integer   ;
      Function GetSizeabn                     :Integer   ;
      Function GetSizedefault                 :Integer   ;
      Function GetColorcompanyname            :String    ;
      Function GetColoraddress                :String    ;
      Function GetColorsuburb                 :String    ;
      Function GetColorphone                  :String    ;
      Function GetColorabn                    :String    ;
      Function GetColordefault                :String    ;
      Function GetStylecompanyname            :String    ;
      Function GetStyleaddress                :String    ;
      Function GetStylesuburb                 :String    ;
      Function GetStylephone                  :String    ;
      Function GetStyleabn                    :String    ;
      Function GetStyledefault                :String    ;
      Function GetBankcode                    :Integer   ;
      Function GetBankbranch                  :String    ;
      Function GetApcano                      :String    ;
      Function GetWorkerscompinsurer          :Integer   ;
      Function GetEmail                       :String    ;
      Function GetUrl                         :String    ;
      Function GetUsedocumenttemplate         :Boolean   ;
      Function GetDocumenttemplatepath        :String    ;
      Function GetContact                     :String    ;
      Function GetHidecompanyname             :Boolean   ;
      Function GetHideaddress                 :Boolean   ;
      Function GetHideaddress2                :Boolean   ;
      Function GetHideaddress3                :Boolean   ;
      Function GetHidecity                    :Boolean   ;
      Function GetHidestate                   :Boolean   ;
      Function GetHidepostcode                :Boolean   ;
      Function GetHidecountry                 :Boolean   ;
      Function GetHidephonenumber             :Boolean   ;
      Function GetHidefaxnumber               :Boolean   ;
      Function GetHideabn                     :Boolean   ;
      Function GetMenucolor                   :Integer   ;
      Function GetSupplierid                  :String    ;
      Function GetDvaabn                      :String    ;
      Function GetRaploginid                  :String    ;
      Function GetRappassword                 :String    ;
      Function GetRaploginpage                :String    ;
      Function GetRAPProgramName              :String    ;
      Function GetRAPInvoiceDescription       :String    ;
      Function GetRAPProductGroup             :String    ;
      Function GetRAPContractNumber           :String    ;
      Function GetBankName                    :String    ;
      Function GetBankAccountName             :String    ;
      Function GetBankAccountID               :Integer   ;
      Function GetStripeCode                  :String    ;
      function GetIsSetupWizard               :Boolean   ;
      function GetIsUSRegionTax               :Boolean   ;

      Procedure SetCompanyname                 (Const Value :String    );
      Procedure SetTradingname                 (Const Value :String    );
      Procedure SetAddress                     (Const Value :String    );
      Procedure SetAddress2                    (Const Value :String    );
      Procedure SetAddress3                    (Const Value :String    );
      Procedure SetCity                        (Const Value :String    );
      Procedure SetState                       (Const Value :String    );
      Procedure SetPostcode                    (Const Value :String    );
      Procedure SetCountry                     (Const Value :String    );
      Procedure SetLocationcode                (Const Value :String    );
      Procedure SetContactname                 (Const Value :String    );
      Procedure SetFirstname                   (Const Value :String    );
      Procedure SetLastName                    (Const Value :String    );
      Procedure SetContactemail                (Const Value :String    );
      Procedure SetPhonenumber                 (Const Value :String    );
      Procedure SetCompanyCategory             (Const Value :String    );
      Procedure SetMobileNumber                (Const Value :String    );
      Procedure SetFaxnumber                   (Const Value :String    );
      Procedure SetAbn                         (Const Value :String    );
      Procedure SetPobox                       (Const Value :String    );
      Procedure SetPobox2                      (Const Value :String    );
      Procedure SetPobox3                      (Const Value :String    );
      Procedure SetPocity                      (Const Value :String    );
      Procedure SetPostate                     (Const Value :String    );
      Procedure SetPopostcode                  (Const Value :String    );
      Procedure SetPocountry                   (Const Value :String    );
      Procedure SetPoLocationcode              (Const Value :String    );
      Procedure SetEtppayertype                (Const Value :Boolean   );
      Procedure SetFilereference               (Const Value :String    );
      Procedure SetTaxsignatory                (Const Value :String    );
      Procedure SetLeaveloadingpercent         (Const Value :Double    );
      Procedure SetCompulsorysuperpercent      (Const Value :Double    );
      Procedure SetBsb                         (Const Value :String    );
      Procedure SetAccountno                   (Const Value :String    );
      Procedure SetFontcompanyname             (Const Value :String    );
      Procedure SetFontaddress                 (Const Value :String    );
      Procedure SetFontsuburb                  (Const Value :String    );
      Procedure SetFontphone                   (Const Value :String    );
      Procedure SetFontabn                     (Const Value :String    );
      Procedure SetFontdefault                 (Const Value :String    );
      Procedure SetSizecompanyname             (Const Value :Integer   );
      Procedure SetSizeaddress                 (Const Value :Integer   );
      Procedure SetSizesuburb                  (Const Value :Integer   );
      Procedure SetSizephone                   (Const Value :Integer   );
      Procedure SetSizeabn                     (Const Value :Integer   );
      Procedure SetSizedefault                 (Const Value :Integer   );
      Procedure SetColorcompanyname            (Const Value :String    );
      Procedure SetColoraddress                (Const Value :String    );
      Procedure SetColorsuburb                 (Const Value :String    );
      Procedure SetColorphone                  (Const Value :String    );
      Procedure SetColorabn                    (Const Value :String    );
      Procedure SetColordefault                (Const Value :String    );
      Procedure SetStylecompanyname            (Const Value :String    );
      Procedure SetStyleaddress                (Const Value :String    );
      Procedure SetStylesuburb                 (Const Value :String    );
      Procedure SetStylephone                  (Const Value :String    );
      Procedure SetStyleabn                    (Const Value :String    );
      Procedure SetStyledefault                (Const Value :String    );
      Procedure SetBankcode                    (Const Value :Integer   );
      Procedure SetBankbranch                  (Const Value :String    );
      Procedure SetApcano                      (Const Value :String    );
      Procedure SetWorkerscompinsurer          (Const Value :Integer   );
      Procedure SetEmail                       (Const Value :String    );
      Procedure SetUrl                         (Const Value :String    );
      Procedure SetUsedocumenttemplate         (Const Value :Boolean   );
      Procedure SetDocumenttemplatepath        (Const Value :String    );
      Procedure SetContact                     (Const Value :String    );
      Procedure SetHidecompanyname             (Const Value :Boolean   );
      Procedure SetHideaddress                 (Const Value :Boolean   );
      Procedure SetHideaddress2                (Const Value :Boolean   );
      Procedure SetHideaddress3                (Const Value :Boolean   );
      Procedure SetHidecity                    (Const Value :Boolean   );
      Procedure SetHidestate                   (Const Value :Boolean   );
      Procedure SetHidepostcode                (Const Value :Boolean   );
      Procedure SetHidecountry                 (Const Value :Boolean   );
      Procedure SetHidephonenumber             (Const Value :Boolean   );
      Procedure SetHidefaxnumber               (Const Value :Boolean   );
      Procedure SetHideabn                     (Const Value :Boolean   );
      Procedure SetMenucolor                   (Const Value :Integer   );
      Procedure SetSupplierid                  (Const Value :String    );
      Procedure SetDvaabn                      (Const Value :String    );
      Procedure SetRaploginid                  (Const Value :String    );
      Procedure SetRappassword                 (Const Value :String    );
      Procedure SetRaploginpage                (Const Value :String    );
      Procedure SetRAPProgramName              (Const Value :String    );
      Procedure SetRAPInvoiceDescription       (Const Value :String    );
      Procedure SetRAPProductGroup             (Const Value :String    );
      Procedure SetRAPContractNumber           (Const Value :String    );
      Procedure SetBankName                    (Const Value :String    );
      Procedure SetBankAccountName             (Const Value :String    );
      Procedure SetBankAccountID               (Const Value :Integer   );
      Procedure SetStripeCode                  (Const Value :String    );
      procedure SetIsSetupWizard               (const Value: Boolean   );
      procedure SetIsUSRegionTax               (const Value: Boolean   );

      function GetCompanyNumber: string;
      procedure SetCompanyNumber(const Value: string);
      function getSiteCode: String;
      procedure setSiteCode(const Value: String);
      function GetTrackEmails: boolean;
      procedure SetTrackEmails(const Value: boolean);
      function getCompanyAddress: String;
      function getIndustryId: integer;
      procedure SetIndustryId(const Value: integer);


   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      procedure DoFieldOnChange(Sender: TField);                           Override;
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      Property     CompanyAddress :String read getCompanyAddress;
  published
      Property CompanyName                  :String       Read getCompanyname               Write SetCompanyname           ;
      Property TradingName                  :String       Read getTradingname               Write SetTradingname           ;
      Property Address                      :String       Read getAddress                   Write SetAddress               ;
      Property Address2                     :String       Read getAddress2                  Write SetAddress2              ;
      Property Address3                     :String       Read getAddress3                  Write SetAddress3              ;
      Property City                         :String       Read getCity                      Write SetCity                  ;
      Property State                        :String       Read getState                     Write SetState                 ;
      Property Postcode                     :String       Read getPostcode                  Write SetPostcode              ;
      Property Country                      :String       Read getCountry                   Write SetCountry               ;
      Property Locationcode                 :String       Read getLocationcode              Write SetLocationcode          ;
      Property ContactName                  :String       Read getContactname               Write SetContactname           ;
      Property Firstname                    :String       Read getFirstname                 Write SetFirstname             ;
      Property LastName                     :String       Read getLastName                  Write SetLastName              ;
      Property ContactEmail                 :String       Read getContactemail              Write SetContactemail          ;
      Property PhoneNumber                  :String       Read getPhonenumber               Write SetPhonenumber           ;
      Property CompanyCategory              :String       Read getCompanyCategory           Write SetCompanyCategory       ;
      Property MobileNumber                 :String       Read getMobileNumber              Write SetMobileNumber          ;
      Property FaxNumber                    :String       Read getFaxnumber                 Write SetFaxnumber             ;
      Property Abn                          :String       Read getAbn                       Write SetAbn                   ;
      property CompanyNumber                :string       read GetCompanyNumber             write SetCompanyNumber;
      Property PoBox                        :String       Read getPobox                     Write SetPobox                 ;
      Property PoBox2                       :String       Read getPobox2                    Write SetPobox2                ;
      Property PoBox3                       :String       Read getPobox3                    Write SetPobox3                ;
      Property PoCity                       :String       Read getPocity                    Write SetPocity                ;
      Property PoState                      :String       Read getPostate                   Write SetPostate               ;
      Property PoPostcode                   :String       Read getPopostcode                Write SetPopostcode            ;
      Property PoCountry                    :String       Read getPocountry                 Write SetPocountry             ;
      Property PoLocationcode               :String       Read getPoLocationcode            Write SetPoLocationcode        ;
      Property EtpPayerType                 :Boolean      Read getEtppayertype              Write SetEtppayertype          ;
      Property FileReference                :String       Read getFilereference             Write SetFilereference         ;
      Property TaxSignatory                 :String       Read getTaxsignatory              Write SetTaxsignatory          ;
      Property LeaveLoadingPercent          :Double       Read getLeaveloadingpercent       Write SetLeaveloadingpercent   ;
      Property CompulsorySuperPercent       :Double       Read getCompulsorysuperpercent    Write SetCompulsorysuperpercent;
      Property Bsb                          :String       Read getBsb                       Write SetBsb                   ;
      Property AccountNo                    :String       Read getAccountno                 Write SetAccountno             ;
      Property FontCompanyName              :String       Read getFontcompanyname           Write SetFontcompanyname       ;
      Property FontAddress                  :String       Read getFontaddress               Write SetFontaddress           ;
      Property FontSuburb                   :String       Read getFontsuburb                Write SetFontsuburb            ;
      Property FontPhone                    :String       Read getFontphone                 Write SetFontphone             ;
      Property FontABN                      :String       Read getFontabn                   Write SetFontabn               ;
      Property FontDefault                  :String       Read getFontdefault               Write SetFontdefault           ;
      Property SizeCompanyName              :Integer      Read getSizecompanyname           Write SetSizecompanyname       ;
      Property SizeAddress                  :Integer      Read getSizeaddress               Write SetSizeaddress           ;
      Property SizeSuburb                   :Integer      Read getSizesuburb                Write SetSizesuburb            ;
      Property SizePhone                    :Integer      Read getSizephone                 Write SetSizephone             ;
      Property SizeABN                      :Integer      Read getSizeabn                   Write SetSizeabn               ;
      Property SizeDefault                  :Integer      Read getSizedefault               Write SetSizedefault           ;
      Property ColorCompanyName             :String       Read getColorcompanyname          Write SetColorcompanyname      ;
      Property ColorAddress                 :String       Read getColoraddress              Write SetColoraddress          ;
      Property ColorSuburb                  :String       Read getColorsuburb               Write SetColorsuburb           ;
      Property ColorPhone                   :String       Read getColorphone                Write SetColorphone            ;
      Property ColorABN                     :String       Read getColorabn                  Write SetColorabn              ;
      Property ColorDefault                 :String       Read getColordefault              Write SetColordefault          ;
      Property StyleCompanyName             :String       Read getStylecompanyname          Write SetStylecompanyname      ;
      Property StyleAddress                 :String       Read getStyleaddress              Write SetStyleaddress          ;
      Property StyleSuburb                  :String       Read getStylesuburb               Write SetStylesuburb           ;
      Property StylePhone                   :String       Read getStylephone                Write SetStylephone            ;
      Property StyleABN                     :String       Read getStyleabn                  Write SetStyleabn              ;
      Property StyleDefault                 :String       Read getStyledefault              Write SetStyledefault          ;
      Property BankCode                     :Integer      Read getBankcode                  Write SetBankcode              ;
      Property BankBranch                   :String       Read getBankbranch                Write SetBankbranch            ;
      Property Apcano                       :String       Read getApcano                    Write SetApcano                ;
      Property WorkersCompInsurer           :Integer      Read getWorkerscompinsurer        Write SetWorkerscompinsurer    ;
      Property Email                        :String       Read getEmail                     Write SetEmail                 ;
      Property Url                          :String       Read getUrl                       Write SetUrl                   ;
      Property UseDocumentTemplate          :Boolean      Read getUsedocumenttemplate       Write SetUsedocumenttemplate   ;
      Property DocumentTemplatePath         :String       Read getDocumenttemplatepath      Write SetDocumenttemplatepath  ;
      Property Contact                      :String       Read getContact                   Write SetContact               ;
      Property HideCompanyName              :Boolean      Read getHidecompanyname           Write SetHidecompanyname       ;
      Property HideAddress                  :Boolean      Read getHideaddress               Write SetHideaddress           ;
      Property HideAddress2                 :Boolean      Read getHideaddress2              Write SetHideaddress2          ;
      Property HideAddress3                 :Boolean      Read getHideaddress3              Write SetHideaddress3          ;
      Property HideCity                     :Boolean      Read getHidecity                  Write SetHidecity              ;
      Property HideState                    :Boolean      Read getHidestate                 Write SetHidestate             ;
      Property HidePostcode                 :Boolean      Read getHidepostcode              Write SetHidepostcode          ;
      Property Hidecountry                  :Boolean      Read getHidecountry               Write SetHidecountry           ;
      Property HidePhoneNumber              :Boolean      Read getHidephonenumber           Write SetHidephonenumber       ;
      Property HideFaxNumber                :Boolean      Read getHidefaxnumber             Write SetHidefaxnumber         ;
      Property HideABN                      :Boolean      Read getHideabn                   Write SetHideabn               ;
      Property MenuColor                    :Integer      Read getMenucolor                 Write SetMenucolor             ;
      Property SupplierId                   :String       Read getSupplierid                Write SetSupplierid            ;
      Property DvaABN                       :String       Read getDvaabn                    Write SetDvaabn                ;
      Property RapLoginId                   :String       Read getRaploginid                Write SetRaploginid            ;
      Property RapPassword                  :String       Read getRappassword               Write SetRappassword           ;
      Property LoginPage                    :String       Read getRaploginpage              Write SetRaploginpage          ;
      Property RAPProgramName               :String       Read getRAPProgramName            Write SetRAPProgramName        ;
      Property RAPInvoiceDescription        :String       Read getRAPInvoiceDescription     Write SetRAPInvoiceDescription ;
      Property RAPProductGroup              :String       Read getRAPProductGroup           Write SetRAPProductGroup       ;
      Property RAPContractNumber            :String       Read getRAPContractNumber         Write SetRAPContractNumber     ;
      Property BankName                     :String       Read getBankName                  Write SetBankName              ;
      Property BankAccountName              :String       Read getBankAccountName           Write SetBankAccountName       ;
      Property BankAccountID                :Integer      Read getBankAccountID             Write SetBankAccountID         ;
      Property StripeCode                   :String       Read getStripeCode                Write SetStripeCode            ;
      Property SiteCode                     :String       read getSiteCode                  write setSiteCode              ;
      Property IsSetUpWizard                :Boolean      Read GetIsSetupWizard             Write SetIsSetupWizard         ;
      Property IsUSRegionTax                :Boolean      Read GetIsUSRegionTax             Write SetIsUSRegionTax         ;
      property TrackEmails: boolean read GetTrackEmails write SetTrackEmails;
      property IndustryId                   : integer read getIndustryId write SetIndustryId;
   End;
  TCompanyLogo = class(TCompanyInfo)
  Private
    function GetCompanyLogo: TCompLogo;
  Public
      Constructor  Create(AOwner: TComponent);                             override;
  Published
    property CompanyLogo: TCompLogo read GetCompanyLogo;
  end;

implementation

uses
  Sysutils,CommonLib ;



{========================================================
         TCompanyInfo
========================================================}
constructor TCompanyInfo.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblcompanyinformation';
end;


destructor TCompanyInfo.Destroy;
begin
   inherited;
end;


procedure   TCompanyInfo.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetPropertyFromNode(Node,'Companyname');
    SetPropertyFromNode(Node,'Tradingname');
    SetPropertyFromNode(Node,'Address');
    SetPropertyFromNode(Node,'Address2');
    SetPropertyFromNode(Node,'Address3');
    SetPropertyFromNode(Node,'City');
    SetPropertyFromNode(Node,'State');
    SetPropertyFromNode(Node,'Postcode');
    SetPropertyFromNode(Node,'Country');
    SetPropertyFromNode(Node,'Locationcode');
    SetPropertyFromNode(Node,'Contactname');
    SetPropertyFromNode(Node,'Firstname');
    SetPropertyFromNode(Node,'LastName');
    SetPropertyFromNode(Node,'Contactemail');
    SetPropertyFromNode(Node,'Phonenumber');
    SetPropertyFromNode(Node,'CompanyCategory');
    SetPropertyFromNode(Node,'MobileNumber');
    SetPropertyFromNode(Node,'Faxnumber');
    SetPropertyFromNode(Node,'Abn');
    SetPropertyFromNode(Node,'Pobox');
    SetPropertyFromNode(Node,'Pobox2');
    SetPropertyFromNode(Node,'Pobox3');
    SetPropertyFromNode(Node,'Pocity');
    SetPropertyFromNode(Node,'Postate');
    SetPropertyFromNode(Node,'Popostcode');
    SetPropertyFromNode(Node,'Pocountry');
    SetPropertyFromNode(Node,'PoLocationcode');
    SetBooleanPropertyFromNode(Node,'Etppayertype');
    SetPropertyFromNode(Node,'Filereference');
    SetPropertyFromNode(Node,'Taxsignatory');
    SetPropertyFromNode(Node,'Leaveloadingpercent');
    SetPropertyFromNode(Node,'Compulsorysuperpercent');
    SetPropertyFromNode(Node,'Bsb');
    SetPropertyFromNode(Node,'Accountno');
    SetPropertyFromNode(Node,'Fontcompanyname');
    SetPropertyFromNode(Node,'Fontaddress');
    SetPropertyFromNode(Node,'Fontsuburb');
    SetPropertyFromNode(Node,'Fontphone');
    SetPropertyFromNode(Node,'Fontabn');
    SetPropertyFromNode(Node,'Fontdefault');
    SetPropertyFromNode(Node,'Sizecompanyname');
    SetPropertyFromNode(Node,'Sizeaddress');
    SetPropertyFromNode(Node,'Sizesuburb');
    SetPropertyFromNode(Node,'Sizephone');
    SetPropertyFromNode(Node,'Sizeabn');
    SetPropertyFromNode(Node,'Sizedefault');
    SetPropertyFromNode(Node,'Colorcompanyname');
    SetPropertyFromNode(Node,'Coloraddress');
    SetPropertyFromNode(Node,'Colorsuburb');
    SetPropertyFromNode(Node,'Colorphone');
    SetPropertyFromNode(Node,'Colorabn');
    SetPropertyFromNode(Node,'Colordefault');
    SetPropertyFromNode(Node,'Stylecompanyname');
    SetPropertyFromNode(Node,'Styleaddress');
    SetPropertyFromNode(Node,'Stylesuburb');
    SetPropertyFromNode(Node,'Stylephone');
    SetPropertyFromNode(Node,'Styleabn');
    SetPropertyFromNode(Node,'Styledefault');
    SetPropertyFromNode(Node,'Bankcode');
    SetPropertyFromNode(Node,'Bankbranch');
    SetPropertyFromNode(Node,'Apcano');
    SetPropertyFromNode(Node,'Workerscompinsurer');
    SetPropertyFromNode(Node,'Email');
    SetPropertyFromNode(Node,'Url');
    SetBooleanPropertyFromNode(Node,'Usedocumenttemplate');
    SetPropertyFromNode(Node,'Documenttemplatepath');
    SetPropertyFromNode(Node,'Contact');
    SetBooleanPropertyFromNode(Node,'Hidecompanyname');
    SetBooleanPropertyFromNode(Node,'Hideaddress');
    SetBooleanPropertyFromNode(Node,'Hideaddress2');
    SetBooleanPropertyFromNode(Node,'Hideaddress3');
    SetBooleanPropertyFromNode(Node,'Hidecity');
    SetBooleanPropertyFromNode(Node,'Hidestate');
    SetBooleanPropertyFromNode(Node,'Hidepostcode');
    SetBooleanPropertyFromNode(Node,'Hidecountry');
    SetBooleanPropertyFromNode(Node,'Hidephonenumber');
    SetBooleanPropertyFromNode(Node,'Hidefaxnumber');
    SetBooleanPropertyFromNode(Node,'Hideabn');
    SetPropertyFromNode(Node,'Menucolor');
    SetPropertyFromNode(Node,'Supplierid');
    SetPropertyFromNode(Node,'Dvaabn');
    SetPropertyFromNode(Node,'Raploginid');
    SetPropertyFromNode(Node,'Rappassword');
    SetPropertyFromNode(Node,'loginpage');
    SetPropertyFromNode(Node,'RAPProgramName');
    SetPropertyFromNode(Node,'RAPInvoiceDescription');
    SetPropertyFromNode(Node,'RAPProductGroup');
    SetPropertyFromNode(Node,'RAPContractNumber');
    SetPropertyFromNode(Node,'BankName');
    SetPropertyFromNode(Node,'BankAccountName');
    SetPropertyFromNode(Node,'BankAccountID');
    SetPropertyFromNode(Node,'StripeCode');
    SetBooleanPropertyFromNode(Node,'TrackEmails');
    SetPropertyFromNode(Node, 'IndustryId');
end;


procedure   TCompanyInfo.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Companyname' ,Companyname);
      AddXMLNode(node,'Tradingname' ,Tradingname);
      AddXMLNode(node,'Address' ,Address);
      AddXMLNode(node,'Address2' ,Address2);
      AddXMLNode(node,'Address3' ,Address3);
      AddXMLNode(node,'City' ,City);
      AddXMLNode(node,'State' ,State);
      AddXMLNode(node,'Postcode' ,Postcode);
      AddXMLNode(node,'Country' ,Country);
      AddXMLNode(node,'Locationcode' ,Locationcode);
      AddXMLNode(node,'Contactname' ,Contactname);
      AddXMLNode(node,'Firstname' ,Firstname);
      AddXMLNode(node,'LastName' ,LastName);
      AddXMLNode(node,'Contactemail' ,Contactemail);
      AddXMLNode(node,'Phonenumber' ,Phonenumber);
      AddXMLNode(node,'CompanyCategory' ,CompanyCategory);
      AddXMLNode(node,'MobileNumber' ,MobileNumber);
      AddXMLNode(node,'Faxnumber' ,Faxnumber);
      AddXMLNode(node,'Abn' ,Abn);
      AddXMLNode(node,'Pobox' ,Pobox);
      AddXMLNode(node,'Pobox2' ,Pobox2);
      AddXMLNode(node,'Pobox3' ,Pobox3);
      AddXMLNode(node,'Pocity' ,Pocity);
      AddXMLNode(node,'Postate' ,Postate);
      AddXMLNode(node,'Popostcode' ,Popostcode);
      AddXMLNode(node,'Pocountry' ,Pocountry);
      AddXMLNode(node,'PoLocationcode' ,PoLocationcode);
      AddXMLNode(node,'Etppayertype' ,Etppayertype);
      AddXMLNode(node,'Filereference' ,Filereference);
      AddXMLNode(node,'Taxsignatory' ,Taxsignatory);
      AddXMLNode(node,'Leaveloadingpercent' ,Leaveloadingpercent);
      AddXMLNode(node,'Compulsorysuperpercent' ,Compulsorysuperpercent);
      AddXMLNode(node,'Bsb' ,Bsb);
      AddXMLNode(node,'Accountno' ,Accountno);
      AddXMLNode(node,'Fontcompanyname' ,Fontcompanyname);
      AddXMLNode(node,'Fontaddress' ,Fontaddress);
      AddXMLNode(node,'Fontsuburb' ,Fontsuburb);
      AddXMLNode(node,'Fontphone' ,Fontphone);
      AddXMLNode(node,'Fontabn' ,Fontabn);
      AddXMLNode(node,'Fontdefault' ,Fontdefault);
      AddXMLNode(node,'Sizecompanyname' ,Sizecompanyname);
      AddXMLNode(node,'Sizeaddress' ,Sizeaddress);
      AddXMLNode(node,'Sizesuburb' ,Sizesuburb);
      AddXMLNode(node,'Sizephone' ,Sizephone);
      AddXMLNode(node,'Sizeabn' ,Sizeabn);
      AddXMLNode(node,'Sizedefault' ,Sizedefault);
      AddXMLNode(node,'Colorcompanyname' ,Colorcompanyname);
      AddXMLNode(node,'Coloraddress' ,Coloraddress);
      AddXMLNode(node,'Colorsuburb' ,Colorsuburb);
      AddXMLNode(node,'Colorphone' ,Colorphone);
      AddXMLNode(node,'Colorabn' ,Colorabn);
      AddXMLNode(node,'Colordefault' ,Colordefault);
      AddXMLNode(node,'Stylecompanyname' ,Stylecompanyname);
      AddXMLNode(node,'Styleaddress' ,Styleaddress);
      AddXMLNode(node,'Stylesuburb' ,Stylesuburb);
      AddXMLNode(node,'Stylephone' ,Stylephone);
      AddXMLNode(node,'Styleabn' ,Styleabn);
      AddXMLNode(node,'Styledefault' ,Styledefault);
      AddXMLNode(node,'Bankcode' ,Bankcode);
      AddXMLNode(node,'Bankbranch' ,Bankbranch);
      AddXMLNode(node,'Apcano' ,Apcano);
      AddXMLNode(node,'Workerscompinsurer' ,Workerscompinsurer);
      AddXMLNode(node,'Email' ,Email);
      AddXMLNode(node,'Url' ,Url);
      AddXMLNode(node,'Usedocumenttemplate' ,Usedocumenttemplate);
      AddXMLNode(node,'Documenttemplatepath' ,Documenttemplatepath);
      AddXMLNode(node,'Contact' ,Contact);
      AddXMLNode(node,'Hidecompanyname' ,Hidecompanyname);
      AddXMLNode(node,'Hideaddress' ,Hideaddress);
      AddXMLNode(node,'Hideaddress2' ,Hideaddress2);
      AddXMLNode(node,'Hideaddress3' ,Hideaddress3);
      AddXMLNode(node,'Hidecity' ,Hidecity);
      AddXMLNode(node,'Hidestate' ,Hidestate);
      AddXMLNode(node,'Hidepostcode' ,Hidepostcode);
      AddXMLNode(node,'Hidecountry' ,Hidecountry);
      AddXMLNode(node,'Hidephonenumber' ,Hidephonenumber);
      AddXMLNode(node,'Hidefaxnumber' ,Hidefaxnumber);
      AddXMLNode(node,'Hideabn' ,Hideabn);
      AddXMLNode(node,'Menucolor' ,Menucolor);
      AddXMLNode(node,'Supplierid' ,Supplierid);
      AddXMLNode(node,'Dvaabn' ,Dvaabn);
      AddXMLNode(node,'Raploginid' ,Raploginid);
      AddXMLNode(node,'Rappassword' ,Rappassword);
      AddXMLNode(node,'loginpage' ,loginpage);
      AddXMLNode(node,'RAPProgramName' ,RAPProgramName);
      AddXMLNode(node,'RAPInvoiceDescription' ,RAPInvoiceDescription);
      AddXMLNode(node,'RAPProductGroup' ,RAPProductGroup);
      AddXMLNode(node,'RAPContractNumber' ,RAPContractNumber);
      AddXMLNode(node,'BankName' ,BankName);
      AddXMLNode(node,'BankAccountName' ,BankAccountName);
      AddXMLNode(node,'BankAccountID' ,BankAccountID);
      AddXMLNode(node,'StripeCode' ,StripeCode);
      AddXMLNode(node,'TrackEmails' ,TrackEmails);
      AddXMLNode(node, 'IndustryId', IndustryId);
end;


function    TCompanyInfo.ValidateData :Boolean ;
begin
   Resultstatus.Clear;
   Result := true;
end;


function    TCompanyInfo.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TCompanyInfo.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TCompanyInfo.DoFieldOnChange(Sender: TField);
begin
   inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'Firstname') or Sysutils.SameText(Sender.FieldName, 'Lastname') then begin
    contact := firstname +' ' +Lastname;
  end;

end;


Function TCompanyInfo.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TCompanyInfo.GetIDField : String;
begin
   Result := 'Setupid'
end;

function TCompanyInfo.getIndustryId: integer;
begin
  Result := GetIntegerField('IndustryId');
end;

class function TCompanyInfo.GetBusObjectTablename: string;
begin
  Result := 'tblcompanyinformation';
end;

Function  TCompanyInfo.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;

{Property functions}
Function  TCompanyInfo.GetCompanyname           :String    ; begin Result := GetStringField('Companyname');End;
function TCompanyInfo.GetTrackEmails: boolean;
begin
  result := GetBooleanField('TrackEmails');
end;

Function  TCompanyInfo.GetTradingname           :String    ; begin Result := GetStringField('Tradingname');End;
Function  TCompanyInfo.GetAddress               :String    ; begin Result := GetStringField('Address');End;
Function  TCompanyInfo.GetAddress2              :String    ; begin Result := GetStringField('Address2');End;
Function  TCompanyInfo.GetAddress3              :String    ; begin Result := GetStringField('Address3');End;
Function  TCompanyInfo.GetCity                  :String    ; begin Result := GetStringField('City');End;
Function  TCompanyInfo.GetState                 :String    ; begin Result := GetStringField('State');End;
Function  TCompanyInfo.GetPostcode              :String    ; begin Result := GetStringField('Postcode');End;
Function  TCompanyInfo.GetCountry               :String    ; begin Result := GetStringField('Country');End;
Function  TCompanyInfo.GetLocationcode          :String    ; begin Result := GetStringField('Locationcode');End;
Function  TCompanyInfo.GetContactname           :String    ; begin Result := GetStringField('Contactname');End;
Function  TCompanyInfo.GetFirstname             :String    ; begin Result := GetStringField('Firstname');End;
Function  TCompanyInfo.GetLastName              :String    ; begin Result := GetStringField('LastName');End;
Function  TCompanyInfo.GetContactemail          :String    ; begin Result := GetStringField('Contactemail');End;
Function  TCompanyInfo.GetPhonenumber           :String    ; begin Result := GetStringField('Phonenumber');End;
Function  TCompanyInfo.GetCompanyCategory       :String    ; begin Result := GetStringField('CompanyCategory');End;
Function  TCompanyInfo.GetMobileNumber          :String    ; begin Result := GetStringField('MobileNumber');End;
Function  TCompanyInfo.GetFaxnumber             :String    ; begin Result := GetStringField('Faxnumber');End;
Function  TCompanyInfo.GetAbn                   :String    ; begin Result := GetStringField('Abn');End;
Function  TCompanyInfo.GetPobox                 :String    ; begin Result := GetStringField('Pobox');End;
Function  TCompanyInfo.GetPobox2                :String    ; begin Result := GetStringField('Pobox2');End;
Function  TCompanyInfo.GetPobox3                :String    ; begin Result := GetStringField('Pobox3');End;
Function  TCompanyInfo.GetPocity                :String    ; begin Result := GetStringField('Pocity');End;
Function  TCompanyInfo.GetPostate               :String    ; begin Result := GetStringField('Postate');End;
Function  TCompanyInfo.GetPopostcode            :String    ; begin Result := GetStringField('Popostcode');End;
Function  TCompanyInfo.GetPocountry             :String    ; begin Result := GetStringField('Pocountry');End;
Function  TCompanyInfo.GetPoLocationcode        :String    ; begin Result := GetStringField('PoLocationcode');End;
Function  TCompanyInfo.GetEtppayertype          :Boolean   ; begin Result := GetBooleanField('Etppayertype');End;
Function  TCompanyInfo.GetFilereference         :String    ; begin Result := GetStringField('Filereference');End;
Function  TCompanyInfo.GetTaxsignatory          :String    ; begin Result := GetStringField('Taxsignatory');End;
Function  TCompanyInfo.GetLeaveloadingpercent   :Double    ; begin Result := GetFloatField('Leaveloadingpercent');End;
Function  TCompanyInfo.GetCompulsorysuperpercent:Double    ; begin Result := GetFloatField('Compulsorysuperpercent');End;
Function  TCompanyInfo.GetBsb                   :String    ; begin Result := GetStringField('Bsb');End;
Function  TCompanyInfo.GetAccountno             :String    ; begin Result := GetStringField('Accountno');End;
Function  TCompanyInfo.GetFontcompanyname       :String    ; begin Result := GetStringField('Fontcompanyname');End;
Function  TCompanyInfo.GetFontaddress           :String    ; begin Result := GetStringField('Fontaddress');End;
Function  TCompanyInfo.GetFontsuburb            :String    ; begin Result := GetStringField('Fontsuburb');End;
Function  TCompanyInfo.GetFontphone             :String    ; begin Result := GetStringField('Fontphone');End;
Function  TCompanyInfo.GetFontabn               :String    ; begin Result := GetStringField('Fontabn');End;
Function  TCompanyInfo.GetFontdefault           :String    ; begin Result := GetStringField('Fontdefault');End;
Function  TCompanyInfo.GetSizecompanyname       :Integer   ; begin Result := GetIntegerField('Sizecompanyname');End;
Function  TCompanyInfo.GetSizeaddress           :Integer   ; begin Result := GetIntegerField('Sizeaddress');End;
Function  TCompanyInfo.GetSizesuburb            :Integer   ; begin Result := GetIntegerField('Sizesuburb');End;
Function  TCompanyInfo.GetSizephone             :Integer   ; begin Result := GetIntegerField('Sizephone');End;
Function  TCompanyInfo.GetSizeabn               :Integer   ; begin Result := GetIntegerField('Sizeabn');End;
Function  TCompanyInfo.GetSizedefault           :Integer   ; begin Result := GetIntegerField('Sizedefault');End;
Function  TCompanyInfo.GetColorcompanyname      :String    ; begin Result := GetStringField('Colorcompanyname');End;
Function  TCompanyInfo.GetColoraddress          :String    ; begin Result := GetStringField('Coloraddress');End;
Function  TCompanyInfo.GetColorsuburb           :String    ; begin Result := GetStringField('Colorsuburb');End;
function TCompanyInfo.getCompanyAddress: String;
begin
  Result := CompanyName;
  if Address  <> '' then Result := Result + Chr(13) + Chr(10) + Address;
  if Address2 <> '' then Result := Result + Chr(13) + Chr(10) + Address2;
  if Address3 <> '' then Result := Result + Chr(13) + Chr(10) + Address3;
  if (City <> '') or (State <> '') then  begin
    Result := Result + Chr(13) + Chr(10);
    if (City <> '') and (State <> '') then Result := Result + City + ' ' + State
    else if City = '' then Result := Result + State
    else Result := Result + City;
  end;
  if Postcode <> '' then Result := Result + ' ' + Postcode;
end;

Function  TCompanyInfo.GetColorphone            :String    ; begin Result := GetStringField('Colorphone');End;
Function  TCompanyInfo.GetColorabn              :String    ; begin Result := GetStringField('Colorabn');End;
Function  TCompanyInfo.GetColordefault          :String    ; begin Result := GetStringField('Colordefault');End;
Function  TCompanyInfo.GetStylecompanyname      :String    ; begin Result := GetStringField('Stylecompanyname');End;
Function  TCompanyInfo.GetStyleaddress          :String    ; begin Result := GetStringField('Styleaddress');End;
Function  TCompanyInfo.GetStylesuburb           :String    ; begin Result := GetStringField('Stylesuburb');End;
Function  TCompanyInfo.GetStylephone            :String    ; begin Result := GetStringField('Stylephone');End;
Function  TCompanyInfo.GetStyleabn              :String    ; begin Result := GetStringField('Styleabn');End;
Function  TCompanyInfo.GetStyledefault          :String    ; begin Result := GetStringField('Styledefault');End;
Function  TCompanyInfo.GetBankcode              :Integer   ; begin Result := GetIntegerField('Bankcode');End;
Function  TCompanyInfo.GetBankbranch            :String    ; begin Result := GetStringField('Bankbranch');End;
Function  TCompanyInfo.GetApcano                :String    ; begin Result := GetStringField('Apcano');End;
Function  TCompanyInfo.GetWorkerscompinsurer    :Integer   ; begin Result := GetIntegerField('Workerscompinsurer');End;
Function  TCompanyInfo.GetEmail                 :String    ; begin Result := GetStringField('Email');End;
Function  TCompanyInfo.GetUrl                   :String    ; begin Result := GetStringField('Url');End;
Function  TCompanyInfo.GetUsedocumenttemplate   :Boolean   ; begin Result := GetBooleanField('Usedocumenttemplate');End;
Function  TCompanyInfo.GetDocumenttemplatepath  :String    ; begin Result := GetStringField('Documenttemplatepath');End;
Function  TCompanyInfo.GetContact               :String    ; begin Result := GetStringField('Contact');End;
Function  TCompanyInfo.GetHidecompanyname       :Boolean   ; begin Result := GetBooleanField('Hidecompanyname');End;
Function  TCompanyInfo.GetHideaddress           :Boolean   ; begin Result := GetBooleanField('Hideaddress');End;
Function  TCompanyInfo.GetHideaddress2          :Boolean   ; begin Result := GetBooleanField('Hideaddress2');End;
Function  TCompanyInfo.GetHideaddress3          :Boolean   ; begin Result := GetBooleanField('Hideaddress3');End;
Function  TCompanyInfo.GetHidecity              :Boolean   ; begin Result := GetBooleanField('Hidecity');End;
Function  TCompanyInfo.GetHidestate             :Boolean   ; begin Result := GetBooleanField('Hidestate');End;
Function  TCompanyInfo.GetHidepostcode          :Boolean   ; begin Result := GetBooleanField('Hidepostcode');End;
Function  TCompanyInfo.GetHidecountry           :Boolean   ; begin Result := GetBooleanField('Hidecountry');End;
Function  TCompanyInfo.GetHidephonenumber       :Boolean   ; begin Result := GetBooleanField('Hidephonenumber');End;
Function  TCompanyInfo.GetHidefaxnumber         :Boolean   ; begin Result := GetBooleanField('Hidefaxnumber');End;
Function  TCompanyInfo.GetHideabn               :Boolean   ; begin Result := GetBooleanField('Hideabn');End;
Function  TCompanyInfo.GetMenucolor             :Integer   ; begin Result := GetIntegerField('Menucolor');End;
Function  TCompanyInfo.GetSupplierid            :String    ; begin Result := GetStringField('Supplierid');End;
Function  TCompanyInfo.GetDvaabn                :String    ; begin Result := GetStringField('Dvaabn');End;
Function  TCompanyInfo.GetRaploginid            :String    ; begin Result := GetStringField('Raploginid');End;
Function  TCompanyInfo.GetRappassword           :String    ; begin Result := GetStringField('Rappassword');End;
Function  TCompanyInfo.GetRaploginpage          :String    ; begin Result := GetStringField('Raploginpage');End;
Function  TCompanyInfo.GetRapProgramName        :String    ; begin Result := GetStringField('RAPProgramName');End;
function  TCompanyInfo.getSiteCode              :String    ; begin REsult := getStringfield('SiteCode');end;
Function  TCompanyInfo.GetRAPInvoiceDescription :String    ; begin Result := GetStringField('RAPInvoiceDescription');End;
Function  TCompanyInfo.GetRAPProductGroup       :String    ; begin Result := GetStringField('RAPProductGroup');End;
Function  TCompanyInfo.GetRAPContractNumber     :String    ; begin Result := GetStringField('RAPContractNumber');End;
Function  TCompanyInfo.GetBankAccountName       :String    ; begin Result := GetStringField('BankAccountName');End;
Function  TCompanyInfo.GetBankName              :String    ; begin Result := GetStringField('BankName');End;
Function  TCompanyInfo.GetBankAccountID         :Integer   ; begin Result := GetIntegerField('BankAccountID');End;
Function  TCompanyInfo.GetStripeCode            :String    ; begin Result := GetStringField('StripeCode');End;
Function  TCompanyInfo.GetIsSetupWizard         :Boolean   ; begin Result := GetBooleanField('IsSetupWizard');End;
Function  TCompanyInfo.GetIsUSRegionTax         :Boolean   ; begin Result := GetBooleanField('IsUSRegionTax');End;

function  TCompanyInfo.GetCompanyNumber         :string    ; begin result := GetStringField('CompanyNumber'); end;
Procedure TCompanyInfo.SetCompanyname           (Const Value :String    ); begin SetStringField('Companyname'            , Value);End;
procedure TCompanyInfo.SetTrackEmails           (const Value: boolean   ); begin   SetBooleanField('TrackEmails',Value);end;
Procedure TCompanyInfo.SetTradingname           (Const Value :String    ); begin SetStringField('Tradingname'            , Value);End;
Procedure TCompanyInfo.SetAddress               (Const Value :String    ); begin SetStringField('Address'                , Value);End;
Procedure TCompanyInfo.SetAddress2              (Const Value :String    ); begin SetStringField('Address2'               , Value);End;
Procedure TCompanyInfo.SetAddress3              (Const Value :String    ); begin SetStringField('Address3'               , Value);End;
Procedure TCompanyInfo.SetCity                  (Const Value :String    ); begin SetStringField('City'                   , Value);End;
Procedure TCompanyInfo.SetState                 (Const Value :String    ); begin SetStringField('State'                  , Value);End;
Procedure TCompanyInfo.SetPostcode              (Const Value :String    ); begin SetStringField('Postcode'               , Value);End;
Procedure TCompanyInfo.SetCountry               (Const Value :String    ); begin SetStringField('Country'                , Value);End;
Procedure TCompanyInfo.SetLocationcode          (Const Value :String    ); begin SetStringField('Locationcode'           , Value);End;
Procedure TCompanyInfo.SetContactname           (Const Value :String    ); begin SetStringField('Contactname'            , Value);End;
Procedure TCompanyInfo.SetFirstname             (Const Value :String    ); begin SetStringField('Firstname'              , Value);End;
Procedure TCompanyInfo.SetLastName              (Const Value :String    ); begin SetStringField('LastName'               , Value);End;
Procedure TCompanyInfo.SetContactemail          (Const Value :String    ); begin SetStringField('Contactemail'           , Value);End;
Procedure TCompanyInfo.SetPhonenumber           (Const Value :String    ); begin SetStringField('Phonenumber'            , Value);End;
Procedure TCompanyInfo.SetCompanyCategory       (Const Value :String    ); begin SetStringField('CompanyCategory'        , Value);End;
Procedure TCompanyInfo.SetMobileNumber          (Const Value :String    ); begin SetStringField('MobileNumber'           , Value);End;
Procedure TCompanyInfo.SetFaxnumber             (Const Value :String    ); begin SetStringField('Faxnumber'              , Value);End;
Procedure TCompanyInfo.SetAbn                   (Const Value :String    ); begin SetStringField('Abn'                    , Value);End;
Procedure TCompanyInfo.SetPobox                 (Const Value :String    ); begin SetStringField('Pobox'                  , Value);End;
Procedure TCompanyInfo.SetPobox2                (Const Value :String    ); begin SetStringField('Pobox2'                 , Value);End;
Procedure TCompanyInfo.SetPobox3                (Const Value :String    ); begin SetStringField('Pobox3'                 , Value);End;
Procedure TCompanyInfo.SetPocity                (Const Value :String    ); begin SetStringField('Pocity'                 , Value);End;
Procedure TCompanyInfo.SetPostate               (Const Value :String    ); begin SetStringField('Postate'                , Value);End;
Procedure TCompanyInfo.SetPopostcode            (Const Value :String    ); begin SetStringField('Popostcode'             , Value);End;
Procedure TCompanyInfo.SetPocountry             (Const Value :String    ); begin SetStringField('Pocountry'              , Value);End;
Procedure TCompanyInfo.SetPoLocationcode        (Const Value :String    ); begin SetStringField('PoLocationcode'         , Value);End;
Procedure TCompanyInfo.SetEtppayertype          (Const Value :Boolean   ); begin SetBooleanField('Etppayertype'           , Value);End;
Procedure TCompanyInfo.SetFilereference         (Const Value :String    ); begin SetStringField('Filereference'          , Value);End;
Procedure TCompanyInfo.SetTaxsignatory          (Const Value :String    ); begin SetStringField('Taxsignatory'           , Value);End;
Procedure TCompanyInfo.SetLeaveloadingpercent   (Const Value :Double    ); begin SetFloatField('Leaveloadingpercent'    , Value);End;
Procedure TCompanyInfo.SetCompulsorysuperpercent(Const Value :Double    ); begin SetFloatField('Leaveloadingpercent'    , Value);End;
Procedure TCompanyInfo.SetBsb                   (Const Value :String    ); begin SetStringField('Bsb'                    , Value);End;
Procedure TCompanyInfo.SetAccountno             (Const Value :String    ); begin SetStringField('Accountno'              , Value);End;
Procedure TCompanyInfo.SetFontcompanyname       (Const Value :String    ); begin SetStringField('Fontcompanyname'        , Value);End;
Procedure TCompanyInfo.SetFontaddress           (Const Value :String    ); begin SetStringField('Fontaddress'            , Value);End;
Procedure TCompanyInfo.SetFontsuburb            (Const Value :String    ); begin SetStringField('Fontsuburb'             , Value);End;
Procedure TCompanyInfo.SetFontphone             (Const Value :String    ); begin SetStringField('Fontphone'              , Value);End;
Procedure TCompanyInfo.SetFontabn               (Const Value :String    ); begin SetStringField('Fontabn'                , Value);End;
Procedure TCompanyInfo.SetFontdefault           (Const Value :String    ); begin SetStringField('Fontdefault'            , Value);End;
Procedure TCompanyInfo.SetSizecompanyname       (Const Value :Integer   ); begin SetIntegerField('Sizecompanyname'        , Value);End;
Procedure TCompanyInfo.SetSizeaddress           (Const Value :Integer   ); begin SetIntegerField('Sizeaddress'            , Value);End;
Procedure TCompanyInfo.SetSizesuburb            (Const Value :Integer   ); begin SetIntegerField('Sizesuburb'             , Value);End;
Procedure TCompanyInfo.SetSizephone             (Const Value :Integer   ); begin SetIntegerField('Sizephone'              , Value);End;
Procedure TCompanyInfo.SetSizeabn               (Const Value :Integer   ); begin SetIntegerField('Sizeabn'                , Value);End;
Procedure TCompanyInfo.SetSizedefault           (Const Value :Integer   ); begin SetIntegerField('Sizedefault'            , Value);End;
Procedure TCompanyInfo.SetColorcompanyname      (Const Value :String    ); begin SetStringField('Colorcompanyname'       , Value);End;
Procedure TCompanyInfo.SetColoraddress          (Const Value :String    ); begin SetStringField('Coloraddress'           , Value);End;
Procedure TCompanyInfo.SetColorsuburb           (Const Value :String    ); begin SetStringField('Colorsuburb'            , Value);End;
Procedure TCompanyInfo.SetColorphone            (Const Value :String    ); begin SetStringField('Colorphone'             , Value);End;
Procedure TCompanyInfo.SetColorabn              (Const Value :String    ); begin SetStringField('Colorabn'               , Value);End;
Procedure TCompanyInfo.SetColordefault          (Const Value :String    ); begin SetStringField('Colordefault'           , Value);End;
Procedure TCompanyInfo.SetStylecompanyname      (Const Value :String    ); begin SetStringField('Stylecompanyname'       , Value);End;
Procedure TCompanyInfo.SetStyleaddress          (Const Value :String    ); begin SetStringField('Styleaddress'           , Value);End;
Procedure TCompanyInfo.SetStylesuburb           (Const Value :String    ); begin SetStringField('Stylesuburb'            , Value);End;
Procedure TCompanyInfo.SetStylephone            (Const Value :String    ); begin SetStringField('Stylephone'             , Value);End;
Procedure TCompanyInfo.SetStyleabn              (Const Value :String    ); begin SetStringField('Styleabn'               , Value);End;
Procedure TCompanyInfo.SetStyledefault          (Const Value :String    ); begin SetStringField('Styledefault'           , Value);End;
Procedure TCompanyInfo.SetBankcode              (Const Value :Integer   ); begin SetIntegerField('Bankcode'               , Value);End;
Procedure TCompanyInfo.SetBankbranch            (Const Value :String    ); begin SetStringField('Bankbranch'             , Value);End;
Procedure TCompanyInfo.SetApcano                (Const Value :String    ); begin SetStringField('Apcano'                 , Value);End;
Procedure TCompanyInfo.SetWorkerscompinsurer    (Const Value :Integer   ); begin SetIntegerField('Workerscompinsurer'     , Value);End;
Procedure TCompanyInfo.SetEmail                 (Const Value :String    ); begin SetStringField('Email'                  , Value);End;
Procedure TCompanyInfo.SetUrl                   (Const Value :String    ); begin SetStringField('Url'                    , Value);End;
Procedure TCompanyInfo.SetUsedocumenttemplate   (Const Value :Boolean   ); begin SetBooleanField('Usedocumenttemplate'    , Value);End;
Procedure TCompanyInfo.SetDocumenttemplatepath  (Const Value :String    ); begin SetStringField('Documenttemplatepath'   , Value);End;
Procedure TCompanyInfo.SetContact               (Const Value :String    ); begin SetStringField('Contact'                , Value);End;
Procedure TCompanyInfo.SetHidecompanyname       (Const Value :Boolean   ); begin SetBooleanField('Hidecompanyname'        , Value);End;
Procedure TCompanyInfo.SetHideaddress           (Const Value :Boolean   ); begin SetBooleanField('Hideaddress'            , Value);End;
Procedure TCompanyInfo.SetHideaddress2          (Const Value :Boolean   ); begin SetBooleanField('Hideaddress2'           , Value);End;
Procedure TCompanyInfo.SetHideaddress3          (Const Value :Boolean   ); begin SetBooleanField('Hideaddress3'           , Value);End;
Procedure TCompanyInfo.SetHidecity              (Const Value :Boolean   ); begin SetBooleanField('Hidecity'               , Value);End;
Procedure TCompanyInfo.SetHidestate             (Const Value :Boolean   ); begin SetBooleanField('Hidestate'              , Value);End;
procedure TCompanyInfo.SetIndustryId            (const Value :integer   ); begin SetIntegerField('IndustryId'             , Value);End;
Procedure TCompanyInfo.SetHidepostcode          (Const Value :Boolean   ); begin SetBooleanField('Hidepostcode'           , Value);End;
Procedure TCompanyInfo.SetHidecountry           (Const Value :Boolean   ); begin SetBooleanField('Hidecountry'            , Value);End;
Procedure TCompanyInfo.SetHidephonenumber       (Const Value :Boolean   ); begin SetBooleanField('Hidephonenumber'        , Value);End;
Procedure TCompanyInfo.SetHidefaxnumber         (Const Value :Boolean   ); begin SetBooleanField('Hidefaxnumber'          , Value);End;
Procedure TCompanyInfo.SetHideabn               (Const Value :Boolean   ); begin SetBooleanField('Hideabn'                , Value);End;
Procedure TCompanyInfo.SetMenucolor             (Const Value :Integer   ); begin SetIntegerField('Menucolor'              , Value);End;
Procedure TCompanyInfo.SetSupplierid            (Const Value :String    ); begin SetStringField('Supplierid'             , Value);End;
Procedure TCompanyInfo.SetDvaabn                (Const Value :String    ); begin SetStringField('Dvaabn'                 , Value);End;
Procedure TCompanyInfo.SetRaploginid            (Const Value :String    ); begin SetStringField('Raploginid'             , Value);End;
Procedure TCompanyInfo.SetRappassword           (Const Value :String    ); begin SetStringField('Rappassword'            , Value);End;
Procedure TCompanyInfo.SetRaploginpage          (Const Value :String    ); begin SetStringField('Raploginpage'           , Value);End;
Procedure TCompanyInfo.SetRAPProgramName        (Const Value :String    ); begin SetStringField('RAPProgramName'         , Value);End;
procedure TCompanyInfo.setSiteCode              (const Value: String    ); begin SetStringField('SiteCode'               , Value);end;
Procedure TCompanyInfo.SetRAPInvoiceDescription (Const Value :String    ); begin SetStringField('RAPInvoiceDescription'  , Value);End;
Procedure TCompanyInfo.SetRAPProductGroup       (Const Value :String    ); begin SetStringField('RAPProductGroup'        , Value);End;
Procedure TCompanyInfo.SetRAPContractNumber     (Const Value :String    ); begin SetStringField('RAPContractNumber'      , Value);End;
Procedure TCompanyInfo.SetBankName              (Const Value :String    ); begin SetStringField('BankName'               , Value);End;
Procedure TCompanyInfo.SetBankAccountName       (Const Value :String    ); begin SetStringField('BankAccountName'        , Value);End;
Procedure TCompanyInfo.SetBankAccountID         (Const Value :Integer   ); begin SetIntegerField('BankAccountID'         , Value);End;
Procedure TCompanyInfo.SetStripeCode            (Const Value :String    ); begin SetStringField('StripeCode'             , Value);End;
procedure TCompanyInfo.SetCompanyNumber         (const Value: string    ); begin SetStringField('CompanyNumber'          , Value);End;
procedure TCompanyInfo.SetIsSetupWizard         (Const Value :Boolean   ); begin SetBooleanField('IsSetupWizard'         , Value);End;
Procedure TCompanyInfo.SetIsUSRegionTax         (Const Value :Boolean   ); begin SetBooleanField('IsUSRegionTax'         , Value);End;
{ TCompanyLogo }

constructor TCompanyLogo.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
end;

function TCompanyLogo.GetCompanyLogo: TCompLogo;
begin
  Result := TCompLogo(GetcontainerComponent(TCompLogo,'SetupID = ' +  IntToStr(ID),self.SilentMode, true, True));
end;

initialization
  RegisterClassOnce(TCompanyInfo);
  RegisterClassOnce(TCompanyLogo);
end.

