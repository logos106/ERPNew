inherited fmStockAdjustEntryTree: TfmStockAdjustEntryTree
  Left = 218
  Top = 193
  HelpContext = 618000
  Caption = 'Stock Adjustment'
  ClientWidth = 954
  ExplicitTop = 8
  ExplicitWidth = 960
  DesignSize = (
    954
    561)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Width = 954
    HelpContext = 618009
    ExplicitWidth = 954
  end
  inherited DNMPanel2: TDNMPanel
    Width = 954
    HelpContext = 618006
    TabOrder = 1
    Transparent = False
    ExplicitWidth = 954
    inherited lblProgressbar: TLabel
      Width = 954
      HelpContext = 618017
    end
    inherited grdTransactions: TwwDBGrid
      Width = 931
      HelpContext = 618007
      ControlType.Strings = (
        'ProductName;CustomEdit;cboProduct;F'
        'ClassName;CustomEdit;cboClass;F'
        'BinLocation;CustomEdit;cboBinLocation;F'
        'BinNumber;CustomEdit;cboBinNumber;F'
        'UOM;CustomEdit;cboUOM;F'
        'BatchNo;CustomEdit;cboBatchnumber;F'
        'PRODUCTNAME;CustomEdit;cboProduct;F'
        'CLASSNAME;CustomEdit;cboClass;F'
        'JobName;CustomEdit;cboJob;F')
      Selected.Strings = (
        'PRODUCTNAME'#9'20'#9'Product~Name'#9'F'#9
        'DESCRIPTION'#9'20'#9'Description'#9'F'#9
        'CLASSNAME'#9'20'#9'Class Name'#9'F'#9
        'AccountName'#9'20'#9'Account Name'#9'F'#9
        'AVAILABLEUOMQTY'#9'10'#9'Available'#9'F'#9'Quantity'
        'FINALUOMQTY'#9'10'#9'Final'#9'F'#9'Quantity'
        'ADJUSTUOMQTY'#9'10'#9'Adjust'#9'F'#9'Quantity'
        'InStockUOMQty'#9'10'#9'In-Stock'#9'T'#9'Quantity'
        'COST'#9'10'#9'Cost'#9'F'#9
        'UOM'#9'10'#9'Uom'#9'F'#9
        'UOMMULTIPLIER'#9'10'#9'Multiplier'#9'F'#9
        'PQAAllocation'#9'20'#9'Allocation'#9'F'#9
        'UOMCost'#9'10'#9'UOM Cost'#9'T'#9
        'Totalcost'#9'10'#9'Total Cost'#9'T'#9
        'PartBarcode'#9'20'#9'Product~Bar Code'#9'F'#9
        'MatrixDesc'#9'10'#9'Desc'#9'F'#9'Matrix'
        'MatrixRef'#9'10'#9'Ref'#9'F'#9'Matrix'
        'MatrixPrice'#9'10'#9'Price'#9'F'#9'Matrix'
        'FormulaQtyValue1'#9'10'#9'Value 1'#9'F'#9'Formula Quantity'
        'FormulaQtyValue2'#9'10'#9'Value 2'#9'F'#9'Formula Quantity'
        'Parttype'#9'13'#9'Part Type'#9'F'#9
        'FormulaQtyValue3'#9'10'#9'Value 3'#9'F'#9'Formula Quantity'
        'FormulaQtyValue4'#9'10'#9'Value 4'#9'F'#9'Formula Quantity'
        'FormulaQtyValue5'#9'10'#9'Value 5'#9'F'#9'Formula Quantity'
        'FormulaQtyValue'#9'10'#9'Value'#9'F'#9'Formula Quantity'
        'Notes'#9'20'#9'Notes'#9'F'#9
        'ProductPrintName'#9'20'#9'Product~Print Name'#9'F'#9)
      DataSource = dsStockAdjustEntryProductLines
      TitleLines = 2
      OnMouseUp = grdTransactionsMouseUp
      ExplicitWidth = 931
      inherited btnDelete: TwwIButton
        Height = 34
        HelpContext = 618008
        OnClick = btnDeleteClick
        ExplicitHeight = 34
      end
    end
    inherited ProgressBar: TProgressBar
      Width = 954
      HelpContext = 618018
      ExplicitWidth = 954
    end
    inherited cboProduct: TERPDbLookupCombo
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Product Name'#9'F'
        'Manuf'#9'15'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'15'#9'Dept'#9'F'
        'PartsDescription'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F')
      DataIDField = 'ProductId'
    end
    inherited cboUOM: TwwDBLookupCombo
      OnCloseUp = cboUOMCloseUp
    end
    inherited DNMPanel4: TDNMPanel
      Left = 948
      Width = 6
      HelpContext = 618019
      ExplicitLeft = 948
      ExplicitWidth = 6
    end
    inherited cboPrintProduct: TERPDbLookupCombo
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Product Name'#9'F'
        'Manuf'#9'15'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'15'#9'Dept'#9'F'
        'PartsDescription'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F')
      Visible = False
    end
  end
  inherited DNMPanel5: TDNMPanel
    Width = 954
    HelpContext = 618020
    ExplicitWidth = 954
    DesignSize = (
      954
      110)
    inherited lbMemo: TLabel
      Top = 21
      Width = 43
      Height = 15
      HelpContext = 618021
      ParentFont = True
      ExplicitTop = 21
      ExplicitWidth = 43
      ExplicitHeight = 15
    end
    inherited lblDeleted: TLabel
      Left = 903
      Top = 63
      ParentFont = True
      ExplicitLeft = 903
      ExplicitTop = 63
    end
    inherited btnCompleted: TDNMSpeedButton
      Left = 219
      Top = 70
      Glyph.Data = {00000000}
      NumGlyphs = 0
      ExplicitLeft = 219
      ExplicitTop = 70
    end
    inherited btnImport: TDNMSpeedButton
      Left = 326
      Top = 70
      HelpContext = 618004
      Enabled = False
      ExplicitLeft = 326
      ExplicitTop = 70
    end
    inherited btnExport: TDNMSpeedButton
      Left = 541
      Top = 70
      HelpContext = 618005
      Enabled = False
      ExplicitLeft = 541
      ExplicitTop = 70
    end
    inherited btnPrint: TDNMSpeedButton
      Left = 648
      Top = 70
      ExplicitLeft = 648
      ExplicitTop = 70
    end
    inherited btnClose: TDNMSpeedButton
      Left = 756
      Top = 70
      ExplicitLeft = 756
      ExplicitTop = 70
    end
    inherited edtReason: TDBMemo
      Left = 80
      Top = 7
      Width = 866
      HelpContext = 618003
      OnEnter = nil
      OnExit = nil
      ExplicitLeft = 80
      ExplicitTop = 7
      ExplicitWidth = 866
    end
    inherited chkDeleted: TwwCheckBox
      Left = 918
      Top = 81
      ExplicitLeft = 918
      ExplicitTop = 81
    end
    inherited chkApproved: TwwCheckBox
      Left = 14
      Top = 76
      TabOrder = 9
      ExplicitLeft = 14
      ExplicitTop = 76
    end
    object btnProcess: TDNMSpeedButton
      Left = 112
      Top = 70
      Width = 87
      Height = 27
      HelpContext = 618022
      Anchors = [akBottom]
      Caption = '&Process'
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
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = btnProcessClick
    end
    object btnLoadProducts: TDNMSpeedButton
      Left = 434
      Top = 70
      Width = 92
      Height = 27
      HelpContext = 618023
      Anchors = [akBottom]
      Caption = 'Load Products'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      AutoDisableParentOnclick = True
      OnClick = btnLoadProductsClick
    end
  end
  inherited DNMPanel1: TDNMPanel
    Width = 954
    HelpContext = 618010
    TabOrder = 0
    ExplicitWidth = 954
    DesignSize = (
      954
      137)
    inherited Bevel1: TBevel
      Height = 60
      HelpContext = 618011
      ExplicitHeight = 60
    end
    inherited Label160: TLabel
      Left = 833
      ParentFont = True
      ExplicitLeft = 833
    end
    inherited Label1: TLabel
      Width = 63
      Height = 15
      HelpContext = 618012
      ParentFont = True
      ExplicitWidth = 63
      ExplicitHeight = 15
    end
    inherited Label48: TLabel
      ParentFont = True
    end
    inherited lblStockDate: TLabel
      Width = 26
      Height = 15
      HelpContext = 618013
      ParentFont = True
      ExplicitWidth = 26
      ExplicitHeight = 15
    end
    inherited pnlTitle: TDNMPanel
      Width = 499
      HelpContext = 618014
      ExplicitWidth = 499
      inherited TitleShader: TShader
        Width = 495
        HelpContext = 618015
        ExplicitWidth = 495
        inherited TitleLabel: TLabel
          Width = 495
          HelpContext = 618016
          ExplicitWidth = 495
        end
      end
    end
    inherited txtCustomID: TDBEdit
      Left = 862
      HelpContext = 618002
      DataField = 'StockAdjustEntryID'
      DataSource = dsStockAdjustEntry
      ExplicitLeft = 862
    end
    inherited cboAccount: TwwDBLookupCombo
      AutoSize = True
    end
    inherited btnToggleMode: TDNMSpeedButton
      HelpContext = 618001
      Caption = '&Flat Mode'
      OnClick = btnToggleModeClick
    end
    inherited chkAdjustmentOnInstock: TwwCheckBox
      OnEnter = chkEnforceUOMEnter
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200B000440110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited qryStockAdjustEntry: TERPQuery
    AfterInsert = qryStockAdjustEntryAfterInsert
    object qryStockAdjustEntryProcessed: TWideStringField
      FieldName = 'Processed'
      Size = 1
    end
    object qryStockAdjustEntryAdjusttype: TWideStringField
      FieldName = 'Adjusttype'
      FixedChar = True
      Size = 5
    end
  end
  inherited dsStockAdjustEntry: TDataSource
    Left = 578
    Top = 337
  end
  inherited qryStockAdjustEntryLines: TERPQuery
    AfterInsert = qryStockAdjustEntryLinesAfterInsert
    inherited qryStockAdjustEntryLinesProductPrintName: TWideStringField
      DisplayLabel = 'Product Print Name'
    end
    inherited qryStockAdjustEntryLinesGlobalRef: TWideStringField
      DisplayLabel = 'Global Ref'
    end
    object qryStockAdjustEntryLinesAccountID: TIntegerField [40]
      FieldName = 'AccountID'
      Origin = 'tblstockadjustentrylines.AccountID'
    end
    object qryStockAdjustEntryLinesAccountName: TWideStringField [41]
      FieldName = 'AccountName'
      Origin = 'tblstockadjustentrylines.AccountName'
      Size = 255
    end
    object qryStockAdjustEntryLinesSerialnos: TWideMemoField [42]
      FieldName = 'Serialnos'
      Origin = 'tblstockadjustentrylines.Serialnos'
      BlobType = ftWideMemo
    end
    object qryStockAdjustEntryLinesBinid: TIntegerField [43]
      FieldName = 'Binid'
      Origin = 'tblstockadjustentrylines.Binid'
    end
  end
  inherited dsStockAdjustEntryLines: TDataSource
    Left = 750
    Top = 169
  end
  inherited cboProductQry: TERPQuery
    Left = 206
    Top = 159
  end
  inherited QryUOM: TERPQuery
    SQL.Strings = (
      '/*SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName, U.Pa' +
        'rtID'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND (ifnull(U.PartID,0) = :KeyId or U.Part' +
        'ID = 0) '
      'Group By U.UnitName '
      'Order By U.UnitName , UnitID desc'
      '*/'
      'SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName, U.Pa' +
        'rtID'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :KeyId'
      'union all '
      'SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName, U.Pa' +
        'rtID'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :KeyId )'
      'Order By UnitID desc ,UnitName;')
  end
  inherited cboEmployeeLookup: TERPQuery
    Left = 301
    Top = 302
  end
  inherited qryJob: TERPQuery
    SQL.Strings = (
      'SELECT ClientID AS JobId, Company, PrintName, JobNumber, JobName'
      #9'FROM tblClients'
      #9'WHERE IsJob = "T"'
      #9'ORDER BY Company')
    Left = 416
    Top = 240
  end
  object qryStockAdjustEntryProductLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tmp_saeProducts')
    BeforePost = qryStockAdjustEntryProductLinesBeforePost
    OnCalcFields = qryStockAdjustEntryProductLinesCalcFields
    Left = 591
    Top = 236
    object qryStockAdjustEntryProductLinesPRODUCTNAME: TWideStringField
      DisplayLabel = 'Product~Name'
      DisplayWidth = 20
      FieldName = 'PRODUCTNAME'
      Origin = 'tmp_saeProducts.ProductName'
      Size = 255
    end
    object qryStockAdjustEntryProductLinesDESCRIPTION: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 20
      FieldName = 'DESCRIPTION'
      Origin = 'tmp_saeProducts.Description'
      Size = 255
    end
    object qryStockAdjustEntryProductLinesCLASSNAME: TWideStringField
      DisplayLabel = 'Class Name'
      DisplayWidth = 20
      FieldName = 'CLASSNAME'
      Origin = 'tmp_saeProducts.ClassName'
      Size = 255
    end
    object qryStockAdjustEntryProductLinesAccountName: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 20
      FieldName = 'AccountName'
      Origin = 'tmp_saeProducts.AccountName'
      Size = 255
    end
    object qryStockAdjustEntryProductLinesAVAILABLEUOMQTY: TFloatField
      DisplayLabel = 'Available'
      DisplayWidth = 10
      FieldName = 'AVAILABLEUOMQTY'
      Origin = 'tmp_saeProducts.AvailableUOMQty'
    end
    object qryStockAdjustEntryProductLinesFINALUOMQTY: TFloatField
      DisplayLabel = 'Final'
      DisplayWidth = 10
      FieldName = 'FINALUOMQTY'
      Origin = 'tmp_saeProducts.FinalUOMQty'
    end
    object qryStockAdjustEntryProductLinesADJUSTUOMQTY: TFloatField
      DisplayLabel = 'Adjust'
      DisplayWidth = 10
      FieldName = 'ADJUSTUOMQTY'
      Origin = 'tmp_saeProducts.AdjustUOMQty'
    end
    object qryStockAdjustEntryProductLinesInStockUOMQty: TFloatField
      DisplayLabel = 'In-Stock'
      DisplayWidth = 10
      FieldName = 'InStockUOMQty'
    end
    object qryStockAdjustEntryProductLinesCOST: TFloatField
      DisplayLabel = 'Cost'
      DisplayWidth = 10
      FieldName = 'COST'
      Origin = 'tmp_saeProducts.Cost'
      DisplayFormat = '$,0.00###'
    end
    object qryStockAdjustEntryProductLinesUOM: TWideStringField
      DisplayLabel = 'Uom'
      DisplayWidth = 10
      FieldName = 'UOM'
      Origin = 'tmp_saeProducts.UOM'
      Size = 50
    end
    object qryStockAdjustEntryProductLinesUOMMULTIPLIER: TFloatField
      DisplayLabel = 'Multiplier'
      DisplayWidth = 10
      FieldName = 'UOMMULTIPLIER'
      Origin = 'tmp_saeProducts.UOMMultiplier'
    end
    object qryStockAdjustEntryProductLinesPQAAllocation: TWideStringField
      DisplayLabel = 'Allocation'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'PQAAllocation'
      Calculated = True
    end
    object qryStockAdjustEntryProductLinesUOMCost: TFloatField
      DisplayLabel = 'UOM Cost'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOMCost'
      DisplayFormat = '$,0.00###'
      Calculated = True
    end
    object qryStockAdjustEntryProductLinesTotalcost: TFloatField
      DisplayLabel = 'Total Cost'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'Totalcost'
      DisplayFormat = '$,0.00###'
      Calculated = True
    end
    object qryStockAdjustEntryProductLinesPartBarcode: TWideStringField
      DisplayLabel = 'Product~Bar Code'
      DisplayWidth = 20
      FieldName = 'PartBarcode'
      Size = 255
    end
    object qryStockAdjustEntryProductLinesMatrixDesc: TWideMemoField
      DisplayLabel = 'Desc'
      DisplayWidth = 10
      FieldName = 'MatrixDesc'
      BlobType = ftWideMemo
    end
    object qryStockAdjustEntryProductLinesMatrixRef: TWideMemoField
      DisplayLabel = 'Ref'
      DisplayWidth = 10
      FieldName = 'MatrixRef'
      BlobType = ftWideMemo
    end
    object qryStockAdjustEntryProductLinesMatrixPrice: TFloatField
      DisplayLabel = 'Price'
      DisplayWidth = 10
      FieldName = 'MatrixPrice'
      DisplayFormat = '$,0.00###'
    end
    object qryStockAdjustEntryProductLinesFormulaQtyValue1: TFloatField
      DisplayLabel = 'Value 1'
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue1'
    end
    object qryStockAdjustEntryProductLinesFormulaQtyValue2: TFloatField
      DisplayLabel = 'Value 2'
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue2'
    end
    object qryStockAdjustEntryProductLinesParttype: TWideStringField
      DisplayLabel = 'Part Type'
      DisplayWidth = 13
      FieldName = 'Parttype'
      Size = 13
    end
    object qryStockAdjustEntryProductLinesFormulaQtyValue3: TFloatField
      DisplayLabel = 'Value 3'
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue3'
    end
    object qryStockAdjustEntryProductLinesFormulaQtyValue4: TFloatField
      DisplayLabel = 'Value 4'
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue4'
    end
    object qryStockAdjustEntryProductLinesFormulaQtyValue5: TFloatField
      DisplayLabel = 'Value 5'
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue5'
    end
    object qryStockAdjustEntryProductLinesFormulaQtyValue: TFloatField
      DisplayLabel = 'Value'
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue'
    end
    object qryStockAdjustEntryProductLinesNotes: TWideStringField
      DisplayWidth = 20
      FieldName = 'Notes'
      Size = 255
    end
    object qryStockAdjustEntryProductLinesProductPrintName: TWideStringField
      DisplayLabel = 'Product~Print Name'
      DisplayWidth = 20
      FieldName = 'ProductPrintName'
      Size = 255
    end
    object qryStockAdjustEntryProductLinesJobName: TWideStringField
      DisplayLabel = 'Customer Job'
      DisplayWidth = 20
      FieldName = 'JobName'
      Visible = False
      Size = 50
    end
    object qryStockAdjustEntryProductLinesGLOBALREF: TWideStringField
      DisplayWidth = 255
      FieldName = 'GLOBALREF'
      Origin = 'tmp_saeProducts.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryStockAdjustEntryProductLinesSTOCKADJUSTENTRYLINESID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'STOCKADJUSTENTRYLINESID'
      Origin = 'tmp_saeProducts.StockAdjustEntryLinesID'
      Visible = False
    end
    object qryStockAdjustEntryProductLinesSTOCKADJUSTENTRYID: TIntegerField
      DisplayWidth = 10
      FieldName = 'STOCKADJUSTENTRYID'
      Origin = 'tmp_saeProducts.StockAdjustEntryID'
      Visible = False
    end
    object qryStockAdjustEntryProductLinesPRODUCTID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PRODUCTID'
      Origin = 'tmp_saeProducts.ProductID'
      Visible = False
    end
    object qryStockAdjustEntryProductLinesCLASSID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CLASSID'
      Origin = 'tmp_saeProducts.ClassID'
      Visible = False
    end
    object qryStockAdjustEntryProductLinesAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AccountID'
      Origin = 'tmp_saeProducts.AccountID'
      Visible = False
    end
    object qryStockAdjustEntryProductLinesAVAILABLEQTY: TFloatField
      DisplayWidth = 10
      FieldName = 'AVAILABLEQTY'
      Origin = 'tmp_saeProducts.AvailableQty'
      Visible = False
    end
    object qryStockAdjustEntryProductLinesFINALQTY: TFloatField
      DisplayWidth = 10
      FieldName = 'FINALQTY'
      Origin = 'tmp_saeProducts.FinalQty'
      Visible = False
    end
    object qryStockAdjustEntryProductLinesADJUSTQTY: TFloatField
      DisplayWidth = 10
      FieldName = 'ADJUSTQTY'
      Origin = 'tmp_saeProducts.AdjustQty'
      Visible = False
    end
    object qryStockAdjustEntryProductLinesDELETED: TWideStringField
      DisplayWidth = 1
      FieldName = 'DELETED'
      Origin = 'tmp_saeProducts.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryStockAdjustEntryProductLinesUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tmp_saeProducts.UOMID'
      Visible = False
    end
    object qryStockAdjustEntryProductLinesMSTIMESTAMP: TDateTimeField
      DisplayWidth = 18
      FieldName = 'MSTIMESTAMP'
      Origin = 'tmp_saeProducts.msTimeStamp'
      Visible = False
    end
    object qryStockAdjustEntryProductLinesInStockQty: TFloatField
      DisplayLabel = 'In-Stock'
      DisplayWidth = 10
      FieldName = 'InStockQty'
      Origin = 'tmp_saeProducts.`In-StockQty`'
      Visible = False
    end
    object qryStockAdjustEntryProductLinesJobID: TIntegerField
      DisplayWidth = 10
      FieldName = 'JobID'
      Visible = False
    end
  end
  object dsStockAdjustEntryProductLines: TDataSource
    DataSet = qryStockAdjustEntryProductLines
    Left = 766
    Top = 257
  end
end
