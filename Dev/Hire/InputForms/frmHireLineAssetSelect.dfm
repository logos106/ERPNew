inherited fmHireLineAssetSelect: TfmHireLineAssetSelect
  HelpContext = 1440002
  BorderStyle = bsDialog
  Caption = 'Hire Select'
  ClientHeight = 373
  ClientWidth = 549
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Position = poScreenCenter
  ExplicitWidth = 565
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 373
    Width = 549
    HelpContext = 1440003
    ExplicitTop = 373
    ExplicitWidth = 549
  end
  object grdMain: TwwDBGrid [4]
    Left = 60
    Top = 112
    Width = 402
    Height = 201
    HelpContext = 1440007
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
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgRowResize]
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
  end
  object cmdClose: TDNMSpeedButton [5]
    Left = 166
    Top = 334
    Width = 93
    Height = 29
    HelpContext = 1440008
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
  end
  object cmdCancel: TDNMSpeedButton [6]
    Left = 289
    Top = 334
    Width = 93
    Height = 29
    HelpContext = 1440009
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
    TabOrder = 3
  end
  object grpFilters: TwwRadioGroup [7]
    Left = 76
    Top = 57
    Width = 386
    Height = 37
    HelpContext = 1440010
    DisableThemes = False
    ItemIndex = 0
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Items.Strings = (
      'Available'
      'All')
    ParentFont = False
    TabOrder = 4
    OnClick = grpFiltersClick
  end
  object pnlTitle: TDNMPanel [8]
    Left = 113
    Top = 12
    Width = 322
    Height = 39
    HelpContext = 1440004
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
      Width = 320
      Height = 37
      HelpContext = 1440005
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
        Width = 320
        Height = 37
        HelpContext = 1440006
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Hire Select'
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
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Connected = True
    LoginPrompt = False
    Left = 10
    Top = 31
  end
  object qryLineAsset: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select if(IsNull(tblhire.HireID),"F","T") as OnHire, tblfixedass' +
        'ets.AssetID, tblfixedassets.AssetName, tblfixedassets.AssetCode ' +
        ' '
      'from tblfixedassets'
      
        'inner join tblassethire on tblassethire.AssetId = tblfixedassets' +
        '.AssetID and tblassethire.Active = "T"'
      
        'left join tblhirelineasset on tblhirelineasset.AssetId = tblfixe' +
        'dassets.AssetID'
      
        'left join tblhirelines on tblhirelines.HireLineID = tblhirelinea' +
        'sset.HireLineID and tblhirelines.Deleted = "F" and tblhirelines.' +
        'Converted = "F" '
      'and ( '
      
        '((tblhirelines.HireFrom >= :timeFrom and tblhirelines.HireFrom <' +
        ' :timeTo) or (tblhirelines.HireTo >= :timeFrom and tblhirelines.' +
        'HireTo < :timeTo))'
      'or'
      
        '((tblhirelines.ActualHireFrom >= :timeFrom and tblhirelines.Actu' +
        'alHireFrom < :timeTo) or (tblhirelines.ActualHireTo >= :timeFrom' +
        ' and tblhirelines.ActualHireTo < :timeTo))'
      ')'
      
        'left join tblhire on tblhire.HireID = tblhirelines.HireID and tb' +
        'lhire.Deleted = "F" and tblhire.Converted = "F"'
      'where tblfixedassets.AssetName = :AssetName'
      'and IfNull(tblhirelines.HireLineId,0) <> :HireLineId')
    Left = 432
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'timeFrom'
      end
      item
        DataType = ftUnknown
        Name = 'timeTo'
      end
      item
        DataType = ftUnknown
        Name = 'timeFrom'
      end
      item
        DataType = ftUnknown
        Name = 'timeTo'
      end
      item
        DataType = ftUnknown
        Name = 'timeFrom'
      end
      item
        DataType = ftUnknown
        Name = 'timeTo'
      end
      item
        DataType = ftUnknown
        Name = 'timeFrom'
      end
      item
        DataType = ftUnknown
        Name = 'timeTo'
      end
      item
        DataType = ftUnknown
        Name = 'AssetName'
      end
      item
        DataType = ftUnknown
        Name = 'HireLineId'
      end>
    object qryLineAssetAssetName: TWideStringField
      DisplayLabel = 'Asset Name'
      DisplayWidth = 30
      FieldName = 'AssetName'
      Size = 255
    end
    object qryLineAssetAssetCode: TWideStringField
      DisplayLabel = 'Asset Code'
      DisplayWidth = 20
      FieldName = 'AssetCode'
      Size = 50
    end
    object qryLineAssetOnHire: TWideStringField
      DisplayWidth = 1
      FieldName = 'OnHire'
      Visible = False
      Size = 1
    end
    object qryLineAssetAssetID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AssetID'
      Visible = False
    end
  end
  object dsLineAsset: TDataSource
    DataSet = qryLineAsset
    Left = 456
    Top = 96
  end
end
