inherited frLicence: TfrLicence
  Width = 629
  Height = 95
  ExplicitWidth = 629
  ExplicitHeight = 95
  object lblID: TLabel [0]
    Left = 135
    Top = 6
    Width = 25
    Height = 15
    Caption = 'lblID'
  end
  object Label1: TLabel [1]
    Left = 5
    Top = 37
    Width = 54
    Height = 15
    Alignment = taRightJustify
    Caption = 'Start Date'
  end
  object Label2: TLabel [2]
    Left = 202
    Top = 37
    Width = 63
    Height = 15
    Alignment = taRightJustify
    Caption = 'Expire Date'
  end
  inherited Bevel1: TBevel
    Top = 85
    Width = 629
    ExplicitTop = 57
    ExplicitWidth = 619
  end
  object Label3: TLabel
    Left = 424
    Top = 6
    Width = 35
    Height = 15
    Alignment = taRightJustify
    Caption = 'Status'
  end
  object Label4: TLabel
    Left = 271
    Top = 6
    Width = 34
    Height = 15
    Alignment = taRightJustify
    Caption = 'Users'
  end
  object Label5: TLabel
    Left = 415
    Top = 35
    Width = 44
    Height = 15
    Alignment = taRightJustify
    Caption = 'Reason'
  end
  object Label6: TLabel
    Left = 26
    Top = 64
    Width = 33
    Height = 15
    Alignment = taRightJustify
    Caption = 'Notes'
  end
  object edtName: TEdit
    Left = 1
    Top = 3
    Width = 120
    Height = 23
    TabOrder = 0
  end
  object chkActive: TCheckBox
    Left = 202
    Top = 6
    Width = 53
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Active'
    TabOrder = 1
  end
  object dtStartDate: TwwDBDateTimePicker
    Left = 65
    Top = 32
    Width = 121
    Height = 23
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'Tahoma'
    CalendarAttributes.Font.Style = []
    Epoch = 1950
    ShowButton = True
    TabOrder = 2
  end
  object dtExpireDate: TwwDBDateTimePicker
    Left = 271
    Top = 32
    Width = 121
    Height = 23
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'Tahoma'
    CalendarAttributes.Font.Style = []
    Epoch = 1950
    ShowButton = True
    TabOrder = 3
  end
  object cboStatus: TComboBox
    Left = 465
    Top = 3
    Width = 145
    Height = 23
    Style = csDropDownList
    TabOrder = 4
    Items.Strings = (
      'lsUnknown'
      'lsPending'
      'lsLicenced'
      'lsHold'
      'lsCancelled'
      'lsReview'
      'lsExpired')
  end
  object edtUsers: TAdvEdit
    Left = 311
    Top = 3
    Width = 42
    Height = 23
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 5
    Text = '0'
    Visible = True
    Version = '2.8.6.9'
  end
  object edtStatusReason: TEdit
    Left = 465
    Top = 32
    Width = 145
    Height = 23
    TabOrder = 6
  end
  object edtNotes: TEdit
    Left = 65
    Top = 61
    Width = 545
    Height = 23
    TabOrder = 7
  end
end
