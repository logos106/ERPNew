inherited fmImportStockAdjustment: TfmImportStockAdjustment
  Left = 278
  Top = 164
  HelpContext = 1215002
  Caption = 'Import Stock Adjustment'
  ExplicitLeft = 278
  ExplicitTop = 164
  PixelsPerInch = 96
  TextHeight = 15
  inherited pnlGrid: TDNMPanel
    Top = 128
    Height = 387
    HelpContext = 1215003
    ExplicitTop = 128
    ExplicitHeight = 436
    object RadioGroup1: TRadioGroup [0]
      Left = 0
      Top = 159
      Width = 997
      Height = 39
      HelpContext = 1215004
      Columns = 2
      Items.Strings = (
        'Stock Take'
        
          'Ignore Bin / Batch / Serial Number Product , if all combined in ' +
          'the spreadsheet')
      TabOrder = 3
      Visible = False
    end
    object DNMPanel2: TDNMPanel [1]
      Left = 421
      Top = 176
      Width = 577
      Height = 211
      HelpContext = 1215005
      Align = alClient
      BevelEdges = []
      BevelOuter = bvNone
      BorderWidth = 1
      BorderStyle = bsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ExplicitTop = 181
      ExplicitHeight = 205
      object lblIgnoreIncompleteallocation: TLabel
        AlignWithMargins = True
        Left = 21
        Top = 21
        Width = 550
        Height = 111
        HelpContext = 1215007
        Margins.Left = 20
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = 'Details changed at run time '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 133
        ExplicitHeight = 14
      end
      object chkIgnorebinbatchProducts: TCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 1
        Width = 565
        Height = 19
        HelpContext = 1215008
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Ignore Bin / Batch / Serial Number Product , if all combined in ' +
          'the spreadsheet ?'
        TabOrder = 0
        OnClick = chkIgnorebinbatchProductsClick
      end
      object DNMPanel3: TDNMPanel
        AlignWithMargins = True
        Left = 2
        Top = 134
        Width = 569
        Height = 71
        HelpContext = 1215014
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alBottom
        BevelEdges = []
        BevelOuter = bvNone
        BorderWidth = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        ExplicitTop = 133
        object Shape1: TShape
          Left = 1
          Top = 1
          Width = 567
          Height = 1
          HelpContext = 1215032
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Brush.Style = bsClear
          Pen.Color = clGray
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 569
        end
        object Label7: TLabel
          AlignWithMargins = True
          Left = 2
          Top = 24
          Width = 565
          Height = 45
          HelpContext = 1215016
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          Caption = 
            'The '#39'Finalcount'#39' of the Product  and '#39'Allocfinalcount'#39' of the Bi' +
            'n/Batch/Serial number is counted for the date given above. The a' +
            'djustment is calculated on basis of Product'#39's '#39'In-Stock'#39' Quantit' +
            'y as on this date. Any transaction after this date will stay as ' +
            'it is.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          ExplicitWidth = 551
          ExplicitHeight = 42
        end
        object Label6: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 5
          Width = 561
          Height = 15
          HelpContext = 1215017
          Align = alTop
          Caption = 'Adjustment Date'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 94
        end
        object dtAdjustmentDate: TwwDBDateTimePicker
          Left = 108
          Top = 2
          Width = 163
          Height = 23
          HelpContext = 1215018
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'Tahoma'
          CalendarAttributes.Font.Style = []
          Date = 40060.000000000000000000
          Epoch = 1950
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 0
        end
      end
    end
    inherited grdMap: TAdvStringGrid
      Height = 176
      HelpContext = 1215009
      Align = alTop
      ExplicitHeight = 176
    end
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = 176
      Width = 421
      Height = 211
      HelpContext = 1215010
      Align = alLeft
      BevelEdges = []
      BevelOuter = bvNone
      BorderWidth = 1
      BorderStyle = bsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object lblStockTakeNote: TLabel
        AlignWithMargins = True
        Left = 2
        Top = 21
        Width = 413
        Height = 184
        HelpContext = 1215012
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = 
          'When imported, a STOCK TAKE will delete all the AVAILABLE(Column' +
          ') stock of the Products/Departments in the spreadsheet and will ' +
          'make the AVAILABLE(column) stock the same as the Spreadsheet.   ' +
          'It will ignore any Product/Department that is not in the spreads' +
          'heet.  All Serial Numbers , Bins and Batches will be removed and' +
          ' replaced with whats on the Spreadsheet.  ie, ERP has 8 Serial N' +
          'umbers, Spread sheet has 5 different Serial Numbers, ERP will be' +
          ' adjusted to 5 Serial Numbers as per the spreadsheet.    When no' +
          't a Stock Take, It will ignore any Product/Department that is no' +
          't in the spreadsheet.  All Serial Numbers , Bins and Batches wil' +
          'l remain and will be added to based on whats on the Spreadsheet.' +
          '  ie, ERP has 8 Serial Numbers, Spread sheet has 5 different Ser' +
          'ial Numbers, ERP will be adjusted to 13 unique Serial Numbers.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        ExplicitHeight = 154
      end
      object chkStockTake: TCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 2
        Width = 401
        Height = 17
        HelpContext = 1215013
        Margins.Top = 1
        Margins.Right = 11
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Stock Take? '
        TabOrder = 0
        OnClick = chkStockTakeClick
      end
    end
  end
  inherited pnlFooter: TDNMPanel
    HelpContext = 1215033
    inherited btnNew: TDNMSpeedButton
      Enabled = False
    end
  end
  inherited pnlTop: TDNMPanel
    Height = 128
    HelpContext = 1215019
    ExplicitLeft = -1
    ExplicitHeight = 128
    DesignSize = (
      998
      128)
    inherited Name: TLabel
      Left = 11
      Top = 9
      Enabled = False
      Visible = False
      ExplicitLeft = 11
      ExplicitTop = 9
    end
    inherited Label1: TLabel
      Left = 756
      Top = 9
      Enabled = False
      Visible = False
      ExplicitLeft = 756
      ExplicitTop = 9
    end
    inherited Label2: TLabel
      Left = 6
      Top = 46
      ExplicitLeft = 6
      ExplicitTop = 46
    end
    inherited Label3: TLabel
      Left = 831
      Top = 68
      ExplicitLeft = 831
      ExplicitTop = 68
    end
    inherited lblColumnCount: TLabel
      Left = 828
      Top = 104
      ExplicitLeft = 828
      ExplicitTop = 104
    end
    inherited Label4: TLabel
      Left = 54
      Top = 9
      Enabled = False
      Visible = False
      ExplicitLeft = 54
      ExplicitTop = 9
    end
    inherited pnlTitle: TDNMPanel
      Left = 318
      Width = 361
      HelpContext = 1215020
      Anchors = [akLeft]
      ExplicitLeft = 318
      ExplicitWidth = 361
      inherited TitleShader: TShader
        Width = 359
        HelpContext = 1215021
        ExplicitWidth = 359
        inherited TitleLabel: TLabel
          Width = 359
          HelpContext = 1215022
          Caption = 'Import Stock Adjustment'
          ExplicitWidth = 359
        end
      end
    end
    inherited edtName: TwwDBEdit
      Left = 50
      Top = 6
      Width = 327
      HelpContext = 1215023
      Enabled = False
      ReadOnly = True
      Visible = False
      ExplicitLeft = 50
      ExplicitTop = 6
      ExplicitWidth = 327
    end
    inherited cboImportType: TwwDBComboBox
      Left = 829
      Top = 6
      Width = 120
      HelpContext = 1215024
      Enabled = False
      ReadOnly = True
      Visible = False
      ExplicitLeft = 829
      ExplicitTop = 6
      ExplicitWidth = 120
    end
    inherited edtImportFileName: TwwDBEdit
      Left = 6
      Top = 64
      Width = 390
      HelpContext = 1215025
      ExplicitLeft = 6
      ExplicitTop = 64
      ExplicitWidth = 390
    end
    inherited chkFirstLineNames: TwwCheckBox
      Left = 6
      Top = 101
      Width = 201
      HelpContext = 1215026
      ExplicitLeft = 6
      ExplicitTop = 101
      ExplicitWidth = 201
    end
    inherited btnRefresh: TDNMSpeedButton
      Left = 342
      Top = 96
      ExplicitLeft = 342
      ExplicitTop = 96
    end
    inherited rgSeparatorType: TwwRadioGroup
      Left = 435
      Top = 53
      Width = 108
      Height = 70
      HelpContext = 1215027
      Columns = 1
      ExplicitLeft = 435
      ExplicitTop = 53
      ExplicitWidth = 108
      ExplicitHeight = 70
    end
    inherited rgSeparatorValue: TwwRadioGroup
      Left = 548
      Top = 53
      Width = 275
      HelpContext = 1215028
      ExplicitLeft = 548
      ExplicitTop = 53
      ExplicitWidth = 275
    end
    inherited edtSeparator: TEdit
      Left = 729
      Top = 93
      ExplicitLeft = 729
      ExplicitTop = 93
    end
    inherited cboTextDelimiter: TComboBox
      Left = 911
      Top = 64
      Width = 82
      HelpContext = 1215029
      ExplicitLeft = 911
      ExplicitTop = 64
      ExplicitWidth = 82
    end
    inherited edtColumnCount: TAdvEdit
      Left = 911
      Top = 100
      Width = 82
      HelpContext = 1215030
      ExplicitLeft = 911
      ExplicitTop = 100
      ExplicitWidth = 82
    end
    inherited btnFile: TDNMSpeedButton
      Left = 399
      Top = 64
      ExplicitLeft = 399
      ExplicitTop = 64
    end
    object chkAdjustmentOnInstock: TCheckBox
      Left = 786
      Top = 10
      Width = 204
      Height = 16
      HelpContext = 1215031
      Alignment = taLeftJustify
      Caption = 'Adjustment on In-Stock Quantity'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      Visible = False
    end
  end
  inherited MyConnection: TERPConnection
    Server = 'Localhost'
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200C800F80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object Qrystockadjustmentimportexport: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblstockadjustmentimportexport')
    Left = 213
    Top = 290
    object QrystockadjustmentimportexportAdjID: TIntegerField
      FieldName = 'AdjID'
    end
    object QrystockadjustmentimportexportDepartmentID: TIntegerField
      FieldName = 'DepartmentID'
    end
    object QrystockadjustmentimportexportUOMID: TIntegerField
      FieldName = 'UOMID'
    end
    object QrystockadjustmentimportexportUOM: TWideStringField
      FieldName = 'UOM'
      Size = 50
    end
    object QrystockadjustmentimportexportUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
    end
    object QrystockadjustmentimportexportPartsId: TIntegerField
      FieldName = 'PartsId'
    end
    object QrystockadjustmentimportexportgLevel: TLargeintField
      FieldName = 'gLevel'
    end
    object QrystockadjustmentimportexportProductName: TWideStringField
      FieldName = 'ProductName'
      Size = 60
    end
    object QrystockadjustmentimportexportProductColumn1: TWideStringField
      FieldName = 'ProductColumn1'
      Size = 255
    end
    object QrystockadjustmentimportexportProductColumn2: TWideStringField
      FieldName = 'ProductColumn2'
      Size = 255
    end
    object QrystockadjustmentimportexportProductColumn3: TWideStringField
      FieldName = 'ProductColumn3'
      Size = 255
    end
    object QrystockadjustmentimportexportPartsDescription: TWideStringField
      FieldName = 'PartsDescription'
      Size = 255
    end
    object QrystockadjustmentimportexportDeptName: TWideStringField
      FieldName = 'DeptName'
      Size = 255
    end
    object QrystockadjustmentimportexportAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 255
    end
    object QrystockadjustmentimportexportAccountGroup: TWideStringField
      FieldName = 'AccountGroup'
      Size = 255
    end
    object QrystockadjustmentimportexportBatchnumber: TWideStringField
      FieldName = 'Batchnumber'
      Size = 100
    end
    object QrystockadjustmentimportexportExpiryDate: TWideStringField
      FieldName = 'ExpiryDate'
      Size = 10
    end
    object QrystockadjustmentimportexportBatchExpiryDate: TDateTimeField
      FieldName = 'BatchExpiryDate'
    end
    object QrystockadjustmentimportexportBinlocation: TWideStringField
      FieldName = 'Binlocation'
      Size = 30
    end
    object QrystockadjustmentimportexportBinnumber: TWideStringField
      FieldName = 'Binnumber'
      Size = 30
    end
    object QrystockadjustmentimportexportSerialnumber: TWideStringField
      FieldName = 'Serialnumber'
      Size = 100
    end
    object QrystockadjustmentimportexportUOMQty: TFloatField
      FieldName = 'UOMQty'
    end
    object QrystockadjustmentimportexportFinalcount: TFloatField
      FieldName = 'Finalcount'
    end
    object QrystockadjustmentimportexportAllocFinalcount: TFloatField
      FieldName = 'AllocFinalcount'
    end
    object QrystockadjustmentimportexportQty: TFloatField
      FieldName = 'Qty'
    end
    object QrystockadjustmentimportexportInstockUOMQty: TFloatField
      FieldName = 'InstockUOMQty'
    end
    object QrystockadjustmentimportexportInstockQty: TFloatField
      FieldName = 'InstockQty'
    end
    object QrystockadjustmentimportexportCost: TFloatField
      FieldName = 'Cost'
    end
    object QrystockadjustmentimportexportValue: TFloatField
      FieldName = 'Value'
    end
    object QrystockadjustmentimportexportActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object QrystockadjustmentimportexportSeqno: TIntegerField
      FieldName = 'Seqno'
    end
    object QrystockadjustmentimportexportProductBarCode: TWideStringField
      FieldName = 'ProductBarCode'
      Size = 255
    end
    object QrystockadjustmentimportexportQtyType: TWideStringField
      FieldName = 'QtyType'
      FixedChar = True
      Size = 1
    end
    object QrystockadjustmentimportexportTruckLoadNo: TWideStringField
      FieldName = 'TruckLoadNo'
      Size = 10
    end
  end
  object dsstockadjustmentimportexport: TDataSource
    DataSet = Qrystockadjustmentimportexport
    Left = 213
    Top = 320
  end
end
