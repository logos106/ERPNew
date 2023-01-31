inherited frBaseListingGuiEdit: TfrBaseListingGuiEdit
  Height = 309
  HelpContext = 596000
  Constraints.MinHeight = 309
  Constraints.MinWidth = 345
  Color = 15527129
  ParentColor = False
  ExplicitWidth = 435
  ExplicitHeight = 309
  object pnlBaseListing: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 435
    Height = 249
    HelpContext = 596001
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    ExplicitWidth = 443
    ExplicitHeight = 309
    object rgCustomisedReport: TGroupBox
      Left = 22
      Top = 21
      Width = 297
      Height = 257
      HelpContext = 596002
      Caption = ' Customised Report '
      TabOrder = 0
      object ReportGUI: TLabel
        Left = 24
        Top = 32
        Width = 74
        Height = 15
        HelpContext = 596003
        Caption = 'Report Name'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 24
        Top = 96
        Width = 170
        Height = 15
        HelpContext = 596004
        Caption = 'Report Selector Tab (Optional)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 24
        Top = 152
        Width = 233
        Height = 49
        HelpContext = 596005
        AutoSize = False
        Caption = 
          'Note that the report will show in the "My Reports" tab of the Re' +
          'port Selector in addition to the Tab chosen from the above Combo' +
          ' Box.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object edtReportName: TEdit
        Left = 24
        Top = 48
        Width = 233
        Height = 23
        HelpContext = 596006
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 40
        ParentFont = False
        TabOrder = 0
      end
      object cboReportTab: TwwDBComboBox
        Left = 24
        Top = 113
        Width = 248
        Height = 23
        HelpContext = 596007
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = True
        AutoDropDown = True
        AutoFillDate = False
        AutoSize = False
        DropDownCount = 8
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Accounts'
          'Appointments'
          'Banking'
          'CRM'
          'Employee'
          'Fixed Assets'
          'Hire/Projects'
          'Hospitality'
          'Inventory'
          'Jobs'
          'Payments'
          'Payroll'
          'Purchases'
          'Sales')
        ParentFont = False
        Sorted = False
        TabOrder = 1
        UnboundDataType = wwDefault
      end
      object btnSaveCustomisedReport: TDNMSpeedButton
        Left = 22
        Top = 214
        Width = 147
        Height = 27
        HelpContext = 596008
        Caption = 'Create Custom Report'
        Color = clWhite
        Default = True
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentColor = False
        ParentFont = False
        Style = bsModern
        TabOrder = 2
        OnClick = btnSaveCustomisedReportClick
      end
    end
  end
end
