inherited dmERP: TdmERP
  OldCreateOrder = True
  object MainMenu: TMainMenu
    Left = 16
    Top = 8
    object ERP1: TMenuItem
      Caption = 'ERP'
      GroupIndex = 130
      object ClientLicenceList1: TMenuItem
        Action = actERPClientList
      end
      object ClientServerLog1: TMenuItem
        Action = actClientServerLog
      end
      object Licence1: TMenuItem
        Action = actClientTreeList
      end
      object Licence2: TMenuItem
        Caption = '-'
      end
      object MessageCostList1: TMenuItem
        Action = actMessageCostList
      end
      object GetClientMessageData1: TMenuItem
        Action = actGetClientMessageData
      end
      object MasterSMSConfig1: TMenuItem
        Action = actMasterSMSConfig
      end
      object CreateSalesOrdersforSMSCharges1: TMenuItem
        Action = actCreateSO
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ERPOffices1: TMenuItem
        Action = actERPOffices
      end
      object trainingVideosAdmin1: TMenuItem
        Action = actTrainingVideoConfiguration
      end
      object HelpDocsconfiguration1: TMenuItem
        Action = actHelpDocConfiguration
      end
    end
  end
  object ActionList: TActionList
    Left = 88
    Top = 16
    object actERPClientList: TDNMAction
      Category = 'Licence'
      Caption = 'Client Licence List'
      ImageIndex = 333
      OnExecute = AnyActionExecute
      ClassExecute = 'TERPClientListGUI'
      buttoncolor = clWhite
    end
    object actClientTreeList: TDNMAction
      Category = 'Licence'
      Caption = 'Client Licence List Tree'
      ImageIndex = 334
      OnExecute = AnyActionExecute
      ClassExecute = 'TERPClientListTreeGUI'
      buttoncolor = clWhite
    end
    object actMasterSMSConfig: TDNMAction
      Category = 'SMS'
      Caption = 'Master SMS Config'
      ImageIndex = 337
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmSMSMasterAccountInfo'
      buttoncolor = clWhite
    end
    object actGetClientMessageData: TDNMAction
      Category = 'SMS'
      Caption = 'Get Client Message Data'
      ImageIndex = 338
      OnExecute = actGetClientMessageDataExecute
      buttoncolor = clWhite
    end
    object actClientServerLog: TDNMAction
      Category = 'Licence'
      Caption = 'Client Server Log'
      ImageIndex = 336
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmClientServerLog'
      buttoncolor = clWhite
    end
    object actMessageCostList: TDNMAction
      Category = 'SMS'
      Caption = 'Message Cost List'
      ImageIndex = 339
      OnExecute = AnyActionExecute
      ClassExecute = 'TERPClientMessageListGUI'
      buttoncolor = clWhite
    end
    object actCreateSO: TDNMAction
      Category = 'SMS'
      Caption = 'Create Sales Orders for SMS Charges'
      ImageIndex = 340
      OnExecute = actCreateSOExecute
      buttoncolor = clWhite
    end
    object actERPOffices: TDNMAction
      Category = 'Training'
      Caption = 'ERP Offices'
      ImageIndex = 341
      OnExecute = AnyActionExecute
      ClassExecute = 'TERPOfficesGUI'
      buttoncolor = clWhite
    end
    object actTrainingVideoConfiguration: TDNMAction
      Category = 'Training'
      Caption = 'Training Videos configuration'
      ImageIndex = 342
      OnExecute = AnyActionExecute
      ClassExecute = 'TERPVideoConfigurationListLISt'
      buttoncolor = clWhite
    end
    object actHelpDocConfiguration: TDNMAction
      Category = 'Training'
      Caption = 'Help Docs configuration'
      ImageIndex = 343
      OnExecute = AnyActionExecute
      ClassExecute = 'THelpDocConfigurationListGUI'
      buttoncolor = clWhite
    end
  end
end
