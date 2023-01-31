inherited fmEmailConfig2: TfmEmailConfig2
  HelpContext = 1302002
  Caption = 'Email Config'
  ClientHeight = 593
  ClientWidth = 646
  ExplicitWidth = 662
  ExplicitHeight = 632
  DesignSize = (
    646
    593)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 593
    Width = 646
    HelpContext = 1302003
    ExplicitTop = 533
    ExplicitWidth = 646
  end
  object btnTest: TDNMSpeedButton [5]
    Left = 272
    Top = 555
    Width = 101
    Height = 31
    HelpContext = 1302004
    Anchors = [akBottom]
    Caption = 'Test'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnTestClick
  end
  object btnCancel: TDNMSpeedButton [6]
    Left = 400
    Top = 555
    Width = 101
    Height = 31
    HelpContext = 1302005
    Anchors = [akBottom]
    Caption = 'Cancel'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object pnlEmailConfig: TDNMPanel [7]
    Left = 9
    Top = 54
    Width = 629
    Height = 495
    HelpContext = 1302006
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    DesignSize = (
      629
      495)
    object Bevel8: TBevel
      Left = 3
      Top = 7
      Width = 622
      Height = 483
      HelpContext = 1302007
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      ExplicitHeight = 422
    end
    object PageControl1: TPageControl
      Left = 14
      Top = 23
      Width = 599
      Height = 458
      HelpContext = 1302008
      ActivePage = tabGeneral
      TabOrder = 0
      object tabGeneral: TTabSheet
        HelpContext = 1302009
        Caption = 'General'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlGeneral: TDNMPanel
          Left = 0
          Top = 0
          Width = 591
          Height = 427
          HelpContext = 1302010
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label1: TLabel
            Left = 30
            Top = 16
            Width = 73
            Height = 16
            HelpContext = 1302011
            Caption = 'Your Name:'
          end
          object Label2: TLabel
            Left = 30
            Top = 47
            Width = 94
            Height = 16
            HelpContext = 1302012
            Caption = 'Email Address:'
          end
          object Label3: TLabel
            Left = 30
            Top = 77
            Width = 106
            Height = 16
            HelpContext = 1302013
            Caption = 'Reply-to Address'
          end
          object Label15: TLabel
            Left = 30
            Top = 242
            Width = 134
            Height = 16
            HelpContext = 1302014
            Caption = 'Default Email Format'
            Visible = False
          end
          object Label20: TLabel
            Left = 30
            Top = 107
            Width = 103
            Height = 16
            HelpContext = 1302015
            Caption = 'Integration Type'
          end
          object lblIntegrationType: TLabel
            Left = 175
            Top = 133
            Width = 389
            Height = 68
            HelpContext = 1302016
            AutoSize = False
            Caption = 'Integration type info'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object EmailName: TEdit
            Left = 175
            Top = 13
            Width = 389
            Height = 24
            HelpContext = 1302017
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = 'EmailName'
          end
          object edtEmailAddress: TEdit
            Left = 175
            Top = 43
            Width = 389
            Height = 24
            HelpContext = 1302018
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = 'edtEmailAddress'
            OnChange = edtEmailAddressChange
          end
          object ReplyEmailAddress: TEdit
            Left = 175
            Top = 73
            Width = 389
            Height = 24
            HelpContext = 1302019
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = 'ReplyEmailAddress'
            OnChange = edtEmailAddressChange
          end
          object EmailFormat: TComboBox
            Left = 175
            Top = 239
            Width = 145
            Height = 23
            HelpContext = 1302020
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Visible = False
            Items.Strings = (
              'HTML'
              'Plain Text')
          end
          object cboIntegrationType: TComboBox
            Left = 175
            Top = 104
            Width = 145
            Height = 23
            HelpContext = 1302021
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = cboIntegrationTypeChange
            Items.Strings = (
              'Email Client'
              'Server')
          end
        end
      end
      object tabSignature: TTabSheet
        HelpContext = 1302022
        Caption = 'Signature'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DNMPanel3: TDNMPanel
          Left = 0
          Top = 0
          Width = 591
          Height = 427
          HelpContext = 1302023
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object lblSignatureText: TLabel
            Left = 14
            Top = 20
            Width = 85
            Height = 15
            HelpContext = 1302024
            Caption = 'Signature Text:'
          end
          object SignatureText: TMemo
            Left = 30
            Top = 42
            Width = 518
            Height = 119
            HelpContext = 1302025
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            Lines.Strings = (
              'SignatureText')
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
          object SignatureFromFile: TwwCheckBox
            Left = 14
            Top = 172
            Width = 395
            Height = 19
            HelpContext = 1302026
            DisableThemes = False
            AlwaysTransparent = False
            ValueChecked = 'True'
            ValueUnchecked = 'False'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Attach signature from a file instead (text, HTML or Image)'
            TabOrder = 1
            OnClick = SignatureFromFileClick
          end
          object ChooseFile: TDNMSpeedButton
            Left = 458
            Top = 167
            Width = 90
            Height = 27
            HelpContext = 1302027
            Caption = 'Choose File'
            DisableTransparent = False
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            TabOrder = 2
            OnClick = ChooseFileClick
          end
          object grdAttach: TwwDBGrid
            Left = 30
            Top = 201
            Width = 419
            Height = 168
            HelpContext = 1302028
            ControlType.Strings = (
              'IsPrimary;CheckBox;T;F')
            Selected.Strings = (
              'FileName'#9'45'#9'File Name'#9'F'#9
              'IsPrimary'#9'1'#9'Primary'#9#9)
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 0
            ShowHorzScrollBar = True
            DataSource = dsEmailSignature
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -13
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
          end
        end
      end
      object tabOutgoing: TTabSheet
        HelpContext = 1302029
        Caption = 'Outgoing Server'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DNMPanel1: TDNMPanel
          Left = 0
          Top = 0
          Width = 591
          Height = 427
          HelpContext = 1302030
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label4: TLabel
            Left = 21
            Top = 16
            Width = 186
            Height = 15
            HelpContext = 1302031
            Caption = 'SMTP (Outgoing Server) Settings'
          end
          object Label5: TLabel
            Left = 22
            Top = 48
            Width = 74
            Height = 15
            HelpContext = 1302032
            Caption = 'Server Name'
          end
          object Label6: TLabel
            Left = 22
            Top = 78
            Width = 24
            Height = 15
            HelpContext = 1302033
            Caption = 'Port'
          end
          object lblSMTPDefaultPort: TLabel
            Left = 245
            Top = 78
            Width = 145
            Height = 15
            HelpContext = 1302034
            Caption = 'Default: 25 or 2525 or 587'
          end
          object Label8: TLabel
            Left = 22
            Top = 138
            Width = 128
            Height = 15
            HelpContext = 1302035
            Caption = 'Authentication method'
          end
          object Label9: TLabel
            Left = 22
            Top = 167
            Width = 63
            Height = 15
            HelpContext = 1302036
            Caption = 'User Name'
          end
          object Label10: TLabel
            Left = 22
            Top = 197
            Width = 58
            Height = 15
            HelpContext = 1302037
            Caption = 'Password'
          end
          object Label19: TLabel
            Left = 22
            Top = 108
            Width = 113
            Height = 15
            HelpContext = 1302038
            Caption = 'Connection security'
          end
          object lblOutServerInstructions: TLabel
            Left = 167
            Top = 241
            Width = 352
            Height = 15
            HelpContext = 1302039
            Caption = 'These fields should match your email program account settings.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object SMTPServer: TEdit
            Left = 167
            Top = 45
            Width = 389
            Height = 24
            HelpContext = 1302040
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = 'SMTPServer'
          end
          object SMTPPort: TAdvSpinEdit
            Left = 167
            Top = 75
            Width = 66
            Height = 24
            HelpContext = 1302041
            Value = 0
            DateValue = 43341.433733576390000000
            HexValue = 0
            Enabled = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            IncrementFloat = 0.100000000000000000
            IncrementFloatPage = 1.000000000000000000
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'Tahoma'
            LabelFont.Style = []
            ParentFont = False
            TabOrder = 1
            Visible = True
            Version = '1.4.7.0'
          end
          object SMTPAuthType: TComboBox
            Left = 167
            Top = 135
            Width = 145
            Height = 23
            HelpContext = 1302042
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Items.Strings = (
              'Normal Password'
              'None'
              'SASL')
          end
          object SMTPUserName: TEdit
            Left = 167
            Top = 164
            Width = 389
            Height = 24
            HelpContext = 1302043
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = 'SMTPUserName'
          end
          object SMTPPassword: TEdit
            Left = 167
            Top = 194
            Width = 389
            Height = 24
            HelpContext = 1302044
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 4
            Text = 'SMTPPassword'
          end
          object SMTPTLS: TComboBox
            Left = 167
            Top = 105
            Width = 145
            Height = 23
            HelpContext = 1302045
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = SMTPTLSChange
            Items.Strings = (
              'None'
              'Explicit TLS'
              'Implicit TLS'
              'Require TLS')
          end
          object btnSMTPGmailDefaults: TDNMSpeedButton
            Left = 301
            Top = 16
            Width = 125
            Height = 23
            HelpContext = 1302046
            Caption = 'Gmail Defaults'
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 6
            OnClick = btnSMTPGmailDefaultsClick
          end
          object btnSMTPOfficeDefaults: TDNMSpeedButton
            Left = 431
            Top = 16
            Width = 125
            Height = 23
            HelpContext = 1302047
            Caption = 'Office 365 Defaults'
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 7
            OnClick = btnSMTPOfficeDefaultsClick
          end
        end
      end
      object tabIncoming: TTabSheet
        HelpContext = 1302048
        Caption = 'Incoming Server'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DNMPanel2: TDNMPanel
          Left = 0
          Top = 0
          Width = 591
          Height = 427
          HelpContext = 1302049
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label11: TLabel
            Left = 21
            Top = 16
            Width = 143
            Height = 15
            HelpContext = 1302050
            Caption = 'Incoming Server Settings'
          end
          object Label12: TLabel
            Left = 21
            Top = 48
            Width = 67
            Height = 15
            HelpContext = 1302051
            Caption = 'Server Type'
          end
          object Label13: TLabel
            Left = 22
            Top = 80
            Width = 74
            Height = 15
            HelpContext = 1302052
            Caption = 'Server Name'
          end
          object Label14: TLabel
            Left = 22
            Top = 110
            Width = 24
            Height = 15
            HelpContext = 1302053
            Caption = 'Port'
          end
          object lblServerPort: TLabel
            Left = 245
            Top = 110
            Width = 67
            Height = 15
            HelpContext = 1302054
            Caption = 'Default: 465'
          end
          object Label16: TLabel
            Left = 22
            Top = 169
            Width = 128
            Height = 15
            HelpContext = 1302055
            Caption = 'Authentication method'
          end
          object Label17: TLabel
            Left = 22
            Top = 198
            Width = 63
            Height = 15
            HelpContext = 1302056
            Caption = 'User Name'
          end
          object Label18: TLabel
            Left = 22
            Top = 228
            Width = 58
            Height = 15
            HelpContext = 1302057
            Caption = 'Password'
          end
          object Label7: TLabel
            Left = 22
            Top = 140
            Width = 113
            Height = 15
            HelpContext = 1302058
            Caption = 'Connection security'
          end
          object lblInServerInstructions: TLabel
            Left = 167
            Top = 277
            Width = 352
            Height = 15
            HelpContext = 1302059
            Caption = 'These fields should match your email program account settings.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object ServerType: TComboBox
            Left = 167
            Top = 45
            Width = 106
            Height = 23
            HelpContext = 1302060
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = ServerTypeChange
            Items.Strings = (
              'POP'
              'IMAP')
          end
          object Server: TEdit
            Left = 167
            Top = 77
            Width = 389
            Height = 24
            HelpContext = 1302061
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = 'Server'
          end
          object Port: TAdvSpinEdit
            Left = 167
            Top = 107
            Width = 66
            Height = 24
            HelpContext = 1302062
            Value = 0
            DateValue = 43341.433733634260000000
            HexValue = 0
            Enabled = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            IncrementFloat = 0.100000000000000000
            IncrementFloatPage = 1.000000000000000000
            LabelFont.Charset = DEFAULT_CHARSET
            LabelFont.Color = clWindowText
            LabelFont.Height = -11
            LabelFont.Name = 'Tahoma'
            LabelFont.Style = []
            ParentFont = False
            TabOrder = 2
            Visible = True
            Version = '1.4.7.0'
          end
          object AuthType: TComboBox
            Left = 167
            Top = 166
            Width = 145
            Height = 23
            HelpContext = 1302063
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Items.Strings = (
              'Normal Password'
              'Encrypted Password')
          end
          object ServerUserName: TEdit
            Left = 167
            Top = 195
            Width = 389
            Height = 24
            HelpContext = 1302064
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            Text = 'ServerUserName'
          end
          object ServerPassword: TEdit
            Left = 167
            Top = 225
            Width = 389
            Height = 24
            HelpContext = 1302065
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 5
            Text = 'ServerPassword'
          end
          object TLS: TComboBox
            Left = 167
            Top = 137
            Width = 145
            Height = 23
            HelpContext = 1302066
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnChange = SMTPTLSChange
            Items.Strings = (
              'None'
              'Explicit TLS'
              'Implicit TLS'
              'Require TLS')
          end
          object btnGmail: TDNMSpeedButton
            Left = 300
            Top = 45
            Width = 125
            Height = 23
            HelpContext = 1302067
            Caption = 'Gmail Defaults'
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 7
            OnClick = btnGmailClick
          end
          object btnOffice: TDNMSpeedButton
            Left = 431
            Top = 45
            Width = 125
            Height = 23
            HelpContext = 1302068
            Caption = 'Office 365 Defaults'
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 8
            OnClick = btnOfficeClick
          end
        end
      end
    end
  end
  object btnSave: TDNMSpeedButton [8]
    Left = 144
    Top = 555
    Width = 101
    Height = 31
    HelpContext = 1302069
    Anchors = [akBottom]
    Caption = 'Save'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object pnlTitle: TDNMPanel [9]
    Left = 143
    Top = 6
    Width = 360
    Height = 41
    HelpContext = 1302070
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
      Width = 356
      Height = 37
      HelpContext = 1302071
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
        Width = 356
        Height = 37
        HelpContext = 1302072
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Email Config'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 355
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 500
  end
  inherited tmrdelay: TTimer
    Left = 536
  end
  inherited popSpelling: TPopupMenu
    Left = 448
    Top = 65528
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 97
    Top = 8
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 533
    Top = 8
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited DataState: TDataState
    Left = 568
    Top = 8
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 219
  end
  inherited imgsort: TImageList
    Left = 395
    Bitmap = {
      494C010102000C01640110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited QryCustomField: TERPQuery
    Left = 138
    Top = 24
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 430
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 254
  end
  inherited qryMemTrans: TERPQuery
    Left = 181
    Top = 24
  end
  object qryEmailSignature: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblemailSignature'
      'where EmailConfigId = :EmailConfigId')
    Left = 472
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EmailConfigId'
      end>
    object qryEmailSignatureFileName: TWideStringField
      DisplayLabel = 'File Name'
      DisplayWidth = 45
      FieldName = 'FileName'
      Origin = 'tblemailsignature.FileName'
      Size = 255
    end
    object qryEmailSignatureIsPrimary: TWideStringField
      DisplayLabel = 'Primary'
      DisplayWidth = 1
      FieldName = 'IsPrimary'
      FixedChar = True
      Size = 1
    end
    object qryEmailSignatureGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblemailsignature.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryEmailSignatureID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblemailsignature.ID'
      Visible = False
    end
    object qryEmailSignatureEmailConfigID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmailConfigID'
      Origin = 'tblemailsignature.EmailConfigID'
      Visible = False
    end
    object qryEmailSignaturemsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblemailsignature.msTimeStamp'
      Visible = False
    end
    object qryEmailSignaturemsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblemailsignature.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object qryEmailSignatureData: TBlobField
      DisplayWidth = 10
      FieldName = 'Data'
      Visible = False
    end
  end
  object dsEmailSignature: TDataSource
    DataSet = qryEmailSignature
    Left = 472
    Top = 392
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'Hyper text|*.htm;*.html|Text|*.txt|Image|*.png;*.jpg;*.jpeg;*.ti' +
      'f;*.giff|All|*.*'
    Left = 536
    Top = 360
  end
end
