unit tcDataUtils;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/09/05  1.00.01 IJB  Added functions GetSaleIDForGlobalRef, GetSaleGlobalRef.
                        GetPurchaseOrderIDForGlobalRef
 11/10/05  1.00.02 DSP  Added function GetPurchaseCustomFieldsInUse and modified
                        GetSaleCustomFieldsInUse to use tblpreferences in place
                        of tblcustomfieldssales. Changed
                        GetPurchaseCustomFieldsInUse to GetCustomFieldsInUse
                        and added a BaseType parameter to make it general
                        purpose.
 18/10/05  1.00.03 IJB  Added function GetTaxRateForCode.
 21/10/05  1.00.04 DSP  Added procedure AdjustCustomFields.
 24/10/05  1.00.05 BJ   Moved the common functions from frmParts -
                        GetAutoBarcode,GetAccountName,GetAutoProdCode
 24/10/05  1.00.06 IJB  Added function GetNextClientInvoiceBaseNo
 25/10/05  1.00.07 BJ   Added Overloaded function searchproduct to either
                        search on the productID and return the productname or
                        search on ProducName and  return the productId.
 26/10/05  1.00.08 IJB  Added IsCustomerTermsOK (copied code from DnMLib).
 26/10/05  1.00.09 BJ   Added  getUnitMultiplier to search for unitname and return multiplier
 27/10/05  1.00.10 BJ   ReadSegregateProductSpec : reads the product spec for the
                        Segregate product to know the total qty.
 31/10/05  1.00.11 BJ   new function : getSerialnumber
 01/11/05  1.00.12 BJ   New function : getLinkAppointId
 09/11/05  1.00.13 MV   New function : SearchForCustomerPONumberReUse
 16/11/05  1.00.14 BJ   New function : getclassname - returns the name of teh class(department name)
                                       BatchForPartandClass , BinForPartandClass
                                       ProductReservedQty : gets the Product's reserved qty in the
                                                            Class, batch , bin
 22/11/05  1.00.15 IJB  Added function tcDataUtils.getAccountID.
 28/11/05  1.00.16 IJB  Added fiunction SalesBackOrderIsInvoiced.
 02/12/05  1.00.17 BJ   Added function DeleteResrvedQty.
                        Added Function getUserName
 15/12/05  1.00.18 IJB  Modified GetNextClientInvoiceBaseNo to pass connection.
 06/01/06  1.00.19 DSP  Changed AdjustCustomFields parameter from a Grid to a
                        DataSet.
 27/01/06  1.00.20 IJB  Added function GetClientsDefaultDeliveryReport,
                        GetTemplateNameForID.
 01/02/06  1.00.21 IJB  Added procedure InsertSimpleTypeRecord;
 13/03/06  1.00.22 BJ   added function GetProductID .
 14/03/06  1.00.23 BJ   changed the name of 'searchProduct' function to 'GetProduct' as it returns the productId
 21/04/06  1.00.24 BJ   Added functions for Supplier name and supplierID
 26/04/06  1.00.25 BJ   GetProductUoM function changed to get the default UOM as the saleUOM and purchaseUOM for any product
 23/05/06  1.00.26 BJ   Added function POBackOrderIsInvoiced.
                        Added function to read the company address.
 23/07/06  1.00.27 BJ   Added generic function FieldBynameValue which can be called with the SQL
                        resultfieldname and the result type. the function runs the SQL on MYQuery
                        with the shared connection and returns the result as variant.
                        Added function getProductIDForBarcode - searches for the barcode and returns the partsid
 14/08/06 1.00.28 BJ    GetNextClientInvoiceBaseNo : the function is called from the invoice when
                        it selects the customer and locks the client till the invoice is not saved.
                        BusobjSale is does this updation outside transaction

}

interface

uses
  SysUtils, MyAccess, ERPdbComponents, tcTypes,
  Wwdbgrid, Classes, dB;

type
  TResultType = (AsString = 1, asInteger = 2, asDateTime = 3, asFloat = 4,    asBoolean = 5, asGroupconcat = 6);
  TtClienttype = (ttnone = 0, ttcustomer = 1, ttJob = 2, ttSupplier = 3,     ttOthercontact = 4);
  tClientcontacttype = (ctNone =0,
                  ctMainContactforCashSale    = 1,
                  ctMainContactforVoucher     = 2,
                  ctMainContactforPOS         = 3,
                  ctMainContactforRefund      = 4,
                  ctMainContactforInvoice     = 5,
                  ctMainContactforSalesOrder  = 6,
                  ctMainContactforStatements  = 7,
                  ctMainContactforQuote       = 8,
                  ctMainContactforCheque      = 9,
                  ctMainContactforCredit      = 10,
                  ctMainContactforBill        = 11,
                  ctMainContactforPO          = 12,
                  ctMainContactforRA          = 13,
                  ctMainContactforRepair      = 14,
                  ctMainContactforSupplierPayment = 15);


Function FieldBynameValue(Const fSQL, fReturnfield: String;Const ResultType: TResultType = AsString;CloseDS:Boolean =False; fConnection : TCustomMyconnection = nil): Variant;
//function Datautilsdataset(const fSQL: String): TERPQuery;
Function getGlobalref(const Tablename, IDFieldName: String; const ID: Integer;
  const GlobalrefFieldName: String = 'Globalref'): String;
Function GetClientID(const ClientName: String; ActiveOnly: boolean = false; fConnection : TCustomMyconnection = nil): Integer;
Function GetClientCode(const ClientName: String): String;

function ClientIsActive(const ClientID: integer): boolean;
function clientDefaultDeliveryTemplateID(const clientID: Integer): Integer;
function CustomerDefaultClassID(const clientID: Integer): Integer;
function IsSaleOnHold(const saleID: Integer): Boolean;
function IsSaleinvoice(const saleID: Integer): Boolean;
function SaleclassId(const saleID: Integer): Integer;
function SaleclassNAme(const saleID: Integer): String;
Function SalesSaleDatetime(const saleID: Integer): TDateTime;
function IsSaleSO(const saleID: Integer): Boolean;Overload;
function IsSaleSO(const salesref: String): Boolean;Overload;
function IsSalelineSO(const SaleLineID: Integer): Boolean;
function SaleID(const SaleLineID: Integer): Integer;

function GetCashCustID: Integer;
Function getClientName(const clientID: Integer): String;
function GetClientFaxNumber(const clientID: Integer): String;

// othercontacts
function GetExportDataRec(const Tablename: String): TExportRec;
function GetProductDescription(const ProductID: TProductID): String;
function GetProductTaxCode(const ProductID: TProductID;
  const TaxCode: TTaxOnType = tcOnSale): String;
function GetProductUoMID(const ProductID: TProductID;
  const UoMType: TUoMType = uomOnSale): Integer;
Function getSupplierName(const SupplierID: Integer): String;
Function getSupplierID(const SupplierName: String): Integer;
function GetCompanyAddress: String;
function GetCompanyname(fconnection: TCustomMyconnection = nil): String;
Function getCurrencyName(const CurrencyId: Integer): String;
Function getCurrencyID(const CurrencyName: String): Integer;
function GetALLRelatedClientIDs(const ParentClientID: Integer): string;
Function IsclientRelated(Const clientID: Integer): Boolean;
Function IsclientRelatedParent(Const clientID: Integer): Boolean;
Function ClientParentID(Const clientID: Integer): Integer;
Function getPickingPriority(const Priority: String): Integer;
function ProductColsExists(const ColValue: STring;
  const colNo: Integer): Boolean;
function GetCustomFieldsInUse(const BaseType: String; const FormType: String;
  const AFieldList: TStrings): Integer;
function GetUnitOfMeasureID(const xUnitName: String; ProductID: Integer = 0)  : Integer; overload;
function getUOMID(const xUnitName: String; ProductID: Integer)  : Integer; overload;
function GetUnitOfMeasureID(const PartsId: Integer; UOM: String;
  const UOMMult: Double): Integer; overload;
Function getUnitProductName(const UOMID: Integer): String;
Function GetUOMName(const UOMID: Integer;fconnection: TCustomMyconnection = nil): String;
function GetTerms(const TermsName: String): Integer; Overload;
function GetTerms(const TermsID: Integer): String; Overload;
procedure GetClientTerms(const iClientID: Integer; var iTermsID: Integer;
  var sTerms: string; var dtDateDue: TDateTime;
  const DefaultTerm: String = ''); Overload;
function GetClientTerms(const iClientID: Integer): String; overload;
function GetSaleIDForGlobalRef(const GlobalRef: String): Integer;
function GetSaleIdForSaleLineId(const aSaleLineId: Integer): Integer;
function GetClientIDforSale(const saleID: Integer): Integer;
function GetClassIDforSale(const saleID: Integer): Integer;
function GetSaleGlobalRef(const ID: Integer): String;
function GetTaxRateForCode(const aTaxCode: String): Double;
function GetUnitOfTimeName(const UOTID: Integer): String;

function getClientTypeName(const CTID: Integer): String;
function getClientTypeID(const CTName: String): Integer;
function DefaultclientTypeId: Integer;
Function getProcessStep(const ProcessStepID: Integer): String; overload;
Function getProcessStep(const ProcessStepdesc: String): Integer; Overload;
Function GetTreeRootID(const ProductID: Integer): Integer;
Function BOMTreeLevels: Integer;
Function BOMPRocessSteps: Integer;
function getUserVersion: String;
function BOMProcesses:Integer;

// TaxCode
Function getTaxcodeID(const TaxCode: String): Integer;
Function getTaxcode(const TaxCodeID: Integer): String;
// bank codes
Function getBankCodeID(const BankCode: String; RegionID: integer): Integer;
Function GetClientBankCode(const clientID: Integer): String;

// Employee
function getemployeeID(const EmployeeName: String): Integer;
function getemployeeName(const EmployeeID: Integer): String;
function getemployeeFirstName(const EmployeeID: Integer): String;
function getemployeeQuota(const EmployeeID: Integer): Double;
function GetEmployeeApprovalValueH(const EmployeeID: Integer;
  AType: String): Double;
function GetEmployeeApprovalValueL(const EmployeeID: Integer;
  AType: String): Double;
// Cost Centre related
function getCostCentreID(const costCentreName: String): Integer;
function getCostCentrename(const costCentreID: Integer): String;
// accounts related
Function GetAccountReceivableID: Integer;
Function GetAccountPayableID: Integer;
function GetAccountNumber(const iAccountID: Integer): String;
function AccountIDForNumber(const Accountnumber: String): integer;
function AccountIDForName(const AccountName: String): integer;
function GetAccountName(const iAccountID: Integer): String; overload;
function GetAccountName(const Accountnumber: String): String; Overload;
Function GetAccountID(const AccountName: String): Integer;
Function GetAccountTypeID(const iAccountTypeName: String): Integer;
Function getDeductionAccountID(const iDeductionID: Integer): Integer;
Function getAllowanceAccountID(const iAllowanceID: Integer): Integer;
Function GetAccountHeaderID(const HeaderType, HeaderName: String): Integer;
function getTypeofAccount(fiAccountID: Integer): String;
//function getLastSuppPayChequeno(const AccountID: Integer): Integer;
//function getLastChequeno(const AccountID: Integer): Integer;
function GetPaymentMethod(const PaymentMethod: String): Integer; Overload;
function GetPaymentMethod(const PaymentMethodID: Integer): String; Overload;
{ Product related }
function GetProduct(const ProductName: String; fconnection: TCustomMyconnection ): Integer; overload;
function GetProduct(const ProductName: String): Integer; overload;
function GetProduct(const ProductID: Integer): String; overload;
function GetProductFormula(const ProductID: Integer): String;
function GetProductFormulaName(const ProductID: Integer): String;
function GetProductFormulaID(const ProductID: Integer): Integer;
function IsBAtchProduct(const ProductID: Integer): Boolean;
function GetProducttype(const ProductID: Integer): String;
function GetProductForbarCode(const Barcode: String): String;
function GetProductForbarCodeEx(const Barcode: String): String;
function GetProductIDForbarCode(const Barcode: String): Integer;
function GetPartSpecID(const ProductID: Integer;
  const SpecDescription: String): Integer;
function GetProductAttribGroupID(const GroupName: String): Integer;

Function getPurchaseOrderID(const PurchaseLineID: Integer): Integer;
Function getShipContainerID(const ShipContainerName: String): Integer;
Function GetSaleIDLinkedToPurchase(const PurchaseLineID: Integer): Integer;
Function GetSaleLineIDLinkedToPurchase(const PurchaseLineID: Integer): Integer;
Function GetPurchaseLineIDLinkedToSale(const SaleLineID: Integer): Integer;

{ Client related functions }
function IsCustomerTermsOK(const iClientID: Integer; var Msg: String): Boolean;
function ClientAppointmentCount(const clientID: Integer;
  Const AtDateTime: TDateTime): Integer;
function getUnitMultiplier(const UnitID: Integer): Double; overload;
function GetClassName(const iClassID: Integer): String;overload;
function GetClassName(const sClassID: String): String;overload;
function GetDeptID(const iClassName: String): Integer;

function GetBinID(Const binLocation, binnumber: String;  const classid: Integer): Integer;
function GetBinLocation(const BinID:Integer): String;
function GetBinnumber(const BinID:Integer): String;
function GetBinLocationnnumber(const BinID:Integer): String;
Function DefaultBinId(Const classid, ProductID: Integer): Integer;
Function DefaultStsClassBinId(Const classid: Integer): Integer;
Function DefaultstockClassId(Const ProductID: Integer): Integer;
Function getLeadID(Contacttype: String; contactID: Integer): Integer;
Function ClientIDofJob(Const clientID: Integer): Integer;
Function ClientFundingbody(Const clientID: Integer): String;
Function ContactClientID(const ContactID:Integer):Integer;
function ClientXMLEmail(const ThisClientID: integer): string;
function ClientPOXMLEmail(const ThisClientID: integer): string;
//function GetContactEmailsList(const AClientId : integer; const aFieldName : string) : TStringList;
function GetContactEmails(const AClientId : integer; const aFieldName : string): string;
function AddEmailToList(aEmail: string; aList: string): string;

{ Country }
function IsEUCountry(const sCountry: String): Boolean;
function IsInternational(const sCountry: String): Boolean;

{ Other types }
Function getOtherType(const typeID: Integer): String; Overload;
Function getOtherType(const typeName: String): Integer; Overload;

{ TaxCode related }
function GetGLTaxCodeIDForName(const TaxCodeName: String): Integer;

{ Media type / source related }
Function getMediatype(const typeName: String): Integer; overload;
Function getMediatype(const typeID: Integer): String; overload;
{ shiping method related }
function getshippingMethod(const ShippingMethodName: String): Integer;
{ Region related }
Function GetRegion(const RegionName: String): Integer; overload;
Function GetRegion(const RegionID: Integer): String; overload;
Function GetRegionIDForCountry(const aCountry:String): Integer;

{ Back Order Related }
function POBackOrderIsInvoiced(const BackOrderGlobalRef: String): Boolean;
function getUserName(const UserId: Integer): String;
function ReminderHideDays(const EmployeeID:Integer):Integer;

{ Report/Template related }
function GetTemplate(const TemplateID: Integer): String; overload;
function GetTemplate(const TemplateName: String): Integer; overload;
Function GetDefaultTemplate(TemplTypeID: Integer): String;overload;
Function GetDefaultTemplate(TemplType: String): String;overload;
function GetTemplateTypeId(const TemplID: Integer): Integer;overload;
function GetTemplateTypeId(const Templname: String): Integer;overload;
function GetTypeNameoftemplate(const Templname: String): String;

{ Simple Types }
{ TODO : bet rid of these and use TSimpleType decendant business object class functions }
procedure InsertSimpleTypeRecord(const AType, aName, aDescription: String;
  const IsDefault, Active: Boolean);
function GetSimpleType(const typeID: Integer): String; overload;
function GetSimpleType(const typeName: String; const TypeCode: String; CreateifnotExists :Boolean = False)  : Integer; overload;
function GetSimpleTypeDefaultStr(const TypeCode: string): string;
Function RepairNotes(RepairID: Integer): String;
Function Repairmanufacure(const RepairNo: Integer): Integer;
{ Lead }
function LeadActionFollowup: Integer;
function LeadActionEmail: Integer;
function LeadActionAppointment: Integer;
function LeadActionInvoice: Integer;
function LeadActionSalesOrder: Integer;
function LeadActionQuote: Integer;
function LeadActionToDo: Integer;
function LeadActionLead: Integer;
function FollowUpResultAppointment: Integer;
{ Product formula }
Function getFormulaId(const formulaName: String): Integer;
Function getFormula(const FormulaID: Integer): String;
Function getDescribeFormula(const FormulaID: Integer): String;
Function getFormulaName(const FormulaID: Integer): String;
{ Equipment }

Function getEquipmentIdforProduct(const ProductID: Integer; Serialnumber :String): Integer;
Function getEquipmentId(const EquipmentName: STring): Integer;
Function getEquipmentName(const EquipmentID: Integer): String;
Function getEquipmentSerialnumber(const EquipmentID: Integer): String;
Function getManufactureId(const ManufactureName: STring): Integer;
Function ManufacturedateFormat(Const RepairNo: Integer): String;
Function getManufactureName(const ManufactureID: Integer): String;
function getServiceID(Const ServiceName: String): Integer;
function getpayrateID(Const payratetypeName: String): Integer;
Function GetId(const GlobalRef: String; const IDFieldName: String;
  const Tablename: STring): Integer;

{ Assessment }
Function getAssessmentLabelId(Const labels: String): Integer;
Function getAssessmentDriverid(Const Driver: String;
  Const clientID: Integer): Integer;
Function getAssessmentDriver(Const DriverId, clientID: Integer): String;
Function getAssessmentAssessorid(Const Assessor: String): Integer;
Function getAssessmentTypeid(Const AssessmentType: String): Integer;

{ POS related }
function getPOSFunctionID(Const POSFunctionName: String): Integer;
function getPOSKeyPadID(Const POSKeyPadName: String): Integer;
function getFuncRoomName(Const FuncRoomID: Integer): String;
function getFuncRoomID(Const FuncRoomName: String): Integer;

{ POS orders }
function getCurrentProcStep(const OrderLineID: Integer): Integer;
function GetTillClassID(const iTillID: Integer): Integer;
function GetTillClassName(const iTillID: Integer): string;
function GetPrimaryPad(const iTillID: Integer): Integer;
{ forms related }
function getformID(Const fFormName: String): Integer;
function getformName(Const fFormID:Integer): String;
function GetAccessLevelsFormID(const FormName: string): Integer;

{ telemarketing related }
function GetRangeSelectionID(const sRangeDescription: string): Integer;
function GetPayRateTypeID(const sRateType: string): Integer;
Function GetMarketingcontactIdforclient(const clientID: Integer): Integer;
Function getMarketingcontactName(const MCID: Integer): String;
Procedure MarketingContactDetails(const clientID: Integer; var MCID: Integer;  var IsLead: Boolean; var LeadID: Integer);
Function MarketingContactID(const MarketingContactName :String):Integer;

{ MailMerge related }
function HasMailMergeHostDetails: Boolean;
function GetRecipientName(MailMergeGroup: string; RecipientID: Integer): String;
function DashBoardPreference: String;
Function getSalesOriginalno(Const saleID: Integer): String;
Function getSalesIDsofgroup(Const saleID: Integer; excludethissale:Boolean =False): String;
function getSalesOriginalnoForRef(Const globalref:String):String;
Function getPOOriginalno(Const PurchaseOrderID: Integer): String;
function SalesCommissionbatchUpdateDetails: String;
function SalesCommissionbatchUpdateBy: String;
Function SalesCommenabled: Boolean;
Function Clienttype(const clientID: Integer): TtClienttype;
Function ClienttypeName(const clientID: Integer): String;

function AvailableRewardPoints(Const CustomerID: Integer;
  const SaleDate: TDateTime; fconnection: TCustomMyconnection = nil): Double;
function clientemail(Const clientID: Integer): String;    overload;
function ReadFieldbynameFromGrid(const Grid: twwDBGrid; fieldname: String;
  Const ResultType: TResultType = AsString): Variant;
function PO_Type(POID: Integer): String;
function SaleType(saleID: Integer): String;  Overload;
function SaleType(Globalref :String): String;Overload;
function SalesGlobalref(saleID: Integer): String;
function SaleIDFromTrans(Const TransId: Integer): Integer;
function TimesheetEntryID(const SaleLineID: Integer): Integer;
Function GetTrainingModuleID(Modulename: String): Integer;
Function getPassword(Const User: string): String;
//function FristTransDate: TDateTime;
function Clientcontactcount(Const ClietnID: Integer): Integer;
function ClientPhoneSupport(const ClietnID: Integer): TDateTime;
function ClientdefaultContactMethod(const ClietnID: Integer): String;
function CheckTemplateExists(const ReportName: string): Boolean;
function FieldExists(Tablename, fieldname: String): Boolean;
Function ActiveTables: String;
Function Activeforms: String;
function GetEmployeeAccessLevel(const FormName: string; const UserName:String): integer;
function GetClientEmail(const ThisClientID: integer; OnlyIfPreferedMethod: boolean = false): string;
function Producttypename(Const typecode:String):String;
function Producthasformula(Const ProductID:Integer):Boolean;
function IshireProduct(Const ProductID:Integer):Boolean;
function HireProductPartID:Integer;
Function ProductHasAllocation(const ProductId :Integer; fconnection: TCustomMyconnection = nil):Boolean;
function LastReturnSummariseDate(tablename:String):TDateTime;
function LastReturnID(tablename:String):Integer;
function TemplateTypeID(Const TemplTypename:String): integer;
function TemplateTypeName(Const TypeID:Integer): String;
function Defaultchart(const Listclass:String):string;
function ProfitnLossDefaultchart:string;
function Formhascomments(aFormID:Integer):Boolean;
function ServiceStandardRate(const ServiceName:String):Double;
function AppointmentclientId(const apptID:Integer):Integer;
function AppointmentDate(const apptID:Integer):TdateTime;
function ClientEmail(ClientID, contactID:Integer):String;overload;
Function ClientcontactEmailID(Const ClientID :Integer; Contacttype : tClientcontacttype; UsePrimarywhenBlank:Boolean = true; USeclientswhenBlank :Boolean = True):String;
function ClientName(ClientID, contactID:Integer):String;
function ClientFax(ClientID, contactID:Integer):String;
function ClientAddress(ClientID, contactID:Integer; Resulttype:Integer):String;
procedure IterateselectedRecords(grd:TWWDBGrid; DoProc:TNotifyEvent);
Function HasObjectProperties(ObjClassname:String):boolean;
function GetLastSequenceNumber(const SeqName: string): string;
function GetNextSequenceNumber(const SeqName: string): string;
function AdjustType(const AdjusmentID: Integer): string;
function TransferType(const AdjusmentID: Integer): string;
function LeadID(const Companyname:String): Integer;
function getEmployeeEmail(const EmployeeID:Integer):String;Overload;
function getEmployeeEmail(const EmployeeName:String):String;Overload;
Function getContactID(const contactName:String): Integer;
Function getContactName(const contactID:Integer): String;
Function getaxScaleID(const ScaleName:String): Integer;
Function getEmpServiceID(const ServiceName:String;employeeID:Integer): Integer;
Function getEmpServicename(const EmpServiceID :Integer): String;
function GetVehicleID(const VehicleName: string): integer;
function CountryISDCode(const Countryname: string): String;
Function SalesProductPartiallyShipped(Const SalesLineID:Integer):Boolean;
Function uomweight(const uomid:Integer):double;
Function StockAdjustImportDataMapID:Integer;
Function ImportDataMapIDFortype(const aTypeName:String):Integer;
Function BOMListImportDataMapID:Integer;
Function ERPVideoImportDataMapID:Integer;

Function LanguageName(Const LanguageID:Integer):String;
//Function Clienttype(const clientID:Integer):String;
Function CurrencyDecimalPlaces(Const Curcode:String):Integer;
function GetDefaultReport(const TemplateTypeID: integer): string;overload;
function GetDefaultReport(const TemplateTypeName: String): string;overload;
Function InhouseClientID:Integer;
Function InhouseClientName:STring;
function IsHoliday(const dt: TDateTime): Boolean;
function ImageSchemeLargeIconsDLLName: String;
function ImageSchemeSmallIconsDLLName: String;
function ImageSchemeNames : TStringList;
Function EmployeeIdforPassWord(Password:String; PasswordEncrypted:Boolean):Integer;
Function EmployeeIdforUserName(UserName:String):Integer;
function TillA4templateID(const fiTillID: Integer): String;
function Durationdesc(const Durationtype:String):String;
Function HireDurationWorkflowID:Integer;
Function HireMakeProductWorkflowID:Integer;
Function HireConvertProductToHireWorkflowID:Integer;
Function HireMakeHireWorkflowID:Integer;
Function WorkflowID(const WorkflowDescription:String):Integer;

function NextUniqueValue(data: String;Tablename:String; fieldname:String; Subchar:String=''):String;
function Resourcerostered(const ResourceID:Integer):Boolean;
Function ProcResourceDetailsUsed(ProcResourceDetailID:Integer):Boolean;
Function ProcesstepResourceID(Const ProcessStepID:Integer):Integer;
Function Processtep(Const ProcessStepID:Integer):String;
Function SaleDetails(const SaleIDs:String):String;
Function FormatSeconds(const Seconds:Integer):String;
function ProcResName(const ProcResID:Integer):String;
function ProcResID(const aProcResname:string):Integer;
function ProcResDetName(const ProcResDetID:Integer):String;
function SalesLineRootNodeId(const SalesLineId:Integer):Integer;
function IsSalesLineScheduled(const SalesLineId:Integer):Boolean;
function ISINTernalOrder(const SaleID :Integer):Boolean;
function SaleIdForLine(const SaleLineID :Integer):Integer;
function TreeRootIDofPP( PPID:Integer):Integer;
function SaleLineIDofTree( PTPID:Integer):Integer;
function SaleIDofTree( PTPID:Integer):Integer;
function AnyProcessScheduled(SalesID:Integer): Boolean;
function SaleslineScheduled(SaleslineID:Integer): Boolean;
function AutoRoundRelatedQty(const Qty:double; ParentProductId, ProductID:Integer):Double;
Function RefundChequeID (Const RefundGlobalref:String):Integer;
Function NextNum( const Tablename :String; Const fieldname :String):Integer;
function CsahCustomerMedtypeId :Integer;
Function SaleIDofLine(const SaleLineID:Integer):Integer;
Function ProcessStepID( ProcessStep:STring):Integer;
function jobIds(const ClientID:Integer):String;
function AllIds(const fsql:String; fieldname:String; fConnection: TCustomMyconnection = nil):String;
function VideoID(PageCaption , videotype:String):Integer;
function VideoFilename(PageCaption , videotype:String):String;Overload;
function hasCashDropsforPeriod(iPeriodID:Integer):Boolean;
function EmployeeIdforLogonName(logonname:String):Integer;
function SalesSmartOrderID(const SalesAutoSmartOrderRef:String):Integer;
function SaleIdForSmartOrder(const SmartorDerREf:String):Integer;Overload;
function SaleIdForSmartOrder(const SmartOderID:Integer ):Integer;Overload;
function GetProductprintname(const ProductID: Integer): String;
function clientPrintName(Company:String):String;
(*function clientNameForPrintname(Printname:String):String;*)
function clientIDForPrintname(Printname:String):Integer;
(*function ProductNameForPrintname(Printname:String):String;*)
function ProductPrintName(Partname:String):String;
function ProductIDForPrintname(Printname:String):Integer;
function OriginalSalesDocNumber(const SaleId:Integer):String;
function OriginalPODocNumber(const POID:Integer):String;
Function IsOtfProduct(Const PartsID:Integer):Boolean;
Function SalesOrderEmployeeEmail(const SaleId :Integer):String;
function ProductDefaultLineNo(Const PartsID:Integer):Integer;
function LastEmployeeNo:Integer;
function EmployeeIDForNo(Const EmpNo:Integer):Integer;
function ProductPrice1(Const PartsID:Integer):Double;
function ProductPrice1inc(Const PartsID:Integer):Double;
Function Is_Inv_Product(Const PartsID:Integer):Boolean;Overload;
Function Is_Inv_Product(Const Partname:String):Boolean;Overload;
Function IsSaleConverted(Const SaleId:Integer):Boolean;
function hasSerialNoTabletAllocationIssue:boolean;
Function IscontainerRelatedProduct(const ProductId , parentProductID:Integer):Boolean;
Function CustomerBOCount(const customerID:Integer; saleType:String):Integer;
Function Recordcount(const tablename :String):Integer;
Function isQLDRegisteredVehicle(const EquipId:Integer):Boolean;
Function EquipIdForCustomerEquipmentId(const CustomerEquipmentId:Integer):Integer;
Procedure ToDoLinktypenID(const ToDOID:Integer; var Linktype:String; var LinkID:Integer);
(*function InvoiceReportName(Const SaleID:Integer): String;*)
function CustomerInvoiceReportName(Const clientID:Integer): String;
function PrefNameToDesc(const aPreftype, aPrefname:String):String;
function POSupplierName(const aPORef:String):String;
function POLProductName(const aPOLineRef:String):String;Overload;
function POLProductName(const aLineID:Integer):String;Overload;
function LinkedPOID(const aPOID:Integer):Integer;
Function TransRecCount(DateFrom, DAteTo:TDateTime):Integer;
Function SalesLineWOLineID(ERPBaseLineno:Integer):Integer;
Function WOIdtoSaleID(WOID:Integer):Integer;
Function WalmartOrderLinecount(WOID:Integer):Integer;
Function Videofilename(TrainingvidoeID:Integer):String;Overload;
Function HasLocalDoc(HelpID:Integer):Boolean;
Function HasExcelPriceforProduct(const aProductId:Integer; var errmsg:String):Boolean; overload;
Function HasExcelPriceforProduct(const aProductId:Integer; showMsgifExcelMissing:Boolean):Boolean;overload;
Function TransSeqno(aProctreeId:Integer ; fConnection: TCustomMyconnection = nil):integer;
Function PPGExists(const PPGRef:String):Boolean;
Function SOInvoiceLineExists(const SOInvoiceLineRef:String):Boolean;
Function SalelineSeqno(aSaleLineID:Integer ; fConnection: TCustomMyconnection = nil):integer;
Function HelpdocID(HelpdDescription:String):Integer;
Function GOLiveAddition(aID:Integer;fconnection: TCustomMyconnection = nil):String;
Function GOLiveCategoryno(aID:Integer;fconnection: TCustomMyconnection = nil):Integer;
Function ProductinstockQty(aPartsID:Integer;
                           fconnection: TCustomMyconnection = nil;
                           Const asOndate: TDatetime = 0;
                           Const fUOM: String = '';
                           Const ficlassid: Integer = 0):Double;
Function ProductAvailableQty(Const aProductID:Integer; aUOM:String; aClassID:Integer=0):Double;Overload;
Function ProductAvailableQty(aPartsID:Integer;
                           fconnection: TCustomMyconnection = nil;
                           Const asOndate: TDatetime = 0;
                           Const fUOM: String = '';
                           Const ficlassid: Integer = 0):Double; Overload;
Function SaleIDForCoucher(Const Voucherno :STring;fconnection: TCustomMyconnection = nil):Integer;
function GetAutoBarcode(fconnection: TCustomMyconnection = nil): string;
function ClientTemplateSQL(templatetype:String):String;
function ClientDefaultTemplate(AOwnerformName :String; Const aSaleID:Integer):String;
function DeliverydocketTemplateForSale(Const aSaleID:Integer):String;
Function ValidCustomerforDB(AOwner:Tcomponent; dbname, customername:String):Boolean;
Function SeedToSaleStarted :Boolean;
Function StsPhaseCodeTodesc(ACode:String):String;
function TotNoOfResourcesinProduct(Const ResDetailID:Integer; fconnection: TCustomMyconnection= nil; ExID:Integer=0):Integer;
Function SOQuteGlobalref(const aSalesOrderGlobalref:STring):String;

function VS1_ModuleID(const aModulename:String):Integer;
Function VS1_Module_Accounts_Payable_Reports_ID   : Integer;
Function VS1_Module_Accounts_Receivable_Report_ID : Integer;
Function VS1_Module_Add_Extra_User_ID             : Integer;
Function VS1_Module_Appointment_Scheduling_ID     : Integer;
Function VS1_Module_Back_Ordering_ID              : Integer;
Function VS1_Module_Balance_Sheets_ID             : Integer;
Function VS1_Module_Batch_Serial_No_Tracking_ID   : Integer;
Function VS1_Module_Bills_ID                      : Integer;
Function VS1_Module_Bin_Tracking_ID               : Integer;
Function VS1_Module_Departments_ID                : Integer;
Function VS1_Module_Expense_Claims_ID             : Integer;
Function VS1_Module_FX_Currency_ID                : Integer;
Function VS1_Module_Inventory_Tracking_ID         : Integer;
Function VS1_Module_Invoices_ID                   : Integer;
Function VS1_Module_Jobs_construction_ID          : Integer;
Function VS1_Module_Journals_ID                   : Integer;
Function VS1_Module_Link_To_TrueERP_ID            : Integer;
Function VS1_Module_Manufacturing_ID              : Integer;
Function VS1_Module_Matrix_ID                     : Integer;
Function VS1_Module_Payemnts_ID                   : Integer;
Function VS1_Module_Payroll_Integration_ID        : Integer;
Function VS1_Module_Payroll_Unlimited_Employees_ID: Integer;
Function VS1_Module_PO_Non_Inventory_ID           : Integer;
Function VS1_Module_POS_ID                        : Integer;
Function VS1_Module_Profit_Loss_Reports_ID        : Integer;
Function VS1_Module_Quotes_ID                     : Integer;
Function VS1_Module_Reports_Dashboard_ID          : Integer;
Function VS1_Module_Seed_To_Sale_ID               : Integer;
Function VS1_Module_Shipping_ID                   : Integer;
Function VS1_Module_Statements_ID                 : Integer;
Function VS1_Module_Stock_Adjustments_ID          : Integer;
Function VS1_Module_Time_Sheets_ID                : Integer;
Function VS1_Module_Use_Foreign_Currency_ID       : Integer;
Function VS1_Module_Website_Integration_ID        : Integer;
Function VS1_Module_WMS_ID                        : Integer;
Function VS1_Module_Paychex_Payroll_ID            : Integer;
Function VS1_Module_ADP_Payroll_ID                : Integer;
Function VS1_Module_Fixed_Assets_ID               : Integer;

implementation

uses
  CommonDBLib, MySQLConst, Math, Types, tcConst,
  DNMLib, // NOTE: this should not be here! Please don't use DNMLib funtions in this unit.
  DBAccess, DataTreeObj, BusObjStock,
  Dialogs, AppEnvironment, Dateutils,
  ProductQtyLib, DefaultClassObj, CommonLib, Controls,
  SyncReportTableObj, SimpleEncrypt,ReportSQLBase,
  DbSharedObjectsObj, ERPSets, RegEdit, TemplateReportsTypeLib, PQALib,
   utVS1Const;

var
  strSQL: String;

{function Datautilsdataset(const fSQL: String): TERPQuery;
begin
  (*Result := TERPQuery.Create(nil);
  Result.Options.FlatBuffers := True;
  Result.Connection := CommonDBLib.GetSharedMyDacConnection;
  Result.SQL.add(fSQL);
  Result.Open;*)
  REsult := SharedQryobj(fSQL);
end;}

function ReadFieldbynameFromGrid(const Grid: twwDBGrid; fieldname: String;
  Const ResultType: TResultType = AsString): Variant;
begin
  try
    if ResultType = AsString then
      Result := Grid.Datasource.Dataset.fieldByname(fieldname).AsString;
    if ResultType = asInteger then
      Result := Grid.Datasource.Dataset.fieldByname(fieldname).asInteger;
    if ResultType = asDateTime then
      Result := Grid.Datasource.Dataset.fieldByname(fieldname).asDateTime;
    if ResultType = asFloat then
      Result := Grid.Datasource.Dataset.fieldByname(fieldname).asFloat;
  Except
    Result := '';
  end;
end;

Function FieldBynameValue(Const fSQL, fReturnfield: String;Const ResultType: TResultType = AsString;CloseDS:Boolean =False; fConnection : TCustomMyconnection = nil): Variant;
var
  QRy:TERPQuery;
begin
  if fconnection = nil then fConnection := CommonDBLib.GetSharedMyDacConnection;

  Qry := DbSharedObj.GetQuery(fConnection);
  try
    if Qry.Active then Qry.Close;
    Qry.SQL.Text := fSQL;
    Qry.Open;
      if ResultType = AsString    then if Qry.IsEmpty then Result := ''     else Result := Qry.fieldByname(fReturnfield).AsString;
      if ResultType = asInteger   then if Qry.IsEmpty then Result := 0      else Result := Qry.fieldByname(fReturnfield).asInteger;
      if ResultType = asDateTime  then if Qry.IsEmpty then Result := 0      else Result := Qry.fieldByname(fReturnfield).asDateTime;
      if ResultType = asBoolean   then if Qry.IsEmpty then Result := False  else Result := Qry.fieldByname(fReturnfield).asBoolean;
      if ResultType = asFloat     then if Qry.IsEmpty then Result := 0      else Result := Qry.fieldByname(fReturnfield).asFloat;
      if ResultType = asGroupconcat then if Qry.IsEmpty then Result := ''   else Result := Qry.groupconcat(fReturnfield);
    finally
      //if CloseDS then if Active then close;
      DbSharedObj.ReleaseObj(Qry);
    end;
end;

function GetCustomFieldsInUse(const BaseType: String; const FormType: String;
  const AFieldList: TStrings): Integer;
var
  Pair: String;
  FieldIndex: Integer;
  CustomNode: TDataTreeNode;
begin
  Result := 0;
  CustomNode := TDataTreeNode.Create;

  try
    CustomNode.Storer.Load(0, 0, cPrefGroupCustomFields, BaseType,AppEnv.CompanyInfo.IndustryId);

    for FieldIndex := 1 to cCustomFieldsMax do
    begin
      if CustomNode['Usage.' + FormType + '.Field' + IntToStr(FieldIndex)
        ].Value = 'T' then
      begin
        Pair := 'CustomField' + IntToStr(FieldIndex) + '=' + CustomNode
          ['Defines.Field' + IntToStr(FieldIndex)].Value;
        AFieldList.add(Pair);
        Inc(Result);
      end;
    end;

  finally
    FreeAndNil(CustomNode);
  end;
end;
function SaleclassId(const saleID: Integer): Integer;
begin
  strSQL := 'select ClassID from tblSales where saleID  = ' +IntToStr(saleID);
  Result := FieldBynameValue(strSQL, 'ClassID', asInteger);
end;
function SaleclassNAme(const saleID: Integer): String;
begin
  strSQL := 'select Class from tblSales where saleID  = ' +IntToStr(saleID);
  Result := FieldBynameValue(strSQL, 'Class', asString);
end;
function IsSaleinvoice(const saleID: Integer): Boolean;
begin
  strSQL := 'select IsInvoice from tblSales where saleID  = ' +
    IntToStr(saleID);
  Result := FieldBynameValue(strSQL, 'IsInvoice', asBoolean);
end;
Function SalesSaleDatetime(const saleID: Integer): TDateTime;
begin
  strSQL := 'select SaleDatetime from tblSales where saleID  = ' +
    IntToStr(saleID);
  Result := FieldBynameValue(strSQL, 'SaleDatetime', AsDatetime);
end;
function IsSaleSO(const saleID: Integer): Boolean;
begin
  strSQL := 'select IsSalesOrder from tblSales where saleID  = ' +
    IntToStr(saleID);
  Result := FieldBynameValue(strSQL, 'IsSalesOrder', asBoolean);
end;
function IsSaleSO(const salesref: String): Boolean;
begin
  strSQL := 'select IsSalesOrder from tblSales where Globalref  = ' +
    Quotedstr(salesref);
  Result := FieldBynameValue(strSQL, 'IsSalesOrder', asBoolean);
end;
function IsSalelineSO(const SaleLineID: Integer): Boolean;
begin
  strSQL := 'select S.IsSalesOrder from tblSales S inner join tblsaleslines SL on S.SaleId = SL.saleId where Sl.saleLineId= ' +inttostr(SaleLineID);
  Result := FieldBynameValue(strSQL, 'IsSalesOrder', asBoolean);
end;
function SaleID(const SaleLineID: Integer): Integer;
begin
  strSQL := 'select SAleID from tblsaleslines where saleLineId= ' +inttostr(SaleLineID);
  Result := FieldBynameValue(strSQL, 'SAleID', asInteger);
end;

function IsSaleOnHold(const saleID: Integer): Boolean;
begin
  strSQL := 'select HoldSale from tblSales where saleID  = ' + IntToStr(saleID);
  Result := FieldBynameValue(strSQL, 'HoldSale', asBoolean);
end;

function CustomerDefaultClassID(const clientID: Integer): Integer;
begin
  strSQL := 'SELECT CL.ClassId FROM tblclients C inner join tblclass CL on CL.Classname = C.DefaultClass  WHERE ClientID  = '
    + IntToStr(clientID);
  Result := FieldBynameValue(strSQL, 'ClassId', asInteger);
  if Result = 0 then
    Result := AppEnv.DefaultClass.classid;
end;

function clientDefaultDeliveryTemplateID(const clientID: Integer): Integer;
begin
  strSQL := 'SELECT DefaultDeliveryTemplateID FROM tblclients WHERE ClientID  = '
    + IntToStr(clientID);
  Result := FieldBynameValue(strSQL, 'DefaultDeliveryTemplateID', asInteger);
end;
Function GetClientCode(const ClientName: String): String;
begin
  strSQL := 'SELECT ClientCode FROM tblclients WHERE Company = ' +
    QuotedStr(StringReplace(ClientName,'\','\\',[rfReplaceAll]));
  Result := FieldBynameValue(strSQL, 'ClientCode', asString);

end;
Function GetClientID(const ClientName: String; ActiveOnly: boolean= false;fConnection : TCustomMyconnection = nil): Integer;
begin
  strSQL := 'SELECT ClientID FROM tblclients WHERE Company = ' +
    QuotedStr(StringReplace(ClientName,'\','\\',[rfReplaceAll]));
  if ActiveOnly then
    strSQL := strSQL  + ' and Active = "T"';
  Result := FieldBynameValue(strSQL, 'ClientID', asInteger, False, fConnection );
End;

function ClientIsActive(const ClientID: integer): boolean;
begin
  strSQL := 'SELECT ClientID FROM tblclients WHERE ClientId = ' + IntToStr(ClientId) +
    ' and Active = "T"';
  Result := FieldBynameValue(strSQL, 'ClientID', asInteger) > 0;
end;

function GetExportDataRec(const Tablename: String): TExportRec;
begin
  Result.ExportID := 0;
  Result.Tablename := Tablename;
  Result.SQL := '';
  Result.TableDescription := '';
  Result.Success := False;
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('SELECT * FROM tblexporttables');
      SQL.add('WHERE TableName = :TableName');
      ParamByName('TableName').AsString := Tablename;
      Open;
      if not IsEmpty then
      begin
        Result.ExportID := fieldByname('ExportID').asInteger;
        Result.SQL := fieldByname('SQLStatement').AsString;
        Result.TableDescription := fieldByname('TableDescription').AsString;
        result.IndexDefs:= fieldByname('IndexDefs').AsString;
        Result.Success := True;
      end;
    finally
      Free;
    end;
end;

Function GetUOMName(const UOMID: Integer;fconnection: TCustomMyconnection = nil): String;
begin
  Result := '';
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      if fconnection <> nil then Connection := fconnection
      else Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('SELECT UnitName FROM tblunitsofmeasure WHERE UnitID = ' +
        IntToStr(UOMID));
      Open;
      if not IsEmpty then
        Result := fieldByname('UnitName').AsString;
    finally
      Free;
    end;
end;

function GetUnitOfMeasureID(const PartsId: Integer; UOM: String;
  const UOMMult: Double): Integer; overload;
begin
  strSQL := 'SELECT UnitID FROM tblunitsofmeasure ' + ' WHERE UnitName = ' +
    QuotedStr(UOM) + ' and Multiplier = ' + floattoStr(UOMMult) +
    ' and (ifnull(PartId,0) = 0 or ifnull(PartId,0) = ' +
    IntToStr(PartsId) + ')';
  Result := FieldBynameValue(strSQL, 'UnitID', asInteger);
end;

function GetUnitOfMeasureID(const xUnitName: String;
  ProductID: Integer = 0): Integer;
begin
  strSQL := 'SELECT PartId , UnitID FROM tblunitsofmeasure ' +
             ' WHERE UnitName = ' +    QuotedStr(xUnitName) +
            ' and (ifnull(PartId,0) = 0 or ifnull(PartId,0) = ' +
    IntToStr(ProductID) + ') order by PartId desc';
  Result := FieldBynameValue(strSQL, 'UnitID', asInteger);
end;
function getUOMID(const xUnitName: String; ProductID: Integer)  : Integer; overload;
begin
  strSQL := 'SELECT UnitID FROM tblunitsofmeasure ' +
            ' WHERE UnitName = ' + QuotedStr(xUnitName) +
            ' and  ifnull(PartId,0) = ' +    IntToStr(ProductID) ;
  Result := FieldBynameValue(strSQL, 'UnitID', asInteger);
end;
Function getUnitProductName(const UOMID: Integer): String;
begin
  Result := '';
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('Select partName');
      SQL.add('from tblunitsofmeasure  inner join tblParts on tblunitsofmeasure.PartId =  tblParts.PartsId');
      SQL.add('where unitId = ' + IntToStr(UOMID));
      Open;
      if not IsEmpty then
        Result := Fields[0].AsString;
    finally
      Free;
    end;
end;

function GetProductUoMID(const ProductID: TProductID;
  const UoMType: TUoMType = uomOnSale): Integer;
var
  Product: TProduct;
begin
  Product := TProduct.Create(nil);
  try
    Product.IgnoreAccesslevel := True;
    Product.Load(ProductID);
    if UoMType = uomOnSale then
      Result := Product.UOMSalesID
    else
      Result := Product.UOMPurchasesID
  finally
    FreeAndNil(Product);
  end;
end;

function GetProductTaxCode(const ProductID: TProductID;
  const TaxCode: TTaxOnType = tcOnSale): String;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := CommonDBLib.TempMyQuery;
  try
    qry.SQL.Text := 'SELECT TaxCode, PurchTaxCode' +
      ' FROM tblParts WHERE PartsId = ' + IntToStr(ProductID);
    qry.Open;
    if not qry.IsEmpty then
    begin
      if TaxCode = tcOnSale then
        Result := qry.fieldByname('TaxCode').AsString
      else
        Result := qry.fieldByname('PurchTaxCode').AsString;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetProductDescription(const ProductID: TProductID): String;
begin
  Result := '';

  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('SELECT PARTSDESCRIPTION FROM tblparts ' +
        'WHERE PARTSID = :PARTSID');
      ParamByName('PARTSID').asInteger := ProductID;
      Open;
      if not IsEmpty then
        Result := fieldByname('PARTSDESCRIPTION').AsString;
    finally
      Free;
    end;
end;

function GetSaleIDForGlobalRef(const GlobalRef: String): Integer;
begin
  REsult := 0;
  if GlobalRef = '' then exit;
  strSQL:='SELECT SaleID FROM tblsales WHERE GlobalRef =' + QuotedStr(GlobalRef);
  Result := FieldBynameValue(strSQL, 'SaleID', asInteger);
end;

function GetSaleGlobalRef(const ID: Integer): String;
begin
  Result := getGlobalref('tblsales', 'SaleID', ID);
end;

function GetCashCustID: Integer;
begin
  Result := getclientID(CLIENT_CASH);
end;

function GetTaxRateForCode(const aTaxCode: String): Double;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := CommonDBLib.TempMyQuery;
  try
    qry.SQL.Text := 'SELECT * FROM tblTaxCodes WHERE Name = ' +
      QuotedStr(aTaxCode) + ' AND RegionID=' +
      IntToStr(AppEnv.RegionalOptions.ID) + ';';
    qry.Open;
    if not qry.IsEmpty then
    begin
      Result := qry.fieldByname('Rate').asFloat;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetAccountNumber(const iAccountID: Integer): String;
begin
  strSQL := 'SELECT Accountnumber FROM tblChartofAccounts where AccountID = ' +
    IntToStr(iAccountID);
  Result := FieldBynameValue(strSQL, 'Accountnumber', AsString);
end;
function AccountIDForNumber(const Accountnumber: string): integer;
begin
  strSQL := 'SELECT AccountID FROM tblChartofAccounts where Accountnumber = ' + quotedstr(Accountnumber);
  Result := FieldBynameValue(strSQL, 'AccountID', asInteger);
end;
function AccountIDForName(const AccountName: String): integer;
begin
  strSQL := 'SELECT AccountID FROM tblChartofAccounts where AccountName = ' + quotedstr(AccountName);
  Result := FieldBynameValue(strSQL, 'AccountID', asInteger);
end;

function GetAccountName(const Accountnumber: String): String; Overload;
begin
  strSQL := 'SELECT AccountID,AccountName FROM tblChartofAccounts where AccountNumber = '
    + QuotedStr(Accountnumber);
  Result := FieldBynameValue(strSQL, 'AccountName', AsString);
end;

function GetAccountName(const iAccountID: Integer): String;
begin
  strSQL := 'SELECT AccountID,AccountName FROM tblChartOfAccounts WHERE AccountID ='
    + IntToStr(iAccountID);
  Result := FieldBynameValue(strSQL, 'AccountName', AsString);
end;

Function GetAccountTypeID(const iAccountTypeName: String): Integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := False;
  try
    with qry do
    begin
      // Account table
      SQL.Clear;
      SQL.add('SELECT TypeID FROM tblAccTypeDesc');
      SQL.add('WHERE AccType =' + QuotedStr(iAccountTypeName) + ';');
      Open;
      if not IsEmpty then
      begin
        Result := fieldByname('TypeID').asInteger;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
End;

Function getDeductionAccountID(const iDeductionID: Integer): Integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := False;
  try
    with qry do
    begin
      SQL.Clear;
      SQL.add('SELECT DeductionID,AccountID FROM tblDeductions');
      SQL.add('WHERE DeductionID =' + IntToStr(iDeductionID) + ';');
      Open;
      if not IsEmpty then
      begin
        Result := fieldByname('AccountID').asInteger;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
End;

Function getAllowanceAccountID(const iAllowanceID: Integer): Integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := False;
  try
    with qry do
    begin
      SQL.Clear;
      SQL.add('SELECT AllowanceID,AccountID FROM tblAllowances');
      SQL.add('WHERE AllowanceID =' + IntToStr(iAllowanceID) + ';');
      Open;
      if not IsEmpty then
      begin
        Result := fieldByname('AccountID').asInteger;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
End;

function getTypeofAccount(fiAccountID: Integer): String;
begin
  strSQL := 'SELECT tblchartofaccounts.AccountType FROM tblchartofaccounts' +
    ' WHERE tblchartofaccounts.AccountID =' + IntToStr(fiAccountID);
  Result := FieldBynameValue(strSQL, 'AccountType');
end;

Function GetAccountHeaderID(const HeaderType, HeaderName: String): Integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := GetSharedMyDacConnection;
  qry.ParamCheck := False;
  try
    with qry do
    begin
      // header is the field which makes the truee so shouuld have the same type
      SQL.Clear;
      SQL.add('SELECT AccountID FROM tblchartofaccounts');
      SQL.add('WHERE AccountType =' + QuotedStr(HeaderType));
      SQL.add('AND AccountName =' + QuotedStr(HeaderName) + ';');
      Open;
      if not IsEmpty then
      begin
        Result := fieldByname('AccountID').asInteger;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
End;

function GetProductIDForbarCode(const Barcode: String): Integer;
var
  Qry:TERPQuery;
begin
  (* strSQL:= 'Select  P.PartsID ' +
    ' from tblpartbarcodes PB  ' +
    ' inner join tblParts P on P.PartsId = PB.PartsId  ' +
    ' WHERE PB.active = "T" and P.Active ="T" and `PB`.`BarCode` =  ' +QuotedStr(Barcode);
    Result := FieldBynameValue(strSQL , 'PartsID' , asInteger); *)
  Result := 0;
  strSQL := 'Select  P.PartsId, P.Partname, ' +
    'if(P.Active="T" ,"T" ,"F")  ProductActive , ' +
  { sortng enum field dosn;t sort properly, so change to string }
    'if(PB.Active="T" ,"T" , "F")  barcodeActive ' +
    'from tblpartbarcodes PB inner join tblParts P on P.PartsId = PB.PartsId ' +
    ' WHERE `PB`.`BarCode` =  ' + QuotedStr(Barcode) +
    ' order by ProductActive desc , barcodeActive desc Limit 1';
  //with Datautilsdataset(strSQL) do begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    if Qry.active then Qry.Close;
    Qry.SQL.Text :=strSQL;
    Qry.open;
      if Qry.recordcount > 0 then
        if (Qry.fieldByname('ProductActive').asBoolean = False) then begin
          MessageDlgXP_Vista('Product' + ' (' + Qry.fieldByname('PartName').AsString+ ') Selected with Barcode (' + Barcode + ') is Inactive.',mtInformation, [mbok], 0);
          Result := -1;
        end else if (Qry.fieldByname('barcodeActive').asBoolean = False) then begin
          MessageDlgXP_Vista('Prodct Barcode ' + Barcode + ' of Product ' +Qry.fieldByname('PartName').AsString + ' is Inactive.', mtInformation,[mbok], 0);
          Result := -1;
        end else
          Result := Qry.fieldByname('PartsId').asInteger;
  finally
    dbsharedobj.releaseobj(Qry);
  end;
end;

function GetProductForbarCodeEx(const Barcode: String): String;
const
  csQry = 'select Distinct PartName, ProductActive, BarcodeActive'#13#10+
          'from ('#13#10+
          'select Distinct P.PartName,'#13#10+
          'if (P.Active="T", "T", "F") ProductActive,'#13#10+
          'if (PB.Active="T", "T", "F") barcodeactive'#13#10+
          'from tblpartbarcodes PB inner join tblParts P on P.PartsId=PB.PartsId'#13#10+
          'where  PB.BarCode = "%s"'#13#10+
          'union all'#13#10+
          'select Distinct E.PartName,'#13#10+
          'if (P.Active="T", "T", "F") ProductActive,'#13#10+
          '"T" as barcodeactive'#13#10+
          'from tblExtraPrice E'#13#10+
          'inner join tblParts P on E.PartsId=P.PartsId'#13#10+
          'where E.SupplierBarCode = "%s"'#13#10+
          ') TT'#13#10+
          'order by ProductActive desc, barcodeactive desc limit 1;';
var
  Qry:TERPQuery;
begin
  Result := '';
  { oder by and limit is to avoid inactive barcodes. Its possible to create the
    barcode for 1 product and then dlete it and add to another part. the deleted
    barcode exists for the first product as inactive }
  //with Datautilsdataset(strSQL) do begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    Qry.Close;
    Qry.SQL.Text := Format(csQry, [BarCode, BarCode]);
    Qry.open;
    if Qry.recordcount > 0 then
      if (Qry.fieldByname('ProductActive').asBoolean = False) then
      begin
        MessageDlgXP_Vista('Product' + ' (' + Qry.fieldByname('PartName').AsString + ') Selected with Barcode (' + Barcode + ') is Inactive.',mtInformation, [mbok], 0);
        Result := 'InactiveProduct';
      end
      else if (Qry.fieldByname('barcodeActive').asBoolean = False) then
      begin
        MessageDlgXP_Vista('Product Barcode ' + Barcode + ' of Product ' + Qry.fieldByname('PartName').AsString + ' is Inactive.', mtInformation, [mbok], 0);
        Result := 'Inactivebarcode';
      end
      else
//        Result := FieldBynameValue(strSQL, 'Partname', AsString);
        Result := qry.FieldByName('PartName').AsString;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

function GetProductForbarCode(const Barcode: String): String;
var
  Qry:TERPQuery;
begin
  Result := '';
  strSQL := 'Select  P.Partname ,  ' +
    'if(P.Active="T" ,"T" ,"F")  ProductActive , ' +
  { sortng enum field dosn;t sort properly, so change to string }
    'if(PB.Active="T" ,"T" , "F")  barcodeActive ' +
    'from tblpartbarcodes PB inner join tblParts P on P.PartsId = PB.PartsId ' +
    ' WHERE `PB`.`BarCode` =  ' + QuotedStr(Barcode) +
    ' order by ProductActive desc , barcodeActive desc Limit 1';
  { oder by and limit is to avoid inactive barcodes. Its possible to create the
    barcode for 1 product and then delete it and add to another part. the deleted
    barcode exists for the first product as inactive }
  //with Datautilsdataset(strSQL) do begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    if Qry.active then Qry.Close;
    Qry.SQL.Text :=strSQL;
    Qry.open;
      if Qry.recordcount > 0 then
        if (Qry.fieldByname('ProductActive').asBoolean = False) then begin
          MessageDlgXP_Vista('Product' + ' (' + Qry.fieldByname('PartName').AsString + ') Selected with Barcode (' + Barcode + ') is Inactive.',mtInformation, [mbok], 0);
          Result := 'InactiveProduct';
        end else if (Qry.fieldByname('barcodeActive').asBoolean = False) then begin
          MessageDlgXP_Vista('Prodct Barcode ' + Barcode + ' of Product ' + Qry.fieldByname('PartName').AsString + ' is Inactive.', mtInformation, [mbok], 0);
          Result := 'Inactivebarcode';
        end else
        // ?? Why we need to run the same qry twice???
//          Result := FieldBynameValue(strSQL, 'Partname', AsString);
          Result := qry.FieldByName('PartName').AsString;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

function GetProduct(const ProductName: String; fconnection: TCustomMyconnection ): Integer; overload;
var
  srch: string;
begin
  srch := StringReplace(ProductName,'\','\\',[rfReplaceAll]);
  Result := 0;
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      if fconnection <> nil then Connection := fconnection else Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('Select PartsId from tblParts where PartName = ' +
        QuotedStr(srch) + ' or Trim(PartName) = ' +
        QuotedStr(trim(srch)));
      Open;
      if not IsEmpty then
        Result := fieldByname('PartsId').asInteger;
    finally
      Free;
    end;
end;
function GetProduct(const ProductName: String): Integer;
var
  srch: string;
begin
  srch := StringReplace(ProductName,'\','\\',[rfReplaceAll]);
  strSQL:='Select PartsId from tblParts where PartName = ' +
        QuotedStr(srch) + ' or Trim(PartName) = ' +
        QuotedStr(trim(srch));
  Result := FieldBynameValue(strSQL, 'PartsId', asInteger);
  (*with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('Select PartsId from tblParts where PartName = ' +
        QuotedStr(srch) + ' or Trim(PartName) = ' +
        QuotedStr(trim(srch)));
      Open;
      if recordcount > 0 then
        Result := fieldByname('PartsId').asInteger;
    finally
      if Active then
        close;
      Free;
    end;*)
end;
function GetProducttype(const ProductID: Integer): String;
begin
  Result := '';
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('Select Parttype from tblParts where PartsId = ' +IntToStr(ProductID));
      Open;
      if recordcount > 0 then
        Result := fieldByname('Parttype').AsString;
    finally
      if Active then
        close;
      Free;
    end;
end;
function IsBAtchProduct(const ProductID: Integer): Boolean;
begin
    strSQL:= 'Select batch from tblparts where partsId = ' + inttostr(ProductID);
    Result := FieldBynameValue(strSQL, 'batch', asBoolean);
end;
function GetProduct(const ProductID: Integer): String;
begin
  strSQL:=' Select PartName from tblParts where PartsId = ' +IntToStr(ProductID);
  Result := FieldBynameValue(strSQL, 'PartName', asString) ;
end;

function getShipContainerID(const ShipContainerName: String): Integer;
begin
  Result := 0;
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('SELECT ContainerName,ShippingContainerID FROM tblShippingContainer');
      SQL.add('WHERE ContainerName = ' + QuotedStr(ShipContainerName));
      Open;
      if recordcount > 0 then
        Result := fieldByname('ShippingContainerID').asInteger;
    finally
      if Active then
        close;
      Free;
    end;
end;

function GetProductAttribGroupID(const GroupName: String): Integer;
begin
  Result := 0;
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('SELECT tblproductattributegroups.PAG_ID FROM tblproductattributegroups');
      SQL.add('WHERE tblproductattributegroups.Name = ' + QuotedStr(GroupName));
      Open;
      if recordcount > 0 then
        Result := fieldByname('PAG_ID').asInteger;
    finally
      if Active then
        close;
      Free;
    end;
end;

function IsCustomerTermsOK(const iClientID: Integer; var Msg: String): Boolean;
begin
  with TempMyQuery do
  begin
    try
      SQL.Clear;

      SQL.add('SELECT SaleID, DueDate, GracePeriod, Paid, ' +
        'tblSales.Balance, TotalAmountInc ' +
        'FROM tblSales INNER JOIN tblClients ' +
        'ON tblSales.ClientID = tblClients.ClientID ' +
        'WHERE tblSales.ClientID = ' + IntToStr(iClientID) +
        ' AND IsInvoice = "T" AND ' +
        'Paid <> "T" AND TotalAmountInc > 0.00 AND tblSales.Balance > 0.0 AND '
        + 'CURDATE() > Date_add(DueDate  , INTERVAL  GracePeriod DAY) ORDER BY DueDate ');
      Open;
      if not IsEmpty then
      begin
        // There are overdues
        Result := False;
        First;
        Msg := 'Customer has exceeded Terms on previous Sale#' +
          IntToStr(fieldByname('SaleID').asInteger) + #13#10 + 'Date Due: ' +
          fieldByname('DueDate').AsString;
      end
      else
      begin
        Result := True;
      end;
    finally
      Free;
    end;
  end;
end;

function getUnitMultiplier(const UnitID: Integer): Double;
begin
  strSQL:= 'Select Multiplier from tblUnitsOfMeasure ' +
           ' where UnitID = ' + IntToStr(UnitID);
  Result := FieldBynameValue(strSQL, 'Multiplier', asFloat);
  if result =0 then result := 1;
  (*Result := 1;
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('Select Multiplier from tblUnitsOfMeasure ');
      SQL.add('where UnitID = ' + IntToStr(UnitID));
      Open;
      if recordcount > 0 then
        Result := fieldByname('Multiplier').asFloat;
    finally
      if Active then
        close;
      Free;
    end;*)
end;

function GetClientTerms(const iClientID: Integer): String;
begin
  strSQL := 'SELECT Terms FROM tblClients WHERE ClientID = ' +
    IntToStr(iClientID);
  Result := FieldBynameValue(strSQL, 'TERMS', AsString);
end;

function GetClassName(const iClassID: Integer): String;
begin
  strSQL := 'SELECT ClassName FROM tblClass WHERE ClassID = ' +
    IntToStr(iClassID);
  Result := FieldBynameValue(strSQL, 'ClassName', AsString);
end;
function GetClassName(const sClassID: String): String;overload;
begin
  result := '';
  if sClassID ='' then exit;
  if not (Isinteger(sClassID)) then exit;
  strSQL := 'SELECT ClassName FROM tblClass WHERE ClassID = ' + sClassID;
  Result := FieldBynameValue(strSQL, 'ClassName', AsString);
  if Result ='' then
    if  sClassID = inttostr(IDForallOther) then
      REsult :='All Other Classes (Including Inactive)';
end;
{ Chart of Accounts related }

{ TaxCode related }
function GetGLTaxCodeIDForName(const TaxCodeName: String): Integer;
begin
  with TempMyQuery do
  begin
    try
      SQL.Text := 'SELECT TaxCodeID FROM tbltaxcodes WHERE Name = ' +
        QuotedStr(TaxCodeName) + ' AND RegionID=' +
        IntToStr(AppEnv.RegionalOptions.ID) + ';';
      Open;
      Result := fieldByname('TaxCodeID').asInteger;
    finally
      Free;
    end;
  end;
end;

{ Back Order Related }
function POBackOrderIsInvoiced(const BackOrderGlobalRef: String): Boolean;
begin
  Result := False;
  with TempMyQuery do
  begin
    try
      SQL.Text :=
        ' SELECT Sum(PL.Shipped) as ShippedSum FROM tblPurchaseLines PL, tblPurchaseOrders  P'
        + ' WHERE PL.PurchaseOrderId = P.PurchaseOrderID AND P.GlobalRef = ' +
        QuotedStr(BackOrderGlobalRef);
      Open;
      if fieldByname('ShippedSum').asFloat <> 0 then
        Result := True;
      close;
    finally
      Free;
    end;
  end;
end;

Function getPurchaseOrderID(const PurchaseLineID: Integer): Integer;
begin
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('select PurchaseOrderID,PurchaseLineID');
      SQL.add('from tblpurchaselines where PurchaseLineID = ' +
        IntToStr(PurchaseLineID));
      Open;
      if recordcount > 0 then
        Result := fieldByname('PurchaseOrderID').asInteger
      else
        Result := 0;
    finally
      if Active then
        close;
      Free;
    end;
end;

Function GetSaleIDLinkedToPurchase(const PurchaseLineID: Integer): Integer;
begin
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('SELECT PL.SaleLineID,SL.SaleID');
      SQL.add('FROM tblpurchaseLines PL');
      SQL.add('INNER JOIN tblsalesLines SL ON SL.SaleLineID= PL.SaleLineID');
      SQL.add('WHERE PurchaseLineID = ' + IntToStr(PurchaseLineID));
      Open;
      if recordcount > 0 then
        Result := fieldByname('SaleID').asInteger
      else
        Result := 0;
    finally
      if Active then
        close;
      Free;
    end;
end;

Function GetPurchaseLineIDLinkedToSale(const SaleLineID: Integer): Integer;
begin
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('SELECT PL.SaleLineID,PL.PurchaseLineID');
      SQL.add('FROM tblpurchaseLines PL');
      SQL.add('WHERE SaleLineID = ' + IntToStr(SaleLineID));
      Open;
      if recordcount > 0 then
        Result := fieldByname('PurchaseLineID').asInteger
      else
        Result := 0;
    finally
      if Active then
        close;
      Free;
    end;
end;

Function GetSaleLineIDLinkedToPurchase(const PurchaseLineID: Integer): Integer;
begin
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('SELECT PL.SaleLineID,SL.SaleID');
      SQL.add('FROM tblpurchaseLines PL');
      SQL.add('INNER JOIN tblsalesLines SL ON SL.SaleLineID= PL.SaleLineID');
      SQL.add('WHERE PurchaseLineID = ' + IntToStr(PurchaseLineID));
      Open;
      if recordcount > 0 then
        Result := fieldByname('SaleLineID').asInteger
      else
        Result := 0;
    finally
      if Active then
        close;
      Free;
    end;
end;

function getUserName(const UserId: Integer): String;
begin
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('select Concat_ws('' '' , FirstName, LastName) as UserName');
      SQL.add('from tblemployees where EmployeeID = ' + IntToStr(UserId));
      Open;
      if recordcount > 0 then
        Result := fieldByname('UserName').AsString;
    finally
      if Active then
        close;
      Free;
    end;
end;
Function GetDefaultTemplate(TemplType: String): String;
begin
  result:= GetDefaultTemplate(TemplateTypeID(TemplType));
end;

Function GetDefaultTemplate(TemplTypeID: Integer): String;
begin
  strSQL := ' SELECT TemplName FROM tbltemplates ' + ' WHERE TypeID = ' +
    IntToStr(TemplTypeID) + ' AND DefaultTemplate = "T"';
  Result := FieldBynameValue(strSQL, 'TemplName', AsString);
end;

function ClientAppointmentCount(const clientID: Integer;
  Const AtDateTime: TDateTime): Integer;
Var
  qry: TERPQuery;
Begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  with qry do
    try
      qry.Options.FlatBuffers := True;
      qry.Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.Clear;
      SQL.add('SELECT COUNT(*) as Count FROM tblappointments');
      SQL.add('WHERE Cancellation="F" AND Active="T" ');
      SQL.add('AND CusID = :xCusID AND STARTTIME < :xDateTime;');
      Params.ParamByName('xCusID').asInteger := clientID;
      Params.ParamByName('xDateTime').asDateTime := AtDateTime;
      Open;
      If recordcount > 0 then
        Result := fieldByname('Count').asInteger + 1;
    finally
      FreeAndNil(qry);
    end;
end;

procedure InsertSimpleTypeRecord(const AType, aName, aDescription: String;
  const IsDefault, Active: Boolean);
var
  qry: TERPQuery;
begin
  qry := TempMyQuery;
  try
    qry.SQL.Text := 'INSERT HIGH_PRIORITY INTO tblSimpleTypes' +
      ' (TypeCode,Name,Description,IsDefault,Active) Values(' + QuotedStr(AType)
      + ',' + QuotedStr(aName) + ',' + QuotedStr(aDescription) + ',' +
      BooleanToSQLStr(IsDefault) + ',' + BooleanToSQLStr(Active) + ')';
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

function GetUnitOfTimeName(const UOTID: Integer): String;
begin
  Result := '';
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('SELECT UnitOfTimeName AS UnitName FROM tblunitsoftime');
      SQL.add('WHERE UnitOfTimeID = ' + IntToStr(UOTID));
      Open;
      if not IsEmpty then
        Result := fieldByname('UnitName').AsString;
    finally
      Free;
    end;
end;

Function getSupplierName(const SupplierID: Integer): String;
begin
  strSQL := 'SELECT company  FROM tblClients WHERE clientId = ' +
    IntToStr(SupplierID) + ' and supplier = ''T'' ';
  Result := FieldBynameValue(strSQL, 'Company');
end;

Function getSupplierID(const SupplierName: String): Integer;
begin
  strSQL := 'SELECT clientID FROM tblClients WHERE supplier = ''T'' and Company = '
    + QuotedStr(SupplierName);
  Result := FieldBynameValue(strSQL, 'clientID', asInteger);
end;
function GetCompanyname(fconnection: TCustomMyconnection = nil): String;
begin
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      if fconnection <> nil then Connection := fconnection else Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add('SELECT CompanyName, Address, Address2, City, State, Postcode FROM tblCompanyInformation');
      Open;
      if not IsEmpty then
        Result := fieldByname('CompanyName').AsString;
    finally
      Free;
    end;

end;
function GetCompanyAddress: String;
begin
  Result := 'Not Specified';
  with TERPQuery.Create(nil) do
    try
      Connection := GetSharedMyDacConnection;
      SQL.add('SELECT CompanyName, Address, Address2, City, State, Postcode, Country FROM tblCompanyInformation');
      Open;
      Result := ConcatStrings([fieldByname('CompanyName').AsString ,
                               fieldByname('Address').AsString,
                               fieldByname('Address2').AsString,
                               ConcatStrings([fieldByname('City').AsString , fieldByname('State').AsString , fieldByname('Postcode').AsString], ' '),
                               fieldByname('Country').AsString] , chr(13)+chr(10));
      close;
    finally
      Free;
    end;
end;

function IsEUCountry(const sCountry: String): Boolean;
begin
  Result := False;
  with TERPQuery.Create(nil) do
    try
      Connection := GetSharedMyDacConnection;
      SQL.add('SELECT CountryName FROM tbleucountries WHERE CountryName = ' +
        QuotedStr(sCountry));
      Open;
      if recordcount > 0 then
        Result := True;
      close;
    finally
      Free;
    end;
end;

function IsInternational(const sCountry: String): Boolean;
begin
  strSQL:= 'Select countryId from tblcountries where Country = ' + Quotedstr(Scountry);
  Result := FieldBynameValue(strSQL, 'countryId', asInteger) <> appenv.RegionalOptions.CountryId;
end;

Function getCurrencyID(const CurrencyName: String): Integer;
begin
  strSQL := 'Select CurrencyId from tblcurrencyconversion where Currency = ' +
    QuotedStr(CurrencyName) + ' or Code = ' + QuotedStr(CurrencyName);
  Result := FieldBynameValue(strSQL, 'CurrencyID', asInteger);
end;

Function getPickingPriority(const Priority: String): Integer;
var
  x: Integer;
  PriorityID: String;
  charfound: Boolean;
  singleChar: String;
begin
  Result := 0;
  charfound := False;
  PriorityID := '';
  For x := 0 to char_length(Priority) - 1 do
    if not charfound then
    begin
      singleChar := Copy(Priority, x, 1);
      if (singleChar = '1') or (singleChar = '2') or (singleChar = '3') or
        (singleChar = '4') or (singleChar = '5') or (singleChar = '6') or
        (singleChar = '7') or (singleChar = '8') or (singleChar = '9') or
        (singleChar = '0') then
        PriorityID := PriorityID + singleChar
      else
        charfound := True;
    End;
  if PriorityID <> '' then
    Result := StrToInt(PriorityID);
end;

Function getCurrencyName(const CurrencyId: Integer): String;
begin
  strSQL := 'Select Currency from tblcurrencyconversion where CurrencyId = ' +
    IntToStr(CurrencyId);
  Result := FieldBynameValue(strSQL, 'Currency');
end;

function getClientTypeName(const CTID: Integer): String;
begin
  strSQL := 'Select typename from tblclienttype where ClienttypeID = ' +
    IntToStr(CTID);
  Result := FieldBynameValue(strSQL, 'typename');
end;

function DefaultclientTypeId: Integer;
begin
  strSQL := 'Select ClienttypeID from tblclienttype where typename = ' +
    QuotedStr('Default');
  Result := FieldBynameValue(strSQL, 'ClienttypeID', asInteger);
  if Result = 0 then
  begin
    With CommonDBLib.TempMyScript do
      try
        SQL.add('Replace into tblclienttype '+
              ' (TypeName , TypeDescription)  '+
              ' Select distinct "Default" , "Default" from tblclienttype where "Default" Not in (Select Typename from tblclienttype);');
        (* SQL.add('update tblClients   '+
            ' Set ClientTypeID =(Select Min(tblclienttype.ClientTypeID) from tblclienttype where tblclienttype.TypeName = "Default")    '+
            ' where ifnull(tblClients.ClientTypeID ,0)= 0   '+
            ' and customer = "T" ;'); *)
        Execute;
      finally
        Free;
      end;
    Result := FieldBynameValue(strSQL, 'ClienttypeID', asInteger);
  end;
end;

function getClientTypeID(const CTName: String): Integer;
begin
  strSQL := 'Select ClienttypeID from tblclienttype where typename = ' +
    QuotedStr(CTName);
  Result := FieldBynameValue(strSQL, 'ClienttypeID', asInteger);
end;

Function getProcessStep(const ProcessStepID: Integer): String;
begin
  strSQL := 'Select Description from tblProcessstep ' + ' where ID  =  ' +
    IntToStr(ProcessStepID);
  Result := FieldBynameValue(strSQL, 'Description');
end;

Function GetTreeRootID(const ProductID: Integer): Integer;
begin
  strSQL := 'Select ProcTreeId from tblproctree AS PT  ' + ' where  MasterID = '
    + IntToStr(ProductID) +
    ' and PT.MasterType =  "mtProduct" AND PT.ParentId = 0';
  Result := FieldBynameValue(strSQL, 'ProcTreeId', asInteger);
end;
function BOMProcesses:Integer;
begin
  strSQL := 'select ProctreeId, count(ID) ctr from tblprocesspart group by proctreeId order by ctr desc limit 1 ';
  Result := FieldBynameValue(strSQL, 'ctr', asInteger);
end;
Function BOMTreeLevels: Integer;
begin
  strSQL := 'Select max(Level) as BOMTreeLevels from tblProctree';
  Result := FieldBynameValue(strSQL, 'BOMTreeLevels', asInteger)+1;
end;
Function BOMPRocessSteps: Integer;
begin
  strSQL := 'select ProctreeId , count(ID) ctr from tblprocesspart group by ProctreeId order by ctr desc limit 1';
  Result := FieldBynameValue(strSQL, 'ctr', asInteger);
end;
Function getProcessStep(const ProcessStepdesc: String): Integer;
begin
  strSQL := 'Select ID from tblProcessstep ' + ' where Description  =  ' +
    QuotedStr(ProcessStepdesc);
  Result := FieldBynameValue(strSQL, 'ID', asInteger);
end;

function getUserVersion: String;
begin
  strSQL := 'SELECT Version  FROM tblUpdateDetails where Current = "T" ';
  Result := FieldBynameValue(strSQL, 'Version');
end;

Function getTaxcodeID(const TaxCode: String): Integer;
begin
  strSQL := 'SELECT TaxCodeID FROM tbltaxcodes  ' + ' Where RegionID= ' +
    IntToStr(AppEnv.RegionalOptions.ID) + ' AND Name = ' + QuotedStr(TaxCode);
  Result := FieldBynameValue(strSQL, 'TaxCodeID', asInteger);
end;

Function getTaxcode(const TaxCodeID: Integer): String;
begin
  strSQL := 'SELECT Name FROM tbltaxcodes  ' + ' Where  TaxCodeID = ' +
    IntToStr(TaxCodeID);
  Result := FieldBynameValue(strSQL, 'Name');
end;

Function getBankCodeID(const BankCode: String; RegionID: integer): Integer;
begin
  strSQL := 'Select CodeID FROM tblBankCodes ' + ' Where  BankCode = ' +
    QuotedStr(BankCode) + ' and RegionId = ' + IntToStr(RegionID);
  Result := FieldBynameValue(strSQL, 'CodeID', asInteger);
end;

Function GetClientBankCode(const clientID: Integer): String;
begin
  strSQL := 'Select BankCode FROM tblClients ' + ' Where  ClientID = ' +
    IntToStr(clientID);
  Result := FieldBynameValue(strSQL, 'BankCode', AsString);
end;
Function DefaultStsClassBinId(Const classid: Integer): Integer;
begin
  strSQL := 'SELECT DefaultStSBinID from tblstsclass CL ' + ' where ClassID=' + IntToStr(classid) ;
  Result := FieldBynameValue(strSQL, 'DefaultStSBinID', asInteger);
end;
Function DefaultBinId(Const classid, ProductID: Integer): Integer;
begin
  strSQL := 'SELECT DefaultbinId from tblProductclasses CL ' + ' where ClassID='
    + IntToStr(classid) + ' and ProductId = ' + IntToStr(ProductID);
  Result := FieldBynameValue(strSQL, 'DefaultbinId', asInteger);
end;
Function DefaultstockClassId(Const ProductID: Integer): Integer;
begin
  strSQL := 'SELECT ClassID from tblProductclasses CL ' + ' where ProductId = ' + IntToStr(ProductID)+' and IsDefaultStockClass ="T"';
  Result := FieldBynameValue(strSQL, 'ClassID', asInteger);
end;
Function getLeadID(Contacttype: String; contactID: Integer): Integer;
begin
  if Pos(Contacttype, 'Job') = 1 then
    contactID := ClientIDofJob(contactID);

  strSQL := 'SELECT LeadID FROM tblmarketingleads ';
  if Pos(Contacttype, 'Marketing Contact') = 1 then
    strSQL := strSQL + ' where MarketingContactID= ' + IntToStr(contactID)
    (* else if Pos(contacttype ,'Job') = 1 then
      strSQL:= strSQL+' where ClientID <> 0 and ClientID= ' +IntToStr(ClientIDofJob(contactId)) *)
  else
    strSQL := strSQL + ' where ClientID <> 0 and ClientID= ' +
      IntToStr(contactID);
  Result := FieldBynameValue(strSQL, 'LeadId', asInteger);
end;
Function ClientFundingbody(Const clientID: Integer): String;
begin
  strSQL := 'Select Mastercompany  from tblrelatedclients  where ChildclientId = ' +
    IntToStr(clientID) ;
  Result := FieldBynameValue(strSQL, 'Mastercompany', asString);
end;
Function ClientIDofJob(Const clientID: Integer): Integer;
begin
  strSQL := 'select parentclientID from tblClients where clientID = ' +
    IntToStr(clientID) + '  and isjob = "T"';
  Result := FieldBynameValue(strSQL, 'parentclientID', asInteger);
end;

function GetBinID(Const binLocation, binnumber: String;
  const classid: Integer): Integer;
begin
  strSQL := 'SELECT BinID ' + ' from tblProductbin  ' +
    ' where ifnull(binlocation,"") = ' + QuotedStr(binLocation) +
    ' and ifnull(binnumber,"") = ' + QuotedStr(binnumber) + ' and classid = ' +
    IntToStr(classid);
  Result := FieldBynameValue(strSQL, 'BinID', asInteger);
end;
function GetBinLocation(const BinID:Integer): String;
begin
  strSQL := 'SELECT binlocation ' + ' from tblProductbin  ' +
    ' where BinID = ' +    IntToStr(binID);
  Result := FieldBynameValue(strSQL, 'binlocation', asString);

end;
function GetBinnumber(const BinID:Integer): String;
begin
  strSQL := 'SELECT binNumber ' + ' from tblProductbin  ' +
    ' where BinID = ' +    IntToStr(binID);
  Result := FieldBynameValue(strSQL, 'binNumber', asString);
end;
function GetBinLocationnnumber(const BinID:Integer): String;
begin
  strSQL := 'SELECT binlocation, binNumber ' + ' from tblProductbin  ' +
    ' where BinID = ' +    IntToStr(binID);
  Result := trim(FieldBynameValue(strSQL, 'Binlocation', asString))+
            trim(FieldBynameValue(strSQL, 'binNumber', asString));
end;
function GetDeptID(const iClassName: String): Integer;
begin
  strSQL := 'SELECT ClassID FROM tblClass WHERE ClassName = ' +
    QuotedStr(iClassName);
  Result := FieldBynameValue(strSQL, 'ClassID', asInteger);
end;

Function GetAccountPayableID: Integer;
begin
  strSQL := 'SELECT AccountID  FROM tblChartOfAccounts WHERE AccountName =' +
    QuotedStr(ACNT_ACNTS_PAY) + ' and AccountType = "AP";';
  Result := FieldBynameValue(strSQL, 'AccountID', asInteger);
end;

Function GetAccountReceivableID: Integer;
begin
  strSQL := 'SELECT AccountID  FROM tblChartOfAccounts WHERE AccountName =' +
    QuotedStr(ACNT_ACNTS_RCV) + ' and AccountType = "AR";';
  Result := FieldBynameValue(strSQL, 'AccountID', asInteger);
end;

Function GetAccountID(const AccountName: String): Integer;
begin
  strSQL := 'SELECT AccountID  FROM tblChartOfAccounts WHERE AccountName =' +
    QuotedStr(AccountName) + ';';
  Result := FieldBynameValue(strSQL, 'AccountID', asInteger);
end;

Function getClientName(const clientID: Integer): String;
begin
  strSQL := 'SELECT Company FROM tblclients WHERE ClientID = ' +
    IntToStr(clientID);
  Result := FieldBynameValue(strSQL, 'Company');
End;

function GetClientFaxNumber(const clientID: Integer): String;
begin
  strSQL := 'SELECT FaxNumber FROM tblClients WHERE ClientID =' +
    IntToStr(clientID);
  Result := FieldBynameValue(strSQL, 'FaxNumber', AsString);
end;

function getemployeeID(const EmployeeName: String): Integer;
begin
  strSQL := 'select EmployeeID from tblEmployees where EmployeeName = ' +
    QuotedStr(EmployeeName);
  Result := FieldBynameValue(strSQL, 'EmployeeID', asInteger);
End;

function getemployeeName(const EmployeeID: Integer): String;
begin
  strSQL := 'select EmployeeName from tblEmployees where EmployeeID = ' +
    IntToStr(EmployeeID);
  Result := FieldBynameValue(strSQL, 'EmployeeName');
End;

function getemployeeFirstName(const EmployeeID: Integer): String;
begin
  strSQL := 'select FirstName from tblEmployees where EmployeeID = ' +
    IntToStr(EmployeeID);
  Result := FieldBynameValue(strSQL, 'FirstName');
End;

function GetEmployeeQuota(const EmployeeID: Integer): Double;
begin
  strSQL := 'SELECT SalesTarget FROM tblEmployees WHERE EmployeeID = ' + IntToStr(EmployeeID);
  Result := FieldBynameValue(strSQL, 'SalesTarget');
End;

function GetEmployeeApprovalValueH(const EmployeeID: Integer;
  AType: String): Double;
begin
  Result := 0;
  strSQL := 'SELECT * FROM tblapprovalLevels WHERE Active = "T" AND EmployeeID ='
    + IntToStr(EmployeeID) + ' AND ApprovalType = ' + QuotedStr(AType);

  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add(strSQL);
      Open;
      if not IsEmpty then
        Result := fieldByname('ValueTo').asFloat;
    finally
      Free;
    end;
End;

function GetEmployeeApprovalValueL(const EmployeeID: Integer;
  AType: String): Double;
begin
  Result := 0;
  strSQL := 'SELECT * FROM tblapprovalLevels WHERE Active = "T" AND EmployeeID ='
    + IntToStr(EmployeeID) + ' AND ApprovalType = ' + QuotedStr(AType);
  with TERPQuery.Create(nil) do
    try
      Options.FlatBuffers := True;
      Connection := CommonDBLib.GetSharedMyDacConnection;
      SQL.add(strSQL);
      Open;
      if not IsEmpty then
        Result := fieldByname('ValueFrom').asFloat;
    finally
      Free;
    end;
End;

function getCostCentreID(const costCentreName: String): Integer;
begin
  strSQL := 'Select costCentreID from tblCostCentre where CostCentreName = ' +
    QuotedStr(costCentreName);
  Result := FieldBynameValue(strSQL, 'costCentreID', asInteger);
End;

function getCostCentrename(const costCentreID: Integer): String;
begin
  strSQL := 'Select CostCentreName from tblCostCentre where costCentreID = ' +
    IntToStr(costCentreID);
  Result := FieldBynameValue(strSQL, 'CostCentreName');
End;

function GetPartSpecID(const ProductID: Integer;
  const SpecDescription: String): Integer;
begin
  strSQL := 'Select PartSpecId from tblPartsSpecifications ' +
    ' where PartsId =' + IntToStr(ProductID) + '  and SpecDescription = ' +
    QuotedStr(SpecDescription);
  Result := FieldBynameValue(strSQL, 'PartSpecId', asInteger);
end;

Function GetRegion(const RegionName: String): Integer;
begin
  strSQL := 'Select RegionID from tblregionalOptions where Region = ' +
    QuotedStr(RegionName);
  Result := FieldBynameValue(strSQL, 'RegionID', asInteger);
end;

Function GetRegion(const RegionID: Integer): String;
begin
  strSQL := 'Select Region from tblregionalOptions where  RegionID = ' +
    IntToStr(RegionID);
  Result := FieldBynameValue(strSQL, 'Region');
End;
Function GetRegionIDForCountry(const aCountry:String): Integer;
var
  acountryID :Integer;
begin
  strSQL := 'Select CountryId from tblcountries where Country = ' + quotedstr(aCountry) + '  UNION ALL '+
            ' Select CountryId from tblcountries where countrycode = ' + quotedstr(aCountry) + '  UNION ALL '+
            ' Select CountryId from tblcountries where Shortcountrycode = ' + quotedstr(aCountry);
  acountryID:= FieldBynameValue(strSQL, 'CountryId');
  strSQL := 'Select RegionID from tblregionalOptions where CountryID = ' + inttostr(acountryID);
  Result := FieldBynameValue(strSQL, 'RegionID', asInteger);
end;
function GetTerms(const TermsName: String): Integer;
begin
  strSQL := 'SELECT TermsID FROM tblTerms WHERE Terms =  ' +
    QuotedStr(TermsName);
  Result := FieldBynameValue(strSQL, 'TermsID', asInteger);
end;

function GetTerms(const TermsID: Integer): String; Overload;
begin
  strSQL := 'SELECT Terms FROM tblTerms WHERE  TermsID=  ' + IntToStr(TermsID);
  Result := FieldBynameValue(strSQL, 'Terms');
End;

procedure GetClientTerms(const iClientID: Integer; var iTermsID: Integer;
  var sTerms: string; var dtDateDue: TDateTime; const DefaultTerm: String = '');
var
  qry: TERPQuery;
  iDaysDue: Integer;
  bEOM: Boolean;
  bEOMPlus: Boolean;
begin
  iTermsID := 0;
  sTerms := '';
  dtDateDue := Date;
  strSQL := 'SELECT TermsID  FROM tblClients where ClientID = ' + IntToStr(iClientID);
  iTermsID := FieldBynameValue(strSQL, 'TermsID', asInteger);
  if (iTermsID = 0) and (DefaultTerm <> '') then iTermsID := GetTermsID(DefaultTerm);
  if iTermsID <> 0 then begin
    strSQL := 'SELECT Terms, TermsAmount , EOM, EOMPlus  FROM tblTerms where TermsID = '
      + IntToStr(iTermsID) + ' and Active = "T"';
    //With Datautilsdataset(strSQL) do begin
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
      if Qry.active then Qry.Close;
      Qry.SQL.Text :=strSQL;
      Qry.open;
        if Qry.recordcount > 0 then begin
          sTerms := Qry.fieldByname('Terms').AsString;
          iDaysDue := Qry.fieldByname('TermsAmount').asInteger;
          bEOM := Qry.fieldByname('EOM').asBoolean;
          bEOMPlus := Qry.fieldByname('EOMPlus').asBoolean;
          if not bEOM then begin
            dtDateDue := Date() + iDaysDue;
          end else if bEOMPlus then begin
            dtDateDue := EndOfTheMonth(IncMonth(Date(), 1));
          end else begin
            dtDateDue := IncDay(EndOfTheMonth(Date()), iDaysDue);
          end;
        end;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
  end;

end;

Function getMediatype(const typeName: String): Integer;
begin
  strSQL := 'SELECT MedTypeID FROM tblSource WHERE  MediaType=  ' +
    QuotedStr(typeName);
  Result := FieldBynameValue(strSQL, 'MedTypeID', asInteger);
End;

Function getMediatype(const typeID: Integer): String;
begin
  strSQL := 'SELECT MediaType FROM tblSource WHERE  MedTypeID=  ' +
    IntToStr(typeID);
  Result := FieldBynameValue(strSQL, 'MediaType');
End;

function getshippingMethod(const ShippingMethodName: String): Integer;
begin
  strSQL := 'Select ShippingMethodID from tblShippingMethods where ShippingMethod = '
    + QuotedStr(ShippingMethodName);
  Result := FieldBynameValue(strSQL, 'ShippingMethodID', asInteger);
end;

function GetPaymentMethod(const PaymentMethodID: Integer): String;
begin
  strSQL := 'SELECT NAME FROM tblpaymentmethods WHERE  PayMethodID = ' +
    IntToStr(PaymentMethodID);
  Result := FieldBynameValue(strSQL, 'NAME');
end;

function GetPaymentMethod(const PaymentMethod: String): Integer;
begin
  strSQL := 'SELECT PayMethodID FROM tblpaymentmethods WHERE NAME =' +
    QuotedStr(PaymentMethod);
  Result := FieldBynameValue(strSQL, 'PayMethodID', asInteger);
end;

Function getOtherType(const typeID: Integer): String;
begin
  strSQL := 'SELECT OtherType FROM tblOtherType WHERE OtherTypeID = ' +
    IntToStr(typeID);
  Result := FieldBynameValue(strSQL, 'OtherType');
end;

Function getOtherType(const typeName: String): Integer;
begin
  strSQL := 'SELECT OtherTypeID  FROM tblOtherType WHERE  OtherType= ' +
    QuotedStr(typeName);
  Result := FieldBynameValue(strSQL, 'OtherTypeID');
end;
function GetTemplateTypeId(const TemplID: Integer): Integer;
begin
  strSQL := 'SELECT typeID FROM tbltemplates  WHERE TemplID = ' +    inttostr(TemplID);
  Result := FieldBynameValue(strSQL, 'typeID',asInteger);
end;
function GetTemplateTypeId(const Templname: String): Integer;
begin
  strSQL := 'SELECT typeID FROM tbltemplates  WHERE TemplName = ' +    quotedstr(Templname);
  Result := FieldBynameValue(strSQL, 'typeID',asInteger);
end;
function GetTypeNameoftemplate(const Templname: String): String;
begin
  strSQL := 'SELECT TT.typename FROM tbltemplates  T inner join tbltemplatetype TT on T.TypeID = TT.TypeID WHERE T.TemplName =' +    quotedstr(Templname);
  Result := FieldBynameValue(strSQL, 'typename',asString);
end;
function GetTemplate(const TemplateID: Integer): String;
begin
  strSQL := 'SELECT TemplName FROM tbltemplates  WHERE TemplID = ' +
    IntToStr(TemplateID);
  Result := FieldBynameValue(strSQL, 'TemplName');
end;

function GetTemplate(const TemplateName: String): Integer; overload;
begin
  strSQL := 'SELECT TemplID FROM tbltemplates  WHERE TemplName = ' +
    QuotedStr(TemplateName);
  Result := FieldBynameValue(strSQL, 'TemplID', asInteger);
end;

function GetSimpleType(const typeID: Integer): String;
begin
  strSQL := 'SELECT Name FROM tblSimpleTypes  WHERE ID = ' + IntToStr(typeID);
  Result := FieldBynameValue(strSQL, 'Name');
End;

function GetSimpleType(const typeName: String; const TypeCode: String; CreateifnotExists :Boolean = False): Integer;
begin
  strSQL := 'SELECT Id FROM tblSimpleTypes  WHERE TypeCode = ' +
    QuotedStr(TypeCode) + ' and Name = ' + QuotedStr(typeName);
  Result := FieldBynameValue(strSQL, 'ID', asInteger, true);
  if result =0 then begin
    ExecuteSQL( 'INSERT INTO tblsimpletypes (TypeCode, Name) VALUES ('+ quotedstr(TypeCode) +', '+ quotedstr(typeName)+')');
    Result := FieldBynameValue(strSQL, 'ID', asInteger);
  end;
end;

// function GetSimpleTypeDefault(const TypeCode: string): Integer;
// begin
// strSQL:='SELECT Id FROM tblSimpleTypes  WHERE TypeCode = ' + QuotedStr(TypeCode) +
// ' and (Active = ''T'') and (IsDefault = ''T'')';
// Result :=FieldBynameValue(strSQL ,'ID', asInteger);
// end;
Function Repairmanufacure(const RepairNo: Integer): Integer;
begin
  strSQL := 'select  ManufactureID from tblrepairdetails where RepairID = ' +
    IntToStr(RepairNo);
  Result := FieldBynameValue(strSQL, 'ManufactureID', asInteger);
end;

Function RepairNotes(RepairID: Integer): String;
begin
  strSQL := 'SELECT Notes from tblRepairs where repairId = ' +
    IntToStr(RepairID);
  Result := FieldBynameValue(strSQL, 'Notes', AsString);
end;

function GetSimpleTypeDefaultStr(const TypeCode: string): string;
begin
  strSQL := 'SELECT Name FROM tblSimpleTypes  WHERE TypeCode = ' +
    QuotedStr(TypeCode) + ' and (Active = ''T'') and (IsDefault = ''T'')';
  Result := FieldBynameValue(strSQL, 'Name', AsString);
end;

// function getrepairGlobalref(const RepairID:Integer):String;
// begin
// strSQL:='SELECT GlobalRef FROM tblRepairs WHERE RepairID = ' + IntToStr(RepairID);
// Result :=FieldBynameValue(strSQL ,'GlobalRef');
// End;
//
// function getrepairID(const GlobalRef :String):Integer;
// begin
// strSQL:='SELECT RepairID FROM tblRepairs WHERE  GlobalRef= ' + QuotedSTr(GlobalRef);
// Result :=FieldBynameValue(strSQL ,'RepairID', asInteger);
// End;

function ProductColsExists(const ColValue: STring;
  const colNo: Integer): Boolean;
var
  fiPArtsId: Integer;
begin
  if colNo = 1 then
    strSQL := 'SELECT partsID   FROM  tblparts ' + ' WHERE char_length(' +
      firstcolumn('tblparts') + ')<>0 ' + ' AND ' + firstcolumn('tblparts') +
      ' =' + QuotedStr(ColValue)
  else if colNo = 2 then
    strSQL := 'SELECT   partsID FROM tblparts' + ' WHERE char_length(' +
      Secondcolumn('tblparts') + ')<>0 ' + ' AND ' + Secondcolumn('tblparts') +
      ' =' + QuotedStr(ColValue)
  else if colNo = 3 then
    strSQL := 'SELECT partsID FROM tblparts ' + ' WHERE char_length(' +
      Thirdcolumn('tblparts') + ')<>0 ' + ' AND ' + Thirdcolumn('tblparts') +
      ' =' + QuotedStr(ColValue);
  fiPArtsId := FieldBynameValue(strSQL, 'partsID', asInteger);
  Result := fiPArtsId <> 0;
End;

Function getFormulaId(const formulaName: String): Integer;
begin
  { same function used to search on formula name and formula - assuming that the formula of 1 line cannot be the name of another line }
  strSQL := 'Select FormulaID from tblFEFormula ' + 'where FormulaName = ' +
    QuotedStr(formulaName) + ' or  Formula = ' + QuotedStr(formulaName);
  Result := FieldBynameValue(strSQL, 'FormulaID', asInteger);
end;

Function getFormula(const FormulaID: Integer): String;
begin
  strSQL := 'Select FormulaID , Formula from tblFEFormula where FormulaID = ' +
    IntToStr(FormulaID);
  Result := FieldBynameValue(strSQL, 'Formula');
end;
Function getDescribeFormula(const FormulaID: Integer): String;
begin
  strSQL := 'Select FormulaID , DescribeFormula(Formula) as Formula from tblFEFormula where FormulaID = ' +
    IntToStr(FormulaID);
  Result := FieldBynameValue(strSQL, 'Formula');
end;
Function getFormulaName(const FormulaID: Integer): String;
begin
  strSQL := 'Select FormulaID , FormulaName from tblFEFormula where FormulaID = ' +
    IntToStr(FormulaID);
  Result := FieldBynameValue(strSQL, 'FormulaName');
end;

Function getServiceID(const ServiceName: STring): Integer;
begin
  strSQL := 'SELECT ServiceID FROM tblServices where servicedesc = ' +
    QuotedStr(ServiceName);
  Result := FieldBynameValue(strSQL, 'ServiceID', asInteger);
end;

Function getEquipmentIdforProduct(const ProductID: Integer; Serialnumber :String): Integer;
begin
  strSQL := 'SELECT EquipmentID FROM tblequipment where ProductId = ' +
    IntToStr(ProductID);
  if Serialnumber <> '' then StrSQL := StrSQL +' and SerialNumber =' +Quotedstr(SerialNumber);
  Result := FieldBynameValue(strSQL, 'EquipmentID', asInteger);
end;

Function getEquipmentId(const EquipmentName: STring): Integer;
begin
  strSQL := 'SELECT EquipmentID FROM tblequipment where EquipmentName = ' +
    QuotedStr(EquipmentName);
  Result := FieldBynameValue(strSQL, 'EquipmentID', asInteger);
end;

Function getEquipmentName(const EquipmentID: Integer): String;
begin
  strSQL := 'SELECT EquipmentName FROM tblequipment where EquipmentID = ' +
    IntToStr(EquipmentID);
  Result := FieldBynameValue(strSQL, 'EquipmentName');
end;
Function getEquipmentSerialnumber(const EquipmentID: Integer): String;
begin
  strSQL := 'SELECT Serialnumber FROM tblequipment where EquipmentID = ' +
    IntToStr(EquipmentID);
  Result := FieldBynameValue(strSQL, 'Serialnumber');
end;
Function ManufacturedateFormat(Const RepairNo: Integer): String;
begin
  strSQL := 'Select 1 as Category, REC.DateFormat ' +
    ' From tblrepairdetails RD ' +
    ' inner join tblRepairsExportconfig REC on REC.ManufactureId = RD.ManufactureID  '
    + ' where RD.repairId = ' + IntToStr(RepairNo) + ' union all ' +
    ' Select 2 category, Dateformat from `tblRepairsExportconfig` where id = 1 '
    + ' order by category ';
  Result := FieldBynameValue(strSQL, 'DateFormat', AsString);
end;

Function getManufactureId(const ManufactureName: STring): Integer;
begin
  strSQL := 'SELECT ID FROM tblManufacture where Name = ' +
    QuotedStr(ManufactureName);
  Result := FieldBynameValue(strSQL, 'ID', asInteger);
end;

Function getManufactureName(const ManufactureID: Integer): String;
begin
  strSQL := 'SELECT Name FROM tblManufacture where ID = ' +
    IntToStr(ManufactureID);
  Result := FieldBynameValue(strSQL, 'Name');
end;

Function getGlobalref(const Tablename, IDFieldName: STring; const ID: Integer;
  const GlobalrefFieldName: String = 'Globalref'): String;
begin
  Result := '';
  if (GlobalrefFieldName <> '') and (Tablename <> '') and (IDFieldName <> '')
    and (ID <> 0) then
  begin
    strSQL := 'SELECT ' + GlobalrefFieldName + ' FROM ' + Tablename + ' Where '
      + IDFieldName + ' = ' + IntToStr(ID);
    Result := FieldBynameValue(strSQL, GlobalrefFieldName);
  End;
end;

Function GetId(const GlobalRef: String; const IDFieldName: String;
  const Tablename: STring): Integer;
begin
  strSQL := 'select ' + IDFieldName + '  from ' + Tablename +
    ' where  globalref= ' + QuotedStr(GlobalRef);
  Result := FieldBynameValue(strSQL, IDFieldName, asInteger);
end;

Function getAssessmentLabelId(Const labels: String): Integer;
Begin
  strSQL := 'SELECT Labelid FROM tblassessmentlabels  WHERE Label = ' +
    QuotedStr(labels);
  Result := FieldBynameValue(strSQL, 'Labelid', asInteger);
end;

Function getAssessmentDriverid(Const Driver: String;
  Const clientID: Integer): Integer;
Begin
  strSQL := 'SELECT ContactID FROM tblContacts WHERE ClientID = ' +
    IntToStr(clientID) +
    ' AND CONCAT_WS(" ",tblContacts.ContactFirstName,tblContacts.ContactSurName) = '
    + QuotedStr(Driver);
  Result := FieldBynameValue(strSQL, 'ContactID', asInteger);
end;

Function getAssessmentDriver(Const DriverId, clientID: Integer): String;
Begin
  strSQL := 'SELECT ContactID,CONCAT_WS(" ",tblContacts.ContactFirstName,tblContacts.ContactSurName) as Name FROM tblContacts WHERE ClientID = '
    + IntToStr(clientID) + ' AND ContactID=' + IntToStr(DriverId);
  Result := FieldBynameValue(strSQL, 'Name', AsString);
end;

Function getAssessmentAssessorid(Const Assessor: String): Integer;
Begin
  strSQL := 'SELECT EmployeeID FROM tblEmployees  WHERE EmployeeName = ' +
    QuotedStr(Assessor);
  Result := FieldBynameValue(strSQL, 'EmployeeID', asInteger);
end;

Function getAssessmentTypeid(Const AssessmentType: String): Integer;
Begin
  strSQL := 'SELECT TypeID FROM tblassessmenttypes WHERE TypeName = ' +
    QuotedStr(AssessmentType);
  Result := FieldBynameValue(strSQL, 'TypeID', asInteger);
end;

function getPOSFunctionID(Const POSFunctionName: String): Integer;
Begin
  strSQL := 'SELECT FunctionID FROM tblPOSFunctions WHERE FunctionName = ' +
    QuotedStr(POSFunctionName);
  Result := FieldBynameValue(strSQL, 'FunctionID', asInteger);
end;

function getPOSKeyPadID(Const POSKeyPadName: String): Integer;
Begin
  strSQL := 'SELECT KeyPadID FROM tblPOSKeyPads WHERE Description = ' +
    QuotedStr(POSKeyPadName);
  Result := FieldBynameValue(strSQL, 'KeyPadID', asInteger);
end;

function getFuncRoomName(Const FuncRoomID: Integer): String;
Begin
  strSQL := 'SELECT Name from tblFuncRooms where RoomId =' +
    IntToStr(FuncRoomID);
  Result := FieldBynameValue(strSQL, 'Name', AsString);
end;

function getFuncRoomID(Const FuncRoomName: String): Integer;
Begin
  strSQL := 'SELECT RoomID FROM tblFuncRooms WHERE Name = ' +
    QuotedStr(FuncRoomName);
  Result := FieldBynameValue(strSQL, 'RoomID', asInteger);
end;

function getCurrentProcStep(const OrderLineID: Integer): Integer;
begin
  strSQL := 'SELECT CurrentProcStep FROM tblOrderLines WHERE ID = ' +
    IntToStr(OrderLineID);
  Result := FieldBynameValue(strSQL, 'CurrentProcStep', asInteger);
end;

function GetTillClassID(const iTillID: Integer): Integer;
begin
  strSQL := 'SELECT ClassID FROM tblPOSTills WHERE TillID = ' +
    IntToStr(iTillID);
  Result := FieldBynameValue(strSQL, 'ClassID', asInteger);
  if (Result = 0) then
    Result := AppEnv.DefaultClass.classid;
end;

function GetTillClassName(const iTillID: Integer): string;
begin
  strSQL := 'SELECT tblClass.ClassName FROM tblClass, tblPOSTills ' +
    ' WHERE tblPOSTills.ClassID = tblClass.ClassID ' +
    'AND tblPOSTills.TillID = ' + IntToStr(iTillID);
  Result := FieldBynameValue(strSQL, 'ClassName', AsString);
  if (Result = '') then
    Result := AppEnv.DefaultClass.DefaultClassName;
end;

function getformID(Const fFormName: String): Integer;
begin
  strSQL := 'select formid from tblforms where formname = ' +
    QuotedStr(fFormName);
  Result := FieldBynameValue(strSQL, 'formid', asInteger);
end;

function getformName(Const fFormID:Integer): String;
begin
  strSQL := 'select formname from tblforms where  formid  = ' +
    inttostr(fFormID);
  Result := FieldBynameValue(strSQL, 'formname', asString);
end;

function GetPrimaryPad(const iTillID: Integer): Integer;
begin
  strSQL := 'SELECT PrimaryPadID FROM tblPOSTills WHERE TillID = ' +
    IntToStr(iTillID);
  Result := FieldBynameValue(strSQL, 'PrimaryPadID', asInteger);
End;

(*function getLastChequeno(const AccountID: Integer): Integer;
begin
  strSQL := ' SELECT Max(TRUNCATE(InvoiceNumber,0)) as ChequeLastNumber   ' +
    ' FROM tblpurchaseorders WHERE IsCheque="T"  ' + ' AND AccountID=' +
    IntToStr(AccountID);
  Result := FieldBynameValue(strSQL, 'ChequeLastNumber', asInteger);
end;*)

(*function getLastSuppPayChequeno(const AccountID: Integer): Integer;
begin
  strSQL := ' SELECT Max(TRUNCATE(ReferenceNo,0)) as ChequeLastNumber  ' +
    ' FROM tblwithdrawal WHERE AccountID=' + IntToStr(AccountID);
  Result := FieldBynameValue(strSQL, 'ChequeLastNumber', asInteger);
End;*)

Function ClientParentID(Const clientID: Integer): Integer;
begin
  strSQL := 'Select MasterclientID from tblrelatedclients where  childclientId =  '
    + IntToStr(clientID);
  Result := FieldBynameValue(strSQL, 'MasterclientID', asInteger);
end;

Function IsclientRelatedParent(Const clientID: Integer): Boolean;
begin
  strSQL := 'Select MasterclientID from tblrelatedclients where  MasterclientID =  '
    + IntToStr(clientID);
  Result := FieldBynameValue(strSQL, 'MasterclientID', asInteger) <> 0;
end;

Function IsclientRelated(Const clientID: Integer): Boolean;
begin
  strSQL := 'Select childclientId from tblrelatedclients where  childclientId = '
    + IntToStr(clientID);
  Result := FieldBynameValue(strSQL, 'childclientId', asInteger) <> 0;
end;

function GetALLRelatedClientIDs(const ParentClientID: Integer): string;
var
  Qry:TERPQuery;
begin
  Result := IntToStr(ParentClientID);
  if ParentClientID = 0 then
    Exit;

  strSQL := 'SELECT ClientID FROM tblClients ' +
    ' WHERE ifnull(ParentRelatedClientID,0) = ' + IntToStr(ParentClientID);

  //with Datautilsdataset(strSQL) do begin
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
      if Qry.active then Qry.Close;
      Qry.SQL.Text :=strSQL;
      Qry.open;
      if Qry.recordcount = 0 then Exit;
      Qry.First;
      While Qry.eof = False do begin
        Result := Result + ',' + IntToStr(Qry.fieldByname('ClientID').asInteger);
        Qry.Next;
      end;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
end;

function LeadActionEmail: Integer;
begin
  Result := GetSimpleType('Email', SimpleTypes_LeadActionType);
end;

function LeadActionAppointment: Integer;
begin
  Result := GetSimpleType('Appointment', SimpleTypes_LeadActionType);
end;

function LeadActionFollowup: Integer;
begin
  Result := GetSimpleType('Follow-up', SimpleTypes_LeadActionType);
end;

function LeadActionInvoice: Integer;
begin
  Result := GetSimpleType('Invoice', SimpleTypes_LeadActionType);
end;

function LeadActionSalesOrder: Integer;
begin
  Result := GetSimpleType('SalesOrder', SimpleTypes_LeadActionType);
end;

function LeadActionQuote: Integer;
begin
  Result := GetSimpleType('Quote', SimpleTypes_LeadActionType);
end;
function LeadActionToDo: Integer;
begin
  Result := GetSimpleType('ToDo', SimpleTypes_LeadActionType);
end;

function LeadActionLead: Integer;
begin
  Result := GetSimpleType('Lead', SimpleTypes_LeadActionType);
end;

function FollowUpResultAppointment: Integer;
begin
  Result := GetSimpleType('Appointment', SimpleTypes_FollowUpResultType);
end;

function DashBoardPreference: String;
begin
  strSQL := 'SELECT   PrefValue from tblPreferences Where PrefName = "TDashBoard" and IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId);
  Result := FieldBynameValue(strSQL, 'PrefValue', AsString);
end;

function GetAccessLevelsFormID(const FormName: string): Integer;
begin
  strSQL := 'SELECT FormID FROM `tblforms`  WHERE `AccessLevels` = "T" ' +
    ' AND (FormName =' + QuotedStr(FormName) + ') ' +
    ' OR (BusinessObjectName = ' + QuotedStr(FormName) + ');';
  Result := FieldBynameValue(strSQL, 'FormID', asInteger);
end;

Function getPOOriginalno(Const PurchaseOrderID: Integer): String;
begin
  strSQL := 'SELECT Originalno FROM tblpurchaseorders WHERE PurchaseOrderID = '
    + IntToStr(PurchaseOrderID) + ';';
  Result := FieldBynameValue(strSQL, 'Originalno', AsString);
end;
function getSalesOriginalnoForRef(Const globalref:String):String;
begin
  strSQL := 'SELECT Originalno FROM tblsales WHERE Globalref = ' +
    Quotedstr(globalref) + ';';
  Result := FieldBynameValue(strSQL, 'Originalno', AsString);

end;
Function getSalesIDsofgroup(Const saleID: Integer; excludethissale:Boolean =False): String;
var
  Originalno :String;
  Qry:TERPQuery;
begin
  Originalno :=getSalesOriginalno(SaleID);
  if Originalno = '' then exit;
  strSQL := 'SELECT SaleId  FROM tblsales WHERE Originalno = ' +    Quotedstr(Originalno) ;
  if excludethissale then strSQL := strSQL +' and SaleID <> ' + inttostr(saleID);
  //with Datautilsdataset(strSQL) do  begin
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
      if Qry.active then Qry.Close;
      Qry.SQL.Text :=strSQL;
      Qry.open;
      result := Qry.groupconcat('SaleId');
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
end;

Function getSalesOriginalno(Const saleID: Integer): String;
begin
  strSQL := 'SELECT Originalno FROM tblsales WHERE saleID = ' +
    IntToStr(saleID) + ';';
  Result := FieldBynameValue(strSQL, 'Originalno', AsString);
end;

function clientemail(Const clientID: Integer): String;
begin
  strSQL := 'Select ifnull(Email,"") as Email from tblclients where clientId = '
    + IntToStr(clientID);
  Result := FieldBynameValue(strSQL, 'Email', AsString);
end;

function GetRangeSelectionID(const sRangeDescription: string): Integer;
begin
  strSQL := 'SELECT RangeSelectionID,RangeDescription FROM `tblMarketingrangeselection`  WHERE `RangeDescription` = '
    + QuotedStr(sRangeDescription) + ';';
  Result := FieldBynameValue(strSQL, 'RangeSelectionID', asInteger);
end;

function getpayrateID(Const payratetypeName: String): Integer;
begin
  strSQL := 'SELECT RateID FROM tblPayRates WHERE Description = ' +
    QuotedStr(payratetypeName);
  Result := FieldBynameValue(strSQL, 'RateID', asInteger);
end;

function GetPayRateTypeID(const sRateType: string): Integer;
begin
  strSQL := 'SELECT TypeID FROM tblPayRateType WHERE Description = ' +
    QuotedStr(sRateType);
  Result := FieldBynameValue(strSQL, 'TypeID', asInteger);
end;

Function GetMarketingcontactIdforclient(const clientID: Integer): Integer;
begin
  strSQL := 'SELECT MC.ID FROM tblmarketingcontacts AS MC   ' +
    ' where  MC.ClientID = ' + IntToStr(clientID);
  Result := FieldBynameValue(strSQL, 'ID', asInteger);
end;
Function getMarketingcontactName(const MCID: Integer): String;
begin
  strSQL := 'SELECT Company FROM tblmarketingcontacts AS MC   ' +
    ' where  MC.ID = ' + IntToStr(MCID);
  Result := FieldBynameValue(strSQL, 'Company', AsString);
end;
Function MarketingContactID(const MarketingContactName :String):Integer;
begin
  strSQL := 'Select ID from  tblmarketingcontacts where company = ' + quotedstr(MarketingContactName);
  Result := FieldBynameValue(strSQL, 'ID', asInteger);
end;
Procedure MarketingContactDetails(const clientID: Integer; var MCID: Integer;  var IsLead: Boolean; var LeadID: Integer);
var
  Qry:TERPQuery;
begin
  strSQL := 'SELECT ML.MarketingContactID, ML.IsLead, ML.LeadID ' +
    ' FROM tblmarketingleads AS ML where ML.ClientID=' + IntToStr(clientID);
  //with Datautilsdataset(strSQL) do begin
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
      if Qry.active then Qry.Close;
      Qry.SQL.Text :=strSQL;
      Qry.open;
      if Qry.recordcount <> 0 then begin
        IsLead := Qry.fieldByname('IsLead').asBoolean;
        MCID := Qry.fieldByname('MarketingContactID').asInteger;
        LeadID := Qry.fieldByname('LeadID').asInteger;
        Exit;
      end;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
end;

function HasMailMergeHostDetails: Boolean;
var
  qry: TERPQuery;
begin
  Result := True;
  qry := CommonDBLib.TempMyQuery;
  try
    qry.SQL.Clear;
    qry.SQL.Text := 'SELECT * FROM tblmailmergehost';
    qry.Open;
    if qry.fieldByname('EmailAddress').AsString = '' then
      Result := False;
    if qry.fieldByname('SMTPHost').AsString = '' then
      Result := False;
    if qry.fieldByname('FromContact').AsString = '' then
      Result := False;
    if qry.fieldByname('SMTPPort').asInteger < 1 then
      Result := False;
    if qry.fieldByname('MaxAttachment').asFloat < 1 then
      Result := False;
  finally
    qry.Free;
  end;
end;

function GetRecipientName(MailMergeGroup: string; RecipientID: Integer): String;
var
  qry: TERPQuery;
begin
  qry := CommonDBLib.TempMyQuery;
  try
    qry.SQL.Clear;
    if SameText(MailMergeGroup, 'Employees') then
    begin
      qry.SQL.add
        ('SELECT EmployeeName,EmployeeID FROM tblemployees WHERE EmployeeID = '
        + IntToStr(RecipientID));
      qry.Open;
      Result := qry.fieldByname('EmployeeName').AsString;
    end
    else if SameText(MailMergeGroup, 'Marketing') then
    begin
      qry.SQL.add('SELECT Company FROM tblmarketingcontacts WHERE Id= ' +
        IntToStr(RecipientID));
      qry.Open;
      Result := qry.fieldByname('Company').AsString;
    end
    else if (SameText(MailMergeGroup, 'Suppliers')) or
      (SameText(MailMergeGroup, 'Customers')) or
      (SameText(MailMergeGroup, 'OtherContacts')) or
      (SameText(MailMergeGroup, 'Loyalty')) or
      (SameText(MailMergeGroup, 'Shippingcontainer')) then
    begin
      qry.SQL.add('SELECT Company FROM tblclients WHERE ClientID = ' +
        IntToStr(RecipientID));
      qry.Open;
      Result := qry.fieldByname('Company').AsString;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetClientIDforSale(const saleID: Integer): Integer;
begin
  strSQL := 'Select clientID from tblSales where SaleId = ' + IntToStr(saleID);
  Result := FieldBynameValue(strSQL, 'ClientID', asInteger);
end;
function GetClassIDforSale(const saleID: Integer): Integer;
begin
  strSQL := 'Select ClassID from tblSales where SaleId = ' + IntToStr(saleID);
  Result := FieldBynameValue(strSQL, 'ClassID', asInteger);
end;
function GetSaleIdForSaleLineId(const aSaleLineId: Integer): Integer;
var
  qry: TERPQuery;
begin
  qry := CommonDBLib.TempMyQuery;
  try
    qry.SQL.Text := 'select SaleId from tblSalesLines where SaleLineId = ' +
      IntToStr(aSaleLineId);
    qry.Open;
    Result := qry.fieldByname('SaleId').asInteger;
  finally
    qry.Free;
  end;
end;

function SalesCommissionbatchUpdateBy: String;
var
  strSQL: String;
begin
  strSQL := 'select ' +
    ' concat_ws(" " , `E`.`FirstName`,`E`.`MiddleName`,`E`.`LastName`) as EmployeeName  '
    + ' from tblsalescommissionupdates SC ' +
    ' inner join tblEmployees e on E.employeeId = SC.EmployeeId ' +
    ' Order by CommissionCalculatedOn desc Limit 1';
  Result := FieldBynameValue(strSQL, 'EmployeeName', AsString);
end;

function SalesCommissionbatchUpdateDetails: String;
var
  strSQL: String;
begin
  strSQL := 'select  SC.CommissionCalculatedOn ,' +
    ' concat_ws(" " , `E`.`FirstName`,`E`.`MiddleName`,`E`.`LastName`) as EmployeeName  '
    + ' from tblsalescommissionupdates SC ' +
    ' inner join tblEmployees e on E.employeeId = SC.EmployeeId ' +
    ' Order by CommissionCalculatedOn desc Limit 1';
  With TempMyQuery do
    try
      SQL.add(strSQL);
      Open;
      Result := 'Sales Commission Last Updated on ' +
        fieldByname('CommissionCalculatedOn').AsString + ' by ' +
        fieldByname('EmployeeName').AsString;
    finally
      if Active then
        close;
      Free;
    end;
end;

Function SalesCommenabled: Boolean;
begin
  Result := ((AppEnv.CompanyPrefs.UseSalesCommission) and
    ((AppEnv.CompanyPrefs.SalesCommissionCalcInProgress = False) or
    (AppEnv.CompanyPrefs.SalesCommissionCalcEmployeeID = AppEnv.Employee.EmployeeID)));
end;

Function ClienttypeName(const clientID: Integer): String;
var
  ct:TtClienttype;
begin
  ct:= Clienttype(clientID);
  if ct = ttcustomer then result := 'Customer'
  else if ct = ttJob then result := 'Job'
  else if ct = ttSupplier then result := 'Supplier'
  else if ct = ttOthercontact then result := 'Other Contact'
  else result := '';

end;
function Clienttype(const clientID: Integer): TtClienttype;
var
  Qry:TERPQuery;
begin
  Result := ttnone;
  (*with Datautilsdataset
    ('SELECT Customer,Supplier,OtherContact,IsJob from tblClients Where clientId = '
    + IntToStr(clientID)) do begin*)
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
      if Qry.active then Qry.Close;
      Qry.SQL.Text :='SELECT Customer,Supplier,OtherContact,IsJob from tblClients Where clientId = ' + IntToStr(clientID);
      Qry.open;
           if Qry.fieldByname('Customer').asBoolean     then Result := ttcustomer
      else if Qry.fieldByname('IsJob').asBoolean        then Result := ttJob
      else if Qry.fieldByname('Supplier').asBoolean     then Result := ttSupplier
      else if Qry.fieldByname('OtherContact').asBoolean then Result := ttOthercontact;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
end;

function AvailableRewardPoints(Const CustomerID: Integer;
  const SaleDate: TDateTime; fconnection: TCustomMyconnection = nil): Double;
begin
  strSQL := 'SELECT Sum(ifnull(SP.LinePoints,0)- ' +
    'ifnull((Select Sum(ifnull(SRP.UsedPoints,0)) from  tblsalesredeempoints AS SRP where  SRP.SalesLinesPointsId = SP.SalesLinesPointsId ),0)'
    + ')  AS Points  ' + ' FROM tblsaleslinespoints AS SP ' +
    ' Left join tblSales s on s.SaleID = SP.SaleId' + ' where SP.active = "T" '
    + ' and SP.clientId = ' + IntToStr(CustomerID) +
    ' and ((ifnull(PointExpiresOn,0) = 0 or PointExpiresOn  >= ' +
    QuotedStr(formatDateTime(MysqlDateFormat, SaleDate)) + '))' +
    ' and ((ifnull(ExpiresOnNoOfMonthsAfterPurchase,0) = 0) or ( Date_add(S.SaleDate , Interval   ExpiresOnNoOfMonthsAfterPurchase MONTH) >= '
    + QuotedStr(formatDateTime(MysqlDateFormat, SaleDate)) + ') )';
  With CommonDBLib.TempMyQuery do
    try
      if fconnection <> nil then
        Connection := fconnection;
      SQL.add(strSQL);
      Open;
      Result := fieldByname('Points').asFloat;
    finally
      if Active then
        close;
      Free;
    end;
end;

function PO_Type(POID: Integer): String;
var
  Qry:TERPQuery;
begin
  (*with Datautilsdataset
    ('SELECT PO.IsPO, PO.IsRA, PO.IsBill, PO.IsCredit, PO.IsCheque, PO.IsPOCredit  '
    + ' from tblpurchaseorders PO   ' + ' where PO.PurchaseOrderID =' +
    IntToStr(POID)) do begin*)
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
      if Qry.active then Qry.Close;
      Qry.SQL.Text :='SELECT PO.IsPO, PO.IsRA, PO.IsBill, PO.IsCredit, PO.IsCheque, PO.IsPOCredit from tblpurchaseorders PO   ' + ' where PO.PurchaseOrderID =' +IntToStr(POID);
      Qry.open;
           if Qry.fieldByname('IsPO').asBoolean       then Result := tcConst.POType
      else if Qry.fieldByname('IsPOCredit').asBoolean then Result := 'PO Credit'
      else if Qry.fieldByname('IsRA').asBoolean       then Result := tcConst.RAType
      else if Qry.fieldByname('IsBill').asBoolean     then Result := tcConst.Billtype
      else if Qry.fieldByname('IsCredit').asBoolean   then Result := tcConst.CreditType
      else if Qry.fieldByname('IsCheque').asBoolean   then Result := tcConst.ChequeType
      else Result := 'Unknown'
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
end;
function SalesGlobalref(saleID: Integer): String;
begin
  strSQL:= 'Select Globalref from tblsales where saleId = ' + inttostr(saleID);
  Result := FieldBynameValue(strSQL, 'Globalref', AsString);
end;
function SaleType(Globalref :String): String;Overload;
var
  Qry:TERPQuery;
begin
  REsult := '';
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
      if Qry.active then Qry.Close;
      Qry.SQL.Text :='SELECT S.IsPOS,S.POS,S.IsRefund,S.IsCashSale,S.IsInvoice,S.IsQuote,S.IsSalesOrder,S.IsVoucher,S.IsLayby,S.IsLaybyTOS,S.IsLaybyPayment from tblSales S Where Globalref = '+ Quotedstr(Globalref);
      Qry.open;
           if Qry.fieldByname('IsPOS').asBoolean              then Result := 'POS'
      else if Qry.fieldByname('POS').asBoolean                then Result := 'POS'
      else if Qry.fieldByname('IsRefund').asBoolean           then Result := tcConst.RefundType
      else if Qry.fieldByname('IsCashSale').asBoolean         then Result := 'Cash Sale'
      else if Qry.fieldByname('IsInvoice').asBoolean          then Result := tcConst.InvType
      else if Qry.fieldByname('IsQuote').asBoolean            then Result := 'Quote'
      else if Qry.fieldByname('IsSalesOrder').asBoolean       then Result := 'Sales Order'
      else if Qry.fieldByname('IsVoucher').asBoolean          then Result := 'Voucher'
      else if Qry.fieldByname('IsLayby').asBoolean            then Result := 'Layby'
      else if Qry.fieldByname('IsLaybyTOS').asBoolean         then Result := 'Layby'
      else if Qry.fieldByname('IsLaybyPayment').asBoolean then Result := 'Layby'
      else Result := 'Unknown';
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

function SaleType(saleID: Integer): String;
var
  Qry:TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
      if Qry.active then Qry.Close;
      Qry.SQL.Text :='SELECT S.IsPOS,S.POS,S.IsRefund,S.IsCashSale,S.IsInvoice,S.IsQuote,S.IsSalesOrder,S.IsVoucher,S.IsLayby,S.IsLaybyTOS,S.IsLaybyPayment from tblSales S Where SaleID = '+ IntToStr(saleID);
      Qry.open;
           if Qry.fieldByname('IsPOS').asBoolean              then Result := 'POS'
      else if Qry.fieldByname('POS').asBoolean                then Result := 'POS'
      else if Qry.fieldByname('IsRefund').asBoolean           then Result := tcConst.RefundType
      else if Qry.fieldByname('IsCashSale').asBoolean         then Result := 'Cash Sale'
      else if Qry.fieldByname('IsInvoice').asBoolean          then Result := tcConst.InvType
      else if Qry.fieldByname('IsQuote').asBoolean            then Result := 'Quote'
      else if Qry.fieldByname('IsSalesOrder').asBoolean       then Result := 'Sales Order'
      else if Qry.fieldByname('IsVoucher').asBoolean          then Result := 'Voucher'
      else if Qry.fieldByname('IsLayby').asBoolean            then Result := 'Layby'
      else if Qry.fieldByname('IsLaybyTOS').asBoolean         then Result := 'Layby'
      else if Qry.fieldByname('IsLaybyPaymentfrom').asBoolean then Result := 'Layby'
      else Result := 'Unknown';
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

function SaleIDFromTrans(Const TransId: Integer): Integer;
begin
  strSQL := 'SELECT SaleId  FROM  tbltransactions WHERE transId = ' +
    IntToStr(TransId);
  Result := FieldBynameValue(strSQL, 'SaleID', asInteger);
end;

function TimesheetEntryID(const SaleLineID: Integer): Integer;
begin
  strSQL := 'Select TimeSheetEntryId from tbltimesheetentry ' +
    ' where type = "Manufacture"  ' + ' and TypeID = ' + IntToStr(SaleLineID);
  Result := FieldBynameValue(strSQL, 'TimeSheetEntryId', asInteger);
end;

Function GetTrainingModuleID(Modulename: String): Integer;
begin
  strSQL := 'Select TrainingModuleId from tbltrainingmodules where trainingmodulename ='
    + QuotedStr(Modulename);
  Result := FieldBynameValue(strSQL, 'TrainingModuleId', asInteger);
end;

Function getPassword(Const User: string): String;
begin
  strSQL := 'SELECT Logon_Password' + ' FROM  tblPassword p ' +
    ' WHERE Logon_Name =  ' + QuotedStr(User);
  Result := DeCrypt(FieldBynameValue(strSQL, 'Logon_Password', AsString), 'z');
end;

(*function FristTransDate: TDateTime;
begin
  strSQL := 'Select min(Date) as date from tbltransactionsummarydetails ' +
    ' union ALL ' +
    ' Select min(Date) as date from tbltransactions ' +  // WHERE TYPE <> "Initialise Summary" ' Removed to speed up query
    ' order by DATE';
  Result := FieldBynameValue(strSQL, 'date', asDateTime);
end;*)

function Clientcontactcount(const ClietnID: Integer): Integer;
begin
  strSQL := 'Select count(*) ctr from tblContacts where ClientId = ' +
    IntToStr(ClietnID);
  Result := FieldBynameValue(strSQL, 'ctr', asInteger);
end;

function ClientPhoneSupport(const ClietnID: Integer): TDateTime;
begin
  strSQL := 'Select PhoneSupportTill from tblclients where ClientID= ' +
    IntToStr(ClietnID);
  Result := FieldBynameValue(strSQL, 'PhoneSupportTill', asDateTime);
end;

function ClientdefaultContactMethod(const ClietnID: Integer): String;
begin
  strSQL := 'select defaultContactMethod from tblclients where clientID= ' +
    IntToStr(ClietnID);
  Result := FieldBynameValue(strSQL, 'defaultContactMethod', AsString);
end;

function CheckTemplateExists(const ReportName: string): Boolean;
begin
  strSQL := 'SELECT TemplID FROM tblTemplates ' + ' WHERE TemplName = ' +
    QuotedStr(trim(ReportName)) + ' OR TemplateClass = ' +
    QuotedStr(trim(ReportName));
  Result := FieldBynameValue(strSQL, 'TemplID', asInteger) <> 0;
end;

function FieldExists(Tablename, fieldname: String): Boolean;
var
  Qry:TERPQuery;
begin
  strSQL := 'Desc ' + Tablename;
  //with Datautilsdataset(strSQL) do begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
      if Qry.active then Qry.Close;
      Qry.SQL.Text :=strSQL;
      Qry.open;
      Result := Qry.Locate('Field', fieldname, []);
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

Function ActiveTables: String;
var
  Qry:TERPQuery;
begin
  Result := '';
  try
    strSQL := 'select ' + 'concat( ' +
      '"Class: " , ifnull(classname   ,""),", " , ' +
      '"User: "  , ifnull(UserName    ,""),", " , ' +
      '"Table: " , ifnull(DatasetName ,""),", " , ' +
      '"ID: "    , ifnull(KeyId       ,0) ,", " , ' +
      '"Group: " , ifnull(groupname   ,""),", " , ' +
      '"Since: " , ifnull(timeEntered ,0) )  ' + 'details from tblinuse order by username , timeEntered';
    //with Datautilsdataset(strSQL) do begin
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
        if Qry.active then Qry.Close;
        Qry.SQL.Text :=strSQL;
        Qry.open;
        Result := Qry.Groupconcat('Details', '', False, #13#10);
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
  except
    //
  end;
end;

Function Activeforms: String;
var
  Qry:TERPQuery;
begin
  Result := '';
  try
    strSQL := 'select concat( ' +
      '"Class: " , ifnull(classname   ,"") , ", " ,  ' +
      '"User: "  , ifnull(UserName    ,"") ,", " , ' +
      '"ID: "    , ifnull(KeyId       ,0)     ,", " , ' +
      '"Since: " , ifnull(timeEntered ,0)    )  ' +
      'details from tblinuseforms order by username , timeEntered';
    //with Datautilsdataset(strSQL) do begin
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
        if Qry.active then Qry.Close;
        Qry.SQL.Text :=strSQL;
        Qry.open;
        Result := Qry.Groupconcat('Details', '', False,#13#10 );
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
  except
     //
  end;
end;

function GetEmployeeAccessLevel(const FormName: string; const UserName :String ): integer;
begin
(*strSQL:= 'SELECT tblEmployeeFormsAccess.Access ' +
                  ' FROM tblEmployeeFormsAccess, tblForms ' +
                  ' WHERE tblEmployeeFormsAccess.FormId = tblForms.FormId ' +
                  ' AND tblEmployeeFormsAccess.EmployeeID = '+ inttostr(EmployeeID)  +' AND tblForms.FormName = '+Quotedstr(FormName);*)
  strSQL:= 'SELECT tblEmployeeFormsAccess.Access ' +
                  ' FROM tblEmployeeFormsAccess inner join  tblForms   on tblEmployeeFormsAccess.FormId = tblForms.FormId ' +
                  ' inner join tblpassword on tblpassword.EmployeeId = tblEmployeeFormsAccess.EmployeeID ' +
                  ' WHERE ' +
                  ' tblpassword.Logon_Name = '+Quotedstr(  UserName)+
                  ' AND tblForms.FormName = '+Quotedstr(  FormName);
  Result := FieldBynameValue(strSQL, 'Access', asInteger);
end;
function GetClientEmail(const ThisClientID: integer; OnlyIfPreferedMethod: boolean = false): string;
begin
    strSQL:= 'SELECT Email,ClientID FROM tblClients WHERE ClientID =' + IntToStr(ThisClientID);
    if OnlyIfPreferedMethod then strSQL:= strSQL+' and DefaultContactMethod = "Email"';
    Result := FieldBynameValue(strSQL, 'Email',asString);
end;
function Producttypename(Const typecode:String):String;
begin
  strSQL := 'Select     typedesc from tblparttypes where typecode = ' +Quotedstr(typecode);
  Result := FieldBynameValue(strSQL, 'typedesc',asString);

end;
function Producthasformula(Const ProductID:Integer):Boolean;
begin
  Result := False;
  if not Appenv.CompanyPrefs.PartCalcfieldVisible then exit;
  StrSQL:= 'Select PartCalcformula from tblparts where PartsID = ' +inttostr(ProductID);
  Result := Trim(FieldBynameValue(strSQL, 'PartCalcformula',asString)) <> '';
end;
Function ProductHasAllocation(const ProductId :Integer; fconnection: TCustomMyconnection = nil):Boolean;
var
  s:String;
begin
  s:= 'Select pqad.* from ' +
      ' tblpqa pqa inner join tblpqadetails pqad on pqa.pqaid = pqad.pqaid' +
      ' where pqa.ProductID =' +inttostr(ProductId) + ' limit 1';
  With CommonDBLib.TempMyQuery do try
      if fconnection <> nil then  Connection := fconnection;
      SQL.Add(s);
      open;
      REsult := recordcount >0 ;
  finally
      if active then close;
      Free;
  end;
end;
function LastReturnSummariseDate(tablename:String): TDateTime;
begin
  With  TempMyQuery do try
    Sql.add('select SummarisedTransDate SummarisedTransDate from ' + tablename+' where active ="T" and Id = ' + inttostr(LastReturnID(tablename)));
    Open;
    Result:= fieldByname('SummarisedTransDate').AsDateTime;
  finally
    closenFree;
  end;
end;
function LastReturnID(tablename:String):Integer;
begin
  With  TempMyQuery do try
    Sql.add('select max(ID) ID from ' + tablename+' where active ="T"');
    Open;
    Result:= fieldByname('ID').AsInteger;
  finally
    closenFree;
  end;
end;

function TemplateTypeID(Const TemplTypename:String): integer;
begin
    StrSQL:= 'SELECT  TypeID FROM  tbltemplatetype where TypeName = ' +quotedstr(TemplTypename);
    Result := FieldBynameValue(strSQL, 'TypeID',asInteger);
end;
function TemplateTypeName(Const TypeID:Integer): String;
begin
    StrSQL:= 'SELECT  TypeName FROM  tbltemplatetype where  TypeID= ' +inttostr(TypeID);
    Result := FieldBynameValue(strSQL, 'TypeName',asString);
end;
function Defaultchart(const Listclass:String):string;
begin
  strSQL := 'select chartname from tblcustomcharts where reportClassname = '+ Quotedstr(Listclass) +' and defaultchart = "T"';
  Result := FieldBynameValue(strSQL, 'chartname',asString);
end;
function ProfitnLossDefaultchart:string;
begin
  REsult:= Defaultchart('TProfitnLosschartGUI');
end;

function Formhascomments(aFormID:Integer):Boolean;
begin
  strSQL:='Select count(*) ctr from TblFromcommnets where formid = ' + inttostr(aFormID);
  Result := FieldBynameValue(strSQL, 'ctr',asInteger) > 0;
end;

function ServiceStandardRate(const ServiceName:String):Double;
begin
  strSQL:='Select standardRate from tblservices where ServiceDesc = ' + Quotedstr(ServiceName);
  Result := FieldBynameValue(strSQL, 'standardRate',asFloat) ;
end;
function AppointmentDate(const apptID:Integer):TdateTime;
begin
  strSQL:='Select AppDate from tblappointments where AppointID =  ' + inttostr(apptID);
  Result := FieldBynameValue(strSQL, 'AppDate',asDateTime) ;
end;
function AppointmentclientId(const apptID:Integer):Integer;
begin
  strSQL:='Select cusid from tblappointments where AppointID =  ' + inttostr(apptID);
  Result := FieldBynameValue(strSQL, 'cusid',asInteger) ;
end;
Function ClientcontactEmailID(Const ClientID :Integer; Contacttype : tClientcontacttype; UsePrimarywhenBlank:Boolean = true; USeclientswhenBlank :Boolean = True):String;
var
  Qry:TERPQuery;
begin
    REsult := '';
    strSQL:= 'Select '+
            ' C.Email as ClientEmail, '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and ISPrimarycontact 				 = "T" limit 1) as EmailforPrimaryContact    , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforCashSale   = "T" limit 1) as ContactEmailforCashSale   , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforVoucher    = "T" limit 1) as ContactEmailforVoucher    , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforPOS        = "T" limit 1) as ContactEmailforPOS        , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforRefund     = "T" limit 1) as ContactEmailforRefund     , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforInvoice    = "T" limit 1) as ContactEmailforInvoice    , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforSalesOrder = "T" limit 1) as ContactEmailforSalesOrder , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforStatements = "T" limit 1) as ContactEmailforStatements , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforQuote      = "T" limit 1) as ContactEmailforQuote      , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforCheque     = "T" limit 1) as ContactEmailforCheque     , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforCredit     = "T" limit 1) as ContactEmailforCredit     , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforBill       = "T" limit 1) as ContactEmailforBill       , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforPO         = "T" limit 1) as ContactEmailforPO         , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforRA         = "T" limit 1) as ContactEmailforRA         , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforRepair     = "T" limit 1) as ContactEmailforRepair     , '+
            ' (Select ContactEmail from tblcontacts where clientId = C.clientId and MainContactforSupplierPayment = "T" limit 1) as ContactEmailforSupplierPayment  '+
            ' From tblclients C '+
            ' Where C.clientID =  ' +inttostr(ClientID);
    //with Datautilsdataset(strSQL) do try
    Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
    try
        if Qry.active then Qry.Close;
        Qry.SQL.Text :=strSQL;
        Qry.open;
            if Contacttype =  ctMainContactforCashSale    then result := Qry.Fieldbyname('ContactEmailforCashSale').asString
      else  if Contacttype =  ctMainContactforVoucher     then result := Qry.Fieldbyname('ContactEmailforVoucher').asString
      else  if Contacttype =  ctMainContactforPOS         then result := Qry.Fieldbyname('ContactEmailforPOS').asString
      else  if Contacttype =  ctMainContactforRefund      then result := Qry.Fieldbyname('ContactEmailforRefund').asString
      else  if Contacttype =  ctMainContactforInvoice     then result := Qry.Fieldbyname('ContactEmailforInvoice').asString
      else  if Contacttype =  ctMainContactforSalesOrder  then result := Qry.Fieldbyname('ContactEmailforSalesOrder').asString
      else  if Contacttype =  ctMainContactforStatements  then result := Qry.Fieldbyname('ContactEmailforStatements').asString
      else  if Contacttype =  ctMainContactforQuote       then result := Qry.Fieldbyname('ContactEmailforQuote').asString
      else  if Contacttype =  ctMainContactforCheque      then result := Qry.Fieldbyname('ContactEmailforCheque').asString
      else  if Contacttype =  ctMainContactforCredit      then result := Qry.Fieldbyname('ContactEmailforCredit').asString
      else  if Contacttype =  ctMainContactforBill        then result := Qry.Fieldbyname('ContactEmailforBill').asString
      else  if Contacttype =  ctMainContactforPO          then result := Qry.Fieldbyname('ContactEmailforPO').asString
      else  if Contacttype =  ctMainContactforRA          then result := Qry.Fieldbyname('ContactEmailforRA').asString
      else  if Contacttype =  ctMainContactforRepair      then result := Qry.Fieldbyname('ContactEmailforRepair').asString
      else  if Contacttype =  ctMainContactforSupplierPAyment then result := Qry.Fieldbyname('ContactEmailforSupplierPayment').asString;
      if result= '' then if  UsePrimarywhenBlank then Result := Qry.Fieldbyname('EmailforPrimaryContact').asString;
      if result= '' then if  USeclientswhenBlank then Result := Qry.Fieldbyname('ClientEmail').asString;
    finally
      DbSharedObj.ReleaseObj(Qry);
    end;
end;
function ClientEmail(ClientID, contactID:Integer):String;
begin
  strSQL:='Select ContactEmail from tblcontacts where contactID =  ' + inttostr(contactId);
  Result := FieldBynameValue(strSQL, 'ContactEmail',asString) ;
  if result = '' then result := clientemail(ClientID);
end;
function ClientName(ClientID, contactID:Integer):String;
begin
  strSQL:='Select Company , concat(contactTitle , " " , contactFirstName , " " , contactSurName) as ContactName from tblcontacts where contactID =  ' + inttostr(contactId);
  Result := FieldBynameValue(strSQL, 'Company',asString) ;
  if result = '' then Result := FieldBynameValue(strSQL, 'contactFirstName',asString) ;
  if result = '' then result := getClientName(ClientID);
end;
function ClientFax(ClientID, contactID:Integer):String;
begin
  strSQL:='Select contactFax from tblcontacts where contactID =  ' + inttostr(contactId);
  Result := FieldBynameValue(strSQL, 'contactFax',asString) ;
  if result = '' then result := GetClientFaxNumber(ClientID);
end;
Function HasObjectProperties(ObjClassname:String):boolean;
begin
  strSQL:='Select count(*) as Ctr from tblobjectproperties where ObjClassname =  ' + quotedstr(ObjClassname);
  Result := FieldBynameValue(strSQL, 'Ctr',asInteger) >0;
end;
function ClientAddress(ClientID, contactID:Integer; Resulttype:Integer):String;
var
  Qry:TERPQuery;
begin
  strSQL := '      select ' +
            '  ifnull(C.Company 				, CL.Company	) as Company, ' +
            '  ifnull(C.contactTitle 		, CL.Title		) as ContactTitle, ' +
            '  ifnull(C.contactFirstName, CL.FirstName) as ContactFirstName, ' +
            '  ifnull(C.contactSurName 	, CL.LastName	) as ContactSurname, ' +
            '  ifnull(C.contactAddress 	, CL.Street		) as ContactAddress, ' +
            '  ifnull(C.contactAddress2 , CL.Street2	) as ContactAddress2, ' +
            '  ifnull(C.contactAddress3 , CL.Street3	) as ContactAddress3, ' +
            '  ifnull(C.contactCity 		, CL.Suburb		) as ContactCity, ' +
            '  ifnull(C.contactState 		, CL.State		) as ContactState, ' +
            '  ifnull(C.contactPcode 		, CL.PostCode	) as ContactPCode, ' +
            '  ifnull(C.contactFax 			, CL.FaxNumber) as ContactFax ' +
            '  from tblclients CL left join tblcontacts C on C.clientID = CL.clientID  and C.contactID = ' + inttostr(contactID) +' where CL.clientID = ' +inttostr(ClientID);
  Result:= '';
  //with Datautilsdataset(strSQL) do begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
        if Qry.active then Qry.Close;
        Qry.SQL.Text :=strSQL;
        Qry.open;
    if resulttype = 1 then begin
                  if Qry.fieldbyname('ContactAddress').AsString   <> '' then REsult  := Qry.fieldbyname('ContactAddress').AsString + ' ';
                  if Qry.fieldbyname('ContactAddress2').AsString  <> '' then REsult  := REsult  + Qry.fieldbyname('ContactAddress2').AsString  + ' ';
                  if Qry.fieldbyname('ContactAddress3').AsString  <> '' then REsult  := REsult  + Qry.fieldbyname('ContactAddress3').AsString ;
    end else if resulttype = 2 then begin
                  if Qry.fieldbyname('ContactCity').AsString   <> '' then REsult  := Qry.fieldbyname('ContactCity').AsString + ' ';
                  if Qry.fieldbyname('ContactState').AsString  <> '' then REsult  := REsult  + Qry.fieldbyname('ContactState').AsString  + ' ';
                  if Qry.fieldbyname('ContactPCode').AsString  <> '' then REsult  := REsult  + Qry.fieldbyname('ContactPCode').AsString ;
    end else if resulttype = 3 then begin
                  if Qry.fieldbyname('ContactTitle').AsString   <> '' then REsult  := Qry.fieldbyname('ContactTitle').AsString + ' ';

    end;
  finally
      DbSharedObj.ReleaseObj(Qry);
  end;
end;

procedure IterateselectedRecords(grd:TWWDBGrid; DoProc:TNotifyEvent);
var
  i: integer;
begin
    if grd.SelectedList.Count > 0 then begin
      for i := 0 to grd.SelectedList.Count - 1 do begin
        grd.Datasource.Dataset.GoToBookmark(grd.SelectedList.Items[i]);
        DoProc(grd);
      end;
    end;
end;

function GetLastSequenceNumber(const SeqName: string): string;
begin
    strSQL:= 'Select SeqValue from tblseqnumbers where Seqname = ' + quotedstr(SeqName);
    Result := FieldBynameValue(strSQL, 'SeqValue',asString);
end;
function GetNextSequenceNumber(const SeqName: string): string;
begin
  result:=GetLastSequenceNumber(SeqName);
  if result = '' then result := '0';
  try
    result := inttostr(strtoInt(trim(result))+1);
  Except
  end;
end;
function AdjustType(const AdjusmentID: Integer): string;
begin
  StrSQL:= 'Select Adjusttype from tblstockadjustentry where StockAdjustEntryID = ' + inttostr(AdjusmentID);
  Result := FieldBynameValue(strSQL, 'Adjusttype',asString);
end;

function TransferType(const AdjusmentID: Integer): string;
begin
  StrSQL:= 'Select TransferType from tblstocktransferentry where TransferEntryID = ' + inttostr(AdjusmentID);
  Result := FieldBynameValue(strSQL, 'TransferType',asString);
end;
function LeadID(const Companyname:String): Integer;
begin
  StrSQL:= 'Select LeadID from tblmarketingleads where company = '+Quotedstr(Companyname);
  Result := FieldBynameValue(strSQL, 'LeadID',asInteger);
end;
function getEmployeeEmail(const EmployeeID:Integer):String;
begin
  StrSQL:= 'select email from tblemployees where employeeId =  '+inttostr(EmployeeID);
  Result := FieldBynameValue(strSQL, 'email',asString);
end;
function getEmployeeEmail(const EmployeeName:String):String;
begin
  StrSQL:= 'select email from tblemployees where employeeId =  '+inttostr(getemployeeID(EmployeeName));
  Result := FieldBynameValue(strSQL, 'email',asString);
end;
Function getContactID(const contactName:String): Integer;
Begin
  strSQL := 'SELECT ContactID FROM tblContacts WHERE concat_WS(" " , Contacttitle, contactfirstname, contactsurname)= '    + QuotedStr(contactName);
  Result := FieldBynameValue(strSQL, 'ContactID', asInteger);
end;
Function getContactName(const contactID:Integer): String;
Begin
  strSQL := 'SELECT concat_WS(" " , Contacttitle, contactfirstname, contactsurname) as Name FROM tblContacts WHERE ContactID= '    + inttostr(contactID);
  Result := FieldBynameValue(strSQL, 'Name', asString);
end;
Function getaxScaleID(const ScaleName:String): Integer;
Begin
  strSQL := 'Select scaleId from tbltaxscales where ScaleDescription = ' +quotedstr(ScaleName);
  Result := FieldBynameValue(strSQL, 'scaleId', asInteger);
end;
Function getEmpServiceID(const ServiceName:String;employeeID:Integer): Integer;
Begin
  strSQL := 'Select ID from tblpaysemployeeservices where Servicename = ' + Quotedstr(Servicename) +' and employeeId = ' + inttostr(EmployeeID);
  Result := FieldBynameValue(strSQL, 'ID', asInteger);
end;

Function getEmpServicename(const EmpServiceID :Integer): String;
Begin
  strSQL := 'Select Servicename from tblpaysemployeeservices where  ID = ' + inttostr(EmpServiceID) ;
  Result := FieldBynameValue(strSQL, 'Servicename', asString);
end;
function GetVehicleID(const VehicleName: string): integer;
begin
  strSQL := 'SELECT VehicleID FROM tblManifestVehicles WHERE VehicleName = ' + quotedStr(VehicleName) ;
  Result := FieldBynameValue(strSQL, 'VehicleID', asInteger);
end;
function CountryISDCode(const Countryname: string): String;
begin
  strSQL := 'Select Callingcode from tblcountries where country = ' + quotedStr(Countryname) ;
  try
    Result := FieldBynameValue(strSQL, 'Callingcode', asString);
  Except
    Result:= '';
  end;
end;
Function uomweight(const uomid:Integer):double;
begin
  strSQL:= 'Select weight from tblunitsofmeasure where UnitID =' + inttostr(uomid);
  Result := FieldBynameValue(strSQL, 'weight', asFloat);
end;

Function SalesProductPartiallyShipped(Const SalesLineID:Integer):Boolean;
begin
  strSQL := 'select count(*) ctr from tblsalesorderinvoicelines SOIL where SOIL.SalesOrderLineID = ' + inttostr(SalesLineID) ;
  Result := FieldBynameValue(strSQL, 'ctr', asInteger) <> 0;
end;
Function ContactClientID(const ContactID:Integer):Integer;
begin
  strSQL := 'Select clientID from tblcontacts where contactId = ' + inttostr( ContactID);
  Result := FieldBynameValue(strSQL, 'clientID', asInteger) ;
end;
function ClientXMLEmail(const ThisClientID: integer): string;
begin
    strSQL := 'SELECT EmailXML  FROM tblClients WHERE ClientID =' + IntToStr(ThisClientID) ;
    Result := FieldBynameValue(strSQL, 'EmailXML', AsString) ;
end;
function ClientPOXMLEmail(const ThisClientID: integer): string;
begin
    strSQL := 'SELECT EmailPOXML FROM tblClients WHERE ClientID =' + IntToStr(ThisClientID) ;
    Result := FieldBynameValue(strSQL, 'EmailPOXML', AsString) ;
end;
Function StockAdjustImportDataMapID:Integer;
begin
  result := ImportDataMapIDFortype('Stock Adjustment');
end;
Function ImportDataMapIDFortype(const aTypeName:String):Integer;
begin
    strSQL := 'SELECT ImportDataMapID FROM tblImportDataMap WHERE  typename =' +Quotedstr( aTypeName);
    Result := FieldBynameValue(strSQL, 'ImportDataMapID', asInteger) ;
end;
Function BOMListImportDataMapID:Integer;
begin
    strSQL := 'SELECT ImportDataMapID FROM tblImportDataMap WHERE  typename =' +Quotedstr( 'BOM List');
    Result := FieldBynameValue(strSQL, 'ImportDataMapID', asInteger) ;
end;
Function ERPVideoImportDataMapID:Integer;
begin
    strSQL := 'SELECT ImportDataMapID FROM tblImportDataMap WHERE  typename =' +Quotedstr( 'ERP videos');
    Result := FieldBynameValue(strSQL, 'ImportDataMapID', asInteger) ;
end;
function ReminderHideDays(const EmployeeID:Integer):Integer;
begin
    strSQL := 'SELECT ReminderHideDays FROM tblpersonalpreferences WHERE EmployeeID = ' +inttostr(EmployeeID);
    Result := FieldBynameValue(strSQL, 'ReminderHideDays', asInteger) ;
end;
Function CurrencyDecimalPlaces(Const Curcode:String):Integer;
begin
    strSQL := 'Select R.region , c.code , DecimalPlaces  from tblregionaloptions R inner join  tblcurrencyconversion C on R.ForeignExDefault = C.Code and R.countryId = C.CountryID where C.Code ='+ quotedstr(Curcode);
    Result := FieldBynameValue(strSQL, 'DecimalPlaces', asInteger) ;
    if REsult =0 then result := 2; // default is 2 if region not exitss for the currency code
end;
Function InhouseClientID:Integer;
begin
  StrSQL := 'Select ClientId from tblclients where IsInternal ="T" and Company =' +quotedstr(Appenv.companyinfo.companyName);
  Result := FieldBynameValue(strSQL, 'ClientId', asInteger) ;
end;
Function InhouseClientName:String;
begin
  StrSQL := 'Select Company from tblclients where IsInternal ="T" and Company =' +quotedstr(Appenv.companyinfo.companyName);
  Result := FieldBynameValue(strSQL, 'Company', asString) ;
end;

(*Function Clienttype(const clientID:Inbteger):String;
begin
  strSQL := 'SELECT Customer, supplier, Othercontact FROM tblclients WHERE clientId =' + inttostr(clientID);
  with Datautilsdataset(fSQL) do  begin
         if Fieldbyname('Customer').asBoolean     then result := 'Customer'
    else if Fieldbyname('supplier').asBoolean     then result := 'Supplier'
    else if Fieldbyname('Othercontact').asBoolean then result := 'Prospect';

  End;
end;*)


Function LanguageName(Const LanguageID:Integer):String;
var
  qry :TERPQuery;
begin
 Qry := TempMyQuery;
 try
  Qry.Connection := GetNewERPLanguageConnection(Qry);
  Qry.SQL.Text :='select Language from languages where Id  = ' + inttostr(LanguageID);
  Qry.Open;
  Result:= Qry.fieldByname('Language').asString;
 finally
  if Qry.Active then Qry.close;
  Qry.connection.Free;
  Freeandnil(Qry);
 end;
end;

function GetDefaultReport(const TemplateTypeID: integer): string;
begin
    result := TemplateReportsTypeLib.GetDefaultReport(TemplateTypeID);
end;

function GetDefaultReport(const TemplateTypeName: String): String;
begin
  result := TemplateReportsTypeLib.GetDefaultReport(TemplateTypeName);
end;
function IsHoliday(const dt: TDateTime): Boolean;
begin
  strSQL := 'SELECT ID FROM tblpublicholidays WHERE Day = '+ FormatDateTime(MysqlDateFormat, dt);
  Result :=  FieldBynameValue(strSQL, 'ID', asInteger ) <> 0;
end;
function ImageSchemeLargeIconsDLLName: String;
begin
  strSQL := 'SELECT LargeIconsDLLName FROM tblimageschemes WHERE active ="T" and Name = '+ Quotedstr(Appenv.Employee.ImageScheme);
  Result :=  FieldBynameValue(strSQL, 'LargeIconsDLLName', asString );
end;

function ImageSchemeSmallIconsDLLName: String;
begin
  strSQL := 'SELECT SmallIconsDLLName FROM tblimageschemes WHERE active ="T" and Name = '+ Quotedstr(Appenv.Employee.ImageScheme);
  Result :=  FieldBynameValue(strSQL, 'SmallIconsDLLName', asString );
end;

function ImageSchemeNames : TStringList;
var
  qry :TERPQuery;
begin
  Result := TStringList.Create;
  qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    if qry.Active then Qry.Close;
    qry.SQL.Text := 'SELECT ID, Name FROM tblimageschemes';
    Qry.Open;
    while not qry.Eof do
    begin
      Result.AddObject(qry.Fields[1].asString, pointer(qry.Fields[0].asinteger));
      qry.Next;
    end;
    qry.Close;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
Function EmployeeIdforUserName(UserName:String):Integer;
begin
    result := 0;
  if UserName = '' then exit;

  strSQL := 'SELECT Emp.EmployeeID ' +
            'FROM tblEmployees as Emp LEFT JOIN tblPassword ' +
            'ON Emp.EmployeeID = tblPassword.EmployeeID ' +
            'WHERE Logon_name = ' + quotedstr(UserName) + ' AND Active = "T"';
  Result :=  FieldBynameValue(strSQL, 'EmployeeID', asInteger);
end;

Function EmployeeIdforPassWord(Password:String; PasswordEncrypted:Boolean):Integer;
begin
  result := 0;
  if Password = '' then exit;

  if not PasswordEncrypted then Password := Encrypt(Password  , 'z');
  strSQL := 'SELECT Emp.EmployeeID ' +
            'FROM tblEmployees as Emp LEFT JOIN tblPassword ' +
            'ON Emp.EmployeeID = tblPassword.EmployeeID ' +
            'WHERE Logon_Password = ' + quotedstr(Password) + ' AND Active = "T"';
  Result :=  FieldBynameValue(strSQL, 'EmployeeID', asInteger);
end;

function TillA4templateID(const fiTillID: Integer): String;
begin
    strSQL:= 'Select T.TemplName from tblpostills  PT inner join tbltemplates T on PT.DefaultA4TemplateID = T.TemplID where Pt.TillID = ' + inttostr(fitillid);
    Result :=  FieldBynameValue(strSQL, 'TemplName', asString);
end;
function IsHireProduct(Const ProductID:Integer):Boolean;
begin
    strSQL:= 'Select E.ProductID FROM tblequipment E  inner join tblParts P on E.ProductID = P.partsId WHERE E.OnHire ="T" and  E.active ="T" and P.partsId =  ' + inttostr(ProductId);
    Result :=  FieldBynameValue(strSQL, 'ProductID', asInteger) <> 0;
end;
function HireProductPartID:Integer;
begin
    strSQL:= 'select PartsId from tblparts where partname =  ' + Quotedstr(PART_HIRE);
    Result :=  FieldBynameValue(strSQL, 'PartsId', asInteger) ;
end;
function Durationdesc(const Durationtype:String):String;
begin
       if Durationtype = 'Y' then result := 'Year(s)'
  else if Durationtype = 'M' then result := 'Month(s)'
  else if Durationtype = 'W' then result := 'Week(s)'
  else if Durationtype = 'D' then result := 'Day(s)'
  else if Durationtype = 'H' then result := 'Hour(s)'
  else result := '';
end;
Function HireDurationWorkflowID     :Integer;begin  REsult := WorkflowID('Hire Duration')    ;end;
Function HireMakeProductWorkflowID  :Integer;begin  REsult := WorkflowID('Make Hire Product');end;
Function HireConvertProductToHireWorkflowID:Integer;begin  REsult := WorkflowID('Convert a Hire Product');end;
Function HireMakeHireWorkflowID     :Integer;begin  REsult := WorkflowID('Make a Hire')      ;end;

function NextUniqueValue(data: String;Tablename:String; fieldname:String; Subchar:String=''):String;
begin
  Result := '';
  if Subchar = '' then Subchar := 'x';
  While true do begin
    strSQL:= 'Select '+ fieldname +' from '+tablename +' Where '+ Fieldname +' = ' + Quotedstr(data);
    if FieldBynameValue(strSQL, fieldname, asString) = '' then begin
      Result := Data;
      Exit;
    end else begin
      Data := Data +Subchar;
    end;

  end;
end;
function Resourcerostered(const ResourceID:Integer):Boolean;
begin
  strSQL:= 'Select count(ID) as Ctr from tblempresprocschedule where active ="T" and ResourceID =' + inttostr(ResourceID);
  Result :=  FieldBynameValue(strSQL, 'Ctr', asInteger)>0;
end;
Function ProcResourceDetailsUsed(ProcResourceDetailID:Integer):Boolean;
begin
  strSQL:= 'Select count(*) as Ctr from tblempresprocschedule where active ="T" and ResourceDetailId =' + inttostr(ProcResourceDetailID);
  Result :=  FieldBynameValue(strSQL, 'Ctr', asInteger)>0;
  if result then exit;

  strSQL:= 'Select count(*) as Ctr from tblprocesstime where active ="T" and ResourcedetailsID =' + inttostr(ProcResourceDetailID);
  Result :=  FieldBynameValue(strSQL, 'Ctr', asInteger)>0;
end;
Function WorkflowID(const WorkflowDescription:String):Integer;
begin
    strSQL:= 'Select ID from tblworkflow where Description   =' + Quotedstr(WorkflowDescription);
    Result :=  FieldBynameValue(strSQL, 'ID', asInteger) ;
end;
Function ProcesstepResourceID(Const ProcessStepID:Integer):Integer;
begin
  strSQL:= 'Select ProcResourceId from tblprocresourceprocess where ProcessstepID=' + inttostr(ProcessStepID);
  Result :=  FieldBynameValue(strSQL, 'ProcResourceId', asInteger);
end;
Function Processtep(Const ProcessStepID:Integer):String;
begin
  strSQL:= 'select Description from tblprocessstep where Id = ' + inttostr(ProcessStepID);
  Result :=  FieldBynameValue(strSQL, 'Description', asString);
end;
Function SaleDetails(const SaleIDs:String):String;
begin
      strSQL:= 'Select Concat("SaleId " , SaleID , " for " , '''''''', customername, '''''''' ) details from tblsales where saleId in (' +SaleIDs+')';
      Result :=  FieldBynameValue(strSQL, 'details', asGroupconcat);
end;
Function FormatSeconds(const Seconds:Integer):String;
begin
      strSQL:= 'Select FormatSeconds(0,'+ inttostr(Seconds) +') as Seconds from dual';
      Result :=  FieldBynameValue(strSQL, 'Seconds', asString);
end;
function ProcResName(const ProcResID:Integer):String;
begin
      strSQL:= 'select ResourceName from tblprocresource where ProcResourceId = ' + inttostr(ProcResID);
  Result :=  FieldBynameValue(strSQL, 'ResourceName', asString);
end;
function ProcResID(const aProcResname:string):Integer;
begin
      strSQL:= 'select ProcResourceId from tblprocresource where ResourceName = ' + quotedstr(aProcResname);
  Result :=  FieldBynameValue(strSQL, 'ProcResourceId', asInteger);
end;

function ProcResDetName(const ProcResDetID:Integer):String;
begin
      strSQL:= 'select Description from tblprocresourcedetails where ID = ' + inttostr(ProcResDetID);
  Result :=  FieldBynameValue(strSQL, 'Description', asString);
end;
function GetProductFormula(const ProductID: Integer): String;
begin
  strSQL:= 'Select FE.FormulaName , FE.Formula '+
            ' from tblparts P inner join tblfeformula FE on P.FormulaID = FE.FormulaID '+
            ' Where P.partsId = ' + inttostr(ProductID);
  Result :=  FieldBynameValue(strSQL, 'Formula', asString);
end;
function GetProductFormulaName(const ProductID: Integer): String;
begin
  strSQL:= 'Select FE.FormulaName , FE.Formula '+
            ' from tblparts P inner join tblfeformula FE on P.FormulaID = FE.FormulaID '+
            ' Where P.partsId = ' + inttostr(ProductID);
  Result :=  FieldBynameValue(strSQL, 'FormulaName', asString);
end;
function GetProductFormulaID(const ProductID: Integer): Integer;
begin
  strSQL:= 'Select FE.FormulaID '+
            ' from tblparts P inner join tblfeformula FE on P.FormulaID = FE.FormulaID '+
            ' Where P.partsId = ' + inttostr(ProductID);
  Result :=  FieldBynameValue(strSQL, 'FormulaID', asInteger);
end;
function SalesLineRootNodeId(const SalesLineId:Integer):Integer;
begin
  strSQL := 'Select ProcTreeId from tblproctree AS PT  ' + ' where  MasterID = '
    + IntToStr(SalesLineId) +' and PT.MasterType <>  "mtProduct" AND PT.ParentId = 0';
  Result := FieldBynameValue(strSQL, 'ProcTreeId', asInteger);

end;
function IsSalesLineScheduled(const SalesLineId:Integer):Boolean;
begin
  strSQL := 'select  ' +
            ' Count(PCT.ProcessTimeId) as ctr ' +
            ' from tblsaleslines SL ' +
            ' inner join tblproctree PT on SL.saleLineID = PT.masterId and PT.MasterType ="mtSalesOrder" ' +
            ' inner join tblProcesspart PP on PT.proctreeId = PP.proctreeId ' +
            ' inner join tblprocesstime PCT on PCT.ProcessPartId = PP.id ' +
            ' Where SL.saleLineId = ' + inttostr(SalesLineId);
  Result := FieldBynameValue(strSQL, 'ctr', asInteger)>0;

end;
function ISINTernalOrder(const SaleID :Integer):Boolean;
begin
  strSQL := 'Select IsInternalOrder from tblsales Where saleId =' + inttostr(SaleID);
  Result := FieldBynameValue(strSQL, 'IsInternalOrder', asBoolean);
end;
function SaleIdForLine(const SaleLineID :Integer):Integer;
begin
  strSQL := 'Select saleId from tblsaleslines Where SaleLineID =' + inttostr(SaleLineID);
  Result := FieldBynameValue(strSQL, 'saleId', asInteger);
end;
function TreeRootIDofPP( PPID:Integer):Integer;
begin
  strSQL := 'Select PT.TreeRootId from tblprocesspart PP inner join tblproctree PT on PT.proctreeId = PP.proctreeId  and PP.ID = ' + inttostr(PPID);
  Result := FieldBynameValue(strSQL, 'TreeRootId', asInteger);
end;
function SaleLineIDofTree( PTPID:Integer):Integer;
begin
  strSQL := 'Select MasterID from tblproctree PT where  PT.proctreeId = ' + inttostr(PTPID);
  Result := FieldBynameValue(strSQL, 'MasterID', asInteger);
end;
function SaleIDofTree( PTPID:Integer):Integer;
begin
  strSQL := 'Select SL.saleId from tblproctree PT inner join tblsaleslines SL on PT.masterId = SL.saleLineId and PT.masterType <> "mtPropduct" where  PT.proctreeId = ' + inttostr(PTPID);
  Result := FieldBynameValue(strSQL, 'saleId', asInteger);
end;
function AnyProcessScheduled(SalesID:Integer): Boolean;
begin
  strSQL:= 'Select  PP.ID ' +
            ' from tblSaleslines SL ' +
            ' inner join tblprocTree PT on SL.SaleLineId	= PT.masterID and 	PT.Mastertype <> "mtProduct" ' +
            ' inner join tblProcessPart   PP on PP.ProcTreeId     = PT.ProcTreeId and (PP.timestart > "1899-12-30 00:00:00" or PP.timeend > "1899-12-30 00:00:00") ' +
            '  inner join tblProcessTime PCT on PCT.ProcessPartId = PP.ID         and not(PCT.timestart = "1899-12-30 00:00:00" and PCT.timeend = "1899-12-30 00:00:00" and PCT.duration =0) '+
            ' where SL.SaleId = ' +IntToStr(SalesID);
  Result := FieldBynameValue(strSQL, 'ID', asInteger)>0;
end;
function SaleslineScheduled(SaleslineID:Integer): Boolean;
begin
  strSQL:= 'Select  PP.ID ' +
            ' from tblSaleslines SL ' +
            ' inner join tblprocTree PT on SL.SaleLineId	= PT.masterID and 	PT.Mastertype <> "mtProduct" ' +
            ' inner join tblProcessPart PP on PP.ProcTreeId = PT.ProcTreeId and  ' +
                        ' (PP.timestart > "1899-12-30 00:00:00" or PP.timeend > "1899-12-30 00:00:00") ' +
            ' where SL.SaleLineID = ' +IntToStr(SaleslineID);
  Result := FieldBynameValue(strSQL, 'ID', asInteger)>0;
end;
function AutoRoundRelatedQty(const Qty:double; ParentProductId, ProductID:Integer):Double;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.sql.text := 'Select AutoRoundRelatedQty(' +floattostr(Qty)+','+Inttostr(ParentProductId)+','+Inttostr(ProductID)+') as Result';
    qry.open;
    Result := round(qry.Fieldbyname('Result').asFloat , tcConst.GeneralRoundPlaces);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

  (*result := qty;
  strsql := 'Select ZeroWhenLessthan1 , IsToRoundtoNextNumberinSales , IsToRoundtoPreviousNumberinSales , ParentQty, qty, extraQty '+
                    ' from tblrelatedparts where ParentID = ' + inttostr( ParentProductID) +'  and ProductID = ' + inttostr(ProductID);
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection, strSQL);
  try

    with Qry do begin
      try
        if (fieldbyname('Qty').AsFloat = 0) or (fieldbyname('ParentQty').AsFloat=0) then result := 0
        else result := result * (fieldbyname('Qty').AsFloat / fieldbyname('ParentQty').AsFloat);
      Except
          On E:Exception do begin
            if fieldbyname('Qty').AsFloat <> 0 then result := result * fieldbyname('Qty').AsFloat
            else result := 0;
          end;
      end;

      if fieldbyname('ZeroWhenLessthan1').AsBoolean and (result <1 ) then result:= 0
      else if FieldByname('IsToRoundtoNextNumberinSales').AsBoolean then begin
        if trunc(result) < result then result := trunc(result) +1;
      end else if FieldByname('IsToRoundtoPreviousNumberinSales').AsBoolean then begin
        if trunc(result) < result then result := trunc(result) ;
      end;
      if fieldbyname('extraQty').asFloat >0 then
        REsult := result + fieldbyname('extraQty').asFloat;
    end;
  finally
      DbSharedObj.ReleaseObj(Qry);
  end;*)
end;

Function RefundChequeID (Const RefundGlobalref:String):Integer;
begin
//  result := 0;
  strSQL:= 'Select PurchaseOrderId from tblPurchaseOrders where ifnull(Refundglobalref, "") =' +Quotedstr(RefundGlobalref);
  Result := FieldBynameValue(strSQL, 'PurchaseOrderId', asInteger);
end;

Function NextNum( const Tablename :String; Const fieldname :String):Integer;
begin
  StrSQL := 'Select max('+fieldname+') as Num from ' + Tablename;
  Result := FieldBynameValue(strSQL, 'Num', asInteger)+1;
end;
function CsahCustomerMedtypeId :Integer;
begin
  StrSQL := 'select  MedTypeID  from tblclients where company ="Cash Customer"';
  Result := FieldBynameValue(strSQL, 'MedTypeID', asInteger);
end;
Function SaleIDofLine(const SaleLineID:Integer):Integer;
begin
  StrSQL := 'select  SaleId from tblsaleslines where saleLineId = ' + inttostr(saleLineID);
  Result := FieldBynameValue(strSQL, 'SaleId', asInteger);
end;
Function ProcessStepID( ProcessStep:STring):Integer;
begin
  StrSQL := 'Select ID from tblprocessstep where Description =' + Quotedstr(ProcessStep);
  Result := FieldBynameValue(strSQL, 'ID', asInteger);
end;
function jobIds(const ClientID:Integer):String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.sql.text := 'Select clientId from tblclients where ifnull(ParentClientId ,0) = ' + inttostr(clientID) +' or ClientId  = ' + inttostr(clientID) ;
    Qry.open;
    Result := Qry.groupconcat('clientId');
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
function AllIds(const fsql:String; fieldname:String; fConnection: TCustomMyconnection = nil):String;
var
  QRy:TERPQuery;
begin
  result := '';
  if fConnection = nil then fConnection := CommonDBLib.GetSharedMyDacConnection;
  Qry := DbSharedObj.GetQuery(fConnection);
  try
    if Qry.Active then Qry.Close;
    Qry.SQL.Text := fSQL;
    Qry.Open;
    if qry.findfield(fieldname) = nil then exit;
      Result := Qry.groupconcat(fieldname);
    finally
      //if CloseDS then if Active then close;
      DbSharedObj.ReleaseObj(Qry);
    end;

end;
function VideoID(PageCaption , videotype:String):Integer;
begin
  strSQL:=' Select ID       from erpdocumentaion.tblvideos where PageCaption=' +quotedstr(PageCaption) +' and VideoType =' +quotedstr(VideoType);
  Result := FieldBynameValue(strSQL, 'ID', asInteger);
end;
function VideoFilename(PageCaption , videotype:String):String;
begin
  strSQL:=' Select FileName from erpdocumentaion.tblvideos where PageCaption=' +quotedstr(PageCaption) +' and VideoType =' +quotedstr(VideoType);
  Result := FieldBynameValue(strSQL, 'FileName', asString);
end;
Function Videofilename(TrainingvidoeID:Integer):String;
begin
  strSQL:=' Select FileName from erpdocumentaion.tblvideos where ID=' +inttostr(TrainingvidoeID);
  Result := FieldBynameValue(strSQL, 'FileName', asString);
end;

function hasCashDropsforPeriod(iPeriodID:Integer):Boolean;
begin
  strSQL:=' Select count(*) ctr from tblcashdrop where EOP_ID = ' + inttostr(iPeriodID);
  Result := FieldBynameValue(strSQL, 'ctr', asInteger) >0;
end;
function EmployeeIdforLogonName(logonname:String):Integer;
begin
  strSQL:=' select E.EmployeeID , E.EmployeeName from tblpassword P inner join tblemployees E on P.EmployeeId = E.EmployeeID where logon_name ='+  Quotedstr(logonname);
  Result := FieldBynameValue(strSQL, 'EmployeeID', AsInteger) ;
end;
function SalesSmartOrderID(const SalesAutoSmartOrderRef:String):Integer;
begin
  result := 0;
  if trim(SalesAutoSmartOrderRef) ='' then exit;
  strSQL:='select SmartOrderID from tblsmartorder where GlobalRef = ' + QuotedStr(SalesAutoSmartOrderRef);
  Result := FieldBynameValue(strSQL, 'SmartOrderID', AsInteger) ;
end;
function SaleIdForSmartOrder(const SmartorDerREf:String):Integer;
begin
  result := 0;
  if trim(SmartorDerREf) ='' then exit;
  strSQL:='select SaleId from  tblSales where AutoSmartOrderRef = ' + QuotedStr(SmartorDerREf);
  Result := FieldBynameValue(strSQL, 'SaleId', AsInteger) ;
end;
function SaleIdForSmartOrder(const SmartOderID:Integer ):Integer;
begin
  result := 0;
  if SmartOderID =0 then exit;
  strSQL:='select SaleId  from  tblSales S inner join tblsmartorder SO on ifnull(S.AutoSmartOrderRef ,"") = SO.globalref where SO.SmartOrderID = '+ inttostr(SmartOderID);
  Result := FieldBynameValue(strSQL, 'SaleId', AsInteger) ;
end;

function GetContactEmailsList(const AClientId : integer; const aFieldName : string) : TStringList;
var
  qry: TERPQuery;
  lSet : ERPSets.TIntegerSet;
  s: string;
begin

  lSet := TIntegerSet.Create;
  try
    Result := TStringList.Create;
    Result.CaseSensitive := false;
    Result.Sorted := true;
    Result.Duplicates := dupIgnore;
    Result.OwnsObjects := false;
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      qry.Sql.Add('SELECT ContactId, Company, ContactEmail from tblContacts where ' + aFieldName + '="T"  and clientId = ' + inttostr(aClientID));
      qry.Active := true;
      while not qry.Eof do
      begin
        if (Result.Count = 0) or not (lSet.Exists(qry.Fields[0].asInteger)) then
        begin
          Result.AddObject(qry.Fields[1].asString + ' <'+qry.Fields[2].asString+'>', Pointer(qry.Fields[0].asInteger));
        end;
        qry.Next;
      end;

      if Result.Count > 0 then
        exit;

      // not found - check for the primary contact
      qry.Close;
      qry.SQL.Text := 'select ContactId, ContactEmail, FirstName, LastName from tblContacts where IsPrimaryContact="T"   and clientId = ' + inttostr(aClientID);
      qry.Open;

      if not qry.Eof and (qry.Fields[1].AsString <> '') then
      begin
        s := qry.FieldByName('FirstName').AsString;
        if qry.FieldByName('LastName').AsString <> '' then begin
          if s <> '' then s := s + ' ';
          s := s + qry.FieldByName('LastName').AsString;
        end;
        Result.AddObject(s + ' <' + qry.Fields[1].asString + '>', Pointer(qry.Fields[0].asInteger));
        exit;
      end;

    // look for ANY contact with e-mail
      qry.Close;
      qry.SQL.Text := 'select ContactId, Company, ContactEmail from tblContacts where ContactEmail is not null and ContactEmail <> ""   and clientId = ' + inttostr(aClientID);
      qry.Open;
      if not qry.Eof and (qry.Fields[1].AsString <> '') then
      begin
        Result.AddObject(qry.Fields[1].asString + ' <'+qry.Fields[2].asString+'>', Pointer(qry.Fields[0].asInteger));
      end;
    finally// Free our used objects.
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  finally
    lSet.Free;
  end;
end;

function GetContactEmails(const AClientId : integer; const aFieldName : string): string;
var
  qry: TERPQuery;
//  s: string;
begin
  result := '';
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.Sql.Add('SELECT ContactId, Company, ContactEmail from tblContacts where ' +
      aFieldName + '="T"  and clientId = ' + inttostr(aClientID));
    qry.Open;
    while not qry.Eof do begin
      if qry.FieldByName('ContactEmail').AsString <> '' then begin
        if result <> '' then result := result + ';';
        result := result + qry.FieldByName('ContactEmail').AsString;
      end;
      qry.Next;
    end;

    if Result <> '' then
      exit;

    // not found - check for the primary contact
    qry.Close;
    qry.SQL.Text := 'select ContactId, ContactEmail, ContactFirstName, ContactSurName from tblContacts where IsPrimaryContact="T"   and clientId = ' + inttostr(aClientID);
    qry.Open;
    if not qry.Eof and (qry.Fields[1].AsString <> '') then begin
      Result := qry.Fields[1].asString;
      exit;
    end;

    // look for ANY contact with e-mail
    qry.Close;
    qry.SQL.Text := 'select ContactId, Company, ContactEmail from tblContacts where ContactEmail is not null and ContactEmail <> ""   and clientId = ' + inttostr(aClientID);
    qry.Open;
    if not qry.Eof and (qry.Fields[1].AsString <> '') then begin
      result := result + qry.FieldByName('ContactEmail').AsString;
      exit;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function AddEmailToList(aEmail: string; aList: string): string;
begin
  result := aList;
  if result <> '' then result := result + ',';
  result := result + aEmail;
end;
function GetProductprintname(const ProductID: Integer): String;
begin
  strSQL:=' Select ProductPrintName from tblParts where PartsId = ' +IntToStr(ProductID);
  Result := FieldBynameValue(strSQL, 'ProductPrintName', asString) ;
end;
function clientPrintName(Company:String):String;
begin
  strSQL:=' Select Printname from tblclients where company = ' + Quotedstr(Company);
  Result := FieldBynameValue(strSQL, 'Printname', asString) ;
end;
(*function clientNameForPrintname(Printname:String):String;
begin
  strSQL:=' Select company from tblclients where  Printname= ' + Quotedstr(Printname);
  Result := FieldBynameValue(strSQL, 'company', asString) ;
end;*)
function clientIDForPrintname(Printname:String):Integer;
begin
  strSQL:=' Select clientID from tblclients where  Printname= ' + Quotedstr(Printname);
  Result := FieldBynameValue(strSQL, 'clientID', asInteger) ;
end;
(*function ProductNameForPrintname(Printname:String):String;
begin
  strSQL:=' Select Partname from tblparts where  ProductPrintname= ' + Quotedstr(Printname);
  Result := FieldBynameValue(strSQL, 'Partname', asString) ;
end;*)
function ProductPrintName(Partname:String):String;
begin
  strSQL:=' Select ProductPrintname from tblparts where Partname = ' + Quotedstr(Partname);
  Result := FieldBynameValue(strSQL, 'ProductPrintname', asString) ;
end;
function ProductIDForPrintname(Printname:String):Integer;
begin
  strSQL:=' Select PartsId from tblparts where Partname = ' + Quotedstr(Printname);
  Result := FieldBynameValue(strSQL, 'PartsId', asInteger) ;
end;
function OriginalSalesDocNumber(const SaleId:Integer):String;
begin
  strSQL:=' Select OriginalNo from tblsales  where SaleId = ' + inttostr(SaleId);
  Result := FieldBynameValue(strSQL, 'OriginalNo', asString) ;
end;
function OriginalPODocNumber(const POID:Integer):String;
begin
  strSQL:=' Select OriginalNo from tblpurchaseorders where purchaseorderId = ' + inttostr(POID);
  Result := FieldBynameValue(strSQL, 'OriginalNo', asString) ;
end;
Function IsOtfProduct(Const PartsID:Integer):Boolean;
begin
  strSQL:=' Select IsOTFProduct from tblparts where partsId = ' + inttostr(PartsID);
  Result := FieldBynameValue(strSQL, 'IsOTFProduct', asBoolean) ;
end;
Function SalesOrderEmployeeEmail(const SaleId :Integer):String;
begin
  strSQL:=' Select E.email from tblsales S inner join tblEmployees E on S.EmployeeId = E.employeeId  where S.saleId=  ' + inttostr(SaleId);
  Result := FieldBynameValue(strSQL, 'email', asString) ;
end;
function ProductDefaultLineNo(Const PartsID:Integer):Integer;
begin
  strSQL:=' Select LineNo from tblparts where partsId = ' + inttostr(PartsID);
  Result := FieldBynameValue(strSQL, 'LineNo', asInteger) ;
end;
function LastEmployeeNo:Integer;
begin
  strSQL:=' Select if(EmployeeNo<EmployeeID , EmployeeID,EmployeeNo) as LastEmployeeNo from (Select ifnull(max(EmployeeNo),0) EmployeeNo , ifnull(Max(EmployeeID),0) EmployeeID from tblemployees) details';
  Result := FieldBynameValue(strSQL, 'LastEmployeeNo', asInteger) ;
end;
function EmployeeIDForNo(Const EmpNo:Integer):Integer;
begin
  strSQL:=' Select EmployeeId from tblemployees where EmployeeNo ='+inttostr(EmpNo);
  Result := FieldBynameValue(strSQL, 'EmployeeId', asInteger) ;
end;
function ProductPrice1(Const PartsID:Integer):Double;
begin
  strSQL:=' Select PRICE1 from tblparts where partsId = ' + inttostr(PartsID);
  Result := FieldBynameValue(strSQL, 'PRICE1', asFloat) ;
end;
function ProductPrice1inc(Const PartsID:Integer):Double;
begin
  strSQL:=' Select PRICEINC1 from tblparts where partsId = ' + inttostr(PartsID);
  Result := FieldBynameValue(strSQL, 'PRICEINC1', asFloat) ;
end;
Function Is_Inv_Product(Const PartsID:Integer):Boolean;
begin
  strSQL:=' Select PARTTYPE from tblparts where partsId = ' + inttostr(PartsID);
  Result := commonlib.IsInvProduct(FieldBynameValue(strSQL, 'PARTTYPE', asString) );
end;
Function Is_Inv_Product(Const Partname:String):Boolean;
begin
  strSQL:=' Select PARTTYPE from tblparts where Partname = ' + Quotedstr(Partname);
  Result := commonlib.IsInvProduct(FieldBynameValue(strSQL, 'PARTTYPE', asString) );
end;
Function IsSaleConverted(Const SaleId:Integer):Boolean;
begin
  strSQL:=' select converted from tblsales where saleId = ' + Inttostr(SaleId);
  Result := FieldBynameValue(strSQL, 'converted', asBoolean) ;
end;
function hasSerialNoTabletAllocationIssue:boolean;
begin
  strSQL:=' select ' +
        ' count(pqa.pqaid) as SerialNosTabletAllocationIssue '+
        ' from tblsaleslines sl '+
        ' inner join tblparts p on sl.ProductID = p.partsId  and p.SNTracking ="T" and p.batch="F" and p.MultipleBins="F" '+
        ' inner join tblpqa pqa on sl.saleLineId = pqa.translineId and pqa.transtype in ("TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine" ) '+
        ' left join tblpqadetails pqad on pqad.PQAID = pqa.pqaid '+
        ' where ifnull(pqad.PQADetailID,0)=0 and ifnull(sl.SoldSerials , "")<> ""';
  Result := FieldBynameValue(strSQL, 'SerialNosTabletAllocationIssue', asInteger) > 0;
end;
Function IscontainerRelatedProduct(const ProductId , parentProductID:Integer):Boolean;
begin
  strSQL:=' Select iscontainer from tblrelatedparts where ParentID = ' + inttostr(parentProductID)+' and ProductID= ' + inttostr(ProductId)+'';
  Result := FieldBynameValue(strSQL, 'iscontainer', asBoolean) ;
end;
Function CustomerBOCount(const customerID:Integer; saleType:String):Integer;
begin
    strSQL:=' SELECT  Count(tblSalesLines.SaleLineID) as ctr '+
                               ' FROM tblSales INNER JOIN tblSalesLines USING(SaleID)   '+
                               ' WHERE '+ iif(saleType='I' , 'tblSales.IsInvoice="T" ', 'tblSales.IsSalesOrder="T" ') +
                               ' AND tblSales.Deleted="F"  AND tblSales.ClientID= ' +IntToStr(customerID) +'  '+
                               ' AND IFNULL(TBLSALES.BOID , "") = ""  AND tblSalesLines.BackOrder > 0  AND tblSalesLines.Invoiced = "F" AND tblSalesLines.Shipped = 0 ';
    Result := FieldBynameValue(strSQL, 'ctr', asInteger) ;

end;
Function Recordcount(const tablename :String):Integer;
begin
  strSQL:= 'Select count(*) as ctr from ' + tablename;
  Result := FieldBynameValue(strSQL, 'ctr', asInteger) ;
end;
Function isQLDRegisteredVehicle(const EquipId:Integer):Boolean;
begin
  strSQL:= 'Select isQLDRegisteredVehicle from tblequipment Where EquipmentID = ' + inttostr(EquipId);
  Result := FieldBynameValue(strSQL, 'isQLDRegisteredVehicle', asBoolean) ;
end;
Function EquipIdForCustomerEquipmentId(const CustomerEquipmentId:Integer):Integer;
begin
  strSQL:= 'select equipmentID from tblcustomerequip where id =  ' + inttostr(CustomerEquipmentId);
  Result := FieldBynameValue(strSQL, 'equipmentID', asInteger) ;

end;
Procedure ToDoLinktypenID(const ToDOID:Integer; var Linktype:String; var LinkID:Integer);
begin
  strSQL:= 'select linkto, linktoID from tbltodo  where todoid =  ' + inttostr(ToDOID);
  Linktype := FieldBynameValue(strSQL, 'linkto', asString) ;
  LinkID := FieldBynameValue(strSQL, 'linktoID', asInteger) ;
end;
(*function InvoiceReportName(Const SaleID:Integer): String;
var
  fi:Integer;
begin
  strSQL:= 'select s.HoldSale , c.DefaultInvoiceTemplateID from tblsales s inner join tblclients C on S.clientId = C.clientId where s.saleId =  ' + inttostr(SaleID);
  if (FieldBynameValue(strSQL, 'HoldSale' , asBoolean)) and not AppEnv.CompanyPrefs.UseTemplateDefaultInvoice then Result := 'Invoice Held'
  else   begin
    fi :=FieldBynameValue(strSQL, 'DefaultInvoiceTemplateID' , asInteger);
    Result := tcDataUtils.GetTemplate(fi);
  end;
end;*)
function CustomerInvoiceReportName(Const clientID:Integer): String;
var
  fi:Integer;
begin
  strSQL:= 'select c.DefaultInvoiceTemplateID from tblclients C where C.clientId =  ' + inttostr(clientID);
  fi :=FieldBynameValue(strSQL, 'DefaultInvoiceTemplateID' , asInteger);
  Result := tcDataUtils.GetTemplate(fi);
end;
function PrefNameToDesc(const aPreftype, aPrefname:String):String;
begin
  // assuming duplciates are only in employee , procprefs and columnheadings
  // company prefs are of different types - ptAccount, ptCompany, ptPayroll ,ptUpdate
  strSQL:= 'select concat_ws("-" , substring(Page,2,Length(Page)-Length("PrefsGUI")-1) , GroupDEsc, Description) as description from tbldbpreference_description  where name = '+quotedstr(aPrefname);
  if aPreftype = '' then strSQL:= strSQL +' and Preftype <> "ptemployees" and Preftype <> "TBusObjProcPrefs" and preftype <> "ptcolumnHeadings"'
  else strSQL:= strSQL +' and Preftype = '+quotedstr(aPreftype);
  Result := FieldBynameValue(strSQL, 'description', asString) ;
  if result = '' then result :=  aPrefname;
end;
function POSupplierName(const aPORef:String):String;
begin
  strSQL:= 'select SupplierName from tblpurchaseorders where Globalref = '+quotedstr(aPORef);
  Result := FieldBynameValue(strSQL, 'SupplierName', asString) ;
end;
function POLProductName(const aPOLineRef:String):String;
begin
  strSQL:= 'select ProductName from tblpurchaselines where Globalref = '+quotedstr(aPOLineRef);
  Result := FieldBynameValue(strSQL, 'ProductName', asString) ;
end;
function POLProductName(const aLineID:Integer):String;
begin
  strSQL:= 'select ProductName from tblpurchaselines where PurchaseLineId = '+inttostr(aLineID);
  Result := FieldBynameValue(strSQL, 'ProductName', asString) ;
end;
function LinkedPOID(const aPOID:Integer):Integer;
begin
  strSQL:= 'select LPO.purchaseOrderId from tblpurchaseorders PO inner join tblpurchaseorders  LPO on PO.Globalref = ifnull(LPO.LinkPORef,"")  where PO.purchaseorderId = '+inttostr(aPOID);
  Result := FieldBynameValue(strSQL, 'purchaseOrderId', asInteger) ;
end;
Function TransRecCount(DateFrom, DAteTo:TDateTime):Integer;
begin
  strsql := 'select Sum(ctr) as ctr from ( '+
              ' select count(*) ctr from tbltransactions where date between ' + quotedstr(FormatDateTime(MysqlDateFormat, datefrom))+' and '+ quotedstr(FormatDateTime(MysqlDatetimeFormat, DateTo)) +
              ' union all select count(*) ctr from tbltransactionsummarydetails  where date between ' + quotedstr(FormatDateTime(MysqlDateFormat, datefrom))+' and '+ quotedstr(FormatDateTime(MysqlDatetimeFormat, DateTo)) +' ) details';
  Result := FieldBynameValue(strSQL, 'ctr', asInteger) ;
end;
Function SalesLineWOLineID(ERPBaseLineno:Integer):Integer;
begin
  StrSQL:= 'Select WOL.OrderLineId ' +
           ' from tblsaleslines SL ' +
           ' inner join tblwalmartorderlines WOL on SL.GlobalRef = WOL.ERPSalesLineRef ' +
           ' where SL.SaleLineID =  ' + inttostr(ERPBaseLineno);
  Result := FieldBynameValue(strSQL, 'OrderLineId', asInteger) ;
end;
Function WOIdtoSaleID(WOID:Integer):Integer;
begin
  strSQL:= 'Select S.saleId from tblWalmartOrders WO inner join tblsales S on WO.erpSalesREf = S.GlobalRef  where WO.orderId = '+ inttostr(WOID);
  Result := FieldBynameValue(strSQL, 'saleId', asInteger) ;
end;
Function WalmartOrderLinecount(WOID:Integer):Integer;
begin
  strSQL:= 'Select count(*) ctr from tblwalmartorderlines where OrderId = '+ inttostr(WOID);
  Result := FieldBynameValue(strSQL, 'ctr', asInteger) ;
end;
Function HasLocalDoc(HelpID:Integer):Boolean;
begin
  strSQL:= 'Select count(*) as ctr  from tblUDErpHelpDocs where contextID = '+ inttostr(HelpID);
  Result := FieldBynameValue(strSQL, 'ctr', asInteger) >0;
end;

Function HasExcelPriceforProduct(const aProductId:Integer; var errmsg:String):Boolean;
begin
  result := False;
  errmsg := '';
  if not(Appenv.Companyprefs.HasExcelPrices) then exit;
  strSQL:= 'select *   from tblpartsforexcelprice where ProductId = ' + inttostr(aProductId) +' and Active ="T"';
  Result := (FieldBynameValue(strSQL, 'ID', asInteger) >0) and
            (trim(FieldBynameValue(strSQL, 'ExcelFilename',asString))<> '');
  if Result and not (isExcelInstalled) then begin
      ErrMsg :='Unable to Access ' + FieldBynameValue(strSQL, 'ExcelFilename',asString) +' for Price '+NL+
                'as This Machine Doesn''t Have Excel Installed.';
      Result := False;
      Exit;
  end;
end;

Function HasExcelPriceforProduct(const aProductId:Integer; showMsgifExcelMissing:Boolean):Boolean;
var
  errmsg:string;
begin
  result :=  HasExcelPriceforProduct(aproductId, errmsg);
  if not(result) and (errmsg<> '') and showMsgifExcelMissing  then MessageDlgXP_Vista(errmsg, mtInformation, [mbOK], 0);
end;

Function TransSeqno(aProctreeId:Integer ; fConnection: TCustomMyconnection = nil):integer;
begin
  strSQL := 'SELECT ' +
            '  count(pqad.PQADetailID) ctr ' +
            '  FROM tblSaleslines SL ' +
            '  INNER JOIN tblproctree PT ON SL.salelineId = PT.masterID AND PT.MasterType <> "mtProduct" ' +
            '  INNER JOIN tblprocprogress PPG on PT.procTreeID = PPG.proctreeId ' +
            '  INNER JOIN tblpqa pqa ON pqa.TransLineID = PPG.ProcProgressID AND pqa.TransType = "TProcProgressIn" ' +
            '  INNER JOIN tblpqadetails pqad ON pqa.pqaid = pqad.pqaid AND pqad.PQAType ="SN" ' +
            '  WHERE PT.proctreeId = ' + inttostr(aProctreeId);
  Result := FieldBynameValue(strSQL, 'ctr', asInteger ,false, fConnection) + 1;
end;
Function PPGExists(const PPGRef:String):Boolean;
begin
  result := False;
  if trim(PPGRef) = '' then exit;
  StrSQL:= 'select count(*) ctr from tblProcprogress where globalref =' +  quotedstr(PPGRef);
  Result := FieldBynameValue(strSQL, 'ctr', asInteger ,false)>0;
end;
Function SOInvoiceLineExists(const SOInvoiceLineRef:String):Boolean;
begin
  result := False;
  if trim(SOInvoiceLineRef) = '' then exit;
  StrSQL:= 'select count(*) ctr from tblsalesorderinvoicelines where globalref =' +  quotedstr(SOInvoiceLineRef);
  Result := FieldBynameValue(strSQL, 'ctr', asInteger ,false)>0;
end;
Function SalelineSeqno(aSaleLineID:Integer ; fConnection: TCustomMyconnection = nil):integer;
begin
  strSQL := 'SELECT ' +
            '  seqno  ' +
            '  FROM tblSaleslines SL ' +
            '  WHERE SL.saleLineID = ' + inttostr(aSaleLineID);
  Result := FieldBynameValue(strSQL, 'seqno', asInteger ,false, fConnection);
end;
Function HelpdocID(HelpdDescription:String):Integer;
begin
  strSQL:= 'Select * from erpdocumentaion.tblhelpdocs where Description =' + quotedstr(HelpdDescription);
  Result := FieldBynameValue(strSQL, 'ID', asInteger ,false);
end;
Function GOLiveAddition(aID:Integer;fconnection: TCustomMyconnection = nil):String;
begin
  strSQL:= 'Select Addition from tblgolive where GoliveId =' + inttostr(aID);
  Result := FieldBynameValue(strSQL, 'Addition', asString ,false, fConnection);
end;
Function GOLiveCategoryno(aID:Integer;fconnection: TCustomMyconnection = nil):Integer;
begin
  strSQL:= 'Select Categoryno from tblgolive where GoliveId =' + inttostr(aID);
  Result := FieldBynameValue(strSQL, 'Categoryno', asInteger ,false, fConnection);
end;
Function ProductinstockQty(aPartsID:Integer;
                           fconnection: TCustomMyconnection = nil;
                           Const asOndate: TDatetime = 0;
                           Const fUOM: String = '';
                           Const ficlassid: Integer = 0):Double;
begin
  strSQL:= ProductQtyLib.SQL4ProductAvailableQty(asOndate , fuom, tsummary, aPartsID, ficlassid,  '',0, '','', '', tInStock);
  Result := FieldBynameValue(strSQL, 'Qty', asInteger ,false, fConnection);
end;
Function ProductAvailableQty(Const aProductID:Integer; aUOM:String; aClassID:Integer=0):Double;
begin
  strSQL:= SQL4ProductAvailableQty(date , aUOM, tSummary , aProductID, aClassID);
  Result := FieldBynameValue(strSQL, 'Qty', asFloat);
end;
Function ProductAvailableQty(aPartsID:Integer;
                           fconnection: TCustomMyconnection = nil;
                           Const asOndate: TDatetime = 0;
                           Const fUOM: String = '';
                           Const ficlassid: Integer = 0):Double;
begin
  strSQL:= ProductQtyLib.SQL4ProductAvailableQty(asOndate , fuom, tsummary, aPartsID, ficlassid,  '',0, '','', '', tAvailable);
  Result := FieldBynameValue(strSQL, 'Qty', asInteger ,false, fConnection);
end;
Function SaleIDForCoucher(Const Voucherno :STring;fconnection: TCustomMyconnection = nil):Integer;
begin
  Strsql:= 'SELECT saleId FROM tblvouchers WHERE voucherno ='+quotedstr(Voucherno);
  Result := FieldBynameValue(strSQL, 'saleId', asInteger ,false, fConnection);
end;
function GetAutoBarcode(fconnection: TCustomMyconnection = nil): string;
var
  fimaxlen :Integer;
begin
  strSQL:= 'Select max(length(barcode)) maxlen from  tblparts where  length(barcode)<=15';
  fimaxlen := FieldBynameValue(strSQL, 'maxlen', asInteger , false, fconnection);
  strSQL:= 'SELECT MAX(Truncate(P.Barcode, 0))  AS aBarcode,  '+
                 ' MAX(Truncate(P.Barcode, 0)) + 1 AS Barcode  '+
                 ' FROM tblparts P  '+
                 ' where isinteger(barcode)     '+
                 ' and  length(barcode) = ' + inttostr(fimaxlen);
  //REsult := inttostr(FieldBynameValue(strSQL, 'Barcode', asInteger , false, fconnection));
  REsult := FieldBynameValue(strSQL, 'Barcode', asString , false, fconnection);
  strSQL := 'Select ifnull(GetSequenceNumber(' +QuotedStr('Product_Bar_Code')+', ' + IntToStr(Integer(fconnection))+','+ Result +'),0)  as no';
  REsult := FieldBynameValue(strSQL, 'no', asString);
end;
function ClientTemplateSQL(templatetype:String):String;
begin
    Result       := 'SELECT '+
                    ' T.TemplName, S.HoldSale '+
                    ' FROM tblsales S '+
                    ' INNER JOIN tblclients C ON S.ClientID = C.ClientID '+
                    ' Left JOIN tbltemplates T ON T.TemplID = '+
                      iif(sametext(templatetype, 'TInvoiceGUI'), 'C.DefaultInvoiceTemplateID' ,
                      iif(sametext(templatetype, 'TSalesOrderGUI'), 'C.DefaultSalesOrderTemplateID' ,
                      iif(sametext(templatetype, 'Statement'), 'C.DefaultStatementTemplateId' ,
                      iif(sametext(templatetype, 'Deliverydocket'), 'C.DefaultDeliveryTemplateID' ,'0' )))) ;
end;

function ClientDefaultTemplate(AOwnerformName: String; Const aSaleID: Integer): String;
var
 qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Closedb(Qry);
    qry.Sql.Text := ClientTemplateSQL(AOwnerformName) +
                    ' WHERE s.saleId = ' + InttoStr(aSaleID);
    OpenDB(qry);
    Result := qry.fieldbyname('TemplName').AsString;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function DeliverydocketTemplateForSale(Const aSaleID:Integer):String;
var
 qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(Qry);
    qry.sql.text := ClientTemplateSQL('Deliverydocket') +
                    ' WHERE s.saleId = ' + inttostr(aSaleID);
    OpenDB(qry);
    Result := qry.fieldbyname('TemplName').AsString;
    if result = '' then begin
      if Qry.fieldbyname('HoldSale').asBoolean then result := 'Delivery Docket Held'
      else result := GetDefaultTemplate('Delivery Docket');//'Delivery Docket';
(*      closedb(Qry);
      qry.sql.text := 'SELECT `TemplID`, `TemplName` FROM `tbltemplates` WHERE  TemplName = '+ quotedstr(result);
      OpenDB(qry);
      result := Qry.fieldbyname('TemplName').asString;*)
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
Function ValidCustomerforDB(AOwner:Tcomponent; dbname, customername:String):Boolean;
var
  con : TERPConnection;
begin
  result := False;
  if dbname = '' then exit;
  con:= GetNewMyDacConnection(AOwner, dbname);
  try
    strSQL:= ' select clientID from tblclients where company =' + quotedstr(Trim(customername)) ;
    result := FieldBynameValue(strSQL, 'clientID', asInteger , false, con)<>0;
  finally
    Freeandnil(Con);
  end;

end;
Function SeedToSaleStarted :Boolean;
begin
  strSQL:= 'Select ID from tblstsTags where ifnull(Plantcount,0)>0 limit 1';
  result := FieldBynameValue(strSQL, 'ID', asInteger , false)>0;
end;
Function StsPhaseCodeTodesc(ACode:String):String;
begin
       if ACode ='I' then Result := 'Immature'
  else if ACode ='V' then Result := 'Vegetative'
  else if ACode ='F' then Result := 'Flowering'
  else if ACode ='H' then Result := 'Harvest'
  else if ACode ='P' then Result := 'Product'
  else if ACode ='D' then Result := 'Destory'
  else Result := '';
end;
function TotNoOfResourcesinProduct(Const ResDetailID:Integer; fconnection: TCustomMyconnection= nil; ExID:Integer=0):Integer;
begin
  strSQL := 'Select Sum(NoOfResources) TotNoOfResources  '+
                     ' from tblprocresourceProducts   '+
                     ' where ProcresourcedetailID = ' + inttostr(ResDetailID) +
                     ' and ID <> ' + inttostr(ExID);

  result := FieldBynameValue(strSQL, 'TotNoOfResources', asInteger , false , fconnection);
end;
function VS1_ModuleID(const aModulename:String):Integer;
begin
  strSQL := 'SELECT ID  From tblVS1_Modules WHERE modulename = '+quotedstr(aModulename);
  result := FieldBynameValue(strSQL, 'ID', asInteger , false );
end;
Function SOQuteGlobalref(const aSalesOrderGlobalref:STring):String;
begin
  result := '';
  if aSalesOrderGlobalref ='' then exit;

  strSQL := 'SELECT Quoteglobalref  From tblsales WHERE globalref= '+quotedstr(aSalesOrderGlobalref);
  result := FieldBynameValue(strSQL, 'Quoteglobalref', asString , false );

end;
Function VS1_Module_Accounts_Payable_Reports_ID   : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Accounts_Payable_Reports   ); end;
Function VS1_Module_Accounts_Receivable_Report_ID : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Accounts_Receivable_Report ); end;
Function VS1_Module_Add_Extra_User_ID             : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Add_Extra_User             ); end;
Function VS1_Module_Appointment_Scheduling_ID     : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Appointment_Scheduling     ); end;
Function VS1_Module_Back_Ordering_ID              : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Back_Ordering              ); end;
Function VS1_Module_Balance_Sheets_ID             : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Balance_Sheets             ); end;
Function VS1_Module_Batch_Serial_No_Tracking_ID   : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Batch_Serial_No_Tracking   ); end;
Function VS1_Module_Bills_ID                      : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Bills                      ); end;
Function VS1_Module_Bin_Tracking_ID               : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Bin_Tracking               ); end;
Function VS1_Module_Departments_ID                : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Departments                ); end;
Function VS1_Module_Expense_Claims_ID             : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Expense_Claims             ); end;
Function VS1_Module_FX_Currency_ID                : Integer;	begin  Result := VS1_ModuleID(VS1_Module_FX_Currency                ); end;
Function VS1_Module_Inventory_Tracking_ID         : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Inventory_Tracking         ); end;
Function VS1_Module_Invoices_ID                   : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Invoices                   ); end;
Function VS1_Module_Jobs_construction_ID          : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Jobs_construction          ); end;
Function VS1_Module_Journals_ID                   : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Journals                   ); end;
Function VS1_Module_Link_To_TrueERP_ID            : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Link_To_TrueERP            ); end;
Function VS1_Module_Manufacturing_ID              : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Manufacturing              ); end;
Function VS1_Module_Matrix_ID                     : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Matrix                     ); end;
Function VS1_Module_Payemnts_ID                   : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Payemnts                   ); end;
Function VS1_Module_Payroll_Integration_ID        : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Payroll_Integration        ); end;
Function VS1_Module_Payroll_Unlimited_Employees_ID: Integer;	begin  Result := VS1_ModuleID(VS1_Module_Payroll_Unlimited_Employees); end;
Function VS1_Module_PO_Non_Inventory_ID           : Integer;	begin  Result := VS1_ModuleID(VS1_Module_PO_Non_Inventory           ); end;
Function VS1_Module_POS_ID                        : Integer;	begin  Result := VS1_ModuleID(VS1_Module_POS                        ); end;
Function VS1_Module_Profit_Loss_Reports_ID        : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Profit_Loss_Reports        ); end;
Function VS1_Module_Quotes_ID                     : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Quotes                     ); end;
Function VS1_Module_Reports_Dashboard_ID          : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Reports_Dashboard          ); end;
Function VS1_Module_Seed_To_Sale_ID               : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Seed_To_Sale               ); end;
Function VS1_Module_Shipping_ID                   : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Shipping                   ); end;
Function VS1_Module_Statements_ID                 : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Statements                 ); end;
Function VS1_Module_Stock_Adjustments_ID          : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Stock_Adjustments          ); end;
Function VS1_Module_Time_Sheets_ID                : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Time_Sheets                ); end;
Function VS1_Module_Use_Foreign_Currency_ID       : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Use_Foreign_Currency       ); end;
Function VS1_Module_Website_Integration_ID        : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Website_Integration        ); end;
Function VS1_Module_WMS_ID                        : Integer;	begin  Result := VS1_ModuleID(VS1_Module_WMS                        ); end;
Function VS1_Module_Paychex_Payroll_ID            : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Paychex_Payroll            ); end;
Function VS1_Module_ADP_Payroll_ID                : Integer;	begin  Result := VS1_ModuleID(VS1_Module_ADP_Payroll                ); end;
Function VS1_Module_Fixed_Assets_ID               : Integer;	begin  Result := VS1_ModuleID(VS1_Module_Fixed_Assets               ); end;



end.

