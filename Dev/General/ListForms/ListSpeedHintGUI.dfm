inherited frmQrySpeedHintGUI: TfrmQrySpeedHintGUI
  Left = 2122
  Top = 289
  HelpContext = 339000
  Caption = 'Hint'
  ClientHeight = 230
  ClientWidth = 460
  Visible = True
  ExplicitLeft = 2122
  ExplicitTop = 289
  ExplicitWidth = 476
  ExplicitHeight = 269
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 230
    Width = 460
    HelpContext = 339009
  end
  object BitBtn2: TDNMSpeedButton [5]
    Left = 369
    Top = 10
    Width = 87
    Height = 25
    HelpContext = 339008
    Caption = ' Yes'
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
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    SlowDecease = True
    Style = bsModern
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = BitBtn2Click
  end
  inherited Panel1: TPanel
    Width = 353
    Height = 191
    HelpContext = 339003
    ExplicitWidth = 353
    ExplicitHeight = 191
    inherited HintHeader: TLabel
      Left = 52
      Top = 21
      HelpContext = 339004
      Caption = ' Slow to Open Lists ??'
      ExplicitLeft = 52
      ExplicitTop = 21
    end
    inherited Image1: TImage
      Left = 9
      HelpContext = 339005
      ExplicitLeft = 9
    end
    inherited HintMemo: TMemo
      Left = 42
      Top = 47
      Width = 282
      Height = 140
      HelpContext = 339006
      Lines.Strings = (
        'ERP Has Detected That This List is Slow to '
        'Open.'
        ''
        'To Improve Speed Try The Following :'
        '  - Alter Dates Ranges to be 10 Days Apart Inside'
        '    Personal Preferences.'
        '  - Change List Mode to Search Engine using the'
        '    Customise Button.'
        ''
        'Do you wish to use Search Engine next Time ?')
      ExplicitLeft = 42
      ExplicitTop = 47
      ExplicitWidth = 282
      ExplicitHeight = 140
    end
  end
  inherited btnClose: TDNMSpeedButton
    Left = 370
    Top = 44
    Width = 87
    Height = 25
    HelpContext = 339007
    Cancel = True
    Caption = ' No'
    Color = clWhite
    Default = False
    Font.Charset = ANSI_CHARSET
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
    ParentColor = False
    ParentFont = False
    SlowDecease = True
    Style = bsModern
    TabOrder = 3
    OnClick = btnCloseClick
    ExplicitLeft = 370
    ExplicitTop = 44
    ExplicitWidth = 87
    ExplicitHeight = 25
  end
  inherited chkDontShowHint: TwwCheckBox
    Left = 4
    Top = 209
    HelpContext = 339002
    ExplicitLeft = 4
    ExplicitTop = 209
  end
end
