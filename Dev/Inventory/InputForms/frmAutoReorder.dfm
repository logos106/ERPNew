inherited AutoReorderGUI: TAutoReorderGUI
  Left = 366
  Top = 255
  HelpContext = 26000
  Caption = 'Auto Re-Order'
  ClientHeight = 491
  ClientWidth = 606
  OldCreateOrder = True
  ExplicitLeft = 366
  ExplicitTop = 255
  ExplicitWidth = 622
  ExplicitHeight = 530
  DesignSize = (
    606
    491)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 37
    Width = 606
    HelpContext = 26023
    ExplicitTop = 399
    ExplicitWidth = 426
  end
  inherited shapehint: TShape
    Left = 18
    ExplicitLeft = 9
  end
  inherited imgGridWatermark: TImage
    HelpContext = 26001
  end
  inherited shapehintextra1: TShape
    Left = 82
    ExplicitLeft = 56
  end
  object pnlTitle: TDNMPanel [5]
    Left = 76
    Top = 2
    Width = 460
    Height = 45
    HelpContext = 26018
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 456
      Height = 41
      HelpContext = 26019
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
        Width = 456
        Height = 41
        HelpContext = 26020
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Auto Re-Order'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 234
      end
    end
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 423
    Width = 606
    Height = 68
    HelpContext = 26029
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      606
      68)
    object lblMsg: TLabel
      Left = 1
      Top = 1
      Width = 604
      Height = 30
      HelpContext = 26006
      Align = alTop
      Alignment = taCenter
      Caption = 
        'Selecting '#39'Start'#39' will Create Smart Order for all Products in th' +
        'e Selection  which has the Selected Qty Type is < It'#39's Preferred' +
        '  Level Qty'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitWidth = 599
    end
    object btnProductForecastFormula: TDNMSpeedButton
      Left = 258
      Top = 32
      Width = 87
      Height = 27
      HelpContext = 26022
      Anchors = []
      Caption = '&Forecast'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnProductForecastFormulaClick
    end
    object btnStart: TDNMSpeedButton
      Left = 23
      Top = 32
      Width = 87
      Height = 27
      HelpContext = 26012
      Anchors = []
      Caption = '&Start'
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnStartClick
    end
    object btnClose: TDNMSpeedButton
      Left = 495
      Top = 32
      Width = 87
      Height = 27
      HelpContext = 26013
      Anchors = []
      Cancel = True
      Caption = '&Close'
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCloseClick
    end
    object btnReorderLevels: TDNMSpeedButton
      Left = 141
      Top = 32
      Width = 87
      Height = 27
      HelpContext = 26028
      Anchors = []
      Caption = '&Reorder Lvls'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnReorderLevelsClick
    end
    object btnHowTo: TDNMSpeedButton
      Left = 376
      Top = 32
      Width = 87
      Height = 27
      HelpContext = 26030
      Anchors = []
      Caption = 'How To'
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
      TabOrder = 4
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnHowToClick
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 37
    Width = 606
    Height = 386
    HelpContext = 26031
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 515
    object DNMPanel4: TDNMPanel
      AlignWithMargins = True
      Left = 2
      Top = 350
      Width = 602
      Height = 34
      HelpContext = 26032
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object lblInProgress: TLabel
        Left = 359
        Top = 0
        Width = 243
        Height = 34
        HelpContext = 26004
        Align = alRight
        Caption = 'In Progress .... Please Wait'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        Visible = False
        ExplicitHeight = 22
      end
      object chkShowOrder: TCheckBox
        Left = 29
        Top = 9
        Width = 157
        Height = 15
        HelpContext = 26011
        Alignment = taLeftJustify
        Caption = 'Show Order(s) Created'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
    end
    object OptBaseson: TRadioGroup
      AlignWithMargins = True
      Left = 2
      Top = 149
      Width = 602
      Height = 61
      HelpContext = 26025
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      Caption = 'Based On'
      Columns = 5
      ItemIndex = 0
      Items.Strings = (
        'In-Stock Qty'
        'Available Qty'
        'Available Qty - SOBO'
        'In-Stock Qty + Internal SOBO'
        'Available Qty + Internal SO')
      ParentShowHint = False
      PopupMenu = mnuOptBaseson
      ShowHint = True
      TabOrder = 1
      WordWrap = True
      OnClick = OptBasesonClick
    end
    object DNMPanel5: TDNMPanel
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 602
      Height = 145
      HelpContext = 26033
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        602
        145)
      object Shape6: TShape
        Left = 142
        Top = 22
        Width = 279
        Height = 119
        HelpContext = 26034
        Brush.Style = bsClear
        Pen.Color = clGray
      end
      object Label3: TLabel
        Left = 105
        Top = 35
        Width = 32
        Height = 15
        HelpContext = 26003
        Alignment = taRightJustify
        Caption = 'Class'
        Transparent = True
      end
      object Label5: TLabel
        Left = 90
        Top = 73
        Width = 47
        Height = 15
        HelpContext = 26007
        Alignment = taRightJustify
        Caption = 'Supplier'
        Transparent = True
      end
      object Label2: TLabel
        Left = 386
        Top = 5
        Width = 17
        Height = 15
        HelpContext = 26002
        Caption = 'All '
        Transparent = True
      end
      object Label1: TLabel
        Left = 92
        Top = 112
        Width = 45
        Height = 15
        HelpContext = 26035
        Alignment = taRightJustify
        Caption = 'Product'
        Transparent = True
      end
      object Shape3: TShape
        Left = 142
        Top = 60
        Width = 279
        Height = 40
        HelpContext = 26036
        Brush.Style = bsClear
        Pen.Color = clGray
      end
      object cboClass: TwwDBLookupCombo
        Left = 148
        Top = 31
        Width = 201
        Height = 23
        HelpContext = 26017
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ClassName'#9'30'#9'ClassName'#9'F')
        LookupTable = qryClass
        LookupField = 'ClassName'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboSupplier: TwwDBLookupCombo
        Left = 148
        Top = 69
        Width = 201
        Height = 23
        HelpContext = 26014
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Company'#9'20'#9'Supplier'#9'T')
        LookupTable = qrySupplier
        LookupField = 'Company'
        Enabled = False
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object chkAllClasses: TCheckBox
        Left = 387
        Top = 35
        Width = 14
        Height = 14
        HelpContext = 26016
        TabOrder = 2
        OnClick = chkAllClassesClick
      end
      object ChkALLSupp: TCheckBox
        Left = 387
        Top = 73
        Width = 14
        Height = 14
        HelpContext = 26015
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = ChkALLSuppClick
      end
      object chkallProducts: TCheckBox
        AlignWithMargins = True
        Left = 387
        Top = 112
        Width = 14
        Height = 14
        HelpContext = 26026
        Margins.Top = 7
        Margins.Bottom = 7
        Checked = True
        State = cbChecked
        TabOrder = 4
        WordWrap = True
        OnClick = chkallProductsClick
      end
      object btnProdList: TDNMSpeedButton
        Left = 239
        Top = 108
        Width = 103
        Height = 23
        HelpContext = 26027
        Anchors = [akTop, akRight]
        Caption = '&Product List'
        DisableTransparent = False
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnProdListClick
      end
    end
    object DNMPanel7: TDNMPanel
      Left = 1
      Top = 211
      Width = 604
      Height = 138
      HelpContext = 26037
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      ExplicitWidth = 513
      object Shape4: TShape
        Left = 27
        Top = 16
        Width = 164
        Height = 106
        HelpContext = 26038
        Brush.Style = bsClear
        Pen.Color = clGray
      end
      object Shape2: TShape
        Left = 190
        Top = 16
        Width = 139
        Height = 106
        HelpContext = 26039
        Brush.Style = bsClear
        Pen.Color = clGray
      end
      object Label6: TLabel
        AlignWithMargins = True
        Left = 48
        Top = 34
        Width = 124
        Height = 15
        HelpContext = 26040
        Margins.Top = 5
        Margins.Bottom = 0
        Caption = 'Transaction To Create'
        Transparent = True
      end
      object Label4: TLabel
        AlignWithMargins = True
        Left = 194
        Top = 21
        Width = 128
        Height = 30
        HelpContext = 26041
        Margins.Top = 0
        Margins.Bottom = 0
        Alignment = taRightJustify
        Caption = 'Limit No of Products in Each Transaction'
        Transparent = True
        WordWrap = True
      end
      object Shape1: TShape
        Left = 27
        Top = 54
        Width = 302
        Height = 68
        HelpContext = 26042
        Brush.Style = bsClear
        Pen.Color = clGray
      end
      object lblwarningSOProducts: TLabel
        AlignWithMargins = True
        Left = 426
        Top = 3
        Width = 175
        Height = 120
        HelpContext = 26043
        Margins.Bottom = 15
        Align = alRight
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 
          '>20 Products in the BOM Sales Order is not Reccomented,  It can ' +
          'Cause '#39'Out of Memory'#39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlBottom
        Visible = False
        WordWrap = True
        ExplicitLeft = 425
        ExplicitHeight = 45
      end
      object lblNoOfProducts: TLabel
        AlignWithMargins = True
        Left = 245
        Top = 3
        Width = 175
        Height = 120
        HelpContext = 26044
        Margins.Bottom = 15
        Align = alRight
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 
          '>20 Products in the BOM Sales Order is not Reccomented,  It can ' +
          'Cause '#39'Out of Memory'#39
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlBottom
        Visible = False
        WordWrap = True
        ExplicitLeft = 244
        ExplicitHeight = 45
      end
      object chkCreateInternalSO: TCheckBox
        Left = 49
        Top = 65
        Width = 138
        Height = 15
        HelpContext = 26045
        Alignment = taLeftJustify
        Caption = 'Internal Sales Order '
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object chkCreateSmartOrder: TCheckBox
        Left = 91
        Top = 90
        Width = 96
        Height = 15
        HelpContext = 26046
        Alignment = taLeftJustify
        Caption = 'Smart Order'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object edtNoinSalesOrder: TAdvSpinEdit
        Left = 220
        Top = 58
        Width = 94
        Height = 24
        HelpContext = 26047
        Value = 0
        DateValue = 44015.648661296300000000
        HexValue = 0
        Enabled = True
        IncrementFloat = 0.100000000000000000
        IncrementFloatPage = 1.000000000000000000
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        TabOrder = 2
        Visible = True
        Version = '1.4.7.0'
        OnChange = edtNoinSalesOrderChange
        OnExit = edtNoinSalesOrderChange
      end
      object edtNoinSmartorder: TAdvSpinEdit
        Left = 220
        Top = 85
        Width = 94
        Height = 24
        HelpContext = 26048
        Value = 0
        DateValue = 44015.648661296300000000
        HexValue = 0
        Enabled = True
        IncrementFloat = 0.100000000000000000
        IncrementFloatPage = 1.000000000000000000
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        TabOrder = 3
        Visible = True
        Version = '1.4.7.0'
      end
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102008400100110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qrySupplier: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company '
      'FROM tblclients'
      'WHERE Active = '#39'T'#39
      'And Supplier = '#39'T'#39' '
      'Order By Company')
    Left = 130
    Top = 119
  end
  object qryClass: TERPQuery
    SQL.Strings = (
      'SELECT ClassID, ClassName FROM tblClass WHERE Active = '#39'T'#39)
    Left = 131
    Top = 54
  end
  object mnuOptBaseson: TPopupMenu
    Left = 176
    Top = 200
    object OpenList1: TMenuItem
      Caption = 'Open List'
      HelpContext = 26049
      OnClick = OpenList1Click
    end
  end
end
