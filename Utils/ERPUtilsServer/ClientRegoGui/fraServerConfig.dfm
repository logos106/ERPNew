inherited frServerConfig: TfrServerConfig
  Width = 672
  Height = 34
  ExplicitWidth = 672
  ExplicitHeight = 34
  inherited Bevel1: TBevel
    Top = 24
    Width = 672
  end
  object Label1: TLabel
    Left = 3
    Top = 6
    Width = 36
    Height = 15
    Caption = 'Config'
  end
  object Label2: TLabel
    Left = 371
    Top = 6
    Width = 33
    Height = 15
    Caption = 'Notes'
  end
  object edtText: TEdit
    Left = 45
    Top = 3
    Width = 316
    Height = 23
    ReadOnly = True
    TabOrder = 0
    OnDblClick = edtTextDblClick
  end
  object edtNotes: TEdit
    Left = 410
    Top = 3
    Width = 255
    Height = 23
    TabOrder = 1
  end
end
