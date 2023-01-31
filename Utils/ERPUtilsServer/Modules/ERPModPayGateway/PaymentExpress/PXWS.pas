// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://sec.paymentexpress.com/WS/PXWS.asmx?WSDL
//  >Import : https://sec.paymentexpress.com/WS/PXWS.asmx?WSDL>0
// Encoding : utf-8
// Version  : 1.0
// (29/11/2017 4:53:27 PM - - $Rev: 90173 $)
// ************************************************************************ //

unit PXWS;

interface

uses
  {$IfDef VER220}
  InvokeRegistry,
  SOAPHTTPClient,
  Types,
  XSBuiltIns
  {$Else}
  Soap.InvokeRegistry,
  Soap.SOAPHTTPClient,
  System.Types,
  Soap.XSBuiltIns
  {$EndIf}
;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TransactionDetails   = class;                 { "http://PaymentExpress.com"[GblCplx] }
  NameValueField       = class;                 { "http://PaymentExpress.com"[GblCplx] }
  EnrolmentCheckRequest = class;                { "http://PaymentExpress.com"[GblCplx] }
  EnrolmentCheckResult = class;                 { "http://PaymentExpress.com"[GblCplx] }
  TransactionResult2   = class;                 { "http://PaymentExpress.com"[GblCplx] }
  riskRuleMatch        = class;                 { "http://PaymentExpress.com"[GblCplx] }

  ArrayOfNameValueField = array of NameValueField;   { "http://PaymentExpress.com"[GblCplx] }


  // ************************************************************************ //
  // XML       : TransactionDetails, global, <complexType>
  // Namespace : http://PaymentExpress.com
  // ************************************************************************ //
  TransactionDetails = class(TRemotable)
  private
    Famount: string;
    Famount_Specified: boolean;
    FbillingId: string;
    FbillingId_Specified: boolean;
    FcardHolderName: string;
    FcardHolderName_Specified: boolean;
    FcardNumber: string;
    FcardNumber_Specified: boolean;
    FclientInfo: string;
    FclientInfo_Specified: boolean;
    Fcvc2: string;
    Fcvc2_Specified: boolean;
    FdateExpiry: string;
    FdateExpiry_Specified: boolean;
    FdpsBillingId: string;
    FdpsBillingId_Specified: boolean;
    FdpsTxnRef: string;
    FdpsTxnRef_Specified: boolean;
    FenableAddBillCard: string;
    FenableAddBillCard_Specified: boolean;
    FenablePaxInfo: string;
    FenablePaxInfo_Specified: boolean;
    FinputCurrency: string;
    FinputCurrency_Specified: boolean;
    FmerchantReference: string;
    FmerchantReference_Specified: boolean;
    FpaxCarrier: string;
    FpaxCarrier_Specified: boolean;
    FpaxCarrier2: string;
    FpaxCarrier2_Specified: boolean;
    FpaxCarrier3: string;
    FpaxCarrier3_Specified: boolean;
    FpaxCarrier4: string;
    FpaxCarrier4_Specified: boolean;
    FpaxDateDepart: string;
    FpaxDateDepart_Specified: boolean;
    FpaxDate2: string;
    FpaxDate2_Specified: boolean;
    FpaxDate3: string;
    FpaxDate3_Specified: boolean;
    FpaxDate4: string;
    FpaxDate4_Specified: boolean;
    FpaxTime1: string;
    FpaxTime1_Specified: boolean;
    FpaxTime2: string;
    FpaxTime2_Specified: boolean;
    FpaxTime3: string;
    FpaxTime3_Specified: boolean;
    FpaxTime4: string;
    FpaxTime4_Specified: boolean;
    FpaxLeg1: string;
    FpaxLeg1_Specified: boolean;
    FpaxLeg2: string;
    FpaxLeg2_Specified: boolean;
    FpaxLeg3: string;
    FpaxLeg3_Specified: boolean;
    FpaxLeg4: string;
    FpaxLeg4_Specified: boolean;
    FpaxClass1: string;
    FpaxClass1_Specified: boolean;
    FpaxClass2: string;
    FpaxClass2_Specified: boolean;
    FpaxClass3: string;
    FpaxClass3_Specified: boolean;
    FpaxClass4: string;
    FpaxClass4_Specified: boolean;
    FpaxStopOverCode1: string;
    FpaxStopOverCode1_Specified: boolean;
    FpaxStopOverCode2: string;
    FpaxStopOverCode2_Specified: boolean;
    FpaxStopOverCode3: string;
    FpaxStopOverCode3_Specified: boolean;
    FpaxStopOverCode4: string;
    FpaxStopOverCode4_Specified: boolean;
    FpaxFareBasis1: string;
    FpaxFareBasis1_Specified: boolean;
    FpaxFareBasis2: string;
    FpaxFareBasis2_Specified: boolean;
    FpaxFareBasis3: string;
    FpaxFareBasis3_Specified: boolean;
    FpaxFareBasis4: string;
    FpaxFareBasis4_Specified: boolean;
    FpaxFlightNumber1: string;
    FpaxFlightNumber1_Specified: boolean;
    FpaxFlightNumber2: string;
    FpaxFlightNumber2_Specified: boolean;
    FpaxFlightNumber3: string;
    FpaxFlightNumber3_Specified: boolean;
    FpaxFlightNumber4: string;
    FpaxFlightNumber4_Specified: boolean;
    FpaxName: string;
    FpaxName_Specified: boolean;
    FpaxOrigin: string;
    FpaxOrigin_Specified: boolean;
    FpaxTicketNumber: string;
    FpaxTicketNumber_Specified: boolean;
    FpaxTravelAgentInfo: string;
    FpaxTravelAgentInfo_Specified: boolean;
    FtxnData1: string;
    FtxnData1_Specified: boolean;
    FtxnData2: string;
    FtxnData2_Specified: boolean;
    FtxnData3: string;
    FtxnData3_Specified: boolean;
    FtxnRef: string;
    FtxnRef_Specified: boolean;
    FtxnType: string;
    FtxnType_Specified: boolean;
    FdateStart: string;
    FdateStart_Specified: boolean;
    FissueNumber: string;
    FissueNumber_Specified: boolean;
    FenableAvsData: string;
    FenableAvsData_Specified: boolean;
    FavsAction: string;
    FavsAction_Specified: boolean;
    FavsPostCode: string;
    FavsPostCode_Specified: boolean;
    FavsStreetAddress: string;
    FavsStreetAddress_Specified: boolean;
    Fenable3DSecure: string;
    Fenable3DSecure_Specified: boolean;
    FpaRes: string;
    FpaRes_Specified: boolean;
    FclientType: string;
    FclientType_Specified: boolean;
    FiccData: string;
    FiccData_Specified: boolean;
    FdeviceId: string;
    FdeviceId_Specified: boolean;
    FcardNumber2: string;
    FcardNumber2_Specified: boolean;
    Ftrack2: string;
    Ftrack2_Specified: boolean;
    Fcvc2Presence: string;
    Fcvc2Presence_Specified: boolean;
    FextendedData: ArrayOfNameValueField;
    FextendedData_Specified: boolean;
    procedure Setamount(Index: Integer; const Astring: string);
    function  amount_Specified(Index: Integer): boolean;
    procedure SetbillingId(Index: Integer; const Astring: string);
    function  billingId_Specified(Index: Integer): boolean;
    procedure SetcardHolderName(Index: Integer; const Astring: string);
    function  cardHolderName_Specified(Index: Integer): boolean;
    procedure SetcardNumber(Index: Integer; const Astring: string);
    function  cardNumber_Specified(Index: Integer): boolean;
    procedure SetclientInfo(Index: Integer; const Astring: string);
    function  clientInfo_Specified(Index: Integer): boolean;
    procedure Setcvc2(Index: Integer; const Astring: string);
    function  cvc2_Specified(Index: Integer): boolean;
    procedure SetdateExpiry(Index: Integer; const Astring: string);
    function  dateExpiry_Specified(Index: Integer): boolean;
    procedure SetdpsBillingId(Index: Integer; const Astring: string);
    function  dpsBillingId_Specified(Index: Integer): boolean;
    procedure SetdpsTxnRef(Index: Integer; const Astring: string);
    function  dpsTxnRef_Specified(Index: Integer): boolean;
    procedure SetenableAddBillCard(Index: Integer; const Astring: string);
    function  enableAddBillCard_Specified(Index: Integer): boolean;
    procedure SetenablePaxInfo(Index: Integer; const Astring: string);
    function  enablePaxInfo_Specified(Index: Integer): boolean;
    procedure SetinputCurrency(Index: Integer; const Astring: string);
    function  inputCurrency_Specified(Index: Integer): boolean;
    procedure SetmerchantReference(Index: Integer; const Astring: string);
    function  merchantReference_Specified(Index: Integer): boolean;
    procedure SetpaxCarrier(Index: Integer; const Astring: string);
    function  paxCarrier_Specified(Index: Integer): boolean;
    procedure SetpaxCarrier2(Index: Integer; const Astring: string);
    function  paxCarrier2_Specified(Index: Integer): boolean;
    procedure SetpaxCarrier3(Index: Integer; const Astring: string);
    function  paxCarrier3_Specified(Index: Integer): boolean;
    procedure SetpaxCarrier4(Index: Integer; const Astring: string);
    function  paxCarrier4_Specified(Index: Integer): boolean;
    procedure SetpaxDateDepart(Index: Integer; const Astring: string);
    function  paxDateDepart_Specified(Index: Integer): boolean;
    procedure SetpaxDate2(Index: Integer; const Astring: string);
    function  paxDate2_Specified(Index: Integer): boolean;
    procedure SetpaxDate3(Index: Integer; const Astring: string);
    function  paxDate3_Specified(Index: Integer): boolean;
    procedure SetpaxDate4(Index: Integer; const Astring: string);
    function  paxDate4_Specified(Index: Integer): boolean;
    procedure SetpaxTime1(Index: Integer; const Astring: string);
    function  paxTime1_Specified(Index: Integer): boolean;
    procedure SetpaxTime2(Index: Integer; const Astring: string);
    function  paxTime2_Specified(Index: Integer): boolean;
    procedure SetpaxTime3(Index: Integer; const Astring: string);
    function  paxTime3_Specified(Index: Integer): boolean;
    procedure SetpaxTime4(Index: Integer; const Astring: string);
    function  paxTime4_Specified(Index: Integer): boolean;
    procedure SetpaxLeg1(Index: Integer; const Astring: string);
    function  paxLeg1_Specified(Index: Integer): boolean;
    procedure SetpaxLeg2(Index: Integer; const Astring: string);
    function  paxLeg2_Specified(Index: Integer): boolean;
    procedure SetpaxLeg3(Index: Integer; const Astring: string);
    function  paxLeg3_Specified(Index: Integer): boolean;
    procedure SetpaxLeg4(Index: Integer; const Astring: string);
    function  paxLeg4_Specified(Index: Integer): boolean;
    procedure SetpaxClass1(Index: Integer; const Astring: string);
    function  paxClass1_Specified(Index: Integer): boolean;
    procedure SetpaxClass2(Index: Integer; const Astring: string);
    function  paxClass2_Specified(Index: Integer): boolean;
    procedure SetpaxClass3(Index: Integer; const Astring: string);
    function  paxClass3_Specified(Index: Integer): boolean;
    procedure SetpaxClass4(Index: Integer; const Astring: string);
    function  paxClass4_Specified(Index: Integer): boolean;
    procedure SetpaxStopOverCode1(Index: Integer; const Astring: string);
    function  paxStopOverCode1_Specified(Index: Integer): boolean;
    procedure SetpaxStopOverCode2(Index: Integer; const Astring: string);
    function  paxStopOverCode2_Specified(Index: Integer): boolean;
    procedure SetpaxStopOverCode3(Index: Integer; const Astring: string);
    function  paxStopOverCode3_Specified(Index: Integer): boolean;
    procedure SetpaxStopOverCode4(Index: Integer; const Astring: string);
    function  paxStopOverCode4_Specified(Index: Integer): boolean;
    procedure SetpaxFareBasis1(Index: Integer; const Astring: string);
    function  paxFareBasis1_Specified(Index: Integer): boolean;
    procedure SetpaxFareBasis2(Index: Integer; const Astring: string);
    function  paxFareBasis2_Specified(Index: Integer): boolean;
    procedure SetpaxFareBasis3(Index: Integer; const Astring: string);
    function  paxFareBasis3_Specified(Index: Integer): boolean;
    procedure SetpaxFareBasis4(Index: Integer; const Astring: string);
    function  paxFareBasis4_Specified(Index: Integer): boolean;
    procedure SetpaxFlightNumber1(Index: Integer; const Astring: string);
    function  paxFlightNumber1_Specified(Index: Integer): boolean;
    procedure SetpaxFlightNumber2(Index: Integer; const Astring: string);
    function  paxFlightNumber2_Specified(Index: Integer): boolean;
    procedure SetpaxFlightNumber3(Index: Integer; const Astring: string);
    function  paxFlightNumber3_Specified(Index: Integer): boolean;
    procedure SetpaxFlightNumber4(Index: Integer; const Astring: string);
    function  paxFlightNumber4_Specified(Index: Integer): boolean;
    procedure SetpaxName(Index: Integer; const Astring: string);
    function  paxName_Specified(Index: Integer): boolean;
    procedure SetpaxOrigin(Index: Integer; const Astring: string);
    function  paxOrigin_Specified(Index: Integer): boolean;
    procedure SetpaxTicketNumber(Index: Integer; const Astring: string);
    function  paxTicketNumber_Specified(Index: Integer): boolean;
    procedure SetpaxTravelAgentInfo(Index: Integer; const Astring: string);
    function  paxTravelAgentInfo_Specified(Index: Integer): boolean;
    procedure SettxnData1(Index: Integer; const Astring: string);
    function  txnData1_Specified(Index: Integer): boolean;
    procedure SettxnData2(Index: Integer; const Astring: string);
    function  txnData2_Specified(Index: Integer): boolean;
    procedure SettxnData3(Index: Integer; const Astring: string);
    function  txnData3_Specified(Index: Integer): boolean;
    procedure SettxnRef(Index: Integer; const Astring: string);
    function  txnRef_Specified(Index: Integer): boolean;
    procedure SettxnType(Index: Integer; const Astring: string);
    function  txnType_Specified(Index: Integer): boolean;
    procedure SetdateStart(Index: Integer; const Astring: string);
    function  dateStart_Specified(Index: Integer): boolean;
    procedure SetissueNumber(Index: Integer; const Astring: string);
    function  issueNumber_Specified(Index: Integer): boolean;
    procedure SetenableAvsData(Index: Integer; const Astring: string);
    function  enableAvsData_Specified(Index: Integer): boolean;
    procedure SetavsAction(Index: Integer; const Astring: string);
    function  avsAction_Specified(Index: Integer): boolean;
    procedure SetavsPostCode(Index: Integer; const Astring: string);
    function  avsPostCode_Specified(Index: Integer): boolean;
    procedure SetavsStreetAddress(Index: Integer; const Astring: string);
    function  avsStreetAddress_Specified(Index: Integer): boolean;
    procedure Setenable3DSecure(Index: Integer; const Astring: string);
    function  enable3DSecure_Specified(Index: Integer): boolean;
    procedure SetpaRes(Index: Integer; const Astring: string);
    function  paRes_Specified(Index: Integer): boolean;
    procedure SetclientType(Index: Integer; const Astring: string);
    function  clientType_Specified(Index: Integer): boolean;
    procedure SeticcData(Index: Integer; const Astring: string);
    function  iccData_Specified(Index: Integer): boolean;
    procedure SetdeviceId(Index: Integer; const Astring: string);
    function  deviceId_Specified(Index: Integer): boolean;
    procedure SetcardNumber2(Index: Integer; const Astring: string);
    function  cardNumber2_Specified(Index: Integer): boolean;
    procedure Settrack2(Index: Integer; const Astring: string);
    function  track2_Specified(Index: Integer): boolean;
    procedure Setcvc2Presence(Index: Integer; const Astring: string);
    function  cvc2Presence_Specified(Index: Integer): boolean;
    procedure SetextendedData(Index: Integer; const AArrayOfNameValueField: ArrayOfNameValueField);
    function  extendedData_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property amount:             string                 Index (IS_OPTN) read Famount write Setamount stored amount_Specified;
    property billingId:          string                 Index (IS_OPTN) read FbillingId write SetbillingId stored billingId_Specified;
    property cardHolderName:     string                 Index (IS_OPTN) read FcardHolderName write SetcardHolderName stored cardHolderName_Specified;
    property cardNumber:         string                 Index (IS_OPTN) read FcardNumber write SetcardNumber stored cardNumber_Specified;
    property clientInfo:         string                 Index (IS_OPTN) read FclientInfo write SetclientInfo stored clientInfo_Specified;
    property cvc2:               string                 Index (IS_OPTN) read Fcvc2 write Setcvc2 stored cvc2_Specified;
    property dateExpiry:         string                 Index (IS_OPTN) read FdateExpiry write SetdateExpiry stored dateExpiry_Specified;
    property dpsBillingId:       string                 Index (IS_OPTN) read FdpsBillingId write SetdpsBillingId stored dpsBillingId_Specified;
    property dpsTxnRef:          string                 Index (IS_OPTN) read FdpsTxnRef write SetdpsTxnRef stored dpsTxnRef_Specified;
    property enableAddBillCard:  string                 Index (IS_OPTN) read FenableAddBillCard write SetenableAddBillCard stored enableAddBillCard_Specified;
    property enablePaxInfo:      string                 Index (IS_OPTN) read FenablePaxInfo write SetenablePaxInfo stored enablePaxInfo_Specified;
    property inputCurrency:      string                 Index (IS_OPTN) read FinputCurrency write SetinputCurrency stored inputCurrency_Specified;
    property merchantReference:  string                 Index (IS_OPTN) read FmerchantReference write SetmerchantReference stored merchantReference_Specified;
    property paxCarrier:         string                 Index (IS_OPTN) read FpaxCarrier write SetpaxCarrier stored paxCarrier_Specified;
    property paxCarrier2:        string                 Index (IS_OPTN) read FpaxCarrier2 write SetpaxCarrier2 stored paxCarrier2_Specified;
    property paxCarrier3:        string                 Index (IS_OPTN) read FpaxCarrier3 write SetpaxCarrier3 stored paxCarrier3_Specified;
    property paxCarrier4:        string                 Index (IS_OPTN) read FpaxCarrier4 write SetpaxCarrier4 stored paxCarrier4_Specified;
    property paxDateDepart:      string                 Index (IS_OPTN) read FpaxDateDepart write SetpaxDateDepart stored paxDateDepart_Specified;
    property paxDate2:           string                 Index (IS_OPTN) read FpaxDate2 write SetpaxDate2 stored paxDate2_Specified;
    property paxDate3:           string                 Index (IS_OPTN) read FpaxDate3 write SetpaxDate3 stored paxDate3_Specified;
    property paxDate4:           string                 Index (IS_OPTN) read FpaxDate4 write SetpaxDate4 stored paxDate4_Specified;
    property paxTime1:           string                 Index (IS_OPTN) read FpaxTime1 write SetpaxTime1 stored paxTime1_Specified;
    property paxTime2:           string                 Index (IS_OPTN) read FpaxTime2 write SetpaxTime2 stored paxTime2_Specified;
    property paxTime3:           string                 Index (IS_OPTN) read FpaxTime3 write SetpaxTime3 stored paxTime3_Specified;
    property paxTime4:           string                 Index (IS_OPTN) read FpaxTime4 write SetpaxTime4 stored paxTime4_Specified;
    property paxLeg1:            string                 Index (IS_OPTN) read FpaxLeg1 write SetpaxLeg1 stored paxLeg1_Specified;
    property paxLeg2:            string                 Index (IS_OPTN) read FpaxLeg2 write SetpaxLeg2 stored paxLeg2_Specified;
    property paxLeg3:            string                 Index (IS_OPTN) read FpaxLeg3 write SetpaxLeg3 stored paxLeg3_Specified;
    property paxLeg4:            string                 Index (IS_OPTN) read FpaxLeg4 write SetpaxLeg4 stored paxLeg4_Specified;
    property paxClass1:          string                 Index (IS_OPTN) read FpaxClass1 write SetpaxClass1 stored paxClass1_Specified;
    property paxClass2:          string                 Index (IS_OPTN) read FpaxClass2 write SetpaxClass2 stored paxClass2_Specified;
    property paxClass3:          string                 Index (IS_OPTN) read FpaxClass3 write SetpaxClass3 stored paxClass3_Specified;
    property paxClass4:          string                 Index (IS_OPTN) read FpaxClass4 write SetpaxClass4 stored paxClass4_Specified;
    property paxStopOverCode1:   string                 Index (IS_OPTN) read FpaxStopOverCode1 write SetpaxStopOverCode1 stored paxStopOverCode1_Specified;
    property paxStopOverCode2:   string                 Index (IS_OPTN) read FpaxStopOverCode2 write SetpaxStopOverCode2 stored paxStopOverCode2_Specified;
    property paxStopOverCode3:   string                 Index (IS_OPTN) read FpaxStopOverCode3 write SetpaxStopOverCode3 stored paxStopOverCode3_Specified;
    property paxStopOverCode4:   string                 Index (IS_OPTN) read FpaxStopOverCode4 write SetpaxStopOverCode4 stored paxStopOverCode4_Specified;
    property paxFareBasis1:      string                 Index (IS_OPTN) read FpaxFareBasis1 write SetpaxFareBasis1 stored paxFareBasis1_Specified;
    property paxFareBasis2:      string                 Index (IS_OPTN) read FpaxFareBasis2 write SetpaxFareBasis2 stored paxFareBasis2_Specified;
    property paxFareBasis3:      string                 Index (IS_OPTN) read FpaxFareBasis3 write SetpaxFareBasis3 stored paxFareBasis3_Specified;
    property paxFareBasis4:      string                 Index (IS_OPTN) read FpaxFareBasis4 write SetpaxFareBasis4 stored paxFareBasis4_Specified;
    property paxFlightNumber1:   string                 Index (IS_OPTN) read FpaxFlightNumber1 write SetpaxFlightNumber1 stored paxFlightNumber1_Specified;
    property paxFlightNumber2:   string                 Index (IS_OPTN) read FpaxFlightNumber2 write SetpaxFlightNumber2 stored paxFlightNumber2_Specified;
    property paxFlightNumber3:   string                 Index (IS_OPTN) read FpaxFlightNumber3 write SetpaxFlightNumber3 stored paxFlightNumber3_Specified;
    property paxFlightNumber4:   string                 Index (IS_OPTN) read FpaxFlightNumber4 write SetpaxFlightNumber4 stored paxFlightNumber4_Specified;
    property paxName:            string                 Index (IS_OPTN) read FpaxName write SetpaxName stored paxName_Specified;
    property paxOrigin:          string                 Index (IS_OPTN) read FpaxOrigin write SetpaxOrigin stored paxOrigin_Specified;
    property paxTicketNumber:    string                 Index (IS_OPTN) read FpaxTicketNumber write SetpaxTicketNumber stored paxTicketNumber_Specified;
    property paxTravelAgentInfo: string                 Index (IS_OPTN) read FpaxTravelAgentInfo write SetpaxTravelAgentInfo stored paxTravelAgentInfo_Specified;
    property txnData1:           string                 Index (IS_OPTN) read FtxnData1 write SettxnData1 stored txnData1_Specified;
    property txnData2:           string                 Index (IS_OPTN) read FtxnData2 write SettxnData2 stored txnData2_Specified;
    property txnData3:           string                 Index (IS_OPTN) read FtxnData3 write SettxnData3 stored txnData3_Specified;
    property txnRef:             string                 Index (IS_OPTN) read FtxnRef write SettxnRef stored txnRef_Specified;
    property txnType:            string                 Index (IS_OPTN) read FtxnType write SettxnType stored txnType_Specified;
    property dateStart:          string                 Index (IS_OPTN) read FdateStart write SetdateStart stored dateStart_Specified;
    property issueNumber:        string                 Index (IS_OPTN) read FissueNumber write SetissueNumber stored issueNumber_Specified;
    property enableAvsData:      string                 Index (IS_OPTN) read FenableAvsData write SetenableAvsData stored enableAvsData_Specified;
    property avsAction:          string                 Index (IS_OPTN) read FavsAction write SetavsAction stored avsAction_Specified;
    property avsPostCode:        string                 Index (IS_OPTN) read FavsPostCode write SetavsPostCode stored avsPostCode_Specified;
    property avsStreetAddress:   string                 Index (IS_OPTN) read FavsStreetAddress write SetavsStreetAddress stored avsStreetAddress_Specified;
    property enable3DSecure:     string                 Index (IS_OPTN) read Fenable3DSecure write Setenable3DSecure stored enable3DSecure_Specified;
    property paRes:              string                 Index (IS_OPTN) read FpaRes write SetpaRes stored paRes_Specified;
    property clientType:         string                 Index (IS_OPTN) read FclientType write SetclientType stored clientType_Specified;
    property iccData:            string                 Index (IS_OPTN) read FiccData write SeticcData stored iccData_Specified;
    property deviceId:           string                 Index (IS_OPTN) read FdeviceId write SetdeviceId stored deviceId_Specified;
    property cardNumber2:        string                 Index (IS_OPTN) read FcardNumber2 write SetcardNumber2 stored cardNumber2_Specified;
    property track2:             string                 Index (IS_OPTN) read Ftrack2 write Settrack2 stored track2_Specified;
    property cvc2Presence:       string                 Index (IS_OPTN) read Fcvc2Presence write Setcvc2Presence stored cvc2Presence_Specified;
    property extendedData:       ArrayOfNameValueField  Index (IS_OPTN) read FextendedData write SetextendedData stored extendedData_Specified;
  end;



  // ************************************************************************ //
  // XML       : NameValueField, global, <complexType>
  // Namespace : http://PaymentExpress.com
  // ************************************************************************ //
  NameValueField = class(TRemotable)
  private
    FfieldName: string;
    FfieldName_Specified: boolean;
    FfieldValue: string;
    FfieldValue_Specified: boolean;
    procedure SetfieldName(Index: Integer; const Astring: string);
    function  fieldName_Specified(Index: Integer): boolean;
    procedure SetfieldValue(Index: Integer; const Astring: string);
    function  fieldValue_Specified(Index: Integer): boolean;
  published
    property fieldName:  string  Index (IS_OPTN) read FfieldName write SetfieldName stored fieldName_Specified;
    property fieldValue: string  Index (IS_OPTN) read FfieldValue write SetfieldValue stored fieldValue_Specified;
  end;



  // ************************************************************************ //
  // XML       : EnrolmentCheckRequest, global, <complexType>
  // Namespace : http://PaymentExpress.com
  // ************************************************************************ //
  EnrolmentCheckRequest = class(TRemotable)
  private
    Famount: string;
    Famount_Specified: boolean;
    FcardNumber: string;
    FcardNumber_Specified: boolean;
    FdateExpiry: string;
    FdateExpiry_Specified: boolean;
    FtxnDescription: string;
    FtxnDescription_Specified: boolean;
    FtxnRef: string;
    FtxnRef_Specified: boolean;
    Fcurrency: string;
    Fcurrency_Specified: boolean;
    procedure Setamount(Index: Integer; const Astring: string);
    function  amount_Specified(Index: Integer): boolean;
    procedure SetcardNumber(Index: Integer; const Astring: string);
    function  cardNumber_Specified(Index: Integer): boolean;
    procedure SetdateExpiry(Index: Integer; const Astring: string);
    function  dateExpiry_Specified(Index: Integer): boolean;
    procedure SettxnDescription(Index: Integer; const Astring: string);
    function  txnDescription_Specified(Index: Integer): boolean;
    procedure SettxnRef(Index: Integer; const Astring: string);
    function  txnRef_Specified(Index: Integer): boolean;
    procedure Setcurrency(Index: Integer; const Astring: string);
    function  currency_Specified(Index: Integer): boolean;
  published
    property amount:         string  Index (IS_OPTN) read Famount write Setamount stored amount_Specified;
    property cardNumber:     string  Index (IS_OPTN) read FcardNumber write SetcardNumber stored cardNumber_Specified;
    property dateExpiry:     string  Index (IS_OPTN) read FdateExpiry write SetdateExpiry stored dateExpiry_Specified;
    property txnDescription: string  Index (IS_OPTN) read FtxnDescription write SettxnDescription stored txnDescription_Specified;
    property txnRef:         string  Index (IS_OPTN) read FtxnRef write SettxnRef stored txnRef_Specified;
    property currency:       string  Index (IS_OPTN) read Fcurrency write Setcurrency stored currency_Specified;
  end;



  // ************************************************************************ //
  // XML       : EnrolmentCheckResult, global, <complexType>
  // Namespace : http://PaymentExpress.com
  // ************************************************************************ //
  EnrolmentCheckResult = class(TRemotable)
  private
    Fenrolled: string;
    Fenrolled_Specified: boolean;
    FpaReq: string;
    FpaReq_Specified: boolean;
    FacsURL: string;
    FacsURL_Specified: boolean;
    procedure Setenrolled(Index: Integer; const Astring: string);
    function  enrolled_Specified(Index: Integer): boolean;
    procedure SetpaReq(Index: Integer; const Astring: string);
    function  paReq_Specified(Index: Integer): boolean;
    procedure SetacsURL(Index: Integer; const Astring: string);
    function  acsURL_Specified(Index: Integer): boolean;
  published
    property enrolled: string  Index (IS_OPTN) read Fenrolled write Setenrolled stored enrolled_Specified;
    property paReq:    string  Index (IS_OPTN) read FpaReq write SetpaReq stored paReq_Specified;
    property acsURL:   string  Index (IS_OPTN) read FacsURL write SetacsURL stored acsURL_Specified;
  end;

  ArrayOfRiskRuleMatch = array of riskRuleMatch;   { "http://PaymentExpress.com"[GblCplx] }


  // ************************************************************************ //
  // XML       : TransactionResult2, global, <complexType>
  // Namespace : http://PaymentExpress.com
  // ************************************************************************ //
  TransactionResult2 = class(TRemotable)
  private
    FacquirerReco: string;
    FacquirerReco_Specified: boolean;
    FacquirerResponseText: string;
    FacquirerResponseText_Specified: boolean;
    Famount: string;
    Famount_Specified: boolean;
    FauthCode: string;
    FauthCode_Specified: boolean;
    Fauthorized: string;
    Fauthorized_Specified: boolean;
    FbillingId: string;
    FbillingId_Specified: boolean;
    FcardHolderHelpText: string;
    FcardHolderHelpText_Specified: boolean;
    FcardHolderName: string;
    FcardHolderName_Specified: boolean;
    FcardHolderResponseDescription: string;
    FcardHolderResponseDescription_Specified: boolean;
    FcardHolderResponseText: string;
    FcardHolderResponseText_Specified: boolean;
    FcardName: string;
    FcardName_Specified: boolean;
    FcardNumber: string;
    FcardNumber_Specified: boolean;
    FcurrencyId: string;
    FcurrencyId_Specified: boolean;
    FcurrencyName: string;
    FcurrencyName_Specified: boolean;
    FcurrencyRate: string;
    FcurrencyRate_Specified: boolean;
    Fcvc2: string;
    Fcvc2_Specified: boolean;
    FdateExpiry: string;
    FdateExpiry_Specified: boolean;
    FdateSettlement: string;
    FdateSettlement_Specified: boolean;
    FdpsBillingId: string;
    FdpsBillingId_Specified: boolean;
    FdpsTxnRef: string;
    FdpsTxnRef_Specified: boolean;
    FhelpText: string;
    FhelpText_Specified: boolean;
    FmerchantHelpText: string;
    FmerchantHelpText_Specified: boolean;
    FmerchantReference: string;
    FmerchantReference_Specified: boolean;
    FmerchantResponseDescription: string;
    FmerchantResponseDescription_Specified: boolean;
    FmerchantResponseText: string;
    FmerchantResponseText_Specified: boolean;
    Freco: string;
    Freco_Specified: boolean;
    FresponseText: string;
    FresponseText_Specified: boolean;
    Fretry: string;
    Fretry_Specified: boolean;
    FstatusRequired: string;
    FstatusRequired_Specified: boolean;
    FtestMode: string;
    FtestMode_Specified: boolean;
    FtxnRef: string;
    FtxnRef_Specified: boolean;
    FtxnType: string;
    FtxnType_Specified: boolean;
    FiccData: string;
    FiccData_Specified: boolean;
    FcardNumber2: string;
    FcardNumber2_Specified: boolean;
    FissuerCountryId: string;
    FissuerCountryId_Specified: boolean;
    FtxnMac: string;
    FtxnMac_Specified: boolean;
    Fcvc2ResultCode: string;
    Fcvc2ResultCode_Specified: boolean;
    FriskRuleMatches: ArrayOfRiskRuleMatch;
    FriskRuleMatches_Specified: boolean;
    FextendedData: ArrayOfNameValueField;
    FextendedData_Specified: boolean;
    procedure SetacquirerReco(Index: Integer; const Astring: string);
    function  acquirerReco_Specified(Index: Integer): boolean;
    procedure SetacquirerResponseText(Index: Integer; const Astring: string);
    function  acquirerResponseText_Specified(Index: Integer): boolean;
    procedure Setamount(Index: Integer; const Astring: string);
    function  amount_Specified(Index: Integer): boolean;
    procedure SetauthCode(Index: Integer; const Astring: string);
    function  authCode_Specified(Index: Integer): boolean;
    procedure Setauthorized(Index: Integer; const Astring: string);
    function  authorized_Specified(Index: Integer): boolean;
    procedure SetbillingId(Index: Integer; const Astring: string);
    function  billingId_Specified(Index: Integer): boolean;
    procedure SetcardHolderHelpText(Index: Integer; const Astring: string);
    function  cardHolderHelpText_Specified(Index: Integer): boolean;
    procedure SetcardHolderName(Index: Integer; const Astring: string);
    function  cardHolderName_Specified(Index: Integer): boolean;
    procedure SetcardHolderResponseDescription(Index: Integer; const Astring: string);
    function  cardHolderResponseDescription_Specified(Index: Integer): boolean;
    procedure SetcardHolderResponseText(Index: Integer; const Astring: string);
    function  cardHolderResponseText_Specified(Index: Integer): boolean;
    procedure SetcardName(Index: Integer; const Astring: string);
    function  cardName_Specified(Index: Integer): boolean;
    procedure SetcardNumber(Index: Integer; const Astring: string);
    function  cardNumber_Specified(Index: Integer): boolean;
    procedure SetcurrencyId(Index: Integer; const Astring: string);
    function  currencyId_Specified(Index: Integer): boolean;
    procedure SetcurrencyName(Index: Integer; const Astring: string);
    function  currencyName_Specified(Index: Integer): boolean;
    procedure SetcurrencyRate(Index: Integer; const Astring: string);
    function  currencyRate_Specified(Index: Integer): boolean;
    procedure Setcvc2(Index: Integer; const Astring: string);
    function  cvc2_Specified(Index: Integer): boolean;
    procedure SetdateExpiry(Index: Integer; const Astring: string);
    function  dateExpiry_Specified(Index: Integer): boolean;
    procedure SetdateSettlement(Index: Integer; const Astring: string);
    function  dateSettlement_Specified(Index: Integer): boolean;
    procedure SetdpsBillingId(Index: Integer; const Astring: string);
    function  dpsBillingId_Specified(Index: Integer): boolean;
    procedure SetdpsTxnRef(Index: Integer; const Astring: string);
    function  dpsTxnRef_Specified(Index: Integer): boolean;
    procedure SethelpText(Index: Integer; const Astring: string);
    function  helpText_Specified(Index: Integer): boolean;
    procedure SetmerchantHelpText(Index: Integer; const Astring: string);
    function  merchantHelpText_Specified(Index: Integer): boolean;
    procedure SetmerchantReference(Index: Integer; const Astring: string);
    function  merchantReference_Specified(Index: Integer): boolean;
    procedure SetmerchantResponseDescription(Index: Integer; const Astring: string);
    function  merchantResponseDescription_Specified(Index: Integer): boolean;
    procedure SetmerchantResponseText(Index: Integer; const Astring: string);
    function  merchantResponseText_Specified(Index: Integer): boolean;
    procedure Setreco(Index: Integer; const Astring: string);
    function  reco_Specified(Index: Integer): boolean;
    procedure SetresponseText(Index: Integer; const Astring: string);
    function  responseText_Specified(Index: Integer): boolean;
    procedure Setretry(Index: Integer; const Astring: string);
    function  retry_Specified(Index: Integer): boolean;
    procedure SetstatusRequired(Index: Integer; const Astring: string);
    function  statusRequired_Specified(Index: Integer): boolean;
    procedure SettestMode(Index: Integer; const Astring: string);
    function  testMode_Specified(Index: Integer): boolean;
    procedure SettxnRef(Index: Integer; const Astring: string);
    function  txnRef_Specified(Index: Integer): boolean;
    procedure SettxnType(Index: Integer; const Astring: string);
    function  txnType_Specified(Index: Integer): boolean;
    procedure SeticcData(Index: Integer; const Astring: string);
    function  iccData_Specified(Index: Integer): boolean;
    procedure SetcardNumber2(Index: Integer; const Astring: string);
    function  cardNumber2_Specified(Index: Integer): boolean;
    procedure SetissuerCountryId(Index: Integer; const Astring: string);
    function  issuerCountryId_Specified(Index: Integer): boolean;
    procedure SettxnMac(Index: Integer; const Astring: string);
    function  txnMac_Specified(Index: Integer): boolean;
    procedure Setcvc2ResultCode(Index: Integer; const Astring: string);
    function  cvc2ResultCode_Specified(Index: Integer): boolean;
    procedure SetriskRuleMatches(Index: Integer; const AArrayOfRiskRuleMatch: ArrayOfRiskRuleMatch);
    function  riskRuleMatches_Specified(Index: Integer): boolean;
    procedure SetextendedData(Index: Integer; const AArrayOfNameValueField: ArrayOfNameValueField);
    function  extendedData_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property acquirerReco:                  string                 Index (IS_OPTN) read FacquirerReco write SetacquirerReco stored acquirerReco_Specified;
    property acquirerResponseText:          string                 Index (IS_OPTN) read FacquirerResponseText write SetacquirerResponseText stored acquirerResponseText_Specified;
    property amount:                        string                 Index (IS_OPTN) read Famount write Setamount stored amount_Specified;
    property authCode:                      string                 Index (IS_OPTN) read FauthCode write SetauthCode stored authCode_Specified;
    property authorized:                    string                 Index (IS_OPTN) read Fauthorized write Setauthorized stored authorized_Specified;
    property billingId:                     string                 Index (IS_OPTN) read FbillingId write SetbillingId stored billingId_Specified;
    property cardHolderHelpText:            string                 Index (IS_OPTN) read FcardHolderHelpText write SetcardHolderHelpText stored cardHolderHelpText_Specified;
    property cardHolderName:                string                 Index (IS_OPTN) read FcardHolderName write SetcardHolderName stored cardHolderName_Specified;
    property cardHolderResponseDescription: string                 Index (IS_OPTN) read FcardHolderResponseDescription write SetcardHolderResponseDescription stored cardHolderResponseDescription_Specified;
    property cardHolderResponseText:        string                 Index (IS_OPTN) read FcardHolderResponseText write SetcardHolderResponseText stored cardHolderResponseText_Specified;
    property cardName:                      string                 Index (IS_OPTN) read FcardName write SetcardName stored cardName_Specified;
    property cardNumber:                    string                 Index (IS_OPTN) read FcardNumber write SetcardNumber stored cardNumber_Specified;
    property currencyId:                    string                 Index (IS_OPTN) read FcurrencyId write SetcurrencyId stored currencyId_Specified;
    property currencyName:                  string                 Index (IS_OPTN) read FcurrencyName write SetcurrencyName stored currencyName_Specified;
    property currencyRate:                  string                 Index (IS_OPTN) read FcurrencyRate write SetcurrencyRate stored currencyRate_Specified;
    property cvc2:                          string                 Index (IS_OPTN) read Fcvc2 write Setcvc2 stored cvc2_Specified;
    property dateExpiry:                    string                 Index (IS_OPTN) read FdateExpiry write SetdateExpiry stored dateExpiry_Specified;
    property dateSettlement:                string                 Index (IS_OPTN) read FdateSettlement write SetdateSettlement stored dateSettlement_Specified;
    property dpsBillingId:                  string                 Index (IS_OPTN) read FdpsBillingId write SetdpsBillingId stored dpsBillingId_Specified;
    property dpsTxnRef:                     string                 Index (IS_OPTN) read FdpsTxnRef write SetdpsTxnRef stored dpsTxnRef_Specified;
    property helpText:                      string                 Index (IS_OPTN) read FhelpText write SethelpText stored helpText_Specified;
    property merchantHelpText:              string                 Index (IS_OPTN) read FmerchantHelpText write SetmerchantHelpText stored merchantHelpText_Specified;
    property merchantReference:             string                 Index (IS_OPTN) read FmerchantReference write SetmerchantReference stored merchantReference_Specified;
    property merchantResponseDescription:   string                 Index (IS_OPTN) read FmerchantResponseDescription write SetmerchantResponseDescription stored merchantResponseDescription_Specified;
    property merchantResponseText:          string                 Index (IS_OPTN) read FmerchantResponseText write SetmerchantResponseText stored merchantResponseText_Specified;
    property reco:                          string                 Index (IS_OPTN) read Freco write Setreco stored reco_Specified;
    property responseText:                  string                 Index (IS_OPTN) read FresponseText write SetresponseText stored responseText_Specified;
    property retry:                         string                 Index (IS_OPTN) read Fretry write Setretry stored retry_Specified;
    property statusRequired:                string                 Index (IS_OPTN) read FstatusRequired write SetstatusRequired stored statusRequired_Specified;
    property testMode:                      string                 Index (IS_OPTN) read FtestMode write SettestMode stored testMode_Specified;
    property txnRef:                        string                 Index (IS_OPTN) read FtxnRef write SettxnRef stored txnRef_Specified;
    property txnType:                       string                 Index (IS_OPTN) read FtxnType write SettxnType stored txnType_Specified;
    property iccData:                       string                 Index (IS_OPTN) read FiccData write SeticcData stored iccData_Specified;
    property cardNumber2:                   string                 Index (IS_OPTN) read FcardNumber2 write SetcardNumber2 stored cardNumber2_Specified;
    property issuerCountryId:               string                 Index (IS_OPTN) read FissuerCountryId write SetissuerCountryId stored issuerCountryId_Specified;
    property txnMac:                        string                 Index (IS_OPTN) read FtxnMac write SettxnMac stored txnMac_Specified;
    property cvc2ResultCode:                string                 Index (IS_OPTN) read Fcvc2ResultCode write Setcvc2ResultCode stored cvc2ResultCode_Specified;
    property riskRuleMatches:               ArrayOfRiskRuleMatch   Index (IS_OPTN) read FriskRuleMatches write SetriskRuleMatches stored riskRuleMatches_Specified;
    property extendedData:                  ArrayOfNameValueField  Index (IS_OPTN) read FextendedData write SetextendedData stored extendedData_Specified;
  end;



  // ************************************************************************ //
  // XML       : riskRuleMatch, global, <complexType>
  // Namespace : http://PaymentExpress.com
  // ************************************************************************ //
  riskRuleMatch = class(TRemotable)
  private
    FmatchedAmount: string;
    FmatchedAmount_Specified: boolean;
    FmatchedTransactionCount: Integer;
    Fname_: string;
    Fname__Specified: boolean;
    Ftype_: string;
    Ftype__Specified: boolean;
    Faction: string;
    Faction_Specified: boolean;
    Fperiod: Integer;
    FincludedTransactions: string;
    FincludedTransactions_Specified: boolean;
    FamountLimit: string;
    FamountLimit_Specified: boolean;
    FtransactionCountLimit: Integer;
    procedure SetmatchedAmount(Index: Integer; const Astring: string);
    function  matchedAmount_Specified(Index: Integer): boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
    procedure Settype_(Index: Integer; const Astring: string);
    function  type__Specified(Index: Integer): boolean;
    procedure Setaction(Index: Integer; const Astring: string);
    function  action_Specified(Index: Integer): boolean;
    procedure SetincludedTransactions(Index: Integer; const Astring: string);
    function  includedTransactions_Specified(Index: Integer): boolean;
    procedure SetamountLimit(Index: Integer; const Astring: string);
    function  amountLimit_Specified(Index: Integer): boolean;
  published
    property matchedAmount:           string   Index (IS_OPTN) read FmatchedAmount write SetmatchedAmount stored matchedAmount_Specified;
    property matchedTransactionCount: Integer  read FmatchedTransactionCount write FmatchedTransactionCount;
    property name_:                   string   Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
    property type_:                   string   Index (IS_OPTN) read Ftype_ write Settype_ stored type__Specified;
    property action:                  string   Index (IS_OPTN) read Faction write Setaction stored action_Specified;
    property period:                  Integer  read Fperiod write Fperiod;
    property includedTransactions:    string   Index (IS_OPTN) read FincludedTransactions write SetincludedTransactions stored includedTransactions_Specified;
    property amountLimit:             string   Index (IS_OPTN) read FamountLimit write SetamountLimit stored amountLimit_Specified;
    property transactionCountLimit:   Integer  read FtransactionCountLimit write FtransactionCountLimit;
  end;


  // ************************************************************************ //
  // Namespace : http://PaymentExpress.com
  // soapAction: http://PaymentExpress.com/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : PaymentExpressWSSoap
  // service   : PaymentExpressWS
  // port      : PaymentExpressWSSoap
  // URL       : https://sec.paymentexpress.com/WS/PXWS.asmx
  // ************************************************************************ //
  PaymentExpressWSSoap = interface(IInvokable)
  ['{121EED3C-28F8-85CA-11F1-AC889379766A}']
    function  SubmitTransaction(const postUsername: string; const postPassword: string; const transactionDetails: TransactionDetails): TransactionResult2; stdcall;
    function  SubmitTransaction2(const postUsername: string; const postPassword: string; const transactionDetails: TransactionDetails): TransactionResult2; stdcall;
    function  Check3dsEnrollment(const postUsername: string; const postPassword: string; const transactionDetails: EnrolmentCheckRequest): EnrolmentCheckResult; stdcall;
    function  GetStatus(const postUsername: string; const postPassword: string; const txnRef: string): TransactionResult2; stdcall;
    function  GetStatus2(const postUsername: string; const postPassword: string; const txnRef: string): TransactionResult2; stdcall;
    function  UpdateCard(const postUsername: string; const postPassword: string; const cardDetails: string): string; stdcall;
  end;

function GetPaymentExpressWSSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): PaymentExpressWSSoap;


implementation

uses
  {$IfDef VER220}
  Sysutils
  {$Else}
  System.Sysutils
  {$EndIf}
  ;

function GetPaymentExpressWSSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): PaymentExpressWSSoap;
const
  defWSDL = 'https://sec.paymentexpress.com/WS/PXWS.asmx?WSDL';
  defURL  = 'https://sec.paymentexpress.com/WS/PXWS.asmx';
  defSvc  = 'PaymentExpressWS';
  defPrt  = 'PaymentExpressWSSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as PaymentExpressWSSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor TransactionDetails.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FextendedData)-1 do
    SysUtils.FreeAndNil(FextendedData[I]);
  System.SetLength(FextendedData, 0);
  inherited Destroy;
end;

procedure TransactionDetails.Setamount(Index: Integer; const Astring: string);
begin
  Famount := Astring;
  Famount_Specified := True;
end;

function TransactionDetails.amount_Specified(Index: Integer): boolean;
begin
  Result := Famount_Specified;
end;

procedure TransactionDetails.SetbillingId(Index: Integer; const Astring: string);
begin
  FbillingId := Astring;
  FbillingId_Specified := True;
end;

function TransactionDetails.billingId_Specified(Index: Integer): boolean;
begin
  Result := FbillingId_Specified;
end;

procedure TransactionDetails.SetcardHolderName(Index: Integer; const Astring: string);
begin
  FcardHolderName := Astring;
  FcardHolderName_Specified := True;
end;

function TransactionDetails.cardHolderName_Specified(Index: Integer): boolean;
begin
  Result := FcardHolderName_Specified;
end;

procedure TransactionDetails.SetcardNumber(Index: Integer; const Astring: string);
begin
  FcardNumber := Astring;
  FcardNumber_Specified := True;
end;

function TransactionDetails.cardNumber_Specified(Index: Integer): boolean;
begin
  Result := FcardNumber_Specified;
end;

procedure TransactionDetails.SetclientInfo(Index: Integer; const Astring: string);
begin
  FclientInfo := Astring;
  FclientInfo_Specified := True;
end;

function TransactionDetails.clientInfo_Specified(Index: Integer): boolean;
begin
  Result := FclientInfo_Specified;
end;

procedure TransactionDetails.Setcvc2(Index: Integer; const Astring: string);
begin
  Fcvc2 := Astring;
  Fcvc2_Specified := True;
end;

function TransactionDetails.cvc2_Specified(Index: Integer): boolean;
begin
  Result := Fcvc2_Specified;
end;

procedure TransactionDetails.SetdateExpiry(Index: Integer; const Astring: string);
begin
  FdateExpiry := Astring;
  FdateExpiry_Specified := True;
end;

function TransactionDetails.dateExpiry_Specified(Index: Integer): boolean;
begin
  Result := FdateExpiry_Specified;
end;

procedure TransactionDetails.SetdpsBillingId(Index: Integer; const Astring: string);
begin
  FdpsBillingId := Astring;
  FdpsBillingId_Specified := True;
end;

function TransactionDetails.dpsBillingId_Specified(Index: Integer): boolean;
begin
  Result := FdpsBillingId_Specified;
end;

procedure TransactionDetails.SetdpsTxnRef(Index: Integer; const Astring: string);
begin
  FdpsTxnRef := Astring;
  FdpsTxnRef_Specified := True;
end;

function TransactionDetails.dpsTxnRef_Specified(Index: Integer): boolean;
begin
  Result := FdpsTxnRef_Specified;
end;

procedure TransactionDetails.SetenableAddBillCard(Index: Integer; const Astring: string);
begin
  FenableAddBillCard := Astring;
  FenableAddBillCard_Specified := True;
end;

function TransactionDetails.enableAddBillCard_Specified(Index: Integer): boolean;
begin
  Result := FenableAddBillCard_Specified;
end;

procedure TransactionDetails.SetenablePaxInfo(Index: Integer; const Astring: string);
begin
  FenablePaxInfo := Astring;
  FenablePaxInfo_Specified := True;
end;

function TransactionDetails.enablePaxInfo_Specified(Index: Integer): boolean;
begin
  Result := FenablePaxInfo_Specified;
end;

procedure TransactionDetails.SetinputCurrency(Index: Integer; const Astring: string);
begin
  FinputCurrency := Astring;
  FinputCurrency_Specified := True;
end;

function TransactionDetails.inputCurrency_Specified(Index: Integer): boolean;
begin
  Result := FinputCurrency_Specified;
end;

procedure TransactionDetails.SetmerchantReference(Index: Integer; const Astring: string);
begin
  FmerchantReference := Astring;
  FmerchantReference_Specified := True;
end;

function TransactionDetails.merchantReference_Specified(Index: Integer): boolean;
begin
  Result := FmerchantReference_Specified;
end;

procedure TransactionDetails.SetpaxCarrier(Index: Integer; const Astring: string);
begin
  FpaxCarrier := Astring;
  FpaxCarrier_Specified := True;
end;

function TransactionDetails.paxCarrier_Specified(Index: Integer): boolean;
begin
  Result := FpaxCarrier_Specified;
end;

procedure TransactionDetails.SetpaxCarrier2(Index: Integer; const Astring: string);
begin
  FpaxCarrier2 := Astring;
  FpaxCarrier2_Specified := True;
end;

function TransactionDetails.paxCarrier2_Specified(Index: Integer): boolean;
begin
  Result := FpaxCarrier2_Specified;
end;

procedure TransactionDetails.SetpaxCarrier3(Index: Integer; const Astring: string);
begin
  FpaxCarrier3 := Astring;
  FpaxCarrier3_Specified := True;
end;

function TransactionDetails.paxCarrier3_Specified(Index: Integer): boolean;
begin
  Result := FpaxCarrier3_Specified;
end;

procedure TransactionDetails.SetpaxCarrier4(Index: Integer; const Astring: string);
begin
  FpaxCarrier4 := Astring;
  FpaxCarrier4_Specified := True;
end;

function TransactionDetails.paxCarrier4_Specified(Index: Integer): boolean;
begin
  Result := FpaxCarrier4_Specified;
end;

procedure TransactionDetails.SetpaxDateDepart(Index: Integer; const Astring: string);
begin
  FpaxDateDepart := Astring;
  FpaxDateDepart_Specified := True;
end;

function TransactionDetails.paxDateDepart_Specified(Index: Integer): boolean;
begin
  Result := FpaxDateDepart_Specified;
end;

procedure TransactionDetails.SetpaxDate2(Index: Integer; const Astring: string);
begin
  FpaxDate2 := Astring;
  FpaxDate2_Specified := True;
end;

function TransactionDetails.paxDate2_Specified(Index: Integer): boolean;
begin
  Result := FpaxDate2_Specified;
end;

procedure TransactionDetails.SetpaxDate3(Index: Integer; const Astring: string);
begin
  FpaxDate3 := Astring;
  FpaxDate3_Specified := True;
end;

function TransactionDetails.paxDate3_Specified(Index: Integer): boolean;
begin
  Result := FpaxDate3_Specified;
end;

procedure TransactionDetails.SetpaxDate4(Index: Integer; const Astring: string);
begin
  FpaxDate4 := Astring;
  FpaxDate4_Specified := True;
end;

function TransactionDetails.paxDate4_Specified(Index: Integer): boolean;
begin
  Result := FpaxDate4_Specified;
end;

procedure TransactionDetails.SetpaxTime1(Index: Integer; const Astring: string);
begin
  FpaxTime1 := Astring;
  FpaxTime1_Specified := True;
end;

function TransactionDetails.paxTime1_Specified(Index: Integer): boolean;
begin
  Result := FpaxTime1_Specified;
end;

procedure TransactionDetails.SetpaxTime2(Index: Integer; const Astring: string);
begin
  FpaxTime2 := Astring;
  FpaxTime2_Specified := True;
end;

function TransactionDetails.paxTime2_Specified(Index: Integer): boolean;
begin
  Result := FpaxTime2_Specified;
end;

procedure TransactionDetails.SetpaxTime3(Index: Integer; const Astring: string);
begin
  FpaxTime3 := Astring;
  FpaxTime3_Specified := True;
end;

function TransactionDetails.paxTime3_Specified(Index: Integer): boolean;
begin
  Result := FpaxTime3_Specified;
end;

procedure TransactionDetails.SetpaxTime4(Index: Integer; const Astring: string);
begin
  FpaxTime4 := Astring;
  FpaxTime4_Specified := True;
end;

function TransactionDetails.paxTime4_Specified(Index: Integer): boolean;
begin
  Result := FpaxTime4_Specified;
end;

procedure TransactionDetails.SetpaxLeg1(Index: Integer; const Astring: string);
begin
  FpaxLeg1 := Astring;
  FpaxLeg1_Specified := True;
end;

function TransactionDetails.paxLeg1_Specified(Index: Integer): boolean;
begin
  Result := FpaxLeg1_Specified;
end;

procedure TransactionDetails.SetpaxLeg2(Index: Integer; const Astring: string);
begin
  FpaxLeg2 := Astring;
  FpaxLeg2_Specified := True;
end;

function TransactionDetails.paxLeg2_Specified(Index: Integer): boolean;
begin
  Result := FpaxLeg2_Specified;
end;

procedure TransactionDetails.SetpaxLeg3(Index: Integer; const Astring: string);
begin
  FpaxLeg3 := Astring;
  FpaxLeg3_Specified := True;
end;

function TransactionDetails.paxLeg3_Specified(Index: Integer): boolean;
begin
  Result := FpaxLeg3_Specified;
end;

procedure TransactionDetails.SetpaxLeg4(Index: Integer; const Astring: string);
begin
  FpaxLeg4 := Astring;
  FpaxLeg4_Specified := True;
end;

function TransactionDetails.paxLeg4_Specified(Index: Integer): boolean;
begin
  Result := FpaxLeg4_Specified;
end;

procedure TransactionDetails.SetpaxClass1(Index: Integer; const Astring: string);
begin
  FpaxClass1 := Astring;
  FpaxClass1_Specified := True;
end;

function TransactionDetails.paxClass1_Specified(Index: Integer): boolean;
begin
  Result := FpaxClass1_Specified;
end;

procedure TransactionDetails.SetpaxClass2(Index: Integer; const Astring: string);
begin
  FpaxClass2 := Astring;
  FpaxClass2_Specified := True;
end;

function TransactionDetails.paxClass2_Specified(Index: Integer): boolean;
begin
  Result := FpaxClass2_Specified;
end;

procedure TransactionDetails.SetpaxClass3(Index: Integer; const Astring: string);
begin
  FpaxClass3 := Astring;
  FpaxClass3_Specified := True;
end;

function TransactionDetails.paxClass3_Specified(Index: Integer): boolean;
begin
  Result := FpaxClass3_Specified;
end;

procedure TransactionDetails.SetpaxClass4(Index: Integer; const Astring: string);
begin
  FpaxClass4 := Astring;
  FpaxClass4_Specified := True;
end;

function TransactionDetails.paxClass4_Specified(Index: Integer): boolean;
begin
  Result := FpaxClass4_Specified;
end;

procedure TransactionDetails.SetpaxStopOverCode1(Index: Integer; const Astring: string);
begin
  FpaxStopOverCode1 := Astring;
  FpaxStopOverCode1_Specified := True;
end;

function TransactionDetails.paxStopOverCode1_Specified(Index: Integer): boolean;
begin
  Result := FpaxStopOverCode1_Specified;
end;

procedure TransactionDetails.SetpaxStopOverCode2(Index: Integer; const Astring: string);
begin
  FpaxStopOverCode2 := Astring;
  FpaxStopOverCode2_Specified := True;
end;

function TransactionDetails.paxStopOverCode2_Specified(Index: Integer): boolean;
begin
  Result := FpaxStopOverCode2_Specified;
end;

procedure TransactionDetails.SetpaxStopOverCode3(Index: Integer; const Astring: string);
begin
  FpaxStopOverCode3 := Astring;
  FpaxStopOverCode3_Specified := True;
end;

function TransactionDetails.paxStopOverCode3_Specified(Index: Integer): boolean;
begin
  Result := FpaxStopOverCode3_Specified;
end;

procedure TransactionDetails.SetpaxStopOverCode4(Index: Integer; const Astring: string);
begin
  FpaxStopOverCode4 := Astring;
  FpaxStopOverCode4_Specified := True;
end;

function TransactionDetails.paxStopOverCode4_Specified(Index: Integer): boolean;
begin
  Result := FpaxStopOverCode4_Specified;
end;

procedure TransactionDetails.SetpaxFareBasis1(Index: Integer; const Astring: string);
begin
  FpaxFareBasis1 := Astring;
  FpaxFareBasis1_Specified := True;
end;

function TransactionDetails.paxFareBasis1_Specified(Index: Integer): boolean;
begin
  Result := FpaxFareBasis1_Specified;
end;

procedure TransactionDetails.SetpaxFareBasis2(Index: Integer; const Astring: string);
begin
  FpaxFareBasis2 := Astring;
  FpaxFareBasis2_Specified := True;
end;

function TransactionDetails.paxFareBasis2_Specified(Index: Integer): boolean;
begin
  Result := FpaxFareBasis2_Specified;
end;

procedure TransactionDetails.SetpaxFareBasis3(Index: Integer; const Astring: string);
begin
  FpaxFareBasis3 := Astring;
  FpaxFareBasis3_Specified := True;
end;

function TransactionDetails.paxFareBasis3_Specified(Index: Integer): boolean;
begin
  Result := FpaxFareBasis3_Specified;
end;

procedure TransactionDetails.SetpaxFareBasis4(Index: Integer; const Astring: string);
begin
  FpaxFareBasis4 := Astring;
  FpaxFareBasis4_Specified := True;
end;

function TransactionDetails.paxFareBasis4_Specified(Index: Integer): boolean;
begin
  Result := FpaxFareBasis4_Specified;
end;

procedure TransactionDetails.SetpaxFlightNumber1(Index: Integer; const Astring: string);
begin
  FpaxFlightNumber1 := Astring;
  FpaxFlightNumber1_Specified := True;
end;

function TransactionDetails.paxFlightNumber1_Specified(Index: Integer): boolean;
begin
  Result := FpaxFlightNumber1_Specified;
end;

procedure TransactionDetails.SetpaxFlightNumber2(Index: Integer; const Astring: string);
begin
  FpaxFlightNumber2 := Astring;
  FpaxFlightNumber2_Specified := True;
end;

function TransactionDetails.paxFlightNumber2_Specified(Index: Integer): boolean;
begin
  Result := FpaxFlightNumber2_Specified;
end;

procedure TransactionDetails.SetpaxFlightNumber3(Index: Integer; const Astring: string);
begin
  FpaxFlightNumber3 := Astring;
  FpaxFlightNumber3_Specified := True;
end;

function TransactionDetails.paxFlightNumber3_Specified(Index: Integer): boolean;
begin
  Result := FpaxFlightNumber3_Specified;
end;

procedure TransactionDetails.SetpaxFlightNumber4(Index: Integer; const Astring: string);
begin
  FpaxFlightNumber4 := Astring;
  FpaxFlightNumber4_Specified := True;
end;

function TransactionDetails.paxFlightNumber4_Specified(Index: Integer): boolean;
begin
  Result := FpaxFlightNumber4_Specified;
end;

procedure TransactionDetails.SetpaxName(Index: Integer; const Astring: string);
begin
  FpaxName := Astring;
  FpaxName_Specified := True;
end;

function TransactionDetails.paxName_Specified(Index: Integer): boolean;
begin
  Result := FpaxName_Specified;
end;

procedure TransactionDetails.SetpaxOrigin(Index: Integer; const Astring: string);
begin
  FpaxOrigin := Astring;
  FpaxOrigin_Specified := True;
end;

function TransactionDetails.paxOrigin_Specified(Index: Integer): boolean;
begin
  Result := FpaxOrigin_Specified;
end;

procedure TransactionDetails.SetpaxTicketNumber(Index: Integer; const Astring: string);
begin
  FpaxTicketNumber := Astring;
  FpaxTicketNumber_Specified := True;
end;

function TransactionDetails.paxTicketNumber_Specified(Index: Integer): boolean;
begin
  Result := FpaxTicketNumber_Specified;
end;

procedure TransactionDetails.SetpaxTravelAgentInfo(Index: Integer; const Astring: string);
begin
  FpaxTravelAgentInfo := Astring;
  FpaxTravelAgentInfo_Specified := True;
end;

function TransactionDetails.paxTravelAgentInfo_Specified(Index: Integer): boolean;
begin
  Result := FpaxTravelAgentInfo_Specified;
end;

procedure TransactionDetails.SettxnData1(Index: Integer; const Astring: string);
begin
  FtxnData1 := Astring;
  FtxnData1_Specified := True;
end;

function TransactionDetails.txnData1_Specified(Index: Integer): boolean;
begin
  Result := FtxnData1_Specified;
end;

procedure TransactionDetails.SettxnData2(Index: Integer; const Astring: string);
begin
  FtxnData2 := Astring;
  FtxnData2_Specified := True;
end;

function TransactionDetails.txnData2_Specified(Index: Integer): boolean;
begin
  Result := FtxnData2_Specified;
end;

procedure TransactionDetails.SettxnData3(Index: Integer; const Astring: string);
begin
  FtxnData3 := Astring;
  FtxnData3_Specified := True;
end;

function TransactionDetails.txnData3_Specified(Index: Integer): boolean;
begin
  Result := FtxnData3_Specified;
end;

procedure TransactionDetails.SettxnRef(Index: Integer; const Astring: string);
begin
  FtxnRef := Astring;
  FtxnRef_Specified := True;
end;

function TransactionDetails.txnRef_Specified(Index: Integer): boolean;
begin
  Result := FtxnRef_Specified;
end;

procedure TransactionDetails.SettxnType(Index: Integer; const Astring: string);
begin
  FtxnType := Astring;
  FtxnType_Specified := True;
end;

function TransactionDetails.txnType_Specified(Index: Integer): boolean;
begin
  Result := FtxnType_Specified;
end;

procedure TransactionDetails.SetdateStart(Index: Integer; const Astring: string);
begin
  FdateStart := Astring;
  FdateStart_Specified := True;
end;

function TransactionDetails.dateStart_Specified(Index: Integer): boolean;
begin
  Result := FdateStart_Specified;
end;

procedure TransactionDetails.SetissueNumber(Index: Integer; const Astring: string);
begin
  FissueNumber := Astring;
  FissueNumber_Specified := True;
end;

function TransactionDetails.issueNumber_Specified(Index: Integer): boolean;
begin
  Result := FissueNumber_Specified;
end;

procedure TransactionDetails.SetenableAvsData(Index: Integer; const Astring: string);
begin
  FenableAvsData := Astring;
  FenableAvsData_Specified := True;
end;

function TransactionDetails.enableAvsData_Specified(Index: Integer): boolean;
begin
  Result := FenableAvsData_Specified;
end;

procedure TransactionDetails.SetavsAction(Index: Integer; const Astring: string);
begin
  FavsAction := Astring;
  FavsAction_Specified := True;
end;

function TransactionDetails.avsAction_Specified(Index: Integer): boolean;
begin
  Result := FavsAction_Specified;
end;

procedure TransactionDetails.SetavsPostCode(Index: Integer; const Astring: string);
begin
  FavsPostCode := Astring;
  FavsPostCode_Specified := True;
end;

function TransactionDetails.avsPostCode_Specified(Index: Integer): boolean;
begin
  Result := FavsPostCode_Specified;
end;

procedure TransactionDetails.SetavsStreetAddress(Index: Integer; const Astring: string);
begin
  FavsStreetAddress := Astring;
  FavsStreetAddress_Specified := True;
end;

function TransactionDetails.avsStreetAddress_Specified(Index: Integer): boolean;
begin
  Result := FavsStreetAddress_Specified;
end;

procedure TransactionDetails.Setenable3DSecure(Index: Integer; const Astring: string);
begin
  Fenable3DSecure := Astring;
  Fenable3DSecure_Specified := True;
end;

function TransactionDetails.enable3DSecure_Specified(Index: Integer): boolean;
begin
  Result := Fenable3DSecure_Specified;
end;

procedure TransactionDetails.SetpaRes(Index: Integer; const Astring: string);
begin
  FpaRes := Astring;
  FpaRes_Specified := True;
end;

function TransactionDetails.paRes_Specified(Index: Integer): boolean;
begin
  Result := FpaRes_Specified;
end;

procedure TransactionDetails.SetclientType(Index: Integer; const Astring: string);
begin
  FclientType := Astring;
  FclientType_Specified := True;
end;

function TransactionDetails.clientType_Specified(Index: Integer): boolean;
begin
  Result := FclientType_Specified;
end;

procedure TransactionDetails.SeticcData(Index: Integer; const Astring: string);
begin
  FiccData := Astring;
  FiccData_Specified := True;
end;

function TransactionDetails.iccData_Specified(Index: Integer): boolean;
begin
  Result := FiccData_Specified;
end;

procedure TransactionDetails.SetdeviceId(Index: Integer; const Astring: string);
begin
  FdeviceId := Astring;
  FdeviceId_Specified := True;
end;

function TransactionDetails.deviceId_Specified(Index: Integer): boolean;
begin
  Result := FdeviceId_Specified;
end;

procedure TransactionDetails.SetcardNumber2(Index: Integer; const Astring: string);
begin
  FcardNumber2 := Astring;
  FcardNumber2_Specified := True;
end;

function TransactionDetails.cardNumber2_Specified(Index: Integer): boolean;
begin
  Result := FcardNumber2_Specified;
end;

procedure TransactionDetails.Settrack2(Index: Integer; const Astring: string);
begin
  Ftrack2 := Astring;
  Ftrack2_Specified := True;
end;

function TransactionDetails.track2_Specified(Index: Integer): boolean;
begin
  Result := Ftrack2_Specified;
end;

procedure TransactionDetails.Setcvc2Presence(Index: Integer; const Astring: string);
begin
  Fcvc2Presence := Astring;
  Fcvc2Presence_Specified := True;
end;

function TransactionDetails.cvc2Presence_Specified(Index: Integer): boolean;
begin
  Result := Fcvc2Presence_Specified;
end;

procedure TransactionDetails.SetextendedData(Index: Integer; const AArrayOfNameValueField: ArrayOfNameValueField);
begin
  FextendedData := AArrayOfNameValueField;
  FextendedData_Specified := True;
end;

function TransactionDetails.extendedData_Specified(Index: Integer): boolean;
begin
  Result := FextendedData_Specified;
end;

procedure NameValueField.SetfieldName(Index: Integer; const Astring: string);
begin
  FfieldName := Astring;
  FfieldName_Specified := True;
end;

function NameValueField.fieldName_Specified(Index: Integer): boolean;
begin
  Result := FfieldName_Specified;
end;

procedure NameValueField.SetfieldValue(Index: Integer; const Astring: string);
begin
  FfieldValue := Astring;
  FfieldValue_Specified := True;
end;

function NameValueField.fieldValue_Specified(Index: Integer): boolean;
begin
  Result := FfieldValue_Specified;
end;

procedure EnrolmentCheckRequest.Setamount(Index: Integer; const Astring: string);
begin
  Famount := Astring;
  Famount_Specified := True;
end;

function EnrolmentCheckRequest.amount_Specified(Index: Integer): boolean;
begin
  Result := Famount_Specified;
end;

procedure EnrolmentCheckRequest.SetcardNumber(Index: Integer; const Astring: string);
begin
  FcardNumber := Astring;
  FcardNumber_Specified := True;
end;

function EnrolmentCheckRequest.cardNumber_Specified(Index: Integer): boolean;
begin
  Result := FcardNumber_Specified;
end;

procedure EnrolmentCheckRequest.SetdateExpiry(Index: Integer; const Astring: string);
begin
  FdateExpiry := Astring;
  FdateExpiry_Specified := True;
end;

function EnrolmentCheckRequest.dateExpiry_Specified(Index: Integer): boolean;
begin
  Result := FdateExpiry_Specified;
end;

procedure EnrolmentCheckRequest.SettxnDescription(Index: Integer; const Astring: string);
begin
  FtxnDescription := Astring;
  FtxnDescription_Specified := True;
end;

function EnrolmentCheckRequest.txnDescription_Specified(Index: Integer): boolean;
begin
  Result := FtxnDescription_Specified;
end;

procedure EnrolmentCheckRequest.SettxnRef(Index: Integer; const Astring: string);
begin
  FtxnRef := Astring;
  FtxnRef_Specified := True;
end;

function EnrolmentCheckRequest.txnRef_Specified(Index: Integer): boolean;
begin
  Result := FtxnRef_Specified;
end;

procedure EnrolmentCheckRequest.Setcurrency(Index: Integer; const Astring: string);
begin
  Fcurrency := Astring;
  Fcurrency_Specified := True;
end;

function EnrolmentCheckRequest.currency_Specified(Index: Integer): boolean;
begin
  Result := Fcurrency_Specified;
end;

procedure EnrolmentCheckResult.Setenrolled(Index: Integer; const Astring: string);
begin
  Fenrolled := Astring;
  Fenrolled_Specified := True;
end;

function EnrolmentCheckResult.enrolled_Specified(Index: Integer): boolean;
begin
  Result := Fenrolled_Specified;
end;

procedure EnrolmentCheckResult.SetpaReq(Index: Integer; const Astring: string);
begin
  FpaReq := Astring;
  FpaReq_Specified := True;
end;

function EnrolmentCheckResult.paReq_Specified(Index: Integer): boolean;
begin
  Result := FpaReq_Specified;
end;

procedure EnrolmentCheckResult.SetacsURL(Index: Integer; const Astring: string);
begin
  FacsURL := Astring;
  FacsURL_Specified := True;
end;

function EnrolmentCheckResult.acsURL_Specified(Index: Integer): boolean;
begin
  Result := FacsURL_Specified;
end;

destructor TransactionResult2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FriskRuleMatches)-1 do
    SysUtils.FreeAndNil(FriskRuleMatches[I]);
  System.SetLength(FriskRuleMatches, 0);
  for I := 0 to System.Length(FextendedData)-1 do
    SysUtils.FreeAndNil(FextendedData[I]);
  System.SetLength(FextendedData, 0);
  inherited Destroy;
end;

procedure TransactionResult2.SetacquirerReco(Index: Integer; const Astring: string);
begin
  FacquirerReco := Astring;
  FacquirerReco_Specified := True;
end;

function TransactionResult2.acquirerReco_Specified(Index: Integer): boolean;
begin
  Result := FacquirerReco_Specified;
end;

procedure TransactionResult2.SetacquirerResponseText(Index: Integer; const Astring: string);
begin
  FacquirerResponseText := Astring;
  FacquirerResponseText_Specified := True;
end;

function TransactionResult2.acquirerResponseText_Specified(Index: Integer): boolean;
begin
  Result := FacquirerResponseText_Specified;
end;

procedure TransactionResult2.Setamount(Index: Integer; const Astring: string);
begin
  Famount := Astring;
  Famount_Specified := True;
end;

function TransactionResult2.amount_Specified(Index: Integer): boolean;
begin
  Result := Famount_Specified;
end;

procedure TransactionResult2.SetauthCode(Index: Integer; const Astring: string);
begin
  FauthCode := Astring;
  FauthCode_Specified := True;
end;

function TransactionResult2.authCode_Specified(Index: Integer): boolean;
begin
  Result := FauthCode_Specified;
end;

procedure TransactionResult2.Setauthorized(Index: Integer; const Astring: string);
begin
  Fauthorized := Astring;
  Fauthorized_Specified := True;
end;

function TransactionResult2.authorized_Specified(Index: Integer): boolean;
begin
  Result := Fauthorized_Specified;
end;

procedure TransactionResult2.SetbillingId(Index: Integer; const Astring: string);
begin
  FbillingId := Astring;
  FbillingId_Specified := True;
end;

function TransactionResult2.billingId_Specified(Index: Integer): boolean;
begin
  Result := FbillingId_Specified;
end;

procedure TransactionResult2.SetcardHolderHelpText(Index: Integer; const Astring: string);
begin
  FcardHolderHelpText := Astring;
  FcardHolderHelpText_Specified := True;
end;

function TransactionResult2.cardHolderHelpText_Specified(Index: Integer): boolean;
begin
  Result := FcardHolderHelpText_Specified;
end;

procedure TransactionResult2.SetcardHolderName(Index: Integer; const Astring: string);
begin
  FcardHolderName := Astring;
  FcardHolderName_Specified := True;
end;

function TransactionResult2.cardHolderName_Specified(Index: Integer): boolean;
begin
  Result := FcardHolderName_Specified;
end;

procedure TransactionResult2.SetcardHolderResponseDescription(Index: Integer; const Astring: string);
begin
  FcardHolderResponseDescription := Astring;
  FcardHolderResponseDescription_Specified := True;
end;

function TransactionResult2.cardHolderResponseDescription_Specified(Index: Integer): boolean;
begin
  Result := FcardHolderResponseDescription_Specified;
end;

procedure TransactionResult2.SetcardHolderResponseText(Index: Integer; const Astring: string);
begin
  FcardHolderResponseText := Astring;
  FcardHolderResponseText_Specified := True;
end;

function TransactionResult2.cardHolderResponseText_Specified(Index: Integer): boolean;
begin
  Result := FcardHolderResponseText_Specified;
end;

procedure TransactionResult2.SetcardName(Index: Integer; const Astring: string);
begin
  FcardName := Astring;
  FcardName_Specified := True;
end;

function TransactionResult2.cardName_Specified(Index: Integer): boolean;
begin
  Result := FcardName_Specified;
end;

procedure TransactionResult2.SetcardNumber(Index: Integer; const Astring: string);
begin
  FcardNumber := Astring;
  FcardNumber_Specified := True;
end;

function TransactionResult2.cardNumber_Specified(Index: Integer): boolean;
begin
  Result := FcardNumber_Specified;
end;

procedure TransactionResult2.SetcurrencyId(Index: Integer; const Astring: string);
begin
  FcurrencyId := Astring;
  FcurrencyId_Specified := True;
end;

function TransactionResult2.currencyId_Specified(Index: Integer): boolean;
begin
  Result := FcurrencyId_Specified;
end;

procedure TransactionResult2.SetcurrencyName(Index: Integer; const Astring: string);
begin
  FcurrencyName := Astring;
  FcurrencyName_Specified := True;
end;

function TransactionResult2.currencyName_Specified(Index: Integer): boolean;
begin
  Result := FcurrencyName_Specified;
end;

procedure TransactionResult2.SetcurrencyRate(Index: Integer; const Astring: string);
begin
  FcurrencyRate := Astring;
  FcurrencyRate_Specified := True;
end;

function TransactionResult2.currencyRate_Specified(Index: Integer): boolean;
begin
  Result := FcurrencyRate_Specified;
end;

procedure TransactionResult2.Setcvc2(Index: Integer; const Astring: string);
begin
  Fcvc2 := Astring;
  Fcvc2_Specified := True;
end;

function TransactionResult2.cvc2_Specified(Index: Integer): boolean;
begin
  Result := Fcvc2_Specified;
end;

procedure TransactionResult2.SetdateExpiry(Index: Integer; const Astring: string);
begin
  FdateExpiry := Astring;
  FdateExpiry_Specified := True;
end;

function TransactionResult2.dateExpiry_Specified(Index: Integer): boolean;
begin
  Result := FdateExpiry_Specified;
end;

procedure TransactionResult2.SetdateSettlement(Index: Integer; const Astring: string);
begin
  FdateSettlement := Astring;
  FdateSettlement_Specified := True;
end;

function TransactionResult2.dateSettlement_Specified(Index: Integer): boolean;
begin
  Result := FdateSettlement_Specified;
end;

procedure TransactionResult2.SetdpsBillingId(Index: Integer; const Astring: string);
begin
  FdpsBillingId := Astring;
  FdpsBillingId_Specified := True;
end;

function TransactionResult2.dpsBillingId_Specified(Index: Integer): boolean;
begin
  Result := FdpsBillingId_Specified;
end;

procedure TransactionResult2.SetdpsTxnRef(Index: Integer; const Astring: string);
begin
  FdpsTxnRef := Astring;
  FdpsTxnRef_Specified := True;
end;

function TransactionResult2.dpsTxnRef_Specified(Index: Integer): boolean;
begin
  Result := FdpsTxnRef_Specified;
end;

procedure TransactionResult2.SethelpText(Index: Integer; const Astring: string);
begin
  FhelpText := Astring;
  FhelpText_Specified := True;
end;

function TransactionResult2.helpText_Specified(Index: Integer): boolean;
begin
  Result := FhelpText_Specified;
end;

procedure TransactionResult2.SetmerchantHelpText(Index: Integer; const Astring: string);
begin
  FmerchantHelpText := Astring;
  FmerchantHelpText_Specified := True;
end;

function TransactionResult2.merchantHelpText_Specified(Index: Integer): boolean;
begin
  Result := FmerchantHelpText_Specified;
end;

procedure TransactionResult2.SetmerchantReference(Index: Integer; const Astring: string);
begin
  FmerchantReference := Astring;
  FmerchantReference_Specified := True;
end;

function TransactionResult2.merchantReference_Specified(Index: Integer): boolean;
begin
  Result := FmerchantReference_Specified;
end;

procedure TransactionResult2.SetmerchantResponseDescription(Index: Integer; const Astring: string);
begin
  FmerchantResponseDescription := Astring;
  FmerchantResponseDescription_Specified := True;
end;

function TransactionResult2.merchantResponseDescription_Specified(Index: Integer): boolean;
begin
  Result := FmerchantResponseDescription_Specified;
end;

procedure TransactionResult2.SetmerchantResponseText(Index: Integer; const Astring: string);
begin
  FmerchantResponseText := Astring;
  FmerchantResponseText_Specified := True;
end;

function TransactionResult2.merchantResponseText_Specified(Index: Integer): boolean;
begin
  Result := FmerchantResponseText_Specified;
end;

procedure TransactionResult2.Setreco(Index: Integer; const Astring: string);
begin
  Freco := Astring;
  Freco_Specified := True;
end;

function TransactionResult2.reco_Specified(Index: Integer): boolean;
begin
  Result := Freco_Specified;
end;

procedure TransactionResult2.SetresponseText(Index: Integer; const Astring: string);
begin
  FresponseText := Astring;
  FresponseText_Specified := True;
end;

function TransactionResult2.responseText_Specified(Index: Integer): boolean;
begin
  Result := FresponseText_Specified;
end;

procedure TransactionResult2.Setretry(Index: Integer; const Astring: string);
begin
  Fretry := Astring;
  Fretry_Specified := True;
end;

function TransactionResult2.retry_Specified(Index: Integer): boolean;
begin
  Result := Fretry_Specified;
end;

procedure TransactionResult2.SetstatusRequired(Index: Integer; const Astring: string);
begin
  FstatusRequired := Astring;
  FstatusRequired_Specified := True;
end;

function TransactionResult2.statusRequired_Specified(Index: Integer): boolean;
begin
  Result := FstatusRequired_Specified;
end;

procedure TransactionResult2.SettestMode(Index: Integer; const Astring: string);
begin
  FtestMode := Astring;
  FtestMode_Specified := True;
end;

function TransactionResult2.testMode_Specified(Index: Integer): boolean;
begin
  Result := FtestMode_Specified;
end;

procedure TransactionResult2.SettxnRef(Index: Integer; const Astring: string);
begin
  FtxnRef := Astring;
  FtxnRef_Specified := True;
end;

function TransactionResult2.txnRef_Specified(Index: Integer): boolean;
begin
  Result := FtxnRef_Specified;
end;

procedure TransactionResult2.SettxnType(Index: Integer; const Astring: string);
begin
  FtxnType := Astring;
  FtxnType_Specified := True;
end;

function TransactionResult2.txnType_Specified(Index: Integer): boolean;
begin
  Result := FtxnType_Specified;
end;

procedure TransactionResult2.SeticcData(Index: Integer; const Astring: string);
begin
  FiccData := Astring;
  FiccData_Specified := True;
end;

function TransactionResult2.iccData_Specified(Index: Integer): boolean;
begin
  Result := FiccData_Specified;
end;

procedure TransactionResult2.SetcardNumber2(Index: Integer; const Astring: string);
begin
  FcardNumber2 := Astring;
  FcardNumber2_Specified := True;
end;

function TransactionResult2.cardNumber2_Specified(Index: Integer): boolean;
begin
  Result := FcardNumber2_Specified;
end;

procedure TransactionResult2.SetissuerCountryId(Index: Integer; const Astring: string);
begin
  FissuerCountryId := Astring;
  FissuerCountryId_Specified := True;
end;

function TransactionResult2.issuerCountryId_Specified(Index: Integer): boolean;
begin
  Result := FissuerCountryId_Specified;
end;

procedure TransactionResult2.SettxnMac(Index: Integer; const Astring: string);
begin
  FtxnMac := Astring;
  FtxnMac_Specified := True;
end;

function TransactionResult2.txnMac_Specified(Index: Integer): boolean;
begin
  Result := FtxnMac_Specified;
end;

procedure TransactionResult2.Setcvc2ResultCode(Index: Integer; const Astring: string);
begin
  Fcvc2ResultCode := Astring;
  Fcvc2ResultCode_Specified := True;
end;

function TransactionResult2.cvc2ResultCode_Specified(Index: Integer): boolean;
begin
  Result := Fcvc2ResultCode_Specified;
end;

procedure TransactionResult2.SetriskRuleMatches(Index: Integer; const AArrayOfRiskRuleMatch: ArrayOfRiskRuleMatch);
begin
  FriskRuleMatches := AArrayOfRiskRuleMatch;
  FriskRuleMatches_Specified := True;
end;

function TransactionResult2.riskRuleMatches_Specified(Index: Integer): boolean;
begin
  Result := FriskRuleMatches_Specified;
end;

procedure TransactionResult2.SetextendedData(Index: Integer; const AArrayOfNameValueField: ArrayOfNameValueField);
begin
  FextendedData := AArrayOfNameValueField;
  FextendedData_Specified := True;
end;

function TransactionResult2.extendedData_Specified(Index: Integer): boolean;
begin
  Result := FextendedData_Specified;
end;

procedure riskRuleMatch.SetmatchedAmount(Index: Integer; const Astring: string);
begin
  FmatchedAmount := Astring;
  FmatchedAmount_Specified := True;
end;

function riskRuleMatch.matchedAmount_Specified(Index: Integer): boolean;
begin
  Result := FmatchedAmount_Specified;
end;

procedure riskRuleMatch.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function riskRuleMatch.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure riskRuleMatch.Settype_(Index: Integer; const Astring: string);
begin
  Ftype_ := Astring;
  Ftype__Specified := True;
end;

function riskRuleMatch.type__Specified(Index: Integer): boolean;
begin
  Result := Ftype__Specified;
end;

procedure riskRuleMatch.Setaction(Index: Integer; const Astring: string);
begin
  Faction := Astring;
  Faction_Specified := True;
end;

function riskRuleMatch.action_Specified(Index: Integer): boolean;
begin
  Result := Faction_Specified;
end;

procedure riskRuleMatch.SetincludedTransactions(Index: Integer; const Astring: string);
begin
  FincludedTransactions := Astring;
  FincludedTransactions_Specified := True;
end;

function riskRuleMatch.includedTransactions_Specified(Index: Integer): boolean;
begin
  Result := FincludedTransactions_Specified;
end;

procedure riskRuleMatch.SetamountLimit(Index: Integer; const Astring: string);
begin
  FamountLimit := Astring;
  FamountLimit_Specified := True;
end;

function riskRuleMatch.amountLimit_Specified(Index: Integer): boolean;
begin
  Result := FamountLimit_Specified;
end;

initialization
  { PaymentExpressWSSoap }
  InvRegistry.RegisterInterface(TypeInfo(PaymentExpressWSSoap), 'http://PaymentExpress.com', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(PaymentExpressWSSoap), 'http://PaymentExpress.com/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(PaymentExpressWSSoap), ioDocument);
  { PaymentExpressWSSoap.SubmitTransaction }
  InvRegistry.RegisterMethodInfo(TypeInfo(PaymentExpressWSSoap), 'SubmitTransaction', '',
                                 '[ReturnName="SubmitTransactionResult"]', IS_OPTN);
  { PaymentExpressWSSoap.SubmitTransaction2 }
  InvRegistry.RegisterMethodInfo(TypeInfo(PaymentExpressWSSoap), 'SubmitTransaction2', '',
                                 '[ReturnName="SubmitTransaction2Result"]', IS_OPTN);
  { PaymentExpressWSSoap.Check3dsEnrollment }
  InvRegistry.RegisterMethodInfo(TypeInfo(PaymentExpressWSSoap), 'Check3dsEnrollment', '',
                                 '[ReturnName="Check3dsEnrollmentResult"]', IS_OPTN);
  { PaymentExpressWSSoap.GetStatus }
  InvRegistry.RegisterMethodInfo(TypeInfo(PaymentExpressWSSoap), 'GetStatus', '',
                                 '[ReturnName="GetStatusResult"]', IS_OPTN);
  { PaymentExpressWSSoap.GetStatus2 }
  InvRegistry.RegisterMethodInfo(TypeInfo(PaymentExpressWSSoap), 'GetStatus2', '',
                                 '[ReturnName="GetStatus2Result"]', IS_OPTN);
  { PaymentExpressWSSoap.UpdateCard }
  InvRegistry.RegisterMethodInfo(TypeInfo(PaymentExpressWSSoap), 'UpdateCard', '',
                                 '[ReturnName="UpdateCardResult"]', IS_OPTN);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfNameValueField), 'http://PaymentExpress.com', 'ArrayOfNameValueField');
  RemClassRegistry.RegisterXSClass(TransactionDetails, 'http://PaymentExpress.com', 'TransactionDetails');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TransactionDetails), 'extendedData', '[ArrayItemName="NameValueField"]');
  RemClassRegistry.RegisterXSClass(NameValueField, 'http://PaymentExpress.com', 'NameValueField');
  RemClassRegistry.RegisterXSClass(EnrolmentCheckRequest, 'http://PaymentExpress.com', 'EnrolmentCheckRequest');
  RemClassRegistry.RegisterXSClass(EnrolmentCheckResult, 'http://PaymentExpress.com', 'EnrolmentCheckResult');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfRiskRuleMatch), 'http://PaymentExpress.com', 'ArrayOfRiskRuleMatch');
  RemClassRegistry.RegisterXSClass(TransactionResult2, 'http://PaymentExpress.com', 'TransactionResult2');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TransactionResult2), 'riskRuleMatches', '[ArrayItemName="riskRuleMatch"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(TransactionResult2), 'extendedData', '[ArrayItemName="NameValueField"]');
  RemClassRegistry.RegisterXSClass(riskRuleMatch, 'http://PaymentExpress.com', 'riskRuleMatch');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(riskRuleMatch), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(riskRuleMatch), 'type_', '[ExtName="type"]');

end.