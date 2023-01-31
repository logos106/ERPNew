inherited frmMessagesGUI: TfrmMessagesGUI
  Left = 50
  Top = 141
  HelpContext = 307000
  Caption = 'Message'
  OldCreateOrder = True
  ShowHint = True
  ExplicitLeft = 50
  ExplicitTop = 141
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 307001
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 949
    Height = 532
    HelpContext = 307002
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 444
      Top = 53
      Width = 408
      Height = 216
      HelpContext = 307004
    end
    object Bevel3: TBevel
      Left = 269
      Top = 53
      Width = 171
      Height = 215
      HelpContext = 307067
    end
    object Bevel2: TBevel
      Left = 1
      Top = 55
      Width = 262
      Height = 439
      HelpContext = 307068
    end
    object Label1: TLabel
      Left = 275
      Top = 58
      Width = 26
      Height = 15
      HelpContext = 307006
      Caption = 'Date'
      Transparent = True
    end
    object Label2: TLabel
      Left = 275
      Top = 99
      Width = 13
      Height = 15
      HelpContext = 307007
      Caption = 'To'
      Transparent = True
    end
    object Label5: TLabel
      Left = 13
      Top = 216
      Width = 16
      Height = 15
      HelpContext = 307010
      Caption = 'Tel'
      Transparent = True
    end
    object Label6: TLabel
      Left = 13
      Top = 255
      Width = 37
      Height = 15
      HelpContext = 307011
      Caption = 'Mobile'
      Transparent = True
    end
    object Label7: TLabel
      Left = 13
      Top = 295
      Width = 20
      Height = 15
      HelpContext = 307012
      Caption = 'Fax'
      Transparent = True
    end
    object Label8: TLabel
      Left = 13
      Top = 373
      Width = 34
      Height = 15
      HelpContext = 307013
      Caption = 'E-Mail'
      Transparent = True
    end
    object Done: TLabel
      Left = 894
      Top = 25
      Width = 29
      Height = 15
      HelpContext = 307018
      Caption = 'Done'
      Transparent = True
      Visible = False
    end
    object lblName: TLabel
      Left = 10
      Top = 58
      Width = 53
      Height = 15
      HelpContext = 307019
      Caption = 'Company'
      Transparent = True
    end
    object Label14: TLabel
      Left = 13
      Top = 412
      Width = 41
      Height = 15
      HelpContext = 307020
      Caption = 'Source'
      Transparent = True
    end
    object Label3: TLabel
      Left = 13
      Top = 177
      Width = 52
      Height = 15
      HelpContext = 307069
      Caption = 'Surname'
      Transparent = True
    end
    object Label13: TLabel
      Left = 13
      Top = 138
      Width = 61
      Height = 15
      HelpContext = 307042
      Caption = 'First Name'
      Transparent = True
    end
    object lblbtn: TLabel
      Left = 206
      Top = 58
      Width = 63
      Height = 15
      HelpContext = 307070
      Alignment = taCenter
      AutoSize = False
      Caption = 'Contact'
      Transparent = True
    end
    object Label16: TLabel
      Left = 275
      Top = 224
      Width = 65
      Height = 15
      HelpContext = 307043
      Alignment = taRightJustify
      Caption = 'Call Priority'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label17: TLabel
      Left = 13
      Top = 452
      Width = 132
      Height = 15
      HelpContext = 307044
      Alignment = taRightJustify
      Caption = 'Default Contact Method'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label18: TLabel
      Left = 452
      Top = 245
      Width = 16
      Height = 15
      HelpContext = 307016
      Caption = 'On'
      Transparent = True
    end
    object Label19: TLabel
      Left = 605
      Top = 245
      Width = 53
      Height = 15
      HelpContext = 307071
      Caption = 'Between '
      Transparent = True
    end
    object Label20: TLabel
      Left = 745
      Top = 245
      Width = 21
      Height = 15
      HelpContext = 307072
      Caption = 'and'
      Transparent = True
    end
    object Label21: TLabel
      Left = 275
      Top = 141
      Width = 26
      Height = 15
      HelpContext = 307073
      Caption = 'Dept'
      Transparent = True
    end
    object bvSupport: TBevel
      Left = 10
      Top = 500
      Width = 87
      Height = 27
      Hint = 
        'To Enable, The '#39'Company'#39' Selection Must be a Customer With '#39'Phon' +
        'e Support'#39' Activated or the Preference '#39'Support All Customers'#39'  ' +
        'Must Be On.'
      HelpContext = 307045
      ParentShowHint = False
      ShowHint = True
    end
    object Label4: TLabel
      Left = 13
      Top = 334
      Width = 22
      Height = 15
      HelpContext = 307074
      Caption = 'Rep'
      Transparent = True
    end
    object Label9: TLabel
      Left = 275
      Top = 182
      Width = 42
      Height = 15
      HelpContext = 307046
      AutoSize = False
      Caption = 'Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label10: TLabel
      Left = 660
      Top = 508
      Width = 124
      Height = 15
      HelpContext = 307075
      Caption = 'Message Received By'
      Transparent = True
    end
    object btnSupport: TDNMSpeedButton
      Left = 10
      Top = 500
      Width = 87
      Height = 27
      HelpContext = 307047
      Action = actSupport
      Caption = 'Support'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentShowHint = False
      ShowHint = False
      TabOrder = 25
      AutoDisableParentOnclick = True
    end
    object rgDetails: TwwRadioGroup
      Left = 452
      Top = 60
      Width = 392
      Height = 38
      HelpContext = 307048
      DisableThemes = False
      Transparent = True
      Caption = 'Details'
      Columns = 2
      DataField = 'Actiontype'
      DataSource = dsmessageLines
      Items.Strings = (
        '   Please Ring'
        '   Will Ring Back')
      TabOrder = 17
      Values.Strings = (
        'R'
        'B')
      OnClick = rgDetailsClick
    end
    object dbeDetails: TwwDBEdit
      Left = 452
      Top = 104
      Width = 392
      Height = 132
      HelpContext = 307021
      AutoSelect = False
      AutoSize = False
      DataField = 'Details'
      DataSource = dsmessageLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      UnboundDataType = wwDefault
      WantReturns = True
      WordWrap = True
      OnEnter = dbeDetailsEnter
    end
    object cbDone: TwwCheckBox
      Left = 873
      Top = 25
      Width = 15
      Height = 15
      HelpContext = 307026
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
      DataField = 'Done'
      DataSource = dsMessages
      TabOrder = 23
      Visible = False
    end
    object btnOk: TDNMSpeedButton
      Left = 856
      Top = 94
      Width = 87
      Height = 27
      HelpContext = 307027
      Caption = 'Save'
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
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 28
      AutoDisableParentOnclick = True
      OnClick = btnOkClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 856
      Top = 135
      Width = 87
      Height = 27
      HelpContext = 307028
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
      TabOrder = 29
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 856
      Top = 176
      Width = 87
      Height = 27
      HelpContext = 307029
      Caption = 'Print'
      DisableTransparent = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 30
      AutoDisableParentOnclick = True
      OnClick = btnPrintClick
    end
    object txtPhone: TwwDBEdit
      Left = 13
      Top = 230
      Width = 173
      Height = 23
      HelpContext = 307030
      Color = clInfoBk
      DataField = 'Phone'
      DataSource = dsMessages
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
      OnDblClick = AnyTxtDblClick
    end
    object txtMobile: TwwDBEdit
      Left = 13
      Top = 269
      Width = 173
      Height = 23
      HelpContext = 307031
      Color = clInfoBk
      DataField = 'Mobile'
      DataSource = dsMessages
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnDblClick = AnyTxtDblClick
    end
    object txtFax: TwwDBEdit
      Left = 13
      Top = 309
      Width = 173
      Height = 23
      HelpContext = 307032
      Color = clInfoBk
      DataField = 'Fax'
      DataSource = dsMessages
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnDblClick = AnyTxtDblClick
    end
    object txtEmail: TwwDBEdit
      Left = 13
      Top = 387
      Width = 242
      Height = 23
      HelpContext = 307033
      Color = clInfoBk
      DataField = 'Email'
      DataSource = dsMessages
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnDblClick = AnyTxtDblClick
    end
    object dtdatentime: TwwDBDateTimePicker
      Left = 275
      Top = 74
      Width = 162
      Height = 23
      HelpContext = 307034
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DateAndTime'
      DataSource = dsmessageLines
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 12
    end
    object cboTo: TwwDBLookupCombo
      Left = 275
      Top = 115
      Width = 162
      Height = 23
      HelpContext = 307036
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'25'#9'Name'#9'F')
      DataField = 'EmployeeName'
      DataSource = dsmessageLines
      LookupTable = qryEmployees
      LookupField = 'Name'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 13
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboToCloseUp
    end
    object cboSource: TwwDBLookupCombo
      Left = 13
      Top = 426
      Width = 173
      Height = 23
      HelpContext = 307038
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'MediaType'#9'20'#9'MediaType'#9'F')
      DataField = 'Source'
      DataSource = dsMessages
      LookupTable = qryMediaType
      LookupField = 'MedTypeID'
      Style = csDropDownList
      Color = clInfoBk
      ParentFont = False
      TabOrder = 10
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object pnlTitle: TDNMPanel
      Left = 372
      Top = 7
      Width = 238
      Height = 41
      HelpContext = 307039
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 24
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 234
        Height = 37
        HelpContext = 307040
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
          Width = 234
          Height = 37
          HelpContext = 307041
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Message'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = 64
        end
      end
    end
    object cboName: TERPDbLookupCombo
      Left = 10
      Top = 74
      Width = 213
      Height = 23
      HelpContext = 307049
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'20'#9'Company'#9'F'
        'Contactname'#9'20'#9'Contactname'#9'F'
        'Type'#9'20'#9'Type'#9'F')
      DataField = 'Company'
      DataSource = dsMessages
      LookupTable = qryContactNames
      LookupField = 'Company'
      Options = [loTitles]
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDblClick = cboNameDblClick
      OnCloseUp = cboNameCloseUp
      OnNotInList = cboNameNotInList
      LookupComboType = ctNone
      AllowFullListSearchMode = False
      OnSpecialItem = cboNameSpecialItem
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
    end
    object edLastName: TwwDBEdit
      Left = 13
      Top = 191
      Width = 173
      Height = 23
      HelpContext = 307050
      Color = clInfoBk
      DataField = 'LastName'
      DataSource = dsMessages
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
    end
    object edFirstName: TwwDBEdit
      Left = 13
      Top = 152
      Width = 173
      Height = 23
      HelpContext = 307051
      Color = clInfoBk
      DataField = 'Name'
      DataSource = dsMessages
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
    end
    object btnContacts: TDNMSpeedButton
      Left = 225
      Top = 74
      Width = 25
      Height = 23
      HelpContext = 307052
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000000
        055557777777777775F508888888888880557F5FFFFFFFFFF75F080000000000
        88057577777777775F755080FFFFFF05088057F7FFFFFF7575F70000000000F0
        F08077777777775757F70FFFFFFFFF0F008075F5FF5FF57577F750F00F00FFF0
        F08057F775775557F7F750FFFFFFFFF0F08057FF5555555757F7000FFFFFFFFF
        0000777FF5FFFFF577770900F00000F000907F775777775777F7090FFFFFFFFF
        00907F7F555555557757000FFFFFFFFF0F00777F5FFF5FF57F77550F000F00FF
        0F05557F777577557F7F550FFFFFFFFF0005557F555FFFFF7775550FFF000000
        05555575FF777777755555500055555555555557775555555555}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnContactsClick
    end
    object btnRepeat: TDNMSpeedButton
      Left = 165
      Top = 500
      Width = 87
      Height = 27
      HelpContext = 307053
      Action = actLead
      Caption = '&Lead'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 26
      AutoDisableParentOnclick = True
    end
    object wwDBComboBox1: TwwDBComboBox
      Left = 275
      Top = 241
      Width = 162
      Height = 23
      HelpContext = 307054
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      AutoDropDown = True
      AutoFillDate = False
      DataField = 'CallPriority'
      DataSource = dsmessageLines
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        '10 - High'#9'10'
        '9'#9'9'
        '8'#9'8'
        '7'#9'7'
        '6'#9'6'
        '5  - Standard'#9'5'
        '4'#9'4'
        '3'#9'3'
        '2'#9'2'
        '1'#9'1'
        '0  - Low'#9'0')
      ParentFont = False
      Sorted = False
      TabOrder = 16
      UnboundDataType = wwDefault
      UnboundAlignment = taCenter
    end
    object cboDefaultContactMethod: TwwDBComboBox
      Left = 13
      Top = 466
      Width = 173
      Height = 23
      HelpContext = 307055
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      DataField = 'DefaultContactMethod'
      DataSource = dsMessages
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Email'
        'Fax'
        'Print'
        'Phone'
        'Mobile'
        'Visit')
      ParentFont = False
      Sorted = False
      TabOrder = 11
      UnboundDataType = wwDefault
    end
    object wwDBDateTimePicker2: TwwDBDateTimePicker
      Left = 475
      Top = 241
      Width = 102
      Height = 23
      HelpContext = 307056
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      DataField = 'ResponsedueOn'
      DataSource = dsmessageLines
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 19
    end
    object wwDBDateTimePicker3: TwwDBDateTimePicker
      Left = 772
      Top = 241
      Width = 74
      Height = 23
      HelpContext = 307057
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      DataField = 'ResponsedueTimeTo'
      DataSource = dsmessageLines
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 21
      UnboundDataType = wwDTEdtTime
      DisplayFormat = 'hh:nn'
    end
    object wwDBDateTimePicker4: TwwDBDateTimePicker
      Left = 660
      Top = 241
      Width = 74
      Height = 23
      HelpContext = 307058
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      DataField = 'ResponsedueTimeFrom'
      DataSource = dsmessageLines
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 20
      UnboundDataType = wwDTEdtTime
      DisplayFormat = 'hh:nn'
    end
    object grdLines: TwwDBGrid
      Left = 269
      Top = 271
      Width = 676
      Height = 225
      HelpContext = 307059
      ControlType.Strings = (
        'Done;CheckBox;T;F')
      Selected.Strings = (
        'Done'#9'1'#9'Done'#9'F'
        'DateAndTime'#9'20'#9'Created'#9'T'
        'DeptName'#9'10'#9'Department'#9'T'
        'TypeName'#9'10'#9'Type'#9'F'
        'EmployeeName'#9'10'#9'Employee'#9'T'
        'Details'#9'10'#9'Details'#9'T'
        'CallPriority'#9'1'#9'Call~Priority'#9'T'
        'cActiontype'#9'10'#9'Details'#9'T'#9'Response'
        'ResponsedueOn'#9'10'#9'Due On'#9'T'#9'Response'
        'ResponsedueTimeFrom'#9'10'#9'Between'#9'T'#9'Response'
        'ResponsedueTimeTo'#9'10'#9'And'#9'T'#9'Response'
        'cMessagetype'#9'10'#9'Message'#9'T'
        'PeriodSinceLast'#9'20'#9'Period Since Last'#9'F')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dsmessageLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      ParentFont = False
      TabOrder = 22
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = False
      UseTFields = False
      FooterColor = clWhite
    end
    object wwDBLookupCombo1: TwwDBLookupCombo
      Left = 275
      Top = 157
      Width = 162
      Height = 23
      HelpContext = 307076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'60'#9'Name'#9'F'
        'Active'#9'1'#9'Active'#9'F')
      DataField = 'DeptName'
      DataSource = dsmessageLines
      LookupTable = cboClassQry
      LookupField = 'ClassName'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 14
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = wwDBLookupCombo1CloseUp
    end
    object btnNew: TDNMSpeedButton
      Left = 856
      Top = 53
      Width = 87
      Height = 27
      HelpContext = 307060
      Caption = 'New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 27
      AutoDisableParentOnclick = True
      OnClick = btnNewClick
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 856
      Top = 218
      Width = 87
      Height = 27
      HelpContext = 307061
      Caption = 'Response'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 31
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton1Click
    end
    object optTelephonedBy: TwwRadioGroup
      Left = 10
      Top = 98
      Width = 241
      Height = 37
      HelpContext = 307062
      DisableThemes = False
      Transparent = True
      Caption = ' '
      Columns = 2
      DataField = 'MessageType'
      DataSource = dsmessageLines
      Items.Strings = (
        '   Telephoned'
        '   Called in')
      TabOrder = 2
      Values.Strings = (
        'T'
        'C')
    end
    object cboRep: TwwDBLookupCombo
      Left = 13
      Top = 348
      Width = 173
      Height = 23
      HelpContext = 307077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'30'#9'Rep Name'#9'F')
      DataField = 'RepID'
      DataSource = dsMessages
      LookupTable = qryReps
      LookupField = 'EmployeeID'
      Style = csDropDownList
      Color = clInfoBk
      ParentFont = False
      TabOrder = 8
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboMessagetype: TwwDBLookupCombo
      Left = 275
      Top = 199
      Width = 162
      Height = 23
      HelpContext = 307063
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'name'#9'15'#9'name'#9'F')
      DataField = 'TypeName'
      DataSource = dsmessageLines
      LookupTable = qryMessagetype
      LookupField = 'name'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 15
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboMessagetypeCloseUp
      OnNotInList = cboMessagetypeNotInList
    end
    object wwDBEdit1: TwwDBEdit
      Left = 792
      Top = 504
      Width = 151
      Height = 23
      HelpContext = 307064
      DataField = 'EnteredByname'
      DataSource = dsmessageLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 32
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 417
    Top = 400
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 658
    Top = 400
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited DataState: TDataState
    Left = 735
    Top = 400
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 628
    Top = 400
  end
  inherited imgsort: TImageList
    Left = 688
    Top = 400
    Bitmap = {
      494C010102003C00500010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryMessages: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblMessages M'
      'WHERE MessagesId = :MessagesId')
    Left = 507
    Top = 400
    ParamData = <
      item
        DataType = ftString
        Name = 'MessagesId'
        Value = ''
      end>
    object qryMessagesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'M.GlobalRef'
      Size = 255
    end
    object qryMessagesMessagesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'MessagesID'
      Origin = 'M.MessagesID'
    end
    object qryMessagesFromId: TIntegerField
      FieldName = 'FromId'
      Origin = 'M.FromId'
    end
    object qryMessagesNameId: TIntegerField
      FieldName = 'NameId'
      Origin = 'M.NameId'
    end
    object qryMessagesName: TWideStringField
      FieldName = 'Name'
      Origin = 'M.Name'
      Size = 30
    end
    object qryMessagesDone: TWideStringField
      FieldName = 'Done'
      Origin = 'M.Done'
      FixedChar = True
      Size = 1
    end
    object qryMessagesDoneDateTime: TDateTimeField
      FieldName = 'DoneDateTime'
      Origin = 'M.DoneDateTime'
    end
    object qryMessagesLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'M.LastName'
      Size = 255
    end
    object qryMessagesPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'M.Phone'
    end
    object qryMessagesMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'M.Mobile'
    end
    object qryMessagesEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'M.Email'
      Size = 100
    end
    object qryMessagesFax: TWideStringField
      FieldName = 'Fax'
      Origin = 'M.Fax'
    end
    object qryMessagesSource: TWideStringField
      FieldName = 'Source'
      Origin = 'M.Source'
      Size = 255
    end
    object qryMessagesCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'M.Company'
      Size = 255
    end
    object qryMessagesCreateDateAndtime: TDateTimeField
      FieldName = 'CreateDateAndtime'
      Origin = 'M.CreateDateAndtime'
    end
    object qryMessagescontactType: TWideStringField
      FieldName = 'contactType'
      Origin = 'M.contactType'
      Size = 50
    end
    object qryMessagesContactID: TIntegerField
      FieldName = 'ContactID'
      Origin = 'M.ContactID'
    end
    object qryMessagesDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
      Origin = 'M.DefaultContactMethod'
      Size = 255
    end
    object qryMessagesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'M.msTimeStamp'
    end
    object qryMessagesRepID: TIntegerField
      FieldName = 'RepID'
    end
    object qryMessagesRepName: TWideStringField
      FieldName = 'RepName'
      Size = 255
    end
  end
  object qryEmployees: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Concat_WS(" ", FirstName, LastName) Name, EmployeeID,'
      'DefaultClassName , DefaultClassID'
      'FROM tblEmployees'
      'WHERE Active = "T"'
      'Order by Name')
    Left = 568
    Top = 400
    object qryEmployeesName: TWideStringField
      DisplayWidth = 25
      FieldName = 'Name'
      Origin = '.Name'
      Size = 81
    end
    object qryEmployeesEmployeeID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblEmployees.EmployeeID'
      Visible = False
    end
    object qryEmployeesDefaultClassName: TWideStringField
      FieldName = 'DefaultClassName'
      Size = 255
    end
    object qryEmployeesDefaultClassID: TIntegerField
      FieldName = 'DefaultClassID'
    end
  end
  object dsMessages: TDataSource
    DataSet = qryMessages
    Left = 507
    Top = 432
  end
  object qryContactNames: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select Id as clientID, Name as company  , '
      '         '#9'if(Type like  "Job%"  , ID , 0) as JobId,'
      
        '                if((Type like "Customer%" or Type like  "Job%" o' +
        'r Type like "Prospect%"  ) , ID , 0) as  customerId,'
      
        'if((Type like "Customer%" or Type like  "Job%" or Type like "Pro' +
        'spect%") , ID , 0) as  Client_ID,'
      '         '#9'if(Type like "Prospect%" , ID , 0) as ProspectID,'
      '         '#9'if(Type like "Supplier%" , ID , 0) as supplierId, '
      '         '#9'if(Type like "Marketing Contact%" , ID , 0) as MCId, '
      '         '#9'if(Type like "Employee%" , ID , 0) as EmployeeID, '
      '         '#9'Type,'
      '         '#9'contactId , '
      '         '#9'Contactname, CallPriority,DefaultContactMethod'
      'FROM'
      '`tmp_1` AS `T`')
    Left = 537
    Top = 400
    object qryContactNamesclientID: TIntegerField
      FieldName = 'clientID'
      Origin = 'tmp_1.clientID'
    end
    object qryContactNamesCallPriority: TIntegerField
      FieldName = 'CallPriority'
      Origin = 'tmp_1.CallPriority'
    end
    object qryContactNamesDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
      Origin = 'tmp_1.DefaultContactMethod'
    end
    object qryContactNamesCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tmp_1.company'
      Size = 122
    end
    object qryContactNamesSupplierID: TLargeintField
      FieldName = 'SupplierID'
      Origin = '.supplierId'
    end
    object qryContactNamesCustomerID: TLargeintField
      FieldName = 'CustomerID'
      Origin = '.customerId'
    end
    object qryContactNamesJobId: TLargeintField
      FieldName = 'JobId'
      Origin = '.JobId'
    end
    object qryContactNamesProspectID: TLargeintField
      FieldName = 'ProspectID'
      Origin = '.ProspectID'
    end
    object qryContactNamesMCId: TLargeintField
      FieldName = 'MCId'
      Origin = '.MCId'
    end
    object qryContactNamescontactId: TLargeintField
      FieldName = 'contactId'
      Origin = 'tmp_1.contactId'
    end
    object qryContactNamesContactname: TWideStringField
      FieldName = 'Contactname'
      Origin = 'tmp_1.Contactname'
      Size = 122
    end
    object qryContactNamesEmployeeID: TLargeintField
      FieldName = 'EmployeeID'
      Origin = '.EmployeeID'
    end
    object qryContactNamesType: TWideStringField
      FieldName = 'Type'
      Size = 60
    end
    object qryContactNamesClient_ID: TLargeintField
      FieldName = 'Client_ID'
    end
  end
  object dsContactNames: TDataSource
    DataSet = qryContactNames
    Left = 537
    Top = 432
  end
  object qryMediaType: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT  tblSource.MedTypeID, tblSource.MediaType, tblSource.Acti' +
        've '
      'FROM tblSource '
      
        'WHERE (((tblSource.MediaType)>" ") And ((tblSource.Active)<>'#39'F'#39')' +
        ') '
      'ORDER BY tblSource.MediaType')
    Left = 598
    Top = 400
    object qryMediaTypeMediaType: TWideStringField
      DisplayWidth = 20
      FieldName = 'MediaType'
      Size = 50
    end
    object qryMediaTypeMedTypeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'MedTypeID'
      Visible = False
    end
  end
  object lsTDNMSpeedButtonActions: TActionList
    Left = 566
    Top = 434
    object actLead: TDNMAction
      Caption = '&Lead'
      HelpContext = 307065
      OnExecute = actLeadExecute
      OnUpdate = actLeadUpdate
      buttoncolor = clWhite
    end
    object actSupport: TDNMAction
      Caption = 'Support'
      HelpContext = 307066
      OnExecute = actSupportExecute
      OnUpdate = actSupportUpdate
      buttoncolor = clWhite
    end
  end
  object qrymessageLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblmessageLines')
    AfterInsert = qrymessageLinesAfterInsert
    OnCalcFields = qrymessageLinesCalcFields
    IndexFieldNames = 'Id desc'
    Left = 379
    Top = 400
    object qrymessageLinesDateAndTime: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'DateAndTime'
      Origin = 'tblmessagelines.DateAndTime'
    end
    object qrymessageLinesCallPriority: TIntegerField
      DisplayLabel = 'Call Priority'
      DisplayWidth = 10
      FieldName = 'CallPriority'
      Origin = 'tblmessagelines.CallPriority'
    end
    object qrymessageLinesDetails: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Details'
      Origin = 'tblmessagelines.Details'
      BlobType = ftWideMemo
    end
    object qrymessageLinesEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 50
      FieldName = 'EmployeeName'
      Origin = 'tblmessagelines.EmployeeName'
      Size = 50
    end
    object qrymessageLinesResponsedueOn: TDateField
      DisplayLabel = 'Due'
      DisplayWidth = 10
      FieldName = 'ResponsedueOn'
      Origin = 'tblmessagelines.ResponsedueOn'
    end
    object qrymessageLinesResponsedueTimeFrom: TTimeField
      DisplayWidth = 10
      FieldName = 'ResponsedueTimeFrom'
      Origin = 'tblmessagelines.ResponsedueTimeFrom'
    end
    object qrymessageLinesResponsedueTimeTo: TTimeField
      DisplayWidth = 10
      FieldName = 'ResponsedueTimeTo'
      Origin = 'tblmessagelines.ResponsedueTimeTo'
    end
    object qrymessageLinesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblmessagelines.GlobalRef'
      Visible = False
      Size = 255
    end
    object qrymessageLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblmessagelines.ID'
      Visible = False
    end
    object qrymessageLinesMessagesID: TIntegerField
      FieldName = 'MessagesID'
      Origin = 'tblmessagelines.MessagesID'
      Visible = False
    end
    object qrymessageLinesEmployeeId: TIntegerField
      FieldName = 'EmployeeId'
      Origin = 'tblmessagelines.EmployeeId'
      Visible = False
    end
    object qrymessageLinesDeptId: TIntegerField
      DisplayWidth = 10
      FieldName = 'DeptId'
      Origin = 'tblmessagelines.DeptId'
    end
    object qrymessageLinesDeptName: TWideStringField
      DisplayWidth = 50
      FieldName = 'DeptName'
      Origin = 'tblmessagelines.DeptName'
      Size = 50
    end
    object qrymessageLinesDone: TWideStringField
      FieldName = 'Done'
      Origin = 'tblmessagelines.Done'
      FixedChar = True
      Size = 1
    end
    object qrymessageLinesMessageType: TWideStringField
      FieldName = 'MessageType'
      FixedChar = True
      Size = 1
    end
    object qrymessageLinesActiontype: TWideStringField
      FieldName = 'Actiontype'
      FixedChar = True
      Size = 1
    end
    object qrymessageLinescActiontype: TStringField
      FieldKind = fkCalculated
      FieldName = 'cActiontype'
      Size = 50
      Calculated = True
    end
    object qrymessageLinescMessagetype: TStringField
      FieldKind = fkCalculated
      FieldName = 'cMessagetype'
      Size = 50
      Calculated = True
    end
    object qrymessageLinesTypeID: TIntegerField
      FieldName = 'TypeID'
    end
    object qrymessageLinesTypeName: TWideStringField
      FieldName = 'TypeName'
      Size = 100
    end
    object qrymessageLinesEnteredBy: TIntegerField
      FieldName = 'EnteredBy'
    end
    object qrymessageLinesEnteredByname: TWideStringField
      FieldName = 'EnteredByname'
      Size = 100
    end
    object qrymessageLinesTimeSinceLast: TDateTimeField
      FieldName = 'TimeSinceLast'
    end
    object qrymessageLinesPeriodSinceLast: TStringField
      FieldKind = fkCalculated
      FieldName = 'PeriodSinceLast'
      Size = 255
      Calculated = True
    end
    object qrymessageLinesSupportLogID: TIntegerField
      FieldName = 'SupportLogID'
    end
  end
  object dsmessageLines: TDataSource
    DataSet = qrymessageLines
    Left = 379
    Top = 432
  end
  object cboClassQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassID,'
      'ClassName, '
      ' Active'
      'FROM tblClass'
      'WHERE ClassName Is Not Null'
      'ORDER BY  Classname;')
    Left = 347
    Top = 399
    object cboClassQryClassName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 60
      FieldName = 'ClassName'
      Size = 60
    end
    object cboClassQryActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object cboClassQryClassID: TIntegerField
      FieldName = 'ClassID'
      Visible = False
    end
  end
  object qryReps: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select EmployeeID, EmployeeName'
      'from tblEmployees'
      'where Rep = "T" and Active = "T"')
    Left = 792
    Top = 400
  end
  object qryMessagetype: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'MessageType'#39
      'ORDER BY Name')
    Left = 760
    Top = 400
    object qryMessagetypename: TWideStringField
      DisplayWidth = 15
      FieldName = 'name'
      Size = 255
    end
    object qryMessagetypeid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object qryMessagetypeTypecode: TWideStringField
      FieldName = 'Typecode'
      Visible = False
      Size = 30
    end
  end
end
