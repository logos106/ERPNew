inherited dtERPHelp: TdtERPHelp
  OldCreateOrder = True
  Height = 143
  Width = 172
  object ActionList: TActionList
    Left = 10
    Top = 7
    object actWiki: TDNMAction
      Caption = 'ERP Wiki'
      ImageIndex = 743
      OnExecute = actWikiExecute
      buttoncolor = clWhite
    end
    object actTrainingVideo: TDNMAction
      Caption = 'Training Video'
      ImageIndex = 249
      OnExecute = actTrainingVideoExecute
      buttoncolor = clWhite
    end
    object actTrainingDocs: TDNMAction
      Caption = 'Training Doc'
      ImageIndex = 655
      OnExecute = actTrainingDocsExecute
      buttoncolor = clWhite
    end
    object actformWiki: TDNMAction
      Caption = 'ERP Wiki'
      ImageIndex = 743
      OnExecute = actformWikiExecute
      buttoncolor = clWhite
    end
    object actFormTrainingVideo: TDNMAction
      Caption = 'Training Video'
      ImageIndex = 249
      OnExecute = actFormTrainingVideoExecute
      buttoncolor = clWhite
    end
    object actFormTrainingDocs: TDNMAction
      Caption = 'Training Doc'
      ImageIndex = 655
      OnExecute = actFormTrainingDocsExecute
      buttoncolor = clWhite
    end
    object actEdit: TDNMAction
      Caption = 'Edit'
      OnExecute = actEditExecute
      buttoncolor = clWhite
    end
  end
end
