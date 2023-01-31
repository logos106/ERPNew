inherited frmSelectBatchesGUI: TfrmSelectBatchesGUI
  Left = 355
  Top = 132
  HelpContext = 348000
  Caption = 'Select Sold Items from Batches'
  ClientHeight = 377
  ClientWidth = 619
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 348001
  end
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 619
    Height = 169
    HelpContext = 348002
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 148
      Top = 8
      Width = 313
      Height = 145
      HelpContext = 348003
      Shape = bsFrame
    end
    object lblDistributeNitems: TLabel
      Left = 275
      Top = 23
      Width = 3
      Height = 15
      HelpContext = 348004
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 174
      Top = 23
      Width = 61
      Height = 19
      HelpContext = 348005
      Caption = 'Product'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 233
      Top = 122
      Width = 53
      Height = 15
      HelpContext = 348006
      Caption = 'To Select'
      Transparent = True
    end
    object Label3: TLabel
      Left = 170
      Top = 55
      Width = 43
      Height = 19
      HelpContext = 348007
      Caption = 'Class'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edSelectNItems: TEdit
      Left = 171
      Top = 87
      Width = 257
      Height = 23
      HelpContext = 348008
      TabStop = False
      AutoSelect = False
      ParentColor = True
      ReadOnly = True
      TabOrder = 2
      Text = 'Select %1.1f Items from Batches available:'
    end
    object edUnallocated: TEdit
      Left = 302
      Top = 117
      Width = 65
      Height = 23
      HelpContext = 348009
      TabStop = False
      AutoSelect = False
      ReadOnly = True
      TabOrder = 3
      Text = 'edUnSelected'
    end
    object edClass: TEdit
      Left = 264
      Top = 52
      Width = 148
      Height = 23
      HelpContext = 348010
      TabStop = False
      AutoSelect = False
      ReadOnly = True
      TabOrder = 1
      Text = 'Class'
    end
    object edPartName: TEdit
      Left = 264
      Top = 20
      Width = 148
      Height = 27
      HelpContext = 348011
      TabStop = False
      AutoSelect = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'Product'
    end
  end
  object DNMPanel2: TDNMPanel [2]
    Left = 0
    Top = 169
    Width = 619
    Height = 208
    HelpContext = 348012
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object grdBatches: TwwDBGrid
      Left = 0
      Top = 0
      Width = 619
      Height = 157
      HelpContext = 348013
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alTop
      DataSource = dsBatches
      KeyOptions = []
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnFieldChanged = grdBatchesFieldChanged
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
    object cmdOK: TDNMSpeedButton
      Left = 169
      Top = 169
      Width = 87
      Height = 27
      HelpContext = 348014
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = cmdOKClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 353
      Top = 169
      Width = 87
      Height = 27
      HelpContext = 348015
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = cmdCancelClick
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 120
    Top = 176
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 576
  end
  object kbBatches: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 88
    Top = 224
  end
  object dsBatches: TDataSource
    DataSet = kbBatches
    Left = 32
    Top = 176
  end
end
