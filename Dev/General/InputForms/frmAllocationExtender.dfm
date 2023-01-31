inherited fmAllocationExt: TfmAllocationExt
  Left = 618
  Top = 273
  HelpContext = 627000
  BorderStyle = bsNone
  Caption = 'fmAllocationExt'
  ClientHeight = 357
  ClientWidth = 341
  KeyPreview = True
  ExplicitLeft = 618
  ExplicitTop = 273
  ExplicitWidth = 357
  ExplicitHeight = 396
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 357
    Width = 341
    HelpContext = 627002
    ExplicitTop = 357
    ExplicitWidth = 341
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 341
    Height = 24
    HelpContext = 627011
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      341
      24)
    object Bevel6: TBevel
      Left = 2
      Top = 3
      Width = 338
      Height = 20
      HelpContext = 627012
      Anchors = [akLeft, akTop, akRight]
      Shape = bsFrame
      Style = bsRaised
    end
    object lblSelect: TLabel
      Left = 3
      Top = 5
      Width = 335
      Height = 15
      HelpContext = 627001
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Select To Allocate'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      WordWrap = True
    end
  end
  object pnlDetails: TDNMPanel [5]
    Left = 0
    Top = 24
    Width = 341
    Height = 333
    HelpContext = 627003
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    Transparent = False
    object lblExtra: TLabel
      Left = 1
      Top = 254
      Width = 339
      Height = 15
      HelpContext = 627004
      Align = alBottom
      Alignment = taCenter
      Caption = 'extra details '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      WordWrap = True
      ExplicitWidth = 74
    end
    object grdmain: TwwDBGrid
      Left = 1
      Top = 1
      Width = 339
      Height = 253
      HelpContext = 627005
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnRowChanged = grdmainRowChanged
      FixedCols = 0
      ShowHorzScrollBar = False
      Align = alClient
      Ctl3D = False
      DataSource = dsmain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyOptions = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgFooter3DCells, dgRowResize]
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clPurple
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      LineColors.FixedColor = clSilver
      OnDblClick = grdmainDblClick
      OnKeyPress = grdmainKeyPress
      OnKeyUp = grdmainKeyUp
      FooterColor = clWhite
    end
    object pnlBottom: TDNMPanel
      Left = 1
      Top = 269
      Width = 339
      Height = 63
      HelpContext = 627006
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        339
        63)
      object lblNote: TLabel
        Left = 1
        Top = 1
        Width = 337
        Height = 15
        HelpContext = 627007
        Align = alTop
        Alignment = taCenter
        Caption = 'Click In The Grid To Search...ALT+DEL To Clear Search'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        ExplicitWidth = 299
      end
      object btnclose: TDNMSpeedButton
        Left = 9
        Top = 22
        Width = 87
        Height = 31
        HelpContext = 627008
        Anchors = [akBottom]
        Caption = '&Save'
        Default = True
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
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
      end
      object btncancel: TDNMSpeedButton
        Left = 235
        Top = 22
        Width = 87
        Height = 31
        HelpContext = 627009
        Anchors = [akBottom]
        Cancel = True
        Caption = '&Cancel'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
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
        TabOrder = 1
        AutoDisableParentOnclick = True
      end
      object btnViewStock: TDNMSpeedButton
        Left = 122
        Top = 22
        Width = 87
        Height = 31
        HelpContext = 627010
        Anchors = [akBottom]
        Caption = '&View Stock'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = btnViewStockClick
      end
    end
  end
  object qrymain: TERPQuery
    Filtered = True
    Filter = 'UOMQty <> 0 and UOMQty <> null'
    Left = 184
    Top = 32
  end
  object dsmain: TDataSource
    DataSet = qrymain
    Left = 288
    Top = 48
  end
end
