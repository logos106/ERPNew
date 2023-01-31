inherited fmRAPProducts: TfmRAPProducts
  Left = 294
  Top = 137
  Caption = 'fmRAPProducts'
  ClientHeight = 458
  ClientWidth = 516
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object HeaderPanel: TDNMPanel [1]
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
    TabOrder = 0
    object pnlTitle: TDNMPanel
      Left = 138
      Top = 6
      Width = 238
      Height = 45
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
        Height = 41
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
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'RAP Product'
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
  object Panel1: TDNMPanel [2]
    Left = 0
    Top = 62
    Width = 516
    Height = 345
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 20
      Width = 78
      Height = 15
      Caption = 'RAP Category'
      Transparent = True
    end
    object Label3: TLabel
      Left = 16
      Top = 52
      Width = 104
      Height = 15
      Caption = 'RAP Product Code'
      Transparent = True
    end
    object Label5: TLabel
      Left = 16
      Top = 84
      Width = 65
      Height = 15
      Caption = 'Description'
      Transparent = True
    end
    object Label32: TLabel
      Left = 16
      Top = 121
      Width = 84
      Height = 30
      Caption = 'Prior Approval Required'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label6: TLabel
      Left = 16
      Top = 277
      Width = 48
      Height = 15
      Caption = 'GST r/s?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 16
      Top = 205
      Width = 105
      Height = 15
      Caption = 'Special Conditions'
      Transparent = True
    end
    object Label9: TLabel
      Left = 16
      Top = 352
      Width = 103
      Height = 15
      Caption = 'Product  Linked to'
      Transparent = True
      Visible = False
    end
    object Label10: TLabel
      Left = 17
      Top = 311
      Width = 57
      Height = 15
      Caption = 'Card Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel66: TBevel
      Left = 135
      Top = 300
      Width = 370
      Height = 36
      Shape = bsFrame
    end
    object Label11: TLabel
      Left = 310
      Top = 277
      Width = 162
      Height = 15
      Caption = 'Raptor Contracted Product? '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object PnlApprovalLimits: TDNMPanel
      Left = 160
      Top = 112
      Width = 344
      Height = 37
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object Label1: TLabel
        Left = 182
        Top = -2
        Width = 162
        Height = 15
        Caption = 'Prior Approval Quantity Limit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 11
        Top = -2
        Width = 159
        Height = 15
        Caption = 'Prior Approval Amount Limit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtPriorApprovalQtyLimit: TwwDBEdit
        Left = 237
        Top = 14
        Width = 53
        Height = 23
        DataField = 'PriorApprovalQtyLimit'
        DataSource = dsDeliveryCodes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edtPriorApprovalAmtLimit: TwwDBEdit
        Left = 64
        Top = 14
        Width = 53
        Height = 23
        DataField = 'PriorApprovalAmtLimit'
        DataSource = dsDeliveryCodes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object edtProductCode: TwwDBEdit
      Left = 135
      Top = 48
      Width = 53
      Height = 23
      DataField = 'ProductCode'
      DataSource = dsDeliveryCodes
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Picture.PictureMask = '&&##'
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object chkPriorApprovalRequired: TwwCheckBox
      Left = 135
      Top = 127
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
      Caption = 'chkPriorApprovalRequired'
      DataField = 'PriorApprovalRequired'
      DataSource = dsDeliveryCodes
      TabOrder = 1
      OnClick = chkPriorApprovalRequiredClick
    end
    object cboRapCategoryCode: TwwDBLookupCombo
      Left = 135
      Top = 16
      Width = 370
      Height = 23
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ItemName'#9'100'#9'ItemName'#9'F')
      DataField = 'RapCategoryCode'
      DataSource = dsDeliveryCodes
      LookupTable = qryRAPCategory
      LookupField = 'ItemCode'
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object chkGST: TwwCheckBox
      Left = 135
      Top = 276
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
      Caption = 'chkActive'
      DataField = 'GST'
      DataSource = dsDeliveryCodes
      TabOrder = 3
    end
    object edtSpecialConsitions: TDBMemo
      Left = 135
      Top = 160
      Width = 370
      Height = 104
      DataField = 'SpecialConsitions'
      DataSource = dsDeliveryCodes
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object cboProduct: TwwDBLookupCombo
      Left = 135
      Top = 348
      Width = 321
      Height = 23
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'60'#9'PARTNAME'#9'F')
      DataField = 'ProductID'
      LookupField = 'PARTSID'
      TabOrder = 6
      Visible = False
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object wwDBEdit1: TwwDBEdit
      Left = 135
      Top = 80
      Width = 370
      Height = 23
      DataField = 'Description'
      DataSource = dsDeliveryCodes
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object rdoCardType: TwwRadioGroup
      Left = 147
      Top = 310
      Width = 358
      Height = 16
      TransparentActiveItem = True
      Indents.TextX = 5
      ShowGroupCaption = False
      Transparent = True
      NoSpacing = True
      Columns = 3
      DataField = 'CardType'
      DataSource = dsDeliveryCodes
      Items.Strings = (
        'Gold Card'
        'White Card'
        'None')
      TabOrder = 8
      Values.Strings = (
        'G'
        'W'
        ' ')
    end
    object chkContracted: TwwCheckBox
      Left = 490
      Top = 276
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
      Caption = 'chkActive'
      DataField = 'Contracted'
      DataSource = dsDeliveryCodes
      TabOrder = 9
    end
  end
  object Panel2: TDNMPanel [3]
    Left = 0
    Top = 407
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
    object Label8: TLabel
      Left = 437
      Top = 20
      Width = 42
      Height = 15
      Anchors = [akTop, akRight]
      Caption = 'Active?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
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
      Left = 208
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
      Left = 490
      Top = 18
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
      Anchors = [akTop, akRight]
      Caption = 'chkActive'
      DataField = 'Active'
      DataSource = dsDeliveryCodes
      TabOrder = 3
    end
  end
  object qryRapProducts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'from tblRapProducts'
      '')
    Left = 389
    Top = 28
    object qryRapProductsRapProductID: TAutoIncField
      FieldName = 'RapProductID'
      ReadOnly = True
    end
    object qryRapProductsRapCategoryID: TIntegerField
      FieldName = 'RapCategoryID'
    end
    object qryRapProductsRapCategoryCode: TStringField
      FieldName = 'RapCategoryCode'
      Size = 4
    end
    object qryRapProductsProductCode: TStringField
      FieldName = 'ProductCode'
      Size = 4
    end
    object qryRapProductsDescription: TStringField
      FieldName = 'Description'
      Size = 100
    end
    object qryRapProductsPriorApprovalRequired: TStringField
      FieldName = 'PriorApprovalRequired'
      FixedChar = True
      Size = 1
    end
    object qryRapProductsPriorApprovalQtyLimit: TFloatField
      FieldName = 'PriorApprovalQtyLimit'
    end
    object qryRapProductsPriorApprovalAmtLimit: TFloatField
      FieldName = 'PriorApprovalAmtLimit'
    end
    object qryRapProductsGST: TStringField
      FieldName = 'GST'
      FixedChar = True
      Size = 1
    end
    object qryRapProductsSpecialConsitions: TMemoField
      FieldName = 'SpecialConsitions'
      BlobType = ftMemo
    end
    object qryRapProductsActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryRapProductsCardType: TStringField
      FieldName = 'CardType'
      FixedChar = True
      Size = 1
    end
    object qryRapProductsContracted: TStringField
      FieldName = 'Contracted'
      FixedChar = True
      Size = 1
    end
    object qryRapProductsGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
  end
  object dsDeliveryCodes: TDataSource
    DataSet = qryRapProducts
    Left = 352
    Top = 32
  end
  object qryRAPCategory: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'from tblRapCategories '
      '')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 239
    Top = 73
    object qryRAPCategoryItemName: TStringField
      DisplayWidth = 100
      FieldName = 'ItemName'
      Size = 100
    end
    object qryRAPCategoryCategoryID: TIntegerField
      FieldName = 'CategoryID'
      Visible = False
    end
    object qryRAPCategoryItemCode: TStringField
      FieldName = 'ItemCode'
      Visible = False
      FixedChar = True
      Size = 2
    end
    object qryRAPCategoryItemNo: TStringField
      FieldName = 'ItemNo'
      Visible = False
      Size = 4
    end
    object qryRAPCategorySeeAlsoCategory: TStringField
      FieldName = 'SeeAlsoCategory'
      Visible = False
      Size = 4
    end
    object qryRAPCategoryNote: TMemoField
      FieldName = 'Note'
      Visible = False
      BlobType = ftMemo
    end
    object qryRAPCategoryActive: TStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object cboProductQry: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'p.PARTNAME, p.PARTSID'
      'FROM tblparts p'
      'WHERE p.Active = '#39'T'#39
      ''
      ''
      '')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 280
    Top = 138
    object cboProductQryPARTNAME: TStringField
      DisplayWidth = 60
      FieldName = 'PARTNAME'
      Size = 60
    end
    object cboProductQryPARTSID: TIntegerField
      FieldName = 'PARTSID'
      Visible = False
    end
  end
end
