
{**************************************************************************************************************************************************}
{                                                                                                                                                  }
{                                                                 XML Data Binding                                                                 }
{                                                                                                                                                  }
{         Generated on: 20/12/2021 1:11:23 PM                                                                                                      }
{       Generated from: C:\Dev\ERP\Dev\Aus_Gov\SBR\ATO_PAYEVNT.0004_2020_Package_v1.2\ATO PAYEVNT 2020 Contracts\ato.payevnt.0004.2020.01.01.xsd   }
{   Settings stored in: C:\Dev\ERP\Dev\Aus_Gov\SBR\ATO_PAYEVNT.0004_2020_Package_v1.2\ATO PAYEVNT 2020 Contracts\ato.payevnt.0004.2020.01.01.xdb   }
{                                                                                                                                                  }
{**************************************************************************************************************************************************}

unit atopayevnt000420200101;

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
    ['{8E81ED48-99BA-41E6-9922-12FD90E01392}']
    { Property Accessors }
    function Get_Rp: IXMLRp;
    function Get_Int: IXMLInt;
    { Methods & Properties }
    property Rp: IXMLRp read Get_Rp;
    property Int: IXMLInt read Get_Int;
  end;

{ IXMLRp }

  IXMLRp = interface(IXMLNode)
    ['{7E21F744-DCC3-4402-B7F9-6D1FED30678D}']
    { Property Accessors }
    function Get_SoftwareInformationBusinessManagementSystemId: UnicodeString;
    function Get_AustralianBusinessNumberId: UnicodeString;
    function Get_WithholdingPayerNumberId: UnicodeString;
    function Get_OrganisationDetailsOrganisationBranchC: UnicodeString;
    function Get_PreviousSoftwareInformationBusinessManagementSystemId: UnicodeString;
    function Get_OrganisationName: IXMLOrganisationName;
    function Get_ElectronicContact: IXMLElectronicContact;
    function Get_AddressDetailsPostal: IXMLAddressDetailsPostal;
    function Get_Payroll: IXMLPayroll;
    function Get_Declaration: IXMLDeclaration;
    procedure Set_SoftwareInformationBusinessManagementSystemId(Value: UnicodeString);
    procedure Set_AustralianBusinessNumberId(Value: UnicodeString);
    procedure Set_WithholdingPayerNumberId(Value: UnicodeString);
    procedure Set_OrganisationDetailsOrganisationBranchC(Value: UnicodeString);
    procedure Set_PreviousSoftwareInformationBusinessManagementSystemId(Value: UnicodeString);
    { Methods & Properties }
    property SoftwareInformationBusinessManagementSystemId: UnicodeString read Get_SoftwareInformationBusinessManagementSystemId write Set_SoftwareInformationBusinessManagementSystemId;
    property AustralianBusinessNumberId: UnicodeString read Get_AustralianBusinessNumberId write Set_AustralianBusinessNumberId;
    property WithholdingPayerNumberId: UnicodeString read Get_WithholdingPayerNumberId write Set_WithholdingPayerNumberId;
    property OrganisationDetailsOrganisationBranchC: UnicodeString read Get_OrganisationDetailsOrganisationBranchC write Set_OrganisationDetailsOrganisationBranchC;
    property PreviousSoftwareInformationBusinessManagementSystemId: UnicodeString read Get_PreviousSoftwareInformationBusinessManagementSystemId write Set_PreviousSoftwareInformationBusinessManagementSystemId;
    property OrganisationName: IXMLOrganisationName read Get_OrganisationName;
    property ElectronicContact: IXMLElectronicContact read Get_ElectronicContact;
    property AddressDetailsPostal: IXMLAddressDetailsPostal read Get_AddressDetailsPostal;
    property Payroll: IXMLPayroll read Get_Payroll;
    property Declaration: IXMLDeclaration read Get_Declaration;
  end;

{ IXMLOrganisationName }

  IXMLOrganisationName = interface(IXMLNode)
    ['{5F67C79E-97AD-4CFD-8B96-C10E79416FAE}']
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
    ['{DFE9562C-A890-4336-A614-CF606C01F176}']
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
    ['{75F31C3E-0441-4090-A42A-11BA76DC1CF0}']
    { Property Accessors }
    function Get_PostcodeT: UnicodeString;
    function Get_CountryC: UnicodeString;
    procedure Set_PostcodeT(Value: UnicodeString);
    procedure Set_CountryC(Value: UnicodeString);
    { Methods & Properties }
    property PostcodeT: UnicodeString read Get_PostcodeT write Set_PostcodeT;
    property CountryC: UnicodeString read Get_CountryC write Set_CountryC;
  end;

{ IXMLPayroll }

  IXMLPayroll = interface(IXMLNode)
    ['{9EBE5FE2-AC59-41C7-BC26-DB979D6DF4B2}']
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
    ['{3EED0930-E51D-4D38-8260-18CE35BB0A28}']
    { Property Accessors }
    function Get_PayAsYouGoWithholdingTaxWithheldA: UnicodeString;
    function Get_TotalGrossPaymentsWithholdingA: UnicodeString;
    function Get_ChildSupportGarnisheeA: UnicodeString;
    function Get_ChildSupportWithholdingA: UnicodeString;
    procedure Set_PayAsYouGoWithholdingTaxWithheldA(Value: UnicodeString);
    procedure Set_TotalGrossPaymentsWithholdingA(Value: UnicodeString);
    procedure Set_ChildSupportGarnisheeA(Value: UnicodeString);
    procedure Set_ChildSupportWithholdingA(Value: UnicodeString);
    { Methods & Properties }
    property PayAsYouGoWithholdingTaxWithheldA: UnicodeString read Get_PayAsYouGoWithholdingTaxWithheldA write Set_PayAsYouGoWithholdingTaxWithheldA;
    property TotalGrossPaymentsWithholdingA: UnicodeString read Get_TotalGrossPaymentsWithholdingA write Set_TotalGrossPaymentsWithholdingA;
    property ChildSupportGarnisheeA: UnicodeString read Get_ChildSupportGarnisheeA write Set_ChildSupportGarnisheeA;
    property ChildSupportWithholdingA: UnicodeString read Get_ChildSupportWithholdingA write Set_ChildSupportWithholdingA;
  end;

{ IXMLDeclaration }

  IXMLDeclaration = interface(IXMLNode)
    ['{63150947-725F-4F71-A177-723118FCC020}']
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
    ['{3E9A2B00-CF4F-48DB-ACF0-9A6B169CB0B5}']
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
    function Get_PreviousSoftwareInformationBusinessManagementSystemId: UnicodeString;
    function Get_OrganisationName: IXMLOrganisationName;
    function Get_ElectronicContact: IXMLElectronicContact;
    function Get_AddressDetailsPostal: IXMLAddressDetailsPostal;
    function Get_Payroll: IXMLPayroll;
    function Get_Declaration: IXMLDeclaration;
    procedure Set_SoftwareInformationBusinessManagementSystemId(Value: UnicodeString);
    procedure Set_AustralianBusinessNumberId(Value: UnicodeString);
    procedure Set_WithholdingPayerNumberId(Value: UnicodeString);
    procedure Set_OrganisationDetailsOrganisationBranchC(Value: UnicodeString);
    procedure Set_PreviousSoftwareInformationBusinessManagementSystemId(Value: UnicodeString);
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
    function Get_PostcodeT: UnicodeString;
    function Get_CountryC: UnicodeString;
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
    function Get_ChildSupportGarnisheeA: UnicodeString;
    function Get_ChildSupportWithholdingA: UnicodeString;
    procedure Set_PayAsYouGoWithholdingTaxWithheldA(Value: UnicodeString);
    procedure Set_TotalGrossPaymentsWithholdingA(Value: UnicodeString);
    procedure Set_ChildSupportGarnisheeA(Value: UnicodeString);
    procedure Set_ChildSupportWithholdingA(Value: UnicodeString);
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

function TXMLRp.Get_PreviousSoftwareInformationBusinessManagementSystemId: UnicodeString;
begin
  Result := ChildNodes['PreviousSoftwareInformationBusinessManagementSystemId'].Text;
end;

procedure TXMLRp.Set_PreviousSoftwareInformationBusinessManagementSystemId(Value: UnicodeString);
begin
  ChildNodes['PreviousSoftwareInformationBusinessManagementSystemId'].NodeValue := Value;
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

function TXMLIncomeTaxAndRemuneration.Get_ChildSupportGarnisheeA: UnicodeString;
begin
  Result := ChildNodes['ChildSupportGarnisheeA'].Text;
end;

procedure TXMLIncomeTaxAndRemuneration.Set_ChildSupportGarnisheeA(Value: UnicodeString);
begin
  ChildNodes['ChildSupportGarnisheeA'].NodeValue := Value;
end;

function TXMLIncomeTaxAndRemuneration.Get_ChildSupportWithholdingA: UnicodeString;
begin
  Result := ChildNodes['ChildSupportWithholdingA'].Text;
end;

procedure TXMLIncomeTaxAndRemuneration.Set_ChildSupportWithholdingA(Value: UnicodeString);
begin
  ChildNodes['ChildSupportWithholdingA'].NodeValue := Value;
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