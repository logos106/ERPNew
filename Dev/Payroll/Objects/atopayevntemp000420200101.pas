
{*****************************************************************************************************************************************************}
{                                                                                                                                                     }
{                                                                  XML Data Binding                                                                   }
{                                                                                                                                                     }
{         Generated on: 20/12/2021 1:13:27 PM                                                                                                         }
{       Generated from: C:\Dev\ERP\Dev\Aus_Gov\SBR\ATO_PAYEVNT.0004_2020_Package_v1.2\ATO PAYEVNT 2020 Contracts\ato.payevntemp.0004.2020.01.01.xsd   }
{   Settings stored in: C:\Dev\ERP\Dev\Aus_Gov\SBR\ATO_PAYEVNT.0004_2020_Package_v1.2\ATO PAYEVNT 2020 Contracts\ato.payevntemp.0004.2020.01.01.xdb   }
{                                                                                                                                                     }
{*****************************************************************************************************************************************************}

unit atopayevntemp000420200101;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLPAYEVNTEMP = interface;
  IXMLPayee = interface;
  IXMLIdentifiers = interface;
  IXMLPersonNameDetails = interface;
  IXMLPersonDemographicDetailsBirth = interface;
  IXMLAddressDetails = interface;
  IXMLElectronicContact = interface;
  IXMLEmployerConditions = interface;
  IXMLPayrollPeriod = interface;
  IXMLRemunerationCollection = interface;
  IXMLRemuneration = interface;
  IXMLPaidLeaveCollection = interface;
  IXMLPaidLeave = interface;
  IXMLAllowanceCollection = interface;
  IXMLAllowance = interface;
  IXMLSalarySacrificeCollection = interface;
  IXMLSalarySacrifice = interface;
  IXMLLumpSumCollection = interface;
  IXMLLumpSum = interface;
  IXMLEmploymentTerminationPaymentCollection = interface;
  IXMLEmploymentTerminationPayment = interface;
  IXMLDeductionCollection = interface;
  IXMLDeduction = interface;
  IXMLSuperannuationContributionCollection = interface;
  IXMLSuperannuationContribution = interface;
  IXMLIncomeFringeBenefitsReportableCollection = interface;
  IXMLIncomeFringeBenefitsReportable = interface;

{ IXMLPAYEVNTEMP }

  IXMLPAYEVNTEMP = interface(IXMLNode)
    ['{DB75C42D-3E5E-48CD-B0E6-9C81A869734F}']
    { Property Accessors }
    function Get_Payee: IXMLPayee;
    { Methods & Properties }
    property Payee: IXMLPayee read Get_Payee;
  end;

{ IXMLPayee }

  IXMLPayee = interface(IXMLNode)
    ['{F4339815-129E-41C9-8CF8-CE5A05949419}']
    { Property Accessors }
    function Get_Identifiers: IXMLIdentifiers;
    function Get_PersonNameDetails: IXMLPersonNameDetails;
    function Get_PersonDemographicDetailsBirth: IXMLPersonDemographicDetailsBirth;
    function Get_AddressDetails: IXMLAddressDetails;
    function Get_ElectronicContact: IXMLElectronicContact;
    function Get_EmployerConditions: IXMLEmployerConditions;
    function Get_PayrollPeriod: IXMLPayrollPeriod;
    { Methods & Properties }
    property Identifiers: IXMLIdentifiers read Get_Identifiers;
    property PersonNameDetails: IXMLPersonNameDetails read Get_PersonNameDetails;
    property PersonDemographicDetailsBirth: IXMLPersonDemographicDetailsBirth read Get_PersonDemographicDetailsBirth;
    property AddressDetails: IXMLAddressDetails read Get_AddressDetails;
    property ElectronicContact: IXMLElectronicContact read Get_ElectronicContact;
    property EmployerConditions: IXMLEmployerConditions read Get_EmployerConditions;
    property PayrollPeriod: IXMLPayrollPeriod read Get_PayrollPeriod;
  end;

{ IXMLIdentifiers }

  IXMLIdentifiers = interface(IXMLNode)
    ['{9C21CC35-336D-4044-AF4D-621FFC64AB23}']
    { Property Accessors }
    function Get_TaxFileNumberId: UnicodeString;
    function Get_AustralianBusinessNumberId: UnicodeString;
    function Get_EmploymentPayrollNumberId: UnicodeString;
    function Get_PreviousPayrollIDEmploymentPayrollNumberId: UnicodeString;
    procedure Set_TaxFileNumberId(Value: UnicodeString);
    procedure Set_AustralianBusinessNumberId(Value: UnicodeString);
    procedure Set_EmploymentPayrollNumberId(Value: UnicodeString);
    procedure Set_PreviousPayrollIDEmploymentPayrollNumberId(Value: UnicodeString);
    { Methods & Properties }
    property TaxFileNumberId: UnicodeString read Get_TaxFileNumberId write Set_TaxFileNumberId;
    property AustralianBusinessNumberId: UnicodeString read Get_AustralianBusinessNumberId write Set_AustralianBusinessNumberId;
    property EmploymentPayrollNumberId: UnicodeString read Get_EmploymentPayrollNumberId write Set_EmploymentPayrollNumberId;
    property PreviousPayrollIDEmploymentPayrollNumberId: UnicodeString read Get_PreviousPayrollIDEmploymentPayrollNumberId write Set_PreviousPayrollIDEmploymentPayrollNumberId;
  end;

{ IXMLPersonNameDetails }

  IXMLPersonNameDetails = interface(IXMLNode)
    ['{7C8ADB56-214F-49F2-B8F0-A2B07B502175}']
    { Property Accessors }
    function Get_FamilyNameT: UnicodeString;
    function Get_GivenNameT: UnicodeString;
    function Get_OtherGivenNameT: UnicodeString;
    procedure Set_FamilyNameT(Value: UnicodeString);
    procedure Set_GivenNameT(Value: UnicodeString);
    procedure Set_OtherGivenNameT(Value: UnicodeString);
    { Methods & Properties }
    property FamilyNameT: UnicodeString read Get_FamilyNameT write Set_FamilyNameT;
    property GivenNameT: UnicodeString read Get_GivenNameT write Set_GivenNameT;
    property OtherGivenNameT: UnicodeString read Get_OtherGivenNameT write Set_OtherGivenNameT;
  end;

{ IXMLPersonDemographicDetailsBirth }

  IXMLPersonDemographicDetailsBirth = interface(IXMLNode)
    ['{72BAB324-5C9F-4EA1-A889-62FBDEB9E6AF}']
    { Property Accessors }
    function Get_Dm: Integer;
    function Get_M: Integer;
    function Get_Y: Integer;
    procedure Set_Dm(Value: Integer);
    procedure Set_M(Value: Integer);
    procedure Set_Y(Value: Integer);
    { Methods & Properties }
    property Dm: Integer read Get_Dm write Set_Dm;
    property M: Integer read Get_M write Set_M;
    property Y: Integer read Get_Y write Set_Y;
  end;

{ IXMLAddressDetails }

  IXMLAddressDetails = interface(IXMLNode)
    ['{C0AE75D0-3EF7-44B5-A54C-818C05825C1B}']
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

{ IXMLElectronicContact }

  IXMLElectronicContact = interface(IXMLNode)
    ['{6D3334CC-1638-40D8-96E8-1F9A9DB3F09C}']
    { Property Accessors }
    function Get_ElectronicMailAddressT: UnicodeString;
    function Get_TelephoneMinimalN: UnicodeString;
    procedure Set_ElectronicMailAddressT(Value: UnicodeString);
    procedure Set_TelephoneMinimalN(Value: UnicodeString);
    { Methods & Properties }
    property ElectronicMailAddressT: UnicodeString read Get_ElectronicMailAddressT write Set_ElectronicMailAddressT;
    property TelephoneMinimalN: UnicodeString read Get_TelephoneMinimalN write Set_TelephoneMinimalN;
  end;

{ IXMLEmployerConditions }

  IXMLEmployerConditions = interface(IXMLNode)
    ['{B8D1EB9B-AE59-4C3E-9B3F-9AE598D84E08}']
    { Property Accessors }
    function Get_EmploymentStartD: UnicodeString;
    function Get_EmploymentEndD: UnicodeString;
    function Get_PaymentBasisC: UnicodeString;
    function Get_CessationTypeC: UnicodeString;
    function Get_TaxTreatmentC: UnicodeString;
    function Get_TaxOffsetClaimTotalA: UnicodeString;
    procedure Set_EmploymentStartD(Value: UnicodeString);
    procedure Set_EmploymentEndD(Value: UnicodeString);
    procedure Set_PaymentBasisC(Value: UnicodeString);
    procedure Set_CessationTypeC(Value: UnicodeString);
    procedure Set_TaxTreatmentC(Value: UnicodeString);
    procedure Set_TaxOffsetClaimTotalA(Value: UnicodeString);
    { Methods & Properties }
    property EmploymentStartD: UnicodeString read Get_EmploymentStartD write Set_EmploymentStartD;
    property EmploymentEndD: UnicodeString read Get_EmploymentEndD write Set_EmploymentEndD;
    property PaymentBasisC: UnicodeString read Get_PaymentBasisC write Set_PaymentBasisC;
    property CessationTypeC: UnicodeString read Get_CessationTypeC write Set_CessationTypeC;
    property TaxTreatmentC: UnicodeString read Get_TaxTreatmentC write Set_TaxTreatmentC;
    property TaxOffsetClaimTotalA: UnicodeString read Get_TaxOffsetClaimTotalA write Set_TaxOffsetClaimTotalA;
  end;

{ IXMLPayrollPeriod }

  IXMLPayrollPeriod = interface(IXMLNode)
    ['{F063E848-BE85-4E14-963C-D428071E6C18}']
    { Property Accessors }
    function Get_StartD: UnicodeString;
    function Get_EndD: UnicodeString;
    function Get_RemunerationPayrollEventFinalI: Boolean;
    function Get_RemunerationCollection: IXMLRemunerationCollection;
    function Get_DeductionCollection: IXMLDeductionCollection;
    function Get_SuperannuationContributionCollection: IXMLSuperannuationContributionCollection;
    function Get_IncomeFringeBenefitsReportableCollection: IXMLIncomeFringeBenefitsReportableCollection;
    procedure Set_StartD(Value: UnicodeString);
    procedure Set_EndD(Value: UnicodeString);
    procedure Set_RemunerationPayrollEventFinalI(Value: Boolean);
    { Methods & Properties }
    property StartD: UnicodeString read Get_StartD write Set_StartD;
    property EndD: UnicodeString read Get_EndD write Set_EndD;
    property RemunerationPayrollEventFinalI: Boolean read Get_RemunerationPayrollEventFinalI write Set_RemunerationPayrollEventFinalI;
    property RemunerationCollection: IXMLRemunerationCollection read Get_RemunerationCollection;
    property DeductionCollection: IXMLDeductionCollection read Get_DeductionCollection;
    property SuperannuationContributionCollection: IXMLSuperannuationContributionCollection read Get_SuperannuationContributionCollection;
    property IncomeFringeBenefitsReportableCollection: IXMLIncomeFringeBenefitsReportableCollection read Get_IncomeFringeBenefitsReportableCollection;
  end;

{ IXMLRemunerationCollection }

  IXMLRemunerationCollection = interface(IXMLNodeCollection)
    ['{8E7FB3C5-2F8D-4D3D-9CFE-B7CFA89169C7}']
    { Property Accessors }
    function Get_Remuneration(Index: Integer): IXMLRemuneration;
    { Methods & Properties }
    function Add: IXMLRemuneration;
    function Insert(const Index: Integer): IXMLRemuneration;
    property Remuneration[Index: Integer]: IXMLRemuneration read Get_Remuneration; default;
  end;

{ IXMLRemuneration }

  IXMLRemuneration = interface(IXMLNode)
    ['{34FE77AC-5E31-4741-BB29-F791F7B9DFE0}']
    { Property Accessors }
    function Get_IncomeStreamTypeC: UnicodeString;
    function Get_AddressDetailsCountryC: UnicodeString;
    function Get_IncomeTaxPayAsYouGoWithholdingTaxWithheldA: UnicodeString;
    function Get_IncomeTaxForeignWithholdingA: UnicodeString;
    function Get_IndividualNonBusinessExemptForeignEmploymentIncomeA: UnicodeString;
    function Get_GrossA: UnicodeString;
    function Get_PaidLeaveCollection: IXMLPaidLeaveCollection;
    function Get_AllowanceCollection: IXMLAllowanceCollection;
    function Get_OvertimePaymentA: UnicodeString;
    function Get_GrossBonusesAndCommissionsA: UnicodeString;
    function Get_GrossDirectorsFeesA: UnicodeString;
    function Get_IndividualNonBusinessCommunityDevelopmentEmploymentProjectA: UnicodeString;
    function Get_SalarySacrificeCollection: IXMLSalarySacrificeCollection;
    function Get_LumpSumCollection: IXMLLumpSumCollection;
    function Get_EmploymentTerminationPaymentCollection: IXMLEmploymentTerminationPaymentCollection;
    procedure Set_IncomeStreamTypeC(Value: UnicodeString);
    procedure Set_AddressDetailsCountryC(Value: UnicodeString);
    procedure Set_IncomeTaxPayAsYouGoWithholdingTaxWithheldA(Value: UnicodeString);
    procedure Set_IncomeTaxForeignWithholdingA(Value: UnicodeString);
    procedure Set_IndividualNonBusinessExemptForeignEmploymentIncomeA(Value: UnicodeString);
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_OvertimePaymentA(Value: UnicodeString);
    procedure Set_GrossBonusesAndCommissionsA(Value: UnicodeString);
    procedure Set_GrossDirectorsFeesA(Value: UnicodeString);
    procedure Set_IndividualNonBusinessCommunityDevelopmentEmploymentProjectA(Value: UnicodeString);
    { Methods & Properties }
    property IncomeStreamTypeC: UnicodeString read Get_IncomeStreamTypeC write Set_IncomeStreamTypeC;
    property AddressDetailsCountryC: UnicodeString read Get_AddressDetailsCountryC write Set_AddressDetailsCountryC;
    property IncomeTaxPayAsYouGoWithholdingTaxWithheldA: UnicodeString read Get_IncomeTaxPayAsYouGoWithholdingTaxWithheldA write Set_IncomeTaxPayAsYouGoWithholdingTaxWithheldA;
    property IncomeTaxForeignWithholdingA: UnicodeString read Get_IncomeTaxForeignWithholdingA write Set_IncomeTaxForeignWithholdingA;
    property IndividualNonBusinessExemptForeignEmploymentIncomeA: UnicodeString read Get_IndividualNonBusinessExemptForeignEmploymentIncomeA write Set_IndividualNonBusinessExemptForeignEmploymentIncomeA;
    property GrossA: UnicodeString read Get_GrossA write Set_GrossA;
    property PaidLeaveCollection: IXMLPaidLeaveCollection read Get_PaidLeaveCollection;
    property AllowanceCollection: IXMLAllowanceCollection read Get_AllowanceCollection;
    property OvertimePaymentA: UnicodeString read Get_OvertimePaymentA write Set_OvertimePaymentA;
    property GrossBonusesAndCommissionsA: UnicodeString read Get_GrossBonusesAndCommissionsA write Set_GrossBonusesAndCommissionsA;
    property GrossDirectorsFeesA: UnicodeString read Get_GrossDirectorsFeesA write Set_GrossDirectorsFeesA;
    property IndividualNonBusinessCommunityDevelopmentEmploymentProjectA: UnicodeString read Get_IndividualNonBusinessCommunityDevelopmentEmploymentProjectA write Set_IndividualNonBusinessCommunityDevelopmentEmploymentProjectA;
    property SalarySacrificeCollection: IXMLSalarySacrificeCollection read Get_SalarySacrificeCollection;
    property LumpSumCollection: IXMLLumpSumCollection read Get_LumpSumCollection;
    property EmploymentTerminationPaymentCollection: IXMLEmploymentTerminationPaymentCollection read Get_EmploymentTerminationPaymentCollection;
  end;

{ IXMLPaidLeaveCollection }

  IXMLPaidLeaveCollection = interface(IXMLNodeCollection)
    ['{096C5DCF-BEAC-43C1-AFD7-1CE139978DC2}']
    { Property Accessors }
    function Get_PaidLeave(Index: Integer): IXMLPaidLeave;
    { Methods & Properties }
    function Add: IXMLPaidLeave;
    function Insert(const Index: Integer): IXMLPaidLeave;
    property PaidLeave[Index: Integer]: IXMLPaidLeave read Get_PaidLeave; default;
  end;

{ IXMLPaidLeave }

  IXMLPaidLeave = interface(IXMLNode)
    ['{A957C8DE-6674-4568-9B81-95C5DCD068BA}']
    { Property Accessors }
    function Get_TypeC: UnicodeString;
    function Get_PaymentA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_PaymentA(Value: UnicodeString);
    { Methods & Properties }
    property TypeC: UnicodeString read Get_TypeC write Set_TypeC;
    property PaymentA: UnicodeString read Get_PaymentA write Set_PaymentA;
  end;

{ IXMLAllowanceCollection }

  IXMLAllowanceCollection = interface(IXMLNodeCollection)
    ['{39B65B00-BC0D-47BE-A82A-042B2B33E7A5}']
    { Property Accessors }
    function Get_Allowance(Index: Integer): IXMLAllowance;
    { Methods & Properties }
    function Add: IXMLAllowance;
    function Insert(const Index: Integer): IXMLAllowance;
    property Allowance[Index: Integer]: IXMLAllowance read Get_Allowance; default;
  end;

{ IXMLAllowance }

  IXMLAllowance = interface(IXMLNode)
    ['{5ECDF6CB-955A-4C82-8B1E-6D4206BFAE93}']
    { Property Accessors }
    function Get_TypeC: UnicodeString;
    function Get_OtherAllowanceTypeDe: UnicodeString;
    function Get_EmploymentAllowancesA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_OtherAllowanceTypeDe(Value: UnicodeString);
    procedure Set_EmploymentAllowancesA(Value: UnicodeString);
    { Methods & Properties }
    property TypeC: UnicodeString read Get_TypeC write Set_TypeC;
    property OtherAllowanceTypeDe: UnicodeString read Get_OtherAllowanceTypeDe write Set_OtherAllowanceTypeDe;
    property EmploymentAllowancesA: UnicodeString read Get_EmploymentAllowancesA write Set_EmploymentAllowancesA;
  end;

{ IXMLSalarySacrificeCollection }

  IXMLSalarySacrificeCollection = interface(IXMLNodeCollection)
    ['{C860E93F-39DA-4086-8719-652354311FC3}']
    { Property Accessors }
    function Get_SalarySacrifice(Index: Integer): IXMLSalarySacrifice;
    { Methods & Properties }
    function Add: IXMLSalarySacrifice;
    function Insert(const Index: Integer): IXMLSalarySacrifice;
    property SalarySacrifice[Index: Integer]: IXMLSalarySacrifice read Get_SalarySacrifice; default;
  end;

{ IXMLSalarySacrifice }

  IXMLSalarySacrifice = interface(IXMLNode)
    ['{6BBADB1A-3DBD-4C96-8177-9F3AD50FA80A}']
    { Property Accessors }
    function Get_TypeC: UnicodeString;
    function Get_PaymentA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_PaymentA(Value: UnicodeString);
    { Methods & Properties }
    property TypeC: UnicodeString read Get_TypeC write Set_TypeC;
    property PaymentA: UnicodeString read Get_PaymentA write Set_PaymentA;
  end;

{ IXMLLumpSumCollection }

  IXMLLumpSumCollection = interface(IXMLNodeCollection)
    ['{BBC168F4-ACDF-4A05-9F3D-AA8A26BC8951}']
    { Property Accessors }
    function Get_LumpSum(Index: Integer): IXMLLumpSum;
    { Methods & Properties }
    function Add: IXMLLumpSum;
    function Insert(const Index: Integer): IXMLLumpSum;
    property LumpSum[Index: Integer]: IXMLLumpSum read Get_LumpSum; default;
  end;

{ IXMLLumpSum }

  IXMLLumpSum = interface(IXMLNode)
    ['{1E0B4D64-64A2-4C4E-9F98-72B151466AD6}']
    { Property Accessors }
    function Get_TypeC: UnicodeString;
    function Get_FinancialY: Integer;
    function Get_PaymentsA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_FinancialY(Value: Integer);
    procedure Set_PaymentsA(Value: UnicodeString);
    { Methods & Properties }
    property TypeC: UnicodeString read Get_TypeC write Set_TypeC;
    property FinancialY: Integer read Get_FinancialY write Set_FinancialY;
    property PaymentsA: UnicodeString read Get_PaymentsA write Set_PaymentsA;
  end;

{ IXMLEmploymentTerminationPaymentCollection }

  IXMLEmploymentTerminationPaymentCollection = interface(IXMLNodeCollection)
    ['{1D8596C7-7923-40B4-A9F1-2DBB3D1A5988}']
    { Property Accessors }
    function Get_EmploymentTerminationPayment(Index: Integer): IXMLEmploymentTerminationPayment;
    { Methods & Properties }
    function Add: IXMLEmploymentTerminationPayment;
    function Insert(const Index: Integer): IXMLEmploymentTerminationPayment;
    property EmploymentTerminationPayment[Index: Integer]: IXMLEmploymentTerminationPayment read Get_EmploymentTerminationPayment; default;
  end;

{ IXMLEmploymentTerminationPayment }

  IXMLEmploymentTerminationPayment = interface(IXMLNode)
    ['{BA562742-DCA0-4242-A047-EAD768D49235}']
    { Property Accessors }
    function Get_IncomeTaxPayAsYouGoWithholdingTypeC: UnicodeString;
    function Get_IncomeD: UnicodeString;
    function Get_IncomeTaxFreeA: UnicodeString;
    function Get_IncomeTaxableA: UnicodeString;
    function Get_IncomePayAsYouGoWithholdingA: UnicodeString;
    procedure Set_IncomeTaxPayAsYouGoWithholdingTypeC(Value: UnicodeString);
    procedure Set_IncomeD(Value: UnicodeString);
    procedure Set_IncomeTaxFreeA(Value: UnicodeString);
    procedure Set_IncomeTaxableA(Value: UnicodeString);
    procedure Set_IncomePayAsYouGoWithholdingA(Value: UnicodeString);
    { Methods & Properties }
    property IncomeTaxPayAsYouGoWithholdingTypeC: UnicodeString read Get_IncomeTaxPayAsYouGoWithholdingTypeC write Set_IncomeTaxPayAsYouGoWithholdingTypeC;
    property IncomeD: UnicodeString read Get_IncomeD write Set_IncomeD;
    property IncomeTaxFreeA: UnicodeString read Get_IncomeTaxFreeA write Set_IncomeTaxFreeA;
    property IncomeTaxableA: UnicodeString read Get_IncomeTaxableA write Set_IncomeTaxableA;
    property IncomePayAsYouGoWithholdingA: UnicodeString read Get_IncomePayAsYouGoWithholdingA write Set_IncomePayAsYouGoWithholdingA;
  end;

{ IXMLDeductionCollection }

  IXMLDeductionCollection = interface(IXMLNodeCollection)
    ['{5024D847-D4B0-4BF5-90D5-493D416CE591}']
    { Property Accessors }
    function Get_Deduction(Index: Integer): IXMLDeduction;
    { Methods & Properties }
    function Add: IXMLDeduction;
    function Insert(const Index: Integer): IXMLDeduction;
    property Deduction[Index: Integer]: IXMLDeduction read Get_Deduction; default;
  end;

{ IXMLDeduction }

  IXMLDeduction = interface(IXMLNode)
    ['{5D82A0FA-CDD1-4A06-B4EC-A9FD6CB7D32A}']
    { Property Accessors }
    function Get_RemunerationTypeC: UnicodeString;
    function Get_RemunerationA: UnicodeString;
    procedure Set_RemunerationTypeC(Value: UnicodeString);
    procedure Set_RemunerationA(Value: UnicodeString);
    { Methods & Properties }
    property RemunerationTypeC: UnicodeString read Get_RemunerationTypeC write Set_RemunerationTypeC;
    property RemunerationA: UnicodeString read Get_RemunerationA write Set_RemunerationA;
  end;

{ IXMLSuperannuationContributionCollection }

  IXMLSuperannuationContributionCollection = interface(IXMLNodeCollection)
    ['{FCDF9DC1-B46D-4A91-99DD-7442E1AAB78F}']
    { Property Accessors }
    function Get_SuperannuationContribution(Index: Integer): IXMLSuperannuationContribution;
    { Methods & Properties }
    function Add: IXMLSuperannuationContribution;
    function Insert(const Index: Integer): IXMLSuperannuationContribution;
    property SuperannuationContribution[Index: Integer]: IXMLSuperannuationContribution read Get_SuperannuationContribution; default;
  end;

{ IXMLSuperannuationContribution }

  IXMLSuperannuationContribution = interface(IXMLNode)
    ['{A27E0FF0-4DCA-4016-9EBE-F6FEA1669144}']
    { Property Accessors }
    function Get_EntitlementTypeC: UnicodeString;
    function Get_EmployerContributionsYearToDateA: UnicodeString;
    procedure Set_EntitlementTypeC(Value: UnicodeString);
    procedure Set_EmployerContributionsYearToDateA(Value: UnicodeString);
    { Methods & Properties }
    property EntitlementTypeC: UnicodeString read Get_EntitlementTypeC write Set_EntitlementTypeC;
    property EmployerContributionsYearToDateA: UnicodeString read Get_EmployerContributionsYearToDateA write Set_EmployerContributionsYearToDateA;
  end;

{ IXMLIncomeFringeBenefitsReportableCollection }

  IXMLIncomeFringeBenefitsReportableCollection = interface(IXMLNodeCollection)
    ['{FE08F703-41E9-42C5-B12C-F1F67F5A97DF}']
    { Property Accessors }
    function Get_IncomeFringeBenefitsReportable(Index: Integer): IXMLIncomeFringeBenefitsReportable;
    { Methods & Properties }
    function Add: IXMLIncomeFringeBenefitsReportable;
    function Insert(const Index: Integer): IXMLIncomeFringeBenefitsReportable;
    property IncomeFringeBenefitsReportable[Index: Integer]: IXMLIncomeFringeBenefitsReportable read Get_IncomeFringeBenefitsReportable; default;
  end;

{ IXMLIncomeFringeBenefitsReportable }

  IXMLIncomeFringeBenefitsReportable = interface(IXMLNode)
    ['{52557B35-846C-4433-9969-C6FB2AE89E11}']
    { Property Accessors }
    function Get_FringeBenefitsReportableExemptionC: UnicodeString;
    function Get_A: UnicodeString;
    procedure Set_FringeBenefitsReportableExemptionC(Value: UnicodeString);
    procedure Set_A(Value: UnicodeString);
    { Methods & Properties }
    property FringeBenefitsReportableExemptionC: UnicodeString read Get_FringeBenefitsReportableExemptionC write Set_FringeBenefitsReportableExemptionC;
    property A: UnicodeString read Get_A write Set_A;
  end;

{ Forward Decls }

  TXMLPAYEVNTEMP = class;
  TXMLPayee = class;
  TXMLIdentifiers = class;
  TXMLPersonNameDetails = class;
  TXMLPersonDemographicDetailsBirth = class;
  TXMLAddressDetails = class;
  TXMLElectronicContact = class;
  TXMLEmployerConditions = class;
  TXMLPayrollPeriod = class;
  TXMLRemunerationCollection = class;
  TXMLRemuneration = class;
  TXMLPaidLeaveCollection = class;
  TXMLPaidLeave = class;
  TXMLAllowanceCollection = class;
  TXMLAllowance = class;
  TXMLSalarySacrificeCollection = class;
  TXMLSalarySacrifice = class;
  TXMLLumpSumCollection = class;
  TXMLLumpSum = class;
  TXMLEmploymentTerminationPaymentCollection = class;
  TXMLEmploymentTerminationPayment = class;
  TXMLDeductionCollection = class;
  TXMLDeduction = class;
  TXMLSuperannuationContributionCollection = class;
  TXMLSuperannuationContribution = class;
  TXMLIncomeFringeBenefitsReportableCollection = class;
  TXMLIncomeFringeBenefitsReportable = class;

{ TXMLPAYEVNTEMP }

  TXMLPAYEVNTEMP = class(TXMLNode, IXMLPAYEVNTEMP)
  protected
    { IXMLPAYEVNTEMP }
    function Get_Payee: IXMLPayee;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPayee }

  TXMLPayee = class(TXMLNode, IXMLPayee)
  protected
    { IXMLPayee }
    function Get_Identifiers: IXMLIdentifiers;
    function Get_PersonNameDetails: IXMLPersonNameDetails;
    function Get_PersonDemographicDetailsBirth: IXMLPersonDemographicDetailsBirth;
    function Get_AddressDetails: IXMLAddressDetails;
    function Get_ElectronicContact: IXMLElectronicContact;
    function Get_EmployerConditions: IXMLEmployerConditions;
    function Get_PayrollPeriod: IXMLPayrollPeriod;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIdentifiers }

  TXMLIdentifiers = class(TXMLNode, IXMLIdentifiers)
  protected
    { IXMLIdentifiers }
    function Get_TaxFileNumberId: UnicodeString;
    function Get_AustralianBusinessNumberId: UnicodeString;
    function Get_EmploymentPayrollNumberId: UnicodeString;
    function Get_PreviousPayrollIDEmploymentPayrollNumberId: UnicodeString;
    procedure Set_TaxFileNumberId(Value: UnicodeString);
    procedure Set_AustralianBusinessNumberId(Value: UnicodeString);
    procedure Set_EmploymentPayrollNumberId(Value: UnicodeString);
    procedure Set_PreviousPayrollIDEmploymentPayrollNumberId(Value: UnicodeString);
  end;

{ TXMLPersonNameDetails }

  TXMLPersonNameDetails = class(TXMLNode, IXMLPersonNameDetails)
  protected
    { IXMLPersonNameDetails }
    function Get_FamilyNameT: UnicodeString;
    function Get_GivenNameT: UnicodeString;
    function Get_OtherGivenNameT: UnicodeString;
    procedure Set_FamilyNameT(Value: UnicodeString);
    procedure Set_GivenNameT(Value: UnicodeString);
    procedure Set_OtherGivenNameT(Value: UnicodeString);
  end;

{ TXMLPersonDemographicDetailsBirth }

  TXMLPersonDemographicDetailsBirth = class(TXMLNode, IXMLPersonDemographicDetailsBirth)
  protected
    { IXMLPersonDemographicDetailsBirth }
    function Get_Dm: Integer;
    function Get_M: Integer;
    function Get_Y: Integer;
    procedure Set_Dm(Value: Integer);
    procedure Set_M(Value: Integer);
    procedure Set_Y(Value: Integer);
  end;

{ TXMLAddressDetails }

  TXMLAddressDetails = class(TXMLNode, IXMLAddressDetails)
  protected
    { IXMLAddressDetails }
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

{ TXMLElectronicContact }

  TXMLElectronicContact = class(TXMLNode, IXMLElectronicContact)
  protected
    { IXMLElectronicContact }
    function Get_ElectronicMailAddressT: UnicodeString;
    function Get_TelephoneMinimalN: UnicodeString;
    procedure Set_ElectronicMailAddressT(Value: UnicodeString);
    procedure Set_TelephoneMinimalN(Value: UnicodeString);
  end;

{ TXMLEmployerConditions }

  TXMLEmployerConditions = class(TXMLNode, IXMLEmployerConditions)
  protected
    { IXMLEmployerConditions }
    function Get_EmploymentStartD: UnicodeString;
    function Get_EmploymentEndD: UnicodeString;
    function Get_PaymentBasisC: UnicodeString;
    function Get_CessationTypeC: UnicodeString;
    function Get_TaxTreatmentC: UnicodeString;
    function Get_TaxOffsetClaimTotalA: UnicodeString;
    procedure Set_EmploymentStartD(Value: UnicodeString);
    procedure Set_EmploymentEndD(Value: UnicodeString);
    procedure Set_PaymentBasisC(Value: UnicodeString);
    procedure Set_CessationTypeC(Value: UnicodeString);
    procedure Set_TaxTreatmentC(Value: UnicodeString);
    procedure Set_TaxOffsetClaimTotalA(Value: UnicodeString);
  end;

{ TXMLPayrollPeriod }

  TXMLPayrollPeriod = class(TXMLNode, IXMLPayrollPeriod)
  protected
    { IXMLPayrollPeriod }
    function Get_StartD: UnicodeString;
    function Get_EndD: UnicodeString;
    function Get_RemunerationPayrollEventFinalI: Boolean;
    function Get_RemunerationCollection: IXMLRemunerationCollection;
    function Get_DeductionCollection: IXMLDeductionCollection;
    function Get_SuperannuationContributionCollection: IXMLSuperannuationContributionCollection;
    function Get_IncomeFringeBenefitsReportableCollection: IXMLIncomeFringeBenefitsReportableCollection;
    procedure Set_StartD(Value: UnicodeString);
    procedure Set_EndD(Value: UnicodeString);
    procedure Set_RemunerationPayrollEventFinalI(Value: Boolean);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRemunerationCollection }

  TXMLRemunerationCollection = class(TXMLNodeCollection, IXMLRemunerationCollection)
  protected
    { IXMLRemunerationCollection }
    function Get_Remuneration(Index: Integer): IXMLRemuneration;
    function Add: IXMLRemuneration;
    function Insert(const Index: Integer): IXMLRemuneration;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLRemuneration }

  TXMLRemuneration = class(TXMLNode, IXMLRemuneration)
  protected
    { IXMLRemuneration }
    function Get_IncomeStreamTypeC: UnicodeString;
    function Get_AddressDetailsCountryC: UnicodeString;
    function Get_IncomeTaxPayAsYouGoWithholdingTaxWithheldA: UnicodeString;
    function Get_IncomeTaxForeignWithholdingA: UnicodeString;
    function Get_IndividualNonBusinessExemptForeignEmploymentIncomeA: UnicodeString;
    function Get_GrossA: UnicodeString;
    function Get_PaidLeaveCollection: IXMLPaidLeaveCollection;
    function Get_AllowanceCollection: IXMLAllowanceCollection;
    function Get_OvertimePaymentA: UnicodeString;
    function Get_GrossBonusesAndCommissionsA: UnicodeString;
    function Get_GrossDirectorsFeesA: UnicodeString;
    function Get_IndividualNonBusinessCommunityDevelopmentEmploymentProjectA: UnicodeString;
    function Get_SalarySacrificeCollection: IXMLSalarySacrificeCollection;
    function Get_LumpSumCollection: IXMLLumpSumCollection;
    function Get_EmploymentTerminationPaymentCollection: IXMLEmploymentTerminationPaymentCollection;
    procedure Set_IncomeStreamTypeC(Value: UnicodeString);
    procedure Set_AddressDetailsCountryC(Value: UnicodeString);
    procedure Set_IncomeTaxPayAsYouGoWithholdingTaxWithheldA(Value: UnicodeString);
    procedure Set_IncomeTaxForeignWithholdingA(Value: UnicodeString);
    procedure Set_IndividualNonBusinessExemptForeignEmploymentIncomeA(Value: UnicodeString);
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_OvertimePaymentA(Value: UnicodeString);
    procedure Set_GrossBonusesAndCommissionsA(Value: UnicodeString);
    procedure Set_GrossDirectorsFeesA(Value: UnicodeString);
    procedure Set_IndividualNonBusinessCommunityDevelopmentEmploymentProjectA(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPaidLeaveCollection }

  TXMLPaidLeaveCollection = class(TXMLNodeCollection, IXMLPaidLeaveCollection)
  protected
    { IXMLPaidLeaveCollection }
    function Get_PaidLeave(Index: Integer): IXMLPaidLeave;
    function Add: IXMLPaidLeave;
    function Insert(const Index: Integer): IXMLPaidLeave;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPaidLeave }

  TXMLPaidLeave = class(TXMLNode, IXMLPaidLeave)
  protected
    { IXMLPaidLeave }
    function Get_TypeC: UnicodeString;
    function Get_PaymentA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_PaymentA(Value: UnicodeString);
  end;

{ TXMLAllowanceCollection }

  TXMLAllowanceCollection = class(TXMLNodeCollection, IXMLAllowanceCollection)
  protected
    { IXMLAllowanceCollection }
    function Get_Allowance(Index: Integer): IXMLAllowance;
    function Add: IXMLAllowance;
    function Insert(const Index: Integer): IXMLAllowance;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLAllowance }

  TXMLAllowance = class(TXMLNode, IXMLAllowance)
  protected
    { IXMLAllowance }
    function Get_TypeC: UnicodeString;
    function Get_OtherAllowanceTypeDe: UnicodeString;
    function Get_EmploymentAllowancesA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_OtherAllowanceTypeDe(Value: UnicodeString);
    procedure Set_EmploymentAllowancesA(Value: UnicodeString);
  end;

{ TXMLSalarySacrificeCollection }

  TXMLSalarySacrificeCollection = class(TXMLNodeCollection, IXMLSalarySacrificeCollection)
  protected
    { IXMLSalarySacrificeCollection }
    function Get_SalarySacrifice(Index: Integer): IXMLSalarySacrifice;
    function Add: IXMLSalarySacrifice;
    function Insert(const Index: Integer): IXMLSalarySacrifice;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSalarySacrifice }

  TXMLSalarySacrifice = class(TXMLNode, IXMLSalarySacrifice)
  protected
    { IXMLSalarySacrifice }
    function Get_TypeC: UnicodeString;
    function Get_PaymentA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_PaymentA(Value: UnicodeString);
  end;

{ TXMLLumpSumCollection }

  TXMLLumpSumCollection = class(TXMLNodeCollection, IXMLLumpSumCollection)
  protected
    { IXMLLumpSumCollection }
    function Get_LumpSum(Index: Integer): IXMLLumpSum;
    function Add: IXMLLumpSum;
    function Insert(const Index: Integer): IXMLLumpSum;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLumpSum }

  TXMLLumpSum = class(TXMLNode, IXMLLumpSum)
  protected
    { IXMLLumpSum }
    function Get_TypeC: UnicodeString;
    function Get_FinancialY: Integer;
    function Get_PaymentsA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_FinancialY(Value: Integer);
    procedure Set_PaymentsA(Value: UnicodeString);
  end;

{ TXMLEmploymentTerminationPaymentCollection }

  TXMLEmploymentTerminationPaymentCollection = class(TXMLNodeCollection, IXMLEmploymentTerminationPaymentCollection)
  protected
    { IXMLEmploymentTerminationPaymentCollection }
    function Get_EmploymentTerminationPayment(Index: Integer): IXMLEmploymentTerminationPayment;
    function Add: IXMLEmploymentTerminationPayment;
    function Insert(const Index: Integer): IXMLEmploymentTerminationPayment;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLEmploymentTerminationPayment }

  TXMLEmploymentTerminationPayment = class(TXMLNode, IXMLEmploymentTerminationPayment)
  protected
    { IXMLEmploymentTerminationPayment }
    function Get_IncomeTaxPayAsYouGoWithholdingTypeC: UnicodeString;
    function Get_IncomeD: UnicodeString;
    function Get_IncomeTaxFreeA: UnicodeString;
    function Get_IncomeTaxableA: UnicodeString;
    function Get_IncomePayAsYouGoWithholdingA: UnicodeString;
    procedure Set_IncomeTaxPayAsYouGoWithholdingTypeC(Value: UnicodeString);
    procedure Set_IncomeD(Value: UnicodeString);
    procedure Set_IncomeTaxFreeA(Value: UnicodeString);
    procedure Set_IncomeTaxableA(Value: UnicodeString);
    procedure Set_IncomePayAsYouGoWithholdingA(Value: UnicodeString);
  end;

{ TXMLDeductionCollection }

  TXMLDeductionCollection = class(TXMLNodeCollection, IXMLDeductionCollection)
  protected
    { IXMLDeductionCollection }
    function Get_Deduction(Index: Integer): IXMLDeduction;
    function Add: IXMLDeduction;
    function Insert(const Index: Integer): IXMLDeduction;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDeduction }

  TXMLDeduction = class(TXMLNode, IXMLDeduction)
  protected
    { IXMLDeduction }
    function Get_RemunerationTypeC: UnicodeString;
    function Get_RemunerationA: UnicodeString;
    procedure Set_RemunerationTypeC(Value: UnicodeString);
    procedure Set_RemunerationA(Value: UnicodeString);
  end;

{ TXMLSuperannuationContributionCollection }

  TXMLSuperannuationContributionCollection = class(TXMLNodeCollection, IXMLSuperannuationContributionCollection)
  protected
    { IXMLSuperannuationContributionCollection }
    function Get_SuperannuationContribution(Index: Integer): IXMLSuperannuationContribution;
    function Add: IXMLSuperannuationContribution;
    function Insert(const Index: Integer): IXMLSuperannuationContribution;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSuperannuationContribution }

  TXMLSuperannuationContribution = class(TXMLNode, IXMLSuperannuationContribution)
  protected
    { IXMLSuperannuationContribution }
    function Get_EntitlementTypeC: UnicodeString;
    function Get_EmployerContributionsYearToDateA: UnicodeString;
    procedure Set_EntitlementTypeC(Value: UnicodeString);
    procedure Set_EmployerContributionsYearToDateA(Value: UnicodeString);
  end;

{ TXMLIncomeFringeBenefitsReportableCollection }

  TXMLIncomeFringeBenefitsReportableCollection = class(TXMLNodeCollection, IXMLIncomeFringeBenefitsReportableCollection)
  protected
    { IXMLIncomeFringeBenefitsReportableCollection }
    function Get_IncomeFringeBenefitsReportable(Index: Integer): IXMLIncomeFringeBenefitsReportable;
    function Add: IXMLIncomeFringeBenefitsReportable;
    function Insert(const Index: Integer): IXMLIncomeFringeBenefitsReportable;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIncomeFringeBenefitsReportable }

  TXMLIncomeFringeBenefitsReportable = class(TXMLNode, IXMLIncomeFringeBenefitsReportable)
  protected
    { IXMLIncomeFringeBenefitsReportable }
    function Get_FringeBenefitsReportableExemptionC: UnicodeString;
    function Get_A: UnicodeString;
    procedure Set_FringeBenefitsReportableExemptionC(Value: UnicodeString);
    procedure Set_A(Value: UnicodeString);
  end;

{ Global Functions }

function GetPAYEVNTEMP(Doc: IXMLDocument): IXMLPAYEVNTEMP;
function LoadPAYEVNTEMP(const FileName: string): IXMLPAYEVNTEMP;
function NewPAYEVNTEMP: IXMLPAYEVNTEMP;

const
  TargetNamespace = 'http://www.sbr.gov.au/ato/payevntemp';

implementation

{ Global Functions }

function GetPAYEVNTEMP(Doc: IXMLDocument): IXMLPAYEVNTEMP;
begin
  Result := Doc.GetDocBinding('PAYEVNTEMP', TXMLPAYEVNTEMP, TargetNamespace) as IXMLPAYEVNTEMP;
end;

function LoadPAYEVNTEMP(const FileName: string): IXMLPAYEVNTEMP;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('PAYEVNTEMP', TXMLPAYEVNTEMP, TargetNamespace) as IXMLPAYEVNTEMP;
end;

function NewPAYEVNTEMP: IXMLPAYEVNTEMP;
begin
  Result := NewXMLDocument.GetDocBinding('PAYEVNTEMP', TXMLPAYEVNTEMP, TargetNamespace) as IXMLPAYEVNTEMP;
end;

{ TXMLPAYEVNTEMP }

procedure TXMLPAYEVNTEMP.AfterConstruction;
begin
  RegisterChildNode('Payee', TXMLPayee);
  inherited;
end;

function TXMLPAYEVNTEMP.Get_Payee: IXMLPayee;
begin
  Result := ChildNodes['Payee'] as IXMLPayee;
end;

{ TXMLPayee }

procedure TXMLPayee.AfterConstruction;
begin
  RegisterChildNode('Identifiers', TXMLIdentifiers);
  RegisterChildNode('PersonNameDetails', TXMLPersonNameDetails);
  RegisterChildNode('PersonDemographicDetailsBirth', TXMLPersonDemographicDetailsBirth);
  RegisterChildNode('AddressDetails', TXMLAddressDetails);
  RegisterChildNode('ElectronicContact', TXMLElectronicContact);
  RegisterChildNode('EmployerConditions', TXMLEmployerConditions);
  RegisterChildNode('PayrollPeriod', TXMLPayrollPeriod);
  inherited;
end;

function TXMLPayee.Get_Identifiers: IXMLIdentifiers;
begin
  Result := ChildNodes['Identifiers'] as IXMLIdentifiers;
end;

function TXMLPayee.Get_PersonNameDetails: IXMLPersonNameDetails;
begin
  Result := ChildNodes['PersonNameDetails'] as IXMLPersonNameDetails;
end;

function TXMLPayee.Get_PersonDemographicDetailsBirth: IXMLPersonDemographicDetailsBirth;
begin
  Result := ChildNodes['PersonDemographicDetailsBirth'] as IXMLPersonDemographicDetailsBirth;
end;

function TXMLPayee.Get_AddressDetails: IXMLAddressDetails;
begin
  Result := ChildNodes['AddressDetails'] as IXMLAddressDetails;
end;

function TXMLPayee.Get_ElectronicContact: IXMLElectronicContact;
begin
  Result := ChildNodes['ElectronicContact'] as IXMLElectronicContact;
end;

function TXMLPayee.Get_EmployerConditions: IXMLEmployerConditions;
begin
  Result := ChildNodes['EmployerConditions'] as IXMLEmployerConditions;
end;

function TXMLPayee.Get_PayrollPeriod: IXMLPayrollPeriod;
begin
  Result := ChildNodes['PayrollPeriod'] as IXMLPayrollPeriod;
end;

{ TXMLIdentifiers }

function TXMLIdentifiers.Get_TaxFileNumberId: UnicodeString;
begin
  Result := ChildNodes['TaxFileNumberId'].Text;
end;

procedure TXMLIdentifiers.Set_TaxFileNumberId(Value: UnicodeString);
begin
  ChildNodes['TaxFileNumberId'].NodeValue := Value;
end;

function TXMLIdentifiers.Get_AustralianBusinessNumberId: UnicodeString;
begin
  Result := ChildNodes['AustralianBusinessNumberId'].Text;
end;

procedure TXMLIdentifiers.Set_AustralianBusinessNumberId(Value: UnicodeString);
begin
  ChildNodes['AustralianBusinessNumberId'].NodeValue := Value;
end;

function TXMLIdentifiers.Get_EmploymentPayrollNumberId: UnicodeString;
begin
  Result := ChildNodes['EmploymentPayrollNumberId'].Text;
end;

procedure TXMLIdentifiers.Set_EmploymentPayrollNumberId(Value: UnicodeString);
begin
  ChildNodes['EmploymentPayrollNumberId'].NodeValue := Value;
end;

function TXMLIdentifiers.Get_PreviousPayrollIDEmploymentPayrollNumberId: UnicodeString;
begin
  Result := ChildNodes['PreviousPayrollIDEmploymentPayrollNumberId'].Text;
end;

procedure TXMLIdentifiers.Set_PreviousPayrollIDEmploymentPayrollNumberId(Value: UnicodeString);
begin
  ChildNodes['PreviousPayrollIDEmploymentPayrollNumberId'].NodeValue := Value;
end;

{ TXMLPersonNameDetails }

function TXMLPersonNameDetails.Get_FamilyNameT: UnicodeString;
begin
  Result := ChildNodes['FamilyNameT'].Text;
end;

procedure TXMLPersonNameDetails.Set_FamilyNameT(Value: UnicodeString);
begin
  ChildNodes['FamilyNameT'].NodeValue := Value;
end;

function TXMLPersonNameDetails.Get_GivenNameT: UnicodeString;
begin
  Result := ChildNodes['GivenNameT'].Text;
end;

procedure TXMLPersonNameDetails.Set_GivenNameT(Value: UnicodeString);
begin
  ChildNodes['GivenNameT'].NodeValue := Value;
end;

function TXMLPersonNameDetails.Get_OtherGivenNameT: UnicodeString;
begin
  Result := ChildNodes['OtherGivenNameT'].Text;
end;

procedure TXMLPersonNameDetails.Set_OtherGivenNameT(Value: UnicodeString);
begin
  ChildNodes['OtherGivenNameT'].NodeValue := Value;
end;

{ TXMLPersonDemographicDetailsBirth }

function TXMLPersonDemographicDetailsBirth.Get_Dm: Integer;
begin
  Result := ChildNodes['Dm'].NodeValue;
end;

procedure TXMLPersonDemographicDetailsBirth.Set_Dm(Value: Integer);
begin
  ChildNodes['Dm'].NodeValue := Value;
end;

function TXMLPersonDemographicDetailsBirth.Get_M: Integer;
begin
  Result := ChildNodes[WideString('M')].NodeValue;
end;

procedure TXMLPersonDemographicDetailsBirth.Set_M(Value: Integer);
begin
  ChildNodes[WideString('M')].NodeValue := Value;
end;

function TXMLPersonDemographicDetailsBirth.Get_Y: Integer;
begin
  Result := ChildNodes[WideString('Y')].NodeValue;
end;

procedure TXMLPersonDemographicDetailsBirth.Set_Y(Value: Integer);
begin
  ChildNodes[WideString('Y')].NodeValue := Value;
end;

{ TXMLAddressDetails }

function TXMLAddressDetails.Get_Line1T: UnicodeString;
begin
  Result := ChildNodes['Line1T'].Text;
end;

procedure TXMLAddressDetails.Set_Line1T(Value: UnicodeString);
begin
  ChildNodes['Line1T'].NodeValue := Value;
end;

function TXMLAddressDetails.Get_Line2T: UnicodeString;
begin
  Result := ChildNodes['Line2T'].Text;
end;

procedure TXMLAddressDetails.Set_Line2T(Value: UnicodeString);
begin
  ChildNodes['Line2T'].NodeValue := Value;
end;

function TXMLAddressDetails.Get_LocalityNameT: UnicodeString;
begin
  Result := ChildNodes['LocalityNameT'].Text;
end;

procedure TXMLAddressDetails.Set_LocalityNameT(Value: UnicodeString);
begin
  ChildNodes['LocalityNameT'].NodeValue := Value;
end;

function TXMLAddressDetails.Get_StateOrTerritoryC: UnicodeString;
begin
  Result := ChildNodes['StateOrTerritoryC'].Text;
end;

procedure TXMLAddressDetails.Set_StateOrTerritoryC(Value: UnicodeString);
begin
  ChildNodes['StateOrTerritoryC'].NodeValue := Value;
end;

function TXMLAddressDetails.Get_PostcodeT: UnicodeString;
begin
  Result := ChildNodes['PostcodeT'].Text;
end;

procedure TXMLAddressDetails.Set_PostcodeT(Value: UnicodeString);
begin
  ChildNodes['PostcodeT'].NodeValue := Value;
end;

function TXMLAddressDetails.Get_CountryC: UnicodeString;
begin
  Result := ChildNodes['CountryC'].Text;
end;

procedure TXMLAddressDetails.Set_CountryC(Value: UnicodeString);
begin
  ChildNodes['CountryC'].NodeValue := Value;
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

{ TXMLEmployerConditions }

function TXMLEmployerConditions.Get_EmploymentStartD: UnicodeString;
begin
  Result := ChildNodes['EmploymentStartD'].Text;
end;

procedure TXMLEmployerConditions.Set_EmploymentStartD(Value: UnicodeString);
begin
  ChildNodes['EmploymentStartD'].NodeValue := Value;
end;

function TXMLEmployerConditions.Get_EmploymentEndD: UnicodeString;
begin
  Result := ChildNodes['EmploymentEndD'].Text;
end;

procedure TXMLEmployerConditions.Set_EmploymentEndD(Value: UnicodeString);
begin
  ChildNodes['EmploymentEndD'].NodeValue := Value;
end;

function TXMLEmployerConditions.Get_PaymentBasisC: UnicodeString;
begin
  Result := ChildNodes['PaymentBasisC'].Text;
end;

procedure TXMLEmployerConditions.Set_PaymentBasisC(Value: UnicodeString);
begin
  ChildNodes['PaymentBasisC'].NodeValue := Value;
end;

function TXMLEmployerConditions.Get_CessationTypeC: UnicodeString;
begin
  Result := ChildNodes['CessationTypeC'].Text;
end;

procedure TXMLEmployerConditions.Set_CessationTypeC(Value: UnicodeString);
begin
  ChildNodes['CessationTypeC'].NodeValue := Value;
end;

function TXMLEmployerConditions.Get_TaxTreatmentC: UnicodeString;
begin
  Result := ChildNodes['TaxTreatmentC'].Text;
end;

procedure TXMLEmployerConditions.Set_TaxTreatmentC(Value: UnicodeString);
begin
  ChildNodes['TaxTreatmentC'].NodeValue := Value;
end;

function TXMLEmployerConditions.Get_TaxOffsetClaimTotalA: UnicodeString;
begin
  Result := ChildNodes['TaxOffsetClaimTotalA'].Text;
end;

procedure TXMLEmployerConditions.Set_TaxOffsetClaimTotalA(Value: UnicodeString);
begin
  ChildNodes['TaxOffsetClaimTotalA'].NodeValue := Value;
end;

{ TXMLPayrollPeriod }

procedure TXMLPayrollPeriod.AfterConstruction;
begin
  RegisterChildNode('RemunerationCollection', TXMLRemunerationCollection);
  RegisterChildNode('DeductionCollection', TXMLDeductionCollection);
  RegisterChildNode('SuperannuationContributionCollection', TXMLSuperannuationContributionCollection);
  RegisterChildNode('IncomeFringeBenefitsReportableCollection', TXMLIncomeFringeBenefitsReportableCollection);
  inherited;
end;

function TXMLPayrollPeriod.Get_StartD: UnicodeString;
begin
  Result := ChildNodes['StartD'].Text;
end;

procedure TXMLPayrollPeriod.Set_StartD(Value: UnicodeString);
begin
  ChildNodes['StartD'].NodeValue := Value;
end;

function TXMLPayrollPeriod.Get_EndD: UnicodeString;
begin
  Result := ChildNodes['EndD'].Text;
end;

procedure TXMLPayrollPeriod.Set_EndD(Value: UnicodeString);
begin
  ChildNodes['EndD'].NodeValue := Value;
end;

function TXMLPayrollPeriod.Get_RemunerationPayrollEventFinalI: Boolean;
begin
  Result := ChildNodes['RemunerationPayrollEventFinalI'].NodeValue;
end;

procedure TXMLPayrollPeriod.Set_RemunerationPayrollEventFinalI(Value: Boolean);
begin
  ChildNodes['RemunerationPayrollEventFinalI'].NodeValue := Value;
end;

function TXMLPayrollPeriod.Get_RemunerationCollection: IXMLRemunerationCollection;
begin
  Result := ChildNodes['RemunerationCollection'] as IXMLRemunerationCollection;
end;

function TXMLPayrollPeriod.Get_DeductionCollection: IXMLDeductionCollection;
begin
  Result := ChildNodes['DeductionCollection'] as IXMLDeductionCollection;
end;

function TXMLPayrollPeriod.Get_SuperannuationContributionCollection: IXMLSuperannuationContributionCollection;
begin
  Result := ChildNodes['SuperannuationContributionCollection'] as IXMLSuperannuationContributionCollection;
end;

function TXMLPayrollPeriod.Get_IncomeFringeBenefitsReportableCollection: IXMLIncomeFringeBenefitsReportableCollection;
begin
  Result := ChildNodes['IncomeFringeBenefitsReportableCollection'] as IXMLIncomeFringeBenefitsReportableCollection;
end;

{ TXMLRemunerationCollection }

procedure TXMLRemunerationCollection.AfterConstruction;
begin
  RegisterChildNode('Remuneration', TXMLRemuneration);
  ItemTag := 'Remuneration';
  ItemInterface := IXMLRemuneration;
  inherited;
end;

function TXMLRemunerationCollection.Get_Remuneration(Index: Integer): IXMLRemuneration;
begin
  Result := List[Index] as IXMLRemuneration;
end;

function TXMLRemunerationCollection.Add: IXMLRemuneration;
begin
  Result := AddItem(-1) as IXMLRemuneration;
end;

function TXMLRemunerationCollection.Insert(const Index: Integer): IXMLRemuneration;
begin
  Result := AddItem(Index) as IXMLRemuneration;
end;

{ TXMLRemuneration }

procedure TXMLRemuneration.AfterConstruction;
begin
  RegisterChildNode('PaidLeaveCollection', TXMLPaidLeaveCollection);
  RegisterChildNode('AllowanceCollection', TXMLAllowanceCollection);
  RegisterChildNode('SalarySacrificeCollection', TXMLSalarySacrificeCollection);
  RegisterChildNode('LumpSumCollection', TXMLLumpSumCollection);
  RegisterChildNode('EmploymentTerminationPaymentCollection', TXMLEmploymentTerminationPaymentCollection);
  inherited;
end;

function TXMLRemuneration.Get_IncomeStreamTypeC: UnicodeString;
begin
  Result := ChildNodes['IncomeStreamTypeC'].Text;
end;

procedure TXMLRemuneration.Set_IncomeStreamTypeC(Value: UnicodeString);
begin
  ChildNodes['IncomeStreamTypeC'].NodeValue := Value;
end;

function TXMLRemuneration.Get_AddressDetailsCountryC: UnicodeString;
begin
  Result := ChildNodes['AddressDetailsCountryC'].Text;
end;

procedure TXMLRemuneration.Set_AddressDetailsCountryC(Value: UnicodeString);
begin
  ChildNodes['AddressDetailsCountryC'].NodeValue := Value;
end;

function TXMLRemuneration.Get_IncomeTaxPayAsYouGoWithholdingTaxWithheldA: UnicodeString;
begin
  Result := ChildNodes['IncomeTaxPayAsYouGoWithholdingTaxWithheldA'].Text;
end;

procedure TXMLRemuneration.Set_IncomeTaxPayAsYouGoWithholdingTaxWithheldA(Value: UnicodeString);
begin
  ChildNodes['IncomeTaxPayAsYouGoWithholdingTaxWithheldA'].NodeValue := Value;
end;

function TXMLRemuneration.Get_IncomeTaxForeignWithholdingA: UnicodeString;
begin
  Result := ChildNodes['IncomeTaxForeignWithholdingA'].Text;
end;

procedure TXMLRemuneration.Set_IncomeTaxForeignWithholdingA(Value: UnicodeString);
begin
  ChildNodes['IncomeTaxForeignWithholdingA'].NodeValue := Value;
end;

function TXMLRemuneration.Get_IndividualNonBusinessExemptForeignEmploymentIncomeA: UnicodeString;
begin
  Result := ChildNodes['IndividualNonBusinessExemptForeignEmploymentIncomeA'].Text;
end;

procedure TXMLRemuneration.Set_IndividualNonBusinessExemptForeignEmploymentIncomeA(Value: UnicodeString);
begin
  ChildNodes['IndividualNonBusinessExemptForeignEmploymentIncomeA'].NodeValue := Value;
end;

function TXMLRemuneration.Get_GrossA: UnicodeString;
begin
  Result := ChildNodes['GrossA'].Text;
end;

procedure TXMLRemuneration.Set_GrossA(Value: UnicodeString);
begin
  ChildNodes['GrossA'].NodeValue := Value;
end;

function TXMLRemuneration.Get_PaidLeaveCollection: IXMLPaidLeaveCollection;
begin
  Result := ChildNodes['PaidLeaveCollection'] as IXMLPaidLeaveCollection;
end;

function TXMLRemuneration.Get_AllowanceCollection: IXMLAllowanceCollection;
begin
  Result := ChildNodes['AllowanceCollection'] as IXMLAllowanceCollection;
end;

function TXMLRemuneration.Get_OvertimePaymentA: UnicodeString;
begin
  Result := ChildNodes['OvertimePaymentA'].Text;
end;

procedure TXMLRemuneration.Set_OvertimePaymentA(Value: UnicodeString);
begin
  ChildNodes['OvertimePaymentA'].NodeValue := Value;
end;

function TXMLRemuneration.Get_GrossBonusesAndCommissionsA: UnicodeString;
begin
  Result := ChildNodes['GrossBonusesAndCommissionsA'].Text;
end;

procedure TXMLRemuneration.Set_GrossBonusesAndCommissionsA(Value: UnicodeString);
begin
  ChildNodes['GrossBonusesAndCommissionsA'].NodeValue := Value;
end;

function TXMLRemuneration.Get_GrossDirectorsFeesA: UnicodeString;
begin
  Result := ChildNodes['GrossDirectorsFeesA'].Text;
end;

procedure TXMLRemuneration.Set_GrossDirectorsFeesA(Value: UnicodeString);
begin
  ChildNodes['GrossDirectorsFeesA'].NodeValue := Value;
end;

function TXMLRemuneration.Get_IndividualNonBusinessCommunityDevelopmentEmploymentProjectA: UnicodeString;
begin
  Result := ChildNodes['IndividualNonBusinessCommunityDevelopmentEmploymentProjectA'].Text;
end;

procedure TXMLRemuneration.Set_IndividualNonBusinessCommunityDevelopmentEmploymentProjectA(Value: UnicodeString);
begin
  ChildNodes['IndividualNonBusinessCommunityDevelopmentEmploymentProjectA'].NodeValue := Value;
end;

function TXMLRemuneration.Get_SalarySacrificeCollection: IXMLSalarySacrificeCollection;
begin
  Result := ChildNodes['SalarySacrificeCollection'] as IXMLSalarySacrificeCollection;
end;

function TXMLRemuneration.Get_LumpSumCollection: IXMLLumpSumCollection;
begin
  Result := ChildNodes['LumpSumCollection'] as IXMLLumpSumCollection;
end;

function TXMLRemuneration.Get_EmploymentTerminationPaymentCollection: IXMLEmploymentTerminationPaymentCollection;
begin
  Result := ChildNodes['EmploymentTerminationPaymentCollection'] as IXMLEmploymentTerminationPaymentCollection;
end;

{ TXMLPaidLeaveCollection }

procedure TXMLPaidLeaveCollection.AfterConstruction;
begin
  RegisterChildNode('PaidLeave', TXMLPaidLeave);
  ItemTag := 'PaidLeave';
  ItemInterface := IXMLPaidLeave;
  inherited;
end;

function TXMLPaidLeaveCollection.Get_PaidLeave(Index: Integer): IXMLPaidLeave;
begin
  Result := List[Index] as IXMLPaidLeave;
end;

function TXMLPaidLeaveCollection.Add: IXMLPaidLeave;
begin
  Result := AddItem(-1) as IXMLPaidLeave;
end;

function TXMLPaidLeaveCollection.Insert(const Index: Integer): IXMLPaidLeave;
begin
  Result := AddItem(Index) as IXMLPaidLeave;
end;

{ TXMLPaidLeave }

function TXMLPaidLeave.Get_TypeC: UnicodeString;
begin
  Result := ChildNodes['TypeC'].Text;
end;

procedure TXMLPaidLeave.Set_TypeC(Value: UnicodeString);
begin
  ChildNodes['TypeC'].NodeValue := Value;
end;

function TXMLPaidLeave.Get_PaymentA: UnicodeString;
begin
  Result := ChildNodes['PaymentA'].Text;
end;

procedure TXMLPaidLeave.Set_PaymentA(Value: UnicodeString);
begin
  ChildNodes['PaymentA'].NodeValue := Value;
end;

{ TXMLAllowanceCollection }

procedure TXMLAllowanceCollection.AfterConstruction;
begin
  RegisterChildNode('Allowance', TXMLAllowance);
  ItemTag := 'Allowance';
  ItemInterface := IXMLAllowance;
  inherited;
end;

function TXMLAllowanceCollection.Get_Allowance(Index: Integer): IXMLAllowance;
begin
  Result := List[Index] as IXMLAllowance;
end;

function TXMLAllowanceCollection.Add: IXMLAllowance;
begin
  Result := AddItem(-1) as IXMLAllowance;
end;

function TXMLAllowanceCollection.Insert(const Index: Integer): IXMLAllowance;
begin
  Result := AddItem(Index) as IXMLAllowance;
end;

{ TXMLAllowance }

function TXMLAllowance.Get_TypeC: UnicodeString;
begin
  Result := ChildNodes['TypeC'].Text;
end;

procedure TXMLAllowance.Set_TypeC(Value: UnicodeString);
begin
  ChildNodes['TypeC'].NodeValue := Value;
end;

function TXMLAllowance.Get_OtherAllowanceTypeDe: UnicodeString;
begin
  Result := ChildNodes['OtherAllowanceTypeDe'].Text;
end;

procedure TXMLAllowance.Set_OtherAllowanceTypeDe(Value: UnicodeString);
begin
  ChildNodes['OtherAllowanceTypeDe'].NodeValue := Value;
end;

function TXMLAllowance.Get_EmploymentAllowancesA: UnicodeString;
begin
  Result := ChildNodes['EmploymentAllowancesA'].Text;
end;

procedure TXMLAllowance.Set_EmploymentAllowancesA(Value: UnicodeString);
begin
  ChildNodes['EmploymentAllowancesA'].NodeValue := Value;
end;

{ TXMLSalarySacrificeCollection }

procedure TXMLSalarySacrificeCollection.AfterConstruction;
begin
  RegisterChildNode('SalarySacrifice', TXMLSalarySacrifice);
  ItemTag := 'SalarySacrifice';
  ItemInterface := IXMLSalarySacrifice;
  inherited;
end;

function TXMLSalarySacrificeCollection.Get_SalarySacrifice(Index: Integer): IXMLSalarySacrifice;
begin
  Result := List[Index] as IXMLSalarySacrifice;
end;

function TXMLSalarySacrificeCollection.Add: IXMLSalarySacrifice;
begin
  Result := AddItem(-1) as IXMLSalarySacrifice;
end;

function TXMLSalarySacrificeCollection.Insert(const Index: Integer): IXMLSalarySacrifice;
begin
  Result := AddItem(Index) as IXMLSalarySacrifice;
end;

{ TXMLSalarySacrifice }

function TXMLSalarySacrifice.Get_TypeC: UnicodeString;
begin
  Result := ChildNodes['TypeC'].Text;
end;

procedure TXMLSalarySacrifice.Set_TypeC(Value: UnicodeString);
begin
  ChildNodes['TypeC'].NodeValue := Value;
end;

function TXMLSalarySacrifice.Get_PaymentA: UnicodeString;
begin
  Result := ChildNodes['PaymentA'].Text;
end;

procedure TXMLSalarySacrifice.Set_PaymentA(Value: UnicodeString);
begin
  ChildNodes['PaymentA'].NodeValue := Value;
end;

{ TXMLLumpSumCollection }

procedure TXMLLumpSumCollection.AfterConstruction;
begin
  RegisterChildNode('LumpSum', TXMLLumpSum);
  ItemTag := 'LumpSum';
  ItemInterface := IXMLLumpSum;
  inherited;
end;

function TXMLLumpSumCollection.Get_LumpSum(Index: Integer): IXMLLumpSum;
begin
  Result := List[Index] as IXMLLumpSum;
end;

function TXMLLumpSumCollection.Add: IXMLLumpSum;
begin
  Result := AddItem(-1) as IXMLLumpSum;
end;

function TXMLLumpSumCollection.Insert(const Index: Integer): IXMLLumpSum;
begin
  Result := AddItem(Index) as IXMLLumpSum;
end;

{ TXMLLumpSum }

function TXMLLumpSum.Get_TypeC: UnicodeString;
begin
  Result := ChildNodes['TypeC'].Text;
end;

procedure TXMLLumpSum.Set_TypeC(Value: UnicodeString);
begin
  ChildNodes['TypeC'].NodeValue := Value;
end;

function TXMLLumpSum.Get_FinancialY: Integer;
begin
  Result := ChildNodes['FinancialY'].NodeValue;
end;

procedure TXMLLumpSum.Set_FinancialY(Value: Integer);
begin
  ChildNodes['FinancialY'].NodeValue := Value;
end;

function TXMLLumpSum.Get_PaymentsA: UnicodeString;
begin
  Result := ChildNodes['PaymentsA'].Text;
end;

procedure TXMLLumpSum.Set_PaymentsA(Value: UnicodeString);
begin
  ChildNodes['PaymentsA'].NodeValue := Value;
end;

{ TXMLEmploymentTerminationPaymentCollection }

procedure TXMLEmploymentTerminationPaymentCollection.AfterConstruction;
begin
  RegisterChildNode('EmploymentTerminationPayment', TXMLEmploymentTerminationPayment);
  ItemTag := 'EmploymentTerminationPayment';
  ItemInterface := IXMLEmploymentTerminationPayment;
  inherited;
end;

function TXMLEmploymentTerminationPaymentCollection.Get_EmploymentTerminationPayment(Index: Integer): IXMLEmploymentTerminationPayment;
begin
  Result := List[Index] as IXMLEmploymentTerminationPayment;
end;

function TXMLEmploymentTerminationPaymentCollection.Add: IXMLEmploymentTerminationPayment;
begin
  Result := AddItem(-1) as IXMLEmploymentTerminationPayment;
end;

function TXMLEmploymentTerminationPaymentCollection.Insert(const Index: Integer): IXMLEmploymentTerminationPayment;
begin
  Result := AddItem(Index) as IXMLEmploymentTerminationPayment;
end;

{ TXMLEmploymentTerminationPayment }

function TXMLEmploymentTerminationPayment.Get_IncomeTaxPayAsYouGoWithholdingTypeC: UnicodeString;
begin
  Result := ChildNodes['IncomeTaxPayAsYouGoWithholdingTypeC'].Text;
end;

procedure TXMLEmploymentTerminationPayment.Set_IncomeTaxPayAsYouGoWithholdingTypeC(Value: UnicodeString);
begin
  ChildNodes['IncomeTaxPayAsYouGoWithholdingTypeC'].NodeValue := Value;
end;

function TXMLEmploymentTerminationPayment.Get_IncomeD: UnicodeString;
begin
  Result := ChildNodes['IncomeD'].Text;
end;

procedure TXMLEmploymentTerminationPayment.Set_IncomeD(Value: UnicodeString);
begin
  ChildNodes['IncomeD'].NodeValue := Value;
end;

function TXMLEmploymentTerminationPayment.Get_IncomeTaxFreeA: UnicodeString;
begin
  Result := ChildNodes['IncomeTaxFreeA'].Text;
end;

procedure TXMLEmploymentTerminationPayment.Set_IncomeTaxFreeA(Value: UnicodeString);
begin
  ChildNodes['IncomeTaxFreeA'].NodeValue := Value;
end;

function TXMLEmploymentTerminationPayment.Get_IncomeTaxableA: UnicodeString;
begin
  Result := ChildNodes['IncomeTaxableA'].Text;
end;

procedure TXMLEmploymentTerminationPayment.Set_IncomeTaxableA(Value: UnicodeString);
begin
  ChildNodes['IncomeTaxableA'].NodeValue := Value;
end;

function TXMLEmploymentTerminationPayment.Get_IncomePayAsYouGoWithholdingA: UnicodeString;
begin
  Result := ChildNodes['IncomePayAsYouGoWithholdingA'].Text;
end;

procedure TXMLEmploymentTerminationPayment.Set_IncomePayAsYouGoWithholdingA(Value: UnicodeString);
begin
  ChildNodes['IncomePayAsYouGoWithholdingA'].NodeValue := Value;
end;

{ TXMLDeductionCollection }

procedure TXMLDeductionCollection.AfterConstruction;
begin
  RegisterChildNode('Deduction', TXMLDeduction);
  ItemTag := 'Deduction';
  ItemInterface := IXMLDeduction;
  inherited;
end;

function TXMLDeductionCollection.Get_Deduction(Index: Integer): IXMLDeduction;
begin
  Result := List[Index] as IXMLDeduction;
end;

function TXMLDeductionCollection.Add: IXMLDeduction;
begin
  Result := AddItem(-1) as IXMLDeduction;
end;

function TXMLDeductionCollection.Insert(const Index: Integer): IXMLDeduction;
begin
  Result := AddItem(Index) as IXMLDeduction;
end;

{ TXMLDeduction }

function TXMLDeduction.Get_RemunerationTypeC: UnicodeString;
begin
  Result := ChildNodes['RemunerationTypeC'].Text;
end;

procedure TXMLDeduction.Set_RemunerationTypeC(Value: UnicodeString);
begin
  ChildNodes['RemunerationTypeC'].NodeValue := Value;
end;

function TXMLDeduction.Get_RemunerationA: UnicodeString;
begin
  Result := ChildNodes['RemunerationA'].Text;
end;

procedure TXMLDeduction.Set_RemunerationA(Value: UnicodeString);
begin
  ChildNodes['RemunerationA'].NodeValue := Value;
end;

{ TXMLSuperannuationContributionCollection }

procedure TXMLSuperannuationContributionCollection.AfterConstruction;
begin
  RegisterChildNode('SuperannuationContribution', TXMLSuperannuationContribution);
  ItemTag := 'SuperannuationContribution';
  ItemInterface := IXMLSuperannuationContribution;
  inherited;
end;

function TXMLSuperannuationContributionCollection.Get_SuperannuationContribution(Index: Integer): IXMLSuperannuationContribution;
begin
  Result := List[Index] as IXMLSuperannuationContribution;
end;

function TXMLSuperannuationContributionCollection.Add: IXMLSuperannuationContribution;
begin
  Result := AddItem(-1) as IXMLSuperannuationContribution;
end;

function TXMLSuperannuationContributionCollection.Insert(const Index: Integer): IXMLSuperannuationContribution;
begin
  Result := AddItem(Index) as IXMLSuperannuationContribution;
end;

{ TXMLSuperannuationContribution }

function TXMLSuperannuationContribution.Get_EntitlementTypeC: UnicodeString;
begin
  Result := ChildNodes['EntitlementTypeC'].Text;
end;

procedure TXMLSuperannuationContribution.Set_EntitlementTypeC(Value: UnicodeString);
begin
  ChildNodes['EntitlementTypeC'].NodeValue := Value;
end;

function TXMLSuperannuationContribution.Get_EmployerContributionsYearToDateA: UnicodeString;
begin
  Result := ChildNodes['EmployerContributionsYearToDateA'].Text;
end;

procedure TXMLSuperannuationContribution.Set_EmployerContributionsYearToDateA(Value: UnicodeString);
begin
  ChildNodes['EmployerContributionsYearToDateA'].NodeValue := Value;
end;

{ TXMLIncomeFringeBenefitsReportableCollection }

procedure TXMLIncomeFringeBenefitsReportableCollection.AfterConstruction;
begin
  RegisterChildNode('IncomeFringeBenefitsReportable', TXMLIncomeFringeBenefitsReportable);
  ItemTag := 'IncomeFringeBenefitsReportable';
  ItemInterface := IXMLIncomeFringeBenefitsReportable;
  inherited;
end;

function TXMLIncomeFringeBenefitsReportableCollection.Get_IncomeFringeBenefitsReportable(Index: Integer): IXMLIncomeFringeBenefitsReportable;
begin
  Result := List[Index] as IXMLIncomeFringeBenefitsReportable;
end;

function TXMLIncomeFringeBenefitsReportableCollection.Add: IXMLIncomeFringeBenefitsReportable;
begin
  Result := AddItem(-1) as IXMLIncomeFringeBenefitsReportable;
end;

function TXMLIncomeFringeBenefitsReportableCollection.Insert(const Index: Integer): IXMLIncomeFringeBenefitsReportable;
begin
  Result := AddItem(Index) as IXMLIncomeFringeBenefitsReportable;
end;

{ TXMLIncomeFringeBenefitsReportable }

function TXMLIncomeFringeBenefitsReportable.Get_FringeBenefitsReportableExemptionC: UnicodeString;
begin
  Result := ChildNodes['FringeBenefitsReportableExemptionC'].Text;
end;

procedure TXMLIncomeFringeBenefitsReportable.Set_FringeBenefitsReportableExemptionC(Value: UnicodeString);
begin
  ChildNodes['FringeBenefitsReportableExemptionC'].NodeValue := Value;
end;

function TXMLIncomeFringeBenefitsReportable.Get_A: UnicodeString;
begin
  Result := ChildNodes[WideString('A')].Text;
end;

procedure TXMLIncomeFringeBenefitsReportable.Set_A(Value: UnicodeString);
begin
  ChildNodes[WideString('A')].NodeValue := Value;
end;

end.