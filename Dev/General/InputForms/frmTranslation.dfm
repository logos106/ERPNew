inherited fmTranslation: TfmTranslation
  Caption = 'fmTranslation'
  PixelsPerInch = 96
  TextHeight = 15
  object pnlHeader: TDNMPanel [3]
    Left = 0
    Top = 0
    Width = 952
    Height = 70
    HelpContext = 254004
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      952
      70)
    object pnlTitle: TDNMPanel
      Left = 296
      Top = 13
      Width = 238
      Height = 36
      HelpContext = 254006
      Anchors = [akTop]
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
        Width = 234
        Height = 32
        HelpContext = 254007
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
          Width = 234
          Height = 32
          HelpContext = 254008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Translation'
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
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 70
    Width = 952
    Height = 392
    HelpContext = 254004
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object wwDBGrid1: TwwDBGrid
      Left = 0
      Top = 0
      Width = 952
      Height = 318
      Selected.Strings = (
        'Language'#9'13'#9'Language'
        'Inenglish'#9'58'#9'Inenglish'
        'Translation'#9'58'#9'Translation')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsLanguageTranslate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      FooterColor = clWhite
      ExplicitTop = -6
    end
    object txtProductDescriptionSale: TDBMemo
      Left = 0
      Top = 355
      Width = 952
      Height = 37
      HelpContext = 314041
      Align = alBottom
      AutoDisplay = False
      DataField = 'Translation'
      DataSource = dsLanguageTranslate
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PopupMenu = popCustomiseGrid
      TabOrder = 1
    end
    object DBMemo3: TDBMemo
      Left = 0
      Top = 318
      Width = 952
      Height = 37
      HelpContext = 314041
      Align = alBottom
      AutoDisplay = False
      DataField = 'Inenglish'
      DataSource = dsLanguageTranslate
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PopupMenu = popCustomiseGrid
      ReadOnly = True
      TabOrder = 2
    end
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 462
    Width = 952
    Height = 70
    HelpContext = 254004
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 368
      Top = 24
      Width = 100
      Height = 23
      Caption = 'Save'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 0
      OnClick = DNMSpeedButton1Click
    end
  end
  inherited MyConnection: TERPConnection
    Database = 'serverupdates'
    Server = 'localhost'
    Connected = True
  end
  inherited QryCustomField: TERPQuery
    Left = 50
    Top = 168
  end
  object QryLanguageTranslate: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      '`languagetranslation` AS `CF`')
    Options.LongStrings = False
    Active = True
    Left = 50
    Top = 216
    object QryLanguageTranslateLanguage: TWideStringField
      DisplayWidth = 13
      FieldKind = fkLookup
      FieldName = 'Language'
      LookupDataSet = Qrylanguages
      LookupKeyFields = 'ID'
      LookupResultField = 'Language'
      KeyFields = 'LanguageID'
      Size = 50
      Lookup = True
    end
    object QryLanguageTranslateInenglish: TWideStringField
      DisplayWidth = 58
      FieldKind = fkLookup
      FieldName = 'Inenglish'
      LookupDataSet = QryinEnglish
      LookupKeyFields = 'ID'
      LookupResultField = 'InEnglish'
      KeyFields = 'EnglishID'
      Size = 255
      Lookup = True
    end
    object QryLanguageTranslateTranslation: TWideStringField
      DisplayWidth = 58
      FieldName = 'Translation'
      Origin = 'CF.Translation'
      Size = 255
    end
    object QryLanguageTranslateID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'CF.ID'
      Visible = False
    end
    object QryLanguageTranslateLanguageID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LanguageID'
      Origin = 'CF.LanguageID'
      Visible = False
    end
    object QryLanguageTranslateEnglishID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EnglishID'
      Origin = 'CF.EnglishID'
      Visible = False
    end
  end
  object Qrylanguages: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      'languages AS `CF`')
    Options.LongStrings = False
    Active = True
    Left = 50
    Top = 264
    object QrylanguagesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'CF.ID'
    end
    object QrylanguagesLanguage: TWideStringField
      FieldName = 'Language'
      Origin = 'CF.Language'
      Size = 50
    end
  end
  object QryinEnglish: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      'inEnglish')
    Options.LongStrings = False
    Active = True
    Left = 50
    Top = 312
    object QryinEnglishID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'inenglish.ID'
    end
    object QryinEnglishInEnglish: TWideStringField
      FieldName = 'InEnglish'
      Origin = 'inenglish.InEnglish'
      Size = 255
    end
  end
  object dsLanguageTranslate: TDataSource
    DataSet = QryLanguageTranslate
    Left = 160
    Top = 217
  end
end
