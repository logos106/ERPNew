inherited ChartDesigner: TChartDesigner
  Left = 231
  Top = 167
  HelpContext = 59000
  Caption = 'Chart Designer'
  ClientHeight = 513
  ClientWidth = 878
  OldCreateOrder = True
  OnActivate = FormActivate
  ExplicitLeft = 231
  ExplicitTop = 167
  ExplicitWidth = 894
  ExplicitHeight = 552
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 513
    Width = 878
    HelpContext = 59062
    ExplicitTop = 513
    ExplicitWidth = 878
  end
  object SubForm: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 878
    Height = 513
    HelpContext = 59001
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object Splitter1: TSplitter
      Left = 194
      Top = 60
      Height = 453
      HelpContext = 59002
    end
    object Panel1: TDNMPanel
      Left = 0
      Top = 60
      Width = 194
      Height = 453
      HelpContext = 59003
      Align = alLeft
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Transparent = False
      object PageControlSeries: TPageControl
        Left = 0
        Top = 263
        Width = 194
        Height = 190
        HelpContext = 59004
        ActivePage = PanelSeries
        Align = alBottom
        TabOrder = 0
        object PanelSeries: TTabSheet
          HelpContext = 59005
          Caption = 'Series'
          object ChartListBox1: TChartListBox
            Left = 0
            Top = 22
            Width = 186
            Height = 139
            HelpContext = 59006
            Chart = DBChart1
            OnChangeColor = ChartListBox1ChangeColor
            OnChangeOrder = ChartListBox1ChangeOrder
            OnDblClickSeries = ChartListBox1DblClickSeries
            OnRemovedSeries = ChartListBox1RemovedSeries
            Align = alClient
            BorderStyle = bsNone
            ItemHeight = 24
            PopupMenu = LocalMenu
            TabOrder = 0
            OnClick = ChartListBox1Click
          end
          object ToolBar1: TToolBar
            Left = 0
            Top = 0
            Width = 186
            Height = 22
            HelpContext = 59007
            AutoSize = True
            Images = ImageListSeries
            ParentShowHint = False
            PopupMenu = PopupToolSeries
            ShowHint = True
            TabOrder = 1
            object SBAdd: TToolButton
              Left = 0
              Top = 0
              Hint = 'Add...'
              HelpContext = 59008
              ImageIndex = 0
              OnClick = SBAddClick
            end
            object SBDelete: TToolButton
              Left = 23
              Top = 0
              Hint = 'Delete...'
              HelpContext = 59009
              ImageIndex = 1
              OnClick = SBDeleteClick
            end
            object ToolButton3: TToolButton
              Left = 46
              Top = 0
              Width = 8
              HelpContext = 59010
              Style = tbsSeparator
            end
            object TBMoveUp: TToolButton
              Left = 54
              Top = 0
              Hint = 'Move Up'
              HelpContext = 59011
              ImageIndex = 2
              OnClick = TBMoveUpClick
            end
            object TBMoveDown: TToolButton
              Left = 77
              Top = 0
              Hint = 'Move Down'
              HelpContext = 59012
              ImageIndex = 3
              OnClick = TBMoveDownClick
            end
            object ToolButton6: TToolButton
              Left = 100
              Top = 0
              Width = 8
              HelpContext = 59013
              Style = tbsSeparator
            end
            object SBSeriesData: TToolButton
              Left = 108
              Top = 0
              Hint = 'Series Data'
              HelpContext = 59014
              Caption = 'SBSeriesData'
              ImageIndex = 8
              OnClick = SBSeriesDataClick
            end
            object SBEdit: TToolButton
              Left = 131
              Top = 0
              Hint = 'Edit...'
              HelpContext = 59015
              ImageIndex = 4
              OnClick = SBEditClick
            end
            object ToolButton2: TToolButton
              Left = 154
              Top = 0
              Width = 8
              HelpContext = 59016
              Style = tbsSeparator
            end
            object SBFont: TToolButton
              Left = 162
              Top = 0
              Hint = 'Title...'
              HelpContext = 59017
              ImageIndex = 5
              OnClick = Title1Click
            end
          end
        end
      end
      object PanelInspector: TDNMPanel
        Left = 0
        Top = 0
        Width = 194
        Height = 263
        HelpContext = 59018
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Transparent = False
        object Panel2: TDNMPanel
          Left = 2
          Top = 2
          Width = 190
          Height = 26
          HelpContext = 59019
          Align = alTop
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = True
          Transparent = False
          object ComboBoxParts: TwwDBComboBox
            Left = 2
            Top = 1
            Width = 161
            Height = 26
            HelpContext = 59020
            ShowButton = True
            Style = csDropDownList
            MapList = False
            AllowClearKey = True
            DropDownCount = 8
            DropDownWidth = 158
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ItemHeight = 14
            Items.Strings = (
              'Chart'
              'Legend'
              'Title'
              'Series'
              'Series Marks'
              'Axis'
              'Wall')
            ParentFont = False
            Sorted = False
            TabOrder = 0
            UnboundDataType = wwDefault
            OnChange = ComboBoxPartsChange
          end
        end
        object Inspector: TTeeInspector
          Left = 2
          Top = 28
          Width = 190
          Height = 233
          HelpContext = 59021
          Align = alClient
          Color = clWhite
          RowCount = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Options = [goFixedVertLine, goVertLine, goHorzLine, goColSizing, goThumbTracking]
          ParentFont = False
          TabOrder = 1
          Items = <
            item
              Expanded = False
            end>
          Header.Font.Color = clNavy
          ColWidths = (
            82
            104)
        end
      end
    end
    object ControlBar1: TControlBar
      Left = 0
      Top = 0
      Width = 878
      Height = 60
      HelpContext = 59024
      Align = alTop
      AutoSize = True
      BevelEdges = [beTop, beBottom]
      BevelInner = bvNone
      Color = clBtnFace
      ParentColor = False
      PopupMenu = PopupMenuToolbar
      RowSize = 29
      TabOrder = 1
      object PanelFont: TDNMPanel
        Left = 11
        Top = 31
        Width = 498
        Height = 25
        HelpContext = 59025
        Align = alTop
        AutoSize = True
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Transparent = False
        object FontBold: TSpeedButton
          Left = 216
          Top = 0
          Width = 23
          Height = 25
          Hint = 'Bold'
          HelpContext = 59026
          AllowAllUp = True
          GroupIndex = 2
          Flat = True
          OnClick = FontBoldClick
        end
        object FontItalic: TSpeedButton
          Left = 240
          Top = 0
          Width = 23
          Height = 25
          Hint = 'Italic'
          HelpContext = 59027
          AllowAllUp = True
          GroupIndex = 3
          Flat = True
          OnClick = FontBoldClick
        end
        object FontUnderline: TSpeedButton
          Left = 264
          Top = 0
          Width = 23
          Height = 25
          Hint = 'Underline'
          HelpContext = 59028
          AllowAllUp = True
          GroupIndex = 4
          Flat = True
          OnClick = FontBoldClick
        end
        object FontStrike: TSpeedButton
          Left = 288
          Top = 0
          Width = 23
          Height = 25
          Hint = 'Strike out'
          HelpContext = 59029
          AllowAllUp = True
          GroupIndex = 5
          Flat = True
          OnClick = FontBoldClick
        end
        object FontLeftAlign: TSpeedButton
          Left = 312
          Top = 0
          Width = 23
          Height = 25
          Hint = 'Left justify'
          HelpContext = 59030
          GroupIndex = 6
          Flat = True
          OnClick = FontLeftAlignClick
        end
        object FontCenterAlign: TSpeedButton
          Left = 336
          Top = 0
          Width = 23
          Height = 25
          Hint = 'Centered'
          HelpContext = 59031
          GroupIndex = 6
          Flat = True
          OnClick = FontLeftAlignClick
        end
        object FontRightAlign: TSpeedButton
          Left = 360
          Top = 0
          Width = 23
          Height = 25
          Hint = 'Right justify'
          HelpContext = 59032
          GroupIndex = 6
          Flat = True
          OnClick = FontLeftAlignClick
        end
        object ShapeFontColor: TShape
          Left = 0
          Top = 3
          Width = 20
          Height = 20
          Cursor = crHandPoint
          Hint = 'Font Color'
          HelpContext = 59033
          OnMouseUp = ShapeFontColorMouseUp
        end
        object SBOutline: TSpeedButton
          Left = 440
          Top = 0
          Width = 54
          Height = 25
          HelpContext = 59034
          Caption = 'Outline...'
          Flat = True
          OnClick = SBOutlineClick
        end
        object EditFontInter: TEdit
          Left = 392
          Top = 2
          Width = 29
          Height = 22
          Hint = 'Inter-char size'
          HelpContext = 59035
          Color = clWhite
          TabOrder = 2
          Text = '0'
        end
        object UDFontInter: TUpDown
          Left = 421
          Top = 2
          Width = 15
          Height = 22
          Hint = 'Inter-char size'
          HelpContext = 59036
          Associate = EditFontInter
          Min = -25
          Max = 25
          TabOrder = 3
        end
        object ComboFonts: TwwDBComboBox
          Left = 26
          Top = 2
          Width = 132
          Height = 22
          Hint = 'Font Name'
          HelpContext = 59037
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = True
          Color = clWhite
          DropDownCount = 15
          DropDownWidth = 132
          ItemHeight = 14
          Sorted = False
          TabOrder = 0
          UnboundDataType = wwDefault
          OnChange = ComboFontsChange
        end
        object ComboFontSize: TwwDBComboBox
          Left = 162
          Top = 2
          Width = 45
          Height = 22
          Hint = 'Font Size'
          HelpContext = 59038
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = True
          Color = clWhite
          DropDownCount = 8
          DropDownWidth = 45
          ItemHeight = 14
          Items.Strings = (
            '8'
            '9'
            '10'
            '11'
            '12'
            '14'
            '16'
            '18'
            '20'
            '22'
            '24'
            '26'
            '28'
            '36'
            '48'
            '72')
          Sorted = False
          TabOrder = 1
          UnboundDataType = wwDefault
          OnChange = ComboFontSizeChange
        end
      end
      object PanelPage: TDNMPanel
        Left = 386
        Top = 2
        Width = 103
        Height = 25
        HelpContext = 59039
        Align = alRight
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        object ChartPageNavigator1: TChartPageNavigator
          Left = 0
          Top = 0
          Width = 103
          Height = 25
          HelpContext = 59040
          Align = alClient
          ParentColor = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Chart = DBChart1
        end
      end
      object PanelTools: TDNMPanel
        Left = 242
        Top = 2
        Width = 131
        Height = 25
        HelpContext = 59041
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Transparent = False
        object Annotation: TSpeedButton
          Left = 0
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Add Annotation...'
          HelpContext = 59042
          AllowAllUp = True
          Flat = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333000330000033333330333300033
            3333330733300033333333700000073333333330330003344433333073000334
            7343333703007334334733330000333444333333000033347343333370073334
            3343333330033334447333333033333333333333333333333333}
          OnClick = AnnotationClick
        end
        object SBZoom: TSpeedButton
          Left = 25
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Enable Zoom'
          HelpContext = 59043
          AllowAllUp = True
          GroupIndex = 1
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33033333333333333F7F3333333333333000333333333333F777333333333333
            000333333333333F777333333333333000333333333333F77733333333333300
            033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
            33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
            3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
            33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
            333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
            333333773FF77333333333370007333333333333777333333333}
          NumGlyphs = 2
          OnClick = SBZoomClick
        end
        object SBScroll: TSpeedButton
          Left = 51
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Enable Scroll'
          HelpContext = 59044
          AllowAllUp = True
          GroupIndex = 1
          Flat = True
          Glyph.Data = {
            96010000424D9601000000000000760000002800000018000000180000000100
            0400000000002001000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333333300000033333333333333
            3330FFFFFF00333333333333330FFFFFFFFF00333333333330FFFFFFFFFFFF03
            3333333330FFFFFFFFFFFFF0333333330FFFFFFFFFFFFFF0333333330FFFFFFF
            FFFFFFFF033333330FFFFFFFFFFF0FFF033333330FFFFFFFFFFF00FF03333333
            0FFFFFFFFFFF0FFF033333330FFFFFFFFFFF0FFF033333330FFFFFFFFFFF0F00
            333333330FF0FF0FF0FF0033333333330FF0FF0FF0FF0333333333330FF0FF0F
            F0FF0333333333330FF0FF0FF0FF0333333333330FF0FF0FF0FF033333333333
            3000FF0FF0FF0333333333333333000FF0003333333333333333333003333333
            3333333333333333333333333333333333333333333333333333}
          OnClick = SBScrollClick
        end
        object SBDrawLine: TSpeedButton
          Left = 77
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Draw Lines'
          HelpContext = 59045
          AllowAllUp = True
          GroupIndex = 1
          Flat = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFCF0FFFFFFF9FFFFFCFF0FFFFF9
            FFFFFFFCFF0FFF9FFFFFFFFCFFF0F9FFFFFFFFFFCFFF9FFFFFFFFFFFCFF9F0FF
            FFFFFFFFFC9FFF0FFFFFFFFFFCFFFFF0FFFFFFFF9FCFFFFF0FFFFFF9FFCFFFFF
            FFFFFF9FFFFCFFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFF}
          OnClick = SBDrawLineClick
        end
        object SBHints: TSpeedButton
          Left = 103
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Show Hints'
          HelpContext = 59046
          AllowAllUp = True
          GroupIndex = 2
          Flat = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFF0999999FFFFFFFFF09999991FFFFFFFF09997777777
            777FF09997BBBBBBBB7FF09997BB0BB0BB7FF09997B0BB0BBB7FF09997B0B0B0
            0B7FF09997BBBBBBBB7FF09997777777777FF099999911FFFFFFF099999911FF
            FFFFF099999911FFFFFFF000000011FFFFFFFFFFFFFFFFFFFFFF}
          OnClick = SBHintsClick
        end
      end
      object TeeCommander1: TTeeCommander
        Left = 11
        Top = 2
        Width = 218
        Height = 25
        HelpContext = 59047
        Panel = DBChart1
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        ParentShowHint = False
        TabOrder = 3
        ChartEditor = ChartEditor1
        LabelValues = False
        OnEditedChart = TeeCommander1EditedChart
      end
      object ToolBarSeries: TToolBar
        Left = 522
        Top = 31
        Width = 70
        Height = 25
        HelpContext = 59048
        AutoSize = True
        ButtonHeight = 25
        Caption = 'ToolBarSeries'
        Images = ImageListSeries
        TabOrder = 4
        Wrapable = False
        object ColorEach: TToolButton
          Left = 0
          Top = 0
          Hint = 'Color Each Point'
          HelpContext = 59049
          AutoSize = True
          Down = True
          ImageIndex = 6
          ParentShowHint = False
          ShowHint = True
          Style = tbsCheck
          OnClick = ColorEachClick
        end
        object ShowAtLegend: TToolButton
          Left = 23
          Top = 0
          Hint = 'Show at Legend'
          HelpContext = 59050
          AutoSize = True
          Down = True
          ImageIndex = 7
          Style = tbsCheck
          OnClick = ShowAtLegendClick
        end
        object ShowMarks: TToolButton
          Left = 46
          Top = 0
          Hint = 'Show Series Marks'
          HelpContext = 59051
          Down = True
          ImageIndex = 5
          Style = tbsCheck
          OnClick = ShowMarksClick
        end
      end
      object Panel3: TDNMPanel
        Left = 502
        Top = 2
        Width = 100
        Height = 25
        HelpContext = 59052
        AutoSize = True
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 5
        Transparent = False
        object ShapeBorderColor: TShape
          Left = 0
          Top = 3
          Width = 20
          Height = 20
          Cursor = crHandPoint
          Hint = 'Border Color'
          HelpContext = 59053
          Visible = False
          OnMouseUp = ShapeBorderColorMouseUp
        end
        object BorderWidth: TScrollBar
          Left = 73
          Top = 0
          Width = 27
          Height = 25
          Hint = 'Border width'
          HelpContext = 59054
          Ctl3D = False
          Max = 10
          Min = 1
          PageSize = 0
          ParentCtl3D = False
          Position = 1
          TabOrder = 1
          OnChange = BorderWidthChange
        end
        object ComboPenStyle: TwwDBComboBox
          Left = 25
          Top = 2
          Width = 45
          Height = 22
          Hint = 'Border Style'
          HelpContext = 59055
          ShowButton = True
          Style = csOwnerDrawFixed
          MapList = False
          AllowClearKey = True
          Color = clWhite
          Ctl3D = True
          DropDownCount = 8
          DropDownWidth = 45
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 15
          Items.Strings = (
            'Solid'
            'Dash'
            'Dot'
            'Dash Dot'
            'Dash Dot Dot')
          ParentCtl3D = False
          ParentFont = False
          Sorted = False
          TabOrder = 0
          UnboundDataType = wwDefault
          OnChange = ComboPenStyleChange
          OnDrawItem = ComboPenStyleDrawItem
        end
      end
    end
    object Panel4: TDNMPanel
      Left = 197
      Top = 60
      Width = 681
      Height = 453
      HelpContext = 59056
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      Transparent = False
      object Splitter4: TSplitter
        Left = 595
        Top = 0
        Height = 438
        HelpContext = 59057
        Align = alRight
        ExplicitHeight = 453
      end
      object lblNote: TLabel
        Left = 0
        Top = 438
        Width = 681
        Height = 15
        HelpContext = 59063
        Align = alBottom
        Alignment = taCenter
        Caption = 'lblNote'
        Visible = False
        ExplicitWidth = 39
      end
      object ScrollBox1: TScrollBox
        Left = 598
        Top = 0
        Width = 83
        Height = 438
        HelpContext = 59058
        HorzScrollBar.Smooth = True
        HorzScrollBar.Visible = False
        VertScrollBar.Smooth = True
        VertScrollBar.Tracking = True
        Align = alRight
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object ChartGalleryPanel1: TChartGalleryPanel
          Left = 0
          Top = -2
          Width = 66
          Height = 901
          HelpContext = 59059
          NumRows = 12
          NumCols = 1
          OnChangeChart = ChartGalleryPanel1ChangeChart
          OnSubSelected = ChartGalleryPanel1ChangeChart
          BevelOuter = bvNone
          ParentColor = True
          ParentShowHint = False
          PopupMenu = PopupMenuGallery
          ShowHint = True
          TabOrder = 0
          TabStop = True
        end
      end
      object ScrollBox2: TScrollBox
        Left = 0
        Top = 0
        Width = 595
        Height = 438
        HelpContext = 59060
        HorzScrollBar.Tracking = True
        VertScrollBar.Tracking = True
        Align = alClient
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object DBChart1: TDBChart
          Left = 0
          Top = 0
          Width = 595
          Height = 438
          HelpContext = 59061
          AllowPanning = pmNone
          BackWall.Brush.Gradient.EndColor = clGray
          BackWall.Brush.Gradient.Visible = True
          BackWall.Size = 6
          BottomWall.Size = 6
          Gradient.EndColor = clGray
          LeftWall.Size = 6
          RightWall.Size = 6
          Title.Text.Strings = (
            'Chart1')
          CustomAxes = <
            item
              Horizontal = False
              OtherSide = False
            end>
          View3DOptions.Perspective = 50
          Zoom.Allow = False
          Zoom.Brush.Style = bsSolid
          Zoom.Pen.Color = clGray
          OnAfterDraw = DBChart1AfterDraw
          Align = alClient
          BevelOuter = bvNone
          PopupMenu = PopupMenuPanel
          TabOrder = 0
          OnDblClick = DBChart1DblClick
          OnMouseMove = DBChart1MouseMove
          PrintMargins = (
            15
            31
            15
            31)
        end
      end
    end
  end
  object ImageListSeries: TImageList
    Left = 39
    Top = 396
    Bitmap = {
      494C010109001000180010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF0000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      00000000FF000000FF00000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      00000000FF000000FF00000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000008000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000800000008000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600A4A0A000F0CA
      A600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0CAA6000000
      0000000000000000000000000000F0CAA600F0CAA600A4A0A000F0CAA6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0CAA6000000
      00000000000000000000F0CAA600F0CAA600A4A0A000F0CAA600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0CAA6000000
      000000000000F0CAA600F0CAA600A4A0A000F0CAA60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0CAA6000000
      0000F0CAA600F0CAA600A4A0A000F0CAA6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F7F7F0000FFFF007F7F
      7F000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0CAA600F0CA
      A600F0CAA600A4A0A000F0CAA6000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0CAA600F0CA
      A600A4A0A000F0CAA600000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000000000000000000000007F7F7F0000FFFF007F7F
      7F000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0CAA600A4A0
      A000F0CAA6000000000000000000000000000000000000000000000000000000
      000000FFFF00A4A0A00000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A4A0A000F0CA
      A600000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0CAA6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00A4A0A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000FFFFFF0000FFFF0000000000808080000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000FFFFFF0000FFFF0000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000C0C0
      C00000000000FFFFFF000000000080808000808080000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000C0C0
      C00000000000FFFFFF0000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00C0C0C0000000000000000000808080000000800000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00C0C0C0000000000000000000808080000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      000000000000000000000000000080808000000080000000800000FFFF00FFFF
      FF0000FFFF00FFFFFF00808080000000800000FFFF00FFFFFF00000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF008080
      800000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00000000008080800080808000000080008080800000FF
      FF00FFFFFF00808080000000800080808000FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000808080000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080000080800000808000008080000080800000000000000000
      0000000000000000000000000000000000008080800000FFFF0000FFFF008080
      8000FFFFFF0000FFFF008080800000FFFF00FFFFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000808080000000000000008000000080008080
      800000FFFF000000800000008000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000808080000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808000008080000080800000808000008080000080800000808000000000
      0000000000000000000000000000000000000000000080808000FFFFFF008080
      800000FFFF008080800000FFFF00FFFFFF0000FFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000808080000000000080808000000080000000
      80000000800000008000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000808080000000000000000000000000000000
      0000808000008080000080800000808000008080000080800000808000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      000000000000000000000000000000000000808080008080800080808000FFFF
      FF0080808000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000808080000000000080808000000080000000
      800000008000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000808080000000000000000000000000000000
      0000000000008080000080800000808000008080000080800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000FFFF008080800000FF
      FF00FFFFFF008080800080808000808080008080800000000000000000000000
      0000000000000000000000000000000000008080800000008000000080000000
      8000000080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      000000000000000000000000000000000000000000008080800000FFFF008080
      800000FFFF008080800000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000008000808080000000
      0000000080000000800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000000000000000000000000
      0000000000000000000000000000000000008080800000FFFF00000000008080
      8000FFFFFF00000000008080800000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000008080
      800000FFFF000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFC8000000000000
      FFB8000000000000CFBF000000000000CFBC000000000000FFBC000000000000
      DFBF000000000000CF7C000000000000E6FC000000000000F37F000000000000
      33BC00000000000033BC00000000000087BF000000000000FFB8000000000000
      FFC8000000000000FFFF0000000000000000FFFFFFFFFFFFFFFFFFFFF83F8EAD
      8001F183E7CF8DB58003FBC7DFF7FFFF8007F9C7B01B8C5F800FF807B83B8DD5
      881FFD8F7C7D8FDB801FFC8F7E8DFFFF804FFC8F41058CD580C7FE1F41058DB5
      81C3FE1F41058ED783C1FE1F818BFFFF87E5FF3F81FB8E978FF0FF7FDFF78DB5
      9FF0FFFFE7CF8C97FFF8FFFFF83FFFFFFFFFFFFFFFFFFFFFC000C000FFFFFFFF
      80008000FFFFFFFF80008000FFFFFFFF80000000F83FFEFF80000000F83FFC7F
      80000000F83FF83F00000000F83FF01F00008000C007E00F80008000E00FC007
      00008000F01FF83F00010001F83FF83F81FF11FFFC7FF83F24FFF8FFFEFFF83F
      66FFFC7FFFFFFFFFE7FFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageList3: TImageList
    Left = 610
    Top = 290
    Bitmap = {
      494C010121003000180010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000009000000001002000000000000090
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
      0000000000007B7B7B0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00848484007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00848484007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484007B7B
      7B00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00848484000000
      00000000000000000000000000000000000000000000848484007B7B7B008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00848484000000
      0000000000000000000000000000000000007B7B7B00848484007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00848484000000
      00000000000000000000000000007B7B7B00848484007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00848484000000
      000000000000000000007B7B7B00848484007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00848484000000
      000000000000848484007B7B7B00848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00848484000000
      00007B7B7B00848484007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00848484007B7B
      7B00848484007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00848484007B7B
      7B00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000848484007B7B7B008484
      84007B7B7B00848484007B7B7B00848484007B7B7B00848484007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00848484007B7B
      7B00848484007B7B7B00848484007B7B7B00848484007B7B7B00848484000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000FF00000084000000FF000000000000000000
      000000000000000000000000000000000000000000007B7B7B00FF00FF000000
      0000FF00FF0000000000FF00FF0000000000FF00FF0000000000FF00FF000000
      0000FF00FF0000000000FF00FF00000000000000000000000000000000000000
      000000000000C6C6C60000000000C6C6C600C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000FF000000840000008400000084000000FF00000084000000840000008400
      000000000000000000000000000000000000000000007B7B7B0000000000FF00
      FF00000000000000000000000000FF00FF0000000000FF00FF0000000000FF00
      FF0000000000FF00FF0000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000000000000000000084000000FF00
      0000840000000084840000848400840000008400000084000000840000008400
      000084000000000000000000000000000000000000007B7B7B00FF00FF000000
      000000000000000000000000000000000000FF00FF0000000000FF00FF000000
      0000FF00FF0000000000FF00FF0000000000000000000000000000000000FFFF
      0000000000000000000000000000C6C6C60000000000C6C6C60000000000FFFF
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000084000000FF0000008400
      0000FF000000008484000084840084000000FF00000084000000FF0000008400
      000000848400008484000000000000000000000000007B7B7B0000000000FF00
      FF0000000000FF00FF00000000000000000000000000FF00FF0000000000FF00
      FF0000000000FF00FF0000000000000000000000000000000000000000000000
      0000FFFF00000000000000000000000000000000000000000000FFFF00000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000084000000FF000000FF00
      0000FF0000000084840000848400008484008400000084000000840000008400
      000000848400008484000000000000000000000000007B7B7B00FF00FF000000
      0000FF00FF0000000000FF00FF00000000000000000000000000FF00FF000000
      0000FF00FF0000000000FF00FF00000000000000000000FFFF0000FFFF000000
      000000000000FFFF0000000000000000000000000000FFFF0000000000000000
      000000FFFF0000FFFF000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF00000000000000FF000000FF000000FF000000FF00
      0000FF000000008484000084840000848400FF000000FF000000FF0000008400
      0000FF000000840000008400000000000000000000007B7B7B0000000000FF00
      FF00000000000000000000000000FF00FF0000000000FF00FF0000000000FF00
      FF0000000000FF00FF0000000000000000000000000000FF000000FF000000FF
      FF0000FFFF0000000000C6C6C600C6C6C600C6C6C6000000000000FFFF0000FF
      FF0000FF000000FF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00000084000000FF000000FF0000000084
      840000848400008484000084840000848400FF000000FF000000FF0000008400
      00008400000084000000FF00000000000000000000007B7B7B00FF00FF000000
      000000000000000000000000000000000000FF00FF0000000000FF00FF000000
      0000FF00FF0000000000FF00FF000000000000000000FFFF0000FFFF000000FF
      000000FF000000000000C6C6C60000000000C6C6C6000000000000FF000000FF
      0000FFFF0000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000084000000008484000084
      840000848400008484000084840000848400FF00000000848400FF0000008400
      0000FF000000FF000000FF00000000000000000000007B7B7B0000000000FF00
      FF0000000000FF00FF00000000000000000000000000FF00FF0000000000FF00
      FF0000000000FF00FF0000000000000000000000000000FF000000FF000000FF
      FF0000FFFF0000000000C6C6C600C6C6C600C6C6C6000000000000FFFF0000FF
      FF0000FF000000FF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000FF000000FF0000000084
      840000848400008484000084840000848400008484000084840000848400FF00
      000084000000FF0000008400000000000000000000007B7B7B00FF00FF000000
      0000FF00FF0000000000FF00FF00000000000000000000000000FF00FF000000
      0000FF00FF0000000000FF00FF00000000000000000000FFFF0000FFFF000000
      000000000000FFFF0000000000000000000000000000FFFF00000000000000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF0000000084
      840000848400FF000000FF00000084000000008484000084840000848400FF00
      0000FF00000084000000FF00000000000000000000007B7B7B0000000000FF00
      FF0000000000FF00FF0000000000FF00FF0000000000FF00FF0000000000FF00
      FF0000000000FF00FF0000000000000000000000000000000000000000000000
      0000FFFF00000000000000000000000000000000000000000000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000848400008484000084840000848400008484000084
      840084000000FF0000000000000000000000000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      000000000000C6C6C60000000000C6C6C600000000000000000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FF0000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400FF000000FF0000000000000000000000000000007B7B7B00FFFF0000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00FF00FF000000FF00FF00000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      84000084840000848400FF000000FF00000000848400FF000000008484000084
      8400FF000000000000000000000000000000000000007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000C6C6C60000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000848400FF000000FF00000084000000FF00000084000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000084000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C60000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000C6C6C6000000000000000000C6C6
      C600000000000000000084008400000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000C6C6C6000000000000000000C6C6C6000000
      0000C6C6C6000000000084008400000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000848484007B7B7B00848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C6000000000000000000C6C6C60000000000C6C6
      C60000000000C6C6C60084008400000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60000000000C6C6C6000000
      0000C6C6C6000000000084008400000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000848484007B7B7B00848484007B7B7B00848484007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000008400000084000000840000008400000084000000840000FFFF000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000848484007B7B
      7B00848484000000000000000000000000000000000000000000000000000000
      00000000FF00FF00000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000FF00000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B0000FFFF007B7B7B0000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000008400FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000084
      00007B7B7B00000000000000000000000000000000000000FF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000008400FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000007B7B
      7B0000FFFF007B7B7B0000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000FF0084848400000000000000000000000000000000000000
      840000008400FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF0000008484840000FF
      FF007B7B7B0000FFFF008484840000000000008400007B7B7B00000000000084
      00007B7B7B000000000000000000000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000FFFF007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000840000008400000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF008484
      8400FF0000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00000000000000000000000000000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00000000000000000000000000000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00000000000000000000000000000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00C6C6C600C6C6C6007B7B7B007B7B7B007B7B7B00C6C6C6007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00C6C6C600C6C6C6007B7B7B007B7B7B007B7B7B00C6C6C6007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00C6C6C600C6C6C6007B7B7B007B7B7B007B7B7B00C6C6C6007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B0000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6007B7B7B007B7B7B00C6C6C6000000
      00007B7B7B00000000000000000000000000000000007B7B7B0000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6007B7B7B007B7B7B00C6C6C6000000
      00007B7B7B00000000000000000000000000000000007B7B7B0000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6007B7B7B007B7B7B00C6C6C6000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6007B7B7B00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000C6C6C6007B7B7B00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6007B7B7B00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600E7E7
      E700C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600E7E7
      E700000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600E7E7
      E700000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B0000000000E7E7
      E700E7E7E700C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      00007B7B7B00000000000000000000000000000000007B7B7B0000000000E7E7
      E700E7E7E700C6C6C6000000000000000000C6C6C600C6C6C600C6C6C6000000
      00007B7B7B00000000000000000000000000000000007B7B7B0000000000E7E7
      E700E7E7E700C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00E7E7E700E7E7E700C6C6C600C6C6C600C6C6C600C6C6C6007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00E7E7E700E7E7E7000000000000000000C6C6C600C6C6C6007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00E7E7E700E7E7E700C6C6C600C6C6C600C6C6C600C6C6C6007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00000000000000000000000000000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00000000000000000000000000000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00000000000000000000000000000000007B7B7B00000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000007B7B7B0000000000000000000000
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
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B008400000000000000000000000000000000000000000000007B7B7B008400
      0000840000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000084000000000000000000000000000000000000007B7B7B008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B008400000000000000000000000000000000000000840000008400
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084000000000000000000000084000000840000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000848484008400000084000000840000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400840000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000000000000000000000000
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
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000084000000F7F7F700F7F7F700F7F7F700E7E7E700F7F7
      F700F7F7F700F7F7F700E7E7E700840000000000000000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000F7F7F700F7F7F700E7E7E700F7F7F700F7F7
      F700F7F7F700E7E7E7008400000000000000000000007B7B7B00008484007B7B
      7B00008484007B7B7B0084000000F7F7F7008400000084000000840000008400
      00008400000084000000F7F7F700840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000F7F7F7000000000000000000000000000000
      000000000000F7F7F700840000000000000000000000008484007B7B7B000084
      84007B7B7B000084840084000000F7F7F700F7F7F700E7E7E700F7F7F700F7F7
      F700F7F7F700E7E7E700F7F7F70084000000000000000000000000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000000000000084000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000F7F7F700F7F7F700F7F7F700E7E7E700F7F7
      F700F7F7F700F7F7F7008400000000000000000000007B7B7B00008484007B7B
      7B00008484007B7B7B0084000000F7F7F700840000008400000084000000F7F7
      F70084000000840000008400000084000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000840000008400
      00000000000000000000000000000000000000000000F7F7F700F7F7F700E7E7
      E700F7F7F700F7F7F70084000000F7F7F7000000000000000000000000000000
      000000000000F7F7F700840000000000000000000000008484007B7B7B000084
      84007B7B7B000084840084000000F7F7F700E7E7E700F7F7F700F7F7F700E7E7
      E700840000000000000084000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000000000000084000000000000000000
      00000000000000000000000000000000000000000000F7F7F700000000000000
      0000000000000000000084000000F7F7F700F7F7F700E7E7E700F7F7F700F7F7
      F700E7E7E700F7F7F70084000000000000000000000084848400008484007B7B
      7B00008484007B7B7B0084000000F7F7F700F7F7F700E7E7E700F7F7F700F7F7
      F700840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700F7F7F700F7F7
      F700E7E7E700F7F7F70084000000F7F7F7000000000000000000F7F7F7008400
      00008400000084000000840000000000000000000000008484007B7B7B000084
      84007B7B7B000084840084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700000000000000
      0000000000000000000084000000F7F7F700E7E7E700F7F7F700F7F7F7008400
      000000000000840000000000000000000000000000007B7B7B00008484007B7B
      7B00008484007B7B7B00008484007B7B7B00008484007B7B7B00008484007B7B
      7B00008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700F7F7F700E7E7
      E700F7F7F700F7F7F70084000000F7F7F700F7F7F700E7E7E700F7F7F7008400
      00008400000000000000000000000000000000000000008484007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000008484
      84007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700000000000000
      0000F7F7F7000000000084000000840000008400000084000000840000008400
      000000000000000000000000000000000000000000007B7B7B00848484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000007B7B
      7B00008484000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700E7E7E700F7F7
      F700F7F7F7000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000008484007B7B7B000084
      84000000000000FFFF00000000000000000000FFFF0000000000848484000084
      84007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700F7F7F700E7E7
      E700F7F7F7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084008400840084007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700F7F7F700F7F7
      F700E7E7E700F7F7F700F7F7F700F7F7F700E7E7E700F7F7F700F7F7F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084008400840084000000000000000000C6C6C6007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484007B7B7B00848484007B7B7B00848484007B7B7B000000000000FF
      FF00000000008484840000000000000000000000000000000000000000000000
      0000F7F7F700E7E7E700F7F7F7000000000000FFFF0000FFFF0000000000F7F7
      F700F7F7F700F7F7F700000000000000000000000000F7F7F700E7E7E700F7F7
      F700F7F7F700F7F7F700E7E7E700F7F7F7000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000008400
      84008400840000000000000000000000000000000000C6C6C600C6C6C6007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000F7F7F700F7F7F700F7F7F7000000000000FFFF0000FFFF0000000000F7F7
      F700E7E7E700F7F7F700000000000000000000000000F7F7F700F7F7F700F7F7
      F700E7E7E700F7F7F700F7F7F700000000007B7B7B00C6C6C600C6C6C6007B7B
      7B00000000008484840000000000000000007B7B7B0084008400840084000000
      0000000000000000000000000000840084008400840000000000C6C6C600C6C6
      C6007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      0000F7F7F700E7E7E700F7F7F7000000000000FFFF0000FFFF0000000000F7F7
      F700F7F7F700F7F7F700000000000000000000000000F7F7F700E7E7E700F7F7
      F700F7F7F700F7F7F700000000007B7B7B00C6C6C600C6C6C600FFFF00007B7B
      7B007B7B7B000000000000000000000000008484840084008400000000000000
      000000000000840084008400840084008400840084008400840000000000C6C6
      C600C6C6C6007B7B7B0000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000008400000084000000000000000000
      000000FFFF000000000000000000848484000000000000000000000000000000
      0000F7F7F700F7F7F700F7F7F7000000000000FFFF0000FFFF0000000000F7F7
      F700E7E7E700F7F7F700000000000000000000000000F7F7F700F7F7F700F7F7
      F700E7E7E700F7F7F70000000000C6C6C600C6C6C600C6C6C600C6C6C6007B7B
      7B00C6C6C6000000000000000000000000007B7B7B0000000000000000008400
      840084008400840084000084840000FFFF008400840084008400840084000000
      0000C6C6C600C6C6C6007B7B7B00000000000000000000000000000000000000
      0000000000000000000000FFFF0000000000000000000000000000FFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      0000F7F7F700E7E7E700F7F7F70000000000000000000000000000000000F7F7
      F700F7F7F700E7E7E700000000000000000000000000F7F7F700E7E7E700F7F7
      F700F7F7F700F7F7F70000000000C6C6C600FFFF0000C6C6C600C6C6C6007B7B
      7B00C6C6C6000000000000000000000000008484840084008400840084008400
      8400840084008400840084008400008484008400840084008400840084008400
      840000000000C6C6C60000000000000000000000000000000000000000000000
      000000FFFF00000000000000000000000000840000007B7B7B00000000000000
      000000FFFF000000000000000000848484000000000000000000000000000000
      0000F7F7F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7F700E7E7E700F7F7
      F700F7F7F700F7F7F700000000000000000000000000F7F7F700F7F7F700F7F7
      F700E7E7E700F7F7F7000000000084848400FFFF0000FFFF0000C6C6C6007B7B
      7B007B7B7B000000000000000000000000000000000084008400000000008400
      84008400840084008400840084008400840000FFFF0000FFFF00840084008400
      8400840084000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000008484840084000000C6C6C6000000
      00000000000000000000000000007B7B7B0000000000000000000000000000FF
      FF0000000000F7F7F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7F700E7E7
      E700F7F7F7000000000000FFFF000000000000000000F7F7F700E7E7E700F7F7
      F700F7F7F700E7E7E700F7F7F7000000000084848400C6C6C600C6C6C6007B7B
      7B00000000000000000000000000000000000000000000000000840084000000
      000084008400840084008400840084008400840084000084840000FFFF0000FF
      FF00840084008400840000000000000000000000000000000000000000000000
      000000FFFF0000000000000000000000000000FFFF007B7B7B00840000007B7B
      7B0000FFFF000000000000000000848484000000000000000000000000000000
      000000FFFF0000000000F7F7F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7
      F7000000000000FFFF00000000000000000000000000F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700E7E7E700F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      840000000000840084008400840084008400008484008400840000FFFF0000FF
      FF00840084008400840084008400000000000000000000000000000000000000
      00000000000000000000840000007B7B7B000000000000000000840000008400
      00000000000000000000000000007B7B7B000000000000000000000000000000
      00000000000000FFFF0000000000F7F7F700F7F7F700E7E7E700F7F7F7000000
      000000FFFF0000000000000000000000000000000000F7F7F700E7E7E700F7F7
      F700E7E7E700F7F7F700F7F7F700F7F7F700F7F7F700E7E7E700F7F7F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400840000000000840084008400840000FFFF0000FFFF0000FFFF008400
      8400840084008400840000000000000000000000000000000000000000000000
      000000FFFF0000000000840000008400000000FFFF00C6C6C600840000008400
      000000FFFF000000000000000000848484000000000000000000000000000000
      0000000000000000000000FFFF0000000000F7F7F700F7F7F7000000000000FF
      FF000000000000000000000000000000000000000000F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700E7E7E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400840000000000840084008400840084008400840084008400
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60084000000840000008400000084000000C6C6
      C6000000000000000000000000007B7B7B000000000000000000000000000000
      000000000000000000000000000000FFFF00000000000000000000FFFF000000
      00000000840000000000000000000000000000000000F7F7F700E7E7E700F7F7
      F700F7F7F700E7E7E700F7F7F700F7F7F70000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084008400000000008400840084008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000000000000000000000000000FFFF0000000000000000000000
      000000FFFF000000000000000000848484000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF00000000000000
      00000000840000000000000000000000000000000000F7F7F700F7F7F700E7E7
      E700F7F7F700F7F7F700F7F7F700E7E7E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840084008400840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000084840000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C600000000000000000000000000000000000000000000000000F7F7
      F700F7F7F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7F700E7E7E700F7F7
      F700000000000000000000000000000000000000000000FFFF00000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C6000000000000000000000000000000000000000000F7F7
      F700E7E7E700F7F7F700F7F7F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7
      F70000000000000000000000000000000000000000000000000000FFFF000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C6000000000000848400000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C60000000000000000000000000000000000000000000000000000000000F7F7
      F700F7F7F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7F700E7E7E700F7F7
      F700000000000000000000000000000000000000000000FFFF000000000000FF
      FF00000000000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000848400000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6007B7B7B007B7B7B0084848400C6C6C600C6C6
      C60000000000C6C6C6000000000000000000000000000000000000000000F7F7
      F700E7E7E700F7F7F700F7F7F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7
      F70000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C60000000000000000000000000000000000F7F7
      F700F7F7F700F7F7F700E7E7E700F7F7F700F7F7F700E7E7E700F7F7F700F7F7
      F700000000000000000000000000000000000000000000FFFF000000000000FF
      FF000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000084840000848400000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C60000000000000000000000000000000000F7F7
      F700E7E7E700F7F7F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7F700E7E7
      E70000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000FFFF000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000084840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C6000000000000000000000000000000000000000000F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700E7E7E700F7F7
      F700000000000000000000000000000000000000000000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000008484000000000000000000000000000000000000000000F7F7
      F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7F700E7E7E700F7F7F7000000
      0000C6C6C60000000000C6C6C60000000000000000000000000000000000F7F7
      F700E7E7E700F7F7F700E7E7E700F7F7F700E7E7E700F7F7F700F7F7F700F7F7
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000084840000000000000000000000000000000000000000000000
      0000F7F7F7000000000000000000000000000000000000000000F7F7F7000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000084840000000000000000000000000000000000000000000000
      0000F7F7F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7F700E7E7E700F7F7
      F70000000000000000000000000000000000000000000000000000000000F7F7
      F700E7E7E700F7F7F700F7F7F700E7E7E700F7F7F70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000F7F7F7000000000000000000000000000000000000000000F7F7
      F70000000000000000000000000000000000000000000000000000000000F7F7
      F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7F70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000F7F7F700F7F7F700E7E7E700F7F7F700F7F7F700F7F7F700E7E7
      E700F7F7F7000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000900000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFF9000000000000
      FFF1000000000000FFE3000000000000FFC70000000000009F8F000000000000
      9F1F0000000000009E3F0000000000009C7F00000000000098FF000000000000
      91FF00000000000083FF00000000000087FF000000000000801F000000000000
      801F000000000000FFFF000000000000FFFFFFFFFFFFFFFF8000F83FFE3FF83F
      9554E20FF89FE00FAAAADD17F54FC0079154AEABE3A78003A0AAB7DB8FD38003
      9454183157E90001AAAA00013BF40001915400017DFA0001A0AA0001BEFD0001
      94541821DF730001AAAAB7DBEF8F80038000AAEBF77F80038000DD77F8FFC007
      8000E68FFFFFE00FFFFFF83FFFFFF83FF01FFFFFC007FFFFF83FFE3FC007FFFF
      EC6FFC05C0070000FEFFF829C0077FFEBFFBF055C00778FEFFFFF0A9C0077FFE
      7FFDE151C007781EFFFFC605C0077FF07FFD8FFFC00747F0FFE39FFFC0077FF0
      07C1BFFFC007000007C1E79FC007FFFF07C1FDF9C007FFFF07E38127C007FFFF
      07EFF8FFC007FFFFFABFC3FFC007FFFFFFFFFFFCFFFCFFFCFFFFFFF8FFF8FFF8
      F801FFF1FFF1FFF1FFFFF023F023F0238001E007E007E007FFFFC00FC00FC00F
      F801800780078007FFFF8007800780078001800780078007FFFF800780078007
      F801800780078007FFFF8007800780078001C00FC00FC00FFFFFE01FE01FE01F
      FFFFF03FF03FF03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      E00FFFFF003FC00FFFFFF07FFFFFFFFFF83FE73F00030003F11FC01FFFFFFFFF
      F39FFE3F003FC00FF39FF87FFFFFFFFFF39FF0FF00030003F39FE3FFFFFFFFFF
      F39FE7FF003FC00FF39FE73FFFFFFFFFE10FF07F00030003FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFDFFBFFFFFFFFC3818FFFFFFFFFFFE7C387F7E01FE07FF3C7C7EFF18FF8FF
      F3C7E3CFF18FF8FFF80FF19FF18FFC7FF98FF83FF01FFC7FFC9FFC7FF18FFE3F
      FC1FF83FF18FFE3FFE3FF19FF18FFF1FFE3FC3CFE01FFE0FFF7F87E7FFFFFFFF
      FFFF8FFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF83E0F9FFFFFFFC00
      83E8F6CFFC01800083E8F6B7FC0100008080F6B7FC0100008020F8B700010000
      8020FE8F000100058020FE3F00010003C001FF7F00010003E0A3FE3F000B0003
      E083FEBF00070003F1C7FC9F000F0003F1D7FDDF02FF0003F1C7FDDF01FF8007
      FFFFFDDF03FFF87FFFFFFFFFFFFFFFFFFFFFFE3FFFF7FFFF000CF81FFFE7E001
      0008E18FF003E00100018607E031E00100031803DD5CE00100032001D734E001
      00030000DDDCE00100030001D734E0010003A001DD1CC0000007D001D704E001
      000FE800DCCCF003000FF400D404F803000FFA03DC0CFC03001FFD0FD774FE13
      003FFE3FDDDDFF33007FFFFFE003FFFFFFFFFFFFFFFFFFFFFFFF001FC001C007
      C007000F80018003C007000780010001C007400380010001C007200180010001
      C007500080010000C0072A9F80010000C007555F80018000C007201F8001C000
      C0078FF18001E001C007FFF98001E007C02FFF758001F007C01FFF8F8001F003
      C03FFFFF8001F803FFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object LocalMenu: TAdvPopupMenu
    Images = ImageListSeries
    OnPopup = LocalMenuPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 17
    Top = 111
    object AddItem: TMenuItem
      Caption = '&New...'
      HelpContext = 59064
      ImageIndex = 0
      ShortCut = 45
      OnClick = SBAddClick
    end
    object Change1: TMenuItem
      Caption = 'C&hange...'
      HelpContext = 59065
      ShortCut = 16456
      OnClick = Change1Click
    end
    object DeleteItem: TMenuItem
      Caption = '&Delete'
      HelpContext = 59066
      ImageIndex = 1
      ShortCut = 46
      OnClick = SBDeleteClick
    end
    object CloneItem: TMenuItem
      Caption = 'D&uplicate'
      HelpContext = 59067
      ShortCut = 16451
      OnClick = CloneItemClick
    end
    object Title1: TMenuItem
      Caption = '&Title...'
      HelpContext = 59068
      ShortCut = 16468
      OnClick = Title1Click
    end
    object MenuItem1: TMenuItem
      Caption = '-'
      HelpContext = 59069
    end
    object SelectAllItem: TMenuItem
      Caption = 'Select &all'
      HelpContext = 59070
      ShortCut = 16449
      OnClick = SelectAllItemClick
    end
    object MenuItem2: TMenuItem
      Caption = '&Edit...'
      HelpContext = 59071
      ImageIndex = 4
      ShortCut = 16453
      OnClick = SBEditClick
    end
    object MenuItem3: TMenuItem
      Caption = '-'
      HelpContext = 59072
    end
    object MoveUp1: TMenuItem
      Caption = 'Move &Up'
      HelpContext = 59073
      ImageIndex = 2
      OnClick = TBMoveUpClick
    end
    object MoveDown1: TMenuItem
      Caption = 'Move &Down'
      HelpContext = 59074
      ImageIndex = 3
      OnClick = TBMoveDownClick
    end
  end
  object PopupMenuToolbar: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 663
    Top = 14
    object AligntoTop1: TMenuItem
      Caption = 'Align to &Top'
      Checked = True
      HelpContext = 59075
      RadioItem = True
      OnClick = AligntoBottom1Click
    end
    object AligntoBottom1: TMenuItem
      Caption = 'Align to &Bottom'
      HelpContext = 59076
      RadioItem = True
      OnClick = AligntoBottom1Click
    end
  end
  object PopupMenuGallery: TAdvPopupMenu
    OnPopup = PopupMenuGalleryPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 769
    Top = 254
    object Borders1: TMenuItem
      Caption = 'Border'
      Checked = True
      HelpContext = 59077
      OnClick = Borders1Click
    end
    object Rightside1: TMenuItem
      Caption = '&Right side'
      Checked = True
      HelpContext = 59078
    end
    object ShowHints1: TMenuItem
      Caption = '&Show Hints'
      Checked = True
      HelpContext = 59079
      OnClick = ShowHints1Click
    end
    object Small1: TMenuItem
      Caption = 'Sm&all'
      Checked = True
      HelpContext = 59080
      OnClick = Small1Click
    end
    object Smooth1: TMenuItem
      Caption = 'S&mooth'
      HelpContext = 59081
    end
    object View3D1: TMenuItem
      Caption = 'View &3D'
      Checked = True
      HelpContext = 59082
      OnClick = View3D1Click
    end
  end
  object PopupLegend: TAdvPopupMenu
    Images = ImageListSeries
    OnPopup = PopupLegendPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 338
    Top = 89
    object Visible1: TMenuItem
      Caption = '&Visible'
      Checked = True
      HelpContext = 59083
    end
    object Checkboxes1: TMenuItem
      Caption = 'Chec&k-boxes'
      HelpContext = 59084
      OnClick = Checkboxes1Click
    end
    object Dividinglines1: TMenuItem
      Caption = '&Dividing lines'
      HelpContext = 59085
      OnClick = Dividinglines1Click
    end
    object Inverted1: TMenuItem
      Caption = '&Inverted'
      HelpContext = 59086
      OnClick = Inverted1Click
    end
    object UseSeriesColor1: TMenuItem
      Caption = 'S&eries Color'
      HelpContext = 59087
      OnClick = UseSeriesColor1Click
    end
    object N10: TMenuItem
      Caption = '-'
      HelpContext = 59088
    end
    object Position1: TMenuItem
      Caption = '&Position'
      HelpContext = 59089
      object Right1: TMenuItem
        Caption = '&Right'
        Checked = True
        HelpContext = 59090
        RadioItem = True
        OnClick = Bottom1Click
      end
      object Left1: TMenuItem
        Caption = 'Left'
        HelpContext = 59091
        RadioItem = True
        OnClick = Bottom1Click
      end
      object Top1: TMenuItem
        Caption = '&Top'
        HelpContext = 59092
        RadioItem = True
        OnClick = Bottom1Click
      end
      object Bottom1: TMenuItem
        Caption = '&Bottom'
        HelpContext = 59093
        RadioItem = True
        OnClick = Bottom1Click
      end
    end
    object Style1: TMenuItem
      Caption = '&Style'
      HelpContext = 59094
      object Seriesnames1: TMenuItem
        Caption = '&Series names'
        HelpContext = 59095
        RadioItem = True
        OnClick = Lastvalues1Click
      end
      object Values1: TMenuItem
        Caption = '&Values'
        Checked = True
        HelpContext = 59096
        RadioItem = True
        OnClick = Lastvalues1Click
      end
      object Lastvalues1: TMenuItem
        Caption = '&Last values'
        HelpContext = 59097
        RadioItem = True
        OnClick = Lastvalues1Click
      end
    end
    object Symbols1: TMenuItem
      Caption = 'Sy&mbols'
      HelpContext = 59098
      OnClick = Right2Click
      object Left2: TMenuItem
        Caption = '&Left'
        Checked = True
        HelpContext = 59099
        RadioItem = True
      end
      object Right2: TMenuItem
        Caption = '&Right'
        HelpContext = 59100
        RadioItem = True
        OnClick = Right2Click
      end
      object N12: TMenuItem
        Caption = '-'
        HelpContext = 59101
      end
      object Continous1: TMenuItem
        Caption = '&Continous'
        HelpContext = 59102
        OnClick = Continous1Click
      end
    end
    object N11: TMenuItem
      Caption = '-'
      HelpContext = 59103
    end
    object LegendBorder: TMenuItem
      Caption = '&Border...'
      HelpContext = 59104
      OnClick = LegendBorderClick
    end
    object Color4: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFFF01111111110FFFFF01111111110FFFFF01111111110FFFFF0111111111
        0FFFFF01111111110FFFFF01111111110FFFFF01111111B10FFFFF0111111111
        0FFFFF01111111110FFFFF011EEEEE110FFFFF011EEEEE110FFFFF011EEEEE11
        0FFFFF01111111110FFFFF01111111110FFFFF00000000000FFF}
      Caption = '&Color...'
      HelpContext = 59105
      OnClick = Color4Click
    end
    object LegendFont: TMenuItem
      Caption = '&Font...'
      HelpContext = 59106
      ImageIndex = 5
      OnClick = LegendFontClick
    end
    object LegendGradient: TMenuItem
      Caption = '&Gradient...'
      HelpContext = 59107
      OnClick = LegendGradientClick
    end
    object LegendTransparent: TMenuItem
      Caption = '&Transparent'
      HelpContext = 59108
      OnClick = LegendTransparentClick
    end
  end
  object PopupMenuTitle: TAdvPopupMenu
    Images = ImageListSeries
    OnPopup = PopupMenuTitlePopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 258
    Top = 89
    object Text1: TMenuItem
      Caption = '&Text...'
      HelpContext = 59109
      OnClick = Text1Click
    end
    object Alignment1: TMenuItem
      Caption = '&Alignment'
      HelpContext = 59110
      object TitleLeft: TMenuItem
        Caption = '&Left'
        HelpContext = 59111
        RadioItem = True
        OnClick = TitleRightClick
      end
      object TitleCenter: TMenuItem
        Caption = '&Center'
        Checked = True
        HelpContext = 59112
        RadioItem = True
        OnClick = TitleRightClick
      end
      object TitleRight: TMenuItem
        Caption = '&Right'
        HelpContext = 59113
        RadioItem = True
        OnClick = TitleRightClick
      end
      object N14: TMenuItem
        Caption = '-'
        HelpContext = 59114
      end
      object TitleAutosize: TMenuItem
        Caption = '&Auto Size'
        Checked = True
        HelpContext = 59115
        OnClick = TitleAutosizeClick
      end
    end
    object CustomPosition1: TMenuItem
      Caption = '&Custom Position'
      HelpContext = 59116
      OnClick = CustomPosition1Click
    end
    object N13: TMenuItem
      Caption = '-'
      HelpContext = 59117
    end
    object TitleBorder: TMenuItem
      Caption = '&Border...'
      HelpContext = 59118
      OnClick = TitleBorderClick
    end
    object Color1: TMenuItem
      Caption = '&Color...'
      HelpContext = 59119
      OnClick = Color1Click
    end
    object TitleFont: TMenuItem
      Caption = '&Font...'
      HelpContext = 59120
      ImageIndex = 5
      OnClick = TitleFontClick
    end
    object TitleGradient: TMenuItem
      Caption = '&Gradient...'
      HelpContext = 59121
      OnClick = TitleGradientClick
    end
    object TitleShadow: TMenuItem
      Caption = '&Shadow'
      Checked = True
      HelpContext = 59122
      OnClick = TitleShadowClick
    end
    object TitleTransparent: TMenuItem
      Caption = 'T&ransparent'
      Checked = True
      HelpContext = 59123
      OnClick = TitleTransparentClick
    end
    object TitleVisible: TMenuItem
      Caption = '&Visible'
      Checked = True
      HelpContext = 59124
      OnClick = TitleVisibleClick
    end
  end
  object PopupMenuPanel: TAdvPopupMenu
    OnPopup = PopupMenuPanelPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 426
    Top = 89
    object Edit2: TMenuItem
      Caption = '&Edit...'
      HelpContext = 59125
      OnClick = Edit2Click
    end
    object N22: TMenuItem
      Caption = '-'
      HelpContext = 59126
    end
    object PanelBackimage: TMenuItem
      Caption = 'Back &Image...'
      HelpContext = 59127
      OnClick = PanelBackimageClick
    end
    object Bevel1: TMenuItem
      Caption = 'Be&vel'
      HelpContext = 59128
      object Lower1: TMenuItem
        Caption = '&Lowered'
        HelpContext = 59129
        RadioItem = True
        OnClick = None1Click
      end
      object Raise1: TMenuItem
        Caption = '&Raised'
        HelpContext = 59130
        RadioItem = True
        OnClick = None1Click
      end
      object None1: TMenuItem
        Caption = '&None'
        HelpContext = 59131
        RadioItem = True
        OnClick = None1Click
      end
    end
    object PanelBorder: TMenuItem
      Caption = '&Border...'
      HelpContext = 59132
      OnClick = PanelBorderClick
    end
    object PanelColor: TMenuItem
      Caption = '&Color...'
      HelpContext = 59133
      OnClick = PanelColorClick
    end
    object GrayScale1: TMenuItem
      Caption = 'Color &mode'
      HelpContext = 59134
      object Colors1: TMenuItem
        Caption = '&Colors'
        Checked = True
        HelpContext = 59135
        RadioItem = True
        OnClick = Colors1Click
      end
      object GrayScale2: TMenuItem
        Caption = '&Gray Scale'
        HelpContext = 59136
        RadioItem = True
        OnClick = GrayScale2Click
      end
      object GrayScaleVisual1: TMenuItem
        Caption = 'Gray &Scale Visual'
        HelpContext = 59137
        RadioItem = True
        OnClick = GrayScaleVisual1Click
      end
      object InvertedGrayScale1: TMenuItem
        Caption = '&Inverted Gray Scale'
        HelpContext = 59138
        RadioItem = True
        OnClick = InvertedGrayScale1Click
      end
      object Monochrome1: TMenuItem
        Caption = '&Monochrome'
        HelpContext = 59139
        RadioItem = True
        OnClick = Monochrome1Click
      end
    end
    object Frame1: TMenuItem
      Caption = '&Frame...'
      HelpContext = 59140
      OnClick = Frame1Click
    end
    object PanelGradient: TMenuItem
      Caption = '&Gradient...'
      HelpContext = 59141
      OnClick = PanelGradientClick
    end
    object PanelView3D: TMenuItem
      Caption = 'View &3D'
      Checked = True
      HelpContext = 59142
      OnClick = PanelView3DClick
    end
    object N15: TMenuItem
      Caption = '-'
      HelpContext = 59143
    end
    object AutoSize1: TMenuItem
      Caption = '&Auto Size'
      Checked = True
      HelpContext = 59144
      OnClick = AutoSize1Click
    end
  end
  object PopupMenuAnn: TAdvPopupMenu
    Images = ImageListSeries
    OnPopup = PopupMenuAnnPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 250
    Top = 137
    object EditAnnotation: TMenuItem
      Caption = '&Text...'
      HelpContext = 59145
      OnClick = EditAnnotationClick
    end
    object Delete1: TMenuItem
      Caption = '&Delete'
      HelpContext = 59146
      OnClick = Delete1Click
    end
    object N17: TMenuItem
      Caption = '-'
      HelpContext = 59147
    end
    object Position2: TMenuItem
      Caption = '&Position'
      HelpContext = 59148
      object LeftTop1: TMenuItem
        Caption = '&Left Top'
        Checked = True
        HelpContext = 59149
        RadioItem = True
        OnClick = RightBottom1Click
      end
      object LeftBottom1: TMenuItem
        Caption = 'Left &Bottom'
        HelpContext = 59150
        RadioItem = True
        OnClick = RightBottom1Click
      end
      object RightTop1: TMenuItem
        Caption = '&Right Top'
        HelpContext = 59151
        RadioItem = True
        OnClick = RightBottom1Click
      end
      object RightBottom1: TMenuItem
        Caption = 'Right B&ottom'
        HelpContext = 59152
        RadioItem = True
        OnClick = RightBottom1Click
      end
      object N18: TMenuItem
        Caption = '-'
        HelpContext = 59153
      end
      object Custom1: TMenuItem
        Caption = '&Custom'
        HelpContext = 59154
        OnClick = Custom1Click
      end
    end
    object N19: TMenuItem
      Caption = '-'
      HelpContext = 59155
    end
    object AnnBorder: TMenuItem
      Caption = '&Border...'
      HelpContext = 59156
      OnClick = AnnBorderClick
    end
    object AnnColor: TMenuItem
      Caption = '&Color...'
      HelpContext = 59157
      OnClick = AnnColorClick
    end
    object AnnoFont: TMenuItem
      Caption = '&Font...'
      HelpContext = 59158
      ImageIndex = 5
      OnClick = AnnoFontClick
    end
    object AnnGradient: TMenuItem
      Caption = '&Gradient...'
      HelpContext = 59159
      OnClick = AnnGradientClick
    end
    object Shadow1: TMenuItem
      Caption = '&Shadow...'
      HelpContext = 59160
      OnClick = Shadow1Click
    end
    object Transparent1: TMenuItem
      Caption = '&Transparent'
      HelpContext = 59161
      OnClick = Transparent1Click
    end
  end
  object PopupMenuMarks: TAdvPopupMenu
    Images = ImageListSeries
    OnPopup = PopupMenuMarksPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 338
    Top = 137
    object Edit4: TMenuItem
      Caption = '&Edit...'
      HelpContext = 59162
      OnClick = Edit4Click
    end
    object N20: TMenuItem
      Caption = '-'
      HelpContext = 59163
    end
    object Arrow1: TMenuItem
      Caption = '&Arrow...'
      HelpContext = 59164
      OnClick = Arrow1Click
    end
    object MarksBorder: TMenuItem
      Caption = '&Border...'
      HelpContext = 59165
      OnClick = MarksBorderClick
    end
    object Color3: TMenuItem
      Caption = '&Color...'
      HelpContext = 59166
      OnClick = Color3Click
    end
    object MarksFont: TMenuItem
      Caption = '&Font...'
      HelpContext = 59167
      ImageIndex = 5
      OnClick = MarksFontClick
    end
    object MarksGradient: TMenuItem
      Caption = '&Gradient...'
      HelpContext = 59168
      OnClick = MarksGradientClick
    end
    object MarksStyle: TMenuItem
      Caption = '&Style'
      HelpContext = 59169
      object Value1: TMenuItem
        Caption = '&Value'
        HelpContext = 59170
        RadioItem = True
        OnClick = XY1Click
      end
      object Percent1: TMenuItem
        Caption = '&Percent'
        HelpContext = 59171
        RadioItem = True
        OnClick = XY1Click
      end
      object Label1: TMenuItem
        Caption = '&Label'
        Checked = True
        HelpContext = 59172
        RadioItem = True
        OnClick = XY1Click
      end
      object LabelPercent1: TMenuItem
        Caption = 'Label P&ercent'
        HelpContext = 59173
        RadioItem = True
        OnClick = XY1Click
      end
      object LabelValue1: TMenuItem
        Caption = 'Label V&alue'
        HelpContext = 59174
        RadioItem = True
        OnClick = XY1Click
      end
      object Legend2: TMenuItem
        Caption = 'Lege&nd'
        HelpContext = 59175
        RadioItem = True
        OnClick = XY1Click
      end
      object PercentTotal1: TMenuItem
        Caption = 'Percent &Total'
        HelpContext = 59176
        RadioItem = True
        OnClick = XY1Click
      end
      object LabelPercentTotal1: TMenuItem
        Caption = 'Label Percent T&otal'
        HelpContext = 59177
        RadioItem = True
        OnClick = XY1Click
      end
      object XValue1: TMenuItem
        Caption = '&X Value'
        HelpContext = 59178
        RadioItem = True
        OnClick = XY1Click
      end
      object XY1: TMenuItem
        Caption = 'X&Y'
        HelpContext = 59179
        RadioItem = True
        OnClick = XY1Click
      end
    end
    object Symbol1: TMenuItem
      Caption = 'S&ymbol...'
      HelpContext = 59180
      OnClick = Symbol1Click
    end
    object Transparent2: TMenuItem
      Caption = '&Transparent'
      HelpContext = 59181
      OnClick = Transparent2Click
    end
    object Visible3: TMenuItem
      Caption = '&Visible'
      Checked = True
      HelpContext = 59182
      OnClick = Visible3Click
    end
  end
  object PopupMenuAxis: TAdvPopupMenu
    OnPopup = PopupMenuAxisPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 200
    Top = 336
    object Edit5: TMenuItem
      Caption = '&Edit...'
      HelpContext = 59183
      OnClick = Edit5Click
    end
    object N21: TMenuItem
      Caption = '-'
      HelpContext = 59184
    end
    object Axisline1: TMenuItem
      Caption = '&Axis line...'
      HelpContext = 59185
      OnClick = Axisline1Click
    end
    object AxisFont: TMenuItem
      Caption = '&Font...'
      HelpContext = 59186
      OnClick = AxisFontClick
    end
    object LabelsFormat1: TMenuItem
      Caption = 'F&ormat...'
      HelpContext = 59187
      OnClick = LabelsFormat1Click
    end
    object Grid1: TMenuItem
      Caption = '&Grid...'
      HelpContext = 59188
      OnClick = Grid1Click
    end
    object Inverted2: TMenuItem
      Caption = '&Inverted'
      HelpContext = 59189
      OnClick = Inverted2Click
    end
    object Labels1: TMenuItem
      Caption = '&Labels'
      Checked = True
      HelpContext = 59190
      OnClick = Labels1Click
    end
    object AxisMinorGrid: TMenuItem
      Caption = '&Minor Grid...'
      HelpContext = 59191
      OnClick = AxisMinorGridClick
    end
    object Ticks1: TMenuItem
      Caption = '&Ticks...'
      HelpContext = 59192
      OnClick = Ticks1Click
    end
    object AxisVisible: TMenuItem
      Caption = '&Visible'
      HelpContext = 59193
      OnClick = AxisVisibleClick
    end
  end
  object PopupMenuSeries: TAdvPopupMenu
    OnPopup = PopupMenuSeriesPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 287
    Top = 336
    object Edit6: TMenuItem
      Caption = '&Edit...'
      HelpContext = 59194
      OnClick = SBEditClick
    end
    object N25: TMenuItem
      Caption = '-'
      HelpContext = 59195
    end
    object Color5: TMenuItem
      Caption = '&Color...'
      HelpContext = 59196
      OnClick = Color5Click
    end
    object Coloreach1: TMenuItem
      Caption = 'Color &each point'
      Checked = True
      HelpContext = 59197
      OnClick = Coloreach1Click
    end
    object ShowatLegend1: TMenuItem
      Caption = 'Show at &Legend'
      Checked = True
      HelpContext = 59198
      OnClick = ShowatLegend1Click
    end
    object ShowMarks1: TMenuItem
      Caption = 'Show &Marks'
      Checked = True
      HelpContext = 59199
      OnClick = ShowMarks1Click
    end
    object Title2: TMenuItem
      Caption = '&Title...'
      HelpContext = 59200
      OnClick = Title1Click
    end
    object Visible2: TMenuItem
      Caption = '&Visible'
      Checked = True
      HelpContext = 59201
      OnClick = Visible2Click
    end
    object SeriesPopupSep: TMenuItem
      Caption = '-'
      HelpContext = 59202
    end
  end
  object PopupLine: TAdvPopupMenu
    OnPopup = PopupLinePopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 512
    Top = 336
    object PopupLineBorder: TMenuItem
      Caption = '&Border...'
      HelpContext = 59203
      OnClick = PopupLineBorderClick
    end
    object PopupLineOutline: TMenuItem
      Caption = '&Outline...'
      HelpContext = 59204
      OnClick = PopupLineOutlineClick
    end
    object PopupLinePattern: TMenuItem
      Caption = '&Pattern...'
      HelpContext = 59205
      OnClick = PopupLinePatternClick
    end
    object PopupLineStairs: TMenuItem
      Caption = '&Stairs'
      HelpContext = 59206
      OnClick = PopupLineStairsClick
    end
    object PopupLineInverted: TMenuItem
      Caption = 'Stairs &Inverted'
      HelpContext = 59207
      OnClick = PopupLineInvertedClick
    end
  end
  object PopupMenuWall: TAdvPopupMenu
    OnPopup = PopupMenuWallPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 376
    Top = 336
    object Edit3: TMenuItem
      Caption = '&Edit...'
      HelpContext = 59208
      OnClick = Edit3Click
    end
    object N26: TMenuItem
      Caption = '-'
      HelpContext = 59209
    end
    object WallBorder: TMenuItem
      Caption = '&Border...'
      HelpContext = 59210
      OnClick = WallBorderClick
    end
    object WallColor: TMenuItem
      Caption = '&Color...'
      HelpContext = 59211
      OnClick = WallColorClick
    end
    object WallDark3D: TMenuItem
      Caption = '&Dark 3D'
      HelpContext = 59212
      OnClick = WallDark3DClick
    end
    object WallGradient: TMenuItem
      Caption = '&Gradient...'
      HelpContext = 59213
      OnClick = WallGradientClick
    end
    object WallTransparent: TMenuItem
      Caption = '&Transparent'
      HelpContext = 59214
      OnClick = WallTransparentClick
    end
    object WallVisible: TMenuItem
      Caption = '&Visible'
      HelpContext = 59215
      OnClick = WallVisibleClick
    end
  end
  object PopupBar: TAdvPopupMenu
    OnPopup = PopupBarPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 448
    Top = 336
    object BarBorder: TMenuItem
      Caption = '&Border...'
      HelpContext = 59216
      OnClick = PopupLineBorderClick
    end
    object BarGradient: TMenuItem
      Caption = '&Gradient...'
      HelpContext = 59217
      OnClick = BarGradientClick
    end
    object BarPattern: TMenuItem
      Caption = '&Pattern...'
      HelpContext = 59218
      OnClick = PopupLinePatternClick
    end
    object BarSideMargins: TMenuItem
      Caption = 'S&ide Margins'
      Checked = True
      HelpContext = 59219
      OnClick = BarSideMarginsClick
    end
    object BarStyleItem: TMenuItem
      Caption = '&Style'
      HelpContext = 59220
      object BarRectangle: TMenuItem
        Caption = '&Rectangle'
        Checked = True
        HelpContext = 59221
        RadioItem = True
        OnClick = BarEllipseClick
      end
      object BarPyramid: TMenuItem
        Caption = '&Pyramid'
        HelpContext = 59222
        RadioItem = True
        OnClick = BarEllipseClick
      end
      object BarInvertPyramid: TMenuItem
        Caption = '&Inverted Pyramid'
        HelpContext = 59223
        RadioItem = True
        OnClick = BarEllipseClick
      end
      object BarCyllinder: TMenuItem
        Caption = '&Cyllinder'
        HelpContext = 59224
        RadioItem = True
        OnClick = BarEllipseClick
      end
      object BarEllipse: TMenuItem
        Caption = '&Ellipse'
        HelpContext = 59225
        RadioItem = True
        OnClick = BarEllipseClick
      end
      object BarArrow: TMenuItem
        Caption = '&Arrow'
        HelpContext = 59226
        RadioItem = True
        OnClick = BarEllipseClick
      end
      object BarGradientStyle: TMenuItem
        Caption = '&Gradient'
        HelpContext = 59227
        RadioItem = True
        OnClick = BarEllipseClick
      end
      object BarCone: TMenuItem
        Caption = '&Cone'
        HelpContext = 59228
        RadioItem = True
        OnClick = BarEllipseClick
      end
    end
    object BarUseOrigin: TMenuItem
      Caption = '&Use Origin'
      Checked = True
      HelpContext = 59229
      OnClick = BarUseOriginClick
    end
    object BarWidthItem: TMenuItem
      Caption = '&Width...'
      HelpContext = 59230
      OnClick = BarWidthItemClick
    end
  end
  object PopupPie: TAdvPopupMenu
    OnPopup = PopupPiePopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 512
    Top = 400
    object PieBorder: TMenuItem
      Caption = '&Border...'
      HelpContext = 59231
      OnClick = PopupLineBorderClick
    end
    object PieCircled: TMenuItem
      Caption = '&Circled'
      HelpContext = 59232
      OnClick = PieCircledClick
    end
    object PieDark3D: TMenuItem
      Caption = '&Dark 3D'
      HelpContext = 59233
      OnClick = PieDark3DClick
    end
    object PiePatterns: TMenuItem
      Caption = '&Patterns'
      HelpContext = 59234
      OnClick = PiePatternsClick
    end
    object PieRotation: TMenuItem
      Caption = '&Rotation...'
      HelpContext = 59235
      OnClick = PieRotationClick
    end
  end
  object PopupFastLine: TAdvPopupMenu
    OnPopup = PopupFastLinePopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 448
    Top = 400
    object FastLineBorder: TMenuItem
      Caption = '&Border...'
      HelpContext = 59236
      OnClick = PopupLineBorderClick
    end
  end
  object PopupPoint: TAdvPopupMenu
    OnPopup = PopupPointPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 377
    Top = 399
    object PointBorder: TMenuItem
      Caption = '&Border...'
      HelpContext = 59237
      OnClick = PopupLineBorderClick
    end
    object PointDark: TMenuItem
      Caption = 'Dark &3D'
      HelpContext = 59238
      OnClick = PointDarkClick
    end
    object PointDraw3D: TMenuItem
      Caption = '&Draw 3D'
      HelpContext = 59239
      OnClick = PointDraw3DClick
    end
    object PointHeight: TMenuItem
      Caption = '&Height...'
      HelpContext = 59240
      OnClick = PointHeightClick
    end
    object PointStyleItem: TMenuItem
      Caption = '&Style'
      HelpContext = 59241
      object Rectangle1: TMenuItem
        Caption = '&Square'
        Checked = True
        HelpContext = 59242
        RadioItem = True
        OnClick = Smalldot1Click
      end
      object Circle1: TMenuItem
        Caption = '&Circle'
        HelpContext = 59243
        RadioItem = True
        OnClick = Smalldot1Click
      end
      object Triangle1: TMenuItem
        Caption = '&Triangle'
        HelpContext = 59244
        RadioItem = True
        OnClick = Smalldot1Click
      end
      object DownTriangle1: TMenuItem
        Caption = '&Down Triangle'
        HelpContext = 59245
        RadioItem = True
        OnClick = Smalldot1Click
      end
      object Cross1: TMenuItem
        Caption = 'C&ross'
        HelpContext = 59246
        RadioItem = True
        OnClick = Smalldot1Click
      end
      object DiagonalCross1: TMenuItem
        Caption = '&Diagonal Cross'
        HelpContext = 59247
        RadioItem = True
        OnClick = Smalldot1Click
      end
      object Star1: TMenuItem
        Caption = 'St&ar'
        HelpContext = 59248
        RadioItem = True
        OnClick = Smalldot1Click
      end
      object Diamond1: TMenuItem
        Caption = 'D&iamond'
        HelpContext = 59249
        RadioItem = True
        OnClick = Smalldot1Click
      end
      object Smalldot1: TMenuItem
        Caption = 'Small d&ot'
        HelpContext = 59250
        RadioItem = True
        OnClick = Smalldot1Click
      end
    end
    object PointWidth: TMenuItem
      Caption = '&Width...'
      HelpContext = 59251
      OnClick = PointWidthClick
    end
  end
  object PopupTabs: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 288
    Top = 400
    object LeftTab: TMenuItem
      Caption = '&Left'
      HelpContext = 59252
      RadioItem = True
      OnClick = BottomTabClick
    end
    object RightTab: TMenuItem
      Caption = '&Right'
      HelpContext = 59253
      RadioItem = True
      OnClick = BottomTabClick
    end
    object TopTab: TMenuItem
      Caption = '&Top'
      HelpContext = 59254
      RadioItem = True
      OnClick = BottomTabClick
    end
    object BottomTab: TMenuItem
      Caption = '&Bottom'
      Checked = True
      HelpContext = 59255
      RadioItem = True
      OnClick = BottomTabClick
    end
  end
  object PopupToolSeries: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 104
    Top = 176
    object TopToolBar: TMenuItem
      Caption = '&Top'
      Checked = True
      HelpContext = 59256
      RadioItem = True
      OnClick = Bottom2Click
    end
    object Bottom2: TMenuItem
      Caption = '&Bottom'
      HelpContext = 59257
      RadioItem = True
      OnClick = Bottom2Click
    end
  end
  object PopupMenuGrid: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 432
    Top = 140
    object Top2: TMenuItem
      Caption = '&Align to Top'
      Checked = True
      HelpContext = 59258
      OnClick = Top2Click
    end
    object N28: TMenuItem
      Caption = '-'
      HelpContext = 59259
    end
    object AlignGrid1: TMenuItem
      Caption = 'Align Grid'
      HelpContext = 59260
      object Top3: TMenuItem
        Caption = 'Top'
        HelpContext = 59261
        RadioItem = True
      end
      object Bottom3: TMenuItem
        Caption = 'Bottom'
        Checked = True
        HelpContext = 59262
        RadioItem = True
      end
      object Left3: TMenuItem
        Caption = 'Left'
        HelpContext = 59263
        RadioItem = True
      end
      object Right3: TMenuItem
        Caption = 'Right'
        HelpContext = 59264
        RadioItem = True
      end
    end
  end
  object ChartEditor1: TChartEditor
    Chart = DBChart1
    OnClose = ChartEditor1Close
    OnShow = ChartEditor1Show
    HideTabs = [cetPrintPreview]
    Options = [ceAdd, ceDelete, ceChange, ceClone, ceTitle, ceGroupAll, ceOrderSeries]
    RememberPosition = True
    TreeView = True
    GalleryHeight = 0
    GalleryWidth = 0
    Height = 0
    Width = 0
    OnChangeSeriesOrder = ChartListBox1ChangeOrder
    Left = 471
    Top = 230
  end
end
