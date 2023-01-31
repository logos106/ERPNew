inherited dtTraining: TdtTraining
  OldCreateOrder = True
  Height = 167
  Width = 235
  object ActionList: TActionList
    Left = 10
    Top = 7
    object actTrainingAssignment: TDNMAction
      Category = 'Training'
      Caption = 'Training Assignment'
      ImageIndex = 165
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmTrainingAssignment'
      buttoncolor = clWhite
    end
    object actTrainingRoster: TDNMAction
      Category = 'Training'
      Caption = 'Training Roster'
      ImageIndex = 673
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmTrainingRoster'
      buttoncolor = clWhite
    end
    object actTrainingProgresschart: TDNMAction
      Category = 'Training'
      Caption = 'Training Progress Chart'
      ImageIndex = 328
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmTrainingStatusChart'
      buttoncolor = clWhite
    end
    object actTrainingStatus: TDNMAction
      Category = 'Training'
      Caption = 'Training Status'
      ImageIndex = 325
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmTrainingStatus'
      buttoncolor = clWhite
    end
    object actTrainingModule: TDNMAction
      Category = 'Training'
      Caption = 'Training Modules'
      ImageIndex = 244
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmTrainingModules'
      buttoncolor = clWhite
    end
    object actSetupTraining: TDNMAction
      Category = 'Training'
      Caption = 'Setup Training'
      ImageIndex = 259
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmERPTrainingSetup'
      buttoncolor = clWhite
    end
    object actVideos: TDNMAction
      Category = 'Training'
      Caption = 'Videos'
      ImageIndex = 249
      OnExecute = AnyActionExecute
      ClassExecute = 'TERPTrainingVideosGUI'
      buttoncolor = clWhite
    end
    object actCustomisetraining: TDNMAction
      Category = 'Training'
      Caption = 'Customise'
      ImageIndex = 289
      OnExecute = actCustomisetrainingExecute
      buttoncolor = clWhite
    end
    object actSetupcompany: TDNMAction
      Category = 'Training'
      Caption = 'Setup Company'
      ImageIndex = 287
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmERPSetup'
      buttoncolor = clWhite
    end
    object actTrainingList: TDNMAction
      Category = 'Training'
      Caption = 'Training Group List'
      ImageIndex = 230
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmTrainingList'
      buttoncolor = clWhite
    end
    object actGoLive: TDNMAction
      Category = 'Training'
      Caption = 'Go Live'
      ImageIndex = 502
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmProjectGoLive'
      buttoncolor = clWhite
    end
    object actHowToList: TDNMAction
      Category = 'Training'
      Caption = 'How To List'
      ImageIndex = 653
      OnExecute = AnyActionExecute
      ClassExecute = 'THowToListGUI'
      buttoncolor = clWhite
    end
    object actTrainingDocs: TDNMAction
      Category = 'Training'
      Caption = 'Training Docs'
      ImageIndex = 655
      OnExecute = AnyActionExecute
      ClassExecute = 'TTrainingDocsGUI'
      buttoncolor = clWhite
    end
    object actHRForm: TDNMAction
      Category = 'Training'
      Caption = 'HR Form'
      ImageIndex = 681
      OnExecute = AnyActionExecute
      ClassExecute = 'TfmHRForm'
      buttoncolor = clWhite
    end
    object actHRForms: TDNMAction
      Category = 'Training'
      Caption = 'HR List'
      ImageIndex = 721
      OnExecute = AnyActionExecute
      ClassExecute = 'THRFormsGUI'
      buttoncolor = clWhite
    end
  end
  object MainMenu: TAdvMainMenu
    Version = '2.5.3.4'
    Left = 57
    Top = 8
    object rainingAssignment1: TMenuItem
      Caption = 'Training'
      GroupIndex = 85
      ImageIndex = 44
      OnClick = AnyActionExecute
      object rainingAssignment2: TMenuItem
        Action = actTrainingAssignment
      end
      object rainingModules1: TMenuItem
        Action = actTrainingModule
      end
      object rainingProgressChart1: TMenuItem
        Action = actTrainingProgresschart
      end
      object rainingRoster1: TMenuItem
        Action = actTrainingRoster
      end
      object rainingStatus1: TMenuItem
        Action = actTrainingStatus
      end
      object GoLive1: TMenuItem
        Action = actGoLive
      end
      object trainingDocs1: TMenuItem
        Action = actTrainingDocs
      end
      object HRForm1: TMenuItem
        Caption = 'HR Form'
        GroupIndex = 190
        object HRForm3: TMenuItem
          Action = actHRForm
        end
        object HRForm2: TMenuItem
          Action = actHRForms
        end
      end
    end
  end
end
