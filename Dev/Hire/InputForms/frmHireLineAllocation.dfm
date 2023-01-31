inherited fmHireLineAllocation: TfmHireLineAllocation
  BorderStyle = bsDialog
  Caption = 'Hire Line Allocation'
  ClientHeight = 367
  ClientWidth = 522
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Position = poScreenCenter
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 528
  ExplicitHeight = 396
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1439002
  inherited lblSkingroupMsg: TLabel
    Top = 367
    Width = 522
    ExplicitTop = 426
    ExplicitWidth = 593
    HelpContext = 1439003
  end
  object pnlTitle: TDNMPanel [3]
    Left = 93
    Top = 12
    Width = 336
    Height = 39
    HelpContext = 1439004
    Anchors = [akLeft, akTop, akRight]
    
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 334
      Height = 37
      HelpContext = 1439005
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
      ExplicitWidth = 365
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 334
        Height = 37
        HelpContext = 1439006
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Hire Line Allocation'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitLeft = -1
        ExplicitTop = 6
        ExplicitWidth = 948
      end
    end
  end
  object cmdClose: TDNMSpeedButton [4]
    Left = 102
    Top = 330
    Width = 93
    Height = 29
    Anchors = [akBottom]
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    OnClick = cmdCloseClick
    ExplicitTop = 341
    HelpContext = 1439007
  end
  object cmdCancel: TDNMSpeedButton [5]
    Left = 327
    Top = 330
    Width = 93
    Height = 29
    Anchors = [akBottom]
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 4
    ExplicitTop = 341
    HelpContext = 1439008
  end
  object grdMain: TwwDBGrid [6]
    Left = 60
    Top = 81
    Width = 402
    Height = 232
    Selected.Strings = (
      'AssetName'#9'30'#9'Asset Name'
      'AssetCode'#9'20'#9'Asset Code')
    MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
    IniAttributes.SaveToRegistry = True
    IniAttributes.Delimiter = ';;'
    IniAttributes.CheckNewFields = True
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
    Color = clWhite
    DataSource = dsLineAsset
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
    TabOrder = 1
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = True
    LineColors.GroupingColor = clSilver
    FooterCellColor = clWhite
    ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
    PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
    HelpContext = 1439009
    object btnGrid: TwwIButton
      Left = 0
      Top = 0
      Width = 22
      Height = 22
      AllowAllUp = True
      Glyph.Data = {
        C6030000424DC603000000000000360000002800000010000000130000000100
        18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
        666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
        99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
        CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
        333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
        99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
        C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
        C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
        77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
        8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
        B2B2B2808080333366000080333366777777777777333366000080333399C0C0
        C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
        0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
        CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
        0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
        868686808080666699333399333399000080333366666666808080969696C0C0
        C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
        8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
        B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
        80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
        CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
        99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
        D7CCCCCCCCCCCCCCCCCC}
      OnClick = btnGridClick
      HelpContext = 1439010
    end
  end
  object btnAdd: TDNMSpeedButton [7]
    Left = 214
    Top = 330
    Width = 93
    Height = 29
    Anchors = [akBottom]
    Caption = 'Add'
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
    ParentFont = False
    TabOrder = 3
    OnClick = btnAddClick
    ExplicitTop = 341
    HelpContext = 1439011
  end
  inherited tmrdelayMsg: TTimer
    Left = 80
    Top = 32
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    LoginPrompt = False
    Left = 10
    Top = 31
  end
  object qryLineAsset: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblhirelineasset')
    Left = 432
    Top = 40
    object qryLineAssetAssetName: TWideStringField
      DisplayLabel = 'Asset Name'
      DisplayWidth = 30
      FieldName = 'AssetName'
      Origin = 'tblhirelineasset.AssetName'
      Size = 255
    end
    object qryLineAssetAssetCode: TWideStringField
      DisplayLabel = 'Asset Code'
      DisplayWidth = 20
      FieldName = 'AssetCode'
      Origin = 'tblhirelineasset.AssetCode'
      Size = 255
    end
    object qryLineAssetHireLineAssetID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'HireLineAssetID'
      Origin = 'tblhirelineasset.HireLineAssetID'
      Visible = False
    end
    object qryLineAssetGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblhirelineasset.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryLineAssetHireLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'HireLineID'
      Origin = 'tblhirelineasset.HireLineID'
      Visible = False
    end
    object qryLineAssetAssetId: TIntegerField
      DisplayWidth = 10
      FieldName = 'AssetId'
      Origin = 'tblhirelineasset.AssetId'
      Visible = False
    end
    object qryLineAssetmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblhirelineasset.msTimeStamp'
      Visible = False
    end
    object qryLineAssetmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblhirelineasset.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsLineAsset: TDataSource
    DataSet = qryLineAsset
    Left = 456
    Top = 96
  end
end
