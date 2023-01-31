inherited fmRapPrescriberType: TfmRapPrescriberType
  Left = 284
  Top = 181
  Caption = 'RAP Prescriber Type'
  ClientHeight = 359
  ClientWidth = 603
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TDNMPanel [1]
    Left = 0
    Top = 62
    Width = 603
    Height = 246
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      603
      246)
    object Label2: TLabel
      Left = 16
      Top = 20
      Width = 29
      Height = 15
      Caption = 'Code'
      Transparent = True
    end
    object Label3: TLabel
      Left = 16
      Top = 47
      Width = 33
      Height = 15
      Caption = 'Name'
      Transparent = True
    end
    object Label4: TLabel
      Left = 16
      Top = 75
      Width = 55
      Height = 15
      Caption = 'Products '
      Transparent = True
    end
    object edtItemName: TwwDBEdit
      Left = 60
      Top = 43
      Width = 316
      Height = 23
      DataField = 'PrescriberName'
      DataSource = dsMaster
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
    object edtItemNo: TwwDBEdit
      Left = 60
      Top = 16
      Width = 93
      Height = 23
      DataField = 'PrescriberCode'
      DataSource = dsMaster
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
    object wwDBGrid1: TwwDBGrid
      Left = 16
      Top = 94
      Width = 573
      Height = 147
      ControlType.Strings = (
        'Active;CheckBox;T;F'
        'RapProductCode;CustomEdit;cboRapProduct;F')
      Selected.Strings = (
        'RapProductCode'#9'4'#9'Product~Code'#9'F'#9
        'RapProductName'#9'63'#9'Product Name'#9'T'#9
        'Active'#9'1'#9'Active'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = 14144187
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsDetails
      TabOrder = 2
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnEnter = wwDBGrid1Enter
      FooterColor = 14144187
    end
    object cboRapProduct: TwwDBLookupCombo
      Left = 232
      Top = 160
      Width = 121
      Height = 23
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ProductCode'#9'4'#9'ProductCode'#9'F'
        'Description'#9'100'#9'Description'#9'F')
      LookupTable = qryRapProducts
      TabOrder = 3
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
  end
  object HeaderPanel: TDNMPanel [2]
    Left = 0
    Top = 0
    Width = 603
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
      Left = 145
      Top = 6
      Width = 315
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
        Width = 311
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
          Width = 311
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'RAP Prescriber Type'
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
    Top = 308
    Width = 603
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
      603
      51)
    object Label32: TLabel
      Left = 520
      Top = 17
      Width = 50
      Height = 16
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
      Left = 103
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
      Left = 247
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
      Left = 395
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
      Left = 576
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
      Caption = 'chkActive'
      DataField = 'Active'
      DataSource = dsMaster
      TabOrder = 3
    end
  end
  object dsDetails: TDataSource
    DataSet = tblDetails
    Left = 296
    Top = 8
  end
  object tblDetails: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'from tblRapPrescriberTypeItems'
      '')
    Left = 341
    Top = 12
    object tblDetailsRapProductCode: TStringField
      DisplayLabel = 'Product~Code'
      DisplayWidth = 4
      FieldKind = fkLookup
      FieldName = 'RapProductCode'
      LookupDataSet = qryRapProducts
      LookupKeyFields = 'RapProductID'
      LookupResultField = 'ProductCode'
      KeyFields = 'RapProductID'
      Size = 4
      Lookup = True
    end
    object tblDetailsRapProductName: TStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 63
      FieldKind = fkLookup
      FieldName = 'RapProductName'
      LookupDataSet = qryRapProducts
      LookupKeyFields = 'RapProductID'
      LookupResultField = 'Description'
      KeyFields = 'RapProductID'
      Size = 100
      Lookup = True
    end
    object tblDetailsActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object tblDetailsID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsPrescriberId: TIntegerField
      DisplayWidth = 10
      FieldName = 'PrescriberId'
      Visible = False
    end
    object tblDetailsRapProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RapProductID'
      Visible = False
    end
    object tblDetailsGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
  end
  object tblMaster: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'from tblRapPrescriberType'
      '')
    Left = 253
    Top = 12
    object tblMasterPrescriberID: TAutoIncField
      FieldName = 'PrescriberID'
      ReadOnly = True
    end
    object tblMasterPrescriberCode: TStringField
      FieldName = 'PrescriberCode'
      Size = 6
    end
    object tblMasterPrescriberName: TStringField
      FieldName = 'PrescriberName'
      Size = 100
    end
    object tblMasterproviderNum: TStringField
      FieldName = 'providerNum'
      Size = 15
    end
    object tblMasterActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object tblMasterGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
  end
  object dsMaster: TDataSource
    DataSet = tblMaster
    Left = 208
    Top = 8
  end
  object qryRapProducts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`tblrapproducts`.`RapProductID`,'
      '`tblrapproducts`.`ProductCode`,'
      '`tblrapproducts`.`Description`'
      'from `tblrapproducts`')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 360
    Top = 152
    object qryRapProductsProductCode: TStringField
      DisplayWidth = 4
      FieldName = 'ProductCode'
      Origin = 'tblrapproducts.ProductCode'
      Size = 4
    end
    object qryRapProductsDescription: TStringField
      DisplayWidth = 100
      FieldName = 'Description'
      Origin = 'tblrapproducts.Description'
      Size = 100
    end
    object qryRapProductsRapProductID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'RapProductID'
      Origin = 'tblrapproducts.RapProductID'
      Visible = False
    end
  end
end
