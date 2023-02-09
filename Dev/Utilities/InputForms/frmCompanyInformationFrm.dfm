inherited frmCompanyInformation: TfrmCompanyInformation
  Left = 452
  Top = 288
  HelpContext = 251000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biMinimize]
  Caption = 'Company Information'
  ClientHeight = 612
  ClientWidth = 761
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  ExplicitLeft = 452
  ExplicitTop = 288
  ExplicitWidth = 777
  ExplicitHeight = 651
  DesignSize = (
    761
    612)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 123
    Width = 761
    HelpContext = 251060
    ExplicitTop = 509
    ExplicitWidth = 761
  end
  inherited imgGridWatermark: TImage
    Left = 107
    Top = 8
    HelpContext = 251001
    ExplicitLeft = 107
    ExplicitTop = 8
  end
  object Label2: TLabel [5]
    Left = 592
    Top = 6
    Width = 102
    Height = 15
    HelpContext = 251037
    Alignment = taRightJustify
    Caption = 'Owner First Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object Label7: TLabel [6]
    Left = 592
    Top = 28
    Width = 102
    Height = 15
    HelpContext = 251075
    Alignment = taRightJustify
    Caption = 'Owner Last Name'
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
  object Label13: TLabel [7]
    Left = 670
    Top = 50
    Width = 24
    Height = 15
    HelpContext = 251085
    Alignment = taRightJustify
    Caption = 'Title'
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
  object DNMPanel1: TDNMPanel [8]
    AlignWithMargins = True
    Left = 3
    Top = 126
    Width = 755
    Height = 441
    HelpContext = 251015
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Bevel5: TBevel
      Left = 12
      Top = 259
      Width = 723
      Height = 38
      HelpContext = 251066
    end
    object Bevel4: TBevel
      Left = 397
      Top = 301
      Width = 338
      Height = 62
      HelpContext = 251061
    end
    object Bevel3: TBevel
      Left = 225
      Top = 301
      Width = 170
      Height = 98
      HelpContext = 251062
    end
    object Bevel2: TBevel
      Left = 12
      Top = 303
      Width = 210
      Height = 98
      HelpContext = 251063
    end
    object Box20: TBevel
      Left = 12
      Top = 16
      Width = 293
      Height = 233
      HelpContext = 251016
    end
    object lblSuburb: TLabel
      Left = 84
      Top = 112
      Width = 21
      Height = 15
      HelpContext = 251017
      Alignment = taRightJustify
      Caption = 'City'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblState: TLabel
      Left = 75
      Top = 140
      Width = 30
      Height = 15
      HelpContext = 251018
      Alignment = taRightJustify
      Caption = 'State'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblPostCode: TLabel
      Left = 47
      Top = 169
      Width = 58
      Height = 15
      HelpContext = 251019
      Alignment = taRightJustify
      Caption = 'Post Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Country_Label: TLabel
      Left = 61
      Top = 197
      Width = 44
      Height = 15
      HelpContext = 251020
      Alignment = taRightJustify
      Caption = 'Country'
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
    object Label33: TLabel
      Left = 47
      Top = 55
      Width = 58
      Height = 15
      HelpContext = 251021
      Alignment = taRightJustify
      Caption = 'Address 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Box31: TBevel
      Left = 442
      Top = 16
      Width = 295
      Height = 233
      HelpContext = 251023
    end
    object Address_Label: TLabel
      Left = 57
      Top = 27
      Width = 48
      Height = 15
      HelpContext = 251024
      Alignment = taRightJustify
      Caption = 'Address'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label22: TLabel
      Left = 483
      Top = 27
      Width = 48
      Height = 15
      HelpContext = 251028
      Alignment = taRightJustify
      Caption = 'Address'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblSuburb2: TLabel
      Left = 510
      Top = 112
      Width = 21
      Height = 15
      HelpContext = 251029
      Alignment = taRightJustify
      Caption = 'City'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblState2: TLabel
      Left = 501
      Top = 140
      Width = 30
      Height = 15
      HelpContext = 251030
      Alignment = taRightJustify
      Caption = 'State'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblPostcode2: TLabel
      Left = 473
      Top = 169
      Width = 58
      Height = 15
      HelpContext = 251031
      Alignment = taRightJustify
      Caption = 'Post Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblCountry: TLabel
      Left = 487
      Top = 197
      Width = 44
      Height = 15
      HelpContext = 251032
      Alignment = taRightJustify
      Caption = 'Country'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      OnDblClick = lblCountryDblClick
    end
    object Label35: TLabel
      Left = 473
      Top = 55
      Width = 58
      Height = 15
      HelpContext = 251033
      Alignment = taRightJustify
      Caption = 'Address 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label36: TLabel
      Left = 15
      Top = -2
      Width = 105
      Height = 18
      HelpContext = 251034
      AutoSize = False
      Caption = 'Shipping Address'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label37: TLabel
      Left = 442
      Top = -2
      Width = 105
      Height = 18
      HelpContext = 251035
      AutoSize = False
      Caption = 'Mailing Address'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label1: TLabel
      Left = 404
      Top = 314
      Width = 35
      Height = 15
      HelpContext = 251036
      Alignment = taRightJustify
      Caption = 'E-mail'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label14: TLabel
      Left = 47
      Top = 83
      Width = 58
      Height = 15
      HelpContext = 251038
      Alignment = taRightJustify
      Caption = 'Address 3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label15: TLabel
      Left = 473
      Top = 83
      Width = 58
      Height = 15
      HelpContext = 251039
      Alignment = taRightJustify
      Caption = 'Address 3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Bevel1: TBevel
      Left = 12
      Top = 402
      Width = 723
      Height = 36
      HelpContext = 251022
    end
    object Label3: TLabel
      Left = 311
      Top = 412
      Width = 62
      Height = 15
      HelpContext = 251072
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Site Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label5: TLabel
      Left = 12
      Top = 404
      Width = 91
      Height = 31
      HelpContext = 251064
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Default Class'
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Label6: TLabel
      Left = 533
      Top = 310
      Width = 73
      Height = 15
      HelpContext = 251065
      Alignment = taRightJustify
      Caption = 'Track Emails'
      Transparent = True
    end
    object FaxNumber_Label: TLabel
      Left = 43
      Top = 343
      Width = 20
      Height = 15
      HelpContext = 251026
      Alignment = taRightJustify
      Caption = 'Fax'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label8: TLabel
      Left = 26
      Top = 376
      Width = 37
      Height = 15
      HelpContext = 251073
      Alignment = taRightJustify
      Caption = 'Mobile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 27
      Top = 311
      Width = 36
      Height = 15
      HelpContext = 251025
      Alignment = taRightJustify
      Caption = 'Phone'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 232
      Top = 356
      Width = 71
      Height = 15
      HelpContext = 251027
      Caption = 'Company No'
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
      Left = 232
      Top = 307
      Width = 24
      Height = 15
      HelpContext = 251074
      Caption = 'ABN'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel6: TBevel
      Left = 397
      Top = 366
      Width = 338
      Height = 33
      HelpContext = 251067
    end
    object Label11: TLabel
      Left = 404
      Top = 375
      Width = 51
      Height = 15
      HelpContext = 251076
      Alignment = taRightJustify
      Caption = 'Category'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label12: TLabel
      Left = 520
      Top = 412
      Width = 70
      Height = 15
      Hint = 
        'Default UOM can only be changed once when u start ERP first time' +
        ' on the database '
      HelpContext = 251083
      Alignment = taRightJustify
      Caption = 'Default UOM'
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object Label17: TLabel
      Left = 57
      Top = 269
      Width = 74
      Height = 15
      HelpContext = 251089
      Caption = 'Owner Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblLocationCode: TLabel
      Left = 24
      Top = 226
      Width = 81
      Height = 15
      HelpContext = 496046
      Alignment = taRightJustify
      Caption = 'Location Code'
      Transparent = True
    end
    object Label18: TLabel
      Left = 450
      Top = 226
      Width = 81
      Height = 15
      HelpContext = 496046
      Alignment = taRightJustify
      Caption = 'Location Code'
      Transparent = True
    end
    object txtAddress: TDBMemo
      Left = 112
      Top = 23
      Width = 186
      Height = 23
      HelpContext = 251040
      DataField = 'Address'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object State: TDBEdit
      Left = 112
      Top = 136
      Width = 96
      Height = 23
      HelpContext = 251041
      DataField = 'State'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object Postcode: TDBEdit
      Left = 112
      Top = 165
      Width = 59
      Height = 23
      HelpContext = 251042
      DataField = 'Postcode'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object txtCountry: TDBEdit
      Left = 112
      Top = 193
      Width = 186
      Height = 23
      HelpContext = 251043
      DataField = 'Country'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object txtPOBox: TDBMemo
      Left = 540
      Top = 23
      Width = 186
      Height = 23
      HelpContext = 251045
      DataField = 'POBox'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object State2: TDBEdit
      Left = 540
      Top = 136
      Width = 105
      Height = 23
      HelpContext = 251046
      DataField = 'POState'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object Postcode2: TDBEdit
      Left = 540
      Top = 165
      Width = 105
      Height = 23
      HelpContext = 251047
      DataField = 'POPostcode'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object txtPOCountry: TDBEdit
      Left = 540
      Top = 193
      Width = 186
      Height = 23
      HelpContext = 251048
      DataField = 'POCountry'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
    end
    object txtAddress2: TDBMemo
      Left = 112
      Top = 51
      Width = 186
      Height = 23
      HelpContext = 251049
      DataField = 'Address2'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object txtPOBox2: TDBMemo
      Left = 540
      Top = 51
      Width = 186
      Height = 23
      HelpContext = 251050
      DataField = 'POBox2'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object cmdCopy: TDNMSpeedButton
      Left = 333
      Top = 112
      Width = 72
      Height = 29
      Hint = 'Copy "Shipping Address" to "Mailing Address"'
      HelpContext = 251051
      Caption = 'C&opy>>'
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
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = cmdCopyClick
    end
    object Suburb: TwwDBLookupCombo
      Left = 112
      Top = 108
      Width = 186
      Height = 23
      HelpContext = 251052
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'City_sub'#9'20'#9'Suburb'#9'T'
        'State'#9'4'#9'State'#9'T'
        'Postcode'#9'4'#9'Postcode'#9'T')
      DataField = 'City'
      DataSource = frmCompanyInformationSrc
      LookupTable = qrySuburb
      LookupField = 'City_sub'
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = SuburbCloseUp
      OnEnter = SuburbEnter
      OnNotInList = SuburbNotInList
    end
    object Suburb2: TwwDBLookupCombo
      Left = 540
      Top = 108
      Width = 186
      Height = 23
      HelpContext = 251053
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'City_sub'#9'20'#9'Suburb'#9'T'
        'State'#9'4'#9'State'#9'T'
        'Postcode'#9'4'#9'Postcode'#9'T')
      DataField = 'POCity'
      DataSource = frmCompanyInformationSrc
      LookupTable = qrySuburb
      LookupField = 'City_sub'
      ParentFont = False
      TabOrder = 11
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = Suburb2CloseUp
      OnEnter = Suburb2Enter
      OnNotInList = Suburb2NotInList
    end
    object edtEmail: TDBEdit
      Left = 404
      Top = 335
      Width = 323
      Height = 23
      HelpContext = 251054
      DataField = 'Email'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
    end
    object txtPhoneNumber: TwwDBEdit
      Left = 69
      Top = 307
      Width = 145
      Height = 23
      HelpContext = 251056
      DataField = 'PhoneNumber'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = txtFaxNumberExit
    end
    object txtFaxNumber: TwwDBEdit
      Left = 69
      Top = 339
      Width = 145
      Height = 23
      HelpContext = 251057
      DataField = 'FaxNumber'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = txtFaxNumberExit
    end
    object txtAddress3: TDBMemo
      Left = 112
      Top = 79
      Width = 186
      Height = 23
      HelpContext = 251058
      DataField = 'Address3'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object txtPOBox3: TDBMemo
      Left = 540
      Top = 79
      Width = 186
      Height = 23
      HelpContext = 251059
      DataField = 'POBox3'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object edtSiteCode: TDBEdit
      Left = 379
      Top = 408
      Width = 48
      Height = 23
      HelpContext = 251077
      DataField = 'SiteCode'
      DataSource = DSBranchCode
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 21
      OnExit = edtSiteCodeExit
    end
    object cboDefaultClass: TwwDBLookupCombo
      Left = 111
      Top = 408
      Width = 169
      Height = 23
      HelpContext = 251068
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'30'#9'Class Name'#9'T')
      DataField = 'DefaultClass'
      DataSource = dsColumnHeadings
      LookupTable = qryDepartments
      LookupField = 'ClassName'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 20
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboDefaultClassChange
      OnBeforeDropDown = cboDefaultClassBeforeDropDown
    end
    object chkTrackEmails: TwwCheckBox
      Left = 611
      Top = 311
      Width = 17
      Height = 13
      HelpContext = 251069
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
      DataField = 'TrackEmails'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 18
    end
    object btnEmailConfig: TDNMSpeedButton
      Left = 633
      Top = 304
      Width = 87
      Height = 27
      HelpContext = 251070
      Caption = 'Email Config'
      Default = True
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
      TabOrder = 19
      AutoDisableParentOnclick = True
      OnClick = btnEmailConfigClick
    end
    object wwDBEdit1: TwwDBEdit
      Left = 69
      Top = 372
      Width = 145
      Height = 23
      HelpContext = 251078
      DataField = 'MobileNumber'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 22
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = txtFaxNumberExit
    end
    object txtABN: TDBEdit
      Left = 232
      Top = 322
      Width = 158
      Height = 23
      HelpContext = 251044
      DataField = 'ABN'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 23
    end
    object edtCompanyNumber: TDBEdit
      Left = 232
      Top = 372
      Width = 158
      Height = 23
      HelpContext = 251079
      DataField = 'CompanyNumber'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 24
    end
    object wwDBEdit2: TwwDBEdit
      Left = 465
      Top = 371
      Width = 262
      Height = 23
      HelpContext = 251082
      DataField = 'CompanyCategory'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 25
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object DBEdit2: TDBEdit
      Left = 600
      Top = 408
      Width = 127
      Height = 23
      Hint = 
        'Default UOM can only be changed once when u start ERP first time' +
        ' on the database '
      HelpContext = 251084
      DataField = 'DefaultUOM'
      DataSource = dsColumnHeadings
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 26
      OnExit = edtSiteCodeExit
    end
    object btnUpdateAllGlobalrefs: TDNMSpeedButton
      Left = 433
      Top = 407
      Width = 31
      Height = 25
      Hint = 'Update Alll Global Refs with the Current Default Site Code'
      HelpContext = 251086
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 27
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnUpdateAllGlobalrefsClick
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 137
      Top = 265
      Width = 318
      Height = 23
      HelpContext = 251090
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'25'#9'EmployeeName'#9'F')
      DataField = 'ContactName'
      DataSource = frmCompanyInformationSrc
      LookupTable = cboEmployeeLookup
      LookupField = 'EmployeeName'
      DropDownWidth = 300
      ParentFont = False
      TabOrder = 28
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnCloseUp = cboEmployeeCloseUp
    end
    object edtLocationCode: TwwDBEdit
      Left = 112
      Top = 222
      Width = 89
      Height = 23
      HelpContext = 496049
      DataField = 'LocationCode'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 29
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit3: TwwDBEdit
      Left = 540
      Top = 222
      Width = 89
      Height = 23
      HelpContext = 496049
      DataField = 'POLocationcode'
      DataSource = frmCompanyInformationSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 30
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object edtFirstName: TDBEdit [9]
    Left = 700
    Top = 3
    Width = 162
    Height = 23
    HelpContext = 251055
    DataField = 'FirstName'
    DataSource = frmCompanyInformationSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
  end
  object edtLastName: TDBEdit [10]
    Left = 700
    Top = 25
    Width = 193
    Height = 23
    HelpContext = 251080
    DataField = 'LastName'
    DataSource = frmCompanyInformationSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Visible = False
  end
  object edtTitle: TDBEdit [11]
    Left = 700
    Top = 47
    Width = 66
    Height = 23
    HelpContext = 251087
    DataField = 'Title'
    DataSource = frmCompanyInformationSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Visible = False
  end
  object DNMPanel2: TDNMPanel [12]
    Left = 0
    Top = 570
    Width = 761
    Height = 42
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    DesignSize = (
      761
      42)
    object cmdClose: TDNMSpeedButton
      Left = 78
      Top = 6
      Width = 105
      Height = 29
      HelpContext = 251008
      Anchors = [akBottom]
      Caption = '&Save'
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
    object cmdCustomise: TDNMSpeedButton
      Left = 328
      Top = 6
      Width = 105
      Height = 29
      HelpContext = 251004
      Anchors = [akBottom]
      Caption = 'Custo&mise'
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
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = cmdCustomiseClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 578
      Top = 6
      Width = 105
      Height = 29
      HelpContext = 251005
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
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 203
      Top = 6
      Width = 105
      Height = 29
      HelpContext = 251004
      Anchors = [akBottom]
      Caption = 'Company Logo'
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
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton1Click
    end
    object DNMSpeedButton2: TDNMSpeedButton
      Left = 453
      Top = 6
      Width = 105
      Height = 29
      HelpContext = 251004
      Anchors = [akBottom]
      Caption = 'Upgrade to VS1'
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
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton2Click
    end
  end
  object DNMPanel3: TDNMPanel [13]
    Left = 0
    Top = 0
    Width = 761
    Height = 123
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object CompanyName_Label: TLabel
      Left = 180
      Top = 63
      Width = 94
      Height = 18
      HelpContext = 251002
      AutoSize = False
      Caption = 'Company Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label16: TLabel
      Left = 166
      Top = 92
      Width = 108
      Height = 18
      HelpContext = 251088
      AutoSize = False
      Caption = 'Company Industry'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object pnlTitle: TDNMPanel
      Left = 226
      Top = 4
      Width = 338
      Height = 53
      HelpContext = 251010
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 334
        Height = 49
        HelpContext = 251011
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
          Width = 334
          Height = 49
          HelpContext = 251012
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Please Enter your  Company'#39's Name and Address'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
      end
    end
    object txtCompanyName: TDBEdit
      Left = 276
      Top = 61
      Width = 254
      Height = 23
      HelpContext = 251006
      DataField = 'CompanyName'
      DataSource = frmCompanyInformationSrc
      TabOrder = 1
    end
    object cbIndustry: TwwDBLookupCombo
      Left = 276
      Top = 90
      Width = 254
      Height = 23
      HelpContext = 251091
      DropDownAlignment = taLeftJustify
      LookupTable = qryIndustries
      LookupField = 'IndustryName'
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cbIndustryCloseUp
    end
    object pnlcompanyLogo: TDNMPanel
      AlignWithMargins = True
      Left = 569
      Top = 4
      Width = 188
      Height = 115
      Align = alRight
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object imgcompanyLogo: TImage
        AlignWithMargins = True
        Left = 135
        Top = 3
        Width = 50
        Height = 109
        Hint = 'Double Click  to Choose Company Logo'
        HelpContext = 314463
        Align = alRight
        AutoSize = True
        ParentShowHint = False
        Proportional = True
        ShowHint = True
        Stretch = True
        OnDblClick = chooseLogo
        ExplicitHeight = 50
      end
    end
    object cboRegion: TwwDBLookupCombo
      Left = 536
      Top = 90
      Width = 161
      Height = 23
      HelpContext = 251071
      DropDownAlignment = taLeftJustify
      LookupTable = qryRegions
      LookupField = 'Region'
      TabOrder = 3
      Visible = False
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboRegionCloseUp
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 478
    Top = 208
  end
  inherited tmrdelay: TTimer
    Left = 520
    Top = 208
  end
  inherited popSpelling: TPopupMenu
    Left = 146
    Top = 208
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 270
    Top = 208
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 312
    Top = 208
  end
  inherited MyConnection: TERPConnection
    Database = 'aus_sample_company'
    Server = 'localhost'
    Connected = True
    Left = 146
    Top = 239
  end
  inherited DataState: TDataState
    Left = 353
    Top = 208
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 187
    Top = 208
  end
  inherited imgsort: TImageList
    Left = 395
    Top = 208
    Bitmap = {
      494C010102006400CC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 321
    Top = 239
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 436
    Top = 208
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 229
    Top = 208
  end
  inherited qryMemTrans: TERPQuery
    Left = 181
    Top = 239
  end
  object frmCompanyInformationSrc: TDataSource
    DataSet = CompanyInfo
    Left = 392
    Top = 275
  end
  object CompanyInfo: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblCompanyInformation'
      'WHERE SetupID=:KeyID;')
    AfterOpen = CompanyInfoAfterOpen
    Left = 392
    Top = 239
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object CompanyInfoSetupID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'SetupID'
      Origin = 'tblCompanyInformation.SetupID'
      ReadOnly = True
    end
    object CompanyInfoCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Origin = 'tblCompanyInformation.CompanyName'
      Size = 200
    end
    object CompanyInfoTradingName: TWideStringField
      FieldName = 'TradingName'
      Origin = 'tblCompanyInformation.TradingName'
      Size = 200
    end
    object CompanyInfoContactName: TWideStringField
      FieldName = 'ContactName'
      Origin = 'tblCompanyInformation.ContactName'
      Size = 255
    end
    object CompanyInfoContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Origin = 'tblCompanyInformation.ContactEmail'
      Size = 255
    end
    object CompanyInfoPhoneNumber: TWideStringField
      FieldName = 'PhoneNumber'
      Origin = 'tblCompanyInformation.PhoneNumber'
      EditMask = '(##)#### ####;0;_'
      Size = 255
    end
    object CompanyInfoFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblCompanyInformation.FaxNumber'
      EditMask = '(##)#### ####;0;_'
      Size = 255
    end
    object CompanyInfoABN: TWideStringField
      DisplayWidth = 15
      FieldName = 'ABN'
      Origin = 'tblCompanyInformation.ABN'
      EditMask = '## ### ### ###;0;_'
      Size = 15
    end
    object CompanyInfoEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblCompanyInformation.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object CompanyInfoPOBox: TWideStringField
      FieldName = 'POBox'
      Origin = 'tblCompanyInformation.POBox'
      Size = 255
    end
    object CompanyInfoPOBox2: TWideStringField
      FieldName = 'POBox2'
      Origin = 'tblCompanyInformation.POBox2'
      Size = 255
    end
    object CompanyInfoPOBox3: TWideStringField
      FieldName = 'POBox3'
      Size = 255
    end
    object CompanyInfoPOCity: TWideStringField
      FieldName = 'POCity'
      Origin = 'tblCompanyInformation.POCity'
      Size = 255
    end
    object CompanyInfoPOState: TWideStringField
      FieldName = 'POState'
      Origin = 'tblCompanyInformation.POState'
      Size = 255
    end
    object CompanyInfoPOPostcode: TWideStringField
      FieldName = 'POPostcode'
      Origin = 'tblCompanyInformation.POPostcode'
      Size = 255
    end
    object CompanyInfoPOCountry: TWideStringField
      FieldName = 'POCountry'
      Origin = 'tblCompanyInformation.POCountry'
      Size = 255
    end
    object CompanyInfoETPPayerType: TWideStringField
      FieldName = 'ETPPayerType'
      Origin = 'tblCompanyInformation.ETPPayerType'
      FixedChar = True
      Size = 1
    end
    object CompanyInfoFileReference: TWideStringField
      FieldName = 'FileReference'
      Origin = 'tblCompanyInformation.FileReference'
      Size = 16
    end
    object CompanyInfoTaxSignatory: TWideStringField
      FieldName = 'TaxSignatory'
      Origin = 'tblCompanyInformation.TaxSignatory'
      Size = 38
    end
    object CompanyInfoLeaveLoadingPercent: TFloatField
      FieldName = 'LeaveLoadingPercent'
      Origin = 'tblCompanyInformation.LeaveLoadingPercent'
    end
    object CompanyInfoCompulsorySuperPercent: TFloatField
      FieldName = 'CompulsorySuperPercent'
      Origin = 'tblCompanyInformation.CompulsorySuperPercent'
    end
    object CompanyInfoBSB: TWideStringField
      FieldName = 'BSB'
      Origin = 'tblCompanyInformation.BSB'
      Size = 10
    end
    object CompanyInfoAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Origin = 'tblCompanyInformation.AccountNo'
      Size = 50
    end
    object CompanyInfoFontCompanyName: TWideStringField
      FieldName = 'FontCompanyName'
      Origin = 'tblCompanyInformation.FontCompanyName'
      Size = 50
    end
    object CompanyInfoFontAddress: TWideStringField
      FieldName = 'FontAddress'
      Origin = 'tblCompanyInformation.FontAddress'
      Size = 50
    end
    object CompanyInfoFontSuburb: TWideStringField
      FieldName = 'FontSuburb'
      Origin = 'tblCompanyInformation.FontSuburb'
      Size = 50
    end
    object CompanyInfoFontPhone: TWideStringField
      FieldName = 'FontPhone'
      Origin = 'tblCompanyInformation.FontPhone'
      Size = 50
    end
    object CompanyInfoFontABN: TWideStringField
      FieldName = 'FontABN'
      Origin = 'tblCompanyInformation.FontABN'
      Size = 50
    end
    object CompanyInfoFontDefault: TWideStringField
      FieldName = 'FontDefault'
      Origin = 'tblCompanyInformation.FontDefault'
      Size = 50
    end
    object CompanyInfoSizeCompanyName: TIntegerField
      FieldName = 'SizeCompanyName'
      Origin = 'tblCompanyInformation.SizeCompanyName'
    end
    object CompanyInfoSizeAddress: TIntegerField
      FieldName = 'SizeAddress'
      Origin = 'tblCompanyInformation.SizeAddress'
    end
    object CompanyInfoSizeSuburb: TIntegerField
      FieldName = 'SizeSuburb'
      Origin = 'tblCompanyInformation.SizeSuburb'
    end
    object CompanyInfoSizePhone: TIntegerField
      FieldName = 'SizePhone'
      Origin = 'tblCompanyInformation.SizePhone'
    end
    object CompanyInfoSizeABN: TIntegerField
      FieldName = 'SizeABN'
      Origin = 'tblCompanyInformation.SizeABN'
    end
    object CompanyInfoSizeDefault: TIntegerField
      FieldName = 'SizeDefault'
      Origin = 'tblCompanyInformation.SizeDefault'
    end
    object CompanyInfoColorCompanyName: TWideStringField
      FieldName = 'ColorCompanyName'
      Origin = 'tblCompanyInformation.ColorCompanyName'
      Size = 50
    end
    object CompanyInfoColorAddress: TWideStringField
      FieldName = 'ColorAddress'
      Origin = 'tblCompanyInformation.ColorAddress'
      Size = 50
    end
    object CompanyInfoColorSuburb: TWideStringField
      FieldName = 'ColorSuburb'
      Origin = 'tblCompanyInformation.ColorSuburb'
      Size = 50
    end
    object CompanyInfoColorPhone: TWideStringField
      FieldName = 'ColorPhone'
      Origin = 'tblCompanyInformation.ColorPhone'
      Size = 50
    end
    object CompanyInfoColorABN: TWideStringField
      FieldName = 'ColorABN'
      Origin = 'tblCompanyInformation.ColorABN'
      Size = 50
    end
    object CompanyInfoColorDefault: TWideStringField
      FieldName = 'ColorDefault'
      Origin = 'tblCompanyInformation.ColorDefault'
      Size = 50
    end
    object CompanyInfoStyleCompanyName: TWideStringField
      FieldName = 'StyleCompanyName'
      Origin = 'tblCompanyInformation.StyleCompanyName'
      Size = 4
    end
    object CompanyInfoStyleAddress: TWideStringField
      FieldName = 'StyleAddress'
      Origin = 'tblCompanyInformation.StyleAddress'
      Size = 4
    end
    object CompanyInfoStyleSuburb: TWideStringField
      FieldName = 'StyleSuburb'
      Origin = 'tblCompanyInformation.StyleSuburb'
      Size = 4
    end
    object CompanyInfoStylePhone: TWideStringField
      FieldName = 'StylePhone'
      Origin = 'tblCompanyInformation.StylePhone'
      Size = 4
    end
    object CompanyInfoStyleABN: TWideStringField
      FieldName = 'StyleABN'
      Origin = 'tblCompanyInformation.StyleABN'
      Size = 4
    end
    object CompanyInfoStyleDefault: TWideStringField
      FieldName = 'StyleDefault'
      Origin = 'tblCompanyInformation.StyleDefault'
      Size = 4
    end
    object CompanyInfoBankCode: TIntegerField
      FieldName = 'BankCode'
      Origin = 'tblCompanyInformation.BankCode'
    end
    object CompanyInfoBankBranch: TWideStringField
      FieldName = 'BankBranch'
      Origin = 'tblCompanyInformation.BankBranch'
      Size = 150
    end
    object CompanyInfoAPCANo: TWideStringField
      FieldName = 'APCANo'
      Origin = 'tblCompanyInformation.APCANo'
      Size = 50
    end
    object CompanyInfoWorkersCompInsurer: TIntegerField
      FieldName = 'WorkersCompInsurer'
      Origin = 'tblCompanyInformation.WorkersCompInsurer'
    end
    object CompanyInfoEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'tblCompanyInformation.Email'
      Size = 255
    end
    object CompanyInfoGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblCompanyInformation.GlobalRef'
      Size = 255
    end
    object CompanyInfoAddress: TWideStringField
      FieldName = 'Address'
      Origin = 'tblCompanyInformation.Address'
      Size = 255
    end
    object CompanyInfoAddress2: TWideStringField
      FieldName = 'Address2'
      Origin = 'tblCompanyInformation.Address2'
      Size = 255
    end
    object CompanyInfoAddress3: TWideStringField
      FieldName = 'Address3'
      Size = 255
    end
    object CompanyInfoCity: TWideStringField
      FieldName = 'City'
      Origin = 'tblCompanyInformation.City'
      Size = 255
    end
    object CompanyInfoState: TWideStringField
      FieldName = 'State'
      Origin = 'tblCompanyInformation.State'
      Size = 255
    end
    object CompanyInfoPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblCompanyInformation.Postcode'
      Size = 255
    end
    object CompanyInfoCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblCompanyInformation.Country'
      Size = 255
    end
    object CompanyInfoURL: TWideStringField
      FieldName = 'URL'
      Origin = 'tblCompanyInformation.URL'
      Size = 255
    end
    object CompanyInfoContact: TWideStringField
      FieldName = 'Contact'
      Origin = 'tblCompanyInformation.Contact'
      Size = 255
    end
    object CompanyInfoMenuColor: TIntegerField
      FieldName = 'MenuColor'
      Origin = 'tblCompanyInformation.MenuColor'
    end
    object CompanyInfoSupplierId: TWideStringField
      FieldName = 'SupplierId'
      Origin = 'tblCompanyInformation.SupplierId'
      Size = 30
    end
    object CompanyInfoDVAABN: TWideStringField
      FieldName = 'DVAABN'
      Origin = 'tblCompanyInformation.DVAABN'
      Size = 100
    end
    object CompanyInfoRAPloginID: TWideStringField
      FieldName = 'RAPloginID'
      Origin = 'tblCompanyInformation.RAPloginID'
      Size = 100
    end
    object CompanyInfoRAPPassword: TWideStringField
      FieldName = 'RAPPassword'
      Origin = 'tblCompanyInformation.RAPPassword'
      Size = 100
    end
    object CompanyInfoRAPLoginPage: TWideStringField
      FieldName = 'RAPLoginPage'
      Origin = 'tblCompanyInformation.RAPLoginPage'
      Size = 255
    end
    object CompanyInfoRAPProgramName: TWideStringField
      FieldName = 'RAPProgramName'
      Origin = 'tblCompanyInformation.RAPProgramName'
      Size = 255
    end
    object CompanyInfoRAPInvoiceDescription: TWideStringField
      FieldName = 'RAPInvoiceDescription'
      Origin = 'tblCompanyInformation.RAPInvoiceDescription'
      Size = 255
    end
    object CompanyInfoRAPProductGroup: TWideStringField
      FieldName = 'RAPProductGroup'
      Origin = 'tblCompanyInformation.RAPProductGroup'
      Size = 255
    end
    object CompanyInfoRAPContractNumber: TWideStringField
      FieldName = 'RAPContractNumber'
      Origin = 'tblCompanyInformation.RAPContractNumber'
      Size = 100
    end
    object CompanyInfoCompanyNumber: TWideStringField
      FieldName = 'CompanyNumber'
      Size = 255
    end
    object CompanyInfoTrackEmails: TWideStringField
      FieldName = 'TrackEmails'
      FixedChar = True
      Size = 1
    end
    object CompanyInfoFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 100
    end
    object CompanyInfoLastName: TWideStringField
      FieldName = 'LastName'
      Size = 155
    end
    object CompanyInfoMobileNumber: TWideStringField
      FieldName = 'MobileNumber'
      Size = 155
    end
    object CompanyInfoCompanyCategory: TWideStringField
      FieldName = 'CompanyCategory'
      Size = 255
    end
    object CompanyInfoTitle: TWideStringField
      FieldName = 'Title'
      Size = 32
    end
    object CompanyInfoEmployeeId: TIntegerField
      FieldName = 'EmployeeId'
    end
    object CompanyInfoIndustryId: TIntegerField
      FieldName = 'IndustryId'
    end
    object CompanyInfoLocationcode: TWideStringField
      FieldName = 'Locationcode'
      Size = 50
    end
    object CompanyInfoPOLocationcode: TWideStringField
      FieldName = 'POLocationcode'
      Size = 50
    end
  end
  object qryInsert: TERPQuery
    Connection = MyConnection
    Left = 357
    Top = 239
  end
  object tblColumnHeadings: TMyTable
    TableName = 'tblcolumnheadings'
    Connection = MyConnection
    Left = 216
    Top = 239
  end
  object DSBranchCode: TDataSource
    DataSet = qryBranchCode
    Left = 251
    Top = 275
  end
  object qryBranchCode: TERPQuery
    Connection = MyConnection
    ParamCheck = False
    SQL.Strings = (
      
        'SELECT BackEndID, SiteCode ,SiteDesc ,BEDefault,EmailAddressData' +
        ', EmailUsername, EmailPassword, ConflictTodoUserId  FROM tblmsba' +
        'ckendid')
    AfterInsert = qryBranchCodeAfterInsert
    Left = 251
    Top = 239
    object qryBranchCodeBEDefault: TWideStringField
      DisplayLabel = 'Def'
      DisplayWidth = 3
      FieldName = 'BEDefault'
      Origin = 'tblmsbackendid.BEDefault'
      FixedChar = True
      Size = 1
    end
    object qryBranchCodeSiteCode: TWideStringField
      DisplayLabel = 'Site Code'
      DisplayWidth = 7
      FieldName = 'SiteCode'
      Origin = 'tblmsbackendid.SiteCode'
      OnSetText = qryBranchCodeSiteCodeSetText
      FixedChar = True
      Size = 3
    end
    object qryBranchCodeSiteDesc: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 15
      FieldName = 'SiteDesc'
      Origin = 'tblmsbackendid.SiteDesc'
      Size = 255
    end
    object qryBranchCodeEmailAddressData: TWideStringField
      DisplayLabel = 'Email'
      DisplayWidth = 23
      FieldName = 'EmailAddressData'
      Origin = 'tblmsbackendid.EmailAddressData'
      Size = 255
    end
    object qryBranchCodeEmailUsername: TWideStringField
      DisplayLabel = 'Username'
      DisplayWidth = 12
      FieldName = 'EmailUsername'
      Origin = 'tblmsbackendid.EmailUsername'
      Size = 255
    end
    object qryBranchCodeEmailPassword: TWideStringField
      DisplayLabel = 'Password'
      DisplayWidth = 12
      FieldName = 'EmailPassword'
      Origin = 'tblmsbackendid.EmailPassword'
      Size = 255
    end
    object qryBranchCodeuserName: TWideStringField
      DisplayLabel = 'Conflict Resolver'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'userName'
      LookupDataSet = cboEmployeeLookup
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'ConflictTodoUserId'
      Size = 255
      Lookup = True
    end
    object qryBranchCodeConflictTodoUserId: TIntegerField
      DisplayLabel = 'Conflict Resolver'
      DisplayWidth = 10
      FieldName = 'ConflictTodoUserId'
      Origin = 'tblmsbackendid.ConflictTodoUserId'
      Visible = False
    end
    object qryBranchCodeBackEndID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'BackEndID'
      Origin = 'tblmsbackendid.BackEndID'
      Visible = False
    end
  end
  object qrySuburb: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT LocationID, City_sub, State, Postcode, Country'
      'FROM tblLocations '
      'Where RegionID= :xRegionID'
      'ORDER BY City_sub')
    BeforeOpen = qrySuburbBeforeOpen
    Left = 286
    Top = 239
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object cboEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblEmployees.EmployeeID, Concat(firstname,'#39' '#39',Lastname) A' +
        'S EmployeeName  , Firstname, Lastname'
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY Concat(firstname,'#39' '#39',Lastname);')
    Left = 427
    Top = 239
    object cboEmployeeLookupEmployeeName: TWideStringField
      DisplayWidth = 25
      FieldName = 'EmployeeName'
      Size = 81
    end
    object cboEmployeeLookupEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Visible = False
    end
    object cboEmployeeLookupFirstname: TWideStringField
      FieldName = 'Firstname'
      Size = 40
    end
    object cboEmployeeLookupLastname: TWideStringField
      FieldName = 'Lastname'
      Size = 40
    end
  end
  object qryDepartments: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblclass where active = "T"')
    Left = 532
    Top = 239
  end
  object qryColumnHeadings: TERPQuery
    SQL.Strings = (
      'select * from tblcolumnheadings')
    Left = 497
    Top = 239
  end
  object dsColumnHeadings: TDataSource
    DataSet = qryColumnHeadings
    Left = 497
    Top = 275
  end
  object qryRegions: TMyQuery
    SQL.Strings = (
      'select Region, RegionID from tblRegionalOptions')
    Left = 568
    Top = 239
  end
  object qryIndustries: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select IndustryId, IndustryName'
      'from tblIndustries')
    Left = 672
    Top = 271
    object qryIndustriesIndustryId: TIntegerField
      FieldName = 'IndustryId'
    end
    object qryIndustriesIndustryName: TWideStringField
      FieldName = 'IndustryName'
      Size = 50
    end
  end
  object ERPQuery1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    AutoCalcFields = False
    Options.LongStrings = False
    Left = 458
    Top = 236
  end
  object QryCompanyLogo: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblcomplogo')
    AfterScroll = QryCompanyLogoAfterScroll
    Left = 336
    Top = 287
    object QryCompanyLogoGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object QryCompanyLogoID: TIntegerField
      FieldName = 'ID'
    end
    object QryCompanyLogoSetupID: TIntegerField
      FieldName = 'SetupID'
    end
    object QryCompanyLogoCompLog: TBlobField
      FieldName = 'CompLog'
    end
    object QryCompanyLogoPictype: TWideStringField
      FieldName = 'Pictype'
      FixedChar = True
      Size = 4
    end
    object QryCompanyLogoImageName: TWideStringField
      FieldName = 'ImageName'
      Size = 255
    end
    object QryCompanyLogoImageTypes: TWideStringField
      FieldName = 'ImageTypes'
      Size = 255
    end
    object QryCompanyLogomsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object QryCompanyLogomsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object dsCompanyLogo: TDataSource
    DataSet = QryCompanyLogo
    Left = 336
    Top = 323
  end
end
