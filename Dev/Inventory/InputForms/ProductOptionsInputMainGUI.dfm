inherited frmProductOptionsMain: TfrmProductOptionsMain
  Left = 551
  Top = 177
  Caption = 'Product Options Main'
  ClientHeight = 584
  ClientWidth = 1241
  ExplicitLeft = 8
  ExplicitTop = -173
  ExplicitWidth = 1247
  ExplicitHeight = 613
  DesignSize = (
    1241
    584)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 544
    Width = 1241
    ExplicitTop = 472
    ExplicitWidth = 1006
  end
  inherited shapehint: TShape
    Left = 15
    ExplicitLeft = 9
  end
  inherited shapehintextra1: TShape
    Left = 74
    ExplicitLeft = 57
  end
  object BasePanel: TDNMPanel [5]
    Left = 0
    Top = 45
    Width = 1241
    Height = 499
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object Panel1: TDNMPanel
      Left = 0
      Top = 0
      Width = 249
      Height = 499
      Align = alLeft
      BorderStyle = bsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Configure: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 9
        Width = 237
        Height = 18
        Margins.Top = 8
        Align = alTop
        Alignment = taCenter
        Caption = 'Configuration'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 97
      end
      object lbConfig: TListBox
        AlignWithMargins = True
        Left = 6
        Top = 33
        Width = 228
        Height = 458
        Margins.Left = 5
        Margins.Right = 10
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 17
        Items.Strings = (
          'Setup'
          'Created Options')
        ParentFont = False
        TabOrder = 0
        OnClick = lbConfigClick
      end
    end
    object OptionsListPanel: TDNMPanel
      Left = 276
      Top = 50
      Width = 853
      Height = 40
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object dbgProductGrid: TwwDBGrid
        AlignWithMargins = True
        Left = 10
        Top = 3
        Width = 836
        Height = 30
        Margins.Left = 10
        LineStyle = glsSingle
        Selected.Strings = (
          'PARTNAME'#9'30'#9'Part Name'
          'ProductPrintName'#9'47'#9'Print Name'
          'COST1'#9'10'#9'Cost'
          'PRICE1'#9'10'#9'Price')
        MemoAttributes = [mSizeable, mWordWrap, mGridShow]
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dsProducts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells, dgRowResize]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = True
        OnDblClick = dbgProductGridDblClick
        FooterColor = clWhite
        FooterCellColor = clWhite
        PaintOptions.BackgroundOptions = [coBlendFixedRow]
      end
    end
    object ProductDesignPanel: TDNMPanel
      Left = 210
      Top = 106
      Width = 1000
      Height = 300
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object GridPanel: TDNMPanel
        Left = 0
        Top = 0
        Width = 996
        Height = 296
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object LeftPanel: TDNMPanel
          Left = 1
          Top = 1
          Width = 352
          Height = 294
          Align = alLeft
          Caption = 'LeftPanel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object dbgProductHeader: TwwDBGrid
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 344
            Height = 286
            LineStyle = glsSingle
            Selected.Strings = (
              'OptionTemplateName'#9'17'#9'Name'#9'F'
              'OptionTemplateDesc'#9'25'#9'Description'#9'F')
            MemoAttributes = [mSizeable, mWordWrap, mGridShow]
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alClient
            DataSource = dsProductHeader
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = [dgAllowInsert]
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells, dgRowResize]
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = True
            FooterColor = clWhite
            FooterCellColor = clWhite
            PaintOptions.BackgroundOptions = [coBlendFixedRow]
          end
        end
        object RightPanel: TDNMPanel
          Left = 353
          Top = 1
          Width = 642
          Height = 294
          Align = alClient
          Caption = 'RightPanel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object dbgProductDetails: TwwDBGrid
            AlignWithMargins = True
            Left = 11
            Top = 4
            Width = 627
            Height = 252
            Margins.Left = 10
            LineStyle = glsSingle
            Selected.Strings = (
              'OptionName'#9'30'#9'Name'
              'OptionAbbreviation'#9'30'#9'Abbreviation'
              'Cost'#9'10'#9'Cost'
              'Price'#9'10'#9'Price')
            MemoAttributes = [mSizeable, mWordWrap, mGridShow]
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alClient
            DataSource = dsProductDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = [dgAllowInsert]
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells, dgRowResize]
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = True
            FooterColor = clWhite
            FooterCellColor = clWhite
            PaintOptions.BackgroundOptions = [coBlendFixedRow]
          end
          object Panel4: TDNMPanel
            Left = 1
            Top = 259
            Width = 640
            Height = 34
            Align = alBottom
            BevelOuter = bvNone
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            object Label1: TLabel
              AlignWithMargins = True
              Left = 10
              Top = 3
              Width = 90
              Height = 28
              Margins.Left = 10
              Align = alLeft
              Caption = 'Display Style'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitHeight = 18
            end
            object dbcListStyle: TComboBox
              AlignWithMargins = True
              Left = 108
              Top = 0
              Width = 101
              Height = 25
              Margins.Left = 5
              Margins.Top = 0
              Align = alLeft
              Style = csDropDownList
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Arial'
              Font.Style = []
              ItemIndex = 0
              ParentFont = False
              TabOrder = 0
              Text = 'Simple'
              OnChange = dbcListStyleChange
              Items.Strings = (
                'Simple'
                'List'
                '')
            end
            object DBCheckBox1: TDBCheckBox
              AlignWithMargins = True
              Left = 564
              Top = 3
              Width = 73
              Height = 28
              Align = alRight
              Caption = 'Active'
              DataField = 'Active'
              DataSource = dsProductHeader
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              ValueChecked = 'T'
              ValueUnchecked = 'F'
            end
          end
        end
      end
    end
  end
  object pnlFooter: TDNMPanel [6]
    Left = 0
    Top = 544
    Width = 1241
    Height = 40
    HelpContext = 366002
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      1241
      40)
    object btnOK: TDNMSpeedButton
      Left = 303
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 366003
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnOKClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 825
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 366004
      Anchors = [akTop, akRight]
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
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnEdit: TDNMSpeedButton
      Left = 496
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 366003
      Caption = 'Edit'
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
      ModalResult = 1
      ParentFont = False
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnEditClick
    end
    object btnNew: TDNMSpeedButton
      Left = 398
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 366003
      Caption = 'New'
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
      ModalResult = 1
      ParentFont = False
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnNewClick
    end
  end
  object pnlTitle: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 1241
    Height = 45
    HelpContext = 380015
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 1239
      Height = 43
      HelpContext = 380016
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
        Width = 1239
        Height = 43
        HelpContext = 380017
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Product Options - Design'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitTop = 4
        ExplicitWidth = 353
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 380
  end
  inherited MyConnection: TERPConnection
    Database = 'aus_sample_company'
    Server = 'localhost'
    Connected = True
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 227
    Top = 9
    object mnuCopyToClipboard: TMenuItem
      Caption = 'Copy To Clipboard'
      HelpContext = 380034
      OnClick = mnuCopyToClipboardClick
    end
    object mnuPasteFromClipboard: TMenuItem
      Caption = 'Paste From Clipboard'
      HelpContext = 380035
      OnClick = mnuPasteFromClipboardClick
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020048017C0310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object dsProductHeader: TDataSource
    DataSet = qryProductHeader
    Left = 636
    Top = 16
  end
  object dsProductDetails: TDataSource
    DataSet = qryProductDetails
    Left = 748
    Top = 16
  end
  object qryProductHeader: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblProductOptionHeader')
    AfterOpen = qryProductHeaderAfterOpen
    BeforePost = qryProductHeaderBeforePost
    AfterScroll = qryProductHeaderAfterScroll
    Options.LongStrings = False
    Left = 634
    Top = 48
    object qryProductHeaderOptionTemplateName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 17
      FieldName = 'OptionTemplateName'
      Origin = 'tblproductoptionheader.OptionTemplateName'
      Size = 100
    end
    object qryProductHeaderOptionTemplateDesc: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 25
      FieldName = 'OptionTemplateDesc'
      Origin = 'tblproductoptionheader.OptionTemplateDesc'
      Size = 255
    end
    object qryProductHeaderActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblproductoptionheader.Active'
      Visible = False
      Size = 1
    end
    object qryProductHeaderDisplayType: TWideStringField
      DisplayWidth = 1
      FieldName = 'DisplayType'
      Origin = 'tblproductoptionheader.DisplayType'
      Visible = False
      Size = 1
    end
    object qryProductHeaderid: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'id'
      Origin = 'tblproductoptionheader.id'
      Visible = False
    end
  end
  object qryProductDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblProductOptionDetails'
      'where id_header = :pIdHeader')
    BeforePost = qryProductDetailsBeforePost
    Options.LongStrings = False
    Left = 706
    Top = 56
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pIdHeader'
        ParamType = ptInput
        Value = 1
      end>
    object qryProductDetailsOptionName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 30
      FieldName = 'OptionName'
      Origin = 'tblproductoptiondetails.OptionName'
      OnChange = qryProductDetailsOptionNameChange
      Size = 100
    end
    object qryProductDetailsOptionAbbreviation: TWideStringField
      DisplayLabel = 'Abbreviation'
      DisplayWidth = 30
      FieldName = 'OptionAbbreviation'
      Origin = 'tblproductoptiondetails.OptionAbbreviation'
      Size = 25
    end
    object qryProductDetailsCost: TFloatField
      DisplayWidth = 10
      FieldName = 'Cost'
      Origin = 'tblproductoptiondetails.Cost'
      currency = True
    end
    object qryProductDetailsPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'Price'
      Origin = 'tblproductoptiondetails.Price'
      currency = True
    end
    object qryProductDetailsid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'tblproductoptiondetails.id'
      Visible = False
    end
    object qryProductDetailsid_header: TIntegerField
      FieldName = 'id_header'
      Origin = 'tblproductoptiondetails.id_header'
      Visible = False
    end
    object qryProductDetailsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblproductoptiondetails.Active'
      Visible = False
      Size = 1
    end
  end
  object qryGeneral: TERPQuery
    Connection = MyConnection
    Options.LongStrings = False
    Left = 794
    Top = 48
  end
  object dsProducts: TDataSource
    DataSet = qryProducts
    Left = 852
    Top = 24
  end
  object qryProducts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblParts p'
      'where p.HasProductOptions = "T"'
      
        'AND EXISTS (SELECT 1 FROM tblProductHeader WHERE trueerp_product' +
        '_id = p.PartsId)')
    Options.LongStrings = False
    Left = 850
    Top = 56
    object qryProductsPARTNAME: TWideStringField
      DisplayLabel = 'Part Name'
      DisplayWidth = 30
      FieldName = 'PARTNAME'
      Origin = 'p.PARTNAME'
      Size = 255
    end
    object qryProductsProductPrintName: TWideStringField
      DisplayLabel = 'Print Name'
      DisplayWidth = 47
      FieldName = 'ProductPrintName'
      Origin = 'p.ProductPrintName'
      Size = 255
    end
    object qryProductsCOST1: TFloatField
      DisplayLabel = 'Cost'
      DisplayWidth = 10
      FieldName = 'COST1'
      Origin = 'p.COST1'
      currency = True
    end
    object qryProductsPRICE1: TFloatField
      DisplayLabel = 'Price'
      DisplayWidth = 10
      FieldName = 'PRICE1'
      Origin = 'p.PRICE1'
      currency = True
    end
    object qryProductsPARTSDESCRIPTION: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 48
      FieldName = 'PARTSDESCRIPTION'
      Origin = 'p.PARTSDESCRIPTION'
      Visible = False
      Size = 255
    end
    object qryProductsPARTSID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PARTSID'
      Origin = 'p.PARTSID'
      Visible = False
    end
  end
end
