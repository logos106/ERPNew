inherited dmStS: TdmStS
  OldCreateOrder = True
  object ActionList: TActionList
    Left = 98
    Top = 7
    object actStrain: TDNMAction
      Category = 'StS'
      Caption = 'Strain'
      ImageIndex = 66
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmStSStrain'
      buttoncolor = clWhite
    end
    object actStSStrains: TDNMAction
      Category = 'StS'
      Caption = 'Strain List'
      ImageIndex = 272
      OnExecute = AnyActionExecute
      ClassExecute = 'TStSStrainsGUI'
      buttoncolor = clWhite
    end
    object actStsTagOrder: TDNMAction
      Category = 'StS'
      Caption = 'Make Tag Order'
      ImageIndex = 724
      OnExecute = actStsTagOrderExecute
      buttoncolor = clWhite
    end
    object actint_StS: TDNMAction
      Category = 'StS'
      Caption = 'Seed To Sale'
      ImageIndex = 723
      OnExecute = actint_StSExecute
      buttoncolor = clWhite
    end
    object actStsHarvest: TDNMAction
      Category = 'StS'
      Caption = 'Seed To Sale - Harvest'
      ImageIndex = 809
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmStSHarvest'
      buttoncolor = clWhite
    end
    object actStSReport: TDNMAction
      Category = 'StS'
      Caption = 'Seed To Sale Reports'
      ImageIndex = 141
      OnExecute = actStSReportExecute
      buttoncolor = clWhite
    end
    object actStSClassList: TDNMAction
      Category = 'StS'
      Caption = 'Facility List'
      ImageIndex = 67
      Visible = False
      OnExecute = AnyActionExecute
      OnUpdate = actStSClassListUpdate
      ClassExecute = 'TStSClassListGUI'
      buttoncolor = clWhite
    end
    object actStsTagOrders: TDNMAction
      Category = 'StS'
      Caption = 'Tag Order List'
      ImageIndex = 750
      OnExecute = AnyActionExecute
      ClassExecute = 'TStSTagOrdersGUI'
      buttoncolor = clWhite
    end
    object actStSTagsofStSSupplier: TDNMAction
      Category = 'StS'
      Caption = 'Tags'
      ImageIndex = 754
      OnExecute = AnyActionExecute
      OnUpdate = actStSTagsofStSSupplierUpdate
      ClassExecute = 'TStSTagsofStSSupplierGUI'
      buttoncolor = clWhite
    end
    object actStSTags: TDNMAction
      Category = 'StS'
      Caption = 'Seed To Sale Tags'
      ImageIndex = 783
      OnExecute = AnyActionExecute
      ClassExecute = 'TStSTagsGUI'
      buttoncolor = clWhite
    end
    object actStsHarvestList: TDNMAction
      Category = 'StS'
      Caption = 'Seed To Sale - Harvests'
      ImageIndex = 810
      OnExecute = AnyActionExecute
      ClassExecute = 'TStSHarvestListGUI'
      buttoncolor = clWhite
    end
    object actStSMain: TDNMAction
      Category = 'StS'
      Caption = 'Seed To Sale - Main '
      ImageIndex = 782
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmStSMain'
      buttoncolor = clWhite
    end
    object actStSClass: TDNMAction
      Category = 'StS'
      Caption = 'Facility'
      ImageIndex = 277
      OnExecute = actStSClassExecute
      OnUpdate = actStSClassUpdate
      buttoncolor = clWhite
    end
    object actStsTagGrowthHistory: TDNMAction
      Category = 'StS'
      Caption = 'Seed To Sale - Tag Growth History'
      ImageIndex = 738
      OnExecute = AnyActionExecute
      ClassExecute = 'TStsTagGrowthHistoryGUI'
      buttoncolor = clWhite
    end
    object actStsTagActivityLog: TDNMAction
      Category = 'StS'
      Caption = 'Seed To Sale - Tag Activity Log'
      ImageIndex = 739
      OnExecute = AnyActionExecute
      ClassExecute = 'TStsTagActivityLogGUI'
      buttoncolor = clWhite
    end
    object actStSProductQtyList: TDNMAction
      Category = 'StS'
      Caption = 'Seed To Sale - Stock Qty List'
      ImageIndex = 693
      OnExecute = AnyActionExecute
      ClassExecute = 'TStSProductQtyListGUI'
      buttoncolor = clWhite
    end
    object actShowTagReports: TDNMAction
      Category = 'StS'
      Caption = 'Show Tag Reports'
      ImageIndex = 108
      OnExecute = actShowTagReportsExecute
      buttoncolor = clWhite
    end
    object actRefreshTagReports: TDNMAction
      Category = 'StS'
      Caption = 'Refresh Tag Reports'
      ImageIndex = 108
      OnExecute = actRefreshTagReportsExecute
      buttoncolor = clWhite
    end
    object actStSRooms: TDNMAction
      Category = 'StS'
      Caption = 'Seed To Sale - Rooms'
      ImageIndex = 243
      OnExecute = AnyActionExecute
      ClassExecute = 'TStSRoomsGUI'
      buttoncolor = clWhite
    end
    object actStsNewHarvestPackage: TDNMAction
      Category = 'StS'
      Caption = 'New Harvest Package'
      ImageIndex = 814
      OnExecute = actStsNewHarvestPackageExecute
      buttoncolor = clWhite
    end
    object actStsNewAnotherPackage: TDNMAction
      Category = 'StS'
      Caption = 'New Another Package'
      ImageIndex = 815
      OnExecute = actStsNewAnotherPackageExecute
      buttoncolor = clWhite
    end
    object actStsPackageList: TDNMAction
      Category = 'StS'
      Caption = 'Package List'
      ImageIndex = 816
      OnExecute = AnyActionExecute
      ClassExecute = 'TfrmStsPackageList'
      buttoncolor = clWhite
    end
    object actStsTransferPackage: TDNMAction
      Category = 'StS'
      Caption = 'New Transfer'
      ImageIndex = 817
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmStSTransferPackage'
      buttoncolor = clWhite
    end
    object actStsTransferPackageList: TDNMAction
      Category = 'StS'
      Caption = 'Transfer List'
      ImageIndex = 818
      OnExecute = actStsTransferPackageListExecute
      ClassExecute = 'TfrmTransferPackageList'
      buttoncolor = clWhite
    end
  end
  object MainMenu: TAdvMainMenu
    Version = '2.5.3.4'
    Left = 17
    Top = 8
    object Budgets1: TMenuItem
      Tag = 2
      Caption = 'Seed to Sale'
      GroupIndex = 10
      ImageIndex = 109
      object SeedtoSaleStrain1: TMenuItem
        Action = actStrain
      end
      object SeedtoSaleStrainList1: TMenuItem
        Action = actStSStrains
      end
      object SeedtoSaleClassList1: TMenuItem
        Action = actStSClassList
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Reports1: TMenuItem
        Action = actStSReport
      end
    end
  end
end
