unit EmployeeAccesses;

interface

function EmployeeHasAccess(Const AccessFor :String) :Boolean;
function CanAlterRefinsupPayment                    :Boolean ;
function CanRecalculateBOMcostnPriceinUpdateBatch   :Boolean ;
function CanShowProgressBuildReport                 :Boolean ;
function AllowFinaliseFromProgressbuild             :Boolean ;
function CanShowBatchetailsinProgressBuild          :Boolean ;
function changeTermsInvoice                         :Boolean ;
function changeTermsSalesOrder                      :Boolean ;
function ChooseTemplate_Invoice                     :Boolean ;
function ChooseTemplate_Quote                       :Boolean ;
function ChooseTemplate_SalesOrder                  :Boolean ;
function HasAccessToCustomerClass                   :Boolean ;
function CanChangeCustomerRep                       :Boolean;
function CanAddToEFT                                :Boolean ;
function AllowAddNewInEnglish                       :Boolean ;
function AllowDeleteinPOS                           :Boolean ;
function AllowInvoiceStockToNegative                :Boolean ;
function AllowPOInvoicedatefuture                   :Boolean ;
function CanApproveTran                             :Boolean ;
function canAuditTrail                              :Boolean ;
function CanBackup                                  :Boolean ;
function CanCalcSalescommission                     :Boolean ;
function CanApproveInvoice                          :Boolean ;
function CanApproveQuote                            :Boolean ;
function CanApproveRepairForInvoicing               :Boolean ;
function CanApproveSalesOrder                       :Boolean ;
function CanChangeCustomerTerms                     :Boolean ;
function CanChangeTermsinRepairs                    :Boolean ;
function CanCloseMessage                            :Boolean ;
function CanCopyInvoice                             :Boolean ;
function CancopySalesOrder                          :Boolean ;
function CanCreateSalesCategory                     :Boolean ;
function CanCreateSalesStatus                       :Boolean ;
function CanDeliverQuote                            :Boolean ;
function CanDeliverSalesOrder                       :Boolean ;
function CanPrepareInvoice                          :Boolean ;
function CanStopAnyManufacturingJob                 :Boolean ;
function CanUpdateTrainingstatus                    :Boolean ;
function CanViewTillsummaryOfAllDepartments         :Boolean ;
function CanChangeClass                             :Boolean ;
function CanChangeClosingDate                       :Boolean ;
function CanChangeDeptSales                         :Boolean ;
function CanChangeHoldSale                          :Boolean ;
function CanChangePayrollAccess                     :Boolean ;
function CanChangeSalesOrderStatus                  :Boolean ;
function CanCopy                                    :Boolean ;
function CanCloneNonERP                             :Boolean ;
function CanCreditOverride                          :Boolean ;
function CanCustomerAccountNoSetup                  :Boolean ;
function CanCustomiseCalendar                       :Boolean ;
function CanDolDisc                                 :Boolean ;
function CanDolSurch                                :Boolean ;
function CanEditPrice                               :Boolean ;
function CanEditPurchaseCost                        :Boolean ;
Function CanEditPurchaseOrderSoldQty                :Boolean ;
function CanEftCashOut                              :Boolean ;
function CanEftSettlement                           :Boolean ;
function CanEmployeeBarcode                         :Boolean ;
function CanEOP                                     :Boolean ;
function CanGiveDiscount                            :Boolean ;
function CanMakeduplicateInvoiceForrepair           :Boolean ;
function CanNewCoDatabase                           :Boolean ;
function CanNoSale                                  :Boolean ;
function CanModifySource                            :Boolean ;
function CanOverrideSmartOrdMax                     :Boolean ;
function CanPartColumnNames                         :Boolean ;
function CanPcentDiscItm                            :Boolean ;
function CanPcentDiscTot                            :Boolean ;
function CanPcentSurchItm                           :Boolean ;
function CanPcentSurchTot                           :Boolean ;
function CanPersonalPref                            :Boolean ;
function CanPONumber                                :Boolean ;
function CanPriceChange                             :Boolean ;
function CanPurchaseLines                           :Boolean ;
function CanQuoteToInvoice                          :Boolean ;
function CanRefund                                  :Boolean ;
function CanRemove                                  :Boolean ;
function CanRepairNumber                            :Boolean ;
function CanRestore                                 :Boolean ;
function CanRunBatch                                :Boolean ;
function CanChangeSaleNumber                        :Boolean ;
function CanSeeCreditCards                          :Boolean ;
function CanShowMargin                              :Boolean ;
function CanSOToInvoice                             :Boolean ;
function CanSupportLogInvoice                       :Boolean ;
function CanTaxcodeLocations                        :Boolean ;
function AllowPrintInvoiceduplicate                 :Boolean ;
function AllowChangingProdutTaxCodeinSales          :Boolean ;
function AllowChangingProdutUOMinSales              :Boolean ;
function AllowFullconvertofIncompleteOrder          :Boolean ;
function CanShowCustomerAttachments                 :Boolean ;
function CanShowSupplierAttachments                 :Boolean ;

implementation

uses AppEnvironment;
function EmployeeHasAccess(Const AccessFor:String)  :Boolean;begin Result := AppEnv.AccessLevels.GetEmployeeAccessLevel(AccessFor) = 1 ;end;
function CanAlterRefinsupPayment                    :Boolean;begin Result := EmployeeHasAccess('CanAlterRefinsupPayment');end;
function CanRecalculateBOMcostnPriceinUpdateBatch   :Boolean;begin Result := EmployeeHasAccess('CanRecalculateBOMcostnPriceinUpdateBatch');end;
function CanShowProgressBuildReport                 :Boolean;begin Result := EmployeeHasAccess('CanShowProgressBuildReport');end;
function AllowFinaliseFromProgressbuild             :Boolean;begin Result := EmployeeHasAccess('AllowFinaliseFromProgressbuild');end;
function CanShowBatchetailsinProgressBuild          :Boolean;begin Result := EmployeeHasAccess('CanShowBatchetailsinProgressBuild');end;
function changeTermsInvoice                         :Boolean;begin Result := EmployeeHasAccess('change Terms-Invoice');end;
function changeTermsSalesOrder                      :Boolean;begin Result := EmployeeHasAccess('change Terms-Sales Order');end;
function ChooseTemplate_Invoice                     :Boolean;begin Result := EmployeeHasAccess('ChooseTemplate-Invoice');end;
function ChooseTemplate_Quote                       :Boolean;begin Result := EmployeeHasAccess('ChooseTemplate-Quote');end;
function ChooseTemplate_SalesOrder                  :Boolean;begin Result := EmployeeHasAccess('ChooseTemplate-Sales Order');end;
function HasAccessToCustomerClass                   :Boolean;begin Result := EmployeeHasAccess('FnAccessToCustomerClass');end;
function CanChangeCustomerRep                       :Boolean;begin Result := EmployeeHasAccess('FnCanChangeCustomerRep');end;
function CanAddToEFT                                :Boolean;begin Result := EmployeeHasAccess('FnAddToEFT');end;
function AllowAddNewInEnglish                       :Boolean;begin Result := EmployeeHasAccess('FnAllowAddNewInEnglish');end;
function AllowDeleteinPOS                           :Boolean;begin Result := EmployeeHasAccess('FnAllowDeleteinPOS');end;
function AllowInvoiceStockToNegative                :Boolean;begin Result := EmployeeHasAccess('FnAllowInvoiceStockToNegative');end;
function AllowPOInvoicedatefuture                   :Boolean;begin Result := EmployeeHasAccess('FnAllowPOInvoicedatefuture');end;
function CanApproveTran                             :Boolean;begin Result := EmployeeHasAccess('fnApproveTran');end;
function canAuditTrail                              :Boolean;begin Result := EmployeeHasAccess('FnAuditTrail');end;
function CanBackup                                  :Boolean;begin Result := EmployeeHasAccess('FnBackup');end;
function CanCalcSalescommission                     :Boolean;begin Result := EmployeeHasAccess('FnCalcSalescommission');end;
function CanApproveInvoice                          :Boolean;begin Result := EmployeeHasAccess('FnCanApproveInvoice');end;
function CanApproveQuote                            :Boolean;begin Result := EmployeeHasAccess('FnCanApproveQuote');end;
function CanApproveRepairForInvoicing               :Boolean;begin Result := EmployeeHasAccess('FnCanApproveRepairForInvoicing');end;
function CanApproveSalesOrder                       :Boolean;begin Result := EmployeeHasAccess('FnCanApproveSalesOrder');end;
function CanChangeCustomerTerms                     :Boolean;begin Result := EmployeeHasAccess('FnCanChangeCustomerTerms');end;
function CanChangeTermsinRepairs                    :Boolean;begin Result := EmployeeHasAccess('FnCanChangeTermsinRepairs');end;
function CanCloseMessage                            :Boolean;begin Result := EmployeeHasAccess('FnCanCloseMessage');end;
function CanCopyInvoice                             :Boolean;begin Result := EmployeeHasAccess('FnCanCopyInvoice');end;
function CancopySalesOrder                          :Boolean;begin Result := EmployeeHasAccess('FnCancopySalesOrder');end;
function CanCreateSalesCategory                     :Boolean;begin Result := EmployeeHasAccess('FnCanCreateSalesCategory');end;
function CanCreateSalesStatus                       :Boolean;begin Result := EmployeeHasAccess('FnCanCreateSalesStatus');end;
function CanDeliverQuote                            :Boolean;begin Result := EmployeeHasAccess('FnCanDeliverQuote');end;
function CanDeliverSalesOrder                       :Boolean;begin Result := EmployeeHasAccess('FnCanDeliverSalesOrder');end;
function CanPrepareInvoice                          :Boolean;begin Result := EmployeeHasAccess('FnCanPrepareInvoice');end;
function CanStopAnyManufacturingJob                 :Boolean;begin Result := EmployeeHasAccess('FnCanStopAnyManufacturingJob');end;
function CanUpdateTrainingstatus                    :Boolean;begin Result := EmployeeHasAccess('FnCanUpdateTrainingstatus');end;
function CanViewTillsummaryOfAllDepartments         :Boolean;begin Result := EmployeeHasAccess('FnCanViewTillsummaryOfAllDepartments');end;
function CanChangeClass                             :Boolean;begin Result := EmployeeHasAccess('FnChangeClass');end;
function CanChangeClosingDate                       :Boolean;begin Result := EmployeeHasAccess('FnChangeClosingDate');end;
function CanChangeDeptSales                         :Boolean;begin Result := EmployeeHasAccess('FnChangeDeptSales');end;
function CanChangeHoldSale                          :Boolean;begin Result := EmployeeHasAccess('FnChangeHoldSale');end;
function CanChangePayrollAccess                     :Boolean;begin Result := EmployeeHasAccess('FnChangePayrollAccess');end;
function CanChangeSalesOrderStatus                  :Boolean;begin Result := EmployeeHasAccess('FnChangeSalesOrderStatus');end;
function CanCopy                                    :Boolean;begin Result := EmployeeHasAccess('FnCopy');end;
function CanCloneNonERP                             :Boolean;begin Result := EmployeeHasAccess('FnNonERPClone');end;
function CanCreditOverride                          :Boolean;begin Result := EmployeeHasAccess('FnCreditOverride');end;
function CanCustomerAccountNoSetup                  :Boolean;begin Result := EmployeeHasAccess('FnCustomerAccountNoSetup');end;
function CanCustomiseCalendar                       :Boolean;begin Result := EmployeeHasAccess('FnCustomiseCalendar');end;
function CanDolDisc                                 :Boolean;begin Result := EmployeeHasAccess('FnDolDisc');end;
function CanDolSurch                                :Boolean;begin Result := EmployeeHasAccess('FnDolSurch');end;
function CanEditPrice                               :Boolean;begin Result := EmployeeHasAccess('FnEditPrice');end;
function CanEditPurchaseCost                        :Boolean;begin Result := EmployeeHasAccess('FnEditPurchaseCost');end;
Function CanEditPurchaseOrderSoldQty                :Boolean;begin Result := EmployeeHasAccess('FnCanEditPOSoldQty');end;
function CanEftCashOut                              :Boolean;begin Result := EmployeeHasAccess('FnEftCashOut');end;
function CanEftSettlement                           :Boolean;begin Result := EmployeeHasAccess('FnEftSettlement');end;
function CanEmployeeBarcode                         :Boolean;begin Result := EmployeeHasAccess('FnEmployeeBarcode');end;
function CanEOP                                     :Boolean;begin Result := EmployeeHasAccess('FnEOP');end;
function CanGiveDiscount                            :Boolean;begin Result := EmployeeHasAccess('FnGiveDiscount');end;
function CanMakeduplicateInvoiceForrepair           :Boolean;begin Result := EmployeeHasAccess('FnMakeduplicateInvoiceForrepair');end;
function CanNewCoDatabase                           :Boolean;begin Result := EmployeeHasAccess('FnNewCoDatabase');end;
function CanNoSale                                  :Boolean;begin Result := EmployeeHasAccess('FnNoSale');end;
function CanModifySource                            :Boolean;begin Result := EmployeeHasAccess('FnModifySource');end;
function CanOverrideSmartOrdMax                     :Boolean;begin Result := EmployeeHasAccess('FnOverrideSmartOrdMax');end;
function CanPartColumnNames                         :Boolean;begin Result := EmployeeHasAccess('FnPartColumnNames');end;
function CanPcentDiscItm                            :Boolean;begin Result := EmployeeHasAccess('FnPcentDiscItm');end;
function CanPcentDiscTot                            :Boolean;begin Result := EmployeeHasAccess('FnPcentDiscTot');end;
function CanPcentSurchItm                           :Boolean;begin Result := EmployeeHasAccess('FnPcentSurchItm');end;
function CanPcentSurchTot                           :Boolean;begin Result := EmployeeHasAccess('FnPcentSurchTot');end;
function CanPersonalPref                            :Boolean;begin Result := EmployeeHasAccess('FnPersonalPref');end;
function CanPONumber                                :Boolean;begin Result := EmployeeHasAccess('FnPONumber');end;
function CanPriceChange                             :Boolean;begin Result := EmployeeHasAccess('FnPriceChange');end;
function CanPurchaseLines                           :Boolean;begin Result := EmployeeHasAccess('FnPurchaseLines');end;
function CanQuoteToInvoice                          :Boolean;begin Result := EmployeeHasAccess('FnQuoteToInvoice');end;
function CanRefund                                  :Boolean;begin Result := EmployeeHasAccess('FnRefund');end;
function CanRemove                                  :Boolean;begin Result := EmployeeHasAccess('FnRemove');end;
function CanRepairNumber                            :Boolean;begin Result := EmployeeHasAccess('FnRepairNumber');end;
function CanRestore                                 :Boolean;begin Result := EmployeeHasAccess('FnRestore');end;
function CanRunBatch                                :Boolean;begin Result := EmployeeHasAccess('FnRunBatch');end;
function CanChangeSaleNumber                        :Boolean;begin Result := EmployeeHasAccess('FnSaleNumber');end;
function CanSeeCreditCards                          :Boolean;begin Result := EmployeeHasAccess('FnSeeCreditCards');end;
function CanShowMargin                              :Boolean;begin Result := EmployeeHasAccess('FnShowMargin');end;
function CanSOToInvoice                             :Boolean;begin Result := EmployeeHasAccess('FnSOToInvoice');end;
function CanSupportLogInvoice                       :Boolean;begin Result := EmployeeHasAccess('FnSupportLogInvoice');end;
function CanTaxcodeLocations                        :Boolean;begin Result := EmployeeHasAccess('FnTaxcodeLocations');end;
function AllowPrintInvoiceduplicate                 :Boolean;begin Result := EmployeeHasAccess('AllowPrintInvoiceduplicate');end;
function AllowChangingProdutTaxCodeinSales          :Boolean;begin Result := EmployeeHasAccess('AllowChangingProdutTaxCodeinSales');end;
function AllowChangingProdutUOMinSales              :Boolean;begin Result := EmployeeHasAccess('AllowChangingProdutUOMinSales');end;
function AllowFullconvertofIncompleteOrder          :Boolean;begin Result := EmployeeHasAccess('AllowFullconvertofIncompleteOrder');end;
function CanShowCustomerAttachments                 :Boolean;begin Result := EmployeeHasAccess('CanShowCustomerAttachments');end;
function CanShowSupplierAttachments                 :Boolean;begin Result := EmployeeHasAccess('CanShowSupplierAttachments');end;
end.

