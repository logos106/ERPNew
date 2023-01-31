inherited fmOffsiteBackupConfig: TfmOffsiteBackupConfig
  Caption = 'Offsite Backup Configuration'
  ClientHeight = 470
  ClientWidth = 596
  ExplicitWidth = 602
  ExplicitHeight = 498
  DesignSize = (
    596
    470)
  PixelsPerInch = 96
  TextHeight = 15
  inherited btnSave: TDNMSpeedButton
    Left = 192
    Top = 435
    ExplicitLeft = 192
    ExplicitTop = 435
  end
  inherited btnCancel: TDNMSpeedButton
    Left = 316
    Top = 435
    ExplicitLeft = 316
    ExplicitTop = 435
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 12
    Width = 577
    Height = 417
    ActivePage = tabRestore
    TabOrder = 2
    object tabBackup: TTabSheet
      Caption = 'Backup'
      object pnlBackup: TDNMPanel
        Left = 0
        Top = 0
        Width = 569
        Height = 387
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Transparent = False
        object rgOffsiteBackupTargetType: TRadioGroup
          Left = 15
          Top = 16
          Width = 354
          Height = 57
          Caption = 'Backup Destination'
          Columns = 2
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'ERP Backup Server'
            'Custom FTP Server')
          ParentFont = False
          TabOrder = 0
          OnClick = rgOffsiteBackupTargetTypeClick
        end
        object chkEnableOffsiteBackup: TCheckBox
          Left = 383
          Top = 40
          Width = 152
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Enable Offsite Backup'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = chkEnableOffsiteBackupClick
        end
        object pnlFTPServer: TDNMPanel
          Left = 15
          Top = 79
          Width = 538
          Height = 98
          BevelInner = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 2
          object Label1: TLabel
            Left = 14
            Top = 39
            Width = 74
            Height = 15
            Caption = 'Server Name'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label154: TLabel
            Left = 14
            Top = 6
            Width = 112
            Height = 15
            HelpContext = 484231
            Caption = 'FTP Server Settings'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            Transparent = True
          end
          object Label2: TLabel
            Left = 14
            Top = 68
            Width = 63
            Height = 15
            Caption = 'User Name'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label3: TLabel
            Left = 268
            Top = 68
            Width = 58
            Height = 15
            Alignment = taRightJustify
            Caption = 'Password'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 300
            Top = 39
            Width = 26
            Height = 15
            Alignment = taRightJustify
            Caption = 'Path'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblMsg1: TLabel
            Left = 138
            Top = 6
            Width = 243
            Height = 15
            Caption = '(Contact your IT specialist for these settings)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object edtFTPHost: TEdit
            Left = 99
            Top = 36
            Width = 180
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = 'edtFTPHost'
            OnChange = edtFTPHostChange
          end
          object edtFTPUser: TEdit
            Left = 99
            Top = 65
            Width = 125
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = 'edtFTPUser'
            OnChange = edtFTPUserChange
          end
          object edtFTPPass: TEdit
            Left = 340
            Top = 65
            Width = 125
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 2
            Text = 'edtFTPPass'
            OnChange = edtFTPPassChange
          end
          object edtFTPPath: TEdit
            Left = 340
            Top = 36
            Width = 180
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = 'edtFTPPath'
            OnChange = edtFTPPathChange
          end
        end
        object pnlDatabaseList: TDNMPanel
          Left = 15
          Top = 181
          Width = 538
          Height = 199
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 3
          object Label4: TLabel
            Left = 14
            Top = 6
            Width = 164
            Height = 15
            HelpContext = 484231
            Caption = 'Databases To Backup Offsite'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            Transparent = True
          end
          object lstDbList: TCheckListBox
            Left = 14
            Top = 31
            Width = 499
            Height = 158
            OnClickCheck = lstDbListClickCheck
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            Sorted = True
            TabOrder = 0
          end
        end
      end
    end
    object tabRestore: TTabSheet
      Caption = 'Restore'
      ImageIndex = 1
      object pnlRestore: TDNMPanel
        Left = 0
        Top = 0
        Width = 569
        Height = 387
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        Transparent = False
        object chkEnableOffsiteRestore: TCheckBox
          Left = 18
          Top = 24
          Width = 152
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Enable Offsite Restore'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = chkEnableOffsiteRestoreClick
        end
        object DNMPanel1: TDNMPanel
          Left = 18
          Top = 53
          Width = 538
          Height = 98
          BevelInner = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 1
          object Label6: TLabel
            Left = 14
            Top = 38
            Width = 74
            Height = 15
            Caption = 'Server Name'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label7: TLabel
            Left = 14
            Top = 6
            Width = 112
            Height = 15
            HelpContext = 484231
            Caption = 'FTP Server Settings'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            Transparent = True
          end
          object Label8: TLabel
            Left = 14
            Top = 67
            Width = 63
            Height = 15
            Caption = 'User Name'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label9: TLabel
            Left = 268
            Top = 67
            Width = 58
            Height = 15
            Alignment = taRightJustify
            Caption = 'Password'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label10: TLabel
            Left = 300
            Top = 38
            Width = 26
            Height = 15
            Alignment = taRightJustify
            Caption = 'Path'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblMsg2: TLabel
            Left = 138
            Top = 6
            Width = 243
            Height = 15
            Caption = '(Contact your IT specialist for these settings)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object edtRestoreFTPHost: TEdit
            Left = 99
            Top = 35
            Width = 180
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = 'edtRestoreFTPHost'
            OnChange = edtRestoreFTPHostChange
          end
          object edtRestoreFTPUser: TEdit
            Left = 99
            Top = 64
            Width = 125
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = 'edtRestoreFTPUser'
            OnChange = edtRestoreFTPUserChange
          end
          object edtRestoreFTPPass: TEdit
            Left = 340
            Top = 64
            Width = 125
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 2
            Text = 'edtRestoreFTPPass'
            OnChange = edtRestoreFTPPassChange
          end
          object edtRestoreFTPPath: TEdit
            Left = 340
            Top = 35
            Width = 180
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = 'edtRestoreFTPPath'
            OnChange = edtRestoreFTPPathChange
          end
        end
        object DNMPanel2: TDNMPanel
          Left = 18
          Top = 218
          Width = 538
          Height = 165
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 2
          object Label11: TLabel
            Left = 14
            Top = 6
            Width = 125
            Height = 15
            HelpContext = 484231
            Caption = 'Databases To Restore'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            Transparent = True
          end
          object Label12: TLabel
            Left = 17
            Top = 30
            Width = 74
            Height = 15
            Caption = 'Restore Path'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtRestoreLocalPath: TEdit
            Left = 102
            Top = 27
            Width = 262
            Height = 23
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = 'edtRestoreLocalPath'
            OnChange = edtRestoreLocalPathChange
          end
          object btnRestoreLocalPath: TDNMSpeedButton
            Left = 360
            Top = 27
            Width = 31
            Height = 23
            Caption = '...'
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
            TabOrder = 1
            OnClick = btnRestoreLocalPathClick
          end
          object lstRestoreDb: TCheckListBox
            Left = 17
            Top = 58
            Width = 504
            Height = 100
            OnClickCheck = lstRestoreDbClickCheck
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            Sorted = True
            TabOrder = 2
          end
        end
        object pnlTime: TDNMPanel
          Left = 18
          Top = 157
          Width = 538
          Height = 59
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          Transparent = False
          object Label13: TLabel
            Left = 14
            Top = 6
            Width = 74
            Height = 15
            HelpContext = 484231
            Caption = 'Check Times'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            Transparent = True
          end
          object Label14: TLabel
            Left = 102
            Top = 34
            Width = 59
            Height = 15
            Caption = 'Start Time'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label15: TLabel
            Left = 302
            Top = 34
            Width = 52
            Height = 15
            Caption = 'End Time'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label16: TLabel
            Left = 138
            Top = 6
            Width = 335
            Height = 15
            Caption = '(Onle check for new backups to restore between these times)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object dtRestoreTimeEnd: TDateTimePicker
            Left = 368
            Top = 29
            Width = 103
            Height = 23
            Date = 42389.419233518520000000
            Time = 42389.419233518520000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Kind = dtkTime
            ParentFont = False
            TabOrder = 0
            OnCloseUp = dtRestoreTimeEndCloseUp
            OnChange = dtRestoreTimeEndChange
          end
          object dtRestoreTimeStart: TDateTimePicker
            Left = 174
            Top = 29
            Width = 103
            Height = 23
            Date = 42389.419233518520000000
            Time = 42389.419233518520000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Kind = dtkTime
            ParentFont = False
            TabOrder = 1
            OnCloseUp = dtRestoreTimeStartCloseUp
            OnChange = dtRestoreTimeStartChange
          end
        end
      end
    end
  end
end
