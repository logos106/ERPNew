
{***********************************************************************************************************************************************************}
{                                                                                                                                                           }
{                                                                     XML Data Binding                                                                      }
{                                                                                                                                                           }
{         Generated on: 22/06/2018 2:40:11 PM                                                                                                               }
{       Generated from: C:\Dev\ERP\Dev\Aus_Gov\SBR\ato\ATO-PAYEVNT.0003-2018-Package-v1.0\ATO PAYEVNT.0003 2018 Contracts\ato.payevnt.0003.2018.01.00.xsd   }
{   Settings stored in: C:\Dev\ERP\Dev\Aus_Gov\SBR\ato\ATO-PAYEVNT.0003-2018-Package-v1.0\ATO PAYEVNT.0003 2018 Contracts\ato.payevnt.0003.2018.01.00.xdb   }
{                                                                                                                                                           }
{***********************************************************************************************************************************************************}

unit atopayevnt000320180100;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLPAYEVNT = interface;
  IXMLRp = interface;
  IXMLOrganisationName = interface;
  IXMLElectronicContact = interface;
  IXMLAddressDetailsPostal = interface;
  IXMLPayroll = interface;
  IXMLIncomeTaxAndRemuneration = interface;
  IXMLDeclaration = interface;
  IXMLInt = interface;

{ IXMLPAYEVNT }

  IXMLPAYEVNT = interface(IXMLNode)
    ['{FACA1A70-30D8-4EC1-AAA1-6917AF0F1230}']
    { Property Accessors }
    function Get_Rp: IXMLRp;
    function Get_Int: IXMLInt;
    { Methods & Properties }
    property Rp: IXMLRp read Get_Rp;
    property Int: IXMLInt read Get_Int;
  end;

{ IXMLRp }

  IXMLRp = interface(IXMLNode)
    ['{9910DB09-AD06-4E72-A125-F959563BB6A1}']
    { Property Accessors }
    function Get_SoftwareInformationBusinessManagementSystemId: UnicodeString;
    function Get_AustralianBusinessNumberId: UnicodeString;
    function Get_WithholdingPayerNumberId: UnicodeString;
    function Get_OrganisationDetailsOrganisationBranchC: UnicodeString;
    function Get_OrganisationName: IXMLOrganisationName;
    function Get_ElectronicContact: IXMLElectronicContact;
    function Get_AddressDetailsPostal: IXMLAddressDetailsPostal;
    function Get_Payroll: IXMLPayroll;
    function Get_Declaration: IXMLDeclaration;
    procedure Set_SoftwareInformationBusinessManagementSystemId(Value: UnicodeString);
    procedure Set_AustralianBusinessNumberId(Value: UnicodeString);
    procedure Set_WithholdingPayerNumberId(Value: UnicodeString);
    procedure Set_OrganisationDetailsOrganisationBranchC(Value: UnicodeString);
    { Methods & Properties }
    property SoftwareInformationBusinessManagementSystemId: UnicodeString read Get_SoftwareInformationBusinessManagementSystemId write Set_SoftwareInformationBusinessManagementSystemId;
    property AustralianBusinessNumberId: UnicodeString read Get_AustralianBusinessNumberId write Set_AustralianBusinessNumberId;
    property WithholdingPayerNumberId: UnicodeString read Get_WithholdingPayerNumberId write Set_WithholdingPayerNumberId;
    property OrganisationDetailsOrganisationBranchC: UnicodeString read Get_OrganisationDetailsOrganisationBranchC write Set_OrganisationDetailsOrganisationBranchC;
    property OrganisationName: IXMLOrganisationName read Get_OrganisationName;
    property ElectronicContact: IXMLElectronicContact read Get_ElectronicContact;
    property AddressDetailsPostal: IXMLAddressDetailsPostal read Get_AddressDetailsPostal;
    property Payroll: IXMLPayroll read Get_Payroll;
    property Declaration: IXMLDeclaration read Get_Declaration;
  end;

{ IXMLOrganisationName }

  IXMLOrganisationName = interface(IXMLNode)
    ['{02F58759-15AC-4F40-AA31-D7A50A2862BE}']
    { Property Accessors }
    function Get_DetailsOrganisationalNameT: UnicodeString;
    function Get_PersonUnstructuredNameFullNameT: UnicodeString;
    procedure Set_DetailsOrganisationalNameT(Value: UnicodeString);
    procedure Set_PersonUnstructuredNameFullNameT(Value: UnicodeString);
    { Methods & Properties }
    property DetailsOrganisationalNameT: UnicodeString read Get_DetailsOrganisationalNameT write Set_DetailsOrganisationalNameT;
    property PersonUnstructuredNameFullNameT: UnicodeString read Get_PersonUnstructuredNameFullNameT write Set_PersonUnstructuredNameFullNameT;
  end;

{ IXMLElectronicContact }

  IXMLElectronicContact = interface(IXMLNode)
    ['{D86B20C6-B44B-4880-B881-FE3E9B3B4BF9}']
    { Property Accessors }
    function Get_ElectronicMailAddressT: UnicodeString;
    function Get_TelephoneMinimalN: UnicodeString;
    procedure Set_ElectronicMailAddressT(Value: UnicodeString);
    procedure Set_TelephoneMinimalN(Value: UnicodeString);
    { Methods & Properties }
    property ElectronicMailAddressT: UnicodeString read Get_ElectronicMailAddressT write Set_ElectronicMailAddressT;
    property TelephoneMinimalN: UnicodeString read Get_TelephoneMinimalN write Set_TelephoneMinimalN;
  end;

{ IXMLAddressDetailsPostal }

  IXMLAddressDetailsPostal = interface(IXMLNode)
    ['{D7AF6303-1432-49BB-937C-114210CFCA97}']
    { Property Accessors }
    function Get_Line1T: UnicodeString;
    function Get_Line2T: UnicodeString;
    function Get_LocalityNameT: UnicodeString;
    function Get_StateOrTerritoryC: UnicodeString;
    function Get_PostcodeT: UnicodeString;
    function Get_CountryC: UnicodeString;
    procedure Set_Line1T(Value: UnicodeString);
    procedure Set_Line2T(Value: UnicodeString);
    procedure Set_LocalityNameT(Value: UnicodeString);
    procedure Set_StateOrTerritoryC(Value: UnicodeString);
    procedure Set_PostcodeT(Value: UnicodeString);
    procedure Set_CountryC(Value: UnicodeString);
    { Methods & Properties }
    property Line1T: UnicodeString read Get_Line1T write Set_Line1T;
    property Line2T: UnicodeString read Get_Line2T write Set_Line2T;
    property LocalityNameT: UnicodeString read Get_LocalityNameT write Set_LocalityNameT;
    property StateOrTerritoryC: UnicodeString read Get_StateOrTerritoryC write Set_StateOrTerritoryC;
    property PostcodeT: UnicodeString read Get_PostcodeT write Set_PostcodeT;
    property CountryC: UnicodeString read Get_CountryC write Set_CountryC;
  end;

{ IXMLPayroll }

  IXMLPayroll = interface(IXMLNode)
    ['{0D159D8B-F232-4F3A-9DA5-0C8CBB09A217}']
    { Property Accessors }
    function Get_PaymentRecordTransactionD: UnicodeString;
    function Get_InteractionRecordCt: LongWord;
    function Get_MessageTimestampGenerationDt: UnicodeString;
    function Get_InteractionTransactionId: UnicodeString;
    function Get_AmendmentI: Boolean;
    function Get_IncomeTaxAndRemuneration: IXMLIncomeTaxAndRemuneration;
    procedure Set_PaymentRecordTransactionD(Value: UnicodeString);
    procedure Set_InteractionRecordCt(Value: LongWord);
    procedure Set_MessageTimestampGenerationDt(Value: UnicodeString);
    procedure Set_InteractionTransactionId(Value: UnicodeString);
    procedure Set_AmendmentI(Value: Boolean);
    { Methods & Properties }
    property PaymentRecordTransactionD: UnicodeString read Get_PaymentRecordTransactionD write Set_PaymentRecordTransactionD;
    property InteractionRecordCt: LongWord read Get_InteractionRecordCt write Set_InteractionRecordCt;
    property MessageTimestampGenerationDt: UnicodeString read Get_MessageTimestampGenerationDt write Set_MessageTimestampGenerationDt;
    property InteractionTransactionId: UnicodeString read Get_InteractionTransactionId write Set_InteractionTransactionId;
    property AmendmentI: Boolean read Get_AmendmentI write Set_AmendmentI;
    property IncomeTaxAndRemuneration: IXMLIncomeTaxAndRemuneration read Get_IncomeTaxAndRemuneration;
  end;

{ IXMLIncomeTaxAndRemuneration }

  IXMLIncomeTaxAndRemuneration = interface(IXMLNode)
    ['{24C6593F-B228-4F1F-AFC0-790E7D40B7E1}']
    { Property Accessors }
    function Get_PayAsYouGoWithholdingTaxWithheldA: UnicodeString;
    function Get_TotalGrossPaymentsWithholdingA: UnicodeString;
    procedure Set_PayAsYouGoWithholdingTaxWithheldA(Value: UnicodeString);
    procedure Set_TotalGrossPaymentsWithholdingA(Value: UnicodeString);
    { Methods & Properties }
    property PayAsYouGoWithholdingTaxWithheldA: UnicodeString read Get_PayAsYouGoWithholdingTaxWithheldA write Set_PayAsYouGoWithholdingTaxWithheldA;
    property TotalGrossPaymentsWithholdingA: UnicodeString read Get_TotalGrossPaymentsWithholdingA write Set_TotalGrossPaymentsWithholdingA;
  end;

{ IXMLDeclaration }

  IXMLDeclaration = interface(IXMLNode)
    ['{54A3C33E-5DC6-4F58-A26F-29B8C17C5AF6}']
    { Property Accessors }
    function Get_SignatoryIdentifierT: UnicodeString;
    function Get_SignatureD: UnicodeString;
    function Get_StatementAcceptedI: Boolean;
    procedure Set_SignatoryIdentifierT(Value: UnicodeString);
    procedure Set_SignatureD(Value: UnicodeString);
    procedure Set_StatementAcceptedI(Value: Boolean);
    { Methods & Properties }
    property SignatoryIdentifierT: UnicodeString read Get_SignatoryIdentifierT write Set_SignatoryIdentifierT;
    property SignatureD: UnicodeString read Get_SignatureD write Set_SignatureD;
    property StatementAcceptedI: Boolean read Get_StatementAcceptedI write Set_StatementAcceptedI;
  end;

{ IXMLInt }

  IXMLInt = interface(IXMLNode)
    ['{EE49706E-0A2E-4FF9-8168-869568E0E221}']
    { Property Accessors }
    function Get_AustralianBusinessNumberId: UnicodeString;
    function Get_TaxAgentNumberId: UnicodeString;
    function Get_PersonUnstructuredNameFullNameT: UnicodeString;
    function Get_ElectronicContact: IXMLElectronicContact;
    function Get_Declaration: IXMLDeclaration;
    procedure Set_AustralianBusinessNumberId(Value: UnicodeString);
    procedure Set_TaxAgentNumberId(Value: UnicodeString);
    procedure Set_PersonUnstructuredNameFullNameT(Value: UnicodeString);
    { Methods & Properties }
    property AustralianBusinessNumberId: UnicodeString read Get_AustralianBusinessNumberId write Set_AustralianBusinessNumberId;
    property TaxAgentNumberId: UnicodeString read Get_TaxAgentNumberId write Set_TaxAgentNumberId;
    property PersonUnstructuredNameFullNameT: UnicodeString read Get_PersonUnstructuredNameFullNameT write Set_PersonUnstructuredNameFullNameT;
    property ElectronicContact: IXMLElectronicContact read Get_ElectronicContact;
    property Declaration: IXMLDeclaration read Get_Declaration;
  end;

{ Forward Decls }

  TXMLPAYEVNT = class;
  TXMLRp = class;
  TXMLOrganisationName = class;
  TXMLElectronicContact = class;
  TXMLAddressDetailsPostal = class;
  TXMLPayroll = class;
  TXMLIncomeTaxAndRemuneration = class;
  TXMLDeclaration = class;
  TXMLInt = class;

{ TXMLPAYEVNT }

  TXMLPAYEVNT = class(TXMLNode, IXMLPAYEVNT)
  protected
    { IXMLPAYEVNT }
    function Get_Rp: IXMLRp;
    function Get_Int: IXMLInt;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRp }

  TXMLRp = class(TXMLNode, IXMLRp)
  protected
    { IXMLRp }
    function Get_SoftwareInformationBusinessManagementSystemId: UnicodeString;
    function Get_AustralianBusinessNumberId: UnicodeString;
    function Get_WithholdingPayerNumberId: UnicodeString;
    function Get_OrganisationDetailsOrganisationBranchC: UnicodeString;
    function Get_OrganisationName: IXMLOrganisationName;
    function Get_ElectronicContact: IXMLElectronicContact;
    function Get_AddressDetailsPostal: IXMLAddressDetailsPostal;
    function Get_Payroll: IXMLPayroll;
    function Get_Declaration: IXMLDeclaration;
    procedure Set_SoftwareInformationBusinessManagementSystemId(Value: UnicodeString);
    procedure Set_AustralianBusinessNumberId(Value: UnicodeString);
    procedure Set_WithholdingPayerNumberId(Value: UnicodeString);
    procedure Set_OrganisationDetailsOrganisationBranchC(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLOrganisationName }

  TXMLOrganisationName = class(TXMLNode, IXMLOrganisationName)
  protected
    { IXMLOrganisationName }
    function Get_DetailsOrganisationalNameT: UnicodeString;
    function Get_PersonUnstructuredNameFullNameT: UnicodeString;
    procedure Set_DetailsOrganisationalNameT(Value: UnicodeString);
    procedure Set_PersonUnstructuredNameFullNameT(Value: UnicodeString);
  end;

{ TXMLElectronicContact }

  TXMLElectronicContact = class(TXMLNode, IXMLElectronicContact)
  protected
    { IXMLElectronicContact }
    function Get_ElectronicMailAddressT: UnicodeString;
    function Get_TelephoneMinimalN: UnicodeString;
    procedure Set_ElectronicMailAddressT(Value: UnicodeString);
    procedure Set_TelephoneMinimalN(Value: UnicodeString);
  end;

{ TXMLAddressDetailsPostal }

  TXMLAddressDetailsPostal = class(TXMLNode, IXMLAddressDetailsPostal)
  protected
    { IXMLAddressDetailsPostal }
    function Get_Line1T: UnicodeString;
    function Get_Line2T: UnicodeString;
    function Get_LocalityNameT: UnicodeString;
    function Get_StateOrTerritoryC: UnicodeString;
    function Get_PostcodeT: UnicodeString;
    function Get_CountryC: UnicodeString;
    procedure Set_Line1T(Value: UnicodeString);
    procedure Set_Line2T(Value: UnicodeString);
    procedure Set_LocalityNameT(Value: UnicodeString);
    procedure Set_StateOrTerritoryC(Value: UnicodeString);
    procedure Set_PostcodeT(Value: UnicodeString);
    procedure Set_CountryC(Value: UnicodeString);
  end;

{ TXMLPayroll }

  TXMLPayroll = class(TXMLNode, IXMLPayroll)
  protected
    { IXMLPayroll }
    function Get_PaymentRecordTransactionD: UnicodeString;
    function Get_InteractionRecordCt: LongWord;
    function Get_MessageTimestampGenerationDt: UnicodeString;
    function Get_InteractionTransactionId: UnicodeString;
    function Get_AmendmentI: Boolean;
    function Get_IncomeTaxAndRemuneration: IXMLIncomeTaxAndRemuneration;
    procedure Set_PaymentRecordTransactionD(Value: UnicodeString);
    procedure Set_InteractionRecordCt(Value: LongWord);
    procedure Set_MessageTimestampGenerationDt(Value: UnicodeString);
    procedure Set_InteractionTransactionId(Value: UnicodeString);
    procedure Set_AmendmentI(Value: Boolean);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIncomeTaxAndRemuneration }

  TXMLIncomeTaxAndRemuneration = class(TXMLNode, IXMLIncomeTaxAndRemuneration)
  protected
    { IXMLIncomeTaxAndRemuneration }
    function Get_PayAsYouGoWithholdingTaxWithheldA: UnicodeString;
    function Get_TotalGrossPaymentsWithholdingA: UnicodeString;
    procedure Set_PayAsYouGoWithholdingTaxWithheldA(Value: UnicodeString);
    procedure Set_TotalGrossPaymentsWithholdingA(Value: UnicodeString);
  end;

{ TXMLDeclaration }

  TXMLDeclaration = class(TXMLNode, IXMLDeclaration)
  protected
    { IXMLDeclaration }
    function Get_SignatoryIdentifierT: UnicodeString;
    function Get_SignatureD: UnicodeString;
    function Get_StatementAcceptedI: Boolean;
    procedure Set_SignatoryIdentifierT(Value: UnicodeString);
    procedure Set_SignatureD(Value: UnicodeString);
    procedure Set_StatementAcceptedI(Value: Boolean);
  end;

{ TXMLInt }

  TXMLInt = class(TXMLNode, IXMLInt)
  protected
    { IXMLInt }
    function Get_AustralianBusinessNumberId: UnicodeString;
    function Get_TaxAgentNumberId: UnicodeString;
    function Get_PersonUnstructuredNameFullNameT: UnicodeString;
    function Get_ElectronicContact: IXMLElectronicContact;
    function Get_Declaration: IXMLDeclaration;
    procedure Set_AustralianBusinessNumberId(Value: UnicodeString);
    procedure Set_TaxAgentNumberId(Value: UnicodeString);
    procedure Set_PersonUnstructuredNameFullNameT(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ Global Functions }

function GetPAYEVNT(Doc: IXMLDocument): IXMLPAYEVNT;
function LoadPAYEVNT(const FileName: string): IXMLPAYEVNT;
function NewPAYEVNT: IXMLPAYEVNT;

const
  TargetNamespace = 'http://www.sbr.gov.au/ato/payevnt';

implementation

{ Global Functions }

function GetPAYEVNT(Doc: IXMLDocument): IXMLPAYEVNT;
begin
  Result := Doc.GetDocBinding('PAYEVNT', TXMLPAYEVNT, TargetNamespace) as IXMLPAYEVNT;
end;

function LoadPAYEVNT(const FileName: string): IXMLPAYEVNT;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('PAYEVNT', TXMLPAYEVNT, TargetNamespace) as IXMLPAYEVNT;
end;

function NewPAYEVNT: IXMLPAYEVNT;
begin
  Result := NewXMLDocument.GetDocBinding('PAYEVNT', TXMLPAYEVNT, TargetNamespace) as IXMLPAYEVNT;
end;

{ TXMLPAYEVNT }

procedure TXMLPAYEVNT.AfterConstruction;
begin
  RegisterChildNode('Rp', TXMLRp);
  RegisterChildNode('Int', TXMLInt);
  inherited;
end;

function TXMLPAYEVNT.Get_Rp: IXMLRp;
begin
  Result := ChildNodes['Rp'] as IXMLRp;
end;

function TXMLPAYEVNT.Get_Int: IXMLInt;
begin
  Result := ChildNodes['Int'] as IXMLInt;
end;

{ TXMLRp }

procedure TXMLRp.AfterConstruction;
begin
  RegisterChildNode('OrganisationName', TXMLOrganisationName);
  RegisterChildNode('ElectronicContact', TXMLElectronicContact);
  RegisterChildNode('AddressDetailsPostal', TXMLAddressDetailsPostal);
  RegisterChildNode('Payroll', TXMLPayroll);
  RegisterChildNode('Declaration', TXMLDeclaration);
  inherited;
end;

function TXMLRp.Get_SoftwareInformationBusinessManagementSystemId: UnicodeString;
begin
  Result := ChildNodes['SoftwareInformationBusinessManagementSystemId'].Text;
end;

procedure TXMLRp.Set_SoftwareInformationBusinessManagementSystemId(Value: UnicodeString);
begin
  ChildNodes['SoftwareInformationBusinessManagementSystemId'].NodeValue := Value;
end;

function TXMLRp.Get_AustralianBusinessNumberId: UnicodeString;
begin
  Result := ChildNodes['AustralianBusinessNumberId'].Text;
end;

procedure TXMLRp.Set_AustralianBusinessNumberId(Value: UnicodeString);
begin
  ChildNodes['AustralianBusinessNumberId'].NodeValue := Value;
end;

function TXMLRp.Get_WithholdingPayerNumberId: UnicodeString;
begin
  Result := ChildNodes['WithholdingPayerNumberId'].Text;
end;

procedure TXMLRp.Set_WithholdingPayerNumberId(Value: UnicodeString);
begin
  ChildNodes['WithholdingPayerNumberId'].NodeValue := Value;
end;

function TXMLRp.Get_OrganisationDetailsOrganisationBranchC: UnicodeString;
begin
  Result := ChildNodes['OrganisationDetailsOrganisationBranchC'].Text;
end;

procedure TXMLRp.Set_OrganisationDetailsOrganisationBranchC(Value: UnicodeString);
begin
  ChildNodes['OrganisationDetailsOrganisationBranchC'].NodeValue := Value;
end;

function TXMLRp.Get_OrganisationName: IXMLOrganisationName;
begin
  Result := ChildNodes['OrganisationName'] as IXMLOrganisationName;
end;

function TXMLRp.Get_ElectronicContact: IXMLElectronicContact;
begin
  Result := ChildNodes['ElectronicContact'] as IXMLElectronicContact;
end;

function TXMLRp.Get_AddressDetailsPostal: IXMLAddressDetailsPostal;
begin
  Result := ChildNodes['AddressDetailsPostal'] as IXMLAddressDetailsPostal;
end;

function TXMLRp.Get_Payroll: IXMLPayroll;
begin
  Result := ChildNodes['Payroll'] as IXMLPayroll;
end;

function TXMLRp.Get_Declaration: IXMLDeclaration;
begin
  Result := ChildNodes['Declaration'] as IXMLDeclaration;
end;

{ TXMLOrganisationName }

function TXMLOrganisationName.Get_DetailsOrganisationalNameT: UnicodeString;
begin
  Result := ChildNodes['DetailsOrganisationalNameT'].Text;
end;

procedure TXMLOrganisationName.Set_DetailsOrganisationalNameT(Value: UnicodeString);
begin
  ChildNodes['DetailsOrganisationalNameT'].NodeValue := Value;
end;

function TXMLOrganisationName.Get_PersonUnstructuredNameFullNameT: UnicodeString;
begin
  Result := ChildNodes['PersonUnstructuredNameFullNameT'].Text;
end;

procedure TXMLOrganisationName.Set_PersonUnstructuredNameFullNameT(Value: UnicodeString);
begin
  ChildNodes['PersonUnstructuredNameFullNameT'].NodeValue := Value;
end;

{ TXMLElectronicContact }

function TXMLElectronicContact.Get_ElectronicMailAddressT: UnicodeString;
begin
  Result := ChildNodes['ElectronicMailAddressT'].Text;
end;

procedure TXMLElectronicContact.Set_ElectronicMailAddressT(Value: UnicodeString);
begin
  ChildNodes['ElectronicMailAddressT'].NodeValue := Value;
end;

function TXMLElectronicContact.Get_TelephoneMinimalN: UnicodeString;
begin
  Result := ChildNodes['TelephoneMinimalN'].Text;
end;

procedure TXMLElectronicContact.Set_TelephoneMinimalN(Value: UnicodeString);
begin
  ChildNodes['TelephoneMinimalN'].NodeValue := Value;
end;

{ TXMLAddressDetailsPostal }

function TXMLAddressDetailsPostal.Get_Line1T: UnicodeString;
begin
  Result := ChildNodes['Line1T'].Text;
end;

procedure TXMLAddressDetailsPostal.Set_Line1T(Value: UnicodeString);
begin
  ChildNodes['Line1T'].NodeValue := Value;
end;

function TXMLAddressDetailsPostal.Get_Line2T: UnicodeString;
begin
  Result := ChildNodes['Line2T'].Text;
end;

procedure TXMLAddressDetailsPostal.Set_Line2T(Value: UnicodeString);
begin
  ChildNodes['Line2T'].NodeValue := Value;
end;

function TXMLAddressDetailsPostal.Get_LocalityNameT: UnicodeString;
begin
  Result := ChildNodes['LocalityNameT'].Text;
end;

procedure TXMLAddressDetailsPostal.Set_LocalityNameT(Value: UnicodeString);
begin
  ChildNodes['LocalityNameT'].NodeValue := Value;
end;

function TXMLAddressDetailsPostal.Get_StateOrTerritoryC: UnicodeString;
begin
  Result := ChildNodes['StateOrTerritoryC'].Text;
end;

procedure TXMLAddressDetailsPostal.Set_StateOrTerritoryC(Value: UnicodeString);
begin
  ChildNodes['StateOrTerritoryC'].NodeValue := Value;
end;

function TXMLAddressDetailsPostal.Get_PostcodeT: UnicodeString;
begin
  Result := ChildNodes['PostcodeT'].Text;
end;

procedure TXMLAddressDetailsPostal.Set_PostcodeT(Value: UnicodeString);
begin
  ChildNodes['PostcodeT'].NodeValue := Value;
end;

function TXMLAddressDetailsPostal.Get_CountryC: UnicodeString;
begin
  Result := ChildNodes['CountryC'].Text;
end;

procedure TXMLAddressDetailsPostal.Set_CountryC(Value: UnicodeString);
begin
  ChildNodes['CountryC'].NodeValue := Value;
end;

{ TXMLPayroll }

procedure TXMLPayroll.AfterConstruction;
begin
  RegisterChildNode('IncomeTaxAndRemuneration', TXMLIncomeTaxAndRemuneration);
  inherited;
end;

function TXMLPayroll.Get_PaymentRecordTransactionD: UnicodeString;
begin
  Result := ChildNodes['PaymentRecordTransactionD'].Text;
end;

procedure TXMLPayroll.Set_PaymentRecordTransactionD(Value: UnicodeString);
begin
  ChildNodes['PaymentRecordTransactionD'].NodeValue := Value;
end;

function TXMLPayroll.Get_InteractionRecordCt: LongWord;
begin
  Result := ChildNodes['InteractionRecordCt'].NodeValue;
end;

procedure TXMLPayroll.Set_InteractionRecordCt(Value: LongWord);
begin
  ChildNodes['InteractionRecordCt'].NodeValue := Value;
end;

function TXMLPayroll.Get_MessageTimestampGenerationDt: UnicodeString;
begin
  Result := ChildNodes['MessageTimestampGenerationDt'].Text;
end;

procedure TXMLPayroll.Set_MessageTimestampGenerationDt(Value: UnicodeString);
begin
  ChildNodes['MessageTimestampGenerationDt'].NodeValue := Value;
end;

function TXMLPayroll.Get_InteractionTransactionId: UnicodeString;
begin
  Result := ChildNodes['InteractionTransactionId'].Text;
end;

procedure TXMLPayroll.Set_InteractionTransactionId(Value: UnicodeString);
begin
  ChildNodes['InteractionTransactionId'].NodeValue := Value;
end;

function TXMLPayroll.Get_AmendmentI: Boolean;
begin
  Result := ChildNodes['AmendmentI'].NodeValue;
end;

procedure TXMLPayroll.Set_AmendmentI(Value: Boolean);
begin
  ChildNodes['AmendmentI'].NodeValue := Value;
end;

function TXMLPayroll.Get_IncomeTaxAndRemuneration: IXMLIncomeTaxAndRemuneration;
begin
  Result := ChildNodes['IncomeTaxAndRemuneration'] as IXMLIncomeTaxAndRemuneration;
end;

{ TXMLIncomeTaxAndRemuneration }

function TXMLIncomeTaxAndRemuneration.Get_PayAsYouGoWithholdingTaxWithheldA: UnicodeString;
begin
  Result := ChildNodes['PayAsYouGoWithholdingTaxWithheldA'].Text;
end;

procedure TXMLIncomeTaxAndRemuneration.Set_PayAsYouGoWithholdingTaxWithheldA(Value: UnicodeString);
begin
  ChildNodes['PayAsYouGoWithholdingTaxWithheldA'].NodeValue := Value;
end;

function TXMLIncomeTaxAndRemuneration.Get_TotalGrossPaymentsWithholdingA: UnicodeString;
begin
  Result := ChildNodes['TotalGrossPaymentsWithholdingA'].Text;
end;

procedure TXMLIncomeTaxAndRemuneration.Set_TotalGrossPaymentsWithholdingA(Value: UnicodeString);
begin
  ChildNodes['TotalGrossPaymentsWithholdingA'].NodeValue := Value;
end;

{ TXMLDeclaration }

function TXMLDeclaration.Get_SignatoryIdentifierT: UnicodeString;
begin
  Result := ChildNodes['SignatoryIdentifierT'].Text;
end;

procedure TXMLDeclaration.Set_SignatoryIdentifierT(Value: UnicodeString);
begin
  ChildNodes['SignatoryIdentifierT'].NodeValue := Value;
end;

function TXMLDeclaration.Get_SignatureD: UnicodeString;
begin
  Result := ChildNodes['SignatureD'].Text;
end;

procedure TXMLDeclaration.Set_SignatureD(Value: UnicodeString);
begin
  ChildNodes['SignatureD'].NodeValue := Value;
end;

function TXMLDeclaration.Get_StatementAcceptedI: Boolean;
begin
  Result := ChildNodes['StatementAcceptedI'].NodeValue;
end;

procedure TXMLDeclaration.Set_StatementAcceptedI(Value: Boolean);
begin
  ChildNodes['StatementAcceptedI'].NodeValue := Value;
end;

{ TXMLInt }

procedure TXMLInt.AfterConstruction;
begin
  RegisterChildNode('ElectronicContact', TXMLElectronicContact);
  RegisterChildNode('Declaration', TXMLDeclaration);
  inherited;
end;

function TXMLInt.Get_AustralianBusinessNumberId: UnicodeString;
begin
  Result := ChildNodes['AustralianBusinessNumberId'].Text;
end;

procedure TXMLInt.Set_AustralianBusinessNumberId(Value: UnicodeString);
begin
  ChildNodes['AustralianBusinessNumberId'].NodeValue := Value;
end;

function TXMLInt.Get_TaxAgentNumberId: UnicodeString;
begin
  Result := ChildNodes['TaxAgentNumberId'].Text;
end;

procedure TXMLInt.Set_TaxAgentNumberId(Value: UnicodeString);
begin
  ChildNodes['TaxAgentNumberId'].NodeValue := Value;
end;

function TXMLInt.Get_PersonUnstructuredNameFullNameT: UnicodeString;
begin
  Result := ChildNodes['PersonUnstructuredNameFullNameT'].Text;
end;

procedure TXMLInt.Set_PersonUnstructuredNameFullNameT(Value: UnicodeString);
begin
  ChildNodes['PersonUnstructuredNameFullNameT'].NodeValue := Value;
end;

function TXMLInt.Get_ElectronicContact: IXMLElectronicContact;
begin
  Result := ChildNodes['ElectronicContact'] as IXMLElectronicContact;
end;

function TXMLInt.Get_Declaration: IXMLDeclaration;
begin
  Result := ChildNodes['Declaration'] as IXMLDeclaration;
end;

end.