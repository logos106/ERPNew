inherited fmRapCategories: TfmRapCategories
  Left = 332
  Top = 246
  Caption = 'fmRapCategories'
  ClientWidth = 516
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TDNMPanel [1]
    Left = 0
    Top = 62
    Width = 516
    Height = 165
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 20
      Width = 43
      Height = 15
      Caption = 'Item No'
      Transparent = True
    end
    object Label3: TLabel
      Left = 16
      Top = 47
      Width = 61
      Height = 15
      Caption = 'Item Name'
      Transparent = True
    end
    object Label4: TLabel
      Left = 16
      Top = 74
      Width = 50
      Height = 15
      Caption = 'See Also'
      Transparent = True
    end
    object Label5: TLabel
      Left = 16
      Top = 101
      Width = 33
      Height = 15
      Caption = 'Notes'
      Transparent = True
    end
    object edtItemName: TwwDBEdit
      Left = 104
      Top = 43
      Width = 397
      Height = 23
      DataField = 'ItemName'
      DataSource = dsRAPCategory
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBLookupCombo1: TwwDBLookupCombo
      Left = 104
      Top = 70
      Width = 397
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ItemName'#9'100'#9'ItemName'#9'F')
      DataField = 'SeeAlsoCategory'
      DataSource = dsRAPCategory
      LookupTable = qryRAPCategoryLk
      LookupField = 'ItemNo'
      ParentFont = False
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object edtNotes: TDBMemo
      Left = 104
      Top = 101
      Width = 397
      Height = 89
      DataField = 'Note'
      DataSource = dsRAPCategory
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edtItemNo: TwwDBEdit
      Left = 104
      Top = 16
      Width = 81
      Height = 23
      DataField = 'ItemNo'
      DataSource = dsRAPCategory
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Picture.PictureMask = '&&00'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object HeaderPanel: TDNMPanel [2]
    Left = 0
    Top = 0
    Width = 516
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object pnlTitle: TDNMPanel
      Left = 125
      Top = 6
      Width = 238
      Height = 42
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
        Height = 38
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
          Height = 38
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Rap Category'
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
  object Panel2: TDNMPanel [3]
    Left = 0
    Top = 227
    Width = 516
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      516
      51)
    object Label32: TLabel
      Left = 442
      Top = 17
      Width = 50
      Height = 16
      Anchors = [akRight]
      AutoSize = False
      Caption = 'Active'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object btnCompleted: TDNMSpeedButton
      Left = 82
      Top = 12
      Width = 87
      Height = 27
      Anchors = []
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnCompletedClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 205
      Top = 12
      Width = 87
      Height = 27
      Anchors = []
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      OnClick = cmdNewClick
    end
    object btnClose: TDNMSpeedButton
      Left = 332
      Top = 12
      Width = 87
      Height = 27
      Anchors = []
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
      TabOrder = 2
      OnClick = btnCloseClick
    end
    object chkActive: TwwCheckBox
      Left = 498
      Top = 17
      Width = 15
      Height = 17
      TabStop = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Anchors = [akRight]
      Caption = 'chkActive'
      DataField = 'Active'
      DataSource = dsRAPCategory
      TabOrder = 3
    end
  end
  object qryRAPCategory: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'from tblRapCategories '
      '')
    Left = 389
    Top = 28
    object qryRAPCategoryCategoryID: TAutoIncField
      FieldName = 'CategoryID'
      ReadOnly = True
    end
    object qryRAPCategoryItemCode: TStringField
      FieldName = 'ItemCode'
      FixedChar = True
      Size = 2
    end
    object qryRAPCategoryItemNo: TStringField
      FieldName = 'ItemNo'
      Size = 4
    end
    object qryRAPCategoryItemName: TStringField
      FieldName = 'ItemName'
      Size = 100
    end
    object qryRAPCategorySeeAlsoCategory: TStringField
      FieldName = 'SeeAlsoCategory'
      Size = 4
    end
    object qryRAPCategoryNote: TMemoField
      FieldName = 'Note'
      BlobType = ftMemo
    end
    object qryRAPCategoryActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryRAPCategoryGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
  end
  object qryRAPCategoryLk: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'from tblRapCategories '
      '')
    Left = 421
    Top = 28
    object qryRAPCategoryLkCategoryID: TAutoIncField
      FieldName = 'CategoryID'
      ReadOnly = True
    end
    object qryRAPCategoryLkItemCode: TStringField
      FieldName = 'ItemCode'
      FixedChar = True
      Size = 2
    end
    object qryRAPCategoryLkItemNo: TStringField
      FieldName = 'ItemNo'
      Size = 4
    end
    object qryRAPCategoryLkItemName: TStringField
      FieldName = 'ItemName'
      Size = 100
    end
    object qryRAPCategoryLkSeeAlsoCategory: TStringField
      FieldName = 'SeeAlsoCategory'
      Size = 4
    end
    object qryRAPCategoryLkNote: TMemoField
      FieldName = 'Note'
      BlobType = ftMemo
    end
    object qryRAPCategoryLkActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryRAPCategoryLkGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
  end
  object dsRAPCategory: TDataSource
    DataSet = qryRAPCategory
    Left = 96
    Top = 32
  end
end
