object fmSiteConfig: TfmSiteConfig
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Site Config'
  ClientHeight = 470
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  DesignSize = (
    428
    470)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 98
    Height = 15
    Caption = 'Descriptive Name'
  end
  object edtName: TEdit
    Left = 120
    Top = 13
    Width = 281
    Height = 23
    TabOrder = 0
  end
  object chkActive: TCheckBox
    Left = 16
    Top = 441
    Width = 57
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Active'
    TabOrder = 4
  end
  object btnOk: TButton
    Left = 128
    Top = 437
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Caption = 'Ok'
    TabOrder = 5
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 224
    Top = 437
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object gbSource: TGroupBox
    Left = 16
    Top = 76
    Width = 391
    Height = 113
    Caption = 'Source'
    TabOrder = 1
    object Label2: TLabel
      Left = 13
      Top = 24
      Width = 25
      Height = 15
      Caption = 'URL'
    end
    object Label4: TLabel
      Left = 13
      Top = 53
      Width = 54
      Height = 15
      Caption = 'Database'
    end
    object Label5: TLabel
      Left = 13
      Top = 82
      Width = 27
      Height = 15
      Caption = 'User'
    end
    object Label6: TLabel
      Left = 200
      Top = 82
      Width = 56
      Height = 15
      Caption = 'Password'
    end
    object edtSourceURL: TEdit
      Left = 73
      Top = 21
      Width = 305
      Height = 23
      TabOrder = 0
    end
    object edtSourceDatabase: TEdit
      Left = 73
      Top = 50
      Width = 304
      Height = 23
      TabOrder = 1
    end
    object edtSourceUser: TEdit
      Left = 73
      Top = 79
      Width = 112
      Height = 23
      TabOrder = 2
    end
    object edtSourcePassword: TEdit
      Left = 265
      Top = 79
      Width = 112
      Height = 23
      TabOrder = 3
    end
  end
  object gbDest: TGroupBox
    Left = 16
    Top = 195
    Width = 391
    Height = 113
    Caption = 'Destination'
    TabOrder = 2
    object Label3: TLabel
      Left = 13
      Top = 24
      Width = 25
      Height = 15
      Caption = 'URL'
    end
    object Label7: TLabel
      Left = 13
      Top = 53
      Width = 54
      Height = 15
      Caption = 'Database'
    end
    object Label8: TLabel
      Left = 13
      Top = 82
      Width = 27
      Height = 15
      Caption = 'User'
    end
    object Label9: TLabel
      Left = 200
      Top = 82
      Width = 56
      Height = 15
      Caption = 'Password'
    end
    object edtDestURL: TEdit
      Left = 72
      Top = 21
      Width = 305
      Height = 23
      TabOrder = 0
    end
    object edtDestDatabase: TEdit
      Left = 72
      Top = 50
      Width = 304
      Height = 23
      TabOrder = 1
    end
    object edtDestUser: TEdit
      Left = 72
      Top = 79
      Width = 112
      Height = 23
      TabOrder = 2
    end
    object edtDestPassword: TEdit
      Left = 265
      Top = 79
      Width = 112
      Height = 23
      TabOrder = 3
    end
  end
  object gbSyncTime: TGroupBox
    Left = 16
    Top = 314
    Width = 391
    Height = 113
    Caption = 'Synchronise Time'
    TabOrder = 3
    object Label10: TLabel
      Left = 12
      Top = 29
      Width = 53
      Height = 15
      Caption = 'Next Sync'
    end
    object Label11: TLabel
      Left = 14
      Top = 57
      Width = 39
      Height = 15
      Caption = 'Interval'
    end
    object Label12: TLabel
      Left = 127
      Top = 57
      Width = 47
      Height = 15
      Caption = '(hh:mm)'
    end
    object dtNextDate: TDateTimePicker
      Left = 73
      Top = 24
      Width = 99
      Height = 23
      Date = 40890.498920717590000000
      Time = 40890.498920717590000000
      TabOrder = 0
    end
    object dtNextTime: TDateTimePicker
      Left = 177
      Top = 24
      Width = 99
      Height = 23
      Date = 40890.498920717590000000
      Time = 40890.498920717590000000
      Kind = dtkTime
      TabOrder = 1
    end
    object edtInterval: TMaskEdit
      Left = 73
      Top = 53
      Width = 48
      Height = 23
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 2
      Text = '  :  '
    end
    object chkSat: TCheckBox
      Left = 14
      Top = 85
      Width = 47
      Height = 17
      Caption = 'Sat'
      TabOrder = 3
    end
    object chkSun: TCheckBox
      Left = 68
      Top = 85
      Width = 47
      Height = 17
      Caption = 'Sun'
      TabOrder = 4
    end
    object chkMon: TCheckBox
      Left = 123
      Top = 85
      Width = 47
      Height = 17
      Caption = 'Mon'
      TabOrder = 5
    end
    object chkTues: TCheckBox
      Left = 177
      Top = 85
      Width = 47
      Height = 17
      Caption = 'Tues'
      TabOrder = 6
    end
    object chkWeds: TCheckBox
      Left = 232
      Top = 85
      Width = 47
      Height = 17
      Caption = 'Wed'
      TabOrder = 7
    end
    object chkThurs: TCheckBox
      Left = 286
      Top = 85
      Width = 47
      Height = 17
      Caption = 'Thur'
      TabOrder = 8
    end
    object chkFri: TCheckBox
      Left = 341
      Top = 85
      Width = 47
      Height = 17
      Caption = 'Fri'
      TabOrder = 9
    end
  end
  object chkTwoWaySynch: TCheckBox
    Left = 29
    Top = 44
    Width = 171
    Height = 17
    Caption = 'Two Way Synchronisation'
    TabOrder = 7
  end
end
