inherited frmQueryOptions: TfrmQueryOptions
  Left = 343
  Top = 200
  HelpContext = 340000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Query Options'
  ClientHeight = 467
  ClientWidth = 560
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Letter_Label: TLabel [0]
    Left = 22
    Top = 134
    Width = 166
    Height = 18
    HelpContext = 340002
    AutoSize = False
    Caption = 'Select a &Document Template'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 340001
  end
  object SpeedButton1: TDNMSpeedButton [2]
    Left = 522
    Top = 132
    Width = 23
    Height = 22
    HelpContext = 340003
    DisableTransparent = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555555555555555555555555555555555555555555555555555555555555555
      555555555555555555555555555555555555555FFFFFFFFFF555550000000000
      55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
      B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
      000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
      555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
      55555575FFF75555555555700007555555555557777555555555555555555555
      5555555555555555555555555555555555555555555555555555}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    TabOrder = 7
    OnClick = SpeedButton1Click
  end
  object rgSelect: TwwRadioGroup [3]
    Left = 16
    Top = 65
    Width = 521
    Height = 56
    HelpContext = 340004
    ItemIndex = 0
    TransparentActiveItem = True
    Frame.FocusStyle = efsFrameSunken
    Frame.NonFocusStyle = efsFrameEtched
    Indents.ButtonX = 9
    Indents.ButtonY = -1
    Indents.TextY = -1
    Transparent = True
    Caption = 'Select One'
    Columns = 5
    Ctl3D = True
    Items.Strings = (
      'Customers'
      'Suppliers'
      'Employees'
      'Other Contacts'
      'Loyalty')
    ParentCtl3D = False
    TabOrder = 0
    Values.Strings = (
      '1'
      '2'
      '3'
      '4')
    OnChange = rgSelectChange
    OnClick = rgSelectClick
  end
  object cmdClose: TDNMSpeedButton [4]
    Left = 419
    Top = 430
    Width = 104
    Height = 27
    HelpContext = 340005
    Cancel = True
    Caption = '&Close'
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
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 6
    OnClick = cmdCloseClick
  end
  object cmdDocument: TDNMSpeedButton [5]
    Left = 163
    Top = 430
    Width = 104
    Height = 27
    HelpContext = 340006
    Caption = '&To Document'
    Default = True
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
      FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
      00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
      F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
      00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
      F033777777777337F73309999990FFF0033377777777FFF77333099999000000
      3333777777777777333333399033333333333337773333333333333903333333
      3333333773333333333333303333333333333337333333333333}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 4
    OnClick = cmdDocumentClick
  end
  object cmdAutoSend: TDNMSpeedButton [6]
    Left = 36
    Top = 430
    Width = 104
    Height = 27
    HelpContext = 340007
    Cancel = True
    Caption = '&Auto Send'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      000037777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
      FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF7777BBF
      FFF07F333777777F3FF70FFFFFFFB9BF1CC07F3FFF337F7377770F777FFFB99B
      C1C07F7773337F377F370FFFFFFFB9BBC1C07FFFFFFF7F337FF700000077B999
      B000777777777F33777733337377B9999B33333F733373F337FF3377377B99BB
      9BB33377F337F377377F3737377B9B79B9B737F73337F7F7F37F33733777BB7B
      BBB73373333377F37F3737333777BB777B9B3733333377F337F7333333777B77
      77BB3333333337333377333333333777337B3333333333333337}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 3
    OnClick = cmdAutoSendClick
  end
  object btnExport: TDNMSpeedButton [7]
    Left = 291
    Top = 430
    Width = 104
    Height = 27
    HelpContext = 340008
    Caption = '&Export'
    Default = True
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 5
    OnClick = btnExportClick
  end
  object TabCtl3: TPageControl [8]
    Left = 20
    Top = 167
    Width = 519
    Height = 252
    HelpContext = 340009
    ActivePage = Filter_Records
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    RaggedRight = True
    TabHeight = 25
    TabIndex = 0
    TabOrder = 2
    TabWidth = 129
    OnChange = TabCtl3Change
    object Filter_Records: TTabSheet
      HelpContext = 340010
      Caption = '&Filter Records'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 217
        HelpContext = 340011
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Field_Label: TLabel
          Left = 88
          Top = 5
          Width = 42
          Height = 18
          HelpContext = 340012
          AutoSize = False
          Caption = 'Field:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Col1_Label: TLabel
          Left = 228
          Top = 5
          Width = 89
          Height = 18
          HelpContext = 340013
          AutoSize = False
          Caption = 'Comparison:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label21: TLabel
          Left = 379
          Top = 5
          Width = 85
          Height = 18
          HelpContext = 340014
          AutoSize = False
          Caption = 'Compare to:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object dtp6: TDateTimePicker
          Left = 378
          Top = 183
          Width = 127
          Height = 23
          HelpContext = 340015
          CalAlignment = dtaLeft
          Date = 38182.5077494792
          Time = 38182.5077494792
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Kind = dtkDate
          ParseInput = False
          ParentFont = False
          TabOrder = 28
        end
        object dtp5: TDateTimePicker
          Left = 378
          Top = 151
          Width = 127
          Height = 23
          HelpContext = 340016
          CalAlignment = dtaLeft
          Date = 38182.5077494792
          Time = 38182.5077494792
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Kind = dtkDate
          ParseInput = False
          ParentFont = False
          TabOrder = 27
          OnChange = cboCompare5Change
        end
        object dtp4: TDateTimePicker
          Left = 378
          Top = 119
          Width = 127
          Height = 23
          HelpContext = 340017
          CalAlignment = dtaLeft
          Date = 38182.5077494792
          Time = 38182.5077494792
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Kind = dtkDate
          ParseInput = False
          ParentFont = False
          TabOrder = 26
          OnChange = cboCompare4Change
        end
        object dtp3: TDateTimePicker
          Left = 378
          Top = 88
          Width = 127
          Height = 23
          HelpContext = 340018
          CalAlignment = dtaLeft
          Date = 38182.5077494792
          Time = 38182.5077494792
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Kind = dtkDate
          ParseInput = False
          ParentFont = False
          TabOrder = 25
          OnChange = cboCompare3Change
        end
        object dtp2: TDateTimePicker
          Left = 378
          Top = 56
          Width = 127
          Height = 23
          HelpContext = 340019
          CalAlignment = dtaLeft
          Date = 38182.5077494792
          Time = 38182.5077494792
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Kind = dtkDate
          ParseInput = False
          ParentFont = False
          TabOrder = 24
          OnChange = cboCompare2Change
        end
        object dtp1: TDateTimePicker
          Left = 378
          Top = 24
          Width = 127
          Height = 23
          HelpContext = 340020
          CalAlignment = dtaLeft
          Date = 38182.5077494792
          Time = 38182.5077494792
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Kind = dtkDate
          ParseInput = False
          ParentFont = False
          TabOrder = 23
          OnChange = cboCompare1Change
        end
        object cboComparison1: TComboBox
          Left = 227
          Top = 24
          Width = 131
          Height = 23
          HelpContext = 340021
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 1
          OnChange = cboComparison1Change
          Items.Strings = (
            'equal to'
            'not equal to'
            'less than'
            'greater than'
            'less than or equal'
            'greater than or equal'
            'is blank'
            'is not blank'
            'starts with')
        end
        object cboCompare1: TEdit
          Left = 378
          Top = 24
          Width = 128
          Height = 23
          HelpContext = 340022
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = cboCompare1Change
        end
        object cboAndOr2: TComboBox
          Left = 6
          Top = 56
          Width = 57
          Height = 23
          HelpContext = 340023
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 3
          OnChange = cboAndOr2Change
          Items.Strings = (
            'and'
            'or')
        end
        object cboField2: TComboBox
          Left = 87
          Top = 56
          Width = 120
          Height = 23
          HelpContext = 340024
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 4
          OnChange = cboField2Change
        end
        object cboComparison2: TComboBox
          Left = 227
          Top = 56
          Width = 131
          Height = 23
          HelpContext = 340025
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 5
          OnChange = cboComparison2Change
          Items.Strings = (
            'equal to'
            'not equal to'
            'less than'
            'greater than'
            'less than or equal'
            'greater than or equal'
            'is blank'
            'is not blank'
            'starts with'
            '')
        end
        object cboCompare2: TEdit
          Left = 378
          Top = 56
          Width = 128
          Height = 23
          HelpContext = 340026
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnChange = cboCompare2Change
        end
        object cboAndOr3: TComboBox
          Left = 6
          Top = 88
          Width = 57
          Height = 23
          HelpContext = 340027
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 7
          OnChange = cboAndOr3Change
          Items.Strings = (
            'and'
            'or')
        end
        object cboField3: TComboBox
          Left = 87
          Top = 88
          Width = 120
          Height = 23
          HelpContext = 340028
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 8
          OnChange = cboField3Change
        end
        object cboComparison3: TComboBox
          Left = 227
          Top = 88
          Width = 131
          Height = 23
          HelpContext = 340029
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 9
          OnChange = cboComparison3Change
          Items.Strings = (
            'equal to'
            'not equal to'
            'less than'
            'greater than'
            'less than or equal'
            'greater than or equal'
            'is blank'
            'is not blank'
            'starts with'
            '')
        end
        object cboCompare3: TEdit
          Left = 378
          Top = 88
          Width = 128
          Height = 23
          HelpContext = 340030
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnChange = cboCompare3Change
        end
        object cboAndOr4: TComboBox
          Left = 6
          Top = 119
          Width = 57
          Height = 23
          HelpContext = 340031
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 11
          OnChange = cboAndOr4Change
          Items.Strings = (
            'and'
            'or')
        end
        object cboField4: TComboBox
          Left = 87
          Top = 119
          Width = 120
          Height = 23
          HelpContext = 340032
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 12
          OnChange = cboField4Change
        end
        object cboComparison4: TComboBox
          Left = 227
          Top = 120
          Width = 131
          Height = 23
          HelpContext = 340033
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 13
          OnChange = cboComparison4Change
          Items.Strings = (
            'equal to'
            'not equal to'
            'less than'
            'greater than'
            'less than or equal'
            'greater than or equal'
            'is blank'
            'is not blank'
            'starts with'
            '')
        end
        object cboCompare4: TEdit
          Left = 378
          Top = 119
          Width = 128
          Height = 23
          HelpContext = 340034
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
          OnChange = cboCompare4Change
        end
        object cboAndOr5: TComboBox
          Left = 6
          Top = 151
          Width = 57
          Height = 23
          HelpContext = 340035
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 15
          OnChange = cboAndOr5Change
          Items.Strings = (
            'and'
            'or')
        end
        object cboField5: TComboBox
          Left = 87
          Top = 151
          Width = 120
          Height = 23
          HelpContext = 340036
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 16
          OnChange = cboField5Change
        end
        object cboComparison5: TComboBox
          Left = 227
          Top = 151
          Width = 131
          Height = 23
          HelpContext = 340037
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 17
          OnChange = cboComparison5Change
          Items.Strings = (
            'equal to'
            'not equal to'
            'less than'
            'greater than'
            'less than or equal'
            'greater than or equal'
            'is blank'
            'is not blank'
            'starts with')
        end
        object cboCompare5: TEdit
          Left = 378
          Top = 151
          Width = 128
          Height = 23
          HelpContext = 340038
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
          OnChange = cboCompare5Change
        end
        object cboAndOr6: TComboBox
          Left = 6
          Top = 183
          Width = 57
          Height = 23
          HelpContext = 340039
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 19
          OnChange = cboAndOr6Change
          Items.Strings = (
            'and'
            'or')
        end
        object cboField6: TComboBox
          Left = 87
          Top = 182
          Width = 120
          Height = 23
          HelpContext = 340040
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 20
          OnChange = cboField6Change
        end
        object cboComparison6: TComboBox
          Left = 227
          Top = 183
          Width = 131
          Height = 23
          HelpContext = 340041
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 21
          OnChange = cboComparison6Change
          Items.Strings = (
            'equal to'
            'not equal to'
            'less than'
            'greater than'
            'less than or equal'
            'greater than or equal'
            'is blank'
            'is not blank'
            'starts with')
        end
        object cboCompare6: TEdit
          Left = 378
          Top = 183
          Width = 128
          Height = 23
          HelpContext = 340042
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 22
        end
        object cboField1: TComboBox
          Left = 87
          Top = 24
          Width = 120
          Height = 23
          HelpContext = 340043
          AutoDropDown = True
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          ParentFont = False
          TabOrder = 0
          OnChange = cboField1Change
        end
      end
    end
    object Sort_Records: TTabSheet
      HelpContext = 340044
      Caption = '&Sort Records'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 217
        HelpContext = 340045
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label40: TLabel
          Left = 102
          Top = 5
          Width = 50
          Height = 18
          HelpContext = 340046
          AutoSize = False
          Caption = 'Sort by'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label48: TLabel
          Left = 100
          Top = 74
          Width = 56
          Height = 18
          HelpContext = 340047
          AutoSize = False
          Caption = 'Then by'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label55: TLabel
          Left = 99
          Top = 146
          Width = 56
          Height = 18
          HelpContext = 340048
          AutoSize = False
          Caption = 'Then by'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object DNMPanel4: TDNMPanel
          Left = 100
          Top = 20
          Width = 326
          Height = 49
          HelpContext = 340049
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label43: TLabel
            Left = 242
            Top = 6
            Width = 63
            Height = 18
            HelpContext = 340050
            AutoSize = False
            Caption = 'Ascending'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label45: TLabel
            Left = 242
            Top = 28
            Width = 72
            Height = 18
            HelpContext = 340051
            AutoSize = False
            Caption = 'Descending'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object cboSort1: TComboBox
            Left = 11
            Top = 18
            Width = 185
            Height = 23
            HelpContext = 340052
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 0
            OnChange = cboSort1Change
            OnCloseUp = cboSortCloseUp
          end
          object Option42: TRadioButton
            Left = 223
            Top = 8
            Width = 17
            Height = 16
            HelpContext = 340053
            Color = 14211288
            ParentColor = False
            TabOrder = 1
          end
          object Option44: TRadioButton
            Left = 222
            Top = 30
            Width = 17
            Height = 16
            HelpContext = 340054
            Color = 14211288
            ParentColor = False
            TabOrder = 2
          end
        end
        object DNMPanel5: TDNMPanel
          Left = 100
          Top = 89
          Width = 326
          Height = 49
          HelpContext = 340055
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label6: TLabel
            Left = 242
            Top = 6
            Width = 63
            Height = 18
            HelpContext = 340056
            AutoSize = False
            Caption = 'Ascending'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label7: TLabel
            Left = 242
            Top = 28
            Width = 72
            Height = 18
            HelpContext = 340057
            AutoSize = False
            Caption = 'Descending'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object cboSort2: TComboBox
            Left = 11
            Top = 18
            Width = 185
            Height = 23
            HelpContext = 340058
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 0
            OnChange = cboSort2Change
            OnCloseUp = cboSortCloseUp
          end
          object Option49: TRadioButton
            Left = 223
            Top = 8
            Width = 17
            Height = 16
            HelpContext = 340059
            Color = 14211288
            ParentColor = False
            TabOrder = 1
          end
          object Option51: TRadioButton
            Left = 222
            Top = 30
            Width = 17
            Height = 16
            HelpContext = 340060
            Color = 14211288
            ParentColor = False
            TabOrder = 2
          end
        end
        object DNMPanel6: TDNMPanel
          Left = 100
          Top = 161
          Width = 326
          Height = 49
          HelpContext = 340061
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object Label8: TLabel
            Left = 242
            Top = 6
            Width = 63
            Height = 18
            HelpContext = 340062
            AutoSize = False
            Caption = 'Ascending'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label9: TLabel
            Left = 242
            Top = 28
            Width = 72
            Height = 18
            HelpContext = 340063
            AutoSize = False
            Caption = 'Descending'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object cboSort3: TComboBox
            Left = 11
            Top = 18
            Width = 185
            Height = 23
            HelpContext = 340064
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 0
            OnCloseUp = cboSortCloseUp
          end
          object Option56: TRadioButton
            Left = 223
            Top = 8
            Width = 17
            Height = 16
            HelpContext = 340065
            Color = 14211288
            ParentColor = False
            TabOrder = 1
          end
          object Option58: TRadioButton
            Left = 222
            Top = 30
            Width = 17
            Height = 16
            HelpContext = 340066
            Color = 14211288
            ParentColor = False
            TabOrder = 2
          end
        end
      end
    end
    object tabLoyalty: TTabSheet
      HelpContext = 340067
      Caption = '&Loyalty Program'
      ImageIndex = 3
      object pnlLoyalty: TDNMPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 217
        HelpContext = 340068
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object grpLoyalty: TwwRadioGroup
          Left = 56
          Top = 16
          Width = 401
          Height = 177
          HelpContext = 340069
          ItemIndex = 0
          TransparentActiveItem = True
          Transparent = True
          Caption = 'Loyalty Program'
          Items.Strings = (
            'Customers who have &Exceeded Sales Target'
            'Customers who have NOT had a &Recent Sale'
            'Customers who have NOT had a Recent &Appointment'
            '&Other Contacts who have NOT had a Recent Appointment')
          TabOrder = 0
        end
      end
    end
    object SendSettings: TTabSheet
      HelpContext = 340070
      Caption = 'Au&to Send Settings'
      ImageIndex = 2
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 511
        Height = 217
        HelpContext = 340071
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel4: TBevel
          Left = 57
          Top = 7
          Width = 385
          Height = 128
          HelpContext = 340072
        end
        object Label1: TLabel
          Left = 64
          Top = 20
          Width = 88
          Height = 18
          HelpContext = 340073
          AutoSize = False
          Caption = 'First Preference'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label2: TLabel
          Left = 64
          Top = 52
          Width = 105
          Height = 18
          HelpContext = 340074
          AutoSize = False
          Caption = 'Second Preference'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label3: TLabel
          Left = 64
          Top = 84
          Width = 105
          Height = 18
          HelpContext = 340075
          AutoSize = False
          Caption = 'Third Preference'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Bevel6: TBevel
          Left = 56
          Top = 144
          Width = 385
          Height = 64
          HelpContext = 340076
        end
        object Label4: TLabel
          Left = 62
          Top = 148
          Width = 368
          Height = 41
          HelpContext = 340077
          AutoSize = False
          Caption = 
            'Use the drop down lists to select your preferences for mailing. ' +
            'For example, if you select "Fax" in the first box, "Email" in th' +
            'e second box and "Printer" in the third box, then each mail item' +
            ' will be sent according to your first preferred '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label5: TLabel
          Left = 62
          Top = 181
          Width = 368
          Height = 27
          HelpContext = 340078
          AutoSize = False
          Caption = 
            'method. If this is not possible, it will use the second method, ' +
            'and then the third and so on until the mail is finally sent.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object FirstPreference: TwwDBComboBox
          Left = 280
          Top = 16
          Width = 153
          Height = 23
          HelpContext = 340079
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          DataField = 'MailMergeOutputPref1'
          DropDownCount = 8
          ItemHeight = 0
          Items.Strings = (
            'Email'
            'Fax'
            'Printer')
          ItemIndex = 0
          Sorted = False
          TabOrder = 0
          UnboundDataType = wwDefault
        end
        object SecondPreference: TwwDBComboBox
          Left = 280
          Top = 49
          Width = 153
          Height = 23
          HelpContext = 340080
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'MailMergeOutputPref2'
          DropDownCount = 8
          ItemHeight = 0
          Items.Strings = (
            'Email'
            'Fax'
            'Printer')
          ItemIndex = 1
          Sorted = False
          TabOrder = 1
          UnboundDataType = wwDefault
        end
        object ThirdPreference: TwwDBComboBox
          Left = 280
          Top = 80
          Width = 153
          Height = 23
          HelpContext = 340081
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'MailMergeOutputPref3'
          DropDownCount = 8
          ItemHeight = 0
          Items.Strings = (
            'Email'
            'Fax'
            'Printer'
            ''
            '')
          ItemIndex = 2
          ReadOnly = True
          Sorted = False
          TabOrder = 2
          UnboundDataType = wwDefault
        end
        object pnlChooseRpt: TDNMPanel
          Left = 195
          Top = 110
          Width = 130
          Height = 21
          HelpContext = 340082
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object lblChooseRpt: TLabel
            Left = 23
            Top = 3
            Width = 99
            Height = 15
            HelpContext = 340083
            Caption = 'C&hoose Template'
            Transparent = True
          end
          object chkChooseRpt: TCheckBox
            Left = 7
            Top = 2
            Width = 14
            Height = 17
            HelpContext = 340084
            TabOrder = 0
          end
        end
      end
    end
  end
  object txtLetter: TEdit [9]
    Left = 191
    Top = 131
    Width = 328
    Height = 23
    HelpContext = 340085
    TabOrder = 1
    OnExit = txtLetterExit
  end
  object pnlTitle: TDNMPanel [10]
    Left = 157
    Top = 7
    Width = 238
    Height = 45
    HelpContext = 340086
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 41
      HelpContext = 340087
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.2.1.1'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 234
        Height = 41
        HelpContext = 340088
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Mail Merge'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  object WordApplication1: TWordApplication [13]
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 418
    Top = 6
  end
  object OpenDialog1: TOpenDialog [14]
    Filter = 'Letter Template (*.doc)|*.doc|All Files (*.*)|*.*'
    Left = 487
    Top = 6
  end
  object SaveDialog1: TSaveDialog [15]
    DefaultExt = 'txt'
    FileName = 'MailMerge_Export.txt'
    Filter = 'Mail Merge Export File (*.txt)|*.txt'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save Export file where ...'
    Left = 456
    Top = 8
  end
  object qryCustomers: TMyQuery [16]
    SQL.Strings = (
      'SELECT FieldName, '
      'If(Length(FieldLabel)<>0,FieldLabel,FieldName) as FieldLabel'
      'FROM tblMergeFields '
      'WHERE (TableName='#39'tblCustomers'#39') OR '
      '( (Length(FieldLabel)=0) AND (Length(TableName)=0) ) '
      'ORDER BY FieldLabel;')
    Left = 135
    Top = 11
  end
  object qryMailMerge: TMyQuery [17]
    Left = 169
    Top = 11
  end
  object qrytmpMailMerge: TMyQuery [18]
    SQL.Strings = (
      'select * from tmp_tblmailmergeemail')
    Left = 307
    Top = 11
  end
  object qryEmployees: TMyQuery [19]
    SQL.Strings = (
      'SELECT FieldName, '
      'If(Length(FieldLabel)<>0,FieldLabel,FieldName) as FieldLabel'
      'FROM tblMergeFields '
      'WHERE (TableName='#39'tblEmployees'#39') OR '
      '( (Length(FieldLabel)=0) AND (Length(TableName)=0) AND '
      'FieldName NOT LIKE '#39'CUSTDATE%'#39') '
      'ORDER BY FieldLabel;')
    Left = 238
    Top = 11
  end
  object qryOthers: TMyQuery [20]
    SQL.Strings = (
      'SELECT FieldName, '
      'If(Length(FieldLabel)<>0,FieldLabel,FieldName) as FieldLabel'
      'FROM tblMergeFields '
      'WHERE (TableName='#39'tblOthers'#39') OR '
      '( (Length(FieldLabel)=0) AND (Length(TableName)=0) ) '
      'ORDER BY FieldLabel;')
    Left = 272
    Top = 11
  end
  object qrySuppliers: TMyQuery [21]
    SQL.Strings = (
      'SELECT FieldName, '
      'If(Length(FieldLabel)<>0,FieldLabel,FieldName) as FieldLabel'
      'FROM tblMergeFields '
      'WHERE (TableName='#39'tblSuppliers'#39') OR '
      '( (Length(FieldLabel)=0) AND (Length(TableName)=0) ) '
      'ORDER BY FieldLabel;')
    Left = 203
    Top = 11
  end
  object tblCustomFields: TMyTable [22]
    TableName = 'tblcustomfields'
    FetchAll = True
    Left = 344
    Top = 11
    object tblCustomFieldsGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Origin = 'tblcustomfields.GlobalRef'
      Size = 255
    end
    object tblCustomFieldsCFLabel1: TStringField
      FieldName = 'CFLabel1'
      Origin = 'tblcustomfields.CFLabel1'
      Size = 16
    end
    object tblCustomFieldsCFCust1: TStringField
      FieldName = 'CFCust1'
      Origin = 'tblcustomfields.CFCust1'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl1: TStringField
      FieldName = 'CFEmpl1'
      Origin = 'tblcustomfields.CFEmpl1'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp1: TStringField
      FieldName = 'CFSupp1'
      Origin = 'tblcustomfields.CFSupp1'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo1: TStringField
      FieldName = 'CFIsCombo1'
      Origin = 'tblcustomfields.CFIsCombo1'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel2: TStringField
      FieldName = 'CFLabel2'
      Origin = 'tblcustomfields.CFLabel2'
      Size = 16
    end
    object tblCustomFieldsCFCust2: TStringField
      FieldName = 'CFCust2'
      Origin = 'tblcustomfields.CFCust2'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl2: TStringField
      FieldName = 'CFEmpl2'
      Origin = 'tblcustomfields.CFEmpl2'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp2: TStringField
      FieldName = 'CFSupp2'
      Origin = 'tblcustomfields.CFSupp2'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo2: TStringField
      FieldName = 'CFIsCombo2'
      Origin = 'tblcustomfields.CFIsCombo2'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel3: TStringField
      FieldName = 'CFLabel3'
      Origin = 'tblcustomfields.CFLabel3'
      Size = 16
    end
    object tblCustomFieldsCFCust3: TStringField
      FieldName = 'CFCust3'
      Origin = 'tblcustomfields.CFCust3'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl3: TStringField
      FieldName = 'CFEmpl3'
      Origin = 'tblcustomfields.CFEmpl3'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp3: TStringField
      FieldName = 'CFSupp3'
      Origin = 'tblcustomfields.CFSupp3'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo3: TStringField
      FieldName = 'CFIsCombo3'
      Origin = 'tblcustomfields.CFIsCombo3'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel4: TStringField
      FieldName = 'CFLabel4'
      Origin = 'tblcustomfields.CFLabel4'
      Size = 16
    end
    object tblCustomFieldsCFCust4: TStringField
      FieldName = 'CFCust4'
      Origin = 'tblcustomfields.CFCust4'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl4: TStringField
      FieldName = 'CFEmpl4'
      Origin = 'tblcustomfields.CFEmpl4'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp4: TStringField
      FieldName = 'CFSupp4'
      Origin = 'tblcustomfields.CFSupp4'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo4: TStringField
      FieldName = 'CFIsCombo4'
      Origin = 'tblcustomfields.CFIsCombo4'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel5: TStringField
      FieldName = 'CFLabel5'
      Origin = 'tblcustomfields.CFLabel5'
      Size = 16
    end
    object tblCustomFieldsCFCust5: TStringField
      FieldName = 'CFCust5'
      Origin = 'tblcustomfields.CFCust5'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl5: TStringField
      FieldName = 'CFEmpl5'
      Origin = 'tblcustomfields.CFEmpl5'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp5: TStringField
      FieldName = 'CFSupp5'
      Origin = 'tblcustomfields.CFSupp5'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo5: TStringField
      FieldName = 'CFIsCombo5'
      Origin = 'tblcustomfields.CFIsCombo5'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel6: TStringField
      FieldName = 'CFLabel6'
      Origin = 'tblcustomfields.CFLabel6'
      Size = 16
    end
    object tblCustomFieldsCFCust6: TStringField
      FieldName = 'CFCust6'
      Origin = 'tblcustomfields.CFCust6'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl6: TStringField
      FieldName = 'CFEmpl6'
      Origin = 'tblcustomfields.CFEmpl6'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp6: TStringField
      FieldName = 'CFSupp6'
      Origin = 'tblcustomfields.CFSupp6'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo6: TStringField
      FieldName = 'CFIsCombo6'
      Origin = 'tblcustomfields.CFIsCombo6'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel7: TStringField
      FieldName = 'CFLabel7'
      Origin = 'tblcustomfields.CFLabel7'
      Size = 16
    end
    object tblCustomFieldsCFCust7: TStringField
      FieldName = 'CFCust7'
      Origin = 'tblcustomfields.CFCust7'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl7: TStringField
      FieldName = 'CFEmpl7'
      Origin = 'tblcustomfields.CFEmpl7'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp7: TStringField
      FieldName = 'CFSupp7'
      Origin = 'tblcustomfields.CFSupp7'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo7: TStringField
      FieldName = 'CFIsCombo7'
      Origin = 'tblcustomfields.CFIsCombo7'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel8: TStringField
      FieldName = 'CFLabel8'
      Origin = 'tblcustomfields.CFLabel8'
      Size = 16
    end
    object tblCustomFieldsCFCust8: TStringField
      FieldName = 'CFCust8'
      Origin = 'tblcustomfields.CFCust8'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl8: TStringField
      FieldName = 'CFEmpl8'
      Origin = 'tblcustomfields.CFEmpl8'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp8: TStringField
      FieldName = 'CFSupp8'
      Origin = 'tblcustomfields.CFSupp8'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo8: TStringField
      FieldName = 'CFIsCombo8'
      Origin = 'tblcustomfields.CFIsCombo8'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel9: TStringField
      FieldName = 'CFLabel9'
      Origin = 'tblcustomfields.CFLabel9'
      Size = 16
    end
    object tblCustomFieldsCFCust9: TStringField
      FieldName = 'CFCust9'
      Origin = 'tblcustomfields.CFCust9'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl9: TStringField
      FieldName = 'CFEmpl9'
      Origin = 'tblcustomfields.CFEmpl9'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp9: TStringField
      FieldName = 'CFSupp9'
      Origin = 'tblcustomfields.CFSupp9'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo9: TStringField
      FieldName = 'CFIsCombo9'
      Origin = 'tblcustomfields.CFIsCombo9'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel10: TStringField
      FieldName = 'CFLabel10'
      Origin = 'tblcustomfields.CFLabel10'
      Size = 16
    end
    object tblCustomFieldsCFCust10: TStringField
      FieldName = 'CFCust10'
      Origin = 'tblcustomfields.CFCust10'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl10: TStringField
      FieldName = 'CFEmpl10'
      Origin = 'tblcustomfields.CFEmpl10'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp10: TStringField
      FieldName = 'CFSupp10'
      Origin = 'tblcustomfields.CFSupp10'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo10: TStringField
      FieldName = 'CFIsCombo10'
      Origin = 'tblcustomfields.CFIsCombo10'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel11: TStringField
      FieldName = 'CFLabel11'
      Origin = 'tblcustomfields.CFLabel11'
      Size = 16
    end
    object tblCustomFieldsCFCust11: TStringField
      FieldName = 'CFCust11'
      Origin = 'tblcustomfields.CFCust11'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl11: TStringField
      FieldName = 'CFEmpl11'
      Origin = 'tblcustomfields.CFEmpl11'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp11: TStringField
      FieldName = 'CFSupp11'
      Origin = 'tblcustomfields.CFSupp11'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo11: TStringField
      FieldName = 'CFIsCombo11'
      Origin = 'tblcustomfields.CFIsCombo11'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel12: TStringField
      FieldName = 'CFLabel12'
      Origin = 'tblcustomfields.CFLabel12'
      Size = 16
    end
    object tblCustomFieldsCFCust12: TStringField
      FieldName = 'CFCust12'
      Origin = 'tblcustomfields.CFCust12'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl12: TStringField
      FieldName = 'CFEmpl12'
      Origin = 'tblcustomfields.CFEmpl12'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp12: TStringField
      FieldName = 'CFSupp12'
      Origin = 'tblcustomfields.CFSupp12'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo12: TStringField
      FieldName = 'CFIsCombo12'
      Origin = 'tblcustomfields.CFIsCombo12'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel13: TStringField
      FieldName = 'CFLabel13'
      Origin = 'tblcustomfields.CFLabel13'
      Size = 16
    end
    object tblCustomFieldsCFCust13: TStringField
      FieldName = 'CFCust13'
      Origin = 'tblcustomfields.CFCust13'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl13: TStringField
      FieldName = 'CFEmpl13'
      Origin = 'tblcustomfields.CFEmpl13'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp13: TStringField
      FieldName = 'CFSupp13'
      Origin = 'tblcustomfields.CFSupp13'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo13: TStringField
      FieldName = 'CFIsCombo13'
      Origin = 'tblcustomfields.CFIsCombo13'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel14: TStringField
      FieldName = 'CFLabel14'
      Origin = 'tblcustomfields.CFLabel14'
      Size = 16
    end
    object tblCustomFieldsCFCust14: TStringField
      FieldName = 'CFCust14'
      Origin = 'tblcustomfields.CFCust14'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl14: TStringField
      FieldName = 'CFEmpl14'
      Origin = 'tblcustomfields.CFEmpl14'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp14: TStringField
      FieldName = 'CFSupp14'
      Origin = 'tblcustomfields.CFSupp14'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo14: TStringField
      FieldName = 'CFIsCombo14'
      Origin = 'tblcustomfields.CFIsCombo14'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel15: TStringField
      FieldName = 'CFLabel15'
      Origin = 'tblcustomfields.CFLabel15'
      Size = 16
    end
    object tblCustomFieldsCFCust15: TStringField
      FieldName = 'CFCust15'
      Origin = 'tblcustomfields.CFCust15'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl15: TStringField
      FieldName = 'CFEmpl15'
      Origin = 'tblcustomfields.CFEmpl15'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp15: TStringField
      FieldName = 'CFSupp15'
      Origin = 'tblcustomfields.CFSupp15'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsCombo15: TStringField
      FieldName = 'CFIsCombo15'
      Origin = 'tblcustomfields.CFIsCombo15'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsEditedFlag: TStringField
      FieldName = 'EditedFlag'
      Origin = 'tblcustomfields.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr1: TStringField
      FieldName = 'CFOthr1'
      Origin = 'tblcustomfields.CFOthr1'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr2: TStringField
      FieldName = 'CFOthr2'
      Origin = 'tblcustomfields.CFOthr2'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr3: TStringField
      FieldName = 'CFOthr3'
      Origin = 'tblcustomfields.CFOthr3'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr4: TStringField
      FieldName = 'CFOthr4'
      Origin = 'tblcustomfields.CFOthr4'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr5: TStringField
      FieldName = 'CFOthr5'
      Origin = 'tblcustomfields.CFOthr5'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr6: TStringField
      FieldName = 'CFOthr6'
      Origin = 'tblcustomfields.CFOthr6'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr7: TStringField
      FieldName = 'CFOthr7'
      Origin = 'tblcustomfields.CFOthr7'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr8: TStringField
      FieldName = 'CFOthr8'
      Origin = 'tblcustomfields.CFOthr8'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr9: TStringField
      FieldName = 'CFOthr9'
      Origin = 'tblcustomfields.CFOthr9'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr10: TStringField
      FieldName = 'CFOthr10'
      Origin = 'tblcustomfields.CFOthr10'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr11: TStringField
      FieldName = 'CFOthr11'
      Origin = 'tblcustomfields.CFOthr11'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr12: TStringField
      FieldName = 'CFOthr12'
      Origin = 'tblcustomfields.CFOthr12'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr13: TStringField
      FieldName = 'CFOthr13'
      Origin = 'tblcustomfields.CFOthr13'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr14: TStringField
      FieldName = 'CFOthr14'
      Origin = 'tblcustomfields.CFOthr14'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr15: TStringField
      FieldName = 'CFOthr15'
      Origin = 'tblcustomfields.CFOthr15'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets1: TStringField
      FieldName = 'CFAssets1'
      Origin = 'tblcustomfields.CFAssets1'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets2: TStringField
      FieldName = 'CFAssets2'
      Origin = 'tblcustomfields.CFAssets2'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets3: TStringField
      FieldName = 'CFAssets3'
      Origin = 'tblcustomfields.CFAssets3'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets4: TStringField
      FieldName = 'CFAssets4'
      Origin = 'tblcustomfields.CFAssets4'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets5: TStringField
      FieldName = 'CFAssets5'
      Origin = 'tblcustomfields.CFAssets5'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets6: TStringField
      FieldName = 'CFAssets6'
      Origin = 'tblcustomfields.CFAssets6'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets7: TStringField
      FieldName = 'CFAssets7'
      Origin = 'tblcustomfields.CFAssets7'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets8: TStringField
      FieldName = 'CFAssets8'
      Origin = 'tblcustomfields.CFAssets8'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets9: TStringField
      FieldName = 'CFAssets9'
      Origin = 'tblcustomfields.CFAssets9'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets10: TStringField
      FieldName = 'CFAssets10'
      Origin = 'tblcustomfields.CFAssets10'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets11: TStringField
      FieldName = 'CFAssets11'
      Origin = 'tblcustomfields.CFAssets11'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets12: TStringField
      FieldName = 'CFAssets12'
      Origin = 'tblcustomfields.CFAssets12'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets13: TStringField
      FieldName = 'CFAssets13'
      Origin = 'tblcustomfields.CFAssets13'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets14: TStringField
      FieldName = 'CFAssets14'
      Origin = 'tblcustomfields.CFAssets14'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets15: TStringField
      FieldName = 'CFAssets15'
      Origin = 'tblcustomfields.CFAssets15'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFCust16: TStringField
      FieldName = 'CFCust16'
      Origin = 'tblcustomfields.CFCust16'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFCust17: TStringField
      FieldName = 'CFCust17'
      Origin = 'tblcustomfields.CFCust17'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFCust18: TStringField
      FieldName = 'CFCust18'
      Origin = 'tblcustomfields.CFCust18'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl16: TStringField
      FieldName = 'CFEmpl16'
      Origin = 'tblcustomfields.CFEmpl16'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl17: TStringField
      FieldName = 'CFEmpl17'
      Origin = 'tblcustomfields.CFEmpl17'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFEmpl18: TStringField
      FieldName = 'CFEmpl18'
      Origin = 'tblcustomfields.CFEmpl18'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp16: TStringField
      FieldName = 'CFSupp16'
      Origin = 'tblcustomfields.CFSupp16'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp17: TStringField
      FieldName = 'CFSupp17'
      Origin = 'tblcustomfields.CFSupp17'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFSupp18: TStringField
      FieldName = 'CFSupp18'
      Origin = 'tblcustomfields.CFSupp18'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr16: TStringField
      FieldName = 'CFOthr16'
      Origin = 'tblcustomfields.CFOthr16'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr17: TStringField
      FieldName = 'CFOthr17'
      Origin = 'tblcustomfields.CFOthr17'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFOthr18: TStringField
      FieldName = 'CFOthr18'
      Origin = 'tblcustomfields.CFOthr18'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets16: TStringField
      FieldName = 'CFAssets16'
      Origin = 'tblcustomfields.CFAssets16'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets17: TStringField
      FieldName = 'CFAssets17'
      Origin = 'tblcustomfields.CFAssets17'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFAssets18: TStringField
      FieldName = 'CFAssets18'
      Origin = 'tblcustomfields.CFAssets18'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired1: TStringField
      FieldName = 'CFIsRequired1'
      Origin = 'tblcustomfields.CFIsRequired1'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired2: TStringField
      FieldName = 'CFIsRequired2'
      Origin = 'tblcustomfields.CFIsRequired2'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired3: TStringField
      FieldName = 'CFIsRequired3'
      Origin = 'tblcustomfields.CFIsRequired3'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired4: TStringField
      FieldName = 'CFIsRequired4'
      Origin = 'tblcustomfields.CFIsRequired4'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired5: TStringField
      FieldName = 'CFIsRequired5'
      Origin = 'tblcustomfields.CFIsRequired5'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired6: TStringField
      FieldName = 'CFIsRequired6'
      Origin = 'tblcustomfields.CFIsRequired6'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired7: TStringField
      FieldName = 'CFIsRequired7'
      Origin = 'tblcustomfields.CFIsRequired7'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired8: TStringField
      FieldName = 'CFIsRequired8'
      Origin = 'tblcustomfields.CFIsRequired8'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired9: TStringField
      FieldName = 'CFIsRequired9'
      Origin = 'tblcustomfields.CFIsRequired9'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired10: TStringField
      FieldName = 'CFIsRequired10'
      Origin = 'tblcustomfields.CFIsRequired10'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired11: TStringField
      FieldName = 'CFIsRequired11'
      Origin = 'tblcustomfields.CFIsRequired11'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired12: TStringField
      FieldName = 'CFIsRequired12'
      Origin = 'tblcustomfields.CFIsRequired12'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired13: TStringField
      FieldName = 'CFIsRequired13'
      Origin = 'tblcustomfields.CFIsRequired13'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired14: TStringField
      FieldName = 'CFIsRequired14'
      Origin = 'tblcustomfields.CFIsRequired14'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired15: TStringField
      FieldName = 'CFIsRequired15'
      Origin = 'tblcustomfields.CFIsRequired15'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFLabel16: TStringField
      FieldName = 'CFLabel16'
      Origin = 'tblcustomfields.CFLabel16'
      Size = 16
    end
    object tblCustomFieldsCFLabel17: TStringField
      FieldName = 'CFLabel17'
      Origin = 'tblcustomfields.CFLabel17'
      Size = 16
    end
    object tblCustomFieldsCFLabel18: TStringField
      FieldName = 'CFLabel18'
      Origin = 'tblcustomfields.CFLabel18'
      Size = 16
    end
    object tblCustomFieldsCFIsRequired16: TStringField
      FieldName = 'CFIsRequired16'
      Origin = 'tblcustomfields.CFIsRequired16'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired17: TStringField
      FieldName = 'CFIsRequired17'
      Origin = 'tblcustomfields.CFIsRequired17'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsCFIsRequired18: TStringField
      FieldName = 'CFIsRequired18'
      Origin = 'tblcustomfields.CFIsRequired18'
      FixedChar = True
      Size = 1
    end
    object tblCustomFieldsID: TIntegerField
      FieldName = 'ID'
    end
  end
  object tblWordMerge: TMyTable [23]
    TableName = 'tblawordmerge'
    FetchAll = True
    Left = 380
    Top = 9
  end
end
