inherited fmRewardPoints: TfmRewardPoints
  Left = 401
  Top = 299
  HelpContext = 701000
  Caption = 'Multiple Product Rewards'
  ClientHeight = 416
  ClientWidth = 684
  OldCreateOrder = True
  ExplicitLeft = 401
  ExplicitTop = 299
  ExplicitWidth = 700
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 416
    Width = 684
    ExplicitTop = 416
    ExplicitWidth = 684
    HelpContext = 701055
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 74
    Width = 247
    Height = 342
    HelpContext = 701001
    Align = alLeft
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    DesignSize = (
      247
      342)
    object Bevel5: TBevel
      Left = 6
      Top = 34
      Width = 236
      Height = 301
      HelpContext = 701002
      Anchors = [akLeft, akTop, akRight, akBottom]
    end
    object t: TwwDBGrid
      Left = 12
      Top = 39
      Width = 223
      Height = 289
      HelpContext = 701003
      Selected.Strings = (
        'PArtname'#9'26'#9'Product Name'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsParts
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentFont = False
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnDblClick = ProducttDblClick
      FooterColor = clWhite
      object tIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 18
        Height = 22
        HelpContext = 701054
        AllowAllUp = True
        Glyph.Data = {
          26040000424D2604000000000000360000002800000012000000120000000100
          180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
          636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
          7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
          00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
          FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
          000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
          D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
          0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
          FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
          D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
          00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
          00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
          0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
          E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
          AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
          07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
          0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
          00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
          FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
          FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
          007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
          CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
          0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
          FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
          1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
          C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
          D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
          E0E3FFFFFFFFFFFF0000}
        OnClick = tIButtonClick
      end
    end
    object btnProdList: TDNMSpeedButton
      Left = 8
      Top = 4
      Width = 89
      Height = 25
      HelpContext = 701004
      Action = actProductList
      Caption = 'Product List'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 0
    end
  end
  object pnlProductPoints: TDNMPanel [6]
    Left = 247
    Top = 74
    Width = 437
    Height = 342
    HelpContext = 701030
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 0
      Width = 437
      Height = 342
      HelpContext = 701005
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel3: TBevel
        Left = 7
        Top = 36
        Width = 423
        Height = 84
        HelpContext = 701007
      end
      object Bevel1: TBevel
        Left = 7
        Top = 206
        Width = 423
        Height = 84
        HelpContext = 701008
      end
      object Bevel2: TBevel
        Left = 7
        Top = 121
        Width = 423
        Height = 84
        HelpContext = 701009
      end
      object Label7: TLabel
        Left = 14
        Top = 56
        Width = 36
        Height = 15
        HelpContext = 701031
        Caption = 'Points'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label8: TLabel
        Left = 129
        Top = 56
        Width = 31
        Height = 15
        HelpContext = 701032
        Caption = 'Value'
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
        Left = 40
        Top = 134
        Width = 90
        Height = 15
        HelpContext = 701033
        Caption = 'Use Date Range'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object lblFrom: TLabel
        Left = 14
        Top = 158
        Width = 29
        Height = 15
        HelpContext = 701034
        Caption = 'From'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblTo: TLabel
        Left = 129
        Top = 158
        Width = 13
        Height = 15
        HelpContext = 701035
        Caption = 'To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label5: TLabel
        Left = 48
        Top = 213
        Width = 89
        Height = 15
        HelpContext = 701036
        Caption = 'Use Expiry Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label6: TLabel
        Left = 15
        Top = 236
        Width = 102
        Height = 15
        HelpContext = 701037
        Caption = 'Points Expires on '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 164
        Top = 236
        Width = 251
        Height = 15
        HelpContext = 701038
        Caption = 'Expires no of months from Date of Purchase'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 137
        Top = 263
        Width = 17
        Height = 15
        HelpContext = 701039
        Caption = 'Or '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 240
        Top = 54
        Width = 90
        Height = 18
        HelpContext = 701040
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
      object edtPoints: TwwDBEdit
        Left = 14
        Top = 76
        Width = 99
        Height = 23
        HelpContext = 701041
        DataField = 'Points'
        DataSource = dsProductPointsGUI
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = dodatachanged
      end
      object wwDBEdit2: TwwDBEdit
        Left = 129
        Top = 76
        Width = 97
        Height = 23
        HelpContext = 701042
        DataField = 'Value'
        DataSource = dsProductPointsGUI
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = dodatachanged
      end
      object chkUseDate: TwwCheckBox
        Left = 14
        Top = 134
        Width = 15
        Height = 14
        HelpContext = 701043
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
        DataField = 'UseDate'
        DataSource = dsProductPointsGUI
        TabOrder = 4
        OnClick = dodatachanged
      end
      object dtFrom: TwwDBDateTimePicker
        Left = 14
        Top = 173
        Width = 98
        Height = 22
        HelpContext = 701044
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        CalendarAttributes.PopupYearOptions.NumberColumns = 4
        DataField = 'DateFrom'
        DataSource = dsProductPointsGUI
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxDate = 401769.000000000000000000
        MinDate = -363.000000000000000000
        ParentFont = False
        ShowButton = True
        TabOrder = 5
        OnChange = dodatachanged
      end
      object dtTo: TwwDBDateTimePicker
        Left = 129
        Top = 173
        Width = 98
        Height = 22
        HelpContext = 701045
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        CalendarAttributes.PopupYearOptions.NumberColumns = 4
        DataField = 'DateTo'
        DataSource = dsProductPointsGUI
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxDate = 401769.000000000000000000
        MinDate = -363.000000000000000000
        ParentFont = False
        ShowButton = True
        TabOrder = 6
        OnChange = dodatachanged
      end
      object wwCheckBox1: TwwCheckBox
        Left = 15
        Top = 213
        Width = 15
        Height = 14
        HelpContext = 701046
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
        DataField = 'UseExpiryDate'
        DataSource = dsProductPointsGUI
        TabOrder = 7
        OnClick = dodatachanged
      end
      object wwDBDateTimePicker2: TwwDBDateTimePicker
        Left = 15
        Top = 259
        Width = 98
        Height = 23
        Hint = 'Allocated points will expire on this date.'
        HelpContext = 701047
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        CalendarAttributes.PopupYearOptions.NumberColumns = 4
        DataField = 'RewardPointExpiresOn'
        DataSource = dsProductPointsGUI
        Epoch = 1950
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MaxDate = 401769.000000000000000000
        MinDate = -363.000000000000000000
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        ShowButton = True
        TabOrder = 8
      end
      object edtExpiresOnNoOfMonthsAfterPurchase: TwwDBEdit
        Left = 164
        Top = 259
        Width = 99
        Height = 23
        HelpContext = 701048
        DataField = 'ExpiresOnNoOfMonthsAfterPurchase'
        DataSource = dsProductPointsGUI
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object cboClientType: TwwDBLookupCombo
        Left = 240
        Top = 76
        Width = 184
        Height = 23
        HelpContext = 701049
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'TypeName'#9'25'#9'TypeName'#9'F')
        DataField = 'ClientTypeID'
        DataSource = dsProductPointsGUI
        LookupTable = qryClientTypes
        LookupField = 'ClientTypeID'
        Options = [loColLines, loTitles]
        ParentFont = False
        TabOrder = 3
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
      end
      object pnlBottom: TDNMPanel
        Left = 1
        Top = 295
        Width = 435
        Height = 46
        HelpContext = 701050
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object lblinvalid: TLabel
          Left = 0
          Top = 31
          Width = 435
          Height = 15
          HelpContext = 701051
          Align = alBottom
          Alignment = taCenter
          Caption = 'Error Message'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitWidth = 81
        end
        object btnSave: TDNMSpeedButton
          Left = 88
          Top = 3
          Width = 87
          Height = 27
          HelpContext = 701010
          Action = actMainSave
          Caption = '&Update'
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
          TabOrder = 0
        end
        object btnCancel: TDNMSpeedButton
          Left = 280
          Top = 3
          Width = 87
          Height = 27
          HelpContext = 701052
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
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 1
          OnClick = btnCancelClick
        end
      end
      object btnCreateSingle: TDNMSpeedButton
        Left = 342
        Top = 4
        Width = 87
        Height = 27
        HelpContext = 701053
        Caption = 'Single '
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
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
        TabOrder = 10
        OnClick = btnCreateSingleClick
      end
    end
  end
  object pnlTop: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 684
    Height = 74
    HelpContext = 701026
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      684
      74)
    object pnlTitle: TDNMPanel
      Left = 78
      Top = 7
      Width = 529
      Height = 45
      HelpContext = 701027
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
        Width = 525
        Height = 41
        HelpContext = 701028
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
          Width = 525
          Height = 41
          HelpContext = 701029
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Multiple Product Loyalty Rewards'
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
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 224
    Top = 0
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 313
    Top = 0
  end
  inherited DataState: TDataState
    Left = 90
    Top = 0
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    HelpContext = 701014
    Left = 269
    Top = 0
  end
  inherited imgsort: TImageList
    Left = 1
    Top = 0
    Bitmap = {
      494C010102000400180010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Distinct P.PARTSID,P.PARTNAME,'
      'cast( ifnull(U.UnitID, Units.UnitID)  as  signed) as UnitID, '
      
        'ifnull(U.UnitName, Units.UnitName) as UnitName, ifnull(U.Multipl' +
        'ier, Units.Multiplier) as Multiplier '
      'FROM tblparts AS P  '
      
        'Left Join tblunitsofmeasure AS U ON P.PARTSID = ifnull(U.PartID,' +
        '0)    and U.SalesDefault="T"'
      
        'Left Join tblunitsofmeasure AS Units ON  Units.unitname = '#39'Units' +
        #39'  and Units.Multiplier = 1 '
      'WHERE P.Active =  "T" AND P.PARTSID IN  (0)')
    Left = 492
    object qryPartsPArtname: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 26
      FieldName = 'PArtname'
      Origin = 'tblparts.PARTNAME'
      Size = 60
    end
    object qryPartsUnitName: TWideStringField
      DisplayLabel = 'Unit Name'
      DisplayWidth = 1
      FieldName = 'UnitName'
      Origin = '.UnitName'
      Visible = False
      Size = 15
    end
    object qryPartsMultiplier: TFloatField
      DisplayWidth = 1
      FieldName = 'Multiplier'
      Origin = '.Multiplier'
      Visible = False
    end
    object qryPartsUnitID: TLargeintField
      FieldName = 'UnitID'
    end
    object qryPartsPARTSID: TIntegerField
      FieldName = 'PARTSID'
    end
  end
  object dsParts: TDataSource
    DataSet = qryParts
    Left = 447
  end
  object alMain: TActionList
    Left = 403
    object actMainSave: TAction
      Caption = '&Update'
      HelpContext = 701024
      OnExecute = actMainSaveExecute
      OnUpdate = actMainSaveUpdate
    end
    object actProductList: TAction
      Caption = 'Product List'
      HelpContext = 701025
      OnExecute = actProductListExecute
    end
  end
  object qryProductPointsGUI: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PP.*'
      'FROM tblProductREwardPoints PP')
    Left = 135
    object qryProductPointsGUIProductRewardPointsId: TIntegerField
      FieldName = 'ProductRewardPointsId'
    end
    object qryProductPointsGUIPartsId: TIntegerField
      FieldName = 'PartsId'
    end
    object qryProductPointsGUIGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryProductPointsGUIPoints: TFloatField
      FieldName = 'Points'
    end
    object qryProductPointsGUIValue: TFloatField
      FieldName = 'Value'
      DisplayFormat = '"$"####,###,###,##0.00'
    end
    object qryProductPointsGUIUseDate: TWideStringField
      FieldName = 'UseDate'
      FixedChar = True
      Size = 1
    end
    object qryProductPointsGUIDateFrom: TDateField
      FieldName = 'DateFrom'
    end
    object qryProductPointsGUIDateTo: TDateField
      FieldName = 'DateTo'
    end
    object qryProductPointsGUIActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryProductPointsGUIDateCreated: TDateTimeField
      FieldName = 'DateCreated'
    end
    object qryProductPointsGUIUseExpiryDate: TWideStringField
      FieldName = 'UseExpiryDate'
      FixedChar = True
      Size = 1
    end
    object qryProductPointsGUIRewardPointExpiresOn: TDateField
      FieldName = 'RewardPointExpiresOn'
    end
    object qryProductPointsGUImsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryProductPointsGUIPartname: TWideStringField
      FieldName = 'Partname'
      Size = 100
    end
    object qryProductPointsGUIUOMID: TIntegerField
      FieldName = 'UOMID'
    end
    object qryProductPointsGUIUOM: TWideStringField
      FieldName = 'UOM'
      Size = 60
    end
    object qryProductPointsGUIUseUOM: TWideStringField
      FieldName = 'UseUOM'
      FixedChar = True
      Size = 1
    end
    object qryProductPointsGUIUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
    end
    object qryProductPointsGUIExpiresOnNoOfMonthsAfterPurchase: TIntegerField
      FieldName = 'ExpiresOnNoOfMonthsAfterPurchase'
    end
    object qryProductPointsGUIClientTypeID: TLargeintField
      FieldName = 'ClientTypeID'
    end
  end
  object dsProductPointsGUI: TDataSource
    DataSet = qryProductPointsGUI
    Left = 179
  end
  object qryProductPoints: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PP.*'
      'FROM tblProductREwardPoints PP')
    Left = 358
    object IntegerField1: TIntegerField
      FieldName = 'ProductRewardPointsId'
    end
    object IntegerField2: TIntegerField
      FieldName = 'PartsId'
    end
    object StringField1: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object FloatField1: TFloatField
      FieldName = 'Points'
    end
    object FloatField2: TFloatField
      FieldName = 'Value'
      DisplayFormat = '"$"####,###,###,##0.00'
    end
    object StringField2: TWideStringField
      FieldName = 'UseDate'
      FixedChar = True
      Size = 1
    end
    object DateField1: TDateField
      FieldName = 'DateFrom'
    end
    object DateField2: TDateField
      FieldName = 'DateTo'
    end
    object StringField3: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DateCreated'
    end
    object StringField5: TWideStringField
      FieldName = 'UseExpiryDate'
      FixedChar = True
      Size = 1
    end
    object DateField3: TDateField
      FieldName = 'RewardPointExpiresOn'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryProductPointsPartname: TWideStringField
      FieldName = 'Partname'
      Size = 100
    end
    object qryProductPointsUOMID: TIntegerField
      FieldName = 'UOMID'
    end
    object qryProductPointsUOM: TWideStringField
      FieldName = 'UOM'
      Size = 60
    end
    object qryProductPointsUseUOM: TWideStringField
      FieldName = 'UseUOM'
      FixedChar = True
      Size = 1
    end
    object qryProductPointsUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
    end
    object qryProductPointsExpiresOnNoOfMonthsAfterPurchase: TIntegerField
      FieldName = 'ExpiresOnNoOfMonthsAfterPurchase'
    end
    object qryProductPointsClientTypeID: TLargeintField
      FieldName = 'ClientTypeID'
    end
  end
  object DataSource1: TDataSource
    DataSet = qryProductPoints
    Left = 537
  end
  object qryClientTypes: TERPQuery
    SQL.Strings = (
      'SELECT TypeName, TypeDescription , TermsID, CreditLimit,'
      'GracePeriod, ClientTypeID'
      'FROM tblClientType'
      'WHERE Active = '#39'T'#39
      'Order By TypeName;')
    Options.LongStrings = False
    Left = 578
    Top = 1
  end
end
