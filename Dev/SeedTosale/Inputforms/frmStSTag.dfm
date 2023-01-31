inherited fmStSTag: TfmStSTag
  Left = 332
  Top = 263
  Caption = 'Tag'
  ClientHeight = 418
  ClientWidth = 607
  Position = poMainFormCenter
  ExplicitLeft = 332
  ExplicitTop = 263
  ExplicitWidth = 623
  ExplicitHeight = 457
  DesignSize = (
    607
    418)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 375
    Width = 607
    ExplicitTop = 233
    ExplicitWidth = 597
  end
  inherited shapehint: TShape
    Left = 6
    ExplicitLeft = 6
  end
  inherited shapehintextra1: TShape
    Left = 49
    ExplicitLeft = 48
  end
  inherited pnlFooter: TDNMPanel
    Top = 375
    Width = 607
    TabOrder = 2
    ExplicitTop = 375
    ExplicitWidth = 607
    DesignSize = (
      607
      43)
    inherited btnCompleted: TDNMSpeedButton
      Left = 105
      TabStop = True
      OnClick = btnCompletedClick
      ExplicitLeft = 105
    end
    inherited btnClose: TDNMSpeedButton
      Left = 414
      TabOrder = 3
      TabStop = True
      OnClick = btnCloseClick
      ExplicitLeft = 414
    end
    object btnHistory: TDNMSpeedButton
      Left = 209
      Top = 8
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = 'History'
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
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnHistoryClick
    end
    object btnTagActivity: TDNMSpeedButton
      Left = 311
      Top = 8
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = 'Activity'
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
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnTagActivityClick
    end
  end
  inherited pnlHeader: TDNMPanel
    Width = 607
    TabOrder = 0
    ExplicitWidth = 607
    DesignSize = (
      607
      57)
    inherited pnlTitle: TDNMPanel
      Width = 343
      ExplicitWidth = 343
      inherited TitleShader: TShader
        Width = 341
        ExplicitWidth = 341
        inherited TitleLabel: TLabel
          Width = 341
          Caption = 'Tag'
          ExplicitWidth = 331
        end
      end
    end
  end
  inherited pnlDetails: TDNMPanel
    Width = 607
    Height = 318
    Font.Style = []
    TabOrder = 1
    ExplicitWidth = 607
    ExplicitHeight = 318
    object Label1: TLabel
      Left = 116
      Top = 14
      Width = 43
      Height = 15
      Alignment = taRightJustify
      Caption = 'Strain : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 86
      Top = 58
      Width = 73
      Height = 15
      Alignment = taRightJustify
      Caption = 'Department :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 117
      Top = 147
      Width = 42
      Height = 15
      Alignment = taRightJustify
      Caption = 'Count : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 15
      Top = 192
      Width = 144
      Height = 15
      Alignment = taRightJustify
      Caption = 'Seed To Sale Tag Phase : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 124
      Top = 237
      Width = 35
      Height = 15
      Alignment = taRightJustify
      Caption = 'Date : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 124
      Top = 103
      Width = 35
      Height = 15
      Alignment = taRightJustify
      Caption = 'Type : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object optStSPhase: TwwRadioGroup
      Left = 178
      Top = 182
      Width = 384
      Height = 34
      DisableThemes = False
      ShowGroupCaption = False
      Caption = 'Seed To Sale Tag Phase'
      Columns = 3
      DataField = 'StSPhase'
      DataSource = dsststags
      Items.Strings = (
        'Immature'
        'Vegetative'
        'Flowering')
      TabOrder = 4
      Values.Strings = (
        'I'
        'V'
        'H')
      OnExit = optStSPhaseExit
    end
    object cboStrainName: TwwDBLookupCombo
      Left = 178
      Top = 10
      Width = 384
      Height = 23
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'StrainName'#9'30'#9'Name'#9'F')
      DataField = 'StrainName'
      DataSource = dsststags
      LookupTable = qryStSStrains
      LookupField = 'StrainName'
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object wwDBLookupCombo1: TwwDBEdit
      Left = 178
      Top = 54
      Width = 384
      Height = 23
      TabStop = False
      DataField = 'Dept'
      DataSource = dsststags
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtPlantcount: TwwDBSpinEdit
      Left = 178
      Top = 143
      Width = 60
      Height = 23
      Increment = 1.000000000000000000
      DataField = 'Plantcount'
      DataSource = dsststags
      TabOrder = 3
      UnboundDataType = wwDefault
    end
    object dtUsedOn: TwwDBDateTimePicker
      Left = 178
      Top = 233
      Width = 143
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      DataField = 'UsedOn'
      DataSource = dsststags
      Epoch = 1950
      ShowButton = True
      TabOrder = 5
    end
    object optSourcetype: TwwRadioGroup
      Left = 178
      Top = 93
      Width = 384
      Height = 34
      DisableThemes = False
      ShowGroupCaption = False
      Caption = 'Seed To Sale Tag Phase'
      Columns = 3
      DataField = 'Sourcetype'
      DataSource = dsststags
      Items.Strings = (
        'Cutting'
        'Clone'
        'Seeds')
      TabOrder = 2
      Values.Strings = (
        'Cutting'
        'Clone'
        'Seeds')
    end
    object pnlbin: TDNMPanel
      Left = 1
      Top = 262
      Width = 605
      Height = 55
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object lblbin: TLabel
        Left = 72
        Top = 20
        Width = 87
        Height = 15
        Alignment = taRightJustify
        Caption = 'Product Room: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object cbobin: TwwDBLookupCombo
        Left = 177
        Top = 16
        Width = 143
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'bin'#9'61'#9'bin'#9'F')
        DataField = 'binid'
        DataSource = dsststags
        LookupTable = QryBin
        LookupField = 'binId'
        ParentFont = False
        TabOrder = 0
        Visible = False
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnEnter = cbobinEnter
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 403
    Top = 8
  end
  inherited tmrdelay: TTimer
    Left = 512
    Top = 8
  end
  inherited popSpelling: TPopupMenu
    Left = 367
    Top = 8
  end
  inherited tmrdelayMsg: TTimer
    Left = 475
    Top = 8
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 331
    Top = 8
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 187
    Top = 8
  end
  inherited MyConnection: TERPConnection
    Left = 266
    Top = 72
  end
  inherited DataState: TDataState
    Left = 223
    Top = 8
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Top = 8
  end
  inherited imgsort: TImageList
    Left = 259
    Top = 8
    Bitmap = {
      494C0101020048015C0310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 290
    Top = 104
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 295
    Top = 8
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 151
    Top = 8
  end
  inherited qryMemTrans: TERPQuery
    Left = 326
    Top = 104
  end
  inherited tmrOnshow: TTimer
    Left = 439
    Top = 8
  end
  object dsststags: TDataSource
    DataSet = fmStSMain.qryststags
    Left = 259
    Top = 136
  end
  object qryStSStrains: TERPQuery
    Connection = fmStSMain.MyConnection
    SQL.Strings = (
      'SELECT * from tblStSStrains ORDER BY strainname')
    Left = 488
    Top = 112
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
      'SELECT C.classId, C.classname from tblclass C'
      'INNER JOIN tblstsclass StSC ON C.classId = StSC.classId'
      'order by classname')
    Left = 392
    Top = 104
    object QryClassClassName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 30
      FieldName = 'ClassName'
      Size = 60
    end
    object QryClassClassID: TIntegerField
      FieldName = 'ClassID'
      Visible = False
    end
  end
  object QryBin: TERPQuery
    Connection = fmStSMain.MyConnection
    SQL.Strings = (
      
        'SELECT binId, concat(binlocation , '#39'-'#39',binnumber ) AS bin FROM t' +
        'blproductbin WHERE classId = :ClassId')
    BeforeOpen = QryBinBeforeOpen
    Left = 456
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClassId'
      end>
    object QryBinbin: TWideStringField
      DisplayWidth = 61
      FieldName = 'bin'
      Size = 61
    end
    object QryBinbinId: TIntegerField
      FieldName = 'binId'
      Visible = False
    end
  end
end
