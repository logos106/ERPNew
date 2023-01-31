inherited fmBankStatmentImport: TfmBankStatmentImport
  Caption = 'Bank Transaction Import'
  ClientHeight = 521
  ClientWidth = 647
  ExplicitWidth = 653
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1625002
  object Bevel1: TBevel [0]
    Left = 33
    Top = 276
    Width = 606
    Height = 196
    HelpContext = 1625003
  end
  inherited lblSkingroupMsg: TLabel
    Top = 521
    Width = 647
    ExplicitTop = 412
    ExplicitWidth = 590
    HelpContext = 1625004
  end
  inherited shapehint: TShape
    Left = 0
    ExplicitLeft = -1
  end
  inherited imgGridWatermark: TImage
    Left = 433
    Top = -5
    ExplicitLeft = 433
    ExplicitTop = -5
  end
  inherited shapehintextra1: TShape
    Left = 31
    ExplicitLeft = 27
  end
  object Label1: TLabel [6]
    Left = 27
    Top = 112
    Width = 78
    Height = 15
    AutoSize = False
    Caption = 'Input File'
    HelpContext = 1625005
  end
  object Label2: TLabel [7]
    Left = 27
    Top = 80
    Width = 78
    Height = 15
    AutoSize = False
    Caption = 'Bank Account'
    HelpContext = 1625006
  end
  object Label3: TLabel [8]
    Left = 46
    Top = 283
    Width = 131
    Height = 15
    Caption = 'Import File Data Format'
    HelpContext = 1625007
  end
  object Label11: TLabel [9]
    Left = 27
    Top = 147
    Width = 58
    Height = 15
    Caption = 'Date From'
    HelpContext = 1625008
  end
  object Label12: TLabel [10]
    Left = 283
    Top = 146
    Width = 42
    Height = 15
    Caption = 'Date To'
    HelpContext = 1625009
  end
  object pnlTitle: TDNMPanel [11]
    Left = 115
    Top = 25
    Width = 418
    Height = 40
    Anchors = []
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    HelpContext = 1625010
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 414
      Height = 36
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
      HelpContext = 1625011
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 414
        Height = 36
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Bank Transaction Import'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 187
        HelpContext = 1625012
      end
    end
  end
  object cmdOk: TDNMSpeedButton [12]
    Left = 215
    Top = 486
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'Import'
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
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = cmdOkClick
    HelpContext = 1625013
  end
  object cmdCancel: TDNMSpeedButton [13]
    Left = 345
    Top = 486
    Width = 87
    Height = 27
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
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = cmdCancelClick
    HelpContext = 1625014
  end
  object edtInputFile: TEdit [14]
    Left = 120
    Top = 109
    Width = 473
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnChange = edtInputFileChange
    HelpContext = 1625015
  end
  object btnSelectFile: TButton [15]
    Left = 589
    Top = 109
    Width = 24
    Height = 24
    Caption = '...'
    TabOrder = 4
    OnClick = btnSelectFileClick
    HelpContext = 1625016
  end
  object cboBankAccount: TwwDBLookupCombo [16]
    Left = 120
    Top = 77
    Width = 217
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    LookupTable = qryBankAccountLookup
    LookupField = 'AccountName'
    ParentFont = False
    TabOrder = 5
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnChange = cboBankAccountChange
    HelpContext = 1625017
  end
  object memSample: TMemo [17]
    Left = 33
    Top = 178
    Width = 606
    Height = 87
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssHorizontal
    TabOrder = 6
    HelpContext = 1625018
  end
  object chkAutoDetect: TwwCheckBox [18]
    Left = 46
    Top = 311
    Width = 169
    Height = 17
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Auto Detect'
    DataField = 'AutoDetect'
    DataSource = dsFormat
    TabOrder = 7
    OnClick = chkAutoDetectClick
    HelpContext = 1625019
  end
  object pnlConfig: TDNMPanel [19]
    Left = 46
    Top = 337
    Width = 585
    Height = 135
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    HelpContext = 1625020
    object Label4: TLabel
      Left = 0
      Top = 37
      Width = 117
      Height = 15
      Caption = 'Separator Character'
      HelpContext = 1625021
    end
    object Label5: TLabel
      Left = 0
      Top = 68
      Width = 69
      Height = 15
      Caption = 'Date Format'
      HelpContext = 1625022
    end
    object Label6: TLabel
      Left = 1
      Top = 99
      Width = 90
      Height = 15
      Caption = 'Date Column No'
      HelpContext = 1625023
    end
    object Label7: TLabel
      Left = 345
      Top = 6
      Width = 145
      Height = 15
      Caption = 'Credit Amount Column No'
      HelpContext = 1625024
    end
    object lblDebitColumnNo: TLabel
      Left = 345
      Top = 37
      Width = 140
      Height = 15
      Caption = 'Debit Amount Column No'
      HelpContext = 1625025
    end
    object Label8: TLabel
      Left = 345
      Top = 62
      Width = 191
      Height = 30
      Caption = '( These should match for a single Amount column )'
      Enabled = False
      WordWrap = True
      HelpContext = 1625026
    end
    object Label9: TLabel
      Left = 345
      Top = 99
      Width = 129
      Height = 15
      Caption = 'Description Column No'
      HelpContext = 1625027
    end
    object Label10: TLabel
      Left = 229
      Top = 67
      Width = 97
      Height = 15
      Caption = '( eg dd/mm/yyyy )'
      Enabled = False
      HelpContext = 1625028
    end
    object chkFirstLineColumnNames: TwwCheckBox
      Left = 0
      Top = 6
      Width = 169
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'First Line Column Names'
      DataField = 'FirstLineColumnNames'
      DataSource = dsFormat
      TabOrder = 0
      HelpContext = 1625029
    end
    object edtDateFormat: TwwDBEdit
      Left = 136
      Top = 65
      Width = 87
      Height = 23
      DataField = 'DateFormat'
      DataSource = dsFormat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 1625030
    end
    object wwDBEdit2: TwwDBEdit
      Left = 136
      Top = 96
      Width = 48
      Height = 23
      DataField = 'DateColumnNo'
      DataSource = dsFormat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 1625031
    end
    object edtCreditColumnNo: TwwDBEdit
      Left = 504
      Top = 1
      Width = 48
      Height = 23
      DataField = 'CreditColumnNo'
      DataSource = dsFormat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 1625032
    end
    object edtDebitColumnNo: TwwDBEdit
      Left = 504
      Top = 34
      Width = 48
      Height = 23
      DataField = 'DebitColumnNo'
      DataSource = dsFormat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      HelpContext = 1625033
    end
    object wwDBEdit3: TwwDBEdit
      Left = 504
      Top = 96
      Width = 48
      Height = 23
      DataField = 'DescriptionColumnNo'
      DataSource = dsFormat
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
      HelpContext = 1625034
    end
    object edtSeperator: TwwDBComboBox
      Left = 136
      Top = 34
      Width = 87
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = True
      AllowClearKey = False
      DataField = 'Seperator'
      DataSource = dsFormat
      DropDownCount = 8
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Comma'#9','
        'Tab'#9'#9')
      ParentFont = False
      Sorted = False
      TabOrder = 6
      UnboundDataType = wwDefault
      HelpContext = 1625035
    end
  end
  object dtFrom: TDateTimePicker [20]
    Left = 120
    Top = 142
    Width = 121
    Height = 23
    Date = 43249.357481747680000000
    Time = 43249.357481747680000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    HelpContext = 1625036
  end
  object dtTo: TDateTimePicker [21]
    Left = 376
    Top = 142
    Width = 121
    Height = 23
    Date = 43249.357481747680000000
    Time = 43249.357481747680000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    HelpContext = 1625037
  end
  inherited tmrProcessMessage: TTimer
    Left = 468
    Top = 65528
  end
  inherited tmrdelay: TTimer
    Left = 504
    Top = 65528
  end
  inherited popSpelling: TPopupMenu
    Left = 152
    Top = 65528
  end
  inherited tmrdelayMsg: TTimer
    Left = 128
    Top = 65520
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 257
    Top = 65528
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 293
    Top = 65528
  end
  inherited DataState: TDataState
    Left = 328
    Top = 65528
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 187
    Top = 65528
  end
  inherited imgsort: TImageList
    Left = 363
    Top = 65528
    Bitmap = {
      494C010102004801080210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 82
    Top = 65528
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 398
    Top = 65528
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 222
    Top = 65528
  end
  inherited qryMemTrans: TERPQuery
    Left = 117
    Top = 65528
  end
  object OpenDialog: TOpenDialog
    Filter = 'Comma-seperated values|*.csv|All Files|*.*'
    Left = 550
    Top = 152
  end
  object qryBankAccountLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select * from tblchartofaccounts where AccountType = "Bank" and ' +
        'Active = "T"')
    Left = 600
    Top = 56
  end
  object qryFormat: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblbankstatementimportformat')
    Left = 536
    Top = 8
    object qryFormatGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryFormatID: TIntegerField
      FieldName = 'ID'
    end
    object qryFormatAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qryFormatAutoDetect: TWideStringField
      FieldName = 'AutoDetect'
      FixedChar = True
      Size = 1
    end
    object qryFormatFirstLineColumnNames: TWideStringField
      FieldName = 'FirstLineColumnNames'
      FixedChar = True
      Size = 1
    end
    object qryFormatSeperator: TWideStringField
      FieldName = 'Seperator'
      Size = 255
    end
    object qryFormatDateColumnNo: TIntegerField
      FieldName = 'DateColumnNo'
    end
    object qryFormatDebitColumnNo: TIntegerField
      FieldName = 'DebitColumnNo'
    end
    object qryFormatCreditColumnNo: TIntegerField
      FieldName = 'CreditColumnNo'
    end
    object qryFormatDescriptionColumnNo: TIntegerField
      FieldName = 'DescriptionColumnNo'
    end
    object qryFormatDateFormat: TWideStringField
      FieldName = 'DateFormat'
      Size = 255
    end
    object qryFormatmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryFormatmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object dsFormat: TDataSource
    DataSet = qryFormat
    Left = 576
    Top = 16
  end
end
