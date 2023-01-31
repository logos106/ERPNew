inherited frmBulkReceiveCustomersGUI: TfrmBulkReceiveCustomersGUI
  Left = 377
  Top = 87
  HelpContext = 239000
  Caption = 'Received Bulk Payments'
  ClientHeight = 558
  ClientWidth = 998
  OldCreateOrder = True
  ExplicitLeft = 377
  ExplicitTop = 87
  ExplicitWidth = 1014
  ExplicitHeight = 597
  DesignSize = (
    998
    558)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 508
    Width = 998
    HelpContext = 239046
    ExplicitTop = 558
    ExplicitWidth = 998
  end
  inherited imgGridWatermark: TImage
    HelpContext = 239001
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 998
    Height = 508
    HelpContext = 239002
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
      Width = 998
      Height = 42
      HelpContext = 239003
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
        998
        42)
      object lblTo: TLabel
        Left = 885
        Top = 23
        Width = 13
        Height = 15
        HelpContext = 239004
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
        Left = 759
        Top = 23
        Width = 29
        Height = 15
        HelpContext = 239005
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
      end
      object Label5: TLabel
        Left = 813
        Top = 3
        Width = 111
        Height = 15
        HelpContext = 239006
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
        Left = 792
        Top = 21
        Width = 88
        Height = 21
        HelpContext = 239009
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
      end
      object dtTo: TwwDBDateTimePicker
        Left = 903
        Top = 21
        Width = 88
        Height = 21
        HelpContext = 239010
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
      end
      object IgnoreDates: TCheckBox
        Left = 793
        Top = 2
        Width = 14
        Height = 17
        HelpContext = 239011
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
        Left = 332
        Top = 1
        Width = 412
        Height = 38
        HelpContext = 239014
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
          Width = 408
          Height = 34
          HelpContext = 239015
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
            Width = 408
            Height = 34
            HelpContext = 239016
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Received Bulk Payments'
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
      Top = 42
      Width = 998
      Height = 122
      HelpContext = 239019
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
        Left = 3
        Top = 35
        Width = 135
        Height = 15
        HelpContext = 239020
        Alignment = taRightJustify
        Caption = 'Total Amount Received :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 33
        Top = 65
        Width = 105
        Height = 15
        HelpContext = 239021
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
        Left = 37
        Top = 96
        Width = 101
        Height = 15
        HelpContext = 239022
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
        Left = 379
        Top = 35
        Width = 119
        Height = 15
        HelpContext = 239023
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
      object cboPayMethod_Label: TLabel
        Left = 346
        Top = 65
        Width = 152
        Height = 16
        HelpContext = 239024
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Receive Payment Method :'
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
        Left = 359
        Top = 97
        Width = 139
        Height = 15
        HelpContext = 239025
        Alignment = taRightJustify
        Caption = 'Receive Payment Class :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 694
        Top = 98
        Width = 79
        Height = 15
        HelpContext = 239026
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
        Left = 100
        Top = 6
        Width = 38
        Height = 15
        HelpContext = 239007
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
        Left = 289
        Top = 6
        Width = 19
        Height = 18
        HelpContext = 239008
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
      object edtAmtTendered: TEdit
        Left = 140
        Top = 32
        Width = 147
        Height = 23
        HelpContext = 239027
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '0.00'
        OnEnter = edtAmtTenderedEnter
        OnExit = edtAmtTenderedExit
        OnKeyPress = edtAmtTenderedKeyPress
      end
      object edtBalance: TEdit
        Left = 140
        Top = 62
        Width = 147
        Height = 23
        HelpContext = 239028
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        Text = '0.00'
      end
      object edtRunningBalance: TEdit
        Left = 140
        Top = 93
        Width = 147
        Height = 23
        HelpContext = 239029
        TabStop = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        Text = '0.00'
      end
      object cboBasis: TComboBox
        Left = 500
        Top = 32
        Width = 165
        Height = 23
        HelpContext = 239030
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
          'All Current'
          'All Overdue'
          'Manual'
          'Over 1-30 Days'
          'Over 30 Days'
          'Over 60 Days'
          'Over 90 Days')
      end
      object cboPaymentMethod: TwwDBLookupCombo
        Left = 500
        Top = 62
        Width = 165
        Height = 23
        HelpContext = 239031
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
      end
      object cboReceiveClass: TwwDBLookupCombo
        Left = 500
        Top = 93
        Width = 165
        Height = 23
        HelpContext = 239032
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        LookupTable = qryClass
        LookupField = 'ClassName'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 5
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object PaymentDate: TwwDBDateTimePicker
        Left = 783
        Top = 94
        Width = 88
        Height = 21
        HelpContext = 239033
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
        TabOrder = 6
        UnboundDataType = wwDTEdtDate
        OnChange = PaymentDateChange
      end
      object cboClass: TwwDBLookupCombo
        Left = 140
        Top = 2
        Width = 147
        Height = 23
        HelpContext = 239012
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
        TabOrder = 7
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboClassCloseUp
      end
      object chkAllClass: TwwCheckBox
        Left = 306
        Top = 5
        Width = 12
        Height = 17
        HelpContext = 239013
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
        TabOrder = 8
        OnClick = chkAllClassClick
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = 164
      Width = 998
      Height = 344
      HelpContext = 239034
      Align = alTop
      Anchors = [akLeft, akTop, akRight, akBottom]
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
        Width = 998
        Height = 39
        HelpContext = 239035
        Align = alTop
        ExplicitLeft = -1
      end
      object Label8: TLabel
        Left = 404
        Top = 12
        Width = 94
        Height = 16
        HelpContext = 239036
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
        Left = 770
        Top = 13
        Width = 47
        Height = 15
        HelpContext = 239037
        Alignment = taRightJustify
        Caption = 'Search :'
        Transparent = True
      end
      object cboFilter: TComboBox
        Left = 500
        Top = 9
        Width = 166
        Height = 23
        HelpContext = 239039
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
        Left = 820
        Top = 9
        Width = 164
        Height = 23
        HelpContext = 239040
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
        Left = 22
        Top = 7
        Width = 107
        Height = 25
        HelpContext = 239041
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
        HelpContext = 239042
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
        Left = 242
        Top = 7
        Width = 107
        Height = 25
        HelpContext = 239043
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
        Width = 998
        Height = 305
        HelpContext = 239044
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
          Width = 996
          Height = 303
          HelpContext = 239045
          ControlType.Strings = (
            'Receipt;CheckBox;T;F')
          Selected.Strings = (
            'CustomerName'#9'12'#9'Customer~Name'#9'F'#9
            'JobName'#9'11'#9'Job~Name'#9#9
            'Type'#9'8'#9'Type'#9#9
            'SaleDate'#9'10'#9'Sale~Date'#9#9
            'InvoiceNumber'#9'8'#9'Invoice~Number'#9#9
            'DueDate'#9'10'#9'Due~Date'#9#9
            'AmountDue'#9'9'#9'Amount~Due'#9#9
            'Current'#9'9'#9'Current'#9#9
            '1-30Days'#9'9'#9'1-30Days'#9#9
            '30-60Days'#9'9'#9'30-60Days'#9#9
            '60-90Days'#9'9'#9'60-90Days'#9#9
            'Receipt'#9'1'#9'Rcpt'#9#9
            'AmountToPay'#9'9'#9'Paid'#9#9
            'BalanceLeft'#9'9'#9'Balance'#9'T'#9)
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
    Width = 998
    HelpContext = 239047
    TabOrder = 1
    ExplicitTop = 508
    ExplicitWidth = 998
    inherited bbOK: TDNMSpeedButton
      Left = 184
      Top = 6
      HelpContext = 239017
      Action = actPay
      Caption = '&Apply'
      ExplicitLeft = 184
      ExplicitTop = 6
    end
    inherited btnSelectAll: TDNMSpeedButton
      Left = 319
      Top = 11
      HelpContext = 239047
      OnClick = btnSelectAllClick
      ExplicitLeft = 319
      ExplicitTop = 11
    end
    inherited btnClear: TDNMSpeedButton
      Left = 455
      Top = 11
      HelpContext = 239046
      OnClick = btnClearClick
      ExplicitLeft = 455
      ExplicitTop = 11
    end
    inherited btnPrint: TDNMSpeedButton
      Left = 591
      Top = 11
      HelpContext = 239048
      TabOrder = 4
      OnClick = btnPrintClick
      ExplicitLeft = 591
      ExplicitTop = 11
    end
    inherited bbCancel: TDNMSpeedButton
      Left = 727
      Top = 11
      HelpContext = 239018
      TabOrder = 3
      OnClick = bbCancelClick
      ExplicitLeft = 727
      ExplicitTop = 11
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 598
    Top = 283
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 657
    Top = 283
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited DataState: TDataState
    Left = 746
    Top = 283
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 40
    Top = 3
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102002800600010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited qryMain: TERPQuery
    AfterOpen = qryMainAfterOpen
    object qryMainCustomerName: TWideStringField
      DisplayLabel = 'Customer~Name'
      DisplayWidth = 12
      FieldName = 'CustomerName'
      Origin = 'A.CustomerName'
      ReadOnly = True
      Size = 255
    end
    object qryMainJobName: TWideStringField
      DisplayLabel = 'Job~Name'
      DisplayWidth = 11
      FieldName = 'JobName'
      Origin = 'B.JobName'
      ReadOnly = True
      Size = 39
    end
    object qryMainType: TWideStringField
      DisplayWidth = 8
      FieldName = 'Type'
      Origin = 'A.Type'
      ReadOnly = True
      Size = 30
    end
    object qryMainSaleDate: TDateField
      DisplayLabel = 'Sale~Date'
      DisplayWidth = 10
      FieldName = 'SaleDate'
      Origin = 'A.SaleDate'
      ReadOnly = True
    end
    object qryMainInvoiceNumber: TWideStringField
      DisplayLabel = 'Invoice~Number'
      DisplayWidth = 8
      FieldName = 'InvoiceNumber'
      Origin = 'A.InvoiceNumber'
      ReadOnly = True
      Size = 30
    end
    object qryMainDueDate: TDateField
      DisplayLabel = 'Due~Date'
      DisplayWidth = 10
      FieldName = 'DueDate'
      Origin = 'A.DueDate'
      ReadOnly = True
    end
    object qryMainAmountDue: TFloatField
      DisplayLabel = 'Amount~Due'
      DisplayWidth = 9
      FieldName = 'AmountDue'
      Origin = 'A.AmountDue'
      ReadOnly = True
      currency = True
    end
    object qryMainCurrent: TFloatField
      DisplayWidth = 9
      FieldName = 'Current'
      Origin = 'A.Current'
      ReadOnly = True
    end
    object qryMainDSDesigner130Days: TFloatField
      DisplayWidth = 9
      FieldName = '1-30Days'
      Origin = 'A.1-30Days'
      ReadOnly = True
      currency = True
    end
    object qryMainDSDesigner3060Days: TFloatField
      DisplayWidth = 9
      FieldName = '30-60Days'
      Origin = 'A.30-60Days'
      ReadOnly = True
      currency = True
    end
    object qryMainDSDesigner6090Days: TFloatField
      DisplayWidth = 9
      FieldName = '60-90Days'
      Origin = 'A.60-90Days'
      ReadOnly = True
      currency = True
    end
    object qryMainReceipt: TWideStringField
      DisplayLabel = 'Rcpt'
      DisplayWidth = 1
      FieldName = 'Receipt'
      Origin = 'A.Receipt'
      OnChange = qryMainReceiptChange
      FixedChar = True
      Size = 1
    end
    object qryMainAmountToPay: TFloatField
      DisplayLabel = 'Paid'
      DisplayWidth = 9
      FieldName = 'AmountToPay'
      Origin = 'A.AmountToPay'
      OnChange = qryMainAmountToPayChange
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object qryMainBalanceLeft: TFloatField
      DisplayLabel = 'Balance'
      DisplayWidth = 9
      FieldName = 'BalanceLeft'
      Origin = 'A.BalanceLeft'
      currency = True
    end
    object qryMainCustomerType: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'CustomerType'
      Origin = 'A.CustomerType'
      ReadOnly = True
      Visible = False
      Size = 255
    end
    object qryMainName: TWideStringField
      DisplayWidth = 40
      FieldName = 'Name'
      Origin = 'A.Name'
      ReadOnly = True
      Visible = False
      Size = 255
    end
    object qryMainTransactionName: TWideStringField
      DisplayWidth = 40
      FieldName = 'TransactionName'
      Origin = 'A.TransactionName'
      ReadOnly = True
      Visible = False
      Size = 255
    end
    object qryMainOriginalAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'OriginalAmount'
      Origin = 'A.OriginalAmount'
      Visible = False
      currency = True
    end
    object qryMainDSDesigner17Days: TFloatField
      DisplayWidth = 10
      FieldName = '1-7Days'
      Origin = 'A.1-7Days'
      Visible = False
      currency = True
    end
    object qryMainDSDesigner714Days: TFloatField
      DisplayWidth = 10
      FieldName = '7-14Days'
      Origin = 'A.7-14Days'
      Visible = False
      currency = True
    end
    object qryMainDSDesigner1421Days: TFloatField
      DisplayWidth = 10
      FieldName = '14-21Days'
      Origin = 'A.14-21Days'
      Visible = False
      currency = True
    end
    object qryMainDSDesigner21Days: TFloatField
      DisplayWidth = 10
      FieldName = '>21Days'
      Origin = 'A.>21Days'
      Visible = False
      currency = True
    end
    object qryMainDSDesigner90Days: TFloatField
      DisplayWidth = 10
      FieldName = '>90Days'
      Origin = 'A.>90Days'
      Visible = False
      currency = True
    end
    object qryMainSaleID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID'
      Origin = 'A.SaleID'
      Visible = False
    end
    object qryMainClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'A.ClientID'
      Visible = False
    end
    object qryMainTransID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TransID'
      Origin = 'A.TransID'
      Visible = False
    end
    object qryMainClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Origin = 'A.ClassID'
      Visible = False
    end
    object qryMainAccountName: TWideStringField
      DisplayWidth = 40
      FieldName = 'AccountName'
      Origin = 'A.AccountName'
      ReadOnly = True
      Visible = False
      Size = 255
    end
    object qryMainParentClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ParentClientID'
      Origin = 'A.ParentClientID'
      Visible = False
    end
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'A.ID'
      Visible = False
    end
    object qryMainCompany: TWideStringField
      DisplayWidth = 80
      FieldName = 'Company'
      Origin = 'B.Company'
      ReadOnly = True
      Visible = False
      Size = 80
    end
    object qryMainForeignExchangecode: TWideStringField
      DisplayWidth = 50
      FieldName = 'ForeignExchangecode'
      Origin = 'A.ForeignExchangecode'
      Visible = False
      Size = 50
    end
    object qryMainForeignExchangeRate: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignExchangeRate'
      Origin = 'A.ForeignExchangeRate'
      Visible = False
    end
  end
  object ActionManager1: TActionManager
    Left = 745
    Top = 311
    StyleName = 'Platform Default'
    object actPay: TAction
      Caption = '&Pay'
      HelpContext = 239048
      OnExecute = actPayExecute
      OnUpdate = actPayUpdate
    end
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
  object qryPayMethod: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PayMethodID, Name as '#39'Payment Method'#39',IsCreditCard'
      'FROM tblpaymentmethods where Active ="T";')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 627
    Top = 312
  end
  object qryClass: TERPQuery
    SQL.Strings = (
      'SELECT '
      'ClassID, ClassName '
      'FROM tblClass '
      'WHERE Active='#39'T'#39' AND ClassName Is Not Null'
      'ORDER BY ClassName;')
    Left = 597
    Top = 341
  end
  object imgPopup: TImageList
    Left = 626
    Top = 341
    Bitmap = {
      494C0101060024005C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 656
    Top = 312
    object AddtoFilter1: TMenuItem
      Caption = 'Add to Filter'
      HelpContext = 239049
      OnClick = btnAddFilterClick
    end
    object ExecuteFilter1: TMenuItem
      Caption = 'Execute Filter'
      Enabled = False
      HelpContext = 239050
      OnClick = btnExecuteClick
    end
    object ClearFilter1: TMenuItem
      Caption = 'Clear Filter'
      Enabled = False
      HelpContext = 239051
      OnClick = btnClearFilterClick
    end
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
    Left = 717
    Top = 252
  end
end
