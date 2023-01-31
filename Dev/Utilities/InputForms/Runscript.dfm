inherited RunScriptGUI: TRunScriptGUI
  Left = 395
  Top = 215
  HelpContext = 681000
  Caption = 'RunScriptGUI'
  ClientHeight = 404
  ClientWidth = 659
  ExplicitWidth = 667
  ExplicitHeight = 438
  PixelsPerInch = 96
  TextHeight = 13
  object Comments: TListBox
    Left = 497
    Top = 0
    Width = 162
    Height = 375
    HelpContext = 681001
    Align = alClient
    ItemHeight = 13
    TabOrder = 5
  end
  object files: TFileListBox
    Left = 257
    Top = 0
    Width = 240
    Height = 375
    HelpContext = 681002
    Align = alLeft
    ItemHeight = 13
    TabOrder = 0
  end
  object dbs: TListBox
    Left = 0
    Top = 0
    Width = 241
    Height = 375
    HelpContext = 681003
    Align = alLeft
    ItemHeight = 13
    TabOrder = 1
  end
  object btn: TButton
    Left = 528
    Top = 72
    Width = 75
    Height = 25
    HelpContext = 681004
    Caption = 'Run'
    TabOrder = 2
    OnClick = btnClick
  end
  object dbname: TListBox
    Left = 241
    Top = 0
    Width = 16
    Height = 375
    HelpContext = 681005
    Align = alLeft
    ItemHeight = 13
    TabOrder = 3
    Visible = False
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 375
    Width = 659
    Height = 29
    HelpContext = 681006
    Align = alBottom
    Step = 1
    TabOrder = 4
    Visible = False
  end
  object script: TERPScript
    BeforeExecute = scriptBeforeExecute
    AfterExecute = scriptAfterExecute
    OnError = scriptError
    Left = 536
    Top = 144
  end
end
