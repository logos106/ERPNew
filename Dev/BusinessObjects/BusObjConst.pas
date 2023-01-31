unit BusObjConst;

{
 Date     Version  Who  What
 -------- -------- ---  --------------------------------------------------------
 27/10/05  1.00.00 IJB  Initial version.
 05/01/06  1.00.01 IJB  Added new BOR_Sales_Warn_CusPONumNotUnique const and
                        moved business object event constants to here.
}

interface

const
{  Business Object Response Codes
   Allocate in blocks of 100 for each Business Object or Area
   (0 - 99 common across all).
   Within this range use the following:
     0 - 29 Info codes
     30 - 59 Warning codes
     60 - 99 Error codes
}
  { Common Response Codes }
  BOR_General_Info = 0;
  BOR_General_Warn = 30;
  BOR_General_Err  = 60;

  {Bus obj Object Level errors}
  BOR_Obj_Err_Not_Registered= 60;
  BOR_Obj_Err_CopyFailed    = 61;
  BOR_Obj_Err_Objectclosed  = 62;

  {XML import Errors}
  BOR_XMLImportExport_Prefix = 100;
  BOR_XMLImport_ObjectNodeNotfound = BOR_XMLImportExport_Prefix +  BOR_General_Err+1;
  BOR_XMLImport_UniqueFieldNameNotDefined = BOR_XMLImportExport_Prefix +  BOR_General_Err+2;
  BOR_XMLImport_DuplicateValueInUniqueField = BOR_XMLImportExport_Prefix +  BOR_General_Err+3;
  BOR_XMLImport_RecordNotFound = BOR_XMLImportExport_Prefix +  BOR_General_Err+4;
  BOR_XMLImport_RecordalreadyExists = BOR_XMLImportExport_Prefix +  BOR_General_Err+5;
  BOR_XMLImport_UnknownType = BOR_XMLImportExport_Prefix +  BOR_General_Err+6;
  BOR_XMLImport_Wrongtype = BOR_XMLImportExport_Prefix +  BOR_General_Err+7;
  BOR_XMLImport_UniqueFieldEmpty = BOR_XMLImportExport_Prefix +  BOR_General_Err+3;


  { Product Qty Response Codes }
  BOR_ProdQty_Prefix = 200;

  BOR_ProdQty_Info = BOR_ProdQty_Prefix + BOR_General_Info;
  BOR_ProdQty_Warn = BOR_ProdQty_Prefix + BOR_General_Warn;
  BOR_ProdQty_Err  = BOR_ProdQty_Prefix + BOR_General_Err;
  BOR_ProdQty_BatchBinAllocFailed = BOR_ProdQty_Prefix + 61;


  { Sales Response Codes }
  BOR_Sales_Prefix = 300;

  BOR_Sales_Info = BOR_Sales_Prefix + BOR_General_Info;
  BOR_Sales_Warn = BOR_Sales_Prefix + BOR_General_Warn;
  BOR_Sales_Warn_CreditExceeded = BOR_Sales_Prefix + 31;
  BOR_Sales_Warn_TermsExceeded = BOR_Sales_Prefix + 32;
  BOR_Sales_Warn_CusPONumNotUnique = BOR_Sales_Prefix + 33;

  BOR_Sales_Err      = BOR_Sales_Prefix + BOR_General_Err;
  BOR_Sales_Err_InvalidDepartment = BOR_Sales_Prefix + 61;
  BOR_Sales_InvalidPONumber = BOR_Sales_Prefix + 62;
  BOR_Sales_HoldSale = BOR_Sales_Prefix + 63;
  BOR_Sales_ErrorUpdatingBalances = BOR_Sales_Prefix + 66;
  BOR_Sales_ErrorSalesMargin = BOR_Sales_Prefix + 69;

  { Order Response Codes }
  BOR_Order_Prefix = 400;

  BOR_Order_Info = BOR_Order_Prefix + BOR_General_Info;

  BOR_Order_Warn = BOR_Order_Prefix + BOR_General_Warn;
  BOR_Order_Warn_Landedcost = BOR_Order_Prefix + 31;


  BOR_Order_Err = BOR_Order_Prefix + BOR_General_Err;
  BOR_Order_ErrorUpdatingBalances = BOR_Order_Prefix + 66;
  BOR_Order__NoProductETA         = BOR_Order_Prefix + 67;
  { TimeSheet Response codes}

  BOR_TimeSheet_Prefix = 500;

  BOR_TimeSheet_Info    = BOR_TimeSheet_Prefix + BOR_General_Info;
  BOR_TimeSheet_Warn    = BOR_TimeSheet_Prefix + BOR_General_Warn;
  BOR_TimeSheet_Err     = BOR_TimeSheet_Prefix + BOR_General_Err;
  (*BOR_TimeSheet_Err_UnknownEmployee = BOR_TimeSheet_Prefix + 61;
  BOR_TimeSheet_Err_NoDepartmentName = BOR_TimeSheet_Prefix + 62;
  BOR_TimeSheet_Err_HoursNotSpecified = BOR_TimeSheet_Prefix + 63;
  BOR_TimeSheet_Err_NoHourlyRate = BOR_TimeSheet_Prefix + 64;*)

  BOR_Product_Prefix = 600;
  BOR_Product_Info = BOR_Product_Prefix + BOR_General_Info;
  BOR_Product_Warn = BOR_Product_Prefix + BOR_General_Warn;
  BOR_Product_Err  = BOR_Product_Prefix + BOR_General_Err;
  {Product has many sub classes and properties, so the errors are categorised so that
  the form can make the relvant tab active}
  BOR_Product_Err_Main      = BOR_Product_Err +1;
  BOR_Product_Err_Qty       = BOR_Product_Err +2;
  BOR_Product_Err_Misc      = BOR_Product_Err +3;
  BOR_Product_Err_BinBatch  = BOR_Product_Err +4;
  BOR_Product_Err_ESP       = BOR_Product_Err +5;
  BOR_Product_Err_EBP       = BOR_Product_Err +6;
  BOR_Product_Err_GNK       = BOR_Product_Err +7;
  BOR_Product_Err_PRJ       = BOR_Product_Err +8;
  BOR_Product_Err_HP        = BOR_Product_Err +9;
  BOR_Product_Err_Serials   = BOR_Product_Err +10;
  BOR_Product_Err_PM        = BOR_Product_Err +11;
  BOR_Product_Err_PMQ       = BOR_Product_Err +12;
  BOR_Product_Err_Man       = BOR_Product_Err +13;


  { Employee Response Codes }
  BOR_Employee_Prefix = 700;
  BOR_Employee_Err_NoTitle                = BOR_Employee_Prefix + BOR_General_Err + 1;
  BOR_Employee_Err_NoFirstName            = BOR_Employee_Prefix + BOR_General_Err + 2;
  BOR_Employee_Err_NoLastName             = BOR_Employee_Prefix + BOR_General_Err + 3;
  BOR_Employee_Err_NoDefaultDepartment    = BOR_Employee_Prefix + BOR_General_Err + 4;
  BOR_Employee_Err_NoAddress              = BOR_Employee_Prefix + BOR_General_Err + 5;
  BOR_Employee_Err_NoCity                 = BOR_Employee_Prefix + BOR_General_Err + 6;
  BOR_Employee_Err_NoState                = BOR_Employee_Prefix + BOR_General_Err + 7;
  BOR_Employee_Err_NoCountry              = BOR_Employee_Prefix + BOR_General_Err + 8;

  BOR_Employee_Err_NoDateStarted          = BOR_Employee_Prefix + BOR_General_Err + 9;
  BOR_Employee_Err_NoDOB                  = BOR_Employee_Prefix + BOR_General_Err + 10;
  BOR_Employee_Err_NoSex                  = BOR_Employee_Prefix + BOR_General_Err + 11;
  BOR_Employee_Err_NoBasisOfPayment       = BOR_Employee_Prefix + BOR_General_Err + 12;
  BOR_Employee_Err_NoEmail                = BOR_Employee_Prefix + BOR_General_Err + 13;
  BOR_Employee_Err_HECSTaxScale           = BOR_Employee_Prefix + BOR_General_Err + 14;
  BOR_Employee_Err_NoHECSTaxScale         = BOR_Employee_Prefix + BOR_General_Err + 15;
  BOR_Employee_Err_StudentLoanTaxScale    = BOR_Employee_Prefix + BOR_General_Err + 16;
  BOR_Employee_Err_NoStudentLoanTaxScale  = BOR_Employee_Prefix + BOR_General_Err + 17;
  BOR_Employee_Err_PAyDatePriortoClosing  = BOR_Employee_Prefix + BOR_General_Err + 18;
  BOR_Employee_Err_NoDateFinished         = BOR_Employee_Prefix + BOR_General_Err + 19;
  BOR_Employee_Err_NoStateTax             = BOR_Employee_Prefix + BOR_General_Err + 20;
  BOR_Employee_Err_NoTaxScale             = BOR_Employee_Prefix + BOR_General_Err + 21;

  { Employee Pay Response Codes }
  BOR_EmployeePay_Prefix = 800;

  BOR_EmployeePay_Err_NoPayPeriod             = BOR_EmployeePay_Prefix + BOR_General_Err + 1;
  BOR_EmployeePay_Err_NoDepartment            = BOR_EmployeePay_Prefix + BOR_General_Err + 2;
  BOR_EmployeePay_Err_HrsRateZeroValue        = BOR_EmployeePay_Prefix + BOR_General_Err + 3;
  BOR_EmployeePay_Err_QtyZeroValue            = BOR_EmployeePay_Prefix + BOR_General_Err + 4;

  BOR_EmployeePay_Err_NoType                  = BOR_EmployeePay_Prefix + BOR_General_Err + 5;
  BOR_EmployeePay_Err_NoRate                  = BOR_EmployeePay_Prefix + BOR_General_Err + 6;

  BOR_EmployeePay_Err_NoBankAmount            = BOR_EmployeePay_Prefix + BOR_General_Warn + 7;
  BOR_EmployeePay_Err_NoAccountNumber         = BOR_EmployeePay_Prefix + BOR_General_Err + 8;
  BOR_EmployeePay_Err_NoBSBNumber             = BOR_EmployeePay_Prefix + BOR_General_Err + 9;
  BOR_EmployeePay_Err_NoBank                  = BOR_EmployeePay_Prefix + BOR_General_Err + 10;
  BOR_EmployeePay_Err_NoAccountName           = BOR_EmployeePay_Prefix + BOR_General_Err + 11;
  BOR_EmployeePay_Err_NoSplit                 = BOR_EmployeePay_Prefix + BOR_General_Err + 12;
  BOR_EmployeePay_Err_RemainderWithOneRec     = BOR_EmployeePay_Prefix + BOR_General_Err + 13;
  BOR_EmployeePay_Err_FBTNoDepartment         = BOR_EmployeePay_Prefix + BOR_General_Err + 14;
  BOR_EmployeePay_Err_FBTNoAmount             = BOR_EmployeePay_Prefix + BOR_General_Err + 15;
  BOR_EmployeePay_Err_FBTNoYearEnding         = BOR_EmployeePay_Prefix + BOR_General_Err + 16;

  BOR_EmployeePay_Err_EmpNoDeduction          = BOR_EmployeePay_Prefix + BOR_General_Err + 17;
  BOR_EmployeePay_Err_EmpDeductionNoQty       = BOR_EmployeePay_Prefix + BOR_General_Err + 18;
  BOR_EmployeePay_Err_EmpNoAmount             = BOR_EmployeePay_Prefix + BOR_General_Err + 21;
  BOR_EmployeePay_Err_EmpNoFirstPayDate       = BOR_EmployeePay_Prefix + BOR_General_Err + 22;
  BOR_EmployeePay_Err_EmpNoTaxCode            = BOR_EmployeePay_Prefix + BOR_General_Err + 23;
  BOR_EmployeePay_Err_EmpNoNICsNumber         = BOR_EmployeePay_Prefix + BOR_General_Err + 24;
  BOR_EmployeePay_Err_EmpNoNICsLetter         = BOR_EmployeePay_Prefix + BOR_General_Err + 25;
  BOR_EmployeePay_Err_NoPayPeriods            = BOR_EmployeePay_Prefix + BOR_General_Err + 26;
  BOR_EmployeePay_Err_NoPaydate               = BOR_EmployeePay_Prefix + BOR_General_Err + 27;
  BOR_EmployeePay_Err_EmpDeductionNoBasedOn   = BOR_EmployeePay_Prefix + BOR_General_Err + 19;
  BOR_EmployeePay_Err_EmpDeductionNoDepartment= BOR_EmployeePay_Prefix + BOR_General_Err + 20;

  { Employee Leave Response Codes }
  BOR_EmployeeLeave_Prefix = 900;

  BOR_EmployeeLeave_Err_NoType              = BOR_EmployeeLeave_Prefix + BOR_General_Err + 1;
  BOR_EmployeeLeave_Err_NoAccrueAfterNo     = BOR_EmployeeLeave_Prefix + BOR_General_Err + 2;
  BOR_EmployeeLeave_Err_NoAccrueAfterPeriod = BOR_EmployeeLeave_Prefix + BOR_General_Err + 3;
  BOR_EmployeeLeave_Err_NoAccrueHrs         = BOR_EmployeeLeave_Prefix + BOR_General_Err + 4;
  BOR_EmployeeLeave_Err_AccruePeriod        = BOR_EmployeeLeave_Prefix + BOR_General_Err + 5;
  BOR_EmployeeLeave_Err_NoDepartment        = BOR_EmployeeLeave_Prefix + BOR_General_Err + 6;
  BOR_EmployeeLeave_Err_NoAccrueNo          = BOR_EmployeeLeave_Prefix + BOR_General_Err + 7;

  { Employee Allowance Response Codes }
  BOR_EmployeeAllowance_Prefix = 1000;

  BOR_EmployeeAllowance_Err_NoDescription   = BOR_EmployeeAllowance_Prefix + BOR_General_Err + 1;
  BOR_EmployeeAllowance_Err_NoAmount        = BOR_EmployeeAllowance_Prefix + BOR_General_Err + 2;
  BOR_EmployeeAllowance_Err_NoCalcBy        = BOR_EmployeeAllowance_Prefix + BOR_General_Err + 3;
  BOR_EmployeeAllowance_Err_NoBasedOnID     = BOR_EmployeeAllowance_Prefix + BOR_General_Err + 4;
  BOR_EmployeeAllowance_Err_NoQty           = BOR_EmployeeAllowance_Prefix + BOR_General_Err + 5;
  BOR_EmployeeAllowance_Err_NoDepartment    = BOR_EmployeeAllowance_Prefix + BOR_General_Err + 6;
  BOR_EmployeeAllowance_Err_NoAllowance     = BOR_EmployeeAllowance_Prefix + BOR_General_Err + 6;

  { Employee Super Response Codes }
  BOR_EmployeeSuper_Prefix = 1100;

  BOR_EmployeeSuper_Err_NoType          = BOR_EmployeeSuper_Prefix + BOR_General_Err + 1;
  BOR_EmployeeSuper_Err_NoAmount        = BOR_EmployeeSuper_Prefix + BOR_General_Err + 2;
  BOR_EmployeeSuper_Err_NoCalcBy        = BOR_EmployeeSuper_Prefix + BOR_General_Err + 3;
  BOR_EmployeeSuper_Err_DateJoined      = BOR_EmployeeSuper_Prefix + BOR_General_Err + 4;
  BOR_EmployeeSuper_Err_NoFund          = BOR_EmployeeSuper_Prefix + BOR_General_Err + 5;
  BOR_EmployeeSuper_Err_NoDepartment    = BOR_EmployeeSuper_Prefix + BOR_General_Err + 6;
  BOR_EmployeeSuper_NoFund_Nagged       = BOR_EmployeeSuper_Prefix + BOR_General_Err + 7;
  BOR_EmployeeSuper_Err_SalarySacrifice = BOR_EmployeeSuper_Prefix + BOR_General_Err + 7;

  { Pay Allowance Response Codes }
  BOR_PayAllowance_Prefix = 1200;

  BOR_PayAllowance_Err_NoDescription   = BOR_PayAllowance_Prefix + BOR_General_Err + 1;
  BOR_PayAllowance_Err_NoQty           = BOR_PayAllowance_Prefix + BOR_General_Err + 2;
  BOR_PayAllowance_Err_NoBasedOnID     = BOR_PayAllowance_Prefix + BOR_General_Err + 3;
  BOR_PayAllowance_Err_NoAmount        = BOR_PayAllowance_Prefix + BOR_General_Err + 4;
  BOR_PayAllowance_Err_NoDepartment    = BOR_PayAllowance_Prefix + BOR_General_Err + 5;
  BOR_PayAllowance_Err_NoCalcBy        = BOR_PayAllowance_Prefix + BOR_General_Err + 6;



  { Pay Benefit Response Codes }
  BOR_PayBenefit_Prefix = 1300;
  //UK
  BOR_PayBenefit_Err_NoDescription      = BOR_PayBenefit_Prefix + BOR_General_Err + 1;
  BOR_PayBenefit_Err_NoNICsClass        = BOR_PayBenefit_Prefix + BOR_General_Err + 2;
  BOR_PayBenefit_Err_NoNIEmployeeAmount = BOR_PayBenefit_Prefix + BOR_General_Err + 3;
  BOR_PayBenefit_Err_NoNIEmployerAmount = BOR_PayBenefit_Prefix + BOR_General_Err + 4;
  BOR_PayBenefit_Err_NoDepartmentUK     = BOR_PayBenefit_Prefix + BOR_General_Err + 5;
  //Aust
  BOR_PayBenefit_Err_NoSuperType        = BOR_PayBenefit_Prefix + BOR_General_Err + 6;
  BOR_PayBenefit_Err_NoFund             = BOR_PayBenefit_Prefix + BOR_General_Err + 7;
  BOR_PayBenefit_Err_NoDateJoined       = BOR_PayBenefit_Prefix + BOR_General_Err + 8;
  BOR_PayBenefit_Err_NoAmount           = BOR_PayBenefit_Prefix + BOR_General_Err + 9;
  BOR_PayBenefit_Err_NoAmountPaid       = BOR_PayBenefit_Prefix + BOR_General_Err + 10;
  BOR_PayBenefit_Err_NoDepartmentAust   = BOR_PayBenefit_Prefix + BOR_General_Err + 11;
  BOR_PayBenefit_Err_SalarySacrifice    = BOR_PayBenefit_Prefix + BOR_General_Err + 12;

  { Pay Payrates Response Codes }
  BOR_PayPayrates_Prefix = 1400;

  BOR_PayPayrates_Err_NoRate           = BOR_PayPayrates_Prefix + BOR_General_Err + 1;
  BOR_PayPayrates_Err_NoType           = BOR_PayPayrates_Prefix + BOR_General_Err + 2;
  BOR_PayPayrates_Err_NoQty            = BOR_PayPayrates_Prefix + BOR_General_Err + 3;
  BOR_PayPayrates_Err_NoDepartment     = BOR_PayPayrates_Prefix + BOR_General_Err + 4;

  { Pay Deductions Response Codes }
  BOR_PayDeductions_Prefix = 1500;

  BOR_PayDeductions_Err_NoDescription  = BOR_PayDeductions_Prefix + BOR_General_Err + 1;
  BOR_PayDeductions_Err_NoAmount       = BOR_PayDeductions_Prefix + BOR_General_Err + 2;
  BOR_PayDeductions_Err_NoCalcBy       = BOR_PayDeductions_Prefix + BOR_General_Err + 3;
  BOR_PayDeductions_Err_NoBasedOnID    = BOR_PayDeductions_Prefix + BOR_General_Err + 4;
  BOR_PayDeductions_Err_NoDepartment   = BOR_PayDeductions_Prefix + BOR_General_Err + 5;
  BOR_PayDeductions_Err_NoQty          = BOR_PayDeductions_Prefix + BOR_General_Err + 6;

  { Pay Leaves Response Codes }
  BOR_PayLeaves_Prefix = 1600;

  BOR_PayLeaves_Err_NoType             = BOR_PayLeaves_Prefix + BOR_General_Err + 1;
  BOR_PayLeaves_Err_NoDateTaken        = BOR_PayLeaves_Prefix + BOR_General_Err + 2;
  BOR_PayLeaves_Err_NoQty              = BOR_PayLeaves_Prefix + BOR_General_Err + 3;
  BOR_PayLeaves_Err_NoDepartment       = BOR_PayLeaves_Prefix + BOR_General_Err + 4;
  BOR_PayLeaves_Err_FromAfterTo        = BOR_EmployeePay_Prefix + BOR_General_Err + 5;

  { Pay Commissions Response Codes }
  BOR_PayCommissions_Prefix = 1700;

  BOR_PayCommissions_Err_NoDescription = BOR_PayCommissions_Prefix + BOR_General_Err + 1;
  BOR_PayCommissions_Err_NoGross       = BOR_PayCommissions_Prefix + BOR_General_Err + 2;
  BOR_PayCommissions_Err_NoPeriod      = BOR_PayCommissions_Prefix + BOR_General_Err + 3;
  BOR_PayCommissions_Err_NoDepartment  = BOR_PayCommissions_Prefix + BOR_General_Err + 4;

  { Pay Sundries Response Codes }
  BOR_PaySundries_Prefix = 1800;

  BOR_PaySundries_Err_NoDescription    = BOR_PaySundries_Prefix + BOR_General_Err + 1;
  BOR_PaySundries_Err_NoAmount         = BOR_PaySundries_Prefix + BOR_General_Err + 2;
  BOR_PaySundries_Err_NoDepartment     = BOR_PaySundries_Prefix + BOR_General_Err + 3;

  { Pay Splits Response Codes }
  BOR_PaySplits_Prefix = 1900;

  BOR_PaySplits_Err_NoSplitType        = BOR_PaySplits_Prefix + BOR_General_Err + 1;
  BOR_PaySplits_Err_NoSplit            = BOR_PaySplits_Prefix + BOR_General_Err + 2;
  BOR_PaySplits_Err_NoBankID           = BOR_PaySplits_Prefix + BOR_General_Err + 3;
  BOR_PaySplits_Err_NoBranch           = BOR_PaySplits_Prefix + BOR_General_Err + 4;
  BOR_PaySplits_Err_NoBsb              = BOR_PaySplits_Prefix + BOR_General_Err + 5;
  BOR_PaySplits_Err_NoAccountNo        = BOR_PaySplits_Prefix + BOR_General_Err + 6;
  BOR_PaySplits_Err_NoAmount           = BOR_PaySplits_Prefix + BOR_General_Err + 7;
  BOR_PaySplits_Err_NoAccountName      = BOR_PaySplits_Prefix + BOR_General_Err + 8;
  BOR_PaySplits_Err_RemainderWithOneRec = BOR_PaySplits_Prefix + BOR_General_Err + 9;

  { Award Response Codes }
  BOR_Award_Prefix = 2000;

  BOR_Award_Err_NoDescription          = BOR_Award_Prefix + BOR_General_Err + 1;
  BOR_Award_Err_NoDepartment           = BOR_Award_Prefix + BOR_General_Err + 2;
  BOR_Award_Err_NoPayPeriod            = BOR_Award_Prefix + BOR_General_Err + 3;
  BOR_Award_Err_NoSickLeaveThreshold   = BOR_Award_Prefix + BOR_General_Err + 4;
  BOR_Award_Err_NoMealBreakHrs         = BOR_Award_Prefix + BOR_General_Err + 5;
  BOR_Award_Err_NoMealBreakThreshold   = BOR_Award_Prefix + BOR_General_Err + 6;
  BOR_Award_Err_NoSuperType            = BOR_Award_Prefix + BOR_General_Err + 7;
  BOR_Award_Err_NoSuperValue           = BOR_Award_Prefix + BOR_General_Err + 8;

  { Award Classification Response Codes }
  BOR_AwardClassification_Prefix = 2100;

  BOR_AwardClassification_Err_NoDescription     = BOR_AwardClassification_Prefix + BOR_General_Err + 1;
  BOR_AwardClassification_Err_NoType            = BOR_AwardClassification_Prefix + BOR_General_Err + 2;
  BOR_AwardClassification_Err_NoFtHourlyRate    = BOR_AwardClassification_Prefix + BOR_General_Err + 3;
  BOR_AwardClassification_Err_NoPtHourlyRate    = BOR_AwardClassification_Prefix + BOR_General_Err + 4;
  BOR_AwardClassification_Err_NoCHourlyRate     = BOR_AwardClassification_Prefix + BOR_General_Err + 5;
  BOR_AwardClassification_Err_NoAdvanceID       = BOR_AwardClassification_Prefix + BOR_General_Err + 6;

  BOR_ClassificationAllowance_Err_NoAllowance   = BOR_AwardClassification_Prefix + BOR_General_Err + 7;
  BOR_ClassificationAllowance_Err_NoAmount      = BOR_AwardClassification_Prefix + BOR_General_Err + 8;
  BOR_ClassificationAllowance_Err_NoBasedOn     = BOR_AwardClassification_Prefix + BOR_General_Err + 9;

  BOR_ClassificationDeduction_Err_NoDeduction   = BOR_AwardClassification_Prefix + BOR_General_Err + 10;
  BOR_ClassificationDeduction_Err_NoAmount      = BOR_AwardClassification_Prefix + BOR_General_Err + 11;
  BOR_ClassificationDeduction_Err_NoBasedOn     = BOR_AwardClassification_Prefix + BOR_General_Err + 12;

  BOR_ClassificationExtraPayRates_Err_NoPayRate = BOR_AwardClassification_Prefix + BOR_General_Err + 13;
  BOR_ClassificationExtraPayRates_Err_NoType    = BOR_AwardClassification_Prefix + BOR_General_Err + 14;
  BOR_ClassificationExtraPayRates_Err_NoAmount  = BOR_AwardClassification_Prefix + BOR_General_Err + 15;
  BOR_ClassificationExtraPayRates_Err_NoWorked  = BOR_AwardClassification_Prefix + BOR_General_Err + 16;

  { Award Leaves Response Codes }
  BOR_AwardLeaves_Prefix = 2200;

  BOR_AwardLeaves_Err_NoLeave                   = BOR_AwardLeaves_Prefix + BOR_General_Err + 1;
  BOR_AwardLeaves_Err_NoAccrueAfterNo           = BOR_AwardLeaves_Prefix + BOR_General_Err + 2;
  BOR_AwardLeaves_Err_NoAfterPeriod             = BOR_AwardLeaves_Prefix + BOR_General_Err + 3;
  BOR_AwardLeaves_Err_NoAccrueNo                = BOR_AwardLeaves_Prefix + BOR_General_Err + 4;
  BOR_AwardLeaves_Err_NoAccruePeriod            = BOR_AwardLeaves_Prefix + BOR_General_Err + 5;
  BOR_AwardLeaves_Err_NoAccrueHours             = BOR_AwardLeaves_Prefix + BOR_General_Err + 6;
  BOR_AwardLeaves_Err_NoStartDate               = BOR_AwardLeaves_Prefix + BOR_General_Err + 7;
  BOR_AwardLeaves_Err_NoEndDate                 = BOR_AwardLeaves_Prefix + BOR_General_Err + 8;

  { Workers Comp Response Codes }
  BOR_WorkersComp_Prefix = 2300;

  BOR_WorkersComp_Err_NoDetails        = BOR_WorkersComp_Prefix + BOR_General_Err + 1;
  BOR_WorkersComp_Err_NoDate           = BOR_WorkersComp_Prefix + BOR_General_Err + 2;
  BOR_WorkersComp_Err_NoAmount         = BOR_WorkersComp_Prefix + BOR_General_Err + 3;
  BOR_WorkersComp_Err_NoDepartment     = BOR_WorkersComp_Prefix + BOR_General_Err + 4;
  BOR_WorkersComp_Err_NoType           = BOR_WorkersComp_Prefix + BOR_General_Err + 5;

  { Employee termination Response Codes }
  BOR_Termination_Prefix = 2400;

  BOR_Termination_Err_NoName           = BOR_Termination_Prefix + BOR_General_Err + 1;
  BOR_Termination_Err_NoReason         = BOR_Termination_Prefix + BOR_General_Err + 2;
  BOR_Termination_Err_NoDate           = BOR_Termination_Prefix + BOR_General_Err + 3;

  {Shipping Container}
  BOR_Ship_Prefix  = 2500;

  BOR_No_Ship_ContainerName            = BOR_Ship_Prefix + BOR_General_Err + 1;
  BOR_No_Ship_Container_Status         = BOR_Ship_Prefix + BOR_General_Err + 2;

  {General}
  BOR_General_Prefix  = 2600;
  SX_StepProgress                      = BOR_General_Prefix + 1;

  {Employee Services}
  BOR_EmpServices_Prefix = 2700;
  BOR_No_EmpService_Name               = BOR_EmpServices_Prefix + BOR_General_Err + 1;
  BOR_No_EmpService_Part               = BOR_EmpServices_Prefix + BOR_General_Err + 2;
  BOR_No_EmpService_Rate               = BOR_EmpServices_Prefix + BOR_General_Err + 3;

  {Messages}
  BOR_Messages_Prefix = 2800;
  BOR_No_Message_Name               = BOR_Messages_Prefix + BOR_General_Err + 1;
  BOR_No_Message_To                 = BOR_Messages_Prefix + BOR_General_Err + 2;
  BOR_No_Message_ActionFlag         = BOR_Messages_Prefix + BOR_General_Err + 3;

  {Currency}
  BOR_Currency_Prefix = 2900;
  BOR_Currency_BuyRateInvalid   = BOR_Currency_Prefix + BOR_General_Err + 1;
  BOR_Currency_SellRateInvalid  = BOR_Currency_Prefix + BOR_General_Err + 2;
  BOR_Currency_No_Country       = BOR_Currency_Prefix + BOR_General_Err + 3;
  BOR_Currency_No_Currency      = BOR_Currency_Prefix + BOR_General_Err + 4;
  BOR_Currency_No_Code          = BOR_Currency_Prefix + BOR_General_Err + 5;

  {Currency}
  BOR_Source_Prefix = 3000;
  BOR_Source_DescriptionBlank   = BOR_Source_Prefix + BOR_General_Err + 1;

  {Shipping Method}
  BOR_ShippingMethod_Prefix = 3100;
  BOR_ShippingMethod_MethodBlank = BOR_ShippingMethod_Prefix + BOR_General_Err + 1;

  {Tax Code}
  BOR_TaxCode_Prefix = 3200;
  BOR_TaxCode_NameBlank       = BOR_TaxCode_Prefix + BOR_General_Err + 1;


  {Tax Code}
  BOR_Journal_Prefix = 3300;
  BOR_Journal_ClientBlank       = BOR_Journal_Prefix + BOR_General_Err + 1;

  { Business Object Result Status codes}
  BORSCode_No_Data = 1;




resourcestring
  { XML Constants }
  XMLDocVersion         = '1.0';
  XMLDOCANSIEncoding    = 'windows-1252';
  XMLDocEncoding        = 'UTF-8';
  XMLDocRoot            = 'ERP1XML';
  XMLDocRequest         = 'ERPXMLRequest';
  IDTagInXML            = 'id';
  XMLNodeNameTagInXML   = 'xmlnodename';
  busobjTypeDesTagInXML = 'ERPObjTypeDescription';
  GlobalRefTagInXML     = 'globalref';
  XMLDocRequestStopError= 'Stop';
  XMLDocRequestIgnoreError= 'Ignore';
  XMLCommandNew         = 'Add';
  XMLCommandUpdate      = 'Update';
  XMLCommandModify      = 'Edit';
  XMLCommandDelete      = 'Delete';
  XMLCommandRestore     = 'Restore';
  XMLCommandExport      = 'Export';
  XMLCommandSetFieldList ='SetFieldList';
  XMLImportResponse     = 'XMLImportResponse.XML';
  XMLDocResponseRoot    = 'ERPXMLImportResponse';

  { Business Objects Events }
  BusObjEvent_Change              = 'BusObjEvent_Change';
  BusObjEvent_Cancelchange        = 'BusObjEvent_Cancelchange';
  BusObjEvent_FieldChange         = 'BusObjEvent_FieldChange';
  BusObjEvent_Error               = 'BusObjEvent_Error';
  BusObjEvent_Warning             = 'BusObjEvent_Warning';
  BusObjEvent_Dataset             = 'BusObjEvent_Dataset';
  BusObjEvent_OnDataIDChange      = 'BusObjEvent_OnDataIDChange';
  BusObjEvent_OpenInvForm         = 'BusObjEvent_OpenInvForm';
  BusObjEvent_OpenSOForm          = 'BusObjEvent_OpenSOForm';
  BusobjEvent_ToDo                = 'BusobjEvent_ToDo';
  BusobjEvent_Event               = 'BusobjEvent_Event';
  BusObjEvent_Log                 = 'BusObjEvent_Log';
  BusobjEvent_MsgLog              = 'BusobjEvent_MsgLog';
  BusobjEvent_EmptyRecDelete      = 'BusobjEvent_EmptyRecDelete';
  BusobjEvent_ChooseEquip         = 'BusobjEvent_ChooseEquip';
  BusobjEvent_ChooseRelatedParts  = 'BusobjEvent_ChooseRelatedParts';
  BusobjEvent_check4FieldErrorMsg = 'BusobjEvent_check4FieldErrorMsg';
  BusObjEvent_GUIFocusField       = 'BusObjEvent_GUIFocusField';
  BusObjEvent_ResourceCapacity    = 'BusObjEvent_ResourceCapacity';
  BusObjEvent_ResourceCount       = 'BusObjEvent_ResourceCount';
  BusObjEvent_ResourceName        = 'BusObjEvent_ResourceName';
  BusObjEvent_InvoiceCommentPopUp = 'BusObjEvent_InvoiceCommentPopUp';
  BusObjEvent_POCommentPopUp      = 'BusObjEvent_POCommentPopUp';
  BusobjEvent_OnCreate            = 'BusobjEvent_OnCreate';
  BusobjEvent_OnREdUserLock       = 'BusobjEvent_OnREdUserLock';

  { user messages, event value will be the actual message to display }
  BusObjEvent_UserErrorMessage    = 'BusObjEvent_UserErrorMessage';
  BusObjEvent_UserWarningMessage  = 'BusObjEvent_UserWArningMessage';
  BusObjEvent_UserInfoMessage     = 'BusObjEvent_UserInfoMessage';


  { Business Objects Event Values }
  BusObjEventVal                            ='BusObjEventVal';
  BusObjEventCall                           ='BusObjEventCall';
  BusObjEventVal_TotalHours                 ='BusObjEventVal_TotalHours';
  Busobjeventval_LeaveDate                  ='Busobjeventval_LeaveDate';
  BusObjEventVal_MissingTenderAccounts      = 'BusObjEventVal_MissingTenderAccounts';
  BusObjEventVal_ProgressPaymenttype        ='BusObjEventVal_ProgressPaymenttype';
  BusObjEventVal_QtyShipped                 = 'BusObjEventVal_QtyShipped';
  BusObjEvent_CheckDescriptionField         = 'BusObjEvent_CheckDescriptionField';
  BusObjEvent_OnTreeCreated                 = 'BusObjEvent_OnTreeCreated';
  BusObjEventVal_Rate                       = 'BusObjEventVal_Rate';
  BusObjEventVal_Qty                        = 'BusObjEventVal_Qty';
  BusObjEventVal_Equipment                  = 'BusObjEventVal_Equipment';
  BusObjEventVal_Manufacture                = 'BusObjEventVal_Manufacture';
  BusObjEventVal_QtySold                    = 'BusObjEventVal_QtySold';
  BusObjEventVal_Taskno                     = 'BusObjEventVal_Taskno';
  BusObjEventVal_ShippingTreeItem           = 'BusObjEventVal_ShippingTreeItem';
  BusObjEventVal_TransQtyChanged            = 'BusObjEventVal_TransQtyChanged';
  BusObjEventVal_TaxcodeLocationChanged     = 'BusObjEventVal_TaxcodeLocationChanged';
  BusObjEventVal_CreationDate               = 'BusObjEventVal_CreationDate';
  BusObjEventVal_OrderTotalsCalculated      = 'BusObjEventVal_OrderTotalsCalculated';
  BusObjEventVal_ProductChanged             = 'BusObjEventVal_ProductChanged';
  BusObjEventVal_OnProductChange            = 'BusObjEventVal_OnProductChange';
  BusObjEventVal_OpenLookuponProductChange  = 'BusObjEventVal_OpenLookuponProductChange';
  BusObjEventVal_UOMChanged                 = 'BusObjEventVal_UOMChanged';
  BusObjEventVal_OnUOMChange                = 'BusObjEventVal_OnUOMChange';
  BusObjEventVal_SalesLineCost              = 'BusObjEventVal_SalesLineCost';
  BusObjEventVal_ResStats                   = 'BusObjEventVal_ResStats';
  BusObjEventVal_SalvageType                = 'BusObjEventVal_SalvageType';
  BusObjEventVal_SalvageType2               = 'BusObjEventVal_SalvageType2';
  BusObjEventVal_AssetName                  = 'BusObjEventVal_AssetName';
  BusObjEventVal_BoxesShipped               = 'BusObjEventVal_BoxesShipped';
  BusObjEvent_onauditTrail									= 'BusObjEvent_onauditTrail';
  BusObjEventVal_StartDateTime              = 'BusObjEventVal_StartDateTime';
  BusObjEventVal_EndDateTime                = 'BusObjEventVal_EndDateTime';

  BusObjEvent_PercentageCostTotal_Invalid   = 'BusObjEvent_PercentageCostTotal_Invalid';
  BusObjEvent_PercentageDeprTotal_Invalid   = 'BusObjEvent_PercentageDeprTotal_Invalid';
  BusObjEvent_FA_DepAcc1_Invalid            = 'BusObjEvent_FA_DepAcc1_Invalid';
  BusObjEvent_FA_DepAcc2_Invalid            = 'BusObjEvent_FA_DepAcc2_Invalid';
  BusObjEvent_CUSTFLD1_Invalid              = 'BusObjEvent_CUSTFLD1_Invalid';
  BusObjEvent_CUSTFLD2_Invalid              = 'BusObjEvent_CUSTFLD2_Invalid';
  BusObjEvent_CUSTFLD3_Invalid              = 'BusObjEvent_CUSTFLD3_Invalid';
  BusObjEvent_CUSTFLD4_Invalid              = 'BusObjEvent_CUSTFLD4_Invalid';
  BusObjEvent_CUSTFLD5_Invalid              = 'BusObjEvent_CUSTFLD5_Invalid';
  BusObjEvent_CUSTFLD6_Invalid              = 'BusObjEvent_CUSTFLD6_Invalid';
  BusObjEvent_CUSTFLD7_Invalid              = 'BusObjEvent_CUSTFLD7_Invalid';
  BusObjEvent_CUSTFLD8_Invalid              = 'BusObjEvent_CUSTFLD8_Invalid';
  BusObjEvent_CUSTFLD9_Invalid              = 'BusObjEvent_CUSTFLD9_Invalid';
  BusObjEvent_CUSTFLD10_Invalid             = 'BusObjEvent_CUSTFLD10_Invalid';
  BusObjEvent_CUSTFLD11_Invalid             = 'BusObjEvent_CUSTFLD11_Invalid';
  BusObjEvent_CUSTFLD12_Invalid             = 'BusObjEvent_CUSTFLD12_Invalid';
  BusObjEvent_CUSTFLD13_Invalid             = 'BusObjEvent_CUSTFLD13_Invalid';
  BusObjEvent_CUSTFLD14_Invalid             = 'BusObjEvent_CUSTFLD14_Invalid';
  BusObjEvent_CUSTFLD15_Invalid             = 'BusObjEvent_CUSTFLD15_Invalid';
  BusObjEvent_CUSTFLD16_Invalid             = 'BusObjEvent_CUSTFLD16_Invalid';
  BusObjEvent_CUSTFLD17_Invalid             = 'BusObjEvent_CUSTFLD17_Invalid';
  BusObjEvent_CUSTFLD18_Invalid             = 'BusObjEvent_CUSTFLD18_Invalid';
  BusObjEvent_DoCalc                        = 'BusObjEvent_DoCalc';

  BusObjEventVal_DeptChanged                = 'BusObjEventVal_DeptChanged';
  BusObjEventVal_StsPhaseChanged            = 'BusObjEventVal_StsPhaseChanged';
  BusObjEventVal_tillChanged                = 'BusObjEventVal_tillChanged';
  BusObjEventVal_FCChanged                  = 'BusObjEventVal_FCChanged';
  BusObjEventVal_Changed                    = 'BusObjEventVal_Changed';
  BusObjEventVal_SupplierChanged            = 'BusObjEventVal_SupplierChanged';
  BusObjEventVal_CustomerChanged            = 'BusObjEventVal_CustomerChanged';
  BusobjEventVal_ChooseAlternateProduct     = 'BusobjEventVal_ChooseAlternateProduct';
  BusObjEventVal_MarketingcontactChanged    = 'BusObjEventVal_MarketingcontactChanged';
  BusObjEventVal_SpecialPrice               = 'BusObjEventVal_SpecialPrice';
  BusObjEventVal_ToID                       = 'BusObjEventVal_ToID';
  BusObjEventVal_contacttype                = 'BusObjEventVal_contacttype';
  BusObjEventVal_Converted                  = 'BusObjEventVal_Converted';
  BusObjEventVal_ReferenceNo                = 'BusObjEventVal_ReferenceNo';
  BusObjEventVal_Error                      = 'BusObjEventVal_Error';
  BusObjEventVal_Warn                       = 'BusObjEventVal_Warn';
  BusObjEventVal_Info                       = 'BusObjEventVal_Info';
  BusObjEventVal_ProductID                  = 'BusObjEventVal_ProductID';
  BusObjEventVal_Hiredate                   = 'BusObjEventVal_Hiredate';
  BusObjEventVal_status                     = 'BusObjEventVal_status';
  BusObjEventVal_Duration                   = 'BusObjEventVal_Duration';
  BusObjEventVal_DurationReplaced           = 'BusObjEventVal_DurationReplaced';
  BusObjEventVal_InitDurationfromMinimum    = 'BusObjEventVal_InitDurationfromMinimum';
  BusObjEventVal_EstimateDuration           = 'BusObjEventVal_EstimateDuration';
  BusobjEventVal_StockAdjustQtyFldchanged   = 'BusobjEventVal_StockAdjustQtyFldchanged';
  BusObjEventVal_convertToinvoice           = 'BusObjEventVal_convertToinvoice';
  BusobjEvent_Invoicestatus                 = 'BusobjEvent_Invoicestatus';
  BusObjEventVal_LineDeleted                = 'BusObjEventVal_LineDeleted';
  BusObjEventVal_Deleted                    = 'BusObjEventVal_Deleted';
  BusObjEventVal_Approved                   = 'BusObjEventVal_Approved';
  BusObjEventVal_EmptyAccount               = 'BusObjEventVal_EmptyAccount';
  BusObjEventVal_AccountSameAsHeader        = 'BusObjEventVal_AccountSameAsHeader';
  BusObjEventVal_ClientID                   = 'BusObjEventVal_ClientID';
  BusObjEventVal_AccountID                  = 'BusObjEventVal_AccountID';
  BusObjEventVal_Terms                      = 'BusObjEventVal_Terms';
  BusObjEventVal_FC                         = 'BusObjEventVal_FC';
  BusObjEventVal_class                      = 'BusObjEventVal_Class';
  BusObjEvent_AssignDataset                 = 'BusObjEvent_assignDataset';
  BusObjEvent_BeforeInsert                  = 'BusObjEvent_Beforeinsert';
  BusObjEvent_AfterInsert                   = 'BusObjEvent_AfterInsert';
  BusObjEvent_CalcFields                    = 'BusObjEvent_CalcFields';
  BusObjEventDataset_AfterClose             = 'BusObjEventDataset_AfterClose';
  BusObjEventDataset_BeforeClose            = 'BusObjEventDataset_BeforeClose';
  BusObjEvent_IDChanged                     = 'BusObjEvent_IDChanged';
  BusObjEvent_BeforeIDChanged               = 'BusObjEvent_BeforeIDChanged';
  BusobjEventVal_TerminateETPFldchanged     = 'BusobjEventVal_TerminateETPFldchanged';
  BusobjEventVal_TerminateEmpNamechanged    = 'BusobjEventVal_TerminateEmpNamechanged';
  BusobjEventVal_HandleIncompleteRecord     = 'BusobjEventVal_HandleIncompleteRecord';
  BusobjEventVal_HandleIncompletePayRate    = 'BusobjEventVal_HandleIncompletePayRate';
  BusobjEventVal_HandleNewLeaveType         = 'BusobjEventVal_HandleNewLeaveType';
  BusobjEventVal_HandleNewPayRate           = 'BusobjEventVal_HandleNewPayRate';
  BusobjEventVal_HandleEmployeeReEmploy     = 'BusobjEventVal_HandleEmployeeReEmploy';
  BusobjEventVal_HandleResetFocus           = 'BusobjEventVal_HandleResetFocus';
  BusobjEventVal_HandleDeletedTermination   = 'BusobjEventVal_HandleDeletedTermination';
  BusobjEventVal_HandleDeleteDialog         = 'BusobjEventVal_HandleDeleteDialog';
  BusobjEventVal_HandleCalcByConflict       = 'BusobjEventVal_HandleCalcByConflict';
  BusobjEventVal_HandleNoAllowanceBasedOn   = 'BusobjEventVal_HandleNoAllowanceBasedOn';
  BusobjEventVal_AddToEFT                   = 'BusobjEventVal_AddToEFT';
  BusObjEventVal_Pay_ManualTax              = 'BusObjEventVal_Pay_ManualTax';
  BusObjEventVal_Pay_TaxAllowanceQty        = 'BusObjEventVal_Pay_TaxAllowanceQty';
  BusObjEventVal_ProductBinNotFound         = 'BusObjEventVal_ProductBinNotFound';
  BusObjEventVal_BankSplitsError            = 'BusObjEventVal_BankSplitsError ';
  BusObjEventVal_AtrribGrp_New              = 'BusObjEventVal_AtrribGrp_New';
  BusobjEventVal_ForAllEmployees            = 'BusobjEventVal_ForAllEmployees';
  BusobjEventVal_EmptyTrainingroster        = 'BusobjEventVal_EmptyTrainingroster';
  BusobjEventVal_ResetName                  = 'BusobjEventVal_ResetName';
  BusObjEventVal_ShipAllFormula             = 'BusObjEventVal_ShipAllFormula';
  BusObjEventVal_ShipAllQty                 = 'BusObjEventVal_ShipAllQty';
  BusObjEventVal_Employee                   = 'BusObjEventVal_Employee';
  BusObjEventVal_SaveValidate               = 'BusObjEventVal_SaveValidate';
  BusObjEventVal_OnAfterSave                = 'BusObjEventVal_OnAfterSave';
  BusObjEventVal_OnBeforeSave               = 'BusObjEventVal_OnBeforeSave';
  BusObjEventVal_OnAfterCancel              = 'BusObjEventVal_OnAfterCancel';
  BusObjEventVal_OnAfterPrint               = 'BusObjEventVal_OnAfterPrint';
  BusObjEventVal_OnAfteremail               = 'BusObjEventVal_OnAfteremail';
  BusObjEventVal_StowedQty                  = 'BusObjEventVal_StowedQty';
  BusobjEventVal_InternalOrder              = 'BusobjEventVal_InternalOrder';
  BusObjEventVal_maincontactDisabled        = 'BusObjEventVal_maincontactDisabled';
  BusobjEventVal_applied                    = 'BusobjEventVal_applied';
  BusObjEventDataset_AfterOpen              = 'BusObjEventDataset_AfterOpen';
  BusObjEventDataset_AfterInsert            = 'BusObjEventDataset_AfterInsert';
  BusObjEventDataset_BeforeOpen             = 'BusObjEventDataset_BeforeOpen';
  BusObjEventDataset_AfterPost              = 'BusObjEventDataset_AfterPost';
  BusObjEventDataset_AfterPostNew           = 'BusObjEventDataset_AfterPostNew';
  BusObjEventDataset_BeforePostNew          = 'BusObjEventDataset_BeforePostNew';
  BusObjEventDataset_BeforePost             = 'BusObjEventDataset_BeforePost';
  BusObjEventDataset_dataIdchange_dcLoad    = 'BusObjEventDataset_dataIdchange_dcLoad';
  BusObjEventDataset_dataIdchange_dcDelete  = 'BusObjEventDataset_dataIdchange_dcDelete';
  BusObjEventDataset_dataIdchange_dcNew     = 'BusObjEventDataset_dataIdchange_dcNew';
  BusObjEventDataset_dataIdchange_dcSave    = 'BusObjEventDataset_dataIdchange_dcSave';
  BusObjEventDataset_dataIdchange_dcClose   = 'BusObjEventDataset_dataIdchange_dcClose';
  BusObjEventDataset_beforedataIdchange     = 'BusObjEventDataset_beforedataIdchange';
  BusobjEventVal_ProductPriceCalctype       = 'BusobjEventVal_ProductPriceCalctype';
  BusobjEventVal_GrossMarginFixed           = 'BusobjEventVal_GrossMarginFixed';
  BusobjEvent_IteratereRecords              = 'BusobjEvent_IteratereRecords';
  BusobjEvent_IteratereRecordLoop           = 'BusobjEvent_IteratereRecordLoop';
  BusobjEvent_IteratereRecordDone           = 'BusobjEvent_IteratereRecordDone';
  BusObjEvent_ReadTreePartSourceforSales    = 'BusObjEvent_ReadTreePartSourceforSales';
  BusObjEvent_TreePartSourcefromstockforSales='BusObjEvent_TreePartSourcefromstockforSales';
  BusobjEventVal_IsPercentage               = 'BusobjEventVal_IsPercentage';
  BusObjEvent_SearchProductID               = 'BusObjEvent_SearchProductID';
  BusObjEvent_SearchDepartmentId            = 'BusObjEvent_SearchDepartmentId';
  //BusObjEventVal_Approved                   = 'BusObjEventVal_Approved';
  BusObjEvent_TotalsChanged                 = 'BusObjEvent_TotalsChanged';
  BusObjEvent_Approved                      = 'BusObjEvent_Approved';
  BusObjEvent_QtyChanged                    = 'BusObjEvent_QtyChanged';
  BusObjEvent_CustFld1Changed               = 'BusObjEvent_CustFld1Changed';
  BusObjEvent_CustFld4Changed               = 'BusObjEvent_CustFld1Changed';
  BusObjEvent_CustFld6Changed               = 'BusObjEvent_CustFld6Changed';
  BusObjEvent_CUSTFLD7Changed               = 'BusObjEvent_CUSTFLD7Changed';
  BusObjEvent_PaymentRefno                  = 'BusObjEvent_PaymentRefno';
  BusObjEvent_AccountName                   = 'BusObjEvent_AccountName';
  BusObjEvent_NoUnprocessedPay              = 'BusObjEvent_NoUnprocessedPay';
  BusObjEvent_PromptBarCode                 = 'BusObjEvent_PromptBarCode';
  BusobjEvent_CustomerinRepair              = 'BusobjEvent_CustomerinRepair';
  BusobjEvent_Repairstatus                  = 'BusobjEvent_Repairstatus';
  BusobjEvent_RepairDone                    = 'BusobjEvent_RepairDone';
  BOR_CommitValidationFailed                = 'BOR_CommitValidationFailed';
  BusobjEvent_ProgressbarProgress           = 'BusobjEvent_ProgressbarProgress';
  BusobjEvent_ShowProgressbar               = 'BusobjEvent_ShowProgressbar';
  BusobjEvent_HideProgressbar               = 'BusobjEvent_HideProgressbar';
  BusobjEvent_AddingRelatedParts            = 'BusobjEvent_AddingRelatedParts';
  BusobjEvent_AutosplitQty                  = 'BusobjEvent_AutosplitQty';
//  BusobjEvent_Openshipments               = 'BusobjEvent_Openshipments';
  BusobjEvent_closeBarcodeSummary           = 'BusobjEvent_closeBarcodeSummary';
  BusobjEvent_AddRelatedParts               = 'BusobjEvent_AddRelatedParts';
  BusobjEvent_AddedRelatedParts             = 'BusobjEvent_AddedRelatedParts';
  BusobjEvent_CalcAvaTax                    = 'BusobjEvent_CalcAvaTax';
  BusobjEvent_AddRelatedPartsDone           = 'BusobjEvent_AddRelatedPartsDone';
  (*BusobjEvent_ProgressbarShowsub          ='BusobjEvent_ProgressbarShowsub';*)
  (*BusobjEvent_ProgressbarStepsub          ='BusobjEvent_ProgressbarStepsub';*)
  BusobjEvent_CalculationsDisabled          = 'BusobjEvent_CalculationsDisabled';
  BusObjEvent_ActionTypeChanged             = 'BusObjEvent_ActionTypeChanged';
  BusObjEvent_NewLeadActionRecord           = 'BusObjEvent_NewLeadActionRecord';
  BusObjEvent_NewLeadActionRecordCreated    = 'BusObjEvent_NewLeadActionRecordCreated';
  BusObjEvent_NewLeadAppointmentRecord      = 'BusObjEvent_NewLeadAppointmentRecord';
(*  BusObjEvent_start_time                    = 'BusObjEvent_start_time';
  BusObjEvent_End_time                      = 'BusObjEvent_End_time';*)
  BusObjEvent_POLineClassChanged            = 'BusObjEvent_POLineClassChanged';
  BusObjEvent_DatetimeChanged               = 'BusObjEvent_DatetimeChanged';
  BusObjEvent_RepServiceCreate              = 'BusObjEvent_RepServiceCreate';
  BusObjEvent_OnCalcOrderTotals             = 'BusObjEvent_OnCalcOrderTotals';
  BusObjEvent_CostRecalculateonQtychange    = 'BusObjEvent_CostRecalculateonQtychange';
  BusObjEvent_ContributionAmountChanged     = 'BusObjEvent_ContributionAmountChanged';
  BusObjEvent_TrainerChanged                = 'BusObjEvent_TrainerChanged';
  BusObjEventVal_Total                      = 'BusObjEventVal_Total';
  BusObjEventVal_PayMethod                  = 'BusObjEventVal_PayMethod';
  BusObjEvent_TimesheetAdded                = 'BusObjEvent_TimesheetAdded';
  BusObjEvent_DupWorkOrderCouponID          = 'BusObjEvent_DupWorkOrderCouponID';
  BusobjEvent_IDChange                      = 'BusobjEvent_IDChange';
  BusobjEvent_DateRangeChange               = 'BusobjEvent_DateRangeChange';
  BusobjEvent_CheckTreeSubNodes             = 'BusobjEvent_CheckTreeSubNodes';
  BusObjEvent_PartBarcodeNotfound           = 'BusObjEvent_PartBarcodeNotfound';
  BusObjEvent_POETADateChanged              = 'POLineETAMatchedWithHeader';
  BusObjEvent_POLinesETADateChanged         = 'BusObjEvent_POLinesETADateChanged';
  BusobjProcessPQADetailClasses             = 'ProcessPQADetailClasses';
  BusobjEvent_checkHireQtyAvailability      = 'BusobjEvent_CheckHireQtyAvailability';
  BusObjEventVal_HireAssetID                = 'BusObjEventVal_HireAssetID';
  BusObjEvent_BlankAccount                  = 'BusObjEvent_BlankAccount';
  BusobjEvent_onFinaliseOrder               = 'BusobjEvent_onFinaliseOrder';
  BusObjEvent_CustPayCreatedForInvoice      = 'BusObjEvent_CustPayCreatedForInvoice';

  BusobjEvent_Function_Failed                   = 'BusobjEvent_Function_Failed';
  BusobjEventVal_FailedValidateData             = 'BusobjEventVal_FailedValidateData';
  BusobjEventVal_FailedPOValidateData           = 'BusobjEventVal_FailedPOValidateData';
  BusobjEventVal_FailedAddressValidateData      = 'BusobjEventVal_FailedAddressValidateData';
  BusobjEventVal_FailedAllowancesValidateData   = 'BusobjEventVal_FailedAllowancesValidateData';
  BusobjEventVal_FailedBankingValidateData      = 'BusobjEventVal_FailedBankingValidateData';
  BusobjEventVal_FailedCommissionValidateData   = 'BusobjEventVal_FailedCommissionValidateData';
  BusobjEventVal_FailedCustom_FieldsValidateData= 'BusobjEventVal_FailedCustom_FieldsValidateData';
  BusobjEventVal_FailedDeductionsValidateData   = 'BusobjEventVal_FailedDeductionsValidateData';
  BusobjEventVal_FailedDocumentsValidateData    = 'BusobjEventVal_FailedDocumentsValidateData';
  BusobjEventVal_FailedHoursValidateData        = 'BusobjEventVal_FailedHoursValidateData';
  BusobjEventVal_FailedInformationValidateData  = 'BusobjEventVal_FailedInformationValidateData';
  BusobjEventVal_FailedLeavesValidateData       = 'BusobjEventVal_FailedLeavesValidateData';
  BusobjEventVal_FailedPay_DetailsValidateData  = 'BusobjEventVal_FailedPay_DetailsValidateData';
  BusobjEventVal_FailedPay_HistoryValidateData  = 'BusobjEventVal_FailedPay_HistoryValidateData';
  BusobjEventVal_FailedPay_NotesValidateData    = 'BusobjEventVal_FailedPay_NotesValidateData';
  BusobjEventVal_FailedPhoto_IDValidateData     = 'BusobjEventVal_FailedPhoto_IDValidateData';
  BusobjEventVal_FailedReportValidateData       = 'BusobjEventVal_FailedReportValidateData';
  BusobjEventVal_FailedTaxationValidateData     = 'BusobjEventVal_FailedTaxationValidateData';
  BusobjEventVal_FailedWorkcoverValidateData    = 'BusobjEventVal_FailedWorkcoverValidateData';
  BusobjEventVal_FailedSundriesValidateData     = 'BusobjEventVal_FailedSundriesValidateData';
  BusobjEventVal_FailedEmployeePayValidateData  = 'BusobjEventVal_FailedEmployeePayValidateData';
  BusobjEventVal_FailedEmpServicesValidateData  = 'BusobjEventVal_FailedEmpServicesValidateData';
  BusobjEventVal_StockAdjustproduct             = 'BusobjEventVal_StockAdjustproduct';
  BusobjEventVal_SalesDiscountApplied           = 'BusobjEventVal_SalesDiscountApplied';
  BusobjEventVal_PurchaseDiscountApplied        = 'BusobjEventVal_PurchaseDiscountApplied';
  BusobjEventVal_ClientUserLockFail             ='BusobjEventVal_ClientUserLockFail';
  BusObjProcTreePartWrongProduct                = 'BusObjProcTreePartWrongProduct';
  BusobjEventVal_OrderQtyLessThanSuppMinOrderQty= 'BusobjEventVal_OrderQtyLessThanSuppMinOrderQty';
  BusobjEventVal_BOMqtyonNonBOMProduct          = 'BusobjEventVal_BOMqtyonNonBOMProduct';
  BusobjEventVal_ConvertedSOLnotEditable        = 'BusobjEventVal_ConvertedSOLnotEditable';
  BusobjEventVal_StopCredit                     = 'BusobjEventVal_StopCredit';
  busobjeventval_checkforStockinOtherDept       = 'busobjeventval_checkforStockinOtherDept';
  BusobjEventVal_FailedLandedCostValidation     = 'BusobjEventVal_BusobjEventVal_FailedLandedCostValidation';
  BusobjEventVal_HireLineQtyUnavailable         = 'BusobjEventVal_HireLineQtyUnavailable';
  BusObjEventVal_FormulaValue                   = 'BusObjEventVal_FormulaValue';
  BusObjEventVal_FormulaId                      = 'BusObjEventVal_FormulaId';
  BusObjEventVal_FormulaType                    = 'BusObjEventVal_FormulaType';
  BusObjEventVal_DuplicateDescription           = 'BusObjEventVal_DuplicateDescription';
  BusObjEventVal_DuplicateProduct               = 'BusObjEventVal_DuplicateProduct';
  BusObjEventVal_Sales_Warn_CreditExceeded      = 'Sales_Warn_CreditExceeded';
  BusObjEventVal_Warn_ZeroLineQty               = 'Warn_ZeroLineQty';
  BusObjEventVal_BeforeRefreshGuiLines          = 'BusObjEventVal_BeforeRefreshGuiLines';
  BusObjEventVal_AfterRefreshGuiLines           = 'BusObjEventVal_AfterRefreshGuiLines';
  BusObjEvent_CrosscompanySaleCreated           = 'BusObjEvent_CrosscompanySaleCreated';
  BusObjEvent_POShipToClass                     = 'BusObjEvent_POShipToClass';
  BusObjEvent_POShipTo                          = 'BusObjEvent_POShipTo';
  BusObjEventCall_RenewLicense                  = 'BusObjEventCall_RenewLicense';
  BusObjEvent_PickupFrom                        = 'BusObjEvent_PickupFrom';


  BusobjEvent_ShowCustomizableInvociedatefield    = 'BusobjEvent_ShowCustomizableInvociedatefield';
  BusobjEvent_ShowCustomizableInvocieTextfield    = 'BusobjEvent_ShowCustomizableInvocieTextfield';
  BusObjEventVal_Marketingcontact_ClientSelected  = 'BusObjEventVal_Marketingcontact_ClientSelected';
  BusobjEventVal_FailedFringe_BenefitsValidateData= 'BusobjEventVal_FailedFringe_BenefitsValidateData';
  BusobjEventVal_FailedSuperannuationValidateData = 'BusobjEventVal_FailedSuperannuationValidateData';
  BusobjEventVal_ApproverID       = 'BusobjEventVal_ApproverID';
  BusObjEventVal_sts_Indica       = 'BusObjEventVal_sts_Indica';
  BusObjEventVal_sts_Sativa       = 'BusObjEventVal_sts_Sativa';
  BusObjEvent_StSTAgClassChanged  = 'BusObjEvent_StSTAgClassChanged';
  BusObjEvent_StSDupHarvestName   = 'BusObjEvent_StSDupHarvestName';
  BusObjEvent_StSHarvestDept      = 'BusObjEvent_StSHarvestDept';
  BusObjEvent_StsProductId        = 'BusObjEvent_StsProductId';
  BusObjEvent_StsStrain           = 'BusObjEvent_StsStrain';

  {NDS Tree related}
  Storer_Save ='Storer_Save';
  Storer_Delete ='Storer_Delete';


implementation

end.

