inherited dtRepairs: TdtRepairs
  OldCreateOrder = True
  Left = 752
  Top = 283
  Height = 136
  Width = 308
  object MainMenu: TAdvMainMenu
    Version = '2.5.3.4'
    Left = 69
    Top = 15
    object Repairs: TMenuItem
      Tag = 6
      Break = mbBarBreak
      Caption = 'Workshop'
      GroupIndex = 125
      ImageIndex = 88
      object NewRepair1: TMenuItem
        Action = actNewRepair
        GroupIndex = 110
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 110
      end
      object RepairsList1: TMenuItem
        Action = actRepairsLsit
        GroupIndex = 110
      end
      object RepairSummary2: TMenuItem
        Action = actRepairSummary
        GroupIndex = 110
      end
      object RepairStatusChoice1: TMenuItem
        Action = actRepairStatusChoice
        GroupIndex = 110
      end
      object N2: TMenuItem
        Caption = '-'
        GroupIndex = 110
      end
      object actEmpCalendar1: TMenuItem
        Action = actEmpCalendar
        GroupIndex = 110
      end
    end
  end
  object ActionList: TActionList
    Left = 17
    Top = 10
    object actNewRepair: TDNMAction
      Category = 'Workshop'
      Caption = 'New Repair'
      ImageIndex = 197
      OnExecute = AnyActionExecute
      ClassExecute = 'TRepairsGUI'
      buttoncolor = clWhite
    end
    object actRepairsLsit: TDNMAction
      Category = 'Workshop'
      Caption = 'Repairs List'
      ImageIndex = 198
      OnExecute = AnyActionExecute
      ClassExecute = 'TRepairsList'
      buttoncolor = clWhite
    end
    object actRepairsExpressLsit: TDNMAction
      Category = 'Workshop'
      Caption = 'Repairs Express List'
      ImageIndex = 43
      OnExecute = AnyActionExecute
      ClassExecute = 'TRepairListExpressGUI'
      buttoncolor = clWhite
    end
    object actRepairListInvocie: TDNMAction
      Category = 'Workshop'
      Caption = 'Repair List (Invoice)'
      ImageIndex = 353
      OnExecute = AnyActionExecute
      ClassExecute = 'TRepairInvoiceListGUI'
      buttoncolor = clWhite
    end
    object actRepairfaults: TDNMAction
      Category = 'Workshop'
      Caption = 'Repair Faults List'
      ImageIndex = 162
      OnExecute = AnyActionExecute
      ClassExecute = 'TRepairFaultGUI'
      buttoncolor = clWhite
    end
    object actNewRepairfault: TDNMAction
      Category = 'Workshop'
      Caption = 'Repair Fault'
      ImageIndex = 158
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmRepairFaults'
      buttoncolor = clWhite
    end
    object actmanufacture: TDNMAction
      Category = 'Workshop'
      Caption = 'Manufacture'
      ImageIndex = 118
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmManufacture'
      buttoncolor = clWhite
    end
    object actManufactureList: TDNMAction
      Category = 'Workshop'
      Caption = 'Manufacture List'
      ImageIndex = 136
      OnExecute = AnyActionExecute
      ClassExecute = 'TManufactureListGUI'
      buttoncolor = clWhite
    end
    object actRepairStatusChoice: TDNMAction
      Category = 'Workshop'
      Caption = 'Repair Status Choice'
      ImageIndex = 180
      OnExecute = actRepairStatusChoiceExecute
      buttoncolor = clWhite
    end
    object actCustomFieldValuesReapirs: TDNMAction
      Category = 'Workshop'
      Caption = 'Customisable List - Repairs'
      ImageIndex = 699
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesReapirsGUI'
      buttoncolor = clWhite
    end
    object actEmpCalendar: TDNMAction
      Category = 'Workshop'
      Caption = 'Service Pad'
      ImageIndex = 194
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmEmployeeCalendar'
      buttoncolor = clWhite
    end
    object actRepairSummary: TDNMAction
      Category = 'Workshop'
      Caption = 'Repair Summary'
      ImageIndex = 524
      OnExecute = AnyActionExecute
      ClassExecute = 'TRepairSummaryGUI'
      buttoncolor = clWhite
    end
    object actCustomFieldValuesListReapirs: TDNMAction
      Category = 'Workshop'
      Caption = 'Customisable Fields - Repairs'
      ImageIndex = 698
      OnExecute = AnyActionExecute
      ClassExecute = 'TCustomFieldValuesListRepairsGUI'
      buttoncolor = clWhite
    end
  end
end
