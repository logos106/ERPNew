inherited JournalEntryGUI: TJournalEntryGUI
  Left = 91
  Top = 346
  HelpContext = 380000
  Caption = 'Journal Entry'
  ClientHeight = 542
  ClientWidth = 825
  OldCreateOrder = True
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 831
  DesignSize = (
    825
    542)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 33
    Top = 73
    Width = 35
    Height = 15
    HelpContext = 380002
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Date :'
    Transparent = True
  end
  object Label2: TLabel [1]
    Left = 13
    Top = 124
    Width = 55
    Height = 15
    HelpContext = 380003
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Entry No :'
    Transparent = True
  end
  object lbMemTrans: TLabel [2]
    Left = 578
    Top = 4
    Width = 145
    Height = 14
    HelpContext = 380004
    Anchors = [akTop, akRight]
    Caption = 'Right-Click to Memorise ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    PopupMenu = popMemTrans
    Transparent = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 542
    Width = 825
    HelpContext = 380018
    ExplicitTop = 542
    ExplicitWidth = 825
  end
  inherited imgGridWatermark: TImage
    HelpContext = 380001
  end
  object lblMsg: TLabel [7]
    Left = 16
    Top = 157
    Width = 707
    Height = 15
    HelpContext = 380030
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'lblMsg'
    Transparent = True
    Visible = False
  end
  object Label3: TLabel [9]
    Left = 512
    Top = 102
    Width = 55
    Height = 15
    HelpContext = 380031
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Memo :'
    Transparent = True
  end
  object btnPreview: TDNMSpeedButton [10]
    Left = 729
    Top = 110
    Width = 87
    Height = 26
    HelpContext = 380009
    Anchors = [akTop, akRight]
    Caption = 'Pre&view'
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
    TabOrder = 7
    AutoDisableParentOnclick = True
    OnClick = btnPreviewClick
  end
  object BtnNew: TDNMSpeedButton [11]
    Left = 729
    Top = 11
    Width = 87
    Height = 25
    HelpContext = 380010
    Anchors = [akTop, akRight]
    Caption = '&New'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 4
    AutoDisableParentOnclick = True
    OnClick = BtnNewClick
  end
  object btnClose: TDNMSpeedButton [12]
    Left = 729
    Top = 77
    Width = 87
    Height = 26
    HelpContext = 380011
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
    TabOrder = 6
    AutoDisableParentOnclick = True
    OnClick = btnCloseClick
  end
  object btnReconciled: TDNMSpeedButton [13]
    Left = 541
    Top = 22
    Width = 87
    Height = 27
    HelpContext = 380012
    Anchors = [akTop, akRight]
    Caption = 'Reconciled'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      55555555FFFFFFFF5555555000000005555555577777777FF555550999999900
      55555575555555775F55509999999901055557F55555557F75F5001111111101
      105577FFFFFFFF7FF75F00000000000011057777777777775F755070FFFFFF0F
      01105777F555557F75F75500FFFFFF0FF0105577F555FF7F57575550FF700008
      8F0055575FF7777555775555000888888F005555777FFFFFFF77555550000000
      0F055555577777777F7F555550FFFFFF0F05555557F5FFF57F7F555550F000FF
      0005555557F777557775555550FFFFFF0555555557F555FF7F55555550FF7000
      05555555575FF777755555555500055555555555557775555555}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 9
    TabStop = False
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = btnReconciledClick
  end
  object grdTransactions: TwwDBGrid [14]
    Left = 14
    Top = 177
    Width = 803
    Height = 357
    HelpContext = 380013
    LineStyle = glsSingle
    ControlType.Strings = (
      'AccountName;CustomEdit;cboAccountline;F'
      'TaxCode;CustomEdit;cboTaxCode;F'
      'ClientName;CustomEdit;cboCustomerJob;F'
      'ClassName;CustomEdit;cboClass;F'
      'AccountNumber;CustomEdit;cboAccountlNoLine;F'
      'EmployeeName;CustomEdit;cboEmployeeLookup;T'
      'AreaCode;CustomEdit;cboLinesAreaCode;F')
    Selected.Strings = (
      'AccountNumber'#9'15'#9'Account No'#9'F'#9
      'AccountName'#9'20'#9'Account (Full)'#9'F'#9
      'DebitAmount'#9'10'#9'Debit (Ex)'#9#9
      'DebitAmountInc'#9'10'#9'Debit (Inc)'#9#9
      'CreditAmount'#9'10'#9'Credit (Ex)'#9#9
      'CreditAmountInc'#9'10'#9'Credit (Inc)'#9#9
      'TaxCode'#9'7'#9'Tax'#9#9
      'TaxAmount'#9'10'#9'Tax Amount'#9'T'#9
      'Memo'#9'15'#9'Memo'#9#9
      'ClientName'#9'15'#9'Name'#9#9
      'ClassName'#9'15'#9'Class'#9#9
      'EmployeeName'#9'15'#9'Employee Name'#9'F'#9
      'EmployeeId'#9'10'#9'EmployeeId'#9'F'#9
      'AreaCode'#9'10'#9'Area'#9'F'#9
      'LinesOrder'#9'10'#9'Order by'#9'F')
    MemoAttributes = [mSizeable, mWordWrap, mGridShow]
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DSDetails
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = [dgAllowInsert]
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFooter3DCells, dgRowResize]
    ParentFont = False
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = True
    OnCalcCellColors = grdTransactionsCalcCellColors
    OnCalcTitleAttributes = grdTransactionsCalcTitleAttributes
    OnTitleButtonClick = grdTransactionsTitleButtonClick
    OnDblClick = grdTransactionsDblClick
    FooterColor = clWhite
    FooterCellColor = clWhite
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
    object btnDelete: TwwIButton
      Left = 0
      Top = 0
      Width = 20
      Height = 22
      HelpContext = 380019
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
  object cboTaxCode: TERPDbLookupCombo [15]
    Left = 60
    Top = 339
    Width = 63
    Height = 23
    HelpContext = 380020
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'name'#9'15'#9'name'#9'F'
      'Description'#9'30'#9'Description'#9'T'
      'Rate'#9'4'#9'Rate'#9'T')
    DataField = 'TaxCode'
    DataSource = DSDetails
    LookupTable = cboTaxCodeQry
    LookupField = 'name'
    Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
    DropDownCount = 5
    DropDownWidth = 350
    ParentFont = False
    TabOrder = 10
    AutoDropDown = True
    ShowButton = True
    OrderByDisplay = False
    PreciseEditRegion = False
    AllowClearKey = True
    LookupFormClassName = 'TTaxCodeListGUI'
    EditFormClassName = 'TfrmTaxcode'
    LookupFormKeyStringFieldName = 'Name'
    LookupComboType = ctTaxcode
    AllowFullListSearchMode = True
    DisableNotInList = False
    AllowMultipleSelectFromList = False
    OpenListinF6WhenNotinList = False
    DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
    LookupIDField = 'TaxCodeID'
    LookupFieldAlt = 'Description'
  end
  object cboClass: TwwDBLookupCombo [16]
    Left = 65
    Top = 310
    Width = 78
    Height = 23
    HelpContext = 380021
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taRightJustify
    DataField = 'ClassName'
    DataSource = DSDetails
    LookupTable = cboClassQry
    LookupField = 'ClassName'
    Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
    Style = csDropDownList
    DropDownWidth = 150
    ParentFont = False
    TabOrder = 11
    AutoDropDown = True
    ShowButton = True
    OrderByDisplay = False
    PreciseEditRegion = False
    AllowClearKey = True
  end
  object cboCustomerJob: TwwDBLookupCombo [17]
    Left = 63
    Top = 287
    Width = 88
    Height = 23
    HelpContext = 380022
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taRightJustify
    Selected.Strings = (
      'Company'#9'30'#9'Company'#9'T'
      'Type'#9'15'#9'Type'#9'T')
    DataField = 'ClientName'
    DataSource = DSDetails
    LookupTable = cboClientLookup
    LookupField = 'Company'
    Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
    Style = csDropDownList
    ParentFont = False
    TabOrder = 12
    AutoDropDown = True
    ShowButton = True
    OrderByDisplay = False
    PreciseEditRegion = False
    AllowClearKey = True
    OnNotInList = cboCustomerJobNotInList
  end
  object cboAccountline: TERPDbLookupCombo [18]
    Left = 62
    Top = 263
    Width = 111
    Height = 23
    HelpContext = 380023
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountName'#9'20'#9'AccountName'#9'F'
      'Type'#9'20'#9'Type'#9'F'
      'Description'#9'20'#9'Description'#9'F'
      'AccountTree'#9'25'#9'AccountTree'#9'F')
    DataField = 'AccountName'
    DataSource = DSDetails
    LookupTable = cboAccountLinesQry
    LookupField = 'AccountName'
    Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
    Style = csDropDownList
    DropDownWidth = 800
    ParentFont = False
    TabOrder = 13
    AutoDropDown = True
    ShowButton = True
    OrderByDisplay = False
    UseTFields = False
    PreciseEditRegion = False
    AllowClearKey = True
    LookupFormClassName = 'TChartOfAccountsListLookupGUI'
    EditFormClassName = 'TfrmChartOfAccounts'
    LookupFormKeyStringFieldName = 'AccountName'
    LookupComboType = ctAccount
    AllowFullListSearchMode = False
    DisableNotInList = False
    AllowMultipleSelectFromList = False
    OpenListinF6WhenNotinList = False
    DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
    LookupIDField = 'AccountID'
  end
  object cboAccountlNoLine: TERPDbLookupCombo [19]
    Left = 60
    Top = 234
    Width = 111
    Height = 23
    HelpContext = 380024
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountNumber'#9'9'#9'AccountNumber'#9'F'
      'AccountName'#9'50'#9'AccountName'#9'T'#9
      'AccountTree'#9'65'#9'AccountTree'#9'F'#9
      'Type'#9'40'#9'Type'#9'T'#9
      'Description'#9'50'#9'Description'#9'F')
    DataField = 'AccountNumber'
    DataSource = DSDetails
    LookupTable = cboAccountNoLinesQry
    LookupField = 'AccountNumber'
    Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
    Style = csDropDownList
    DropDownWidth = 600
    ParentFont = False
    TabOrder = 14
    AutoDropDown = True
    ShowButton = True
    OrderByDisplay = False
    PreciseEditRegion = False
    AllowClearKey = True
    LookupFormClassName = 'TChartOfAccountsListLookupGUI'
    EditFormClassName = 'TfrmChartOfAccounts'
    LookupFormKeyStringFieldName = 'Account No'
    LookupComboType = ctAccountNumber
    AllowFullListSearchMode = False
    DisableNotInList = False
    AllowMultipleSelectFromList = False
    OpenListinF6WhenNotinList = False
    DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
    LookupIDField = 'AccountID'
  end
  object cboEmployeeLookup: TwwDBLookupCombo [20]
    Left = 64
    Top = 368
    Width = 109
    Height = 18
    HelpContext = 380025
    AutoSize = False
    DropDownAlignment = taLeftJustify
    DataField = 'EmployeeName'
    DataSource = DSDetails
    LookupTable = qryEmployeeLookup
    LookupField = 'EmployeeName'
    TabOrder = 15
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = True
  end
  object btnCompleted: TDNMSpeedButton [21]
    Left = 730
    Top = 45
    Width = 87
    Height = 26
    HelpContext = 380014
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
    OnClick = btnCompletedClick
  end
  object pnlTitle: TDNMPanel [22]
    Left = 298
    Top = 6
    Width = 238
    Height = 45
    HelpContext = 380015
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 236
      Height = 43
      HelpContext = 380016
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
        Width = 236
        Height = 43
        HelpContext = 380017
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Journal Entry'
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
  object TransNo: TDBEdit [23]
    Left = 71
    Top = 121
    Width = 136
    Height = 23
    HelpContext = 380006
    AutoSize = False
    DataField = 'TransactionNo'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object cboDate: TwwDBDateTimePicker [24]
    Left = 71
    Top = 69
    Width = 121
    Height = 23
    HelpContext = 380005
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'TransactionDate'
    DataSource = DSMaster
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 0
    UnboundDataType = wwDTEdtDate
  end
  object grpTaxSelect: TwwRadioGroup [25]
    Left = 328
    Top = 69
    Width = 170
    Height = 72
    HelpContext = 380007
    DisableThemes = False
    TransparentActiveItem = True
    Transparent = True
    NoSpacing = True
    Anchors = [akTop]
    Caption = 'Show on Tax Reports as:'
    DataField = 'TaxSelect'
    DataSource = DSMaster
    Items.Strings = (
      '  Input (Purchase)'
      '  Output (Sale)')
    TabOrder = 2
    Values.Strings = (
      'INPUT'
      'OUTPUT')
  end
  object cboLinesAreaCode: TwwDBLookupCombo [26]
    Left = 385
    Top = 318
    Width = 88
    Height = 23
    HelpContext = 380029
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AreaCode'#9'10'#9'Code'#9'F'
      'AreaName'#9'20'#9'Name'#9'F')
    DataField = 'AreaCode'
    DataSource = DSDetails
    LookupTable = QryAreaCodeLk
    LookupField = 'AreaCode'
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object chkApproved: TwwCheckBox [27]
    Left = 228
    Top = 124
    Width = 81
    Height = 17
    HelpContext = 380032
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
    Caption = 'Approved'
    DataField = 'Approved'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 18
    OnClick = chkApprovedClick
  end
  object btnPrint: TDNMSpeedButton [28]
    Left = 729
    Top = 144
    Width = 87
    Height = 26
    HelpContext = 380008
    Anchors = [akTop, akRight]
    Caption = 'Prin&t'
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
    TabOrder = 8
    AutoDisableParentOnclick = True
    OnClick = btnPrintClick
  end
  object edtMemo: TwwDBEdit [29]
    Left = 512
    Top = 121
    Width = 201
    Height = 23
    HelpContext = 380033
    Anchors = [akTop, akRight]
    DataField = 'Memo'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 19
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  inherited tmrProcessMessage: TTimer
    Left = 436
    Top = 160
  end
  inherited tmrdelay: TTimer
    Left = 472
    Top = 160
  end
  inherited popSpelling: TPopupMenu
    Left = 96
    Top = 32
  end
  inherited tmrdelayMsg: TTimer
    Left = 8
    Top = 144
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 132
    Top = 6
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 69
    Top = 6
  end
  inherited MyConnection: TERPConnection
    Left = 100
    Top = 5
  end
  inherited DataState: TDataState
    Top = 8
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 227
    Top = 9
    object mnuCopyToClipboard: TMenuItem
      Caption = 'Copy To Clipboard'
      HelpContext = 380034
      OnClick = mnuCopyToClipboardClick
    end
    object mnuPasteFromClipboard: TMenuItem
      Caption = 'Paste From Clipboard'
      HelpContext = 380035
      OnClick = mnuPasteFromClipboardClick
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102008400100110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 466
    Top = 456
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 262
    Top = 48
  end
  inherited qryMemTrans: TERPQuery
    Left = 501
    Top = 456
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 72
    Top = 484
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 23
    Top = 484
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblgeneraljournal'
      'Where GJID=:ID;')
    Left = 23
    Top = 454
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblgeneraljournal.GlobalRef'
      Size = 255
    end
    object tblMasterGJID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'GJID'
      Origin = 'tblgeneraljournal.GJID'
      ReadOnly = True
    end
    object tblMasterTransactionDate: TDateField
      FieldName = 'TransactionDate'
      Origin = 'tblgeneraljournal.TransactionDate'
    end
    object tblMasterTransactionNo: TWideStringField
      FieldName = 'TransactionNo'
      Origin = 'tblgeneraljournal.TransactionNo'
      Size = 25
    end
    object tblMasterAmount: TFloatField
      FieldName = 'Amount'
      Origin = 'tblgeneraljournal.Amount'
      currency = True
    end
    object tblMasterTaxSelect: TWideStringField
      FieldName = 'TaxSelect'
      Origin = 'tblgeneraljournal.TaxSelect'
      FixedChar = True
      Size = 6
    end
    object tblMasterDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblgeneraljournal.Deleted'
      FixedChar = True
      Size = 1
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblgeneraljournal.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblgeneraljournal.msTimeStamp'
    end
    object tblMastermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblgeneraljournal.msUpdateSiteCode'
      Size = 3
    end
    object tblMasterApproved: TWideStringField
      FieldName = 'Approved'
      Origin = 'tblgeneraljournal.Approved'
      FixedChar = True
      Size = 1
    end
    object tblMasterMemo: TWideStringField
      FieldName = 'Memo'
      Size = 255
    end
  end
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblgeneraljournaldetails'
      'Where GJID=:ID;')
    Filtered = True
    Filter = 'Deleted <> '#39'T'#39
    Left = 72
    Top = 454
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblDetailsAccountNumber: TWideStringField
      DisplayLabel = 'Account No'
      DisplayWidth = 15
      FieldName = 'AccountNumber'
      OnChange = tblDetailsAccountNumberChange
      Size = 50
    end
    object tblDetailsAccountName: TWideStringField
      DisplayLabel = 'Account (Full)'
      DisplayWidth = 20
      FieldName = 'AccountName'
      OnChange = tblDetailsAccountNameChange
      Size = 100
    end
    object tblDetailsDebitAmount: TFloatField
      DisplayLabel = 'Debit (Ex)'
      DisplayWidth = 10
      FieldName = 'DebitAmount'
      currency = True
    end
    object tblDetailsDebitAmountInc: TFloatField
      DisplayLabel = 'Debit (Inc)'
      DisplayWidth = 10
      FieldName = 'DebitAmountInc'
      currency = True
    end
    object tblDetailsCreditAmount: TFloatField
      DisplayLabel = 'Credit (Ex)'
      DisplayWidth = 10
      FieldName = 'CreditAmount'
      currency = True
    end
    object tblDetailsCreditAmountInc: TFloatField
      DisplayLabel = 'Credit (Inc)'
      DisplayWidth = 10
      FieldName = 'CreditAmountInc'
      currency = True
    end
    object tblDetailsTaxCode: TWideStringField
      DisplayLabel = 'Tax'
      DisplayWidth = 7
      FieldName = 'TaxCode'
      Size = 50
    end
    object tblDetailsTaxAmount: TFloatField
      DisplayLabel = 'Tax Amount'
      DisplayWidth = 10
      FieldName = 'TaxAmount'
      currency = True
    end
    object tblDetailsMemo: TWideStringField
      DisplayWidth = 15
      FieldName = 'Memo'
      Size = 255
    end
    object tblDetailsClientName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 15
      FieldName = 'ClientName'
      Size = 80
    end
    object tblDetailsClassName: TWideStringField
      DisplayLabel = 'Class'
      DisplayWidth = 15
      FieldName = 'ClassName'
      Size = 100
    end
    object tblDetailsEmployeeName: TWideStringField
      DisplayLabel = 'Employee Name'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Size = 255
    end
    object tblDetailsEmployeeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeId'
    end
    object tblDetailsAreaCode: TWideStringField
      DisplayLabel = 'Area'
      DisplayWidth = 10
      FieldName = 'AreaCode'
      Size = 50
    end
    object tblDetailsLinesOrder: TIntegerField
      DisplayLabel = 'Order by'
      DisplayWidth = 10
      FieldName = 'LinesOrder'
    end
    object tblDetailsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tblDetailsGJDID: TAutoIncField
      FieldName = 'GJDID'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsGJID: TIntegerField
      FieldName = 'GJID'
      Visible = False
    end
    object tblDetailsAccountID: TIntegerField
      FieldName = 'AccountID'
      Visible = False
    end
    object tblDetailsTaxCodeID: TIntegerField
      FieldName = 'TaxCodeID'
      Visible = False
    end
    object tblDetailsTaxRate: TFloatField
      FieldName = 'TaxRate'
      Visible = False
    end
    object tblDetailsClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
    object tblDetailsClassID: TIntegerField
      FieldName = 'ClassID'
      Visible = False
    end
    object tblDetailsReconciled: TWideStringField
      FieldName = 'Reconciled'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsDeleted: TWideStringField
      FieldName = 'Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Visible = False
    end
    object tblDetailsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object lsTDNMSpeedButtonActions: TActionList
    Left = 17
    Top = 26
    object actMemTrans: TAction
      Caption = 'Memorise Transaction'
      HelpContext = 380026
      OnExecute = actMemTransExecute
      OnUpdate = actMemTransUpdate
    end
    object actMemTransAuto: TAction
      Caption = 'Memorize Auto Transaction'
      HelpContext = 380027
      OnExecute = actMemTransExecute
    end
  end
  object cboAccountLinesQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'tblChartofAccounts.AccountID,'
      'tblChartofAccounts.AccountName,'
      'tblChartofAccounts.AccountGroup,'
      'tblChartofAccounts.AccountNumber,'
      'tblacctypedesc.AccDesc AS Type,'
      'tblChartofAccounts.Description,'
      'tblChartofAccounts.Taxcode,'
      'tblChartofAccounts.Active,'
      
        'Concat(If( char_length(Level4)>0,Space(15), If( char_length(Leve' +
        'l3)>0,Space(10),If( char_length(Level2)>0,Space(5),Space(0)))),A' +
        'ccountName) as AccountTree,'
      
        'SUBSTRING(If((char_length(tblChartofAccounts.AccountGroup)>0),Co' +
        'ncat(REPLACE(tblChartofAccounts.AccountGroup,"^"," - ")," - ",tb' +
        'lChartofAccounts.AccountName),tblChartofAccounts.AccountName),1,' +
        '255) as FullAccountName'
      'FROM tblChartofAccounts'
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = tblChartofA' +
        'ccounts.AccountType'
      
        'WHERE (Active = '#39'T'#39') and (IsHeader = '#39'F'#39') # and tblChartofAccoun' +
        'ts.Accountname <> "Retained Earnings"'
      'and (((:SearchMode = 0) or (IsNull(:SearchMode))) '
      
        'or ((:SearchMode = 1) and ((tblChartofAccounts.AccountName LIKE ' +
        'Concat(:SearchValue,"%")) ))'
      
        'or ((:SearchMode = 2) and ((tblChartofAccounts.AccountName LIKE ' +
        'Concat("%",:SearchValue,"%"))) ))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY Type, FullAccountName;')
    Options.LongStrings = False
    Left = 268
    Top = 454
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object cboAccountLinesQryAccountName: TWideStringField
      DisplayWidth = 20
      FieldName = 'AccountName'
      Origin = 'tblChartofAccounts.AccountName'
      Size = 50
    end
    object cboAccountLinesQryType: TWideStringField
      DisplayWidth = 20
      FieldName = 'Type'
      Origin = 'tblacctypedesc.Type'
      Size = 255
    end
    object cboAccountLinesQryDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'tblChartofAccounts.Description'
      Size = 150
    end
    object cboAccountLinesQryAccountTree: TWideStringField
      DisplayWidth = 25
      FieldName = 'AccountTree'
      Origin = 'tblChartofAccounts.AccountTree'
      Size = 65
    end
    object cboAccountLinesQryAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AccountID'
      Origin = 'tblChartofAccounts.AccountID'
      Visible = False
    end
    object cboAccountLinesQryAccountGroup: TWideStringField
      DisplayWidth = 40
      FieldName = 'AccountGroup'
      Origin = 'tblChartofAccounts.AccountGroup'
      Visible = False
      Size = 255
    end
    object cboAccountLinesQryAccountNumber: TWideStringField
      DisplayWidth = 9
      FieldName = 'AccountNumber'
      Origin = 'tblChartofAccounts.AccountNumber'
      Visible = False
      Size = 9
    end
    object cboAccountLinesQryTaxcode: TWideStringField
      DisplayWidth = 15
      FieldName = 'Taxcode'
      Origin = 'tblChartofAccounts.Taxcode'
      Visible = False
      Size = 15
    end
    object cboAccountLinesQryActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblChartofAccounts.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboAccountLinesQryFullAccountName: TWideStringField
      DisplayWidth = 40
      FieldName = 'FullAccountName'
      Origin = 'tblChartofAccounts.FullAccountName'
      Visible = False
      Size = 255
    end
  end
  object cboTaxCodeQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TaxCodeID, Name as name, Description, Rate  '
      'FROM tbltaxcodes '
      'Where RegionID=:xRegionID'
      'AND Active <>"F"'
      'and '
      '(((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (tbltaxcodes.Name LIKE Concat(:SearchV' +
        'alue,"%")))'
      
        'or ((:SearchMode = 2) and (tbltaxcodes.Name LIKE Concat("%",:Sea' +
        'rchValue,"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      '-- or RegionID = 1')
    BeforeOpen = cboTaxCodeQryBeforeOpen
    Options.LongStrings = False
    Left = 366
    Top = 454
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
  end
  object cboClassQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Options.LongStrings = False
    Left = 121
    Top = 454
  end
  object cboClientLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientID, Company'
      
        ',if(Supplier = '#39'T'#39' and Customer = '#39'T'#39' , '#39'Customer/Supplier'#39' ,  I' +
        'f(Supplier = '#39'T'#39','#39'Supplier'#39',If(Customer = '#39'T'#39','#39'Customer'#39','#39'Unknow' +
        'n'#39'))) as Type  '
      'FROM tblclients'
      'WHERE Active = '#39'T'#39' And (Supplier = '#39'T'#39' or Customer = '#39'T'#39') '
      'Order By Type,Company;')
    Options.LongStrings = False
    Left = 170
    Top = 454
  end
  object qryEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeName '
      'FROM tblemployees'
      'WHERE Active = '#39'T'#39' '
      'ORDER BY EmployeeName;')
    Options.LongStrings = False
    Left = 219
    Top = 454
    object qryEmployeeLookupEmployeeName: TWideStringField
      DisplayWidth = 30
      FieldName = 'EmployeeName'
      Origin = 'tblemployees.EmployeeName'
      Size = 255
    end
  end
  object popMemTrans: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 676
    Top = 45
    object MemorizeTransaction1: TMenuItem
      Action = actMemTrans
    end
    object MemorizeAutoTransaction1: TMenuItem
      Action = actMemTransAuto
    end
    object mnuAuditTrail: TMenuItem
      Caption = 'Audit Trail'
      HelpContext = 380028
      OnClick = mnuAuditTrailClick
    end
  end
  object cboAccountNoLinesQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'tblChartofAccounts.AccountID,'
      'tblChartofAccounts.AccountName,'
      'tblChartofAccounts.AccountGroup,'
      'tblChartofAccounts.AccountNumber,'
      'tblacctypedesc.AccDesc AS Type,'
      'tblChartofAccounts.Description,'
      'tblChartofAccounts.Taxcode,'
      'tblChartofAccounts.Active,'
      
        'Concat(If( char_length(Level4)>0,Space(15), If( char_length(Leve' +
        'l3)>0,Space(10),If( char_length(Level2)>0,Space(5),Space(0)))),A' +
        'ccountName) as AccountTree,'
      
        'SUBSTRING(If((char_length(tblChartofAccounts.AccountGroup)>0),Co' +
        'ncat(REPLACE(tblChartofAccounts.AccountGroup,"^"," - ")," - ",tb' +
        'lChartofAccounts.AccountName),tblChartofAccounts.AccountName),1,' +
        '255) as FullAccountName'
      'FROM tblChartofAccounts'
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = tblChartofA' +
        'ccounts.AccountType'
      
        'WHERE (Active = '#39'T'#39') and (IsHeader = '#39'F'#39')  #and tblChartofAccoun' +
        'ts.Accountname <> "Retained Earnings"'
      'and (((:SearchMode = 0) or (IsNull(:SearchMode))) '
      
        'or ((:SearchMode = 1) and ((tblChartofAccounts.AccountNumber LIK' +
        'E Concat(:SearchValue,"%")) ))'
      
        'or ((:SearchMode = 2) and ((tblChartofAccounts.AccountNumber LIK' +
        'E Concat("%",:SearchValue,"%"))) ))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY Type, AccountNumber;')
    Options.LongStrings = False
    Left = 317
    Top = 454
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object WideStringField6: TWideStringField
      DisplayWidth = 9
      FieldName = 'AccountNumber'
      Origin = 'tblChartofAccounts.AccountNumber'
      Size = 9
    end
    object WideStringField1: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountName'
      Origin = 'tblChartofAccounts.AccountName'
      Size = 50
    end
    object WideStringField4: TWideStringField
      DisplayWidth = 65
      FieldName = 'AccountTree'
      Origin = 'tblChartofAccounts.AccountTree'
      Size = 65
    end
    object WideStringField2: TWideStringField
      DisplayWidth = 40
      FieldName = 'Type'
      Origin = 'tblacctypedesc.Type'
      Size = 255
    end
    object WideStringField3: TWideStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Origin = 'tblChartofAccounts.Description'
      Size = 150
    end
    object IntegerField1: TIntegerField
      DisplayWidth = 10
      FieldName = 'AccountID'
      Origin = 'tblChartofAccounts.AccountID'
      Visible = False
    end
    object WideStringField5: TWideStringField
      DisplayWidth = 40
      FieldName = 'AccountGroup'
      Origin = 'tblChartofAccounts.AccountGroup'
      Visible = False
      Size = 255
    end
    object WideStringField7: TWideStringField
      DisplayWidth = 15
      FieldName = 'Taxcode'
      Origin = 'tblChartofAccounts.Taxcode'
      Visible = False
      Size = 15
    end
    object WideStringField8: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblChartofAccounts.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object WideStringField9: TWideStringField
      DisplayWidth = 40
      FieldName = 'FullAccountName'
      Origin = 'tblChartofAccounts.FullAccountName'
      Visible = False
      Size = 255
    end
  end
  object QryAreaCodeLk: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 415
    Top = 454
    object QryAreaCodeLkAreaCode: TWideStringField
      FieldName = 'AreaCode'
      Size = 50
    end
    object QryAreaCodeLkAreaName: TWideStringField
      FieldName = 'AreaName'
      Size = 100
    end
  end
end
