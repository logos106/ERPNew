inherited PaymentsPrefsGUI: TPaymentsPrefsGUI
  Left = 100
  Top = 100
  HelpContext = 411000
  VertScrollBar.Tracking = True
  Caption = 'Payments Preferences'
  ClientHeight = 861
  ClientWidth = 1084
  OldCreateOrder = True
  ExplicitTop = 2
  ExplicitWidth = 1100
  ExplicitHeight = 900
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 861
    Width = 1084
    HelpContext = 411056
    ExplicitTop = 913
    ExplicitWidth = 905
  end
  object lblWidth: TLabel [1]
    Left = 15
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 411001
    Caption = 
      'All panels should have a width of 545.  Panel TabOrder is used f' +
      'or panel placement sequence.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited sbpanels: TAdvScrollBox
    Width = 1084
    Height = 861
    HelpContext = 411083
    VertScrollBar.Position = 55
    ExplicitWidth = 1084
    ExplicitHeight = 861
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = -55
      Width = 1065
      Height = 105
      HelpContext = 411011
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 91
        HelpContext = 411012
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 9
      end
      object Label4: TLabel
        Left = 14
        Top = 14
        Width = 203
        Height = 15
        HelpContext = 411013
        Caption = 'Default Payment Variation Accounts'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label5: TLabel
        Left = 24
        Top = 40
        Width = 56
        Height = 15
        HelpContext = 411014
        Caption = 'Customer'
        Transparent = True
      end
      object Label6: TLabel
        Left = 200
        Top = 40
        Width = 47
        Height = 15
        HelpContext = 411015
        Caption = 'Supplier'
        Transparent = True
      end
      object wwDBLookupCombo4: TwwDBLookupCombo
        Left = 24
        Top = 56
        Width = 144
        Height = 23
        HelpContext = 411016
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'CustomerPaymentsDefaultVariationAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount2
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo5: TwwDBLookupCombo
        Left = 200
        Top = 56
        Width = 144
        Height = 23
        HelpContext = 411017
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'SupplierPaymentsDefaultVariationAccountID'
        DataSource = dsPrefs
        LookupTable = qryAccount2
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = 50
      Width = 1065
      Height = 140
      HelpContext = 411002
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 126
        HelpContext = 411003
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 4
        ExplicitTop = 5
        ExplicitWidth = 537
        ExplicitHeight = 132
      end
      object Label8: TLabel
        Left = 14
        Top = 14
        Width = 150
        Height = 15
        HelpContext = 411004
        Caption = 'Default Payment Accounts'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 24
        Top = 40
        Width = 56
        Height = 15
        HelpContext = 411005
        Caption = 'Customer'
        Transparent = True
      end
      object Label1: TLabel
        Left = 200
        Top = 40
        Width = 47
        Height = 15
        HelpContext = 411006
        Caption = 'Supplier'
        Transparent = True
      end
      object Label3: TLabel
        Left = 376
        Top = 40
        Width = 64
        Height = 15
        HelpContext = 411007
        Caption = 'Credit Card'
        Transparent = True
      end
      object wwDBLookupCombo1: TwwDBLookupCombo
        Left = 24
        Top = 56
        Width = 144
        Height = 23
        HelpContext = 411008
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'DefaultCustPaymentAccount'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo2: TwwDBLookupCombo
        Left = 200
        Top = 56
        Width = 144
        Height = 23
        HelpContext = 411009
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'DefaultSuppPaymentAccount'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 1
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo3: TwwDBLookupCombo
        Left = 376
        Top = 56
        Width = 144
        Height = 23
        HelpContext = 411010
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'DefaultCCardPaymentAccount'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object btnTenderAccounts: TDNMSpeedButton
        Left = 24
        Top = 97
        Width = 163
        Height = 25
        HelpContext = 411071
        Caption = 'Auto Deposit Accounts'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = btnTenderAccountsClick
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 190
      Width = 1065
      Height = 209
      HelpContext = 411018
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 195
        HelpContext = 411019
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 529
        ExplicitHeight = 193
      end
      object Label7: TLabel
        Left = 14
        Top = 14
        Width = 121
        Height = 15
        HelpContext = 411020
        Caption = 'Statement Messages'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblIgnore: TLabel
        Left = 216
        Top = 24
        Width = 226
        Height = 15
        HelpContext = 411021
        Caption = 'Leave blank to assign previous message'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object grpOverdueDays: TwwRadioGroup
        Left = 24
        Top = 37
        Width = 177
        Height = 145
        HelpContext = 411022
        DisableThemes = False
        ItemIndex = 0
        TransparentActiveItem = True
        Transparent = True
        Caption = 'Days Outstanding'
        Columns = 2
        Items.Strings = (
          ' OK'
          ' > 1'
          ' > 7'
          ' > 14'
          ' > 21'
          ' > 30'
          ' > 60'
          ' > 90')
        TabOrder = 0
        OnClick = grpOverdueDaysClick
      end
      object edtOverdueMsg: TDBMemo
        Left = 216
        Top = 48
        Width = 305
        Height = 137
        HelpContext = 411023
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = 1018
      Width = 1065
      Height = 548
      HelpContext = 411024
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 534
        HelpContext = 411025
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 4
        ExplicitWidth = 529
        ExplicitHeight = 390
      end
      object Label9: TLabel
        Left = 14
        Top = 14
        Width = 44
        Height = 15
        HelpContext = 411026
        Caption = 'General'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 24
        Top = 201
        Width = 93
        Height = 15
        HelpContext = 411027
        Caption = 'Deposit Account'
        Transparent = True
      end
      object Label11: TLabel
        Left = 184
        Top = 201
        Width = 93
        Height = 15
        HelpContext = 411028
        Caption = 'Cheque Account'
        Transparent = True
      end
      object Label12: TLabel
        Left = 24
        Top = 253
        Width = 213
        Height = 15
        HelpContext = 411057
        Caption = 'Begin Customer Payments at Number'
        Transparent = True
      end
      object Label13: TLabel
        Left = 24
        Top = 285
        Width = 204
        Height = 15
        HelpContext = 411058
        Caption = 'Begin Supplier Payments at Number'
        Transparent = True
      end
      object Label14: TLabel
        Left = 24
        Top = 321
        Width = 362
        Height = 15
        HelpContext = 411060
        Caption = 'Cheque Template - Maximum No of Lines can be printed in Detail'
        Transparent = True
      end
      object Label15: TLabel
        Left = 137
        Top = 333
        Width = 136
        Height = 14
        HelpContext = 411061
        Caption = '( 0 if all lines can be printed)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object wwDBLookupCombo6: TwwDBLookupCombo
        Left = 24
        Top = 217
        Width = 144
        Height = 23
        HelpContext = 411041
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'DefaultDepositsAccount'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 4
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwDBLookupCombo7: TwwDBLookupCombo
        Left = 184
        Top = 217
        Width = 144
        Height = 23
        HelpContext = 411042
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'30'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        DataField = 'DefaultChequeAccount'
        DataSource = dsPrefs
        LookupTable = qryAccount
        LookupField = 'AccountID'
        ParentFont = False
        TabOrder = 5
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object wwCheckBox3: TwwCheckBox
        Left = 24
        Top = 175
        Width = 333
        Height = 17
        HelpContext = 411045
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Accounts Receivable - Group Jobs with Customer'
        DataField = 'GroupJobsOnAccountsReceivable'
        DataSource = dsPrefs
        TabOrder = 1
      end
      object wwCheckBox5: TwwCheckBox
        Left = 24
        Top = 72
        Width = 333
        Height = 17
        HelpContext = 411046
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Auto Select Deposits'
        DataField = 'AutoApplyDeposits'
        DataSource = dsPersonalPreferences
        TabOrder = 0
      end
      object wwCheckBox6: TwwCheckBox
        Left = 24
        Top = 356
        Width = 333
        Height = 17
        HelpContext = 411049
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Auto Cheque Numbers'
        DataField = 'UseAutoChequeNo'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object wwCheckBox7: TwwCheckBox
        Left = 24
        Top = 38
        Width = 333
        Height = 17
        HelpContext = 411050
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Group POS Deposits (Cash Sales)'
        DataField = 'UseGroupedPOSDeposits'
        DataSource = dsPrefs
        TabOrder = 3
      end
      object wwCheckBox8: TwwCheckBox
        Left = 24
        Top = 106
        Width = 333
        Height = 17
        HelpContext = 411052
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Cheque and Payments Add to E.F.T. by default'
        Checked = True
        DataField = 'PaymentsAddToEFT'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 6
      end
      object edtCustPaymentsStartNo: TAdvEdit
        Left = 248
        Top = 249
        Width = 97
        Height = 23
        HelpContext = 411062
        EditType = etNumeric
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 12
        ParentFont = False
        TabOrder = 7
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object edtSuppPaymentsStartNo: TAdvEdit
        Left = 248
        Top = 281
        Width = 97
        Height = 23
        HelpContext = 411063
        EditType = etNumeric
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 12
        ParentFont = False
        TabOrder = 8
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object wwCheckBox1: TwwCheckBox
        Left = 24
        Top = 140
        Width = 333
        Height = 17
        HelpContext = 411064
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Default to Customer'#39's Class In Payments'
        Checked = True
        DataField = 'DefaultCustomerClassInPayments'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 9
      end
      object wwDBEdit1: TwwDBEdit
        Left = 395
        Top = 317
        Width = 57
        Height = 23
        HelpContext = 411065
        DataField = 'chequeTemplate_NoofLinesinDetailSection'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
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
      object grdlastchequeno: TwwDBGrid
        Left = 384
        Top = 76
        Width = 403
        Height = 134
        HelpContext = 411084
        Selected.Strings = (
          'accountname'#9'20'#9'Account~Name'#9#9
          'Type'#9'20'#9'Type'#9#9
          'ChequeLastNumber'#9'10'#9'Cheque~Number'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        DataSource = dschequeNos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
        ParentFont = False
        TabOrder = 11
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 2
        TitleButtons = False
        Visible = False
        OnCalcCellColors = grdlastchequenoCalcCellColors
        FooterColor = clWhite
        GroupFieldName = 'Accountname'
      end
      object rgCustEarlyPaymentAction: TwwRadioGroup
        Left = 25
        Top = 388
        Width = 432
        Height = 55
        HelpContext = 411085
        DisableThemes = False
        Caption = 'Customer Early Payment Discount Action'
        Columns = 2
        Items.Strings = (
          'Add Discount to Sale'
          'Create Refund Amount')
        TabOrder = 12
      end
      object rgSuppEarlyPaymentAction: TwwRadioGroup
        Left = 25
        Top = 460
        Width = 432
        Height = 55
        HelpContext = 411086
        DisableThemes = False
        Caption = 'Supplier Early Payment Discount Action'
        Columns = 2
        Items.Strings = (
          'Add Discount to Order'
          'Create Credit Amount')
        TabOrder = 13
      end
    end
    object pnlapprovals: TDNMPanel
      Left = 0
      Top = 747
      Width = 1065
      Height = 271
      HelpContext = 411066
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 257
        HelpContext = 411067
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 6
      end
      object Approvals: TLabel
        Left = 14
        Top = 14
        Width = 57
        Height = 15
        HelpContext = 411068
        Caption = 'Approvals'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label24: TLabel
        Left = 26
        Top = 123
        Width = 79
        Height = 15
        HelpContext = 411005
        Caption = 'Approval Type'
        Transparent = True
      end
      object optApprovaltype: TwwRadioGroup
        Left = 111
        Top = 52
        Width = 161
        Height = 148
        HelpContext = 411022
        DisableThemes = False
        ItemIndex = 0
        TransparentActiveItem = True
        Transparent = True
        Items.Strings = (
          'Self Approval'
          'Single User Approval'
          'Stepped Level Approval')
        TabOrder = 4
        OnClick = optApprovaltypeClick
      end
      object memApprovaltype: TMemo
        Left = 272
        Top = 77
        Width = 221
        Height = 106
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Lines.Strings = (
          '(Logged In User Can Approve,'
          ' if he has Rights To)'
          ''
          '(Any one can Choose the Approver,'
          'Who has Rights To)'
          ''
          '(All Approvers will have to Approve )')
        ParentColor = True
        ParentFont = False
        TabOrder = 5
        WordWrap = False
      end
      object wwCheckBox2: TwwCheckBox
        Left = 24
        Top = 200
        Width = 416
        Height = 17
        HelpContext = 411070
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Only Approved Transactions in Supplier Payment'
        DataField = 'POOnlyApprovedTransInSuppPayment'
        DataSource = dsPrefs
        TabOrder = 2
      end
      object btnERPLink: TDNMSpeedButton
        Left = 24
        Top = 227
        Width = 207
        Height = 27
        HelpContext = 411087
        Caption = 'Configure ERP Link / API'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = btnERPLinkClick
      end
      object btnFaxSetup: TDNMSpeedButton
        Left = 175
        Top = 36
        Width = 143
        Height = 27
        HelpContext = 411055
        Caption = 'Approval Levels'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnApprovalLevelsClick
      end
      object chkUseApprovalLevels: TwwCheckBox
        Left = 24
        Top = 40
        Width = 144
        Height = 17
        HelpContext = 411054
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Use Approval Levels '
        DataField = 'UseApprovalLevels'
        DataSource = dsPrefs
        TabOrder = 0
      end
    end
    object DNMPanel6: TDNMPanel
      Left = 0
      Top = 399
      Width = 1065
      Height = 116
      HelpContext = 411072
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object Bevel6: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 102
        HelpContext = 411073
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 8
        ExplicitWidth = 531
      end
      object Label16: TLabel
        Left = 14
        Top = 14
        Width = 197
        Height = 15
        HelpContext = 411074
        Caption = 'Surcharges for Overdue Payments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label17: TLabel
        Left = 28
        Top = 47
        Width = 65
        Height = 15
        HelpContext = 411075
        Alignment = taRightJustify
        Caption = ' 1 - 30 Days'
        Transparent = True
      end
      object Label18: TLabel
        Left = 162
        Top = 47
        Width = 72
        Height = 15
        HelpContext = 411076
        Alignment = taRightJustify
        Caption = '30 - 60  Days'
        Transparent = True
      end
      object Label19: TLabel
        Left = 296
        Top = 47
        Width = 72
        Height = 15
        HelpContext = 411077
        Alignment = taRightJustify
        Caption = '60 - 90  Days'
        Transparent = True
      end
      object Label20: TLabel
        Left = 430
        Top = 47
        Width = 58
        Height = 15
        HelpContext = 411078
        Alignment = taRightJustify
        Caption = '> 90  Days'
        Transparent = True
      end
      object wwDBEdit2: TwwDBEdit
        Left = 28
        Top = 68
        Width = 103
        Height = 23
        HelpContext = 411079
        DataField = 'SurchargePercent1'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Picture.AllowInvalidExit = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit3: TwwDBEdit
        Left = 162
        Top = 68
        Width = 103
        Height = 23
        HelpContext = 411080
        DataField = 'SurchargePercent2'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Picture.AllowInvalidExit = True
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit4: TwwDBEdit
        Left = 296
        Top = 68
        Width = 103
        Height = 23
        HelpContext = 411081
        DataField = 'SurchargePercent3'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Picture.AllowInvalidExit = True
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit5: TwwDBEdit
        Left = 430
        Top = 68
        Width = 103
        Height = 23
        HelpContext = 411082
        DataField = 'SurchargePercent4'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Picture.AllowInvalidExit = True
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object DNMPanel7: TDNMPanel
      Left = 0
      Top = 515
      Width = 1065
      Height = 116
      HelpContext = 411088
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object Bevel7: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 102
        HelpContext = 411089
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 8
        ExplicitWidth = 531
      end
      object Label21: TLabel
        Left = 14
        Top = 14
        Width = 59
        Height = 15
        HelpContext = 411090
        Caption = 'Templates'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label22: TLabel
        Left = 24
        Top = 56
        Width = 228
        Height = 15
        HelpContext = 411091
        Alignment = taRightJustify
        Caption = 'Blank Lines in Supplier Payment Cheque'
        Transparent = True
      end
      object wwDBEdit6: TwwDBEdit
        Left = 266
        Top = 52
        Width = 103
        Height = 23
        HelpContext = 411092
        DataField = 'BlankLinesinSuppPaymentCheque'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Picture.AllowInvalidExit = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object pnlBankReconciliation: TDNMPanel
      Left = 0
      Top = 631
      Width = 1065
      Height = 116
      HelpContext = 411093
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object Bevel8: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 102
        HelpContext = 411094
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 8
        ExplicitWidth = 531
      end
      object Label23: TLabel
        Left = 14
        Top = 14
        Width = 112
        Height = 15
        HelpContext = 411095
        Caption = 'Bank Reconciliation'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox4: TwwCheckBox
        Left = 35
        Top = 51
        Width = 342
        Height = 17
        HelpContext = 411096
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Enable Bank Statement Transaction Import'
        Checked = True
        DataField = 'UseBankStatements'
        DataSource = dsPrefs
        State = cbChecked
        TabOrder = 0
      end
    end
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'Localhost'
    LoginPrompt = False
    Left = 592
    Top = 48
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'BlankLinesinSuppPaymentCheque'
      'chequeTemplate_NoofLinesinDetailSection'
      'CustEarlyPaymentAction'
      'CustomerPaymentsDefaultVariationAccountID'
      'DefaultCCardPaymentAccount'
      'DefaultChequeAccount'
      'DefaultCustomerClassInPayments'
      'DefaultCustPaymentAccount'
      'DefaultDepositsAccount'
      'DefaultSuppPaymentAccount'
      'GroupJobsOnAccountsReceivable'
      'ODue14Days'
      'ODue1Days'
      'ODue21Days'
      'ODue30Days'
      'ODue60Days'
      'ODue7Days'
      'ODue90Days'
      'ODueOk'
      'PaymentsAddToEFT'
      'POOnlyApprovedTransInSuppPayment'
      'SuppEarlyPaymentAction'
      'SupplierPaymentsDefaultVariationAccountID'
      'SurchargePercent1'
      'SurchargePercent2'
      'SurchargePercent3'
      'SurchargePercent4'
      'UseApprovalLevels'
      'UseAutoChequeNo'
      'UseBankStatements'
      'UseGroupedPOSDeposits')
    Left = 624
    Top = 48
  end
  object qryAccount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 656
    Top = 48
  end
  object qryAccount2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc AS Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc ON AccType = AccountType'
      
        'WHERE IsHeader = '#39'F'#39' AND (AccountType = '#39'EXP'#39' OR AccountType = '#39 +
        'EXEXP'#39') AND Active = '#39'T'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 688
    Top = 48
  end
  object dsPersonalPreferences: TDataSource
    DataSet = qryPersonalPreferences
    Left = 720
    Top = 48
  end
  object qryPersonalPreferences: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblpersonalpreferences'
      'WHERE EmployeeID = :EmployeeID;')
    Left = 752
    Top = 48
    ParamData = <
      item
        DataType = ftString
        Name = 'EmployeeID'
        Value = ''
      end>
  end
  object QrychequeNos: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT 1 as typecode, '#39'Last Cheque'#39' Type, Account accountname, M' +
        'ax(TRUNCATE(InvoiceNumber,0)) as ChequeLastNumber FROM tblpurcha' +
        'seorders PO  WHERE IsCheque="T" AND cancelled="F" group by Accou' +
        'nt union all '
      
        'SELECT 2 as typecode, '#39'Last Payments'#39' Type, COA.AccountName acco' +
        'untname, Max(TRUNCATE(ReferenceNo,0)) as ChequeLastNumber FROM t' +
        'blwithdrawal W inner join tblpaymentmethods PM on PM.PayMethodID' +
        ' = W.PayMethodID and PM.NAME ='#39'Cheque'#39' inner join tblchartofacco' +
        'unts COA on W.AccountID = COA.AccountID union all '
      
        'SELECT 3 as typeCode, "Last Prepayment" Type, AccountName as acc' +
        'ountname,Max(TRUNCATE(ReferenceNo,0)) as ChequeLastNumber FROM t' +
        'blprepayments  PP inner join tblpaymentmethods PM on PM.PayMetho' +
        'dID = PP.PayMethodID and PM.NAME ="Cheque" inner join tblchartof' +
        'accounts COA on PP.bankaccountId  = COA.AccountID  where Supplie' +
        'r="T"  union all '
      
        'Select 4 as Typecode, "    Next Cheque Number" , Accountname , m' +
        'ax(ChequeLastNumber) +1 from '
      
        '(SELECT '#39'Cheque'#39' Type, Account accountname, Max(TRUNCATE(Invoice' +
        'Number,0)) as ChequeLastNumber FROM tblpurchaseorders PO  WHERE ' +
        'IsCheque="T" AND cancelled="F" group by Account union all '
      
        'SELECT '#39'Cheque Payments'#39' Type, COA.AccountName accountname, Max(' +
        'TRUNCATE(ReferenceNo,0)) as ChequeLastNumber FROM tblwithdrawal ' +
        'W inner join tblpaymentmethods PM on PM.PayMethodID = W.PayMetho' +
        'dID and PM.NAME ='#39'Cheque'#39' inner join tblchartofaccounts COA on W' +
        '.AccountID = COA.AccountID union all '
      
        'SELECT "Supplier cheque Prepayment" Type, AccountName as account' +
        'name,Max(TRUNCATE(ReferenceNo,0)) as ChequeLastNumber FROM tblpr' +
        'epayments  PP inner join tblpaymentmethods PM on PM.PayMethodID ' +
        '= PP.PayMethodID and PM.NAME ="Cheque" inner join tblchartofacco' +
        'unts COA on PP.bankaccountId  = COA.AccountID  where Supplier="T' +
        '" '
      ') Details group by accountname'
      'Order by accountname , typecode')
    Filtered = True
    Filter = 'Accountname <> ""'
    Left = 686
    Top = 81
  end
  object dschequeNos: TDataSource
    DataSet = QrychequeNos
    Left = 654
    Top = 81
  end
end
