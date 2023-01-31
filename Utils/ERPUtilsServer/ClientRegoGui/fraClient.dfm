inherited frClient: TfrClient
  Width = 596
  Height = 33
  ExplicitWidth = 596
  ExplicitHeight = 33
  inherited Bevel1: TBevel
    Top = 23
    Width = 596
    ExplicitTop = 23
    ExplicitWidth = 596
  end
  object Label1: TLabel
    Left = 410
    Top = 6
    Width = 25
    Height = 15
    Alignment = taRightJustify
    Caption = 'Type'
  end
  object lblID: TLabel
    Left = 256
    Top = 6
    Width = 25
    Height = 15
    Caption = 'lblID'
  end
  object edtName: TEdit
    Left = -1
    Top = 3
    Width = 245
    Height = 23
    TabOrder = 0
  end
  object cboReleaseType: TComboBox
    Left = 441
    Top = 3
    Width = 145
    Height = 23
    Style = csDropDownList
    TabOrder = 1
    Items.Strings = (
      'Production'
      'Production10'
      'Production11'
      'Production12'
      'Beta'
      'Alpha'
      'Dev')
  end
  object chkActive: TCheckBox
    Left = 337
    Top = 5
    Width = 53
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Active'
    TabOrder = 2
  end
end
