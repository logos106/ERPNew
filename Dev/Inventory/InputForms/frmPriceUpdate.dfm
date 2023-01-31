inherited PriceUpdateGUI: TPriceUpdateGUI
  Left = 803
  Top = 203
  HelpContext = 439000
  Caption = 'Data Update'
  ClientHeight = 567
  OldCreateOrder = True
  ExplicitLeft = 803
  ExplicitTop = 203
  ExplicitHeight = 594
  DesignSize = (
    949
    567)
  PixelsPerInch = 96
  TextHeight = 15
  object lblNotice: TLabel [0]
    Left = 80
    Top = 452
    Width = 654
    Height = 22
    HelpContext = 439002
    Caption = 
      'NOTE: Price change will be based on a minimum above cost of xx.x' +
      'x %'
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    Visible = False
  end
  inherited imgGridWatermark: TImage
    HelpContext = 439001
  end
  inherited lblSkingroupMsg: TLabel
    Top = 567
    ExplicitTop = 567
  end
  object pnlFilters: TDNMPanel [5]
    Left = 8
    Top = 48
    Width = 933
    Height = 57
    HelpContext = 439026
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      933
      57)
    object Label1: TLabel
      Left = 24
      Top = 28
      Width = 14
      Height = 15
      HelpContext = 439027
      Caption = 'All'
      Transparent = True
    end
    object Label89: TLabel
      Left = 78
      Top = 9
      Width = 109
      Height = 17
      HelpContext = 439028
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Product Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblFirstCol: TLabel
      Left = 360
      Top = 9
      Width = 113
      Height = 17
      HelpContext = 439029
      Anchors = [akTop]
      AutoSize = False
      Caption = '1st Column'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblSecondCol: TLabel
      Left = 499
      Top = 9
      Width = 115
      Height = 17
      HelpContext = 439030
      Anchors = [akTop]
      AutoSize = False
      Caption = '2nd Column'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblThirdCol: TLabel
      Left = 637
      Top = 9
      Width = 111
      Height = 17
      HelpContext = 439031
      Anchors = [akTop]
      AutoSize = False
      Caption = '3rd Column'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label4: TLabel
      Left = 221
      Top = 10
      Width = 124
      Height = 17
      HelpContext = 439032
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Product Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label2: TLabel
      Left = 5
      Top = 0
      Width = 48
      Height = 16
      HelpContext = 439033
      Caption = 'Product'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object chkAll: TCheckBox
      Left = 8
      Top = 28
      Width = 14
      Height = 16
      HelpContext = 439034
      TabOrder = 0
      OnClick = chkAllClick
    end
    object cboFirstCol: TwwDBLookupCombo
      Left = 358
      Top = 25
      Width = 115
      Height = 22
      HelpContext = 439035
      Anchors = [akTop]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PartLevel1'#9'25'#9'PartLevel1'#9'F')
      LookupTable = qryFirstCol
      LookupField = 'PartLevel1'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = True
      OnBeforeDropDown = cboFirstColBeforeDropDown
      OnCloseUp = cboFirstColCloseUp
    end
    object cboSecondCol: TwwDBLookupCombo
      Left = 498
      Top = 25
      Width = 115
      Height = 22
      HelpContext = 439036
      Anchors = [akTop]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PartLevel2'#9'25'#9'PartLevel2'#9'F')
      LookupTable = qrySecondCol
      LookupField = 'PartLevel2'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = True
      OnBeforeDropDown = cboSecondColBeforeDropDown
      OnCloseUp = cboSecondColCloseUp
    end
    object cboThirdCol: TwwDBLookupCombo
      Left = 637
      Top = 25
      Width = 115
      Height = 22
      HelpContext = 439037
      Anchors = [akTop]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PartLevel3'#9'25'#9'PartLevel3'#9'F')
      LookupTable = qryThirdCol
      LookupField = 'PartLevel3'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = True
      OnBeforeDropDown = cboThirdColDropDown
      OnCloseUp = cboThirdColCloseUp
    end
    object cboPartName: TwwDBLookupCombo
      Left = 217
      Top = 25
      Width = 115
      Height = 23
      HelpContext = 439038
      Anchors = [akTop]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'40'#9'PARTNAME'#9#9)
      LookupTable = qryPartName
      LookupField = 'PartsID'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = True
      OnBeforeDropDown = cboPartNameBeforeDropDown
      OnCloseUp = cboPartNameCloseUp
    end
    object cboType: TwwDBLookupCombo
      Left = 77
      Top = 25
      Width = 115
      Height = 22
      HelpContext = 439039
      Anchors = [akTop]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'TypeDesc'#9'30'#9'TypeDesc'#9#9)
      LookupTable = qryProductTypeLookup
      LookupField = 'TypeCode'
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnBeforeDropDown = cboTypeDropDown
      OnCloseUp = cboTypeCloseUp
    end
    object btnCustomField: TDNMSpeedButton
      Left = 793
      Top = 22
      Width = 100
      Height = 27
      Caption = 'Custom Fields'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 6
      OnClick = btnCustomFieldClick
    end
  end
  object btnUpdate: TDNMSpeedButton [6]
    Left = 289
    Top = 533
    Width = 87
    Height = 27
    HelpContext = 439040
    Caption = '&Update'
    DisableTransparent = False
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 8
    OnClick = btnUpdateClick
  end
  object tbnClose: TDNMSpeedButton [7]
    Left = 570
    Top = 534
    Width = 87
    Height = 27
    HelpContext = 439041
    Caption = '&Close'
    DisableTransparent = False
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    Kind = bkAbort
    ModalResult = 3
    NumGlyphs = 2
    TabOrder = 9
    OnClick = tbnCloseClick
  end
  object pnlBatch: TDNMPanel [8]
    Left = 429
    Top = 428
    Width = 347
    Height = 99
    HelpContext = 439042
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 173
      Height = 97
      HelpContext = 439043
      Align = alLeft
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clWhite
      TabOrder = 0
      object Label9: TLabel
        Left = 25
        Top = 5
        Width = 85
        Height = 15
        HelpContext = 439044
        Caption = 'Batch Tracking'
        Transparent = True
      end
      object grpBatch: TRadioGroup
        Left = 6
        Top = 18
        Width = 162
        Height = 76
        HelpContext = 439045
        Color = clWhite
        Enabled = False
        Items.Strings = (
          'Off'
          'Automatic Allocation'
          'Manual Allocation')
        ParentColor = False
        TabOrder = 0
      end
      object chkBatch: TCheckBox
        Left = 7
        Top = 4
        Width = 15
        Height = 17
        HelpContext = 439046
        Caption = 'chkExtraSell'
        TabOrder = 1
        OnClick = chkBatchClick
      end
    end
    object Panel4: TPanel
      Left = 173
      Top = 1
      Width = 173
      Height = 97
      HelpContext = 439047
      Align = alRight
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clWhite
      TabOrder = 1
      object Label10: TLabel
        Left = 30
        Top = 5
        Width = 72
        Height = 15
        HelpContext = 439048
        Caption = 'Multiple Bins'
        Transparent = True
      end
      object grpBin: TRadioGroup
        Left = 7
        Top = 18
        Width = 162
        Height = 76
        HelpContext = 439049
        Color = clWhite
        Enabled = False
        Items.Strings = (
          'Off'
          'Automatic Allocation'
          'Manual Allocation')
        ParentColor = False
        TabOrder = 0
      end
      object chkBin: TCheckBox
        Left = 7
        Top = 4
        Width = 15
        Height = 17
        HelpContext = 439050
        Caption = 'chkExtraSell'
        TabOrder = 1
        OnClick = chkBinClick
      end
    end
  end
  object pnlPrice: TDNMPanel [9]
    Left = 8
    Top = 211
    Width = 505
    Height = 120
    HelpContext = 439051
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      505
      120)
    object Label3: TLabel
      Left = 24
      Top = 71
      Width = 88
      Height = 17
      HelpContext = 439052
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Customer Type'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label15: TLabel
      Left = 194
      Top = 71
      Width = 96
      Height = 17
      HelpContext = 439053
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Unit of Measure'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label16: TLabel
      Left = 144
      Top = 90
      Width = 14
      Height = 15
      HelpContext = 439054
      Caption = 'All'
      Enabled = False
      Transparent = True
    end
    object Label17: TLabel
      Left = 259
      Top = 95
      Width = 14
      Height = 15
      HelpContext = 439055
      Caption = 'All'
      Enabled = False
      Transparent = True
    end
    object Label21: TLabel
      Left = 332
      Top = 88
      Width = 27
      Height = 15
      HelpContext = 439056
      Caption = 'Main'
      Enabled = False
      Transparent = True
    end
    object pnlType: TPanel
      Left = 6
      Top = 5
      Width = 495
      Height = 61
      HelpContext = 439057
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clWhite
      TabOrder = 0
      object grpPrice: TRadioGroup
        Left = 8
        Top = 2
        Width = 483
        Height = 55
        HelpContext = 439058
        Caption = 'Price Type'
        Color = clWhite
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Line Prices'
          'Both'
          'Fixed Main / Extra Sell ')
        ParentColor = False
        TabOrder = 0
        OnClick = grpPriceClick
      end
    end
    object btnFixedPrice: TDNMSpeedButton
      Left = 379
      Top = 82
      Width = 81
      Height = 27
      HelpContext = 439059
      Caption = 'Fixed Prices'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 6
      OnClick = btnFixedPriceClick
    end
    object cboUOM: TwwDBLookupCombo
      Left = 195
      Top = 86
      Width = 102
      Height = 23
      HelpContext = 439060
      Anchors = [akTop]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupTable = qryUOM
      LookupField = 'UnitName'
      Style = csDropDownList
      DropDownWidth = 150
      Enabled = False
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboUOMCloseUp
      OnEnter = cboClientTypeEnter
    end
    object chkAllClientTypes: TCheckBox
      Left = 105
      Top = 90
      Width = 14
      Height = 16
      HelpContext = 439061
      Enabled = False
      TabOrder = 2
      OnClick = chkAllClientTypesClick
    end
    object chkAllUOM: TCheckBox
      Left = 315
      Top = 89
      Width = 14
      Height = 16
      HelpContext = 439062
      Enabled = False
      TabOrder = 5
      OnClick = chkAllUOMClick
    end
    object cboClientType2: TwwDBLookupCombo
      Left = 26
      Top = 86
      Width = 94
      Height = 23
      HelpContext = 439063
      Anchors = [akTop]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupTable = qryClientType
      LookupField = 'TypeName'
      DropDownWidth = 350
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboClientType2CloseUp
      OnEnter = cboClientTypeEnter
    end
    object chkMain: TCheckBox
      Left = 127
      Top = 90
      Width = 14
      Height = 16
      HelpContext = 439064
      Enabled = False
      TabOrder = 4
      OnClick = chkMainClick
    end
  end
  object pnlReOrderOptions: TDNMPanel [10]
    Left = 724
    Top = 181
    Width = 217
    Height = 93
    HelpContext = 439065
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object lblReOrderPoint: TLabel
      Left = 6
      Top = 27
      Width = 49
      Height = 30
      HelpContext = 439066
      Alignment = taCenter
      AutoSize = False
      Caption = 'ReOrder Point'
      Transparent = True
      WordWrap = True
    end
    object lblPreferredLevel: TLabel
      Left = 74
      Top = 27
      Width = 61
      Height = 29
      HelpContext = 439067
      Alignment = taCenter
      AutoSize = False
      Caption = 'Preferred Level'
      Transparent = True
      WordWrap = True
    end
    object lblReOrderAmount: TLabel
      Left = 153
      Top = 27
      Width = 56
      Height = 30
      HelpContext = 439068
      Alignment = taCenter
      AutoSize = False
      Caption = 'ReOrder Amount'
      Transparent = True
      WordWrap = True
    end
    object lblReOrder: TLabel
      Left = 24
      Top = 4
      Width = 134
      Height = 15
      HelpContext = 439069
      Caption = 'Update Re-order Points'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object edtReOrderPoints: TEdit
      Left = 6
      Top = 60
      Width = 48
      Height = 23
      HelpContext = 439070
      TabOrder = 0
      Text = '0'
      OnExit = IntegerEditExit
    end
    object edtPreferredLevel: TEdit
      Left = 81
      Top = 60
      Width = 48
      Height = 23
      HelpContext = 439071
      TabOrder = 1
      Text = '0'
      OnExit = IntegerEditExit
    end
    object edtReOrderAmount: TEdit
      Left = 157
      Top = 60
      Width = 48
      Height = 23
      HelpContext = 439072
      TabOrder = 2
      Text = '0'
      OnExit = IntegerEditExit
    end
  end
  object pnlCorrectExtraSell: TDNMPanel [11]
    Left = 519
    Top = 181
    Width = 200
    Height = 49
    HelpContext = 439073
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label13: TLabel
      Left = 6
      Top = 2
      Width = 164
      Height = 15
      HelpContext = 439074
      Caption = 'Auto Correct Extra Sell Price'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label14: TLabel
      Left = 26
      Top = 16
      Width = 135
      Height = 30
      HelpContext = 439075
      Caption = 'Correct Extra Sell Prices for products'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object chkCorrectExtra: TCheckBox
      Left = 6
      Top = 17
      Width = 17
      Height = 17
      HelpContext = 439076
      Caption = 'chkCorrectExtra'
      TabOrder = 0
    end
  end
  object pnlVariation: TDNMPanel [12]
    Left = 7
    Top = 429
    Width = 419
    Height = 99
    HelpContext = 439077
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object Label8: TLabel
      Left = 10
      Top = 2
      Width = 52
      Height = 15
      HelpContext = 439078
      Caption = 'Variation'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object pnlOptions: TPanel
      Left = 66
      Top = 24
      Width = 266
      Height = 70
      HelpContext = 439079
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clWhite
      TabOrder = 0
      object grpOption: TRadioGroup
        Left = 11
        Top = 5
        Width = 123
        Height = 57
        HelpContext = 439080
        Caption = 'Variation Option'
        Color = clWhite
        ItemIndex = 0
        Items.Strings = (
          'Increase By'
          'Decrease By')
        ParentColor = False
        TabOrder = 0
      end
      object grpType: TRadioGroup
        Left = 140
        Top = 5
        Width = 118
        Height = 57
        HelpContext = 439081
        Caption = 'Variation Type'
        Color = clWhite
        ItemIndex = 0
        Items.Strings = (
          'Percentage'
          'Dollars')
        ParentColor = False
        TabOrder = 1
      end
    end
    object edtAmount: TLabeledEdit
      Left = 338
      Top = 55
      Width = 62
      Height = 23
      HelpContext = 439082
      EditLabel.Width = 75
      EditLabel.Height = 15
      EditLabel.Caption = 'Variation (Ex)'
      EditLabel.Transparent = True
      EditLabel.Layout = tlCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '0.00'
    end
  end
  object pnlStatus: TDNMPanel [13]
    Left = 519
    Top = 277
    Width = 422
    Height = 54
    HelpContext = 439084
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    object Label18: TLabel
      Left = 6
      Top = 4
      Width = 209
      Height = 16
      HelpContext = 439085
      Caption = 'Deactivate Products not used after'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label19: TLabel
      Left = 280
      Top = 28
      Width = 69
      Height = 15
      HelpContext = 439086
      Caption = 'Make Active'
      Enabled = False
      Transparent = True
    end
    object Label20: TLabel
      Left = 160
      Top = 28
      Width = 78
      Height = 15
      HelpContext = 439087
      Caption = 'Make Inactive'
      Enabled = False
      Transparent = True
    end
    object dtFrom: TDateTimePicker
      Left = 7
      Top = 24
      Width = 97
      Height = 23
      HelpContext = 439088
      Date = 38457.000000000000000000
      Time = 38457.000000000000000000
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object chkActivate: TCheckBox
      Left = 264
      Top = 28
      Width = 14
      Height = 16
      HelpContext = 439089
      Enabled = False
      TabOrder = 1
      OnClick = chkActivateClick
    end
    object chkDeactivate: TCheckBox
      Left = 144
      Top = 28
      Width = 14
      Height = 16
      HelpContext = 439090
      Enabled = False
      TabOrder = 2
      OnClick = chkDeactivateClick
    end
  end
  object pnlClass: TDNMPanel [14]
    Left = 519
    Top = 231
    Width = 200
    Height = 43
    HelpContext = 439091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    object Label12: TLabel
      Left = 4
      Top = 1
      Width = 94
      Height = 15
      HelpContext = 439092
      Caption = 'Add products to '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object lblClass: TLabel
      Left = 99
      Top = 1
      Width = 33
      Height = 15
      HelpContext = 439093
      Caption = 'Class'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label22: TLabel
      Left = 177
      Top = 19
      Width = 14
      Height = 15
      HelpContext = 439094
      Caption = 'All'
      Transparent = True
    end
    object cboClass: TwwDBLookupCombo
      Left = 5
      Top = 15
      Width = 121
      Height = 23
      HelpContext = 439095
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'20'#9'Class Name'#9'F'#9)
      LookupTable = qryClass
      LookupField = 'ClassID'
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object chkAllClass: TCheckBox
      Left = 160
      Top = 18
      Width = 14
      Height = 17
      HelpContext = 439096
      TabOrder = 1
      OnClick = chkAllClassClick
    end
  end
  object pnlUnitOfMeasure: TDNMPanel [15]
    Left = 780
    Top = 333
    Width = 161
    Height = 193
    HelpContext = 439097
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    object Label23: TLabel
      Left = 6
      Top = 6
      Width = 89
      Height = 15
      HelpContext = 439098
      Caption = 'Unit of Measure'
      Transparent = True
    end
    object Label24: TLabel
      Left = 6
      Top = 100
      Width = 77
      Height = 15
      HelpContext = 439099
      Caption = 'Unit Multiplier'
      Transparent = True
    end
    object Label25: TLabel
      Left = 27
      Top = 149
      Width = 74
      Height = 15
      HelpContext = 439100
      Caption = 'Sales default'
      Transparent = True
    end
    object Label26: TLabel
      Left = 27
      Top = 169
      Width = 59
      Height = 15
      HelpContext = 439101
      Caption = 'PO default'
      Transparent = True
    end
    object Label27: TLabel
      Left = 56
      Top = 119
      Width = 11
      Height = 15
      HelpContext = 439102
      Caption = 'of'
      Transparent = True
    end
    object Label28: TLabel
      Left = 6
      Top = 54
      Width = 65
      Height = 15
      HelpContext = 439103
      Caption = 'Description'
      Transparent = True
    end
    object edMultiplier: TDBEdit
      Left = 6
      Top = 115
      Width = 42
      Height = 23
      HelpContext = 439104
      DataField = 'Multiplier'
      DataSource = DSUOM2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object chkSalesDefault: TwwCheckBox
      Left = 6
      Top = 148
      Width = 16
      Height = 17
      HelpContext = 439105
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
      Caption = 'chkSalesDefault'
      DataField = 'SalesDefault'
      DataSource = DSUOM2
      TabOrder = 1
    end
    object chkPurchDefault: TwwCheckBox
      Left = 6
      Top = 169
      Width = 14
      Height = 14
      HelpContext = 439106
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
      Caption = 'chkPurchDefault'
      DataField = 'PurchasesDefault'
      DataSource = DSUOM2
      TabOrder = 2
    end
    object cboUnitOfMeasure: TwwDBLookupCombo
      Left = 70
      Top = 115
      Width = 86
      Height = 23
      HelpContext = 439107
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'UnitName'#9'15'#9'Unit Name'#9'F')
      DataField = 'BaseUnitName'
      LookupTable = qrycboUnitOfMeasure
      LookupField = 'UnitName'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object edtDesc: TDBEdit
      Left = 6
      Top = 69
      Width = 147
      Height = 23
      HelpContext = 439108
      DataField = 'UnitDescription'
      DataSource = DSUOM2
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object edtUnit: TwwDBLookupCombo
      Left = 6
      Top = 22
      Width = 146
      Height = 23
      HelpContext = 439109
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupTable = qryUOM2
      LookupField = 'UnitName'
      ParentFont = False
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnBeforeDropDown = edtUnitBeforeDropDown
    end
  end
  object pnlTitle: TDNMPanel [16]
    Left = 356
    Top = 4
    Width = 238
    Height = 40
    HelpContext = 439116
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 36
      HelpContext = 439117
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
        Width = 234
        Height = 36
        HelpContext = 439118
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = ' Data Update'
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
  object DNMPanel2: TDNMPanel [17]
    Left = 519
    Top = 107
    Width = 422
    Height = 72
    HelpContext = 439018
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    object Bevel2: TBevel
      Left = 9
      Top = 5
      Width = 416
      Height = 62
      HelpContext = 439019
    end
    object lblInProgress: TLabel
      Left = 16
      Top = 6
      Width = 398
      Height = 22
      HelpContext = 439020
      Alignment = taCenter
      AutoSize = False
      Caption = 'In Progress .... Please Wait'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object lblRecCount: TLabel
      Left = 16
      Top = 50
      Width = 398
      Height = 15
      HelpContext = 439021
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblRecCount'
      Transparent = True
      Visible = False
    end
    object ProgressBar: TProgressBar
      Left = 17
      Top = 30
      Width = 400
      Height = 19
      HelpContext = 439022
      Smooth = True
      Step = 1
      TabOrder = 0
    end
  end
  object pnlCustFilters: TDNMPanel [18]
    Left = 7
    Top = 333
    Width = 767
    Height = 93
    HelpContext = 439003
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    DesignSize = (
      767
      93)
    object Bevel6: TBevel
      Left = 451
      Top = 0
      Width = 317
      Height = 94
      HelpContext = 439004
      Shape = bsFrame
    end
    object Label5: TLabel
      Left = 6
      Top = 4
      Width = 62
      Height = 16
      HelpContext = 439005
      AutoSize = False
      Caption = 'Customer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 29
      Top = 33
      Width = 14
      Height = 15
      HelpContext = 439006
      Caption = 'All'
      Transparent = True
    end
    object Label7: TLabel
      Left = 99
      Top = 32
      Width = 111
      Height = 17
      HelpContext = 439007
      AutoSize = False
      Caption = 'Customer Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label11: TLabel
      Left = 462
      Top = 12
      Width = 241
      Height = 15
      HelpContext = 439008
      Caption = 'Add this Customer Type to Extra Sell Price '
      Transparent = True
      WordWrap = True
    end
    object Label29: TLabel
      Left = 554
      Top = 40
      Width = 96
      Height = 17
      HelpContext = 439053
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = 'Unit of Measure'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object chkAllCust: TCheckBox
      Left = 9
      Top = 32
      Width = 14
      Height = 16
      HelpContext = 439009
      TabOrder = 0
      OnClick = chkAllCustClick
    end
    object cboClientType: TwwDBLookupCombo
      Left = 99
      Top = 53
      Width = 132
      Height = 23
      HelpContext = 439010
      Anchors = [akTop]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'TypeName'#9'15'#9'TypeName'#9'F'
        'TypeDescription'#9'25'#9'TypeDescription'#9'F')
      LookupTable = qryClientType
      LookupField = 'ClientTypeID'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnEnter = cboClientTypeEnter
    end
    object chkExtraSell: TCheckBox
      Left = 723
      Top = 13
      Width = 15
      Height = 17
      HelpContext = 439011
      Caption = 'chkExtraSell'
      TabOrder = 2
      OnClick = chkExtraSellClick
    end
    object edtDisc1: TLabeledEdit
      Left = 460
      Top = 55
      Width = 46
      Height = 23
      HelpContext = 439012
      EditLabel.Width = 44
      EditLabel.Height = 15
      EditLabel.BiDiMode = bdLeftToRight
      EditLabel.Caption = '%Disc 1'
      EditLabel.ParentBiDiMode = False
      EditLabel.Transparent = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '  0.0'
    end
    object edtDisc2: TLabeledEdit
      Left = 654
      Top = 55
      Width = 46
      Height = 23
      HelpContext = 439014
      EditLabel.Width = 44
      EditLabel.Height = 15
      EditLabel.BiDiMode = bdLeftToRight
      EditLabel.Caption = '%Disc 2'
      EditLabel.ParentBiDiMode = False
      EditLabel.Transparent = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '  0.0'
      Visible = False
    end
    object edtDisc3: TLabeledEdit
      Left = 705
      Top = 55
      Width = 46
      Height = 23
      HelpContext = 439015
      EditLabel.Width = 44
      EditLabel.Height = 15
      EditLabel.BiDiMode = bdLeftToRight
      EditLabel.Caption = '%Disc 3'
      EditLabel.ParentBiDiMode = False
      EditLabel.Transparent = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = '  0.0'
      Visible = False
    end
    object Panel1: TPanel
      Left = 251
      Top = 4
      Width = 195
      Height = 83
      HelpContext = 439016
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clWhite
      TabOrder = 6
      object grpSpecial: TRadioGroup
        Left = 6
        Top = 3
        Width = 180
        Height = 76
        HelpContext = 439017
        Caption = 'Special Prices'
        ItemIndex = 1
        Items.Strings = (
          'Include Special Prices'
          'Exclude Special Prices')
        TabOrder = 0
      end
    end
    object cboUOMExtraSell: TwwDBLookupCombo
      Left = 555
      Top = 55
      Width = 102
      Height = 23
      HelpContext = 439060
      Anchors = [akTop]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'UnitName'#9'15'#9'UnitName'#9'F')
      LookupTable = QryUOMExtraSellPrice
      LookupField = 'UnitName'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 7
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  object pnlSelection: TDNMPanel [19]
    Left = 8
    Top = 107
    Width = 505
    Height = 102
    HelpContext = 439023
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Panel3: TDNMPanel
      Left = 6
      Top = 4
      Width = 496
      Height = 93
      HelpContext = 439024
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Transparent = False
      object grpSelection: TRadioGroup
        Left = 5
        Top = 2
        Width = 484
        Height = 86
        HelpContext = 439025
        Caption = 'Selection'
        Color = clWhite
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Product Prices'
          'Correct Extra Sell Prices'
          'Add to Store'
          'Customer Prices'
          'Batch && Multi Bin'
          'Adjust Class Variance'
          'Deactivate Products'
          'Update Re-order Points'
          'Unit of Measure')
        ParentColor = False
        TabOrder = 0
        OnClick = grpSelectionClick
      end
    end
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003400340010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryPartName: TERPQuery
    SQL.Strings = (
      'SELECT '
      'PARTNAME AS PARTNAME, '
      'PartsID AS PartsID'
      'FROM tblparts'
      'WHERE Active = '#39'T'#39
      'ORDER BY PARTNAME')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 512
    Top = 35
  end
  object qryParts: TERPQuery
    SQL.Strings = (
      'SELECT'
      
        'IF(INSTR(IF(INSTR(PRODUCTGROUP,"^")<>0, SUBSTRING_INDEX(PRODUCTG' +
        'ROUP,"^",2),""),"^")<>0, SUBSTRING_INDEX(PRODUCTGROUP,"^",-1),Sp' +
        'ace(10))  AS '#39'Col3'#39','
      
        'IF(INSTR(PRODUCTGROUP,"^")<>0, SUBSTRING_INDEX(SUBSTRING_INDEX(P' +
        'RODUCTGROUP,"^",2),"^",-1),Space(10)) AS '#39'Col2'#39','
      'SUBSTRING_INDEX(PRODUCTGROUP,"^",1) AS '#39'Col1'#39','
      'PARTSID AS PARTSID,'
      'PARTNAME AS PARTNAME,'
      'PRODUCTGROUP AS PRODUCTGROUP,'
      'PARTTYPE AS PARTTYPE,'
      'BuyQTY1 AS BuyQTY1,'
      'BuyQTY2 AS BuyQTY2,'
      'BuyQTY3 AS BuyQTY3,'
      'COST1 AS COST1,'
      'COST2 AS COST2,'
      'COST3 AS COST3,'
      'SellQTY1 AS SellQTY1,'
      'SellQTY2 AS SellQTY2,'
      'SellQTY3 AS SellQTY3,'
      'PRICE1 AS PRICE1,'
      'PRICE2 AS PRICE2,'
      'PRICE3 AS PRICE3,'
      'PRICEINC1,'
      'PRICEINC2,'
      'PRICEINC3,'
      'TAXCODE,'
      'WHOLESALEPRICE AS WHOLESALEPRICE,'
      'Active AS Active,'
      'AvgCost AS AvgCost,'
      'Batch AS Batch,'
      'MultipleBins AS MultipleBins,'
      'EditedFlag AS EditedFlag,'
      'DateUpdated AS DateUpdated,'
      'autobatch, '
      'autobin,'
      'CUSTFLD1,'
      'CUSTFLD2,'
      'CUSTFLD3,'
      'CUSTFLD4,'
      'CUSTFLD5,'
      'CUSTFLD6,'
      'CUSTFLD7,'
      'CUSTFLD8,'
      'CUSTFLD9,'
      'CUSTFLD10,'
      'CUSTFLD11,'
      'CUSTFLD12,'
      'CUSTFLD13,'
      'CUSTFLD14,'
      'CUSTFLD15,'
      'CUSTDATE1,'
      'CUSTDATE2,'
      'CUSTDATE3 '
      'FROM tblparts'
      'WHERE Active = '#39'T'#39)
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 544
    Top = 11
  end
  object qryFirstCol: TERPQuery
    SQL.Strings = (
      'SELECT'
      'SUBSTRING_INDEX(PRODUCTGROUP,"^",1) AS PartLevel1'
      'FROM tblparts'
      'WHERE char_length(SUBSTRING_INDEX(PRODUCTGROUP,"^",1))<>0'
      'Group by PartLevel1'
      'Order by PartLevel1')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 576
    Top = 11
  end
  object qryProductTypeLookup: TERPQuery
    SQL.Strings = (
      'SELECT TypeCode, TypeDesc'
      'FROM tblparttypes'
      'order by TypeDesc')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 272
    Top = 8
  end
  object qrySecondCol: TERPQuery
    SQL.Strings = (
      'SELECT'
      
        'IF(INSTR(PRODUCTGROUP,"^")<>0, SUBSTRING_INDEX(SUBSTRING_INDEX(P' +
        'RODUCTGROUP,"^",2),"^",-1),'#39#39') AS PartLevel2'
      'FROM tblparts'
      
        'WHERE char_length(IF(INSTR(PRODUCTGROUP,"^")<>0, SUBSTRING_INDEX' +
        '(SUBSTRING_INDEX(PRODUCTGROUP,"^",2),"^",-1),'#39#39'))<>0'
      'Group by PartLevel2'
      'Order by PartLevel2;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 608
    Top = 10
  end
  object qryThirdCol: TERPQuery
    SQL.Strings = (
      'SELECT'
      
        'IF(INSTR(IF(INSTR(PRODUCTGROUP,"^")<>0, SUBSTRING_INDEX(PRODUCTG' +
        'ROUP,"^",2),""),"^")<>0, SUBSTRING_INDEX(PRODUCTGROUP,"^",-1),'#39#39 +
        ') AS PartLevel3'
      'FROM tblparts'
      'WHERE'
      
        'char_length(IF(INSTR(IF(INSTR(PRODUCTGROUP,"^")<>0, SUBSTRING_IN' +
        'DEX(PRODUCTGROUP,"^",2),""),"^")<>0, SUBSTRING_INDEX(PRODUCTGROU' +
        'P,"^",-1),'#39#39'))<> 0'
      'Group by PartLevel3'
      'Order by PartLevel3;'
      '')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 640
    Top = 11
  end
  object qryClass: TERPQuery
    SQL.Strings = (
      'SELECT ClassID, ClassName FROM tblClass'
      'WHERE Active='#39'T'#39';')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 672
    Top = 12
  end
  object qryClientType: TERPQuery
    SQL.Strings = (
      'SELECT '
      'ClientTypeID, TypeName, TypeDescription'
      'FROM tblclienttype'
      'WHERE Active='#39'T'#39
      'Order by TypeName;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 166
    Top = 2
    object qryClientTypeClientTypeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientTypeID'
      Origin = 'tblclienttype.ClientTypeID'
    end
    object qryClientTypeTypeName: TWideStringField
      FieldName = 'TypeName'
      Origin = 'tblclienttype.TypeName'
      Size = 50
    end
    object qryClientTypeTypeDescription: TWideStringField
      FieldName = 'TypeDescription'
      Origin = 'tblclienttype.TypeDescription'
      Size = 255
    end
  end
  object tblCustomerLines: TERPQuery
    SQL.Strings = (
      'Select * From tblCustomerLines')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 205
    Top = 10
  end
  object qryExtraSell: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblextrapricesell;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 704
    Top = 13
  end
  object qrySpecPrices: TERPQuery
    SQL.Strings = (
      'SELECT'
      'if((LOCATE('#39'^'#39',PRODUCTGROUP,InStr(PRODUCTGROUP,'#39'^'#39')+1)) >0,'
      'MID(PRODUCTGROUP,LOCATE('#39'^'#39',PRODUCTGROUP,'
      'InStr(PRODUCTGROUP,'#39'^'#39')+1)+1,char_length(PRODUCTGROUP)-'
      
        'LOCATE('#39'^'#39',PRODUCTGROUP,InStr(PRODUCTGROUP,'#39'^'#39')+1)),  Null)  AS ' +
        #39'Col3'#39' ,'
      'MID(PRODUCTGROUP, InStr(PRODUCTGROUP,'#39'^'#39')+1 ,'
      'If(LOCATE('#39'^'#39',PRODUCTGROUP,'
      'InStr(PRODUCTGROUP,'#39'^'#39')+1) - InStr(PRODUCTGROUP,'#39'^'#39') >0,'
      'LOCATE('#39'^'#39',PRODUCTGROUP,'
      'InStr(PRODUCTGROUP,'#39'^'#39')+1)-1 - InStr(PRODUCTGROUP,'#39'^'#39'),'
      'IF(InStr(PRODUCTGROUP,'#39'^'#39')<>0,'
      
        'char_length(PRODUCTGROUP) - InStr(PRODUCTGROUP,'#39'^'#39'),0))) AS '#39'Col' +
        '2'#39' ,'
      'If(InStr(PRODUCTGROUP,'#39'^'#39') -1 >0,'
      'Left(PRODUCTGROUP,InStr(PRODUCTGROUP,'#39'^'#39')-1),'
      'PRODUCTGROUP) AS '#39'Col1'#39' ,'
      'PARTSID,PARTTYPE, tblparts.Active, AvgCost, COST1,'
      'tblcustomerlines.OrigPrice, tblcustomerlines.LinePrice,'
      'tblclients.ClientTypeID, tblcustomerlines.CustomerLinesID'
      'FROM tblcustomerlines INNER JOIN tblparts'
      'ON tblcustomerlines.ProductID = tblparts.PartsID'
      'LEFT JOIN tblclients'
      'ON tblclients.ClientID = tblcustomerlines.CustomerID'
      'WHERE tblparts.Active = '#39'T'#39';')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 132
    Top = 2
  end
  object qryUOM: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'UnitID, UnitName,BaseUnitName,UnitDescription,Multiplier,PartID,'
      'SalesDefault,PurchasesDefault,BaseUnitID,Active'
      'FROM tblunitsofmeasure'
      'ORDER BY UnitName;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 238
    Top = 10
    object qryUOMUnitID: TIntegerField
      FieldName = 'UnitID'
    end
    object qryUOMUnitName: TWideStringField
      FieldName = 'UnitName'
      Size = 15
    end
    object qryUOMMultiplier: TFloatField
      FieldName = 'Multiplier'
    end
    object qryUOMPartID: TIntegerField
      FieldName = 'PartID'
    end
    object qryUOMSalesDefault: TWideStringField
      FieldName = 'SalesDefault'
      FixedChar = True
      Size = 1
    end
    object qryUOMPurchasesDefault: TWideStringField
      FieldName = 'PurchasesDefault'
      FixedChar = True
      Size = 1
    end
    object qryUOMUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
    end
    object qryUOMBaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
    end
    object qryUOMBaseUnitID: TIntegerField
      FieldName = 'BaseUnitID'
    end
    object qryUOMActive: TWideStringField
      FieldName = 'Active'
    end
  end
  object tmrESValidate: TTimer
    Interval = 200
    OnTimer = tmrESValidateTimer
    Left = 304
    Top = 8
  end
  object DSUOM: TDataSource
    DataSet = qryUOM
    Left = 236
    Top = 45
  end
  object qrycboUnitOfMeasure: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT  U.UnitID as UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 AND Multiplier ' +
        ' = 1'
      'Group By U.UnitName Desc'
      'Order By U.UnitName')
    Left = 902
    Top = 446
    object qrycboUnitOfMeasureUnitName: TWideStringField
      DisplayLabel = 'Unit Name'
      DisplayWidth = 15
      FieldName = 'UnitName'
      Size = 15
    end
    object qrycboUnitOfMeasureUnitID: TAutoIncField
      FieldName = 'UnitID'
      ReadOnly = True
      Visible = False
    end
    object qrycboUnitOfMeasureUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Visible = False
      Size = 35
    end
  end
  object qryUOM2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblunitsofmeasure GROUP BY UnitName')
    Left = 899
    Top = 348
  end
  object DSUOM2: TDataSource
    DataSet = qryUOM2
    Left = 156
    Top = 43
  end
  object QryUOMExtraSellPrice: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'UnitID, UnitName,BaseUnitName,UnitDescription,Multiplier,PartID,'
      'SalesDefault,PurchasesDefault,BaseUnitID,Active'
      'FROM tblunitsofmeasure'
      'ORDER BY UnitName;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 670
    Top = 354
    object StringField1: TWideStringField
      DisplayWidth = 15
      FieldName = 'UnitName'
      Size = 15
    end
    object IntegerField1: TIntegerField
      FieldName = 'UnitID'
      Visible = False
    end
    object FloatField1: TFloatField
      FieldName = 'Multiplier'
      Visible = False
    end
    object IntegerField2: TIntegerField
      FieldName = 'PartID'
      Visible = False
    end
    object StringField2: TWideStringField
      FieldName = 'SalesDefault'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object StringField3: TWideStringField
      FieldName = 'PurchasesDefault'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object StringField4: TWideStringField
      FieldName = 'UnitDescription'
      Visible = False
    end
    object StringField5: TWideStringField
      FieldName = 'BaseUnitName'
      Visible = False
    end
    object IntegerField3: TIntegerField
      FieldName = 'BaseUnitID'
      Visible = False
    end
    object StringField6: TWideStringField
      FieldName = 'Active'
      Visible = False
    end
  end
  object qryProductAllocation: TERPQuery
    SQL.Strings = (
      'SELECT'
      
        'IF(INSTR(IF(INSTR(PRODUCTGROUP,"^")<>0, SUBSTRING_INDEX(PRODUCTG' +
        'ROUP,"^",2),""),"^")<>0, SUBSTRING_INDEX(PRODUCTGROUP,"^",-1),Sp' +
        'ace(10))  AS '#39'Col3'#39','
      
        'IF(INSTR(PRODUCTGROUP,"^")<>0, SUBSTRING_INDEX(SUBSTRING_INDEX(P' +
        'RODUCTGROUP,"^",2),"^",-1),Space(10)) AS '#39'Col2'#39','
      'SUBSTRING_INDEX(PRODUCTGROUP,"^",1) AS '#39'Col1'#39','
      'PARTSID AS PARTSID,'
      'PARTNAME AS PARTNAME,'
      'PRODUCTGROUP AS PRODUCTGROUP,'
      'PARTTYPE AS PARTTYPE,'
      'BuyQTY1 AS BuyQTY1,'
      'BuyQTY2 AS BuyQTY2,'
      'BuyQTY3 AS BuyQTY3,'
      'COST1 AS COST1,'
      'COST2 AS COST2,'
      'COST3 AS COST3,'
      'SellQTY1 AS SellQTY1,'
      'SellQTY2 AS SellQTY2,'
      'SellQTY3 AS SellQTY3,'
      'PRICE1 AS PRICE1,'
      'PRICE2 AS PRICE2,'
      'PRICE3 AS PRICE3,'
      'PRICEINC1,'
      'PRICEINC2,'
      'PRICEINC3,'
      'TAXCODE,'
      'WHOLESALEPRICE AS WHOLESALEPRICE,'
      'Active AS Active,'
      'AvgCost AS AvgCost,'
      'Batch AS Batch,'
      'MultipleBins AS MultipleBins,'
      'EditedFlag AS EditedFlag,'
      'DateUpdated AS DateUpdated,'
      'autobatch, '
      'autobin,'
      'CUSTFLD1,'
      'CUSTFLD2,'
      'CUSTFLD3,'
      'CUSTFLD4,'
      'CUSTFLD5,'
      'CUSTFLD6,'
      'CUSTFLD7,'
      'CUSTFLD8,'
      'CUSTFLD9,'
      'CUSTFLD10,'
      'CUSTFLD11,'
      'CUSTFLD12,'
      'CUSTFLD13,'
      'CUSTFLD14,'
      'CUSTFLD15,'
      'CUSTDATE1,'
      'CUSTDATE2,'
      'CUSTDATE3 '
      'FROM tblparts'
      'WHERE Active = '#39'T'#39)
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 736
    Top = 11
  end
end
