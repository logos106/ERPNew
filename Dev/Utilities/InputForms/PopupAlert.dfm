inherited PopupAlertGUI: TPopupAlertGUI
  Left = 308
  Top = 252
  HelpContext = 419000
  Caption = 'Alert'
  ClientHeight = 271
  ClientWidth = 528
  ExplicitLeft = 308
  ExplicitTop = 252
  DesignSize = (
    528
    271)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 271
    Width = 528
  end
  inherited Label1: TLabel
    Top = 253
    HelpContext = 419001
    Visible = False
    ExplicitTop = 253
  end
  inherited chkDontShowHint: TwwCheckBox
    Left = 7
    Top = 252
    HelpContext = 419002
    Visible = False
    ExplicitLeft = 7
    ExplicitTop = 252
  end
  inherited Panel1: TPanel
    Top = 8
    Width = 512
    Height = 227
    HelpContext = 419003
    Anchors = [akLeft, akTop, akRight, akBottom]
    ExplicitTop = 8
    ExplicitWidth = 512
    ExplicitHeight = 227
    inherited HintHeader: TLabel
      Left = 71
      Width = 431
      HelpContext = 419004
      Font.Height = -19
      ExplicitLeft = 71
      ExplicitWidth = 431
    end
    inherited Image1: TImage
      HelpContext = 419005
    end
    inherited HintMemo: TMemo
      Left = 4
      Top = 79
      Width = 506
      Height = 145
      HelpContext = 419006
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Color = clBlack
      Font.Height = -13
      ReadOnly = True
      WantTabs = True
      ExplicitLeft = 4
      ExplicitTop = 79
      ExplicitWidth = 506
      ExplicitHeight = 145
    end
  end
  inherited btnClose: TDNMSpeedButton
    Left = 220
    Top = 240
    Width = 87
    Height = 27
    HelpContext = 419007
    Anchors = [akBottom]
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
    ModalResult = 1
    ParentFont = False
    OnClick = btnCloseClick
    ExplicitLeft = 220
    ExplicitTop = 240
    ExplicitWidth = 87
    ExplicitHeight = 27
  end
end
