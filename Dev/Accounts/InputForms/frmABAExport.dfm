inherited frmABAExportGUI: TfrmABAExportGUI
  Left = 236
  Top = 151
  HelpContext = 222000
  Caption = 'Electronic Funds Transfer'
  ClientHeight = 519
  ClientWidth = 976
  OldCreateOrder = True
  ExplicitLeft = 236
  ExplicitTop = 151
  ExplicitWidth = 992
  ExplicitHeight = 558
  DesignSize = (
    976
    519)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 489
    Width = 976
    HelpContext = 222025
    ExplicitTop = 489
    ExplicitWidth = 976
  end
  inherited imgGridWatermark: TImage
    HelpContext = 222001
  end
  object pnlFooter: TDNMPanel [5]
    Left = 0
    Top = 489
    Width = 976
    Height = 30
    HelpContext = 222018
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      976
      30)
    object cboComments_Label: TLabel
      Left = 6
      Top = -117
      Width = 67
      Height = 18
      HelpContext = 222019
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Comments'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblMsg: TLabel
      Left = 0
      Top = 15
      Width = 976
      Height = 15
      HelpContext = 222003
      Align = alBottom
      Alignment = taCenter
      Caption = 'Bank Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      Visible = False
      ExplicitWidth = 65
    end
  end
  object pnlHeader: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 976
    Height = 170
    HelpContext = 222002
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      976
      170)
    object Label1: TLabel
      Left = 334
      Top = 61
      Width = 65
      Height = 15
      HelpContext = 222026
      Caption = 'Bank Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblUser: TLabel
      Left = 20
      Top = 118
      Width = 77
      Height = 15
      HelpContext = 222004
      Caption = 'Name of User'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 334
      Top = 118
      Width = 89
      Height = 15
      HelpContext = 222005
      Caption = 'Number of User'
      FocusControl = UserID
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 663
      Top = 118
      Width = 135
      Height = 15
      HelpContext = 222006
      Caption = 'Transaction Description'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 663
      Top = 61
      Width = 94
      Height = 15
      HelpContext = 222007
      Caption = 'Processing Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblAccount: TLabel
      Left = 20
      Top = 62
      Width = 48
      Height = 14
      HelpContext = 222008
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
    object btnCompleted: TDNMSpeedButton
      Left = 884
      Top = 9
      Width = 87
      Height = 27
      Hint = 'Export all selected (Apply) records from the list'
      HelpContext = 222009
      Anchors = [akTop, akRight]
      Caption = 'Export'
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
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCompletedClick
    end
    object btnClose: TDNMSpeedButton
      Left = 884
      Top = 46
      Width = 87
      Height = 27
      Hint = 'Close the form'
      HelpContext = 222010
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
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
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCloseClick
    end
    object UserID: TDBEdit
      Left = 334
      Top = 136
      Width = 94
      Height = 23
      HelpContext = 222011
      DataField = 'DirectEntryUserID'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object wwDBDateTimePicker1: TwwDBDateTimePicker
      Left = 663
      Top = 77
      Width = 125
      Height = 23
      HelpContext = 222012
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ProcessingDate'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 2
    end
    object cboBankCode: TwwDBLookupCombo
      Left = 334
      Top = 76
      Width = 255
      Height = 23
      HelpContext = 222013
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'BankName'#9'40'#9'BankName'#9'F')
      DataField = 'UserBankName'
      DataSource = DSMaster
      LookupTable = qryBankCodes
      LookupField = 'BankCode'
      AutoSelect = False
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboBankCodeCloseUp
    end
    object cboAccount: TwwDBLookupCombo
      Left = 20
      Top = 75
      Width = 200
      Height = 23
      HelpContext = 222014
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'50'#9'AccountName'#9'F')
      DataField = 'AccountID'
      DataSource = DSMaster
      LookupTable = cboAccountQry
      LookupField = 'AccountID'
      DropDownWidth = 300
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboAccountChange
    end
    object CboTransDesc: TwwDBLookupCombo
      Left = 663
      Top = 136
      Width = 188
      Height = 23
      HelpContext = 222015
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Description'#9'12'#9'Description'#9#9)
      DataField = 'TransactionDescription'
      DataSource = DSMaster
      LookupTable = qryTransDescription
      LookupField = 'Description'
      ParentFont = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnNotInList = CboTransDescNotInList
    end
    object btnOptions: TDNMSpeedButton
      Left = 884
      Top = 83
      Width = 87
      Height = 27
      Hint = 'Open Options form'
      HelpContext = 222016
      Anchors = [akTop, akRight]
      Caption = '&Options'
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
      OnClick = btnOptionsClick
    end
    object btnSelectAll: TDNMSpeedButton
      Left = 884
      Top = 120
      Width = 87
      Height = 27
      Hint = 'Select(Apply) all records '
      HelpContext = 222017
      Action = actSelectAll
      Anchors = [akTop, akRight]
      Caption = '&Select All'
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
    end
    object edtUserName: TEdit
      Left = 20
      Top = 136
      Width = 94
      Height = 23
      HelpContext = 222030
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
      Text = 'edtUserName'
    end
  end
  object pnlDetail: TDNMPanel [7]
    Left = 0
    Top = 170
    Width = 976
    Height = 319
    HelpContext = 222020
    Align = alClient
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
      Width = 976
      Height = 319
      HelpContext = 222021
      ControlType.Strings = (
        'TransCodeDesc;CustomEdit;cboTransactionCode;F'
        'Apply;CheckBox;T;F')
      Selected.Strings = (
        'Apply'#9'1'#9'Apply?'#9'F'#9
        'AccountName'#9'29'#9'Account Name'#9'F'#9
        'BSB'#9'7'#9'BSB'#9#9
        'CreditDebitAccountNumber'#9'9'#9'Account No'#9'F'#9
        'TransCodeDesc'#9'10'#9'Transaction Code'#9'F'#9
        'LodgementReferences'#9'18'#9'Lodgement References'#9'F'#9
        'Amount'#9'10'#9'Amount'#9'F'#9
        'UsersBSB'#9'7'#9'From BSB'#9'F'#9
        'UsersAccountNumber'#9'9'#9'From Account No'#9'F'#9)
      IniAttributes.Enabled = True
      IniAttributes.SaveToRegistry = True
      IniAttributes.FileName = 'ABAExport'
      IniAttributes.SectionName = 'ABAExport'
      IniAttributes.Delimiter = ';;'
      IniAttributes.CheckNewFields = True
      TitleColor = clWindow
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alClient
      DataSource = DSDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgEnterToTab, dgAllowInsert]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgRowResize]
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
      OnCalcCellColors = grdTransactionsCalcCellColors
      OnTitleButtonClick = grdTransactionsTitleButtonClick
      OnExit = grdTransactionsExit
      OnCalcTitleImage = grdTransactionsCalcTitleImage
      TitleImageList = imgPopup
      FooterColor = clWindow
      FooterCellColor = clWindow
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object btnDelete: TwwIButton
        Left = 0
        Top = 0
        Width = 20
        Height = 22
        HelpContext = 222031
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
    object cboTransactionCode: TwwDBLookupCombo
      Left = 353
      Top = 28
      Width = 121
      Height = 26
      HelpContext = 222032
      AutoSize = False
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'TransCodeDescription'#9'40'#9'TransCodeDescription'#9'F')
      LookupTable = qryTransCodes
      LookupField = 'TransCodeDescription'
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  object pnlTitle: TDNMPanel [8]
    Left = 292
    Top = 6
    Width = 392
    Height = 45
    HelpContext = 222022
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 390
      Height = 43
      HelpContext = 222023
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
        Width = 390
        Height = 43
        HelpContext = 222024
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Electronic Funds Transfer'
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
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003800500010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblabadescriptiverecord'
      'Where DescriptiveRecordID= :ID;')
    Left = 9
    Top = 316
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblMasterDescriptiveRecordID: TAutoIncField
      FieldName = 'DescriptiveRecordID'
      ReadOnly = True
    end
    object tblMasterRecordType: TWideStringField
      FieldName = 'RecordType'
      FixedChar = True
      Size = 1
    end
    object tblMasterBlank1: TWideStringField
      FieldName = 'Blank1'
      FixedChar = True
      Size = 17
    end
    object tblMasterReelSequenceNumber: TWideStringField
      FieldName = 'ReelSequenceNumber'
      FixedChar = True
      Size = 2
    end
    object tblMasterUserBankName: TWideStringField
      FieldName = 'UserBankName'
      FixedChar = True
      Size = 3
    end
    object tblMasterBlank2: TWideStringField
      FieldName = 'Blank2'
      FixedChar = True
      Size = 7
    end
    object tblMasterDirectEntryUserName: TWideStringField
      FieldName = 'DirectEntryUserName'
      FixedChar = True
      Size = 26
    end
    object tblMasterDirectEntryUserID: TWideStringField
      FieldName = 'DirectEntryUserID'
      FixedChar = True
      Size = 6
    end
    object tblMasterTransactionDescription: TWideStringField
      FieldName = 'TransactionDescription'
      EditMask = '!>LLLLLLLLLL;1; '
      FixedChar = True
      Size = 12
    end
    object tblMasterProcessingIndicator: TWideStringField
      FieldName = 'ProcessingIndicator'
      FixedChar = True
      Size = 1
    end
    object tblMasterBlank3: TWideStringField
      FieldName = 'Blank3'
      FixedChar = True
      Size = 39
    end
    object tblMasterProcessingDate: TDateField
      FieldName = 'ProcessingDate'
    end
    object tblMasterAccountID: TIntegerField
      FieldName = 'AccountID'
      OnChange = tblMasterAccountIDChange
    end
    object tblMasterIncludeBalanceRecord: TWideStringField
      FieldName = 'IncludeBalanceRecord'
      FixedChar = True
      Size = 1
    end
    object tblMasterIncludeNetTotal: TWideStringField
      FieldName = 'IncludeNetTotal'
      FixedChar = True
      Size = 1
    end
    object tblMasterIncludeCreditTotal: TWideStringField
      FieldName = 'IncludeCreditTotal'
      FixedChar = True
      Size = 1
    end
    object tblMasterIncludeDebitTotal: TWideStringField
      FieldName = 'IncludeDebitTotal'
      FixedChar = True
      Size = 1
    end
  end
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblabadetailrecord'
      'Where AccountID= :ID;'
      '')
    Left = 45
    Top = 315
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblDetailsApply: TWideStringField
      DisplayLabel = 'Apply?'
      DisplayWidth = 1
      FieldName = 'Apply'
      OnChange = tblDetailsApplyChange
      FixedChar = True
      Size = 1
    end
    object tblDetailsAccountName: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 29
      FieldName = 'AccountName'
      FixedChar = True
      Size = 32
    end
    object tblDetailsBSB: TWideStringField
      DisplayWidth = 7
      FieldName = 'BSB'
      EditMask = '!>000\-000;1; '
      FixedChar = True
      Size = 7
    end
    object tblDetailsCreditDebitAccountNumber: TWideStringField
      DisplayLabel = 'Account No'
      DisplayWidth = 9
      FieldName = 'CreditDebitAccountNumber'
      FixedChar = True
      Size = 9
    end
    object tblDetailsTransCodeDesc: TWideStringField
      DisplayLabel = 'Transaction Code'
      DisplayWidth = 10
      FieldName = 'TransCodeDesc'
      OnChange = tblDetailsTransCodeDescChange
      Size = 255
    end
    object tblDetailsLodgementReferences: TWideStringField
      DisplayLabel = 'Lodgement References'
      DisplayWidth = 18
      FieldName = 'LodgementReferences'
      FixedChar = True
      Size = 18
    end
    object tblDetailsAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      currency = True
    end
    object tblDetailsUsersBSB: TWideStringField
      DisplayLabel = 'From BSB'
      DisplayWidth = 7
      FieldName = 'UsersBSB'
      EditMask = '!>000\-000;1; '
      FixedChar = True
      Size = 7
    end
    object tblDetailsUsersAccountNumber: TWideStringField
      DisplayLabel = 'From Account No'
      DisplayWidth = 9
      FieldName = 'UsersAccountNumber'
      FixedChar = True
      Size = 9
    end
    object tblDetailsTransactionCode: TWideStringField
      DisplayWidth = 2
      FieldName = 'TransactionCode'
      Visible = False
      FixedChar = True
      Size = 2
    end
    object tblDetailsDetailRecordID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'DetailRecordID'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsDescriptiveRecordID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DescriptiveRecordID'
      Visible = False
    end
    object tblDetailsRecordType: TWideStringField
      DisplayWidth = 1
      FieldName = 'RecordType'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsIndicator: TWideStringField
      DisplayWidth = 1
      FieldName = 'Indicator'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsNameofRemitter: TWideStringField
      DisplayWidth = 16
      FieldName = 'NameofRemitter'
      Visible = False
      FixedChar = True
      Size = 16
    end
    object tblDetailsAmountOfWithholdingTax: TWideStringField
      DisplayWidth = 8
      FieldName = 'AmountOfWithholdingTax'
      Visible = False
      FixedChar = True
      Size = 8
    end
    object tblDetailsAccountID: TIntegerField
      FieldName = 'AccountID'
      Visible = False
    end
    object tblDetailsTransType: TWideStringField
      FieldName = 'TransType'
      Visible = False
      Size = 255
    end
    object tblDetailsTransID: TIntegerField
      FieldName = 'TransID'
      Visible = False
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 9
    Top = 350
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 42
    Top = 347
  end
  object qryBankCodes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select CodeID,BankCode,BankName'
      'FROM tblBankCodes'
      'Where (RegionId = :XRegionID)')
    BeforeOpen = qryBankCodesBeforeOpen
    Left = 156
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'XRegionID'
      end>
  end
  object qryTransDescription: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ID,Description FROM `tblabatransactiondescriptions`;')
    Left = 194
    Top = 314
  end
  object cboAccountQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AccountID, AccountName, '
      'AccountID,'
      'Description,'
      'BankAccountName,'
      'BSB,'
      'BankAccountNumber,'
      'BankCode,'
      'APCANo,'
      'IncludeBalanceRecord,'
      'IncludeNetTotal, '
      'IncludeCreditTotal, '
      'IncludeDebitTotal '
      'FROM tblchartofaccounts'
      'WHERE AccountType = '#39'Bank'#39' and Active='#39'T'#39' and IsHeader = '#39'F'#39';')
    Left = 125
    Top = 315
  end
  object qryTransCodes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT TransCodeID,TransCode,TransCodeDescription FROM tblabatra' +
        'nscode')
    Left = 229
    Top = 318
  end
  object ActionManager1: TActionManager
    Left = 104
    Top = 8
    StyleName = 'Platform Default'
    object actSelectAll: TAction
      Caption = '&Select All'
      HelpContext = 222033
      OnExecute = btnSelectAllClick
      OnUpdate = actSelectAllUpdate
    end
  end
  object imgPopup: TImageList
    Left = 175
    Top = 5
    Bitmap = {
      494C010102001000280010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
end
