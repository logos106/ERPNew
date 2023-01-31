inherited dtmMarketingAddin: TdtmMarketingAddin
  OldCreateOrder = True
  Height = 286
  Width = 201
  object ActionList: TActionList
    Left = 105
    Top = 10
    object actContactSelectionRange: TDNMAction
      Category = 'Marketing'
      Caption = 'Contact Selection Range'
      ImageIndex = 57
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmMarketingContactSelectionRange'
      Description = 'Con Sel Rng'
      buttoncolor = clWhite
    end
    object actContactSelectionRangeList: TDNMAction
      Category = 'Marketing'
      Caption = 'Contact Selection Range List'
      ImageIndex = 274
      OnExecute = AnyActionExecute
      ClassExecute = 'TMarketingContactSelectionRangeListGUI'
      Description = 'Con Sl Rng Lst'
      buttoncolor = clWhite
    end
    object actsalesAnalysisGraph: TDNMAction
      Category = 'Marketing'
      Caption = 'Sales Analysis Chart'
      ImageIndex = 331
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmsalesAnalysisGraph'
      buttoncolor = clWhite
    end
    object actMarketing: TDNMAction
      Category = 'Marketing'
      Caption = 'Telemarketing'
      ImageIndex = 268
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmMarketing'
      buttoncolor = clWhite
    end
    object actMarketingList: TDNMAction
      Category = 'Marketing'
      Caption = 'Telemarketing List'
      ImageIndex = 269
      OnExecute = AnyActionExecute
      ClassExecute = 'TMarketingGUI'
      buttoncolor = clWhite
    end
    object actMarketingContact: TDNMAction
      Category = 'Marketing'
      Caption = 'Marketing Contact'
      ImageIndex = 310
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmMarketingContact'
      Description = 'Marketing Con'
      buttoncolor = clWhite
    end
    object actMarketingContactList: TDNMAction
      Category = 'Marketing'
      Caption = 'Marketing Contact List'
      ImageIndex = 318
      OnExecute = AnyActionExecute
      ClassExecute = 'TMarketingContactListGUI'
      Description = 'Market Con Lst'
      buttoncolor = clWhite
    end
    object actMarketingContactSummary: TDNMAction
      Category = 'Marketing'
      Caption = 'Marketing Contact Summary'
      ImageIndex = 304
      OnExecute = AnyActionExecute
      ClassExecute = 'TMarketingContactSummaryGUI'
      Description = 'Market Con Sum'
      buttoncolor = clWhite
    end
    object actLeadList: TDNMAction
      Category = 'Marketing'
      Caption = 'Lead List'
      ImageIndex = 282
      OnExecute = AnyActionExecute
      ClassExecute = 'TMarketingLeadsGUI'
      buttoncolor = clWhite
    end
    object actLead: TDNMAction
      Category = 'Marketing'
      Caption = 'Lead'
      ImageIndex = 341
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmMarketingLead'
      buttoncolor = clWhite
    end
    object actMarketingReports: TDNMAction
      Category = 'Marketing'
      Caption = 'Marketing Reports'
      ImageIndex = 141
      OnExecute = actMarketingReportsExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
    object actReminderPrn: TDNMAction
      Category = 'Marketing'
      Caption = 'Print Reminders'
      ImageIndex = 288
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmReminderPrnGUI'
      buttoncolor = clWhite
    end
    object actMarketingContactListDetail: TDNMAction
      Category = 'Marketing'
      Caption = 'Marketing Action List'
      ImageIndex = 283
      OnExecute = AnyActionExecute
      ClassExecute = 'TMarketingContactListDetailGUI'
      buttoncolor = clWhite
    end
    object actMarketingContactProduct: TDNMAction
      Category = 'Marketing'
      Caption = 'Marketing Contact Products'
      ImageIndex = 291
      OnExecute = AnyActionExecute
      ClassExecute = 'TMarketingContactProductListGUI'
      buttoncolor = clWhite
    end
    object actMarketingContactcontact: TDNMAction
      Category = 'Marketing'
      Caption = 'Marketing Contact Contacts'
      ImageIndex = 297
      OnExecute = AnyActionExecute
      ClassExecute = 'TMarketingContactcontactListGUI'
      buttoncolor = clWhite
    end
    object actProductProcessList: TDNMAction
      Category = 'Marketing'
      Caption = 'Product Process List'
      ImageIndex = 298
      OnExecute = AnyActionExecute
      ClassExecute = 'TProductProcessListGUI'
      buttoncolor = clWhite
    end
    object actClientnMarketingList: TDNMAction
      Category = 'Marketing'
      Caption = 'Client and Marketing Contact List'
      ImageIndex = 98
      OnExecute = AnyActionExecute
      ClassExecute = 'TClientsandMarketingcontactsListGUI'
      buttoncolor = clWhite
    end
    object actLeadActionType: TDNMAction
      Category = 'Marketing'
      Caption = 'Action Types'
      ImageIndex = 299
      OnExecute = actLeadActionTypeExecute
      buttoncolor = clWhite
    end
    object actSalesAnalysis: TDNMAction
      Category = 'Marketing'
      Caption = 'Sales Analysis'
      ImageIndex = 663
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSalesAnalysisManual'
      buttoncolor = clWhite
    end
    object actSalesAnalysisList: TDNMAction
      Category = 'Marketing'
      Caption = 'Sales Analysis List'
      ImageIndex = 669
      OnExecute = AnyActionExecute
      ClassExecute = 'TSalesAnalysisManualGUI'
      buttoncolor = clWhite
    end
  end
  object MainMenu: TAdvMainMenu
    Version = '2.5.3.4'
    Left = 21
    Top = 15
    object Marketing: TMenuItem
      Tag = 6
      Break = mbBarBreak
      Caption = 'Marketing'
      GroupIndex = 110
      ImageIndex = 80
      object ActionTypes1: TMenuItem
        Action = actLeadActionType
        GroupIndex = 20
      end
      object RangeSelectionList1: TMenuItem
        Action = actContactSelectionRangeList
        GroupIndex = 20
      end
      object ContactSelectionRange1: TMenuItem
        Action = actContactSelectionRange
        GroupIndex = 20
      end
      object About3: TMenuItem
        Action = dtmMainGUI.actFollowupTypes
        GroupIndex = 20
      end
      object Lead1: TMenuItem
        Action = actLead
        GroupIndex = 20
      end
      object LeadList1: TMenuItem
        Action = actLeadList
        GroupIndex = 20
      end
      object mnuMarketingActionList: TMenuItem
        Action = actMarketingContactListDetail
        GroupIndex = 20
      end
      object MarketingContact1: TMenuItem
        Action = actMarketingContact
        GroupIndex = 20
      end
      object MarketingContactList1: TMenuItem
        Action = actMarketingContactList
        GroupIndex = 20
      end
      object MarketingContactSummary1: TMenuItem
        Action = actMarketingContactSummary
        GroupIndex = 20
      end
      object About4: TMenuItem
        Action = dtmMainGUI.actMarketingRatios
        GroupIndex = 20
      end
      object PrintReminders1: TMenuItem
        Action = actReminderPrn
        GroupIndex = 20
      end
      object About1: TMenuItem
        Action = dtmMainGUI.actSalesCRMOtherContacts
        GroupIndex = 20
      end
      object About2: TMenuItem
        Action = dtmMainGUI.actSalesCRMOtherContactsList
        GroupIndex = 20
      end
      object SalesAnalysisChart1: TMenuItem
        Action = actsalesAnalysisGraph
        GroupIndex = 20
      end
      object About6: TMenuItem
        Action = dtmMainGUI.actSalesPipeline
        GroupIndex = 20
      end
      object SalesRatiosReport1: TMenuItem
        Action = dtmMainGUI.actSalesRatios
        GroupIndex = 20
      end
      object Marketing1: TMenuItem
        Action = actMarketing
        GroupIndex = 20
      end
      object elemarketingList1: TMenuItem
        Action = actMarketingList
        GroupIndex = 20
      end
      object HowTo1: TMenuItem
        Caption = 'How To'
        GroupIndex = 20
        object CreatingandUsingLeads1: TMenuItem
        end
      end
    end
  end
end
