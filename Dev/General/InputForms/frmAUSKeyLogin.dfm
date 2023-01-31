inherited fmAUSKeyLogin: TfmAUSKeyLogin
  BorderStyle = bsSingle
  Caption = 'fmAUSKeyLogin'
  ClientHeight = 264
  ClientWidth = 566
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Position = poScreenCenter
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 572
  ExplicitHeight = 293
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1624002
  inherited lblSkingroupMsg: TLabel
    Top = 264
    Width = 566
    ExplicitTop = 264
    ExplicitWidth = 449
    HelpContext = 1624003
  end
  object Label1: TLabel [4]
    Left = 36
    Top = 83
    Width = 63
    Height = 15
    AutoSize = False
    Caption = 'Key File'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    HelpContext = 1624004
  end
  object Label2: TLabel [5]
    Left = 36
    Top = 113
    Width = 63
    Height = 15
    AutoSize = False
    Caption = 'Entity'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    HelpContext = 1624005
  end
  object Label3: TLabel [6]
    Left = 36
    Top = 142
    Width = 63
    Height = 15
    AutoSize = False
    Caption = 'Password'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    HelpContext = 1624006
  end
  object pnlTitle: TDNMPanel [7]
    Left = 48
    Top = 6
    Width = 470
    Height = 45
    HelpContext = 1624007
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 466
      Height = 41
      HelpContext = 1624008
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
        Width = 466
        Height = 41
        HelpContext = 1624009
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = ' "Please Enter your  AUSKey Login Details"'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 308
      end
    end
  end
  object cmdLogon: TDNMSpeedButton [8]
    Left = 155
    Top = 226
    Width = 106
    Height = 30
    Anchors = [akBottom]
    Caption = '&Logon'
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
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    Style = bsModern
    TabOrder = 1
    OnClick = cmdLogonClick
    HelpContext = 1624010
  end
  object cmdCancel: TDNMSpeedButton [9]
    Left = 304
    Top = 226
    Width = 106
    Height = 30
    Anchors = [akBottom]
    Cancel = True
    Caption = '&Cancel'
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
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 2
    NumGlyphs = 2
    ParentColor = False
    ParentFont = False
    Style = bsModern
    TabOrder = 2
    HelpContext = 1624011
  end
  object edtKeyFile: TEdit [10]
    Left = 104
    Top = 80
    Width = 393
    Height = 23
    TabOrder = 3
    Text = 'edtKeyFile'
    OnChange = edtKeyFileChange
    HelpContext = 1624012
  end
  object btnOPenKeyFile: TButton [11]
    Left = 491
    Top = 79
    Width = 25
    Height = 25
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnOPenKeyFileClick
    HelpContext = 1624013
  end
  object cboEntity: TComboBox [12]
    Left = 104
    Top = 110
    Width = 412
    Height = 23
    Style = csDropDownList
    TabOrder = 5
    HelpContext = 1624014
  end
  object edtPassword: TEdit [13]
    Left = 104
    Top = 139
    Width = 412
    Height = 23
    PasswordChar = '*'
    TabOrder = 6
    HelpContext = 1624015
  end
  object chkSavePassword: TwwCheckBox [14]
    Left = 104
    Top = 184
    Width = 145
    Height = 17
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'Save Password'
    TabOrder = 7
    HelpContext = 1624016
  end
  inherited popSpelling: TPopupMenu
    Left = 112
    Top = 24
  end
  inherited tmrdelayMsg: TTimer
    Top = 32
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 433
    Top = 24
  end
  object OpenDialog: TOpenDialog
    Filter = 'XML Files|*.xml|All Files|*.*'
    FilterIndex = 0
    Left = 360
    Top = 192
  end
end
