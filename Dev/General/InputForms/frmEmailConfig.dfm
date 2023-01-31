inherited fmEmailConfig: TfmEmailConfig
  HelpContext = 971001
  Anchors = [akBottom]
  Caption = 'Email Config'
  ClientHeight = 399
  ClientWidth = 440
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Position = poScreenCenter
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 456
  ExplicitHeight = 437
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 399
    Width = 440
    HelpContext = 971002
    ExplicitTop = 339
    ExplicitWidth = 440
  end
  inherited shapehint: TShape
    Left = -2
    ExplicitLeft = -2
  end
  inherited shapehintextra1: TShape
    Left = 16
    ExplicitLeft = 16
  end
  object Label1: TLabel [3]
    Left = 48
    Top = 72
    Width = 82
    Height = 15
    HelpContext = 971003
    Caption = 'Email Address'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel [4]
    Left = 78
    Top = 134
    Width = 64
    Height = 15
    HelpContext = 971004
    Caption = 'Mail Server'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel [5]
    Left = 77
    Top = 163
    Width = 65
    Height = 15
    HelpContext = 971005
    Caption = 'Server Port'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel [6]
    Left = 48
    Top = 292
    Width = 63
    Height = 15
    HelpContext = 971006
    Caption = 'User Name'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel [7]
    Left = 48
    Top = 321
    Width = 58
    Height = 15
    HelpContext = 971007
    Caption = 'Password'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel [8]
    Left = 248
    Top = 163
    Width = 76
    Height = 15
    HelpContext = 971008
    Caption = '( Default 110 )'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel [9]
    Left = 48
    Top = 105
    Width = 52
    Height = 15
    HelpContext = 971020
    Caption = 'Incoming'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel [10]
    Left = 78
    Top = 225
    Width = 64
    Height = 15
    HelpContext = 971021
    Caption = 'Mail Server'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel [11]
    Left = 77
    Top = 254
    Width = 65
    Height = 15
    HelpContext = 971022
    Caption = 'Server Port'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel [12]
    Left = 248
    Top = 254
    Width = 70
    Height = 15
    HelpContext = 971023
    Caption = '( Default 25 )'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel [13]
    Left = 48
    Top = 196
    Width = 51
    Height = 15
    HelpContext = 971024
    Caption = 'Outgoing'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel [14]
    Left = 72
    Top = 119
    Width = 342
    Height = 70
    HelpContext = 971025
  end
  object Bevel2: TBevel [15]
    Left = 72
    Top = 212
    Width = 342
    Height = 70
    HelpContext = 971026
  end
  object pnlTitle: TDNMPanel [16]
    Left = 57
    Top = 5
    Width = 327
    Height = 36
    HelpContext = 971009
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 323
      Height = 32
      HelpContext = 971010
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
        Width = 323
        Height = 32
        HelpContext = 971011
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Email Config'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -25
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  object btnSave: TDNMSpeedButton [17]
    Left = 63
    Top = 358
    Width = 87
    Height = 27
    HelpContext = 971012
    Anchors = [akBottom]
    Caption = 'Save'
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 6
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton [18]
    Left = 290
    Top = 358
    Width = 87
    Height = 27
    HelpContext = 971013
    Anchors = [akBottom]
    Caption = 'Cancel'
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 8
  end
  object edtEmailAddress: TEdit [19]
    Left = 160
    Top = 69
    Width = 241
    Height = 23
    HelpContext = 971014
    TabOrder = 1
    Text = 'edtEmailAddress'
    OnChange = edtEmailAddressChange
  end
  object edtMailServer: TEdit [20]
    Left = 160
    Top = 131
    Width = 241
    Height = 23
    HelpContext = 971015
    TabOrder = 2
    Text = 'edtMailServer'
  end
  object edtUserName: TEdit [21]
    Left = 160
    Top = 289
    Width = 241
    Height = 23
    HelpContext = 971016
    TabOrder = 4
    Text = 'edtUserName'
  end
  object edtPassword: TEdit [22]
    Left = 160
    Top = 318
    Width = 241
    Height = 23
    HelpContext = 971017
    PasswordChar = '*'
    TabOrder = 5
    Text = 'edtPassword'
  end
  object edtPort: TAdvEdit [23]
    Left = 160
    Top = 160
    Width = 70
    Height = 23
    HelpContext = 971018
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 3
    Text = '0'
    Visible = True
    Version = '2.8.6.9'
  end
  object btnTest: TDNMSpeedButton [24]
    Left = 176
    Top = 358
    Width = 87
    Height = 27
    HelpContext = 971019
    Anchors = [akBottom]
    Caption = 'Test'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = btnTestClick
  end
  object edtOutMailServer: TEdit [25]
    Left = 160
    Top = 222
    Width = 241
    Height = 23
    HelpContext = 971027
    TabOrder = 9
    Text = 'edtMailServer'
  end
  object edtOutPort: TAdvEdit [26]
    Left = 160
    Top = 251
    Width = 70
    Height = 23
    HelpContext = 971028
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 10
    Text = '0'
    Visible = True
    Version = '2.8.6.9'
  end
  inherited popSpelling: TPopupMenu
    Left = 88
    Top = 40
  end
end
