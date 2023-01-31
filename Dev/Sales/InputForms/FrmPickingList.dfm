inherited fmPickingList: TfmPickingList
  Left = 167
  Top = 235
  Caption = 'Picking Slip'
  ClientHeight = 301
  ClientWidth = 940
  OldCreateOrder = True
  DesignSize = (
    940
    301)
  PixelsPerInch = 96
  TextHeight = 15
  object btnCancel: TDNMSpeedButton [1]
    Left = 498
    Top = 263
    Width = 87
    Height = 27
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = '&Cancel'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
    TabStop = False
  end
  object btnPrint: TDNMSpeedButton [2]
    Left = 354
    Top = 262
    Width = 87
    Height = 27
    Anchors = [akTop, akRight]
    Caption = '&Print'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
    TabOrder = 2
    TabStop = False
    OnClick = btnPrintClick
  end
  object pnlTitle: TDNMPanel [3]
    Left = 0
    Top = 0
    Width = 940
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentColor = True
    ParentFont = False
    TabOrder = 3
    object DNMPanel1: TDNMPanel
      Left = 350
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
          Caption = 'Picking Slip'
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
  object grdList: TwwDBGrid [4]
    Left = 0
    Top = 57
    Width = 940
    Height = 189
    ControlType.Strings = (
      'Active;CheckBox;T;F')
    Selected.Strings = (
      'Partname'#9'27'#9'Product'#9'T'#9
      'Batchnumber'#9'15'#9'Batch Number'#9'T'#9
      'ExpiryDate'#9'10'#9'Batch Expiry Date'#9'T'#9
      'BinLocation'#9'20'#9'Bin Location'#9'T'#9
      'BinNumber'#9'10'#9'Bin Number'#9'T'#9
      'UOM'#9'15'#9'UOM'#9'T'#9
      'UOMQty'#9'10'#9'UOMQty'#9'T'#9
      'QtyPicking'#9'10'#9'QtyPicking'#9#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alTop
    DataSource = dsProducts
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = []
    ParentFont = False
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 37
    Top = 4
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 6
    Top = 1
  end
  inherited MyConnection: TMyConnection
    Database = 'platinum1'
    Left = 74
    Top = 3
  end
  inherited DataState: TDataState
    Left = 7
    Top = 31
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 131
    Top = 7
  end
  object qryProducts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select ID, BinId, BatchId, PartsId ,UOM, UOMQty,  QtyPicking '
      'from tblProductQtyallocation '
      'Where TransID = :SaleId'
      'and transType =:transType'
      'and tblProductQtyallocation.Active = "T"')
    BeforePost = qryProductsBeforePost
    Left = 96
    Top = 217
    ParamData = <
      item
        DataType = ftString
        Name = 'SaleId'
        Value = '0'
      end
      item
        DataType = ftString
        Name = 'transType'
        Value = ' '
      end>
    object qryProductsPartname: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 27
      FieldKind = fkLookup
      FieldName = 'Partname'
      LookupDataSet = qryParts
      LookupKeyFields = 'PartsId'
      LookupResultField = 'Partname'
      KeyFields = 'PartsId'
      Size = 100
      Lookup = True
    end
    object qryProductsBatchnumber: TStringField
      DisplayLabel = 'Batch Number'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'Batchnumber'
      LookupDataSet = qryBatches
      LookupKeyFields = 'ID'
      LookupResultField = 'BatchNumber'
      KeyFields = 'BatchId'
      Size = 100
      Lookup = True
    end
    object qryProductsExpiryDate: TDateField
      DisplayLabel = 'Batch Expiry Date'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'ExpiryDate'
      LookupDataSet = qryBatches
      LookupKeyFields = 'ID'
      LookupResultField = 'ExpiryDate'
      KeyFields = 'BatchId'
      Lookup = True
    end
    object qryProductsBinLocation: TStringField
      DisplayLabel = 'Bin Location'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'BinLocation'
      LookupDataSet = qrybins
      LookupKeyFields = 'ID'
      LookupResultField = 'BinLocation'
      KeyFields = 'BinId'
      Size = 100
      Lookup = True
    end
    object qryProductsBinNumber: TStringField
      DisplayLabel = 'Bin Number'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'BinNumber'
      LookupDataSet = qrybins
      LookupKeyFields = 'ID'
      LookupResultField = 'binnumber'
      KeyFields = 'BinId'
      Size = 100
      Lookup = True
    end
    object qryProductsUOM: TStringField
      DisplayWidth = 15
      FieldName = 'UOM'
      Origin = 'tblProductQtyallocation.UOM'
      Size = 15
    end
    object qryProductsUOMQty: TFloatField
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'tblProductQtyallocation.UOMQty'
    end
    object qryProductsQtyPicking: TFloatField
      DisplayWidth = 10
      FieldName = 'QtyPicking'
      Origin = 'tblProductQtyallocation.QtyPicking'
    end
    object qryProductsID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblProductQtyallocation.ID'
      ReadOnly = True
      Visible = False
    end
    object qryProductsBatchId: TIntegerField
      DisplayWidth = 10
      FieldName = 'BatchId'
      Origin = 'tblProductQtyallocation.BatchID'
      Visible = False
    end
    object qryProductsPartsId: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsId'
      Origin = 'tblProductQtyallocation.PartsId'
      Visible = False
    end
    object qryProductsBinId: TLargeintField
      FieldName = 'BinId'
      Origin = 'tblProductQtyallocation.BinID'
      Visible = False
    end
  end
  object dsProducts: TDataSource
    DataSet = qryProducts
    Left = 128
    Top = 216
  end
  object qryParts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select tblParts.PartsId , tblParts.Partname from tblParts')
    Left = 161
    Top = 216
    object qryPartsPartsId: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'PartsId'
      Origin = 'tblParts.PARTSID'
      ReadOnly = True
    end
    object qryPartsPartname: TStringField
      FieldName = 'Partname'
      Origin = 'tblParts.PARTNAME'
      Size = 60
    end
  end
  object qrybins: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select ID, BinLocation, binnumber  from tblProductBinQty')
    Left = 200
    Top = 216
    object qrybinsID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblProductBinQty.ID'
      ReadOnly = True
    end
    object qrybinsBinLocation: TStringField
      FieldName = 'BinLocation'
      Origin = 'tblProductBinQty.BinLocation'
      Size = 25
    end
    object qrybinsbinnumber: TStringField
      FieldName = 'binnumber'
      Origin = 'tblProductBinQty.BinNumber'
      Size = 15
    end
  end
  object qryBatches: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select ID, if(BatchNumber='#39'Hidden'#39' , '#39#39' , BatchNumber) as BatchN' +
        'umber, ExpiryDate  from tblProductBatchQty')
    Left = 232
    Top = 216
    object qryBatchesID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblProductBatchQty.ID'
      ReadOnly = True
    end
    object qryBatchesBatchNumber: TStringField
      FieldName = 'BatchNumber'
      Origin = '.BatchNumber'
      Size = 30
    end
    object qryBatchesExpiryDate: TDateTimeField
      FieldName = 'ExpiryDate'
      Origin = 'tblProductBatchQty.ExpiryDate'
    end
  end
end
