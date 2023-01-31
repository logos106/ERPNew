inherited dmBudgetAddin: TdmBudgetAddin
  OldCreateOrder = True
  Left = 608
  Top = 166
  Height = 160
  Width = 184
  object MainMenu: TAdvMainMenu
    Version = '2.5.3.4'
    Left = 17
    Top = 8
    object Budgets1: TMenuItem
      Tag = 2
      Caption = 'Budget'
      GroupIndex = 10
      ImageIndex = 109
      object BudgetDefinition1: TMenuItem
        Action = actBudgetDefinition
        GroupIndex = 100
      end
      object BudgetDefinitionList1: TMenuItem
        Action = actBudgetDefinitionList
        GroupIndex = 100
      end
      object N2: TMenuItem
        Caption = '-'
        GroupIndex = 100
      end
      object Budgets2: TMenuItem
        Action = actBudget
        GroupIndex = 100
      end
      object BudgetList1: TMenuItem
        Action = actBudgetList
        GroupIndex = 100
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 100
      end
      object BudgetVariation1: TMenuItem
        Action = actBudgetVariation
        GroupIndex = 100
      end
      object BudgetVsActualREport1: TMenuItem
        Action = actBudgetvsActual
        GroupIndex = 100
      end
      object JobBudgetVsActual1: TMenuItem
        Action = actJobBudgetVsActual
        GroupIndex = 100
      end
      object N3: TMenuItem
        Caption = '-'
        GroupIndex = 100
      end
      object ProfitandLossReport1: TMenuItem
        Action = actBudgetProfitAndLossReport
        GroupIndex = 100
      end
      object N4: TMenuItem
        Caption = '-'
        GroupIndex = 100
      end
      object AccountList1: TMenuItem
        Action = actBudgetAccountList
        GroupIndex = 100
      end
    end
  end
  object ActionList: TActionList
    Left = 98
    Top = 7
    object actBudgetDefinition: TDNMAction
      Category = 'Budget'
      Caption = 'Budget Definition'
      ImageIndex = 322
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmBudgetDef'
      buttoncolor = clWhite
    end
    object actBudget: TDNMAction
      Category = 'Budget'
      Caption = 'Budget'
      ImageIndex = 347
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmBudget'
      buttoncolor = clWhite
    end
    object actBudgetVariation: TDNMAction
      Category = 'Budget'
      Caption = 'Budget Variation'
      ImageIndex = 314
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmBudgetVariation'
      buttoncolor = clWhite
    end
    object actBudgetAccountList: TDNMAction
      Category = 'Budget'
      Caption = 'Account List for Budget'
      ImageIndex = 350
      OnExecute = AnyActionExecute
      ClassExecute = 'TChartOfAccountsListGUI'
      buttoncolor = clWhite
    end
    object actBudgetvsActual: TDNMAction
      Category = 'Budget'
      Caption = 'Budget vs Actual'
      ImageIndex = 169
      OnExecute = AnyActionExecute
      ClassExecute = 'TBudVsActListGUI'
      buttoncolor = clWhite
    end
    object actReportsBudget: TDNMAction
      Category = 'Budget'
      Caption = 'Budget Reports'
      ImageIndex = 141
      OnExecute = actReportsBudgetExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      DefaultPage = 'Budget'
      buttoncolor = clWhite
    end
    object actBudgetDefinitionList: TDNMAction
      Category = 'Budget'
      Caption = 'Budget Definition List'
      ImageIndex = 323
      OnExecute = AnyActionExecute
      ClassExecute = 'TBudgetDefGUI'
      buttoncolor = clWhite
    end
    object actBudgetList: TDNMAction
      Category = 'Budget'
      Caption = 'Budget List'
      ImageIndex = 348
      OnExecute = AnyActionExecute
      ClassExecute = 'TBudgetGUI'
      buttoncolor = clWhite
    end
    object actBudgetProfitAndLossReport: TDNMAction
      Category = 'Budget'
      Caption = 'Budget Profit and Loss Report'
      ImageIndex = 267
      OnExecute = AnyActionExecute
      ClassExecute = 'TProfitandLossByPeriodGUI'
      buttoncolor = clWhite
    end
    object actJobBudgetVsActual: TDNMAction
      Category = 'Budget'
      Caption = 'Job  Report (Budget Vs Actual)'
      ImageIndex = 311
      OnExecute = AnyActionExecute
      ClassExecute = 'TJobBudgetVsActual'
      DefaultPage = 'Budget'
      buttoncolor = clWhite
    end
  end
end
