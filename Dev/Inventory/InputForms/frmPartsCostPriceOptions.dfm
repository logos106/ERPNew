inherited fmPartsCostPriceOptions: TfmPartsCostPriceOptions
  Left = 788
  Top = 120
  HelpContext = 1073002
  Caption = 'Cost / Price Recalculation Options'
  ClientHeight = 486
  ClientWidth = 645
  Position = poMainFormCenter
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 661
  ExplicitHeight = 525
  DesignSize = (
    645
    486)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 72
    Width = 645
    HelpContext = 1073003
    ExplicitTop = 46
    ExplicitWidth = 593
  end
  object lblProductName: TLabel [3]
    Left = 21
    Top = 56
    Width = 81
    Height = 15
    HelpContext = 1073004
    Alignment = taRightJustify
    Anchors = [akTop]
    Caption = 'Product Name'
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
  object lblMsg: TLabel [4]
    Left = 0
    Top = 473
    Width = 645
    Height = 13
    HelpContext = 1073005
    Align = alBottom
    Alignment = taCenter
    Caption = 'lblMsg'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlBottom
    Visible = False
    WordWrap = True
    ExplicitWidth = 37
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 72
    Width = 645
    Height = 161
    HelpContext = 1073009
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      645
      161)
    object Label8: TLabel
      Left = 16
      Top = 7
      Width = 174
      Height = 15
      HelpContext = 1073010
      Anchors = [akTop]
      Caption = 'Recalculate Options to Choose'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object chkChangeCost: TCheckBox
      Left = 53
      Top = 36
      Width = 145
      Height = 17
      HelpContext = 1073011
      Caption = 'Change All Cost'
      TabOrder = 0
    end
    object optPriceRecalculate: TRadioGroup
      Left = 45
      Top = 68
      Width = 503
      Height = 84
      HelpContext = 1073012
      Caption = 'Price Recalculate Option'
      Items.Strings = (
        'Keep '#39'Gross Margin'#39'/'#39'Markup'#39' and Recalculate Price'
        'Keep Price and Recalculate '#39'Gross Margin'#39'/'#39'Markup'#39)
      TabOrder = 1
    end
    object chkChangePrice: TCheckBox
      Left = 262
      Top = 36
      Width = 145
      Height = 17
      HelpContext = 1073013
      Caption = 'Change All Prices'
      TabOrder = 2
    end
  end
  object pnlPurchase: TDNMPanel [7]
    Left = 0
    Top = 233
    Width = 645
    Height = 190
    HelpContext = 1073014
    Align = alBottom
    BevelInner = bvRaised
    BevelKind = bkFlat
    BevelWidth = 3
    Color = 15263976
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    Transparent = False
    DesignSize = (
      641
      186)
    object Bevel2: TBevel
      Left = 77
      Top = 141
      Width = 476
      Height = 42
      HelpContext = 1073015
      Shape = bsFrame
    end
    object Bevel1: TBevel
      Left = 77
      Top = 93
      Width = 476
      Height = 42
      HelpContext = 1073016
      Shape = bsFrame
    end
    object Label4: TLabel
      Left = 26
      Top = 40
      Width = 43
      Height = 15
      HelpContext = 1073017
      Caption = 'Qty Buy'
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
    object Label5: TLabel
      Left = 346
      Top = 40
      Width = 43
      Height = 15
      HelpContext = 1073018
      Anchors = [akTop, akRight]
      Caption = 'Qty Sell'
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
    object lblcost: TLabel
      Left = 15
      Top = 68
      Width = 54
      Height = 15
      HelpContext = 1073019
      Alignment = taRightJustify
      Caption = 'Cost (Inc)'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblPrice: TLabel
      Left = 331
      Top = 68
      Width = 58
      Height = 15
      HelpContext = 1073020
      Alignment = taRightJustify
      Caption = 'Price (Inc)'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 107
      Top = 155
      Width = 189
      Height = 15
      HelpContext = 1073021
      Caption = 'Update Price when Cost Increase'
      Enabled = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 353
      Top = 155
      Width = 194
      Height = 15
      HelpContext = 1073022
      Caption = 'Update Price when Cost Decrease'
      Enabled = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 109
      Top = 105
      Width = 97
      Height = 19
      HelpContext = 1073023
      Alignment = taCenter
      AutoSize = False
      Caption = ' %(Ex): Cost / Sell'
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
    object Label7: TLabel
      Left = 14
      Top = 8
      Width = 87
      Height = 15
      HelpContext = 1073024
      Anchors = [akTop]
      Caption = 'Product Details'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object txtBuy3: TDBEdit
      Left = 243
      Top = 36
      Width = 72
      Height = 23
      HelpContext = 1073025
      TabStop = False
      DataField = 'BuyQTY3'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      OnEnter = ForceExit
    end
    object txtBuy1: TDBEdit
      Left = 76
      Top = 36
      Width = 72
      Height = 23
      HelpContext = 1073026
      TabStop = False
      DataField = 'BuyQTY1'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnEnter = ForceExit
    end
    object txtBuy2: TDBEdit
      Left = 159
      Top = 36
      Width = 72
      Height = 23
      HelpContext = 1073027
      TabStop = False
      DataField = 'BuyQTY2'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      OnEnter = ForceExit
    end
    object txtCost1: TwwDBEdit
      Left = 76
      Top = 64
      Width = 72
      Height = 23
      HelpContext = 1073028
      TabStop = False
      DataField = 'COSTINC1'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = ForceExit
    end
    object txtCost3: TwwDBEdit
      Left = 243
      Top = 64
      Width = 72
      Height = 23
      HelpContext = 1073029
      TabStop = False
      DataField = 'COST3'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = ForceExit
    end
    object txtCost2: TwwDBEdit
      Left = 159
      Top = 64
      Width = 72
      Height = 23
      HelpContext = 1073030
      TabStop = False
      DataField = 'COST2'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = ForceExit
    end
    object txtSell1: TDBEdit
      Left = 399
      Top = 36
      Width = 72
      Height = 23
      HelpContext = 1073031
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'SellQTY1'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      OnEnter = ForceExit
    end
    object txtPrice1: TwwDBEdit
      Left = 399
      Top = 64
      Width = 72
      Height = 23
      HelpContext = 1073032
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'PRICEINC1'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = ForceExit
    end
    object txtSell2: TDBEdit
      Left = 482
      Top = 36
      Width = 72
      Height = 23
      HelpContext = 1073033
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'SellQTY2'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
      OnEnter = ForceExit
    end
    object txtPrice2: TwwDBEdit
      Left = 482
      Top = 64
      Width = 72
      Height = 23
      HelpContext = 1073034
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'PRICE2'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = ForceExit
    end
    object txtSell3: TDBEdit
      Left = 565
      Top = 36
      Width = 72
      Height = 23
      HelpContext = 1073035
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'SellQTY3'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 10
      OnEnter = ForceExit
    end
    object txtPrice3: TwwDBEdit
      Left = 565
      Top = 64
      Width = 72
      Height = 23
      HelpContext = 1073036
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'PRICE3'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 11
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = ForceExit
    end
    object DBCheckBox35: TwwCheckBox
      Left = 86
      Top = 154
      Width = 13
      Height = 17
      HelpContext = 1073037
      TabStop = False
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
      Color = clBtnFace
      DataField = 'OnCostIncrease'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 12
      OnEnter = ForceExit
      ReadOnly = True
    end
    object DBCheckBox80: TwwCheckBox
      Left = 333
      Top = 154
      Width = 14
      Height = 17
      HelpContext = 1073038
      TabStop = False
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
      Color = clBtnFace
      DataField = 'OnCostDecrease'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 13
      OnEnter = ForceExit
      ReadOnly = True
    end
    object rgMarkupType: TwwRadioGroup
      Left = 339
      Top = 103
      Width = 200
      Height = 21
      HelpContext = 1073039
      DisableThemes = False
      Frame.NonFocusBorders = [efTopBorder, efBottomBorder]
      ShowBorder = False
      Columns = 2
      DataField = 'GrossMarginMode'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Items.Strings = (
        'Markup'
        'Gross Margin')
      TabOrder = 14
      Values.Strings = (
        'T'
        'F')
      OnEnter = ForceExit
    end
    object txtmarkup: TwwDBEdit
      Left = 211
      Top = 101
      Width = 97
      Height = 23
      HelpContext = 1073040
      DataField = 'Sell_Cost_Percentage'
      DataSource = frmParts.qryProductDS
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Picture.AutoFill = False
      TabOrder = 15
      UnboundDataType = wwDefault
      UsePictureMask = False
      WantReturns = False
      WordWrap = False
      OnEnter = ForceExit
    end
  end
  object pnlTitle: TDNMPanel [8]
    Left = 81
    Top = 5
    Width = 509
    Height = 35
    HelpContext = 1073041
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 505
      Height = 31
      HelpContext = 1073042
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
        Width = 505
        Height = 31
        HelpContext = 1073043
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Cost / Price Recalculation Options'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 172
      end
    end
  end
  object edtPart: TwwDBEdit [9]
    Left = 111
    Top = 47
    Width = 444
    Height = 32
    HelpContext = 1073044
    TabStop = False
    Anchors = [akTop]
    DataField = 'PARTNAME'
    DataSource = frmParts.qryProductDS
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    OnEnter = ForceExit
  end
  object DNMPanel2: TDNMPanel [10]
    Left = 0
    Top = 423
    Width = 645
    Height = 50
    HelpContext = 1073006
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      645
      50)
    object btnClose: TDNMSpeedButton
      Left = 369
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 1073007
      Anchors = []
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
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnOk: TDNMSpeedButton
      Left = 181
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 1073008
      Anchors = []
      Caption = '&Ok'
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
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
end
