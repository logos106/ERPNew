inherited frmSource: TfrmSource
  Left = 351
  Top = 251
  HelpContext = 352000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Source Types'
  ClientHeight = 236
  ClientWidth = 464
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  ExplicitLeft = 351
  ExplicitTop = 251
  ExplicitWidth = 480
  ExplicitHeight = 275
  DesignSize = (
    464
    236)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel2: TBevel [0]
    Left = 10
    Top = 57
    Width = 443
    Height = 120
    HelpContext = 352002
    Shape = bsFrame
  end
  object MediaType_Label: TLabel [1]
    Left = 27
    Top = 65
    Width = 114
    Height = 18
    HelpContext = 352003
    AutoSize = False
    Caption = 'Source Description'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Active_Label: TLabel [2]
    Left = 414
    Top = 197
    Width = 40
    Height = 18
    HelpContext = 352004
    Anchors = [akBottom]
    AutoSize = False
    Caption = 'Active'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
    ExplicitTop = 188
  end
  object Label10: TLabel [3]
    Left = 27
    Top = 120
    Width = 50
    Height = 18
    HelpContext = 352005
    AutoSize = False
    Caption = 'Created'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label11: TLabel [4]
    Left = 179
    Top = 120
    Width = 49
    Height = 18
    HelpContext = 352006
    AutoSize = False
    Caption = 'Inactive'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label20: TLabel [5]
    Left = 179
    Top = 65
    Width = 104
    Height = 18
    HelpContext = 352007
    AutoSize = False
    Caption = 'Expense Account'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label21: TLabel [6]
    Left = 329
    Top = 65
    Width = 111
    Height = 18
    HelpContext = 352008
    AutoSize = False
    Caption = 'Estimated Cost (Ex)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 236
    Width = 464
    HelpContext = 352023
    ExplicitTop = 227
    ExplicitWidth = 464
  end
  inherited imgGridWatermark: TImage
    HelpContext = 352001
  end
  object Label1: TLabel [11]
    Left = 332
    Top = 141
    Width = 49
    Height = 15
    HelpContext = 352024
    Caption = 'Google ?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    WordWrap = True
  end
  object wwDBDateTimePicker1: TwwDBDateTimePicker [13]
    Left = 27
    Top = 137
    Width = 121
    Height = 23
    HelpContext = 352013
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'CreationDate'
    DataSource = frmSourceSrc
    Epoch = 1950
    ShowButton = True
    TabOrder = 3
  end
  object wwDBDateTimePicker2: TwwDBDateTimePicker [14]
    Left = 179
    Top = 137
    Width = 121
    Height = 23
    HelpContext = 352014
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'InactiveDate'
    DataSource = frmSourceSrc
    Epoch = 1950
    ShowButton = True
    TabOrder = 4
  end
  object cboAccount: TwwDBLookupCombo [15]
    Left = 179
    Top = 84
    Width = 144
    Height = 23
    HelpContext = 352015
    AutoSize = False
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountName'#9'50'#9'Account Name'#9'T'
      'AccountType'#9'20'#9'Type'#9'F')
    DataField = 'Account'
    DataSource = frmSourceSrc
    LookupTable = qryAccount
    LookupField = 'AccountID'
    Options = [loTitles]
    TabOrder = 1
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object chkActive: TwwCheckBox [16]
    Left = 423
    Top = 214
    Width = 14
    Height = 15
    HelpContext = 352016
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbChecked
    Anchors = [akBottom]
    Checked = True
    DataField = 'Active'
    DataSource = frmSourceSrc
    State = cbChecked
    TabOrder = 8
  end
  object txtMediaType: TDBEdit [17]
    Left = 27
    Top = 84
    Width = 146
    Height = 23
    Hint = 'Description of Media Source'
    HelpContext = 352017
    Color = clWhite
    DataField = 'MediaType'
    DataSource = frmSourceSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object cmdOk: TDNMSpeedButton [18]
    Left = 66
    Top = 198
    Width = 87
    Height = 27
    HelpContext = 352025
    Action = actSave
    Anchors = [akBottom]
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
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 9
  end
  object cmdCancel: TDNMSpeedButton [19]
    Left = 314
    Top = 198
    Width = 87
    Height = 27
    HelpContext = 352026
    Action = actCancel
    Anchors = [akBottom]
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
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 10
  end
  object pnlTitle: TDNMPanel [20]
    Left = 111
    Top = 6
    Width = 237
    Height = 40
    HelpContext = 352020
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 233
      Height = 36
      HelpContext = 352021
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
        Width = 233
        Height = 36
        HelpContext = 352022
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Source Type'
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
  object MedTypeID: TDBEdit [21]
    Left = 86
    Top = 10
    Width = 14
    Height = 22
    HelpContext = 352010
    TabStop = False
    DataField = 'MedTypeID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Visible = False
  end
  object cmdNew: TDNMSpeedButton [22]
    Left = 190
    Top = 198
    Width = 87
    Height = 27
    HelpContext = 352027
    Action = actNew
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
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object EditedFlag: TDBCheckBox [23]
    Left = 0
    Top = 0
    Width = 17
    Height = 16
    HelpContext = 352011
    TabStop = False
    DataField = 'EditedFlag'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    Visible = False
  end
  object wwCheckBox1: TwwCheckBox [24]
    Left = 389
    Top = 141
    Width = 14
    Height = 15
    HelpContext = 352028
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbChecked
    Checked = True
    DataField = 'showingoogle'
    DataSource = frmSourceSrc
    State = cbChecked
    TabOrder = 12
  end
  object Cost: TDBEdit [25]
    Left = 329
    Top = 84
    Width = 93
    Height = 23
    HelpContext = 352012
    DataField = 'Cost'
    DataSource = frmSourceSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  inherited DataState: TDataState
    Left = 32
    Top = 24
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003800400010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object frmSourceSrc: TDataSource
    DataSet = qrySource
    Left = 378
    Top = 16
  end
  object qrySource: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT MedTypeID, MediaType, Account, Cost, Active, CreationDate' +
        ', InactiveDate, EditedFlag, Globalref,showingoogle'
      'FROM tblSource'
      'Where MedTypeID = :KeyID')
    Left = 368
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object qrySourceMedTypeID: TAutoIncField
      FieldName = 'MedTypeID'
      ReadOnly = True
    end
    object qrySourceMediaType: TWideStringField
      FieldName = 'MediaType'
      FixedChar = True
      Size = 50
    end
    object qrySourceAccount: TIntegerField
      FieldName = 'Account'
    end
    object qrySourceCost: TFloatField
      FieldName = 'Cost'
      currency = True
    end
    object qrySourceActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qrySourceCreationDate: TDateField
      FieldName = 'CreationDate'
    end
    object qrySourceInactiveDate: TDateField
      FieldName = 'InactiveDate'
    end
    object qrySourceEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qrySourceGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object qrySourceshowingoogle: TWideStringField
      FieldName = 'showingoogle'
      FixedChar = True
      Size = 1
    end
  end
  object qryAccount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblChartofAccounts.AccountID, tblChartofAccounts.AccountN' +
        'ame, tblChartofAccounts.AccountType '
      'FROM tblChartofAccounts '
      'ORDER BY tblChartofAccounts.AccountName;')
    Left = 419
    Top = 8
  end
  object memQrySource: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'MedTypeID'
        DataType = ftAutoInc
      end
      item
        Name = 'MediaType'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Account'
        DataType = ftInteger
      end
      item
        Name = 'Cost'
        DataType = ftBCD
        Size = 4
      end
      item
        Name = 'Active'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CreationDate'
        DataType = ftDate
      end
      item
        Name = 'InactiveDate'
        DataType = ftDate
      end
      item
        Name = 'EditedFlag'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 16
    Top = 168
    object memQrySourceMedTypeID: TAutoIncField
      FieldName = 'MedTypeID'
    end
    object memQrySourceMediaType: TWideStringField
      FieldName = 'MediaType'
      Size = 50
    end
    object memQrySourceAccount: TIntegerField
      FieldName = 'Account'
    end
    object memQrySourceCost: TFloatField
      FieldName = 'Cost'
    end
    object memQrySourceActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object memQrySourceCreationDate: TDateField
      FieldName = 'CreationDate'
    end
    object memQrySourceInactiveDate: TDateField
      FieldName = 'InactiveDate'
    end
    object memQrySourceEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
  object ActionList: TActionList
    Left = 72
    Top = 8
    object actSave: TAction
      Caption = '&Save'
      HelpContext = 352029
      OnExecute = actSaveExecute
    end
    object actNew: TAction
      Caption = '&New'
      HelpContext = 352030
      OnExecute = actNewExecute
    end
    object actCancel: TAction
      Caption = '&Cancel'
      HelpContext = 352031
      OnExecute = actCancelExecute
    end
  end
end
