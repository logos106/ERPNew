inherited AppointmentGUI: TAppointmentGUI
  Left = 343
  Top = 166
  HelpContext = 11000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Appointment'
  ClientHeight = 564
  ClientWidth = 807
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  ExplicitLeft = 343
  ExplicitTop = 166
  ExplicitWidth = 823
  ExplicitHeight = 603
  DesignSize = (
    807
    564)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 564
    Width = 807
    HelpContext = 11114
    ExplicitTop = 564
    ExplicitWidth = 821
  end
  inherited imgGridWatermark: TImage
    HelpContext = 11001
  end
  inherited shapehintextra1: TShape
    Left = 52
    ExplicitLeft = 52
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 439
    Width = 807
    Height = 125
    HelpContext = 11002
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lblConverted: TLabel
      Left = 0
      Top = 78
      Width = 803
      Height = 24
      HelpContext = 11004
      Align = alBottom
      Alignment = taCenter
      Caption = 'Has Been Converted'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitWidth = 208
    end
    object Label11: TLabel
      Left = 408
      Top = 2
      Width = 104
      Height = 18
      HelpContext = 11005
      AutoSize = False
      Caption = 'Feedback Notes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label4: TLabel
      Left = 10
      Top = 2
      Width = 38
      Height = 14
      HelpContext = 11006
      AutoSize = False
      Caption = 'Notes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblMsg: TLabel
      Left = 0
      Top = 102
      Width = 803
      Height = 19
      HelpContext = 11188
      Align = alBottom
      Alignment = taCenter
      Caption = 'Msg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitWidth = 32
    end
    object lstTimes: TListBox
      Left = 248
      Top = 56
      Width = 33
      Height = 33
      HelpContext = 11009
      ItemHeight = 18
      TabOrder = 2
      Visible = False
    end
    object txtNotes: TDBMemo
      Left = 8
      Top = 21
      Width = 395
      Height = 74
      HelpContext = 11010
      DataField = 'Notes'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object txtFeedbackNotes: TDBMemo
      Left = 409
      Top = 21
      Width = 404
      Height = 74
      HelpContext = 11011
      DataField = 'FeedbackNotes'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 328
      Top = 3
      Width = 75
      Height = 18
      HelpContext = 11115
      Caption = 'Add Date'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton1Click
    end
    object DNMSpeedButton2: TDNMSpeedButton
      Left = 737
      Top = 3
      Width = 75
      Height = 18
      HelpContext = 11116
      Caption = 'Add Date'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton2Click
    end
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 807
    Height = 439
    HelpContext = 11017
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitTop = -1
    DesignSize = (
      807
      439)
    object Bevel11: TBevel
      Left = 324
      Top = 159
      Width = 140
      Height = 53
      HelpContext = 11018
      Shape = bsFrame
    end
    object Bevel3: TBevel
      Left = 462
      Top = 51
      Width = 355
      Height = 161
      HelpContext = 11172
      Shape = bsFrame
    end
    object Bevel: TBevel
      Left = 710
      Top = 60
      Width = 104
      Height = 92
      HelpContext = 11019
      Shape = bsFrame
    end
    object Bevel2: TBevel
      Left = 10
      Top = 51
      Width = 316
      Height = 161
      HelpContext = 11020
      Shape = bsFrame
    end
    object Label7: TLabel
      Left = 16
      Top = 61
      Width = 58
      Height = 16
      HelpContext = 11021
      AutoSize = False
      Caption = 'Company'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label15: TLabel
      Left = 16
      Top = 84
      Width = 41
      Height = 18
      HelpContext = 11022
      AutoSize = False
      Caption = 'Details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label36: TLabel
      Left = 467
      Top = 162
      Width = 81
      Height = 16
      HelpContext = 11023
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Rep / Last Rep'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object LastTrainerID_Label: TLabel
      Left = 497
      Top = 137
      Width = 51
      Height = 15
      HelpContext = 11024
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Mobile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label9: TLabel
      Left = 522
      Top = 111
      Width = 26
      Height = 17
      HelpContext = 11025
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Fax'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Cus_Alt_PH_Label: TLabel
      Left = 488
      Top = 86
      Width = 60
      Height = 17
      HelpContext = 11026
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Alt Phone'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label6: TLabel
      Left = 488
      Top = 61
      Width = 60
      Height = 17
      HelpContext = 11027
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Co Phone'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label3: TLabel
      Left = 480
      Top = 188
      Width = 68
      Height = 16
      HelpContext = 11028
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Entered By'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblAppNo: TLabel
      Left = 12
      Top = 3
      Width = 99
      Height = 17
      HelpContext = 11029
      Anchors = [akLeft, akTop, akBottom]
      AutoSize = False
      Caption = 'Appointment No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label22: TLabel
      Left = 714
      Top = 65
      Width = 96
      Height = 48
      HelpContext = 11030
      Alignment = taCenter
      AutoSize = False
      Caption = 'Company'#39's Appointment Count'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Bevel1: TBevel
      Left = 324
      Top = 51
      Width = 140
      Height = 110
      HelpContext = 11173
      Shape = bsFrame
    end
    object Label13: TLabel
      Left = 377
      Top = 167
      Width = 32
      Height = 15
      HelpContext = 11003
      Alignment = taRightJustify
      Caption = 'Class'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object DBText1: TDBText
      Left = 718
      Top = 24
      Width = 84
      Height = 24
      HelpContext = 11189
      Alignment = taRightJustify
      AutoSize = True
      DataField = 'DisplayStatus'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtEnteredBy: TwwDBEdit
      Left = 552
      Top = 185
      Width = 150
      Height = 23
      HelpContext = 11031
      TabStop = False
      DataField = 'EnteredByEmployeeName'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 13
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object txtClientDetails: TDBMemo
      Left = 16
      Top = 104
      Width = 276
      Height = 103
      HelpContext = 11034
      DataField = 'CustomerDetails'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object cboLastEmployee: TwwDBLookupCombo
      Left = 710
      Top = 159
      Width = 104
      Height = 23
      HelpContext = 11035
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'30'#9'EmployeeName'#9#9)
      DataField = 'LastTrainerID'
      DataSource = DSMaster
      LookupTable = cboLastRepLookup
      LookupField = 'EmployeeID'
      Style = csDropDownList
      AutoSelect = False
      DropDownCount = 0
      ButtonWidth = -1
      ParentFont = False
      ReadOnly = True
      TabOrder = 15
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnDblClick = cboEmployeeDblClick
      OnNotInList = cboLastEmployeeNotInList
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 554
      Top = 159
      Width = 123
      Height = 23
      HelpContext = 11036
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'30'#9'EmployeeName'#9'T')
      DataField = 'TrainerID'
      DataSource = DSMaster
      LookupTable = cboRepLookup
      LookupField = 'TrainerID'
      ParentFont = False
      TabOrder = 11
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnDblClick = cboEmployeeDblClick
      OnNotInList = cboEmployeeNotInList
    end
    object txtPhone: TwwDBEdit
      Left = 552
      Top = 58
      Width = 150
      Height = 23
      HelpContext = 11037
      DataField = 'Phone'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object txtAltPhone: TwwDBEdit
      Left = 552
      Top = 83
      Width = 150
      Height = 23
      HelpContext = 11038
      DataField = 'AltPhone'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object txtFax: TwwDBEdit
      Left = 552
      Top = 108
      Width = 150
      Height = 23
      HelpContext = 11039
      DataField = 'Fax'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtOverwriteAppID: TwwDBEdit
      Left = 13
      Top = 19
      Width = 78
      Height = 23
      HelpContext = 11044
      DataField = 'AppointID'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object SchedulePageControl: TPageControl
      Left = 8
      Top = 217
      Width = 721
      Height = 217
      HelpContext = 11045
      ActivePage = TabSheet1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabHeight = 23
      TabOrder = 17
      TabWidth = 119
      OnChange = SchedulePageControlChange
      OnResize = SchedulePageControlResize
      object TabSheet1: TTabSheet
        HelpContext = 11046
        Caption = 'Schedule'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DNMPanel2: TDNMPanel
          Left = 0
          Top = 0
          Width = 713
          Height = 184
          HelpContext = 11047
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
          object Bevel4: TBevel
            Left = 403
            Top = 0
            Width = 309
            Height = 133
            HelpContext = 11048
          end
          object Bevel9: TBevel
            Left = 403
            Top = 136
            Width = 309
            Height = 46
            HelpContext = 11049
          end
          object Bevel8: TBevel
            Left = 1
            Top = 136
            Width = 400
            Height = 46
            HelpContext = 11050
          end
          object Bevel5: TBevel
            Left = 1
            Top = 0
            Width = 400
            Height = 134
            HelpContext = 11051
          end
          object Combo15_Label: TLabel
            Left = 15
            Top = 139
            Width = 70
            Height = 15
            HelpContext = 11052
            Caption = 'Charge Rate'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label10: TLabel
            Left = 169
            Top = 139
            Width = 39
            Height = 15
            HelpContext = 11053
            Caption = 'Callout'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Start_Time_Label: TLabel
            Left = 111
            Top = 6
            Width = 34
            Height = 16
            HelpContext = 11054
            AutoSize = False
            Caption = 'Start'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object End_Time_Label: TLabel
            Left = 231
            Top = 6
            Width = 26
            Height = 17
            HelpContext = 11055
            AutoSize = False
            Caption = 'End'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label12: TLabel
            Left = 246
            Top = 139
            Width = 70
            Height = 15
            HelpContext = 11056
            Caption = 'Invoice Total'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label1: TLabel
            Left = 627
            Top = 139
            Width = 80
            Height = 15
            HelpContext = 11057
            Caption = 'Pay Rate Total'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label5: TLabel
            Left = 320
            Top = 6
            Width = 65
            Height = 16
            HelpContext = 11058
            AutoSize = False
            Caption = 'Total  Hrs'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Cancellation_Label: TLabel
            Left = 403
            Top = 31
            Width = 78
            Height = 17
            HelpContext = 11059
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Cancellation'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblRescheduled: TLabel
            Left = 407
            Top = 57
            Width = 74
            Height = 17
            HelpContext = 11060
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Reschedule'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblRescheduleLabel: TLabel
            Left = 407
            Top = 84
            Width = 94
            Height = 19
            HelpContext = 11061
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Resched  from'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Visible = False
          end
          object lblDateCaption: TLabel
            Left = 533
            Top = 6
            Width = 31
            Height = 17
            HelpContext = 11062
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label19: TLabel
            Left = 7
            Top = 32
            Width = 52
            Height = 18
            HelpContext = 11063
            AutoSize = False
            Caption = 'Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblActualDate: TLabel
            Left = 7
            Top = 84
            Width = 76
            Height = 18
            HelpContext = 11064
            AutoSize = False
            Caption = 'Actual Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Bevel6: TBevel
            Left = 1
            Top = 23
            Width = 400
            Height = 2
            HelpContext = 11065
          end
          object lblOutstandinghrs: TLabel
            Left = 417
            Top = 139
            Width = 92
            Height = 15
            HelpContext = 11066
            Caption = 'Outstanding Hrs'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblHrstoInvoice: TLabel
            Left = 529
            Top = 139
            Width = 77
            Height = 15
            HelpContext = 11067
            Caption = 'Hrs to Invoice'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Bevel7: TBevel
            Left = 404
            Top = 23
            Width = 308
            Height = 2
            HelpContext = 11068
          end
          object Label21: TLabel
            Left = 633
            Top = 6
            Width = 43
            Height = 15
            HelpContext = 11069
            Alignment = taRightJustify
            Caption = 'Reason'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label23: TLabel
            Left = 6
            Top = 56
            Width = 28
            Height = 15
            HelpContext = 11070
            Caption = 'Time'
            Transparent = True
          end
          object Bevel10: TBevel
            Left = 3
            Top = 79
            Width = 398
            Height = 2
            HelpContext = 11071
            Shape = bsFrame
          end
          object lblActualTime: TLabel
            Left = 5
            Top = 112
            Width = 67
            Height = 15
            HelpContext = 11072
            Caption = 'Actual Time'
            Transparent = True
          end
          object Label25: TLabel
            Left = 410
            Top = 108
            Width = 71
            Height = 15
            HelpContext = 11073
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Status'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lblCurrency: TLabel
            Left = 7
            Top = 157
            Width = 7
            Height = 15
            HelpContext = 11174
            Alignment = taRightJustify
            AutoSize = False
            Caption = '$'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object txtTotal: TwwDBEdit
            Left = 246
            Top = 153
            Width = 75
            Height = 23
            HelpContext = 11074
            DataField = 'TotalInc'
            DataSource = DSMaster
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object txtCalloutValue: TwwDBEdit
            Left = 169
            Top = 153
            Width = 75
            Height = 23
            HelpContext = 11075
            DataField = 'CalloutValue'
            DataSource = DSMaster
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object cboChargeRate: TwwDBLookupCombo
            Left = 15
            Top = 153
            Width = 75
            Height = 23
            HelpContext = 11076
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ControlType.Strings = (
              'IsFixedRate;CheckBox;T;F')
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Rate'#9'10'#9'Rate'#9'F'#9)
            DataField = 'ServiceID'
            DataSource = DSMaster
            LookupTable = QryAvailableServices
            LookupField = 'ServiceID'
            Options = [loColLines, loTitles]
            ParentFont = False
            TabOrder = 4
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnBeforeDropDown = cboChargeRateBeforeDropDown
            OnCloseUp = cboChargeRateCloseUp
            OnEnter = cboChargeRateEnter
            OnNotInList = cboChargeRateNotInList
          end
          object AppDate: TwwDBDateTimePicker
            Left = 80
            Top = 28
            Width = 100
            Height = 23
            HelpContext = 11077
            AutoSize = False
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'AppDate'
            DataSource = DSMaster
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
            UnboundDataType = wwDTEdtDate
            OnCloseUp = ComboCloseUp
          end
          object txtStartTime: TErpDbTimeCombo
            Left = 80
            Top = 53
            Width = 100
            Height = 23
            Hint = '"Select The Time That The Appointment Will Start"'
            HelpContext = 11180
            DataField = 'Start_Time'
            DataSource = DSMaster
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Items.Strings = (
              '12:00 AM'
              '12:30 AM'
              '01:00 AM'
              '01:30 AM'
              '02:00 AM'
              '02:30 AM'
              '03:00 AM'
              '03:30 AM'
              '04:00 AM'
              '04:30 AM'
              '05:00 AM'
              '05:30 AM'
              '06:00 AM'
              '06:30 AM'
              '07:00 AM'
              '07:30 AM'
              '08:00 AM'
              '08:30 AM'
              '09:00 AM'
              '09:30 AM'
              '10:00 AM'
              '10:30 AM'
              '11:00 AM'
              '11:30 AM'
              '12:00 PM'
              '12:30 PM'
              '01:00 PM'
              '01:30 PM'
              '02:00 PM'
              '02:30 PM'
              '03:00 PM'
              '03:30 PM'
              '04:00 PM'
              '04:30 PM'
              '05:00 PM'
              '05:30 PM'
              '06:00 PM'
              '06:30 PM'
              '07:00 PM'
              '07:30 PM'
              '08:00 PM'
              '08:30 PM'
              '09:00 PM'
              '09:30 PM'
              '10:00 PM'
              '10:30 PM'
              '11:00 PM'
              '11:30 PM')
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 24
            OnDropDown = txtStartTimeDropDown
            Interval = 30
          end
          object txtEndTime: TErpDbTimeCombo
            Left = 197
            Top = 53
            Width = 100
            Height = 23
            Hint = '"Select The Time That The Appointment Will End"'
            HelpContext = 11181
            DataField = 'End_Time'
            DataSource = DSMaster
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Items.Strings = (
              '12:00 AM'
              '12:30 AM'
              '01:00 AM'
              '01:30 AM'
              '02:00 AM'
              '02:30 AM'
              '03:00 AM'
              '03:30 AM'
              '04:00 AM'
              '04:30 AM'
              '05:00 AM'
              '05:30 AM'
              '06:00 AM'
              '06:30 AM'
              '07:00 AM'
              '07:30 AM'
              '08:00 AM'
              '08:30 AM'
              '09:00 AM'
              '09:30 AM'
              '10:00 AM'
              '10:30 AM'
              '11:00 AM'
              '11:30 AM'
              '12:00 PM'
              '12:30 PM'
              '01:00 PM'
              '01:30 PM'
              '02:00 PM'
              '02:30 PM'
              '03:00 PM'
              '03:30 PM'
              '04:00 PM'
              '04:30 PM'
              '05:00 PM'
              '05:30 PM'
              '06:00 PM'
              '06:30 PM'
              '07:00 PM'
              '07:30 PM'
              '08:00 PM'
              '08:30 PM'
              '09:00 PM'
              '09:30 PM'
              '10:00 PM'
              '10:30 PM'
              '11:00 PM'
              '11:30 PM')
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 25
            OnDropDown = txtEndTimeDropDown
            Interval = 30
          end
          object txtLabourCost: TwwDBEdit
            Left = 627
            Top = 154
            Width = 75
            Height = 23
            HelpContext = 11080
            DataField = 'TotalCost'
            DataSource = DSMaster
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object txtTotalTime: TEdit
            Left = 320
            Top = 42
            Width = 63
            Height = 23
            HelpContext = 11081
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            OnDblClick = txtTotalTimeDblClick
          end
          object chkCancellation: TDBCheckBox
            Left = 485
            Top = 31
            Width = 13
            Height = 16
            HelpContext = 11082
            Color = 13686993
            DataField = 'Cancellation'
            DataSource = DSMaster
            ParentColor = False
            TabOrder = 8
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            OnClick = chkCancellationClick
          end
          object cboCancellationDate: TwwDBDateTimePicker
            Left = 505
            Top = 28
            Width = 100
            Height = 23
            HelpContext = 11083
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'CancellationDate'
            DataSource = DSMaster
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 9
            UnboundDataType = wwDTEdtDate
            Visible = False
            OnCloseUp = ComboCloseUp
          end
          object cboRescheduledDate: TwwDBDateTimePicker
            Left = 505
            Top = 54
            Width = 100
            Height = 23
            HelpContext = 11085
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'RescheduledDate'
            DataSource = DSMaster
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 10
            UnboundDataType = wwDTEdtDate
            Visible = False
            OnCloseUp = cboRescheduledDateCloseUp
          end
          object edtlblRescheduleLabel: TwwDBEdit
            Left = 505
            Top = 80
            Width = 100
            Height = 23
            HelpContext = 11086
            TabStop = False
            DataField = 'RescheduledFrom'
            DataSource = DSMaster
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 11
            UnboundDataType = wwDefault
            Visible = False
            WantReturns = False
            WordWrap = False
          end
          object txtActual_appDate: TwwDBDateTimePicker
            Left = 80
            Top = 82
            Width = 100
            Height = 23
            HelpContext = 11087
            AutoSize = False
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'Actual_AppDate'
            DataSource = DSMaster
            Date = 40605.000000000000000000
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 2
            UnboundDataType = wwDTEdtDate
            OnCloseUp = ComboCloseUp
          end
          object txtActualStartTime: TErpDbTimeCombo
            Left = 80
            Top = 109
            Width = 100
            Height = 23
            Hint = '"Select The Time That The Appointment Actually Start"ed'
            HelpContext = 11182
            DataField = 'Actual_Start_time'
            DataSource = DSMaster
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Items.Strings = (
              '12:00 AM'
              '12:30 AM'
              '01:00 AM'
              '01:30 AM'
              '02:00 AM'
              '02:30 AM'
              '03:00 AM'
              '03:30 AM'
              '04:00 AM'
              '04:30 AM'
              '05:00 AM'
              '05:30 AM'
              '06:00 AM'
              '06:30 AM'
              '07:00 AM'
              '07:30 AM'
              '08:00 AM'
              '08:30 AM'
              '09:00 AM'
              '09:30 AM'
              '10:00 AM'
              '10:30 AM'
              '11:00 AM'
              '11:30 AM'
              '12:00 PM'
              '12:30 PM'
              '01:00 PM'
              '01:30 PM'
              '02:00 PM'
              '02:30 PM'
              '03:00 PM'
              '03:30 PM'
              '04:00 PM'
              '04:30 PM'
              '05:00 PM'
              '05:30 PM'
              '06:00 PM'
              '06:30 PM'
              '07:00 PM'
              '07:30 PM'
              '08:00 PM'
              '08:30 PM'
              '09:00 PM'
              '09:30 PM'
              '10:00 PM'
              '10:30 PM'
              '11:00 PM'
              '11:30 PM')
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 22
            OnDropDown = txtActualStarttimeDropDown
            Interval = 30
          end
          object txtActualEndTime: TErpDbTimeCombo
            Left = 197
            Top = 109
            Width = 100
            Height = 23
            Hint = '"Select The Time That The Appointment Actually Ended"'
            HelpContext = 11183
            DataField = 'Actual_End_time'
            DataSource = DSMaster
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Items.Strings = (
              '12:00 AM'
              '12:30 AM'
              '01:00 AM'
              '01:30 AM'
              '02:00 AM'
              '02:30 AM'
              '03:00 AM'
              '03:30 AM'
              '04:00 AM'
              '04:30 AM'
              '05:00 AM'
              '05:30 AM'
              '06:00 AM'
              '06:30 AM'
              '07:00 AM'
              '07:30 AM'
              '08:00 AM'
              '08:30 AM'
              '09:00 AM'
              '09:30 AM'
              '10:00 AM'
              '10:30 AM'
              '11:00 AM'
              '11:30 AM'
              '12:00 PM'
              '12:30 PM'
              '01:00 PM'
              '01:30 PM'
              '02:00 PM'
              '02:30 PM'
              '03:00 PM'
              '03:30 PM'
              '04:00 PM'
              '04:30 PM'
              '05:00 PM'
              '05:30 PM'
              '06:00 PM'
              '06:30 PM'
              '07:00 PM'
              '07:30 PM'
              '08:00 PM'
              '08:30 PM'
              '09:00 PM'
              '09:30 PM'
              '10:00 PM'
              '10:30 PM'
              '11:00 PM'
              '11:30 PM')
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 23
            OnDropDown = txtActualEndTimeDropDown
            Interval = 30
          end
          object txtActualtotaltime: TEdit
            Left = 322
            Top = 87
            Width = 63
            Height = 23
            HelpContext = 11090
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
            OnDblClick = txtActualtotaltimeDblClick
          end
          object chkRescheduled: TDBCheckBox
            Left = 485
            Top = 58
            Width = 14
            Height = 15
            HelpContext = 11091
            Color = 13686993
            DataField = 'Reschedulled'
            DataSource = DSMaster
            ParentColor = False
            TabOrder = 12
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            OnClick = chkRescheduledClick
          end
          object txtOutstandinghrs: TwwDBEdit
            Left = 417
            Top = 154
            Width = 75
            Height = 23
            HelpContext = 11092
            DataSource = DSMaster
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 13
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object txtHrsToInvoice: TwwDBEdit
            Left = 529
            Top = 154
            Width = 75
            Height = 23
            HelpContext = 11093
            DataField = 'HrstoInvoice'
            DataSource = DSMaster
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 15
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object cboCancellationReason: TwwDBLookupCombo
            Left = 608
            Top = 28
            Width = 100
            Height = 23
            HelpContext = 11094
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Name'#9'30'#9'Reason'#9'F')
            DataField = 'CancellationReason'
            DataSource = DSMaster
            LookupTable = qryCancellationReason
            LookupField = 'Name'
            Options = [loColLines, loTitles]
            ParentFont = False
            TabOrder = 17
            Visible = False
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnNotInList = cboCancellationReasonNotInList
          end
          object dtAppEndDate: TwwDBDateTimePicker
            Left = 197
            Top = 28
            Width = 100
            Height = 23
            HelpContext = 11095
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'ENDTIME'
            DataSource = DSMaster
            Date = 40605.000000000000000000
            Epoch = 1950
            Time = 0.375000000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 19
            OnCloseUp = ComboCloseUp
          end
          object dtActualEndDate: TwwDBDateTimePicker
            Left = 197
            Top = 82
            Width = 100
            Height = 23
            HelpContext = 11096
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'Actual_Endtime'
            DataSource = DSMaster
            Date = 40605.000000000000000000
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 21
            UnboundDataType = wwDTEdtDate
            OnCloseUp = ComboCloseUp
          end
          object cboFollowUpResult: TwwDBLookupCombo
            Left = 485
            Top = 105
            Width = 222
            Height = 23
            HelpContext = 11097
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Name'#9'30'#9'Name'#9'F')
            DataField = 'Status'
            DataSource = DSMaster
            LookupTable = qryStatusType
            LookupField = 'Name'
            Style = csDropDownList
            ParentFont = False
            TabOrder = 14
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnNotInList = cboFollowUpResultNotInList
          end
          object DBEdit1: TwwDBEdit
            Left = 92
            Top = 153
            Width = 75
            Height = 23
            HelpContext = 11175
            DataField = 'Rate'
            DataSource = DSMaster
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 16
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object btnUpdateRepair: TDNMSpeedButton
            Left = 324
            Top = 151
            Width = 75
            Height = 27
            HelpContext = 11120
            Action = ActUpdateRepairs
            Caption = 'Repair'
            DisableTransparent = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 18
            AutoDisableParentOnclick = True
          end
          object pnlReminderhint: TPanel
            Left = 79
            Top = 85
            Width = 221
            Height = 47
            HelpContext = 11184
            Color = clMaroon
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 20
            object Label16: TLabel
              AlignWithMargins = True
              Left = 2
              Top = 2
              Width = 217
              Height = 43
              HelpContext = 11185
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 
                'Will not Show in Reminders as The Actual Date and Time is Entere' +
                'd'
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              WordWrap = True
              OnDblClick = Label16DblClick
              ExplicitTop = 1
            end
          end
        end
      end
      object TabTimeLog: TTabSheet
        Caption = 'Time Log'
        ImageIndex = 6
        object DNMPanel9: TDNMPanel
          Left = 0
          Top = 0
          Width = 713
          Height = 184
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object grdMain: TwwDBGrid
            Left = 1
            Top = 1
            Width = 625
            Height = 182
            ControlType.Strings = (
              'EmployeeName;CustomEdit;cboTimesLogEmployee;F'
              'IncludeForInvoice;CheckBox;T;F')
            Selected.Strings = (
              'StartDatetime'#9'18'#9'From'
              'EmployeeName'#9'10'#9'Employee'
              'Description'#9'20'#9'Description'
              'IncludeForInvoice'#9'1'#9'Invoice ?'
              'EndDatetime'#9'18'#9'To'
              'Duration'#9'1'#9'Duration')
            MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
            IniAttributes.SaveToRegistry = True
            IniAttributes.Delimiter = ';;'
            IniAttributes.CheckNewFields = True
            TitleColor = clBtnFace
            FixedCols = 0
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
            Align = alClient
            BorderStyle = bsNone
            Color = clWhite
            DataSource = dsAppointmentsTimeLog
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = True
            LineColors.GroupingColor = clSilver
            OnCalcCellColors = grdMainCalcCellColors
            FooterCellColor = clWhite
            ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
            PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
            object btnGrid: TwwIButton
              Left = 0
              Top = 0
              Width = 13
              Height = 22
              AllowAllUp = True
            end
          end
          object DNMPanel10: TDNMPanel
            Left = 626
            Top = 1
            Width = 86
            Height = 182
            Align = alRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object btnStart: TDNMSpeedButton
              AlignWithMargins = True
              Left = 2
              Top = 12
              Width = 82
              Height = 69
              HelpContext = 11032
              Margins.Left = 1
              Margins.Top = 11
              Margins.Right = 1
              Margins.Bottom = 11
              Align = alTop
              Caption = 'Start   Appointment'
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
              Layout = blGlyphTop
              NumGlyphs = 2
              ParentFont = False
              TabOrder = 0
              WordWrap = True
              AutoDisableParentOnclick = True
              OnClick = btnStartClick
            end
            object btnStop: TDNMSpeedButton
              AlignWithMargins = True
              Left = 2
              Top = 94
              Width = 82
              Height = 69
              HelpContext = 11043
              Margins.Left = 1
              Margins.Top = 2
              Margins.Right = 1
              Margins.Bottom = 2
              Align = alTop
              Caption = 'Stop    Appointment'
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
                333333333333333333333333000033338833333333333333333F333333333333
                0000333911833333983333333388F333333F3333000033391118333911833333
                38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
                911118111118333338F3338F833338F3000033333911111111833333338F3338
                3333F8330000333333911111183333333338F333333F83330000333333311111
                8333333333338F3333383333000033333339111183333333333338F333833333
                00003333339111118333333333333833338F3333000033333911181118333333
                33338333338F333300003333911183911183333333383338F338F33300003333
                9118333911183333338F33838F338F33000033333913333391113333338FF833
                38F338F300003333333333333919333333388333338FFF830000333333333333
                3333333333333333333888330000333333333333333333333333333333333333
                0000}
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -11
              HotTrackFont.Name = 'MS Sans Serif'
              HotTrackFont.Style = []
              Layout = blGlyphTop
              NumGlyphs = 2
              ParentFont = False
              TabOrder = 1
              WordWrap = True
              AutoDisableParentOnclick = True
              OnClick = btnStopClick
            end
          end
          object cboTimesLogEmployee: TwwDBLookupCombo
            Left = 183
            Top = 63
            Width = 123
            Height = 23
            HelpContext = 11036
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'EmployeeName'#9'30'#9'EmployeeName'#9'T')
            DataField = 'EmployeeName'
            DataSource = dsAppointmentsTimeLog
            LookupTable = QryEmployee
            LookupField = 'EmployeeName'
            Style = csDropDownList
            ParentFont = False
            TabOrder = 2
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
        end
      end
      object TabSheet2: TTabSheet
        HelpContext = 11098
        Caption = 'Service'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DNMPanel4: TDNMPanel
          Left = 0
          Top = 0
          Width = 713
          Height = 184
          HelpContext = 11099
          Align = alClient
          BevelOuter = bvNone
          Caption = 'DNMPanel4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          Transparent = False
          object Label24: TLabel
            Left = 387
            Top = 148
            Width = 44
            Height = 18
            HelpContext = 11100
            AutoSize = False
            Caption = 'Other :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label17: TLabel
            Left = 7
            Top = 148
            Width = 53
            Height = 18
            HelpContext = 11101
            AutoSize = False
            Caption = 'Search :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label18: TLabel
            Left = 219
            Top = 148
            Width = 113
            Height = 19
            HelpContext = 11102
            AutoSize = False
            Caption = 'Number of Columns :'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object ServiceList: TCheckListBox
            Left = 7
            Top = 5
            Width = 698
            Height = 124
            HelpContext = 11103
            OnClickCheck = ServiceListClickCheck
            Columns = 3
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            IntegralHeight = True
            ItemHeight = 15
            ParentFont = False
            Sorted = True
            TabOrder = 0
          end
          object txtOther: TwwDBEdit
            Left = 443
            Top = 146
            Width = 150
            Height = 23
            HelpContext = 11104
            DataField = 'Othertxt'
            DataSource = DSMaster
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object ServiceSearch: TEdit
            Left = 62
            Top = 146
            Width = 150
            Height = 23
            HelpContext = 11105
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = ServiceSearchChange
          end
          object speColumns: TSpinEdit
            Left = 336
            Top = 145
            Width = 41
            Height = 24
            HelpContext = 11106
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            MaxValue = 4
            MinValue = 1
            ParentFont = False
            TabOrder = 2
            Value = 3
            OnChange = speColumnsChange
          end
          object btnChooseProduct: TDNMSpeedButton
            Left = 605
            Top = 134
            Width = 100
            Height = 46
            HelpContext = 11042
            Caption = 'Choose Service Product'
            DisableTransparent = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            WordWrap = True
            AutoDisableParentOnclick = True
            OnClick = btnChooseProductClick
          end
        end
      end
      object tabEquipment: TTabSheet
        HelpContext = 11121
        Caption = 'Equipment'
        ImageIndex = 3
        object pnlEquipments: TDNMPanel
          Left = 0
          Top = 0
          Width = 713
          Height = 184
          HelpContext = 11176
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label28: TLabel
            Left = 769
            Top = 94
            Width = 47
            Height = 15
            HelpContext = 11177
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Deleted'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object wwCheckBox1: TwwCheckBox
            Left = 788
            Top = 109
            Width = 13
            Height = 13
            HelpContext = 11015
            DisableThemes = False
            AlwaysTransparent = True
            Frame.Enabled = True
            Frame.Transparent = True
            Frame.FocusBorders = []
            Frame.NonFocusBorders = []
            ValueChecked = 'F'
            ValueUnchecked = 'T'
            DisplayValueChecked = 'F'
            DisplayValueUnchecked = 'T'
            NullAndBlankState = cbUnchecked
            DataField = 'Active'
            DataSource = DSMaster
            ShowText = False
            TabOrder = 0
          end
        end
      end
      object Custom_Fields: TTabSheet
        HelpContext = 11122
        Caption = 'Custom Fields'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlCustFields: TDNMPanel
          Left = 0
          Top = 0
          Width = 713
          Height = 184
          HelpContext = 11123
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Transparent = False
          object CUSTLBL1: TLabel
            Left = 59
            Top = 13
            Width = 17
            Height = 15
            HelpContext = 11124
            Alignment = taRightJustify
            Caption = 'cl1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL2: TLabel
            Left = 59
            Top = 35
            Width = 17
            Height = 15
            HelpContext = 11125
            Alignment = taRightJustify
            Caption = 'cl2'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL3: TLabel
            Left = 59
            Top = 58
            Width = 17
            Height = 15
            HelpContext = 11126
            Alignment = taRightJustify
            Caption = 'cl3'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL4: TLabel
            Left = 59
            Top = 80
            Width = 17
            Height = 15
            HelpContext = 11127
            Alignment = taRightJustify
            Caption = 'cl4'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL5: TLabel
            Left = 59
            Top = 103
            Width = 17
            Height = 15
            HelpContext = 11128
            Alignment = taRightJustify
            Caption = 'cl5'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL6: TLabel
            Left = 59
            Top = 126
            Width = 17
            Height = 15
            HelpContext = 11129
            Alignment = taRightJustify
            Caption = 'cl6'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL7: TLabel
            Left = 310
            Top = 13
            Width = 17
            Height = 15
            HelpContext = 11130
            Alignment = taRightJustify
            Caption = 'cl7'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL8: TLabel
            Left = 310
            Top = 35
            Width = 17
            Height = 15
            HelpContext = 11131
            Alignment = taRightJustify
            Caption = 'cl8'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL9: TLabel
            Left = 310
            Top = 58
            Width = 17
            Height = 15
            HelpContext = 11132
            Alignment = taRightJustify
            Caption = 'cl9'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL10: TLabel
            Left = 303
            Top = 80
            Width = 24
            Height = 15
            HelpContext = 11133
            Alignment = taRightJustify
            Caption = 'cl10'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL11: TLabel
            Left = 303
            Top = 103
            Width = 23
            Height = 15
            HelpContext = 11134
            Alignment = taRightJustify
            Caption = 'cl11'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL12: TLabel
            Left = 302
            Top = 126
            Width = 24
            Height = 15
            HelpContext = 11135
            Alignment = taRightJustify
            Caption = 'cl12'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL13: TLabel
            Left = 546
            Top = 13
            Width = 24
            Height = 15
            HelpContext = 11136
            Alignment = taRightJustify
            Caption = 'cl13'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL14: TLabel
            Left = 546
            Top = 35
            Width = 24
            Height = 15
            HelpContext = 11137
            Alignment = taRightJustify
            Caption = 'cl14'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL15: TLabel
            Left = 546
            Top = 58
            Width = 24
            Height = 15
            HelpContext = 11138
            Alignment = taRightJustify
            Caption = 'cl15'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL16: TLabel
            Left = 546
            Top = 80
            Width = 24
            Height = 15
            HelpContext = 11139
            Alignment = taRightJustify
            Caption = 'cl16'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label54: TLabel
            Left = 631
            Top = 215
            Width = 3
            Height = 15
            HelpContext = 11140
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label55: TLabel
            Left = 631
            Top = 247
            Width = 3
            Height = 15
            HelpContext = 11141
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL17: TLabel
            Left = 546
            Top = 103
            Width = 24
            Height = 15
            HelpContext = 11142
            Alignment = taRightJustify
            Caption = 'cl17'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL18: TLabel
            Left = 546
            Top = 126
            Width = 24
            Height = 15
            HelpContext = 11143
            Alignment = taRightJustify
            Caption = 'cl18'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object cmdCustomLabelsOld: TDNMSpeedButton
            Left = 313
            Top = 152
            Width = 87
            Height = 27
            Hint = '"Add A New Customised Field For All Employee'#39's"'
            HelpContext = 11144
            Caption = '&Add Labels'
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 18
            AutoDisableParentOnclick = True
            OnClick = cmdCustomLabelsOldClick
          end
          object CUSTFLD1: TwwDBComboBox
            Left = 79
            Top = 9
            Width = 130
            Height = 23
            HelpContext = 11145
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD1'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 0
            UnboundDataType = wwDefault
          end
          object CUSTFLD2: TwwDBComboBox
            Left = 79
            Top = 31
            Width = 130
            Height = 23
            HelpContext = 11146
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD2'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 1
            UnboundDataType = wwDefault
          end
          object CUSTFLD3: TwwDBComboBox
            Left = 79
            Top = 54
            Width = 130
            Height = 23
            HelpContext = 11147
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD3'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 2
            UnboundDataType = wwDefault
          end
          object CUSTFLD4: TwwDBComboBox
            Left = 79
            Top = 76
            Width = 130
            Height = 23
            HelpContext = 11148
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD4'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 3
            UnboundDataType = wwDefault
          end
          object CUSTFLD5: TwwDBComboBox
            Left = 79
            Top = 99
            Width = 130
            Height = 23
            HelpContext = 11149
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD5'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 4
            UnboundDataType = wwDefault
          end
          object CUSTFLD10: TwwDBComboBox
            Left = 330
            Top = 76
            Width = 130
            Height = 23
            HelpContext = 11150
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD10'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 9
            UnboundDataType = wwDefault
          end
          object CUSTFLD9: TwwDBComboBox
            Left = 330
            Top = 54
            Width = 130
            Height = 23
            HelpContext = 11151
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD9'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 8
            UnboundDataType = wwDefault
          end
          object CUSTFLD8: TwwDBComboBox
            Left = 330
            Top = 31
            Width = 130
            Height = 23
            HelpContext = 11152
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD8'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 7
            UnboundDataType = wwDefault
          end
          object CUSTFLD7: TwwDBComboBox
            Left = 330
            Top = 9
            Width = 130
            Height = 23
            HelpContext = 11153
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD7'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 6
            UnboundDataType = wwDefault
          end
          object CUSTFLD6: TwwDBComboBox
            Left = 79
            Top = 122
            Width = 130
            Height = 23
            HelpContext = 11154
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD6'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 5
            UnboundDataType = wwDefault
          end
          object CUSTFLD11: TwwDBComboBox
            Left = 330
            Top = 99
            Width = 130
            Height = 23
            HelpContext = 11155
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD11'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 10
            UnboundDataType = wwDefault
          end
          object CUSTFLD12: TwwDBComboBox
            Left = 330
            Top = 122
            Width = 130
            Height = 23
            HelpContext = 11156
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD12'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 11
            UnboundDataType = wwDefault
          end
          object CUSTFLD13: TwwDBComboBox
            Left = 573
            Top = 9
            Width = 130
            Height = 23
            HelpContext = 11157
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD13'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 12
            UnboundDataType = wwDefault
          end
          object CUSTFLD14: TwwDBComboBox
            Left = 573
            Top = 31
            Width = 130
            Height = 23
            HelpContext = 11158
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD14'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 13
            UnboundDataType = wwDefault
          end
          object CUSTFLD15: TwwDBComboBox
            Left = 573
            Top = 54
            Width = 130
            Height = 23
            HelpContext = 11159
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD15'
            DataSource = DSMaster
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ButtonWidth = -1
            ItemHeight = 0
            ParentFont = False
            Sorted = False
            TabOrder = 14
            UnboundDataType = wwDefault
          end
          object CUSTFLD16: TwwDBDateTimePicker
            Left = 573
            Top = 76
            Width = 130
            Height = 23
            HelpContext = 11160
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'CUSTDATE1'
            DataSource = DSMaster
            Epoch = 1950
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 15
          end
          object CUSTFLD17: TwwDBDateTimePicker
            Left = 573
            Top = 99
            Width = 130
            Height = 23
            HelpContext = 11161
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'CUSTDATE2'
            DataSource = DSMaster
            Epoch = 1950
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 16
          end
          object CUSTFLD18: TwwDBDateTimePicker
            Left = 573
            Top = 122
            Width = 130
            Height = 23
            HelpContext = 11162
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'CUSTDATE3'
            DataSource = DSMaster
            Epoch = 1950
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 17
          end
        end
      end
      object tabAttachments: TTabSheet
        HelpContext = 11186
        Caption = 'Attachments'
        ImageIndex = 4
      end
      object TabSheet3: TTabSheet
        Caption = 'Address'
        ImageIndex = 5
        object DNMPanel7: TDNMPanel
          Left = 0
          Top = 0
          Width = 713
          Height = 184
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label8: TLabel
            Left = 3
            Top = 7
            Width = 66
            Height = 18
            HelpContext = 254062
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Address'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label14: TLabel
            Left = 3
            Top = 32
            Width = 66
            Height = 17
            HelpContext = 254058
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Address 2'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label20: TLabel
            Left = 3
            Top = 57
            Width = 66
            Height = 17
            HelpContext = 254077
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Address 3'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblSuburb: TLabel
            Left = 3
            Top = 82
            Width = 66
            Height = 17
            HelpContext = 254063
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'City'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblState: TLabel
            Left = 3
            Top = 107
            Width = 66
            Height = 17
            HelpContext = 254065
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'State'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblPostCode: TLabel
            Left = 3
            Top = 132
            Width = 66
            Height = 17
            HelpContext = 254064
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Postcode'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label2: TLabel
            Left = 3
            Top = 158
            Width = 66
            Height = 17
            HelpContext = 254070
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Country'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Street2: TDBEdit
            Left = 75
            Top = 30
            Width = 250
            Height = 23
            HelpContext = 254080
            DataField = 'Street2'
            DataSource = DSMaster
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object Street: TDBEdit
            Left = 75
            Top = 5
            Width = 250
            Height = 23
            HelpContext = 254079
            DataField = 'Street'
            DataSource = DSMaster
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object Street3: TDBEdit
            Left = 75
            Top = 55
            Width = 250
            Height = 23
            HelpContext = 254097
            DataField = 'Street3'
            DataSource = DSMaster
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object Suburb: TwwDBLookupCombo
            Left = 75
            Top = 80
            Width = 250
            Height = 22
            HelpContext = 254088
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'City_sub'#9'20'#9'Suburb'#9'T'
              'State'#9'20'#9'State'#9'T'
              'Postcode'#9'10'#9'Postcode'#9'T'
              'Code'#9'10'#9'Code'#9'T')
            DataField = 'Suburb'
            DataSource = DSMaster
            LookupTable = qrySuburb
            LookupField = 'City_sub'
            ParentFont = False
            TabOrder = 3
            AutoDropDown = True
            ShowButton = True
            UseTFields = False
            PreciseEditRegion = False
            AllowClearKey = False
          end
          object State: TDBEdit
            Left = 75
            Top = 105
            Width = 89
            Height = 23
            HelpContext = 254081
            DataField = 'State'
            DataSource = DSMaster
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object Postcode: TDBEdit
            Left = 75
            Top = 130
            Width = 89
            Height = 23
            HelpContext = 254082
            DataField = 'Postcode'
            DataSource = DSMaster
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object Country: TDBEdit
            Left = 75
            Top = 155
            Width = 250
            Height = 23
            HelpContext = 254090
            DataField = 'Country'
            DataSource = DSMaster
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
        end
      end
    end
    object txtMoblie: TwwDBEdit
      Left = 552
      Top = 134
      Width = 150
      Height = 23
      HelpContext = 11108
      DataField = 'Mobile'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object AppCount: TwwDBEdit
      Left = 730
      Top = 115
      Width = 62
      Height = 24
      HelpContext = 11109
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 14
      UnboundDataType = wwDefault
      UnboundAlignment = taCenter
      WantReturns = False
      WordWrap = False
    end
    object btnFax: TDNMSpeedButton
      Left = 536
      Top = 381
      Width = 87
      Height = 27
      Hint = '"Send This Appointment Via Email To The Rep"'
      HelpContext = 11110
      Caption = 'Fax'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnFaxClick
    end
    object pnlTitle: TDNMPanel
      Left = 301
      Top = 3
      Width = 238
      Height = 45
      HelpContext = 11111
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 19
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 236
        Height = 43
        HelpContext = 11112
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.4.0.0'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 236
          Height = 43
          HelpContext = 11113
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Appointment'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
    end
    object cboMediaType: TwwDBLookupCombo
      Left = 710
      Top = 185
      Width = 104
      Height = 23
      Hint = '"Enter Where This Customer Came From"'
      HelpContext = 11163
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'MediaType'#9'40'#9'MediaType'#9'F')
      DataField = 'MedTypeID'
      DataSource = DSMaster
      LookupTable = qryMediaType
      LookupField = 'MedTypeID'
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object btnPOS: TDNMSpeedButton
      Left = 351
      Top = 59
      Width = 87
      Height = 27
      HelpContext = 11164
      Action = actPOS
      Caption = 'POS'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 3
      AutoDisableParentOnclick = True
    end
    object btnInvoice: TDNMSpeedButton
      Left = 351
      Top = 92
      Width = 87
      Height = 27
      HelpContext = 11165
      Action = actInvoice
      Caption = '&Invoice'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 4
      AutoDisableParentOnclick = True
    end
    object btnRepeat: TDNMSpeedButton
      Left = 351
      Top = 125
      Width = 87
      Height = 27
      Hint = '"Repeat This Appointment"'
      HelpContext = 11107
      Caption = 'Repeat'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btnRepeatClick
    end
    object cboClass: TwwDBLookupCombo
      Left = 328
      Top = 182
      Width = 131
      Height = 23
      HelpContext = 11012
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'30'#9'ClassName'#9'T')
      DataField = 'ClassID'
      DataSource = DSMaster
      LookupTable = cboClassQry
      LookupField = 'ClassID'
      ParentFont = False
      TabOrder = 6
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object MultipleReps: TDNMSpeedButton
      Left = 679
      Top = 160
      Width = 23
      Height = 21
      Hint = '"Repeat This Appointment"'
      HelpContext = 11179
      Caption = '...'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      AutoDisableParentOnclick = True
      OnClick = MultipleRepsClick
    end
    object cboClient: TERPDbLookupCombo
      Left = 80
      Top = 58
      Width = 212
      Height = 23
      HelpContext = 11166
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'StopCreditImage;ImageIndex;Shrink To Fit')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'20'#9'Company'#9'F'
        'PrintName'#9'20'#9'PrintName'#9'F'
        'StopCreditImage'#9'3'#9'StopCreditImage'#9'F')
      DataField = 'ClientName'
      DataSource = DSMaster
      LookupTable = cboClientLookup
      LookupField = 'Company'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboClientChange
      OnDblClick = cboClientDblClick
      OnCloseUp = cboClientCloseUp
      OnEnter = cboClientEnter
      OnNotInList = cboClientNotInList
      LookupFormClassName = 'TClientListGUI'
      LookupFormKeyStringFieldName = 'Company'
      LookupComboType = ctClient
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'CusID'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
    object btnContacts: TDNMSpeedButton
      Left = 293
      Top = 58
      Width = 25
      Height = 23
      HelpContext = 11187
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000000
        055557777777777775F508888888888880557F5FFFFFFFFFF75F080000000000
        88057577777777775F755080FFFFFF05088057F7FFFFFF7575F70000000000F0
        F08077777777775757F70FFFFFFFFF0F008075F5FF5FF57577F750F00F00FFF0
        F08057F775775557F7F750FFFFFFFFF0F08057FF5555555757F7000FFFFFFFFF
        0000777FF5FFFFF577770900F00000F000907F775777775777F7090FFFFFFFFF
        00907F7F555555557757000FFFFFFFFF0F00777F5FFF5FF57F77550F000F00FF
        0F05557F777577557F7F550FFFFFFFFF0005557F555FFFFF7775550FFF000000
        05555575FF777777755555500055555555555557775555555555}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 20
      AutoDisableParentOnclick = True
      OnClick = btnContactsClick
    end
    object DNMPanel5: TDNMPanel
      AlignWithMargins = True
      Left = 716
      Top = 218
      Width = 90
      Height = 220
      HelpContext = 11190
      Margins.Left = 1
      Margins.Top = 218
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 21
      object cmdNew: TDNMSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 4
        Width = 88
        Height = 27
        Hint = '"Save This Appointment And Open A New Appointment"'
        HelpContext = 11040
        Margins.Left = 1
        Margins.Top = 4
        Margins.Right = 1
        Margins.Bottom = 2
        Align = alTop
        Caption = '&New'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = cmdNewClick
      end
      object btnSave: TDNMSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 35
        Width = 88
        Height = 27
        HelpContext = 11032
        Margins.Left = 1
        Margins.Top = 2
        Margins.Right = 1
        Margins.Bottom = 2
        Align = alTop
        Caption = '&Save'
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
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnSaveClick
      end
      object btnCancel: TDNMSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 66
        Width = 88
        Height = 27
        HelpContext = 11043
        Margins.Left = 1
        Margins.Top = 2
        Margins.Right = 1
        Margins.Bottom = 2
        Align = alTop
        Caption = '&Cancel'
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
          333333333333333333333333000033338833333333333333333F333333333333
          0000333911833333983333333388F333333F3333000033391118333911833333
          38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
          911118111118333338F3338F833338F3000033333911111111833333338F3338
          3333F8330000333333911111183333333338F333333F83330000333333311111
          8333333333338F3333383333000033333339111183333333333338F333833333
          00003333339111118333333333333833338F3333000033333911181118333333
          33338333338F333300003333911183911183333333383338F338F33300003333
          9118333911183333338F33838F338F33000033333913333391113333338FF833
          38F338F300003333333333333919333333388333338FFF830000333333333333
          3333333333333333333888330000333333333333333333333333333333333333
          0000}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = btnCancelClick
      end
      object cmdPrint: TDNMSpeedButton
        AlignWithMargins = True
        Left = 1
        Top = 97
        Width = 88
        Height = 27
        Hint = '"Print This Appointment"'
        HelpContext = 11041
        Margins.Left = 1
        Margins.Top = 2
        Margins.Right = 1
        Margins.Bottom = 16
        Align = alTop
        Caption = 'Prin&t'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = cmdPrintClick
      end
      object DNMPanel6: TDNMPanel
        AlignWithMargins = True
        Left = 1
        Top = 142
        Width = 88
        Height = 35
        HelpContext = 11191
        Margins.Left = 1
        Margins.Top = 2
        Margins.Right = 1
        Margins.Bottom = 2
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object chkSyncWithGoogle: TDBCheckBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 82
          Height = 27
          HelpContext = 11167
          Margins.Right = 1
          Align = alClient
          Alignment = taLeftJustify
          Caption = 'Synch with Google'
          DataField = 'SynchWithGoogle'
          DataSource = DSMaster
          TabOrder = 0
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          WordWrap = True
        end
      end
      object DNMPanel8: TDNMPanel
        AlignWithMargins = True
        Left = 1
        Top = 181
        Width = 88
        Height = 35
        HelpContext = 11192
        Margins.Left = 1
        Margins.Top = 2
        Margins.Right = 1
        Margins.Bottom = 2
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        object chkDeleted: TDBCheckBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 82
          Height = 27
          HelpContext = 11178
          Margins.Right = 1
          Align = alClient
          Alignment = taLeftJustify
          Caption = 'Deleted? '
          DataField = 'Active'
          DataSource = DSMaster
          TabOrder = 0
          ValueChecked = 'F'
          ValueUnchecked = 'T'
        end
      end
    end
    object cmdEmail: TDNMSpeedButton
      Left = 524
      Top = 341
      Width = 87
      Height = 34
      Hint = '"Send This Appointment Via Email To The Rep"'
      HelpContext = 11042
      Caption = '&E-mail'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 22
      Visible = False
      AutoDisableParentOnclick = True
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 34
    Top = 63
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 98
    Top = 63
  end
  inherited MyConnection: TERPConnection
    Database = 'aus_sample_company'
    Server = 'Localhost'
    Connected = True
  end
  inherited DataState: TDataState
    Left = 34
    Top = 87
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 250
    Top = 4
  end
  inherited imgsort: TImageList
    Top = 80
    Bitmap = {
      494C01010200FC00340210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 48
    Top = 182
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 18
    Top = 181
  end
  object actlstAppointments: TActionList
    Left = 171
    Top = 64
    object actPOS: TAction
      Caption = 'POS'
      HelpContext = 11168
      OnExecute = actPOSExecute
      OnUpdate = actPOSUpdate
    end
    object actInvoice: TAction
      Caption = '&Invoice'
      HelpContext = 11169
      OnExecute = actInvoiceExecute
      OnUpdate = actInvoiceUpdate
    end
    object ActUpdateRepairs: TDNMAction
      Caption = 'Repair'
      HelpContext = 11170
      OnExecute = ActUpdateRepairsExecute
      OnUpdate = ActUpdateRepairsUpdate
      buttoncolor = clWhite
    end
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblappointments'
      'Where AppointID= :ID;')
    AfterOpen = tblMasterAfterOpen
    AfterInsert = tblMasterAfterInsert
    AfterPost = tblMasterAfterPost
    OnCalcFields = tblMasterCalcFields
    Left = 17
    Top = 152
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        Value = 1
      end>
    object tblMasterAppointID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'AppointID'
      Origin = 'tblappointments.AppointID'
      ReadOnly = True
    end
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblappointments.GlobalRef'
      Size = 255
    end
    object tblMasterCusID: TIntegerField
      FieldName = 'CusID'
      Origin = 'tblappointments.CusID'
    end
    object tblMasterAppDate: TDateField
      FieldName = 'AppDate'
      Origin = 'tblappointments.AppDate'
    end
    object tblMasterCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblappointments.CreationDate'
    end
    object tblMasterUpdateDate: TDateField
      FieldName = 'UpdateDate'
      Origin = 'tblappointments.UpdateDate'
    end
    object tblMasterCancellation: TWideStringField
      FieldName = 'Cancellation'
      Origin = 'tblappointments.Cancellation'
      FixedChar = True
      Size = 1
    end
    object tblMasterTrainRateID: TIntegerField
      FieldName = 'TrainRateID'
      Origin = 'tblappointments.TrainRateID'
    end
    object tblMasterTrainerID: TIntegerField
      FieldName = 'TrainerID'
      Origin = 'tblappointments.TrainerID'
    end
    object tblMasterLastTrainerID: TIntegerField
      FieldName = 'LastTrainerID'
      Origin = 'tblappointments.LastTrainerID'
    end
    object tblMasterMedTypeID: TIntegerField
      FieldName = 'MedTypeID'
      Origin = 'tblappointments.MedTypeID'
    end
    object tblMasterContact: TWideStringField
      FieldName = 'Contact'
      Origin = 'tblappointments.Contact'
      Size = 50
    end
    object tblMasterReschedulled: TWideStringField
      FieldName = 'Reschedulled'
      Origin = 'tblappointments.Reschedulled'
      FixedChar = True
      Size = 1
    end
    object tblMasterCancellationDate: TDateField
      FieldName = 'CancellationDate'
      Origin = 'tblappointments.CancellationDate'
    end
    object tblMasterRescheduledDate: TDateField
      FieldName = 'RescheduledDate'
      Origin = 'tblappointments.RescheduledDate'
    end
    object tblMasterStart_Time: TWideStringField
      FieldName = 'Start_Time'
      Origin = 'tblappointments.Start_Time'
      Size = 50
    end
    object tblMasterEnd_Time: TWideStringField
      FieldName = 'End_Time'
      Origin = 'tblappointments.End_Time'
      Size = 50
    end
    object tblMasterStartVal: TFloatField
      FieldName = 'StartVal'
      Origin = 'tblappointments.StartVal'
    end
    object tblMasterEndVal: TFloatField
      FieldName = 'EndVal'
      Origin = 'tblappointments.EndVal'
    end
    object tblMasterPH_Support_Till: TDateField
      FieldName = 'PH_Support_Till'
      Origin = 'tblappointments.PH_Support_Till'
    end
    object tblMasterRate: TFloatField
      FieldName = 'Rate'
      Origin = 'tblappointments.Rate'
      currency = True
    end
    object tblMasterTrainerCode: TWideStringField
      FieldName = 'TrainerCode'
      Origin = 'tblappointments.TrainerCode'
      Size = 50
    end
    object tblMasterFeedbackNotes: TWideMemoField
      FieldName = 'FeedbackNotes'
      Origin = 'tblappointments.FeedbackNotes'
      BlobType = ftWideMemo
    end
    object tblMasterCalloutValue: TFloatField
      FieldName = 'CalloutValue'
      Origin = 'tblappointments.CalloutValue'
      currency = True
    end
    object tblMasterOther: TWideStringField
      FieldName = 'Other'
      Origin = 'tblappointments.Other'
      FixedChar = True
      Size = 1
    end
    object tblMasterOthertxt: TWideStringField
      FieldName = 'Othertxt'
      Origin = 'tblappointments.Othertxt'
      Size = 50
    end
    object tblMasterFeedback: TWideStringField
      FieldName = 'Feedback'
      Origin = 'tblappointments.Feedback'
      FixedChar = True
      Size = 1
    end
    object tblMasterTotalInc: TFloatField
      FieldName = 'TotalInc'
      Origin = 'tblappointments.TotalInc'
      currency = True
    end
    object tblMasterTotalCost: TFloatField
      FieldName = 'TotalCost'
      Origin = 'tblappointments.TotalCost'
      currency = True
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblappointments.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterMSRef: TWideStringField
      FieldName = 'MSRef'
      Origin = 'tblappointments.MSRef'
      Size = 255
    end
    object tblMasterAppearDays: TIntegerField
      FieldName = 'AppearDays'
      Origin = 'tblappointments.AppearDays'
    end
    object tblMasterClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblappointments.ClassID'
    end
    object tblMasterRescheduledFrom: TDateField
      FieldName = 'RescheduledFrom'
      Origin = 'tblappointments.RescheduledFrom'
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblappointments.EmployeeID'
    end
    object tblMasterCustomerDetails: TWideStringField
      FieldName = 'CustomerDetails'
      Origin = 'tblappointments.CustomerDetails'
      Size = 255
    end
    object tblMasterPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblappointments.Phone'
      EditMask = '## #### ####;0;_'
      Size = 30
    end
    object tblMasterAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblappointments.AltPhone'
      EditMask = '## #### ####;0;_'
      Size = 30
    end
    object tblMasterFax: TWideStringField
      FieldName = 'Fax'
      Origin = 'tblappointments.Fax'
      EditMask = '## #### ####;0;_'
      Size = 30
    end
    object tblMasterSTARTTIME: TDateTimeField
      FieldName = 'STARTTIME'
      Origin = 'tblappointments.STARTTIME'
    end
    object tblMasterENDTIME: TDateTimeField
      FieldName = 'ENDTIME'
      Origin = 'tblappointments.ENDTIME'
    end
    object tblMasterJobDueDate: TDateField
      FieldName = 'JobDueDate'
      Origin = 'tblappointments.JobDueDate'
    end
    object tblMasterServiceID: TWordField
      FieldName = 'ServiceID'
      Origin = 'tblappointments.ServiceID'
    end
    object tblMasterResourceID: TWordField
      FieldName = 'ResourceID'
      Origin = 'tblappointments.ResourceID'
    end
    object tblMasterPosID: TIntegerField
      FieldName = 'PosID'
      Origin = 'tblappointments.PosID'
    end
    object tblMasterConverted: TWideStringField
      FieldName = 'Converted'
      Origin = 'tblappointments.Converted'
      FixedChar = True
      Size = 1
    end
    object tblMasterUnavailable: TWideStringField
      FieldName = 'Unavailable'
      Origin = 'tblappointments.Unavailable'
      FixedChar = True
      Size = 1
    end
    object tblMasterEnteredByEmployeeID: TIntegerField
      FieldName = 'EnteredByEmployeeID'
      Origin = 'tblappointments.EnteredByEmployeeID'
    end
    object tblMasterEnteredByEmployeeName: TWideStringField
      DisplayWidth = 100
      FieldName = 'EnteredByEmployeeName'
      Origin = 'tblappointments.EnteredByEmployeeName'
      Size = 100
    end
    object tblMasterNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblappointments.Notes'
      BlobType = ftWideMemo
    end
    object tblMasterActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblappointments.Active'
      FixedChar = True
      Size = 1
    end
    object tblMasterLinkAppointID: TIntegerField
      FieldName = 'LinkAppointID'
      Origin = 'tblappointments.LinkAppointID'
    end
    object tblMasterIsGroupParent: TWideStringField
      FieldName = 'IsGroupParent'
      Origin = 'tblappointments.IsGroupParent'
      FixedChar = True
      Size = 1
    end
    object tblMasterServiceDesc: TWideStringField
      FieldName = 'ServiceDesc'
      Origin = 'tblappointments.ServiceDesc'
      Size = 50
    end
    object tblMasterActual_AppDate: TDateField
      FieldName = 'Actual_AppDate'
      Origin = 'tblappointments.Actual_AppDate'
    end
    object tblMasterActual_Start_time: TWideStringField
      FieldName = 'Actual_Start_time'
      Origin = 'tblappointments.Actual_Start_time'
      Size = 50
    end
    object tblMasterActual_End_time: TWideStringField
      FieldName = 'Actual_End_time'
      Origin = 'tblappointments.Actual_End_time'
      Size = 50
    end
    object tblMasterActual_Starttime: TDateTimeField
      FieldName = 'Actual_Starttime'
      Origin = 'tblappointments.Actual_Starttime'
    end
    object tblMasterActual_Endtime: TDateTimeField
      FieldName = 'Actual_Endtime'
      Origin = 'tblappointments.Actual_Endtime'
    end
    object tblMasterTimesheetID: TIntegerField
      FieldName = 'TimesheetID'
      Origin = 'tblappointments.TimesheetID'
    end
    object tblMasterHrstoInvoice: TFloatField
      FieldName = 'HrstoInvoice'
      Origin = 'tblappointments.HrstoInvoice'
    end
    object tblMasterCancellationReason: TWideStringField
      FieldName = 'CancellationReason'
      Origin = 'tblappointments.CancellationReason'
      Size = 255
    end
    object tblMasterMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblappointments.Mobile'
      Size = 30
    end
    object tblMasterStatus: TWideStringField
      FieldName = 'Status'
      Origin = 'tblappointments.Status'
      Size = 255
    end
    object tblMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblappointments.msTimeStamp'
      Visible = False
    end
    object tblMasterCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Origin = 'tblappointments.CUSTFLD1'
      Size = 255
    end
    object tblMasterCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Origin = 'tblappointments.CUSTFLD2'
      Size = 255
    end
    object tblMasterCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Origin = 'tblappointments.CUSTFLD3'
      Size = 255
    end
    object tblMasterCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Origin = 'tblappointments.CUSTFLD4'
      Size = 255
    end
    object tblMasterCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Origin = 'tblappointments.CUSTFLD5'
      Size = 255
    end
    object tblMasterCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Origin = 'tblappointments.CUSTFLD6'
      Size = 255
    end
    object tblMasterCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Origin = 'tblappointments.CUSTFLD7'
      Size = 255
    end
    object tblMasterCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Origin = 'tblappointments.CUSTFLD8'
      Size = 255
    end
    object tblMasterCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Origin = 'tblappointments.CUSTFLD9'
      Size = 255
    end
    object tblMasterCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Origin = 'tblappointments.CUSTFLD10'
      Size = 255
    end
    object tblMasterCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Origin = 'tblappointments.CUSTFLD11'
      Size = 255
    end
    object tblMasterCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Origin = 'tblappointments.CUSTFLD12'
      Size = 255
    end
    object tblMasterCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Origin = 'tblappointments.CUSTFLD13'
      Size = 255
    end
    object tblMasterCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Origin = 'tblappointments.CUSTFLD14'
      Size = 255
    end
    object tblMasterCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Origin = 'tblappointments.CUSTFLD15'
      Size = 255
    end
    object tblMasterCUSTDATE1: TDateField
      FieldName = 'CUSTDATE1'
      Origin = 'tblappointments.CUSTDATE1'
    end
    object tblMasterCUSTDATE2: TDateField
      FieldName = 'CUSTDATE2'
      Origin = 'tblappointments.CUSTDATE2'
    end
    object tblMasterCUSTDATE3: TDateField
      FieldName = 'CUSTDATE3'
      Origin = 'tblappointments.CUSTDATE3'
    end
    object tblMasterRateDesc: TWideStringField
      FieldKind = fkLookup
      FieldName = 'RateDesc'
      LookupDataSet = qryServices
      LookupKeyFields = 'ServiceID'
      LookupResultField = 'ServiceDesc'
      KeyFields = 'ServiceID'
      Size = 100
      Lookup = True
    end
    object tblMasterRepairID: TIntegerField
      FieldName = 'RepairID'
      Origin = 'tblappointments.RepairID'
    end
    object tblMasterClientName: TWideStringField
      FieldName = 'ClientName'
      Size = 100
    end
    object tblMastermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object tblMasterGoogleId: TWideStringField
      FieldName = 'GoogleId'
      Size = 255
    end
    object tblMasterSynchWithGoogle: TWideStringField
      FieldName = 'SynchWithGoogle'
      FixedChar = True
      Size = 1
    end
    object tblMasterDisplayStatus: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'DisplayStatus'
      Size = 100
      Calculated = True
    end
    object tblMasterLocalApp: TWideStringField
      FieldName = 'LocalApp'
      FixedChar = True
      Size = 1
    end
    object tblMasterClientPrintName: TWideStringField
      DisplayWidth = 255
      FieldName = 'ClientPrintName'
      Size = 255
    end
    object tblMasterStreet: TWideStringField
      FieldName = 'Street'
      Size = 255
    end
    object tblMasterStreet2: TWideStringField
      FieldName = 'Street2'
      Size = 255
    end
    object tblMasterStreet3: TWideStringField
      FieldName = 'Street3'
      Size = 255
    end
    object tblMasterSuburb: TWideStringField
      FieldName = 'Suburb'
      Size = 255
    end
    object tblMasterState: TWideStringField
      FieldName = 'State'
      Size = 255
    end
    object tblMasterCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object tblMasterPostcode: TWideStringField
      FieldName = 'Postcode'
      Size = 255
    end
    object tblMasterProductDesc: TWideStringField
      FieldName = 'ProductDesc'
      Size = 255
    end
    object tblMasterProductID: TIntegerField
      FieldName = 'ProductID'
    end
  end
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblequipmentxref'
      'Where AppointmentID= :ID;')
    Left = 48
    Top = 153
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblDetailsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblequipmentxref.GlobalRef'
      Size = 255
    end
    object tblDetailsid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'tblequipmentxref.id'
    end
    object tblDetailsCustomerEquipmentID: TIntegerField
      FieldName = 'CustomerEquipmentID'
      Origin = 'tblequipmentxref.CustomerEquipmentID'
    end
    object tblDetailsRepairID: TIntegerField
      FieldName = 'RepairID'
      Origin = 'tblequipmentxref.RepairID'
    end
    object tblDetailsAppointmentID: TLargeintField
      FieldName = 'AppointmentID'
      Origin = 'tblequipmentxref.AppointmentID'
    end
    object tblDetailsSaleId: TLargeintField
      FieldName = 'SaleId'
      Origin = 'tblequipmentxref.SaleId'
    end
    object tblDetailsInvoiceID: TLargeintField
      FieldName = 'InvoiceID'
      Origin = 'tblequipmentxref.InvoiceID'
    end
    object tblDetailsNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'tblequipmentxref.Notes'
      Size = 100
    end
    object tblDetailsOnSite: TWideStringField
      FieldName = 'OnSite'
      Origin = 'tblequipmentxref.OnSite'
      FixedChar = True
      Size = 1
    end
    object tblDetailsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblequipmentxref.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblDetailsDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tblequipmentxref.Description'
      Size = 255
    end
    object tblDetailsCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblequipmentxref.CreationDate'
    end
    object tblDetailsUpdateDate: TDateField
      FieldName = 'UpdateDate'
      Origin = 'tblequipmentxref.UpdateDate'
    end
    object tblDetailsCode: TWideStringField
      FieldName = 'Code'
      Origin = 'tblequipmentxref.Code'
      Size = 255
    end
    object tblDetailsCustomField1: TWideStringField
      FieldName = 'CustomField1'
      Origin = 'tblequipmentxref.CustomField1'
      Size = 255
    end
    object tblDetailsCustomField2: TWideStringField
      FieldName = 'CustomField2'
      Origin = 'tblequipmentxref.CustomField2'
      Size = 255
    end
    object tblDetailsCustomField3: TWideStringField
      FieldName = 'CustomField3'
      Origin = 'tblequipmentxref.CustomField3'
      Size = 255
    end
    object tblDetailsCustomField4: TWideStringField
      FieldName = 'CustomField4'
      Origin = 'tblequipmentxref.CustomField4'
      Size = 255
    end
    object tblDetailsCustomField5: TWideStringField
      FieldName = 'CustomField5'
      Origin = 'tblequipmentxref.CustomField5'
      Size = 255
    end
    object tblDetailsCustomField6: TWideStringField
      FieldName = 'CustomField6'
      Origin = 'tblequipmentxref.CustomField6'
      Size = 255
    end
    object tblDetailsCustomField7: TWideStringField
      FieldName = 'CustomField7'
      Origin = 'tblequipmentxref.CustomField7'
      Size = 255
    end
    object tblDetailsCustomField8: TWideStringField
      FieldName = 'CustomField8'
      Origin = 'tblequipmentxref.CustomField8'
      Size = 255
    end
    object tblDetailsCustomField9: TWideStringField
      FieldName = 'CustomField9'
      Origin = 'tblequipmentxref.CustomField9'
      Size = 255
    end
    object tblDetailsCustomField10: TWideStringField
      FieldName = 'CustomField10'
      Origin = 'tblequipmentxref.CustomField10'
      Size = 255
    end
    object tblDetailsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblequipmentxref.msTimeStamp'
    end
    object tblDetailsWarantyPeriodTaken: TLargeintField
      FieldName = 'WarantyPeriodTaken'
      Origin = 'tblequipmentxref.WarantyPeriodTaken'
      OnChange = tblDetailsWarantyPeriodTakenChange
    end
    object tblDetailsWarantyPeriodLeft: TLargeintField
      FieldName = 'WarantyPeriodLeft'
      Origin = 'tblequipmentxref.WarantyPeriodLeft'
      OnChange = tblDetailsWarantyPeriodLeftChange
    end
    object tblDetailsQuantity: TFloatField
      FieldName = 'Quantity'
      Origin = 'tblequipmentxref.Quantity'
    end
    object tblDetailsUOM: TWideStringField
      FieldName = 'UOM'
      Origin = 'tblequipmentxref.UOM'
      Size = 50
    end
    object tblDetailsUOMID: TLargeintField
      FieldName = 'UOMID'
      Origin = 'tblequipmentxref.UOMID'
    end
    object tblDetailsUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tblequipmentxref.UOMMultiplier'
    end
    object tblDetailsUOMQty: TFloatField
      FieldName = 'UOMQty'
      Origin = 'tblequipmentxref.UOMQty'
    end
    object tblDetailsNextServiceDate: TDateTimeField
      FieldName = 'NextServiceDate'
    end
    object tblDetailsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object imgCredit: TImageList
    Left = 218
    Top = 4
    Bitmap = {
      494C01010200F800300210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000000080808000000000000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000008000808080000000FF000000800000000000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000000080000000800000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000800000008000008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080008080800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000FF0000008000000080000080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000800000800000000000000000FF00000080000000800000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000FF0000008000808080000000FF0000008000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000800000008000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000800000008000808080000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008000000080
      0000808080000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000F98FF9FF00000000E10FF0FF00000000
      F01FE07F00000000F83FE03F00000000FC3FE01F00000000F81FE20F00000000
      F00FFF0700000000F00FFF8700000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object cboClientLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientID,'
      
        '-- CONCAT_WS(" ", If(InStr(Company,'#39'^'#39') -1 >0,Left(Company,InStr' +
        '(Company,'#39'^'#39')-1),Company),IF(char_length(JobName)>0, Concat("(",' +
        'JobName,")"),'#39#39')) as CompanyName,'
      'Company as Company,'
      'PrintName as PrintName,'
      'StopCredit AS StopCredit,'
      'IsJob,Customer,Supplier,OtherContact'
      'FROM tblclients'
      
        'WHERE not IsNull(tblclients.Company) And (tblclients.Active <>'#39'F' +
        #39' or clientID =:Selectedclient)'
      
        'AND (  tblclients.Customer ='#39'T'#39' OR tblclients.Supplier = '#39'T'#39' OR ' +
        'tblclients.OtherContact = '#39'T'#39')'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (Company LIKE Concat(:SearchValue,"%")' +
        '))'
      
        'or ((:SearchMode = 2) and (Company LIKE Concat("%",:SearchValue,' +
        '"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    FilterOptions = [foCaseInsensitive]
    AfterOpen = cboClientLookupAfterOpen
    OnCalcFields = cboClientLookupCalcFields
    Options.LongStrings = False
    Left = 243
    Top = 66
    ParamData = <
      item
        DataType = ftInteger
        Name = 'Selectedclient'
        Value = 0
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object cboClientLookupStopCreditImage: TIntegerField
      DisplayWidth = 3
      FieldKind = fkCalculated
      FieldName = 'StopCreditImage'
      Calculated = True
    end
    object cboClientLookupClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
      Visible = False
    end
    object cboClientLookupStopCredit: TWideStringField
      FieldName = 'StopCredit'
      Origin = 'tblclients.StopCredit'
      FixedChar = True
      Size = 1
    end
    object cboClientLookupIsJob: TWideStringField
      FieldName = 'IsJob'
      Origin = 'tblclients.IsJob'
      FixedChar = True
      Size = 1
    end
    object cboClientLookupCustomer: TWideStringField
      FieldName = 'Customer'
      Origin = 'tblclients.Customer'
      FixedChar = True
      Size = 1
    end
    object cboClientLookupSupplier: TWideStringField
      FieldName = 'Supplier'
      Origin = 'tblclients.Supplier'
      FixedChar = True
      Size = 1
    end
    object cboClientLookupOtherContact: TWideStringField
      FieldName = 'OtherContact'
      Origin = 'tblclients.OtherContact'
      FixedChar = True
      Size = 1
    end
    object cboClientLookupCompany: TWideStringField
      DisplayWidth = 20
      FieldName = 'Company'
      Size = 160
    end
    object cboClientLookupPrintName: TWideStringField
      DisplayWidth = 20
      FieldName = 'PrintName'
      Size = 255
    end
  end
  object cboClassQry: TERPQuery
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName;')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 106
    Top = 122
  end
  object cboLastRepLookup: TERPQuery
    SQL.Strings = (
      
        'SELECT tblEmployees.EmployeeID, Concat(firstname,'#39' '#39',Lastname) A' +
        'S EmployeeName '
      'FROM tblEmployees '
      'WHERE tblEmployees.Active<>'#39'F'#39' '
      'ORDER BY Concat(firstname,'#39' '#39',Lastname);')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 76
    Top = 122
  end
  object cboRepLookup: TERPQuery
    SQL.Strings = (
      
        'SELECT EmployeeID as TrainerID, EmployeeName, Email, Active, msT' +
        'imestamp'
      'FROM tblEmployees '
      'WHERE (Active <> '#39'F'#39' and Rep <> '#39'F'#39') or (EmployeeId = :EmpID)'
      'ORDER BY EmployeeName')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 46
    Top = 122
    ParamData = <
      item
        DataType = ftInteger
        Name = 'EmpID'
        Value = 0
      end>
  end
  object tblApptGroups: TERPQuery
    SQL.Strings = (
      'Select * from tblAppointGroups')
    Left = 284
    Top = 122
    object tblApptGroupsAppointID: TIntegerField
      FieldName = 'AppointID'
    end
    object tblApptGroupsGroupID: TIntegerField
      FieldName = 'GroupID'
    end
  end
  object qryApptGrp: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Delete from tblAppointGroups where GroupID = :GroupID')
    FilterOptions = [foCaseInsensitive]
    AfterOpen = cboClientLookupAfterOpen
    OnCalcFields = cboClientLookupCalcFields
    Options.LongStrings = False
    Left = 254
    Top = 122
    ParamData = <
      item
        DataType = ftString
        Name = 'GroupID'
        Value = ''
      end>
  end
  object qryCancellationReason: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT DISTINCT Name FROM tblSimpleTypes WHERE TypeCode = :TypeC' +
        'ode'
      'AND (Active = "T" OR Name = :Name)')
    Left = 79
    Top = 154
    ParamData = <
      item
        DataType = ftString
        Name = 'TypeCode'
        Value = ''
      end
      item
        DataType = ftUnknown
        Name = 'Name'
      end>
  end
  object qryStatusType: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblSimpleTypes '
      'where Active <> "F" and TypeCode = '#39'AppointmentStatusType'#39
      '')
    Left = 164
    Top = 122
  end
  object QryAvailableServices: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select * from tblTrainerRates WHERE EmployeeID=:cboTrainerID and' +
        ' ServiceID in (Select s.ServiceID from  tblServices s where s.ac' +
        'tive = '#39'T'#39' ) or serviceId =  :ServiceID')
    Left = 224
    Top = 122
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cboTrainerID'
      end
      item
        DataType = ftUnknown
        Name = 'ServiceID'
      end>
    object FloatField1: TFloatField
      DisplayWidth = 10
      FieldName = 'Rate'
      Origin = 'tblTrainerRates.Rate'
    end
    object IntegerField1: TIntegerField
      DisplayWidth = 10
      FieldName = 'ServiceID'
      Origin = 'tblServices.ServiceID'
      Visible = False
    end
    object FloatField2: TFloatField
      DisplayWidth = 10
      FieldName = 'PayRate'
      Origin = 'tblTrainerRates.PayRate'
      Visible = False
    end
    object IntegerField2: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblTrainerRates.EmployeeID'
      Visible = False
    end
    object IntegerField3: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblTrainerRates.ClientID'
      Visible = False
    end
  end
  object qryCustomFields: TERPQuery
    Connection = frmCustomFields.MyConnection
    SQL.Strings = (
      'SELECT * FROM tblcustomfields;')
    Options.LongStrings = False
    Left = 109
    Top = 154
  end
  object qryMediaType: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT  tblSource.MedTypeID, tblSource.MediaType, tblSource.Acti' +
        've '
      'FROM tblSource '
      
        'WHERE (((tblSource.MediaType)>" ") And ((tblSource.Active)<>'#39'F'#39')' +
        ') '
      'ORDER BY tblSource.MediaType; ')
    Options.LongStrings = False
    Left = 137
    Top = 154
  end
  object QryServiceLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Distinct '
      'ServiceID, '
      'ServiceDesc, '
      'IsFixedRate '
      'FROM tblServices')
    Left = 175
    Top = 154
    object QryServiceLookupServiceID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ServiceID'
      Origin = 'tblservices.ServiceID'
    end
    object QryServiceLookupServiceDesc: TWideStringField
      FieldName = 'ServiceDesc'
      Origin = 'tblservices.ServiceDesc'
      Size = 50
    end
    object QryServiceLookupIsFixedRate: TWideStringField
      FieldName = 'IsFixedRate'
      Origin = 'tblservices.IsFixedRate'
      FixedChar = True
      Size = 1
    end
  end
  object TmrReminderhint: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TmrReminderhintTimer
    Left = 460
    Top = 64
  end
  object qrySuburb: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT LocationID, City_sub, State, Postcode, Code, Country'
      'FROM tblLocations '
      'Where RegionID= :xRegionID'
      'ORDER BY City_sub;')
    Options.LongStrings = False
    Left = 209
    Top = 153
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object qryServices: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblTrainerRates')
    Left = 135
    Top = 122
    object qryServicesRate: TFloatField
      DisplayWidth = 10
      FieldName = 'Rate'
      Origin = 'tbltrainerrates.Rate'
    end
    object qryServicesServiceID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ServiceID'
      Origin = 'tbltrainerrates.ServiceID'
      Visible = False
    end
    object qryServicesPayRate: TFloatField
      DisplayWidth = 10
      FieldName = 'PayRate'
      Origin = 'tbltrainerrates.PayRate'
      Visible = False
    end
    object qryServicesEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tbltrainerrates.EmployeeID'
      Visible = False
    end
    object qryServicesClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tbltrainerrates.ClientID'
      Visible = False
    end
    object qryServicesServiceDesc: TStringField
      FieldKind = fkLookup
      FieldName = 'ServiceDesc'
      LookupDataSet = QryServiceLookup
      LookupKeyFields = 'ServiceID'
      LookupResultField = 'ServiceDesc'
      KeyFields = 'ServiceID'
      Size = 0
      Lookup = True
    end
    object qryServicesIsFixedRate: TWideStringField
      FieldKind = fkLookup
      FieldName = 'IsFixedRate'
      LookupDataSet = QryServiceLookup
      LookupKeyFields = 'ServiceID'
      LookupResultField = 'IsFixedRate'
      KeyFields = 'ServiceID'
      Lookup = True
    end
  end
  object dsAppointmentsTimeLog: TDataSource
    DataSet = qryAppointmentsTimeLog
    Left = 46
    Top = 351
  end
  object qryAppointmentsTimeLog: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblappointmentstimelog')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = qryAppointmentsTimeLogBeforeOpen
    Active = True
    Left = 43
    Top = 384
    object qryAppointmentsTimeLogStartDatetime: TDateTimeField
      DisplayLabel = 'From'
      DisplayWidth = 18
      FieldName = 'StartDatetime'
      Origin = 'tblappointmentstimelog.StartDatetime'
    end
    object qryAppointmentsTimeLogEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 10
      FieldName = 'EmployeeName'
      Origin = 'tblappointmentstimelog.Employeename'
      Size = 255
    end
    object qryAppointmentsTimeLogDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'tblappointmentstimelog.Description'
      Size = 255
    end
    object qryAppointmentsTimeLogIncludeForInvoice: TWideStringField
      DisplayLabel = 'Invoice ?'
      DisplayWidth = 1
      FieldName = 'IncludeForInvoice'
      Origin = 'tblappointmentstimelog.IncludeForInvoice'
      FixedChar = True
      Size = 1
    end
    object qryAppointmentsTimeLogEndDatetime: TDateTimeField
      DisplayLabel = 'To'
      DisplayWidth = 18
      FieldName = 'EndDatetime'
      Origin = 'tblappointmentstimelog.EndDatetime'
    end
    object qryAppointmentsTimeLogDuration: TFloatField
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'Duration'
      Calculated = True
    end
    object qryAppointmentsTimeLogEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblappointmentstimelog.EmployeeID'
      Visible = False
    end
    object qryAppointmentsTimeLogID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblappointmentstimelog.ID'
      Visible = False
    end
    object qryAppointmentsTimeLogAppointID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AppointID'
      Origin = 'tblappointmentstimelog.AppointID'
      Visible = False
    end
    object qryAppointmentsTimeLogGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblappointmentstimelog.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryAppointmentsTimeLogEnteredByEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EnteredByEmployeeID'
      Origin = 'tblappointmentstimelog.EnteredByEmployeeID'
      Visible = False
    end
    object qryAppointmentsTimeLogmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblappointmentstimelog.msTimeStamp'
      Visible = False
    end
    object qryAppointmentsTimeLogmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblappointmentstimelog.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object QryEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT EmployeeID as TrainerID, EmployeeName, Email, Active, msT' +
        'imestamp'
      'FROM tblEmployees '
      'WHERE (Active <> '#39'F'#39' and Rep <> '#39'F'#39') '
      'ORDER BY EmployeeName')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 78
    Top = 386
    object QryEmployeeEmployeeName: TWideStringField
      DisplayWidth = 30
      FieldName = 'EmployeeName'
      Size = 255
    end
    object QryEmployeeTrainerID: TIntegerField
      FieldName = 'TrainerID'
      Visible = False
    end
  end
end
