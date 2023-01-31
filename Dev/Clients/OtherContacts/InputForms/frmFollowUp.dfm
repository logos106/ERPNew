inherited fmFollowUp: TfmFollowUp
  Left = 247
  Top = 142
  HelpContext = 165000
  Caption = 'Follow-Up'
  ClientHeight = 506
  ClientWidth = 827
  OldCreateOrder = True
  ExplicitLeft = 247
  ExplicitTop = 142
  ExplicitWidth = 843
  ExplicitHeight = 545
  DesignSize = (
    827
    506)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 458
    Width = 827
    ExplicitTop = 458
    ExplicitWidth = 827
    HelpContext = 165075
  end
  inherited imgGridWatermark: TImage
    HelpContext = 165001
  end
  object pnlTop: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 827
    Height = 87
    HelpContext = 165002
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object txtCompany: TDBMemo
      Left = 13
      Top = 51
      Width = 797
      Height = 25
      HelpContext = 165003
      TabStop = False
      Alignment = taCenter
      DataField = 'Company'
      DataSource = dsClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object pnlTitle: TDNMPanel [6]
    Left = 294
    Top = 5
    Width = 238
    Height = 39
    HelpContext = 165072
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 35
      HelpContext = 165073
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
        Width = 234
        Height = 35
        HelpContext = 165074
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Follow-Up'
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
  object pnlBottom: TDNMPanel [7]
    Left = 0
    Top = 458
    Width = 827
    Height = 48
    HelpContext = 165065
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      827
      48)
    object btnOk: TDNMSpeedButton
      Left = 80
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 165066
      Anchors = [akBottom]
      Caption = '&Save'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnOkClick
    end
    object cmdFollowUp: TDNMSpeedButton
      Left = 428
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 165067
      Anchors = [akBottom]
      Caption = '&Follow-Up'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 3
      OnClick = cmdFollowUpClick
    end
    object cmdClose: TDNMSpeedButton
      Left = 661
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 165068
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 5
      OnClick = cmdCloseClick
    end
    object btnNext: TDNMSpeedButton
      Left = 195
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 165069
      Anchors = [akBottom]
      Cancel = True
      Caption = 'Next'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333333333333EEEEEEEEEEEEEEE333FFFFFFFFFFFFF3E00000000000
        00E337777777777777F3E0F77777777770E337F33333333337F3E0F333333333
        70E337F3333F333337F3E0F33303333370E337F3337FF33337F3E0F333003333
        70E337F33377FF3337F3E0F33300033370E337F333777FF337F3E0F333000033
        70E337F33377773337F3E0F33300033370E337F33377733337F3E0F333003333
        70E337F33377333337F3E0F33303333370E337F33373333337F3E0F333333333
        70E337F33333333337F3E0FFFFFFFFFFF0E337FFFFFFFFFFF7F3E00000000000
        00E33777777777777733EEEEEEEEEEEEEEE33333333333333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnNextClick
    end
    object btnAppointment: TDNMSpeedButton
      Left = 545
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 165070
      Anchors = [akBottom]
      Caption = '&Appointment'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 4
      OnClick = btnAppointmentClick
    end
    object btnClient: TDNMSpeedButton
      Left = 312
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 165071
      Anchors = [akBottom]
      Caption = 'Contact'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 2
      OnClick = btnClientClick
    end
  end
  object DNMPanel1: TDNMPanel [8]
    Left = 0
    Top = 87
    Width = 827
    Height = 371
    HelpContext = 165004
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object PageControl: TPageControl
      Left = 9
      Top = 0
      Width = 808
      Height = 369
      HelpContext = 165005
      ActivePage = tabDetails
      TabHeight = 25
      TabOrder = 0
      TabWidth = 402
      object tabDetails: TTabSheet
        HelpContext = 165006
        Caption = 'Details'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlDetails: TDNMPanel
          Left = 0
          Top = 0
          Width = 800
          Height = 334
          HelpContext = 165007
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label8: TLabel
            Left = 10
            Top = 309
            Width = 75
            Height = 15
            HelpContext = 165008
            Caption = 'Last Updated'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label6: TLabel
            Left = 11
            Top = 216
            Width = 33
            Height = 15
            HelpContext = 165009
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
          object lblFollowUpType: TLabel
            Left = 8
            Top = 171
            Width = 26
            Height = 15
            HelpContext = 165010
            Caption = 'Type'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblFollowUpDate: TLabel
            Left = 187
            Top = 172
            Width = 83
            Height = 15
            HelpContext = 165011
            Caption = 'Follow-up Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblEmployee: TLabel
            Left = 369
            Top = 172
            Width = 55
            Height = 15
            HelpContext = 165012
            Caption = 'Employee'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblFollowUpResult: TLabel
            Left = 545
            Top = 172
            Width = 36
            Height = 15
            HelpContext = 165013
            Caption = 'Result'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblDone: TLabel
            Left = 754
            Top = 190
            Width = 29
            Height = 15
            HelpContext = 165014
            Caption = 'Done'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lblListSelection: TLabel
            Left = 11
            Top = 9
            Width = 82
            Height = 15
            HelpContext = 165015
            Caption = 'Contacts Lists'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object edtLastUpdated: TwwDBEdit
            Left = 91
            Top = 306
            Width = 89
            Height = 23
            HelpContext = 165016
            TabStop = False
            DataField = 'UpdateDate'
            DataSource = dsFollowUp
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object memNotes: TDBMemo
            Left = 8
            Top = 230
            Width = 785
            Height = 66
            HelpContext = 165017
            TabStop = False
            DataField = 'Notes'
            DataSource = dsFollowUp
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnEnter = memNotesEnter
          end
          object grdContacts: TwwDBGrid
            Left = 8
            Top = 36
            Width = 785
            Height = 127
            HelpContext = 165018
            TabStop = False
            Selected.Strings = (
              'JobTitle'#9'17'#9'Job Title'#9'T'#9
              'Title'#9'6'#9'Title'#9'T'#9
              'FirstName'#9'14'#9'First Name'#9'T'#9
              'LastName'#9'14'#9'Last Name'#9'T'#9
              'Phone'#9'15'#9'Phone'#9'T'#9
              'AltPhone'#9'15'#9'Alt Phone'#9'T'#9
              'Mobile'#9'15'#9'Mobile'#9'T'#9
              'Email'#9'20'#9'Email'#9'T'#9)
            MemoAttributes = [mSizeable, mWordWrap, mGridShow]
            IniAttributes.Delimiter = ';;'
            TitleColor = 14155775
            FixedCols = 0
            ShowHorzScrollBar = True
            DataSource = dsContacts
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            TitleAlignment = taLeftJustify
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
          end
          object cboFollowUpType: TwwDBLookupCombo
            Left = 8
            Top = 187
            Width = 165
            Height = 23
            HelpContext = 165019
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Name'#9'30'#9'Name'#9'F')
            DataField = 'TypeId'
            DataSource = dsFollowUp
            LookupTable = qryFollowUpType
            LookupField = 'Id'
            ParentFont = False
            TabOrder = 3
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnNotInList = cboFollowUpTypeNotInList
          end
          object dtpFollowUpDate: TwwDBDateTimePicker
            Left = 188
            Top = 187
            Width = 165
            Height = 23
            HelpContext = 165020
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'FollowUpDate'
            DataSource = dsFollowUp
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 4
            DisplayFormat = 'dd/mm/yyyy hh:nn:ss'
          end
          object cboEmployee: TwwDBLookupCombo
            Left = 368
            Top = 187
            Width = 165
            Height = 23
            HelpContext = 165021
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'EmployeeName'#9'40'#9'Employee Name'#9'F')
            DataField = 'EmployeeID'
            DataSource = dsFollowUp
            LookupTable = qryEmployee
            LookupField = 'EmployeeId'
            ParentFont = False
            TabOrder = 5
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnNotInList = cboFollowUpResultNotInList
          end
          object cboFollowUpResult: TwwDBLookupCombo
            Left = 544
            Top = 187
            Width = 165
            Height = 23
            HelpContext = 165022
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Name'#9'30'#9'Name'#9'F')
            DataField = 'ResultTypeId'
            DataSource = dsFollowUp
            LookupTable = qryFollowUpResultType
            LookupField = 'Id'
            ParentFont = False
            TabOrder = 6
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnNotInList = cboFollowUpResultNotInList
          end
          object chkDone: TwwCheckBox
            Left = 731
            Top = 189
            Width = 17
            Height = 17
            HelpContext = 165023
            DisableThemes = False
            AlwaysTransparent = True
            Frame.Enabled = True
            Frame.Transparent = True
            Frame.FocusBorders = []
            Frame.NonFocusBorders = []
            ValueChecked = 'True'
            ValueUnchecked = 'False'
            DisplayValueChecked = 'True'
            DisplayValueUnchecked = 'False'
            NullAndBlankState = cbUnchecked
            Caption = 'Done'
            DataField = 'Done'
            DataSource = dsFollowUp
            TabOrder = 7
          end
          object cboListSelection: TwwDBLookupCombo
            Left = 97
            Top = 6
            Width = 209
            Height = 23
            HelpContext = 165024
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'RangeDescription'#9'40'#9'Description'#9'F')
            LookupTable = qryClientSelectionList
            LookupField = 'RangeDescription'
            TabOrder = 8
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnDblClick = cboListSelectionDblClick
            OnCloseUp = cboListSelectionCloseUp
          end
        end
      end
      object Custom_Fields: TTabSheet
        HelpContext = 165025
        Caption = 'Custom Fields'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlCustFields: TDNMPanel
          Left = 0
          Top = 0
          Width = 800
          Height = 334
          HelpContext = 165026
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Box181: TBevel
            Left = 8
            Top = 36
            Width = 784
            Height = 234
            HelpContext = 165027
          end
          object CUSTLBL1: TLabel
            Left = 45
            Top = 62
            Width = 80
            Height = 15
            HelpContext = 165028
            Alignment = taRightJustify
            Caption = 'Custom Field1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL2: TLabel
            Left = 45
            Top = 96
            Width = 80
            Height = 15
            HelpContext = 165029
            Alignment = taRightJustify
            Caption = 'Custom Field2'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL3: TLabel
            Left = 45
            Top = 131
            Width = 80
            Height = 15
            HelpContext = 165030
            Alignment = taRightJustify
            Caption = 'Custom Field3'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL4: TLabel
            Left = 45
            Top = 165
            Width = 80
            Height = 15
            HelpContext = 165031
            Alignment = taRightJustify
            Caption = 'Custom Field4'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL5: TLabel
            Left = 45
            Top = 199
            Width = 80
            Height = 15
            HelpContext = 165032
            Alignment = taRightJustify
            Caption = 'Custom Field5'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL6: TLabel
            Left = 46
            Top = 233
            Width = 80
            Height = 15
            HelpContext = 165033
            Alignment = taRightJustify
            Caption = 'Custom Field6'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL7: TLabel
            Left = 297
            Top = 63
            Width = 80
            Height = 15
            HelpContext = 165034
            Alignment = taRightJustify
            Caption = 'Custom Field7'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL8: TLabel
            Left = 297
            Top = 96
            Width = 80
            Height = 15
            HelpContext = 165035
            Alignment = taRightJustify
            Caption = 'Custom Field8'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL9: TLabel
            Left = 297
            Top = 131
            Width = 80
            Height = 15
            HelpContext = 165036
            Alignment = taRightJustify
            Caption = 'Custom Field9'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL10: TLabel
            Left = 290
            Top = 165
            Width = 87
            Height = 15
            HelpContext = 165037
            Alignment = taRightJustify
            Caption = 'Custom Field10'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL11: TLabel
            Left = 291
            Top = 198
            Width = 86
            Height = 15
            HelpContext = 165038
            Alignment = taRightJustify
            Caption = 'Custom Field11'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL12: TLabel
            Left = 290
            Top = 232
            Width = 87
            Height = 15
            HelpContext = 165039
            Alignment = taRightJustify
            Caption = 'Custom Field12'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL13: TLabel
            Left = 565
            Top = 62
            Width = 87
            Height = 15
            HelpContext = 165040
            Alignment = taRightJustify
            Caption = 'Custom Field13'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL14: TLabel
            Left = 565
            Top = 96
            Width = 87
            Height = 15
            HelpContext = 165041
            Alignment = taRightJustify
            Caption = 'Custom Field14'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL15: TLabel
            Left = 565
            Top = 131
            Width = 87
            Height = 15
            HelpContext = 165042
            Alignment = taRightJustify
            Caption = 'Custom Field15'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL16: TLabel
            Left = 565
            Top = 165
            Width = 87
            Height = 15
            HelpContext = 165043
            Alignment = taRightJustify
            Caption = 'Custom Field16'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL17: TLabel
            Left = 565
            Top = 199
            Width = 87
            Height = 15
            HelpContext = 165044
            Alignment = taRightJustify
            Caption = 'Custom Field17'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object CUSTLBL18: TLabel
            Left = 565
            Top = 232
            Width = 87
            Height = 15
            HelpContext = 165045
            Alignment = taRightJustify
            Caption = 'Custom Field18'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object cmdCustomLabelsOld: TDNMSpeedButton
            Left = 332
            Top = 286
            Width = 87
            Height = 27
            Hint = '"Add A New Customised Field For All Employee'#39's"'
            HelpContext = 165046
            Caption = '&Add Labels'
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 15
            OnClick = cmdCustomLabelsOldClick
          end
          object CUSTFLD1: TwwDBComboBox
            Left = 128
            Top = 59
            Width = 130
            Height = 23
            HelpContext = 165047
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD1'
            DataSource = dsClient
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
            Left = 128
            Top = 93
            Width = 130
            Height = 23
            HelpContext = 165048
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD2'
            DataSource = dsClient
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
            Left = 128
            Top = 128
            Width = 130
            Height = 23
            HelpContext = 165049
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD3'
            DataSource = dsClient
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
            Left = 128
            Top = 162
            Width = 130
            Height = 23
            HelpContext = 165050
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD4'
            DataSource = dsClient
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
            Left = 128
            Top = 196
            Width = 130
            Height = 23
            HelpContext = 165051
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD5'
            DataSource = dsClient
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
            Left = 379
            Top = 162
            Width = 130
            Height = 23
            HelpContext = 165052
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD10'
            DataSource = dsClient
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
            Left = 379
            Top = 128
            Width = 130
            Height = 23
            HelpContext = 165053
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD9'
            DataSource = dsClient
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
            Left = 379
            Top = 93
            Width = 130
            Height = 23
            HelpContext = 165054
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD8'
            DataSource = dsClient
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
            Left = 379
            Top = 59
            Width = 130
            Height = 23
            HelpContext = 165055
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD7'
            DataSource = dsClient
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
            Left = 128
            Top = 230
            Width = 130
            Height = 23
            HelpContext = 165056
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD6'
            DataSource = dsClient
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
            Left = 379
            Top = 196
            Width = 130
            Height = 23
            HelpContext = 165057
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD11'
            DataSource = dsClient
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
            Left = 379
            Top = 229
            Width = 130
            Height = 23
            HelpContext = 165058
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD12'
            DataSource = dsClient
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
            Left = 654
            Top = 59
            Width = 130
            Height = 23
            HelpContext = 165059
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD13'
            DataSource = dsClient
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
            Left = 654
            Top = 93
            Width = 130
            Height = 23
            HelpContext = 165060
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD14'
            DataSource = dsClient
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
            Left = 654
            Top = 128
            Width = 130
            Height = 23
            HelpContext = 165061
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'CUSTFLD15'
            DataSource = dsClient
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
            Left = 654
            Top = 162
            Width = 130
            Height = 23
            HelpContext = 165062
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'CUSTDATE1'
            DataSource = dsClient
            Epoch = 1950
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ShowButton = True
            TabOrder = 16
          end
          object CUSTFLD17: TwwDBDateTimePicker
            Left = 654
            Top = 196
            Width = 130
            Height = 23
            HelpContext = 165063
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'CUSTDATE2'
            DataSource = dsClient
            Epoch = 1950
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ShowButton = True
            TabOrder = 17
          end
          object CUSTFLD18: TwwDBDateTimePicker
            Left = 654
            Top = 229
            Width = 130
            Height = 23
            HelpContext = 165064
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'CUSTDATE3'
            DataSource = dsClient
            Epoch = 1950
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ShowButton = True
            TabOrder = 18
          end
        end
      end
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 56
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 200
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 136
  end
  inherited DataState: TDataState
    Left = 144
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102001C00380010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited qryMemTrans: TERPQuery
    Top = 104
  end
  object dsClient: TDataSource
    DataSet = qryClient
    Left = 72
    Top = 40
  end
  object dsContacts: TDataSource
    DataSet = qryContacts
    Left = 296
    Top = 56
  end
  object dsFollowUp: TDataSource
    DataSet = qryFollowUp
    Left = 472
    Top = 56
  end
  object qryContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '/*'
      'SELECT'
      
        'C.Title, C.FirstName, C.LastName, C.Phone, C.Mobile, C.Email, C.' +
        'JobTitle, C.AltPhone'
      'FROM tblClients C'
      'WHERE C.ClientId = :ClientId'
      'UNION'
      'SELECT'
      
        'T.ContactTitle, T.ContactFirstName, T.ContactSurname, T.ContactP' +
        'H, T.ContactMOB,'
      'T.ContactEmail, T.JobTitle, T.ContactAltPh, T.ContactId'
      'FROM tblContacts T'
      'WHERE '
      'T.Active = "T" and'
      'T.ClientId = :CusId'
      '*/'
      'SELECT'
      
        'C.Title, C.FirstName, C.LastName, C.Phone, C.Mobile, C.Email, C.' +
        'JobTitle, C.AltPhone, 0 as ContactId'
      'FROM tblClients C'
      'where C.ClientId not in (select ClientId from tblcontacts) '
      'and C.ClientId=:ClientId'
      'UNION'
      'SELECT'
      
        'T.ContactTitle, T.ContactFirstName, T.ContactSurname, T.ContactP' +
        'H, T.ContactMOB,'
      'T.ContactEmail, T.JobTitle, T.ContactAltPh, ContactId'
      'FROM tblContacts T'
      'WHERE  active = "T" and'
      'T.ClientId = :ClientId')
    Left = 280
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientId'
      end
      item
        DataType = ftUnknown
        Name = 'ClientId'
      end>
    object qryContactsJobTitle: TWideStringField
      DisplayLabel = 'Job Title'
      DisplayWidth = 17
      FieldName = 'JobTitle'
      Size = 255
    end
    object qryContactsTitle: TWideStringField
      DisplayWidth = 6
      FieldName = 'Title'
      Size = 32
    end
    object qryContactsFirstName: TWideStringField
      DisplayLabel = 'First Name'
      DisplayWidth = 14
      FieldName = 'FirstName'
      Size = 15
    end
    object qryContactsLastName: TWideStringField
      DisplayLabel = 'Last Name'
      DisplayWidth = 14
      FieldName = 'LastName'
      Size = 30
    end
    object qryContactsPhone: TWideStringField
      DisplayWidth = 15
      FieldName = 'Phone'
      OnGetText = qryContactsPhoneGetText
    end
    object qryContactsAltPhone: TWideStringField
      DisplayLabel = 'Alt Phone'
      DisplayWidth = 15
      FieldName = 'AltPhone'
      Size = 255
    end
    object qryContactsMobile: TWideStringField
      DisplayWidth = 15
      FieldName = 'Mobile'
    end
    object qryContactsEmail: TWideStringField
      DisplayWidth = 20
      FieldName = 'Email'
      Size = 80
    end
    object qryContactsContactId: TLargeintField
      FieldName = 'ContactId'
    end
  end
  object qryFollowUp: TERPQuery
    SQL.Strings = (
      'Select * from tblOtherFollowUP where FollowUpID = :FollowUpId')
    AfterOpen = qryFollowUpAfterOpen
    AfterClose = qryFollowUpAfterClose
    Left = 408
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FollowUpId'
      end>
    object qryFollowUpGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryFollowUpFollowUpID: TAutoIncField
      FieldName = 'FollowUpID'
      ReadOnly = True
    end
    object qryFollowUpOtherContactID: TIntegerField
      FieldName = 'OtherContactID'
    end
    object qryFollowUpRepairID: TIntegerField
      FieldName = 'RepairID'
    end
    object qryFollowUpEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryFollowUpClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryFollowUpFollowUpDate: TDateTimeField
      FieldName = 'FollowUpDate'
    end
    object qryFollowUpDone: TWideStringField
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object qryFollowUpEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryFollowUpAppearDays: TIntegerField
      FieldName = 'AppearDays'
    end
    object qryFollowUpCreationDate: TDateTimeField
      FieldName = 'CreationDate'
    end
    object qryFollowUpUpdateDate: TDateField
      FieldName = 'UpdateDate'
    end
    object qryFollowUpIsSupplier: TWideStringField
      FieldName = 'IsSupplier'
      FixedChar = True
      Size = 1
    end
    object qryFollowUpIsOtherContact: TWideStringField
      FieldName = 'IsOtherContact'
      FixedChar = True
      Size = 1
    end
    object qryFollowUpIsCustomer: TWideStringField
      FieldName = 'IsCustomer'
      FixedChar = True
      Size = 1
    end
    object qryFollowUpHours: TFloatField
      FieldName = 'Hours'
    end
    object qryFollowUpTypeId: TIntegerField
      FieldName = 'TypeId'
    end
    object qryFollowUpResultTypeId: TIntegerField
      FieldName = 'ResultTypeId'
    end
    object qryFollowUpContactId: TIntegerField
      FieldName = 'ContactId'
    end
    object qryFollowUpIsPhoneFollowUp: TWideStringField
      FieldName = 'IsPhoneFollowUp'
      FixedChar = True
      Size = 1
    end
    object qryFollowUpNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
  end
  object qryClient: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblClients WHERE ClientId = :ClientId')
    Left = 24
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientId'
      end>
  end
  object qryFollowUpResultType: TERPQuery
    SQL.Strings = (
      
        'Select * from tblSimpleTypes where Active <> "F" and TypeCode = ' +
        ':TypeCode')
    Left = 576
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TypeCode'
      end>
  end
  object qryFollowUpType: TERPQuery
    SQL.Strings = (
      
        'Select * from tblSimpleTypes where Active <> "F" and TypeCode = ' +
        ':TypeCode')
    Left = 136
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TypeCode'
      end>
  end
  object qryEmployee: TERPQuery
    SQL.Strings = (
      'SELECT EmployeeId, EmployeeName, Active FROM tblEmployees'
      'WHERE Active = "T"')
    Left = 360
    Top = 48
  end
  object qryClientSelectionList: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblMarketingrangeselection '
      'WHERE Active = "T"')
    Left = 664
    Top = 16
  end
  object qryClientList: TERPQuery
    SQL.Strings = (
      'SELECT tblSimpleTypes.Name as CompanyType, tblClients.* '
      'FROM tblClients'
      
        'LEFT JOIN tblSimpleTypes ON tblClients.CompanyTypeId = tblSimple' +
        'Types.Id'
      
        'LEFT JOIN tblOtherFollowup ON tblOtherFollowup.ClientId = tblCli' +
        'ents.ClientId'
      'WHERE tblOtherFollowup.FollowUpId IS NULL'
      'AND tblClients.Active = "T"'
      'AND tblClients.OtherContact = "T"'
      'AND tblClients.Customer = "F"'
      'AND tblClients.Supplier = "F"')
    Left = 720
    Top = 8
  end
  object qryCustomFields: TERPQuery
    SQL.Strings = (
      'SELECT '
      'CFLabel1,CFCust1, CFEmpl1, CFSupp1, CFLabel2, '
      'CFCust2, CFEmpl2, CFSupp2, CFLabel3, CFCust3, CFEmpl3, '
      'CFSupp3, CFLabel4, CFCust4, CFEmpl4, CFSupp4, CFLabel5, '
      'CFCust5, CFEmpl5, CFSupp5, CFLabel6, CFCust6, CFEmpl6, '
      'CFSupp6, CFLabel7, CFCust7, CFEmpl7, CFSupp7, CFLabel8, '
      'CFCust8, CFEmpl8, CFSupp8, CFLabel9, CFCust9, CFEmpl9, '
      'CFSupp9, CFLabel10, CFCust10, CFEmpl10, CFSupp10, CFLabel11,'
      'CFCust11, CFEmpl11, CFSupp11, CFLabel12, CFCust12, CFEmpl12, '
      'CFSupp12, CFLabel13, CFCust13, CFEmpl13, CFSupp13, CFLabel14, '
      'CFCust14, CFEmpl14, CFSupp14, CFLabel15, CFCust15, CFEmpl15,'
      
        'CFSupp15, EditedFlag, CFOthr1, CFOthr2, CFOthr3, CFOthr4, CFOthr' +
        '5, '
      
        'CFOthr6, CFOthr7, CFOthr8, CFOthr9, CFOthr10, CFOthr11, CFOthr12' +
        ', '
      'CFOthr13, CFOthr14, CFOthr15, CFOthr16, CFOthr17, CFOthr18,'
      'CFLabel16, CFLabel17, CFLabel18  '
      'FROM tblcustomfields')
    Left = 664
    Top = 72
  end
  object dsCustomFields: TDataSource
    DataSet = qryCustomFields
    Left = 680
    Top = 118
  end
  object qryCheckForFollowUps: TERPQuery
    SQL.Strings = (
      
        'SELECT FollowUpId FROM tblOtherFollowUp WHERE ClientId = :Client' +
        'Id')
    Left = 728
    Top = 72
    ParamData = <
      item
        DataType = ftString
        Name = 'ClientId'
        Value = ''
      end>
  end
  object cmd: TERPCommand
    CommandTimeout = 30
    Left = 536
    Top = 40
  end
end
