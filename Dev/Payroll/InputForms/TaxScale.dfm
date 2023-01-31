inherited TaxScaleForm: TTaxScaleForm
  Left = -15
  Top = 427
  HelpContext = 523000
  Caption = 'Tax Scale'
  ClientHeight = 683
  ClientWidth = 496
  OldCreateOrder = True
  ExplicitLeft = -15
  ExplicitTop = 427
  ExplicitWidth = 512
  ExplicitHeight = 722
  DesignSize = (
    496
    683)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 15
    Top = 70
    Width = 465
    Height = 300
    HelpContext = 523002
    Shape = bsFrame
  end
  object Label2: TLabel [1]
    Left = 199
    Top = 85
    Width = 75
    Height = 15
    HelpContext = 523003
    Caption = 'Last Updated'
    Transparent = True
  end
  object Label1: TLabel [2]
    Left = 74
    Top = 84
    Width = 103
    Height = 15
    HelpContext = 523004
    Caption = 'Tax Scale Number'
    Transparent = True
  end
  object Label3: TLabel [3]
    Left = 75
    Top = 132
    Width = 65
    Height = 15
    HelpContext = 523005
    Caption = 'Description'
    Transparent = True
  end
  object Label4: TLabel [4]
    Left = 448
    Top = 627
    Width = 35
    Height = 15
    HelpContext = 523006
    Caption = 'Active'
    Transparent = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 683
    Width = 496
    HelpContext = 523016
    ExplicitTop = 417
    ExplicitWidth = 496
  end
  inherited imgGridWatermark: TImage
    HelpContext = 523001
  end
  object Label5: TLabel [10]
    Left = 348
    Top = 84
    Width = 56
    Height = 15
    HelpContext = 523017
    Caption = 'Maximum'
    Transparent = True
  end
  object Label7: TLabel [11]
    Left = 30
    Top = 462
    Width = 37
    Height = 15
    Caption = 'Option'
  end
  object Label8: TLabel [12]
    Left = 30
    Top = 492
    Width = 183
    Height = 15
    Caption = 'Study and Training Support Loan'
  end
  object Label9: TLabel [13]
    Left = 30
    Top = 522
    Width = 145
    Height = 15
    Caption = 'Medicare Levy Surcharge'
  end
  object Label10: TLabel [14]
    Left = 30
    Top = 552
    Width = 152
    Height = 15
    Caption = 'Medicare Levy Excemption'
  end
  object Label11: TLabel [15]
    Left = 30
    Top = 582
    Width = 142
    Height = 15
    Caption = 'Medicare Levy Reduction'
  end
  object Bevel2: TBevel [16]
    Left = 15
    Top = 385
    Width = 465
    Height = 236
    Shape = bsFrame
  end
  object Label6: TLabel [17]
    Left = 30
    Top = 432
    Width = 51
    Height = 15
    Caption = 'Category'
  end
  object Label12: TLabel [18]
    Left = 230
    Top = 432
    Width = 7
    Height = 15
    Caption = '1'
  end
  object Label13: TLabel [19]
    Left = 230
    Top = 552
    Width = 7
    Height = 15
    Caption = '5'
  end
  object Label14: TLabel [20]
    Left = 230
    Top = 582
    Width = 7
    Height = 15
    Caption = '6'
  end
  object Label15: TLabel [21]
    Left = 230
    Top = 462
    Width = 7
    Height = 15
    Caption = '2'
  end
  object Label16: TLabel [22]
    Left = 230
    Top = 492
    Width = 7
    Height = 15
    Caption = '3'
  end
  object Label17: TLabel [23]
    Left = 230
    Top = 522
    Width = 7
    Height = 15
    Caption = '4'
  end
  object Label18: TLabel [24]
    Left = 30
    Top = 402
    Width = 159
    Height = 15
    Caption = 'Must Select Category 1 First'
  end
  object dtpLastUpdated: TwwDBDateTimePicker [25]
    Left = 198
    Top = 103
    Width = 121
    Height = 23
    HelpContext = 523011
    TabStop = False
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'LastUpdated'
    DataSource = DSTaxScales
    Epoch = 1950
    ShowButton = True
    TabOrder = 2
  end
  object pnlTitle: TDNMPanel [26]
    Left = 146
    Top = 10
    Width = 175
    Height = 50
    HelpContext = 523012
    Caption = 'Tax Scale'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 14221420
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object chkActive: TwwCheckBox [27]
    Left = 457
    Top = 642
    Width = 17
    Height = 17
    HelpContext = 523013
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
    Caption = 'chkActive'
    DataField = 'Active'
    DataSource = DSTaxScales
    TabOrder = 8
  end
  object grdThreshold: TwwDBGrid [28]
    Left = 75
    Top = 181
    Width = 350
    Height = 171
    HelpContext = 523014
    Selected.Strings = (
      'Threshold'#9'19'#9'Threshold'#9'F'#9
      'A'#9'10'#9'Multiplier'#9'F'#9
      'B'#9'12'#9'Subtract'#9'F'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = DSTax
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgProportionalColResize]
    TabOrder = 4
    TitleAlignment = taCenter
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = True
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
    object wwDBGrid1IButton: TwwIButton
      Left = 0
      Top = -2
      Width = 23
      Height = 25
      HelpContext = 523018
      AllowAllUp = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033337733333333333333333F333333333333
        0000333911733333973333333377F333333F3333000033391117333911733333
        37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
        911117111117333337F3337F733337F3000033333911111111733333337F3337
        3333F7330000333333911111173333333337F333333F73330000333333311111
        7333333333337F3333373333000033333339111173333333333337F333733333
        00003333339111117333333333333733337F3333000033333911171117333333
        33337333337F333300003333911173911173333333373337F337F33300003333
        9117333911173333337F33737F337F33000033333913333391113333337FF733
        37F337F300003333333333333919333333377333337FFF730000333333333333
        3333333333333333333777330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      Transparent = False
      Visible = False
    end
  end
  object cmdOK: TDNMSpeedButton [29]
    Left = 84
    Top = 632
    Width = 87
    Height = 27
    HelpContext = 523015
    Anchors = [akTop, akRight]
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 5
    AutoDisableParentOnclick = True
    OnClick = cmdOKClick
  end
  object cmdNew: TDNMSpeedButton [30]
    Left = 212
    Top = 632
    Width = 87
    Height = 27
    HelpContext = 523008
    Anchors = [akTop, akRight]
    Caption = '&New'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    AutoDisableParentOnclick = True
    OnClick = cmdNewClick
  end
  object cmdCancel: TDNMSpeedButton [31]
    Left = 340
    Top = 632
    Width = 87
    Height = 27
    HelpContext = 523007
    Anchors = [akTop, akRight]
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 7
    AutoDisableParentOnclick = True
    OnClick = cmdCancelClick
  end
  object ScaleDesc: TwwDBEdit [32]
    Left = 75
    Top = 152
    Width = 350
    Height = 23
    HelpContext = 523009
    DataField = 'ScaleDescription'
    DataSource = DSTaxScales
    TabOrder = 3
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtScale: TwwDBEdit [33]
    Left = 75
    Top = 103
    Width = 76
    Height = 23
    HelpContext = 523010
    DataField = 'ScaleID'
    DataSource = DSTaxScales
    TabOrder = 0
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtMaximum: TwwDBEdit [34]
    Left = 349
    Top = 103
    Width = 76
    Height = 23
    Hint = 'Maximum amount per annum tax cut off point'
    HelpContext = 523019
    DataField = 'Maximum'
    DataSource = DSTaxScales
    TabOrder = 9
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cboCategory: TwwDBComboBox [35]
    Left = 250
    Top = 432
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DataField = 'TT_Category'
    DataSource = DSTaxScales
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9
      'Actors'#9'A'
      'ATO-Defined'#9'D'
      'Foreign Resident'#9'F'
      'Horticulturists and Shearers'#9'C'
      'No TFN'#9'N'
      'Regular'#9'R'
      'Seasonal Worker Programme'#9'W'
      'Seniors and Pensioners'#9'S'
      'Voluntary Agreement'#9'V'
      'Working Holiday Makers'#9'H')
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 10
    UnboundDataType = wwDefault
    OnChange = cboCategoryChange
  end
  object cboOption: TwwDBComboBox [36]
    Left = 250
    Top = 463
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DataField = 'TT_Option'
    DataSource = DSTaxScales
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9)
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 11
    UnboundDataType = wwDefault
    OnChange = cboOptionChange
  end
  object cboSTSL: TwwDBComboBox [37]
    Left = 250
    Top = 492
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DataField = 'TT_STSL'
    DataSource = DSTaxScales
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9)
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 12
    UnboundDataType = wwDefault
  end
  object cboMLS: TwwDBComboBox [38]
    Left = 250
    Top = 522
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DataField = 'TT_MLS'
    DataSource = DSTaxScales
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9)
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 13
    UnboundDataType = wwDefault
  end
  object cboMLE: TwwDBComboBox [39]
    Left = 250
    Top = 552
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DataField = 'TT_MLE'
    DataSource = DSTaxScales
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9)
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 14
    UnboundDataType = wwDefault
  end
  object cboMLR: TwwDBComboBox [40]
    Left = 250
    Top = 582
    Width = 220
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DataField = 'TT_MLR'
    DataSource = DSTaxScales
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      '[Default]'#9)
    ItemIndex = 0
    ParentFont = False
    Sorted = False
    TabOrder = 15
    UnboundDataType = wwDefault
  end
  inherited tmrProcessMessage: TTimer
    Top = 256
  end
  inherited tmrdelay: TTimer
    Top = 256
  end
  inherited popSpelling: TPopupMenu
    Top = 256
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 256
  end
  inherited ApplicationEvents1: TApplicationEvents
    Top = 256
  end
  inherited MyConnection: TERPConnection
    Database = 'aus_sample_company'
    Connected = True
  end
  inherited DataState: TDataState
    Top = 256
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Top = 256
  end
  inherited imgsort: TImageList
    Top = 256
    Bitmap = {
      494C010102002400880010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Top = 256
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Top = 256
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Top = 256
  end
  inherited qryMemTrans: TERPQuery
    Top = 256
  end
  object qryTaxScales: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select RegionID, GlobalRef, ScaleID, ScaleDescription, LastUpdat' +
        'ed, EditedFlag, Active, Maximum, TT_Category, TT_Option, TT_STSL' +
        ', TT_MLS, TT_MLE, TT_MLR'
      'FROM tbltaxscales WHERE ScaleID = :xScaleID')
    AfterInsert = qryTaxScalesAfterInsert
    Left = 330
    Top = 3
    ParamData = <
      item
        DataType = ftString
        Name = 'xScaleID'
        Size = 255
      end>
    object qryTaxScalesLastUpdated: TDateField
      FieldName = 'LastUpdated'
    end
    object qryTaxScalesScaleID: TIntegerField
      FieldName = 'ScaleID'
    end
    object qryTaxScalesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryTaxScalesScaleDescription: TWideStringField
      FieldName = 'ScaleDescription'
      Size = 255
    end
    object qryTaxScalesEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryTaxScalesActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryTaxScalesRegionID: TIntegerField
      FieldName = 'RegionID'
    end
    object qryTaxScalesMaximum: TFloatField
      FieldName = 'Maximum'
      currency = True
    end
    object qryTaxScalesTT_Category: TWideStringField
      FieldName = 'TT_Category'
      Size = 1
    end
    object qryTaxScalesTT_Option: TWideStringField
      FieldName = 'TT_Option'
      Size = 1
    end
    object qryTaxScalesTT_STSL: TWideStringField
      FieldName = 'TT_STSL'
      Size = 1
    end
    object qryTaxScalesTT_MLS: TWideStringField
      FieldName = 'TT_MLS'
      Size = 1
    end
    object qryTaxScalesTT_MLE: TWideStringField
      FieldName = 'TT_MLE'
      Size = 1
    end
    object qryTaxScalesTT_MLR: TWideStringField
      FieldName = 'TT_MLR'
      Size = 1
    end
  end
  object qryTax: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select TaxID, GlobalRef, ScaleID, Threshold, A, B, EditedFlag fr' +
        'om tblTax'
      'WHERE ScaleID = :xScaleID'
      'ORDER BY TaxID')
    BeforePost = qryTaxBeforePost
    AfterPost = qryTaxAfterPost
    Left = 360
    Top = 4
    ParamData = <
      item
        DataType = ftString
        Name = 'xScaleID'
        Size = 255
      end>
    object qryTaxThreshold: TFloatField
      DisplayWidth = 19
      FieldName = 'Threshold'
      DisplayFormat = '$#.00'
      EditFormat = '#.00'
    end
    object qryTaxA: TFloatField
      DisplayLabel = 'Multiplier'
      DisplayWidth = 10
      FieldName = 'A'
    end
    object qryTaxB: TFloatField
      DisplayLabel = 'Subtract'
      DisplayWidth = 12
      FieldName = 'B'
    end
    object qryTaxScaleID: TIntegerField
      FieldName = 'ScaleID'
      Visible = False
    end
    object qryTaxEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryTaxTaxID: TIntegerField
      FieldName = 'TaxID'
      Visible = False
    end
  end
  object DSTaxScales: TDataSource
    DataSet = qryTaxScales
    Left = 327
    Top = 33
  end
  object DSTax: TDataSource
    DataSet = qryTax
    Left = 359
    Top = 34
  end
end
