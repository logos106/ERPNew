// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://ws.cert.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1?wsdl
//  >Import : https://ws.cert.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1?wsdl>0
//  >Import : https://ws.cert.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1?xsd=2
//  >Import : https://ws.cert.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1?wsdl>1
//  >Import : https://ws.cert.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1?xsd=3
//  >Import : https://ws.cert.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1?xsd=1
// Encoding : utf-8
// Version  : 1.0
// (15/12/2017 10:59:24 AM - - $Rev: 90173 $)
// ************************************************************************ //

unit MerchantWebServices_v1_Cert;

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
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  SettleTranRequest    = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[Lit][GblElm] }
  UpdtRecurrProfRequest = class;                { "http://postilion/realtime/merchantframework/xsd/v1/"[Lit][GblElm] }
  RecurProf            = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  FndRecurrProfRequest = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[Lit][GblElm] }
  RecurPmt             = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  Cust                 = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  BaseFaultType        = class;                 { "http://postilion/realtime/portal/soa/xsd/Faults/2009/01"[GblCplx] }
  SystemFault          = class;                 { "http://postilion/realtime/portal/soa/xsd/Faults/2009/01"[Flt][GblElm] }
  ServiceFault         = class;                 { "http://postilion/realtime/portal/soa/xsd/Faults/2009/01"[Flt][GblElm] }
  Pos                  = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  NameVal              = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  DriversLicense       = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  Identity             = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  AchEcheck            = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  AdditionalAmount     = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  SendTranRequest      = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[Lit][GblElm] }
  ProdData             = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  AchResponse          = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  RecurMan             = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  PmtCrta              = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  FndRecurrProfResponse = class;                { "http://postilion/realtime/merchantframework/xsd/v1/"[Lit][GblElm] }
  SendTranResponse     = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[Lit][GblElm] }
  SettleTranResponse   = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[Lit][GblElm] }
  RecurrProfFromTranResponse = class;           { "http://postilion/realtime/merchantframework/xsd/v1/"[Lit][GblElm] }
  UpdtRecurrProfResponse = class;               { "http://postilion/realtime/merchantframework/xsd/v1/"[Lit][GblElm] }
  RecurrProfFromTranRequest = class;            { "http://postilion/realtime/merchantframework/xsd/v1/"[Lit][GblElm] }
  Pmt                  = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  AuthRsp              = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  SettleData           = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  RecurProfCrta        = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  ProdCrta             = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  Prod                 = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  ProdInfo             = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  Tax                  = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  Recur                = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  CustCrta             = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  Merc                 = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  Ship                 = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  Phone2               = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  Contact              = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  BillShip             = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  TranData             = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  LineItem             = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  PurcCardTax          = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  Card                 = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  TranFlags            = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  AuthReq              = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }
  PurcCard             = class;                 { "http://postilion/realtime/merchantframework/xsd/v1/"[GblCplx] }

  {$SCOPEDENUMS ON}
  { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  cavvRslt = (
      _0, 
      _1, 
      _2, 
      _3, 
      _4, 
      _6, 
      _7, 
      _8, 
      _9, 
      A, 
      B, 
      C, 
      D
  );

  { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  blngCyc = (
      _0, 
      _10, 
      _20, 
      _30, 
      _40, 
      _50, 
      _51, 
      _52, 
      _60, 
      _70, 
      _80, 
      _90
  );

  { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  accountType = (
      _00, 
      _08, 
      _09, 
      _10, 
      _11, 
      _12, 
      _18, 
      _19, 
      _20, 
      _21, 
      _28, 
      _29, 
      _30, 
      _31, 
      _32, 
      _33, 
      _34, 
      _35, 
      _39, 
      _40, 
      _48, 
      _49, 
      _50, 
      _51, 
      _52, 
      _53, 
      _58, 
      _59, 
      _60, 
      _67, 
      _68, 
      _69, 
      _70, 
      _71, 
      _72, 
      _73, 
      _91, 
      _92
  );

  { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  amountType = (
      _00, 
      _01, 
      _02, 
      _05, 
      _20, 
      _40, 
      _53, 
      _57, 
      _80, 
      _81, 
      _90, 
      _91, 
      _3S, 
      _4S, 
      _4T, 
      _4U, 
      _4V, 
      _4W, 
      _4X
  );

  { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  tranCode = (
      _0, 
      _1, 
      _2, 
      _3, 
      _4, 
      _5, 
      _6, 
      _7, 
      _9, 
      _10, 
      _11, 
      _12, 
      _13, 
      _14, 
      _15, 
      _16, 
      _17, 
      _18
  );

  { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  state = (
      AL, 
      AK, 
      AS_, 
      AZ, 
      AR, 
      CA, 
      CO, 
      CT, 
      DE, 
      DC, 
      FM, 
      FL, 
      GA, 
      GU, 
      HI, 
      ID, 
      IL, 
      IN_, 
      IA, 
      KS, 
      KY, 
      LA, 
      ME, 
      MH, 
      MD, 
      MA, 
      MI, 
      MN, 
      MS, 
      MO, 
      MT, 
      NE, 
      NV, 
      NH, 
      NJ, 
      NM, 
      NY, 
      NC, 
      ND, 
      MP, 
      OH, 
      OK, 
      OR_, 
      PW, 
      PA, 
      PR, 
      RI, 
      SC, 
      SD, 
      TN, 
      TX, 
      UT, 
      VT, 
      VI, 
      VA, 
      WA, 
      WV, 
      WI, 
      WY
  );

  { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  state2 = (
      AL, 
      AK, 
      AS_, 
      AZ, 
      AR, 
      CA, 
      CO, 
      CT, 
      DE, 
      DC, 
      FM, 
      FL, 
      GA, 
      GU, 
      HI, 
      ID, 
      IL, 
      IN_, 
      IA, 
      KS, 
      KY, 
      LA, 
      ME, 
      MH, 
      MD, 
      MA, 
      MI, 
      MN, 
      MS, 
      MO, 
      MT, 
      NE, 
      NV, 
      NH, 
      NJ, 
      NM, 
      NY, 
      NC, 
      ND, 
      MP, 
      OH, 
      OK, 
      OR_, 
      PW, 
      PA, 
      PR, 
      RI, 
      SC, 
      SD, 
      TN, 
      TX, 
      UT, 
      VT, 
      VI, 
      VA, 
      WA, 
      WV, 
      WI, 
      WY
  );

  { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  state3 = (
      AL, 
      AK, 
      AS_, 
      AZ, 
      AR, 
      CA, 
      CO, 
      CT, 
      DE, 
      DC, 
      FM, 
      FL, 
      GA, 
      GU, 
      HI, 
      ID, 
      IL, 
      IN_, 
      IA, 
      KS, 
      KY, 
      LA, 
      ME, 
      MH, 
      MD, 
      MA, 
      MI, 
      MN, 
      MS, 
      MO, 
      MT, 
      NE, 
      NV, 
      NH, 
      NJ, 
      NM, 
      NY, 
      NC, 
      ND, 
      MP, 
      OH, 
      OK, 
      OR_, 
      PW, 
      PA, 
      PR, 
      RI, 
      SC, 
      SD, 
      TN, 
      TX, 
      UT, 
      VT, 
      VI, 
      VA, 
      WA, 
      WV, 
      WI, 
      WY
  );

  { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  dcnt = (Y, N);

  { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  sign = (C, D);

  {$SCOPEDENUMS OFF}

  id              =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  id2             =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  id3             =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  prodId          =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  id4             =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  custId          =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  pmtId           =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  prodId2         =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  pmtId2          =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  id5             =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  custId2         =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  custId3         =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  pmtId3          =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  id6             =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  Array_Of_AdditionalAmount = array of AdditionalAmount;   { "http://postilion/realtime/merchantframework/xsd/v1/"[GblUbnd] }
  Array_Of_SettleData = array of SettleData;    { "http://postilion/realtime/merchantframework/xsd/v1/"[GblUbnd] }


  // ************************************************************************ //
  // XML       : SettleTranRequest, global, <element>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  SettleTranRequest = class(TRemotable)
  private
    Fmerc: Merc;
    FsettleData: Array_Of_SettleData;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property merc:       Merc                 read Fmerc write Fmerc;
    property settleData: Array_Of_SettleData  Index (IS_UNBD) read FsettleData write FsettleData;
  end;

  Array_Of_ProdData = array of ProdData;        { "http://postilion/realtime/merchantframework/xsd/v1/"[GblUbnd] }


  // ************************************************************************ //
  // XML       : UpdtRecurrProfRequest, global, <element>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  UpdtRecurrProfRequest = class(TRemotable)
  private
    Fmerc: Merc;
    Fcust: Cust;
    Fcust_Specified: boolean;
    FrecurProf: RecurProf;
    FrecurProf_Specified: boolean;
    FprodData: Array_Of_ProdData;
    FprodData_Specified: boolean;
    procedure Setcust(Index: Integer; const ACust: Cust);
    function  cust_Specified(Index: Integer): boolean;
    procedure SetrecurProf(Index: Integer; const ARecurProf: RecurProf);
    function  recurProf_Specified(Index: Integer): boolean;
    procedure SetprodData(Index: Integer; const AArray_Of_ProdData: Array_Of_ProdData);
    function  prodData_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property merc:      Merc               read Fmerc write Fmerc;
    property cust:      Cust               Index (IS_OPTN) read Fcust write Setcust stored cust_Specified;
    property recurProf: RecurProf          Index (IS_OPTN) read FrecurProf write SetrecurProf stored recurProf_Specified;
    property prodData:  Array_Of_ProdData  Index (IS_OPTN or IS_UNBD) read FprodData write SetprodData stored prodData_Specified;
  end;

  Array_Of_pmtId = array of pmtId3;             { "http://postilion/realtime/merchantframework/xsd/v1/"[Ubnd] }
  Array_Of_Cust = array of Cust;                { "http://postilion/realtime/merchantframework/xsd/v1/"[GblUbnd] }
  Array_Of_RecurProf = array of RecurProf;      { "http://postilion/realtime/merchantframework/xsd/v1/"[GblUbnd] }
  Array_Of_prodId = array of prodId2;           { "http://postilion/realtime/merchantframework/xsd/v1/"[Ubnd] }
  Array_Of_pmtId2 = array of pmtId2;            { "http://postilion/realtime/merchantframework/xsd/v1/"[Ubnd] }
  Array_Of_Phone = array of Phone2;             { "http://postilion/realtime/merchantframework/xsd/v1/"[GblUbnd] }
  Array_Of_LineItem = array of LineItem;        { "http://postilion/realtime/merchantframework/xsd/v1/"[GblUbnd] }
  Array_Of_NameVal = array of NameVal;          { "http://postilion/realtime/merchantframework/xsd/v1/"[GblUbnd] }
  Array_Of_Pmt = array of Pmt;                  { "http://postilion/realtime/merchantframework/xsd/v1/"[GblUbnd] }
  Array_Of_PurcCardTax = array of PurcCardTax;   { "http://postilion/realtime/merchantframework/xsd/v1/"[GblUbnd] }
  Array_Of_ProdInfo = array of ProdInfo;        { "http://postilion/realtime/merchantframework/xsd/v1/"[GblUbnd] }
  pmtId4          =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  recurProfId     =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  id7             =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  id8             =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  invId           =  type Int64;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  inType          =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  prodType        =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  fraudChk        =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  type_           =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  checkNr         =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  type_2          =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  seccCode        =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  acctType        =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  indCode         =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  type_3          =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  type_4          =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : RecurProf, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  RecurProf = class(TRemotable)
  private
    FrecurProfId: recurProfId;
    FrecurProfId_Specified: boolean;
    Ftype_: type_4;
    Ftype__Specified: boolean;
    Frecur: Recur;
    Frecur_Specified: boolean;
    FprodData: Array_Of_ProdData;
    FprodData_Specified: boolean;
    procedure SetrecurProfId(Index: Integer; const ArecurProfId: recurProfId);
    function  recurProfId_Specified(Index: Integer): boolean;
    procedure Settype_(Index: Integer; const Atype_4: type_4);
    function  type__Specified(Index: Integer): boolean;
    procedure Setrecur(Index: Integer; const ARecur: Recur);
    function  recur_Specified(Index: Integer): boolean;
    procedure SetprodData(Index: Integer; const AArray_Of_ProdData: Array_Of_ProdData);
    function  prodData_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property recurProfId: recurProfId        Index (IS_OPTN) read FrecurProfId write SetrecurProfId stored recurProfId_Specified;
    property type_:       type_4             Index (IS_OPTN) read Ftype_ write Settype_ stored type__Specified;
    property recur:       Recur              Index (IS_OPTN) read Frecur write Setrecur stored recur_Specified;
    property prodData:    Array_Of_ProdData  Index (IS_OPTN or IS_UNBD) read FprodData write SetprodData stored prodData_Specified;
  end;

  seccCode2       =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  type_5          =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : FndRecurrProfRequest, global, <element>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  FndRecurrProfRequest = class(TRemotable)
  private
    Fmerc: Merc;
    Ftype_: type_5;
    Ftype__Specified: boolean;
    FrecurProfCrta: RecurProfCrta;
    FrecurProfCrta_Specified: boolean;
    FcustCrta: CustCrta;
    FcustCrta_Specified: boolean;
    FprodCrta: ProdCrta;
    FprodCrta_Specified: boolean;
    FpmtCrta: PmtCrta;
    FpmtCrta_Specified: boolean;
    procedure Settype_(Index: Integer; const Atype_5: type_5);
    function  type__Specified(Index: Integer): boolean;
    procedure SetrecurProfCrta(Index: Integer; const ARecurProfCrta: RecurProfCrta);
    function  recurProfCrta_Specified(Index: Integer): boolean;
    procedure SetcustCrta(Index: Integer; const ACustCrta: CustCrta);
    function  custCrta_Specified(Index: Integer): boolean;
    procedure SetprodCrta(Index: Integer; const AProdCrta: ProdCrta);
    function  prodCrta_Specified(Index: Integer): boolean;
    procedure SetpmtCrta(Index: Integer; const APmtCrta: PmtCrta);
    function  pmtCrta_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property merc:          Merc           read Fmerc write Fmerc;
    property type_:         type_5         Index (IS_OPTN) read Ftype_ write Settype_ stored type__Specified;
    property recurProfCrta: RecurProfCrta  Index (IS_OPTN) read FrecurProfCrta write SetrecurProfCrta stored recurProfCrta_Specified;
    property custCrta:      CustCrta       Index (IS_OPTN) read FcustCrta write SetcustCrta stored custCrta_Specified;
    property prodCrta:      ProdCrta       Index (IS_OPTN) read FprodCrta write SetprodCrta stored prodCrta_Specified;
    property pmtCrta:       PmtCrta        Index (IS_OPTN) read FpmtCrta write SetpmtCrta stored pmtCrta_Specified;
  end;

  status          =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  indCode2        =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  dbtOrCdt        =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  recurProfStat   =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  type_6          =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  nrOfPmtRem      =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  nrOfPmtProc     =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  indCode3        =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  nrOfPmt         =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  initRecurPmtIdcr =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  pmtFreq         =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  pmtNr           =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  nrOfPmt2        =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : RecurPmt, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  RecurPmt = class(TRemotable)
  private
    FpmtFreq: pmtFreq;
    FinitRecurPmtIdcr: initRecurPmtIdcr;
    FinitRecurPmtIdcr_Specified: boolean;
    FpmtNr: pmtNr;
    FpmtNr_Specified: boolean;
    FnrOfPmt: nrOfPmt2;
    FnrOfPmt_Specified: boolean;
    procedure SetinitRecurPmtIdcr(Index: Integer; const AinitRecurPmtIdcr: initRecurPmtIdcr);
    function  initRecurPmtIdcr_Specified(Index: Integer): boolean;
    procedure SetpmtNr(Index: Integer; const ApmtNr: pmtNr);
    function  pmtNr_Specified(Index: Integer): boolean;
    procedure SetnrOfPmt(Index: Integer; const AnrOfPmt2: nrOfPmt2);
    function  nrOfPmt_Specified(Index: Integer): boolean;
  published
    property pmtFreq:          pmtFreq           read FpmtFreq write FpmtFreq;
    property initRecurPmtIdcr: initRecurPmtIdcr  Index (IS_OPTN) read FinitRecurPmtIdcr write SetinitRecurPmtIdcr stored initRecurPmtIdcr_Specified;
    property pmtNr:            pmtNr             Index (IS_OPTN) read FpmtNr write SetpmtNr stored pmtNr_Specified;
    property nrOfPmt:          nrOfPmt2          Index (IS_OPTN) read FnrOfPmt write SetnrOfPmt stored nrOfPmt_Specified;
  end;

  stat            =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  itemNr          =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  stat2           =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  stat3           =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  idcr            =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  seccCode3       =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  type_7          =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Cust, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Cust = class(TRemotable)
  private
    Ftype_: type_7;
    Ftype__Specified: boolean;
    Fcontact: Contact;
    Fpmt: Array_Of_Pmt;
    Fpmt_Specified: boolean;
    procedure Settype_(Index: Integer; const Atype_7: type_7);
    function  type__Specified(Index: Integer): boolean;
    procedure Setpmt(Index: Integer; const AArray_Of_Pmt: Array_Of_Pmt);
    function  pmt_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property type_:   type_7        Index (IS_OPTN) read Ftype_ write Settype_ stored type__Specified;
    property contact: Contact       read Fcontact write Fcontact;
    property pmt:     Array_Of_Pmt  Index (IS_OPTN or IS_UNBD) read Fpmt write Setpmt stored pmt_Specified;
  end;



  // ************************************************************************ //
  // XML       : BaseFaultType, global, <complexType>
  // Namespace : http://postilion/realtime/portal/soa/xsd/Faults/2009/01
  // ************************************************************************ //
  BaseFaultType = class(TRemotable)
  private
    Fname_: string;
    Fmessage_: string;
    Fmessage__Specified: boolean;
    FerrorCode: string;
    procedure Setmessage_(Index: Integer; const Astring: string);
    function  message__Specified(Index: Integer): boolean;
  published
    property name_:     string  read Fname_ write Fname_;
    property message_:  string  Index (IS_OPTN) read Fmessage_ write Setmessage_ stored message__Specified;
    property errorCode: string  read FerrorCode write FerrorCode;
  end;



  // ************************************************************************ //
  // XML       : SystemFault, global, <element>
  // Namespace : http://postilion/realtime/portal/soa/xsd/Faults/2009/01
  // Info      : Fault
  // Base Types: BaseFaultType
  // ************************************************************************ //
  SystemFault = class(ERemotableException)
  private
    Fname_: string;
    Fmessage_: string;
    Fmessage__Specified: boolean;
    FerrorCode: string;
    procedure Setmessage_(Index: Integer; const Astring: string);
    function  message__Specified(Index: Integer): boolean;
  published
    property name_:     string  read Fname_ write Fname_;
    property message_:  string  Index (IS_OPTN) read Fmessage_ write Setmessage_ stored message__Specified;
    property errorCode: string  read FerrorCode write FerrorCode;
  end;



  // ************************************************************************ //
  // XML       : ServiceFault, global, <element>
  // Namespace : http://postilion/realtime/portal/soa/xsd/Faults/2009/01
  // Info      : Fault
  // Base Types: BaseFaultType
  // ************************************************************************ //
  ServiceFault = class(ERemotableException)
  private
    Fname_: string;
    Fmessage_: string;
    Fmessage__Specified: boolean;
    FerrorCode: string;
    procedure Setmessage_(Index: Integer; const Astring: string);
    function  message__Specified(Index: Integer): boolean;
  published
    property name_:     string  read Fname_ write Fname_;
    property message_:  string  Index (IS_OPTN) read Fmessage_ write Setmessage_ stored message__Specified;
    property errorCode: string  read FerrorCode write FerrorCode;
  end;

  lastName        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  firstName       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  coName          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  fullName        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  id9             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  phone           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  termId          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  storeNr         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  fiid            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  pmtDesc         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  mcc             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  dtBirth         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  pan             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  xprDt           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  sec             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  aba             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Pos, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Pos = class(TRemotable)
  private
    Fmcc: mcc;
    Fmcc_Specified: boolean;
    FstoreNr: storeNr;
    FstoreNr_Specified: boolean;
    FtermId: termId;
    FtermId_Specified: boolean;
    FpmtDesc: pmtDesc;
    FpmtDesc_Specified: boolean;
    FcustSvcPhNr: Phone2;
    FcustSvcPhNr_Specified: boolean;
    Ffiid: fiid;
    Ffiid_Specified: boolean;
    Faba: aba;
    Faba_Specified: boolean;
    procedure Setmcc(Index: Integer; const Amcc: mcc);
    function  mcc_Specified(Index: Integer): boolean;
    procedure SetstoreNr(Index: Integer; const AstoreNr: storeNr);
    function  storeNr_Specified(Index: Integer): boolean;
    procedure SettermId(Index: Integer; const AtermId: termId);
    function  termId_Specified(Index: Integer): boolean;
    procedure SetpmtDesc(Index: Integer; const ApmtDesc: pmtDesc);
    function  pmtDesc_Specified(Index: Integer): boolean;
    procedure SetcustSvcPhNr(Index: Integer; const APhone2: Phone2);
    function  custSvcPhNr_Specified(Index: Integer): boolean;
    procedure Setfiid(Index: Integer; const Afiid: fiid);
    function  fiid_Specified(Index: Integer): boolean;
    procedure Setaba(Index: Integer; const Aaba: aba);
    function  aba_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property mcc:         mcc      Index (IS_OPTN) read Fmcc write Setmcc stored mcc_Specified;
    property storeNr:     storeNr  Index (IS_OPTN) read FstoreNr write SetstoreNr stored storeNr_Specified;
    property termId:      termId   Index (IS_OPTN) read FtermId write SettermId stored termId_Specified;
    property pmtDesc:     pmtDesc  Index (IS_OPTN) read FpmtDesc write SetpmtDesc stored pmtDesc_Specified;
    property custSvcPhNr: Phone2   Index (IS_OPTN) read FcustSvcPhNr write SetcustSvcPhNr stored custSvcPhNr_Specified;
    property fiid:        fiid     Index (IS_OPTN) read Ffiid write Setfiid stored fiid_Specified;
    property aba:         aba      Index (IS_OPTN) read Faba write Setaba stored aba_Specified;
  end;

  val             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  name_           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : NameVal, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  NameVal = class(TRemotable)
  private
    Fname_: name_;
    Fval: val;
    Fval_Specified: boolean;
    procedure Setval(Index: Integer; const Aval: val);
    function  val_Specified(Index: Integer): boolean;
  published
    property name_: name_  read Fname_ write Fname_;
    property val:   val    Index (IS_OPTN) read Fval write Setval stored val_Specified;
  end;

  nr              =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  nr2             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : DriversLicense, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  DriversLicense = class(TRemotable)
  private
    Fstate: state;
    Fstate_Specified: boolean;
    Fnr: nr;
    procedure Setstate(Index: Integer; const Astate: state);
    function  state_Specified(Index: Integer): boolean;
  published
    property state: state  Index (IS_OPTN) read Fstate write Setstate stored state_Specified;
    property nr:    nr     read Fnr write Fnr;
  end;

  email           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  nr3             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  type_8          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Identity, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Identity = class(TRemotable)
  private
    Ftype_: type_8;
    Fnr: nr3;
  published
    property type_: type_8  read Ftype_ write Ftype_;
    property nr:    nr3     read Fnr write Fnr;
  end;

  acctNrEncrypt   =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  acctNr          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  bankName        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  achId           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  bankRtNr        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  achAcctInfo     =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : AchEcheck, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  AchEcheck = class(TRemotable)
  private
    FachId: achId;
    FachId_Specified: boolean;
    FachAcctInfo: achAcctInfo;
    FachAcctInfo_Specified: boolean;
    FbankRtNr: bankRtNr;
    FbankRtNr_Specified: boolean;
    FbankName: bankName;
    FbankName_Specified: boolean;
    FacctNr: acctNr;
    FacctNr_Specified: boolean;
    FacctNrEncrypt: acctNrEncrypt;
    FacctNrEncrypt_Specified: boolean;
    FacctType: acctType;
    FacctType_Specified: boolean;
    FseccCode: seccCode;
    FseccCode_Specified: boolean;
    FcheckNr: checkNr;
    FcheckNr_Specified: boolean;
    FfraudChk: fraudChk;
    FfraudChk_Specified: boolean;
    FdriversLicense: DriversLicense;
    FdriversLicense_Specified: boolean;
    Fidentity: Identity;
    Fidentity_Specified: boolean;
    FdtBirth: dtBirth;
    FdtBirth_Specified: boolean;
    procedure SetachId(Index: Integer; const AachId: achId);
    function  achId_Specified(Index: Integer): boolean;
    procedure SetachAcctInfo(Index: Integer; const AachAcctInfo: achAcctInfo);
    function  achAcctInfo_Specified(Index: Integer): boolean;
    procedure SetbankRtNr(Index: Integer; const AbankRtNr: bankRtNr);
    function  bankRtNr_Specified(Index: Integer): boolean;
    procedure SetbankName(Index: Integer; const AbankName: bankName);
    function  bankName_Specified(Index: Integer): boolean;
    procedure SetacctNr(Index: Integer; const AacctNr: acctNr);
    function  acctNr_Specified(Index: Integer): boolean;
    procedure SetacctNrEncrypt(Index: Integer; const AacctNrEncrypt: acctNrEncrypt);
    function  acctNrEncrypt_Specified(Index: Integer): boolean;
    procedure SetacctType(Index: Integer; const AacctType: acctType);
    function  acctType_Specified(Index: Integer): boolean;
    procedure SetseccCode(Index: Integer; const AseccCode: seccCode);
    function  seccCode_Specified(Index: Integer): boolean;
    procedure SetcheckNr(Index: Integer; const AcheckNr: checkNr);
    function  checkNr_Specified(Index: Integer): boolean;
    procedure SetfraudChk(Index: Integer; const AfraudChk: fraudChk);
    function  fraudChk_Specified(Index: Integer): boolean;
    procedure SetdriversLicense(Index: Integer; const ADriversLicense: DriversLicense);
    function  driversLicense_Specified(Index: Integer): boolean;
    procedure Setidentity(Index: Integer; const AIdentity: Identity);
    function  identity_Specified(Index: Integer): boolean;
    procedure SetdtBirth(Index: Integer; const AdtBirth: dtBirth);
    function  dtBirth_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property achId:          achId           Index (IS_OPTN) read FachId write SetachId stored achId_Specified;
    property achAcctInfo:    achAcctInfo     Index (IS_OPTN) read FachAcctInfo write SetachAcctInfo stored achAcctInfo_Specified;
    property bankRtNr:       bankRtNr        Index (IS_OPTN) read FbankRtNr write SetbankRtNr stored bankRtNr_Specified;
    property bankName:       bankName        Index (IS_OPTN) read FbankName write SetbankName stored bankName_Specified;
    property acctNr:         acctNr          Index (IS_OPTN) read FacctNr write SetacctNr stored acctNr_Specified;
    property acctNrEncrypt:  acctNrEncrypt   Index (IS_OPTN) read FacctNrEncrypt write SetacctNrEncrypt stored acctNrEncrypt_Specified;
    property acctType:       acctType        Index (IS_OPTN) read FacctType write SetacctType stored acctType_Specified;
    property seccCode:       seccCode        Index (IS_OPTN) read FseccCode write SetseccCode stored seccCode_Specified;
    property checkNr:        checkNr         Index (IS_OPTN) read FcheckNr write SetcheckNr stored checkNr_Specified;
    property fraudChk:       fraudChk        Index (IS_OPTN) read FfraudChk write SetfraudChk stored fraudChk_Specified;
    property driversLicense: DriversLicense  Index (IS_OPTN) read FdriversLicense write SetdriversLicense stored driversLicense_Specified;
    property identity:       Identity        Index (IS_OPTN) read Fidentity write Setidentity stored identity_Specified;
    property dtBirth:        dtBirth         Index (IS_OPTN) read FdtBirth write SetdtBirth stored dtBirth_Specified;
  end;

  amount          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  amountSign      =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  currencyCode    =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : AdditionalAmount, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  AdditionalAmount = class(TRemotable)
  private
    FaccountType: accountType;
    FamountType: amountType;
    FcurrencyCode: currencyCode;
    FamountSign: amountSign;
    Famount: amount;
  published
    property accountType:  accountType   read FaccountType write FaccountType;
    property amountType:   amountType    read FamountType write FamountType;
    property currencyCode: currencyCode  read FcurrencyCode write FcurrencyCode;
    property amountSign:   amountSign    read FamountSign write FamountSign;
    property amount:       amount        read Famount write Famount;
  end;

  Note            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  Array_Of_Note = array of Note;                { "http://postilion/realtime/merchantframework/xsd/v1/"[Ubnd] }
  rspCode         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  extRspCode      =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  goodsSoldCode   =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  prevSettleAmt   =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  reqAmt          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  deviceType      =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : SendTranRequest, global, <element>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  SendTranRequest = class(TRemotable)
  private
    Fmerc: Merc;
    FtranCode: tranCode;
    Fcard: Card;
    Fcard_Specified: boolean;
    Fcontact: Contact;
    Fcontact_Specified: boolean;
    FreqAmt: reqAmt;
    FreqAmt_Specified: boolean;
    FprevSettleAmt: prevSettleAmt;
    FprevSettleAmt_Specified: boolean;
    FlclDtTm: TXSDateTime;
    FlclDtTm_Specified: boolean;
    FusrDef: Array_Of_NameVal;
    FusrDef_Specified: boolean;
    Fpos: Pos;
    Fpos_Specified: boolean;
    FindCode: indCode;
    FindCode_Specified: boolean;
    FtranFlags: TranFlags;
    FtranFlags_Specified: boolean;
    FauthReq: AuthReq;
    FauthReq_Specified: boolean;
    ForigTranData: TranData;
    ForigTranData_Specified: boolean;
    FachEcheck: AchEcheck;
    FachEcheck_Specified: boolean;
    FrecurPmt: RecurPmt;
    FrecurPmt_Specified: boolean;
    FrecurMan: RecurMan;
    FrecurMan_Specified: boolean;
    Ftax: Tax;
    Ftax_Specified: boolean;
    FdeviceType: deviceType;
    FdeviceType_Specified: boolean;
    FgoodsSoldCode: goodsSoldCode;
    FgoodsSoldCode_Specified: boolean;
    procedure Setcard(Index: Integer; const ACard: Card);
    function  card_Specified(Index: Integer): boolean;
    procedure Setcontact(Index: Integer; const AContact: Contact);
    function  contact_Specified(Index: Integer): boolean;
    procedure SetreqAmt(Index: Integer; const AreqAmt: reqAmt);
    function  reqAmt_Specified(Index: Integer): boolean;
    procedure SetprevSettleAmt(Index: Integer; const AprevSettleAmt: prevSettleAmt);
    function  prevSettleAmt_Specified(Index: Integer): boolean;
    procedure SetlclDtTm(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  lclDtTm_Specified(Index: Integer): boolean;
    procedure SetusrDef(Index: Integer; const AArray_Of_NameVal: Array_Of_NameVal);
    function  usrDef_Specified(Index: Integer): boolean;
    procedure Setpos(Index: Integer; const APos: Pos);
    function  pos_Specified(Index: Integer): boolean;
    procedure SetindCode(Index: Integer; const AindCode: indCode);
    function  indCode_Specified(Index: Integer): boolean;
    procedure SettranFlags(Index: Integer; const ATranFlags: TranFlags);
    function  tranFlags_Specified(Index: Integer): boolean;
    procedure SetauthReq(Index: Integer; const AAuthReq: AuthReq);
    function  authReq_Specified(Index: Integer): boolean;
    procedure SetorigTranData(Index: Integer; const ATranData: TranData);
    function  origTranData_Specified(Index: Integer): boolean;
    procedure SetachEcheck(Index: Integer; const AAchEcheck: AchEcheck);
    function  achEcheck_Specified(Index: Integer): boolean;
    procedure SetrecurPmt(Index: Integer; const ARecurPmt: RecurPmt);
    function  recurPmt_Specified(Index: Integer): boolean;
    procedure SetrecurMan(Index: Integer; const ARecurMan: RecurMan);
    function  recurMan_Specified(Index: Integer): boolean;
    procedure Settax(Index: Integer; const ATax: Tax);
    function  tax_Specified(Index: Integer): boolean;
    procedure SetdeviceType(Index: Integer; const AdeviceType: deviceType);
    function  deviceType_Specified(Index: Integer): boolean;
    procedure SetgoodsSoldCode(Index: Integer; const AgoodsSoldCode: goodsSoldCode);
    function  goodsSoldCode_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property merc:          Merc              read Fmerc write Fmerc;
    property tranCode:      tranCode          read FtranCode write FtranCode;
    property card:          Card              Index (IS_OPTN) read Fcard write Setcard stored card_Specified;
    property contact:       Contact           Index (IS_OPTN) read Fcontact write Setcontact stored contact_Specified;
    property reqAmt:        reqAmt            Index (IS_OPTN) read FreqAmt write SetreqAmt stored reqAmt_Specified;
    property prevSettleAmt: prevSettleAmt     Index (IS_OPTN) read FprevSettleAmt write SetprevSettleAmt stored prevSettleAmt_Specified;
    property lclDtTm:       TXSDateTime       Index (IS_OPTN) read FlclDtTm write SetlclDtTm stored lclDtTm_Specified;
    property usrDef:        Array_Of_NameVal  Index (IS_OPTN or IS_UNBD) read FusrDef write SetusrDef stored usrDef_Specified;
    property pos:           Pos               Index (IS_OPTN) read Fpos write Setpos stored pos_Specified;
    property indCode:       indCode           Index (IS_OPTN) read FindCode write SetindCode stored indCode_Specified;
    property tranFlags:     TranFlags         Index (IS_OPTN) read FtranFlags write SettranFlags stored tranFlags_Specified;
    property authReq:       AuthReq           Index (IS_OPTN) read FauthReq write SetauthReq stored authReq_Specified;
    property origTranData:  TranData          Index (IS_OPTN) read ForigTranData write SetorigTranData stored origTranData_Specified;
    property achEcheck:     AchEcheck         Index (IS_OPTN) read FachEcheck write SetachEcheck stored achEcheck_Specified;
    property recurPmt:      RecurPmt          Index (IS_OPTN) read FrecurPmt write SetrecurPmt stored recurPmt_Specified;
    property recurMan:      RecurMan          Index (IS_OPTN) read FrecurMan write SetrecurMan stored recurMan_Specified;
    property tax:           Tax               Index (IS_OPTN) read Ftax write Settax stored tax_Specified;
    property deviceType:    deviceType        Index (IS_OPTN) read FdeviceType write SetdeviceType stored deviceType_Specified;
    property goodsSoldCode: goodsSoldCode     Index (IS_OPTN) read FgoodsSoldCode write SetgoodsSoldCode stored goodsSoldCode_Specified;
  end;

  Message_        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  quantity        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : ProdData, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  ProdData = class(TRemotable)
  private
    Fid: id7;
    Fid_Specified: boolean;
    Ftype_: type_3;
    Ftype__Specified: boolean;
    Fprod: Prod;
    Fprod_Specified: boolean;
    Fquantity: quantity;
    Fquantity_Specified: boolean;
    procedure Setid(Index: Integer; const Aid7: id7);
    function  id_Specified(Index: Integer): boolean;
    procedure Settype_(Index: Integer; const Atype_3: type_3);
    function  type__Specified(Index: Integer): boolean;
    procedure Setprod(Index: Integer; const AProd: Prod);
    function  prod_Specified(Index: Integer): boolean;
    procedure Setquantity(Index: Integer; const Aquantity: quantity);
    function  quantity_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property id:       id7       Index (IS_OPTN) read Fid write Setid stored id_Specified;
    property type_:    type_3    Index (IS_OPTN) read Ftype_ write Settype_ stored type__Specified;
    property prod:     Prod      Index (IS_OPTN) read Fprod write Setprod stored prod_Specified;
    property quantity: quantity  Index (IS_OPTN) read Fquantity write Setquantity stored quantity_Specified;
  end;

  pmtDesc2        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : AchResponse, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  AchResponse = class(TRemotable)
  private
    FMessage_: Message_;
    FMessage__Specified: boolean;
    FNote: Array_Of_Note;
    FNote_Specified: boolean;
    procedure SetMessage_(Index: Integer; const AMessage_: Message_);
    function  Message__Specified(Index: Integer): boolean;
    procedure SetNote(Index: Integer; const AArray_Of_Note: Array_Of_Note);
    function  Note_Specified(Index: Integer): boolean;
  published
    property Message_: Message_       Index (IS_OPTN) read FMessage_ write SetMessage_ stored Message__Specified;
    property Note:     Array_Of_Note  Index (IS_OPTN or IS_UNBD) read FNote write SetNote stored Note_Specified;
  end;

  ordNr           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  acctNr2         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  sec2            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : RecurMan, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  RecurMan = class(TRemotable)
  private
    Fid: id8;
    Fsec: sec2;
    Fsec_Specified: boolean;
    FseccCode: seccCode2;
    FseccCode_Specified: boolean;
    FprodInfo: Array_Of_ProdInfo;
    FprodInfo_Specified: boolean;
    procedure Setsec(Index: Integer; const Asec2: sec2);
    function  sec_Specified(Index: Integer): boolean;
    procedure SetseccCode(Index: Integer; const AseccCode2: seccCode2);
    function  seccCode_Specified(Index: Integer): boolean;
    procedure SetprodInfo(Index: Integer; const AArray_Of_ProdInfo: Array_Of_ProdInfo);
    function  prodInfo_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property id:       id8                read Fid write Fid;
    property sec:      sec2               Index (IS_OPTN) read Fsec write Setsec stored sec_Specified;
    property seccCode: seccCode2          Index (IS_OPTN) read FseccCode write SetseccCode stored seccCode_Specified;
    property prodInfo: Array_Of_ProdInfo  Index (IS_OPTN or IS_UNBD) read FprodInfo write SetprodInfo stored prodInfo_Specified;
  end;

  pan2            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : PmtCrta, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  PmtCrta = class(TRemotable)
  private
    Fpan: pan2;
    Fpan_Specified: boolean;
    FacctNr: acctNr2;
    FacctNr_Specified: boolean;
    FpmtId: pmtId4;
    FpmtId_Specified: boolean;
    FpmtDesc: pmtDesc2;
    FpmtDesc_Specified: boolean;
    FordNr: ordNr;
    FordNr_Specified: boolean;
    procedure Setpan(Index: Integer; const Apan2: pan2);
    function  pan_Specified(Index: Integer): boolean;
    procedure SetacctNr(Index: Integer; const AacctNr2: acctNr2);
    function  acctNr_Specified(Index: Integer): boolean;
    procedure SetpmtId(Index: Integer; const ApmtId4: pmtId4);
    function  pmtId_Specified(Index: Integer): boolean;
    procedure SetpmtDesc(Index: Integer; const ApmtDesc2: pmtDesc2);
    function  pmtDesc_Specified(Index: Integer): boolean;
    procedure SetordNr(Index: Integer; const AordNr: ordNr);
    function  ordNr_Specified(Index: Integer): boolean;
  published
    property pan:     pan2      Index (IS_OPTN) read Fpan write Setpan stored pan_Specified;
    property acctNr:  acctNr2   Index (IS_OPTN) read FacctNr write SetacctNr stored acctNr_Specified;
    property pmtId:   pmtId4    Index (IS_OPTN) read FpmtId write SetpmtId stored pmtId_Specified;
    property pmtDesc: pmtDesc2  Index (IS_OPTN) read FpmtDesc write SetpmtDesc stored pmtDesc_Specified;
    property ordNr:   ordNr     Index (IS_OPTN) read FordNr write SetordNr stored ordNr_Specified;
  end;

  cardType        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  mercId          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : FndRecurrProfResponse, global, <element>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  FndRecurrProfResponse = class(TRemotable)
  private
    Fid: Integer;
    Fid_Specified: boolean;
    FmercId: mercId;
    Fcust: Array_Of_Cust;
    Fcust_Specified: boolean;
    FrecurProf: Array_Of_RecurProf;
    FrecurProf_Specified: boolean;
    FprodData: Array_Of_ProdData;
    FprodData_Specified: boolean;
    procedure Setid(Index: Integer; const AInteger: Integer);
    function  id_Specified(Index: Integer): boolean;
    procedure Setcust(Index: Integer; const AArray_Of_Cust: Array_Of_Cust);
    function  cust_Specified(Index: Integer): boolean;
    procedure SetrecurProf(Index: Integer; const AArray_Of_RecurProf: Array_Of_RecurProf);
    function  recurProf_Specified(Index: Integer): boolean;
    procedure SetprodData(Index: Integer; const AArray_Of_ProdData: Array_Of_ProdData);
    function  prodData_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property id:        Integer             Index (IS_OPTN) read Fid write Setid stored id_Specified;
    property mercId:    mercId              read FmercId write FmercId;
    property cust:      Array_Of_Cust       Index (IS_OPTN or IS_UNBD) read Fcust write Setcust stored cust_Specified;
    property recurProf: Array_Of_RecurProf  Index (IS_OPTN or IS_UNBD) read FrecurProf write SetrecurProf stored recurProf_Specified;
    property prodData:  Array_Of_ProdData   Index (IS_OPTN or IS_UNBD) read FprodData write SetprodData stored prodData_Specified;
  end;

  mapCaid         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : SendTranResponse, global, <element>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  SendTranResponse = class(TRemotable)
  private
    FrspCode: rspCode;
    FextRspCode: extRspCode;
    FextRspCode_Specified: boolean;
    FauthRsp: AuthRsp;
    FauthRsp_Specified: boolean;
    FtranData: TranData;
    FtranData_Specified: boolean;
    FinvId: invId;
    FinvId_Specified: boolean;
    FcardType: cardType;
    FcardType_Specified: boolean;
    FmapCaid: mapCaid;
    FmapCaid_Specified: boolean;
    FadditionalAmount: Array_Of_AdditionalAmount;
    FadditionalAmount_Specified: boolean;
    FachResponse: AchResponse;
    FachResponse_Specified: boolean;
    Fmerc: Merc;
    Fmerc_Specified: boolean;
    FauthReq: AuthReq;
    FauthReq_Specified: boolean;
    FusrDef: Array_Of_NameVal;
    FusrDef_Specified: boolean;
    procedure SetextRspCode(Index: Integer; const AextRspCode: extRspCode);
    function  extRspCode_Specified(Index: Integer): boolean;
    procedure SetauthRsp(Index: Integer; const AAuthRsp: AuthRsp);
    function  authRsp_Specified(Index: Integer): boolean;
    procedure SettranData(Index: Integer; const ATranData: TranData);
    function  tranData_Specified(Index: Integer): boolean;
    procedure SetinvId(Index: Integer; const AinvId: invId);
    function  invId_Specified(Index: Integer): boolean;
    procedure SetcardType(Index: Integer; const AcardType: cardType);
    function  cardType_Specified(Index: Integer): boolean;
    procedure SetmapCaid(Index: Integer; const AmapCaid: mapCaid);
    function  mapCaid_Specified(Index: Integer): boolean;
    procedure SetadditionalAmount(Index: Integer; const AArray_Of_AdditionalAmount: Array_Of_AdditionalAmount);
    function  additionalAmount_Specified(Index: Integer): boolean;
    procedure SetachResponse(Index: Integer; const AAchResponse: AchResponse);
    function  achResponse_Specified(Index: Integer): boolean;
    procedure Setmerc(Index: Integer; const AMerc: Merc);
    function  merc_Specified(Index: Integer): boolean;
    procedure SetauthReq(Index: Integer; const AAuthReq: AuthReq);
    function  authReq_Specified(Index: Integer): boolean;
    procedure SetusrDef(Index: Integer; const AArray_Of_NameVal: Array_Of_NameVal);
    function  usrDef_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property rspCode:          rspCode                    read FrspCode write FrspCode;
    property extRspCode:       extRspCode                 Index (IS_OPTN) read FextRspCode write SetextRspCode stored extRspCode_Specified;
    property authRsp:          AuthRsp                    Index (IS_OPTN) read FauthRsp write SetauthRsp stored authRsp_Specified;
    property tranData:         TranData                   Index (IS_OPTN) read FtranData write SettranData stored tranData_Specified;
    property invId:            invId                      Index (IS_OPTN) read FinvId write SetinvId stored invId_Specified;
    property cardType:         cardType                   Index (IS_OPTN) read FcardType write SetcardType stored cardType_Specified;
    property mapCaid:          mapCaid                    Index (IS_OPTN) read FmapCaid write SetmapCaid stored mapCaid_Specified;
    property additionalAmount: Array_Of_AdditionalAmount  Index (IS_OPTN or IS_UNBD) read FadditionalAmount write SetadditionalAmount stored additionalAmount_Specified;
    property achResponse:      AchResponse                Index (IS_OPTN) read FachResponse write SetachResponse stored achResponse_Specified;
    property merc:             Merc                       Index (IS_OPTN) read Fmerc write Setmerc stored merc_Specified;
    property authReq:          AuthReq                    Index (IS_OPTN) read FauthReq write SetauthReq stored authReq_Specified;
    property usrDef:           Array_Of_NameVal           Index (IS_OPTN or IS_UNBD) read FusrDef write SetusrDef stored usrDef_Specified;
  end;

  rspCode2        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : SettleTranResponse, global, <element>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  SettleTranResponse = class(TRemotable)
  private
    FrspCode: rspCode2;
  public
    constructor Create; override;
  published
    property rspCode: rspCode2  read FrspCode write FrspCode;
  end;

  rspCode3        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : RecurrProfFromTranResponse, global, <element>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  RecurrProfFromTranResponse = class(TRemotable)
  private
    Fid: id5;
    Fid_Specified: boolean;
    FcustId: custId2;
    FcustId_Specified: boolean;
    FpmtId: Array_Of_pmtId2;
    FpmtId_Specified: boolean;
    FrspCode: rspCode3;
    FrspCode_Specified: boolean;
    procedure Setid(Index: Integer; const Aid5: id5);
    function  id_Specified(Index: Integer): boolean;
    procedure SetcustId(Index: Integer; const AcustId2: custId2);
    function  custId_Specified(Index: Integer): boolean;
    procedure SetpmtId(Index: Integer; const AArray_Of_pmtId2: Array_Of_pmtId2);
    function  pmtId_Specified(Index: Integer): boolean;
    procedure SetrspCode(Index: Integer; const ArspCode3: rspCode3);
    function  rspCode_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property id:      id5              Index (IS_OPTN) read Fid write Setid stored id_Specified;
    property custId:  custId2          Index (IS_OPTN) read FcustId write SetcustId stored custId_Specified;
    property pmtId:   Array_Of_pmtId2  Index (IS_OPTN or IS_UNBD) read FpmtId write SetpmtId stored pmtId_Specified;
    property rspCode: rspCode3         Index (IS_OPTN) read FrspCode write SetrspCode stored rspCode_Specified;
  end;

  rspCode4        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : UpdtRecurrProfResponse, global, <element>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  UpdtRecurrProfResponse = class(TRemotable)
  private
    Fid: id6;
    Fid_Specified: boolean;
    FcustId: custId3;
    FcustId_Specified: boolean;
    FpmtId: Array_Of_pmtId;
    FpmtId_Specified: boolean;
    FprodId: Array_Of_prodId;
    FprodId_Specified: boolean;
    FrspCode: rspCode4;
    FrspCode_Specified: boolean;
    procedure Setid(Index: Integer; const Aid6: id6);
    function  id_Specified(Index: Integer): boolean;
    procedure SetcustId(Index: Integer; const AcustId3: custId3);
    function  custId_Specified(Index: Integer): boolean;
    procedure SetpmtId(Index: Integer; const AArray_Of_pmtId: Array_Of_pmtId);
    function  pmtId_Specified(Index: Integer): boolean;
    procedure SetprodId(Index: Integer; const AArray_Of_prodId: Array_Of_prodId);
    function  prodId_Specified(Index: Integer): boolean;
    procedure SetrspCode(Index: Integer; const ArspCode4: rspCode4);
    function  rspCode_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
  published
    property id:      id6              Index (IS_OPTN) read Fid write Setid stored id_Specified;
    property custId:  custId3          Index (IS_OPTN) read FcustId write SetcustId stored custId_Specified;
    property pmtId:   Array_Of_pmtId   Index (IS_OPTN or IS_UNBD) read FpmtId write SetpmtId stored pmtId_Specified;
    property prodId:  Array_Of_prodId  Index (IS_OPTN or IS_UNBD) read FprodId write SetprodId stored prodId_Specified;
    property rspCode: rspCode4         Index (IS_OPTN) read FrspCode write SetrspCode stored rspCode_Specified;
  end;

  tranNr          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : RecurrProfFromTranRequest, global, <element>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  RecurrProfFromTranRequest = class(TRemotable)
  private
    Fmerc: Merc;
    FtranNr: tranNr;
    FrecurProf: RecurProf;
    FrecurProf_Specified: boolean;
    procedure SetrecurProf(Index: Integer; const ARecurProf: RecurProf);
    function  recurProf_Specified(Index: Integer): boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property merc:      Merc       read Fmerc write Fmerc;
    property tranNr:    tranNr     read FtranNr write FtranNr;
    property recurProf: RecurProf  Index (IS_OPTN) read FrecurProf write SetrecurProf stored recurProf_Specified;
  end;

  ordNr2          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  amt             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  desc            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  amt2            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  ordNr3          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  desc2           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  avsRslt         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  secRslt         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  aci             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  tranId          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  gwyTranId       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  mgdSettle       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  amt3            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Pmt, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Pmt = class(TRemotable)
  private
    Fid: id;
    Fid_Specified: boolean;
    Ftype_: type_6;
    Ftype__Specified: boolean;
    Fcard: Card;
    Fcard_Specified: boolean;
    FordNr: ordNr2;
    FordNr_Specified: boolean;
    Famt: amt;
    Famt_Specified: boolean;
    Ftax: Tax;
    Ftax_Specified: boolean;
    Fach: AchEcheck;
    Fach_Specified: boolean;
    Fdesc: desc;
    Fdesc_Specified: boolean;
    FindCode: indCode2;
    FindCode_Specified: boolean;
    Fstatus: status;
    Fstatus_Specified: boolean;
    procedure Setid(Index: Integer; const Aid: id);
    function  id_Specified(Index: Integer): boolean;
    procedure Settype_(Index: Integer; const Atype_6: type_6);
    function  type__Specified(Index: Integer): boolean;
    procedure Setcard(Index: Integer; const ACard: Card);
    function  card_Specified(Index: Integer): boolean;
    procedure SetordNr(Index: Integer; const AordNr2: ordNr2);
    function  ordNr_Specified(Index: Integer): boolean;
    procedure Setamt(Index: Integer; const Aamt: amt);
    function  amt_Specified(Index: Integer): boolean;
    procedure Settax(Index: Integer; const ATax: Tax);
    function  tax_Specified(Index: Integer): boolean;
    procedure Setach(Index: Integer; const AAchEcheck: AchEcheck);
    function  ach_Specified(Index: Integer): boolean;
    procedure Setdesc(Index: Integer; const Adesc: desc);
    function  desc_Specified(Index: Integer): boolean;
    procedure SetindCode(Index: Integer; const AindCode2: indCode2);
    function  indCode_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const Astatus: status);
    function  status_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property id:      id         Index (IS_OPTN) read Fid write Setid stored id_Specified;
    property type_:   type_6     Index (IS_OPTN) read Ftype_ write Settype_ stored type__Specified;
    property card:    Card       Index (IS_OPTN) read Fcard write Setcard stored card_Specified;
    property ordNr:   ordNr2     Index (IS_OPTN) read FordNr write SetordNr stored ordNr_Specified;
    property amt:     amt        Index (IS_OPTN) read Famt write Setamt stored amt_Specified;
    property tax:     Tax        Index (IS_OPTN) read Ftax write Settax stored tax_Specified;
    property ach:     AchEcheck  Index (IS_OPTN) read Fach write Setach stored ach_Specified;
    property desc:    desc       Index (IS_OPTN) read Fdesc write Setdesc stored desc_Specified;
    property indCode: indCode2   Index (IS_OPTN) read FindCode write SetindCode stored indCode_Specified;
    property status:  status     Index (IS_OPTN) read Fstatus write Setstatus stored status_Specified;
  end;

  valCode         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  issrNtwkId      =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  comCardType     =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : AuthRsp, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  AuthRsp = class(TRemotable)
  private
    FsecRslt: secRslt;
    FsecRslt_Specified: boolean;
    FavsRslt: avsRslt;
    FavsRslt_Specified: boolean;
    Faci: aci;
    Faci_Specified: boolean;
    FcavvRslt: cavvRslt;
    FcavvRslt_Specified: boolean;
    FtranId: tranId;
    FtranId_Specified: boolean;
    FgwyTranId: gwyTranId;
    FgwyTranId_Specified: boolean;
    FissrNtwkId: issrNtwkId;
    FissrNtwkId_Specified: boolean;
    FvalCode: valCode;
    FvalCode_Specified: boolean;
    FcomCardType: comCardType;
    FcomCardType_Specified: boolean;
    procedure SetsecRslt(Index: Integer; const AsecRslt: secRslt);
    function  secRslt_Specified(Index: Integer): boolean;
    procedure SetavsRslt(Index: Integer; const AavsRslt: avsRslt);
    function  avsRslt_Specified(Index: Integer): boolean;
    procedure Setaci(Index: Integer; const Aaci: aci);
    function  aci_Specified(Index: Integer): boolean;
    procedure SetcavvRslt(Index: Integer; const AcavvRslt: cavvRslt);
    function  cavvRslt_Specified(Index: Integer): boolean;
    procedure SettranId(Index: Integer; const AtranId: tranId);
    function  tranId_Specified(Index: Integer): boolean;
    procedure SetgwyTranId(Index: Integer; const AgwyTranId: gwyTranId);
    function  gwyTranId_Specified(Index: Integer): boolean;
    procedure SetissrNtwkId(Index: Integer; const AissrNtwkId: issrNtwkId);
    function  issrNtwkId_Specified(Index: Integer): boolean;
    procedure SetvalCode(Index: Integer; const AvalCode: valCode);
    function  valCode_Specified(Index: Integer): boolean;
    procedure SetcomCardType(Index: Integer; const AcomCardType: comCardType);
    function  comCardType_Specified(Index: Integer): boolean;
  published
    property secRslt:     secRslt      Index (IS_OPTN) read FsecRslt write SetsecRslt stored secRslt_Specified;
    property avsRslt:     avsRslt      Index (IS_OPTN) read FavsRslt write SetavsRslt stored avsRslt_Specified;
    property aci:         aci          Index (IS_OPTN) read Faci write Setaci stored aci_Specified;
    property cavvRslt:    cavvRslt     Index (IS_OPTN) read FcavvRslt write SetcavvRslt stored cavvRslt_Specified;
    property tranId:      tranId       Index (IS_OPTN) read FtranId write SettranId stored tranId_Specified;
    property gwyTranId:   gwyTranId    Index (IS_OPTN) read FgwyTranId write SetgwyTranId stored gwyTranId_Specified;
    property issrNtwkId:  issrNtwkId   Index (IS_OPTN) read FissrNtwkId write SetissrNtwkId stored issrNtwkId_Specified;
    property valCode:     valCode      Index (IS_OPTN) read FvalCode write SetvalCode stored valCode_Specified;
    property comCardType: comCardType  Index (IS_OPTN) read FcomCardType write SetcomCardType stored comCardType_Specified;
  end;

  tranNr2         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : SettleData, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  SettleData = class(TRemotable)
  private
    FtranNr: tranNr2;
    Famt: amt3;
    Famt_Specified: boolean;
    FmgdSettle: mgdSettle;
    FmgdSettle_Specified: boolean;
    procedure Setamt(Index: Integer; const Aamt3: amt3);
    function  amt_Specified(Index: Integer): boolean;
    procedure SetmgdSettle(Index: Integer; const AmgdSettle: mgdSettle);
    function  mgdSettle_Specified(Index: Integer): boolean;
  published
    property tranNr:    tranNr2    read FtranNr write FtranNr;
    property amt:       amt3       Index (IS_OPTN) read Famt write Setamt stored amt_Specified;
    property mgdSettle: mgdSettle  Index (IS_OPTN) read FmgdSettle write SetmgdSettle stored mgdSettle_Specified;
  end;

  prodName        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  taxPctg         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  unitOfMsr       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  desc3           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  price           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  ordNr4          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : RecurProfCrta, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  RecurProfCrta = class(TRemotable)
  private
    Fid: id3;
    Fid_Specified: boolean;
    FordNr: ordNr4;
    FordNr_Specified: boolean;
    procedure Setid(Index: Integer; const Aid3: id3);
    function  id_Specified(Index: Integer): boolean;
    procedure SetordNr(Index: Integer; const AordNr4: ordNr4);
    function  ordNr_Specified(Index: Integer): boolean;
  published
    property id:    id3     Index (IS_OPTN) read Fid write Setid stored id_Specified;
    property ordNr: ordNr4  Index (IS_OPTN) read FordNr write SetordNr stored ordNr_Specified;
  end;

  prodName2       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : ProdCrta, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  ProdCrta = class(TRemotable)
  private
    Fid: id2;
    Fid_Specified: boolean;
    Fstat: stat3;
    Fstat_Specified: boolean;
    FprodName: prodName2;
    FprodName_Specified: boolean;
    procedure Setid(Index: Integer; const Aid2: id2);
    function  id_Specified(Index: Integer): boolean;
    procedure Setstat(Index: Integer; const Astat3: stat3);
    function  stat_Specified(Index: Integer): boolean;
    procedure SetprodName(Index: Integer; const AprodName2: prodName2);
    function  prodName_Specified(Index: Integer): boolean;
  published
    property id:       id2        Index (IS_OPTN) read Fid write Setid stored id_Specified;
    property stat:     stat3      Index (IS_OPTN) read Fstat write Setstat stored stat_Specified;
    property prodName: prodName2  Index (IS_OPTN) read FprodName write SetprodName stored prodName_Specified;
  end;

  setupFee        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Prod, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Prod = class(TRemotable)
  private
    FprodName: prodName;
    FprodName_Specified: boolean;
    Fstat: stat2;
    FitemNr: itemNr;
    Fdesc: desc3;
    Fdesc_Specified: boolean;
    Fprice: price;
    Fprice_Specified: boolean;
    FtaxPctg: taxPctg;
    FtaxPctg_Specified: boolean;
    FunitOfMsr: unitOfMsr;
    FunitOfMsr_Specified: boolean;
    FsetupFee: setupFee;
    FsetupFee_Specified: boolean;
    procedure SetprodName(Index: Integer; const AprodName: prodName);
    function  prodName_Specified(Index: Integer): boolean;
    procedure Setdesc(Index: Integer; const Adesc3: desc3);
    function  desc_Specified(Index: Integer): boolean;
    procedure Setprice(Index: Integer; const Aprice: price);
    function  price_Specified(Index: Integer): boolean;
    procedure SettaxPctg(Index: Integer; const AtaxPctg: taxPctg);
    function  taxPctg_Specified(Index: Integer): boolean;
    procedure SetunitOfMsr(Index: Integer; const AunitOfMsr: unitOfMsr);
    function  unitOfMsr_Specified(Index: Integer): boolean;
    procedure SetsetupFee(Index: Integer; const AsetupFee: setupFee);
    function  setupFee_Specified(Index: Integer): boolean;
  published
    property prodName:  prodName   Index (IS_OPTN) read FprodName write SetprodName stored prodName_Specified;
    property stat:      stat2      read Fstat write Fstat;
    property itemNr:    itemNr     read FitemNr write FitemNr;
    property desc:      desc3      Index (IS_OPTN) read Fdesc write Setdesc stored desc_Specified;
    property price:     price      Index (IS_OPTN) read Fprice write Setprice stored price_Specified;
    property taxPctg:   taxPctg    Index (IS_OPTN) read FtaxPctg write SettaxPctg stored taxPctg_Specified;
    property unitOfMsr: unitOfMsr  Index (IS_OPTN) read FunitOfMsr write SetunitOfMsr stored unitOfMsr_Specified;
    property setupFee:  setupFee   Index (IS_OPTN) read FsetupFee write SetsetupFee stored setupFee_Specified;
  end;

  quantity2       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : ProdInfo, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  ProdInfo = class(TRemotable)
  private
    FprodId: prodId;
    Fquantity: quantity2;
  published
    property prodId:   prodId     read FprodId write FprodId;
    property quantity: quantity2  read Fquantity write Fquantity;
  end;

  amt4            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Tax, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Tax = class(TRemotable)
  private
    Fidcr: idcr;
    Famt: amt4;
    Famt_Specified: boolean;
    procedure Setamt(Index: Integer; const Aamt4: amt4);
    function  amt_Specified(Index: Integer): boolean;
  published
    property idcr: idcr  read Fidcr write Fidcr;
    property amt:  amt4  Index (IS_OPTN) read Famt write Setamt stored amt_Specified;
  end;

  shipToZipCode   =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  purcOrdNr       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  achAcctInfo2    =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Recur, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Recur = class(TRemotable)
  private
    FrecurProfStat: recurProfStat;
    FdbtOrCdt: dbtOrCdt;
    Famt: amt2;
    Famt_Specified: boolean;
    FnrOfPmt: nrOfPmt;
    FnrOfPmt_Specified: boolean;
    FstartDt: TXSDateTime;
    FblngCyc: blngCyc;
    Fdesc: desc2;
    Fdesc_Specified: boolean;
    FcustId: custId;
    FcustId_Specified: boolean;
    FpmtId: pmtId;
    FpmtId_Specified: boolean;
    FprodInfo: Array_Of_ProdInfo;
    FprodInfo_Specified: boolean;
    FnextProcDt: TXSDateTime;
    FnextProcDt_Specified: boolean;
    FnrOfPmtRem: nrOfPmtRem;
    FnrOfPmtRem_Specified: boolean;
    FnrOfPmtProc: nrOfPmtProc;
    FnrOfPmtProc_Specified: boolean;
    FindCode: indCode3;
    FindCode_Specified: boolean;
    FordNr: ordNr3;
    FordNr_Specified: boolean;
    FpurcOrdNr: purcOrdNr;
    FpurcOrdNr_Specified: boolean;
    FshipToZipCode: shipToZipCode;
    FshipToZipCode_Specified: boolean;
    FusrDef: Array_Of_NameVal;
    FusrDef_Specified: boolean;
    Ftax: Tax;
    Ftax_Specified: boolean;
    FseccCode: seccCode3;
    FseccCode_Specified: boolean;
    FachAcctInfo: achAcctInfo2;
    FachAcctInfo_Specified: boolean;
    procedure Setamt(Index: Integer; const Aamt2: amt2);
    function  amt_Specified(Index: Integer): boolean;
    procedure SetnrOfPmt(Index: Integer; const AnrOfPmt: nrOfPmt);
    function  nrOfPmt_Specified(Index: Integer): boolean;
    procedure Setdesc(Index: Integer; const Adesc2: desc2);
    function  desc_Specified(Index: Integer): boolean;
    procedure SetcustId(Index: Integer; const AcustId: custId);
    function  custId_Specified(Index: Integer): boolean;
    procedure SetpmtId(Index: Integer; const ApmtId: pmtId);
    function  pmtId_Specified(Index: Integer): boolean;
    procedure SetprodInfo(Index: Integer; const AArray_Of_ProdInfo: Array_Of_ProdInfo);
    function  prodInfo_Specified(Index: Integer): boolean;
    procedure SetnextProcDt(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  nextProcDt_Specified(Index: Integer): boolean;
    procedure SetnrOfPmtRem(Index: Integer; const AnrOfPmtRem: nrOfPmtRem);
    function  nrOfPmtRem_Specified(Index: Integer): boolean;
    procedure SetnrOfPmtProc(Index: Integer; const AnrOfPmtProc: nrOfPmtProc);
    function  nrOfPmtProc_Specified(Index: Integer): boolean;
    procedure SetindCode(Index: Integer; const AindCode3: indCode3);
    function  indCode_Specified(Index: Integer): boolean;
    procedure SetordNr(Index: Integer; const AordNr3: ordNr3);
    function  ordNr_Specified(Index: Integer): boolean;
    procedure SetpurcOrdNr(Index: Integer; const ApurcOrdNr: purcOrdNr);
    function  purcOrdNr_Specified(Index: Integer): boolean;
    procedure SetshipToZipCode(Index: Integer; const AshipToZipCode: shipToZipCode);
    function  shipToZipCode_Specified(Index: Integer): boolean;
    procedure SetusrDef(Index: Integer; const AArray_Of_NameVal: Array_Of_NameVal);
    function  usrDef_Specified(Index: Integer): boolean;
    procedure Settax(Index: Integer; const ATax: Tax);
    function  tax_Specified(Index: Integer): boolean;
    procedure SetseccCode(Index: Integer; const AseccCode3: seccCode3);
    function  seccCode_Specified(Index: Integer): boolean;
    procedure SetachAcctInfo(Index: Integer; const AachAcctInfo2: achAcctInfo2);
    function  achAcctInfo_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property recurProfStat: recurProfStat      read FrecurProfStat write FrecurProfStat;
    property dbtOrCdt:      dbtOrCdt           read FdbtOrCdt write FdbtOrCdt;
    property amt:           amt2               Index (IS_OPTN) read Famt write Setamt stored amt_Specified;
    property nrOfPmt:       nrOfPmt            Index (IS_OPTN) read FnrOfPmt write SetnrOfPmt stored nrOfPmt_Specified;
    property startDt:       TXSDateTime        read FstartDt write FstartDt;
    property blngCyc:       blngCyc            read FblngCyc write FblngCyc;
    property desc:          desc2              Index (IS_OPTN) read Fdesc write Setdesc stored desc_Specified;
    property custId:        custId             Index (IS_OPTN) read FcustId write SetcustId stored custId_Specified;
    property pmtId:         pmtId              Index (IS_OPTN) read FpmtId write SetpmtId stored pmtId_Specified;
    property prodInfo:      Array_Of_ProdInfo  Index (IS_OPTN or IS_UNBD) read FprodInfo write SetprodInfo stored prodInfo_Specified;
    property nextProcDt:    TXSDateTime        Index (IS_OPTN) read FnextProcDt write SetnextProcDt stored nextProcDt_Specified;
    property nrOfPmtRem:    nrOfPmtRem         Index (IS_OPTN) read FnrOfPmtRem write SetnrOfPmtRem stored nrOfPmtRem_Specified;
    property nrOfPmtProc:   nrOfPmtProc        Index (IS_OPTN) read FnrOfPmtProc write SetnrOfPmtProc stored nrOfPmtProc_Specified;
    property indCode:       indCode3           Index (IS_OPTN) read FindCode write SetindCode stored indCode_Specified;
    property ordNr:         ordNr3             Index (IS_OPTN) read FordNr write SetordNr stored ordNr_Specified;
    property purcOrdNr:     purcOrdNr          Index (IS_OPTN) read FpurcOrdNr write SetpurcOrdNr stored purcOrdNr_Specified;
    property shipToZipCode: shipToZipCode      Index (IS_OPTN) read FshipToZipCode write SetshipToZipCode stored shipToZipCode_Specified;
    property usrDef:        Array_Of_NameVal   Index (IS_OPTN or IS_UNBD) read FusrDef write SetusrDef stored usrDef_Specified;
    property tax:           Tax                Index (IS_OPTN) read Ftax write Settax stored tax_Specified;
    property seccCode:      seccCode3          Index (IS_OPTN) read FseccCode write SetseccCode stored seccCode_Specified;
    property achAcctInfo:   achAcctInfo2       Index (IS_OPTN) read FachAcctInfo write SetachAcctInfo stored achAcctInfo_Specified;
  end;

  firstName2      =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  coName2         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  fullName2       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  lastName2       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : CustCrta, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  CustCrta = class(TRemotable)
  private
    Fid: id4;
    Fid_Specified: boolean;
    FcoName: coName2;
    FcoName_Specified: boolean;
    FfirstName: firstName2;
    FfirstName_Specified: boolean;
    FlastName: lastName2;
    FlastName_Specified: boolean;
    FfullName: fullName2;
    FfullName_Specified: boolean;
    Fstat: stat;
    Fstat_Specified: boolean;
    procedure Setid(Index: Integer; const Aid4: id4);
    function  id_Specified(Index: Integer): boolean;
    procedure SetcoName(Index: Integer; const AcoName2: coName2);
    function  coName_Specified(Index: Integer): boolean;
    procedure SetfirstName(Index: Integer; const AfirstName2: firstName2);
    function  firstName_Specified(Index: Integer): boolean;
    procedure SetlastName(Index: Integer; const AlastName2: lastName2);
    function  lastName_Specified(Index: Integer): boolean;
    procedure SetfullName(Index: Integer; const AfullName2: fullName2);
    function  fullName_Specified(Index: Integer): boolean;
    procedure Setstat(Index: Integer; const Astat: stat);
    function  stat_Specified(Index: Integer): boolean;
  published
    property id:        id4         Index (IS_OPTN) read Fid write Setid stored id_Specified;
    property coName:    coName2     Index (IS_OPTN) read FcoName write SetcoName stored coName_Specified;
    property firstName: firstName2  Index (IS_OPTN) read FfirstName write SetfirstName stored firstName_Specified;
    property lastName:  lastName2   Index (IS_OPTN) read FlastName write SetlastName stored lastName_Specified;
    property fullName:  fullName2   Index (IS_OPTN) read FfullName write SetfullName stored fullName_Specified;
    property stat:      stat        Index (IS_OPTN) read Fstat write Setstat stored stat_Specified;
  end;

  usrId           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  pwd             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  id10            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  regKey          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Merc, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Merc = class(TRemotable)
  private
    Fid: id10;
    Fid_Specified: boolean;
    FregKey: regKey;
    FregKey_Specified: boolean;
    FusrId: usrId;
    FusrId_Specified: boolean;
    Fpwd: pwd;
    Fpwd_Specified: boolean;
    FinType: inType;
    FprodType: prodType;
    FprodType_Specified: boolean;
    procedure Setid(Index: Integer; const Aid10: id10);
    function  id_Specified(Index: Integer): boolean;
    procedure SetregKey(Index: Integer; const AregKey: regKey);
    function  regKey_Specified(Index: Integer): boolean;
    procedure SetusrId(Index: Integer; const AusrId: usrId);
    function  usrId_Specified(Index: Integer): boolean;
    procedure Setpwd(Index: Integer; const Apwd: pwd);
    function  pwd_Specified(Index: Integer): boolean;
    procedure SetprodType(Index: Integer; const AprodType: prodType);
    function  prodType_Specified(Index: Integer): boolean;
  published
    property id:       id10      Index (IS_OPTN) read Fid write Setid stored id_Specified;
    property regKey:   regKey    Index (IS_OPTN) read FregKey write SetregKey stored regKey_Specified;
    property usrId:    usrId     Index (IS_OPTN) read FusrId write SetusrId stored usrId_Specified;
    property pwd:      pwd       Index (IS_OPTN) read Fpwd write Setpwd stored pwd_Specified;
    property inType:   inType    read FinType write FinType;
    property prodType: prodType  Index (IS_OPTN) read FprodType write SetprodType stored prodType_Specified;
  end;

  title           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  fullName3       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  stat4           =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  note2           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  addrLn1         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  zipCode         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  addrLn2         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  city            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Ship, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Ship = class(TRemotable)
  private
    FfullName: fullName3;
    FfullName_Specified: boolean;
    FaddrLn1: addrLn1;
    FaddrLn1_Specified: boolean;
    FaddrLn2: addrLn2;
    FaddrLn2_Specified: boolean;
    Fcity: city;
    Fcity_Specified: boolean;
    Fstate: state2;
    Fstate_Specified: boolean;
    FzipCode: zipCode;
    FzipCode_Specified: boolean;
    Fphone: phone;
    Fphone_Specified: boolean;
    Femail: email;
    Femail_Specified: boolean;
    procedure SetfullName(Index: Integer; const AfullName3: fullName3);
    function  fullName_Specified(Index: Integer): boolean;
    procedure SetaddrLn1(Index: Integer; const AaddrLn1: addrLn1);
    function  addrLn1_Specified(Index: Integer): boolean;
    procedure SetaddrLn2(Index: Integer; const AaddrLn2: addrLn2);
    function  addrLn2_Specified(Index: Integer): boolean;
    procedure Setcity(Index: Integer; const Acity: city);
    function  city_Specified(Index: Integer): boolean;
    procedure Setstate(Index: Integer; const Astate2: state2);
    function  state_Specified(Index: Integer): boolean;
    procedure SetzipCode(Index: Integer; const AzipCode: zipCode);
    function  zipCode_Specified(Index: Integer): boolean;
    procedure Setphone(Index: Integer; const Aphone: phone);
    function  phone_Specified(Index: Integer): boolean;
    procedure Setemail(Index: Integer; const Aemail: email);
    function  email_Specified(Index: Integer): boolean;
  published
    property fullName: fullName3  Index (IS_OPTN) read FfullName write SetfullName stored fullName_Specified;
    property addrLn1:  addrLn1    Index (IS_OPTN) read FaddrLn1 write SetaddrLn1 stored addrLn1_Specified;
    property addrLn2:  addrLn2    Index (IS_OPTN) read FaddrLn2 write SetaddrLn2 stored addrLn2_Specified;
    property city:     city       Index (IS_OPTN) read Fcity write Setcity stored city_Specified;
    property state:    state2     Index (IS_OPTN) read Fstate write Setstate stored state_Specified;
    property zipCode:  zipCode    Index (IS_OPTN) read FzipCode write SetzipCode stored zipCode_Specified;
    property phone:    phone      Index (IS_OPTN) read Fphone write Setphone stored phone_Specified;
    property email:    email      Index (IS_OPTN) read Femail write Setemail stored email_Specified;
  end;

  addrLn22        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  city2           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Phone, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Phone2 = class(TRemotable)
  private
    Ftype_: type_2;
    Fnr: nr2;
  published
    property type_: type_2  read Ftype_ write Ftype_;
    property nr:    nr2     read Fnr write Fnr;
  end;

  addrLn12        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  email2          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  type_9          =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  zipCode2        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  ctry            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Contact, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Contact = class(TRemotable)
  private
    Fid: id9;
    Fid_Specified: boolean;
    FfirstName: firstName;
    FfirstName_Specified: boolean;
    FlastName: lastName;
    FlastName_Specified: boolean;
    FfullName: fullName;
    FfullName_Specified: boolean;
    FcoName: coName;
    FcoName_Specified: boolean;
    Ftitle: title;
    Ftitle_Specified: boolean;
    Fphone: Array_Of_Phone;
    Fphone_Specified: boolean;
    FaddrLn1: addrLn12;
    FaddrLn1_Specified: boolean;
    FaddrLn2: addrLn22;
    FaddrLn2_Specified: boolean;
    Fcity: city2;
    Fcity_Specified: boolean;
    Fstate: state3;
    Fstate_Specified: boolean;
    FzipCode: zipCode2;
    FzipCode_Specified: boolean;
    Fctry: ctry;
    Fctry_Specified: boolean;
    Femail: email2;
    Femail_Specified: boolean;
    Ftype_: type_9;
    Ftype__Specified: boolean;
    Fstat: stat4;
    Fstat_Specified: boolean;
    Fnote: note2;
    Fnote_Specified: boolean;
    Fship: Ship;
    Fship_Specified: boolean;
    procedure Setid(Index: Integer; const Aid9: id9);
    function  id_Specified(Index: Integer): boolean;
    procedure SetfirstName(Index: Integer; const AfirstName: firstName);
    function  firstName_Specified(Index: Integer): boolean;
    procedure SetlastName(Index: Integer; const AlastName: lastName);
    function  lastName_Specified(Index: Integer): boolean;
    procedure SetfullName(Index: Integer; const AfullName: fullName);
    function  fullName_Specified(Index: Integer): boolean;
    procedure SetcoName(Index: Integer; const AcoName: coName);
    function  coName_Specified(Index: Integer): boolean;
    procedure Settitle(Index: Integer; const Atitle: title);
    function  title_Specified(Index: Integer): boolean;
    procedure Setphone(Index: Integer; const AArray_Of_Phone: Array_Of_Phone);
    function  phone_Specified(Index: Integer): boolean;
    procedure SetaddrLn1(Index: Integer; const AaddrLn12: addrLn12);
    function  addrLn1_Specified(Index: Integer): boolean;
    procedure SetaddrLn2(Index: Integer; const AaddrLn22: addrLn22);
    function  addrLn2_Specified(Index: Integer): boolean;
    procedure Setcity(Index: Integer; const Acity2: city2);
    function  city_Specified(Index: Integer): boolean;
    procedure Setstate(Index: Integer; const Astate3: state3);
    function  state_Specified(Index: Integer): boolean;
    procedure SetzipCode(Index: Integer; const AzipCode2: zipCode2);
    function  zipCode_Specified(Index: Integer): boolean;
    procedure Setctry(Index: Integer; const Actry: ctry);
    function  ctry_Specified(Index: Integer): boolean;
    procedure Setemail(Index: Integer; const Aemail2: email2);
    function  email_Specified(Index: Integer): boolean;
    procedure Settype_(Index: Integer; const Atype_9: type_9);
    function  type__Specified(Index: Integer): boolean;
    procedure Setstat(Index: Integer; const Astat4: stat4);
    function  stat_Specified(Index: Integer): boolean;
    procedure Setnote(Index: Integer; const Anote2: note2);
    function  note_Specified(Index: Integer): boolean;
    procedure Setship(Index: Integer; const AShip: Ship);
    function  ship_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property id:        id9             Index (IS_OPTN) read Fid write Setid stored id_Specified;
    property firstName: firstName       Index (IS_OPTN) read FfirstName write SetfirstName stored firstName_Specified;
    property lastName:  lastName        Index (IS_OPTN) read FlastName write SetlastName stored lastName_Specified;
    property fullName:  fullName        Index (IS_OPTN) read FfullName write SetfullName stored fullName_Specified;
    property coName:    coName          Index (IS_OPTN) read FcoName write SetcoName stored coName_Specified;
    property title:     title           Index (IS_OPTN) read Ftitle write Settitle stored title_Specified;
    property phone:     Array_Of_Phone  Index (IS_OPTN or IS_UNBD) read Fphone write Setphone stored phone_Specified;
    property addrLn1:   addrLn12        Index (IS_OPTN) read FaddrLn1 write SetaddrLn1 stored addrLn1_Specified;
    property addrLn2:   addrLn22        Index (IS_OPTN) read FaddrLn2 write SetaddrLn2 stored addrLn2_Specified;
    property city:      city2           Index (IS_OPTN) read Fcity write Setcity stored city_Specified;
    property state:     state3          Index (IS_OPTN) read Fstate write Setstate stored state_Specified;
    property zipCode:   zipCode2        Index (IS_OPTN) read FzipCode write SetzipCode stored zipCode_Specified;
    property ctry:      ctry            Index (IS_OPTN) read Fctry write Setctry stored ctry_Specified;
    property email:     email2          Index (IS_OPTN) read Femail write Setemail stored email_Specified;
    property type_:     type_9          Index (IS_OPTN) read Ftype_ write Settype_ stored type__Specified;
    property stat:      stat4           Index (IS_OPTN) read Fstat write Setstat stored stat_Specified;
    property note:      note2           Index (IS_OPTN) read Fnote write Setnote stored note_Specified;
    property ship:      Ship            Index (IS_OPTN) read Fship write Setship stored ship_Specified;
  end;

  sqncNr          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  qty             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  qtyExp          =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  vatRefNr        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  desc4           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  unitOfMsr2      =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  dcntRt          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  dcntAmt         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  unitPrc         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  cmnt            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  privData        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  custCode        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  cmdyCode        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  itemNr2         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  prodCode        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  totAmt          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  type_10         =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : BillShip, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  BillShip = class(TRemotable)
  private
    Ftype_: type_10;
    Ftype__Specified: boolean;
    Fcontact: Contact;
    Fcontact_Specified: boolean;
    procedure Settype_(Index: Integer; const Atype_10: type_10);
    function  type__Specified(Index: Integer): boolean;
    procedure Setcontact(Index: Integer; const AContact: Contact);
    function  contact_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property type_:   type_10  Index (IS_OPTN) read Ftype_ write Settype_ stored type__Specified;
    property contact: Contact  Index (IS_OPTN) read Fcontact write Setcontact stored contact_Specified;
  end;

  rateExp         =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  cardAcptrId     =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  swchKey         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  stan            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  auth            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  tranNr3         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  amt5            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : TranData, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  TranData = class(TRemotable)
  private
    FswchKey: swchKey;
    FswchKey_Specified: boolean;
    FtranNr: tranNr3;
    FtranNr_Specified: boolean;
    FdtTm: TXSDateTime;
    FdtTm_Specified: boolean;
    Famt: amt5;
    Famt_Specified: boolean;
    Fstan: stan;
    Fstan_Specified: boolean;
    Fauth: auth;
    Fauth_Specified: boolean;
    procedure SetswchKey(Index: Integer; const AswchKey: swchKey);
    function  swchKey_Specified(Index: Integer): boolean;
    procedure SettranNr(Index: Integer; const AtranNr3: tranNr3);
    function  tranNr_Specified(Index: Integer): boolean;
    procedure SetdtTm(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  dtTm_Specified(Index: Integer): boolean;
    procedure Setamt(Index: Integer; const Aamt5: amt5);
    function  amt_Specified(Index: Integer): boolean;
    procedure Setstan(Index: Integer; const Astan: stan);
    function  stan_Specified(Index: Integer): boolean;
    procedure Setauth(Index: Integer; const Aauth: auth);
    function  auth_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property swchKey: swchKey      Index (IS_OPTN) read FswchKey write SetswchKey stored swchKey_Specified;
    property tranNr:  tranNr3      Index (IS_OPTN) read FtranNr write SettranNr stored tranNr_Specified;
    property dtTm:    TXSDateTime  Index (IS_OPTN) read FdtTm write SetdtTm stored dtTm_Specified;
    property amt:     amt5         Index (IS_OPTN) read Famt write Setamt stored amt_Specified;
    property stan:    stan         Index (IS_OPTN) read Fstan write Setstan stored stan_Specified;
    property auth:    auth         Index (IS_OPTN) read Fauth write Setauth stored auth_Specified;
  end;

  privData2       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  totAmtType      =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  supType         =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : LineItem, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  LineItem = class(TRemotable)
  private
    FitemNr: itemNr2;
    FitemNr_Specified: boolean;
    FprodCode: prodCode;
    FprodCode_Specified: boolean;
    FcustCode: custCode;
    FcustCode_Specified: boolean;
    FcmdyCode: cmdyCode;
    FcmdyCode_Specified: boolean;
    FvatRefNr: vatRefNr;
    FvatRefNr_Specified: boolean;
    Fdesc: desc4;
    Fdesc_Specified: boolean;
    Fqty: qty;
    Fqty_Specified: boolean;
    FqtyExp: qtyExp;
    FqtyExp_Specified: boolean;
    FunitOfMsr: unitOfMsr2;
    FunitOfMsr_Specified: boolean;
    FunitPrc: unitPrc;
    FunitPrc_Specified: boolean;
    Fdcnt: dcnt;
    Fdcnt_Specified: boolean;
    FdcntRt: dcntRt;
    FdcntRt_Specified: boolean;
    FdcntAmt: dcntAmt;
    FdcntAmt_Specified: boolean;
    FtotAmt: totAmt;
    FtotAmt_Specified: boolean;
    FtotAmtType: totAmtType;
    FtotAmtType_Specified: boolean;
    FsupType: supType;
    FsupType_Specified: boolean;
    Fsign: sign;
    Fsign_Specified: boolean;
    FprivData: privData2;
    FprivData_Specified: boolean;
    Ftax: Array_Of_PurcCardTax;
    Ftax_Specified: boolean;
    procedure SetitemNr(Index: Integer; const AitemNr2: itemNr2);
    function  itemNr_Specified(Index: Integer): boolean;
    procedure SetprodCode(Index: Integer; const AprodCode: prodCode);
    function  prodCode_Specified(Index: Integer): boolean;
    procedure SetcustCode(Index: Integer; const AcustCode: custCode);
    function  custCode_Specified(Index: Integer): boolean;
    procedure SetcmdyCode(Index: Integer; const AcmdyCode: cmdyCode);
    function  cmdyCode_Specified(Index: Integer): boolean;
    procedure SetvatRefNr(Index: Integer; const AvatRefNr: vatRefNr);
    function  vatRefNr_Specified(Index: Integer): boolean;
    procedure Setdesc(Index: Integer; const Adesc4: desc4);
    function  desc_Specified(Index: Integer): boolean;
    procedure Setqty(Index: Integer; const Aqty: qty);
    function  qty_Specified(Index: Integer): boolean;
    procedure SetqtyExp(Index: Integer; const AqtyExp: qtyExp);
    function  qtyExp_Specified(Index: Integer): boolean;
    procedure SetunitOfMsr(Index: Integer; const AunitOfMsr2: unitOfMsr2);
    function  unitOfMsr_Specified(Index: Integer): boolean;
    procedure SetunitPrc(Index: Integer; const AunitPrc: unitPrc);
    function  unitPrc_Specified(Index: Integer): boolean;
    procedure Setdcnt(Index: Integer; const Adcnt: dcnt);
    function  dcnt_Specified(Index: Integer): boolean;
    procedure SetdcntRt(Index: Integer; const AdcntRt: dcntRt);
    function  dcntRt_Specified(Index: Integer): boolean;
    procedure SetdcntAmt(Index: Integer; const AdcntAmt: dcntAmt);
    function  dcntAmt_Specified(Index: Integer): boolean;
    procedure SettotAmt(Index: Integer; const AtotAmt: totAmt);
    function  totAmt_Specified(Index: Integer): boolean;
    procedure SettotAmtType(Index: Integer; const AtotAmtType: totAmtType);
    function  totAmtType_Specified(Index: Integer): boolean;
    procedure SetsupType(Index: Integer; const AsupType: supType);
    function  supType_Specified(Index: Integer): boolean;
    procedure Setsign(Index: Integer; const Asign: sign);
    function  sign_Specified(Index: Integer): boolean;
    procedure SetprivData(Index: Integer; const AprivData2: privData2);
    function  privData_Specified(Index: Integer): boolean;
    procedure Settax(Index: Integer; const AArray_Of_PurcCardTax: Array_Of_PurcCardTax);
    function  tax_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property itemNr:     itemNr2               Index (IS_OPTN) read FitemNr write SetitemNr stored itemNr_Specified;
    property prodCode:   prodCode              Index (IS_OPTN) read FprodCode write SetprodCode stored prodCode_Specified;
    property custCode:   custCode              Index (IS_OPTN) read FcustCode write SetcustCode stored custCode_Specified;
    property cmdyCode:   cmdyCode              Index (IS_OPTN) read FcmdyCode write SetcmdyCode stored cmdyCode_Specified;
    property vatRefNr:   vatRefNr              Index (IS_OPTN) read FvatRefNr write SetvatRefNr stored vatRefNr_Specified;
    property desc:       desc4                 Index (IS_OPTN) read Fdesc write Setdesc stored desc_Specified;
    property qty:        qty                   Index (IS_OPTN) read Fqty write Setqty stored qty_Specified;
    property qtyExp:     qtyExp                Index (IS_OPTN) read FqtyExp write SetqtyExp stored qtyExp_Specified;
    property unitOfMsr:  unitOfMsr2            Index (IS_OPTN) read FunitOfMsr write SetunitOfMsr stored unitOfMsr_Specified;
    property unitPrc:    unitPrc               Index (IS_OPTN) read FunitPrc write SetunitPrc stored unitPrc_Specified;
    property dcnt:       dcnt                  Index (IS_OPTN) read Fdcnt write Setdcnt stored dcnt_Specified;
    property dcntRt:     dcntRt                Index (IS_OPTN) read FdcntRt write SetdcntRt stored dcntRt_Specified;
    property dcntAmt:    dcntAmt               Index (IS_OPTN) read FdcntAmt write SetdcntAmt stored dcntAmt_Specified;
    property totAmt:     totAmt                Index (IS_OPTN) read FtotAmt write SettotAmt stored totAmt_Specified;
    property totAmtType: totAmtType            Index (IS_OPTN) read FtotAmtType write SettotAmtType stored totAmtType_Specified;
    property supType:    supType               Index (IS_OPTN) read FsupType write SetsupType stored supType_Specified;
    property sign:       sign                  Index (IS_OPTN) read Fsign write Setsign stored sign_Specified;
    property privData:   privData2             Index (IS_OPTN) read FprivData write SetprivData stored privData_Specified;
    property tax:        Array_Of_PurcCardTax  Index (IS_OPTN or IS_UNBD) read Ftax write Settax stored tax_Specified;
  end;

  type_11         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  amt6            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  rate            =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  desc5           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  incld           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : PurcCardTax, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  PurcCardTax = class(TRemotable)
  private
    Ftype_: type_11;
    Ftype__Specified: boolean;
    Fdesc: desc5;
    Fdesc_Specified: boolean;
    Fincld: incld;
    Fincld_Specified: boolean;
    Famt: amt6;
    Famt_Specified: boolean;
    Frate: rate;
    Frate_Specified: boolean;
    FrateExp: rateExp;
    FrateExp_Specified: boolean;
    FcardAcptrId: cardAcptrId;
    FcardAcptrId_Specified: boolean;
    procedure Settype_(Index: Integer; const Atype_11: type_11);
    function  type__Specified(Index: Integer): boolean;
    procedure Setdesc(Index: Integer; const Adesc5: desc5);
    function  desc_Specified(Index: Integer): boolean;
    procedure Setincld(Index: Integer; const Aincld: incld);
    function  incld_Specified(Index: Integer): boolean;
    procedure Setamt(Index: Integer; const Aamt6: amt6);
    function  amt_Specified(Index: Integer): boolean;
    procedure Setrate(Index: Integer; const Arate: rate);
    function  rate_Specified(Index: Integer): boolean;
    procedure SetrateExp(Index: Integer; const ArateExp: rateExp);
    function  rateExp_Specified(Index: Integer): boolean;
    procedure SetcardAcptrId(Index: Integer; const AcardAcptrId: cardAcptrId);
    function  cardAcptrId_Specified(Index: Integer): boolean;
  published
    property type_:       type_11      Index (IS_OPTN) read Ftype_ write Settype_ stored type__Specified;
    property desc:        desc5        Index (IS_OPTN) read Fdesc write Setdesc stored desc_Specified;
    property incld:       incld        Index (IS_OPTN) read Fincld write Setincld stored incld_Specified;
    property amt:         amt6         Index (IS_OPTN) read Famt write Setamt stored amt_Specified;
    property rate:        rate         Index (IS_OPTN) read Frate write Setrate stored rate_Specified;
    property rateExp:     rateExp      Index (IS_OPTN) read FrateExp write SetrateExp stored rateExp_Specified;
    property cardAcptrId: cardAcptrId  Index (IS_OPTN) read FcardAcptrId write SetcardAcptrId stored cardAcptrId_Specified;
  end;

  totAmt2         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  cavv            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  ucafIdcr        =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  xid             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  ucaf            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  voiceAuthCode   =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  ordNr5          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  eSign           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  dbtOrCdt2       =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  trk1            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  trk2            =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : Card, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  Card = class(TRemotable)
  private
    Ftype_: type_;
    Ftype__Specified: boolean;
    Fpan: pan;
    Fpan_Specified: boolean;
    Fsec: sec;
    Fsec_Specified: boolean;
    FxprDt: xprDt;
    FxprDt_Specified: boolean;
    FsqncNr: sqncNr;
    FsqncNr_Specified: boolean;
    Ftrk1: trk1;
    Ftrk1_Specified: boolean;
    Ftrk2: trk2;
    Ftrk2_Specified: boolean;
    FdbtOrCdt: dbtOrCdt2;
    FdbtOrCdt_Specified: boolean;
    procedure Settype_(Index: Integer; const Atype_: type_);
    function  type__Specified(Index: Integer): boolean;
    procedure Setpan(Index: Integer; const Apan: pan);
    function  pan_Specified(Index: Integer): boolean;
    procedure Setsec(Index: Integer; const Asec: sec);
    function  sec_Specified(Index: Integer): boolean;
    procedure SetxprDt(Index: Integer; const AxprDt: xprDt);
    function  xprDt_Specified(Index: Integer): boolean;
    procedure SetsqncNr(Index: Integer; const AsqncNr: sqncNr);
    function  sqncNr_Specified(Index: Integer): boolean;
    procedure Settrk1(Index: Integer; const Atrk1: trk1);
    function  trk1_Specified(Index: Integer): boolean;
    procedure Settrk2(Index: Integer; const Atrk2: trk2);
    function  trk2_Specified(Index: Integer): boolean;
    procedure SetdbtOrCdt(Index: Integer; const AdbtOrCdt2: dbtOrCdt2);
    function  dbtOrCdt_Specified(Index: Integer): boolean;
  published
    property type_:    type_      Index (IS_OPTN) read Ftype_ write Settype_ stored type__Specified;
    property pan:      pan        Index (IS_OPTN) read Fpan write Setpan stored pan_Specified;
    property sec:      sec        Index (IS_OPTN) read Fsec write Setsec stored sec_Specified;
    property xprDt:    xprDt      Index (IS_OPTN) read FxprDt write SetxprDt stored xprDt_Specified;
    property sqncNr:   sqncNr     Index (IS_OPTN) read FsqncNr write SetsqncNr stored sqncNr_Specified;
    property trk1:     trk1       Index (IS_OPTN) read Ftrk1 write Settrk1 stored trk1_Specified;
    property trk2:     trk2       Index (IS_OPTN) read Ftrk2 write Settrk2 stored trk2_Specified;
    property dbtOrCdt: dbtOrCdt2  Index (IS_OPTN) read FdbtOrCdt write SetdbtOrCdt stored dbtOrCdt_Specified;
  end;

  dupChkTmPrd     =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  mgdSettle2      =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  convFeeAcptd    =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  revAuthOnVoid   =  type Integer;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  rsbmt           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : TranFlags, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  TranFlags = class(TRemotable)
  private
    FdupChkTmPrd: dupChkTmPrd;
    FdupChkTmPrd_Specified: boolean;
    FrevAuthOnVoid: revAuthOnVoid;
    FrevAuthOnVoid_Specified: boolean;
    Frsbmt: rsbmt;
    Frsbmt_Specified: boolean;
    FmgdSettle: mgdSettle2;
    FmgdSettle_Specified: boolean;
    FconvFeeAcptd: convFeeAcptd;
    FconvFeeAcptd_Specified: boolean;
    procedure SetdupChkTmPrd(Index: Integer; const AdupChkTmPrd: dupChkTmPrd);
    function  dupChkTmPrd_Specified(Index: Integer): boolean;
    procedure SetrevAuthOnVoid(Index: Integer; const ArevAuthOnVoid: revAuthOnVoid);
    function  revAuthOnVoid_Specified(Index: Integer): boolean;
    procedure Setrsbmt(Index: Integer; const Arsbmt: rsbmt);
    function  rsbmt_Specified(Index: Integer): boolean;
    procedure SetmgdSettle(Index: Integer; const AmgdSettle2: mgdSettle2);
    function  mgdSettle_Specified(Index: Integer): boolean;
    procedure SetconvFeeAcptd(Index: Integer; const AconvFeeAcptd: convFeeAcptd);
    function  convFeeAcptd_Specified(Index: Integer): boolean;
  published
    property dupChkTmPrd:   dupChkTmPrd    Index (IS_OPTN) read FdupChkTmPrd write SetdupChkTmPrd stored dupChkTmPrd_Specified;
    property revAuthOnVoid: revAuthOnVoid  Index (IS_OPTN) read FrevAuthOnVoid write SetrevAuthOnVoid stored revAuthOnVoid_Specified;
    property rsbmt:         rsbmt          Index (IS_OPTN) read Frsbmt write Setrsbmt stored rsbmt_Specified;
    property mgdSettle:     mgdSettle2     Index (IS_OPTN) read FmgdSettle write SetmgdSettle stored mgdSettle_Specified;
    property convFeeAcptd:  convFeeAcptd   Index (IS_OPTN) read FconvFeeAcptd write SetconvFeeAcptd stored convFeeAcptd_Specified;
  end;

  vchrNr          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  taxExmp         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  cmdyCode2       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  custBlngCode    =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  custOrdNr       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  desc6           =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  dutyAmt         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  taxColld        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  dcntAmt2        =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  shpAmt          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  cardAcptrTaxId  =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  cardAcptrVatNr  =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  pin             =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : AuthReq, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  AuthReq = class(TRemotable)
  private
    Fxid: xid;
    Fxid_Specified: boolean;
    Fcavv: cavv;
    Fcavv_Specified: boolean;
    FucafIdcr: ucafIdcr;
    FucafIdcr_Specified: boolean;
    Fucaf: ucaf;
    Fucaf_Specified: boolean;
    FpurcCard: PurcCard;
    FpurcCard_Specified: boolean;
    FeSign: eSign;
    FeSign_Specified: boolean;
    FvoiceAuthCode: voiceAuthCode;
    FvoiceAuthCode_Specified: boolean;
    FordNr: ordNr5;
    FordNr_Specified: boolean;
    FvchrNr: vchrNr;
    FvchrNr_Specified: boolean;
    Fpin: pin;
    Fpin_Specified: boolean;
    procedure Setxid(Index: Integer; const Axid: xid);
    function  xid_Specified(Index: Integer): boolean;
    procedure Setcavv(Index: Integer; const Acavv: cavv);
    function  cavv_Specified(Index: Integer): boolean;
    procedure SetucafIdcr(Index: Integer; const AucafIdcr: ucafIdcr);
    function  ucafIdcr_Specified(Index: Integer): boolean;
    procedure Setucaf(Index: Integer; const Aucaf: ucaf);
    function  ucaf_Specified(Index: Integer): boolean;
    procedure SetpurcCard(Index: Integer; const APurcCard: PurcCard);
    function  purcCard_Specified(Index: Integer): boolean;
    procedure SeteSign(Index: Integer; const AeSign: eSign);
    function  eSign_Specified(Index: Integer): boolean;
    procedure SetvoiceAuthCode(Index: Integer; const AvoiceAuthCode: voiceAuthCode);
    function  voiceAuthCode_Specified(Index: Integer): boolean;
    procedure SetordNr(Index: Integer; const AordNr5: ordNr5);
    function  ordNr_Specified(Index: Integer): boolean;
    procedure SetvchrNr(Index: Integer; const AvchrNr: vchrNr);
    function  vchrNr_Specified(Index: Integer): boolean;
    procedure Setpin(Index: Integer; const Apin: pin);
    function  pin_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property xid:           xid            Index (IS_OPTN) read Fxid write Setxid stored xid_Specified;
    property cavv:          cavv           Index (IS_OPTN) read Fcavv write Setcavv stored cavv_Specified;
    property ucafIdcr:      ucafIdcr       Index (IS_OPTN) read FucafIdcr write SetucafIdcr stored ucafIdcr_Specified;
    property ucaf:          ucaf           Index (IS_OPTN) read Fucaf write Setucaf stored ucaf_Specified;
    property purcCard:      PurcCard       Index (IS_OPTN) read FpurcCard write SetpurcCard stored purcCard_Specified;
    property eSign:         eSign          Index (IS_OPTN) read FeSign write SeteSign stored eSign_Specified;
    property voiceAuthCode: voiceAuthCode  Index (IS_OPTN) read FvoiceAuthCode write SetvoiceAuthCode stored voiceAuthCode_Specified;
    property ordNr:         ordNr5         Index (IS_OPTN) read FordNr write SetordNr stored ordNr_Specified;
    property vchrNr:        vchrNr         Index (IS_OPTN) read FvchrNr write SetvchrNr stored vchrNr_Specified;
    property pin:           pin            Index (IS_OPTN) read Fpin write Setpin stored pin_Specified;
  end;

  custId4         =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  cardAcptrRefNr  =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  mercOrdNr       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  invcNr          =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  corpVatNr       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }
  custVatNr       =  type string;      { "http://postilion/realtime/merchantframework/xsd/v1/"[Smpl] }


  // ************************************************************************ //
  // XML       : PurcCard, global, <complexType>
  // Namespace : http://postilion/realtime/merchantframework/xsd/v1/
  // ************************************************************************ //
  PurcCard = class(TRemotable)
  private
    FcustId: custId4;
    FcustId_Specified: boolean;
    FcardAcptrTaxId: cardAcptrTaxId;
    FcardAcptrTaxId_Specified: boolean;
    FcardAcptrVatNr: cardAcptrVatNr;
    FcardAcptrVatNr_Specified: boolean;
    FcardAcptrRefNr: cardAcptrRefNr;
    FcardAcptrRefNr_Specified: boolean;
    FcorpVatNr: corpVatNr;
    FcorpVatNr_Specified: boolean;
    FcustVatNr: custVatNr;
    FcustVatNr_Specified: boolean;
    FmercOrdNr: mercOrdNr;
    FmercOrdNr_Specified: boolean;
    FinvcNr: invcNr;
    FinvcNr_Specified: boolean;
    FordDt: TXSDateTime;
    FordDt_Specified: boolean;
    FpurcDt: TXSDateTime;
    FpurcDt_Specified: boolean;
    FcustBlngCode: custBlngCode;
    FcustBlngCode_Specified: boolean;
    FcustOrdNr: custOrdNr;
    FcustOrdNr_Specified: boolean;
    FtaxExmp: taxExmp;
    FtaxExmp_Specified: boolean;
    FcmdyCode: cmdyCode2;
    FcmdyCode_Specified: boolean;
    Fdesc: desc6;
    Fdesc_Specified: boolean;
    FdcntAmt: dcntAmt2;
    FdcntAmt_Specified: boolean;
    FshpAmt: shpAmt;
    FshpAmt_Specified: boolean;
    FdutyAmt: dutyAmt;
    FdutyAmt_Specified: boolean;
    FtaxColld: taxColld;
    FtaxColld_Specified: boolean;
    FtotAmt: totAmt2;
    FtotAmt_Specified: boolean;
    Fcmnt: cmnt;
    Fcmnt_Specified: boolean;
    FprivData: privData;
    FprivData_Specified: boolean;
    FlineItem: Array_Of_LineItem;
    FlineItem_Specified: boolean;
    Ftax: Array_Of_PurcCardTax;
    Ftax_Specified: boolean;
    FbillShip: BillShip;
    FbillShip_Specified: boolean;
    procedure SetcustId(Index: Integer; const AcustId4: custId4);
    function  custId_Specified(Index: Integer): boolean;
    procedure SetcardAcptrTaxId(Index: Integer; const AcardAcptrTaxId: cardAcptrTaxId);
    function  cardAcptrTaxId_Specified(Index: Integer): boolean;
    procedure SetcardAcptrVatNr(Index: Integer; const AcardAcptrVatNr: cardAcptrVatNr);
    function  cardAcptrVatNr_Specified(Index: Integer): boolean;
    procedure SetcardAcptrRefNr(Index: Integer; const AcardAcptrRefNr: cardAcptrRefNr);
    function  cardAcptrRefNr_Specified(Index: Integer): boolean;
    procedure SetcorpVatNr(Index: Integer; const AcorpVatNr: corpVatNr);
    function  corpVatNr_Specified(Index: Integer): boolean;
    procedure SetcustVatNr(Index: Integer; const AcustVatNr: custVatNr);
    function  custVatNr_Specified(Index: Integer): boolean;
    procedure SetmercOrdNr(Index: Integer; const AmercOrdNr: mercOrdNr);
    function  mercOrdNr_Specified(Index: Integer): boolean;
    procedure SetinvcNr(Index: Integer; const AinvcNr: invcNr);
    function  invcNr_Specified(Index: Integer): boolean;
    procedure SetordDt(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  ordDt_Specified(Index: Integer): boolean;
    procedure SetpurcDt(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  purcDt_Specified(Index: Integer): boolean;
    procedure SetcustBlngCode(Index: Integer; const AcustBlngCode: custBlngCode);
    function  custBlngCode_Specified(Index: Integer): boolean;
    procedure SetcustOrdNr(Index: Integer; const AcustOrdNr: custOrdNr);
    function  custOrdNr_Specified(Index: Integer): boolean;
    procedure SettaxExmp(Index: Integer; const AtaxExmp: taxExmp);
    function  taxExmp_Specified(Index: Integer): boolean;
    procedure SetcmdyCode(Index: Integer; const AcmdyCode2: cmdyCode2);
    function  cmdyCode_Specified(Index: Integer): boolean;
    procedure Setdesc(Index: Integer; const Adesc6: desc6);
    function  desc_Specified(Index: Integer): boolean;
    procedure SetdcntAmt(Index: Integer; const AdcntAmt2: dcntAmt2);
    function  dcntAmt_Specified(Index: Integer): boolean;
    procedure SetshpAmt(Index: Integer; const AshpAmt: shpAmt);
    function  shpAmt_Specified(Index: Integer): boolean;
    procedure SetdutyAmt(Index: Integer; const AdutyAmt: dutyAmt);
    function  dutyAmt_Specified(Index: Integer): boolean;
    procedure SettaxColld(Index: Integer; const AtaxColld: taxColld);
    function  taxColld_Specified(Index: Integer): boolean;
    procedure SettotAmt(Index: Integer; const AtotAmt2: totAmt2);
    function  totAmt_Specified(Index: Integer): boolean;
    procedure Setcmnt(Index: Integer; const Acmnt: cmnt);
    function  cmnt_Specified(Index: Integer): boolean;
    procedure SetprivData(Index: Integer; const AprivData: privData);
    function  privData_Specified(Index: Integer): boolean;
    procedure SetlineItem(Index: Integer; const AArray_Of_LineItem: Array_Of_LineItem);
    function  lineItem_Specified(Index: Integer): boolean;
    procedure Settax(Index: Integer; const AArray_Of_PurcCardTax: Array_Of_PurcCardTax);
    function  tax_Specified(Index: Integer): boolean;
    procedure SetbillShip(Index: Integer; const ABillShip: BillShip);
    function  billShip_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property custId:         custId4               Index (IS_OPTN) read FcustId write SetcustId stored custId_Specified;
    property cardAcptrTaxId: cardAcptrTaxId        Index (IS_OPTN) read FcardAcptrTaxId write SetcardAcptrTaxId stored cardAcptrTaxId_Specified;
    property cardAcptrVatNr: cardAcptrVatNr        Index (IS_OPTN) read FcardAcptrVatNr write SetcardAcptrVatNr stored cardAcptrVatNr_Specified;
    property cardAcptrRefNr: cardAcptrRefNr        Index (IS_OPTN) read FcardAcptrRefNr write SetcardAcptrRefNr stored cardAcptrRefNr_Specified;
    property corpVatNr:      corpVatNr             Index (IS_OPTN) read FcorpVatNr write SetcorpVatNr stored corpVatNr_Specified;
    property custVatNr:      custVatNr             Index (IS_OPTN) read FcustVatNr write SetcustVatNr stored custVatNr_Specified;
    property mercOrdNr:      mercOrdNr             Index (IS_OPTN) read FmercOrdNr write SetmercOrdNr stored mercOrdNr_Specified;
    property invcNr:         invcNr                Index (IS_OPTN) read FinvcNr write SetinvcNr stored invcNr_Specified;
    property ordDt:          TXSDateTime           Index (IS_OPTN) read FordDt write SetordDt stored ordDt_Specified;
    property purcDt:         TXSDateTime           Index (IS_OPTN) read FpurcDt write SetpurcDt stored purcDt_Specified;
    property custBlngCode:   custBlngCode          Index (IS_OPTN) read FcustBlngCode write SetcustBlngCode stored custBlngCode_Specified;
    property custOrdNr:      custOrdNr             Index (IS_OPTN) read FcustOrdNr write SetcustOrdNr stored custOrdNr_Specified;
    property taxExmp:        taxExmp               Index (IS_OPTN) read FtaxExmp write SettaxExmp stored taxExmp_Specified;
    property cmdyCode:       cmdyCode2             Index (IS_OPTN) read FcmdyCode write SetcmdyCode stored cmdyCode_Specified;
    property desc:           desc6                 Index (IS_OPTN) read Fdesc write Setdesc stored desc_Specified;
    property dcntAmt:        dcntAmt2              Index (IS_OPTN) read FdcntAmt write SetdcntAmt stored dcntAmt_Specified;
    property shpAmt:         shpAmt                Index (IS_OPTN) read FshpAmt write SetshpAmt stored shpAmt_Specified;
    property dutyAmt:        dutyAmt               Index (IS_OPTN) read FdutyAmt write SetdutyAmt stored dutyAmt_Specified;
    property taxColld:       taxColld              Index (IS_OPTN) read FtaxColld write SettaxColld stored taxColld_Specified;
    property totAmt:         totAmt2               Index (IS_OPTN) read FtotAmt write SettotAmt stored totAmt_Specified;
    property cmnt:           cmnt                  Index (IS_OPTN) read Fcmnt write Setcmnt stored cmnt_Specified;
    property privData:       privData              Index (IS_OPTN) read FprivData write SetprivData stored privData_Specified;
    property lineItem:       Array_Of_LineItem     Index (IS_OPTN or IS_UNBD) read FlineItem write SetlineItem stored lineItem_Specified;
    property tax:            Array_Of_PurcCardTax  Index (IS_OPTN or IS_UNBD) read Ftax write Settax stored tax_Specified;
    property billShip:       BillShip              Index (IS_OPTN) read FbillShip write SetbillShip stored billShip_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://postilion/realtime/merchantframework/wsdl/v1/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : MerchantWebServicesSOAP11Binding
  // service   : MerchantWebServices
  // port      : SOAPOverHTTP
  // URL       : https://ws.cert.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1
  // ************************************************************************ //
  MerchantWebServicesPortType = interface(IInvokable)
  ['{D0207081-2646-370E-B866-B757E062832E}']

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    //     - More than one strictly out element was found
    function  SendTran(const parameters: SendTranRequest): SendTranResponse; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    function  SettleTran(const parameters: SettleTranRequest): SettleTranResponse; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    //     - More than one strictly out element was found
    function  UpdtRecurrProf(const parameters: UpdtRecurrProfRequest): UpdtRecurrProfResponse; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    //     - More than one strictly out element was found
    function  FndRecurrProf(const parameters: FndRecurrProfRequest): FndRecurrProfResponse; stdcall;

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    //     - More than one strictly out element was found
    function  RecurrProfFromTran(const parameters: RecurrProfFromTranRequest): RecurrProfFromTranResponse; stdcall;
  end;

function GetMerchantWebServicesPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MerchantWebServicesPortType;


implementation

uses
  {$IfDef VER220}
  Sysutils
  {$Else}
  System.Sysutils
  {$EndIf}
  ;

function GetMerchantWebServicesPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MerchantWebServicesPortType;
const
  defWSDL = 'https://ws.cert.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1?wsdl';
  defURL  = 'https://ws.cert.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1';
  defSvc  = 'MerchantWebServices';
  defPrt  = 'SOAPOverHTTP';
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
    Result := (RIO as MerchantWebServicesPortType);
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


constructor SettleTranRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor SettleTranRequest.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FsettleData)-1 do
    SysUtils.FreeAndNil(FsettleData[I]);
  System.SetLength(FsettleData, 0);
  SysUtils.FreeAndNil(Fmerc);
  inherited Destroy;
end;

constructor UpdtRecurrProfRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor UpdtRecurrProfRequest.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FprodData)-1 do
    SysUtils.FreeAndNil(FprodData[I]);
  System.SetLength(FprodData, 0);
  SysUtils.FreeAndNil(Fmerc);
  SysUtils.FreeAndNil(Fcust);
  SysUtils.FreeAndNil(FrecurProf);
  inherited Destroy;
end;

procedure UpdtRecurrProfRequest.Setcust(Index: Integer; const ACust: Cust);
begin
  Fcust := ACust;
  Fcust_Specified := True;
end;

function UpdtRecurrProfRequest.cust_Specified(Index: Integer): boolean;
begin
  Result := Fcust_Specified;
end;

procedure UpdtRecurrProfRequest.SetrecurProf(Index: Integer; const ARecurProf: RecurProf);
begin
  FrecurProf := ARecurProf;
  FrecurProf_Specified := True;
end;

function UpdtRecurrProfRequest.recurProf_Specified(Index: Integer): boolean;
begin
  Result := FrecurProf_Specified;
end;

procedure UpdtRecurrProfRequest.SetprodData(Index: Integer; const AArray_Of_ProdData: Array_Of_ProdData);
begin
  FprodData := AArray_Of_ProdData;
  FprodData_Specified := True;
end;

function UpdtRecurrProfRequest.prodData_Specified(Index: Integer): boolean;
begin
  Result := FprodData_Specified;
end;

destructor RecurProf.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FprodData)-1 do
    SysUtils.FreeAndNil(FprodData[I]);
  System.SetLength(FprodData, 0);
  SysUtils.FreeAndNil(Frecur);
  inherited Destroy;
end;

procedure RecurProf.SetrecurProfId(Index: Integer; const ArecurProfId: recurProfId);
begin
  FrecurProfId := ArecurProfId;
  FrecurProfId_Specified := True;
end;

function RecurProf.recurProfId_Specified(Index: Integer): boolean;
begin
  Result := FrecurProfId_Specified;
end;

procedure RecurProf.Settype_(Index: Integer; const Atype_4: type_4);
begin
  Ftype_ := Atype_4;
  Ftype__Specified := True;
end;

function RecurProf.type__Specified(Index: Integer): boolean;
begin
  Result := Ftype__Specified;
end;

procedure RecurProf.Setrecur(Index: Integer; const ARecur: Recur);
begin
  Frecur := ARecur;
  Frecur_Specified := True;
end;

function RecurProf.recur_Specified(Index: Integer): boolean;
begin
  Result := Frecur_Specified;
end;

procedure RecurProf.SetprodData(Index: Integer; const AArray_Of_ProdData: Array_Of_ProdData);
begin
  FprodData := AArray_Of_ProdData;
  FprodData_Specified := True;
end;

function RecurProf.prodData_Specified(Index: Integer): boolean;
begin
  Result := FprodData_Specified;
end;

constructor FndRecurrProfRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor FndRecurrProfRequest.Destroy;
begin
  SysUtils.FreeAndNil(Fmerc);
  SysUtils.FreeAndNil(FrecurProfCrta);
  SysUtils.FreeAndNil(FcustCrta);
  SysUtils.FreeAndNil(FprodCrta);
  SysUtils.FreeAndNil(FpmtCrta);
  inherited Destroy;
end;

procedure FndRecurrProfRequest.Settype_(Index: Integer; const Atype_5: type_5);
begin
  Ftype_ := Atype_5;
  Ftype__Specified := True;
end;

function FndRecurrProfRequest.type__Specified(Index: Integer): boolean;
begin
  Result := Ftype__Specified;
end;

procedure FndRecurrProfRequest.SetrecurProfCrta(Index: Integer; const ARecurProfCrta: RecurProfCrta);
begin
  FrecurProfCrta := ARecurProfCrta;
  FrecurProfCrta_Specified := True;
end;

function FndRecurrProfRequest.recurProfCrta_Specified(Index: Integer): boolean;
begin
  Result := FrecurProfCrta_Specified;
end;

procedure FndRecurrProfRequest.SetcustCrta(Index: Integer; const ACustCrta: CustCrta);
begin
  FcustCrta := ACustCrta;
  FcustCrta_Specified := True;
end;

function FndRecurrProfRequest.custCrta_Specified(Index: Integer): boolean;
begin
  Result := FcustCrta_Specified;
end;

procedure FndRecurrProfRequest.SetprodCrta(Index: Integer; const AProdCrta: ProdCrta);
begin
  FprodCrta := AProdCrta;
  FprodCrta_Specified := True;
end;

function FndRecurrProfRequest.prodCrta_Specified(Index: Integer): boolean;
begin
  Result := FprodCrta_Specified;
end;

procedure FndRecurrProfRequest.SetpmtCrta(Index: Integer; const APmtCrta: PmtCrta);
begin
  FpmtCrta := APmtCrta;
  FpmtCrta_Specified := True;
end;

function FndRecurrProfRequest.pmtCrta_Specified(Index: Integer): boolean;
begin
  Result := FpmtCrta_Specified;
end;

procedure RecurPmt.SetinitRecurPmtIdcr(Index: Integer; const AinitRecurPmtIdcr: initRecurPmtIdcr);
begin
  FinitRecurPmtIdcr := AinitRecurPmtIdcr;
  FinitRecurPmtIdcr_Specified := True;
end;

function RecurPmt.initRecurPmtIdcr_Specified(Index: Integer): boolean;
begin
  Result := FinitRecurPmtIdcr_Specified;
end;

procedure RecurPmt.SetpmtNr(Index: Integer; const ApmtNr: pmtNr);
begin
  FpmtNr := ApmtNr;
  FpmtNr_Specified := True;
end;

function RecurPmt.pmtNr_Specified(Index: Integer): boolean;
begin
  Result := FpmtNr_Specified;
end;

procedure RecurPmt.SetnrOfPmt(Index: Integer; const AnrOfPmt2: nrOfPmt2);
begin
  FnrOfPmt := AnrOfPmt2;
  FnrOfPmt_Specified := True;
end;

function RecurPmt.nrOfPmt_Specified(Index: Integer): boolean;
begin
  Result := FnrOfPmt_Specified;
end;

destructor Cust.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fpmt)-1 do
    SysUtils.FreeAndNil(Fpmt[I]);
  System.SetLength(Fpmt, 0);
  SysUtils.FreeAndNil(Fcontact);
  inherited Destroy;
end;

procedure Cust.Settype_(Index: Integer; const Atype_7: type_7);
begin
  Ftype_ := Atype_7;
  Ftype__Specified := True;
end;

function Cust.type__Specified(Index: Integer): boolean;
begin
  Result := Ftype__Specified;
end;

procedure Cust.Setpmt(Index: Integer; const AArray_Of_Pmt: Array_Of_Pmt);
begin
  Fpmt := AArray_Of_Pmt;
  Fpmt_Specified := True;
end;

function Cust.pmt_Specified(Index: Integer): boolean;
begin
  Result := Fpmt_Specified;
end;

procedure BaseFaultType.Setmessage_(Index: Integer; const Astring: string);
begin
  Fmessage_ := Astring;
  Fmessage__Specified := True;
end;

function BaseFaultType.message__Specified(Index: Integer): boolean;
begin
  Result := Fmessage__Specified;
end;

procedure SystemFault.Setmessage_(Index: Integer; const Astring: string);
begin
  Fmessage_ := Astring;
  Fmessage__Specified := True;
end;

function SystemFault.message__Specified(Index: Integer): boolean;
begin
  Result := Fmessage__Specified;
end;

procedure ServiceFault.Setmessage_(Index: Integer; const Astring: string);
begin
  Fmessage_ := Astring;
  Fmessage__Specified := True;
end;

function ServiceFault.message__Specified(Index: Integer): boolean;
begin
  Result := Fmessage__Specified;
end;

destructor Pos.Destroy;
begin
  SysUtils.FreeAndNil(FcustSvcPhNr);
  inherited Destroy;
end;

procedure Pos.Setmcc(Index: Integer; const Amcc: mcc);
begin
  Fmcc := Amcc;
  Fmcc_Specified := True;
end;

function Pos.mcc_Specified(Index: Integer): boolean;
begin
  Result := Fmcc_Specified;
end;

procedure Pos.SetstoreNr(Index: Integer; const AstoreNr: storeNr);
begin
  FstoreNr := AstoreNr;
  FstoreNr_Specified := True;
end;

function Pos.storeNr_Specified(Index: Integer): boolean;
begin
  Result := FstoreNr_Specified;
end;

procedure Pos.SettermId(Index: Integer; const AtermId: termId);
begin
  FtermId := AtermId;
  FtermId_Specified := True;
end;

function Pos.termId_Specified(Index: Integer): boolean;
begin
  Result := FtermId_Specified;
end;

procedure Pos.SetpmtDesc(Index: Integer; const ApmtDesc: pmtDesc);
begin
  FpmtDesc := ApmtDesc;
  FpmtDesc_Specified := True;
end;

function Pos.pmtDesc_Specified(Index: Integer): boolean;
begin
  Result := FpmtDesc_Specified;
end;

procedure Pos.SetcustSvcPhNr(Index: Integer; const APhone2: Phone2);
begin
  FcustSvcPhNr := APhone2;
  FcustSvcPhNr_Specified := True;
end;

function Pos.custSvcPhNr_Specified(Index: Integer): boolean;
begin
  Result := FcustSvcPhNr_Specified;
end;

procedure Pos.Setfiid(Index: Integer; const Afiid: fiid);
begin
  Ffiid := Afiid;
  Ffiid_Specified := True;
end;

function Pos.fiid_Specified(Index: Integer): boolean;
begin
  Result := Ffiid_Specified;
end;

procedure Pos.Setaba(Index: Integer; const Aaba: aba);
begin
  Faba := Aaba;
  Faba_Specified := True;
end;

function Pos.aba_Specified(Index: Integer): boolean;
begin
  Result := Faba_Specified;
end;

procedure NameVal.Setval(Index: Integer; const Aval: val);
begin
  Fval := Aval;
  Fval_Specified := True;
end;

function NameVal.val_Specified(Index: Integer): boolean;
begin
  Result := Fval_Specified;
end;

procedure DriversLicense.Setstate(Index: Integer; const Astate: state);
begin
  Fstate := Astate;
  Fstate_Specified := True;
end;

function DriversLicense.state_Specified(Index: Integer): boolean;
begin
  Result := Fstate_Specified;
end;

destructor AchEcheck.Destroy;
begin
  SysUtils.FreeAndNil(FdriversLicense);
  SysUtils.FreeAndNil(Fidentity);
  inherited Destroy;
end;

procedure AchEcheck.SetachId(Index: Integer; const AachId: achId);
begin
  FachId := AachId;
  FachId_Specified := True;
end;

function AchEcheck.achId_Specified(Index: Integer): boolean;
begin
  Result := FachId_Specified;
end;

procedure AchEcheck.SetachAcctInfo(Index: Integer; const AachAcctInfo: achAcctInfo);
begin
  FachAcctInfo := AachAcctInfo;
  FachAcctInfo_Specified := True;
end;

function AchEcheck.achAcctInfo_Specified(Index: Integer): boolean;
begin
  Result := FachAcctInfo_Specified;
end;

procedure AchEcheck.SetbankRtNr(Index: Integer; const AbankRtNr: bankRtNr);
begin
  FbankRtNr := AbankRtNr;
  FbankRtNr_Specified := True;
end;

function AchEcheck.bankRtNr_Specified(Index: Integer): boolean;
begin
  Result := FbankRtNr_Specified;
end;

procedure AchEcheck.SetbankName(Index: Integer; const AbankName: bankName);
begin
  FbankName := AbankName;
  FbankName_Specified := True;
end;

function AchEcheck.bankName_Specified(Index: Integer): boolean;
begin
  Result := FbankName_Specified;
end;

procedure AchEcheck.SetacctNr(Index: Integer; const AacctNr: acctNr);
begin
  FacctNr := AacctNr;
  FacctNr_Specified := True;
end;

function AchEcheck.acctNr_Specified(Index: Integer): boolean;
begin
  Result := FacctNr_Specified;
end;

procedure AchEcheck.SetacctNrEncrypt(Index: Integer; const AacctNrEncrypt: acctNrEncrypt);
begin
  FacctNrEncrypt := AacctNrEncrypt;
  FacctNrEncrypt_Specified := True;
end;

function AchEcheck.acctNrEncrypt_Specified(Index: Integer): boolean;
begin
  Result := FacctNrEncrypt_Specified;
end;

procedure AchEcheck.SetacctType(Index: Integer; const AacctType: acctType);
begin
  FacctType := AacctType;
  FacctType_Specified := True;
end;

function AchEcheck.acctType_Specified(Index: Integer): boolean;
begin
  Result := FacctType_Specified;
end;

procedure AchEcheck.SetseccCode(Index: Integer; const AseccCode: seccCode);
begin
  FseccCode := AseccCode;
  FseccCode_Specified := True;
end;

function AchEcheck.seccCode_Specified(Index: Integer): boolean;
begin
  Result := FseccCode_Specified;
end;

procedure AchEcheck.SetcheckNr(Index: Integer; const AcheckNr: checkNr);
begin
  FcheckNr := AcheckNr;
  FcheckNr_Specified := True;
end;

function AchEcheck.checkNr_Specified(Index: Integer): boolean;
begin
  Result := FcheckNr_Specified;
end;

procedure AchEcheck.SetfraudChk(Index: Integer; const AfraudChk: fraudChk);
begin
  FfraudChk := AfraudChk;
  FfraudChk_Specified := True;
end;

function AchEcheck.fraudChk_Specified(Index: Integer): boolean;
begin
  Result := FfraudChk_Specified;
end;

procedure AchEcheck.SetdriversLicense(Index: Integer; const ADriversLicense: DriversLicense);
begin
  FdriversLicense := ADriversLicense;
  FdriversLicense_Specified := True;
end;

function AchEcheck.driversLicense_Specified(Index: Integer): boolean;
begin
  Result := FdriversLicense_Specified;
end;

procedure AchEcheck.Setidentity(Index: Integer; const AIdentity: Identity);
begin
  Fidentity := AIdentity;
  Fidentity_Specified := True;
end;

function AchEcheck.identity_Specified(Index: Integer): boolean;
begin
  Result := Fidentity_Specified;
end;

procedure AchEcheck.SetdtBirth(Index: Integer; const AdtBirth: dtBirth);
begin
  FdtBirth := AdtBirth;
  FdtBirth_Specified := True;
end;

function AchEcheck.dtBirth_Specified(Index: Integer): boolean;
begin
  Result := FdtBirth_Specified;
end;

constructor SendTranRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor SendTranRequest.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FusrDef)-1 do
    SysUtils.FreeAndNil(FusrDef[I]);
  System.SetLength(FusrDef, 0);
  SysUtils.FreeAndNil(Fmerc);
  SysUtils.FreeAndNil(Fcard);
  SysUtils.FreeAndNil(Fcontact);
  SysUtils.FreeAndNil(FlclDtTm);
  SysUtils.FreeAndNil(Fpos);
  SysUtils.FreeAndNil(FtranFlags);
  SysUtils.FreeAndNil(FauthReq);
  SysUtils.FreeAndNil(ForigTranData);
  SysUtils.FreeAndNil(FachEcheck);
  SysUtils.FreeAndNil(FrecurPmt);
  SysUtils.FreeAndNil(FrecurMan);
  SysUtils.FreeAndNil(Ftax);
  inherited Destroy;
end;

procedure SendTranRequest.Setcard(Index: Integer; const ACard: Card);
begin
  Fcard := ACard;
  Fcard_Specified := True;
end;

function SendTranRequest.card_Specified(Index: Integer): boolean;
begin
  Result := Fcard_Specified;
end;

procedure SendTranRequest.Setcontact(Index: Integer; const AContact: Contact);
begin
  Fcontact := AContact;
  Fcontact_Specified := True;
end;

function SendTranRequest.contact_Specified(Index: Integer): boolean;
begin
  Result := Fcontact_Specified;
end;

procedure SendTranRequest.SetreqAmt(Index: Integer; const AreqAmt: reqAmt);
begin
  FreqAmt := AreqAmt;
  FreqAmt_Specified := True;
end;

function SendTranRequest.reqAmt_Specified(Index: Integer): boolean;
begin
  Result := FreqAmt_Specified;
end;

procedure SendTranRequest.SetprevSettleAmt(Index: Integer; const AprevSettleAmt: prevSettleAmt);
begin
  FprevSettleAmt := AprevSettleAmt;
  FprevSettleAmt_Specified := True;
end;

function SendTranRequest.prevSettleAmt_Specified(Index: Integer): boolean;
begin
  Result := FprevSettleAmt_Specified;
end;

procedure SendTranRequest.SetlclDtTm(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FlclDtTm := ATXSDateTime;
  FlclDtTm_Specified := True;
end;

function SendTranRequest.lclDtTm_Specified(Index: Integer): boolean;
begin
  Result := FlclDtTm_Specified;
end;

procedure SendTranRequest.SetusrDef(Index: Integer; const AArray_Of_NameVal: Array_Of_NameVal);
begin
  FusrDef := AArray_Of_NameVal;
  FusrDef_Specified := True;
end;

function SendTranRequest.usrDef_Specified(Index: Integer): boolean;
begin
  Result := FusrDef_Specified;
end;

procedure SendTranRequest.Setpos(Index: Integer; const APos: Pos);
begin
  Fpos := APos;
  Fpos_Specified := True;
end;

function SendTranRequest.pos_Specified(Index: Integer): boolean;
begin
  Result := Fpos_Specified;
end;

procedure SendTranRequest.SetindCode(Index: Integer; const AindCode: indCode);
begin
  FindCode := AindCode;
  FindCode_Specified := True;
end;

function SendTranRequest.indCode_Specified(Index: Integer): boolean;
begin
  Result := FindCode_Specified;
end;

procedure SendTranRequest.SettranFlags(Index: Integer; const ATranFlags: TranFlags);
begin
  FtranFlags := ATranFlags;
  FtranFlags_Specified := True;
end;

function SendTranRequest.tranFlags_Specified(Index: Integer): boolean;
begin
  Result := FtranFlags_Specified;
end;

procedure SendTranRequest.SetauthReq(Index: Integer; const AAuthReq: AuthReq);
begin
  FauthReq := AAuthReq;
  FauthReq_Specified := True;
end;

function SendTranRequest.authReq_Specified(Index: Integer): boolean;
begin
  Result := FauthReq_Specified;
end;

procedure SendTranRequest.SetorigTranData(Index: Integer; const ATranData: TranData);
begin
  ForigTranData := ATranData;
  ForigTranData_Specified := True;
end;

function SendTranRequest.origTranData_Specified(Index: Integer): boolean;
begin
  Result := ForigTranData_Specified;
end;

procedure SendTranRequest.SetachEcheck(Index: Integer; const AAchEcheck: AchEcheck);
begin
  FachEcheck := AAchEcheck;
  FachEcheck_Specified := True;
end;

function SendTranRequest.achEcheck_Specified(Index: Integer): boolean;
begin
  Result := FachEcheck_Specified;
end;

procedure SendTranRequest.SetrecurPmt(Index: Integer; const ARecurPmt: RecurPmt);
begin
  FrecurPmt := ARecurPmt;
  FrecurPmt_Specified := True;
end;

function SendTranRequest.recurPmt_Specified(Index: Integer): boolean;
begin
  Result := FrecurPmt_Specified;
end;

procedure SendTranRequest.SetrecurMan(Index: Integer; const ARecurMan: RecurMan);
begin
  FrecurMan := ARecurMan;
  FrecurMan_Specified := True;
end;

function SendTranRequest.recurMan_Specified(Index: Integer): boolean;
begin
  Result := FrecurMan_Specified;
end;

procedure SendTranRequest.Settax(Index: Integer; const ATax: Tax);
begin
  Ftax := ATax;
  Ftax_Specified := True;
end;

function SendTranRequest.tax_Specified(Index: Integer): boolean;
begin
  Result := Ftax_Specified;
end;

procedure SendTranRequest.SetdeviceType(Index: Integer; const AdeviceType: deviceType);
begin
  FdeviceType := AdeviceType;
  FdeviceType_Specified := True;
end;

function SendTranRequest.deviceType_Specified(Index: Integer): boolean;
begin
  Result := FdeviceType_Specified;
end;

procedure SendTranRequest.SetgoodsSoldCode(Index: Integer; const AgoodsSoldCode: goodsSoldCode);
begin
  FgoodsSoldCode := AgoodsSoldCode;
  FgoodsSoldCode_Specified := True;
end;

function SendTranRequest.goodsSoldCode_Specified(Index: Integer): boolean;
begin
  Result := FgoodsSoldCode_Specified;
end;

destructor ProdData.Destroy;
begin
  SysUtils.FreeAndNil(Fprod);
  inherited Destroy;
end;

procedure ProdData.Setid(Index: Integer; const Aid7: id7);
begin
  Fid := Aid7;
  Fid_Specified := True;
end;

function ProdData.id_Specified(Index: Integer): boolean;
begin
  Result := Fid_Specified;
end;

procedure ProdData.Settype_(Index: Integer; const Atype_3: type_3);
begin
  Ftype_ := Atype_3;
  Ftype__Specified := True;
end;

function ProdData.type__Specified(Index: Integer): boolean;
begin
  Result := Ftype__Specified;
end;

procedure ProdData.Setprod(Index: Integer; const AProd: Prod);
begin
  Fprod := AProd;
  Fprod_Specified := True;
end;

function ProdData.prod_Specified(Index: Integer): boolean;
begin
  Result := Fprod_Specified;
end;

procedure ProdData.Setquantity(Index: Integer; const Aquantity: quantity);
begin
  Fquantity := Aquantity;
  Fquantity_Specified := True;
end;

function ProdData.quantity_Specified(Index: Integer): boolean;
begin
  Result := Fquantity_Specified;
end;

procedure AchResponse.SetMessage_(Index: Integer; const AMessage_: Message_);
begin
  FMessage_ := AMessage_;
  FMessage__Specified := True;
end;

function AchResponse.Message__Specified(Index: Integer): boolean;
begin
  Result := FMessage__Specified;
end;

procedure AchResponse.SetNote(Index: Integer; const AArray_Of_Note: Array_Of_Note);
begin
  FNote := AArray_Of_Note;
  FNote_Specified := True;
end;

function AchResponse.Note_Specified(Index: Integer): boolean;
begin
  Result := FNote_Specified;
end;

destructor RecurMan.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FprodInfo)-1 do
    SysUtils.FreeAndNil(FprodInfo[I]);
  System.SetLength(FprodInfo, 0);
  inherited Destroy;
end;

procedure RecurMan.Setsec(Index: Integer; const Asec2: sec2);
begin
  Fsec := Asec2;
  Fsec_Specified := True;
end;

function RecurMan.sec_Specified(Index: Integer): boolean;
begin
  Result := Fsec_Specified;
end;

procedure RecurMan.SetseccCode(Index: Integer; const AseccCode2: seccCode2);
begin
  FseccCode := AseccCode2;
  FseccCode_Specified := True;
end;

function RecurMan.seccCode_Specified(Index: Integer): boolean;
begin
  Result := FseccCode_Specified;
end;

procedure RecurMan.SetprodInfo(Index: Integer; const AArray_Of_ProdInfo: Array_Of_ProdInfo);
begin
  FprodInfo := AArray_Of_ProdInfo;
  FprodInfo_Specified := True;
end;

function RecurMan.prodInfo_Specified(Index: Integer): boolean;
begin
  Result := FprodInfo_Specified;
end;

procedure PmtCrta.Setpan(Index: Integer; const Apan2: pan2);
begin
  Fpan := Apan2;
  Fpan_Specified := True;
end;

function PmtCrta.pan_Specified(Index: Integer): boolean;
begin
  Result := Fpan_Specified;
end;

procedure PmtCrta.SetacctNr(Index: Integer; const AacctNr2: acctNr2);
begin
  FacctNr := AacctNr2;
  FacctNr_Specified := True;
end;

function PmtCrta.acctNr_Specified(Index: Integer): boolean;
begin
  Result := FacctNr_Specified;
end;

procedure PmtCrta.SetpmtId(Index: Integer; const ApmtId4: pmtId4);
begin
  FpmtId := ApmtId4;
  FpmtId_Specified := True;
end;

function PmtCrta.pmtId_Specified(Index: Integer): boolean;
begin
  Result := FpmtId_Specified;
end;

procedure PmtCrta.SetpmtDesc(Index: Integer; const ApmtDesc2: pmtDesc2);
begin
  FpmtDesc := ApmtDesc2;
  FpmtDesc_Specified := True;
end;

function PmtCrta.pmtDesc_Specified(Index: Integer): boolean;
begin
  Result := FpmtDesc_Specified;
end;

procedure PmtCrta.SetordNr(Index: Integer; const AordNr: ordNr);
begin
  FordNr := AordNr;
  FordNr_Specified := True;
end;

function PmtCrta.ordNr_Specified(Index: Integer): boolean;
begin
  Result := FordNr_Specified;
end;

constructor FndRecurrProfResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor FndRecurrProfResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fcust)-1 do
    SysUtils.FreeAndNil(Fcust[I]);
  System.SetLength(Fcust, 0);
  for I := 0 to System.Length(FrecurProf)-1 do
    SysUtils.FreeAndNil(FrecurProf[I]);
  System.SetLength(FrecurProf, 0);
  for I := 0 to System.Length(FprodData)-1 do
    SysUtils.FreeAndNil(FprodData[I]);
  System.SetLength(FprodData, 0);
  inherited Destroy;
end;

procedure FndRecurrProfResponse.Setid(Index: Integer; const AInteger: Integer);
begin
  Fid := AInteger;
  Fid_Specified := True;
end;

function FndRecurrProfResponse.id_Specified(Index: Integer): boolean;
begin
  Result := Fid_Specified;
end;

procedure FndRecurrProfResponse.Setcust(Index: Integer; const AArray_Of_Cust: Array_Of_Cust);
begin
  Fcust := AArray_Of_Cust;
  Fcust_Specified := True;
end;

function FndRecurrProfResponse.cust_Specified(Index: Integer): boolean;
begin
  Result := Fcust_Specified;
end;

procedure FndRecurrProfResponse.SetrecurProf(Index: Integer; const AArray_Of_RecurProf: Array_Of_RecurProf);
begin
  FrecurProf := AArray_Of_RecurProf;
  FrecurProf_Specified := True;
end;

function FndRecurrProfResponse.recurProf_Specified(Index: Integer): boolean;
begin
  Result := FrecurProf_Specified;
end;

procedure FndRecurrProfResponse.SetprodData(Index: Integer; const AArray_Of_ProdData: Array_Of_ProdData);
begin
  FprodData := AArray_Of_ProdData;
  FprodData_Specified := True;
end;

function FndRecurrProfResponse.prodData_Specified(Index: Integer): boolean;
begin
  Result := FprodData_Specified;
end;

constructor SendTranResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor SendTranResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FadditionalAmount)-1 do
    SysUtils.FreeAndNil(FadditionalAmount[I]);
  System.SetLength(FadditionalAmount, 0);
  for I := 0 to System.Length(FusrDef)-1 do
    SysUtils.FreeAndNil(FusrDef[I]);
  System.SetLength(FusrDef, 0);
  SysUtils.FreeAndNil(FauthRsp);
  SysUtils.FreeAndNil(FtranData);
  SysUtils.FreeAndNil(FachResponse);
  SysUtils.FreeAndNil(Fmerc);
  SysUtils.FreeAndNil(FauthReq);
  inherited Destroy;
end;

procedure SendTranResponse.SetextRspCode(Index: Integer; const AextRspCode: extRspCode);
begin
  FextRspCode := AextRspCode;
  FextRspCode_Specified := True;
end;

function SendTranResponse.extRspCode_Specified(Index: Integer): boolean;
begin
  Result := FextRspCode_Specified;
end;

procedure SendTranResponse.SetauthRsp(Index: Integer; const AAuthRsp: AuthRsp);
begin
  FauthRsp := AAuthRsp;
  FauthRsp_Specified := True;
end;

function SendTranResponse.authRsp_Specified(Index: Integer): boolean;
begin
  Result := FauthRsp_Specified;
end;

procedure SendTranResponse.SettranData(Index: Integer; const ATranData: TranData);
begin
  FtranData := ATranData;
  FtranData_Specified := True;
end;

function SendTranResponse.tranData_Specified(Index: Integer): boolean;
begin
  Result := FtranData_Specified;
end;

procedure SendTranResponse.SetinvId(Index: Integer; const AinvId: invId);
begin
  FinvId := AinvId;
  FinvId_Specified := True;
end;

function SendTranResponse.invId_Specified(Index: Integer): boolean;
begin
  Result := FinvId_Specified;
end;

procedure SendTranResponse.SetcardType(Index: Integer; const AcardType: cardType);
begin
  FcardType := AcardType;
  FcardType_Specified := True;
end;

function SendTranResponse.cardType_Specified(Index: Integer): boolean;
begin
  Result := FcardType_Specified;
end;

procedure SendTranResponse.SetmapCaid(Index: Integer; const AmapCaid: mapCaid);
begin
  FmapCaid := AmapCaid;
  FmapCaid_Specified := True;
end;

function SendTranResponse.mapCaid_Specified(Index: Integer): boolean;
begin
  Result := FmapCaid_Specified;
end;

procedure SendTranResponse.SetadditionalAmount(Index: Integer; const AArray_Of_AdditionalAmount: Array_Of_AdditionalAmount);
begin
  FadditionalAmount := AArray_Of_AdditionalAmount;
  FadditionalAmount_Specified := True;
end;

function SendTranResponse.additionalAmount_Specified(Index: Integer): boolean;
begin
  Result := FadditionalAmount_Specified;
end;

procedure SendTranResponse.SetachResponse(Index: Integer; const AAchResponse: AchResponse);
begin
  FachResponse := AAchResponse;
  FachResponse_Specified := True;
end;

function SendTranResponse.achResponse_Specified(Index: Integer): boolean;
begin
  Result := FachResponse_Specified;
end;

procedure SendTranResponse.Setmerc(Index: Integer; const AMerc: Merc);
begin
  Fmerc := AMerc;
  Fmerc_Specified := True;
end;

function SendTranResponse.merc_Specified(Index: Integer): boolean;
begin
  Result := Fmerc_Specified;
end;

procedure SendTranResponse.SetauthReq(Index: Integer; const AAuthReq: AuthReq);
begin
  FauthReq := AAuthReq;
  FauthReq_Specified := True;
end;

function SendTranResponse.authReq_Specified(Index: Integer): boolean;
begin
  Result := FauthReq_Specified;
end;

procedure SendTranResponse.SetusrDef(Index: Integer; const AArray_Of_NameVal: Array_Of_NameVal);
begin
  FusrDef := AArray_Of_NameVal;
  FusrDef_Specified := True;
end;

function SendTranResponse.usrDef_Specified(Index: Integer): boolean;
begin
  Result := FusrDef_Specified;
end;

constructor SettleTranResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor RecurrProfFromTranResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure RecurrProfFromTranResponse.Setid(Index: Integer; const Aid5: id5);
begin
  Fid := Aid5;
  Fid_Specified := True;
end;

function RecurrProfFromTranResponse.id_Specified(Index: Integer): boolean;
begin
  Result := Fid_Specified;
end;

procedure RecurrProfFromTranResponse.SetcustId(Index: Integer; const AcustId2: custId2);
begin
  FcustId := AcustId2;
  FcustId_Specified := True;
end;

function RecurrProfFromTranResponse.custId_Specified(Index: Integer): boolean;
begin
  Result := FcustId_Specified;
end;

procedure RecurrProfFromTranResponse.SetpmtId(Index: Integer; const AArray_Of_pmtId2: Array_Of_pmtId2);
begin
  FpmtId := AArray_Of_pmtId2;
  FpmtId_Specified := True;
end;

function RecurrProfFromTranResponse.pmtId_Specified(Index: Integer): boolean;
begin
  Result := FpmtId_Specified;
end;

procedure RecurrProfFromTranResponse.SetrspCode(Index: Integer; const ArspCode3: rspCode3);
begin
  FrspCode := ArspCode3;
  FrspCode_Specified := True;
end;

function RecurrProfFromTranResponse.rspCode_Specified(Index: Integer): boolean;
begin
  Result := FrspCode_Specified;
end;

constructor UpdtRecurrProfResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

procedure UpdtRecurrProfResponse.Setid(Index: Integer; const Aid6: id6);
begin
  Fid := Aid6;
  Fid_Specified := True;
end;

function UpdtRecurrProfResponse.id_Specified(Index: Integer): boolean;
begin
  Result := Fid_Specified;
end;

procedure UpdtRecurrProfResponse.SetcustId(Index: Integer; const AcustId3: custId3);
begin
  FcustId := AcustId3;
  FcustId_Specified := True;
end;

function UpdtRecurrProfResponse.custId_Specified(Index: Integer): boolean;
begin
  Result := FcustId_Specified;
end;

procedure UpdtRecurrProfResponse.SetpmtId(Index: Integer; const AArray_Of_pmtId: Array_Of_pmtId);
begin
  FpmtId := AArray_Of_pmtId;
  FpmtId_Specified := True;
end;

function UpdtRecurrProfResponse.pmtId_Specified(Index: Integer): boolean;
begin
  Result := FpmtId_Specified;
end;

procedure UpdtRecurrProfResponse.SetprodId(Index: Integer; const AArray_Of_prodId: Array_Of_prodId);
begin
  FprodId := AArray_Of_prodId;
  FprodId_Specified := True;
end;

function UpdtRecurrProfResponse.prodId_Specified(Index: Integer): boolean;
begin
  Result := FprodId_Specified;
end;

procedure UpdtRecurrProfResponse.SetrspCode(Index: Integer; const ArspCode4: rspCode4);
begin
  FrspCode := ArspCode4;
  FrspCode_Specified := True;
end;

function UpdtRecurrProfResponse.rspCode_Specified(Index: Integer): boolean;
begin
  Result := FrspCode_Specified;
end;

constructor RecurrProfFromTranRequest.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor RecurrProfFromTranRequest.Destroy;
begin
  SysUtils.FreeAndNil(Fmerc);
  SysUtils.FreeAndNil(FrecurProf);
  inherited Destroy;
end;

procedure RecurrProfFromTranRequest.SetrecurProf(Index: Integer; const ARecurProf: RecurProf);
begin
  FrecurProf := ARecurProf;
  FrecurProf_Specified := True;
end;

function RecurrProfFromTranRequest.recurProf_Specified(Index: Integer): boolean;
begin
  Result := FrecurProf_Specified;
end;

destructor Pmt.Destroy;
begin
  SysUtils.FreeAndNil(Fcard);
  SysUtils.FreeAndNil(Ftax);
  SysUtils.FreeAndNil(Fach);
  inherited Destroy;
end;

procedure Pmt.Setid(Index: Integer; const Aid: id);
begin
  Fid := Aid;
  Fid_Specified := True;
end;

function Pmt.id_Specified(Index: Integer): boolean;
begin
  Result := Fid_Specified;
end;

procedure Pmt.Settype_(Index: Integer; const Atype_6: type_6);
begin
  Ftype_ := Atype_6;
  Ftype__Specified := True;
end;

function Pmt.type__Specified(Index: Integer): boolean;
begin
  Result := Ftype__Specified;
end;

procedure Pmt.Setcard(Index: Integer; const ACard: Card);
begin
  Fcard := ACard;
  Fcard_Specified := True;
end;

function Pmt.card_Specified(Index: Integer): boolean;
begin
  Result := Fcard_Specified;
end;

procedure Pmt.SetordNr(Index: Integer; const AordNr2: ordNr2);
begin
  FordNr := AordNr2;
  FordNr_Specified := True;
end;

function Pmt.ordNr_Specified(Index: Integer): boolean;
begin
  Result := FordNr_Specified;
end;

procedure Pmt.Setamt(Index: Integer; const Aamt: amt);
begin
  Famt := Aamt;
  Famt_Specified := True;
end;

function Pmt.amt_Specified(Index: Integer): boolean;
begin
  Result := Famt_Specified;
end;

procedure Pmt.Settax(Index: Integer; const ATax: Tax);
begin
  Ftax := ATax;
  Ftax_Specified := True;
end;

function Pmt.tax_Specified(Index: Integer): boolean;
begin
  Result := Ftax_Specified;
end;

procedure Pmt.Setach(Index: Integer; const AAchEcheck: AchEcheck);
begin
  Fach := AAchEcheck;
  Fach_Specified := True;
end;

function Pmt.ach_Specified(Index: Integer): boolean;
begin
  Result := Fach_Specified;
end;

procedure Pmt.Setdesc(Index: Integer; const Adesc: desc);
begin
  Fdesc := Adesc;
  Fdesc_Specified := True;
end;

function Pmt.desc_Specified(Index: Integer): boolean;
begin
  Result := Fdesc_Specified;
end;

procedure Pmt.SetindCode(Index: Integer; const AindCode2: indCode2);
begin
  FindCode := AindCode2;
  FindCode_Specified := True;
end;

function Pmt.indCode_Specified(Index: Integer): boolean;
begin
  Result := FindCode_Specified;
end;

procedure Pmt.Setstatus(Index: Integer; const Astatus: status);
begin
  Fstatus := Astatus;
  Fstatus_Specified := True;
end;

function Pmt.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure AuthRsp.SetsecRslt(Index: Integer; const AsecRslt: secRslt);
begin
  FsecRslt := AsecRslt;
  FsecRslt_Specified := True;
end;

function AuthRsp.secRslt_Specified(Index: Integer): boolean;
begin
  Result := FsecRslt_Specified;
end;

procedure AuthRsp.SetavsRslt(Index: Integer; const AavsRslt: avsRslt);
begin
  FavsRslt := AavsRslt;
  FavsRslt_Specified := True;
end;

function AuthRsp.avsRslt_Specified(Index: Integer): boolean;
begin
  Result := FavsRslt_Specified;
end;

procedure AuthRsp.Setaci(Index: Integer; const Aaci: aci);
begin
  Faci := Aaci;
  Faci_Specified := True;
end;

function AuthRsp.aci_Specified(Index: Integer): boolean;
begin
  Result := Faci_Specified;
end;

procedure AuthRsp.SetcavvRslt(Index: Integer; const AcavvRslt: cavvRslt);
begin
  FcavvRslt := AcavvRslt;
  FcavvRslt_Specified := True;
end;

function AuthRsp.cavvRslt_Specified(Index: Integer): boolean;
begin
  Result := FcavvRslt_Specified;
end;

procedure AuthRsp.SettranId(Index: Integer; const AtranId: tranId);
begin
  FtranId := AtranId;
  FtranId_Specified := True;
end;

function AuthRsp.tranId_Specified(Index: Integer): boolean;
begin
  Result := FtranId_Specified;
end;

procedure AuthRsp.SetgwyTranId(Index: Integer; const AgwyTranId: gwyTranId);
begin
  FgwyTranId := AgwyTranId;
  FgwyTranId_Specified := True;
end;

function AuthRsp.gwyTranId_Specified(Index: Integer): boolean;
begin
  Result := FgwyTranId_Specified;
end;

procedure AuthRsp.SetissrNtwkId(Index: Integer; const AissrNtwkId: issrNtwkId);
begin
  FissrNtwkId := AissrNtwkId;
  FissrNtwkId_Specified := True;
end;

function AuthRsp.issrNtwkId_Specified(Index: Integer): boolean;
begin
  Result := FissrNtwkId_Specified;
end;

procedure AuthRsp.SetvalCode(Index: Integer; const AvalCode: valCode);
begin
  FvalCode := AvalCode;
  FvalCode_Specified := True;
end;

function AuthRsp.valCode_Specified(Index: Integer): boolean;
begin
  Result := FvalCode_Specified;
end;

procedure AuthRsp.SetcomCardType(Index: Integer; const AcomCardType: comCardType);
begin
  FcomCardType := AcomCardType;
  FcomCardType_Specified := True;
end;

function AuthRsp.comCardType_Specified(Index: Integer): boolean;
begin
  Result := FcomCardType_Specified;
end;

procedure SettleData.Setamt(Index: Integer; const Aamt3: amt3);
begin
  Famt := Aamt3;
  Famt_Specified := True;
end;

function SettleData.amt_Specified(Index: Integer): boolean;
begin
  Result := Famt_Specified;
end;

procedure SettleData.SetmgdSettle(Index: Integer; const AmgdSettle: mgdSettle);
begin
  FmgdSettle := AmgdSettle;
  FmgdSettle_Specified := True;
end;

function SettleData.mgdSettle_Specified(Index: Integer): boolean;
begin
  Result := FmgdSettle_Specified;
end;

procedure RecurProfCrta.Setid(Index: Integer; const Aid3: id3);
begin
  Fid := Aid3;
  Fid_Specified := True;
end;

function RecurProfCrta.id_Specified(Index: Integer): boolean;
begin
  Result := Fid_Specified;
end;

procedure RecurProfCrta.SetordNr(Index: Integer; const AordNr4: ordNr4);
begin
  FordNr := AordNr4;
  FordNr_Specified := True;
end;

function RecurProfCrta.ordNr_Specified(Index: Integer): boolean;
begin
  Result := FordNr_Specified;
end;

procedure ProdCrta.Setid(Index: Integer; const Aid2: id2);
begin
  Fid := Aid2;
  Fid_Specified := True;
end;

function ProdCrta.id_Specified(Index: Integer): boolean;
begin
  Result := Fid_Specified;
end;

procedure ProdCrta.Setstat(Index: Integer; const Astat3: stat3);
begin
  Fstat := Astat3;
  Fstat_Specified := True;
end;

function ProdCrta.stat_Specified(Index: Integer): boolean;
begin
  Result := Fstat_Specified;
end;

procedure ProdCrta.SetprodName(Index: Integer; const AprodName2: prodName2);
begin
  FprodName := AprodName2;
  FprodName_Specified := True;
end;

function ProdCrta.prodName_Specified(Index: Integer): boolean;
begin
  Result := FprodName_Specified;
end;

procedure Prod.SetprodName(Index: Integer; const AprodName: prodName);
begin
  FprodName := AprodName;
  FprodName_Specified := True;
end;

function Prod.prodName_Specified(Index: Integer): boolean;
begin
  Result := FprodName_Specified;
end;

procedure Prod.Setdesc(Index: Integer; const Adesc3: desc3);
begin
  Fdesc := Adesc3;
  Fdesc_Specified := True;
end;

function Prod.desc_Specified(Index: Integer): boolean;
begin
  Result := Fdesc_Specified;
end;

procedure Prod.Setprice(Index: Integer; const Aprice: price);
begin
  Fprice := Aprice;
  Fprice_Specified := True;
end;

function Prod.price_Specified(Index: Integer): boolean;
begin
  Result := Fprice_Specified;
end;

procedure Prod.SettaxPctg(Index: Integer; const AtaxPctg: taxPctg);
begin
  FtaxPctg := AtaxPctg;
  FtaxPctg_Specified := True;
end;

function Prod.taxPctg_Specified(Index: Integer): boolean;
begin
  Result := FtaxPctg_Specified;
end;

procedure Prod.SetunitOfMsr(Index: Integer; const AunitOfMsr: unitOfMsr);
begin
  FunitOfMsr := AunitOfMsr;
  FunitOfMsr_Specified := True;
end;

function Prod.unitOfMsr_Specified(Index: Integer): boolean;
begin
  Result := FunitOfMsr_Specified;
end;

procedure Prod.SetsetupFee(Index: Integer; const AsetupFee: setupFee);
begin
  FsetupFee := AsetupFee;
  FsetupFee_Specified := True;
end;

function Prod.setupFee_Specified(Index: Integer): boolean;
begin
  Result := FsetupFee_Specified;
end;

procedure Tax.Setamt(Index: Integer; const Aamt4: amt4);
begin
  Famt := Aamt4;
  Famt_Specified := True;
end;

function Tax.amt_Specified(Index: Integer): boolean;
begin
  Result := Famt_Specified;
end;

destructor Recur.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FprodInfo)-1 do
    SysUtils.FreeAndNil(FprodInfo[I]);
  System.SetLength(FprodInfo, 0);
  for I := 0 to System.Length(FusrDef)-1 do
    SysUtils.FreeAndNil(FusrDef[I]);
  System.SetLength(FusrDef, 0);
  SysUtils.FreeAndNil(FstartDt);
  SysUtils.FreeAndNil(FnextProcDt);
  SysUtils.FreeAndNil(Ftax);
  inherited Destroy;
end;

procedure Recur.Setamt(Index: Integer; const Aamt2: amt2);
begin
  Famt := Aamt2;
  Famt_Specified := True;
end;

function Recur.amt_Specified(Index: Integer): boolean;
begin
  Result := Famt_Specified;
end;

procedure Recur.SetnrOfPmt(Index: Integer; const AnrOfPmt: nrOfPmt);
begin
  FnrOfPmt := AnrOfPmt;
  FnrOfPmt_Specified := True;
end;

function Recur.nrOfPmt_Specified(Index: Integer): boolean;
begin
  Result := FnrOfPmt_Specified;
end;

procedure Recur.Setdesc(Index: Integer; const Adesc2: desc2);
begin
  Fdesc := Adesc2;
  Fdesc_Specified := True;
end;

function Recur.desc_Specified(Index: Integer): boolean;
begin
  Result := Fdesc_Specified;
end;

procedure Recur.SetcustId(Index: Integer; const AcustId: custId);
begin
  FcustId := AcustId;
  FcustId_Specified := True;
end;

function Recur.custId_Specified(Index: Integer): boolean;
begin
  Result := FcustId_Specified;
end;

procedure Recur.SetpmtId(Index: Integer; const ApmtId: pmtId);
begin
  FpmtId := ApmtId;
  FpmtId_Specified := True;
end;

function Recur.pmtId_Specified(Index: Integer): boolean;
begin
  Result := FpmtId_Specified;
end;

procedure Recur.SetprodInfo(Index: Integer; const AArray_Of_ProdInfo: Array_Of_ProdInfo);
begin
  FprodInfo := AArray_Of_ProdInfo;
  FprodInfo_Specified := True;
end;

function Recur.prodInfo_Specified(Index: Integer): boolean;
begin
  Result := FprodInfo_Specified;
end;

procedure Recur.SetnextProcDt(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FnextProcDt := ATXSDateTime;
  FnextProcDt_Specified := True;
end;

function Recur.nextProcDt_Specified(Index: Integer): boolean;
begin
  Result := FnextProcDt_Specified;
end;

procedure Recur.SetnrOfPmtRem(Index: Integer; const AnrOfPmtRem: nrOfPmtRem);
begin
  FnrOfPmtRem := AnrOfPmtRem;
  FnrOfPmtRem_Specified := True;
end;

function Recur.nrOfPmtRem_Specified(Index: Integer): boolean;
begin
  Result := FnrOfPmtRem_Specified;
end;

procedure Recur.SetnrOfPmtProc(Index: Integer; const AnrOfPmtProc: nrOfPmtProc);
begin
  FnrOfPmtProc := AnrOfPmtProc;
  FnrOfPmtProc_Specified := True;
end;

function Recur.nrOfPmtProc_Specified(Index: Integer): boolean;
begin
  Result := FnrOfPmtProc_Specified;
end;

procedure Recur.SetindCode(Index: Integer; const AindCode3: indCode3);
begin
  FindCode := AindCode3;
  FindCode_Specified := True;
end;

function Recur.indCode_Specified(Index: Integer): boolean;
begin
  Result := FindCode_Specified;
end;

procedure Recur.SetordNr(Index: Integer; const AordNr3: ordNr3);
begin
  FordNr := AordNr3;
  FordNr_Specified := True;
end;

function Recur.ordNr_Specified(Index: Integer): boolean;
begin
  Result := FordNr_Specified;
end;

procedure Recur.SetpurcOrdNr(Index: Integer; const ApurcOrdNr: purcOrdNr);
begin
  FpurcOrdNr := ApurcOrdNr;
  FpurcOrdNr_Specified := True;
end;

function Recur.purcOrdNr_Specified(Index: Integer): boolean;
begin
  Result := FpurcOrdNr_Specified;
end;

procedure Recur.SetshipToZipCode(Index: Integer; const AshipToZipCode: shipToZipCode);
begin
  FshipToZipCode := AshipToZipCode;
  FshipToZipCode_Specified := True;
end;

function Recur.shipToZipCode_Specified(Index: Integer): boolean;
begin
  Result := FshipToZipCode_Specified;
end;

procedure Recur.SetusrDef(Index: Integer; const AArray_Of_NameVal: Array_Of_NameVal);
begin
  FusrDef := AArray_Of_NameVal;
  FusrDef_Specified := True;
end;

function Recur.usrDef_Specified(Index: Integer): boolean;
begin
  Result := FusrDef_Specified;
end;

procedure Recur.Settax(Index: Integer; const ATax: Tax);
begin
  Ftax := ATax;
  Ftax_Specified := True;
end;

function Recur.tax_Specified(Index: Integer): boolean;
begin
  Result := Ftax_Specified;
end;

procedure Recur.SetseccCode(Index: Integer; const AseccCode3: seccCode3);
begin
  FseccCode := AseccCode3;
  FseccCode_Specified := True;
end;

function Recur.seccCode_Specified(Index: Integer): boolean;
begin
  Result := FseccCode_Specified;
end;

procedure Recur.SetachAcctInfo(Index: Integer; const AachAcctInfo2: achAcctInfo2);
begin
  FachAcctInfo := AachAcctInfo2;
  FachAcctInfo_Specified := True;
end;

function Recur.achAcctInfo_Specified(Index: Integer): boolean;
begin
  Result := FachAcctInfo_Specified;
end;

procedure CustCrta.Setid(Index: Integer; const Aid4: id4);
begin
  Fid := Aid4;
  Fid_Specified := True;
end;

function CustCrta.id_Specified(Index: Integer): boolean;
begin
  Result := Fid_Specified;
end;

procedure CustCrta.SetcoName(Index: Integer; const AcoName2: coName2);
begin
  FcoName := AcoName2;
  FcoName_Specified := True;
end;

function CustCrta.coName_Specified(Index: Integer): boolean;
begin
  Result := FcoName_Specified;
end;

procedure CustCrta.SetfirstName(Index: Integer; const AfirstName2: firstName2);
begin
  FfirstName := AfirstName2;
  FfirstName_Specified := True;
end;

function CustCrta.firstName_Specified(Index: Integer): boolean;
begin
  Result := FfirstName_Specified;
end;

procedure CustCrta.SetlastName(Index: Integer; const AlastName2: lastName2);
begin
  FlastName := AlastName2;
  FlastName_Specified := True;
end;

function CustCrta.lastName_Specified(Index: Integer): boolean;
begin
  Result := FlastName_Specified;
end;

procedure CustCrta.SetfullName(Index: Integer; const AfullName2: fullName2);
begin
  FfullName := AfullName2;
  FfullName_Specified := True;
end;

function CustCrta.fullName_Specified(Index: Integer): boolean;
begin
  Result := FfullName_Specified;
end;

procedure CustCrta.Setstat(Index: Integer; const Astat: stat);
begin
  Fstat := Astat;
  Fstat_Specified := True;
end;

function CustCrta.stat_Specified(Index: Integer): boolean;
begin
  Result := Fstat_Specified;
end;

procedure Merc.Setid(Index: Integer; const Aid10: id10);
begin
  Fid := Aid10;
  Fid_Specified := True;
end;

function Merc.id_Specified(Index: Integer): boolean;
begin
  Result := Fid_Specified;
end;

procedure Merc.SetregKey(Index: Integer; const AregKey: regKey);
begin
  FregKey := AregKey;
  FregKey_Specified := True;
end;

function Merc.regKey_Specified(Index: Integer): boolean;
begin
  Result := FregKey_Specified;
end;

procedure Merc.SetusrId(Index: Integer; const AusrId: usrId);
begin
  FusrId := AusrId;
  FusrId_Specified := True;
end;

function Merc.usrId_Specified(Index: Integer): boolean;
begin
  Result := FusrId_Specified;
end;

procedure Merc.Setpwd(Index: Integer; const Apwd: pwd);
begin
  Fpwd := Apwd;
  Fpwd_Specified := True;
end;

function Merc.pwd_Specified(Index: Integer): boolean;
begin
  Result := Fpwd_Specified;
end;

procedure Merc.SetprodType(Index: Integer; const AprodType: prodType);
begin
  FprodType := AprodType;
  FprodType_Specified := True;
end;

function Merc.prodType_Specified(Index: Integer): boolean;
begin
  Result := FprodType_Specified;
end;

procedure Ship.SetfullName(Index: Integer; const AfullName3: fullName3);
begin
  FfullName := AfullName3;
  FfullName_Specified := True;
end;

function Ship.fullName_Specified(Index: Integer): boolean;
begin
  Result := FfullName_Specified;
end;

procedure Ship.SetaddrLn1(Index: Integer; const AaddrLn1: addrLn1);
begin
  FaddrLn1 := AaddrLn1;
  FaddrLn1_Specified := True;
end;

function Ship.addrLn1_Specified(Index: Integer): boolean;
begin
  Result := FaddrLn1_Specified;
end;

procedure Ship.SetaddrLn2(Index: Integer; const AaddrLn2: addrLn2);
begin
  FaddrLn2 := AaddrLn2;
  FaddrLn2_Specified := True;
end;

function Ship.addrLn2_Specified(Index: Integer): boolean;
begin
  Result := FaddrLn2_Specified;
end;

procedure Ship.Setcity(Index: Integer; const Acity: city);
begin
  Fcity := Acity;
  Fcity_Specified := True;
end;

function Ship.city_Specified(Index: Integer): boolean;
begin
  Result := Fcity_Specified;
end;

procedure Ship.Setstate(Index: Integer; const Astate2: state2);
begin
  Fstate := Astate2;
  Fstate_Specified := True;
end;

function Ship.state_Specified(Index: Integer): boolean;
begin
  Result := Fstate_Specified;
end;

procedure Ship.SetzipCode(Index: Integer; const AzipCode: zipCode);
begin
  FzipCode := AzipCode;
  FzipCode_Specified := True;
end;

function Ship.zipCode_Specified(Index: Integer): boolean;
begin
  Result := FzipCode_Specified;
end;

procedure Ship.Setphone(Index: Integer; const Aphone: phone);
begin
  Fphone := Aphone;
  Fphone_Specified := True;
end;

function Ship.phone_Specified(Index: Integer): boolean;
begin
  Result := Fphone_Specified;
end;

procedure Ship.Setemail(Index: Integer; const Aemail: email);
begin
  Femail := Aemail;
  Femail_Specified := True;
end;

function Ship.email_Specified(Index: Integer): boolean;
begin
  Result := Femail_Specified;
end;

destructor Contact.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fphone)-1 do
    SysUtils.FreeAndNil(Fphone[I]);
  System.SetLength(Fphone, 0);
  SysUtils.FreeAndNil(Fship);
  inherited Destroy;
end;

procedure Contact.Setid(Index: Integer; const Aid9: id9);
begin
  Fid := Aid9;
  Fid_Specified := True;
end;

function Contact.id_Specified(Index: Integer): boolean;
begin
  Result := Fid_Specified;
end;

procedure Contact.SetfirstName(Index: Integer; const AfirstName: firstName);
begin
  FfirstName := AfirstName;
  FfirstName_Specified := True;
end;

function Contact.firstName_Specified(Index: Integer): boolean;
begin
  Result := FfirstName_Specified;
end;

procedure Contact.SetlastName(Index: Integer; const AlastName: lastName);
begin
  FlastName := AlastName;
  FlastName_Specified := True;
end;

function Contact.lastName_Specified(Index: Integer): boolean;
begin
  Result := FlastName_Specified;
end;

procedure Contact.SetfullName(Index: Integer; const AfullName: fullName);
begin
  FfullName := AfullName;
  FfullName_Specified := True;
end;

function Contact.fullName_Specified(Index: Integer): boolean;
begin
  Result := FfullName_Specified;
end;

procedure Contact.SetcoName(Index: Integer; const AcoName: coName);
begin
  FcoName := AcoName;
  FcoName_Specified := True;
end;

function Contact.coName_Specified(Index: Integer): boolean;
begin
  Result := FcoName_Specified;
end;

procedure Contact.Settitle(Index: Integer; const Atitle: title);
begin
  Ftitle := Atitle;
  Ftitle_Specified := True;
end;

function Contact.title_Specified(Index: Integer): boolean;
begin
  Result := Ftitle_Specified;
end;

procedure Contact.Setphone(Index: Integer; const AArray_Of_Phone: Array_Of_Phone);
begin
  Fphone := AArray_Of_Phone;
  Fphone_Specified := True;
end;

function Contact.phone_Specified(Index: Integer): boolean;
begin
  Result := Fphone_Specified;
end;

procedure Contact.SetaddrLn1(Index: Integer; const AaddrLn12: addrLn12);
begin
  FaddrLn1 := AaddrLn12;
  FaddrLn1_Specified := True;
end;

function Contact.addrLn1_Specified(Index: Integer): boolean;
begin
  Result := FaddrLn1_Specified;
end;

procedure Contact.SetaddrLn2(Index: Integer; const AaddrLn22: addrLn22);
begin
  FaddrLn2 := AaddrLn22;
  FaddrLn2_Specified := True;
end;

function Contact.addrLn2_Specified(Index: Integer): boolean;
begin
  Result := FaddrLn2_Specified;
end;

procedure Contact.Setcity(Index: Integer; const Acity2: city2);
begin
  Fcity := Acity2;
  Fcity_Specified := True;
end;

function Contact.city_Specified(Index: Integer): boolean;
begin
  Result := Fcity_Specified;
end;

procedure Contact.Setstate(Index: Integer; const Astate3: state3);
begin
  Fstate := Astate3;
  Fstate_Specified := True;
end;

function Contact.state_Specified(Index: Integer): boolean;
begin
  Result := Fstate_Specified;
end;

procedure Contact.SetzipCode(Index: Integer; const AzipCode2: zipCode2);
begin
  FzipCode := AzipCode2;
  FzipCode_Specified := True;
end;

function Contact.zipCode_Specified(Index: Integer): boolean;
begin
  Result := FzipCode_Specified;
end;

procedure Contact.Setctry(Index: Integer; const Actry: ctry);
begin
  Fctry := Actry;
  Fctry_Specified := True;
end;

function Contact.ctry_Specified(Index: Integer): boolean;
begin
  Result := Fctry_Specified;
end;

procedure Contact.Setemail(Index: Integer; const Aemail2: email2);
begin
  Femail := Aemail2;
  Femail_Specified := True;
end;

function Contact.email_Specified(Index: Integer): boolean;
begin
  Result := Femail_Specified;
end;

procedure Contact.Settype_(Index: Integer; const Atype_9: type_9);
begin
  Ftype_ := Atype_9;
  Ftype__Specified := True;
end;

function Contact.type__Specified(Index: Integer): boolean;
begin
  Result := Ftype__Specified;
end;

procedure Contact.Setstat(Index: Integer; const Astat4: stat4);
begin
  Fstat := Astat4;
  Fstat_Specified := True;
end;

function Contact.stat_Specified(Index: Integer): boolean;
begin
  Result := Fstat_Specified;
end;

procedure Contact.Setnote(Index: Integer; const Anote2: note2);
begin
  Fnote := Anote2;
  Fnote_Specified := True;
end;

function Contact.note_Specified(Index: Integer): boolean;
begin
  Result := Fnote_Specified;
end;

procedure Contact.Setship(Index: Integer; const AShip: Ship);
begin
  Fship := AShip;
  Fship_Specified := True;
end;

function Contact.ship_Specified(Index: Integer): boolean;
begin
  Result := Fship_Specified;
end;

destructor BillShip.Destroy;
begin
  SysUtils.FreeAndNil(Fcontact);
  inherited Destroy;
end;

procedure BillShip.Settype_(Index: Integer; const Atype_10: type_10);
begin
  Ftype_ := Atype_10;
  Ftype__Specified := True;
end;

function BillShip.type__Specified(Index: Integer): boolean;
begin
  Result := Ftype__Specified;
end;

procedure BillShip.Setcontact(Index: Integer; const AContact: Contact);
begin
  Fcontact := AContact;
  Fcontact_Specified := True;
end;

function BillShip.contact_Specified(Index: Integer): boolean;
begin
  Result := Fcontact_Specified;
end;

destructor TranData.Destroy;
begin
  SysUtils.FreeAndNil(FdtTm);
  inherited Destroy;
end;

procedure TranData.SetswchKey(Index: Integer; const AswchKey: swchKey);
begin
  FswchKey := AswchKey;
  FswchKey_Specified := True;
end;

function TranData.swchKey_Specified(Index: Integer): boolean;
begin
  Result := FswchKey_Specified;
end;

procedure TranData.SettranNr(Index: Integer; const AtranNr3: tranNr3);
begin
  FtranNr := AtranNr3;
  FtranNr_Specified := True;
end;

function TranData.tranNr_Specified(Index: Integer): boolean;
begin
  Result := FtranNr_Specified;
end;

procedure TranData.SetdtTm(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FdtTm := ATXSDateTime;
  FdtTm_Specified := True;
end;

function TranData.dtTm_Specified(Index: Integer): boolean;
begin
  Result := FdtTm_Specified;
end;

procedure TranData.Setamt(Index: Integer; const Aamt5: amt5);
begin
  Famt := Aamt5;
  Famt_Specified := True;
end;

function TranData.amt_Specified(Index: Integer): boolean;
begin
  Result := Famt_Specified;
end;

procedure TranData.Setstan(Index: Integer; const Astan: stan);
begin
  Fstan := Astan;
  Fstan_Specified := True;
end;

function TranData.stan_Specified(Index: Integer): boolean;
begin
  Result := Fstan_Specified;
end;

procedure TranData.Setauth(Index: Integer; const Aauth: auth);
begin
  Fauth := Aauth;
  Fauth_Specified := True;
end;

function TranData.auth_Specified(Index: Integer): boolean;
begin
  Result := Fauth_Specified;
end;

destructor LineItem.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Ftax)-1 do
    SysUtils.FreeAndNil(Ftax[I]);
  System.SetLength(Ftax, 0);
  inherited Destroy;
end;

procedure LineItem.SetitemNr(Index: Integer; const AitemNr2: itemNr2);
begin
  FitemNr := AitemNr2;
  FitemNr_Specified := True;
end;

function LineItem.itemNr_Specified(Index: Integer): boolean;
begin
  Result := FitemNr_Specified;
end;

procedure LineItem.SetprodCode(Index: Integer; const AprodCode: prodCode);
begin
  FprodCode := AprodCode;
  FprodCode_Specified := True;
end;

function LineItem.prodCode_Specified(Index: Integer): boolean;
begin
  Result := FprodCode_Specified;
end;

procedure LineItem.SetcustCode(Index: Integer; const AcustCode: custCode);
begin
  FcustCode := AcustCode;
  FcustCode_Specified := True;
end;

function LineItem.custCode_Specified(Index: Integer): boolean;
begin
  Result := FcustCode_Specified;
end;

procedure LineItem.SetcmdyCode(Index: Integer; const AcmdyCode: cmdyCode);
begin
  FcmdyCode := AcmdyCode;
  FcmdyCode_Specified := True;
end;

function LineItem.cmdyCode_Specified(Index: Integer): boolean;
begin
  Result := FcmdyCode_Specified;
end;

procedure LineItem.SetvatRefNr(Index: Integer; const AvatRefNr: vatRefNr);
begin
  FvatRefNr := AvatRefNr;
  FvatRefNr_Specified := True;
end;

function LineItem.vatRefNr_Specified(Index: Integer): boolean;
begin
  Result := FvatRefNr_Specified;
end;

procedure LineItem.Setdesc(Index: Integer; const Adesc4: desc4);
begin
  Fdesc := Adesc4;
  Fdesc_Specified := True;
end;

function LineItem.desc_Specified(Index: Integer): boolean;
begin
  Result := Fdesc_Specified;
end;

procedure LineItem.Setqty(Index: Integer; const Aqty: qty);
begin
  Fqty := Aqty;
  Fqty_Specified := True;
end;

function LineItem.qty_Specified(Index: Integer): boolean;
begin
  Result := Fqty_Specified;
end;

procedure LineItem.SetqtyExp(Index: Integer; const AqtyExp: qtyExp);
begin
  FqtyExp := AqtyExp;
  FqtyExp_Specified := True;
end;

function LineItem.qtyExp_Specified(Index: Integer): boolean;
begin
  Result := FqtyExp_Specified;
end;

procedure LineItem.SetunitOfMsr(Index: Integer; const AunitOfMsr2: unitOfMsr2);
begin
  FunitOfMsr := AunitOfMsr2;
  FunitOfMsr_Specified := True;
end;

function LineItem.unitOfMsr_Specified(Index: Integer): boolean;
begin
  Result := FunitOfMsr_Specified;
end;

procedure LineItem.SetunitPrc(Index: Integer; const AunitPrc: unitPrc);
begin
  FunitPrc := AunitPrc;
  FunitPrc_Specified := True;
end;

function LineItem.unitPrc_Specified(Index: Integer): boolean;
begin
  Result := FunitPrc_Specified;
end;

procedure LineItem.Setdcnt(Index: Integer; const Adcnt: dcnt);
begin
  Fdcnt := Adcnt;
  Fdcnt_Specified := True;
end;

function LineItem.dcnt_Specified(Index: Integer): boolean;
begin
  Result := Fdcnt_Specified;
end;

procedure LineItem.SetdcntRt(Index: Integer; const AdcntRt: dcntRt);
begin
  FdcntRt := AdcntRt;
  FdcntRt_Specified := True;
end;

function LineItem.dcntRt_Specified(Index: Integer): boolean;
begin
  Result := FdcntRt_Specified;
end;

procedure LineItem.SetdcntAmt(Index: Integer; const AdcntAmt: dcntAmt);
begin
  FdcntAmt := AdcntAmt;
  FdcntAmt_Specified := True;
end;

function LineItem.dcntAmt_Specified(Index: Integer): boolean;
begin
  Result := FdcntAmt_Specified;
end;

procedure LineItem.SettotAmt(Index: Integer; const AtotAmt: totAmt);
begin
  FtotAmt := AtotAmt;
  FtotAmt_Specified := True;
end;

function LineItem.totAmt_Specified(Index: Integer): boolean;
begin
  Result := FtotAmt_Specified;
end;

procedure LineItem.SettotAmtType(Index: Integer; const AtotAmtType: totAmtType);
begin
  FtotAmtType := AtotAmtType;
  FtotAmtType_Specified := True;
end;

function LineItem.totAmtType_Specified(Index: Integer): boolean;
begin
  Result := FtotAmtType_Specified;
end;

procedure LineItem.SetsupType(Index: Integer; const AsupType: supType);
begin
  FsupType := AsupType;
  FsupType_Specified := True;
end;

function LineItem.supType_Specified(Index: Integer): boolean;
begin
  Result := FsupType_Specified;
end;

procedure LineItem.Setsign(Index: Integer; const Asign: sign);
begin
  Fsign := Asign;
  Fsign_Specified := True;
end;

function LineItem.sign_Specified(Index: Integer): boolean;
begin
  Result := Fsign_Specified;
end;

procedure LineItem.SetprivData(Index: Integer; const AprivData2: privData2);
begin
  FprivData := AprivData2;
  FprivData_Specified := True;
end;

function LineItem.privData_Specified(Index: Integer): boolean;
begin
  Result := FprivData_Specified;
end;

procedure LineItem.Settax(Index: Integer; const AArray_Of_PurcCardTax: Array_Of_PurcCardTax);
begin
  Ftax := AArray_Of_PurcCardTax;
  Ftax_Specified := True;
end;

function LineItem.tax_Specified(Index: Integer): boolean;
begin
  Result := Ftax_Specified;
end;

procedure PurcCardTax.Settype_(Index: Integer; const Atype_11: type_11);
begin
  Ftype_ := Atype_11;
  Ftype__Specified := True;
end;

function PurcCardTax.type__Specified(Index: Integer): boolean;
begin
  Result := Ftype__Specified;
end;

procedure PurcCardTax.Setdesc(Index: Integer; const Adesc5: desc5);
begin
  Fdesc := Adesc5;
  Fdesc_Specified := True;
end;

function PurcCardTax.desc_Specified(Index: Integer): boolean;
begin
  Result := Fdesc_Specified;
end;

procedure PurcCardTax.Setincld(Index: Integer; const Aincld: incld);
begin
  Fincld := Aincld;
  Fincld_Specified := True;
end;

function PurcCardTax.incld_Specified(Index: Integer): boolean;
begin
  Result := Fincld_Specified;
end;

procedure PurcCardTax.Setamt(Index: Integer; const Aamt6: amt6);
begin
  Famt := Aamt6;
  Famt_Specified := True;
end;

function PurcCardTax.amt_Specified(Index: Integer): boolean;
begin
  Result := Famt_Specified;
end;

procedure PurcCardTax.Setrate(Index: Integer; const Arate: rate);
begin
  Frate := Arate;
  Frate_Specified := True;
end;

function PurcCardTax.rate_Specified(Index: Integer): boolean;
begin
  Result := Frate_Specified;
end;

procedure PurcCardTax.SetrateExp(Index: Integer; const ArateExp: rateExp);
begin
  FrateExp := ArateExp;
  FrateExp_Specified := True;
end;

function PurcCardTax.rateExp_Specified(Index: Integer): boolean;
begin
  Result := FrateExp_Specified;
end;

procedure PurcCardTax.SetcardAcptrId(Index: Integer; const AcardAcptrId: cardAcptrId);
begin
  FcardAcptrId := AcardAcptrId;
  FcardAcptrId_Specified := True;
end;

function PurcCardTax.cardAcptrId_Specified(Index: Integer): boolean;
begin
  Result := FcardAcptrId_Specified;
end;

procedure Card.Settype_(Index: Integer; const Atype_: type_);
begin
  Ftype_ := Atype_;
  Ftype__Specified := True;
end;

function Card.type__Specified(Index: Integer): boolean;
begin
  Result := Ftype__Specified;
end;

procedure Card.Setpan(Index: Integer; const Apan: pan);
begin
  Fpan := Apan;
  Fpan_Specified := True;
end;

function Card.pan_Specified(Index: Integer): boolean;
begin
  Result := Fpan_Specified;
end;

procedure Card.Setsec(Index: Integer; const Asec: sec);
begin
  Fsec := Asec;
  Fsec_Specified := True;
end;

function Card.sec_Specified(Index: Integer): boolean;
begin
  Result := Fsec_Specified;
end;

procedure Card.SetxprDt(Index: Integer; const AxprDt: xprDt);
begin
  FxprDt := AxprDt;
  FxprDt_Specified := True;
end;

function Card.xprDt_Specified(Index: Integer): boolean;
begin
  Result := FxprDt_Specified;
end;

procedure Card.SetsqncNr(Index: Integer; const AsqncNr: sqncNr);
begin
  FsqncNr := AsqncNr;
  FsqncNr_Specified := True;
end;

function Card.sqncNr_Specified(Index: Integer): boolean;
begin
  Result := FsqncNr_Specified;
end;

procedure Card.Settrk1(Index: Integer; const Atrk1: trk1);
begin
  Ftrk1 := Atrk1;
  Ftrk1_Specified := True;
end;

function Card.trk1_Specified(Index: Integer): boolean;
begin
  Result := Ftrk1_Specified;
end;

procedure Card.Settrk2(Index: Integer; const Atrk2: trk2);
begin
  Ftrk2 := Atrk2;
  Ftrk2_Specified := True;
end;

function Card.trk2_Specified(Index: Integer): boolean;
begin
  Result := Ftrk2_Specified;
end;

procedure Card.SetdbtOrCdt(Index: Integer; const AdbtOrCdt2: dbtOrCdt2);
begin
  FdbtOrCdt := AdbtOrCdt2;
  FdbtOrCdt_Specified := True;
end;

function Card.dbtOrCdt_Specified(Index: Integer): boolean;
begin
  Result := FdbtOrCdt_Specified;
end;

procedure TranFlags.SetdupChkTmPrd(Index: Integer; const AdupChkTmPrd: dupChkTmPrd);
begin
  FdupChkTmPrd := AdupChkTmPrd;
  FdupChkTmPrd_Specified := True;
end;

function TranFlags.dupChkTmPrd_Specified(Index: Integer): boolean;
begin
  Result := FdupChkTmPrd_Specified;
end;

procedure TranFlags.SetrevAuthOnVoid(Index: Integer; const ArevAuthOnVoid: revAuthOnVoid);
begin
  FrevAuthOnVoid := ArevAuthOnVoid;
  FrevAuthOnVoid_Specified := True;
end;

function TranFlags.revAuthOnVoid_Specified(Index: Integer): boolean;
begin
  Result := FrevAuthOnVoid_Specified;
end;

procedure TranFlags.Setrsbmt(Index: Integer; const Arsbmt: rsbmt);
begin
  Frsbmt := Arsbmt;
  Frsbmt_Specified := True;
end;

function TranFlags.rsbmt_Specified(Index: Integer): boolean;
begin
  Result := Frsbmt_Specified;
end;

procedure TranFlags.SetmgdSettle(Index: Integer; const AmgdSettle2: mgdSettle2);
begin
  FmgdSettle := AmgdSettle2;
  FmgdSettle_Specified := True;
end;

function TranFlags.mgdSettle_Specified(Index: Integer): boolean;
begin
  Result := FmgdSettle_Specified;
end;

procedure TranFlags.SetconvFeeAcptd(Index: Integer; const AconvFeeAcptd: convFeeAcptd);
begin
  FconvFeeAcptd := AconvFeeAcptd;
  FconvFeeAcptd_Specified := True;
end;

function TranFlags.convFeeAcptd_Specified(Index: Integer): boolean;
begin
  Result := FconvFeeAcptd_Specified;
end;

destructor AuthReq.Destroy;
begin
  SysUtils.FreeAndNil(FpurcCard);
  inherited Destroy;
end;

procedure AuthReq.Setxid(Index: Integer; const Axid: xid);
begin
  Fxid := Axid;
  Fxid_Specified := True;
end;

function AuthReq.xid_Specified(Index: Integer): boolean;
begin
  Result := Fxid_Specified;
end;

procedure AuthReq.Setcavv(Index: Integer; const Acavv: cavv);
begin
  Fcavv := Acavv;
  Fcavv_Specified := True;
end;

function AuthReq.cavv_Specified(Index: Integer): boolean;
begin
  Result := Fcavv_Specified;
end;

procedure AuthReq.SetucafIdcr(Index: Integer; const AucafIdcr: ucafIdcr);
begin
  FucafIdcr := AucafIdcr;
  FucafIdcr_Specified := True;
end;

function AuthReq.ucafIdcr_Specified(Index: Integer): boolean;
begin
  Result := FucafIdcr_Specified;
end;

procedure AuthReq.Setucaf(Index: Integer; const Aucaf: ucaf);
begin
  Fucaf := Aucaf;
  Fucaf_Specified := True;
end;

function AuthReq.ucaf_Specified(Index: Integer): boolean;
begin
  Result := Fucaf_Specified;
end;

procedure AuthReq.SetpurcCard(Index: Integer; const APurcCard: PurcCard);
begin
  FpurcCard := APurcCard;
  FpurcCard_Specified := True;
end;

function AuthReq.purcCard_Specified(Index: Integer): boolean;
begin
  Result := FpurcCard_Specified;
end;

procedure AuthReq.SeteSign(Index: Integer; const AeSign: eSign);
begin
  FeSign := AeSign;
  FeSign_Specified := True;
end;

function AuthReq.eSign_Specified(Index: Integer): boolean;
begin
  Result := FeSign_Specified;
end;

procedure AuthReq.SetvoiceAuthCode(Index: Integer; const AvoiceAuthCode: voiceAuthCode);
begin
  FvoiceAuthCode := AvoiceAuthCode;
  FvoiceAuthCode_Specified := True;
end;

function AuthReq.voiceAuthCode_Specified(Index: Integer): boolean;
begin
  Result := FvoiceAuthCode_Specified;
end;

procedure AuthReq.SetordNr(Index: Integer; const AordNr5: ordNr5);
begin
  FordNr := AordNr5;
  FordNr_Specified := True;
end;

function AuthReq.ordNr_Specified(Index: Integer): boolean;
begin
  Result := FordNr_Specified;
end;

procedure AuthReq.SetvchrNr(Index: Integer; const AvchrNr: vchrNr);
begin
  FvchrNr := AvchrNr;
  FvchrNr_Specified := True;
end;

function AuthReq.vchrNr_Specified(Index: Integer): boolean;
begin
  Result := FvchrNr_Specified;
end;

procedure AuthReq.Setpin(Index: Integer; const Apin: pin);
begin
  Fpin := Apin;
  Fpin_Specified := True;
end;

function AuthReq.pin_Specified(Index: Integer): boolean;
begin
  Result := Fpin_Specified;
end;

destructor PurcCard.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FlineItem)-1 do
    SysUtils.FreeAndNil(FlineItem[I]);
  System.SetLength(FlineItem, 0);
  for I := 0 to System.Length(Ftax)-1 do
    SysUtils.FreeAndNil(Ftax[I]);
  System.SetLength(Ftax, 0);
  SysUtils.FreeAndNil(FordDt);
  SysUtils.FreeAndNil(FpurcDt);
  SysUtils.FreeAndNil(FbillShip);
  inherited Destroy;
end;

procedure PurcCard.SetcustId(Index: Integer; const AcustId4: custId4);
begin
  FcustId := AcustId4;
  FcustId_Specified := True;
end;

function PurcCard.custId_Specified(Index: Integer): boolean;
begin
  Result := FcustId_Specified;
end;

procedure PurcCard.SetcardAcptrTaxId(Index: Integer; const AcardAcptrTaxId: cardAcptrTaxId);
begin
  FcardAcptrTaxId := AcardAcptrTaxId;
  FcardAcptrTaxId_Specified := True;
end;

function PurcCard.cardAcptrTaxId_Specified(Index: Integer): boolean;
begin
  Result := FcardAcptrTaxId_Specified;
end;

procedure PurcCard.SetcardAcptrVatNr(Index: Integer; const AcardAcptrVatNr: cardAcptrVatNr);
begin
  FcardAcptrVatNr := AcardAcptrVatNr;
  FcardAcptrVatNr_Specified := True;
end;

function PurcCard.cardAcptrVatNr_Specified(Index: Integer): boolean;
begin
  Result := FcardAcptrVatNr_Specified;
end;

procedure PurcCard.SetcardAcptrRefNr(Index: Integer; const AcardAcptrRefNr: cardAcptrRefNr);
begin
  FcardAcptrRefNr := AcardAcptrRefNr;
  FcardAcptrRefNr_Specified := True;
end;

function PurcCard.cardAcptrRefNr_Specified(Index: Integer): boolean;
begin
  Result := FcardAcptrRefNr_Specified;
end;

procedure PurcCard.SetcorpVatNr(Index: Integer; const AcorpVatNr: corpVatNr);
begin
  FcorpVatNr := AcorpVatNr;
  FcorpVatNr_Specified := True;
end;

function PurcCard.corpVatNr_Specified(Index: Integer): boolean;
begin
  Result := FcorpVatNr_Specified;
end;

procedure PurcCard.SetcustVatNr(Index: Integer; const AcustVatNr: custVatNr);
begin
  FcustVatNr := AcustVatNr;
  FcustVatNr_Specified := True;
end;

function PurcCard.custVatNr_Specified(Index: Integer): boolean;
begin
  Result := FcustVatNr_Specified;
end;

procedure PurcCard.SetmercOrdNr(Index: Integer; const AmercOrdNr: mercOrdNr);
begin
  FmercOrdNr := AmercOrdNr;
  FmercOrdNr_Specified := True;
end;

function PurcCard.mercOrdNr_Specified(Index: Integer): boolean;
begin
  Result := FmercOrdNr_Specified;
end;

procedure PurcCard.SetinvcNr(Index: Integer; const AinvcNr: invcNr);
begin
  FinvcNr := AinvcNr;
  FinvcNr_Specified := True;
end;

function PurcCard.invcNr_Specified(Index: Integer): boolean;
begin
  Result := FinvcNr_Specified;
end;

procedure PurcCard.SetordDt(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FordDt := ATXSDateTime;
  FordDt_Specified := True;
end;

function PurcCard.ordDt_Specified(Index: Integer): boolean;
begin
  Result := FordDt_Specified;
end;

procedure PurcCard.SetpurcDt(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FpurcDt := ATXSDateTime;
  FpurcDt_Specified := True;
end;

function PurcCard.purcDt_Specified(Index: Integer): boolean;
begin
  Result := FpurcDt_Specified;
end;

procedure PurcCard.SetcustBlngCode(Index: Integer; const AcustBlngCode: custBlngCode);
begin
  FcustBlngCode := AcustBlngCode;
  FcustBlngCode_Specified := True;
end;

function PurcCard.custBlngCode_Specified(Index: Integer): boolean;
begin
  Result := FcustBlngCode_Specified;
end;

procedure PurcCard.SetcustOrdNr(Index: Integer; const AcustOrdNr: custOrdNr);
begin
  FcustOrdNr := AcustOrdNr;
  FcustOrdNr_Specified := True;
end;

function PurcCard.custOrdNr_Specified(Index: Integer): boolean;
begin
  Result := FcustOrdNr_Specified;
end;

procedure PurcCard.SettaxExmp(Index: Integer; const AtaxExmp: taxExmp);
begin
  FtaxExmp := AtaxExmp;
  FtaxExmp_Specified := True;
end;

function PurcCard.taxExmp_Specified(Index: Integer): boolean;
begin
  Result := FtaxExmp_Specified;
end;

procedure PurcCard.SetcmdyCode(Index: Integer; const AcmdyCode2: cmdyCode2);
begin
  FcmdyCode := AcmdyCode2;
  FcmdyCode_Specified := True;
end;

function PurcCard.cmdyCode_Specified(Index: Integer): boolean;
begin
  Result := FcmdyCode_Specified;
end;

procedure PurcCard.Setdesc(Index: Integer; const Adesc6: desc6);
begin
  Fdesc := Adesc6;
  Fdesc_Specified := True;
end;

function PurcCard.desc_Specified(Index: Integer): boolean;
begin
  Result := Fdesc_Specified;
end;

procedure PurcCard.SetdcntAmt(Index: Integer; const AdcntAmt2: dcntAmt2);
begin
  FdcntAmt := AdcntAmt2;
  FdcntAmt_Specified := True;
end;

function PurcCard.dcntAmt_Specified(Index: Integer): boolean;
begin
  Result := FdcntAmt_Specified;
end;

procedure PurcCard.SetshpAmt(Index: Integer; const AshpAmt: shpAmt);
begin
  FshpAmt := AshpAmt;
  FshpAmt_Specified := True;
end;

function PurcCard.shpAmt_Specified(Index: Integer): boolean;
begin
  Result := FshpAmt_Specified;
end;

procedure PurcCard.SetdutyAmt(Index: Integer; const AdutyAmt: dutyAmt);
begin
  FdutyAmt := AdutyAmt;
  FdutyAmt_Specified := True;
end;

function PurcCard.dutyAmt_Specified(Index: Integer): boolean;
begin
  Result := FdutyAmt_Specified;
end;

procedure PurcCard.SettaxColld(Index: Integer; const AtaxColld: taxColld);
begin
  FtaxColld := AtaxColld;
  FtaxColld_Specified := True;
end;

function PurcCard.taxColld_Specified(Index: Integer): boolean;
begin
  Result := FtaxColld_Specified;
end;

procedure PurcCard.SettotAmt(Index: Integer; const AtotAmt2: totAmt2);
begin
  FtotAmt := AtotAmt2;
  FtotAmt_Specified := True;
end;

function PurcCard.totAmt_Specified(Index: Integer): boolean;
begin
  Result := FtotAmt_Specified;
end;

procedure PurcCard.Setcmnt(Index: Integer; const Acmnt: cmnt);
begin
  Fcmnt := Acmnt;
  Fcmnt_Specified := True;
end;

function PurcCard.cmnt_Specified(Index: Integer): boolean;
begin
  Result := Fcmnt_Specified;
end;

procedure PurcCard.SetprivData(Index: Integer; const AprivData: privData);
begin
  FprivData := AprivData;
  FprivData_Specified := True;
end;

function PurcCard.privData_Specified(Index: Integer): boolean;
begin
  Result := FprivData_Specified;
end;

procedure PurcCard.SetlineItem(Index: Integer; const AArray_Of_LineItem: Array_Of_LineItem);
begin
  FlineItem := AArray_Of_LineItem;
  FlineItem_Specified := True;
end;

function PurcCard.lineItem_Specified(Index: Integer): boolean;
begin
  Result := FlineItem_Specified;
end;

procedure PurcCard.Settax(Index: Integer; const AArray_Of_PurcCardTax: Array_Of_PurcCardTax);
begin
  Ftax := AArray_Of_PurcCardTax;
  Ftax_Specified := True;
end;

function PurcCard.tax_Specified(Index: Integer): boolean;
begin
  Result := Ftax_Specified;
end;

procedure PurcCard.SetbillShip(Index: Integer; const ABillShip: BillShip);
begin
  FbillShip := ABillShip;
  FbillShip_Specified := True;
end;

function PurcCard.billShip_Specified(Index: Integer): boolean;
begin
  Result := FbillShip_Specified;
end;

initialization
  { MerchantWebServicesPortType }
  InvRegistry.RegisterInterface(TypeInfo(MerchantWebServicesPortType), 'http://postilion/realtime/merchantframework/wsdl/v1/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MerchantWebServicesPortType), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(MerchantWebServicesPortType), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(MerchantWebServicesPortType), ioLiteral);
  RemClassRegistry.RegisterXSInfo(TypeInfo(id), 'http://postilion/realtime/merchantframework/xsd/v1/', 'id');
  RemClassRegistry.RegisterXSInfo(TypeInfo(id2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'id2', 'id');
  RemClassRegistry.RegisterXSInfo(TypeInfo(id3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'id3', 'id');
  RemClassRegistry.RegisterXSInfo(TypeInfo(prodId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'prodId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(id4), 'http://postilion/realtime/merchantframework/xsd/v1/', 'id4', 'id');
  RemClassRegistry.RegisterXSInfo(TypeInfo(cavvRslt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'cavvRslt');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(cavvRslt), '_0', '0');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(cavvRslt), '_1', '1');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(cavvRslt), '_2', '2');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(cavvRslt), '_3', '3');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(cavvRslt), '_4', '4');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(cavvRslt), '_6', '6');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(cavvRslt), '_7', '7');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(cavvRslt), '_8', '8');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(cavvRslt), '_9', '9');
  RemClassRegistry.RegisterXSInfo(TypeInfo(custId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'custId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pmtId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pmtId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(blngCyc), 'http://postilion/realtime/merchantframework/xsd/v1/', 'blngCyc');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_0', '0');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_10', '10');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_20', '20');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_30', '30');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_40', '40');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_50', '50');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_51', '51');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_52', '52');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_60', '60');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_70', '70');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_80', '80');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(blngCyc), '_90', '90');
  RemClassRegistry.RegisterXSInfo(TypeInfo(prodId2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'prodId2', 'prodId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pmtId2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pmtId2', 'pmtId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(id5), 'http://postilion/realtime/merchantframework/xsd/v1/', 'id5', 'id');
  RemClassRegistry.RegisterXSInfo(TypeInfo(custId2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'custId2', 'custId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(custId3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'custId3', 'custId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pmtId3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pmtId3', 'pmtId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(id6), 'http://postilion/realtime/merchantframework/xsd/v1/', 'id6', 'id');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_AdditionalAmount), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_AdditionalAmount');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_SettleData), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_SettleData');
  RemClassRegistry.RegisterXSClass(SettleTranRequest, 'http://postilion/realtime/merchantframework/xsd/v1/', 'SettleTranRequest');
  RemClassRegistry.RegisterSerializeOptions(SettleTranRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_ProdData), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_ProdData');
  RemClassRegistry.RegisterXSClass(UpdtRecurrProfRequest, 'http://postilion/realtime/merchantframework/xsd/v1/', 'UpdtRecurrProfRequest');
  RemClassRegistry.RegisterSerializeOptions(UpdtRecurrProfRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_pmtId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_pmtId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_Cust), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_Cust');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_RecurProf), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_RecurProf');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_prodId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_prodId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_pmtId2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_pmtId2', 'Array_Of_pmtId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_Phone), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_Phone');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_LineItem), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_LineItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_NameVal), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_NameVal');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_Pmt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_Pmt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_PurcCardTax), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_PurcCardTax');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_ProdInfo), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_ProdInfo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pmtId4), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pmtId4', 'pmtId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(recurProfId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'recurProfId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(id7), 'http://postilion/realtime/merchantframework/xsd/v1/', 'id7', 'id');
  RemClassRegistry.RegisterXSInfo(TypeInfo(id8), 'http://postilion/realtime/merchantframework/xsd/v1/', 'id8', 'id');
  RemClassRegistry.RegisterXSInfo(TypeInfo(invId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'invId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(accountType), 'http://postilion/realtime/merchantframework/xsd/v1/', 'accountType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_00', '00');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_08', '08');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_09', '09');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_10', '10');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_11', '11');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_12', '12');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_18', '18');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_19', '19');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_20', '20');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_21', '21');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_28', '28');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_29', '29');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_30', '30');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_31', '31');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_32', '32');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_33', '33');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_34', '34');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_35', '35');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_39', '39');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_40', '40');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_48', '48');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_49', '49');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_50', '50');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_51', '51');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_52', '52');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_53', '53');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_58', '58');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_59', '59');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_60', '60');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_67', '67');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_68', '68');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_69', '69');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_70', '70');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_71', '71');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_72', '72');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_73', '73');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_91', '91');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(accountType), '_92', '92');
  RemClassRegistry.RegisterXSInfo(TypeInfo(amountType), 'http://postilion/realtime/merchantframework/xsd/v1/', 'amountType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_00', '00');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_01', '01');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_02', '02');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_05', '05');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_20', '20');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_40', '40');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_53', '53');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_57', '57');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_80', '80');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_81', '81');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_90', '90');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_91', '91');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_3S', '3S');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_4S', '4S');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_4T', '4T');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_4U', '4U');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_4V', '4V');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_4W', '4W');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(amountType), '_4X', '4X');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tranCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'tranCode');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_0', '0');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_1', '1');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_2', '2');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_3', '3');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_4', '4');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_5', '5');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_6', '6');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_7', '7');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_9', '9');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_10', '10');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_11', '11');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_12', '12');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_13', '13');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_14', '14');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_15', '15');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_16', '16');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_17', '17');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(tranCode), '_18', '18');
  RemClassRegistry.RegisterXSInfo(TypeInfo(state), 'http://postilion/realtime/merchantframework/xsd/v1/', 'state');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(state), 'AS_', 'AS');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(state), 'IN_', 'IN');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(state), 'OR_', 'OR');
  RemClassRegistry.RegisterXSInfo(TypeInfo(inType), 'http://postilion/realtime/merchantframework/xsd/v1/', 'inType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(prodType), 'http://postilion/realtime/merchantframework/xsd/v1/', 'prodType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(fraudChk), 'http://postilion/realtime/merchantframework/xsd/v1/', 'fraudChk');
  RemClassRegistry.RegisterXSInfo(TypeInfo(type_), 'http://postilion/realtime/merchantframework/xsd/v1/', 'type_', 'type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(checkNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'checkNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(type_2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'type_2', 'type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(seccCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'seccCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(acctType), 'http://postilion/realtime/merchantframework/xsd/v1/', 'acctType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(indCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'indCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(type_3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'type_3', 'type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(type_4), 'http://postilion/realtime/merchantframework/xsd/v1/', 'type_4', 'type');
  RemClassRegistry.RegisterXSClass(RecurProf, 'http://postilion/realtime/merchantframework/xsd/v1/', 'RecurProf');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(RecurProf), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(seccCode2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'seccCode2', 'seccCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(type_5), 'http://postilion/realtime/merchantframework/xsd/v1/', 'type_5', 'type');
  RemClassRegistry.RegisterXSClass(FndRecurrProfRequest, 'http://postilion/realtime/merchantframework/xsd/v1/', 'FndRecurrProfRequest');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(FndRecurrProfRequest), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterSerializeOptions(FndRecurrProfRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(status), 'http://postilion/realtime/merchantframework/xsd/v1/', 'status');
  RemClassRegistry.RegisterXSInfo(TypeInfo(indCode2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'indCode2', 'indCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dbtOrCdt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'dbtOrCdt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(recurProfStat), 'http://postilion/realtime/merchantframework/xsd/v1/', 'recurProfStat');
  RemClassRegistry.RegisterXSInfo(TypeInfo(type_6), 'http://postilion/realtime/merchantframework/xsd/v1/', 'type_6', 'type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(nrOfPmtRem), 'http://postilion/realtime/merchantframework/xsd/v1/', 'nrOfPmtRem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(nrOfPmtProc), 'http://postilion/realtime/merchantframework/xsd/v1/', 'nrOfPmtProc');
  RemClassRegistry.RegisterXSInfo(TypeInfo(indCode3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'indCode3', 'indCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(nrOfPmt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'nrOfPmt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(initRecurPmtIdcr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'initRecurPmtIdcr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pmtFreq), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pmtFreq');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pmtNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pmtNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(nrOfPmt2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'nrOfPmt2', 'nrOfPmt');
  RemClassRegistry.RegisterXSClass(RecurPmt, 'http://postilion/realtime/merchantframework/xsd/v1/', 'RecurPmt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(stat), 'http://postilion/realtime/merchantframework/xsd/v1/', 'stat');
  RemClassRegistry.RegisterXSInfo(TypeInfo(itemNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'itemNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(stat2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'stat2', 'stat');
  RemClassRegistry.RegisterXSInfo(TypeInfo(stat3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'stat3', 'stat');
  RemClassRegistry.RegisterXSInfo(TypeInfo(idcr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'idcr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(seccCode3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'seccCode3', 'seccCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(type_7), 'http://postilion/realtime/merchantframework/xsd/v1/', 'type_7', 'type');
  RemClassRegistry.RegisterXSClass(Cust, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Cust');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Cust), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSClass(BaseFaultType, 'http://postilion/realtime/portal/soa/xsd/Faults/2009/01', 'BaseFaultType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BaseFaultType), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BaseFaultType), 'message_', '[ExtName="message"]');
  RemClassRegistry.RegisterXSClass(SystemFault, 'http://postilion/realtime/portal/soa/xsd/Faults/2009/01', 'SystemFault');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SystemFault), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SystemFault), 'message_', '[ExtName="message"]');
  RemClassRegistry.RegisterXSClass(ServiceFault, 'http://postilion/realtime/portal/soa/xsd/Faults/2009/01', 'ServiceFault');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ServiceFault), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ServiceFault), 'message_', '[ExtName="message"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(lastName), 'http://postilion/realtime/merchantframework/xsd/v1/', 'lastName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(firstName), 'http://postilion/realtime/merchantframework/xsd/v1/', 'firstName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(coName), 'http://postilion/realtime/merchantframework/xsd/v1/', 'coName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(fullName), 'http://postilion/realtime/merchantframework/xsd/v1/', 'fullName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(id9), 'http://postilion/realtime/merchantframework/xsd/v1/', 'id9', 'id');
  RemClassRegistry.RegisterXSInfo(TypeInfo(phone), 'http://postilion/realtime/merchantframework/xsd/v1/', 'phone');
  RemClassRegistry.RegisterXSInfo(TypeInfo(termId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'termId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(storeNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'storeNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(fiid), 'http://postilion/realtime/merchantframework/xsd/v1/', 'fiid');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pmtDesc), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pmtDesc');
  RemClassRegistry.RegisterXSInfo(TypeInfo(mcc), 'http://postilion/realtime/merchantframework/xsd/v1/', 'mcc');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dtBirth), 'http://postilion/realtime/merchantframework/xsd/v1/', 'dtBirth');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pan), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pan');
  RemClassRegistry.RegisterXSInfo(TypeInfo(xprDt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'xprDt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(sec), 'http://postilion/realtime/merchantframework/xsd/v1/', 'sec');
  RemClassRegistry.RegisterXSInfo(TypeInfo(aba), 'http://postilion/realtime/merchantframework/xsd/v1/', 'aba');
  RemClassRegistry.RegisterXSClass(Pos, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Pos');
  RemClassRegistry.RegisterXSInfo(TypeInfo(val), 'http://postilion/realtime/merchantframework/xsd/v1/', 'val');
  RemClassRegistry.RegisterXSInfo(TypeInfo(name_), 'http://postilion/realtime/merchantframework/xsd/v1/', 'name_', 'name');
  RemClassRegistry.RegisterXSClass(NameVal, 'http://postilion/realtime/merchantframework/xsd/v1/', 'NameVal');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(NameVal), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(nr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'nr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(nr2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'nr2', 'nr');
  RemClassRegistry.RegisterXSClass(DriversLicense, 'http://postilion/realtime/merchantframework/xsd/v1/', 'DriversLicense');
  RemClassRegistry.RegisterXSInfo(TypeInfo(email), 'http://postilion/realtime/merchantframework/xsd/v1/', 'email');
  RemClassRegistry.RegisterXSInfo(TypeInfo(nr3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'nr3', 'nr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(type_8), 'http://postilion/realtime/merchantframework/xsd/v1/', 'type_8', 'type');
  RemClassRegistry.RegisterXSClass(Identity, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Identity');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Identity), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(acctNrEncrypt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'acctNrEncrypt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(acctNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'acctNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(bankName), 'http://postilion/realtime/merchantframework/xsd/v1/', 'bankName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(achId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'achId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(bankRtNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'bankRtNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(achAcctInfo), 'http://postilion/realtime/merchantframework/xsd/v1/', 'achAcctInfo');
  RemClassRegistry.RegisterXSClass(AchEcheck, 'http://postilion/realtime/merchantframework/xsd/v1/', 'AchEcheck');
  RemClassRegistry.RegisterXSInfo(TypeInfo(amount), 'http://postilion/realtime/merchantframework/xsd/v1/', 'amount');
  RemClassRegistry.RegisterXSInfo(TypeInfo(amountSign), 'http://postilion/realtime/merchantframework/xsd/v1/', 'amountSign');
  RemClassRegistry.RegisterXSInfo(TypeInfo(currencyCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'currencyCode');
  RemClassRegistry.RegisterXSClass(AdditionalAmount, 'http://postilion/realtime/merchantframework/xsd/v1/', 'AdditionalAmount');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Note), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Note');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_Note), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Array_Of_Note');
  RemClassRegistry.RegisterXSInfo(TypeInfo(rspCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'rspCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(extRspCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'extRspCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(goodsSoldCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'goodsSoldCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(prevSettleAmt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'prevSettleAmt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(reqAmt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'reqAmt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(deviceType), 'http://postilion/realtime/merchantframework/xsd/v1/', 'deviceType');
  RemClassRegistry.RegisterXSClass(SendTranRequest, 'http://postilion/realtime/merchantframework/xsd/v1/', 'SendTranRequest');
  RemClassRegistry.RegisterSerializeOptions(SendTranRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_), 'http://postilion/realtime/merchantframework/xsd/v1/', 'Message_', 'Message');
  RemClassRegistry.RegisterXSInfo(TypeInfo(quantity), 'http://postilion/realtime/merchantframework/xsd/v1/', 'quantity');
  RemClassRegistry.RegisterXSClass(ProdData, 'http://postilion/realtime/merchantframework/xsd/v1/', 'ProdData');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ProdData), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pmtDesc2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pmtDesc2', 'pmtDesc');
  RemClassRegistry.RegisterXSClass(AchResponse, 'http://postilion/realtime/merchantframework/xsd/v1/', 'AchResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(AchResponse), 'Message_', '[ExtName="Message"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ordNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'ordNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(acctNr2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'acctNr2', 'acctNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(sec2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'sec2', 'sec');
  RemClassRegistry.RegisterXSClass(RecurMan, 'http://postilion/realtime/merchantframework/xsd/v1/', 'RecurMan');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pan2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pan2', 'pan');
  RemClassRegistry.RegisterXSClass(PmtCrta, 'http://postilion/realtime/merchantframework/xsd/v1/', 'PmtCrta');
  RemClassRegistry.RegisterXSInfo(TypeInfo(cardType), 'http://postilion/realtime/merchantframework/xsd/v1/', 'cardType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(mercId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'mercId');
  RemClassRegistry.RegisterXSClass(FndRecurrProfResponse, 'http://postilion/realtime/merchantframework/xsd/v1/', 'FndRecurrProfResponse');
  RemClassRegistry.RegisterSerializeOptions(FndRecurrProfResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(mapCaid), 'http://postilion/realtime/merchantframework/xsd/v1/', 'mapCaid');
  RemClassRegistry.RegisterXSClass(SendTranResponse, 'http://postilion/realtime/merchantframework/xsd/v1/', 'SendTranResponse');
  RemClassRegistry.RegisterSerializeOptions(SendTranResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(rspCode2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'rspCode2', 'rspCode');
  RemClassRegistry.RegisterXSClass(SettleTranResponse, 'http://postilion/realtime/merchantframework/xsd/v1/', 'SettleTranResponse');
  RemClassRegistry.RegisterSerializeOptions(SettleTranResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(rspCode3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'rspCode3', 'rspCode');
  RemClassRegistry.RegisterXSClass(RecurrProfFromTranResponse, 'http://postilion/realtime/merchantframework/xsd/v1/', 'RecurrProfFromTranResponse');
  RemClassRegistry.RegisterSerializeOptions(RecurrProfFromTranResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(rspCode4), 'http://postilion/realtime/merchantframework/xsd/v1/', 'rspCode4', 'rspCode');
  RemClassRegistry.RegisterXSClass(UpdtRecurrProfResponse, 'http://postilion/realtime/merchantframework/xsd/v1/', 'UpdtRecurrProfResponse');
  RemClassRegistry.RegisterSerializeOptions(UpdtRecurrProfResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(tranNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'tranNr');
  RemClassRegistry.RegisterXSClass(RecurrProfFromTranRequest, 'http://postilion/realtime/merchantframework/xsd/v1/', 'RecurrProfFromTranRequest');
  RemClassRegistry.RegisterSerializeOptions(RecurrProfFromTranRequest, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ordNr2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'ordNr2', 'ordNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(amt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'amt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(desc), 'http://postilion/realtime/merchantframework/xsd/v1/', 'desc');
  RemClassRegistry.RegisterXSInfo(TypeInfo(amt2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'amt2', 'amt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ordNr3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'ordNr3', 'ordNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(desc2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'desc2', 'desc');
  RemClassRegistry.RegisterXSInfo(TypeInfo(avsRslt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'avsRslt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(secRslt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'secRslt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(aci), 'http://postilion/realtime/merchantframework/xsd/v1/', 'aci');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tranId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'tranId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(gwyTranId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'gwyTranId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(mgdSettle), 'http://postilion/realtime/merchantframework/xsd/v1/', 'mgdSettle');
  RemClassRegistry.RegisterXSInfo(TypeInfo(amt3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'amt3', 'amt');
  RemClassRegistry.RegisterXSClass(Pmt, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Pmt');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Pmt), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(valCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'valCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(issrNtwkId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'issrNtwkId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(comCardType), 'http://postilion/realtime/merchantframework/xsd/v1/', 'comCardType');
  RemClassRegistry.RegisterXSClass(AuthRsp, 'http://postilion/realtime/merchantframework/xsd/v1/', 'AuthRsp');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tranNr2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'tranNr2', 'tranNr');
  RemClassRegistry.RegisterXSClass(SettleData, 'http://postilion/realtime/merchantframework/xsd/v1/', 'SettleData');
  RemClassRegistry.RegisterXSInfo(TypeInfo(prodName), 'http://postilion/realtime/merchantframework/xsd/v1/', 'prodName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(taxPctg), 'http://postilion/realtime/merchantframework/xsd/v1/', 'taxPctg');
  RemClassRegistry.RegisterXSInfo(TypeInfo(unitOfMsr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'unitOfMsr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(desc3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'desc3', 'desc');
  RemClassRegistry.RegisterXSInfo(TypeInfo(price), 'http://postilion/realtime/merchantframework/xsd/v1/', 'price');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ordNr4), 'http://postilion/realtime/merchantframework/xsd/v1/', 'ordNr4', 'ordNr');
  RemClassRegistry.RegisterXSClass(RecurProfCrta, 'http://postilion/realtime/merchantframework/xsd/v1/', 'RecurProfCrta');
  RemClassRegistry.RegisterXSInfo(TypeInfo(prodName2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'prodName2', 'prodName');
  RemClassRegistry.RegisterXSClass(ProdCrta, 'http://postilion/realtime/merchantframework/xsd/v1/', 'ProdCrta');
  RemClassRegistry.RegisterXSInfo(TypeInfo(setupFee), 'http://postilion/realtime/merchantframework/xsd/v1/', 'setupFee');
  RemClassRegistry.RegisterXSClass(Prod, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Prod');
  RemClassRegistry.RegisterXSInfo(TypeInfo(quantity2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'quantity2', 'quantity');
  RemClassRegistry.RegisterXSClass(ProdInfo, 'http://postilion/realtime/merchantframework/xsd/v1/', 'ProdInfo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(amt4), 'http://postilion/realtime/merchantframework/xsd/v1/', 'amt4', 'amt');
  RemClassRegistry.RegisterXSClass(Tax, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Tax');
  RemClassRegistry.RegisterXSInfo(TypeInfo(shipToZipCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'shipToZipCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(purcOrdNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'purcOrdNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(achAcctInfo2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'achAcctInfo2', 'achAcctInfo');
  RemClassRegistry.RegisterXSClass(Recur, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Recur');
  RemClassRegistry.RegisterXSInfo(TypeInfo(firstName2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'firstName2', 'firstName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(coName2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'coName2', 'coName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(fullName2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'fullName2', 'fullName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(lastName2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'lastName2', 'lastName');
  RemClassRegistry.RegisterXSClass(CustCrta, 'http://postilion/realtime/merchantframework/xsd/v1/', 'CustCrta');
  RemClassRegistry.RegisterXSInfo(TypeInfo(usrId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'usrId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pwd), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pwd');
  RemClassRegistry.RegisterXSInfo(TypeInfo(id10), 'http://postilion/realtime/merchantframework/xsd/v1/', 'id10', 'id');
  RemClassRegistry.RegisterXSInfo(TypeInfo(regKey), 'http://postilion/realtime/merchantframework/xsd/v1/', 'regKey');
  RemClassRegistry.RegisterXSClass(Merc, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Merc');
  RemClassRegistry.RegisterXSInfo(TypeInfo(title), 'http://postilion/realtime/merchantframework/xsd/v1/', 'title');
  RemClassRegistry.RegisterXSInfo(TypeInfo(fullName3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'fullName3', 'fullName');
  RemClassRegistry.RegisterXSInfo(TypeInfo(stat4), 'http://postilion/realtime/merchantframework/xsd/v1/', 'stat4', 'stat');
  RemClassRegistry.RegisterXSInfo(TypeInfo(note2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'note2', 'note');
  RemClassRegistry.RegisterXSInfo(TypeInfo(addrLn1), 'http://postilion/realtime/merchantframework/xsd/v1/', 'addrLn1');
  RemClassRegistry.RegisterXSInfo(TypeInfo(state2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'state2', 'state');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(state2), 'AS_', 'AS');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(state2), 'IN_', 'IN');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(state2), 'OR_', 'OR');
  RemClassRegistry.RegisterXSInfo(TypeInfo(zipCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'zipCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(addrLn2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'addrLn2');
  RemClassRegistry.RegisterXSInfo(TypeInfo(city), 'http://postilion/realtime/merchantframework/xsd/v1/', 'city');
  RemClassRegistry.RegisterXSClass(Ship, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Ship');
  RemClassRegistry.RegisterXSInfo(TypeInfo(addrLn22), 'http://postilion/realtime/merchantframework/xsd/v1/', 'addrLn22', 'addrLn2');
  RemClassRegistry.RegisterXSInfo(TypeInfo(city2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'city2', 'city');
  RemClassRegistry.RegisterXSClass(Phone2, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Phone2', 'Phone');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Phone2), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(addrLn12), 'http://postilion/realtime/merchantframework/xsd/v1/', 'addrLn12', 'addrLn1');
  RemClassRegistry.RegisterXSInfo(TypeInfo(state3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'state3', 'state');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(state3), 'AS_', 'AS');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(state3), 'IN_', 'IN');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(state3), 'OR_', 'OR');
  RemClassRegistry.RegisterXSInfo(TypeInfo(email2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'email2', 'email');
  RemClassRegistry.RegisterXSInfo(TypeInfo(type_9), 'http://postilion/realtime/merchantframework/xsd/v1/', 'type_9', 'type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(zipCode2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'zipCode2', 'zipCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ctry), 'http://postilion/realtime/merchantframework/xsd/v1/', 'ctry');
  RemClassRegistry.RegisterXSClass(Contact, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Contact');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Contact), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(sqncNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'sqncNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(qty), 'http://postilion/realtime/merchantframework/xsd/v1/', 'qty');
  RemClassRegistry.RegisterXSInfo(TypeInfo(qtyExp), 'http://postilion/realtime/merchantframework/xsd/v1/', 'qtyExp');
  RemClassRegistry.RegisterXSInfo(TypeInfo(vatRefNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'vatRefNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(desc4), 'http://postilion/realtime/merchantframework/xsd/v1/', 'desc4', 'desc');
  RemClassRegistry.RegisterXSInfo(TypeInfo(unitOfMsr2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'unitOfMsr2', 'unitOfMsr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dcntRt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'dcntRt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dcntAmt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'dcntAmt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(unitPrc), 'http://postilion/realtime/merchantframework/xsd/v1/', 'unitPrc');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dcnt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'dcnt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(cmnt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'cmnt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(privData), 'http://postilion/realtime/merchantframework/xsd/v1/', 'privData');
  RemClassRegistry.RegisterXSInfo(TypeInfo(custCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'custCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(cmdyCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'cmdyCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(itemNr2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'itemNr2', 'itemNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(prodCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'prodCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(totAmt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'totAmt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(type_10), 'http://postilion/realtime/merchantframework/xsd/v1/', 'type_10', 'type');
  RemClassRegistry.RegisterXSClass(BillShip, 'http://postilion/realtime/merchantframework/xsd/v1/', 'BillShip');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BillShip), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(rateExp), 'http://postilion/realtime/merchantframework/xsd/v1/', 'rateExp');
  RemClassRegistry.RegisterXSInfo(TypeInfo(cardAcptrId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'cardAcptrId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(swchKey), 'http://postilion/realtime/merchantframework/xsd/v1/', 'swchKey');
  RemClassRegistry.RegisterXSInfo(TypeInfo(stan), 'http://postilion/realtime/merchantframework/xsd/v1/', 'stan');
  RemClassRegistry.RegisterXSInfo(TypeInfo(auth), 'http://postilion/realtime/merchantframework/xsd/v1/', 'auth');
  RemClassRegistry.RegisterXSInfo(TypeInfo(tranNr3), 'http://postilion/realtime/merchantframework/xsd/v1/', 'tranNr3', 'tranNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(amt5), 'http://postilion/realtime/merchantframework/xsd/v1/', 'amt5', 'amt');
  RemClassRegistry.RegisterXSClass(TranData, 'http://postilion/realtime/merchantframework/xsd/v1/', 'TranData');
  RemClassRegistry.RegisterXSInfo(TypeInfo(sign), 'http://postilion/realtime/merchantframework/xsd/v1/', 'sign');
  RemClassRegistry.RegisterXSInfo(TypeInfo(privData2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'privData2', 'privData');
  RemClassRegistry.RegisterXSInfo(TypeInfo(totAmtType), 'http://postilion/realtime/merchantframework/xsd/v1/', 'totAmtType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(supType), 'http://postilion/realtime/merchantframework/xsd/v1/', 'supType');
  RemClassRegistry.RegisterXSClass(LineItem, 'http://postilion/realtime/merchantframework/xsd/v1/', 'LineItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(type_11), 'http://postilion/realtime/merchantframework/xsd/v1/', 'type_11', 'type');
  RemClassRegistry.RegisterXSInfo(TypeInfo(amt6), 'http://postilion/realtime/merchantframework/xsd/v1/', 'amt6', 'amt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(rate), 'http://postilion/realtime/merchantframework/xsd/v1/', 'rate');
  RemClassRegistry.RegisterXSInfo(TypeInfo(desc5), 'http://postilion/realtime/merchantframework/xsd/v1/', 'desc5', 'desc');
  RemClassRegistry.RegisterXSInfo(TypeInfo(incld), 'http://postilion/realtime/merchantframework/xsd/v1/', 'incld');
  RemClassRegistry.RegisterXSClass(PurcCardTax, 'http://postilion/realtime/merchantframework/xsd/v1/', 'PurcCardTax');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PurcCardTax), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(totAmt2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'totAmt2', 'totAmt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(cavv), 'http://postilion/realtime/merchantframework/xsd/v1/', 'cavv');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ucafIdcr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'ucafIdcr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(xid), 'http://postilion/realtime/merchantframework/xsd/v1/', 'xid');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ucaf), 'http://postilion/realtime/merchantframework/xsd/v1/', 'ucaf');
  RemClassRegistry.RegisterXSInfo(TypeInfo(voiceAuthCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'voiceAuthCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ordNr5), 'http://postilion/realtime/merchantframework/xsd/v1/', 'ordNr5', 'ordNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(eSign), 'http://postilion/realtime/merchantframework/xsd/v1/', 'eSign');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dbtOrCdt2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'dbtOrCdt2', 'dbtOrCdt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(trk1), 'http://postilion/realtime/merchantframework/xsd/v1/', 'trk1');
  RemClassRegistry.RegisterXSInfo(TypeInfo(trk2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'trk2');
  RemClassRegistry.RegisterXSClass(Card, 'http://postilion/realtime/merchantframework/xsd/v1/', 'Card');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Card), 'type_', '[ExtName="type"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dupChkTmPrd), 'http://postilion/realtime/merchantframework/xsd/v1/', 'dupChkTmPrd');
  RemClassRegistry.RegisterXSInfo(TypeInfo(mgdSettle2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'mgdSettle2', 'mgdSettle');
  RemClassRegistry.RegisterXSInfo(TypeInfo(convFeeAcptd), 'http://postilion/realtime/merchantframework/xsd/v1/', 'convFeeAcptd');
  RemClassRegistry.RegisterXSInfo(TypeInfo(revAuthOnVoid), 'http://postilion/realtime/merchantframework/xsd/v1/', 'revAuthOnVoid');
  RemClassRegistry.RegisterXSInfo(TypeInfo(rsbmt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'rsbmt');
  RemClassRegistry.RegisterXSClass(TranFlags, 'http://postilion/realtime/merchantframework/xsd/v1/', 'TranFlags');
  RemClassRegistry.RegisterXSInfo(TypeInfo(vchrNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'vchrNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(taxExmp), 'http://postilion/realtime/merchantframework/xsd/v1/', 'taxExmp');
  RemClassRegistry.RegisterXSInfo(TypeInfo(cmdyCode2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'cmdyCode2', 'cmdyCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(custBlngCode), 'http://postilion/realtime/merchantframework/xsd/v1/', 'custBlngCode');
  RemClassRegistry.RegisterXSInfo(TypeInfo(custOrdNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'custOrdNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(desc6), 'http://postilion/realtime/merchantframework/xsd/v1/', 'desc6', 'desc');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dutyAmt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'dutyAmt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(taxColld), 'http://postilion/realtime/merchantframework/xsd/v1/', 'taxColld');
  RemClassRegistry.RegisterXSInfo(TypeInfo(dcntAmt2), 'http://postilion/realtime/merchantframework/xsd/v1/', 'dcntAmt2', 'dcntAmt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(shpAmt), 'http://postilion/realtime/merchantframework/xsd/v1/', 'shpAmt');
  RemClassRegistry.RegisterXSInfo(TypeInfo(cardAcptrTaxId), 'http://postilion/realtime/merchantframework/xsd/v1/', 'cardAcptrTaxId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(cardAcptrVatNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'cardAcptrVatNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(pin), 'http://postilion/realtime/merchantframework/xsd/v1/', 'pin');
  RemClassRegistry.RegisterXSClass(AuthReq, 'http://postilion/realtime/merchantframework/xsd/v1/', 'AuthReq');
  RemClassRegistry.RegisterXSInfo(TypeInfo(custId4), 'http://postilion/realtime/merchantframework/xsd/v1/', 'custId4', 'custId');
  RemClassRegistry.RegisterXSInfo(TypeInfo(cardAcptrRefNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'cardAcptrRefNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(mercOrdNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'mercOrdNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(invcNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'invcNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(corpVatNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'corpVatNr');
  RemClassRegistry.RegisterXSInfo(TypeInfo(custVatNr), 'http://postilion/realtime/merchantframework/xsd/v1/', 'custVatNr');
  RemClassRegistry.RegisterXSClass(PurcCard, 'http://postilion/realtime/merchantframework/xsd/v1/', 'PurcCard');

end.