inherited EmbroideryDetailsGUI: TEmbroideryDetailsGUI
  Left = 149
  Top = 252
  Caption = 'Embroidery Details'
  ClientHeight = 369
  ClientWidth = 954
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 954
    Height = 369
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
      954
      369)
    object Label1: TLabel
      Left = 16
      Top = 72
      Width = 30
      Height = 15
      Caption = 'Type:'
      Transparent = True
    end
    object lblEmbroideryType: TLabel
      Left = 56
      Top = 72
      Width = 15
      Height = 15
      Caption = 'ET'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object grdMain: TwwDBGrid
      Left = 16
      Top = 104
      Width = 925
      Height = 209
      ControlType.Strings = (
        'Design;Bitmap;Stretch To Fit;Source Copy'
        'ProductName;CustomEdit;cboProduct;F'
        'Position;CustomEdit;cboPosition;F'
        'Memo;CustomEdit;dbeMemo;F'
        'Image;Bitmap;Stretch To Fit;Source Copy')
      Selected.Strings = (
        'ProductName'#9'20'#9'Product'
        'Qty'#9'10'#9'Qty'
        'Position'#9'20'#9'Position'
        'Name'#9'20'#9'Name'
        'Image'#9'10'#9'Design'
        'Stitches'#9'10'#9'Stitches'
        'Price'#9'10'#9'Price'
        'TotalPrice'#9'10'#9'Total Price'
        'Memo'#9'10'#9'Memo')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWindow
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      ParentFont = False
      RowHeightPercent = 300
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      object grdMainIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 20
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
        OnClick = grdMainIButtonClick
      end
    end
    object btnSave: TDNMSpeedButton
      Left = 262
      Top = 328
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = 'Save'
      Default = True
      DisableTransparent = False
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
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 600
      Top = 328
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Cancel = True
      Caption = 'Cancel'
      DisableTransparent = False
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
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object cboProduct: TwwDBLookupCombo
      Left = 40
      Top = 136
      Width = 121
      Height = 23
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ProductName'#9'30'#9'Product Name'#9'T')
      DataField = 'ProductName'
      DataSource = dsMain
      LookupTable = qryProduct
      LookupField = 'ProductName'
      Options = [loSearchOnBackspace]
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      UseTFields = False
      AllowClearKey = False
      OnCloseUp = cboProductCloseUp
    end
    object btnAddItems: TDNMSpeedButton
      Left = 431
      Top = 328
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = 'Add Items'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      OnClick = btnAddItemsClick
    end
    object cboPosition: TwwDBLookupCombo
      Left = 176
      Top = 136
      Width = 121
      Height = 23
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'30'#9'Description'#9'T')
      DataField = 'Position'
      DataSource = dsMain
      LookupTable = qryPosition
      LookupField = 'Description'
      Options = [loSearchOnBackspace]
      ParentFont = False
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      UseTFields = False
      AllowClearKey = False
      OnCloseUp = cboPositionCloseUp
    end
    object dbeMemo: TwwDBEdit
      Left = 320
      Top = 136
      Width = 121
      Height = 23
      TabOrder = 6
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object pnlTitle: TDNMPanel
      Left = 315
      Top = 22
      Width = 327
      Height = 45
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 323
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
          Width = 323
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Embroidery Details'
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
  inherited MyConnection: TMyConnection
    Top = 8
  end
  inherited DataState: TDataState
    Top = 40
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 40
    Top = 40
  end
  object qryMain: TMyQuery
    SQL.Strings = (
      'SELECT *'
      'FROM tblembroiderydetails'
      'WHERE (SaleLineID = :SaleLineID) AND (Active = '#39'T'#39')')
    Left = 800
    Top = 8
    ParamData = <
      item
        DataType = ftString
        Name = 'SaleLineID'
        Size = -1
        Value = ''
      end>
    object qryMainProductName: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'tblembroiderydetails.ProductName'
      Size = 60
    end
    object qryMainQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblembroiderydetails.Qty'
    end
    object qryMainPosition: TStringField
      DisplayWidth = 20
      FieldName = 'Position'
      Origin = 'tblembroiderydetails.Position'
      Size = 255
    end
    object qryMainName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Origin = 'tblembroiderydetails.Name'
      Size = 255
    end
    object qryMainStitches: TIntegerField
      DisplayWidth = 10
      FieldName = 'Stitches'
      Origin = 'tblembroiderydetails.Stitches'
    end
    object qryMainPrice: TFloatField
      FieldName = 'Price'
      currency = True
    end
    object qryMainTotalPrice: TFloatField
      DisplayLabel = 'Total Price'
      FieldName = 'TotalPrice'
      currency = True
    end
    object qryMainEmbroideryDetailsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'EmbroideryDetailsID'
      Origin = 'tblembroiderydetails.EmbroideryDetailsID'
      Visible = False
    end
    object qryMainMemo: TMemoField
      DisplayWidth = 10
      FieldName = 'Memo'
      Origin = 'tblembroiderydetails.Memo'
      BlobType = ftMemo
    end
    object qryMainGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Origin = 'tblembroiderydetails.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainSaleLineID: TIntegerField
      FieldName = 'SaleLineID'
      Origin = 'tblembroiderydetails.SaleLineID'
      Visible = False
    end
    object qryMainProductID: TIntegerField
      FieldName = 'ProductID'
      Origin = 'tblembroiderydetails.ProductID'
      Visible = False
    end
    object qryMainImageID: TIntegerField
      FieldName = 'ImageID'
      Origin = 'tblembroiderydetails.ImageID'
      Visible = False
    end
    object qryMainActive: TStringField
      FieldName = 'Active'
      Origin = 'tblembroiderydetails.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblembroiderydetails.msTimeStamp'
      Visible = False
    end
  end
  object dsMain: TDataSource
    DataSet = memMain
    Left = 736
    Top = 8
  end
  object qryProduct: TMyQuery
    SQL.Strings = (
      'SELECT PartsID AS ProductID, PartName AS ProductName'
      'FROM tblparts'
      'WHERE (Embroidery = '#39'F'#39') AND (Active = '#39'T'#39')'
      'ORDER BY ProductName')
    Left = 736
    Top = 40
    object qryProductProductID: TIntegerField
      FieldName = 'ProductID'
      Visible = False
    end
    object qryProductProductName: TStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 30
      FieldName = 'ProductName'
      Size = 60
    end
  end
  object qryPrice: TMyQuery
    SQL.Strings = (
      'SELECT *'
      'FROM tblembroiderypricelist'
      '')
    Left = 800
    Top = 40
  end
  object qryAxes: TMyQuery
    SQL.Strings = (
      'SELECT *'
      'FROM tblembroideryaxes'
      'WHERE AxisType = '#39'Column'#39
      '')
    Left = 832
    Top = 40
  end
  object qryPosition: TMyQuery
    SQL.Strings = (
      'SELECT *'
      'FROM tblembroideryposition')
    Left = 768
    Top = 40
    object qryPositionEmbroideryPositionID: TIntegerField
      FieldName = 'EmbroideryPositionID'
    end
    object qryPositionDescription: TStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryPositionImage: TBlobField
      FieldName = 'Image'
    end
  end
  object qryDetails: TMyQuery
    SQL.Strings = (
      'SELECT *'
      'FROM tblembroiderydetails ed'
      
        'INNER JOIN tblembroideryposition ep ON ed.ImageID = ep.Embroider' +
        'yPositionID'
      'WHERE (ed.SaleLineID = :SaleLineID) AND (Active = '#39'T'#39')')
    Left = 832
    Top = 8
    ParamData = <
      item
        DataType = ftString
        Name = 'SaleLineID'
        Size = -1
        Value = ''
      end>
    object qryDetailsProductName: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'tblembroiderydetails.ProductName'
      Size = 60
    end
    object qryDetailsQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblembroiderydetails.Qty'
    end
    object qryDetailsPosition: TStringField
      DisplayWidth = 20
      FieldName = 'Position'
      Origin = 'tblembroiderydetails.Position'
      Size = 255
    end
    object qryDetailsName: TStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Origin = 'tblembroiderydetails.Name'
      Size = 255
    end
    object qryDetailsImage: TBlobField
      DisplayLabel = 'Design'
      DisplayWidth = 10
      FieldName = 'Image'
      Origin = 'ep.Image'
    end
    object qryDetailsStitches: TIntegerField
      DisplayWidth = 10
      FieldName = 'Stitches'
      Origin = 'tblembroiderydetails.Stitches'
    end
    object qryDetailsPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'Price'
      Origin = 'tblembroiderydetails.Price'
      currency = True
    end
    object qryDetailsTotalPrice: TFloatField
      DisplayLabel = 'Total Price'
      DisplayWidth = 10
      FieldName = 'TotalPrice'
      Origin = 'tblembroiderydetails.TotalPrice'
      currency = True
    end
    object qryDetailsMemo: TMemoField
      DisplayWidth = 10
      FieldName = 'Memo'
      Origin = 'tblembroiderydetails.Memo'
      BlobType = ftMemo
    end
    object qryDetailsEmbroideryDetailsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'EmbroideryDetailsID'
      Origin = 'tblembroiderydetails.EmbroideryDetailsID'
      Visible = False
    end
    object qryDetailsProductID: TIntegerField
      FieldName = 'ProductID'
      Origin = 'tblembroiderydetails.ProductID'
      Visible = False
    end
    object qryDetailsSaleLineID: TIntegerField
      FieldName = 'SaleLineID'
      Origin = 'tblembroiderydetails.SaleLineID'
      Visible = False
    end
    object qryDetailsImageID: TIntegerField
      FieldName = 'ImageID'
      Origin = 'tblembroiderydetails.ImageID'
      Visible = False
    end
  end
  object memMain: TkbmMemTable
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
    BeforeDelete = memMainBeforeDelete
    Left = 768
    Top = 8
  end
end
