inherited dmAssessmentAddin: TdmAssessmentAddin
  OldCreateOrder = True
  Left = 608
  Top = 335
  Height = 153
  Width = 206
  object MainMenu: TAdvMainMenu
    Version = '2.5.1.1'
    Left = 34
    Top = 8
    object Assessment1: TMenuItem
      Caption = 'Assessment'
      GroupIndex = 60
      object Assessment2: TMenuItem
        Action = actAssessment
      end
      object AssessmentList1: TMenuItem
        Action = actAssessmentList
      end
      object AssessmentTypes1: TMenuItem
        Action = actAssessmentType
      end
      object AssessmentTypeList1: TMenuItem
        Action = actAssessmentTypeList
      end
      object AssessmentLabels1: TMenuItem
        Action = actAssessmentLabels
      end
      object AssessmentLabelsList1: TMenuItem
        Action = actAssessmentLabelsList
      end
    end
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 34
    Top = 61
    object actAssessmentLabels: TDNMAction
      Category = 'Assessment'
      Caption = 'Assessment Labels'
      ImageIndex = 114
      OnExecute = AnyActionExecute
      ClassExecute = 'TAssessmentLabelsGUI'
    end
    object actAssessmentLabelsList: TDNMAction
      Category = 'Assessment'
      Caption = 'Assessment Labels List'
      ImageIndex = 15
      OnExecute = AnyActionExecute
      ClassExecute = 'TAssessmentLabelsList'
    end
    object actAssessmentType: TDNMAction
      Category = 'Assessment'
      Caption = 'Assessment Types'
      ImageIndex = 137
      OnExecute = AnyActionExecute
      ClassExecute = 'TAssessmentTypeGUI'
    end
    object actAssessmentTypeList: TDNMAction
      Category = 'Assessment'
      Caption = 'Assessment Type List'
      ImageIndex = 366
      OnExecute = AnyActionExecute
      ClassExecute = 'TAssessmentTypeListGUI'
    end
    object actAssessment: TDNMAction
      Category = 'Assessment'
      Caption = 'Assessment'
      ImageIndex = 140
      OnExecute = AnyActionExecute
      ClassExecute = 'TAssessmentGUI'
    end
    object actAssessmentList: TDNMAction
      Category = 'Assessment'
      Caption = 'Assessment List'
      ImageIndex = 239
      OnExecute = AnyActionExecute
      ClassExecute = 'TAssessmentListGUI'
    end
  end
end
