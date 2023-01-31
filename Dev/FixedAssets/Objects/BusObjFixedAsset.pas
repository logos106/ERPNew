unit BusObjFixedAsset;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  06/11/12  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjPicture,
  BusobjProduct, BusObjAssetHire, MyAccess;

type
  TRepairAssetXRef = class(TMSBusObj)
  private
    function GetAssetId: Integer;
    function GetRepairId: Integer;
    procedure SetAssetId(const Value: Integer);
    procedure SetRepairId(const Value: Integer);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    Function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property AssetId: Integer read GetAssetId write SetAssetId;
    property RepairId: Integer read GetRepairId write SetRepairId;
  end;

  TFixedAssetsDepreciationDetailsBase = class(TMSBusObj)
  private
    function GetAssetId: Integer;
    function GetYear: string;
    function GetMonth: string;
    function GetMonthNo: Integer;
    function GetDepreciation: Double;
    function GetTotalDepreciation: Double;
    function GetBookValue: Double;
    function GetDate: TDateTime;
    procedure SetAssetId(const Value: Integer);
    procedure SetYear(const Value: string);
    procedure SetMonth(const Value: string);
    procedure SetMonthNo(const Value: Integer);
    procedure SetDepreciation(const Value: Double);
    procedure SetTotalDepreciation(const Value: Double);
    procedure SetBookValue(const Value: Double);
    procedure SetDate(const Value: TDateTime);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;

  public
    class function GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property AssetId: Integer read GetAssetId write SetAssetId;
    property Year: string read GetYear write SetYear;
    property Month: string read GetMonth write SetMonth;
    property MonthNo: Integer read GetMonthNo write SetMonthNo;
    property Depreciation: Double read GetDepreciation write SetDepreciation;
    property TotalDepreciation: Double read GetTotalDepreciation write SetTotalDepreciation;
    property BookValue: Double read GetBookValue write SetBookValue;
    property Date: TDateTime read GetDate write SetDate;
  end;

  TFixedAssetsDepreciationDetails1 = Class(TFixedAssetsDepreciationDetailsBase)
  Private
  Protected
    Procedure CreateInstance; Override;
  Public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
  End;

  TFixedAssetsDepreciationDetails2 = Class(TFixedAssetsDepreciationDetailsBase)
  Private
  Protected
    Procedure CreateInstance; Override;
  Public
    constructor Create(AOwner: TComponent); override;
    class function GetBusObjectTablename: string; override;
  End;

  TAssetPicture = class(TbusobjPicture)
  private
    function GetAssetId: Integer;
    function GetImagetype: string;
    procedure SetAssetId(const Value: Integer);
    procedure SetImagetype(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    Procedure CreateInstance; Override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    function Picturefieldname: String; Override;
    function Picturetypefieldname: String; Override;

  published
    property AssetId: Integer read GetAssetId write SetAssetId;
    property Imagetype: string read GetImagetype write SetImagetype;
  end;

  TFixedAssetPercentages = class(TMSBusObj)
  private
    function GetAssetId: Integer;
    function GetClassID: Integer;
    function GetCost: Double;
    function GetDepreciation: Double;
    function GetDescription: string;
    function GetActive: Boolean;
    function GetFAPClassName: string;
    procedure SetAssetId(const Value: Integer);
    procedure SetClassID(const Value: Integer);
    procedure SetCost(const Value: Double);
    procedure SetDepreciation(const Value: Double);
    procedure SetDescription(const Value: string);
    procedure SetActive(const Value: Boolean);
    procedure SetFAPClassName(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    Procedure CreateInstance; Override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property AssetId: Integer read GetAssetId write SetAssetId;
    property ClassID: Integer read GetClassID write SetClassID;
    property Cost: Double read GetCost write SetCost;
    property Depreciation: Double read GetDepreciation write SetDepreciation;
    property Description: string read GetDescription write SetDescription;
    property Active: Boolean read GetActive write SetActive;
    property FAPClassName: string read GetFAPClassName write SetFAPClassName;
  end;

  TFixedAssets = class(TMSBusObj)
  private
    fbAllLinesValid: Boolean;
    fdValue: Double;
    fCloneAssetName: boolean;
    function GetAssetCode: string;
    function GetAssetName: string;
    function GetPurchDate: TDateTime;
    function GetPurchCost: Double;
    function GetAssetType: string;
    function GetClassID: Integer;
    function GetLocationDescription: string;
    function GetBrandName: string;
    function GetManufacture: string;
    function GetModel: string;
    function GetSerial: string;
    function GetNotes: string;
    function GetQty: Integer;
    function GetAssetCondition: string;
    function GetColour: string;
    function GetSize: string;
    function GetShape: string;
    function GetStatus: string;
    function GetEstimatedValue: Double;
    function GetReplacementCost: Double;
    function GetWarrantyType: string;
    function GetWarrantyExpiresDate: TDateTime;
    function GetInsuredBy: string;
    function GetInsurancePolicy: string;
    function GetInsuredUntil: TDateTime;
    function GetBusinessUsePercent: Double;
    function GetCUSTFLD1: string;
    function GetCUSTFLD2: string;
    function GetCUSTFLD3: string;
    function GetCUSTFLD4: string;
    function GetCUSTFLD5: string;
    function GetCUSTFLD6: string;
    function GetCUSTFLD7: string;
    function GetCUSTFLD8: string;
    function GetCUSTFLD9: string;
    function GetCUSTFLD10: string;
    function GetCUSTFLD11: string;
    function GetCUSTFLD12: string;
    function GetCUSTFLD13: string;
    function GetCUSTFLD14: string;
    function GetCUSTFLD15: string;
    function GetDepreciationOption: Integer;
    function GetLife: Double;
    function GetSalvageType: Integer;
    function GetSalvage: Double;
    function GetSalvageFactor: Double;
    function GetPriorAccumDeprec: Boolean;
    function GetPriorAccumDeprecDate: string;
    function GetPriorAccumDeprecAmount: Double;
    function GetDisposal: Boolean;
    function GetDisposalDate: TDateTime;
    function GetDisposalBookValue: Double;
    function GetDisposalAccumDeprec: Double;
    function GetSalesPrice: Double;
    function GetFixedAssetCostAccountName: string;
    function GetFixedAssetCostAccountID: Integer;
    function GetClearingAccountName: string;
    function GetClearingAccountID: Integer;
    function GetActive: Boolean;
    function GetPARTNAME: string;
    function GetPARTSID: Integer;
    function GetFixedAssetDepreciationAccountName: string;
    function GetFixedAssetDepreciationAccountID: Integer;
    function GetSupplierName: string;
    function GetSupplierID: Integer;
    function GetBARCODE: string;
    function GetDepreciationOption2: Integer;
    function GetLife2: Double;
    function GetSalvageType2: Integer;
    function GetSalvage2: Double;
    function GetSalvageFactor2: Double;
    function GetPriorAccumDeprec2: Boolean;
    function GetPriorAccumDeprecDate2: string;
    function GetPriorAccumDeprecAmount2: Double;
    function GetDisposalDate2: TDateTime;
    function GetDisposalBookValue2: Double;
    function GetDisposalAccumDeprec2: Double;
    function GetSalesPrice2: Double;
    function GetFixedAssetCostAccountName2: string;
    function GetFixedAssetCostAccountID2: Integer;
    function GetClearingAccountName2: string;
    function GetClearingAccountID2: Integer;
    function GetFixedAssetDepreciationAccountName2: string;
    function GetFixedAssetDepreciationAccountID2: Integer;
    function GetBusinessUsePercent2: Double;
    function GetFixedAssetDepreciationAssetAccountName: string;
    function GetFixedAssetDepreciationAssetAccountID: Integer;
    function GetFixedAssetDepreciationAssetAccountName2: string;
    function GetFixedAssetDepreciationAssetAccountID2: Integer;
    function GetCUSTDATE1: TDateTime;
    function GetCUSTDATE2: TDateTime;
    function GetCUSTDATE3: TDateTime;
    function GetParentID: Integer;
    function GetTotalChildAsset: Double;
    function GetLastTestDate: TDateTime;
    function GetNextTestDate: TDateTime;
    procedure SetAssetCode(const Value: string);
    procedure SetAssetName(const Value: string);
    procedure SetPurchDate(const Value: TDateTime);
    procedure SetPurchCost(const Value: Double);
    procedure SetAssetType(const Value: string);
    procedure SetClassID(const Value: Integer);
    procedure SetLocationDescription(const Value: string);
    procedure SetBrandName(const Value: string);
    procedure SetManufacture(const Value: string);
    procedure SetModel(const Value: string);
    procedure SetSerial(const Value: string);
    procedure SetNotes(const Value: string);
    procedure SetQty(const Value: Integer);
    procedure SetAssetCondition(const Value: string);
    procedure SetColour(const Value: string);
    procedure SetSize(const Value: string);
    procedure SetShape(const Value: string);
    procedure SetStatus(const Value: string);
    procedure SetEstimatedValue(const Value: Double);
    procedure SetReplacementCost(const Value: Double);
    procedure SetWarrantyType(const Value: string);
    procedure SetWarrantyExpiresDate(const Value: TDateTime);
    procedure SetInsuredBy(const Value: string);
    procedure SetInsurancePolicy(const Value: string);
    procedure SetInsuredUntil(const Value: TDateTime);
    procedure SetBusinessUsePercent(const Value: Double);
    procedure SetCUSTFLD1(const Value: string);
    procedure SetCUSTFLD2(const Value: string);
    procedure SetCUSTFLD3(const Value: string);
    procedure SetCUSTFLD4(const Value: string);
    procedure SetCUSTFLD5(const Value: string);
    procedure SetCUSTFLD6(const Value: string);
    procedure SetCUSTFLD7(const Value: string);
    procedure SetCUSTFLD8(const Value: string);
    procedure SetCUSTFLD9(const Value: string);
    procedure SetCUSTFLD10(const Value: string);
    procedure SetCUSTFLD11(const Value: string);
    procedure SetCUSTFLD12(const Value: string);
    procedure SetCUSTFLD13(const Value: string);
    procedure SetCUSTFLD14(const Value: string);
    procedure SetCUSTFLD15(const Value: string);
    procedure SetDepreciationOption(const Value: Integer);
    procedure SetLife(const Value: Double);
    procedure SetSalvageType(const Value: Integer);
    procedure SetSalvage(const Value: Double);
    procedure SetSalvageFactor(const Value: Double);
    procedure SetPriorAccumDeprec(const Value: Boolean);
    procedure SetPriorAccumDeprecDate(const Value: string);
    procedure SetPriorAccumDeprecAmount(const Value: Double);
    procedure SetDisposal(const Value: Boolean);
    procedure SetDisposalDate(const Value: TDateTime);
    procedure SetDisposalBookValue(const Value: Double);
    procedure SetDisposalAccumDeprec(const Value: Double);
    procedure SetSalesPrice(const Value: Double);
    procedure SetFixedAssetCostAccountName(const Value: string);
    procedure SetFixedAssetCostAccountID(const Value: Integer);
    procedure SetClearingAccountName(const Value: string);
    procedure SetClearingAccountID(const Value: Integer);
    procedure SetActive(const Value: Boolean);
    procedure SetPARTNAME(const Value: string);
    procedure SetPARTSID(const Value: Integer);
    procedure SetFixedAssetDepreciationAccountName(const Value: string);
    procedure SetFixedAssetDepreciationAccountID(const Value: Integer);
    procedure SetSupplierName(const Value: string);
    procedure SetSupplierID(const Value: Integer);
    procedure SetBARCODE(const Value: string);
    procedure SetDepreciationOption2(const Value: Integer);
    procedure SetLife2(const Value: Double);
    procedure SetSalvageType2(const Value: Integer);
    procedure SetSalvage2(const Value: Double);
    procedure SetSalvageFactor2(const Value: Double);
    procedure SetPriorAccumDeprec2(const Value: Boolean);
    procedure SetPriorAccumDeprecDate2(const Value: string);
    procedure SetPriorAccumDeprecAmount2(const Value: Double);
    procedure SetDisposalDate2(const Value: TDateTime);
    procedure SetDisposalBookValue2(const Value: Double);
    procedure SetDisposalAccumDeprec2(const Value: Double);
    procedure SetSalesPrice2(const Value: Double);
    procedure SetFixedAssetCostAccountName2(const Value: string);
    procedure SetFixedAssetCostAccountID2(const Value: Integer);
    procedure SetClearingAccountName2(const Value: string);
    procedure SetClearingAccountID2(const Value: Integer);
    procedure SetFixedAssetDepreciationAccountName2(const Value: string);
    procedure SetFixedAssetDepreciationAccountID2(const Value: Integer);
    procedure SetBusinessUsePercent2(const Value: Double);
    procedure SetFixedAssetDepreciationAssetAccountName(const Value: string);
    procedure SetFixedAssetDepreciationAssetAccountID(const Value: Integer);
    procedure SetFixedAssetDepreciationAssetAccountName2(const Value: string);
    procedure SetFixedAssetDepreciationAssetAccountID2(const Value: Integer);
    procedure SetCUSTDATE1(const Value: TDateTime);
    procedure SetCUSTDATE2(const Value: TDateTime);
    procedure SetCUSTDATE3(const Value: TDateTime);
    procedure SetParentID(const Value: Integer);
    procedure SetTotalChildAsset(const Value: Double);
    procedure SetLastTestDate(const Value: TDateTime);
    procedure SetNextTestDate(const Value: TDateTime);
    function GetDepreciationStartDate: TDateTime;
    procedure SetDepreciationStartDate(const Value: TDateTime);
    function getfixedassetsdepreciationdetails1: Tfixedassetsdepreciationdetails1;
    function getfixedassetsdepreciationdetails2: Tfixedassetsdepreciationdetails2;
    function getAssetPicture: TAssetPicture;
    function getFixedAssetPercentages: TFixedAssetPercentages;
    Procedure ValidateCallback(const Sender: TBusObj; var Abort: Boolean);
    function getFAPercentageCostTotal: Double;
    function getFAPercentageDepreciationTotal: Double;
    Procedure FAPercentageDepreciationTotalCallback(const Sender: TBusObj; var Abort: Boolean);
    Procedure FAPercentageCostTotalCallback(const Sender: TBusObj; var Abort: Boolean);
    function getProduct: TProductSimple;
    function getCleanDepreciationStartDate: TDateTime;
    function getCleanPurchDate: TDateTime;
    procedure CloneLines(const Sender: TBusObj; var Abort: Boolean);
    function GetAssetHire: TAssetHire;
    function GetDescription: string;
    procedure SetDescription(const Value: string);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;

  public
    property CloneAssetName: boolean read fCloneAssetName write fCloneAssetName;
    Procedure ClonePropertyObjects; override;
    class function GetKeyStringField: string; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function AssetNameForId(aAssetId: integer; Connection: TCustomMyConnection = nil): string;
    class function AssetIdForName(aAssetName: string; Connection: TCustomMyConnection = nil): integer;
    class function AssetCodeForID(aAssetID: integer; Connection: TCustomMyConnection = nil): string;
    class function AssetIdForCode(aAssetCode: string; var aAssetName: string; ExcludeAssetId: integer = 0; Connection: TCustomMyConnection = nil): integer;
    class function NextAssetCode(const LastAssetCode: string = ''; Connection: TCustomMyConnection = nil): string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    Property FAPercentageCostTotal: Double read getFAPercentageCostTotal;
    Property FAPercentageDepreciationTotal: Double read getFAPercentageDepreciationTotal;
    procedure InitAccounts;
    Property Product: TProductSimple read getProduct;
    Property CleanDepreciationStartDate: TDateTime read getCleanDepreciationStartDate;
    Property CleanPurchDate: TDateTime read getCleanPurchDate;
  published
    property AssetCode: string read GetAssetCode write SetAssetCode;
    property AssetName: string read GetAssetName write SetAssetName;
    property Description: string read GetDescription write SetDescription;
    property PurchDate: TDateTime read GetPurchDate write SetPurchDate;
    property DepreciationStartDate: TDateTime read GetDepreciationStartDate
      write SetDepreciationStartDate;
    property PurchCost: Double read GetPurchCost write SetPurchCost;
    property AssetType: string read GetAssetType write SetAssetType;
    property ClassID: Integer read GetClassID write SetClassID;
    property LocationDescription: string read GetLocationDescription write SetLocationDescription;
    property BrandName: string read GetBrandName write SetBrandName;
    property Manufacture: string read GetManufacture write SetManufacture;
    property Model: string read GetModel write SetModel;
    property Serial: string read GetSerial write SetSerial;
    property Notes: string read GetNotes write SetNotes;
    property Qty: Integer read GetQty write SetQty;
    property AssetCondition: string read GetAssetCondition write SetAssetCondition;
    property Colour: string read GetColour write SetColour;
    property Size: string read GetSize write SetSize;
    property Shape: string read GetShape write SetShape;
    property Status: string read GetStatus write SetStatus;
    property EstimatedValue: Double read GetEstimatedValue write SetEstimatedValue;
    property ReplacementCost: Double read GetReplacementCost write SetReplacementCost;
    property WarrantyType: string read GetWarrantyType write SetWarrantyType;
    property WarrantyExpiresDate: TDateTime read GetWarrantyExpiresDate
      write SetWarrantyExpiresDate;
    property InsuredBy: string read GetInsuredBy write SetInsuredBy;
    property InsurancePolicy: string read GetInsurancePolicy write SetInsurancePolicy;
    property InsuredUntil: TDateTime read GetInsuredUntil write SetInsuredUntil;
    property BusinessUsePercent: Double read GetBusinessUsePercent write SetBusinessUsePercent;
    property CUSTFLD1: string read GetCUSTFLD1 write SetCUSTFLD1;
    property CUSTFLD2: string read GetCUSTFLD2 write SetCUSTFLD2;
    property CUSTFLD3: string read GetCUSTFLD3 write SetCUSTFLD3;
    property CUSTFLD4: string read GetCUSTFLD4 write SetCUSTFLD4;
    property CUSTFLD5: string read GetCUSTFLD5 write SetCUSTFLD5;
    property CUSTFLD6: string read GetCUSTFLD6 write SetCUSTFLD6;
    property CUSTFLD7: string read GetCUSTFLD7 write SetCUSTFLD7;
    property CUSTFLD8: string read GetCUSTFLD8 write SetCUSTFLD8;
    property CUSTFLD9: string read GetCUSTFLD9 write SetCUSTFLD9;
    property CUSTFLD10: string read GetCUSTFLD10 write SetCUSTFLD10;
    property CUSTFLD11: string read GetCUSTFLD11 write SetCUSTFLD11;
    property CUSTFLD12: string read GetCUSTFLD12 write SetCUSTFLD12;
    property CUSTFLD13: string read GetCUSTFLD13 write SetCUSTFLD13;
    property CUSTFLD14: string read GetCUSTFLD14 write SetCUSTFLD14;
    property CUSTFLD15: string read GetCUSTFLD15 write SetCUSTFLD15;
    property DepreciationOption: Integer read GetDepreciationOption write SetDepreciationOption;
    property Life: Double read GetLife write SetLife;
    property SalvageType: Integer read GetSalvageType write SetSalvageType;
    property Salvage: Double read GetSalvage write SetSalvage;
    property SalvageFactor: Double read GetSalvageFactor write SetSalvageFactor;
    property PriorAccumDeprec: Boolean read GetPriorAccumDeprec write SetPriorAccumDeprec;
    property PriorAccumDeprecDate: string read GetPriorAccumDeprecDate
      write SetPriorAccumDeprecDate;
    property PriorAccumDeprecAmount: Double read GetPriorAccumDeprecAmount
      write SetPriorAccumDeprecAmount;
    property Disposal: Boolean read GetDisposal write SetDisposal;
    property DisposalDate: TDateTime read GetDisposalDate write SetDisposalDate;
    property DisposalBookValue: Double read GetDisposalBookValue write SetDisposalBookValue;
    property DisposalAccumDeprec: Double read GetDisposalAccumDeprec write SetDisposalAccumDeprec;
    property SalesPrice: Double read GetSalesPrice write SetSalesPrice;
    property FixedAssetCostAccountName: string read GetFixedAssetCostAccountName
      write SetFixedAssetCostAccountName;
    property FixedAssetCostAccountID: Integer read GetFixedAssetCostAccountID
      write SetFixedAssetCostAccountID;
    property ClearingAccountName: string read GetClearingAccountName write SetClearingAccountName;
    property ClearingAccountID: Integer read GetClearingAccountID write SetClearingAccountID;
    property Active: Boolean read GetActive write SetActive;
    property PARTNAME: string read GetPARTNAME write SetPARTNAME;
    property PARTSID: Integer read GetPARTSID write SetPARTSID;
    property FixedAssetDepreciationAccountName: string read GetFixedAssetDepreciationAccountName
      write SetFixedAssetDepreciationAccountName;
    property FixedAssetDepreciationAccountID: Integer read GetFixedAssetDepreciationAccountID
      write SetFixedAssetDepreciationAccountID;
    property SupplierName: string read GetSupplierName write SetSupplierName;
    property SupplierID: Integer read GetSupplierID write SetSupplierID;
    property BARCODE: string read GetBARCODE write SetBARCODE;
    property DepreciationOption2: Integer read GetDepreciationOption2 write SetDepreciationOption2;
    property Life2: Double read GetLife2 write SetLife2;
    property SalvageType2: Integer read GetSalvageType2 write SetSalvageType2;
    property Salvage2: Double read GetSalvage2 write SetSalvage2;
    property SalvageFactor2: Double read GetSalvageFactor2 write SetSalvageFactor2;
    property PriorAccumDeprec2: Boolean read GetPriorAccumDeprec2 write SetPriorAccumDeprec2;
    property PriorAccumDeprecDate2: string read GetPriorAccumDeprecDate2
      write SetPriorAccumDeprecDate2;
    property PriorAccumDeprecAmount2: Double read GetPriorAccumDeprecAmount2
      write SetPriorAccumDeprecAmount2;
    property DisposalDate2: TDateTime read GetDisposalDate2 write SetDisposalDate2;
    property DisposalBookValue2: Double read GetDisposalBookValue2 write SetDisposalBookValue2;
    property DisposalAccumDeprec2: Double read GetDisposalAccumDeprec2
      write SetDisposalAccumDeprec2;
    property SalesPrice2: Double read GetSalesPrice2 write SetSalesPrice2;
    property FixedAssetCostAccountName2: string read GetFixedAssetCostAccountName2
      write SetFixedAssetCostAccountName2;
    property FixedAssetCostAccountID2: Integer read GetFixedAssetCostAccountID2
      write SetFixedAssetCostAccountID2;
    property ClearingAccountName2: string read GetClearingAccountName2
      write SetClearingAccountName2;
    property ClearingAccountID2: Integer read GetClearingAccountID2 write SetClearingAccountID2;
    property FixedAssetDepreciationAccountName2: string read GetFixedAssetDepreciationAccountName2
      write SetFixedAssetDepreciationAccountName2;
    property FixedAssetDepreciationAccountID2: Integer read GetFixedAssetDepreciationAccountID2
      write SetFixedAssetDepreciationAccountID2;
    property BusinessUsePercent2: Double read GetBusinessUsePercent2 write SetBusinessUsePercent2;
    property FixedAssetDepreciationAssetAccountName: string
      read GetFixedAssetDepreciationAssetAccountName
      write SetFixedAssetDepreciationAssetAccountName;
    property FixedAssetDepreciationAssetAccountID: Integer
      read GetFixedAssetDepreciationAssetAccountID write SetFixedAssetDepreciationAssetAccountID;
    property FixedAssetDepreciationAssetAccountName2: string
      read GetFixedAssetDepreciationAssetAccountName2
      write SetFixedAssetDepreciationAssetAccountName2;
    property FixedAssetDepreciationAssetAccountID2: Integer
      read GetFixedAssetDepreciationAssetAccountID2 write SetFixedAssetDepreciationAssetAccountID2;
    property CUSTDATE1: TDateTime read GetCUSTDATE1 write SetCUSTDATE1;
    property CUSTDATE2: TDateTime read GetCUSTDATE2 write SetCUSTDATE2;
    property CUSTDATE3: TDateTime read GetCUSTDATE3 write SetCUSTDATE3;
    property ParentID: Integer read GetParentID write SetParentID;
    property TotalChildAsset: Double read GetTotalChildAsset write SetTotalChildAsset;
    property LastTestDate: TDateTime read GetLastTestDate write SetLastTestDate;
    property NextTestDate: TDateTime read GetNextTestDate write SetNextTestDate;
    Property fixedassetsdepreciationdetails1: Tfixedassetsdepreciationdetails1
      read getfixedassetsdepreciationdetails1;
    Property fixedassetsdepreciationdetails2: Tfixedassetsdepreciationdetails2
      read getfixedassetsdepreciationdetails2;
    Property AssetPicture: TAssetPicture read getAssetPicture;
    Property FixedAssetPercentages: TFixedAssetPercentages read getFixedAssetPercentages;
    property AssetHire: TAssetHire read GetAssetHire;
  end;

  TFixedAssetType = class(TMSBusObj)
  private
    function GetActive: boolean;
    function GetAssetTypeCode: string;
    function GetAssetTypeName: string;
    function GetDepreciationOption: integer;
    function GetLife: double;
    function GetNotes: string;
    function GetSalvage: double;
    function GetSalvageFactor: double;
    function GetSalvageType: integer;
    procedure SetActive(const Value: boolean);
    procedure SetAssetTypeCode(const Value: string);
    procedure SetAssetTypeName(const Value: string);
    procedure SetDepreciationOption(const Value: integer);
    procedure SetLife(const Value: double);
    procedure SetNotes(const Value: string);
    procedure SetSalvage(const Value: double);
    procedure SetSalvageFactor(const Value: double);
    procedure SetSalvageType(const Value: integer);
  protected
  public
    class function GetKeyStringField: string; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property AssetTypeCode: string read GetAssetTypeCode write SetAssetTypeCode;
    property AssetTypeName: string read GetAssetTypeName write SetAssetTypeName;
    property Notes: string read GetNotes write SetNotes;
    property DepreciationOption: integer read GetDepreciationOption write SetDepreciationOption;
    property Life: double read GetLife write SetLife;
    property SalvageType: integer read GetSalvageType write SetSalvageType;
    property Salvage: double read GetSalvage write SetSalvage;
    property SalvageFactor: double read GetSalvageFactor write SetSalvageFactor;
    property Active: boolean read GetActive write SetActive;
  end;


implementation

uses tcDataUtils, CommonLib, BusObjRepairs, SysUtils, BusObjectListObj, AppEnvironment,
  BusObjGLAccount, BusObjConst, BusObjCustomFieldsGeneral, BusObjClient,
  BusObjClass, LogLib, ERPDBComponents, DbSharedObjectsObj, CommonDbLib;

{ TRepairAssetXRef }

constructor TRepairAssetXRef.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'RepairAssetXRef';
  fSQL := 'SELECT * FROM tblrepairassetxref';
end;

destructor TRepairAssetXRef.Destroy;
begin
  inherited;
end;

procedure TRepairAssetXRef.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'AssetId');
  SetPropertyFromNode(node, 'RepairId');
end;

procedure TRepairAssetXRef.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'AssetId', AssetId);
  AddXMLNode(node, 'RepairId', RepairId);
end;

function TRepairAssetXRef.ValidateData: Boolean;
begin
  Resultstatus.Clear;

  Result := True;
end;

function TRepairAssetXRef.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TRepairAssetXRef.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TRepairAssetXRef.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TRepairAssetXRef.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TRepairAssetXRef.GetIDField: string;
begin
  Result := 'RepairAssetXRefId'
end;

class function TRepairAssetXRef.GetBusObjectTablename: string;
begin
  Result := 'tblrepairassetxref';
end;

function TRepairAssetXRef.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited;
  if Assigned(Owner) and (Owner is TRepairs) then
    self.RepairId := TRepairs(Owner).ID;
end;

function TRepairAssetXRef.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TRepairAssetXRef.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  if self.AssetId < 1 then begin
    Dataset.Cancel;
    Abort;
  end;
  Result := inherited;
end;

{ Property Functions }
function TRepairAssetXRef.GetAssetId: Integer;
begin
  Result := GetIntegerField('AssetId');
end;

function TRepairAssetXRef.GetRepairId: Integer;
begin
  Result := GetIntegerField('RepairId');
end;

procedure TRepairAssetXRef.SetAssetId(const Value: Integer);
begin
  SetIntegerField('AssetId', Value);
end;

procedure TRepairAssetXRef.SetRepairId(const Value: Integer);
begin
  SetIntegerField('RepairId', Value);
end;

{ TFixedAssets }
procedure TFixedAssets.ClonePropertyObjects;

  Procedure Logafterclose(Sender: TBusObj);
  begin
    if Assigned(Sender.ObjInstanceToClone) then
      Logtext(Sender.classname + ' :' + inttostr(Sender.Count) + ' -> ' +
        inttostr(Sender.ObjInstanceToClone.Count) + ' (' + Sender.ObjInstanceToClone.Dataset.Name +
        '-' + Sender.ObjInstanceToClone.SQL + ')');
  end;

begin
  inherited;

  if Assigned(ObjInstanceToClone) and (ObjInstanceToClone is TFixedAssets) then begin
    TFixedAssets(ObjInstanceToClone).fixedassetsdepreciationdetails1.DeleteAll;
    TFixedAssets(ObjInstanceToClone).fixedassetsdepreciationdetails2.DeleteAll;
    TFixedAssets(ObjInstanceToClone).AssetPicture.DeleteAll;
    TFixedAssets(ObjInstanceToClone).FixedAssetPercentages.DeleteAll;
  end;

  fixedassetsdepreciationdetails1.IterateRecords(CloneLines);
  fixedassetsdepreciationdetails2.IterateRecords(CloneLines);
  AssetPicture.IterateRecords(CloneLines);
  FixedAssetPercentages.IterateRecords(CloneLines);

  Logafterclose(fixedassetsdepreciationdetails1);
  Logafterclose(fixedassetsdepreciationdetails2);
  Logafterclose(AssetPicture);
  Logafterclose(FixedAssetPercentages);

  if CloneAssetName then
    TFixedAssets(ObjInstanceToClone).AssetName := self.AssetName;
  TFixedAssets(ObjInstanceToClone).PostDB;

  if self.AssetHire.Count > 0 then begin
    if TFixedAssets(ObjInstanceToClone).AssetHire.Count > 0 then
      TFixedAssets(ObjInstanceToClone).AssetHire.Delete;
    TFixedAssets(ObjInstanceToClone).AssetHire.New;
    TFixedAssets(ObjInstanceToClone).AssetHire.Assign(self.AssetHire);
    TFixedAssets(ObjInstanceToClone).AssetHire.AssetId := TFixedAssets(ObjInstanceToClone).ID;
    TFixedAssets(ObjInstanceToClone).AssetHire.PostDb;
    TFixedAssets(ObjInstanceToClone).AssetHire.PriceLines.First;
    self.AssetHire.PriceLines.First;
    while not self.AssetHire.PriceLines.EOF do begin
      TFixedAssets(ObjInstanceToClone).AssetHire.PriceLines.New;
      TFixedAssets(ObjInstanceToClone).AssetHire.PriceLines.Assign(self.AssetHire.PriceLines);
      TFixedAssets(ObjInstanceToClone).AssetHire.PriceLines.AssetHireID := TFixedAssets(ObjInstanceToClone).AssetHire.ID;
      TFixedAssets(ObjInstanceToClone).AssetHire.PriceLines.PostDb;
      self.AssetHire.PriceLines.Next;
    end;
  end;


//  x


end;

class function TFixedAssets.AssetCodeForID(aAssetID: integer;
  Connection: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  if Assigned(Connection) then
    qry := DbSharedObj.GetQuery(connection)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select AssetCode from ' + GetBusObjectTablename + ' where AssetID = ' + IntToStr(aAssetId));
    qry.Open;
    result := qry.FieldByName('AssetCode').AsString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TFixedAssets.AssetIdForCode(aAssetCode: string;
  var aAssetName: string; ExcludeAssetId: integer;
  Connection: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  if Assigned(Connection) then
    qry := DbSharedObj.GetQuery(connection)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select AssetName, AssetId from ' + GetBusObjectTablename + ' where AssetCode = ' + QuotedStr(aAssetCode));
    if ExcludeAssetId <> 0 then
      qry.SQL.Add('and AssetId <> ' + IntToStr(ExcludeAssetId));
    qry.Open;
    result := qry.FieldByName('AssetID').AsInteger;
    aAssetName := qry.FieldByName('AssetName').AsString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TFixedAssets.AssetIdForName(aAssetName: string;
  Connection: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  if Assigned(Connection) then
    qry := DbSharedObj.GetQuery(connection)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select AssetId from ' + GetBusObjectTablename + ' where AssetName = ' + QuotedStr(aAssetName));
    qry.Open;
    result := qry.FieldByName('AssetId').AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TFixedAssets.AssetNameForId(aAssetId: integer; Connection: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  if Assigned(Connection) then
    qry := DbSharedObj.GetQuery(connection)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select AssetName from ' + GetBusObjectTablename + ' where ' + GetIDField + ' = ' + IntToStr(aAssetId));
    qry.Open;
    result := qry.FieldByName('AssetName').AsString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

Procedure TFixedAssets.CloneLines(Const Sender: TBusObj; Var Abort: Boolean);
begin
  Sender.CloneBusObj('AssetID', ObjInstanceToClone.ID, False);
end;

constructor TFixedAssets.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'FixedAssets';
  fSQL := 'SELECT * FROM tblfixedassets';
  fCloneAssetName := true;
end;

destructor TFixedAssets.Destroy;
begin
  inherited;
end;

procedure TFixedAssets.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'AssetCode');
  SetPropertyFromNode(node, 'AssetName');
  SetDateTimePropertyFromNode(node, 'PurchDate');
  SetDateTimePropertyFromNode(node, 'DepreciationStartDate');
  SetPropertyFromNode(node, 'PurchCost');
  SetPropertyFromNode(node, 'AssetType');
  SetPropertyFromNode(node, 'ClassID');
  SetPropertyFromNode(node, 'LocationDescription');
  SetPropertyFromNode(node, 'BrandName');
  SetPropertyFromNode(node, 'Manufacture');
  SetPropertyFromNode(node, 'Model');
  SetPropertyFromNode(node, 'Serial');
  SetPropertyFromNode(node, 'Notes');
  SetPropertyFromNode(node, 'Qty');
  SetPropertyFromNode(node, 'AssetCondition');
  SetPropertyFromNode(node, 'Colour');
  SetPropertyFromNode(node, 'Size');
  SetPropertyFromNode(node, 'Shape');
  SetPropertyFromNode(node, 'Status');
  SetPropertyFromNode(node, 'EstimatedValue');
  SetPropertyFromNode(node, 'ReplacementCost');
  SetPropertyFromNode(node, 'WarrantyType');
  SetDateTimePropertyFromNode(node, 'WarrantyExpiresDate');
  SetPropertyFromNode(node, 'InsuredBy');
  SetPropertyFromNode(node, 'InsurancePolicy');
  SetDateTimePropertyFromNode(node, 'InsuredUntil');
  SetPropertyFromNode(node, 'BusinessUsePercent');
  SetPropertyFromNode(node, 'CUSTFLD1');
  SetPropertyFromNode(node, 'CUSTFLD2');
  SetPropertyFromNode(node, 'CUSTFLD3');
  SetPropertyFromNode(node, 'CUSTFLD4');
  SetPropertyFromNode(node, 'CUSTFLD5');
  SetPropertyFromNode(node, 'CUSTFLD6');
  SetPropertyFromNode(node, 'CUSTFLD7');
  SetPropertyFromNode(node, 'CUSTFLD8');
  SetPropertyFromNode(node, 'CUSTFLD9');
  SetPropertyFromNode(node, 'CUSTFLD10');
  SetPropertyFromNode(node, 'CUSTFLD11');
  SetPropertyFromNode(node, 'CUSTFLD12');
  SetPropertyFromNode(node, 'CUSTFLD13');
  SetPropertyFromNode(node, 'CUSTFLD14');
  SetPropertyFromNode(node, 'CUSTFLD15');
  SetPropertyFromNode(node, 'DepreciationOption');
  SetPropertyFromNode(node, 'Life');
  SetPropertyFromNode(node, 'SalvageType');
  SetPropertyFromNode(node, 'Salvage');
  SetPropertyFromNode(node, 'SalvageFactor');
  SetBooleanPropertyFromNode(node, 'PriorAccumDeprec');
  SetPropertyFromNode(node, 'PriorAccumDeprecDate');
  SetPropertyFromNode(node, 'PriorAccumDeprecAmount');
  SetBooleanPropertyFromNode(node, 'Disposal');
  SetDateTimePropertyFromNode(node, 'DisposalDate');
  SetPropertyFromNode(node, 'DisposalBookValue');
  SetPropertyFromNode(node, 'DisposalAccumDeprec');
  SetPropertyFromNode(node, 'SalesPrice');
  SetPropertyFromNode(node, 'FixedAssetCostAccountName');
  SetPropertyFromNode(node, 'FixedAssetCostAccountID');
  SetPropertyFromNode(node, 'ClearingAccountName');
  SetPropertyFromNode(node, 'ClearingAccountID');
  SetBooleanPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'PARTNAME');
  SetPropertyFromNode(node, 'PARTSID');
  SetPropertyFromNode(node, 'FixedAssetDepreciationAccountName');
  SetPropertyFromNode(node, 'FixedAssetDepreciationAccountID');
  SetPropertyFromNode(node, 'SupplierName');
  SetPropertyFromNode(node, 'SupplierID');
  SetPropertyFromNode(node, 'BARCODE');
  SetPropertyFromNode(node, 'DepreciationOption2');
  SetPropertyFromNode(node, 'Life2');
  SetPropertyFromNode(node, 'SalvageType2');
  SetPropertyFromNode(node, 'Salvage2');
  SetPropertyFromNode(node, 'SalvageFactor2');
  SetBooleanPropertyFromNode(node, 'PriorAccumDeprec2');
  SetPropertyFromNode(node, 'PriorAccumDeprecDate2');
  SetPropertyFromNode(node, 'PriorAccumDeprecAmount2');
  SetDateTimePropertyFromNode(node, 'DisposalDate2');
  SetPropertyFromNode(node, 'DisposalBookValue2');
  SetPropertyFromNode(node, 'DisposalAccumDeprec2');
  SetPropertyFromNode(node, 'SalesPrice2');
  SetPropertyFromNode(node, 'FixedAssetCostAccountName2');
  SetPropertyFromNode(node, 'FixedAssetCostAccountID2');
  SetPropertyFromNode(node, 'ClearingAccountName2');
  SetPropertyFromNode(node, 'ClearingAccountID2');
  SetPropertyFromNode(node, 'FixedAssetDepreciationAccountName2');
  SetPropertyFromNode(node, 'FixedAssetDepreciationAccountID2');
  SetPropertyFromNode(node, 'BusinessUsePercent2');
  SetPropertyFromNode(node, 'FixedAssetDepreciationAssetAccountName');
  SetPropertyFromNode(node, 'FixedAssetDepreciationAssetAccountID');
  SetPropertyFromNode(node, 'FixedAssetDepreciationAssetAccountName2');
  SetPropertyFromNode(node, 'FixedAssetDepreciationAssetAccountID2');
  SetDateTimePropertyFromNode(node, 'CUSTDATE1');
  SetDateTimePropertyFromNode(node, 'CUSTDATE2');
  SetDateTimePropertyFromNode(node, 'CUSTDATE3');
  SetPropertyFromNode(node, 'ParentID');
  SetPropertyFromNode(node, 'TotalChildAsset');
  SetDateTimePropertyFromNode(node, 'LastTestDate');
  SetDateTimePropertyFromNode(node, 'NextTestDate');
end;

class function TFixedAssets.NextAssetCode(const LastAssetCode: string = '';
  Connection: TCustomMyConnection = nil): string;
var
  qry: TERPQuery;
  lastVal, s, prefix: string;
  x: integer;
const
  defaultVal = '000001';
begin
  if LastAssetCode <> '' then
    lastVal := LastAssetCode
  else begin
    if Assigned(Connection) then
      qry := DbSharedObj.GetQuery(connection)
    else
      qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      qry.SQL.Add('select AssetCode from ' + GetBusObjectTablename + ' where Active = "T"');
      qry.SQL.Add('order by AssetID desc');
      qry.SQL.Add('limit 1');
      qry.Open;
      lastVal := qry.FieldByName('AssetCode').AsString;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end;
  if lastVal = '' then begin
    result := defaultVal;
    exit;
  end;
  s := '';
  for x := Length(lastVal) downto 1 do begin
    if CharInSet(lastVal[x],['0'..'9']) then
      s := lastVal[x] + s
    else
      break;
  end;
  if s = '' then begin
    result := defaultVal;
    exit;
  end;
  prefix := Copy(lastVal,1,Length(lastVal) - Length(s));
  result := IntToStr(StrToInt(s) + 1);
  while Length(result) < Length(s) do
    result := '0' + result;
  result := prefix + result;
end;

procedure TFixedAssets.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'AssetCode', AssetCode);
  AddXMLNode(node, 'AssetName', AssetName);
  AddXMLNode(node, 'PurchDate', PurchDate);
  AddXMLNode(node, 'DepreciationStartDate', PurchDate);
  AddXMLNode(node, 'PurchCost', PurchCost);
  AddXMLNode(node, 'AssetType', AssetType);
  AddXMLNode(node, 'ClassID', ClassID);
  AddXMLNode(node, 'LocationDescription', LocationDescription);
  AddXMLNode(node, 'BrandName', BrandName);
  AddXMLNode(node, 'Manufacture', Manufacture);
  AddXMLNode(node, 'Model', Model);
  AddXMLNode(node, 'Serial', Serial);
  AddXMLNode(node, 'Notes', Notes);
  AddXMLNode(node, 'Qty', Qty);
  AddXMLNode(node, 'AssetCondition', AssetCondition);
  AddXMLNode(node, 'Colour', Colour);
  AddXMLNode(node, 'Size', Size);
  AddXMLNode(node, 'Shape', Shape);
  AddXMLNode(node, 'Status', Status);
  AddXMLNode(node, 'EstimatedValue', EstimatedValue);
  AddXMLNode(node, 'ReplacementCost', ReplacementCost);
  AddXMLNode(node, 'WarrantyType', WarrantyType);
  AddXMLNode(node, 'WarrantyExpiresDate', WarrantyExpiresDate);
  AddXMLNode(node, 'InsuredBy', InsuredBy);
  AddXMLNode(node, 'InsurancePolicy', InsurancePolicy);
  AddXMLNode(node, 'InsuredUntil', InsuredUntil);
  AddXMLNode(node, 'BusinessUsePercent', BusinessUsePercent);
  AddXMLNode(node, 'CUSTFLD1', CUSTFLD1);
  AddXMLNode(node, 'CUSTFLD2', CUSTFLD2);
  AddXMLNode(node, 'CUSTFLD3', CUSTFLD3);
  AddXMLNode(node, 'CUSTFLD4', CUSTFLD4);
  AddXMLNode(node, 'CUSTFLD5', CUSTFLD5);
  AddXMLNode(node, 'CUSTFLD6', CUSTFLD6);
  AddXMLNode(node, 'CUSTFLD7', CUSTFLD7);
  AddXMLNode(node, 'CUSTFLD8', CUSTFLD8);
  AddXMLNode(node, 'CUSTFLD9', CUSTFLD9);
  AddXMLNode(node, 'CUSTFLD10', CUSTFLD10);
  AddXMLNode(node, 'CUSTFLD11', CUSTFLD11);
  AddXMLNode(node, 'CUSTFLD12', CUSTFLD12);
  AddXMLNode(node, 'CUSTFLD13', CUSTFLD13);
  AddXMLNode(node, 'CUSTFLD14', CUSTFLD14);
  AddXMLNode(node, 'CUSTFLD15', CUSTFLD15);
  AddXMLNode(node, 'DepreciationOption', DepreciationOption);
  AddXMLNode(node, 'Life', Life);
  AddXMLNode(node, 'SalvageType', SalvageType);
  AddXMLNode(node, 'Salvage', Salvage);
  AddXMLNode(node, 'SalvageFactor', SalvageFactor);
  AddXMLNode(node, 'PriorAccumDeprec', PriorAccumDeprec);
  AddXMLNode(node, 'PriorAccumDeprecDate', PriorAccumDeprecDate);
  AddXMLNode(node, 'PriorAccumDeprecAmount', PriorAccumDeprecAmount);
  AddXMLNode(node, 'Disposal', Disposal);
  AddXMLNode(node, 'DisposalDate', DisposalDate);
  AddXMLNode(node, 'DisposalBookValue', DisposalBookValue);
  AddXMLNode(node, 'DisposalAccumDeprec', DisposalAccumDeprec);
  AddXMLNode(node, 'SalesPrice', SalesPrice);
  AddXMLNode(node, 'FixedAssetCostAccountName', FixedAssetCostAccountName);
  AddXMLNode(node, 'FixedAssetCostAccountID', FixedAssetCostAccountID);
  AddXMLNode(node, 'ClearingAccountName', ClearingAccountName);
  AddXMLNode(node, 'ClearingAccountID', ClearingAccountID);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'PARTNAME', PARTNAME);
  AddXMLNode(node, 'PARTSID', PARTSID);
  AddXMLNode(node, 'FixedAssetDepreciationAccountName', FixedAssetDepreciationAccountName);
  AddXMLNode(node, 'FixedAssetDepreciationAccountID', FixedAssetDepreciationAccountID);
  AddXMLNode(node, 'SupplierName', SupplierName);
  AddXMLNode(node, 'SupplierID', SupplierID);
  AddXMLNode(node, 'BARCODE', BARCODE);
  AddXMLNode(node, 'DepreciationOption2', DepreciationOption2);
  AddXMLNode(node, 'Life2', Life2);
  AddXMLNode(node, 'SalvageType2', SalvageType2);
  AddXMLNode(node, 'Salvage2', Salvage2);
  AddXMLNode(node, 'SalvageFactor2', SalvageFactor2);
  AddXMLNode(node, 'PriorAccumDeprec2', PriorAccumDeprec2);
  AddXMLNode(node, 'PriorAccumDeprecDate2', PriorAccumDeprecDate2);
  AddXMLNode(node, 'PriorAccumDeprecAmount2', PriorAccumDeprecAmount2);
  AddXMLNode(node, 'DisposalDate2', DisposalDate2);
  AddXMLNode(node, 'DisposalBookValue2', DisposalBookValue2);
  AddXMLNode(node, 'DisposalAccumDeprec2', DisposalAccumDeprec2);
  AddXMLNode(node, 'SalesPrice2', SalesPrice2);
  AddXMLNode(node, 'FixedAssetCostAccountName2', FixedAssetCostAccountName2);
  AddXMLNode(node, 'FixedAssetCostAccountID2', FixedAssetCostAccountID2);
  AddXMLNode(node, 'ClearingAccountName2', ClearingAccountName2);
  AddXMLNode(node, 'ClearingAccountID2', ClearingAccountID2);
  AddXMLNode(node, 'FixedAssetDepreciationAccountName2', FixedAssetDepreciationAccountName2);
  AddXMLNode(node, 'FixedAssetDepreciationAccountID2', FixedAssetDepreciationAccountID2);
  AddXMLNode(node, 'BusinessUsePercent2', BusinessUsePercent2);
  AddXMLNode(node, 'FixedAssetDepreciationAssetAccountName',
    FixedAssetDepreciationAssetAccountName);
  AddXMLNode(node, 'FixedAssetDepreciationAssetAccountID', FixedAssetDepreciationAssetAccountID);
  AddXMLNode(node, 'FixedAssetDepreciationAssetAccountName2',
    FixedAssetDepreciationAssetAccountName2);
  AddXMLNode(node, 'FixedAssetDepreciationAssetAccountID2', FixedAssetDepreciationAssetAccountID2);
  AddXMLNode(node, 'CUSTDATE1', CUSTDATE1);
  AddXMLNode(node, 'CUSTDATE2', CUSTDATE2);
  AddXMLNode(node, 'CUSTDATE3', CUSTDATE3);
  AddXMLNode(node, 'ParentID', ParentID);
  AddXMLNode(node, 'TotalChildAsset', TotalChildAsset);
  AddXMLNode(node, 'LastTestDate', LastTestDate);
  AddXMLNode(node, 'NextTestDate', NextTestDate);
end;

function TFixedAssets.ValidateData: Boolean;
var
  msg: string;
begin
  Result := False;
  Resultstatus.Clear;
  if ClassID = 0 then begin
    AddResult(False, rssWarning, 0, AppEnv.DefaultClass.ClassHeading + ' cannot be blank.', True);
    Exit;
  end;

  if AssetType = '' then begin
    msg := 'Asset Type cannot be blank.';
    if AssetName <> '' then msg := msg + ' Asset Name "' + AssetName + '"';
    if AssetCode <> '' then msg := msg + ' Asset Code "' + AssetCode + '"';
    msg := msg + #13#10 + 'On Current Form or the Fixed Asset Form Please set this Value.';
    AddResult(False, rssWarning, 0, msg, True);
    Exit;
  end;

  if AssetName = '' then begin
    msg := 'Asset Name cannot be blank.';
    if AssetName <> '' then msg := msg + ' Asset Name "' + AssetName + '"';
    if AssetCode <> '' then msg := msg + ' Asset Code "' + AssetCode + '"';
    msg := msg + #13#10 + 'On Current Form or the Fixed Asset Form Please set this Value.';
    AddResult(False, rssWarning, 0, msg, True);
    Exit;
  end;

  if AssetCode = '' then begin
    msg := 'Asset Code cannot be blank.';
    if AssetName <> '' then msg := msg + ' Asset Name "' + AssetName + '"';
    if AssetCode <> '' then msg := msg + ' Asset Code "' + AssetCode + '"';
    msg := msg + #13#10 + 'On Current Form or the Fixed Asset Form Please set this Value.';
    AddResult(False, rssWarning, 0, msg, True);
    Exit;
  end;

  if DepreciationStartDate = 0 then begin
    msg := 'Depreciation Start Date cannot be blank.';
    if AssetName <> '' then msg := msg + ' Asset Name "' + AssetName + '"';
    if AssetCode <> '' then msg := msg + ' Asset Code "' + AssetCode + '"';
    msg := msg + #13#10 + 'On the Fixed Asset Form Please set this Value.';
    AddResult(False, rssWarning, 0, msg);
    Exit;
  end;

  if DepreciationStartDate < self.PurchDate then begin
    msg := 'Depreciation Start Date cannot be before the Purchase Date.';
    if AssetName <> '' then msg := msg + ' Asset Name "' + AssetName + '"';
    if AssetCode <> '' then msg := msg + ' Asset Code "' + AssetCode + '"';
    msg := msg + #13#10 + 'On the Fixed Asset Form Please correct this Value.';
    AddResult(False, rssWarning, 0, msg);
    Exit;
  end;

  if (AppEnv.CompanyPrefs.DepreciationForTransactions = 1) then begin
    if Empty(FixedAssetDepreciationAssetAccountName) <> Empty(FixedAssetDepreciationAccountName)
    then begin
      AddResult(False, rssWarning, 0, 'Both "Fixed Assets Depreciation Asset Account"' + #13#10 +
        ' AND "Fixed Assets Depreciation Expense Account" Must Be Entered.');
      SendEvent(BusObjEvent_ToDO, BusObjEvent_FA_DepAcc1_Invalid, self);
      Exit;
    end;
    if Empty(FixedAssetDepreciationAssetAccountName) <> Empty(FixedAssetDepreciationAccountName)
    then begin
      AddResult(False, rssWarning, 0, 'Both "Fixed Assets Cost Asset Account"' + #13#10 +
        ' AND "Fixed Assets Clearing Account" Must Be Entered.');
      SendEvent(BusObjEvent_ToDO, BusObjEvent_FA_DepAcc1_Invalid, self);
      Exit;
    end;

  end
  else if (AppEnv.CompanyPrefs.DepreciationForTransactions = 2) then begin
    if Empty(FixedAssetDepreciationAssetAccountName2) <> Empty(FixedAssetDepreciationAccountName2)
    then begin
      AddResult(False, rssWarning, 0, 'Both "Fixed Assets Depreciation Asset Account"' + #13#10 +
        ' AND "Fixed Assets Depreciation Expense Account" Must Be Entered.');
      SendEvent(BusObjEvent_ToDO, BusObjEvent_FA_DepAcc2_Invalid, self);
      Exit;
    end;
    if Empty(FixedAssetDepreciationAssetAccountName2) <> Empty(FixedAssetDepreciationAccountName2)
    then begin
      AddResult(False, rssWarning, 0, 'Both "Fixed Assets Cost Asset Account"' + #13#10 +
        ' AND "Fixed Assets Clearing Account" Must Be Entered.');
      SendEvent(BusObjEvent_ToDO, BusObjEvent_FA_DepAcc2_Invalid, self);
      Exit;
    end;
  end;

  fbAllLinesValid := True;
  fixedassetsdepreciationdetails1.IterateRecords(ValidateCallback);
  if not fbAllLinesValid then
    Exit;

  fbAllLinesValid := True;
  fixedassetsdepreciationdetails2.IterateRecords(ValidateCallback);
  if not fbAllLinesValid then
    Exit;

  fbAllLinesValid := True;
  AssetPicture.IterateRecords(ValidateCallback);
  if not fbAllLinesValid then
    Exit;

  fbAllLinesValid := True;
  FixedAssetPercentages.IterateRecords(ValidateCallback);
  if not fbAllLinesValid then
    Exit;

  if FAPercentageCostTotal <> 100 then begin
    AddResult(False, rssWarning, 0, 'Sum of Costs shoud be 100', True);
    SendEvent(BusObjEvent_ToDO, BusObjEvent_PercentageCostTotal_Invalid, self);
    Exit;
  end;

  if FAPercentageDepreciationTotal <> 100 then begin
    AddResult(False, rssWarning, 0, 'Sum of Depreciation  shoud be 100', True);
    SendEvent(BusObjEvent_ToDO, BusObjEvent_PercentageDeprTotal_Invalid, self);
    Exit;
  end;

  with TCustomFields.CustomFieldObj(self, 'cust') do begin
    if CF1 and CFIsRequired1 and (CUSTFLD1 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel1 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD1_Invalid, self);
    end
    else if CF2 and CFIsRequired2 and (CUSTFLD2 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel2 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD2_Invalid, self);
    end
    else if CF3 and CFIsRequired3 and (CUSTFLD3 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel3 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD3_Invalid, self);
    end
    else if CF4 and CFIsRequired4 and (CUSTFLD4 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel4 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD4_Invalid, self);
    end
    else if CF5 and CFIsRequired5 and (CUSTFLD5 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel5 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD5_Invalid, self);
    end
    else if CF6 and CFIsRequired6 and (CUSTFLD6 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel6 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD6_Invalid, self);
    end
    else if CF7 and CFIsRequired7 and (CUSTFLD7 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel7 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD7_Invalid, self);
    end
    else if CF8 and CFIsRequired8 and (CUSTFLD8 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel8 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD8_Invalid, self);
    end
    else if CF9 and CFIsRequired9 and (CUSTFLD9 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel9 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD9_Invalid, self);
    end
    else if CF10 and CFIsRequired10 and (CUSTFLD10 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel10 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD10_Invalid, self);
    end
    else if CF11 and CFIsRequired11 and (CUSTFLD11 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel11 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD11_Invalid, self);
    end
    else if CF12 and CFIsRequired12 and (CUSTFLD12 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel12 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD12_Invalid, self);
    end
    else if CF13 and CFIsRequired13 and (CUSTFLD13 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel13 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD13_Invalid, self);
    end
    else if CF14 and CFIsRequired14 and (CUSTFLD14 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel14 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD14_Invalid, self);
    end
    else if CF15 and CFIsRequired15 and (CUSTFLD15 = '') then begin
      AddResult(False, rssWarning, 0, CFLabel15 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD15_Invalid, self);
    end
    else if CF16 and CFIsRequired16 and (CUSTDATE1 = 0) then begin
      AddResult(False, rssWarning, 0, CFLabel16 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD16_Invalid, self);
    end
    else if CF17 and CFIsRequired17 and (CUSTDATE2 = 0) then begin
      AddResult(False, rssWarning, 0, CFLabel17 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD17_Invalid, self);
    end
    else if CF18 and CFIsRequired18 and (CUSTDATE3 = 0) then begin
      AddResult(False, rssWarning, 0, CFLabel18 + ' Should not be Blank', True);
      SendEvent(BusObjEvent_ToDO, BusObjEvent_CUSTFLD18_Invalid, self);
    end;
    Free;
  end;
  if not AssetHire.ValidateData then
    exit;

  Result := True;
end;

Procedure TFixedAssets.ValidateCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not Sender.ValidateData then begin
    Abort := True;
    fbAllLinesValid := False;
  end;
end;

function TFixedAssets.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  AssetHire.PostDb;
  if not AssetHire.Save then
    Exit;
  Result := inherited Save;
end;

procedure TFixedAssets.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TFixedAssets.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then
      Exit; // we are only interested in data fields.
  inherited;
  { ---- } if (SysUtils.SameText(Sender.FieldName, 'FixedAssetDepreciationAccountName')) then begin
    FixedAssetDepreciationAccountID := TAccount.IDToggle(FixedAssetDepreciationAccountName);

    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'FixedAssetCostAccountName')) then begin
    FixedAssetCostAccountID := TAccount.IDToggle(FixedAssetCostAccountName);

    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'ClearingAccountName')) then begin
    ClearingAccountID := TAccount.IDToggle(ClearingAccountName);

    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'FixedAssetDepreciationAssetAccountName')) then begin
    FixedAssetDepreciationAssetAccountID :=
      TAccount.IDToggle(FixedAssetDepreciationAssetAccountName);

    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'FixedAssetDepreciationAccountName2')) then begin
    FixedAssetDepreciationAccountID2 := TAccount.IDToggle(FixedAssetDepreciationAccountName2);

    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'FixedAssetCostAccountName2')) then begin
    FixedAssetCostAccountID2 := TAccount.IDToggle(FixedAssetCostAccountName2);

    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'ClearingAccountName2')) then begin
    ClearingAccountID2 := TAccount.IDToggle(ClearingAccountName2);

    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'FixedAssetDepreciationAssetAccountName2')) then
  begin
    FixedAssetDepreciationAssetAccountID2 :=
      TAccount.IDToggle(FixedAssetDepreciationAssetAccountName2);

    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'SalvageType')) then begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_SalvageType, self);

    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'SalvageType2')) then begin
    SendEvent(BusObjEvent_Change, BusObjEventVal_SalvageType2, self);

    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'PurchDate')) then begin
    if (CleanPurchDate <> 0) and (CleanPurchDate <> PurchDate) then begin
      if DepreciationStartDate < PurchDate then begin
        AddResult(False, rssWarning, 0,
          'You Have Set The Depreciation Start Date Before The Purchase Date !' + #13 + #10 + '' +
          #13 + #10 +
          'The Depreciation Start Date Will Automatically be Set To The Purchase Date.');
        DepreciationStartDate := PurchDate;
      end;
      DoFieldOnChange(Dataset.FindField('DepreciationStartDate'));
    end;
    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'DepreciationStartDate')) then begin
    if (CleanDepreciationStartDate <> 0) and (CleanDepreciationStartDate <> DepreciationStartDate)
    then begin
      if (DepreciationStartDate <= AppEnv.CompanyPrefs.ClosingDate) then begin
        AddResult(False, rssWarning, 0,
          'You Have Set The Depreciation Start Date Before The Closing Date !' + #13 + #10 + '' +
          #13 + #10 + 'The Date Will Automatically be Set To Today''s Date ' + #13 + #10 + '' + #13
          + #10 + 'OR' + #13 + #10 + '' + #13 + #10 + 'Reset The Closing Date In Preferences.');
        DepreciationStartDate := Now;
      end;
    end;
    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'SupplierName')) then begin
    SupplierID := TSupplier.IDToggle(SupplierName);
    { ---- } end
  else if (SysUtils.SameText(Sender.FieldName, 'PArtName')) then begin
    PARTSID := TProductSimple.IDToggle(PARTNAME);
  end;

  { ---- } if (SysUtils.SameText(Sender.FieldName, 'PurchDate')) or
    (SysUtils.SameText(Sender.FieldName, 'PurchCost')) or
    (SysUtils.SameText(Sender.FieldName, 'BusinessUsePercent')) or
    (SysUtils.SameText(Sender.FieldName, 'DepreciationOption')) or
    (SysUtils.SameText(Sender.FieldName, 'Life')) or
    (SysUtils.SameText(Sender.FieldName, 'SalvageType')) or
    (SysUtils.SameText(Sender.FieldName, 'Salvage')) or
    (SysUtils.SameText(Sender.FieldName, 'SalvageFactor')) or
    (SysUtils.SameText(Sender.FieldName, 'SalesPrice')) or
    (SysUtils.SameText(Sender.FieldName, 'PriorAccumDeprec')) or
    (SysUtils.SameText(Sender.FieldName, 'PriorAccumDeprecDate')) or
    (SysUtils.SameText(Sender.FieldName, 'PriorAccumDeprecAmount')) then begin
    SendEvent(BusObjEvent_ToDO, BusObjEvent_DoCalc, self);

  end;

end;

function TFixedAssets.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TFixedAssets.GetIDField: string;
begin
  Result := 'AssetID'
end;

class function TFixedAssets.GetBusObjectTablename: string;
begin
  Result := 'tblfixedassets';
end;

function TFixedAssets.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(Result) then
    Exit;

  InitAccounts;
  ClassID := AppEnv.DefaultClass.ClassID;
  Postdb;

  FixedAssetPercentages.New;
  FixedAssetPercentages.FAPClassName := AppEnv.DefaultClass.DefaultClassName;
  FixedAssetPercentages.Cost := 100;
  FixedAssetPercentages.Depreciation := 100;
  FixedAssetPercentages.Postdb;

end;

Procedure TFixedAssets.InitAccounts;
begin
  if FixedAssetDepreciationAccountName = '' then
    FixedAssetDepreciationAccountName := AppEnv.CompanyPrefs.FixedAssetDepreciationExpAccount;
  if FixedAssetCostAccountName = '' then
    FixedAssetCostAccountName := AppEnv.CompanyPrefs.FixedAssetCostAssetAccount;
  if ClearingAccountName = '' then
    ClearingAccountName := AppEnv.CompanyPrefs.FixedAssetClearingAccount;
  if FixedAssetDepreciationAssetAccountName = '' then
    FixedAssetDepreciationAssetAccountName :=
      AppEnv.CompanyPrefs.FixedAssetDepreciationAssetAccount;
  if FixedAssetDepreciationAccountName2 = '' then
    FixedAssetDepreciationAccountName2 := AppEnv.CompanyPrefs.FixedAssetDepreciationExpAccount;
  if FixedAssetCostAccountName2 = '' then
    FixedAssetCostAccountName2 := AppEnv.CompanyPrefs.FixedAssetCostAssetAccount;
  if ClearingAccountName2 = '' then
    ClearingAccountName2 := AppEnv.CompanyPrefs.FixedAssetClearingAccount;
  if FixedAssetDepreciationAssetAccountName2 = '' then
    FixedAssetDepreciationAssetAccountName2 :=
      AppEnv.CompanyPrefs.FixedAssetDepreciationAssetAccount;

end;

function TFixedAssets.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

class function TFixedAssets.GetKeyStringField: string;
begin
  Result := 'AssetName';
end;

{ Property Functions }
function TFixedAssets.GetAssetCode: string;
begin
  Result := GetStringField('AssetCode');
end;

function TFixedAssets.GetAssetName: string;
begin
  Result := GetStringField('AssetName');
end;

function TFixedAssets.GetPurchDate: TDateTime;
begin
  Result := GetDateTimeField('PurchDate');
end;

function TFixedAssets.GetPurchCost: Double;
begin
  Result := GetFloatField('PurchCost');
end;

function TFixedAssets.GetAssetType: string;
begin
  Result := GetStringField('AssetType');
end;

function TFixedAssets.GetClassID: Integer;
begin
  Result := GetIntegerField('ClassID');
end;

function TFixedAssets.GetLocationDescription: string;
begin
  Result := GetStringField('LocationDescription');
end;

function TFixedAssets.GetBrandName: string;
begin
  Result := GetStringField('BrandName');
end;

function TFixedAssets.GetManufacture: string;
begin
  Result := GetStringField('Manufacture');
end;

function TFixedAssets.GetModel: string;
begin
  Result := GetStringField('Model');
end;

function TFixedAssets.GetSerial: string;
begin
  Result := GetStringField('Serial');
end;

function TFixedAssets.GetNotes: string;
begin
  Result := GetStringField('Notes');
end;

function TFixedAssets.GetQty: Integer;
begin
  Result := GetIntegerField('Qty');
end;

function TFixedAssets.GetAssetCondition: string;
begin
  Result := GetStringField('AssetCondition');
end;

function TFixedAssets.GetAssetHire: TAssetHire;
begin
  if ID = 0 then
    PostDb;
  Result := TAssetHire(GetContainerComponent(TAssetHire, 'AssetId = ' + inttostr(ID),self.SilentMode, true, True));
end;

function TFixedAssets.GetColour: string;
begin
  Result := GetStringField('Colour');
end;

function TFixedAssets.GetSize: string;
begin
  Result := GetStringField('Size');
end;

function TFixedAssets.GetShape: string;
begin
  Result := GetStringField('Shape');
end;

function TFixedAssets.GetStatus: string;
begin
  Result := GetStringField('Status');
end;

function TFixedAssets.GetEstimatedValue: Double;
begin
  Result := GetFloatField('EstimatedValue');
end;

function TFixedAssets.GetReplacementCost: Double;
begin
  Result := GetFloatField('ReplacementCost');
end;

function TFixedAssets.GetWarrantyType: string;
begin
  Result := GetStringField('WarrantyType');
end;

function TFixedAssets.GetWarrantyExpiresDate: TDateTime;
begin
  Result := GetDateTimeField('WarrantyExpiresDate');
end;

function TFixedAssets.GetInsuredBy: string;
begin
  Result := GetStringField('InsuredBy');
end;

function TFixedAssets.GetInsurancePolicy: string;
begin
  Result := GetStringField('InsurancePolicy');
end;

function TFixedAssets.GetInsuredUntil: TDateTime;
begin
  Result := GetDateTimeField('InsuredUntil');
end;

function TFixedAssets.GetBusinessUsePercent: Double;
begin
  Result := GetFloatField('BusinessUsePercent');
end;

function TFixedAssets.GetCUSTFLD1: string;
begin
  Result := GetStringField('CUSTFLD1');
end;

function TFixedAssets.GetCUSTFLD2: string;
begin
  Result := GetStringField('CUSTFLD2');
end;

function TFixedAssets.GetCUSTFLD3: string;
begin
  Result := GetStringField('CUSTFLD3');
end;

function TFixedAssets.GetCUSTFLD4: string;
begin
  Result := GetStringField('CUSTFLD4');
end;

function TFixedAssets.GetCUSTFLD5: string;
begin
  Result := GetStringField('CUSTFLD5');
end;

function TFixedAssets.GetCUSTFLD6: string;
begin
  Result := GetStringField('CUSTFLD6');
end;

function TFixedAssets.GetCUSTFLD7: string;
begin
  Result := GetStringField('CUSTFLD7');
end;

function TFixedAssets.GetCUSTFLD8: string;
begin
  Result := GetStringField('CUSTFLD8');
end;

function TFixedAssets.GetCUSTFLD9: string;
begin
  Result := GetStringField('CUSTFLD9');
end;

function TFixedAssets.GetCUSTFLD10: string;
begin
  Result := GetStringField('CUSTFLD10');
end;

function TFixedAssets.GetCUSTFLD11: string;
begin
  Result := GetStringField('CUSTFLD11');
end;

function TFixedAssets.GetCUSTFLD12: string;
begin
  Result := GetStringField('CUSTFLD12');
end;

function TFixedAssets.GetCUSTFLD13: string;
begin
  Result := GetStringField('CUSTFLD13');
end;

function TFixedAssets.GetCUSTFLD14: string;
begin
  Result := GetStringField('CUSTFLD14');
end;

function TFixedAssets.GetCUSTFLD15: string;
begin
  Result := GetStringField('CUSTFLD15');
end;

function TFixedAssets.GetDepreciationOption: Integer;
begin
  Result := GetIntegerField('DepreciationOption');
end;

function TFixedAssets.GetLife: Double;
begin
  Result := GetFloatField('Life');
end;

function TFixedAssets.GetSalvageType: Integer;
begin
  Result := GetIntegerField('SalvageType');
end;

function TFixedAssets.GetSalvage: Double;
begin
  Result := GetFloatField('Salvage');
end;

function TFixedAssets.GetSalvageFactor: Double;
begin
  Result := GetFloatField('SalvageFactor');
end;

function TFixedAssets.GetPriorAccumDeprec: Boolean;
begin
  Result := GetBooleanField('PriorAccumDeprec');
end;

function TFixedAssets.GetPriorAccumDeprecDate: string;
begin
  Result := GetStringField('PriorAccumDeprecDate');
end;

function TFixedAssets.GetPriorAccumDeprecAmount: Double;
begin
  Result := GetFloatField('PriorAccumDeprecAmount');
end;

function TFixedAssets.GetDisposal: Boolean;
begin
  Result := GetBooleanField('Disposal');
end;

function TFixedAssets.GetDisposalDate: TDateTime;
begin
  Result := GetDateTimeField('DisposalDate');
end;

function TFixedAssets.GetDisposalBookValue: Double;
begin
  Result := GetFloatField('DisposalBookValue');
end;

function TFixedAssets.GetDisposalAccumDeprec: Double;
begin
  Result := GetFloatField('DisposalAccumDeprec');
end;

function TFixedAssets.GetSalesPrice: Double;
begin
  Result := GetFloatField('SalesPrice');
end;

function TFixedAssets.GetFixedAssetCostAccountName: string;
begin
  Result := GetStringField('FixedAssetCostAccountName');
end;

function TFixedAssets.GetFixedAssetCostAccountID: Integer;
begin
  Result := GetIntegerField('FixedAssetCostAccountID');
end;

function TFixedAssets.GetClearingAccountName: string;
begin
  Result := GetStringField('ClearingAccountName');
end;

function TFixedAssets.GetClearingAccountID: Integer;
begin
  Result := GetIntegerField('ClearingAccountID');
end;

function TFixedAssets.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TFixedAssets.GetPARTNAME: string;
begin
  Result := GetStringField('PARTNAME');
end;

function TFixedAssets.GetPARTSID: Integer;
begin
  Result := GetIntegerField('PARTSID');
end;

function TFixedAssets.GetFixedAssetDepreciationAccountName: string;
begin
  Result := GetStringField('FixedAssetDepreciationAccountName');
end;

function TFixedAssets.GetFixedAssetDepreciationAccountID: Integer;
begin
  Result := GetIntegerField('FixedAssetDepreciationAccountID');
end;

function TFixedAssets.GetSupplierName: string;
begin
  Result := GetStringField('SupplierName');
end;

function TFixedAssets.GetSupplierID: Integer;
begin
  Result := GetIntegerField('SupplierID');
end;

function TFixedAssets.GetBARCODE: string;
begin
  Result := GetStringField('BARCODE');
end;

function TFixedAssets.GetDepreciationOption2: Integer;
begin
  Result := GetIntegerField('DepreciationOption2');
end;

function TFixedAssets.GetDepreciationStartDate: TDateTime;
begin
  Result := GetDateTimeField('DepreciationStartDate');
end;

function TFixedAssets.GetDescription: string;
begin
  result := GetStringField('Description');
end;

function TFixedAssets.GetLife2: Double;
begin
  Result := GetFloatField('Life2');
end;

function TFixedAssets.GetSalvageType2: Integer;
begin
  Result := GetIntegerField('SalvageType2');
end;

function TFixedAssets.GetSalvage2: Double;
begin
  Result := GetFloatField('Salvage2');
end;

function TFixedAssets.GetSalvageFactor2: Double;
begin
  Result := GetFloatField('SalvageFactor2');
end;

function TFixedAssets.GetPriorAccumDeprec2: Boolean;
begin
  Result := GetBooleanField('PriorAccumDeprec2');
end;

function TFixedAssets.GetPriorAccumDeprecDate2: string;
begin
  Result := GetStringField('PriorAccumDeprecDate2');
end;

function TFixedAssets.GetPriorAccumDeprecAmount2: Double;
begin
  Result := GetFloatField('PriorAccumDeprecAmount2');
end;

function TFixedAssets.GetDisposalDate2: TDateTime;
begin
  Result := GetDateTimeField('DisposalDate2');
end;

function TFixedAssets.GetDisposalBookValue2: Double;
begin
  Result := GetFloatField('DisposalBookValue2');
end;

function TFixedAssets.GetDisposalAccumDeprec2: Double;
begin
  Result := GetFloatField('DisposalAccumDeprec2');
end;

function TFixedAssets.GetSalesPrice2: Double;
begin
  Result := GetFloatField('SalesPrice2');
end;

function TFixedAssets.GetFixedAssetCostAccountName2: string;
begin
  Result := GetStringField('FixedAssetCostAccountName2');
end;

function TFixedAssets.GetFixedAssetCostAccountID2: Integer;
begin
  Result := GetIntegerField('FixedAssetCostAccountID2');
end;

function TFixedAssets.GetClearingAccountName2: string;
begin
  Result := GetStringField('ClearingAccountName2');
end;

function TFixedAssets.GetClearingAccountID2: Integer;
begin
  Result := GetIntegerField('ClearingAccountID2');
end;

function TFixedAssets.GetFixedAssetDepreciationAccountName2: string;
begin
  Result := GetStringField('FixedAssetDepreciationAccountName2');
end;

function TFixedAssets.GetFixedAssetDepreciationAccountID2: Integer;
begin
  Result := GetIntegerField('FixedAssetDepreciationAccountID2');
end;

function TFixedAssets.GetBusinessUsePercent2: Double;
begin
  Result := GetFloatField('BusinessUsePercent2');
end;

function TFixedAssets.GetFixedAssetDepreciationAssetAccountName: string;
begin
  Result := GetStringField('FixedAssetDepreciationAssetAccountName');
end;

function TFixedAssets.GetFixedAssetDepreciationAssetAccountID: Integer;
begin
  Result := GetIntegerField('FixedAssetDepreciationAssetAccountID');
end;

function TFixedAssets.GetFixedAssetDepreciationAssetAccountName2: string;
begin
  Result := GetStringField('FixedAssetDepreciationAssetAccountName2');
end;

function TFixedAssets.GetFixedAssetDepreciationAssetAccountID2: Integer;
begin
  Result := GetIntegerField('FixedAssetDepreciationAssetAccountID2');
end;

function TFixedAssets.GetCUSTDATE1: TDateTime;
begin
  Result := GetDateTimeField('CUSTDATE1');
end;

function TFixedAssets.GetCUSTDATE2: TDateTime;
begin
  Result := GetDateTimeField('CUSTDATE2');
end;

function TFixedAssets.GetCUSTDATE3: TDateTime;
begin
  Result := GetDateTimeField('CUSTDATE3');
end;

function TFixedAssets.GetParentID: Integer;
begin
  Result := GetIntegerField('ParentID');
end;

function TFixedAssets.GetTotalChildAsset: Double;
begin
  Result := GetFloatField('TotalChildAsset');
end;

function TFixedAssets.GetLastTestDate: TDateTime;
begin
  Result := GetDateTimeField('LastTestDate');
end;

function TFixedAssets.GetNextTestDate: TDateTime;
begin
  Result := GetDateTimeField('NextTestDate');
end;

function TFixedAssets.getCleanDepreciationStartDate: TDateTime;
begin
  Result := GetXMLNodeDateTimeValue(CleanXMLNode, 'DepreciationStartDate');
end;

function TFixedAssets.getCleanPurchDate: TDateTime;
begin
  Result := GetXMLNodeDateTimeValue(CleanXMLNode, 'PurchDate');
end;

procedure TFixedAssets.SetAssetCode(const Value: string);
begin
  SetStringField('AssetCode', Value);
end;

procedure TFixedAssets.SetAssetName(const Value: string);
begin
  SetStringField('AssetName', Value);
end;

procedure TFixedAssets.SetPurchDate(const Value: TDateTime);
begin
  SetDateTimeField('PurchDate', Value);
end;

procedure TFixedAssets.SetPurchCost(const Value: Double);
begin
  SetFloatField('PurchCost', Value);
end;

procedure TFixedAssets.SetAssetType(const Value: string);
begin
  SetStringField('AssetType', Value);
end;

procedure TFixedAssets.SetClassID(const Value: Integer);
begin
  SetIntegerField('ClassID', Value);
end;

procedure TFixedAssets.SetLocationDescription(const Value: string);
begin
  SetStringField('LocationDescription', Value);
end;

procedure TFixedAssets.SetBrandName(const Value: string);
begin
  SetStringField('BrandName', Value);
end;

procedure TFixedAssets.SetManufacture(const Value: string);
begin
  SetStringField('Manufacture', Value);
end;

procedure TFixedAssets.SetModel(const Value: string);
begin
  SetStringField('Model', Value);
end;

procedure TFixedAssets.SetSerial(const Value: string);
begin
  SetStringField('Serial', Value);
end;

procedure TFixedAssets.SetNotes(const Value: string);
begin
  SetStringField('Notes', Value);
end;

procedure TFixedAssets.SetQty(const Value: Integer);
begin
  SetIntegerField('Qty', Value);
end;

procedure TFixedAssets.SetAssetCondition(const Value: string);
begin
  SetStringField('AssetCondition', Value);
end;

procedure TFixedAssets.SetColour(const Value: string);
begin
  SetStringField('Colour', Value);
end;

procedure TFixedAssets.SetSize(const Value: string);
begin
  SetStringField('Size', Value);
end;

procedure TFixedAssets.SetShape(const Value: string);
begin
  SetStringField('Shape', Value);
end;

procedure TFixedAssets.SetStatus(const Value: string);
begin
  SetStringField('Status', Value);
end;

procedure TFixedAssets.SetEstimatedValue(const Value: Double);
begin
  SetFloatField('EstimatedValue', Value);
end;

procedure TFixedAssets.SetReplacementCost(const Value: Double);
begin
  SetFloatField('ReplacementCost', Value);
end;

procedure TFixedAssets.SetWarrantyType(const Value: string);
begin
  SetStringField('WarrantyType', Value);
end;

procedure TFixedAssets.SetWarrantyExpiresDate(const Value: TDateTime);
begin
  SetDateTimeField('WarrantyExpiresDate', Value);
end;

procedure TFixedAssets.SetInsuredBy(const Value: string);
begin
  SetStringField('InsuredBy', Value);
end;

procedure TFixedAssets.SetInsurancePolicy(const Value: string);
begin
  SetStringField('InsurancePolicy', Value);
end;

procedure TFixedAssets.SetInsuredUntil(const Value: TDateTime);
begin
  SetDateTimeField('InsuredUntil', Value);
end;

procedure TFixedAssets.SetBusinessUsePercent(const Value: Double);
begin
  SetFloatField('BusinessUsePercent', Value);
end;

procedure TFixedAssets.SetCUSTFLD1(const Value: string);
begin
  SetStringField('CUSTFLD1', Value);
end;

procedure TFixedAssets.SetCUSTFLD2(const Value: string);
begin
  SetStringField('CUSTFLD2', Value);
end;

procedure TFixedAssets.SetCUSTFLD3(const Value: string);
begin
  SetStringField('CUSTFLD3', Value);
end;

procedure TFixedAssets.SetCUSTFLD4(const Value: string);
begin
  SetStringField('CUSTFLD4', Value);
end;

procedure TFixedAssets.SetCUSTFLD5(const Value: string);
begin
  SetStringField('CUSTFLD5', Value);
end;

procedure TFixedAssets.SetCUSTFLD6(const Value: string);
begin
  SetStringField('CUSTFLD6', Value);
end;

procedure TFixedAssets.SetCUSTFLD7(const Value: string);
begin
  SetStringField('CUSTFLD7', Value);
end;

procedure TFixedAssets.SetCUSTFLD8(const Value: string);
begin
  SetStringField('CUSTFLD8', Value);
end;

procedure TFixedAssets.SetCUSTFLD9(const Value: string);
begin
  SetStringField('CUSTFLD9', Value);
end;

procedure TFixedAssets.SetCUSTFLD10(const Value: string);
begin
  SetStringField('CUSTFLD10', Value);
end;

procedure TFixedAssets.SetCUSTFLD11(const Value: string);
begin
  SetStringField('CUSTFLD11', Value);
end;

procedure TFixedAssets.SetCUSTFLD12(const Value: string);
begin
  SetStringField('CUSTFLD12', Value);
end;

procedure TFixedAssets.SetCUSTFLD13(const Value: string);
begin
  SetStringField('CUSTFLD13', Value);
end;

procedure TFixedAssets.SetCUSTFLD14(const Value: string);
begin
  SetStringField('CUSTFLD14', Value);
end;

procedure TFixedAssets.SetCUSTFLD15(const Value: string);
begin
  SetStringField('CUSTFLD15', Value);
end;

procedure TFixedAssets.SetDepreciationOption(const Value: Integer);
begin
  SetIntegerField('DepreciationOption', Value);
end;

procedure TFixedAssets.SetLife(const Value: Double);
begin
  SetFloatField('Life', Value);
end;

procedure TFixedAssets.SetSalvageType(const Value: Integer);
begin
  SetIntegerField('SalvageType', Value);
end;

procedure TFixedAssets.SetSalvage(const Value: Double);
begin
  SetFloatField('Salvage', Value);
end;

procedure TFixedAssets.SetSalvageFactor(const Value: Double);
begin
  SetFloatField('SalvageFactor', Value);
end;

procedure TFixedAssets.SetPriorAccumDeprec(const Value: Boolean);
begin
  SetBooleanField('PriorAccumDeprec', Value);
end;

procedure TFixedAssets.SetPriorAccumDeprecDate(const Value: string);
begin
  SetStringField('PriorAccumDeprecDate', Value);
end;

procedure TFixedAssets.SetPriorAccumDeprecAmount(const Value: Double);
begin
  SetFloatField('PriorAccumDeprecAmount', Value);
end;

procedure TFixedAssets.SetDisposal(const Value: Boolean);
begin
  SetBooleanField('Disposal', Value);
end;

procedure TFixedAssets.SetDisposalDate(const Value: TDateTime);
begin
  SetDateTimeField('DisposalDate', Value);
end;

procedure TFixedAssets.SetDisposalBookValue(const Value: Double);
begin
  SetFloatField('DisposalBookValue', Value);
end;

procedure TFixedAssets.SetDisposalAccumDeprec(const Value: Double);
begin
  SetFloatField('DisposalAccumDeprec', Value);
end;

procedure TFixedAssets.SetSalesPrice(const Value: Double);
begin
  SetFloatField('SalesPrice', Value);
end;

procedure TFixedAssets.SetFixedAssetCostAccountName(const Value: string);
begin
  SetStringField('FixedAssetCostAccountName', Value);
end;

procedure TFixedAssets.SetFixedAssetCostAccountID(const Value: Integer);
begin
  SetIntegerField('FixedAssetCostAccountID', Value);
end;

procedure TFixedAssets.SetClearingAccountName(const Value: string);
begin
  SetStringField('ClearingAccountName', Value);
end;

procedure TFixedAssets.SetClearingAccountID(const Value: Integer);
begin
  SetIntegerField('ClearingAccountID', Value);
end;

procedure TFixedAssets.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TFixedAssets.SetPARTNAME(const Value: string);
begin
  SetStringField('PARTNAME', Value);
end;

procedure TFixedAssets.SetPARTSID(const Value: Integer);
begin
  SetIntegerField('PARTSID', Value);
end;

procedure TFixedAssets.SetFixedAssetDepreciationAccountName(const Value: string);
begin
  SetStringField('FixedAssetDepreciationAccountName', Value);
end;

procedure TFixedAssets.SetFixedAssetDepreciationAccountID(const Value: Integer);
begin
  SetIntegerField('FixedAssetDepreciationAccountID', Value);
end;

procedure TFixedAssets.SetSupplierName(const Value: string);
begin
  SetStringField('SupplierName', Value);
end;

procedure TFixedAssets.SetSupplierID(const Value: Integer);
begin
  SetIntegerField('SupplierID', Value);
end;

procedure TFixedAssets.SetBARCODE(const Value: string);
begin
  SetStringField('BARCODE', Value);
end;

procedure TFixedAssets.SetDepreciationOption2(const Value: Integer);
begin
  SetIntegerField('DepreciationOption2', Value);
end;

procedure TFixedAssets.SetDepreciationStartDate(const Value: TDateTime);
begin
  SetDateTimeField('DepreciationStartDate', Value);
end;

procedure TFixedAssets.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TFixedAssets.SetLife2(const Value: Double);
begin
  SetFloatField('Life2', Value);
end;

procedure TFixedAssets.SetSalvageType2(const Value: Integer);
begin
  SetIntegerField('SalvageType2', Value);
end;

procedure TFixedAssets.SetSalvage2(const Value: Double);
begin
  SetFloatField('Salvage2', Value);
end;

procedure TFixedAssets.SetSalvageFactor2(const Value: Double);
begin
  SetFloatField('SalvageFactor2', Value);
end;

procedure TFixedAssets.SetPriorAccumDeprec2(const Value: Boolean);
begin
  SetBooleanField('PriorAccumDeprec2', Value);
end;

procedure TFixedAssets.SetPriorAccumDeprecDate2(const Value: string);
begin
  SetStringField('PriorAccumDeprecDate2', Value);
end;

procedure TFixedAssets.SetPriorAccumDeprecAmount2(const Value: Double);
begin
  SetFloatField('PriorAccumDeprecAmount2', Value);
end;

procedure TFixedAssets.SetDisposalDate2(const Value: TDateTime);
begin
  SetDateTimeField('DisposalDate2', Value);
end;

procedure TFixedAssets.SetDisposalBookValue2(const Value: Double);
begin
  SetFloatField('DisposalBookValue2', Value);
end;

procedure TFixedAssets.SetDisposalAccumDeprec2(const Value: Double);
begin
  SetFloatField('DisposalAccumDeprec2', Value);
end;

procedure TFixedAssets.SetSalesPrice2(const Value: Double);
begin
  SetFloatField('SalesPrice2', Value);
end;

procedure TFixedAssets.SetFixedAssetCostAccountName2(const Value: string);
begin
  SetStringField('FixedAssetCostAccountName2', Value);
end;

procedure TFixedAssets.SetFixedAssetCostAccountID2(const Value: Integer);
begin
  SetIntegerField('FixedAssetCostAccountID2', Value);
end;

procedure TFixedAssets.SetClearingAccountName2(const Value: string);
begin
  SetStringField('ClearingAccountName2', Value);
end;

procedure TFixedAssets.SetClearingAccountID2(const Value: Integer);
begin
  SetIntegerField('ClearingAccountID2', Value);
end;

procedure TFixedAssets.SetFixedAssetDepreciationAccountName2(const Value: string);
begin
  SetStringField('FixedAssetDepreciationAccountName2', Value);
end;

procedure TFixedAssets.SetFixedAssetDepreciationAccountID2(const Value: Integer);
begin
  SetIntegerField('FixedAssetDepreciationAccountID2', Value);
end;

procedure TFixedAssets.SetBusinessUsePercent2(const Value: Double);
begin
  SetFloatField('BusinessUsePercent2', Value);
end;

procedure TFixedAssets.SetFixedAssetDepreciationAssetAccountName(const Value: string);
begin
  SetStringField('FixedAssetDepreciationAssetAccountName', Value);
end;

procedure TFixedAssets.SetFixedAssetDepreciationAssetAccountID(const Value: Integer);
begin
  SetIntegerField('FixedAssetDepreciationAssetAccountID', Value);
end;

procedure TFixedAssets.SetFixedAssetDepreciationAssetAccountName2(const Value: string);
begin
  SetStringField('FixedAssetDepreciationAssetAccountName2', Value);
end;

procedure TFixedAssets.SetFixedAssetDepreciationAssetAccountID2(const Value: Integer);
begin
  SetIntegerField('FixedAssetDepreciationAssetAccountID2', Value);
end;

procedure TFixedAssets.SetCUSTDATE1(const Value: TDateTime);
begin
  SetDateTimeField('CUSTDATE1', Value);
end;

procedure TFixedAssets.SetCUSTDATE2(const Value: TDateTime);
begin
  SetDateTimeField('CUSTDATE2', Value);
end;

procedure TFixedAssets.SetCUSTDATE3(const Value: TDateTime);
begin
  SetDateTimeField('CUSTDATE3', Value);
end;

procedure TFixedAssets.SetParentID(const Value: Integer);
begin
  SetIntegerField('ParentID', Value);
end;

procedure TFixedAssets.SetTotalChildAsset(const Value: Double);
begin
  SetFloatField('TotalChildAsset', Value);
end;

procedure TFixedAssets.SetLastTestDate(const Value: TDateTime);
begin
  SetDateTimeField('LastTestDate', Value);
end;

procedure TFixedAssets.SetNextTestDate(const Value: TDateTime);
begin
  SetDateTimeField('NextTestDate', Value);
end;

function TFixedAssets.getProduct: TProductSimple;
begin
  Result := TProductSimple(getContainerComponent(TProductSimple, 'PartsId =' + inttostr(PARTSID),
    self.SilentMode, False, True));
end;

function TFixedAssets.getfixedassetsdepreciationdetails1: Tfixedassetsdepreciationdetails1;
begin
  Result := Tfixedassetsdepreciationdetails1(getContainerComponent(Tfixedassetsdepreciationdetails1,
    'AssetID = ' + inttostr(ID)));
end;

function TFixedAssets.getfixedassetsdepreciationdetails2: Tfixedassetsdepreciationdetails2;
begin
  Result := Tfixedassetsdepreciationdetails2(getContainerComponent(Tfixedassetsdepreciationdetails2,
    'AssetID = ' + inttostr(ID)));
end;

function TFixedAssets.getAssetPicture: TAssetPicture;
begin
  Result := TAssetPicture(getContainerComponent(TAssetPicture, 'AssetID = ' + inttostr(ID)));
end;

function TFixedAssets.getFixedAssetPercentages: TFixedAssetPercentages;
begin
  Result := TFixedAssetPercentages(getContainerComponent(TFixedAssetPercentages,
    'AssetID = ' + inttostr(ID)));
end;

function TFixedAssets.getFAPercentageCostTotal: Double;
begin
  fdValue := 0;
  FixedAssetPercentages.IterateRecords(FAPercentageCostTotalCallback);
  Result := fdValue;
end;

function TFixedAssets.getFAPercentageDepreciationTotal: Double;
begin
  fdValue := 0;
  FixedAssetPercentages.IterateRecords(FAPercentageDepreciationTotalCallback);
  Result := fdValue;
end;

Procedure TFixedAssets.FAPercentageDepreciationTotalCallback(const Sender: TBusObj;
  var Abort: Boolean);
begin
  if not(Sender is TFixedAssetPercentages) then
    Exit;
  fdValue := fdValue + TFixedAssetPercentages(Sender).Depreciation;
end;

Procedure TFixedAssets.FAPercentageCostTotalCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TFixedAssetPercentages) then
    Exit;
  fdValue := fdValue + TFixedAssetPercentages(Sender).Cost;
end;

{ TAssetPicture }

constructor TAssetPicture.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'AssetPicture';
  fSQL := 'SELECT * FROM tblassetpicture';
end;

procedure TAssetPicture.CreateInstance;
begin
  inherited;
  if Owner is TFixedAssets then
    if Assigned(TFixedAssets(Owner).ObjInstanceToClone) then
      if TFixedAssets(Owner).ObjInstanceToClone is TFixedAssets then
        ObjInstanceToClone := TFixedAssets(TFixedAssets(Owner).ObjInstanceToClone).AssetPicture;

end;

destructor TAssetPicture.Destroy;
begin
  inherited;
end;

procedure TAssetPicture.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'AssetId');
  SetPropertyFromNode(node, 'Imagetype');
end;

procedure TAssetPicture.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'AssetId', AssetId);
  AddXMLNode(node, 'Imagetype', Imagetype);
end;

function TAssetPicture.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if AssetId = 0 then begin
    AddResult(False, rssError, 0, 'AssetId should not be 0', True);
    Exit;
  end;
  Result := True;
end;

function TAssetPicture.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TAssetPicture.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TAssetPicture.Picturefieldname: String;
begin
  Result := 'Image';
end;

function TAssetPicture.Picturetypefieldname: String;
begin
  Result := 'Imagetype';
end;

procedure TAssetPicture.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TAssetPicture.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TAssetPicture.GetIDField: string;
begin
  Result := 'AssetPictureId'
end;

class function TAssetPicture.GetBusObjectTablename: string;
begin
  Result := 'tblassetpicture';
end;

function TAssetPicture.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(Result) then
    Exit;
  if Assigned(Owner) then
    if Owner is TFixedAssets then
      AssetId := TFixedAssets(Owner).ID;
end;

function TAssetPicture.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TAssetPicture.GetAssetId: Integer;
begin
  Result := GetIntegerField('AssetId');
end;

function TAssetPicture.GetImagetype: string;
begin
  Result := GetStringField('Imagetype');
end;

procedure TAssetPicture.SetAssetId(const Value: Integer);
begin
  SetIntegerField('AssetId', Value);
end;

procedure TAssetPicture.SetImagetype(const Value: string);
begin
  SetStringField('Imagetype', Value);
end;

{ TfixedassetsdepreciationdetailsBase }

constructor TfixedassetsdepreciationdetailsBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TfixedassetsdepreciationdetailsBase.Destroy;
begin
  inherited;
end;

procedure TfixedassetsdepreciationdetailsBase.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'AssetID');
  SetPropertyFromNode(node, 'Year');
  SetPropertyFromNode(node, 'Month');
  SetPropertyFromNode(node, 'MonthNo');
  SetPropertyFromNode(node, 'Depreciation');
  SetPropertyFromNode(node, 'TotalDepreciation');
  SetPropertyFromNode(node, 'BookValue');
  SetDateTimePropertyFromNode(node, 'Date');
end;

procedure TfixedassetsdepreciationdetailsBase.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'AssetID', AssetId);
  AddXMLNode(node, 'Year', Year);
  AddXMLNode(node, 'Month', Month);
  AddXMLNode(node, 'MonthNo', MonthNo);
  AddXMLNode(node, 'Depreciation', Depreciation);
  AddXMLNode(node, 'TotalDepreciation', TotalDepreciation);
  AddXMLNode(node, 'BookValue', BookValue);
  AddXMLNode(node, 'Date', Date);
end;

function TfixedassetsdepreciationdetailsBase.ValidateData: Boolean;
begin
//  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TfixedassetsdepreciationdetailsBase.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TfixedassetsdepreciationdetailsBase.OnDataIdChange(Const ChangeType
  : TBusObjDataChangeType);
begin
  inherited;
end;

procedure TfixedassetsdepreciationdetailsBase.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TfixedassetsdepreciationdetailsBase.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TfixedassetsdepreciationdetailsBase.GetIDField: string;
begin
  Result := 'AssetDepreciationID'
end;

function TfixedassetsdepreciationdetailsBase.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(Result) then
    Exit;
  if Assigned(Owner) then
    if Owner is TFixedAssets then
      AssetId := TFixedAssets(Owner).ID;
end;

function TfixedassetsdepreciationdetailsBase.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TfixedassetsdepreciationdetailsBase.GetAssetId: Integer;
begin
  Result := GetIntegerField('AssetID');
end;

function TfixedassetsdepreciationdetailsBase.GetYear: string;
begin
  Result := GetStringField('Year');
end;

function TfixedassetsdepreciationdetailsBase.GetMonth: string;
begin
  Result := GetStringField('Month');
end;

function TfixedassetsdepreciationdetailsBase.GetMonthNo: Integer;
begin
  Result := GetIntegerField('MonthNo');
end;

function TfixedassetsdepreciationdetailsBase.GetDepreciation: Double;
begin
  Result := GetFloatField('Depreciation');
end;

function TfixedassetsdepreciationdetailsBase.GetTotalDepreciation: Double;
begin
  Result := GetFloatField('TotalDepreciation');
end;

function TfixedassetsdepreciationdetailsBase.GetBookValue: Double;
begin
  Result := GetFloatField('BookValue');
end;

function TfixedassetsdepreciationdetailsBase.GetDate: TDateTime;
begin
  Result := GetDateTimeField('Date');
end;

procedure TfixedassetsdepreciationdetailsBase.SetAssetId(const Value: Integer);
begin
  SetIntegerField('AssetID', Value);
end;

procedure TfixedassetsdepreciationdetailsBase.SetYear(const Value: string);
begin
  SetStringField('Year', Value);
end;

procedure TfixedassetsdepreciationdetailsBase.SetMonth(const Value: string);
begin
  SetStringField('Month', Value);
end;

procedure TfixedassetsdepreciationdetailsBase.SetMonthNo(const Value: Integer);
begin
  SetIntegerField('MonthNo', Value);
end;

procedure TfixedassetsdepreciationdetailsBase.SetDepreciation(const Value: Double);
begin
  SetFloatField('Depreciation', Value);
end;

procedure TfixedassetsdepreciationdetailsBase.SetTotalDepreciation(const Value: Double);
begin
  SetFloatField('TotalDepreciation', Value);
end;

procedure TfixedassetsdepreciationdetailsBase.SetBookValue(const Value: Double);
begin
  SetFloatField('BookValue', Value);
end;

procedure TfixedassetsdepreciationdetailsBase.SetDate(const Value: TDateTime);
begin
  SetDateTimeField('Date', Value);
end;

{ Tfixedassetsdepreciationdetails1 }

constructor Tfixedassetsdepreciationdetails1.Create(AOwner: TComponent);
begin
  inherited;
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'fixedassetsdepreciationdetails';
  fSQL := 'SELECT * FROM tblfixedassetsdepreciationdetails';

end;

procedure Tfixedassetsdepreciationdetails1.CreateInstance;
begin
  inherited;
  if Owner is TFixedAssets then
    if Assigned(TFixedAssets(Owner).ObjInstanceToClone) then
      if TFixedAssets(Owner).ObjInstanceToClone is TFixedAssets then
        ObjInstanceToClone := TFixedAssets(TFixedAssets(Owner).ObjInstanceToClone)
          .fixedassetsdepreciationdetails1;

end;

class function Tfixedassetsdepreciationdetails1.GetBusObjectTablename: string;
begin
  Result := 'tblfixedassetsdepreciationdetails';
end;

{ Tfixedassetsdepreciationdetails2 }

constructor Tfixedassetsdepreciationdetails2.Create(AOwner: TComponent);
begin
  inherited;
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'fixedassetsdepreciationdetails2';
  fSQL := 'SELECT * FROM tblfixedassetsdepreciationdetails2';
end;

procedure Tfixedassetsdepreciationdetails2.CreateInstance;
begin
  inherited;
  if Owner is TFixedAssets then
    if Assigned(TFixedAssets(Owner).ObjInstanceToClone) then
      if TFixedAssets(Owner).ObjInstanceToClone is TFixedAssets then
        ObjInstanceToClone := TFixedAssets(TFixedAssets(Owner).ObjInstanceToClone)
          .fixedassetsdepreciationdetails2;
end;

class function Tfixedassetsdepreciationdetails2.GetBusObjectTablename: string;
begin
  Result := 'tblfixedassetsdepreciationdetails2';
end;

{ TFixedAssetPercentages }

constructor TFixedAssetPercentages.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'FixedAssetPercentages';
  fSQL := 'SELECT * FROM tblfixedassetpercentages';
end;

procedure TFixedAssetPercentages.CreateInstance;
begin
  inherited;
  if Owner is TFixedAssets then
    if Assigned(TFixedAssets(Owner).ObjInstanceToClone) then
      if TFixedAssets(Owner).ObjInstanceToClone is TFixedAssets then
        ObjInstanceToClone := TFixedAssets(TFixedAssets(Owner).ObjInstanceToClone)
          .FixedAssetPercentages;
end;

destructor TFixedAssetPercentages.Destroy;
begin
  inherited;
end;

procedure TFixedAssetPercentages.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'AssetID');
  SetPropertyFromNode(node, 'ClassID');
  SetPropertyFromNode(node, 'Cost');
  SetPropertyFromNode(node, 'Depreciation');
  SetPropertyFromNode(node, 'Description');
  SetBooleanPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'ClassName');
end;

procedure TFixedAssetPercentages.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'AssetID', AssetId);
  AddXMLNode(node, 'ClassID', ClassID);
  AddXMLNode(node, 'Cost', Cost);
  AddXMLNode(node, 'Depreciation', Depreciation);
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'FAPClassName', FAPClassName);
end;

function TFixedAssetPercentages.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if AssetId = 0 then begin
    AddResult(False, rssError, 0, 'AssetID should not be 0', True);
    Exit;
  end;
  if ClassID = 0 then begin
    AddResult(False, rssError, 0, 'ClassID should not be 0', True);
    Exit;
  end;
  Result := True;
end;

function TFixedAssetPercentages.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TFixedAssetPercentages.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TFixedAssetPercentages.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then
      Exit; // we are only interested in data fields.
  inherited;
  { ---- } if (SysUtils.SameText(Sender.FieldName, 'Classname')) then begin
    ClassID := TDeptClass.IDToggle(FAPClassName);
  end;
end;

function TFixedAssetPercentages.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TFixedAssetPercentages.GetIDField: string;
begin
  Result := 'AssetPercentagesID'
end;

class function TFixedAssetPercentages.GetBusObjectTablename: string;
begin
  Result := 'tblfixedassetpercentages';
end;

function TFixedAssetPercentages.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not Result then
    Exit;

  if Assigned(Owner) then
    if Owner is TFixedAssets then
      AssetId := TFixedAssets(Owner).ID;
end;

function TFixedAssetPercentages.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TFixedAssetPercentages.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then
    Exit;
  if FAPClassName = '' then
    FAPClassName := AppEnv.DefaultClass.DefaultClassName;
end;

{ Property Functions }
function TFixedAssetPercentages.GetAssetId: Integer;
begin
  Result := GetIntegerField('AssetID');
end;

function TFixedAssetPercentages.GetClassID: Integer;
begin
  Result := GetIntegerField('ClassID');
end;

function TFixedAssetPercentages.GetCost: Double;
begin
  Result := GetFloatField('Cost');
end;

function TFixedAssetPercentages.GetDepreciation: Double;
begin
  Result := GetFloatField('Depreciation');
end;

function TFixedAssetPercentages.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function TFixedAssetPercentages.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TFixedAssetPercentages.GetFAPClassName: string;
begin
  Result := GetStringField('ClassName');
end;

procedure TFixedAssetPercentages.SetAssetId(const Value: Integer);
begin
  SetIntegerField('AssetID', Value);
end;

procedure TFixedAssetPercentages.SetClassID(const Value: Integer);
begin
  SetIntegerField('ClassID', Value);
end;

procedure TFixedAssetPercentages.SetCost(const Value: Double);
begin
  SetFloatField('Cost', Value);
end;

procedure TFixedAssetPercentages.SetDepreciation(const Value: Double);
begin
  SetFloatField('Depreciation', Value);
end;

procedure TFixedAssetPercentages.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TFixedAssetPercentages.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TFixedAssetPercentages.SetFAPClassName(const Value: string);
begin
  SetStringField('ClassName', Value);
end;

{ TFixedAssetType }

constructor TFixedAssetType.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'FixedAssetType';
  fSQL := 'SELECT * FROM tblfixedassettypes';
end;

destructor TFixedAssetType.Destroy;
begin

  inherited;
end;

function TFixedAssetType.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

function TFixedAssetType.GetAssetTypeCode: string;
begin
  result := GetStringField('AssetTypeCode');
end;

function TFixedAssetType.GetAssetTypeName: string;
begin
  result := GetStringField('AssetTypeName');
end;

class function TFixedAssetType.GetBusObjectTablename: string;
begin
  result := 'tblfixedassettypes';
end;

function TFixedAssetType.GetDepreciationOption: integer;
begin
  result := GetIntegerField('DepreciationOption');
end;

class function TFixedAssetType.GetIDField: string;
begin
  result := 'AssetTypeID';
end;

class function TFixedAssetType.GetKeyStringField: string;
begin
  inherited;
end;

function TFixedAssetType.GetLife: double;
begin
  result := GetFloatField('Life');
end;

function TFixedAssetType.GetNotes: string;
begin
  result := GetStringField('Notes');
end;

function TFixedAssetType.GetSalvage: double;
begin
  result := GetFloatField('Salvage');
end;

function TFixedAssetType.GetSalvageFactor: double;
begin
  result := GetFloatField('SalvageFactor');
end;

function TFixedAssetType.GetSalvageType: integer;
begin
  result := GetIntegerField('SalvageType');
end;

function TFixedAssetType.Save: Boolean;
begin
  ResultStatus.Clear;
  result := ValidateData;
  if result then
    result := inherited;
end;

procedure TFixedAssetType.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TFixedAssetType.SetAssetTypeCode(const Value: string);
begin
  SetStringField('AssetTypeCode', Value);
end;

procedure TFixedAssetType.SetAssetTypeName(const Value: string);
begin
  SetStringField('AssetTypeName', Value);
end;

procedure TFixedAssetType.SetDepreciationOption(const Value: integer);
begin
  SetIntegerField('DepreciationOption', Value);
end;

procedure TFixedAssetType.SetLife(const Value: double);
begin
  SetFloatField('Life', Value);
end;

procedure TFixedAssetType.SetNotes(const Value: string);
begin
  SetStringField('Notes', Value);
end;

procedure TFixedAssetType.SetSalvage(const Value: double);
begin
  SetFloatField('Salve', Value);
end;

procedure TFixedAssetType.SetSalvageFactor(const Value: double);
begin
  SetFloatField('SalveFactor', Value);
end;

procedure TFixedAssetType.SetSalvageType(const Value: integer);
begin
  SetIntegerField('SalvageType', Value);
end;

function TFixedAssetType.ValidateData: Boolean;
begin
  result := false;
  if self.AssetTypeCode = '' then begin
    AddResult(false,rssWarning,0,'Asset Type Code can ot be blank.');
    exit;
  end;
  result := true;
end;

initialization

RegisterClass(TFixedAssetPercentages);
RegisterClass(Tfixedassetsdepreciationdetails2);
RegisterClass(TAssetPicture);
RegisterClass(TFixedAssets);
RegisterClass(TRepairAssetXRef);
BusObjectListObj.TBusObjInfoList.Inst.Add('Fixed Asset', 'TFixedAssets', 'TFixedAssetsListGUI');
RegisterClass(TFixedAssetType);

end.
