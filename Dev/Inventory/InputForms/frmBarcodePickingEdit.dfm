inherited BarcodePickingEditGUI: TBarcodePickingEditGUI
  Left = 125
  HelpContext = 34000
  Caption = 'Barcode Picking'
  ClientHeight = 552
  ClientWidth = 729
  OldCreateOrder = True
  ExplicitLeft = 125
  ExplicitWidth = 737
  ExplicitHeight = 579
  DesignSize = (
    729
    552)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 9
    Top = 84
    Width = 179
    Height = 58
    HelpContext = 34002
    Shape = bsFrame
  end
  object Bevel4: TBevel [1]
    Left = 186
    Top = 84
    Width = 179
    Height = 58
    HelpContext = 34003
    Shape = bsFrame
  end
  object Bevel5: TBevel [2]
    Left = 367
    Top = 84
    Width = 179
    Height = 58
    HelpContext = 34004
    Shape = bsFrame
  end
  object Bevel6: TBevel [3]
    Left = 544
    Top = 84
    Width = 179
    Height = 58
    HelpContext = 34005
    Shape = bsFrame
  end
  object Bevel2: TBevel [4]
    Left = 81
    Top = 140
    Width = 212
    Height = 156
    HelpContext = 34006
    Shape = bsFrame
  end
  object Bevel3: TBevel [5]
    Left = 442
    Top = 140
    Width = 212
    Height = 156
    HelpContext = 34007
    Shape = bsFrame
  end
  object Label1: TLabel [6]
    Left = 573
    Top = 39
    Width = 122
    Height = 15
    HelpContext = 34008
    Caption = 'Picking Assembly No.'
    FocusControl = PickingAssemblyID
    Transparent = True
  end
  object Label2: TLabel [7]
    Left = 42
    Top = 39
    Width = 85
    Height = 15
    HelpContext = 34009
    Caption = 'Barcode Prefix'
    FocusControl = Barcode
    Transparent = True
  end
  object Label3: TLabel [8]
    Left = 105
    Top = 151
    Width = 100
    Height = 15
    HelpContext = 34010
    Caption = 'Picking Employee'
    Transparent = True
  end
  object Label4: TLabel [9]
    Left = 55
    Top = 99
    Width = 87
    Height = 15
    HelpContext = 34011
    Caption = 'Started Picking'
    Transparent = True
  end
  object Label5: TLabel [10]
    Left = 105
    Top = 194
    Width = 118
    Height = 15
    HelpContext = 34012
    Caption = 'Started Picking Time'
    Transparent = True
  end
  object Label6: TLabel [11]
    Left = 229
    Top = 99
    Width = 92
    Height = 15
    HelpContext = 34013
    Caption = 'Finished Picking'
    Transparent = True
  end
  object Label7: TLabel [12]
    Left = 105
    Top = 238
    Width = 123
    Height = 15
    HelpContext = 34014
    Caption = 'Finished Picking Time'
    Transparent = True
  end
  object Label8: TLabel [13]
    Left = 465
    Top = 151
    Width = 104
    Height = 15
    HelpContext = 34015
    Caption = 'Packing Employee'
    Transparent = True
  end
  object Label9: TLabel [14]
    Left = 411
    Top = 99
    Width = 91
    Height = 15
    HelpContext = 34016
    Caption = 'Started Packing'
    Transparent = True
  end
  object Label10: TLabel [15]
    Left = 465
    Top = 194
    Width = 122
    Height = 15
    HelpContext = 34017
    Caption = 'Started Packing Time'
    Transparent = True
  end
  object Label11: TLabel [16]
    Left = 585
    Top = 99
    Width = 96
    Height = 15
    HelpContext = 34018
    Caption = 'Finished Packing'
    Transparent = True
  end
  object Label12: TLabel [17]
    Left = 465
    Top = 238
    Width = 127
    Height = 15
    HelpContext = 34019
    Caption = 'Finished Packing Time'
    Transparent = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 302
    Width = 729
    ExplicitTop = 302
    ExplicitWidth = 729
  end
  inherited imgGridWatermark: TImage
    HelpContext = 34001
  end
  object StartPickingTime: TwwDBDateTimePicker [22]
    Left = 105
    Top = 210
    Width = 169
    Height = 23
    HelpContext = 34024
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'StartPickingTime'
    DataSource = DSMaster
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Interval.RoundMinutes = True
    ParentFont = False
    ShowButton = True
    TabOrder = 3
  end
  object FinishedPickingTime: TwwDBDateTimePicker [23]
    Left = 105
    Top = 253
    Width = 169
    Height = 23
    HelpContext = 34025
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'FinishedPickingTime'
    DataSource = DSMaster
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Interval.RoundMinutes = True
    ParentFont = False
    ShowButton = True
    TabOrder = 4
  end
  object FinishedPackingTime: TwwDBDateTimePicker [24]
    Left = 465
    Top = 253
    Width = 169
    Height = 23
    HelpContext = 34026
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'FinishedPackingTime'
    DataSource = DSMaster
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Interval.RoundMinutes = True
    ParentFont = False
    ShowButton = True
    TabOrder = 5
  end
  object StartPackingTime: TwwDBDateTimePicker [25]
    Left = 465
    Top = 210
    Width = 169
    Height = 23
    HelpContext = 34027
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'StartPackingTime'
    DataSource = DSMaster
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Interval.RoundMinutes = True
    ParentFont = False
    ShowButton = True
    TabOrder = 6
  end
  object StartPicking: TwwCheckBox [26]
    Left = 91
    Top = 116
    Width = 15
    Height = 15
    HelpContext = 34028
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
    Caption = 'StartPicking'
    DataField = 'StartPicking'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object FinishedPicking: TwwCheckBox [27]
    Left = 268
    Top = 114
    Width = 15
    Height = 15
    HelpContext = 34029
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
    Caption = 'wwCheckBox1'
    DataField = 'FinishedPicking'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object StartPacking: TwwCheckBox [28]
    Left = 449
    Top = 116
    Width = 15
    Height = 15
    HelpContext = 34030
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
    Caption = 'wwCheckBox1'
    DataField = 'StartPacking'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object PickingEmployeeID: TwwDBLookupCombo [29]
    Left = 105
    Top = 167
    Width = 169
    Height = 23
    HelpContext = 34031
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'EmployeeName'#9'20'#9'Employee Name'#9#9)
    DataField = 'PickingEmployeeID'
    DataSource = DSMaster
    LookupTable = cboEmployeeLookup
    LookupField = 'EmployeeID'
    ParentFont = False
    TabOrder = 11
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = PickingEmployeeIDCloseUp
  end
  object PackingEmployeeID: TwwDBLookupCombo [30]
    Left = 465
    Top = 167
    Width = 169
    Height = 23
    HelpContext = 34032
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'EmployeeName'#9'20'#9'Employee Name'#9'T'#9)
    DataField = 'PackingEmployeeID'
    DataSource = DSMaster
    LookupTable = cboEmployeeLookup
    LookupField = 'EmployeeID'
    ParentFont = False
    TabOrder = 12
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = PackingEmployeeIDCloseUp
  end
  object DNMPanel2: TDNMPanel [31]
    Left = 0
    Top = 502
    Width = 729
    Height = 50
    HelpContext = 34033
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    DesignSize = (
      729
      50)
    object cmdCancel: TDNMSpeedButton
      Left = 586
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 34034
      Anchors = [akBottom]
      Caption = '&Cancel'
      DisableTransparent = False
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
      TabOrder = 0
      OnClick = cmdCancelClick
    end
    object cmdPrint: TDNMSpeedButton
      Left = 146
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 34035
      Anchors = [akBottom]
      Caption = '&Print'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = cmdPrintClick
    end
    object cmdOk: TDNMSpeedButton
      Left = 37
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 34036
      Anchors = [akBottom]
      Caption = '&Save'
      DisableTransparent = False
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
      TabOrder = 2
      OnClick = cmdOkClick
    end
    object cmdDeliveryDocket: TDNMSpeedButton
      Left = 366
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 34037
      Anchors = [akTop, akRight]
      Caption = '&Del Docket'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TabStop = False
      OnClick = cmdDeliveryDocketClick
    end
    object cmdPrintPick: TDNMSpeedButton
      Left = 256
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 34038
      Anchors = [akTop, akRight]
      Caption = 'Print Pick'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TabStop = False
      OnClick = cmdPrintPickClick
    end
    object Button1: TDNMSpeedButton
      Left = 476
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 34039
      Anchors = [akBottom]
      Caption = 'Print C'#39'Note'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Button1Click
    end
  end
  object FinishedPacking: TwwCheckBox [32]
    Left = 626
    Top = 117
    Width = 15
    Height = 15
    HelpContext = 34040
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
    Caption = 'wwCheckBox1'
    DataField = 'FinishedPacking'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object pnlTitle: TDNMPanel [33]
    Left = 231
    Top = 6
    Width = 265
    Height = 45
    HelpContext = 34041
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 261
      Height = 41
      HelpContext = 34042
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
        Width = 261
        Height = 41
        HelpContext = 34043
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Barcode Picking'
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
  object PickingAssemblyID: TDBEdit [34]
    Left = 591
    Top = 53
    Width = 90
    Height = 23
    HelpContext = 34022
    DataField = 'PickingAssemblyID'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object pnlDetail: TDNMPanel [35]
    Left = 0
    Top = 302
    Width = 729
    Height = 200
    HelpContext = 34020
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object grdTransactions: TwwDBGrid
      Left = 0
      Top = 0
      Width = 729
      Height = 200
      HelpContext = 34021
      Selected.Strings = (
        'ProductName'#9'30'#9'ProductName'#9#9
        'Qty'#9'10'#9'Qty'#9#9
        'PackNumber'#9'10'#9'PackNumber'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = DSDetails
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgEnterToTab]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object btnDelete: TwwIButton
        Left = 0
        Top = 0
        Width = 20
        Height = 22
        AllowAllUp = True
        Glyph.Data = {
          C6030000424DC603000000000000360000002800000010000000130000000100
          18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
          666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
          99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
          CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
          333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
          99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
          C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
          C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
          77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
          8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
          B2B2B2808080333366000080333366777777777777333366000080333399C0C0
          C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
          0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
          CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
          0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
          868686808080666699333399333399000080333366666666808080969696C0C0
          C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
          8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
          B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
          80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
          CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
          99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
          D7CCCCCCCCCCCCCCCCCC}
        OnClick = btnDeleteClick
      end
    end
  end
  object Barcode: TDBEdit [36]
    Left = 42
    Top = 53
    Width = 116
    Height = 23
    HelpContext = 34023
    DataField = 'Barcode'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 1
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 62
    Top = 0
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102001400140010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblpickingassemblylines'
      'Where PickingAssemblyID= :ID;')
    Left = 69
    Top = 427
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object tblDetailsProductName: TWideStringField
      DisplayWidth = 30
      FieldName = 'ProductName'
      Size = 255
    end
    object tblDetailsPackNumber: TIntegerField
      DisplayWidth = 10
      FieldName = 'PackNumber'
    end
    object tblDetailsQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
    end
    object tblDetailsPickingAssemblylinesID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'PickingAssemblylinesID'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsPickingAssemblyID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PickingAssemblyID'
      Visible = False
    end
    object tblDetailsProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
  end
  object tblMaster: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblpickingassembly '
      'Where PickingAssemblyID= :ID;')
    Left = 30
    Top = 428
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object tblMasterPickingAssemblyID: TAutoIncField
      FieldName = 'PickingAssemblyID'
      ReadOnly = True
    end
    object tblMasterSaleID: TIntegerField
      FieldName = 'SaleID'
      ReadOnly = True
    end
    object tblMasterBarcode: TWideStringField
      FieldName = 'Barcode'
      ReadOnly = True
      Size = 255
    end
    object tblMasterPickingEmployeeID: TIntegerField
      FieldName = 'PickingEmployeeID'
    end
    object tblMasterStartPicking: TWideStringField
      FieldName = 'StartPicking'
      FixedChar = True
      Size = 1
    end
    object tblMasterStartPickingTime: TDateTimeField
      FieldName = 'StartPickingTime'
    end
    object tblMasterFinishedPicking: TWideStringField
      FieldName = 'FinishedPicking'
      FixedChar = True
      Size = 1
    end
    object tblMasterFinishedPickingTime: TDateTimeField
      FieldName = 'FinishedPickingTime'
    end
    object tblMasterPackingEmployeeID: TIntegerField
      FieldName = 'PackingEmployeeID'
    end
    object tblMasterStartPacking: TWideStringField
      FieldName = 'StartPacking'
      FixedChar = True
      Size = 1
    end
    object tblMasterStartPackingTime: TDateTimeField
      FieldName = 'StartPackingTime'
    end
    object tblMasterFinishedPacking: TWideStringField
      FieldName = 'FinishedPacking'
      FixedChar = True
      Size = 1
    end
    object tblMasterFinishedPackingTime: TDateTimeField
      FieldName = 'FinishedPackingTime'
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 33
    Top = 457
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 67
    Top = 458
  end
  object cboEmployeeLookup: TERPQuery
    SQL.Strings = (
      
        'SELECT tblEmployees.EmployeeID, Concat_WS('#39' '#39',firstname,Lastname' +
        ') AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY Concat(firstname,'#39' '#39',Lastname);')
    Left = 213
    Top = 429
  end
  object DSEmployeeLookup: TDataSource
    AutoEdit = False
    DataSet = cboEmployeeLookup
    Left = 214
    Top = 458
  end
end
