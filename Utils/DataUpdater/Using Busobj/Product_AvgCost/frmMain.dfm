inherited fmMain: TfmMain
  Left = 1417
  Top = 108
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'ERP Data Update'
  ClientHeight = 610
  ClientWidth = 877
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 877
  end
  inherited pnlBottom: TPanel
    Top = 560
    Width = 877
    object Label2: TLabel [0]
      Left = 129
      Top = 16
      Width = 55
      Height = 20
      Anchors = [akLeft, akBottom]
      Caption = 'Label2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    inherited btnStartUpdate: TDNMSpeedButton
      Anchors = [akLeft, akBottom]
    end
  end
  inherited pnlLeft: TPanel
    Height = 455
  end
  inherited pnlRight: TPanel
    Left = 860
    Height = 455
  end
  inherited memLog: TMemo
    Width = 336
    Height = 455
    Align = alLeft
    OnDblClick = memLogDblClick
  end
  object grdInvalidTrans: TwwDBGrid [5]
    Left = 353
    Top = 105
    Width = 507
    Height = 455
    Selected.Strings = (
      'PartsId'#9'10'#9'PartsId'#9#9
      'PartName'#9'35'#9'PartName'#9'F'
      'tmp_7489Fix_AvgCost'#9'15'#9'Clean AvgCost'#9'F'
      'AvgCost'#9'15'#9'AvgCost'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dsInvalidTrans
    TabOrder = 5
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleLines = 2
    TitleButtons = False
    UseTFields = False
    Visible = False
    OnCalcCellColors = grdInvalidTransCalcCellColors
  end
  inherited DbConn: TMyConnection
    Port = 3309
    Username = 'P_One'
    Password = '1w$p&LD07'
  end
  object InvalidTrans: TMyQuery
    Connection = DbConn
    SQL.Strings = (
      
        'select PartsId, Partname, AvgCost  , tmp_7489Fix_AvgCost from tb' +
        'lParts where parttype = "INV"')
    AutoCalcFields = False
    Left = 320
    Top = 56
    object InvalidTransPartsId: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'PartsId'
      Origin = 'tblParts.PARTSID'
    end
    object InvalidTransPartName: TStringField
      FieldName = 'PartName'
      Origin = 'tblParts.PARTNAME'
      Size = 60
    end
    object InvalidTranstmp_7489Fix_AvgCost: TFloatField
      FieldName = 'tmp_7489Fix_AvgCost'
      Origin = 'tblParts.tmp_7489Fix_AvgCost'
      currency = True
    end
    object InvalidTransAvgCost: TFloatField
      FieldName = 'AvgCost'
      Origin = 'tblParts.AvgCost'
      currency = True
    end
  end
  object dsInvalidTrans: TDataSource
    DataSet = InvalidTrans
    Left = 352
    Top = 56
  end
end
