inherited DashboardGUI: TDashboardGUI
  Left = 192
  Top = 106
  HelpContext = 670000
  VertScrollBar.ButtonSize = 10
  VertScrollBar.Style = ssFlat
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Dashboard'
  ClientHeight = 532
  ClientWidth = 952
  KeyPreview = True
  ExplicitLeft = 192
  ExplicitTop = 106
  ExplicitWidth = 968
  ExplicitHeight = 571
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 489
    Width = 952
    HelpContext = 670014
    ExplicitTop = 492
    ExplicitWidth = 952
  end
  object Horizontal1: TSplitter [3]
    Left = 0
    Top = 256
    Width = 952
    Height = 2
    Cursor = crVSplit
    HelpContext = 670001
    Align = alTop
    OnMoved = Horizontal1Moved
  end
  object pnl3: TDNMPanel [5]
    Left = 0
    Top = 258
    Width = 952
    Height = 231
    HelpContext = 670008
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object report3n4: TSplitter
      Left = 262
      Top = 1
      Width = 2
      Height = 229
      HelpContext = 670009
      OnMoved = report3n4Moved
      ExplicitHeight = 232
    end
    object report4n5: TSplitter
      Left = 524
      Top = 1
      Width = 2
      Height = 229
      HelpContext = 670010
      OnMoved = report4n5Moved
      ExplicitLeft = 530
      ExplicitHeight = 232
    end
    object Report4: TDNMPanel
      Left = 1
      Top = 1
      Width = 261
      Height = 229
      HelpContext = 670011
      Align = alLeft
      Color = clInfoBk
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object Report5: TDNMPanel
      Left = 264
      Top = 1
      Width = 260
      Height = 229
      HelpContext = 670012
      Align = alLeft
      Color = clInfoBk
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object report6: TDNMPanel
      Left = 526
      Top = 1
      Width = 425
      Height = 229
      HelpContext = 670013
      Align = alClient
      Color = clInfoBk
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 489
    Width = 952
    Height = 43
    HelpContext = 670015
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Transparent = False
    DesignSize = (
      952
      43)
    object btnCancel: TDNMSpeedButton
      Left = 422
      Top = 6
      Width = 109
      Height = 27
      HelpContext = 670016
      Anchors = []
      Caption = '&Close'
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
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object cmdExport: TDNMSpeedButton
      Left = 230
      Top = 6
      Width = 109
      Height = 27
      Hint = '"Export The List To An Excel Spreadsheet"'
      HelpContext = 670018
      Anchors = []
      Caption = 'E&xport Charts'
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
      OnClick = cmdExportClick
    end
    object btnImport: TDNMSpeedButton
      Left = 614
      Top = 6
      Width = 109
      Height = 27
      HelpContext = 670019
      Anchors = []
      Caption = 'Import Charts'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnImportClick
    end
    object pnlDonotshowonStartup: TDNMPanel
      AlignWithMargins = True
      Left = 776
      Top = 4
      Width = 172
      Height = 35
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object chkShowDashboard: TCheckBox
        AlignWithMargins = True
        Left = 8
        Top = 4
        Width = 156
        Height = 27
        HelpContext = 670017
        Margins.Left = 7
        Margins.Right = 7
        Align = alClient
        Alignment = taLeftJustify
        Caption = 'Do Not Show on Startup'
        TabOrder = 0
        WordWrap = True
        OnExit = chkShowDashboardExit
      end
    end
  end
  object pnl1: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 952
    Height = 256
    HelpContext = 670002
    Align = alTop
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object report2n3: TSplitter
      Left = 642
      Top = 1
      Width = 2
      Height = 254
      HelpContext = 670003
      OnMoved = report2n3Moved
    end
    object report1n2: TSplitter
      Left = 189
      Top = 1
      Width = 2
      Height = 254
      HelpContext = 670004
      OnMoved = report1n2Moved
    end
    object Report2: TDNMPanel
      Left = 191
      Top = 1
      Width = 451
      Height = 254
      HelpContext = 670005
      Align = alLeft
      Color = clInfoBk
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object Report3: TDNMPanel
      Left = 644
      Top = 1
      Width = 307
      Height = 254
      HelpContext = 670006
      Align = alClient
      Color = clInfoBk
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Report1: TDNMPanel
      Left = 1
      Top = 1
      Width = 188
      Height = 254
      HelpContext = 670007
      Align = alLeft
      Color = clInfoBk
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Transparent = False
    end
  end
  object qrycustomcharts: TERPQuery
    SQL.Strings = (
      
        'SELECT * FROM tblcustomcharts WHERE tblcustomcharts.ReportClassN' +
        'ame = '#39'DashboardGraphs'#39'  AND (tblcustomcharts.EmployeeID = '#39'0'#39' O' +
        'R tblcustomcharts.Global = '#39'T'#39') Order By ChartName')
    Filter = 'UserID = 1'
    Left = 467
    Top = 120
    object qrycustomchartsChartName: TWideStringField
      DisplayWidth = 25
      FieldName = 'ChartName'
      Origin = 'tblcustomcharts.ChartName'
      Size = 255
    end
    object qrycustomchartsReportClassName: TWideStringField
      DisplayWidth = 25
      FieldName = 'ReportClassName'
      Origin = 'tblcustomcharts.ReportClassName'
      Size = 255
    end
    object qrycustomchartsGlobal: TWideStringField
      DisplayWidth = 1
      FieldName = 'Global'
      Origin = 'tblcustomcharts.Global'
      FixedChar = True
      Size = 1
    end
    object qrycustomchartsDefaultChart: TWideStringField
      DisplayWidth = 1
      FieldName = 'DefaultChart'
      Origin = 'tblcustomcharts.DefaultChart'
      FixedChar = True
      Size = 1
    end
    object qrycustomchartsX_LabelsField: TWideStringField
      DisplayWidth = 16
      FieldName = 'X_LabelsField'
      Origin = 'tblcustomcharts.X_LabelsField'
      Size = 255
    end
    object qrycustomchartsX_ChartedField: TWideStringField
      DisplayWidth = 16
      FieldName = 'X_ChartedField'
      Origin = 'tblcustomcharts.X_ChartedField'
      Size = 255
    end
    object qrycustomchartsY_ChartedField: TWideStringField
      DisplayWidth = 16
      FieldName = 'Y_ChartedField'
      Origin = 'tblcustomcharts.Y_ChartedField'
      Size = 255
    end
    object qrycustomchartsZ_ChartedField: TWideStringField
      DisplayWidth = 16
      FieldName = 'Z_ChartedField'
      Origin = 'tblcustomcharts.Z_ChartedField'
      Size = 255
    end
    object qrycustomchartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblcustomcharts.ID'
      Visible = False
    end
    object qrycustomchartsCustomFilterID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomFilterID'
      Origin = 'tblcustomcharts.CustomFilterID'
      Visible = False
    end
    object qrycustomchartsEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblcustomcharts.EmployeeID'
      Visible = False
    end
    object qrycustomchartsChartBlob: TBlobField
      DisplayWidth = 10
      FieldName = 'ChartBlob'
      Origin = 'tblcustomcharts.ChartBlob'
      Visible = False
    end
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'pdi'
    FileName = 'Dashboard Charts.ERPC'
    Filter = 'ERP Charts (*.ERPC)|*.ERPC'
    Left = 650
    Top = 249
  end
  object dlgOpen: TOpenDialog
    DefaultExt = 'ERPC'
    FileName = 'Dashboard Charts.ERPC'
    Left = 479
    Top = 259
  end
end
