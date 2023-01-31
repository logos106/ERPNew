inherited dtmPriceSchemeAddin: TdtmPriceSchemeAddin
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Left = 442
  Top = 910
  Height = 127
  Width = 182
  object ActionList: TActionList
    Left = 80
    Top = 16
    object actPriceSchemeList: TDNMAction
      Category = 'Price Schemes'
      Caption = 'Price Scheme List'
      ImageIndex = 330
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmPriceSchemeList'
      buttoncolor = clWhite
    end
    object actPriceLists: TDNMAction
      Category = 'Price Schemes'
      Caption = 'Price Lists'
      ImageIndex = 326
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmPriceListsList'
      buttoncolor = clWhite
    end
    object actPriceSchemeReports: TDNMAction
      Category = 'Price Schemes'
      Caption = 'Price Scheme Reports'
      ImageIndex = 141
      OnExecute = actPriceSchemeReportsExecute
      ClassExecute = 'TfrmReportSelectorGUI'
      buttoncolor = clWhite
    end
  end
  object MainMenu: TAdvMainMenu
    Version = '2.5.3.4'
    Left = 17
    Top = 16
    object mnuPriceSchemes: TMenuItem
      Tag = 3
      Caption = 'Price Schemes'
      GroupIndex = 70
      object PriceSchemeList1: TMenuItem
        Action = actPriceSchemeList
      end
      object PriceLists1: TMenuItem
        Action = actPriceLists
      end
    end
  end
end
