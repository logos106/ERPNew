inherited fmLicenceList: TfmLicenceList
  Left = 219
  Top = 231
  Width = 829
  Height = 394
  Caption = 'Licence List'
  PixelsPerInch = 96
  TextHeight = 15
  inherited pnlTop: TPanel
    Width = 821
    Height = 52
    object Label1: TLabel [0]
      Left = 96
      Top = 8
      Width = 85
      Height = 15
      Caption = 'Licence Status'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btnRefresh: TButton
      Top = 16
      TabOrder = 3
    end
    object cbStatus: TComboBox
      Left = 96
      Top = 24
      Width = 121
      Height = 23
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemHeight = 15
      ParentFont = False
      TabOrder = 0
      OnChange = cbStatusChange
      Items.Strings = (
        'lsUnknown'
        'lsPending'
        'lsLicenced'
        'lsHold'
        'lsCancelled'
        'lsReview'
        'lsExpired')
    end
    object chkAllStatus: TCheckBox
      Left = 224
      Top = 27
      Width = 41
      Height = 17
      Caption = 'All'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = chkAllStatusClick
    end
    object rgLicenceActive: TRadioGroup
      Left = 511
      Top = 8
      Width = 217
      Height = 37
      Caption = ' Licence '
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        'Active'
        'Inactive'
        'All')
      ParentFont = False
      TabOrder = 2
    end
    object rgClientActive: TRadioGroup
      Left = 282
      Top = 8
      Width = 216
      Height = 37
      Caption = ' Client '
      Columns = 3
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        'Active'
        'Inactive'
        'All')
      ParentFont = False
      TabOrder = 4
    end
  end
  inherited gdMain: TwwDBGrid
    Top = 52
    Width = 821
    Height = 308
    ControlType.Strings = (
      'ClientActive;CheckBox;T;F'
      'ComputerActive;CheckBox;T;F'
      'LicenceActive;CheckBox;T;F')
    Selected.Strings = (
      'ClientActive'#9'9'#9'Client Active'#9#9
      'ClientName'#9'32'#9'Client Name'#9#9
      'ClientDateTime'#9'18'#9'Client Date Time'#9#9
      'ClientUser'#9'8'#9'Client User'#9#9
      'ComputerActive'#9'13'#9'Computer Active'#9#9
      'ComputerName'#9'22'#9'Computer Name'#9#9
      'ComputerNotes'#9'12'#9'Computer Notes'#9#9
      'ComputerDateTime'#9'18'#9'Computer Date Time'#9#9
      'ComputerUser'#9'16'#9'Computer User'#9#9
      'LicenceActive'#9'11'#9'Licence Active'#9#9
      'LicenceSoftwareName'#9'16'#9'Software'#9#9
      'LicenceStartDate'#9'10'#9'Start Date'#9#9
      'LicenceExpireDate'#9'10'#9'Expire Date'#9#9
      'LicenceConcurrentUsers'#9'5'#9'Users'#9#9
      'LicenceStatus'#9'12'#9'Licence Status'#9#9
      'LicenceStatusReason'#9'23'#9'Licence Status Reason'#9#9
      'LicenceDataText'#9'13'#9'Licence Data Text'#9#9
      'LicenceNotes'#9'11'#9'Licence Notes'#9#9
      'LicenceDateTime'#9'18'#9'Licence Date Time'#9#9
      'LicenceUser'#9'10'#9'Licence User'#9#9)
    ReadOnly = True
    UseTFields = False
    OnDblClick = gdMainDblClick
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'select '
      'c.id as ClientID,'
      'c.active as ClientActive,'
      'c.name as ClientName,'
      'c.datetime as ClientDateTime,'
      'c.user as ClientUser,'
      'u.id as ComputerId,'
      'u.clientid as ComputerClientId,'
      'u.active as ComputerActive,'
      'u.computername as ComputerName,'
      'u.notes as ComputerNotes,'
      'u.datetime as ComputerDateTime,'
      'u.user as ComputerUser,'
      'l.id as LicenceId,'
      'l.computerId as LicenceComputerId,'
      'l.active as LicenceActive,'
      'l.softwarename as LicenceSoftwareName,'
      'l.startdate as LicenceStartDate,'
      'l.expiredate as LicenceExpireDate,'
      'l.concurrentusers as LicenceConcurrentUsers,'
      'l.status as LicenceStatus,'
      'l.statusreason as LicenceStatusReason,'
      'l.datatext as LicenceDataText,'
      'l.notes as LicenceNotes,'
      'l.datetime as LicenceDateTime,'
      'l.user as LicenceUser'
      'from tclientconfig c, tcomputer u, tsoftwarelicence l'
      'where c.id = u.clientid and u.id = l.computerid')
    Left = 96
    Top = 176
  end
  inherited dsMain: TDataSource
    Left = 136
    Top = 184
  end
  inherited MyConnection1: TMyConnection
    Left = 56
    Top = 168
  end
end
