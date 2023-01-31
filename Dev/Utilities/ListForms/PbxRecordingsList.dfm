inherited PBXRecordingsListGUI: TPBXRecordingsListGUI
  Left = 63
  Top = 521
  Caption = 'Call Recordings'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 14153215
    inherited cmdClose: TDNMSpeedButton
      Left = 658
    end
    inherited cmdNew: TDNMSpeedButton
      Visible = False
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 522
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 387
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 252
    end
  end
  inherited HeaderPanel: TPanel
    Color = 14153215
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Top = 27
      Height = 315
      TitleColor = 14153215
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 998
      Height = 27
      Align = alTop
      Color = 14153215
      TabOrder = 1
      object MediaPlayer1: TMediaPlayer
        Left = 0
        Top = 2
        Width = 85
        Height = 24
        VisibleButtons = [btPlay, btPause, btStop]
        AutoEnable = False
        TabOrder = 0
        OnClick = MediaPlayer1Click
        OnNotify = MediaPlayer1Notify
      end
    end
  end
  inherited dsMain: TDataSource
    Left = 446
  end
  inherited dlgSave: TSaveDialog
    Left = 544
  end
  inherited dlgPrint: TPdtPrintDAT
    Left = 392
  end
  inherited actlstFilters: TActionList
    Left = 600
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 329
    Top = 7
  end
  inherited wwLocateDialog1: TwwLocateDialog
    Left = 655
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT RecordingID, Time, ClientID, ClientName, '
      'Reference,Employee,Extension  '
      'FROM tblcallrecordings'
      'WHERE  Time Between :txtfrom AND :txtto'
      'ORDER BY RecordingID DESC')
    Left = 488
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'txtfrom'
      end
      item
        DataType = ftUnknown
        Name = 'txtto'
      end>
  end
  inherited qryPersonalPrefs: TMyQuery
    Left = 288
    Top = 0
  end
end
