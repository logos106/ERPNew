object fmMainMenu: TfmMainMenu
  Left = 192
  Top = 190
  Caption = 'Client Registration Manager'
  ClientHeight = 586
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object alMain: TActionList
    Left = 160
    Top = 40
    object actClose: TAction
      Caption = 'Close'
      OnExecute = actCloseExecute
    end
    object actLogin: TAction
      Caption = 'Login'
      OnExecute = actLoginExecute
    end
    object actClientList: TAction
      Caption = 'Client List'
      OnExecute = actClientListExecute
    end
    object actLicenceList: TAction
      Caption = 'Licence List'
      OnExecute = actLicenceListExecute
    end
    object actServerLog: TAction
      Caption = 'Server Log'
      OnExecute = actServerLogExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 304
    Top = 24
    object File1: TMenuItem
      Caption = 'File'
      object Login1: TMenuItem
        Action = actLogin
      end
      object Close1: TMenuItem
        Action = actClose
      end
    end
    object Lists1: TMenuItem
      Caption = 'Lists'
      object ClientList1: TMenuItem
        Action = actClientList
      end
      object LicenceList1: TMenuItem
        Action = actLicenceList
      end
      object ServerLog1: TMenuItem
        Action = actServerLog
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 464
    Top = 16
  end
end
