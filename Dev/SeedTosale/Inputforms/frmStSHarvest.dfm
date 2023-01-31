inherited fmStSHarvest: TfmStSHarvest
  Left = 132
  Top = 153
  Caption = 'Seed To Sale - Harvest'
  ClientHeight = 639
  ClientWidth = 644
  ExplicitLeft = 132
  ExplicitTop = 153
  ExplicitWidth = 660
  ExplicitHeight = 678
  DesignSize = (
    644
    639)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 550
    Width = 644
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 77
    Top = 10
    ExplicitLeft = 49
    ExplicitTop = 10
  end
  inherited imgGridWatermark: TImage
    Left = 305
    Top = 10
    ExplicitLeft = 305
    ExplicitTop = 10
  end
  inherited shapehintextra1: TShape
    Left = 168
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  inherited pnlFooter: TDNMPanel
    Top = 596
    Width = 644
    ExplicitTop = 596
    ExplicitWidth = 644
    DesignSize = (
      644
      43)
    inherited btnCompleted: TDNMSpeedButton
      Left = 202
      OnClick = btnCompletedClick
      ExplicitLeft = 202
    end
    inherited btnClose: TDNMSpeedButton
      Left = 356
      OnClick = btnCloseClick
      ExplicitLeft = 356
    end
  end
  inherited pnlHeader: TDNMPanel
    Width = 644
    ExplicitWidth = 644
    DesignSize = (
      644
      57)
    inherited pnlTitle: TDNMPanel
      Left = 185
      Width = 275
      ExplicitLeft = 185
      ExplicitWidth = 275
      inherited TitleShader: TShader
        Width = 273
        ExplicitWidth = 273
        inherited TitleLabel: TLabel
          Width = 273
          Caption = 'Harvest'
          ExplicitLeft = 2
          ExplicitTop = 4
          ExplicitWidth = 419
        end
      end
    end
  end
  inherited pnlDetails: TDNMPanel
    Top = 201
    Width = 644
    Height = 349
    ExplicitTop = 201
    ExplicitWidth = 644
    ExplicitHeight = 349
    object grdHarvestLines: TwwDBGrid
      AlignWithMargins = True
      Left = 45
      Top = 12
      Width = 554
      Height = 325
      Margins.Left = 44
      Margins.Top = 11
      Margins.Right = 44
      Margins.Bottom = 11
      Selected.Strings = (
        'StsTag'#9'60'#9'Plant (Tag)'
        'UOMQty'#9'13'#9'Weight')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnRowChanged = grdHarvestLinesRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsStSHarvestLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnCalcCellColors = grdHarvestLinesCalcCellColors
      OnColEnter = grdHarvestLinesColEnter
      OnEnter = grdHarvestLinesEnter
      FooterCellColor = clWhite
    end
  end
  object pnlHarvestsummary: TDNMPanel [8]
    Left = 0
    Top = 550
    Width = 644
    Height = 46
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label3: TLabel
      Left = 407
      Top = 16
      Width = 70
      Height = 15
      Alignment = taRightJustify
      Caption = 'Total Weight'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object txtUOM: TDBText
      Left = 583
      Top = 15
      Width = 87
      Height = 17
      DataField = 'UOM'
      DataSource = dsStSHarvest
    end
    object Label7: TLabel
      Left = 48
      Top = 16
      Width = 43
      Height = 15
      Alignment = taRightJustify
      Caption = 'Packed'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object edtTotalQty: TwwDBEdit
      Left = 483
      Top = 12
      Width = 95
      Height = 23
      TabStop = False
      DataField = 'TotalQty'
      DataSource = dsStSHarvest
      ReadOnly = True
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit1: TwwDBEdit
      Left = 97
      Top = 6
      Width = 71
      Height = 23
      TabStop = False
      DataField = 'PackedQty'
      DataSource = dsStSHarvest
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      Visible = False
      WantReturns = False
      WordWrap = False
    end
    object wwCheckBox1: TwwCheckBox
      Left = 158
      Top = 15
      Width = 69
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Done ? '
      DataField = 'Done'
      DataSource = dsStSHarvest
      TabOrder = 2
      Visible = False
    end
  end
  object pnlHarvestHeader: TDNMPanel [9]
    Left = 0
    Top = 159
    Width = 644
    Height = 42
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label4: TLabel
      AlignWithMargins = True
      Left = 45
      Top = 13
      Width = 33
      Height = 15
      Caption = 'Room'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 314
      Top = 13
      Width = 116
      Height = 15
      Caption = 'Weight Measured in '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object wwDBLookupCombo1: TwwDBLookupCombo
      Left = 84
      Top = 9
      Width = 163
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'bindetails'#9'61'#9'bindetails'#9'F')
      DataField = 'BinID'
      DataSource = dsStSHarvest
      LookupTable = qrybins
      LookupField = 'binid'
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboUOM: TwwDBLookupCombo
      Left = 436
      Top = 9
      Width = 163
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'UnitName'#9'15'#9'UnitName'#9'F'
        'Multiplier'#9'10'#9'Multiplier'#9'F')
      DataField = 'UOM'
      DataSource = dsStSHarvest
      LookupTable = QryUOM
      LookupField = 'UnitName'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  object pnlTagSelection: TDNMPanel [10]
    Left = 0
    Top = 57
    Width = 644
    Height = 102
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object Label6: TLabel
      AlignWithMargins = True
      Left = 194
      Top = 5
      Width = 105
      Height = 15
      Margins.Left = 33
      Margins.Top = 8
      Caption = 'Scan the Plant Tag'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 7
      Top = 5
      Width = 80
      Height = 15
      Margins.Top = 8
      Caption = 'Harvest Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 7
      Top = 54
      Width = 73
      Height = 15
      Margins.Left = 44
      Caption = 'Harvest Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtBarcode: TEdit
      AlignWithMargins = True
      Left = 193
      Top = 22
      Width = 315
      Height = 72
      Margins.Top = 4
      Margins.Bottom = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -55
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Text = 'edtBarcode'
      OnExit = edtBarcodeExit
      OnKeyDown = edtBarcodeKeyDown
      OnKeyPress = edtBarcodeKeyPress
    end
    object cboProductname: TwwDBEdit
      Left = 7
      Top = 22
      Width = 165
      Height = 23
      TabStop = False
      DataField = 'HarvestName'
      DataSource = dsStSHarvest
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object dtUsedOn: TwwDBDateTimePicker
      Left = 7
      Top = 71
      Width = 163
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      DataField = 'HarvestDate'
      DataSource = dsStSHarvest
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 266
    Top = 397
  end
  inherited tmrdelay: TTimer
    Left = 229
    Top = 397
  end
  inherited popSpelling: TPopupMenu
    Left = 294
    Top = 365
  end
  inherited tmrdelayMsg: TTimer
    Left = 192
    Top = 397
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 328
    Top = 365
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 464
    Top = 365
  end
  inherited MyConnection: TERPConnection
    Database = 'sts_1'
    Server = 'localhost'
    Connected = True
    Left = 192
    Top = 365
  end
  inherited DataState: TDataState
    Left = 396
    Top = 365
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 498
    Top = 365
  end
  inherited imgsort: TImageList
    Left = 430
    Top = 365
    Bitmap = {
      494C010102009400040110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryCustomField: TERPQuery
    Left = 260
    Top = 365
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 567
    Top = 365
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 362
    Top = 365
  end
  inherited qryMemTrans: TERPQuery
    Left = 226
    Top = 365
  end
  inherited tmrOnshow: TTimer
    Left = 304
    Top = 397
  end
  object Actionlist: TActionList
    Left = 532
    Top = 365
    object actSerialnumbers: TDNMAction
      Category = 'StS'
      Caption = 'Choose Tags'
      ImageIndex = 400
      OnExecute = ChooseTags
      buttoncolor = clWhite
    end
    object actMakeMetrcHarvestname: TDNMAction
      Category = 'StS'
      Caption = 'Make Metrc Harvest Name'
      OnExecute = actMakeMetrcHarvestnameExecute
      OnUpdate = actMakeMetrcHarvestnameUpdate
      buttoncolor = clWhite
    end
  end
  object QryStSHarvest: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblStSHarvest')
    Active = True
    Left = 601
    Top = 364
    object QryStSHarvestID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblstsharvest.ID'
    end
    object QryStSHarvestDeptID: TIntegerField
      FieldName = 'DeptID'
      Origin = 'tblstsharvest.DeptID'
    end
    object QryStSHarvestBinID: TIntegerField
      FieldName = 'BinID'
      Origin = 'tblstsharvest.BinID'
    end
    object QryStSHarvestHarvestDate: TDateTimeField
      FieldName = 'HarvestDate'
      Origin = 'tblstsharvest.HarvestDate'
    end
    object QryStSHarvestStrainID: TIntegerField
      FieldName = 'StrainID'
      Origin = 'tblstsharvest.StrainID'
    end
    object QryStSHarvestStrainName: TWideStringField
      FieldName = 'StrainName'
      Origin = 'tblstsharvest.StrainName'
      Size = 255
    end
    object QryStSHarvestUOMID: TIntegerField
      FieldName = 'UOMID'
      Origin = 'tblstsharvest.UOMID'
    end
    object QryStSHarvestUOM: TWideStringField
      FieldName = 'UOM'
      Origin = 'tblstsharvest.UOM'
      Size = 255
    end
    object QryStSHarvestHarvestName: TWideStringField
      FieldName = 'HarvestName'
      Origin = 'tblstsharvest.HarvestName'
      Size = 255
    end
    object QryStSHarvestUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tblstsharvest.UOMMultiplier'
    end
    object QryStSHarvestTotalQty: TFloatField
      FieldName = 'TotalQty'
      Origin = 'tblstsharvest.TotalQty'
    end
    object QryStSHarvestPackedQty: TFloatField
      FieldName = 'PackedQty'
      Origin = 'tblstsharvest.PackedQty'
    end
    object QryStSHarvestStSProductId: TIntegerField
      FieldName = 'StSProductId'
      Origin = 'tblstsharvest.StSProductId'
    end
    object QryStSHarvestmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblstsharvest.msTimeStamp'
    end
    object QryStSHarvestmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblstsharvest.msUpdateSiteCode'
      Size = 3
    end
    object QryStSHarvestDone: TWideStringField
      FieldName = 'Done'
      Origin = 'tblstsharvest.Done'
      FixedChar = True
      Size = 1
    end
  end
  object dsStSHarvest: TDataSource
    DataSet = QryStSHarvest
    Left = 602
    Top = 394
  end
  object qryStSHarvestLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblStSHarvestLines')
    Active = True
    Left = 633
    Top = 364
    object qryStSHarvestLinesStsTag: TWideStringField
      DisplayLabel = 'Plant (Tag)'
      DisplayWidth = 60
      FieldName = 'StsTag'
      Origin = 'tblstsharvestlines.StsTag'
      Size = 255
    end
    object qryStSHarvestLinesUOMQty: TFloatField
      DisplayLabel = 'Weight'
      DisplayWidth = 13
      FieldName = 'UOMQty'
      Origin = 'tblstsharvestlines.UOMQty'
    end
    object qryStSHarvestLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblstsharvestlines.ID'
      Visible = False
    end
    object qryStSHarvestLinesHarvestID: TIntegerField
      DisplayWidth = 10
      FieldName = 'HarvestID'
      Origin = 'tblstsharvestlines.HarvestID'
      Visible = False
    end
    object qryStSHarvestLinesTagID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TagID'
      Origin = 'tblstsharvestlines.TagID'
      Visible = False
    end
    object qryStSHarvestLinesQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblstsharvestlines.Qty'
      Visible = False
    end
    object qryStSHarvestLinesStSActionID: TIntegerField
      DisplayWidth = 10
      FieldName = 'StSActionID'
      Origin = 'tblstsharvestlines.StSActionID'
      Visible = False
    end
  end
  object dsStSHarvestLines: TDataSource
    DataSet = qryStSHarvestLines
    Left = 634
    Top = 394
  end
  object qryStSStrains: TERPQuery
    Connection = fmStSMain.MyConnection
    SQL.Strings = (
      'SELECT * from tblStSStrains ORDER BY strainname')
    Left = 664
    Top = 364
    object qryStSStrainsStrainName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 30
      FieldName = 'StrainName'
      Size = 255
    end
    object qryStSStrainsID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
  end
  object QryClass: TERPQuery
    Connection = fmStSMain.MyConnection
    SQL.Strings = (
      'Select C.classID, c.classname'
      'FROM tblClass C'
      'inner join tblStSClass StS on StS.classId = c.classId'
      'Order by c.classname')
    Left = 698
    Top = 364
    object QryClassClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object QryClassClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 60
    end
  end
  object qrybins: TERPQuery
    Connection = fmStSMain.MyConnection
    SQL.Strings = (
      
        'SELECT binid, concat(Binlocation , '#39'-'#39', binnumber) bindetails FR' +
        'OM tblproductbin WHERE classId = :ClassId')
    BeforeOpen = qrybinsBeforeOpen
    Left = 730
    Top = 364
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClassId'
      end>
    object qrybinsbindetails: TWideStringField
      DisplayWidth = 61
      FieldName = 'bindetails'
      Size = 61
    end
    object qrybinsbinid: TIntegerField
      FieldName = 'binid'
      Visible = False
    end
  end
  object QryUOM: TERPQuery
    Connection = fmStSMain.MyConnection
    SQL.Strings = (
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName,'
      'CONCAT(U.UnitName , "(", U.Multiplier,")") AS UOMDetails'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 40'
      'union all '
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName,'
      'CONCAT(U.UnitName , "(", U.Multiplier,")") AS UOMDetails'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = 40 )'
      'Order By UnitID desc ,UnitName;')
    BeforeOpen = QryUOMBeforeOpen
    Left = 759
    Top = 364
    object QryUOMUnitName: TWideStringField
      DisplayWidth = 15
      FieldName = 'UnitName'
      Size = 15
    end
    object QryUOMMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'Multiplier'
    end
    object QryUOMUOMDetails: TWideStringField
      DisplayWidth = 40
      FieldName = 'UOMDetails'
      Visible = False
      Size = 39
    end
    object QryUOMUnitID: TIntegerField
      FieldName = 'UnitID'
      Visible = False
    end
    object QryUOMUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Visible = False
      Size = 35
    end
    object QryUOMBaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
      Visible = False
      Size = 15
    end
  end
end
