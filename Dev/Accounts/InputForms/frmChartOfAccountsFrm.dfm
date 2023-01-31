inherited frmChartofAccounts: TfrmChartofAccounts
  Left = 462
  Top = 430
  HelpContext = 243000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Account'
  ClientHeight = 471
  ClientWidth = 695
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  ExplicitTop = 8
  ExplicitWidth = 701
  ExplicitHeight = 500
  DesignSize = (
    695
    471)
  PixelsPerInch = 96
  TextHeight = 15
  object Label50: TLabel [0]
    Left = 646
    Top = 431
    Width = 40
    Height = 16
    HelpContext = 243002
    Anchors = [akLeft, akBottom]
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
  end
  inherited lblSkingroupMsg: TLabel
    Top = 471
    Width = 695
    HelpContext = 243059
    ExplicitTop = 471
    ExplicitWidth = 695
  end
  inherited imgGridWatermark: TImage
    HelpContext = 243001
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 70
    Width = 698
    Height = 353
    HelpContext = 243005
    Anchors = [akLeft, akRight]
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object Bevel3: TBevel
      Left = 356
      Top = 112
      Width = 327
      Height = 61
      HelpContext = 243006
      Shape = bsFrame
    end
    object Bevel1: TBevel
      Left = 10
      Top = 196
      Width = 327
      Height = 142
      HelpContext = 243007
      Shape = bsFrame
    end
    object Bevel2: TBevel
      Left = 10
      Top = 68
      Width = 327
      Height = 105
      HelpContext = 243008
      Shape = bsFrame
    end
    object Label1: TLabel
      Left = 22
      Top = 73
      Width = 65
      Height = 15
      HelpContext = 243009
      Caption = 'Account No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 14
      Top = 11
      Width = 76
      Height = 15
      HelpContext = 243010
      Caption = 'Account Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 556
      Top = 11
      Width = 83
      Height = 15
      HelpContext = 243011
      Caption = 'Account Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 149
      Top = 11
      Width = 117
      Height = 15
      HelpContext = 243012
      AutoSize = False
      Caption = 'Sub Account 1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 21
      Top = 120
      Width = 115
      Height = 15
      HelpContext = 243013
      Caption = 'Account Description'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 229
      Top = 73
      Width = 52
      Height = 15
      HelpContext = 243014
      Caption = 'Tax Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblBSB: TLabel
      Left = 23
      Top = 249
      Width = 24
      Height = 15
      HelpContext = 243015
      Caption = 'BSB'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblBankAccNo: TLabel
      Left = 124
      Top = 249
      Width = 65
      Height = 15
      HelpContext = 243016
      Caption = 'Account No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblBankAccDetails: TLabel
      Left = 12
      Top = 180
      Width = 123
      Height = 15
      HelpContext = 243017
      Caption = 'Bank Account Details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object lblBankAccName: TLabel
      Left = 22
      Top = 205
      Width = 115
      Height = 15
      HelpContext = 243018
      Caption = 'Bank Account Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 285
      Top = 11
      Width = 117
      Height = 15
      HelpContext = 243019
      AutoSize = False
      Caption = 'Sub Account 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 420
      Top = 11
      Width = 117
      Height = 15
      HelpContext = 243020
      AutoSize = False
      Caption = 'Sub Account 3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label11: TLabel
      Left = 356
      Top = 181
      Width = 109
      Height = 15
      HelpContext = 243021
      Caption = 'Account Tree View'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 409
      Top = 119
      Width = 124
      Height = 15
      HelpContext = 243022
      Caption = 'Last Cheque No. Used'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel4: TBevel
      Left = 356
      Top = 68
      Width = 327
      Height = 37
      HelpContext = 243023
      Shape = bsFrame
    end
    object Label13: TLabel
      Left = 630
      Top = 119
      Width = 22
      Height = 15
      HelpContext = 243024
      Caption = 'Use'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object AccountNumber: TDBEdit
      Left = 22
      Top = 90
      Width = 139
      Height = 23
      HelpContext = 243025
      DataField = 'AccountNumber'
      DataSource = frmChartofAccountsSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object cboAccountType: TwwDBLookupCombo
      Left = 14
      Top = 29
      Width = 123
      Height = 23
      HelpContext = 243026
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccDesc'#9'30'#9'Account Type'#9'T')
      DataField = 'AccountType'
      DataSource = frmChartofAccountsSrc
      LookupTable = cboAccountTypeQry
      LookupField = 'AccType'
      Options = [loColLines, loTitles]
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboAccountTypeCloseUp
      OnExit = cboAccountTypeExit
    end
    object cboTaxCode: TwwDBLookupCombo
      Left = 229
      Top = 90
      Width = 70
      Height = 23
      HelpContext = 243027
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'5'#9'Tax Code'#9'F'
        'Description'#9'20'#9'Description'#9'T'
        'Rate'#9'10'#9'Rate'#9'T'#9)
      DataField = 'Taxcode'
      DataSource = frmChartofAccountsSrc
      LookupTable = cbTaxCodeQry
      LookupField = 'Taxcode'
      Options = [loColLines, loTitles]
      DropDownCount = 5
      DropDownWidth = 350
      ParentFont = False
      TabOrder = 6
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      PreciseEditRegion = False
      AllowClearKey = True
    end
    object txtDescription: TDBEdit
      Left = 21
      Top = 137
      Width = 302
      Height = 23
      HelpContext = 243028
      BevelWidth = 0
      DataField = 'Description'
      DataSource = frmChartofAccountsSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object cboAccLevel1: TwwDBLookupCombo
      Left = 149
      Top = 29
      Width = 123
      Height = 23
      HelpContext = 243029
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupTable = qryAccLevel1
      LookupField = 'AccLevel1'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnChange = cboAccLevel1Change
      OnExit = cboAccLevel1Exit
      OnNotInList = cboAccLevel1NotInList
    end
    object cboAccLevel2: TwwDBLookupCombo
      Left = 285
      Top = 29
      Width = 123
      Height = 23
      HelpContext = 243030
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupTable = qryAccLevel2
      LookupField = 'AccLevel2'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnChange = cboAccLevel2Change
      OnExit = cboAccLevel2Exit
      OnNotInList = cboAccLevel1NotInList
    end
    object cboAccLevel3: TwwDBLookupCombo
      Left = 420
      Top = 29
      Width = 123
      Height = 23
      HelpContext = 243031
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupTable = qryAccLevel3
      LookupField = 'AccLevel3'
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnChange = cboAccLevel3Change
      OnNotInList = cboAccLevel1NotInList
    end
    object edtAccountName: TwwDBEdit
      Left = 556
      Top = 29
      Width = 123
      Height = 23
      HelpContext = 243032
      DataField = 'AccountName'
      DataSource = frmChartofAccountsSrc
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
      OnChange = edtAccountNameChange
    end
    object edtBankAccName: TwwDBEdit
      Left = 22
      Top = 219
      Width = 298
      Height = 23
      HelpContext = 243034
      DataField = 'BankAccountName'
      DataSource = frmChartofAccountsSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object AccountTreeView: TTreeView
      Left = 356
      Top = 197
      Width = 327
      Height = 141
      HelpContext = 243035
      AutoExpand = True
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Indent = 21
      ParentFont = False
      ReadOnly = True
      ShowButtons = False
      TabOrder = 15
      TabStop = False
      OnClick = AccountTreeViewClick
    end
    object txtLastChequeNo: TDBEdit
      Left = 407
      Top = 136
      Width = 199
      Height = 23
      HelpContext = 243036
      DataField = 'LastChequeNo'
      DataSource = frmChartofAccountsSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
    end
    object chkIsHeader: TwwCheckBox
      Left = 404
      Top = 80
      Width = 97
      Height = 17
      HelpContext = 243037
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'Is Header'
      DataField = 'IsHeader'
      DataSource = frmChartofAccountsSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      OnClick = chkIsHeaderClick
    end
    object pnlEFT: TDNMPanel
      Left = 23
      Top = 289
      Width = 300
      Height = 42
      HelpContext = 243038
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      DesignSize = (
        300
        42)
      object Label12: TLabel
        Left = 1
        Top = 2
        Width = 89
        Height = 16
        HelpContext = 243039
        AutoSize = False
        Caption = 'APCA No.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label18: TLabel
        Left = 101
        Top = 2
        Width = 89
        Height = 16
        HelpContext = 243040
        AutoSize = False
        Caption = 'Bank Code'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object APCANo: TwwDBEdit
        Left = 1
        Top = 16
        Width = 88
        Height = 23
        HelpContext = 243041
        DataField = 'APCANo'
        DataSource = frmChartofAccountsSrc
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
      end
      object cboBankCode: TwwDBLookupCombo
        Left = 101
        Top = 16
        Width = 101
        Height = 23
        HelpContext = 243042
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'BankCode'#9'4'#9'Bank Code'#9'F'
          'BankName'#9'30'#9'BankName'#9'F')
        DataField = 'BankCode'
        DataSource = frmChartofAccountsSrc
        LookupTable = qryBankCodes
        LookupField = 'BankCode'
        DropDownWidth = 300
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object btnOptions: TDNMSpeedButton
        Left = 211
        Top = 10
        Width = 87
        Height = 27
        HelpContext = 243043
        Anchors = [akBottom]
        Caption = 'EFT Options'
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
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnOptionsClick
      end
    end
    object edtBSB: TDBEdit
      Left = 24
      Top = 262
      Width = 89
      Height = 23
      HelpContext = 243044
      DataField = 'BSB'
      DataSource = frmChartofAccountsSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object chkUseLastChequeNo: TwwCheckBox
      Left = 631
      Top = 134
      Width = 18
      Height = 17
      HelpContext = 243045
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      DataField = 'UseLastChequeNo'
      DataSource = frmChartofAccountsSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 16
    end
    object chkAllowExpenseClaim: TwwCheckBox
      Left = 527
      Top = 80
      Width = 140
      Height = 17
      HelpContext = 243046
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'Allow Expense Claim'
      DataField = 'AllowExpenseClaim'
      DataSource = frmChartofAccountsSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
    end
    object edtBankAccNo: TDBEdit
      Left = 124
      Top = 262
      Width = 194
      Height = 23
      HelpContext = 243060
      DataField = 'BankAccountNumber'
      DataSource = frmChartofAccountsSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
  end
  object cmdCancel: TDNMSpeedButton [7]
    Left = 437
    Top = 434
    Width = 87
    Height = 27
    HelpContext = 243053
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
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = cmdCancelClick
  end
  object cmdOk: TDNMSpeedButton [8]
    Left = 170
    Top = 434
    Width = 87
    Height = 27
    HelpContext = 243052
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
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = cmdOkClick
  end
  object chkActive: TwwCheckBox [9]
    Left = 656
    Top = 444
    Width = 16
    Height = 17
    HelpContext = 243054
    DisableThemes = False
    AlwaysTransparent = True
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Anchors = [akLeft, akBottom]
    Caption = 'chkActive'
    DataField = 'Active'
    DataSource = frmChartofAccountsSrc
    TabOrder = 4
    OnClick = chkActiveClick
  end
  object cmdRules: TDNMSpeedButton [10]
    Left = 535
    Top = 434
    Width = 87
    Height = 27
    Hint = 'View Rules applicable to this form'
    HelpContext = 243061
    Anchors = [akBottom]
    Caption = 'Rules'
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
    TabOrder = 6
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = cmdRulesClick
  end
  object cmdNew: TDNMSpeedButton [11]
    Left = 303
    Top = 434
    Width = 87
    Height = 27
    Hint = '"Save This Account And Open A New Account"'
    HelpContext = 243055
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
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = cmdNewClick
  end
  object pnlTitle: TDNMPanel [12]
    Left = 143
    Top = 9
    Width = 410
    Height = 45
    HelpContext = 243056
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 408
      Height = 43
      HelpContext = 243057
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
        Width = 408
        Height = 43
        HelpContext = 243058
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Account'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 236
      end
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003400500010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object frmChartofAccountsSrc: TDataSource
    DataSet = qryChartofAccounts
    Left = 12
    Top = 96
  end
  object qryChartofAccounts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblChartofAccounts'
      'WHERE AccountID= :COAID;')
    AfterOpen = qryChartofAccountsAfterOpen
    Left = 13
    Top = 67
    ParamData = <
      item
        DataType = ftString
        Name = 'COAID'
        Size = 255
      end>
    object qryChartofAccountsAccountID: TAutoIncField
      FieldName = 'AccountID'
      ReadOnly = True
    end
    object qryChartofAccountsAccountNumber: TWideStringField
      FieldName = 'AccountNumber'
      Size = 50
    end
    object qryChartofAccountsAccountType: TWideStringField
      FieldName = 'AccountType'
      Size = 50
    end
    object qryChartofAccountsAccountGroup: TWideStringField
      FieldName = 'AccountGroup'
      Size = 255
    end
    object qryChartofAccountsAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 50
    end
    object qryChartofAccountsDescription: TWideStringField
      FieldName = 'Description'
      Size = 150
    end
    object qryChartofAccountsBankNumber: TWideStringField
      FieldName = 'BankNumber'
      Size = 50
    end
    object qryChartofAccountsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryChartofAccountsTaxcode: TWideStringField
      FieldName = 'Taxcode'
      Size = 15
    end
    object qryChartofAccountsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryChartofAccountsClass: TWideStringField
      FieldName = 'Class'
      Size = 255
    end
    object qryChartofAccountsAllClasses: TWideStringField
      FieldName = 'AllClasses'
      FixedChar = True
      Size = 1
    end
    object qryChartofAccountsBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Size = 255
    end
    object qryChartofAccountsLastChequeNo: TIntegerField
      FieldName = 'LastChequeNo'
    end
    object qryChartofAccountsUseLastChequeNo: TWideStringField
      FieldName = 'UseLastChequeNo'
      FixedChar = True
      Size = 1
    end
    object qryChartofAccountsRequired: TWideStringField
      FieldName = 'Required'
      FixedChar = True
      Size = 1
    end
    object qryChartofAccountsBankCode: TWideStringField
      FieldName = 'BankCode'
      FixedChar = True
      Size = 3
    end
    object qryChartofAccountsAPCANo: TWideStringField
      FieldName = 'APCANo'
      Size = 6
    end
    object qryChartofAccountsBSB: TWideStringField
      FieldName = 'BSB'
      Size = 30
    end
    object qryChartofAccountsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryChartofAccountsBalance: TFloatField
      FieldName = 'Balance'
    end
    object qryChartofAccountsExtra: TWideStringField
      FieldName = 'Extra'
      Size = 50
    end
    object qryChartofAccountsOpeningBalance: TFloatField
      FieldName = 'OpeningBalance'
    end
    object qryChartofAccountsDebits: TFloatField
      FieldName = 'Debits'
    end
    object qryChartofAccountsCredits: TFloatField
      FieldName = 'Credits'
    end
    object qryChartofAccountsClosingBalance: TFloatField
      FieldName = 'ClosingBalance'
    end
    object qryChartofAccountsLevel1: TWideStringField
      FieldName = 'Level1'
      Size = 255
    end
    object qryChartofAccountsLevel2: TWideStringField
      FieldName = 'Level2'
      Size = 255
    end
    object qryChartofAccountsLevel3: TWideStringField
      FieldName = 'Level3'
      Size = 255
    end
    object qryChartofAccountsLevel4: TWideStringField
      FieldName = 'Level4'
      Size = 255
    end
    object qryChartofAccountsIncludeBalanceRecord: TWideStringField
      FieldName = 'IncludeBalanceRecord'
      FixedChar = True
      Size = 1
    end
    object qryChartofAccountsIncludeNetTotal: TWideStringField
      FieldName = 'IncludeNetTotal'
      FixedChar = True
      Size = 1
    end
    object qryChartofAccountsIncludeCreditTotal: TWideStringField
      FieldName = 'IncludeCreditTotal'
      FixedChar = True
      Size = 1
    end
    object qryChartofAccountsIncludeDebitTotal: TWideStringField
      FieldName = 'IncludeDebitTotal'
      FixedChar = True
      Size = 1
    end
    object qryChartofAccountsBankAccountNumber: TWideStringField
      FieldName = 'BankAccountNumber'
      Size = 255
    end
    object qryChartofAccountsIsHeader: TWideStringField
      FieldName = 'IsHeader'
      FixedChar = True
      Size = 1
    end
    object qryChartofAccountsAllowExpenseClaim: TWideStringField
      FieldName = 'AllowExpenseClaim'
      FixedChar = True
      Size = 1
    end
  end
  object cboAccountTypeQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AccDesc, AccType '
      'FROM tblAccTypeDesc '
      'GROUP BY AccDesc, AccType; ')
    Left = 232
    Top = 6
  end
  object cbTaxCodeQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TaxCodeID, Name as Taxcode, Name, Description, Rate '
      'FROM tbltaxcodes '
      'Where RegionID= :xRegionID AND Active <>'#39'F'#39';')
    BeforeOpen = cbTaxCodeQryBeforeOpen
    Left = 137
    Top = 33
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
        Size = -1
      end>
  end
  object qryAccClasses: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassName, ClassID,  AccountID, EditedFlag'
      'FROM tblaccountsclasses'
      'Where AccountID = :ACCID;')
    AfterInsert = qryAccClassesAfterInsert
    BeforePost = qryAccClassesBeforePost
    Left = 167
    Top = 1
    ParamData = <
      item
        DataType = ftString
        Name = 'ACCID'
        Size = 255
      end>
    object qryAccClassesClassName: TWideStringField
      DisplayLabel = 'Class Name'
      DisplayWidth = 50
      FieldName = 'ClassName'
      OnChange = qryAccClassesClassNameChange
      Size = 50
    end
    object qryAccClassesClassID: TIntegerField
      DisplayLabel = 'Class Name'
      DisplayWidth = 30
      FieldName = 'ClassID'
      Visible = False
    end
    object qryAccClassesAccountID: TIntegerField
      FieldName = 'AccountID'
      Visible = False
    end
  end
  object qryAccountName: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AccountName'
      'FROM tblchartofaccounts'
      'Where AccountName <> '#39#39
      'Order By AccountName;')
    Left = 585
    Top = 2
  end
  object qryAccLevel3: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AccountName As AccLevel3'
      'FROM tblchartofaccounts'
      'Where AccountName <> '#39#39' And AccountGroup =:SubAcc'
      'AND AccountType =:xType AND AccountName<> :SelfAcc'
      'AND Active = "T"'
      'Group by AccLevel3'
      'Order by AccLevel3;')
    Left = 553
    Top = 2
    ParamData = <
      item
        DataType = ftString
        Name = 'SubAcc'
        Size = 255
      end
      item
        DataType = ftString
        Name = 'xType'
        Size = 255
      end
      item
        DataType = ftString
        Name = 'SelfAcc'
        Size = 255
      end>
  end
  object qryAccLevel2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AccountName As AccLevel2'
      'FROM tblchartofaccounts'
      'Where AccountName <> '#39#39' And AccountGroup =:SubAcc'
      'AND AccountType =:xType AND AccountName<> :SelfAcc'
      'AND Active = "T"'
      'Group by AccLevel2'
      'Order by AccLevel2;')
    Left = 518
    Top = 1
    ParamData = <
      item
        DataType = ftString
        Name = 'SubAcc'
        Size = 255
      end
      item
        DataType = ftString
        Name = 'xType'
        Size = 255
      end
      item
        DataType = ftString
        Name = 'SelfAcc'
        Size = 255
      end>
  end
  object qryAccLevel1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AccountName As AccLevel1'
      'FROM tblchartofaccounts'
      'Where AccountName <> '#39#39' '
      'And AccountName=Level1'
      'AND AccountType =:xType  AND AccountName<> :SelfAcc'
      'AND Active = "T"'
      'Group by AccLevel1'
      'Order by AccLevel1;')
    Left = 483
    Top = 2
    ParamData = <
      item
        DataType = ftString
        Name = 'xType'
        Size = 255
      end
      item
        DataType = ftString
        Name = 'SelfAcc'
        Size = 255
      end>
  end
  object qryProductLevels: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT If(InStr(AccountGroup,'#39'^'#39') -1 >0,Left(AccountGroup,InStr(' +
        'AccountGroup,'#39'^'#39')-1),AccountGroup) AS AccLevel1,'
      
        'MID(AccountGroup, InStr(AccountGroup,'#39'^'#39')+1 ,If(LOCATE('#39'^'#39',Accou' +
        'ntGroup,InStr(AccountGroup,'#39'^'#39')+1) - InStr(AccountGroup,'#39'^'#39') >0,' +
        'LOCATE('#39'^'#39',AccountGroup,InStr(AccountGroup,'#39'^'#39')+1)-1 - InStr(Acc' +
        'ountGroup,'#39'^'#39'),IF(InStr(AccountGroup,'#39'^'#39')<>0,char_length(Account' +
        'Group) - InStr(AccountGroup,'#39'^'#39'),0)))  AS AccLevel2,'
      
        'if((LOCATE('#39'^'#39',AccountGroup,InStr(AccountGroup,'#39'^'#39')+1)) >0, MID(' +
        'AccountGroup,LOCATE('#39'^'#39',AccountGroup, InStr(AccountGroup,'#39'^'#39')+1)' +
        '+1,char_length(AccountGroup)- LOCATE('#39'^'#39',AccountGroup,InStr(Acco' +
        'untGroup,'#39'^'#39')+1)),  Null)  AS AccLevel3'
      'FROM tblchartofaccounts '
      'Where AccountID = :KeyID;'
      '')
    Left = 621
    Top = 1
    ParamData = <
      item
        DataType = ftString
        Name = 'KeyID'
        Size = 255
      end>
  end
  object memqryChartofAccounts: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'AccountID'
        DataType = ftAutoInc
      end
      item
        Name = 'AccountNumber'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'AccountType'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'AccountGroup'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'AccountName'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'BankNumber'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Active'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Taxcode'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'EditedFlag'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Class'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'AllClasses'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'BankAccountName'
        DataType = ftString
        Size = 255
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
    Left = 85
    Top = 37
  end
  object qryBankCodes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select CodeID,BankCode,BankName'
      'FROM tblBankCodes '
      'where (RegionId = :XRegionID) or (BankCode = :BankCode)'
      'Order by BankCode;')
    BeforeOpen = qryBankCodesBeforeOpen
    Left = 653
    Top = 7
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'XRegionID'
      end
      item
        DataType = ftUnknown
        Name = 'BankCode'
      end>
  end
end
