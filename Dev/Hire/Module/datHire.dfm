inherited dtHire: TdtHire
  OldCreateOrder = True
  Left = 553
  Top = 307
  Height = 177
  Width = 265
  object MainMenu: TAdvMainMenu
    Version = '2.5.3.4'
    Left = 69
    Top = 15
    object Repairs: TMenuItem
      Tag = 6
      Break = mbBarBreak
      Caption = 'Hire'
      GroupIndex = 65
      ImageIndex = 88
      object NewRepair1: TMenuItem
        Action = actHire
        GroupIndex = 110
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 110
      end
      object RepairsList1: TMenuItem
        Action = actHireList
        GroupIndex = 110
      end
      object HireItemDetails1: TMenuItem
        Action = actHireItemDetails
        GroupIndex = 110
      end
      object HireHistory1: TMenuItem
        Action = actHireHistory
        GroupIndex = 110
      end
      object N2: TMenuItem
        Caption = '-'
        GroupIndex = 110
      end
      object HireAvailability1: TMenuItem
        Action = actHireAvailability
        GroupIndex = 110
      end
      object actEmpCalendar1: TMenuItem
        Caption = 'Hire Roster'
        GroupIndex = 110
        ImageIndex = 724
        OnClick = AnyActionExecute
      end
    end
  end
  object ActionList: TActionList
    Left = 17
    Top = 10
    object actHire: TDNMAction
      Category = 'Hire'
      Caption = 'New Hire'
      ImageIndex = 720
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmHire'
      buttoncolor = clWhite
    end
    object actHireList: TDNMAction
      Category = 'Hire'
      Caption = 'Hire List'
      ImageIndex = 713
      OnExecute = AnyActionExecute
      ClassExecute = 'THireListGUI'
      buttoncolor = clWhite
    end
    object actDurationList: TDNMAction
      Category = 'Hire'
      Caption = 'Duration List'
      ImageIndex = 728
      OnExecute = AnyActionExecute
      ClassExecute = 'TDurationListGUI'
      buttoncolor = clWhite
    end
    object actDuration: TDNMAction
      Category = 'Hire'
      Caption = 'New Duration'
      ImageIndex = 726
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmDuration'
      buttoncolor = clWhite
    end
    object actHireListDetails: TDNMAction
      Category = 'Hire'
      Caption = 'Hire Details'
      ImageIndex = 731
      OnExecute = AnyActionExecute
      ClassExecute = 'THireListDetailsGUI'
      buttoncolor = clWhite
    end
    object actHireEquipmentList: TDNMAction
      Category = 'Hire'
      Caption = 'Hire Equipment List'
      ImageIndex = 730
      OnExecute = AnyActionExecute
      ClassExecute = 'THireEquipmentListGUI'
      buttoncolor = clWhite
    end
    object actSetupHire: TDNMAction
      Category = 'Hire'
      Caption = 'Hire Setup'
      ImageIndex = 743
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSetupHire'
      buttoncolor = clWhite
    end
    object actHireItemDetails: TDNMAction
      Category = 'Hire'
      Caption = 'Hire Item Details'
      ImageIndex = 729
      OnExecute = AnyActionExecute
      ClassExecute = 'THireItemDetailListGUI'
      buttoncolor = clWhite
    end
    object actHireHistory: TDNMAction
      Category = 'Hire'
      Caption = 'Hire History'
      ImageIndex = 646
      OnExecute = AnyActionExecute
      ClassExecute = 'THireHistoryForAssetGUI'
      buttoncolor = clWhite
    end
    object actHireAvailability: TDNMAction
      Category = 'Hire'
      Caption = 'Hire Availability'
      ImageIndex = 627
      OnExecute = AnyActionExecute
      ClassExecute = 'THireItemAvailabilityGUI'
      buttoncolor = clWhite
    end
    object actHirePlanner: TDNMAction
      Category = 'Hire'
      Caption = 'Hire Planner'
      ImageIndex = 574
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmHirePlanner'
      buttoncolor = clWhite
    end
    object actStockToAsset: TDNMAction
      Category = 'Hire'
      Caption = 'Product To Fixed Asset'
      ImageIndex = 685
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmStockToFixedAsset'
      buttoncolor = clWhite
    end
    object actStockToAssetList: TDNMAction
      Category = 'Hire'
      Caption = 'Product To Fixed Asset List'
      ImageIndex = 686
      OnExecute = AnyActionExecute
      ClassExecute = 'TStockToFixedAssetListGUI'
      buttoncolor = clWhite
    end
  end
end
