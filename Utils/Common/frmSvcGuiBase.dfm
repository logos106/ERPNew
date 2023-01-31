inherited fmSvcGuiBase: TfmSvcGuiBase
  Left = 486
  Top = 348
  Width = 387
  Height = 238
  Caption = 'fmSvcGuiBase'
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TAdvOfficeStatusBar
    Left = 0
    Top = 192
    Width = 379
    Height = 19
    AnchorHint = False
    Panels = <
      item
        AppearanceStyle = psLight
        DateFormat = 'mm/dd/yyyy'
        Progress.BackGround = clNone
        Progress.Indication = piPercentage
        Progress.Min = 0
        Progress.Max = 100
        Progress.Position = 0
        Progress.Level0Color = clLime
        Progress.Level0ColorTo = 14811105
        Progress.Level1Color = clYellow
        Progress.Level1ColorTo = 13303807
        Progress.Level2Color = 5483007
        Progress.Level2ColorTo = 11064319
        Progress.Level3Color = clRed
        Progress.Level3ColorTo = 13290239
        Progress.Level1Perc = 70
        Progress.Level2Perc = 90
        Progress.BorderColor = clBlack
        Progress.ShowBorder = False
        Progress.Stacked = False
        TimeFormat = 'hh:mm:ss'
        Width = 120
      end
      item
        AppearanceStyle = psLight
        DateFormat = 'mm/dd/yyyy'
        Progress.BackGround = clNone
        Progress.Indication = piPercentage
        Progress.Min = 0
        Progress.Max = 100
        Progress.Position = 0
        Progress.Level0Color = clLime
        Progress.Level0ColorTo = 14811105
        Progress.Level1Color = clYellow
        Progress.Level1ColorTo = 13303807
        Progress.Level2Color = 5483007
        Progress.Level2ColorTo = 11064319
        Progress.Level3Color = clRed
        Progress.Level3ColorTo = 13290239
        Progress.Level1Perc = 70
        Progress.Level2Perc = 90
        Progress.BorderColor = clBlack
        Progress.ShowBorder = False
        Progress.Stacked = False
        TimeFormat = 'hh:mm:ss'
        Width = 150
      end>
    SimplePanel = False
    URLColor = clBlue
    Version = '1.2.0.0'
  end
  object TrayIcon: TCoolTrayIcon
    CycleInterval = 0
    Icon.Data = {
      0000010001002020040000000000E80200001600000028000000200000004000
      0000010004000000000000020000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006444
      4444444444444444444444444400666666666666666666666666666666007FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF7006FFFFFFFFFFFFFFFFFFFFFFFFFFFF7006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF8006FFFFFFFFFFFFFFFFFFFFFFFFFFFF8006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF8006FFFFFFFFFFFFFFFFFFFFFFFFFFFF8006FFF
      FFFFFFFFFFFFFFFFFFFFFFFFF8006FFFFFFFFFFFFFFFFFFFFFFFFFFFF8006888
      8888888888888888888888888600666666666666666666666664666666006666
      666666666666666666867E697600668EEEEEEEEEEEEEEEE66EE6EE6766006666
      6666666666666666666666666600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FFFFFFFFFFFF8000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000001FFFFFFFFFFFFFFFFFFFFFFFF}
    IconVisible = True
    IconIndex = 0
    PopupMenu = popTray
    MinimizeToTray = True
    OnDblClick = TrayIconDblClick
    Left = 16
    Top = 8
  end
  object ActionList: TActionList
    Left = 80
    Top = 8
    object actClose: TAction
      Caption = 'Close'
      OnExecute = actCloseExecute
    end
    object actShow: TAction
      Caption = 'Show Window'
      OnExecute = actShowExecute
    end
    object actShowLog: TAction
      Caption = 'Show Log'
      OnExecute = actShowLogExecute
    end
    object actConfigureControlClient: TAction
      Caption = 'Config Client'
      OnExecute = actConfigureControlClientExecute
    end
  end
  object popTray: TAdvPopupMenu
    OwnerDraw = False
    Version = '2.5.1.1'
    Left = 48
    Top = 8
    object ShowWindow1: TMenuItem
      Action = actShow
      Default = True
    end
    object ShowLog1: TMenuItem
      Action = actShowLog
    end
    object Close1: TMenuItem
      Action = actClose
    end
  end
end
