inherited ChartSetup: TChartSetup
  Left = 177
  Top = 258
  HelpContext = 62000
  Caption = 'Chart Setup'
  ClientHeight = 435
  ClientWidth = 792
  OldCreateOrder = True
  ExplicitLeft = 177
  ExplicitTop = 258
  ExplicitWidth = 800
  ExplicitHeight = 462
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 435
    Width = 792
    ExplicitTop = 435
    ExplicitWidth = 792
    HelpContext = 62027
  end
  object SubForm: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 792
    Height = 435
    HelpContext = 62001
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Transparent = False
    DesignSize = (
      792
      435)
    object Bevel1: TBevel
      Left = 102
      Top = 13
      Width = 568
      Height = 400
      HelpContext = 62002
      Shape = bsFrame
    end
    object Label3: TLabel
      Left = 188
      Top = 40
      Width = 67
      Height = 15
      HelpContext = 62003
      Caption = 'Chart Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label11: TLabel
      Left = 526
      Top = 48
      Width = 40
      Height = 17
      HelpContext = 62004
      Alignment = taCenter
      AutoSize = False
      Caption = 'Default'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label1: TLabel
      Left = 528
      Top = 105
      Width = 40
      Height = 17
      HelpContext = 62005
      Alignment = taCenter
      AutoSize = False
      Caption = 'Global'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblcustomReport: TLabel
      Left = 187
      Top = 98
      Width = 82
      Height = 15
      HelpContext = 62006
      Caption = 'Custom Filters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object txtChartName: TwwDBEdit
      Left = 187
      Top = 56
      Width = 167
      Height = 23
      HelpContext = 62007
      DataField = 'ChartName'
      DataSource = DSCustomCharts
      Font.Charset = ANSI_CHARSET
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
    object chkDefault: TwwCheckBox
      Left = 539
      Top = 62
      Width = 13
      Height = 16
      HelpContext = 62008
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      DataField = 'DefaultChart'
      DataSource = DSCustomCharts
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object chkGlobal: TwwCheckBox
      Left = 540
      Top = 120
      Width = 13
      Height = 16
      HelpContext = 62009
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbChecked
      Checked = True
      DataField = 'Global'
      DataSource = DSCustomCharts
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
    end
    object cboCustomReports: TwwDBLookupCombo
      Left = 187
      Top = 114
      Width = 209
      Height = 23
      HelpContext = 62010
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'FilterName'#9'50'#9'FilterName'#9'F')
      DataField = 'CustomFilterID'
      DataSource = DSCustomCharts
      LookupTable = qryCustomReports
      LookupField = 'ID'
      DropDownWidth = 350
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnCloseUp = cboCustomReportsCloseUp
    end
    object btnApply: TDNMSpeedButton
      Left = 681
      Top = 17
      Width = 87
      Height = 27
      HelpContext = 62011
      Anchors = [akTop, akRight]
      Caption = 'Apply'
      Color = clWhite
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
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
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -13
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 4
      OnClick = btnApplyClick
    end
    object pnlSeries: TDNMPanel
      Left = 186
      Top = 155
      Width = 395
      Height = 231
      HelpContext = 62012
      BevelOuter = bvLowered
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      Transparent = False
      DesignSize = (
        395
        231)
      object Bevel2: TBevel
        Left = 27
        Top = 54
        Width = 338
        Height = 158
        HelpContext = 62013
        Style = bsRaised
      end
      object lblX_LabelsField: TLabel
        Left = 48
        Top = 70
        Width = 88
        Height = 15
        HelpContext = 62014
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Labels (X: Axis)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
      object lblX_ChartedField: TLabel
        Left = 38
        Top = 143
        Width = 97
        Height = 15
        HelpContext = 62015
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'X: Axis (Optional)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
      object lblY_ChartedField: TLabel
        Left = 98
        Top = 107
        Width = 37
        Height = 15
        HelpContext = 62016
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Y: Axis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
      object lblSeries: TLabel
        Left = 28
        Top = 12
        Width = 73
        Height = 15
        HelpContext = 62017
        Alignment = taRightJustify
        Caption = 'Series Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblZ_ChartedField: TLabel
        Left = 97
        Top = 178
        Width = 38
        Height = 15
        HelpContext = 62018
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Z: Axis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
      object LabelSeriesClass: TLabel
        Left = 234
        Top = 32
        Width = 130
        Height = 13
        HelpContext = 62019
        AutoSize = False
        Transparent = True
      end
      object ImageSeries: TImage
        Left = 202
        Top = 26
        Width = 24
        Height = 24
        HelpContext = 62020
        Transparent = True
      end
      object cboX_LabelsField: TwwDBComboBox
        Left = 145
        Top = 67
        Width = 204
        Height = 23
        HelpContext = 62021
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = True
        AutoDropDown = True
        AutoSize = False
        DataField = 'X_LabelsField'
        DataSource = DSCustomCharts
        DropDownCount = 8
        DropDownWidth = 350
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
      end
      object cboX_ChartedField: TwwDBComboBox
        Left = 145
        Top = 138
        Width = 204
        Height = 23
        HelpContext = 62022
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = True
        AutoDropDown = True
        AutoSize = False
        DataField = 'X_ChartedField'
        DataSource = DSCustomCharts
        DropDownCount = 8
        DropDownWidth = 350
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        Sorted = False
        TabOrder = 2
        UnboundDataType = wwDefault
      end
      object cboY_ChartedField: TwwDBComboBox
        Left = 145
        Top = 103
        Width = 204
        Height = 23
        HelpContext = 62023
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = True
        AutoDropDown = True
        AutoSize = False
        DataField = 'Y_ChartedField'
        DataSource = DSCustomCharts
        DropDownCount = 8
        DropDownWidth = 350
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        Sorted = False
        TabOrder = 1
        UnboundDataType = wwDefault
      end
      object cboZ_ChartedField: TwwDBComboBox
        Left = 145
        Top = 174
        Width = 204
        Height = 23
        HelpContext = 62024
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = True
        AutoDropDown = True
        AutoSize = False
        DataField = 'Z_ChartedField'
        DataSource = DSCustomCharts
        DropDownCount = 8
        DropDownWidth = 350
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        Sorted = False
        TabOrder = 3
        UnboundDataType = wwDefault
      end
    end
    object btnDelete: TDNMSpeedButton
      Left = 682
      Top = 61
      Width = 87
      Height = 27
      HelpContext = 62025
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Delete'
      Color = clWhite
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
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
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -13
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 7
      OnClick = btnDeleteClick
    end
    object SeriesName: TwwDBComboBox
      Left = 213
      Top = 182
      Width = 167
      Height = 23
      HelpContext = 62026
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      AutoFillDate = False
      DropDownCount = 8
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      Sorted = False
      TabOrder = 6
      UnboundDataType = wwDefault
      OnChange = SeriesNameChange
    end
  end
  object DSCustomCharts: TDataSource
    DataSet = ListChartView.qryCustomCharts
    Left = 12
    Top = 9
  end
  object qryCustomReports: TERPQuery
    SQL.Strings = (
      'SELECT ID,FilterName,FilterStatement, DefaultFilter'
      'from tblCustomFilters'
      'where Active = "T" and ReportName = :ReportName and '
      '(USerId = :USERID or AllUsers = "T")')
    Left = 44
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ReportName'
      end
      item
        DataType = ftUnknown
        Name = 'USERID'
      end>
    object qryCustomReportsFilterName: TWideStringField
      DisplayWidth = 50
      FieldName = 'FilterName'
      Origin = 'tblCustomFilters.FilterName'
      Size = 255
    end
    object qryCustomReportsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblCustomFilters.ID'
      Visible = False
    end
    object qryCustomReportsFilterStatement: TWideMemoField
      FieldName = 'FilterStatement'
      Origin = 'tblCustomFilters.FilterStatement'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryCustomReportsDefaultFilter: TWideStringField
      FieldName = 'DefaultFilter'
      FixedChar = True
      Size = 1
    end
  end
end
