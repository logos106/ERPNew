inherited dmVs1: TdmVs1
  OldCreateOrder = True
  object ActionList: TActionList
    Left = 88
    Top = 16
    object actvs1ClientList: TDNMAction
      Category = 'License'
      Caption = 'VS1 Licence List'
      Enabled = False
      ImageIndex = 807
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TVs1ClientListGUI'
      buttoncolor = clWhite
    end
    object actVS1LicenseLevelsnModules: TDNMAction
      Category = 'License'
      Caption = 'VS1 License Levels and Modules'
      ImageIndex = 803
      OnExecute = AnyActionExecute
      ClassExecute = 'TVS1LicenseLevelsnModulesGUI'
      buttoncolor = clWhite
    end
    object actVs1DatabaseList: TDNMAction
      Category = 'License'
      Caption = 'VS1 Database List'
      ImageIndex = 806
      OnExecute = AnyActionExecute
      ClassExecute = 'TVs1DatabaseListGUI'
      buttoncolor = clWhite
    end
    object actVS1AdminDBconfig: TDNMAction
      Category = 'License'
      Caption = 'VS1 Admin'
      ImageIndex = 808
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmVS1AdminDBconfig'
      buttoncolor = clWhite
    end
    object actVS1Test: TDNMAction
      Category = 'License'
      Caption = 'VS1 Test'
      ImageIndex = 801
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmVS1Test'
      buttoncolor = clWhite
    end
    object actClientARListGUI: TDNMAction
      Category = 'License'
      Caption = 'VS1 Client AR List'
      Enabled = False
      ImageIndex = 4
      Visible = False
      OnExecute = AnyActionExecute
      ClassExecute = 'TVS1ClientARListGUI'
      buttoncolor = clWhite
    end
  end
  object MainMenu: TMainMenu
    Left = 16
    Top = 8
    object ERP1: TMenuItem
      Caption = 'VS1'
      GroupIndex = 130
      object VS1LicenceList1: TMenuItem
        Action = actvs1ClientList
      end
    end
  end
end
