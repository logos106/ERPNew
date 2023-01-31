inherited fmQLDTransRegoCheck: TfmQLDTransRegoCheck
  Left = 494
  Top = 314
  BorderStyle = bsNone
  Caption = 'QLD Vehicle Rego Check'
  ClientHeight = 480
  ClientWidth = 507
  PopupMenu = popSpelling
  Position = poMainFormCenter
  ExplicitLeft = 494
  ExplicitTop = 314
  ExplicitWidth = 523
  ExplicitHeight = 519
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1660002
  inherited lblSkingroupMsg: TLabel
    Top = 160
    Width = 507
    ExplicitTop = 160
    ExplicitWidth = 507
    HelpContext = 1660003
  end
  inherited WebBrowser: TWebBrowser
    Top = 160
    Width = 507
    Height = 320
    Align = alBottom
    OnDocumentComplete = WebBrowserDocumentComplete
    ExplicitTop = 479
    ExplicitWidth = 507
    ExplicitHeight = 320
    ControlData = {
      4C0000002F620000C73600000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
    HelpContext = 1660004
  end
  object DNMPanel1: TDNMPanel [5]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 501
    Height = 154
    HelpContext = 1660005
    Align = alClient
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 497
      Height = 150
      HelpContext = 1660006
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      FromColor = 10485759
      ToColor = 10944422
      FromColorMirror = 10944422
      ToColorMirror = 10485759
      Steps = 10
      Direction = False
      Version = '1.4.0.0'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 497
        Height = 150
        HelpContext = 1660007
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Please Wait while Checking for the QLD Vehicle Rego Details'
        Font.Charset = ANSI_CHARSET
        Font.Color = 26112
        Font.Height = -40
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 234
        ExplicitHeight = 36
      end
    end
  end
  object tmrQLDRegisteredVehiclecheck: TTimer
    Enabled = False
    OnTimer = tmrQLDRegisteredVehiclecheckTimer
    Left = 480
    Top = 88
  end
end
