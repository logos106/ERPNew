inherited fmBOMPlannerItemDetails: TfmBOMPlannerItemDetails
  Left = 1111
  Top = 180
  BorderStyle = bsSingle
  Caption = 'Schedule Details'
  ClientHeight = 527
  ClientWidth = 567
  Position = poMainFormCenter
  ExplicitLeft = 1111
  ExplicitTop = 180
  ExplicitWidth = 583
  ExplicitHeight = 566
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1424002
  inherited lblSkingroupMsg: TLabel
    Top = 477
    Width = 567
    HelpContext = 1424003
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 0
    Top = 477
    Width = 567
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = 160
    ExplicitTop = 200
    ExplicitWidth = 150
    DesignSize = (
      567
      50)
    HelpContext = 1424004
    object cmdCancel: TDNMSpeedButton
      Left = 238
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 1424005
      Anchors = [akBottom]
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
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = cmdCancelClick
      ExplicitLeft = 182
    end
  end
  object DNMPanel2: TDNMPanel [4]
    Left = 0
    Top = 50
    Width = 567
    Height = 427
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = -2
    ExplicitWidth = 189
    ExplicitHeight = 311
    HelpContext = 1424006
    object grdMain: TwwDBGrid
      Left = 1
      Top = 1
      Width = 565
      Height = 425
      Selected.Strings = (
        'Description'#9'30'#9'Description'
        'data'#9'44'#9'Details')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
      IniAttributes.SaveToRegistry = True
      IniAttributes.Delimiter = ';;'
      IniAttributes.CheckNewFields = True
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = False
      ShowVertScrollBar = False
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      DataSource = dsMain
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      LineColors.GroupingColor = clSilver
      OnCalcCellColors = grdMainCalcCellColors
      FooterCellColor = clWhite
      ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
      PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
      HelpContext = 1424007
      object btnGrid: TwwIButton
        Left = 0
        Top = 0
        Width = 13
        Height = 22
        AllowAllUp = True
        HelpContext = 1424008
      end
    end
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 567
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitLeft = 176
    ExplicitTop = 216
    ExplicitWidth = 150
    DesignSize = (
      567
      50)
    HelpContext = 1424009
    object pnlTitle: TDNMPanel
      Left = 149
      Top = 5
      Width = 270
      Height = 39
      HelpContext = 1424010
      Anchors = []
      
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 93
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 268
        Height = 37
        HelpContext = 1424011
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
          Width = 268
          Height = 37
          HelpContext = 1424012
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Schedule Details'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -1
          ExplicitWidth = 428
        end
      end
    end
  end
  object qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select 1 as Category, "" as Description, "" as data')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Active = True
    Left = 99
    Top = 200
    object qryMainDescription: TWideStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Origin = 'Description'
      Size = 65530
    end
    object qryMaindata: TWideStringField
      DisplayLabel = 'Details'
      DisplayWidth = 44
      FieldName = 'data'
      Origin = 'data'
      Size = 65530
    end
    object qryMainCategory: TLargeintField
      FieldName = 'Category'
      Origin = 'Category'
      Visible = False
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 102
    Top = 167
  end
  object MyConnection1: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 9
    Top = 384
  end
end
