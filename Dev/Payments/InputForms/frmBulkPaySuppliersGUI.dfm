inherited frmBulkPaySuppliers: TfrmBulkPaySuppliers
  Left = 298
  Top = 321
  HelpContext = 238000
  Caption = 'Bulk Pay Suppliers'
  ClientHeight = 558
  ClientWidth = 990
  OldCreateOrder = True
  ExplicitLeft = 298
  ExplicitTop = 321
  ExplicitWidth = 1006
  ExplicitHeight = 597
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 508
    Width = 990
    HelpContext = 238054
    ExplicitTop = 558
    ExplicitWidth = 990
  end
  inherited imgGridWatermark: TImage
    HelpContext = 238001
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 990
    Height = 508
    HelpContext = 238002
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = 0
      Width = 990
      Height = 44
      HelpContext = 238003
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        990
        44)
      object lblTo: TLabel
        Left = 876
        Top = 27
        Width = 13
        Height = 15
        HelpContext = 238004
        Anchors = [akTop, akRight]
        Caption = '&To'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblFrom: TLabel
        Left = 751
        Top = 27
        Width = 29
        Height = 15
        HelpContext = 238005
        Anchors = [akTop, akRight]
        Caption = '&From'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
      end
      object Label5: TLabel
        Left = 805
        Top = 4
        Width = 111
        Height = 15
        HelpContext = 238006
        Anchors = [akTop, akRight]
        Caption = 'Ignore Date Ranges'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object dtFrom: TwwDBDateTimePicker
        Left = 784
        Top = 25
        Width = 88
        Height = 21
        HelpContext = 238009
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        Date = 37432.000000000000000000
        Epoch = 1950
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MaxDate = 401769.000000000000000000
        MinDate = -363.000000000000000000
        ParentFont = False
        ShowButton = True
        TabOrder = 1
        UnboundDataType = wwDTEdtDate
        Visible = False
        OnChange = dtFromChange
        OnExit = dtFromExit
      end
      object dtTo: TwwDBDateTimePicker
        Left = 894
        Top = 25
        Width = 88
        Height = 20
        HelpContext = 238010
        TabStop = False
        Anchors = [akTop, akRight]
        AutoSize = False
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        Date = 37432.000000000000000000
        Epoch = 1950
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MaxDate = 401769.000000000000000000
        MinDate = -363.000000000000000000
        ParentFont = False
        ShowButton = True
        TabOrder = 2
        UnboundDataType = wwDTEdtDate
        OnChange = dtToChange
        OnExit = dtToExit
      end
      object IgnoreDates: TCheckBox
        Left = 785
        Top = 5
        Width = 14
        Height = 17
        HelpContext = 238011
        Anchors = [akTop, akRight]
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 0
        OnClick = IgnoreDatesClick
      end
      object pnlTitle: TDNMPanel
        Left = 352
        Top = 2
        Width = 292
        Height = 39
        HelpContext = 238014
        Anchors = [akLeft, akTop, akRight]
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
          Width = 288
          Height = 35
          HelpContext = 238015
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
            Width = 288
            Height = 35
            HelpContext = 238016
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Bulk Pay Suppliers'
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
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 44
      Width = 990
      Height = 118
      HelpContext = 238019
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        Left = 18
        Top = 33
        Width = 118
        Height = 15
        HelpContext = 238020
        Alignment = taRightJustify
        Caption = 'Total Amount to Pay :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 31
        Top = 63
        Width = 105
        Height = 15
        HelpContext = 238021
        Alignment = taRightJustify
        Caption = 'Selected Balance :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label3: TLabel
        Left = 35
        Top = 93
        Width = 101
        Height = 15
        HelpContext = 238022
        Alignment = taRightJustify
        Caption = 'Running Balance :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 377
        Top = 33
        Width = 119
        Height = 15
        HelpContext = 238023
        Alignment = taRightJustify
        Caption = 'Basis of Suggestion :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label81: TLabel
        Left = 286
        Top = 93
        Width = 210
        Height = 16
        HelpContext = 238024
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Override Pay From Bank Account :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object cboPayMethod_Label: TLabel
        Left = 392
        Top = 63
        Width = 104
        Height = 16
        HelpContext = 238025
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Payment Method'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label7: TLabel
        Left = 902
        Top = 96
        Width = 69
        Height = 18
        HelpContext = 238026
        AutoSize = False
        Caption = 'Add to E.F.T.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 670
        Top = 64
        Width = 17
        Height = 18
        HelpContext = 238027
        Alignment = taCenter
        AutoSize = False
        Caption = 'All'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label11: TLabel
        Left = 735
        Top = 46
        Width = 79
        Height = 15
        HelpContext = 238028
        Caption = 'Payment Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblClassTitle: TLabel
        Left = 98
        Top = 5
        Width = 38
        Height = 15
        HelpContext = 238007
        Alignment = taRightJustify
        Caption = 'Class :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 291
        Top = 5
        Width = 17
        Height = 18
        HelpContext = 238008
        Alignment = taCenter
        AutoSize = False
        Caption = 'All'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label12: TLabel
        Left = 291
        Top = 34
        Width = 48
        Height = 15
        HelpContext = 238055
        Alignment = taRightJustify
        Caption = 'Dbl click'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtAmtTendered: TEdit
        Left = 140
        Top = 30
        Width = 147
        Height = 23
        HelpContext = 238029
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '0.00'
        OnDblClick = edtAmtTenderedDblClick
        OnEnter = edtAmtTenderedEnter
        OnExit = edtAmtTenderedExit
        OnKeyPress = edtAmtTenderedKeyPress
      end
      object edtBalance: TEdit
        Left = 140
        Top = 60
        Width = 147
        Height = 23
        HelpContext = 238030
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
        Text = '0.00'
      end
      object edtRunningBalance: TEdit
        Left = 140
        Top = 90
        Width = 147
        Height = 23
        HelpContext = 238031
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
        Text = '0.00'
      end
      object cboBasis: TComboBox
        Left = 500
        Top = 30
        Width = 165
        Height = 23
        HelpContext = 238032
        AutoDropDown = True
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemIndex = 2
        ParentFont = False
        TabOrder = 1
        Text = 'Manual'
        OnCloseUp = cboBasisCloseUp
        Items.Strings = (
          'All Overdue'
          'Less than 30 Days'
          'Manual'
          'Over 30 Days'
          'Over 60 Days'
          'Over 90 Days'
          'Over 120 Days')
      end
      object cboAccount: TwwDBLookupCombo
        Left = 500
        Top = 90
        Width = 217
        Height = 23
        HelpContext = 238033
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'20'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        LookupTable = cboAccountQry
        LookupField = 'AccountID'
        Options = [loTitles]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 4
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        ShowMatchText = True
        OnCloseUp = cboAccountCloseUp
      end
      object cboPaymentMethod: TwwDBLookupCombo
        Left = 500
        Top = 60
        Width = 165
        Height = 23
        HelpContext = 238034
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taRightJustify
        Selected.Strings = (
          'Payment Method'#9'30'#9'Payment Method'#9'T')
        LookupTable = qryPayMethod
        LookupField = 'PayMethodID'
        Style = csDropDownList
        DropDownWidth = 150
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        ShowMatchText = True
        OnCloseUp = cboPaymentMethodCloseUp
      end
      object chkAddToEFT: TwwCheckBox
        Left = 885
        Top = 95
        Width = 14
        Height = 17
        HelpContext = 238035
        DisableThemes = False
        AlwaysTransparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ShowText = False
        TabOrder = 6
      end
      object edtBankBalance: TwwDBEdit
        Left = 734
        Top = 90
        Width = 121
        Height = 22
        HelpContext = 238036
        DataSource = dsAccountQry
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object chkAllPayments: TwwCheckBox
        Left = 688
        Top = 63
        Width = 12
        Height = 17
        HelpContext = 238037
        DisableThemes = False
        AlwaysTransparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'All'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ShowText = False
        State = cbChecked
        TabOrder = 3
        OnClick = chkAllPaymentsClick
      end
      object PaymentDate: TwwDBDateTimePicker
        Left = 735
        Top = 62
        Width = 88
        Height = 21
        HelpContext = 238038
        TabStop = False
        AutoSize = False
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        Date = 38899.000000000000000000
        Epoch = 1950
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MaxDate = 401769.000000000000000000
        MinDate = -363.000000000000000000
        ParentFont = False
        ShowButton = True
        TabOrder = 5
        UnboundDataType = wwDTEdtDate
        OnChange = PaymentDateChange
      end
      object cboClass: TwwDBLookupCombo
        Left = 140
        Top = 1
        Width = 149
        Height = 23
        HelpContext = 238012
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        LookupTable = cboClassQry
        LookupField = 'ClassName'
        Style = csDropDownList
        Enabled = False
        ParentFont = False
        TabOrder = 10
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboClassCloseUp
      end
      object chkAllClass: TwwCheckBox
        Left = 309
        Top = 4
        Width = 12
        Height = 17
        HelpContext = 238013
        DisableThemes = False
        AlwaysTransparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'All'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ShowText = False
        State = cbChecked
        TabOrder = 11
        OnClick = chkAllClassClick
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = 162
      Width = 990
      Height = 346
      HelpContext = 238039
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 990
        Height = 39
        HelpContext = 238040
        Align = alTop
        ExplicitLeft = 5
        ExplicitWidth = 981
      end
      object Label8: TLabel
        Left = 402
        Top = 11
        Width = 94
        Height = 16
        HelpContext = 238041
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Search Column :'
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
        Left = 763
        Top = 12
        Width = 47
        Height = 15
        HelpContext = 238042
        Alignment = taRightJustify
        Caption = 'Search :'
        Transparent = True
      end
      object cboFilter: TComboBox
        Left = 499
        Top = 8
        Width = 172
        Height = 23
        HelpContext = 238044
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object edtSearch: TEdit
        Left = 815
        Top = 8
        Width = 166
        Height = 23
        HelpContext = 238045
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnChange = edtSearchChange
      end
      object btnAddFilter: TDNMSpeedButton
        Left = 21
        Top = 7
        Width = 107
        Height = 25
        HelpContext = 238046
        Caption = '&Add To Filter'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33033333333333333F7F3333333333333000333333333333F777333333333333
          000333333333333F777333333333333000333333333333F77733333333333300
          033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
          33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
          3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
          33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
          333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
          333333773FF77333333333370007333333333333777333333333}
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = btnAddFilterClick
      end
      object btnExecute: TDNMSpeedButton
        Left = 132
        Top = 7
        Width = 107
        Height = 25
        HelpContext = 238047
        Caption = 'Execute Filter'
        DisableTransparent = False
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnExecuteClick
      end
      object btnClearFilter: TDNMSpeedButton
        Left = 243
        Top = 7
        Width = 107
        Height = 25
        HelpContext = 238048
        Caption = 'Clear &Filter'
        DisableTransparent = False
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
          555557777F777555F55500000000555055557777777755F75555005500055055
          555577F5777F57555555005550055555555577FF577F5FF55555500550050055
          5555577FF77577FF555555005050110555555577F757777FF555555505099910
          555555FF75777777FF555005550999910555577F5F77777775F5500505509990
          3055577F75F77777575F55005055090B030555775755777575755555555550B0
          B03055555F555757575755550555550B0B335555755555757555555555555550
          BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
          50BB555555555555575F555555555555550B5555555555555575}
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = btnClearFilterClick
      end
      object DNMPanel5: TDNMPanel
        Left = 0
        Top = 39
        Width = 990
        Height = 307
        HelpContext = 238049
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        object grdmain: TwwDBGrid
          Left = 1
          Top = 1
          Width = 988
          Height = 305
          HelpContext = 238050
          ControlType.Strings = (
            'Receipt;CheckBox;T;F'
            'Pay;CheckBox;T;F')
          Selected.Strings = (
            'SupplierName'#9'11'#9'Supplier~Name'#9'F'#9
            'Type'#9'8'#9'Type'#9#9
            'InvoiceNumber'#9'10'#9'Invoice~Number'#9#9
            'OrderDate'#9'10'#9'Order~Date'#9#9
            'DueDate'#9'10'#9'Due~Date'#9#9
            'AmountDue'#9'9'#9'Amount~Due'#9#9
            'TransAmount'#9'9'#9'Trans Amount'#9'F'#9
            'TransBalance'#9'9'#9'Trans Balance'#9'F'#9
            'TransPayment'#9'9'#9'Payment Done'#9'F'#9
            'Current'#9'9'#9'Current'#9#9
            '30Days'#9'9'#9'30 Days'#9#9
            '60Days'#9'9'#9'60 Days'#9#9
            '90Days'#9'9'#9'90 Days'#9#9
            '120Days'#9'9'#9'120 Days'#9#9
            'AmountToPay'#9'9'#9'Amount~To Pay'#9#9
            'Pay'#9'3'#9'Pay'#9#9
            'BalanceLeft'#9'10'#9'Balance~Left'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alClient
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = False
          OnCalcCellColors = grdmainCalcCellColors
          OnTitleButtonClick = grdmainTitleButtonClick
          OnColEnter = grdmainColEnter
          OnDblClick = grdmainDblClick
          OnCalcTitleImage = grdmainCalcTitleImage
          FooterColor = clWhite
        end
      end
    end
  end
  inherited pnlfooter: TDNMPanel
    Top = 508
    Width = 990
    HelpContext = 238060
    TabOrder = 1
    ExplicitTop = 508
    ExplicitWidth = 990
    inherited bbOK: TDNMSpeedButton
      Left = 213
      Top = 11
      HelpContext = 238017
      Action = actPay
      ExplicitLeft = 213
      ExplicitTop = 11
    end
    inherited btnSelectAll: TDNMSpeedButton
      Left = 332
      Top = 11
      OnClick = btnSelectAllClick
      ExplicitLeft = 332
      ExplicitTop = 11
    end
    inherited btnClear: TDNMSpeedButton
      Left = 451
      Top = 11
      OnClick = btnClearClick
      ExplicitLeft = 451
      ExplicitTop = 11
    end
    inherited btnPrint: TDNMSpeedButton
      Left = 570
      Top = 11
      OnClick = btnPrintClick
      ExplicitLeft = 570
      ExplicitTop = 11
    end
    inherited bbCancel: TDNMSpeedButton
      Left = 689
      Top = 11
      TabOrder = 5
      OnClick = bbCancelClick
      ExplicitLeft = 689
      ExplicitTop = 11
    end
    inherited pnlChooseRpt: TDNMPanel
      Top = 11
      HelpContext = 238061
      TabOrder = 4
      ExplicitTop = 11
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 598
    Top = 283
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 658
    Top = 283
  end
  inherited MyConnection: TERPConnection
    Left = 687
    Top = 283
  end
  inherited DataState: TDataState
    Left = 746
    Top = 282
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 40
    Top = 13
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020038007C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited dsMain: TDataSource
    Left = 692
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      
        '#SELECT tmp_tblaccountspayable.*,tblpurchaseorders.approved FROM' +
        ' tmp_tblaccountspayable'
      
        '#INNER JOIN tblpurchaseorders ON tmp_tblaccountspayable.PONumber' +
        '=tblpurchaseorders.purchaseorderID'
      '#WHERE AmountDue <> 0'
      '#AND approved="T"'
      ''
      'SELECT tmp_tblaccountspayable.* FROM tmp_tblaccountspayable'
      'WHERE AmountDue <> 0')
    AfterOpen = qryMainAfterOpen
    object qryMainSupplierName: TWideStringField
      DisplayLabel = 'Supplier~Name'
      DisplayWidth = 11
      FieldName = 'SupplierName'
      Origin = 'tmp_tblaccountspayable.SupplierName'
      ReadOnly = True
      Size = 255
    end
    object qryMainType: TWideStringField
      DisplayWidth = 8
      FieldName = 'Type'
      Origin = 'tmp_tblaccountspayable.Type'
      Size = 30
    end
    object qryMainInvoiceNumber: TWideStringField
      DisplayLabel = 'Invoice~Number'
      DisplayWidth = 10
      FieldName = 'InvoiceNumber'
      Origin = 'tmp_tblaccountspayable.InvoiceNumber'
      Size = 30
    end
    object qryMainOrderDate: TDateField
      DisplayLabel = 'Order~Date'
      DisplayWidth = 10
      FieldName = 'OrderDate'
      Origin = 'tmp_tblaccountspayable.OrderDate'
      ReadOnly = True
    end
    object qryMainDueDate: TDateField
      DisplayLabel = 'Due~Date'
      DisplayWidth = 10
      FieldName = 'DueDate'
      Origin = 'tmp_tblaccountspayable.DueDate'
      ReadOnly = True
    end
    object qryMainAmountDue: TFloatField
      DisplayLabel = 'Amount~Due'
      DisplayWidth = 9
      FieldName = 'AmountDue'
      Origin = 'tmp_tblaccountspayable.AmountDue'
      ReadOnly = True
      currency = True
    end
    object qryMainTransAmount: TFloatField
      DisplayLabel = 'Trans Amount'
      DisplayWidth = 9
      FieldName = 'TransAmount'
      Origin = 'TransAmount'
      ReadOnly = True
      currency = True
    end
    object qryMainTransBalance: TFloatField
      DisplayLabel = 'Trans Balance'
      DisplayWidth = 9
      FieldName = 'TransBalance'
      Origin = 'TransBalance'
      ReadOnly = True
      currency = True
    end
    object qryMainTransPayment: TFloatField
      DisplayLabel = 'Payment Done'
      DisplayWidth = 9
      FieldName = 'TransPayment'
      Origin = 'TransPayment'
      ReadOnly = True
      currency = True
    end
    object qryMainCurrent: TFloatField
      DisplayWidth = 9
      FieldName = 'Current'
      Origin = 'tmp_tblaccountspayable.Current'
      ReadOnly = True
      currency = True
    end
    object qryMainDSDesigner30Days: TFloatField
      DisplayLabel = '30 Days'
      DisplayWidth = 9
      FieldName = '30Days'
      Origin = 'tmp_tblaccountspayable.`30Days`'
      ReadOnly = True
      currency = True
    end
    object qryMainDSDesigner60Days: TFloatField
      DisplayLabel = '60 Days'
      DisplayWidth = 9
      FieldName = '60Days'
      Origin = 'tmp_tblaccountspayable.`60Days`'
      ReadOnly = True
      currency = True
    end
    object qryMainDSDesigner90Days: TFloatField
      DisplayLabel = '90 Days'
      DisplayWidth = 9
      FieldName = '90Days'
      Origin = 'tmp_tblaccountspayable.`90Days`'
      ReadOnly = True
      currency = True
    end
    object qryMainDSDesigner120Days: TFloatField
      DisplayLabel = '120 Days'
      DisplayWidth = 9
      FieldName = '120Days'
      Origin = 'tmp_tblaccountspayable.`120Days`'
      ReadOnly = True
      currency = True
    end
    object qryMainAmountToPay: TFloatField
      DisplayLabel = 'Amount~To Pay'
      DisplayWidth = 9
      FieldName = 'AmountToPay'
      Origin = 'tmp_tblaccountspayable.AmountToPay'
      OnChange = qryMainAmountToPayChange
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object qryMainPay: TWideStringField
      DisplayWidth = 3
      FieldName = 'Pay'
      Origin = 'tmp_tblaccountspayable.Pay'
      OnChange = qryMainPayChange
      FixedChar = True
      Size = 1
    end
    object qryMainBalanceLeft: TFloatField
      DisplayLabel = 'Balance~Left'
      DisplayWidth = 10
      FieldName = 'BalanceLeft'
      Origin = 'tmp_tblaccountspayable.BalanceLeft'
      currency = True
    end
    object qryMainInvoiceDate: TDateField
      DisplayLabel = 'Invoice~Date'
      DisplayWidth = 10
      FieldName = 'InvoiceDate'
      Origin = 'tmp_tblaccountspayable.InvoiceDate'
      Visible = False
    end
    object qryMainAccountName: TWideStringField
      DisplayWidth = 40
      FieldName = 'AccountName'
      Origin = 'tmp_tblaccountspayable.AccountName'
      Visible = False
      Size = 255
    end
    object qryMainClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tmp_tblaccountspayable.ClientID'
      Visible = False
    end
    object qryMainDetails: TIntegerField
      DisplayWidth = 10
      FieldName = 'Details'
      Origin = 'tmp_tblaccountspayable.Details'
      Visible = False
    end
    object qryMainEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tmp_tblaccountspayable.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'tmp_tblaccountspayable.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'ID'
      Origin = 'tmp_tblaccountspayable.ID'
      Visible = False
    end
    object qryMainName: TWideStringField
      DisplayWidth = 40
      FieldName = 'Name'
      Origin = 'tmp_tblaccountspayable.Name'
      Visible = False
      Size = 255
    end
    object qryMainOriginalAmount: TFloatField
      DisplayLabel = 'Orig Amt'
      DisplayWidth = 10
      FieldName = 'OriginalAmount'
      Origin = 'tmp_tblaccountspayable.OriginalAmount'
      Visible = False
    end
    object qryMainPONumber: TWideStringField
      DisplayWidth = 30
      FieldName = 'PONumber'
      Origin = 'tmp_tblaccountspayable.PONumber'
      Visible = False
      Size = 30
    end
    object qryMainPurchaseOrderID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PurchaseOrderID'
      Origin = 'tmp_tblaccountspayable.PurchaseOrderID'
      Visible = False
    end
    object qryMainTransID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TransID'
      Origin = 'tmp_tblaccountspayable.TransID'
      Visible = False
    end
    object qryMainmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tmp_tblaccountspayable.msTimeStamp'
      Visible = False
    end
    object qryMainAPNotes: TWideMemoField
      DisplayWidth = 10
      FieldName = 'APNotes'
      Origin = 'tmp_tblaccountspayable.APNotes'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryMainForeignExchangecode: TWideStringField
      DisplayWidth = 50
      FieldName = 'ForeignExchangecode'
      Origin = 'tmp_tblaccountspayable.ForeignExchangecode'
      Visible = False
      Size = 50
    end
    object qryMainForeignExchangeRate: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignExchangeRate'
      Origin = 'tmp_tblaccountspayable.ForeignExchangeRate'
      Visible = False
    end
  end
  object ActionManager1: TActionManager
    Left = 746
    Top = 312
    StyleName = 'Platform Default'
    object actPay: TAction
      Caption = '&Pay'
      HelpContext = 238056
      OnExecute = actPayExecute
      OnUpdate = actPayUpdate
    end
  end
  object cboAccountQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.* ,AccDesc as Type'
      'FROM tblChartofAccounts'
      'Left Join tblacctypedesc on  AccType = AccountType'
      'WHERE Active = '#39'T'#39' and IsHeader = '#39'F'#39
      'AND AccountType <> '#39'NONPOSTING'#39
      'Order By AccDesc,AccountName;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 656
    Top = 312
    object cboAccountQryGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblChartofAccounts.GlobalRef'
      Size = 255
    end
    object cboAccountQryAccountID: TIntegerField
      FieldName = 'AccountID'
      Origin = 'tblChartofAccounts.AccountID'
    end
    object cboAccountQryAccountName: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 20
      FieldName = 'AccountName'
      Origin = 'tblChartofAccounts.AccountName'
      Size = 50
    end
    object cboAccountQryAccountType: TWideStringField
      FieldName = 'AccountType'
      Origin = 'tblChartofAccounts.AccountType'
      Size = 50
    end
    object cboAccountQryBalance: TFloatField
      FieldName = 'Balance'
      Origin = 'tblChartofAccounts.Balance'
      DisplayFormat = ',#0.00'
      EditFormat = ',#0.00'
    end
    object cboAccountQryDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tblChartofAccounts.Description'
      Size = 150
    end
    object cboAccountQryAccountNumber: TWideStringField
      FieldName = 'AccountNumber'
      Origin = 'tblChartofAccounts.AccountNumber'
      Size = 50
    end
    object cboAccountQryTaxcode: TWideStringField
      FieldName = 'Taxcode'
      Origin = 'tblChartofAccounts.Taxcode'
      Size = 15
    end
    object cboAccountQryBankNumber: TWideStringField
      FieldName = 'BankNumber'
      Origin = 'tblChartofAccounts.BankNumber'
      Size = 50
    end
    object cboAccountQryExtra: TWideStringField
      FieldName = 'Extra'
      Origin = 'tblChartofAccounts.Extra'
      Size = 50
    end
    object cboAccountQryActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblChartofAccounts.Active'
      FixedChar = True
      Size = 1
    end
    object cboAccountQryEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblChartofAccounts.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object cboAccountQryClass: TWideStringField
      FieldName = 'Class'
      Origin = 'tblChartofAccounts.Class'
      Size = 255
    end
    object cboAccountQryAllClasses: TWideStringField
      FieldName = 'AllClasses'
      Origin = 'tblChartofAccounts.AllClasses'
      FixedChar = True
      Size = 1
    end
    object cboAccountQryOpeningBalance: TFloatField
      FieldName = 'OpeningBalance'
      Origin = 'tblChartofAccounts.OpeningBalance'
    end
    object cboAccountQryDebits: TFloatField
      FieldName = 'Debits'
      Origin = 'tblChartofAccounts.Debits'
    end
    object cboAccountQryCredits: TFloatField
      FieldName = 'Credits'
      Origin = 'tblChartofAccounts.Credits'
    end
    object cboAccountQryClosingBalance: TFloatField
      FieldName = 'ClosingBalance'
      Origin = 'tblChartofAccounts.ClosingBalance'
    end
    object cboAccountQryAccountGroup: TWideStringField
      FieldName = 'AccountGroup'
      Origin = 'tblChartofAccounts.AccountGroup'
      Size = 255
    end
    object cboAccountQryBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Origin = 'tblChartofAccounts.BankAccountName'
      Size = 255
    end
    object cboAccountQryLevel1: TWideStringField
      FieldName = 'Level1'
      Origin = 'tblChartofAccounts.Level1'
      Size = 255
    end
    object cboAccountQryLevel2: TWideStringField
      FieldName = 'Level2'
      Origin = 'tblChartofAccounts.Level2'
      Size = 255
    end
    object cboAccountQryLevel3: TWideStringField
      FieldName = 'Level3'
      Origin = 'tblChartofAccounts.Level3'
      Size = 255
    end
    object cboAccountQryLevel4: TWideStringField
      FieldName = 'Level4'
      Origin = 'tblChartofAccounts.Level4'
      Size = 255
    end
    object cboAccountQryRequired: TWideStringField
      FieldName = 'Required'
      Origin = 'tblChartofAccounts.Required'
      FixedChar = True
      Size = 1
    end
    object cboAccountQryBankCode: TWideStringField
      FieldName = 'BankCode'
      Origin = 'tblChartofAccounts.BankCode'
      FixedChar = True
      Size = 3
    end
    object cboAccountQryAPCANo: TWideStringField
      FieldName = 'APCANo'
      Origin = 'tblChartofAccounts.APCANo'
      Size = 6
    end
    object cboAccountQryBSB: TWideStringField
      FieldName = 'BSB'
      Origin = 'tblChartofAccounts.BSB'
      Size = 30
    end
    object cboAccountQryIncludeBalanceRecord: TWideStringField
      FieldName = 'IncludeBalanceRecord'
      Origin = 'tblChartofAccounts.IncludeBalanceRecord'
      FixedChar = True
      Size = 1
    end
    object cboAccountQryBankAccountNumber: TWideStringField
      FieldName = 'BankAccountNumber'
      Origin = 'tblChartofAccounts.BankAccountNumber'
      Size = 255
    end
    object cboAccountQryIncludeNetTotal: TWideStringField
      FieldName = 'IncludeNetTotal'
      Origin = 'tblChartofAccounts.IncludeNetTotal'
      FixedChar = True
      Size = 1
    end
    object cboAccountQryIncludeCreditTotal: TWideStringField
      FieldName = 'IncludeCreditTotal'
      Origin = 'tblChartofAccounts.IncludeCreditTotal'
      FixedChar = True
      Size = 1
    end
    object cboAccountQryIncludeDebitTotal: TWideStringField
      FieldName = 'IncludeDebitTotal'
      Origin = 'tblChartofAccounts.IncludeDebitTotal'
      FixedChar = True
      Size = 1
    end
    object cboAccountQryType: TWideStringField
      DisplayWidth = 20
      FieldName = 'Type'
      Origin = 'tblacctypedesc.AccDesc'
      Size = 255
    end
    object cboAccountQryLastChequeNo: TIntegerField
      FieldName = 'LastChequeNo'
      Origin = 'tblChartofAccounts.LastChequeNo'
    end
    object cboAccountQryUseLastChequeNo: TWideStringField
      FieldName = 'UseLastChequeNo'
      Origin = 'tblChartofAccounts.UseLastChequeNo'
      FixedChar = True
      Size = 1
    end
  end
  object qryPayMethod: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PayMethodID, Name as '#39'Payment Method'#39',IsCreditCard'
      'FROM tblpaymentmethods where Active ="T";')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 626
    Top = 312
  end
  object cboClassQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'ClassID, ClassName '
      'FROM tblClass '
      'WHERE Active='#39'T'#39' AND ClassName Is Not Null'
      'ORDER BY ClassName;')
    Left = 597
    Top = 312
  end
  object imgPopup: TImageList
    Left = 626
    Top = 341
    Bitmap = {
      494C010106003000740010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
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
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000FFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00000000000000000000FFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      000000000000000000000000000000000000000000007F7F7F000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000007F7F7F000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008080000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF0000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000080800000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000808000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000808000008080000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008080000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      00000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FDFF800000000000F8FF800000000000
      F8FFC00000000000F87FE00000000000F81FF00000000000F80FF80000000000
      F00FFC0000000000E00F060000000000E00F070000000000E00F018000000000
      F01F018000000000F00F006000000000F00FC06000000000F007C06000000000
      F007F04400000000F007F07E00000000FFFDFFFF847FE00FFFF8FFFF00EFE00F
      FFF1F9FF31BFE00FFFE3F0FF39FFF00FFFC7F0FF993FF00FE08FE07FCA1FF80F
      C01FC07FF40FF007803F843F9C07F007001F1E3F9603F007001FFE1FCB01F00F
      001FFF1FFF80F01F001FFF8FF7C0F81F001FFFC7FFE0FE1F803FFFE3EFF0FF1F
      C07FFFF8FFF8FF1FE0FFFFFFFFFCFFBF00000000000000000000000000000000
      000000000000}
  end
  object pumOptions: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 655
    Top = 341
    object AddtoFilter1: TMenuItem
      Caption = 'Add to Filter'
      HelpContext = 238057
      OnClick = btnAddFilterClick
    end
    object ExecuteFilter1: TMenuItem
      Caption = 'Execute Filter'
      Enabled = False
      HelpContext = 238058
      OnClick = btnExecuteClick
    end
    object ClearFilter1: TMenuItem
      Caption = 'Clear Filter'
      Enabled = False
      HelpContext = 238059
      OnClick = btnClearFilterClick
    end
  end
  object dsAccountQry: TDataSource
    DataSet = cboAccountQry
    Left = 656
    Top = 376
  end
  object kbmBinaryStreamFormat: TkbmBinaryStreamFormat
    Version = '3.00'
    sfUsingIndex = [sfSaveUsingIndex]
    sfData = [sfSaveData, sfLoadData]
    sfCalculated = []
    sfLookup = []
    sfNonVisible = [sfSaveNonVisible, sfLoadNonVisible]
    sfBlobs = [sfSaveBlobs, sfLoadBlobs]
    sfDef = [sfSaveDef, sfLoadDef]
    sfIndexDef = [sfSaveIndexDef, sfLoadIndexDef]
    sfFiltered = [sfSaveFiltered]
    sfIgnoreRange = [sfSaveIgnoreRange]
    sfIgnoreMasterDetail = [sfSaveIgnoreMasterDetail]
    sfDeltas = []
    sfDontFilterDeltas = []
    sfAppend = []
    sfFieldKind = [sfSaveFieldKind]
    sfFromStart = [sfLoadFromStart]
    sfDataTypeHeader = [sfSaveDataTypeHeader, sfLoadDataTypeHeader]
    sfDisplayWidth = []
    BufferSize = 16384
    Left = 714
    Top = 244
  end
end
