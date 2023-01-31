inherited POSTillsPopUp: TPOSTillsPopUp
  Left = 108
  Top = 316
  HelpContext = 435000
  BorderStyle = bsDialog
  Caption = 'Till Assignments'
  ClientHeight = 565
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesigned
  ExplicitLeft = 108
  ExplicitTop = 316
  ExplicitHeight = 604
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 565
    ExplicitTop = 556
  end
  object Bevel1: TBevel [1]
    Left = 8
    Top = 348
    Width = 192
    Height = 52
    HelpContext = 435002
    Shape = bsFrame
  end
  object Label3: TLabel [2]
    Left = 16
    Top = 354
    Width = 177
    Height = 41
    HelpContext = 435003
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'NOTE: Select '#39'Multiple Tills'#39' using the Company Preferences Scre' +
      'en to enable these selections.'
    Transparent = True
    WordWrap = True
  end
  object Label6: TLabel [3]
    Left = 792
    Top = 1
    Width = 137
    Height = 57
    HelpContext = 435004
    AutoSize = False
    Caption = 
      'Printer Changes made here should be reflected in Company prefs a' +
      'nd Visa Versa'
    Color = clRed
    ParentColor = False
    Visible = False
    WordWrap = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 435056
  end
  object pnlTitle: TDNMPanel [9]
    Left = 343
    Top = 6
    Width = 266
    Height = 45
    HelpContext = 435053
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 262
      Height = 41
      HelpContext = 435054
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.4.0.0'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 262
        Height = 41
        HelpContext = 435055
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Till Assignments'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  object DNMPanel5: TDNMPanel [10]
    Left = 8
    Top = 402
    Width = 192
    Height = 160
    HelpContext = 435006
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 5
      Top = 4
      Width = 92
      Height = 15
      HelpContext = 435011
      Caption = 'Computer Name'
      Transparent = True
      WordWrap = True
    end
    object DBEdit9: TDBEdit
      Left = 7
      Top = 22
      Width = 174
      Height = 23
      Hint = 'Enter the name of the computer to which '
      HelpContext = 435016
      AutoSize = False
      DataField = 'ComputerName'
      DataSource = dsTills
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object DNMSpeedButton4: TDNMSpeedButton
      Left = 20
      Top = 53
      Width = 144
      Height = 29
      HelpContext = 435017
      Caption = 'Assign to My Computer'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 1
      OnClick = btnAssignClick
    end
    object DNMSpeedButton5: TDNMSpeedButton
      Left = 20
      Top = 88
      Width = 144
      Height = 29
      HelpContext = 435018
      Caption = 'Clear'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 2
      OnClick = btnUnassignClick
    end
    object DNMSpeedButton6: TDNMSpeedButton
      Left = 20
      Top = 124
      Width = 144
      Height = 29
      HelpContext = 435020
      Caption = 'Setup Customer Display'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 3
      OnClick = btnSetupCustomerDisplayClick
    end
  end
  object DNMPanel1: TDNMPanel [11]
    Left = 206
    Top = 64
    Width = 248
    Height = 465
    HelpContext = 435078
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Bevel2: TBevel
      Left = 56
      Top = 5
      Width = 129
      Height = 28
      HelpContext = 435079
      Shape = bsFrame
    end
    object Label2: TLabel
      Left = 64
      Top = 9
      Width = 113
      Height = 19
      HelpContext = 435080
      Alignment = taCenter
      AutoSize = False
      Caption = 'Till Details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object DNMPanel4: TDNMPanel
      Left = 4
      Top = 37
      Width = 239
      Height = 423
      HelpContext = 435081
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label24: TLabel
        Left = 134
        Top = 43
        Width = 32
        Height = 15
        HelpContext = 435012
        Caption = 'Class'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label25: TLabel
        Left = 5
        Top = 43
        Width = 90
        Height = 15
        HelpContext = 435010
        Caption = 'Primary Keypad'
        Transparent = True
      end
      object Label26: TLabel
        Left = 5
        Top = 5
        Width = 52
        Height = 15
        HelpContext = 435009
        Caption = 'Till Name'
        Transparent = True
      end
      object Label27: TLabel
        Left = 200
        Top = 398
        Width = 35
        Height = 15
        HelpContext = 435057
        Alignment = taRightJustify
        Caption = 'Active'
        Transparent = True
      end
      object Label17: TLabel
        Left = 5
        Top = 85
        Width = 53
        Height = 15
        HelpContext = 435082
        Alignment = taRightJustify
        Caption = 'Company'
        Transparent = True
      end
      object Label19: TLabel
        Left = 5
        Top = 127
        Width = 58
        Height = 15
        HelpContext = 435083
        Alignment = taRightJustify
        Caption = 'Address 1'
        Transparent = True
      end
      object Label20: TLabel
        Left = 5
        Top = 169
        Width = 58
        Height = 15
        HelpContext = 435084
        Alignment = taRightJustify
        Caption = 'Address 2'
        Transparent = True
      end
      object lblState: TLabel
        Left = 5
        Top = 253
        Width = 30
        Height = 15
        HelpContext = 435085
        Caption = 'State'
        Transparent = True
      end
      object Label22: TLabel
        Left = 134
        Top = 253
        Width = 54
        Height = 15
        HelpContext = 435086
        Alignment = taRightJustify
        Caption = 'Postcode'
        Transparent = True
      end
      object lblSuburb: TLabel
        Left = 5
        Top = 211
        Width = 21
        Height = 15
        HelpContext = 435087
        Caption = 'City'
        Transparent = True
      end
      object Label15: TLabel
        Left = 5
        Top = 295
        Width = 84
        Height = 15
        HelpContext = 435088
        Caption = 'Phone Number'
        Transparent = True
      end
      object Label23: TLabel
        Left = 134
        Top = 295
        Width = 67
        Height = 15
        HelpContext = 435089
        Caption = 'Fax number'
        Transparent = True
      end
      object Label31: TLabel
        Left = 5
        Top = 337
        Width = 131
        Height = 15
        HelpContext = 435062
        Caption = 'Default Template (POS)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label33: TLabel
        Left = 5
        Top = 379
        Width = 121
        Height = 15
        HelpContext = 435063
        Caption = 'Default Template (A4)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object DBCheckBox2: TDBCheckBox
        Left = 182
        Top = 397
        Width = 14
        Height = 17
        HelpContext = 435013
        Caption = 'Active'
        Color = 14211288
        DataField = 'Active'
        DataSource = dsTills
        ParentColor = False
        TabOrder = 11
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
      object edtTitle: TDBEdit
        Left = 5
        Top = 19
        Width = 228
        Height = 23
        HelpContext = 435014
        DataField = 'TillName'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object wwDBLookupCombo1: TwwDBLookupCombo
        Left = 5
        Top = 60
        Width = 92
        Height = 23
        HelpContext = 435015
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Description'#9'20'#9'Description'#9#9)
        DataField = 'PrimaryPadID'
        DataSource = dsTills
        LookupTable = qryPads
        LookupField = 'KeypadID'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo2: TwwDBLookupCombo
        Left = 134
        Top = 60
        Width = 92
        Height = 23
        HelpContext = 435019
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ClassName'#9'20'#9'ClassName'#9'F')
        DataField = 'ClassID'
        DataSource = dsTills
        LookupTable = cboClassQry
        LookupField = 'ClassID'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
      end
      object DBEdit1: TDBEdit
        Left = 5
        Top = 102
        Width = 228
        Height = 23
        HelpContext = 435090
        DataField = 'Company'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object DBEdit2: TDBEdit
        Left = 5
        Top = 144
        Width = 228
        Height = 23
        HelpContext = 435091
        DataField = 'Address1'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object DBEdit3: TDBEdit
        Left = 5
        Top = 185
        Width = 228
        Height = 23
        HelpContext = 435092
        DataField = 'Address2'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object DBEdit4: TDBEdit
        Left = 5
        Top = 269
        Width = 118
        Height = 23
        HelpContext = 435093
        DataField = 'State'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object DBEdit5: TDBEdit
        Left = 134
        Top = 269
        Width = 99
        Height = 23
        HelpContext = 435094
        DataField = 'PostCode'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object DBEdit6: TDBEdit
        Left = 5
        Top = 227
        Width = 227
        Height = 23
        HelpContext = 435095
        DataField = 'city'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object DBEdit7: TDBEdit
        Left = 5
        Top = 310
        Width = 118
        Height = 23
        HelpContext = 435096
        DataField = 'phonenumber'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object DBEdit8: TDBEdit
        Left = 134
        Top = 310
        Width = 99
        Height = 23
        HelpContext = 435097
        DataField = 'faxnumber'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object cboInvoiceTemplate: TwwDBLookupCombo
        Left = 5
        Top = 352
        Width = 151
        Height = 23
        HelpContext = 435064
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'TemplName'#9'20'#9'Name'#9'T')
        DataField = 'DefaultTemplateID'
        DataSource = dsTills
        LookupTable = qryPOSTemplates
        LookupField = 'TemplID'
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
      end
      object cboa4Template: TwwDBLookupCombo
        Left = 5
        Top = 394
        Width = 151
        Height = 23
        HelpContext = 435065
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'TemplName'#9'20'#9'Name'#9'T')
        DataField = 'DefaultA4TemplateID'
        DataSource = dsTills
        LookupTable = QryCashSaleTemplates
        LookupField = 'TemplID'
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
      end
    end
  end
  object grdTills: TDBGrid [12]
    Left = 8
    Top = 64
    Width = 192
    Height = 281
    HelpContext = 435005
    TabStop = False
    DataSource = dsTills
    FixedColor = 14211288
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'TillName'
        Title.Caption = 'Till Name'
        Width = 158
        Visible = True
      end>
  end
  object DNMPanel6: TDNMPanel [13]
    Left = 460
    Top = 394
    Width = 485
    Height = 168
    HelpContext = 435066
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object Bevel5: TBevel
      Left = 3
      Top = 22
      Width = 238
      Height = 80
      HelpContext = 435098
      Shape = bsFrame
    end
    object Label32: TLabel
      Left = 9
      Top = 48
      Width = 74
      Height = 15
      HelpContext = 435067
      Caption = 'Device Name'
      Transparent = True
    end
    object Bevel6: TBevel
      Left = 243
      Top = 22
      Width = 238
      Height = 80
      HelpContext = 435099
      Shape = bsFrame
    end
    object Label21: TLabel
      Left = 30
      Top = 29
      Width = 57
      Height = 15
      HelpContext = 435100
      Caption = 'Use Scale'
      Transparent = True
    end
    object Label29: TLabel
      Left = 4
      Top = 4
      Width = 113
      Height = 15
      HelpContext = 435101
      Caption = 'OPOS Configuration'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label30: TLabel
      Left = 270
      Top = 29
      Width = 73
      Height = 15
      HelpContext = 435102
      Caption = 'Use Scanner'
      Transparent = True
    end
    object lblScannerDevice: TLabel
      Left = 247
      Top = 48
      Width = 74
      Height = 15
      HelpContext = 435068
      Caption = 'Device Name'
      Transparent = True
    end
    object wwCheckBox3: TwwCheckBox
      Left = 9
      Top = 28
      Width = 17
      Height = 17
      HelpContext = 435103
      DisableThemes = False
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
      DataField = 'UseScale'
      DataSource = dsTills
      TabOrder = 0
      OnClick = wwCheckBox2Click
    end
    object cboScales: TDBComboBox
      Left = 9
      Top = 65
      Width = 190
      Height = 23
      HelpContext = 435069
      DataField = 'ScaleDeviceName'
      DataSource = dsTills
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnDropDown = cbopolePortDropDown
    end
    object wwCheckBox4: TwwCheckBox
      Left = 247
      Top = 28
      Width = 17
      Height = 17
      HelpContext = 435104
      DisableThemes = False
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
      DataField = 'UseScanner'
      DataSource = dsTills
      TabOrder = 2
      OnClick = wwCheckBox2Click
    end
    object cboscanners: TDBComboBox
      Left = 247
      Top = 65
      Width = 190
      Height = 23
      HelpContext = 435070
      DataField = 'ScannerDeviceName'
      DataSource = dsTills
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnDropDown = cbopolePortDropDown
    end
    object btnscaleDetails: TDNMSpeedButton
      Left = 204
      Top = 65
      Width = 21
      Height = 23
      HelpContext = 435071
      Caption = '. . .'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 4
      OnClick = btnscaleDetailsClick
    end
    object btnScannerDetails: TDNMSpeedButton
      Left = 439
      Top = 65
      Width = 21
      Height = 23
      HelpContext = 435072
      Caption = '. . .'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 5
      OnClick = btnScannerDetailsClick
    end
    object DNMPanel3: TDNMPanel
      Left = 3
      Top = 104
      Width = 477
      Height = 60
      HelpContext = 435073
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object Label7: TLabel
        Left = 30
        Top = 4
        Width = 93
        Height = 15
        HelpContext = 435105
        Caption = 'Use Pole display'
        Transparent = True
      end
      object lblpolePort: TLabel
        Left = 35
        Top = 35
        Width = 52
        Height = 15
        HelpContext = 435074
        Caption = 'Pole Port'
        Transparent = True
      end
      object Label28: TLabel
        Left = 260
        Top = 35
        Width = 68
        Height = 15
        HelpContext = 435075
        Caption = 'Display type'
        Transparent = True
      end
      object wwCheckBox2: TwwCheckBox
        Left = 9
        Top = 3
        Width = 17
        Height = 17
        HelpContext = 435106
        DisableThemes = False
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
        DataField = 'UsePoledisplay'
        DataSource = dsTills
        TabOrder = 0
        OnClick = wwCheckBox2Click
      end
      object cbopolePort: TDBComboBox
        Left = 93
        Top = 31
        Width = 132
        Height = 23
        HelpContext = 435076
        DataField = 'PolePort'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Items.Strings = (
          'None'
          'COM1'
          'COM2'
          'COM3'
          'COM4'
          'COM5'
          'COM6'
          'COM7'
          'COM8')
        ParentFont = False
        TabOrder = 1
        OnDropDown = cbopolePortDropDown
      end
      object DBComboBox1: TDBComboBox
        Left = 332
        Top = 31
        Width = 125
        Height = 23
        HelpContext = 435077
        DataField = 'PoleDisplayName'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Items.Strings = (
          'VFD 860'
          'GIGATEK DSP 830')
        ParentFont = False
        TabOrder = 2
        OnDropDown = cbopolePortDropDown
      end
    end
  end
  object btnSave: TDNMSpeedButton [14]
    Left = 226
    Top = 535
    Width = 87
    Height = 27
    HelpContext = 435021
    Caption = '&Save'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton [15]
    Left = 331
    Top = 535
    Width = 87
    Height = 27
    HelpContext = 435022
    Cancel = True
    Caption = '&Cancel'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object pnlPrinter: TDNMPanel [16]
    Left = 461
    Top = 64
    Width = 484
    Height = 329
    HelpContext = 435023
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Bevel14: TBevel
      Left = 174
      Top = 6
      Width = 129
      Height = 28
      HelpContext = 435041
      Shape = bsFrame
    end
    object Label10: TLabel
      Left = 182
      Top = 10
      Width = 113
      Height = 19
      HelpContext = 435043
      Caption = 'Receipt Printer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object pnlSpooler: TDNMPanel
      Left = 8
      Top = 221
      Width = 229
      Height = 103
      HelpContext = 435024
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      TabStop = True
      object Label12: TLabel
        Left = 40
        Top = 13
        Width = 99
        Height = 15
        HelpContext = 435025
        Caption = 'Use Print Spooler'
        Transparent = True
      end
      object chkUseSpooler: TwwCheckBox
        Left = 19
        Top = 11
        Width = 17
        Height = 17
        HelpContext = 435026
        DisableThemes = False
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
        DataField = 'UsePrintSpooler'
        DataSource = dsTills
        TabOrder = 0
        OnClick = chkUseSpoolerClick
      end
      object pnlSpoolerTill: TDNMPanel
        Left = 3
        Top = 32
        Width = 223
        Height = 66
        HelpContext = 435027
        BevelOuter = bvLowered
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label9: TLabel
          Left = 9
          Top = 12
          Width = 63
          Height = 15
          HelpContext = 435028
          Caption = 'Spooler Till'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label14: TLabel
          Left = 28
          Top = 41
          Width = 149
          Height = 15
          HelpContext = 435029
          Caption = 'Kick Spooler Cash Drawer'
          Transparent = True
        end
        object cboSpooler: TwwDBLookupCombo
          Left = 78
          Top = 7
          Width = 137
          Height = 23
          HelpContext = 435030
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'TillName'#9'30'#9'TillName'#9#9)
          DataField = 'RemoteTillID'
          DataSource = dsTills
          LookupTable = qryTillsLookup
          LookupField = 'TillID'
          ParentFont = False
          TabOrder = 0
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object wwCheckBox1: TwwCheckBox
          Left = 10
          Top = 40
          Width = 14
          Height = 17
          HelpContext = 435031
          DisableThemes = False
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
          DataField = 'EnableKickRemoteDrawer'
          DataSource = dsTills
          TabOrder = 1
          OnClick = chkUseLocalCashDrawerClick
        end
      end
    end
    object pnlPrintConfig: TDNMPanel
      Left = 243
      Top = 38
      Width = 233
      Height = 286
      HelpContext = 435032
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Bevel4: TBevel
        Left = 10
        Top = 241
        Width = 215
        Height = 31
        HelpContext = 435058
      end
      object Bevel3: TBevel
        Left = 10
        Top = 206
        Width = 215
        Height = 31
        HelpContext = 435059
      end
      object Label155: TLabel
        Left = 9
        Top = 14
        Width = 68
        Height = 15
        HelpContext = 435034
        Caption = 'Printer Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object lblUSBPrinter: TLabel
        Left = 9
        Top = 163
        Width = 66
        Height = 15
        HelpContext = 435060
        Caption = 'USB Printer'
        Transparent = True
      end
      object Label13: TLabel
        Left = 51
        Top = 214
        Width = 108
        Height = 15
        HelpContext = 435035
        Caption = 'Local Cash Drawer'
        Transparent = True
      end
      object Label8: TLabel
        Left = 51
        Top = 249
        Width = 127
        Height = 15
        HelpContext = 435033
        Caption = 'Use Cash Drawer Only'
        Transparent = True
      end
      object chkUseLocalCashDrawer: TwwCheckBox
        Left = 26
        Top = 213
        Width = 17
        Height = 17
        HelpContext = 435039
        DisableThemes = False
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
        Caption = 'Use Local Cash Drawer'
        Checked = True
        DataField = 'UseLocalDrawer'
        DataSource = dsTills
        State = cbChecked
        TabOrder = 3
        OnClick = chkUseLocalCashDrawerClick
      end
      object grpPrnPorts: TDBRadioGroup
        Left = 9
        Top = 41
        Width = 218
        Height = 117
        HelpContext = 435036
        Caption = 'Receipt Printer Port'
        Color = 14276567
        Columns = 3
        DataField = 'ReceiptPrinterPort'
        DataSource = dsTills
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Items.Strings = (
          'None'
          'Com4'
          'Com1'
          'Lpt1'
          'Com2'
          'Lpt2'
          'Com3')
        ParentBackground = True
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        TabStop = True
        Values.Strings = (
          'NUL:'
          'COM4:'
          'COM1:'
          'LPT1:'
          'COM2:'
          'LPT2:'
          'COM3:')
      end
      object cboPrinterType: TwwDBComboBox
        Left = 83
        Top = 10
        Width = 146
        Height = 23
        HelpContext = 435038
        ShowButton = True
        Style = csDropDownList
        MapList = True
        AllowClearKey = False
        DataField = 'ReceiptPrinterType'
        DataSource = dsTills
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Epson'#9'EPSON'
          'Star'#9'STAR'
          'Citizen'#9'CITIZEN'
          'Citizen iDP460'#9'CTZ460'
          'Citizen iDP3540'#9'CTZ3540'
          'Hero TH200'#9'HERO'
          'Eltron Companion'#9'COMPANION'
          'Epson TM-U220 Series on USB'#9'EPSON-TM-U220'
          'Epson TM-T82II Series on USB'#9'EPSON-TM-T82II'
          'STAR TSP-100 Series on USB'#9'STAR-TSP-100')
        ItemIndex = 0
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
        OnChange = cboPrinterTypeChange
      end
      object cboUSBPrinter: TDBComboBox
        Left = 8
        Top = 181
        Width = 218
        Height = 23
        HelpContext = 435061
        DataField = 'USBPrinterName'
        DataSource = dsTills
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnDropDown = cboUSBPrinterDropDown
      end
      object chkCashDrawerOnly: TwwCheckBox
        Left = 26
        Top = 248
        Width = 17
        Height = 17
        HelpContext = 435037
        DisableThemes = False
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
        Caption = 'chkUsePrn'
        DataField = 'UseCashDrawerOnly'
        DataSource = dsTills
        TabOrder = 4
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 8
      Top = 37
      Width = 229
      Height = 181
      HelpContext = 435040
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
      object Label5: TLabel
        Left = 29
        Top = 51
        Width = 157
        Height = 15
        HelpContext = 435042
        AutoSize = False
        Caption = 'Use Default Printer Settings'
        Transparent = True
      end
      object Label4: TLabel
        Left = 29
        Top = 17
        Width = 110
        Height = 15
        HelpContext = 435044
        AutoSize = False
        Caption = 'Use Receipt Printer'
        Transparent = True
      end
      object Label11: TLabel
        Left = 29
        Top = 85
        Width = 97
        Height = 15
        HelpContext = 435045
        AutoSize = False
        Caption = 'Is a Print Spooler'
        Transparent = True
      end
      object Label16: TLabel
        Left = 29
        Top = 119
        Width = 184
        Height = 15
        HelpContext = 435046
        AutoSize = False
        Caption = 'Print Receipts On Complete Sale'
        Transparent = True
      end
      object Label18: TLabel
        Left = 29
        Top = 153
        Width = 167
        Height = 15
        HelpContext = 435047
        AutoSize = False
        Caption = 'Multiple Lines For Description'
        Transparent = True
      end
      object chkUseDefault: TwwCheckBox
        Left = 6
        Top = 50
        Width = 17
        Height = 17
        HelpContext = 435048
        DisableThemes = False
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
        Caption = 'chkUseDefault'
        Checked = True
        DataField = 'UseDefaultPrinter'
        DataSource = dsTills
        State = cbChecked
        TabOrder = 1
        OnClick = chkUseDefaultClick
      end
      object chkUsePrn: TwwCheckBox
        Left = 6
        Top = 16
        Width = 17
        Height = 17
        Hint = 'If you have a receipt printer atta'
        HelpContext = 435049
        DisableThemes = False
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
        Caption = 'chkUsePrn'
        DataField = 'ReceiptPrinterOn'
        DataSource = dsTills
        TabOrder = 0
        OnClick = chkUsePrnClick
      end
      object chkIsSpooler: TwwCheckBox
        Left = 6
        Top = 84
        Width = 17
        Height = 17
        HelpContext = 435050
        DisableThemes = False
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
        DataField = 'IsPrintSpooler'
        DataSource = dsTills
        TabOrder = 2
        OnClick = chkIsSpoolerClick
      end
      object chkPOSPrintReceiptOnCompleteSale: TwwCheckBox
        Left = 6
        Top = 118
        Width = 17
        Height = 17
        HelpContext = 435051
        DisableThemes = False
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
        Checked = True
        DataField = 'POSPrintReceiptOnlyOnCompleteSale'
        DataSource = dsTills
        State = cbChecked
        TabOrder = 3
        OnClick = chkPOSPrintReceiptOnCompleteSaleClick
      end
      object chkPOSPrintMultipleLines: TwwCheckBox
        Left = 6
        Top = 152
        Width = 17
        Height = 17
        HelpContext = 435052
        DisableThemes = False
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
        DataField = 'POSPrintDescriptionMultipleLines'
        DataSource = dsTills
        TabOrder = 4
        OnClick = chkPOSPrintMultipleLinesClick
      end
    end
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102007400780010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  object dsTills: TDataSource
    DataSet = qryTills
    Left = 40
    Top = 152
  end
  object qryTills: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT TillID, TillName, PrimaryPadID, UseDefaultPrinter, Receip' +
        'tPrinterOn, '
      
        'ReceiptPrinterPort, ReceiptPrinterType, Active, EditedFlag, Comp' +
        'uterName,'
      
        'UseCashDrawerOnly, IsPrintSpooler, RemoteTillID, UsePrintSpooler' +
        ', '
      'UseLocalDrawer,ClassID,EnableKickRemoteDrawer,'
      'POSPrintReceiptOnlyOnCompleteSale,'
      'POSPrintDescriptionMultipleLines, '
      
        'company, Address1, Address2, city, State, PostCode, phonenumber,' +
        ' faxnumber, USBPrinterName , UsePoledisplay , PolePort,'
      
        'UseScale,UseScanner,ScaleDeviceName,ScannerDeviceName , PoleDisp' +
        'layName,DefaultTemplateID,DefaultA4TemplateID'
      'FROM tblPOSTills')
    BeforePost = qryTillsBeforePost
    BeforeScroll = qryTillsBeforeScroll
    AfterScroll = qryTillsAfterScroll
    Left = 40
    Top = 184
    object qryTillsTillID: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'TillID'
      Origin = 'tblpostills.TillID'
    end
    object qryTillsTillName: TWideStringField
      FieldName = 'TillName'
      Origin = 'tblpostills.TillName'
      Size = 30
    end
    object qryTillsPrimaryPadID: TWordField
      FieldName = 'PrimaryPadID'
      Origin = 'tblpostills.PrimaryPadID'
    end
    object qryTillsUseDefaultPrinter: TWideStringField
      FieldName = 'UseDefaultPrinter'
      Origin = 'tblpostills.UseDefaultPrinter'
      OnChange = qryTillsUseDefaultPrinterChange
      FixedChar = True
      Size = 1
    end
    object qryTillsReceiptPrinterOn: TWideStringField
      FieldName = 'ReceiptPrinterOn'
      Origin = 'tblpostills.ReceiptPrinterOn'
      FixedChar = True
      Size = 1
    end
    object qryTillsReceiptPrinterPort: TWideStringField
      FieldName = 'ReceiptPrinterPort'
      Origin = 'tblpostills.ReceiptPrinterPort'
      FixedChar = True
      Size = 5
    end
    object qryTillsReceiptPrinterType: TWideStringField
      FieldName = 'ReceiptPrinterType'
      Origin = 'tblpostills.ReceiptPrinterType'
      FixedChar = True
      Size = 255
    end
    object qryTillsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblpostills.Active'
      FixedChar = True
      Size = 1
    end
    object qryTillsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblpostills.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryTillsComputerName: TWideStringField
      FieldName = 'ComputerName'
      Origin = 'tblpostills.ComputerName'
      Size = 255
    end
    object qryTillsUseCashDrawerOnly: TWideStringField
      FieldName = 'UseCashDrawerOnly'
      Origin = 'tblpostills.UseCashDrawerOnly'
      FixedChar = True
      Size = 1
    end
    object qryTillsIsPrintSpooler: TWideStringField
      FieldName = 'IsPrintSpooler'
      Origin = 'tblpostills.IsPrintSpooler'
      FixedChar = True
      Size = 1
    end
    object qryTillsRemoteTillID: TSmallintField
      FieldName = 'RemoteTillID'
      Origin = 'tblpostills.RemoteTillID'
    end
    object qryTillsUsePrintSpooler: TWideStringField
      FieldName = 'UsePrintSpooler'
      Origin = 'tblpostills.UsePrintSpooler'
      FixedChar = True
      Size = 1
    end
    object qryTillsUseLocalDrawer: TWideStringField
      FieldName = 'UseLocalDrawer'
      Origin = 'tblpostills.UseLocalDrawer'
      FixedChar = True
      Size = 1
    end
    object qryTillsClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblpostills.ClassID'
    end
    object qryTillsEnableKickRemoteDrawer: TWideStringField
      FieldName = 'EnableKickRemoteDrawer'
      Origin = 'tblpostills.EnableKickRemoteDrawer'
      FixedChar = True
      Size = 1
    end
    object qryTillsPOSPrintReceiptOnlyOnCompleteSale: TWideStringField
      FieldName = 'POSPrintReceiptOnlyOnCompleteSale'
      Origin = 'tblpostills.POSPrintReceiptOnlyOnCompleteSale'
      FixedChar = True
      Size = 1
    end
    object qryTillsPOSPrintDescriptionMultipleLines: TWideStringField
      FieldName = 'POSPrintDescriptionMultipleLines'
      Origin = 'tblpostills.POSPrintDescriptionMultipleLines'
      FixedChar = True
      Size = 1
    end
    object qryTillscompany: TWideStringField
      FieldName = 'company'
      Origin = 'tblpostills.Company'
      Size = 255
    end
    object qryTillsAddress1: TWideStringField
      FieldName = 'Address1'
      Origin = 'tblpostills.Address1'
      Size = 255
    end
    object qryTillsAddress2: TWideStringField
      FieldName = 'Address2'
      Origin = 'tblpostills.Address2'
      Size = 255
    end
    object qryTillsState: TWideStringField
      FieldName = 'State'
      Origin = 'tblpostills.State'
      Size = 30
    end
    object qryTillsPostCode: TWideStringField
      FieldName = 'PostCode'
      Origin = 'tblpostills.PostCode'
      Size = 4
    end
    object qryTillscity: TWideStringField
      FieldName = 'city'
      Origin = 'tblpostills.CITY'
      Size = 100
    end
    object qryTillsphonenumber: TWideStringField
      FieldName = 'phonenumber'
      Origin = 'tblpostills.PHONENUMBER'
      Size = 30
    end
    object qryTillsfaxnumber: TWideStringField
      FieldName = 'faxnumber'
      Origin = 'tblpostills.FAXNUMBER'
      Size = 30
    end
    object qryTillsUSBPrinterName: TWideStringField
      FieldName = 'USBPrinterName'
      Origin = 'tblpostills.USBPrinterName'
      Size = 100
    end
    object qryTillsUsePoledisplay: TWideStringField
      FieldName = 'UsePoledisplay'
      Origin = 'tblpostills.UsePoledisplay'
      FixedChar = True
      Size = 1
    end
    object qryTillsPolePort: TWideStringField
      FieldName = 'PolePort'
      Origin = 'tblpostills.PolePort'
      Size = 50
    end
    object qryTillsUseScale: TWideStringField
      FieldName = 'UseScale'
      Origin = 'tblpostills.UseScale'
      FixedChar = True
      Size = 1
    end
    object qryTillsUseScanner: TWideStringField
      FieldName = 'UseScanner'
      Origin = 'tblpostills.UseScanner'
      FixedChar = True
      Size = 1
    end
    object qryTillsScaleDeviceName: TWideStringField
      FieldName = 'ScaleDeviceName'
      Origin = 'tblpostills.ScaleDeviceName'
      Size = 50
    end
    object qryTillsScannerDeviceName: TWideStringField
      FieldName = 'ScannerDeviceName'
      Origin = 'tblpostills.ScannerDeviceName'
      Size = 50
    end
    object qryTillsPoleDisplayName: TWideStringField
      FieldName = 'PoleDisplayName'
      Origin = 'tblpostills.PoleDisplayName'
    end
    object qryTillsDefaultTemplateID: TIntegerField
      FieldName = 'DefaultTemplateID'
      Origin = 'tblpostills.DefaultTemplateID'
    end
    object qryTillsDefaultA4TemplateID: TIntegerField
      FieldName = 'DefaultA4TemplateID'
      Origin = 'tblpostills.DefaultA4TemplateID'
    end
  end
  object dsPadsX: TDataSource
    DataSet = qryPads
    Left = 405
    Top = 88
  end
  object qryPads: TERPQuery
    SQL.Strings = (
      'SELECT KeypadID, Description FROM tblPOSKeypads'
      'WHERE Active = '#39'T'#39)
    Left = 397
    Top = 176
  end
  object qryTillsLookup: TERPQuery
    SQL.Strings = (
      'SELECT TillID, TillName'
      'FROM tblPOSTills')
    Left = 416
    Top = 48
  end
  object cboClassQry: TERPQuery
    SQL.Strings = (
      'SELECT ClassID, ClassName '
      'FROM tblClass '
      'WHERE Active='#39'T'#39' AND ClassName Is Not Null'
      'ORDER BY ClassName;')
    Left = 396
    Top = 245
  end
  object qryPOSTemplates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT TemplID,TemplName FROM `tbltemplates`  WHERE `TypeID` in ' +
        '(select typeID from tbltemplatetype where TypeName = '#39'POS - Rece' +
        'ipt Printer'#39')')
    Options.LongStrings = False
    Left = 204
    Top = 41
    object qryPOSTemplatesTemplName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'TemplName'
      Size = 30
    end
    object qryPOSTemplatesTemplID: TIntegerField
      FieldName = 'TemplID'
      Visible = False
    end
  end
  object QryCashSaleTemplates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT TemplID,TemplName FROM `tbltemplates`  WHERE `TypeID` in ' +
        '(select typeID from tbltemplatetype where TypeName = '#39'Cash Sale'#39 +
        ')')
    Options.LongStrings = False
    Left = 236
    Top = 41
    object WideStringField1: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'TemplName'
      Size = 30
    end
    object IntegerField1: TIntegerField
      FieldName = 'TemplID'
      Visible = False
    end
  end
end
