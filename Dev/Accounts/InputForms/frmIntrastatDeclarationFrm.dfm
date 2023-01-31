inherited frmIntrastatDeclaration: TfrmIntrastatDeclaration
  Left = 1245
  Top = 188
  HelpContext = 299000
  Caption = 'Intrastat Supplementary Declaration'
  ClientHeight = 556
  ClientWidth = 1003
  OldCreateOrder = True
  ExplicitLeft = 1245
  ExplicitTop = 188
  ExplicitWidth = 1019
  ExplicitHeight = 595
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 556
    Width = 1003
    ExplicitTop = 556
    ExplicitWidth = 1003
    HelpContext = 299026
  end
  object Label3: TLabel [1]
    Left = 814
    Top = 27
    Width = 69
    Height = 15
    HelpContext = 299002
    Caption = 'Intrastat No.'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 299001
  end
  object cboType: TwwDBComboBox [6]
    Left = 116
    Top = 72
    Width = 145
    Height = 23
    HelpContext = 299015
    ShowButton = True
    Style = csDropDown
    MapList = False
    AllowClearKey = False
    DataField = 'IntrastatType'
    DataSource = DSIntrastats
    DropDownCount = 8
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    Items.Strings = (
      'Arrivals'
      'Dispatches')
    ParentFont = False
    Sorted = False
    TabOrder = 3
    UnboundDataType = wwDefault
    OnCloseUp = cboTypeCloseUp
  end
  object cboSubmitDate: TwwDBDateTimePicker [7]
    Left = 807
    Top = 72
    Width = 121
    Height = 23
    HelpContext = 299016
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'SubmittedDate'
    DataSource = DSIntrastats
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 4
    OnCloseUp = cboSubmitDateCloseUp
  end
  object DNMPanel1: TDNMPanel [8]
    Left = 12
    Top = 116
    Width = 982
    Height = 373
    HelpContext = 299017
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object grdLines: TwwDBGrid
      Left = 7
      Top = 7
      Width = 968
      Height = 359
      HelpContext = 299018
      ControlType.Strings = (
        'Country;CustomEdit;cboCountries;F'
        'DeliveryTerms;CustomEdit;cboDeliveryTerms;F'
        'ProductName;CustomEdit;cboProductID;F')
      Selected.Strings = (
        'GlobalRef'#9'15'#9'GlobalRef'#9'F'#9
        'CommodityCode'#9'8'#9'Commodity Code'#9'F'#9
        'ProductName'#9'25'#9'ProductName'#9'F'#9
        'Value'#9'10'#9'Value'#9#9
        'DeliveryTerms'#9'15'#9'Delivery Terms'#9'F'#9
        'TransactionNature'#9'15'#9'Transaction Nature'#9'F'#9
        'NetMass'#9'10'#9'NetMass'#9#9
        'SupplementaryUnit'#9'15'#9'Supplementary Unit'#9'F'#9
        'Country'#9'15'#9'Country'#9'F'#9
        'TraderRef'#9'20'#9'Trader Reference'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = DSIntrastatLines
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnDblClick = grdLinesDblClick
      FooterColor = clWhite
      FooterCellColor = clWhite
      object grdLinesButton: TwwIButton
        Left = 0
        Top = 0
        Width = 25
        Height = 22
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
        OnClick = grdLinesButtonClick
        HelpContext = 299027
      end
    end
    object cboCountries: TwwDBLookupCombo
      Left = 424
      Top = 72
      Width = 30
      Height = 23
      AutoSize = False
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'CountryName'#9'20'#9'CountryName'#9'F')
      DataField = 'Country'
      DataSource = DSIntrastatLines
      LookupTable = qryEuCountries
      LookupField = 'CountryName'
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      HelpContext = 299028
    end
    object cboDeliveryTerms: TwwDBComboBox
      Left = 656
      Top = 72
      Width = 121
      Height = 23
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'DeliveryTerms'
      DataSource = DSIntrastatLines
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'CFR'
        'CIF'
        'CIP'
        'CPT'
        'DAF'
        'DDP'
        'DDU'
        'DEQ'
        'DES'
        'EXW'
        'FAS'
        'FCA'
        'FOB'
        'XXX')
      ParentFont = False
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
      HelpContext = 299029
    end
    object cboProductID: TwwDBLookupCombo
      Left = 216
      Top = 120
      Width = 129
      Height = 23
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PartName'#9'20'#9'PartName'#9'F')
      DataField = 'ProductID'
      DataSource = DSIntrastatLines
      LookupTable = qryProducts
      LookupField = 'PartName'
      TabOrder = 3
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnDblClick = cboProductIDDblClick
      OnCloseUp = cboProductIDCloseUp
      HelpContext = 299030
    end
  end
  object btnPrint: TDNMSpeedButton [9]
    Left = 611
    Top = 523
    Width = 87
    Height = 27
    HelpContext = 299019
    Anchors = [akBottom]
    Caption = 'Prin&t'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    TabOrder = 8
    OnClick = btnPrintClick
  end
  object btnLoadInvoiceLines: TDNMSpeedButton [10]
    Left = 296
    Top = 523
    Width = 87
    Height = 27
    HelpContext = 299020
    Anchors = [akBottom]
    Caption = 'Load Invoices'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    TabOrder = 9
    OnClick = btnLoadInvoiceLinesClick
  end
  object btnLoadPOs: TDNMSpeedButton [11]
    Left = 296
    Top = 523
    Width = 87
    Height = 27
    HelpContext = 299021
    Anchors = [akBottom]
    Caption = 'Load POs'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    TabOrder = 10
    OnClick = btnLoadPOsClick
  end
  object chkSubmitted: TwwCheckBox [12]
    Left = 643
    Top = 61
    Width = 82
    Height = 17
    HelpContext = 299022
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
    Caption = 'Submitted'
    DataField = 'IsSubmitted'
    DataSource = DSIntrastats
    TabOrder = 5
    Visible = False
  end
  object edIntrastatID: TwwDBEdit [13]
    Left = 891
    Top = 24
    Width = 89
    Height = 23
    HelpContext = 299023
    DataField = 'IntrastatID'
    DataSource = DSIntrastats
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object pnlPrint: TDNMPanel [14]
    Left = 584
    Top = 494
    Width = 140
    Height = 25
    HelpContext = 299024
    Anchors = [akLeft, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    object chkPreview: TwwCheckBox
      Left = 19
      Top = 4
      Width = 103
      Height = 17
      HelpContext = 299025
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Show Preview'
      TabOrder = 0
    end
  end
  object btnElectronic: TDNMSpeedButton [15]
    Left = 426
    Top = 523
    Width = 137
    Height = 27
    Caption = 'Electronic Submission'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 13
    Visible = False
    OnClick = btnElectronicClick
    HelpContext = 299031
  end
  object btnCancel: TDNMSpeedButton [16]
    Left = 754
    Top = 523
    Width = 87
    Height = 27
    HelpContext = 299010
    Anchors = [akRight, akBottom]
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
    TabOrder = 0
    OnClick = btnCancelClick
  end
  object DNMPanel2: TDNMPanel [17]
    Left = 13
    Top = 61
    Width = 980
    Height = 47
    HelpContext = 299003
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object Label1: TLabel
      Left = 702
      Top = 17
      Width = 87
      Height = 15
      HelpContext = 299004
      Caption = 'Date Submitted'
      Transparent = True
    end
    object Label2: TLabel
      Left = 67
      Top = 17
      Width = 26
      Height = 15
      HelpContext = 299005
      Caption = 'Type'
      Transparent = True
    end
    object Label4: TLabel
      Left = 267
      Top = 17
      Width = 35
      Height = 15
      HelpContext = 299006
      Caption = 'Month'
      Transparent = True
    end
    object Label5: TLabel
      Left = 476
      Top = 16
      Width = 25
      Height = 15
      HelpContext = 299007
      Caption = 'Year'
      Transparent = True
    end
    object cboMonth: TwwDBComboBox
      Left = 312
      Top = 11
      Width = 122
      Height = 23
      HelpContext = 299008
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'Month'
      DataSource = DSIntrastats
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'January'
        'February'
        'March'
        'April'
        'May'
        'June'
        'July'
        'August'
        'September'
        'October'
        'November'
        'December')
      ParentFont = False
      Sorted = False
      TabOrder = 0
      UnboundDataType = wwDefault
      OnCloseUp = cboMonthCloseUp
    end
    object edYear: TwwDBEdit
      Left = 512
      Top = 11
      Width = 65
      Height = 23
      HelpContext = 299009
      DataField = 'Year'
      DataSource = DSIntrastats
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
      OnChange = edYearChange
    end
  end
  object pnlTitle: TDNMPanel [18]
    Left = 336
    Top = 6
    Width = 392
    Height = 45
    HelpContext = 299011
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 388
      Height = 41
      HelpContext = 299012
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
        Width = 388
        Height = 41
        HelpContext = 299013
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Intrastat Declaration'
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
  object btnOK: TDNMSpeedButton [19]
    Left = 158
    Top = 523
    Width = 87
    Height = 27
    HelpContext = 299014
    Anchors = [akBottom]
    Caption = 'Save'
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
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    OnClick = btnOKClick
  end
  inherited popSpelling: TPopupMenu
    Left = 168
    Top = 8
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 265
    Top = 0
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 203
    Top = 8
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200A000B40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 66
    Top = 24
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 238
    Top = 8
  end
  inherited qryMemTrans: TERPQuery
    Left = 133
    Top = 16
  end
  object DSIntrastats: TDataSource
    DataSet = qryIntrastats
    Left = 240
    Top = 16
  end
  object qryIntrastats: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblintrastats')
    Left = 280
    Top = 16
    object qryIntrastatsIntrastatID: TIntegerField
      DisplayWidth = 10
      FieldName = 'IntrastatID'
    end
    object qryIntrastatsIntrastatType: TWideStringField
      DisplayWidth = 10
      FieldName = 'IntrastatType'
      FixedChar = True
      Size = 10
    end
    object qryIntrastatsIsSubmitted: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsSubmitted'
      FixedChar = True
      Size = 1
    end
    object qryIntrastatsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryIntrastatsSubmittedDate: TDateField
      FieldName = 'SubmittedDate'
    end
    object qryIntrastatsMonth: TWideStringField
      FieldName = 'Month'
      Size = 255
    end
    object qryIntrastatsYear: TIntegerField
      FieldName = 'Year'
    end
    object qryIntrastatsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryIntrastatsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object qryIntrastatLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblintrastatlines')
    Left = 744
    object qryIntrastatLinesGlobalRef: TWideStringField
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryIntrastatLinesCommodityCode: TWideStringField
      DisplayLabel = 'Commodity Code'
      DisplayWidth = 8
      FieldName = 'CommodityCode'
      Size = 8
    end
    object qryIntrastatLinesProductName: TWideStringField
      DisplayWidth = 25
      FieldKind = fkLookup
      FieldName = 'ProductName'
      LookupDataSet = qryProducts
      LookupKeyFields = 'PartsId'
      LookupResultField = 'PartName'
      KeyFields = 'ProductID'
      Size = 255
      Lookup = True
    end
    object qryIntrastatLinesValue: TFloatField
      DisplayWidth = 10
      FieldName = 'Value'
      currency = True
    end
    object qryIntrastatLinesDeliveryTerms: TWideStringField
      DisplayLabel = 'Delivery Terms'
      DisplayWidth = 15
      FieldName = 'DeliveryTerms'
      Size = 255
    end
    object qryIntrastatLinesTransactionNature: TWideStringField
      DisplayLabel = 'Transaction Nature'
      DisplayWidth = 15
      FieldName = 'TransactionNature'
      Size = 255
    end
    object qryIntrastatLinesNetMass: TIntegerField
      DisplayWidth = 10
      FieldName = 'NetMass'
    end
    object qryIntrastatLinesSupplementaryUnit: TWideStringField
      DisplayLabel = 'Supplementary Unit'
      DisplayWidth = 15
      FieldName = 'SupplementaryUnit'
      Size = 255
    end
    object qryIntrastatLinesCountry: TWideStringField
      DisplayWidth = 15
      FieldName = 'Country'
      Size = 255
    end
    object qryIntrastatLinesTraderRef: TWideStringField
      DisplayLabel = 'Trader Reference'
      DisplayWidth = 20
      FieldName = 'TraderRef'
      Size = 255
    end
    object qryIntrastatLinesProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object qryIntrastatLinesIntrastatID: TIntegerField
      DisplayWidth = 10
      FieldName = 'IntrastatID'
      Visible = False
    end
    object qryIntrastatLinesIntrastatLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'IntrastatLineID'
      Visible = False
    end
    object qryIntrastatLinesInvoiceOrPOLineID: TIntegerField
      FieldName = 'InvoiceOrPOLineID'
    end
    object qryIntrastatLinesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryIntrastatLinesmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object DSIntrastatLines: TDataSource
    DataSet = qryIntrastatLines
    Left = 744
    Top = 32
  end
  object qryEuCountries: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tbleucountries')
    Left = 792
  end
  object qryInvoicelines: TERPQuery
    SQL.Strings = (
      
        'Select SL.SaleID,SL.ProductID,SL.TotalLineAmount,S.SaleID,S.IsIn' +
        'voice,S.InvoiceDocNumber,S.ClientID,SL.SaleLineId,'
      
        'C.IncludeOnIntrastat,P.PartsID,P.CommodityCode,SL.QtySold,S.Ship' +
        'Date,P.NetWeightKg * SL.QtySold AS NetWeight,'
      'C.Country'
      'From tblsaleslines SL'
      'INNER JOIN tblsales S on s.saleid = sl.saleid'
      'INNER JOIN tblparts P on P.PartsID = SL.ProductID'
      'INNER JOIN tblclients C on C.ClientID = S.ClientID'
      'where S.IsInvoice = '#39'T'#39' AND C.IncludeOnIntrastat = '#39'T'#39
      'AND S.ShipDate BETWEEN :xFrom AND :xTo')
    Left = 832
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xFrom'
      end
      item
        DataType = ftUnknown
        Name = 'xTo'
      end>
    object qryInvoicelinesSaleID: TIntegerField
      FieldName = 'SaleID'
    end
    object qryInvoicelinesProductID: TIntegerField
      FieldName = 'ProductID'
    end
    object qryInvoicelinesTotalLineAmount: TFloatField
      FieldName = 'TotalLineAmount'
    end
    object qryInvoicelinesSaleID_1: TIntegerField
      FieldName = 'SaleID_1'
    end
    object qryInvoicelinesIsInvoice: TWideStringField
      FieldName = 'IsInvoice'
      FixedChar = True
      Size = 1
    end
    object qryInvoicelinesInvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      Size = 30
    end
    object qryInvoicelinesClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryInvoicelinesIncludeOnIntrastat: TWideStringField
      FieldName = 'IncludeOnIntrastat'
      FixedChar = True
      Size = 1
    end
    object qryInvoicelinesPartsID: TIntegerField
      FieldName = 'PartsID'
    end
    object qryInvoicelinesCommodityCode: TWideStringField
      FieldName = 'CommodityCode'
      Size = 8
    end
    object qryInvoicelinesQtySold: TFloatField
      FieldName = 'QtySold'
    end
    object qryInvoicelinesShipDate: TDateField
      FieldName = 'ShipDate'
    end
    object qryInvoicelinesNetWeight: TFloatField
      FieldName = 'NetWeight'
    end
    object qryInvoicelinesCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryInvoicelinesSaleLineId: TIntegerField
      FieldName = 'SaleLineId'
    end
  end
  object qryPOs: TERPQuery
    SQL.Strings = (
      'Select * From tblpurchasesorders')
    Left = 880
  end
  object qryPOLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select PL.PurchaseOrderID,PL.ProductID,PL.TotalLineAmount,P.Purc' +
        'haseOrderID,P.IsPO,P.PurchaseOrderNumber,P.ClientID,'
      
        'C.IncludeOnIntrastat,PA.PartsID,PA.CommodityCode,PL.ReceivedDate' +
        ',PL.Shipped,PA.NetWeightKg * PL.Shipped AS NetWeight,'
      'C.Country,C.Company,PL.PurchaseLineID'
      'From tblpurchaselines PL'
      
        'INNER JOIN tblPurchaseOrders P on P.purchaseOrderId = PL.Purchas' +
        'eOrderid'
      'INNER JOIN tblparts PA on PA.PartsID = PL.ProductID'
      'INNER JOIN tblclients C on C.ClientID = P.ClientID'
      
        'where P.IsPO = '#39'T'#39' AND C.IncludeOnIntrastat = '#39'T'#39' AND PL.Shipped' +
        ' > 0'
      'AND PL.ReceivedDate BETWEEN :xFrom AND :xTo')
    Left = 928
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xFrom'
      end
      item
        DataType = ftUnknown
        Name = 'xTo'
      end>
    object qryPOLinesPurchaseOrderID: TIntegerField
      FieldName = 'PurchaseOrderID'
    end
    object qryPOLinesProductID: TIntegerField
      FieldName = 'ProductID'
    end
    object qryPOLinesTotalLineAmount: TFloatField
      FieldName = 'TotalLineAmount'
    end
    object qryPOLinesPurchaseOrderID_1: TIntegerField
      FieldName = 'PurchaseOrderID_1'
    end
    object qryPOLinesIsPO: TWideStringField
      FieldName = 'IsPO'
      FixedChar = True
      Size = 1
    end
    object qryPOLinesPurchaseOrderNumber: TWideStringField
      FieldName = 'PurchaseOrderNumber'
      Size = 30
    end
    object qryPOLinesClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryPOLinesIncludeOnIntrastat: TWideStringField
      FieldName = 'IncludeOnIntrastat'
      FixedChar = True
      Size = 1
    end
    object qryPOLinesPartsID: TIntegerField
      FieldName = 'PartsID'
    end
    object qryPOLinesCommodityCode: TWideStringField
      FieldName = 'CommodityCode'
      Size = 8
    end
    object qryPOLinesReceivedDate: TDateField
      FieldName = 'ReceivedDate'
    end
    object qryPOLinesShipped: TFloatField
      FieldName = 'Shipped'
    end
    object qryPOLinesNetWeight: TFloatField
      FieldName = 'NetWeight'
    end
    object qryPOLinesCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryPOLinesCompany: TWideStringField
      FieldName = 'Company'
      Size = 80
    end
    object qryPOLinesPurchaseLineID: TIntegerField
      FieldName = 'PurchaseLineID'
    end
  end
  object DSPOLines: TDataSource
    DataSet = qryPOLines
    Left = 968
    Top = 8
  end
  object qryProducts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PartsId,PartName,Active '
      'FROM tblparts'
      'WHERE Active = '#39'T'#39
      'ORDER BY PartName')
    Left = 808
    Top = 48
    object qryProductsPartName: TWideStringField
      DisplayWidth = 20
      FieldName = 'PartName'
      Size = 60
    end
    object qryProductsPartsId: TIntegerField
      FieldName = 'PartsId'
      Visible = False
    end
    object qryProductsActive: TWideStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
end
