inherited fmPoolProfileTestDefaults: TfmPoolProfileTestDefaults
  Left = 401
  Top = 211
  Caption = 'fmPoolProfileTestDefaults'
  ClientHeight = 374
  ClientWidth = 507
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 19
    Top = 223
    Width = 469
    Height = 108
  end
  object Bevel2: TBevel [1]
    Left = 19
    Top = 63
    Width = 469
    Height = 131
    Shape = bsFrame
  end
  inherited imgGridWatermark: TImage
    Left = 171
    Top = 78
  end
  object lblSubstance: TLabel [3]
    Left = 49
    Top = 107
    Width = 61
    Height = 15
    Alignment = taRightJustify
    Caption = 'Substance'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblType: TLabel [4]
    Left = 70
    Top = 77
    Width = 40
    Height = 15
    Alignment = taRightJustify
    Caption = 'lblType'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblTemperature: TLabel [5]
    Left = 35
    Top = 156
    Width = 75
    Height = 15
    Alignment = taRightJustify
    Caption = 'Target Value '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [6]
    Left = 258
    Top = 156
    Width = 36
    Height = 15
    Alignment = taRightJustify
    Caption = 'Range'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [7]
    Left = 328
    Top = 137
    Width = 23
    Height = 15
    Alignment = taRightJustify
    Caption = 'Min.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel [8]
    Left = 416
    Top = 137
    Width = 27
    Height = 15
    Alignment = taRightJustify
    Caption = 'Max.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [9]
    Left = 21
    Top = 207
    Width = 161
    Height = 18
    Alignment = taCenter
    Caption = 'TREATMENT (10,000L)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label11: TLabel [10]
    Left = 59
    Top = 288
    Width = 50
    Height = 15
    Alignment = taRightJustify
    Caption = 'Increase'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel [11]
    Left = 59
    Top = 264
    Width = 55
    Height = 15
    Alignment = taRightJustify
    Caption = 'Decrease'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblAlgaeType: TLabel [12]
    Left = 124
    Top = 240
    Width = 45
    Height = 15
    Alignment = taRightJustify
    Caption = 'Part No.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label9: TLabel [13]
    Left = 294
    Top = 240
    Width = 29
    Height = 15
    Alignment = taRightJustify
    Caption = 'Dose'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label10: TLabel [14]
    Left = 393
    Top = 240
    Width = 36
    Height = 15
    Alignment = taRightJustify
    Caption = 'Result'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object edtName: TEdit [15]
    Left = 119
    Top = 73
    Width = 134
    Height = 23
    Color = 15724527
    ReadOnly = True
    TabOrder = 0
    Text = 'edtName'
  end
  object edtSubstance: TEdit [16]
    Left = 119
    Top = 103
    Width = 133
    Height = 23
    Color = 15724527
    ReadOnly = True
    TabOrder = 1
  end
  object edtTargetValue: TwwDBEdit [17]
    Left = 119
    Top = 152
    Width = 70
    Height = 23
    DataField = 'TargetValue'
    DataSource = dsPoolTestDefault
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtMinRange: TwwDBEdit [18]
    Left = 304
    Top = 152
    Width = 70
    Height = 23
    DataField = 'Minimum'
    DataSource = dsPoolTestDefault
    TabOrder = 3
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtMaxRange: TwwDBEdit [19]
    Left = 394
    Top = 152
    Width = 70
    Height = 23
    DataField = 'Maximum'
    DataSource = dsPoolTestDefault
    TabOrder = 4
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cboDecreasePartNo: TwwDBLookupCombo [20]
    Left = 124
    Top = 255
    Width = 121
    Height = 23
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'PartName'#9'40'#9'PartName'#9'F')
    DataField = 'DecreasePartID'
    DataSource = dsPoolTestDefault
    LookupTable = qryDecreaseParts
    LookupField = 'PartsID'
    Style = csDropDownList
    TabOrder = 5
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object cboIncreasePartNo: TwwDBLookupCombo [21]
    Left = 124
    Top = 284
    Width = 121
    Height = 23
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'PartName'#9'40'#9'PartName'#9'F')
    DataField = 'IncreasePartID'
    DataSource = dsPoolTestDefault
    LookupTable = QryIncreaseParts
    LookupField = 'PartsID'
    Style = csDropDownList
    TabOrder = 6
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object edtIncreaseDose: TwwDBEdit [22]
    Left = 273
    Top = 284
    Width = 70
    Height = 23
    DataField = 'IncreaseDose'
    DataSource = dsPoolTestDefault
    TabOrder = 7
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtDecreaseDose: TwwDBEdit [23]
    Left = 273
    Top = 255
    Width = 70
    Height = 23
    DataField = 'DecreaseDose'
    DataSource = dsPoolTestDefault
    TabOrder = 8
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtDecreaseResult: TwwDBEdit [24]
    Left = 376
    Top = 255
    Width = 70
    Height = 23
    DataField = 'DecreaseRslt'
    DataSource = dsPoolTestDefault
    TabOrder = 9
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtIncreaseResult: TwwDBEdit [25]
    Left = 376
    Top = 284
    Width = 70
    Height = 23
    DataField = 'IncreaseRslt'
    DataSource = dsPoolTestDefault
    TabOrder = 10
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object DNMPanel1: TDNMPanel [26]
    Left = 0
    Top = 333
    Width = 507
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    DesignSize = (
      507
      41)
    object Button1: TDNMSpeedButton
      Left = 105
      Top = 6
      Width = 87
      Height = 27
      Action = actMainSave
      Anchors = [akBottom]
      Caption = 'OK'
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object BitBtn2: TDNMSpeedButton
      Left = 323
      Top = 7
      Width = 87
      Height = 27
      Action = actMainCancel
      Anchors = [akBottom]
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
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
    end
  end
  object pnlTitle: TDNMPanel [27]
    Left = 73
    Top = 6
    Width = 361
    Height = 45
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 357
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
        Width = 357
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Pool Test Configuration'
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
  inherited ApplicationEvents1: TApplicationEvents
    Left = 75
    Top = 78
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 11
    Top = 78
  end
  inherited MyConnection: TMyConnection
    Left = 107
    Top = 77
  end
  inherited DataState: TDataState
    Left = 11
    Top = 102
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 139
    Top = 78
  end
  object alMain: TActionList
    Left = 39
    Top = 108
    object actMainSave: TAction
      Caption = '&Save'
      OnExecute = actMainSaveExecute
    end
    object actMainNew: TAction
      Caption = '&New'
      OnExecute = actMainNewExecute
    end
    object actMainCancel: TAction
      Caption = '&Cancel'
      OnExecute = actMainCancelExecute
    end
  end
  object qryPoolTestDefault: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblPoolDefaultTest '
      'Where DefaultTestID = :DefaultTestID'
      '')
    Options.LongStrings = False
    Left = 432
    Top = 72
    ParamData = <
      item
        DataType = ftString
        Name = 'DefaultTestID'
        Value = ''
      end>
    object qryPoolTestDefaultDefaultTestID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'DefaultTestID'
      Origin = 'tblPoolDefaultTest.DefaultTestID'
    end
    object qryPoolTestDefaultTestCategoriesID: TIntegerField
      FieldName = 'TestCategoriesID'
      Origin = 'tblPoolDefaultTest.TestCategoriesID'
    end
    object qryPoolTestDefaultName: TStringField
      FieldName = 'Name'
      Origin = 'tblPoolDefaultTest.Name'
      Size = 30
    end
    object qryPoolTestDefaultTargetValue: TFloatField
      FieldName = 'TargetValue'
      Origin = 'tblPoolDefaultTest.TargetValue'
    end
    object qryPoolTestDefaultMinimum: TFloatField
      FieldName = 'Minimum'
      Origin = 'tblPoolDefaultTest.Minimum'
    end
    object qryPoolTestDefaultMaximum: TFloatField
      FieldName = 'Maximum'
      Origin = 'tblPoolDefaultTest.Maximum'
    end
    object qryPoolTestDefaultDecreasePartNo: TStringField
      FieldName = 'DecreasePartNo'
      Origin = 'tblPoolDefaultTest.DecreasePartNo'
      Size = 10
    end
    object qryPoolTestDefaultDecreaseDose: TFloatField
      FieldName = 'DecreaseDose'
      Origin = 'tblPoolDefaultTest.DecreaseDose'
    end
    object qryPoolTestDefaultDecreaseRslt: TFloatField
      FieldName = 'DecreaseRslt'
      Origin = 'tblPoolDefaultTest.DecreaseRslt'
    end
    object qryPoolTestDefaultIncreasePartNo: TStringField
      FieldName = 'IncreasePartNo'
      Origin = 'tblPoolDefaultTest.IncreasePartNo'
      Size = 10
    end
    object qryPoolTestDefaultIncreaseDose: TFloatField
      FieldName = 'IncreaseDose'
      Origin = 'tblPoolDefaultTest.IncreaseDose'
    end
    object qryPoolTestDefaultIncreaseRslt: TFloatField
      FieldName = 'IncreaseRslt'
      Origin = 'tblPoolDefaultTest.IncreaseRslt'
    end
    object qryPoolTestDefaultDecreasePartID: TIntegerField
      FieldName = 'DecreasePartID'
      Origin = 'tblPoolDefaultTest.DecreasePartID'
    end
    object qryPoolTestDefaultIncreasePartID: TIntegerField
      FieldName = 'IncreasePartID'
      Origin = 'tblPoolDefaultTest.IncreasePartID'
    end
  end
  object QryIncreaseParts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select PartsID, PartName from tblParts '
      'Where Active = '#39'T'#39' Order by PartName'
      ''
      '')
    Options.LongStrings = False
    Left = 496
    Top = 71
    object QryIncreasePartsPartName: TStringField
      DisplayWidth = 40
      FieldName = 'PartName'
      Origin = 'tblParts.PartName'
      Size = 40
    end
    object QryIncreasePartsPartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PartsID'
      Origin = 'tblParts.PartsID'
      Visible = False
    end
  end
  object qryDecreaseParts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select PartsID, PartName from tblParts '
      'Where Active = '#39'T'#39' Order by PartName')
    Options.LongStrings = False
    Left = 457
    Top = 71
    object qryDecreasePartsPartName: TStringField
      DisplayWidth = 40
      FieldName = 'PartName'
      Origin = 'tblParts.PartName'
      Size = 40
    end
    object qryDecreasePartsPartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PartsID'
      Origin = 'tblParts.PartsID'
      Visible = False
    end
  end
  object dsPoolTestDefault: TDataSource
    DataSet = qryPoolTestDefault
    Left = 432
    Top = 112
  end
end
