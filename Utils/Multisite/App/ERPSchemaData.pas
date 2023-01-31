unit ERPSchemaData;

interface

const
  nl = #13#10;
  ERPSchemaText =
'{'                                                                         +nl+
'//  "ObjectsToSync":"CashSale,POSCashSale,POSSale,POSale",'                +nl+
'  "ObjectsToSync":"TCurrency,'                                             +nl+
'                        TCurrencyRateHistory,'                             +nl+
'                        TSource,'                                          +nl+
'                        TAccount,'                                         +nl+
'                        TAccountType,'                                     +nl+
'                        TClientType,'                                      +nl+
'                        TTerms,'                                           +nl+
'                        TShippingMethod,'                                  +nl+
'                        TTaxCode,'                                         +nl+
'                        TDeptClass,'                                       +nl+
'                        TSale",'                                           +nl+
'  "CashSale": { "InheritsFrom": "TSale" },'                                +nl+
'  "POSCashSale": { "InheritsFrom": "TSale" },'                             +nl+
'  "POSSale": { "InheritsFrom": "TSale" },'                                 +nl+
'  "POSale": { "InheritsFrom": "TSale" },'                                  +nl+
'  "Currency": { "InheritsFrom": "TCurrency" },'                            +nl+
'  "CurrencyRateHistory": { "InheritsFrom": "TCurrencyRateHistory" },'      +nl+
'  "Source": { "InheritsFrom": "TSource" },'                                +nl+
'  "Account": { "InheritsFrom": "TAccount" },'                              +nl+
'  "AccountType": { "InheritsFrom": "TAccountType" },'                      +nl+
'  "ClientType": { "InheritsFrom": "TClientType" },'                        +nl+
'  "Terms": { "InheritsFrom": "TTerms" },'                                  +nl+
'  "ShippingMethod": { "InheritsFrom": "TShippingMethod" },'                +nl+
'  "TaxCode": { "InheritsFrom": "TTaxCode" },'                              +nl+
'        "Class": { "InheritsFrom": "TDeptClass" },'                        +nl+
'  "TSale": {'                                                              +nl+
'    "TableName": "tblsales",'                                              +nl+
'    "IdFieldName": "saleid",'                                              +nl+
'    "LookupFields": "SaleId,GlobalRef,msTimeStamp",'                       +nl+
'    "Mappings": {'                                                         +nl+
'      "AccountId": {'                                                      +nl+
'        "ClassName": "TAccount",'                                          +nl+
'        "Field": "AccountId"'                                              +nl+
'      },'                                                                  +nl+
'      "ClientId": {'                                                       +nl+
'        "ClassName": "TCustomer",'                                         +nl+
'        "Field": "ClientId"'                                               +nl+
'      },'                                                                  +nl+
'      "ClassId": {'                                                        +nl+
'        "ClassName": "TDeptClass",'                                        +nl+
'        "Field": "ClassID"'                                                +nl+
'      },'                                                                  +nl+
'      "EmployeeId": {'                                                     +nl+
'        "ClassName": "TEmployeeDetails",'                                  +nl+
'        "Field": "EmployeeId"'                                             +nl+
'      },'                                                                  +nl+
'      "Terms": {'                                                          +nl+
'        "ClassName": "TTerms",'                                            +nl+
'        "Field": "Terms"'                                                  +nl+
'      },'                                                                  +nl+
'      "PayMethod": {'                                                      +nl+
'        "ClassName": "TPaymethod",'                                        +nl+
'        "Field": "Name"'                                                   +nl+
'      },'                                                                  +nl+
'      "TillId": {'                                                         +nl+
'        "ClassName": "TPOSTill",'                                          +nl+
'        "Field": "TillId"'                                                 +nl+
'      },'                                                                  +nl+
'      "EnteredBy": {'                                                      +nl+
'        "ClassName": "TEmployeeDetails",'                                  +nl+
'        "Field": "EmployeeName"'                                           +nl+
'      },'                                                                  +nl+
'    },'                                                                    +nl+
'    "Objects": {'                                                          +nl+
'      "Lines": {'                                                          +nl+
'        "ClassName": "TSaleLine",'                                         +nl+
'        "IsList": true,'                                                   +nl+
'        "Link": {'                                                         +nl+
'          "ParentField": "SaleId",'                                        +nl+
'          "LinkField": "SaleId"'                                           +nl+
'        }'                                                                 +nl+
'      },'                                                                  +nl+
'      "Payments": {'                                                       +nl+
'        "ClassName": "TSalesPayments",'                                    +nl+
'        "IsList": true,'                                                   +nl+
'        "Link": {'                                                         +nl+
'          "ParentField": "SaleId",'                                        +nl+
'          "LinkField": "SaleId"'                                           +nl+
'        }'                                                                 +nl+
'      }'                                                                   +nl+
'    }'                                                                     +nl+
'  },'                                                                      +nl+
'  "TAccount": {'                                                           +nl+
'    "TableName": "tblChartOfAccounts",'                                    +nl+
'    "IdFieldName": "AccountId",'                                           +nl+
'    "LookupFields": "AccountId,AccountName,AccountNumber,GlobalRef,msTimeStamp",'+nl+
'    "Mappings": {'                                                         +nl+
'      "AccountType": {'                                                    +nl+
'        "ClassName": "TAccountType",'                                      +nl+
'        "Field": "AccType"'                                                +nl+
'      }'                                                                   +nl+
'                }'                                                         +nl+
'  },'                                                                      +nl+
'  "TAccountType": {'                                                       +nl+
'    "TableName": "tblacctypedesc",'                                        +nl+
'    "IdFieldName": "TypeId",'                                              +nl+
'    "LookupFields": "TypeId,AccType,GlobalRef,msTimeStamp"'                +nl+
'  },'                                                                      +nl+
'  "TCustomer": {'                                                          +nl+
'    "TableName": "tblclients",'                                            +nl+
'    "IdFieldName": "clientid",'                                            +nl+
'    "LookupFields": "ClientId,GlobalRef,msTimeStamp"'                      +nl+
'  },'                                                                      +nl+
'  "TEmployeeDetails": {'                                                   +nl+
'    "TableName": "tblEmployees",'                                          +nl+
'    "IdFieldName": "EmployeeId",'                                          +nl+
'    "LookupFields": "EmployeeId,EmployeeName,GlobalRef,msTimeStamp"'       +nl+
'  },'                                                                      +nl+
'  "TDeptClass": {'                                                         +nl+
'    "TableName": "tblClass",'                                              +nl+
'    "IdFieldName": "ClassId",'                                             +nl+
'    "LookupFields": "ClassId,ClassName,GlobalRef,msTimeStamp"'             +nl+
'    "Mappings": {'                                                         +nl+
'      "Level2": {'                                                         +nl+
'        "ClassName": "TDeptClass",'                                        +nl+
'        "Field": "ClassName"'                                              +nl+
'      },'                                                                  +nl+
'      "Level3": {'                                                         +nl+
'        "ClassName": "TDeptClass",'                                        +nl+
'        "Field": "ClassName"'                                              +nl+
'      },'                                                                  +nl+
'      "Level4": {'                                                         +nl+
'        "ClassName": "TDeptClass",'                                        +nl+
'        "Field": "ClassName"'                                              +nl+
'      }'                                                                   +nl+
'                }'                                                         +nl+
'  },'                                                                      +nl+
'  "TTerms": {'                                                             +nl+
'    "TableName": "tblTerms",'                                              +nl+
'    "IdFieldName": "TermsId",'                                             +nl+
'    "LookupFields": "TermsId,Terms,GlobalRef,msTimeStamp"'                 +nl+
'  },'                                                                      +nl+
'  "TPaymethod": {'                                                         +nl+
'    "TableName": "tblPaymentMethods",'                                     +nl+
'    "IdFieldName": "PayMethodID",'                                         +nl+
'    "LookupFields": "PayMethodId,Name,GlobalRef,msTimeStamp"'              +nl+
'  },'                                                                      +nl+
'  "TPOSTill": {'                                                           +nl+
'    "TableName": "tblPOSTills",'                                           +nl+
'    "IdFieldName": "TillID",'                                              +nl+
'    "LookupFields": "TillId,TillName,GlobalRef,msTimeStamp"'               +nl+
'  },'                                                                      +nl+
'  "TSaleLine": {'                                                          +nl+
'    "TableName": "tblsaleslines",'                                         +nl+
'    "IdFieldName": "salelineid",'                                          +nl+
'    "LookupFields": "SaleLineId,SaleId,GlobalRef,msTimeStamp",'            +nl+
'    "Mappings": {'                                                         +nl+
'      "SaleId": {'                                                         +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "SaleId"'                                                 +nl+
'      },'                                                                  +nl+
'      "ProductId": {'                                                      +nl+
'        "ClassName": "TProduct",'                                          +nl+
'        "Field": "PartsId"'                                                +nl+
'      },'                                                                  +nl+
'      "IncomeAccnt": {'                                                    +nl+
'        "ClassName": "TAccount",'                                          +nl+
'        "Field": "AccountName"'                                            +nl+
'      },'                                                                  +nl+
'      "AssetAccnt": {'                                                     +nl+
'        "ClassName": "TAccount",'                                          +nl+
'        "Field": "AccountName"'                                            +nl+
'      },'                                                                  +nl+
'      "CogsAccnt": {'                                                      +nl+
'        "ClassName": "TAccount",'                                          +nl+
'        "Field": "AccountName"'                                            +nl+
'      },'                                                                  +nl+
'      "UnitOfMeasureID": {'                                                +nl+
'        "ClassName": "TUnitOfMeasure",'                                    +nl+
'        "Field": "UnitID"'                                                 +nl+
'      }'                                                                   +nl+
'    },'                                                                    +nl+
'    "Objects": {'                                                          +nl+
'      "ProductQuantityAllocation": {'                                      +nl+
'        "ClassName": "TPQA",'                                              +nl+
'        "IsList": true,'                                                   +nl+
'        "Link": {'                                                         +nl+
'          "ParentField": "SaleLineId",'                                    +nl+
'          "LinkField": "TransLineId"'                                      +nl+
'        }'                                                                 +nl+
'      },'                                                                  +nl+
'      "FormulaEntry": {'                                                   +nl+
'        "ClassName": "TFESalesLines",'                                     +nl+
'        "IsList": true,'                                                   +nl+
'        "Link": {'                                                         +nl+
'          "ParentField": "SaleLineId",'                                    +nl+
'          "LinkField": "SaleLineId"'                                       +nl+
'        }'                                                                 +nl+
'      }'                                                                   +nl+
'    }'                                                                     +nl+
'  },'                                                                      +nl+
'  "TPQA": {'                                                               +nl+
'    "TableName": "tblPQA",'                                                +nl+
'    "IdFieldName": "PQAID",'                                               +nl+
'    "LookupFields": "PQAId,TransId,TransLineId,GlobalRef,msTimeStamp",'    +nl+
'    "Mappings": {'                                                         +nl+
'      "TransLineId": {'                                                    +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "SaleLineId"'                                             +nl+
'      },'                                                                  +nl+
'      "TransId": {'                                                        +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "SaleId"'                                                 +nl+
'      },'                                                                  +nl+
'      "UOMId": {'                                                          +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "UnitOfMeasureID"'                                        +nl+
'      },'                                                                  +nl+
'      "ProductId": {'                                                      +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "ProductId"'                                              +nl+
'      },'                                                                  +nl+
'      "DepartmentId": {'                                                   +nl+
'        "ClassName": "TDeptClass",'                                        +nl+
'        "Field": "ClassID"'                                                +nl+
'      }'                                                                   +nl+
'    },  '                                                                  +nl+
'    "Objects": {'                                                          +nl+
'      "PQADetails": {'                                                     +nl+
'        "ClassName": "TPQADetails",'                                       +nl+
'        "IsList": true,'                                                   +nl+
'        "Link": {'                                                         +nl+
'          "ParentField": "PQAId",'                                         +nl+
'          "LinkField": "PQAId"'                                            +nl+
'        }'                                                                 +nl+
'      }'                                                                   +nl+
'    }  '                                                                   +nl+
'  },'                                                                      +nl+
'  "TPQADetails": {'                                                        +nl+
'    "TableName": "tblPQADetails",'                                         +nl+
'    "IdFieldName": "PQADetailID",'                                         +nl+
'    "LookupFields": "PQADetailId,GlobalRef,msTimeStamp",'                  +nl+
'    "Mappings": {'                                                         +nl+
'      "PQAIDId": {'                                                        +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "PQAID"'                                                  +nl+
'      }'                                                                   +nl+
'    }  '                                                                   +nl+
'  },  '                                                                    +nl+
'  "TFESalesLines": {'                                                      +nl+
'    "TableName": "tblFESalesLines",'                                       +nl+
'    "IdFieldName": "FESalesLineID",'                                       +nl+
'    "LookupFields": "FESalesLineID,SaleId,SaleLineId,GlobalRef,msTimeStamp",'+nl+
'    "Mappings": {'                                                         +nl+
'      "SaleId": {'                                                         +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "SaleId"'                                                 +nl+
'      },'                                                                  +nl+
'      "SaleLineId": {'                                                     +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "SaleLineId"'                                             +nl+
'      },'                                                                  +nl+
'      "ProductId": {'                                                      +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "ProductId"'                                              +nl+
'      }'                                                                   +nl+
'    },  '                                                                  +nl+
'    "Objects": {'                                                          +nl+
'      "RelatedProducts": {'                                                +nl+
'        "ClassName": "TFESalesLinesRelatedPrs",'                           +nl+
'        "IsList": true,'                                                   +nl+
'        "Link": {'                                                         +nl+
'          "ParentField": "FESalesLineID",'                                 +nl+
'          "LinkField": "FESalesLineID"'                                    +nl+
'        }'                                                                 +nl+
'      }'                                                                   +nl+
'    }  '                                                                   +nl+
'  },'                                                                      +nl+
'  "TFESalesLinesRelatedPrs": {'                                            +nl+
'    "TableName": "tblFESalesLinesRelatedPrs",'                             +nl+
'    "IdFieldName": "FESalesLineRelatedPrID",'                              +nl+
'    "LookupFields": "FESalesLineRelatedPrID,FESalesLineId,GlobalRef,msTimeStamp",'+nl+
'    "Mappings": {'                                                         +nl+
'      "FESalesLineId": {'                                                  +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "FESalesLineId"'                                          +nl+
'      },'                                                                  +nl+
'      "ProductId": {'                                                      +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "ProductId"'                                              +nl+
'      },'                                                                  +nl+
'      "FormulaID": {'                                                      +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "FormulaID"'                                              +nl+
'      }'                                                                   +nl+
'    }  '                                                                   +nl+
'  },'                                                                      +nl+
'  "TUnitOfMeasure": {'                                                     +nl+
'    "TableName": "tblUnitsOfMeasure",'                                     +nl+
'    "IdFieldName": "UnitID",'                                              +nl+
'    "LookupFields": "UnitId,UnitName,GlobalRef,msTimeStamp"'               +nl+
'  },'                                                                      +nl+
'  "TFormual": {'                                                           +nl+
'    "TableName": "tblFEFormula",'                                          +nl+
'    "IdFieldName": "FormulaID",'                                           +nl+
'    "LookupFields": "FormulaID,FormulaName,GlobalRef,msTimeStamp"'         +nl+
'  },'                                                                      +nl+
'  "TSalesPayments": {'                                                     +nl+
'    "TableName": "tblsalespayments",'                                      +nl+
'    "IdFieldName": "PaymentID",'                                           +nl+
'    "LookupFields": "PaymentID,SaleId,GlobalRef,msTimeStamp",'             +nl+
'    "Mappings": {'                                                         +nl+
'      "SaleID": {'                                                         +nl+
'        "ClassName": "parent",'                                            +nl+
'        "Field": "SaleID"'                                                 +nl+
'      }'                                                                   +nl+
'    }  '                                                                   +nl+
'  },'                                                                      +nl+
'  "TProduct": {'                                                           +nl+
'    "TableName": "tblparts",'                                              +nl+
'    "IdFieldName": "partsid",'                                             +nl+
'    "LookupFields": "PartsId,PartName,GlobalRef,msTimeStamp",'             +nl+
'    "Mappings": {'                                                         +nl+
'      "IncomeAccnt": {'                                                    +nl+
'        "ClassName": "TAccount",'                                          +nl+
'        "Field": "AccountName"'                                            +nl+
'      },'                                                                  +nl+
'      "AssetAccnt": {'                                                     +nl+
'        "ClassName": "TAccount",'                                          +nl+
'        "Field": "AccountName"'                                            +nl+
'      },'                                                                  +nl+
'      "COGSAccnt": {'                                                      +nl+
'        "ClassName": "TAccount",'                                          +nl+
'        "Field": "AccountName"'                                            +nl+
'      },'                                                                  +nl+
'      "TaxCode": {'                                                        +nl+
'        "ClassName": "TTaxCode",'                                          +nl+
'        "Field": "Name"'                                                   +nl+
'      },'                                                                  +nl+
'      "PurchTaxCode": {'                                                   +nl+
'        "ClassName": "TTaxCode",'                                          +nl+
'        "Field": "Name"'                                                   +nl+
'      },'                                                                  +nl+
'      "PreferedSupp": {'                                                   +nl+
'        "ClassName": "TSupplier",'                                         +nl+
'        "Field": "Company"'                                                +nl+
'      }'                                                                   +nl+
'    }'                                                                     +nl+
'        },'                                                                +nl+
'  "TTaxCode": {'                                                           +nl+
'    "TableName": "tbltaxcodes",'                                           +nl+
'    "IdFieldName": "taxcodeid",'                                           +nl+
'    "LookupFields": "taxcodeid,Name,GlobalRef,msTimeStamp",'               +nl+
'    "Mappings": {'                                                         +nl+
'      "RegionId": {'                                                       +nl+
'        "ClassName": "TRegionalOptions",'                                  +nl+
'        "Field": "RegionID"'                                               +nl+
'      }'                                                                   +nl+
'    }'                                                                     +nl+
'        },'                                                                +nl+
'  "TRegionalOptions": {'                                                   +nl+
'    "TableName": "tblregionaloptions",'                                    +nl+
'    "IdFieldName": "RegionID",'                                            +nl+
'    "LookupFields": "RegionID,Region,GlobalRef,msTimeStamp"'               +nl+
'        },'                                                                +nl+
'  "ProductBarcodeList": { "InheritsFrom": "TProductBarcodeList" },'        +nl+
'  "TProductBarcodeList": {'                                                +nl+
'    "TableName": "tblparts",'                                              +nl+
'    "SelectFields": "PartsID,GlobalRef,msTimeStamp",'                      +nl+
'    "IdFieldName": "PartsId",'                                             +nl+
'    "LookupFields": "PartsID,GlobalRef,msTimeStamp"'                       +nl+
'    "Objects": {'                                                          +nl+
'      "Lines": {'                                                          +nl+
'        "ClassName": "TProductBarcode",'                                   +nl+
'        "IsList": true,'                                                   +nl+
'        "Link": {'                                                         +nl+
'          "ParentField": "PartsId",'                                       +nl+
'          "LinkField": "PartsId"'                                          +nl+
'        }'                                                                 +nl+
'      }'                                                                   +nl+
'    }'                                                                     +nl+
'        },'                                                                +nl+
'  "TProductBarcode": {'                                                    +nl+
'    "TableName": "tblpartbarcodes",'                                       +nl+
'    "IdFieldName": "ProductBarcodeId",'                                    +nl+
'    "LookupFields": "ProductBarcodeID,GlobalRef,msTimeStamp"'              +nl+
'    "Mappings": {'                                                         +nl+
'      "PartsId": {'                                                        +nl+
'        "ClassName": "TProduct",'                                          +nl+
'        "Field": "PartsID"'                                                +nl+
'      }'                                                                   +nl+
'                }'                                                         +nl+
'        }'                                                                 +nl+
'  "Supplier": { "InheritsFrom": "TSupplier" },'                            +nl+
'  "TSupplier": { "InheritsFrom": "TClient" },'                             +nl+
'  "TClient": {'                                                            +nl+
'    "TableName": "tblclients",'                                            +nl+
'    "IdFieldName": "ClientId",'                                            +nl+
'    "LookupFields": "ClientID,Company,GlobalRef,msTimeStamp"'              +nl+
'    "IgnoreFields": "DefaultInvoiceTemplateID,DefaultDeliveryTemplateID",' +nl+
'    "Mappings": {'                                                         +nl+
'      "MedTypeID": {'                                                      +nl+
'        "ClassName": "TSource",'                                           +nl+
'        "Field": "MedTypeID"'                                              +nl+
'      },'                                                                  +nl+
'      "Type": {'                                                           +nl+
'        "ClassName": "TClientType",'                                       +nl+
'        "Field": "TypeName"'                                               +nl+
'      },'                                                                  +nl+
'      "TaxID": {'                                                          +nl+
'        "ClassName": "TTaxCode",'                                          +nl+
'        "Field": "taxcodeid"'                                              +nl+
'      },'                                                                  +nl+
'      "ShippingMethod": {'                                                 +nl+
'        "ClassName": "TShippingMethod",'                                   +nl+
'        "Field": "ShippingMethod"'                                         +nl+
'      },'                                                                  +nl+
'      "ShippingID": {'                                                     +nl+
'        "ClassName": "TShippingMethod",'                                   +nl+
'        "Field": "ShippingMethodID"'                                       +nl+
'      },'                                                                  +nl+
'      "Terms": {'                                                          +nl+
'        "ClassName": "TTerms",'                                            +nl+
'        "Field": "Terms"'                                                  +nl+
'      },'                                                                  +nl+
'      "TermsID": {'                                                        +nl+
'        "ClassName": "TTerms",'                                            +nl+
'        "Field": "TermsID"'                                                +nl+
'      },'                                                                  +nl+
'      "PayMethodID": {'                                                    +nl+
'        "ClassName": "TPaymethod",'                                        +nl+
'        "Field": "PaymethodID"'                                            +nl+
'      },'                                                                  +nl+
'      "RepID": {'                                                          +nl+
'        "ClassName": "TEmployeeDetails",'                                  +nl+
'        "Field": "EmployeeId"'                                             +nl+
'      },'                                                                  +nl+
'      "RepName": {'                                                        +nl+
'        "ClassName": "TEmployeeDetails",'                                  +nl+
'        "Field": "EmployeeName"'                                           +nl+
'      },'                                                                  +nl+
'      "ParentClientID": {'                                                 +nl+
'        "ClassName": "TClient",'                                           +nl+
'        "Field": "ClientID"'                                               +nl+
'      },'                                                                  +nl+
'//      "CombinedInvoiceBOID": {'                                          +nl+
'//        "ClassName": "",'                                                +nl+
'//        "Field": ""'                                                     +nl+
'//      },'                                                                +nl+
'//      "CombinedPurchaseBOID": {'                                         +nl+
'//        "ClassName": "",'                                                +nl+
'//        "Field": ""'                                                     +nl+
'//      },'                                                                +nl+
'//      "CombinedSalesOrderBOID": {'                                       +nl+
'//        "ClassName": "",'                                                +nl+
'//        "Field": ""'                                                     +nl+
'//      },'                                                                +nl+
'//                      // For now we are not going to multisite templates'+nl+
'//      "DefaultInvoiceTemplateID": {'                                     +nl+
'//        "ClassName": "",'                                                +nl+
'//        "Field": ""'                                                     +nl+
'//      },'                                                                +nl+
'//      "DefaultDeliveryTemplateID": {'                                    +nl+
'//        "ClassName": "",'                                                +nl+
'//        "Field": ""'                                                     +nl+
'//      },'                                                                +nl+
'                        "ForeignExchangeSellCode": {'                      +nl+
'        "ClassName": "TCurrency",'                                         +nl+
'        "Field": "Code"'                                                   +nl+
'      },'                                                                  +nl+
'      "DefaultClass": {'                                                   +nl+
'        "ClassName": "TDeptClass",'                                        +nl+
'        "Field": "ClassName"'                                              +nl+
'      },'                                                                  +nl+
'      "ParentRelatedClientID": {'                                          +nl+
'        "ClassName": "TClient",'                                           +nl+
'        "Field": "ClientID"'                                               +nl+
'      },'                                                                  +nl+
'      "CompanyTypeID": {'                                                  +nl+
'        "ClassName": "TClientType",'                                       +nl+
'        "Field": "ClientTypeID"'                                           +nl+
'      }'                                                                   +nl+
'                }'                                                         +nl+
'        },'                                                                +nl+
'  "TSource": {'                                                            +nl+
'    "TableName": "tblsource",'                                             +nl+
'    "IdFieldName": "MedTypeID",'                                           +nl+
'    "LookupFields": "MedTypeID,MediaType,GlobalRef,msTimeStamp"'           +nl+
'    "Mappings": {'                                                         +nl+
'      "Account": {'                                                        +nl+
'        "ClassName": "TAccount",'                                          +nl+
'        "Field": "AccountID"'                                              +nl+
'      }'                                                                   +nl+
'                }'                                                         +nl+
'        },'                                                                +nl+
'  "TClientType": {'                                                        +nl+
'    "TableName": "tblclienttype",'                                         +nl+
'    "IdFieldName": "ClientTypeId",'                                        +nl+
'    "LookupFields": "ClientTypeID,TypeName,GlobalRef,msTimeStamp",'        +nl+
'    "Mappings": {'                                                         +nl+
'      "TermsID": {'                                                        +nl+
'        "ClassName": "TTerms",'                                            +nl+
'        "Field": "TermsID"'                                                +nl+
'      },'                                                                  +nl+
'      "DefaultPostAccount": {'                                             +nl+
'        "ClassName": "TAccount",'                                          +nl+
'        "Field": "AccountName"'                                            +nl+
'      },'                                                                  +nl+
'      "DefaultPostAccountID": {'                                           +nl+
'        "ClassName": "TAccount",'                                          +nl+
'        "Field": "AccountID"'                                              +nl+
'      }'                                                                   +nl+
'                }'                                                         +nl+
'        },'                                                                +nl+
'  "TShippingMethod": {'                                                    +nl+
'    "TableName": "tblShippingMethods",'                                    +nl+
'    "IdFieldName": "ShippingMethodID",'                                    +nl+
'    "LookupFields": "ShippingMethodID,ShippingMethod,GlobalRef,msTimeStamp"'+nl+
'        },'                                                                +nl+
'  "TCurrency": {'                                                          +nl+
'    "TableName": "tblcurrencyconversion",'                                 +nl+
'    "IdFieldName": "CurrencyID",'                                          +nl+
'    "LookupFields": "CurrencyID,Country,Code,GlobalRef,msTimeStamp"'       +nl+
'        },'                                                                +nl+
'  "TCurrencyRateHistory": {'                                               +nl+
'    "TableName": "tblcurrencyconversionhistory",'                          +nl+
'    "IdFieldName": "CurrencyHistoryID",'                                   +nl+
'    "LookupFields": "CurrencyHistoryID,Code,GlobalRef,msTimeStamp",'       +nl+
'    "Mappings": {'                                                         +nl+
'      "CurrencyID": {'                                                     +nl+
'        "ClassName": "TCurrency",'                                         +nl+
'        "Field": "CurrencyID"'                                             +nl+
'      },'                                                                  +nl+
'      "Code": {'                                                           +nl+
'        "ClassName": "TCurrency",'                                         +nl+
'        "Field": "Code"'                                                   +nl+
'      },'                                                                  +nl+
'                }'                                                         +nl+
'        }'                                                                 +nl+
'}';



implementation

end.
