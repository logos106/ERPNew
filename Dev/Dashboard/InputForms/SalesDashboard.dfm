inherited SalesDashboardGUI: TSalesDashboardGUI
  Left = 797
  Top = 255
  HelpContext = 998001
  Caption = 'Sales Dashboard'
  ExplicitLeft = 797
  ExplicitTop = 255
  PixelsPerInch = 96
  TextHeight = 13
  inherited Horizontal1: TSplitter
    Top = 308
    ExplicitTop = 306
  end
  inherited pnl3: TDNMPanel
    Top = 310
    Height = 179
    HelpContext = 998008
    ExplicitTop = 310
    ExplicitHeight = 182
    inherited report3n4: TSplitter
      Height = 177
      HelpContext = 998009
      ExplicitHeight = 182
    end
    inherited report4n5: TSplitter
      Height = 177
      HelpContext = 998010
      ExplicitHeight = 182
    end
    inherited Report4: TDNMPanel
      Height = 177
      HelpContext = 998011
      ExplicitHeight = 180
    end
    inherited Report5: TDNMPanel
      Height = 177
      HelpContext = 998012
      ExplicitHeight = 180
    end
    inherited report6: TDNMPanel
      Height = 177
      HelpContext = 998013
      ExplicitHeight = 180
    end
  end
  inherited DNMPanel1: TDNMPanel
    HelpContext = 998028
    inherited btnCancel: TDNMSpeedButton
      Left = 486
      ExplicitLeft = 486
    end
    object btnRequery: TDNMSpeedButton [2]
      Left = 358
      Top = 5
      Width = 109
      Height = 27
      HelpContext = 998014
      Anchors = []
      Caption = 'Refresh'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnRequeryClick
    end
    inherited btnImport: TDNMSpeedButton
      TabOrder = 4
    end
    inherited pnlDonotshowonStartup: TDNMPanel
      inherited chkShowDashboard: TCheckBox
        ExplicitLeft = 829
      end
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 952
    Height = 52
    HelpContext = 998015
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      952
      52)
    object Bevel1: TBevel
      Left = 663
      Top = 1
      Width = 288
      Height = 50
      HelpContext = 998016
      Align = alRight
      ExplicitLeft = 662
      ExplicitHeight = 48
    end
    object lblTo: TLabel
      Left = 865
      Top = 4
      Width = 13
      Height = 15
      HelpContext = 998017
      Anchors = [akTop, akRight]
      Caption = '&To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblFrom: TLabel
      Left = 772
      Top = 3
      Width = 29
      Height = 15
      HelpContext = 998018
      Anchors = [akTop, akRight]
      Caption = '&From'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object Bevel2: TBevel
      Left = 1
      Top = 1
      Width = 288
      Height = 50
      HelpContext = 998019
      Align = alLeft
      ExplicitHeight = 48
    end
    object dtTo: TwwDBDateTimePicker
      Left = 865
      Top = 22
      Width = 82
      Height = 23
      HelpContext = 998020
      TabStop = False
      Anchors = [akTop, akRight]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 6
      CalendarAttributes.PopupYearOptions.StartYear = 1980
      Date = 37432.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ShowButton = True
      TabOrder = 0
      UnboundDataType = wwDTEdtDate
      OnChange = dtToChange
    end
    object dtFrom: TwwDBDateTimePicker
      Left = 772
      Top = 22
      Width = 82
      Height = 23
      HelpContext = 998021
      TabStop = False
      Anchors = [akTop, akRight]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 6
      CalendarAttributes.PopupYearOptions.StartYear = 1980
      Date = 37432.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ShowButton = True
      TabOrder = 1
      UnboundDataType = wwDTEdtDate
      OnChange = dtFromChange
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 119
      Top = 14
      Width = 145
      Height = 23
      HelpContext = 998022
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'255'#9'EmployeeName'#9'F')
      LookupTable = qryEmployees
      LookupField = 'EmployeeName'
      DropDownWidth = 350
      ParentFont = False
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboEmployeeChange
    end
    object chkAllEmployees: TCheckBox
      Left = 10
      Top = 17
      Width = 97
      Height = 17
      HelpContext = 998023
      Caption = 'All Employees'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = chkAllEmployeesClick
    end
    object pnlHeader: TPanel
      AlignWithMargins = True
      Left = 292
      Top = 4
      Width = 368
      Height = 44
      HelpContext = 998024
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 4
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 366
        Height = 42
        HelpContext = 998025
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.4.0.0'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 366
          Height = 42
          HelpContext = 998026
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sales Dashboard'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -49
          ExplicitWidth = 548
          ExplicitHeight = 47
        end
      end
    end
    object chkIgnoreDates: TCheckBox
      Left = 670
      Top = 25
      Width = 93
      Height = 17
      HelpContext = 998027
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = 'Ignore Dates'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = chkIgnoreDatesClick
    end
  end
  inherited pnl1: TDNMPanel
    Top = 52
    HelpContext = 998029
    ExplicitTop = 52
    inherited report2n3: TSplitter
      Top = 17
      Height = 238
      HelpContext = 998002
      ExplicitTop = 17
      ExplicitHeight = 238
    end
    inherited report1n2: TSplitter
      Top = 17
      Height = 238
      HelpContext = 998003
      ExplicitTop = 17
      ExplicitHeight = 238
    end
    object lblREfreshInfo: TLabel [2]
      Left = 1
      Top = 1
      Width = 950
      Height = 16
      HelpContext = 998004
      Align = alTop
      Alignment = taCenter
      Caption = 'Please Select Refresh Button to Apply the Selection Criteria'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      WordWrap = True
      ExplicitWidth = 379
    end
    inherited Report2: TDNMPanel
      Top = 17
      Height = 238
      HelpContext = 998005
      ExplicitLeft = 195
      ExplicitTop = 15
      ExplicitHeight = 238
    end
    inherited Report3: TDNMPanel
      Top = 17
      Height = 238
      HelpContext = 998006
      ExplicitTop = 17
      ExplicitHeight = 238
    end
    inherited Report1: TDNMPanel
      Top = 17
      Height = 238
      HelpContext = 998007
      ExplicitLeft = -3
      ExplicitTop = 15
      ExplicitHeight = 238
    end
  end
  object qryEmployees: TERPQuery [11]
    SQL.Strings = (
      'SELECT EmployeeID, EmployeeName FROM tblemployees'
      'ORDER BY EmployeeName')
    Left = 218
    Top = 71
  end
end
