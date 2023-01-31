inherited PQAMismatchDetailsGUI: TPQAMismatchDetailsGUI
  Left = 183
  Top = 288
  Caption = 'PQA Mismatch Details'
  ExplicitLeft = 183
  ExplicitTop = 288
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 842001
  inherited FooterPanel: TDnMPanel
    HelpContext = 842004
    inherited cmdNew: TDNMSpeedButton
      Left = 523
      ExplicitLeft = 523
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 660
      ExplicitLeft = 660
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 249
      ExplicitLeft = 249
    end
    object btndelete: TDNMSpeedButton
      Left = 386
      Top = 32
      Width = 87
      Height = 27
      Hint = '"Export The List To An Excel Spreadsheet"'
      Anchors = [akBottom]
      Caption = 'Delete PQA'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      TabStop = False
      OnClick = btndeleteClick
      HelpContext = 842002
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 842005
    inherited pnlHeader: TPanel
      HelpContext = 842006
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'PQA Mismatch Details'
          HelpContext = 842003
        end
      end
    end
  end
  inherited Panel1: TPanel
    HelpContext = 842007
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'IsBO;CheckBox;T;F')
      Selected.Strings = (
        'TransID'#9'10'#9'Trans ID'
        'TransLineID'#9'10'#9'Trans~Line ID'
        'TransType'#9'15'#9'Trans~Type'
        'TransDate'#9'12'#9'Trans~Date'
        'Alloctype'#9'6'#9'Alloc~Type'
        'IsBO'#9'5'#9'Is BO?'
        'Qty'#9'10'#9'Qty'
        'UOMQty'#9'10'#9'UOM Qty'
        'UOM'#9'15'#9'UOM'
        'UOMMultiplier'#9'10'#9'UOM Multiplier'
        'ProductName'#9'15'#9'Product'
        'Active'#9'1'#9'Active')
      TitleLines = 2
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select * from tblPQa '
      'where TRansId =:TransId'
      'and TransLineId = :TransLineId'
      'and Transtype = :Transtype')
    Active = True
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TransId'
      end
      item
        DataType = ftUnknown
        Name = 'TransLineId'
      end
      item
        DataType = ftUnknown
        Name = 'Transtype'
      end>
    object qryMainTransID: TLargeintField
      DisplayLabel = 'Trans ID'
      DisplayWidth = 10
      FieldName = 'TransID'
      Origin = 'tblpqa.TransID'
    end
    object qryMainTransLineID: TIntegerField
      DisplayLabel = 'Trans~Line ID'
      DisplayWidth = 10
      FieldName = 'TransLineID'
      Origin = 'tblpqa.TransLineID'
    end
    object qryMainTransType: TWideStringField
      DisplayLabel = 'Trans~Type'
      DisplayWidth = 15
      FieldName = 'TransType'
      Origin = 'tblpqa.TransType'
      Size = 50
    end
    object qryMainTransDate: TDateTimeField
      DisplayLabel = 'Trans~Date'
      DisplayWidth = 12
      FieldName = 'TransDate'
      Origin = 'tblpqa.TransDate'
    end
    object qryMainAlloctype: TWideStringField
      DisplayLabel = 'Alloc~Type'
      DisplayWidth = 6
      FieldName = 'Alloctype'
      Origin = 'tblpqa.Alloctype'
      Size = 3
    end
    object qryMainIsBO: TWideStringField
      DisplayLabel = 'Is BO?'
      DisplayWidth = 5
      FieldName = 'IsBO'
      Origin = 'tblpqa.IsBO'
      FixedChar = True
      Size = 1
    end
    object qryMainQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblpqa.Qty'
    end
    object qryMainUOMQty: TFloatField
      DisplayLabel = 'UOM Qty'
      DisplayWidth = 10
      FieldName = 'UOMQty'
      Origin = 'tblpqa.UOMQty'
    end
    object qryMainUOM: TWideStringField
      DisplayWidth = 15
      FieldName = 'UOM'
      Origin = 'tblpqa.UOM'
      Size = 50
    end
    object qryMainUOMMultiplier: TFloatField
      DisplayLabel = 'UOM Multiplier'
      DisplayWidth = 10
      FieldName = 'UOMMultiplier'
      Origin = 'tblpqa.UOMMultiplier'
    end
    object qryMainProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 15
      FieldName = 'ProductName'
      Origin = 'tblpqa.ProductName'
      Size = 100
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblpqa.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblpqa.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainPQAID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PQAID'
      Origin = 'tblpqa.PQAID'
      Visible = False
    end
    object qryMainUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tblpqa.UOMID'
      Visible = False
    end
    object qryMainDepartmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DepartmentID'
      Origin = 'tblpqa.DepartmentID'
      Visible = False
    end
    object qryMainProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblpqa.ProductID'
      Visible = False
    end
    object qryMainReserved: TWideStringField
      DisplayWidth = 1
      FieldName = 'Reserved'
      Origin = 'tblpqa.Reserved'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblpqa.msTimeStamp'
      Visible = False
    end
    object qryMainMatrixRef: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixRef'
      Origin = 'tblpqa.MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
  end
end
