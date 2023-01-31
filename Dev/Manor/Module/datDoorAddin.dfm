inherited dtmDoorAddin: TdtmDoorAddin
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Left = 566
  Top = 182
  Height = 172
  Width = 360
  object MainMenu: TAdvMainMenu
    Version = '2.5.1.1'
    Left = 33
    Top = 16
    object DoorsMenu: TMenuItem
      Caption = 'Doors'
      GroupIndex = 75
      object compDetList1: TMenuItem
        Action = actdoorCompGUI
        GroupIndex = 110
      end
      object compDet1: TMenuItem
        Action = actDoorCompDetGUI
        GroupIndex = 110
      end
      object DoorIsdescriptions1: TMenuItem
        Action = actDoorIsDescriptionsGUI
        GroupIndex = 110
      end
      object DoorDetailList1: TMenuItem
        Action = actDoorDetGUI
        GroupIndex = 110
      end
      object DoorFinish2: TMenuItem
        Action = actDoorfinishGUI
        GroupIndex = 110
      end
      object DoorFireRating2: TMenuItem
        Action = actDoorFireRatingGUI
        GroupIndex = 110
      end
      object DoorGlazingList1: TMenuItem
        Action = actDoorGlazingGUI
        GroupIndex = 110
      end
      object DoorHandingDetailsList1: TMenuItem
        Action = actDoorHandingDetailsGUI
        GroupIndex = 110
      end
      object DoorJoinery2: TMenuItem
        Action = actDoorJoineryGUI
        GroupIndex = 110
      end
      object DoorLipping2: TMenuItem
        Action = actDoorLippingGUI
        GroupIndex = 110
      end
      object DoorStiles2: TMenuItem
        Action = actDoorStilesGUI
        GroupIndex = 110
      end
      object DoorStopType2: TMenuItem
        Action = actDoorStopTypeGUI
        GroupIndex = 110
      end
      object DoorSundry2: TMenuItem
        Action = actDoorSundryGUI
        GroupIndex = 110
      end
      object DoorVeneer2: TMenuItem
        Action = actDoorVeneerGUI
        GroupIndex = 110
      end
    end
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 32
    Top = 72
    object actDoorReports: TDNMAction
      Category = 'Door'
      Caption = 'Door Reports'
      Enabled = False
      ImageIndex = 281
      OnExecute = actDoorReportsExecute
      ClassExecute = 'TfrmReportSelectorGUI'
    end
    object actDoorDetails: TDNMAction
      Category = 'Door'
      Caption = 'Door Details'
      Enabled = False
      ImageIndex = 215
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmDoorDet'
    end
    object actDoorFinish: TDNMAction
      Category = 'Door'
      Caption = 'Door Finish'
      Enabled = False
      ImageIndex = 71
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmDoorFinish'
    end
    object actDoorFireRating: TDNMAction
      Category = 'Door'
      Caption = 'Door Fire Rating'
      Enabled = False
      ImageIndex = 105
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmDoorFireRating'
    end
    object actDoorGlazing: TDNMAction
      Category = 'Door'
      Caption = 'Door Glazing'
      Enabled = False
      ImageIndex = 90
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmDoorGlazing'
    end
    object actDoorHandingDetails: TDNMAction
      Category = 'Door'
      Caption = 'Door Handing Details'
      Enabled = False
      ImageIndex = 406
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmDoorHandingDetails'
    end
    object actdoorIsDescription: TDNMAction
      Category = 'Door'
      Caption = 'Door Description'
      Enabled = False
      ImageIndex = 39
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmdoorIsDescription'
    end
    object actdoorJoinery: TDNMAction
      Category = 'Door'
      Caption = 'Door Joinery'
      Enabled = False
      ImageIndex = 80
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmdoorJoinery'
    end
    object actdoorLipping: TDNMAction
      Category = 'Door'
      Caption = 'Door Lipping'
      Enabled = False
      ImageIndex = 387
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmdoorLipping'
    end
    object actdoorstiles: TDNMAction
      Category = 'Door'
      Caption = 'Door Stiles'
      Enabled = False
      ImageIndex = 260
      OnExecute = AnyActionExecute
      ClassExecute = 'Tfmdoorstiles'
    end
    object actdoorStoptype: TDNMAction
      Category = 'Door'
      Caption = 'Door Stop Type'
      Enabled = False
      ImageIndex = 238
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmdoorStoptype'
    end
    object actdoorsundry: TDNMAction
      Category = 'Door'
      Caption = 'Door Sundry'
      Enabled = False
      ImageIndex = 213
      OnExecute = AnyActionExecute
      ClassExecute = 'Tfmdoorsundry'
    end
    object actdoorVeneer: TDNMAction
      Category = 'Door'
      Caption = 'Door Veneer'
      Enabled = False
      ImageIndex = 388
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmdoorVeneer'
    end
    object actDoorcompDet: TDNMAction
      Category = 'Door'
      Caption = 'Door Comp Details'
      Checked = True
      Enabled = False
      ImageIndex = 136
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmDoorcompDet'
    end
    object actfmDoorComp: TDNMAction
      Category = 'Door'
      Caption = 'Door Comp'
      Enabled = False
      ImageIndex = 198
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmDoorComp'
    end
    object actDoorDetGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Detail List'
      ImageIndex = 208
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorDetGUI'
    end
    object actDoorfinishGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Finish List'
      ImageIndex = 72
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorfinishGUI'
    end
    object actDoorFireRatingGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Fire Rating List'
      ImageIndex = 92
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorFireRatingGUI'
    end
    object actDoorGlazingGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Glazing List'
      ImageIndex = 94
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorGlazingGUI'
    end
    object actDoorHandingDetailsGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Handing Details List'
      ImageIndex = 362
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorHandingDetailsGUI'
    end
    object actDoorIsDescriptionsGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Descriptions List'
      ImageIndex = 40
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorIsDescriptionsGUI'
    end
    object actDoorJoineryGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Joinery List'
      ImageIndex = 79
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorJoineryGUI'
    end
    object actDoorLippingGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Lipping List'
      ImageIndex = 386
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorLippingGUI'
    end
    object actDoorStilesGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Stiles List'
      ImageIndex = 232
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorStilesGUI'
    end
    object actDoorStopTypeGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Stop Type List'
      ImageIndex = 257
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorStopTypeGUI'
    end
    object actDoorSundryGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Sundry List'
      ImageIndex = 204
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorSundryGUI'
    end
    object actDoorVeneerGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Veneer List'
      ImageIndex = 389
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorVeneerGUI'
    end
    object actDoorCompDetGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Comp Detail List'
      ImageIndex = 139
      OnExecute = AnyActionExecute
      ClassExecute = 'TDoorCompDetGUI'
    end
    object actdoorCompGUI: TDNMAction
      Category = 'Door'
      Caption = 'Door Comp List'
      ImageIndex = 126
      OnExecute = AnyActionExecute
      ClassExecute = 'TdoorCompGUI'
    end
  end
end
