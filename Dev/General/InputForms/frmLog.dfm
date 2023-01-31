inherited fmLog: TfmLog
  BorderStyle = bsNone
  Caption = 'fmLog'
  ClientHeight = 49
  ClientWidth = 327
  FormStyle = fsStayOnTop
  ExplicitWidth = 335
  ExplicitHeight = 76
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1203002
  inherited lblSkingroupMsg: TLabel
    Top = 49
    Width = 327
    ExplicitWidth = 493
    HelpContext = 1203003
  end
  object lblMsg: TLabel [3]
    Left = 0
    Top = 0
    Width = 327
    Height = 48
    Align = alTop
    Alignment = taCenter
    Caption = 
      'jkgldfk gjdklgj dlkgjdgldfkjgldkjgdklgdjglkdjgdlkg jdlkgjd glkdg' +
      'jdlkgjdglkdjglkdjgdklgjdglkjgdlkgjdflgkjdfklgdfjgdfljld gdlkgjdf' +
      'lgdfjlgdfgjdflkgjdfglkdjgdlfgjdflkgj'
    Color = clBlue
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    WordWrap = True
    OnDblClick = lblMsgDblClick
    ExplicitWidth = 324
    HelpContext = 1203004
  end
  inherited tmrdelay: TTimer
    Enabled = False
    Interval = 20000
  end
  object Timershow: TTimer
    Enabled = False
    Interval = 20000
    OnTimer = TimershowTimer
    Left = 56
    Top = 88
  end
end
