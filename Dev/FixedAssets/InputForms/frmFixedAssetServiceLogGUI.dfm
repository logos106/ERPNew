inherited ServiceLogGUI: TServiceLogGUI
  Left = 325
  Top = 122
  HelpContext = 493000
  Caption = 'Service Log Entry'
  ClientHeight = 507
  ClientWidth = 505
  OldCreateOrder = True
  ExplicitLeft = 325
  ExplicitTop = 122
  ExplicitWidth = 513
  ExplicitHeight = 534
  DesignSize = (
    505
    507)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 32
    Top = 104
    Width = 441
    Height = 207
    HelpContext = 493002
    Shape = bsFrame
  end
  object Label1: TLabel [1]
    Left = 42
    Top = 236
    Width = 105
    Height = 16
    HelpContext = 493003
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Next Service'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object Label3: TLabel [2]
    Left = 32
    Top = 317
    Width = 81
    Height = 23
    HelpContext = 493004
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Service Notes'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object Label4: TLabel [3]
    Left = 59
    Top = 149
    Width = 88
    Height = 16
    HelpContext = 493005
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Service Date'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object Label5: TLabel [4]
    Left = 46
    Top = 182
    Width = 101
    Height = 16
    HelpContext = 493006
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Service Provider'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object Label7: TLabel [5]
    Left = 81
    Top = 66
    Width = 65
    Height = 23
    HelpContext = 493007
    AutoSize = False
    Caption = 'Asset Code'
    Transparent = True
    Layout = tlCenter
  end
  object Label8: TLabel [6]
    Left = 78
    Top = 117
    Width = 69
    Height = 16
    HelpContext = 493008
    AutoSize = False
    Caption = 'Asset Name'
    Transparent = True
    Layout = tlCenter
  end
  inherited lblSkingroupMsg: TLabel
    Top = 507
    Width = 505
    HelpContext = 493021
    ExplicitTop = 451
    ExplicitWidth = 506
  end
  inherited imgGridWatermark: TImage
    HelpContext = 493001
  end
  object Label2: TLabel [11]
    Left = 119
    Top = 277
    Width = 28
    Height = 16
    HelpContext = 493022
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Rep'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label6: TLabel [12]
    Left = 158
    Top = 215
    Width = 26
    Height = 15
    HelpContext = 493026
    Caption = 'Date'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object Label9: TLabel [13]
    Left = 299
    Top = 215
    Width = 42
    Height = 15
    HelpContext = 493027
    Caption = 'Hour(s)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object Label10: TLabel [14]
    Left = 386
    Top = 215
    Width = 34
    Height = 15
    HelpContext = 493028
    Caption = 'Km(s)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object Label11: TLabel [15]
    Left = 407
    Top = 278
    Width = 29
    Height = 15
    HelpContext = 493023
    Caption = 'Done'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object cboAssetCode: TwwDBLookupCombo [16]
    Left = 157
    Top = 67
    Width = 181
    Height = 23
    HelpContext = 493012
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AssetCode'#9'15'#9'AssetCode'#9'F'
      'AssetName'#9'20'#9'AssetName'#9'F')
    DataField = 'AssetCode'
    DataSource = DSServicelog
    LookupTable = qryAssets
    LookupField = 'AssetCode'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 0
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboAssetCodeCloseUp
  end
  object DBEdit2: TDBEdit [17]
    Left = 158
    Top = 181
    Width = 301
    Height = 23
    HelpContext = 493013
    DataField = 'ServiceProvider'
    DataSource = DSServicelog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object AssetName: TDBEdit [18]
    Left = 158
    Top = 117
    Width = 181
    Height = 23
    HelpContext = 493014
    DataField = 'AssetName'
    DataSource = DSServicelog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object wwDBDateTimePicker1: TwwDBDateTimePicker [19]
    Left = 158
    Top = 149
    Width = 121
    Height = 23
    HelpContext = 493015
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'ServiceDate'
    DataSource = DSServicelog
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 2
  end
  object DBMemo1: TDBMemo [20]
    Left = 32
    Top = 336
    Width = 440
    Height = 121
    HelpContext = 493016
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataField = 'ServiceNotes'
    DataSource = DSServicelog
    TabOrder = 9
  end
  object cmdOk: TDNMSpeedButton [21]
    Left = 76
    Top = 470
    Width = 87
    Height = 27
    HelpContext = 493017
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 10
    OnClick = cmdOkClick
  end
  object pnlTitle: TDNMPanel [22]
    Left = 130
    Top = 7
    Width = 237
    Height = 45
    HelpContext = 493018
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 233
      Height = 41
      HelpContext = 493019
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
        Height = 41
        HelpContext = 493020
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Service Log'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 234
      end
    end
  end
  object cboPurchDate: TwwDBDateTimePicker [23]
    Left = 158
    Top = 233
    Width = 121
    Height = 23
    HelpContext = 493011
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'NextServiceDate'
    DataSource = DSServicelog
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 4
  end
  object cmdCancel: TDNMSpeedButton [24]
    Left = 336
    Top = 470
    Width = 87
    Height = 27
    HelpContext = 493010
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 12
    OnClick = cmdCancelClick
  end
  object cmdNew: TDNMSpeedButton [25]
    Left = 206
    Top = 470
    Width = 87
    Height = 27
    HelpContext = 493009
    Anchors = [akBottom]
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
    TabOrder = 11
    OnClick = cmdNewClick
  end
  object cboRep: TwwDBLookupCombo [26]
    Left = 158
    Top = 274
    Width = 121
    Height = 23
    HelpContext = 493024
    TabStop = False
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'EmployeeName'#9'40'#9'EmployeeName'#9'T')
    DataField = 'EmployeeName'
    DataSource = DSServicelog
    LookupTable = qryRep
    LookupField = 'EmployeeName'
    Style = csDropDownList
    DropDownWidth = 430
    ParentFont = False
    TabOrder = 7
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboRepCloseUp
  end
  object DBEdit1: TDBEdit [27]
    Left = 299
    Top = 233
    Width = 73
    Height = 23
    HelpContext = 493029
    DataField = 'HoursFornextService'
    DataSource = DSServicelog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object DBEdit3: TDBEdit [28]
    Left = 386
    Top = 233
    Width = 73
    Height = 23
    HelpContext = 493030
    DataField = 'KmsForNextService'
    DataSource = DSServicelog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object chkActive: TwwCheckBox [29]
    Left = 445
    Top = 278
    Width = 14
    Height = 15
    HelpContext = 493025
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
    NullAndBlankState = cbUnchecked
    Caption = 'done'
    DataField = 'done'
    DataSource = DSServicelog
    TabOrder = 8
  end
  inherited MyConnection: TERPConnection

    Server = 'localhost'
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102007C007C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 434
    Top = 0
  end
  object qryServicelog: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblfixedassetservicelog'
      'Where ServiceID =:ID;')
    AfterInsert = qryServicelogAfterInsert
    Left = 370
    Top = 65534
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryServicelogServiceID: TAutoIncField
      FieldName = 'ServiceID'
      ReadOnly = True
    end
    object qryServicelogAssetID: TIntegerField
      FieldName = 'AssetID'
    end
    object qryServicelogAssetCode: TWideStringField
      FieldName = 'AssetCode'
      Size = 50
    end
    object qryServicelogAssetName: TWideStringField
      FieldName = 'AssetName'
      Size = 255
    end
    object qryServicelogServiceProvider: TWideStringField
      FieldName = 'ServiceProvider'
      Size = 255
    end
    object qryServicelogServiceDate: TDateField
      FieldName = 'ServiceDate'
    end
    object qryServicelogNextServiceDate: TDateField
      FieldName = 'NextServiceDate'
    end
    object qryServicelogServiceNotes: TWideMemoField
      FieldName = 'ServiceNotes'
      BlobType = ftWideMemo
    end
    object qryServicelogemployeeID: TIntegerField
      FieldName = 'employeeID'
    end
    object qryServicelogEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 100
    end
    object qryServicelogCreationDate: TDateTimeField
      FieldName = 'CreationDate'
    end
    object qryServicelogHoursFornextService: TIntegerField
      FieldName = 'HoursFornextService'
    end
    object qryServicelogKmsForNextService: TIntegerField
      FieldName = 'KmsForNextService'
    end
    object qryServicelogDone: TWideStringField
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
  end
  object DSServicelog: TDataSource
    DataSet = qryServicelog
    Left = 371
    Top = 28
  end
  object qryAssets: TERPQuery
    SQL.Strings = (
      'SELECT AssetID, AssetCode, AssetName  FROM tblfixedassets')
    Left = 402
    Top = 65534
    object qryAssetsAssetCode: TWideStringField
      DisplayWidth = 15
      FieldName = 'AssetCode'
      Size = 50
    end
    object qryAssetsAssetName: TWideStringField
      DisplayWidth = 20
      FieldName = 'AssetName'
      Size = 255
    end
    object qryAssetsAssetID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'AssetID'
      ReadOnly = True
      Visible = False
    end
  end
  object qryRep: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeID, EmployeeName '
      'FROM tblemployees'
      'ORDER BY EmployeeName')
    Left = 477
    Top = 2
    object qryRepEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryRepEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
  end
end
