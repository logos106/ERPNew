inherited fmListdates: TfmListdates
  Left = 2424
  Caption = 'Dates'
  ClientHeight = 78
  ClientWidth = 263
  Position = poMainFormCenter
  ExplicitLeft = 2424
  ExplicitWidth = 271
  ExplicitHeight = 105
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1235002
  inherited lblSkingroupMsg: TLabel
    Top = 78
    Width = 263
    ExplicitTop = 78
    ExplicitWidth = 263
    HelpContext = 1235003
  end
  object lblFrom: TLabel [3]
    Left = 13
    Top = 12
    Width = 29
    Height = 15
    Caption = '&From'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    HelpContext = 1235004
  end
  object lblTo: TLabel [4]
    Left = 135
    Top = 12
    Width = 13
    Height = 15
    Caption = '&To'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    HelpContext = 1235005
  end
  object dtFrom: TwwDBDateTimePicker [5]
    Left = 49
    Top = 8
    Width = 86
    Height = 21
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
    TabOrder = 0
    UnboundDataType = wwDTEdtDate
    HelpContext = 1235006
  end
  object dtTo: TwwDBDateTimePicker [6]
    Left = 149
    Top = 8
    Width = 86
    Height = 21
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
    TabOrder = 1
    UnboundDataType = wwDTEdtDate
    HelpContext = 1235007
  end
  object btnOk: TDNMSpeedButton [7]
    Left = 88
    Top = 36
    Width = 87
    Height = 27
    Caption = 'OK'
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
    OnClick = btnOkClick
    HelpContext = 1235008
  end
end
