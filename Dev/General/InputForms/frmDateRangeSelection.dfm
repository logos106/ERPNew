inherited fmDateRangeSelection: TfmDateRangeSelection
  Left = 1142
  Top = 103
  Caption = 'fmDateRangeSelection'
  ClientHeight = 74
  ClientWidth = 282
  ExplicitLeft = 1142
  ExplicitTop = 103
  ExplicitWidth = 290
  ExplicitHeight = 101
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1388002
  inherited lblSkingroupMsg: TLabel
    Top = 74
    Width = 282
    ExplicitTop = 74
    ExplicitWidth = 282
    HelpContext = 1388003
  end
  object pnlDateRangeSelection: TDNMPanel [3]
    Left = 0
    Top = 0
    Width = 282
    Height = 73
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    HelpContext = 1388004
    object lblTo: TLabel
      Left = 175
      Top = 41
      Width = 13
      Height = 15
      Caption = '&To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      HelpContext = 1388005
    end
    object lblFrom: TLabel
      Left = 50
      Top = 41
      Width = 29
      Height = 15
      Caption = '&From'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
      HelpContext = 1388006
    end
    object chkIgnoreDates: TCheckBox
      Left = 22
      Top = 8
      Width = 61
      Height = 29
      HelpContext = 1388007
      Alignment = taLeftJustify
      Caption = 'Ignore Dates'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      WordWrap = True
    end
    object cboDateRange: TComboBox
      Left = 89
      Top = 8
      Width = 186
      Height = 23
      AutoDropDown = True
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 15
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      Text = 'Custom'
      Items.Strings = (
        'Today'
        'Yesterday'
        'Last Week'
        'Last Month'
        'Last Quarter'
        'Last 12 Months'
        'Previous Week'
        'Previous Month'
        'Previous Quarter'
        'Previous Financial Year'
        'This Week'
        'This Month'
        'This Quarter'
        'This Financial Year'
        'This Financial Year To Date'
        'Custom')
      HelpContext = 1388008
    end
    object dtFrom: TwwDBDateTimePicker
      Left = 86
      Top = 37
      Width = 86
      Height = 23
      TabStop = False
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
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ShowButton = True
      TabOrder = 2
      UnboundDataType = wwDTEdtDate
      HelpContext = 1388009
    end
    object dtTo: TwwDBDateTimePicker
      Left = 189
      Top = 37
      Width = 86
      Height = 23
      TabStop = False
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
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      ShowButton = True
      TabOrder = 3
      UnboundDataType = wwDTEdtDate
      HelpContext = 1388010
    end
  end
end
