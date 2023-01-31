
{**************************************************************************************************************************************************************}
{                                                                                                                                                              }
{                                                                       XML Data Binding                                                                       }
{                                                                                                                                                              }
{         Generated on: 22/06/2018 2:42:21 PM                                                                                                                  }
{       Generated from: C:\Dev\ERP\Dev\Aus_Gov\SBR\ato\ATO-PAYEVNT.0003-2018-Package-v1.0\ATO PAYEVNT.0003 2018 Contracts\ato.payevntemp.0003.2018.01.00.xsd   }
{   Settings stored in: C:\Dev\ERP\Dev\Aus_Gov\SBR\ato\ATO-PAYEVNT.0003-2018-Package-v1.0\ATO PAYEVNT.0003 2018 Contracts\ato.payevntemp.0003.2018.01.00.xdb   }
{                                                                                                                                                              }
{**************************************************************************************************************************************************************}

unit atopayevntemp000320180100;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLPAYEVNTEMP = interface;
  IXMLPayee = interface;
  IXMLIdentifiers = interface;
  IXMLPersonNameDetails = interface;
  IXMLPersonDemographicDetails = interface;
  IXMLAddressDetails = interface;
  IXMLElectronicContact = interface;
  IXMLEmployerConditions = interface;
  IXMLRemunerationIncomeTaxPayAsYouGoWithholding = interface;
  IXMLPayrollPeriod = interface;
  IXMLIndividualNonBusiness = interface;
  IXMLVoluntaryAgreement = interface;
  IXMLLabourHireArrangementPayment = interface;
  IXMLSpecifiedByRegulationPayment = interface;
  IXMLJointPetroleumDevelopmentAreaPayment = interface;
  IXMLWorkingHolidayMaker = interface;
  IXMLPaymentToForeignResident = interface;
  IXMLEmploymentTerminationPaymentCollection = interface;
  IXMLEmploymentTerminationPayment = interface;
  IXMLUnusedAnnualOrLongServiceLeavePayment = interface;
  IXMLLumpSumPaymentA = interface;
  IXMLAllowanceCollection = interface;
  IXMLAllowance = interface;
  IXMLDeductionCollection = interface;
  IXMLDeduction = interface;
  IXMLSuperannuationContribution = interface;
  IXMLIncomeFringeBenefitsReportable = interface;
  IXMLOnboarding = interface;
  IXMLTFND = interface;
  IXMLDeclaration = interface;

{ IXMLPAYEVNTEMP }

  IXMLPAYEVNTEMP = interface(IXMLNode)
    ['{78BD553F-9DBB-40AA-B4DA-54DF5445FB6F}']
    { Property Accessors }
    function Get_Payee: IXMLPayee;
    { Methods & Properties }
    property Payee: IXMLPayee read Get_Payee;
  end;

{ IXMLPayee }

  IXMLPayee = interface(IXMLNode)
    ['{E5055453-DBA8-49CB-A7BB-305D410F05B9}']
    { Property Accessors }
    function Get_Identifiers: IXMLIdentifiers;
    function Get_PersonNameDetails: IXMLPersonNameDetails;
    function Get_PersonDemographicDetails: IXMLPersonDemographicDetails;
    function Get_AddressDetails: IXMLAddressDetails;
    function Get_ElectronicContact: IXMLElectronicContact;
    function Get_EmployerConditions: IXMLEmployerConditions;
    function Get_RemunerationIncomeTaxPayAsYouGoWithholding: IXMLRemunerationIncomeTaxPayAsYouGoWithholding;
    function Get_Onboarding: IXMLOnboarding;
    { Methods & Properties }
    property Identifiers: IXMLIdentifiers read Get_Identifiers;
    property PersonNameDetails: IXMLPersonNameDetails read Get_PersonNameDetails;
    property PersonDemographicDetails: IXMLPersonDemographicDetails read Get_PersonDemographicDetails;
    property AddressDetails: IXMLAddressDetails read Get_AddressDetails;
    property ElectronicContact: IXMLElectronicContact read Get_ElectronicContact;
    property EmployerConditions: IXMLEmployerConditions read Get_EmployerConditions;
    property RemunerationIncomeTaxPayAsYouGoWithholding: IXMLRemunerationIncomeTaxPayAsYouGoWithholding read Get_RemunerationIncomeTaxPayAsYouGoWithholding;
    property Onboarding: IXMLOnboarding read Get_Onboarding;
  end;

{ IXMLIdentifiers }

  IXMLIdentifiers = interface(IXMLNode)
    ['{D47C49D8-00A4-43DA-A40B-D1F8F4B6E845}']
    { Property Accessors }
    function Get_TaxFileNumberId: UnicodeString;
    function Get_AustralianBusinessNumberId: UnicodeString;
    function Get_EmploymentPayrollNumberId: UnicodeString;
    procedure Set_TaxFileNumberId(Value: UnicodeString);
    procedure Set_AustralianBusinessNumberId(Value: UnicodeString);
    procedure Set_EmploymentPayrollNumberId(Value: UnicodeString);
    { Methods & Properties }
    property TaxFileNumberId: UnicodeString read Get_TaxFileNumberId write Set_TaxFileNumberId;
    property AustralianBusinessNumberId: UnicodeString read Get_AustralianBusinessNumberId write Set_AustralianBusinessNumberId;
    property EmploymentPayrollNumberId: UnicodeString read Get_EmploymentPayrollNumberId write Set_EmploymentPayrollNumberId;
  end;

{ IXMLPersonNameDetails }

  IXMLPersonNameDetails = interface(IXMLNode)
    ['{90853187-7428-424B-A7D5-91501907AE13}']
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

{ IXMLPersonDemographicDetails }

  IXMLPersonDemographicDetails = interface(IXMLNode)
    ['{155B0D00-60BC-4FC9-8BE4-3F297177DEE3}']
    { Property Accessors }
    function Get_BirthDm: Integer;
    function Get_BirthM: Integer;
    function Get_BirthY: Integer;
    procedure Set_BirthDm(Value: Integer);
    procedure Set_BirthM(Value: Integer);
    procedure Set_BirthY(Value: Integer);
    { Methods & Properties }
    property BirthDm: Integer read Get_BirthDm write Set_BirthDm;
    property BirthM: Integer read Get_BirthM write Set_BirthM;
    property BirthY: Integer read Get_BirthY write Set_BirthY;
  end;

{ IXMLAddressDetails }

  IXMLAddressDetails = interface(IXMLNode)
    ['{9268EB94-A496-4071-891F-CE14A3737AAC}']
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
    ['{09527D84-9689-4261-A948-C539C809044A}']
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
    ['{231CE38B-AC19-49A0-82D4-8977A23B976A}']
    { Property Accessors }
    function Get_EmploymentStartD: UnicodeString;
    function Get_EmploymentEndD: UnicodeString;
    procedure Set_EmploymentStartD(Value: UnicodeString);
    procedure Set_EmploymentEndD(Value: UnicodeString);
    { Methods & Properties }
    property EmploymentStartD: UnicodeString read Get_EmploymentStartD write Set_EmploymentStartD;
    property EmploymentEndD: UnicodeString read Get_EmploymentEndD write Set_EmploymentEndD;
  end;

{ IXMLRemunerationIncomeTaxPayAsYouGoWithholding }

  IXMLRemunerationIncomeTaxPayAsYouGoWithholding = interface(IXMLNode)
    ['{ACE7687B-D40A-4365-82FD-8752F1F9C21D}']
    { Property Accessors }
    function Get_PayrollPeriod: IXMLPayrollPeriod;
    function Get_IndividualNonBusiness: IXMLIndividualNonBusiness;
    function Get_VoluntaryAgreement: IXMLVoluntaryAgreement;
    function Get_LabourHireArrangementPayment: IXMLLabourHireArrangementPayment;
    function Get_SpecifiedByRegulationPayment: IXMLSpecifiedByRegulationPayment;
    function Get_JointPetroleumDevelopmentAreaPayment: IXMLJointPetroleumDevelopmentAreaPayment;
    function Get_WorkingHolidayMaker: IXMLWorkingHolidayMaker;
    function Get_PaymentToForeignResident: IXMLPaymentToForeignResident;
    function Get_EmploymentTerminationPaymentCollection: IXMLEmploymentTerminationPaymentCollection;
    function Get_UnusedAnnualOrLongServiceLeavePayment: IXMLUnusedAnnualOrLongServiceLeavePayment;
    function Get_AllowanceCollection: IXMLAllowanceCollection;
    function Get_DeductionCollection: IXMLDeductionCollection;
    function Get_SuperannuationContribution: IXMLSuperannuationContribution;
    function Get_IncomeFringeBenefitsReportable: IXMLIncomeFringeBenefitsReportable;
    { Methods & Properties }
    property PayrollPeriod: IXMLPayrollPeriod read Get_PayrollPeriod;
    property IndividualNonBusiness: IXMLIndividualNonBusiness read Get_IndividualNonBusiness;
    property VoluntaryAgreement: IXMLVoluntaryAgreement read Get_VoluntaryAgreement;
    property LabourHireArrangementPayment: IXMLLabourHireArrangementPayment read Get_LabourHireArrangementPayment;
    property SpecifiedByRegulationPayment: IXMLSpecifiedByRegulationPayment read Get_SpecifiedByRegulationPayment;
    property JointPetroleumDevelopmentAreaPayment: IXMLJointPetroleumDevelopmentAreaPayment read Get_JointPetroleumDevelopmentAreaPayment;
    property WorkingHolidayMaker: IXMLWorkingHolidayMaker read Get_WorkingHolidayMaker;
    property PaymentToForeignResident: IXMLPaymentToForeignResident read Get_PaymentToForeignResident;
    property EmploymentTerminationPaymentCollection: IXMLEmploymentTerminationPaymentCollection read Get_EmploymentTerminationPaymentCollection;
    property UnusedAnnualOrLongServiceLeavePayment: IXMLUnusedAnnualOrLongServiceLeavePayment read Get_UnusedAnnualOrLongServiceLeavePayment;
    property AllowanceCollection: IXMLAllowanceCollection read Get_AllowanceCollection;
    property DeductionCollection: IXMLDeductionCollection read Get_DeductionCollection;
    property SuperannuationContribution: IXMLSuperannuationContribution read Get_SuperannuationContribution;
    property IncomeFringeBenefitsReportable: IXMLIncomeFringeBenefitsReportable read Get_IncomeFringeBenefitsReportable;
  end;

{ IXMLPayrollPeriod }

  IXMLPayrollPeriod = interface(IXMLNode)
    ['{5E5E9066-0A97-44DB-8F7C-F400061AFE8A}']
    { Property Accessors }
    function Get_StartD: UnicodeString;
    function Get_EndD: UnicodeString;
    function Get_PayrollEventFinalI: Boolean;
    procedure Set_StartD(Value: UnicodeString);
    procedure Set_EndD(Value: UnicodeString);
    procedure Set_PayrollEventFinalI(Value: Boolean);
    { Methods & Properties }
    property StartD: UnicodeString read Get_StartD write Set_StartD;
    property EndD: UnicodeString read Get_EndD write Set_EndD;
    property PayrollEventFinalI: Boolean read Get_PayrollEventFinalI write Set_PayrollEventFinalI;
  end;

{ IXMLIndividualNonBusiness }

  IXMLIndividualNonBusiness = interface(IXMLNode)
    ['{B952B36D-6B6A-4195-8BC7-3D57BE5A3955}']
    { Property Accessors }
    function Get_GrossA: UnicodeString;
    function Get_CommunityDevelopmentEmploymentProjectA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    function Get_ExemptForeignEmploymentIncomeA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_CommunityDevelopmentEmploymentProjectA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
    procedure Set_ExemptForeignEmploymentIncomeA(Value: UnicodeString);
    { Methods & Properties }
    property GrossA: UnicodeString read Get_GrossA write Set_GrossA;
    property CommunityDevelopmentEmploymentProjectA: UnicodeString read Get_CommunityDevelopmentEmploymentProjectA write Set_CommunityDevelopmentEmploymentProjectA;
    property TaxWithheldA: UnicodeString read Get_TaxWithheldA write Set_TaxWithheldA;
    property ExemptForeignEmploymentIncomeA: UnicodeString read Get_ExemptForeignEmploymentIncomeA write Set_ExemptForeignEmploymentIncomeA;
  end;

{ IXMLVoluntaryAgreement }

  IXMLVoluntaryAgreement = interface(IXMLNode)
    ['{977F4E0A-BDF8-442E-92E1-D4811DBCA0E4}']
    { Property Accessors }
    function Get_GrossA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
    { Methods & Properties }
    property GrossA: UnicodeString read Get_GrossA write Set_GrossA;
    property TaxWithheldA: UnicodeString read Get_TaxWithheldA write Set_TaxWithheldA;
  end;

{ IXMLLabourHireArrangementPayment }

  IXMLLabourHireArrangementPayment = interface(IXMLNode)
    ['{DB89CE40-3B4F-41CD-85D8-81B07A385174}']
    { Property Accessors }
    function Get_GrossA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
    { Methods & Properties }
    property GrossA: UnicodeString read Get_GrossA write Set_GrossA;
    property TaxWithheldA: UnicodeString read Get_TaxWithheldA write Set_TaxWithheldA;
  end;

{ IXMLSpecifiedByRegulationPayment }

  IXMLSpecifiedByRegulationPayment = interface(IXMLNode)
    ['{B30C761E-9CE3-4FEA-B10E-F097442C3134}']
    { Property Accessors }
    function Get_GrossA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
    { Methods & Properties }
    property GrossA: UnicodeString read Get_GrossA write Set_GrossA;
    property TaxWithheldA: UnicodeString read Get_TaxWithheldA write Set_TaxWithheldA;
  end;

{ IXMLJointPetroleumDevelopmentAreaPayment }

  IXMLJointPetroleumDevelopmentAreaPayment = interface(IXMLNode)
    ['{65CA7B5C-E782-4BC7-8CD1-B9EA3A3DE9D9}']
    { Property Accessors }
    function Get_A: UnicodeString;
    function Get_ForeignWithholdingA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_A(Value: UnicodeString);
    procedure Set_ForeignWithholdingA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
    { Methods & Properties }
    property A: UnicodeString read Get_A write Set_A;
    property ForeignWithholdingA: UnicodeString read Get_ForeignWithholdingA write Set_ForeignWithholdingA;
    property TaxWithheldA: UnicodeString read Get_TaxWithheldA write Set_TaxWithheldA;
  end;

{ IXMLWorkingHolidayMaker }

  IXMLWorkingHolidayMaker = interface(IXMLNode)
    ['{3507302E-B441-424C-99C9-D8D70BE278AD}']
    { Property Accessors }
    function Get_GrossA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
    { Methods & Properties }
    property GrossA: UnicodeString read Get_GrossA write Set_GrossA;
    property TaxWithheldA: UnicodeString read Get_TaxWithheldA write Set_TaxWithheldA;
  end;

{ IXMLPaymentToForeignResident }

  IXMLPaymentToForeignResident = interface(IXMLNode)
    ['{1C429E2D-AC4D-4351-87A8-66D74532F78D}']
    { Property Accessors }
    function Get_GrossA: UnicodeString;
    function Get_ForeignWithholdingA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_ForeignWithholdingA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
    { Methods & Properties }
    property GrossA: UnicodeString read Get_GrossA write Set_GrossA;
    property ForeignWithholdingA: UnicodeString read Get_ForeignWithholdingA write Set_ForeignWithholdingA;
    property TaxWithheldA: UnicodeString read Get_TaxWithheldA write Set_TaxWithheldA;
  end;

{ IXMLEmploymentTerminationPaymentCollection }

  IXMLEmploymentTerminationPaymentCollection = interface(IXMLNodeCollection)
    ['{EFFFE9D5-670E-47F9-BE0F-8F54AA661023}']
    { Property Accessors }
    function Get_EmploymentTerminationPayment(Index: Integer): IXMLEmploymentTerminationPayment;
    { Methods & Properties }
    function Add: IXMLEmploymentTerminationPayment;
    function Insert(const Index: Integer): IXMLEmploymentTerminationPayment;
    property EmploymentTerminationPayment[Index: Integer]: IXMLEmploymentTerminationPayment read Get_EmploymentTerminationPayment; default;
  end;

{ IXMLEmploymentTerminationPayment }

  IXMLEmploymentTerminationPayment = interface(IXMLNode)
    ['{2A46C38F-36A2-4CF5-AD9E-1A730A2DB910}']
    { Property Accessors }
    function Get_TypeC: UnicodeString;
    function Get_PaymentRecordPaymentEffectiveD: UnicodeString;
    function Get_SuperannuationTaxFreeComponentA: UnicodeString;
    function Get_SuperannuationEmploymentTerminationTaxableComponentTotalA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_PaymentRecordPaymentEffectiveD(Value: UnicodeString);
    procedure Set_SuperannuationTaxFreeComponentA(Value: UnicodeString);
    procedure Set_SuperannuationEmploymentTerminationTaxableComponentTotalA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
    { Methods & Properties }
    property TypeC: UnicodeString read Get_TypeC write Set_TypeC;
    property PaymentRecordPaymentEffectiveD: UnicodeString read Get_PaymentRecordPaymentEffectiveD write Set_PaymentRecordPaymentEffectiveD;
    property SuperannuationTaxFreeComponentA: UnicodeString read Get_SuperannuationTaxFreeComponentA write Set_SuperannuationTaxFreeComponentA;
    property SuperannuationEmploymentTerminationTaxableComponentTotalA: UnicodeString read Get_SuperannuationEmploymentTerminationTaxableComponentTotalA write Set_SuperannuationEmploymentTerminationTaxableComponentTotalA;
    property TaxWithheldA: UnicodeString read Get_TaxWithheldA write Set_TaxWithheldA;
  end;

{ IXMLUnusedAnnualOrLongServiceLeavePayment }

  IXMLUnusedAnnualOrLongServiceLeavePayment = interface(IXMLNode)
    ['{92F4D19E-7511-48B9-B269-5D80E89B2062}']
    { Property Accessors }
    function Get_LumpSumPaymentA: IXMLLumpSumPaymentA;
    function Get_LumpSumBA: UnicodeString;
    function Get_LumpSumDA: UnicodeString;
    function Get_LumpSumEA: UnicodeString;
    procedure Set_LumpSumBA(Value: UnicodeString);
    procedure Set_LumpSumDA(Value: UnicodeString);
    procedure Set_LumpSumEA(Value: UnicodeString);
    { Methods & Properties }
    property LumpSumPaymentA: IXMLLumpSumPaymentA read Get_LumpSumPaymentA;
    property LumpSumBA: UnicodeString read Get_LumpSumBA write Set_LumpSumBA;
    property LumpSumDA: UnicodeString read Get_LumpSumDA write Set_LumpSumDA;
    property LumpSumEA: UnicodeString read Get_LumpSumEA write Set_LumpSumEA;
  end;

{ IXMLLumpSumPaymentA }

  IXMLLumpSumPaymentA = interface(IXMLNode)
    ['{A589518A-3813-4C44-90DE-F70FD4BB92CC}']
    { Property Accessors }
    function Get_LumpSumAC: UnicodeString;
    function Get_LumpSumAA: UnicodeString;
    procedure Set_LumpSumAC(Value: UnicodeString);
    procedure Set_LumpSumAA(Value: UnicodeString);
    { Methods & Properties }
    property LumpSumAC: UnicodeString read Get_LumpSumAC write Set_LumpSumAC;
    property LumpSumAA: UnicodeString read Get_LumpSumAA write Set_LumpSumAA;
  end;

{ IXMLAllowanceCollection }

  IXMLAllowanceCollection = interface(IXMLNodeCollection)
    ['{FAA25AA0-F38B-465C-B39D-7F49DF8A42EE}']
    { Property Accessors }
    function Get_Allowance(Index: Integer): IXMLAllowance;
    { Methods & Properties }
    function Add: IXMLAllowance;
    function Insert(const Index: Integer): IXMLAllowance;
    property Allowance[Index: Integer]: IXMLAllowance read Get_Allowance; default;
  end;

{ IXMLAllowance }

  IXMLAllowance = interface(IXMLNode)
    ['{A53AFE25-3509-44A6-8A5B-D6FE8D9653FD}']
    { Property Accessors }
    function Get_TypeC: UnicodeString;
    function Get_OtherAllowanceTypeDe: UnicodeString;
    function Get_IndividualNonBusinessEmploymentAllowancesA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_OtherAllowanceTypeDe(Value: UnicodeString);
    procedure Set_IndividualNonBusinessEmploymentAllowancesA(Value: UnicodeString);
    { Methods & Properties }
    property TypeC: UnicodeString read Get_TypeC write Set_TypeC;
    property OtherAllowanceTypeDe: UnicodeString read Get_OtherAllowanceTypeDe write Set_OtherAllowanceTypeDe;
    property IndividualNonBusinessEmploymentAllowancesA: UnicodeString read Get_IndividualNonBusinessEmploymentAllowancesA write Set_IndividualNonBusinessEmploymentAllowancesA;
  end;

{ IXMLDeductionCollection }

  IXMLDeductionCollection = interface(IXMLNodeCollection)
    ['{6515D40B-39A4-4CF7-A460-F287DFA644DB}']
    { Property Accessors }
    function Get_Deduction(Index: Integer): IXMLDeduction;
    { Methods & Properties }
    function Add: IXMLDeduction;
    function Insert(const Index: Integer): IXMLDeduction;
    property Deduction[Index: Integer]: IXMLDeduction read Get_Deduction; default;
  end;

{ IXMLDeduction }

  IXMLDeduction = interface(IXMLNode)
    ['{7E91F35D-3DE5-4D28-9825-BB2E34435A47}']
    { Property Accessors }
    function Get_TypeC: UnicodeString;
    function Get_A: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_A(Value: UnicodeString);
    { Methods & Properties }
    property TypeC: UnicodeString read Get_TypeC write Set_TypeC;
    property A: UnicodeString read Get_A write Set_A;
  end;

{ IXMLSuperannuationContribution }

  IXMLSuperannuationContribution = interface(IXMLNode)
    ['{65049A50-04C8-445E-98B5-BDE64C35324B}']
    { Property Accessors }
    function Get_EmployerContributionsSuperannuationGuaranteeA: UnicodeString;
    function Get_OrdinaryTimeEarningsA: UnicodeString;
    function Get_EmployerReportableA: UnicodeString;
    procedure Set_EmployerContributionsSuperannuationGuaranteeA(Value: UnicodeString);
    procedure Set_OrdinaryTimeEarningsA(Value: UnicodeString);
    procedure Set_EmployerReportableA(Value: UnicodeString);
    { Methods & Properties }
    property EmployerContributionsSuperannuationGuaranteeA: UnicodeString read Get_EmployerContributionsSuperannuationGuaranteeA write Set_EmployerContributionsSuperannuationGuaranteeA;
    property OrdinaryTimeEarningsA: UnicodeString read Get_OrdinaryTimeEarningsA write Set_OrdinaryTimeEarningsA;
    property EmployerReportableA: UnicodeString read Get_EmployerReportableA write Set_EmployerReportableA;
  end;

{ IXMLIncomeFringeBenefitsReportable }

  IXMLIncomeFringeBenefitsReportable = interface(IXMLNode)
    ['{F6896707-F1E8-42A9-B13C-CFD3B6722931}']
    { Property Accessors }
    function Get_TaxableIncomeFringeBenefitsReportableA: UnicodeString;
    function Get_ExemptIncomeFringeBenefitsReportableA: UnicodeString;
    procedure Set_TaxableIncomeFringeBenefitsReportableA(Value: UnicodeString);
    procedure Set_ExemptIncomeFringeBenefitsReportableA(Value: UnicodeString);
    { Methods & Properties }
    property TaxableIncomeFringeBenefitsReportableA: UnicodeString read Get_TaxableIncomeFringeBenefitsReportableA write Set_TaxableIncomeFringeBenefitsReportableA;
    property ExemptIncomeFringeBenefitsReportableA: UnicodeString read Get_ExemptIncomeFringeBenefitsReportableA write Set_ExemptIncomeFringeBenefitsReportableA;
  end;

{ IXMLOnboarding }

  IXMLOnboarding = interface(IXMLNode)
    ['{9852667B-EDDD-42FC-AA2B-5E821C9E66EA}']
    { Property Accessors }
    function Get_TFND: IXMLTFND;
    function Get_Declaration: IXMLDeclaration;
    { Methods & Properties }
    property TFND: IXMLTFND read Get_TFND;
    property Declaration: IXMLDeclaration read Get_Declaration;
  end;

{ IXMLTFND }

  IXMLTFND = interface(IXMLNode)
    ['{DDE8E871-FE92-4BB5-A4EA-7ACEB7127031}']
    { Property Accessors }
    function Get_PaymentArrangementTerminationC: UnicodeString;
    function Get_ResidencyTaxPurposesPersonStatusC: UnicodeString;
    function Get_PaymentArrangementPaymentBasisC: UnicodeString;
    function Get_TaxOffsetClaimTaxFreeThresholdI: Boolean;
    function Get_IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI: Boolean;
    function Get_StudentLoanStudentFinancialSupplementSchemeI: Boolean;
    procedure Set_PaymentArrangementTerminationC(Value: UnicodeString);
    procedure Set_ResidencyTaxPurposesPersonStatusC(Value: UnicodeString);
    procedure Set_PaymentArrangementPaymentBasisC(Value: UnicodeString);
    procedure Set_TaxOffsetClaimTaxFreeThresholdI(Value: Boolean);
    procedure Set_IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI(Value: Boolean);
    procedure Set_StudentLoanStudentFinancialSupplementSchemeI(Value: Boolean);
    { Methods & Properties }
    property PaymentArrangementTerminationC: UnicodeString read Get_PaymentArrangementTerminationC write Set_PaymentArrangementTerminationC;
    property ResidencyTaxPurposesPersonStatusC: UnicodeString read Get_ResidencyTaxPurposesPersonStatusC write Set_ResidencyTaxPurposesPersonStatusC;
    property PaymentArrangementPaymentBasisC: UnicodeString read Get_PaymentArrangementPaymentBasisC write Set_PaymentArrangementPaymentBasisC;
    property TaxOffsetClaimTaxFreeThresholdI: Boolean read Get_TaxOffsetClaimTaxFreeThresholdI write Set_TaxOffsetClaimTaxFreeThresholdI;
    property IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI: Boolean read Get_IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI write Set_IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI;
    property StudentLoanStudentFinancialSupplementSchemeI: Boolean read Get_StudentLoanStudentFinancialSupplementSchemeI write Set_StudentLoanStudentFinancialSupplementSchemeI;
  end;

{ IXMLDeclaration }

  IXMLDeclaration = interface(IXMLNode)
    ['{77882147-1542-476D-AD2F-0F39C0B2BDEE}']
    { Property Accessors }
    function Get_StatementAcceptedI: Boolean;
    function Get_SignatureD: UnicodeString;
    procedure Set_StatementAcceptedI(Value: Boolean);
    procedure Set_SignatureD(Value: UnicodeString);
    { Methods & Properties }
    property StatementAcceptedI: Boolean read Get_StatementAcceptedI write Set_StatementAcceptedI;
    property SignatureD: UnicodeString read Get_SignatureD write Set_SignatureD;
  end;

{ Forward Decls }

  TXMLPAYEVNTEMP = class;
  TXMLPayee = class;
  TXMLIdentifiers = class;
  TXMLPersonNameDetails = class;
  TXMLPersonDemographicDetails = class;
  TXMLAddressDetails = class;
  TXMLElectronicContact = class;
  TXMLEmployerConditions = class;
  TXMLRemunerationIncomeTaxPayAsYouGoWithholding = class;
  TXMLPayrollPeriod = class;
  TXMLIndividualNonBusiness = class;
  TXMLVoluntaryAgreement = class;
  TXMLLabourHireArrangementPayment = class;
  TXMLSpecifiedByRegulationPayment = class;
  TXMLJointPetroleumDevelopmentAreaPayment = class;
  TXMLWorkingHolidayMaker = class;
  TXMLPaymentToForeignResident = class;
  TXMLEmploymentTerminationPaymentCollection = class;
  TXMLEmploymentTerminationPayment = class;
  TXMLUnusedAnnualOrLongServiceLeavePayment = class;
  TXMLLumpSumPaymentA = class;
  TXMLAllowanceCollection = class;
  TXMLAllowance = class;
  TXMLDeductionCollection = class;
  TXMLDeduction = class;
  TXMLSuperannuationContribution = class;
  TXMLIncomeFringeBenefitsReportable = class;
  TXMLOnboarding = class;
  TXMLTFND = class;
  TXMLDeclaration = class;

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
    function Get_PersonDemographicDetails: IXMLPersonDemographicDetails;
    function Get_AddressDetails: IXMLAddressDetails;
    function Get_ElectronicContact: IXMLElectronicContact;
    function Get_EmployerConditions: IXMLEmployerConditions;
    function Get_RemunerationIncomeTaxPayAsYouGoWithholding: IXMLRemunerationIncomeTaxPayAsYouGoWithholding;
    function Get_Onboarding: IXMLOnboarding;
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
    procedure Set_TaxFileNumberId(Value: UnicodeString);
    procedure Set_AustralianBusinessNumberId(Value: UnicodeString);
    procedure Set_EmploymentPayrollNumberId(Value: UnicodeString);
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

{ TXMLPersonDemographicDetails }

  TXMLPersonDemographicDetails = class(TXMLNode, IXMLPersonDemographicDetails)
  protected
    { IXMLPersonDemographicDetails }
    function Get_BirthDm: Integer;
    function Get_BirthM: Integer;
    function Get_BirthY: Integer;
    procedure Set_BirthDm(Value: Integer);
    procedure Set_BirthM(Value: Integer);
    procedure Set_BirthY(Value: Integer);
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
    procedure Set_EmploymentStartD(Value: UnicodeString);
    procedure Set_EmploymentEndD(Value: UnicodeString);
  end;

{ TXMLRemunerationIncomeTaxPayAsYouGoWithholding }

  TXMLRemunerationIncomeTaxPayAsYouGoWithholding = class(TXMLNode, IXMLRemunerationIncomeTaxPayAsYouGoWithholding)
  protected
    { IXMLRemunerationIncomeTaxPayAsYouGoWithholding }
    function Get_PayrollPeriod: IXMLPayrollPeriod;
    function Get_IndividualNonBusiness: IXMLIndividualNonBusiness;
    function Get_VoluntaryAgreement: IXMLVoluntaryAgreement;
    function Get_LabourHireArrangementPayment: IXMLLabourHireArrangementPayment;
    function Get_SpecifiedByRegulationPayment: IXMLSpecifiedByRegulationPayment;
    function Get_JointPetroleumDevelopmentAreaPayment: IXMLJointPetroleumDevelopmentAreaPayment;
    function Get_WorkingHolidayMaker: IXMLWorkingHolidayMaker;
    function Get_PaymentToForeignResident: IXMLPaymentToForeignResident;
    function Get_EmploymentTerminationPaymentCollection: IXMLEmploymentTerminationPaymentCollection;
    function Get_UnusedAnnualOrLongServiceLeavePayment: IXMLUnusedAnnualOrLongServiceLeavePayment;
    function Get_AllowanceCollection: IXMLAllowanceCollection;
    function Get_DeductionCollection: IXMLDeductionCollection;
    function Get_SuperannuationContribution: IXMLSuperannuationContribution;
    function Get_IncomeFringeBenefitsReportable: IXMLIncomeFringeBenefitsReportable;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPayrollPeriod }

  TXMLPayrollPeriod = class(TXMLNode, IXMLPayrollPeriod)
  protected
    { IXMLPayrollPeriod }
    function Get_StartD: UnicodeString;
    function Get_EndD: UnicodeString;
    function Get_PayrollEventFinalI: Boolean;
    procedure Set_StartD(Value: UnicodeString);
    procedure Set_EndD(Value: UnicodeString);
    procedure Set_PayrollEventFinalI(Value: Boolean);
  end;

{ TXMLIndividualNonBusiness }

  TXMLIndividualNonBusiness = class(TXMLNode, IXMLIndividualNonBusiness)
  protected
    { IXMLIndividualNonBusiness }
    function Get_GrossA: UnicodeString;
    function Get_CommunityDevelopmentEmploymentProjectA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    function Get_ExemptForeignEmploymentIncomeA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_CommunityDevelopmentEmploymentProjectA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
    procedure Set_ExemptForeignEmploymentIncomeA(Value: UnicodeString);
  end;

{ TXMLVoluntaryAgreement }

  TXMLVoluntaryAgreement = class(TXMLNode, IXMLVoluntaryAgreement)
  protected
    { IXMLVoluntaryAgreement }
    function Get_GrossA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
  end;

{ TXMLLabourHireArrangementPayment }

  TXMLLabourHireArrangementPayment = class(TXMLNode, IXMLLabourHireArrangementPayment)
  protected
    { IXMLLabourHireArrangementPayment }
    function Get_GrossA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
  end;

{ TXMLSpecifiedByRegulationPayment }

  TXMLSpecifiedByRegulationPayment = class(TXMLNode, IXMLSpecifiedByRegulationPayment)
  protected
    { IXMLSpecifiedByRegulationPayment }
    function Get_GrossA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
  end;

{ TXMLJointPetroleumDevelopmentAreaPayment }

  TXMLJointPetroleumDevelopmentAreaPayment = class(TXMLNode, IXMLJointPetroleumDevelopmentAreaPayment)
  protected
    { IXMLJointPetroleumDevelopmentAreaPayment }
    function Get_A: UnicodeString;
    function Get_ForeignWithholdingA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_A(Value: UnicodeString);
    procedure Set_ForeignWithholdingA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
  end;

{ TXMLWorkingHolidayMaker }

  TXMLWorkingHolidayMaker = class(TXMLNode, IXMLWorkingHolidayMaker)
  protected
    { IXMLWorkingHolidayMaker }
    function Get_GrossA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
  end;

{ TXMLPaymentToForeignResident }

  TXMLPaymentToForeignResident = class(TXMLNode, IXMLPaymentToForeignResident)
  protected
    { IXMLPaymentToForeignResident }
    function Get_GrossA: UnicodeString;
    function Get_ForeignWithholdingA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_GrossA(Value: UnicodeString);
    procedure Set_ForeignWithholdingA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
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
    function Get_TypeC: UnicodeString;
    function Get_PaymentRecordPaymentEffectiveD: UnicodeString;
    function Get_SuperannuationTaxFreeComponentA: UnicodeString;
    function Get_SuperannuationEmploymentTerminationTaxableComponentTotalA: UnicodeString;
    function Get_TaxWithheldA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_PaymentRecordPaymentEffectiveD(Value: UnicodeString);
    procedure Set_SuperannuationTaxFreeComponentA(Value: UnicodeString);
    procedure Set_SuperannuationEmploymentTerminationTaxableComponentTotalA(Value: UnicodeString);
    procedure Set_TaxWithheldA(Value: UnicodeString);
  end;

{ TXMLUnusedAnnualOrLongServiceLeavePayment }

  TXMLUnusedAnnualOrLongServiceLeavePayment = class(TXMLNode, IXMLUnusedAnnualOrLongServiceLeavePayment)
  protected
    { IXMLUnusedAnnualOrLongServiceLeavePayment }
    function Get_LumpSumPaymentA: IXMLLumpSumPaymentA;
    function Get_LumpSumBA: UnicodeString;
    function Get_LumpSumDA: UnicodeString;
    function Get_LumpSumEA: UnicodeString;
    procedure Set_LumpSumBA(Value: UnicodeString);
    procedure Set_LumpSumDA(Value: UnicodeString);
    procedure Set_LumpSumEA(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLumpSumPaymentA }

  TXMLLumpSumPaymentA = class(TXMLNode, IXMLLumpSumPaymentA)
  protected
    { IXMLLumpSumPaymentA }
    function Get_LumpSumAC: UnicodeString;
    function Get_LumpSumAA: UnicodeString;
    procedure Set_LumpSumAC(Value: UnicodeString);
    procedure Set_LumpSumAA(Value: UnicodeString);
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
    function Get_IndividualNonBusinessEmploymentAllowancesA: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_OtherAllowanceTypeDe(Value: UnicodeString);
    procedure Set_IndividualNonBusinessEmploymentAllowancesA(Value: UnicodeString);
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
    function Get_TypeC: UnicodeString;
    function Get_A: UnicodeString;
    procedure Set_TypeC(Value: UnicodeString);
    procedure Set_A(Value: UnicodeString);
  end;

{ TXMLSuperannuationContribution }

  TXMLSuperannuationContribution = class(TXMLNode, IXMLSuperannuationContribution)
  protected
    { IXMLSuperannuationContribution }
    function Get_EmployerContributionsSuperannuationGuaranteeA: UnicodeString;
    function Get_OrdinaryTimeEarningsA: UnicodeString;
    function Get_EmployerReportableA: UnicodeString;
    procedure Set_EmployerContributionsSuperannuationGuaranteeA(Value: UnicodeString);
    procedure Set_OrdinaryTimeEarningsA(Value: UnicodeString);
    procedure Set_EmployerReportableA(Value: UnicodeString);
  end;

{ TXMLIncomeFringeBenefitsReportable }

  TXMLIncomeFringeBenefitsReportable = class(TXMLNode, IXMLIncomeFringeBenefitsReportable)
  protected
    { IXMLIncomeFringeBenefitsReportable }
    function Get_TaxableIncomeFringeBenefitsReportableA: UnicodeString;
    function Get_ExemptIncomeFringeBenefitsReportableA: UnicodeString;
    procedure Set_TaxableIncomeFringeBenefitsReportableA(Value: UnicodeString);
    procedure Set_ExemptIncomeFringeBenefitsReportableA(Value: UnicodeString);
  end;

{ TXMLOnboarding }

  TXMLOnboarding = class(TXMLNode, IXMLOnboarding)
  protected
    { IXMLOnboarding }
    function Get_TFND: IXMLTFND;
    function Get_Declaration: IXMLDeclaration;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTFND }

  TXMLTFND = class(TXMLNode, IXMLTFND)
  protected
    { IXMLTFND }
    function Get_PaymentArrangementTerminationC: UnicodeString;
    function Get_ResidencyTaxPurposesPersonStatusC: UnicodeString;
    function Get_PaymentArrangementPaymentBasisC: UnicodeString;
    function Get_TaxOffsetClaimTaxFreeThresholdI: Boolean;
    function Get_IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI: Boolean;
    function Get_StudentLoanStudentFinancialSupplementSchemeI: Boolean;
    procedure Set_PaymentArrangementTerminationC(Value: UnicodeString);
    procedure Set_ResidencyTaxPurposesPersonStatusC(Value: UnicodeString);
    procedure Set_PaymentArrangementPaymentBasisC(Value: UnicodeString);
    procedure Set_TaxOffsetClaimTaxFreeThresholdI(Value: Boolean);
    procedure Set_IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI(Value: Boolean);
    procedure Set_StudentLoanStudentFinancialSupplementSchemeI(Value: Boolean);
  end;

{ TXMLDeclaration }

  TXMLDeclaration = class(TXMLNode, IXMLDeclaration)
  protected
    { IXMLDeclaration }
    function Get_StatementAcceptedI: Boolean;
    function Get_SignatureD: UnicodeString;
    procedure Set_StatementAcceptedI(Value: Boolean);
    procedure Set_SignatureD(Value: UnicodeString);
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
  RegisterChildNode('PersonDemographicDetails', TXMLPersonDemographicDetails);
  RegisterChildNode('AddressDetails', TXMLAddressDetails);
  RegisterChildNode('ElectronicContact', TXMLElectronicContact);
  RegisterChildNode('EmployerConditions', TXMLEmployerConditions);
  RegisterChildNode('RemunerationIncomeTaxPayAsYouGoWithholding', TXMLRemunerationIncomeTaxPayAsYouGoWithholding);
  RegisterChildNode('Onboarding', TXMLOnboarding);
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

function TXMLPayee.Get_PersonDemographicDetails: IXMLPersonDemographicDetails;
begin
  Result := ChildNodes['PersonDemographicDetails'] as IXMLPersonDemographicDetails;
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

function TXMLPayee.Get_RemunerationIncomeTaxPayAsYouGoWithholding: IXMLRemunerationIncomeTaxPayAsYouGoWithholding;
begin
  Result := ChildNodes['RemunerationIncomeTaxPayAsYouGoWithholding'] as IXMLRemunerationIncomeTaxPayAsYouGoWithholding;
end;

function TXMLPayee.Get_Onboarding: IXMLOnboarding;
begin
  Result := ChildNodes['Onboarding'] as IXMLOnboarding;
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

{ TXMLPersonDemographicDetails }

function TXMLPersonDemographicDetails.Get_BirthDm: Integer;
begin
  Result := ChildNodes['BirthDm'].NodeValue;
end;

procedure TXMLPersonDemographicDetails.Set_BirthDm(Value: Integer);
begin
  ChildNodes['BirthDm'].NodeValue := Value;
end;

function TXMLPersonDemographicDetails.Get_BirthM: Integer;
begin
  Result := ChildNodes['BirthM'].NodeValue;
end;

procedure TXMLPersonDemographicDetails.Set_BirthM(Value: Integer);
begin
  ChildNodes['BirthM'].NodeValue := Value;
end;

function TXMLPersonDemographicDetails.Get_BirthY: Integer;
begin
  Result := ChildNodes['BirthY'].NodeValue;
end;

procedure TXMLPersonDemographicDetails.Set_BirthY(Value: Integer);
begin
  ChildNodes['BirthY'].NodeValue := Value;
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

{ TXMLRemunerationIncomeTaxPayAsYouGoWithholding }

procedure TXMLRemunerationIncomeTaxPayAsYouGoWithholding.AfterConstruction;
begin
  RegisterChildNode('PayrollPeriod', TXMLPayrollPeriod);
  RegisterChildNode('IndividualNonBusiness', TXMLIndividualNonBusiness);
  RegisterChildNode('VoluntaryAgreement', TXMLVoluntaryAgreement);
  RegisterChildNode('LabourHireArrangementPayment', TXMLLabourHireArrangementPayment);
  RegisterChildNode('SpecifiedByRegulationPayment', TXMLSpecifiedByRegulationPayment);
  RegisterChildNode('JointPetroleumDevelopmentAreaPayment', TXMLJointPetroleumDevelopmentAreaPayment);
  RegisterChildNode('WorkingHolidayMaker', TXMLWorkingHolidayMaker);
  RegisterChildNode('PaymentToForeignResident', TXMLPaymentToForeignResident);
  RegisterChildNode('EmploymentTerminationPaymentCollection', TXMLEmploymentTerminationPaymentCollection);
  RegisterChildNode('UnusedAnnualOrLongServiceLeavePayment', TXMLUnusedAnnualOrLongServiceLeavePayment);
  RegisterChildNode('AllowanceCollection', TXMLAllowanceCollection);
  RegisterChildNode('DeductionCollection', TXMLDeductionCollection);
  RegisterChildNode('SuperannuationContribution', TXMLSuperannuationContribution);
  RegisterChildNode('IncomeFringeBenefitsReportable', TXMLIncomeFringeBenefitsReportable);
  inherited;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_PayrollPeriod: IXMLPayrollPeriod;
begin
  Result := ChildNodes['PayrollPeriod'] as IXMLPayrollPeriod;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_IndividualNonBusiness: IXMLIndividualNonBusiness;
begin
  Result := ChildNodes['IndividualNonBusiness'] as IXMLIndividualNonBusiness;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_VoluntaryAgreement: IXMLVoluntaryAgreement;
begin
  Result := ChildNodes['VoluntaryAgreement'] as IXMLVoluntaryAgreement;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_LabourHireArrangementPayment: IXMLLabourHireArrangementPayment;
begin
  Result := ChildNodes['LabourHireArrangementPayment'] as IXMLLabourHireArrangementPayment;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_SpecifiedByRegulationPayment: IXMLSpecifiedByRegulationPayment;
begin
  Result := ChildNodes['SpecifiedByRegulationPayment'] as IXMLSpecifiedByRegulationPayment;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_JointPetroleumDevelopmentAreaPayment: IXMLJointPetroleumDevelopmentAreaPayment;
begin
  Result := ChildNodes['JointPetroleumDevelopmentAreaPayment'] as IXMLJointPetroleumDevelopmentAreaPayment;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_WorkingHolidayMaker: IXMLWorkingHolidayMaker;
begin
  Result := ChildNodes['WorkingHolidayMaker'] as IXMLWorkingHolidayMaker;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_PaymentToForeignResident: IXMLPaymentToForeignResident;
begin
  Result := ChildNodes['PaymentToForeignResident'] as IXMLPaymentToForeignResident;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_EmploymentTerminationPaymentCollection: IXMLEmploymentTerminationPaymentCollection;
begin
  Result := ChildNodes['EmploymentTerminationPaymentCollection'] as IXMLEmploymentTerminationPaymentCollection;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_UnusedAnnualOrLongServiceLeavePayment: IXMLUnusedAnnualOrLongServiceLeavePayment;
begin
  Result := ChildNodes['UnusedAnnualOrLongServiceLeavePayment'] as IXMLUnusedAnnualOrLongServiceLeavePayment;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_AllowanceCollection: IXMLAllowanceCollection;
begin
  Result := ChildNodes['AllowanceCollection'] as IXMLAllowanceCollection;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_DeductionCollection: IXMLDeductionCollection;
begin
  Result := ChildNodes['DeductionCollection'] as IXMLDeductionCollection;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_SuperannuationContribution: IXMLSuperannuationContribution;
begin
  Result := ChildNodes['SuperannuationContribution'] as IXMLSuperannuationContribution;
end;

function TXMLRemunerationIncomeTaxPayAsYouGoWithholding.Get_IncomeFringeBenefitsReportable: IXMLIncomeFringeBenefitsReportable;
begin
  Result := ChildNodes['IncomeFringeBenefitsReportable'] as IXMLIncomeFringeBenefitsReportable;
end;

{ TXMLPayrollPeriod }

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

function TXMLPayrollPeriod.Get_PayrollEventFinalI: Boolean;
begin
  Result := ChildNodes['PayrollEventFinalI'].NodeValue;
end;

procedure TXMLPayrollPeriod.Set_PayrollEventFinalI(Value: Boolean);
begin
  ChildNodes['PayrollEventFinalI'].NodeValue := Value;
end;

{ TXMLIndividualNonBusiness }

function TXMLIndividualNonBusiness.Get_GrossA: UnicodeString;
begin
  Result := ChildNodes['GrossA'].Text;
end;

procedure TXMLIndividualNonBusiness.Set_GrossA(Value: UnicodeString);
begin
  ChildNodes['GrossA'].NodeValue := Value;
end;

function TXMLIndividualNonBusiness.Get_CommunityDevelopmentEmploymentProjectA: UnicodeString;
begin
  Result := ChildNodes['CommunityDevelopmentEmploymentProjectA'].Text;
end;

procedure TXMLIndividualNonBusiness.Set_CommunityDevelopmentEmploymentProjectA(Value: UnicodeString);
begin
  ChildNodes['CommunityDevelopmentEmploymentProjectA'].NodeValue := Value;
end;

function TXMLIndividualNonBusiness.Get_TaxWithheldA: UnicodeString;
begin
  Result := ChildNodes['TaxWithheldA'].Text;
end;

procedure TXMLIndividualNonBusiness.Set_TaxWithheldA(Value: UnicodeString);
begin
  ChildNodes['TaxWithheldA'].NodeValue := Value;
end;

function TXMLIndividualNonBusiness.Get_ExemptForeignEmploymentIncomeA: UnicodeString;
begin
  Result := ChildNodes['ExemptForeignEmploymentIncomeA'].Text;
end;

procedure TXMLIndividualNonBusiness.Set_ExemptForeignEmploymentIncomeA(Value: UnicodeString);
begin
  ChildNodes['ExemptForeignEmploymentIncomeA'].NodeValue := Value;
end;

{ TXMLVoluntaryAgreement }

function TXMLVoluntaryAgreement.Get_GrossA: UnicodeString;
begin
  Result := ChildNodes['GrossA'].Text;
end;

procedure TXMLVoluntaryAgreement.Set_GrossA(Value: UnicodeString);
begin
  ChildNodes['GrossA'].NodeValue := Value;
end;

function TXMLVoluntaryAgreement.Get_TaxWithheldA: UnicodeString;
begin
  Result := ChildNodes['TaxWithheldA'].Text;
end;

procedure TXMLVoluntaryAgreement.Set_TaxWithheldA(Value: UnicodeString);
begin
  ChildNodes['TaxWithheldA'].NodeValue := Value;
end;

{ TXMLLabourHireArrangementPayment }

function TXMLLabourHireArrangementPayment.Get_GrossA: UnicodeString;
begin
  Result := ChildNodes['GrossA'].Text;
end;

procedure TXMLLabourHireArrangementPayment.Set_GrossA(Value: UnicodeString);
begin
  ChildNodes['GrossA'].NodeValue := Value;
end;

function TXMLLabourHireArrangementPayment.Get_TaxWithheldA: UnicodeString;
begin
  Result := ChildNodes['TaxWithheldA'].Text;
end;

procedure TXMLLabourHireArrangementPayment.Set_TaxWithheldA(Value: UnicodeString);
begin
  ChildNodes['TaxWithheldA'].NodeValue := Value;
end;

{ TXMLSpecifiedByRegulationPayment }

function TXMLSpecifiedByRegulationPayment.Get_GrossA: UnicodeString;
begin
  Result := ChildNodes['GrossA'].Text;
end;

procedure TXMLSpecifiedByRegulationPayment.Set_GrossA(Value: UnicodeString);
begin
  ChildNodes['GrossA'].NodeValue := Value;
end;

function TXMLSpecifiedByRegulationPayment.Get_TaxWithheldA: UnicodeString;
begin
  Result := ChildNodes['TaxWithheldA'].Text;
end;

procedure TXMLSpecifiedByRegulationPayment.Set_TaxWithheldA(Value: UnicodeString);
begin
  ChildNodes['TaxWithheldA'].NodeValue := Value;
end;

{ TXMLJointPetroleumDevelopmentAreaPayment }

function TXMLJointPetroleumDevelopmentAreaPayment.Get_A: UnicodeString;
begin
  Result := ChildNodes[WideString('A')].Text;
end;

procedure TXMLJointPetroleumDevelopmentAreaPayment.Set_A(Value: UnicodeString);
begin
  ChildNodes[WideString('A')].NodeValue := Value;
end;

function TXMLJointPetroleumDevelopmentAreaPayment.Get_ForeignWithholdingA: UnicodeString;
begin
  Result := ChildNodes['ForeignWithholdingA'].Text;
end;

procedure TXMLJointPetroleumDevelopmentAreaPayment.Set_ForeignWithholdingA(Value: UnicodeString);
begin
  ChildNodes['ForeignWithholdingA'].NodeValue := Value;
end;

function TXMLJointPetroleumDevelopmentAreaPayment.Get_TaxWithheldA: UnicodeString;
begin
  Result := ChildNodes['TaxWithheldA'].Text;
end;

procedure TXMLJointPetroleumDevelopmentAreaPayment.Set_TaxWithheldA(Value: UnicodeString);
begin
  ChildNodes['TaxWithheldA'].NodeValue := Value;
end;

{ TXMLWorkingHolidayMaker }

function TXMLWorkingHolidayMaker.Get_GrossA: UnicodeString;
begin
  Result := ChildNodes['GrossA'].Text;
end;

procedure TXMLWorkingHolidayMaker.Set_GrossA(Value: UnicodeString);
begin
  ChildNodes['GrossA'].NodeValue := Value;
end;

function TXMLWorkingHolidayMaker.Get_TaxWithheldA: UnicodeString;
begin
  Result := ChildNodes['TaxWithheldA'].Text;
end;

procedure TXMLWorkingHolidayMaker.Set_TaxWithheldA(Value: UnicodeString);
begin
  ChildNodes['TaxWithheldA'].NodeValue := Value;
end;

{ TXMLPaymentToForeignResident }

function TXMLPaymentToForeignResident.Get_GrossA: UnicodeString;
begin
  Result := ChildNodes['GrossA'].Text;
end;

procedure TXMLPaymentToForeignResident.Set_GrossA(Value: UnicodeString);
begin
  ChildNodes['GrossA'].NodeValue := Value;
end;

function TXMLPaymentToForeignResident.Get_ForeignWithholdingA: UnicodeString;
begin
  Result := ChildNodes['ForeignWithholdingA'].Text;
end;

procedure TXMLPaymentToForeignResident.Set_ForeignWithholdingA(Value: UnicodeString);
begin
  ChildNodes['ForeignWithholdingA'].NodeValue := Value;
end;

function TXMLPaymentToForeignResident.Get_TaxWithheldA: UnicodeString;
begin
  Result := ChildNodes['TaxWithheldA'].Text;
end;

procedure TXMLPaymentToForeignResident.Set_TaxWithheldA(Value: UnicodeString);
begin
  ChildNodes['TaxWithheldA'].NodeValue := Value;
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

function TXMLEmploymentTerminationPayment.Get_TypeC: UnicodeString;
begin
  Result := ChildNodes['TypeC'].Text;
end;

procedure TXMLEmploymentTerminationPayment.Set_TypeC(Value: UnicodeString);
begin
  ChildNodes['TypeC'].NodeValue := Value;
end;

function TXMLEmploymentTerminationPayment.Get_PaymentRecordPaymentEffectiveD: UnicodeString;
begin
  Result := ChildNodes['PaymentRecordPaymentEffectiveD'].Text;
end;

procedure TXMLEmploymentTerminationPayment.Set_PaymentRecordPaymentEffectiveD(Value: UnicodeString);
begin
  ChildNodes['PaymentRecordPaymentEffectiveD'].NodeValue := Value;
end;

function TXMLEmploymentTerminationPayment.Get_SuperannuationTaxFreeComponentA: UnicodeString;
begin
  Result := ChildNodes['SuperannuationTaxFreeComponentA'].Text;
end;

procedure TXMLEmploymentTerminationPayment.Set_SuperannuationTaxFreeComponentA(Value: UnicodeString);
begin
  ChildNodes['SuperannuationTaxFreeComponentA'].NodeValue := Value;
end;

function TXMLEmploymentTerminationPayment.Get_SuperannuationEmploymentTerminationTaxableComponentTotalA: UnicodeString;
begin
  Result := ChildNodes['SuperannuationEmploymentTerminationTaxableComponentTotalA'].Text;
end;

procedure TXMLEmploymentTerminationPayment.Set_SuperannuationEmploymentTerminationTaxableComponentTotalA(Value: UnicodeString);
begin
  ChildNodes['SuperannuationEmploymentTerminationTaxableComponentTotalA'].NodeValue := Value;
end;

function TXMLEmploymentTerminationPayment.Get_TaxWithheldA: UnicodeString;
begin
  Result := ChildNodes['TaxWithheldA'].Text;
end;

procedure TXMLEmploymentTerminationPayment.Set_TaxWithheldA(Value: UnicodeString);
begin
  ChildNodes['TaxWithheldA'].NodeValue := Value;
end;

{ TXMLUnusedAnnualOrLongServiceLeavePayment }

procedure TXMLUnusedAnnualOrLongServiceLeavePayment.AfterConstruction;
begin
  RegisterChildNode('LumpSumPaymentA', TXMLLumpSumPaymentA);
  inherited;
end;

function TXMLUnusedAnnualOrLongServiceLeavePayment.Get_LumpSumPaymentA: IXMLLumpSumPaymentA;
begin
  Result := ChildNodes['LumpSumPaymentA'] as IXMLLumpSumPaymentA;
end;

function TXMLUnusedAnnualOrLongServiceLeavePayment.Get_LumpSumBA: UnicodeString;
begin
  Result := ChildNodes['LumpSumBA'].Text;
end;

procedure TXMLUnusedAnnualOrLongServiceLeavePayment.Set_LumpSumBA(Value: UnicodeString);
begin
  ChildNodes['LumpSumBA'].NodeValue := Value;
end;

function TXMLUnusedAnnualOrLongServiceLeavePayment.Get_LumpSumDA: UnicodeString;
begin
  Result := ChildNodes['LumpSumDA'].Text;
end;

procedure TXMLUnusedAnnualOrLongServiceLeavePayment.Set_LumpSumDA(Value: UnicodeString);
begin
  ChildNodes['LumpSumDA'].NodeValue := Value;
end;

function TXMLUnusedAnnualOrLongServiceLeavePayment.Get_LumpSumEA: UnicodeString;
begin
  Result := ChildNodes['LumpSumEA'].Text;
end;

procedure TXMLUnusedAnnualOrLongServiceLeavePayment.Set_LumpSumEA(Value: UnicodeString);
begin
  ChildNodes['LumpSumEA'].NodeValue := Value;
end;

{ TXMLLumpSumPaymentA }

function TXMLLumpSumPaymentA.Get_LumpSumAC: UnicodeString;
begin
  Result := ChildNodes['LumpSumAC'].Text;
end;

procedure TXMLLumpSumPaymentA.Set_LumpSumAC(Value: UnicodeString);
begin
  ChildNodes['LumpSumAC'].NodeValue := Value;
end;

function TXMLLumpSumPaymentA.Get_LumpSumAA: UnicodeString;
begin
  Result := ChildNodes['LumpSumAA'].Text;
end;

procedure TXMLLumpSumPaymentA.Set_LumpSumAA(Value: UnicodeString);
begin
  ChildNodes['LumpSumAA'].NodeValue := Value;
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

function TXMLAllowance.Get_IndividualNonBusinessEmploymentAllowancesA: UnicodeString;
begin
  Result := ChildNodes['IndividualNonBusinessEmploymentAllowancesA'].Text;
end;

procedure TXMLAllowance.Set_IndividualNonBusinessEmploymentAllowancesA(Value: UnicodeString);
begin
  ChildNodes['IndividualNonBusinessEmploymentAllowancesA'].NodeValue := Value;
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

function TXMLDeduction.Get_TypeC: UnicodeString;
begin
  Result := ChildNodes['TypeC'].Text;
end;

procedure TXMLDeduction.Set_TypeC(Value: UnicodeString);
begin
  ChildNodes['TypeC'].NodeValue := Value;
end;

function TXMLDeduction.Get_A: UnicodeString;
begin
  Result := ChildNodes[WideString('A')].Text;
end;

procedure TXMLDeduction.Set_A(Value: UnicodeString);
begin
  ChildNodes[WideString('A')].NodeValue := Value;
end;

{ TXMLSuperannuationContribution }

function TXMLSuperannuationContribution.Get_EmployerContributionsSuperannuationGuaranteeA: UnicodeString;
begin
  Result := ChildNodes['EmployerContributionsSuperannuationGuaranteeA'].Text;
end;

procedure TXMLSuperannuationContribution.Set_EmployerContributionsSuperannuationGuaranteeA(Value: UnicodeString);
begin
  ChildNodes['EmployerContributionsSuperannuationGuaranteeA'].NodeValue := Value;
end;

function TXMLSuperannuationContribution.Get_OrdinaryTimeEarningsA: UnicodeString;
begin
  Result := ChildNodes['OrdinaryTimeEarningsA'].Text;
end;

procedure TXMLSuperannuationContribution.Set_OrdinaryTimeEarningsA(Value: UnicodeString);
begin
  ChildNodes['OrdinaryTimeEarningsA'].NodeValue := Value;
end;

function TXMLSuperannuationContribution.Get_EmployerReportableA: UnicodeString;
begin
  Result := ChildNodes['EmployerReportableA'].Text;
end;

procedure TXMLSuperannuationContribution.Set_EmployerReportableA(Value: UnicodeString);
begin
  ChildNodes['EmployerReportableA'].NodeValue := Value;
end;

{ TXMLIncomeFringeBenefitsReportable }

function TXMLIncomeFringeBenefitsReportable.Get_TaxableIncomeFringeBenefitsReportableA: UnicodeString;
begin
  Result := ChildNodes['TaxableIncomeFringeBenefitsReportableA'].Text;
end;

procedure TXMLIncomeFringeBenefitsReportable.Set_TaxableIncomeFringeBenefitsReportableA(Value: UnicodeString);
begin
  ChildNodes['TaxableIncomeFringeBenefitsReportableA'].NodeValue := Value;
end;

function TXMLIncomeFringeBenefitsReportable.Get_ExemptIncomeFringeBenefitsReportableA: UnicodeString;
begin
  Result := ChildNodes['ExemptIncomeFringeBenefitsReportableA'].Text;
end;

procedure TXMLIncomeFringeBenefitsReportable.Set_ExemptIncomeFringeBenefitsReportableA(Value: UnicodeString);
begin
  ChildNodes['ExemptIncomeFringeBenefitsReportableA'].NodeValue := Value;
end;

{ TXMLOnboarding }

procedure TXMLOnboarding.AfterConstruction;
begin
  RegisterChildNode('TFND', TXMLTFND);
  RegisterChildNode('Declaration', TXMLDeclaration);
  inherited;
end;

function TXMLOnboarding.Get_TFND: IXMLTFND;
begin
  Result := ChildNodes['TFND'] as IXMLTFND;
end;

function TXMLOnboarding.Get_Declaration: IXMLDeclaration;
begin
  Result := ChildNodes['Declaration'] as IXMLDeclaration;
end;

{ TXMLTFND }

function TXMLTFND.Get_PaymentArrangementTerminationC: UnicodeString;
begin
  Result := ChildNodes['PaymentArrangementTerminationC'].Text;
end;

procedure TXMLTFND.Set_PaymentArrangementTerminationC(Value: UnicodeString);
begin
  ChildNodes['PaymentArrangementTerminationC'].NodeValue := Value;
end;

function TXMLTFND.Get_ResidencyTaxPurposesPersonStatusC: UnicodeString;
begin
  Result := ChildNodes['ResidencyTaxPurposesPersonStatusC'].Text;
end;

procedure TXMLTFND.Set_ResidencyTaxPurposesPersonStatusC(Value: UnicodeString);
begin
  ChildNodes['ResidencyTaxPurposesPersonStatusC'].NodeValue := Value;
end;

function TXMLTFND.Get_PaymentArrangementPaymentBasisC: UnicodeString;
begin
  Result := ChildNodes['PaymentArrangementPaymentBasisC'].Text;
end;

procedure TXMLTFND.Set_PaymentArrangementPaymentBasisC(Value: UnicodeString);
begin
  ChildNodes['PaymentArrangementPaymentBasisC'].NodeValue := Value;
end;

function TXMLTFND.Get_TaxOffsetClaimTaxFreeThresholdI: Boolean;
begin
  Result := ChildNodes['TaxOffsetClaimTaxFreeThresholdI'].NodeValue;
end;

procedure TXMLTFND.Set_TaxOffsetClaimTaxFreeThresholdI(Value: Boolean);
begin
  ChildNodes['TaxOffsetClaimTaxFreeThresholdI'].NodeValue := Value;
end;

function TXMLTFND.Get_IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI: Boolean;
begin
  Result := ChildNodes['IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI'].NodeValue;
end;

procedure TXMLTFND.Set_IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI(Value: Boolean);
begin
  ChildNodes['IncomeTaxPayAsYouGoWithholdingStudyAndTrainingLoanRepaymentI'].NodeValue := Value;
end;

function TXMLTFND.Get_StudentLoanStudentFinancialSupplementSchemeI: Boolean;
begin
  Result := ChildNodes['StudentLoanStudentFinancialSupplementSchemeI'].NodeValue;
end;

procedure TXMLTFND.Set_StudentLoanStudentFinancialSupplementSchemeI(Value: Boolean);
begin
  ChildNodes['StudentLoanStudentFinancialSupplementSchemeI'].NodeValue := Value;
end;

{ TXMLDeclaration }

function TXMLDeclaration.Get_StatementAcceptedI: Boolean;
begin
  Result := ChildNodes['StatementAcceptedI'].NodeValue;
end;

procedure TXMLDeclaration.Set_StatementAcceptedI(Value: Boolean);
begin
  ChildNodes['StatementAcceptedI'].NodeValue := Value;
end;

function TXMLDeclaration.Get_SignatureD: UnicodeString;
begin
  Result := ChildNodes['SignatureD'].Text;
end;

procedure TXMLDeclaration.Set_SignatureD(Value: UnicodeString);
begin
  ChildNodes['SignatureD'].NodeValue := Value;
end;

end.