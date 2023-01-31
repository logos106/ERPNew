inherited frmPayrollCompanyInfo: TfrmPayrollCompanyInfo
  Left = 325
  Top = 188
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biMinimize]
  Caption = 'Company Payroll Information'
  ClientHeight = 470
  ClientWidth = 671
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel1: TBevel [0]
    Left = 160
    Top = 8
    Width = 313
    Height = 49
    Style = bsRaised
  end
  object Info: TLabel [1]
    Left = 172
    Top = 8
    Width = 291
    Height = 50
    Alignment = taCenter
    AutoSize = False
    Caption = 'Company'#13#10'Payroll Information'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 14221420
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object CompanyName_Label: TLabel [2]
    Left = 139
    Top = 63
    Width = 94
    Height = 18
    AutoSize = False
    Caption = 'Company Name'
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
  object cmdClose: TDNMSpeedButton [4]
    Left = 189
    Top = 430
    Width = 93
    Height = 29
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
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    OnClick = cmdCloseClick
  end
  object cmdCancel: TDNMSpeedButton [5]
    Left = 388
    Top = 430
    Width = 93
    Height = 29
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
    TabOrder = 3
    OnClick = cmdCancelClick
  end
  object PageControl1: TPageControl [6]
    Left = 15
    Top = 92
    Width = 640
    Height = 320
    ActivePage = TabSheet2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabHeight = 25
    TabIndex = 0
    TabOrder = 1
    TabWidth = 212
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
    object TabSheet2: TTabSheet
      Caption = '&Banking'
      ImageIndex = 1
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 632
        Height = 285
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel2: TBevel
          Left = 106
          Top = 29
          Width = 405
          Height = 219
        end
        object Label1: TLabel
          Left = 145
          Top = 88
          Width = 61
          Height = 15
          Caption = 'Bank Code'
          Transparent = True
        end
        object Label2: TLabel
          Left = 145
          Top = 117
          Width = 73
          Height = 15
          Caption = 'Bank Branch'
          Transparent = True
        end
        object Label3: TLabel
          Left = 145
          Top = 147
          Width = 45
          Height = 15
          Caption = 'BSB No.'
          Transparent = True
        end
        object Label4: TLabel
          Left = 145
          Top = 176
          Width = 68
          Height = 15
          Caption = 'Account No.'
          Transparent = True
        end
        object Label5: TLabel
          Left = 145
          Top = 206
          Width = 53
          Height = 15
          Caption = 'APCA No.'
          Transparent = True
        end
        object Label15: TLabel
          Left = 145
          Top = 59
          Width = 79
          Height = 15
          Caption = 'Bank Account'
          Transparent = True
        end
        object BankBranch: TDBEdit
          Left = 247
          Top = 112
          Width = 234
          Height = 23
          DataField = 'BankBranch'
          DataSource = frmCompanyInformationSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object BSB: TDBEdit
          Left = 247
          Top = 142
          Width = 121
          Height = 23
          DataField = 'BSB'
          DataSource = frmCompanyInformationSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object Account: TDBEdit
          Left = 247
          Top = 171
          Width = 121
          Height = 23
          DataField = 'AccountNo'
          DataSource = frmCompanyInformationSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object APCA: TDBEdit
          Left = 247
          Top = 201
          Width = 121
          Height = 23
          DataField = 'APCANo'
          DataSource = frmCompanyInformationSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object DBLookupComboBox1: TDBLookupComboBox
          Left = 247
          Top = 83
          Width = 121
          Height = 23
          DataField = 'BankCode'
          DataSource = frmCompanyInformationSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'CodeID'
          ListField = 'BankCode'
          ListSource = DataSource3
          ParentFont = False
          TabOrder = 2
        end
        object btnClear: TDNMSpeedButton
          Left = 371
          Top = 54
          Width = 56
          Height = 23
          Caption = 'C&lear'
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
          TabStop = False
          OnClick = btnClearClick
        end
        object cboBankAccounts: TwwDBLookupCombo
          Left = 247
          Top = 54
          Width = 121
          Height = 23
          DropDownAlignment = taLeftJustify
          LookupTable = qryBankAccounts
          LookupField = 'AccountName'
          Style = csDropDownList
          TabOrder = 0
          AutoDropDown = False
          ShowButton = True
          AllowClearKey = True
          OnCloseUp = cboBankAccountsCloseUp
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = '&Workers Compensation'
      ImageIndex = 2
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 632
        Height = 285
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel3: TBevel
          Left = 104
          Top = 5
          Width = 436
          Height = 276
        end
        object Label6: TLabel
          Left = 132
          Top = 17
          Width = 53
          Height = 15
          Caption = 'Company'
          Transparent = True
        end
        object Label7: TLabel
          Left = 132
          Top = 43
          Width = 58
          Height = 15
          Caption = 'Address 1'
          Transparent = True
        end
        object Label8: TLabel
          Left = 132
          Top = 69
          Width = 58
          Height = 15
          Caption = 'Address 2'
          Transparent = True
        end
        object Label9: TLabel
          Left = 132
          Top = 122
          Width = 41
          Height = 15
          Caption = 'Suburb'
          Transparent = True
        end
        object Label10: TLabel
          Left = 132
          Top = 149
          Width = 30
          Height = 15
          Caption = 'State'
          Transparent = True
        end
        object Label11: TLabel
          Left = 132
          Top = 175
          Width = 54
          Height = 15
          Caption = 'Postcode'
          Transparent = True
        end
        object Label12: TLabel
          Left = 132
          Top = 228
          Width = 84
          Height = 15
          Caption = 'Phone Number'
          Transparent = True
        end
        object Label13: TLabel
          Left = 132
          Top = 255
          Width = 68
          Height = 15
          Caption = 'Fax Number'
          Transparent = True
        end
        object lblAddress3: TLabel
          Left = 132
          Top = 96
          Width = 58
          Height = 15
          Caption = 'Address 3'
          Transparent = True
        end
        object lblCountry: TLabel
          Left = 132
          Top = 202
          Width = 44
          Height = 15
          Caption = 'Country'
          Transparent = True
        end
        object DBLookupComboBox2: TDBLookupComboBox
          Left = 252
          Top = 13
          Width = 261
          Height = 23
          DataField = 'WorkersCompInsurer'
          DataSource = frmCompanyInformationSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'ClientID'
          ListField = 'Company'
          ListSource = DataSource4
          ParentFont = False
          TabOrder = 0
        end
        object DBEdit4: TDBEdit
          Left = 252
          Top = 39
          Width = 261
          Height = 23
          DataField = 'Street'
          DataSource = DataSource4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object DBEdit5: TDBEdit
          Left = 252
          Top = 65
          Width = 261
          Height = 23
          DataField = 'Street2'
          DataSource = DataSource4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object DBEdit6: TDBEdit
          Left = 252
          Top = 118
          Width = 261
          Height = 23
          DataField = 'Suburb'
          DataSource = DataSource4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object DBEdit7: TDBEdit
          Left = 252
          Top = 145
          Width = 58
          Height = 23
          DataField = 'State'
          DataSource = DataSource4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object DBEdit8: TDBEdit
          Left = 252
          Top = 171
          Width = 58
          Height = 23
          DataField = 'Postcode'
          DataSource = DataSource4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object DBEdit9: TDBEdit
          Left = 252
          Top = 224
          Width = 131
          Height = 23
          DataField = 'Phone'
          DataSource = DataSource4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object DBEdit10: TDBEdit
          Left = 252
          Top = 251
          Width = 131
          Height = 23
          DataField = 'FaxNumber'
          DataSource = DataSource4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object txtAddress3: TDBEdit
          Left = 252
          Top = 92
          Width = 261
          Height = 23
          DataField = 'Street3'
          DataSource = DataSource4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object txtCountry: TDBEdit
          Left = 252
          Top = 198
          Width = 261
          Height = 23
          DataField = 'Country'
          DataSource = DataSource4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = '&Superannuation'
      ImageIndex = 3
      object DNMPanel4: TDNMPanel
        Left = 0
        Top = 0
        Width = 632
        Height = 285
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label14: TLabel
          Left = 138
          Top = 11
          Width = 337
          Height = 15
          Caption = 'Place here all the Superannuation Payer Member Accounts.'
          Transparent = True
        end
        object wwDBEdit1: TwwDBEdit
          Left = 419
          Top = 181
          Width = 102
          Height = 21
          BorderStyle = bsNone
          DataField = 'AccountNo'
          DataSource = DataSource5
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object wwDBGrid1: TwwDBGrid
          Left = 84
          Top = 40
          Width = 454
          Height = 217
          ControlType.Strings = (
            'ClientID;CustomEdit;CboSuperCompany;T'
            'AccountNo;CustomEdit;wwDBEdit1;T'
            'SuperName;CustomEdit;cboClient;F')
          Selected.Strings = (
            'SuperName'#9'39'#9'Company'#9'F'
            'AccountNo'#9'18'#9'Account No'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = 15785701
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = DataSource5
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgProportionalColResize]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = True
          UseTFields = False
          object btnDelete: TwwIButton
            Left = 0
            Top = 0
            Width = 24
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
            OnClick = btnDeleteClick
          end
        end
        object cboClient: TwwDBLookupCombo
          Left = 165
          Top = 260
          Width = 278
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Company'#9'50'#9'Company'#9'F')
          DataField = 'SuperCompany'
          DataSource = DataSource5
          LookupTable = qryClients
          LookupField = 'Company'
          TabOrder = 1
          AutoDropDown = False
          ShowButton = True
          AllowClearKey = False
          OnCloseUp = cboClientCloseUp
        end
      end
    end
  end
  object txtCompanyName: TwwDBLookupCombo [7]
    Left = 235
    Top = 61
    Width = 254
    Height = 23
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'CompanyName'#9'80'#9'CompanyName'#9'F')
    DataField = 'SetupID'
    DataSource = frmCompanyInformationSrc
    LookupTable = qryCompanyName
    LookupField = 'SetupID'
    TabOrder = 0
    Visible = False
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object EditedFlag: TDBCheckBox [8]
    Left = 0
    Top = 0
    Width = 17
    Height = 16
    DataField = 'EditedFlag'
    TabOrder = 4
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    Visible = False
  end
  object frmCompanyInformationSrc: TDataSource
    DataSet = CompanyInfo
    Left = 29
    Top = 12
  end
  object CompanyInfo: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblCompanyInformation'
      'WHERE SetupID=:KeyID;')
    Left = 1
    Top = 12
    ParamData = <
      item
        DataType = ftInteger
        Name = 'KeyID'
        Size = 25165824
        Value = 0
      end>
    object CompanyInfoSetupID: TAutoIncField
      FieldName = 'SetupID'
      ReadOnly = True
    end
    object CompanyInfoCompanyName: TStringField
      FieldName = 'CompanyName'
      Size = 200
    end
    object CompanyInfoTradingName: TStringField
      FieldName = 'TradingName'
      Size = 200
    end
    object CompanyInfoAddress: TStringField
      FieldName = 'Address'
      Size = 38
    end
    object CompanyInfoAddress2: TStringField
      FieldName = 'Address2'
      Size = 38
    end
    object CompanyInfoCity: TStringField
      FieldName = 'City'
      Size = 27
    end
    object CompanyInfoState: TStringField
      FieldName = 'State'
      FixedChar = True
      Size = 3
    end
    object CompanyInfoPostcode: TStringField
      FieldName = 'Postcode'
      Size = 4
    end
    object CompanyInfoCountry: TStringField
      FieldName = 'Country'
    end
    object CompanyInfoContactName: TStringField
      FieldName = 'ContactName'
      Size = 38
    end
    object CompanyInfoContactEmail: TStringField
      FieldName = 'ContactEmail'
      Size = 76
    end
    object CompanyInfoPhoneNumber: TStringField
      FieldName = 'PhoneNumber'
      EditMask = '!\(99\)0000-0000;1;_'
      Size = 15
    end
    object CompanyInfoFaxNumber: TStringField
      FieldName = 'FaxNumber'
      EditMask = '!\(99\)0000-0000;1;_'
      Size = 15
    end
    object CompanyInfoABN: TStringField
      DisplayWidth = 11
      FieldName = 'ABN'
      EditMask = '00\ 000\ 000\ 000;0;_'
      Size = 11
    end
    object CompanyInfoEditedFlag: TStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object CompanyInfoPOBox: TStringField
      FieldName = 'POBox'
      Size = 38
    end
    object CompanyInfoPOBox2: TStringField
      FieldName = 'POBox2'
      Size = 38
    end
    object CompanyInfoPOCity: TStringField
      FieldName = 'POCity'
      Size = 27
    end
    object CompanyInfoPOState: TStringField
      FieldName = 'POState'
      FixedChar = True
      Size = 3
    end
    object CompanyInfoPOPostcode: TStringField
      FieldName = 'POPostcode'
      Size = 4
    end
    object CompanyInfoPOCountry: TStringField
      FieldName = 'POCountry'
    end
    object CompanyInfoETPPayerType: TStringField
      FieldName = 'ETPPayerType'
      FixedChar = True
      Size = 1
    end
    object CompanyInfoFileReference: TStringField
      FieldName = 'FileReference'
      Size = 16
    end
    object CompanyInfoTaxSignatory: TStringField
      FieldName = 'TaxSignatory'
      Size = 38
    end
    object CompanyInfoLeaveLoadingPercent: TFloatField
      FieldName = 'LeaveLoadingPercent'
    end
    object CompanyInfoCompulsorySuperPercent: TFloatField
      FieldName = 'CompulsorySuperPercent'
    end
    object CompanyInfoBSB: TStringField
      FieldName = 'BSB'
      Size = 10
    end
    object CompanyInfoAccountNo: TStringField
      FieldName = 'AccountNo'
      Size = 50
    end
    object CompanyInfoFontCompanyName: TStringField
      FieldName = 'FontCompanyName'
      Size = 50
    end
    object CompanyInfoFontAddress: TStringField
      FieldName = 'FontAddress'
      Size = 50
    end
    object CompanyInfoFontSuburb: TStringField
      FieldName = 'FontSuburb'
      Size = 50
    end
    object CompanyInfoFontPhone: TStringField
      FieldName = 'FontPhone'
      Size = 50
    end
    object CompanyInfoFontABN: TStringField
      FieldName = 'FontABN'
      Size = 50
    end
    object CompanyInfoFontDefault: TStringField
      FieldName = 'FontDefault'
      Size = 50
    end
    object CompanyInfoSizeCompanyName: TIntegerField
      FieldName = 'SizeCompanyName'
    end
    object CompanyInfoSizeAddress: TIntegerField
      FieldName = 'SizeAddress'
    end
    object CompanyInfoSizeSuburb: TIntegerField
      FieldName = 'SizeSuburb'
    end
    object CompanyInfoSizePhone: TIntegerField
      FieldName = 'SizePhone'
    end
    object CompanyInfoSizeABN: TIntegerField
      FieldName = 'SizeABN'
    end
    object CompanyInfoSizeDefault: TIntegerField
      FieldName = 'SizeDefault'
    end
    object CompanyInfoColorCompanyName: TStringField
      FieldName = 'ColorCompanyName'
      Size = 50
    end
    object CompanyInfoColorAddress: TStringField
      FieldName = 'ColorAddress'
      Size = 50
    end
    object CompanyInfoColorSuburb: TStringField
      FieldName = 'ColorSuburb'
      Size = 50
    end
    object CompanyInfoColorPhone: TStringField
      FieldName = 'ColorPhone'
      Size = 50
    end
    object CompanyInfoColorABN: TStringField
      FieldName = 'ColorABN'
      Size = 50
    end
    object CompanyInfoColorDefault: TStringField
      FieldName = 'ColorDefault'
      Size = 50
    end
    object CompanyInfoStyleCompanyName: TStringField
      FieldName = 'StyleCompanyName'
      Size = 4
    end
    object CompanyInfoStyleAddress: TStringField
      FieldName = 'StyleAddress'
      Size = 4
    end
    object CompanyInfoStyleSuburb: TStringField
      FieldName = 'StyleSuburb'
      Size = 4
    end
    object CompanyInfoStylePhone: TStringField
      FieldName = 'StylePhone'
      Size = 4
    end
    object CompanyInfoStyleABN: TStringField
      FieldName = 'StyleABN'
      Size = 4
    end
    object CompanyInfoStyleDefault: TStringField
      FieldName = 'StyleDefault'
      Size = 4
    end
    object CompanyInfoBankCode: TIntegerField
      FieldName = 'BankCode'
    end
    object CompanyInfoBankBranch: TStringField
      FieldName = 'BankBranch'
      Size = 150
    end
    object CompanyInfoAPCANo: TStringField
      FieldName = 'APCANo'
      Size = 6
    end
    object CompanyInfoWorkersCompInsurer: TIntegerField
      FieldName = 'WorkersCompInsurer'
    end
  end
  object tblBankCodes: TMyTable
    TableName = 'tblbankcodes'
    Connection = MyConnection
    FetchAll = True
    Left = 4
    Top = 108
  end
  object DataSource3: TDataSource
    DataSet = tblBankCodes
    Left = 39
    Top = 109
  end
  object DataSource4: TDataSource
    DataSet = qryClients
    Left = 41
    Top = 145
  end
  object qryClients: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select ClientID, Company, Street, Street2, Street3, Suburb,State' +
        ',Postcode, Country,'
      'Phone,FaxNumber,AccountNo, ClientNo'
      'FROM tblClients'
      'WHERE Supplier='#39'T'#39';')
    Left = 4
    Top = 143
    object qryClientsClientID: TAutoIncField
      FieldName = 'ClientID'
      ReadOnly = True
    end
    object qryClientsCompany: TStringField
      FieldName = 'Company'
      Size = 80
    end
    object qryClientsStreet: TStringField
      FieldName = 'Street'
      Size = 38
    end
    object qryClientsStreet2: TStringField
      FieldName = 'Street2'
      Size = 38
    end
    object qryClientsStreet3: TStringField
      FieldName = 'Street3'
      Size = 255
    end
    object qryClientsSuburb: TStringField
      FieldName = 'Suburb'
      Size = 27
    end
    object qryClientsState: TStringField
      FieldName = 'State'
      FixedChar = True
      Size = 3
    end
    object qryClientsPostcode: TStringField
      FieldName = 'Postcode'
      Size = 4
    end
    object qryClientsPhone: TStringField
      FieldName = 'Phone'
      EditMask = '## #### ####;0;_'
    end
    object qryClientsFaxNumber: TStringField
      FieldName = 'FaxNumber'
    end
    object qryClientsAccountNo: TStringField
      FieldName = 'AccountNo'
      Size = 50
    end
    object qryClientsClientNo: TStringField
      FieldName = 'ClientNo'
      Size = 50
    end
    object qryClientsCountry: TStringField
      FieldName = 'Country'
      Size = 255
    end
  end
  object qrySuper: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select ID, ClientID, SuperName, AccountNo, GlobalRef'
      'FROM tblpayersuperaccounts')
    Left = 7
    Top = 177
    object qrySuperID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object qrySuperClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object qrySuperSuperName: TStringField
      FieldName = 'SuperName'
      Size = 255
    end
    object qrySuperAccountNo: TStringField
      DisplayLabel = 'Account No'
      DisplayWidth = 19
      FieldName = 'AccountNo'
      Size = 50
    end
    object qrySuperGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
  end
  object DataSource5: TDataSource
    DataSet = qrySuper
    Left = 40
    Top = 177
  end
  object cboCompany: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select SetupID,CompanyName '
      'FROM tblCompanyInformation'
      '')
    Left = 3
    Top = 222
  end
  object DScboCompany: TDataSource
    DataSet = cboCompany
    Left = 35
    Top = 225
  end
  object qryCompanyName: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select SetupID, CompanyName'
      'FROM tblCompanyInformation')
    Left = 28
    Top = 41
  end
  object qryBankAccounts: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT AccountID, AccountName, BankCode, BSB, BankAccountNumber,' +
        '  APCANo'
      'FROM tblchartofaccounts'
      'WHERE AccountType = '#39'BANK'#39)
    Left = 6
    Top = 75
  end
  object dsBankAccounts: TDataSource
    DataSet = qryBankAccounts
    Left = 38
    Top = 76
  end
end
