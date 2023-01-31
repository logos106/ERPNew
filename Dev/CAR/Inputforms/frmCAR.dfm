inherited fmCAR: TfmCAR
  Left = 386
  Top = 211
  HelpContext = 1130002
  Caption = 'Corrective Action Reporting'
  ClientHeight = 565
  ClientWidth = 996
  ExplicitLeft = 386
  ExplicitTop = 211
  ExplicitWidth = 1012
  ExplicitHeight = 604
  DesignSize = (
    996
    565)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 515
    Width = 996
    HelpContext = 1130003
    ExplicitTop = 223
    ExplicitWidth = 455
  end
  inherited shapehint: TShape
    Left = 126
    Top = 10
    ExplicitLeft = 49
    ExplicitTop = 10
  end
  inherited imgGridWatermark: TImage
    Left = 305
    Top = 10
    ExplicitLeft = 305
    ExplicitTop = 10
  end
  inherited shapehintextra1: TShape
    Left = 266
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 50
    Width = 996
    Height = 465
    HelpContext = 1130010
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      996
      465)
    object Box20: TBevel
      Left = 10
      Top = 2
      Width = 986
      Height = 457
      HelpContext = 1130011
      Anchors = [akLeft, akTop, akRight, akBottom]
    end
    object TabCtl20: TPageControl
      Left = 1
      Top = 1
      Width = 994
      Height = 463
      HelpContext = 1130012
      ActivePage = tabMain
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MultiLine = True
      ParentFont = False
      RaggedRight = True
      TabHeight = 23
      TabOrder = 0
      TabWidth = 143
      OnChanging = TabCtl20Changing
      object tabMain: TTabSheet
        HelpContext = 1130013
        Caption = 'CAR Details'
        object pnlMain: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 980
          Height = 424
          HelpContext = 1130014
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            980
            424)
          object Shape13: TShape
            Left = 18
            Top = 254
            Width = 799
            Height = 49
            HelpContext = 1130015
            Brush.Style = bsClear
            Pen.Color = clGray
          end
          object Shape12: TShape
            Left = 18
            Top = 206
            Width = 799
            Height = 49
            HelpContext = 1130016
            Brush.Style = bsClear
            Pen.Color = clGray
          end
          object Shape11: TShape
            Left = 18
            Top = 158
            Width = 799
            Height = 49
            HelpContext = 1130017
            Brush.Style = bsClear
            Pen.Color = clGray
          end
          object Label1: TLabel
            Left = 44
            Top = 20
            Width = 65
            Height = 15
            HelpContext = 1130018
            Alignment = taRightJustify
            Caption = 'Action Type'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label2: TLabel
            Left = 30
            Top = 271
            Width = 45
            Height = 15
            HelpContext = 1130019
            Caption = 'Product'
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
            Left = 27
            Top = 54
            Width = 82
            Height = 30
            HelpContext = 1130020
            Alignment = taRightJustify
            Caption = 'Description of the Problem'
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
            Left = 781
            Top = 20
            Width = 61
            Height = 15
            HelpContext = 1130021
            Alignment = taRightJustify
            Caption = 'Entered By'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label5: TLabel
            Left = 578
            Top = 271
            Width = 55
            Height = 15
            HelpContext = 1130022
            Alignment = taRightJustify
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
          object Label6: TLabel
            Left = 333
            Top = 176
            Width = 56
            Height = 15
            HelpContext = 1130023
            Alignment = taRightJustify
            Caption = 'Customer'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label7: TLabel
            Left = 589
            Top = 175
            Width = 44
            Height = 15
            HelpContext = 1130024
            Alignment = taRightJustify
            Caption = 'Contact'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label8: TLabel
            Left = 540
            Top = 20
            Width = 81
            Height = 15
            HelpContext = 1130025
            Alignment = taRightJustify
            Caption = 'Date of Report'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label9: TLabel
            Left = 162
            Top = 176
            Width = 39
            Height = 15
            HelpContext = 1130026
            Alignment = taRightJustify
            Caption = 'Sale ID'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label10: TLabel
            Left = 16
            Top = 127
            Width = 93
            Height = 15
            HelpContext = 1130027
            Alignment = taRightJustify
            Caption = 'Production Build'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label11: TLabel
            Left = 343
            Top = 224
            Width = 47
            Height = 15
            HelpContext = 1130028
            Alignment = taRightJustify
            Caption = 'Supplier'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label12: TLabel
            Left = 6
            Top = 317
            Width = 142
            Height = 15
            HelpContext = 1130029
            Caption = 'Improvement Suggestion'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label14: TLabel
            Left = 171
            Top = 224
            Width = 31
            Height = 15
            HelpContext = 1130030
            Alignment = taRightJustify
            Caption = 'PO ID'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label39: TLabel
            Left = 589
            Top = 224
            Width = 44
            Height = 15
            HelpContext = 1130031
            Alignment = taRightJustify
            Caption = 'Contact'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label40: TLabel
            Left = 120
            Top = 176
            Width = 8
            Height = 15
            HelpContext = 1130032
            Caption = 'X'
            Visible = False
            OnClick = Label40Click
          end
          object Label41: TLabel
            Left = 121
            Top = 224
            Width = 8
            Height = 15
            HelpContext = 1130033
            Caption = 'X'
            Visible = False
            OnClick = Label41Click
          end
          object cboProcesstype: TwwDBLookupCombo
            Left = 117
            Top = 16
            Width = 273
            Height = 23
            HelpContext = 1130034
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ControlInfoInDataset = False
            DropDownAlignment = taLeftJustify
            DataField = 'ComplaintType'
            DataSource = dsCAR
            LookupTable = QryProcessType
            LookupField = 'Name'
            AutoSelect = False
            DropDownWidth = 50
            MaxLength = 255
            ParentFont = False
            TabOrder = 0
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            ShowMatchText = True
            OnDblClick = cboProcesstypeDblClick
            OnNotInList = cboProcesstypeNotInList
          end
          object cboProductR: TwwDBEdit
            Left = 81
            Top = 267
            Width = 174
            Height = 23
            HelpContext = 1130035
            DataField = 'ProductName'
            DataSource = dsCAR
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 14
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnEnter = HightLightselectSale
            OnExit = HideHighLight
          end
          object DBMemo1: TDBMemo
            Left = 117
            Top = 54
            Width = 852
            Height = 60
            HelpContext = 1130036
            DataField = 'DescriptionofProblem'
            DataSource = dsCAR
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object cboEmployee: TwwDBLookupCombo
            Left = 639
            Top = 267
            Width = 164
            Height = 23
            HelpContext = 1130037
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'EmployeeName'#9'30'#9'Employee Name'#9'F')
            DataField = 'Rep'
            DataSource = dsCAR
            LookupTable = QryRep
            LookupField = 'EmployeeName'
            DropDownWidth = 300
            ParentFont = False
            TabOrder = 16
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
          end
          object edtcustomer: TwwDBEdit
            Left = 397
            Top = 172
            Width = 174
            Height = 23
            HelpContext = 1130038
            DataField = 'ComplaintFrom'
            DataSource = dsCAR
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnEnter = HightLightselectSale
            OnExit = HideHighLight
          end
          object cbocontact: TwwDBLookupCombo
            Left = 639
            Top = 172
            Width = 164
            Height = 23
            HelpContext = 1130039
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'name'#9'30'#9'Contact Name'#9'F')
            DataField = 'contactName'
            DataSource = dsCAR
            LookupTable = qrycontacts
            LookupField = 'name'
            ParentFont = False
            TabOrder = 9
            AutoDropDown = True
            ShowButton = True
            UseTFields = False
            PreciseEditRegion = False
            AllowClearKey = False
            OnDropDown = closenOpenLookuptable
            OnEnter = cbocontactEnter
          end
          object dtReportedDate: TwwDBDateTimePicker
            Left = 628
            Top = 16
            Width = 116
            Height = 23
            HelpContext = 1130040
            AutoFillDateAndTime = True
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'ReportedDate'
            DataSource = dsCAR
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 1
          end
          object edtSales: TwwDBEdit
            Left = 207
            Top = 172
            Width = 108
            Height = 23
            HelpContext = 1130041
            DataField = 'SalesID'
            DataSource = dsCAR
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnEnter = HightLightselectSale
            OnExit = HideHighLight
          end
          object cboProductionBuild: TwwDBLookupCombo
            Left = 115
            Top = 123
            Width = 174
            Height = 23
            HelpContext = 1130042
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ControlInfoInDataset = False
            DropDownAlignment = taLeftJustify
            DataField = 'ProductionBuild'
            DataSource = dsCAR
            LookupTable = QryProductionbuild
            LookupField = 'Name'
            AutoSelect = False
            DropDownWidth = 50
            MaxLength = 255
            ParentFont = False
            TabOrder = 4
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            ShowMatchText = True
            OnDblClick = cboProductionBuildDblClick
            OnNotInList = cboProductionBuildNotInList
          end
          object edtSupplier: TwwDBEdit
            Left = 398
            Top = 220
            Width = 174
            Height = 23
            HelpContext = 1130043
            DataField = 'SupplierName'
            DataSource = dsCAR
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 12
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnEnter = HightLightselectPO
            OnExit = HideHighLight
          end
          object edtProductionBuildDesc: TwwDBEdit
            Left = 295
            Top = 123
            Width = 674
            Height = 23
            HelpContext = 1130044
            DataField = 'ProductionBuildDesc'
            DataSource = dsCAR
            Font.Charset = DEFAULT_CHARSET
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
          object DBMemo2: TDBMemo
            Left = 6
            Top = 338
            Width = 963
            Height = 78
            HelpContext = 1130045
            DataField = 'ImprovementSuggestion'
            DataSource = dsCAR
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 17
          end
          object edtPOId: TwwDBEdit
            Left = 208
            Top = 220
            Width = 108
            Height = 23
            HelpContext = 1130046
            DataField = 'POID'
            DataSource = dsCAR
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 11
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnEnter = HightLightselectPO
            OnExit = HideHighLight
          end
          object btnSelectSale: TDNMSpeedButton
            Left = 26
            Top = 169
            Width = 93
            Height = 27
            HelpContext = 1130047
            Anchors = [akBottom]
            Caption = 'Select Sale'
            Default = True
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = []
            ParentFont = False
            TabOrder = 6
            AutoDisableParentOnclick = True
            OnClick = btnSalesClick
          end
          object btnSelectPO: TDNMSpeedButton
            Left = 26
            Top = 221
            Width = 93
            Height = 27
            HelpContext = 1130048
            Anchors = [akBottom]
            Caption = 'Select PO'
            Default = True
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = []
            ParentFont = False
            TabOrder = 10
            AutoDisableParentOnclick = True
            OnClick = btnSelectPOClick
          end
          object edtEnteredBy: TwwDBEdit
            Left = 846
            Top = 16
            Width = 121
            Height = 23
            HelpContext = 1130049
            TabStop = False
            DataField = 'EnteredBy'
            DataSource = dsCAR
            ReadOnly = True
            TabOrder = 2
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object edtProductDescription: TwwDBEdit
            Left = 271
            Top = 267
            Width = 286
            Height = 23
            HelpContext = 1130050
            DataField = 'PARTSDESCRIPTION'
            DataSource = dsCAR
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
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
          object cboSupcontact: TwwDBLookupCombo
            Left = 639
            Top = 220
            Width = 164
            Height = 23
            HelpContext = 1130051
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'name'#9'30'#9'Contact Name'#9'F')
            DataField = 'supcontactName'
            DataSource = dsCAR
            LookupTable = QrySupcontact
            LookupField = 'name'
            ParentFont = False
            TabOrder = 13
            AutoDropDown = True
            ShowButton = True
            UseTFields = False
            PreciseEditRegion = False
            AllowClearKey = False
            OnDropDown = closenOpenLookuptable
            OnEnter = cbocontactEnter
          end
        end
      end
      object tabAction: TTabSheet
        HelpContext = 1130052
        Caption = 'Imm. Action'
        ImageIndex = 1
        object pnlAction: TDNMPanel
          Left = 0
          Top = 0
          Width = 986
          Height = 430
          HelpContext = 1130053
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            986
            430)
          object Label13: TLabel
            Left = 54
            Top = 23
            Width = 90
            Height = 15
            HelpContext = 1130054
            Alignment = taRightJustify
            Caption = 'Action Required'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label15: TLabel
            Left = 7
            Top = 55
            Width = 102
            Height = 15
            HelpContext = 1130055
            Caption = 'Immediate Details'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label16: TLabel
            Left = 375
            Top = 24
            Width = 65
            Height = 15
            HelpContext = 1130056
            Alignment = taRightJustify
            Caption = 'Action Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label17: TLabel
            Left = 622
            Top = 24
            Width = 67
            Height = 15
            HelpContext = 1130057
            Alignment = taRightJustify
            Caption = 'Actioned By'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object cboActionRequired: TwwDBLookupCombo
            Left = 150
            Top = 20
            Width = 189
            Height = 23
            HelpContext = 1130058
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ControlInfoInDataset = False
            DropDownAlignment = taLeftJustify
            DataField = 'ActionRequired'
            DataSource = dsCARAction
            LookupTable = QryActionRequired
            LookupField = 'Name'
            AutoSelect = False
            DropDownWidth = 50
            MaxLength = 255
            ParentFont = False
            TabOrder = 1
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            ShowMatchText = True
            OnDblClick = cboActionRequiredDblClick
            OnNotInList = cboActionRequiredNotInList
          end
          object DBMemo3: TDBMemo
            Left = 7
            Top = 76
            Width = 842
            Height = 59
            HelpContext = 1130059
            DataField = 'ImmediateDetails'
            DataSource = dsCARAction
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object dtImmActionDate: TwwDBDateTimePicker
            Left = 446
            Top = 20
            Width = 116
            Height = 23
            HelpContext = 1130060
            AutoFillDateAndTime = True
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'ActionDate'
            DataSource = dsCARAction
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 2
          end
          object cboActionBy: TwwDBLookupCombo
            Left = 695
            Top = 20
            Width = 138
            Height = 23
            HelpContext = 1130061
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'EmployeeName'#9'30'#9'Employee Name'#9'F')
            DataField = 'Rep'
            DataSource = dsCARAction
            LookupTable = QryActionedBy
            LookupField = 'EmployeeName'
            DropDownWidth = 300
            ParentFont = False
            TabOrder = 3
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
          end
          object grdTransactions: TwwDBGrid
            Left = 1
            Top = 141
            Width = 984
            Height = 288
            HelpContext = 1130062
            Selected.Strings = (
              'ActionDate'#9'18'#9'Action Date'
              'ActionRequired'#9'30'#9'Action Required'
              'ImmediateDetails'#9'60'#9'Immediate Details'
              'Rep'#9'20'#9'Actioned By')
            MemoAttributes = [mSizeable, mWordWrap, mGridShow]
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alBottom
            DataSource = dsCARAction
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = True
            FooterColor = clWhite
            FooterCellColor = clWhite
            PaintOptions.BackgroundOptions = [coBlendFixedRow]
            object grdTransactionsIButton: TwwIButton
              Left = 0
              Top = 0
              Width = 13
              Height = 22
              HelpContext = 1130063
              AllowAllUp = True
              Glyph.Data = {
                26040000424D2604000000000000360000002800000012000000120000000100
                180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
                636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
                7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
                00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
                FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
                000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
                D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
                0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
                FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
                D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
                00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
                00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
                0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
                E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
                AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
                07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
                0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
                00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
                FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
                FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
                007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
                CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
                0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
                FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
                1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
                C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
                D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
                E0E3FFFFFFFFFFFF0000}
              OnClick = grdTransactionsIButtonClick
            end
          end
          object btnNewImmAction: TDNMSpeedButton
            Left = 855
            Top = 84
            Width = 114
            Height = 43
            HelpContext = 1130064
            Anchors = [akBottom]
            Caption = 'New Immediate Action'
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            TabStop = False
            WordWrap = True
            AutoDisableParentOnclick = True
            OnClick = btnNewImmActionClick
          end
        end
      end
      object tabMeasure: TTabSheet
        HelpContext = 1130065
        Caption = 'Prev. Measures'
        ImageIndex = 2
        object pnlMeasure: TDNMPanel
          Left = 0
          Top = 0
          Width = 986
          Height = 430
          HelpContext = 1130066
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            986
            430)
          object Label19: TLabel
            Left = 7
            Top = 55
            Width = 102
            Height = 15
            HelpContext = 1130067
            Caption = 'Preventive Details'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label22: TLabel
            Left = 12
            Top = 23
            Width = 132
            Height = 15
            HelpContext = 1130068
            Alignment = taRightJustify
            Caption = 'Prev. Action Comments'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label26: TLabel
            Left = 370
            Top = 24
            Width = 70
            Height = 15
            HelpContext = 1130069
            Alignment = taRightJustify
            Caption = 'Review Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label27: TLabel
            Left = 631
            Top = 24
            Width = 58
            Height = 15
            HelpContext = 1130070
            Alignment = taRightJustify
            Caption = 'Review By'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object grdPrevMeasures: TwwDBGrid
            Left = 1
            Top = 141
            Width = 984
            Height = 288
            HelpContext = 1130071
            Selected.Strings = (
              'ActionDate'#9'18'#9'Review Date'
              'PreventiveActioncomments'#9'20'#9'Preventive Action Comments'
              'PreventiveDetails'#9'70'#9'Preventive Details'
              'Rep'#9'20'#9'Reviewed By')
            MemoAttributes = [mSizeable, mWordWrap, mGridShow]
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alBottom
            DataSource = dsCARPrevMeasures
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = True
            FooterColor = clWhite
            FooterCellColor = clWhite
            PaintOptions.BackgroundOptions = [coBlendFixedRow]
            object grdPrevMeasuresIButton: TwwIButton
              Left = 0
              Top = 0
              Width = 13
              Height = 22
              HelpContext = 1130072
              AllowAllUp = True
              Glyph.Data = {
                26040000424D2604000000000000360000002800000012000000120000000100
                180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
                636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
                7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
                00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
                FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
                000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
                D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
                0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
                FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
                D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
                00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
                00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
                0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
                E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
                AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
                07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
                0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
                00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
                FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
                FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
                007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
                CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
                0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
                FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
                1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
                C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
                D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
                E0E3FFFFFFFFFFFF0000}
              OnClick = grdPrevMeasuresIButtonClick
            end
          end
          object DBMemo4: TDBMemo
            Left = 7
            Top = 76
            Width = 842
            Height = 59
            HelpContext = 1130073
            DataField = 'PreventiveDetails'
            DataSource = dsCARPrevMeasures
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object cboPreventiveAction: TwwDBLookupCombo
            Left = 150
            Top = 20
            Width = 189
            Height = 23
            HelpContext = 1130074
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ControlInfoInDataset = False
            DropDownAlignment = taLeftJustify
            DataField = 'PreventiveActioncomments'
            DataSource = dsCARPrevMeasures
            LookupTable = QryPreventiveActions
            LookupField = 'Name'
            AutoSelect = False
            DropDownWidth = 50
            MaxLength = 255
            ParentFont = False
            TabOrder = 2
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            ShowMatchText = True
            OnDblClick = cboPreventiveActionDblClick
            OnNotInList = cboPreventiveActionNotInList
          end
          object dtPrevMeasReviewDate: TwwDBDateTimePicker
            Left = 446
            Top = 20
            Width = 116
            Height = 23
            HelpContext = 1130075
            AutoFillDateAndTime = True
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'ActionDate'
            DataSource = dsCARPrevMeasures
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 3
          end
          object cboPreventiveACtionreviewBy: TwwDBLookupCombo
            Left = 695
            Top = 20
            Width = 138
            Height = 23
            HelpContext = 1130076
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'EmployeeName'#9'30'#9'Employee Name'#9'F')
            DataField = 'Rep'
            DataSource = dsCARPrevMeasures
            LookupTable = QryReviewedby
            LookupField = 'EmployeeName'
            DropDownWidth = 300
            ParentFont = False
            TabOrder = 4
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
          end
          object btnNewPrevMeasure: TDNMSpeedButton
            Left = 855
            Top = 84
            Width = 114
            Height = 43
            HelpContext = 1130077
            Anchors = [akBottom]
            Caption = 'New Preventive Measure'
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            TabStop = False
            WordWrap = True
            AutoDisableParentOnclick = True
            OnClick = btnNewPrevMeasureClick
          end
        end
      end
      object tabOutcome: TTabSheet
        HelpContext = 1130078
        Caption = 'Outcome Review'
        ImageIndex = 3
        object pnlOutcome: TDNMPanel
          Left = 0
          Top = 0
          Width = 986
          Height = 430
          HelpContext = 1130079
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            986
            430)
          object Label23: TLabel
            Left = 356
            Top = 24
            Width = 84
            Height = 15
            HelpContext = 1130080
            Alignment = taRightJustify
            Caption = 'Close Out Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label24: TLabel
            Left = 610
            Top = 24
            Width = 79
            Height = 15
            HelpContext = 1130081
            Alignment = taRightJustify
            Caption = 'Closed Out By'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label25: TLabel
            Left = 7
            Top = 55
            Width = 159
            Height = 15
            HelpContext = 1130082
            Caption = 'Action Close off or Outcome'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object dtOutcomeReviewDate: TwwDBDateTimePicker
            Left = 446
            Top = 20
            Width = 116
            Height = 23
            HelpContext = 1130083
            AutoFillDateAndTime = True
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'Closedouton'
            DataSource = dsCAROutcomeReview
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 0
          end
          object cboOutcomeReviewedBy: TwwDBLookupCombo
            Left = 695
            Top = 20
            Width = 138
            Height = 23
            HelpContext = 1130084
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'EmployeeName'#9'30'#9'Employee Name'#9'F')
            DataField = 'Rep'
            DataSource = dsCAROutcomeReview
            LookupTable = QryOutComeReviewBy
            LookupField = 'EmployeeName'
            DropDownWidth = 300
            ParentFont = False
            TabOrder = 1
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
          end
          object grdOutcomeReview: TwwDBGrid
            Left = 1
            Top = 141
            Width = 984
            Height = 288
            HelpContext = 1130085
            ControlType.Strings = (
              'Option1;CheckBox;T;F'
              'Option2;CheckBox;T;F'
              'Option3;CheckBox;T;F'
              'Option4;CheckBox;T;F'
              'Option5;CheckBox;T;F'
              'Option6;CheckBox;T;F'
              'Option7;CheckBox;T;F'
              'Option8;CheckBox;T;F'
              'Option9;CheckBox;T;F'
              'Option10;CheckBox;T;F')
            Selected.Strings = (
              'Closedouton'#9'18'#9'Close Out Date'#9#9
              'ActionorOutCome'#9'95'#9'Outcome'#9'F'
              'Rep'#9'20'#9'Closed Out By'#9#9)
            MemoAttributes = [mSizeable, mWordWrap, mGridShow]
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alBottom
            DataSource = dsCAROutcomeReview
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = True
            UseTFields = False
            FooterColor = clWhite
            FooterCellColor = clWhite
            PaintOptions.BackgroundOptions = [coBlendFixedRow]
            object grdOutcomeReviewIButton: TwwIButton
              Left = 0
              Top = 0
              Width = 13
              Height = 22
              HelpContext = 1130086
              AllowAllUp = True
              Glyph.Data = {
                26040000424D2604000000000000360000002800000012000000120000000100
                180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
                636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
                7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
                00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
                FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
                000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
                D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
                0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
                FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
                D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
                00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
                00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
                0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
                E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
                AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
                07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
                0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
                00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
                FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
                FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
                007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
                CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
                0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
                FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
                1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
                C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
                D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
                E0E3FFFFFFFFFFFF0000}
              OnClick = grdOutcomeReviewIButtonClick
            end
          end
          object DBMemo5: TDBMemo
            Left = 7
            Top = 76
            Width = 842
            Height = 59
            HelpContext = 1130087
            DataField = 'ActionorOutCome'
            DataSource = dsCAROutcomeReview
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object btnNewOutcomeReview: TDNMSpeedButton
            Left = 855
            Top = 84
            Width = 114
            Height = 43
            HelpContext = 1130088
            Anchors = [akBottom]
            Caption = 'New Outcome Review'
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            TabStop = False
            WordWrap = True
            AutoDisableParentOnclick = True
            OnClick = btnNewOutcomeReviewClick
          end
        end
      end
      object tabReview: TTabSheet
        HelpContext = 1130089
        Caption = 'Mgmt Review'
        ImageIndex = 4
        object pnlReview: TDNMPanel
          Left = 0
          Top = 0
          Width = 986
          Height = 430
          HelpContext = 1130090
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            986
            430)
          object Label35: TLabel
            Left = 7
            Top = 55
            Width = 183
            Height = 15
            HelpContext = 1130091
            Caption = 'Management Review Comments'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label36: TLabel
            Left = 332
            Top = 24
            Width = 108
            Height = 15
            HelpContext = 1130092
            Alignment = taRightJustify
            Caption = 'Mgmt. Review Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label37: TLabel
            Left = 593
            Top = 24
            Width = 96
            Height = 15
            HelpContext = 1130093
            Alignment = taRightJustify
            Caption = 'Mgmt. Review By'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object grdMgmtReview: TwwDBGrid
            Left = 1
            Top = 141
            Width = 984
            Height = 288
            HelpContext = 1130094
            Selected.Strings = (
              'Reviewdon'#9'12'#9'Mgmt. Reviewd on'
              'Rep'#9'20'#9'Mgmt. Reviewed By'
              'ReviewComments'#9'99'#9'Management Review Comments')
            MemoAttributes = [mSizeable, mWordWrap, mGridShow]
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alBottom
            DataSource = dsCARReview
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = True
            FooterColor = clWhite
            FooterCellColor = clWhite
            PaintOptions.BackgroundOptions = [coBlendFixedRow]
            object grdMgmtReviewIButton: TwwIButton
              Left = 0
              Top = 0
              Width = 13
              Height = 22
              HelpContext = 1130095
              AllowAllUp = True
              Glyph.Data = {
                26040000424D2604000000000000360000002800000012000000120000000100
                180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
                636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
                7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
                00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
                FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
                000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
                D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
                0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
                FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
                D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
                00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
                00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
                0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
                E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
                AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
                07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
                0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
                00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
                FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
                FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
                007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
                CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
                0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
                FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
                1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
                C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
                D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
                E0E3FFFFFFFFFFFF0000}
              OnClick = grdMgmtReviewIButtonClick
            end
          end
          object DBMemo6: TDBMemo
            Left = 7
            Top = 76
            Width = 842
            Height = 59
            HelpContext = 1130096
            DataField = 'ReviewComments'
            DataSource = dsCARReview
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object dtMgmtreviewDate: TwwDBDateTimePicker
            Left = 446
            Top = 20
            Width = 116
            Height = 23
            HelpContext = 1130097
            AutoFillDateAndTime = True
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            DataField = 'Reviewdon'
            DataSource = dsCARReview
            Epoch = 1950
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 2
          end
          object cboMgmtReviewdBy: TwwDBLookupCombo
            Left = 695
            Top = 20
            Width = 138
            Height = 23
            HelpContext = 1130098
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'EmployeeName'#9'30'#9'Employee Name'#9'F')
            DataField = 'Rep'
            DataSource = dsCARReview
            LookupTable = QryManagementReviewBy
            LookupField = 'EmployeeName'
            DropDownWidth = 300
            ParentFont = False
            TabOrder = 3
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
          end
          object btnNewMgmtReview: TDNMSpeedButton
            Left = 855
            Top = 84
            Width = 114
            Height = 43
            HelpContext = 1130099
            Anchors = [akBottom]
            Caption = 'New Management  Review'
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            TabStop = False
            WordWrap = True
            AutoDisableParentOnclick = True
            OnClick = btnNewMgmtReviewClick
          end
        end
      end
      object Custom_Fields: TTabSheet
        HelpContext = 1130100
        Caption = 'Outcome Review Options'
        ImageIndex = 5
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlcustomfieldList: TDNMPanel
          Left = 0
          Top = 0
          Width = 986
          Height = 430
          HelpContext = 1130101
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 515
    Width = 996
    Height = 50
    HelpContext = 1130102
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      996
      50)
    object LblChooseTemplate: TLabel
      Left = 877
      Top = 22
      Width = 98
      Height = 15
      HelpContext = 1130103
      Caption = 'Choose &Template'
      Transparent = True
    end
    object cmdok: TDNMSpeedButton
      Left = 218
      Top = 6
      Width = 93
      Height = 29
      HelpContext = 1130104
      Anchors = [akBottom]
      Caption = '&Save'
      Default = True
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = cmdokClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 679
      Top = 6
      Width = 93
      Height = 29
      HelpContext = 1130105
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
    object cmdPrint: TDNMSpeedButton
      Left = 525
      Top = 6
      Width = 93
      Height = 29
      Hint = '"Print The List"'
      HelpContext = 1130106
      Anchors = [akBottom]
      Caption = 'Prin&t'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdPrintClick
    end
    object ChkChooseRpt: TCheckBox
      Left = 860
      Top = 23
      Width = 14
      Height = 16
      HelpContext = 1130107
      TabOrder = 3
    end
    object cmdNew: TDNMSpeedButton
      Left = 371
      Top = 6
      Width = 93
      Height = 29
      Hint = '"Add A New Entry"'
      HelpContext = 1130108
      Anchors = [akBottom]
      Caption = '&New'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdNewClick
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 996
    Height = 50
    HelpContext = 1130004
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      996
      50)
    object Label38: TLabel
      Left = 925
      Top = 5
      Width = 63
      Height = 18
      HelpContext = 1130005
      AutoSize = False
      Caption = 'CAR No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object pnlTitle: TDNMPanel
      Left = 284
      Top = 4
      Width = 409
      Height = 39
      HelpContext = 1130006
      Anchors = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 407
        Height = 37
        HelpContext = 1130007
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
          Width = 407
          Height = 37
          HelpContext = 1130008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Corrective Action Reporting'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 2
        end
      end
    end
    object txtCustomID: TDBEdit
      Left = 925
      Top = 21
      Width = 63
      Height = 23
      Hint = 'Double Click For The Transaction Sequence List'
      HelpContext = 1130009
      DataField = 'ID'
      DataSource = dsCAR
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 565
    Top = 447
  end
  inherited tmrdelay: TTimer
    Left = 711
    Top = 447
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 602
    Top = 463
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 747
    Top = 447
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 784
    Top = 447
  end
  inherited DataState: TDataState
    Left = 638
    Top = 447
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 820
    Top = 447
  end
  inherited imgsort: TImageList
    Left = 675
    Top = 447
    Bitmap = {
      494C01010200F000000110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 529
    Top = 447
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 857
    Top = 447
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 888
    Top = 448
  end
  object qryCAR: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblCAR')
    OnCalcFields = qryCARCalcFields
    Left = 365
    Top = 447
    object qryCARID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblcar.ID'
    end
    object qryCARGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblcar.GlobalRef'
      Size = 255
    end
    object qryCARComplaintfromID: TIntegerField
      FieldName = 'ComplaintfromID'
      Origin = 'tblcar.ComplaintfromID'
    end
    object qryCARComplaintFrom: TWideStringField
      FieldName = 'ComplaintFrom'
      Origin = 'tblcar.ComplaintFrom'
      Size = 255
    end
    object qryCARContactID: TIntegerField
      FieldName = 'ContactID'
      Origin = 'tblcar.ContactID'
    end
    object qryCARcontactName: TWideStringField
      FieldName = 'contactName'
      Origin = 'tblcar.contactName'
      Size = 255
    end
    object qryCARComplaintType: TWideStringField
      FieldName = 'ComplaintType'
      Origin = 'tblcar.ComplaintType'
      Size = 255
    end
    object qryCARProductID: TIntegerField
      FieldName = 'ProductID'
      Origin = 'tblcar.ProductID'
    end
    object qryCARProductName: TWideStringField
      FieldName = 'ProductName'
      Origin = 'tblcar.ProductName'
      Size = 100
    end
    object qryCAREnteredByID: TIntegerField
      FieldName = 'EnteredByID'
      Origin = 'tblcar.EnteredByID'
    end
    object qryCAREnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Origin = 'tblcar.EnteredBy'
      Size = 100
    end
    object qryCARReportedDate: TDateTimeField
      FieldName = 'ReportedDate'
      Origin = 'tblcar.ReportedDate'
    end
    object qryCARSalesID: TIntegerField
      FieldName = 'SalesID'
      Origin = 'tblcar.SalesID'
    end
    object qryCARSalesLineID: TIntegerField
      FieldName = 'SalesLineID'
      Origin = 'tblcar.SalesLineID'
    end
    object qryCARProductionBuild: TWideStringField
      FieldName = 'ProductionBuild'
      Origin = 'tblcar.ProductionBuild'
      Size = 100
    end
    object qryCARProductionBuildDesc: TWideStringField
      FieldName = 'ProductionBuildDesc'
      Origin = 'tblcar.ProductionBuildDesc'
      Size = 255
    end
    object qryCARSupplierID: TIntegerField
      FieldName = 'SupplierID'
      Origin = 'tblcar.SupplierID'
    end
    object qryCARSupplierName: TWideStringField
      FieldName = 'SupplierName'
      Origin = 'tblcar.SupplierName'
      Size = 100
    end
    object qryCARPOID: TIntegerField
      FieldName = 'POID'
      Origin = 'tblcar.POID'
    end
    object qryCARPOLineID: TIntegerField
      FieldName = 'POLineID'
      Origin = 'tblcar.POLineID'
    end
    object qryCARDescriptionofProblem: TWideStringField
      FieldName = 'DescriptionofProblem'
      Origin = 'tblcar.DescriptionofProblem'
      Size = 255
    end
    object qryCARImprovementSuggestion: TWideStringField
      FieldName = 'ImprovementSuggestion'
      Origin = 'tblcar.ImprovementSuggestion'
      Size = 255
    end
    object qryCARRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblcar.RepID'
    end
    object qryCARRep: TWideStringField
      FieldName = 'Rep'
      Origin = 'tblcar.Rep'
      Size = 100
    end
    object qryCARmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
      Origin = 'tblcar.mstimestamp'
    end
    object qryCARmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblcar.msUpdateSiteCode'
      Size = 3
    end
    object qryCARsupcontactID: TIntegerField
      FieldName = 'supcontactID'
    end
    object qryCARsupcontactName: TWideStringField
      FieldName = 'supcontactName'
      Size = 255
    end
    object qryCARPARTSDESCRIPTION: TStringField
      FieldKind = fkCalculated
      FieldName = 'PARTSDESCRIPTION'
      Size = 100
      Calculated = True
    end
  end
  object dsCAR: TDataSource
    DataSet = qryCAR
    Left = 365
    Top = 475
  end
  object qryCARAction: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblCARAction')
    Left = 397
    Top = 447
    object qryCARActionActionDate: TDateTimeField
      DisplayLabel = 'Action Date'
      DisplayWidth = 18
      FieldName = 'ActionDate'
      Origin = 'tblcaraction.ActionDate'
    end
    object qryCARActionActionRequired: TWideStringField
      DisplayLabel = 'Action Required'
      DisplayWidth = 30
      FieldName = 'ActionRequired'
      Origin = 'tblcaraction.ActionRequired'
      Size = 255
    end
    object qryCARActionImmediateDetails: TWideStringField
      DisplayLabel = 'Immediate Details'
      DisplayWidth = 60
      FieldName = 'ImmediateDetails'
      Origin = 'tblcaraction.ImmediateDetails'
      Size = 255
    end
    object qryCARActionRep: TWideStringField
      DisplayLabel = 'Actioned By'
      DisplayWidth = 20
      FieldName = 'Rep'
      Origin = 'tblcaraction.Rep'
      Size = 100
    end
    object qryCARActionID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblcaraction.ID'
      Visible = False
    end
    object qryCARActionGlobalRef: TWideStringField
      DisplayWidth = 20
      FieldName = 'GlobalRef'
      Origin = 'tblcaraction.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryCARActionCARID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CARID'
      Origin = 'tblcaraction.CARID'
      Visible = False
    end
    object qryCARActionSeqno: TIntegerField
      DisplayWidth = 10
      FieldName = 'Seqno'
      Origin = 'tblcaraction.Seqno'
      Visible = False
    end
    object qryCARActionRepID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepID'
      Origin = 'tblcaraction.RepID'
      Visible = False
    end
    object qryCARActionmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblcaraction.msTimeStamp'
      Visible = False
    end
    object qryCARActionmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblcaraction.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsCARAction: TDataSource
    DataSet = qryCARAction
    Left = 397
    Top = 475
  end
  object QryCARPrevMeasures: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblCARPrevMeasures')
    Left = 429
    Top = 447
    object QryCARPrevMeasuresActionDate: TDateTimeField
      DisplayLabel = 'Review Date'
      DisplayWidth = 18
      FieldName = 'ActionDate'
      Origin = 'tblcarprevmeasures.ActionDate'
    end
    object QryCARPrevMeasuresPreventiveActioncomments: TWideStringField
      DisplayLabel = 'Preventive Action Comments'
      DisplayWidth = 20
      FieldName = 'PreventiveActioncomments'
      Origin = 'tblcarprevmeasures.PreventiveActioncomments'
      Size = 255
    end
    object QryCARPrevMeasuresPreventiveDetails: TWideStringField
      DisplayLabel = 'Preventive Details'
      DisplayWidth = 70
      FieldName = 'PreventiveDetails'
      Origin = 'tblcarprevmeasures.PreventiveDetails'
      Size = 255
    end
    object QryCARPrevMeasuresRep: TWideStringField
      DisplayLabel = 'Reviewed By'
      DisplayWidth = 20
      FieldName = 'Rep'
      Origin = 'tblcarprevmeasures.Rep'
      Size = 100
    end
    object QryCARPrevMeasuresID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblcarprevmeasures.ID'
      Visible = False
    end
    object QryCARPrevMeasuresGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblcarprevmeasures.GlobalRef'
      Visible = False
      Size = 255
    end
    object QryCARPrevMeasuresCARID: TIntegerField
      FieldName = 'CARID'
      Origin = 'tblcarprevmeasures.CARID'
      Visible = False
    end
    object QryCARPrevMeasuresSeqno: TIntegerField
      FieldName = 'Seqno'
      Origin = 'tblcarprevmeasures.Seqno'
      Visible = False
    end
    object QryCARPrevMeasuresRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblcarprevmeasures.RepID'
      Visible = False
    end
    object QryCARPrevMeasuresmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblcarprevmeasures.msTimeStamp'
      Visible = False
    end
    object QryCARPrevMeasuresmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblcarprevmeasures.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsCARPrevMeasures: TDataSource
    DataSet = QryCARPrevMeasures
    Left = 429
    Top = 475
  end
  object qryCAROutcomeReview: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblCAROutcomeReview')
    Left = 461
    Top = 447
    object qryCAROutcomeReviewActionorOutCome: TWideStringField
      DisplayLabel = 'Outcome'
      DisplayWidth = 20
      FieldName = 'ActionorOutCome'
      Origin = 'tblcaroutcomereview.ActionorOutCome'
      Size = 255
    end
    object qryCAROutcomeReviewRep: TWideStringField
      DisplayLabel = 'Closed Out By'
      DisplayWidth = 20
      FieldName = 'Rep'
      Origin = 'tblcaroutcomereview.Rep'
      Size = 100
    end
    object qryCAROutcomeReviewClosedouton: TDateTimeField
      DisplayLabel = 'Close Out Date'
      DisplayWidth = 18
      FieldName = 'Closedouton'
      Origin = 'tblcaroutcomereview.Closedouton'
    end
    object qryCAROutcomeReviewRepID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepID'
      Origin = 'tblcaroutcomereview.RepID'
    end
    object qryCAROutcomeReviewSeqno: TIntegerField
      DisplayWidth = 10
      FieldName = 'Seqno'
      Origin = 'tblcaroutcomereview.Seqno'
    end
    object qryCAROutcomeReviewID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblcaroutcomereview.ID'
      Visible = False
    end
    object qryCAROutcomeReviewGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblcaroutcomereview.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryCAROutcomeReviewCARID: TIntegerField
      FieldName = 'CARID'
      Origin = 'tblcaroutcomereview.CARID'
      Visible = False
    end
    object qryCAROutcomeReviewmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblcaroutcomereview.msTimeStamp'
      Visible = False
    end
    object qryCAROutcomeReviewmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblcaroutcomereview.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsCAROutcomeReview: TDataSource
    DataSet = qryCAROutcomeReview
    Left = 461
    Top = 475
  end
  object qryCARReview: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblCARReview')
    Left = 493
    Top = 447
    object qryCARReviewReviewdon: TDateTimeField
      DisplayLabel = 'Mgmt. Reviewd on'
      DisplayWidth = 12
      FieldName = 'Reviewdon'
      Origin = 'tblcarreview.Reviewdon'
    end
    object qryCARReviewRep: TWideStringField
      DisplayLabel = 'Mgmt. Reviewed By'
      DisplayWidth = 20
      FieldName = 'Rep'
      Origin = 'tblcarreview.Rep'
      Size = 100
    end
    object qryCARReviewReviewComments: TWideStringField
      DisplayLabel = 'Management Review Comments'
      DisplayWidth = 99
      FieldName = 'ReviewComments'
      Origin = 'tblcarreview.ReviewComments'
      Size = 255
    end
    object qryCARReviewID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblcarreview.ID'
      Visible = False
    end
    object qryCARReviewGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblcarreview.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryCARReviewCARID: TIntegerField
      FieldName = 'CARID'
      Origin = 'tblcarreview.CARID'
      Visible = False
    end
    object qryCARReviewSeqno: TIntegerField
      FieldName = 'Seqno'
      Origin = 'tblcarreview.Seqno'
      Visible = False
    end
    object qryCARReviewRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblcarreview.RepID'
      Visible = False
    end
    object qryCARReviewmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblcarreview.msTimeStamp'
      Visible = False
    end
    object qryCARReviewmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblcarreview.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsCARReview: TDataSource
    DataSet = qryCARReview
    Left = 493
    Top = 475
  end
  object QryProcessType: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'CAR Action type'#39
      'ORDER BY Name')
    Left = 286
    Top = 416
  end
  object cboProductQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'P.PARTSID as PARTSID,'
      'P.PARTNAME as PARTNAME,'
      'P.PARTSDESCRIPTION as PARTSDESCRIPTION'
      'FROM tblParts P'
      'WHERE P.Active = "T"')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 207
    Top = 450
    object cboProductQryPARTNAME: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 15
      FieldName = 'PARTNAME'
      Origin = 'tblParts.PARTNAME'
      Size = 60
    end
    object cboProductQryPARTSID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PARTSID'
      Origin = 'tblParts.PARTSID'
      Visible = False
    end
    object cboProductQryPARTSDESCRIPTION: TWideStringField
      FieldName = 'PARTSDESCRIPTION'
      Size = 255
    end
  end
  object QryRep: TERPQuery
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    Options.LongStrings = False
    Left = 286
    Top = 378
  end
  object qrycontacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select contactID, concat_WS('#39' '#39' , Contacttitle, contactfirstname' +
        ', contactsurname) as name  from tblcontacts where clientId = :Cl' +
        'ientID')
    BeforeOpen = qrycontactsBeforeOpen
    Left = 272
    Top = 448
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientID'
      end>
    object qrycontactscontactID: TIntegerField
      FieldName = 'contactID'
    end
    object qrycontactsname: TWideStringField
      FieldName = 'name'
      Size = 94
    end
  end
  object QryProductionbuild: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'CAR Productionbuild'#39
      'ORDER BY Name')
    Left = 318
    Top = 416
    object QryProductionbuildid: TIntegerField
      FieldName = 'id'
    end
    object QryProductionbuildTypecode: TWideStringField
      FieldName = 'Typecode'
      Size = 30
    end
    object QryProductionbuildname: TWideStringField
      FieldName = 'name'
    end
  end
  object QryActionRequired: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'CAR ActionRequired'#39
      'ORDER BY Name')
    Left = 350
    Top = 416
  end
  object QryPreventiveActions: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'CAR PreventiveActionComments'#39
      'ORDER BY Name')
    Left = 374
    Top = 416
  end
  object QryActionedBy: TERPQuery
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    Options.LongStrings = False
    Left = 318
    Top = 378
  end
  object QryReviewedby: TERPQuery
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    Options.LongStrings = False
    Left = 350
    Top = 378
  end
  object QryOutComeReviewBy: TERPQuery
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    Options.LongStrings = False
    Left = 382
    Top = 378
  end
  object QryManagementReviewBy: TERPQuery
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    Options.LongStrings = False
    Left = 414
    Top = 378
  end
  object dsProduct: TDataSource
    DataSet = cboProductQry
    Left = 205
    Top = 427
  end
  object QrySupcontact: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select contactID, concat_WS('#39' '#39' , Contacttitle, contactfirstname' +
        ', contactsurname) as name  from tblcontacts where clientId = :Cl' +
        'ientID')
    BeforeOpen = QrySupcontactBeforeOpen
    Left = 336
    Top = 448
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientID'
      end>
    object IntegerField2: TIntegerField
      FieldName = 'contactID'
    end
    object WideStringField2: TWideStringField
      FieldName = 'name'
      Size = 94
    end
  end
end
