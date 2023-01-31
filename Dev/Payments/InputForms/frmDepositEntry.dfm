inherited DepositEntryGUI: TDepositEntryGUI
  Left = 186
  Top = 164
  HelpContext = 97000
  Caption = 'Deposit Entry'
  ClientHeight = 527
  ClientWidth = 825
  OldCreateOrder = True
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 831
  ExplicitHeight = 556
  DesignSize = (
    825
    527)
  PixelsPerInch = 96
  TextHeight = 15
  object Box31: TBevel [0]
    Left = 548
    Top = 433
    Width = 257
    Height = 43
    HelpContext = 97002
    Anchors = [akRight, akBottom]
  end
  object Box68: TBevel [1]
    Left = 14
    Top = 67
    Width = 796
    Height = 59
    HelpContext = 97003
    Anchors = [akLeft, akTop, akRight]
    Style = bsRaised
  end
  object Label1: TLabel [2]
    Left = 533
    Top = 76
    Width = 121
    Height = 15
    HelpContext = 97004
    Anchors = [akTop]
    AutoSize = False
    Caption = 'Date'
    Transparent = True
  end
  object Label2: TLabel [3]
    Left = 673
    Top = 76
    Width = 69
    Height = 15
    HelpContext = 97005
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Deposit No.'
    Transparent = True
  end
  object lblAccount: TLabel [4]
    Left = 29
    Top = 74
    Width = 48
    Height = 18
    HelpContext = 97006
    AutoSize = False
    Caption = 'Account'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label80: TLabel [5]
    Left = 415
    Top = 74
    Width = 85
    Height = 18
    HelpContext = 97007
    Anchors = [akTop]
    AutoSize = False
    Caption = 'Deposit Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label28: TLabel [6]
    Left = 11
    Top = 416
    Width = 77
    Height = 15
    HelpContext = 97008
    Anchors = [akLeft, akBottom]
    Caption = 'Reference No'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label36: TLabel [7]
    Left = 559
    Top = 446
    Width = 105
    Height = 18
    HelpContext = 97009
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Total Deposited = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label11: TLabel [8]
    Left = 769
    Top = 493
    Width = 54
    Height = 17
    HelpContext = 97010
    Alignment = taCenter
    Anchors = [akBottom]
    AutoSize = False
    Caption = 'Deleted'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
    WordWrap = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 527
    Width = 825
    HelpContext = 97028
    ExplicitTop = 527
    ExplicitWidth = 825
  end
  inherited imgGridWatermark: TImage
    HelpContext = 97001
  end
  object Label3: TLabel [13]
    Left = 263
    Top = 74
    Width = 85
    Height = 18
    HelpContext = 97037
    Anchors = [akTop]
    AutoSize = False
    Caption = 'Area'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lbMemTrans: TLabel [15]
    Left = 660
    Top = 8
    Width = 150
    Height = 14
    HelpContext = 97038
    Anchors = [akTop, akRight]
    Caption = 'Right-Click For Audit Trail ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    OnMouseDown = lbMemTransMouseDown
  end
  object btnPreview: TDNMSpeedButton [16]
    Left = 350
    Top = 497
    Width = 87
    Height = 26
    HelpContext = 97016
    Anchors = [akBottom]
    Caption = 'Pre&view'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
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
    TabOrder = 10
    AutoDisableParentOnclick = True
    OnClick = btnPreviewClick
  end
  object cboAccount: TwwDBLookupCombo [17]
    Left = 30
    Top = 91
    Width = 217
    Height = 23
    HelpContext = 97017
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountName'#9'20'#9'Account Name'#9'F'
      'Account Type'#9'20'#9'Account Type'#9'F')
    DataField = 'AccountID'
    DataSource = DSMaster
    LookupTable = cboAccountQry
    LookupField = 'AccountID'
    Options = [loColLines, loTitles]
    ParentFont = False
    TabOrder = 0
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object txtDepositAmount: TDBEdit [18]
    Left = 414
    Top = 91
    Width = 85
    Height = 23
    HelpContext = 97018
    Anchors = [akTop]
    DataField = 'Deposit'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object Notes: TDBMemo [19]
    Left = 11
    Top = 433
    Width = 527
    Height = 43
    HelpContext = 97019
    Anchors = [akLeft, akRight, akBottom]
    Color = clWhite
    DataField = 'Notes'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnEnter = NotesEnter
    OnExit = NotesExit
  end
  object txtDeposited: TDNMPanel [20]
    Left = 670
    Top = 442
    Width = 122
    Height = 24
    HelpContext = 97020
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object btnClose: TDNMSpeedButton [21]
    Left = 623
    Top = 497
    Width = 87
    Height = 26
    HelpContext = 97021
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
    AutoDisableParentOnclick = True
    OnClick = btnCloseClick
  end
  object btnReconciled: TDNMSpeedButton [22]
    Left = 540
    Top = 25
    Width = 87
    Height = 27
    HelpContext = 97022
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
    TabOrder = 13
    TabStop = False
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = btnReconciledClick
  end
  object btnCompleted: TDNMSpeedButton [23]
    Left = 214
    Top = 497
    Width = 87
    Height = 27
    HelpContext = 97023
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
    TabOrder = 9
    AutoDisableParentOnclick = True
    OnClick = btnCompletedClick
  end
  object pnlTitle: TDNMPanel [24]
    Left = 294
    Top = 6
    Width = 238
    Height = 45
    HelpContext = 97024
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 236
      Height = 43
      HelpContext = 97025
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
        HelpContext = 97026
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Deposit Entry'
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
  object chkDeleted: TwwCheckBox [25]
    Left = 789
    Top = 509
    Width = 15
    Height = 17
    HelpContext = 97027
    TabStop = False
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
    Anchors = [akBottom]
    Caption = 'chkApplycredits'
    DataField = 'Deleted'
    DataSource = DSMaster
    TabOrder = 8
    Visible = False
  end
  object cmdNew: TDNMSpeedButton [26]
    Left = 78
    Top = 497
    Width = 87
    Height = 27
    HelpContext = 97029
    Anchors = [akBottom]
    Caption = '&New'
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
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 15
    AutoDisableParentOnclick = True
    OnClick = cmdNewClick
  end
  object TransNo: TDBEdit [27]
    Left = 673
    Top = 91
    Width = 117
    Height = 23
    HelpContext = 97012
    Anchors = [akTop, akRight]
    AutoSize = False
    DataField = 'DepositID'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object cboDate: TwwDBDateTimePicker [28]
    Left = 531
    Top = 91
    Width = 121
    Height = 23
    HelpContext = 97011
    Anchors = [akTop]
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'DepositDate'
    DataSource = DSMaster
    Date = 37720.000000000000000000
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 3
    UnboundDataType = wwDTEdtDate
  end
  object pnlDetail: TDNMPanel [29]
    Left = 11
    Top = 146
    Width = 802
    Height = 265
    HelpContext = 97013
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object grdTransactions: TwwDBGrid
      Left = 2
      Top = 2
      Width = 798
      Height = 261
      HelpContext = 97014
      ControlType.Strings = (
        'AccountName;CustomEdit;cboAccountline;F'
        'TransClassName;CustomEdit;cboClass;F'
        'PaymentMethod;CustomEdit;cboPaymentMethod;F'
        'CompanyName;CustomEdit;cboCustomerJob;F')
      Selected.Strings = (
        'AccountName'#9'25'#9'From Account'#9'F'
        'Amount'#9'10'#9'Amount'#9'F'
        'PaymentMethod'#9'20'#9'Payment Method'#9'F'
        'ReferenceNo'#9'10'#9'Reference No'#9'F'
        'TransClassName'#9'17'#9'Department'#9'F'
        'CompanyName'#9'20'#9'Received From'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = DSDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
      ParentFont = False
      PopupMenu = mnupopup
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      UseTFields = False
      OnEnter = grdTransactionsEnter
      OnKeyUp = grdTransactionsKeyUp
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object btnDelete: TwwIButton
        Left = 0
        Top = 0
        Width = 20
        Height = 22
        HelpContext = 97030
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
    object cboCustomerJob: TwwDBLookupCombo
      Left = 21
      Top = 77
      Width = 88
      Height = 23
      HelpContext = 97031
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'25'#9'Company'#9'F'
        'Type'#9'20'#9'Type'#9'F')
      DataField = 'CompanyName'
      DataSource = DSDetails
      LookupTable = cboClientLookup
      LookupField = 'Company'
      Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboCustomerJobCloseUp
      OnNotInList = cboCustomerJobNotInList
    end
    object cboAccountline: TERPDbLookupCombo
      Left = 20
      Top = 53
      Width = 111
      Height = 23
      HelpContext = 97032
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'20'#9'Account Name'#9'F'
        'Account Type'#9'20'#9'Account Type'#9'F')
      DataField = 'AccountName'
      DataSource = DSDetails
      LookupTable = qryLinesAccountLookup
      LookupField = 'AccountName'
      Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
      DropDownWidth = 600
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnNotInList = cboAccountlineNotInList
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
    object cboPaymentMethod: TwwDBLookupCombo
      Left = 21
      Top = 106
      Width = 116
      Height = 23
      HelpContext = 97033
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taRightJustify
      DataField = 'PaymentMethod'
      DataSource = DSDetails
      LookupTable = qryPayMethod
      LookupField = 'Name'
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboClass: TwwDBLookupCombo
      Left = 19
      Top = 131
      Width = 78
      Height = 23
      HelpContext = 97034
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'ClassName'#9'20'#9'Class Name'#9'F')
      DataField = 'TransClassName'
      DataSource = DSDetails
      LookupTable = cboClassQry
      LookupField = 'ClassName'
      Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboClassCloseUp
    end
  end
  object btnAddDate: TDNMSpeedButton [30]
    Left = 478
    Top = 417
    Width = 64
    Height = 15
    HelpContext = 97035
    Caption = 'Add Date'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    AutoDisableParentOnclick = True
    OnClick = btnAddDateClick
  end
  object cboAreaCode: TwwDBLookupCombo [31]
    Left = 263
    Top = 90
    Width = 81
    Height = 24
    HelpContext = 97036
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AreaCode'#9'10'#9'Code'#9'F'
      'AreaName'#9'20'#9'Name'#9'F')
    DataField = 'Area'
    DataSource = DSMaster
    LookupTable = QryAreaCodes
    LookupField = 'AreaCode'
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object btnPrint: TDNMSpeedButton [32]
    Left = 486
    Top = 497
    Width = 87
    Height = 26
    HelpContext = 97015
    Anchors = [akBottom]
    Caption = 'Prin&t'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
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
    AutoDisableParentOnclick = True
    OnClick = btnPrintClick
  end
  object wwCreateRule: TwwCheckBox [33]
    Left = 720
    Top = 412
    Width = 90
    Height = 17
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Anchors = [akRight, akBottom]
    Caption = 'Create Rule'
    TabOrder = 17
  end
  object cboClientLookup: TERPQuery [35]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientID, Company,'
      'If((Supplier = '#39'T'#39' AND Customer = '#39'T'#39'),'#39'Supplier / Customer'#39','
      
        'If(Supplier = '#39'T'#39','#39'Supplier'#39',If(Customer = '#39'T'#39','#39'Customer'#39','#39'Unkno' +
        'wn'#39'))) as Type  '
      'FROM tblclients'
      'WHERE Active = '#39'T'#39' And (Supplier = '#39'T'#39' or Customer = '#39'T'#39') '
      'Order By Company;')
    Left = 354
    Top = 254
  end
  object cboClassQry: TERPQuery [36]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Left = 391
    Top = 253
  end
  object DSClientLookup: TDataSource [37]
    AutoEdit = False
    DataSet = cboClientLookup
    Left = 354
    Top = 288
  end
  object cboClassSrc: TDataSource [38]
    AutoEdit = False
    DataSet = cboClassQry
    Left = 391
    Top = 286
  end
  object cboAccountQry: TERPQuery [39]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AccountID,'
      'AccDesc as '#39'Account Type'#39','
      'AccountGroup  , AccountName, '
      'Balance, Description, AccountNumber  '
      'FROM tblchartofaccounts'
      'LEFT JOIN tblacctypedesc on AccountType = AccType'
      
        'WHERE (Active='#39'T'#39' or accountID =:AccountID) AND AccountType <> '#39 +
        'AR'#39' AND AccountType <> '#39'AP'#39' '
      'AND IsHeader = '#39'F'#39
      'GROUP BY AccDesc,AccountName;')
    BeforeOpen = cboAccountQryBeforeOpen
    Left = 323
    Top = 254
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AccountID'
      end>
  end
  object cboAccountSrc: TDataSource [40]
    AutoEdit = False
    DataSet = cboAccountQry
    Left = 320
    Top = 284
  end
  object DSPaymethod: TDataSource [41]
    AutoEdit = False
    DataSet = qryPayMethod
    Left = 465
    Top = 289
  end
  object qryPayMethod: TERPQuery [42]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT PayMethodID, Name, IsCreditCard FROM tblpaymentmethods wh' +
        'ere Active ="T"')
    AutoCalcFields = False
    Left = 466
    Top = 255
  end
  object DSMaster: TDataSource [43]
    DataSet = tblMaster
    Left = 254
    Top = 287
  end
  object DSDetails: TDataSource [44]
    DataSet = tblDetails
    Left = 286
    Top = 287
  end
  object tblMaster: TERPQuery [45]
    SQL.Strings = (
      'SELECT * FROM tblbankdeposit'
      'Where DepositID=:ID;')
    AfterOpen = tblMasterAfterOpen
    Left = 252
    Top = 252
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object tblMasterDepositID: TAutoIncField
      FieldName = 'DepositID'
      ReadOnly = True
    end
    object tblMasterDepositDate: TDateField
      FieldName = 'DepositDate'
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object tblMasterClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object tblMasterClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
    object tblMasterArea: TWideStringField
      FieldName = 'Area'
      Size = 50
    end
    object tblMasterAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object tblMasterNotes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object tblMasterDeposit: TFloatField
      FieldName = 'Deposit'
      currency = True
    end
    object tblMasterDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterReconciled: TWideStringField
      FieldName = 'Reconciled'
      FixedChar = True
      Size = 1
    end
  end
  object tblDetails: TERPQuery [46]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblbankdepositlines'
      'Where DepositID=:ID;')
    AfterDelete = tblDetailsAfterDelete
    Left = 286
    Top = 253
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object tblDetailsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object tblDetailsDepositLineID: TAutoIncField
      FieldName = 'DepositLineID'
      ReadOnly = True
    end
    object tblDetailsDepositID: TIntegerField
      FieldName = 'DepositID'
    end
    object tblDetailsPaymentID: TIntegerField
      FieldName = 'PaymentID'
    end
    object tblDetailsTrnsType: TWideStringField
      FieldName = 'TrnsType'
      Size = 255
    end
    object tblDetailsCusID: TIntegerField
      FieldName = 'CusID'
    end
    object tblDetailsPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
    end
    object tblDetailsPaymentMethod: TWideStringField
      FieldName = 'PaymentMethod'
      Size = 70
    end
    object tblDetailsPaymentDate: TDateField
      FieldName = 'PaymentDate'
    end
    object tblDetailsCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 100
    end
    object tblDetailsReferenceNo: TWideStringField
      FieldName = 'ReferenceNo'
      Size = 50
    end
    object tblDetailsClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object tblDetailsTransClassName: TWideStringField
      FieldName = 'TransClassName'
      Size = 50
    end
    object tblDetailsAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object tblDetailsAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 60
    end
    object tblDetailsName: TWideStringField
      FieldName = 'Name'
      Size = 50
    end
    object tblDetailsAmount: TFloatField
      FieldName = 'Amount'
      OnChange = tblDetailsAmountChange
      currency = True
    end
    object tblDetailsNotes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object tblDetailsCustomer: TWideStringField
      FieldName = 'Customer'
      FixedChar = True
      Size = 1
    end
    object tblDetailsSupplier: TWideStringField
      FieldName = 'Supplier'
      FixedChar = True
      Size = 1
    end
    object tblDetailsEmployee: TWideStringField
      FieldName = 'Employee'
      FixedChar = True
      Size = 1
    end
    object tblDetailsContact: TWideStringField
      FieldName = 'Contact'
      FixedChar = True
      Size = 1
    end
    object tblDetailsDeposited: TWideStringField
      FieldName = 'Deposited'
      FixedChar = True
      Size = 1
    end
    object tblDetailsStatementNo: TIntegerField
      FieldName = 'StatementNo'
    end
    object tblDetailsFromDeposited: TWideStringField
      FieldName = 'FromDeposited'
      FixedChar = True
      Size = 1
    end
    object tblDetailsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblDetailsReconciled: TWideStringField
      FieldName = 'Reconciled'
      FixedChar = True
      Size = 1
    end
    object tblDetailsTransID: TIntegerField
      FieldName = 'TransID'
    end
    object tblDetailsDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
  end
  inherited tmrdelayMsg: TTimer
    Left = 96
    Top = 32
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 5
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 68
    Top = 4
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Top = 40
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200A400FC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 106
    Top = 0
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Top = 40
  end
  inherited qryMemTrans: TERPQuery
    Top = 8
  end
  object qryLinesAccountLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AccountID,'
      'AccDesc as '#39'Account Type'#39','
      'AccountGroup  , AccountName, '
      'Balance, Description, AccountNumber  '
      'FROM tblchartofaccounts'
      'LEFT JOIN tblacctypedesc on AccountType = AccType'
      
        'WHERE Active='#39'T'#39' AND AccountType <> '#39'AR'#39' AND AccountType <> '#39'AP'#39 +
        ' '
      'AND IsHeader = '#39'F'#39
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((AccountName LIKE Concat(:SearchValue' +
        ',"%")) or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%"))' +
        ' or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%"))) )'
      
        'or ((:SearchMode = 2) and ((AccountName LIKE Concat("%",:SearchV' +
        'alue,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchVal' +
        'ue,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchValue' +
        ',"%")))))'
      'and IfNull(:SearchValue,"") <> ""'
      'GROUP BY AccDesc,AccountName')
    Left = 504
    Top = 256
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
        Name = 'SearchValue'
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
  object QryAreaCodes: TERPQuery
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 431
    Top = 250
    object QryAreaCodesAreaCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 10
      FieldName = 'AreaCode'
      Size = 50
    end
    object QryAreaCodesAreaName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'AreaName'
      Size = 100
    end
  end
  object mnupopup: TAdvPopupMenu
    AutoHotkeys = maManual
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 356
    Top = 346
    object CalculatorF81: TMenuItem
      Caption = 'Calculator (F9)'
      HelpContext = 97039
      OnClick = CalculatorF81Click
    end
  end
  object ERPQWildCards: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    Options.LongStrings = False
    Left = 548
    Top = 250
  end
end
