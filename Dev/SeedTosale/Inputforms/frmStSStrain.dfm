inherited fmStSStrain: TfmStSStrain
  Left = 244
  Top = 147
  Caption = 'Seed To Sale - Strain'
  ClientHeight = 479
  ClientWidth = 816
  ExplicitLeft = 244
  ExplicitTop = 147
  ExplicitWidth = 832
  ExplicitHeight = 518
  DesignSize = (
    816
    479)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 429
    Width = 816
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 101
    Top = 10
    ExplicitLeft = 49
    ExplicitTop = 10
  end
  inherited imgGridWatermark: TImage
    Left = 305
    Top = 10
    ExplicitLeft = 305
    ExplicitTop = 10
  end
  inherited shapehintextra1: TShape
    Left = 215
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 816
    Height = 59
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      816
      59)
    object pnlTitle: TDNMPanel
      Left = 260
      Top = 10
      Width = 297
      Height = 39
      HelpContext = 372080
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 295
        Height = 37
        HelpContext = 372081
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
          Width = 295
          Height = 37
          HelpContext = 254008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Seed To Sale - Strain'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 234
          ExplicitHeight = 32
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 429
    Width = 816
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = True
    DesignSize = (
      816
      50)
    object cmdClose: TDNMSpeedButton
      Left = 210
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 251008
      Anchors = []
      Caption = '&Save'
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 513
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 251005
      Anchors = []
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 361
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 358022
      Anchors = []
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = cmdNewClick
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 59
    Width = 816
    Height = 370
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitTop = 55
    DesignSize = (
      816
      370)
    object Shape3: TShape
      Left = 149
      Top = 261
      Width = 474
      Height = 84
      Brush.Style = bsClear
      Pen.Color = clGray
    end
    object Shape4: TShape
      Left = 504
      Top = 84
      Width = 295
      Height = 172
      Brush.Style = bsClear
      Pen.Color = clGray
    end
    object Shape1: TShape
      Left = 149
      Top = 84
      Width = 337
      Height = 84
      Brush.Style = bsClear
      Pen.Color = clGray
    end
    object lblProductPrintName: TLabel
      Left = 50
      Top = 11
      Width = 70
      Height = 15
      HelpContext = 314766
      Alignment = taRightJustify
      Anchors = [akTop]
      Caption = 'Strain Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      ExplicitLeft = 58
    end
    object Label1: TLabel
      Left = 73
      Top = 109
      Width = 55
      Height = 15
      HelpContext = 314095
      Alignment = taRightJustify
      Caption = 'Tested By'
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
      Left = 160
      Top = 136
      Width = 62
      Height = 15
      HelpContext = 314095
      Alignment = taRightJustify
      Caption = 'Third Party'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 84
      Top = 226
      Width = 44
      Height = 15
      HelpContext = 314095
      Alignment = taRightJustify
      Caption = 'Content'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Shape2: TShape
      Left = 149
      Top = 172
      Width = 177
      Height = 84
      Brush.Style = bsClear
      Pen.Color = clGray
    end
    object Label4: TLabel
      Left = 199
      Top = 188
      Width = 23
      Height = 15
      HelpContext = 314095
      Alignment = taRightJustify
      Caption = 'THC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 198
      Top = 225
      Width = 24
      Height = 15
      HelpContext = 314095
      Alignment = taRightJustify
      Caption = 'CBD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 188
      Top = 276
      Width = 34
      Height = 15
      HelpContext = 314095
      Alignment = taRightJustify
      Caption = 'Indica'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 187
      Top = 314
      Width = 35
      Height = 15
      HelpContext = 314095
      Alignment = taRightJustify
      Caption = 'Savita'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblTimerMsg: TLabel
      Left = 1
      Top = 353
      Width = 814
      Height = 16
      Cursor = crHandPoint
      Align = alBottom
      Alignment = taCenter
      Caption = 'TimerMsg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      GlowSize = 2
      ParentFont = False
      Layout = tlCenter
      Visible = False
      WordWrap = True
      ExplicitWidth = 62
    end
    object Label6: TLabel
      Left = 519
      Top = 100
      Width = 55
      Height = 15
      HelpContext = 314095
      Caption = 'Immature'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 519
      Top = 141
      Width = 59
      Height = 15
      HelpContext = 314095
      Caption = 'Vegetative'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label11: TLabel
      Left = 519
      Top = 182
      Width = 55
      Height = 15
      HelpContext = 314095
      Caption = 'Flowering'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label12: TLabel
      Left = 515
      Top = 62
      Width = 89
      Height = 15
      HelpContext = 314095
      Alignment = taRightJustify
      Caption = 'Strain Products'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 519
      Top = 224
      Width = 44
      Height = 15
      HelpContext = 314095
      Caption = 'Harvest'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object chkTested: TwwCheckBox
      Left = 73
      Top = 61
      Width = 87
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Tested ?'
      DataField = 'Tested'
      DataSource = dsStS_Strain
      TabOrder = 1
    end
    object chkTestedInHouse: TwwCheckBox
      Left = 172
      Top = 99
      Width = 88
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'In-House'
      DataField = 'TestedInHouse'
      DataSource = dsStS_Strain
      TabOrder = 2
      OnEnter = chkTestedInHouseEnter
    end
    object cboTestedBy: TwwDBLookupCombo
      Left = 245
      Top = 132
      Width = 231
      Height = 23
      HelpContext = 314099
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'30'#9'Supplier'#9'T')
      DataField = 'TestedBy'
      DataSource = dsStS_Strain
      LookupTable = cboClientLookup
      LookupField = 'Company'
      Options = [loSearchOnBackspace]
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboTestedByCloseUp
      OnEnter = cboTestedByEnter
    end
    object edtTHC_Content: TwwDBSpinEdit
      Left = 245
      Top = 184
      Width = 57
      Height = 23
      Increment = 1.000000000000000000
      MaxValue = 100.000000000000000000
      DataField = 'THC_Content'
      DataSource = dsStS_Strain
      TabOrder = 10
      UnboundDataType = wwDefault
    end
    object edtCBD_Content: TwwDBSpinEdit
      Left = 245
      Top = 221
      Width = 57
      Height = 23
      Increment = 1.000000000000000000
      MaxValue = 100.000000000000000000
      DataField = 'CBD_Content'
      DataSource = dsStS_Strain
      TabOrder = 11
      UnboundDataType = wwDefault
    end
    object edtIndica: TwwDBSpinEdit
      Left = 245
      Top = 272
      Width = 57
      Height = 23
      Increment = 1.000000000000000000
      MaxValue = 100.000000000000000000
      DataField = 'Indica'
      DataSource = dsStS_Strain
      TabOrder = 12
      UnboundDataType = wwDefault
    end
    object edtsativa: TwwDBSpinEdit
      Left = 245
      Top = 310
      Width = 57
      Height = 23
      Increment = 1.000000000000000000
      MaxValue = 100.000000000000000000
      DataField = 'Sativa'
      DataSource = dsStS_Strain
      TabOrder = 14
      UnboundDataType = wwDefault
    end
    object prgIndica: TAdvProgress
      Left = 308
      Top = 272
      Width = 299
      Height = 23
      Enabled = False
      BarColor = clHighlight
      TabOrder = 13
      BkColor = clWindow
      Version = '1.2.0.0'
    end
    object prgSativa: TAdvProgress
      Left = 308
      Top = 310
      Width = 299
      Height = 23
      Enabled = False
      BarColor = clHighlight
      TabOrder = 15
      BkColor = clWindow
      Version = '1.2.0.0'
    end
    object edtImmatureProduct: TEdit
      Left = 584
      Top = 96
      Width = 177
      Height = 23
      HelpContext = 254358
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object edtStrainName: TwwDBEdit
      Left = 149
      Top = 7
      Width = 337
      Height = 23
      DataField = 'StrainName'
      DataSource = dsStS_Strain
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtVegetativeProduct: TEdit
      Left = 584
      Top = 141
      Width = 177
      Height = 23
      HelpContext = 254358
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
    end
    object edtFloweringProduct: TEdit
      Left = 584
      Top = 182
      Width = 177
      Height = 23
      HelpContext = 254358
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
    object btnImmatureProduct: TDNMSpeedButton
      Left = 767
      Top = 96
      Width = 28
      Height = 23
      HelpContext = 443009
      Anchors = [akBottom]
      Caption = ' .  .  .'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btnImmatureProductClick
    end
    object btnVegetativeProduct: TDNMSpeedButton
      Left = 767
      Top = 141
      Width = 28
      Height = 23
      HelpContext = 443009
      Anchors = [akBottom]
      Caption = ' .  .  .'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = btnVegetativeProductClick
    end
    object btnFloweringProduct: TDNMSpeedButton
      Left = 767
      Top = 182
      Width = 28
      Height = 23
      HelpContext = 443009
      Anchors = [akBottom]
      Caption = ' .  .  .'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      AutoDisableParentOnclick = True
      OnClick = btnFloweringProductClick
    end
    object btnInitDefaults: TDNMSpeedButton
      Left = 646
      Top = 58
      Width = 153
      Height = 23
      Caption = 'Intialise with Defaults'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'Tahoma'
      HotTrackFont.Style = []
      TabOrder = 16
      AutoDisableParentOnclick = True
      OnClick = btnInitDefaultsClick
    end
    object edtHarvestProduct: TEdit
      Left = 584
      Top = 220
      Width = 177
      Height = 23
      HelpContext = 254358
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 17
    end
    object btnHarvestProduct: TDNMSpeedButton
      Left = 767
      Top = 220
      Width = 28
      Height = 23
      HelpContext = 443009
      Anchors = [akBottom]
      Caption = ' .  .  .'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      AutoDisableParentOnclick = True
      OnClick = btnHarvestProductClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 60
    Top = 5
  end
  inherited tmrdelay: TTimer
    Left = 96
    Top = 5
  end
  inherited popSpelling: TPopupMenu
    Left = 462
    Top = 5
  end
  inherited tmrdelayMsg: TTimer
    Left = 22
    Top = 5
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 499
    Top = 5
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 684
    Top = 5
  end
  inherited MyConnection: TERPConnection
    Database = 'sts_test'
    Server = 'localhost'
    Left = 174
    Top = 5
  end
  inherited DataState: TDataState
    Left = 573
    Top = 5
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 721
    Top = 5
  end
  inherited imgsort: TImageList
    Left = 610
    Top = 5
    Bitmap = {
      494C010102009400600110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryCustomField: TERPQuery
    Left = 252
    Top = 5
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 759
    Top = 5
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 536
    Top = 5
  end
  inherited qryMemTrans: TERPQuery
    Left = 214
    Top = 5
  end
  inherited tmrOnshow: TTimer
    Left = 133
    Top = 5
  end
  object Actionlist: TActionList
    Left = 647
    Top = 5
  end
  object dsStS_Strain: TDataSource
    DataSet = QryStS_Strain
    Left = 320
    Top = 37
  end
  object QryStS_Strain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblStSStrains')
    AfterOpen = QryStS_StrainAfterOpen
    Left = 320
    Top = 5
    object QryStS_StrainID: TIntegerField
      FieldName = 'ID'
    end
    object QryStS_StrainGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object QryStS_StrainStrainName: TWideStringField
      FieldName = 'StrainName'
      Size = 255
    end
    object QryStS_StrainTested: TWideStringField
      FieldName = 'Tested'
      FixedChar = True
      Size = 1
    end
    object QryStS_StrainTestedInHouse: TWideStringField
      FieldName = 'TestedInHouse'
      FixedChar = True
      Size = 1
    end
    object QryStS_StrainTestedByID: TIntegerField
      FieldName = 'TestedByID'
    end
    object QryStS_StrainTestedBy: TWideStringField
      FieldName = 'TestedBy'
      Size = 255
    end
    object QryStS_StrainTHC_Content: TFloatField
      FieldName = 'THC_Content'
    end
    object QryStS_StrainCBD_Content: TFloatField
      FieldName = 'CBD_Content'
    end
    object QryStS_StrainIndica: TFloatField
      FieldName = 'Indica'
    end
    object QryStS_StrainSativa: TFloatField
      FieldName = 'Sativa'
    end
    object QryStS_StrainImmatureProductID: TIntegerField
      FieldName = 'ImmatureProductID'
    end
    object QryStS_StrainVegetativeProductId: TIntegerField
      FieldName = 'VegetativeProductId'
    end
    object QryStS_StrainFloweringProductID: TIntegerField
      FieldName = 'FloweringProductID'
    end
    object QryStS_StrainHarvestProductId: TIntegerField
      FieldName = 'HarvestProductId'
    end
    object QryStS_Strainmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
    object QryStS_Strainmsupdatesitecode: TWideStringField
      FieldName = 'msupdatesitecode'
      Size = 3
    end
  end
  object cboClientLookup: TERPQuery
    SQLDelete.Strings = (
      'DELETE FROM tblclients'
      'WHERE'
      '  ClientID = :Old_ClientID')
    SQLUpdate.Strings = (
      'UPDATE tblclients'
      'SET'
      
        '  ClientID = :ClientID, Company = :Company, ForeignExchangeSellC' +
        'ode = :ForeignExchangeSellCode'
      'WHERE'
      '  ClientID = :Old_ClientID')
    SQLRefresh.Strings = (
      
        'SELECT tblclients.ClientID, tblclients.Company, tblclients.Forei' +
        'gnExchangeSellCode FROM tblclients'
      'WHERE'
      '  tblclients.ClientID = :Old_ClientID')
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientID, Company, ForeignExchangeSellCode'
      'FROM tblclients'
      
        'WHERE tblclients.Company Is Not Null And tblclients.Active <>'#39'F'#39 +
        ' And tblclients.Supplier = '#39'T'#39
      'Order by company')
    FetchRows = 1
    Left = 280
    Top = 5
    object cboClientLookupCompany: TWideStringField
      DisplayWidth = 25
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object cboClientLookupClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
    end
    object cboClientLookupForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblclients.ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
  end
end
