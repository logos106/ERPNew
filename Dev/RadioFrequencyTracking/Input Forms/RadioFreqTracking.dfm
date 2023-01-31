inherited RadioFreqTrackingGUI: TRadioFreqTrackingGUI
  Left = 106
  Top = 182
  Caption = 'Radio Frequency Tracking'
  ClientHeight = 561
  ClientWidth = 990
  OldCreateOrder = True
  DesignSize = (
    990
    561)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [1]
    Left = 20
    Top = 42
    Width = 92
    Height = 15
    Caption = 'Customer Name'
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 51
    Top = 103
    Width = 65
    Height = 15
    Caption = 'SelcallType'
    Transparent = True
  end
  object Label3: TLabel [3]
    Left = 51
    Top = 148
    Width = 91
    Height = 15
    Caption = 'Frequency Band'
    Transparent = True
  end
  object Bevel4: TBevel [4]
    Left = 18
    Top = 87
    Width = 605
    Height = 122
    Anchors = [akLeft, akTop, akRight]
    Shape = bsFrame
  end
  object Label13: TLabel [5]
    Left = 286
    Top = 103
    Width = 91
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Number of Units'
    Transparent = True
  end
  object Label14: TLabel [6]
    Left = 286
    Top = 148
    Width = 114
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Rpt Rate/Units $/Mth'
    Transparent = True
  end
  object Label15: TLabel [7]
    Left = 485
    Top = 103
    Width = 83
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Monthly Rental'
    Transparent = True
  end
  object Label16: TLabel [8]
    Left = 485
    Top = 148
    Width = 56
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Setup Fee'
    Transparent = True
  end
  object Bevel5: TBevel [9]
    Left = 637
    Top = 87
    Width = 332
    Height = 122
    Anchors = [akTop, akRight]
    Shape = bsFrame
  end
  object Label17: TLabel [10]
    Left = 651
    Top = 93
    Width = 125
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Description of System'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object Bevel6: TBevel [11]
    Left = 16
    Top = 216
    Width = 953
    Height = 145
    Anchors = [akTop, akRight]
    Shape = bsFrame
  end
  object Bevel7: TBevel [12]
    Left = 16
    Top = 368
    Width = 953
    Height = 153
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object Label18: TLabel [13]
    Left = 24
    Top = 220
    Width = 88
    Height = 15
    Caption = 'Channel Details'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object Label19: TLabel [14]
    Left = 24
    Top = 372
    Width = 69
    Height = 15
    Caption = 'Fleet Details'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object Label20: TLabel [15]
    Left = 877
    Top = 28
    Width = 18
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'No.'
    Transparent = True
  end
  object Label4: TLabel [16]
    Left = 936
    Top = 532
    Width = 35
    Height = 15
    Caption = 'Active'
    Transparent = True
  end
  object btnOk: TDNMSpeedButton [17]
    Left = 329
    Top = 528
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'OK'
    Default = True
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
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 10
    OnClick = btnOkClick
  end
  object btnCancel: TDNMSpeedButton [18]
    Left = 569
    Top = 528
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Cancel'
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
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 11
    OnClick = btnCancelClick
  end
  object cboSelcallType: TwwDBLookupCombo [19]
    Left = 51
    Top = 120
    Width = 152
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'SelcallType'#9'15'#9'SelcallType'#9#9)
    DataField = 'SelcallType'
    DataSource = dsRFT
    LookupTable = qrySelcallType
    LookupField = 'SelcallType'
    ParentFont = False
    TabOrder = 1
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
    OnNotInList = cboAnyNotInList
  end
  object cboFreqBand: TwwDBLookupCombo [20]
    Left = 51
    Top = 164
    Width = 152
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'FreqBandName'#9'20'#9'FreqBandName'#9#9)
    DataField = 'FreqBand'
    DataSource = dsRFT
    LookupTable = qryFreqBand
    LookupField = 'FreqBandName'
    ParentFont = False
    TabOrder = 2
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
    OnNotInList = cboAnyNotInList
  end
  object edtDescOfSys: TwwDBEdit [21]
    Left = 649
    Top = 110
    Width = 312
    Height = 91
    Anchors = [akTop, akRight]
    AutoSize = False
    DataField = 'Description'
    DataSource = dsRFT
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    UnboundDataType = wwDefault
    WantReturns = True
    WordWrap = True
    OnDblClick = edtDescOfSysDblClick
  end
  object edtMobilesQty: TwwDBEdit [22]
    Left = 286
    Top = 120
    Width = 105
    Height = 23
    Anchors = [akTop, akRight]
    DataField = 'UnitQty'
    DataSource = dsRFT
    Font.Charset = ANSI_CHARSET
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
  object edtRate: TwwDBEdit [23]
    Left = 286
    Top = 164
    Width = 105
    Height = 23
    Anchors = [akTop, akRight]
    DataField = 'RptRate'
    DataSource = dsRFT
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtSetupFee: TwwDBEdit [24]
    Left = 485
    Top = 164
    Width = 105
    Height = 23
    Anchors = [akTop, akRight]
    DataField = 'SetupFee'
    DataSource = dsRFT
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object grdChannels: TwwDBGrid [25]
    Left = 24
    Top = 240
    Width = 937
    Height = 113
    Selected.Strings = (
      'ChannelNo'#9'15'#9'Channel No'#9'F'#9
      'TxFreq'#9'10'#9'Tx Freq'#9'F'#9
      'RxFreq'#9'10'#9'Rx Freq'#9'F'#9
      'Subtone'#9'10'#9'Subtone'#9'F'
      'RepeaterNo'#9'3'#9'Repeater No'#9'F'#9
      'RptLocations'#9'30'#9'Rpt Locations'#9'F'#9
      'Deviation'#9'15'#9'Deviation'#9#9
      'LicenseNo'#9'15'#9'License No'#9'F'#9
      'Details'#9'50'#9'Details'#9#9
      'Note'#9'20'#9'Note'#9'F'#9)
    MemoAttributes = [mSizeable, mWordWrap, mDisableDialog]
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight]
    DataSource = dsChannels
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = [dgAllowInsert]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
    ParentFont = False
    TabOrder = 8
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnDblClick = grdChannelsDblClick
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
    object qrdChannelsIButton: TwwIButton
      Left = 0
      Top = 0
      Width = 13
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
      OnClick = qrdChannelsIButtonClick
    end
  end
  object grdSelCallDetails: TwwDBGrid [26]
    Left = 24
    Top = 392
    Width = 937
    Height = 121
    ControlType.Strings = (
      'DateInstalled;CustomEdit;dtDateInstalled;F'
      'AntennaType;CustomEdit;cboATM1;F'
      'RadioModel;CustomEdit;cboRMU1;F'
      'Invoice;CheckBox;T;F')
    Selected.Strings = (
      'FleetNo'#9'15'#9'Fleet No'#9'F'#9
      'SelcallNo'#9'5'#9'SelcallNo'#9'F'#9
      'Vehicle'#9'15'#9'Vehicle'#9#9
      'Driver'#9'30'#9'Driver'#9#9
      'DateInstalled'#9'10'#9'DateInstalled'#9'F'#9
      'AntennaType'#9'10'#9'AntennaType'#9'F'#9
      'Rego'#9'10'#9'Rego'#9'F'#9
      'Serial'#9'10'#9'Serial'#9'F'#9
      'RadioModel'#9'10'#9'RadioModel'#9'F'#9
      'Note'#9'12'#9'Note'#9'F'#9
      'Invoice'#9'1'#9'Invoice'#9'F'#9)
    MemoAttributes = [mSizeable, mWordWrap, mDisableDialog]
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsSelcallsDetails
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = [dgAllowInsert]
    ParentFont = False
    PopupMenu = popCustomiseGrid
    TabOrder = 9
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnDblClick = grdSelCallDetailsDblClick
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
    object grdSelCallDetailsIButton: TwwIButton
      Left = 0
      Top = 0
      Width = 13
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
      OnClick = grdSelCallDetailsIButtonClick
    end
  end
  object edtMonthlyRental: TwwDBEdit [27]
    Left = 485
    Top = 120
    Width = 105
    Height = 23
    TabStop = False
    Anchors = [akTop, akRight]
    DataField = 'MonthlyRental'
    DataSource = dsRFT
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object chkActive: TwwCheckBox [28]
    Left = 912
    Top = 532
    Width = 17
    Height = 17
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
    Anchors = [akBottom]
    DataField = 'Active'
    DataSource = dsRFT
    TabOrder = 12
  end
  object edtID: TwwDBEdit [29]
    Left = 901
    Top = 24
    Width = 65
    Height = 23
    Anchors = [akTop, akRight]
    DataField = 'RFTID'
    DataSource = dsRFT
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
  object dtDateInstalled: TwwDBDateTimePicker [30]
    Left = 324
    Top = 433
    Width = 121
    Height = 23
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'DateInstalled'
    DataSource = dsSelcallsDetails
    Epoch = 1950
    ShowButton = True
    TabOrder = 14
  end
  object cboClient: TwwDBLookupCombo [31]
    Left = 20
    Top = 58
    Width = 180
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Company'#9'80'#9'Company'#9#9)
    DataField = 'CustomerName'
    DataSource = dsRFT
    LookupTable = qryClients
    LookupField = 'Company'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 0
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = True
  end
  object cboATM1: TwwDBLookupCombo [32]
    Left = 193
    Top = 458
    Width = 137
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AntennaTypeMobilesName'#9'20'#9'AntennaTypeMobilesName'#9#9)
    DataField = 'AntennaTypeMobiles1'
    DataSource = dsRFT
    LookupTable = qryAntTypeMobiles
    LookupField = 'AntennaTypeMobilesName'
    ParentFont = False
    TabOrder = 15
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
    OnNotInList = cboAnyNotInList
  end
  object cboRMU1: TwwDBLookupCombo [33]
    Left = 369
    Top = 458
    Width = 137
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'RadioModelsUsedName'#9'20'#9'RadioModelsUsedName'#9#9)
    DataField = 'RadioModelsUsed1'
    DataSource = dsRFT
    LookupTable = qryRadioModelsUsed
    LookupField = 'RadioModelsUsedName'
    ParentFont = False
    TabOrder = 16
    AutoDropDown = True
    ShowButton = True
    AllowClearKey = False
    OnNotInList = cboAnyNotInList
  end
  object pnlTitle: TDNMPanel [34]
    Left = 277
    Top = 6
    Width = 422
    Height = 45
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 17
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 418
      Height = 41
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.2.1.1'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 418
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Radio Frequency Tracking'
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
  object qryClients: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientID, Company'
      'FROM tblClients'
      'WHERE Active = "T"'
      'AND Customer="T"'
      'ORDER By Company')
    Left = 80
    Top = 40
    object qryClientsCompany: TStringField
      DisplayWidth = 80
      FieldName = 'Company'
      Size = 80
    end
    object qryClientsClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
  end
  object qryRFT: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblRFT'
      'WHERE RFTID = :KeyID')
    OnCalcFields = qryRFTCalcFields
    Left = 169
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'KeyID'
        Value = 0
      end>
    object qryRFTRptRate: TFloatField
      FieldName = 'RptRate'
      currency = True
    end
    object qryRFTSetupFee: TFloatField
      FieldName = 'SetupFee'
      currency = True
    end
    object qryRFTDescription: TMemoField
      FieldName = 'Description'
      BlobType = ftMemo
    end
    object qryRFTUnitQty: TIntegerField
      FieldName = 'UnitQty'
    end
    object qryRFTRFTID: TIntegerField
      FieldName = 'RFTID'
    end
    object qryRFTSelcallType: TStringField
      FieldName = 'SelcallType'
      Size = 15
    end
    object qryRFTCustomerName: TStringField
      FieldName = 'CustomerName'
      Size = 40
    end
    object qryRFTFreqBand: TStringField
      FieldName = 'FreqBand'
    end
    object qryRFTAntennaTypeBase: TStringField
      FieldName = 'AntennaTypeBase'
    end
    object qryRFTAntennaTypeMobiles1: TStringField
      FieldName = 'AntennaTypeMobiles1'
    end
    object qryRFTAntennaTypeMobiles2: TStringField
      FieldName = 'AntennaTypeMobiles2'
    end
    object qryRFTAntennaTypeMobiles3: TStringField
      FieldName = 'AntennaTypeMobiles3'
    end
    object qryRFTRadioModelsUsed1: TStringField
      FieldName = 'RadioModelsUsed1'
    end
    object qryRFTRadioModelsUsed2: TStringField
      FieldName = 'RadioModelsUsed2'
    end
    object qryRFTRadioModelsUsed3: TStringField
      FieldName = 'RadioModelsUsed3'
    end
    object qryRFTActive: TStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryRFTMonthlyRental: TFloatField
      FieldKind = fkCalculated
      FieldName = 'MonthlyRental'
      currency = True
      Calculated = True
    end
  end
  object dsRFT: TDataSource
    DataSet = qryRFT
    Left = 167
    Top = 37
  end
  object qryFreqBand: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblRFTFreqBand'
      'WHERE Active = "T"')
    Left = 202
    Top = 164
    object qryFreqBandFreqBandName: TStringField
      DisplayWidth = 20
      FieldName = 'FreqBandName'
    end
    object qryFreqBandFreqBandID: TIntegerField
      DisplayWidth = 15
      FieldName = 'FreqBandID'
      Visible = False
    end
    object qryFreqBandFreqBandDescription: TStringField
      DisplayWidth = 255
      FieldName = 'FreqBandDescription'
      Visible = False
      Size = 255
    end
  end
  object qryChannels: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblRFTChannels'
      'WHERE Active = "T"'
      'AND RFTID = :xID')
    BeforePost = qryChannelsBeforePost
    MasterSource = dsRFT
    MasterFields = 'RFTID'
    DetailFields = 'RFTID'
    Left = 224
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end
      item
        DataType = ftString
        Name = 'RFTID'
        Value = ''
      end>
    object qryChannelsChannelNo: TIntegerField
      DisplayLabel = 'Channel No'
      DisplayWidth = 15
      FieldName = 'ChannelNo'
      Origin = 'tblRFTChannels.ChannelNo'
    end
    object qryChannelsTxFreq: TFloatField
      DisplayLabel = 'Tx Freq'
      DisplayWidth = 10
      FieldName = 'TxFreq'
      Origin = 'tblRFTChannels.TxFreq'
      DisplayFormat = '#0.00000 MHz'
    end
    object qryChannelsRxFreq: TFloatField
      DisplayLabel = 'Rx Freq'
      DisplayWidth = 10
      FieldName = 'RxFreq'
      Origin = 'tblRFTChannels.RxFreq'
      DisplayFormat = '#0.00000 MHz'
    end
    object qryChannelsSubtone: TStringField
      DisplayWidth = 10
      FieldName = 'Subtone'
      Size = 255
    end
    object qryChannelsRepeaterNo: TStringField
      DisplayLabel = 'Repeater No'
      DisplayWidth = 3
      FieldName = 'RepeaterNo'
      Origin = 'tblRFTChannels.RepeaterNo'
      FixedChar = True
      Size = 3
    end
    object qryChannelsRptLocations: TStringField
      DisplayLabel = 'Rpt Locations'
      DisplayWidth = 30
      FieldName = 'RptLocations'
      Origin = 'tblRFTChannels.RptLocations'
      Size = 30
    end
    object qryChannelsDeviation: TStringField
      DisplayWidth = 15
      FieldName = 'Deviation'
      Origin = 'tblRFTChannels.Deviation'
      Size = 15
    end
    object qryChannelsLicenseNo: TStringField
      DisplayLabel = 'License No'
      DisplayWidth = 15
      FieldName = 'LicenseNo'
      Origin = 'tblRFTChannels.LicenseNo'
      Size = 15
    end
    object qryChannelsDetails: TStringField
      DisplayWidth = 50
      FieldName = 'Details'
      Origin = 'tblRFTChannels.Details'
      Size = 50
    end
    object qryChannelsNote: TStringField
      DisplayWidth = 20
      FieldName = 'Note'
      Size = 250
    end
    object qryChannelsChannelsID: TWordField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ChannelsID'
      Origin = 'tblRFTChannels.ChannelsID'
      Visible = False
    end
    object qryChannelsRFTID: TIntegerField
      DisplayWidth = 15
      FieldName = 'RFTID'
      Origin = 'tblRFTChannels.RFTID'
      Visible = False
    end
    object qryChannelsActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblRFTChannels.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsChannels: TDataSource
    DataSet = qryChannels
    Left = 225
    Top = 263
  end
  object qrySelcallsDetails: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblRFTSelcallDetails'
      'WHERE Active ="T"'
      'AND RFTID = :xID')
    BeforePost = qrySelcallsDetailsBeforePost
    DetailFields = 'ChannelsID'
    Left = 224
    Top = 387
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qrySelcallsDetailsSelcallNo: TStringField
      DisplayWidth = 5
      FieldName = 'SelcallNo'
      Origin = 'tblRFTSelcallDetails.SelcallNo'
      Size = 5
    end
    object qrySelcallsDetailsVehicle: TStringField
      DisplayWidth = 15
      FieldName = 'Vehicle'
      Origin = 'tblRFTSelcallDetails.Vehicle'
      Size = 15
    end
    object qrySelcallsDetailsDriver: TStringField
      DisplayWidth = 30
      FieldName = 'Driver'
      Origin = 'tblRFTSelcallDetails.Driver'
      Size = 30
    end
    object qrySelcallsDetailsDateInstalled: TDateField
      DisplayWidth = 10
      FieldName = 'DateInstalled'
      Origin = 'tblRFTSelcallDetails.DateInstalled'
    end
    object qrySelcallsDetailsAntennaType: TStringField
      DisplayWidth = 10
      FieldName = 'AntennaType'
      Origin = 'tblRFTSelcallDetails.AntennaType'
      Size = 255
    end
    object qrySelcallsDetailsRego: TStringField
      DisplayWidth = 10
      FieldName = 'Rego'
      Origin = 'tblRFTSelcallDetails.Rego'
      Size = 255
    end
    object qrySelcallsDetailsSerial: TStringField
      DisplayWidth = 10
      FieldName = 'Serial'
      Origin = 'tblRFTSelcallDetails.Serial'
      Size = 255
    end
    object qrySelcallsDetailsRadioModel: TStringField
      DisplayWidth = 10
      FieldName = 'RadioModel'
      Origin = 'tblRFTSelcallDetails.RadioModel'
      Size = 255
    end
    object qrySelcallsDetailsNote: TStringField
      DisplayWidth = 12
      FieldName = 'Note'
      Origin = 'tblRFTSelcallDetails.Note'
      Size = 255
    end
    object qrySelcallsDetailsInvoice: TStringField
      DisplayWidth = 1
      FieldName = 'Invoice'
      Origin = 'tblRFTSelcallDetails.Invoice'
      OnChange = qrySelcallsDetailsInvoiceChange
      FixedChar = True
      Size = 1
    end
    object qrySelcallsDetailsSelcallDetailsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'SelcallDetailsID'
      Origin = 'tblRFTSelcallDetails.SelcallDetailsID'
      Visible = False
    end
    object qrySelcallsDetailsRFTID: TIntegerField
      DisplayWidth = 15
      FieldName = 'RFTID'
      Origin = 'tblRFTSelcallDetails.RFTID'
      Visible = False
    end
    object qrySelcallsDetailsGlobalRef: TStringField
      DisplayWidth = 10
      FieldName = 'GlobalRef'
      Origin = 'tblRFTSelcallDetails.GlobalRef'
      Visible = False
      Size = 255
    end
    object qrySelcallsDetailsActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblRFTSelcallDetails.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySelcallsDetailsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblRFTSelcallDetails.msTimeStamp'
      Visible = False
    end
    object qrySelcallsDetailsFleetNo: TLargeintField
      FieldName = 'FleetNo'
    end
  end
  object dsSelcallsDetails: TDataSource
    DataSet = qrySelcallsDetails
    Left = 226
    Top = 413
  end
  object qrySelcallType: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblRFTSelcallType'
      'WHERE Active = "T"')
    Left = 205
    Top = 115
    object qrySelcallTypeSelcallType: TStringField
      DisplayWidth = 15
      FieldName = 'SelcallType'
      Size = 15
    end
    object qrySelcallTypeSelcallTypeID: TIntegerField
      DisplayWidth = 15
      FieldName = 'SelcallTypeID'
      Visible = False
    end
    object qrySelcallTypeSelcallTypeDescription: TStringField
      DisplayWidth = 255
      FieldName = 'SelcallTypeDescription'
      Visible = False
      Size = 255
    end
    object qrySelcallTypeActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsClients: TDataSource
    DataSet = qryClients
    Left = 82
    Top = 71
  end
  object dlgSelcallNote: TwwMemoDialog
    DataSource = dsSelcallsDetails
    DataField = 'Note'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    DlgLeft = 0
    DlgTop = 0
    DlgWidth = 561
    DlgHeight = 396
    OnUserButton1Click = dlgSelcallNoteUserButton1Click
    UserButton1Caption = 'Add Stamp'
    Left = 568
    Top = 424
  end
  object dlgChannelsNote: TwwMemoDialog
    DataSource = dsChannels
    DataField = 'Note'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    DlgLeft = 0
    DlgTop = 0
    DlgWidth = 561
    DlgHeight = 396
    OnUserButton1Click = dlgChannelsNoteUserButton1Click
    UserButton1Caption = 'Add Stamp'
    Left = 560
    Top = 288
  end
  object qryAntTypeMobiles: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblRFTAntennaTypeMobiles'
      'WHERE Active = "T"')
    Left = 305
    Top = 426
    object qryAntTypeMobilesAntennaTypeMobilesName: TStringField
      DisplayWidth = 20
      FieldName = 'AntennaTypeMobilesName'
    end
    object qryAntTypeMobilesAntennaTypeMobilesID: TIntegerField
      DisplayWidth = 15
      FieldName = 'AntennaTypeMobilesID'
      Visible = False
    end
    object qryAntTypeMobilesAntennaTypeMobilesDescription: TStringField
      DisplayWidth = 255
      FieldName = 'AntennaTypeMobilesDescription'
      Visible = False
      Size = 255
    end
  end
  object qryRadioModelsUsed: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblRFTradiomodelsused'
      'WHERE Active = "T"')
    Left = 481
    Top = 426
    object qryRadioModelsUsedRadioModelsUsedName: TStringField
      DisplayWidth = 20
      FieldName = 'RadioModelsUsedName'
    end
    object qryRadioModelsUsedRadioModelsUsedID: TIntegerField
      DisplayWidth = 15
      FieldName = 'RadioModelsUsedID'
      Visible = False
    end
    object qryRadioModelsUsedRadioModelsUsedDescription: TStringField
      DisplayWidth = 255
      FieldName = 'RadioModelsUsedDescription'
      Visible = False
      Size = 255
    end
  end
end
