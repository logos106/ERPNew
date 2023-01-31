// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Dev\ERP\Dev\Aus_Gov\SBR\DotNet\C_Sharp\SBR_CoreServicesRequester_C#_1.2.0_2015-06-09\SBR_CoreServicesRequester\WSDL\Core\lodge.02.01.service.wsdl
//  >Import : C:\Dev\ERP\Dev\Aus_Gov\SBR\DotNet\C_Sharp\SBR_CoreServicesRequester_C#_1.2.0_2015-06-09\SBR_CoreServicesRequester\WSDL\Core\lodge.02.01.service.wsdl>0
//  >Import : C:\Dev\ERP\Dev\Aus_Gov\SBR\DotNet\C_Sharp\SBR_CoreServicesRequester_C#_1.2.0_2015-06-09\SBR_CoreServicesRequester\WSDL\Core\core.02.01.data.xsd
//  >Import : C:\Dev\ERP\Dev\Aus_Gov\SBR\DotNet\C_Sharp\SBR_CoreServicesRequester_C#_1.2.0_2015-06-09\SBR_CoreServicesRequester\WSDL\Core\sbdm.02.01.data.xsd
//  >Import : C:\Dev\ERP\Dev\Aus_Gov\SBR\DotNet\C_Sharp\SBR_CoreServicesRequester_C#_1.2.0_2015-06-09\SBR_CoreServicesRequester\WSDL\Core\xmlmime.xsd
// Encoding : UTF-8
// Version  : 1.0
// (19/06/2018 9:28:51 AM - - $Rev: 34800 $)
// ************************************************************************ //

unit lodge;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_ATTR = $0010;
  IS_TEXT = $0020;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:anyURI          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:integer         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:contentType     - "http://www.w3.org/2005/05/xmlmime"[GblAttr]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  Message_NonRepudiationToken_TextType = class;   { "http://sbr.gov.au/comn/core.02.data"[GblCplx] }
  NonRepudiationType   = class;                 { "http://sbr.gov.au/comn/core.02.data"[Hdr][GblCplx] }
  ResponseLodgeReport  = class;                 { "http://sbr.gov.au/comn/lodge.02.service"[Lit][GblElm] }
  RequestLodgeReport   = class;                 { "http://sbr.gov.au/comn/lodge.02.service"[Lit][GblElm] }
  NonRepudiation       = class;                 { "http://sbr.gov.au/comn/core.02.data"[Hdr][GblElm] }
  MessageEventType     = class;                 { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  StandardBusinessDocumentMessageType = class;   { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  StandardBusinessDocumentMessage = class;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblElm] }
  LodgementReceiptType = class;                 { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  SoftwareInformationType = class;              { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  MessageEventItemType = class;                 { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  MessageEventItemParameterType = class;        { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  PartyType            = class;                 { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  StandardBusinessDocumentBodyType = class;     { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  StandardBusinessDocumentHeaderType = class;   { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  BusinessDocument_Instance_TextType = class;   { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  AttachmentInstanceType = class;               { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  Message_Attachment_Instance_BinaryObjectType = class;   { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  AttachmentType       = class;                 { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  BusinessDocumentInstanceType = class;         { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  MessageEventItemLocationType = class;         { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  MessageTimestampType = class;                 { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  BusinessDocumentType = class;                 { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }

  {$SCOPEDENUMS ON}
  { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  Message_Event_Item_Severity_CodeType = (Error, Warning, Information);

  { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  IdentificationDetails_IdentifierName_TextType = (AgencyInternetDomainName);

  { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  Message_Timestamp_GenerationSource_CodeType = (BusinessEntity, SBRCore, GovernmentAgency, VANguard);

  {$SCOPEDENUMS OFF}

  MessageEventItemLocationsType = array of MessageEventItemLocationType;   { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  MessageEventItemParametersType = array of MessageEventItemParameterType;   { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  MessageEventItemsType = array of MessageEventItemType;   { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }


  // ************************************************************************ //
  // XML       : Message.NonRepudiationToken.TextType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/core.02.data
  // ************************************************************************ //
  Message_NonRepudiationToken_TextType = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : NonRepudiationType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/core.02.data
  // Info      : Header
  // ************************************************************************ //
  NonRepudiationType = class(TSOAPHeader)
  private
    FMessage_NonRepudiationToken_Text: Message_NonRepudiationToken_TextType;
  public
    destructor Destroy; override;
  published
    property Message_NonRepudiationToken_Text: Message_NonRepudiationToken_TextType  read FMessage_NonRepudiationToken_Text write FMessage_NonRepudiationToken_Text;
  end;



  // ************************************************************************ //
  // XML       : ResponseLodgeReport, global, <element>
  // Namespace : http://sbr.gov.au/comn/lodge.02.service
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  ResponseLodgeReport = class(TRemotable)
  private
    FStandardBusinessDocumentMessage: StandardBusinessDocumentMessage;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property StandardBusinessDocumentMessage: StandardBusinessDocumentMessage  Index (IS_REF) read FStandardBusinessDocumentMessage write FStandardBusinessDocumentMessage;
  end;



  // ************************************************************************ //
  // XML       : RequestLodgeReport, global, <element>
  // Namespace : http://sbr.gov.au/comn/lodge.02.service
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  RequestLodgeReport = class(TRemotable)
  private
    FStandardBusinessDocumentMessage: StandardBusinessDocumentMessage;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property StandardBusinessDocumentMessage: StandardBusinessDocumentMessage  Index (IS_REF) read FStandardBusinessDocumentMessage write FStandardBusinessDocumentMessage;
  end;



  // ************************************************************************ //
  // XML       : NonRepudiation, global, <element>
  // Namespace : http://sbr.gov.au/comn/core.02.data
  // Info      : Header
  // ************************************************************************ //
  NonRepudiation = class(NonRepudiationType)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : MessageEventType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  MessageEventType = class(TRemotable)
  private
    FMessage_Event_MaximumSeverity_Code: Message_Event_Item_Severity_CodeType;
    FMessageEventItems: MessageEventItemsType;
  public
    destructor Destroy; override;
  published
    property Message_Event_MaximumSeverity_Code: Message_Event_Item_Severity_CodeType  read FMessage_Event_MaximumSeverity_Code write FMessage_Event_MaximumSeverity_Code;
    property MessageEventItems:                  MessageEventItemsType                 read FMessageEventItems write FMessageEventItems;
  end;

  BusinessDocumentsType = array of BusinessDocumentType;   { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  AttachmentInstancesType = array of AttachmentInstanceType;   { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  Lodgement_Receipt_DatetimeType = class(TXSDateTime) end;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  BusinessDocumentInstancesType = array of BusinessDocumentInstanceType;   { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }


  // ************************************************************************ //
  // XML       : StandardBusinessDocumentMessageType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  StandardBusinessDocumentMessageType = class(TRemotable)
  private
    FStandardBusinessDocumentHeader: StandardBusinessDocumentHeaderType;
    FStandardBusinessDocumentBody: StandardBusinessDocumentBodyType;
    FStandardBusinessDocumentBody_Specified: boolean;
    procedure SetStandardBusinessDocumentBody(Index: Integer; const AStandardBusinessDocumentBodyType: StandardBusinessDocumentBodyType);
    function  StandardBusinessDocumentBody_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property StandardBusinessDocumentHeader: StandardBusinessDocumentHeaderType  read FStandardBusinessDocumentHeader write FStandardBusinessDocumentHeader;
    property StandardBusinessDocumentBody:   StandardBusinessDocumentBodyType    Index (IS_OPTN) read FStandardBusinessDocumentBody write SetStandardBusinessDocumentBody stored StandardBusinessDocumentBody_Specified;
  end;



  // ************************************************************************ //
  // XML       : StandardBusinessDocumentMessage, global, <element>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  StandardBusinessDocumentMessage = class(StandardBusinessDocumentMessageType)
  private
  published
  end;

  Lodgement_Receipt_IdentifierType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }


  // ************************************************************************ //
  // XML       : LodgementReceiptType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  LodgementReceiptType = class(TRemotable)
  private
    FLodgement_Receipt_Identifier: Lodgement_Receipt_IdentifierType;
    FLodgement_Receipt_Identifier_Specified: boolean;
    FLodgement_Receipt_Datetime: Lodgement_Receipt_DatetimeType;
    FLodgement_Receipt_Datetime_Specified: boolean;
    procedure SetLodgement_Receipt_Identifier(Index: Integer; const ALodgement_Receipt_IdentifierType: Lodgement_Receipt_IdentifierType);
    function  Lodgement_Receipt_Identifier_Specified(Index: Integer): boolean;
    procedure SetLodgement_Receipt_Datetime(Index: Integer; const ALodgement_Receipt_DatetimeType: Lodgement_Receipt_DatetimeType);
    function  Lodgement_Receipt_Datetime_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Lodgement_Receipt_Identifier: Lodgement_Receipt_IdentifierType  Index (IS_OPTN) read FLodgement_Receipt_Identifier write SetLodgement_Receipt_Identifier stored Lodgement_Receipt_Identifier_Specified;
    property Lodgement_Receipt_Datetime:   Lodgement_Receipt_DatetimeType    Index (IS_OPTN) read FLodgement_Receipt_Datetime write SetLodgement_Receipt_Datetime stored Lodgement_Receipt_Datetime_Specified;
  end;

  SoftwareInformation_ProductVersion_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  OrganisationNameDetails_OrganisationalName_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  SoftwareInformation_ProductName_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }


  // ************************************************************************ //
  // XML       : SoftwareInformationType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  SoftwareInformationType = class(TRemotable)
  private
    FOrganisationNameDetails_OrganisationalName_Text: OrganisationNameDetails_OrganisationalName_TextType;
    FSoftwareInformation_ProductName_Text: SoftwareInformation_ProductName_TextType;
    FSoftwareInformation_ProductVersion_Text: SoftwareInformation_ProductVersion_TextType;
  published
    property OrganisationNameDetails_OrganisationalName_Text: OrganisationNameDetails_OrganisationalName_TextType  read FOrganisationNameDetails_OrganisationalName_Text write FOrganisationNameDetails_OrganisationalName_Text;
    property SoftwareInformation_ProductName_Text:            SoftwareInformation_ProductName_TextType             read FSoftwareInformation_ProductName_Text write FSoftwareInformation_ProductName_Text;
    property SoftwareInformation_ProductVersion_Text:         SoftwareInformation_ProductVersion_TextType          read FSoftwareInformation_ProductVersion_Text write FSoftwareInformation_ProductVersion_Text;
  end;

  IdentificationDetails_IdentifierDesignation_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  Message_Event_Item_Error_CodeType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  Message_Event_Item_Short_DescriptionType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  Message_Event_Item_Detailed_DescriptionType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }


  // ************************************************************************ //
  // XML       : MessageEventItemType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  MessageEventItemType = class(TRemotable)
  private
    FMessage_Event_Item_Error_Code: Message_Event_Item_Error_CodeType;
    FMessage_Event_Item_Severity_Code: Message_Event_Item_Severity_CodeType;
    FMessage_Event_Item_Short_Description: Message_Event_Item_Short_DescriptionType;
    FMessage_Event_Item_Short_Description_Specified: boolean;
    FMessage_Event_Item_Detailed_Description: Message_Event_Item_Detailed_DescriptionType;
    FMessage_Event_Item_Detailed_Description_Specified: boolean;
    FParameters: MessageEventItemParametersType;
    FParameters_Specified: boolean;
    FLocations: MessageEventItemLocationsType;
    FLocations_Specified: boolean;
    procedure SetMessage_Event_Item_Short_Description(Index: Integer; const AMessage_Event_Item_Short_DescriptionType: Message_Event_Item_Short_DescriptionType);
    function  Message_Event_Item_Short_Description_Specified(Index: Integer): boolean;
    procedure SetMessage_Event_Item_Detailed_Description(Index: Integer; const AMessage_Event_Item_Detailed_DescriptionType: Message_Event_Item_Detailed_DescriptionType);
    function  Message_Event_Item_Detailed_Description_Specified(Index: Integer): boolean;
    procedure SetParameters(Index: Integer; const AMessageEventItemParametersType: MessageEventItemParametersType);
    function  Parameters_Specified(Index: Integer): boolean;
    procedure SetLocations(Index: Integer; const AMessageEventItemLocationsType: MessageEventItemLocationsType);
    function  Locations_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Message_Event_Item_Error_Code:           Message_Event_Item_Error_CodeType            read FMessage_Event_Item_Error_Code write FMessage_Event_Item_Error_Code;
    property Message_Event_Item_Severity_Code:        Message_Event_Item_Severity_CodeType         read FMessage_Event_Item_Severity_Code write FMessage_Event_Item_Severity_Code;
    property Message_Event_Item_Short_Description:    Message_Event_Item_Short_DescriptionType     Index (IS_OPTN) read FMessage_Event_Item_Short_Description write SetMessage_Event_Item_Short_Description stored Message_Event_Item_Short_Description_Specified;
    property Message_Event_Item_Detailed_Description: Message_Event_Item_Detailed_DescriptionType  Index (IS_OPTN) read FMessage_Event_Item_Detailed_Description write SetMessage_Event_Item_Detailed_Description stored Message_Event_Item_Detailed_Description_Specified;
    property Parameters:                              MessageEventItemParametersType               Index (IS_OPTN) read FParameters write SetParameters stored Parameters_Specified;
    property Locations:                               MessageEventItemLocationsType                Index (IS_OPTN) read FLocations write SetLocations stored Locations_Specified;
  end;

  Message_Event_Item_Parameter_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  Message_Event_Item_Parameter_IdentifierType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  Message_Event_Item_Location_Path_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }


  // ************************************************************************ //
  // XML       : MessageEventItemParameterType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  MessageEventItemParameterType = class(TRemotable)
  private
    FMessage_Event_Item_Parameter_Identifier: Message_Event_Item_Parameter_IdentifierType;
    FMessage_Event_Item_Parameter_Text: Message_Event_Item_Parameter_TextType;
  published
    property Message_Event_Item_Parameter_Identifier: Message_Event_Item_Parameter_IdentifierType  read FMessage_Event_Item_Parameter_Identifier write FMessage_Event_Item_Parameter_Identifier;
    property Message_Event_Item_Parameter_Text:       Message_Event_Item_Parameter_TextType        read FMessage_Event_Item_Parameter_Text write FMessage_Event_Item_Parameter_Text;
  end;

  MessageTimestampsType = array of MessageTimestampType;   { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }


  // ************************************************************************ //
  // XML       : PartyType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  PartyType = class(TRemotable)
  private
    FIdentificationDetails_IdentifierDesignation_Text: IdentificationDetails_IdentifierDesignation_TextType;
    FIdentificationDetails_IdentifierName_Text: IdentificationDetails_IdentifierName_TextType;
  published
    property IdentificationDetails_IdentifierDesignation_Text: IdentificationDetails_IdentifierDesignation_TextType  read FIdentificationDetails_IdentifierDesignation_Text write FIdentificationDetails_IdentifierDesignation_Text;
    property IdentificationDetails_IdentifierName_Text:        IdentificationDetails_IdentifierName_TextType         read FIdentificationDetails_IdentifierName_Text write FIdentificationDetails_IdentifierName_Text;
  end;



  // ************************************************************************ //
  // XML       : StandardBusinessDocumentBodyType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  StandardBusinessDocumentBodyType = class(TRemotable)
  private
    FBusinessDocumentInstances: BusinessDocumentInstancesType;
    FAttachmentInstances: AttachmentInstancesType;
    FAttachmentInstances_Specified: boolean;
    procedure SetAttachmentInstances(Index: Integer; const AAttachmentInstancesType: AttachmentInstancesType);
    function  AttachmentInstances_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property BusinessDocumentInstances: BusinessDocumentInstancesType  read FBusinessDocumentInstances write FBusinessDocumentInstances;
    property AttachmentInstances:       AttachmentInstancesType        Index (IS_OPTN) read FAttachmentInstances write SetAttachmentInstances stored AttachmentInstances_Specified;
  end;

  Message_Type_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }


  // ************************************************************************ //
  // XML       : StandardBusinessDocumentHeaderType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  StandardBusinessDocumentHeaderType = class(TRemotable)
  private
    FMessage_Type_Text: Message_Type_TextType;
    FMessageTimestamps: MessageTimestampsType;
    FSender: PartyType;
    FSender_Specified: boolean;
    FReceiver: PartyType;
    FReceiver_Specified: boolean;
    FLodgementReceipt: LodgementReceiptType;
    FLodgementReceipt_Specified: boolean;
    FSoftwareInformation: SoftwareInformationType;
    FSoftwareInformation_Specified: boolean;
    FBusinessDocuments: BusinessDocumentsType;
    FBusinessDocuments_Specified: boolean;
    FMessageEvent: MessageEventType;
    FMessageEvent_Specified: boolean;
    procedure SetSender(Index: Integer; const APartyType: PartyType);
    function  Sender_Specified(Index: Integer): boolean;
    procedure SetReceiver(Index: Integer; const APartyType: PartyType);
    function  Receiver_Specified(Index: Integer): boolean;
    procedure SetLodgementReceipt(Index: Integer; const ALodgementReceiptType: LodgementReceiptType);
    function  LodgementReceipt_Specified(Index: Integer): boolean;
    procedure SetSoftwareInformation(Index: Integer; const ASoftwareInformationType: SoftwareInformationType);
    function  SoftwareInformation_Specified(Index: Integer): boolean;
    procedure SetBusinessDocuments(Index: Integer; const ABusinessDocumentsType: BusinessDocumentsType);
    function  BusinessDocuments_Specified(Index: Integer): boolean;
    procedure SetMessageEvent(Index: Integer; const AMessageEventType: MessageEventType);
    function  MessageEvent_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property Message_Type_Text:   Message_Type_TextType    read FMessage_Type_Text write FMessage_Type_Text;
    property MessageTimestamps:   MessageTimestampsType    read FMessageTimestamps write FMessageTimestamps;
    property Sender:              PartyType                Index (IS_OPTN) read FSender write SetSender stored Sender_Specified;
    property Receiver:            PartyType                Index (IS_OPTN) read FReceiver write SetReceiver stored Receiver_Specified;
    property LodgementReceipt:    LodgementReceiptType     Index (IS_OPTN) read FLodgementReceipt write SetLodgementReceipt stored LodgementReceipt_Specified;
    property SoftwareInformation: SoftwareInformationType  Index (IS_OPTN) read FSoftwareInformation write SetSoftwareInformation stored SoftwareInformation_Specified;
    property BusinessDocuments:   BusinessDocumentsType    Index (IS_OPTN) read FBusinessDocuments write SetBusinessDocuments stored BusinessDocuments_Specified;
    property MessageEvent:        MessageEventType         Index (IS_OPTN) read FMessageEvent write SetMessageEvent stored MessageEvent_Specified;
  end;

  Message_Attachment_Sequence_NumberType =  type Int64;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }


  // ************************************************************************ //
  // XML       : BusinessDocument.Instance.TextType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  BusinessDocument_Instance_TextType = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : AttachmentInstanceType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  AttachmentInstanceType = class(TRemotable)
  private
    FMessage_Attachment_Sequence_Number: Message_Attachment_Sequence_NumberType;
    FMessage_Attachment_Instance_BinaryObject: Message_Attachment_Instance_BinaryObjectType;
  public
    destructor Destroy; override;
  published
    property Message_Attachment_Sequence_Number:       Message_Attachment_Sequence_NumberType        read FMessage_Attachment_Sequence_Number write FMessage_Attachment_Sequence_Number;
    property Message_Attachment_Instance_BinaryObject: Message_Attachment_Instance_BinaryObjectType  read FMessage_Attachment_Instance_BinaryObject write FMessage_Attachment_Instance_BinaryObject;
  end;



  // ************************************************************************ //
  // XML       : Message.Attachment.Instance.BinaryObjectType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // TODO: Simple Content Failure: dmSimpleRestriction
  // ************************************************************************ //
  Message_Attachment_Instance_BinaryObjectType = class(TRemotable)
  private
    FcontentType: contentType;
  published
    property contentType: contentType  Index (IS_ATTR) read FcontentType write FcontentType;
  end;

  Message_Attachment_FileName_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  Message_Attachment_Description_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }


  // ************************************************************************ //
  // XML       : AttachmentType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  AttachmentType = class(TRemotable)
  private
    FMessage_Attachment_Sequence_Number: Message_Attachment_Sequence_NumberType;
    FMessage_Attachment_FileName_Text: Message_Attachment_FileName_TextType;
    FMessage_Attachment_FileName_Text_Specified: boolean;
    FMessage_Attachment_Description_Text: Message_Attachment_Description_TextType;
    FMessage_Attachment_Description_Text_Specified: boolean;
    procedure SetMessage_Attachment_FileName_Text(Index: Integer; const AMessage_Attachment_FileName_TextType: Message_Attachment_FileName_TextType);
    function  Message_Attachment_FileName_Text_Specified(Index: Integer): boolean;
    procedure SetMessage_Attachment_Description_Text(Index: Integer; const AMessage_Attachment_Description_TextType: Message_Attachment_Description_TextType);
    function  Message_Attachment_Description_Text_Specified(Index: Integer): boolean;
  published
    property Message_Attachment_Sequence_Number:  Message_Attachment_Sequence_NumberType   read FMessage_Attachment_Sequence_Number write FMessage_Attachment_Sequence_Number;
    property Message_Attachment_FileName_Text:    Message_Attachment_FileName_TextType     Index (IS_OPTN) read FMessage_Attachment_FileName_Text write SetMessage_Attachment_FileName_Text stored Message_Attachment_FileName_Text_Specified;
    property Message_Attachment_Description_Text: Message_Attachment_Description_TextType  Index (IS_OPTN) read FMessage_Attachment_Description_Text write SetMessage_Attachment_Description_Text stored Message_Attachment_Description_Text_Specified;
  end;

  AttachmentsType = array of AttachmentType;    { "http://sbr.gov.au/comn/sbdm.02.data"[GblCplx] }
  BusinessDocument_Sequence_NumberType =  type Int64;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }


  // ************************************************************************ //
  // XML       : BusinessDocumentInstanceType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  BusinessDocumentInstanceType = class(TRemotable)
  private
    FBusinessDocument_Sequence_Number: BusinessDocument_Sequence_NumberType;
    FBusinessDocument_Instance_Text: BusinessDocument_Instance_TextType;
  public
    destructor Destroy; override;
  published
    property BusinessDocument_Sequence_Number: BusinessDocument_Sequence_NumberType  read FBusinessDocument_Sequence_Number write FBusinessDocument_Sequence_Number;
    property BusinessDocument_Instance_Text:   BusinessDocument_Instance_TextType    read FBusinessDocument_Instance_Text write FBusinessDocument_Instance_Text;
  end;



  // ************************************************************************ //
  // XML       : MessageEventItemLocationType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  MessageEventItemLocationType = class(TRemotable)
  private
    FBusinessDocument_Sequence_Number: BusinessDocument_Sequence_NumberType;
    FMessage_Event_Item_Location_Path_Text: Message_Event_Item_Location_Path_TextType;
    FMessage_Event_Item_Location_Path_Text_Specified: boolean;
    procedure SetMessage_Event_Item_Location_Path_Text(Index: Integer; const AMessage_Event_Item_Location_Path_TextType: Message_Event_Item_Location_Path_TextType);
    function  Message_Event_Item_Location_Path_Text_Specified(Index: Integer): boolean;
  published
    property BusinessDocument_Sequence_Number:      BusinessDocument_Sequence_NumberType       read FBusinessDocument_Sequence_Number write FBusinessDocument_Sequence_Number;
    property Message_Event_Item_Location_Path_Text: Message_Event_Item_Location_Path_TextType  Index (IS_OPTN) read FMessage_Event_Item_Location_Path_Text write SetMessage_Event_Item_Location_Path_Text stored Message_Event_Item_Location_Path_Text_Specified;
  end;

  Message_Timestamp_Generation_DatetimeType = class(TXSDateTime) end;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }


  // ************************************************************************ //
  // XML       : MessageTimestampType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  MessageTimestampType = class(TRemotable)
  private
    FMessage_Timestamp_Generation_Datetime: Message_Timestamp_Generation_DatetimeType;
    FMessage_Timestamp_GenerationSource_Code: Message_Timestamp_GenerationSource_CodeType;
  public
    destructor Destroy; override;
  published
    property Message_Timestamp_Generation_Datetime:   Message_Timestamp_Generation_DatetimeType    read FMessage_Timestamp_Generation_Datetime write FMessage_Timestamp_Generation_Datetime;
    property Message_Timestamp_GenerationSource_Code: Message_Timestamp_GenerationSource_CodeType  read FMessage_Timestamp_GenerationSource_Code write FMessage_Timestamp_GenerationSource_Code;
  end;

  BusinessDocument_BusinessGeneratedIdentifier_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  BusinessDocument_GovernmentGeneratedIdentifier_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  BusinessDocument_Creation_DatetimeType = class(TXSDateTime) end;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }
  BusinessDocument_ValidationUniformResourceIdentifier_TextType =  type string;      { "http://sbr.gov.au/comn/sbdm.02.data"[GblSmpl] }


  // ************************************************************************ //
  // XML       : BusinessDocumentType, global, <complexType>
  // Namespace : http://sbr.gov.au/comn/sbdm.02.data
  // ************************************************************************ //
  BusinessDocumentType = class(TRemotable)
  private
    FBusinessDocument_Sequence_Number: BusinessDocument_Sequence_NumberType;
    FBusinessDocument_Creation_Datetime: BusinessDocument_Creation_DatetimeType;
    FBusinessDocument_ValidationUniformResourceIdentifier_Text: BusinessDocument_ValidationUniformResourceIdentifier_TextType;
    FBusinessDocument_BusinessGeneratedIdentifier_Text: BusinessDocument_BusinessGeneratedIdentifier_TextType;
    FBusinessDocument_BusinessGeneratedIdentifier_Text_Specified: boolean;
    FBusinessDocument_GovernmentGeneratedIdentifier_Text: BusinessDocument_GovernmentGeneratedIdentifier_TextType;
    FBusinessDocument_GovernmentGeneratedIdentifier_Text_Specified: boolean;
    FAttachments: AttachmentsType;
    FAttachments_Specified: boolean;
    procedure SetBusinessDocument_BusinessGeneratedIdentifier_Text(Index: Integer; const ABusinessDocument_BusinessGeneratedIdentifier_TextType: BusinessDocument_BusinessGeneratedIdentifier_TextType);
    function  BusinessDocument_BusinessGeneratedIdentifier_Text_Specified(Index: Integer): boolean;
    procedure SetBusinessDocument_GovernmentGeneratedIdentifier_Text(Index: Integer; const ABusinessDocument_GovernmentGeneratedIdentifier_TextType: BusinessDocument_GovernmentGeneratedIdentifier_TextType);
    function  BusinessDocument_GovernmentGeneratedIdentifier_Text_Specified(Index: Integer): boolean;
    procedure SetAttachments(Index: Integer; const AAttachmentsType: AttachmentsType);
    function  Attachments_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property BusinessDocument_Sequence_Number:                          BusinessDocument_Sequence_NumberType                           read FBusinessDocument_Sequence_Number write FBusinessDocument_Sequence_Number;
    property BusinessDocument_Creation_Datetime:                        BusinessDocument_Creation_DatetimeType                         read FBusinessDocument_Creation_Datetime write FBusinessDocument_Creation_Datetime;
    property BusinessDocument_ValidationUniformResourceIdentifier_Text: BusinessDocument_ValidationUniformResourceIdentifier_TextType  read FBusinessDocument_ValidationUniformResourceIdentifier_Text write FBusinessDocument_ValidationUniformResourceIdentifier_Text;
    property BusinessDocument_BusinessGeneratedIdentifier_Text:         BusinessDocument_BusinessGeneratedIdentifier_TextType          Index (IS_OPTN) read FBusinessDocument_BusinessGeneratedIdentifier_Text write SetBusinessDocument_BusinessGeneratedIdentifier_Text stored BusinessDocument_BusinessGeneratedIdentifier_Text_Specified;
    property BusinessDocument_GovernmentGeneratedIdentifier_Text:       BusinessDocument_GovernmentGeneratedIdentifier_TextType        Index (IS_OPTN) read FBusinessDocument_GovernmentGeneratedIdentifier_Text write SetBusinessDocument_GovernmentGeneratedIdentifier_Text stored BusinessDocument_GovernmentGeneratedIdentifier_Text_Specified;
    property Attachments:                                               AttachmentsType                                                Index (IS_OPTN) read FAttachments write SetAttachments stored Attachments_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://sbr.gov.au/comn/lodge.02.service
  // soapAction: http://sbr.gov.au/services/lodge.02.service/LodgeReport
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : Lodge.02.SoapBinding
  // service   : Lodge.02.Service
  // port      : Lodge.02.Port
  // URL       : https://sbr.gov.au/services/lodge.02.service
  // ************************************************************************ //
  ILodge02 = interface(IInvokable)
  ['{FA50739D-B3E4-A45C-B11C-EEE7CDA6A591}']

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    // Headers: nonRepudiation:pOut
    function  LodgeReport(const parameters: RequestLodgeReport): ResponseLodgeReport; stdcall;
  end;

function GetILodge02(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ILodge02;


implementation
  uses SysUtils;

function GetILodge02(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ILodge02;
const
  defWSDL = 'C:\Dev\ERP\Dev\Aus_Gov\SBR\DotNet\C_Sharp\SBR_CoreServicesRequester_C#_1.2.0_2015-06-09\SBR_CoreServicesRequester\WSDL\Core\lodge.02.01.service.wsdl';
  defURL  = 'https://sbr.gov.au/services/lodge.02.service';
  defSvc  = 'Lodge.02.Service';
  defPrt  = 'Lodge.02.Port';
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
    Result := (RIO as ILodge02);
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


destructor NonRepudiationType.Destroy;
begin
  SysUtils.FreeAndNil(FMessage_NonRepudiationToken_Text);
  inherited Destroy;
end;

constructor ResponseLodgeReport.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor ResponseLodgeReport.Destroy;
begin
  SysUtils.FreeAndNil(FStandardBusinessDocumentMessage);
  inherited Destroy;
end;

constructor RequestLodgeReport.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor RequestLodgeReport.Destroy;
begin
  SysUtils.FreeAndNil(FStandardBusinessDocumentMessage);
  inherited Destroy;
end;

destructor MessageEventType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FMessageEventItems)-1 do
    SysUtils.FreeAndNil(FMessageEventItems[I]);
  System.SetLength(FMessageEventItems, 0);
  inherited Destroy;
end;

destructor StandardBusinessDocumentMessageType.Destroy;
begin
  SysUtils.FreeAndNil(FStandardBusinessDocumentHeader);
  SysUtils.FreeAndNil(FStandardBusinessDocumentBody);
  inherited Destroy;
end;

procedure StandardBusinessDocumentMessageType.SetStandardBusinessDocumentBody(Index: Integer; const AStandardBusinessDocumentBodyType: StandardBusinessDocumentBodyType);
begin
  FStandardBusinessDocumentBody := AStandardBusinessDocumentBodyType;
  FStandardBusinessDocumentBody_Specified := True;
end;

function StandardBusinessDocumentMessageType.StandardBusinessDocumentBody_Specified(Index: Integer): boolean;
begin
  Result := FStandardBusinessDocumentBody_Specified;
end;

destructor LodgementReceiptType.Destroy;
begin
  SysUtils.FreeAndNil(FLodgement_Receipt_Datetime);
  inherited Destroy;
end;

procedure LodgementReceiptType.SetLodgement_Receipt_Identifier(Index: Integer; const ALodgement_Receipt_IdentifierType: Lodgement_Receipt_IdentifierType);
begin
  FLodgement_Receipt_Identifier := ALodgement_Receipt_IdentifierType;
  FLodgement_Receipt_Identifier_Specified := True;
end;

function LodgementReceiptType.Lodgement_Receipt_Identifier_Specified(Index: Integer): boolean;
begin
  Result := FLodgement_Receipt_Identifier_Specified;
end;

procedure LodgementReceiptType.SetLodgement_Receipt_Datetime(Index: Integer; const ALodgement_Receipt_DatetimeType: Lodgement_Receipt_DatetimeType);
begin
  FLodgement_Receipt_Datetime := ALodgement_Receipt_DatetimeType;
  FLodgement_Receipt_Datetime_Specified := True;
end;

function LodgementReceiptType.Lodgement_Receipt_Datetime_Specified(Index: Integer): boolean;
begin
  Result := FLodgement_Receipt_Datetime_Specified;
end;

destructor MessageEventItemType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FParameters)-1 do
    SysUtils.FreeAndNil(FParameters[I]);
  System.SetLength(FParameters, 0);
  for I := 0 to System.Length(FLocations)-1 do
    SysUtils.FreeAndNil(FLocations[I]);
  System.SetLength(FLocations, 0);
  inherited Destroy;
end;

procedure MessageEventItemType.SetMessage_Event_Item_Short_Description(Index: Integer; const AMessage_Event_Item_Short_DescriptionType: Message_Event_Item_Short_DescriptionType);
begin
  FMessage_Event_Item_Short_Description := AMessage_Event_Item_Short_DescriptionType;
  FMessage_Event_Item_Short_Description_Specified := True;
end;

function MessageEventItemType.Message_Event_Item_Short_Description_Specified(Index: Integer): boolean;
begin
  Result := FMessage_Event_Item_Short_Description_Specified;
end;

procedure MessageEventItemType.SetMessage_Event_Item_Detailed_Description(Index: Integer; const AMessage_Event_Item_Detailed_DescriptionType: Message_Event_Item_Detailed_DescriptionType);
begin
  FMessage_Event_Item_Detailed_Description := AMessage_Event_Item_Detailed_DescriptionType;
  FMessage_Event_Item_Detailed_Description_Specified := True;
end;

function MessageEventItemType.Message_Event_Item_Detailed_Description_Specified(Index: Integer): boolean;
begin
  Result := FMessage_Event_Item_Detailed_Description_Specified;
end;

procedure MessageEventItemType.SetParameters(Index: Integer; const AMessageEventItemParametersType: MessageEventItemParametersType);
begin
  FParameters := AMessageEventItemParametersType;
  FParameters_Specified := True;
end;

function MessageEventItemType.Parameters_Specified(Index: Integer): boolean;
begin
  Result := FParameters_Specified;
end;

procedure MessageEventItemType.SetLocations(Index: Integer; const AMessageEventItemLocationsType: MessageEventItemLocationsType);
begin
  FLocations := AMessageEventItemLocationsType;
  FLocations_Specified := True;
end;

function MessageEventItemType.Locations_Specified(Index: Integer): boolean;
begin
  Result := FLocations_Specified;
end;

destructor StandardBusinessDocumentBodyType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FBusinessDocumentInstances)-1 do
    SysUtils.FreeAndNil(FBusinessDocumentInstances[I]);
  System.SetLength(FBusinessDocumentInstances, 0);
  for I := 0 to System.Length(FAttachmentInstances)-1 do
    SysUtils.FreeAndNil(FAttachmentInstances[I]);
  System.SetLength(FAttachmentInstances, 0);
  inherited Destroy;
end;

procedure StandardBusinessDocumentBodyType.SetAttachmentInstances(Index: Integer; const AAttachmentInstancesType: AttachmentInstancesType);
begin
  FAttachmentInstances := AAttachmentInstancesType;
  FAttachmentInstances_Specified := True;
end;

function StandardBusinessDocumentBodyType.AttachmentInstances_Specified(Index: Integer): boolean;
begin
  Result := FAttachmentInstances_Specified;
end;

destructor StandardBusinessDocumentHeaderType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FMessageTimestamps)-1 do
    SysUtils.FreeAndNil(FMessageTimestamps[I]);
  System.SetLength(FMessageTimestamps, 0);
  for I := 0 to System.Length(FBusinessDocuments)-1 do
    SysUtils.FreeAndNil(FBusinessDocuments[I]);
  System.SetLength(FBusinessDocuments, 0);
  SysUtils.FreeAndNil(FSender);
  SysUtils.FreeAndNil(FReceiver);
  SysUtils.FreeAndNil(FLodgementReceipt);
  SysUtils.FreeAndNil(FSoftwareInformation);
  SysUtils.FreeAndNil(FMessageEvent);
  inherited Destroy;
end;

procedure StandardBusinessDocumentHeaderType.SetSender(Index: Integer; const APartyType: PartyType);
begin
  FSender := APartyType;
  FSender_Specified := True;
end;

function StandardBusinessDocumentHeaderType.Sender_Specified(Index: Integer): boolean;
begin
  Result := FSender_Specified;
end;

procedure StandardBusinessDocumentHeaderType.SetReceiver(Index: Integer; const APartyType: PartyType);
begin
  FReceiver := APartyType;
  FReceiver_Specified := True;
end;

function StandardBusinessDocumentHeaderType.Receiver_Specified(Index: Integer): boolean;
begin
  Result := FReceiver_Specified;
end;

procedure StandardBusinessDocumentHeaderType.SetLodgementReceipt(Index: Integer; const ALodgementReceiptType: LodgementReceiptType);
begin
  FLodgementReceipt := ALodgementReceiptType;
  FLodgementReceipt_Specified := True;
end;

function StandardBusinessDocumentHeaderType.LodgementReceipt_Specified(Index: Integer): boolean;
begin
  Result := FLodgementReceipt_Specified;
end;

procedure StandardBusinessDocumentHeaderType.SetSoftwareInformation(Index: Integer; const ASoftwareInformationType: SoftwareInformationType);
begin
  FSoftwareInformation := ASoftwareInformationType;
  FSoftwareInformation_Specified := True;
end;

function StandardBusinessDocumentHeaderType.SoftwareInformation_Specified(Index: Integer): boolean;
begin
  Result := FSoftwareInformation_Specified;
end;

procedure StandardBusinessDocumentHeaderType.SetBusinessDocuments(Index: Integer; const ABusinessDocumentsType: BusinessDocumentsType);
begin
  FBusinessDocuments := ABusinessDocumentsType;
  FBusinessDocuments_Specified := True;
end;

function StandardBusinessDocumentHeaderType.BusinessDocuments_Specified(Index: Integer): boolean;
begin
  Result := FBusinessDocuments_Specified;
end;

procedure StandardBusinessDocumentHeaderType.SetMessageEvent(Index: Integer; const AMessageEventType: MessageEventType);
begin
  FMessageEvent := AMessageEventType;
  FMessageEvent_Specified := True;
end;

function StandardBusinessDocumentHeaderType.MessageEvent_Specified(Index: Integer): boolean;
begin
  Result := FMessageEvent_Specified;
end;

destructor AttachmentInstanceType.Destroy;
begin
  SysUtils.FreeAndNil(FMessage_Attachment_Instance_BinaryObject);
  inherited Destroy;
end;

procedure AttachmentType.SetMessage_Attachment_FileName_Text(Index: Integer; const AMessage_Attachment_FileName_TextType: Message_Attachment_FileName_TextType);
begin
  FMessage_Attachment_FileName_Text := AMessage_Attachment_FileName_TextType;
  FMessage_Attachment_FileName_Text_Specified := True;
end;

function AttachmentType.Message_Attachment_FileName_Text_Specified(Index: Integer): boolean;
begin
  Result := FMessage_Attachment_FileName_Text_Specified;
end;

procedure AttachmentType.SetMessage_Attachment_Description_Text(Index: Integer; const AMessage_Attachment_Description_TextType: Message_Attachment_Description_TextType);
begin
  FMessage_Attachment_Description_Text := AMessage_Attachment_Description_TextType;
  FMessage_Attachment_Description_Text_Specified := True;
end;

function AttachmentType.Message_Attachment_Description_Text_Specified(Index: Integer): boolean;
begin
  Result := FMessage_Attachment_Description_Text_Specified;
end;

destructor BusinessDocumentInstanceType.Destroy;
begin
  SysUtils.FreeAndNil(FBusinessDocument_Instance_Text);
  inherited Destroy;
end;

procedure MessageEventItemLocationType.SetMessage_Event_Item_Location_Path_Text(Index: Integer; const AMessage_Event_Item_Location_Path_TextType: Message_Event_Item_Location_Path_TextType);
begin
  FMessage_Event_Item_Location_Path_Text := AMessage_Event_Item_Location_Path_TextType;
  FMessage_Event_Item_Location_Path_Text_Specified := True;
end;

function MessageEventItemLocationType.Message_Event_Item_Location_Path_Text_Specified(Index: Integer): boolean;
begin
  Result := FMessage_Event_Item_Location_Path_Text_Specified;
end;

destructor MessageTimestampType.Destroy;
begin
  SysUtils.FreeAndNil(FMessage_Timestamp_Generation_Datetime);
  inherited Destroy;
end;

destructor BusinessDocumentType.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FAttachments)-1 do
    SysUtils.FreeAndNil(FAttachments[I]);
  System.SetLength(FAttachments, 0);
  SysUtils.FreeAndNil(FBusinessDocument_Creation_Datetime);
  inherited Destroy;
end;

procedure BusinessDocumentType.SetBusinessDocument_BusinessGeneratedIdentifier_Text(Index: Integer; const ABusinessDocument_BusinessGeneratedIdentifier_TextType: BusinessDocument_BusinessGeneratedIdentifier_TextType);
begin
  FBusinessDocument_BusinessGeneratedIdentifier_Text := ABusinessDocument_BusinessGeneratedIdentifier_TextType;
  FBusinessDocument_BusinessGeneratedIdentifier_Text_Specified := True;
end;

function BusinessDocumentType.BusinessDocument_BusinessGeneratedIdentifier_Text_Specified(Index: Integer): boolean;
begin
  Result := FBusinessDocument_BusinessGeneratedIdentifier_Text_Specified;
end;

procedure BusinessDocumentType.SetBusinessDocument_GovernmentGeneratedIdentifier_Text(Index: Integer; const ABusinessDocument_GovernmentGeneratedIdentifier_TextType: BusinessDocument_GovernmentGeneratedIdentifier_TextType);
begin
  FBusinessDocument_GovernmentGeneratedIdentifier_Text := ABusinessDocument_GovernmentGeneratedIdentifier_TextType;
  FBusinessDocument_GovernmentGeneratedIdentifier_Text_Specified := True;
end;

function BusinessDocumentType.BusinessDocument_GovernmentGeneratedIdentifier_Text_Specified(Index: Integer): boolean;
begin
  Result := FBusinessDocument_GovernmentGeneratedIdentifier_Text_Specified;
end;

procedure BusinessDocumentType.SetAttachments(Index: Integer; const AAttachmentsType: AttachmentsType);
begin
  FAttachments := AAttachmentsType;
  FAttachments_Specified := True;
end;

function BusinessDocumentType.Attachments_Specified(Index: Integer): boolean;
begin
  Result := FAttachments_Specified;
end;

initialization
  { ILodge02 }
  InvRegistry.RegisterInterface(TypeInfo(ILodge02), 'http://sbr.gov.au/comn/lodge.02.service', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ILodge02), 'http://sbr.gov.au/services/lodge.02.service/LodgeReport');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ILodge02), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(ILodge02), ioLiteral);
  InvRegistry.RegisterInvokeOptions(TypeInfo(ILodge02), ioSOAP12);
  InvRegistry.RegisterHeaderClass(TypeInfo(ILodge02), NonRepudiation, 'nonRepudiation', 'http://sbr.gov.au/comn/core.02.data');
  RemClassRegistry.RegisterXSInfo(TypeInfo(MessageEventItemLocationsType), 'http://sbr.gov.au/comn/sbdm.02.data', 'MessageEventItemLocationsType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(MessageEventItemParametersType), 'http://sbr.gov.au/comn/sbdm.02.data', 'MessageEventItemParametersType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(MessageEventItemsType), 'http://sbr.gov.au/comn/sbdm.02.data', 'MessageEventItemsType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Event_Item_Severity_CodeType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Event_Item_Severity_CodeType', 'Message.Event.Item.Severity.CodeType');
  RemClassRegistry.RegisterXSClass(Message_NonRepudiationToken_TextType, 'http://sbr.gov.au/comn/core.02.data', 'Message_NonRepudiationToken_TextType', 'Message.NonRepudiationToken.TextType');
  RemClassRegistry.RegisterXSClass(NonRepudiationType, 'http://sbr.gov.au/comn/core.02.data', 'NonRepudiationType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(NonRepudiationType), 'Message_NonRepudiationToken_Text', '[ExtName="Message.NonRepudiationToken.Text"]');
  RemClassRegistry.RegisterXSClass(ResponseLodgeReport, 'http://sbr.gov.au/comn/lodge.02.service', 'ResponseLodgeReport');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(ResponseLodgeReport), 'StandardBusinessDocumentMessage', '[Namespace="http://sbr.gov.au/comn/sbdm.02.data"]');
  RemClassRegistry.RegisterSerializeOptions(ResponseLodgeReport, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(RequestLodgeReport, 'http://sbr.gov.au/comn/lodge.02.service', 'RequestLodgeReport');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(RequestLodgeReport), 'StandardBusinessDocumentMessage', '[Namespace="http://sbr.gov.au/comn/sbdm.02.data"]');
  RemClassRegistry.RegisterSerializeOptions(RequestLodgeReport, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(NonRepudiation, 'http://sbr.gov.au/comn/core.02.data', 'NonRepudiation');
  RemClassRegistry.RegisterXSInfo(TypeInfo(IdentificationDetails_IdentifierName_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'IdentificationDetails_IdentifierName_TextType', 'IdentificationDetails.IdentifierName.TextType');
  RemClassRegistry.RegisterXSClass(MessageEventType, 'http://sbr.gov.au/comn/sbdm.02.data', 'MessageEventType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventType), 'Message_Event_MaximumSeverity_Code', '[ExtName="Message.Event.MaximumSeverity.Code"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventType), 'MessageEventItems', '[ArrayItemName="MessageEventItem"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(BusinessDocumentsType), 'http://sbr.gov.au/comn/sbdm.02.data', 'BusinessDocumentsType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(AttachmentInstancesType), 'http://sbr.gov.au/comn/sbdm.02.data', 'AttachmentInstancesType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Lodgement_Receipt_DatetimeType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Lodgement_Receipt_DatetimeType', 'Lodgement.Receipt.DatetimeType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(BusinessDocumentInstancesType), 'http://sbr.gov.au/comn/sbdm.02.data', 'BusinessDocumentInstancesType');
  RemClassRegistry.RegisterXSClass(StandardBusinessDocumentMessageType, 'http://sbr.gov.au/comn/sbdm.02.data', 'StandardBusinessDocumentMessageType');
  RemClassRegistry.RegisterXSClass(StandardBusinessDocumentMessage, 'http://sbr.gov.au/comn/sbdm.02.data', 'StandardBusinessDocumentMessage');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Lodgement_Receipt_IdentifierType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Lodgement_Receipt_IdentifierType', 'Lodgement.Receipt.IdentifierType');
  RemClassRegistry.RegisterXSClass(LodgementReceiptType, 'http://sbr.gov.au/comn/sbdm.02.data', 'LodgementReceiptType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LodgementReceiptType), 'Lodgement_Receipt_Identifier', '[ExtName="Lodgement.Receipt.Identifier"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(LodgementReceiptType), 'Lodgement_Receipt_Datetime', '[ExtName="Lodgement.Receipt.Datetime"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(SoftwareInformation_ProductVersion_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'SoftwareInformation_ProductVersion_TextType', 'SoftwareInformation.ProductVersion.TextType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(OrganisationNameDetails_OrganisationalName_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'OrganisationNameDetails_OrganisationalName_TextType', 'OrganisationNameDetails.OrganisationalName.TextType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(SoftwareInformation_ProductName_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'SoftwareInformation_ProductName_TextType', 'SoftwareInformation.ProductName.TextType');
  RemClassRegistry.RegisterXSClass(SoftwareInformationType, 'http://sbr.gov.au/comn/sbdm.02.data', 'SoftwareInformationType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SoftwareInformationType), 'OrganisationNameDetails_OrganisationalName_Text', '[ExtName="OrganisationNameDetails.OrganisationalName.Text"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SoftwareInformationType), 'SoftwareInformation_ProductName_Text', '[ExtName="SoftwareInformation.ProductName.Text"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(SoftwareInformationType), 'SoftwareInformation_ProductVersion_Text', '[ExtName="SoftwareInformation.ProductVersion.Text"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(IdentificationDetails_IdentifierDesignation_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'IdentificationDetails_IdentifierDesignation_TextType', 'IdentificationDetails.IdentifierDesignation.TextType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Event_Item_Error_CodeType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Event_Item_Error_CodeType', 'Message.Event.Item.Error.CodeType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Event_Item_Short_DescriptionType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Event_Item_Short_DescriptionType', 'Message.Event.Item.Short.DescriptionType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Event_Item_Detailed_DescriptionType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Event_Item_Detailed_DescriptionType', 'Message.Event.Item.Detailed.DescriptionType');
  RemClassRegistry.RegisterXSClass(MessageEventItemType, 'http://sbr.gov.au/comn/sbdm.02.data', 'MessageEventItemType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventItemType), 'Message_Event_Item_Error_Code', '[ExtName="Message.Event.Item.Error.Code"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventItemType), 'Message_Event_Item_Severity_Code', '[ExtName="Message.Event.Item.Severity.Code"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventItemType), 'Message_Event_Item_Short_Description', '[ExtName="Message.Event.Item.Short.Description"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventItemType), 'Message_Event_Item_Detailed_Description', '[ExtName="Message.Event.Item.Detailed.Description"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventItemType), 'Parameters', '[ArrayItemName="Parameter"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventItemType), 'Locations', '[ArrayItemName="Location"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Event_Item_Parameter_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Event_Item_Parameter_TextType', 'Message.Event.Item.Parameter.TextType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Event_Item_Parameter_IdentifierType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Event_Item_Parameter_IdentifierType', 'Message.Event.Item.Parameter.IdentifierType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Event_Item_Location_Path_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Event_Item_Location_Path_TextType', 'Message.Event.Item.Location.Path.TextType');
  RemClassRegistry.RegisterXSClass(MessageEventItemParameterType, 'http://sbr.gov.au/comn/sbdm.02.data', 'MessageEventItemParameterType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventItemParameterType), 'Message_Event_Item_Parameter_Identifier', '[ExtName="Message.Event.Item.Parameter.Identifier"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventItemParameterType), 'Message_Event_Item_Parameter_Text', '[ExtName="Message.Event.Item.Parameter.Text"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(MessageTimestampsType), 'http://sbr.gov.au/comn/sbdm.02.data', 'MessageTimestampsType');
  RemClassRegistry.RegisterXSClass(PartyType, 'http://sbr.gov.au/comn/sbdm.02.data', 'PartyType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PartyType), 'IdentificationDetails_IdentifierDesignation_Text', '[ExtName="IdentificationDetails.IdentifierDesignation.Text"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PartyType), 'IdentificationDetails_IdentifierName_Text', '[ExtName="IdentificationDetails.IdentifierName.Text"]');
  RemClassRegistry.RegisterXSClass(StandardBusinessDocumentBodyType, 'http://sbr.gov.au/comn/sbdm.02.data', 'StandardBusinessDocumentBodyType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(StandardBusinessDocumentBodyType), 'BusinessDocumentInstances', '[ArrayItemName="BusinessDocumentInstance"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(StandardBusinessDocumentBodyType), 'AttachmentInstances', '[ArrayItemName="AttachmentInstance"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Type_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Type_TextType', 'Message.Type.TextType');
  RemClassRegistry.RegisterXSClass(StandardBusinessDocumentHeaderType, 'http://sbr.gov.au/comn/sbdm.02.data', 'StandardBusinessDocumentHeaderType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(StandardBusinessDocumentHeaderType), 'Message_Type_Text', '[ExtName="Message.Type.Text"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(StandardBusinessDocumentHeaderType), 'MessageTimestamps', '[ArrayItemName="MessageTimestamp"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(StandardBusinessDocumentHeaderType), 'BusinessDocuments', '[ArrayItemName="BusinessDocument"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Attachment_Sequence_NumberType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Attachment_Sequence_NumberType', 'Message.Attachment.Sequence.NumberType');
  RemClassRegistry.RegisterXSClass(BusinessDocument_Instance_TextType, 'http://sbr.gov.au/comn/sbdm.02.data', 'BusinessDocument_Instance_TextType', 'BusinessDocument.Instance.TextType');
  RemClassRegistry.RegisterXSClass(AttachmentInstanceType, 'http://sbr.gov.au/comn/sbdm.02.data', 'AttachmentInstanceType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(AttachmentInstanceType), 'Message_Attachment_Sequence_Number', '[ExtName="Message.Attachment.Sequence.Number"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(AttachmentInstanceType), 'Message_Attachment_Instance_BinaryObject', '[ExtName="Message.Attachment.Instance.BinaryObject"]');
  RemClassRegistry.RegisterXSClass(Message_Attachment_Instance_BinaryObjectType, 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Attachment_Instance_BinaryObjectType', 'Message.Attachment.Instance.BinaryObjectType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Message_Attachment_Instance_BinaryObjectType), 'contentType', '[Namespace="http://www.w3.org/2005/05/xmlmime"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Attachment_FileName_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Attachment_FileName_TextType', 'Message.Attachment.FileName.TextType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Attachment_Description_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Attachment_Description_TextType', 'Message.Attachment.Description.TextType');
  RemClassRegistry.RegisterXSClass(AttachmentType, 'http://sbr.gov.au/comn/sbdm.02.data', 'AttachmentType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(AttachmentType), 'Message_Attachment_Sequence_Number', '[ExtName="Message.Attachment.Sequence.Number"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(AttachmentType), 'Message_Attachment_FileName_Text', '[ExtName="Message.Attachment.FileName.Text"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(AttachmentType), 'Message_Attachment_Description_Text', '[ExtName="Message.Attachment.Description.Text"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(AttachmentsType), 'http://sbr.gov.au/comn/sbdm.02.data', 'AttachmentsType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(BusinessDocument_Sequence_NumberType), 'http://sbr.gov.au/comn/sbdm.02.data', 'BusinessDocument_Sequence_NumberType', 'BusinessDocument.Sequence.NumberType');
  RemClassRegistry.RegisterXSClass(BusinessDocumentInstanceType, 'http://sbr.gov.au/comn/sbdm.02.data', 'BusinessDocumentInstanceType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BusinessDocumentInstanceType), 'BusinessDocument_Sequence_Number', '[ExtName="BusinessDocument.Sequence.Number"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BusinessDocumentInstanceType), 'BusinessDocument_Instance_Text', '[ExtName="BusinessDocument.Instance.Text"]');
  RemClassRegistry.RegisterXSClass(MessageEventItemLocationType, 'http://sbr.gov.au/comn/sbdm.02.data', 'MessageEventItemLocationType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventItemLocationType), 'BusinessDocument_Sequence_Number', '[ExtName="BusinessDocument.Sequence.Number"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageEventItemLocationType), 'Message_Event_Item_Location_Path_Text', '[ExtName="Message.Event.Item.Location.Path.Text"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Timestamp_Generation_DatetimeType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Timestamp_Generation_DatetimeType', 'Message.Timestamp.Generation.DatetimeType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Message_Timestamp_GenerationSource_CodeType), 'http://sbr.gov.au/comn/sbdm.02.data', 'Message_Timestamp_GenerationSource_CodeType', 'Message.Timestamp.GenerationSource.CodeType');
  RemClassRegistry.RegisterXSClass(MessageTimestampType, 'http://sbr.gov.au/comn/sbdm.02.data', 'MessageTimestampType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageTimestampType), 'Message_Timestamp_Generation_Datetime', '[ExtName="Message.Timestamp.Generation.Datetime"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(MessageTimestampType), 'Message_Timestamp_GenerationSource_Code', '[ExtName="Message.Timestamp.GenerationSource.Code"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(BusinessDocument_BusinessGeneratedIdentifier_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'BusinessDocument_BusinessGeneratedIdentifier_TextType', 'BusinessDocument.BusinessGeneratedIdentifier.TextType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(BusinessDocument_GovernmentGeneratedIdentifier_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'BusinessDocument_GovernmentGeneratedIdentifier_TextType', 'BusinessDocument.GovernmentGeneratedIdentifier.TextType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(BusinessDocument_Creation_DatetimeType), 'http://sbr.gov.au/comn/sbdm.02.data', 'BusinessDocument_Creation_DatetimeType', 'BusinessDocument.Creation.DatetimeType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(BusinessDocument_ValidationUniformResourceIdentifier_TextType), 'http://sbr.gov.au/comn/sbdm.02.data', 'BusinessDocument_ValidationUniformResourceIdentifier_TextType', 'BusinessDocument.ValidationUniformResourceIdentifier.TextType');
  RemClassRegistry.RegisterXSClass(BusinessDocumentType, 'http://sbr.gov.au/comn/sbdm.02.data', 'BusinessDocumentType');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BusinessDocumentType), 'BusinessDocument_Sequence_Number', '[ExtName="BusinessDocument.Sequence.Number"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BusinessDocumentType), 'BusinessDocument_Creation_Datetime', '[ExtName="BusinessDocument.Creation.Datetime"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BusinessDocumentType), 'BusinessDocument_ValidationUniformResourceIdentifier_Text', '[ExtName="BusinessDocument.ValidationUniformResourceIdentifier.Text"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BusinessDocumentType), 'BusinessDocument_BusinessGeneratedIdentifier_Text', '[ExtName="BusinessDocument.BusinessGeneratedIdentifier.Text"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BusinessDocumentType), 'BusinessDocument_GovernmentGeneratedIdentifier_Text', '[ExtName="BusinessDocument.GovernmentGeneratedIdentifier.Text"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(BusinessDocumentType), 'Attachments', '[ArrayItemName="Attachment"]');

end.