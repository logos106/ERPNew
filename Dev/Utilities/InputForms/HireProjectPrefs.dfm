object HireProjectPrefsGUI: THireProjectPrefsGUI
  Left = 168
  Top = 163
  Width = 915
  Height = 540
  VertScrollBar.Tracking = True
  Caption = 'Hire / Project Preferences'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblWidth: TLabel
    Left = 16
    Top = 8
    Width = 864
    Height = 22
    Caption = 
      'All panels should have a width of 545.  Panel TabOrder is used f' +
      'or panel placement sequence.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DNMPanel1: TDNMPanel
    Left = 8
    Top = 48
    Width = 545
    Height = 113
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      545
      113)
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 529
      Height = 97
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label1: TLabel
      Left = 14
      Top = 14
      Width = 78
      Height = 15
      Caption = 'Unit Bookings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 48
      Top = 40
      Width = 146
      Height = 15
      Caption = 'Only Show Qualified Crew'
      Transparent = True
    end
    object Label3: TLabel
      Left = 48
      Top = 72
      Width = 281
      Height = 15
      Caption = 'Calc from Leave Depot Time to Return Depot Time'
      Transparent = True
    end
    object wwCheckBox1: TwwCheckBox
      Left = 24
      Top = 40
      Width = 16
      Height = 17
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'wwCheckBox1'
      DataField = 'ShowOnlyQualifiedCrew'
      DataSource = dsPrefs
      TabOrder = 0
    end
    object wwCheckBox2: TwwCheckBox
      Left = 24
      Top = 72
      Width = 16
      Height = 17
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'wwCheckBox1'
      DataField = 'CalcUsingDepot'
      DataSource = dsPrefs
      TabOrder = 1
    end
  end
  object DNMPanel2: TDNMPanel
    Left = 8
    Top = 168
    Width = 545
    Height = 105
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      545
      105)
    object Bevel2: TBevel
      Left = 8
      Top = 8
      Width = 529
      Height = 89
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label4: TLabel
      Left = 14
      Top = 14
      Width = 138
      Height = 15
      Caption = 'Hours to Remind Before '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label40: TLabel
      Left = 24
      Top = 40
      Width = 133
      Height = 15
      Caption = 'Unit To Return To Depot'
      Transparent = True
    end
    object Label5: TLabel
      Left = 232
      Top = 40
      Width = 134
      Height = 15
      Caption = 'Employee'#39's End Of Shift'
      Transparent = True
    end
    object lblIgnore: TLabel
      Left = 24
      Top = 69
      Width = 176
      Height = 15
      Caption = 'Set to Zero to Disable Reminder'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object wwDBEdit1: TwwDBEdit
      Left = 168
      Top = 32
      Width = 35
      Height = 23
      DataField = 'BookingReminderInterval'
      DataSource = dsPersonalPreferences
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit2: TwwDBEdit
      Left = 376
      Top = 32
      Width = 35
      Height = 23
      DataField = 'EmployeeReminderInterval'
      DataSource = dsPersonalPreferences
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DNMPanel3: TDNMPanel
    Left = 8
    Top = 280
    Width = 545
    Height = 161
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      545
      161)
    object Bevel3: TBevel
      Left = 8
      Top = 8
      Width = 529
      Height = 145
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label6: TLabel
      Left = 14
      Top = 14
      Width = 114
      Height = 15
      Caption = 'Customisable Fields'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 24
      Top = 40
      Width = 104
      Height = 15
      Caption = 'Units Start Header'
      Transparent = True
    end
    object Label8: TLabel
      Left = 24
      Top = 96
      Width = 97
      Height = 15
      Caption = 'Units End Header'
      Transparent = True
    end
    object Label9: TLabel
      Left = 208
      Top = 40
      Width = 143
      Height = 15
      Caption = 'Unit Service Start Header'
      Transparent = True
    end
    object Label10: TLabel
      Left = 208
      Top = 96
      Width = 136
      Height = 15
      Caption = 'Unit Service End Header'
      Transparent = True
    end
    object wwDBEdit3: TwwDBEdit
      Left = 24
      Top = 56
      Width = 145
      Height = 23
      DataField = 'UnitBookingUnitStartHeader'
      DataSource = dsPrefs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit4: TwwDBEdit
      Left = 24
      Top = 112
      Width = 145
      Height = 23
      DataField = 'UnitBookingUnitEndHeader'
      DataSource = dsPrefs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit5: TwwDBEdit
      Left = 208
      Top = 56
      Width = 145
      Height = 23
      DataField = 'UnitBookingServiceStartHeader'
      DataSource = dsPrefs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit6: TwwDBEdit
      Left = 208
      Top = 112
      Width = 145
      Height = 23
      DataField = 'UnitBookingUnitEndHeader'
      DataSource = dsPrefs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object DNMPanel4: TDNMPanel
    Left = 8
    Top = 448
    Width = 545
    Height = 81
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      545
      81)
    object Bevel4: TBevel
      Left = 8
      Top = 8
      Width = 529
      Height = 65
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label11: TLabel
      Left = 14
      Top = 14
      Width = 48
      Height = 15
      Caption = 'Projects'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label12: TLabel
      Left = 48
      Top = 40
      Width = 217
      Height = 15
      Caption = 'Colours Indicate Project Task'#39's Status'
      Transparent = True
    end
    object wwCheckBox3: TwwCheckBox
      Left = 24
      Top = 40
      Width = 16
      Height = 17
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'wwCheckBox1'
      Checked = True
      DataField = 'PrjStatusColours'
      DataSource = dsPrefs
      State = cbChecked
      TabOrder = 0
    end
  end
  object DNMPanel5: TDNMPanel
    Left = 8
    Top = 536
    Width = 545
    Height = 169
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    DesignSize = (
      545
      169)
    object Bevel5: TBevel
      Left = 8
      Top = 8
      Width = 529
      Height = 153
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label13: TLabel
      Left = 14
      Top = 14
      Width = 70
      Height = 15
      Caption = 'General Hire'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label14: TLabel
      Left = 48
      Top = 40
      Width = 153
      Height = 15
      Caption = 'Allow Auto Period Changes'
      Transparent = True
    end
    object Label15: TLabel
      Left = 48
      Top = 72
      Width = 117
      Height = 15
      Caption = 'Use Ex Price for Hire'
      Transparent = True
    end
    object Label16: TLabel
      Left = 232
      Top = 40
      Width = 227
      Height = 15
      Caption = 'Annual Increase Rate in Hire Price (%ge)'
      Transparent = True
    end
    object Label17: TLabel
      Left = 24
      Top = 104
      Width = 151
      Height = 15
      Caption = 'Hire Description on Invoice'
      Transparent = True
    end
    object wwCheckBox4: TwwCheckBox
      Left = 24
      Top = 40
      Width = 16
      Height = 17
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'wwCheckBox1'
      DataField = 'AutoPeriodChange'
      DataSource = dsPrefs
      TabOrder = 0
    end
    object wwCheckBox5: TwwCheckBox
      Left = 24
      Top = 72
      Width = 16
      Height = 17
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'wwCheckBox1'
      DataField = 'UseExPriceForHire'
      DataSource = dsPrefs
      TabOrder = 1
    end
    object btnHireTemplate: TDNMSpeedButton
      Left = 351
      Top = 120
      Width = 114
      Height = 25
      Caption = 'Hire Template'
      Color = clWhite
      DisableTransparent = False
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentColor = False
      Style = bsModern
      TabOrder = 5
      OnClick = btnHireTemplateClick
    end
    object wwDBEdit7: TwwDBEdit
      Left = 472
      Top = 32
      Width = 35
      Height = 23
      DataField = 'AnnualHirePriceIncreaseRate'
      DataSource = dsPrefs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtHireDescription: TwwDBEdit
      Left = 24
      Top = 120
      Width = 161
      Height = 23
      DataField = 'HireInvoiceDescription'
      DataSource = dsPrefs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 191
      Top = 120
      Width = 66
      Height = 25
      Caption = 'Test'
      Color = clWhite
      DisableTransparent = False
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentColor = False
      Style = bsModern
      TabOrder = 3
      OnClick = DNMSpeedButton1Click
    end
    object btnDefaultHireInvoiceDesc: TDNMSpeedButton
      Left = 263
      Top = 120
      Width = 66
      Height = 25
      Caption = 'Default'
      Color = clWhite
      DisableTransparent = False
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentColor = False
      Style = bsModern
      TabOrder = 4
      OnClick = btnDefaultHireInvoiceDescClick
    end
  end
  object DNMPanel6: TDNMPanel
    Left = 8
    Top = 712
    Width = 545
    Height = 89
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    DesignSize = (
      545
      89)
    object Bevel6: TBevel
      Left = 8
      Top = 8
      Width = 529
      Height = 73
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label18: TLabel
      Left = 14
      Top = 14
      Width = 228
      Height = 15
      Caption = 'Warehouse Space Rental Product Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object cboSpaceRent: TwwDBLookupCombo
      Left = 24
      Top = 40
      Width = 201
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PartName'#9'40'#9'Part Name'#9'T'
        'PartType'#9'10'#9'Part Type'#9'T')
      DataField = 'SpaceRentPartName'
      DataSource = dsPrefs
      LookupTable = qryPartOther
      LookupField = 'PartName'
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
    end
  end
  object MyConnection: TMyConnection
    LoginPrompt = False
    Left = 600
    Top = 50
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'AnnualHirePriceIncreaseRate'
      'AutoPeriodChange'
      'CalcUsingDepot'
      'HireInvoiceDescription'
      'PrjStatusColours'
      'ShowOnlyQualifiedCrew'
      'SpaceRentPartName'
      'UnitBookingServiceEndHeader'
      'UnitBookingServiceStartHeader'
      'UnitBookingUnitEndHeader'
      'UnitBookingUnitStartHeader'
      'UseExPriceForHire')
    Left = 640
    Top = 50
  end
  object dsPersonalPreferences: TDataSource
    DataSet = qryPersonalPreferences
    Left = 680
    Top = 48
  end
  object qryPersonalPreferences: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblpersonalpreferences'
      'WHERE EmployeeID = :EmployeeID;')
    Left = 714
    Top = 48
    ParamData = <
      item
        DataType = ftString
        Name = 'EmployeeID'
        Value = ''
      end>
  end
  object qryPartOther: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PartName, PartType '
      'FROM tblParts'
      'WHERE PartType = '#39'OTHER'#39
      '')
    Left = 746
    Top = 48
  end
end
