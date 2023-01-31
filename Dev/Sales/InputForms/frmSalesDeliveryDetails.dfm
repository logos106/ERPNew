inherited fmSalesDeliveryDetails: TfmSalesDeliveryDetails
  Left = 746
  Top = 251
  HelpContext = 881001
  Caption = 'fmSalesDeliveryDetails'
  ClientHeight = 378
  ExplicitLeft = 746
  ExplicitTop = 251
  ExplicitHeight = 417
  DesignSize = (
    538
    378)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 301
    ExplicitTop = 298
  end
  inherited DNMPanel3: TDNMPanel
    Top = 301
    Height = 77
    HelpContext = 881024
    ExplicitTop = 301
    ExplicitHeight = 77
    DesignSize = (
      538
      77)
    inherited chkHide: TCheckBox
      OnClick = chkHideClick
    end
  end
  inherited DNMPanel1: TDNMPanel
    HelpContext = 881026
    inherited pnlTitle: TDNMPanel
      HelpContext = 881027
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          HelpContext = 881025
          Caption = 'Delivery Details'
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Height = 243
    HelpContext = 881002
    ExplicitHeight = 240
    DesignSize = (
      538
      243)
    object Bevel4: TBevel
      Left = 271
      Top = 72
      Width = 262
      Height = 164
      HelpContext = 881003
    end
    object Bevel1: TBevel
      Left = 2
      Top = 4
      Width = 265
      Height = 109
      HelpContext = 881004
    end
    object Label1: TLabel
      Left = 37
      Top = 7
      Width = 173
      Height = 16
      HelpContext = 881005
      Caption = 'Delivery Planned Between '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 118
      Top = 59
      Width = 28
      Height = 16
      HelpContext = 881006
      Caption = 'and '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel2: TBevel
      Left = 3
      Top = 117
      Width = 265
      Height = 59
      HelpContext = 881007
    end
    object Label3: TLabel
      Left = 38
      Top = 120
      Width = 133
      Height = 16
      HelpContext = 881008
      Caption = 'Delivery Promised At'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 12
      Top = 184
      Width = 87
      Height = 16
      HelpContext = 881009
      Caption = 'Delay Reason'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 275
      Top = 74
      Width = 118
      Height = 16
      HelpContext = 881010
      Caption = 'Delivery Feedback'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel3: TBevel
      Left = 270
      Top = 4
      Width = 262
      Height = 62
      HelpContext = 881011
    end
    object Label5: TLabel
      Left = 279
      Top = 7
      Width = 132
      Height = 16
      HelpContext = 881012
      Caption = 'Actual Delivery Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel5: TBevel
      Left = 3
      Top = 180
      Width = 265
      Height = 56
      HelpContext = 881013
    end
    object cboPlannedDelfromTime: TDBComboBox
      Left = 134
      Top = 29
      Width = 115
      Height = 23
      Hint = '"Select The Time That The Appointment Will Start"'
      HelpContext = 881014
      AutoDropDown = True
      DataField = 'PlannedDelfromTime'
      DataSource = DataSource
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        '0:00 AM'
        '0:30 AM'
        '1:00 AM'
        '1:30 AM'
        '2:00 AM'
        '2:30 AM'
        '3:00 AM'
        '3:30 AM'
        '4:00 AM'
        '4:30 AM'
        '5:00 AM'
        '5:30 AM'
        '6:00 AM'
        '6:30 AM'
        '7:00 AM'
        '7:30 AM'
        '8:00 AM'
        '8:30 AM'
        '9:00 AM'
        '9:30 AM'
        '10:00 AM'
        '10:30 AM'
        '11:00 AM'
        '11:30 AM'
        '12:00 PM'
        '12:30 PM'
        '1:00 PM'
        '1:30 PM'
        '2:00 PM'
        '2:30 PM'
        '3:00 PM'
        '3:30 PM'
        '4:00 PM'
        '4:30 PM'
        '5:00 PM'
        '5:30 PM'
        '6:00 PM'
        '6:30 PM'
        '7:00 PM'
        '7:30 PM'
        '8:00 PM'
        '8:30 PM'
        '9:00 PM'
        '9:30 PM'
        '10:00 PM'
        '10:30 PM'
        '11:00 PM'
        '11:30 PM'
        '12:00 AM'
        '12:30 AM')
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object dtPlannedDelfromDt: TwwDBDateTimePicker
      Left = 12
      Top = 29
      Width = 115
      Height = 23
      HelpContext = 881015
      AutoSize = False
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'PlannedDelfromDt'
      DataSource = DataSource
      Date = 40605.000000000000000000
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 0
    end
    object dtPlannedDelToDt: TwwDBDateTimePicker
      Left = 12
      Top = 81
      Width = 115
      Height = 24
      HelpContext = 881016
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'PlannedDelToDt'
      DataSource = DataSource
      Date = 40605.000000000000000000
      Epoch = 1950
      Time = 0.375000000000000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 2
    end
    object cboPlannedDeltotime: TDBComboBox
      Left = 134
      Top = 81
      Width = 115
      Height = 23
      Hint = '"Select The Approximate Time That The Appointment Will Finish"'
      HelpContext = 881017
      AutoDropDown = True
      DataField = 'PlannedDeltotime'
      DataSource = DataSource
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        '0:00 AM'
        '0:30 AM'
        '1:00 AM'
        '1:30 AM'
        '2:00 AM'
        '2:30 AM'
        '3:00 AM'
        '3:30 AM'
        '4:00 AM'
        '4:30 AM'
        '5:00 AM'
        '5:30 AM'
        '6:00 AM'
        '6:30 AM'
        '7:00 AM'
        '7:30 AM'
        '8:00 AM'
        '8:30 AM'
        '9:00 AM'
        '9:30 AM'
        '10:00 AM'
        '10:30 AM'
        '11:00 AM'
        '11:30 AM'
        '12:00 PM'
        '12:30 PM'
        '1:00 PM'
        '1:30 PM'
        '2:00 PM'
        '2:30 PM'
        '3:00 PM'
        '3:30 PM'
        '4:00 PM'
        '4:30 PM'
        '5:00 PM'
        '5:30 PM'
        '6:00 PM'
        '6:30 PM'
        '7:00 PM'
        '7:30 PM'
        '8:00 PM'
        '8:30 PM'
        '9:00 PM'
        '9:30 PM'
        '10:00 PM'
        '10:30 PM'
        '11:00 PM'
        '11:30 PM'
        '12:00 AM'
        '12:30 AM')
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object dtPromisedDelDt: TwwDBDateTimePicker
      Left = 13
      Top = 139
      Width = 116
      Height = 23
      HelpContext = 881018
      AutoSize = False
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'PromisedDelDt'
      DataSource = DataSource
      Date = 40605.000000000000000000
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 4
    end
    object cboPromisedDeltime: TDBComboBox
      Left = 135
      Top = 139
      Width = 115
      Height = 23
      Hint = '"Select The Time That The Appointment Will Start"'
      HelpContext = 881019
      AutoDropDown = True
      DataField = 'PromisedDeltime'
      DataSource = DataSource
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        '0:00 AM'
        '0:30 AM'
        '1:00 AM'
        '1:30 AM'
        '2:00 AM'
        '2:30 AM'
        '3:00 AM'
        '3:30 AM'
        '4:00 AM'
        '4:30 AM'
        '5:00 AM'
        '5:30 AM'
        '6:00 AM'
        '6:30 AM'
        '7:00 AM'
        '7:30 AM'
        '8:00 AM'
        '8:30 AM'
        '9:00 AM'
        '9:30 AM'
        '10:00 AM'
        '10:30 AM'
        '11:00 AM'
        '11:30 AM'
        '12:00 PM'
        '12:30 PM'
        '1:00 PM'
        '1:30 PM'
        '2:00 PM'
        '2:30 PM'
        '3:00 PM'
        '3:30 PM'
        '4:00 PM'
        '4:30 PM'
        '5:00 PM'
        '5:30 PM'
        '6:00 PM'
        '6:30 PM'
        '7:00 PM'
        '7:30 PM'
        '8:00 PM'
        '8:30 PM'
        '9:00 PM'
        '9:30 PM'
        '10:00 PM'
        '10:30 PM'
        '11:00 PM'
        '11:30 PM'
        '12:00 AM'
        '12:30 AM')
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    object cboDelayreson: TwwDBLookupCombo
      Left = 12
      Top = 204
      Width = 238
      Height = 23
      HelpContext = 881020
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlInfoInDataset = False
      DropDownAlignment = taLeftJustify
      DataField = 'CauseofDelay'
      DataSource = DataSource
      LookupTable = QryDelayreason
      LookupField = 'Name'
      AutoSelect = False
      DropDownWidth = 50
      MaxLength = 255
      ParentFont = False
      TabOrder = 6
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      ShowMatchText = True
      OnDblClick = cboDelayresonDblClick
      OnCloseUp = cboDelayresonCloseUp
      OnNotInList = cboDelayresonNotInList
    end
    object txtFeedBack: TDBMemo
      Left = 274
      Top = 92
      Width = 255
      Height = 138
      Hint = '"Type In A Comment For The Warehouse"'
      HelpContext = 881021
      Anchors = [akLeft, akBottom]
      DataField = 'FeedBack'
      DataSource = DataSource
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 9
    end
    object dtActualDelDt: TwwDBDateTimePicker
      Left = 275
      Top = 29
      Width = 116
      Height = 23
      HelpContext = 881022
      AutoSize = False
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ActualDelDt'
      DataSource = DataSource
      Date = 40605.000000000000000000
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 7
    end
    object cboActualDeltime: TDBComboBox
      Left = 398
      Top = 29
      Width = 115
      Height = 23
      Hint = '"Select The Time That The Appointment Will Start"'
      HelpContext = 881023
      AutoDropDown = True
      DataField = 'ActualDeltime'
      DataSource = DataSource
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        '0:00 AM'
        '0:30 AM'
        '1:00 AM'
        '1:30 AM'
        '2:00 AM'
        '2:30 AM'
        '3:00 AM'
        '3:30 AM'
        '4:00 AM'
        '4:30 AM'
        '5:00 AM'
        '5:30 AM'
        '6:00 AM'
        '6:30 AM'
        '7:00 AM'
        '7:30 AM'
        '8:00 AM'
        '8:30 AM'
        '9:00 AM'
        '9:30 AM'
        '10:00 AM'
        '10:30 AM'
        '11:00 AM'
        '11:30 AM'
        '12:00 PM'
        '12:30 PM'
        '1:00 PM'
        '1:30 PM'
        '2:00 PM'
        '2:30 PM'
        '3:00 PM'
        '3:30 PM'
        '4:00 PM'
        '4:30 PM'
        '5:00 PM'
        '5:30 PM'
        '6:00 PM'
        '6:30 PM'
        '7:00 PM'
        '7:30 PM'
        '8:00 PM'
        '8:30 PM'
        '9:00 PM'
        '9:30 PM'
        '10:00 PM'
        '10:30 PM'
        '11:00 PM'
        '11:30 PM'
        '12:00 AM'
        '12:30 AM')
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
    end
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 128
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102002C00380010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited QryCustomField: TERPQuery
    Top = 272
  end
  inherited DataSource: TDataSource
    Left = 472
    Top = 272
  end
  object QryDelayreason: TERPQuery
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'SalesDelDelayReason'#39
      'ORDER BY Name')
    Left = 504
    Top = 272
  end
end
