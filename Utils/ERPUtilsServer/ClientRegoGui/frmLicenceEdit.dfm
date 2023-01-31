inherited fmLicenceEdit: TfmLicenceEdit
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'Licence'
  ClientHeight = 345
  ClientWidth = 437
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 14
    Top = 19
    Width = 50
    Height = 14
    Caption = 'Software'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel [1]
    Left = 14
    Top = 51
    Width = 35
    Height = 14
    Caption = 'Status'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 14
    Top = 83
    Width = 41
    Height = 14
    Caption = 'Reason'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel [3]
    Left = 14
    Top = 123
    Width = 53
    Height = 14
    Caption = 'Start Date'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel [4]
    Left = 190
    Top = 123
    Width = 61
    Height = 14
    Caption = 'Expire Date'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel [5]
    Left = 14
    Top = 163
    Width = 33
    Height = 14
    Caption = 'Users'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel [6]
    Left = 14
    Top = 195
    Width = 32
    Height = 14
    Caption = 'Notes'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel [7]
    Left = 14
    Top = 251
    Width = 23
    Height = 14
    Caption = 'Data'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlBottom: TPanel
    Top = 309
    Width = 437
    inherited btnOk: TButton
      Left = 16
    end
  end
  object edtSoftwareName: TDBEdit [9]
    Left = 72
    Top = 17
    Width = 107
    Height = 21
    DataField = 'softwarename'
    DataSource = dsLicence
    TabOrder = 1
  end
  object DBComboBox1: TDBComboBox [10]
    Left = 72
    Top = 48
    Width = 129
    Height = 21
    Style = csDropDownList
    DataField = 'status'
    DataSource = dsLicence
    ItemHeight = 13
    Items.Strings = (
      'lsUnknown'
      'lsPending'
      'lsLicenced'
      'lsHold'
      'lsCancelled'
      'lsReview'
      'lsExpired')
    TabOrder = 2
  end
  object edtStatusReason: TDBEdit [11]
    Left = 72
    Top = 81
    Width = 337
    Height = 21
    DataField = 'statusreason'
    DataSource = dsLicence
    TabOrder = 3
  end
  object dtpStartDate: TwwDBDateTimePicker [12]
    Left = 72
    Top = 120
    Width = 89
    Height = 21
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'startdate'
    DataSource = dsLicence
    Epoch = 1950
    ShowButton = True
    TabOrder = 4
  end
  object dtpExpireDate: TwwDBDateTimePicker [13]
    Left = 264
    Top = 120
    Width = 89
    Height = 21
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'expiredate'
    DataSource = dsLicence
    Epoch = 1950
    ShowButton = True
    TabOrder = 5
  end
  object edtUsers: TwwDBEdit [14]
    Left = 72
    Top = 160
    Width = 41
    Height = 21
    DataField = 'concurrentusers'
    DataSource = dsLicence
    TabOrder = 6
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object memNotes: TDBMemo [15]
    Left = 72
    Top = 192
    Width = 337
    Height = 49
    DataField = 'notes'
    DataSource = dsLicence
    TabOrder = 7
  end
  object DBMemo1: TDBMemo [16]
    Left = 72
    Top = 248
    Width = 337
    Height = 49
    DataField = 'datatext'
    DataSource = dsLicence
    ReadOnly = True
    TabOrder = 8
  end
  object chkActive: TwwCheckBox [17]
    Left = 213
    Top = 51
    Width = 56
    Height = 15
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Caption = 'Active'
    DataField = 'active'
    DataSource = dsLicence
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  inherited alMain: TActionList
    Left = 248
    Top = 24
    inherited actOk: TAction
      OnExecute = actOkExecute
    end
    inherited actCancel: TAction
      OnExecute = actCancelExecute
    end
  end
  inherited TransConnection: TMyConnection
    Server = ''
    Left = 288
    Top = 16
  end
  object qryLicence: TMyQuery
    Connection = TransConnection
    SQL.Strings = (
      'select * from tsoftwarelicence where id = :KeyID')
    BeforePost = qryLicenceBeforePost
    Left = 264
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
  end
  object dsLicence: TDataSource
    DataSet = qryLicence
    Left = 288
    Top = 48
  end
end
