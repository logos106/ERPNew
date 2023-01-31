inherited POSChgPadPopUp: TPOSChgPadPopUp
  Left = 339
  Top = 234
  Caption = 'Select Target Keypad'
  ClientHeight = 181
  ClientWidth = 291
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 421000
  object cboKeyPads: TwwDBLookupCombo [1]
    Left = 64
    Top = 88
    Width = 169
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Description'#9'20'#9'Description'#9'F')
    LookupTable = qryKeypads
    LookupField = 'Description'
    ParentFont = False
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
    HelpContext = 421002
  end
  object btnOK: TDNMSpeedButton [2]
    Left = 105
    Top = 136
    Width = 87
    Height = 27
    Caption = 'O&K'
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    OnClick = btnOKClick
    HelpContext = 421003
  end
  object pnlTitle: TDNMPanel [3]
    Left = 26
    Top = 14
    Width = 238
    Height = 45
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    HelpContext = 421004
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 41
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.2.1.1'
      HelpContext = 421005
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 234
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Select Keypad'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        HelpContext = 421006
      end
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 87
    Top = 70
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 23
    Top = 70
  end
  inherited MyConnection: TERPConnection
    Left = 119
    Top = 69
  end
  inherited DataState: TDataState
    Left = 23
    Top = 94
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 151
    Top = 70
  end
  object qryKeypads: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT KeypadID, Description'
      'FROM tblPOSKeypads WHERE Active = '#39'T'#39';')
    Left = 23
    Top = 111
  end
  inherited imgGridWatermark: TImage
    HelpContext = 421001
  end
end
