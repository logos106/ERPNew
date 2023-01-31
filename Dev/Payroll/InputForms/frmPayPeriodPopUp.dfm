inherited PayPeriodGUI: TPayPeriodGUI
  Left = 474
  Top = 317
  HelpContext = 413000
  BorderStyle = bsDialog
  Caption = 'Pay Period'
  ClientHeight = 181
  ClientWidth = 378
  Color = 15785701
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnPaint = FormPaint
  ExplicitLeft = 474
  ExplicitTop = 317
  ExplicitWidth = 394
  ExplicitHeight = 220
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 181
    Width = 378
    HelpContext = 413008
    ExplicitTop = 181
    ExplicitWidth = 378
  end
  object Bevel1: TBevel [3]
    Left = 8
    Top = 24
    Width = 353
    Height = 97
    HelpContext = 413001
    Shape = bsFrame
  end
  object Label1: TLabel [4]
    Left = 32
    Top = 44
    Width = 209
    Height = 15
    HelpContext = 413002
    Caption = 'You are about to Pay Staff through to:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object label2: TLabel [5]
    Left = 184
    Top = 84
    Width = 57
    Height = 15
    HelpContext = 413003
    Caption = 'Paid Date:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object btnCancel: TDNMSpeedButton [7]
    Left = 207
    Top = 133
    Width = 87
    Height = 27
    HelpContext = 413005
    Cancel = True
    Caption = 'Cancel'
    Color = clWhite
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
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
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    SlowDecease = True
    Style = bsModern
    TabOrder = 1
    AutoDisableParentOnclick = True
  end
  object dtpCommence: TwwDBDateTimePicker [8]
    Left = 251
    Top = 41
    Width = 94
    Height = 23
    HelpContext = 413006
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 2
  end
  object dtpDatePaid: TwwDBDateTimePicker [9]
    Left = 251
    Top = 82
    Width = 94
    Height = 23
    HelpContext = 413007
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 3
  end
  object btnOk: TDNMSpeedButton [10]
    Left = 95
    Top = 133
    Width = 87
    Height = 27
    HelpContext = 413004
    Caption = 'OK'
    Color = clWhite
    Default = True
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    HotTrackColor = clBtnShadow
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    SlowDecease = True
    Style = bsModern
    TabOrder = 0
    AutoDisableParentOnclick = True
  end
end
