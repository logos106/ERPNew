inherited fmContactbase: TfmContactbase
  Left = 874
  Top = 109
  HelpContext = 714000
  Caption = 'fmContactbase'
  ClientHeight = 611
  ClientWidth = 607
  OldCreateOrder = True
  ExplicitWidth = 613
  ExplicitHeight = 640
  DesignSize = (
    607
    611)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 611
    Width = 607
    HelpContext = 714028
    ExplicitTop = 549
    ExplicitWidth = 607
  end
  object pnlTitle: TDNMPanel [5]
    Left = 190
    Top = 6
    Width = 238
    Height = 45
    HelpContext = 714052
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
      Width = 234
      Height = 41
      HelpContext = 714053
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
        Height = 41
        HelpContext = 714054
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Contact'
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
  object TABCTL20: TPageControl [6]
    Left = 0
    Top = 57
    Width = 607
    Height = 507
    ActivePage = tsMain
    TabHeight = 23
    TabOrder = 1
    TabWidth = 100
    OnDrawTab = TABCTL20DrawTab
    HelpContext = 714058
    object tsMain: TTabSheet
      Caption = 'Details'
      HelpContext = 714059
      object MainPanel: TDNMPanel
        Left = 0
        Top = 0
        Width = 599
        Height = 474
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          599
          474)
        HelpContext = 714060
        object Bevel2: TBevel
          Left = 24
          Top = 400
          Width = 568
          Height = 41
          HelpContext = 714001
        end
        object Box69: TBevel
          Left = 18
          Top = 12
          Width = 288
          Height = 164
          HelpContext = 714002
        end
        object Box70: TBevel
          Left = 312
          Top = 13
          Width = 275
          Height = 164
          HelpContext = 714003
        end
        object Box72: TBevel
          Left = 312
          Top = 182
          Width = 275
          Height = 212
          HelpContext = 714004
        end
        object Box83: TBevel
          Left = 18
          Top = 182
          Width = 288
          Height = 212
          HelpContext = 714005
        end
        object Label27: TLabel
          Left = 51
          Top = 42
          Width = 60
          Height = 18
          HelpContext = 714006
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Mr./Mrs/...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label28: TLabel
          Left = 42
          Top = 68
          Width = 69
          Height = 18
          HelpContext = 714007
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'First Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label29: TLabel
          Left = 45
          Top = 94
          Width = 66
          Height = 18
          HelpContext = 714008
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Last Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label31: TLabel
          Left = 341
          Top = 15
          Width = 41
          Height = 18
          HelpContext = 714009
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Phone Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label33: TLabel
          Left = 357
          Top = 69
          Width = 25
          Height = 18
          HelpContext = 714010
          Alignment = taRightJustify
          AutoSize = False
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
        object Label34: TLabel
          Left = 340
          Top = 42
          Width = 42
          Height = 18
          HelpContext = 714011
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Mobile'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label35: TLabel
          Left = 323
          Top = 96
          Width = 59
          Height = 18
          HelpContext = 714012
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Alt Phone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label59: TLabel
          Left = 323
          Top = 194
          Width = 58
          Height = 15
          HelpContext = 714013
          AutoSize = False
          Caption = 'Notes:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label78: TLabel
          Left = 49
          Top = 196
          Width = 56
          Height = 18
          HelpContext = 714014
          Alignment = taRightJustify
          AutoSize = False
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
        object Label77: TLabel
          Left = 344
          Top = 124
          Width = 41
          Height = 16
          HelpContext = 714015
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Email: '
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
          Left = 35
          Top = 224
          Width = 70
          Height = 18
          HelpContext = 714016
          Alignment = taRightJustify
          AutoSize = False
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
        object Label2: TLabel
          Left = 30
          Top = 16
          Width = 86
          Height = 18
          HelpContext = 714017
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Contact Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object lblSuburb: TLabel
          Left = 76
          Top = 281
          Width = 29
          Height = 18
          HelpContext = 714018
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'City:'
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
          Left = 43
          Top = 337
          Width = 62
          Height = 18
          HelpContext = 714019
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Postcode'
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
          Left = 67
          Top = 309
          Width = 38
          Height = 18
          HelpContext = 714020
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'State:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label3: TLabel
          Left = 80
          Top = 147
          Width = 29
          Height = 15
          HelpContext = 714021
          Caption = 'Type:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblCustType: TLabel
          Left = 121
          Top = 147
          Width = 65
          Height = 15
          HelpContext = 714022
          Caption = 'lblCustType'
          Transparent = True
        end
        object Label4: TLabel
          Left = 27
          Top = 415
          Width = 48
          Height = 15
          HelpContext = 714023
          Caption = 'Card No:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label5: TLabel
          Left = 319
          Top = 364
          Width = 65
          Height = 15
          HelpContext = 714024
          Caption = 'Account No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label6: TLabel
          Left = 44
          Top = 120
          Width = 66
          Height = 18
          HelpContext = 714025
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Job Title:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label7: TLabel
          Left = 35
          Top = 252
          Width = 70
          Height = 18
          HelpContext = 714026
          Alignment = taRightJustify
          AutoSize = False
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
        object lblCountry: TLabel
          Left = 43
          Top = 366
          Width = 62
          Height = 18
          HelpContext = 714027
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Country'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object ContactFax: TwwDBEdit
          Left = 386
          Top = 66
          Width = 157
          Height = 23
          HelpContext = 714030
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactFax'
          DataSource = dsContacts
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
        object ContactMOB: TwwDBEdit
          Left = 386
          Top = 39
          Width = 157
          Height = 23
          HelpContext = 714031
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactMOB'
          DataSource = dsContacts
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
        end
        object txtContactAltPH: TwwDBEdit
          Left = 386
          Top = 93
          Width = 157
          Height = 23
          HelpContext = 714032
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactAltPH'
          DataSource = dsContacts
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
        end
        object txtNotes: TDBMemo
          Left = 323
          Top = 211
          Width = 247
          Height = 137
          HelpContext = 714033
          DataField = 'Notes'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object txtContactAddress: TDBEdit
          Left = 115
          Top = 194
          Width = 184
          Height = 23
          HelpContext = 714034
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactAddress'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object txtContactEmail: TDBEdit
          Left = 386
          Top = 121
          Width = 199
          Height = 23
          HelpContext = 714035
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactEmail'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object txtContactAddress2: TDBEdit
          Left = 115
          Top = 222
          Width = 184
          Height = 23
          HelpContext = 714036
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactAddress2'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object txtCompany: TDBEdit
          Left = 121
          Top = 13
          Width = 185
          Height = 23
          HelpContext = 714037
          AutoSelect = False
          AutoSize = False
          DataField = 'Company'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          OnExit = txtCompanyExit
        end
        object Postcode: TDBEdit
          Left = 115
          Top = 335
          Width = 89
          Height = 23
          HelpContext = 714041
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactPcode'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object Suburb: TwwDBLookupCombo
          Left = 115
          Top = 279
          Width = 185
          Height = 23
          HelpContext = 714042
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'City_sub'#9'20'#9'Suburb'#9'T'
            'State'#9'4'#9'State'#9'T'#9
            'Postcode'#9'4'#9'Postcode'#9'T'#9)
          DataField = 'ContactCity'
          DataSource = dsContacts
          LookupTable = qrySuburb
          LookupField = 'City_sub'
          ParentFont = False
          TabOrder = 13
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = SuburbCloseUp
        end
        object State: TDBEdit
          Left = 115
          Top = 307
          Width = 89
          Height = 23
          HelpContext = 714043
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactState'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object chkActive: TwwCheckBox
          Left = 539
          Top = 457
          Width = 57
          Height = 17
          HelpContext = 714044
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
          NullAndBlankState = cbChecked
          Caption = 'Active'
          Checked = True
          Color = clBtnFace
          DataField = 'Active'
          DataSource = dsContacts
          ParentColor = False
          State = cbChecked
          TabOrder = 15
        end
        object edtCardNum: TwwDBEdit
          Left = 80
          Top = 412
          Width = 500
          Height = 23
          HelpContext = 714045
          DataField = 'CardNumber'
          DataSource = dsContacts
          TabOrder = 16
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwDBEdit1: TwwDBEdit
          Left = 393
          Top = 360
          Width = 177
          Height = 23
          HelpContext = 714046
          DataField = 'AccountNo'
          DataSource = dsContacts
          TabOrder = 17
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object JobTitle: TDBEdit
          Left = 121
          Top = 120
          Width = 185
          Height = 23
          HelpContext = 714047
          AutoSelect = False
          AutoSize = False
          DataField = 'JobTitle'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
        end
        object txtContactAddress3: TDBEdit
          Left = 115
          Top = 250
          Width = 184
          Height = 23
          HelpContext = 714048
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactAddress3'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
        end
        object edtCountry: TwwDBEdit
          Left = 115
          Top = 364
          Width = 184
          Height = 23
          HelpContext = 714049
          DataField = 'ContactCountry'
          DataSource = dsContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 20
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwCheckBox1: TwwCheckBox
          Left = 386
          Top = 150
          Width = 133
          Height = 17
          HelpContext = 714050
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
          NullAndBlankState = cbChecked
          Caption = 'Is Primary Contact?'
          Checked = True
          Color = clBtnFace
          DataField = 'IsPrimarycontact'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          State = cbChecked
          TabOrder = 21
        end
        object txtContactFirstName: TDBEdit
          Left = 121
          Top = 66
          Width = 185
          Height = 23
          HelpContext = 714055
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactFirstName'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnExit = txtContactFirstNameExit
        end
        object txtContactTitle: TDBEdit
          Left = 121
          Top = 39
          Width = 185
          Height = 23
          HelpContext = 714056
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactTitle'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object txtContactSurName: TDBEdit
          Left = 121
          Top = 93
          Width = 185
          Height = 23
          HelpContext = 714057
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactSurName'
          DataSource = dsContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnExit = txtContactFirstNameExit
        end
        object ContactPh: TwwDBEdit
          Left = 386
          Top = 12
          Width = 157
          Height = 23
          HelpContext = 714029
          AutoSelect = False
          AutoSize = False
          DataField = 'ContactPH'
          DataSource = dsContacts
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
        object chkDoNotContact: TwwCheckBox
          Left = 22
          Top = 457
          Width = 107
          Height = 17
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
          NullAndBlankState = cbChecked
          Anchors = [akTop, akRight]
          Caption = 'Do Not Contact'
          Checked = True
          Color = clBtnFace
          DataField = 'DoNotContact'
          DataSource = dsContacts
          ParentColor = False
          State = cbChecked
          TabOrder = 22
          HelpContext = 714061
        end
      end
    end
  end
  object cmdOk: TDNMSpeedButton [7]
    Left = 101
    Top = 570
    Width = 87
    Height = 27
    HelpContext = 714038
    Caption = '&Save'
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
    TabOrder = 2
  end
  object cmdNew: TDNMSpeedButton [8]
    Left = 212
    Top = 570
    Width = 87
    Height = 27
    HelpContext = 714039
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
    TabOrder = 3
  end
  object cmOriginal: TDNMSpeedButton [9]
    Left = 323
    Top = 570
    Width = 87
    Height = 27
    HelpContext = 714051
    Caption = 'Original'
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
  end
  object cmdClose: TDNMSpeedButton [10]
    Left = 435
    Top = 570
    Width = 87
    Height = 27
    HelpContext = 714040
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
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 5
  end
  inherited tmrProcessMessage: TTimer
    Left = 468
    Top = 56
  end
  inherited tmrdelay: TTimer
    Left = 528
    Top = 96
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Left = 403
    Top = 24
    Bitmap = {
      494C0101020048006C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Top = 96
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 470
    Top = 104
  end
  inherited qryMemTrans: TERPQuery
    Left = 61
    Top = 32
  end
  object qryContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblContacts'
      'WHERE ContactID=:KeyID;')
    Left = 109
    Top = 5
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
  end
  object dsContacts: TDataSource
    DataSet = qryContacts
    Left = 158
    Top = 14
  end
  object qrySuburb: TERPQuery
    SQL.Strings = (
      'SELECT LocationID, City_sub, State, Postcode, Country'
      'FROM tblLocations '
      'Where RegionID= :xRegionID'
      'Order By City_sub;')
    Options.LongStrings = False
    Left = 529
    Top = 49
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
end
