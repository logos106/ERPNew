inherited dtWorkflow: TdtWorkflow
  OldCreateOrder = True
  Left = 438
  Top = 719
  object ActionList: TActionList
    Left = 20
    Top = 9
    object actStartRecording: TDNMAction
      Category = 'Workflow'
      Caption = 'Start Recording'
      GroupIndex = 140
      ImageIndex = 116
      OnExecute = DoStartrecording
      buttoncolor = clWhite
    end
    object actStoprecording: TDNMAction
      Category = 'Workflow'
      Caption = 'Stop Recording'
      GroupIndex = 140
      ImageIndex = 97
      OnExecute = DoStopRecording
      buttoncolor = clGreen
    end
    object actCancelrecording: TDNMAction
      Category = 'Workflow'
      Caption = 'Cancel Recording'
      GroupIndex = 140
      ImageIndex = 90
      OnExecute = DoCancelRecording
      buttoncolor = clRed
    end
    object actWorkflows: TDNMAction
      Category = 'Workflow'
      Caption = 'Work Flows'
      GroupIndex = 140
      ImageIndex = 64
      OnExecute = AnyActionExecute
      ClassExecute = 'TWorkflowsGUI'
      buttoncolor = clWhite
    end
    object actImportWorkflow: TDNMAction
      Category = 'Workflow'
      Caption = 'Import Workflow(s)'
      ImageIndex = 45
      OnExecute = actImportWorkflowExecute
      buttoncolor = clWhite
    end
    object actExportAllWorkflows: TDNMAction
      Category = 'Workflow'
      Caption = 'Export all Workflow(s)'
      ImageIndex = 129
      OnExecute = actExportAllWorkflowsExecute
      ClassExecute = 'TWorkflowsGUI'
      buttoncolor = clWhite
    end
  end
  object MainMenu: TAdvMainMenu
    Version = '2.5.3.4'
    Left = 77
    Top = 15
    object Workflow: TMenuItem
      Tag = 6
      Break = mbBarBreak
      Caption = 'Workflow'
      GroupIndex = 135
      ImageIndex = 337
      object CancelRecording1: TMenuItem
        Action = actStartRecording
        GroupIndex = 120
      end
      object StopRecording1: TMenuItem
        Action = actStoprecording
        GroupIndex = 120
      end
      object StopRecording2: TMenuItem
        Action = actCancelrecording
        GroupIndex = 120
      end
      object WorkFlows1: TMenuItem
        Action = actWorkflows
        GroupIndex = 120
      end
      object ExportAllWorkFlows1: TMenuItem
        Action = actExportAllWorkflows
        GroupIndex = 120
      end
      object ImportWorkflows1: TMenuItem
        Action = actImportWorkflow
        GroupIndex = 120
      end
    end
  end
end
