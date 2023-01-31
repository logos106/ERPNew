inherited fmProcAutoShedSelect: TfmProcAutoShedSelect
  Left = 384
  Top = 242
  HelpContext = 604000
  Caption = 'Items To Schedule'
  ClientHeight = 509
  ClientWidth = 996
  Position = poScreenCenter
  ExplicitLeft = 384
  ExplicitTop = 242
  ExplicitWidth = 1012
  ExplicitHeight = 548
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 465
    Width = 996
    ExplicitTop = 465
    ExplicitWidth = 996
    HelpContext = 604009
  end
  object lvItems: TAdvListView [3]
    Left = 0
    Top = 66
    Width = 996
    Height = 399
    HelpContext = 604004
    Align = alClient
    Checkboxes = True
    Columns = <
      item
        Caption = 'Ref'
        Width = 80
      end
      item
        Caption = 'Customer'
        Width = 150
      end
      item
        Caption = 'Product'
        Width = 150
      end
      item
        Caption = 'Ship'
        Width = 75
      end
      item
        Caption = 'Item'
        Width = 150
      end
      item
        Caption = 'Process'
        Width = 150
      end
      item
        Caption = 'col1'
        Width = 79
      end
      item
        Caption = 'col2'
        Width = 79
      end
      item
        Caption = 'Col3'
        Width = 79
      end>
    HoverTime = -1
    PopupMenu = PopupMenu
    TabOrder = 1
    ViewStyle = vsReport
    OnClick = lvItemsClick
    OnColumnClick = lvItemsColumnClick
    AutoHint = False
    ClipboardEnable = False
    ColumnSize.Save = False
    ColumnSize.Stretch = False
    ColumnSize.Storage = stInifile
    FilterTimeOut = 500
    PrintSettings.FooterSize = 0
    PrintSettings.HeaderSize = 0
    PrintSettings.Time = ppNone
    PrintSettings.Date = ppNone
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.PageNr = ppNone
    PrintSettings.Title = ppNone
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'MS Sans Serif'
    PrintSettings.Font.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'MS Sans Serif'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'MS Sans Serif'
    PrintSettings.FooterFont.Style = []
    PrintSettings.Borders = pbNoborder
    PrintSettings.BorderStyle = psSolid
    PrintSettings.Centered = False
    PrintSettings.RepeatHeaders = False
    PrintSettings.LeftSize = 0
    PrintSettings.RightSize = 0
    PrintSettings.ColumnSpacing = 0
    PrintSettings.RowSpacing = 0
    PrintSettings.Orientation = poPortrait
    PrintSettings.FixedWidth = 0
    PrintSettings.FixedHeight = 0
    PrintSettings.UseFixedHeight = False
    PrintSettings.UseFixedWidth = False
    PrintSettings.FitToPage = fpNever
    PrintSettings.PageNumSep = '/'
    HTMLHint = False
    HTMLSettings.Width = 100
    HeaderHotTrack = False
    HeaderDragDrop = False
    HeaderFlatStyle = False
    HeaderOwnerDraw = False
    HeaderHeight = 13
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    ProgressSettings.ColorFrom = clSilver
    ProgressSettings.FontColorFrom = clBlack
    ProgressSettings.ColorTo = clWhite
    ProgressSettings.FontColorTo = clGray
    SelectionRTFKeep = False
    ScrollHint = False
    SelectionColor = clHighlight
    SelectionTextColor = clHighlightText
    SizeWithForm = False
    SortDirection = sdAscending
    SortShow = False
    SortIndicator = siLeft
    StretchColumn = False
    SubImages = False
    SubItemEdit = False
    SubItemSelect = False
    VAlignment = vtaCenter
    ItemHeight = 13
    SaveHeader = False
    LoadHeader = False
    ReArrangeItems = False
    DetailView.Visible = False
    DetailView.Column = 0
    DetailView.Font.Charset = DEFAULT_CHARSET
    DetailView.Font.Color = clBlue
    DetailView.Font.Height = -11
    DetailView.Font.Name = 'MS Sans Serif'
    DetailView.Font.Style = []
    DetailView.Height = 16
    DetailView.Indent = 0
    DetailView.SplitLine = False
    OnColumnRClick = lvItemsColumnRClick
    Version = '1.6.5.1'
  end
  object pnlTop: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 996
    Height = 66
    HelpContext = 604005
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      996
      66)
    object pnlTitle: TDNMPanel
      Left = 145
      Top = 16
      Width = 706
      Height = 41
      HelpContext = 604006
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
        Width = 702
        Height = 37
        HelpContext = 604007
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
          Width = 702
          Height = 37
          HelpContext = 604008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Items To Schedule'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 484
        end
      end
    end
  end
  object pnlBottom: TDNMPanel [5]
    Left = 0
    Top = 465
    Width = 996
    Height = 44
    HelpContext = 604001
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      996
      44)
    object btnOk: TDNMSpeedButton
      Left = 340
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 604002
      Anchors = [akBottom]
      Caption = 'Ok'
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
      TabOrder = 2
      OnClick = btnOkClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 565
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 604003
      Anchors = [akBottom]
      Caption = 'Cancel'
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
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
    end
    object btnSelectAll: TDNMSpeedButton
      Left = 11
      Top = 8
      Width = 87
      Height = 27
      Action = actSelectAll
      Caption = 'Select All'
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
      HelpContext = 604010
    end
    object btnClearAll: TDNMSpeedButton
      Left = 107
      Top = 8
      Width = 87
      Height = 27
      Action = actClearAll
      Caption = 'Clear All'
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
      TabOrder = 1
      HelpContext = 604011
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 452
      Top = 8
      Width = 87
      Height = 27
      Caption = 'Filter'
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
      TabOrder = 4
      OnClick = DNMSpeedButton1Click
      HelpContext = 604012
    end
  end
  object PopupMenu: TPopupMenu
    HelpContext = 604009
    Left = 112
    Top = 16
    object SelectAll1: TMenuItem
      Action = actSelectAll
    end
    object ClearAll1: TMenuItem
      Action = actClearAll
    end
  end
  object ActionList: TActionList
    Left = 48
    Top = 32
    object actSelectAll: TAction
      Caption = 'Select All'
      OnExecute = actSelectAllExecute
      HelpContext = 604013
    end
    object actClearAll: TAction
      Caption = 'Clear All'
      OnExecute = actClearAllExecute
      HelpContext = 604014
    end
  end
  object mnucol1: TPopupMenu
    OnPopup = mnuCol3Popup
    Left = 128
    Top = 192
  end
  object mnucol2: TPopupMenu
    OnPopup = mnuCol3Popup
    Left = 176
    Top = 192
  end
  object mnuCol3: TPopupMenu
    OnPopup = mnuCol3Popup
    Left = 224
    Top = 192
  end
end
